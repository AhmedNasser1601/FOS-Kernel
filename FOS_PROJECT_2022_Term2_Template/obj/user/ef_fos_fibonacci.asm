
obj/user/ef_fos_fibonacci:     file format elf32-i386


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
  800031:	e8 82 00 00 00       	call   8000b8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	i1 = 20;
  800048:	c7 45 f4 14 00 00 00 	movl   $0x14,-0xc(%ebp)

	int res = fibonacci(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <fibonacci>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 c0 18 80 00       	push   $0x8018c0
  80006e:	e8 55 02 00 00       	call   8002c8 <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <fibonacci>:


int fibonacci(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	53                   	push   %ebx
  80007d:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  800080:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800084:	7f 07                	jg     80008d <fibonacci+0x14>
		return 1 ;
  800086:	b8 01 00 00 00       	mov    $0x1,%eax
  80008b:	eb 26                	jmp    8000b3 <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  80008d:	8b 45 08             	mov    0x8(%ebp),%eax
  800090:	48                   	dec    %eax
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	50                   	push   %eax
  800095:	e8 df ff ff ff       	call   800079 <fibonacci>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 c3                	mov    %eax,%ebx
  80009f:	8b 45 08             	mov    0x8(%ebp),%eax
  8000a2:	83 e8 02             	sub    $0x2,%eax
  8000a5:	83 ec 0c             	sub    $0xc,%esp
  8000a8:	50                   	push   %eax
  8000a9:	e8 cb ff ff ff       	call   800079 <fibonacci>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	01 d8                	add    %ebx,%eax
}
  8000b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000b6:	c9                   	leave  
  8000b7:	c3                   	ret    

008000b8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000b8:	55                   	push   %ebp
  8000b9:	89 e5                	mov    %esp,%ebp
  8000bb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000be:	e8 03 10 00 00       	call   8010c6 <sys_getenvindex>
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c9:	89 d0                	mov    %edx,%eax
  8000cb:	c1 e0 02             	shl    $0x2,%eax
  8000ce:	01 d0                	add    %edx,%eax
  8000d0:	01 c0                	add    %eax,%eax
  8000d2:	01 d0                	add    %edx,%eax
  8000d4:	01 c0                	add    %eax,%eax
  8000d6:	01 d0                	add    %edx,%eax
  8000d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000df:	01 d0                	add    %edx,%eax
  8000e1:	c1 e0 02             	shl    $0x2,%eax
  8000e4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000e9:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000ee:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f3:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000f9:	84 c0                	test   %al,%al
  8000fb:	74 0f                	je     80010c <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000fd:	a1 04 20 80 00       	mov    0x802004,%eax
  800102:	05 f4 02 00 00       	add    $0x2f4,%eax
  800107:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80010c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800110:	7e 0a                	jle    80011c <libmain+0x64>
		binaryname = argv[0];
  800112:	8b 45 0c             	mov    0xc(%ebp),%eax
  800115:	8b 00                	mov    (%eax),%eax
  800117:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80011c:	83 ec 08             	sub    $0x8,%esp
  80011f:	ff 75 0c             	pushl  0xc(%ebp)
  800122:	ff 75 08             	pushl  0x8(%ebp)
  800125:	e8 0e ff ff ff       	call   800038 <_main>
  80012a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80012d:	e8 2f 11 00 00       	call   801261 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800132:	83 ec 0c             	sub    $0xc,%esp
  800135:	68 ec 18 80 00       	push   $0x8018ec
  80013a:	e8 5c 01 00 00       	call   80029b <cprintf>
  80013f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800142:	a1 04 20 80 00       	mov    0x802004,%eax
  800147:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80014d:	a1 04 20 80 00       	mov    0x802004,%eax
  800152:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	52                   	push   %edx
  80015c:	50                   	push   %eax
  80015d:	68 14 19 80 00       	push   $0x801914
  800162:	e8 34 01 00 00       	call   80029b <cprintf>
  800167:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80016a:	a1 04 20 80 00       	mov    0x802004,%eax
  80016f:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	50                   	push   %eax
  800179:	68 39 19 80 00       	push   $0x801939
  80017e:	e8 18 01 00 00       	call   80029b <cprintf>
  800183:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	68 ec 18 80 00       	push   $0x8018ec
  80018e:	e8 08 01 00 00       	call   80029b <cprintf>
  800193:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800196:	e8 e0 10 00 00       	call   80127b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80019b:	e8 19 00 00 00       	call   8001b9 <exit>
}
  8001a0:	90                   	nop
  8001a1:	c9                   	leave  
  8001a2:	c3                   	ret    

008001a3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001a3:	55                   	push   %ebp
  8001a4:	89 e5                	mov    %esp,%ebp
  8001a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001a9:	83 ec 0c             	sub    $0xc,%esp
  8001ac:	6a 00                	push   $0x0
  8001ae:	e8 df 0e 00 00       	call   801092 <sys_env_destroy>
  8001b3:	83 c4 10             	add    $0x10,%esp
}
  8001b6:	90                   	nop
  8001b7:	c9                   	leave  
  8001b8:	c3                   	ret    

008001b9 <exit>:

void
exit(void)
{
  8001b9:	55                   	push   %ebp
  8001ba:	89 e5                	mov    %esp,%ebp
  8001bc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001bf:	e8 34 0f 00 00       	call   8010f8 <sys_env_exit>
}
  8001c4:	90                   	nop
  8001c5:	c9                   	leave  
  8001c6:	c3                   	ret    

008001c7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001c7:	55                   	push   %ebp
  8001c8:	89 e5                	mov    %esp,%ebp
  8001ca:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d0:	8b 00                	mov    (%eax),%eax
  8001d2:	8d 48 01             	lea    0x1(%eax),%ecx
  8001d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d8:	89 0a                	mov    %ecx,(%edx)
  8001da:	8b 55 08             	mov    0x8(%ebp),%edx
  8001dd:	88 d1                	mov    %dl,%cl
  8001df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e9:	8b 00                	mov    (%eax),%eax
  8001eb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001f0:	75 2c                	jne    80021e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001f2:	a0 08 20 80 00       	mov    0x802008,%al
  8001f7:	0f b6 c0             	movzbl %al,%eax
  8001fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fd:	8b 12                	mov    (%edx),%edx
  8001ff:	89 d1                	mov    %edx,%ecx
  800201:	8b 55 0c             	mov    0xc(%ebp),%edx
  800204:	83 c2 08             	add    $0x8,%edx
  800207:	83 ec 04             	sub    $0x4,%esp
  80020a:	50                   	push   %eax
  80020b:	51                   	push   %ecx
  80020c:	52                   	push   %edx
  80020d:	e8 3e 0e 00 00       	call   801050 <sys_cputs>
  800212:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800215:	8b 45 0c             	mov    0xc(%ebp),%eax
  800218:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80021e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800221:	8b 40 04             	mov    0x4(%eax),%eax
  800224:	8d 50 01             	lea    0x1(%eax),%edx
  800227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80022d:	90                   	nop
  80022e:	c9                   	leave  
  80022f:	c3                   	ret    

00800230 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800230:	55                   	push   %ebp
  800231:	89 e5                	mov    %esp,%ebp
  800233:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800239:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800240:	00 00 00 
	b.cnt = 0;
  800243:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80024a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80024d:	ff 75 0c             	pushl  0xc(%ebp)
  800250:	ff 75 08             	pushl  0x8(%ebp)
  800253:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800259:	50                   	push   %eax
  80025a:	68 c7 01 80 00       	push   $0x8001c7
  80025f:	e8 11 02 00 00       	call   800475 <vprintfmt>
  800264:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800267:	a0 08 20 80 00       	mov    0x802008,%al
  80026c:	0f b6 c0             	movzbl %al,%eax
  80026f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800275:	83 ec 04             	sub    $0x4,%esp
  800278:	50                   	push   %eax
  800279:	52                   	push   %edx
  80027a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800280:	83 c0 08             	add    $0x8,%eax
  800283:	50                   	push   %eax
  800284:	e8 c7 0d 00 00       	call   801050 <sys_cputs>
  800289:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80028c:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800293:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800299:	c9                   	leave  
  80029a:	c3                   	ret    

0080029b <cprintf>:

int cprintf(const char *fmt, ...) {
  80029b:	55                   	push   %ebp
  80029c:	89 e5                	mov    %esp,%ebp
  80029e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002a1:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002a8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b7:	50                   	push   %eax
  8002b8:	e8 73 ff ff ff       	call   800230 <vcprintf>
  8002bd:	83 c4 10             	add    $0x10,%esp
  8002c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002c6:	c9                   	leave  
  8002c7:	c3                   	ret    

008002c8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002c8:	55                   	push   %ebp
  8002c9:	89 e5                	mov    %esp,%ebp
  8002cb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ce:	e8 8e 0f 00 00       	call   801261 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002d3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002dc:	83 ec 08             	sub    $0x8,%esp
  8002df:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e2:	50                   	push   %eax
  8002e3:	e8 48 ff ff ff       	call   800230 <vcprintf>
  8002e8:	83 c4 10             	add    $0x10,%esp
  8002eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002ee:	e8 88 0f 00 00       	call   80127b <sys_enable_interrupt>
	return cnt;
  8002f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f6:	c9                   	leave  
  8002f7:	c3                   	ret    

008002f8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002f8:	55                   	push   %ebp
  8002f9:	89 e5                	mov    %esp,%ebp
  8002fb:	53                   	push   %ebx
  8002fc:	83 ec 14             	sub    $0x14,%esp
  8002ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800302:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800305:	8b 45 14             	mov    0x14(%ebp),%eax
  800308:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80030b:	8b 45 18             	mov    0x18(%ebp),%eax
  80030e:	ba 00 00 00 00       	mov    $0x0,%edx
  800313:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800316:	77 55                	ja     80036d <printnum+0x75>
  800318:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80031b:	72 05                	jb     800322 <printnum+0x2a>
  80031d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800320:	77 4b                	ja     80036d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800322:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800325:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800328:	8b 45 18             	mov    0x18(%ebp),%eax
  80032b:	ba 00 00 00 00       	mov    $0x0,%edx
  800330:	52                   	push   %edx
  800331:	50                   	push   %eax
  800332:	ff 75 f4             	pushl  -0xc(%ebp)
  800335:	ff 75 f0             	pushl  -0x10(%ebp)
  800338:	e8 03 13 00 00       	call   801640 <__udivdi3>
  80033d:	83 c4 10             	add    $0x10,%esp
  800340:	83 ec 04             	sub    $0x4,%esp
  800343:	ff 75 20             	pushl  0x20(%ebp)
  800346:	53                   	push   %ebx
  800347:	ff 75 18             	pushl  0x18(%ebp)
  80034a:	52                   	push   %edx
  80034b:	50                   	push   %eax
  80034c:	ff 75 0c             	pushl  0xc(%ebp)
  80034f:	ff 75 08             	pushl  0x8(%ebp)
  800352:	e8 a1 ff ff ff       	call   8002f8 <printnum>
  800357:	83 c4 20             	add    $0x20,%esp
  80035a:	eb 1a                	jmp    800376 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80035c:	83 ec 08             	sub    $0x8,%esp
  80035f:	ff 75 0c             	pushl  0xc(%ebp)
  800362:	ff 75 20             	pushl  0x20(%ebp)
  800365:	8b 45 08             	mov    0x8(%ebp),%eax
  800368:	ff d0                	call   *%eax
  80036a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80036d:	ff 4d 1c             	decl   0x1c(%ebp)
  800370:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800374:	7f e6                	jg     80035c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800376:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800379:	bb 00 00 00 00       	mov    $0x0,%ebx
  80037e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800381:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800384:	53                   	push   %ebx
  800385:	51                   	push   %ecx
  800386:	52                   	push   %edx
  800387:	50                   	push   %eax
  800388:	e8 c3 13 00 00       	call   801750 <__umoddi3>
  80038d:	83 c4 10             	add    $0x10,%esp
  800390:	05 74 1b 80 00       	add    $0x801b74,%eax
  800395:	8a 00                	mov    (%eax),%al
  800397:	0f be c0             	movsbl %al,%eax
  80039a:	83 ec 08             	sub    $0x8,%esp
  80039d:	ff 75 0c             	pushl  0xc(%ebp)
  8003a0:	50                   	push   %eax
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	ff d0                	call   *%eax
  8003a6:	83 c4 10             	add    $0x10,%esp
}
  8003a9:	90                   	nop
  8003aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ad:	c9                   	leave  
  8003ae:	c3                   	ret    

