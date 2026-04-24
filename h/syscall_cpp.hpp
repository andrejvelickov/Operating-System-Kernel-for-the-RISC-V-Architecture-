//
// Created by os on 5/19/24.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HPP
#define PROJECT_BASE_SYSCALL_CPP_HPP

#include "syscall_c.hpp"

void* operator new(size_t);
void operator delete(void*);

class Thread{

public:

    Thread(void (*body)(void*), void* arg);
    virtual ~Thread();

    int start();

    static void dispatch();

    void send(char* message);
    char* receive();


protected:

    Thread();
    virtual void run(){}

private:

    friend class Semaphore;
    static void Wrapper(void* function);
    thread_t myHandle;
    void (*body)(void*);
    void* arg;
};

class Semaphore{

public:

    Semaphore(unsigned init = 1);
    virtual ~Semaphore();

    int wait();
    int signal();
    //int timedWait(time_t);
    int tryWait();

private:

    sem_t myHandle;
};

class PeriodicThread : public Thread{

public:

    void terminate();

protected:

    PeriodicThread(time_t period);
    virtual void periodicActivation(){}

private:
    time_t period;
};

class Console{

public:

    static char getc();
    static void putc(char character);
};

#endif //PROJECT_BASE_SYSCALL_CPP_HPP