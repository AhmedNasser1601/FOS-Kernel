#include <inc/memlayout.h>
#include <kern/kheap.h>
#include <kern/memory_manager.h>

#define Mega (1024*1024)
#define kilo (1024)

//2022: NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)

uint32 startAdd = KERNEL_HEAP_START;
int idx = 0;

struct HEAP
{
	uint32 first;
	int size;
} heapArr[Mega];

void* kmalloc(unsigned int size)
{
	//TODO: [PROjECT 2022 - [1] Kernel Heap] kmalloc()
	// Write your code here, remove the panic and write your code
	//kpanic_into_prompt("kmalloc() is not implemented yet...!!");

	//NOTE: Allocation using NEXTFIT strategy
	//NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)
	//refer to the project presentation and documentation for details

	uint32 newStart = startAdd;
	heapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
	uint32 maxSize = startAdd+size;

	if(KERNEL_HEAP_MAX-startAdd > size)
	{
		for(uint32 i = startAdd; i < maxSize; i += PAGE_SIZE)
		{
			struct Frame_Info* ptrFrameInfo;
			int tmp = allocate_frame(&ptrFrameInfo);

			if(tmp == E_NO_MEM) return NULL;

			tmp = map_frame(ptr_page_directory, ptrFrameInfo, (void*)i, PERM_PRESENT|PERM_WRITEABLE);

			if(tmp == E_NO_MEM)
			{
				free_frame(ptrFrameInfo);
				return NULL;
			}

			startAdd += PAGE_SIZE;   //Moving Forward
		}

		heapArr[idx].first = newStart;
		idx++;

		return (void*)newStart;
	}

	//TODO: [PROjECT 2022 - BONUS1] Implement a Kernel allocation strategy
	// Instead of the Next allocation/deallocation, implement
	// BEST FIT strategy
	// use "isKHeapPlacementStrategyBESTFIT() ..."
	// and "isKHeapPlacementStrategyNEXTFIT() ..."
	//functions to check the current strategy
	//change this "return" according to your answer

	return NULL;
}

void kfree(void* virtual_address)
{
	//TODO: [PROJECT 2022 - [2] Kernel Heap] kfree()
	// Write your code here, remove the panic and write your code
	//panic("kfree() is not implemented yet...!!");

	//you need to get the size of the given allocation using its address
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++)
	{
		if (virtual_address == (void*)heapArr[i].first)
		{
			uint32 finalAdd = heapArr[i].first + heapArr[i].size;
			for(uint32 j = (uint32)virtual_address; j<finalAdd; j+=PAGE_SIZE)
			{
				unmap_frame(ptr_page_directory, (uint32*)j);
			}

			heapArr[i].first = heapArr[i].size = 0;
		}
	}
}

unsigned int kheap_virtual_address(unsigned int physical_address)
{
	//TODO: [PROJECT 2022 - [3] Kernel Heap] kheap_virtual_address()
	// Write your code here, remove the panic and write your code
	panic("kheap_virtual_address() is not implemented yet...!!");

	//return the virtual address corresponding to given physical_address
	//refer to the project presentation and documentation for details

	//change this "return" according to your answer

	return 0;
}

unsigned int kheap_physical_address(unsigned int virtual_address)
{
	//TODO: [PROJECT 2022 - [4] Kernel Heap] kheap_physical_address()
	// Write your code here, remove the panic and write your code
	panic("kheap_physical_address() is not implemented yet...!!");

	//return the physical address corresponding to given virtual_address
	//refer to the project presentation and documentation for details

	//change this "return" according to your answer
	return 0;
}

