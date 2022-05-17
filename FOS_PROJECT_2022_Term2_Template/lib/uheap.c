#include <inc/lib.h>

#define Mega (1024*1024)
#define kilo (1024)

// malloc()
//	This function use NEXT FIT strategy to allocate space in heap
//  with the given size and return void pointer to the start of the allocated space

//	To do this, we need to switch to the kernel, allocate the required space
//	in Page File then switch back to the user again.
//
//	We can use sys_allocateMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls allocateMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the allocateMem function is empty, make sure to implement it.


//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

uint32 startAdd = USER_HEAP_START;
bool checkList[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE] = {0};

struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
			newSize += PAGE_SIZE;
			newAdd += PAGE_SIZE;
			spacePages--;
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
			flag = 1;
			tmp = newAdd;
			newSize += PAGE_SIZE;
			newAdd += PAGE_SIZE;
			spacePages--;
		} else {
			if(newSize >= size) {
				startAdd = tmp;
				found = 1;
				break;
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
			flag = newSize = 0;
		}

		if(newSize >= size) {
			startAdd = tmp;
			found = 1;
			break;
		}

		if(newAdd >= USER_HEAP_MAX) {
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
		if(newSize < size) return NULL;
		else startAdd = tmp;
	}

	uint32 returnHolder = startAdd;

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
	checkList[newAdd] = size/PAGE_SIZE;
	sys_allocateMem(startAdd, size);

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;

	return (void*)returnHolder;
}

void* malloc(uint32 size) {
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	//panic("malloc() is not implemented yet...!!");

	// Steps:
	//	1) Implement NEXT FIT strategy to search the heap for suitable space
	//		to the required allocation size (space should be on 4 KB BOUNDARY)
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	//This function should find the space of the required range
	// ******** ON 4KB BOUNDARY ******************* //

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
		return nextFitAlgo(size);
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
	panic("smalloc() is not required ..!!");
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
	panic("sget() is not required ..!!");
	return 0;
}

// free():
//	This function frees the allocation of the given virtual_address
//	To do this, we need to switch to the kernel, free the pages AND "EMPTY" PAGE TABLES
//	from page file and main memory then switch back to the user again.
//
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	//panic("free() is not implemented yet...!!");

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
		if (uHeapArr[i].first == (uint32)virtual_address) {
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
			size = uHeapArr[i].size;
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
}


void sfree(void* virtual_address)
{
	panic("sfree() is not requried ..!!");
}


//===============
// [2] realloc():
//===============

//	Attempts to resize the allocated space at "virtual_address" to "new_size" bytes,
//	possibly moving it in the heap.
//	If successful, returns the new virtual_address, in which case the old virtual_address must no longer be accessed.
//	On failure, returns a null pointer, and the old virtual_address remains valid.

//	A call with virtual_address = null is equivalent to malloc().
//	A call with new_size = zero is equivalent to free().

//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");

	return NULL;
}
