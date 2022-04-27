
obj/user/ef_fos_factorial:     file format elf32-i386


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
  800031:	e8 6c 00 00 00       	call   8000a2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	//atomic_readline("Please enter a number:", buff1);
	i1 = 10;
  800048:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)

	int res = factorial(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <factorial>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 a0 18 80 00       	push   $0x8018a0
  80006e:	e8 3f 02 00 00       	call   8002b2 <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <factorial>:


int factorial(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  80007f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800083:	7f 07                	jg     80008c <factorial+0x13>
		return 1 ;
  800085:	b8 01 00 00 00       	mov    $0x1,%eax
  80008a:	eb 14                	jmp    8000a0 <factorial+0x27>
	return n * factorial(n-1) ;
  80008c:	8b 45 08             	mov    0x8(%ebp),%eax
  80008f:	48                   	dec    %eax
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	50                   	push   %eax
  800094:	e8 e0 ff ff ff       	call   800079 <factorial>
  800099:	83 c4 10             	add    $0x10,%esp
  80009c:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000a8:	e8 03 10 00 00       	call   8010b0 <sys_getenvindex>
  8000ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b3:	89 d0                	mov    %edx,%eax
  8000b5:	c1 e0 02             	shl    $0x2,%eax
  8000b8:	01 d0                	add    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	01 c0                	add    %eax,%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000c9:	01 d0                	add    %edx,%eax
  8000cb:	c1 e0 02             	shl    $0x2,%eax
  8000ce:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000d3:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000d8:	a1 04 20 80 00       	mov    0x802004,%eax
  8000dd:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000e3:	84 c0                	test   %al,%al
  8000e5:	74 0f                	je     8000f6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000e7:	a1 04 20 80 00       	mov    0x802004,%eax
  8000ec:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000f1:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000fa:	7e 0a                	jle    800106 <libmain+0x64>
		binaryname = argv[0];
  8000fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ff:	8b 00                	mov    (%eax),%eax
  800101:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800106:	83 ec 08             	sub    $0x8,%esp
  800109:	ff 75 0c             	pushl  0xc(%ebp)
  80010c:	ff 75 08             	pushl  0x8(%ebp)
  80010f:	e8 24 ff ff ff       	call   800038 <_main>
  800114:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800117:	e8 2f 11 00 00       	call   80124b <sys_disable_interrupt>
	cprintf("**************************************\n");
  80011c:	83 ec 0c             	sub    $0xc,%esp
  80011f:	68 cc 18 80 00       	push   $0x8018cc
  800124:	e8 5c 01 00 00       	call   800285 <cprintf>
  800129:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80012c:	a1 04 20 80 00       	mov    0x802004,%eax
  800131:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800137:	a1 04 20 80 00       	mov    0x802004,%eax
  80013c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	52                   	push   %edx
  800146:	50                   	push   %eax
  800147:	68 f4 18 80 00       	push   $0x8018f4
  80014c:	e8 34 01 00 00       	call   800285 <cprintf>
  800151:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800154:	a1 04 20 80 00       	mov    0x802004,%eax
  800159:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80015f:	83 ec 08             	sub    $0x8,%esp
  800162:	50                   	push   %eax
  800163:	68 19 19 80 00       	push   $0x801919
  800168:	e8 18 01 00 00       	call   800285 <cprintf>
  80016d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800170:	83 ec 0c             	sub    $0xc,%esp
  800173:	68 cc 18 80 00       	push   $0x8018cc
  800178:	e8 08 01 00 00       	call   800285 <cprintf>
  80017d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800180:	e8 e0 10 00 00       	call   801265 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800185:	e8 19 00 00 00       	call   8001a3 <exit>
}
  80018a:	90                   	nop
  80018b:	c9                   	leave  
  80018c:	c3                   	ret    

0080018d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80018d:	55                   	push   %ebp
  80018e:	89 e5                	mov    %esp,%ebp
  800190:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	6a 00                	push   $0x0
  800198:	e8 df 0e 00 00       	call   80107c <sys_env_destroy>
  80019d:	83 c4 10             	add    $0x10,%esp
}
  8001a0:	90                   	nop
  8001a1:	c9                   	leave  
  8001a2:	c3                   	ret    

008001a3 <exit>:

void
exit(void)
{
  8001a3:	55                   	push   %ebp
  8001a4:	89 e5                	mov    %esp,%ebp
  8001a6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a9:	e8 34 0f 00 00       	call   8010e2 <sys_env_exit>
}
  8001ae:	90                   	nop
  8001af:	c9                   	leave  
  8001b0:	c3                   	ret    

008001b1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001b1:	55                   	push   %ebp
  8001b2:	89 e5                	mov    %esp,%ebp
  8001b4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ba:	8b 00                	mov    (%eax),%eax
  8001bc:	8d 48 01             	lea    0x1(%eax),%ecx
  8001bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c2:	89 0a                	mov    %ecx,(%edx)
  8001c4:	8b 55 08             	mov    0x8(%ebp),%edx
  8001c7:	88 d1                	mov    %dl,%cl
  8001c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d3:	8b 00                	mov    (%eax),%eax
  8001d5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001da:	75 2c                	jne    800208 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001dc:	a0 08 20 80 00       	mov    0x802008,%al
  8001e1:	0f b6 c0             	movzbl %al,%eax
  8001e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e7:	8b 12                	mov    (%edx),%edx
  8001e9:	89 d1                	mov    %edx,%ecx
  8001eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ee:	83 c2 08             	add    $0x8,%edx
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	50                   	push   %eax
  8001f5:	51                   	push   %ecx
  8001f6:	52                   	push   %edx
  8001f7:	e8 3e 0e 00 00       	call   80103a <sys_cputs>
  8001fc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800202:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	8b 40 04             	mov    0x4(%eax),%eax
  80020e:	8d 50 01             	lea    0x1(%eax),%edx
  800211:	8b 45 0c             	mov    0xc(%ebp),%eax
  800214:	89 50 04             	mov    %edx,0x4(%eax)
}
  800217:	90                   	nop
  800218:	c9                   	leave  
  800219:	c3                   	ret    

0080021a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80021a:	55                   	push   %ebp
  80021b:	89 e5                	mov    %esp,%ebp
  80021d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800223:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80022a:	00 00 00 
	b.cnt = 0;
  80022d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800234:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800237:	ff 75 0c             	pushl  0xc(%ebp)
  80023a:	ff 75 08             	pushl  0x8(%ebp)
  80023d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800243:	50                   	push   %eax
  800244:	68 b1 01 80 00       	push   $0x8001b1
  800249:	e8 11 02 00 00       	call   80045f <vprintfmt>
  80024e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800251:	a0 08 20 80 00       	mov    0x802008,%al
  800256:	0f b6 c0             	movzbl %al,%eax
  800259:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80025f:	83 ec 04             	sub    $0x4,%esp
  800262:	50                   	push   %eax
  800263:	52                   	push   %edx
  800264:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026a:	83 c0 08             	add    $0x8,%eax
  80026d:	50                   	push   %eax
  80026e:	e8 c7 0d 00 00       	call   80103a <sys_cputs>
  800273:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800276:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80027d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800283:	c9                   	leave  
  800284:	c3                   	ret    

00800285 <cprintf>:

int cprintf(const char *fmt, ...) {
  800285:	55                   	push   %ebp
  800286:	89 e5                	mov    %esp,%ebp
  800288:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80028b:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800292:	8d 45 0c             	lea    0xc(%ebp),%eax
  800295:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800298:	8b 45 08             	mov    0x8(%ebp),%eax
  80029b:	83 ec 08             	sub    $0x8,%esp
  80029e:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a1:	50                   	push   %eax
  8002a2:	e8 73 ff ff ff       	call   80021a <vcprintf>
  8002a7:	83 c4 10             	add    $0x10,%esp
  8002aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002b0:	c9                   	leave  
  8002b1:	c3                   	ret    

008002b2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002b2:	55                   	push   %ebp
  8002b3:	89 e5                	mov    %esp,%ebp
  8002b5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002b8:	e8 8e 0f 00 00       	call   80124b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	83 ec 08             	sub    $0x8,%esp
  8002c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cc:	50                   	push   %eax
  8002cd:	e8 48 ff ff ff       	call   80021a <vcprintf>
  8002d2:	83 c4 10             	add    $0x10,%esp
  8002d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002d8:	e8 88 0f 00 00       	call   801265 <sys_enable_interrupt>
	return cnt;
  8002dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e0:	c9                   	leave  
  8002e1:	c3                   	ret    

008002e2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002e2:	55                   	push   %ebp
  8002e3:	89 e5                	mov    %esp,%ebp
  8002e5:	53                   	push   %ebx
  8002e6:	83 ec 14             	sub    $0x14,%esp
  8002e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8002f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8002fd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800300:	77 55                	ja     800357 <printnum+0x75>
  800302:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800305:	72 05                	jb     80030c <printnum+0x2a>
  800307:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80030a:	77 4b                	ja     800357 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80030c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80030f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800312:	8b 45 18             	mov    0x18(%ebp),%eax
  800315:	ba 00 00 00 00       	mov    $0x0,%edx
  80031a:	52                   	push   %edx
  80031b:	50                   	push   %eax
  80031c:	ff 75 f4             	pushl  -0xc(%ebp)
  80031f:	ff 75 f0             	pushl  -0x10(%ebp)
  800322:	e8 05 13 00 00       	call   80162c <__udivdi3>
  800327:	83 c4 10             	add    $0x10,%esp
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	ff 75 20             	pushl  0x20(%ebp)
  800330:	53                   	push   %ebx
  800331:	ff 75 18             	pushl  0x18(%ebp)
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	ff 75 0c             	pushl  0xc(%ebp)
  800339:	ff 75 08             	pushl  0x8(%ebp)
  80033c:	e8 a1 ff ff ff       	call   8002e2 <printnum>
  800341:	83 c4 20             	add    $0x20,%esp
  800344:	eb 1a                	jmp    800360 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800346:	83 ec 08             	sub    $0x8,%esp
  800349:	ff 75 0c             	pushl  0xc(%ebp)
  80034c:	ff 75 20             	pushl  0x20(%ebp)
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	ff d0                	call   *%eax
  800354:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800357:	ff 4d 1c             	decl   0x1c(%ebp)
  80035a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80035e:	7f e6                	jg     800346 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800360:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800363:	bb 00 00 00 00       	mov    $0x0,%ebx
  800368:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80036e:	53                   	push   %ebx
  80036f:	51                   	push   %ecx
  800370:	52                   	push   %edx
  800371:	50                   	push   %eax
  800372:	e8 c5 13 00 00       	call   80173c <__umoddi3>
  800377:	83 c4 10             	add    $0x10,%esp
  80037a:	05 54 1b 80 00       	add    $0x801b54,%eax
  80037f:	8a 00                	mov    (%eax),%al
  800381:	0f be c0             	movsbl %al,%eax
  800384:	83 ec 08             	sub    $0x8,%esp
  800387:	ff 75 0c             	pushl  0xc(%ebp)
  80038a:	50                   	push   %eax
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	ff d0                	call   *%eax
  800390:	83 c4 10             	add    $0x10,%esp
}
  800393:	90                   	nop
  800394:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800397:	c9                   	leave  
  800398:	c3                   	ret    

