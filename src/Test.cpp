//
// Created by os on 7/4/24.
//

#include "../h/syscall_cpp.hpp"
#include "../h/Test.hpp"
#include "../h/printing.hpp"

static volatile bool finishedA1 = false;
static volatile bool finishedB1 = false;
static volatile bool finishedC1 = false;

Thread* threads[3];

class WorkerA1: public Thread {
    void workerBodyA1(void* arg);
public:
    WorkerA1():Thread() {}

    void run() override {
        workerBodyA1(nullptr);
    }
};

class WorkerB1: public Thread {
    void workerBodyB1(void* arg);
public:
    WorkerB1():Thread() {}

    void run() override {
        workerBodyB1(nullptr);
    }
};

class WorkerC1: public Thread {
    void workerBodyC1(void* arg);
public:
    WorkerC1():Thread() {}

    void run() override {
        workerBodyC1(nullptr);
    }
};

void WorkerA1::workerBodyA1(void *arg)
{
    char m1[] = "A -> B";
    threads[1]->send(m1);

    char m2[] = "A -> C";
    threads[2]->send(m2);

    char* msg = Thread::receive();
    printString(msg);

    printString("\nA finished!\n");
    finishedA1 = true;
}

void WorkerB1::workerBodyB1(void *arg)
{
    char m3[] = "B -> C";
    threads[2]->send(m3);

    char* msg = Thread::receive();
    printString(msg);

    printString("\nB finished!\n");
    finishedB1 = true;
}

void WorkerC1::workerBodyC1(void *arg)
{

    char m4[] = "C -> A";
    threads[0]->send(m4);

    char* msg = Thread::receive();

    printString(msg);

    printString("\nC finished!\n");
    finishedC1 = true;
}


void Test()
{

    threads[0] = new WorkerA1();
    printString("ThreadA created\n");

    threads[1] = new WorkerB1();
    printString("ThreadB created\n");

    threads[2] = new WorkerC1();
    printString("ThreadC created\n");

    for(int i=0; i<3; i++)
    {
        threads[i]->start();
    }

    while (!(finishedA1 && finishedB1 && finishedC1)) {
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }
}
