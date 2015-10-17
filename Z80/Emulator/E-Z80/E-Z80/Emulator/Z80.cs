using System;

namespace E_Z80.Emulator
{
    /**
     * Z80 Class emulates a Z80's CPU behaviour
     * By Elfic One (2006)
     * Enhanced by S.Petry (2013)
     *
     *  V1.00	+ Port to CSharp based on version 1.50 of CPUZ80 written in 2001 by E.Duijs as a part of JEmu
     *  
     */

    public interface IMemoryProvider
    {
        int Peek(int addr);
        void Poke(int addr, int value);
    }

    public interface IPortProvider
    {
        int InB(int addr, int hi);
        void OutB(int addr, int value, int state);
    }

    public class Z80
    {
        //private StreamWriter FLogFile = new StreamWriter("cpulog.txt");

        public bool EnableLog { get; set; }

        public static int IM0 = 0;
        public static int IM1 = 1;
        public static int IM2 = 2;

        /** Interrupt type */
        public static int INTERRUPT_TYPE_IRQ = 0;
        /** Interrupt type */
        public static int INTERRUPT_TYPE_NMI = 1;
        /** Interrupt type */
        public static int INTERRUPT_TYPE_FIRQ = 2;
        /** Interrupt type */
        public static int INTERRUPT_TYPE_IGNORE = -1;
        /** Property type */
        public static int PROPERTY_Z80_IRQ_VECTOR = 0;

        public static bool DEBUG = false; //fixme

        // registers
        public int A, F, B, C, D, E, H, L, I, _R;
        public int A1, F1, B1, C1, D1, E1, H1, L1;
        public int PC;
        public int SP = 0x10000;
        public int IX, IY;
        public int IXYd = 0; 			// Ix+d or IY+d

        // states
        public bool state_HALT = false;
        //private bool state_INIT = false;

        // interrupt
        public int IM = 0; 	// interrupt mode
        public bool IFF0 = false; // IRQ interrupt flip-flop
        public bool IFF1 = false; // NMI interrupt flip-flop
        public int I_Vector = 0;
        public bool IRQ = false; // interrupt request
        public bool NMI = false; // Non-maskable interrupt
        //private bool goingToirq = false;// used to execute 1 more inst after an irq

        // Current cyc of execution
        public int Cycle = 0;
        public int CycleCounter;

        public IMemoryProvider MemProvider { get; set; }
        public IPortProvider PortProvider { get; set; }

        // Currently executed inst
        private int _instruction = 0;

        // Misc
        private int _tmp, _tmp1, _tmp2, _tmp3;
        private int _PPC = 0; 				// previous PC - used by debugger
        private static readonly int[] BitSet = { 1, 2, 4, 8, 16, 32, 64, 128 }; 		// lookup table for setting a bit of an 8-bit value using OR
        private static readonly int[] BitRes = { 254, 253, 251, 247, 239, 223, 191, 127 }; // lookup table for resetting a bit of an 8-bit value using AND

        // Debug info
#pragma warning disable 414
        private int _debugLevel = 0;
        private int _debugBreakPoint = 0;
        private bool _debugEnabled = false;
        private bool _startSlice = true;
#pragma warning restore 414

        // flag tables
        private static bool[] _parity = new bool[256];
        private static int[] _SZ = new int[256];
        private static int[] _SZ_BIT = new int[256];
        private static int[] _SZP = new int[256];
        private static int[] _SZHV_inc = new int[256];
        private static int[] _SZHV_dec = new int[256];
        private static int[] _SZHVC_Add = new int[2 * 256 * 256];
        private static int[] _SZHVC_sub = new int[2 * 256 * 256];
        private static int _SF = 0x80;
        private static int _ZF = 0x40;
        private static int _YF = 0x20;
        private static int _HF = 0x10;
        private static int _XF = 0x08;
        private static int _VF = 0x04;
        private static int _PF = 0x04;
        private static int _NF = 0x02;
        private static int _CF = 0x01;

        private string _tag;

        static Z80()
        {

            int p = 0;

            for (int i = 0; i < 256; i++)
            {
                bool bp = true;
                for (int j = 0; j < 8; j++)
                {
                    if ((i & (1 << j)) != 0)
                    {
                        bp = !bp;
                    }
                }
                _parity[i] = bp;

                p = 0;

                if ((i & 0x01) != 0) ++p;
                if ((i & 0x02) != 0) ++p;
                if ((i & 0x04) != 0) ++p;
                if ((i & 0x08) != 0) ++p;
                if ((i & 0x10) != 0) ++p;
                if ((i & 0x20) != 0) ++p;
                if ((i & 0x40) != 0) ++p;
                if ((i & 0x80) != 0) ++p;

                _SZ[i] = (i != 0) ? i & 0x80 : 0x40;

                _SZ[i] |= (i & (0x20 | 0x08)); 	/* undocumented flag bits 5+3 */

                _SZ_BIT[i] = (i != 0) ? i & 0x80 : 0x40 | 0x04;

                _SZ_BIT[i] |= (i & (0x20 | 0x08)); /* undocumented flag bits 5+3 */

                _SZP[i] = _SZ[i] | (((p & 1) != 0) ? 0 : 0x04);

                _SZHV_inc[i] = _SZ[i];

                if (i == 0x80)
                {
                    _SZHV_inc[i] |= 0x04;
                }

                if ((i & 0x0f) == 0x00)
                {
                    _SZHV_inc[i] |= 0x10;
                }

                _SZHV_dec[i] = _SZ[i] | 0x02;

                if (i == 0x7f)
                {
                    _SZHV_dec[i] |= 0x04;
                }

                if ((i & 0x0f) == 0x0f)
                {
                    _SZHV_dec[i] |= 0x10;
                }
            }

            int oldval, newval, val;
            int padd, padc, psub, psbc;

            padd = 0 * 256;
            padc = 256 * 256;
            psub = 0 * 256;
            psbc = 256 * 256;

            for (oldval = 0; oldval < 256; oldval++)
            {

                for (newval = 0; newval < 256; newval++)
                {

                    /* add or adc w/o carry set */
                    val = newval - oldval;

                    if (newval != 0)
                    {
                        if ((newval & 0x80) != 0)
                        {
                            _SZHVC_Add[padd] = _SF;
                        }
                        else
                        {
                            _SZHVC_Add[padd] = 0;
                        }
                    }
                    else
                    {
                        _SZHVC_Add[padd] = _ZF;
                    }

                    _SZHVC_Add[padd] |= (newval & (_YF | _XF));	/* undocumented flag bits 5+3 */

                    if ((newval & 0x0f) < (oldval & 0x0f))
                    {
                        _SZHVC_Add[padd] |= _HF;
                    }
                    if (newval < oldval)
                    {
                        _SZHVC_Add[padd] |= _CF;
                    }
                    if (((val ^ oldval ^ 0x80) & (val ^ newval) & 0x80) != 0)
                    {
                        _SZHVC_Add[padd] |= _VF;
                    }
                    padd++;

                    /* adc with carry set */
                    val = newval - oldval - 1;
                    if (newval != 0)
                    {
                        if ((newval & 0x80) != 0)
                        {
                            _SZHVC_Add[padc] = _SF;
                        }
                        else
                        {
                            _SZHVC_Add[padc] = 0;
                        }
                    }
                    else
                    {
                        _SZHVC_Add[padc] = _ZF;
                    }


                    _SZHVC_Add[padc] |= (newval & (_YF | _XF));	/* undocumented flag bits 5+3 */
                    if ((newval & 0x0f) <= (oldval & 0x0f))
                    {
                        _SZHVC_Add[padc] |= _HF;
                    }

                    if (newval <= oldval)
                    {
                        _SZHVC_Add[padc] |= _CF;
                    }

                    if (((val ^ oldval ^ 0x80) & (val ^ newval) & 0x80) != 0)
                    {
                        _SZHVC_Add[padc] |= _VF;
                    }

                    padc++;

                    /* cp, sub or sbc w/o carry set */
                    val = oldval - newval;
                    if (newval != 0)
                    {
                        if ((newval & 0x80) != 0)
                        {
                            _SZHVC_sub[psub] = _NF | _SF;
                        }
                        else
                        {
                            _SZHVC_sub[psub] = _NF;
                        }
                    }
                    else
                    {
                        _SZHVC_sub[psub] = _NF | _ZF;
                    }

                    _SZHVC_sub[psub] |= (newval & (_YF | _XF));	/* undocumented flag bits 5+3 */
                    if ((newval & 0x0f) > (oldval & 0x0f))
                    {
                        _SZHVC_sub[psub] |= _HF;
                    }
                    if (newval > oldval)
                    {
                        _SZHVC_sub[psub] |= _CF;
                    }
                    if (((val ^ oldval) & (oldval ^ newval) & 0x80) != 0)
                    {
                        _SZHVC_sub[psub] |= _VF;
                    }
                    psub++;

                    /* sbc with carry set */
                    val = oldval - newval - 1;
                    if (newval != 0)
                    {
                        if ((newval & 0x80) != 0)
                        {
                            _SZHVC_sub[psbc] = _NF | _SF;
                        }
                        else
                        {
                            _SZHVC_sub[psbc] = _NF;
                        }
                    }
                    else
                    {
                        _SZHVC_sub[psbc] = _NF | _ZF;
                    }

                    _SZHVC_sub[psbc] |= (newval & (_YF | _XF));	/* undocumented flag bits 5+3 */
                    if ((newval & 0x0f) >= (oldval & 0x0f))
                    {
                        _SZHVC_sub[psbc] |= _HF;
                    }

                    if (newval >= oldval)
                    {
                        _SZHVC_sub[psbc] |= _CF;
                    }

                    if (((val ^ oldval) & (oldval ^ newval) & 0x80) != 0)
                    {
                        _SZHVC_sub[psbc] |= _VF;
                    }

                    psbc++;
                }
            }
        }

        /**
         * Default constructor
         * debugging disabled
         * Use this constructor for use in applets
         */
        public Z80()
        {
            //super();
            _debugLevel = 0;
        }

        public void SetTag(String tag)
        {
            _tag = tag;
        }

        public string GetTag()
        {
            return _tag;
        }

        /**
         * returns the currently excecuted instruction
         */
        public long GetInstruction()
        {
            return _instruction;
        }

        public void Interrupt(int type, bool irq)
        {
            if (type == INTERRUPT_TYPE_NMI)
            {
                Nmi();
            }
            else if (type == INTERRUPT_TYPE_IRQ)
            { // type ==IRQ
                Irq();
            }
        }

        /**
         * returns the program counter register (PC)
         */
        public int GetPC()
        {
            return PC;
        }

        public void SetDebug(bool debug)
        {
            _debugEnabled = debug;
        }

        public void SetProperty(int property, int value)
        {
            if (property == PROPERTY_Z80_IRQ_VECTOR)
            {
                I_Vector = value;
            }
        }

        /**
         * irq request
         */
        public void Irq()
        {
            IRQ = true;
            //if (!debugDisabled)
            //   { log("irq Request..."); }
        }

        /**
         * Non-Maskable irq request
         */
        public void Nmi()
        {
            NMI = true;
            //if (!debugDisabled)
            //   { log("Non-Maskable irq Request..."); }
        }

        /**
         * Reset CPU - Only resets the registers
         */
        public void Reset()
        {
            SP = 0x10000; 	// it's actually 0 but since the 1st stack inst is never a POP
            // we can set it to default 0x10000 in order to prevent AND-ing SP
            // with 0xffff all the time...

            PC = 0; A = 0; F = 0; B = 0; C = 0; D = 0; E = 0; H = 0; L = 0; I = 0; _R = 0; IX = 0xffff; IY = 0xffff;

            Cycle = 0;

            state_HALT = false;

            A1 = 0; F1 = 0; B1 = 0; C1 = 0; D1 = 0; E1 = 0; H1 = 0; L1 = 0;

            //if (!debugDisabled)
            //FLogFile.WriteLine("***Z80 RESET***");

        }

        public int GetCycle()
        {
            return CycleCounter - Cycle;

        }

        public void Step()
        {
        }

