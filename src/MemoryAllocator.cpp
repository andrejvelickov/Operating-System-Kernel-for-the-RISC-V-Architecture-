//
// Created by os on 5/17/24.
//

#include "../h/MemoryAllocator.hpp"

MemoryAllocator :: FreeMemBlockHeader* MemoryAllocator :: FreeMemHead = nullptr;
MemoryAllocator* MemoryAllocator :: instance = nullptr;

MemoryAllocator *MemoryAllocator::getInstance()
{
    if(instance == nullptr)
    {
        mem_init();
        instance = (MemoryAllocator*) MemoryAllocator::mem_alloc((sizeof(instance) + MEM_BLOCK_SIZE - 1)/ MEM_BLOCK_SIZE);
       //printInteger((uint64) instance);
       //printString("\n");
    }

    return instance;
}

void MemoryAllocator::mem_init()
{

    FreeMemHead = (FreeMemBlockHeader*) HEAP_START_ADDR;
    FreeMemHead->next = nullptr;
    FreeMemHead->prev = nullptr;
    FreeMemHead->size = ((char*) HEAP_END_ADDR - 1 - (char*)HEAP_START_ADDR);
}

void *MemoryAllocator::mem_alloc(size_t size)
{
  //  printInteger((uint64) FreeMemHead);
  // if(size <= 0) return nullptr;


   size = size * MEM_BLOCK_SIZE + sizeof(FreeMemBlockHeader);
    //printInteger((uint64 ) FreeMemHead);
   FreeMemBlockHeader* current = FreeMemHead;
   bool found = false;

   for(; current != nullptr; current = current->next)
   {
       if(current->size >= size)
       {
           found = true;
           break;
       }
   }

   if(!found) return nullptr;

   size_t remaining = current->size - size;

   if(remaining >= MEM_BLOCK_SIZE + sizeof(FreeMemBlockHeader))
   {

        current->size = size;
        size_t offset  = size;
        FreeMemBlockHeader* newFreeMemBlockHeader = (FreeMemBlockHeader*) ((char*) current + offset);
        if(current->prev)
        {
            current->prev->next = newFreeMemBlockHeader;
        }
        else
        {
            FreeMemHead = newFreeMemBlockHeader;
        }

       // printInteger((uint64) current);
       // printInteger((uint64) newFreeMemBlockHeader);
        newFreeMemBlockHeader->next = current->next;
        newFreeMemBlockHeader->prev = current->prev;
        //printInteger((uint64) newFreeMemBlockHeader);

        newFreeMemBlockHeader->size = remaining;

   }

   else
   {
       //printString("ananas");
       if(current->prev)
       {
           current->prev->next = current->next;
       }

       else
       {
           FreeMemHead = current->next;
       }

       if(current->next)
       {
           current->next->prev = current->prev;
       }

   }

   current->next = nullptr;
   current->prev = nullptr;

   return (char*) current + sizeof(FreeMemBlockHeader);

}

int MemoryAllocator::mem_free(void* addr)
{
    //printString("\nFreeMemHEAD");
    //printInteger((uint64) FreeMemHead);
    //printString("\n");
    if(addr == nullptr)
    {
        return 1;
    }

    //printInteger((uint64) addr);
    FreeMemBlockHeader* address = (FreeMemBlockHeader*) ((char*) addr - sizeof(FreeMemBlockHeader));
    //printInteger((uint64) address);

    if(FreeMemHead == nullptr)
    {

        FreeMemHead = address;
        FreeMemHead->prev = nullptr;
        //printInteger((uint64)FreeMemHead);
        FreeMemHead->next = nullptr;
        //printInteger(FreeMemHead->size);

        return 0;
    }

    FreeMemBlockHeader* current = FreeMemHead;


    if(address < FreeMemHead)
    {
        current = nullptr;
    }
    else
    {
        for(; current->next != nullptr && address > current->next; current = current->next);
    }

    address->prev = current;

    if(current)
    {
        address->next = current->next;
    }

    else
    {
        address->next = FreeMemHead;
    }

    if(address->next)
    {
        address->next->prev = address;
    }

    if(current)
    {
        current->next = address;
    }
    else
    {
        FreeMemHead = address;
    }

    tryToJoin(address);
    tryToJoin(current);

    //printInteger((uint64) FreeMemHead);
    //printString("\n");
    //printString("\nFreeMemHEAD2");
    //printInteger((uint64) FreeMemHead);
    //printString("\n");

    return 0;
}

void MemoryAllocator::tryToJoin(MemoryAllocator::FreeMemBlockHeader *block)
{
    if(!block) return;

   // printString("\n Address:");
   // printInteger((uint64) block);
   // printString("\n");
//
   // printString("\n Address next:");
   // printInteger((uint64) block->next);
   // printString("\n");
//
//
   // printString("\n BLSIZE next:");
   // printInteger((uint64) (block->size));
   // printString("\n");


    if(block->next && (((char*)((char*) block + block->size)) == (char*) (block->next)))
    {
        //printString("desilo se");
        block->size = block->size + block->next->size;
       //printString("\nDESILO SE BLOCK SIZE");
       //printInteger((uint64) block->size);
       //printString("\n");
        block->next = block->next->next;
        if(block->next) block->next->prev = block;
    }
}


