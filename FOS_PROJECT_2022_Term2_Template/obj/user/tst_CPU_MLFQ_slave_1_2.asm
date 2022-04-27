
obj/user/tst_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 69 00 00 00       	call   80009f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 2f                	jmp    800076 <_main+0x3e>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), 0);
  800047:	a1 04 20 80 00       	mov    0x802004,%eax
  80004c:	8b 40 74             	mov    0x74(%eax),%eax
  80004f:	83 ec 04             	sub    $0x4,%esp
  800052:	6a 00                	push   $0x0
  800054:	50                   	push   %eax
  800055:	68 40 19 80 00       	push   $0x801940
  80005a:	e8 6e 13 00 00       	call   8013cd <sys_create_env>
  80005f:	83 c4 10             	add    $0x10,%esp
  800062:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  800065:	83 ec 0c             	sub    $0xc,%esp
  800068:	ff 75 f0             	pushl  -0x10(%ebp)
  80006b:	e8 7a 13 00 00       	call   8013ea <sys_run_env>
  800070:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  800073:	ff 45 f4             	incl   -0xc(%ebp)
  800076:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80007a:	7e cb                	jle    800047 <_main+0xf>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), 0);
		sys_run_env(ID);
	}

	env_sleep(100000);
  80007c:	83 ec 0c             	sub    $0xc,%esp
  80007f:	68 a0 86 01 00       	push   $0x186a0
  800084:	e8 9d 15 00 00       	call   801626 <env_sleep>
  800089:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test CPU SCHEDULING using MLFQ is completed successfully.\n");
  80008c:	83 ec 0c             	sub    $0xc,%esp
  80008f:	68 50 19 80 00       	push   $0x801950
  800094:	e8 e9 01 00 00       	call   800282 <cprintf>
  800099:	83 c4 10             	add    $0x10,%esp

	return;
  80009c:	90                   	nop
}
  80009d:	c9                   	leave  
  80009e:	c3                   	ret    

0080009f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80009f:	55                   	push   %ebp
  8000a0:	89 e5                	mov    %esp,%ebp
  8000a2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000a5:	e8 03 10 00 00       	call   8010ad <sys_getenvindex>
  8000aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b0:	89 d0                	mov    %edx,%eax
  8000b2:	c1 e0 02             	shl    $0x2,%eax
  8000b5:	01 d0                	add    %edx,%eax
  8000b7:	01 c0                	add    %eax,%eax
  8000b9:	01 d0                	add    %edx,%eax
  8000bb:	01 c0                	add    %eax,%eax
  8000bd:	01 d0                	add    %edx,%eax
  8000bf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c1 e0 02             	shl    $0x2,%eax
  8000cb:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000d0:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000d5:	a1 04 20 80 00       	mov    0x802004,%eax
  8000da:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000e0:	84 c0                	test   %al,%al
  8000e2:	74 0f                	je     8000f3 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000e4:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e9:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000ee:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f7:	7e 0a                	jle    800103 <libmain+0x64>
		binaryname = argv[0];
  8000f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000fc:	8b 00                	mov    (%eax),%eax
  8000fe:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	ff 75 0c             	pushl  0xc(%ebp)
  800109:	ff 75 08             	pushl  0x8(%ebp)
  80010c:	e8 27 ff ff ff       	call   800038 <_main>
  800111:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800114:	e8 2f 11 00 00       	call   801248 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 b8 19 80 00       	push   $0x8019b8
  800121:	e8 5c 01 00 00       	call   800282 <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800129:	a1 04 20 80 00       	mov    0x802004,%eax
  80012e:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800134:	a1 04 20 80 00       	mov    0x802004,%eax
  800139:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	52                   	push   %edx
  800143:	50                   	push   %eax
  800144:	68 e0 19 80 00       	push   $0x8019e0
  800149:	e8 34 01 00 00       	call   800282 <cprintf>
  80014e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800151:	a1 04 20 80 00       	mov    0x802004,%eax
  800156:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80015c:	83 ec 08             	sub    $0x8,%esp
  80015f:	50                   	push   %eax
  800160:	68 05 1a 80 00       	push   $0x801a05
  800165:	e8 18 01 00 00       	call   800282 <cprintf>
  80016a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80016d:	83 ec 0c             	sub    $0xc,%esp
  800170:	68 b8 19 80 00       	push   $0x8019b8
  800175:	e8 08 01 00 00       	call   800282 <cprintf>
  80017a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80017d:	e8 e0 10 00 00       	call   801262 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800182:	e8 19 00 00 00       	call   8001a0 <exit>
}
  800187:	90                   	nop
  800188:	c9                   	leave  
  800189:	c3                   	ret    

0080018a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80018a:	55                   	push   %ebp
  80018b:	89 e5                	mov    %esp,%ebp
  80018d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800190:	83 ec 0c             	sub    $0xc,%esp
  800193:	6a 00                	push   $0x0
  800195:	e8 df 0e 00 00       	call   801079 <sys_env_destroy>
  80019a:	83 c4 10             	add    $0x10,%esp
}
  80019d:	90                   	nop
  80019e:	c9                   	leave  
  80019f:	c3                   	ret    

008001a0 <exit>:

void
exit(void)
{
  8001a0:	55                   	push   %ebp
  8001a1:	89 e5                	mov    %esp,%ebp
  8001a3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a6:	e8 34 0f 00 00       	call   8010df <sys_env_exit>
}
  8001ab:	90                   	nop
  8001ac:	c9                   	leave  
  8001ad:	c3                   	ret    

008001ae <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ae:	55                   	push   %ebp
  8001af:	89 e5                	mov    %esp,%ebp
  8001b1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b7:	8b 00                	mov    (%eax),%eax
  8001b9:	8d 48 01             	lea    0x1(%eax),%ecx
  8001bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001bf:	89 0a                	mov    %ecx,(%edx)
  8001c1:	8b 55 08             	mov    0x8(%ebp),%edx
  8001c4:	88 d1                	mov    %dl,%cl
  8001c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d0:	8b 00                	mov    (%eax),%eax
  8001d2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001d7:	75 2c                	jne    800205 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001d9:	a0 08 20 80 00       	mov    0x802008,%al
  8001de:	0f b6 c0             	movzbl %al,%eax
  8001e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e4:	8b 12                	mov    (%edx),%edx
  8001e6:	89 d1                	mov    %edx,%ecx
  8001e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001eb:	83 c2 08             	add    $0x8,%edx
  8001ee:	83 ec 04             	sub    $0x4,%esp
  8001f1:	50                   	push   %eax
  8001f2:	51                   	push   %ecx
  8001f3:	52                   	push   %edx
  8001f4:	e8 3e 0e 00 00       	call   801037 <sys_cputs>
  8001f9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800205:	8b 45 0c             	mov    0xc(%ebp),%eax
  800208:	8b 40 04             	mov    0x4(%eax),%eax
  80020b:	8d 50 01             	lea    0x1(%eax),%edx
  80020e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800211:	89 50 04             	mov    %edx,0x4(%eax)
}
  800214:	90                   	nop
  800215:	c9                   	leave  
  800216:	c3                   	ret    

00800217 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800217:	55                   	push   %ebp
  800218:	89 e5                	mov    %esp,%ebp
  80021a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800220:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800227:	00 00 00 
	b.cnt = 0;
  80022a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800231:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800234:	ff 75 0c             	pushl  0xc(%ebp)
  800237:	ff 75 08             	pushl  0x8(%ebp)
  80023a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800240:	50                   	push   %eax
  800241:	68 ae 01 80 00       	push   $0x8001ae
  800246:	e8 11 02 00 00       	call   80045c <vprintfmt>
  80024b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80024e:	a0 08 20 80 00       	mov    0x802008,%al
  800253:	0f b6 c0             	movzbl %al,%eax
  800256:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80025c:	83 ec 04             	sub    $0x4,%esp
  80025f:	50                   	push   %eax
  800260:	52                   	push   %edx
  800261:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800267:	83 c0 08             	add    $0x8,%eax
  80026a:	50                   	push   %eax
  80026b:	e8 c7 0d 00 00       	call   801037 <sys_cputs>
  800270:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800273:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80027a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800280:	c9                   	leave  
  800281:	c3                   	ret    

00800282 <cprintf>:

int cprintf(const char *fmt, ...) {
  800282:	55                   	push   %ebp
  800283:	89 e5                	mov    %esp,%ebp
  800285:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800288:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  80028f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800292:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800295:	8b 45 08             	mov    0x8(%ebp),%eax
  800298:	83 ec 08             	sub    $0x8,%esp
  80029b:	ff 75 f4             	pushl  -0xc(%ebp)
  80029e:	50                   	push   %eax
  80029f:	e8 73 ff ff ff       	call   800217 <vcprintf>
  8002a4:	83 c4 10             	add    $0x10,%esp
  8002a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ad:	c9                   	leave  
  8002ae:	c3                   	ret    

008002af <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002af:	55                   	push   %ebp
  8002b0:	89 e5                	mov    %esp,%ebp
  8002b2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002b5:	e8 8e 0f 00 00       	call   801248 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002ba:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c3:	83 ec 08             	sub    $0x8,%esp
  8002c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c9:	50                   	push   %eax
  8002ca:	e8 48 ff ff ff       	call   800217 <vcprintf>
  8002cf:	83 c4 10             	add    $0x10,%esp
  8002d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002d5:	e8 88 0f 00 00       	call   801262 <sys_enable_interrupt>
	return cnt;
  8002da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002dd:	c9                   	leave  
  8002de:	c3                   	ret    

008002df <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002df:	55                   	push   %ebp
  8002e0:	89 e5                	mov    %esp,%ebp
  8002e2:	53                   	push   %ebx
  8002e3:	83 ec 14             	sub    $0x14,%esp
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002f2:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f5:	ba 00 00 00 00       	mov    $0x0,%edx
  8002fa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002fd:	77 55                	ja     800354 <printnum+0x75>
  8002ff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800302:	72 05                	jb     800309 <printnum+0x2a>
  800304:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800307:	77 4b                	ja     800354 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800309:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80030c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80030f:	8b 45 18             	mov    0x18(%ebp),%eax
  800312:	ba 00 00 00 00       	mov    $0x0,%edx
  800317:	52                   	push   %edx
  800318:	50                   	push   %eax
  800319:	ff 75 f4             	pushl  -0xc(%ebp)
  80031c:	ff 75 f0             	pushl  -0x10(%ebp)
  80031f:	e8 b8 13 00 00       	call   8016dc <__udivdi3>
  800324:	83 c4 10             	add    $0x10,%esp
  800327:	83 ec 04             	sub    $0x4,%esp
  80032a:	ff 75 20             	pushl  0x20(%ebp)
  80032d:	53                   	push   %ebx
  80032e:	ff 75 18             	pushl  0x18(%ebp)
  800331:	52                   	push   %edx
  800332:	50                   	push   %eax
  800333:	ff 75 0c             	pushl  0xc(%ebp)
  800336:	ff 75 08             	pushl  0x8(%ebp)
  800339:	e8 a1 ff ff ff       	call   8002df <printnum>
  80033e:	83 c4 20             	add    $0x20,%esp
  800341:	eb 1a                	jmp    80035d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800343:	83 ec 08             	sub    $0x8,%esp
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	ff 75 20             	pushl  0x20(%ebp)
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	ff d0                	call   *%eax
  800351:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800354:	ff 4d 1c             	decl   0x1c(%ebp)
  800357:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80035b:	7f e6                	jg     800343 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80035d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800360:	bb 00 00 00 00       	mov    $0x0,%ebx
  800365:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800368:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80036b:	53                   	push   %ebx
  80036c:	51                   	push   %ecx
  80036d:	52                   	push   %edx
  80036e:	50                   	push   %eax
  80036f:	e8 78 14 00 00       	call   8017ec <__umoddi3>
  800374:	83 c4 10             	add    $0x10,%esp
  800377:	05 34 1c 80 00       	add    $0x801c34,%eax
  80037c:	8a 00                	mov    (%eax),%al
  80037e:	0f be c0             	movsbl %al,%eax
  800381:	83 ec 08             	sub    $0x8,%esp
  800384:	ff 75 0c             	pushl  0xc(%ebp)
  800387:	50                   	push   %eax
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	ff d0                	call   *%eax
  80038d:	83 c4 10             	add    $0x10,%esp
}
  800390:	90                   	nop
  800391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800394:	c9                   	leave  
  800395:	c3                   	ret    

