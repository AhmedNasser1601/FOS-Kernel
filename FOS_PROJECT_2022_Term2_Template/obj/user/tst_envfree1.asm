
obj/user/tst_envfree1:     file format elf32-i386


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
  800031:	e8 3c 01 00 00       	call   800172 <libmain>
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
	// Testing scenario 1: without using dynamic allocation/de-allocation, shared variables and semaphores
	// Testing removing the allocated pages in mem, WS, mapped page tables, env's directory and env's page file

	int freeFrames_before = sys_calculate_free_frames() ;
  80003e:	e8 e8 13 00 00       	call   80142b <sys_calculate_free_frames>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int usedDiskPages_before = sys_pf_calculate_allocated_pages() ;
  800046:	e8 63 14 00 00       	call   8014ae <sys_pf_calculate_allocated_pages>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("\n---# of free frames before running programs = %d\n", freeFrames_before);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f4             	pushl  -0xc(%ebp)
  800054:	68 00 1c 80 00       	push   $0x801c00
  800059:	e8 d7 04 00 00       	call   800535 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	/*[4] CREATE AND RUN ProcessA & ProcessB*/
	//Create 3 processes
	int32 envIdProcessA = sys_create_env("ef_fib", 5, 50);
  800061:	83 ec 04             	sub    $0x4,%esp
  800064:	6a 32                	push   $0x32
  800066:	6a 05                	push   $0x5
  800068:	68 33 1c 80 00       	push   $0x801c33
  80006d:	e8 0e 16 00 00       	call   801680 <sys_create_env>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int32 envIdProcessB = sys_create_env("ef_fact", 4, 50);
  800078:	83 ec 04             	sub    $0x4,%esp
  80007b:	6a 32                	push   $0x32
  80007d:	6a 04                	push   $0x4
  80007f:	68 3a 1c 80 00       	push   $0x801c3a
  800084:	e8 f7 15 00 00       	call   801680 <sys_create_env>
  800089:	83 c4 10             	add    $0x10,%esp
  80008c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 envIdProcessC = sys_create_env("ef_fos_add", 30, 50);
  80008f:	83 ec 04             	sub    $0x4,%esp
  800092:	6a 32                	push   $0x32
  800094:	6a 1e                	push   $0x1e
  800096:	68 42 1c 80 00       	push   $0x801c42
  80009b:	e8 e0 15 00 00       	call   801680 <sys_create_env>
  8000a0:	83 c4 10             	add    $0x10,%esp
  8000a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Run 3 processes
	sys_run_env(envIdProcessA);
  8000a6:	83 ec 0c             	sub    $0xc,%esp
  8000a9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000ac:	e8 ec 15 00 00       	call   80169d <sys_run_env>
  8000b1:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  8000b4:	83 ec 0c             	sub    $0xc,%esp
  8000b7:	ff 75 e8             	pushl  -0x18(%ebp)
  8000ba:	e8 de 15 00 00       	call   80169d <sys_run_env>
  8000bf:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessC);
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000c8:	e8 d0 15 00 00       	call   80169d <sys_run_env>
  8000cd:	83 c4 10             	add    $0x10,%esp

	env_sleep(6000);
  8000d0:	83 ec 0c             	sub    $0xc,%esp
  8000d3:	68 70 17 00 00       	push   $0x1770
  8000d8:	e8 fc 17 00 00       	call   8018d9 <env_sleep>
  8000dd:	83 c4 10             	add    $0x10,%esp
	cprintf("\n---# of free frames after running programs = %d\n", sys_calculate_free_frames());
  8000e0:	e8 46 13 00 00       	call   80142b <sys_calculate_free_frames>
  8000e5:	83 ec 08             	sub    $0x8,%esp
  8000e8:	50                   	push   %eax
  8000e9:	68 50 1c 80 00       	push   $0x801c50
  8000ee:	e8 42 04 00 00       	call   800535 <cprintf>
  8000f3:	83 c4 10             	add    $0x10,%esp

	//Kill the 3 processes
	sys_free_env(envIdProcessA);
  8000f6:	83 ec 0c             	sub    $0xc,%esp
  8000f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8000fc:	e8 b8 15 00 00       	call   8016b9 <sys_free_env>
  800101:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessB);
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	ff 75 e8             	pushl  -0x18(%ebp)
  80010a:	e8 aa 15 00 00       	call   8016b9 <sys_free_env>
  80010f:	83 c4 10             	add    $0x10,%esp
	sys_free_env(envIdProcessC);
  800112:	83 ec 0c             	sub    $0xc,%esp
  800115:	ff 75 e4             	pushl  -0x1c(%ebp)
  800118:	e8 9c 15 00 00       	call   8016b9 <sys_free_env>
  80011d:	83 c4 10             	add    $0x10,%esp

	//Checking the number of frames after killing the created environments
	int freeFrames_after = sys_calculate_free_frames() ;
  800120:	e8 06 13 00 00       	call   80142b <sys_calculate_free_frames>
  800125:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages_after = sys_pf_calculate_allocated_pages() ;
  800128:	e8 81 13 00 00       	call   8014ae <sys_pf_calculate_allocated_pages>
  80012d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	if((freeFrames_after - freeFrames_before) !=0)
  800130:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800133:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800136:	74 14                	je     80014c <_main+0x114>
		panic("env_free() does not work correctly... check it again.") ;
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 84 1c 80 00       	push   $0x801c84
  800140:	6a 25                	push   $0x25
  800142:	68 ba 1c 80 00       	push   $0x801cba
  800147:	e8 35 01 00 00       	call   800281 <_panic>

	cprintf("\n---# of free frames after closing running programs returned back to be as before running = %d\n", freeFrames_after);
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	ff 75 e0             	pushl  -0x20(%ebp)
  800152:	68 d0 1c 80 00       	push   $0x801cd0
  800157:	e8 d9 03 00 00       	call   800535 <cprintf>
  80015c:	83 c4 10             	add    $0x10,%esp

	cprintf("\n\nCongratulations!! test scenario 1 for envfree completed successfully.\n");
  80015f:	83 ec 0c             	sub    $0xc,%esp
  800162:	68 30 1d 80 00       	push   $0x801d30
  800167:	e8 c9 03 00 00       	call   800535 <cprintf>
  80016c:	83 c4 10             	add    $0x10,%esp
	return;
  80016f:	90                   	nop
}
  800170:	c9                   	leave  
  800171:	c3                   	ret    

00800172 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800172:	55                   	push   %ebp
  800173:	89 e5                	mov    %esp,%ebp
  800175:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800178:	e8 e3 11 00 00       	call   801360 <sys_getenvindex>
  80017d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800180:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800183:	89 d0                	mov    %edx,%eax
  800185:	c1 e0 02             	shl    $0x2,%eax
  800188:	01 d0                	add    %edx,%eax
  80018a:	01 c0                	add    %eax,%eax
  80018c:	01 d0                	add    %edx,%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	01 d0                	add    %edx,%eax
  800192:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800199:	01 d0                	add    %edx,%eax
  80019b:	c1 e0 02             	shl    $0x2,%eax
  80019e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001a3:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001a8:	a1 04 30 80 00       	mov    0x803004,%eax
  8001ad:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8001b3:	84 c0                	test   %al,%al
  8001b5:	74 0f                	je     8001c6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8001b7:	a1 04 30 80 00       	mov    0x803004,%eax
  8001bc:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001c1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ca:	7e 0a                	jle    8001d6 <libmain+0x64>
		binaryname = argv[0];
  8001cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cf:	8b 00                	mov    (%eax),%eax
  8001d1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8001d6:	83 ec 08             	sub    $0x8,%esp
  8001d9:	ff 75 0c             	pushl  0xc(%ebp)
  8001dc:	ff 75 08             	pushl  0x8(%ebp)
  8001df:	e8 54 fe ff ff       	call   800038 <_main>
  8001e4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001e7:	e8 0f 13 00 00       	call   8014fb <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	68 94 1d 80 00       	push   $0x801d94
  8001f4:	e8 3c 03 00 00       	call   800535 <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001fc:	a1 04 30 80 00       	mov    0x803004,%eax
  800201:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800207:	a1 04 30 80 00       	mov    0x803004,%eax
  80020c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800212:	83 ec 04             	sub    $0x4,%esp
  800215:	52                   	push   %edx
  800216:	50                   	push   %eax
  800217:	68 bc 1d 80 00       	push   $0x801dbc
  80021c:	e8 14 03 00 00       	call   800535 <cprintf>
  800221:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800224:	a1 04 30 80 00       	mov    0x803004,%eax
  800229:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80022f:	83 ec 08             	sub    $0x8,%esp
  800232:	50                   	push   %eax
  800233:	68 e1 1d 80 00       	push   $0x801de1
  800238:	e8 f8 02 00 00       	call   800535 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	68 94 1d 80 00       	push   $0x801d94
  800248:	e8 e8 02 00 00       	call   800535 <cprintf>
  80024d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800250:	e8 c0 12 00 00       	call   801515 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800255:	e8 19 00 00 00       	call   800273 <exit>
}
  80025a:	90                   	nop
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800263:	83 ec 0c             	sub    $0xc,%esp
  800266:	6a 00                	push   $0x0
  800268:	e8 bf 10 00 00       	call   80132c <sys_env_destroy>
  80026d:	83 c4 10             	add    $0x10,%esp
}
  800270:	90                   	nop
  800271:	c9                   	leave  
  800272:	c3                   	ret    

00800273 <exit>:

void
exit(void)
{
  800273:	55                   	push   %ebp
  800274:	89 e5                	mov    %esp,%ebp
  800276:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800279:	e8 14 11 00 00       	call   801392 <sys_env_exit>
}
  80027e:	90                   	nop
  80027f:	c9                   	leave  
  800280:	c3                   	ret    

00800281 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800281:	55                   	push   %ebp
  800282:	89 e5                	mov    %esp,%ebp
  800284:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800287:	8d 45 10             	lea    0x10(%ebp),%eax
  80028a:	83 c0 04             	add    $0x4,%eax
  80028d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800290:	a1 14 30 80 00       	mov    0x803014,%eax
  800295:	85 c0                	test   %eax,%eax
  800297:	74 16                	je     8002af <_panic+0x2e>
		cprintf("%s: ", argv0);
  800299:	a1 14 30 80 00       	mov    0x803014,%eax
  80029e:	83 ec 08             	sub    $0x8,%esp
  8002a1:	50                   	push   %eax
  8002a2:	68 f8 1d 80 00       	push   $0x801df8
  8002a7:	e8 89 02 00 00       	call   800535 <cprintf>
  8002ac:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8002af:	a1 00 30 80 00       	mov    0x803000,%eax
  8002b4:	ff 75 0c             	pushl  0xc(%ebp)
  8002b7:	ff 75 08             	pushl  0x8(%ebp)
  8002ba:	50                   	push   %eax
  8002bb:	68 fd 1d 80 00       	push   $0x801dfd
  8002c0:	e8 70 02 00 00       	call   800535 <cprintf>
  8002c5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8002c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8002cb:	83 ec 08             	sub    $0x8,%esp
  8002ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d1:	50                   	push   %eax
  8002d2:	e8 f3 01 00 00       	call   8004ca <vcprintf>
  8002d7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	6a 00                	push   $0x0
  8002df:	68 19 1e 80 00       	push   $0x801e19
  8002e4:	e8 e1 01 00 00       	call   8004ca <vcprintf>
  8002e9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002ec:	e8 82 ff ff ff       	call   800273 <exit>

	// should not return here
	while (1) ;
  8002f1:	eb fe                	jmp    8002f1 <_panic+0x70>