00800399 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800399:	55                   	push   %ebp
  80039a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80039c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003a0:	7e 1c                	jle    8003be <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a5:	8b 00                	mov    (%eax),%eax
  8003a7:	8d 50 08             	lea    0x8(%eax),%edx
  8003aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ad:	89 10                	mov    %edx,(%eax)
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	8b 00                	mov    (%eax),%eax
  8003b4:	83 e8 08             	sub    $0x8,%eax
  8003b7:	8b 50 04             	mov    0x4(%eax),%edx
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	eb 40                	jmp    8003fe <getuint+0x65>
	else if (lflag)
  8003be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003c2:	74 1e                	je     8003e2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c7:	8b 00                	mov    (%eax),%eax
  8003c9:	8d 50 04             	lea    0x4(%eax),%edx
  8003cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cf:	89 10                	mov    %edx,(%eax)
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	83 e8 04             	sub    $0x4,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	ba 00 00 00 00       	mov    $0x0,%edx
  8003e0:	eb 1c                	jmp    8003fe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	8b 00                	mov    (%eax),%eax
  8003e7:	8d 50 04             	lea    0x4(%eax),%edx
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	89 10                	mov    %edx,(%eax)
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	83 e8 04             	sub    $0x4,%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003fe:	5d                   	pop    %ebp
  8003ff:	c3                   	ret    

00800400 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800400:	55                   	push   %ebp
  800401:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800403:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800407:	7e 1c                	jle    800425 <getint+0x25>
		return va_arg(*ap, long long);
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	8d 50 08             	lea    0x8(%eax),%edx
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	89 10                	mov    %edx,(%eax)
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	83 e8 08             	sub    $0x8,%eax
  80041e:	8b 50 04             	mov    0x4(%eax),%edx
  800421:	8b 00                	mov    (%eax),%eax
  800423:	eb 38                	jmp    80045d <getint+0x5d>
	else if (lflag)
  800425:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800429:	74 1a                	je     800445 <getint+0x45>
		return va_arg(*ap, long);
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	8d 50 04             	lea    0x4(%eax),%edx
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	89 10                	mov    %edx,(%eax)
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	83 e8 04             	sub    $0x4,%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	99                   	cltd   
  800443:	eb 18                	jmp    80045d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	8d 50 04             	lea    0x4(%eax),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	89 10                	mov    %edx,(%eax)
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	83 e8 04             	sub    $0x4,%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	99                   	cltd   
}
  80045d:	5d                   	pop    %ebp
  80045e:	c3                   	ret    

0080045f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80045f:	55                   	push   %ebp
  800460:	89 e5                	mov    %esp,%ebp
  800462:	56                   	push   %esi
  800463:	53                   	push   %ebx
  800464:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800467:	eb 17                	jmp    800480 <vprintfmt+0x21>
			if (ch == '\0')
  800469:	85 db                	test   %ebx,%ebx
  80046b:	0f 84 af 03 00 00    	je     800820 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800471:	83 ec 08             	sub    $0x8,%esp
  800474:	ff 75 0c             	pushl  0xc(%ebp)
  800477:	53                   	push   %ebx
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	ff d0                	call   *%eax
  80047d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800480:	8b 45 10             	mov    0x10(%ebp),%eax
  800483:	8d 50 01             	lea    0x1(%eax),%edx
  800486:	89 55 10             	mov    %edx,0x10(%ebp)
  800489:	8a 00                	mov    (%eax),%al
  80048b:	0f b6 d8             	movzbl %al,%ebx
  80048e:	83 fb 25             	cmp    $0x25,%ebx
  800491:	75 d6                	jne    800469 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800493:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800497:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80049e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004ac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b6:	8d 50 01             	lea    0x1(%eax),%edx
  8004b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8004bc:	8a 00                	mov    (%eax),%al
  8004be:	0f b6 d8             	movzbl %al,%ebx
  8004c1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004c4:	83 f8 55             	cmp    $0x55,%eax
  8004c7:	0f 87 2b 03 00 00    	ja     8007f8 <vprintfmt+0x399>
  8004cd:	8b 04 85 78 1b 80 00 	mov    0x801b78(,%eax,4),%eax
  8004d4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004d6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004da:	eb d7                	jmp    8004b3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004dc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004e0:	eb d1                	jmp    8004b3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004ec:	89 d0                	mov    %edx,%eax
  8004ee:	c1 e0 02             	shl    $0x2,%eax
  8004f1:	01 d0                	add    %edx,%eax
  8004f3:	01 c0                	add    %eax,%eax
  8004f5:	01 d8                	add    %ebx,%eax
  8004f7:	83 e8 30             	sub    $0x30,%eax
  8004fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800500:	8a 00                	mov    (%eax),%al
  800502:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800505:	83 fb 2f             	cmp    $0x2f,%ebx
  800508:	7e 3e                	jle    800548 <vprintfmt+0xe9>
  80050a:	83 fb 39             	cmp    $0x39,%ebx
  80050d:	7f 39                	jg     800548 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800512:	eb d5                	jmp    8004e9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800514:	8b 45 14             	mov    0x14(%ebp),%eax
  800517:	83 c0 04             	add    $0x4,%eax
  80051a:	89 45 14             	mov    %eax,0x14(%ebp)
  80051d:	8b 45 14             	mov    0x14(%ebp),%eax
  800520:	83 e8 04             	sub    $0x4,%eax
  800523:	8b 00                	mov    (%eax),%eax
  800525:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800528:	eb 1f                	jmp    800549 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80052a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80052e:	79 83                	jns    8004b3 <vprintfmt+0x54>
				width = 0;
  800530:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800537:	e9 77 ff ff ff       	jmp    8004b3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80053c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800543:	e9 6b ff ff ff       	jmp    8004b3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800548:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800549:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80054d:	0f 89 60 ff ff ff    	jns    8004b3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800553:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800556:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800559:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800560:	e9 4e ff ff ff       	jmp    8004b3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800565:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800568:	e9 46 ff ff ff       	jmp    8004b3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80056d:	8b 45 14             	mov    0x14(%ebp),%eax
  800570:	83 c0 04             	add    $0x4,%eax
  800573:	89 45 14             	mov    %eax,0x14(%ebp)
  800576:	8b 45 14             	mov    0x14(%ebp),%eax
  800579:	83 e8 04             	sub    $0x4,%eax
  80057c:	8b 00                	mov    (%eax),%eax
  80057e:	83 ec 08             	sub    $0x8,%esp
  800581:	ff 75 0c             	pushl  0xc(%ebp)
  800584:	50                   	push   %eax
  800585:	8b 45 08             	mov    0x8(%ebp),%eax
  800588:	ff d0                	call   *%eax
  80058a:	83 c4 10             	add    $0x10,%esp
			break;
  80058d:	e9 89 02 00 00       	jmp    80081b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800592:	8b 45 14             	mov    0x14(%ebp),%eax
  800595:	83 c0 04             	add    $0x4,%eax
  800598:	89 45 14             	mov    %eax,0x14(%ebp)
  80059b:	8b 45 14             	mov    0x14(%ebp),%eax
  80059e:	83 e8 04             	sub    $0x4,%eax
  8005a1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005a3:	85 db                	test   %ebx,%ebx
  8005a5:	79 02                	jns    8005a9 <vprintfmt+0x14a>
				err = -err;
  8005a7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005a9:	83 fb 64             	cmp    $0x64,%ebx
  8005ac:	7f 0b                	jg     8005b9 <vprintfmt+0x15a>
  8005ae:	8b 34 9d c0 19 80 00 	mov    0x8019c0(,%ebx,4),%esi
  8005b5:	85 f6                	test   %esi,%esi
  8005b7:	75 19                	jne    8005d2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005b9:	53                   	push   %ebx
  8005ba:	68 65 1b 80 00       	push   $0x801b65
  8005bf:	ff 75 0c             	pushl  0xc(%ebp)
  8005c2:	ff 75 08             	pushl  0x8(%ebp)
  8005c5:	e8 5e 02 00 00       	call   800828 <printfmt>
  8005ca:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005cd:	e9 49 02 00 00       	jmp    80081b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005d2:	56                   	push   %esi
  8005d3:	68 6e 1b 80 00       	push   $0x801b6e
  8005d8:	ff 75 0c             	pushl  0xc(%ebp)
  8005db:	ff 75 08             	pushl  0x8(%ebp)
  8005de:	e8 45 02 00 00       	call   800828 <printfmt>
  8005e3:	83 c4 10             	add    $0x10,%esp
			break;
  8005e6:	e9 30 02 00 00       	jmp    80081b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ee:	83 c0 04             	add    $0x4,%eax
  8005f1:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f7:	83 e8 04             	sub    $0x4,%eax
  8005fa:	8b 30                	mov    (%eax),%esi
  8005fc:	85 f6                	test   %esi,%esi
  8005fe:	75 05                	jne    800605 <vprintfmt+0x1a6>
				p = "(null)";
  800600:	be 71 1b 80 00       	mov    $0x801b71,%esi
			if (width > 0 && padc != '-')
  800605:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800609:	7e 6d                	jle    800678 <vprintfmt+0x219>
  80060b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80060f:	74 67                	je     800678 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800611:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800614:	83 ec 08             	sub    $0x8,%esp
  800617:	50                   	push   %eax
  800618:	56                   	push   %esi
  800619:	e8 0c 03 00 00       	call   80092a <strnlen>
  80061e:	83 c4 10             	add    $0x10,%esp
  800621:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800624:	eb 16                	jmp    80063c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800626:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	50                   	push   %eax
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	ff d0                	call   *%eax
  800636:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800639:	ff 4d e4             	decl   -0x1c(%ebp)
  80063c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800640:	7f e4                	jg     800626 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800642:	eb 34                	jmp    800678 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800644:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800648:	74 1c                	je     800666 <vprintfmt+0x207>
  80064a:	83 fb 1f             	cmp    $0x1f,%ebx
  80064d:	7e 05                	jle    800654 <vprintfmt+0x1f5>
  80064f:	83 fb 7e             	cmp    $0x7e,%ebx
  800652:	7e 12                	jle    800666 <vprintfmt+0x207>
					putch('?', putdat);
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	6a 3f                	push   $0x3f
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	ff d0                	call   *%eax
  800661:	83 c4 10             	add    $0x10,%esp
  800664:	eb 0f                	jmp    800675 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800666:	83 ec 08             	sub    $0x8,%esp
  800669:	ff 75 0c             	pushl  0xc(%ebp)
  80066c:	53                   	push   %ebx
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	ff d0                	call   *%eax
  800672:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800675:	ff 4d e4             	decl   -0x1c(%ebp)
  800678:	89 f0                	mov    %esi,%eax
  80067a:	8d 70 01             	lea    0x1(%eax),%esi
  80067d:	8a 00                	mov    (%eax),%al
  80067f:	0f be d8             	movsbl %al,%ebx
  800682:	85 db                	test   %ebx,%ebx
  800684:	74 24                	je     8006aa <vprintfmt+0x24b>
  800686:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80068a:	78 b8                	js     800644 <vprintfmt+0x1e5>
  80068c:	ff 4d e0             	decl   -0x20(%ebp)
  80068f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800693:	79 af                	jns    800644 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800695:	eb 13                	jmp    8006aa <vprintfmt+0x24b>
				putch(' ', putdat);
  800697:	83 ec 08             	sub    $0x8,%esp
  80069a:	ff 75 0c             	pushl  0xc(%ebp)
  80069d:	6a 20                	push   $0x20
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	ff d0                	call   *%eax
  8006a4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a7:	ff 4d e4             	decl   -0x1c(%ebp)
  8006aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ae:	7f e7                	jg     800697 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006b0:	e9 66 01 00 00       	jmp    80081b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8006bb:	8d 45 14             	lea    0x14(%ebp),%eax
  8006be:	50                   	push   %eax
  8006bf:	e8 3c fd ff ff       	call   800400 <getint>
  8006c4:	83 c4 10             	add    $0x10,%esp
  8006c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d3:	85 d2                	test   %edx,%edx
  8006d5:	79 23                	jns    8006fa <vprintfmt+0x29b>
				putch('-', putdat);
  8006d7:	83 ec 08             	sub    $0x8,%esp
  8006da:	ff 75 0c             	pushl  0xc(%ebp)
  8006dd:	6a 2d                	push   $0x2d
  8006df:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e2:	ff d0                	call   *%eax
  8006e4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ed:	f7 d8                	neg    %eax
  8006ef:	83 d2 00             	adc    $0x0,%edx
  8006f2:	f7 da                	neg    %edx
  8006f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006fa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800701:	e9 bc 00 00 00       	jmp    8007c2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800706:	83 ec 08             	sub    $0x8,%esp
  800709:	ff 75 e8             	pushl  -0x18(%ebp)
  80070c:	8d 45 14             	lea    0x14(%ebp),%eax
  80070f:	50                   	push   %eax
  800710:	e8 84 fc ff ff       	call   800399 <getuint>
  800715:	83 c4 10             	add    $0x10,%esp
  800718:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80071e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800725:	e9 98 00 00 00       	jmp    8007c2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80072a:	83 ec 08             	sub    $0x8,%esp
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	6a 58                	push   $0x58
  800732:	8b 45 08             	mov    0x8(%ebp),%eax
  800735:	ff d0                	call   *%eax
  800737:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	6a 58                	push   $0x58
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	ff d0                	call   *%eax
  800747:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80074a:	83 ec 08             	sub    $0x8,%esp
  80074d:	ff 75 0c             	pushl  0xc(%ebp)
  800750:	6a 58                	push   $0x58
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	ff d0                	call   *%eax
  800757:	83 c4 10             	add    $0x10,%esp
			break;
  80075a:	e9 bc 00 00 00       	jmp    80081b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80075f:	83 ec 08             	sub    $0x8,%esp
  800762:	ff 75 0c             	pushl  0xc(%ebp)
  800765:	6a 30                	push   $0x30
  800767:	8b 45 08             	mov    0x8(%ebp),%eax
  80076a:	ff d0                	call   *%eax
  80076c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80076f:	83 ec 08             	sub    $0x8,%esp
  800772:	ff 75 0c             	pushl  0xc(%ebp)
  800775:	6a 78                	push   $0x78
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	ff d0                	call   *%eax
  80077c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80077f:	8b 45 14             	mov    0x14(%ebp),%eax
  800782:	83 c0 04             	add    $0x4,%eax
  800785:	89 45 14             	mov    %eax,0x14(%ebp)
  800788:	8b 45 14             	mov    0x14(%ebp),%eax
  80078b:	83 e8 04             	sub    $0x4,%eax
  80078e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800790:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800793:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80079a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007a1:	eb 1f                	jmp    8007c2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007a3:	83 ec 08             	sub    $0x8,%esp
  8007a6:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a9:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ac:	50                   	push   %eax
  8007ad:	e8 e7 fb ff ff       	call   800399 <getuint>
  8007b2:	83 c4 10             	add    $0x10,%esp
  8007b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007bb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007c2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c9:	83 ec 04             	sub    $0x4,%esp
  8007cc:	52                   	push   %edx
  8007cd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007d0:	50                   	push   %eax
  8007d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	ff 75 08             	pushl  0x8(%ebp)
  8007dd:	e8 00 fb ff ff       	call   8002e2 <printnum>
  8007e2:	83 c4 20             	add    $0x20,%esp
			break;
  8007e5:	eb 34                	jmp    80081b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007e7:	83 ec 08             	sub    $0x8,%esp
  8007ea:	ff 75 0c             	pushl  0xc(%ebp)
  8007ed:	53                   	push   %ebx
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	ff d0                	call   *%eax
  8007f3:	83 c4 10             	add    $0x10,%esp
			break;
  8007f6:	eb 23                	jmp    80081b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	6a 25                	push   $0x25
  800800:	8b 45 08             	mov    0x8(%ebp),%eax
  800803:	ff d0                	call   *%eax
  800805:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800808:	ff 4d 10             	decl   0x10(%ebp)
  80080b:	eb 03                	jmp    800810 <vprintfmt+0x3b1>
  80080d:	ff 4d 10             	decl   0x10(%ebp)
  800810:	8b 45 10             	mov    0x10(%ebp),%eax
  800813:	48                   	dec    %eax
  800814:	8a 00                	mov    (%eax),%al
  800816:	3c 25                	cmp    $0x25,%al
  800818:	75 f3                	jne    80080d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80081a:	90                   	nop
		}
	}
  80081b:	e9 47 fc ff ff       	jmp    800467 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800820:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800821:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800824:	5b                   	pop    %ebx
  800825:	5e                   	pop    %esi
  800826:	5d                   	pop    %ebp
  800827:	c3                   	ret    

