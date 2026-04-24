//
// Created by os on 6/25/24.
//

#include "../h/MySemaphore.hpp"
#include "../h/tcb.hpp"
#include "../h/printing.hpp"

int MySemaphore::sem_open(sem_t *handle, unsigned init)
{
    *handle = new MySemaphore(init);

    if(*handle == nullptr)
    {
        return -1;
    }

    return 0;
}

int MySemaphore::sem_close(sem_t handle)
{
    if(handle == nullptr)
    {
        return -2;
    }

    for(unsigned int i = 0; i < handle->semaphoreQueue.numberOfElements(); i++)
    {
        thread_t tcb = handle->semaphoreQueue.removeFirst();
        Scheduler::getInstance().put(tcb);
        tcb->semClosed = true;
    }

    delete handle;

    return 0;
}

int MySemaphore::sem_wait(sem_t id)
{
    if(id == nullptr)
    {
        return -2;
    }

    id->value = id->value - 1;

    if(id->value < 0)
    {
        thread_t oldRunning = TCB::running;
        id->semaphoreQueue.addLast(oldRunning);

        thread_t newRunning = Scheduler::getInstance().get();
        TCB::running = newRunning;
        TCB::contextSwitch(&oldRunning->context, &newRunning->context);
    }

    if(TCB::running->semClosed)
    {
        return -1;
    }

    return 0;
}

int MySemaphore::sem_signal(sem_t id)
{
    if(id == nullptr)
    {
        return -2;
    }

    id->value = id->value + 1;

    if(id->value <= 0)
    {
        thread_t unblocked = id->semaphoreQueue.removeFirst();
        Scheduler::getInstance().put(unblocked);
    }

    return 0;
}

int MySemaphore::sem_trywait(sem_t id)
{
    if(id == nullptr)
    {
        return -2;
    }

    id->value = id->value - 1;

    if(id->value < 0)
    {
        return 0;
    }

    return 1;
}


void *MySemaphore::operator new(size_t size)
{
    return (sem_t) MemoryAllocator::mem_alloc((sizeof(MySemaphore) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
}

void MySemaphore::operator delete(void *address)
{
    MemoryAllocator::mem_free(address);
}

void MySemaphore::sem_setValue(sem_t id, int value)
{
    id->value = value;
}