008003af <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003af:	55                   	push   %ebp
  8003b0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003b6:	7e 1c                	jle    8003d4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	8d 50 08             	lea    0x8(%eax),%edx
  8003c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c3:	89 10                	mov    %edx,(%eax)
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	8b 00                	mov    (%eax),%eax
  8003ca:	83 e8 08             	sub    $0x8,%eax
  8003cd:	8b 50 04             	mov    0x4(%eax),%edx
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	eb 40                	jmp    800414 <getuint+0x65>
	else if (lflag)
  8003d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003d8:	74 1e                	je     8003f8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	8d 50 04             	lea    0x4(%eax),%edx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	89 10                	mov    %edx,(%eax)
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	83 e8 04             	sub    $0x4,%eax
  8003ef:	8b 00                	mov    (%eax),%eax
  8003f1:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f6:	eb 1c                	jmp    800414 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	8b 00                	mov    (%eax),%eax
  8003fd:	8d 50 04             	lea    0x4(%eax),%edx
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	89 10                	mov    %edx,(%eax)
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	83 e8 04             	sub    $0x4,%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800414:	5d                   	pop    %ebp
  800415:	c3                   	ret    

00800416 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800416:	55                   	push   %ebp
  800417:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800419:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80041d:	7e 1c                	jle    80043b <getint+0x25>
		return va_arg(*ap, long long);
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	8d 50 08             	lea    0x8(%eax),%edx
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	89 10                	mov    %edx,(%eax)
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	83 e8 08             	sub    $0x8,%eax
  800434:	8b 50 04             	mov    0x4(%eax),%edx
  800437:	8b 00                	mov    (%eax),%eax
  800439:	eb 38                	jmp    800473 <getint+0x5d>
	else if (lflag)
  80043b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80043f:	74 1a                	je     80045b <getint+0x45>
		return va_arg(*ap, long);
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	8b 00                	mov    (%eax),%eax
  800446:	8d 50 04             	lea    0x4(%eax),%edx
  800449:	8b 45 08             	mov    0x8(%ebp),%eax
  80044c:	89 10                	mov    %edx,(%eax)
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	83 e8 04             	sub    $0x4,%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	99                   	cltd   
  800459:	eb 18                	jmp    800473 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	8b 00                	mov    (%eax),%eax
  800460:	8d 50 04             	lea    0x4(%eax),%edx
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	89 10                	mov    %edx,(%eax)
  800468:	8b 45 08             	mov    0x8(%ebp),%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	83 e8 04             	sub    $0x4,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	99                   	cltd   
}
  800473:	5d                   	pop    %ebp
  800474:	c3                   	ret    