00800828 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800828:	55                   	push   %ebp
  800829:	89 e5                	mov    %esp,%ebp
  80082b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80082e:	8d 45 10             	lea    0x10(%ebp),%eax
  800831:	83 c0 04             	add    $0x4,%eax
  800834:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800837:	8b 45 10             	mov    0x10(%ebp),%eax
  80083a:	ff 75 f4             	pushl  -0xc(%ebp)
  80083d:	50                   	push   %eax
  80083e:	ff 75 0c             	pushl  0xc(%ebp)
  800841:	ff 75 08             	pushl  0x8(%ebp)
  800844:	e8 16 fc ff ff       	call   80045f <vprintfmt>
  800849:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80084c:	90                   	nop
  80084d:	c9                   	leave  
  80084e:	c3                   	ret    

0080084f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80084f:	55                   	push   %ebp
  800850:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800852:	8b 45 0c             	mov    0xc(%ebp),%eax
  800855:	8b 40 08             	mov    0x8(%eax),%eax
  800858:	8d 50 01             	lea    0x1(%eax),%edx
  80085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800861:	8b 45 0c             	mov    0xc(%ebp),%eax
  800864:	8b 10                	mov    (%eax),%edx
  800866:	8b 45 0c             	mov    0xc(%ebp),%eax
  800869:	8b 40 04             	mov    0x4(%eax),%eax
  80086c:	39 c2                	cmp    %eax,%edx
  80086e:	73 12                	jae    800882 <sprintputch+0x33>
		*b->buf++ = ch;
  800870:	8b 45 0c             	mov    0xc(%ebp),%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	8d 48 01             	lea    0x1(%eax),%ecx
  800878:	8b 55 0c             	mov    0xc(%ebp),%edx
  80087b:	89 0a                	mov    %ecx,(%edx)
  80087d:	8b 55 08             	mov    0x8(%ebp),%edx
  800880:	88 10                	mov    %dl,(%eax)
}
  800882:	90                   	nop
  800883:	5d                   	pop    %ebp
  800884:	c3                   	ret    

00800885 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800885:	55                   	push   %ebp
  800886:	89 e5                	mov    %esp,%ebp
  800888:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	8d 50 ff             	lea    -0x1(%eax),%edx
  800897:	8b 45 08             	mov    0x8(%ebp),%eax
  80089a:	01 d0                	add    %edx,%eax
  80089c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008aa:	74 06                	je     8008b2 <vsnprintf+0x2d>
  8008ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b0:	7f 07                	jg     8008b9 <vsnprintf+0x34>
		return -E_INVAL;
  8008b2:	b8 03 00 00 00       	mov    $0x3,%eax
  8008b7:	eb 20                	jmp    8008d9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008b9:	ff 75 14             	pushl  0x14(%ebp)
  8008bc:	ff 75 10             	pushl  0x10(%ebp)
  8008bf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008c2:	50                   	push   %eax
  8008c3:	68 4f 08 80 00       	push   $0x80084f
  8008c8:	e8 92 fb ff ff       	call   80045f <vprintfmt>
  8008cd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008d3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008d9:	c9                   	leave  
  8008da:	c3                   	ret    

008008db <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
  8008de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008e1:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e4:	83 c0 04             	add    $0x4,%eax
  8008e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f0:	50                   	push   %eax
  8008f1:	ff 75 0c             	pushl  0xc(%ebp)
  8008f4:	ff 75 08             	pushl  0x8(%ebp)
  8008f7:	e8 89 ff ff ff       	call   800885 <vsnprintf>
  8008fc:	83 c4 10             	add    $0x10,%esp
  8008ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800902:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800905:	c9                   	leave  
  800906:	c3                   	ret    

00800907 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800907:	55                   	push   %ebp
  800908:	89 e5                	mov    %esp,%ebp
  80090a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80090d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800914:	eb 06                	jmp    80091c <strlen+0x15>
		n++;
  800916:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800919:	ff 45 08             	incl   0x8(%ebp)
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	8a 00                	mov    (%eax),%al
  800921:	84 c0                	test   %al,%al
  800923:	75 f1                	jne    800916 <strlen+0xf>
		n++;
	return n;
  800925:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800928:	c9                   	leave  
  800929:	c3                   	ret    

0080092a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80092a:	55                   	push   %ebp
  80092b:	89 e5                	mov    %esp,%ebp
  80092d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800930:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800937:	eb 09                	jmp    800942 <strnlen+0x18>
		n++;
  800939:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80093c:	ff 45 08             	incl   0x8(%ebp)
  80093f:	ff 4d 0c             	decl   0xc(%ebp)
  800942:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800946:	74 09                	je     800951 <strnlen+0x27>
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	8a 00                	mov    (%eax),%al
  80094d:	84 c0                	test   %al,%al
  80094f:	75 e8                	jne    800939 <strnlen+0xf>
		n++;
	return n;
  800951:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800954:	c9                   	leave  
  800955:	c3                   	ret    