008002f3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002f3:	55                   	push   %ebp
  8002f4:	89 e5                	mov    %esp,%ebp
  8002f6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002f9:	a1 04 30 80 00       	mov    0x803004,%eax
  8002fe:	8b 50 74             	mov    0x74(%eax),%edx
  800301:	8b 45 0c             	mov    0xc(%ebp),%eax
  800304:	39 c2                	cmp    %eax,%edx
  800306:	74 14                	je     80031c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800308:	83 ec 04             	sub    $0x4,%esp
  80030b:	68 1c 1e 80 00       	push   $0x801e1c
  800310:	6a 26                	push   $0x26
  800312:	68 68 1e 80 00       	push   $0x801e68
  800317:	e8 65 ff ff ff       	call   800281 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80031c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800323:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80032a:	e9 c2 00 00 00       	jmp    8003f1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80032f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	85 c0                	test   %eax,%eax
  800342:	75 08                	jne    80034c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800344:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800347:	e9 a2 00 00 00       	jmp    8003ee <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80034c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800353:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80035a:	eb 69                	jmp    8003c5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80035c:	a1 04 30 80 00       	mov    0x803004,%eax
  800361:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800367:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80036a:	89 d0                	mov    %edx,%eax
  80036c:	01 c0                	add    %eax,%eax
  80036e:	01 d0                	add    %edx,%eax
  800370:	c1 e0 02             	shl    $0x2,%eax
  800373:	01 c8                	add    %ecx,%eax
  800375:	8a 40 04             	mov    0x4(%eax),%al
  800378:	84 c0                	test   %al,%al
  80037a:	75 46                	jne    8003c2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80037c:	a1 04 30 80 00       	mov    0x803004,%eax
  800381:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800387:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80038a:	89 d0                	mov    %edx,%eax
  80038c:	01 c0                	add    %eax,%eax
  80038e:	01 d0                	add    %edx,%eax
  800390:	c1 e0 02             	shl    $0x2,%eax
  800393:	01 c8                	add    %ecx,%eax
  800395:	8b 00                	mov    (%eax),%eax
  800397:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80039a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b1:	01 c8                	add    %ecx,%eax
  8003b3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003b5:	39 c2                	cmp    %eax,%edx
  8003b7:	75 09                	jne    8003c2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8003b9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8003c0:	eb 12                	jmp    8003d4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c2:	ff 45 e8             	incl   -0x18(%ebp)
  8003c5:	a1 04 30 80 00       	mov    0x803004,%eax
  8003ca:	8b 50 74             	mov    0x74(%eax),%edx
  8003cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003d0:	39 c2                	cmp    %eax,%edx
  8003d2:	77 88                	ja     80035c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8003d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003d8:	75 14                	jne    8003ee <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 74 1e 80 00       	push   $0x801e74
  8003e2:	6a 3a                	push   $0x3a
  8003e4:	68 68 1e 80 00       	push   $0x801e68
  8003e9:	e8 93 fe ff ff       	call   800281 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ee:	ff 45 f0             	incl   -0x10(%ebp)
  8003f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003f7:	0f 8c 32 ff ff ff    	jl     80032f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800404:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80040b:	eb 26                	jmp    800433 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80040d:	a1 04 30 80 00       	mov    0x803004,%eax
  800412:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800418:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80041b:	89 d0                	mov    %edx,%eax
  80041d:	01 c0                	add    %eax,%eax
  80041f:	01 d0                	add    %edx,%eax
  800421:	c1 e0 02             	shl    $0x2,%eax
  800424:	01 c8                	add    %ecx,%eax
  800426:	8a 40 04             	mov    0x4(%eax),%al
  800429:	3c 01                	cmp    $0x1,%al
  80042b:	75 03                	jne    800430 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80042d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800430:	ff 45 e0             	incl   -0x20(%ebp)
  800433:	a1 04 30 80 00       	mov    0x803004,%eax
  800438:	8b 50 74             	mov    0x74(%eax),%edx
  80043b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80043e:	39 c2                	cmp    %eax,%edx
  800440:	77 cb                	ja     80040d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800442:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800445:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800448:	74 14                	je     80045e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80044a:	83 ec 04             	sub    $0x4,%esp
  80044d:	68 c8 1e 80 00       	push   $0x801ec8
  800452:	6a 44                	push   $0x44
  800454:	68 68 1e 80 00       	push   $0x801e68
  800459:	e8 23 fe ff ff       	call   800281 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80045e:	90                   	nop
  80045f:	c9                   	leave  
  800460:	c3                   	ret    

00800461 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800461:	55                   	push   %ebp
  800462:	89 e5                	mov    %esp,%ebp
  800464:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800467:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	8d 48 01             	lea    0x1(%eax),%ecx
  80046f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800472:	89 0a                	mov    %ecx,(%edx)
  800474:	8b 55 08             	mov    0x8(%ebp),%edx
  800477:	88 d1                	mov    %dl,%cl
  800479:	8b 55 0c             	mov    0xc(%ebp),%edx
  80047c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800480:	8b 45 0c             	mov    0xc(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	3d ff 00 00 00       	cmp    $0xff,%eax
  80048a:	75 2c                	jne    8004b8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80048c:	a0 08 30 80 00       	mov    0x803008,%al
  800491:	0f b6 c0             	movzbl %al,%eax
  800494:	8b 55 0c             	mov    0xc(%ebp),%edx
  800497:	8b 12                	mov    (%edx),%edx
  800499:	89 d1                	mov    %edx,%ecx
  80049b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80049e:	83 c2 08             	add    $0x8,%edx
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	50                   	push   %eax
  8004a5:	51                   	push   %ecx
  8004a6:	52                   	push   %edx
  8004a7:	e8 3e 0e 00 00       	call   8012ea <sys_cputs>
  8004ac:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bb:	8b 40 04             	mov    0x4(%eax),%eax
  8004be:	8d 50 01             	lea    0x1(%eax),%edx
  8004c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8004c7:	90                   	nop
  8004c8:	c9                   	leave  
  8004c9:	c3                   	ret    

008004ca <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8004ca:	55                   	push   %ebp
  8004cb:	89 e5                	mov    %esp,%ebp
  8004cd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8004d3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004da:	00 00 00 
	b.cnt = 0;
  8004dd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004e4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004e7:	ff 75 0c             	pushl  0xc(%ebp)
  8004ea:	ff 75 08             	pushl  0x8(%ebp)
  8004ed:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004f3:	50                   	push   %eax
  8004f4:	68 61 04 80 00       	push   $0x800461
  8004f9:	e8 11 02 00 00       	call   80070f <vprintfmt>
  8004fe:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800501:	a0 08 30 80 00       	mov    0x803008,%al
  800506:	0f b6 c0             	movzbl %al,%eax
  800509:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80050f:	83 ec 04             	sub    $0x4,%esp
  800512:	50                   	push   %eax
  800513:	52                   	push   %edx
  800514:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80051a:	83 c0 08             	add    $0x8,%eax
  80051d:	50                   	push   %eax
  80051e:	e8 c7 0d 00 00       	call   8012ea <sys_cputs>
  800523:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800526:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  80052d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800533:	c9                   	leave  
  800534:	c3                   	ret    

00800535 <cprintf>:

int cprintf(const char *fmt, ...) {
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
  800538:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80053b:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800542:	8d 45 0c             	lea    0xc(%ebp),%eax
  800545:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800548:	8b 45 08             	mov    0x8(%ebp),%eax
  80054b:	83 ec 08             	sub    $0x8,%esp
  80054e:	ff 75 f4             	pushl  -0xc(%ebp)
  800551:	50                   	push   %eax
  800552:	e8 73 ff ff ff       	call   8004ca <vcprintf>
  800557:	83 c4 10             	add    $0x10,%esp
  80055a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80055d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
  800565:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800568:	e8 8e 0f 00 00       	call   8014fb <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80056d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800570:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800573:	8b 45 08             	mov    0x8(%ebp),%eax
  800576:	83 ec 08             	sub    $0x8,%esp
  800579:	ff 75 f4             	pushl  -0xc(%ebp)
  80057c:	50                   	push   %eax
  80057d:	e8 48 ff ff ff       	call   8004ca <vcprintf>
  800582:	83 c4 10             	add    $0x10,%esp
  800585:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800588:	e8 88 0f 00 00       	call   801515 <sys_enable_interrupt>
	return cnt;
  80058d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	53                   	push   %ebx
  800596:	83 ec 14             	sub    $0x14,%esp
  800599:	8b 45 10             	mov    0x10(%ebp),%eax
  80059c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80059f:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005a5:	8b 45 18             	mov    0x18(%ebp),%eax
  8005a8:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ad:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005b0:	77 55                	ja     800607 <printnum+0x75>
  8005b2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005b5:	72 05                	jb     8005bc <printnum+0x2a>
  8005b7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005ba:	77 4b                	ja     800607 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005bc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005bf:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005c2:	8b 45 18             	mov    0x18(%ebp),%eax
  8005c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ca:	52                   	push   %edx
  8005cb:	50                   	push   %eax
  8005cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8005cf:	ff 75 f0             	pushl  -0x10(%ebp)
  8005d2:	e8 b9 13 00 00       	call   801990 <__udivdi3>
  8005d7:	83 c4 10             	add    $0x10,%esp
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	ff 75 20             	pushl  0x20(%ebp)
  8005e0:	53                   	push   %ebx
  8005e1:	ff 75 18             	pushl  0x18(%ebp)
  8005e4:	52                   	push   %edx
  8005e5:	50                   	push   %eax
  8005e6:	ff 75 0c             	pushl  0xc(%ebp)
  8005e9:	ff 75 08             	pushl  0x8(%ebp)
  8005ec:	e8 a1 ff ff ff       	call   800592 <printnum>
  8005f1:	83 c4 20             	add    $0x20,%esp
  8005f4:	eb 1a                	jmp    800610 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005f6:	83 ec 08             	sub    $0x8,%esp
  8005f9:	ff 75 0c             	pushl  0xc(%ebp)
  8005fc:	ff 75 20             	pushl  0x20(%ebp)
  8005ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800602:	ff d0                	call   *%eax
  800604:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800607:	ff 4d 1c             	decl   0x1c(%ebp)
  80060a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80060e:	7f e6                	jg     8005f6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800610:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800613:	bb 00 00 00 00       	mov    $0x0,%ebx
  800618:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80061e:	53                   	push   %ebx
  80061f:	51                   	push   %ecx
  800620:	52                   	push   %edx
  800621:	50                   	push   %eax
  800622:	e8 79 14 00 00       	call   801aa0 <__umoddi3>
  800627:	83 c4 10             	add    $0x10,%esp
  80062a:	05 34 21 80 00       	add    $0x802134,%eax
  80062f:	8a 00                	mov    (%eax),%al
  800631:	0f be c0             	movsbl %al,%eax
  800634:	83 ec 08             	sub    $0x8,%esp
  800637:	ff 75 0c             	pushl  0xc(%ebp)
  80063a:	50                   	push   %eax
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	ff d0                	call   *%eax
  800640:	83 c4 10             	add    $0x10,%esp
}
  800643:	90                   	nop
  800644:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800647:	c9                   	leave  
  800648:	c3                   	ret    

00800649 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800649:	55                   	push   %ebp
  80064a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80064c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800650:	7e 1c                	jle    80066e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	8b 00                	mov    (%eax),%eax
  800657:	8d 50 08             	lea    0x8(%eax),%edx
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	89 10                	mov    %edx,(%eax)
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	8b 00                	mov    (%eax),%eax
  800664:	83 e8 08             	sub    $0x8,%eax
  800667:	8b 50 04             	mov    0x4(%eax),%edx
  80066a:	8b 00                	mov    (%eax),%eax
  80066c:	eb 40                	jmp    8006ae <getuint+0x65>
	else if (lflag)
  80066e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800672:	74 1e                	je     800692 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800674:	8b 45 08             	mov    0x8(%ebp),%eax
  800677:	8b 00                	mov    (%eax),%eax
  800679:	8d 50 04             	lea    0x4(%eax),%edx
  80067c:	8b 45 08             	mov    0x8(%ebp),%eax
  80067f:	89 10                	mov    %edx,(%eax)
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	8b 00                	mov    (%eax),%eax
  800686:	83 e8 04             	sub    $0x4,%eax
  800689:	8b 00                	mov    (%eax),%eax
  80068b:	ba 00 00 00 00       	mov    $0x0,%edx
  800690:	eb 1c                	jmp    8006ae <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	8b 00                	mov    (%eax),%eax
  800697:	8d 50 04             	lea    0x4(%eax),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	89 10                	mov    %edx,(%eax)
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	8b 00                	mov    (%eax),%eax
  8006a4:	83 e8 04             	sub    $0x4,%eax
  8006a7:	8b 00                	mov    (%eax),%eax
  8006a9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006ae:	5d                   	pop    %ebp
  8006af:	c3                   	ret    

008006b0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006b0:	55                   	push   %ebp
  8006b1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006b7:	7e 1c                	jle    8006d5 <getint+0x25>
		return va_arg(*ap, long long);
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	8d 50 08             	lea    0x8(%eax),%edx
  8006c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c4:	89 10                	mov    %edx,(%eax)
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	83 e8 08             	sub    $0x8,%eax
  8006ce:	8b 50 04             	mov    0x4(%eax),%edx
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	eb 38                	jmp    80070d <getint+0x5d>
	else if (lflag)
  8006d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d9:	74 1a                	je     8006f5 <getint+0x45>
		return va_arg(*ap, long);
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	8b 00                	mov    (%eax),%eax
  8006e0:	8d 50 04             	lea    0x4(%eax),%edx
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	89 10                	mov    %edx,(%eax)
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	8b 00                	mov    (%eax),%eax
  8006ed:	83 e8 04             	sub    $0x4,%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	99                   	cltd   
  8006f3:	eb 18                	jmp    80070d <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	8d 50 04             	lea    0x4(%eax),%edx
  8006fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800700:	89 10                	mov    %edx,(%eax)
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	8b 00                	mov    (%eax),%eax
  800707:	83 e8 04             	sub    $0x4,%eax
  80070a:	8b 00                	mov    (%eax),%eax
  80070c:	99                   	cltd   
}
  80070d:	5d                   	pop    %ebp
  80070e:	c3                   	ret    

