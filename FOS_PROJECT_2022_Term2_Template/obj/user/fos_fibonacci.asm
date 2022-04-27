
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 ab 00 00 00       	call   8000e1 <libmain>
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
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 80 1b 80 00       	push   $0x801b80
  800057:	e8 e8 09 00 00       	call   800a44 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 3a 0e 00 00       	call   800eac <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 9e 1b 80 00       	push   $0x801b9e
  800097:	e8 55 02 00 00       	call   8002f1 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <fibonacci>:


int fibonacci(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	53                   	push   %ebx
  8000a6:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  8000a9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ad:	7f 07                	jg     8000b6 <fibonacci+0x14>
		return 1 ;
  8000af:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b4:	eb 26                	jmp    8000dc <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b9:	48                   	dec    %eax
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	50                   	push   %eax
  8000be:	e8 df ff ff ff       	call   8000a2 <fibonacci>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 c3                	mov    %eax,%ebx
  8000c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cb:	83 e8 02             	sub    $0x2,%eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 cb ff ff ff       	call   8000a2 <fibonacci>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	01 d8                	add    %ebx,%eax
}
  8000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000df:	c9                   	leave  
  8000e0:	c3                   	ret    

008000e1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000e1:	55                   	push   %ebp
  8000e2:	89 e5                	mov    %esp,%ebp
  8000e4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e7:	e8 09 12 00 00       	call   8012f5 <sys_getenvindex>
  8000ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	c1 e0 02             	shl    $0x2,%eax
  8000f7:	01 d0                	add    %edx,%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	01 d0                	add    %edx,%eax
  8000fd:	01 c0                	add    %eax,%eax
  8000ff:	01 d0                	add    %edx,%eax
  800101:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800108:	01 d0                	add    %edx,%eax
  80010a:	c1 e0 02             	shl    $0x2,%eax
  80010d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800112:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800117:	a1 04 20 80 00       	mov    0x802004,%eax
  80011c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800122:	84 c0                	test   %al,%al
  800124:	74 0f                	je     800135 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800126:	a1 04 20 80 00       	mov    0x802004,%eax
  80012b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800130:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800135:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800139:	7e 0a                	jle    800145 <libmain+0x64>
		binaryname = argv[0];
  80013b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80013e:	8b 00                	mov    (%eax),%eax
  800140:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800145:	83 ec 08             	sub    $0x8,%esp
  800148:	ff 75 0c             	pushl  0xc(%ebp)
  80014b:	ff 75 08             	pushl  0x8(%ebp)
  80014e:	e8 e5 fe ff ff       	call   800038 <_main>
  800153:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800156:	e8 35 13 00 00       	call   801490 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	68 cc 1b 80 00       	push   $0x801bcc
  800163:	e8 5c 01 00 00       	call   8002c4 <cprintf>
  800168:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80016b:	a1 04 20 80 00       	mov    0x802004,%eax
  800170:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800176:	a1 04 20 80 00       	mov    0x802004,%eax
  80017b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800181:	83 ec 04             	sub    $0x4,%esp
  800184:	52                   	push   %edx
  800185:	50                   	push   %eax
  800186:	68 f4 1b 80 00       	push   $0x801bf4
  80018b:	e8 34 01 00 00       	call   8002c4 <cprintf>
  800190:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800193:	a1 04 20 80 00       	mov    0x802004,%eax
  800198:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	50                   	push   %eax
  8001a2:	68 19 1c 80 00       	push   $0x801c19
  8001a7:	e8 18 01 00 00       	call   8002c4 <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001af:	83 ec 0c             	sub    $0xc,%esp
  8001b2:	68 cc 1b 80 00       	push   $0x801bcc
  8001b7:	e8 08 01 00 00       	call   8002c4 <cprintf>
  8001bc:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001bf:	e8 e6 12 00 00       	call   8014aa <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001c4:	e8 19 00 00 00       	call   8001e2 <exit>
}
  8001c9:	90                   	nop
  8001ca:	c9                   	leave  
  8001cb:	c3                   	ret    

008001cc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001cc:	55                   	push   %ebp
  8001cd:	89 e5                	mov    %esp,%ebp
  8001cf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	6a 00                	push   $0x0
  8001d7:	e8 e5 10 00 00       	call   8012c1 <sys_env_destroy>
  8001dc:	83 c4 10             	add    $0x10,%esp
}
  8001df:	90                   	nop
  8001e0:	c9                   	leave  
  8001e1:	c3                   	ret    

008001e2 <exit>:

void
exit(void)
{
  8001e2:	55                   	push   %ebp
  8001e3:	89 e5                	mov    %esp,%ebp
  8001e5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001e8:	e8 3a 11 00 00       	call   801327 <sys_env_exit>
}
  8001ed:	90                   	nop
  8001ee:	c9                   	leave  
  8001ef:	c3                   	ret    

008001f0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001f0:	55                   	push   %ebp
  8001f1:	89 e5                	mov    %esp,%ebp
  8001f3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	8d 48 01             	lea    0x1(%eax),%ecx
  8001fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800201:	89 0a                	mov    %ecx,(%edx)
  800203:	8b 55 08             	mov    0x8(%ebp),%edx
  800206:	88 d1                	mov    %dl,%cl
  800208:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80020f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800212:	8b 00                	mov    (%eax),%eax
  800214:	3d ff 00 00 00       	cmp    $0xff,%eax
  800219:	75 2c                	jne    800247 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80021b:	a0 08 20 80 00       	mov    0x802008,%al
  800220:	0f b6 c0             	movzbl %al,%eax
  800223:	8b 55 0c             	mov    0xc(%ebp),%edx
  800226:	8b 12                	mov    (%edx),%edx
  800228:	89 d1                	mov    %edx,%ecx
  80022a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80022d:	83 c2 08             	add    $0x8,%edx
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	50                   	push   %eax
  800234:	51                   	push   %ecx
  800235:	52                   	push   %edx
  800236:	e8 44 10 00 00       	call   80127f <sys_cputs>
  80023b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80023e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024a:	8b 40 04             	mov    0x4(%eax),%eax
  80024d:	8d 50 01             	lea    0x1(%eax),%edx
  800250:	8b 45 0c             	mov    0xc(%ebp),%eax
  800253:	89 50 04             	mov    %edx,0x4(%eax)
}
  800256:	90                   	nop
  800257:	c9                   	leave  
  800258:	c3                   	ret    

00800259 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800259:	55                   	push   %ebp
  80025a:	89 e5                	mov    %esp,%ebp
  80025c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800262:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800269:	00 00 00 
	b.cnt = 0;
  80026c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800273:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800276:	ff 75 0c             	pushl  0xc(%ebp)
  800279:	ff 75 08             	pushl  0x8(%ebp)
  80027c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800282:	50                   	push   %eax
  800283:	68 f0 01 80 00       	push   $0x8001f0
  800288:	e8 11 02 00 00       	call   80049e <vprintfmt>
  80028d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800290:	a0 08 20 80 00       	mov    0x802008,%al
  800295:	0f b6 c0             	movzbl %al,%eax
  800298:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80029e:	83 ec 04             	sub    $0x4,%esp
  8002a1:	50                   	push   %eax
  8002a2:	52                   	push   %edx
  8002a3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a9:	83 c0 08             	add    $0x8,%eax
  8002ac:	50                   	push   %eax
  8002ad:	e8 cd 0f 00 00       	call   80127f <sys_cputs>
  8002b2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002b5:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  8002bc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002ca:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002d1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e0:	50                   	push   %eax
  8002e1:	e8 73 ff ff ff       	call   800259 <vcprintf>
  8002e6:	83 c4 10             	add    $0x10,%esp
  8002e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ef:	c9                   	leave  
  8002f0:	c3                   	ret    

008002f1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002f1:	55                   	push   %ebp
  8002f2:	89 e5                	mov    %esp,%ebp
  8002f4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002f7:	e8 94 11 00 00       	call   801490 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002fc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800302:	8b 45 08             	mov    0x8(%ebp),%eax
  800305:	83 ec 08             	sub    $0x8,%esp
  800308:	ff 75 f4             	pushl  -0xc(%ebp)
  80030b:	50                   	push   %eax
  80030c:	e8 48 ff ff ff       	call   800259 <vcprintf>
  800311:	83 c4 10             	add    $0x10,%esp
  800314:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800317:	e8 8e 11 00 00       	call   8014aa <sys_enable_interrupt>
	return cnt;
  80031c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80031f:	c9                   	leave  
  800320:	c3                   	ret    

00800321 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800321:	55                   	push   %ebp
  800322:	89 e5                	mov    %esp,%ebp
  800324:	53                   	push   %ebx
  800325:	83 ec 14             	sub    $0x14,%esp
  800328:	8b 45 10             	mov    0x10(%ebp),%eax
  80032b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80032e:	8b 45 14             	mov    0x14(%ebp),%eax
  800331:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800334:	8b 45 18             	mov    0x18(%ebp),%eax
  800337:	ba 00 00 00 00       	mov    $0x0,%edx
  80033c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033f:	77 55                	ja     800396 <printnum+0x75>
  800341:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800344:	72 05                	jb     80034b <printnum+0x2a>
  800346:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800349:	77 4b                	ja     800396 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80034b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80034e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800351:	8b 45 18             	mov    0x18(%ebp),%eax
  800354:	ba 00 00 00 00       	mov    $0x0,%edx
  800359:	52                   	push   %edx
  80035a:	50                   	push   %eax
  80035b:	ff 75 f4             	pushl  -0xc(%ebp)
  80035e:	ff 75 f0             	pushl  -0x10(%ebp)
  800361:	e8 aa 15 00 00       	call   801910 <__udivdi3>
  800366:	83 c4 10             	add    $0x10,%esp
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	ff 75 20             	pushl  0x20(%ebp)
  80036f:	53                   	push   %ebx
  800370:	ff 75 18             	pushl  0x18(%ebp)
  800373:	52                   	push   %edx
  800374:	50                   	push   %eax
  800375:	ff 75 0c             	pushl  0xc(%ebp)
  800378:	ff 75 08             	pushl  0x8(%ebp)
  80037b:	e8 a1 ff ff ff       	call   800321 <printnum>
  800380:	83 c4 20             	add    $0x20,%esp
  800383:	eb 1a                	jmp    80039f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800385:	83 ec 08             	sub    $0x8,%esp
  800388:	ff 75 0c             	pushl  0xc(%ebp)
  80038b:	ff 75 20             	pushl  0x20(%ebp)
  80038e:	8b 45 08             	mov    0x8(%ebp),%eax
  800391:	ff d0                	call   *%eax
  800393:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800396:	ff 4d 1c             	decl   0x1c(%ebp)
  800399:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80039d:	7f e6                	jg     800385 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80039f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003a2:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ad:	53                   	push   %ebx
  8003ae:	51                   	push   %ecx
  8003af:	52                   	push   %edx
  8003b0:	50                   	push   %eax
  8003b1:	e8 6a 16 00 00       	call   801a20 <__umoddi3>
  8003b6:	83 c4 10             	add    $0x10,%esp
  8003b9:	05 54 1e 80 00       	add    $0x801e54,%eax
  8003be:	8a 00                	mov    (%eax),%al
  8003c0:	0f be c0             	movsbl %al,%eax
  8003c3:	83 ec 08             	sub    $0x8,%esp
  8003c6:	ff 75 0c             	pushl  0xc(%ebp)
  8003c9:	50                   	push   %eax
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	ff d0                	call   *%eax
  8003cf:	83 c4 10             	add    $0x10,%esp
}
  8003d2:	90                   	nop
  8003d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d6:	c9                   	leave  
  8003d7:	c3                   	ret    