00800396 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800396:	55                   	push   %ebp
  800397:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800399:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80039d:	7e 1c                	jle    8003bb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80039f:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a2:	8b 00                	mov    (%eax),%eax
  8003a4:	8d 50 08             	lea    0x8(%eax),%edx
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	89 10                	mov    %edx,(%eax)
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	8b 00                	mov    (%eax),%eax
  8003b1:	83 e8 08             	sub    $0x8,%eax
  8003b4:	8b 50 04             	mov    0x4(%eax),%edx
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	eb 40                	jmp    8003fb <getuint+0x65>
	else if (lflag)
  8003bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003bf:	74 1e                	je     8003df <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	8b 00                	mov    (%eax),%eax
  8003c6:	8d 50 04             	lea    0x4(%eax),%edx
  8003c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cc:	89 10                	mov    %edx,(%eax)
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	83 e8 04             	sub    $0x4,%eax
  8003d6:	8b 00                	mov    (%eax),%eax
  8003d8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003dd:	eb 1c                	jmp    8003fb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003df:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	8d 50 04             	lea    0x4(%eax),%edx
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	89 10                	mov    %edx,(%eax)
  8003ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ef:	8b 00                	mov    (%eax),%eax
  8003f1:	83 e8 04             	sub    $0x4,%eax
  8003f4:	8b 00                	mov    (%eax),%eax
  8003f6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003fb:	5d                   	pop    %ebp
  8003fc:	c3                   	ret    

008003fd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003fd:	55                   	push   %ebp
  8003fe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800400:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800404:	7e 1c                	jle    800422 <getint+0x25>
		return va_arg(*ap, long long);
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	8d 50 08             	lea    0x8(%eax),%edx
  80040e:	8b 45 08             	mov    0x8(%ebp),%eax
  800411:	89 10                	mov    %edx,(%eax)
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	83 e8 08             	sub    $0x8,%eax
  80041b:	8b 50 04             	mov    0x4(%eax),%edx
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	eb 38                	jmp    80045a <getint+0x5d>
	else if (lflag)
  800422:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800426:	74 1a                	je     800442 <getint+0x45>
		return va_arg(*ap, long);
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	8d 50 04             	lea    0x4(%eax),%edx
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	89 10                	mov    %edx,(%eax)
  800435:	8b 45 08             	mov    0x8(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	83 e8 04             	sub    $0x4,%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	99                   	cltd   
  800440:	eb 18                	jmp    80045a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	8b 00                	mov    (%eax),%eax
  800447:	8d 50 04             	lea    0x4(%eax),%edx
  80044a:	8b 45 08             	mov    0x8(%ebp),%eax
  80044d:	89 10                	mov    %edx,(%eax)
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	83 e8 04             	sub    $0x4,%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	99                   	cltd   
}
  80045a:	5d                   	pop    %ebp
  80045b:	c3                   	ret    

0080045c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80045c:	55                   	push   %ebp
  80045d:	89 e5                	mov    %esp,%ebp
  80045f:	56                   	push   %esi
  800460:	53                   	push   %ebx
  800461:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800464:	eb 17                	jmp    80047d <vprintfmt+0x21>
			if (ch == '\0')
  800466:	85 db                	test   %ebx,%ebx
  800468:	0f 84 af 03 00 00    	je     80081d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80046e:	83 ec 08             	sub    $0x8,%esp
  800471:	ff 75 0c             	pushl  0xc(%ebp)
  800474:	53                   	push   %ebx
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	ff d0                	call   *%eax
  80047a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80047d:	8b 45 10             	mov    0x10(%ebp),%eax
  800480:	8d 50 01             	lea    0x1(%eax),%edx
  800483:	89 55 10             	mov    %edx,0x10(%ebp)
  800486:	8a 00                	mov    (%eax),%al
  800488:	0f b6 d8             	movzbl %al,%ebx
  80048b:	83 fb 25             	cmp    $0x25,%ebx
  80048e:	75 d6                	jne    800466 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800490:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800494:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80049b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004a2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004a9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b3:	8d 50 01             	lea    0x1(%eax),%edx
  8004b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b9:	8a 00                	mov    (%eax),%al
  8004bb:	0f b6 d8             	movzbl %al,%ebx
  8004be:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004c1:	83 f8 55             	cmp    $0x55,%eax
  8004c4:	0f 87 2b 03 00 00    	ja     8007f5 <vprintfmt+0x399>
  8004ca:	8b 04 85 58 1c 80 00 	mov    0x801c58(,%eax,4),%eax
  8004d1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004d3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004d7:	eb d7                	jmp    8004b0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004d9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004dd:	eb d1                	jmp    8004b0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004e6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004e9:	89 d0                	mov    %edx,%eax
  8004eb:	c1 e0 02             	shl    $0x2,%eax
  8004ee:	01 d0                	add    %edx,%eax
  8004f0:	01 c0                	add    %eax,%eax
  8004f2:	01 d8                	add    %ebx,%eax
  8004f4:	83 e8 30             	sub    $0x30,%eax
  8004f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fd:	8a 00                	mov    (%eax),%al
  8004ff:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800502:	83 fb 2f             	cmp    $0x2f,%ebx
  800505:	7e 3e                	jle    800545 <vprintfmt+0xe9>
  800507:	83 fb 39             	cmp    $0x39,%ebx
  80050a:	7f 39                	jg     800545 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80050f:	eb d5                	jmp    8004e6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800511:	8b 45 14             	mov    0x14(%ebp),%eax
  800514:	83 c0 04             	add    $0x4,%eax
  800517:	89 45 14             	mov    %eax,0x14(%ebp)
  80051a:	8b 45 14             	mov    0x14(%ebp),%eax
  80051d:	83 e8 04             	sub    $0x4,%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800525:	eb 1f                	jmp    800546 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800527:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80052b:	79 83                	jns    8004b0 <vprintfmt+0x54>
				width = 0;
  80052d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800534:	e9 77 ff ff ff       	jmp    8004b0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800539:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800540:	e9 6b ff ff ff       	jmp    8004b0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800545:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800546:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80054a:	0f 89 60 ff ff ff    	jns    8004b0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800550:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800553:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800556:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80055d:	e9 4e ff ff ff       	jmp    8004b0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800562:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800565:	e9 46 ff ff ff       	jmp    8004b0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80056a:	8b 45 14             	mov    0x14(%ebp),%eax
  80056d:	83 c0 04             	add    $0x4,%eax
  800570:	89 45 14             	mov    %eax,0x14(%ebp)
  800573:	8b 45 14             	mov    0x14(%ebp),%eax
  800576:	83 e8 04             	sub    $0x4,%eax
  800579:	8b 00                	mov    (%eax),%eax
  80057b:	83 ec 08             	sub    $0x8,%esp
  80057e:	ff 75 0c             	pushl  0xc(%ebp)
  800581:	50                   	push   %eax
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	ff d0                	call   *%eax
  800587:	83 c4 10             	add    $0x10,%esp
			break;
  80058a:	e9 89 02 00 00       	jmp    800818 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80058f:	8b 45 14             	mov    0x14(%ebp),%eax
  800592:	83 c0 04             	add    $0x4,%eax
  800595:	89 45 14             	mov    %eax,0x14(%ebp)
  800598:	8b 45 14             	mov    0x14(%ebp),%eax
  80059b:	83 e8 04             	sub    $0x4,%eax
  80059e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005a0:	85 db                	test   %ebx,%ebx
  8005a2:	79 02                	jns    8005a6 <vprintfmt+0x14a>
				err = -err;
  8005a4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005a6:	83 fb 64             	cmp    $0x64,%ebx
  8005a9:	7f 0b                	jg     8005b6 <vprintfmt+0x15a>
  8005ab:	8b 34 9d a0 1a 80 00 	mov    0x801aa0(,%ebx,4),%esi
  8005b2:	85 f6                	test   %esi,%esi
  8005b4:	75 19                	jne    8005cf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005b6:	53                   	push   %ebx
  8005b7:	68 45 1c 80 00       	push   $0x801c45
  8005bc:	ff 75 0c             	pushl  0xc(%ebp)
  8005bf:	ff 75 08             	pushl  0x8(%ebp)
  8005c2:	e8 5e 02 00 00       	call   800825 <printfmt>
  8005c7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ca:	e9 49 02 00 00       	jmp    800818 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005cf:	56                   	push   %esi
  8005d0:	68 4e 1c 80 00       	push   $0x801c4e
  8005d5:	ff 75 0c             	pushl  0xc(%ebp)
  8005d8:	ff 75 08             	pushl  0x8(%ebp)
  8005db:	e8 45 02 00 00       	call   800825 <printfmt>
  8005e0:	83 c4 10             	add    $0x10,%esp
			break;
  8005e3:	e9 30 02 00 00       	jmp    800818 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005eb:	83 c0 04             	add    $0x4,%eax
  8005ee:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f4:	83 e8 04             	sub    $0x4,%eax
  8005f7:	8b 30                	mov    (%eax),%esi
  8005f9:	85 f6                	test   %esi,%esi
  8005fb:	75 05                	jne    800602 <vprintfmt+0x1a6>
				p = "(null)";
  8005fd:	be 51 1c 80 00       	mov    $0x801c51,%esi
			if (width > 0 && padc != '-')
  800602:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800606:	7e 6d                	jle    800675 <vprintfmt+0x219>
  800608:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80060c:	74 67                	je     800675 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80060e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800611:	83 ec 08             	sub    $0x8,%esp
  800614:	50                   	push   %eax
  800615:	56                   	push   %esi
  800616:	e8 0c 03 00 00       	call   800927 <strnlen>
  80061b:	83 c4 10             	add    $0x10,%esp
  80061e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800621:	eb 16                	jmp    800639 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800623:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800627:	83 ec 08             	sub    $0x8,%esp
  80062a:	ff 75 0c             	pushl  0xc(%ebp)
  80062d:	50                   	push   %eax
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	ff d0                	call   *%eax
  800633:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800636:	ff 4d e4             	decl   -0x1c(%ebp)
  800639:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063d:	7f e4                	jg     800623 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80063f:	eb 34                	jmp    800675 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800641:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800645:	74 1c                	je     800663 <vprintfmt+0x207>
  800647:	83 fb 1f             	cmp    $0x1f,%ebx
  80064a:	7e 05                	jle    800651 <vprintfmt+0x1f5>
  80064c:	83 fb 7e             	cmp    $0x7e,%ebx
  80064f:	7e 12                	jle    800663 <vprintfmt+0x207>
					putch('?', putdat);
  800651:	83 ec 08             	sub    $0x8,%esp
  800654:	ff 75 0c             	pushl  0xc(%ebp)
  800657:	6a 3f                	push   $0x3f
  800659:	8b 45 08             	mov    0x8(%ebp),%eax
  80065c:	ff d0                	call   *%eax
  80065e:	83 c4 10             	add    $0x10,%esp
  800661:	eb 0f                	jmp    800672 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800663:	83 ec 08             	sub    $0x8,%esp
  800666:	ff 75 0c             	pushl  0xc(%ebp)
  800669:	53                   	push   %ebx
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	ff d0                	call   *%eax
  80066f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800672:	ff 4d e4             	decl   -0x1c(%ebp)
  800675:	89 f0                	mov    %esi,%eax
  800677:	8d 70 01             	lea    0x1(%eax),%esi
  80067a:	8a 00                	mov    (%eax),%al
  80067c:	0f be d8             	movsbl %al,%ebx
  80067f:	85 db                	test   %ebx,%ebx
  800681:	74 24                	je     8006a7 <vprintfmt+0x24b>
  800683:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800687:	78 b8                	js     800641 <vprintfmt+0x1e5>
  800689:	ff 4d e0             	decl   -0x20(%ebp)
  80068c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800690:	79 af                	jns    800641 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800692:	eb 13                	jmp    8006a7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800694:	83 ec 08             	sub    $0x8,%esp
  800697:	ff 75 0c             	pushl  0xc(%ebp)
  80069a:	6a 20                	push   $0x20
  80069c:	8b 45 08             	mov    0x8(%ebp),%eax
  80069f:	ff d0                	call   *%eax
  8006a1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a4:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ab:	7f e7                	jg     800694 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ad:	e9 66 01 00 00       	jmp    800818 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 e8             	pushl  -0x18(%ebp)
  8006b8:	8d 45 14             	lea    0x14(%ebp),%eax
  8006bb:	50                   	push   %eax
  8006bc:	e8 3c fd ff ff       	call   8003fd <getint>
  8006c1:	83 c4 10             	add    $0x10,%esp
  8006c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d0:	85 d2                	test   %edx,%edx
  8006d2:	79 23                	jns    8006f7 <vprintfmt+0x29b>
				putch('-', putdat);
  8006d4:	83 ec 08             	sub    $0x8,%esp
  8006d7:	ff 75 0c             	pushl  0xc(%ebp)
  8006da:	6a 2d                	push   $0x2d
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	ff d0                	call   *%eax
  8006e1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ea:	f7 d8                	neg    %eax
  8006ec:	83 d2 00             	adc    $0x0,%edx
  8006ef:	f7 da                	neg    %edx
  8006f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006f7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006fe:	e9 bc 00 00 00       	jmp    8007bf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 e8             	pushl  -0x18(%ebp)
  800709:	8d 45 14             	lea    0x14(%ebp),%eax
  80070c:	50                   	push   %eax
  80070d:	e8 84 fc ff ff       	call   800396 <getuint>
  800712:	83 c4 10             	add    $0x10,%esp
  800715:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800718:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80071b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800722:	e9 98 00 00 00       	jmp    8007bf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	6a 58                	push   $0x58
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800737:	83 ec 08             	sub    $0x8,%esp
  80073a:	ff 75 0c             	pushl  0xc(%ebp)
  80073d:	6a 58                	push   $0x58
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	ff d0                	call   *%eax
  800744:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800747:	83 ec 08             	sub    $0x8,%esp
  80074a:	ff 75 0c             	pushl  0xc(%ebp)
  80074d:	6a 58                	push   $0x58
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	ff d0                	call   *%eax
  800754:	83 c4 10             	add    $0x10,%esp
			break;
  800757:	e9 bc 00 00 00       	jmp    800818 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 0c             	pushl  0xc(%ebp)
  800762:	6a 30                	push   $0x30
  800764:	8b 45 08             	mov    0x8(%ebp),%eax
  800767:	ff d0                	call   *%eax
  800769:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 0c             	pushl  0xc(%ebp)
  800772:	6a 78                	push   $0x78
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80077c:	8b 45 14             	mov    0x14(%ebp),%eax
  80077f:	83 c0 04             	add    $0x4,%eax
  800782:	89 45 14             	mov    %eax,0x14(%ebp)
  800785:	8b 45 14             	mov    0x14(%ebp),%eax
  800788:	83 e8 04             	sub    $0x4,%eax
  80078b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80078d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800790:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800797:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80079e:	eb 1f                	jmp    8007bf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007a0:	83 ec 08             	sub    $0x8,%esp
  8007a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a6:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a9:	50                   	push   %eax
  8007aa:	e8 e7 fb ff ff       	call   800396 <getuint>
  8007af:	83 c4 10             	add    $0x10,%esp
  8007b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007b8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007bf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c6:	83 ec 04             	sub    $0x4,%esp
  8007c9:	52                   	push   %edx
  8007ca:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007cd:	50                   	push   %eax
  8007ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8007d4:	ff 75 0c             	pushl  0xc(%ebp)
  8007d7:	ff 75 08             	pushl  0x8(%ebp)
  8007da:	e8 00 fb ff ff       	call   8002df <printnum>
  8007df:	83 c4 20             	add    $0x20,%esp
			break;
  8007e2:	eb 34                	jmp    800818 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007e4:	83 ec 08             	sub    $0x8,%esp
  8007e7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ea:	53                   	push   %ebx
  8007eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ee:	ff d0                	call   *%eax
  8007f0:	83 c4 10             	add    $0x10,%esp
			break;
  8007f3:	eb 23                	jmp    800818 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	6a 25                	push   $0x25
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800805:	ff 4d 10             	decl   0x10(%ebp)
  800808:	eb 03                	jmp    80080d <vprintfmt+0x3b1>
  80080a:	ff 4d 10             	decl   0x10(%ebp)
  80080d:	8b 45 10             	mov    0x10(%ebp),%eax
  800810:	48                   	dec    %eax
  800811:	8a 00                	mov    (%eax),%al
  800813:	3c 25                	cmp    $0x25,%al
  800815:	75 f3                	jne    80080a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800817:	90                   	nop
		}
	}
  800818:	e9 47 fc ff ff       	jmp    800464 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80081d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80081e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800821:	5b                   	pop    %ebx
  800822:	5e                   	pop    %esi
  800823:	5d                   	pop    %ebp
  800824:	c3                   	ret    

