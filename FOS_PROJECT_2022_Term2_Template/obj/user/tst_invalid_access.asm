
obj/user/tst_invalid_access:     file format elf32-i386


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
  800031:	e8 57 00 00 00       	call   80008d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	
	

	/// testing illegal memory access
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)


		unsigned char *x = (unsigned char *)0x80000000;
  80004e:	c7 45 e8 00 00 00 80 	movl   $0x80000000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)


		unsigned char *x = (unsigned char *)0x80000000;

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}

		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for new stack pages\n");
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	68 60 1a 80 00       	push   $0x801a60
  800081:	6a 1f                	push   $0x1f
  800083:	68 69 1b 80 00       	push   $0x801b69
  800088:	e8 0f 01 00 00       	call   80019c <_panic>

0080008d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80008d:	55                   	push   %ebp
  80008e:	89 e5                	mov    %esp,%ebp
  800090:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800093:	e8 e3 11 00 00       	call   80127b <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	c1 e0 02             	shl    $0x2,%eax
  8000a3:	01 d0                	add    %edx,%eax
  8000a5:	01 c0                	add    %eax,%eax
  8000a7:	01 d0                	add    %edx,%eax
  8000a9:	01 c0                	add    %eax,%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	c1 e0 02             	shl    $0x2,%eax
  8000b9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000be:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c3:	a1 04 30 80 00       	mov    0x803004,%eax
  8000c8:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000ce:	84 c0                	test   %al,%al
  8000d0:	74 0f                	je     8000e1 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000d2:	a1 04 30 80 00       	mov    0x803004,%eax
  8000d7:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000dc:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e5:	7e 0a                	jle    8000f1 <libmain+0x64>
		binaryname = argv[0];
  8000e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000f1:	83 ec 08             	sub    $0x8,%esp
  8000f4:	ff 75 0c             	pushl  0xc(%ebp)
  8000f7:	ff 75 08             	pushl  0x8(%ebp)
  8000fa:	e8 39 ff ff ff       	call   800038 <_main>
  8000ff:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800102:	e8 0f 13 00 00       	call   801416 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800107:	83 ec 0c             	sub    $0xc,%esp
  80010a:	68 9c 1b 80 00       	push   $0x801b9c
  80010f:	e8 3c 03 00 00       	call   800450 <cprintf>
  800114:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800117:	a1 04 30 80 00       	mov    0x803004,%eax
  80011c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800122:	a1 04 30 80 00       	mov    0x803004,%eax
  800127:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80012d:	83 ec 04             	sub    $0x4,%esp
  800130:	52                   	push   %edx
  800131:	50                   	push   %eax
  800132:	68 c4 1b 80 00       	push   $0x801bc4
  800137:	e8 14 03 00 00       	call   800450 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80013f:	a1 04 30 80 00       	mov    0x803004,%eax
  800144:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80014a:	83 ec 08             	sub    $0x8,%esp
  80014d:	50                   	push   %eax
  80014e:	68 e9 1b 80 00       	push   $0x801be9
  800153:	e8 f8 02 00 00       	call   800450 <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	68 9c 1b 80 00       	push   $0x801b9c
  800163:	e8 e8 02 00 00       	call   800450 <cprintf>
  800168:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80016b:	e8 c0 12 00 00       	call   801430 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800170:	e8 19 00 00 00       	call   80018e <exit>
}
  800175:	90                   	nop
  800176:	c9                   	leave  
  800177:	c3                   	ret    

00800178 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800178:	55                   	push   %ebp
  800179:	89 e5                	mov    %esp,%ebp
  80017b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80017e:	83 ec 0c             	sub    $0xc,%esp
  800181:	6a 00                	push   $0x0
  800183:	e8 bf 10 00 00       	call   801247 <sys_env_destroy>
  800188:	83 c4 10             	add    $0x10,%esp
}
  80018b:	90                   	nop
  80018c:	c9                   	leave  
  80018d:	c3                   	ret    

0080018e <exit>:

void
exit(void)
{
  80018e:	55                   	push   %ebp
  80018f:	89 e5                	mov    %esp,%ebp
  800191:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800194:	e8 14 11 00 00       	call   8012ad <sys_env_exit>
}
  800199:	90                   	nop
  80019a:	c9                   	leave  
  80019b:	c3                   	ret    

0080019c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80019c:	55                   	push   %ebp
  80019d:	89 e5                	mov    %esp,%ebp
  80019f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001a2:	8d 45 10             	lea    0x10(%ebp),%eax
  8001a5:	83 c0 04             	add    $0x4,%eax
  8001a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001ab:	a1 14 30 80 00       	mov    0x803014,%eax
  8001b0:	85 c0                	test   %eax,%eax
  8001b2:	74 16                	je     8001ca <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001b4:	a1 14 30 80 00       	mov    0x803014,%eax
  8001b9:	83 ec 08             	sub    $0x8,%esp
  8001bc:	50                   	push   %eax
  8001bd:	68 00 1c 80 00       	push   $0x801c00
  8001c2:	e8 89 02 00 00       	call   800450 <cprintf>
  8001c7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8001ca:	a1 00 30 80 00       	mov    0x803000,%eax
  8001cf:	ff 75 0c             	pushl  0xc(%ebp)
  8001d2:	ff 75 08             	pushl  0x8(%ebp)
  8001d5:	50                   	push   %eax
  8001d6:	68 05 1c 80 00       	push   $0x801c05
  8001db:	e8 70 02 00 00       	call   800450 <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8001e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8001e6:	83 ec 08             	sub    $0x8,%esp
  8001e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8001ec:	50                   	push   %eax
  8001ed:	e8 f3 01 00 00       	call   8003e5 <vcprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8001f5:	83 ec 08             	sub    $0x8,%esp
  8001f8:	6a 00                	push   $0x0
  8001fa:	68 21 1c 80 00       	push   $0x801c21
  8001ff:	e8 e1 01 00 00       	call   8003e5 <vcprintf>
  800204:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800207:	e8 82 ff ff ff       	call   80018e <exit>

	// should not return here
	while (1) ;
  80020c:	eb fe                	jmp    80020c <_panic+0x70>

0080020e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80020e:	55                   	push   %ebp
  80020f:	89 e5                	mov    %esp,%ebp
  800211:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800214:	a1 04 30 80 00       	mov    0x803004,%eax
  800219:	8b 50 74             	mov    0x74(%eax),%edx
  80021c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021f:	39 c2                	cmp    %eax,%edx
  800221:	74 14                	je     800237 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	68 24 1c 80 00       	push   $0x801c24
  80022b:	6a 26                	push   $0x26
  80022d:	68 70 1c 80 00       	push   $0x801c70
  800232:	e8 65 ff ff ff       	call   80019c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800237:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80023e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800245:	e9 c2 00 00 00       	jmp    80030c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80024a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80024d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800254:	8b 45 08             	mov    0x8(%ebp),%eax
  800257:	01 d0                	add    %edx,%eax
  800259:	8b 00                	mov    (%eax),%eax
  80025b:	85 c0                	test   %eax,%eax
  80025d:	75 08                	jne    800267 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80025f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800262:	e9 a2 00 00 00       	jmp    800309 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800267:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80026e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800275:	eb 69                	jmp    8002e0 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800277:	a1 04 30 80 00       	mov    0x803004,%eax
  80027c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800282:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800285:	89 d0                	mov    %edx,%eax
  800287:	01 c0                	add    %eax,%eax
  800289:	01 d0                	add    %edx,%eax
  80028b:	c1 e0 02             	shl    $0x2,%eax
  80028e:	01 c8                	add    %ecx,%eax
  800290:	8a 40 04             	mov    0x4(%eax),%al
  800293:	84 c0                	test   %al,%al
  800295:	75 46                	jne    8002dd <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800297:	a1 04 30 80 00       	mov    0x803004,%eax
  80029c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8002a2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002a5:	89 d0                	mov    %edx,%eax
  8002a7:	01 c0                	add    %eax,%eax
  8002a9:	01 d0                	add    %edx,%eax
  8002ab:	c1 e0 02             	shl    $0x2,%eax
  8002ae:	01 c8                	add    %ecx,%eax
  8002b0:	8b 00                	mov    (%eax),%eax
  8002b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002bd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002cc:	01 c8                	add    %ecx,%eax
  8002ce:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002d0:	39 c2                	cmp    %eax,%edx
  8002d2:	75 09                	jne    8002dd <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8002d4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8002db:	eb 12                	jmp    8002ef <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002dd:	ff 45 e8             	incl   -0x18(%ebp)
  8002e0:	a1 04 30 80 00       	mov    0x803004,%eax
  8002e5:	8b 50 74             	mov    0x74(%eax),%edx
  8002e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002eb:	39 c2                	cmp    %eax,%edx
  8002ed:	77 88                	ja     800277 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8002ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8002f3:	75 14                	jne    800309 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8002f5:	83 ec 04             	sub    $0x4,%esp
  8002f8:	68 7c 1c 80 00       	push   $0x801c7c
  8002fd:	6a 3a                	push   $0x3a
  8002ff:	68 70 1c 80 00       	push   $0x801c70
  800304:	e8 93 fe ff ff       	call   80019c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800309:	ff 45 f0             	incl   -0x10(%ebp)
  80030c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800312:	0f 8c 32 ff ff ff    	jl     80024a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800318:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80031f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800326:	eb 26                	jmp    80034e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800328:	a1 04 30 80 00       	mov    0x803004,%eax
  80032d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800333:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800336:	89 d0                	mov    %edx,%eax
  800338:	01 c0                	add    %eax,%eax
  80033a:	01 d0                	add    %edx,%eax
  80033c:	c1 e0 02             	shl    $0x2,%eax
  80033f:	01 c8                	add    %ecx,%eax
  800341:	8a 40 04             	mov    0x4(%eax),%al
  800344:	3c 01                	cmp    $0x1,%al
  800346:	75 03                	jne    80034b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800348:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80034b:	ff 45 e0             	incl   -0x20(%ebp)
  80034e:	a1 04 30 80 00       	mov    0x803004,%eax
  800353:	8b 50 74             	mov    0x74(%eax),%edx
  800356:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800359:	39 c2                	cmp    %eax,%edx
  80035b:	77 cb                	ja     800328 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80035d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800360:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800363:	74 14                	je     800379 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 d0 1c 80 00       	push   $0x801cd0
  80036d:	6a 44                	push   $0x44
  80036f:	68 70 1c 80 00       	push   $0x801c70
  800374:	e8 23 fe ff ff       	call   80019c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800382:	8b 45 0c             	mov    0xc(%ebp),%eax
  800385:	8b 00                	mov    (%eax),%eax
  800387:	8d 48 01             	lea    0x1(%eax),%ecx
  80038a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80038d:	89 0a                	mov    %ecx,(%edx)
  80038f:	8b 55 08             	mov    0x8(%ebp),%edx
  800392:	88 d1                	mov    %dl,%cl
  800394:	8b 55 0c             	mov    0xc(%ebp),%edx
  800397:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	8b 00                	mov    (%eax),%eax
  8003a0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003a5:	75 2c                	jne    8003d3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003a7:	a0 08 30 80 00       	mov    0x803008,%al
  8003ac:	0f b6 c0             	movzbl %al,%eax
  8003af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b2:	8b 12                	mov    (%edx),%edx
  8003b4:	89 d1                	mov    %edx,%ecx
  8003b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003b9:	83 c2 08             	add    $0x8,%edx
  8003bc:	83 ec 04             	sub    $0x4,%esp
  8003bf:	50                   	push   %eax
  8003c0:	51                   	push   %ecx
  8003c1:	52                   	push   %edx
  8003c2:	e8 3e 0e 00 00       	call   801205 <sys_cputs>
  8003c7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d6:	8b 40 04             	mov    0x4(%eax),%eax
  8003d9:	8d 50 01             	lea    0x1(%eax),%edx
  8003dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003df:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003e2:	90                   	nop
  8003e3:	c9                   	leave  
  8003e4:	c3                   	ret    

