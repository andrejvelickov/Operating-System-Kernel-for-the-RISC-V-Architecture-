//
// Created by os on 5/17/24.
//

#ifndef PROJECT_BASE_LIST_HPP
#define PROJECT_BASE_LIST_HPP

#include "MemoryAllocator.hpp"

template<typename T>
class List
{
private:
    struct Elem
    {
        T *data;
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}
    };

    Elem *head, *tail;
    unsigned int n;

public:
    List() : head(0), tail(0), n(0) {}

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

    unsigned int numberOfElements()
    {
        return n;
    };

    void addFirst(T *data)
    {
        Elem *elem = new Elem(data, head);
        head = elem;
        if (!tail) { tail = head; }
        n++;
    }

    void addLast(T *data)
    {

        Elem* elem = (Elem*) MemoryAllocator::mem_alloc((sizeof(Elem) + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE);
        elem->data = data;
        elem->next = nullptr;

        if (tail)
        {
            tail->next = elem;
            tail = elem;
        }

        else
        {
            head = tail = elem;
        }

        n++;
    }

    T *removeFirst()
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        T *ret = elem->data;

        MemoryAllocator::mem_free(elem);

        n--;

        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
        return head->data;
    }

    T *removeLast()
    {
        if (!head) { return 0; }

        Elem *prev = 0;
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
        {
            prev = curr;
        }

        Elem *elem = tail;
        if (prev) { prev->next = 0; }
        else { head = 0; }
        tail = prev;

        T *ret = elem->data;

        n--;
        delete elem;
        return ret;
    }

    T *peekLast()
    {
        if (!tail) { return 0; }
        return tail->data;
    }
};

#endif //PROJECT_BASE_LIST_HPP
