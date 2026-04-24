//
// Created by os on 5/17/24.
//

#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/MySemaphore.hpp"
#include "../h/printing.hpp"

void Riscv::popSppSpie()
{
    mc_sstatus(BitMaskSstatus::SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap()
{
    uint64 volatile  a1, a2, a3, a4;
    __asm__ volatile("mv %0, a1" : "=r" (a1));
    __asm__ volatile("mv %0, a2" : "=r" (a2));
    __asm__ volatile("mv %0, a3" : "=r" (a3));
    __asm__ volatile("mv %0, a4" : "=r" (a4));

    uint64 scause = r_scause();

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {

        uint64 volatile sepc = r_sepc() + 4;
        uint64 volatile sstatus = r_sstatus();

        uint64 volatile number;
        __asm__ volatile("mv %0, a0" : "=r" (number));

        if(number == 0x01)
        {
            uint64 volatile numberOfBlocks = (uint64 volatile) a1;
            //__asm__ volatile("mv %0, a1" : "=r" (numberOfBlocks));

            void* volatile ptr = nullptr;


            ptr = MemoryAllocator::getInstance()->mem_alloc(numberOfBlocks);

            __asm__ volatile("mv a0, %0" : : "r" (ptr));
            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x02)
        {
            void* volatile address = (void* volatile) a1;
            int volatile returnValue;

            //__asm__ volatile("mv %0, a1" : "=r" (address));

            returnValue = MemoryAllocator::getInstance()->mem_free(address);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x11)
        {
            thread_t* volatile handle = (thread_t* volatile) a1;
            TCB::Body volatile start_routine = (TCB::Body volatile) a2;
            void* volatile arg = (void* volatile)a3;
            void* volatile stack = (void* volatile)a4;
            int volatile returnValue;

            returnValue = TCB::thread_create(handle, start_routine, arg, stack);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x12)
        {
            int volatile returnValue;

            returnValue = TCB::thread_exit();

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x13)
        {
            TCB::thread_dispatch();
        }

        else if(number == 0x14)
        {
            thread_t volatile handle = (thread_t volatile) a1;
            char* volatile msg = (char* volatile) a2;

            TCB::send(handle, msg);
        }

        else if(number == 0x15)
        {
            char* volatile returnValue;

            returnValue = TCB::receive();

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x21)
        {
            int volatile returnValue;

            sem_t* volatile handle = (sem_t * volatile) a1;
            unsigned volatile init = (unsigned volatile) a2;

            returnValue = MySemaphore::sem_open(handle, init);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x22)
        {
            int volatile returnValue;

            sem_t volatile handle = (sem_t volatile) a1;

            returnValue = MySemaphore::sem_close(handle);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x23)
        {
            int volatile returnValue;

            sem_t volatile id = (sem_t volatile) a1;

            returnValue = MySemaphore::sem_wait(id);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x24)
        {
            int volatile returnValue;

            sem_t volatile id = (sem_t volatile) a1;

            returnValue = MySemaphore::sem_signal(id);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x26)
        {
            int volatile returnValue;

            sem_t volatile id = (sem_t volatile) a1;

            returnValue = MySemaphore::sem_trywait(id);

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x41)
        {
            char volatile returnValue;

            returnValue = __getc();

            __asm__ volatile("mv a0, %0" : : "r" (returnValue));

            __asm__ volatile("sd a0, 80(fp)");
        }

        else if(number == 0x42)
        {
            char volatile character = (char volatile) a1;

            __putc(character);
        }

        w_sstatus(sstatus);
        w_sepc(sepc);

    }
    else if (scause == 0x8000000000000001UL)
    {
        // interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
        mc_sip(SIP_SSIP);
        //printString("j");
        //TCB::timeSliceCounter++;
        //if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
        //{
        //    uint64 volatile sepc = r_sepc();
        //    uint64 volatile sstatus = r_sstatus();
        //    TCB::timeSliceCounter = 0;
        //    TCB::dispatch();
        //    w_sstatus(sstatus);
        //    w_sepc(sepc);
        //}
    }
    else if (scause == 0x8000000000000009UL)
    {
        // interrupt: yes; cause code: supervisor external interrupt (PLIC; could be keyboard)
        console_handler();
    }
    else
    {
        // unexpected trap cause
        printString("Error");
        while(1);
    }
}