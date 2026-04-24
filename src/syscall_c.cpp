//
// Created by os on 5/19/24.
//

#include "../h/syscall_c.hpp"
#include "../h/printing.hpp"

void* mem_alloc(size_t size)
{

    void* volatile address = nullptr;
    uint64 volatile number = 0x01;
    uint64 volatile numberOfBlocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    //printString("x");
    //printInteger( numberOfBlocks);
    //printString("x");
    //printString("\n");
    __asm__ volatile("mv a0, %0" : : "r" (number));
    __asm__ volatile("mv a1, %0" : : "r" (numberOfBlocks));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (address));

    return address;

    //return __mem_alloc(size);
}

int mem_free(void* address)
{
    int volatile returnValue;
    uint64 volatile number = 0x02;

    __asm__ volatile("mv a1, %0" : : "r" (address));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");


    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;

    //return __mem_free(address);
}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg)
{
    thread_t* volatile local_handle = handle;
    void(*local_start_routine)(void*) = start_routine;
    void* volatile local_arg = arg;

    //mem_alloc stack-a

    void* volatile stack;
    stack = mem_alloc(DEFAULT_STACK_SIZE * sizeof(uint64));

    //thread_create

    int volatile returnValue;
    uint64 volatile number = 0x11;

    __asm__ volatile("mv a0, %0" : : "r" (number));
    __asm__ volatile("mv a1, %0" : : "r" (local_handle));
    __asm__ volatile("mv a2, %0" : : "r" (local_start_routine));
    __asm__ volatile("mv a3, %0" : : "r" (local_arg));
    __asm__ volatile("mv a4, %0" : : "r" (stack));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int thread_exit()
{
    int volatile returnValue;
    uint64 volatile number = 0x12;

    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

void thread_dispatch()
{
    uint64 volatile number = 0x13;

    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");
}

void send(thread_t handle, char* message)
{
    uint64 volatile number = 0x14;

    __asm__ volatile("mv a2, %0" : : "r" (message));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");
}

char* receive()
{
    char* volatile returnValue;
    uint64 volatile number = 0x15;

    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int sem_open(sem_t* handle, unsigned init)
{
    int volatile returnValue;
    uint64 volatile number = 0x21;

    __asm__ volatile("mv a2, %0" : : "r" (init));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int sem_close(sem_t handle)
{
    int volatile returnValue;
    uint64 volatile number = 0x22;

    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int sem_wait(sem_t id)
{
    int volatile returnValue;
    uint64 volatile number = 0x23;

    __asm__ volatile("mv a1, %0" : : "r" (id));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int sem_signal(sem_t id)
{
    int volatile returnValue;
    uint64 volatile number = 0x24;

    __asm__ volatile("mv a1, %0" : : "r" (id));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

int sem_trywait(sem_t id)
{
    int volatile returnValue;
    uint64 volatile number = 0x26;

    __asm__ volatile("mv a1, %0" : : "r" (id));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

char getc()
{
    char volatile returnValue;
    uint64 volatile number = 0x41;

    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

    __asm__ volatile("mv %0, a0" : "=r" (returnValue));

    return returnValue;
}

void putc(char c)
{
    uint64 volatile number = 0x42;

    __asm__ volatile("mv a1, %0" : : "r" (c));
    __asm__ volatile("mv a0, %0" : : "r" (number));

    __asm__ volatile("ecall");

}