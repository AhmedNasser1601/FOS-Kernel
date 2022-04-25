#include <inc/lib.h>

void _main(void)
{
	// For EXIT
	int ID = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), 0);
	sys_run_env(ID);
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size), 0);
	sys_run_env(ID);
	//============

	for (int i = 0; i < 3; ++i) {
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), 0);
			sys_run_env(ID);
		}
	env_sleep(10000);

	ID = sys_create_env("cpuMLFQ1Slave_1", (myEnv->page_WS_max_size), 0);
	sys_run_env(ID);

	// To wait till other queues filled with other processes
	env_sleep(10000);


	// To check that the slave environments completed successfully
	rsttst();

	env_sleep(200);
}
