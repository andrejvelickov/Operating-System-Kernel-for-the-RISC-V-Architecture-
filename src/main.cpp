//
// Created by os on 5/17/24.
//

#include "../lib/hw.h"
#include "../lib/console.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/syscall_c.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/riscv.hpp"
#include "../h/printing.hpp"

#include "../h/tcb.hpp"
#include "../h/workers.hpp"
#include "../h/printing.hpp"
#include "../h/riscv.hpp"
//#include "../src/userMain.cpp"

extern void userMain();

void userMainWrapper(void*)
{
    userMain();
}

int main()
{
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    thread_t systemThread;
    thread_create(&systemThread , nullptr, nullptr);
    TCB::running = systemThread;


    thread_t userMainThread;
    thread_create(&userMainThread , &userMainWrapper, nullptr);

    Riscv::ms_sstatus(Riscv::BitMaskSstatus::SSTATUS_SIE);

    while(!userMainThread->isFinished())
    {
        thread_dispatch();
    }

    return 0;
}