        /**
         * Execute a number of clock cycles
         *
         * @param	cycles
         *			number of cycles to be excecuted
         */
        public void Exec(int cycles)
        {
            CycleCounter += Cycle;
            Cycle += cycles;

            Cycle = CheckInterrupt(Cycle);

            if (DEBUG)
            {
                _startSlice = true;
            }

            while (Cycle > 0)
            {
                Step();

                // Cpu in HALT state
                if (state_HALT)
                {

                    while (state_HALT)
                    {
                        Halt();
                        Cycle = CheckInterrupt(Cycle);
                        if (Cycle <= 0)
                        {
                            return;
                        }
                        //  if (state_HALT == false)
                        //	  PC = (PC + 1 ) & 0xffff;
                    }
                }

                _instruction = MemProvider.Peek(PC);

                //if (EnableLog)
                //    FLogFile.WriteLine(String.Format("{0:X04} : {1:X02}", PC, inst));

                _PPC = PC;
                PC = (PC + 1) & 0xffff;
                _R++;

                switch (_instruction)
                {
                    case 0x00: Nop(); break; 		// NOP			ok
                    case 0x01: Ld_BC_nn(); break; 	// LD Bc,nn		ok
                    case 0x02: Ld_BCi_A(); break; 	// LD (Bc),a	ok
                    case 0x03: Inc_BC(); break; 	// INC Bc		ok
                    case 0x04: Inc_B(); break;		// INC B		ok
                    case 0x05: Dec_B(); break;		// DEC B		ok
                    case 0x06: Ld_B_n(); break;	// LD B,n		ok
                    case 0x07: Rlca(); break;		// RLCA			ok
                    case 0x08: Ex_AF_AF(); break;	// EX Af,Af'	ok
                    case 0x09: Add_HL_BC(); break;	// ADD Hl,Bc	ok
                    case 0x0a: Ld_A_BCi(); break;	// LD a,(Bc)	ok
                    case 0x0b: Dec_BC(); break;	// DEC Bc		ok
                    case 0x0C: Inc_C(); break;		// INC C		ok
                    case 0x0D: Dec_C(); break;		// DEC C		ok
                    case 0x0e: Ld_C_n(); break;	// LD C,n		ok
                    case 0x0f: Rrca(); break;		// RRCA			ok
                    case 0x10: Djnz_n(); break;	// DJNZ,n		ok
                    case 0x11: Ld_DE_nn(); break; 	// LD De,nn		ok
                    case 0x12: Ld_DEi_A(); break;	// LD (De),a	ok
                    case 0x13: Inc_DE(); break; 	// INC De		ok
                    case 0x14: Inc_D(); break;		// INC D		ok
                    case 0x15: Dec_D(); break;		// DEC D		ok
                    case 0x16: Ld_D_n(); break;	// LD D,n		ok
                    case 0x17: Rla(); break;		// RLA
                    case 0x18: Jr_e(); break;		// JR e			ok
                    case 0x19: Add_HL_DE(); break;	// ADD Hl,De	ok
                    case 0x1a: Ld_A_DEi(); break;	// LD a,(De)	ok
                    case 0x1b: Dec_DE(); break; 	// DEC De		ok
                    case 0x1C: Inc_E(); break; 	// INC E		ok
                    case 0x1D: Dec_E(); break; 	// DEC E		ok
                    case 0x1e: Ld_E_n(); break; 	// LD E,n		ok
                    case 0x1f: Rra(); break; 		// RRA
                    case 0x20: Jr_NZ_e(); break;	// JR NZ,e		ok
                    case 0x21: Ld_HL_nn(); break; 	// LD Hl,nn		ok
                    case 0x22: Ld_ni_HL(); break;	// LD (nn),Hl	ok
                    case 0x23: Inc_HL(); break; 	// INC Hl		ok
                    case 0x24: Inc_H(); break; 	// INC H		ok
                    case 0x25: Dec_H(); break;		// DEC H		ok
                    case 0x26: Ld_H_n(); break; 	// LD H,n		ok
                    case 0x27: Daa(); break;		// DAA			ok
                    case 0x28: Jr_Z_e(); break;	// JR Z,e		ok
                    case 0x29: Add_HL_HL(); break;	// ADD Hl,Hl	ok
                    case 0x2a: Ld_HL_ni(); break;	// LD Hl,(nn)	ok
                    case 0x2b: Dec_HL(); break; 	// DEC Hl		ok
                    case 0x2C: Inc_L(); break; 	// INC L		ok
                    case 0x2D: Dec_L(); break; 	// DEC L		ok
                    case 0x2e: Ld_L_n(); break; 	// LD L,n		ok
                    case 0x2f: Cpl(); break;		// CPL			ok
                    case 0x30: Jr_NC_e(); break;	// JR NC,e		ok
                    case 0x31: Ld_SP_nn(); break; 	// LD SP,nn		ok
                    case 0x32: Ld_ni_A(); break;	// LD (nn),a	ok
                    case 0x33: Inc_SP(); break;	// INC SP		ok
                    case 0x34: Inc_HLi(); break; 	// INC (Hl)		ok
                    case 0x35: Dec_HLi(); break; 	// DEC (Hl)		ok
                    case 0x36: Ld_HLi_n(); break; 	// LD (Hl),n	ok
                    case 0x37: Scf(); break;		// SCF			ok
                    case 0x38: Jr_C_e(); break;	// JR C,e		ok
                    case 0x39: Add_HL_SP(); break; // ADD Hl,SP	ok
                    case 0x3a: Ld_A_ni(); break;	// LD a,(nn)	ok
                    case 0x3b: Dec_SP(); break; 	// DEC SP		ok
                    case 0x3C: Inc_A(); break;		// INC a		ok
                    case 0x3D: Dec_A(); break;		// DEC a		ok
                    case 0x3e: Ld_A_n(); break;	// LD a,n		ok
                    case 0x3f: Ccf(); break;		// CCF			ok
                    case 0x40: Nop(); break;		// LD B,B		ok
                    case 0x41: Ld_B(C, 4); break; 	// LD B,C		ok
                    case 0x42: Ld_B(D, 4); break; 	// LD B,D		ok
                    case 0x43: Ld_B(E, 4); break; 	// LD B,E		ok
                    case 0x44: Ld_B(H, 4); break; 	// LD B,H		ok
                    case 0x45: Ld_B(L, 4); break; 	// LD B,L		ok
                    case 0x46: Ld_B(HLi(), 7); break; 	// LD B,(Hl)	ok
                    case 0x47: Ld_B(A, 4); break; 	// LD B,a		ok
                    case 0x48: Ld_C(B, 4); break;	// LD C,B		ok
                    case 0x49: Nop(); break; 		// LD C,C		ok
                    case 0x4a: Ld_C(D, 4); break; 	// LD C,D		ok
                    case 0x4b: Ld_C(E, 4); break; 	// LD C,E		ok
                    case 0x4c: Ld_C(H, 4); break; 	// LD C,H		ok
                    case 0x4d: Ld_C(L, 4); break; 	// LD C,L		ok
                    case 0x4e: Ld_C(HLi(), 7); break; 	// LD C,(Hl)	ok
                    case 0x4f: Ld_C(A, 4); break; 	// LD C,a		ok
                    case 0x50: Ld_D(B, 4); break;	// LD D,B		ok
                    case 0x51: Ld_D(C, 4); break;	// LD D,C		ok
                    case 0x52: Nop(); break;		// LD D,D		ok
                    case 0x53: Ld_D(E, 4); break;	// LD D,E		ok
                    case 0x54: Ld_D(H, 4); break;	// LD D,H		ok
                    case 0x55: Ld_D(L, 4); break;	// LD D,L		ok
                    case 0x56: Ld_D(HLi(), 7); break; 	// LD D,(Hl)	ok
                    case 0x57: Ld_D(A, 4); break;	// LD D,a		ok
                    case 0x58: Ld_E(B, 4); break; 	// LD E,B		ok
                    case 0x59: Ld_E(C, 4); break; 	// LD E,C		ok
                    case 0x5a: Ld_E(D, 4); break; 	// LD E,D		ok
                    case 0x5b: Nop(); break; 		// LD E,E		ok
                    case 0x5c: Ld_E(H, 4); break; 	// LD E,H		ok
                    case 0x5d: Ld_E(L, 4); break; 	// LD E,L		ok
                    case 0x5e: Ld_E(HLi(), 7); break; 	// LD E,(Hl)	ok
                    case 0x5f: Ld_E(A, 4); break; 	// LD E,a		ok
                    case 0x60: Ld_H(B, 4); break;	// LD H,B		ok
                    case 0x61: Ld_H(C, 4); break;	// LD H,C		ok
                    case 0x62: Ld_H(D, 4); break;	// LD H,D		ok
                    case 0x63: Ld_H(E, 4); break;	// LD H,E		ok
                    case 0x64: Nop(); break; 		// LD H,H		ok
                    case 0x65: Ld_H(L, 4); break;	// LD H,L		ok
                    case 0x66: Ld_H(HLi(), 7); break;	// LD H,(Hl)	ok
                    case 0x67: Ld_H(A, 4); break;	// LD H,a		ok
                    case 0x68: Ld_L(B, 4); break;	// LD L,B		ok
                    case 0x69: Ld_L(C, 4); break;	// LD L,C		ok
                    case 0x6a: Ld_L(D, 4); break; 	// LD L,D		ok
                    case 0x6b: Ld_L(E, 4); break; 	// LD L,E		ok
                    case 0x6c: Ld_L(H, 4); break; 	// LD L,H		ok
                    case 0x6d: Nop(); break; 		// LD L,L		ok
                    case 0x6e: Ld_L(HLi(), 7); break;	// LD L,(Hl)	ok
                    case 0x6f: Ld_L(A, 4); break;	// LD L,a		ok
                    case 0x70: Ld_HLi(B, 7); break; // LD (Hl),B	ok
                    case 0x71: Ld_HLi(C, 7); break; // LD (Hl),C	ok
                    case 0x72: Ld_HLi(D, 7); break; // LD (Hl),D	ok
                    case 0x73: Ld_HLi(E, 7); break; // LD (Hl),E	ok
                    case 0x74: Ld_HLi(H, 7); break; // LD (Hl),H	ok
                    case 0x75: Ld_HLi(L, 7); break; // LD (Hl),L	ok
                    case 0x76: Halt(); break;		// HALT			ok
                    case 0x77: Ld_HLi(A, 7); break; // LD (Hl),a	ok
                    case 0x78: Ld_A(B, 4); break; 	// LD a,B		ok
                    case 0x79: Ld_A(C, 4); break; 	// LD a,C		ok
                    case 0x7a: Ld_A(D, 4); break; 	// LD a,D		ok
                    case 0x7b: Ld_A(E, 4); break; 	// LD a,E		ok
                    case 0x7c: Ld_A(H, 4); break; 	// LD a,H		ok
                    case 0x7d: Ld_A(L, 4); break; 	// LD a,L		ok
                    case 0x7e: Ld_A(HLi(), 7); break; 	// LD a,(Hl)	ok
                    case 0x7f: Nop(); break; 		// LD a,a		ok
                    case 0x80: Add_A(B, 4); break;	// ADD a,B		ok
                    case 0x81: Add_A(C, 4); break; 	// ADD a,C		ok
                    case 0x82: Add_A(D, 4); break; 	// ADD a,D		ok
                    case 0x83: Add_A(E, 4); break; 	// ADD a,E		ok
                    case 0x84: Add_A(H, 4); break; 	// ADD a,H		ok
                    case 0x85: Add_A(L, 4); break; 	// ADD a,L		ok
                    case 0x86: Add_A(HLi(), 7); break; 	// ADD a,(Hl)	ok
                    case 0x87: Add_A(A, 4); break; 	// ADD a,a		ok
                    case 0x88: Adc_A(B, 4); break;	// ADC a,B		ok
                    case 0x89: Adc_A(C, 4); break;	// ADC a,C		ok
                    case 0x8a: Adc_A(D, 4); break;	// ADC a,D		ok
                    case 0x8b: Adc_A(E, 4); break;	// ADC a,E		ok
                    case 0x8c: Adc_A(H, 4); break;	// ADC a,H		ok
                    case 0x8d: Adc_A(L, 4); break;	// ADC a,L		ok
                    case 0x8e: Adc_A(HLi(), 7); break; 	// ADC a,(Hl)	ok
                    case 0x8f: Adc_A(A, 4); break;	// ADC a,a		ok
                    case 0x90: Sub_A(B, 4); break; 	// SUB a,B		ok
                    case 0x91: Sub_A(C, 4); break; 	// SUB a,C		ok
                    case 0x92: Sub_A(D, 4); break; 	// SUB a,D		ok
                    case 0x93: Sub_A(E, 4); break; 	// SUB a,E		ok
                    case 0x94: Sub_A(H, 4); break; 	// SUB a,H		ok
                    case 0x95: Sub_A(L, 4); break; 	// SUB a,L		ok
                    case 0x96: Sub_A(HLi(), 7); break; 	// SUB a,(Hl)	ok
                    case 0x97: Sub_A(A, 4); break; 	// SUB a,a		ok
                    case 0x98: Sbc_A(B, 4); break; 	// SBC a,B		ok
                    case 0x99: Sbc_A(C, 4); break; 	// SBC a,C		ok
                    case 0x9a: Sbc_A(D, 4); break; 	// SBC a,D		ok
                    case 0x9b: Sbc_A(E, 4); break; 	// SBC a,E		ok
                    case 0x9c: Sbc_A(H, 4); break; 	// SBC a,H		ok
                    case 0x9d: Sbc_A(L, 4); break; 	// SBC a,L		ok
                    case 0x9e: Sbc_A(HLi(), 7); break; 	// SBC a,(Hl)	ok
                    case 0x9f: Sbc_A(A, 4); break; 	// SBC a,a		ok
                    case 0xa0: And_A(B, 4); break; 	// AND B		ok
                    case 0xa1: And_A(C, 4); break; 	// AND C		ok
                    case 0xa2: And_A(D, 4); break; 	// AND D		ok
                    case 0xa3: And_A(E, 4); break; 	// AND E		ok
                    case 0xa4: And_A(H, 4); break; 	// AND H		ok
                    case 0xa5: And_A(L, 4); break; 	// AND L		ok
                    case 0xa6: And_A(HLi(), 7); break; 	// AND (Hl)	ok
                    case 0xa7: And_A(A, 4); break; 	// AND a		ok
                    case 0xa8: Xor_A(B, 4); break; 	// XOR B		ok
                    case 0xa9: Xor_A(C, 4); break; 	// XOR C		ok
                    case 0xaa: Xor_A(D, 4); break; 	// XOR D		ok
                    case 0xab: Xor_A(E, 4); break; 	// XOR E		ok
                    case 0xac: Xor_A(H, 4); break; 	// XOR H		ok
                    case 0xad: Xor_A(L, 4); break; 	// XOR L		ok
                    case 0xae: Xor_A(HLi(), 7); break; 	// XOR (Hl)	ok
                    case 0xaf: Xor_A(A, 4); break; 	// XOR a		ok
                    case 0xb0: Or_A(B, 4); break; 	// OR B			ok
                    case 0xb1: Or_A(C, 4); break; 	// OR C			ok
                    case 0xb2: Or_A(D, 4); break; 	// OR D			ok
                    case 0xb3: Or_A(E, 4); break; 	// OR E			ok
                    case 0xb4: Or_A(H, 4); break; 	// OR H			ok
                    case 0xb5: Or_A(L, 4); break; 	// OR L			ok
                    case 0xb6: Or_A(HLi(), 7); break; 	// OR (Hl)	ok
                    case 0xb7: Or_A(A, 4); break; 	// OR a			ok
                    case 0xb8: Cp_A(B, 4); break;	// CP B			ok
                    case 0xb9: Cp_A(C, 4); break;	// CP C			ok
                    case 0xba: Cp_A(D, 4); break;	// CP D			ok
                    case 0xbb: Cp_A(E, 4); break;	// CP E			ok
                    case 0xbc: Cp_A(H, 4); break;	// CP H			ok
                    case 0xbd: Cp_A(L, 4); break;	// CP L			ok
                    case 0xbe: Cp_A(HLi(), 7); break;  	// CP a,(Hl)ok
                    case 0xbf: Cp_A(A, 4); break;	// CP a			ok
                    case 0xc0: Ret_NZ(); break; 	// RET NZ		ok
                    case 0xc1: Pop_BC(); break; 	// POP Bc		ok
                    case 0xc2: Jp_NZ_nn(); break; 	// JP NZ,nn		ok
                    case 0xc3: Jp_nn(); break; 	// JP nn		ok
                    case 0xc4: Call_NZ_nn(); break;// CALL NZ,nn	ok
                    case 0xc5: Push_BC(); break; 	// PUSH Bc		ok
                    case 0xc6: Add_A_n(); break; 	// ADD a,n		ok
                    case 0xc7: Rst(0x00); break; 	// RST $00		ok
                    case 0xc8: Ret_Z(); break;		// RET Z		ok
                    case 0xc9: Ret(); break; 		// RET			ok
                    case 0xca: Jp_Z_nn(); break; 	// JP Z,nn 		ok
                    case 0xcb: Prefix_BC(); break;	// Opcodes with $CB prefix opcodes
                    case 0xcc: Call_Z_nn(); break;	// CALL Z,nn	ok
                    case 0xcd: Call_nn(); break; 	// CALL nn		ok
                    case 0xce: adc_A_n(); break; 	// ADC a,n		ok
                    case 0xcf: Rst(0x08); break; 	// RST $08		ok
                    case 0xd0: Ret_NC(); break;	// RET NC		ok
                    case 0xd1: Pop_DE(); break;	// POP De		ok
                    case 0xd2: Jp_NC_nn(); break; 	// JP NC,nn		ok
                    case 0xd3: out_n_A(); break;	// OUT (n),a	ok
                    case 0xd4: Call_NC_nn(); break; // CALL NC,nn	ok
                    case 0xd5: Push_DE(); break; 	// PUSH De		ok
                    case 0xd6: sub_A_n(); break; 	// SUB a,n		ok
                    case 0xd7: Rst(0x10); break; 	// RST $10		ok
                    case 0xd8: Ret_C(); break;		// RET C		ok
                    case 0xd9: Exx(); break; 		// EXX			ok
                    case 0xda: Jp_C_nn(); break; 	// JP C,nn		ok
                    case 0xdb: In_A_n(); break;	// IN a,(n)		ok
                    case 0xdc: Call_C_nn(); break; // CALL C,nn	ok
                    case 0xdd: IX = ExecXy(IX); break;	// Opcodes with $DD prefix
                    case 0xde: Sbc_A_n(); break; 	// SBC a,n		ok
                    case 0xdf: Rst(0x18); break; 	// RST $18		ok
                    case 0xe0: Ret_PO(); break;	// RET PO		ok
                    case 0xe1: Pop_HL(); break; 	// POP Hl		ok
                    case 0xe2: Jp_PO_nn(); break; 	// JP PO,nn		ok
                    case 0xe3: Ex_SPi_HL(); break;	// EX (SP),Hl	ok
                    case 0xe4: Call_PO_nn(); break;// CALL PO,nn	ok
                    case 0xe5: Push_HL(); break;	// PUSH Hl		ok
                    case 0xe6: And_A_n(); break;	// AND a,n		ok
                    case 0xe7: Rst(0x20); break;	// RST $20		ok
                    case 0xe8: Ret_PE(); break;	// RET PE		ok
                    case 0xe9: Jp_HLi(); break; 	// JP (Hl)		ok
                    case 0xea: Jp_PE_nn(); break; 	// JP PE,nn		ok
                    case 0xeb: Ex_DE_HL(); break; 	// EX De,Hl		ok
                    case 0xec: Call_PE_nn(); break;// CALL PE,nn	ok
                    case 0xed: Prefix_ED(); break;	// Opcodes with $ED prefix
                    case 0xee: Xor_n(); break; 	// XOR a,n		ok
                    case 0xef: Rst(0x28); break; 	// RST $28		ok
                    case 0xf0: Ret_P(); break;		// RET P		ok
                    case 0xf1: Pop_AF(); break;	// POP Af		ok
                    case 0xf2: Jp_P_nn(); break; 	// JP P,nn		ok
                    case 0xf3: Di(); break; 		// DI			ok
                    case 0xf4: Call_P_nn(); break; // CALL P,nn	ok
                    case 0xf5: Push_AF(); break;	// PUSH Af		ok
                    case 0xf6: Or_n(); break;		// OR a,n		ok
                    case 0xf7: Rst(0x30); break;	// RST $30		ok
                    case 0xf8: Ret_M(); break;		// RET M		ok
                    case 0xf9: Ld_SP_HL(); break;	// LD SP,Hl		ok
                    case 0xfa: Jp_M_nn(); break; 	// JP M,nn		ok
                    case 0xfb: Ei(); break;		// EI			ok
                    case 0xfc: Call_M_nn(); break;	// CALL M,nn	ok
                    case 0xfd: IY = ExecXy(IY); break;	// Opcodes with $FD prefix
                    case 0xfe: Cp_n(); break; 		// CP a,n		ok
                    case 0xff: Rst(0x38); break;	// RST $38		ok
                }

                //if (DEBUG) debug(inst, _PPC, a, F, B, C, D, E, H, L, SP, IX, IY, I, cyc);

            }	// end if (cyc ==0)

        }	// end void exec()