00800475 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800475:	55                   	push   %ebp
  800476:	89 e5                	mov    %esp,%ebp
  800478:	56                   	push   %esi
  800479:	53                   	push   %ebx
  80047a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80047d:	eb 17                	jmp    800496 <vprintfmt+0x21>
			if (ch == '\0')
  80047f:	85 db                	test   %ebx,%ebx
  800481:	0f 84 af 03 00 00    	je     800836 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800487:	83 ec 08             	sub    $0x8,%esp
  80048a:	ff 75 0c             	pushl  0xc(%ebp)
  80048d:	53                   	push   %ebx
  80048e:	8b 45 08             	mov    0x8(%ebp),%eax
  800491:	ff d0                	call   *%eax
  800493:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800496:	8b 45 10             	mov    0x10(%ebp),%eax
  800499:	8d 50 01             	lea    0x1(%eax),%edx
  80049c:	89 55 10             	mov    %edx,0x10(%ebp)
  80049f:	8a 00                	mov    (%eax),%al
  8004a1:	0f b6 d8             	movzbl %al,%ebx
  8004a4:	83 fb 25             	cmp    $0x25,%ebx
  8004a7:	75 d6                	jne    80047f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004a9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ad:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004b4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004c2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cc:	8d 50 01             	lea    0x1(%eax),%edx
  8004cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d2:	8a 00                	mov    (%eax),%al
  8004d4:	0f b6 d8             	movzbl %al,%ebx
  8004d7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004da:	83 f8 55             	cmp    $0x55,%eax
  8004dd:	0f 87 2b 03 00 00    	ja     80080e <vprintfmt+0x399>
  8004e3:	8b 04 85 98 1b 80 00 	mov    0x801b98(,%eax,4),%eax
  8004ea:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004ec:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004f0:	eb d7                	jmp    8004c9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004f2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004f6:	eb d1                	jmp    8004c9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004f8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800502:	89 d0                	mov    %edx,%eax
  800504:	c1 e0 02             	shl    $0x2,%eax
  800507:	01 d0                	add    %edx,%eax
  800509:	01 c0                	add    %eax,%eax
  80050b:	01 d8                	add    %ebx,%eax
  80050d:	83 e8 30             	sub    $0x30,%eax
  800510:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800513:	8b 45 10             	mov    0x10(%ebp),%eax
  800516:	8a 00                	mov    (%eax),%al
  800518:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80051b:	83 fb 2f             	cmp    $0x2f,%ebx
  80051e:	7e 3e                	jle    80055e <vprintfmt+0xe9>
  800520:	83 fb 39             	cmp    $0x39,%ebx
  800523:	7f 39                	jg     80055e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800525:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800528:	eb d5                	jmp    8004ff <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80052a:	8b 45 14             	mov    0x14(%ebp),%eax
  80052d:	83 c0 04             	add    $0x4,%eax
  800530:	89 45 14             	mov    %eax,0x14(%ebp)
  800533:	8b 45 14             	mov    0x14(%ebp),%eax
  800536:	83 e8 04             	sub    $0x4,%eax
  800539:	8b 00                	mov    (%eax),%eax
  80053b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80053e:	eb 1f                	jmp    80055f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800544:	79 83                	jns    8004c9 <vprintfmt+0x54>
				width = 0;
  800546:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80054d:	e9 77 ff ff ff       	jmp    8004c9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800552:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800559:	e9 6b ff ff ff       	jmp    8004c9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80055e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80055f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800563:	0f 89 60 ff ff ff    	jns    8004c9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800569:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80056f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800576:	e9 4e ff ff ff       	jmp    8004c9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80057b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80057e:	e9 46 ff ff ff       	jmp    8004c9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800583:	8b 45 14             	mov    0x14(%ebp),%eax
  800586:	83 c0 04             	add    $0x4,%eax
  800589:	89 45 14             	mov    %eax,0x14(%ebp)
  80058c:	8b 45 14             	mov    0x14(%ebp),%eax
  80058f:	83 e8 04             	sub    $0x4,%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	83 ec 08             	sub    $0x8,%esp
  800597:	ff 75 0c             	pushl  0xc(%ebp)
  80059a:	50                   	push   %eax
  80059b:	8b 45 08             	mov    0x8(%ebp),%eax
  80059e:	ff d0                	call   *%eax
  8005a0:	83 c4 10             	add    $0x10,%esp
			break;
  8005a3:	e9 89 02 00 00       	jmp    800831 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ab:	83 c0 04             	add    $0x4,%eax
  8005ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b4:	83 e8 04             	sub    $0x4,%eax
  8005b7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005b9:	85 db                	test   %ebx,%ebx
  8005bb:	79 02                	jns    8005bf <vprintfmt+0x14a>
				err = -err;
  8005bd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005bf:	83 fb 64             	cmp    $0x64,%ebx
  8005c2:	7f 0b                	jg     8005cf <vprintfmt+0x15a>
  8005c4:	8b 34 9d e0 19 80 00 	mov    0x8019e0(,%ebx,4),%esi
  8005cb:	85 f6                	test   %esi,%esi
  8005cd:	75 19                	jne    8005e8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005cf:	53                   	push   %ebx
  8005d0:	68 85 1b 80 00       	push   $0x801b85
  8005d5:	ff 75 0c             	pushl  0xc(%ebp)
  8005d8:	ff 75 08             	pushl  0x8(%ebp)
  8005db:	e8 5e 02 00 00       	call   80083e <printfmt>
  8005e0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005e3:	e9 49 02 00 00       	jmp    800831 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005e8:	56                   	push   %esi
  8005e9:	68 8e 1b 80 00       	push   $0x801b8e
  8005ee:	ff 75 0c             	pushl  0xc(%ebp)
  8005f1:	ff 75 08             	pushl  0x8(%ebp)
  8005f4:	e8 45 02 00 00       	call   80083e <printfmt>
  8005f9:	83 c4 10             	add    $0x10,%esp
			break;
  8005fc:	e9 30 02 00 00       	jmp    800831 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800601:	8b 45 14             	mov    0x14(%ebp),%eax
  800604:	83 c0 04             	add    $0x4,%eax
  800607:	89 45 14             	mov    %eax,0x14(%ebp)
  80060a:	8b 45 14             	mov    0x14(%ebp),%eax
  80060d:	83 e8 04             	sub    $0x4,%eax
  800610:	8b 30                	mov    (%eax),%esi
  800612:	85 f6                	test   %esi,%esi
  800614:	75 05                	jne    80061b <vprintfmt+0x1a6>
				p = "(null)";
  800616:	be 91 1b 80 00       	mov    $0x801b91,%esi
			if (width > 0 && padc != '-')
  80061b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061f:	7e 6d                	jle    80068e <vprintfmt+0x219>
  800621:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800625:	74 67                	je     80068e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800627:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	50                   	push   %eax
  80062e:	56                   	push   %esi
  80062f:	e8 0c 03 00 00       	call   800940 <strnlen>
  800634:	83 c4 10             	add    $0x10,%esp
  800637:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80063a:	eb 16                	jmp    800652 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80063c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800640:	83 ec 08             	sub    $0x8,%esp
  800643:	ff 75 0c             	pushl  0xc(%ebp)
  800646:	50                   	push   %eax
  800647:	8b 45 08             	mov    0x8(%ebp),%eax
  80064a:	ff d0                	call   *%eax
  80064c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80064f:	ff 4d e4             	decl   -0x1c(%ebp)
  800652:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800656:	7f e4                	jg     80063c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800658:	eb 34                	jmp    80068e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80065a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80065e:	74 1c                	je     80067c <vprintfmt+0x207>
  800660:	83 fb 1f             	cmp    $0x1f,%ebx
  800663:	7e 05                	jle    80066a <vprintfmt+0x1f5>
  800665:	83 fb 7e             	cmp    $0x7e,%ebx
  800668:	7e 12                	jle    80067c <vprintfmt+0x207>
					putch('?', putdat);
  80066a:	83 ec 08             	sub    $0x8,%esp
  80066d:	ff 75 0c             	pushl  0xc(%ebp)
  800670:	6a 3f                	push   $0x3f
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	ff d0                	call   *%eax
  800677:	83 c4 10             	add    $0x10,%esp
  80067a:	eb 0f                	jmp    80068b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80067c:	83 ec 08             	sub    $0x8,%esp
  80067f:	ff 75 0c             	pushl  0xc(%ebp)
  800682:	53                   	push   %ebx
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	ff d0                	call   *%eax
  800688:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80068b:	ff 4d e4             	decl   -0x1c(%ebp)
  80068e:	89 f0                	mov    %esi,%eax
  800690:	8d 70 01             	lea    0x1(%eax),%esi
  800693:	8a 00                	mov    (%eax),%al
  800695:	0f be d8             	movsbl %al,%ebx
  800698:	85 db                	test   %ebx,%ebx
  80069a:	74 24                	je     8006c0 <vprintfmt+0x24b>
  80069c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a0:	78 b8                	js     80065a <vprintfmt+0x1e5>
  8006a2:	ff 4d e0             	decl   -0x20(%ebp)
  8006a5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a9:	79 af                	jns    80065a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ab:	eb 13                	jmp    8006c0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ad:	83 ec 08             	sub    $0x8,%esp
  8006b0:	ff 75 0c             	pushl  0xc(%ebp)
  8006b3:	6a 20                	push   $0x20
  8006b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b8:	ff d0                	call   *%eax
  8006ba:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006bd:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c4:	7f e7                	jg     8006ad <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006c6:	e9 66 01 00 00       	jmp    800831 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006cb:	83 ec 08             	sub    $0x8,%esp
  8006ce:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d4:	50                   	push   %eax
  8006d5:	e8 3c fd ff ff       	call   800416 <getint>
  8006da:	83 c4 10             	add    $0x10,%esp
  8006dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e9:	85 d2                	test   %edx,%edx
  8006eb:	79 23                	jns    800710 <vprintfmt+0x29b>
				putch('-', putdat);
  8006ed:	83 ec 08             	sub    $0x8,%esp
  8006f0:	ff 75 0c             	pushl  0xc(%ebp)
  8006f3:	6a 2d                	push   $0x2d
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	ff d0                	call   *%eax
  8006fa:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800700:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800703:	f7 d8                	neg    %eax
  800705:	83 d2 00             	adc    $0x0,%edx
  800708:	f7 da                	neg    %edx
  80070a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800710:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800717:	e9 bc 00 00 00       	jmp    8007d8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	ff 75 e8             	pushl  -0x18(%ebp)
  800722:	8d 45 14             	lea    0x14(%ebp),%eax
  800725:	50                   	push   %eax
  800726:	e8 84 fc ff ff       	call   8003af <getuint>
  80072b:	83 c4 10             	add    $0x10,%esp
  80072e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800731:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800734:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80073b:	e9 98 00 00 00       	jmp    8007d8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800740:	83 ec 08             	sub    $0x8,%esp
  800743:	ff 75 0c             	pushl  0xc(%ebp)
  800746:	6a 58                	push   $0x58
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	ff d0                	call   *%eax
  80074d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800750:	83 ec 08             	sub    $0x8,%esp
  800753:	ff 75 0c             	pushl  0xc(%ebp)
  800756:	6a 58                	push   $0x58
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	ff d0                	call   *%eax
  80075d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 0c             	pushl  0xc(%ebp)
  800766:	6a 58                	push   $0x58
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
			break;
  800770:	e9 bc 00 00 00       	jmp    800831 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 0c             	pushl  0xc(%ebp)
  80077b:	6a 30                	push   $0x30
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	ff d0                	call   *%eax
  800782:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800785:	83 ec 08             	sub    $0x8,%esp
  800788:	ff 75 0c             	pushl  0xc(%ebp)
  80078b:	6a 78                	push   $0x78
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	ff d0                	call   *%eax
  800792:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800795:	8b 45 14             	mov    0x14(%ebp),%eax
  800798:	83 c0 04             	add    $0x4,%eax
  80079b:	89 45 14             	mov    %eax,0x14(%ebp)
  80079e:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a1:	83 e8 04             	sub    $0x4,%eax
  8007a4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007b0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007b7:	eb 1f                	jmp    8007d8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007b9:	83 ec 08             	sub    $0x8,%esp
  8007bc:	ff 75 e8             	pushl  -0x18(%ebp)
  8007bf:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c2:	50                   	push   %eax
  8007c3:	e8 e7 fb ff ff       	call   8003af <getuint>
  8007c8:	83 c4 10             	add    $0x10,%esp
  8007cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007d1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007d8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007df:	83 ec 04             	sub    $0x4,%esp
  8007e2:	52                   	push   %edx
  8007e3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007e6:	50                   	push   %eax
  8007e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8007ed:	ff 75 0c             	pushl  0xc(%ebp)
  8007f0:	ff 75 08             	pushl  0x8(%ebp)
  8007f3:	e8 00 fb ff ff       	call   8002f8 <printnum>
  8007f8:	83 c4 20             	add    $0x20,%esp
			break;
  8007fb:	eb 34                	jmp    800831 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007fd:	83 ec 08             	sub    $0x8,%esp
  800800:	ff 75 0c             	pushl  0xc(%ebp)
  800803:	53                   	push   %ebx
  800804:	8b 45 08             	mov    0x8(%ebp),%eax
  800807:	ff d0                	call   *%eax
  800809:	83 c4 10             	add    $0x10,%esp
			break;
  80080c:	eb 23                	jmp    800831 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	6a 25                	push   $0x25
  800816:	8b 45 08             	mov    0x8(%ebp),%eax
  800819:	ff d0                	call   *%eax
  80081b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80081e:	ff 4d 10             	decl   0x10(%ebp)
  800821:	eb 03                	jmp    800826 <vprintfmt+0x3b1>
  800823:	ff 4d 10             	decl   0x10(%ebp)
  800826:	8b 45 10             	mov    0x10(%ebp),%eax
  800829:	48                   	dec    %eax
  80082a:	8a 00                	mov    (%eax),%al
  80082c:	3c 25                	cmp    $0x25,%al
  80082e:	75 f3                	jne    800823 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800830:	90                   	nop
		}
	}
  800831:	e9 47 fc ff ff       	jmp    80047d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800836:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800837:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80083a:	5b                   	pop    %ebx
  80083b:	5e                   	pop    %esi
  80083c:	5d                   	pop    %ebp
  80083d:	c3                   	ret    

0080083e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80083e:	55                   	push   %ebp
  80083f:	89 e5                	mov    %esp,%ebp
  800841:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800844:	8d 45 10             	lea    0x10(%ebp),%eax
  800847:	83 c0 04             	add    $0x4,%eax
  80084a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80084d:	8b 45 10             	mov    0x10(%ebp),%eax
  800850:	ff 75 f4             	pushl  -0xc(%ebp)
  800853:	50                   	push   %eax
  800854:	ff 75 0c             	pushl  0xc(%ebp)
  800857:	ff 75 08             	pushl  0x8(%ebp)
  80085a:	e8 16 fc ff ff       	call   800475 <vprintfmt>
  80085f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800862:	90                   	nop
  800863:	c9                   	leave  
  800864:	c3                   	ret    

00800865 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800865:	55                   	push   %ebp
  800866:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800868:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086b:	8b 40 08             	mov    0x8(%eax),%eax
  80086e:	8d 50 01             	lea    0x1(%eax),%edx
  800871:	8b 45 0c             	mov    0xc(%ebp),%eax
  800874:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087a:	8b 10                	mov    (%eax),%edx
  80087c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087f:	8b 40 04             	mov    0x4(%eax),%eax
  800882:	39 c2                	cmp    %eax,%edx
  800884:	73 12                	jae    800898 <sprintputch+0x33>
		*b->buf++ = ch;
  800886:	8b 45 0c             	mov    0xc(%ebp),%eax
  800889:	8b 00                	mov    (%eax),%eax
  80088b:	8d 48 01             	lea    0x1(%eax),%ecx
  80088e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800891:	89 0a                	mov    %ecx,(%edx)
  800893:	8b 55 08             	mov    0x8(%ebp),%edx
  800896:	88 10                	mov    %dl,(%eax)
}
  800898:	90                   	nop
  800899:	5d                   	pop    %ebp
  80089a:	c3                   	ret    

0080089b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80089b:	55                   	push   %ebp
  80089c:	89 e5                	mov    %esp,%ebp
  80089e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008c0:	74 06                	je     8008c8 <vsnprintf+0x2d>
  8008c2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c6:	7f 07                	jg     8008cf <vsnprintf+0x34>
		return -E_INVAL;
  8008c8:	b8 03 00 00 00       	mov    $0x3,%eax
  8008cd:	eb 20                	jmp    8008ef <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008cf:	ff 75 14             	pushl  0x14(%ebp)
  8008d2:	ff 75 10             	pushl  0x10(%ebp)
  8008d5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008d8:	50                   	push   %eax
  8008d9:	68 65 08 80 00       	push   $0x800865
  8008de:	e8 92 fb ff ff       	call   800475 <vprintfmt>
  8008e3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008e9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008ef:	c9                   	leave  
  8008f0:	c3                   	ret    

