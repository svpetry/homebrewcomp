using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace E_Z80
{
    public class Emulator
    {
        private Z80 FCpu;
        private MemoryMapper FMemoryMapper;
        private PortMapper FPortMapper;
        private Ram FRam;

        private bool FInterruptIrq;
        private bool FInterruptNmi;
        private bool FStop;
        private Task FMainTask;

        public Emulator()
        {
            FMemoryMapper = new MemoryMapper();
            FPortMapper = new PortMapper();
            FCpu = new Z80 { MemProvider = FMemoryMapper, PortProvider = FPortMapper };

            FRam = new Ram();
            FMemoryMapper.Register(0, 0xffff, FRam);
        }

        private void ExecutionLoop()
        {
            while (!FStop)
            {
                FCpu.Exec(1);
                if (FInterruptIrq)
                {
                    FCpu.Interrupt(Z80.INTERRUPT_TYPE_IRQ, true);
                    FInterruptIrq = false;
                }
                if (FInterruptNmi)
                {
                    FCpu.Interrupt(Z80.INTERRUPT_TYPE_NMI, true);
                    FInterruptNmi = false;
                }
            }
        }

        public void Start()
        {
            FStop = false;
            FMainTask = new Task(ExecutionLoop);
            FMainTask.Start();
        }

        public void Stop()
        {
            FStop = true;
        }

        public void InterruptIrq()
        {
            FInterruptIrq = true;
        }

        public void InterruptNmi()
        {
            FInterruptNmi = true;
        }
    }
}
