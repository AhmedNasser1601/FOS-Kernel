
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 f9 00 00 00       	call   80012f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	char arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 9a 13 00 00       	call   8013e8 <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 15 14 00 00       	call   80146b <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 00 1b 80 00       	push   $0x801b00
  800088:	e8 65 04 00 00       	call   8004f2 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800097:	eb 2c                	jmp    8000c5 <_main+0x8d>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  800099:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  80009f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	8a 00                	mov    (%eax),%al
  8000a6:	3c ff                	cmp    $0xff,%al
  8000a8:	74 14                	je     8000be <_main+0x86>
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	68 38 1b 80 00       	push   $0x801b38
  8000b2:	6a 1a                	push   $0x1a
  8000b4:	68 68 1b 80 00       	push   $0x801b68
  8000b9:	e8 80 01 00 00       	call   80023e <_panic>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000be:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c5:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000cc:	7e cb                	jle    800099 <_main+0x61>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  9) panic("Unexpected extra/less pages have been added to page file");
  8000ce:	e8 98 13 00 00       	call   80146b <sys_pf_calculate_allocated_pages>
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 f8 09             	cmp    $0x9,%eax
  8000d9:	74 14                	je     8000ef <_main+0xb7>
  8000db:	83 ec 04             	sub    $0x4,%esp
  8000de:	68 8c 1b 80 00       	push   $0x801b8c
  8000e3:	6a 1c                	push   $0x1c
  8000e5:	68 68 1b 80 00       	push   $0x801b68
  8000ea:	e8 4f 01 00 00       	call   80023e <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000ef:	e8 f4 12 00 00       	call   8013e8 <sys_calculate_free_frames>
  8000f4:	89 c3                	mov    %eax,%ebx
  8000f6:	e8 06 13 00 00       	call   801401 <sys_calculate_modified_frames>
  8000fb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	39 c2                	cmp    %eax,%edx
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 c8 1b 80 00       	push   $0x801bc8
  80010d:	6a 1e                	push   $0x1e
  80010f:	68 68 1b 80 00       	push   $0x801b68
  800114:	e8 25 01 00 00       	call   80023e <_panic>
	}

	cprintf("Congratulations: stack pages created, modified and read successfully!\n\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 2c 1c 80 00       	push   $0x801c2c
  800121:	e8 cc 03 00 00       	call   8004f2 <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp


	return;
  800129:	90                   	nop
}
  80012a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800135:	e8 e3 11 00 00       	call   80131d <sys_getenvindex>
  80013a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80013d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800140:	89 d0                	mov    %edx,%eax
  800142:	c1 e0 02             	shl    $0x2,%eax
  800145:	01 d0                	add    %edx,%eax
  800147:	01 c0                	add    %eax,%eax
  800149:	01 d0                	add    %edx,%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800156:	01 d0                	add    %edx,%eax
  800158:	c1 e0 02             	shl    $0x2,%eax
  80015b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800160:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800165:	a1 04 30 80 00       	mov    0x803004,%eax
  80016a:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800170:	84 c0                	test   %al,%al
  800172:	74 0f                	je     800183 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800174:	a1 04 30 80 00       	mov    0x803004,%eax
  800179:	05 f4 02 00 00       	add    $0x2f4,%eax
  80017e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800183:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800187:	7e 0a                	jle    800193 <libmain+0x64>
		binaryname = argv[0];
  800189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018c:	8b 00                	mov    (%eax),%eax
  80018e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800193:	83 ec 08             	sub    $0x8,%esp
  800196:	ff 75 0c             	pushl  0xc(%ebp)
  800199:	ff 75 08             	pushl  0x8(%ebp)
  80019c:	e8 97 fe ff ff       	call   800038 <_main>
  8001a1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a4:	e8 0f 13 00 00       	call   8014b8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a9:	83 ec 0c             	sub    $0xc,%esp
  8001ac:	68 8c 1c 80 00       	push   $0x801c8c
  8001b1:	e8 3c 03 00 00       	call   8004f2 <cprintf>
  8001b6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b9:	a1 04 30 80 00       	mov    0x803004,%eax
  8001be:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001c4:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c9:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	52                   	push   %edx
  8001d3:	50                   	push   %eax
  8001d4:	68 b4 1c 80 00       	push   $0x801cb4
  8001d9:	e8 14 03 00 00       	call   8004f2 <cprintf>
  8001de:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001e1:	a1 04 30 80 00       	mov    0x803004,%eax
  8001e6:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001ec:	83 ec 08             	sub    $0x8,%esp
  8001ef:	50                   	push   %eax
  8001f0:	68 d9 1c 80 00       	push   $0x801cd9
  8001f5:	e8 f8 02 00 00       	call   8004f2 <cprintf>
  8001fa:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001fd:	83 ec 0c             	sub    $0xc,%esp
  800200:	68 8c 1c 80 00       	push   $0x801c8c
  800205:	e8 e8 02 00 00       	call   8004f2 <cprintf>
  80020a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80020d:	e8 c0 12 00 00       	call   8014d2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800212:	e8 19 00 00 00       	call   800230 <exit>
}
  800217:	90                   	nop
  800218:	c9                   	leave  
  800219:	c3                   	ret    

0080021a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80021a:	55                   	push   %ebp
  80021b:	89 e5                	mov    %esp,%ebp
  80021d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	6a 00                	push   $0x0
  800225:	e8 bf 10 00 00       	call   8012e9 <sys_env_destroy>
  80022a:	83 c4 10             	add    $0x10,%esp
}
  80022d:	90                   	nop
  80022e:	c9                   	leave  
  80022f:	c3                   	ret    

00800230 <exit>:

void
exit(void)
{
  800230:	55                   	push   %ebp
  800231:	89 e5                	mov    %esp,%ebp
  800233:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800236:	e8 14 11 00 00       	call   80134f <sys_env_exit>
}
  80023b:	90                   	nop
  80023c:	c9                   	leave  
  80023d:	c3                   	ret    

0080023e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80023e:	55                   	push   %ebp
  80023f:	89 e5                	mov    %esp,%ebp
  800241:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800244:	8d 45 10             	lea    0x10(%ebp),%eax
  800247:	83 c0 04             	add    $0x4,%eax
  80024a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80024d:	a1 14 30 80 00       	mov    0x803014,%eax
  800252:	85 c0                	test   %eax,%eax
  800254:	74 16                	je     80026c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800256:	a1 14 30 80 00       	mov    0x803014,%eax
  80025b:	83 ec 08             	sub    $0x8,%esp
  80025e:	50                   	push   %eax
  80025f:	68 f0 1c 80 00       	push   $0x801cf0
  800264:	e8 89 02 00 00       	call   8004f2 <cprintf>
  800269:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80026c:	a1 00 30 80 00       	mov    0x803000,%eax
  800271:	ff 75 0c             	pushl  0xc(%ebp)
  800274:	ff 75 08             	pushl  0x8(%ebp)
  800277:	50                   	push   %eax
  800278:	68 f5 1c 80 00       	push   $0x801cf5
  80027d:	e8 70 02 00 00       	call   8004f2 <cprintf>
  800282:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800285:	8b 45 10             	mov    0x10(%ebp),%eax
  800288:	83 ec 08             	sub    $0x8,%esp
  80028b:	ff 75 f4             	pushl  -0xc(%ebp)
  80028e:	50                   	push   %eax
  80028f:	e8 f3 01 00 00       	call   800487 <vcprintf>
  800294:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800297:	83 ec 08             	sub    $0x8,%esp
  80029a:	6a 00                	push   $0x0
  80029c:	68 11 1d 80 00       	push   $0x801d11
  8002a1:	e8 e1 01 00 00       	call   800487 <vcprintf>
  8002a6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002a9:	e8 82 ff ff ff       	call   800230 <exit>

	// should not return here
	while (1) ;
  8002ae:	eb fe                	jmp    8002ae <_panic+0x70>

