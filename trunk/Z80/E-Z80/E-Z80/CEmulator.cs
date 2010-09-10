using System;
using System.Collections.Generic;
using System.Text;

namespace EZ80
{
    class CEmulator
    {
        #region member variables

        private byte[] m_Ram = new byte[65536];
        private CRegisters m_Reg = new CRegisters();

        #endregion

        #region public methods

        public void Step()
        {
            byte cmd = m_Ram[m_Reg.IP];

            // LD r,r' / LD r,(HL)
            if ((cmd & 0xC0) == 0x40)
            {
                byte r1 = (byte) ((cmd & 0x38) >> 3);
                byte r2 = (byte) (cmd & 0x07);

                // LD r,(HL)
                if (r2 == 0x07)
                    m_Reg.SetReg(r1, m_Ram[m_Reg.HL]);

                // LD (HL),r
                else if (r1 == 0x07)
                    m_Ram[m_Reg.HL] = m_Reg.GetReg(r2);

                else
                {
                    // LD r,r'
                    m_Reg.SetReg(r1, m_Reg.GetReg(r2));
                }
                m_Reg.IP++;
            }

            // LD r,n
            else if ((cmd & 0xC0) == 0 && (cmd & 0x07) == 0x06)
            {

                byte r = (byte)((cmd & 0x38) >> 3);
                m_Reg.SetReg(r, m_Ram[m_Reg.IP + 1]);
                m_Reg.IP += 2;
            }

            // LD dd,nn
            else if ((cmd & 0xCF) == 0x01)
            {
                byte dd = (byte)((cmd & 0x30) >> 4);
                ushort value = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                m_Reg.SetPair(dd, value);
                m_Reg.IP += 3;
            }

            // ADD A,r
            else if ((cmd & 0xF8) == 0x80)
            {
                Add8Bit(m_Reg.GetReg((byte)(cmd & 0x07)));
                m_Reg.IP++;
            }

            // ADC A,r
            else if ((cmd & 0xF8) == 0x88)
            {
                Add8Bit((byte)(m_Reg.GetReg((byte)(cmd & 0x07)) + (m_Reg.CF ? 1 : 0)));
                m_Reg.IP++;
            }

            // SUB A,r
            else if ((cmd & 0xF8) == 0x90)
            {
                Sub8Bit(m_Reg.GetReg((byte)(cmd & 0x07)));
                m_Reg.IP++;
            }

            // SBC A,r
            else if ((cmd & 0xF8) == 0x98)
            {
                Sub8Bit((byte)(m_Reg.GetReg((byte)(cmd & 0x07)) + (m_Reg.CF ? 1 : 0)));
                m_Reg.IP++;
            }

            // AND A,r
            else if ((cmd & 0xF8) == 0xA0)
            {
                And8Bit(m_Reg.GetReg((byte)(cmd & 0x07)));
                m_Reg.IP++;
            }

            // OR A,r
            else if ((cmd & 0xF8) == 0xB0)
            {
                Or8Bit(m_Reg.GetReg((byte)(cmd & 0x07)));
                m_Reg.IP++;
            }

            // XOR A,r
            else if ((cmd & 0xF8) == 0xA8)
            {
                Xor8Bit(m_Reg.GetReg((byte)(cmd & 0x07)));
                m_Reg.IP++;
            }

            else
            {
                byte cmd1 = m_Ram[m_Reg.IP + 1];

                switch (cmd)
                {
                    // IX
                    case 0xDD:

                        // LD r,(IX+d)
                        if ((cmd1 & 0xC7) == 0x46)
                        {
                            byte r = (byte)((cmd & 0x38) >> 3);
                            m_Reg.SetReg(r, m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);

                            m_Reg.IP += 3;
                        }

                        // LD (IX+d),r
                        else if ((cmd1 & 0xF8) == 0x70)
                        {
                            byte r = (byte)(cmd & 0x07);
                            m_Ram[m_Reg.IX + m_Ram[m_Reg.IP + 2]] = m_Reg.GetReg(r);

                            m_Reg.IP += 3;
                        }

                        else
                        {
                            switch (cmd1)
                            {
                                // LD (IX+d),n
                                case 0x36:
                                    m_Ram[m_Reg.IX + m_Ram[m_Reg.IP + 2]] = m_Ram[m_Reg.IP + 3];
                                    m_Reg.IP += 4;
                                    break;

                                // LD IX,nn
                                case 0x21:
                                    m_Reg.IX = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.IP += 4;
                                    break;

                                // LD IX,(nn)
                                case 0x2A:
                                    {
                                        ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                        m_Reg.IX = (ushort)(m_Ram[addr] + (m_Ram[(ushort)(addr + 1)] << 8));
                                    }
                                    m_Reg.IP += 4;
                                    break;

                                // LD (nn),IX
                                case 0x22:
                                    {
                                        ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                        m_Ram[addr] = (byte)m_Reg.IX;
                                        m_Ram[(ushort)(addr + 1)] = (byte)(m_Reg.IX >> 8);
                                    }
                                    m_Reg.IP += 4;
                                    break;

                                // LD SP,IX
                                case 0xF9:
                                    m_Reg.SP = m_Reg.IX;
                                    m_Reg.IP += 2;
                                    break;

                                // PUSH IX
                                case 0xE5:
                                    m_Reg.SP--;
                                    m_Ram[m_Reg.SP] = (byte)(m_Reg.IX >> 8);
                                    m_Reg.SP--;
                                    m_Ram[m_Reg.SP] = (byte)m_Reg.IX;
                                    m_Reg.IP += 2;
                                    break;

                                // POP IX
                                case 0xE1:
                                    m_Reg.IX = (ushort)(m_Ram[m_Reg.SP] + (m_Ram[(ushort)(m_Reg.SP + 1)] << 8));
                                    m_Reg.SP += 2;
                                    m_Reg.IP += 2;
                                    break;

                                // EX (SP),IX
                                case 0xE3:
                                    {
                                        ushort temp;

                                        temp = m_Reg.IX;
                                        m_Reg.IX = (ushort)(m_Ram[m_Reg.SP] + (m_Ram[(ushort)(m_Reg.SP + 1)] << 8));
                                        m_Ram[m_Reg.SP] = (byte)temp;
                                        m_Ram[(ushort)(m_Reg.SP + 1)] = (byte)(temp >> 8);
                                    }
                                    m_Reg.IP += 2;
                                    break;
                                
                                // ADD A,(IX+d)
                                case 0x86:
                                    Add8Bit(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // ADC A,(IX+d)
                                case 0x8E:
                                    Add8Bit((byte)(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])] + (m_Reg.CF ? 1 : 0)));
                                    m_Reg.IP += 3;
                                    break;

                                // SUB A,(IX+d)
                                case 0x96:
                                    Sub8Bit(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // SBC A,(IX+d)
                                case 0x9E:
                                    Sub8Bit((byte)(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])] + (m_Reg.CF ? 1 : 0)));
                                    m_Reg.IP += 3;
                                    break;

                                // AND A,(IX+d)
                                case 0xA6:
                                    And8Bit(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // OR A,(IX+d)
                                case 0xB6:
                                    Or8Bit(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // XOR A,(IX+d)
                                case 0xAE:
                                    Xor8Bit(m_Ram[(ushort)(m_Reg.IX + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;
                            }
                        } // 0xDD
                        break;

                    // IY
                    case 0xFD:

                        // LD r,(IY+d)
                        if ((cmd1 & 0xC7) == 0x46)
                        {
                            byte r = (byte)((cmd & 0x38) >> 3);
                            m_Reg.SetReg(r, m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);

                            m_Reg.IP += 3;
                        }

                        // LD (IY+d),r
                        else if ((cmd1 & 0xF8) == 0x70)
                        {
                            byte r = (byte)(cmd & 0x07);
                            m_Ram[m_Reg.IY + m_Ram[m_Reg.IP + 2]] = m_Reg.GetReg(r);

                            m_Reg.IP += 3;
                        }
                        else
                        {
                            switch (cmd1)
                            {
                                // LD (IY+d),n
                                case 36:
                                    m_Ram[m_Reg.IY + m_Ram[m_Reg.IP + 2]] = m_Ram[m_Reg.IP + 3];
                                    m_Reg.IP += 4;
                                    break;

                                // LD IY,nn
                                case 0x21:
                                    m_Reg.IY = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.IP += 4;
                                    break;

                                // LD IY,(nn)
                                case 0x2A:
                                    {
                                        ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                        m_Reg.IY = (ushort)(m_Ram[addr] + (m_Ram[(ushort)(addr + 1)] << 8));
                                    }
                                    m_Reg.IP += 4;
                                    break;

                                // LD (nn),IY
                                case 0x22:
                                    {
                                        ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                        m_Ram[addr] = (byte)m_Reg.IY;
                                        m_Ram[(ushort)(addr + 1)] = (byte)(m_Reg.IY >> 8);
                                    }
                                    m_Reg.IP += 4;
                                    break;

                                // LD SP,IY
                                case 0xF9:
                                    m_Reg.SP = m_Reg.IY;
                                    m_Reg.IP += 2;
                                    break;

                                // PUSH IY
                                case 0xE5:
                                    m_Reg.SP--;
                                    m_Ram[m_Reg.SP] = (byte)(m_Reg.IY >> 8);
                                    m_Reg.SP--;
                                    m_Ram[m_Reg.SP] = (byte)m_Reg.IY;
                                    m_Reg.IP += 2;
                                    break;

                                // POP IY
                                case 0xE1:
                                    m_Reg.IY = (ushort)(m_Ram[m_Reg.SP] + (m_Ram[m_Reg.SP + 1] << 8));
                                    m_Reg.SP += 2;
                                    m_Reg.IP += 2;
                                    break;

                                // EX (SP),IY
                                case 0xE3:
                                    {
                                        ushort temp;

                                        temp = m_Reg.IY;
                                        m_Reg.IY = (ushort)(m_Ram[m_Reg.SP] + (m_Ram[m_Reg.SP + 1] << 8));
                                        m_Ram[m_Reg.SP] = (byte)temp;
                                        m_Ram[m_Reg.SP + 1] = (byte)(temp >> 8);
                                    }
                                    m_Reg.IP += 2;
                                    break;

                                // ADD A,(IY+d)
                                case 0x86:
                                    Add8Bit(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // ADC A,(IY+d)
                                case 0x8E:
                                    Add8Bit((byte)(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])] + (m_Reg.CF ? 1 : 0)));
                                    m_Reg.IP += 3;
                                    break;

                                // SUB A,(IY+d)
                                case 0x96:
                                    Sub8Bit(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // SBC A,(IY+d)
                                case 0x9E:
                                    Sub8Bit((byte)(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])] + (m_Reg.CF ? 1 : 0)));
                                    m_Reg.IP += 3;
                                    break;

                                // AND A,(IY+d)
                                case 0xA6:
                                    And8Bit(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // OR A,(IY+d)
                                case 0xB6:
                                    Or8Bit(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;

                                // XOR A,(IY+d)
                                case 0xAE:
                                    Xor8Bit(m_Ram[(ushort)(m_Reg.IY + m_Ram[m_Reg.IP + 2])]);
                                    m_Reg.IP += 3;
                                    break;
                            }
                        } // 0xFD
                        break;

                    // LD (HL),n
                    case 0x36:
                        m_Ram[m_Reg.HL] = m_Ram[m_Reg.IP + 1];
                        m_Reg.IP += 2;
                        break;

                    // LD A,(BC)
                    case 0x0A:
                        m_Reg.A = m_Ram[m_Reg.BC];
                        m_Reg.IP += 1;
                        break;

                    // LD A,(DE)
                    case 0x1A:
                        m_Reg.A = m_Ram[m_Reg.DE];
                        m_Reg.IP += 1;
                        break;

                    // LD A,(nn)
                    case 0x3A:
                        {
                            ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                            m_Reg.A = m_Ram[addr];
                        }
                        m_Reg.IP += 3;
                        break;

                    // LD (BC),A
                    case 0x02:
                        m_Ram[m_Reg.BC] = m_Reg.A;
                        m_Reg.IP++;
                        break;

                    // LD (DE),A
                    case 0x12:
                        m_Ram[m_Reg.DE] = m_Reg.A;
                        m_Reg.IP++;
                        break;

                    // LD (nn),A
                    case 0x32:
                        {
                            ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                            m_Ram[addr] = m_Reg.A;
                        }
                        m_Reg.IP += 3;
                        break;

                    case 0xED:
                        switch (cmd1)
                        {
                            // LD A,I
                            case 0x57:
                                m_Reg.SF = (m_Reg.I & 0x80) != 0;
                                m_Reg.ZF = m_Reg.I == 0;
                                m_Reg.HF = false;
                                m_Reg.PF = false; // Todo: P/V contains contents of IFF2
                                m_Reg.NF = false;

                                m_Reg.A = m_Reg.I;
                                m_Reg.IP += 2;
                                break;

                            // LD A,R
                            case 0x5F:
                                m_Reg.SF = (m_Reg.R & 0x80) != 0;
                                m_Reg.ZF = m_Reg.R == 0;
                                m_Reg.HF = false;
                                m_Reg.PF = false; // Todo: P/V contains contents of IFF2
                                m_Reg.NF = false;

                                m_Reg.A = m_Reg.R;
                                m_Reg.IP += 2;
                                break;

                            // LD I,A
                            case 0x47:
                                m_Reg.I = m_Reg.A;
                                m_Reg.IP += 2;
                                break;

                            // LD R,A
                            case 0x4F:
                                m_Reg.R = m_Reg.A;
                                m_Reg.IP += 2;
                                break;

                            // LD BC,(nn)
                            case 0x4B:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.C = m_Ram[addr];
                                    m_Reg.B = m_Ram[(ushort)(addr + 1)];
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD DE,(nn)
                            case 0x5B:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.E = m_Ram[addr];
                                    m_Reg.D = m_Ram[(ushort)(addr + 1)];
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD HL,(nn)
                            case 0x6B:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.L = m_Ram[addr];
                                    m_Reg.H = m_Ram[(ushort)(addr + 1)];
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD SP,(nn)
                            case 0x7B:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Reg.SP = (ushort)(m_Ram[addr] + (m_Ram[(ushort)(addr + 1)] << 8));
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD (nn),BC
                            case 0x43:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Ram[addr] = m_Reg.C;
                                    m_Ram[(ushort)(addr + 1)] = m_Reg.B;
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD (nn),DE
                            case 0x53:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Ram[addr] = m_Reg.E;
                                    m_Ram[(ushort)(addr + 1)] = m_Reg.D;
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD (nn),HL
                            case 0x63:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Ram[addr] = m_Reg.L;
                                    m_Ram[(ushort)(addr + 1)] = m_Reg.H;
                                }
                                m_Reg.IP += 3;
                                break;

                            // LD (nn),SP
                            case 0x73:
                                {
                                    ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                                    m_Ram[addr] = (byte)m_Reg.SP;
                                    m_Ram[(ushort)(addr + 1)] = (byte)(m_Reg.SP >> 8);
                                }
                                m_Reg.IP += 3;
                                break;

                            // LDI
                            case 0xA0:
                                m_Ram[m_Reg.DE++] = m_Ram[m_Reg.HL++];
                                m_Reg.BC--;
                                m_Reg.HF = false;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = false;
                                m_Reg.IP += 2;
                                break;

                            // LDIR
                            case 0xB0:
                                m_Ram[m_Reg.DE++] = m_Ram[m_Reg.HL++];
                                m_Reg.HF = false;
                                m_Reg.PF = false;
                                m_Reg.NF = false;
                                if (--m_Reg.BC == 0)
                                    m_Reg.IP += 2;
                                // Todo: Blockanweisung beachten!
                                break;

                            // LDD
                            case 0xA8:
                                m_Ram[m_Reg.DE--] = m_Ram[m_Reg.HL--];
                                m_Reg.BC--;
                                m_Reg.HF = false;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = false;
                                m_Reg.IP += 2;
                                break;

                            // LDDR
                            case 0xB8:
                                m_Ram[m_Reg.DE--] = m_Ram[m_Reg.HL--];
                                m_Reg.HF = false;
                                m_Reg.PF = false;
                                m_Reg.NF = false;
                                if (--m_Reg.BC == 0)
                                    m_Reg.IP += 2;
                                // Todo: Blockanweisung beachten!
                                break;

                            // CPI
                            case 0xA1:
                                m_Reg.ZF = m_Reg.A == m_Ram[m_Reg.HL++];
                                m_Reg.BC--;
                                m_Reg.SF = (m_Reg.A & 0x80) > 0;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = true;

                                // Todo: auf Korrektheit prüfen
                                // Todo: H is set if borrow from bit 4; reset otherwise
                                // Half carry (H), bit 4 - set if there was a carry out from bit 3 to bit 4 of the result.
                                m_Reg.IP += 2;
                                break;

                            // CPIR
                            case 0xB1:
                                m_Reg.ZF = m_Reg.A == m_Ram[m_Reg.HL++];
                                m_Reg.BC--;
                                m_Reg.SF = (m_Reg.A & 0x80) > 0;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = true;

                                // Todo: auf Korrektheit prüfen
                                // Todo: H is set if borrow from bit 4; reset otherwise
                                // Half carry (H), bit 4 - set if there was a carry out from bit 3 to bit 4 of the result.
                                if (m_Reg.ZF || !m_Reg.PF)
                                    m_Reg.IP += 2;
                                break;

                            // CPD
                            case 0xA9:
                                m_Reg.ZF = m_Reg.A == m_Ram[m_Reg.HL--];
                                m_Reg.BC--;
                                m_Reg.SF = (m_Reg.A & 0x80) > 0;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = true;

                                // Todo: auf Korrektheit prüfen
                                // Todo: H is set if borrow from bit 4; reset otherwise
                                // Half carry (H), bit 4 - set if there was a carry out from bit 3 to bit 4 of the result.
                                m_Reg.IP += 2;
                                break;

                            // CPDR
                            case 0xB9:
                                m_Reg.ZF = m_Reg.A == m_Ram[m_Reg.HL--];
                                m_Reg.BC--;
                                m_Reg.SF = (m_Reg.A & 0x80) > 0;
                                m_Reg.PF = m_Reg.BC != 0;
                                m_Reg.NF = true;

                                // Todo: auf Korrektheit prüfen
                                // Todo: H is set if borrow from bit 4; reset otherwise
                                // Half carry (H), bit 4 - set if there was a carry out from bit 3 to bit 4 of the result.
                                if (m_Reg.ZF || !m_Reg.PF)
                                    m_Reg.IP += 2;
                                break;

                        } // switch (cmd1)
                        break; // case 0xED

                    // LD HL,(nn)
                    case 0x2A:
                        {
                            ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                            m_Reg.L = m_Ram[addr];
                            m_Reg.H = m_Ram[(ushort)(addr + 1)];
                        }
                        m_Reg.IP += 3;
                        break;

                    // LD (nn),HL
                    case 0x22:
                        {
                            ushort addr = (ushort)(m_Ram[m_Reg.IP + 1] + (m_Ram[m_Reg.IP + 2] << 8));
                            m_Ram[addr] = m_Reg.L;
                            m_Ram[(ushort)(addr + 1)] = m_Reg.H;
                        }
                        m_Reg.IP += 3;
                        break;

                    // LD SP,HL
                    case 0xF9:
                        m_Reg.SP = m_Reg.HL;
                        m_Reg.IP++;
                        break;

                    // PUSH BC
                    case 0xC5:
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.B;
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.C;
                        m_Reg.IP++;
                        break;

                    // PUSH DE
                    case 0xD5:
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.D;
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.E;
                        m_Reg.IP++;
                        break;

                    // PUSH HL
                    case 0xE5:
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.H;
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.L;
                        m_Reg.IP++;
                        break;

                    // PUSH AF
                    case 0xF5:
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.A;
                        m_Reg.SP--;
                        m_Ram[m_Reg.SP] = m_Reg.F;
                        m_Reg.IP++;
                        break;

                    // POP BC
                    case 0xC1:
                        m_Reg.C = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.B = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.IP++;
                        break;

                    // POP DE
                    case 0xD1:
                        m_Reg.E = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.D = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.IP++;
                        break;

                    // POP HL
                    case 0xE1:
                        m_Reg.L = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.H = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.IP++;
                        break;

                    // POP AF
                    case 0xF1:
                        m_Reg.F = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.A = m_Ram[m_Reg.SP];
                        m_Reg.SP++;
                        m_Reg.IP++;
                        break;

                    // EX DE,HL
                    case 0xEB:
                        {
                            byte temp;

                            temp = m_Reg.D;
                            m_Reg.D = m_Reg.H;
                            m_Reg.H = temp;

                            temp = m_Reg.E;
                            m_Reg.E = m_Reg.L;
                            m_Reg.L = temp;
                        }
                        m_Reg.IP++;
                        break;

                    // EX AF,AF'
                    case 0x08:
                        {
                            byte temp;

                            temp = m_Reg.A;
                            m_Reg.A = m_Reg.A_;
                            m_Reg.A_ = temp;

                            temp = m_Reg.F;
                            m_Reg.F = m_Reg.F_;
                            m_Reg.F_ = temp;
                        }
                        m_Reg.IP++;
                        break;

                    // EXX
                    case 0xD9:
                        {
                            byte temp;

                            temp = m_Reg.B;
                            m_Reg.B = m_Reg.B_;
                            m_Reg.B_ = temp;

                            temp = m_Reg.C;
                            m_Reg.C = m_Reg.C_;
                            m_Reg.C_ = temp;

                            temp = m_Reg.D;
                            m_Reg.D = m_Reg.D_;
                            m_Reg.D_ = temp;

                            temp = m_Reg.E;
                            m_Reg.E = m_Reg.E_;
                            m_Reg.E_ = temp;

                            temp = m_Reg.H;
                            m_Reg.H = m_Reg.H_;
                            m_Reg.H_ = temp;

                            temp = m_Reg.L;
                            m_Reg.L = m_Reg.L_;
                            m_Reg.L_ = temp;
                        }
                        m_Reg.IP++;
                        break;

                    // EX (SP),HL
                    case 0xE3:
                        {
                            byte temp;

                            temp = m_Reg.L;
                            m_Reg.L = m_Ram[m_Reg.SP];
                            m_Ram[m_Reg.SP] = temp;

                            temp = m_Reg.H;
                            m_Reg.H = m_Ram[m_Reg.SP + 1];
                            m_Ram[m_Reg.SP + 1] = temp;
                        }
                        m_Reg.IP++;
                        break;

                    // ADD A,n
                    case 0xC6:
                        Add8Bit(m_Ram[m_Reg.IP + 1]);
                        m_Reg.IP += 2;
                        break;

                    // ADD A,(HL)
                    case 0x86:
                        Add8Bit(m_Ram[m_Reg.HL]);
                        m_Reg.IP++;
                        break;

                    // ADC A,n
                    case 0xCE:
                        Add8Bit((byte)(m_Ram[m_Reg.IP + 1] + (m_Reg.CF ? 1 : 0)));
                        m_Reg.IP += 2;
                        break;

                    // ADC A,(HL)
                    case 0x8E:
                        Add8Bit((byte)(m_Ram[m_Reg.HL] + (m_Reg.CF ? 1 : 0)));
                        m_Reg.IP++;
                        break;

                    // SUB A,n
                    case 0xD6:
                        Sub8Bit(m_Ram[m_Reg.IP + 1]);
                        m_Reg.IP += 2;
                        break;

                    // SUB A,(HL)
                    case 0x96:
                        Sub8Bit(m_Ram[m_Reg.HL]);
                        m_Reg.IP++;
                        break;

                    // SBC A,n
                    case 0xDE:
                        Sub8Bit((byte)(m_Ram[m_Reg.IP + 1] + (m_Reg.CF ? 1 : 0)));
                        m_Reg.IP += 2;
                        break;

                    // SBC A,(HL)
                    case 0x9E:
                        Sub8Bit((byte)(m_Ram[m_Reg.HL] + (m_Reg.CF ? 1 : 0)));
                        m_Reg.IP++;
                        break;

                    // AND A,n
                    case 0xE6:
                        And8Bit(m_Ram[m_Reg.IP + 1]);
                        m_Reg.IP += 2;
                        break;

                    // AND A,(HL)
                    case 0xA6:
                        And8Bit(m_Ram[m_Reg.HL]);
                        m_Reg.IP++;
                        break;

                    // OR A,n
                    case 0xF6:
                        Or8Bit(m_Ram[m_Reg.IP + 1]);
                        m_Reg.IP += 2;
                        break;

                    // OR A,(HL)
                    case 0xB6:
                        Or8Bit(m_Ram[m_Reg.HL]);
                        m_Reg.IP++;
                        break;

                    // XOR A,n
                    case 0xEE:
                        Xor8Bit(m_Ram[m_Reg.IP + 1]);
                        m_Reg.IP += 2;
                        break;

                    // XOR A,(HL)
                    case 0xAE:
                        Xor8Bit(m_Ram[m_Reg.HL]);
                        m_Reg.IP++;
                        break;


                } // switch (cmd)

            }

        }

        #endregion

        #region private methods

        private void Add8Bit(byte _value)
        {
            InternalAdd8Bit(_value, true);
        }

        private void InternalAdd8Bit(byte _value, bool _store)
        {
            ushort result = (ushort)(m_Reg.A + _value);
            m_Reg.SF = (result & 0x80) > 0;
            m_Reg.ZF = result == 0;
            m_Reg.HF = (m_Reg.A & 0x0f) + (_value & 0x0f) > 0x0f;
            m_Reg.NF = false;
            m_Reg.CF = result > 0xFF;
            m_Reg.PF = ((_value & 0x80) == (m_Reg.A & 0x80)) && ((result & 0x80) != (m_Reg.A & 0x80));
            if (_store)
                m_Reg.A = (byte)result;
        }

        private void Sub8Bit(byte _value)
        {
            InternalAdd8Bit((byte)(-_value), true);
        }

        private void Cmp8Bit(byte _value)
        {
            InternalAdd8Bit((byte)(-_value), false);
        }

        private void And8Bit(byte _value)
        {
            byte result = (byte)(m_Reg.A & _value);
            m_Reg.SF = (result & 0x80) > 0;
            m_Reg.ZF = result == 0;
            m_Reg.HF = true;
            m_Reg.NF = false;
            m_Reg.CF = false;
            m_Reg.PF = ((_value & 0x80) == (m_Reg.A & 0x80)) && ((result & 0x80) != (m_Reg.A & 0x80));
            m_Reg.A = result;
        }

        private void Or8Bit(byte _value)
        {
            byte result = (byte)(m_Reg.A | _value);
            m_Reg.SF = (result & 0x80) > 0;
            m_Reg.ZF = result == 0;
            m_Reg.HF = true;
            m_Reg.NF = false;
            m_Reg.CF = false;
            m_Reg.PF = ((_value & 0x80) == (m_Reg.A & 0x80)) && ((result & 0x80) != (m_Reg.A & 0x80));
            m_Reg.A = result;
        }

        private void Xor8Bit(byte _value)
        {
            byte result = (byte)(m_Reg.A | _value);
            m_Reg.SF = (result & 0x80) > 0;
            m_Reg.ZF = result == 0;
            m_Reg.HF = true;
            m_Reg.NF = false;
            m_Reg.CF = false;
            m_Reg.PF = Parity(result);
            m_Reg.A = result;
        }

        //private byte Neg8Bit(byte _value)
        //{
        //    return (byte)((~_value) + 1);
        //}

        //private ushort Neg16Bit(ushort _value)
        //{
        //    return (ushort)((~_value) + 1);
        //}

        private bool Parity(byte _value)
        {
            _value = (byte)(_value ^ (_value >> 4));
            _value = (byte)(_value ^ (_value >> 2));
            _value = (byte)(_value ^ (_value >> 1));
            return (_value & 1) > 0;
        }

        #endregion

    }
}
