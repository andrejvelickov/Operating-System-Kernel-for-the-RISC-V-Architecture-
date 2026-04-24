//
// Created by os on 5/17/24.
//

#ifndef PROJECT_BASE_TCB_HPP
#define PROJECT_BASE_TCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/MySemaphore.hpp"

// Thread Control Block
class TCB
{

public:

    ~TCB() { MemoryAllocator::mem_free(stack); }
    bool isFinished() const { return finished; }
    void setFinished(bool value) { finished = value; }

    using Body = void (*)(void*);

    static int thread_create(thread_t* handle, void (*start_routine)(void*), void* arg, void* stack_space);

    static void thread_dispatch();

    static int thread_exit();

    static void send(thread_t handle, char* message);
    static char* receive();

    static TCB *running;

    void* operator new(size_t size);
    void operator delete(void* address);
    Body body;

private:

    TCB(Body body, void* arg, void* stack_space) :
            body(body),
            arg(arg),
            stack((uint64*)stack_space),
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
                    }),
            finished(false),
            semClosed(false),
            msg(nullptr),
            full(false),
            block(false),
            waiting()
    {
        blocked = new MySemaphore(0);
        if (body != nullptr) { Scheduler::getInstance().put(this); }
    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };


    void* arg;
    uint64 *stack;
    Context context;
    bool finished;
    bool semClosed;
    friend class Riscv;
    friend class MySemaphore;

    char* msg;
    bool full;
    bool block;
    MySemaphore* blocked;
    List<MySemaphore*> waiting;

    static void threadWrapper();

    static void contextSwitch(Context *oldContext, Context *runningContext);

};

#endif //PROJECT_BASE_TCB_HPP