008008f1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008f1:	55                   	push   %ebp
  8008f2:	89 e5                	mov    %esp,%ebp
  8008f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008f7:	8d 45 10             	lea    0x10(%ebp),%eax
  8008fa:	83 c0 04             	add    $0x4,%eax
  8008fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800900:	8b 45 10             	mov    0x10(%ebp),%eax
  800903:	ff 75 f4             	pushl  -0xc(%ebp)
  800906:	50                   	push   %eax
  800907:	ff 75 0c             	pushl  0xc(%ebp)
  80090a:	ff 75 08             	pushl  0x8(%ebp)
  80090d:	e8 89 ff ff ff       	call   80089b <vsnprintf>
  800912:	83 c4 10             	add    $0x10,%esp
  800915:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800918:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80091b:	c9                   	leave  
  80091c:	c3                   	ret    

0080091d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80091d:	55                   	push   %ebp
  80091e:	89 e5                	mov    %esp,%ebp
  800920:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800923:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80092a:	eb 06                	jmp    800932 <strlen+0x15>
		n++;
  80092c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80092f:	ff 45 08             	incl   0x8(%ebp)
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	8a 00                	mov    (%eax),%al
  800937:	84 c0                	test   %al,%al
  800939:	75 f1                	jne    80092c <strlen+0xf>
		n++;
	return n;
  80093b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80093e:	c9                   	leave  
  80093f:	c3                   	ret    

00800940 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800946:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094d:	eb 09                	jmp    800958 <strnlen+0x18>
		n++;
  80094f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800952:	ff 45 08             	incl   0x8(%ebp)
  800955:	ff 4d 0c             	decl   0xc(%ebp)
  800958:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095c:	74 09                	je     800967 <strnlen+0x27>
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	8a 00                	mov    (%eax),%al
  800963:	84 c0                	test   %al,%al
  800965:	75 e8                	jne    80094f <strnlen+0xf>
		n++;
	return n;
  800967:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80096a:	c9                   	leave  
  80096b:	c3                   	ret    

0080096c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80096c:	55                   	push   %ebp
  80096d:	89 e5                	mov    %esp,%ebp
  80096f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800978:	90                   	nop
  800979:	8b 45 08             	mov    0x8(%ebp),%eax
  80097c:	8d 50 01             	lea    0x1(%eax),%edx
  80097f:	89 55 08             	mov    %edx,0x8(%ebp)
  800982:	8b 55 0c             	mov    0xc(%ebp),%edx
  800985:	8d 4a 01             	lea    0x1(%edx),%ecx
  800988:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80098b:	8a 12                	mov    (%edx),%dl
  80098d:	88 10                	mov    %dl,(%eax)
  80098f:	8a 00                	mov    (%eax),%al
  800991:	84 c0                	test   %al,%al
  800993:	75 e4                	jne    800979 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800995:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800998:	c9                   	leave  
  800999:	c3                   	ret    

0080099a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80099a:	55                   	push   %ebp
  80099b:	89 e5                	mov    %esp,%ebp
  80099d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ad:	eb 1f                	jmp    8009ce <strncpy+0x34>
		*dst++ = *src;
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	8d 50 01             	lea    0x1(%eax),%edx
  8009b5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009bb:	8a 12                	mov    (%edx),%dl
  8009bd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c2:	8a 00                	mov    (%eax),%al
  8009c4:	84 c0                	test   %al,%al
  8009c6:	74 03                	je     8009cb <strncpy+0x31>
			src++;
  8009c8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009cb:	ff 45 fc             	incl   -0x4(%ebp)
  8009ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009d4:	72 d9                	jb     8009af <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009eb:	74 30                	je     800a1d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009ed:	eb 16                	jmp    800a05 <strlcpy+0x2a>
			*dst++ = *src++;
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	8d 50 01             	lea    0x1(%eax),%edx
  8009f5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009fe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a01:	8a 12                	mov    (%edx),%dl
  800a03:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a05:	ff 4d 10             	decl   0x10(%ebp)
  800a08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0c:	74 09                	je     800a17 <strlcpy+0x3c>
  800a0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a11:	8a 00                	mov    (%eax),%al
  800a13:	84 c0                	test   %al,%al
  800a15:	75 d8                	jne    8009ef <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a1d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a23:	29 c2                	sub    %eax,%edx
  800a25:	89 d0                	mov    %edx,%eax
}
  800a27:	c9                   	leave  
  800a28:	c3                   	ret    

00800a29 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a29:	55                   	push   %ebp
  800a2a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a2c:	eb 06                	jmp    800a34 <strcmp+0xb>
		p++, q++;
  800a2e:	ff 45 08             	incl   0x8(%ebp)
  800a31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a34:	8b 45 08             	mov    0x8(%ebp),%eax
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	84 c0                	test   %al,%al
  800a3b:	74 0e                	je     800a4b <strcmp+0x22>
  800a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a40:	8a 10                	mov    (%eax),%dl
  800a42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a45:	8a 00                	mov    (%eax),%al
  800a47:	38 c2                	cmp    %al,%dl
  800a49:	74 e3                	je     800a2e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4e:	8a 00                	mov    (%eax),%al
  800a50:	0f b6 d0             	movzbl %al,%edx
  800a53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a56:	8a 00                	mov    (%eax),%al
  800a58:	0f b6 c0             	movzbl %al,%eax
  800a5b:	29 c2                	sub    %eax,%edx
  800a5d:	89 d0                	mov    %edx,%eax
}
  800a5f:	5d                   	pop    %ebp
  800a60:	c3                   	ret    

00800a61 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a61:	55                   	push   %ebp
  800a62:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a64:	eb 09                	jmp    800a6f <strncmp+0xe>
		n--, p++, q++;
  800a66:	ff 4d 10             	decl   0x10(%ebp)
  800a69:	ff 45 08             	incl   0x8(%ebp)
  800a6c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a73:	74 17                	je     800a8c <strncmp+0x2b>
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	84 c0                	test   %al,%al
  800a7c:	74 0e                	je     800a8c <strncmp+0x2b>
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	8a 10                	mov    (%eax),%dl
  800a83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	38 c2                	cmp    %al,%dl
  800a8a:	74 da                	je     800a66 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a90:	75 07                	jne    800a99 <strncmp+0x38>
		return 0;
  800a92:	b8 00 00 00 00       	mov    $0x0,%eax
  800a97:	eb 14                	jmp    800aad <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	8a 00                	mov    (%eax),%al
  800a9e:	0f b6 d0             	movzbl %al,%edx
  800aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa4:	8a 00                	mov    (%eax),%al
  800aa6:	0f b6 c0             	movzbl %al,%eax
  800aa9:	29 c2                	sub    %eax,%edx
  800aab:	89 d0                	mov    %edx,%eax
}
  800aad:	5d                   	pop    %ebp
  800aae:	c3                   	ret    

00800aaf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aaf:	55                   	push   %ebp
  800ab0:	89 e5                	mov    %esp,%ebp
  800ab2:	83 ec 04             	sub    $0x4,%esp
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800abb:	eb 12                	jmp    800acf <strchr+0x20>
		if (*s == c)
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	8a 00                	mov    (%eax),%al
  800ac2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ac5:	75 05                	jne    800acc <strchr+0x1d>
			return (char *) s;
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	eb 11                	jmp    800add <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800acc:	ff 45 08             	incl   0x8(%ebp)
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8a 00                	mov    (%eax),%al
  800ad4:	84 c0                	test   %al,%al
  800ad6:	75 e5                	jne    800abd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ad8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800add:	c9                   	leave  
  800ade:	c3                   	ret    

00800adf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800adf:	55                   	push   %ebp
  800ae0:	89 e5                	mov    %esp,%ebp
  800ae2:	83 ec 04             	sub    $0x4,%esp
  800ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aeb:	eb 0d                	jmp    800afa <strfind+0x1b>
		if (*s == c)
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8a 00                	mov    (%eax),%al
  800af2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800af5:	74 0e                	je     800b05 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800af7:	ff 45 08             	incl   0x8(%ebp)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	84 c0                	test   %al,%al
  800b01:	75 ea                	jne    800aed <strfind+0xe>
  800b03:	eb 01                	jmp    800b06 <strfind+0x27>
		if (*s == c)
			break;
  800b05:	90                   	nop
	return (char *) s;
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b09:	c9                   	leave  
  800b0a:	c3                   	ret    

00800b0b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
  800b0e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b17:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b1d:	eb 0e                	jmp    800b2d <memset+0x22>
		*p++ = c;
  800b1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b22:	8d 50 01             	lea    0x1(%eax),%edx
  800b25:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b2d:	ff 4d f8             	decl   -0x8(%ebp)
  800b30:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b34:	79 e9                	jns    800b1f <memset+0x14>
		*p++ = c;

	return v;
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b39:	c9                   	leave  
  800b3a:	c3                   	ret    

00800b3b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b3b:	55                   	push   %ebp
  800b3c:	89 e5                	mov    %esp,%ebp
  800b3e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b4d:	eb 16                	jmp    800b65 <memcpy+0x2a>
		*d++ = *s++;
  800b4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b52:	8d 50 01             	lea    0x1(%eax),%edx
  800b55:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b58:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b5b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b5e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b61:	8a 12                	mov    (%edx),%dl
  800b63:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b65:	8b 45 10             	mov    0x10(%ebp),%eax
  800b68:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b6b:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6e:	85 c0                	test   %eax,%eax
  800b70:	75 dd                	jne    800b4f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b75:	c9                   	leave  
  800b76:	c3                   	ret    

00800b77 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b77:	55                   	push   %ebp
  800b78:	89 e5                	mov    %esp,%ebp
  800b7a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b8c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b8f:	73 50                	jae    800be1 <memmove+0x6a>
  800b91:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b94:	8b 45 10             	mov    0x10(%ebp),%eax
  800b97:	01 d0                	add    %edx,%eax
  800b99:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b9c:	76 43                	jbe    800be1 <memmove+0x6a>
		s += n;
  800b9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ba4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800baa:	eb 10                	jmp    800bbc <memmove+0x45>
			*--d = *--s;
  800bac:	ff 4d f8             	decl   -0x8(%ebp)
  800baf:	ff 4d fc             	decl   -0x4(%ebp)
  800bb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb5:	8a 10                	mov    (%eax),%dl
  800bb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bba:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc5:	85 c0                	test   %eax,%eax
  800bc7:	75 e3                	jne    800bac <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bc9:	eb 23                	jmp    800bee <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bce:	8d 50 01             	lea    0x1(%eax),%edx
  800bd1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bd4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bd7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bda:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bdd:	8a 12                	mov    (%edx),%dl
  800bdf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800be1:	8b 45 10             	mov    0x10(%ebp),%eax
  800be4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bea:	85 c0                	test   %eax,%eax
  800bec:	75 dd                	jne    800bcb <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
  800bf6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c02:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c05:	eb 2a                	jmp    800c31 <memcmp+0x3e>
		if (*s1 != *s2)
  800c07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0a:	8a 10                	mov    (%eax),%dl
  800c0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0f:	8a 00                	mov    (%eax),%al
  800c11:	38 c2                	cmp    %al,%dl
  800c13:	74 16                	je     800c2b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c15:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	0f b6 d0             	movzbl %al,%edx
  800c1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	0f b6 c0             	movzbl %al,%eax
  800c25:	29 c2                	sub    %eax,%edx
  800c27:	89 d0                	mov    %edx,%eax
  800c29:	eb 18                	jmp    800c43 <memcmp+0x50>
		s1++, s2++;
  800c2b:	ff 45 fc             	incl   -0x4(%ebp)
  800c2e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c31:	8b 45 10             	mov    0x10(%ebp),%eax
  800c34:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c37:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3a:	85 c0                	test   %eax,%eax
  800c3c:	75 c9                	jne    800c07 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c3e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800c4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c51:	01 d0                	add    %edx,%eax
  800c53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c56:	eb 15                	jmp    800c6d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	8a 00                	mov    (%eax),%al
  800c5d:	0f b6 d0             	movzbl %al,%edx
  800c60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c63:	0f b6 c0             	movzbl %al,%eax
  800c66:	39 c2                	cmp    %eax,%edx
  800c68:	74 0d                	je     800c77 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c6a:	ff 45 08             	incl   0x8(%ebp)
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c73:	72 e3                	jb     800c58 <memfind+0x13>
  800c75:	eb 01                	jmp    800c78 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c77:	90                   	nop
	return (void *) s;
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c7b:	c9                   	leave  
  800c7c:	c3                   	ret    