008003d8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003d8:	55                   	push   %ebp
  8003d9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003db:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003df:	7e 1c                	jle    8003fd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	8d 50 08             	lea    0x8(%eax),%edx
  8003e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ec:	89 10                	mov    %edx,(%eax)
  8003ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	83 e8 08             	sub    $0x8,%eax
  8003f6:	8b 50 04             	mov    0x4(%eax),%edx
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	eb 40                	jmp    80043d <getuint+0x65>
	else if (lflag)
  8003fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800401:	74 1e                	je     800421 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	8d 50 04             	lea    0x4(%eax),%edx
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	89 10                	mov    %edx,(%eax)
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	83 e8 04             	sub    $0x4,%eax
  800418:	8b 00                	mov    (%eax),%eax
  80041a:	ba 00 00 00 00       	mov    $0x0,%edx
  80041f:	eb 1c                	jmp    80043d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	8b 00                	mov    (%eax),%eax
  800426:	8d 50 04             	lea    0x4(%eax),%edx
  800429:	8b 45 08             	mov    0x8(%ebp),%eax
  80042c:	89 10                	mov    %edx,(%eax)
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	83 e8 04             	sub    $0x4,%eax
  800436:	8b 00                	mov    (%eax),%eax
  800438:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80043d:	5d                   	pop    %ebp
  80043e:	c3                   	ret    

0080043f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80043f:	55                   	push   %ebp
  800440:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800442:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800446:	7e 1c                	jle    800464 <getint+0x25>
		return va_arg(*ap, long long);
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	8d 50 08             	lea    0x8(%eax),%edx
  800450:	8b 45 08             	mov    0x8(%ebp),%eax
  800453:	89 10                	mov    %edx,(%eax)
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	83 e8 08             	sub    $0x8,%eax
  80045d:	8b 50 04             	mov    0x4(%eax),%edx
  800460:	8b 00                	mov    (%eax),%eax
  800462:	eb 38                	jmp    80049c <getint+0x5d>
	else if (lflag)
  800464:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800468:	74 1a                	je     800484 <getint+0x45>
		return va_arg(*ap, long);
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	8b 00                	mov    (%eax),%eax
  80046f:	8d 50 04             	lea    0x4(%eax),%edx
  800472:	8b 45 08             	mov    0x8(%ebp),%eax
  800475:	89 10                	mov    %edx,(%eax)
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	83 e8 04             	sub    $0x4,%eax
  80047f:	8b 00                	mov    (%eax),%eax
  800481:	99                   	cltd   
  800482:	eb 18                	jmp    80049c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	8d 50 04             	lea    0x4(%eax),%edx
  80048c:	8b 45 08             	mov    0x8(%ebp),%eax
  80048f:	89 10                	mov    %edx,(%eax)
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	83 e8 04             	sub    $0x4,%eax
  800499:	8b 00                	mov    (%eax),%eax
  80049b:	99                   	cltd   
}
  80049c:	5d                   	pop    %ebp
  80049d:	c3                   	ret    

0080049e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80049e:	55                   	push   %ebp
  80049f:	89 e5                	mov    %esp,%ebp
  8004a1:	56                   	push   %esi
  8004a2:	53                   	push   %ebx
  8004a3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a6:	eb 17                	jmp    8004bf <vprintfmt+0x21>
			if (ch == '\0')
  8004a8:	85 db                	test   %ebx,%ebx
  8004aa:	0f 84 af 03 00 00    	je     80085f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004b0:	83 ec 08             	sub    $0x8,%esp
  8004b3:	ff 75 0c             	pushl  0xc(%ebp)
  8004b6:	53                   	push   %ebx
  8004b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ba:	ff d0                	call   *%eax
  8004bc:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c2:	8d 50 01             	lea    0x1(%eax),%edx
  8004c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c8:	8a 00                	mov    (%eax),%al
  8004ca:	0f b6 d8             	movzbl %al,%ebx
  8004cd:	83 fb 25             	cmp    $0x25,%ebx
  8004d0:	75 d6                	jne    8004a8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004d2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004d6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004dd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004e4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004eb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f5:	8d 50 01             	lea    0x1(%eax),%edx
  8004f8:	89 55 10             	mov    %edx,0x10(%ebp)
  8004fb:	8a 00                	mov    (%eax),%al
  8004fd:	0f b6 d8             	movzbl %al,%ebx
  800500:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800503:	83 f8 55             	cmp    $0x55,%eax
  800506:	0f 87 2b 03 00 00    	ja     800837 <vprintfmt+0x399>
  80050c:	8b 04 85 78 1e 80 00 	mov    0x801e78(,%eax,4),%eax
  800513:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800515:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800519:	eb d7                	jmp    8004f2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80051b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80051f:	eb d1                	jmp    8004f2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800521:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800528:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80052b:	89 d0                	mov    %edx,%eax
  80052d:	c1 e0 02             	shl    $0x2,%eax
  800530:	01 d0                	add    %edx,%eax
  800532:	01 c0                	add    %eax,%eax
  800534:	01 d8                	add    %ebx,%eax
  800536:	83 e8 30             	sub    $0x30,%eax
  800539:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80053c:	8b 45 10             	mov    0x10(%ebp),%eax
  80053f:	8a 00                	mov    (%eax),%al
  800541:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800544:	83 fb 2f             	cmp    $0x2f,%ebx
  800547:	7e 3e                	jle    800587 <vprintfmt+0xe9>
  800549:	83 fb 39             	cmp    $0x39,%ebx
  80054c:	7f 39                	jg     800587 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80054e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800551:	eb d5                	jmp    800528 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800553:	8b 45 14             	mov    0x14(%ebp),%eax
  800556:	83 c0 04             	add    $0x4,%eax
  800559:	89 45 14             	mov    %eax,0x14(%ebp)
  80055c:	8b 45 14             	mov    0x14(%ebp),%eax
  80055f:	83 e8 04             	sub    $0x4,%eax
  800562:	8b 00                	mov    (%eax),%eax
  800564:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800567:	eb 1f                	jmp    800588 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800569:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80056d:	79 83                	jns    8004f2 <vprintfmt+0x54>
				width = 0;
  80056f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800576:	e9 77 ff ff ff       	jmp    8004f2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80057b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800582:	e9 6b ff ff ff       	jmp    8004f2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800587:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800588:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80058c:	0f 89 60 ff ff ff    	jns    8004f2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800592:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800595:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800598:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80059f:	e9 4e ff ff ff       	jmp    8004f2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005a4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005a7:	e9 46 ff ff ff       	jmp    8004f2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 c0 04             	add    $0x4,%eax
  8005b2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b8:	83 e8 04             	sub    $0x4,%eax
  8005bb:	8b 00                	mov    (%eax),%eax
  8005bd:	83 ec 08             	sub    $0x8,%esp
  8005c0:	ff 75 0c             	pushl  0xc(%ebp)
  8005c3:	50                   	push   %eax
  8005c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c7:	ff d0                	call   *%eax
  8005c9:	83 c4 10             	add    $0x10,%esp
			break;
  8005cc:	e9 89 02 00 00       	jmp    80085a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d4:	83 c0 04             	add    $0x4,%eax
  8005d7:	89 45 14             	mov    %eax,0x14(%ebp)
  8005da:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dd:	83 e8 04             	sub    $0x4,%eax
  8005e0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005e2:	85 db                	test   %ebx,%ebx
  8005e4:	79 02                	jns    8005e8 <vprintfmt+0x14a>
				err = -err;
  8005e6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005e8:	83 fb 64             	cmp    $0x64,%ebx
  8005eb:	7f 0b                	jg     8005f8 <vprintfmt+0x15a>
  8005ed:	8b 34 9d c0 1c 80 00 	mov    0x801cc0(,%ebx,4),%esi
  8005f4:	85 f6                	test   %esi,%esi
  8005f6:	75 19                	jne    800611 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005f8:	53                   	push   %ebx
  8005f9:	68 65 1e 80 00       	push   $0x801e65
  8005fe:	ff 75 0c             	pushl  0xc(%ebp)
  800601:	ff 75 08             	pushl  0x8(%ebp)
  800604:	e8 5e 02 00 00       	call   800867 <printfmt>
  800609:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80060c:	e9 49 02 00 00       	jmp    80085a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800611:	56                   	push   %esi
  800612:	68 6e 1e 80 00       	push   $0x801e6e
  800617:	ff 75 0c             	pushl  0xc(%ebp)
  80061a:	ff 75 08             	pushl  0x8(%ebp)
  80061d:	e8 45 02 00 00       	call   800867 <printfmt>
  800622:	83 c4 10             	add    $0x10,%esp
			break;
  800625:	e9 30 02 00 00       	jmp    80085a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80062a:	8b 45 14             	mov    0x14(%ebp),%eax
  80062d:	83 c0 04             	add    $0x4,%eax
  800630:	89 45 14             	mov    %eax,0x14(%ebp)
  800633:	8b 45 14             	mov    0x14(%ebp),%eax
  800636:	83 e8 04             	sub    $0x4,%eax
  800639:	8b 30                	mov    (%eax),%esi
  80063b:	85 f6                	test   %esi,%esi
  80063d:	75 05                	jne    800644 <vprintfmt+0x1a6>
				p = "(null)";
  80063f:	be 71 1e 80 00       	mov    $0x801e71,%esi
			if (width > 0 && padc != '-')
  800644:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800648:	7e 6d                	jle    8006b7 <vprintfmt+0x219>
  80064a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80064e:	74 67                	je     8006b7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800650:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800653:	83 ec 08             	sub    $0x8,%esp
  800656:	50                   	push   %eax
  800657:	56                   	push   %esi
  800658:	e8 12 05 00 00       	call   800b6f <strnlen>
  80065d:	83 c4 10             	add    $0x10,%esp
  800660:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800663:	eb 16                	jmp    80067b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800665:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800669:	83 ec 08             	sub    $0x8,%esp
  80066c:	ff 75 0c             	pushl  0xc(%ebp)
  80066f:	50                   	push   %eax
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	ff d0                	call   *%eax
  800675:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800678:	ff 4d e4             	decl   -0x1c(%ebp)
  80067b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067f:	7f e4                	jg     800665 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800681:	eb 34                	jmp    8006b7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800683:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800687:	74 1c                	je     8006a5 <vprintfmt+0x207>
  800689:	83 fb 1f             	cmp    $0x1f,%ebx
  80068c:	7e 05                	jle    800693 <vprintfmt+0x1f5>
  80068e:	83 fb 7e             	cmp    $0x7e,%ebx
  800691:	7e 12                	jle    8006a5 <vprintfmt+0x207>
					putch('?', putdat);
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	ff 75 0c             	pushl  0xc(%ebp)
  800699:	6a 3f                	push   $0x3f
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
  8006a3:	eb 0f                	jmp    8006b4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006a5:	83 ec 08             	sub    $0x8,%esp
  8006a8:	ff 75 0c             	pushl  0xc(%ebp)
  8006ab:	53                   	push   %ebx
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	ff d0                	call   *%eax
  8006b1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b4:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b7:	89 f0                	mov    %esi,%eax
  8006b9:	8d 70 01             	lea    0x1(%eax),%esi
  8006bc:	8a 00                	mov    (%eax),%al
  8006be:	0f be d8             	movsbl %al,%ebx
  8006c1:	85 db                	test   %ebx,%ebx
  8006c3:	74 24                	je     8006e9 <vprintfmt+0x24b>
  8006c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c9:	78 b8                	js     800683 <vprintfmt+0x1e5>
  8006cb:	ff 4d e0             	decl   -0x20(%ebp)
  8006ce:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d2:	79 af                	jns    800683 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d4:	eb 13                	jmp    8006e9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006d6:	83 ec 08             	sub    $0x8,%esp
  8006d9:	ff 75 0c             	pushl  0xc(%ebp)
  8006dc:	6a 20                	push   $0x20
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	ff d0                	call   *%eax
  8006e3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e6:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ed:	7f e7                	jg     8006d6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ef:	e9 66 01 00 00       	jmp    80085a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	ff 75 e8             	pushl  -0x18(%ebp)
  8006fa:	8d 45 14             	lea    0x14(%ebp),%eax
  8006fd:	50                   	push   %eax
  8006fe:	e8 3c fd ff ff       	call   80043f <getint>
  800703:	83 c4 10             	add    $0x10,%esp
  800706:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800709:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80070c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800712:	85 d2                	test   %edx,%edx
  800714:	79 23                	jns    800739 <vprintfmt+0x29b>
				putch('-', putdat);
  800716:	83 ec 08             	sub    $0x8,%esp
  800719:	ff 75 0c             	pushl  0xc(%ebp)
  80071c:	6a 2d                	push   $0x2d
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	ff d0                	call   *%eax
  800723:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800726:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800729:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80072c:	f7 d8                	neg    %eax
  80072e:	83 d2 00             	adc    $0x0,%edx
  800731:	f7 da                	neg    %edx
  800733:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800736:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800739:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800740:	e9 bc 00 00 00       	jmp    800801 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800745:	83 ec 08             	sub    $0x8,%esp
  800748:	ff 75 e8             	pushl  -0x18(%ebp)
  80074b:	8d 45 14             	lea    0x14(%ebp),%eax
  80074e:	50                   	push   %eax
  80074f:	e8 84 fc ff ff       	call   8003d8 <getuint>
  800754:	83 c4 10             	add    $0x10,%esp
  800757:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80075d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800764:	e9 98 00 00 00       	jmp    800801 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 0c             	pushl  0xc(%ebp)
  80076f:	6a 58                	push   $0x58
  800771:	8b 45 08             	mov    0x8(%ebp),%eax
  800774:	ff d0                	call   *%eax
  800776:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	6a 58                	push   $0x58
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	ff d0                	call   *%eax
  800786:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	6a 58                	push   $0x58
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	ff d0                	call   *%eax
  800796:	83 c4 10             	add    $0x10,%esp
			break;
  800799:	e9 bc 00 00 00       	jmp    80085a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80079e:	83 ec 08             	sub    $0x8,%esp
  8007a1:	ff 75 0c             	pushl  0xc(%ebp)
  8007a4:	6a 30                	push   $0x30
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	ff d0                	call   *%eax
  8007ab:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 0c             	pushl  0xc(%ebp)
  8007b4:	6a 78                	push   $0x78
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	ff d0                	call   *%eax
  8007bb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007be:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c1:	83 c0 04             	add    $0x4,%eax
  8007c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ca:	83 e8 04             	sub    $0x4,%eax
  8007cd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007e0:	eb 1f                	jmp    800801 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e8:	8d 45 14             	lea    0x14(%ebp),%eax
  8007eb:	50                   	push   %eax
  8007ec:	e8 e7 fb ff ff       	call   8003d8 <getuint>
  8007f1:	83 c4 10             	add    $0x10,%esp
  8007f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007fa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800801:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800805:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800808:	83 ec 04             	sub    $0x4,%esp
  80080b:	52                   	push   %edx
  80080c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80080f:	50                   	push   %eax
  800810:	ff 75 f4             	pushl  -0xc(%ebp)
  800813:	ff 75 f0             	pushl  -0x10(%ebp)
  800816:	ff 75 0c             	pushl  0xc(%ebp)
  800819:	ff 75 08             	pushl  0x8(%ebp)
  80081c:	e8 00 fb ff ff       	call   800321 <printnum>
  800821:	83 c4 20             	add    $0x20,%esp
			break;
  800824:	eb 34                	jmp    80085a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	53                   	push   %ebx
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	ff d0                	call   *%eax
  800832:	83 c4 10             	add    $0x10,%esp
			break;
  800835:	eb 23                	jmp    80085a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800837:	83 ec 08             	sub    $0x8,%esp
  80083a:	ff 75 0c             	pushl  0xc(%ebp)
  80083d:	6a 25                	push   $0x25
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	ff d0                	call   *%eax
  800844:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800847:	ff 4d 10             	decl   0x10(%ebp)
  80084a:	eb 03                	jmp    80084f <vprintfmt+0x3b1>
  80084c:	ff 4d 10             	decl   0x10(%ebp)
  80084f:	8b 45 10             	mov    0x10(%ebp),%eax
  800852:	48                   	dec    %eax
  800853:	8a 00                	mov    (%eax),%al
  800855:	3c 25                	cmp    $0x25,%al
  800857:	75 f3                	jne    80084c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800859:	90                   	nop
		}
	}
  80085a:	e9 47 fc ff ff       	jmp    8004a6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80085f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800860:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800863:	5b                   	pop    %ebx
  800864:	5e                   	pop    %esi
  800865:	5d                   	pop    %ebp
  800866:	c3                   	ret    

