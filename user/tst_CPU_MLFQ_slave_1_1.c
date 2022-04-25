#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 3; ++i) {
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),0);
		sys_run_env(ID);
	}
	env_sleep(50);

	ID = sys_create_env("cpuMLFQ1Slave_2", (myEnv->page_WS_max_size), 0);
	sys_run_env(ID);

	env_sleep(5000);

	return;
}