00800c7d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c7d:	55                   	push   %ebp
  800c7e:	89 e5                	mov    %esp,%ebp
  800c80:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c91:	eb 03                	jmp    800c96 <strtol+0x19>
		s++;
  800c93:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	3c 20                	cmp    $0x20,%al
  800c9d:	74 f4                	je     800c93 <strtol+0x16>
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	3c 09                	cmp    $0x9,%al
  800ca6:	74 eb                	je     800c93 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8a 00                	mov    (%eax),%al
  800cad:	3c 2b                	cmp    $0x2b,%al
  800caf:	75 05                	jne    800cb6 <strtol+0x39>
		s++;
  800cb1:	ff 45 08             	incl   0x8(%ebp)
  800cb4:	eb 13                	jmp    800cc9 <strtol+0x4c>
	else if (*s == '-')
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3c 2d                	cmp    $0x2d,%al
  800cbd:	75 0a                	jne    800cc9 <strtol+0x4c>
		s++, neg = 1;
  800cbf:	ff 45 08             	incl   0x8(%ebp)
  800cc2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccd:	74 06                	je     800cd5 <strtol+0x58>
  800ccf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cd3:	75 20                	jne    800cf5 <strtol+0x78>
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	3c 30                	cmp    $0x30,%al
  800cdc:	75 17                	jne    800cf5 <strtol+0x78>
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	40                   	inc    %eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	3c 78                	cmp    $0x78,%al
  800ce6:	75 0d                	jne    800cf5 <strtol+0x78>
		s += 2, base = 16;
  800ce8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cec:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cf3:	eb 28                	jmp    800d1d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cf5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf9:	75 15                	jne    800d10 <strtol+0x93>
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	3c 30                	cmp    $0x30,%al
  800d02:	75 0c                	jne    800d10 <strtol+0x93>
		s++, base = 8;
  800d04:	ff 45 08             	incl   0x8(%ebp)
  800d07:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d0e:	eb 0d                	jmp    800d1d <strtol+0xa0>
	else if (base == 0)
  800d10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d14:	75 07                	jne    800d1d <strtol+0xa0>
		base = 10;
  800d16:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	3c 2f                	cmp    $0x2f,%al
  800d24:	7e 19                	jle    800d3f <strtol+0xc2>
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 39                	cmp    $0x39,%al
  800d2d:	7f 10                	jg     800d3f <strtol+0xc2>
			dig = *s - '0';
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	0f be c0             	movsbl %al,%eax
  800d37:	83 e8 30             	sub    $0x30,%eax
  800d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d3d:	eb 42                	jmp    800d81 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	3c 60                	cmp    $0x60,%al
  800d46:	7e 19                	jle    800d61 <strtol+0xe4>
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	3c 7a                	cmp    $0x7a,%al
  800d4f:	7f 10                	jg     800d61 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	0f be c0             	movsbl %al,%eax
  800d59:	83 e8 57             	sub    $0x57,%eax
  800d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d5f:	eb 20                	jmp    800d81 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	3c 40                	cmp    $0x40,%al
  800d68:	7e 39                	jle    800da3 <strtol+0x126>
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	3c 5a                	cmp    $0x5a,%al
  800d71:	7f 30                	jg     800da3 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	0f be c0             	movsbl %al,%eax
  800d7b:	83 e8 37             	sub    $0x37,%eax
  800d7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d84:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d87:	7d 19                	jge    800da2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d89:	ff 45 08             	incl   0x8(%ebp)
  800d8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8f:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d93:	89 c2                	mov    %eax,%edx
  800d95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d98:	01 d0                	add    %edx,%eax
  800d9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d9d:	e9 7b ff ff ff       	jmp    800d1d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800da2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800da3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da7:	74 08                	je     800db1 <strtol+0x134>
		*endptr = (char *) s;
  800da9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dac:	8b 55 08             	mov    0x8(%ebp),%edx
  800daf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800db1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800db5:	74 07                	je     800dbe <strtol+0x141>
  800db7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dba:	f7 d8                	neg    %eax
  800dbc:	eb 03                	jmp    800dc1 <strtol+0x144>
  800dbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dc1:	c9                   	leave  
  800dc2:	c3                   	ret    

00800dc3 <ltostr>:

void
ltostr(long value, char *str)
{
  800dc3:	55                   	push   %ebp
  800dc4:	89 e5                	mov    %esp,%ebp
  800dc6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dc9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dd0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dd7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ddb:	79 13                	jns    800df0 <ltostr+0x2d>
	{
		neg = 1;
  800ddd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800de4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dea:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ded:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800df8:	99                   	cltd   
  800df9:	f7 f9                	idiv   %ecx
  800dfb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dfe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e01:	8d 50 01             	lea    0x1(%eax),%edx
  800e04:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e07:	89 c2                	mov    %eax,%edx
  800e09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0c:	01 d0                	add    %edx,%eax
  800e0e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e11:	83 c2 30             	add    $0x30,%edx
  800e14:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e16:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e19:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e1e:	f7 e9                	imul   %ecx
  800e20:	c1 fa 02             	sar    $0x2,%edx
  800e23:	89 c8                	mov    %ecx,%eax
  800e25:	c1 f8 1f             	sar    $0x1f,%eax
  800e28:	29 c2                	sub    %eax,%edx
  800e2a:	89 d0                	mov    %edx,%eax
  800e2c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e32:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e37:	f7 e9                	imul   %ecx
  800e39:	c1 fa 02             	sar    $0x2,%edx
  800e3c:	89 c8                	mov    %ecx,%eax
  800e3e:	c1 f8 1f             	sar    $0x1f,%eax
  800e41:	29 c2                	sub    %eax,%edx
  800e43:	89 d0                	mov    %edx,%eax
  800e45:	c1 e0 02             	shl    $0x2,%eax
  800e48:	01 d0                	add    %edx,%eax
  800e4a:	01 c0                	add    %eax,%eax
  800e4c:	29 c1                	sub    %eax,%ecx
  800e4e:	89 ca                	mov    %ecx,%edx
  800e50:	85 d2                	test   %edx,%edx
  800e52:	75 9c                	jne    800df0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5e:	48                   	dec    %eax
  800e5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e62:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e66:	74 3d                	je     800ea5 <ltostr+0xe2>
		start = 1 ;
  800e68:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e6f:	eb 34                	jmp    800ea5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	01 d0                	add    %edx,%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e84:	01 c2                	add    %eax,%edx
  800e86:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	01 c8                	add    %ecx,%eax
  800e8e:	8a 00                	mov    (%eax),%al
  800e90:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e92:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	01 c2                	add    %eax,%edx
  800e9a:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e9d:	88 02                	mov    %al,(%edx)
		start++ ;
  800e9f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ea2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ea8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eab:	7c c4                	jl     800e71 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ead:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb3:	01 d0                	add    %edx,%eax
  800eb5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eb8:	90                   	nop
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ec1:	ff 75 08             	pushl  0x8(%ebp)
  800ec4:	e8 54 fa ff ff       	call   80091d <strlen>
  800ec9:	83 c4 04             	add    $0x4,%esp
  800ecc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ecf:	ff 75 0c             	pushl  0xc(%ebp)
  800ed2:	e8 46 fa ff ff       	call   80091d <strlen>
  800ed7:	83 c4 04             	add    $0x4,%esp
  800eda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800edd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ee4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eeb:	eb 17                	jmp    800f04 <strcconcat+0x49>
		final[s] = str1[s] ;
  800eed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef3:	01 c2                	add    %eax,%edx
  800ef5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	01 c8                	add    %ecx,%eax
  800efd:	8a 00                	mov    (%eax),%al
  800eff:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f01:	ff 45 fc             	incl   -0x4(%ebp)
  800f04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f07:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f0a:	7c e1                	jl     800eed <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f0c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f1a:	eb 1f                	jmp    800f3b <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1f:	8d 50 01             	lea    0x1(%eax),%edx
  800f22:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f25:	89 c2                	mov    %eax,%edx
  800f27:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2a:	01 c2                	add    %eax,%edx
  800f2c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f32:	01 c8                	add    %ecx,%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f38:	ff 45 f8             	incl   -0x8(%ebp)
  800f3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f41:	7c d9                	jl     800f1c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f46:	8b 45 10             	mov    0x10(%ebp),%eax
  800f49:	01 d0                	add    %edx,%eax
  800f4b:	c6 00 00             	movb   $0x0,(%eax)
}
  800f4e:	90                   	nop
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f54:	8b 45 14             	mov    0x14(%ebp),%eax
  800f57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f60:	8b 00                	mov    (%eax),%eax
  800f62:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f69:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6c:	01 d0                	add    %edx,%eax
  800f6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f74:	eb 0c                	jmp    800f82 <strsplit+0x31>
			*string++ = 0;
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8d 50 01             	lea    0x1(%eax),%edx
  800f7c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f7f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	84 c0                	test   %al,%al
  800f89:	74 18                	je     800fa3 <strsplit+0x52>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	0f be c0             	movsbl %al,%eax
  800f93:	50                   	push   %eax
  800f94:	ff 75 0c             	pushl  0xc(%ebp)
  800f97:	e8 13 fb ff ff       	call   800aaf <strchr>
  800f9c:	83 c4 08             	add    $0x8,%esp
  800f9f:	85 c0                	test   %eax,%eax
  800fa1:	75 d3                	jne    800f76 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	84 c0                	test   %al,%al
  800faa:	74 5a                	je     801006 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800fac:	8b 45 14             	mov    0x14(%ebp),%eax
  800faf:	8b 00                	mov    (%eax),%eax
  800fb1:	83 f8 0f             	cmp    $0xf,%eax
  800fb4:	75 07                	jne    800fbd <strsplit+0x6c>
		{
			return 0;
  800fb6:	b8 00 00 00 00       	mov    $0x0,%eax
  800fbb:	eb 66                	jmp    801023 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc0:	8b 00                	mov    (%eax),%eax
  800fc2:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc5:	8b 55 14             	mov    0x14(%ebp),%edx
  800fc8:	89 0a                	mov    %ecx,(%edx)
  800fca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd4:	01 c2                	add    %eax,%edx
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fdb:	eb 03                	jmp    800fe0 <strsplit+0x8f>
			string++;
  800fdd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	84 c0                	test   %al,%al
  800fe7:	74 8b                	je     800f74 <strsplit+0x23>
  800fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fec:	8a 00                	mov    (%eax),%al
  800fee:	0f be c0             	movsbl %al,%eax
  800ff1:	50                   	push   %eax
  800ff2:	ff 75 0c             	pushl  0xc(%ebp)
  800ff5:	e8 b5 fa ff ff       	call   800aaf <strchr>
  800ffa:	83 c4 08             	add    $0x8,%esp
  800ffd:	85 c0                	test   %eax,%eax
  800fff:	74 dc                	je     800fdd <strsplit+0x8c>
			string++;
	}
  801001:	e9 6e ff ff ff       	jmp    800f74 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801006:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801007:	8b 45 14             	mov    0x14(%ebp),%eax
  80100a:	8b 00                	mov    (%eax),%eax
  80100c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80101e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801023:	c9                   	leave  
  801024:	c3                   	ret    

00801025 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801025:	55                   	push   %ebp
  801026:	89 e5                	mov    %esp,%ebp
  801028:	57                   	push   %edi
  801029:	56                   	push   %esi
  80102a:	53                   	push   %ebx
  80102b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8b 55 0c             	mov    0xc(%ebp),%edx
  801034:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801037:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80103a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80103d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801040:	cd 30                	int    $0x30
  801042:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801045:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801048:	83 c4 10             	add    $0x10,%esp
  80104b:	5b                   	pop    %ebx
  80104c:	5e                   	pop    %esi
  80104d:	5f                   	pop    %edi
  80104e:	5d                   	pop    %ebp
  80104f:	c3                   	ret    

00801050 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801050:	55                   	push   %ebp
  801051:	89 e5                	mov    %esp,%ebp
  801053:	83 ec 04             	sub    $0x4,%esp
  801056:	8b 45 10             	mov    0x10(%ebp),%eax
  801059:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80105c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	6a 00                	push   $0x0
  801065:	6a 00                	push   $0x0
  801067:	52                   	push   %edx
  801068:	ff 75 0c             	pushl  0xc(%ebp)
  80106b:	50                   	push   %eax
  80106c:	6a 00                	push   $0x0
  80106e:	e8 b2 ff ff ff       	call   801025 <syscall>
  801073:	83 c4 18             	add    $0x18,%esp
}
  801076:	90                   	nop
  801077:	c9                   	leave  
  801078:	c3                   	ret    

