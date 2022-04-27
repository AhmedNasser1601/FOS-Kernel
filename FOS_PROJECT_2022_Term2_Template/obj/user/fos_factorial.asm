
obj/user/fos_factorial:     file format elf32-i386


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
  800031:	e8 95 00 00 00       	call   8000cb <libmain>
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
	atomic_readline("Please enter a number:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 60 1b 80 00       	push   $0x801b60
  800057:	e8 d2 09 00 00       	call   800a2e <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 24 0e 00 00       	call   800e96 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = factorial(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <factorial>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 77 1b 80 00       	push   $0x801b77
  800097:	e8 3f 02 00 00       	call   8002db <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <factorial>:


int factorial(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  8000a8:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ac:	7f 07                	jg     8000b5 <factorial+0x13>
		return 1 ;
  8000ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b3:	eb 14                	jmp    8000c9 <factorial+0x27>
	return n * factorial(n-1) ;
  8000b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b8:	48                   	dec    %eax
  8000b9:	83 ec 0c             	sub    $0xc,%esp
  8000bc:	50                   	push   %eax
  8000bd:	e8 e0 ff ff ff       	call   8000a2 <factorial>
  8000c2:	83 c4 10             	add    $0x10,%esp
  8000c5:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000c9:	c9                   	leave  
  8000ca:	c3                   	ret    

008000cb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000cb:	55                   	push   %ebp
  8000cc:	89 e5                	mov    %esp,%ebp
  8000ce:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d1:	e8 09 12 00 00       	call   8012df <sys_getenvindex>
  8000d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000dc:	89 d0                	mov    %edx,%eax
  8000de:	c1 e0 02             	shl    $0x2,%eax
  8000e1:	01 d0                	add    %edx,%eax
  8000e3:	01 c0                	add    %eax,%eax
  8000e5:	01 d0                	add    %edx,%eax
  8000e7:	01 c0                	add    %eax,%eax
  8000e9:	01 d0                	add    %edx,%eax
  8000eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000f2:	01 d0                	add    %edx,%eax
  8000f4:	c1 e0 02             	shl    $0x2,%eax
  8000f7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000fc:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800101:	a1 04 20 80 00       	mov    0x802004,%eax
  800106:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80010c:	84 c0                	test   %al,%al
  80010e:	74 0f                	je     80011f <libmain+0x54>
		binaryname = myEnv->prog_name;
  800110:	a1 04 20 80 00       	mov    0x802004,%eax
  800115:	05 f4 02 00 00       	add    $0x2f4,%eax
  80011a:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80011f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800123:	7e 0a                	jle    80012f <libmain+0x64>
		binaryname = argv[0];
  800125:	8b 45 0c             	mov    0xc(%ebp),%eax
  800128:	8b 00                	mov    (%eax),%eax
  80012a:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80012f:	83 ec 08             	sub    $0x8,%esp
  800132:	ff 75 0c             	pushl  0xc(%ebp)
  800135:	ff 75 08             	pushl  0x8(%ebp)
  800138:	e8 fb fe ff ff       	call   800038 <_main>
  80013d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800140:	e8 35 13 00 00       	call   80147a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800145:	83 ec 0c             	sub    $0xc,%esp
  800148:	68 a4 1b 80 00       	push   $0x801ba4
  80014d:	e8 5c 01 00 00       	call   8002ae <cprintf>
  800152:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800155:	a1 04 20 80 00       	mov    0x802004,%eax
  80015a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800160:	a1 04 20 80 00       	mov    0x802004,%eax
  800165:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	52                   	push   %edx
  80016f:	50                   	push   %eax
  800170:	68 cc 1b 80 00       	push   $0x801bcc
  800175:	e8 34 01 00 00       	call   8002ae <cprintf>
  80017a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80017d:	a1 04 20 80 00       	mov    0x802004,%eax
  800182:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800188:	83 ec 08             	sub    $0x8,%esp
  80018b:	50                   	push   %eax
  80018c:	68 f1 1b 80 00       	push   $0x801bf1
  800191:	e8 18 01 00 00       	call   8002ae <cprintf>
  800196:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800199:	83 ec 0c             	sub    $0xc,%esp
  80019c:	68 a4 1b 80 00       	push   $0x801ba4
  8001a1:	e8 08 01 00 00       	call   8002ae <cprintf>
  8001a6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001a9:	e8 e6 12 00 00       	call   801494 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001ae:	e8 19 00 00 00       	call   8001cc <exit>
}
  8001b3:	90                   	nop
  8001b4:	c9                   	leave  
  8001b5:	c3                   	ret    

008001b6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b6:	55                   	push   %ebp
  8001b7:	89 e5                	mov    %esp,%ebp
  8001b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001bc:	83 ec 0c             	sub    $0xc,%esp
  8001bf:	6a 00                	push   $0x0
  8001c1:	e8 e5 10 00 00       	call   8012ab <sys_env_destroy>
  8001c6:	83 c4 10             	add    $0x10,%esp
}
  8001c9:	90                   	nop
  8001ca:	c9                   	leave  
  8001cb:	c3                   	ret    

008001cc <exit>:

void
exit(void)
{
  8001cc:	55                   	push   %ebp
  8001cd:	89 e5                	mov    %esp,%ebp
  8001cf:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001d2:	e8 3a 11 00 00       	call   801311 <sys_env_exit>
}
  8001d7:	90                   	nop
  8001d8:	c9                   	leave  
  8001d9:	c3                   	ret    

008001da <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001da:	55                   	push   %ebp
  8001db:	89 e5                	mov    %esp,%ebp
  8001dd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e3:	8b 00                	mov    (%eax),%eax
  8001e5:	8d 48 01             	lea    0x1(%eax),%ecx
  8001e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001eb:	89 0a                	mov    %ecx,(%edx)
  8001ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f0:	88 d1                	mov    %dl,%cl
  8001f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	3d ff 00 00 00       	cmp    $0xff,%eax
  800203:	75 2c                	jne    800231 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800205:	a0 08 20 80 00       	mov    0x802008,%al
  80020a:	0f b6 c0             	movzbl %al,%eax
  80020d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800210:	8b 12                	mov    (%edx),%edx
  800212:	89 d1                	mov    %edx,%ecx
  800214:	8b 55 0c             	mov    0xc(%ebp),%edx
  800217:	83 c2 08             	add    $0x8,%edx
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	50                   	push   %eax
  80021e:	51                   	push   %ecx
  80021f:	52                   	push   %edx
  800220:	e8 44 10 00 00       	call   801269 <sys_cputs>
  800225:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800231:	8b 45 0c             	mov    0xc(%ebp),%eax
  800234:	8b 40 04             	mov    0x4(%eax),%eax
  800237:	8d 50 01             	lea    0x1(%eax),%edx
  80023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800240:	90                   	nop
  800241:	c9                   	leave  
  800242:	c3                   	ret    

00800243 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800243:	55                   	push   %ebp
  800244:	89 e5                	mov    %esp,%ebp
  800246:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80024c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800253:	00 00 00 
	b.cnt = 0;
  800256:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80025d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800260:	ff 75 0c             	pushl  0xc(%ebp)
  800263:	ff 75 08             	pushl  0x8(%ebp)
  800266:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026c:	50                   	push   %eax
  80026d:	68 da 01 80 00       	push   $0x8001da
  800272:	e8 11 02 00 00       	call   800488 <vprintfmt>
  800277:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80027a:	a0 08 20 80 00       	mov    0x802008,%al
  80027f:	0f b6 c0             	movzbl %al,%eax
  800282:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800288:	83 ec 04             	sub    $0x4,%esp
  80028b:	50                   	push   %eax
  80028c:	52                   	push   %edx
  80028d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800293:	83 c0 08             	add    $0x8,%eax
  800296:	50                   	push   %eax
  800297:	e8 cd 0f 00 00       	call   801269 <sys_cputs>
  80029c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80029f:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  8002a6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002ac:	c9                   	leave  
  8002ad:	c3                   	ret    

008002ae <cprintf>:

int cprintf(const char *fmt, ...) {
  8002ae:	55                   	push   %ebp
  8002af:	89 e5                	mov    %esp,%ebp
  8002b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b4:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002bb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c4:	83 ec 08             	sub    $0x8,%esp
  8002c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ca:	50                   	push   %eax
  8002cb:	e8 73 ff ff ff       	call   800243 <vcprintf>
  8002d0:	83 c4 10             	add    $0x10,%esp
  8002d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d9:	c9                   	leave  
  8002da:	c3                   	ret    

008002db <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002db:	55                   	push   %ebp
  8002dc:	89 e5                	mov    %esp,%ebp
  8002de:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002e1:	e8 94 11 00 00       	call   80147a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ef:	83 ec 08             	sub    $0x8,%esp
  8002f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f5:	50                   	push   %eax
  8002f6:	e8 48 ff ff ff       	call   800243 <vcprintf>
  8002fb:	83 c4 10             	add    $0x10,%esp
  8002fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800301:	e8 8e 11 00 00       	call   801494 <sys_enable_interrupt>
	return cnt;
  800306:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800309:	c9                   	leave  
  80030a:	c3                   	ret    

0080030b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80030b:	55                   	push   %ebp
  80030c:	89 e5                	mov    %esp,%ebp
  80030e:	53                   	push   %ebx
  80030f:	83 ec 14             	sub    $0x14,%esp
  800312:	8b 45 10             	mov    0x10(%ebp),%eax
  800315:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800318:	8b 45 14             	mov    0x14(%ebp),%eax
  80031b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80031e:	8b 45 18             	mov    0x18(%ebp),%eax
  800321:	ba 00 00 00 00       	mov    $0x0,%edx
  800326:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800329:	77 55                	ja     800380 <printnum+0x75>
  80032b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032e:	72 05                	jb     800335 <printnum+0x2a>
  800330:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800333:	77 4b                	ja     800380 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800335:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800338:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80033b:	8b 45 18             	mov    0x18(%ebp),%eax
  80033e:	ba 00 00 00 00       	mov    $0x0,%edx
  800343:	52                   	push   %edx
  800344:	50                   	push   %eax
  800345:	ff 75 f4             	pushl  -0xc(%ebp)
  800348:	ff 75 f0             	pushl  -0x10(%ebp)
  80034b:	e8 a8 15 00 00       	call   8018f8 <__udivdi3>
  800350:	83 c4 10             	add    $0x10,%esp
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	ff 75 20             	pushl  0x20(%ebp)
  800359:	53                   	push   %ebx
  80035a:	ff 75 18             	pushl  0x18(%ebp)
  80035d:	52                   	push   %edx
  80035e:	50                   	push   %eax
  80035f:	ff 75 0c             	pushl  0xc(%ebp)
  800362:	ff 75 08             	pushl  0x8(%ebp)
  800365:	e8 a1 ff ff ff       	call   80030b <printnum>
  80036a:	83 c4 20             	add    $0x20,%esp
  80036d:	eb 1a                	jmp    800389 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80036f:	83 ec 08             	sub    $0x8,%esp
  800372:	ff 75 0c             	pushl  0xc(%ebp)
  800375:	ff 75 20             	pushl  0x20(%ebp)
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	ff d0                	call   *%eax
  80037d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800380:	ff 4d 1c             	decl   0x1c(%ebp)
  800383:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800387:	7f e6                	jg     80036f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800389:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80038c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800391:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800394:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800397:	53                   	push   %ebx
  800398:	51                   	push   %ecx
  800399:	52                   	push   %edx
  80039a:	50                   	push   %eax
  80039b:	e8 68 16 00 00       	call   801a08 <__umoddi3>
  8003a0:	83 c4 10             	add    $0x10,%esp
  8003a3:	05 34 1e 80 00       	add    $0x801e34,%eax
  8003a8:	8a 00                	mov    (%eax),%al
  8003aa:	0f be c0             	movsbl %al,%eax
  8003ad:	83 ec 08             	sub    $0x8,%esp
  8003b0:	ff 75 0c             	pushl  0xc(%ebp)
  8003b3:	50                   	push   %eax
  8003b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b7:	ff d0                	call   *%eax
  8003b9:	83 c4 10             	add    $0x10,%esp
}
  8003bc:	90                   	nop
  8003bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c0:	c9                   	leave  
  8003c1:	c3                   	ret    

008003c2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003c2:	55                   	push   %ebp
  8003c3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c9:	7e 1c                	jle    8003e7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	8b 00                	mov    (%eax),%eax
  8003d0:	8d 50 08             	lea    0x8(%eax),%edx
  8003d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d6:	89 10                	mov    %edx,(%eax)
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	83 e8 08             	sub    $0x8,%eax
  8003e0:	8b 50 04             	mov    0x4(%eax),%edx
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	eb 40                	jmp    800427 <getuint+0x65>
	else if (lflag)
  8003e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003eb:	74 1e                	je     80040b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f0:	8b 00                	mov    (%eax),%eax
  8003f2:	8d 50 04             	lea    0x4(%eax),%edx
  8003f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f8:	89 10                	mov    %edx,(%eax)
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	8b 00                	mov    (%eax),%eax
  8003ff:	83 e8 04             	sub    $0x4,%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	ba 00 00 00 00       	mov    $0x0,%edx
  800409:	eb 1c                	jmp    800427 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	8b 00                	mov    (%eax),%eax
  800410:	8d 50 04             	lea    0x4(%eax),%edx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	89 10                	mov    %edx,(%eax)
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	83 e8 04             	sub    $0x4,%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800427:	5d                   	pop    %ebp
  800428:	c3                   	ret    

00800429 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800429:	55                   	push   %ebp
  80042a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80042c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800430:	7e 1c                	jle    80044e <getint+0x25>
		return va_arg(*ap, long long);
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	8d 50 08             	lea    0x8(%eax),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	89 10                	mov    %edx,(%eax)
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	83 e8 08             	sub    $0x8,%eax
  800447:	8b 50 04             	mov    0x4(%eax),%edx
  80044a:	8b 00                	mov    (%eax),%eax
  80044c:	eb 38                	jmp    800486 <getint+0x5d>
	else if (lflag)
  80044e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800452:	74 1a                	je     80046e <getint+0x45>
		return va_arg(*ap, long);
  800454:	8b 45 08             	mov    0x8(%ebp),%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	8d 50 04             	lea    0x4(%eax),%edx
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	89 10                	mov    %edx,(%eax)
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	83 e8 04             	sub    $0x4,%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	99                   	cltd   
  80046c:	eb 18                	jmp    800486 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	8d 50 04             	lea    0x4(%eax),%edx
  800476:	8b 45 08             	mov    0x8(%ebp),%eax
  800479:	89 10                	mov    %edx,(%eax)
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	8b 00                	mov    (%eax),%eax
  800480:	83 e8 04             	sub    $0x4,%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	99                   	cltd   
}
  800486:	5d                   	pop    %ebp
  800487:	c3                   	ret    

