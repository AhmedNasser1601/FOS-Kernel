
obj/user/tst_envfree2:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 1c 01 00 00       	call   800152 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	// Testing scenario 2: using dynamic allocation and free
	// Testing removing the allocated pages (static & dynamic) in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 c8 13 00 00       	call   80140b <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 43 14 00 00       	call   80148e <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 e0 1b 80 00       	push   $0x801be0
  800059:	e8 b7 04 00 00       	call   800515 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes
	int32 envIdProcessA = sys_create_env("ef_ms1", 10, 50);
  800061:	83 ec 04             	sub    $0x4,%esp
  800064:	6a 32                	push   $0x32
  800066:	6a 0a                	push   $0xa
  800068:	68 13 1c 80 00       	push   $0x801c13
  80006d:	e8 ee 15 00 00       	call   801660 <sys_create_env>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_ms2", 7, 50);
  800078:	83 ec 04             	sub    $0x4,%esp
  80007b:	6a 32                	push   $0x32
  80007d:	6a 07                	push   $0x7
  80007f:	68 1a 1c 80 00       	push   $0x801c1a
  800084:	e8 d7 15 00 00       	call   801660 <sys_create_env>
  800089:	83 c4 10             	add    $0x10,%esp
  80008c:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	ff 75 ec             	pushl  -0x14(%ebp)
  800095:	e8 e3 15 00 00       	call   80167d <sys_run_env>
  80009a:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  80009d:	83 ec 0c             	sub    $0xc,%esp
  8000a0:	ff 75 e8             	pushl  -0x18(%ebp)
  8000a3:	e8 d5 15 00 00       	call   80167d <sys_run_env>
  8000a8:	83 c4 10             	add    $0x10,%esp

	env_sleep(30000);
  8000ab:	83 ec 0c             	sub    $0xc,%esp
  8000ae:	68 30 75 00 00       	push   $0x7530
  8000b3:	e8 01 18 00 00       	call   8018b9 <env_sleep>
  8000b8:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000bb:	e8 4b 13 00 00       	call   80140b <sys_calculate_free_frames>
  8000c0:	83 ec 08             	sub    $0x8,%esp
  8000c3:	50                   	push   %eax
  8000c4:	68 24 1c 80 00       	push   $0x801c24
  8000c9:	e8 47 04 00 00       	call   800515 <cprintf>
  8000ce:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 bd 15 00 00       	call   801699 <sys_free_env>
  8000dc:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 e8             	pushl  -0x18(%ebp)
  8000e5:	e8 af 15 00 00       	call   801699 <sys_free_env>
  8000ea:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  8000ed:	e8 19 13 00 00       	call   80140b <sys_calculate_free_frames>
  8000f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  8000f5:	e8 94 13 00 00       	call   80148e <sys_pf_calculate_allocated_pages>
  8000fa:	89 45 e0             	mov    %eax,-0x20(%ebp)

	if ((freeFrames_after - freeFrames_before) != 0) {
  8000fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800100:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800103:	74 27                	je     80012c <_main+0xf4>
		cprintf("\n---# of free frames after closing running programs not as before running = %d\n",
  800105:	83 ec 08             	sub    $0x8,%esp
  800108:	ff 75 e4             	pushl  -0x1c(%ebp)
  80010b:	68 58 1c 80 00       	push   $0x801c58
  800110:	e8 00 04 00 00       	call   800515 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
				freeFrames_after);
		panic("env_free() does not work correctly... check it again.");
  800118:	83 ec 04             	sub    $0x4,%esp
  80011b:	68 a8 1c 80 00       	push   $0x801ca8
  800120:	6a 24                	push   $0x24
  800122:	68 de 1c 80 00       	push   $0x801cde
  800127:	e8 35 01 00 00       	call   800261 <_panic>
	}

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80012c:	83 ec 08             	sub    $0x8,%esp
  80012f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800132:	68 f4 1c 80 00       	push   $0x801cf4
  800137:	e8 d9 03 00 00       	call   800515 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 2 for envfree completed successfully.\n");
  80013f:	83 ec 0c             	sub    $0xc,%esp
  800142:	68 54 1d 80 00       	push   $0x801d54
  800147:	e8 c9 03 00 00       	call   800515 <cprintf>
  80014c:	83 c4 10             	add    $0x10,%esp
	return;
  80014f:	90                   	nop
}
  800150:	c9                   	leave  
  800151:	c3                   	ret    

00800152 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800152:	55                   	push   %ebp
  800153:	89 e5                	mov    %esp,%ebp
  800155:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800158:	e8 e3 11 00 00       	call   801340 <sys_getenvindex>
  80015d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800160:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800163:	89 d0                	mov    %edx,%eax
  800165:	c1 e0 02             	shl    $0x2,%eax
  800168:	01 d0                	add    %edx,%eax
  80016a:	01 c0                	add    %eax,%eax
  80016c:	01 d0                	add    %edx,%eax
  80016e:	01 c0                	add    %eax,%eax
  800170:	01 d0                	add    %edx,%eax
  800172:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800179:	01 d0                	add    %edx,%eax
  80017b:	c1 e0 02             	shl    $0x2,%eax
  80017e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800183:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800188:	a1 04 30 80 00       	mov    0x803004,%eax
  80018d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800193:	84 c0                	test   %al,%al
  800195:	74 0f                	je     8001a6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800197:	a1 04 30 80 00       	mov    0x803004,%eax
  80019c:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001a1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001aa:	7e 0a                	jle    8001b6 <libmain+0x64>
		binaryname = argv[0];
  8001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001af:	8b 00                	mov    (%eax),%eax
  8001b1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 0c             	pushl  0xc(%ebp)
  8001bc:	ff 75 08             	pushl  0x8(%ebp)
  8001bf:	e8 74 fe ff ff       	call   800038 <_main>
  8001c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001c7:	e8 0f 13 00 00       	call   8014db <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	68 b8 1d 80 00       	push   $0x801db8
  8001d4:	e8 3c 03 00 00       	call   800515 <cprintf>
  8001d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001dc:	a1 04 30 80 00       	mov    0x803004,%eax
  8001e1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001e7:	a1 04 30 80 00       	mov    0x803004,%eax
  8001ec:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	52                   	push   %edx
  8001f6:	50                   	push   %eax
  8001f7:	68 e0 1d 80 00       	push   $0x801de0
  8001fc:	e8 14 03 00 00       	call   800515 <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800204:	a1 04 30 80 00       	mov    0x803004,%eax
  800209:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80020f:	83 ec 08             	sub    $0x8,%esp
  800212:	50                   	push   %eax
  800213:	68 05 1e 80 00       	push   $0x801e05
  800218:	e8 f8 02 00 00       	call   800515 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 b8 1d 80 00       	push   $0x801db8
  800228:	e8 e8 02 00 00       	call   800515 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800230:	e8 c0 12 00 00       	call   8014f5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800235:	e8 19 00 00 00       	call   800253 <exit>
}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800243:	83 ec 0c             	sub    $0xc,%esp
  800246:	6a 00                	push   $0x0
  800248:	e8 bf 10 00 00       	call   80130c <sys_env_destroy>
  80024d:	83 c4 10             	add    $0x10,%esp
}
  800250:	90                   	nop
  800251:	c9                   	leave  
  800252:	c3                   	ret    

00800253 <exit>:

void
exit(void)
{
  800253:	55                   	push   %ebp
  800254:	89 e5                	mov    %esp,%ebp
  800256:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800259:	e8 14 11 00 00       	call   801372 <sys_env_exit>
}
  80025e:	90                   	nop
  80025f:	c9                   	leave  
  800260:	c3                   	ret    

00800261 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800261:	55                   	push   %ebp
  800262:	89 e5                	mov    %esp,%ebp
  800264:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800267:	8d 45 10             	lea    0x10(%ebp),%eax
  80026a:	83 c0 04             	add    $0x4,%eax
  80026d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800270:	a1 14 30 80 00       	mov    0x803014,%eax
  800275:	85 c0                	test   %eax,%eax
  800277:	74 16                	je     80028f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800279:	a1 14 30 80 00       	mov    0x803014,%eax
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	50                   	push   %eax
  800282:	68 1c 1e 80 00       	push   $0x801e1c
  800287:	e8 89 02 00 00       	call   800515 <cprintf>
  80028c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80028f:	a1 00 30 80 00       	mov    0x803000,%eax
  800294:	ff 75 0c             	pushl  0xc(%ebp)
  800297:	ff 75 08             	pushl  0x8(%ebp)
  80029a:	50                   	push   %eax
  80029b:	68 21 1e 80 00       	push   $0x801e21
  8002a0:	e8 70 02 00 00       	call   800515 <cprintf>
  8002a5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ab:	83 ec 08             	sub    $0x8,%esp
  8002ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b1:	50                   	push   %eax
  8002b2:	e8 f3 01 00 00       	call   8004aa <vcprintf>
  8002b7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	6a 00                	push   $0x0
  8002bf:	68 3d 1e 80 00       	push   $0x801e3d
  8002c4:	e8 e1 01 00 00       	call   8004aa <vcprintf>
  8002c9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002cc:	e8 82 ff ff ff       	call   800253 <exit>

	// should not return here
	while (1) ;
  8002d1:	eb fe                	jmp    8002d1 <_panic+0x70>

008002d3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002d3:	55                   	push   %ebp
  8002d4:	89 e5                	mov    %esp,%ebp
  8002d6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002d9:	a1 04 30 80 00       	mov    0x803004,%eax
  8002de:	8b 50 74             	mov    0x74(%eax),%edx
  8002e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e4:	39 c2                	cmp    %eax,%edx
  8002e6:	74 14                	je     8002fc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 40 1e 80 00       	push   $0x801e40
  8002f0:	6a 26                	push   $0x26
  8002f2:	68 8c 1e 80 00       	push   $0x801e8c
  8002f7:	e8 65 ff ff ff       	call   800261 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800303:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80030a:	e9 c2 00 00 00       	jmp    8003d1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80030f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 00                	mov    (%eax),%eax
  800320:	85 c0                	test   %eax,%eax
  800322:	75 08                	jne    80032c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800324:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800327:	e9 a2 00 00 00       	jmp    8003ce <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80032c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800333:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80033a:	eb 69                	jmp    8003a5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80033c:	a1 04 30 80 00       	mov    0x803004,%eax
  800341:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800347:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80034a:	89 d0                	mov    %edx,%eax
  80034c:	01 c0                	add    %eax,%eax
  80034e:	01 d0                	add    %edx,%eax
  800350:	c1 e0 02             	shl    $0x2,%eax
  800353:	01 c8                	add    %ecx,%eax
  800355:	8a 40 04             	mov    0x4(%eax),%al
  800358:	84 c0                	test   %al,%al
  80035a:	75 46                	jne    8003a2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80035c:	a1 04 30 80 00       	mov    0x803004,%eax
  800361:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800367:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80036a:	89 d0                	mov    %edx,%eax
  80036c:	01 c0                	add    %eax,%eax
  80036e:	01 d0                	add    %edx,%eax
  800370:	c1 e0 02             	shl    $0x2,%eax
  800373:	01 c8                	add    %ecx,%eax
  800375:	8b 00                	mov    (%eax),%eax
  800377:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80037a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80037d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800382:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800384:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800387:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80038e:	8b 45 08             	mov    0x8(%ebp),%eax
  800391:	01 c8                	add    %ecx,%eax
  800393:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800395:	39 c2                	cmp    %eax,%edx
  800397:	75 09                	jne    8003a2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800399:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003a0:	eb 12                	jmp    8003b4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a2:	ff 45 e8             	incl   -0x18(%ebp)
  8003a5:	a1 04 30 80 00       	mov    0x803004,%eax
  8003aa:	8b 50 74             	mov    0x74(%eax),%edx
  8003ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003b0:	39 c2                	cmp    %eax,%edx
  8003b2:	77 88                	ja     80033c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003b8:	75 14                	jne    8003ce <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003ba:	83 ec 04             	sub    $0x4,%esp
  8003bd:	68 98 1e 80 00       	push   $0x801e98
  8003c2:	6a 3a                	push   $0x3a
  8003c4:	68 8c 1e 80 00       	push   $0x801e8c
  8003c9:	e8 93 fe ff ff       	call   800261 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ce:	ff 45 f0             	incl   -0x10(%ebp)
  8003d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003d7:	0f 8c 32 ff ff ff    	jl     80030f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003eb:	eb 26                	jmp    800413 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003ed:	a1 04 30 80 00       	mov    0x803004,%eax
  8003f2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003fb:	89 d0                	mov    %edx,%eax
  8003fd:	01 c0                	add    %eax,%eax
  8003ff:	01 d0                	add    %edx,%eax
  800401:	c1 e0 02             	shl    $0x2,%eax
  800404:	01 c8                	add    %ecx,%eax
  800406:	8a 40 04             	mov    0x4(%eax),%al
  800409:	3c 01                	cmp    $0x1,%al
  80040b:	75 03                	jne    800410 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80040d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800410:	ff 45 e0             	incl   -0x20(%ebp)
  800413:	a1 04 30 80 00       	mov    0x803004,%eax
  800418:	8b 50 74             	mov    0x74(%eax),%edx
  80041b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80041e:	39 c2                	cmp    %eax,%edx
  800420:	77 cb                	ja     8003ed <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800422:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800425:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800428:	74 14                	je     80043e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80042a:	83 ec 04             	sub    $0x4,%esp
  80042d:	68 ec 1e 80 00       	push   $0x801eec
  800432:	6a 44                	push   $0x44
  800434:	68 8c 1e 80 00       	push   $0x801e8c
  800439:	e8 23 fe ff ff       	call   800261 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80043e:	90                   	nop
  80043f:	c9                   	leave  
  800440:	c3                   	ret    