0080070f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80070f:	55                   	push   %ebp
  800710:	89 e5                	mov    %esp,%ebp
  800712:	56                   	push   %esi
  800713:	53                   	push   %ebx
  800714:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800717:	eb 17                	jmp    800730 <vprintfmt+0x21>
			if (ch == '\0')
  800719:	85 db                	test   %ebx,%ebx
  80071b:	0f 84 af 03 00 00    	je     800ad0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	53                   	push   %ebx
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	ff d0                	call   *%eax
  80072d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800730:	8b 45 10             	mov    0x10(%ebp),%eax
  800733:	8d 50 01             	lea    0x1(%eax),%edx
  800736:	89 55 10             	mov    %edx,0x10(%ebp)
  800739:	8a 00                	mov    (%eax),%al
  80073b:	0f b6 d8             	movzbl %al,%ebx
  80073e:	83 fb 25             	cmp    $0x25,%ebx
  800741:	75 d6                	jne    800719 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800743:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800747:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80074e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800755:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80075c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800763:	8b 45 10             	mov    0x10(%ebp),%eax
  800766:	8d 50 01             	lea    0x1(%eax),%edx
  800769:	89 55 10             	mov    %edx,0x10(%ebp)
  80076c:	8a 00                	mov    (%eax),%al
  80076e:	0f b6 d8             	movzbl %al,%ebx
  800771:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800774:	83 f8 55             	cmp    $0x55,%eax
  800777:	0f 87 2b 03 00 00    	ja     800aa8 <vprintfmt+0x399>
  80077d:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
  800784:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800786:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80078a:	eb d7                	jmp    800763 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80078c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800790:	eb d1                	jmp    800763 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800792:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800799:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80079c:	89 d0                	mov    %edx,%eax
  80079e:	c1 e0 02             	shl    $0x2,%eax
  8007a1:	01 d0                	add    %edx,%eax
  8007a3:	01 c0                	add    %eax,%eax
  8007a5:	01 d8                	add    %ebx,%eax
  8007a7:	83 e8 30             	sub    $0x30,%eax
  8007aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b0:	8a 00                	mov    (%eax),%al
  8007b2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007b5:	83 fb 2f             	cmp    $0x2f,%ebx
  8007b8:	7e 3e                	jle    8007f8 <vprintfmt+0xe9>
  8007ba:	83 fb 39             	cmp    $0x39,%ebx
  8007bd:	7f 39                	jg     8007f8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007bf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007c2:	eb d5                	jmp    800799 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c7:	83 c0 04             	add    $0x4,%eax
  8007ca:	89 45 14             	mov    %eax,0x14(%ebp)
  8007cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d0:	83 e8 04             	sub    $0x4,%eax
  8007d3:	8b 00                	mov    (%eax),%eax
  8007d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007d8:	eb 1f                	jmp    8007f9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007de:	79 83                	jns    800763 <vprintfmt+0x54>
				width = 0;
  8007e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007e7:	e9 77 ff ff ff       	jmp    800763 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007ec:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007f3:	e9 6b ff ff ff       	jmp    800763 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007f8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007fd:	0f 89 60 ff ff ff    	jns    800763 <vprintfmt+0x54>
				width = precision, precision = -1;
  800803:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800806:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800809:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800810:	e9 4e ff ff ff       	jmp    800763 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800815:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800818:	e9 46 ff ff ff       	jmp    800763 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80081d:	8b 45 14             	mov    0x14(%ebp),%eax
  800820:	83 c0 04             	add    $0x4,%eax
  800823:	89 45 14             	mov    %eax,0x14(%ebp)
  800826:	8b 45 14             	mov    0x14(%ebp),%eax
  800829:	83 e8 04             	sub    $0x4,%eax
  80082c:	8b 00                	mov    (%eax),%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	50                   	push   %eax
  800835:	8b 45 08             	mov    0x8(%ebp),%eax
  800838:	ff d0                	call   *%eax
  80083a:	83 c4 10             	add    $0x10,%esp
			break;
  80083d:	e9 89 02 00 00       	jmp    800acb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800842:	8b 45 14             	mov    0x14(%ebp),%eax
  800845:	83 c0 04             	add    $0x4,%eax
  800848:	89 45 14             	mov    %eax,0x14(%ebp)
  80084b:	8b 45 14             	mov    0x14(%ebp),%eax
  80084e:	83 e8 04             	sub    $0x4,%eax
  800851:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800853:	85 db                	test   %ebx,%ebx
  800855:	79 02                	jns    800859 <vprintfmt+0x14a>
				err = -err;
  800857:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800859:	83 fb 64             	cmp    $0x64,%ebx
  80085c:	7f 0b                	jg     800869 <vprintfmt+0x15a>
  80085e:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  800865:	85 f6                	test   %esi,%esi
  800867:	75 19                	jne    800882 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800869:	53                   	push   %ebx
  80086a:	68 45 21 80 00       	push   $0x802145
  80086f:	ff 75 0c             	pushl  0xc(%ebp)
  800872:	ff 75 08             	pushl  0x8(%ebp)
  800875:	e8 5e 02 00 00       	call   800ad8 <printfmt>
  80087a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80087d:	e9 49 02 00 00       	jmp    800acb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800882:	56                   	push   %esi
  800883:	68 4e 21 80 00       	push   $0x80214e
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	ff 75 08             	pushl  0x8(%ebp)
  80088e:	e8 45 02 00 00       	call   800ad8 <printfmt>
  800893:	83 c4 10             	add    $0x10,%esp
			break;
  800896:	e9 30 02 00 00       	jmp    800acb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80089b:	8b 45 14             	mov    0x14(%ebp),%eax
  80089e:	83 c0 04             	add    $0x4,%eax
  8008a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a7:	83 e8 04             	sub    $0x4,%eax
  8008aa:	8b 30                	mov    (%eax),%esi
  8008ac:	85 f6                	test   %esi,%esi
  8008ae:	75 05                	jne    8008b5 <vprintfmt+0x1a6>
				p = "(null)";
  8008b0:	be 51 21 80 00       	mov    $0x802151,%esi
			if (width > 0 && padc != '-')
  8008b5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b9:	7e 6d                	jle    800928 <vprintfmt+0x219>
  8008bb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008bf:	74 67                	je     800928 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c4:	83 ec 08             	sub    $0x8,%esp
  8008c7:	50                   	push   %eax
  8008c8:	56                   	push   %esi
  8008c9:	e8 0c 03 00 00       	call   800bda <strnlen>
  8008ce:	83 c4 10             	add    $0x10,%esp
  8008d1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008d4:	eb 16                	jmp    8008ec <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008d6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008da:	83 ec 08             	sub    $0x8,%esp
  8008dd:	ff 75 0c             	pushl  0xc(%ebp)
  8008e0:	50                   	push   %eax
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	ff d0                	call   *%eax
  8008e6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008e9:	ff 4d e4             	decl   -0x1c(%ebp)
  8008ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f0:	7f e4                	jg     8008d6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f2:	eb 34                	jmp    800928 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008f4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008f8:	74 1c                	je     800916 <vprintfmt+0x207>
  8008fa:	83 fb 1f             	cmp    $0x1f,%ebx
  8008fd:	7e 05                	jle    800904 <vprintfmt+0x1f5>
  8008ff:	83 fb 7e             	cmp    $0x7e,%ebx
  800902:	7e 12                	jle    800916 <vprintfmt+0x207>
					putch('?', putdat);
  800904:	83 ec 08             	sub    $0x8,%esp
  800907:	ff 75 0c             	pushl  0xc(%ebp)
  80090a:	6a 3f                	push   $0x3f
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	ff d0                	call   *%eax
  800911:	83 c4 10             	add    $0x10,%esp
  800914:	eb 0f                	jmp    800925 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800916:	83 ec 08             	sub    $0x8,%esp
  800919:	ff 75 0c             	pushl  0xc(%ebp)
  80091c:	53                   	push   %ebx
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	ff d0                	call   *%eax
  800922:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800925:	ff 4d e4             	decl   -0x1c(%ebp)
  800928:	89 f0                	mov    %esi,%eax
  80092a:	8d 70 01             	lea    0x1(%eax),%esi
  80092d:	8a 00                	mov    (%eax),%al
  80092f:	0f be d8             	movsbl %al,%ebx
  800932:	85 db                	test   %ebx,%ebx
  800934:	74 24                	je     80095a <vprintfmt+0x24b>
  800936:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093a:	78 b8                	js     8008f4 <vprintfmt+0x1e5>
  80093c:	ff 4d e0             	decl   -0x20(%ebp)
  80093f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800943:	79 af                	jns    8008f4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800945:	eb 13                	jmp    80095a <vprintfmt+0x24b>
				putch(' ', putdat);
  800947:	83 ec 08             	sub    $0x8,%esp
  80094a:	ff 75 0c             	pushl  0xc(%ebp)
  80094d:	6a 20                	push   $0x20
  80094f:	8b 45 08             	mov    0x8(%ebp),%eax
  800952:	ff d0                	call   *%eax
  800954:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800957:	ff 4d e4             	decl   -0x1c(%ebp)
  80095a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80095e:	7f e7                	jg     800947 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800960:	e9 66 01 00 00       	jmp    800acb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800965:	83 ec 08             	sub    $0x8,%esp
  800968:	ff 75 e8             	pushl  -0x18(%ebp)
  80096b:	8d 45 14             	lea    0x14(%ebp),%eax
  80096e:	50                   	push   %eax
  80096f:	e8 3c fd ff ff       	call   8006b0 <getint>
  800974:	83 c4 10             	add    $0x10,%esp
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80097d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800980:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800983:	85 d2                	test   %edx,%edx
  800985:	79 23                	jns    8009aa <vprintfmt+0x29b>
				putch('-', putdat);
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	ff 75 0c             	pushl  0xc(%ebp)
  80098d:	6a 2d                	push   $0x2d
  80098f:	8b 45 08             	mov    0x8(%ebp),%eax
  800992:	ff d0                	call   *%eax
  800994:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800997:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80099d:	f7 d8                	neg    %eax
  80099f:	83 d2 00             	adc    $0x0,%edx
  8009a2:	f7 da                	neg    %edx
  8009a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009aa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009b1:	e9 bc 00 00 00       	jmp    800a72 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009b6:	83 ec 08             	sub    $0x8,%esp
  8009b9:	ff 75 e8             	pushl  -0x18(%ebp)
  8009bc:	8d 45 14             	lea    0x14(%ebp),%eax
  8009bf:	50                   	push   %eax
  8009c0:	e8 84 fc ff ff       	call   800649 <getuint>
  8009c5:	83 c4 10             	add    $0x10,%esp
  8009c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009ce:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009d5:	e9 98 00 00 00       	jmp    800a72 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	6a 58                	push   $0x58
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	ff d0                	call   *%eax
  8009e7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 0c             	pushl  0xc(%ebp)
  8009f0:	6a 58                	push   $0x58
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	ff d0                	call   *%eax
  8009f7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 0c             	pushl  0xc(%ebp)
  800a00:	6a 58                	push   $0x58
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
			break;
  800a0a:	e9 bc 00 00 00       	jmp    800acb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a0f:	83 ec 08             	sub    $0x8,%esp
  800a12:	ff 75 0c             	pushl  0xc(%ebp)
  800a15:	6a 30                	push   $0x30
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	ff d0                	call   *%eax
  800a1c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a1f:	83 ec 08             	sub    $0x8,%esp
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	6a 78                	push   $0x78
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	ff d0                	call   *%eax
  800a2c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a32:	83 c0 04             	add    $0x4,%eax
  800a35:	89 45 14             	mov    %eax,0x14(%ebp)
  800a38:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3b:	83 e8 04             	sub    $0x4,%eax
  800a3e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a4a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a51:	eb 1f                	jmp    800a72 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a53:	83 ec 08             	sub    $0x8,%esp
  800a56:	ff 75 e8             	pushl  -0x18(%ebp)
  800a59:	8d 45 14             	lea    0x14(%ebp),%eax
  800a5c:	50                   	push   %eax
  800a5d:	e8 e7 fb ff ff       	call   800649 <getuint>
  800a62:	83 c4 10             	add    $0x10,%esp
  800a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a68:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a6b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a72:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a76:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a79:	83 ec 04             	sub    $0x4,%esp
  800a7c:	52                   	push   %edx
  800a7d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a80:	50                   	push   %eax
  800a81:	ff 75 f4             	pushl  -0xc(%ebp)
  800a84:	ff 75 f0             	pushl  -0x10(%ebp)
  800a87:	ff 75 0c             	pushl  0xc(%ebp)
  800a8a:	ff 75 08             	pushl  0x8(%ebp)
  800a8d:	e8 00 fb ff ff       	call   800592 <printnum>
  800a92:	83 c4 20             	add    $0x20,%esp
			break;
  800a95:	eb 34                	jmp    800acb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a97:	83 ec 08             	sub    $0x8,%esp
  800a9a:	ff 75 0c             	pushl  0xc(%ebp)
  800a9d:	53                   	push   %ebx
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	ff d0                	call   *%eax
  800aa3:	83 c4 10             	add    $0x10,%esp
			break;
  800aa6:	eb 23                	jmp    800acb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 0c             	pushl  0xc(%ebp)
  800aae:	6a 25                	push   $0x25
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	ff d0                	call   *%eax
  800ab5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ab8:	ff 4d 10             	decl   0x10(%ebp)
  800abb:	eb 03                	jmp    800ac0 <vprintfmt+0x3b1>
  800abd:	ff 4d 10             	decl   0x10(%ebp)
  800ac0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac3:	48                   	dec    %eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	3c 25                	cmp    $0x25,%al
  800ac8:	75 f3                	jne    800abd <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800aca:	90                   	nop
		}
	}
  800acb:	e9 47 fc ff ff       	jmp    800717 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ad0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ad1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ad4:	5b                   	pop    %ebx
  800ad5:	5e                   	pop    %esi
  800ad6:	5d                   	pop    %ebp
  800ad7:	c3                   	ret    