00801079 <sys_cgetc>:

int
sys_cgetc(void)
{
  801079:	55                   	push   %ebp
  80107a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80107c:	6a 00                	push   $0x0
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	6a 00                	push   $0x0
  801086:	6a 01                	push   $0x1
  801088:	e8 98 ff ff ff       	call   801025 <syscall>
  80108d:	83 c4 18             	add    $0x18,%esp
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 00                	push   $0x0
  8010a0:	50                   	push   %eax
  8010a1:	6a 05                	push   $0x5
  8010a3:	e8 7d ff ff ff       	call   801025 <syscall>
  8010a8:	83 c4 18             	add    $0x18,%esp
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 02                	push   $0x2
  8010bc:	e8 64 ff ff ff       	call   801025 <syscall>
  8010c1:	83 c4 18             	add    $0x18,%esp
}
  8010c4:	c9                   	leave  
  8010c5:	c3                   	ret    

008010c6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010c6:	55                   	push   %ebp
  8010c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 00                	push   $0x0
  8010d3:	6a 03                	push   $0x3
  8010d5:	e8 4b ff ff ff       	call   801025 <syscall>
  8010da:	83 c4 18             	add    $0x18,%esp
}
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 04                	push   $0x4
  8010ee:	e8 32 ff ff ff       	call   801025 <syscall>
  8010f3:	83 c4 18             	add    $0x18,%esp
}
  8010f6:	c9                   	leave  
  8010f7:	c3                   	ret    

008010f8 <sys_env_exit>:


void sys_env_exit(void)
{
  8010f8:	55                   	push   %ebp
  8010f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	6a 06                	push   $0x6
  801107:	e8 19 ff ff ff       	call   801025 <syscall>
  80110c:	83 c4 18             	add    $0x18,%esp
}
  80110f:	90                   	nop
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801115:	8b 55 0c             	mov    0xc(%ebp),%edx
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	6a 00                	push   $0x0
  801121:	52                   	push   %edx
  801122:	50                   	push   %eax
  801123:	6a 07                	push   $0x7
  801125:	e8 fb fe ff ff       	call   801025 <syscall>
  80112a:	83 c4 18             	add    $0x18,%esp
}
  80112d:	c9                   	leave  
  80112e:	c3                   	ret    

0080112f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80112f:	55                   	push   %ebp
  801130:	89 e5                	mov    %esp,%ebp
  801132:	56                   	push   %esi
  801133:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801134:	8b 75 18             	mov    0x18(%ebp),%esi
  801137:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80113a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80113d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	56                   	push   %esi
  801144:	53                   	push   %ebx
  801145:	51                   	push   %ecx
  801146:	52                   	push   %edx
  801147:	50                   	push   %eax
  801148:	6a 08                	push   $0x8
  80114a:	e8 d6 fe ff ff       	call   801025 <syscall>
  80114f:	83 c4 18             	add    $0x18,%esp
}
  801152:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801155:	5b                   	pop    %ebx
  801156:	5e                   	pop    %esi
  801157:	5d                   	pop    %ebp
  801158:	c3                   	ret    

00801159 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80115c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	52                   	push   %edx
  801169:	50                   	push   %eax
  80116a:	6a 09                	push   $0x9
  80116c:	e8 b4 fe ff ff       	call   801025 <syscall>
  801171:	83 c4 18             	add    $0x18,%esp
}
  801174:	c9                   	leave  
  801175:	c3                   	ret    

00801176 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801176:	55                   	push   %ebp
  801177:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	ff 75 0c             	pushl  0xc(%ebp)
  801182:	ff 75 08             	pushl  0x8(%ebp)
  801185:	6a 0a                	push   $0xa
  801187:	e8 99 fe ff ff       	call   801025 <syscall>
  80118c:	83 c4 18             	add    $0x18,%esp
}
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 0b                	push   $0xb
  8011a0:	e8 80 fe ff ff       	call   801025 <syscall>
  8011a5:	83 c4 18             	add    $0x18,%esp
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 0c                	push   $0xc
  8011b9:	e8 67 fe ff ff       	call   801025 <syscall>
  8011be:	83 c4 18             	add    $0x18,%esp
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 0d                	push   $0xd
  8011d2:	e8 4e fe ff ff       	call   801025 <syscall>
  8011d7:	83 c4 18             	add    $0x18,%esp
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	ff 75 0c             	pushl  0xc(%ebp)
  8011e8:	ff 75 08             	pushl  0x8(%ebp)
  8011eb:	6a 11                	push   $0x11
  8011ed:	e8 33 fe ff ff       	call   801025 <syscall>
  8011f2:	83 c4 18             	add    $0x18,%esp
	return;
  8011f5:	90                   	nop
}
  8011f6:	c9                   	leave  
  8011f7:	c3                   	ret    

008011f8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	ff 75 08             	pushl  0x8(%ebp)
  801207:	6a 12                	push   $0x12
  801209:	e8 17 fe ff ff       	call   801025 <syscall>
  80120e:	83 c4 18             	add    $0x18,%esp
	return ;
  801211:	90                   	nop
}
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 0e                	push   $0xe
  801223:	e8 fd fd ff ff       	call   801025 <syscall>
  801228:	83 c4 18             	add    $0x18,%esp
}
  80122b:	c9                   	leave  
  80122c:	c3                   	ret    

0080122d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80122d:	55                   	push   %ebp
  80122e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	ff 75 08             	pushl  0x8(%ebp)
  80123b:	6a 0f                	push   $0xf
  80123d:	e8 e3 fd ff ff       	call   801025 <syscall>
  801242:	83 c4 18             	add    $0x18,%esp
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 10                	push   $0x10
  801256:	e8 ca fd ff ff       	call   801025 <syscall>
  80125b:	83 c4 18             	add    $0x18,%esp
}
  80125e:	90                   	nop
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 14                	push   $0x14
  801270:	e8 b0 fd ff ff       	call   801025 <syscall>
  801275:	83 c4 18             	add    $0x18,%esp
}
  801278:	90                   	nop
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 15                	push   $0x15
  80128a:	e8 96 fd ff ff       	call   801025 <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	90                   	nop
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <sys_cputc>:


void
sys_cputc(const char c)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
  801298:	83 ec 04             	sub    $0x4,%esp
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	50                   	push   %eax
  8012ae:	6a 16                	push   $0x16
  8012b0:	e8 70 fd ff ff       	call   801025 <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	90                   	nop
  8012b9:	c9                   	leave  
  8012ba:	c3                   	ret    

008012bb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 17                	push   $0x17
  8012ca:	e8 56 fd ff ff       	call   801025 <syscall>
  8012cf:	83 c4 18             	add    $0x18,%esp
}
  8012d2:	90                   	nop
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	ff 75 0c             	pushl  0xc(%ebp)
  8012e4:	50                   	push   %eax
  8012e5:	6a 18                	push   $0x18
  8012e7:	e8 39 fd ff ff       	call   801025 <syscall>
  8012ec:	83 c4 18             	add    $0x18,%esp
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	52                   	push   %edx
  801301:	50                   	push   %eax
  801302:	6a 1b                	push   $0x1b
  801304:	e8 1c fd ff ff       	call   801025 <syscall>
  801309:	83 c4 18             	add    $0x18,%esp
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801311:	8b 55 0c             	mov    0xc(%ebp),%edx
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	52                   	push   %edx
  80131e:	50                   	push   %eax
  80131f:	6a 19                	push   $0x19
  801321:	e8 ff fc ff ff       	call   801025 <syscall>
  801326:	83 c4 18             	add    $0x18,%esp
}
  801329:	90                   	nop
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80132f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	52                   	push   %edx
  80133c:	50                   	push   %eax
  80133d:	6a 1a                	push   $0x1a
  80133f:	e8 e1 fc ff ff       	call   801025 <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	90                   	nop
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
  80134d:	83 ec 04             	sub    $0x4,%esp
  801350:	8b 45 10             	mov    0x10(%ebp),%eax
  801353:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801356:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801359:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	6a 00                	push   $0x0
  801362:	51                   	push   %ecx
  801363:	52                   	push   %edx
  801364:	ff 75 0c             	pushl  0xc(%ebp)
  801367:	50                   	push   %eax
  801368:	6a 1c                	push   $0x1c
  80136a:	e8 b6 fc ff ff       	call   801025 <syscall>
  80136f:	83 c4 18             	add    $0x18,%esp
}
  801372:	c9                   	leave  
  801373:	c3                   	ret    