00800956 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80095c:	8b 45 08             	mov    0x8(%ebp),%eax
  80095f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800962:	90                   	nop
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	8d 50 01             	lea    0x1(%eax),%edx
  800969:	89 55 08             	mov    %edx,0x8(%ebp)
  80096c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800972:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800975:	8a 12                	mov    (%edx),%dl
  800977:	88 10                	mov    %dl,(%eax)
  800979:	8a 00                	mov    (%eax),%al
  80097b:	84 c0                	test   %al,%al
  80097d:	75 e4                	jne    800963 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80097f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800990:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800997:	eb 1f                	jmp    8009b8 <strncpy+0x34>
		*dst++ = *src;
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	8d 50 01             	lea    0x1(%eax),%edx
  80099f:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a5:	8a 12                	mov    (%edx),%dl
  8009a7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ac:	8a 00                	mov    (%eax),%al
  8009ae:	84 c0                	test   %al,%al
  8009b0:	74 03                	je     8009b5 <strncpy+0x31>
			src++;
  8009b2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009b5:	ff 45 fc             	incl   -0x4(%ebp)
  8009b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009bb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009be:	72 d9                	jb     800999 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009c3:	c9                   	leave  
  8009c4:	c3                   	ret    

008009c5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009c5:	55                   	push   %ebp
  8009c6:	89 e5                	mov    %esp,%ebp
  8009c8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d5:	74 30                	je     800a07 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009d7:	eb 16                	jmp    8009ef <strlcpy+0x2a>
			*dst++ = *src++;
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	8d 50 01             	lea    0x1(%eax),%edx
  8009df:	89 55 08             	mov    %edx,0x8(%ebp)
  8009e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009eb:	8a 12                	mov    (%edx),%dl
  8009ed:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ef:	ff 4d 10             	decl   0x10(%ebp)
  8009f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f6:	74 09                	je     800a01 <strlcpy+0x3c>
  8009f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fb:	8a 00                	mov    (%eax),%al
  8009fd:	84 c0                	test   %al,%al
  8009ff:	75 d8                	jne    8009d9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a07:	8b 55 08             	mov    0x8(%ebp),%edx
  800a0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a0d:	29 c2                	sub    %eax,%edx
  800a0f:	89 d0                	mov    %edx,%eax
}
  800a11:	c9                   	leave  
  800a12:	c3                   	ret    

00800a13 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a16:	eb 06                	jmp    800a1e <strcmp+0xb>
		p++, q++;
  800a18:	ff 45 08             	incl   0x8(%ebp)
  800a1b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	8a 00                	mov    (%eax),%al
  800a23:	84 c0                	test   %al,%al
  800a25:	74 0e                	je     800a35 <strcmp+0x22>
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	8a 10                	mov    (%eax),%dl
  800a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2f:	8a 00                	mov    (%eax),%al
  800a31:	38 c2                	cmp    %al,%dl
  800a33:	74 e3                	je     800a18 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	8a 00                	mov    (%eax),%al
  800a3a:	0f b6 d0             	movzbl %al,%edx
  800a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a40:	8a 00                	mov    (%eax),%al
  800a42:	0f b6 c0             	movzbl %al,%eax
  800a45:	29 c2                	sub    %eax,%edx
  800a47:	89 d0                	mov    %edx,%eax
}
  800a49:	5d                   	pop    %ebp
  800a4a:	c3                   	ret    

00800a4b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a4b:	55                   	push   %ebp
  800a4c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a4e:	eb 09                	jmp    800a59 <strncmp+0xe>
		n--, p++, q++;
  800a50:	ff 4d 10             	decl   0x10(%ebp)
  800a53:	ff 45 08             	incl   0x8(%ebp)
  800a56:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a5d:	74 17                	je     800a76 <strncmp+0x2b>
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8a 00                	mov    (%eax),%al
  800a64:	84 c0                	test   %al,%al
  800a66:	74 0e                	je     800a76 <strncmp+0x2b>
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8a 10                	mov    (%eax),%dl
  800a6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a70:	8a 00                	mov    (%eax),%al
  800a72:	38 c2                	cmp    %al,%dl
  800a74:	74 da                	je     800a50 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7a:	75 07                	jne    800a83 <strncmp+0x38>
		return 0;
  800a7c:	b8 00 00 00 00       	mov    $0x0,%eax
  800a81:	eb 14                	jmp    800a97 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	0f b6 d0             	movzbl %al,%edx
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	8a 00                	mov    (%eax),%al
  800a90:	0f b6 c0             	movzbl %al,%eax
  800a93:	29 c2                	sub    %eax,%edx
  800a95:	89 d0                	mov    %edx,%eax
}
  800a97:	5d                   	pop    %ebp
  800a98:	c3                   	ret    

00800a99 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a99:	55                   	push   %ebp
  800a9a:	89 e5                	mov    %esp,%ebp
  800a9c:	83 ec 04             	sub    $0x4,%esp
  800a9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa5:	eb 12                	jmp    800ab9 <strchr+0x20>
		if (*s == c)
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aaf:	75 05                	jne    800ab6 <strchr+0x1d>
			return (char *) s;
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	eb 11                	jmp    800ac7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ab6:	ff 45 08             	incl   0x8(%ebp)
  800ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	84 c0                	test   %al,%al
  800ac0:	75 e5                	jne    800aa7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ac2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ac7:	c9                   	leave  
  800ac8:	c3                   	ret    

00800ac9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ac9:	55                   	push   %ebp
  800aca:	89 e5                	mov    %esp,%ebp
  800acc:	83 ec 04             	sub    $0x4,%esp
  800acf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad5:	eb 0d                	jmp    800ae4 <strfind+0x1b>
		if (*s == c)
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800adf:	74 0e                	je     800aef <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ae1:	ff 45 08             	incl   0x8(%ebp)
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	84 c0                	test   %al,%al
  800aeb:	75 ea                	jne    800ad7 <strfind+0xe>
  800aed:	eb 01                	jmp    800af0 <strfind+0x27>
		if (*s == c)
			break;
  800aef:	90                   	nop
	return (char *) s;
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
  800af8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b01:	8b 45 10             	mov    0x10(%ebp),%eax
  800b04:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b07:	eb 0e                	jmp    800b17 <memset+0x22>
		*p++ = c;
  800b09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b0c:	8d 50 01             	lea    0x1(%eax),%edx
  800b0f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b15:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b17:	ff 4d f8             	decl   -0x8(%ebp)
  800b1a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b1e:	79 e9                	jns    800b09 <memset+0x14>
		*p++ = c;

	return v;
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b23:	c9                   	leave  
  800b24:	c3                   	ret    

00800b25 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b37:	eb 16                	jmp    800b4f <memcpy+0x2a>
		*d++ = *s++;
  800b39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b3c:	8d 50 01             	lea    0x1(%eax),%edx
  800b3f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b42:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b45:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b48:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b4b:	8a 12                	mov    (%edx),%dl
  800b4d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b52:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b55:	89 55 10             	mov    %edx,0x10(%ebp)
  800b58:	85 c0                	test   %eax,%eax
  800b5a:	75 dd                	jne    800b39 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5f:	c9                   	leave  
  800b60:	c3                   	ret    

00800b61 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
  800b64:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b76:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b79:	73 50                	jae    800bcb <memmove+0x6a>
  800b7b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b81:	01 d0                	add    %edx,%eax
  800b83:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b86:	76 43                	jbe    800bcb <memmove+0x6a>
		s += n;
  800b88:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b91:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b94:	eb 10                	jmp    800ba6 <memmove+0x45>
			*--d = *--s;
  800b96:	ff 4d f8             	decl   -0x8(%ebp)
  800b99:	ff 4d fc             	decl   -0x4(%ebp)
  800b9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9f:	8a 10                	mov    (%eax),%dl
  800ba1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ba6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bac:	89 55 10             	mov    %edx,0x10(%ebp)
  800baf:	85 c0                	test   %eax,%eax
  800bb1:	75 e3                	jne    800b96 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bb3:	eb 23                	jmp    800bd8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb8:	8d 50 01             	lea    0x1(%eax),%edx
  800bbb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bbe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bc1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc7:	8a 12                	mov    (%edx),%dl
  800bc9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bce:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd1:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd4:	85 c0                	test   %eax,%eax
  800bd6:	75 dd                	jne    800bb5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bdb:	c9                   	leave  
  800bdc:	c3                   	ret    

00800bdd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bdd:	55                   	push   %ebp
  800bde:	89 e5                	mov    %esp,%ebp
  800be0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800be9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bec:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bef:	eb 2a                	jmp    800c1b <memcmp+0x3e>
		if (*s1 != *s2)
  800bf1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf4:	8a 10                	mov    (%eax),%dl
  800bf6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	38 c2                	cmp    %al,%dl
  800bfd:	74 16                	je     800c15 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c02:	8a 00                	mov    (%eax),%al
  800c04:	0f b6 d0             	movzbl %al,%edx
  800c07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	0f b6 c0             	movzbl %al,%eax
  800c0f:	29 c2                	sub    %eax,%edx
  800c11:	89 d0                	mov    %edx,%eax
  800c13:	eb 18                	jmp    800c2d <memcmp+0x50>
		s1++, s2++;
  800c15:	ff 45 fc             	incl   -0x4(%ebp)
  800c18:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c21:	89 55 10             	mov    %edx,0x10(%ebp)
  800c24:	85 c0                	test   %eax,%eax
  800c26:	75 c9                	jne    800bf1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c28:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c2d:	c9                   	leave  
  800c2e:	c3                   	ret    

00800c2f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c35:	8b 55 08             	mov    0x8(%ebp),%edx
  800c38:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3b:	01 d0                	add    %edx,%eax
  800c3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c40:	eb 15                	jmp    800c57 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	0f b6 d0             	movzbl %al,%edx
  800c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4d:	0f b6 c0             	movzbl %al,%eax
  800c50:	39 c2                	cmp    %eax,%edx
  800c52:	74 0d                	je     800c61 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c54:	ff 45 08             	incl   0x8(%ebp)
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c5d:	72 e3                	jb     800c42 <memfind+0x13>
  800c5f:	eb 01                	jmp    800c62 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c61:	90                   	nop
	return (void *) s;
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c65:	c9                   	leave  
  800c66:	c3                   	ret    