008003e5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003e5:	55                   	push   %ebp
  8003e6:	89 e5                	mov    %esp,%ebp
  8003e8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003ee:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003f5:	00 00 00 
	b.cnt = 0;
  8003f8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003ff:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800402:	ff 75 0c             	pushl  0xc(%ebp)
  800405:	ff 75 08             	pushl  0x8(%ebp)
  800408:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80040e:	50                   	push   %eax
  80040f:	68 7c 03 80 00       	push   $0x80037c
  800414:	e8 11 02 00 00       	call   80062a <vprintfmt>
  800419:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80041c:	a0 08 30 80 00       	mov    0x803008,%al
  800421:	0f b6 c0             	movzbl %al,%eax
  800424:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80042a:	83 ec 04             	sub    $0x4,%esp
  80042d:	50                   	push   %eax
  80042e:	52                   	push   %edx
  80042f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800435:	83 c0 08             	add    $0x8,%eax
  800438:	50                   	push   %eax
  800439:	e8 c7 0d 00 00       	call   801205 <sys_cputs>
  80043e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800441:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800448:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80044e:	c9                   	leave  
  80044f:	c3                   	ret    

00800450 <cprintf>:

int cprintf(const char *fmt, ...) {
  800450:	55                   	push   %ebp
  800451:	89 e5                	mov    %esp,%ebp
  800453:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800456:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  80045d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800460:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	83 ec 08             	sub    $0x8,%esp
  800469:	ff 75 f4             	pushl  -0xc(%ebp)
  80046c:	50                   	push   %eax
  80046d:	e8 73 ff ff ff       	call   8003e5 <vcprintf>
  800472:	83 c4 10             	add    $0x10,%esp
  800475:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800478:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800483:	e8 8e 0f 00 00       	call   801416 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800488:	8d 45 0c             	lea    0xc(%ebp),%eax
  80048b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	83 ec 08             	sub    $0x8,%esp
  800494:	ff 75 f4             	pushl  -0xc(%ebp)
  800497:	50                   	push   %eax
  800498:	e8 48 ff ff ff       	call   8003e5 <vcprintf>
  80049d:	83 c4 10             	add    $0x10,%esp
  8004a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004a3:	e8 88 0f 00 00       	call   801430 <sys_enable_interrupt>
	return cnt;
  8004a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004ab:	c9                   	leave  
  8004ac:	c3                   	ret    

008004ad <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004ad:	55                   	push   %ebp
  8004ae:	89 e5                	mov    %esp,%ebp
  8004b0:	53                   	push   %ebx
  8004b1:	83 ec 14             	sub    $0x14,%esp
  8004b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8004bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004c0:	8b 45 18             	mov    0x18(%ebp),%eax
  8004c3:	ba 00 00 00 00       	mov    $0x0,%edx
  8004c8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004cb:	77 55                	ja     800522 <printnum+0x75>
  8004cd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004d0:	72 05                	jb     8004d7 <printnum+0x2a>
  8004d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004d5:	77 4b                	ja     800522 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004d7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004da:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004dd:	8b 45 18             	mov    0x18(%ebp),%eax
  8004e0:	ba 00 00 00 00       	mov    $0x0,%edx
  8004e5:	52                   	push   %edx
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8004ed:	e8 02 13 00 00       	call   8017f4 <__udivdi3>
  8004f2:	83 c4 10             	add    $0x10,%esp
  8004f5:	83 ec 04             	sub    $0x4,%esp
  8004f8:	ff 75 20             	pushl  0x20(%ebp)
  8004fb:	53                   	push   %ebx
  8004fc:	ff 75 18             	pushl  0x18(%ebp)
  8004ff:	52                   	push   %edx
  800500:	50                   	push   %eax
  800501:	ff 75 0c             	pushl  0xc(%ebp)
  800504:	ff 75 08             	pushl  0x8(%ebp)
  800507:	e8 a1 ff ff ff       	call   8004ad <printnum>
  80050c:	83 c4 20             	add    $0x20,%esp
  80050f:	eb 1a                	jmp    80052b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800511:	83 ec 08             	sub    $0x8,%esp
  800514:	ff 75 0c             	pushl  0xc(%ebp)
  800517:	ff 75 20             	pushl  0x20(%ebp)
  80051a:	8b 45 08             	mov    0x8(%ebp),%eax
  80051d:	ff d0                	call   *%eax
  80051f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800522:	ff 4d 1c             	decl   0x1c(%ebp)
  800525:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800529:	7f e6                	jg     800511 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80052b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80052e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800533:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800536:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800539:	53                   	push   %ebx
  80053a:	51                   	push   %ecx
  80053b:	52                   	push   %edx
  80053c:	50                   	push   %eax
  80053d:	e8 c2 13 00 00       	call   801904 <__umoddi3>
  800542:	83 c4 10             	add    $0x10,%esp
  800545:	05 34 1f 80 00       	add    $0x801f34,%eax
  80054a:	8a 00                	mov    (%eax),%al
  80054c:	0f be c0             	movsbl %al,%eax
  80054f:	83 ec 08             	sub    $0x8,%esp
  800552:	ff 75 0c             	pushl  0xc(%ebp)
  800555:	50                   	push   %eax
  800556:	8b 45 08             	mov    0x8(%ebp),%eax
  800559:	ff d0                	call   *%eax
  80055b:	83 c4 10             	add    $0x10,%esp
}
  80055e:	90                   	nop
  80055f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800562:	c9                   	leave  
  800563:	c3                   	ret    

00800564 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800564:	55                   	push   %ebp
  800565:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800567:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80056b:	7e 1c                	jle    800589 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80056d:	8b 45 08             	mov    0x8(%ebp),%eax
  800570:	8b 00                	mov    (%eax),%eax
  800572:	8d 50 08             	lea    0x8(%eax),%edx
  800575:	8b 45 08             	mov    0x8(%ebp),%eax
  800578:	89 10                	mov    %edx,(%eax)
  80057a:	8b 45 08             	mov    0x8(%ebp),%eax
  80057d:	8b 00                	mov    (%eax),%eax
  80057f:	83 e8 08             	sub    $0x8,%eax
  800582:	8b 50 04             	mov    0x4(%eax),%edx
  800585:	8b 00                	mov    (%eax),%eax
  800587:	eb 40                	jmp    8005c9 <getuint+0x65>
	else if (lflag)
  800589:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80058d:	74 1e                	je     8005ad <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	8d 50 04             	lea    0x4(%eax),%edx
  800597:	8b 45 08             	mov    0x8(%ebp),%eax
  80059a:	89 10                	mov    %edx,(%eax)
  80059c:	8b 45 08             	mov    0x8(%ebp),%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 e8 04             	sub    $0x4,%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	ba 00 00 00 00       	mov    $0x0,%edx
  8005ab:	eb 1c                	jmp    8005c9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	8b 00                	mov    (%eax),%eax
  8005b2:	8d 50 04             	lea    0x4(%eax),%edx
  8005b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b8:	89 10                	mov    %edx,(%eax)
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	83 e8 04             	sub    $0x4,%eax
  8005c2:	8b 00                	mov    (%eax),%eax
  8005c4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005c9:	5d                   	pop    %ebp
  8005ca:	c3                   	ret    

008005cb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005cb:	55                   	push   %ebp
  8005cc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005ce:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005d2:	7e 1c                	jle    8005f0 <getint+0x25>
		return va_arg(*ap, long long);
  8005d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d7:	8b 00                	mov    (%eax),%eax
  8005d9:	8d 50 08             	lea    0x8(%eax),%edx
  8005dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005df:	89 10                	mov    %edx,(%eax)
  8005e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	83 e8 08             	sub    $0x8,%eax
  8005e9:	8b 50 04             	mov    0x4(%eax),%edx
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	eb 38                	jmp    800628 <getint+0x5d>
	else if (lflag)
  8005f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005f4:	74 1a                	je     800610 <getint+0x45>
		return va_arg(*ap, long);
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	8d 50 04             	lea    0x4(%eax),%edx
  8005fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800601:	89 10                	mov    %edx,(%eax)
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	8b 00                	mov    (%eax),%eax
  800608:	83 e8 04             	sub    $0x4,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	99                   	cltd   
  80060e:	eb 18                	jmp    800628 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	8d 50 04             	lea    0x4(%eax),%edx
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	89 10                	mov    %edx,(%eax)
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	8b 00                	mov    (%eax),%eax
  800622:	83 e8 04             	sub    $0x4,%eax
  800625:	8b 00                	mov    (%eax),%eax
  800627:	99                   	cltd   
}
  800628:	5d                   	pop    %ebp
  800629:	c3                   	ret    