        /** $ED prefix opcodes */
        private void Prefix_ED()
        {
            int tmp1, tmp2, tmp3;
            _instruction = (_instruction << 8) + MemProvider.Peek(PC);
            PC = (PC + 1) & 0xffff;
            switch (_instruction & 0xff)
            {
                case 0x40: Cycle -= 12; B = PortIn(C, B); break;			// IN B,(C)		ok
                case 0x41: Cycle -= 12; PortOut(C, B); break; 			// OUT (C),B	ok
                case 0x42: Cycle -= 15; SbcHl(Bc()); break; 			// SBC Hl,Bc	ok
                case 0x43: Cycle -= 20; PokeW(PeekW(PC), Bc()); PC += 2; break;// LD (nn),Bc
                case 0x44: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 		// NEG
                case 0x45: Cycle -= 14; PC = PeekW(SP); SP += 2; IFF0 = IFF1; 		// RET N
                    Cycle = CheckInterrupt(Cycle); break;
                case 0x46: Cycle -= 8; IM = 0; break; 				// IM 0
                case 0x47: Cycle -= 9; I = A; break;					// LD I,a

                case 0x48: Cycle -= 12; C = PortIn(C, B); break;			// IN C,(C)		ok
                case 0x49: Cycle -= 12; PortOut(C, D); break; 			// OUT (C),D	ok
                case 0x4a: Cycle -= 15; AdcHl(Bc()); break; 			// ADC Hl,Bc
                case 0x4b: Cycle -= 20; B = MemProvider.Peek(PeekW(PC) + 1); C = MemProvider.Peek(PeekW(PC)); PC += 2; break; // LD Bc,(nn)
                case 0x4c: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 				// NEG
                case 0x4d: Cycle -= 14; PC = PeekW(SP); SP += 2; break; 					// RETI
                case 0x4e: Cycle -= 8; IM = 0; break; 				// IM 0
                case 0x4f: Cycle -= 9; _R = A; break; 					// LD R,a

                case 0x50: Cycle -= 12; D = PortIn(C, B); break;			// IN D,(C)		ok
                case 0x51: Cycle -= 12; PortOut(C, D); break; 			// OUT (C),E
                case 0x52: Cycle -= 15; SbcHl(De()); break; 			// SBC Hl,De	ok
                case 0x53: Cycle -= 20; PokeW(PeekW(PC), De()); PC += 2; break;// LD (nn),De
                case 0x54: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 				// NEG
                case 0x55: Cycle -= 14; PC = PeekW(SP); SP += 2; IFF0 = IFF1; 				// RET N
                    Cycle = CheckInterrupt(Cycle); break;
                case 0x56: Cycle -= 8; //System.out.println("IM 1");
                    IM = 1; break; 				// IM 1
                case 0x57: Cycle -= 9; A = I; break;					// LD a,I

                case 0x58: Cycle -= 12; E = PortIn(C, B); break;			// IN E,(C)		ok
                case 0x59: Cycle -= 12; PortOut(C, E); break; 			// OUT (C),E
                case 0x5a: Cycle -= 15; AdcHl(De()); break; 			// ADC Hl,De
                case 0x5B: Cycle -= 20; D = MemProvider.Peek(PeekW(PC) + 1); E = MemProvider.Peek(PeekW(PC)); PC += 2; break; // LD De,(nn)
                case 0x5c: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 				// NEG
                case 0x5d: Cycle -= 14; PC = PeekW(SP); SP += 2; break; 					// RETI
                case 0x5e: Cycle -= 8; IM = 2; break; 				// IM 2
                case 0x5f: Cycle -= 9; A = R(); break; 				// LD a,R

                case 0x60: Cycle -= 12; H = PortIn(C, B); break;			// IN H,(C)		ok
                case 0x61: Cycle -= 12; PortOut(C, H); break; 			// OUT (C),H
                case 0x62: Cycle -= 15; SbcHl(Hl()); break; 			// SBC Hl,Hl	ok
                case 0x63: Cycle -= 20; PokeW(PeekW(PC), Hl()); PC += 2; break;	// LD (nn),Hl
                case 0x64: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 				// NEG
                case 0x65: Cycle -= 14; PC = PeekW(SP); SP += 2; IFF0 = IFF1; 				// RET N
                    Cycle = CheckInterrupt(Cycle); break;
                case 0x66: Cycle -= 8; IM = 0; break; 				// IM 0
                case 0x67: Cycle -= 18; A = rrd_A(A, H, L); break;		// RRD

                case 0x68: Cycle -= 12; L = PortIn(C, B); break;			// IN L,(C)		ok
                case 0x69: Cycle -= 12; PortOut(C, L); break; 			// OUT (C),L
                case 0x6a: Cycle -= 15; AdcHl(Hl()); break; 			// ADC Hl,Hl
                case 0x6B: Cycle -= 20; H = MemProvider.Peek(PeekW(PC) + 1); L = MemProvider.Peek(PeekW(PC)); PC += 2; break; // LD Hl,(nn)
                case 0x6c: Cycle -= 13; tmp1 = A; A = 0; A = SubA_8(tmp1, A); break; 				// NEG
                case 0x6d: Cycle -= 14; PC = PeekW(SP); SP += 2; break; 					// RETI
                case 0x6e: Cycle -= 8; IM = 0; break; 				// IM 0
                case 0x6f: Cycle -= 18; A = rld_A(A, H, L); break; 		// RLD

                case 0x72: Cycle -= 15; SbcHl(SP); break; 			// SBC Hl,SP	ok
                case 0x73: Cycle -= 20; PokeW(PeekW(PC), SP); PC += 2; break; 		// LD (nn),SP

                case 0x78: Cycle -= 12; A = PortIn(C, B); break;			// IN a,(C)
                case 0x79: Cycle -= 11; PortOut(C, A, B); break; 			// OUT (C),a
                case 0x7a: Cycle -= 15; AdcHl(SP); break; 			// ADC Hl,SP
                case 0x7B: Cycle -= 20; SP = PeekW(PeekW(PC)); PC += 2; break;			// LD SP,(nn)

                case 0xa0: Cycle -= 21; 								// LDI
                    tmp1 = De(); tmp2 = Hl(); tmp3 = Bc(); MemProvider.Poke(tmp1, MemProvider.Peek(tmp2++)); tmp1 = (tmp1 + 1) & 0xffff; tmp3 = (tmp3 - 1) & 0xffff;
                    E = tmp1 & 0xff; D = tmp1 >> 8; L = tmp2 & 0xff; H = tmp2 >> 8; C = tmp3 & 0xff; B = tmp3 >> 8;
                    F &= 0x80 | 0x40 | 0x01;
                    if (tmp3 != 0)
                    {
                        F |= 0x04;
                    }
                    break;
                case 0xa1: Cycle -= 21;								// CPI
                    tmp1 = Hl(); tmp2 = Bc();
                    int value = MemProvider.Peek(tmp1);
                    int result = (A - value) & 0xff;
                    tmp1++; tmp2++;
                    F = (F & 1) | (_SZ[result] & ~(0x28)) | ((A ^ value ^ result) & 0x10) | 0x02;
                    if ((F & 0x10) != 0) { result = (result - 1) & 0xff; }
                    if ((result & 0x02) != 0) { F |= 0x20; }
                    if ((result & 0x08) != 0) { F |= 0x08; }
                    if (tmp2 != 0) { F |= 0x04; }
                    H = tmp1 >> 8; L = tmp1 & 0xff; B = tmp2 >> 8; C = tmp2 & 0xff;
                    break;
                case 0xa2: Cycle -= 16;								// INI
                    tmp1 = Hl();
                    B = (B - 1) & 0xff;
                    MemProvider.Poke(tmp1++, PortIn(B, A));
                    tmp1 &= 0xffff;
                    H = tmp1 >> 8; L = tmp1 & 0xff;
                    if (B == 0) { F |= 0x40; } else { F &= ~0x40; }
                    F |= 2;
                    break;
                case 0xa3: Cycle -= 16;								// OUTI
                    tmp1 = Hl();
                    PortOut(B, MemProvider.Peek(tmp1++));
                    B = (B - 1) & 0xff;
                    H = tmp1 >> 8; L = tmp1 & 0xff;
                    if (B == 0) { F |= 0x40; } else { F &= ~0x40; }
                    F |= 2;
                    break;
                case 0xa8: Cycle -= 21; 								// LDD
                    tmp1 = De(); tmp2 = Hl(); tmp3 = Bc(); MemProvider.Poke(tmp1, MemProvider.Peek(tmp2--)); tmp1 = (tmp1 - 1) & 0xffff; tmp3 = (tmp3 - 1) & 0xffff;
                    E = tmp1 & 0xff; D = tmp1 >> 8; L = tmp2 & 0xff; H = tmp2 >> 8; C = tmp3 & 0xff; B = tmp3 >> 8;
                    F &= 0x80 | 0x40 | 0x01;
                    if (tmp3 != 0)
                    {
                        F |= 0x04;
                    }
                    break;
                case 0xaa: Cycle -= 16;								// IND
                    tmp1 = Hl();
                    B = (B - 1) & 0xff;
                    MemProvider.Poke(tmp1--, PortIn(B, A));
                    tmp1 &= 0xffff;
                    H = tmp1 >> 8; L = tmp1 & 0xff;
                    if (B == 0) { F |= 0x40; } else { F &= ~0x40; }
                    F |= 2;
                    break;
                case 0xb0: Cycle = Cycle - (5 + 16 * (Bc())); tmp1 = De(); tmp2 = Hl();	// LDIR - ok
                    for (int n = (Bc()); n > 0; n--)
                    {
                        MemProvider.Poke(tmp1, MemProvider.Peek(tmp2)); tmp1 = (tmp1 + 1) & 0xffff; tmp2 = (tmp2 + 1) & 0xffff;
                    }
                    E = tmp1 & 0xff; D = tmp1 >> 8; B = C = 0; L = tmp2 & 0xff; H = tmp2 >> 8; F &= 0xe9; break;
                case 0xb1: tmp2 = F & 1; tmp1 = Bc(); tmp3 = Hl(); 						// CPIR - ok
                    Cycle -= 4; CpA_8(MemProvider.Peek(tmp3), A); tmp3++; tmp1--;
                    H = tmp3 >> 8; L = tmp3 & 0xff; B = tmp1 >> 8; C = tmp1 & 0xff;
                    F = (F & 0xfe) | tmp2;
                    if ((tmp1 != 0) && (F & 0x40) == 0) { PC -= 2; F |= 4; Cycle -= 21; } else { F &= 0xfb; Cycle -= 16; }
                    break;
                case 0xb3: Cycle = Cycle - (5 + 16 * B);					// OTIR
                    while (B > 0)
                    {
                        tmp1 = Hl();
                        PortOut(B, MemProvider.Peek(tmp1++));
                        B = (B - 1) & 0xff;
                        H = tmp1 >> 8; L = tmp1 & 0xff;
                        if (B == 0) { F |= 0x40; } else { F &= ~0x40; }
                    }
                    F |= 2;
                    break;

                case 0xb8: Cycle = Cycle - (5 + 16 * (Bc())); tmp1 = De(); tmp2 = Hl();	// LDDR - ok
                    for (int n = (Bc()); n > 0; n--)
                    {
                        MemProvider.Poke(tmp1--, MemProvider.Peek(tmp2--));
                    }
                    E = tmp1 & 0xff; D = tmp1 >> 8; B = C = 0; L = tmp2 & 0xff; H = tmp2 >> 8; F &= 0xe9; break;

                case 0xb9: tmp2 = F & 1; tmp1 = Bc(); tmp3 = Hl(); 						// CPIR - ok
                    Cycle -= 4; CpA_8(MemProvider.Peek(tmp3), A); tmp3--; tmp1--;
                    H = tmp3 >> 8; L = tmp3 & 0xff; B = tmp1 >> 8; C = tmp1 & 0xff;
                    F = (F & 0xfe) | tmp2;
                    if ((tmp1 != 0) && (F & 0x40) == 0) { PC -= 2; F |= 4; Cycle -= 21; } else { F &= 0xfb; Cycle -= 16; }
                    break;

                default: Error(_instruction, _PPC); break; // Not implemented
            }
        }

