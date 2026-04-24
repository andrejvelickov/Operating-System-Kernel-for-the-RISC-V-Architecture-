//
// Created by os on 5/19/24.
//

#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"
#include "../h/tcb.hpp"

void* operator new(size_t size)
{
    void* address = mem_alloc(size);
    return address;
}

void* operator new[](size_t size)
{
    void* address = mem_alloc(size);
    return address;
}

void operator delete(void* address)
{
    mem_free(address);
}

void operator delete[](void* address)
{
    mem_free(address);
}

Thread::Thread(void (*body)(void *), void *arg)
{
    this->myHandle = nullptr;
    this->body = body;
    this->arg = arg;
}

Thread::~Thread()
{
    if(myHandle != nullptr)
    {
        delete this->myHandle;
        this->myHandle = nullptr;
    }

}

int Thread::start()
{
    if(this->myHandle == nullptr)
    {
        thread_create(&this->myHandle, this->body, this->arg);
        return 0;
    }

    return -1;
}

void Thread::dispatch()
{
    thread_dispatch();
}

Thread::Thread()
{
    this->myHandle = nullptr;
    this->body = &Wrapper;
    this->arg = this;
}

void Thread::Wrapper(void *thread)
{
    ((Thread*) thread) -> run();
}

void Thread::send(char *message)
{
    ::send(this->myHandle, message);
}

char* Thread::receive()
{
    return ::receive();
}


Semaphore::Semaphore(unsigned int init)
{
    sem_open(&this->myHandle, init);
}

Semaphore::~Semaphore()
{
    if(this->myHandle != nullptr)
    {
        sem_close(this->myHandle);
    }
}

int Semaphore::wait()
{
    if(this->myHandle != nullptr)
    {
        sem_wait(this->myHandle);
        return 0;
    }

    return -1;
}

int Semaphore::signal()
{
    if(this->myHandle != nullptr)
    {
        sem_signal(this->myHandle);
        return 0;
    }

    return -1;
}

int Semaphore::tryWait()
{
    if(this->myHandle != nullptr)
    {
        sem_trywait(this->myHandle);
        return 0;
    }

    return -1;
}


char Console::getc()
{
    return ::getc();
}

void Console::putc(char character)
{
    ::putc(character);
}