0080062a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80062a:	55                   	push   %ebp
  80062b:	89 e5                	mov    %esp,%ebp
  80062d:	56                   	push   %esi
  80062e:	53                   	push   %ebx
  80062f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800632:	eb 17                	jmp    80064b <vprintfmt+0x21>
			if (ch == '\0')
  800634:	85 db                	test   %ebx,%ebx
  800636:	0f 84 af 03 00 00    	je     8009eb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80063c:	83 ec 08             	sub    $0x8,%esp
  80063f:	ff 75 0c             	pushl  0xc(%ebp)
  800642:	53                   	push   %ebx
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	ff d0                	call   *%eax
  800648:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80064b:	8b 45 10             	mov    0x10(%ebp),%eax
  80064e:	8d 50 01             	lea    0x1(%eax),%edx
  800651:	89 55 10             	mov    %edx,0x10(%ebp)
  800654:	8a 00                	mov    (%eax),%al
  800656:	0f b6 d8             	movzbl %al,%ebx
  800659:	83 fb 25             	cmp    $0x25,%ebx
  80065c:	75 d6                	jne    800634 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80065e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800662:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800669:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800670:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800677:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80067e:	8b 45 10             	mov    0x10(%ebp),%eax
  800681:	8d 50 01             	lea    0x1(%eax),%edx
  800684:	89 55 10             	mov    %edx,0x10(%ebp)
  800687:	8a 00                	mov    (%eax),%al
  800689:	0f b6 d8             	movzbl %al,%ebx
  80068c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80068f:	83 f8 55             	cmp    $0x55,%eax
  800692:	0f 87 2b 03 00 00    	ja     8009c3 <vprintfmt+0x399>
  800698:	8b 04 85 58 1f 80 00 	mov    0x801f58(,%eax,4),%eax
  80069f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006a1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006a5:	eb d7                	jmp    80067e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006a7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006ab:	eb d1                	jmp    80067e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ad:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006b4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006b7:	89 d0                	mov    %edx,%eax
  8006b9:	c1 e0 02             	shl    $0x2,%eax
  8006bc:	01 d0                	add    %edx,%eax
  8006be:	01 c0                	add    %eax,%eax
  8006c0:	01 d8                	add    %ebx,%eax
  8006c2:	83 e8 30             	sub    $0x30,%eax
  8006c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006cb:	8a 00                	mov    (%eax),%al
  8006cd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006d0:	83 fb 2f             	cmp    $0x2f,%ebx
  8006d3:	7e 3e                	jle    800713 <vprintfmt+0xe9>
  8006d5:	83 fb 39             	cmp    $0x39,%ebx
  8006d8:	7f 39                	jg     800713 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006da:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006dd:	eb d5                	jmp    8006b4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006df:	8b 45 14             	mov    0x14(%ebp),%eax
  8006e2:	83 c0 04             	add    $0x4,%eax
  8006e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8006e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8006eb:	83 e8 04             	sub    $0x4,%eax
  8006ee:	8b 00                	mov    (%eax),%eax
  8006f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006f3:	eb 1f                	jmp    800714 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f9:	79 83                	jns    80067e <vprintfmt+0x54>
				width = 0;
  8006fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800702:	e9 77 ff ff ff       	jmp    80067e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800707:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80070e:	e9 6b ff ff ff       	jmp    80067e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800713:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800714:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800718:	0f 89 60 ff ff ff    	jns    80067e <vprintfmt+0x54>
				width = precision, precision = -1;
  80071e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800721:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800724:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80072b:	e9 4e ff ff ff       	jmp    80067e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800730:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800733:	e9 46 ff ff ff       	jmp    80067e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800738:	8b 45 14             	mov    0x14(%ebp),%eax
  80073b:	83 c0 04             	add    $0x4,%eax
  80073e:	89 45 14             	mov    %eax,0x14(%ebp)
  800741:	8b 45 14             	mov    0x14(%ebp),%eax
  800744:	83 e8 04             	sub    $0x4,%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	83 ec 08             	sub    $0x8,%esp
  80074c:	ff 75 0c             	pushl  0xc(%ebp)
  80074f:	50                   	push   %eax
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	ff d0                	call   *%eax
  800755:	83 c4 10             	add    $0x10,%esp
			break;
  800758:	e9 89 02 00 00       	jmp    8009e6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80075d:	8b 45 14             	mov    0x14(%ebp),%eax
  800760:	83 c0 04             	add    $0x4,%eax
  800763:	89 45 14             	mov    %eax,0x14(%ebp)
  800766:	8b 45 14             	mov    0x14(%ebp),%eax
  800769:	83 e8 04             	sub    $0x4,%eax
  80076c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80076e:	85 db                	test   %ebx,%ebx
  800770:	79 02                	jns    800774 <vprintfmt+0x14a>
				err = -err;
  800772:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800774:	83 fb 64             	cmp    $0x64,%ebx
  800777:	7f 0b                	jg     800784 <vprintfmt+0x15a>
  800779:	8b 34 9d a0 1d 80 00 	mov    0x801da0(,%ebx,4),%esi
  800780:	85 f6                	test   %esi,%esi
  800782:	75 19                	jne    80079d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800784:	53                   	push   %ebx
  800785:	68 45 1f 80 00       	push   $0x801f45
  80078a:	ff 75 0c             	pushl  0xc(%ebp)
  80078d:	ff 75 08             	pushl  0x8(%ebp)
  800790:	e8 5e 02 00 00       	call   8009f3 <printfmt>
  800795:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800798:	e9 49 02 00 00       	jmp    8009e6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80079d:	56                   	push   %esi
  80079e:	68 4e 1f 80 00       	push   $0x801f4e
  8007a3:	ff 75 0c             	pushl  0xc(%ebp)
  8007a6:	ff 75 08             	pushl  0x8(%ebp)
  8007a9:	e8 45 02 00 00       	call   8009f3 <printfmt>
  8007ae:	83 c4 10             	add    $0x10,%esp
			break;
  8007b1:	e9 30 02 00 00       	jmp    8009e6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b9:	83 c0 04             	add    $0x4,%eax
  8007bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8007bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c2:	83 e8 04             	sub    $0x4,%eax
  8007c5:	8b 30                	mov    (%eax),%esi
  8007c7:	85 f6                	test   %esi,%esi
  8007c9:	75 05                	jne    8007d0 <vprintfmt+0x1a6>
				p = "(null)";
  8007cb:	be 51 1f 80 00       	mov    $0x801f51,%esi
			if (width > 0 && padc != '-')
  8007d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007d4:	7e 6d                	jle    800843 <vprintfmt+0x219>
  8007d6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007da:	74 67                	je     800843 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	50                   	push   %eax
  8007e3:	56                   	push   %esi
  8007e4:	e8 0c 03 00 00       	call   800af5 <strnlen>
  8007e9:	83 c4 10             	add    $0x10,%esp
  8007ec:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007ef:	eb 16                	jmp    800807 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007f1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	50                   	push   %eax
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	ff d0                	call   *%eax
  800801:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800804:	ff 4d e4             	decl   -0x1c(%ebp)
  800807:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80080b:	7f e4                	jg     8007f1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80080d:	eb 34                	jmp    800843 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80080f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800813:	74 1c                	je     800831 <vprintfmt+0x207>
  800815:	83 fb 1f             	cmp    $0x1f,%ebx
  800818:	7e 05                	jle    80081f <vprintfmt+0x1f5>
  80081a:	83 fb 7e             	cmp    $0x7e,%ebx
  80081d:	7e 12                	jle    800831 <vprintfmt+0x207>
					putch('?', putdat);
  80081f:	83 ec 08             	sub    $0x8,%esp
  800822:	ff 75 0c             	pushl  0xc(%ebp)
  800825:	6a 3f                	push   $0x3f
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	ff d0                	call   *%eax
  80082c:	83 c4 10             	add    $0x10,%esp
  80082f:	eb 0f                	jmp    800840 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800831:	83 ec 08             	sub    $0x8,%esp
  800834:	ff 75 0c             	pushl  0xc(%ebp)
  800837:	53                   	push   %ebx
  800838:	8b 45 08             	mov    0x8(%ebp),%eax
  80083b:	ff d0                	call   *%eax
  80083d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800840:	ff 4d e4             	decl   -0x1c(%ebp)
  800843:	89 f0                	mov    %esi,%eax
  800845:	8d 70 01             	lea    0x1(%eax),%esi
  800848:	8a 00                	mov    (%eax),%al
  80084a:	0f be d8             	movsbl %al,%ebx
  80084d:	85 db                	test   %ebx,%ebx
  80084f:	74 24                	je     800875 <vprintfmt+0x24b>
  800851:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800855:	78 b8                	js     80080f <vprintfmt+0x1e5>
  800857:	ff 4d e0             	decl   -0x20(%ebp)
  80085a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80085e:	79 af                	jns    80080f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800860:	eb 13                	jmp    800875 <vprintfmt+0x24b>
				putch(' ', putdat);
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	ff 75 0c             	pushl  0xc(%ebp)
  800868:	6a 20                	push   $0x20
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	ff d0                	call   *%eax
  80086f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800872:	ff 4d e4             	decl   -0x1c(%ebp)
  800875:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800879:	7f e7                	jg     800862 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80087b:	e9 66 01 00 00       	jmp    8009e6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800880:	83 ec 08             	sub    $0x8,%esp
  800883:	ff 75 e8             	pushl  -0x18(%ebp)
  800886:	8d 45 14             	lea    0x14(%ebp),%eax
  800889:	50                   	push   %eax
  80088a:	e8 3c fd ff ff       	call   8005cb <getint>
  80088f:	83 c4 10             	add    $0x10,%esp
  800892:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800895:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800898:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80089b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80089e:	85 d2                	test   %edx,%edx
  8008a0:	79 23                	jns    8008c5 <vprintfmt+0x29b>
				putch('-', putdat);
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 0c             	pushl  0xc(%ebp)
  8008a8:	6a 2d                	push   $0x2d
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	ff d0                	call   *%eax
  8008af:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b8:	f7 d8                	neg    %eax
  8008ba:	83 d2 00             	adc    $0x0,%edx
  8008bd:	f7 da                	neg    %edx
  8008bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008c5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008cc:	e9 bc 00 00 00       	jmp    80098d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008d1:	83 ec 08             	sub    $0x8,%esp
  8008d4:	ff 75 e8             	pushl  -0x18(%ebp)
  8008d7:	8d 45 14             	lea    0x14(%ebp),%eax
  8008da:	50                   	push   %eax
  8008db:	e8 84 fc ff ff       	call   800564 <getuint>
  8008e0:	83 c4 10             	add    $0x10,%esp
  8008e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008e9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008f0:	e9 98 00 00 00       	jmp    80098d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008f5:	83 ec 08             	sub    $0x8,%esp
  8008f8:	ff 75 0c             	pushl  0xc(%ebp)
  8008fb:	6a 58                	push   $0x58
  8008fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800900:	ff d0                	call   *%eax
  800902:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800905:	83 ec 08             	sub    $0x8,%esp
  800908:	ff 75 0c             	pushl  0xc(%ebp)
  80090b:	6a 58                	push   $0x58
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	ff d0                	call   *%eax
  800912:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	6a 58                	push   $0x58
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	ff d0                	call   *%eax
  800922:	83 c4 10             	add    $0x10,%esp
			break;
  800925:	e9 bc 00 00 00       	jmp    8009e6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	6a 30                	push   $0x30
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	ff d0                	call   *%eax
  800937:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80093a:	83 ec 08             	sub    $0x8,%esp
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	6a 78                	push   $0x78
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	ff d0                	call   *%eax
  800947:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80094a:	8b 45 14             	mov    0x14(%ebp),%eax
  80094d:	83 c0 04             	add    $0x4,%eax
  800950:	89 45 14             	mov    %eax,0x14(%ebp)
  800953:	8b 45 14             	mov    0x14(%ebp),%eax
  800956:	83 e8 04             	sub    $0x4,%eax
  800959:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80095b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800965:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80096c:	eb 1f                	jmp    80098d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80096e:	83 ec 08             	sub    $0x8,%esp
  800971:	ff 75 e8             	pushl  -0x18(%ebp)
  800974:	8d 45 14             	lea    0x14(%ebp),%eax
  800977:	50                   	push   %eax
  800978:	e8 e7 fb ff ff       	call   800564 <getuint>
  80097d:	83 c4 10             	add    $0x10,%esp
  800980:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800983:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800986:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80098d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800991:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800994:	83 ec 04             	sub    $0x4,%esp
  800997:	52                   	push   %edx
  800998:	ff 75 e4             	pushl  -0x1c(%ebp)
  80099b:	50                   	push   %eax
  80099c:	ff 75 f4             	pushl  -0xc(%ebp)
  80099f:	ff 75 f0             	pushl  -0x10(%ebp)
  8009a2:	ff 75 0c             	pushl  0xc(%ebp)
  8009a5:	ff 75 08             	pushl  0x8(%ebp)
  8009a8:	e8 00 fb ff ff       	call   8004ad <printnum>
  8009ad:	83 c4 20             	add    $0x20,%esp
			break;
  8009b0:	eb 34                	jmp    8009e6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009b2:	83 ec 08             	sub    $0x8,%esp
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	53                   	push   %ebx
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	ff d0                	call   *%eax
  8009be:	83 c4 10             	add    $0x10,%esp
			break;
  8009c1:	eb 23                	jmp    8009e6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009c3:	83 ec 08             	sub    $0x8,%esp
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	6a 25                	push   $0x25
  8009cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ce:	ff d0                	call   *%eax
  8009d0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009d3:	ff 4d 10             	decl   0x10(%ebp)
  8009d6:	eb 03                	jmp    8009db <vprintfmt+0x3b1>
  8009d8:	ff 4d 10             	decl   0x10(%ebp)
  8009db:	8b 45 10             	mov    0x10(%ebp),%eax
  8009de:	48                   	dec    %eax
  8009df:	8a 00                	mov    (%eax),%al
  8009e1:	3c 25                	cmp    $0x25,%al
  8009e3:	75 f3                	jne    8009d8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009e5:	90                   	nop
		}
	}
  8009e6:	e9 47 fc ff ff       	jmp    800632 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009eb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009ef:	5b                   	pop    %ebx
  8009f0:	5e                   	pop    %esi
  8009f1:	5d                   	pop    %ebp
  8009f2:	c3                   	ret    