        /** $CB prefix opcodes */
        private void Prefix_BC()
        {
            _instruction = (_instruction << 8) + MemProvider.Peek(PC++);
            switch (_instruction & 0xff)
            {
                case 0x00: Cycle -= 8; B = Rlc(B); break;
                case 0x01: Cycle -= 8; C = Rlc(C); break;
                case 0x02: Cycle -= 8; D = Rlc(D); break;
                case 0x03: Cycle -= 8; E = Rlc(E); break;
                case 0x04: Cycle -= 8; H = Rlc(H); break;
                case 0x05: Cycle -= 8; L = Rlc(L); break;
                case 0x06: Cycle -= 15; MemProvider.Poke(Hl(), Rlc(HLi())); break;
                case 0x07: Cycle -= 8; A = Rlc(A); break;

                case 0x08: Cycle -= 8; B = Rrc(B); break;
                case 0x09: Cycle -= 8; C = Rrc(C); break;
                case 0x0a: Cycle -= 8; D = Rrc(D); break;
                case 0x0b: Cycle -= 8; E = Rrc(E); break;
                case 0x0c: Cycle -= 8; H = Rrc(H); break;
                case 0x0d: Cycle -= 8; L = Rrc(L); break;
                case 0x0e: Cycle -= 15; MemProvider.Poke(Hl(), Rrc(HLi())); break;
                case 0x0f: Cycle -= 8; A = Rrc(A); break;

                case 0x10: Cycle -= 8; B = Rl(B); break;
                case 0x11: Cycle -= 8; C = Rl(C); break;
                case 0x12: Cycle -= 8; D = Rl(D); break;
                case 0x13: Cycle -= 8; E = Rl(E); break;
                case 0x14: Cycle -= 8; H = Rl(H); break;
                case 0x15: Cycle -= 8; L = Rl(L); break;
                case 0x16: Cycle -= 15; MemProvider.Poke((Hl()), Rl(HLi())); break;
                case 0x17: Cycle -= 8; A = Rl(A); break;

                case 0x18: Cycle -= 8; B = Rr(B); break;
                case 0x19: Cycle -= 8; C = Rr(C); break;
                case 0x1A: Cycle -= 8; D = Rr(D); break;
                case 0x1B: Cycle -= 8; E = Rr(E); break;
                case 0x1C: Cycle -= 8; H = Rr(H); break;
                case 0x1D: Cycle -= 8; L = Rr(L); break;
                case 0x1E: Cycle -= 15; MemProvider.Poke((Hl()), Rr(HLi())); break;
                case 0x1F: Cycle -= 8; A = Rr(A); break;

                case 0x20: Cycle -= 8; B = Sla(B); break;
                case 0x21: Cycle -= 8; C = Sla(C); break;
                case 0x22: Cycle -= 8; D = Sla(D); break;
                case 0x23: Cycle -= 8; E = Sla(E); break;
                case 0x24: Cycle -= 8; H = Sla(H); break;
                case 0x25: Cycle -= 8; L = Sla(L); break;
                case 0x26: Cycle -= 12; MemProvider.Poke((Hl()), Sla(HLi())); break;
                case 0x27: Cycle -= 8; A = Sla(A); break;

                case 0x28: Cycle -= 8; B = Sra(B); break;
                case 0x29: Cycle -= 8; C = Sra(C); break;
                case 0x2a: Cycle -= 8; D = Sra(D); break;
                case 0x2b: Cycle -= 8; E = Sra(E); break;
                case 0x2c: Cycle -= 8; H = Sra(H); break;
                case 0x2d: Cycle -= 8; L = Sra(L); break;
                case 0x2e: Cycle -= 12; MemProvider.Poke((Hl()), Sra(HLi())); break;
                case 0x2f: Cycle -= 8; A = Sra(A); break;

                case 0x30: Cycle -= 8; B = Sll(B); break;
                case 0x31: Cycle -= 8; C = Sll(C); break;
                case 0x32: Cycle -= 8; D = Sll(D); break;
                case 0x33: Cycle -= 8; E = Sll(E); break;
                case 0x34: Cycle -= 8; H = Sll(H); break;
                case 0x35: Cycle -= 8; L = Sll(L); break;
                case 0x36: Cycle -= 12; MemProvider.Poke((Hl()), Sll(HLi())); break;
                case 0x37: Cycle -= 8; A = Sll(A); break;

                case 0x38: Cycle -= 8; B = Srl(B); break;
                case 0x39: Cycle -= 8; C = Srl(C); break;
                case 0x3a: Cycle -= 8; D = Srl(D); break;
                case 0x3b: Cycle -= 8; E = Srl(E); break;
                case 0x3c: Cycle -= 8; H = Srl(H); break;
                case 0x3d: Cycle -= 8; L = Srl(L); break;
                case 0x3e: Cycle -= 12; MemProvider.Poke((Hl()), Srl(HLi())); break;
                case 0x3f: Cycle -= 8; A = Srl(A); break;

                case 0x40: Cycle -= 8; Bit(0, B); break;
                case 0x41: Cycle -= 8; Bit(0, C); break;
                case 0x42: Cycle -= 8; Bit(0, D); break;
                case 0x43: Cycle -= 8; Bit(0, E); break;
                case 0x44: Cycle -= 8; Bit(0, H); break;
                case 0x45: Cycle -= 8; Bit(0, L); break;
                case 0x46: Cycle -= 12; Bit(0, HLi()); break;
                case 0x47: Cycle -= 8; Bit(0, A); break;

                case 0x48: Cycle -= 8; Bit(1, B); break;
                case 0x49: Cycle -= 8; Bit(1, C); break;
                case 0x4a: Cycle -= 8; Bit(1, D); break;
                case 0x4b: Cycle -= 8; Bit(1, E); break;
                case 0x4c: Cycle -= 8; Bit(1, H); break;
                case 0x4d: Cycle -= 8; Bit(1, L); break;
                case 0x4e: Cycle -= 12; Bit(1, HLi()); break;
                case 0x4f: Cycle -= 8; Bit(1, A); break;

                case 0x50: Cycle -= 8; Bit(2, B); break;
                case 0x51: Cycle -= 8; Bit(2, C); break;
                case 0x52: Cycle -= 8; Bit(2, D); break;
                case 0x53: Cycle -= 8; Bit(2, E); break;
                case 0x54: Cycle -= 8; Bit(2, H); break;
                case 0x55: Cycle -= 8; Bit(2, L); break;
                case 0x56: Cycle -= 12; Bit(2, HLi()); break;
                case 0x57: Cycle -= 8; Bit(2, A); break;

                case 0x58: Cycle -= 8; Bit(3, B); break;
                case 0x59: Cycle -= 8; Bit(3, C); break;
                case 0x5a: Cycle -= 8; Bit(3, D); break;
                case 0x5b: Cycle -= 8; Bit(3, E); break;
                case 0x5c: Cycle -= 8; Bit(3, H); break;
                case 0x5d: Cycle -= 8; Bit(3, L); break;
                case 0x5e: Cycle -= 12; Bit(3, HLi()); break;
                case 0x5f: Cycle -= 8; Bit(3, A); break;

                case 0x60: Cycle -= 8; Bit(4, B); break;
                case 0x61: Cycle -= 8; Bit(4, C); break;
                case 0x62: Cycle -= 8; Bit(4, D); break;
                case 0x63: Cycle -= 8; Bit(4, E); break;
                case 0x64: Cycle -= 8; Bit(4, H); break;
                case 0x65: Cycle -= 8; Bit(4, L); break;
                case 0x66: Cycle -= 12; Bit(4, HLi()); break;
                case 0x67: Cycle -= 8; Bit(4, A); break;

                case 0x68: Cycle -= 8; Bit(5, B); break;
                case 0x69: Cycle -= 8; Bit(5, C); break;
                case 0x6a: Cycle -= 8; Bit(5, D); break;
                case 0x6b: Cycle -= 8; Bit(5, E); break;
                case 0x6c: Cycle -= 8; Bit(5, H); break;
                case 0x6d: Cycle -= 8; Bit(5, L); break;
                case 0x6e: Cycle -= 12; Bit(5, HLi()); break;
                case 0x6f: Cycle -= 8; Bit(5, A); break;

                case 0x70: Cycle -= 8; Bit(6, B); break;
                case 0x71: Cycle -= 8; Bit(6, C); break;
                case 0x72: Cycle -= 8; Bit(6, D); break;
                case 0x73: Cycle -= 8; Bit(6, E); break;
                case 0x74: Cycle -= 8; Bit(6, H); break;
                case 0x75: Cycle -= 8; Bit(6, L); break;
                case 0x76: Cycle -= 12; Bit(6, HLi()); break;
                case 0x77: Cycle -= 8; Bit(6, A); break;

                case 0x78: Cycle -= 8; Bit(7, B); break;
                case 0x79: Cycle -= 8; Bit(7, C); break;
                case 0x7a: Cycle -= 8; Bit(7, D); break;
                case 0x7b: Cycle -= 8; Bit(7, E); break;
                case 0x7c: Cycle -= 8; Bit(7, H); break;
                case 0x7d: Cycle -= 8; Bit(7, L); break;
                case 0x7e: Cycle -= 12; Bit(7, HLi()); break;
                case 0x7f: Cycle -= 8; Bit(7, A); break;

                case 0x80: Cycle -= 8; B = Res(0, B); break;
                case 0x81: Cycle -= 8; C = Res(0, C); break;
                case 0x82: Cycle -= 8; D = Res(0, D); break;
                case 0x83: Cycle -= 8; E = Res(0, E); break;
                case 0x84: Cycle -= 8; H = Res(0, H); break;
                case 0x85: Cycle -= 8; L = Res(0, L); break;
                case 0x86: Cycle -= 12; MemProvider.Poke(Hl(), Res(0, HLi())); break;
                case 0x87: Cycle -= 8; A = Res(0, A); break;

                case 0x88: Cycle -= 8; B = Res(1, B); break;
                case 0x89: Cycle -= 8; C = Res(1, C); break;
                case 0x8a: Cycle -= 8; D = Res(1, D); break;
                case 0x8b: Cycle -= 8; E = Res(1, E); break;
                case 0x8c: Cycle -= 8; H = Res(1, H); break;
                case 0x8d: Cycle -= 8; L = Res(1, L); break;
                case 0x8e: Cycle -= 12; MemProvider.Poke(Hl(), Res(1, HLi())); break;
                case 0x8f: Cycle -= 8; A = Res(1, A); break;

                case 0x90: Cycle -= 8; B = Res(2, B); break;
                case 0x91: Cycle -= 8; C = Res(2, C); break;
                case 0x92: Cycle -= 8; D = Res(2, D); break;
                case 0x93: Cycle -= 8; E = Res(2, E); break;
                case 0x94: Cycle -= 8; H = Res(2, H); break;
                case 0x95: Cycle -= 8; L = Res(2, L); break;
                case 0x96: Cycle -= 12; MemProvider.Poke(Hl(), Res(2, HLi())); break;
                case 0x97: Cycle -= 8; A = Res(2, A); break;

                case 0x98: Cycle -= 8; B = Res(3, B); break;
                case 0x99: Cycle -= 8; C = Res(3, C); break;
                case 0x9a: Cycle -= 8; D = Res(3, D); break;
                case 0x9b: Cycle -= 8; E = Res(3, E); break;
                case 0x9c: Cycle -= 8; H = Res(3, H); break;
                case 0x9d: Cycle -= 8; L = Res(3, L); break;
                case 0x9e: Cycle -= 12; MemProvider.Poke(Hl(), Res(3, HLi())); break;
                case 0x9f: Cycle -= 8; A = Res(3, A); break;

                case 0xa0: Cycle -= 8; B = Res(4, B); break;
                case 0xa1: Cycle -= 8; C = Res(4, C); break;
                case 0xa2: Cycle -= 8; D = Res(4, D); break;
                case 0xa3: Cycle -= 8; E = Res(4, E); break;
                case 0xa4: Cycle -= 8; H = Res(4, H); break;
                case 0xa5: Cycle -= 8; L = Res(4, L); break;
                case 0xa6: Cycle -= 12; MemProvider.Poke(Hl(), Res(4, HLi())); break;
                case 0xa7: Cycle -= 8; A = Res(4, A); break;

                case 0xa8: Cycle -= 8; B = Res(5, B); break;
                case 0xa9: Cycle -= 8; C = Res(5, C); break;
                case 0xaa: Cycle -= 8; D = Res(5, D); break;
                case 0xab: Cycle -= 8; E = Res(5, E); break;
                case 0xac: Cycle -= 8; H = Res(5, H); break;
                case 0xad: Cycle -= 8; L = Res(5, L); break;
                case 0xae: Cycle -= 12; MemProvider.Poke(Hl(), Res(5, HLi())); break;
                case 0xaf: Cycle -= 8; A = Res(5, A); break;

                case 0xb0: Cycle -= 8; B = Res(6, B); break;
                case 0xb1: Cycle -= 8; C = Res(6, C); break;
                case 0xb2: Cycle -= 8; D = Res(6, D); break;
                case 0xb3: Cycle -= 8; E = Res(6, E); break;
                case 0xb4: Cycle -= 8; H = Res(6, H); break;
                case 0xb5: Cycle -= 8; L = Res(6, L); break;
                case 0xb6: Cycle -= 12; MemProvider.Poke(Hl(), Res(6, HLi())); break;
                case 0xb7: Cycle -= 8; A = Res(6, A); break;

                case 0xb8: Cycle -= 8; B = Res(7, B); break;
                case 0xb9: Cycle -= 8; C = Res(7, C); break;
                case 0xba: Cycle -= 8; D = Res(7, D); break;
                case 0xbb: Cycle -= 8; E = Res(7, E); break;
                case 0xbc: Cycle -= 8; H = Res(7, H); break;
                case 0xbd: Cycle -= 8; L = Res(7, L); break;
                case 0xbe: Cycle -= 12; MemProvider.Poke(Hl(), Res(7, HLi())); break;
                case 0xbf: Cycle -= 8; A = Res(7, A); break;

                case 0xc0: Cycle -= 8; B = Set(0, B); break;
                case 0xc1: Cycle -= 8; C = Set(0, C); break;
                case 0xc2: Cycle -= 8; D = Set(0, D); break;
                case 0xc3: Cycle -= 8; E = Set(0, E); break;
                case 0xc4: Cycle -= 8; H = Set(0, H); break;
                case 0xc5: Cycle -= 8; L = Set(0, L); break;
                case 0xc6: Cycle -= 12; MemProvider.Poke(Hl(), Set(0, HLi())); break;
                case 0xc7: Cycle -= 8; A = Set(0, A); break;

                case 0xc8: Cycle -= 8; B = Set(1, B); break;
                case 0xc9: Cycle -= 8; C = Set(1, C); break;
                case 0xca: Cycle -= 8; D = Set(1, D); break;
                case 0xcb: Cycle -= 8; E = Set(1, E); break;
                case 0xcc: Cycle -= 8; H = Set(1, H); break;
                case 0xcd: Cycle -= 8; L = Set(1, L); break;
                case 0xce: Cycle -= 12; MemProvider.Poke(Hl(), Set(1, HLi())); break;
                case 0xcf: Cycle -= 8; A = Set(1, A); break;

                case 0xd0: Cycle -= 8; B = Set(2, B); break;
                case 0xd1: Cycle -= 8; C = Set(2, C); break;
                case 0xd2: Cycle -= 8; D = Set(2, D); break;
                case 0xd3: Cycle -= 8; E = Set(2, E); break;
                case 0xd4: Cycle -= 8; H = Set(2, H); break;
                case 0xd5: Cycle -= 8; L = Set(2, L); break;
                case 0xd6: Cycle -= 12; MemProvider.Poke(Hl(), Set(2, HLi())); break;
                case 0xd7: Cycle -= 8; A = Set(2, A); break;

                case 0xd8: Cycle -= 8; B = Set(3, B); break;
                case 0xd9: Cycle -= 8; C = Set(3, C); break;
                case 0xda: Cycle -= 8; D = Set(3, D); break;
                case 0xdb: Cycle -= 8; E = Set(3, E); break;
                case 0xdc: Cycle -= 8; H = Set(3, H); break;
                case 0xdd: Cycle -= 8; L = Set(3, L); break;
                case 0xde: Cycle -= 12; MemProvider.Poke(Hl(), Set(3, HLi())); break;
                case 0xdf: Cycle -= 8; A = Set(3, A); break;

                case 0xe0: Cycle -= 8; B = Set(4, B); break;
                case 0xe1: Cycle -= 8; C = Set(4, C); break;
                case 0xe2: Cycle -= 8; D = Set(4, D); break;
                case 0xe3: Cycle -= 8; E = Set(4, E); break;
                case 0xe4: Cycle -= 8; H = Set(4, H); break;
                case 0xe5: Cycle -= 8; L = Set(4, L); break;
                case 0xe6: Cycle -= 12; MemProvider.Poke(Hl(), Set(4, HLi())); break;
                case 0xe7: Cycle -= 8; A = Set(4, A); break;

                case 0xe8: Cycle -= 8; B = Set(5, B); break;
                case 0xe9: Cycle -= 8; C = Set(5, C); break;
                case 0xea: Cycle -= 8; D = Set(5, D); break;
                case 0xeb: Cycle -= 8; E = Set(5, E); break;
                case 0xec: Cycle -= 8; H = Set(5, H); break;
                case 0xed: Cycle -= 8; L = Set(5, L); break;
                case 0xee: Cycle -= 12; MemProvider.Poke(Hl(), Set(5, HLi())); break;
                case 0xef: Cycle -= 8; A = Set(5, A); break;

                case 0xf0: Cycle -= 8; B = Set(6, B); break;
                case 0xf1: Cycle -= 8; C = Set(6, C); break;
                case 0xf2: Cycle -= 8; D = Set(6, D); break;
                case 0xf3: Cycle -= 8; E = Set(6, E); break;
                case 0xf4: Cycle -= 8; H = Set(6, H); break;
                case 0xf5: Cycle -= 8; L = Set(6, L); break;
                case 0xf6: Cycle -= 12; MemProvider.Poke(Hl(), Set(6, HLi())); break;
                case 0xf7: Cycle -= 8; A = Set(6, A); break;

                case 0xf8: Cycle -= 8; B = Set(7, B); break;
                case 0xf9: Cycle -= 8; C = Set(7, C); break;
                case 0xfa: Cycle -= 8; D = Set(7, D); break;
                case 0xfb: Cycle -= 8; E = Set(7, E); break;
                case 0xfc: Cycle -= 8; H = Set(7, H); break;
                case 0xfd: Cycle -= 8; L = Set(7, L); break;
                case 0xfe: Cycle -= 12; MemProvider.Poke(Hl(), Set(7, HLi())); break;
                case 0xff: Cycle -= 8; A = Set(7, A); break;
            }
        }