00800825 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800825:	55                   	push   %ebp
  800826:	89 e5                	mov    %esp,%ebp
  800828:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80082b:	8d 45 10             	lea    0x10(%ebp),%eax
  80082e:	83 c0 04             	add    $0x4,%eax
  800831:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800834:	8b 45 10             	mov    0x10(%ebp),%eax
  800837:	ff 75 f4             	pushl  -0xc(%ebp)
  80083a:	50                   	push   %eax
  80083b:	ff 75 0c             	pushl  0xc(%ebp)
  80083e:	ff 75 08             	pushl  0x8(%ebp)
  800841:	e8 16 fc ff ff       	call   80045c <vprintfmt>
  800846:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800849:	90                   	nop
  80084a:	c9                   	leave  
  80084b:	c3                   	ret    

0080084c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80084c:	55                   	push   %ebp
  80084d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80084f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800852:	8b 40 08             	mov    0x8(%eax),%eax
  800855:	8d 50 01             	lea    0x1(%eax),%edx
  800858:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80085e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800861:	8b 10                	mov    (%eax),%edx
  800863:	8b 45 0c             	mov    0xc(%ebp),%eax
  800866:	8b 40 04             	mov    0x4(%eax),%eax
  800869:	39 c2                	cmp    %eax,%edx
  80086b:	73 12                	jae    80087f <sprintputch+0x33>
		*b->buf++ = ch;
  80086d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	8d 48 01             	lea    0x1(%eax),%ecx
  800875:	8b 55 0c             	mov    0xc(%ebp),%edx
  800878:	89 0a                	mov    %ecx,(%edx)
  80087a:	8b 55 08             	mov    0x8(%ebp),%edx
  80087d:	88 10                	mov    %dl,(%eax)
}
  80087f:	90                   	nop
  800880:	5d                   	pop    %ebp
  800881:	c3                   	ret    

00800882 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800882:	55                   	push   %ebp
  800883:	89 e5                	mov    %esp,%ebp
  800885:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800888:	8b 45 08             	mov    0x8(%ebp),%eax
  80088b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80088e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800891:	8d 50 ff             	lea    -0x1(%eax),%edx
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	01 d0                	add    %edx,%eax
  800899:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a7:	74 06                	je     8008af <vsnprintf+0x2d>
  8008a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ad:	7f 07                	jg     8008b6 <vsnprintf+0x34>
		return -E_INVAL;
  8008af:	b8 03 00 00 00       	mov    $0x3,%eax
  8008b4:	eb 20                	jmp    8008d6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008b6:	ff 75 14             	pushl  0x14(%ebp)
  8008b9:	ff 75 10             	pushl  0x10(%ebp)
  8008bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008bf:	50                   	push   %eax
  8008c0:	68 4c 08 80 00       	push   $0x80084c
  8008c5:	e8 92 fb ff ff       	call   80045c <vprintfmt>
  8008ca:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008d0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008d6:	c9                   	leave  
  8008d7:	c3                   	ret    

008008d8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008d8:	55                   	push   %ebp
  8008d9:	89 e5                	mov    %esp,%ebp
  8008db:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008de:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e1:	83 c0 04             	add    $0x4,%eax
  8008e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ed:	50                   	push   %eax
  8008ee:	ff 75 0c             	pushl  0xc(%ebp)
  8008f1:	ff 75 08             	pushl  0x8(%ebp)
  8008f4:	e8 89 ff ff ff       	call   800882 <vsnprintf>
  8008f9:	83 c4 10             	add    $0x10,%esp
  8008fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800902:	c9                   	leave  
  800903:	c3                   	ret    

00800904 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800904:	55                   	push   %ebp
  800905:	89 e5                	mov    %esp,%ebp
  800907:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80090a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800911:	eb 06                	jmp    800919 <strlen+0x15>
		n++;
  800913:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800916:	ff 45 08             	incl   0x8(%ebp)
  800919:	8b 45 08             	mov    0x8(%ebp),%eax
  80091c:	8a 00                	mov    (%eax),%al
  80091e:	84 c0                	test   %al,%al
  800920:	75 f1                	jne    800913 <strlen+0xf>
		n++;
	return n;
  800922:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800925:	c9                   	leave  
  800926:	c3                   	ret    

00800927 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800927:	55                   	push   %ebp
  800928:	89 e5                	mov    %esp,%ebp
  80092a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80092d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800934:	eb 09                	jmp    80093f <strnlen+0x18>
		n++;
  800936:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800939:	ff 45 08             	incl   0x8(%ebp)
  80093c:	ff 4d 0c             	decl   0xc(%ebp)
  80093f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800943:	74 09                	je     80094e <strnlen+0x27>
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	8a 00                	mov    (%eax),%al
  80094a:	84 c0                	test   %al,%al
  80094c:	75 e8                	jne    800936 <strnlen+0xf>
		n++;
	return n;
  80094e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800951:	c9                   	leave  
  800952:	c3                   	ret    