00800c67 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c67:	55                   	push   %ebp
  800c68:	89 e5                	mov    %esp,%ebp
  800c6a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c74:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c7b:	eb 03                	jmp    800c80 <strtol+0x19>
		s++;
  800c7d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	3c 20                	cmp    $0x20,%al
  800c87:	74 f4                	je     800c7d <strtol+0x16>
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8a 00                	mov    (%eax),%al
  800c8e:	3c 09                	cmp    $0x9,%al
  800c90:	74 eb                	je     800c7d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	8a 00                	mov    (%eax),%al
  800c97:	3c 2b                	cmp    $0x2b,%al
  800c99:	75 05                	jne    800ca0 <strtol+0x39>
		s++;
  800c9b:	ff 45 08             	incl   0x8(%ebp)
  800c9e:	eb 13                	jmp    800cb3 <strtol+0x4c>
	else if (*s == '-')
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	8a 00                	mov    (%eax),%al
  800ca5:	3c 2d                	cmp    $0x2d,%al
  800ca7:	75 0a                	jne    800cb3 <strtol+0x4c>
		s++, neg = 1;
  800ca9:	ff 45 08             	incl   0x8(%ebp)
  800cac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb7:	74 06                	je     800cbf <strtol+0x58>
  800cb9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cbd:	75 20                	jne    800cdf <strtol+0x78>
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	3c 30                	cmp    $0x30,%al
  800cc6:	75 17                	jne    800cdf <strtol+0x78>
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	40                   	inc    %eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	3c 78                	cmp    $0x78,%al
  800cd0:	75 0d                	jne    800cdf <strtol+0x78>
		s += 2, base = 16;
  800cd2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cd6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cdd:	eb 28                	jmp    800d07 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cdf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce3:	75 15                	jne    800cfa <strtol+0x93>
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	3c 30                	cmp    $0x30,%al
  800cec:	75 0c                	jne    800cfa <strtol+0x93>
		s++, base = 8;
  800cee:	ff 45 08             	incl   0x8(%ebp)
  800cf1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cf8:	eb 0d                	jmp    800d07 <strtol+0xa0>
	else if (base == 0)
  800cfa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfe:	75 07                	jne    800d07 <strtol+0xa0>
		base = 10;
  800d00:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 2f                	cmp    $0x2f,%al
  800d0e:	7e 19                	jle    800d29 <strtol+0xc2>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 39                	cmp    $0x39,%al
  800d17:	7f 10                	jg     800d29 <strtol+0xc2>
			dig = *s - '0';
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	0f be c0             	movsbl %al,%eax
  800d21:	83 e8 30             	sub    $0x30,%eax
  800d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d27:	eb 42                	jmp    800d6b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3c 60                	cmp    $0x60,%al
  800d30:	7e 19                	jle    800d4b <strtol+0xe4>
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3c 7a                	cmp    $0x7a,%al
  800d39:	7f 10                	jg     800d4b <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	0f be c0             	movsbl %al,%eax
  800d43:	83 e8 57             	sub    $0x57,%eax
  800d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d49:	eb 20                	jmp    800d6b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8a 00                	mov    (%eax),%al
  800d50:	3c 40                	cmp    $0x40,%al
  800d52:	7e 39                	jle    800d8d <strtol+0x126>
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	3c 5a                	cmp    $0x5a,%al
  800d5b:	7f 30                	jg     800d8d <strtol+0x126>
			dig = *s - 'A' + 10;
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	0f be c0             	movsbl %al,%eax
  800d65:	83 e8 37             	sub    $0x37,%eax
  800d68:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d6e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d71:	7d 19                	jge    800d8c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d73:	ff 45 08             	incl   0x8(%ebp)
  800d76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d79:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d7d:	89 c2                	mov    %eax,%edx
  800d7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d82:	01 d0                	add    %edx,%eax
  800d84:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d87:	e9 7b ff ff ff       	jmp    800d07 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d8c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d8d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d91:	74 08                	je     800d9b <strtol+0x134>
		*endptr = (char *) s;
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	8b 55 08             	mov    0x8(%ebp),%edx
  800d99:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d9b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d9f:	74 07                	je     800da8 <strtol+0x141>
  800da1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da4:	f7 d8                	neg    %eax
  800da6:	eb 03                	jmp    800dab <strtol+0x144>
  800da8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dab:	c9                   	leave  
  800dac:	c3                   	ret    

00800dad <ltostr>:

void
ltostr(long value, char *str)
{
  800dad:	55                   	push   %ebp
  800dae:	89 e5                	mov    %esp,%ebp
  800db0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800db3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dc1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dc5:	79 13                	jns    800dda <ltostr+0x2d>
	{
		neg = 1;
  800dc7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dd4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dd7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800de2:	99                   	cltd   
  800de3:	f7 f9                	idiv   %ecx
  800de5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800de8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800deb:	8d 50 01             	lea    0x1(%eax),%edx
  800dee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df1:	89 c2                	mov    %eax,%edx
  800df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df6:	01 d0                	add    %edx,%eax
  800df8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dfb:	83 c2 30             	add    $0x30,%edx
  800dfe:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e00:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e03:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e08:	f7 e9                	imul   %ecx
  800e0a:	c1 fa 02             	sar    $0x2,%edx
  800e0d:	89 c8                	mov    %ecx,%eax
  800e0f:	c1 f8 1f             	sar    $0x1f,%eax
  800e12:	29 c2                	sub    %eax,%edx
  800e14:	89 d0                	mov    %edx,%eax
  800e16:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e19:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e1c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e21:	f7 e9                	imul   %ecx
  800e23:	c1 fa 02             	sar    $0x2,%edx
  800e26:	89 c8                	mov    %ecx,%eax
  800e28:	c1 f8 1f             	sar    $0x1f,%eax
  800e2b:	29 c2                	sub    %eax,%edx
  800e2d:	89 d0                	mov    %edx,%eax
  800e2f:	c1 e0 02             	shl    $0x2,%eax
  800e32:	01 d0                	add    %edx,%eax
  800e34:	01 c0                	add    %eax,%eax
  800e36:	29 c1                	sub    %eax,%ecx
  800e38:	89 ca                	mov    %ecx,%edx
  800e3a:	85 d2                	test   %edx,%edx
  800e3c:	75 9c                	jne    800dda <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e45:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e48:	48                   	dec    %eax
  800e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e4c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e50:	74 3d                	je     800e8f <ltostr+0xe2>
		start = 1 ;
  800e52:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e59:	eb 34                	jmp    800e8f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	01 d0                	add    %edx,%eax
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6e:	01 c2                	add    %eax,%edx
  800e70:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e76:	01 c8                	add    %ecx,%eax
  800e78:	8a 00                	mov    (%eax),%al
  800e7a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e7c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	01 c2                	add    %eax,%edx
  800e84:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e87:	88 02                	mov    %al,(%edx)
		start++ ;
  800e89:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e8c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e92:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e95:	7c c4                	jl     800e5b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e97:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9d:	01 d0                	add    %edx,%eax
  800e9f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ea2:	90                   	nop
  800ea3:	c9                   	leave  
  800ea4:	c3                   	ret    

00800ea5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ea5:	55                   	push   %ebp
  800ea6:	89 e5                	mov    %esp,%ebp
  800ea8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eab:	ff 75 08             	pushl  0x8(%ebp)
  800eae:	e8 54 fa ff ff       	call   800907 <strlen>
  800eb3:	83 c4 04             	add    $0x4,%esp
  800eb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eb9:	ff 75 0c             	pushl  0xc(%ebp)
  800ebc:	e8 46 fa ff ff       	call   800907 <strlen>
  800ec1:	83 c4 04             	add    $0x4,%esp
  800ec4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ec7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ece:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed5:	eb 17                	jmp    800eee <strcconcat+0x49>
		final[s] = str1[s] ;
  800ed7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eda:	8b 45 10             	mov    0x10(%ebp),%eax
  800edd:	01 c2                	add    %eax,%edx
  800edf:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	01 c8                	add    %ecx,%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eeb:	ff 45 fc             	incl   -0x4(%ebp)
  800eee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ef4:	7c e1                	jl     800ed7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ef6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800efd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f04:	eb 1f                	jmp    800f25 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f09:	8d 50 01             	lea    0x1(%eax),%edx
  800f0c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f0f:	89 c2                	mov    %eax,%edx
  800f11:	8b 45 10             	mov    0x10(%ebp),%eax
  800f14:	01 c2                	add    %eax,%edx
  800f16:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	01 c8                	add    %ecx,%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f22:	ff 45 f8             	incl   -0x8(%ebp)
  800f25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f28:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f2b:	7c d9                	jl     800f06 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f2d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f30:	8b 45 10             	mov    0x10(%ebp),%eax
  800f33:	01 d0                	add    %edx,%eax
  800f35:	c6 00 00             	movb   $0x0,(%eax)
}
  800f38:	90                   	nop
  800f39:	c9                   	leave  
  800f3a:	c3                   	ret    

00800f3b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f3b:	55                   	push   %ebp
  800f3c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f3e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f41:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f47:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4a:	8b 00                	mov    (%eax),%eax
  800f4c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f53:	8b 45 10             	mov    0x10(%ebp),%eax
  800f56:	01 d0                	add    %edx,%eax
  800f58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f5e:	eb 0c                	jmp    800f6c <strsplit+0x31>
			*string++ = 0;
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8d 50 01             	lea    0x1(%eax),%edx
  800f66:	89 55 08             	mov    %edx,0x8(%ebp)
  800f69:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	84 c0                	test   %al,%al
  800f73:	74 18                	je     800f8d <strsplit+0x52>
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	0f be c0             	movsbl %al,%eax
  800f7d:	50                   	push   %eax
  800f7e:	ff 75 0c             	pushl  0xc(%ebp)
  800f81:	e8 13 fb ff ff       	call   800a99 <strchr>
  800f86:	83 c4 08             	add    $0x8,%esp
  800f89:	85 c0                	test   %eax,%eax
  800f8b:	75 d3                	jne    800f60 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	84 c0                	test   %al,%al
  800f94:	74 5a                	je     800ff0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f96:	8b 45 14             	mov    0x14(%ebp),%eax
  800f99:	8b 00                	mov    (%eax),%eax
  800f9b:	83 f8 0f             	cmp    $0xf,%eax
  800f9e:	75 07                	jne    800fa7 <strsplit+0x6c>
		{
			return 0;
  800fa0:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa5:	eb 66                	jmp    80100d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fa7:	8b 45 14             	mov    0x14(%ebp),%eax
  800faa:	8b 00                	mov    (%eax),%eax
  800fac:	8d 48 01             	lea    0x1(%eax),%ecx
  800faf:	8b 55 14             	mov    0x14(%ebp),%edx
  800fb2:	89 0a                	mov    %ecx,(%edx)
  800fb4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbe:	01 c2                	add    %eax,%edx
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc5:	eb 03                	jmp    800fca <strsplit+0x8f>
			string++;
  800fc7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	84 c0                	test   %al,%al
  800fd1:	74 8b                	je     800f5e <strsplit+0x23>
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	0f be c0             	movsbl %al,%eax
  800fdb:	50                   	push   %eax
  800fdc:	ff 75 0c             	pushl  0xc(%ebp)
  800fdf:	e8 b5 fa ff ff       	call   800a99 <strchr>
  800fe4:	83 c4 08             	add    $0x8,%esp
  800fe7:	85 c0                	test   %eax,%eax
  800fe9:	74 dc                	je     800fc7 <strsplit+0x8c>
			string++;
	}
  800feb:	e9 6e ff ff ff       	jmp    800f5e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ff0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ff1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff4:	8b 00                	mov    (%eax),%eax
  800ff6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ffd:	8b 45 10             	mov    0x10(%ebp),%eax
  801000:	01 d0                	add    %edx,%eax
  801002:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801008:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80100d:	c9                   	leave  
  80100e:	c3                   	ret    

0080100f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80100f:	55                   	push   %ebp
  801010:	89 e5                	mov    %esp,%ebp
  801012:	57                   	push   %edi
  801013:	56                   	push   %esi
  801014:	53                   	push   %ebx
  801015:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80101e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801021:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801024:	8b 7d 18             	mov    0x18(%ebp),%edi
  801027:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80102a:	cd 30                	int    $0x30
  80102c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80102f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801032:	83 c4 10             	add    $0x10,%esp
  801035:	5b                   	pop    %ebx
  801036:	5e                   	pop    %esi
  801037:	5f                   	pop    %edi
  801038:	5d                   	pop    %ebp
  801039:	c3                   	ret    

0080103a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80103a:	55                   	push   %ebp
  80103b:	89 e5                	mov    %esp,%ebp
  80103d:	83 ec 04             	sub    $0x4,%esp
  801040:	8b 45 10             	mov    0x10(%ebp),%eax
  801043:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801046:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	6a 00                	push   $0x0
  80104f:	6a 00                	push   $0x0
  801051:	52                   	push   %edx
  801052:	ff 75 0c             	pushl  0xc(%ebp)
  801055:	50                   	push   %eax
  801056:	6a 00                	push   $0x0
  801058:	e8 b2 ff ff ff       	call   80100f <syscall>
  80105d:	83 c4 18             	add    $0x18,%esp
}
  801060:	90                   	nop
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <sys_cgetc>:

int
sys_cgetc(void)
{
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801066:	6a 00                	push   $0x0
  801068:	6a 00                	push   $0x0
  80106a:	6a 00                	push   $0x0
  80106c:	6a 00                	push   $0x0
  80106e:	6a 00                	push   $0x0
  801070:	6a 01                	push   $0x1
  801072:	e8 98 ff ff ff       	call   80100f <syscall>
  801077:	83 c4 18             	add    $0x18,%esp
}
  80107a:	c9                   	leave  
  80107b:	c3                   	ret    

0080107c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80107c:	55                   	push   %ebp
  80107d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	6a 00                	push   $0x0
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	6a 00                	push   $0x0
  80108a:	50                   	push   %eax
  80108b:	6a 05                	push   $0x5
  80108d:	e8 7d ff ff ff       	call   80100f <syscall>
  801092:	83 c4 18             	add    $0x18,%esp
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 00                	push   $0x0
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 02                	push   $0x2
  8010a6:	e8 64 ff ff ff       	call   80100f <syscall>
  8010ab:	83 c4 18             	add    $0x18,%esp
}
  8010ae:	c9                   	leave  
  8010af:	c3                   	ret    

008010b0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010b0:	55                   	push   %ebp
  8010b1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010b3:	6a 00                	push   $0x0
  8010b5:	6a 00                	push   $0x0
  8010b7:	6a 00                	push   $0x0
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 03                	push   $0x3
  8010bf:	e8 4b ff ff ff       	call   80100f <syscall>
  8010c4:	83 c4 18             	add    $0x18,%esp
}
  8010c7:	c9                   	leave  
  8010c8:	c3                   	ret    

008010c9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010c9:	55                   	push   %ebp
  8010ca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	6a 04                	push   $0x4
  8010d8:	e8 32 ff ff ff       	call   80100f <syscall>
  8010dd:	83 c4 18             	add    $0x18,%esp
}
  8010e0:	c9                   	leave  
  8010e1:	c3                   	ret    

008010e2 <sys_env_exit>:


void sys_env_exit(void)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 00                	push   $0x0
  8010e9:	6a 00                	push   $0x0
  8010eb:	6a 00                	push   $0x0
  8010ed:	6a 00                	push   $0x0
  8010ef:	6a 06                	push   $0x6
  8010f1:	e8 19 ff ff ff       	call   80100f <syscall>
  8010f6:	83 c4 18             	add    $0x18,%esp
}
  8010f9:	90                   	nop
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	6a 00                	push   $0x0
  801107:	6a 00                	push   $0x0
  801109:	6a 00                	push   $0x0
  80110b:	52                   	push   %edx
  80110c:	50                   	push   %eax
  80110d:	6a 07                	push   $0x7
  80110f:	e8 fb fe ff ff       	call   80100f <syscall>
  801114:	83 c4 18             	add    $0x18,%esp
}
  801117:	c9                   	leave  
  801118:	c3                   	ret    

00801119 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801119:	55                   	push   %ebp
  80111a:	89 e5                	mov    %esp,%ebp
  80111c:	56                   	push   %esi
  80111d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80111e:	8b 75 18             	mov    0x18(%ebp),%esi
  801121:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801124:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801127:	8b 55 0c             	mov    0xc(%ebp),%edx
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	56                   	push   %esi
  80112e:	53                   	push   %ebx
  80112f:	51                   	push   %ecx
  801130:	52                   	push   %edx
  801131:	50                   	push   %eax
  801132:	6a 08                	push   $0x8
  801134:	e8 d6 fe ff ff       	call   80100f <syscall>
  801139:	83 c4 18             	add    $0x18,%esp
}
  80113c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80113f:	5b                   	pop    %ebx
  801140:	5e                   	pop    %esi
  801141:	5d                   	pop    %ebp
  801142:	c3                   	ret    

00801143 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801146:	8b 55 0c             	mov    0xc(%ebp),%edx
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	6a 00                	push   $0x0
  80114e:	6a 00                	push   $0x0
  801150:	6a 00                	push   $0x0
  801152:	52                   	push   %edx
  801153:	50                   	push   %eax
  801154:	6a 09                	push   $0x9
  801156:	e8 b4 fe ff ff       	call   80100f <syscall>
  80115b:	83 c4 18             	add    $0x18,%esp
}
  80115e:	c9                   	leave  
  80115f:	c3                   	ret    

00801160 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801160:	55                   	push   %ebp
  801161:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801163:	6a 00                	push   $0x0
  801165:	6a 00                	push   $0x0
  801167:	6a 00                	push   $0x0
  801169:	ff 75 0c             	pushl  0xc(%ebp)
  80116c:	ff 75 08             	pushl  0x8(%ebp)
  80116f:	6a 0a                	push   $0xa
  801171:	e8 99 fe ff ff       	call   80100f <syscall>
  801176:	83 c4 18             	add    $0x18,%esp
}
  801179:	c9                   	leave  
  80117a:	c3                   	ret    

0080117b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80117b:	55                   	push   %ebp
  80117c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 00                	push   $0x0
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	6a 0b                	push   $0xb
  80118a:	e8 80 fe ff ff       	call   80100f <syscall>
  80118f:	83 c4 18             	add    $0x18,%esp
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801197:	6a 00                	push   $0x0
  801199:	6a 00                	push   $0x0
  80119b:	6a 00                	push   $0x0
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 0c                	push   $0xc
  8011a3:	e8 67 fe ff ff       	call   80100f <syscall>
  8011a8:	83 c4 18             	add    $0x18,%esp
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	6a 00                	push   $0x0
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 0d                	push   $0xd
  8011bc:	e8 4e fe ff ff       	call   80100f <syscall>
  8011c1:	83 c4 18             	add    $0x18,%esp
}
  8011c4:	c9                   	leave  
  8011c5:	c3                   	ret    

008011c6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 00                	push   $0x0
  8011cd:	6a 00                	push   $0x0
  8011cf:	ff 75 0c             	pushl  0xc(%ebp)
  8011d2:	ff 75 08             	pushl  0x8(%ebp)
  8011d5:	6a 11                	push   $0x11
  8011d7:	e8 33 fe ff ff       	call   80100f <syscall>
  8011dc:	83 c4 18             	add    $0x18,%esp
	return;
  8011df:	90                   	nop
}
  8011e0:	c9                   	leave  
  8011e1:	c3                   	ret    

008011e2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011e2:	55                   	push   %ebp
  8011e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	ff 75 0c             	pushl  0xc(%ebp)
  8011ee:	ff 75 08             	pushl  0x8(%ebp)
  8011f1:	6a 12                	push   $0x12
  8011f3:	e8 17 fe ff ff       	call   80100f <syscall>
  8011f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8011fb:	90                   	nop
}
  8011fc:	c9                   	leave  
  8011fd:	c3                   	ret    

008011fe <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	6a 00                	push   $0x0
  801209:	6a 00                	push   $0x0
  80120b:	6a 0e                	push   $0xe
  80120d:	e8 fd fd ff ff       	call   80100f <syscall>
  801212:	83 c4 18             	add    $0x18,%esp
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80121a:	6a 00                	push   $0x0
  80121c:	6a 00                	push   $0x0
  80121e:	6a 00                	push   $0x0
  801220:	6a 00                	push   $0x0
  801222:	ff 75 08             	pushl  0x8(%ebp)
  801225:	6a 0f                	push   $0xf
  801227:	e8 e3 fd ff ff       	call   80100f <syscall>
  80122c:	83 c4 18             	add    $0x18,%esp
}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	6a 00                	push   $0x0
  80123e:	6a 10                	push   $0x10
  801240:	e8 ca fd ff ff       	call   80100f <syscall>
  801245:	83 c4 18             	add    $0x18,%esp
}
  801248:	90                   	nop
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 00                	push   $0x0
  801256:	6a 00                	push   $0x0
  801258:	6a 14                	push   $0x14
  80125a:	e8 b0 fd ff ff       	call   80100f <syscall>
  80125f:	83 c4 18             	add    $0x18,%esp
}
  801262:	90                   	nop
  801263:	c9                   	leave  
  801264:	c3                   	ret    

00801265 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 15                	push   $0x15
  801274:	e8 96 fd ff ff       	call   80100f <syscall>
  801279:	83 c4 18             	add    $0x18,%esp
}
  80127c:	90                   	nop
  80127d:	c9                   	leave  
  80127e:	c3                   	ret    

0080127f <sys_cputc>:


void
sys_cputc(const char c)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
  801282:	83 ec 04             	sub    $0x4,%esp
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80128b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	50                   	push   %eax
  801298:	6a 16                	push   $0x16
  80129a:	e8 70 fd ff ff       	call   80100f <syscall>
  80129f:	83 c4 18             	add    $0x18,%esp
}
  8012a2:	90                   	nop
  8012a3:	c9                   	leave  
  8012a4:	c3                   	ret    