        /** $DD and $FD prefix opcodes (index instructions) */
        private int ExecXy(int xy)
        {
            int tmp1, tmp2;
            _instruction = (_instruction << 8) + MemProvider.Peek(PC++);
            IXYd = (xy + Sign(MemProvider.Peek(PC))) & 0xffff;
            switch (_instruction & 0xff)
            {
                case 0x00:
                case 0x01:
                case 0x02:
                case 0x03:
                case 0x04:
                case 0x05:
                case 0x06:
                case 0x07:
                case 0x08: Error(_instruction, _PPC); break; // Not implemented
                case 0x09: Cycle -= 15; xy = Add16(xy, Bc()); break; 						// ADD xy,Bc	ok
                case 0x0a:
                case 0x0b:
                case 0x0c:
                case 0x0d:
                case 0x0e:
                case 0x0f:
                case 0x10:
                case 0x11:
                case 0x12:
                case 0x13:
                case 0x14:
                case 0x15:
                case 0x16:
                case 0x17:
                case 0x18: Error(_instruction, _PPC); break; // Not implemented
                case 0x19: Cycle -= 15; xy = Add16(xy, De()); break; 						// ADD xy,De	ok
                case 0x1a:
                case 0x1b:
                case 0x1c:
                case 0x1d:
                case 0x1e:
                case 0x1f:
                case 0x20: Error(_instruction, _PPC); break; // Not implemented
                case 0x21: Cycle -= 14; xy = PeekW(PC); PC += 2; break; 				// LD xy,nn		ok
                case 0x22: Cycle -= 20; PokeW(PeekW(PC), xy); PC += 2; break; 	// LD (nn),xy	ok
                case 0x23: Cycle -= 10; xy = (xy + 1) & 0xffff; break; // INC xy		ok
                case 0x24:
                case 0x25: Error(_instruction, _PPC); break; // Not implemented
                case 0x26: Cycle -= 11; xy = (xy & 0x00ff) | (MemProvider.Peek(PC++) << 8); break;		// LD HXY,n		ok
                case 0x27:
                case 0x28: Error(_instruction, _PPC); break; // Not implemented
                case 0x29: Cycle -= 15; xy = Add16(xy, xy); break;	// ADD xy,xy		ok
                case 0x2a: Cycle -= 20; xy = PeekW(PeekW(PC)); PC += 2; break; 	// LD xy,(nn)	ok
                case 0x2b: Cycle -= 10; xy = (xy - 1) & 0xffff; break; // DEC xy		ok
                case 0x2c: Cycle -= 15; xy = IncL16(xy); break;
                case 0x2d: Cycle -= 15; xy = DecL16(xy); break;
                case 0x2e: Cycle -= 11; xy = (xy & 0xff00) | MemProvider.Peek(PC++); break;
                case 0x2f:
                case 0x30:
                case 0x31:
                case 0x32:
                case 0x33: Error(_instruction, _PPC); break; // Not implemented
                case 0x34: Cycle -= 15; MemProvider.Poke(IXYd, Inc8(MemProvider.Peek(IXYd))); PC++; break; // INC (xy+d)	ok
                case 0x35: Cycle -= 15; MemProvider.Poke(IXYd, Dec8(MemProvider.Peek(IXYd))); PC++; break; // DEC (xy+d)	ok
                case 0x36: Cycle -= 19; MemProvider.Poke(IXYd, MemProvider.Peek(PC + 1)); PC += 2; break; 	// LD (xy+d),n
                case 0x37:
                case 0x38: Error(_instruction, _PPC); break; // Not implemented
                case 0x39: Cycle -= 15; tmp2 = xy; xy = (xy + SP) & 0xffff; if (xy < tmp2) { F = (F & 0xFD) | 1; } else { F = (F & 0xFD); } break;// ADD xy,SP	ok
                case 0x3a:
                case 0x3b:
                case 0x3c:
                case 0x3d:
                case 0x3e:
                case 0x3f:
                case 0x40:
                case 0x41:
                case 0x42:
                case 0x43:
                case 0x44:
                case 0x45: Error(_instruction, _PPC); break; // Not implemented
                case 0x46: Cycle -= 11; B = MemProvider.Peek(IXYd); PC++; break; 						// LD B,(xy+d)	ok
                case 0x47:
                case 0x48:
                case 0x49:
                case 0x4a:
                case 0x4b: Error(_instruction, _PPC); break; // Not implemented
                case 0x4c: Cycle -= 11; C = (xy >> 8); break;
                case 0x4d: Cycle -= 11; C = (xy & 0xff); break;
                case 0x4e: Cycle -= 11; C = MemProvider.Peek(IXYd); PC++; break; 					// LD C,(xy+d)	ok
                case 0x4f:
                case 0x50:
                case 0x51:
                case 0x52:
                case 0x53: Error(_instruction, _PPC); break; // Not implemented
                case 0x54: Cycle -= 11; D = (xy >> 8); break;
                case 0x55: Cycle -= 11; D = (xy & 0xff); break;
                case 0x56: Cycle -= 11; D = MemProvider.Peek(IXYd); PC++; break; 					// LD D,(xy+d)	ok
                case 0x57:
                case 0x58:
                case 0x59:
                case 0x5a:
                case 0x5b: Error(_instruction, _PPC); break; // Not implemented
                case 0x5c: Cycle -= 11; E = (xy >> 8); break;
                case 0x5d: Cycle -= 11; E = (xy & 0xff); break;
                case 0x5e: Cycle -= 11; E = MemProvider.Peek(IXYd); PC++; break; 					// LD E,(xy+d)	ok
                case 0x5f: Error(_instruction, _PPC); break; // Not implemented
                case 0x60: Cycle -= 11; xy = LdXYH_8(xy, B); break;
                case 0x61: Cycle -= 11; xy = LdXYH_8(xy, C); break;
                case 0x62: Cycle -= 11; xy = LdXYH_8(xy, D); break;
                case 0x63: Cycle -= 11; xy = LdXYH_8(xy, E); break;
                case 0x64:
                case 0x65: Error(_instruction, _PPC); break; // Not implemented
                case 0x66: Cycle -= 11; H = MemProvider.Peek(IXYd); PC++; break; 					// LD H,(xy+d)	ok
                case 0x67: Cycle -= 11; xy = (xy & 0xff) | (A << 8); break;
                case 0x68: Cycle -= 11; xy = LdXYL_8(xy, B); break;
                case 0x69: Cycle -= 11; xy = LdXYL_8(xy, C); break;
                case 0x6a: Cycle -= 11; xy = LdXYL_8(xy, D); break;
                case 0x6b: Cycle -= 11; xy = LdXYL_8(xy, E); break;
                case 0x6c:
                case 0x6d: Error(_instruction, _PPC); break; // Not implemented
                case 0x6e: Cycle -= 11; L = MemProvider.Peek(IXYd); PC++; break; 					// LD L,(xy+d)	ok
                case 0x6f: Cycle -= 11; xy = (xy & 0xff00) | A; break;
                case 0x70: Cycle -= 11; MemProvider.Poke(IXYd, B); PC++; break; 					// LD (xy+d),B	ok
                case 0x71: Cycle -= 11; MemProvider.Poke(IXYd, C); PC++; break; 					// LD (xy+d),C	ok
                case 0x72: Cycle -= 11; MemProvider.Poke(IXYd, D); PC++; break; 					// LD (xy+d),D	ok
                case 0x73: Cycle -= 11; MemProvider.Poke(IXYd, E); PC++; break; 					// LD (xy+d),E	ok
                case 0x74: Cycle -= 11; MemProvider.Poke(IXYd, H); PC++; break; 					// LD (xy+d),H	ok
                case 0x75: Cycle -= 11; MemProvider.Poke(IXYd, L); PC++; break; 					// LD (xy+d),L	ok
                case 0x77: Cycle -= 11; MemProvider.Poke(IXYd, A); PC++; break; 					// LD (xy+d),a	ok
                case 0x78:
                case 0x79:
                case 0x7a:
                case 0x7b: Error(_instruction, _PPC); break; // Not implemented
                case 0x7c: Cycle -= 11; A = (xy & 0xff00) >> 8; break;
                case 0x7d: Cycle -= 11; A = xy & 0xff; break;
                case 0x7e: Cycle -= 11; A = MemProvider.Peek(IXYd); PC++; break; 					// LD a,(xy+d)	ok
                case 0x7f:
                case 0x80:
                case 0x81:
                case 0x82:
                case 0x83: Error(_instruction, _PPC); break; // Not implemented
                case 0x84: Cycle -= 11; A = AddA_8((xy >> 8), A); break;
                case 0x85: Cycle -= 11; A = AddA_8((xy & 0xff), A); break;
                case 0x86: Cycle -= 11; A = AddA_8(MemProvider.Peek(IXYd), A); PC++; break; 			// ADD a,(xy+d)	ok
                case 0x87:
                case 0x88:
                case 0x89:
                case 0x8a:
                case 0x8b:
                case 0x8c:
                case 0x8d: Error(_instruction, _PPC); break; // Not implemented
                case 0x8e: Cycle -= 11; A = AdcA_8(MemProvider.Peek(IXYd), A); PC++; break; 		// ADC a,(xy+d)	ok
                case 0x8f:
                case 0x90:
                case 0x91:
                case 0x92:
                case 0x93: Error(_instruction, _PPC); break; // Not implemented
                case 0x94: Cycle -= 11; A = SubA_8(xy >> 8, A); break;
                case 0x95: Cycle -= 11; A = SubA_8(xy & 0xff, A); break;
                case 0x96: Cycle -= 11; A = SubA_8(MemProvider.Peek(IXYd), A); PC++; break; 		// SUB a,(xy+d)	ok
                case 0x97:
                case 0x98:
                case 0x99:
                case 0x9a:
                case 0x9b:
                case 0x9c:
                case 0x9d: Error(_instruction, _PPC); break; // Not implemented
                case 0x9e: Cycle -= 11; A = SbcA_8(MemProvider.Peek(IXYd), A); PC++; break; 		// SBC a,(xy+d)	ok
                case 0x9f:
                case 0xa0:
                case 0xa1:
                case 0xa2:
                case 0xa3:
                case 0xa4:
                case 0xa5: Error(_instruction, _PPC); break; // Not implemented
                case 0xa6: Cycle -= 11; A = AndA(MemProvider.Peek(IXYd), A); PC++; break; 			// AND (xy+d)	ok
                case 0xa7:
                case 0xa8:
                case 0xa9:
                case 0xaa:
                case 0xab: Error(_instruction, _PPC); break; // Not implemented
                case 0xac: Cycle -= 11; A = XorA(xy >> 8, A); break;
                case 0xad: Error(_instruction, _PPC); break; // Not implemented
                case 0xae: Cycle -= 11; A = XorA(MemProvider.Peek(IXYd), A); PC++; break; 			// XOR (xy+d)	ok
                case 0xaf:
                case 0xb0:
                case 0xb1:
                case 0xb2:
                case 0xb3:
                case 0xb4:
                case 0xb5: Error(_instruction, _PPC); break; // Not implemented
                case 0xb6: Cycle -= 11; A = OrA(MemProvider.Peek(IXYd), A); PC++; break; 			// OR (xy+d)	ok
                case 0xb7:
                case 0xb8:
                case 0xb9:
                case 0xba:
                case 0xbb:
                case 0xbc:
                case 0xbd: Error(_instruction, _PPC); break; // Not implemented
                case 0xbe: Cycle -= 11; CpA_8(MemProvider.Peek(IXYd), A); PC++; break; 			// CP (xy+d)	ok
                case 0xcb:	//---------------------------Second table-----------------------------
                    IXYd = xy + Sign(MemProvider.Peek(PC++));
                    _instruction = (_instruction << 8) + MemProvider.Peek(PC++);
                    switch (_instruction & 0xff)
                    {
                        case 0x06: Cycle -= 15; MemProvider.Poke(IXYd, Rlc(MemProvider.Peek(IXYd))); break; // RLC (IXYd)	ok
                        case 0x0E: Cycle -= 15; MemProvider.Poke(IXYd, Rrc(MemProvider.Peek(IXYd))); break; // RRC (IXYd)	ok
                        case 0x16: Cycle -= 12; MemProvider.Poke(IXYd, Rl(MemProvider.Peek(IXYd))); break; // RL (IXYd)		ok
                        case 0x1E: Cycle -= 12; MemProvider.Poke(IXYd, Rr(MemProvider.Peek(IXYd))); break; // RR (IXYd)		ok
                        case 0x26: Cycle -= 12; MemProvider.Poke(IXYd, Sla(MemProvider.Peek(IXYd))); break; // SLA (IXYd)	ok
                        case 0x2e: Cycle -= 12; MemProvider.Poke(IXYd, Sra(MemProvider.Peek(IXYd))); break; // SRA (IXYd)	ok
                        case 0x36: Cycle -= 12; MemProvider.Poke(IXYd, Sll(MemProvider.Peek(IXYd))); break; // SLL (IXYd)	ok
                        case 0x3e: Cycle -= 12; MemProvider.Poke(IXYd, Srl(MemProvider.Peek(IXYd))); break; // SRL (IXYd)	ok
                        case 0x40:
                        case 0x41:
                        case 0x42:
                        case 0x43:
                        case 0x44:
                        case 0x45:
                        case 0x46:
                        case 0x47: Cycle -= 12; Bit(0, MemProvider.Peek(IXYd)); break;
                        case 0x48:
                        case 0x49:
                        case 0x4a:
                        case 0x4b:
                        case 0x4c:
                        case 0x4d:
                        case 0x4e:
                        case 0x4f: Cycle -= 12; Bit(1, MemProvider.Peek(IXYd)); break;
                        case 0x50:
                        case 0x51:
                        case 0x52:
                        case 0x53:
                        case 0x54:
                        case 0x55:
                        case 0x56:
                        case 0x57: Cycle -= 12; Bit(2, MemProvider.Peek(IXYd)); break;
                        case 0x58:
                        case 0x59:
                        case 0x5a:
                        case 0x5b:
                        case 0x5c:
                        case 0x5d:
                        case 0x5e:
                        case 0x5f: Cycle -= 12; Bit(3, MemProvider.Peek(IXYd)); break;
                        case 0x60:
                        case 0x61:
                        case 0x62:
                        case 0x63:
                        case 0x64:
                        case 0x65:
                        case 0x66:
                        case 0x67: Cycle -= 12; Bit(4, MemProvider.Peek(IXYd)); break;
                        case 0x68:
                        case 0x69:
                        case 0x6a:
                        case 0x6b:
                        case 0x6c:
                        case 0x6d:
                        case 0x6e:
                        case 0x6f: Cycle -= 12; Bit(5, MemProvider.Peek(IXYd)); break;
                        case 0x70:
                        case 0x71:
                        case 0x72:
                        case 0x73:
                        case 0x74:
                        case 0x75:
                        case 0x76:
                        case 0x77: Cycle -= 12; Bit(6, MemProvider.Peek(IXYd)); break;
                        case 0x78:
                        case 0x79:
                        case 0x7a:
                        case 0x7b:
                        case 0x7c:
                        case 0x7d:
                        case 0x7e:
                        case 0x7f: Cycle -= 12; Bit(7, MemProvider.Peek(IXYd)); break;
                        case 0x86: Cycle -= 12; MemProvider.Poke(IXYd, Res(0, MemProvider.Peek(IXYd))); break;
                        case 0x8e: Cycle -= 12; MemProvider.Poke(IXYd, Res(1, MemProvider.Peek(IXYd))); break;
                        case 0x96: Cycle -= 12; MemProvider.Poke(IXYd, Res(2, MemProvider.Peek(IXYd))); break;
                        case 0x9e: Cycle -= 12; MemProvider.Poke(IXYd, Res(3, MemProvider.Peek(IXYd))); break;
                        case 0xa6: Cycle -= 12; MemProvider.Poke(IXYd, Res(4, MemProvider.Peek(IXYd))); break;
                        case 0xae: Cycle -= 12; MemProvider.Poke(IXYd, Res(5, MemProvider.Peek(IXYd))); break;
                        case 0xb6: Cycle -= 12; MemProvider.Poke(IXYd, Res(6, MemProvider.Peek(IXYd))); break;
                        case 0xbe: Cycle -= 12; MemProvider.Poke(IXYd, Res(7, MemProvider.Peek(IXYd))); break;
                        case 0xc6: Cycle -= 12; MemProvider.Poke(IXYd, Set(0, MemProvider.Peek(IXYd))); break;
                        case 0xce: Cycle -= 12; MemProvider.Poke(IXYd, Set(1, MemProvider.Peek(IXYd))); break;
                        case 0xd6: Cycle -= 12; MemProvider.Poke(IXYd, Set(2, MemProvider.Peek(IXYd))); break;
                        case 0xde: Cycle -= 12; MemProvider.Poke(IXYd, Set(3, MemProvider.Peek(IXYd))); break;
                        case 0xe6: Cycle -= 12; MemProvider.Poke(IXYd, Set(4, MemProvider.Peek(IXYd))); break;
                        case 0xee: Cycle -= 12; MemProvider.Poke(IXYd, Set(5, MemProvider.Peek(IXYd))); break;
                        //case 0xf4: cyc-=12; MemProvider.Poke(IXYd,set(6,MemProvider.Peek(IXYd))); // undocumented
                        //						H=MemProvider.Peek(IXYd); break;
                        case 0xf6: Cycle -= 12; MemProvider.Poke(IXYd, Set(6, MemProvider.Peek(IXYd))); break;
                        case 0xfe: Cycle -= 12; MemProvider.Poke(IXYd, Set(7, MemProvider.Peek(IXYd))); break;

                        default: Error(_instruction, _PPC); break; // Not implemented
                    }
                    break;
                case 0xe1: Cycle -= 14; xy = Pop(); break; 					// POP xy	ok
                case 0xe3: Cycle -= 23; tmp1 = PeekW(SP); PokeW(SP, xy); xy = tmp1; break; 	// EX (SP),xy	ok
                case 0xe5: Cycle -= 14; PokeW(SP - 2, xy); SP -= 2; break; 					// PUSH xy	ok
                case 0xe9: Cycle -= 8; PC = xy; break; 				// JP (xy)	ok
                case 0xeb: Cycle -= 8; tmp1 = De(); D = xy >> 8; E = xy & 0xff; xy = tmp1; break; 	// EX De,xy	ok
                case 0xf9: Cycle -= 10; SP = xy; break; 				// LD SP,xy	ok

                default: Error(_instruction, _PPC); break; // Not implemented
            }
            return xy;
        }