00801374 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801374:	55                   	push   %ebp
  801375:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801377:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	52                   	push   %edx
  801384:	50                   	push   %eax
  801385:	6a 1d                	push   $0x1d
  801387:	e8 99 fc ff ff       	call   801025 <syscall>
  80138c:	83 c4 18             	add    $0x18,%esp
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801394:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801397:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	51                   	push   %ecx
  8013a2:	52                   	push   %edx
  8013a3:	50                   	push   %eax
  8013a4:	6a 1e                	push   $0x1e
  8013a6:	e8 7a fc ff ff       	call   801025 <syscall>
  8013ab:	83 c4 18             	add    $0x18,%esp
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	52                   	push   %edx
  8013c0:	50                   	push   %eax
  8013c1:	6a 1f                	push   $0x1f
  8013c3:	e8 5d fc ff ff       	call   801025 <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 20                	push   $0x20
  8013dc:	e8 44 fc ff ff       	call   801025 <syscall>
  8013e1:	83 c4 18             	add    $0x18,%esp
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	ff 75 10             	pushl  0x10(%ebp)
  8013f3:	ff 75 0c             	pushl  0xc(%ebp)
  8013f6:	50                   	push   %eax
  8013f7:	6a 21                	push   $0x21
  8013f9:	e8 27 fc ff ff       	call   801025 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	50                   	push   %eax
  801412:	6a 22                	push   $0x22
  801414:	e8 0c fc ff ff       	call   801025 <syscall>
  801419:	83 c4 18             	add    $0x18,%esp
}
  80141c:	90                   	nop
  80141d:	c9                   	leave  
  80141e:	c3                   	ret    

0080141f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80141f:	55                   	push   %ebp
  801420:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	50                   	push   %eax
  80142e:	6a 23                	push   $0x23
  801430:	e8 f0 fb ff ff       	call   801025 <syscall>
  801435:	83 c4 18             	add    $0x18,%esp
}
  801438:	90                   	nop
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
  80143e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801441:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801444:	8d 50 04             	lea    0x4(%eax),%edx
  801447:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	52                   	push   %edx
  801451:	50                   	push   %eax
  801452:	6a 24                	push   $0x24
  801454:	e8 cc fb ff ff       	call   801025 <syscall>
  801459:	83 c4 18             	add    $0x18,%esp
	return result;
  80145c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80145f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801462:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801465:	89 01                	mov    %eax,(%ecx)
  801467:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	c9                   	leave  
  80146e:	c2 04 00             	ret    $0x4

00801471 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801471:	55                   	push   %ebp
  801472:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	ff 75 10             	pushl  0x10(%ebp)
  80147b:	ff 75 0c             	pushl  0xc(%ebp)
  80147e:	ff 75 08             	pushl  0x8(%ebp)
  801481:	6a 13                	push   $0x13
  801483:	e8 9d fb ff ff       	call   801025 <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
	return ;
  80148b:	90                   	nop
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_rcr2>:
uint32 sys_rcr2()
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 25                	push   $0x25
  80149d:	e8 83 fb ff ff       	call   801025 <syscall>
  8014a2:	83 c4 18             	add    $0x18,%esp
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
  8014aa:	83 ec 04             	sub    $0x4,%esp
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014b3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	50                   	push   %eax
  8014c0:	6a 26                	push   $0x26
  8014c2:	e8 5e fb ff ff       	call   801025 <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ca:	90                   	nop
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <rsttst>:
void rsttst()
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 28                	push   $0x28
  8014dc:	e8 44 fb ff ff       	call   801025 <syscall>
  8014e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e4:	90                   	nop
}
  8014e5:	c9                   	leave  
  8014e6:	c3                   	ret    

008014e7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014e7:	55                   	push   %ebp
  8014e8:	89 e5                	mov    %esp,%ebp
  8014ea:	83 ec 04             	sub    $0x4,%esp
  8014ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014f3:	8b 55 18             	mov    0x18(%ebp),%edx
  8014f6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014fa:	52                   	push   %edx
  8014fb:	50                   	push   %eax
  8014fc:	ff 75 10             	pushl  0x10(%ebp)
  8014ff:	ff 75 0c             	pushl  0xc(%ebp)
  801502:	ff 75 08             	pushl  0x8(%ebp)
  801505:	6a 27                	push   $0x27
  801507:	e8 19 fb ff ff       	call   801025 <syscall>
  80150c:	83 c4 18             	add    $0x18,%esp
	return ;
  80150f:	90                   	nop
}
  801510:	c9                   	leave  
  801511:	c3                   	ret    

00801512 <chktst>:
void chktst(uint32 n)
{
  801512:	55                   	push   %ebp
  801513:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	ff 75 08             	pushl  0x8(%ebp)
  801520:	6a 29                	push   $0x29
  801522:	e8 fe fa ff ff       	call   801025 <syscall>
  801527:	83 c4 18             	add    $0x18,%esp
	return ;
  80152a:	90                   	nop
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <inctst>:

void inctst()
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 2a                	push   $0x2a
  80153c:	e8 e4 fa ff ff       	call   801025 <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
	return ;
  801544:	90                   	nop
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <gettst>:
uint32 gettst()
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 2b                	push   $0x2b
  801556:	e8 ca fa ff ff       	call   801025 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
  801563:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 2c                	push   $0x2c
  801572:	e8 ae fa ff ff       	call   801025 <syscall>
  801577:	83 c4 18             	add    $0x18,%esp
  80157a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80157d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801581:	75 07                	jne    80158a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801583:	b8 01 00 00 00       	mov    $0x1,%eax
  801588:	eb 05                	jmp    80158f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80158a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
  801594:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 2c                	push   $0x2c
  8015a3:	e8 7d fa ff ff       	call   801025 <syscall>
  8015a8:	83 c4 18             	add    $0x18,%esp
  8015ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015ae:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015b2:	75 07                	jne    8015bb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015b4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b9:	eb 05                	jmp    8015c0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
  8015c5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 2c                	push   $0x2c
  8015d4:	e8 4c fa ff ff       	call   801025 <syscall>
  8015d9:	83 c4 18             	add    $0x18,%esp
  8015dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015df:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015e3:	75 07                	jne    8015ec <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ea:	eb 05                	jmp    8015f1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 2c                	push   $0x2c
  801605:	e8 1b fa ff ff       	call   801025 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
  80160d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801610:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801614:	75 07                	jne    80161d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801616:	b8 01 00 00 00       	mov    $0x1,%eax
  80161b:	eb 05                	jmp    801622 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80161d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	ff 75 08             	pushl  0x8(%ebp)
  801632:	6a 2d                	push   $0x2d
  801634:	e8 ec f9 ff ff       	call   801025 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
	return ;
  80163c:	90                   	nop
}
  80163d:	c9                   	leave  
  80163e:	c3                   	ret    
  80163f:	90                   	nop