008002b0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002b6:	a1 04 30 80 00       	mov    0x803004,%eax
  8002bb:	8b 50 74             	mov    0x74(%eax),%edx
  8002be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c1:	39 c2                	cmp    %eax,%edx
  8002c3:	74 14                	je     8002d9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	68 14 1d 80 00       	push   $0x801d14
  8002cd:	6a 26                	push   $0x26
  8002cf:	68 60 1d 80 00       	push   $0x801d60
  8002d4:	e8 65 ff ff ff       	call   80023e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002e7:	e9 c2 00 00 00       	jmp    8003ae <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	85 c0                	test   %eax,%eax
  8002ff:	75 08                	jne    800309 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800301:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800304:	e9 a2 00 00 00       	jmp    8003ab <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800309:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800310:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800317:	eb 69                	jmp    800382 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800319:	a1 04 30 80 00       	mov    0x803004,%eax
  80031e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800324:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800327:	89 d0                	mov    %edx,%eax
  800329:	01 c0                	add    %eax,%eax
  80032b:	01 d0                	add    %edx,%eax
  80032d:	c1 e0 02             	shl    $0x2,%eax
  800330:	01 c8                	add    %ecx,%eax
  800332:	8a 40 04             	mov    0x4(%eax),%al
  800335:	84 c0                	test   %al,%al
  800337:	75 46                	jne    80037f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800339:	a1 04 30 80 00       	mov    0x803004,%eax
  80033e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800344:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800347:	89 d0                	mov    %edx,%eax
  800349:	01 c0                	add    %eax,%eax
  80034b:	01 d0                	add    %edx,%eax
  80034d:	c1 e0 02             	shl    $0x2,%eax
  800350:	01 c8                	add    %ecx,%eax
  800352:	8b 00                	mov    (%eax),%eax
  800354:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800357:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80035a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800364:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	01 c8                	add    %ecx,%eax
  800370:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800372:	39 c2                	cmp    %eax,%edx
  800374:	75 09                	jne    80037f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800376:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80037d:	eb 12                	jmp    800391 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80037f:	ff 45 e8             	incl   -0x18(%ebp)
  800382:	a1 04 30 80 00       	mov    0x803004,%eax
  800387:	8b 50 74             	mov    0x74(%eax),%edx
  80038a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80038d:	39 c2                	cmp    %eax,%edx
  80038f:	77 88                	ja     800319 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800391:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800395:	75 14                	jne    8003ab <CheckWSWithoutLastIndex+0xfb>
			panic(
  800397:	83 ec 04             	sub    $0x4,%esp
  80039a:	68 6c 1d 80 00       	push   $0x801d6c
  80039f:	6a 3a                	push   $0x3a
  8003a1:	68 60 1d 80 00       	push   $0x801d60
  8003a6:	e8 93 fe ff ff       	call   80023e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003ab:	ff 45 f0             	incl   -0x10(%ebp)
  8003ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003b4:	0f 8c 32 ff ff ff    	jl     8002ec <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003c1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003c8:	eb 26                	jmp    8003f0 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003ca:	a1 04 30 80 00       	mov    0x803004,%eax
  8003cf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003d5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003d8:	89 d0                	mov    %edx,%eax
  8003da:	01 c0                	add    %eax,%eax
  8003dc:	01 d0                	add    %edx,%eax
  8003de:	c1 e0 02             	shl    $0x2,%eax
  8003e1:	01 c8                	add    %ecx,%eax
  8003e3:	8a 40 04             	mov    0x4(%eax),%al
  8003e6:	3c 01                	cmp    $0x1,%al
  8003e8:	75 03                	jne    8003ed <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003ea:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ed:	ff 45 e0             	incl   -0x20(%ebp)
  8003f0:	a1 04 30 80 00       	mov    0x803004,%eax
  8003f5:	8b 50 74             	mov    0x74(%eax),%edx
  8003f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003fb:	39 c2                	cmp    %eax,%edx
  8003fd:	77 cb                	ja     8003ca <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800402:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800405:	74 14                	je     80041b <CheckWSWithoutLastIndex+0x16b>
		panic(
  800407:	83 ec 04             	sub    $0x4,%esp
  80040a:	68 c0 1d 80 00       	push   $0x801dc0
  80040f:	6a 44                	push   $0x44
  800411:	68 60 1d 80 00       	push   $0x801d60
  800416:	e8 23 fe ff ff       	call   80023e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80041b:	90                   	nop
  80041c:	c9                   	leave  
  80041d:	c3                   	ret    

0080041e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80041e:	55                   	push   %ebp
  80041f:	89 e5                	mov    %esp,%ebp
  800421:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800424:	8b 45 0c             	mov    0xc(%ebp),%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	8d 48 01             	lea    0x1(%eax),%ecx
  80042c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80042f:	89 0a                	mov    %ecx,(%edx)
  800431:	8b 55 08             	mov    0x8(%ebp),%edx
  800434:	88 d1                	mov    %dl,%cl
  800436:	8b 55 0c             	mov    0xc(%ebp),%edx
  800439:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80043d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	3d ff 00 00 00       	cmp    $0xff,%eax
  800447:	75 2c                	jne    800475 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800449:	a0 08 30 80 00       	mov    0x803008,%al
  80044e:	0f b6 c0             	movzbl %al,%eax
  800451:	8b 55 0c             	mov    0xc(%ebp),%edx
  800454:	8b 12                	mov    (%edx),%edx
  800456:	89 d1                	mov    %edx,%ecx
  800458:	8b 55 0c             	mov    0xc(%ebp),%edx
  80045b:	83 c2 08             	add    $0x8,%edx
  80045e:	83 ec 04             	sub    $0x4,%esp
  800461:	50                   	push   %eax
  800462:	51                   	push   %ecx
  800463:	52                   	push   %edx
  800464:	e8 3e 0e 00 00       	call   8012a7 <sys_cputs>
  800469:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80046c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800475:	8b 45 0c             	mov    0xc(%ebp),%eax
  800478:	8b 40 04             	mov    0x4(%eax),%eax
  80047b:	8d 50 01             	lea    0x1(%eax),%edx
  80047e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800481:	89 50 04             	mov    %edx,0x4(%eax)
}
  800484:	90                   	nop
  800485:	c9                   	leave  
  800486:	c3                   	ret    

00800487 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800487:	55                   	push   %ebp
  800488:	89 e5                	mov    %esp,%ebp
  80048a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800490:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800497:	00 00 00 
	b.cnt = 0;
  80049a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004a1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004a4:	ff 75 0c             	pushl  0xc(%ebp)
  8004a7:	ff 75 08             	pushl  0x8(%ebp)
  8004aa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004b0:	50                   	push   %eax
  8004b1:	68 1e 04 80 00       	push   $0x80041e
  8004b6:	e8 11 02 00 00       	call   8006cc <vprintfmt>
  8004bb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004be:	a0 08 30 80 00       	mov    0x803008,%al
  8004c3:	0f b6 c0             	movzbl %al,%eax
  8004c6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004cc:	83 ec 04             	sub    $0x4,%esp
  8004cf:	50                   	push   %eax
  8004d0:	52                   	push   %edx
  8004d1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004d7:	83 c0 08             	add    $0x8,%eax
  8004da:	50                   	push   %eax
  8004db:	e8 c7 0d 00 00       	call   8012a7 <sys_cputs>
  8004e0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004e3:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8004ea:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004f0:	c9                   	leave  
  8004f1:	c3                   	ret    

008004f2 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004f2:	55                   	push   %ebp
  8004f3:	89 e5                	mov    %esp,%ebp
  8004f5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004f8:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8004ff:	8d 45 0c             	lea    0xc(%ebp),%eax
  800502:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800505:	8b 45 08             	mov    0x8(%ebp),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	ff 75 f4             	pushl  -0xc(%ebp)
  80050e:	50                   	push   %eax
  80050f:	e8 73 ff ff ff       	call   800487 <vcprintf>
  800514:	83 c4 10             	add    $0x10,%esp
  800517:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80051a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80051d:	c9                   	leave  
  80051e:	c3                   	ret    

0080051f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80051f:	55                   	push   %ebp
  800520:	89 e5                	mov    %esp,%ebp
  800522:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800525:	e8 8e 0f 00 00       	call   8014b8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80052a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80052d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800530:	8b 45 08             	mov    0x8(%ebp),%eax
  800533:	83 ec 08             	sub    $0x8,%esp
  800536:	ff 75 f4             	pushl  -0xc(%ebp)
  800539:	50                   	push   %eax
  80053a:	e8 48 ff ff ff       	call   800487 <vcprintf>
  80053f:	83 c4 10             	add    $0x10,%esp
  800542:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800545:	e8 88 0f 00 00       	call   8014d2 <sys_enable_interrupt>
	return cnt;
  80054a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80054d:	c9                   	leave  
  80054e:	c3                   	ret    

0080054f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80054f:	55                   	push   %ebp
  800550:	89 e5                	mov    %esp,%ebp
  800552:	53                   	push   %ebx
  800553:	83 ec 14             	sub    $0x14,%esp
  800556:	8b 45 10             	mov    0x10(%ebp),%eax
  800559:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80055c:	8b 45 14             	mov    0x14(%ebp),%eax
  80055f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800562:	8b 45 18             	mov    0x18(%ebp),%eax
  800565:	ba 00 00 00 00       	mov    $0x0,%edx
  80056a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80056d:	77 55                	ja     8005c4 <printnum+0x75>
  80056f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800572:	72 05                	jb     800579 <printnum+0x2a>
  800574:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800577:	77 4b                	ja     8005c4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800579:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80057c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80057f:	8b 45 18             	mov    0x18(%ebp),%eax
  800582:	ba 00 00 00 00       	mov    $0x0,%edx
  800587:	52                   	push   %edx
  800588:	50                   	push   %eax
  800589:	ff 75 f4             	pushl  -0xc(%ebp)
  80058c:	ff 75 f0             	pushl  -0x10(%ebp)
  80058f:	e8 04 13 00 00       	call   801898 <__udivdi3>
  800594:	83 c4 10             	add    $0x10,%esp
  800597:	83 ec 04             	sub    $0x4,%esp
  80059a:	ff 75 20             	pushl  0x20(%ebp)
  80059d:	53                   	push   %ebx
  80059e:	ff 75 18             	pushl  0x18(%ebp)
  8005a1:	52                   	push   %edx
  8005a2:	50                   	push   %eax
  8005a3:	ff 75 0c             	pushl  0xc(%ebp)
  8005a6:	ff 75 08             	pushl  0x8(%ebp)
  8005a9:	e8 a1 ff ff ff       	call   80054f <printnum>
  8005ae:	83 c4 20             	add    $0x20,%esp
  8005b1:	eb 1a                	jmp    8005cd <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005b3:	83 ec 08             	sub    $0x8,%esp
  8005b6:	ff 75 0c             	pushl  0xc(%ebp)
  8005b9:	ff 75 20             	pushl  0x20(%ebp)
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	ff d0                	call   *%eax
  8005c1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005c4:	ff 4d 1c             	decl   0x1c(%ebp)
  8005c7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005cb:	7f e6                	jg     8005b3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005cd:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005d0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005db:	53                   	push   %ebx
  8005dc:	51                   	push   %ecx
  8005dd:	52                   	push   %edx
  8005de:	50                   	push   %eax
  8005df:	e8 c4 13 00 00       	call   8019a8 <__umoddi3>
  8005e4:	83 c4 10             	add    $0x10,%esp
  8005e7:	05 34 20 80 00       	add    $0x802034,%eax
  8005ec:	8a 00                	mov    (%eax),%al
  8005ee:	0f be c0             	movsbl %al,%eax
  8005f1:	83 ec 08             	sub    $0x8,%esp
  8005f4:	ff 75 0c             	pushl  0xc(%ebp)
  8005f7:	50                   	push   %eax
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	ff d0                	call   *%eax
  8005fd:	83 c4 10             	add    $0x10,%esp
}
  800600:	90                   	nop
  800601:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800604:	c9                   	leave  
  800605:	c3                   	ret    

00800606 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800606:	55                   	push   %ebp
  800607:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800609:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80060d:	7e 1c                	jle    80062b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	8b 00                	mov    (%eax),%eax
  800614:	8d 50 08             	lea    0x8(%eax),%edx
  800617:	8b 45 08             	mov    0x8(%ebp),%eax
  80061a:	89 10                	mov    %edx,(%eax)
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	8b 00                	mov    (%eax),%eax
  800621:	83 e8 08             	sub    $0x8,%eax
  800624:	8b 50 04             	mov    0x4(%eax),%edx
  800627:	8b 00                	mov    (%eax),%eax
  800629:	eb 40                	jmp    80066b <getuint+0x65>
	else if (lflag)
  80062b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80062f:	74 1e                	je     80064f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	8b 00                	mov    (%eax),%eax
  800636:	8d 50 04             	lea    0x4(%eax),%edx
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	89 10                	mov    %edx,(%eax)
  80063e:	8b 45 08             	mov    0x8(%ebp),%eax
  800641:	8b 00                	mov    (%eax),%eax
  800643:	83 e8 04             	sub    $0x4,%eax
  800646:	8b 00                	mov    (%eax),%eax
  800648:	ba 00 00 00 00       	mov    $0x0,%edx
  80064d:	eb 1c                	jmp    80066b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	8b 00                	mov    (%eax),%eax
  800654:	8d 50 04             	lea    0x4(%eax),%edx
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	89 10                	mov    %edx,(%eax)
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	8b 00                	mov    (%eax),%eax
  800661:	83 e8 04             	sub    $0x4,%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80066b:	5d                   	pop    %ebp
  80066c:	c3                   	ret    

0080066d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80066d:	55                   	push   %ebp
  80066e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800670:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800674:	7e 1c                	jle    800692 <getint+0x25>
		return va_arg(*ap, long long);
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	8b 00                	mov    (%eax),%eax
  80067b:	8d 50 08             	lea    0x8(%eax),%edx
  80067e:	8b 45 08             	mov    0x8(%ebp),%eax
  800681:	89 10                	mov    %edx,(%eax)
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	8b 00                	mov    (%eax),%eax
  800688:	83 e8 08             	sub    $0x8,%eax
  80068b:	8b 50 04             	mov    0x4(%eax),%edx
  80068e:	8b 00                	mov    (%eax),%eax
  800690:	eb 38                	jmp    8006ca <getint+0x5d>
	else if (lflag)
  800692:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800696:	74 1a                	je     8006b2 <getint+0x45>
		return va_arg(*ap, long);
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	8b 00                	mov    (%eax),%eax
  80069d:	8d 50 04             	lea    0x4(%eax),%edx
  8006a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a3:	89 10                	mov    %edx,(%eax)
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	83 e8 04             	sub    $0x4,%eax
  8006ad:	8b 00                	mov    (%eax),%eax
  8006af:	99                   	cltd   
  8006b0:	eb 18                	jmp    8006ca <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	8d 50 04             	lea    0x4(%eax),%edx
  8006ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bd:	89 10                	mov    %edx,(%eax)
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	8b 00                	mov    (%eax),%eax
  8006c4:	83 e8 04             	sub    $0x4,%eax
  8006c7:	8b 00                	mov    (%eax),%eax
  8006c9:	99                   	cltd   
}
  8006ca:	5d                   	pop    %ebp
  8006cb:	c3                   	ret    