00800867 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800867:	55                   	push   %ebp
  800868:	89 e5                	mov    %esp,%ebp
  80086a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80086d:	8d 45 10             	lea    0x10(%ebp),%eax
  800870:	83 c0 04             	add    $0x4,%eax
  800873:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800876:	8b 45 10             	mov    0x10(%ebp),%eax
  800879:	ff 75 f4             	pushl  -0xc(%ebp)
  80087c:	50                   	push   %eax
  80087d:	ff 75 0c             	pushl  0xc(%ebp)
  800880:	ff 75 08             	pushl  0x8(%ebp)
  800883:	e8 16 fc ff ff       	call   80049e <vprintfmt>
  800888:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80088b:	90                   	nop
  80088c:	c9                   	leave  
  80088d:	c3                   	ret    

0080088e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80088e:	55                   	push   %ebp
  80088f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	8b 40 08             	mov    0x8(%eax),%eax
  800897:	8d 50 01             	lea    0x1(%eax),%edx
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a3:	8b 10                	mov    (%eax),%edx
  8008a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a8:	8b 40 04             	mov    0x4(%eax),%eax
  8008ab:	39 c2                	cmp    %eax,%edx
  8008ad:	73 12                	jae    8008c1 <sprintputch+0x33>
		*b->buf++ = ch;
  8008af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ba:	89 0a                	mov    %ecx,(%edx)
  8008bc:	8b 55 08             	mov    0x8(%ebp),%edx
  8008bf:	88 10                	mov    %dl,(%eax)
}
  8008c1:	90                   	nop
  8008c2:	5d                   	pop    %ebp
  8008c3:	c3                   	ret    

008008c4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008c4:	55                   	push   %ebp
  8008c5:	89 e5                	mov    %esp,%ebp
  8008c7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d9:	01 d0                	add    %edx,%eax
  8008db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e9:	74 06                	je     8008f1 <vsnprintf+0x2d>
  8008eb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ef:	7f 07                	jg     8008f8 <vsnprintf+0x34>
		return -E_INVAL;
  8008f1:	b8 03 00 00 00       	mov    $0x3,%eax
  8008f6:	eb 20                	jmp    800918 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008f8:	ff 75 14             	pushl  0x14(%ebp)
  8008fb:	ff 75 10             	pushl  0x10(%ebp)
  8008fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800901:	50                   	push   %eax
  800902:	68 8e 08 80 00       	push   $0x80088e
  800907:	e8 92 fb ff ff       	call   80049e <vprintfmt>
  80090c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80090f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800912:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800915:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800918:	c9                   	leave  
  800919:	c3                   	ret    

0080091a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80091a:	55                   	push   %ebp
  80091b:	89 e5                	mov    %esp,%ebp
  80091d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800920:	8d 45 10             	lea    0x10(%ebp),%eax
  800923:	83 c0 04             	add    $0x4,%eax
  800926:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800929:	8b 45 10             	mov    0x10(%ebp),%eax
  80092c:	ff 75 f4             	pushl  -0xc(%ebp)
  80092f:	50                   	push   %eax
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	ff 75 08             	pushl  0x8(%ebp)
  800936:	e8 89 ff ff ff       	call   8008c4 <vsnprintf>
  80093b:	83 c4 10             	add    $0x10,%esp
  80093e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800941:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800944:	c9                   	leave  
  800945:	c3                   	ret    

00800946 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800946:	55                   	push   %ebp
  800947:	89 e5                	mov    %esp,%ebp
  800949:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80094c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800950:	74 13                	je     800965 <readline+0x1f>
		cprintf("%s", prompt);
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 08             	pushl  0x8(%ebp)
  800958:	68 d0 1f 80 00       	push   $0x801fd0
  80095d:	e8 62 f9 ff ff       	call   8002c4 <cprintf>
  800962:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800965:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80096c:	83 ec 0c             	sub    $0xc,%esp
  80096f:	6a 00                	push   $0x0
  800971:	e8 8e 0f 00 00       	call   801904 <iscons>
  800976:	83 c4 10             	add    $0x10,%esp
  800979:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80097c:	e8 35 0f 00 00       	call   8018b6 <getchar>
  800981:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800984:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800988:	79 22                	jns    8009ac <readline+0x66>
			if (c != -E_EOF)
  80098a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80098e:	0f 84 ad 00 00 00    	je     800a41 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 ec             	pushl  -0x14(%ebp)
  80099a:	68 d3 1f 80 00       	push   $0x801fd3
  80099f:	e8 20 f9 ff ff       	call   8002c4 <cprintf>
  8009a4:	83 c4 10             	add    $0x10,%esp
			return;
  8009a7:	e9 95 00 00 00       	jmp    800a41 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009ac:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009b0:	7e 34                	jle    8009e6 <readline+0xa0>
  8009b2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009b9:	7f 2b                	jg     8009e6 <readline+0xa0>
			if (echoing)
  8009bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009bf:	74 0e                	je     8009cf <readline+0x89>
				cputchar(c);
  8009c1:	83 ec 0c             	sub    $0xc,%esp
  8009c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8009c7:	e8 a2 0e 00 00       	call   80186e <cputchar>
  8009cc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009d2:	8d 50 01             	lea    0x1(%eax),%edx
  8009d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009d8:	89 c2                	mov    %eax,%edx
  8009da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dd:	01 d0                	add    %edx,%eax
  8009df:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009e2:	88 10                	mov    %dl,(%eax)
  8009e4:	eb 56                	jmp    800a3c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009e6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009ea:	75 1f                	jne    800a0b <readline+0xc5>
  8009ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009f0:	7e 19                	jle    800a0b <readline+0xc5>
			if (echoing)
  8009f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009f6:	74 0e                	je     800a06 <readline+0xc0>
				cputchar(c);
  8009f8:	83 ec 0c             	sub    $0xc,%esp
  8009fb:	ff 75 ec             	pushl  -0x14(%ebp)
  8009fe:	e8 6b 0e 00 00       	call   80186e <cputchar>
  800a03:	83 c4 10             	add    $0x10,%esp

			i--;
  800a06:	ff 4d f4             	decl   -0xc(%ebp)
  800a09:	eb 31                	jmp    800a3c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a0b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a0f:	74 0a                	je     800a1b <readline+0xd5>
  800a11:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a15:	0f 85 61 ff ff ff    	jne    80097c <readline+0x36>
			if (echoing)
  800a1b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a1f:	74 0e                	je     800a2f <readline+0xe9>
				cputchar(c);
  800a21:	83 ec 0c             	sub    $0xc,%esp
  800a24:	ff 75 ec             	pushl  -0x14(%ebp)
  800a27:	e8 42 0e 00 00       	call   80186e <cputchar>
  800a2c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a35:	01 d0                	add    %edx,%eax
  800a37:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a3a:	eb 06                	jmp    800a42 <readline+0xfc>
		}
	}
  800a3c:	e9 3b ff ff ff       	jmp    80097c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a41:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a42:	c9                   	leave  
  800a43:	c3                   	ret    