00800953 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800953:	55                   	push   %ebp
  800954:	89 e5                	mov    %esp,%ebp
  800956:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80095f:	90                   	nop
  800960:	8b 45 08             	mov    0x8(%ebp),%eax
  800963:	8d 50 01             	lea    0x1(%eax),%edx
  800966:	89 55 08             	mov    %edx,0x8(%ebp)
  800969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80096f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800972:	8a 12                	mov    (%edx),%dl
  800974:	88 10                	mov    %dl,(%eax)
  800976:	8a 00                	mov    (%eax),%al
  800978:	84 c0                	test   %al,%al
  80097a:	75 e4                	jne    800960 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80097c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097f:	c9                   	leave  
  800980:	c3                   	ret    

00800981 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800981:	55                   	push   %ebp
  800982:	89 e5                	mov    %esp,%ebp
  800984:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80098d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800994:	eb 1f                	jmp    8009b5 <strncpy+0x34>
		*dst++ = *src;
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	8d 50 01             	lea    0x1(%eax),%edx
  80099c:	89 55 08             	mov    %edx,0x8(%ebp)
  80099f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a2:	8a 12                	mov    (%edx),%dl
  8009a4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a9:	8a 00                	mov    (%eax),%al
  8009ab:	84 c0                	test   %al,%al
  8009ad:	74 03                	je     8009b2 <strncpy+0x31>
			src++;
  8009af:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009b2:	ff 45 fc             	incl   -0x4(%ebp)
  8009b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009b8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009bb:	72 d9                	jb     800996 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009c0:	c9                   	leave  
  8009c1:	c3                   	ret    

008009c2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009c2:	55                   	push   %ebp
  8009c3:	89 e5                	mov    %esp,%ebp
  8009c5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d2:	74 30                	je     800a04 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009d4:	eb 16                	jmp    8009ec <strlcpy+0x2a>
			*dst++ = *src++;
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	8d 50 01             	lea    0x1(%eax),%edx
  8009dc:	89 55 08             	mov    %edx,0x8(%ebp)
  8009df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009e8:	8a 12                	mov    (%edx),%dl
  8009ea:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ec:	ff 4d 10             	decl   0x10(%ebp)
  8009ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f3:	74 09                	je     8009fe <strlcpy+0x3c>
  8009f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f8:	8a 00                	mov    (%eax),%al
  8009fa:	84 c0                	test   %al,%al
  8009fc:	75 d8                	jne    8009d6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800a01:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a04:	8b 55 08             	mov    0x8(%ebp),%edx
  800a07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a0a:	29 c2                	sub    %eax,%edx
  800a0c:	89 d0                	mov    %edx,%eax
}
  800a0e:	c9                   	leave  
  800a0f:	c3                   	ret    

00800a10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a10:	55                   	push   %ebp
  800a11:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a13:	eb 06                	jmp    800a1b <strcmp+0xb>
		p++, q++;
  800a15:	ff 45 08             	incl   0x8(%ebp)
  800a18:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	84 c0                	test   %al,%al
  800a22:	74 0e                	je     800a32 <strcmp+0x22>
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	8a 10                	mov    (%eax),%dl
  800a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2c:	8a 00                	mov    (%eax),%al
  800a2e:	38 c2                	cmp    %al,%dl
  800a30:	74 e3                	je     800a15 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a32:	8b 45 08             	mov    0x8(%ebp),%eax
  800a35:	8a 00                	mov    (%eax),%al
  800a37:	0f b6 d0             	movzbl %al,%edx
  800a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3d:	8a 00                	mov    (%eax),%al
  800a3f:	0f b6 c0             	movzbl %al,%eax
  800a42:	29 c2                	sub    %eax,%edx
  800a44:	89 d0                	mov    %edx,%eax
}
  800a46:	5d                   	pop    %ebp
  800a47:	c3                   	ret    

00800a48 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a48:	55                   	push   %ebp
  800a49:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a4b:	eb 09                	jmp    800a56 <strncmp+0xe>
		n--, p++, q++;
  800a4d:	ff 4d 10             	decl   0x10(%ebp)
  800a50:	ff 45 08             	incl   0x8(%ebp)
  800a53:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a5a:	74 17                	je     800a73 <strncmp+0x2b>
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	8a 00                	mov    (%eax),%al
  800a61:	84 c0                	test   %al,%al
  800a63:	74 0e                	je     800a73 <strncmp+0x2b>
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	8a 10                	mov    (%eax),%dl
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	8a 00                	mov    (%eax),%al
  800a6f:	38 c2                	cmp    %al,%dl
  800a71:	74 da                	je     800a4d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a73:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a77:	75 07                	jne    800a80 <strncmp+0x38>
		return 0;
  800a79:	b8 00 00 00 00       	mov    $0x0,%eax
  800a7e:	eb 14                	jmp    800a94 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	8a 00                	mov    (%eax),%al
  800a85:	0f b6 d0             	movzbl %al,%edx
  800a88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8b:	8a 00                	mov    (%eax),%al
  800a8d:	0f b6 c0             	movzbl %al,%eax
  800a90:	29 c2                	sub    %eax,%edx
  800a92:	89 d0                	mov    %edx,%eax
}
  800a94:	5d                   	pop    %ebp
  800a95:	c3                   	ret    

00800a96 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a96:	55                   	push   %ebp
  800a97:	89 e5                	mov    %esp,%ebp
  800a99:	83 ec 04             	sub    $0x4,%esp
  800a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa2:	eb 12                	jmp    800ab6 <strchr+0x20>
		if (*s == c)
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aac:	75 05                	jne    800ab3 <strchr+0x1d>
			return (char *) s;
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	eb 11                	jmp    800ac4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ab3:	ff 45 08             	incl   0x8(%ebp)
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	84 c0                	test   %al,%al
  800abd:	75 e5                	jne    800aa4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800abf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ac4:	c9                   	leave  
  800ac5:	c3                   	ret    

00800ac6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ac6:	55                   	push   %ebp
  800ac7:	89 e5                	mov    %esp,%ebp
  800ac9:	83 ec 04             	sub    $0x4,%esp
  800acc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad2:	eb 0d                	jmp    800ae1 <strfind+0x1b>
		if (*s == c)
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	8a 00                	mov    (%eax),%al
  800ad9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800adc:	74 0e                	je     800aec <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ade:	ff 45 08             	incl   0x8(%ebp)
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	84 c0                	test   %al,%al
  800ae8:	75 ea                	jne    800ad4 <strfind+0xe>
  800aea:	eb 01                	jmp    800aed <strfind+0x27>
		if (*s == c)
			break;
  800aec:	90                   	nop
	return (char *) s;
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800af0:	c9                   	leave  
  800af1:	c3                   	ret    

00800af2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
  800af5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800afe:	8b 45 10             	mov    0x10(%ebp),%eax
  800b01:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b04:	eb 0e                	jmp    800b14 <memset+0x22>
		*p++ = c;
  800b06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b09:	8d 50 01             	lea    0x1(%eax),%edx
  800b0c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b12:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b14:	ff 4d f8             	decl   -0x8(%ebp)
  800b17:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b1b:	79 e9                	jns    800b06 <memset+0x14>
		*p++ = c;

	return v;
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b20:	c9                   	leave  
  800b21:	c3                   	ret    

00800b22 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b34:	eb 16                	jmp    800b4c <memcpy+0x2a>
		*d++ = *s++;
  800b36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b39:	8d 50 01             	lea    0x1(%eax),%edx
  800b3c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b42:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b45:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b48:	8a 12                	mov    (%edx),%dl
  800b4a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b52:	89 55 10             	mov    %edx,0x10(%ebp)
  800b55:	85 c0                	test   %eax,%eax
  800b57:	75 dd                	jne    800b36 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5c:	c9                   	leave  
  800b5d:	c3                   	ret    

00800b5e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b73:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b76:	73 50                	jae    800bc8 <memmove+0x6a>
  800b78:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7e:	01 d0                	add    %edx,%eax
  800b80:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b83:	76 43                	jbe    800bc8 <memmove+0x6a>
		s += n;
  800b85:	8b 45 10             	mov    0x10(%ebp),%eax
  800b88:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b91:	eb 10                	jmp    800ba3 <memmove+0x45>
			*--d = *--s;
  800b93:	ff 4d f8             	decl   -0x8(%ebp)
  800b96:	ff 4d fc             	decl   -0x4(%ebp)
  800b99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9c:	8a 10                	mov    (%eax),%dl
  800b9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ba3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bac:	85 c0                	test   %eax,%eax
  800bae:	75 e3                	jne    800b93 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bb0:	eb 23                	jmp    800bd5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb5:	8d 50 01             	lea    0x1(%eax),%edx
  800bb8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bbb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bbe:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc4:	8a 12                	mov    (%edx),%dl
  800bc6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bce:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd1:	85 c0                	test   %eax,%eax
  800bd3:	75 dd                	jne    800bb2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd8:	c9                   	leave  
  800bd9:	c3                   	ret    

00800bda <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bda:	55                   	push   %ebp
  800bdb:	89 e5                	mov    %esp,%ebp
  800bdd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800be6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bec:	eb 2a                	jmp    800c18 <memcmp+0x3e>
		if (*s1 != *s2)
  800bee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf1:	8a 10                	mov    (%eax),%dl
  800bf3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	38 c2                	cmp    %al,%dl
  800bfa:	74 16                	je     800c12 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	0f b6 d0             	movzbl %al,%edx
  800c04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	0f b6 c0             	movzbl %al,%eax
  800c0c:	29 c2                	sub    %eax,%edx
  800c0e:	89 d0                	mov    %edx,%eax
  800c10:	eb 18                	jmp    800c2a <memcmp+0x50>
		s1++, s2++;
  800c12:	ff 45 fc             	incl   -0x4(%ebp)
  800c15:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c18:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c21:	85 c0                	test   %eax,%eax
  800c23:	75 c9                	jne    800bee <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c32:	8b 55 08             	mov    0x8(%ebp),%edx
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	01 d0                	add    %edx,%eax
  800c3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c3d:	eb 15                	jmp    800c54 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	0f b6 d0             	movzbl %al,%edx
  800c47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4a:	0f b6 c0             	movzbl %al,%eax
  800c4d:	39 c2                	cmp    %eax,%edx
  800c4f:	74 0d                	je     800c5e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c51:	ff 45 08             	incl   0x8(%ebp)
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c5a:	72 e3                	jb     800c3f <memfind+0x13>
  800c5c:	eb 01                	jmp    800c5f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c5e:	90                   	nop
	return (void *) s;
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c62:	c9                   	leave  
  800c63:	c3                   	ret    

