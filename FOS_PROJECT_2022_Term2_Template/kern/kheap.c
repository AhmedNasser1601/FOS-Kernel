#include <inc/memlayout.h>
#include <kern/kheap.h>
#include <kern/memory_manager.h>

#define Mega (1024*1024)
#define kilo (1024)

//2022: NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)

uint32 startAdd = KERNEL_HEAP_START;
int IDX = 0;

struct KernelHEAP {
	uint32 first;
	uint32 last;
	int size;
} kHeapArr[Mega];

uint32* nextFitAlgo(unsigned int size) {
	uint32 x = 0, y = 0;
	struct Frame_Info* framePTR;

	for(uint32 i = startAdd; i <= KERNEL_HEAP_MAX; i += PAGE_SIZE) {
		if(i == KERNEL_HEAP_MAX) i = KERNEL_HEAP_START;
		if(i == startAdd) y++;
		if(y == 2) if (x != kHeapArr[IDX].size) return NULL;

		uint32* ptr_page;
		framePTR = get_frame_info(ptr_page_directory, (void*)i, &ptr_page);
		if (framePTR == NULL) {
			if (x == 0) kHeapArr[IDX].first = i;
			kHeapArr[IDX].last = i;
			x += PAGE_SIZE;
		} else x = 0;

		if (x == kHeapArr[IDX].size) break;
	}

	if (x == kHeapArr[IDX].size) {
		for (uint32 j=kHeapArr[IDX].first; j <= kHeapArr[IDX].last; j+=PAGE_SIZE) {
			allocate_frame(&framePTR);
			map_frame(ptr_page_directory, framePTR, (void*)j, PERM_PRESENT|PERM_WRITEABLE);
		}
	}

	startAdd = kHeapArr[IDX].last + PAGE_SIZE;
	IDX++;
	return (void*) kHeapArr[IDX-1].first;
}

void* kmalloc(unsigned int size) {
	//TODO: [PROjECT 2022 - [1] Kernel Heap] kmalloc()
	// Write your code here, remove the panic and write your code
	//kpanic_into_prompt("kmalloc() is not implemented yet...!!");

	//NOTE: Allocation using NEXTFIT strategy
	//NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)
	//refer to the project presentation and documentation for details

	//TODO: [PROjECT 2022 - BONUS1] Implement a Kernel allocation strategy
	// Instead of the Next allocation/deallocation, implement
	// BEST FIT strategy
	// use "isKHeapPlacementStrategyBESTFIT() ..."
	// and "isKHeapPlacementStrategyNEXTFIT() ..."
	//functions to check the current strategy
	//change this "return" according to your answer

	kHeapArr[IDX].size = ROUNDUP(size, PAGE_SIZE);

	if(isKHeapPlacementStrategyNEXTFIT()) {
		return nextFitAlgo(size);
	}

	if(isKHeapPlacementStrategyBESTFIT()) {
		// --->>> BONUS -->> BEST FIT -> HERE

		uint32* ptr=NULL;
		int numofpages=(size+(PAGE_SIZE-1))/PAGE_SIZE;

		int flag=1,temp;
		for(int i=KERNEL_HEAP_START;i<KERNEL_HEAP_MAX;i+=PAGE_SIZE)
		{
			uint32 *ptr_table = NULL;
			struct Frame_Info* ptr_frame_info = get_frame_info(ptr_page_directory, (void*)i, &ptr_table);
			int counter=0,j=i;
			while(ptr_frame_info == NULL && j < KERNEL_HEAP_MAX)
			{
				counter++;
				ptr_frame_info = get_frame_info(ptr_page_directory,(void*)j, &ptr_table);
				j+=PAGE_SIZE;
			}
			if(flag && counter>numofpages)
			{
				temp=counter;
				ptr=(void*)i;
				flag=0;
			}

			else if(counter>numofpages && counter<temp)
			{
				temp=counter;
				ptr=(void*)i;
			}
			if(j>i)
				i=j-PAGE_SIZE;
		}
	}

	return NULL;
}

void kfree(void* virtual_address) {
	//TODO: [PROJECT 2022 - [2] Kernel Heap] kfree()
	// Write your code here, remove the panic and write your code
	//panic("kfree() is not implemented yet...!!");

	//you need to get the size of the given allocation using its address
	//refer to the project presentation and documentation for details

	uint32 flag = 0, start, end;

	for(int i=0; i<IDX; i++) {
		if((uint32)virtual_address == kHeapArr[i].first) {
			flag=1;
			start = (uint32)virtual_address;
			end = kHeapArr[i].last;
		}
	}

	if(flag) {
		for(uint32 i=start; i<=end; i+=PAGE_SIZE) {
			unmap_frame(ptr_page_directory, (void*)i);
			uint32*ptrPT;
			get_page_table(ptr_page_directory, (void*)i, &ptrPT);
			if(ptrPT != NULL) ptrPT[PTX(i)] = 0;
		}
	}
}

unsigned int kheap_virtual_address(unsigned int physical_address) {
	//TODO: [PROJECT 2022 - [3] Kernel Heap] kheap_virtual_address()
	// Write your code here, remove the panic and write your code
	//panic("kheap_virtual_address() is not implemented yet...!!");

	//return the virtual address corresponding to given physical_address
	//refer to the project presentation and documentation for details

	//change this "return" according to your answer

	struct Frame_Info* phyAddFrame = to_frame_info(physical_address);
	for(uint32 i=KERNEL_HEAP_START; i<startAdd; i+=PAGE_SIZE) {
		uint32* framePTR = NULL;
		if(phyAddFrame == get_frame_info(ptr_page_directory, (void*)i, &framePTR))
			return i;
	}

	return 0;
}

unsigned int kheap_physical_address(unsigned int virtual_address) {
	//TODO: [PROJECT 2022 - [4] Kernel Heap] kheap_physical_address()
	// Write your code here, remove the panic and write your code
	//panic("kheap_physical_address() is not implemented yet...!!");

	//return the physical address corresponding to given virtual_address
	//refer to the project presentation and documentation for details

	//change this "return" according to your answer

	uint32 *ptPTR = NULL;
	get_page_table(ptr_page_directory, (uint32*)virtual_address, &ptPTR);
	if(ptPTR != NULL)
		return (ptPTR[PTX(virtual_address)] & 0xFFFFF000);
	return 0;
}