00800a44 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a44:	55                   	push   %ebp
  800a45:	89 e5                	mov    %esp,%ebp
  800a47:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a4a:	e8 41 0a 00 00       	call   801490 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a4f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a53:	74 13                	je     800a68 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a55:	83 ec 08             	sub    $0x8,%esp
  800a58:	ff 75 08             	pushl  0x8(%ebp)
  800a5b:	68 d0 1f 80 00       	push   $0x801fd0
  800a60:	e8 5f f8 ff ff       	call   8002c4 <cprintf>
  800a65:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a6f:	83 ec 0c             	sub    $0xc,%esp
  800a72:	6a 00                	push   $0x0
  800a74:	e8 8b 0e 00 00       	call   801904 <iscons>
  800a79:	83 c4 10             	add    $0x10,%esp
  800a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a7f:	e8 32 0e 00 00       	call   8018b6 <getchar>
  800a84:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a87:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a8b:	79 23                	jns    800ab0 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a8d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a91:	74 13                	je     800aa6 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a93:	83 ec 08             	sub    $0x8,%esp
  800a96:	ff 75 ec             	pushl  -0x14(%ebp)
  800a99:	68 d3 1f 80 00       	push   $0x801fd3
  800a9e:	e8 21 f8 ff ff       	call   8002c4 <cprintf>
  800aa3:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800aa6:	e8 ff 09 00 00       	call   8014aa <sys_enable_interrupt>
			return;
  800aab:	e9 9a 00 00 00       	jmp    800b4a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ab0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ab4:	7e 34                	jle    800aea <atomic_readline+0xa6>
  800ab6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800abd:	7f 2b                	jg     800aea <atomic_readline+0xa6>
			if (echoing)
  800abf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ac3:	74 0e                	je     800ad3 <atomic_readline+0x8f>
				cputchar(c);
  800ac5:	83 ec 0c             	sub    $0xc,%esp
  800ac8:	ff 75 ec             	pushl  -0x14(%ebp)
  800acb:	e8 9e 0d 00 00       	call   80186e <cputchar>
  800ad0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ad6:	8d 50 01             	lea    0x1(%eax),%edx
  800ad9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800adc:	89 c2                	mov    %eax,%edx
  800ade:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae1:	01 d0                	add    %edx,%eax
  800ae3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ae6:	88 10                	mov    %dl,(%eax)
  800ae8:	eb 5b                	jmp    800b45 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800aea:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800aee:	75 1f                	jne    800b0f <atomic_readline+0xcb>
  800af0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800af4:	7e 19                	jle    800b0f <atomic_readline+0xcb>
			if (echoing)
  800af6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800afa:	74 0e                	je     800b0a <atomic_readline+0xc6>
				cputchar(c);
  800afc:	83 ec 0c             	sub    $0xc,%esp
  800aff:	ff 75 ec             	pushl  -0x14(%ebp)
  800b02:	e8 67 0d 00 00       	call   80186e <cputchar>
  800b07:	83 c4 10             	add    $0x10,%esp
			i--;
  800b0a:	ff 4d f4             	decl   -0xc(%ebp)
  800b0d:	eb 36                	jmp    800b45 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b0f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b13:	74 0a                	je     800b1f <atomic_readline+0xdb>
  800b15:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b19:	0f 85 60 ff ff ff    	jne    800a7f <atomic_readline+0x3b>
			if (echoing)
  800b1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b23:	74 0e                	je     800b33 <atomic_readline+0xef>
				cputchar(c);
  800b25:	83 ec 0c             	sub    $0xc,%esp
  800b28:	ff 75 ec             	pushl  -0x14(%ebp)
  800b2b:	e8 3e 0d 00 00       	call   80186e <cputchar>
  800b30:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b39:	01 d0                	add    %edx,%eax
  800b3b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b3e:	e8 67 09 00 00       	call   8014aa <sys_enable_interrupt>
			return;
  800b43:	eb 05                	jmp    800b4a <atomic_readline+0x106>
		}
	}
  800b45:	e9 35 ff ff ff       	jmp    800a7f <atomic_readline+0x3b>
}
  800b4a:	c9                   	leave  
  800b4b:	c3                   	ret    

00800b4c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
  800b4f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b52:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b59:	eb 06                	jmp    800b61 <strlen+0x15>
		n++;
  800b5b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b5e:	ff 45 08             	incl   0x8(%ebp)
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8a 00                	mov    (%eax),%al
  800b66:	84 c0                	test   %al,%al
  800b68:	75 f1                	jne    800b5b <strlen+0xf>
		n++;
	return n;
  800b6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b6d:	c9                   	leave  
  800b6e:	c3                   	ret    

00800b6f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b6f:	55                   	push   %ebp
  800b70:	89 e5                	mov    %esp,%ebp
  800b72:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7c:	eb 09                	jmp    800b87 <strnlen+0x18>
		n++;
  800b7e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b81:	ff 45 08             	incl   0x8(%ebp)
  800b84:	ff 4d 0c             	decl   0xc(%ebp)
  800b87:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8b:	74 09                	je     800b96 <strnlen+0x27>
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	84 c0                	test   %al,%al
  800b94:	75 e8                	jne    800b7e <strnlen+0xf>
		n++;
	return n;
  800b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b99:	c9                   	leave  
  800b9a:	c3                   	ret    

00800b9b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
  800b9e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ba7:	90                   	nop
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	8d 50 01             	lea    0x1(%eax),%edx
  800bae:	89 55 08             	mov    %edx,0x8(%ebp)
  800bb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bba:	8a 12                	mov    (%edx),%dl
  800bbc:	88 10                	mov    %dl,(%eax)
  800bbe:	8a 00                	mov    (%eax),%al
  800bc0:	84 c0                	test   %al,%al
  800bc2:	75 e4                	jne    800ba8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc7:	c9                   	leave  
  800bc8:	c3                   	ret    

00800bc9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
  800bcc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bd5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdc:	eb 1f                	jmp    800bfd <strncpy+0x34>
		*dst++ = *src;
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	8d 50 01             	lea    0x1(%eax),%edx
  800be4:	89 55 08             	mov    %edx,0x8(%ebp)
  800be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bea:	8a 12                	mov    (%edx),%dl
  800bec:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	84 c0                	test   %al,%al
  800bf5:	74 03                	je     800bfa <strncpy+0x31>
			src++;
  800bf7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bfa:	ff 45 fc             	incl   -0x4(%ebp)
  800bfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c00:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c03:	72 d9                	jb     800bde <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c05:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c08:	c9                   	leave  
  800c09:	c3                   	ret    

00800c0a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c0a:	55                   	push   %ebp
  800c0b:	89 e5                	mov    %esp,%ebp
  800c0d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c16:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1a:	74 30                	je     800c4c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c1c:	eb 16                	jmp    800c34 <strlcpy+0x2a>
			*dst++ = *src++;
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	8d 50 01             	lea    0x1(%eax),%edx
  800c24:	89 55 08             	mov    %edx,0x8(%ebp)
  800c27:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c2d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c30:	8a 12                	mov    (%edx),%dl
  800c32:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c34:	ff 4d 10             	decl   0x10(%ebp)
  800c37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3b:	74 09                	je     800c46 <strlcpy+0x3c>
  800c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c40:	8a 00                	mov    (%eax),%al
  800c42:	84 c0                	test   %al,%al
  800c44:	75 d8                	jne    800c1e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c4c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c52:	29 c2                	sub    %eax,%edx
  800c54:	89 d0                	mov    %edx,%eax
}
  800c56:	c9                   	leave  
  800c57:	c3                   	ret    

00800c58 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c58:	55                   	push   %ebp
  800c59:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c5b:	eb 06                	jmp    800c63 <strcmp+0xb>
		p++, q++;
  800c5d:	ff 45 08             	incl   0x8(%ebp)
  800c60:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	84 c0                	test   %al,%al
  800c6a:	74 0e                	je     800c7a <strcmp+0x22>
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	8a 10                	mov    (%eax),%dl
  800c71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c74:	8a 00                	mov    (%eax),%al
  800c76:	38 c2                	cmp    %al,%dl
  800c78:	74 e3                	je     800c5d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	8a 00                	mov    (%eax),%al
  800c7f:	0f b6 d0             	movzbl %al,%edx
  800c82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c85:	8a 00                	mov    (%eax),%al
  800c87:	0f b6 c0             	movzbl %al,%eax
  800c8a:	29 c2                	sub    %eax,%edx
  800c8c:	89 d0                	mov    %edx,%eax
}
  800c8e:	5d                   	pop    %ebp
  800c8f:	c3                   	ret    

00800c90 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c90:	55                   	push   %ebp
  800c91:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c93:	eb 09                	jmp    800c9e <strncmp+0xe>
		n--, p++, q++;
  800c95:	ff 4d 10             	decl   0x10(%ebp)
  800c98:	ff 45 08             	incl   0x8(%ebp)
  800c9b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca2:	74 17                	je     800cbb <strncmp+0x2b>
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	84 c0                	test   %al,%al
  800cab:	74 0e                	je     800cbb <strncmp+0x2b>
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 10                	mov    (%eax),%dl
  800cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	38 c2                	cmp    %al,%dl
  800cb9:	74 da                	je     800c95 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbf:	75 07                	jne    800cc8 <strncmp+0x38>
		return 0;
  800cc1:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc6:	eb 14                	jmp    800cdc <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	0f b6 d0             	movzbl %al,%edx
  800cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	0f b6 c0             	movzbl %al,%eax
  800cd8:	29 c2                	sub    %eax,%edx
  800cda:	89 d0                	mov    %edx,%eax
}
  800cdc:	5d                   	pop    %ebp
  800cdd:	c3                   	ret    

00800cde <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 04             	sub    $0x4,%esp
  800ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cea:	eb 12                	jmp    800cfe <strchr+0x20>
		if (*s == c)
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cf4:	75 05                	jne    800cfb <strchr+0x1d>
			return (char *) s;
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	eb 11                	jmp    800d0c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cfb:	ff 45 08             	incl   0x8(%ebp)
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8a 00                	mov    (%eax),%al
  800d03:	84 c0                	test   %al,%al
  800d05:	75 e5                	jne    800cec <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d07:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d0c:	c9                   	leave  
  800d0d:	c3                   	ret    

00800d0e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 04             	sub    $0x4,%esp
  800d14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d17:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1a:	eb 0d                	jmp    800d29 <strfind+0x1b>
		if (*s == c)
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d24:	74 0e                	je     800d34 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d26:	ff 45 08             	incl   0x8(%ebp)
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	84 c0                	test   %al,%al
  800d30:	75 ea                	jne    800d1c <strfind+0xe>
  800d32:	eb 01                	jmp    800d35 <strfind+0x27>
		if (*s == c)
			break;
  800d34:	90                   	nop
	return (char *) s;
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d38:	c9                   	leave  
  800d39:	c3                   	ret    

00800d3a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d3a:	55                   	push   %ebp
  800d3b:	89 e5                	mov    %esp,%ebp
  800d3d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
  800d43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d46:	8b 45 10             	mov    0x10(%ebp),%eax
  800d49:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d4c:	eb 0e                	jmp    800d5c <memset+0x22>
		*p++ = c;
  800d4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d51:	8d 50 01             	lea    0x1(%eax),%edx
  800d54:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d5c:	ff 4d f8             	decl   -0x8(%ebp)
  800d5f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d63:	79 e9                	jns    800d4e <memset+0x14>
		*p++ = c;

	return v;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d68:	c9                   	leave  
  800d69:	c3                   	ret    