00800441 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800441:	55                   	push   %ebp
  800442:	89 e5                	mov    %esp,%ebp
  800444:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800447:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044a:	8b 00                	mov    (%eax),%eax
  80044c:	8d 48 01             	lea    0x1(%eax),%ecx
  80044f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800452:	89 0a                	mov    %ecx,(%edx)
  800454:	8b 55 08             	mov    0x8(%ebp),%edx
  800457:	88 d1                	mov    %dl,%cl
  800459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80045c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800460:	8b 45 0c             	mov    0xc(%ebp),%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	3d ff 00 00 00       	cmp    $0xff,%eax
  80046a:	75 2c                	jne    800498 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80046c:	a0 08 30 80 00       	mov    0x803008,%al
  800471:	0f b6 c0             	movzbl %al,%eax
  800474:	8b 55 0c             	mov    0xc(%ebp),%edx
  800477:	8b 12                	mov    (%edx),%edx
  800479:	89 d1                	mov    %edx,%ecx
  80047b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80047e:	83 c2 08             	add    $0x8,%edx
  800481:	83 ec 04             	sub    $0x4,%esp
  800484:	50                   	push   %eax
  800485:	51                   	push   %ecx
  800486:	52                   	push   %edx
  800487:	e8 3e 0e 00 00       	call   8012ca <sys_cputs>
  80048c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80048f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800492:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049b:	8b 40 04             	mov    0x4(%eax),%eax
  80049e:	8d 50 01             	lea    0x1(%eax),%edx
  8004a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004a7:	90                   	nop
  8004a8:	c9                   	leave  
  8004a9:	c3                   	ret    

008004aa <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004aa:	55                   	push   %ebp
  8004ab:	89 e5                	mov    %esp,%ebp
  8004ad:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004b3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004ba:	00 00 00 
	b.cnt = 0;
  8004bd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004c4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004c7:	ff 75 0c             	pushl  0xc(%ebp)
  8004ca:	ff 75 08             	pushl  0x8(%ebp)
  8004cd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004d3:	50                   	push   %eax
  8004d4:	68 41 04 80 00       	push   $0x800441
  8004d9:	e8 11 02 00 00       	call   8006ef <vprintfmt>
  8004de:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004e1:	a0 08 30 80 00       	mov    0x803008,%al
  8004e6:	0f b6 c0             	movzbl %al,%eax
  8004e9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004ef:	83 ec 04             	sub    $0x4,%esp
  8004f2:	50                   	push   %eax
  8004f3:	52                   	push   %edx
  8004f4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004fa:	83 c0 08             	add    $0x8,%eax
  8004fd:	50                   	push   %eax
  8004fe:	e8 c7 0d 00 00       	call   8012ca <sys_cputs>
  800503:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800506:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80050d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800513:	c9                   	leave  
  800514:	c3                   	ret    

00800515 <cprintf>:

int cprintf(const char *fmt, ...) {
  800515:	55                   	push   %ebp
  800516:	89 e5                	mov    %esp,%ebp
  800518:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80051b:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800522:	8d 45 0c             	lea    0xc(%ebp),%eax
  800525:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	83 ec 08             	sub    $0x8,%esp
  80052e:	ff 75 f4             	pushl  -0xc(%ebp)
  800531:	50                   	push   %eax
  800532:	e8 73 ff ff ff       	call   8004aa <vcprintf>
  800537:	83 c4 10             	add    $0x10,%esp
  80053a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80053d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800540:	c9                   	leave  
  800541:	c3                   	ret    

00800542 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800542:	55                   	push   %ebp
  800543:	89 e5                	mov    %esp,%ebp
  800545:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800548:	e8 8e 0f 00 00       	call   8014db <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80054d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800550:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800553:	8b 45 08             	mov    0x8(%ebp),%eax
  800556:	83 ec 08             	sub    $0x8,%esp
  800559:	ff 75 f4             	pushl  -0xc(%ebp)
  80055c:	50                   	push   %eax
  80055d:	e8 48 ff ff ff       	call   8004aa <vcprintf>
  800562:	83 c4 10             	add    $0x10,%esp
  800565:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800568:	e8 88 0f 00 00       	call   8014f5 <sys_enable_interrupt>
	return cnt;
  80056d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800570:	c9                   	leave  
  800571:	c3                   	ret    

00800572 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800572:	55                   	push   %ebp
  800573:	89 e5                	mov    %esp,%ebp
  800575:	53                   	push   %ebx
  800576:	83 ec 14             	sub    $0x14,%esp
  800579:	8b 45 10             	mov    0x10(%ebp),%eax
  80057c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80057f:	8b 45 14             	mov    0x14(%ebp),%eax
  800582:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800585:	8b 45 18             	mov    0x18(%ebp),%eax
  800588:	ba 00 00 00 00       	mov    $0x0,%edx
  80058d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800590:	77 55                	ja     8005e7 <printnum+0x75>
  800592:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800595:	72 05                	jb     80059c <printnum+0x2a>
  800597:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80059a:	77 4b                	ja     8005e7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80059c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80059f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005a2:	8b 45 18             	mov    0x18(%ebp),%eax
  8005a5:	ba 00 00 00 00       	mov    $0x0,%edx
  8005aa:	52                   	push   %edx
  8005ab:	50                   	push   %eax
  8005ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8005af:	ff 75 f0             	pushl  -0x10(%ebp)
  8005b2:	e8 b9 13 00 00       	call   801970 <__udivdi3>
  8005b7:	83 c4 10             	add    $0x10,%esp
  8005ba:	83 ec 04             	sub    $0x4,%esp
  8005bd:	ff 75 20             	pushl  0x20(%ebp)
  8005c0:	53                   	push   %ebx
  8005c1:	ff 75 18             	pushl  0x18(%ebp)
  8005c4:	52                   	push   %edx
  8005c5:	50                   	push   %eax
  8005c6:	ff 75 0c             	pushl  0xc(%ebp)
  8005c9:	ff 75 08             	pushl  0x8(%ebp)
  8005cc:	e8 a1 ff ff ff       	call   800572 <printnum>
  8005d1:	83 c4 20             	add    $0x20,%esp
  8005d4:	eb 1a                	jmp    8005f0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005d6:	83 ec 08             	sub    $0x8,%esp
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 20             	pushl  0x20(%ebp)
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	ff d0                	call   *%eax
  8005e4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005e7:	ff 4d 1c             	decl   0x1c(%ebp)
  8005ea:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005ee:	7f e6                	jg     8005d6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005f0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005f3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fe:	53                   	push   %ebx
  8005ff:	51                   	push   %ecx
  800600:	52                   	push   %edx
  800601:	50                   	push   %eax
  800602:	e8 79 14 00 00       	call   801a80 <__umoddi3>
  800607:	83 c4 10             	add    $0x10,%esp
  80060a:	05 54 21 80 00       	add    $0x802154,%eax
  80060f:	8a 00                	mov    (%eax),%al
  800611:	0f be c0             	movsbl %al,%eax
  800614:	83 ec 08             	sub    $0x8,%esp
  800617:	ff 75 0c             	pushl  0xc(%ebp)
  80061a:	50                   	push   %eax
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	ff d0                	call   *%eax
  800620:	83 c4 10             	add    $0x10,%esp
}
  800623:	90                   	nop
  800624:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800627:	c9                   	leave  
  800628:	c3                   	ret    

00800629 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800629:	55                   	push   %ebp
  80062a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80062c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800630:	7e 1c                	jle    80064e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	8b 00                	mov    (%eax),%eax
  800637:	8d 50 08             	lea    0x8(%eax),%edx
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	89 10                	mov    %edx,(%eax)
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	83 e8 08             	sub    $0x8,%eax
  800647:	8b 50 04             	mov    0x4(%eax),%edx
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	eb 40                	jmp    80068e <getuint+0x65>
	else if (lflag)
  80064e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800652:	74 1e                	je     800672 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	8d 50 04             	lea    0x4(%eax),%edx
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	89 10                	mov    %edx,(%eax)
  800661:	8b 45 08             	mov    0x8(%ebp),%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	83 e8 04             	sub    $0x4,%eax
  800669:	8b 00                	mov    (%eax),%eax
  80066b:	ba 00 00 00 00       	mov    $0x0,%edx
  800670:	eb 1c                	jmp    80068e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8b 00                	mov    (%eax),%eax
  800677:	8d 50 04             	lea    0x4(%eax),%edx
  80067a:	8b 45 08             	mov    0x8(%ebp),%eax
  80067d:	89 10                	mov    %edx,(%eax)
  80067f:	8b 45 08             	mov    0x8(%ebp),%eax
  800682:	8b 00                	mov    (%eax),%eax
  800684:	83 e8 04             	sub    $0x4,%eax
  800687:	8b 00                	mov    (%eax),%eax
  800689:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80068e:	5d                   	pop    %ebp
  80068f:	c3                   	ret    

00800690 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800690:	55                   	push   %ebp
  800691:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800693:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800697:	7e 1c                	jle    8006b5 <getint+0x25>
		return va_arg(*ap, long long);
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	8d 50 08             	lea    0x8(%eax),%edx
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	89 10                	mov    %edx,(%eax)
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	83 e8 08             	sub    $0x8,%eax
  8006ae:	8b 50 04             	mov    0x4(%eax),%edx
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	eb 38                	jmp    8006ed <getint+0x5d>
	else if (lflag)
  8006b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006b9:	74 1a                	je     8006d5 <getint+0x45>
		return va_arg(*ap, long);
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	8d 50 04             	lea    0x4(%eax),%edx
  8006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c6:	89 10                	mov    %edx,(%eax)
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8b 00                	mov    (%eax),%eax
  8006cd:	83 e8 04             	sub    $0x4,%eax
  8006d0:	8b 00                	mov    (%eax),%eax
  8006d2:	99                   	cltd   
  8006d3:	eb 18                	jmp    8006ed <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	8b 00                	mov    (%eax),%eax
  8006da:	8d 50 04             	lea    0x4(%eax),%edx
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	89 10                	mov    %edx,(%eax)
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	83 e8 04             	sub    $0x4,%eax
  8006ea:	8b 00                	mov    (%eax),%eax
  8006ec:	99                   	cltd   
}
  8006ed:	5d                   	pop    %ebp
  8006ee:	c3                   	ret    