008009f3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009f3:	55                   	push   %ebp
  8009f4:	89 e5                	mov    %esp,%ebp
  8009f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8009fc:	83 c0 04             	add    $0x4,%eax
  8009ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a02:	8b 45 10             	mov    0x10(%ebp),%eax
  800a05:	ff 75 f4             	pushl  -0xc(%ebp)
  800a08:	50                   	push   %eax
  800a09:	ff 75 0c             	pushl  0xc(%ebp)
  800a0c:	ff 75 08             	pushl  0x8(%ebp)
  800a0f:	e8 16 fc ff ff       	call   80062a <vprintfmt>
  800a14:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a17:	90                   	nop
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a20:	8b 40 08             	mov    0x8(%eax),%eax
  800a23:	8d 50 01             	lea    0x1(%eax),%edx
  800a26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a29:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2f:	8b 10                	mov    (%eax),%edx
  800a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a34:	8b 40 04             	mov    0x4(%eax),%eax
  800a37:	39 c2                	cmp    %eax,%edx
  800a39:	73 12                	jae    800a4d <sprintputch+0x33>
		*b->buf++ = ch;
  800a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3e:	8b 00                	mov    (%eax),%eax
  800a40:	8d 48 01             	lea    0x1(%eax),%ecx
  800a43:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a46:	89 0a                	mov    %ecx,(%edx)
  800a48:	8b 55 08             	mov    0x8(%ebp),%edx
  800a4b:	88 10                	mov    %dl,(%eax)
}
  800a4d:	90                   	nop
  800a4e:	5d                   	pop    %ebp
  800a4f:	c3                   	ret    

00800a50 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a50:	55                   	push   %ebp
  800a51:	89 e5                	mov    %esp,%ebp
  800a53:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	01 d0                	add    %edx,%eax
  800a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a71:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a75:	74 06                	je     800a7d <vsnprintf+0x2d>
  800a77:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a7b:	7f 07                	jg     800a84 <vsnprintf+0x34>
		return -E_INVAL;
  800a7d:	b8 03 00 00 00       	mov    $0x3,%eax
  800a82:	eb 20                	jmp    800aa4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a84:	ff 75 14             	pushl  0x14(%ebp)
  800a87:	ff 75 10             	pushl  0x10(%ebp)
  800a8a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a8d:	50                   	push   %eax
  800a8e:	68 1a 0a 80 00       	push   $0x800a1a
  800a93:	e8 92 fb ff ff       	call   80062a <vprintfmt>
  800a98:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a9e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800aa4:	c9                   	leave  
  800aa5:	c3                   	ret    

00800aa6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800aa6:	55                   	push   %ebp
  800aa7:	89 e5                	mov    %esp,%ebp
  800aa9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800aac:	8d 45 10             	lea    0x10(%ebp),%eax
  800aaf:	83 c0 04             	add    $0x4,%eax
  800ab2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ab5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab8:	ff 75 f4             	pushl  -0xc(%ebp)
  800abb:	50                   	push   %eax
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	ff 75 08             	pushl  0x8(%ebp)
  800ac2:	e8 89 ff ff ff       	call   800a50 <vsnprintf>
  800ac7:	83 c4 10             	add    $0x10,%esp
  800aca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800acd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ad0:	c9                   	leave  
  800ad1:	c3                   	ret    

00800ad2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ad2:	55                   	push   %ebp
  800ad3:	89 e5                	mov    %esp,%ebp
  800ad5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ad8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800adf:	eb 06                	jmp    800ae7 <strlen+0x15>
		n++;
  800ae1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ae4:	ff 45 08             	incl   0x8(%ebp)
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	8a 00                	mov    (%eax),%al
  800aec:	84 c0                	test   %al,%al
  800aee:	75 f1                	jne    800ae1 <strlen+0xf>
		n++;
	return n;
  800af0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
  800af8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800afb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b02:	eb 09                	jmp    800b0d <strnlen+0x18>
		n++;
  800b04:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b07:	ff 45 08             	incl   0x8(%ebp)
  800b0a:	ff 4d 0c             	decl   0xc(%ebp)
  800b0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b11:	74 09                	je     800b1c <strnlen+0x27>
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	8a 00                	mov    (%eax),%al
  800b18:	84 c0                	test   %al,%al
  800b1a:	75 e8                	jne    800b04 <strnlen+0xf>
		n++;
	return n;
  800b1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b1f:	c9                   	leave  
  800b20:	c3                   	ret    

00800b21 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b21:	55                   	push   %ebp
  800b22:	89 e5                	mov    %esp,%ebp
  800b24:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b2d:	90                   	nop
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8d 50 01             	lea    0x1(%eax),%edx
  800b34:	89 55 08             	mov    %edx,0x8(%ebp)
  800b37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b3a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b3d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b40:	8a 12                	mov    (%edx),%dl
  800b42:	88 10                	mov    %dl,(%eax)
  800b44:	8a 00                	mov    (%eax),%al
  800b46:	84 c0                	test   %al,%al
  800b48:	75 e4                	jne    800b2e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b62:	eb 1f                	jmp    800b83 <strncpy+0x34>
		*dst++ = *src;
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8d 50 01             	lea    0x1(%eax),%edx
  800b6a:	89 55 08             	mov    %edx,0x8(%ebp)
  800b6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b70:	8a 12                	mov    (%edx),%dl
  800b72:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b77:	8a 00                	mov    (%eax),%al
  800b79:	84 c0                	test   %al,%al
  800b7b:	74 03                	je     800b80 <strncpy+0x31>
			src++;
  800b7d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b80:	ff 45 fc             	incl   -0x4(%ebp)
  800b83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b86:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b89:	72 d9                	jb     800b64 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b8e:	c9                   	leave  
  800b8f:	c3                   	ret    

00800b90 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
  800b93:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ba0:	74 30                	je     800bd2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ba2:	eb 16                	jmp    800bba <strlcpy+0x2a>
			*dst++ = *src++;
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	8d 50 01             	lea    0x1(%eax),%edx
  800baa:	89 55 08             	mov    %edx,0x8(%ebp)
  800bad:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bb6:	8a 12                	mov    (%edx),%dl
  800bb8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bba:	ff 4d 10             	decl   0x10(%ebp)
  800bbd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bc1:	74 09                	je     800bcc <strlcpy+0x3c>
  800bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	84 c0                	test   %al,%al
  800bca:	75 d8                	jne    800ba4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bd2:	8b 55 08             	mov    0x8(%ebp),%edx
  800bd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd8:	29 c2                	sub    %eax,%edx
  800bda:	89 d0                	mov    %edx,%eax
}
  800bdc:	c9                   	leave  
  800bdd:	c3                   	ret    

00800bde <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800be1:	eb 06                	jmp    800be9 <strcmp+0xb>
		p++, q++;
  800be3:	ff 45 08             	incl   0x8(%ebp)
  800be6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	84 c0                	test   %al,%al
  800bf0:	74 0e                	je     800c00 <strcmp+0x22>
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	8a 10                	mov    (%eax),%dl
  800bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfa:	8a 00                	mov    (%eax),%al
  800bfc:	38 c2                	cmp    %al,%dl
  800bfe:	74 e3                	je     800be3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c00:	8b 45 08             	mov    0x8(%ebp),%eax
  800c03:	8a 00                	mov    (%eax),%al
  800c05:	0f b6 d0             	movzbl %al,%edx
  800c08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f b6 c0             	movzbl %al,%eax
  800c10:	29 c2                	sub    %eax,%edx
  800c12:	89 d0                	mov    %edx,%eax
}
  800c14:	5d                   	pop    %ebp
  800c15:	c3                   	ret    

00800c16 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c16:	55                   	push   %ebp
  800c17:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c19:	eb 09                	jmp    800c24 <strncmp+0xe>
		n--, p++, q++;
  800c1b:	ff 4d 10             	decl   0x10(%ebp)
  800c1e:	ff 45 08             	incl   0x8(%ebp)
  800c21:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c28:	74 17                	je     800c41 <strncmp+0x2b>
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	84 c0                	test   %al,%al
  800c31:	74 0e                	je     800c41 <strncmp+0x2b>
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	8a 10                	mov    (%eax),%dl
  800c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3b:	8a 00                	mov    (%eax),%al
  800c3d:	38 c2                	cmp    %al,%dl
  800c3f:	74 da                	je     800c1b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c45:	75 07                	jne    800c4e <strncmp+0x38>
		return 0;
  800c47:	b8 00 00 00 00       	mov    $0x0,%eax
  800c4c:	eb 14                	jmp    800c62 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	0f b6 d0             	movzbl %al,%edx
  800c56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	0f b6 c0             	movzbl %al,%eax
  800c5e:	29 c2                	sub    %eax,%edx
  800c60:	89 d0                	mov    %edx,%eax
}
  800c62:	5d                   	pop    %ebp
  800c63:	c3                   	ret    

00800c64 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c64:	55                   	push   %ebp
  800c65:	89 e5                	mov    %esp,%ebp
  800c67:	83 ec 04             	sub    $0x4,%esp
  800c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c70:	eb 12                	jmp    800c84 <strchr+0x20>
		if (*s == c)
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c7a:	75 05                	jne    800c81 <strchr+0x1d>
			return (char *) s;
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	eb 11                	jmp    800c92 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c81:	ff 45 08             	incl   0x8(%ebp)
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	84 c0                	test   %al,%al
  800c8b:	75 e5                	jne    800c72 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c92:	c9                   	leave  
  800c93:	c3                   	ret    

