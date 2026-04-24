//
// Created by os on 5/17/24.
//

#include "../h/tcb.hpp"
#include "../h/riscv.hpp"
#include "../h/printing.hpp"

TCB *TCB::running = nullptr;

int TCB::thread_create(thread_t* handle, void (*start_routine)(void*), void* arg, void* stack_space)
{

    *handle = new TCB(start_routine, arg, stack_space);


    if(*handle == nullptr)
    {
        return -1;
    }

    return 0;
}

void TCB::thread_dispatch()
{
    TCB *old = running;
    if (!old->isFinished()) { Scheduler::put(old); }
    running = Scheduler::get();

    TCB::contextSwitch(&old->context, &running->context);
}

void TCB::threadWrapper()
{
    Riscv::popSppSpie();
    running->body(running->arg);
    running->setFinished(true);
    ::thread_dispatch();
    //TCB::thread_dispatch();
}

int TCB::thread_exit()
{
    running->setFinished(true);
    ::thread_dispatch();
    //TCB::thread_dispatch();
    return 0;
}

void *TCB::operator new(size_t size)
{
    return (thread_t) MemoryAllocator::mem_alloc((sizeof(TCB) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
}

void TCB::operator delete(void* address)
{
    MemoryAllocator::mem_free(address);
}

void TCB::send(thread_t handle, char *message)
{
    if(handle->full)
    {
        handle->waiting.addLast(&running->blocked);
        sem_wait(running->blocked);
    }

    handle->msg = message;
    handle->full = true;

    if(handle->block)
    {
        handle->block = false;
        sem_signal(handle->blocked);
    }
}

char *TCB::receive()
{
    if(!running->full)
    {
        running->block = true;
        sem_wait(running->blocked);
    }

    running->full = false;

    sem_t *sem = running->waiting.removeFirst();
    
    if(sem)
    {
        sem_signal(*sem);
    }


    return running->msg;
}

