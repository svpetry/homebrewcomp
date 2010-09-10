using System;
using System.Collections.Generic;
using System.Text;

namespace EZ80
{
    class CRegisters
    {
        #region member variables

        // special purpose registers
        public ushort IX;
        public ushort IY;
        public ushort SP;
        public ushort IP;
        public byte I;
        public byte R;
        public byte F;
        public byte F_;

        // general purpose registers
        public byte A;
        public byte A_;
        public byte B;
        public byte B_;
        public byte C;
        public byte C_;
        public byte D;
        public byte D_;
        public byte E;
        public byte E_;
        public byte H;
        public byte H_;
        public byte L;
        public byte L_;

        #endregion

        #region properties

        public ushort HL
        {
            get
            {
                return (ushort) (L + (H << 8));
            }
            set
            {
                L = (byte) (value & 0xFF);
                H = (byte) ((value & 0xFF00) >> 8);
            }
        }

        public ushort BC
        {
            get
            {
                return (ushort)(C + (B << 8)); // Todo: Korrekt?
            }
            set
            {
                C = (byte)(value & 0xFF);
                B = (byte)((value & 0xFF00) >> 8);
            }
        }

        public ushort DE
        {
            get
            {
                return (ushort)(E + (D << 8)); // Todo: Korrekt?
            }
            set
            {
                E = (byte)(value & 0xFF);
                D = (byte)((value & 0xFF00) >> 8);
            }
        }

        // flags

        // The carry flag, set if there was a carry after the most significant bit.
        public bool CF
        {
            get
            {
                return (F & 0x01) > 0;
            }
            set
            {
                if (value)
                    F |= 0x01;
                else
                    F &= 0xFE;
            }
        }

        // Shows whether the last operation was an addition (0) or an subtraction (1).
        // This information is needed for DAA.
        public bool NF
        {
            get
            {
                return (F & 0x02) > 0;
            }
            set
            {
                if (value)
                    F |= 0x02;
                else
                    F &= 0xFF - 0x02;
            }
        }

        // This flag can either be the parity of the result (PF), or the
        // 2-compliment signed overflow (VF): set if 2-compliment value doesn't fit in the register.
        public bool PF
        {
            get
            {
                return (F & 0x04) > 0;
            }
            set
            {
                if (value)
                    F |= 0x04;
                else
                    F &= 0xFF - 0x04;
            }
        }

        // The half-carry of an addition/subtraction (from bit 3 to 4).
        // Needed for BCD correction with DAA.
        public bool HF
        {
            get
            {
                return (F & 0x10) > 0;
            }
            set
            {
                if (value)
                    F |= 0x10;
                else
                    F &= 0xFF - 0x10;
            }
        }

        // Set if the result is zero.
        public bool ZF
        {
            get
            {
                return (F & 0x40) > 0;
            }
            set
            {
                if (value)
                    F |= 0x40;
                else
                    F &= 0xFF - 0x40;
            }
        }

        // Set if the 2-complement value is negative. It's simply a copy of the most significant bit.
        public bool SF 
        {
            get
            {
                return (F & 0x80) > 0;
            }
            set
            {
                if (value)
                    F |= 0x80;
                else
                    F &= 0xFF - 0x80;
            }
        }

        #endregion

        #region public methods

        public byte GetReg(byte _r)
        {
            switch(_r)
            {
                case 0:
                    return B;
                case 1:
                    return C;
                case 2:
                    return D;
                case 3:
                    return E;
                case 4:
                    return H;
                case 5:
                    return L;
                case 7:
                    return A;
                default:
                    return 0;
            }
        }
        
        public void SetReg(byte _r, byte _v)
        {
            switch (_r)
            {
                case 0:
                    B = _v;
                    break;
                case 1:
                    C = _v;
                    break;
                case 2:
                    D = _v;
                    break;
                case 3:
                    E = _v;
                    break;
                case 4:
                    H = _v;
                    break;
                case 5:
                    L = _v;
                    break;
                case 7:
                    A = _v;
                    break;
            }
        }

        public ushort GetPair(byte _d)
        {
            switch (_d)
            {
                case 0:
                    return BC;
                case 1:
                    return DE;
                case 2:
                    return HL;
                case 3:
                    return SP;
                default:
                    return 0;
            }
        }

        public void SetPair(byte _d, ushort _v)
        {
            switch (_d)
            {
                case 0:
                    BC = _v;
                    break;
                case 1:
                    DE = _v;
                    break;
                case 2:
                    HL = _v;
                    break;
                case 3:
                    SP = _v;
                    break;
            }
        }

        #endregion

    }
}