008006ef <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006ef:	55                   	push   %ebp
  8006f0:	89 e5                	mov    %esp,%ebp
  8006f2:	56                   	push   %esi
  8006f3:	53                   	push   %ebx
  8006f4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006f7:	eb 17                	jmp    800710 <vprintfmt+0x21>
			if (ch == '\0')
  8006f9:	85 db                	test   %ebx,%ebx
  8006fb:	0f 84 af 03 00 00    	je     800ab0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	53                   	push   %ebx
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	ff d0                	call   *%eax
  80070d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800710:	8b 45 10             	mov    0x10(%ebp),%eax
  800713:	8d 50 01             	lea    0x1(%eax),%edx
  800716:	89 55 10             	mov    %edx,0x10(%ebp)
  800719:	8a 00                	mov    (%eax),%al
  80071b:	0f b6 d8             	movzbl %al,%ebx
  80071e:	83 fb 25             	cmp    $0x25,%ebx
  800721:	75 d6                	jne    8006f9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800723:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800727:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80072e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800735:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80073c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800743:	8b 45 10             	mov    0x10(%ebp),%eax
  800746:	8d 50 01             	lea    0x1(%eax),%edx
  800749:	89 55 10             	mov    %edx,0x10(%ebp)
  80074c:	8a 00                	mov    (%eax),%al
  80074e:	0f b6 d8             	movzbl %al,%ebx
  800751:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800754:	83 f8 55             	cmp    $0x55,%eax
  800757:	0f 87 2b 03 00 00    	ja     800a88 <vprintfmt+0x399>
  80075d:	8b 04 85 78 21 80 00 	mov    0x802178(,%eax,4),%eax
  800764:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800766:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80076a:	eb d7                	jmp    800743 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80076c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800770:	eb d1                	jmp    800743 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800772:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800779:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80077c:	89 d0                	mov    %edx,%eax
  80077e:	c1 e0 02             	shl    $0x2,%eax
  800781:	01 d0                	add    %edx,%eax
  800783:	01 c0                	add    %eax,%eax
  800785:	01 d8                	add    %ebx,%eax
  800787:	83 e8 30             	sub    $0x30,%eax
  80078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80078d:	8b 45 10             	mov    0x10(%ebp),%eax
  800790:	8a 00                	mov    (%eax),%al
  800792:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800795:	83 fb 2f             	cmp    $0x2f,%ebx
  800798:	7e 3e                	jle    8007d8 <vprintfmt+0xe9>
  80079a:	83 fb 39             	cmp    $0x39,%ebx
  80079d:	7f 39                	jg     8007d8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80079f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007a2:	eb d5                	jmp    800779 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a7:	83 c0 04             	add    $0x4,%eax
  8007aa:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b0:	83 e8 04             	sub    $0x4,%eax
  8007b3:	8b 00                	mov    (%eax),%eax
  8007b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007b8:	eb 1f                	jmp    8007d9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007ba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007be:	79 83                	jns    800743 <vprintfmt+0x54>
				width = 0;
  8007c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007c7:	e9 77 ff ff ff       	jmp    800743 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007cc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007d3:	e9 6b ff ff ff       	jmp    800743 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007d8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007dd:	0f 89 60 ff ff ff    	jns    800743 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007e9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007f0:	e9 4e ff ff ff       	jmp    800743 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007f5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007f8:	e9 46 ff ff ff       	jmp    800743 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007fd:	8b 45 14             	mov    0x14(%ebp),%eax
  800800:	83 c0 04             	add    $0x4,%eax
  800803:	89 45 14             	mov    %eax,0x14(%ebp)
  800806:	8b 45 14             	mov    0x14(%ebp),%eax
  800809:	83 e8 04             	sub    $0x4,%eax
  80080c:	8b 00                	mov    (%eax),%eax
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	50                   	push   %eax
  800815:	8b 45 08             	mov    0x8(%ebp),%eax
  800818:	ff d0                	call   *%eax
  80081a:	83 c4 10             	add    $0x10,%esp
			break;
  80081d:	e9 89 02 00 00       	jmp    800aab <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800822:	8b 45 14             	mov    0x14(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 14             	mov    %eax,0x14(%ebp)
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 e8 04             	sub    $0x4,%eax
  800831:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800833:	85 db                	test   %ebx,%ebx
  800835:	79 02                	jns    800839 <vprintfmt+0x14a>
				err = -err;
  800837:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800839:	83 fb 64             	cmp    $0x64,%ebx
  80083c:	7f 0b                	jg     800849 <vprintfmt+0x15a>
  80083e:	8b 34 9d c0 1f 80 00 	mov    0x801fc0(,%ebx,4),%esi
  800845:	85 f6                	test   %esi,%esi
  800847:	75 19                	jne    800862 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800849:	53                   	push   %ebx
  80084a:	68 65 21 80 00       	push   $0x802165
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	ff 75 08             	pushl  0x8(%ebp)
  800855:	e8 5e 02 00 00       	call   800ab8 <printfmt>
  80085a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80085d:	e9 49 02 00 00       	jmp    800aab <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800862:	56                   	push   %esi
  800863:	68 6e 21 80 00       	push   $0x80216e
  800868:	ff 75 0c             	pushl  0xc(%ebp)
  80086b:	ff 75 08             	pushl  0x8(%ebp)
  80086e:	e8 45 02 00 00       	call   800ab8 <printfmt>
  800873:	83 c4 10             	add    $0x10,%esp
			break;
  800876:	e9 30 02 00 00       	jmp    800aab <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80087b:	8b 45 14             	mov    0x14(%ebp),%eax
  80087e:	83 c0 04             	add    $0x4,%eax
  800881:	89 45 14             	mov    %eax,0x14(%ebp)
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 e8 04             	sub    $0x4,%eax
  80088a:	8b 30                	mov    (%eax),%esi
  80088c:	85 f6                	test   %esi,%esi
  80088e:	75 05                	jne    800895 <vprintfmt+0x1a6>
				p = "(null)";
  800890:	be 71 21 80 00       	mov    $0x802171,%esi
			if (width > 0 && padc != '-')
  800895:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800899:	7e 6d                	jle    800908 <vprintfmt+0x219>
  80089b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80089f:	74 67                	je     800908 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	50                   	push   %eax
  8008a8:	56                   	push   %esi
  8008a9:	e8 0c 03 00 00       	call   800bba <strnlen>
  8008ae:	83 c4 10             	add    $0x10,%esp
  8008b1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008b4:	eb 16                	jmp    8008cc <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008b6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 0c             	pushl  0xc(%ebp)
  8008c0:	50                   	push   %eax
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	ff d0                	call   *%eax
  8008c6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008c9:	ff 4d e4             	decl   -0x1c(%ebp)
  8008cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d0:	7f e4                	jg     8008b6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008d2:	eb 34                	jmp    800908 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008d4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008d8:	74 1c                	je     8008f6 <vprintfmt+0x207>
  8008da:	83 fb 1f             	cmp    $0x1f,%ebx
  8008dd:	7e 05                	jle    8008e4 <vprintfmt+0x1f5>
  8008df:	83 fb 7e             	cmp    $0x7e,%ebx
  8008e2:	7e 12                	jle    8008f6 <vprintfmt+0x207>
					putch('?', putdat);
  8008e4:	83 ec 08             	sub    $0x8,%esp
  8008e7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ea:	6a 3f                	push   $0x3f
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	ff d0                	call   *%eax
  8008f1:	83 c4 10             	add    $0x10,%esp
  8008f4:	eb 0f                	jmp    800905 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008f6:	83 ec 08             	sub    $0x8,%esp
  8008f9:	ff 75 0c             	pushl  0xc(%ebp)
  8008fc:	53                   	push   %ebx
  8008fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800900:	ff d0                	call   *%eax
  800902:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800905:	ff 4d e4             	decl   -0x1c(%ebp)
  800908:	89 f0                	mov    %esi,%eax
  80090a:	8d 70 01             	lea    0x1(%eax),%esi
  80090d:	8a 00                	mov    (%eax),%al
  80090f:	0f be d8             	movsbl %al,%ebx
  800912:	85 db                	test   %ebx,%ebx
  800914:	74 24                	je     80093a <vprintfmt+0x24b>
  800916:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80091a:	78 b8                	js     8008d4 <vprintfmt+0x1e5>
  80091c:	ff 4d e0             	decl   -0x20(%ebp)
  80091f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800923:	79 af                	jns    8008d4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800925:	eb 13                	jmp    80093a <vprintfmt+0x24b>
				putch(' ', putdat);
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	6a 20                	push   $0x20
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	ff d0                	call   *%eax
  800934:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800937:	ff 4d e4             	decl   -0x1c(%ebp)
  80093a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80093e:	7f e7                	jg     800927 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800940:	e9 66 01 00 00       	jmp    800aab <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800945:	83 ec 08             	sub    $0x8,%esp
  800948:	ff 75 e8             	pushl  -0x18(%ebp)
  80094b:	8d 45 14             	lea    0x14(%ebp),%eax
  80094e:	50                   	push   %eax
  80094f:	e8 3c fd ff ff       	call   800690 <getint>
  800954:	83 c4 10             	add    $0x10,%esp
  800957:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80095d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800960:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800963:	85 d2                	test   %edx,%edx
  800965:	79 23                	jns    80098a <vprintfmt+0x29b>
				putch('-', putdat);
  800967:	83 ec 08             	sub    $0x8,%esp
  80096a:	ff 75 0c             	pushl  0xc(%ebp)
  80096d:	6a 2d                	push   $0x2d
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	ff d0                	call   *%eax
  800974:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800977:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80097a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80097d:	f7 d8                	neg    %eax
  80097f:	83 d2 00             	adc    $0x0,%edx
  800982:	f7 da                	neg    %edx
  800984:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800987:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80098a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800991:	e9 bc 00 00 00       	jmp    800a52 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800996:	83 ec 08             	sub    $0x8,%esp
  800999:	ff 75 e8             	pushl  -0x18(%ebp)
  80099c:	8d 45 14             	lea    0x14(%ebp),%eax
  80099f:	50                   	push   %eax
  8009a0:	e8 84 fc ff ff       	call   800629 <getuint>
  8009a5:	83 c4 10             	add    $0x10,%esp
  8009a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009ae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009b5:	e9 98 00 00 00       	jmp    800a52 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	ff 75 0c             	pushl  0xc(%ebp)
  8009c0:	6a 58                	push   $0x58
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	ff d0                	call   *%eax
  8009c7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ca:	83 ec 08             	sub    $0x8,%esp
  8009cd:	ff 75 0c             	pushl  0xc(%ebp)
  8009d0:	6a 58                	push   $0x58
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	ff d0                	call   *%eax
  8009d7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	6a 58                	push   $0x58
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	ff d0                	call   *%eax
  8009e7:	83 c4 10             	add    $0x10,%esp
			break;
  8009ea:	e9 bc 00 00 00       	jmp    800aab <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 0c             	pushl  0xc(%ebp)
  8009f5:	6a 30                	push   $0x30
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009ff:	83 ec 08             	sub    $0x8,%esp
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	6a 78                	push   $0x78
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	ff d0                	call   *%eax
  800a0c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a12:	83 c0 04             	add    $0x4,%eax
  800a15:	89 45 14             	mov    %eax,0x14(%ebp)
  800a18:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1b:	83 e8 04             	sub    $0x4,%eax
  800a1e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a2a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a31:	eb 1f                	jmp    800a52 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a33:	83 ec 08             	sub    $0x8,%esp
  800a36:	ff 75 e8             	pushl  -0x18(%ebp)
  800a39:	8d 45 14             	lea    0x14(%ebp),%eax
  800a3c:	50                   	push   %eax
  800a3d:	e8 e7 fb ff ff       	call   800629 <getuint>
  800a42:	83 c4 10             	add    $0x10,%esp
  800a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a4b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a52:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a56:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a59:	83 ec 04             	sub    $0x4,%esp
  800a5c:	52                   	push   %edx
  800a5d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a60:	50                   	push   %eax
  800a61:	ff 75 f4             	pushl  -0xc(%ebp)
  800a64:	ff 75 f0             	pushl  -0x10(%ebp)
  800a67:	ff 75 0c             	pushl  0xc(%ebp)
  800a6a:	ff 75 08             	pushl  0x8(%ebp)
  800a6d:	e8 00 fb ff ff       	call   800572 <printnum>
  800a72:	83 c4 20             	add    $0x20,%esp
			break;
  800a75:	eb 34                	jmp    800aab <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	53                   	push   %ebx
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	ff d0                	call   *%eax
  800a83:	83 c4 10             	add    $0x10,%esp
			break;
  800a86:	eb 23                	jmp    800aab <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a88:	83 ec 08             	sub    $0x8,%esp
  800a8b:	ff 75 0c             	pushl  0xc(%ebp)
  800a8e:	6a 25                	push   $0x25
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	ff d0                	call   *%eax
  800a95:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a98:	ff 4d 10             	decl   0x10(%ebp)
  800a9b:	eb 03                	jmp    800aa0 <vprintfmt+0x3b1>
  800a9d:	ff 4d 10             	decl   0x10(%ebp)
  800aa0:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa3:	48                   	dec    %eax
  800aa4:	8a 00                	mov    (%eax),%al
  800aa6:	3c 25                	cmp    $0x25,%al
  800aa8:	75 f3                	jne    800a9d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aaa:	90                   	nop
		}
	}
  800aab:	e9 47 fc ff ff       	jmp    8006f7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ab0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ab1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ab4:	5b                   	pop    %ebx
  800ab5:	5e                   	pop    %esi
  800ab6:	5d                   	pop    %ebp
  800ab7:	c3                   	ret    