00800488 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800488:	55                   	push   %ebp
  800489:	89 e5                	mov    %esp,%ebp
  80048b:	56                   	push   %esi
  80048c:	53                   	push   %ebx
  80048d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800490:	eb 17                	jmp    8004a9 <vprintfmt+0x21>
			if (ch == '\0')
  800492:	85 db                	test   %ebx,%ebx
  800494:	0f 84 af 03 00 00    	je     800849 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80049a:	83 ec 08             	sub    $0x8,%esp
  80049d:	ff 75 0c             	pushl  0xc(%ebp)
  8004a0:	53                   	push   %ebx
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	ff d0                	call   *%eax
  8004a6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ac:	8d 50 01             	lea    0x1(%eax),%edx
  8004af:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b2:	8a 00                	mov    (%eax),%al
  8004b4:	0f b6 d8             	movzbl %al,%ebx
  8004b7:	83 fb 25             	cmp    $0x25,%ebx
  8004ba:	75 d6                	jne    800492 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004bc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004c7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004d5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004df:	8d 50 01             	lea    0x1(%eax),%edx
  8004e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e5:	8a 00                	mov    (%eax),%al
  8004e7:	0f b6 d8             	movzbl %al,%ebx
  8004ea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ed:	83 f8 55             	cmp    $0x55,%eax
  8004f0:	0f 87 2b 03 00 00    	ja     800821 <vprintfmt+0x399>
  8004f6:	8b 04 85 58 1e 80 00 	mov    0x801e58(,%eax,4),%eax
  8004fd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004ff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800503:	eb d7                	jmp    8004dc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800505:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800509:	eb d1                	jmp    8004dc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800512:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800515:	89 d0                	mov    %edx,%eax
  800517:	c1 e0 02             	shl    $0x2,%eax
  80051a:	01 d0                	add    %edx,%eax
  80051c:	01 c0                	add    %eax,%eax
  80051e:	01 d8                	add    %ebx,%eax
  800520:	83 e8 30             	sub    $0x30,%eax
  800523:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800526:	8b 45 10             	mov    0x10(%ebp),%eax
  800529:	8a 00                	mov    (%eax),%al
  80052b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80052e:	83 fb 2f             	cmp    $0x2f,%ebx
  800531:	7e 3e                	jle    800571 <vprintfmt+0xe9>
  800533:	83 fb 39             	cmp    $0x39,%ebx
  800536:	7f 39                	jg     800571 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800538:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80053b:	eb d5                	jmp    800512 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80053d:	8b 45 14             	mov    0x14(%ebp),%eax
  800540:	83 c0 04             	add    $0x4,%eax
  800543:	89 45 14             	mov    %eax,0x14(%ebp)
  800546:	8b 45 14             	mov    0x14(%ebp),%eax
  800549:	83 e8 04             	sub    $0x4,%eax
  80054c:	8b 00                	mov    (%eax),%eax
  80054e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800551:	eb 1f                	jmp    800572 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800553:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800557:	79 83                	jns    8004dc <vprintfmt+0x54>
				width = 0;
  800559:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800560:	e9 77 ff ff ff       	jmp    8004dc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800565:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80056c:	e9 6b ff ff ff       	jmp    8004dc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800571:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800572:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800576:	0f 89 60 ff ff ff    	jns    8004dc <vprintfmt+0x54>
				width = precision, precision = -1;
  80057c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80057f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800582:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800589:	e9 4e ff ff ff       	jmp    8004dc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80058e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800591:	e9 46 ff ff ff       	jmp    8004dc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800596:	8b 45 14             	mov    0x14(%ebp),%eax
  800599:	83 c0 04             	add    $0x4,%eax
  80059c:	89 45 14             	mov    %eax,0x14(%ebp)
  80059f:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a2:	83 e8 04             	sub    $0x4,%eax
  8005a5:	8b 00                	mov    (%eax),%eax
  8005a7:	83 ec 08             	sub    $0x8,%esp
  8005aa:	ff 75 0c             	pushl  0xc(%ebp)
  8005ad:	50                   	push   %eax
  8005ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b1:	ff d0                	call   *%eax
  8005b3:	83 c4 10             	add    $0x10,%esp
			break;
  8005b6:	e9 89 02 00 00       	jmp    800844 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005be:	83 c0 04             	add    $0x4,%eax
  8005c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c7:	83 e8 04             	sub    $0x4,%eax
  8005ca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005cc:	85 db                	test   %ebx,%ebx
  8005ce:	79 02                	jns    8005d2 <vprintfmt+0x14a>
				err = -err;
  8005d0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005d2:	83 fb 64             	cmp    $0x64,%ebx
  8005d5:	7f 0b                	jg     8005e2 <vprintfmt+0x15a>
  8005d7:	8b 34 9d a0 1c 80 00 	mov    0x801ca0(,%ebx,4),%esi
  8005de:	85 f6                	test   %esi,%esi
  8005e0:	75 19                	jne    8005fb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005e2:	53                   	push   %ebx
  8005e3:	68 45 1e 80 00       	push   $0x801e45
  8005e8:	ff 75 0c             	pushl  0xc(%ebp)
  8005eb:	ff 75 08             	pushl  0x8(%ebp)
  8005ee:	e8 5e 02 00 00       	call   800851 <printfmt>
  8005f3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f6:	e9 49 02 00 00       	jmp    800844 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005fb:	56                   	push   %esi
  8005fc:	68 4e 1e 80 00       	push   $0x801e4e
  800601:	ff 75 0c             	pushl  0xc(%ebp)
  800604:	ff 75 08             	pushl  0x8(%ebp)
  800607:	e8 45 02 00 00       	call   800851 <printfmt>
  80060c:	83 c4 10             	add    $0x10,%esp
			break;
  80060f:	e9 30 02 00 00       	jmp    800844 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800614:	8b 45 14             	mov    0x14(%ebp),%eax
  800617:	83 c0 04             	add    $0x4,%eax
  80061a:	89 45 14             	mov    %eax,0x14(%ebp)
  80061d:	8b 45 14             	mov    0x14(%ebp),%eax
  800620:	83 e8 04             	sub    $0x4,%eax
  800623:	8b 30                	mov    (%eax),%esi
  800625:	85 f6                	test   %esi,%esi
  800627:	75 05                	jne    80062e <vprintfmt+0x1a6>
				p = "(null)";
  800629:	be 51 1e 80 00       	mov    $0x801e51,%esi
			if (width > 0 && padc != '-')
  80062e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800632:	7e 6d                	jle    8006a1 <vprintfmt+0x219>
  800634:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800638:	74 67                	je     8006a1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80063a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063d:	83 ec 08             	sub    $0x8,%esp
  800640:	50                   	push   %eax
  800641:	56                   	push   %esi
  800642:	e8 12 05 00 00       	call   800b59 <strnlen>
  800647:	83 c4 10             	add    $0x10,%esp
  80064a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80064d:	eb 16                	jmp    800665 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80064f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800653:	83 ec 08             	sub    $0x8,%esp
  800656:	ff 75 0c             	pushl  0xc(%ebp)
  800659:	50                   	push   %eax
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	ff d0                	call   *%eax
  80065f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800662:	ff 4d e4             	decl   -0x1c(%ebp)
  800665:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800669:	7f e4                	jg     80064f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066b:	eb 34                	jmp    8006a1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80066d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800671:	74 1c                	je     80068f <vprintfmt+0x207>
  800673:	83 fb 1f             	cmp    $0x1f,%ebx
  800676:	7e 05                	jle    80067d <vprintfmt+0x1f5>
  800678:	83 fb 7e             	cmp    $0x7e,%ebx
  80067b:	7e 12                	jle    80068f <vprintfmt+0x207>
					putch('?', putdat);
  80067d:	83 ec 08             	sub    $0x8,%esp
  800680:	ff 75 0c             	pushl  0xc(%ebp)
  800683:	6a 3f                	push   $0x3f
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	ff d0                	call   *%eax
  80068a:	83 c4 10             	add    $0x10,%esp
  80068d:	eb 0f                	jmp    80069e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80068f:	83 ec 08             	sub    $0x8,%esp
  800692:	ff 75 0c             	pushl  0xc(%ebp)
  800695:	53                   	push   %ebx
  800696:	8b 45 08             	mov    0x8(%ebp),%eax
  800699:	ff d0                	call   *%eax
  80069b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80069e:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a1:	89 f0                	mov    %esi,%eax
  8006a3:	8d 70 01             	lea    0x1(%eax),%esi
  8006a6:	8a 00                	mov    (%eax),%al
  8006a8:	0f be d8             	movsbl %al,%ebx
  8006ab:	85 db                	test   %ebx,%ebx
  8006ad:	74 24                	je     8006d3 <vprintfmt+0x24b>
  8006af:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b3:	78 b8                	js     80066d <vprintfmt+0x1e5>
  8006b5:	ff 4d e0             	decl   -0x20(%ebp)
  8006b8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006bc:	79 af                	jns    80066d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006be:	eb 13                	jmp    8006d3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c0:	83 ec 08             	sub    $0x8,%esp
  8006c3:	ff 75 0c             	pushl  0xc(%ebp)
  8006c6:	6a 20                	push   $0x20
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	ff d0                	call   *%eax
  8006cd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d7:	7f e7                	jg     8006c0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006d9:	e9 66 01 00 00       	jmp    800844 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006de:	83 ec 08             	sub    $0x8,%esp
  8006e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e7:	50                   	push   %eax
  8006e8:	e8 3c fd ff ff       	call   800429 <getint>
  8006ed:	83 c4 10             	add    $0x10,%esp
  8006f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006fc:	85 d2                	test   %edx,%edx
  8006fe:	79 23                	jns    800723 <vprintfmt+0x29b>
				putch('-', putdat);
  800700:	83 ec 08             	sub    $0x8,%esp
  800703:	ff 75 0c             	pushl  0xc(%ebp)
  800706:	6a 2d                	push   $0x2d
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	ff d0                	call   *%eax
  80070d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800710:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800713:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800716:	f7 d8                	neg    %eax
  800718:	83 d2 00             	adc    $0x0,%edx
  80071b:	f7 da                	neg    %edx
  80071d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800720:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800723:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072a:	e9 bc 00 00 00       	jmp    8007eb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80072f:	83 ec 08             	sub    $0x8,%esp
  800732:	ff 75 e8             	pushl  -0x18(%ebp)
  800735:	8d 45 14             	lea    0x14(%ebp),%eax
  800738:	50                   	push   %eax
  800739:	e8 84 fc ff ff       	call   8003c2 <getuint>
  80073e:	83 c4 10             	add    $0x10,%esp
  800741:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800744:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800747:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80074e:	e9 98 00 00 00       	jmp    8007eb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 0c             	pushl  0xc(%ebp)
  800759:	6a 58                	push   $0x58
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800763:	83 ec 08             	sub    $0x8,%esp
  800766:	ff 75 0c             	pushl  0xc(%ebp)
  800769:	6a 58                	push   $0x58
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	ff d0                	call   *%eax
  800770:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800773:	83 ec 08             	sub    $0x8,%esp
  800776:	ff 75 0c             	pushl  0xc(%ebp)
  800779:	6a 58                	push   $0x58
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	ff d0                	call   *%eax
  800780:	83 c4 10             	add    $0x10,%esp
			break;
  800783:	e9 bc 00 00 00       	jmp    800844 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800788:	83 ec 08             	sub    $0x8,%esp
  80078b:	ff 75 0c             	pushl  0xc(%ebp)
  80078e:	6a 30                	push   $0x30
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	ff d0                	call   *%eax
  800795:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800798:	83 ec 08             	sub    $0x8,%esp
  80079b:	ff 75 0c             	pushl  0xc(%ebp)
  80079e:	6a 78                	push   $0x78
  8007a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a3:	ff d0                	call   *%eax
  8007a5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ab:	83 c0 04             	add    $0x4,%eax
  8007ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b4:	83 e8 04             	sub    $0x4,%eax
  8007b7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007ca:	eb 1f                	jmp    8007eb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007cc:	83 ec 08             	sub    $0x8,%esp
  8007cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8007d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8007d5:	50                   	push   %eax
  8007d6:	e8 e7 fb ff ff       	call   8003c2 <getuint>
  8007db:	83 c4 10             	add    $0x10,%esp
  8007de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007eb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f2:	83 ec 04             	sub    $0x4,%esp
  8007f5:	52                   	push   %edx
  8007f6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007f9:	50                   	push   %eax
  8007fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fd:	ff 75 f0             	pushl  -0x10(%ebp)
  800800:	ff 75 0c             	pushl  0xc(%ebp)
  800803:	ff 75 08             	pushl  0x8(%ebp)
  800806:	e8 00 fb ff ff       	call   80030b <printnum>
  80080b:	83 c4 20             	add    $0x20,%esp
			break;
  80080e:	eb 34                	jmp    800844 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	ff 75 0c             	pushl  0xc(%ebp)
  800816:	53                   	push   %ebx
  800817:	8b 45 08             	mov    0x8(%ebp),%eax
  80081a:	ff d0                	call   *%eax
  80081c:	83 c4 10             	add    $0x10,%esp
			break;
  80081f:	eb 23                	jmp    800844 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	6a 25                	push   $0x25
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	ff d0                	call   *%eax
  80082e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800831:	ff 4d 10             	decl   0x10(%ebp)
  800834:	eb 03                	jmp    800839 <vprintfmt+0x3b1>
  800836:	ff 4d 10             	decl   0x10(%ebp)
  800839:	8b 45 10             	mov    0x10(%ebp),%eax
  80083c:	48                   	dec    %eax
  80083d:	8a 00                	mov    (%eax),%al
  80083f:	3c 25                	cmp    $0x25,%al
  800841:	75 f3                	jne    800836 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800843:	90                   	nop
		}
	}
  800844:	e9 47 fc ff ff       	jmp    800490 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800849:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80084a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80084d:	5b                   	pop    %ebx
  80084e:	5e                   	pop    %esi
  80084f:	5d                   	pop    %ebp
  800850:	c3                   	ret    