        /** NOP */
        private void Nop()
        {
            Cycle -= 4;
        }

        /** LD Bc, nn */
        private void Ld_BC_nn()
        {
            Cycle -= 10;
            C = MemProvider.Peek(PC++);
            B = MemProvider.Peek(PC++);
        }

        /** LD (Bc),a */
        private void Ld_BCi_A()
        {
            Cycle -= 7;
            MemProvider.Poke(Bc(), A);
        }

        /** INC Bc */
        private void Inc_BC()
        {
            Cycle -= 6;
            Bc((Bc() + 1) & 0xffff);
        }

        /** INC B */
        private void Inc_B()
        {
            Cycle -= 4;
            B = Inc8(B);
        }

        /** DEC B */
        private void Dec_B()
        {
            Cycle -= 4;
            B = Dec8(B);
        }

        /** LD B,n */
        private void Ld_B_n()
        {
            Cycle -= 7;
            B = MemProvider.Peek(PC++);
        }

        /** RLCA */
        private void Rlca()
        {
            Cycle -= 4;
            A = Rlc_A(A);
        }

        /** EX Af,Af' */
        public void Ex_AF_AF()
        {
            Cycle -= 4;
            _tmp = A;
            A = A1;
            A1 = _tmp;
            _tmp = F;
            F = F1;
            F1 = _tmp;
        }

        /** ADD Hl,Bc */
        private void Add_HL_BC()
        {
            Cycle -= 11;
            Hl(Add16(Hl(), Bc()));
        }

        /** LD a,(Bc) */
        private void Ld_A_BCi()
        {
            Cycle -= 7;
            A = MemProvider.Peek(Bc());
        }

        /** DEC Bc */
        private void Dec_BC()
        {
            Cycle -= 6;
            Bc((Bc() - 1) & 0xffff);
        }

        /** INC C */
        private void Inc_C()
        {
            Cycle -= 4;
            C = Inc8(C);
        }

        /** DEC C */
        private void Dec_C()
        {
            Cycle -= 4;
            C = Dec8(C);
        }

        /** LD C,n */
        private void Ld_C_n()
        {
            Cycle -= 7;
            C = MemProvider.Peek(PC++);
        }

        /** RRCA */
        private void Rrca()
        {
            Cycle -= 4;
            A = Rrc_A(A);
        }

        /** DJNZ,n */
        private void Djnz_n()
        {
            B = (B - 1) & 0xff;
            if (B != 0)
            {
                Cycle -= 13;
                PC += Sign(MemProvider.Peek(PC));
                PC++;
            }
            else
            {
                Cycle -= 8;
                PC++;
            }
        }

        /** LD De,nn */
        private void Ld_DE_nn()
        {
            Cycle -= 10;
            E = MemProvider.Peek(PC++);
            D = MemProvider.Peek(PC++);
        }

        /** LD (De),a */
        private void Ld_DEi_A()
        {
            Cycle -= 7;
            MemProvider.Poke(De(), A);
        }

        /** INC De */
        private void Inc_DE()
        {
            Cycle -= 6;
            De((De() + 1) & 0xffff);
        }

        /** INC D */
        private void Inc_D()
        {
            Cycle -= 4;
            D = Inc8(D);
        }

        /** DEC D */
        private void Dec_D()
        {
            Cycle -= 4;
            D = Dec8(D);
        }

        /** LD D,n */
        private void Ld_D_n()
        {
            Cycle -= 7;
            D = MemProvider.Peek(PC++);
        }

        /** RLA */
        private void Rla()
        {
            Cycle -= 4;
            A = Rl_A(A);
        }

        /** JR e */
        private void Jr_e()
        {
            Cycle -= 12;
            PC += Sign(MemProvider.Peek(PC));
            PC++;
        }

        /** ADD Hl,De */
        private void Add_HL_DE()
        {
            Cycle -= 11;
            Hl(Add16(Hl(), De()));
        }

        /** LD a,(De) */
        private void Ld_A_DEi()
        {
            Cycle -= 7;
            A = MemProvider.Peek(De());
        }

        /** DEC De */
        private void Dec_DE()
        {
            Cycle -= 6;
            De((De() - 1) & 0xffff);
        }

        /** INC E */
        private void Inc_E()
        {
            Cycle -= 4;
            E = Inc8(E);
        }

        /** DEC E */
        private void Dec_E()
        {
            Cycle -= 4;
            E = Dec8(E);
        }

        /** LD E,n */
        private void Ld_E_n()
        {
            Cycle -= 7;
            E = MemProvider.Peek(PC++);
        }

        /** RRA */
        private void Rra()
        {
            Cycle -= 4;
            A = Rr_A(A);
        }

        /** JR NZ,e */
        private void Jr_NZ_e()
        {
            if ((F & _ZF) == 0)
            {
                Cycle -= 12;
                PC += Sign(MemProvider.Peek(PC));
                PC++;
            }
            else
            {
                PC++;
                Cycle -= 7;
            }
        }

        /** LD Hl,nn */
        private void Ld_HL_nn()
        {
            Cycle -= 10;
            L = MemProvider.Peek(PC++);
            H = MemProvider.Peek(PC++);
        }

        /** LD (nn),Hl */
        private void Ld_ni_HL()
        {
            Cycle -= 16;
            Ld_ea_ind16(Hl());
        }