00800ab8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ab8:	55                   	push   %ebp
  800ab9:	89 e5                	mov    %esp,%ebp
  800abb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800abe:	8d 45 10             	lea    0x10(%ebp),%eax
  800ac1:	83 c0 04             	add    $0x4,%eax
  800ac4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ac7:	8b 45 10             	mov    0x10(%ebp),%eax
  800aca:	ff 75 f4             	pushl  -0xc(%ebp)
  800acd:	50                   	push   %eax
  800ace:	ff 75 0c             	pushl  0xc(%ebp)
  800ad1:	ff 75 08             	pushl  0x8(%ebp)
  800ad4:	e8 16 fc ff ff       	call   8006ef <vprintfmt>
  800ad9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800adc:	90                   	nop
  800add:	c9                   	leave  
  800ade:	c3                   	ret    

00800adf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800adf:	55                   	push   %ebp
  800ae0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ae2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae5:	8b 40 08             	mov    0x8(%eax),%eax
  800ae8:	8d 50 01             	lea    0x1(%eax),%edx
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800af1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af4:	8b 10                	mov    (%eax),%edx
  800af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af9:	8b 40 04             	mov    0x4(%eax),%eax
  800afc:	39 c2                	cmp    %eax,%edx
  800afe:	73 12                	jae    800b12 <sprintputch+0x33>
		*b->buf++ = ch;
  800b00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b03:	8b 00                	mov    (%eax),%eax
  800b05:	8d 48 01             	lea    0x1(%eax),%ecx
  800b08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0b:	89 0a                	mov    %ecx,(%edx)
  800b0d:	8b 55 08             	mov    0x8(%ebp),%edx
  800b10:	88 10                	mov    %dl,(%eax)
}
  800b12:	90                   	nop
  800b13:	5d                   	pop    %ebp
  800b14:	c3                   	ret    

00800b15 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b15:	55                   	push   %ebp
  800b16:	89 e5                	mov    %esp,%ebp
  800b18:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b24:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	01 d0                	add    %edx,%eax
  800b2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b36:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b3a:	74 06                	je     800b42 <vsnprintf+0x2d>
  800b3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b40:	7f 07                	jg     800b49 <vsnprintf+0x34>
		return -E_INVAL;
  800b42:	b8 03 00 00 00       	mov    $0x3,%eax
  800b47:	eb 20                	jmp    800b69 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b49:	ff 75 14             	pushl  0x14(%ebp)
  800b4c:	ff 75 10             	pushl  0x10(%ebp)
  800b4f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b52:	50                   	push   %eax
  800b53:	68 df 0a 80 00       	push   $0x800adf
  800b58:	e8 92 fb ff ff       	call   8006ef <vprintfmt>
  800b5d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b60:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b63:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b69:	c9                   	leave  
  800b6a:	c3                   	ret    

00800b6b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
  800b6e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b71:	8d 45 10             	lea    0x10(%ebp),%eax
  800b74:	83 c0 04             	add    $0x4,%eax
  800b77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800b80:	50                   	push   %eax
  800b81:	ff 75 0c             	pushl  0xc(%ebp)
  800b84:	ff 75 08             	pushl  0x8(%ebp)
  800b87:	e8 89 ff ff ff       	call   800b15 <vsnprintf>
  800b8c:	83 c4 10             	add    $0x10,%esp
  800b8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b92:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b95:	c9                   	leave  
  800b96:	c3                   	ret    

00800b97 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
  800b9a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ba4:	eb 06                	jmp    800bac <strlen+0x15>
		n++;
  800ba6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ba9:	ff 45 08             	incl   0x8(%ebp)
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8a 00                	mov    (%eax),%al
  800bb1:	84 c0                	test   %al,%al
  800bb3:	75 f1                	jne    800ba6 <strlen+0xf>
		n++;
	return n;
  800bb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb8:	c9                   	leave  
  800bb9:	c3                   	ret    

00800bba <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bba:	55                   	push   %ebp
  800bbb:	89 e5                	mov    %esp,%ebp
  800bbd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc7:	eb 09                	jmp    800bd2 <strnlen+0x18>
		n++;
  800bc9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bcc:	ff 45 08             	incl   0x8(%ebp)
  800bcf:	ff 4d 0c             	decl   0xc(%ebp)
  800bd2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd6:	74 09                	je     800be1 <strnlen+0x27>
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8a 00                	mov    (%eax),%al
  800bdd:	84 c0                	test   %al,%al
  800bdf:	75 e8                	jne    800bc9 <strnlen+0xf>
		n++;
	return n;
  800be1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800be4:	c9                   	leave  
  800be5:	c3                   	ret    

00800be6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800be6:	55                   	push   %ebp
  800be7:	89 e5                	mov    %esp,%ebp
  800be9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bf2:	90                   	nop
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	8d 50 01             	lea    0x1(%eax),%edx
  800bf9:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bff:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c02:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c05:	8a 12                	mov    (%edx),%dl
  800c07:	88 10                	mov    %dl,(%eax)
  800c09:	8a 00                	mov    (%eax),%al
  800c0b:	84 c0                	test   %al,%al
  800c0d:	75 e4                	jne    800bf3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c27:	eb 1f                	jmp    800c48 <strncpy+0x34>
		*dst++ = *src;
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	8d 50 01             	lea    0x1(%eax),%edx
  800c2f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c35:	8a 12                	mov    (%edx),%dl
  800c37:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	84 c0                	test   %al,%al
  800c40:	74 03                	je     800c45 <strncpy+0x31>
			src++;
  800c42:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c45:	ff 45 fc             	incl   -0x4(%ebp)
  800c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c4e:	72 d9                	jb     800c29 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c50:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c53:	c9                   	leave  
  800c54:	c3                   	ret    

00800c55 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c55:	55                   	push   %ebp
  800c56:	89 e5                	mov    %esp,%ebp
  800c58:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c61:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c65:	74 30                	je     800c97 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c67:	eb 16                	jmp    800c7f <strlcpy+0x2a>
			*dst++ = *src++;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	8d 50 01             	lea    0x1(%eax),%edx
  800c6f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c75:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c78:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c7b:	8a 12                	mov    (%edx),%dl
  800c7d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c7f:	ff 4d 10             	decl   0x10(%ebp)
  800c82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c86:	74 09                	je     800c91 <strlcpy+0x3c>
  800c88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8b:	8a 00                	mov    (%eax),%al
  800c8d:	84 c0                	test   %al,%al
  800c8f:	75 d8                	jne    800c69 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c97:	8b 55 08             	mov    0x8(%ebp),%edx
  800c9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9d:	29 c2                	sub    %eax,%edx
  800c9f:	89 d0                	mov    %edx,%eax
}
  800ca1:	c9                   	leave  
  800ca2:	c3                   	ret    

00800ca3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ca3:	55                   	push   %ebp
  800ca4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ca6:	eb 06                	jmp    800cae <strcmp+0xb>
		p++, q++;
  800ca8:	ff 45 08             	incl   0x8(%ebp)
  800cab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	84 c0                	test   %al,%al
  800cb5:	74 0e                	je     800cc5 <strcmp+0x22>
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 10                	mov    (%eax),%dl
  800cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	38 c2                	cmp    %al,%dl
  800cc3:	74 e3                	je     800ca8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	0f b6 d0             	movzbl %al,%edx
  800ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd0:	8a 00                	mov    (%eax),%al
  800cd2:	0f b6 c0             	movzbl %al,%eax
  800cd5:	29 c2                	sub    %eax,%edx
  800cd7:	89 d0                	mov    %edx,%eax
}
  800cd9:	5d                   	pop    %ebp
  800cda:	c3                   	ret    

00800cdb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cdb:	55                   	push   %ebp
  800cdc:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cde:	eb 09                	jmp    800ce9 <strncmp+0xe>
		n--, p++, q++;
  800ce0:	ff 4d 10             	decl   0x10(%ebp)
  800ce3:	ff 45 08             	incl   0x8(%ebp)
  800ce6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ced:	74 17                	je     800d06 <strncmp+0x2b>
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	84 c0                	test   %al,%al
  800cf6:	74 0e                	je     800d06 <strncmp+0x2b>
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	8a 10                	mov    (%eax),%dl
  800cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	38 c2                	cmp    %al,%dl
  800d04:	74 da                	je     800ce0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0a:	75 07                	jne    800d13 <strncmp+0x38>
		return 0;
  800d0c:	b8 00 00 00 00       	mov    $0x0,%eax
  800d11:	eb 14                	jmp    800d27 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	0f b6 d0             	movzbl %al,%edx
  800d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1e:	8a 00                	mov    (%eax),%al
  800d20:	0f b6 c0             	movzbl %al,%eax
  800d23:	29 c2                	sub    %eax,%edx
  800d25:	89 d0                	mov    %edx,%eax
}
  800d27:	5d                   	pop    %ebp
  800d28:	c3                   	ret    

00800d29 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
  800d2c:	83 ec 04             	sub    $0x4,%esp
  800d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d32:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d35:	eb 12                	jmp    800d49 <strchr+0x20>
		if (*s == c)
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	8a 00                	mov    (%eax),%al
  800d3c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d3f:	75 05                	jne    800d46 <strchr+0x1d>
			return (char *) s;
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	eb 11                	jmp    800d57 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d46:	ff 45 08             	incl   0x8(%ebp)
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	84 c0                	test   %al,%al
  800d50:	75 e5                	jne    800d37 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d57:	c9                   	leave  
  800d58:	c3                   	ret    

