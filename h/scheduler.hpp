//
// Created by os on 5/17/24.
//

#ifndef PROJECT_BASE_SCHEDULER_HPP
#define PROJECT_BASE_SCHEDULER_HPP

#include "list.hpp"

class TCB;

class Scheduler
{
private:

    static List<TCB> readyThreadQueue;

    Scheduler() = default;
    ~Scheduler() = default;

public:


    static TCB* get();

    static void put(TCB *tcb);

    static Scheduler& getInstance()
    {
        static Scheduler instance;
        return instance;
    }



    Scheduler(const Scheduler&) = delete;
    Scheduler& operator=(const Scheduler&) = delete;

};
#endif //PROJECT_BASE_SCHEDULER_HPP