00800851 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800851:	55                   	push   %ebp
  800852:	89 e5                	mov    %esp,%ebp
  800854:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800857:	8d 45 10             	lea    0x10(%ebp),%eax
  80085a:	83 c0 04             	add    $0x4,%eax
  80085d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800860:	8b 45 10             	mov    0x10(%ebp),%eax
  800863:	ff 75 f4             	pushl  -0xc(%ebp)
  800866:	50                   	push   %eax
  800867:	ff 75 0c             	pushl  0xc(%ebp)
  80086a:	ff 75 08             	pushl  0x8(%ebp)
  80086d:	e8 16 fc ff ff       	call   800488 <vprintfmt>
  800872:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800875:	90                   	nop
  800876:	c9                   	leave  
  800877:	c3                   	ret    

00800878 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800878:	55                   	push   %ebp
  800879:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80087b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087e:	8b 40 08             	mov    0x8(%eax),%eax
  800881:	8d 50 01             	lea    0x1(%eax),%edx
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80088a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088d:	8b 10                	mov    (%eax),%edx
  80088f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800892:	8b 40 04             	mov    0x4(%eax),%eax
  800895:	39 c2                	cmp    %eax,%edx
  800897:	73 12                	jae    8008ab <sprintputch+0x33>
		*b->buf++ = ch;
  800899:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089c:	8b 00                	mov    (%eax),%eax
  80089e:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a4:	89 0a                	mov    %ecx,(%edx)
  8008a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a9:	88 10                	mov    %dl,(%eax)
}
  8008ab:	90                   	nop
  8008ac:	5d                   	pop    %ebp
  8008ad:	c3                   	ret    

008008ae <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008ae:	55                   	push   %ebp
  8008af:	89 e5                	mov    %esp,%ebp
  8008b1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c3:	01 d0                	add    %edx,%eax
  8008c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d3:	74 06                	je     8008db <vsnprintf+0x2d>
  8008d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d9:	7f 07                	jg     8008e2 <vsnprintf+0x34>
		return -E_INVAL;
  8008db:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e0:	eb 20                	jmp    800902 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008e2:	ff 75 14             	pushl  0x14(%ebp)
  8008e5:	ff 75 10             	pushl  0x10(%ebp)
  8008e8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008eb:	50                   	push   %eax
  8008ec:	68 78 08 80 00       	push   $0x800878
  8008f1:	e8 92 fb ff ff       	call   800488 <vprintfmt>
  8008f6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008fc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800902:	c9                   	leave  
  800903:	c3                   	ret    

00800904 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800904:	55                   	push   %ebp
  800905:	89 e5                	mov    %esp,%ebp
  800907:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80090a:	8d 45 10             	lea    0x10(%ebp),%eax
  80090d:	83 c0 04             	add    $0x4,%eax
  800910:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800913:	8b 45 10             	mov    0x10(%ebp),%eax
  800916:	ff 75 f4             	pushl  -0xc(%ebp)
  800919:	50                   	push   %eax
  80091a:	ff 75 0c             	pushl  0xc(%ebp)
  80091d:	ff 75 08             	pushl  0x8(%ebp)
  800920:	e8 89 ff ff ff       	call   8008ae <vsnprintf>
  800925:	83 c4 10             	add    $0x10,%esp
  800928:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80092b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80092e:	c9                   	leave  
  80092f:	c3                   	ret    

00800930 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800930:	55                   	push   %ebp
  800931:	89 e5                	mov    %esp,%ebp
  800933:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800936:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80093a:	74 13                	je     80094f <readline+0x1f>
		cprintf("%s", prompt);
  80093c:	83 ec 08             	sub    $0x8,%esp
  80093f:	ff 75 08             	pushl  0x8(%ebp)
  800942:	68 b0 1f 80 00       	push   $0x801fb0
  800947:	e8 62 f9 ff ff       	call   8002ae <cprintf>
  80094c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80094f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800956:	83 ec 0c             	sub    $0xc,%esp
  800959:	6a 00                	push   $0x0
  80095b:	e8 8e 0f 00 00       	call   8018ee <iscons>
  800960:	83 c4 10             	add    $0x10,%esp
  800963:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800966:	e8 35 0f 00 00       	call   8018a0 <getchar>
  80096b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80096e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800972:	79 22                	jns    800996 <readline+0x66>
			if (c != -E_EOF)
  800974:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800978:	0f 84 ad 00 00 00    	je     800a2b <readline+0xfb>
				cprintf("read error: %e\n", c);
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 ec             	pushl  -0x14(%ebp)
  800984:	68 b3 1f 80 00       	push   $0x801fb3
  800989:	e8 20 f9 ff ff       	call   8002ae <cprintf>
  80098e:	83 c4 10             	add    $0x10,%esp
			return;
  800991:	e9 95 00 00 00       	jmp    800a2b <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800996:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80099a:	7e 34                	jle    8009d0 <readline+0xa0>
  80099c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009a3:	7f 2b                	jg     8009d0 <readline+0xa0>
			if (echoing)
  8009a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009a9:	74 0e                	je     8009b9 <readline+0x89>
				cputchar(c);
  8009ab:	83 ec 0c             	sub    $0xc,%esp
  8009ae:	ff 75 ec             	pushl  -0x14(%ebp)
  8009b1:	e8 a2 0e 00 00       	call   801858 <cputchar>
  8009b6:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009bc:	8d 50 01             	lea    0x1(%eax),%edx
  8009bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009c2:	89 c2                	mov    %eax,%edx
  8009c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c7:	01 d0                	add    %edx,%eax
  8009c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009cc:	88 10                	mov    %dl,(%eax)
  8009ce:	eb 56                	jmp    800a26 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009d0:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009d4:	75 1f                	jne    8009f5 <readline+0xc5>
  8009d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009da:	7e 19                	jle    8009f5 <readline+0xc5>
			if (echoing)
  8009dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009e0:	74 0e                	je     8009f0 <readline+0xc0>
				cputchar(c);
  8009e2:	83 ec 0c             	sub    $0xc,%esp
  8009e5:	ff 75 ec             	pushl  -0x14(%ebp)
  8009e8:	e8 6b 0e 00 00       	call   801858 <cputchar>
  8009ed:	83 c4 10             	add    $0x10,%esp

			i--;
  8009f0:	ff 4d f4             	decl   -0xc(%ebp)
  8009f3:	eb 31                	jmp    800a26 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8009f5:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8009f9:	74 0a                	je     800a05 <readline+0xd5>
  8009fb:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8009ff:	0f 85 61 ff ff ff    	jne    800966 <readline+0x36>
			if (echoing)
  800a05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a09:	74 0e                	je     800a19 <readline+0xe9>
				cputchar(c);
  800a0b:	83 ec 0c             	sub    $0xc,%esp
  800a0e:	ff 75 ec             	pushl  -0x14(%ebp)
  800a11:	e8 42 0e 00 00       	call   801858 <cputchar>
  800a16:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1f:	01 d0                	add    %edx,%eax
  800a21:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a24:	eb 06                	jmp    800a2c <readline+0xfc>
		}
	}
  800a26:	e9 3b ff ff ff       	jmp    800966 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a2b:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a2c:	c9                   	leave  
  800a2d:	c3                   	ret    