00800ad8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ad8:	55                   	push   %ebp
  800ad9:	89 e5                	mov    %esp,%ebp
  800adb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ade:	8d 45 10             	lea    0x10(%ebp),%eax
  800ae1:	83 c0 04             	add    $0x4,%eax
  800ae4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ae7:	8b 45 10             	mov    0x10(%ebp),%eax
  800aea:	ff 75 f4             	pushl  -0xc(%ebp)
  800aed:	50                   	push   %eax
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	ff 75 08             	pushl  0x8(%ebp)
  800af4:	e8 16 fc ff ff       	call   80070f <vprintfmt>
  800af9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800afc:	90                   	nop
  800afd:	c9                   	leave  
  800afe:	c3                   	ret    

00800aff <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	8b 40 08             	mov    0x8(%eax),%eax
  800b08:	8d 50 01             	lea    0x1(%eax),%edx
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b14:	8b 10                	mov    (%eax),%edx
  800b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b19:	8b 40 04             	mov    0x4(%eax),%eax
  800b1c:	39 c2                	cmp    %eax,%edx
  800b1e:	73 12                	jae    800b32 <sprintputch+0x33>
		*b->buf++ = ch;
  800b20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b23:	8b 00                	mov    (%eax),%eax
  800b25:	8d 48 01             	lea    0x1(%eax),%ecx
  800b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2b:	89 0a                	mov    %ecx,(%edx)
  800b2d:	8b 55 08             	mov    0x8(%ebp),%edx
  800b30:	88 10                	mov    %dl,(%eax)
}
  800b32:	90                   	nop
  800b33:	5d                   	pop    %ebp
  800b34:	c3                   	ret    

00800b35 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b35:	55                   	push   %ebp
  800b36:	89 e5                	mov    %esp,%ebp
  800b38:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b44:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	01 d0                	add    %edx,%eax
  800b4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b56:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b5a:	74 06                	je     800b62 <vsnprintf+0x2d>
  800b5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b60:	7f 07                	jg     800b69 <vsnprintf+0x34>
		return -E_INVAL;
  800b62:	b8 03 00 00 00       	mov    $0x3,%eax
  800b67:	eb 20                	jmp    800b89 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b69:	ff 75 14             	pushl  0x14(%ebp)
  800b6c:	ff 75 10             	pushl  0x10(%ebp)
  800b6f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b72:	50                   	push   %eax
  800b73:	68 ff 0a 80 00       	push   $0x800aff
  800b78:	e8 92 fb ff ff       	call   80070f <vprintfmt>
  800b7d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b80:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b83:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b89:	c9                   	leave  
  800b8a:	c3                   	ret    

00800b8b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b8b:	55                   	push   %ebp
  800b8c:	89 e5                	mov    %esp,%ebp
  800b8e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b91:	8d 45 10             	lea    0x10(%ebp),%eax
  800b94:	83 c0 04             	add    $0x4,%eax
  800b97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9d:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba0:	50                   	push   %eax
  800ba1:	ff 75 0c             	pushl  0xc(%ebp)
  800ba4:	ff 75 08             	pushl  0x8(%ebp)
  800ba7:	e8 89 ff ff ff       	call   800b35 <vsnprintf>
  800bac:	83 c4 10             	add    $0x10,%esp
  800baf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb5:	c9                   	leave  
  800bb6:	c3                   	ret    

00800bb7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bb7:	55                   	push   %ebp
  800bb8:	89 e5                	mov    %esp,%ebp
  800bba:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bbd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc4:	eb 06                	jmp    800bcc <strlen+0x15>
		n++;
  800bc6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800bc9:	ff 45 08             	incl   0x8(%ebp)
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	8a 00                	mov    (%eax),%al
  800bd1:	84 c0                	test   %al,%al
  800bd3:	75 f1                	jne    800bc6 <strlen+0xf>
		n++;
	return n;
  800bd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd8:	c9                   	leave  
  800bd9:	c3                   	ret    

00800bda <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800bda:	55                   	push   %ebp
  800bdb:	89 e5                	mov    %esp,%ebp
  800bdd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800be0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be7:	eb 09                	jmp    800bf2 <strnlen+0x18>
		n++;
  800be9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bec:	ff 45 08             	incl   0x8(%ebp)
  800bef:	ff 4d 0c             	decl   0xc(%ebp)
  800bf2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf6:	74 09                	je     800c01 <strnlen+0x27>
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	8a 00                	mov    (%eax),%al
  800bfd:	84 c0                	test   %al,%al
  800bff:	75 e8                	jne    800be9 <strnlen+0xf>
		n++;
	return n;
  800c01:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c04:	c9                   	leave  
  800c05:	c3                   	ret    

00800c06 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c06:	55                   	push   %ebp
  800c07:	89 e5                	mov    %esp,%ebp
  800c09:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c12:	90                   	nop
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8d 50 01             	lea    0x1(%eax),%edx
  800c19:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c22:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c25:	8a 12                	mov    (%edx),%dl
  800c27:	88 10                	mov    %dl,(%eax)
  800c29:	8a 00                	mov    (%eax),%al
  800c2b:	84 c0                	test   %al,%al
  800c2d:	75 e4                	jne    800c13 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c32:	c9                   	leave  
  800c33:	c3                   	ret    

00800c34 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c34:	55                   	push   %ebp
  800c35:	89 e5                	mov    %esp,%ebp
  800c37:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c47:	eb 1f                	jmp    800c68 <strncpy+0x34>
		*dst++ = *src;
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4c:	8d 50 01             	lea    0x1(%eax),%edx
  800c4f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c52:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c55:	8a 12                	mov    (%edx),%dl
  800c57:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5c:	8a 00                	mov    (%eax),%al
  800c5e:	84 c0                	test   %al,%al
  800c60:	74 03                	je     800c65 <strncpy+0x31>
			src++;
  800c62:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c65:	ff 45 fc             	incl   -0x4(%ebp)
  800c68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c6e:	72 d9                	jb     800c49 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c70:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c73:	c9                   	leave  
  800c74:	c3                   	ret    

00800c75 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c75:	55                   	push   %ebp
  800c76:	89 e5                	mov    %esp,%ebp
  800c78:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c85:	74 30                	je     800cb7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c87:	eb 16                	jmp    800c9f <strlcpy+0x2a>
			*dst++ = *src++;
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8d 50 01             	lea    0x1(%eax),%edx
  800c8f:	89 55 08             	mov    %edx,0x8(%ebp)
  800c92:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c95:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c98:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c9b:	8a 12                	mov    (%edx),%dl
  800c9d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c9f:	ff 4d 10             	decl   0x10(%ebp)
  800ca2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca6:	74 09                	je     800cb1 <strlcpy+0x3c>
  800ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cab:	8a 00                	mov    (%eax),%al
  800cad:	84 c0                	test   %al,%al
  800caf:	75 d8                	jne    800c89 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cb7:	8b 55 08             	mov    0x8(%ebp),%edx
  800cba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cbd:	29 c2                	sub    %eax,%edx
  800cbf:	89 d0                	mov    %edx,%eax
}
  800cc1:	c9                   	leave  
  800cc2:	c3                   	ret    

00800cc3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cc3:	55                   	push   %ebp
  800cc4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800cc6:	eb 06                	jmp    800cce <strcmp+0xb>
		p++, q++;
  800cc8:	ff 45 08             	incl   0x8(%ebp)
  800ccb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	84 c0                	test   %al,%al
  800cd5:	74 0e                	je     800ce5 <strcmp+0x22>
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 10                	mov    (%eax),%dl
  800cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	38 c2                	cmp    %al,%dl
  800ce3:	74 e3                	je     800cc8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f b6 d0             	movzbl %al,%edx
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	0f b6 c0             	movzbl %al,%eax
  800cf5:	29 c2                	sub    %eax,%edx
  800cf7:	89 d0                	mov    %edx,%eax
}
  800cf9:	5d                   	pop    %ebp
  800cfa:	c3                   	ret    

00800cfb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cfe:	eb 09                	jmp    800d09 <strncmp+0xe>
		n--, p++, q++;
  800d00:	ff 4d 10             	decl   0x10(%ebp)
  800d03:	ff 45 08             	incl   0x8(%ebp)
  800d06:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0d:	74 17                	je     800d26 <strncmp+0x2b>
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	84 c0                	test   %al,%al
  800d16:	74 0e                	je     800d26 <strncmp+0x2b>
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 10                	mov    (%eax),%dl
  800d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	38 c2                	cmp    %al,%dl
  800d24:	74 da                	je     800d00 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2a:	75 07                	jne    800d33 <strncmp+0x38>
		return 0;
  800d2c:	b8 00 00 00 00       	mov    $0x0,%eax
  800d31:	eb 14                	jmp    800d47 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	0f b6 d0             	movzbl %al,%edx
  800d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	0f b6 c0             	movzbl %al,%eax
  800d43:	29 c2                	sub    %eax,%edx
  800d45:	89 d0                	mov    %edx,%eax
}
  800d47:	5d                   	pop    %ebp
  800d48:	c3                   	ret    