008006cc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	56                   	push   %esi
  8006d0:	53                   	push   %ebx
  8006d1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006d4:	eb 17                	jmp    8006ed <vprintfmt+0x21>
			if (ch == '\0')
  8006d6:	85 db                	test   %ebx,%ebx
  8006d8:	0f 84 af 03 00 00    	je     800a8d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006de:	83 ec 08             	sub    $0x8,%esp
  8006e1:	ff 75 0c             	pushl  0xc(%ebp)
  8006e4:	53                   	push   %ebx
  8006e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e8:	ff d0                	call   *%eax
  8006ea:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f0:	8d 50 01             	lea    0x1(%eax),%edx
  8006f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8006f6:	8a 00                	mov    (%eax),%al
  8006f8:	0f b6 d8             	movzbl %al,%ebx
  8006fb:	83 fb 25             	cmp    $0x25,%ebx
  8006fe:	75 d6                	jne    8006d6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800700:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800704:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80070b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800712:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800719:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800720:	8b 45 10             	mov    0x10(%ebp),%eax
  800723:	8d 50 01             	lea    0x1(%eax),%edx
  800726:	89 55 10             	mov    %edx,0x10(%ebp)
  800729:	8a 00                	mov    (%eax),%al
  80072b:	0f b6 d8             	movzbl %al,%ebx
  80072e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800731:	83 f8 55             	cmp    $0x55,%eax
  800734:	0f 87 2b 03 00 00    	ja     800a65 <vprintfmt+0x399>
  80073a:	8b 04 85 58 20 80 00 	mov    0x802058(,%eax,4),%eax
  800741:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800743:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800747:	eb d7                	jmp    800720 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800749:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80074d:	eb d1                	jmp    800720 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80074f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800756:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800759:	89 d0                	mov    %edx,%eax
  80075b:	c1 e0 02             	shl    $0x2,%eax
  80075e:	01 d0                	add    %edx,%eax
  800760:	01 c0                	add    %eax,%eax
  800762:	01 d8                	add    %ebx,%eax
  800764:	83 e8 30             	sub    $0x30,%eax
  800767:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80076a:	8b 45 10             	mov    0x10(%ebp),%eax
  80076d:	8a 00                	mov    (%eax),%al
  80076f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800772:	83 fb 2f             	cmp    $0x2f,%ebx
  800775:	7e 3e                	jle    8007b5 <vprintfmt+0xe9>
  800777:	83 fb 39             	cmp    $0x39,%ebx
  80077a:	7f 39                	jg     8007b5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80077c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80077f:	eb d5                	jmp    800756 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800781:	8b 45 14             	mov    0x14(%ebp),%eax
  800784:	83 c0 04             	add    $0x4,%eax
  800787:	89 45 14             	mov    %eax,0x14(%ebp)
  80078a:	8b 45 14             	mov    0x14(%ebp),%eax
  80078d:	83 e8 04             	sub    $0x4,%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800795:	eb 1f                	jmp    8007b6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800797:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079b:	79 83                	jns    800720 <vprintfmt+0x54>
				width = 0;
  80079d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007a4:	e9 77 ff ff ff       	jmp    800720 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007a9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007b0:	e9 6b ff ff ff       	jmp    800720 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007b5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ba:	0f 89 60 ff ff ff    	jns    800720 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007c6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007cd:	e9 4e ff ff ff       	jmp    800720 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007d2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007d5:	e9 46 ff ff ff       	jmp    800720 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007da:	8b 45 14             	mov    0x14(%ebp),%eax
  8007dd:	83 c0 04             	add    $0x4,%eax
  8007e0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e6:	83 e8 04             	sub    $0x4,%eax
  8007e9:	8b 00                	mov    (%eax),%eax
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 0c             	pushl  0xc(%ebp)
  8007f1:	50                   	push   %eax
  8007f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f5:	ff d0                	call   *%eax
  8007f7:	83 c4 10             	add    $0x10,%esp
			break;
  8007fa:	e9 89 02 00 00       	jmp    800a88 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800802:	83 c0 04             	add    $0x4,%eax
  800805:	89 45 14             	mov    %eax,0x14(%ebp)
  800808:	8b 45 14             	mov    0x14(%ebp),%eax
  80080b:	83 e8 04             	sub    $0x4,%eax
  80080e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800810:	85 db                	test   %ebx,%ebx
  800812:	79 02                	jns    800816 <vprintfmt+0x14a>
				err = -err;
  800814:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800816:	83 fb 64             	cmp    $0x64,%ebx
  800819:	7f 0b                	jg     800826 <vprintfmt+0x15a>
  80081b:	8b 34 9d a0 1e 80 00 	mov    0x801ea0(,%ebx,4),%esi
  800822:	85 f6                	test   %esi,%esi
  800824:	75 19                	jne    80083f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800826:	53                   	push   %ebx
  800827:	68 45 20 80 00       	push   $0x802045
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 5e 02 00 00       	call   800a95 <printfmt>
  800837:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80083a:	e9 49 02 00 00       	jmp    800a88 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80083f:	56                   	push   %esi
  800840:	68 4e 20 80 00       	push   $0x80204e
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	ff 75 08             	pushl  0x8(%ebp)
  80084b:	e8 45 02 00 00       	call   800a95 <printfmt>
  800850:	83 c4 10             	add    $0x10,%esp
			break;
  800853:	e9 30 02 00 00       	jmp    800a88 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800858:	8b 45 14             	mov    0x14(%ebp),%eax
  80085b:	83 c0 04             	add    $0x4,%eax
  80085e:	89 45 14             	mov    %eax,0x14(%ebp)
  800861:	8b 45 14             	mov    0x14(%ebp),%eax
  800864:	83 e8 04             	sub    $0x4,%eax
  800867:	8b 30                	mov    (%eax),%esi
  800869:	85 f6                	test   %esi,%esi
  80086b:	75 05                	jne    800872 <vprintfmt+0x1a6>
				p = "(null)";
  80086d:	be 51 20 80 00       	mov    $0x802051,%esi
			if (width > 0 && padc != '-')
  800872:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800876:	7e 6d                	jle    8008e5 <vprintfmt+0x219>
  800878:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80087c:	74 67                	je     8008e5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80087e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	50                   	push   %eax
  800885:	56                   	push   %esi
  800886:	e8 0c 03 00 00       	call   800b97 <strnlen>
  80088b:	83 c4 10             	add    $0x10,%esp
  80088e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800891:	eb 16                	jmp    8008a9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800893:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800897:	83 ec 08             	sub    $0x8,%esp
  80089a:	ff 75 0c             	pushl  0xc(%ebp)
  80089d:	50                   	push   %eax
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	ff d0                	call   *%eax
  8008a3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008a6:	ff 4d e4             	decl   -0x1c(%ebp)
  8008a9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ad:	7f e4                	jg     800893 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008af:	eb 34                	jmp    8008e5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008b1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008b5:	74 1c                	je     8008d3 <vprintfmt+0x207>
  8008b7:	83 fb 1f             	cmp    $0x1f,%ebx
  8008ba:	7e 05                	jle    8008c1 <vprintfmt+0x1f5>
  8008bc:	83 fb 7e             	cmp    $0x7e,%ebx
  8008bf:	7e 12                	jle    8008d3 <vprintfmt+0x207>
					putch('?', putdat);
  8008c1:	83 ec 08             	sub    $0x8,%esp
  8008c4:	ff 75 0c             	pushl  0xc(%ebp)
  8008c7:	6a 3f                	push   $0x3f
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	ff d0                	call   *%eax
  8008ce:	83 c4 10             	add    $0x10,%esp
  8008d1:	eb 0f                	jmp    8008e2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008d3:	83 ec 08             	sub    $0x8,%esp
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	53                   	push   %ebx
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	ff d0                	call   *%eax
  8008df:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008e2:	ff 4d e4             	decl   -0x1c(%ebp)
  8008e5:	89 f0                	mov    %esi,%eax
  8008e7:	8d 70 01             	lea    0x1(%eax),%esi
  8008ea:	8a 00                	mov    (%eax),%al
  8008ec:	0f be d8             	movsbl %al,%ebx
  8008ef:	85 db                	test   %ebx,%ebx
  8008f1:	74 24                	je     800917 <vprintfmt+0x24b>
  8008f3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008f7:	78 b8                	js     8008b1 <vprintfmt+0x1e5>
  8008f9:	ff 4d e0             	decl   -0x20(%ebp)
  8008fc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800900:	79 af                	jns    8008b1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800902:	eb 13                	jmp    800917 <vprintfmt+0x24b>
				putch(' ', putdat);
  800904:	83 ec 08             	sub    $0x8,%esp
  800907:	ff 75 0c             	pushl  0xc(%ebp)
  80090a:	6a 20                	push   $0x20
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	ff d0                	call   *%eax
  800911:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800914:	ff 4d e4             	decl   -0x1c(%ebp)
  800917:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80091b:	7f e7                	jg     800904 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80091d:	e9 66 01 00 00       	jmp    800a88 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800922:	83 ec 08             	sub    $0x8,%esp
  800925:	ff 75 e8             	pushl  -0x18(%ebp)
  800928:	8d 45 14             	lea    0x14(%ebp),%eax
  80092b:	50                   	push   %eax
  80092c:	e8 3c fd ff ff       	call   80066d <getint>
  800931:	83 c4 10             	add    $0x10,%esp
  800934:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800937:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80093a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800940:	85 d2                	test   %edx,%edx
  800942:	79 23                	jns    800967 <vprintfmt+0x29b>
				putch('-', putdat);
  800944:	83 ec 08             	sub    $0x8,%esp
  800947:	ff 75 0c             	pushl  0xc(%ebp)
  80094a:	6a 2d                	push   $0x2d
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	ff d0                	call   *%eax
  800951:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800954:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800957:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80095a:	f7 d8                	neg    %eax
  80095c:	83 d2 00             	adc    $0x0,%edx
  80095f:	f7 da                	neg    %edx
  800961:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800964:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800967:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80096e:	e9 bc 00 00 00       	jmp    800a2f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800973:	83 ec 08             	sub    $0x8,%esp
  800976:	ff 75 e8             	pushl  -0x18(%ebp)
  800979:	8d 45 14             	lea    0x14(%ebp),%eax
  80097c:	50                   	push   %eax
  80097d:	e8 84 fc ff ff       	call   800606 <getuint>
  800982:	83 c4 10             	add    $0x10,%esp
  800985:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800988:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80098b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800992:	e9 98 00 00 00       	jmp    800a2f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800997:	83 ec 08             	sub    $0x8,%esp
  80099a:	ff 75 0c             	pushl  0xc(%ebp)
  80099d:	6a 58                	push   $0x58
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	ff d0                	call   *%eax
  8009a4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 0c             	pushl  0xc(%ebp)
  8009ad:	6a 58                	push   $0x58
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	ff d0                	call   *%eax
  8009b4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b7:	83 ec 08             	sub    $0x8,%esp
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	6a 58                	push   $0x58
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	ff d0                	call   *%eax
  8009c4:	83 c4 10             	add    $0x10,%esp
			break;
  8009c7:	e9 bc 00 00 00       	jmp    800a88 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009cc:	83 ec 08             	sub    $0x8,%esp
  8009cf:	ff 75 0c             	pushl  0xc(%ebp)
  8009d2:	6a 30                	push   $0x30
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	ff d0                	call   *%eax
  8009d9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009dc:	83 ec 08             	sub    $0x8,%esp
  8009df:	ff 75 0c             	pushl  0xc(%ebp)
  8009e2:	6a 78                	push   $0x78
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	ff d0                	call   *%eax
  8009e9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ef:	83 c0 04             	add    $0x4,%eax
  8009f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f8:	83 e8 04             	sub    $0x4,%eax
  8009fb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a07:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a0e:	eb 1f                	jmp    800a2f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a10:	83 ec 08             	sub    $0x8,%esp
  800a13:	ff 75 e8             	pushl  -0x18(%ebp)
  800a16:	8d 45 14             	lea    0x14(%ebp),%eax
  800a19:	50                   	push   %eax
  800a1a:	e8 e7 fb ff ff       	call   800606 <getuint>
  800a1f:	83 c4 10             	add    $0x10,%esp
  800a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a28:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a2f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a36:	83 ec 04             	sub    $0x4,%esp
  800a39:	52                   	push   %edx
  800a3a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a3d:	50                   	push   %eax
  800a3e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a41:	ff 75 f0             	pushl  -0x10(%ebp)
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	ff 75 08             	pushl  0x8(%ebp)
  800a4a:	e8 00 fb ff ff       	call   80054f <printnum>
  800a4f:	83 c4 20             	add    $0x20,%esp
			break;
  800a52:	eb 34                	jmp    800a88 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a54:	83 ec 08             	sub    $0x8,%esp
  800a57:	ff 75 0c             	pushl  0xc(%ebp)
  800a5a:	53                   	push   %ebx
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	ff d0                	call   *%eax
  800a60:	83 c4 10             	add    $0x10,%esp
			break;
  800a63:	eb 23                	jmp    800a88 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a65:	83 ec 08             	sub    $0x8,%esp
  800a68:	ff 75 0c             	pushl  0xc(%ebp)
  800a6b:	6a 25                	push   $0x25
  800a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a70:	ff d0                	call   *%eax
  800a72:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a75:	ff 4d 10             	decl   0x10(%ebp)
  800a78:	eb 03                	jmp    800a7d <vprintfmt+0x3b1>
  800a7a:	ff 4d 10             	decl   0x10(%ebp)
  800a7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a80:	48                   	dec    %eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	3c 25                	cmp    $0x25,%al
  800a85:	75 f3                	jne    800a7a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a87:	90                   	nop
		}
	}
  800a88:	e9 47 fc ff ff       	jmp    8006d4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a8d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a91:	5b                   	pop    %ebx
  800a92:	5e                   	pop    %esi
  800a93:	5d                   	pop    %ebp
  800a94:	c3                   	ret    