        /** INC Hl */
        private void Inc_HL()
        {
            Cycle -= 6;
            Hl((Hl() + 1) & 0xffff);
        }

        /** INC H */
        private void Inc_H()
        {
            Cycle -= 4;
            H = Inc8(H);
        }

        /** DEC H */
        private void Dec_H()
        {
            Cycle -= 4;
            H = Dec8(H);
        }

        /** LD H,n */
        private void Ld_H_n()
        {
            Cycle -= 7;
            H = MemProvider.Peek(PC++);
        }

        /** DAA */
        private void Daa()
        {
            Cycle -= 4;
            _tmp1 = A;
            _tmp2 = 0;
            _tmp3 = (F & 1);
            int tmp = _tmp3;
            if (((F & 0x10) != 0) || ((_tmp1 & 0x0f) > 0x09))
            {
                _tmp2 |= 0x06;
            }
            if ((_tmp3 == 1) || (_tmp1 > 0x9f) || ((_tmp1 > 0x8f) && ((_tmp1 & 0x0f) > 0x09)))
            {
                _tmp2 |= 0x60;
                tmp = 1;
            }
            if (_tmp1 > 0x99)
            {
                tmp = 1;
            }
            if ((F & 0x02) != 0)
            {
                Cycle -= 4;
                A = SubA_8(_tmp2, A);
            }
            else
            {
                Cycle -= 4;
                A = AddA_8(_tmp2, A);
            }
            F = (F & 0xfe) | tmp;
            if (_parity[A])
            {
                F = (F & 0xfb) | 4;
            }
            else
            {
                F = (F & 0xfb);
            }
        }

        /** JR Z,e */
        private void Jr_Z_e()
        {
            if ((F & _ZF) != 0)
            {
                Cycle -= 12;
                PC += Sign(MemProvider.Peek(PC));
                PC++;
            }
            else
            {
                PC++;
                Cycle -= 7;
            }
        }

        /** ADD Hl,Hl */
        private void Add_HL_HL()
        {
            Cycle -= 11;
            int hl = Hl();
            Hl(Add16(hl, hl));
        }

        /** LD Hl,(nn) */
        private void Ld_HL_ni()
        {
            Cycle -= 16;
            int ea = PeekW(PC);
            H = MemProvider.Peek(ea + 1);
            L = MemProvider.Peek(ea);
            PC += 2;
        }

        /** DEC Hl */
        private void Dec_HL()
        {
            Cycle -= 6;
            Hl((Hl() - 1) & 0xffff);
        }

        /** INC L */
        private void Inc_L()
        {
            Cycle -= 4;
            L = Inc8(L);
        }

        /** DEC L */
        private void Dec_L()
        {
            Cycle -= 4;
            L = Dec8(L);
        }

        /** LD L,n */
        private void Ld_L_n()
        {
            Cycle -= 7;
            L = MemProvider.Peek(PC++);
        }

        /** CPL */
        private void Cpl()
        {
            Cycle -= 4;
            A ^= 0xff;
            F = (F & (0xc5)) | 0x12 | (A & (0x28));
        }

        /** JR NC,e */
        private void Jr_NC_e()
        {
            if ((F & _CF) == 0)
            {
                Cycle -= 12;
                PC += Sign(MemProvider.Peek(PC));
                PC++;
            }
            else
            {
                PC++;
                Cycle -= 7;
            }
        }

        /** LD SP,nn */
        private void Ld_SP_nn()
        {
            Cycle -= 10;
            SP = PeekW(PC);
            PC += 2;
        }

        /** LD (nn),a */
        private void Ld_ni_A()
        {
            Cycle -= 13;
            Ld_ea_ind8(A);
        }

        /** INC SP */
        private void Inc_SP()
        {
            Cycle -= 6;
            SP = (SP + 1) & 0xffff;
        }

        /** INC (Hl) */
        private void Inc_HLi()
        {
            Cycle -= 11;
            int hl = Hl();
            MemProvider.Poke(hl, Inc8(MemProvider.Peek(hl)));
        }

        /** DEC (Hl) */
        private void Dec_HLi()
        {
            Cycle -= 11;
            int hl = Hl();
            MemProvider.Poke(hl, Dec8(MemProvider.Peek(hl)));
        }

        /** LD (Hl),n */
        private void Ld_HLi_n()
        {
            Cycle -= 10;
            MemProvider.Poke(Hl(), MemProvider.Peek(PC++));
        }

        /** SCF */
        private void Scf()
        {
            Cycle -= 4;
            F = (F & 0xc4) | 1 | (A & (0x28));
        }

        /** JR C,e */
        private void Jr_C_e()
        {
            if ((F & _CF) != 0)
            {
                Cycle -= 12;
                PC += Sign(MemProvider.Peek(PC));
                PC++;
            }
            else
            {
                PC++;
                Cycle -= 7;
            }
        }

        /** ADD Hl,SP */
        private void Add_HL_SP()
        {
            Cycle -= 11;
            Hl(Add16(Hl(), SP));
        }

        /** LD a,(nn) */
        private void Ld_A_ni()
        {
            Cycle -= 13;
            A = MemProvider.Peek(PeekW(PC));
            PC += 2;
        }

        /** DEC SP */
        private void Dec_SP()
        {
            Cycle -= 6;
            SP = (SP - 1) & 0xffff;
        }

        /** INC a */
        private void Inc_A()
        {
            Cycle -= 4;
            A = Inc8(A);
        }

        /** DEC a */
        private void Dec_A()
        {
            Cycle -= 4;
            A = Dec8(A);
        }

        /** LD a,n */
        private void Ld_A_n()
        {
            Cycle -= 7;
            A = MemProvider.Peek(PC++);
        }

        /** CCF */
        private void Ccf()
        {
            Cycle -= 4;
            F = ((F & 0xc5) | ((F & 1) << 4) | (A & 0x28)) ^ 1;
        }

        /** HALT */
        private void Halt()
        {
            Cycle -= 4;
            state_HALT = true;
            //goingToirq = false;
            //PC--;
            Cycle = 0;
        }