008012a5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012a5:	55                   	push   %ebp
  8012a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 17                	push   $0x17
  8012b4:	e8 56 fd ff ff       	call   80100f <syscall>
  8012b9:	83 c4 18             	add    $0x18,%esp
}
  8012bc:	90                   	nop
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	ff 75 0c             	pushl  0xc(%ebp)
  8012ce:	50                   	push   %eax
  8012cf:	6a 18                	push   $0x18
  8012d1:	e8 39 fd ff ff       	call   80100f <syscall>
  8012d6:	83 c4 18             	add    $0x18,%esp
}
  8012d9:	c9                   	leave  
  8012da:	c3                   	ret    

008012db <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012db:	55                   	push   %ebp
  8012dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	52                   	push   %edx
  8012eb:	50                   	push   %eax
  8012ec:	6a 1b                	push   $0x1b
  8012ee:	e8 1c fd ff ff       	call   80100f <syscall>
  8012f3:	83 c4 18             	add    $0x18,%esp
}
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	52                   	push   %edx
  801308:	50                   	push   %eax
  801309:	6a 19                	push   $0x19
  80130b:	e8 ff fc ff ff       	call   80100f <syscall>
  801310:	83 c4 18             	add    $0x18,%esp
}
  801313:	90                   	nop
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801319:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	52                   	push   %edx
  801326:	50                   	push   %eax
  801327:	6a 1a                	push   $0x1a
  801329:	e8 e1 fc ff ff       	call   80100f <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	90                   	nop
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
  801337:	83 ec 04             	sub    $0x4,%esp
  80133a:	8b 45 10             	mov    0x10(%ebp),%eax
  80133d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801340:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801343:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	6a 00                	push   $0x0
  80134c:	51                   	push   %ecx
  80134d:	52                   	push   %edx
  80134e:	ff 75 0c             	pushl  0xc(%ebp)
  801351:	50                   	push   %eax
  801352:	6a 1c                	push   $0x1c
  801354:	e8 b6 fc ff ff       	call   80100f <syscall>
  801359:	83 c4 18             	add    $0x18,%esp
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801361:	8b 55 0c             	mov    0xc(%ebp),%edx
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	52                   	push   %edx
  80136e:	50                   	push   %eax
  80136f:	6a 1d                	push   $0x1d
  801371:	e8 99 fc ff ff       	call   80100f <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80137e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801381:	8b 55 0c             	mov    0xc(%ebp),%edx
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	51                   	push   %ecx
  80138c:	52                   	push   %edx
  80138d:	50                   	push   %eax
  80138e:	6a 1e                	push   $0x1e
  801390:	e8 7a fc ff ff       	call   80100f <syscall>
  801395:	83 c4 18             	add    $0x18,%esp
}
  801398:	c9                   	leave  
  801399:	c3                   	ret    

0080139a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80139a:	55                   	push   %ebp
  80139b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80139d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	52                   	push   %edx
  8013aa:	50                   	push   %eax
  8013ab:	6a 1f                	push   $0x1f
  8013ad:	e8 5d fc ff ff       	call   80100f <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 20                	push   $0x20
  8013c6:	e8 44 fc ff ff       	call   80100f <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	ff 75 10             	pushl  0x10(%ebp)
  8013dd:	ff 75 0c             	pushl  0xc(%ebp)
  8013e0:	50                   	push   %eax
  8013e1:	6a 21                	push   $0x21
  8013e3:	e8 27 fc ff ff       	call   80100f <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
}
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	50                   	push   %eax
  8013fc:	6a 22                	push   $0x22
  8013fe:	e8 0c fc ff ff       	call   80100f <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	90                   	nop
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	50                   	push   %eax
  801418:	6a 23                	push   $0x23
  80141a:	e8 f0 fb ff ff       	call   80100f <syscall>
  80141f:	83 c4 18             	add    $0x18,%esp
}
  801422:	90                   	nop
  801423:	c9                   	leave  
  801424:	c3                   	ret    

00801425 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
  801428:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80142b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80142e:	8d 50 04             	lea    0x4(%eax),%edx
  801431:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	52                   	push   %edx
  80143b:	50                   	push   %eax
  80143c:	6a 24                	push   $0x24
  80143e:	e8 cc fb ff ff       	call   80100f <syscall>
  801443:	83 c4 18             	add    $0x18,%esp
	return result;
  801446:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801449:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80144c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80144f:	89 01                	mov    %eax,(%ecx)
  801451:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	c9                   	leave  
  801458:	c2 04 00             	ret    $0x4

0080145b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	ff 75 10             	pushl  0x10(%ebp)
  801465:	ff 75 0c             	pushl  0xc(%ebp)
  801468:	ff 75 08             	pushl  0x8(%ebp)
  80146b:	6a 13                	push   $0x13
  80146d:	e8 9d fb ff ff       	call   80100f <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
	return ;
  801475:	90                   	nop
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_rcr2>:
uint32 sys_rcr2()
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 25                	push   $0x25
  801487:	e8 83 fb ff ff       	call   80100f <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
  801494:	83 ec 04             	sub    $0x4,%esp
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80149d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	50                   	push   %eax
  8014aa:	6a 26                	push   $0x26
  8014ac:	e8 5e fb ff ff       	call   80100f <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b4:	90                   	nop
}
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <rsttst>:
void rsttst()
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 28                	push   $0x28
  8014c6:	e8 44 fb ff ff       	call   80100f <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ce:	90                   	nop
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 04             	sub    $0x4,%esp
  8014d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014da:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014dd:	8b 55 18             	mov    0x18(%ebp),%edx
  8014e0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e4:	52                   	push   %edx
  8014e5:	50                   	push   %eax
  8014e6:	ff 75 10             	pushl  0x10(%ebp)
  8014e9:	ff 75 0c             	pushl  0xc(%ebp)
  8014ec:	ff 75 08             	pushl  0x8(%ebp)
  8014ef:	6a 27                	push   $0x27
  8014f1:	e8 19 fb ff ff       	call   80100f <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f9:	90                   	nop
}
  8014fa:	c9                   	leave  
  8014fb:	c3                   	ret    

008014fc <chktst>:
void chktst(uint32 n)
{
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	6a 29                	push   $0x29
  80150c:	e8 fe fa ff ff       	call   80100f <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
	return ;
  801514:	90                   	nop
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <inctst>:

void inctst()
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 2a                	push   $0x2a
  801526:	e8 e4 fa ff ff       	call   80100f <syscall>
  80152b:	83 c4 18             	add    $0x18,%esp
	return ;
  80152e:	90                   	nop
}
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <gettst>:
uint32 gettst()
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 2b                	push   $0x2b
  801540:	e8 ca fa ff ff       	call   80100f <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
  80154d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 2c                	push   $0x2c
  80155c:	e8 ae fa ff ff       	call   80100f <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
  801564:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801567:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80156b:	75 07                	jne    801574 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80156d:	b8 01 00 00 00       	mov    $0x1,%eax
  801572:	eb 05                	jmp    801579 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801574:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
  80157e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 2c                	push   $0x2c
  80158d:	e8 7d fa ff ff       	call   80100f <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
  801595:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801598:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80159c:	75 07                	jne    8015a5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80159e:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a3:	eb 05                	jmp    8015aa <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
  8015af:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 2c                	push   $0x2c
  8015be:	e8 4c fa ff ff       	call   80100f <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
  8015c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015c9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015cd:	75 07                	jne    8015d6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015cf:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d4:	eb 05                	jmp    8015db <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 2c                	push   $0x2c
  8015ef:	e8 1b fa ff ff       	call   80100f <syscall>
  8015f4:	83 c4 18             	add    $0x18,%esp
  8015f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015fa:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015fe:	75 07                	jne    801607 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801600:	b8 01 00 00 00       	mov    $0x1,%eax
  801605:	eb 05                	jmp    80160c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801607:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	ff 75 08             	pushl  0x8(%ebp)
  80161c:	6a 2d                	push   $0x2d
  80161e:	e8 ec f9 ff ff       	call   80100f <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
	return ;
  801626:	90                   	nop
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    
  801629:	66 90                	xchg   %ax,%ax
  80162b:	90                   	nop