00800d59 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d59:	55                   	push   %ebp
  800d5a:	89 e5                	mov    %esp,%ebp
  800d5c:	83 ec 04             	sub    $0x4,%esp
  800d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d62:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d65:	eb 0d                	jmp    800d74 <strfind+0x1b>
		if (*s == c)
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d6f:	74 0e                	je     800d7f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d71:	ff 45 08             	incl   0x8(%ebp)
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	8a 00                	mov    (%eax),%al
  800d79:	84 c0                	test   %al,%al
  800d7b:	75 ea                	jne    800d67 <strfind+0xe>
  800d7d:	eb 01                	jmp    800d80 <strfind+0x27>
		if (*s == c)
			break;
  800d7f:	90                   	nop
	return (char *) s;
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d83:	c9                   	leave  
  800d84:	c3                   	ret    

00800d85 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d91:	8b 45 10             	mov    0x10(%ebp),%eax
  800d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d97:	eb 0e                	jmp    800da7 <memset+0x22>
		*p++ = c;
  800d99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800da2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800da7:	ff 4d f8             	decl   -0x8(%ebp)
  800daa:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dae:	79 e9                	jns    800d99 <memset+0x14>
		*p++ = c;

	return v;
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db3:	c9                   	leave  
  800db4:	c3                   	ret    

00800db5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dc7:	eb 16                	jmp    800ddf <memcpy+0x2a>
		*d++ = *s++;
  800dc9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dcc:	8d 50 01             	lea    0x1(%eax),%edx
  800dcf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ddb:	8a 12                	mov    (%edx),%dl
  800ddd:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ddf:	8b 45 10             	mov    0x10(%ebp),%eax
  800de2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de5:	89 55 10             	mov    %edx,0x10(%ebp)
  800de8:	85 c0                	test   %eax,%eax
  800dea:	75 dd                	jne    800dc9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800def:	c9                   	leave  
  800df0:	c3                   	ret    

00800df1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800df1:	55                   	push   %ebp
  800df2:	89 e5                	mov    %esp,%ebp
  800df4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800df7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e06:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e09:	73 50                	jae    800e5b <memmove+0x6a>
  800e0b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e11:	01 d0                	add    %edx,%eax
  800e13:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e16:	76 43                	jbe    800e5b <memmove+0x6a>
		s += n;
  800e18:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e21:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e24:	eb 10                	jmp    800e36 <memmove+0x45>
			*--d = *--s;
  800e26:	ff 4d f8             	decl   -0x8(%ebp)
  800e29:	ff 4d fc             	decl   -0x4(%ebp)
  800e2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e2f:	8a 10                	mov    (%eax),%dl
  800e31:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e34:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e36:	8b 45 10             	mov    0x10(%ebp),%eax
  800e39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3f:	85 c0                	test   %eax,%eax
  800e41:	75 e3                	jne    800e26 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e43:	eb 23                	jmp    800e68 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e45:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e48:	8d 50 01             	lea    0x1(%eax),%edx
  800e4b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e51:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e54:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e57:	8a 12                	mov    (%edx),%dl
  800e59:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e61:	89 55 10             	mov    %edx,0x10(%ebp)
  800e64:	85 c0                	test   %eax,%eax
  800e66:	75 dd                	jne    800e45 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e6b:	c9                   	leave  
  800e6c:	c3                   	ret    

00800e6d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e6d:	55                   	push   %ebp
  800e6e:	89 e5                	mov    %esp,%ebp
  800e70:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e7f:	eb 2a                	jmp    800eab <memcmp+0x3e>
		if (*s1 != *s2)
  800e81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e84:	8a 10                	mov    (%eax),%dl
  800e86:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e89:	8a 00                	mov    (%eax),%al
  800e8b:	38 c2                	cmp    %al,%dl
  800e8d:	74 16                	je     800ea5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	0f b6 d0             	movzbl %al,%edx
  800e97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	0f b6 c0             	movzbl %al,%eax
  800e9f:	29 c2                	sub    %eax,%edx
  800ea1:	89 d0                	mov    %edx,%eax
  800ea3:	eb 18                	jmp    800ebd <memcmp+0x50>
		s1++, s2++;
  800ea5:	ff 45 fc             	incl   -0x4(%ebp)
  800ea8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800eab:	8b 45 10             	mov    0x10(%ebp),%eax
  800eae:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb1:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb4:	85 c0                	test   %eax,%eax
  800eb6:	75 c9                	jne    800e81 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800eb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
  800ec2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ec5:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecb:	01 d0                	add    %edx,%eax
  800ecd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ed0:	eb 15                	jmp    800ee7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	0f b6 d0             	movzbl %al,%edx
  800eda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edd:	0f b6 c0             	movzbl %al,%eax
  800ee0:	39 c2                	cmp    %eax,%edx
  800ee2:	74 0d                	je     800ef1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ee4:	ff 45 08             	incl   0x8(%ebp)
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eed:	72 e3                	jb     800ed2 <memfind+0x13>
  800eef:	eb 01                	jmp    800ef2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ef1:	90                   	nop
	return (void *) s;
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ef5:	c9                   	leave  
  800ef6:	c3                   	ret    

00800ef7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ef7:	55                   	push   %ebp
  800ef8:	89 e5                	mov    %esp,%ebp
  800efa:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800efd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f04:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f0b:	eb 03                	jmp    800f10 <strtol+0x19>
		s++;
  800f0d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	3c 20                	cmp    $0x20,%al
  800f17:	74 f4                	je     800f0d <strtol+0x16>
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	3c 09                	cmp    $0x9,%al
  800f20:	74 eb                	je     800f0d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	3c 2b                	cmp    $0x2b,%al
  800f29:	75 05                	jne    800f30 <strtol+0x39>
		s++;
  800f2b:	ff 45 08             	incl   0x8(%ebp)
  800f2e:	eb 13                	jmp    800f43 <strtol+0x4c>
	else if (*s == '-')
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	3c 2d                	cmp    $0x2d,%al
  800f37:	75 0a                	jne    800f43 <strtol+0x4c>
		s++, neg = 1;
  800f39:	ff 45 08             	incl   0x8(%ebp)
  800f3c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f43:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f47:	74 06                	je     800f4f <strtol+0x58>
  800f49:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f4d:	75 20                	jne    800f6f <strtol+0x78>
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	3c 30                	cmp    $0x30,%al
  800f56:	75 17                	jne    800f6f <strtol+0x78>
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	40                   	inc    %eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	3c 78                	cmp    $0x78,%al
  800f60:	75 0d                	jne    800f6f <strtol+0x78>
		s += 2, base = 16;
  800f62:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f66:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f6d:	eb 28                	jmp    800f97 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f73:	75 15                	jne    800f8a <strtol+0x93>
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	3c 30                	cmp    $0x30,%al
  800f7c:	75 0c                	jne    800f8a <strtol+0x93>
		s++, base = 8;
  800f7e:	ff 45 08             	incl   0x8(%ebp)
  800f81:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f88:	eb 0d                	jmp    800f97 <strtol+0xa0>
	else if (base == 0)
  800f8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8e:	75 07                	jne    800f97 <strtol+0xa0>
		base = 10;
  800f90:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 2f                	cmp    $0x2f,%al
  800f9e:	7e 19                	jle    800fb9 <strtol+0xc2>
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 39                	cmp    $0x39,%al
  800fa7:	7f 10                	jg     800fb9 <strtol+0xc2>
			dig = *s - '0';
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	0f be c0             	movsbl %al,%eax
  800fb1:	83 e8 30             	sub    $0x30,%eax
  800fb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb7:	eb 42                	jmp    800ffb <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	8a 00                	mov    (%eax),%al
  800fbe:	3c 60                	cmp    $0x60,%al
  800fc0:	7e 19                	jle    800fdb <strtol+0xe4>
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	3c 7a                	cmp    $0x7a,%al
  800fc9:	7f 10                	jg     800fdb <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	8a 00                	mov    (%eax),%al
  800fd0:	0f be c0             	movsbl %al,%eax
  800fd3:	83 e8 57             	sub    $0x57,%eax
  800fd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd9:	eb 20                	jmp    800ffb <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	8a 00                	mov    (%eax),%al
  800fe0:	3c 40                	cmp    $0x40,%al
  800fe2:	7e 39                	jle    80101d <strtol+0x126>
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	3c 5a                	cmp    $0x5a,%al
  800feb:	7f 30                	jg     80101d <strtol+0x126>
			dig = *s - 'A' + 10;
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	0f be c0             	movsbl %al,%eax
  800ff5:	83 e8 37             	sub    $0x37,%eax
  800ff8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffe:	3b 45 10             	cmp    0x10(%ebp),%eax
  801001:	7d 19                	jge    80101c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801003:	ff 45 08             	incl   0x8(%ebp)
  801006:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801009:	0f af 45 10          	imul   0x10(%ebp),%eax
  80100d:	89 c2                	mov    %eax,%edx
  80100f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801012:	01 d0                	add    %edx,%eax
  801014:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801017:	e9 7b ff ff ff       	jmp    800f97 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80101c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80101d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801021:	74 08                	je     80102b <strtol+0x134>
		*endptr = (char *) s;
  801023:	8b 45 0c             	mov    0xc(%ebp),%eax
  801026:	8b 55 08             	mov    0x8(%ebp),%edx
  801029:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80102b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80102f:	74 07                	je     801038 <strtol+0x141>
  801031:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801034:	f7 d8                	neg    %eax
  801036:	eb 03                	jmp    80103b <strtol+0x144>
  801038:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80103b:	c9                   	leave  
  80103c:	c3                   	ret    

0080103d <ltostr>:

void
ltostr(long value, char *str)
{
  80103d:	55                   	push   %ebp
  80103e:	89 e5                	mov    %esp,%ebp
  801040:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801043:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80104a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801051:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801055:	79 13                	jns    80106a <ltostr+0x2d>
	{
		neg = 1;
  801057:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80105e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801061:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801064:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801067:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801072:	99                   	cltd   
  801073:	f7 f9                	idiv   %ecx
  801075:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801078:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80107b:	8d 50 01             	lea    0x1(%eax),%edx
  80107e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801081:	89 c2                	mov    %eax,%edx
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	01 d0                	add    %edx,%eax
  801088:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80108b:	83 c2 30             	add    $0x30,%edx
  80108e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801090:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801093:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801098:	f7 e9                	imul   %ecx
  80109a:	c1 fa 02             	sar    $0x2,%edx
  80109d:	89 c8                	mov    %ecx,%eax
  80109f:	c1 f8 1f             	sar    $0x1f,%eax
  8010a2:	29 c2                	sub    %eax,%edx
  8010a4:	89 d0                	mov    %edx,%eax
  8010a6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ac:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010b1:	f7 e9                	imul   %ecx
  8010b3:	c1 fa 02             	sar    $0x2,%edx
  8010b6:	89 c8                	mov    %ecx,%eax
  8010b8:	c1 f8 1f             	sar    $0x1f,%eax
  8010bb:	29 c2                	sub    %eax,%edx
  8010bd:	89 d0                	mov    %edx,%eax
  8010bf:	c1 e0 02             	shl    $0x2,%eax
  8010c2:	01 d0                	add    %edx,%eax
  8010c4:	01 c0                	add    %eax,%eax
  8010c6:	29 c1                	sub    %eax,%ecx
  8010c8:	89 ca                	mov    %ecx,%edx
  8010ca:	85 d2                	test   %edx,%edx
  8010cc:	75 9c                	jne    80106a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d8:	48                   	dec    %eax
  8010d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010e0:	74 3d                	je     80111f <ltostr+0xe2>
		start = 1 ;
  8010e2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010e9:	eb 34                	jmp    80111f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	01 d0                	add    %edx,%eax
  8010f3:	8a 00                	mov    (%eax),%al
  8010f5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fe:	01 c2                	add    %eax,%edx
  801100:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	01 c8                	add    %ecx,%eax
  801108:	8a 00                	mov    (%eax),%al
  80110a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80110c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80110f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801112:	01 c2                	add    %eax,%edx
  801114:	8a 45 eb             	mov    -0x15(%ebp),%al
  801117:	88 02                	mov    %al,(%edx)
		start++ ;
  801119:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80111c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80111f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801125:	7c c4                	jl     8010eb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801127:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80112a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112d:	01 d0                	add    %edx,%eax
  80112f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801132:	90                   	nop
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80113b:	ff 75 08             	pushl  0x8(%ebp)
  80113e:	e8 54 fa ff ff       	call   800b97 <strlen>
  801143:	83 c4 04             	add    $0x4,%esp
  801146:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801149:	ff 75 0c             	pushl  0xc(%ebp)
  80114c:	e8 46 fa ff ff       	call   800b97 <strlen>
  801151:	83 c4 04             	add    $0x4,%esp
  801154:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801157:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80115e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801165:	eb 17                	jmp    80117e <strcconcat+0x49>
		final[s] = str1[s] ;
  801167:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116a:	8b 45 10             	mov    0x10(%ebp),%eax
  80116d:	01 c2                	add    %eax,%edx
  80116f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	01 c8                	add    %ecx,%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80117b:	ff 45 fc             	incl   -0x4(%ebp)
  80117e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801181:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801184:	7c e1                	jl     801167 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801186:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80118d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801194:	eb 1f                	jmp    8011b5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801196:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801199:	8d 50 01             	lea    0x1(%eax),%edx
  80119c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80119f:	89 c2                	mov    %eax,%edx
  8011a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a4:	01 c2                	add    %eax,%edx
  8011a6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	01 c8                	add    %ecx,%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011b2:	ff 45 f8             	incl   -0x8(%ebp)
  8011b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011bb:	7c d9                	jl     801196 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c3:	01 d0                	add    %edx,%eax
  8011c5:	c6 00 00             	movb   $0x0,(%eax)
}
  8011c8:	90                   	nop
  8011c9:	c9                   	leave  
  8011ca:	c3                   	ret    

008011cb <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011cb:	55                   	push   %ebp
  8011cc:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011da:	8b 00                	mov    (%eax),%eax
  8011dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e6:	01 d0                	add    %edx,%eax
  8011e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ee:	eb 0c                	jmp    8011fc <strsplit+0x31>
			*string++ = 0;
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8d 50 01             	lea    0x1(%eax),%edx
  8011f6:	89 55 08             	mov    %edx,0x8(%ebp)
  8011f9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	74 18                	je     80121d <strsplit+0x52>
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	0f be c0             	movsbl %al,%eax
  80120d:	50                   	push   %eax
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	e8 13 fb ff ff       	call   800d29 <strchr>
  801216:	83 c4 08             	add    $0x8,%esp
  801219:	85 c0                	test   %eax,%eax
  80121b:	75 d3                	jne    8011f0 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	84 c0                	test   %al,%al
  801224:	74 5a                	je     801280 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801226:	8b 45 14             	mov    0x14(%ebp),%eax
  801229:	8b 00                	mov    (%eax),%eax
  80122b:	83 f8 0f             	cmp    $0xf,%eax
  80122e:	75 07                	jne    801237 <strsplit+0x6c>
		{
			return 0;
  801230:	b8 00 00 00 00       	mov    $0x0,%eax
  801235:	eb 66                	jmp    80129d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801237:	8b 45 14             	mov    0x14(%ebp),%eax
  80123a:	8b 00                	mov    (%eax),%eax
  80123c:	8d 48 01             	lea    0x1(%eax),%ecx
  80123f:	8b 55 14             	mov    0x14(%ebp),%edx
  801242:	89 0a                	mov    %ecx,(%edx)
  801244:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124b:	8b 45 10             	mov    0x10(%ebp),%eax
  80124e:	01 c2                	add    %eax,%edx
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801255:	eb 03                	jmp    80125a <strsplit+0x8f>
			string++;
  801257:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
  80125d:	8a 00                	mov    (%eax),%al
  80125f:	84 c0                	test   %al,%al
  801261:	74 8b                	je     8011ee <strsplit+0x23>
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	0f be c0             	movsbl %al,%eax
  80126b:	50                   	push   %eax
  80126c:	ff 75 0c             	pushl  0xc(%ebp)
  80126f:	e8 b5 fa ff ff       	call   800d29 <strchr>
  801274:	83 c4 08             	add    $0x8,%esp
  801277:	85 c0                	test   %eax,%eax
  801279:	74 dc                	je     801257 <strsplit+0x8c>
			string++;
	}
  80127b:	e9 6e ff ff ff       	jmp    8011ee <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801280:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801281:	8b 45 14             	mov    0x14(%ebp),%eax
  801284:	8b 00                	mov    (%eax),%eax
  801286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80128d:	8b 45 10             	mov    0x10(%ebp),%eax
  801290:	01 d0                	add    %edx,%eax
  801292:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801298:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
  8012a2:	57                   	push   %edi
  8012a3:	56                   	push   %esi
  8012a4:	53                   	push   %ebx
  8012a5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012b1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012b4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012b7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012ba:	cd 30                	int    $0x30
  8012bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012c2:	83 c4 10             	add    $0x10,%esp
  8012c5:	5b                   	pop    %ebx
  8012c6:	5e                   	pop    %esi
  8012c7:	5f                   	pop    %edi
  8012c8:	5d                   	pop    %ebp
  8012c9:	c3                   	ret    

008012ca <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012ca:	55                   	push   %ebp
  8012cb:	89 e5                	mov    %esp,%ebp
  8012cd:	83 ec 04             	sub    $0x4,%esp
  8012d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012d6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	52                   	push   %edx
  8012e2:	ff 75 0c             	pushl  0xc(%ebp)
  8012e5:	50                   	push   %eax
  8012e6:	6a 00                	push   $0x0
  8012e8:	e8 b2 ff ff ff       	call   80129f <syscall>
  8012ed:	83 c4 18             	add    $0x18,%esp
}
  8012f0:	90                   	nop
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 01                	push   $0x1
  801302:	e8 98 ff ff ff       	call   80129f <syscall>
  801307:	83 c4 18             	add    $0x18,%esp
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	50                   	push   %eax
  80131b:	6a 05                	push   $0x5
  80131d:	e8 7d ff ff ff       	call   80129f <syscall>
  801322:	83 c4 18             	add    $0x18,%esp
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 02                	push   $0x2
  801336:	e8 64 ff ff ff       	call   80129f <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	c9                   	leave  
  80133f:	c3                   	ret    

00801340 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 03                	push   $0x3
  80134f:	e8 4b ff ff ff       	call   80129f <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 04                	push   $0x4
  801368:	e8 32 ff ff ff       	call   80129f <syscall>
  80136d:	83 c4 18             	add    $0x18,%esp
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <sys_env_exit>:


void sys_env_exit(void)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 00                	push   $0x0
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 06                	push   $0x6
  801381:	e8 19 ff ff ff       	call   80129f <syscall>
  801386:	83 c4 18             	add    $0x18,%esp
}
  801389:	90                   	nop
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80138f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	52                   	push   %edx
  80139c:	50                   	push   %eax
  80139d:	6a 07                	push   $0x7
  80139f:	e8 fb fe ff ff       	call   80129f <syscall>
  8013a4:	83 c4 18             	add    $0x18,%esp
}
  8013a7:	c9                   	leave  
  8013a8:	c3                   	ret    

008013a9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013a9:	55                   	push   %ebp
  8013aa:	89 e5                	mov    %esp,%ebp
  8013ac:	56                   	push   %esi
  8013ad:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013ae:	8b 75 18             	mov    0x18(%ebp),%esi
  8013b1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	56                   	push   %esi
  8013be:	53                   	push   %ebx
  8013bf:	51                   	push   %ecx
  8013c0:	52                   	push   %edx
  8013c1:	50                   	push   %eax
  8013c2:	6a 08                	push   $0x8
  8013c4:	e8 d6 fe ff ff       	call   80129f <syscall>
  8013c9:	83 c4 18             	add    $0x18,%esp
}
  8013cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013cf:	5b                   	pop    %ebx
  8013d0:	5e                   	pop    %esi
  8013d1:	5d                   	pop    %ebp
  8013d2:	c3                   	ret    

008013d3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	52                   	push   %edx
  8013e3:	50                   	push   %eax
  8013e4:	6a 09                	push   $0x9
  8013e6:	e8 b4 fe ff ff       	call   80129f <syscall>
  8013eb:	83 c4 18             	add    $0x18,%esp
}
  8013ee:	c9                   	leave  
  8013ef:	c3                   	ret    

008013f0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013f0:	55                   	push   %ebp
  8013f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	ff 75 0c             	pushl  0xc(%ebp)
  8013fc:	ff 75 08             	pushl  0x8(%ebp)
  8013ff:	6a 0a                	push   $0xa
  801401:	e8 99 fe ff ff       	call   80129f <syscall>
  801406:	83 c4 18             	add    $0x18,%esp
}
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 0b                	push   $0xb
  80141a:	e8 80 fe ff ff       	call   80129f <syscall>
  80141f:	83 c4 18             	add    $0x18,%esp
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 0c                	push   $0xc
  801433:	e8 67 fe ff ff       	call   80129f <syscall>
  801438:	83 c4 18             	add    $0x18,%esp
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 0d                	push   $0xd
  80144c:	e8 4e fe ff ff       	call   80129f <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	ff 75 0c             	pushl  0xc(%ebp)
  801462:	ff 75 08             	pushl  0x8(%ebp)
  801465:	6a 11                	push   $0x11
  801467:	e8 33 fe ff ff       	call   80129f <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
	return;
  80146f:	90                   	nop
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	ff 75 0c             	pushl  0xc(%ebp)
  80147e:	ff 75 08             	pushl  0x8(%ebp)
  801481:	6a 12                	push   $0x12
  801483:	e8 17 fe ff ff       	call   80129f <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
	return ;
  80148b:	90                   	nop
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 0e                	push   $0xe
  80149d:	e8 fd fd ff ff       	call   80129f <syscall>
  8014a2:	83 c4 18             	add    $0x18,%esp
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	ff 75 08             	pushl  0x8(%ebp)
  8014b5:	6a 0f                	push   $0xf
  8014b7:	e8 e3 fd ff ff       	call   80129f <syscall>
  8014bc:	83 c4 18             	add    $0x18,%esp
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 10                	push   $0x10
  8014d0:	e8 ca fd ff ff       	call   80129f <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
}
  8014d8:	90                   	nop
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 14                	push   $0x14
  8014ea:	e8 b0 fd ff ff       	call   80129f <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
}
  8014f2:	90                   	nop
  8014f3:	c9                   	leave  
  8014f4:	c3                   	ret    

008014f5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014f5:	55                   	push   %ebp
  8014f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 15                	push   $0x15
  801504:	e8 96 fd ff ff       	call   80129f <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	90                   	nop
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <sys_cputc>:


void
sys_cputc(const char c)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
  801512:	83 ec 04             	sub    $0x4,%esp
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80151b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	50                   	push   %eax
  801528:	6a 16                	push   $0x16
  80152a:	e8 70 fd ff ff       	call   80129f <syscall>
  80152f:	83 c4 18             	add    $0x18,%esp
}
  801532:	90                   	nop
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 17                	push   $0x17
  801544:	e8 56 fd ff ff       	call   80129f <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
}
  80154c:	90                   	nop
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	ff 75 0c             	pushl  0xc(%ebp)
  80155e:	50                   	push   %eax
  80155f:	6a 18                	push   $0x18
  801561:	e8 39 fd ff ff       	call   80129f <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
}
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80156e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	52                   	push   %edx
  80157b:	50                   	push   %eax
  80157c:	6a 1b                	push   $0x1b
  80157e:	e8 1c fd ff ff       	call   80129f <syscall>
  801583:	83 c4 18             	add    $0x18,%esp
}
  801586:	c9                   	leave  
  801587:	c3                   	ret    

00801588 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80158b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	52                   	push   %edx
  801598:	50                   	push   %eax
  801599:	6a 19                	push   $0x19
  80159b:	e8 ff fc ff ff       	call   80129f <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
}
  8015a3:	90                   	nop
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	52                   	push   %edx
  8015b6:	50                   	push   %eax
  8015b7:	6a 1a                	push   $0x1a
  8015b9:	e8 e1 fc ff ff       	call   80129f <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	90                   	nop
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
  8015c7:	83 ec 04             	sub    $0x4,%esp
  8015ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015d0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015d3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	51                   	push   %ecx
  8015dd:	52                   	push   %edx
  8015de:	ff 75 0c             	pushl  0xc(%ebp)
  8015e1:	50                   	push   %eax
  8015e2:	6a 1c                	push   $0x1c
  8015e4:	e8 b6 fc ff ff       	call   80129f <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	52                   	push   %edx
  8015fe:	50                   	push   %eax
  8015ff:	6a 1d                	push   $0x1d
  801601:	e8 99 fc ff ff       	call   80129f <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80160e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	51                   	push   %ecx
  80161c:	52                   	push   %edx
  80161d:	50                   	push   %eax
  80161e:	6a 1e                	push   $0x1e
  801620:	e8 7a fc ff ff       	call   80129f <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80162d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	52                   	push   %edx
  80163a:	50                   	push   %eax
  80163b:	6a 1f                	push   $0x1f
  80163d:	e8 5d fc ff ff       	call   80129f <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 20                	push   $0x20
  801656:	e8 44 fc ff ff       	call   80129f <syscall>
  80165b:	83 c4 18             	add    $0x18,%esp
}
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	ff 75 10             	pushl  0x10(%ebp)
  80166d:	ff 75 0c             	pushl  0xc(%ebp)
  801670:	50                   	push   %eax
  801671:	6a 21                	push   $0x21
  801673:	e8 27 fc ff ff       	call   80129f <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
}
  80167b:	c9                   	leave  
  80167c:	c3                   	ret    

0080167d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80167d:	55                   	push   %ebp
  80167e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	50                   	push   %eax
  80168c:	6a 22                	push   $0x22
  80168e:	e8 0c fc ff ff       	call   80129f <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
}
  801696:	90                   	nop
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	50                   	push   %eax
  8016a8:	6a 23                	push   $0x23
  8016aa:	e8 f0 fb ff ff       	call   80129f <syscall>
  8016af:	83 c4 18             	add    $0x18,%esp
}
  8016b2:	90                   	nop
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016bb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016be:	8d 50 04             	lea    0x4(%eax),%edx
  8016c1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	52                   	push   %edx
  8016cb:	50                   	push   %eax
  8016cc:	6a 24                	push   $0x24
  8016ce:	e8 cc fb ff ff       	call   80129f <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
	return result;
  8016d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016df:	89 01                	mov    %eax,(%ecx)
  8016e1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	c9                   	leave  
  8016e8:	c2 04 00             	ret    $0x4

008016eb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	ff 75 10             	pushl  0x10(%ebp)
  8016f5:	ff 75 0c             	pushl  0xc(%ebp)
  8016f8:	ff 75 08             	pushl  0x8(%ebp)
  8016fb:	6a 13                	push   $0x13
  8016fd:	e8 9d fb ff ff       	call   80129f <syscall>
  801702:	83 c4 18             	add    $0x18,%esp
	return ;
  801705:	90                   	nop
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <sys_rcr2>:
uint32 sys_rcr2()
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 25                	push   $0x25
  801717:	e8 83 fb ff ff       	call   80129f <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
  801724:	83 ec 04             	sub    $0x4,%esp
  801727:	8b 45 08             	mov    0x8(%ebp),%eax
  80172a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80172d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	50                   	push   %eax
  80173a:	6a 26                	push   $0x26
  80173c:	e8 5e fb ff ff       	call   80129f <syscall>
  801741:	83 c4 18             	add    $0x18,%esp
	return ;
  801744:	90                   	nop
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <rsttst>:
void rsttst()
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 28                	push   $0x28
  801756:	e8 44 fb ff ff       	call   80129f <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
	return ;
  80175e:	90                   	nop
}
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
  801764:	83 ec 04             	sub    $0x4,%esp
  801767:	8b 45 14             	mov    0x14(%ebp),%eax
  80176a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80176d:	8b 55 18             	mov    0x18(%ebp),%edx
  801770:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801774:	52                   	push   %edx
  801775:	50                   	push   %eax
  801776:	ff 75 10             	pushl  0x10(%ebp)
  801779:	ff 75 0c             	pushl  0xc(%ebp)
  80177c:	ff 75 08             	pushl  0x8(%ebp)
  80177f:	6a 27                	push   $0x27
  801781:	e8 19 fb ff ff       	call   80129f <syscall>
  801786:	83 c4 18             	add    $0x18,%esp
	return ;
  801789:	90                   	nop
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <chktst>:
void chktst(uint32 n)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	ff 75 08             	pushl  0x8(%ebp)
  80179a:	6a 29                	push   $0x29
  80179c:	e8 fe fa ff ff       	call   80129f <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a4:	90                   	nop
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <inctst>:

void inctst()
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 2a                	push   $0x2a
  8017b6:	e8 e4 fa ff ff       	call   80129f <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8017be:	90                   	nop
}
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <gettst>:
uint32 gettst()
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 2b                	push   $0x2b
  8017d0:	e8 ca fa ff ff       	call   80129f <syscall>
  8017d5:	83 c4 18             	add    $0x18,%esp
}
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
  8017dd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 2c                	push   $0x2c
  8017ec:	e8 ae fa ff ff       	call   80129f <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
  8017f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017f7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017fb:	75 07                	jne    801804 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017fd:	b8 01 00 00 00       	mov    $0x1,%eax
  801802:	eb 05                	jmp    801809 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801804:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
  80180e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 2c                	push   $0x2c
  80181d:	e8 7d fa ff ff       	call   80129f <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
  801825:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801828:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80182c:	75 07                	jne    801835 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80182e:	b8 01 00 00 00       	mov    $0x1,%eax
  801833:	eb 05                	jmp    80183a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801835:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183a:	c9                   	leave  
  80183b:	c3                   	ret    

0080183c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
  80183f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 2c                	push   $0x2c
  80184e:	e8 4c fa ff ff       	call   80129f <syscall>
  801853:	83 c4 18             	add    $0x18,%esp
  801856:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801859:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80185d:	75 07                	jne    801866 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80185f:	b8 01 00 00 00       	mov    $0x1,%eax
  801864:	eb 05                	jmp    80186b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801866:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
  801870:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 2c                	push   $0x2c
  80187f:	e8 1b fa ff ff       	call   80129f <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
  801887:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80188a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80188e:	75 07                	jne    801897 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801890:	b8 01 00 00 00       	mov    $0x1,%eax
  801895:	eb 05                	jmp    80189c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801897:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80189c:	c9                   	leave  
  80189d:	c3                   	ret    

0080189e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80189e:	55                   	push   %ebp
  80189f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	ff 75 08             	pushl  0x8(%ebp)
  8018ac:	6a 2d                	push   $0x2d
  8018ae:	e8 ec f9 ff ff       	call   80129f <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b6:	90                   	nop
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
  8018bc:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8018c2:	89 d0                	mov    %edx,%eax
  8018c4:	c1 e0 02             	shl    $0x2,%eax
  8018c7:	01 d0                	add    %edx,%eax
  8018c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d0:	01 d0                	add    %edx,%eax
  8018d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d9:	01 d0                	add    %edx,%eax
  8018db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018e2:	01 d0                	add    %edx,%eax
  8018e4:	c1 e0 04             	shl    $0x4,%eax
  8018e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8018ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018f1:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018f4:	83 ec 0c             	sub    $0xc,%esp
  8018f7:	50                   	push   %eax
  8018f8:	e8 b8 fd ff ff       	call   8016b5 <sys_get_virtual_time>
  8018fd:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801900:	eb 41                	jmp    801943 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801902:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801905:	83 ec 0c             	sub    $0xc,%esp
  801908:	50                   	push   %eax
  801909:	e8 a7 fd ff ff       	call   8016b5 <sys_get_virtual_time>
  80190e:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801911:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801914:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801917:	29 c2                	sub    %eax,%edx
  801919:	89 d0                	mov    %edx,%eax
  80191b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80191e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801921:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801924:	89 d1                	mov    %edx,%ecx
  801926:	29 c1                	sub    %eax,%ecx
  801928:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80192b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80192e:	39 c2                	cmp    %eax,%edx
  801930:	0f 97 c0             	seta   %al
  801933:	0f b6 c0             	movzbl %al,%eax
  801936:	29 c1                	sub    %eax,%ecx
  801938:	89 c8                	mov    %ecx,%eax
  80193a:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80193d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801940:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801943:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801946:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801949:	72 b7                	jb     801902 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  80194b:	90                   	nop
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
  801951:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801954:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80195b:	eb 03                	jmp    801960 <busy_wait+0x12>
  80195d:	ff 45 fc             	incl   -0x4(%ebp)
  801960:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801963:	3b 45 08             	cmp    0x8(%ebp),%eax
  801966:	72 f5                	jb     80195d <busy_wait+0xf>
	return i;
  801968:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80196b:	c9                   	leave  
  80196c:	c3                   	ret    
  80196d:	66 90                	xchg   %ax,%ax
  80196f:	90                   	nop

