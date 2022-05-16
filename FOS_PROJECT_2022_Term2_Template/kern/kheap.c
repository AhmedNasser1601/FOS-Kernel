#include <inc/memlayout.h>
#include <kern/kheap.h>
#include <kern/memory_manager.h>

//2022: NOTE: All kernel heap allocations are multiples of PAGE_SIZE (4KB)

struct KernelHEAP {
	uint32 starter;
	uint32 pages;
	int first;
	int last;
	uint8 allocated;
} kHeapArr[(KERNEL_HEAP_MAX-KERNEL_HEAP_START)/PAGE_SIZE];

int x=-1, y=-1;
int fIDX=0, looping=0;
int IDX=1, kmallocBEGIN=1, freeBEGIN=1;

uint32 *nextFitAlgo(unsigned int Size) {
	while(kHeapArr[fIDX].allocated || (kHeapArr[fIDX].pages < Size)) {
		fIDX = kHeapArr[fIDX].last;
		if(fIDX == -1) {
			if(isKHeapPlacementStrategyNEXTFIT() && !looping) {
				looping = 1;
				fIDX = 0;
			}
			else return NULL;
		}
	}

	if(kHeapArr[fIDX].pages != Size) {
		int lIDX;
		if(x != -1) {
			lIDX = x;
			x = -1;
		} else if(y != -1) {
			lIDX = y;
			y = -1;
		} else {
			lIDX = IDX;
			IDX++;
		}

		kHeapArr[lIDX].last = kHeapArr[fIDX].last;

		if(kHeapArr[lIDX].last != -1)
			kHeapArr[kHeapArr[lIDX].last].first = lIDX;

		kHeapArr[lIDX].first = fIDX;
		kHeapArr[fIDX].last = lIDX;

		kHeapArr[lIDX].allocated = 0;
		kHeapArr[lIDX].pages = kHeapArr[fIDX].pages - Size;
		kHeapArr[lIDX].starter = kHeapArr[fIDX].starter + (Size*PAGE_SIZE);

		kHeapArr[fIDX].pages = Size;
	}

	kHeapArr[fIDX].allocated = 1;
	uint32 ptrVA = kHeapArr[fIDX].starter;

	for(int i=0; i<Size; i++) {
		struct Frame_Info* framePTR;
		if(allocate_frame(&framePTR) != E_NO_MEM) {
			map_frame(ptr_page_directory, framePTR, (void*)ptrVA, PERM_WRITEABLE|PERM_AVAILABLE);
			framePTR->va = ptrVA;
		}
		ptrVA += PAGE_SIZE;
	}
	looping = 0;

	return (void*)kHeapArr[fIDX].starter;
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

	if(kmallocBEGIN) {
		kHeapArr[0].starter = KERNEL_HEAP_START;
		kHeapArr[0].pages = (KERNEL_HEAP_MAX-KERNEL_HEAP_START)/PAGE_SIZE;
		kHeapArr[0].first = kHeapArr[0].last = -1;
		kHeapArr[0].allocated = 0;
		kmallocBEGIN = 0;
	}

	if(isKHeapPlacementStrategyNEXTFIT()) {
		return nextFitAlgo(ROUNDUP(size, PAGE_SIZE)/PAGE_SIZE);
	}

	if(isKHeapPlacementStrategyBESTFIT()) {
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
}

void kfree(void* virtual_address) {
	//TODO: [PROJECT 2022 - [2] Kernel Heap] kfree()
	// Write your code here, remove the panic and write your code
	//panic("kfree() is not implemented yet...!!");

	//you need to get the size of the given allocation using its address
	//refer to the project presentation and documentation for details

	if(freeBEGIN) {
		fIDX = 0;
		freeBEGIN = 0;
	}

	int idx = 0;
	while(idx != -1) {
		if(kHeapArr[idx].starter == (uint32) virtual_address) break;
		idx = kHeapArr[idx].last;
		if(idx == -1) return;
	}

	kHeapArr[idx].allocated = 0;
	uint32 pages = kHeapArr[idx].pages;

	if(!isKHeapPlacementStrategyCONTALLOC()) {
		int first = kHeapArr[idx].first;
		int last = kHeapArr[idx].last;

		if(last != -1 && !kHeapArr[last].allocated) {
			kHeapArr[idx].pages += kHeapArr[last].pages;
			kHeapArr[last].first = idx;
			kHeapArr[idx].last = kHeapArr[last].last;
			x = last;
		}

		first = kHeapArr[idx].first;
		last = kHeapArr[idx].last;

		if(first != -1 && !kHeapArr[first].allocated) {
			kHeapArr[first].pages += kHeapArr[idx].pages;
			kHeapArr[last].first = first;
			kHeapArr[first].last = last;
			y = idx;
		}
	}

	for(int i=0; i<pages; i++, virtual_address+=PAGE_SIZE)
		unmap_frame(ptr_page_directory,virtual_address);
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