00800a2e <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
  800a31:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a34:	e8 41 0a 00 00       	call   80147a <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a39:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a3d:	74 13                	je     800a52 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 08             	pushl  0x8(%ebp)
  800a45:	68 b0 1f 80 00       	push   $0x801fb0
  800a4a:	e8 5f f8 ff ff       	call   8002ae <cprintf>
  800a4f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a59:	83 ec 0c             	sub    $0xc,%esp
  800a5c:	6a 00                	push   $0x0
  800a5e:	e8 8b 0e 00 00       	call   8018ee <iscons>
  800a63:	83 c4 10             	add    $0x10,%esp
  800a66:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a69:	e8 32 0e 00 00       	call   8018a0 <getchar>
  800a6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a71:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a75:	79 23                	jns    800a9a <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a77:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a7b:	74 13                	je     800a90 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 ec             	pushl  -0x14(%ebp)
  800a83:	68 b3 1f 80 00       	push   $0x801fb3
  800a88:	e8 21 f8 ff ff       	call   8002ae <cprintf>
  800a8d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800a90:	e8 ff 09 00 00       	call   801494 <sys_enable_interrupt>
			return;
  800a95:	e9 9a 00 00 00       	jmp    800b34 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800a9a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800a9e:	7e 34                	jle    800ad4 <atomic_readline+0xa6>
  800aa0:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800aa7:	7f 2b                	jg     800ad4 <atomic_readline+0xa6>
			if (echoing)
  800aa9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aad:	74 0e                	je     800abd <atomic_readline+0x8f>
				cputchar(c);
  800aaf:	83 ec 0c             	sub    $0xc,%esp
  800ab2:	ff 75 ec             	pushl  -0x14(%ebp)
  800ab5:	e8 9e 0d 00 00       	call   801858 <cputchar>
  800aba:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ac0:	8d 50 01             	lea    0x1(%eax),%edx
  800ac3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ac6:	89 c2                	mov    %eax,%edx
  800ac8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acb:	01 d0                	add    %edx,%eax
  800acd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ad0:	88 10                	mov    %dl,(%eax)
  800ad2:	eb 5b                	jmp    800b2f <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800ad4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800ad8:	75 1f                	jne    800af9 <atomic_readline+0xcb>
  800ada:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ade:	7e 19                	jle    800af9 <atomic_readline+0xcb>
			if (echoing)
  800ae0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ae4:	74 0e                	je     800af4 <atomic_readline+0xc6>
				cputchar(c);
  800ae6:	83 ec 0c             	sub    $0xc,%esp
  800ae9:	ff 75 ec             	pushl  -0x14(%ebp)
  800aec:	e8 67 0d 00 00       	call   801858 <cputchar>
  800af1:	83 c4 10             	add    $0x10,%esp
			i--;
  800af4:	ff 4d f4             	decl   -0xc(%ebp)
  800af7:	eb 36                	jmp    800b2f <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800af9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800afd:	74 0a                	je     800b09 <atomic_readline+0xdb>
  800aff:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b03:	0f 85 60 ff ff ff    	jne    800a69 <atomic_readline+0x3b>
			if (echoing)
  800b09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b0d:	74 0e                	je     800b1d <atomic_readline+0xef>
				cputchar(c);
  800b0f:	83 ec 0c             	sub    $0xc,%esp
  800b12:	ff 75 ec             	pushl  -0x14(%ebp)
  800b15:	e8 3e 0d 00 00       	call   801858 <cputchar>
  800b1a:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b23:	01 d0                	add    %edx,%eax
  800b25:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b28:	e8 67 09 00 00       	call   801494 <sys_enable_interrupt>
			return;
  800b2d:	eb 05                	jmp    800b34 <atomic_readline+0x106>
		}
	}
  800b2f:	e9 35 ff ff ff       	jmp    800a69 <atomic_readline+0x3b>
}
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b43:	eb 06                	jmp    800b4b <strlen+0x15>
		n++;
  800b45:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b48:	ff 45 08             	incl   0x8(%ebp)
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	8a 00                	mov    (%eax),%al
  800b50:	84 c0                	test   %al,%al
  800b52:	75 f1                	jne    800b45 <strlen+0xf>
		n++;
	return n;
  800b54:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b57:	c9                   	leave  
  800b58:	c3                   	ret    

00800b59 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b59:	55                   	push   %ebp
  800b5a:	89 e5                	mov    %esp,%ebp
  800b5c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b66:	eb 09                	jmp    800b71 <strnlen+0x18>
		n++;
  800b68:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b6b:	ff 45 08             	incl   0x8(%ebp)
  800b6e:	ff 4d 0c             	decl   0xc(%ebp)
  800b71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b75:	74 09                	je     800b80 <strnlen+0x27>
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8a 00                	mov    (%eax),%al
  800b7c:	84 c0                	test   %al,%al
  800b7e:	75 e8                	jne    800b68 <strnlen+0xf>
		n++;
	return n;
  800b80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b83:	c9                   	leave  
  800b84:	c3                   	ret    

00800b85 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b85:	55                   	push   %ebp
  800b86:	89 e5                	mov    %esp,%ebp
  800b88:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b91:	90                   	nop
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	8d 50 01             	lea    0x1(%eax),%edx
  800b98:	89 55 08             	mov    %edx,0x8(%ebp)
  800b9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ba4:	8a 12                	mov    (%edx),%dl
  800ba6:	88 10                	mov    %dl,(%eax)
  800ba8:	8a 00                	mov    (%eax),%al
  800baa:	84 c0                	test   %al,%al
  800bac:	75 e4                	jne    800b92 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bb1:	c9                   	leave  
  800bb2:	c3                   	ret    

00800bb3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bb3:	55                   	push   %ebp
  800bb4:	89 e5                	mov    %esp,%ebp
  800bb6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bbf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bc6:	eb 1f                	jmp    800be7 <strncpy+0x34>
		*dst++ = *src;
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8d 50 01             	lea    0x1(%eax),%edx
  800bce:	89 55 08             	mov    %edx,0x8(%ebp)
  800bd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd4:	8a 12                	mov    (%edx),%dl
  800bd6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdb:	8a 00                	mov    (%eax),%al
  800bdd:	84 c0                	test   %al,%al
  800bdf:	74 03                	je     800be4 <strncpy+0x31>
			src++;
  800be1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800be4:	ff 45 fc             	incl   -0x4(%ebp)
  800be7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bea:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bed:	72 d9                	jb     800bc8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bf2:	c9                   	leave  
  800bf3:	c3                   	ret    

00800bf4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800bf4:	55                   	push   %ebp
  800bf5:	89 e5                	mov    %esp,%ebp
  800bf7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c04:	74 30                	je     800c36 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c06:	eb 16                	jmp    800c1e <strlcpy+0x2a>
			*dst++ = *src++;
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	8d 50 01             	lea    0x1(%eax),%edx
  800c0e:	89 55 08             	mov    %edx,0x8(%ebp)
  800c11:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c14:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c17:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c1a:	8a 12                	mov    (%edx),%dl
  800c1c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c1e:	ff 4d 10             	decl   0x10(%ebp)
  800c21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c25:	74 09                	je     800c30 <strlcpy+0x3c>
  800c27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2a:	8a 00                	mov    (%eax),%al
  800c2c:	84 c0                	test   %al,%al
  800c2e:	75 d8                	jne    800c08 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c36:	8b 55 08             	mov    0x8(%ebp),%edx
  800c39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3c:	29 c2                	sub    %eax,%edx
  800c3e:	89 d0                	mov    %edx,%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c45:	eb 06                	jmp    800c4d <strcmp+0xb>
		p++, q++;
  800c47:	ff 45 08             	incl   0x8(%ebp)
  800c4a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	84 c0                	test   %al,%al
  800c54:	74 0e                	je     800c64 <strcmp+0x22>
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	8a 10                	mov    (%eax),%dl
  800c5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5e:	8a 00                	mov    (%eax),%al
  800c60:	38 c2                	cmp    %al,%dl
  800c62:	74 e3                	je     800c47 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	0f b6 d0             	movzbl %al,%edx
  800c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6f:	8a 00                	mov    (%eax),%al
  800c71:	0f b6 c0             	movzbl %al,%eax
  800c74:	29 c2                	sub    %eax,%edx
  800c76:	89 d0                	mov    %edx,%eax
}
  800c78:	5d                   	pop    %ebp
  800c79:	c3                   	ret    

00800c7a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c7a:	55                   	push   %ebp
  800c7b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c7d:	eb 09                	jmp    800c88 <strncmp+0xe>
		n--, p++, q++;
  800c7f:	ff 4d 10             	decl   0x10(%ebp)
  800c82:	ff 45 08             	incl   0x8(%ebp)
  800c85:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c88:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c8c:	74 17                	je     800ca5 <strncmp+0x2b>
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	84 c0                	test   %al,%al
  800c95:	74 0e                	je     800ca5 <strncmp+0x2b>
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 10                	mov    (%eax),%dl
  800c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9f:	8a 00                	mov    (%eax),%al
  800ca1:	38 c2                	cmp    %al,%dl
  800ca3:	74 da                	je     800c7f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ca5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca9:	75 07                	jne    800cb2 <strncmp+0x38>
		return 0;
  800cab:	b8 00 00 00 00       	mov    $0x0,%eax
  800cb0:	eb 14                	jmp    800cc6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	0f b6 d0             	movzbl %al,%edx
  800cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	0f b6 c0             	movzbl %al,%eax
  800cc2:	29 c2                	sub    %eax,%edx
  800cc4:	89 d0                	mov    %edx,%eax
}
  800cc6:	5d                   	pop    %ebp
  800cc7:	c3                   	ret    

00800cc8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
  800ccb:	83 ec 04             	sub    $0x4,%esp
  800cce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cd4:	eb 12                	jmp    800ce8 <strchr+0x20>
		if (*s == c)
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	8a 00                	mov    (%eax),%al
  800cdb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cde:	75 05                	jne    800ce5 <strchr+0x1d>
			return (char *) s;
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	eb 11                	jmp    800cf6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ce5:	ff 45 08             	incl   0x8(%ebp)
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	84 c0                	test   %al,%al
  800cef:	75 e5                	jne    800cd6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cf1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cf6:	c9                   	leave  
  800cf7:	c3                   	ret    

00800cf8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800cf8:	55                   	push   %ebp
  800cf9:	89 e5                	mov    %esp,%ebp
  800cfb:	83 ec 04             	sub    $0x4,%esp
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d04:	eb 0d                	jmp    800d13 <strfind+0x1b>
		if (*s == c)
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d0e:	74 0e                	je     800d1e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d10:	ff 45 08             	incl   0x8(%ebp)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	84 c0                	test   %al,%al
  800d1a:	75 ea                	jne    800d06 <strfind+0xe>
  800d1c:	eb 01                	jmp    800d1f <strfind+0x27>
		if (*s == c)
			break;
  800d1e:	90                   	nop
	return (char *) s;
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d22:	c9                   	leave  
  800d23:	c3                   	ret    