00800c64 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c64:	55                   	push   %ebp
  800c65:	89 e5                	mov    %esp,%ebp
  800c67:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c71:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c78:	eb 03                	jmp    800c7d <strtol+0x19>
		s++;
  800c7a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8a 00                	mov    (%eax),%al
  800c82:	3c 20                	cmp    $0x20,%al
  800c84:	74 f4                	je     800c7a <strtol+0x16>
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	8a 00                	mov    (%eax),%al
  800c8b:	3c 09                	cmp    $0x9,%al
  800c8d:	74 eb                	je     800c7a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	3c 2b                	cmp    $0x2b,%al
  800c96:	75 05                	jne    800c9d <strtol+0x39>
		s++;
  800c98:	ff 45 08             	incl   0x8(%ebp)
  800c9b:	eb 13                	jmp    800cb0 <strtol+0x4c>
	else if (*s == '-')
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	3c 2d                	cmp    $0x2d,%al
  800ca4:	75 0a                	jne    800cb0 <strtol+0x4c>
		s++, neg = 1;
  800ca6:	ff 45 08             	incl   0x8(%ebp)
  800ca9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cb0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb4:	74 06                	je     800cbc <strtol+0x58>
  800cb6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cba:	75 20                	jne    800cdc <strtol+0x78>
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	3c 30                	cmp    $0x30,%al
  800cc3:	75 17                	jne    800cdc <strtol+0x78>
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	40                   	inc    %eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	3c 78                	cmp    $0x78,%al
  800ccd:	75 0d                	jne    800cdc <strtol+0x78>
		s += 2, base = 16;
  800ccf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cd3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cda:	eb 28                	jmp    800d04 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce0:	75 15                	jne    800cf7 <strtol+0x93>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	3c 30                	cmp    $0x30,%al
  800ce9:	75 0c                	jne    800cf7 <strtol+0x93>
		s++, base = 8;
  800ceb:	ff 45 08             	incl   0x8(%ebp)
  800cee:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cf5:	eb 0d                	jmp    800d04 <strtol+0xa0>
	else if (base == 0)
  800cf7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfb:	75 07                	jne    800d04 <strtol+0xa0>
		base = 10;
  800cfd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	3c 2f                	cmp    $0x2f,%al
  800d0b:	7e 19                	jle    800d26 <strtol+0xc2>
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	3c 39                	cmp    $0x39,%al
  800d14:	7f 10                	jg     800d26 <strtol+0xc2>
			dig = *s - '0';
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	0f be c0             	movsbl %al,%eax
  800d1e:	83 e8 30             	sub    $0x30,%eax
  800d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d24:	eb 42                	jmp    800d68 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 60                	cmp    $0x60,%al
  800d2d:	7e 19                	jle    800d48 <strtol+0xe4>
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	3c 7a                	cmp    $0x7a,%al
  800d36:	7f 10                	jg     800d48 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	0f be c0             	movsbl %al,%eax
  800d40:	83 e8 57             	sub    $0x57,%eax
  800d43:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d46:	eb 20                	jmp    800d68 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	3c 40                	cmp    $0x40,%al
  800d4f:	7e 39                	jle    800d8a <strtol+0x126>
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	3c 5a                	cmp    $0x5a,%al
  800d58:	7f 30                	jg     800d8a <strtol+0x126>
			dig = *s - 'A' + 10;
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	8a 00                	mov    (%eax),%al
  800d5f:	0f be c0             	movsbl %al,%eax
  800d62:	83 e8 37             	sub    $0x37,%eax
  800d65:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d6b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d6e:	7d 19                	jge    800d89 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d70:	ff 45 08             	incl   0x8(%ebp)
  800d73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d76:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d7a:	89 c2                	mov    %eax,%edx
  800d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d7f:	01 d0                	add    %edx,%eax
  800d81:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d84:	e9 7b ff ff ff       	jmp    800d04 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d89:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d8e:	74 08                	je     800d98 <strtol+0x134>
		*endptr = (char *) s;
  800d90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d93:	8b 55 08             	mov    0x8(%ebp),%edx
  800d96:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d98:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d9c:	74 07                	je     800da5 <strtol+0x141>
  800d9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da1:	f7 d8                	neg    %eax
  800da3:	eb 03                	jmp    800da8 <strtol+0x144>
  800da5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800da8:	c9                   	leave  
  800da9:	c3                   	ret    

00800daa <ltostr>:

void
ltostr(long value, char *str)
{
  800daa:	55                   	push   %ebp
  800dab:	89 e5                	mov    %esp,%ebp
  800dad:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800db0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800db7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dbe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dc2:	79 13                	jns    800dd7 <ltostr+0x2d>
	{
		neg = 1;
  800dc4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dce:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dd1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dd4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ddf:	99                   	cltd   
  800de0:	f7 f9                	idiv   %ecx
  800de2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800de5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de8:	8d 50 01             	lea    0x1(%eax),%edx
  800deb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dee:	89 c2                	mov    %eax,%edx
  800df0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df3:	01 d0                	add    %edx,%eax
  800df5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800df8:	83 c2 30             	add    $0x30,%edx
  800dfb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dfd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e00:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e05:	f7 e9                	imul   %ecx
  800e07:	c1 fa 02             	sar    $0x2,%edx
  800e0a:	89 c8                	mov    %ecx,%eax
  800e0c:	c1 f8 1f             	sar    $0x1f,%eax
  800e0f:	29 c2                	sub    %eax,%edx
  800e11:	89 d0                	mov    %edx,%eax
  800e13:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e16:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e19:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e1e:	f7 e9                	imul   %ecx
  800e20:	c1 fa 02             	sar    $0x2,%edx
  800e23:	89 c8                	mov    %ecx,%eax
  800e25:	c1 f8 1f             	sar    $0x1f,%eax
  800e28:	29 c2                	sub    %eax,%edx
  800e2a:	89 d0                	mov    %edx,%eax
  800e2c:	c1 e0 02             	shl    $0x2,%eax
  800e2f:	01 d0                	add    %edx,%eax
  800e31:	01 c0                	add    %eax,%eax
  800e33:	29 c1                	sub    %eax,%ecx
  800e35:	89 ca                	mov    %ecx,%edx
  800e37:	85 d2                	test   %edx,%edx
  800e39:	75 9c                	jne    800dd7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e45:	48                   	dec    %eax
  800e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e49:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4d:	74 3d                	je     800e8c <ltostr+0xe2>
		start = 1 ;
  800e4f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e56:	eb 34                	jmp    800e8c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e58:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5e:	01 d0                	add    %edx,%eax
  800e60:	8a 00                	mov    (%eax),%al
  800e62:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6b:	01 c2                	add    %eax,%edx
  800e6d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e73:	01 c8                	add    %ecx,%eax
  800e75:	8a 00                	mov    (%eax),%al
  800e77:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e79:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7f:	01 c2                	add    %eax,%edx
  800e81:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e84:	88 02                	mov    %al,(%edx)
		start++ ;
  800e86:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e89:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e8f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e92:	7c c4                	jl     800e58 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e94:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9a:	01 d0                	add    %edx,%eax
  800e9c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e9f:	90                   	nop
  800ea0:	c9                   	leave  
  800ea1:	c3                   	ret    

00800ea2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ea2:	55                   	push   %ebp
  800ea3:	89 e5                	mov    %esp,%ebp
  800ea5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ea8:	ff 75 08             	pushl  0x8(%ebp)
  800eab:	e8 54 fa ff ff       	call   800904 <strlen>
  800eb0:	83 c4 04             	add    $0x4,%esp
  800eb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eb6:	ff 75 0c             	pushl  0xc(%ebp)
  800eb9:	e8 46 fa ff ff       	call   800904 <strlen>
  800ebe:	83 c4 04             	add    $0x4,%esp
  800ec1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ec4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ecb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed2:	eb 17                	jmp    800eeb <strcconcat+0x49>
		final[s] = str1[s] ;
  800ed4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eda:	01 c2                	add    %eax,%edx
  800edc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	01 c8                	add    %ecx,%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ee8:	ff 45 fc             	incl   -0x4(%ebp)
  800eeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ef1:	7c e1                	jl     800ed4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ef3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800efa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f01:	eb 1f                	jmp    800f22 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f06:	8d 50 01             	lea    0x1(%eax),%edx
  800f09:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f0c:	89 c2                	mov    %eax,%edx
  800f0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f11:	01 c2                	add    %eax,%edx
  800f13:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	01 c8                	add    %ecx,%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f1f:	ff 45 f8             	incl   -0x8(%ebp)
  800f22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f25:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f28:	7c d9                	jl     800f03 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f30:	01 d0                	add    %edx,%eax
  800f32:	c6 00 00             	movb   $0x0,(%eax)
}
  800f35:	90                   	nop
  800f36:	c9                   	leave  
  800f37:	c3                   	ret    

00800f38 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f38:	55                   	push   %ebp
  800f39:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f44:	8b 45 14             	mov    0x14(%ebp),%eax
  800f47:	8b 00                	mov    (%eax),%eax
  800f49:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f50:	8b 45 10             	mov    0x10(%ebp),%eax
  800f53:	01 d0                	add    %edx,%eax
  800f55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f5b:	eb 0c                	jmp    800f69 <strsplit+0x31>
			*string++ = 0;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	8d 50 01             	lea    0x1(%eax),%edx
  800f63:	89 55 08             	mov    %edx,0x8(%ebp)
  800f66:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 00                	mov    (%eax),%al
  800f6e:	84 c0                	test   %al,%al
  800f70:	74 18                	je     800f8a <strsplit+0x52>
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	0f be c0             	movsbl %al,%eax
  800f7a:	50                   	push   %eax
  800f7b:	ff 75 0c             	pushl  0xc(%ebp)
  800f7e:	e8 13 fb ff ff       	call   800a96 <strchr>
  800f83:	83 c4 08             	add    $0x8,%esp
  800f86:	85 c0                	test   %eax,%eax
  800f88:	75 d3                	jne    800f5d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	84 c0                	test   %al,%al
  800f91:	74 5a                	je     800fed <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f93:	8b 45 14             	mov    0x14(%ebp),%eax
  800f96:	8b 00                	mov    (%eax),%eax
  800f98:	83 f8 0f             	cmp    $0xf,%eax
  800f9b:	75 07                	jne    800fa4 <strsplit+0x6c>
		{
			return 0;
  800f9d:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa2:	eb 66                	jmp    80100a <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fa4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa7:	8b 00                	mov    (%eax),%eax
  800fa9:	8d 48 01             	lea    0x1(%eax),%ecx
  800fac:	8b 55 14             	mov    0x14(%ebp),%edx
  800faf:	89 0a                	mov    %ecx,(%edx)
  800fb1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbb:	01 c2                	add    %eax,%edx
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc2:	eb 03                	jmp    800fc7 <strsplit+0x8f>
			string++;
  800fc4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	84 c0                	test   %al,%al
  800fce:	74 8b                	je     800f5b <strsplit+0x23>
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	0f be c0             	movsbl %al,%eax
  800fd8:	50                   	push   %eax
  800fd9:	ff 75 0c             	pushl  0xc(%ebp)
  800fdc:	e8 b5 fa ff ff       	call   800a96 <strchr>
  800fe1:	83 c4 08             	add    $0x8,%esp
  800fe4:	85 c0                	test   %eax,%eax
  800fe6:	74 dc                	je     800fc4 <strsplit+0x8c>
			string++;
	}
  800fe8:	e9 6e ff ff ff       	jmp    800f5b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fed:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fee:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff1:	8b 00                	mov    (%eax),%eax
  800ff3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ffa:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801005:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80100a:	c9                   	leave  
  80100b:	c3                   	ret    

0080100c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80100c:	55                   	push   %ebp
  80100d:	89 e5                	mov    %esp,%ebp
  80100f:	57                   	push   %edi
  801010:	56                   	push   %esi
  801011:	53                   	push   %ebx
  801012:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8b 55 0c             	mov    0xc(%ebp),%edx
  80101b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80101e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801021:	8b 7d 18             	mov    0x18(%ebp),%edi
  801024:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801027:	cd 30                	int    $0x30
  801029:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80102c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80102f:	83 c4 10             	add    $0x10,%esp
  801032:	5b                   	pop    %ebx
  801033:	5e                   	pop    %esi
  801034:	5f                   	pop    %edi
  801035:	5d                   	pop    %ebp
  801036:	c3                   	ret    

00801037 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
  80103a:	83 ec 04             	sub    $0x4,%esp
  80103d:	8b 45 10             	mov    0x10(%ebp),%eax
  801040:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801043:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	6a 00                	push   $0x0
  80104c:	6a 00                	push   $0x0
  80104e:	52                   	push   %edx
  80104f:	ff 75 0c             	pushl  0xc(%ebp)
  801052:	50                   	push   %eax
  801053:	6a 00                	push   $0x0
  801055:	e8 b2 ff ff ff       	call   80100c <syscall>
  80105a:	83 c4 18             	add    $0x18,%esp
}
  80105d:	90                   	nop
  80105e:	c9                   	leave  
  80105f:	c3                   	ret    

