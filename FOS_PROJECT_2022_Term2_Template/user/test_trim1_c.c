///MAKE SUR PAGE_WS_MAX_SIZE = 250
#include <inc/lib.h>

uint32 remainingfreeframes;
uint32 requiredMemFrames;
uint32 extraFramesNeeded ;
uint32 memFramesToAllocate;

void _main(void)
{
	remainingfreeframes = sys_calculate_free_frames();
	memFramesToAllocate = (remainingfreeframes+0);

	requiredMemFrames = sys_calculate_required_frames(USER_HEAP_START, memFramesToAllocate*PAGE_SIZE);
	extraFramesNeeded = requiredMemFrames - remainingfreeframes;
	
	//cprintf("remaining frames = %d\n",remainingfreeframes);
	//cprintf("frames desired to be allocated = %d\n",memFramesToAllocate);
	//cprintf("req frames = %d\n",requiredMemFrames);
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
	char* x = malloc(sizeof(char)*size);

	uint32 i=0;
	for(i=0; i<size;i++ )
	{
		x[i]=-1;
	}

	uint32 all_frames_to_be_trimmed = ROUNDUP(extraFramesNeeded*2, 3);
	uint32 frames_to_trimmed_every_env = all_frames_to_be_trimmed/3;

	cprintf("Frames to be trimmed from A or B = %d\n", frames_to_trimmed_every_env);

	return;	
}