        /** RET NZ */
        private void Ret_NZ()
        {
            if ((F & _ZF) == 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** POP Bc */
        private void Pop_BC()
        {
            Cycle -= 10;
            C = MemProvider.Peek(SP++);
            B = MemProvider.Peek(SP++);
        }

        /** JP NZ,nn */
        private void Jp_NZ_nn()
        {
            Cycle -= 10;
            if ((F & _ZF) == 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** JP nn */
        private void Jp_nn()
        {
            Cycle -= 10;
            PC = PeekW(PC);
        }

        /** CALL NZ,nn */
        private void Call_NZ_nn()
        {
            if ((F & _ZF) == 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** PUSH Bc */
        private void Push_BC()
        {
            Cycle -= 11;
            Push(Bc());
        }

        /** ADD a,n */
        private void Add_A_n()
        {
            Cycle -= 7;
            A = AddA_8(MemProvider.Peek(PC++), A);
        }

        /** RET Z */
        private void Ret_Z()
        {
            if ((F & _ZF) != 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** RET */
        private void Ret()
        {
            Cycle -= 10;
            PC = Pop();
        }

        /** JP Z,nn */
        private void Jp_Z_nn()
        {
            Cycle -= 10;
            if ((F & _ZF) != 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** CALL Z,nn */
        private void Call_Z_nn()
        {
            if ((F & _ZF) != 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** CALL nn */
        private void Call_nn()
        {
            Cycle -= 17;
            Push(PC + 2);
            PC = PeekW(PC);
        }

        /** ADC a,n */
        private void adc_A_n()
        {
            Cycle -= 7;
            A = AdcA_8(MemProvider.Peek(PC++), A);
        }

        /** RET NC */
        private void Ret_NC()
        {
            if ((F & _CF) == 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** POP De */
        private void Pop_DE()
        {
            Cycle -= 10;
            E = MemProvider.Peek(SP++);
            D = MemProvider.Peek(SP++);
        }

        /** JP NC,nn */
        private void Jp_NC_nn()
        {
            Cycle -= 10;
            if ((F & _CF) == 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** OUT (n),a */
        private void out_n_A()
        {
            Cycle -= 11;
            PortOut(MemProvider.Peek(PC++), A);
        }

        /** CALL NC, nn */
        private void Call_NC_nn()
        {
            if ((F & _CF) == 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** PUSH De */
        private void Push_DE()
        {
            Cycle -= 11;
            Push(De());
        }

        /** SUB a,n */
        private void sub_A_n()
        {
            Cycle -= 7;
            A = SubA_8(MemProvider.Peek(PC++), A);
        }

        /** RET C */
        private void Ret_C()
        {
            if ((F & _CF) != 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** EXX */
        public void Exx()
        {
            Cycle -= 4;
            _tmp = B;
            B = B1;
            B1 = _tmp;
            _tmp = C;
            C = C1;
            C1 = _tmp;
            _tmp = D;
            D = D1;
            D1 = _tmp;
            _tmp = E;
            E = E1;
            E1 = _tmp;
            _tmp = H;
            H = H1;
            H1 = _tmp;
            _tmp = L;
            L = L1;
            L1 = _tmp;
        }

        /** JP C,nn */
        private void Jp_C_nn()
        {
            Cycle -= 10;
            if ((F & _CF) != 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /* IN a,(n) */
        private void In_A_n()
        {
            Cycle -= 11;
            A = PortIn(MemProvider.Peek(PC++), A);
        }

        /** CALL C,nn */
        private void Call_C_nn()
        {
            if ((F & _CF) != 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** SBC a,n */
        private void Sbc_A_n()
        {
            Cycle -= 7;
            A = SbcA_8(MemProvider.Peek(PC++), A);
        }

        /** RET PO */
        private void Ret_PO()
        {
            if ((F & _PF) == 0)
            {
                Cycle -= 11;
                PC = PeekW(SP);
                SP += 2;
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** POP Hl */
        private void Pop_HL()
        {
            Cycle -= 10;
            L = MemProvider.Peek(SP++);
            H = MemProvider.Peek(SP++);
        }

        /** JP PO,nn */
        private void Jp_PO_nn()
        {
            Cycle -= 10;
            if ((F & _PF) == 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** EX (SP),Hl */
        private void Ex_SPi_HL()
        {
            Cycle -= 19;
            _tmp = MemProvider.Peek(SP + 1);
            MemProvider.Poke(SP + 1, H);
            H = _tmp;
            _tmp = MemProvider.Peek(SP);
            MemProvider.Poke(SP, L);
            L = _tmp;
        }

        /** CALL PO,nn */
        private void Call_PO_nn()
        {
            if ((F & _PF) == 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** PUSH Hl */
        private void Push_HL()
        {
            Cycle -= 11;
            Push(Hl());
        }

        /** AND a,n */
        private void And_A_n()
        {
            Cycle -= 7;
            A = AndA(MemProvider.Peek(PC++), A);
        }

        /** RET PE */
        private void Ret_PE()
        {
            if ((F & _PF) != 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** JP (Hl) */
        private void Jp_HLi()
        {
            Cycle -= 4;
            PC = Hl();
        }

        /** JP PE,nn */
        private void Jp_PE_nn()
        {
            Cycle -= 10;
            if ((F & _PF) != 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** EX De,Hl */
        private void Ex_DE_HL()
        {
            Cycle -= 4;
            _tmp = D;
            D = H;
            H = _tmp;
            _tmp = E;
            E = L;
            L = _tmp;
        }

        /** CALL PE,nn */
        private void Call_PE_nn()
        {
            if ((F & _PF) != 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }


        /** XOR a,n */
        private void Xor_n()
        {
            Cycle -= 7;
            A = XorA(MemProvider.Peek(PC++), A);
        }

        /** RET P */
        private void Ret_P()
        {
            if ((F & _SF) == 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** POP Af */
        private void Pop_AF()
        {
            Cycle -= 10;
            F = MemProvider.Peek(SP++);
            A = MemProvider.Peek(SP++);
        }

        /** JP P,nn */
        private void Jp_P_nn()
        {
            Cycle -= 10;
            if ((F & _SF) == 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** DI */
        private void Di()
        {
            Cycle -= 4;
            IFF0 = IFF1 = false;
        }

        /** CALL P,nn */
        private void Call_P_nn()
        {
            if ((F & _SF) == 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** PUSH Af */
        private void Push_AF()
        {
            Cycle -= 11;
            Push(Af());
        }

        /** OR a,n */
        private void Or_n()
        {
            Cycle -= 7;
            A = OrA(MemProvider.Peek(PC++), A);
        }

        /** RET M */
        private void Ret_M()
        {
            if ((F & _SF) != 0)
            {
                Cycle -= 11;
                PC = Pop();
            }
            else
            {
                Cycle -= 5;
            }
        }

        /** LD SP,Hl */
        private void Ld_SP_HL()
        {
            Cycle -= 6;
            SP = Hl();
        }

        /** JP M,nn */
        private void Jp_M_nn()
        {
            Cycle -= 10;
            if ((F & _SF) != 0)
            {
                PC = PeekW(PC);
            }
            else
            {
                PC += 2;
            }
        }

        /** EI */
        private void Ei()
        {
            Cycle -= 4;
            IFF0 = IFF1 = true;
            //goingToirq = true;
            Cycle = CheckInterrupt(Cycle);
        }

        /** CALL M,nn */
        private void Call_M_nn()
        {
            if ((F & _SF) != 0)
            {
                Cycle -= 17;
                Push(PC + 2);
                PC = PeekW(PC);
            }
            else
            {
                Cycle -= 10;
                PC += 2;
            }
        }

        /** CP a,n */
        private void Cp_n()
        {
            Cycle -= 7; CpA_8(MemProvider.Peek(PC++), A);
        }

        private int Af() => (A << 8) | F;

        private int Bc() => (B << 8) | C;

        private int De() => (D << 8) | E;

        private int Hl() => (H << 8) | L;

        private int HLi()
        {
            return MemProvider.Peek(Hl());
        }

        public void Af(int nn)
        {
            A = nn >> 8;
            F = nn & 0xff;
        }
        public void Bc(int nn)
        {
            B = nn >> 8;
            C = nn & 0xff;
        }

        public void De(int nn)
        {
            D = nn >> 8;
            E = nn & 0xff;
        }

        public void Ix(int nn) => IX = nn & 0xffff;

        public void Iy(int nn) => IY = nn & 0xffff;

        public void Hl(int nn)
        {
            H = nn >> 8;
            L = nn & 0xff;
        }

        private void Push(int nn)
        {
            SP = (SP - 2) & 0xffff;
            PokeW(SP, nn);
        }

        public int Pop()
        {
            int nn = PeekW(SP);
            SP = (SP + 2) & 0xffff;
            return nn;
        }

        private int Sign(int nn) => nn - ((nn & 128) << 1);

        private void Rst(int ea)
        {
            Cycle -= 11;
            Push(PC);
            PC = ea;
        }

        private void Ld_A(int n, int cycles)
        {
            Cycle -= cycles;
            A = n;
        }

        private void Ld_B(int n, int cycles)
        {
            Cycle -= cycles;
            B = n;
        }

        private void Ld_C(int n, int cycles)
        {
            Cycle -= cycles;
            C = n;
        }

        private void Ld_D(int n, int cycles)
        {
            Cycle -= cycles;
            D = n;
        }

        private void Ld_E(int n, int cycles)
        {
            Cycle -= cycles;
            E = n;
        }

        private void Ld_H(int n, int cycles)
        {
            Cycle -= cycles;
            H = n;
        }

        private void Ld_L(int n, int cycles)
        {
            Cycle -= cycles;
            L = n;
        }

        private void Ld_HLi(int n, int cycles)
        {
            Cycle -= cycles;
            MemProvider.Poke(Hl(), n);
        }

        /** LD (ea),nn */
        private void Ld_ea_ind16(int nn)
        {
            PokeW(PeekW(PC), nn);
            PC += 2;
        }

        /** LD (ea),n */
        private void Ld_ea_ind8(int n)
        {
            MemProvider.Poke(PeekW(PC), n);
            PC += 2;
        }

        /**
         * Add value to Accu and set flags accordingly
         */
        private int AddA_8(int value, int a)
        {
            _tmp = (a + value) & 0xff;
            F = _SZHVC_Add[(a << 8) | _tmp];
            return _tmp;
        }

        /**
         * Add to accu and count cycles
         */
        private void Add_A(int n, int c)
        {
            Cycle -= c;
            A = AddA_8(n, A);
        }

        /**
         * Add value with carry to Accu and set flags accordingly
         */
        private int AdcA_8(int value, int a)
        {
            int c = F & 1;
            int result = (a + value + c) & 0xff;
            F = _SZHVC_Add[(c << 16) | (a << 8) | result];
            return result;
        }

        /**
         * Add to accu and count cycles
         */
        private void Adc_A(int n, int c)
        {
            Cycle -= c;
            A = AdcA_8(n, A);
        }

        /**
         * 8 bit increment
         */
        private int Inc8(int value)
        {
            value = (value + 1) & 0xff;
            F = (F & 1) | _SZHV_inc[value];
            return value;
        }

        /**
         * 8 bit decrement
         */
        private int Dec8(int value)
        {
            value = (value - 1) & 0xff;
            F = (F & 1) | _SZHV_dec[value];
            return (value);
        }

        /**
         * Compare value with Accu
         */
        private void CpA_8(int value, int a)
        {
            int result = (a - value) & 0xff;
            F = _SZHVC_sub[(a << 8) | result];
        }

        /**
         * Compare with accu and count cycles
         */
        private void Cp_A(int n, int c)
        {
            Cycle -= c;
            CpA_8(n, A);
        }

        /**
         * Subtract value from Accu and set flags accordingly
         */
        private int SubA_8(int value, int a)
        {
            int result = (a - value) & 0xff;
            F = _SZHVC_sub[(a << 8) | result];
            return result;
        }

        /**
         * Subtract from accu and count cycles
         */
        private void Sub_A(int n, int c)
        {
            Cycle -= c;
            A = SubA_8(n, A);
        }

        /**
         * Subtract value with carry from Accu and set flags accordingly
         */
        private int SbcA_8(int value, int a)
        {
            int c = F & 1;
            int result = (a - value - c) & 0xff;
            F = _SZHVC_sub[(c << 16) | (a << 8) | result];
            return result;
        }

        /**
         * Subtract from accu and count cycles
         */
        private void Sbc_A(int n, int c)
        {
            Cycle -= c;
            A = SbcA_8(n, A);
        }

        /**
         * 16bit Add
         */
        private int Add16(int a, int b)
        {
            int result = a + b;
            F = (F & 0xc4) | (((a ^ result ^ b) >> 8) & 0x10) | ((result >> 16) & 1);
            return (result & 0xffff);
        }

        /**
         * SBC Hl,nn
         */
        private void SbcHl(int value)
        {
            int hld = Hl();
            int result = hld - value - (F & 1);
            F = (((hld ^ result ^ value) >> 8) & 0x10) | 0x02 | ((result >> 16) & 1) | ((result >> 8) & 0x80) | (((result & 0xffff) != 0) ? 0 : 0x40) | (((value ^ hld) & (hld ^ result) & 0x8000) >> 13);
            H = (result >> 8) & 0xff;
            L = result & 0xff;
        }

        /**
         * ADC Hl,nn
         */
        private void AdcHl(int value)
        {
            int hld = Hl();
            int result = hld + value + (F & 1);
            F = (((hld ^ result ^ value) >> 8) & 0x10) | ((result >> 16) & 1) | ((result >> 8) & 0x80) | (((result & 0xffff) != 0) ? 0 : 0x40) | (((value ^ hld ^ 0x8000) & (value ^ result) & 0x8000) >> 13);
            H = (result >> 8) & 0xff;
            L = result & 0xff;
        }

        /**
         * Shift right	- ok
         */
        private int Srl(int value)
        {
            int c = value & 0x01;
            value = (value >> 1) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * Shift left	- ok
         */
        private int Sla(int value)
        {
            int c = (value & 0x80) >> 7;
            value = (value << 1) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * Shift left and insert a 1
         */
        private int Sll(int value)
        {
            int c = (value & 0x80) >> 7;
            value = ((value << 1) | 1) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * Shift right while keeping the correct sign
         */
        private int Sra(int value)
        {
            int c = value & 0x01;
            value = (value >> 1) | (value & 128);
            F = _SZP[value] | c;
            return value;
        }

        /**
         * 9-bit left rotate	- ok
         */
        private int Rl(int value)
        {
            int c = (value & 0x80) >> 7;
            value = ((value << 1) | (F & 1)) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * 9-bit left rotate a	- ok
         */
        private int Rl_A(int a)
        {
            int old = a;
            a = ((a << 1) | (F & 1)) & 0xff; 						// rotate
            F = (F & 0xec) | (old >> 7);
            return a;
        }

        /**
         * 9-bit right rotate
         */
        private int Rr(int value)
        {
            int c = (value & 0x01);
            value = ((value >> 1) | (F << 7)) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * 9-bit right rotate a
         */
        private int Rr_A(int a)
        {
            int old = a;
            a = ((a >> 1) | (F & 1) << 7) & 0xff; 					// rotate
            F = (F & 0xec) | (old & 1);
            return a;
        }

        /**
         * left rotate	- ok
         */
        private int Rlc(int value)
        {
            int c = (value & 0x80) >> 7;
            value = ((value << 1) | (value >> 7)) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * left rotate	- ok
         */
        private int Rlc_A(int a)
        {
            F = (F & 0xec) | (a >> 7);
            //F = (F & 0xc5) | ((a >> 7) | (a & 0x28));		// including undocumented flags
            return ((a << 1) + ((a & 128) >> 7)) & 0xff; 				// rotate
        }

        /**
         * right rotate	- ok
         */
        private int Rrc(int value)
        {
            int c = (value & 0x01);
            value = ((value >> 1) | (value << 7)) & 0xff;
            F = _SZP[value] | c;
            return value;
        }

        /**
         * right rotate	a - ok
         */
        private int Rrc_A(int a)
        {
            F = (F & 0xec) | (a & 0x29);
            return ((a >> 1) + ((a & 1) << 7)) & 0xff; 				// rotate
        }

        /**
         * RLD
         */
        private int rld_A(int a, int h, int l)
        {
            int result = a;
            int t = MemProvider.Peek(Hl());
            int q = t;

            t = (t << 4) | (result & 0x0f);
            result = (result & 0xf0) | (q >> 4);
            MemProvider.Poke(Hl(), (t & 0xff));

            F = (F & 1) | _SZP[result];

            return result;
        }

        /**
         * RRD
         */
        private int rrd_A(int a, int h, int l)
        {
            int result = a;
            int t = MemProvider.Peek(Hl());
            int q = t;

            t = (t >> 4) | (result << 4);
            result = (result & 0xf0) | (q & 0x0f);
            MemProvider.Poke(Hl(), t & 0xff);

            F = (F & 1) | _SZP[result];

            return result;
        }

        /**
         * test specified bit - ok
         */
        private void Bit(int bitNumber, int value)
        {
            F = (F & 1) | 0x10 | _SZ_BIT[value & BitSet[bitNumber]];
        }

        /**
         * set specified bit	- ok
         */
        private int Set(int bitNumber, int value)
        {
            value = value | BitSet[bitNumber];
            return value;
        }

        /**
         * reset specified bit	- ok
         */
        private int Res(int bitNumber, int value)
        {
            value = value & BitRes[bitNumber];
            return value;
        }

        /**
         * AND	- ok
         */
        private int AndA(int value, int a)
        {
            a &= value;
            F = _SZP[a] | 0x10;
            return a;
        }

        private void And_A(int n, int c)
        {
            Cycle -= c;
            A = AndA(n, A);
        }

        /**
         * OR	- ok
         */
        private int OrA(int value, int a)
        {
            a |= value;
            F = _SZP[a];
            return a;
        }

        private void Or_A(int n, int c)
        {
            Cycle -= c;
            A = OrA(n, A);
        }

        /**
         * XOR - ok
         */
        private int XorA(int value, int a)
        {
            a ^= value;
            F = _SZP[a];
            return a;
        }

        private void Xor_A(int n, int c)
        {
            Cycle -= c;
            A = XorA(n, A);
        }

        /**
         * OUT
         */
        private void PortOut(int port, int value)
        {
            PortProvider.OutB(port, value, 0);
        }

        private void PortOut(int port, int value, int state)
        {
            PortProvider.OutB(port, value, state);
        }
        /**
         * IN
         */
        private int PortIn(int port, int hi)
        {
            int portIn = PortProvider.InB(port, hi);
            F = (F & 1) | _SZP[A];
            return portIn;
        }

        public int PeekW(int add)
        {
            int value = MemProvider.Peek(add);
            value |= MemProvider.Peek(add + 1) << 8;

            return value;
        }

        public void PokeW(int add, int value)
        {
            MemProvider.Poke(add, value);
            MemProvider.Poke(add + 1, value >> 8);
        }

        /**
         * Undocumented
         */
        private int IncL16(int value)
        {
            return (value & 0xff00) | Inc8(value & 0xff);
        }

        private int DecL16(int value)
        {
            return (value & 0xff00) | Dec8(value & 0xff);
        }

        private int LdXYH_8(int val16, int val8)
        {
            return (val16 & 0xff) | (val8 << 8);
        }

        private int LdXYL_8(int val16, int val8)
        {
            return (val16 & 0xff00) | val8;
        }


        /**
         * R access
         */
        private int R()
        {
            return (_R & 0xff);
        }

        /**
         * check interrupt
         */
        private int CheckInterrupt(int cyc)
        {
            if (NMI || (IFF0 && IRQ))
            {
                if (NMI)
                { // Take NMI
                    //if (!goingToirq) {
                    //FLogFile.WriteLine("...CPUZ80 takes non maskable interrupt");
                    state_HALT = false;

                    IFF1 = IFF0;
                    NMI = IFF0 = false;

                    Push(PC);
                    PC = 0x0066; 					// ...and jump to 0x0066

                    cyc -= 13;
                    //} else {
                    //   goingToirq = false; /* CPU has to execute 1 more inst */
                    //}
                }

                if (IFF0 && IRQ)
                {	// Take interrupt if enabled
                    //FLogFile.WriteLine("...CPUZ80 takes interrupt using interrupt mode " + IM);
                    state_HALT = false;

                    switch (IM)
                    {
                        case 0:	// IM0  --> exec 1-byte inst. Only calls are supported.
                            IRQ = IFF0 = false;
                            Push(PC);
                            if (I_Vector == 0 || I_Vector == 255) { PC = 0x0038; } else { PC = I_Vector; }
                            cyc -= 13;
                            break;
                        case 1:	// IM1	--> RST &38
                            IRQ = IFF0 = false;
                            Push(PC);
                            PC = 0x0038;
                            cyc -= 13; // RST &38 = 11 cycles    + 2 cycles
                            break;
                        case 2:	// IM2  --> Call I:Vector
                            IRQ = IFF0 = false;
                            Push(PC);
                            PC = PeekW((I << 8) | I_Vector);
                            cyc = cyc - 19; // Call = 17 cycles    + 2 cycles
                            break;
                    }
                    //} else {
                    //	goingToirq = false; // CPU has to execute 1 more inst
                    //}
                }
            }
            return cyc;
        }
        /**
         * Illegal inst
         */
        private void Error(int inst, int address)
        {
            Console.WriteLine($"CPU error: illegal inst ${inst:X} at ${address:X}");
            Environment.Exit(1);
        }

        //private void debug(int inst, int _PPC, int a, int F, int B, int C, int D, int E,
        //                   int H, int L, int SP, int Ix, int IY, int I, int cycles)
        //{

        //    if (_PPC == debugBreakPoint)
        //    {
        //        debugEnabled = true;
        //    }

        //    if (debugEnabled)
        //    {
        //        if (startSlice)
        //        {
        //            Console.WriteLine("*** " + tag + " ***");
        //            startSlice = false;
        //        }
        //        int opcgroup = inst & 65280;
        //        String dataLog = string.Format("{0:X} : {1:X},{2:X},{3:X},{4:X}    \t",
        //            _PPC,
        //            MemProvider.Peek(_PPC),
        //            MemProvider.Peek(_PPC + 1),
        //            MemProvider.Peek(_PPC + 2),
        //            MemProvider.Peek(_PPC + 3)
        //        );
        //        if (inst < 256)
        //        {
        //            dataLog = dataLog + Z80Debug.OpCode1[inst];
        //        }
        //        else if (opcgroup == (237 << 8))
        //        {
        //            dataLog = dataLog + Z80Debug.OpCode3[(inst & 0xff)];
        //        }
        //        else if (opcgroup == (203 << 8))
        //        {
        //            dataLog = dataLog + Z80Debug.OpCode2[(inst & 0xff)];
        //        }
        //        dataLog = dataLog + string.Format("   Af:{0:X} Bc:{1:X} De:{2:X} Hl:{3:X} SP:{4:X} Ix:{5:X} IY:{6:X} I:{7:X} Cycles:{8}",
        //            Af(),
        //            Bc(),
        //            De(),
        //            Hl(),
        //            SP,
        //            Ix,
        //            IY,
        //            I,
        //            cycles);
        //        Console.WriteLine(dataLog);
        //    }
        //}

    } // end class declaration

}