00800a95 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a95:	55                   	push   %ebp
  800a96:	89 e5                	mov    %esp,%ebp
  800a98:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a9b:	8d 45 10             	lea    0x10(%ebp),%eax
  800a9e:	83 c0 04             	add    $0x4,%eax
  800aa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800aa4:	8b 45 10             	mov    0x10(%ebp),%eax
  800aa7:	ff 75 f4             	pushl  -0xc(%ebp)
  800aaa:	50                   	push   %eax
  800aab:	ff 75 0c             	pushl  0xc(%ebp)
  800aae:	ff 75 08             	pushl  0x8(%ebp)
  800ab1:	e8 16 fc ff ff       	call   8006cc <vprintfmt>
  800ab6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ab9:	90                   	nop
  800aba:	c9                   	leave  
  800abb:	c3                   	ret    

00800abc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800abc:	55                   	push   %ebp
  800abd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800abf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac2:	8b 40 08             	mov    0x8(%eax),%eax
  800ac5:	8d 50 01             	lea    0x1(%eax),%edx
  800ac8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ace:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad1:	8b 10                	mov    (%eax),%edx
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8b 40 04             	mov    0x4(%eax),%eax
  800ad9:	39 c2                	cmp    %eax,%edx
  800adb:	73 12                	jae    800aef <sprintputch+0x33>
		*b->buf++ = ch;
  800add:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae0:	8b 00                	mov    (%eax),%eax
  800ae2:	8d 48 01             	lea    0x1(%eax),%ecx
  800ae5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae8:	89 0a                	mov    %ecx,(%edx)
  800aea:	8b 55 08             	mov    0x8(%ebp),%edx
  800aed:	88 10                	mov    %dl,(%eax)
}
  800aef:	90                   	nop
  800af0:	5d                   	pop    %ebp
  800af1:	c3                   	ret    

00800af2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
  800af5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800afe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b01:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	01 d0                	add    %edx,%eax
  800b09:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b13:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b17:	74 06                	je     800b1f <vsnprintf+0x2d>
  800b19:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1d:	7f 07                	jg     800b26 <vsnprintf+0x34>
		return -E_INVAL;
  800b1f:	b8 03 00 00 00       	mov    $0x3,%eax
  800b24:	eb 20                	jmp    800b46 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b26:	ff 75 14             	pushl  0x14(%ebp)
  800b29:	ff 75 10             	pushl  0x10(%ebp)
  800b2c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b2f:	50                   	push   %eax
  800b30:	68 bc 0a 80 00       	push   $0x800abc
  800b35:	e8 92 fb ff ff       	call   8006cc <vprintfmt>
  800b3a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b40:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b46:	c9                   	leave  
  800b47:	c3                   	ret    

00800b48 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b48:	55                   	push   %ebp
  800b49:	89 e5                	mov    %esp,%ebp
  800b4b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b4e:	8d 45 10             	lea    0x10(%ebp),%eax
  800b51:	83 c0 04             	add    $0x4,%eax
  800b54:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b57:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5d:	50                   	push   %eax
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	ff 75 08             	pushl  0x8(%ebp)
  800b64:	e8 89 ff ff ff       	call   800af2 <vsnprintf>
  800b69:	83 c4 10             	add    $0x10,%esp
  800b6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b72:	c9                   	leave  
  800b73:	c3                   	ret    

00800b74 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b74:	55                   	push   %ebp
  800b75:	89 e5                	mov    %esp,%ebp
  800b77:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b81:	eb 06                	jmp    800b89 <strlen+0x15>
		n++;
  800b83:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b86:	ff 45 08             	incl   0x8(%ebp)
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8a 00                	mov    (%eax),%al
  800b8e:	84 c0                	test   %al,%al
  800b90:	75 f1                	jne    800b83 <strlen+0xf>
		n++;
	return n;
  800b92:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b95:	c9                   	leave  
  800b96:	c3                   	ret    

00800b97 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
  800b9a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ba4:	eb 09                	jmp    800baf <strnlen+0x18>
		n++;
  800ba6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ba9:	ff 45 08             	incl   0x8(%ebp)
  800bac:	ff 4d 0c             	decl   0xc(%ebp)
  800baf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb3:	74 09                	je     800bbe <strnlen+0x27>
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8a 00                	mov    (%eax),%al
  800bba:	84 c0                	test   %al,%al
  800bbc:	75 e8                	jne    800ba6 <strnlen+0xf>
		n++;
	return n;
  800bbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc1:	c9                   	leave  
  800bc2:	c3                   	ret    

00800bc3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bc3:	55                   	push   %ebp
  800bc4:	89 e5                	mov    %esp,%ebp
  800bc6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bcf:	90                   	nop
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8d 50 01             	lea    0x1(%eax),%edx
  800bd6:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bdc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bdf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800be2:	8a 12                	mov    (%edx),%dl
  800be4:	88 10                	mov    %dl,(%eax)
  800be6:	8a 00                	mov    (%eax),%al
  800be8:	84 c0                	test   %al,%al
  800bea:	75 e4                	jne    800bd0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bfd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c04:	eb 1f                	jmp    800c25 <strncpy+0x34>
		*dst++ = *src;
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8d 50 01             	lea    0x1(%eax),%edx
  800c0c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c12:	8a 12                	mov    (%edx),%dl
  800c14:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	8a 00                	mov    (%eax),%al
  800c1b:	84 c0                	test   %al,%al
  800c1d:	74 03                	je     800c22 <strncpy+0x31>
			src++;
  800c1f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c22:	ff 45 fc             	incl   -0x4(%ebp)
  800c25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c28:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c2b:	72 d9                	jb     800c06 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c30:	c9                   	leave  
  800c31:	c3                   	ret    

00800c32 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
  800c35:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c3e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c42:	74 30                	je     800c74 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c44:	eb 16                	jmp    800c5c <strlcpy+0x2a>
			*dst++ = *src++;
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	8d 50 01             	lea    0x1(%eax),%edx
  800c4c:	89 55 08             	mov    %edx,0x8(%ebp)
  800c4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c55:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c58:	8a 12                	mov    (%edx),%dl
  800c5a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c5c:	ff 4d 10             	decl   0x10(%ebp)
  800c5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c63:	74 09                	je     800c6e <strlcpy+0x3c>
  800c65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	84 c0                	test   %al,%al
  800c6c:	75 d8                	jne    800c46 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c74:	8b 55 08             	mov    0x8(%ebp),%edx
  800c77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c7a:	29 c2                	sub    %eax,%edx
  800c7c:	89 d0                	mov    %edx,%eax
}
  800c7e:	c9                   	leave  
  800c7f:	c3                   	ret    

00800c80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c80:	55                   	push   %ebp
  800c81:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c83:	eb 06                	jmp    800c8b <strcmp+0xb>
		p++, q++;
  800c85:	ff 45 08             	incl   0x8(%ebp)
  800c88:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	8a 00                	mov    (%eax),%al
  800c90:	84 c0                	test   %al,%al
  800c92:	74 0e                	je     800ca2 <strcmp+0x22>
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 10                	mov    (%eax),%dl
  800c99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	38 c2                	cmp    %al,%dl
  800ca0:	74 e3                	je     800c85 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	0f b6 d0             	movzbl %al,%edx
  800caa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	0f b6 c0             	movzbl %al,%eax
  800cb2:	29 c2                	sub    %eax,%edx
  800cb4:	89 d0                	mov    %edx,%eax
}
  800cb6:	5d                   	pop    %ebp
  800cb7:	c3                   	ret    

00800cb8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cbb:	eb 09                	jmp    800cc6 <strncmp+0xe>
		n--, p++, q++;
  800cbd:	ff 4d 10             	decl   0x10(%ebp)
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cca:	74 17                	je     800ce3 <strncmp+0x2b>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	84 c0                	test   %al,%al
  800cd3:	74 0e                	je     800ce3 <strncmp+0x2b>
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 10                	mov    (%eax),%dl
  800cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	38 c2                	cmp    %al,%dl
  800ce1:	74 da                	je     800cbd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ce3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce7:	75 07                	jne    800cf0 <strncmp+0x38>
		return 0;
  800ce9:	b8 00 00 00 00       	mov    $0x0,%eax
  800cee:	eb 14                	jmp    800d04 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	0f b6 d0             	movzbl %al,%edx
  800cf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfb:	8a 00                	mov    (%eax),%al
  800cfd:	0f b6 c0             	movzbl %al,%eax
  800d00:	29 c2                	sub    %eax,%edx
  800d02:	89 d0                	mov    %edx,%eax
}
  800d04:	5d                   	pop    %ebp
  800d05:	c3                   	ret    

00800d06 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d06:	55                   	push   %ebp
  800d07:	89 e5                	mov    %esp,%ebp
  800d09:	83 ec 04             	sub    $0x4,%esp
  800d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d12:	eb 12                	jmp    800d26 <strchr+0x20>
		if (*s == c)
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d1c:	75 05                	jne    800d23 <strchr+0x1d>
			return (char *) s;
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	eb 11                	jmp    800d34 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d23:	ff 45 08             	incl   0x8(%ebp)
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	84 c0                	test   %al,%al
  800d2d:	75 e5                	jne    800d14 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d34:	c9                   	leave  
  800d35:	c3                   	ret    