00800c94 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c94:	55                   	push   %ebp
  800c95:	89 e5                	mov    %esp,%ebp
  800c97:	83 ec 04             	sub    $0x4,%esp
  800c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ca0:	eb 0d                	jmp    800caf <strfind+0x1b>
		if (*s == c)
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800caa:	74 0e                	je     800cba <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cac:	ff 45 08             	incl   0x8(%ebp)
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	84 c0                	test   %al,%al
  800cb6:	75 ea                	jne    800ca2 <strfind+0xe>
  800cb8:	eb 01                	jmp    800cbb <strfind+0x27>
		if (*s == c)
			break;
  800cba:	90                   	nop
	return (char *) s;
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cbe:	c9                   	leave  
  800cbf:	c3                   	ret    

00800cc0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800cc0:	55                   	push   %ebp
  800cc1:	89 e5                	mov    %esp,%ebp
  800cc3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ccc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800cd2:	eb 0e                	jmp    800ce2 <memset+0x22>
		*p++ = c;
  800cd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd7:	8d 50 01             	lea    0x1(%eax),%edx
  800cda:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ce2:	ff 4d f8             	decl   -0x8(%ebp)
  800ce5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ce9:	79 e9                	jns    800cd4 <memset+0x14>
		*p++ = c;

	return v;
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cee:	c9                   	leave  
  800cef:	c3                   	ret    

00800cf0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800cf0:	55                   	push   %ebp
  800cf1:	89 e5                	mov    %esp,%ebp
  800cf3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d02:	eb 16                	jmp    800d1a <memcpy+0x2a>
		*d++ = *s++;
  800d04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d07:	8d 50 01             	lea    0x1(%eax),%edx
  800d0a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d10:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d13:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d16:	8a 12                	mov    (%edx),%dl
  800d18:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d20:	89 55 10             	mov    %edx,0x10(%ebp)
  800d23:	85 c0                	test   %eax,%eax
  800d25:	75 dd                	jne    800d04 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d2a:	c9                   	leave  
  800d2b:	c3                   	ret    

00800d2c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d2c:	55                   	push   %ebp
  800d2d:	89 e5                	mov    %esp,%ebp
  800d2f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d41:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d44:	73 50                	jae    800d96 <memmove+0x6a>
  800d46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d49:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4c:	01 d0                	add    %edx,%eax
  800d4e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d51:	76 43                	jbe    800d96 <memmove+0x6a>
		s += n;
  800d53:	8b 45 10             	mov    0x10(%ebp),%eax
  800d56:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d59:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d5f:	eb 10                	jmp    800d71 <memmove+0x45>
			*--d = *--s;
  800d61:	ff 4d f8             	decl   -0x8(%ebp)
  800d64:	ff 4d fc             	decl   -0x4(%ebp)
  800d67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d6a:	8a 10                	mov    (%eax),%dl
  800d6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d71:	8b 45 10             	mov    0x10(%ebp),%eax
  800d74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d77:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7a:	85 c0                	test   %eax,%eax
  800d7c:	75 e3                	jne    800d61 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d7e:	eb 23                	jmp    800da3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d83:	8d 50 01             	lea    0x1(%eax),%edx
  800d86:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d8c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d8f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d92:	8a 12                	mov    (%edx),%dl
  800d94:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d9c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d9f:	85 c0                	test   %eax,%eax
  800da1:	75 dd                	jne    800d80 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800da8:	55                   	push   %ebp
  800da9:	89 e5                	mov    %esp,%ebp
  800dab:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800db4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dba:	eb 2a                	jmp    800de6 <memcmp+0x3e>
		if (*s1 != *s2)
  800dbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbf:	8a 10                	mov    (%eax),%dl
  800dc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	38 c2                	cmp    %al,%dl
  800dc8:	74 16                	je     800de0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800dca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcd:	8a 00                	mov    (%eax),%al
  800dcf:	0f b6 d0             	movzbl %al,%edx
  800dd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	0f b6 c0             	movzbl %al,%eax
  800dda:	29 c2                	sub    %eax,%edx
  800ddc:	89 d0                	mov    %edx,%eax
  800dde:	eb 18                	jmp    800df8 <memcmp+0x50>
		s1++, s2++;
  800de0:	ff 45 fc             	incl   -0x4(%ebp)
  800de3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800de6:	8b 45 10             	mov    0x10(%ebp),%eax
  800de9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dec:	89 55 10             	mov    %edx,0x10(%ebp)
  800def:	85 c0                	test   %eax,%eax
  800df1:	75 c9                	jne    800dbc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800df3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800df8:	c9                   	leave  
  800df9:	c3                   	ret    

00800dfa <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800dfa:	55                   	push   %ebp
  800dfb:	89 e5                	mov    %esp,%ebp
  800dfd:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e00:	8b 55 08             	mov    0x8(%ebp),%edx
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	01 d0                	add    %edx,%eax
  800e08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e0b:	eb 15                	jmp    800e22 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e10:	8a 00                	mov    (%eax),%al
  800e12:	0f b6 d0             	movzbl %al,%edx
  800e15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e18:	0f b6 c0             	movzbl %al,%eax
  800e1b:	39 c2                	cmp    %eax,%edx
  800e1d:	74 0d                	je     800e2c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e28:	72 e3                	jb     800e0d <memfind+0x13>
  800e2a:	eb 01                	jmp    800e2d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e2c:	90                   	nop
	return (void *) s;
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e30:	c9                   	leave  
  800e31:	c3                   	ret    

00800e32 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e32:	55                   	push   %ebp
  800e33:	89 e5                	mov    %esp,%ebp
  800e35:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e3f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e46:	eb 03                	jmp    800e4b <strtol+0x19>
		s++;
  800e48:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	3c 20                	cmp    $0x20,%al
  800e52:	74 f4                	je     800e48 <strtol+0x16>
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	3c 09                	cmp    $0x9,%al
  800e5b:	74 eb                	je     800e48 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	8a 00                	mov    (%eax),%al
  800e62:	3c 2b                	cmp    $0x2b,%al
  800e64:	75 05                	jne    800e6b <strtol+0x39>
		s++;
  800e66:	ff 45 08             	incl   0x8(%ebp)
  800e69:	eb 13                	jmp    800e7e <strtol+0x4c>
	else if (*s == '-')
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	3c 2d                	cmp    $0x2d,%al
  800e72:	75 0a                	jne    800e7e <strtol+0x4c>
		s++, neg = 1;
  800e74:	ff 45 08             	incl   0x8(%ebp)
  800e77:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e82:	74 06                	je     800e8a <strtol+0x58>
  800e84:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e88:	75 20                	jne    800eaa <strtol+0x78>
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	3c 30                	cmp    $0x30,%al
  800e91:	75 17                	jne    800eaa <strtol+0x78>
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	40                   	inc    %eax
  800e97:	8a 00                	mov    (%eax),%al
  800e99:	3c 78                	cmp    $0x78,%al
  800e9b:	75 0d                	jne    800eaa <strtol+0x78>
		s += 2, base = 16;
  800e9d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ea1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ea8:	eb 28                	jmp    800ed2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800eaa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eae:	75 15                	jne    800ec5 <strtol+0x93>
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	3c 30                	cmp    $0x30,%al
  800eb7:	75 0c                	jne    800ec5 <strtol+0x93>
		s++, base = 8;
  800eb9:	ff 45 08             	incl   0x8(%ebp)
  800ebc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ec3:	eb 0d                	jmp    800ed2 <strtol+0xa0>
	else if (base == 0)
  800ec5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec9:	75 07                	jne    800ed2 <strtol+0xa0>
		base = 10;
  800ecb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	3c 2f                	cmp    $0x2f,%al
  800ed9:	7e 19                	jle    800ef4 <strtol+0xc2>
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	3c 39                	cmp    $0x39,%al
  800ee2:	7f 10                	jg     800ef4 <strtol+0xc2>
			dig = *s - '0';
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	0f be c0             	movsbl %al,%eax
  800eec:	83 e8 30             	sub    $0x30,%eax
  800eef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ef2:	eb 42                	jmp    800f36 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	8a 00                	mov    (%eax),%al
  800ef9:	3c 60                	cmp    $0x60,%al
  800efb:	7e 19                	jle    800f16 <strtol+0xe4>
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	3c 7a                	cmp    $0x7a,%al
  800f04:	7f 10                	jg     800f16 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8a 00                	mov    (%eax),%al
  800f0b:	0f be c0             	movsbl %al,%eax
  800f0e:	83 e8 57             	sub    $0x57,%eax
  800f11:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f14:	eb 20                	jmp    800f36 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	3c 40                	cmp    $0x40,%al
  800f1d:	7e 39                	jle    800f58 <strtol+0x126>
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	3c 5a                	cmp    $0x5a,%al
  800f26:	7f 30                	jg     800f58 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	0f be c0             	movsbl %al,%eax
  800f30:	83 e8 37             	sub    $0x37,%eax
  800f33:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f39:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f3c:	7d 19                	jge    800f57 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f3e:	ff 45 08             	incl   0x8(%ebp)
  800f41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f44:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f48:	89 c2                	mov    %eax,%edx
  800f4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f4d:	01 d0                	add    %edx,%eax
  800f4f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f52:	e9 7b ff ff ff       	jmp    800ed2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f57:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f5c:	74 08                	je     800f66 <strtol+0x134>
		*endptr = (char *) s;
  800f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f61:	8b 55 08             	mov    0x8(%ebp),%edx
  800f64:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f66:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f6a:	74 07                	je     800f73 <strtol+0x141>
  800f6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f6f:	f7 d8                	neg    %eax
  800f71:	eb 03                	jmp    800f76 <strtol+0x144>
  800f73:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f76:	c9                   	leave  
  800f77:	c3                   	ret    

00800f78 <ltostr>:

void
ltostr(long value, char *str)
{
  800f78:	55                   	push   %ebp
  800f79:	89 e5                	mov    %esp,%ebp
  800f7b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f85:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f8c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f90:	79 13                	jns    800fa5 <ltostr+0x2d>
	{
		neg = 1;
  800f92:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f9f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800fa2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fad:	99                   	cltd   
  800fae:	f7 f9                	idiv   %ecx
  800fb0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb6:	8d 50 01             	lea    0x1(%eax),%edx
  800fb9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbc:	89 c2                	mov    %eax,%edx
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	01 d0                	add    %edx,%eax
  800fc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fc6:	83 c2 30             	add    $0x30,%edx
  800fc9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fcb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fce:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fd3:	f7 e9                	imul   %ecx
  800fd5:	c1 fa 02             	sar    $0x2,%edx
  800fd8:	89 c8                	mov    %ecx,%eax
  800fda:	c1 f8 1f             	sar    $0x1f,%eax
  800fdd:	29 c2                	sub    %eax,%edx
  800fdf:	89 d0                	mov    %edx,%eax
  800fe1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800fe4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fe7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fec:	f7 e9                	imul   %ecx
  800fee:	c1 fa 02             	sar    $0x2,%edx
  800ff1:	89 c8                	mov    %ecx,%eax
  800ff3:	c1 f8 1f             	sar    $0x1f,%eax
  800ff6:	29 c2                	sub    %eax,%edx
  800ff8:	89 d0                	mov    %edx,%eax
  800ffa:	c1 e0 02             	shl    $0x2,%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	01 c0                	add    %eax,%eax
  801001:	29 c1                	sub    %eax,%ecx
  801003:	89 ca                	mov    %ecx,%edx
  801005:	85 d2                	test   %edx,%edx
  801007:	75 9c                	jne    800fa5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801009:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801010:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801013:	48                   	dec    %eax
  801014:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801017:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80101b:	74 3d                	je     80105a <ltostr+0xe2>
		start = 1 ;
  80101d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801024:	eb 34                	jmp    80105a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801026:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801029:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102c:	01 d0                	add    %edx,%eax
  80102e:	8a 00                	mov    (%eax),%al
  801030:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801033:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	01 c2                	add    %eax,%edx
  80103b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80103e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801041:	01 c8                	add    %ecx,%eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801047:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	01 c2                	add    %eax,%edx
  80104f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801052:	88 02                	mov    %al,(%edx)
		start++ ;
  801054:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801057:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80105a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80105d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801060:	7c c4                	jl     801026 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801062:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801065:	8b 45 0c             	mov    0xc(%ebp),%eax
  801068:	01 d0                	add    %edx,%eax
  80106a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80106d:	90                   	nop
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
  801073:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801076:	ff 75 08             	pushl  0x8(%ebp)
  801079:	e8 54 fa ff ff       	call   800ad2 <strlen>
  80107e:	83 c4 04             	add    $0x4,%esp
  801081:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801084:	ff 75 0c             	pushl  0xc(%ebp)
  801087:	e8 46 fa ff ff       	call   800ad2 <strlen>
  80108c:	83 c4 04             	add    $0x4,%esp
  80108f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801092:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801099:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010a0:	eb 17                	jmp    8010b9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a8:	01 c2                	add    %eax,%edx
  8010aa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	01 c8                	add    %ecx,%eax
  8010b2:	8a 00                	mov    (%eax),%al
  8010b4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010b6:	ff 45 fc             	incl   -0x4(%ebp)
  8010b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010bf:	7c e1                	jl     8010a2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010c8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010cf:	eb 1f                	jmp    8010f0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d4:	8d 50 01             	lea    0x1(%eax),%edx
  8010d7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010da:	89 c2                	mov    %eax,%edx
  8010dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010df:	01 c2                	add    %eax,%edx
  8010e1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e7:	01 c8                	add    %ecx,%eax
  8010e9:	8a 00                	mov    (%eax),%al
  8010eb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8010ed:	ff 45 f8             	incl   -0x8(%ebp)
  8010f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010f6:	7c d9                	jl     8010d1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8010f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fe:	01 d0                	add    %edx,%eax
  801100:	c6 00 00             	movb   $0x0,(%eax)
}
  801103:	90                   	nop
  801104:	c9                   	leave  
  801105:	c3                   	ret    

00801106 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801106:	55                   	push   %ebp
  801107:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801109:	8b 45 14             	mov    0x14(%ebp),%eax
  80110c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801112:	8b 45 14             	mov    0x14(%ebp),%eax
  801115:	8b 00                	mov    (%eax),%eax
  801117:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80111e:	8b 45 10             	mov    0x10(%ebp),%eax
  801121:	01 d0                	add    %edx,%eax
  801123:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801129:	eb 0c                	jmp    801137 <strsplit+0x31>
			*string++ = 0;
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8d 50 01             	lea    0x1(%eax),%edx
  801131:	89 55 08             	mov    %edx,0x8(%ebp)
  801134:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
  80113a:	8a 00                	mov    (%eax),%al
  80113c:	84 c0                	test   %al,%al
  80113e:	74 18                	je     801158 <strsplit+0x52>
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	0f be c0             	movsbl %al,%eax
  801148:	50                   	push   %eax
  801149:	ff 75 0c             	pushl  0xc(%ebp)
  80114c:	e8 13 fb ff ff       	call   800c64 <strchr>
  801151:	83 c4 08             	add    $0x8,%esp
  801154:	85 c0                	test   %eax,%eax
  801156:	75 d3                	jne    80112b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	84 c0                	test   %al,%al
  80115f:	74 5a                	je     8011bb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801161:	8b 45 14             	mov    0x14(%ebp),%eax
  801164:	8b 00                	mov    (%eax),%eax
  801166:	83 f8 0f             	cmp    $0xf,%eax
  801169:	75 07                	jne    801172 <strsplit+0x6c>
		{
			return 0;
  80116b:	b8 00 00 00 00       	mov    $0x0,%eax
  801170:	eb 66                	jmp    8011d8 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801172:	8b 45 14             	mov    0x14(%ebp),%eax
  801175:	8b 00                	mov    (%eax),%eax
  801177:	8d 48 01             	lea    0x1(%eax),%ecx
  80117a:	8b 55 14             	mov    0x14(%ebp),%edx
  80117d:	89 0a                	mov    %ecx,(%edx)
  80117f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801186:	8b 45 10             	mov    0x10(%ebp),%eax
  801189:	01 c2                	add    %eax,%edx
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801190:	eb 03                	jmp    801195 <strsplit+0x8f>
			string++;
  801192:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	84 c0                	test   %al,%al
  80119c:	74 8b                	je     801129 <strsplit+0x23>
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f be c0             	movsbl %al,%eax
  8011a6:	50                   	push   %eax
  8011a7:	ff 75 0c             	pushl  0xc(%ebp)
  8011aa:	e8 b5 fa ff ff       	call   800c64 <strchr>
  8011af:	83 c4 08             	add    $0x8,%esp
  8011b2:	85 c0                	test   %eax,%eax
  8011b4:	74 dc                	je     801192 <strsplit+0x8c>
			string++;
	}
  8011b6:	e9 6e ff ff ff       	jmp    801129 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011bb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bf:	8b 00                	mov    (%eax),%eax
  8011c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011cb:	01 d0                	add    %edx,%eax
  8011cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011d3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011d8:	c9                   	leave  
  8011d9:	c3                   	ret    

008011da <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011da:	55                   	push   %ebp
  8011db:	89 e5                	mov    %esp,%ebp
  8011dd:	57                   	push   %edi
  8011de:	56                   	push   %esi
  8011df:	53                   	push   %ebx
  8011e0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011ef:	8b 7d 18             	mov    0x18(%ebp),%edi
  8011f2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8011f5:	cd 30                	int    $0x30
  8011f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8011fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011fd:	83 c4 10             	add    $0x10,%esp
  801200:	5b                   	pop    %ebx
  801201:	5e                   	pop    %esi
  801202:	5f                   	pop    %edi
  801203:	5d                   	pop    %ebp
  801204:	c3                   	ret    

00801205 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
  801208:	83 ec 04             	sub    $0x4,%esp
  80120b:	8b 45 10             	mov    0x10(%ebp),%eax
  80120e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801211:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	52                   	push   %edx
  80121d:	ff 75 0c             	pushl  0xc(%ebp)
  801220:	50                   	push   %eax
  801221:	6a 00                	push   $0x0
  801223:	e8 b2 ff ff ff       	call   8011da <syscall>
  801228:	83 c4 18             	add    $0x18,%esp
}
  80122b:	90                   	nop
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <sys_cgetc>:

int
sys_cgetc(void)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 01                	push   $0x1
  80123d:	e8 98 ff ff ff       	call   8011da <syscall>
  801242:	83 c4 18             	add    $0x18,%esp
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	50                   	push   %eax
  801256:	6a 05                	push   $0x5
  801258:	e8 7d ff ff ff       	call   8011da <syscall>
  80125d:	83 c4 18             	add    $0x18,%esp
}
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 02                	push   $0x2
  801271:	e8 64 ff ff ff       	call   8011da <syscall>
  801276:	83 c4 18             	add    $0x18,%esp
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 03                	push   $0x3
  80128a:	e8 4b ff ff ff       	call   8011da <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 04                	push   $0x4
  8012a3:	e8 32 ff ff ff       	call   8011da <syscall>
  8012a8:	83 c4 18             	add    $0x18,%esp
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_env_exit>:


void sys_env_exit(void)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 06                	push   $0x6
  8012bc:	e8 19 ff ff ff       	call   8011da <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	90                   	nop
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	52                   	push   %edx
  8012d7:	50                   	push   %eax
  8012d8:	6a 07                	push   $0x7
  8012da:	e8 fb fe ff ff       	call   8011da <syscall>
  8012df:	83 c4 18             	add    $0x18,%esp
}
  8012e2:	c9                   	leave  
  8012e3:	c3                   	ret    

008012e4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012e4:	55                   	push   %ebp
  8012e5:	89 e5                	mov    %esp,%ebp
  8012e7:	56                   	push   %esi
  8012e8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8012e9:	8b 75 18             	mov    0x18(%ebp),%esi
  8012ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	56                   	push   %esi
  8012f9:	53                   	push   %ebx
  8012fa:	51                   	push   %ecx
  8012fb:	52                   	push   %edx
  8012fc:	50                   	push   %eax
  8012fd:	6a 08                	push   $0x8
  8012ff:	e8 d6 fe ff ff       	call   8011da <syscall>
  801304:	83 c4 18             	add    $0x18,%esp
}
  801307:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80130a:	5b                   	pop    %ebx
  80130b:	5e                   	pop    %esi
  80130c:	5d                   	pop    %ebp
  80130d:	c3                   	ret    

0080130e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801311:	8b 55 0c             	mov    0xc(%ebp),%edx
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	52                   	push   %edx
  80131e:	50                   	push   %eax
  80131f:	6a 09                	push   $0x9
  801321:	e8 b4 fe ff ff       	call   8011da <syscall>
  801326:	83 c4 18             	add    $0x18,%esp
}
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	ff 75 0c             	pushl  0xc(%ebp)
  801337:	ff 75 08             	pushl  0x8(%ebp)
  80133a:	6a 0a                	push   $0xa
  80133c:	e8 99 fe ff ff       	call   8011da <syscall>
  801341:	83 c4 18             	add    $0x18,%esp
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 0b                	push   $0xb
  801355:	e8 80 fe ff ff       	call   8011da <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 0c                	push   $0xc
  80136e:	e8 67 fe ff ff       	call   8011da <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 0d                	push   $0xd
  801387:	e8 4e fe ff ff       	call   8011da <syscall>
  80138c:	83 c4 18             	add    $0x18,%esp
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	ff 75 0c             	pushl  0xc(%ebp)
  80139d:	ff 75 08             	pushl  0x8(%ebp)
  8013a0:	6a 11                	push   $0x11
  8013a2:	e8 33 fe ff ff       	call   8011da <syscall>
  8013a7:	83 c4 18             	add    $0x18,%esp
	return;
  8013aa:	90                   	nop
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	ff 75 0c             	pushl  0xc(%ebp)
  8013b9:	ff 75 08             	pushl  0x8(%ebp)
  8013bc:	6a 12                	push   $0x12
  8013be:	e8 17 fe ff ff       	call   8011da <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8013c6:	90                   	nop
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 0e                	push   $0xe
  8013d8:	e8 fd fd ff ff       	call   8011da <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	ff 75 08             	pushl  0x8(%ebp)
  8013f0:	6a 0f                	push   $0xf
  8013f2:	e8 e3 fd ff ff       	call   8011da <syscall>
  8013f7:	83 c4 18             	add    $0x18,%esp
}
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 10                	push   $0x10
  80140b:	e8 ca fd ff ff       	call   8011da <syscall>
  801410:	83 c4 18             	add    $0x18,%esp
}
  801413:	90                   	nop
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 14                	push   $0x14
  801425:	e8 b0 fd ff ff       	call   8011da <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	90                   	nop
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 15                	push   $0x15
  80143f:	e8 96 fd ff ff       	call   8011da <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	90                   	nop
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <sys_cputc>:


void
sys_cputc(const char c)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
  80144d:	83 ec 04             	sub    $0x4,%esp
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801456:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	50                   	push   %eax
  801463:	6a 16                	push   $0x16
  801465:	e8 70 fd ff ff       	call   8011da <syscall>
  80146a:	83 c4 18             	add    $0x18,%esp
}
  80146d:	90                   	nop
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 17                	push   $0x17
  80147f:	e8 56 fd ff ff       	call   8011da <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
}
  801487:	90                   	nop
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	ff 75 0c             	pushl  0xc(%ebp)
  801499:	50                   	push   %eax
  80149a:	6a 18                	push   $0x18
  80149c:	e8 39 fd ff ff       	call   8011da <syscall>
  8014a1:	83 c4 18             	add    $0x18,%esp
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	52                   	push   %edx
  8014b6:	50                   	push   %eax
  8014b7:	6a 1b                	push   $0x1b
  8014b9:	e8 1c fd ff ff       	call   8011da <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
}
  8014c1:	c9                   	leave  
  8014c2:	c3                   	ret    

008014c3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014c3:	55                   	push   %ebp
  8014c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	52                   	push   %edx
  8014d3:	50                   	push   %eax
  8014d4:	6a 19                	push   $0x19
  8014d6:	e8 ff fc ff ff       	call   8011da <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	90                   	nop
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	52                   	push   %edx
  8014f1:	50                   	push   %eax
  8014f2:	6a 1a                	push   $0x1a
  8014f4:	e8 e1 fc ff ff       	call   8011da <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	90                   	nop
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	8b 45 10             	mov    0x10(%ebp),%eax
  801508:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80150b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80150e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	6a 00                	push   $0x0
  801517:	51                   	push   %ecx
  801518:	52                   	push   %edx
  801519:	ff 75 0c             	pushl  0xc(%ebp)
  80151c:	50                   	push   %eax
  80151d:	6a 1c                	push   $0x1c
  80151f:	e8 b6 fc ff ff       	call   8011da <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80152c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	52                   	push   %edx
  801539:	50                   	push   %eax
  80153a:	6a 1d                	push   $0x1d
  80153c:	e8 99 fc ff ff       	call   8011da <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801549:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80154c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	51                   	push   %ecx
  801557:	52                   	push   %edx
  801558:	50                   	push   %eax
  801559:	6a 1e                	push   $0x1e
  80155b:	e8 7a fc ff ff       	call   8011da <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801568:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	52                   	push   %edx
  801575:	50                   	push   %eax
  801576:	6a 1f                	push   $0x1f
  801578:	e8 5d fc ff ff       	call   8011da <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 20                	push   $0x20
  801591:	e8 44 fc ff ff       	call   8011da <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	ff 75 10             	pushl  0x10(%ebp)
  8015a8:	ff 75 0c             	pushl  0xc(%ebp)
  8015ab:	50                   	push   %eax
  8015ac:	6a 21                	push   $0x21
  8015ae:	e8 27 fc ff ff       	call   8011da <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	50                   	push   %eax
  8015c7:	6a 22                	push   $0x22
  8015c9:	e8 0c fc ff ff       	call   8011da <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
}
  8015d1:	90                   	nop
  8015d2:	c9                   	leave  
  8015d3:	c3                   	ret    

008015d4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015d4:	55                   	push   %ebp
  8015d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	50                   	push   %eax
  8015e3:	6a 23                	push   $0x23
  8015e5:	e8 f0 fb ff ff       	call   8011da <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	90                   	nop
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
  8015f3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8015f6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015f9:	8d 50 04             	lea    0x4(%eax),%edx
  8015fc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	52                   	push   %edx
  801606:	50                   	push   %eax
  801607:	6a 24                	push   $0x24
  801609:	e8 cc fb ff ff       	call   8011da <syscall>
  80160e:	83 c4 18             	add    $0x18,%esp
	return result;
  801611:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801614:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801617:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161a:	89 01                	mov    %eax,(%ecx)
  80161c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	c9                   	leave  
  801623:	c2 04 00             	ret    $0x4

00801626 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	ff 75 10             	pushl  0x10(%ebp)
  801630:	ff 75 0c             	pushl  0xc(%ebp)
  801633:	ff 75 08             	pushl  0x8(%ebp)
  801636:	6a 13                	push   $0x13
  801638:	e8 9d fb ff ff       	call   8011da <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
	return ;
  801640:	90                   	nop
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_rcr2>:
uint32 sys_rcr2()
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 25                	push   $0x25
  801652:	e8 83 fb ff ff       	call   8011da <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
  80165f:	83 ec 04             	sub    $0x4,%esp
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801668:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	50                   	push   %eax
  801675:	6a 26                	push   $0x26
  801677:	e8 5e fb ff ff       	call   8011da <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
	return ;
  80167f:	90                   	nop
}
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <rsttst>:
void rsttst()
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 28                	push   $0x28
  801691:	e8 44 fb ff ff       	call   8011da <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
	return ;
  801699:	90                   	nop
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 04             	sub    $0x4,%esp
  8016a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016a8:	8b 55 18             	mov    0x18(%ebp),%edx
  8016ab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016af:	52                   	push   %edx
  8016b0:	50                   	push   %eax
  8016b1:	ff 75 10             	pushl  0x10(%ebp)
  8016b4:	ff 75 0c             	pushl  0xc(%ebp)
  8016b7:	ff 75 08             	pushl  0x8(%ebp)
  8016ba:	6a 27                	push   $0x27
  8016bc:	e8 19 fb ff ff       	call   8011da <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c4:	90                   	nop
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <chktst>:
void chktst(uint32 n)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	ff 75 08             	pushl  0x8(%ebp)
  8016d5:	6a 29                	push   $0x29
  8016d7:	e8 fe fa ff ff       	call   8011da <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8016df:	90                   	nop
}
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <inctst>:

void inctst()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 2a                	push   $0x2a
  8016f1:	e8 e4 fa ff ff       	call   8011da <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f9:	90                   	nop
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <gettst>:
uint32 gettst()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 2b                	push   $0x2b
  80170b:	e8 ca fa ff ff       	call   8011da <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
}
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
  801718:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 2c                	push   $0x2c
  801727:	e8 ae fa ff ff       	call   8011da <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
  80172f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801732:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801736:	75 07                	jne    80173f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801738:	b8 01 00 00 00       	mov    $0x1,%eax
  80173d:	eb 05                	jmp    801744 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80173f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 2c                	push   $0x2c
  801758:	e8 7d fa ff ff       	call   8011da <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
  801760:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801763:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801767:	75 07                	jne    801770 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801769:	b8 01 00 00 00       	mov    $0x1,%eax
  80176e:	eb 05                	jmp    801775 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801770:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
  80177a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 2c                	push   $0x2c
  801789:	e8 4c fa ff ff       	call   8011da <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
  801791:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801794:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801798:	75 07                	jne    8017a1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80179a:	b8 01 00 00 00       	mov    $0x1,%eax
  80179f:	eb 05                	jmp    8017a6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a6:	c9                   	leave  
  8017a7:	c3                   	ret    