0080162c <__udivdi3>:
  80162c:	55                   	push   %ebp
  80162d:	57                   	push   %edi
  80162e:	56                   	push   %esi
  80162f:	53                   	push   %ebx
  801630:	83 ec 1c             	sub    $0x1c,%esp
  801633:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801637:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80163b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80163f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801643:	89 ca                	mov    %ecx,%edx
  801645:	89 f8                	mov    %edi,%eax
  801647:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80164b:	85 f6                	test   %esi,%esi
  80164d:	75 2d                	jne    80167c <__udivdi3+0x50>
  80164f:	39 cf                	cmp    %ecx,%edi
  801651:	77 65                	ja     8016b8 <__udivdi3+0x8c>
  801653:	89 fd                	mov    %edi,%ebp
  801655:	85 ff                	test   %edi,%edi
  801657:	75 0b                	jne    801664 <__udivdi3+0x38>
  801659:	b8 01 00 00 00       	mov    $0x1,%eax
  80165e:	31 d2                	xor    %edx,%edx
  801660:	f7 f7                	div    %edi
  801662:	89 c5                	mov    %eax,%ebp
  801664:	31 d2                	xor    %edx,%edx
  801666:	89 c8                	mov    %ecx,%eax
  801668:	f7 f5                	div    %ebp
  80166a:	89 c1                	mov    %eax,%ecx
  80166c:	89 d8                	mov    %ebx,%eax
  80166e:	f7 f5                	div    %ebp
  801670:	89 cf                	mov    %ecx,%edi
  801672:	89 fa                	mov    %edi,%edx
  801674:	83 c4 1c             	add    $0x1c,%esp
  801677:	5b                   	pop    %ebx
  801678:	5e                   	pop    %esi
  801679:	5f                   	pop    %edi
  80167a:	5d                   	pop    %ebp
  80167b:	c3                   	ret    
  80167c:	39 ce                	cmp    %ecx,%esi
  80167e:	77 28                	ja     8016a8 <__udivdi3+0x7c>
  801680:	0f bd fe             	bsr    %esi,%edi
  801683:	83 f7 1f             	xor    $0x1f,%edi
  801686:	75 40                	jne    8016c8 <__udivdi3+0x9c>
  801688:	39 ce                	cmp    %ecx,%esi
  80168a:	72 0a                	jb     801696 <__udivdi3+0x6a>
  80168c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801690:	0f 87 9e 00 00 00    	ja     801734 <__udivdi3+0x108>
  801696:	b8 01 00 00 00       	mov    $0x1,%eax
  80169b:	89 fa                	mov    %edi,%edx
  80169d:	83 c4 1c             	add    $0x1c,%esp
  8016a0:	5b                   	pop    %ebx
  8016a1:	5e                   	pop    %esi
  8016a2:	5f                   	pop    %edi
  8016a3:	5d                   	pop    %ebp
  8016a4:	c3                   	ret    
  8016a5:	8d 76 00             	lea    0x0(%esi),%esi
  8016a8:	31 ff                	xor    %edi,%edi
  8016aa:	31 c0                	xor    %eax,%eax
  8016ac:	89 fa                	mov    %edi,%edx
  8016ae:	83 c4 1c             	add    $0x1c,%esp
  8016b1:	5b                   	pop    %ebx
  8016b2:	5e                   	pop    %esi
  8016b3:	5f                   	pop    %edi
  8016b4:	5d                   	pop    %ebp
  8016b5:	c3                   	ret    
  8016b6:	66 90                	xchg   %ax,%ax
  8016b8:	89 d8                	mov    %ebx,%eax
  8016ba:	f7 f7                	div    %edi
  8016bc:	31 ff                	xor    %edi,%edi
  8016be:	89 fa                	mov    %edi,%edx
  8016c0:	83 c4 1c             	add    $0x1c,%esp
  8016c3:	5b                   	pop    %ebx
  8016c4:	5e                   	pop    %esi
  8016c5:	5f                   	pop    %edi
  8016c6:	5d                   	pop    %ebp
  8016c7:	c3                   	ret    
  8016c8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016cd:	89 eb                	mov    %ebp,%ebx
  8016cf:	29 fb                	sub    %edi,%ebx
  8016d1:	89 f9                	mov    %edi,%ecx
  8016d3:	d3 e6                	shl    %cl,%esi
  8016d5:	89 c5                	mov    %eax,%ebp
  8016d7:	88 d9                	mov    %bl,%cl
  8016d9:	d3 ed                	shr    %cl,%ebp
  8016db:	89 e9                	mov    %ebp,%ecx
  8016dd:	09 f1                	or     %esi,%ecx
  8016df:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016e3:	89 f9                	mov    %edi,%ecx
  8016e5:	d3 e0                	shl    %cl,%eax
  8016e7:	89 c5                	mov    %eax,%ebp
  8016e9:	89 d6                	mov    %edx,%esi
  8016eb:	88 d9                	mov    %bl,%cl
  8016ed:	d3 ee                	shr    %cl,%esi
  8016ef:	89 f9                	mov    %edi,%ecx
  8016f1:	d3 e2                	shl    %cl,%edx
  8016f3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016f7:	88 d9                	mov    %bl,%cl
  8016f9:	d3 e8                	shr    %cl,%eax
  8016fb:	09 c2                	or     %eax,%edx
  8016fd:	89 d0                	mov    %edx,%eax
  8016ff:	89 f2                	mov    %esi,%edx
  801701:	f7 74 24 0c          	divl   0xc(%esp)
  801705:	89 d6                	mov    %edx,%esi
  801707:	89 c3                	mov    %eax,%ebx
  801709:	f7 e5                	mul    %ebp
  80170b:	39 d6                	cmp    %edx,%esi
  80170d:	72 19                	jb     801728 <__udivdi3+0xfc>
  80170f:	74 0b                	je     80171c <__udivdi3+0xf0>
  801711:	89 d8                	mov    %ebx,%eax
  801713:	31 ff                	xor    %edi,%edi
  801715:	e9 58 ff ff ff       	jmp    801672 <__udivdi3+0x46>
  80171a:	66 90                	xchg   %ax,%ax
  80171c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801720:	89 f9                	mov    %edi,%ecx
  801722:	d3 e2                	shl    %cl,%edx
  801724:	39 c2                	cmp    %eax,%edx
  801726:	73 e9                	jae    801711 <__udivdi3+0xe5>
  801728:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80172b:	31 ff                	xor    %edi,%edi
  80172d:	e9 40 ff ff ff       	jmp    801672 <__udivdi3+0x46>
  801732:	66 90                	xchg   %ax,%ax
  801734:	31 c0                	xor    %eax,%eax
  801736:	e9 37 ff ff ff       	jmp    801672 <__udivdi3+0x46>
  80173b:	90                   	nop

0080173c <__umoddi3>:
  80173c:	55                   	push   %ebp
  80173d:	57                   	push   %edi
  80173e:	56                   	push   %esi
  80173f:	53                   	push   %ebx
  801740:	83 ec 1c             	sub    $0x1c,%esp
  801743:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801747:	8b 74 24 34          	mov    0x34(%esp),%esi
  80174b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80174f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801753:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801757:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80175b:	89 f3                	mov    %esi,%ebx
  80175d:	89 fa                	mov    %edi,%edx
  80175f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801763:	89 34 24             	mov    %esi,(%esp)
  801766:	85 c0                	test   %eax,%eax
  801768:	75 1a                	jne    801784 <__umoddi3+0x48>
  80176a:	39 f7                	cmp    %esi,%edi
  80176c:	0f 86 a2 00 00 00    	jbe    801814 <__umoddi3+0xd8>
  801772:	89 c8                	mov    %ecx,%eax
  801774:	89 f2                	mov    %esi,%edx
  801776:	f7 f7                	div    %edi
  801778:	89 d0                	mov    %edx,%eax
  80177a:	31 d2                	xor    %edx,%edx
  80177c:	83 c4 1c             	add    $0x1c,%esp
  80177f:	5b                   	pop    %ebx
  801780:	5e                   	pop    %esi
  801781:	5f                   	pop    %edi
  801782:	5d                   	pop    %ebp
  801783:	c3                   	ret    
  801784:	39 f0                	cmp    %esi,%eax
  801786:	0f 87 ac 00 00 00    	ja     801838 <__umoddi3+0xfc>
  80178c:	0f bd e8             	bsr    %eax,%ebp
  80178f:	83 f5 1f             	xor    $0x1f,%ebp
  801792:	0f 84 ac 00 00 00    	je     801844 <__umoddi3+0x108>
  801798:	bf 20 00 00 00       	mov    $0x20,%edi
  80179d:	29 ef                	sub    %ebp,%edi
  80179f:	89 fe                	mov    %edi,%esi
  8017a1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017a5:	89 e9                	mov    %ebp,%ecx
  8017a7:	d3 e0                	shl    %cl,%eax
  8017a9:	89 d7                	mov    %edx,%edi
  8017ab:	89 f1                	mov    %esi,%ecx
  8017ad:	d3 ef                	shr    %cl,%edi
  8017af:	09 c7                	or     %eax,%edi
  8017b1:	89 e9                	mov    %ebp,%ecx
  8017b3:	d3 e2                	shl    %cl,%edx
  8017b5:	89 14 24             	mov    %edx,(%esp)
  8017b8:	89 d8                	mov    %ebx,%eax
  8017ba:	d3 e0                	shl    %cl,%eax
  8017bc:	89 c2                	mov    %eax,%edx
  8017be:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017c2:	d3 e0                	shl    %cl,%eax
  8017c4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017c8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017cc:	89 f1                	mov    %esi,%ecx
  8017ce:	d3 e8                	shr    %cl,%eax
  8017d0:	09 d0                	or     %edx,%eax
  8017d2:	d3 eb                	shr    %cl,%ebx
  8017d4:	89 da                	mov    %ebx,%edx
  8017d6:	f7 f7                	div    %edi
  8017d8:	89 d3                	mov    %edx,%ebx
  8017da:	f7 24 24             	mull   (%esp)
  8017dd:	89 c6                	mov    %eax,%esi
  8017df:	89 d1                	mov    %edx,%ecx
  8017e1:	39 d3                	cmp    %edx,%ebx
  8017e3:	0f 82 87 00 00 00    	jb     801870 <__umoddi3+0x134>
  8017e9:	0f 84 91 00 00 00    	je     801880 <__umoddi3+0x144>
  8017ef:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017f3:	29 f2                	sub    %esi,%edx
  8017f5:	19 cb                	sbb    %ecx,%ebx
  8017f7:	89 d8                	mov    %ebx,%eax
  8017f9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017fd:	d3 e0                	shl    %cl,%eax
  8017ff:	89 e9                	mov    %ebp,%ecx
  801801:	d3 ea                	shr    %cl,%edx
  801803:	09 d0                	or     %edx,%eax
  801805:	89 e9                	mov    %ebp,%ecx
  801807:	d3 eb                	shr    %cl,%ebx
  801809:	89 da                	mov    %ebx,%edx
  80180b:	83 c4 1c             	add    $0x1c,%esp
  80180e:	5b                   	pop    %ebx
  80180f:	5e                   	pop    %esi
  801810:	5f                   	pop    %edi
  801811:	5d                   	pop    %ebp
  801812:	c3                   	ret    
  801813:	90                   	nop
  801814:	89 fd                	mov    %edi,%ebp
  801816:	85 ff                	test   %edi,%edi
  801818:	75 0b                	jne    801825 <__umoddi3+0xe9>
  80181a:	b8 01 00 00 00       	mov    $0x1,%eax
  80181f:	31 d2                	xor    %edx,%edx
  801821:	f7 f7                	div    %edi
  801823:	89 c5                	mov    %eax,%ebp
  801825:	89 f0                	mov    %esi,%eax
  801827:	31 d2                	xor    %edx,%edx
  801829:	f7 f5                	div    %ebp
  80182b:	89 c8                	mov    %ecx,%eax
  80182d:	f7 f5                	div    %ebp
  80182f:	89 d0                	mov    %edx,%eax
  801831:	e9 44 ff ff ff       	jmp    80177a <__umoddi3+0x3e>
  801836:	66 90                	xchg   %ax,%ax
  801838:	89 c8                	mov    %ecx,%eax
  80183a:	89 f2                	mov    %esi,%edx
  80183c:	83 c4 1c             	add    $0x1c,%esp
  80183f:	5b                   	pop    %ebx
  801840:	5e                   	pop    %esi
  801841:	5f                   	pop    %edi
  801842:	5d                   	pop    %ebp
  801843:	c3                   	ret    
  801844:	3b 04 24             	cmp    (%esp),%eax
  801847:	72 06                	jb     80184f <__umoddi3+0x113>
  801849:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80184d:	77 0f                	ja     80185e <__umoddi3+0x122>
  80184f:	89 f2                	mov    %esi,%edx
  801851:	29 f9                	sub    %edi,%ecx
  801853:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801857:	89 14 24             	mov    %edx,(%esp)
  80185a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80185e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801862:	8b 14 24             	mov    (%esp),%edx
  801865:	83 c4 1c             	add    $0x1c,%esp
  801868:	5b                   	pop    %ebx
  801869:	5e                   	pop    %esi
  80186a:	5f                   	pop    %edi
  80186b:	5d                   	pop    %ebp
  80186c:	c3                   	ret    
  80186d:	8d 76 00             	lea    0x0(%esi),%esi
  801870:	2b 04 24             	sub    (%esp),%eax
  801873:	19 fa                	sbb    %edi,%edx
  801875:	89 d1                	mov    %edx,%ecx
  801877:	89 c6                	mov    %eax,%esi
  801879:	e9 71 ff ff ff       	jmp    8017ef <__umoddi3+0xb3>
  80187e:	66 90                	xchg   %ax,%ax
  801880:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801884:	72 ea                	jb     801870 <__umoddi3+0x134>
  801886:	89 d9                	mov    %ebx,%ecx
  801888:	e9 62 ff ff ff       	jmp    8017ef <__umoddi3+0xb3>