00800d36 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d36:	55                   	push   %ebp
  800d37:	89 e5                	mov    %esp,%ebp
  800d39:	83 ec 04             	sub    $0x4,%esp
  800d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d42:	eb 0d                	jmp    800d51 <strfind+0x1b>
		if (*s == c)
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d4c:	74 0e                	je     800d5c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d4e:	ff 45 08             	incl   0x8(%ebp)
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	84 c0                	test   %al,%al
  800d58:	75 ea                	jne    800d44 <strfind+0xe>
  800d5a:	eb 01                	jmp    800d5d <strfind+0x27>
		if (*s == c)
			break;
  800d5c:	90                   	nop
	return (char *) s;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d60:	c9                   	leave  
  800d61:	c3                   	ret    

00800d62 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
  800d65:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d74:	eb 0e                	jmp    800d84 <memset+0x22>
		*p++ = c;
  800d76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d79:	8d 50 01             	lea    0x1(%eax),%edx
  800d7c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d82:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d84:	ff 4d f8             	decl   -0x8(%ebp)
  800d87:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d8b:	79 e9                	jns    800d76 <memset+0x14>
		*p++ = c;

	return v;
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d90:	c9                   	leave  
  800d91:	c3                   	ret    

00800d92 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d92:	55                   	push   %ebp
  800d93:	89 e5                	mov    %esp,%ebp
  800d95:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800da4:	eb 16                	jmp    800dbc <memcpy+0x2a>
		*d++ = *s++;
  800da6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da9:	8d 50 01             	lea    0x1(%eax),%edx
  800dac:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800daf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800db2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800db5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800db8:	8a 12                	mov    (%edx),%dl
  800dba:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc5:	85 c0                	test   %eax,%eax
  800dc7:	75 dd                	jne    800da6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dcc:	c9                   	leave  
  800dcd:	c3                   	ret    

00800dce <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dce:	55                   	push   %ebp
  800dcf:	89 e5                	mov    %esp,%ebp
  800dd1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800de0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de6:	73 50                	jae    800e38 <memmove+0x6a>
  800de8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df3:	76 43                	jbe    800e38 <memmove+0x6a>
		s += n;
  800df5:	8b 45 10             	mov    0x10(%ebp),%eax
  800df8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfe:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e01:	eb 10                	jmp    800e13 <memmove+0x45>
			*--d = *--s;
  800e03:	ff 4d f8             	decl   -0x8(%ebp)
  800e06:	ff 4d fc             	decl   -0x4(%ebp)
  800e09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e0c:	8a 10                	mov    (%eax),%dl
  800e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e11:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e13:	8b 45 10             	mov    0x10(%ebp),%eax
  800e16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e19:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1c:	85 c0                	test   %eax,%eax
  800e1e:	75 e3                	jne    800e03 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e20:	eb 23                	jmp    800e45 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e25:	8d 50 01             	lea    0x1(%eax),%edx
  800e28:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e31:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e34:	8a 12                	mov    (%edx),%dl
  800e36:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e38:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3e:	89 55 10             	mov    %edx,0x10(%ebp)
  800e41:	85 c0                	test   %eax,%eax
  800e43:	75 dd                	jne    800e22 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e48:	c9                   	leave  
  800e49:	c3                   	ret    

00800e4a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e4a:	55                   	push   %ebp
  800e4b:	89 e5                	mov    %esp,%ebp
  800e4d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e59:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e5c:	eb 2a                	jmp    800e88 <memcmp+0x3e>
		if (*s1 != *s2)
  800e5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e61:	8a 10                	mov    (%eax),%dl
  800e63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	38 c2                	cmp    %al,%dl
  800e6a:	74 16                	je     800e82 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	8a 00                	mov    (%eax),%al
  800e71:	0f b6 d0             	movzbl %al,%edx
  800e74:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	0f b6 c0             	movzbl %al,%eax
  800e7c:	29 c2                	sub    %eax,%edx
  800e7e:	89 d0                	mov    %edx,%eax
  800e80:	eb 18                	jmp    800e9a <memcmp+0x50>
		s1++, s2++;
  800e82:	ff 45 fc             	incl   -0x4(%ebp)
  800e85:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e88:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8e:	89 55 10             	mov    %edx,0x10(%ebp)
  800e91:	85 c0                	test   %eax,%eax
  800e93:	75 c9                	jne    800e5e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e9a:	c9                   	leave  
  800e9b:	c3                   	ret    

00800e9c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e9c:	55                   	push   %ebp
  800e9d:	89 e5                	mov    %esp,%ebp
  800e9f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ea2:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea8:	01 d0                	add    %edx,%eax
  800eaa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ead:	eb 15                	jmp    800ec4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f b6 d0             	movzbl %al,%edx
  800eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eba:	0f b6 c0             	movzbl %al,%eax
  800ebd:	39 c2                	cmp    %eax,%edx
  800ebf:	74 0d                	je     800ece <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ec1:	ff 45 08             	incl   0x8(%ebp)
  800ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eca:	72 e3                	jb     800eaf <memfind+0x13>
  800ecc:	eb 01                	jmp    800ecf <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ece:	90                   	nop
	return (void *) s;
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed2:	c9                   	leave  
  800ed3:	c3                   	ret    

00800ed4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ed4:	55                   	push   %ebp
  800ed5:	89 e5                	mov    %esp,%ebp
  800ed7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ee1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ee8:	eb 03                	jmp    800eed <strtol+0x19>
		s++;
  800eea:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	3c 20                	cmp    $0x20,%al
  800ef4:	74 f4                	je     800eea <strtol+0x16>
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	3c 09                	cmp    $0x9,%al
  800efd:	74 eb                	je     800eea <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	3c 2b                	cmp    $0x2b,%al
  800f06:	75 05                	jne    800f0d <strtol+0x39>
		s++;
  800f08:	ff 45 08             	incl   0x8(%ebp)
  800f0b:	eb 13                	jmp    800f20 <strtol+0x4c>
	else if (*s == '-')
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	3c 2d                	cmp    $0x2d,%al
  800f14:	75 0a                	jne    800f20 <strtol+0x4c>
		s++, neg = 1;
  800f16:	ff 45 08             	incl   0x8(%ebp)
  800f19:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f24:	74 06                	je     800f2c <strtol+0x58>
  800f26:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f2a:	75 20                	jne    800f4c <strtol+0x78>
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 30                	cmp    $0x30,%al
  800f33:	75 17                	jne    800f4c <strtol+0x78>
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	40                   	inc    %eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	3c 78                	cmp    $0x78,%al
  800f3d:	75 0d                	jne    800f4c <strtol+0x78>
		s += 2, base = 16;
  800f3f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f43:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f4a:	eb 28                	jmp    800f74 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f50:	75 15                	jne    800f67 <strtol+0x93>
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	3c 30                	cmp    $0x30,%al
  800f59:	75 0c                	jne    800f67 <strtol+0x93>
		s++, base = 8;
  800f5b:	ff 45 08             	incl   0x8(%ebp)
  800f5e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f65:	eb 0d                	jmp    800f74 <strtol+0xa0>
	else if (base == 0)
  800f67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f6b:	75 07                	jne    800f74 <strtol+0xa0>
		base = 10;
  800f6d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	3c 2f                	cmp    $0x2f,%al
  800f7b:	7e 19                	jle    800f96 <strtol+0xc2>
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	3c 39                	cmp    $0x39,%al
  800f84:	7f 10                	jg     800f96 <strtol+0xc2>
			dig = *s - '0';
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	0f be c0             	movsbl %al,%eax
  800f8e:	83 e8 30             	sub    $0x30,%eax
  800f91:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f94:	eb 42                	jmp    800fd8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	3c 60                	cmp    $0x60,%al
  800f9d:	7e 19                	jle    800fb8 <strtol+0xe4>
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	3c 7a                	cmp    $0x7a,%al
  800fa6:	7f 10                	jg     800fb8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	0f be c0             	movsbl %al,%eax
  800fb0:	83 e8 57             	sub    $0x57,%eax
  800fb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fb6:	eb 20                	jmp    800fd8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3c 40                	cmp    $0x40,%al
  800fbf:	7e 39                	jle    800ffa <strtol+0x126>
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	3c 5a                	cmp    $0x5a,%al
  800fc8:	7f 30                	jg     800ffa <strtol+0x126>
			dig = *s - 'A' + 10;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	0f be c0             	movsbl %al,%eax
  800fd2:	83 e8 37             	sub    $0x37,%eax
  800fd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fdb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fde:	7d 19                	jge    800ff9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fe0:	ff 45 08             	incl   0x8(%ebp)
  800fe3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe6:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fea:	89 c2                	mov    %eax,%edx
  800fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fef:	01 d0                	add    %edx,%eax
  800ff1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ff4:	e9 7b ff ff ff       	jmp    800f74 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800ff9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ffa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffe:	74 08                	je     801008 <strtol+0x134>
		*endptr = (char *) s;
  801000:	8b 45 0c             	mov    0xc(%ebp),%eax
  801003:	8b 55 08             	mov    0x8(%ebp),%edx
  801006:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801008:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80100c:	74 07                	je     801015 <strtol+0x141>
  80100e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801011:	f7 d8                	neg    %eax
  801013:	eb 03                	jmp    801018 <strtol+0x144>
  801015:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801018:	c9                   	leave  
  801019:	c3                   	ret    

0080101a <ltostr>:

void
ltostr(long value, char *str)
{
  80101a:	55                   	push   %ebp
  80101b:	89 e5                	mov    %esp,%ebp
  80101d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801020:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801027:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80102e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801032:	79 13                	jns    801047 <ltostr+0x2d>
	{
		neg = 1;
  801034:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80103b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801041:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801044:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80104f:	99                   	cltd   
  801050:	f7 f9                	idiv   %ecx
  801052:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801055:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801058:	8d 50 01             	lea    0x1(%eax),%edx
  80105b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80105e:	89 c2                	mov    %eax,%edx
  801060:	8b 45 0c             	mov    0xc(%ebp),%eax
  801063:	01 d0                	add    %edx,%eax
  801065:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801068:	83 c2 30             	add    $0x30,%edx
  80106b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80106d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801070:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801075:	f7 e9                	imul   %ecx
  801077:	c1 fa 02             	sar    $0x2,%edx
  80107a:	89 c8                	mov    %ecx,%eax
  80107c:	c1 f8 1f             	sar    $0x1f,%eax
  80107f:	29 c2                	sub    %eax,%edx
  801081:	89 d0                	mov    %edx,%eax
  801083:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801086:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801089:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80108e:	f7 e9                	imul   %ecx
  801090:	c1 fa 02             	sar    $0x2,%edx
  801093:	89 c8                	mov    %ecx,%eax
  801095:	c1 f8 1f             	sar    $0x1f,%eax
  801098:	29 c2                	sub    %eax,%edx
  80109a:	89 d0                	mov    %edx,%eax
  80109c:	c1 e0 02             	shl    $0x2,%eax
  80109f:	01 d0                	add    %edx,%eax
  8010a1:	01 c0                	add    %eax,%eax
  8010a3:	29 c1                	sub    %eax,%ecx
  8010a5:	89 ca                	mov    %ecx,%edx
  8010a7:	85 d2                	test   %edx,%edx
  8010a9:	75 9c                	jne    801047 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b5:	48                   	dec    %eax
  8010b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010bd:	74 3d                	je     8010fc <ltostr+0xe2>
		start = 1 ;
  8010bf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010c6:	eb 34                	jmp    8010fc <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 d0                	add    %edx,%eax
  8010d0:	8a 00                	mov    (%eax),%al
  8010d2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010db:	01 c2                	add    %eax,%edx
  8010dd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e3:	01 c8                	add    %ecx,%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010e9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	01 c2                	add    %eax,%edx
  8010f1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010f4:	88 02                	mov    %al,(%edx)
		start++ ;
  8010f6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010f9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ff:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801102:	7c c4                	jl     8010c8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801104:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110a:	01 d0                	add    %edx,%eax
  80110c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80110f:	90                   	nop
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
  801115:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801118:	ff 75 08             	pushl  0x8(%ebp)
  80111b:	e8 54 fa ff ff       	call   800b74 <strlen>
  801120:	83 c4 04             	add    $0x4,%esp
  801123:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801126:	ff 75 0c             	pushl  0xc(%ebp)
  801129:	e8 46 fa ff ff       	call   800b74 <strlen>
  80112e:	83 c4 04             	add    $0x4,%esp
  801131:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801134:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80113b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801142:	eb 17                	jmp    80115b <strcconcat+0x49>
		final[s] = str1[s] ;
  801144:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801147:	8b 45 10             	mov    0x10(%ebp),%eax
  80114a:	01 c2                	add    %eax,%edx
  80114c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	01 c8                	add    %ecx,%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801158:	ff 45 fc             	incl   -0x4(%ebp)
  80115b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801161:	7c e1                	jl     801144 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801163:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80116a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801171:	eb 1f                	jmp    801192 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801173:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801176:	8d 50 01             	lea    0x1(%eax),%edx
  801179:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80117c:	89 c2                	mov    %eax,%edx
  80117e:	8b 45 10             	mov    0x10(%ebp),%eax
  801181:	01 c2                	add    %eax,%edx
  801183:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801186:	8b 45 0c             	mov    0xc(%ebp),%eax
  801189:	01 c8                	add    %ecx,%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80118f:	ff 45 f8             	incl   -0x8(%ebp)
  801192:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801195:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801198:	7c d9                	jl     801173 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80119a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80119d:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a0:	01 d0                	add    %edx,%eax
  8011a2:	c6 00 00             	movb   $0x0,(%eax)
}
  8011a5:	90                   	nop
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b7:	8b 00                	mov    (%eax),%eax
  8011b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c3:	01 d0                	add    %edx,%eax
  8011c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011cb:	eb 0c                	jmp    8011d9 <strsplit+0x31>
			*string++ = 0;
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8d 50 01             	lea    0x1(%eax),%edx
  8011d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	84 c0                	test   %al,%al
  8011e0:	74 18                	je     8011fa <strsplit+0x52>
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	0f be c0             	movsbl %al,%eax
  8011ea:	50                   	push   %eax
  8011eb:	ff 75 0c             	pushl  0xc(%ebp)
  8011ee:	e8 13 fb ff ff       	call   800d06 <strchr>
  8011f3:	83 c4 08             	add    $0x8,%esp
  8011f6:	85 c0                	test   %eax,%eax
  8011f8:	75 d3                	jne    8011cd <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	84 c0                	test   %al,%al
  801201:	74 5a                	je     80125d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801203:	8b 45 14             	mov    0x14(%ebp),%eax
  801206:	8b 00                	mov    (%eax),%eax
  801208:	83 f8 0f             	cmp    $0xf,%eax
  80120b:	75 07                	jne    801214 <strsplit+0x6c>
		{
			return 0;
  80120d:	b8 00 00 00 00       	mov    $0x0,%eax
  801212:	eb 66                	jmp    80127a <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801214:	8b 45 14             	mov    0x14(%ebp),%eax
  801217:	8b 00                	mov    (%eax),%eax
  801219:	8d 48 01             	lea    0x1(%eax),%ecx
  80121c:	8b 55 14             	mov    0x14(%ebp),%edx
  80121f:	89 0a                	mov    %ecx,(%edx)
  801221:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801228:	8b 45 10             	mov    0x10(%ebp),%eax
  80122b:	01 c2                	add    %eax,%edx
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801232:	eb 03                	jmp    801237 <strsplit+0x8f>
			string++;
  801234:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 00                	mov    (%eax),%al
  80123c:	84 c0                	test   %al,%al
  80123e:	74 8b                	je     8011cb <strsplit+0x23>
  801240:	8b 45 08             	mov    0x8(%ebp),%eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	0f be c0             	movsbl %al,%eax
  801248:	50                   	push   %eax
  801249:	ff 75 0c             	pushl  0xc(%ebp)
  80124c:	e8 b5 fa ff ff       	call   800d06 <strchr>
  801251:	83 c4 08             	add    $0x8,%esp
  801254:	85 c0                	test   %eax,%eax
  801256:	74 dc                	je     801234 <strsplit+0x8c>
			string++;
	}
  801258:	e9 6e ff ff ff       	jmp    8011cb <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80125d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80125e:	8b 45 14             	mov    0x14(%ebp),%eax
  801261:	8b 00                	mov    (%eax),%eax
  801263:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80126a:	8b 45 10             	mov    0x10(%ebp),%eax
  80126d:	01 d0                	add    %edx,%eax
  80126f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801275:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80127a:	c9                   	leave  
  80127b:	c3                   	ret    

0080127c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80127c:	55                   	push   %ebp
  80127d:	89 e5                	mov    %esp,%ebp
  80127f:	57                   	push   %edi
  801280:	56                   	push   %esi
  801281:	53                   	push   %ebx
  801282:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	8b 55 0c             	mov    0xc(%ebp),%edx
  80128b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80128e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801291:	8b 7d 18             	mov    0x18(%ebp),%edi
  801294:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801297:	cd 30                	int    $0x30
  801299:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80129c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80129f:	83 c4 10             	add    $0x10,%esp
  8012a2:	5b                   	pop    %ebx
  8012a3:	5e                   	pop    %esi
  8012a4:	5f                   	pop    %edi
  8012a5:	5d                   	pop    %ebp
  8012a6:	c3                   	ret    

008012a7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012a7:	55                   	push   %ebp
  8012a8:	89 e5                	mov    %esp,%ebp
  8012aa:	83 ec 04             	sub    $0x4,%esp
  8012ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012b3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	52                   	push   %edx
  8012bf:	ff 75 0c             	pushl  0xc(%ebp)
  8012c2:	50                   	push   %eax
  8012c3:	6a 00                	push   $0x0
  8012c5:	e8 b2 ff ff ff       	call   80127c <syscall>
  8012ca:	83 c4 18             	add    $0x18,%esp
}
  8012cd:	90                   	nop
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 01                	push   $0x1
  8012df:	e8 98 ff ff ff       	call   80127c <syscall>
  8012e4:	83 c4 18             	add    $0x18,%esp
}
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	50                   	push   %eax
  8012f8:	6a 05                	push   $0x5
  8012fa:	e8 7d ff ff ff       	call   80127c <syscall>
  8012ff:	83 c4 18             	add    $0x18,%esp
}
  801302:	c9                   	leave  
  801303:	c3                   	ret    

00801304 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801304:	55                   	push   %ebp
  801305:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 02                	push   $0x2
  801313:	e8 64 ff ff ff       	call   80127c <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 03                	push   $0x3
  80132c:	e8 4b ff ff ff       	call   80127c <syscall>
  801331:	83 c4 18             	add    $0x18,%esp
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 04                	push   $0x4
  801345:	e8 32 ff ff ff       	call   80127c <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_env_exit>:


void sys_env_exit(void)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 06                	push   $0x6
  80135e:	e8 19 ff ff ff       	call   80127c <syscall>
  801363:	83 c4 18             	add    $0x18,%esp
}
  801366:	90                   	nop
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80136c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	52                   	push   %edx
  801379:	50                   	push   %eax
  80137a:	6a 07                	push   $0x7
  80137c:	e8 fb fe ff ff       	call   80127c <syscall>
  801381:	83 c4 18             	add    $0x18,%esp
}
  801384:	c9                   	leave  
  801385:	c3                   	ret    

00801386 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801386:	55                   	push   %ebp
  801387:	89 e5                	mov    %esp,%ebp
  801389:	56                   	push   %esi
  80138a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80138b:	8b 75 18             	mov    0x18(%ebp),%esi
  80138e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801391:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801394:	8b 55 0c             	mov    0xc(%ebp),%edx
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	56                   	push   %esi
  80139b:	53                   	push   %ebx
  80139c:	51                   	push   %ecx
  80139d:	52                   	push   %edx
  80139e:	50                   	push   %eax
  80139f:	6a 08                	push   $0x8
  8013a1:	e8 d6 fe ff ff       	call   80127c <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013ac:	5b                   	pop    %ebx
  8013ad:	5e                   	pop    %esi
  8013ae:	5d                   	pop    %ebp
  8013af:	c3                   	ret    

008013b0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	52                   	push   %edx
  8013c0:	50                   	push   %eax
  8013c1:	6a 09                	push   $0x9
  8013c3:	e8 b4 fe ff ff       	call   80127c <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	ff 75 0c             	pushl  0xc(%ebp)
  8013d9:	ff 75 08             	pushl  0x8(%ebp)
  8013dc:	6a 0a                	push   $0xa
  8013de:	e8 99 fe ff ff       	call   80127c <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 0b                	push   $0xb
  8013f7:	e8 80 fe ff ff       	call   80127c <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 0c                	push   $0xc
  801410:	e8 67 fe ff ff       	call   80127c <syscall>
  801415:	83 c4 18             	add    $0x18,%esp
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 0d                	push   $0xd
  801429:	e8 4e fe ff ff       	call   80127c <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	ff 75 0c             	pushl  0xc(%ebp)
  80143f:	ff 75 08             	pushl  0x8(%ebp)
  801442:	6a 11                	push   $0x11
  801444:	e8 33 fe ff ff       	call   80127c <syscall>
  801449:	83 c4 18             	add    $0x18,%esp
	return;
  80144c:	90                   	nop
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	ff 75 0c             	pushl  0xc(%ebp)
  80145b:	ff 75 08             	pushl  0x8(%ebp)
  80145e:	6a 12                	push   $0x12
  801460:	e8 17 fe ff ff       	call   80127c <syscall>
  801465:	83 c4 18             	add    $0x18,%esp
	return ;
  801468:	90                   	nop
}
  801469:	c9                   	leave  
  80146a:	c3                   	ret    

0080146b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80146b:	55                   	push   %ebp
  80146c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 0e                	push   $0xe
  80147a:	e8 fd fd ff ff       	call   80127c <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
}
  801482:	c9                   	leave  
  801483:	c3                   	ret    

00801484 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	ff 75 08             	pushl  0x8(%ebp)
  801492:	6a 0f                	push   $0xf
  801494:	e8 e3 fd ff ff       	call   80127c <syscall>
  801499:	83 c4 18             	add    $0x18,%esp
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 10                	push   $0x10
  8014ad:	e8 ca fd ff ff       	call   80127c <syscall>
  8014b2:	83 c4 18             	add    $0x18,%esp
}
  8014b5:	90                   	nop
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 14                	push   $0x14
  8014c7:	e8 b0 fd ff ff       	call   80127c <syscall>
  8014cc:	83 c4 18             	add    $0x18,%esp
}
  8014cf:	90                   	nop
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 15                	push   $0x15
  8014e1:	e8 96 fd ff ff       	call   80127c <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
}
  8014e9:	90                   	nop
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <sys_cputc>:


void
sys_cputc(const char c)
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
  8014ef:	83 ec 04             	sub    $0x4,%esp
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014f8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	50                   	push   %eax
  801505:	6a 16                	push   $0x16
  801507:	e8 70 fd ff ff       	call   80127c <syscall>
  80150c:	83 c4 18             	add    $0x18,%esp
}
  80150f:	90                   	nop
  801510:	c9                   	leave  
  801511:	c3                   	ret    

00801512 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801512:	55                   	push   %ebp
  801513:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 17                	push   $0x17
  801521:	e8 56 fd ff ff       	call   80127c <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
}
  801529:	90                   	nop
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	ff 75 0c             	pushl  0xc(%ebp)
  80153b:	50                   	push   %eax
  80153c:	6a 18                	push   $0x18
  80153e:	e8 39 fd ff ff       	call   80127c <syscall>
  801543:	83 c4 18             	add    $0x18,%esp
}
  801546:	c9                   	leave  
  801547:	c3                   	ret    

00801548 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801548:	55                   	push   %ebp
  801549:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80154b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	52                   	push   %edx
  801558:	50                   	push   %eax
  801559:	6a 1b                	push   $0x1b
  80155b:	e8 1c fd ff ff       	call   80127c <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801568:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	52                   	push   %edx
  801575:	50                   	push   %eax
  801576:	6a 19                	push   $0x19
  801578:	e8 ff fc ff ff       	call   80127c <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	90                   	nop
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801586:	8b 55 0c             	mov    0xc(%ebp),%edx
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	52                   	push   %edx
  801593:	50                   	push   %eax
  801594:	6a 1a                	push   $0x1a
  801596:	e8 e1 fc ff ff       	call   80127c <syscall>
  80159b:	83 c4 18             	add    $0x18,%esp
}
  80159e:	90                   	nop
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 04             	sub    $0x4,%esp
  8015a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015aa:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015ad:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015b0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	6a 00                	push   $0x0
  8015b9:	51                   	push   %ecx
  8015ba:	52                   	push   %edx
  8015bb:	ff 75 0c             	pushl  0xc(%ebp)
  8015be:	50                   	push   %eax
  8015bf:	6a 1c                	push   $0x1c
  8015c1:	e8 b6 fc ff ff       	call   80127c <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	52                   	push   %edx
  8015db:	50                   	push   %eax
  8015dc:	6a 1d                	push   $0x1d
  8015de:	e8 99 fc ff ff       	call   80127c <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	51                   	push   %ecx
  8015f9:	52                   	push   %edx
  8015fa:	50                   	push   %eax
  8015fb:	6a 1e                	push   $0x1e
  8015fd:	e8 7a fc ff ff       	call   80127c <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80160a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160d:	8b 45 08             	mov    0x8(%ebp),%eax
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	52                   	push   %edx
  801617:	50                   	push   %eax
  801618:	6a 1f                	push   $0x1f
  80161a:	e8 5d fc ff ff       	call   80127c <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 20                	push   $0x20
  801633:	e8 44 fc ff ff       	call   80127c <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	ff 75 10             	pushl  0x10(%ebp)
  80164a:	ff 75 0c             	pushl  0xc(%ebp)
  80164d:	50                   	push   %eax
  80164e:	6a 21                	push   $0x21
  801650:	e8 27 fc ff ff       	call   80127c <syscall>
  801655:	83 c4 18             	add    $0x18,%esp
}
  801658:	c9                   	leave  
  801659:	c3                   	ret    

0080165a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80165a:	55                   	push   %ebp
  80165b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80165d:	8b 45 08             	mov    0x8(%ebp),%eax
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	50                   	push   %eax
  801669:	6a 22                	push   $0x22
  80166b:	e8 0c fc ff ff       	call   80127c <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	90                   	nop
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	50                   	push   %eax
  801685:	6a 23                	push   $0x23
  801687:	e8 f0 fb ff ff       	call   80127c <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	90                   	nop
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
  801695:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801698:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80169b:	8d 50 04             	lea    0x4(%eax),%edx
  80169e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	52                   	push   %edx
  8016a8:	50                   	push   %eax
  8016a9:	6a 24                	push   $0x24
  8016ab:	e8 cc fb ff ff       	call   80127c <syscall>
  8016b0:	83 c4 18             	add    $0x18,%esp
	return result;
  8016b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016bc:	89 01                	mov    %eax,(%ecx)
  8016be:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	c9                   	leave  
  8016c5:	c2 04 00             	ret    $0x4

008016c8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	ff 75 10             	pushl  0x10(%ebp)
  8016d2:	ff 75 0c             	pushl  0xc(%ebp)
  8016d5:	ff 75 08             	pushl  0x8(%ebp)
  8016d8:	6a 13                	push   $0x13
  8016da:	e8 9d fb ff ff       	call   80127c <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e2:	90                   	nop
}
  8016e3:	c9                   	leave  
  8016e4:	c3                   	ret    

008016e5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016e5:	55                   	push   %ebp
  8016e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 25                	push   $0x25
  8016f4:	e8 83 fb ff ff       	call   80127c <syscall>
  8016f9:	83 c4 18             	add    $0x18,%esp
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
  801701:	83 ec 04             	sub    $0x4,%esp
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80170a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	50                   	push   %eax
  801717:	6a 26                	push   $0x26
  801719:	e8 5e fb ff ff       	call   80127c <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
	return ;
  801721:	90                   	nop
}
  801722:	c9                   	leave  
  801723:	c3                   	ret    

00801724 <rsttst>:
void rsttst()
{
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 28                	push   $0x28
  801733:	e8 44 fb ff ff       	call   80127c <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
	return ;
  80173b:	90                   	nop
}
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
  801741:	83 ec 04             	sub    $0x4,%esp
  801744:	8b 45 14             	mov    0x14(%ebp),%eax
  801747:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80174a:	8b 55 18             	mov    0x18(%ebp),%edx
  80174d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801751:	52                   	push   %edx
  801752:	50                   	push   %eax
  801753:	ff 75 10             	pushl  0x10(%ebp)
  801756:	ff 75 0c             	pushl  0xc(%ebp)
  801759:	ff 75 08             	pushl  0x8(%ebp)
  80175c:	6a 27                	push   $0x27
  80175e:	e8 19 fb ff ff       	call   80127c <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
	return ;
  801766:	90                   	nop
}
  801767:	c9                   	leave  
  801768:	c3                   	ret    

00801769 <chktst>:
void chktst(uint32 n)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	ff 75 08             	pushl  0x8(%ebp)
  801777:	6a 29                	push   $0x29
  801779:	e8 fe fa ff ff       	call   80127c <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
	return ;
  801781:	90                   	nop
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <inctst>:

void inctst()
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 2a                	push   $0x2a
  801793:	e8 e4 fa ff ff       	call   80127c <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
	return ;
  80179b:	90                   	nop
}
  80179c:	c9                   	leave  
  80179d:	c3                   	ret    

0080179e <gettst>:
uint32 gettst()
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 2b                	push   $0x2b
  8017ad:	e8 ca fa ff ff       	call   80127c <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
  8017ba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 2c                	push   $0x2c
  8017c9:	e8 ae fa ff ff       	call   80127c <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
  8017d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017d4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017d8:	75 07                	jne    8017e1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017da:	b8 01 00 00 00       	mov    $0x1,%eax
  8017df:	eb 05                	jmp    8017e6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
  8017eb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 2c                	push   $0x2c
  8017fa:	e8 7d fa ff ff       	call   80127c <syscall>
  8017ff:	83 c4 18             	add    $0x18,%esp
  801802:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801805:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801809:	75 07                	jne    801812 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80180b:	b8 01 00 00 00       	mov    $0x1,%eax
  801810:	eb 05                	jmp    801817 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801812:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
  80181c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 2c                	push   $0x2c
  80182b:	e8 4c fa ff ff       	call   80127c <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
  801833:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801836:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80183a:	75 07                	jne    801843 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80183c:	b8 01 00 00 00       	mov    $0x1,%eax
  801841:	eb 05                	jmp    801848 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801843:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
  80184d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 2c                	push   $0x2c
  80185c:	e8 1b fa ff ff       	call   80127c <syscall>
  801861:	83 c4 18             	add    $0x18,%esp
  801864:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801867:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80186b:	75 07                	jne    801874 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80186d:	b8 01 00 00 00       	mov    $0x1,%eax
  801872:	eb 05                	jmp    801879 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801874:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	ff 75 08             	pushl  0x8(%ebp)
  801889:	6a 2d                	push   $0x2d
  80188b:	e8 ec f9 ff ff       	call   80127c <syscall>
  801890:	83 c4 18             	add    $0x18,%esp
	return ;
  801893:	90                   	nop
}
  801894:	c9                   	leave  
  801895:	c3                   	ret    
  801896:	66 90                	xchg   %ax,%ax