00800d6a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d6a:	55                   	push   %ebp
  800d6b:	89 e5                	mov    %esp,%ebp
  800d6d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d7c:	eb 16                	jmp    800d94 <memcpy+0x2a>
		*d++ = *s++;
  800d7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d81:	8d 50 01             	lea    0x1(%eax),%edx
  800d84:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d87:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d8d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d90:	8a 12                	mov    (%edx),%dl
  800d92:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d94:	8b 45 10             	mov    0x10(%ebp),%eax
  800d97:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d9a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d9d:	85 c0                	test   %eax,%eax
  800d9f:	75 dd                	jne    800d7e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da4:	c9                   	leave  
  800da5:	c3                   	ret    

00800da6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800da6:	55                   	push   %ebp
  800da7:	89 e5                	mov    %esp,%ebp
  800da9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800db8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dbe:	73 50                	jae    800e10 <memmove+0x6a>
  800dc0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc6:	01 d0                	add    %edx,%eax
  800dc8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dcb:	76 43                	jbe    800e10 <memmove+0x6a>
		s += n;
  800dcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dd9:	eb 10                	jmp    800deb <memmove+0x45>
			*--d = *--s;
  800ddb:	ff 4d f8             	decl   -0x8(%ebp)
  800dde:	ff 4d fc             	decl   -0x4(%ebp)
  800de1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de4:	8a 10                	mov    (%eax),%dl
  800de6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df1:	89 55 10             	mov    %edx,0x10(%ebp)
  800df4:	85 c0                	test   %eax,%eax
  800df6:	75 e3                	jne    800ddb <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800df8:	eb 23                	jmp    800e1d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfd:	8d 50 01             	lea    0x1(%eax),%edx
  800e00:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e06:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e09:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e0c:	8a 12                	mov    (%edx),%dl
  800e0e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e10:	8b 45 10             	mov    0x10(%ebp),%eax
  800e13:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e16:	89 55 10             	mov    %edx,0x10(%ebp)
  800e19:	85 c0                	test   %eax,%eax
  800e1b:	75 dd                	jne    800dfa <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e20:	c9                   	leave  
  800e21:	c3                   	ret    

00800e22 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e22:	55                   	push   %ebp
  800e23:	89 e5                	mov    %esp,%ebp
  800e25:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e31:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e34:	eb 2a                	jmp    800e60 <memcmp+0x3e>
		if (*s1 != *s2)
  800e36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e39:	8a 10                	mov    (%eax),%dl
  800e3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3e:	8a 00                	mov    (%eax),%al
  800e40:	38 c2                	cmp    %al,%dl
  800e42:	74 16                	je     800e5a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	0f b6 d0             	movzbl %al,%edx
  800e4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4f:	8a 00                	mov    (%eax),%al
  800e51:	0f b6 c0             	movzbl %al,%eax
  800e54:	29 c2                	sub    %eax,%edx
  800e56:	89 d0                	mov    %edx,%eax
  800e58:	eb 18                	jmp    800e72 <memcmp+0x50>
		s1++, s2++;
  800e5a:	ff 45 fc             	incl   -0x4(%ebp)
  800e5d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e60:	8b 45 10             	mov    0x10(%ebp),%eax
  800e63:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e66:	89 55 10             	mov    %edx,0x10(%ebp)
  800e69:	85 c0                	test   %eax,%eax
  800e6b:	75 c9                	jne    800e36 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e6d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e72:	c9                   	leave  
  800e73:	c3                   	ret    

00800e74 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e74:	55                   	push   %ebp
  800e75:	89 e5                	mov    %esp,%ebp
  800e77:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e7a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e80:	01 d0                	add    %edx,%eax
  800e82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e85:	eb 15                	jmp    800e9c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	0f b6 d0             	movzbl %al,%edx
  800e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e92:	0f b6 c0             	movzbl %al,%eax
  800e95:	39 c2                	cmp    %eax,%edx
  800e97:	74 0d                	je     800ea6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e99:	ff 45 08             	incl   0x8(%ebp)
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ea2:	72 e3                	jb     800e87 <memfind+0x13>
  800ea4:	eb 01                	jmp    800ea7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ea6:	90                   	nop
	return (void *) s;
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eaa:	c9                   	leave  
  800eab:	c3                   	ret    

00800eac <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
  800eaf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eb9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec0:	eb 03                	jmp    800ec5 <strtol+0x19>
		s++;
  800ec2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	3c 20                	cmp    $0x20,%al
  800ecc:	74 f4                	je     800ec2 <strtol+0x16>
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	3c 09                	cmp    $0x9,%al
  800ed5:	74 eb                	je     800ec2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	3c 2b                	cmp    $0x2b,%al
  800ede:	75 05                	jne    800ee5 <strtol+0x39>
		s++;
  800ee0:	ff 45 08             	incl   0x8(%ebp)
  800ee3:	eb 13                	jmp    800ef8 <strtol+0x4c>
	else if (*s == '-')
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	3c 2d                	cmp    $0x2d,%al
  800eec:	75 0a                	jne    800ef8 <strtol+0x4c>
		s++, neg = 1;
  800eee:	ff 45 08             	incl   0x8(%ebp)
  800ef1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ef8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800efc:	74 06                	je     800f04 <strtol+0x58>
  800efe:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f02:	75 20                	jne    800f24 <strtol+0x78>
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	3c 30                	cmp    $0x30,%al
  800f0b:	75 17                	jne    800f24 <strtol+0x78>
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	40                   	inc    %eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	3c 78                	cmp    $0x78,%al
  800f15:	75 0d                	jne    800f24 <strtol+0x78>
		s += 2, base = 16;
  800f17:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f1b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f22:	eb 28                	jmp    800f4c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f28:	75 15                	jne    800f3f <strtol+0x93>
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	3c 30                	cmp    $0x30,%al
  800f31:	75 0c                	jne    800f3f <strtol+0x93>
		s++, base = 8;
  800f33:	ff 45 08             	incl   0x8(%ebp)
  800f36:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f3d:	eb 0d                	jmp    800f4c <strtol+0xa0>
	else if (base == 0)
  800f3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f43:	75 07                	jne    800f4c <strtol+0xa0>
		base = 10;
  800f45:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 2f                	cmp    $0x2f,%al
  800f53:	7e 19                	jle    800f6e <strtol+0xc2>
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3c 39                	cmp    $0x39,%al
  800f5c:	7f 10                	jg     800f6e <strtol+0xc2>
			dig = *s - '0';
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8a 00                	mov    (%eax),%al
  800f63:	0f be c0             	movsbl %al,%eax
  800f66:	83 e8 30             	sub    $0x30,%eax
  800f69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6c:	eb 42                	jmp    800fb0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 60                	cmp    $0x60,%al
  800f75:	7e 19                	jle    800f90 <strtol+0xe4>
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	3c 7a                	cmp    $0x7a,%al
  800f7e:	7f 10                	jg     800f90 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	0f be c0             	movsbl %al,%eax
  800f88:	83 e8 57             	sub    $0x57,%eax
  800f8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f8e:	eb 20                	jmp    800fb0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	3c 40                	cmp    $0x40,%al
  800f97:	7e 39                	jle    800fd2 <strtol+0x126>
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3c 5a                	cmp    $0x5a,%al
  800fa0:	7f 30                	jg     800fd2 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 00                	mov    (%eax),%al
  800fa7:	0f be c0             	movsbl %al,%eax
  800faa:	83 e8 37             	sub    $0x37,%eax
  800fad:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fb6:	7d 19                	jge    800fd1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fb8:	ff 45 08             	incl   0x8(%ebp)
  800fbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbe:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fc2:	89 c2                	mov    %eax,%edx
  800fc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc7:	01 d0                	add    %edx,%eax
  800fc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fcc:	e9 7b ff ff ff       	jmp    800f4c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fd1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fd2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd6:	74 08                	je     800fe0 <strtol+0x134>
		*endptr = (char *) s;
  800fd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fde:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fe0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fe4:	74 07                	je     800fed <strtol+0x141>
  800fe6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe9:	f7 d8                	neg    %eax
  800feb:	eb 03                	jmp    800ff0 <strtol+0x144>
  800fed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ff0:	c9                   	leave  
  800ff1:	c3                   	ret    

00800ff2 <ltostr>:

void
ltostr(long value, char *str)
{
  800ff2:	55                   	push   %ebp
  800ff3:	89 e5                	mov    %esp,%ebp
  800ff5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ff8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800fff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801006:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100a:	79 13                	jns    80101f <ltostr+0x2d>
	{
		neg = 1;
  80100c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801013:	8b 45 0c             	mov    0xc(%ebp),%eax
  801016:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801019:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80101c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801027:	99                   	cltd   
  801028:	f7 f9                	idiv   %ecx
  80102a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80102d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801030:	8d 50 01             	lea    0x1(%eax),%edx
  801033:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801036:	89 c2                	mov    %eax,%edx
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	01 d0                	add    %edx,%eax
  80103d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801040:	83 c2 30             	add    $0x30,%edx
  801043:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801045:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801048:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80104d:	f7 e9                	imul   %ecx
  80104f:	c1 fa 02             	sar    $0x2,%edx
  801052:	89 c8                	mov    %ecx,%eax
  801054:	c1 f8 1f             	sar    $0x1f,%eax
  801057:	29 c2                	sub    %eax,%edx
  801059:	89 d0                	mov    %edx,%eax
  80105b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80105e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801061:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801066:	f7 e9                	imul   %ecx
  801068:	c1 fa 02             	sar    $0x2,%edx
  80106b:	89 c8                	mov    %ecx,%eax
  80106d:	c1 f8 1f             	sar    $0x1f,%eax
  801070:	29 c2                	sub    %eax,%edx
  801072:	89 d0                	mov    %edx,%eax
  801074:	c1 e0 02             	shl    $0x2,%eax
  801077:	01 d0                	add    %edx,%eax
  801079:	01 c0                	add    %eax,%eax
  80107b:	29 c1                	sub    %eax,%ecx
  80107d:	89 ca                	mov    %ecx,%edx
  80107f:	85 d2                	test   %edx,%edx
  801081:	75 9c                	jne    80101f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801083:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80108a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108d:	48                   	dec    %eax
  80108e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801091:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801095:	74 3d                	je     8010d4 <ltostr+0xe2>
		start = 1 ;
  801097:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80109e:	eb 34                	jmp    8010d4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a6:	01 d0                	add    %edx,%eax
  8010a8:	8a 00                	mov    (%eax),%al
  8010aa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	01 c2                	add    %eax,%edx
  8010b5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	01 c8                	add    %ecx,%eax
  8010bd:	8a 00                	mov    (%eax),%al
  8010bf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c7:	01 c2                	add    %eax,%edx
  8010c9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010cc:	88 02                	mov    %al,(%edx)
		start++ ;
  8010ce:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010d1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010da:	7c c4                	jl     8010a0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010dc:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	01 d0                	add    %edx,%eax
  8010e4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010e7:	90                   	nop
  8010e8:	c9                   	leave  
  8010e9:	c3                   	ret    

008010ea <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010ea:	55                   	push   %ebp
  8010eb:	89 e5                	mov    %esp,%ebp
  8010ed:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f0:	ff 75 08             	pushl  0x8(%ebp)
  8010f3:	e8 54 fa ff ff       	call   800b4c <strlen>
  8010f8:	83 c4 04             	add    $0x4,%esp
  8010fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010fe:	ff 75 0c             	pushl  0xc(%ebp)
  801101:	e8 46 fa ff ff       	call   800b4c <strlen>
  801106:	83 c4 04             	add    $0x4,%esp
  801109:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80110c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80111a:	eb 17                	jmp    801133 <strcconcat+0x49>
		final[s] = str1[s] ;
  80111c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80111f:	8b 45 10             	mov    0x10(%ebp),%eax
  801122:	01 c2                	add    %eax,%edx
  801124:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	01 c8                	add    %ecx,%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801130:	ff 45 fc             	incl   -0x4(%ebp)
  801133:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801136:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801139:	7c e1                	jl     80111c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80113b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801142:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801149:	eb 1f                	jmp    80116a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80114b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114e:	8d 50 01             	lea    0x1(%eax),%edx
  801151:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801154:	89 c2                	mov    %eax,%edx
  801156:	8b 45 10             	mov    0x10(%ebp),%eax
  801159:	01 c2                	add    %eax,%edx
  80115b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	01 c8                	add    %ecx,%eax
  801163:	8a 00                	mov    (%eax),%al
  801165:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801167:	ff 45 f8             	incl   -0x8(%ebp)
  80116a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801170:	7c d9                	jl     80114b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801172:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801175:	8b 45 10             	mov    0x10(%ebp),%eax
  801178:	01 d0                	add    %edx,%eax
  80117a:	c6 00 00             	movb   $0x0,(%eax)
}
  80117d:	90                   	nop
  80117e:	c9                   	leave  
  80117f:	c3                   	ret    

00801180 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801180:	55                   	push   %ebp
  801181:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801183:	8b 45 14             	mov    0x14(%ebp),%eax
  801186:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80118c:	8b 45 14             	mov    0x14(%ebp),%eax
  80118f:	8b 00                	mov    (%eax),%eax
  801191:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801198:	8b 45 10             	mov    0x10(%ebp),%eax
  80119b:	01 d0                	add    %edx,%eax
  80119d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a3:	eb 0c                	jmp    8011b1 <strsplit+0x31>
			*string++ = 0;
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8d 50 01             	lea    0x1(%eax),%edx
  8011ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ae:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	84 c0                	test   %al,%al
  8011b8:	74 18                	je     8011d2 <strsplit+0x52>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	0f be c0             	movsbl %al,%eax
  8011c2:	50                   	push   %eax
  8011c3:	ff 75 0c             	pushl  0xc(%ebp)
  8011c6:	e8 13 fb ff ff       	call   800cde <strchr>
  8011cb:	83 c4 08             	add    $0x8,%esp
  8011ce:	85 c0                	test   %eax,%eax
  8011d0:	75 d3                	jne    8011a5 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	84 c0                	test   %al,%al
  8011d9:	74 5a                	je     801235 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011db:	8b 45 14             	mov    0x14(%ebp),%eax
  8011de:	8b 00                	mov    (%eax),%eax
  8011e0:	83 f8 0f             	cmp    $0xf,%eax
  8011e3:	75 07                	jne    8011ec <strsplit+0x6c>
		{
			return 0;
  8011e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8011ea:	eb 66                	jmp    801252 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ef:	8b 00                	mov    (%eax),%eax
  8011f1:	8d 48 01             	lea    0x1(%eax),%ecx
  8011f4:	8b 55 14             	mov    0x14(%ebp),%edx
  8011f7:	89 0a                	mov    %ecx,(%edx)
  8011f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801200:	8b 45 10             	mov    0x10(%ebp),%eax
  801203:	01 c2                	add    %eax,%edx
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80120a:	eb 03                	jmp    80120f <strsplit+0x8f>
			string++;
  80120c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	84 c0                	test   %al,%al
  801216:	74 8b                	je     8011a3 <strsplit+0x23>
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	0f be c0             	movsbl %al,%eax
  801220:	50                   	push   %eax
  801221:	ff 75 0c             	pushl  0xc(%ebp)
  801224:	e8 b5 fa ff ff       	call   800cde <strchr>
  801229:	83 c4 08             	add    $0x8,%esp
  80122c:	85 c0                	test   %eax,%eax
  80122e:	74 dc                	je     80120c <strsplit+0x8c>
			string++;
	}
  801230:	e9 6e ff ff ff       	jmp    8011a3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801235:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801236:	8b 45 14             	mov    0x14(%ebp),%eax
  801239:	8b 00                	mov    (%eax),%eax
  80123b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801242:	8b 45 10             	mov    0x10(%ebp),%eax
  801245:	01 d0                	add    %edx,%eax
  801247:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80124d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
  801257:	57                   	push   %edi
  801258:	56                   	push   %esi
  801259:	53                   	push   %ebx
  80125a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8b 55 0c             	mov    0xc(%ebp),%edx
  801263:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801266:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801269:	8b 7d 18             	mov    0x18(%ebp),%edi
  80126c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80126f:	cd 30                	int    $0x30
  801271:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801274:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801277:	83 c4 10             	add    $0x10,%esp
  80127a:	5b                   	pop    %ebx
  80127b:	5e                   	pop    %esi
  80127c:	5f                   	pop    %edi
  80127d:	5d                   	pop    %ebp
  80127e:	c3                   	ret    

0080127f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
  801282:	83 ec 04             	sub    $0x4,%esp
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80128b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	6a 00                	push   $0x0
  801294:	6a 00                	push   $0x0
  801296:	52                   	push   %edx
  801297:	ff 75 0c             	pushl  0xc(%ebp)
  80129a:	50                   	push   %eax
  80129b:	6a 00                	push   $0x0
  80129d:	e8 b2 ff ff ff       	call   801254 <syscall>
  8012a2:	83 c4 18             	add    $0x18,%esp
}
  8012a5:	90                   	nop
  8012a6:	c9                   	leave  
  8012a7:	c3                   	ret    

008012a8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012a8:	55                   	push   %ebp
  8012a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 01                	push   $0x1
  8012b7:	e8 98 ff ff ff       	call   801254 <syscall>
  8012bc:	83 c4 18             	add    $0x18,%esp
}
  8012bf:	c9                   	leave  
  8012c0:	c3                   	ret    

008012c1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012c1:	55                   	push   %ebp
  8012c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	50                   	push   %eax
  8012d0:	6a 05                	push   $0x5
  8012d2:	e8 7d ff ff ff       	call   801254 <syscall>
  8012d7:	83 c4 18             	add    $0x18,%esp
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 02                	push   $0x2
  8012eb:	e8 64 ff ff ff       	call   801254 <syscall>
  8012f0:	83 c4 18             	add    $0x18,%esp
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 03                	push   $0x3
  801304:	e8 4b ff ff ff       	call   801254 <syscall>
  801309:	83 c4 18             	add    $0x18,%esp
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 04                	push   $0x4
  80131d:	e8 32 ff ff ff       	call   801254 <syscall>
  801322:	83 c4 18             	add    $0x18,%esp
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_env_exit>:


void sys_env_exit(void)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 06                	push   $0x6
  801336:	e8 19 ff ff ff       	call   801254 <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	90                   	nop
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801344:	8b 55 0c             	mov    0xc(%ebp),%edx
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	52                   	push   %edx
  801351:	50                   	push   %eax
  801352:	6a 07                	push   $0x7
  801354:	e8 fb fe ff ff       	call   801254 <syscall>
  801359:	83 c4 18             	add    $0x18,%esp
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	56                   	push   %esi
  801362:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801363:	8b 75 18             	mov    0x18(%ebp),%esi
  801366:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801369:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	56                   	push   %esi
  801373:	53                   	push   %ebx
  801374:	51                   	push   %ecx
  801375:	52                   	push   %edx
  801376:	50                   	push   %eax
  801377:	6a 08                	push   $0x8
  801379:	e8 d6 fe ff ff       	call   801254 <syscall>
  80137e:	83 c4 18             	add    $0x18,%esp
}
  801381:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801384:	5b                   	pop    %ebx
  801385:	5e                   	pop    %esi
  801386:	5d                   	pop    %ebp
  801387:	c3                   	ret    

00801388 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80138b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	6a 00                	push   $0x0
  801397:	52                   	push   %edx
  801398:	50                   	push   %eax
  801399:	6a 09                	push   $0x9
  80139b:	e8 b4 fe ff ff       	call   801254 <syscall>
  8013a0:	83 c4 18             	add    $0x18,%esp
}
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	ff 75 0c             	pushl  0xc(%ebp)
  8013b1:	ff 75 08             	pushl  0x8(%ebp)
  8013b4:	6a 0a                	push   $0xa
  8013b6:	e8 99 fe ff ff       	call   801254 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 0b                	push   $0xb
  8013cf:	e8 80 fe ff ff       	call   801254 <syscall>
  8013d4:	83 c4 18             	add    $0x18,%esp
}
  8013d7:	c9                   	leave  
  8013d8:	c3                   	ret    

008013d9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013d9:	55                   	push   %ebp
  8013da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 0c                	push   $0xc
  8013e8:	e8 67 fe ff ff       	call   801254 <syscall>
  8013ed:	83 c4 18             	add    $0x18,%esp
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 0d                	push   $0xd
  801401:	e8 4e fe ff ff       	call   801254 <syscall>
  801406:	83 c4 18             	add    $0x18,%esp
}
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	ff 75 0c             	pushl  0xc(%ebp)
  801417:	ff 75 08             	pushl  0x8(%ebp)
  80141a:	6a 11                	push   $0x11
  80141c:	e8 33 fe ff ff       	call   801254 <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
	return;
  801424:	90                   	nop
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	ff 75 0c             	pushl  0xc(%ebp)
  801433:	ff 75 08             	pushl  0x8(%ebp)
  801436:	6a 12                	push   $0x12
  801438:	e8 17 fe ff ff       	call   801254 <syscall>
  80143d:	83 c4 18             	add    $0x18,%esp
	return ;
  801440:	90                   	nop
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	6a 0e                	push   $0xe
  801452:	e8 fd fd ff ff       	call   801254 <syscall>
  801457:	83 c4 18             	add    $0x18,%esp
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	ff 75 08             	pushl  0x8(%ebp)
  80146a:	6a 0f                	push   $0xf
  80146c:	e8 e3 fd ff ff       	call   801254 <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 10                	push   $0x10
  801485:	e8 ca fd ff ff       	call   801254 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	90                   	nop
  80148e:	c9                   	leave  
  80148f:	c3                   	ret    

00801490 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 14                	push   $0x14
  80149f:	e8 b0 fd ff ff       	call   801254 <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
}
  8014a7:	90                   	nop
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 15                	push   $0x15
  8014b9:	e8 96 fd ff ff       	call   801254 <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
}
  8014c1:	90                   	nop
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 04             	sub    $0x4,%esp
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014d0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 00                	push   $0x0
  8014dc:	50                   	push   %eax
  8014dd:	6a 16                	push   $0x16
  8014df:	e8 70 fd ff ff       	call   801254 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	90                   	nop
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 17                	push   $0x17
  8014f9:	e8 56 fd ff ff       	call   801254 <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
}
  801501:	90                   	nop
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	ff 75 0c             	pushl  0xc(%ebp)
  801513:	50                   	push   %eax
  801514:	6a 18                	push   $0x18
  801516:	e8 39 fd ff ff       	call   801254 <syscall>
  80151b:	83 c4 18             	add    $0x18,%esp
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801523:	8b 55 0c             	mov    0xc(%ebp),%edx
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	52                   	push   %edx
  801530:	50                   	push   %eax
  801531:	6a 1b                	push   $0x1b
  801533:	e8 1c fd ff ff       	call   801254 <syscall>
  801538:	83 c4 18             	add    $0x18,%esp
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801540:	8b 55 0c             	mov    0xc(%ebp),%edx
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	52                   	push   %edx
  80154d:	50                   	push   %eax
  80154e:	6a 19                	push   $0x19
  801550:	e8 ff fc ff ff       	call   801254 <syscall>
  801555:	83 c4 18             	add    $0x18,%esp
}
  801558:	90                   	nop
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80155e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	52                   	push   %edx
  80156b:	50                   	push   %eax
  80156c:	6a 1a                	push   $0x1a
  80156e:	e8 e1 fc ff ff       	call   801254 <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	90                   	nop
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 04             	sub    $0x4,%esp
  80157f:	8b 45 10             	mov    0x10(%ebp),%eax
  801582:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801585:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801588:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	6a 00                	push   $0x0
  801591:	51                   	push   %ecx
  801592:	52                   	push   %edx
  801593:	ff 75 0c             	pushl  0xc(%ebp)
  801596:	50                   	push   %eax
  801597:	6a 1c                	push   $0x1c
  801599:	e8 b6 fc ff ff       	call   801254 <syscall>
  80159e:	83 c4 18             	add    $0x18,%esp
}
  8015a1:	c9                   	leave  
  8015a2:	c3                   	ret    