00801060 <sys_cgetc>:

int
sys_cgetc(void)
{
  801060:	55                   	push   %ebp
  801061:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801063:	6a 00                	push   $0x0
  801065:	6a 00                	push   $0x0
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	6a 00                	push   $0x0
  80106d:	6a 01                	push   $0x1
  80106f:	e8 98 ff ff ff       	call   80100c <syscall>
  801074:	83 c4 18             	add    $0x18,%esp
}
  801077:	c9                   	leave  
  801078:	c3                   	ret    

00801079 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801079:	55                   	push   %ebp
  80107a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	6a 00                	push   $0x0
  801081:	6a 00                	push   $0x0
  801083:	6a 00                	push   $0x0
  801085:	6a 00                	push   $0x0
  801087:	50                   	push   %eax
  801088:	6a 05                	push   $0x5
  80108a:	e8 7d ff ff ff       	call   80100c <syscall>
  80108f:	83 c4 18             	add    $0x18,%esp
}
  801092:	c9                   	leave  
  801093:	c3                   	ret    

00801094 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801094:	55                   	push   %ebp
  801095:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 00                	push   $0x0
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 02                	push   $0x2
  8010a3:	e8 64 ff ff ff       	call   80100c <syscall>
  8010a8:	83 c4 18             	add    $0x18,%esp
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 03                	push   $0x3
  8010bc:	e8 4b ff ff ff       	call   80100c <syscall>
  8010c1:	83 c4 18             	add    $0x18,%esp
}
  8010c4:	c9                   	leave  
  8010c5:	c3                   	ret    

008010c6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010c6:	55                   	push   %ebp
  8010c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 00                	push   $0x0
  8010d3:	6a 04                	push   $0x4
  8010d5:	e8 32 ff ff ff       	call   80100c <syscall>
  8010da:	83 c4 18             	add    $0x18,%esp
}
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <sys_env_exit>:


void sys_env_exit(void)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 06                	push   $0x6
  8010ee:	e8 19 ff ff ff       	call   80100c <syscall>
  8010f3:	83 c4 18             	add    $0x18,%esp
}
  8010f6:	90                   	nop
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	6a 00                	push   $0x0
  801104:	6a 00                	push   $0x0
  801106:	6a 00                	push   $0x0
  801108:	52                   	push   %edx
  801109:	50                   	push   %eax
  80110a:	6a 07                	push   $0x7
  80110c:	e8 fb fe ff ff       	call   80100c <syscall>
  801111:	83 c4 18             	add    $0x18,%esp
}
  801114:	c9                   	leave  
  801115:	c3                   	ret    

00801116 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801116:	55                   	push   %ebp
  801117:	89 e5                	mov    %esp,%ebp
  801119:	56                   	push   %esi
  80111a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80111b:	8b 75 18             	mov    0x18(%ebp),%esi
  80111e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801121:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801124:	8b 55 0c             	mov    0xc(%ebp),%edx
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	56                   	push   %esi
  80112b:	53                   	push   %ebx
  80112c:	51                   	push   %ecx
  80112d:	52                   	push   %edx
  80112e:	50                   	push   %eax
  80112f:	6a 08                	push   $0x8
  801131:	e8 d6 fe ff ff       	call   80100c <syscall>
  801136:	83 c4 18             	add    $0x18,%esp
}
  801139:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80113c:	5b                   	pop    %ebx
  80113d:	5e                   	pop    %esi
  80113e:	5d                   	pop    %ebp
  80113f:	c3                   	ret    

00801140 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801140:	55                   	push   %ebp
  801141:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801143:	8b 55 0c             	mov    0xc(%ebp),%edx
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	6a 00                	push   $0x0
  80114f:	52                   	push   %edx
  801150:	50                   	push   %eax
  801151:	6a 09                	push   $0x9
  801153:	e8 b4 fe ff ff       	call   80100c <syscall>
  801158:	83 c4 18             	add    $0x18,%esp
}
  80115b:	c9                   	leave  
  80115c:	c3                   	ret    

0080115d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801160:	6a 00                	push   $0x0
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	ff 75 0c             	pushl  0xc(%ebp)
  801169:	ff 75 08             	pushl  0x8(%ebp)
  80116c:	6a 0a                	push   $0xa
  80116e:	e8 99 fe ff ff       	call   80100c <syscall>
  801173:	83 c4 18             	add    $0x18,%esp
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 0b                	push   $0xb
  801187:	e8 80 fe ff ff       	call   80100c <syscall>
  80118c:	83 c4 18             	add    $0x18,%esp
}
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 0c                	push   $0xc
  8011a0:	e8 67 fe ff ff       	call   80100c <syscall>
  8011a5:	83 c4 18             	add    $0x18,%esp
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 0d                	push   $0xd
  8011b9:	e8 4e fe ff ff       	call   80100c <syscall>
  8011be:	83 c4 18             	add    $0x18,%esp
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	ff 75 0c             	pushl  0xc(%ebp)
  8011cf:	ff 75 08             	pushl  0x8(%ebp)
  8011d2:	6a 11                	push   $0x11
  8011d4:	e8 33 fe ff ff       	call   80100c <syscall>
  8011d9:	83 c4 18             	add    $0x18,%esp
	return;
  8011dc:	90                   	nop
}
  8011dd:	c9                   	leave  
  8011de:	c3                   	ret    

008011df <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011df:	55                   	push   %ebp
  8011e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	6a 00                	push   $0x0
  8011e8:	ff 75 0c             	pushl  0xc(%ebp)
  8011eb:	ff 75 08             	pushl  0x8(%ebp)
  8011ee:	6a 12                	push   $0x12
  8011f0:	e8 17 fe ff ff       	call   80100c <syscall>
  8011f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8011f8:	90                   	nop
}
  8011f9:	c9                   	leave  
  8011fa:	c3                   	ret    

008011fb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011fb:	55                   	push   %ebp
  8011fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 0e                	push   $0xe
  80120a:	e8 fd fd ff ff       	call   80100c <syscall>
  80120f:	83 c4 18             	add    $0x18,%esp
}
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	ff 75 08             	pushl  0x8(%ebp)
  801222:	6a 0f                	push   $0xf
  801224:	e8 e3 fd ff ff       	call   80100c <syscall>
  801229:	83 c4 18             	add    $0x18,%esp
}
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 10                	push   $0x10
  80123d:	e8 ca fd ff ff       	call   80100c <syscall>
  801242:	83 c4 18             	add    $0x18,%esp
}
  801245:	90                   	nop
  801246:	c9                   	leave  
  801247:	c3                   	ret    

00801248 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801248:	55                   	push   %ebp
  801249:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 14                	push   $0x14
  801257:	e8 b0 fd ff ff       	call   80100c <syscall>
  80125c:	83 c4 18             	add    $0x18,%esp
}
  80125f:	90                   	nop
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 15                	push   $0x15
  801271:	e8 96 fd ff ff       	call   80100c <syscall>
  801276:	83 c4 18             	add    $0x18,%esp
}
  801279:	90                   	nop
  80127a:	c9                   	leave  
  80127b:	c3                   	ret    

0080127c <sys_cputc>:


void
sys_cputc(const char c)
{
  80127c:	55                   	push   %ebp
  80127d:	89 e5                	mov    %esp,%ebp
  80127f:	83 ec 04             	sub    $0x4,%esp
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801288:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	50                   	push   %eax
  801295:	6a 16                	push   $0x16
  801297:	e8 70 fd ff ff       	call   80100c <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 17                	push   $0x17
  8012b1:	e8 56 fd ff ff       	call   80100c <syscall>
  8012b6:	83 c4 18             	add    $0x18,%esp
}
  8012b9:	90                   	nop
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	ff 75 0c             	pushl  0xc(%ebp)
  8012cb:	50                   	push   %eax
  8012cc:	6a 18                	push   $0x18
  8012ce:	e8 39 fd ff ff       	call   80100c <syscall>
  8012d3:	83 c4 18             	add    $0x18,%esp
}
  8012d6:	c9                   	leave  
  8012d7:	c3                   	ret    

008012d8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012d8:	55                   	push   %ebp
  8012d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012de:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	52                   	push   %edx
  8012e8:	50                   	push   %eax
  8012e9:	6a 1b                	push   $0x1b
  8012eb:	e8 1c fd ff ff       	call   80100c <syscall>
  8012f0:	83 c4 18             	add    $0x18,%esp
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	52                   	push   %edx
  801305:	50                   	push   %eax
  801306:	6a 19                	push   $0x19
  801308:	e8 ff fc ff ff       	call   80100c <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	90                   	nop
  801311:	c9                   	leave  
  801312:	c3                   	ret    

00801313 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801316:	8b 55 0c             	mov    0xc(%ebp),%edx
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	52                   	push   %edx
  801323:	50                   	push   %eax
  801324:	6a 1a                	push   $0x1a
  801326:	e8 e1 fc ff ff       	call   80100c <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	90                   	nop
  80132f:	c9                   	leave  
  801330:	c3                   	ret    

00801331 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801331:	55                   	push   %ebp
  801332:	89 e5                	mov    %esp,%ebp
  801334:	83 ec 04             	sub    $0x4,%esp
  801337:	8b 45 10             	mov    0x10(%ebp),%eax
  80133a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80133d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801340:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	6a 00                	push   $0x0
  801349:	51                   	push   %ecx
  80134a:	52                   	push   %edx
  80134b:	ff 75 0c             	pushl  0xc(%ebp)
  80134e:	50                   	push   %eax
  80134f:	6a 1c                	push   $0x1c
  801351:	e8 b6 fc ff ff       	call   80100c <syscall>
  801356:	83 c4 18             	add    $0x18,%esp
}
  801359:	c9                   	leave  
  80135a:	c3                   	ret    