00801898 <__udivdi3>:
  801898:	55                   	push   %ebp
  801899:	57                   	push   %edi
  80189a:	56                   	push   %esi
  80189b:	53                   	push   %ebx
  80189c:	83 ec 1c             	sub    $0x1c,%esp
  80189f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8018a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8018a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8018af:	89 ca                	mov    %ecx,%edx
  8018b1:	89 f8                	mov    %edi,%eax
  8018b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8018b7:	85 f6                	test   %esi,%esi
  8018b9:	75 2d                	jne    8018e8 <__udivdi3+0x50>
  8018bb:	39 cf                	cmp    %ecx,%edi
  8018bd:	77 65                	ja     801924 <__udivdi3+0x8c>
  8018bf:	89 fd                	mov    %edi,%ebp
  8018c1:	85 ff                	test   %edi,%edi
  8018c3:	75 0b                	jne    8018d0 <__udivdi3+0x38>
  8018c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ca:	31 d2                	xor    %edx,%edx
  8018cc:	f7 f7                	div    %edi
  8018ce:	89 c5                	mov    %eax,%ebp
  8018d0:	31 d2                	xor    %edx,%edx
  8018d2:	89 c8                	mov    %ecx,%eax
  8018d4:	f7 f5                	div    %ebp
  8018d6:	89 c1                	mov    %eax,%ecx
  8018d8:	89 d8                	mov    %ebx,%eax
  8018da:	f7 f5                	div    %ebp
  8018dc:	89 cf                	mov    %ecx,%edi
  8018de:	89 fa                	mov    %edi,%edx
  8018e0:	83 c4 1c             	add    $0x1c,%esp
  8018e3:	5b                   	pop    %ebx
  8018e4:	5e                   	pop    %esi
  8018e5:	5f                   	pop    %edi
  8018e6:	5d                   	pop    %ebp
  8018e7:	c3                   	ret    
  8018e8:	39 ce                	cmp    %ecx,%esi
  8018ea:	77 28                	ja     801914 <__udivdi3+0x7c>
  8018ec:	0f bd fe             	bsr    %esi,%edi
  8018ef:	83 f7 1f             	xor    $0x1f,%edi
  8018f2:	75 40                	jne    801934 <__udivdi3+0x9c>
  8018f4:	39 ce                	cmp    %ecx,%esi
  8018f6:	72 0a                	jb     801902 <__udivdi3+0x6a>
  8018f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018fc:	0f 87 9e 00 00 00    	ja     8019a0 <__udivdi3+0x108>
  801902:	b8 01 00 00 00       	mov    $0x1,%eax
  801907:	89 fa                	mov    %edi,%edx
  801909:	83 c4 1c             	add    $0x1c,%esp
  80190c:	5b                   	pop    %ebx
  80190d:	5e                   	pop    %esi
  80190e:	5f                   	pop    %edi
  80190f:	5d                   	pop    %ebp
  801910:	c3                   	ret    
  801911:	8d 76 00             	lea    0x0(%esi),%esi
  801914:	31 ff                	xor    %edi,%edi
  801916:	31 c0                	xor    %eax,%eax
  801918:	89 fa                	mov    %edi,%edx
  80191a:	83 c4 1c             	add    $0x1c,%esp
  80191d:	5b                   	pop    %ebx
  80191e:	5e                   	pop    %esi
  80191f:	5f                   	pop    %edi
  801920:	5d                   	pop    %ebp
  801921:	c3                   	ret    
  801922:	66 90                	xchg   %ax,%ax
  801924:	89 d8                	mov    %ebx,%eax
  801926:	f7 f7                	div    %edi
  801928:	31 ff                	xor    %edi,%edi
  80192a:	89 fa                	mov    %edi,%edx
  80192c:	83 c4 1c             	add    $0x1c,%esp
  80192f:	5b                   	pop    %ebx
  801930:	5e                   	pop    %esi
  801931:	5f                   	pop    %edi
  801932:	5d                   	pop    %ebp
  801933:	c3                   	ret    
  801934:	bd 20 00 00 00       	mov    $0x20,%ebp
  801939:	89 eb                	mov    %ebp,%ebx
  80193b:	29 fb                	sub    %edi,%ebx
  80193d:	89 f9                	mov    %edi,%ecx
  80193f:	d3 e6                	shl    %cl,%esi
  801941:	89 c5                	mov    %eax,%ebp
  801943:	88 d9                	mov    %bl,%cl
  801945:	d3 ed                	shr    %cl,%ebp
  801947:	89 e9                	mov    %ebp,%ecx
  801949:	09 f1                	or     %esi,%ecx
  80194b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80194f:	89 f9                	mov    %edi,%ecx
  801951:	d3 e0                	shl    %cl,%eax
  801953:	89 c5                	mov    %eax,%ebp
  801955:	89 d6                	mov    %edx,%esi
  801957:	88 d9                	mov    %bl,%cl
  801959:	d3 ee                	shr    %cl,%esi
  80195b:	89 f9                	mov    %edi,%ecx
  80195d:	d3 e2                	shl    %cl,%edx
  80195f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801963:	88 d9                	mov    %bl,%cl
  801965:	d3 e8                	shr    %cl,%eax
  801967:	09 c2                	or     %eax,%edx
  801969:	89 d0                	mov    %edx,%eax
  80196b:	89 f2                	mov    %esi,%edx
  80196d:	f7 74 24 0c          	divl   0xc(%esp)
  801971:	89 d6                	mov    %edx,%esi
  801973:	89 c3                	mov    %eax,%ebx
  801975:	f7 e5                	mul    %ebp
  801977:	39 d6                	cmp    %edx,%esi
  801979:	72 19                	jb     801994 <__udivdi3+0xfc>
  80197b:	74 0b                	je     801988 <__udivdi3+0xf0>
  80197d:	89 d8                	mov    %ebx,%eax
  80197f:	31 ff                	xor    %edi,%edi
  801981:	e9 58 ff ff ff       	jmp    8018de <__udivdi3+0x46>
  801986:	66 90                	xchg   %ax,%ax
  801988:	8b 54 24 08          	mov    0x8(%esp),%edx
  80198c:	89 f9                	mov    %edi,%ecx
  80198e:	d3 e2                	shl    %cl,%edx
  801990:	39 c2                	cmp    %eax,%edx
  801992:	73 e9                	jae    80197d <__udivdi3+0xe5>
  801994:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801997:	31 ff                	xor    %edi,%edi
  801999:	e9 40 ff ff ff       	jmp    8018de <__udivdi3+0x46>
  80199e:	66 90                	xchg   %ax,%ax
  8019a0:	31 c0                	xor    %eax,%eax
  8019a2:	e9 37 ff ff ff       	jmp    8018de <__udivdi3+0x46>
  8019a7:	90                   	nop

008019a8 <__umoddi3>:
  8019a8:	55                   	push   %ebp
  8019a9:	57                   	push   %edi
  8019aa:	56                   	push   %esi
  8019ab:	53                   	push   %ebx
  8019ac:	83 ec 1c             	sub    $0x1c,%esp
  8019af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8019b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8019b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8019bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8019c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8019c7:	89 f3                	mov    %esi,%ebx
  8019c9:	89 fa                	mov    %edi,%edx
  8019cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019cf:	89 34 24             	mov    %esi,(%esp)
  8019d2:	85 c0                	test   %eax,%eax
  8019d4:	75 1a                	jne    8019f0 <__umoddi3+0x48>
  8019d6:	39 f7                	cmp    %esi,%edi
  8019d8:	0f 86 a2 00 00 00    	jbe    801a80 <__umoddi3+0xd8>
  8019de:	89 c8                	mov    %ecx,%eax
  8019e0:	89 f2                	mov    %esi,%edx
  8019e2:	f7 f7                	div    %edi
  8019e4:	89 d0                	mov    %edx,%eax
  8019e6:	31 d2                	xor    %edx,%edx
  8019e8:	83 c4 1c             	add    $0x1c,%esp
  8019eb:	5b                   	pop    %ebx
  8019ec:	5e                   	pop    %esi
  8019ed:	5f                   	pop    %edi
  8019ee:	5d                   	pop    %ebp
  8019ef:	c3                   	ret    
  8019f0:	39 f0                	cmp    %esi,%eax
  8019f2:	0f 87 ac 00 00 00    	ja     801aa4 <__umoddi3+0xfc>
  8019f8:	0f bd e8             	bsr    %eax,%ebp
  8019fb:	83 f5 1f             	xor    $0x1f,%ebp
  8019fe:	0f 84 ac 00 00 00    	je     801ab0 <__umoddi3+0x108>
  801a04:	bf 20 00 00 00       	mov    $0x20,%edi
  801a09:	29 ef                	sub    %ebp,%edi
  801a0b:	89 fe                	mov    %edi,%esi
  801a0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a11:	89 e9                	mov    %ebp,%ecx
  801a13:	d3 e0                	shl    %cl,%eax
  801a15:	89 d7                	mov    %edx,%edi
  801a17:	89 f1                	mov    %esi,%ecx
  801a19:	d3 ef                	shr    %cl,%edi
  801a1b:	09 c7                	or     %eax,%edi
  801a1d:	89 e9                	mov    %ebp,%ecx
  801a1f:	d3 e2                	shl    %cl,%edx
  801a21:	89 14 24             	mov    %edx,(%esp)
  801a24:	89 d8                	mov    %ebx,%eax
  801a26:	d3 e0                	shl    %cl,%eax
  801a28:	89 c2                	mov    %eax,%edx
  801a2a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a2e:	d3 e0                	shl    %cl,%eax
  801a30:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a34:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a38:	89 f1                	mov    %esi,%ecx
  801a3a:	d3 e8                	shr    %cl,%eax
  801a3c:	09 d0                	or     %edx,%eax
  801a3e:	d3 eb                	shr    %cl,%ebx
  801a40:	89 da                	mov    %ebx,%edx
  801a42:	f7 f7                	div    %edi
  801a44:	89 d3                	mov    %edx,%ebx
  801a46:	f7 24 24             	mull   (%esp)
  801a49:	89 c6                	mov    %eax,%esi
  801a4b:	89 d1                	mov    %edx,%ecx
  801a4d:	39 d3                	cmp    %edx,%ebx
  801a4f:	0f 82 87 00 00 00    	jb     801adc <__umoddi3+0x134>
  801a55:	0f 84 91 00 00 00    	je     801aec <__umoddi3+0x144>
  801a5b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a5f:	29 f2                	sub    %esi,%edx
  801a61:	19 cb                	sbb    %ecx,%ebx
  801a63:	89 d8                	mov    %ebx,%eax
  801a65:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a69:	d3 e0                	shl    %cl,%eax
  801a6b:	89 e9                	mov    %ebp,%ecx
  801a6d:	d3 ea                	shr    %cl,%edx
  801a6f:	09 d0                	or     %edx,%eax
  801a71:	89 e9                	mov    %ebp,%ecx
  801a73:	d3 eb                	shr    %cl,%ebx
  801a75:	89 da                	mov    %ebx,%edx
  801a77:	83 c4 1c             	add    $0x1c,%esp
  801a7a:	5b                   	pop    %ebx
  801a7b:	5e                   	pop    %esi
  801a7c:	5f                   	pop    %edi
  801a7d:	5d                   	pop    %ebp
  801a7e:	c3                   	ret    
  801a7f:	90                   	nop
  801a80:	89 fd                	mov    %edi,%ebp
  801a82:	85 ff                	test   %edi,%edi
  801a84:	75 0b                	jne    801a91 <__umoddi3+0xe9>
  801a86:	b8 01 00 00 00       	mov    $0x1,%eax
  801a8b:	31 d2                	xor    %edx,%edx
  801a8d:	f7 f7                	div    %edi
  801a8f:	89 c5                	mov    %eax,%ebp
  801a91:	89 f0                	mov    %esi,%eax
  801a93:	31 d2                	xor    %edx,%edx
  801a95:	f7 f5                	div    %ebp
  801a97:	89 c8                	mov    %ecx,%eax
  801a99:	f7 f5                	div    %ebp
  801a9b:	89 d0                	mov    %edx,%eax
  801a9d:	e9 44 ff ff ff       	jmp    8019e6 <__umoddi3+0x3e>
  801aa2:	66 90                	xchg   %ax,%ax
  801aa4:	89 c8                	mov    %ecx,%eax
  801aa6:	89 f2                	mov    %esi,%edx
  801aa8:	83 c4 1c             	add    $0x1c,%esp
  801aab:	5b                   	pop    %ebx
  801aac:	5e                   	pop    %esi
  801aad:	5f                   	pop    %edi
  801aae:	5d                   	pop    %ebp
  801aaf:	c3                   	ret    
  801ab0:	3b 04 24             	cmp    (%esp),%eax
  801ab3:	72 06                	jb     801abb <__umoddi3+0x113>
  801ab5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ab9:	77 0f                	ja     801aca <__umoddi3+0x122>
  801abb:	89 f2                	mov    %esi,%edx
  801abd:	29 f9                	sub    %edi,%ecx
  801abf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ac3:	89 14 24             	mov    %edx,(%esp)
  801ac6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801aca:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ace:	8b 14 24             	mov    (%esp),%edx
  801ad1:	83 c4 1c             	add    $0x1c,%esp
  801ad4:	5b                   	pop    %ebx
  801ad5:	5e                   	pop    %esi
  801ad6:	5f                   	pop    %edi
  801ad7:	5d                   	pop    %ebp
  801ad8:	c3                   	ret    
  801ad9:	8d 76 00             	lea    0x0(%esi),%esi
  801adc:	2b 04 24             	sub    (%esp),%eax
  801adf:	19 fa                	sbb    %edi,%edx
  801ae1:	89 d1                	mov    %edx,%ecx
  801ae3:	89 c6                	mov    %eax,%esi
  801ae5:	e9 71 ff ff ff       	jmp    801a5b <__umoddi3+0xb3>
  801aea:	66 90                	xchg   %ax,%ax
  801aec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801af0:	72 ea                	jb     801adc <__umoddi3+0x134>
  801af2:	89 d9                	mov    %ebx,%ecx
  801af4:	e9 62 ff ff ff       	jmp    801a5b <__umoddi3+0xb3>