00800d24 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d24:	55                   	push   %ebp
  800d25:	89 e5                	mov    %esp,%ebp
  800d27:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d30:	8b 45 10             	mov    0x10(%ebp),%eax
  800d33:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d36:	eb 0e                	jmp    800d46 <memset+0x22>
		*p++ = c;
  800d38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3b:	8d 50 01             	lea    0x1(%eax),%edx
  800d3e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d41:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d44:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d46:	ff 4d f8             	decl   -0x8(%ebp)
  800d49:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d4d:	79 e9                	jns    800d38 <memset+0x14>
		*p++ = c;

	return v;
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d52:	c9                   	leave  
  800d53:	c3                   	ret    

00800d54 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d54:	55                   	push   %ebp
  800d55:	89 e5                	mov    %esp,%ebp
  800d57:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d66:	eb 16                	jmp    800d7e <memcpy+0x2a>
		*d++ = *s++;
  800d68:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6b:	8d 50 01             	lea    0x1(%eax),%edx
  800d6e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d71:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d74:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d77:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d7a:	8a 12                	mov    (%edx),%dl
  800d7c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d84:	89 55 10             	mov    %edx,0x10(%ebp)
  800d87:	85 c0                	test   %eax,%eax
  800d89:	75 dd                	jne    800d68 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d8e:	c9                   	leave  
  800d8f:	c3                   	ret    

00800d90 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d90:	55                   	push   %ebp
  800d91:	89 e5                	mov    %esp,%ebp
  800d93:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d99:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800da2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800da5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800da8:	73 50                	jae    800dfa <memmove+0x6a>
  800daa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dad:	8b 45 10             	mov    0x10(%ebp),%eax
  800db0:	01 d0                	add    %edx,%eax
  800db2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db5:	76 43                	jbe    800dfa <memmove+0x6a>
		s += n;
  800db7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dba:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dc3:	eb 10                	jmp    800dd5 <memmove+0x45>
			*--d = *--s;
  800dc5:	ff 4d f8             	decl   -0x8(%ebp)
  800dc8:	ff 4d fc             	decl   -0x4(%ebp)
  800dcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dce:	8a 10                	mov    (%eax),%dl
  800dd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dde:	85 c0                	test   %eax,%eax
  800de0:	75 e3                	jne    800dc5 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800de2:	eb 23                	jmp    800e07 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800de4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de7:	8d 50 01             	lea    0x1(%eax),%edx
  800dea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ded:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800df3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800df6:	8a 12                	mov    (%edx),%dl
  800df8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e00:	89 55 10             	mov    %edx,0x10(%ebp)
  800e03:	85 c0                	test   %eax,%eax
  800e05:	75 dd                	jne    800de4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0a:	c9                   	leave  
  800e0b:	c3                   	ret    

00800e0c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e0c:	55                   	push   %ebp
  800e0d:	89 e5                	mov    %esp,%ebp
  800e0f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e1e:	eb 2a                	jmp    800e4a <memcmp+0x3e>
		if (*s1 != *s2)
  800e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e23:	8a 10                	mov    (%eax),%dl
  800e25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	38 c2                	cmp    %al,%dl
  800e2c:	74 16                	je     800e44 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	0f b6 d0             	movzbl %al,%edx
  800e36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e39:	8a 00                	mov    (%eax),%al
  800e3b:	0f b6 c0             	movzbl %al,%eax
  800e3e:	29 c2                	sub    %eax,%edx
  800e40:	89 d0                	mov    %edx,%eax
  800e42:	eb 18                	jmp    800e5c <memcmp+0x50>
		s1++, s2++;
  800e44:	ff 45 fc             	incl   -0x4(%ebp)
  800e47:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e50:	89 55 10             	mov    %edx,0x10(%ebp)
  800e53:	85 c0                	test   %eax,%eax
  800e55:	75 c9                	jne    800e20 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e5c:	c9                   	leave  
  800e5d:	c3                   	ret    

00800e5e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e5e:	55                   	push   %ebp
  800e5f:	89 e5                	mov    %esp,%ebp
  800e61:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e64:	8b 55 08             	mov    0x8(%ebp),%edx
  800e67:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6a:	01 d0                	add    %edx,%eax
  800e6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e6f:	eb 15                	jmp    800e86 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	0f b6 d0             	movzbl %al,%edx
  800e79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7c:	0f b6 c0             	movzbl %al,%eax
  800e7f:	39 c2                	cmp    %eax,%edx
  800e81:	74 0d                	je     800e90 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e83:	ff 45 08             	incl   0x8(%ebp)
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e8c:	72 e3                	jb     800e71 <memfind+0x13>
  800e8e:	eb 01                	jmp    800e91 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e90:	90                   	nop
	return (void *) s;
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e94:	c9                   	leave  
  800e95:	c3                   	ret    

00800e96 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e96:	55                   	push   %ebp
  800e97:	89 e5                	mov    %esp,%ebp
  800e99:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ea3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eaa:	eb 03                	jmp    800eaf <strtol+0x19>
		s++;
  800eac:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	3c 20                	cmp    $0x20,%al
  800eb6:	74 f4                	je     800eac <strtol+0x16>
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8a 00                	mov    (%eax),%al
  800ebd:	3c 09                	cmp    $0x9,%al
  800ebf:	74 eb                	je     800eac <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	8a 00                	mov    (%eax),%al
  800ec6:	3c 2b                	cmp    $0x2b,%al
  800ec8:	75 05                	jne    800ecf <strtol+0x39>
		s++;
  800eca:	ff 45 08             	incl   0x8(%ebp)
  800ecd:	eb 13                	jmp    800ee2 <strtol+0x4c>
	else if (*s == '-')
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	8a 00                	mov    (%eax),%al
  800ed4:	3c 2d                	cmp    $0x2d,%al
  800ed6:	75 0a                	jne    800ee2 <strtol+0x4c>
		s++, neg = 1;
  800ed8:	ff 45 08             	incl   0x8(%ebp)
  800edb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ee2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ee6:	74 06                	je     800eee <strtol+0x58>
  800ee8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800eec:	75 20                	jne    800f0e <strtol+0x78>
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 30                	cmp    $0x30,%al
  800ef5:	75 17                	jne    800f0e <strtol+0x78>
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	40                   	inc    %eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	3c 78                	cmp    $0x78,%al
  800eff:	75 0d                	jne    800f0e <strtol+0x78>
		s += 2, base = 16;
  800f01:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f05:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f0c:	eb 28                	jmp    800f36 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f12:	75 15                	jne    800f29 <strtol+0x93>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	3c 30                	cmp    $0x30,%al
  800f1b:	75 0c                	jne    800f29 <strtol+0x93>
		s++, base = 8;
  800f1d:	ff 45 08             	incl   0x8(%ebp)
  800f20:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f27:	eb 0d                	jmp    800f36 <strtol+0xa0>
	else if (base == 0)
  800f29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2d:	75 07                	jne    800f36 <strtol+0xa0>
		base = 10;
  800f2f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	3c 2f                	cmp    $0x2f,%al
  800f3d:	7e 19                	jle    800f58 <strtol+0xc2>
  800f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f42:	8a 00                	mov    (%eax),%al
  800f44:	3c 39                	cmp    $0x39,%al
  800f46:	7f 10                	jg     800f58 <strtol+0xc2>
			dig = *s - '0';
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	8a 00                	mov    (%eax),%al
  800f4d:	0f be c0             	movsbl %al,%eax
  800f50:	83 e8 30             	sub    $0x30,%eax
  800f53:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f56:	eb 42                	jmp    800f9a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	3c 60                	cmp    $0x60,%al
  800f5f:	7e 19                	jle    800f7a <strtol+0xe4>
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	3c 7a                	cmp    $0x7a,%al
  800f68:	7f 10                	jg     800f7a <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	0f be c0             	movsbl %al,%eax
  800f72:	83 e8 57             	sub    $0x57,%eax
  800f75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f78:	eb 20                	jmp    800f9a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	3c 40                	cmp    $0x40,%al
  800f81:	7e 39                	jle    800fbc <strtol+0x126>
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	3c 5a                	cmp    $0x5a,%al
  800f8a:	7f 30                	jg     800fbc <strtol+0x126>
			dig = *s - 'A' + 10;
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	8a 00                	mov    (%eax),%al
  800f91:	0f be c0             	movsbl %al,%eax
  800f94:	83 e8 37             	sub    $0x37,%eax
  800f97:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f9d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fa0:	7d 19                	jge    800fbb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fa2:	ff 45 08             	incl   0x8(%ebp)
  800fa5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa8:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fac:	89 c2                	mov    %eax,%edx
  800fae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb1:	01 d0                	add    %edx,%eax
  800fb3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fb6:	e9 7b ff ff ff       	jmp    800f36 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fbb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fbc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc0:	74 08                	je     800fca <strtol+0x134>
		*endptr = (char *) s;
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fca:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fce:	74 07                	je     800fd7 <strtol+0x141>
  800fd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd3:	f7 d8                	neg    %eax
  800fd5:	eb 03                	jmp    800fda <strtol+0x144>
  800fd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fda:	c9                   	leave  
  800fdb:	c3                   	ret    

00800fdc <ltostr>:

void
ltostr(long value, char *str)
{
  800fdc:	55                   	push   %ebp
  800fdd:	89 e5                	mov    %esp,%ebp
  800fdf:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fe2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fe9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ff0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff4:	79 13                	jns    801009 <ltostr+0x2d>
	{
		neg = 1;
  800ff6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ffd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801000:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801003:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801006:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801011:	99                   	cltd   
  801012:	f7 f9                	idiv   %ecx
  801014:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801017:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101a:	8d 50 01             	lea    0x1(%eax),%edx
  80101d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801020:	89 c2                	mov    %eax,%edx
  801022:	8b 45 0c             	mov    0xc(%ebp),%eax
  801025:	01 d0                	add    %edx,%eax
  801027:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80102a:	83 c2 30             	add    $0x30,%edx
  80102d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80102f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801032:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801037:	f7 e9                	imul   %ecx
  801039:	c1 fa 02             	sar    $0x2,%edx
  80103c:	89 c8                	mov    %ecx,%eax
  80103e:	c1 f8 1f             	sar    $0x1f,%eax
  801041:	29 c2                	sub    %eax,%edx
  801043:	89 d0                	mov    %edx,%eax
  801045:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801048:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801050:	f7 e9                	imul   %ecx
  801052:	c1 fa 02             	sar    $0x2,%edx
  801055:	89 c8                	mov    %ecx,%eax
  801057:	c1 f8 1f             	sar    $0x1f,%eax
  80105a:	29 c2                	sub    %eax,%edx
  80105c:	89 d0                	mov    %edx,%eax
  80105e:	c1 e0 02             	shl    $0x2,%eax
  801061:	01 d0                	add    %edx,%eax
  801063:	01 c0                	add    %eax,%eax
  801065:	29 c1                	sub    %eax,%ecx
  801067:	89 ca                	mov    %ecx,%edx
  801069:	85 d2                	test   %edx,%edx
  80106b:	75 9c                	jne    801009 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80106d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801074:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801077:	48                   	dec    %eax
  801078:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80107b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80107f:	74 3d                	je     8010be <ltostr+0xe2>
		start = 1 ;
  801081:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801088:	eb 34                	jmp    8010be <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80108a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	01 d0                	add    %edx,%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801097:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109d:	01 c2                	add    %eax,%edx
  80109f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	01 c8                	add    %ecx,%eax
  8010a7:	8a 00                	mov    (%eax),%al
  8010a9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b1:	01 c2                	add    %eax,%edx
  8010b3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010b6:	88 02                	mov    %al,(%edx)
		start++ ;
  8010b8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010bb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010c4:	7c c4                	jl     80108a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cc:	01 d0                	add    %edx,%eax
  8010ce:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010d1:	90                   	nop
  8010d2:	c9                   	leave  
  8010d3:	c3                   	ret    

008010d4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010d4:	55                   	push   %ebp
  8010d5:	89 e5                	mov    %esp,%ebp
  8010d7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010da:	ff 75 08             	pushl  0x8(%ebp)
  8010dd:	e8 54 fa ff ff       	call   800b36 <strlen>
  8010e2:	83 c4 04             	add    $0x4,%esp
  8010e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010e8:	ff 75 0c             	pushl  0xc(%ebp)
  8010eb:	e8 46 fa ff ff       	call   800b36 <strlen>
  8010f0:	83 c4 04             	add    $0x4,%esp
  8010f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8010f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801104:	eb 17                	jmp    80111d <strcconcat+0x49>
		final[s] = str1[s] ;
  801106:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801109:	8b 45 10             	mov    0x10(%ebp),%eax
  80110c:	01 c2                	add    %eax,%edx
  80110e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	01 c8                	add    %ecx,%eax
  801116:	8a 00                	mov    (%eax),%al
  801118:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80111a:	ff 45 fc             	incl   -0x4(%ebp)
  80111d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801120:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801123:	7c e1                	jl     801106 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801125:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80112c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801133:	eb 1f                	jmp    801154 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801135:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801138:	8d 50 01             	lea    0x1(%eax),%edx
  80113b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80113e:	89 c2                	mov    %eax,%edx
  801140:	8b 45 10             	mov    0x10(%ebp),%eax
  801143:	01 c2                	add    %eax,%edx
  801145:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	01 c8                	add    %ecx,%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801151:	ff 45 f8             	incl   -0x8(%ebp)
  801154:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801157:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80115a:	7c d9                	jl     801135 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80115c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115f:	8b 45 10             	mov    0x10(%ebp),%eax
  801162:	01 d0                	add    %edx,%eax
  801164:	c6 00 00             	movb   $0x0,(%eax)
}
  801167:	90                   	nop
  801168:	c9                   	leave  
  801169:	c3                   	ret    

0080116a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80116a:	55                   	push   %ebp
  80116b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80116d:	8b 45 14             	mov    0x14(%ebp),%eax
  801170:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801176:	8b 45 14             	mov    0x14(%ebp),%eax
  801179:	8b 00                	mov    (%eax),%eax
  80117b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801182:	8b 45 10             	mov    0x10(%ebp),%eax
  801185:	01 d0                	add    %edx,%eax
  801187:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80118d:	eb 0c                	jmp    80119b <strsplit+0x31>
			*string++ = 0;
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	8d 50 01             	lea    0x1(%eax),%edx
  801195:	89 55 08             	mov    %edx,0x8(%ebp)
  801198:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	84 c0                	test   %al,%al
  8011a2:	74 18                	je     8011bc <strsplit+0x52>
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	0f be c0             	movsbl %al,%eax
  8011ac:	50                   	push   %eax
  8011ad:	ff 75 0c             	pushl  0xc(%ebp)
  8011b0:	e8 13 fb ff ff       	call   800cc8 <strchr>
  8011b5:	83 c4 08             	add    $0x8,%esp
  8011b8:	85 c0                	test   %eax,%eax
  8011ba:	75 d3                	jne    80118f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	84 c0                	test   %al,%al
  8011c3:	74 5a                	je     80121f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c8:	8b 00                	mov    (%eax),%eax
  8011ca:	83 f8 0f             	cmp    $0xf,%eax
  8011cd:	75 07                	jne    8011d6 <strsplit+0x6c>
		{
			return 0;
  8011cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8011d4:	eb 66                	jmp    80123c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d9:	8b 00                	mov    (%eax),%eax
  8011db:	8d 48 01             	lea    0x1(%eax),%ecx
  8011de:	8b 55 14             	mov    0x14(%ebp),%edx
  8011e1:	89 0a                	mov    %ecx,(%edx)
  8011e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	01 c2                	add    %eax,%edx
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011f4:	eb 03                	jmp    8011f9 <strsplit+0x8f>
			string++;
  8011f6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	84 c0                	test   %al,%al
  801200:	74 8b                	je     80118d <strsplit+0x23>
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	0f be c0             	movsbl %al,%eax
  80120a:	50                   	push   %eax
  80120b:	ff 75 0c             	pushl  0xc(%ebp)
  80120e:	e8 b5 fa ff ff       	call   800cc8 <strchr>
  801213:	83 c4 08             	add    $0x8,%esp
  801216:	85 c0                	test   %eax,%eax
  801218:	74 dc                	je     8011f6 <strsplit+0x8c>
			string++;
	}
  80121a:	e9 6e ff ff ff       	jmp    80118d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80121f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801220:	8b 45 14             	mov    0x14(%ebp),%eax
  801223:	8b 00                	mov    (%eax),%eax
  801225:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80122c:	8b 45 10             	mov    0x10(%ebp),%eax
  80122f:	01 d0                	add    %edx,%eax
  801231:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801237:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80123c:	c9                   	leave  
  80123d:	c3                   	ret    

0080123e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
  801241:	57                   	push   %edi
  801242:	56                   	push   %esi
  801243:	53                   	push   %ebx
  801244:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80124d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801250:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801253:	8b 7d 18             	mov    0x18(%ebp),%edi
  801256:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801259:	cd 30                	int    $0x30
  80125b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80125e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801261:	83 c4 10             	add    $0x10,%esp
  801264:	5b                   	pop    %ebx
  801265:	5e                   	pop    %esi
  801266:	5f                   	pop    %edi
  801267:	5d                   	pop    %ebp
  801268:	c3                   	ret    

00801269 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801269:	55                   	push   %ebp
  80126a:	89 e5                	mov    %esp,%ebp
  80126c:	83 ec 04             	sub    $0x4,%esp
  80126f:	8b 45 10             	mov    0x10(%ebp),%eax
  801272:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801275:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	52                   	push   %edx
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	50                   	push   %eax
  801285:	6a 00                	push   $0x0
  801287:	e8 b2 ff ff ff       	call   80123e <syscall>
  80128c:	83 c4 18             	add    $0x18,%esp
}
  80128f:	90                   	nop
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <sys_cgetc>:

int
sys_cgetc(void)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 01                	push   $0x1
  8012a1:	e8 98 ff ff ff       	call   80123e <syscall>
  8012a6:	83 c4 18             	add    $0x18,%esp
}
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	50                   	push   %eax
  8012ba:	6a 05                	push   $0x5
  8012bc:	e8 7d ff ff ff       	call   80123e <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 02                	push   $0x2
  8012d5:	e8 64 ff ff ff       	call   80123e <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 03                	push   $0x3
  8012ee:	e8 4b ff ff ff       	call   80123e <syscall>
  8012f3:	83 c4 18             	add    $0x18,%esp
}
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 04                	push   $0x4
  801307:	e8 32 ff ff ff       	call   80123e <syscall>
  80130c:	83 c4 18             	add    $0x18,%esp
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <sys_env_exit>:


void sys_env_exit(void)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 06                	push   $0x6
  801320:	e8 19 ff ff ff       	call   80123e <syscall>
  801325:	83 c4 18             	add    $0x18,%esp
}
  801328:	90                   	nop
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80132e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	52                   	push   %edx
  80133b:	50                   	push   %eax
  80133c:	6a 07                	push   $0x7
  80133e:	e8 fb fe ff ff       	call   80123e <syscall>
  801343:	83 c4 18             	add    $0x18,%esp
}
  801346:	c9                   	leave  
  801347:	c3                   	ret    

00801348 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
  80134b:	56                   	push   %esi
  80134c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80134d:	8b 75 18             	mov    0x18(%ebp),%esi
  801350:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801353:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801356:	8b 55 0c             	mov    0xc(%ebp),%edx
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	56                   	push   %esi
  80135d:	53                   	push   %ebx
  80135e:	51                   	push   %ecx
  80135f:	52                   	push   %edx
  801360:	50                   	push   %eax
  801361:	6a 08                	push   $0x8
  801363:	e8 d6 fe ff ff       	call   80123e <syscall>
  801368:	83 c4 18             	add    $0x18,%esp
}
  80136b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80136e:	5b                   	pop    %ebx
  80136f:	5e                   	pop    %esi
  801370:	5d                   	pop    %ebp
  801371:	c3                   	ret    

00801372 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801375:	8b 55 0c             	mov    0xc(%ebp),%edx
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	52                   	push   %edx
  801382:	50                   	push   %eax
  801383:	6a 09                	push   $0x9
  801385:	e8 b4 fe ff ff       	call   80123e <syscall>
  80138a:	83 c4 18             	add    $0x18,%esp
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	ff 75 0c             	pushl  0xc(%ebp)
  80139b:	ff 75 08             	pushl  0x8(%ebp)
  80139e:	6a 0a                	push   $0xa
  8013a0:	e8 99 fe ff ff       	call   80123e <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 0b                	push   $0xb
  8013b9:	e8 80 fe ff ff       	call   80123e <syscall>
  8013be:	83 c4 18             	add    $0x18,%esp
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 0c                	push   $0xc
  8013d2:	e8 67 fe ff ff       	call   80123e <syscall>
  8013d7:	83 c4 18             	add    $0x18,%esp
}
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 0d                	push   $0xd
  8013eb:	e8 4e fe ff ff       	call   80123e <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	c9                   	leave  
  8013f4:	c3                   	ret    

008013f5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	ff 75 0c             	pushl  0xc(%ebp)
  801401:	ff 75 08             	pushl  0x8(%ebp)
  801404:	6a 11                	push   $0x11
  801406:	e8 33 fe ff ff       	call   80123e <syscall>
  80140b:	83 c4 18             	add    $0x18,%esp
	return;
  80140e:	90                   	nop
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	ff 75 0c             	pushl  0xc(%ebp)
  80141d:	ff 75 08             	pushl  0x8(%ebp)
  801420:	6a 12                	push   $0x12
  801422:	e8 17 fe ff ff       	call   80123e <syscall>
  801427:	83 c4 18             	add    $0x18,%esp
	return ;
  80142a:	90                   	nop
}
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 0e                	push   $0xe
  80143c:	e8 fd fd ff ff       	call   80123e <syscall>
  801441:	83 c4 18             	add    $0x18,%esp
}
  801444:	c9                   	leave  
  801445:	c3                   	ret    

00801446 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801446:	55                   	push   %ebp
  801447:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	ff 75 08             	pushl  0x8(%ebp)
  801454:	6a 0f                	push   $0xf
  801456:	e8 e3 fd ff ff       	call   80123e <syscall>
  80145b:	83 c4 18             	add    $0x18,%esp
}
  80145e:	c9                   	leave  
  80145f:	c3                   	ret    

00801460 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801460:	55                   	push   %ebp
  801461:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 10                	push   $0x10
  80146f:	e8 ca fd ff ff       	call   80123e <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	90                   	nop
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 14                	push   $0x14
  801489:	e8 b0 fd ff ff       	call   80123e <syscall>
  80148e:	83 c4 18             	add    $0x18,%esp
}
  801491:	90                   	nop
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 15                	push   $0x15
  8014a3:	e8 96 fd ff ff       	call   80123e <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
}
  8014ab:	90                   	nop
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <sys_cputc>:


void
sys_cputc(const char c)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
  8014b1:	83 ec 04             	sub    $0x4,%esp
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014ba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	50                   	push   %eax
  8014c7:	6a 16                	push   $0x16
  8014c9:	e8 70 fd ff ff       	call   80123e <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
}
  8014d1:	90                   	nop
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 17                	push   $0x17
  8014e3:	e8 56 fd ff ff       	call   80123e <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	90                   	nop
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	ff 75 0c             	pushl  0xc(%ebp)
  8014fd:	50                   	push   %eax
  8014fe:	6a 18                	push   $0x18
  801500:	e8 39 fd ff ff       	call   80123e <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80150d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	52                   	push   %edx
  80151a:	50                   	push   %eax
  80151b:	6a 1b                	push   $0x1b
  80151d:	e8 1c fd ff ff       	call   80123e <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80152a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	52                   	push   %edx
  801537:	50                   	push   %eax
  801538:	6a 19                	push   $0x19
  80153a:	e8 ff fc ff ff       	call   80123e <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	90                   	nop
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801548:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	52                   	push   %edx
  801555:	50                   	push   %eax
  801556:	6a 1a                	push   $0x1a
  801558:	e8 e1 fc ff ff       	call   80123e <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
}
  801560:	90                   	nop
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
  801566:	83 ec 04             	sub    $0x4,%esp
  801569:	8b 45 10             	mov    0x10(%ebp),%eax
  80156c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80156f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801572:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	6a 00                	push   $0x0
  80157b:	51                   	push   %ecx
  80157c:	52                   	push   %edx
  80157d:	ff 75 0c             	pushl  0xc(%ebp)
  801580:	50                   	push   %eax
  801581:	6a 1c                	push   $0x1c
  801583:	e8 b6 fc ff ff       	call   80123e <syscall>
  801588:	83 c4 18             	add    $0x18,%esp
}
  80158b:	c9                   	leave  
  80158c:	c3                   	ret    

0080158d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801590:	8b 55 0c             	mov    0xc(%ebp),%edx
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	52                   	push   %edx
  80159d:	50                   	push   %eax
  80159e:	6a 1d                	push   $0x1d
  8015a0:	e8 99 fc ff ff       	call   80123e <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	51                   	push   %ecx
  8015bb:	52                   	push   %edx
  8015bc:	50                   	push   %eax
  8015bd:	6a 1e                	push   $0x1e
  8015bf:	e8 7a fc ff ff       	call   80123e <syscall>
  8015c4:	83 c4 18             	add    $0x18,%esp
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	52                   	push   %edx
  8015d9:	50                   	push   %eax
  8015da:	6a 1f                	push   $0x1f
  8015dc:	e8 5d fc ff ff       	call   80123e <syscall>
  8015e1:	83 c4 18             	add    $0x18,%esp
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 20                	push   $0x20
  8015f5:	e8 44 fc ff ff       	call   80123e <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
}
  8015fd:	c9                   	leave  
  8015fe:	c3                   	ret    

008015ff <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8015ff:	55                   	push   %ebp
  801600:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	ff 75 10             	pushl  0x10(%ebp)
  80160c:	ff 75 0c             	pushl  0xc(%ebp)
  80160f:	50                   	push   %eax
  801610:	6a 21                	push   $0x21
  801612:	e8 27 fc ff ff       	call   80123e <syscall>
  801617:	83 c4 18             	add    $0x18,%esp
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	50                   	push   %eax
  80162b:	6a 22                	push   $0x22
  80162d:	e8 0c fc ff ff       	call   80123e <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
}
  801635:	90                   	nop
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	50                   	push   %eax
  801647:	6a 23                	push   $0x23
  801649:	e8 f0 fb ff ff       	call   80123e <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	90                   	nop
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
  801657:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80165a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80165d:	8d 50 04             	lea    0x4(%eax),%edx
  801660:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	52                   	push   %edx
  80166a:	50                   	push   %eax
  80166b:	6a 24                	push   $0x24
  80166d:	e8 cc fb ff ff       	call   80123e <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
	return result;
  801675:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801678:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80167b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167e:	89 01                	mov    %eax,(%ecx)
  801680:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	c9                   	leave  
  801687:	c2 04 00             	ret    $0x4

0080168a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	ff 75 10             	pushl  0x10(%ebp)
  801694:	ff 75 0c             	pushl  0xc(%ebp)
  801697:	ff 75 08             	pushl  0x8(%ebp)
  80169a:	6a 13                	push   $0x13
  80169c:	e8 9d fb ff ff       	call   80123e <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a4:	90                   	nop
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 25                	push   $0x25
  8016b6:	e8 83 fb ff ff       	call   80123e <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
}
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
  8016c3:	83 ec 04             	sub    $0x4,%esp
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016cc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	50                   	push   %eax
  8016d9:	6a 26                	push   $0x26
  8016db:	e8 5e fb ff ff       	call   80123e <syscall>
  8016e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016e3:	90                   	nop
}
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <rsttst>:
void rsttst()
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 28                	push   $0x28
  8016f5:	e8 44 fb ff ff       	call   80123e <syscall>
  8016fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fd:	90                   	nop
}
  8016fe:	c9                   	leave  
  8016ff:	c3                   	ret    

00801700 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
  801703:	83 ec 04             	sub    $0x4,%esp
  801706:	8b 45 14             	mov    0x14(%ebp),%eax
  801709:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80170c:	8b 55 18             	mov    0x18(%ebp),%edx
  80170f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801713:	52                   	push   %edx
  801714:	50                   	push   %eax
  801715:	ff 75 10             	pushl  0x10(%ebp)
  801718:	ff 75 0c             	pushl  0xc(%ebp)
  80171b:	ff 75 08             	pushl  0x8(%ebp)
  80171e:	6a 27                	push   $0x27
  801720:	e8 19 fb ff ff       	call   80123e <syscall>
  801725:	83 c4 18             	add    $0x18,%esp
	return ;
  801728:	90                   	nop
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <chktst>:
void chktst(uint32 n)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	ff 75 08             	pushl  0x8(%ebp)
  801739:	6a 29                	push   $0x29
  80173b:	e8 fe fa ff ff       	call   80123e <syscall>
  801740:	83 c4 18             	add    $0x18,%esp
	return ;
  801743:	90                   	nop
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <inctst>:

void inctst()
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 2a                	push   $0x2a
  801755:	e8 e4 fa ff ff       	call   80123e <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
	return ;
  80175d:	90                   	nop
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <gettst>:
uint32 gettst()
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 2b                	push   $0x2b
  80176f:	e8 ca fa ff ff       	call   80123e <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
  80177c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 2c                	push   $0x2c
  80178b:	e8 ae fa ff ff       	call   80123e <syscall>
  801790:	83 c4 18             	add    $0x18,%esp
  801793:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801796:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80179a:	75 07                	jne    8017a3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80179c:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a1:	eb 05                	jmp    8017a8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a8:	c9                   	leave  
  8017a9:	c3                   	ret    

008017aa <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
  8017ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 2c                	push   $0x2c
  8017bc:	e8 7d fa ff ff       	call   80123e <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
  8017c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017c7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017cb:	75 07                	jne    8017d4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d2:	eb 05                	jmp    8017d9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
  8017de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 2c                	push   $0x2c
  8017ed:	e8 4c fa ff ff       	call   80123e <syscall>
  8017f2:	83 c4 18             	add    $0x18,%esp
  8017f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017f8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017fc:	75 07                	jne    801805 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801803:	eb 05                	jmp    80180a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801805:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 2c                	push   $0x2c
  80181e:	e8 1b fa ff ff       	call   80123e <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
  801826:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801829:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80182d:	75 07                	jne    801836 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80182f:	b8 01 00 00 00       	mov    $0x1,%eax
  801834:	eb 05                	jmp    80183b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801836:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80183b:	c9                   	leave  
  80183c:	c3                   	ret    

0080183d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80183d:	55                   	push   %ebp
  80183e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	ff 75 08             	pushl  0x8(%ebp)
  80184b:	6a 2d                	push   $0x2d
  80184d:	e8 ec f9 ff ff       	call   80123e <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
	return ;
  801855:	90                   	nop
}
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
  80185b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801864:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801868:	83 ec 0c             	sub    $0xc,%esp
  80186b:	50                   	push   %eax
  80186c:	e8 3d fc ff ff       	call   8014ae <sys_cputc>
  801871:	83 c4 10             	add    $0x10,%esp
}
  801874:	90                   	nop
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
  80187a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80187d:	e8 f8 fb ff ff       	call   80147a <sys_disable_interrupt>
	char c = ch;
  801882:	8b 45 08             	mov    0x8(%ebp),%eax
  801885:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801888:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80188c:	83 ec 0c             	sub    $0xc,%esp
  80188f:	50                   	push   %eax
  801890:	e8 19 fc ff ff       	call   8014ae <sys_cputc>
  801895:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801898:	e8 f7 fb ff ff       	call   801494 <sys_enable_interrupt>
}
  80189d:	90                   	nop
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <getchar>:

int
getchar(void)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
  8018a3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8018a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018ad:	eb 08                	jmp    8018b7 <getchar+0x17>
	{
		c = sys_cgetc();
  8018af:	e8 de f9 ff ff       	call   801292 <sys_cgetc>
  8018b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8018b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018bb:	74 f2                	je     8018af <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8018bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018c0:	c9                   	leave  
  8018c1:	c3                   	ret    

008018c2 <atomic_getchar>:

int
atomic_getchar(void)
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
  8018c5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018c8:	e8 ad fb ff ff       	call   80147a <sys_disable_interrupt>
	int c=0;
  8018cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018d4:	eb 08                	jmp    8018de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8018d6:	e8 b7 f9 ff ff       	call   801292 <sys_cgetc>
  8018db:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8018de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018e2:	74 f2                	je     8018d6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8018e4:	e8 ab fb ff ff       	call   801494 <sys_enable_interrupt>
	return c;
  8018e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <iscons>:

int iscons(int fdnum)
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8018f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8018f6:	5d                   	pop    %ebp
  8018f7:	c3                   	ret    

008018f8 <__udivdi3>:
  8018f8:	55                   	push   %ebp
  8018f9:	57                   	push   %edi
  8018fa:	56                   	push   %esi
  8018fb:	53                   	push   %ebx
  8018fc:	83 ec 1c             	sub    $0x1c,%esp
  8018ff:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801903:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801907:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80190b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80190f:	89 ca                	mov    %ecx,%edx
  801911:	89 f8                	mov    %edi,%eax
  801913:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801917:	85 f6                	test   %esi,%esi
  801919:	75 2d                	jne    801948 <__udivdi3+0x50>
  80191b:	39 cf                	cmp    %ecx,%edi
  80191d:	77 65                	ja     801984 <__udivdi3+0x8c>
  80191f:	89 fd                	mov    %edi,%ebp
  801921:	85 ff                	test   %edi,%edi
  801923:	75 0b                	jne    801930 <__udivdi3+0x38>
  801925:	b8 01 00 00 00       	mov    $0x1,%eax
  80192a:	31 d2                	xor    %edx,%edx
  80192c:	f7 f7                	div    %edi
  80192e:	89 c5                	mov    %eax,%ebp
  801930:	31 d2                	xor    %edx,%edx
  801932:	89 c8                	mov    %ecx,%eax
  801934:	f7 f5                	div    %ebp
  801936:	89 c1                	mov    %eax,%ecx
  801938:	89 d8                	mov    %ebx,%eax
  80193a:	f7 f5                	div    %ebp
  80193c:	89 cf                	mov    %ecx,%edi
  80193e:	89 fa                	mov    %edi,%edx
  801940:	83 c4 1c             	add    $0x1c,%esp
  801943:	5b                   	pop    %ebx
  801944:	5e                   	pop    %esi
  801945:	5f                   	pop    %edi
  801946:	5d                   	pop    %ebp
  801947:	c3                   	ret    
  801948:	39 ce                	cmp    %ecx,%esi
  80194a:	77 28                	ja     801974 <__udivdi3+0x7c>
  80194c:	0f bd fe             	bsr    %esi,%edi
  80194f:	83 f7 1f             	xor    $0x1f,%edi
  801952:	75 40                	jne    801994 <__udivdi3+0x9c>
  801954:	39 ce                	cmp    %ecx,%esi
  801956:	72 0a                	jb     801962 <__udivdi3+0x6a>
  801958:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80195c:	0f 87 9e 00 00 00    	ja     801a00 <__udivdi3+0x108>
  801962:	b8 01 00 00 00       	mov    $0x1,%eax
  801967:	89 fa                	mov    %edi,%edx
  801969:	83 c4 1c             	add    $0x1c,%esp
  80196c:	5b                   	pop    %ebx
  80196d:	5e                   	pop    %esi
  80196e:	5f                   	pop    %edi
  80196f:	5d                   	pop    %ebp
  801970:	c3                   	ret    
  801971:	8d 76 00             	lea    0x0(%esi),%esi
  801974:	31 ff                	xor    %edi,%edi
  801976:	31 c0                	xor    %eax,%eax
  801978:	89 fa                	mov    %edi,%edx
  80197a:	83 c4 1c             	add    $0x1c,%esp
  80197d:	5b                   	pop    %ebx
  80197e:	5e                   	pop    %esi
  80197f:	5f                   	pop    %edi
  801980:	5d                   	pop    %ebp
  801981:	c3                   	ret    
  801982:	66 90                	xchg   %ax,%ax
  801984:	89 d8                	mov    %ebx,%eax
  801986:	f7 f7                	div    %edi
  801988:	31 ff                	xor    %edi,%edi
  80198a:	89 fa                	mov    %edi,%edx
  80198c:	83 c4 1c             	add    $0x1c,%esp
  80198f:	5b                   	pop    %ebx
  801990:	5e                   	pop    %esi
  801991:	5f                   	pop    %edi
  801992:	5d                   	pop    %ebp
  801993:	c3                   	ret    
  801994:	bd 20 00 00 00       	mov    $0x20,%ebp
  801999:	89 eb                	mov    %ebp,%ebx
  80199b:	29 fb                	sub    %edi,%ebx
  80199d:	89 f9                	mov    %edi,%ecx
  80199f:	d3 e6                	shl    %cl,%esi
  8019a1:	89 c5                	mov    %eax,%ebp
  8019a3:	88 d9                	mov    %bl,%cl
  8019a5:	d3 ed                	shr    %cl,%ebp
  8019a7:	89 e9                	mov    %ebp,%ecx
  8019a9:	09 f1                	or     %esi,%ecx
  8019ab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019af:	89 f9                	mov    %edi,%ecx
  8019b1:	d3 e0                	shl    %cl,%eax
  8019b3:	89 c5                	mov    %eax,%ebp
  8019b5:	89 d6                	mov    %edx,%esi
  8019b7:	88 d9                	mov    %bl,%cl
  8019b9:	d3 ee                	shr    %cl,%esi
  8019bb:	89 f9                	mov    %edi,%ecx
  8019bd:	d3 e2                	shl    %cl,%edx
  8019bf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019c3:	88 d9                	mov    %bl,%cl
  8019c5:	d3 e8                	shr    %cl,%eax
  8019c7:	09 c2                	or     %eax,%edx
  8019c9:	89 d0                	mov    %edx,%eax
  8019cb:	89 f2                	mov    %esi,%edx
  8019cd:	f7 74 24 0c          	divl   0xc(%esp)
  8019d1:	89 d6                	mov    %edx,%esi
  8019d3:	89 c3                	mov    %eax,%ebx
  8019d5:	f7 e5                	mul    %ebp
  8019d7:	39 d6                	cmp    %edx,%esi
  8019d9:	72 19                	jb     8019f4 <__udivdi3+0xfc>
  8019db:	74 0b                	je     8019e8 <__udivdi3+0xf0>
  8019dd:	89 d8                	mov    %ebx,%eax
  8019df:	31 ff                	xor    %edi,%edi
  8019e1:	e9 58 ff ff ff       	jmp    80193e <__udivdi3+0x46>
  8019e6:	66 90                	xchg   %ax,%ax
  8019e8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019ec:	89 f9                	mov    %edi,%ecx
  8019ee:	d3 e2                	shl    %cl,%edx
  8019f0:	39 c2                	cmp    %eax,%edx
  8019f2:	73 e9                	jae    8019dd <__udivdi3+0xe5>
  8019f4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8019f7:	31 ff                	xor    %edi,%edi
  8019f9:	e9 40 ff ff ff       	jmp    80193e <__udivdi3+0x46>
  8019fe:	66 90                	xchg   %ax,%ax
  801a00:	31 c0                	xor    %eax,%eax
  801a02:	e9 37 ff ff ff       	jmp    80193e <__udivdi3+0x46>
  801a07:	90                   	nop

00801a08 <__umoddi3>:
  801a08:	55                   	push   %ebp
  801a09:	57                   	push   %edi
  801a0a:	56                   	push   %esi
  801a0b:	53                   	push   %ebx
  801a0c:	83 ec 1c             	sub    $0x1c,%esp
  801a0f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a13:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a1b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a23:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a27:	89 f3                	mov    %esi,%ebx
  801a29:	89 fa                	mov    %edi,%edx
  801a2b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a2f:	89 34 24             	mov    %esi,(%esp)
  801a32:	85 c0                	test   %eax,%eax
  801a34:	75 1a                	jne    801a50 <__umoddi3+0x48>
  801a36:	39 f7                	cmp    %esi,%edi
  801a38:	0f 86 a2 00 00 00    	jbe    801ae0 <__umoddi3+0xd8>
  801a3e:	89 c8                	mov    %ecx,%eax
  801a40:	89 f2                	mov    %esi,%edx
  801a42:	f7 f7                	div    %edi
  801a44:	89 d0                	mov    %edx,%eax
  801a46:	31 d2                	xor    %edx,%edx
  801a48:	83 c4 1c             	add    $0x1c,%esp
  801a4b:	5b                   	pop    %ebx
  801a4c:	5e                   	pop    %esi
  801a4d:	5f                   	pop    %edi
  801a4e:	5d                   	pop    %ebp
  801a4f:	c3                   	ret    
  801a50:	39 f0                	cmp    %esi,%eax
  801a52:	0f 87 ac 00 00 00    	ja     801b04 <__umoddi3+0xfc>
  801a58:	0f bd e8             	bsr    %eax,%ebp
  801a5b:	83 f5 1f             	xor    $0x1f,%ebp
  801a5e:	0f 84 ac 00 00 00    	je     801b10 <__umoddi3+0x108>
  801a64:	bf 20 00 00 00       	mov    $0x20,%edi
  801a69:	29 ef                	sub    %ebp,%edi
  801a6b:	89 fe                	mov    %edi,%esi
  801a6d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a71:	89 e9                	mov    %ebp,%ecx
  801a73:	d3 e0                	shl    %cl,%eax
  801a75:	89 d7                	mov    %edx,%edi
  801a77:	89 f1                	mov    %esi,%ecx
  801a79:	d3 ef                	shr    %cl,%edi
  801a7b:	09 c7                	or     %eax,%edi
  801a7d:	89 e9                	mov    %ebp,%ecx
  801a7f:	d3 e2                	shl    %cl,%edx
  801a81:	89 14 24             	mov    %edx,(%esp)
  801a84:	89 d8                	mov    %ebx,%eax
  801a86:	d3 e0                	shl    %cl,%eax
  801a88:	89 c2                	mov    %eax,%edx
  801a8a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a8e:	d3 e0                	shl    %cl,%eax
  801a90:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a94:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a98:	89 f1                	mov    %esi,%ecx
  801a9a:	d3 e8                	shr    %cl,%eax
  801a9c:	09 d0                	or     %edx,%eax
  801a9e:	d3 eb                	shr    %cl,%ebx
  801aa0:	89 da                	mov    %ebx,%edx
  801aa2:	f7 f7                	div    %edi
  801aa4:	89 d3                	mov    %edx,%ebx
  801aa6:	f7 24 24             	mull   (%esp)
  801aa9:	89 c6                	mov    %eax,%esi
  801aab:	89 d1                	mov    %edx,%ecx
  801aad:	39 d3                	cmp    %edx,%ebx
  801aaf:	0f 82 87 00 00 00    	jb     801b3c <__umoddi3+0x134>
  801ab5:	0f 84 91 00 00 00    	je     801b4c <__umoddi3+0x144>
  801abb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801abf:	29 f2                	sub    %esi,%edx
  801ac1:	19 cb                	sbb    %ecx,%ebx
  801ac3:	89 d8                	mov    %ebx,%eax
  801ac5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ac9:	d3 e0                	shl    %cl,%eax
  801acb:	89 e9                	mov    %ebp,%ecx
  801acd:	d3 ea                	shr    %cl,%edx
  801acf:	09 d0                	or     %edx,%eax
  801ad1:	89 e9                	mov    %ebp,%ecx
  801ad3:	d3 eb                	shr    %cl,%ebx
  801ad5:	89 da                	mov    %ebx,%edx
  801ad7:	83 c4 1c             	add    $0x1c,%esp
  801ada:	5b                   	pop    %ebx
  801adb:	5e                   	pop    %esi
  801adc:	5f                   	pop    %edi
  801add:	5d                   	pop    %ebp
  801ade:	c3                   	ret    
  801adf:	90                   	nop
  801ae0:	89 fd                	mov    %edi,%ebp
  801ae2:	85 ff                	test   %edi,%edi
  801ae4:	75 0b                	jne    801af1 <__umoddi3+0xe9>
  801ae6:	b8 01 00 00 00       	mov    $0x1,%eax
  801aeb:	31 d2                	xor    %edx,%edx
  801aed:	f7 f7                	div    %edi
  801aef:	89 c5                	mov    %eax,%ebp
  801af1:	89 f0                	mov    %esi,%eax
  801af3:	31 d2                	xor    %edx,%edx
  801af5:	f7 f5                	div    %ebp
  801af7:	89 c8                	mov    %ecx,%eax
  801af9:	f7 f5                	div    %ebp
  801afb:	89 d0                	mov    %edx,%eax
  801afd:	e9 44 ff ff ff       	jmp    801a46 <__umoddi3+0x3e>
  801b02:	66 90                	xchg   %ax,%ax
  801b04:	89 c8                	mov    %ecx,%eax
  801b06:	89 f2                	mov    %esi,%edx
  801b08:	83 c4 1c             	add    $0x1c,%esp
  801b0b:	5b                   	pop    %ebx
  801b0c:	5e                   	pop    %esi
  801b0d:	5f                   	pop    %edi
  801b0e:	5d                   	pop    %ebp
  801b0f:	c3                   	ret    
  801b10:	3b 04 24             	cmp    (%esp),%eax
  801b13:	72 06                	jb     801b1b <__umoddi3+0x113>
  801b15:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b19:	77 0f                	ja     801b2a <__umoddi3+0x122>
  801b1b:	89 f2                	mov    %esi,%edx
  801b1d:	29 f9                	sub    %edi,%ecx
  801b1f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b23:	89 14 24             	mov    %edx,(%esp)
  801b26:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b2a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b2e:	8b 14 24             	mov    (%esp),%edx
  801b31:	83 c4 1c             	add    $0x1c,%esp
  801b34:	5b                   	pop    %ebx
  801b35:	5e                   	pop    %esi
  801b36:	5f                   	pop    %edi
  801b37:	5d                   	pop    %ebp
  801b38:	c3                   	ret    
  801b39:	8d 76 00             	lea    0x0(%esi),%esi
  801b3c:	2b 04 24             	sub    (%esp),%eax
  801b3f:	19 fa                	sbb    %edi,%edx
  801b41:	89 d1                	mov    %edx,%ecx
  801b43:	89 c6                	mov    %eax,%esi
  801b45:	e9 71 ff ff ff       	jmp    801abb <__umoddi3+0xb3>
  801b4a:	66 90                	xchg   %ax,%ax
  801b4c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b50:	72 ea                	jb     801b3c <__umoddi3+0x134>
  801b52:	89 d9                	mov    %ebx,%ecx
  801b54:	e9 62 ff ff ff       	jmp    801abb <__umoddi3+0xb3>