00801970 <__udivdi3>:
  801970:	55                   	push   %ebp
  801971:	57                   	push   %edi
  801972:	56                   	push   %esi
  801973:	53                   	push   %ebx
  801974:	83 ec 1c             	sub    $0x1c,%esp
  801977:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80197b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80197f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801983:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801987:	89 ca                	mov    %ecx,%edx
  801989:	89 f8                	mov    %edi,%eax
  80198b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80198f:	85 f6                	test   %esi,%esi
  801991:	75 2d                	jne    8019c0 <__udivdi3+0x50>
  801993:	39 cf                	cmp    %ecx,%edi
  801995:	77 65                	ja     8019fc <__udivdi3+0x8c>
  801997:	89 fd                	mov    %edi,%ebp
  801999:	85 ff                	test   %edi,%edi
  80199b:	75 0b                	jne    8019a8 <__udivdi3+0x38>
  80199d:	b8 01 00 00 00       	mov    $0x1,%eax
  8019a2:	31 d2                	xor    %edx,%edx
  8019a4:	f7 f7                	div    %edi
  8019a6:	89 c5                	mov    %eax,%ebp
  8019a8:	31 d2                	xor    %edx,%edx
  8019aa:	89 c8                	mov    %ecx,%eax
  8019ac:	f7 f5                	div    %ebp
  8019ae:	89 c1                	mov    %eax,%ecx
  8019b0:	89 d8                	mov    %ebx,%eax
  8019b2:	f7 f5                	div    %ebp
  8019b4:	89 cf                	mov    %ecx,%edi
  8019b6:	89 fa                	mov    %edi,%edx
  8019b8:	83 c4 1c             	add    $0x1c,%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5f                   	pop    %edi
  8019be:	5d                   	pop    %ebp
  8019bf:	c3                   	ret    
  8019c0:	39 ce                	cmp    %ecx,%esi
  8019c2:	77 28                	ja     8019ec <__udivdi3+0x7c>
  8019c4:	0f bd fe             	bsr    %esi,%edi
  8019c7:	83 f7 1f             	xor    $0x1f,%edi
  8019ca:	75 40                	jne    801a0c <__udivdi3+0x9c>
  8019cc:	39 ce                	cmp    %ecx,%esi
  8019ce:	72 0a                	jb     8019da <__udivdi3+0x6a>
  8019d0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019d4:	0f 87 9e 00 00 00    	ja     801a78 <__udivdi3+0x108>
  8019da:	b8 01 00 00 00       	mov    $0x1,%eax
  8019df:	89 fa                	mov    %edi,%edx
  8019e1:	83 c4 1c             	add    $0x1c,%esp
  8019e4:	5b                   	pop    %ebx
  8019e5:	5e                   	pop    %esi
  8019e6:	5f                   	pop    %edi
  8019e7:	5d                   	pop    %ebp
  8019e8:	c3                   	ret    
  8019e9:	8d 76 00             	lea    0x0(%esi),%esi
  8019ec:	31 ff                	xor    %edi,%edi
  8019ee:	31 c0                	xor    %eax,%eax
  8019f0:	89 fa                	mov    %edi,%edx
  8019f2:	83 c4 1c             	add    $0x1c,%esp
  8019f5:	5b                   	pop    %ebx
  8019f6:	5e                   	pop    %esi
  8019f7:	5f                   	pop    %edi
  8019f8:	5d                   	pop    %ebp
  8019f9:	c3                   	ret    
  8019fa:	66 90                	xchg   %ax,%ax
  8019fc:	89 d8                	mov    %ebx,%eax
  8019fe:	f7 f7                	div    %edi
  801a00:	31 ff                	xor    %edi,%edi
  801a02:	89 fa                	mov    %edi,%edx
  801a04:	83 c4 1c             	add    $0x1c,%esp
  801a07:	5b                   	pop    %ebx
  801a08:	5e                   	pop    %esi
  801a09:	5f                   	pop    %edi
  801a0a:	5d                   	pop    %ebp
  801a0b:	c3                   	ret    
  801a0c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a11:	89 eb                	mov    %ebp,%ebx
  801a13:	29 fb                	sub    %edi,%ebx
  801a15:	89 f9                	mov    %edi,%ecx
  801a17:	d3 e6                	shl    %cl,%esi
  801a19:	89 c5                	mov    %eax,%ebp
  801a1b:	88 d9                	mov    %bl,%cl
  801a1d:	d3 ed                	shr    %cl,%ebp
  801a1f:	89 e9                	mov    %ebp,%ecx
  801a21:	09 f1                	or     %esi,%ecx
  801a23:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a27:	89 f9                	mov    %edi,%ecx
  801a29:	d3 e0                	shl    %cl,%eax
  801a2b:	89 c5                	mov    %eax,%ebp
  801a2d:	89 d6                	mov    %edx,%esi
  801a2f:	88 d9                	mov    %bl,%cl
  801a31:	d3 ee                	shr    %cl,%esi
  801a33:	89 f9                	mov    %edi,%ecx
  801a35:	d3 e2                	shl    %cl,%edx
  801a37:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a3b:	88 d9                	mov    %bl,%cl
  801a3d:	d3 e8                	shr    %cl,%eax
  801a3f:	09 c2                	or     %eax,%edx
  801a41:	89 d0                	mov    %edx,%eax
  801a43:	89 f2                	mov    %esi,%edx
  801a45:	f7 74 24 0c          	divl   0xc(%esp)
  801a49:	89 d6                	mov    %edx,%esi
  801a4b:	89 c3                	mov    %eax,%ebx
  801a4d:	f7 e5                	mul    %ebp
  801a4f:	39 d6                	cmp    %edx,%esi
  801a51:	72 19                	jb     801a6c <__udivdi3+0xfc>
  801a53:	74 0b                	je     801a60 <__udivdi3+0xf0>
  801a55:	89 d8                	mov    %ebx,%eax
  801a57:	31 ff                	xor    %edi,%edi
  801a59:	e9 58 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a5e:	66 90                	xchg   %ax,%ax
  801a60:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a64:	89 f9                	mov    %edi,%ecx
  801a66:	d3 e2                	shl    %cl,%edx
  801a68:	39 c2                	cmp    %eax,%edx
  801a6a:	73 e9                	jae    801a55 <__udivdi3+0xe5>
  801a6c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a6f:	31 ff                	xor    %edi,%edi
  801a71:	e9 40 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a76:	66 90                	xchg   %ax,%ax
  801a78:	31 c0                	xor    %eax,%eax
  801a7a:	e9 37 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a7f:	90                   	nop

00801a80 <__umoddi3>:
  801a80:	55                   	push   %ebp
  801a81:	57                   	push   %edi
  801a82:	56                   	push   %esi
  801a83:	53                   	push   %ebx
  801a84:	83 ec 1c             	sub    $0x1c,%esp
  801a87:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a8b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a8f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a93:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a97:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a9b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a9f:	89 f3                	mov    %esi,%ebx
  801aa1:	89 fa                	mov    %edi,%edx
  801aa3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801aa7:	89 34 24             	mov    %esi,(%esp)
  801aaa:	85 c0                	test   %eax,%eax
  801aac:	75 1a                	jne    801ac8 <__umoddi3+0x48>
  801aae:	39 f7                	cmp    %esi,%edi
  801ab0:	0f 86 a2 00 00 00    	jbe    801b58 <__umoddi3+0xd8>
  801ab6:	89 c8                	mov    %ecx,%eax
  801ab8:	89 f2                	mov    %esi,%edx
  801aba:	f7 f7                	div    %edi
  801abc:	89 d0                	mov    %edx,%eax
  801abe:	31 d2                	xor    %edx,%edx
  801ac0:	83 c4 1c             	add    $0x1c,%esp
  801ac3:	5b                   	pop    %ebx
  801ac4:	5e                   	pop    %esi
  801ac5:	5f                   	pop    %edi
  801ac6:	5d                   	pop    %ebp
  801ac7:	c3                   	ret    
  801ac8:	39 f0                	cmp    %esi,%eax
  801aca:	0f 87 ac 00 00 00    	ja     801b7c <__umoddi3+0xfc>
  801ad0:	0f bd e8             	bsr    %eax,%ebp
  801ad3:	83 f5 1f             	xor    $0x1f,%ebp
  801ad6:	0f 84 ac 00 00 00    	je     801b88 <__umoddi3+0x108>
  801adc:	bf 20 00 00 00       	mov    $0x20,%edi
  801ae1:	29 ef                	sub    %ebp,%edi
  801ae3:	89 fe                	mov    %edi,%esi
  801ae5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 e0                	shl    %cl,%eax
  801aed:	89 d7                	mov    %edx,%edi
  801aef:	89 f1                	mov    %esi,%ecx
  801af1:	d3 ef                	shr    %cl,%edi
  801af3:	09 c7                	or     %eax,%edi
  801af5:	89 e9                	mov    %ebp,%ecx
  801af7:	d3 e2                	shl    %cl,%edx
  801af9:	89 14 24             	mov    %edx,(%esp)
  801afc:	89 d8                	mov    %ebx,%eax
  801afe:	d3 e0                	shl    %cl,%eax
  801b00:	89 c2                	mov    %eax,%edx
  801b02:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b06:	d3 e0                	shl    %cl,%eax
  801b08:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b0c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b10:	89 f1                	mov    %esi,%ecx
  801b12:	d3 e8                	shr    %cl,%eax
  801b14:	09 d0                	or     %edx,%eax
  801b16:	d3 eb                	shr    %cl,%ebx
  801b18:	89 da                	mov    %ebx,%edx
  801b1a:	f7 f7                	div    %edi
  801b1c:	89 d3                	mov    %edx,%ebx
  801b1e:	f7 24 24             	mull   (%esp)
  801b21:	89 c6                	mov    %eax,%esi
  801b23:	89 d1                	mov    %edx,%ecx
  801b25:	39 d3                	cmp    %edx,%ebx
  801b27:	0f 82 87 00 00 00    	jb     801bb4 <__umoddi3+0x134>
  801b2d:	0f 84 91 00 00 00    	je     801bc4 <__umoddi3+0x144>
  801b33:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b37:	29 f2                	sub    %esi,%edx
  801b39:	19 cb                	sbb    %ecx,%ebx
  801b3b:	89 d8                	mov    %ebx,%eax
  801b3d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b41:	d3 e0                	shl    %cl,%eax
  801b43:	89 e9                	mov    %ebp,%ecx
  801b45:	d3 ea                	shr    %cl,%edx
  801b47:	09 d0                	or     %edx,%eax
  801b49:	89 e9                	mov    %ebp,%ecx
  801b4b:	d3 eb                	shr    %cl,%ebx
  801b4d:	89 da                	mov    %ebx,%edx
  801b4f:	83 c4 1c             	add    $0x1c,%esp
  801b52:	5b                   	pop    %ebx
  801b53:	5e                   	pop    %esi
  801b54:	5f                   	pop    %edi
  801b55:	5d                   	pop    %ebp
  801b56:	c3                   	ret    
  801b57:	90                   	nop
  801b58:	89 fd                	mov    %edi,%ebp
  801b5a:	85 ff                	test   %edi,%edi
  801b5c:	75 0b                	jne    801b69 <__umoddi3+0xe9>
  801b5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b63:	31 d2                	xor    %edx,%edx
  801b65:	f7 f7                	div    %edi
  801b67:	89 c5                	mov    %eax,%ebp
  801b69:	89 f0                	mov    %esi,%eax
  801b6b:	31 d2                	xor    %edx,%edx
  801b6d:	f7 f5                	div    %ebp
  801b6f:	89 c8                	mov    %ecx,%eax
  801b71:	f7 f5                	div    %ebp
  801b73:	89 d0                	mov    %edx,%eax
  801b75:	e9 44 ff ff ff       	jmp    801abe <__umoddi3+0x3e>
  801b7a:	66 90                	xchg   %ax,%ax
  801b7c:	89 c8                	mov    %ecx,%eax
  801b7e:	89 f2                	mov    %esi,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	3b 04 24             	cmp    (%esp),%eax
  801b8b:	72 06                	jb     801b93 <__umoddi3+0x113>
  801b8d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b91:	77 0f                	ja     801ba2 <__umoddi3+0x122>
  801b93:	89 f2                	mov    %esi,%edx
  801b95:	29 f9                	sub    %edi,%ecx
  801b97:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b9b:	89 14 24             	mov    %edx,(%esp)
  801b9e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ba2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ba6:	8b 14 24             	mov    (%esp),%edx
  801ba9:	83 c4 1c             	add    $0x1c,%esp
  801bac:	5b                   	pop    %ebx
  801bad:	5e                   	pop    %esi
  801bae:	5f                   	pop    %edi
  801baf:	5d                   	pop    %ebp
  801bb0:	c3                   	ret    
  801bb1:	8d 76 00             	lea    0x0(%esi),%esi
  801bb4:	2b 04 24             	sub    (%esp),%eax
  801bb7:	19 fa                	sbb    %edi,%edx
  801bb9:	89 d1                	mov    %edx,%ecx
  801bbb:	89 c6                	mov    %eax,%esi
  801bbd:	e9 71 ff ff ff       	jmp    801b33 <__umoddi3+0xb3>
  801bc2:	66 90                	xchg   %ax,%ax
  801bc4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bc8:	72 ea                	jb     801bb4 <__umoddi3+0x134>
  801bca:	89 d9                	mov    %ebx,%ecx
  801bcc:	e9 62 ff ff ff       	jmp    801b33 <__umoddi3+0xb3>
