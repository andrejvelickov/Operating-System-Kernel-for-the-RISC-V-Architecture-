//
// Created by os on 5/17/24.
//

#ifndef PROJECT_BASE_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

class MemoryAllocator {

public:

    struct FreeMemBlockHeader
    {
        FreeMemBlockHeader* next;
        FreeMemBlockHeader* prev;
        size_t size;
    };

    static void* mem_alloc(size_t size);
    static int mem_free(void* addr);
    static void mem_init();
    static void tryToJoin(FreeMemBlockHeader* block);


    static MemoryAllocator* getInstance();

    MemoryAllocator(const MemoryAllocator&) = delete;
    MemoryAllocator& operator=(const MemoryAllocator&) = delete;


private:

    static MemoryAllocator* instance;
    static FreeMemBlockHeader* FreeMemHead;
    MemoryAllocator() = default;
    ~MemoryAllocator() = default;
};


#endif //PROJECT_BASE_MEMORYALLOCATOR_HPP