00801640 <__udivdi3>:
  801640:	55                   	push   %ebp
  801641:	57                   	push   %edi
  801642:	56                   	push   %esi
  801643:	53                   	push   %ebx
  801644:	83 ec 1c             	sub    $0x1c,%esp
  801647:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80164b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80164f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801653:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801657:	89 ca                	mov    %ecx,%edx
  801659:	89 f8                	mov    %edi,%eax
  80165b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80165f:	85 f6                	test   %esi,%esi
  801661:	75 2d                	jne    801690 <__udivdi3+0x50>
  801663:	39 cf                	cmp    %ecx,%edi
  801665:	77 65                	ja     8016cc <__udivdi3+0x8c>
  801667:	89 fd                	mov    %edi,%ebp
  801669:	85 ff                	test   %edi,%edi
  80166b:	75 0b                	jne    801678 <__udivdi3+0x38>
  80166d:	b8 01 00 00 00       	mov    $0x1,%eax
  801672:	31 d2                	xor    %edx,%edx
  801674:	f7 f7                	div    %edi
  801676:	89 c5                	mov    %eax,%ebp
  801678:	31 d2                	xor    %edx,%edx
  80167a:	89 c8                	mov    %ecx,%eax
  80167c:	f7 f5                	div    %ebp
  80167e:	89 c1                	mov    %eax,%ecx
  801680:	89 d8                	mov    %ebx,%eax
  801682:	f7 f5                	div    %ebp
  801684:	89 cf                	mov    %ecx,%edi
  801686:	89 fa                	mov    %edi,%edx
  801688:	83 c4 1c             	add    $0x1c,%esp
  80168b:	5b                   	pop    %ebx
  80168c:	5e                   	pop    %esi
  80168d:	5f                   	pop    %edi
  80168e:	5d                   	pop    %ebp
  80168f:	c3                   	ret    
  801690:	39 ce                	cmp    %ecx,%esi
  801692:	77 28                	ja     8016bc <__udivdi3+0x7c>
  801694:	0f bd fe             	bsr    %esi,%edi
  801697:	83 f7 1f             	xor    $0x1f,%edi
  80169a:	75 40                	jne    8016dc <__udivdi3+0x9c>
  80169c:	39 ce                	cmp    %ecx,%esi
  80169e:	72 0a                	jb     8016aa <__udivdi3+0x6a>
  8016a0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016a4:	0f 87 9e 00 00 00    	ja     801748 <__udivdi3+0x108>
  8016aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8016af:	89 fa                	mov    %edi,%edx
  8016b1:	83 c4 1c             	add    $0x1c,%esp
  8016b4:	5b                   	pop    %ebx
  8016b5:	5e                   	pop    %esi
  8016b6:	5f                   	pop    %edi
  8016b7:	5d                   	pop    %ebp
  8016b8:	c3                   	ret    
  8016b9:	8d 76 00             	lea    0x0(%esi),%esi
  8016bc:	31 ff                	xor    %edi,%edi
  8016be:	31 c0                	xor    %eax,%eax
  8016c0:	89 fa                	mov    %edi,%edx
  8016c2:	83 c4 1c             	add    $0x1c,%esp
  8016c5:	5b                   	pop    %ebx
  8016c6:	5e                   	pop    %esi
  8016c7:	5f                   	pop    %edi
  8016c8:	5d                   	pop    %ebp
  8016c9:	c3                   	ret    
  8016ca:	66 90                	xchg   %ax,%ax
  8016cc:	89 d8                	mov    %ebx,%eax
  8016ce:	f7 f7                	div    %edi
  8016d0:	31 ff                	xor    %edi,%edi
  8016d2:	89 fa                	mov    %edi,%edx
  8016d4:	83 c4 1c             	add    $0x1c,%esp
  8016d7:	5b                   	pop    %ebx
  8016d8:	5e                   	pop    %esi
  8016d9:	5f                   	pop    %edi
  8016da:	5d                   	pop    %ebp
  8016db:	c3                   	ret    
  8016dc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016e1:	89 eb                	mov    %ebp,%ebx
  8016e3:	29 fb                	sub    %edi,%ebx
  8016e5:	89 f9                	mov    %edi,%ecx
  8016e7:	d3 e6                	shl    %cl,%esi
  8016e9:	89 c5                	mov    %eax,%ebp
  8016eb:	88 d9                	mov    %bl,%cl
  8016ed:	d3 ed                	shr    %cl,%ebp
  8016ef:	89 e9                	mov    %ebp,%ecx
  8016f1:	09 f1                	or     %esi,%ecx
  8016f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016f7:	89 f9                	mov    %edi,%ecx
  8016f9:	d3 e0                	shl    %cl,%eax
  8016fb:	89 c5                	mov    %eax,%ebp
  8016fd:	89 d6                	mov    %edx,%esi
  8016ff:	88 d9                	mov    %bl,%cl
  801701:	d3 ee                	shr    %cl,%esi
  801703:	89 f9                	mov    %edi,%ecx
  801705:	d3 e2                	shl    %cl,%edx
  801707:	8b 44 24 08          	mov    0x8(%esp),%eax
  80170b:	88 d9                	mov    %bl,%cl
  80170d:	d3 e8                	shr    %cl,%eax
  80170f:	09 c2                	or     %eax,%edx
  801711:	89 d0                	mov    %edx,%eax
  801713:	89 f2                	mov    %esi,%edx
  801715:	f7 74 24 0c          	divl   0xc(%esp)
  801719:	89 d6                	mov    %edx,%esi
  80171b:	89 c3                	mov    %eax,%ebx
  80171d:	f7 e5                	mul    %ebp
  80171f:	39 d6                	cmp    %edx,%esi
  801721:	72 19                	jb     80173c <__udivdi3+0xfc>
  801723:	74 0b                	je     801730 <__udivdi3+0xf0>
  801725:	89 d8                	mov    %ebx,%eax
  801727:	31 ff                	xor    %edi,%edi
  801729:	e9 58 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  80172e:	66 90                	xchg   %ax,%ax
  801730:	8b 54 24 08          	mov    0x8(%esp),%edx
  801734:	89 f9                	mov    %edi,%ecx
  801736:	d3 e2                	shl    %cl,%edx
  801738:	39 c2                	cmp    %eax,%edx
  80173a:	73 e9                	jae    801725 <__udivdi3+0xe5>
  80173c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80173f:	31 ff                	xor    %edi,%edi
  801741:	e9 40 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  801746:	66 90                	xchg   %ax,%ax
  801748:	31 c0                	xor    %eax,%eax
  80174a:	e9 37 ff ff ff       	jmp    801686 <__udivdi3+0x46>
  80174f:	90                   	nop

00801750 <__umoddi3>:
  801750:	55                   	push   %ebp
  801751:	57                   	push   %edi
  801752:	56                   	push   %esi
  801753:	53                   	push   %ebx
  801754:	83 ec 1c             	sub    $0x1c,%esp
  801757:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80175b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80175f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801763:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801767:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80176b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80176f:	89 f3                	mov    %esi,%ebx
  801771:	89 fa                	mov    %edi,%edx
  801773:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801777:	89 34 24             	mov    %esi,(%esp)
  80177a:	85 c0                	test   %eax,%eax
  80177c:	75 1a                	jne    801798 <__umoddi3+0x48>
  80177e:	39 f7                	cmp    %esi,%edi
  801780:	0f 86 a2 00 00 00    	jbe    801828 <__umoddi3+0xd8>
  801786:	89 c8                	mov    %ecx,%eax
  801788:	89 f2                	mov    %esi,%edx
  80178a:	f7 f7                	div    %edi
  80178c:	89 d0                	mov    %edx,%eax
  80178e:	31 d2                	xor    %edx,%edx
  801790:	83 c4 1c             	add    $0x1c,%esp
  801793:	5b                   	pop    %ebx
  801794:	5e                   	pop    %esi
  801795:	5f                   	pop    %edi
  801796:	5d                   	pop    %ebp
  801797:	c3                   	ret    
  801798:	39 f0                	cmp    %esi,%eax
  80179a:	0f 87 ac 00 00 00    	ja     80184c <__umoddi3+0xfc>
  8017a0:	0f bd e8             	bsr    %eax,%ebp
  8017a3:	83 f5 1f             	xor    $0x1f,%ebp
  8017a6:	0f 84 ac 00 00 00    	je     801858 <__umoddi3+0x108>
  8017ac:	bf 20 00 00 00       	mov    $0x20,%edi
  8017b1:	29 ef                	sub    %ebp,%edi
  8017b3:	89 fe                	mov    %edi,%esi
  8017b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017b9:	89 e9                	mov    %ebp,%ecx
  8017bb:	d3 e0                	shl    %cl,%eax
  8017bd:	89 d7                	mov    %edx,%edi
  8017bf:	89 f1                	mov    %esi,%ecx
  8017c1:	d3 ef                	shr    %cl,%edi
  8017c3:	09 c7                	or     %eax,%edi
  8017c5:	89 e9                	mov    %ebp,%ecx
  8017c7:	d3 e2                	shl    %cl,%edx
  8017c9:	89 14 24             	mov    %edx,(%esp)
  8017cc:	89 d8                	mov    %ebx,%eax
  8017ce:	d3 e0                	shl    %cl,%eax
  8017d0:	89 c2                	mov    %eax,%edx
  8017d2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017d6:	d3 e0                	shl    %cl,%eax
  8017d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017dc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e0:	89 f1                	mov    %esi,%ecx
  8017e2:	d3 e8                	shr    %cl,%eax
  8017e4:	09 d0                	or     %edx,%eax
  8017e6:	d3 eb                	shr    %cl,%ebx
  8017e8:	89 da                	mov    %ebx,%edx
  8017ea:	f7 f7                	div    %edi
  8017ec:	89 d3                	mov    %edx,%ebx
  8017ee:	f7 24 24             	mull   (%esp)
  8017f1:	89 c6                	mov    %eax,%esi
  8017f3:	89 d1                	mov    %edx,%ecx
  8017f5:	39 d3                	cmp    %edx,%ebx
  8017f7:	0f 82 87 00 00 00    	jb     801884 <__umoddi3+0x134>
  8017fd:	0f 84 91 00 00 00    	je     801894 <__umoddi3+0x144>
  801803:	8b 54 24 04          	mov    0x4(%esp),%edx
  801807:	29 f2                	sub    %esi,%edx
  801809:	19 cb                	sbb    %ecx,%ebx
  80180b:	89 d8                	mov    %ebx,%eax
  80180d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801811:	d3 e0                	shl    %cl,%eax
  801813:	89 e9                	mov    %ebp,%ecx
  801815:	d3 ea                	shr    %cl,%edx
  801817:	09 d0                	or     %edx,%eax
  801819:	89 e9                	mov    %ebp,%ecx
  80181b:	d3 eb                	shr    %cl,%ebx
  80181d:	89 da                	mov    %ebx,%edx
  80181f:	83 c4 1c             	add    $0x1c,%esp
  801822:	5b                   	pop    %ebx
  801823:	5e                   	pop    %esi
  801824:	5f                   	pop    %edi
  801825:	5d                   	pop    %ebp
  801826:	c3                   	ret    
  801827:	90                   	nop
  801828:	89 fd                	mov    %edi,%ebp
  80182a:	85 ff                	test   %edi,%edi
  80182c:	75 0b                	jne    801839 <__umoddi3+0xe9>
  80182e:	b8 01 00 00 00       	mov    $0x1,%eax
  801833:	31 d2                	xor    %edx,%edx
  801835:	f7 f7                	div    %edi
  801837:	89 c5                	mov    %eax,%ebp
  801839:	89 f0                	mov    %esi,%eax
  80183b:	31 d2                	xor    %edx,%edx
  80183d:	f7 f5                	div    %ebp
  80183f:	89 c8                	mov    %ecx,%eax
  801841:	f7 f5                	div    %ebp
  801843:	89 d0                	mov    %edx,%eax
  801845:	e9 44 ff ff ff       	jmp    80178e <__umoddi3+0x3e>
  80184a:	66 90                	xchg   %ax,%ax
  80184c:	89 c8                	mov    %ecx,%eax
  80184e:	89 f2                	mov    %esi,%edx
  801850:	83 c4 1c             	add    $0x1c,%esp
  801853:	5b                   	pop    %ebx
  801854:	5e                   	pop    %esi
  801855:	5f                   	pop    %edi
  801856:	5d                   	pop    %ebp
  801857:	c3                   	ret    
  801858:	3b 04 24             	cmp    (%esp),%eax
  80185b:	72 06                	jb     801863 <__umoddi3+0x113>
  80185d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801861:	77 0f                	ja     801872 <__umoddi3+0x122>
  801863:	89 f2                	mov    %esi,%edx
  801865:	29 f9                	sub    %edi,%ecx
  801867:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80186b:	89 14 24             	mov    %edx,(%esp)
  80186e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801872:	8b 44 24 04          	mov    0x4(%esp),%eax
  801876:	8b 14 24             	mov    (%esp),%edx
  801879:	83 c4 1c             	add    $0x1c,%esp
  80187c:	5b                   	pop    %ebx
  80187d:	5e                   	pop    %esi
  80187e:	5f                   	pop    %edi
  80187f:	5d                   	pop    %ebp
  801880:	c3                   	ret    
  801881:	8d 76 00             	lea    0x0(%esi),%esi
  801884:	2b 04 24             	sub    (%esp),%eax
  801887:	19 fa                	sbb    %edi,%edx
  801889:	89 d1                	mov    %edx,%ecx
  80188b:	89 c6                	mov    %eax,%esi
  80188d:	e9 71 ff ff ff       	jmp    801803 <__umoddi3+0xb3>
  801892:	66 90                	xchg   %ax,%ax
  801894:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801898:	72 ea                	jb     801884 <__umoddi3+0x134>
  80189a:	89 d9                	mov    %ebx,%ecx
  80189c:	e9 62 ff ff ff       	jmp    801803 <__umoddi3+0xb3>