008017a8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017a8:	55                   	push   %ebp
  8017a9:	89 e5                	mov    %esp,%ebp
  8017ab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 2c                	push   $0x2c
  8017ba:	e8 1b fa ff ff       	call   8011da <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
  8017c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017c5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017c9:	75 07                	jne    8017d2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017cb:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d0:	eb 05                	jmp    8017d7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	ff 75 08             	pushl  0x8(%ebp)
  8017e7:	6a 2d                	push   $0x2d
  8017e9:	e8 ec f9 ff ff       	call   8011da <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f1:	90                   	nop
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <__udivdi3>:
  8017f4:	55                   	push   %ebp
  8017f5:	57                   	push   %edi
  8017f6:	56                   	push   %esi
  8017f7:	53                   	push   %ebx
  8017f8:	83 ec 1c             	sub    $0x1c,%esp
  8017fb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8017ff:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801803:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801807:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80180b:	89 ca                	mov    %ecx,%edx
  80180d:	89 f8                	mov    %edi,%eax
  80180f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801813:	85 f6                	test   %esi,%esi
  801815:	75 2d                	jne    801844 <__udivdi3+0x50>
  801817:	39 cf                	cmp    %ecx,%edi
  801819:	77 65                	ja     801880 <__udivdi3+0x8c>
  80181b:	89 fd                	mov    %edi,%ebp
  80181d:	85 ff                	test   %edi,%edi
  80181f:	75 0b                	jne    80182c <__udivdi3+0x38>
  801821:	b8 01 00 00 00       	mov    $0x1,%eax
  801826:	31 d2                	xor    %edx,%edx
  801828:	f7 f7                	div    %edi
  80182a:	89 c5                	mov    %eax,%ebp
  80182c:	31 d2                	xor    %edx,%edx
  80182e:	89 c8                	mov    %ecx,%eax
  801830:	f7 f5                	div    %ebp
  801832:	89 c1                	mov    %eax,%ecx
  801834:	89 d8                	mov    %ebx,%eax
  801836:	f7 f5                	div    %ebp
  801838:	89 cf                	mov    %ecx,%edi
  80183a:	89 fa                	mov    %edi,%edx
  80183c:	83 c4 1c             	add    $0x1c,%esp
  80183f:	5b                   	pop    %ebx
  801840:	5e                   	pop    %esi
  801841:	5f                   	pop    %edi
  801842:	5d                   	pop    %ebp
  801843:	c3                   	ret    
  801844:	39 ce                	cmp    %ecx,%esi
  801846:	77 28                	ja     801870 <__udivdi3+0x7c>
  801848:	0f bd fe             	bsr    %esi,%edi
  80184b:	83 f7 1f             	xor    $0x1f,%edi
  80184e:	75 40                	jne    801890 <__udivdi3+0x9c>
  801850:	39 ce                	cmp    %ecx,%esi
  801852:	72 0a                	jb     80185e <__udivdi3+0x6a>
  801854:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801858:	0f 87 9e 00 00 00    	ja     8018fc <__udivdi3+0x108>
  80185e:	b8 01 00 00 00       	mov    $0x1,%eax
  801863:	89 fa                	mov    %edi,%edx
  801865:	83 c4 1c             	add    $0x1c,%esp
  801868:	5b                   	pop    %ebx
  801869:	5e                   	pop    %esi
  80186a:	5f                   	pop    %edi
  80186b:	5d                   	pop    %ebp
  80186c:	c3                   	ret    
  80186d:	8d 76 00             	lea    0x0(%esi),%esi
  801870:	31 ff                	xor    %edi,%edi
  801872:	31 c0                	xor    %eax,%eax
  801874:	89 fa                	mov    %edi,%edx
  801876:	83 c4 1c             	add    $0x1c,%esp
  801879:	5b                   	pop    %ebx
  80187a:	5e                   	pop    %esi
  80187b:	5f                   	pop    %edi
  80187c:	5d                   	pop    %ebp
  80187d:	c3                   	ret    
  80187e:	66 90                	xchg   %ax,%ax
  801880:	89 d8                	mov    %ebx,%eax
  801882:	f7 f7                	div    %edi
  801884:	31 ff                	xor    %edi,%edi
  801886:	89 fa                	mov    %edi,%edx
  801888:	83 c4 1c             	add    $0x1c,%esp
  80188b:	5b                   	pop    %ebx
  80188c:	5e                   	pop    %esi
  80188d:	5f                   	pop    %edi
  80188e:	5d                   	pop    %ebp
  80188f:	c3                   	ret    
  801890:	bd 20 00 00 00       	mov    $0x20,%ebp
  801895:	89 eb                	mov    %ebp,%ebx
  801897:	29 fb                	sub    %edi,%ebx
  801899:	89 f9                	mov    %edi,%ecx
  80189b:	d3 e6                	shl    %cl,%esi
  80189d:	89 c5                	mov    %eax,%ebp
  80189f:	88 d9                	mov    %bl,%cl
  8018a1:	d3 ed                	shr    %cl,%ebp
  8018a3:	89 e9                	mov    %ebp,%ecx
  8018a5:	09 f1                	or     %esi,%ecx
  8018a7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8018ab:	89 f9                	mov    %edi,%ecx
  8018ad:	d3 e0                	shl    %cl,%eax
  8018af:	89 c5                	mov    %eax,%ebp
  8018b1:	89 d6                	mov    %edx,%esi
  8018b3:	88 d9                	mov    %bl,%cl
  8018b5:	d3 ee                	shr    %cl,%esi
  8018b7:	89 f9                	mov    %edi,%ecx
  8018b9:	d3 e2                	shl    %cl,%edx
  8018bb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018bf:	88 d9                	mov    %bl,%cl
  8018c1:	d3 e8                	shr    %cl,%eax
  8018c3:	09 c2                	or     %eax,%edx
  8018c5:	89 d0                	mov    %edx,%eax
  8018c7:	89 f2                	mov    %esi,%edx
  8018c9:	f7 74 24 0c          	divl   0xc(%esp)
  8018cd:	89 d6                	mov    %edx,%esi
  8018cf:	89 c3                	mov    %eax,%ebx
  8018d1:	f7 e5                	mul    %ebp
  8018d3:	39 d6                	cmp    %edx,%esi
  8018d5:	72 19                	jb     8018f0 <__udivdi3+0xfc>
  8018d7:	74 0b                	je     8018e4 <__udivdi3+0xf0>
  8018d9:	89 d8                	mov    %ebx,%eax
  8018db:	31 ff                	xor    %edi,%edi
  8018dd:	e9 58 ff ff ff       	jmp    80183a <__udivdi3+0x46>
  8018e2:	66 90                	xchg   %ax,%ax
  8018e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8018e8:	89 f9                	mov    %edi,%ecx
  8018ea:	d3 e2                	shl    %cl,%edx
  8018ec:	39 c2                	cmp    %eax,%edx
  8018ee:	73 e9                	jae    8018d9 <__udivdi3+0xe5>
  8018f0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8018f3:	31 ff                	xor    %edi,%edi
  8018f5:	e9 40 ff ff ff       	jmp    80183a <__udivdi3+0x46>
  8018fa:	66 90                	xchg   %ax,%ax
  8018fc:	31 c0                	xor    %eax,%eax
  8018fe:	e9 37 ff ff ff       	jmp    80183a <__udivdi3+0x46>
  801903:	90                   	nop

00801904 <__umoddi3>:
  801904:	55                   	push   %ebp
  801905:	57                   	push   %edi
  801906:	56                   	push   %esi
  801907:	53                   	push   %ebx
  801908:	83 ec 1c             	sub    $0x1c,%esp
  80190b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80190f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801913:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801917:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80191b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80191f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801923:	89 f3                	mov    %esi,%ebx
  801925:	89 fa                	mov    %edi,%edx
  801927:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80192b:	89 34 24             	mov    %esi,(%esp)
  80192e:	85 c0                	test   %eax,%eax
  801930:	75 1a                	jne    80194c <__umoddi3+0x48>
  801932:	39 f7                	cmp    %esi,%edi
  801934:	0f 86 a2 00 00 00    	jbe    8019dc <__umoddi3+0xd8>
  80193a:	89 c8                	mov    %ecx,%eax
  80193c:	89 f2                	mov    %esi,%edx
  80193e:	f7 f7                	div    %edi
  801940:	89 d0                	mov    %edx,%eax
  801942:	31 d2                	xor    %edx,%edx
  801944:	83 c4 1c             	add    $0x1c,%esp
  801947:	5b                   	pop    %ebx
  801948:	5e                   	pop    %esi
  801949:	5f                   	pop    %edi
  80194a:	5d                   	pop    %ebp
  80194b:	c3                   	ret    
  80194c:	39 f0                	cmp    %esi,%eax
  80194e:	0f 87 ac 00 00 00    	ja     801a00 <__umoddi3+0xfc>
  801954:	0f bd e8             	bsr    %eax,%ebp
  801957:	83 f5 1f             	xor    $0x1f,%ebp
  80195a:	0f 84 ac 00 00 00    	je     801a0c <__umoddi3+0x108>
  801960:	bf 20 00 00 00       	mov    $0x20,%edi
  801965:	29 ef                	sub    %ebp,%edi
  801967:	89 fe                	mov    %edi,%esi
  801969:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80196d:	89 e9                	mov    %ebp,%ecx
  80196f:	d3 e0                	shl    %cl,%eax
  801971:	89 d7                	mov    %edx,%edi
  801973:	89 f1                	mov    %esi,%ecx
  801975:	d3 ef                	shr    %cl,%edi
  801977:	09 c7                	or     %eax,%edi
  801979:	89 e9                	mov    %ebp,%ecx
  80197b:	d3 e2                	shl    %cl,%edx
  80197d:	89 14 24             	mov    %edx,(%esp)
  801980:	89 d8                	mov    %ebx,%eax
  801982:	d3 e0                	shl    %cl,%eax
  801984:	89 c2                	mov    %eax,%edx
  801986:	8b 44 24 08          	mov    0x8(%esp),%eax
  80198a:	d3 e0                	shl    %cl,%eax
  80198c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801990:	8b 44 24 08          	mov    0x8(%esp),%eax
  801994:	89 f1                	mov    %esi,%ecx
  801996:	d3 e8                	shr    %cl,%eax
  801998:	09 d0                	or     %edx,%eax
  80199a:	d3 eb                	shr    %cl,%ebx
  80199c:	89 da                	mov    %ebx,%edx
  80199e:	f7 f7                	div    %edi
  8019a0:	89 d3                	mov    %edx,%ebx
  8019a2:	f7 24 24             	mull   (%esp)
  8019a5:	89 c6                	mov    %eax,%esi
  8019a7:	89 d1                	mov    %edx,%ecx
  8019a9:	39 d3                	cmp    %edx,%ebx
  8019ab:	0f 82 87 00 00 00    	jb     801a38 <__umoddi3+0x134>
  8019b1:	0f 84 91 00 00 00    	je     801a48 <__umoddi3+0x144>
  8019b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8019bb:	29 f2                	sub    %esi,%edx
  8019bd:	19 cb                	sbb    %ecx,%ebx
  8019bf:	89 d8                	mov    %ebx,%eax
  8019c1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8019c5:	d3 e0                	shl    %cl,%eax
  8019c7:	89 e9                	mov    %ebp,%ecx
  8019c9:	d3 ea                	shr    %cl,%edx
  8019cb:	09 d0                	or     %edx,%eax
  8019cd:	89 e9                	mov    %ebp,%ecx
  8019cf:	d3 eb                	shr    %cl,%ebx
  8019d1:	89 da                	mov    %ebx,%edx
  8019d3:	83 c4 1c             	add    $0x1c,%esp
  8019d6:	5b                   	pop    %ebx
  8019d7:	5e                   	pop    %esi
  8019d8:	5f                   	pop    %edi
  8019d9:	5d                   	pop    %ebp
  8019da:	c3                   	ret    
  8019db:	90                   	nop
  8019dc:	89 fd                	mov    %edi,%ebp
  8019de:	85 ff                	test   %edi,%edi
  8019e0:	75 0b                	jne    8019ed <__umoddi3+0xe9>
  8019e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e7:	31 d2                	xor    %edx,%edx
  8019e9:	f7 f7                	div    %edi
  8019eb:	89 c5                	mov    %eax,%ebp
  8019ed:	89 f0                	mov    %esi,%eax
  8019ef:	31 d2                	xor    %edx,%edx
  8019f1:	f7 f5                	div    %ebp
  8019f3:	89 c8                	mov    %ecx,%eax
  8019f5:	f7 f5                	div    %ebp
  8019f7:	89 d0                	mov    %edx,%eax
  8019f9:	e9 44 ff ff ff       	jmp    801942 <__umoddi3+0x3e>
  8019fe:	66 90                	xchg   %ax,%ax
  801a00:	89 c8                	mov    %ecx,%eax
  801a02:	89 f2                	mov    %esi,%edx
  801a04:	83 c4 1c             	add    $0x1c,%esp
  801a07:	5b                   	pop    %ebx
  801a08:	5e                   	pop    %esi
  801a09:	5f                   	pop    %edi
  801a0a:	5d                   	pop    %ebp
  801a0b:	c3                   	ret    
  801a0c:	3b 04 24             	cmp    (%esp),%eax
  801a0f:	72 06                	jb     801a17 <__umoddi3+0x113>
  801a11:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a15:	77 0f                	ja     801a26 <__umoddi3+0x122>
  801a17:	89 f2                	mov    %esi,%edx
  801a19:	29 f9                	sub    %edi,%ecx
  801a1b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a1f:	89 14 24             	mov    %edx,(%esp)
  801a22:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a26:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a2a:	8b 14 24             	mov    (%esp),%edx
  801a2d:	83 c4 1c             	add    $0x1c,%esp
  801a30:	5b                   	pop    %ebx
  801a31:	5e                   	pop    %esi
  801a32:	5f                   	pop    %edi
  801a33:	5d                   	pop    %ebp
  801a34:	c3                   	ret    
  801a35:	8d 76 00             	lea    0x0(%esi),%esi
  801a38:	2b 04 24             	sub    (%esp),%eax
  801a3b:	19 fa                	sbb    %edi,%edx
  801a3d:	89 d1                	mov    %edx,%ecx
  801a3f:	89 c6                	mov    %eax,%esi
  801a41:	e9 71 ff ff ff       	jmp    8019b7 <__umoddi3+0xb3>
  801a46:	66 90                	xchg   %ax,%ax
  801a48:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a4c:	72 ea                	jb     801a38 <__umoddi3+0x134>
  801a4e:	89 d9                	mov    %ebx,%ecx
  801a50:	e9 62 ff ff ff       	jmp    8019b7 <__umoddi3+0xb3>