0080135b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80135e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	52                   	push   %edx
  80136b:	50                   	push   %eax
  80136c:	6a 1d                	push   $0x1d
  80136e:	e8 99 fc ff ff       	call   80100c <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80137b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80137e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	51                   	push   %ecx
  801389:	52                   	push   %edx
  80138a:	50                   	push   %eax
  80138b:	6a 1e                	push   $0x1e
  80138d:	e8 7a fc ff ff       	call   80100c <syscall>
  801392:	83 c4 18             	add    $0x18,%esp
}
  801395:	c9                   	leave  
  801396:	c3                   	ret    

00801397 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801397:	55                   	push   %ebp
  801398:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80139a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	52                   	push   %edx
  8013a7:	50                   	push   %eax
  8013a8:	6a 1f                	push   $0x1f
  8013aa:	e8 5d fc ff ff       	call   80100c <syscall>
  8013af:	83 c4 18             	add    $0x18,%esp
}
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 20                	push   $0x20
  8013c3:	e8 44 fc ff ff       	call   80100c <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	ff 75 10             	pushl  0x10(%ebp)
  8013da:	ff 75 0c             	pushl  0xc(%ebp)
  8013dd:	50                   	push   %eax
  8013de:	6a 21                	push   $0x21
  8013e0:	e8 27 fc ff ff       	call   80100c <syscall>
  8013e5:	83 c4 18             	add    $0x18,%esp
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	50                   	push   %eax
  8013f9:	6a 22                	push   $0x22
  8013fb:	e8 0c fc ff ff       	call   80100c <syscall>
  801400:	83 c4 18             	add    $0x18,%esp
}
  801403:	90                   	nop
  801404:	c9                   	leave  
  801405:	c3                   	ret    

00801406 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801406:	55                   	push   %ebp
  801407:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	50                   	push   %eax
  801415:	6a 23                	push   $0x23
  801417:	e8 f0 fb ff ff       	call   80100c <syscall>
  80141c:	83 c4 18             	add    $0x18,%esp
}
  80141f:	90                   	nop
  801420:	c9                   	leave  
  801421:	c3                   	ret    

00801422 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801422:	55                   	push   %ebp
  801423:	89 e5                	mov    %esp,%ebp
  801425:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801428:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80142b:	8d 50 04             	lea    0x4(%eax),%edx
  80142e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	52                   	push   %edx
  801438:	50                   	push   %eax
  801439:	6a 24                	push   $0x24
  80143b:	e8 cc fb ff ff       	call   80100c <syscall>
  801440:	83 c4 18             	add    $0x18,%esp
	return result;
  801443:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801446:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801449:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80144c:	89 01                	mov    %eax,(%ecx)
  80144e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	c9                   	leave  
  801455:	c2 04 00             	ret    $0x4

00801458 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801458:	55                   	push   %ebp
  801459:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	ff 75 10             	pushl  0x10(%ebp)
  801462:	ff 75 0c             	pushl  0xc(%ebp)
  801465:	ff 75 08             	pushl  0x8(%ebp)
  801468:	6a 13                	push   $0x13
  80146a:	e8 9d fb ff ff       	call   80100c <syscall>
  80146f:	83 c4 18             	add    $0x18,%esp
	return ;
  801472:	90                   	nop
}
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <sys_rcr2>:
uint32 sys_rcr2()
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 25                	push   $0x25
  801484:	e8 83 fb ff ff       	call   80100c <syscall>
  801489:	83 c4 18             	add    $0x18,%esp
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 04             	sub    $0x4,%esp
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80149a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	50                   	push   %eax
  8014a7:	6a 26                	push   $0x26
  8014a9:	e8 5e fb ff ff       	call   80100c <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b1:	90                   	nop
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <rsttst>:
void rsttst()
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 28                	push   $0x28
  8014c3:	e8 44 fb ff ff       	call   80100c <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014cb:	90                   	nop
}
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
  8014d1:	83 ec 04             	sub    $0x4,%esp
  8014d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014da:	8b 55 18             	mov    0x18(%ebp),%edx
  8014dd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e1:	52                   	push   %edx
  8014e2:	50                   	push   %eax
  8014e3:	ff 75 10             	pushl  0x10(%ebp)
  8014e6:	ff 75 0c             	pushl  0xc(%ebp)
  8014e9:	ff 75 08             	pushl  0x8(%ebp)
  8014ec:	6a 27                	push   $0x27
  8014ee:	e8 19 fb ff ff       	call   80100c <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f6:	90                   	nop
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <chktst>:
void chktst(uint32 n)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	ff 75 08             	pushl  0x8(%ebp)
  801507:	6a 29                	push   $0x29
  801509:	e8 fe fa ff ff       	call   80100c <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
	return ;
  801511:	90                   	nop
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <inctst>:

void inctst()
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 2a                	push   $0x2a
  801523:	e8 e4 fa ff ff       	call   80100c <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
	return ;
  80152b:	90                   	nop
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <gettst>:
uint32 gettst()
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 2b                	push   $0x2b
  80153d:	e8 ca fa ff ff       	call   80100c <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
  80154a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 2c                	push   $0x2c
  801559:	e8 ae fa ff ff       	call   80100c <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
  801561:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801564:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801568:	75 07                	jne    801571 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80156a:	b8 01 00 00 00       	mov    $0x1,%eax
  80156f:	eb 05                	jmp    801576 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801571:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
  80157b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 2c                	push   $0x2c
  80158a:	e8 7d fa ff ff       	call   80100c <syscall>
  80158f:	83 c4 18             	add    $0x18,%esp
  801592:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801595:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801599:	75 07                	jne    8015a2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80159b:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a0:	eb 05                	jmp    8015a7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 2c                	push   $0x2c
  8015bb:	e8 4c fa ff ff       	call   80100c <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
  8015c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015c6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015ca:	75 07                	jne    8015d3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015cc:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d1:	eb 05                	jmp    8015d8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 2c                	push   $0x2c
  8015ec:	e8 1b fa ff ff       	call   80100c <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
  8015f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015f7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015fb:	75 07                	jne    801604 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015fd:	b8 01 00 00 00       	mov    $0x1,%eax
  801602:	eb 05                	jmp    801609 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801604:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	ff 75 08             	pushl  0x8(%ebp)
  801619:	6a 2d                	push   $0x2d
  80161b:	e8 ec f9 ff ff       	call   80100c <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
	return ;
  801623:	90                   	nop
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
  801629:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80162c:	8b 55 08             	mov    0x8(%ebp),%edx
  80162f:	89 d0                	mov    %edx,%eax
  801631:	c1 e0 02             	shl    $0x2,%eax
  801634:	01 d0                	add    %edx,%eax
  801636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80163d:	01 d0                	add    %edx,%eax
  80163f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801646:	01 d0                	add    %edx,%eax
  801648:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80164f:	01 d0                	add    %edx,%eax
  801651:	c1 e0 04             	shl    $0x4,%eax
  801654:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801657:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80165e:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801661:	83 ec 0c             	sub    $0xc,%esp
  801664:	50                   	push   %eax
  801665:	e8 b8 fd ff ff       	call   801422 <sys_get_virtual_time>
  80166a:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80166d:	eb 41                	jmp    8016b0 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80166f:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801672:	83 ec 0c             	sub    $0xc,%esp
  801675:	50                   	push   %eax
  801676:	e8 a7 fd ff ff       	call   801422 <sys_get_virtual_time>
  80167b:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80167e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801681:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801684:	29 c2                	sub    %eax,%edx
  801686:	89 d0                	mov    %edx,%eax
  801688:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80168b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80168e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801691:	89 d1                	mov    %edx,%ecx
  801693:	29 c1                	sub    %eax,%ecx
  801695:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801698:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80169b:	39 c2                	cmp    %eax,%edx
  80169d:	0f 97 c0             	seta   %al
  8016a0:	0f b6 c0             	movzbl %al,%eax
  8016a3:	29 c1                	sub    %eax,%ecx
  8016a5:	89 c8                	mov    %ecx,%eax
  8016a7:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016b6:	72 b7                	jb     80166f <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  8016b8:	90                   	nop
  8016b9:	c9                   	leave  
  8016ba:	c3                   	ret    

008016bb <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8016bb:	55                   	push   %ebp
  8016bc:	89 e5                	mov    %esp,%ebp
  8016be:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8016c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8016c8:	eb 03                	jmp    8016cd <busy_wait+0x12>
  8016ca:	ff 45 fc             	incl   -0x4(%ebp)
  8016cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d0:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016d3:	72 f5                	jb     8016ca <busy_wait+0xf>
	return i;
  8016d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    
  8016da:	66 90                	xchg   %ax,%ax

