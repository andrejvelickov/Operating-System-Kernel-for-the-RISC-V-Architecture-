//
// Created by os on 6/25/24.
//

#ifndef PROJECT_BASE_MYSEMAPHORE_HPP
#define PROJECT_BASE_MYSEMAPHORE_HPP

#include "syscall_c.hpp"
#include "list.hpp"
#include "scheduler.hpp"

class MySemaphore{

public:

    MySemaphore(unsigned value): value(value){}


    static int sem_open(sem_t* handle, unsigned init);
    static int sem_close(sem_t handle);
    static int sem_wait(sem_t id);
    static int sem_signal(sem_t id);
    static int sem_trywait(sem_t id);
    static void sem_setValue(sem_t id, int value);

    void* operator new(size_t size);
    void operator delete(void* address);

private:

    List<TCB> semaphoreQueue;
    int value;

};


#endif //PROJECT_BASE_MYSEMAPHORE_HPP