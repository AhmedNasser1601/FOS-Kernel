#include <inc/lib.h>

int first = 1;
uint32 ws_size_first=0;

void _main(void)
{
	if(first == 1)
	{
		first = 0;

		int envID = sys_getenvid();
		cprintf("envID = %d\n",envID);


		uint32 i=0;
		/*
		cprintf("WS:\n");
		for(; i< PAGE_WS_MAX_SIZE; i++)
		{
		cprintf("# %d = %x ",i ,myEnv->__uptr_pws[i].virtual_address);
		if(myEnv->__uptr_pws[i].empty == 1)
		{
		cprintf(",  empty");
		}
		cprintf("\n");
		}
		*/

		cprintf("testing trim: hello from B\n");
		i=0;
		for(; i< (myEnv->page_WS_max_size); i++)
		{
			if(myEnv->__uptr_pws[i].empty == 0)
			{
				ws_size_first++;
			}
		}
		//cprintf("ws_size_first = %d\n",ws_size_first);
	}
	else
	{
		int envID = sys_getenvid();
		cprintf("envID = %d\n",envID);

		uint32 i=0;
		/*
		cprintf("WS:\n");
		for(; i< PAGE_WS_MAX_SIZE; i++)
		{
		cprintf("# %d = %x ",i ,myEnv->__uptr_pws[i].virtual_address);
		if(myEnv->__uptr_pws[i].empty == 1)
		{
		cprintf(",  empty");
		}
		cprintf("\n");
		}
		*/

		i=0;
		uint32 ws_size=0;
		for(; i< (myEnv->page_WS_max_size); i++)
		{
			if(myEnv->__uptr_pws[i].empty == 0)
			{
				ws_size++;
			}
		}

		uint32 reduced_frames = ws_size_first-ws_size;
		//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 B: WS size after trimming is reduced by %d frames\n", reduced_frames);
	}
}