00800d49 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d49:	55                   	push   %ebp
  800d4a:	89 e5                	mov    %esp,%ebp
  800d4c:	83 ec 04             	sub    $0x4,%esp
  800d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d52:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d55:	eb 12                	jmp    800d69 <strchr+0x20>
		if (*s == c)
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d5f:	75 05                	jne    800d66 <strchr+0x1d>
			return (char *) s;
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	eb 11                	jmp    800d77 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d66:	ff 45 08             	incl   0x8(%ebp)
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	84 c0                	test   %al,%al
  800d70:	75 e5                	jne    800d57 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d77:	c9                   	leave  
  800d78:	c3                   	ret    

00800d79 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
  800d7c:	83 ec 04             	sub    $0x4,%esp
  800d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d82:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d85:	eb 0d                	jmp    800d94 <strfind+0x1b>
		if (*s == c)
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d8f:	74 0e                	je     800d9f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d91:	ff 45 08             	incl   0x8(%ebp)
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	8a 00                	mov    (%eax),%al
  800d99:	84 c0                	test   %al,%al
  800d9b:	75 ea                	jne    800d87 <strfind+0xe>
  800d9d:	eb 01                	jmp    800da0 <strfind+0x27>
		if (*s == c)
			break;
  800d9f:	90                   	nop
	return (char *) s;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da3:	c9                   	leave  
  800da4:	c3                   	ret    

00800da5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800da5:	55                   	push   %ebp
  800da6:	89 e5                	mov    %esp,%ebp
  800da8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800db1:	8b 45 10             	mov    0x10(%ebp),%eax
  800db4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800db7:	eb 0e                	jmp    800dc7 <memset+0x22>
		*p++ = c;
  800db9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbc:	8d 50 01             	lea    0x1(%eax),%edx
  800dbf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800dc7:	ff 4d f8             	decl   -0x8(%ebp)
  800dca:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800dce:	79 e9                	jns    800db9 <memset+0x14>
		*p++ = c;

	return v;
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd3:	c9                   	leave  
  800dd4:	c3                   	ret    

00800dd5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800dd5:	55                   	push   %ebp
  800dd6:	89 e5                	mov    %esp,%ebp
  800dd8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dde:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800de7:	eb 16                	jmp    800dff <memcpy+0x2a>
		*d++ = *s++;
  800de9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dec:	8d 50 01             	lea    0x1(%eax),%edx
  800def:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dfb:	8a 12                	mov    (%edx),%dl
  800dfd:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dff:	8b 45 10             	mov    0x10(%ebp),%eax
  800e02:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e05:	89 55 10             	mov    %edx,0x10(%ebp)
  800e08:	85 c0                	test   %eax,%eax
  800e0a:	75 dd                	jne    800de9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0f:	c9                   	leave  
  800e10:	c3                   	ret    

00800e11 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e11:	55                   	push   %ebp
  800e12:	89 e5                	mov    %esp,%ebp
  800e14:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800e17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e26:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e29:	73 50                	jae    800e7b <memmove+0x6a>
  800e2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e31:	01 d0                	add    %edx,%eax
  800e33:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e36:	76 43                	jbe    800e7b <memmove+0x6a>
		s += n;
  800e38:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e41:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e44:	eb 10                	jmp    800e56 <memmove+0x45>
			*--d = *--s;
  800e46:	ff 4d f8             	decl   -0x8(%ebp)
  800e49:	ff 4d fc             	decl   -0x4(%ebp)
  800e4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4f:	8a 10                	mov    (%eax),%dl
  800e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e54:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e56:	8b 45 10             	mov    0x10(%ebp),%eax
  800e59:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5f:	85 c0                	test   %eax,%eax
  800e61:	75 e3                	jne    800e46 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e63:	eb 23                	jmp    800e88 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e68:	8d 50 01             	lea    0x1(%eax),%edx
  800e6b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e71:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e74:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e77:	8a 12                	mov    (%edx),%dl
  800e79:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e81:	89 55 10             	mov    %edx,0x10(%ebp)
  800e84:	85 c0                	test   %eax,%eax
  800e86:	75 dd                	jne    800e65 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e8b:	c9                   	leave  
  800e8c:	c3                   	ret    

00800e8d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e8d:	55                   	push   %ebp
  800e8e:	89 e5                	mov    %esp,%ebp
  800e90:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e9f:	eb 2a                	jmp    800ecb <memcmp+0x3e>
		if (*s1 != *s2)
  800ea1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea4:	8a 10                	mov    (%eax),%dl
  800ea6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea9:	8a 00                	mov    (%eax),%al
  800eab:	38 c2                	cmp    %al,%dl
  800ead:	74 16                	je     800ec5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800eaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f b6 d0             	movzbl %al,%edx
  800eb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	0f b6 c0             	movzbl %al,%eax
  800ebf:	29 c2                	sub    %eax,%edx
  800ec1:	89 d0                	mov    %edx,%eax
  800ec3:	eb 18                	jmp    800edd <memcmp+0x50>
		s1++, s2++;
  800ec5:	ff 45 fc             	incl   -0x4(%ebp)
  800ec8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ecb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ece:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ed1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed4:	85 c0                	test   %eax,%eax
  800ed6:	75 c9                	jne    800ea1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ed8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800edd:	c9                   	leave  
  800ede:	c3                   	ret    

00800edf <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800edf:	55                   	push   %ebp
  800ee0:	89 e5                	mov    %esp,%ebp
  800ee2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ee5:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee8:	8b 45 10             	mov    0x10(%ebp),%eax
  800eeb:	01 d0                	add    %edx,%eax
  800eed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ef0:	eb 15                	jmp    800f07 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	0f b6 d0             	movzbl %al,%edx
  800efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efd:	0f b6 c0             	movzbl %al,%eax
  800f00:	39 c2                	cmp    %eax,%edx
  800f02:	74 0d                	je     800f11 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f04:	ff 45 08             	incl   0x8(%ebp)
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f0d:	72 e3                	jb     800ef2 <memfind+0x13>
  800f0f:	eb 01                	jmp    800f12 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f11:	90                   	nop
	return (void *) s;
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f15:	c9                   	leave  
  800f16:	c3                   	ret    

00800f17 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f17:	55                   	push   %ebp
  800f18:	89 e5                	mov    %esp,%ebp
  800f1a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f1d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f24:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f2b:	eb 03                	jmp    800f30 <strtol+0x19>
		s++;
  800f2d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	3c 20                	cmp    $0x20,%al
  800f37:	74 f4                	je     800f2d <strtol+0x16>
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	3c 09                	cmp    $0x9,%al
  800f40:	74 eb                	je     800f2d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8a 00                	mov    (%eax),%al
  800f47:	3c 2b                	cmp    $0x2b,%al
  800f49:	75 05                	jne    800f50 <strtol+0x39>
		s++;
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	eb 13                	jmp    800f63 <strtol+0x4c>
	else if (*s == '-')
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	3c 2d                	cmp    $0x2d,%al
  800f57:	75 0a                	jne    800f63 <strtol+0x4c>
		s++, neg = 1;
  800f59:	ff 45 08             	incl   0x8(%ebp)
  800f5c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f67:	74 06                	je     800f6f <strtol+0x58>
  800f69:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f6d:	75 20                	jne    800f8f <strtol+0x78>
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	3c 30                	cmp    $0x30,%al
  800f76:	75 17                	jne    800f8f <strtol+0x78>
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	40                   	inc    %eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	3c 78                	cmp    $0x78,%al
  800f80:	75 0d                	jne    800f8f <strtol+0x78>
		s += 2, base = 16;
  800f82:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f86:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f8d:	eb 28                	jmp    800fb7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f93:	75 15                	jne    800faa <strtol+0x93>
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	3c 30                	cmp    $0x30,%al
  800f9c:	75 0c                	jne    800faa <strtol+0x93>
		s++, base = 8;
  800f9e:	ff 45 08             	incl   0x8(%ebp)
  800fa1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fa8:	eb 0d                	jmp    800fb7 <strtol+0xa0>
	else if (base == 0)
  800faa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fae:	75 07                	jne    800fb7 <strtol+0xa0>
		base = 10;
  800fb0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 2f                	cmp    $0x2f,%al
  800fbe:	7e 19                	jle    800fd9 <strtol+0xc2>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 39                	cmp    $0x39,%al
  800fc7:	7f 10                	jg     800fd9 <strtol+0xc2>
			dig = *s - '0';
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	0f be c0             	movsbl %al,%eax
  800fd1:	83 e8 30             	sub    $0x30,%eax
  800fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fd7:	eb 42                	jmp    80101b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	8a 00                	mov    (%eax),%al
  800fde:	3c 60                	cmp    $0x60,%al
  800fe0:	7e 19                	jle    800ffb <strtol+0xe4>
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	3c 7a                	cmp    $0x7a,%al
  800fe9:	7f 10                	jg     800ffb <strtol+0xe4>
			dig = *s - 'a' + 10;
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	0f be c0             	movsbl %al,%eax
  800ff3:	83 e8 57             	sub    $0x57,%eax
  800ff6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ff9:	eb 20                	jmp    80101b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	3c 40                	cmp    $0x40,%al
  801002:	7e 39                	jle    80103d <strtol+0x126>
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	3c 5a                	cmp    $0x5a,%al
  80100b:	7f 30                	jg     80103d <strtol+0x126>
			dig = *s - 'A' + 10;
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	0f be c0             	movsbl %al,%eax
  801015:	83 e8 37             	sub    $0x37,%eax
  801018:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80101b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80101e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801021:	7d 19                	jge    80103c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801023:	ff 45 08             	incl   0x8(%ebp)
  801026:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801029:	0f af 45 10          	imul   0x10(%ebp),%eax
  80102d:	89 c2                	mov    %eax,%edx
  80102f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801032:	01 d0                	add    %edx,%eax
  801034:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801037:	e9 7b ff ff ff       	jmp    800fb7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80103c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80103d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801041:	74 08                	je     80104b <strtol+0x134>
		*endptr = (char *) s;
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	8b 55 08             	mov    0x8(%ebp),%edx
  801049:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80104b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80104f:	74 07                	je     801058 <strtol+0x141>
  801051:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801054:	f7 d8                	neg    %eax
  801056:	eb 03                	jmp    80105b <strtol+0x144>
  801058:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80105b:	c9                   	leave  
  80105c:	c3                   	ret    

0080105d <ltostr>:

void
ltostr(long value, char *str)
{
  80105d:	55                   	push   %ebp
  80105e:	89 e5                	mov    %esp,%ebp
  801060:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801063:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80106a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801071:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801075:	79 13                	jns    80108a <ltostr+0x2d>
	{
		neg = 1;
  801077:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801084:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801087:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801092:	99                   	cltd   
  801093:	f7 f9                	idiv   %ecx
  801095:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801098:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109b:	8d 50 01             	lea    0x1(%eax),%edx
  80109e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a1:	89 c2                	mov    %eax,%edx
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	01 d0                	add    %edx,%eax
  8010a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010ab:	83 c2 30             	add    $0x30,%edx
  8010ae:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010b3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010b8:	f7 e9                	imul   %ecx
  8010ba:	c1 fa 02             	sar    $0x2,%edx
  8010bd:	89 c8                	mov    %ecx,%eax
  8010bf:	c1 f8 1f             	sar    $0x1f,%eax
  8010c2:	29 c2                	sub    %eax,%edx
  8010c4:	89 d0                	mov    %edx,%eax
  8010c6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8010c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010cc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010d1:	f7 e9                	imul   %ecx
  8010d3:	c1 fa 02             	sar    $0x2,%edx
  8010d6:	89 c8                	mov    %ecx,%eax
  8010d8:	c1 f8 1f             	sar    $0x1f,%eax
  8010db:	29 c2                	sub    %eax,%edx
  8010dd:	89 d0                	mov    %edx,%eax
  8010df:	c1 e0 02             	shl    $0x2,%eax
  8010e2:	01 d0                	add    %edx,%eax
  8010e4:	01 c0                	add    %eax,%eax
  8010e6:	29 c1                	sub    %eax,%ecx
  8010e8:	89 ca                	mov    %ecx,%edx
  8010ea:	85 d2                	test   %edx,%edx
  8010ec:	75 9c                	jne    80108a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f8:	48                   	dec    %eax
  8010f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801100:	74 3d                	je     80113f <ltostr+0xe2>
		start = 1 ;
  801102:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801109:	eb 34                	jmp    80113f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80110b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80110e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801111:	01 d0                	add    %edx,%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801118:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111e:	01 c2                	add    %eax,%edx
  801120:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	01 c8                	add    %ecx,%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80112c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80112f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801132:	01 c2                	add    %eax,%edx
  801134:	8a 45 eb             	mov    -0x15(%ebp),%al
  801137:	88 02                	mov    %al,(%edx)
		start++ ;
  801139:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80113c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80113f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801142:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801145:	7c c4                	jl     80110b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801147:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80114a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114d:	01 d0                	add    %edx,%eax
  80114f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801152:	90                   	nop
  801153:	c9                   	leave  
  801154:	c3                   	ret    

00801155 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801155:	55                   	push   %ebp
  801156:	89 e5                	mov    %esp,%ebp
  801158:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80115b:	ff 75 08             	pushl  0x8(%ebp)
  80115e:	e8 54 fa ff ff       	call   800bb7 <strlen>
  801163:	83 c4 04             	add    $0x4,%esp
  801166:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801169:	ff 75 0c             	pushl  0xc(%ebp)
  80116c:	e8 46 fa ff ff       	call   800bb7 <strlen>
  801171:	83 c4 04             	add    $0x4,%esp
  801174:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801177:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80117e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801185:	eb 17                	jmp    80119e <strcconcat+0x49>
		final[s] = str1[s] ;
  801187:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80118a:	8b 45 10             	mov    0x10(%ebp),%eax
  80118d:	01 c2                	add    %eax,%edx
  80118f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	01 c8                	add    %ecx,%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80119b:	ff 45 fc             	incl   -0x4(%ebp)
  80119e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011a4:	7c e1                	jl     801187 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011ad:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011b4:	eb 1f                	jmp    8011d5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b9:	8d 50 01             	lea    0x1(%eax),%edx
  8011bc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011bf:	89 c2                	mov    %eax,%edx
  8011c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c4:	01 c2                	add    %eax,%edx
  8011c6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8011c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cc:	01 c8                	add    %ecx,%eax
  8011ce:	8a 00                	mov    (%eax),%al
  8011d0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8011d2:	ff 45 f8             	incl   -0x8(%ebp)
  8011d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011db:	7c d9                	jl     8011b6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e3:	01 d0                	add    %edx,%eax
  8011e5:	c6 00 00             	movb   $0x0,(%eax)
}
  8011e8:	90                   	nop
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fa:	8b 00                	mov    (%eax),%eax
  8011fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801203:	8b 45 10             	mov    0x10(%ebp),%eax
  801206:	01 d0                	add    %edx,%eax
  801208:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80120e:	eb 0c                	jmp    80121c <strsplit+0x31>
			*string++ = 0;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8d 50 01             	lea    0x1(%eax),%edx
  801216:	89 55 08             	mov    %edx,0x8(%ebp)
  801219:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	84 c0                	test   %al,%al
  801223:	74 18                	je     80123d <strsplit+0x52>
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	0f be c0             	movsbl %al,%eax
  80122d:	50                   	push   %eax
  80122e:	ff 75 0c             	pushl  0xc(%ebp)
  801231:	e8 13 fb ff ff       	call   800d49 <strchr>
  801236:	83 c4 08             	add    $0x8,%esp
  801239:	85 c0                	test   %eax,%eax
  80123b:	75 d3                	jne    801210 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	84 c0                	test   %al,%al
  801244:	74 5a                	je     8012a0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801246:	8b 45 14             	mov    0x14(%ebp),%eax
  801249:	8b 00                	mov    (%eax),%eax
  80124b:	83 f8 0f             	cmp    $0xf,%eax
  80124e:	75 07                	jne    801257 <strsplit+0x6c>
		{
			return 0;
  801250:	b8 00 00 00 00       	mov    $0x0,%eax
  801255:	eb 66                	jmp    8012bd <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801257:	8b 45 14             	mov    0x14(%ebp),%eax
  80125a:	8b 00                	mov    (%eax),%eax
  80125c:	8d 48 01             	lea    0x1(%eax),%ecx
  80125f:	8b 55 14             	mov    0x14(%ebp),%edx
  801262:	89 0a                	mov    %ecx,(%edx)
  801264:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126b:	8b 45 10             	mov    0x10(%ebp),%eax
  80126e:	01 c2                	add    %eax,%edx
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
  801273:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801275:	eb 03                	jmp    80127a <strsplit+0x8f>
			string++;
  801277:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	84 c0                	test   %al,%al
  801281:	74 8b                	je     80120e <strsplit+0x23>
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	0f be c0             	movsbl %al,%eax
  80128b:	50                   	push   %eax
  80128c:	ff 75 0c             	pushl  0xc(%ebp)
  80128f:	e8 b5 fa ff ff       	call   800d49 <strchr>
  801294:	83 c4 08             	add    $0x8,%esp
  801297:	85 c0                	test   %eax,%eax
  801299:	74 dc                	je     801277 <strsplit+0x8c>
			string++;
	}
  80129b:	e9 6e ff ff ff       	jmp    80120e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012a0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a4:	8b 00                	mov    (%eax),%eax
  8012a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012b8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
  8012c2:	57                   	push   %edi
  8012c3:	56                   	push   %esi
  8012c4:	53                   	push   %ebx
  8012c5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ce:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012d1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012d4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012d7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012da:	cd 30                	int    $0x30
  8012dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012df:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012e2:	83 c4 10             	add    $0x10,%esp
  8012e5:	5b                   	pop    %ebx
  8012e6:	5e                   	pop    %esi
  8012e7:	5f                   	pop    %edi
  8012e8:	5d                   	pop    %ebp
  8012e9:	c3                   	ret    

008012ea <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012ea:	55                   	push   %ebp
  8012eb:	89 e5                	mov    %esp,%ebp
  8012ed:	83 ec 04             	sub    $0x4,%esp
  8012f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012f6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	52                   	push   %edx
  801302:	ff 75 0c             	pushl  0xc(%ebp)
  801305:	50                   	push   %eax
  801306:	6a 00                	push   $0x0
  801308:	e8 b2 ff ff ff       	call   8012bf <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	90                   	nop
  801311:	c9                   	leave  
  801312:	c3                   	ret    

00801313 <sys_cgetc>:

int
sys_cgetc(void)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 01                	push   $0x1
  801322:	e8 98 ff ff ff       	call   8012bf <syscall>
  801327:	83 c4 18             	add    $0x18,%esp
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	50                   	push   %eax
  80133b:	6a 05                	push   $0x5
  80133d:	e8 7d ff ff ff       	call   8012bf <syscall>
  801342:	83 c4 18             	add    $0x18,%esp
}
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 02                	push   $0x2
  801356:	e8 64 ff ff ff       	call   8012bf <syscall>
  80135b:	83 c4 18             	add    $0x18,%esp
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 03                	push   $0x3
  80136f:	e8 4b ff ff ff       	call   8012bf <syscall>
  801374:	83 c4 18             	add    $0x18,%esp
}
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 04                	push   $0x4
  801388:	e8 32 ff ff ff       	call   8012bf <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <sys_env_exit>:


void sys_env_exit(void)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 06                	push   $0x6
  8013a1:	e8 19 ff ff ff       	call   8012bf <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	90                   	nop
  8013aa:	c9                   	leave  
  8013ab:	c3                   	ret    

008013ac <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8013ac:	55                   	push   %ebp
  8013ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8013af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	52                   	push   %edx
  8013bc:	50                   	push   %eax
  8013bd:	6a 07                	push   $0x7
  8013bf:	e8 fb fe ff ff       	call   8012bf <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
  8013cc:	56                   	push   %esi
  8013cd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013ce:	8b 75 18             	mov    0x18(%ebp),%esi
  8013d1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	56                   	push   %esi
  8013de:	53                   	push   %ebx
  8013df:	51                   	push   %ecx
  8013e0:	52                   	push   %edx
  8013e1:	50                   	push   %eax
  8013e2:	6a 08                	push   $0x8
  8013e4:	e8 d6 fe ff ff       	call   8012bf <syscall>
  8013e9:	83 c4 18             	add    $0x18,%esp
}
  8013ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013ef:	5b                   	pop    %ebx
  8013f0:	5e                   	pop    %esi
  8013f1:	5d                   	pop    %ebp
  8013f2:	c3                   	ret    

008013f3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	52                   	push   %edx
  801403:	50                   	push   %eax
  801404:	6a 09                	push   $0x9
  801406:	e8 b4 fe ff ff       	call   8012bf <syscall>
  80140b:	83 c4 18             	add    $0x18,%esp
}
  80140e:	c9                   	leave  
  80140f:	c3                   	ret    

00801410 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801410:	55                   	push   %ebp
  801411:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	ff 75 0c             	pushl  0xc(%ebp)
  80141c:	ff 75 08             	pushl  0x8(%ebp)
  80141f:	6a 0a                	push   $0xa
  801421:	e8 99 fe ff ff       	call   8012bf <syscall>
  801426:	83 c4 18             	add    $0x18,%esp
}
  801429:	c9                   	leave  
  80142a:	c3                   	ret    

0080142b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80142b:	55                   	push   %ebp
  80142c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 0b                	push   $0xb
  80143a:	e8 80 fe ff ff       	call   8012bf <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
}
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 0c                	push   $0xc
  801453:	e8 67 fe ff ff       	call   8012bf <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 0d                	push   $0xd
  80146c:	e8 4e fe ff ff       	call   8012bf <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	ff 75 0c             	pushl  0xc(%ebp)
  801482:	ff 75 08             	pushl  0x8(%ebp)
  801485:	6a 11                	push   $0x11
  801487:	e8 33 fe ff ff       	call   8012bf <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
	return;
  80148f:	90                   	nop
}
  801490:	c9                   	leave  
  801491:	c3                   	ret    

00801492 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801492:	55                   	push   %ebp
  801493:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	ff 75 0c             	pushl  0xc(%ebp)
  80149e:	ff 75 08             	pushl  0x8(%ebp)
  8014a1:	6a 12                	push   $0x12
  8014a3:	e8 17 fe ff ff       	call   8012bf <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ab:	90                   	nop
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 0e                	push   $0xe
  8014bd:	e8 fd fd ff ff       	call   8012bf <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
}
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	ff 75 08             	pushl  0x8(%ebp)
  8014d5:	6a 0f                	push   $0xf
  8014d7:	e8 e3 fd ff ff       	call   8012bf <syscall>
  8014dc:	83 c4 18             	add    $0x18,%esp
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 10                	push   $0x10
  8014f0:	e8 ca fd ff ff       	call   8012bf <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	90                   	nop
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 14                	push   $0x14
  80150a:	e8 b0 fd ff ff       	call   8012bf <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	90                   	nop
  801513:	c9                   	leave  
  801514:	c3                   	ret    

00801515 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801515:	55                   	push   %ebp
  801516:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 15                	push   $0x15
  801524:	e8 96 fd ff ff       	call   8012bf <syscall>
  801529:	83 c4 18             	add    $0x18,%esp
}
  80152c:	90                   	nop
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <sys_cputc>:


void
sys_cputc(const char c)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
  801532:	83 ec 04             	sub    $0x4,%esp
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80153b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	50                   	push   %eax
  801548:	6a 16                	push   $0x16
  80154a:	e8 70 fd ff ff       	call   8012bf <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
}
  801552:	90                   	nop
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 17                	push   $0x17
  801564:	e8 56 fd ff ff       	call   8012bf <syscall>
  801569:	83 c4 18             	add    $0x18,%esp
}
  80156c:	90                   	nop
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801572:	8b 45 08             	mov    0x8(%ebp),%eax
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	ff 75 0c             	pushl  0xc(%ebp)
  80157e:	50                   	push   %eax
  80157f:	6a 18                	push   $0x18
  801581:	e8 39 fd ff ff       	call   8012bf <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
}
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80158e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	52                   	push   %edx
  80159b:	50                   	push   %eax
  80159c:	6a 1b                	push   $0x1b
  80159e:	e8 1c fd ff ff       	call   8012bf <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	52                   	push   %edx
  8015b8:	50                   	push   %eax
  8015b9:	6a 19                	push   $0x19
  8015bb:	e8 ff fc ff ff       	call   8012bf <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	90                   	nop
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	52                   	push   %edx
  8015d6:	50                   	push   %eax
  8015d7:	6a 1a                	push   $0x1a
  8015d9:	e8 e1 fc ff ff       	call   8012bf <syscall>
  8015de:	83 c4 18             	add    $0x18,%esp
}
  8015e1:	90                   	nop
  8015e2:	c9                   	leave  
  8015e3:	c3                   	ret    

008015e4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
  8015e7:	83 ec 04             	sub    $0x4,%esp
  8015ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015f0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015f3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	6a 00                	push   $0x0
  8015fc:	51                   	push   %ecx
  8015fd:	52                   	push   %edx
  8015fe:	ff 75 0c             	pushl  0xc(%ebp)
  801601:	50                   	push   %eax
  801602:	6a 1c                	push   $0x1c
  801604:	e8 b6 fc ff ff       	call   8012bf <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 1d                	push   $0x1d
  801621:	e8 99 fc ff ff       	call   8012bf <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80162e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801631:	8b 55 0c             	mov    0xc(%ebp),%edx
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	51                   	push   %ecx
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	6a 1e                	push   $0x1e
  801640:	e8 7a fc ff ff       	call   8012bf <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80164d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	52                   	push   %edx
  80165a:	50                   	push   %eax
  80165b:	6a 1f                	push   $0x1f
  80165d:	e8 5d fc ff ff       	call   8012bf <syscall>
  801662:	83 c4 18             	add    $0x18,%esp
}
  801665:	c9                   	leave  
  801666:	c3                   	ret    

00801667 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801667:	55                   	push   %ebp
  801668:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 20                	push   $0x20
  801676:	e8 44 fc ff ff       	call   8012bf <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	ff 75 10             	pushl  0x10(%ebp)
  80168d:	ff 75 0c             	pushl  0xc(%ebp)
  801690:	50                   	push   %eax
  801691:	6a 21                	push   $0x21
  801693:	e8 27 fc ff ff       	call   8012bf <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	50                   	push   %eax
  8016ac:	6a 22                	push   $0x22
  8016ae:	e8 0c fc ff ff       	call   8012bf <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
}
  8016b6:	90                   	nop
  8016b7:	c9                   	leave  
  8016b8:	c3                   	ret    

008016b9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	50                   	push   %eax
  8016c8:	6a 23                	push   $0x23
  8016ca:	e8 f0 fb ff ff       	call   8012bf <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
}
  8016d2:	90                   	nop
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016db:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016de:	8d 50 04             	lea    0x4(%eax),%edx
  8016e1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	52                   	push   %edx
  8016eb:	50                   	push   %eax
  8016ec:	6a 24                	push   $0x24
  8016ee:	e8 cc fb ff ff       	call   8012bf <syscall>
  8016f3:	83 c4 18             	add    $0x18,%esp
	return result;
  8016f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ff:	89 01                	mov    %eax,(%ecx)
  801701:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	c9                   	leave  
  801708:	c2 04 00             	ret    $0x4

0080170b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	ff 75 10             	pushl  0x10(%ebp)
  801715:	ff 75 0c             	pushl  0xc(%ebp)
  801718:	ff 75 08             	pushl  0x8(%ebp)
  80171b:	6a 13                	push   $0x13
  80171d:	e8 9d fb ff ff       	call   8012bf <syscall>
  801722:	83 c4 18             	add    $0x18,%esp
	return ;
  801725:	90                   	nop
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_rcr2>:
uint32 sys_rcr2()
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 25                	push   $0x25
  801737:	e8 83 fb ff ff       	call   8012bf <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
  801744:	83 ec 04             	sub    $0x4,%esp
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80174d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	50                   	push   %eax
  80175a:	6a 26                	push   $0x26
  80175c:	e8 5e fb ff ff       	call   8012bf <syscall>
  801761:	83 c4 18             	add    $0x18,%esp
	return ;
  801764:	90                   	nop
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    

00801767 <rsttst>:
void rsttst()
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 28                	push   $0x28
  801776:	e8 44 fb ff ff       	call   8012bf <syscall>
  80177b:	83 c4 18             	add    $0x18,%esp
	return ;
  80177e:	90                   	nop
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
  801784:	83 ec 04             	sub    $0x4,%esp
  801787:	8b 45 14             	mov    0x14(%ebp),%eax
  80178a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80178d:	8b 55 18             	mov    0x18(%ebp),%edx
  801790:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801794:	52                   	push   %edx
  801795:	50                   	push   %eax
  801796:	ff 75 10             	pushl  0x10(%ebp)
  801799:	ff 75 0c             	pushl  0xc(%ebp)
  80179c:	ff 75 08             	pushl  0x8(%ebp)
  80179f:	6a 27                	push   $0x27
  8017a1:	e8 19 fb ff ff       	call   8012bf <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a9:	90                   	nop
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <chktst>:
void chktst(uint32 n)
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	ff 75 08             	pushl  0x8(%ebp)
  8017ba:	6a 29                	push   $0x29
  8017bc:	e8 fe fa ff ff       	call   8012bf <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c4:	90                   	nop
}
  8017c5:	c9                   	leave  
  8017c6:	c3                   	ret    

008017c7 <inctst>:

void inctst()
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 2a                	push   $0x2a
  8017d6:	e8 e4 fa ff ff       	call   8012bf <syscall>
  8017db:	83 c4 18             	add    $0x18,%esp
	return ;
  8017de:	90                   	nop
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <gettst>:
uint32 gettst()
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 2b                	push   $0x2b
  8017f0:	e8 ca fa ff ff       	call   8012bf <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
}
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
  8017fd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 2c                	push   $0x2c
  80180c:	e8 ae fa ff ff       	call   8012bf <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
  801814:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801817:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80181b:	75 07                	jne    801824 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80181d:	b8 01 00 00 00       	mov    $0x1,%eax
  801822:	eb 05                	jmp    801829 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801824:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
  80182e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 2c                	push   $0x2c
  80183d:	e8 7d fa ff ff       	call   8012bf <syscall>
  801842:	83 c4 18             	add    $0x18,%esp
  801845:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801848:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80184c:	75 07                	jne    801855 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80184e:	b8 01 00 00 00       	mov    $0x1,%eax
  801853:	eb 05                	jmp    80185a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801855:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
  80185f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 2c                	push   $0x2c
  80186e:	e8 4c fa ff ff       	call   8012bf <syscall>
  801873:	83 c4 18             	add    $0x18,%esp
  801876:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801879:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80187d:	75 07                	jne    801886 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80187f:	b8 01 00 00 00       	mov    $0x1,%eax
  801884:	eb 05                	jmp    80188b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801886:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 2c                	push   $0x2c
  80189f:	e8 1b fa ff ff       	call   8012bf <syscall>
  8018a4:	83 c4 18             	add    $0x18,%esp
  8018a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8018aa:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8018ae:	75 07                	jne    8018b7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8018b0:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b5:	eb 05                	jmp    8018bc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	ff 75 08             	pushl  0x8(%ebp)
  8018cc:	6a 2d                	push   $0x2d
  8018ce:	e8 ec f9 ff ff       	call   8012bf <syscall>
  8018d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d6:	90                   	nop
}
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
  8018dc:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018df:	8b 55 08             	mov    0x8(%ebp),%edx
  8018e2:	89 d0                	mov    %edx,%eax
  8018e4:	c1 e0 02             	shl    $0x2,%eax
  8018e7:	01 d0                	add    %edx,%eax
  8018e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f0:	01 d0                	add    %edx,%eax
  8018f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f9:	01 d0                	add    %edx,%eax
  8018fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801902:	01 d0                	add    %edx,%eax
  801904:	c1 e0 04             	shl    $0x4,%eax
  801907:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80190a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801911:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801914:	83 ec 0c             	sub    $0xc,%esp
  801917:	50                   	push   %eax
  801918:	e8 b8 fd ff ff       	call   8016d5 <sys_get_virtual_time>
  80191d:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801920:	eb 41                	jmp    801963 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801922:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801925:	83 ec 0c             	sub    $0xc,%esp
  801928:	50                   	push   %eax
  801929:	e8 a7 fd ff ff       	call   8016d5 <sys_get_virtual_time>
  80192e:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801931:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801934:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801937:	29 c2                	sub    %eax,%edx
  801939:	89 d0                	mov    %edx,%eax
  80193b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80193e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801941:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801944:	89 d1                	mov    %edx,%ecx
  801946:	29 c1                	sub    %eax,%ecx
  801948:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80194b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80194e:	39 c2                	cmp    %eax,%edx
  801950:	0f 97 c0             	seta   %al
  801953:	0f b6 c0             	movzbl %al,%eax
  801956:	29 c1                	sub    %eax,%ecx
  801958:	89 c8                	mov    %ecx,%eax
  80195a:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80195d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801960:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801963:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801966:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801969:	72 b7                	jb     801922 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  80196b:	90                   	nop
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
  801971:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801974:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80197b:	eb 03                	jmp    801980 <busy_wait+0x12>
  80197d:	ff 45 fc             	incl   -0x4(%ebp)
  801980:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801983:	3b 45 08             	cmp    0x8(%ebp),%eax
  801986:	72 f5                	jb     80197d <busy_wait+0xf>
	return i;
  801988:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    
  80198d:	66 90                	xchg   %ax,%ax
  80198f:	90                   	nop

