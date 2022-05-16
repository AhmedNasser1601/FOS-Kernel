#include <inc/memlayout.h>
#include <kern/kheap.h>
#include <kern/memory_manager.h>

//2022: NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)


int count =0;


uint32 startAdd = KERNEL_HEAP_START;
int idx = 0;
struct KernelHEAP {
	uint32 first;
	uint32 last;
	int size;

} kHeapArr[1024*1024];


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
	int count = 0;
		kHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 X = 0;
		struct Frame_Info*fra;
		uint32 co = 0;
		if (isKHeapPlacementStrategyNEXTFIT()) {
			for (uint32 i = startAdd; i <= KERNEL_HEAP_MAX; i += PAGE_SIZE) {
				if (i == KERNEL_HEAP_MAX) {
					i = KERNEL_HEAP_START;
				}
				if (i == startAdd) {
					co++;
				}
				if (co == 2) {
					if (X != kHeapArr[idx].size) {
						return NULL;
					}
				}

				uint32*ptr_page;
				struct Frame_Info*frame = get_frame_info(ptr_page_directory,
						(void*) i, &ptr_page);
				if (frame == NULL) {
					if (X == 0) {
						kHeapArr[idx].first = i;
					}
					kHeapArr[idx].last = i;
					X += PAGE_SIZE;
				} else {
					X = 0;
				}

				if (X == kHeapArr[idx].size) {
					break;
				}

			}

			if (X == kHeapArr[idx].size) {

				for (uint32 j = kHeapArr[idx].first; j <= kHeapArr[idx].last; j +=
				PAGE_SIZE) {
					int alloc = allocate_frame(&fra);
					map_frame(ptr_page_directory, fra, (void*) j,
					PERM_PRESENT | PERM_WRITEABLE);
				}
			}
			startAdd = kHeapArr[idx].last + PAGE_SIZE;
			int val = idx;
			idx++;
			return (void*) kHeapArr[val].first;

		}
return NULL;
}

void kfree(void* virtual_address) {
	//TODO: [PROJECT 2022 - [2] Kernel Heap] kfree()
	// Write your code here, remove the panic and write your code
	//panic("kfree() is not implemented yet...!!");

	//you need to get the size of the given allocation using its address
	//refer to the project presentation and documentation for details
	uint32 check=0;
	uint32 startAddress;
	uint32 EndAddress;
	for(int i=0;i<idx;i++)
	{
			if((uint32)virtual_address==kHeapArr[i].first)
			{
				check=1;
				startAddress =(uint32)virtual_address;
				EndAddress=kHeapArr[i].last;

			}


	}
	if(check==1)
	{
		for( uint32 A = startAddress;A<=EndAddress;A+=PAGE_SIZE)
		{
			unmap_frame(ptr_page_directory,(void *)A);
			uint32*ptr_page;

			get_page_table(ptr_page_directory,(void*)A,&ptr_page);
			if(ptr_page!=NULL)
			{
			ptr_page[PTX(A)]=0;
			}

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

	return frames_info[physical_address>>12].va;
}

unsigned int kheap_physical_address(unsigned int virtual_address) {
	//TODO: [PROJECT 2022 - [4] Kernel Heap] kheap_physical_address()
	// Write your code here, remove the panic and write your code
	//panic("kheap_physical_address() is not implemented yet...!!");

	//return the physical address corresponding to given virtual_address
	//refer to the project presentation and documentation for details

	//change this "return" according to your answer

	uint32 *ptPTR = NULL;
	get_page_table(ptr_page_directory,(uint32*)virtual_address, &ptPTR);
	if(ptPTR != NULL) return (ptPTR[PTX(virtual_address)] & 0xFFFFF000);
	return 0;
}