008015a3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	52                   	push   %edx
  8015b3:	50                   	push   %eax
  8015b4:	6a 1d                	push   $0x1d
  8015b6:	e8 99 fc ff ff       	call   801254 <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	51                   	push   %ecx
  8015d1:	52                   	push   %edx
  8015d2:	50                   	push   %eax
  8015d3:	6a 1e                	push   $0x1e
  8015d5:	e8 7a fc ff ff       	call   801254 <syscall>
  8015da:	83 c4 18             	add    $0x18,%esp
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	52                   	push   %edx
  8015ef:	50                   	push   %eax
  8015f0:	6a 1f                	push   $0x1f
  8015f2:	e8 5d fc ff ff       	call   801254 <syscall>
  8015f7:	83 c4 18             	add    $0x18,%esp
}
  8015fa:	c9                   	leave  
  8015fb:	c3                   	ret    

008015fc <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 20                	push   $0x20
  80160b:	e8 44 fc ff ff       	call   801254 <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	ff 75 10             	pushl  0x10(%ebp)
  801622:	ff 75 0c             	pushl  0xc(%ebp)
  801625:	50                   	push   %eax
  801626:	6a 21                	push   $0x21
  801628:	e8 27 fc ff ff       	call   801254 <syscall>
  80162d:	83 c4 18             	add    $0x18,%esp
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    

00801632 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	50                   	push   %eax
  801641:	6a 22                	push   $0x22
  801643:	e8 0c fc ff ff       	call   801254 <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	90                   	nop
  80164c:	c9                   	leave  
  80164d:	c3                   	ret    

0080164e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80164e:	55                   	push   %ebp
  80164f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	50                   	push   %eax
  80165d:	6a 23                	push   $0x23
  80165f:	e8 f0 fb ff ff       	call   801254 <syscall>
  801664:	83 c4 18             	add    $0x18,%esp
}
  801667:	90                   	nop
  801668:	c9                   	leave  
  801669:	c3                   	ret    

0080166a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
  80166d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801670:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801673:	8d 50 04             	lea    0x4(%eax),%edx
  801676:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	52                   	push   %edx
  801680:	50                   	push   %eax
  801681:	6a 24                	push   $0x24
  801683:	e8 cc fb ff ff       	call   801254 <syscall>
  801688:	83 c4 18             	add    $0x18,%esp
	return result;
  80168b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80168e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801691:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801694:	89 01                	mov    %eax,(%ecx)
  801696:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	c9                   	leave  
  80169d:	c2 04 00             	ret    $0x4

008016a0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	ff 75 10             	pushl  0x10(%ebp)
  8016aa:	ff 75 0c             	pushl  0xc(%ebp)
  8016ad:	ff 75 08             	pushl  0x8(%ebp)
  8016b0:	6a 13                	push   $0x13
  8016b2:	e8 9d fb ff ff       	call   801254 <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ba:	90                   	nop
}
  8016bb:	c9                   	leave  
  8016bc:	c3                   	ret    

008016bd <sys_rcr2>:
uint32 sys_rcr2()
{
  8016bd:	55                   	push   %ebp
  8016be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 25                	push   $0x25
  8016cc:	e8 83 fb ff ff       	call   801254 <syscall>
  8016d1:	83 c4 18             	add    $0x18,%esp
}
  8016d4:	c9                   	leave  
  8016d5:	c3                   	ret    

008016d6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
  8016d9:	83 ec 04             	sub    $0x4,%esp
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016e2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	50                   	push   %eax
  8016ef:	6a 26                	push   $0x26
  8016f1:	e8 5e fb ff ff       	call   801254 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f9:	90                   	nop
}
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <rsttst>:
void rsttst()
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 28                	push   $0x28
  80170b:	e8 44 fb ff ff       	call   801254 <syscall>
  801710:	83 c4 18             	add    $0x18,%esp
	return ;
  801713:	90                   	nop
}
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 04             	sub    $0x4,%esp
  80171c:	8b 45 14             	mov    0x14(%ebp),%eax
  80171f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801722:	8b 55 18             	mov    0x18(%ebp),%edx
  801725:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801729:	52                   	push   %edx
  80172a:	50                   	push   %eax
  80172b:	ff 75 10             	pushl  0x10(%ebp)
  80172e:	ff 75 0c             	pushl  0xc(%ebp)
  801731:	ff 75 08             	pushl  0x8(%ebp)
  801734:	6a 27                	push   $0x27
  801736:	e8 19 fb ff ff       	call   801254 <syscall>
  80173b:	83 c4 18             	add    $0x18,%esp
	return ;
  80173e:	90                   	nop
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <chktst>:
void chktst(uint32 n)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	ff 75 08             	pushl  0x8(%ebp)
  80174f:	6a 29                	push   $0x29
  801751:	e8 fe fa ff ff       	call   801254 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
	return ;
  801759:	90                   	nop
}
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <inctst>:

void inctst()
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 2a                	push   $0x2a
  80176b:	e8 e4 fa ff ff       	call   801254 <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
	return ;
  801773:	90                   	nop
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <gettst>:
uint32 gettst()
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 2b                	push   $0x2b
  801785:	e8 ca fa ff ff       	call   801254 <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
  801792:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 2c                	push   $0x2c
  8017a1:	e8 ae fa ff ff       	call   801254 <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
  8017a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ac:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017b0:	75 07                	jne    8017b9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017b7:	eb 05                	jmp    8017be <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
  8017c3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 2c                	push   $0x2c
  8017d2:	e8 7d fa ff ff       	call   801254 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
  8017da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017dd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017e1:	75 07                	jne    8017ea <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017e3:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e8:	eb 05                	jmp    8017ef <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 2c                	push   $0x2c
  801803:	e8 4c fa ff ff       	call   801254 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
  80180b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80180e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801812:	75 07                	jne    80181b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801814:	b8 01 00 00 00       	mov    $0x1,%eax
  801819:	eb 05                	jmp    801820 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80181b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801820:	c9                   	leave  
  801821:	c3                   	ret    

00801822 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 2c                	push   $0x2c
  801834:	e8 1b fa ff ff       	call   801254 <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
  80183c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80183f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801843:	75 07                	jne    80184c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801845:	b8 01 00 00 00       	mov    $0x1,%eax
  80184a:	eb 05                	jmp    801851 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80184c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	ff 75 08             	pushl  0x8(%ebp)
  801861:	6a 2d                	push   $0x2d
  801863:	e8 ec f9 ff ff       	call   801254 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
	return ;
  80186b:	90                   	nop
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
  801871:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80187a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80187e:	83 ec 0c             	sub    $0xc,%esp
  801881:	50                   	push   %eax
  801882:	e8 3d fc ff ff       	call   8014c4 <sys_cputc>
  801887:	83 c4 10             	add    $0x10,%esp
}
  80188a:	90                   	nop
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801893:	e8 f8 fb ff ff       	call   801490 <sys_disable_interrupt>
	char c = ch;
  801898:	8b 45 08             	mov    0x8(%ebp),%eax
  80189b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80189e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018a2:	83 ec 0c             	sub    $0xc,%esp
  8018a5:	50                   	push   %eax
  8018a6:	e8 19 fc ff ff       	call   8014c4 <sys_cputc>
  8018ab:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8018ae:	e8 f7 fb ff ff       	call   8014aa <sys_enable_interrupt>
}
  8018b3:	90                   	nop
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <getchar>:

int
getchar(void)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
  8018b9:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8018bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018c3:	eb 08                	jmp    8018cd <getchar+0x17>
	{
		c = sys_cgetc();
  8018c5:	e8 de f9 ff ff       	call   8012a8 <sys_cgetc>
  8018ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8018cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018d1:	74 f2                	je     8018c5 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8018d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <atomic_getchar>:

int
atomic_getchar(void)
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
  8018db:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018de:	e8 ad fb ff ff       	call   801490 <sys_disable_interrupt>
	int c=0;
  8018e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8018ea:	eb 08                	jmp    8018f4 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8018ec:	e8 b7 f9 ff ff       	call   8012a8 <sys_cgetc>
  8018f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8018f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8018f8:	74 f2                	je     8018ec <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8018fa:	e8 ab fb ff ff       	call   8014aa <sys_enable_interrupt>
	return c;
  8018ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801902:	c9                   	leave  
  801903:	c3                   	ret    

00801904 <iscons>:

int iscons(int fdnum)
{
  801904:	55                   	push   %ebp
  801905:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801907:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80190c:	5d                   	pop    %ebp
  80190d:	c3                   	ret    
  80190e:	66 90                	xchg   %ax,%ax

00801910 <__udivdi3>:
  801910:	55                   	push   %ebp
  801911:	57                   	push   %edi
  801912:	56                   	push   %esi
  801913:	53                   	push   %ebx
  801914:	83 ec 1c             	sub    $0x1c,%esp
  801917:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80191b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80191f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801923:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801927:	89 ca                	mov    %ecx,%edx
  801929:	89 f8                	mov    %edi,%eax
  80192b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80192f:	85 f6                	test   %esi,%esi
  801931:	75 2d                	jne    801960 <__udivdi3+0x50>
  801933:	39 cf                	cmp    %ecx,%edi
  801935:	77 65                	ja     80199c <__udivdi3+0x8c>
  801937:	89 fd                	mov    %edi,%ebp
  801939:	85 ff                	test   %edi,%edi
  80193b:	75 0b                	jne    801948 <__udivdi3+0x38>
  80193d:	b8 01 00 00 00       	mov    $0x1,%eax
  801942:	31 d2                	xor    %edx,%edx
  801944:	f7 f7                	div    %edi
  801946:	89 c5                	mov    %eax,%ebp
  801948:	31 d2                	xor    %edx,%edx
  80194a:	89 c8                	mov    %ecx,%eax
  80194c:	f7 f5                	div    %ebp
  80194e:	89 c1                	mov    %eax,%ecx
  801950:	89 d8                	mov    %ebx,%eax
  801952:	f7 f5                	div    %ebp
  801954:	89 cf                	mov    %ecx,%edi
  801956:	89 fa                	mov    %edi,%edx
  801958:	83 c4 1c             	add    $0x1c,%esp
  80195b:	5b                   	pop    %ebx
  80195c:	5e                   	pop    %esi
  80195d:	5f                   	pop    %edi
  80195e:	5d                   	pop    %ebp
  80195f:	c3                   	ret    
  801960:	39 ce                	cmp    %ecx,%esi
  801962:	77 28                	ja     80198c <__udivdi3+0x7c>
  801964:	0f bd fe             	bsr    %esi,%edi
  801967:	83 f7 1f             	xor    $0x1f,%edi
  80196a:	75 40                	jne    8019ac <__udivdi3+0x9c>
  80196c:	39 ce                	cmp    %ecx,%esi
  80196e:	72 0a                	jb     80197a <__udivdi3+0x6a>
  801970:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801974:	0f 87 9e 00 00 00    	ja     801a18 <__udivdi3+0x108>
  80197a:	b8 01 00 00 00       	mov    $0x1,%eax
  80197f:	89 fa                	mov    %edi,%edx
  801981:	83 c4 1c             	add    $0x1c,%esp
  801984:	5b                   	pop    %ebx
  801985:	5e                   	pop    %esi
  801986:	5f                   	pop    %edi
  801987:	5d                   	pop    %ebp
  801988:	c3                   	ret    
  801989:	8d 76 00             	lea    0x0(%esi),%esi
  80198c:	31 ff                	xor    %edi,%edi
  80198e:	31 c0                	xor    %eax,%eax
  801990:	89 fa                	mov    %edi,%edx
  801992:	83 c4 1c             	add    $0x1c,%esp
  801995:	5b                   	pop    %ebx
  801996:	5e                   	pop    %esi
  801997:	5f                   	pop    %edi
  801998:	5d                   	pop    %ebp
  801999:	c3                   	ret    
  80199a:	66 90                	xchg   %ax,%ax
  80199c:	89 d8                	mov    %ebx,%eax
  80199e:	f7 f7                	div    %edi
  8019a0:	31 ff                	xor    %edi,%edi
  8019a2:	89 fa                	mov    %edi,%edx
  8019a4:	83 c4 1c             	add    $0x1c,%esp
  8019a7:	5b                   	pop    %ebx
  8019a8:	5e                   	pop    %esi
  8019a9:	5f                   	pop    %edi
  8019aa:	5d                   	pop    %ebp
  8019ab:	c3                   	ret    
  8019ac:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019b1:	89 eb                	mov    %ebp,%ebx
  8019b3:	29 fb                	sub    %edi,%ebx
  8019b5:	89 f9                	mov    %edi,%ecx
  8019b7:	d3 e6                	shl    %cl,%esi
  8019b9:	89 c5                	mov    %eax,%ebp
  8019bb:	88 d9                	mov    %bl,%cl
  8019bd:	d3 ed                	shr    %cl,%ebp
  8019bf:	89 e9                	mov    %ebp,%ecx
  8019c1:	09 f1                	or     %esi,%ecx
  8019c3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019c7:	89 f9                	mov    %edi,%ecx
  8019c9:	d3 e0                	shl    %cl,%eax
  8019cb:	89 c5                	mov    %eax,%ebp
  8019cd:	89 d6                	mov    %edx,%esi
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 ee                	shr    %cl,%esi
  8019d3:	89 f9                	mov    %edi,%ecx
  8019d5:	d3 e2                	shl    %cl,%edx
  8019d7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019db:	88 d9                	mov    %bl,%cl
  8019dd:	d3 e8                	shr    %cl,%eax
  8019df:	09 c2                	or     %eax,%edx
  8019e1:	89 d0                	mov    %edx,%eax
  8019e3:	89 f2                	mov    %esi,%edx
  8019e5:	f7 74 24 0c          	divl   0xc(%esp)
  8019e9:	89 d6                	mov    %edx,%esi
  8019eb:	89 c3                	mov    %eax,%ebx
  8019ed:	f7 e5                	mul    %ebp
  8019ef:	39 d6                	cmp    %edx,%esi
  8019f1:	72 19                	jb     801a0c <__udivdi3+0xfc>
  8019f3:	74 0b                	je     801a00 <__udivdi3+0xf0>
  8019f5:	89 d8                	mov    %ebx,%eax
  8019f7:	31 ff                	xor    %edi,%edi
  8019f9:	e9 58 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  8019fe:	66 90                	xchg   %ax,%ax
  801a00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a04:	89 f9                	mov    %edi,%ecx
  801a06:	d3 e2                	shl    %cl,%edx
  801a08:	39 c2                	cmp    %eax,%edx
  801a0a:	73 e9                	jae    8019f5 <__udivdi3+0xe5>
  801a0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a0f:	31 ff                	xor    %edi,%edi
  801a11:	e9 40 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  801a16:	66 90                	xchg   %ax,%ax
  801a18:	31 c0                	xor    %eax,%eax
  801a1a:	e9 37 ff ff ff       	jmp    801956 <__udivdi3+0x46>
  801a1f:	90                   	nop

00801a20 <__umoddi3>:
  801a20:	55                   	push   %ebp
  801a21:	57                   	push   %edi
  801a22:	56                   	push   %esi
  801a23:	53                   	push   %ebx
  801a24:	83 ec 1c             	sub    $0x1c,%esp
  801a27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a3f:	89 f3                	mov    %esi,%ebx
  801a41:	89 fa                	mov    %edi,%edx
  801a43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a47:	89 34 24             	mov    %esi,(%esp)
  801a4a:	85 c0                	test   %eax,%eax
  801a4c:	75 1a                	jne    801a68 <__umoddi3+0x48>
  801a4e:	39 f7                	cmp    %esi,%edi
  801a50:	0f 86 a2 00 00 00    	jbe    801af8 <__umoddi3+0xd8>
  801a56:	89 c8                	mov    %ecx,%eax
  801a58:	89 f2                	mov    %esi,%edx
  801a5a:	f7 f7                	div    %edi
  801a5c:	89 d0                	mov    %edx,%eax
  801a5e:	31 d2                	xor    %edx,%edx
  801a60:	83 c4 1c             	add    $0x1c,%esp
  801a63:	5b                   	pop    %ebx
  801a64:	5e                   	pop    %esi
  801a65:	5f                   	pop    %edi
  801a66:	5d                   	pop    %ebp
  801a67:	c3                   	ret    
  801a68:	39 f0                	cmp    %esi,%eax
  801a6a:	0f 87 ac 00 00 00    	ja     801b1c <__umoddi3+0xfc>
  801a70:	0f bd e8             	bsr    %eax,%ebp
  801a73:	83 f5 1f             	xor    $0x1f,%ebp
  801a76:	0f 84 ac 00 00 00    	je     801b28 <__umoddi3+0x108>
  801a7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801a81:	29 ef                	sub    %ebp,%edi
  801a83:	89 fe                	mov    %edi,%esi
  801a85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a89:	89 e9                	mov    %ebp,%ecx
  801a8b:	d3 e0                	shl    %cl,%eax
  801a8d:	89 d7                	mov    %edx,%edi
  801a8f:	89 f1                	mov    %esi,%ecx
  801a91:	d3 ef                	shr    %cl,%edi
  801a93:	09 c7                	or     %eax,%edi
  801a95:	89 e9                	mov    %ebp,%ecx
  801a97:	d3 e2                	shl    %cl,%edx
  801a99:	89 14 24             	mov    %edx,(%esp)
  801a9c:	89 d8                	mov    %ebx,%eax
  801a9e:	d3 e0                	shl    %cl,%eax
  801aa0:	89 c2                	mov    %eax,%edx
  801aa2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa6:	d3 e0                	shl    %cl,%eax
  801aa8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801aac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ab0:	89 f1                	mov    %esi,%ecx
  801ab2:	d3 e8                	shr    %cl,%eax
  801ab4:	09 d0                	or     %edx,%eax
  801ab6:	d3 eb                	shr    %cl,%ebx
  801ab8:	89 da                	mov    %ebx,%edx
  801aba:	f7 f7                	div    %edi
  801abc:	89 d3                	mov    %edx,%ebx
  801abe:	f7 24 24             	mull   (%esp)
  801ac1:	89 c6                	mov    %eax,%esi
  801ac3:	89 d1                	mov    %edx,%ecx
  801ac5:	39 d3                	cmp    %edx,%ebx
  801ac7:	0f 82 87 00 00 00    	jb     801b54 <__umoddi3+0x134>
  801acd:	0f 84 91 00 00 00    	je     801b64 <__umoddi3+0x144>
  801ad3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ad7:	29 f2                	sub    %esi,%edx
  801ad9:	19 cb                	sbb    %ecx,%ebx
  801adb:	89 d8                	mov    %ebx,%eax
  801add:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ae1:	d3 e0                	shl    %cl,%eax
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	d3 ea                	shr    %cl,%edx
  801ae7:	09 d0                	or     %edx,%eax
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 eb                	shr    %cl,%ebx
  801aed:	89 da                	mov    %ebx,%edx
  801aef:	83 c4 1c             	add    $0x1c,%esp
  801af2:	5b                   	pop    %ebx
  801af3:	5e                   	pop    %esi
  801af4:	5f                   	pop    %edi
  801af5:	5d                   	pop    %ebp
  801af6:	c3                   	ret    
  801af7:	90                   	nop
  801af8:	89 fd                	mov    %edi,%ebp
  801afa:	85 ff                	test   %edi,%edi
  801afc:	75 0b                	jne    801b09 <__umoddi3+0xe9>
  801afe:	b8 01 00 00 00       	mov    $0x1,%eax
  801b03:	31 d2                	xor    %edx,%edx
  801b05:	f7 f7                	div    %edi
  801b07:	89 c5                	mov    %eax,%ebp
  801b09:	89 f0                	mov    %esi,%eax
  801b0b:	31 d2                	xor    %edx,%edx
  801b0d:	f7 f5                	div    %ebp
  801b0f:	89 c8                	mov    %ecx,%eax
  801b11:	f7 f5                	div    %ebp
  801b13:	89 d0                	mov    %edx,%eax
  801b15:	e9 44 ff ff ff       	jmp    801a5e <__umoddi3+0x3e>
  801b1a:	66 90                	xchg   %ax,%ax
  801b1c:	89 c8                	mov    %ecx,%eax
  801b1e:	89 f2                	mov    %esi,%edx
  801b20:	83 c4 1c             	add    $0x1c,%esp
  801b23:	5b                   	pop    %ebx
  801b24:	5e                   	pop    %esi
  801b25:	5f                   	pop    %edi
  801b26:	5d                   	pop    %ebp
  801b27:	c3                   	ret    
  801b28:	3b 04 24             	cmp    (%esp),%eax
  801b2b:	72 06                	jb     801b33 <__umoddi3+0x113>
  801b2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b31:	77 0f                	ja     801b42 <__umoddi3+0x122>
  801b33:	89 f2                	mov    %esi,%edx
  801b35:	29 f9                	sub    %edi,%ecx
  801b37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b3b:	89 14 24             	mov    %edx,(%esp)
  801b3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b46:	8b 14 24             	mov    (%esp),%edx
  801b49:	83 c4 1c             	add    $0x1c,%esp
  801b4c:	5b                   	pop    %ebx
  801b4d:	5e                   	pop    %esi
  801b4e:	5f                   	pop    %edi
  801b4f:	5d                   	pop    %ebp
  801b50:	c3                   	ret    
  801b51:	8d 76 00             	lea    0x0(%esi),%esi
  801b54:	2b 04 24             	sub    (%esp),%eax
  801b57:	19 fa                	sbb    %edi,%edx
  801b59:	89 d1                	mov    %edx,%ecx
  801b5b:	89 c6                	mov    %eax,%esi
  801b5d:	e9 71 ff ff ff       	jmp    801ad3 <__umoddi3+0xb3>
  801b62:	66 90                	xchg   %ax,%ax
  801b64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b68:	72 ea                	jb     801b54 <__umoddi3+0x134>
  801b6a:	89 d9                	mov    %ebx,%ecx
  801b6c:	e9 62 ff ff ff       	jmp    801ad3 <__umoddi3+0xb3>