00801990 <__udivdi3>:
  801990:	55                   	push   %ebp
  801991:	57                   	push   %edi
  801992:	56                   	push   %esi
  801993:	53                   	push   %ebx
  801994:	83 ec 1c             	sub    $0x1c,%esp
  801997:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80199b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80199f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019a3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019a7:	89 ca                	mov    %ecx,%edx
  8019a9:	89 f8                	mov    %edi,%eax
  8019ab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019af:	85 f6                	test   %esi,%esi
  8019b1:	75 2d                	jne    8019e0 <__udivdi3+0x50>
  8019b3:	39 cf                	cmp    %ecx,%edi
  8019b5:	77 65                	ja     801a1c <__udivdi3+0x8c>
  8019b7:	89 fd                	mov    %edi,%ebp
  8019b9:	85 ff                	test   %edi,%edi
  8019bb:	75 0b                	jne    8019c8 <__udivdi3+0x38>
  8019bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8019c2:	31 d2                	xor    %edx,%edx
  8019c4:	f7 f7                	div    %edi
  8019c6:	89 c5                	mov    %eax,%ebp
  8019c8:	31 d2                	xor    %edx,%edx
  8019ca:	89 c8                	mov    %ecx,%eax
  8019cc:	f7 f5                	div    %ebp
  8019ce:	89 c1                	mov    %eax,%ecx
  8019d0:	89 d8                	mov    %ebx,%eax
  8019d2:	f7 f5                	div    %ebp
  8019d4:	89 cf                	mov    %ecx,%edi
  8019d6:	89 fa                	mov    %edi,%edx
  8019d8:	83 c4 1c             	add    $0x1c,%esp
  8019db:	5b                   	pop    %ebx
  8019dc:	5e                   	pop    %esi
  8019dd:	5f                   	pop    %edi
  8019de:	5d                   	pop    %ebp
  8019df:	c3                   	ret    
  8019e0:	39 ce                	cmp    %ecx,%esi
  8019e2:	77 28                	ja     801a0c <__udivdi3+0x7c>
  8019e4:	0f bd fe             	bsr    %esi,%edi
  8019e7:	83 f7 1f             	xor    $0x1f,%edi
  8019ea:	75 40                	jne    801a2c <__udivdi3+0x9c>
  8019ec:	39 ce                	cmp    %ecx,%esi
  8019ee:	72 0a                	jb     8019fa <__udivdi3+0x6a>
  8019f0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019f4:	0f 87 9e 00 00 00    	ja     801a98 <__udivdi3+0x108>
  8019fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ff:	89 fa                	mov    %edi,%edx
  801a01:	83 c4 1c             	add    $0x1c,%esp
  801a04:	5b                   	pop    %ebx
  801a05:	5e                   	pop    %esi
  801a06:	5f                   	pop    %edi
  801a07:	5d                   	pop    %ebp
  801a08:	c3                   	ret    
  801a09:	8d 76 00             	lea    0x0(%esi),%esi
  801a0c:	31 ff                	xor    %edi,%edi
  801a0e:	31 c0                	xor    %eax,%eax
  801a10:	89 fa                	mov    %edi,%edx
  801a12:	83 c4 1c             	add    $0x1c,%esp
  801a15:	5b                   	pop    %ebx
  801a16:	5e                   	pop    %esi
  801a17:	5f                   	pop    %edi
  801a18:	5d                   	pop    %ebp
  801a19:	c3                   	ret    
  801a1a:	66 90                	xchg   %ax,%ax
  801a1c:	89 d8                	mov    %ebx,%eax
  801a1e:	f7 f7                	div    %edi
  801a20:	31 ff                	xor    %edi,%edi
  801a22:	89 fa                	mov    %edi,%edx
  801a24:	83 c4 1c             	add    $0x1c,%esp
  801a27:	5b                   	pop    %ebx
  801a28:	5e                   	pop    %esi
  801a29:	5f                   	pop    %edi
  801a2a:	5d                   	pop    %ebp
  801a2b:	c3                   	ret    
  801a2c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a31:	89 eb                	mov    %ebp,%ebx
  801a33:	29 fb                	sub    %edi,%ebx
  801a35:	89 f9                	mov    %edi,%ecx
  801a37:	d3 e6                	shl    %cl,%esi
  801a39:	89 c5                	mov    %eax,%ebp
  801a3b:	88 d9                	mov    %bl,%cl
  801a3d:	d3 ed                	shr    %cl,%ebp
  801a3f:	89 e9                	mov    %ebp,%ecx
  801a41:	09 f1                	or     %esi,%ecx
  801a43:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a47:	89 f9                	mov    %edi,%ecx
  801a49:	d3 e0                	shl    %cl,%eax
  801a4b:	89 c5                	mov    %eax,%ebp
  801a4d:	89 d6                	mov    %edx,%esi
  801a4f:	88 d9                	mov    %bl,%cl
  801a51:	d3 ee                	shr    %cl,%esi
  801a53:	89 f9                	mov    %edi,%ecx
  801a55:	d3 e2                	shl    %cl,%edx
  801a57:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a5b:	88 d9                	mov    %bl,%cl
  801a5d:	d3 e8                	shr    %cl,%eax
  801a5f:	09 c2                	or     %eax,%edx
  801a61:	89 d0                	mov    %edx,%eax
  801a63:	89 f2                	mov    %esi,%edx
  801a65:	f7 74 24 0c          	divl   0xc(%esp)
  801a69:	89 d6                	mov    %edx,%esi
  801a6b:	89 c3                	mov    %eax,%ebx
  801a6d:	f7 e5                	mul    %ebp
  801a6f:	39 d6                	cmp    %edx,%esi
  801a71:	72 19                	jb     801a8c <__udivdi3+0xfc>
  801a73:	74 0b                	je     801a80 <__udivdi3+0xf0>
  801a75:	89 d8                	mov    %ebx,%eax
  801a77:	31 ff                	xor    %edi,%edi
  801a79:	e9 58 ff ff ff       	jmp    8019d6 <__udivdi3+0x46>
  801a7e:	66 90                	xchg   %ax,%ax
  801a80:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a84:	89 f9                	mov    %edi,%ecx
  801a86:	d3 e2                	shl    %cl,%edx
  801a88:	39 c2                	cmp    %eax,%edx
  801a8a:	73 e9                	jae    801a75 <__udivdi3+0xe5>
  801a8c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a8f:	31 ff                	xor    %edi,%edi
  801a91:	e9 40 ff ff ff       	jmp    8019d6 <__udivdi3+0x46>
  801a96:	66 90                	xchg   %ax,%ax
  801a98:	31 c0                	xor    %eax,%eax
  801a9a:	e9 37 ff ff ff       	jmp    8019d6 <__udivdi3+0x46>
  801a9f:	90                   	nop

00801aa0 <__umoddi3>:
  801aa0:	55                   	push   %ebp
  801aa1:	57                   	push   %edi
  801aa2:	56                   	push   %esi
  801aa3:	53                   	push   %ebx
  801aa4:	83 ec 1c             	sub    $0x1c,%esp
  801aa7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801aab:	8b 74 24 34          	mov    0x34(%esp),%esi
  801aaf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ab3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ab7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801abb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801abf:	89 f3                	mov    %esi,%ebx
  801ac1:	89 fa                	mov    %edi,%edx
  801ac3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ac7:	89 34 24             	mov    %esi,(%esp)
  801aca:	85 c0                	test   %eax,%eax
  801acc:	75 1a                	jne    801ae8 <__umoddi3+0x48>
  801ace:	39 f7                	cmp    %esi,%edi
  801ad0:	0f 86 a2 00 00 00    	jbe    801b78 <__umoddi3+0xd8>
  801ad6:	89 c8                	mov    %ecx,%eax
  801ad8:	89 f2                	mov    %esi,%edx
  801ada:	f7 f7                	div    %edi
  801adc:	89 d0                	mov    %edx,%eax
  801ade:	31 d2                	xor    %edx,%edx
  801ae0:	83 c4 1c             	add    $0x1c,%esp
  801ae3:	5b                   	pop    %ebx
  801ae4:	5e                   	pop    %esi
  801ae5:	5f                   	pop    %edi
  801ae6:	5d                   	pop    %ebp
  801ae7:	c3                   	ret    
  801ae8:	39 f0                	cmp    %esi,%eax
  801aea:	0f 87 ac 00 00 00    	ja     801b9c <__umoddi3+0xfc>
  801af0:	0f bd e8             	bsr    %eax,%ebp
  801af3:	83 f5 1f             	xor    $0x1f,%ebp
  801af6:	0f 84 ac 00 00 00    	je     801ba8 <__umoddi3+0x108>
  801afc:	bf 20 00 00 00       	mov    $0x20,%edi
  801b01:	29 ef                	sub    %ebp,%edi
  801b03:	89 fe                	mov    %edi,%esi
  801b05:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b09:	89 e9                	mov    %ebp,%ecx
  801b0b:	d3 e0                	shl    %cl,%eax
  801b0d:	89 d7                	mov    %edx,%edi
  801b0f:	89 f1                	mov    %esi,%ecx
  801b11:	d3 ef                	shr    %cl,%edi
  801b13:	09 c7                	or     %eax,%edi
  801b15:	89 e9                	mov    %ebp,%ecx
  801b17:	d3 e2                	shl    %cl,%edx
  801b19:	89 14 24             	mov    %edx,(%esp)
  801b1c:	89 d8                	mov    %ebx,%eax
  801b1e:	d3 e0                	shl    %cl,%eax
  801b20:	89 c2                	mov    %eax,%edx
  801b22:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b26:	d3 e0                	shl    %cl,%eax
  801b28:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b2c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b30:	89 f1                	mov    %esi,%ecx
  801b32:	d3 e8                	shr    %cl,%eax
  801b34:	09 d0                	or     %edx,%eax
  801b36:	d3 eb                	shr    %cl,%ebx
  801b38:	89 da                	mov    %ebx,%edx
  801b3a:	f7 f7                	div    %edi
  801b3c:	89 d3                	mov    %edx,%ebx
  801b3e:	f7 24 24             	mull   (%esp)
  801b41:	89 c6                	mov    %eax,%esi
  801b43:	89 d1                	mov    %edx,%ecx
  801b45:	39 d3                	cmp    %edx,%ebx
  801b47:	0f 82 87 00 00 00    	jb     801bd4 <__umoddi3+0x134>
  801b4d:	0f 84 91 00 00 00    	je     801be4 <__umoddi3+0x144>
  801b53:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b57:	29 f2                	sub    %esi,%edx
  801b59:	19 cb                	sbb    %ecx,%ebx
  801b5b:	89 d8                	mov    %ebx,%eax
  801b5d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b61:	d3 e0                	shl    %cl,%eax
  801b63:	89 e9                	mov    %ebp,%ecx
  801b65:	d3 ea                	shr    %cl,%edx
  801b67:	09 d0                	or     %edx,%eax
  801b69:	89 e9                	mov    %ebp,%ecx
  801b6b:	d3 eb                	shr    %cl,%ebx
  801b6d:	89 da                	mov    %ebx,%edx
  801b6f:	83 c4 1c             	add    $0x1c,%esp
  801b72:	5b                   	pop    %ebx
  801b73:	5e                   	pop    %esi
  801b74:	5f                   	pop    %edi
  801b75:	5d                   	pop    %ebp
  801b76:	c3                   	ret    
  801b77:	90                   	nop
  801b78:	89 fd                	mov    %edi,%ebp
  801b7a:	85 ff                	test   %edi,%edi
  801b7c:	75 0b                	jne    801b89 <__umoddi3+0xe9>
  801b7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b83:	31 d2                	xor    %edx,%edx
  801b85:	f7 f7                	div    %edi
  801b87:	89 c5                	mov    %eax,%ebp
  801b89:	89 f0                	mov    %esi,%eax
  801b8b:	31 d2                	xor    %edx,%edx
  801b8d:	f7 f5                	div    %ebp
  801b8f:	89 c8                	mov    %ecx,%eax
  801b91:	f7 f5                	div    %ebp
  801b93:	89 d0                	mov    %edx,%eax
  801b95:	e9 44 ff ff ff       	jmp    801ade <__umoddi3+0x3e>
  801b9a:	66 90                	xchg   %ax,%ax
  801b9c:	89 c8                	mov    %ecx,%eax
  801b9e:	89 f2                	mov    %esi,%edx
  801ba0:	83 c4 1c             	add    $0x1c,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    
  801ba8:	3b 04 24             	cmp    (%esp),%eax
  801bab:	72 06                	jb     801bb3 <__umoddi3+0x113>
  801bad:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bb1:	77 0f                	ja     801bc2 <__umoddi3+0x122>
  801bb3:	89 f2                	mov    %esi,%edx
  801bb5:	29 f9                	sub    %edi,%ecx
  801bb7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bbb:	89 14 24             	mov    %edx,(%esp)
  801bbe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bc2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bc6:	8b 14 24             	mov    (%esp),%edx
  801bc9:	83 c4 1c             	add    $0x1c,%esp
  801bcc:	5b                   	pop    %ebx
  801bcd:	5e                   	pop    %esi
  801bce:	5f                   	pop    %edi
  801bcf:	5d                   	pop    %ebp
  801bd0:	c3                   	ret    
  801bd1:	8d 76 00             	lea    0x0(%esi),%esi
  801bd4:	2b 04 24             	sub    (%esp),%eax
  801bd7:	19 fa                	sbb    %edi,%edx
  801bd9:	89 d1                	mov    %edx,%ecx
  801bdb:	89 c6                	mov    %eax,%esi
  801bdd:	e9 71 ff ff ff       	jmp    801b53 <__umoddi3+0xb3>
  801be2:	66 90                	xchg   %ax,%ax
  801be4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801be8:	72 ea                	jb     801bd4 <__umoddi3+0x134>
  801bea:	89 d9                	mov    %ebx,%ecx
  801bec:	e9 62 ff ff ff       	jmp    801b53 <__umoddi3+0xb3>