008016dc <__udivdi3>:
  8016dc:	55                   	push   %ebp
  8016dd:	57                   	push   %edi
  8016de:	56                   	push   %esi
  8016df:	53                   	push   %ebx
  8016e0:	83 ec 1c             	sub    $0x1c,%esp
  8016e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016f3:	89 ca                	mov    %ecx,%edx
  8016f5:	89 f8                	mov    %edi,%eax
  8016f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016fb:	85 f6                	test   %esi,%esi
  8016fd:	75 2d                	jne    80172c <__udivdi3+0x50>
  8016ff:	39 cf                	cmp    %ecx,%edi
  801701:	77 65                	ja     801768 <__udivdi3+0x8c>
  801703:	89 fd                	mov    %edi,%ebp
  801705:	85 ff                	test   %edi,%edi
  801707:	75 0b                	jne    801714 <__udivdi3+0x38>
  801709:	b8 01 00 00 00       	mov    $0x1,%eax
  80170e:	31 d2                	xor    %edx,%edx
  801710:	f7 f7                	div    %edi
  801712:	89 c5                	mov    %eax,%ebp
  801714:	31 d2                	xor    %edx,%edx
  801716:	89 c8                	mov    %ecx,%eax
  801718:	f7 f5                	div    %ebp
  80171a:	89 c1                	mov    %eax,%ecx
  80171c:	89 d8                	mov    %ebx,%eax
  80171e:	f7 f5                	div    %ebp
  801720:	89 cf                	mov    %ecx,%edi
  801722:	89 fa                	mov    %edi,%edx
  801724:	83 c4 1c             	add    $0x1c,%esp
  801727:	5b                   	pop    %ebx
  801728:	5e                   	pop    %esi
  801729:	5f                   	pop    %edi
  80172a:	5d                   	pop    %ebp
  80172b:	c3                   	ret    
  80172c:	39 ce                	cmp    %ecx,%esi
  80172e:	77 28                	ja     801758 <__udivdi3+0x7c>
  801730:	0f bd fe             	bsr    %esi,%edi
  801733:	83 f7 1f             	xor    $0x1f,%edi
  801736:	75 40                	jne    801778 <__udivdi3+0x9c>
  801738:	39 ce                	cmp    %ecx,%esi
  80173a:	72 0a                	jb     801746 <__udivdi3+0x6a>
  80173c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801740:	0f 87 9e 00 00 00    	ja     8017e4 <__udivdi3+0x108>
  801746:	b8 01 00 00 00       	mov    $0x1,%eax
  80174b:	89 fa                	mov    %edi,%edx
  80174d:	83 c4 1c             	add    $0x1c,%esp
  801750:	5b                   	pop    %ebx
  801751:	5e                   	pop    %esi
  801752:	5f                   	pop    %edi
  801753:	5d                   	pop    %ebp
  801754:	c3                   	ret    
  801755:	8d 76 00             	lea    0x0(%esi),%esi
  801758:	31 ff                	xor    %edi,%edi
  80175a:	31 c0                	xor    %eax,%eax
  80175c:	89 fa                	mov    %edi,%edx
  80175e:	83 c4 1c             	add    $0x1c,%esp
  801761:	5b                   	pop    %ebx
  801762:	5e                   	pop    %esi
  801763:	5f                   	pop    %edi
  801764:	5d                   	pop    %ebp
  801765:	c3                   	ret    
  801766:	66 90                	xchg   %ax,%ax
  801768:	89 d8                	mov    %ebx,%eax
  80176a:	f7 f7                	div    %edi
  80176c:	31 ff                	xor    %edi,%edi
  80176e:	89 fa                	mov    %edi,%edx
  801770:	83 c4 1c             	add    $0x1c,%esp
  801773:	5b                   	pop    %ebx
  801774:	5e                   	pop    %esi
  801775:	5f                   	pop    %edi
  801776:	5d                   	pop    %ebp
  801777:	c3                   	ret    
  801778:	bd 20 00 00 00       	mov    $0x20,%ebp
  80177d:	89 eb                	mov    %ebp,%ebx
  80177f:	29 fb                	sub    %edi,%ebx
  801781:	89 f9                	mov    %edi,%ecx
  801783:	d3 e6                	shl    %cl,%esi
  801785:	89 c5                	mov    %eax,%ebp
  801787:	88 d9                	mov    %bl,%cl
  801789:	d3 ed                	shr    %cl,%ebp
  80178b:	89 e9                	mov    %ebp,%ecx
  80178d:	09 f1                	or     %esi,%ecx
  80178f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801793:	89 f9                	mov    %edi,%ecx
  801795:	d3 e0                	shl    %cl,%eax
  801797:	89 c5                	mov    %eax,%ebp
  801799:	89 d6                	mov    %edx,%esi
  80179b:	88 d9                	mov    %bl,%cl
  80179d:	d3 ee                	shr    %cl,%esi
  80179f:	89 f9                	mov    %edi,%ecx
  8017a1:	d3 e2                	shl    %cl,%edx
  8017a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017a7:	88 d9                	mov    %bl,%cl
  8017a9:	d3 e8                	shr    %cl,%eax
  8017ab:	09 c2                	or     %eax,%edx
  8017ad:	89 d0                	mov    %edx,%eax
  8017af:	89 f2                	mov    %esi,%edx
  8017b1:	f7 74 24 0c          	divl   0xc(%esp)
  8017b5:	89 d6                	mov    %edx,%esi
  8017b7:	89 c3                	mov    %eax,%ebx
  8017b9:	f7 e5                	mul    %ebp
  8017bb:	39 d6                	cmp    %edx,%esi
  8017bd:	72 19                	jb     8017d8 <__udivdi3+0xfc>
  8017bf:	74 0b                	je     8017cc <__udivdi3+0xf0>
  8017c1:	89 d8                	mov    %ebx,%eax
  8017c3:	31 ff                	xor    %edi,%edi
  8017c5:	e9 58 ff ff ff       	jmp    801722 <__udivdi3+0x46>
  8017ca:	66 90                	xchg   %ax,%ax
  8017cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017d0:	89 f9                	mov    %edi,%ecx
  8017d2:	d3 e2                	shl    %cl,%edx
  8017d4:	39 c2                	cmp    %eax,%edx
  8017d6:	73 e9                	jae    8017c1 <__udivdi3+0xe5>
  8017d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017db:	31 ff                	xor    %edi,%edi
  8017dd:	e9 40 ff ff ff       	jmp    801722 <__udivdi3+0x46>
  8017e2:	66 90                	xchg   %ax,%ax
  8017e4:	31 c0                	xor    %eax,%eax
  8017e6:	e9 37 ff ff ff       	jmp    801722 <__udivdi3+0x46>
  8017eb:	90                   	nop

008017ec <__umoddi3>:
  8017ec:	55                   	push   %ebp
  8017ed:	57                   	push   %edi
  8017ee:	56                   	push   %esi
  8017ef:	53                   	push   %ebx
  8017f0:	83 ec 1c             	sub    $0x1c,%esp
  8017f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801803:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801807:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80180b:	89 f3                	mov    %esi,%ebx
  80180d:	89 fa                	mov    %edi,%edx
  80180f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801813:	89 34 24             	mov    %esi,(%esp)
  801816:	85 c0                	test   %eax,%eax
  801818:	75 1a                	jne    801834 <__umoddi3+0x48>
  80181a:	39 f7                	cmp    %esi,%edi
  80181c:	0f 86 a2 00 00 00    	jbe    8018c4 <__umoddi3+0xd8>
  801822:	89 c8                	mov    %ecx,%eax
  801824:	89 f2                	mov    %esi,%edx
  801826:	f7 f7                	div    %edi
  801828:	89 d0                	mov    %edx,%eax
  80182a:	31 d2                	xor    %edx,%edx
  80182c:	83 c4 1c             	add    $0x1c,%esp
  80182f:	5b                   	pop    %ebx
  801830:	5e                   	pop    %esi
  801831:	5f                   	pop    %edi
  801832:	5d                   	pop    %ebp
  801833:	c3                   	ret    
  801834:	39 f0                	cmp    %esi,%eax
  801836:	0f 87 ac 00 00 00    	ja     8018e8 <__umoddi3+0xfc>
  80183c:	0f bd e8             	bsr    %eax,%ebp
  80183f:	83 f5 1f             	xor    $0x1f,%ebp
  801842:	0f 84 ac 00 00 00    	je     8018f4 <__umoddi3+0x108>
  801848:	bf 20 00 00 00       	mov    $0x20,%edi
  80184d:	29 ef                	sub    %ebp,%edi
  80184f:	89 fe                	mov    %edi,%esi
  801851:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801855:	89 e9                	mov    %ebp,%ecx
  801857:	d3 e0                	shl    %cl,%eax
  801859:	89 d7                	mov    %edx,%edi
  80185b:	89 f1                	mov    %esi,%ecx
  80185d:	d3 ef                	shr    %cl,%edi
  80185f:	09 c7                	or     %eax,%edi
  801861:	89 e9                	mov    %ebp,%ecx
  801863:	d3 e2                	shl    %cl,%edx
  801865:	89 14 24             	mov    %edx,(%esp)
  801868:	89 d8                	mov    %ebx,%eax
  80186a:	d3 e0                	shl    %cl,%eax
  80186c:	89 c2                	mov    %eax,%edx
  80186e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801872:	d3 e0                	shl    %cl,%eax
  801874:	89 44 24 04          	mov    %eax,0x4(%esp)
  801878:	8b 44 24 08          	mov    0x8(%esp),%eax
  80187c:	89 f1                	mov    %esi,%ecx
  80187e:	d3 e8                	shr    %cl,%eax
  801880:	09 d0                	or     %edx,%eax
  801882:	d3 eb                	shr    %cl,%ebx
  801884:	89 da                	mov    %ebx,%edx
  801886:	f7 f7                	div    %edi
  801888:	89 d3                	mov    %edx,%ebx
  80188a:	f7 24 24             	mull   (%esp)
  80188d:	89 c6                	mov    %eax,%esi
  80188f:	89 d1                	mov    %edx,%ecx
  801891:	39 d3                	cmp    %edx,%ebx
  801893:	0f 82 87 00 00 00    	jb     801920 <__umoddi3+0x134>
  801899:	0f 84 91 00 00 00    	je     801930 <__umoddi3+0x144>
  80189f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018a3:	29 f2                	sub    %esi,%edx
  8018a5:	19 cb                	sbb    %ecx,%ebx
  8018a7:	89 d8                	mov    %ebx,%eax
  8018a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018ad:	d3 e0                	shl    %cl,%eax
  8018af:	89 e9                	mov    %ebp,%ecx
  8018b1:	d3 ea                	shr    %cl,%edx
  8018b3:	09 d0                	or     %edx,%eax
  8018b5:	89 e9                	mov    %ebp,%ecx
  8018b7:	d3 eb                	shr    %cl,%ebx
  8018b9:	89 da                	mov    %ebx,%edx
  8018bb:	83 c4 1c             	add    $0x1c,%esp
  8018be:	5b                   	pop    %ebx
  8018bf:	5e                   	pop    %esi
  8018c0:	5f                   	pop    %edi
  8018c1:	5d                   	pop    %ebp
  8018c2:	c3                   	ret    
  8018c3:	90                   	nop
  8018c4:	89 fd                	mov    %edi,%ebp
  8018c6:	85 ff                	test   %edi,%edi
  8018c8:	75 0b                	jne    8018d5 <__umoddi3+0xe9>
  8018ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8018cf:	31 d2                	xor    %edx,%edx
  8018d1:	f7 f7                	div    %edi
  8018d3:	89 c5                	mov    %eax,%ebp
  8018d5:	89 f0                	mov    %esi,%eax
  8018d7:	31 d2                	xor    %edx,%edx
  8018d9:	f7 f5                	div    %ebp
  8018db:	89 c8                	mov    %ecx,%eax
  8018dd:	f7 f5                	div    %ebp
  8018df:	89 d0                	mov    %edx,%eax
  8018e1:	e9 44 ff ff ff       	jmp    80182a <__umoddi3+0x3e>
  8018e6:	66 90                	xchg   %ax,%ax
  8018e8:	89 c8                	mov    %ecx,%eax
  8018ea:	89 f2                	mov    %esi,%edx
  8018ec:	83 c4 1c             	add    $0x1c,%esp
  8018ef:	5b                   	pop    %ebx
  8018f0:	5e                   	pop    %esi
  8018f1:	5f                   	pop    %edi
  8018f2:	5d                   	pop    %ebp
  8018f3:	c3                   	ret    
  8018f4:	3b 04 24             	cmp    (%esp),%eax
  8018f7:	72 06                	jb     8018ff <__umoddi3+0x113>
  8018f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018fd:	77 0f                	ja     80190e <__umoddi3+0x122>
  8018ff:	89 f2                	mov    %esi,%edx
  801901:	29 f9                	sub    %edi,%ecx
  801903:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801907:	89 14 24             	mov    %edx,(%esp)
  80190a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80190e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801912:	8b 14 24             	mov    (%esp),%edx
  801915:	83 c4 1c             	add    $0x1c,%esp
  801918:	5b                   	pop    %ebx
  801919:	5e                   	pop    %esi
  80191a:	5f                   	pop    %edi
  80191b:	5d                   	pop    %ebp
  80191c:	c3                   	ret    
  80191d:	8d 76 00             	lea    0x0(%esi),%esi
  801920:	2b 04 24             	sub    (%esp),%eax
  801923:	19 fa                	sbb    %edi,%edx
  801925:	89 d1                	mov    %edx,%ecx
  801927:	89 c6                	mov    %eax,%esi
  801929:	e9 71 ff ff ff       	jmp    80189f <__umoddi3+0xb3>
  80192e:	66 90                	xchg   %ax,%ax
  801930:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801934:	72 ea                	jb     801920 <__umoddi3+0x134>
  801936:	89 d9                	mov    %ebx,%ecx
  801938:	e9 62 ff ff ff       	jmp    80189f <__umoddi3+0xb3>
