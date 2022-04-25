/* See COPYRIGHT for copyright information. */
#include <inc/mmu.h>
#include <inc/x86.h>
#include <inc/assert.h>

#include <kern/memory_manager.h>
#include <kern/console.h>
#include <kern/command_prompt.h>
#include <kern/user_environment.h>
#include <kern/file_manager.h>
#include <kern/syscall.h>
#include <kern/sched.h>
#include <kern/kclock.h>
#include <kern/utilities.h>

void schenv()
{
	__nl = 0;
	__ne = NULL;
	for (int i = 0; i < num_of_ready_queues; ++i)
	{
		if (queue_size(&(env_ready_queues[i])))
		{
			__ne = LIST_LAST(&(env_ready_queues[i]));
			__nl = i;
			break;
		}
	}
	if (curenv != NULL)
	{
		if (__ne != NULL)
		{
			if ((__pl + 1) < __nl)
			{
				__ne = curenv;
				__nl = __pl < num_of_ready_queues-1? __pl + 1 : __pl ;
			}
		}
		else
		{
			__ne = curenv;
			__nl = __pl < num_of_ready_queues-1? __pl + 1 : __pl ;
		}
	}
}

void chksch(uint8 onoff)
{
	__pe = NULL;
	__ne = NULL;
	__pl = 0 ;
	__nl = 0 ;
	__chkstatus = onoff;
}
void chk1()
{
	if (__chkstatus == 0)
		return ;
	__pe = curenv;
	__pl = __nl ;
	if (__pe == NULL)
	{
		__pl = 0;
	}
	//cprintf("chk1: current = %s @ level %d\n", __pe == NULL? "NULL" : __pe->prog_name, __pl);
	schenv();
}
void chk2(struct Env* __se)
{
	if (__chkstatus == 0)
		return ;

	//cprintf("chk2: next = %s @ level %d\n", __ne == NULL? "NULL" : __ne->prog_name, __nl);

	assert_endall(__se == __ne);
	//cprintf("%d - %d\n", kclock_read_cnt0_latch() , TIMER_DIV((1000/quantums[__nl])));

	if (__ne != NULL)
	{
		uint16 upper = TIMER_DIV((1000/quantums[__nl])) ;
		uint16 lower = 90 * upper / 100 ;
		uint16 current = kclock_read_cnt0_latch();
		//cprintf("current = %d, lower = %d, upper = %d\n", current, lower, upper);
		assert_endall(current > lower && current <= upper) ;

		for (int i = 0; i < num_of_ready_queues; ++i)
		{
			assert_endall(find_env_in_queue(&(env_ready_queues[i]), __ne->env_id) == NULL);
		}
	}
	if (__pe != NULL && __pe != __ne)
	{
		uint8 __tl = __pl == num_of_ready_queues-1 ? __pl : __pl + 1 ;
		assert_endall(find_env_in_queue(&(env_ready_queues[__tl]), __pe->env_id) != NULL);
		for (int i = 0; i < num_of_ready_queues; ++i)
		{
			if (i == __tl) continue;
			assert_endall(find_env_in_queue(&(env_ready_queues[i]), __pe->env_id) == NULL) ;
		}
	}
}
