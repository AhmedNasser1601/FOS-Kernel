
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 20 1c 80 00       	push   $0x801c20
  80005e:	e8 db 09 00 00       	call   800a3e <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 2d 0e 00 00       	call   800ea6 <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 dc 17 00 00       	call   801868 <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 3c 1c 80 00       	push   $0x801c3c
  80009e:	e8 9b 09 00 00       	call   800a3e <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 ed 0d 00 00       	call   800ea6 <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 59 1c 80 00       	push   $0x801c59
  8000d0:	e8 16 02 00 00       	call   8002eb <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e1:	e8 09 12 00 00       	call   8012ef <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	c1 e0 02             	shl    $0x2,%eax
  8000f1:	01 d0                	add    %edx,%eax
  8000f3:	01 c0                	add    %eax,%eax
  8000f5:	01 d0                	add    %edx,%eax
  8000f7:	01 c0                	add    %eax,%eax
  8000f9:	01 d0                	add    %edx,%eax
  8000fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800102:	01 d0                	add    %edx,%eax
  800104:	c1 e0 02             	shl    $0x2,%eax
  800107:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80010c:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800111:	a1 04 30 80 00       	mov    0x803004,%eax
  800116:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80011c:	84 c0                	test   %al,%al
  80011e:	74 0f                	je     80012f <libmain+0x54>
		binaryname = myEnv->prog_name;
  800120:	a1 04 30 80 00       	mov    0x803004,%eax
  800125:	05 f4 02 00 00       	add    $0x2f4,%eax
  80012a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80012f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800133:	7e 0a                	jle    80013f <libmain+0x64>
		binaryname = argv[0];
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	8b 00                	mov    (%eax),%eax
  80013a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80013f:	83 ec 08             	sub    $0x8,%esp
  800142:	ff 75 0c             	pushl  0xc(%ebp)
  800145:	ff 75 08             	pushl  0x8(%ebp)
  800148:	e8 eb fe ff ff       	call   800038 <_main>
  80014d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800150:	e8 35 13 00 00       	call   80148a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800155:	83 ec 0c             	sub    $0xc,%esp
  800158:	68 8c 1c 80 00       	push   $0x801c8c
  80015d:	e8 5c 01 00 00       	call   8002be <cprintf>
  800162:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800165:	a1 04 30 80 00       	mov    0x803004,%eax
  80016a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800170:	a1 04 30 80 00       	mov    0x803004,%eax
  800175:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80017b:	83 ec 04             	sub    $0x4,%esp
  80017e:	52                   	push   %edx
  80017f:	50                   	push   %eax
  800180:	68 b4 1c 80 00       	push   $0x801cb4
  800185:	e8 34 01 00 00       	call   8002be <cprintf>
  80018a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80018d:	a1 04 30 80 00       	mov    0x803004,%eax
  800192:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800198:	83 ec 08             	sub    $0x8,%esp
  80019b:	50                   	push   %eax
  80019c:	68 d9 1c 80 00       	push   $0x801cd9
  8001a1:	e8 18 01 00 00       	call   8002be <cprintf>
  8001a6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001a9:	83 ec 0c             	sub    $0xc,%esp
  8001ac:	68 8c 1c 80 00       	push   $0x801c8c
  8001b1:	e8 08 01 00 00       	call   8002be <cprintf>
  8001b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b9:	e8 e6 12 00 00       	call   8014a4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001be:	e8 19 00 00 00       	call   8001dc <exit>
}
  8001c3:	90                   	nop
  8001c4:	c9                   	leave  
  8001c5:	c3                   	ret    

008001c6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c6:	55                   	push   %ebp
  8001c7:	89 e5                	mov    %esp,%ebp
  8001c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	6a 00                	push   $0x0
  8001d1:	e8 e5 10 00 00       	call   8012bb <sys_env_destroy>
  8001d6:	83 c4 10             	add    $0x10,%esp
}
  8001d9:	90                   	nop
  8001da:	c9                   	leave  
  8001db:	c3                   	ret    

008001dc <exit>:

void
exit(void)
{
  8001dc:	55                   	push   %ebp
  8001dd:	89 e5                	mov    %esp,%ebp
  8001df:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001e2:	e8 3a 11 00 00       	call   801321 <sys_env_exit>
}
  8001e7:	90                   	nop
  8001e8:	c9                   	leave  
  8001e9:	c3                   	ret    

008001ea <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ea:	55                   	push   %ebp
  8001eb:	89 e5                	mov    %esp,%ebp
  8001ed:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f3:	8b 00                	mov    (%eax),%eax
  8001f5:	8d 48 01             	lea    0x1(%eax),%ecx
  8001f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fb:	89 0a                	mov    %ecx,(%edx)
  8001fd:	8b 55 08             	mov    0x8(%ebp),%edx
  800200:	88 d1                	mov    %dl,%cl
  800202:	8b 55 0c             	mov    0xc(%ebp),%edx
  800205:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800209:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800213:	75 2c                	jne    800241 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800215:	a0 08 30 80 00       	mov    0x803008,%al
  80021a:	0f b6 c0             	movzbl %al,%eax
  80021d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800220:	8b 12                	mov    (%edx),%edx
  800222:	89 d1                	mov    %edx,%ecx
  800224:	8b 55 0c             	mov    0xc(%ebp),%edx
  800227:	83 c2 08             	add    $0x8,%edx
  80022a:	83 ec 04             	sub    $0x4,%esp
  80022d:	50                   	push   %eax
  80022e:	51                   	push   %ecx
  80022f:	52                   	push   %edx
  800230:	e8 44 10 00 00       	call   801279 <sys_cputs>
  800235:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800238:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800241:	8b 45 0c             	mov    0xc(%ebp),%eax
  800244:	8b 40 04             	mov    0x4(%eax),%eax
  800247:	8d 50 01             	lea    0x1(%eax),%edx
  80024a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800250:	90                   	nop
  800251:	c9                   	leave  
  800252:	c3                   	ret    

00800253 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800253:	55                   	push   %ebp
  800254:	89 e5                	mov    %esp,%ebp
  800256:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80025c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800263:	00 00 00 
	b.cnt = 0;
  800266:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80026d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800270:	ff 75 0c             	pushl  0xc(%ebp)
  800273:	ff 75 08             	pushl  0x8(%ebp)
  800276:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027c:	50                   	push   %eax
  80027d:	68 ea 01 80 00       	push   $0x8001ea
  800282:	e8 11 02 00 00       	call   800498 <vprintfmt>
  800287:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80028a:	a0 08 30 80 00       	mov    0x803008,%al
  80028f:	0f b6 c0             	movzbl %al,%eax
  800292:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800298:	83 ec 04             	sub    $0x4,%esp
  80029b:	50                   	push   %eax
  80029c:	52                   	push   %edx
  80029d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a3:	83 c0 08             	add    $0x8,%eax
  8002a6:	50                   	push   %eax
  8002a7:	e8 cd 0f 00 00       	call   801279 <sys_cputs>
  8002ac:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002af:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  8002b6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002bc:	c9                   	leave  
  8002bd:	c3                   	ret    

008002be <cprintf>:

int cprintf(const char *fmt, ...) {
  8002be:	55                   	push   %ebp
  8002bf:	89 e5                	mov    %esp,%ebp
  8002c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c4:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  8002cb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d4:	83 ec 08             	sub    $0x8,%esp
  8002d7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002da:	50                   	push   %eax
  8002db:	e8 73 ff ff ff       	call   800253 <vcprintf>
  8002e0:	83 c4 10             	add    $0x10,%esp
  8002e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e9:	c9                   	leave  
  8002ea:	c3                   	ret    

008002eb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002eb:	55                   	push   %ebp
  8002ec:	89 e5                	mov    %esp,%ebp
  8002ee:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002f1:	e8 94 11 00 00       	call   80148a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	ff 75 f4             	pushl  -0xc(%ebp)
  800305:	50                   	push   %eax
  800306:	e8 48 ff ff ff       	call   800253 <vcprintf>
  80030b:	83 c4 10             	add    $0x10,%esp
  80030e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800311:	e8 8e 11 00 00       	call   8014a4 <sys_enable_interrupt>
	return cnt;
  800316:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	53                   	push   %ebx
  80031f:	83 ec 14             	sub    $0x14,%esp
  800322:	8b 45 10             	mov    0x10(%ebp),%eax
  800325:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800328:	8b 45 14             	mov    0x14(%ebp),%eax
  80032b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80032e:	8b 45 18             	mov    0x18(%ebp),%eax
  800331:	ba 00 00 00 00       	mov    $0x0,%edx
  800336:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800339:	77 55                	ja     800390 <printnum+0x75>
  80033b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033e:	72 05                	jb     800345 <printnum+0x2a>
  800340:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800343:	77 4b                	ja     800390 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800345:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800348:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80034b:	8b 45 18             	mov    0x18(%ebp),%eax
  80034e:	ba 00 00 00 00       	mov    $0x0,%edx
  800353:	52                   	push   %edx
  800354:	50                   	push   %eax
  800355:	ff 75 f4             	pushl  -0xc(%ebp)
  800358:	ff 75 f0             	pushl  -0x10(%ebp)
  80035b:	e8 5c 16 00 00       	call   8019bc <__udivdi3>
  800360:	83 c4 10             	add    $0x10,%esp
  800363:	83 ec 04             	sub    $0x4,%esp
  800366:	ff 75 20             	pushl  0x20(%ebp)
  800369:	53                   	push   %ebx
  80036a:	ff 75 18             	pushl  0x18(%ebp)
  80036d:	52                   	push   %edx
  80036e:	50                   	push   %eax
  80036f:	ff 75 0c             	pushl  0xc(%ebp)
  800372:	ff 75 08             	pushl  0x8(%ebp)
  800375:	e8 a1 ff ff ff       	call   80031b <printnum>
  80037a:	83 c4 20             	add    $0x20,%esp
  80037d:	eb 1a                	jmp    800399 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80037f:	83 ec 08             	sub    $0x8,%esp
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	ff 75 20             	pushl  0x20(%ebp)
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	ff d0                	call   *%eax
  80038d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800390:	ff 4d 1c             	decl   0x1c(%ebp)
  800393:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800397:	7f e6                	jg     80037f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800399:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80039c:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a7:	53                   	push   %ebx
  8003a8:	51                   	push   %ecx
  8003a9:	52                   	push   %edx
  8003aa:	50                   	push   %eax
  8003ab:	e8 1c 17 00 00       	call   801acc <__umoddi3>
  8003b0:	83 c4 10             	add    $0x10,%esp
  8003b3:	05 14 1f 80 00       	add    $0x801f14,%eax
  8003b8:	8a 00                	mov    (%eax),%al
  8003ba:	0f be c0             	movsbl %al,%eax
  8003bd:	83 ec 08             	sub    $0x8,%esp
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	50                   	push   %eax
  8003c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c7:	ff d0                	call   *%eax
  8003c9:	83 c4 10             	add    $0x10,%esp
}
  8003cc:	90                   	nop
  8003cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d0:	c9                   	leave  
  8003d1:	c3                   	ret    

008003d2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003d2:	55                   	push   %ebp
  8003d3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d9:	7e 1c                	jle    8003f7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003db:	8b 45 08             	mov    0x8(%ebp),%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	8d 50 08             	lea    0x8(%eax),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	89 10                	mov    %edx,(%eax)
  8003e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	83 e8 08             	sub    $0x8,%eax
  8003f0:	8b 50 04             	mov    0x4(%eax),%edx
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	eb 40                	jmp    800437 <getuint+0x65>
	else if (lflag)
  8003f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003fb:	74 1e                	je     80041b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	8d 50 04             	lea    0x4(%eax),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	89 10                	mov    %edx,(%eax)
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	83 e8 04             	sub    $0x4,%eax
  800412:	8b 00                	mov    (%eax),%eax
  800414:	ba 00 00 00 00       	mov    $0x0,%edx
  800419:	eb 1c                	jmp    800437 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	8d 50 04             	lea    0x4(%eax),%edx
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	89 10                	mov    %edx,(%eax)
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	83 e8 04             	sub    $0x4,%eax
  800430:	8b 00                	mov    (%eax),%eax
  800432:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800437:	5d                   	pop    %ebp
  800438:	c3                   	ret    

00800439 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800439:	55                   	push   %ebp
  80043a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80043c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800440:	7e 1c                	jle    80045e <getint+0x25>
		return va_arg(*ap, long long);
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	8b 00                	mov    (%eax),%eax
  800447:	8d 50 08             	lea    0x8(%eax),%edx
  80044a:	8b 45 08             	mov    0x8(%ebp),%eax
  80044d:	89 10                	mov    %edx,(%eax)
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	83 e8 08             	sub    $0x8,%eax
  800457:	8b 50 04             	mov    0x4(%eax),%edx
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	eb 38                	jmp    800496 <getint+0x5d>
	else if (lflag)
  80045e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800462:	74 1a                	je     80047e <getint+0x45>
		return va_arg(*ap, long);
  800464:	8b 45 08             	mov    0x8(%ebp),%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	8d 50 04             	lea    0x4(%eax),%edx
  80046c:	8b 45 08             	mov    0x8(%ebp),%eax
  80046f:	89 10                	mov    %edx,(%eax)
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	83 e8 04             	sub    $0x4,%eax
  800479:	8b 00                	mov    (%eax),%eax
  80047b:	99                   	cltd   
  80047c:	eb 18                	jmp    800496 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	8d 50 04             	lea    0x4(%eax),%edx
  800486:	8b 45 08             	mov    0x8(%ebp),%eax
  800489:	89 10                	mov    %edx,(%eax)
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	83 e8 04             	sub    $0x4,%eax
  800493:	8b 00                	mov    (%eax),%eax
  800495:	99                   	cltd   
}
  800496:	5d                   	pop    %ebp
  800497:	c3                   	ret    

00800498 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800498:	55                   	push   %ebp
  800499:	89 e5                	mov    %esp,%ebp
  80049b:	56                   	push   %esi
  80049c:	53                   	push   %ebx
  80049d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a0:	eb 17                	jmp    8004b9 <vprintfmt+0x21>
			if (ch == '\0')
  8004a2:	85 db                	test   %ebx,%ebx
  8004a4:	0f 84 af 03 00 00    	je     800859 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	ff 75 0c             	pushl  0xc(%ebp)
  8004b0:	53                   	push   %ebx
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	ff d0                	call   *%eax
  8004b6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bc:	8d 50 01             	lea    0x1(%eax),%edx
  8004bf:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c2:	8a 00                	mov    (%eax),%al
  8004c4:	0f b6 d8             	movzbl %al,%ebx
  8004c7:	83 fb 25             	cmp    $0x25,%ebx
  8004ca:	75 d6                	jne    8004a2 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004cc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004d0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004de:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ef:	8d 50 01             	lea    0x1(%eax),%edx
  8004f2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f5:	8a 00                	mov    (%eax),%al
  8004f7:	0f b6 d8             	movzbl %al,%ebx
  8004fa:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004fd:	83 f8 55             	cmp    $0x55,%eax
  800500:	0f 87 2b 03 00 00    	ja     800831 <vprintfmt+0x399>
  800506:	8b 04 85 38 1f 80 00 	mov    0x801f38(,%eax,4),%eax
  80050d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80050f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800513:	eb d7                	jmp    8004ec <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800515:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800519:	eb d1                	jmp    8004ec <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80051b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800522:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800525:	89 d0                	mov    %edx,%eax
  800527:	c1 e0 02             	shl    $0x2,%eax
  80052a:	01 d0                	add    %edx,%eax
  80052c:	01 c0                	add    %eax,%eax
  80052e:	01 d8                	add    %ebx,%eax
  800530:	83 e8 30             	sub    $0x30,%eax
  800533:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800536:	8b 45 10             	mov    0x10(%ebp),%eax
  800539:	8a 00                	mov    (%eax),%al
  80053b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80053e:	83 fb 2f             	cmp    $0x2f,%ebx
  800541:	7e 3e                	jle    800581 <vprintfmt+0xe9>
  800543:	83 fb 39             	cmp    $0x39,%ebx
  800546:	7f 39                	jg     800581 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800548:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80054b:	eb d5                	jmp    800522 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80054d:	8b 45 14             	mov    0x14(%ebp),%eax
  800550:	83 c0 04             	add    $0x4,%eax
  800553:	89 45 14             	mov    %eax,0x14(%ebp)
  800556:	8b 45 14             	mov    0x14(%ebp),%eax
  800559:	83 e8 04             	sub    $0x4,%eax
  80055c:	8b 00                	mov    (%eax),%eax
  80055e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800561:	eb 1f                	jmp    800582 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800563:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800567:	79 83                	jns    8004ec <vprintfmt+0x54>
				width = 0;
  800569:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800570:	e9 77 ff ff ff       	jmp    8004ec <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800575:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80057c:	e9 6b ff ff ff       	jmp    8004ec <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800581:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800582:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800586:	0f 89 60 ff ff ff    	jns    8004ec <vprintfmt+0x54>
				width = precision, precision = -1;
  80058c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80058f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800592:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800599:	e9 4e ff ff ff       	jmp    8004ec <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80059e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005a1:	e9 46 ff ff ff       	jmp    8004ec <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a9:	83 c0 04             	add    $0x4,%eax
  8005ac:	89 45 14             	mov    %eax,0x14(%ebp)
  8005af:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b2:	83 e8 04             	sub    $0x4,%eax
  8005b5:	8b 00                	mov    (%eax),%eax
  8005b7:	83 ec 08             	sub    $0x8,%esp
  8005ba:	ff 75 0c             	pushl  0xc(%ebp)
  8005bd:	50                   	push   %eax
  8005be:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c1:	ff d0                	call   *%eax
  8005c3:	83 c4 10             	add    $0x10,%esp
			break;
  8005c6:	e9 89 02 00 00       	jmp    800854 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ce:	83 c0 04             	add    $0x4,%eax
  8005d1:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d7:	83 e8 04             	sub    $0x4,%eax
  8005da:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005dc:	85 db                	test   %ebx,%ebx
  8005de:	79 02                	jns    8005e2 <vprintfmt+0x14a>
				err = -err;
  8005e0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005e2:	83 fb 64             	cmp    $0x64,%ebx
  8005e5:	7f 0b                	jg     8005f2 <vprintfmt+0x15a>
  8005e7:	8b 34 9d 80 1d 80 00 	mov    0x801d80(,%ebx,4),%esi
  8005ee:	85 f6                	test   %esi,%esi
  8005f0:	75 19                	jne    80060b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005f2:	53                   	push   %ebx
  8005f3:	68 25 1f 80 00       	push   $0x801f25
  8005f8:	ff 75 0c             	pushl  0xc(%ebp)
  8005fb:	ff 75 08             	pushl  0x8(%ebp)
  8005fe:	e8 5e 02 00 00       	call   800861 <printfmt>
  800603:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800606:	e9 49 02 00 00       	jmp    800854 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80060b:	56                   	push   %esi
  80060c:	68 2e 1f 80 00       	push   $0x801f2e
  800611:	ff 75 0c             	pushl  0xc(%ebp)
  800614:	ff 75 08             	pushl  0x8(%ebp)
  800617:	e8 45 02 00 00       	call   800861 <printfmt>
  80061c:	83 c4 10             	add    $0x10,%esp
			break;
  80061f:	e9 30 02 00 00       	jmp    800854 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800624:	8b 45 14             	mov    0x14(%ebp),%eax
  800627:	83 c0 04             	add    $0x4,%eax
  80062a:	89 45 14             	mov    %eax,0x14(%ebp)
  80062d:	8b 45 14             	mov    0x14(%ebp),%eax
  800630:	83 e8 04             	sub    $0x4,%eax
  800633:	8b 30                	mov    (%eax),%esi
  800635:	85 f6                	test   %esi,%esi
  800637:	75 05                	jne    80063e <vprintfmt+0x1a6>
				p = "(null)";
  800639:	be 31 1f 80 00       	mov    $0x801f31,%esi
			if (width > 0 && padc != '-')
  80063e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800642:	7e 6d                	jle    8006b1 <vprintfmt+0x219>
  800644:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800648:	74 67                	je     8006b1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80064a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80064d:	83 ec 08             	sub    $0x8,%esp
  800650:	50                   	push   %eax
  800651:	56                   	push   %esi
  800652:	e8 12 05 00 00       	call   800b69 <strnlen>
  800657:	83 c4 10             	add    $0x10,%esp
  80065a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80065d:	eb 16                	jmp    800675 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80065f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800663:	83 ec 08             	sub    $0x8,%esp
  800666:	ff 75 0c             	pushl  0xc(%ebp)
  800669:	50                   	push   %eax
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	ff d0                	call   *%eax
  80066f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800672:	ff 4d e4             	decl   -0x1c(%ebp)
  800675:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800679:	7f e4                	jg     80065f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067b:	eb 34                	jmp    8006b1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80067d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800681:	74 1c                	je     80069f <vprintfmt+0x207>
  800683:	83 fb 1f             	cmp    $0x1f,%ebx
  800686:	7e 05                	jle    80068d <vprintfmt+0x1f5>
  800688:	83 fb 7e             	cmp    $0x7e,%ebx
  80068b:	7e 12                	jle    80069f <vprintfmt+0x207>
					putch('?', putdat);
  80068d:	83 ec 08             	sub    $0x8,%esp
  800690:	ff 75 0c             	pushl  0xc(%ebp)
  800693:	6a 3f                	push   $0x3f
  800695:	8b 45 08             	mov    0x8(%ebp),%eax
  800698:	ff d0                	call   *%eax
  80069a:	83 c4 10             	add    $0x10,%esp
  80069d:	eb 0f                	jmp    8006ae <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80069f:	83 ec 08             	sub    $0x8,%esp
  8006a2:	ff 75 0c             	pushl  0xc(%ebp)
  8006a5:	53                   	push   %ebx
  8006a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a9:	ff d0                	call   *%eax
  8006ab:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ae:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b1:	89 f0                	mov    %esi,%eax
  8006b3:	8d 70 01             	lea    0x1(%eax),%esi
  8006b6:	8a 00                	mov    (%eax),%al
  8006b8:	0f be d8             	movsbl %al,%ebx
  8006bb:	85 db                	test   %ebx,%ebx
  8006bd:	74 24                	je     8006e3 <vprintfmt+0x24b>
  8006bf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c3:	78 b8                	js     80067d <vprintfmt+0x1e5>
  8006c5:	ff 4d e0             	decl   -0x20(%ebp)
  8006c8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006cc:	79 af                	jns    80067d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ce:	eb 13                	jmp    8006e3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006d0:	83 ec 08             	sub    $0x8,%esp
  8006d3:	ff 75 0c             	pushl  0xc(%ebp)
  8006d6:	6a 20                	push   $0x20
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	ff d0                	call   *%eax
  8006dd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e7:	7f e7                	jg     8006d0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006e9:	e9 66 01 00 00       	jmp    800854 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006ee:	83 ec 08             	sub    $0x8,%esp
  8006f1:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f4:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f7:	50                   	push   %eax
  8006f8:	e8 3c fd ff ff       	call   800439 <getint>
  8006fd:	83 c4 10             	add    $0x10,%esp
  800700:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800703:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800706:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800709:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070c:	85 d2                	test   %edx,%edx
  80070e:	79 23                	jns    800733 <vprintfmt+0x29b>
				putch('-', putdat);
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	ff 75 0c             	pushl  0xc(%ebp)
  800716:	6a 2d                	push   $0x2d
  800718:	8b 45 08             	mov    0x8(%ebp),%eax
  80071b:	ff d0                	call   *%eax
  80071d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800720:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800723:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800726:	f7 d8                	neg    %eax
  800728:	83 d2 00             	adc    $0x0,%edx
  80072b:	f7 da                	neg    %edx
  80072d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800730:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800733:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80073a:	e9 bc 00 00 00       	jmp    8007fb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80073f:	83 ec 08             	sub    $0x8,%esp
  800742:	ff 75 e8             	pushl  -0x18(%ebp)
  800745:	8d 45 14             	lea    0x14(%ebp),%eax
  800748:	50                   	push   %eax
  800749:	e8 84 fc ff ff       	call   8003d2 <getuint>
  80074e:	83 c4 10             	add    $0x10,%esp
  800751:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800754:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800757:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80075e:	e9 98 00 00 00       	jmp    8007fb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	6a 58                	push   $0x58
  80078b:	8b 45 08             	mov    0x8(%ebp),%eax
  80078e:	ff d0                	call   *%eax
  800790:	83 c4 10             	add    $0x10,%esp
			break;
  800793:	e9 bc 00 00 00       	jmp    800854 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800798:	83 ec 08             	sub    $0x8,%esp
  80079b:	ff 75 0c             	pushl  0xc(%ebp)
  80079e:	6a 30                	push   $0x30
  8007a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a3:	ff d0                	call   *%eax
  8007a5:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007a8:	83 ec 08             	sub    $0x8,%esp
  8007ab:	ff 75 0c             	pushl  0xc(%ebp)
  8007ae:	6a 78                	push   $0x78
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	ff d0                	call   *%eax
  8007b5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bb:	83 c0 04             	add    $0x4,%eax
  8007be:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c4:	83 e8 04             	sub    $0x4,%eax
  8007c7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007da:	eb 1f                	jmp    8007fb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007dc:	83 ec 08             	sub    $0x8,%esp
  8007df:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e2:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e5:	50                   	push   %eax
  8007e6:	e8 e7 fb ff ff       	call   8003d2 <getuint>
  8007eb:	83 c4 10             	add    $0x10,%esp
  8007ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007fb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800802:	83 ec 04             	sub    $0x4,%esp
  800805:	52                   	push   %edx
  800806:	ff 75 e4             	pushl  -0x1c(%ebp)
  800809:	50                   	push   %eax
  80080a:	ff 75 f4             	pushl  -0xc(%ebp)
  80080d:	ff 75 f0             	pushl  -0x10(%ebp)
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 00 fb ff ff       	call   80031b <printnum>
  80081b:	83 c4 20             	add    $0x20,%esp
			break;
  80081e:	eb 34                	jmp    800854 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800820:	83 ec 08             	sub    $0x8,%esp
  800823:	ff 75 0c             	pushl  0xc(%ebp)
  800826:	53                   	push   %ebx
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	ff d0                	call   *%eax
  80082c:	83 c4 10             	add    $0x10,%esp
			break;
  80082f:	eb 23                	jmp    800854 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800831:	83 ec 08             	sub    $0x8,%esp
  800834:	ff 75 0c             	pushl  0xc(%ebp)
  800837:	6a 25                	push   $0x25
  800839:	8b 45 08             	mov    0x8(%ebp),%eax
  80083c:	ff d0                	call   *%eax
  80083e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800841:	ff 4d 10             	decl   0x10(%ebp)
  800844:	eb 03                	jmp    800849 <vprintfmt+0x3b1>
  800846:	ff 4d 10             	decl   0x10(%ebp)
  800849:	8b 45 10             	mov    0x10(%ebp),%eax
  80084c:	48                   	dec    %eax
  80084d:	8a 00                	mov    (%eax),%al
  80084f:	3c 25                	cmp    $0x25,%al
  800851:	75 f3                	jne    800846 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800853:	90                   	nop
		}
	}
  800854:	e9 47 fc ff ff       	jmp    8004a0 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800859:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80085a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80085d:	5b                   	pop    %ebx
  80085e:	5e                   	pop    %esi
  80085f:	5d                   	pop    %ebp
  800860:	c3                   	ret    

00800861 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800861:	55                   	push   %ebp
  800862:	89 e5                	mov    %esp,%ebp
  800864:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800867:	8d 45 10             	lea    0x10(%ebp),%eax
  80086a:	83 c0 04             	add    $0x4,%eax
  80086d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800870:	8b 45 10             	mov    0x10(%ebp),%eax
  800873:	ff 75 f4             	pushl  -0xc(%ebp)
  800876:	50                   	push   %eax
  800877:	ff 75 0c             	pushl  0xc(%ebp)
  80087a:	ff 75 08             	pushl  0x8(%ebp)
  80087d:	e8 16 fc ff ff       	call   800498 <vprintfmt>
  800882:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800885:	90                   	nop
  800886:	c9                   	leave  
  800887:	c3                   	ret    

00800888 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800888:	55                   	push   %ebp
  800889:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80088b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088e:	8b 40 08             	mov    0x8(%eax),%eax
  800891:	8d 50 01             	lea    0x1(%eax),%edx
  800894:	8b 45 0c             	mov    0xc(%ebp),%eax
  800897:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	8b 10                	mov    (%eax),%edx
  80089f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a2:	8b 40 04             	mov    0x4(%eax),%eax
  8008a5:	39 c2                	cmp    %eax,%edx
  8008a7:	73 12                	jae    8008bb <sprintputch+0x33>
		*b->buf++ = ch;
  8008a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b4:	89 0a                	mov    %ecx,(%edx)
  8008b6:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b9:	88 10                	mov    %dl,(%eax)
}
  8008bb:	90                   	nop
  8008bc:	5d                   	pop    %ebp
  8008bd:	c3                   	ret    

008008be <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008be:	55                   	push   %ebp
  8008bf:	89 e5                	mov    %esp,%ebp
  8008c1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	01 d0                	add    %edx,%eax
  8008d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008df:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e3:	74 06                	je     8008eb <vsnprintf+0x2d>
  8008e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e9:	7f 07                	jg     8008f2 <vsnprintf+0x34>
		return -E_INVAL;
  8008eb:	b8 03 00 00 00       	mov    $0x3,%eax
  8008f0:	eb 20                	jmp    800912 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008f2:	ff 75 14             	pushl  0x14(%ebp)
  8008f5:	ff 75 10             	pushl  0x10(%ebp)
  8008f8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008fb:	50                   	push   %eax
  8008fc:	68 88 08 80 00       	push   $0x800888
  800901:	e8 92 fb ff ff       	call   800498 <vprintfmt>
  800906:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800909:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80090c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80090f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800912:	c9                   	leave  
  800913:	c3                   	ret    

00800914 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800914:	55                   	push   %ebp
  800915:	89 e5                	mov    %esp,%ebp
  800917:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80091a:	8d 45 10             	lea    0x10(%ebp),%eax
  80091d:	83 c0 04             	add    $0x4,%eax
  800920:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800923:	8b 45 10             	mov    0x10(%ebp),%eax
  800926:	ff 75 f4             	pushl  -0xc(%ebp)
  800929:	50                   	push   %eax
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	ff 75 08             	pushl  0x8(%ebp)
  800930:	e8 89 ff ff ff       	call   8008be <vsnprintf>
  800935:	83 c4 10             	add    $0x10,%esp
  800938:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80093b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093e:	c9                   	leave  
  80093f:	c3                   	ret    

00800940 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800946:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80094a:	74 13                	je     80095f <readline+0x1f>
		cprintf("%s", prompt);
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 08             	pushl  0x8(%ebp)
  800952:	68 90 20 80 00       	push   $0x802090
  800957:	e8 62 f9 ff ff       	call   8002be <cprintf>
  80095c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80095f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800966:	83 ec 0c             	sub    $0xc,%esp
  800969:	6a 00                	push   $0x0
  80096b:	e8 42 10 00 00       	call   8019b2 <iscons>
  800970:	83 c4 10             	add    $0x10,%esp
  800973:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800976:	e8 e9 0f 00 00       	call   801964 <getchar>
  80097b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80097e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800982:	79 22                	jns    8009a6 <readline+0x66>
			if (c != -E_EOF)
  800984:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800988:	0f 84 ad 00 00 00    	je     800a3b <readline+0xfb>
				cprintf("read error: %e\n", c);
  80098e:	83 ec 08             	sub    $0x8,%esp
  800991:	ff 75 ec             	pushl  -0x14(%ebp)
  800994:	68 93 20 80 00       	push   $0x802093
  800999:	e8 20 f9 ff ff       	call   8002be <cprintf>
  80099e:	83 c4 10             	add    $0x10,%esp
			return;
  8009a1:	e9 95 00 00 00       	jmp    800a3b <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009a6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009aa:	7e 34                	jle    8009e0 <readline+0xa0>
  8009ac:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009b3:	7f 2b                	jg     8009e0 <readline+0xa0>
			if (echoing)
  8009b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009b9:	74 0e                	je     8009c9 <readline+0x89>
				cputchar(c);
  8009bb:	83 ec 0c             	sub    $0xc,%esp
  8009be:	ff 75 ec             	pushl  -0x14(%ebp)
  8009c1:	e8 56 0f 00 00       	call   80191c <cputchar>
  8009c6:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009cc:	8d 50 01             	lea    0x1(%eax),%edx
  8009cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009d2:	89 c2                	mov    %eax,%edx
  8009d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d7:	01 d0                	add    %edx,%eax
  8009d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009dc:	88 10                	mov    %dl,(%eax)
  8009de:	eb 56                	jmp    800a36 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009e0:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009e4:	75 1f                	jne    800a05 <readline+0xc5>
  8009e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009ea:	7e 19                	jle    800a05 <readline+0xc5>
			if (echoing)
  8009ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009f0:	74 0e                	je     800a00 <readline+0xc0>
				cputchar(c);
  8009f2:	83 ec 0c             	sub    $0xc,%esp
  8009f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8009f8:	e8 1f 0f 00 00       	call   80191c <cputchar>
  8009fd:	83 c4 10             	add    $0x10,%esp

			i--;
  800a00:	ff 4d f4             	decl   -0xc(%ebp)
  800a03:	eb 31                	jmp    800a36 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a05:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a09:	74 0a                	je     800a15 <readline+0xd5>
  800a0b:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a0f:	0f 85 61 ff ff ff    	jne    800976 <readline+0x36>
			if (echoing)
  800a15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a19:	74 0e                	je     800a29 <readline+0xe9>
				cputchar(c);
  800a1b:	83 ec 0c             	sub    $0xc,%esp
  800a1e:	ff 75 ec             	pushl  -0x14(%ebp)
  800a21:	e8 f6 0e 00 00       	call   80191c <cputchar>
  800a26:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a29:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2f:	01 d0                	add    %edx,%eax
  800a31:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a34:	eb 06                	jmp    800a3c <readline+0xfc>
		}
	}
  800a36:	e9 3b ff ff ff       	jmp    800976 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a3b:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a3c:	c9                   	leave  
  800a3d:	c3                   	ret    

00800a3e <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
  800a41:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a44:	e8 41 0a 00 00       	call   80148a <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a49:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a4d:	74 13                	je     800a62 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a4f:	83 ec 08             	sub    $0x8,%esp
  800a52:	ff 75 08             	pushl  0x8(%ebp)
  800a55:	68 90 20 80 00       	push   $0x802090
  800a5a:	e8 5f f8 ff ff       	call   8002be <cprintf>
  800a5f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a62:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a69:	83 ec 0c             	sub    $0xc,%esp
  800a6c:	6a 00                	push   $0x0
  800a6e:	e8 3f 0f 00 00       	call   8019b2 <iscons>
  800a73:	83 c4 10             	add    $0x10,%esp
  800a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a79:	e8 e6 0e 00 00       	call   801964 <getchar>
  800a7e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a81:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a85:	79 23                	jns    800aaa <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a87:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a8b:	74 13                	je     800aa0 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 ec             	pushl  -0x14(%ebp)
  800a93:	68 93 20 80 00       	push   $0x802093
  800a98:	e8 21 f8 ff ff       	call   8002be <cprintf>
  800a9d:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800aa0:	e8 ff 09 00 00       	call   8014a4 <sys_enable_interrupt>
			return;
  800aa5:	e9 9a 00 00 00       	jmp    800b44 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800aaa:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aae:	7e 34                	jle    800ae4 <atomic_readline+0xa6>
  800ab0:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ab7:	7f 2b                	jg     800ae4 <atomic_readline+0xa6>
			if (echoing)
  800ab9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800abd:	74 0e                	je     800acd <atomic_readline+0x8f>
				cputchar(c);
  800abf:	83 ec 0c             	sub    $0xc,%esp
  800ac2:	ff 75 ec             	pushl  -0x14(%ebp)
  800ac5:	e8 52 0e 00 00       	call   80191c <cputchar>
  800aca:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ad0:	8d 50 01             	lea    0x1(%eax),%edx
  800ad3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ad6:	89 c2                	mov    %eax,%edx
  800ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adb:	01 d0                	add    %edx,%eax
  800add:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ae0:	88 10                	mov    %dl,(%eax)
  800ae2:	eb 5b                	jmp    800b3f <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800ae4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800ae8:	75 1f                	jne    800b09 <atomic_readline+0xcb>
  800aea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800aee:	7e 19                	jle    800b09 <atomic_readline+0xcb>
			if (echoing)
  800af0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800af4:	74 0e                	je     800b04 <atomic_readline+0xc6>
				cputchar(c);
  800af6:	83 ec 0c             	sub    $0xc,%esp
  800af9:	ff 75 ec             	pushl  -0x14(%ebp)
  800afc:	e8 1b 0e 00 00       	call   80191c <cputchar>
  800b01:	83 c4 10             	add    $0x10,%esp
			i--;
  800b04:	ff 4d f4             	decl   -0xc(%ebp)
  800b07:	eb 36                	jmp    800b3f <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b09:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b0d:	74 0a                	je     800b19 <atomic_readline+0xdb>
  800b0f:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b13:	0f 85 60 ff ff ff    	jne    800a79 <atomic_readline+0x3b>
			if (echoing)
  800b19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b1d:	74 0e                	je     800b2d <atomic_readline+0xef>
				cputchar(c);
  800b1f:	83 ec 0c             	sub    $0xc,%esp
  800b22:	ff 75 ec             	pushl  -0x14(%ebp)
  800b25:	e8 f2 0d 00 00       	call   80191c <cputchar>
  800b2a:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b33:	01 d0                	add    %edx,%eax
  800b35:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b38:	e8 67 09 00 00       	call   8014a4 <sys_enable_interrupt>
			return;
  800b3d:	eb 05                	jmp    800b44 <atomic_readline+0x106>
		}
	}
  800b3f:	e9 35 ff ff ff       	jmp    800a79 <atomic_readline+0x3b>
}
  800b44:	c9                   	leave  
  800b45:	c3                   	ret    

00800b46 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b46:	55                   	push   %ebp
  800b47:	89 e5                	mov    %esp,%ebp
  800b49:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b53:	eb 06                	jmp    800b5b <strlen+0x15>
		n++;
  800b55:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b58:	ff 45 08             	incl   0x8(%ebp)
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	84 c0                	test   %al,%al
  800b62:	75 f1                	jne    800b55 <strlen+0xf>
		n++;
	return n;
  800b64:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b67:	c9                   	leave  
  800b68:	c3                   	ret    

00800b69 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b69:	55                   	push   %ebp
  800b6a:	89 e5                	mov    %esp,%ebp
  800b6c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b76:	eb 09                	jmp    800b81 <strnlen+0x18>
		n++;
  800b78:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b7b:	ff 45 08             	incl   0x8(%ebp)
  800b7e:	ff 4d 0c             	decl   0xc(%ebp)
  800b81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b85:	74 09                	je     800b90 <strnlen+0x27>
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	8a 00                	mov    (%eax),%al
  800b8c:	84 c0                	test   %al,%al
  800b8e:	75 e8                	jne    800b78 <strnlen+0xf>
		n++;
	return n;
  800b90:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b93:	c9                   	leave  
  800b94:	c3                   	ret    

00800b95 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b95:	55                   	push   %ebp
  800b96:	89 e5                	mov    %esp,%ebp
  800b98:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ba1:	90                   	nop
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	8d 50 01             	lea    0x1(%eax),%edx
  800ba8:	89 55 08             	mov    %edx,0x8(%ebp)
  800bab:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bae:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bb4:	8a 12                	mov    (%edx),%dl
  800bb6:	88 10                	mov    %dl,(%eax)
  800bb8:	8a 00                	mov    (%eax),%al
  800bba:	84 c0                	test   %al,%al
  800bbc:	75 e4                	jne    800ba2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc1:	c9                   	leave  
  800bc2:	c3                   	ret    

00800bc3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bc3:	55                   	push   %ebp
  800bc4:	89 e5                	mov    %esp,%ebp
  800bc6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bcf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bd6:	eb 1f                	jmp    800bf7 <strncpy+0x34>
		*dst++ = *src;
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8d 50 01             	lea    0x1(%eax),%edx
  800bde:	89 55 08             	mov    %edx,0x8(%ebp)
  800be1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be4:	8a 12                	mov    (%edx),%dl
  800be6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800be8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800beb:	8a 00                	mov    (%eax),%al
  800bed:	84 c0                	test   %al,%al
  800bef:	74 03                	je     800bf4 <strncpy+0x31>
			src++;
  800bf1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bf4:	ff 45 fc             	incl   -0x4(%ebp)
  800bf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfa:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bfd:	72 d9                	jb     800bd8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bff:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c02:	c9                   	leave  
  800c03:	c3                   	ret    

00800c04 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c04:	55                   	push   %ebp
  800c05:	89 e5                	mov    %esp,%ebp
  800c07:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c14:	74 30                	je     800c46 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c16:	eb 16                	jmp    800c2e <strlcpy+0x2a>
			*dst++ = *src++;
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	8d 50 01             	lea    0x1(%eax),%edx
  800c1e:	89 55 08             	mov    %edx,0x8(%ebp)
  800c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c24:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c27:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c2a:	8a 12                	mov    (%edx),%dl
  800c2c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c2e:	ff 4d 10             	decl   0x10(%ebp)
  800c31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c35:	74 09                	je     800c40 <strlcpy+0x3c>
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	84 c0                	test   %al,%al
  800c3e:	75 d8                	jne    800c18 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c46:	8b 55 08             	mov    0x8(%ebp),%edx
  800c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4c:	29 c2                	sub    %eax,%edx
  800c4e:	89 d0                	mov    %edx,%eax
}
  800c50:	c9                   	leave  
  800c51:	c3                   	ret    

00800c52 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c55:	eb 06                	jmp    800c5d <strcmp+0xb>
		p++, q++;
  800c57:	ff 45 08             	incl   0x8(%ebp)
  800c5a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	8a 00                	mov    (%eax),%al
  800c62:	84 c0                	test   %al,%al
  800c64:	74 0e                	je     800c74 <strcmp+0x22>
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	8a 10                	mov    (%eax),%dl
  800c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6e:	8a 00                	mov    (%eax),%al
  800c70:	38 c2                	cmp    %al,%dl
  800c72:	74 e3                	je     800c57 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	8a 00                	mov    (%eax),%al
  800c79:	0f b6 d0             	movzbl %al,%edx
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	0f b6 c0             	movzbl %al,%eax
  800c84:	29 c2                	sub    %eax,%edx
  800c86:	89 d0                	mov    %edx,%eax
}
  800c88:	5d                   	pop    %ebp
  800c89:	c3                   	ret    

00800c8a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c8a:	55                   	push   %ebp
  800c8b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c8d:	eb 09                	jmp    800c98 <strncmp+0xe>
		n--, p++, q++;
  800c8f:	ff 4d 10             	decl   0x10(%ebp)
  800c92:	ff 45 08             	incl   0x8(%ebp)
  800c95:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9c:	74 17                	je     800cb5 <strncmp+0x2b>
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	8a 00                	mov    (%eax),%al
  800ca3:	84 c0                	test   %al,%al
  800ca5:	74 0e                	je     800cb5 <strncmp+0x2b>
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8a 10                	mov    (%eax),%dl
  800cac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	38 c2                	cmp    %al,%dl
  800cb3:	74 da                	je     800c8f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cb5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb9:	75 07                	jne    800cc2 <strncmp+0x38>
		return 0;
  800cbb:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc0:	eb 14                	jmp    800cd6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	0f b6 d0             	movzbl %al,%edx
  800cca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	0f b6 c0             	movzbl %al,%eax
  800cd2:	29 c2                	sub    %eax,%edx
  800cd4:	89 d0                	mov    %edx,%eax
}
  800cd6:	5d                   	pop    %ebp
  800cd7:	c3                   	ret    

00800cd8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cd8:	55                   	push   %ebp
  800cd9:	89 e5                	mov    %esp,%ebp
  800cdb:	83 ec 04             	sub    $0x4,%esp
  800cde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ce4:	eb 12                	jmp    800cf8 <strchr+0x20>
		if (*s == c)
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	8a 00                	mov    (%eax),%al
  800ceb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cee:	75 05                	jne    800cf5 <strchr+0x1d>
			return (char *) s;
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	eb 11                	jmp    800d06 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cf5:	ff 45 08             	incl   0x8(%ebp)
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	8a 00                	mov    (%eax),%al
  800cfd:	84 c0                	test   %al,%al
  800cff:	75 e5                	jne    800ce6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d01:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d06:	c9                   	leave  
  800d07:	c3                   	ret    

00800d08 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d08:	55                   	push   %ebp
  800d09:	89 e5                	mov    %esp,%ebp
  800d0b:	83 ec 04             	sub    $0x4,%esp
  800d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d11:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d14:	eb 0d                	jmp    800d23 <strfind+0x1b>
		if (*s == c)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d1e:	74 0e                	je     800d2e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 ea                	jne    800d16 <strfind+0xe>
  800d2c:	eb 01                	jmp    800d2f <strfind+0x27>
		if (*s == c)
			break;
  800d2e:	90                   	nop
	return (char *) s;
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d32:	c9                   	leave  
  800d33:	c3                   	ret    

00800d34 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d34:	55                   	push   %ebp
  800d35:	89 e5                	mov    %esp,%ebp
  800d37:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d40:	8b 45 10             	mov    0x10(%ebp),%eax
  800d43:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d46:	eb 0e                	jmp    800d56 <memset+0x22>
		*p++ = c;
  800d48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d4b:	8d 50 01             	lea    0x1(%eax),%edx
  800d4e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d51:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d54:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d56:	ff 4d f8             	decl   -0x8(%ebp)
  800d59:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d5d:	79 e9                	jns    800d48 <memset+0x14>
		*p++ = c;

	return v;
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d62:	c9                   	leave  
  800d63:	c3                   	ret    

00800d64 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d64:	55                   	push   %ebp
  800d65:	89 e5                	mov    %esp,%ebp
  800d67:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d76:	eb 16                	jmp    800d8e <memcpy+0x2a>
		*d++ = *s++;
  800d78:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d7b:	8d 50 01             	lea    0x1(%eax),%edx
  800d7e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d81:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d84:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d87:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d8a:	8a 12                	mov    (%edx),%dl
  800d8c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d91:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d94:	89 55 10             	mov    %edx,0x10(%ebp)
  800d97:	85 c0                	test   %eax,%eax
  800d99:	75 dd                	jne    800d78 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9e:	c9                   	leave  
  800d9f:	c3                   	ret    

00800da0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800da0:	55                   	push   %ebp
  800da1:	89 e5                	mov    %esp,%ebp
  800da3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800da6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db8:	73 50                	jae    800e0a <memmove+0x6a>
  800dba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc0:	01 d0                	add    %edx,%eax
  800dc2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc5:	76 43                	jbe    800e0a <memmove+0x6a>
		s += n;
  800dc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dca:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dd3:	eb 10                	jmp    800de5 <memmove+0x45>
			*--d = *--s;
  800dd5:	ff 4d f8             	decl   -0x8(%ebp)
  800dd8:	ff 4d fc             	decl   -0x4(%ebp)
  800ddb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dde:	8a 10                	mov    (%eax),%dl
  800de0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800de5:	8b 45 10             	mov    0x10(%ebp),%eax
  800de8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800deb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dee:	85 c0                	test   %eax,%eax
  800df0:	75 e3                	jne    800dd5 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800df2:	eb 23                	jmp    800e17 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800df4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df7:	8d 50 01             	lea    0x1(%eax),%edx
  800dfa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dfd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e00:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e03:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e06:	8a 12                	mov    (%edx),%dl
  800e08:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e10:	89 55 10             	mov    %edx,0x10(%ebp)
  800e13:	85 c0                	test   %eax,%eax
  800e15:	75 dd                	jne    800df4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e1a:	c9                   	leave  
  800e1b:	c3                   	ret    

00800e1c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
  800e1f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e2e:	eb 2a                	jmp    800e5a <memcmp+0x3e>
		if (*s1 != *s2)
  800e30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e33:	8a 10                	mov    (%eax),%dl
  800e35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	38 c2                	cmp    %al,%dl
  800e3c:	74 16                	je     800e54 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	0f b6 d0             	movzbl %al,%edx
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	8a 00                	mov    (%eax),%al
  800e4b:	0f b6 c0             	movzbl %al,%eax
  800e4e:	29 c2                	sub    %eax,%edx
  800e50:	89 d0                	mov    %edx,%eax
  800e52:	eb 18                	jmp    800e6c <memcmp+0x50>
		s1++, s2++;
  800e54:	ff 45 fc             	incl   -0x4(%ebp)
  800e57:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e60:	89 55 10             	mov    %edx,0x10(%ebp)
  800e63:	85 c0                	test   %eax,%eax
  800e65:	75 c9                	jne    800e30 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e6c:	c9                   	leave  
  800e6d:	c3                   	ret    

00800e6e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e6e:	55                   	push   %ebp
  800e6f:	89 e5                	mov    %esp,%ebp
  800e71:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e74:	8b 55 08             	mov    0x8(%ebp),%edx
  800e77:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7a:	01 d0                	add    %edx,%eax
  800e7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e7f:	eb 15                	jmp    800e96 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	0f b6 d0             	movzbl %al,%edx
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	0f b6 c0             	movzbl %al,%eax
  800e8f:	39 c2                	cmp    %eax,%edx
  800e91:	74 0d                	je     800ea0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e93:	ff 45 08             	incl   0x8(%ebp)
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e9c:	72 e3                	jb     800e81 <memfind+0x13>
  800e9e:	eb 01                	jmp    800ea1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ea0:	90                   	nop
	return (void *) s;
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea4:	c9                   	leave  
  800ea5:	c3                   	ret    

00800ea6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ea6:	55                   	push   %ebp
  800ea7:	89 e5                	mov    %esp,%ebp
  800ea9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eb3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eba:	eb 03                	jmp    800ebf <strtol+0x19>
		s++;
  800ebc:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	3c 20                	cmp    $0x20,%al
  800ec6:	74 f4                	je     800ebc <strtol+0x16>
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	3c 09                	cmp    $0x9,%al
  800ecf:	74 eb                	je     800ebc <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	3c 2b                	cmp    $0x2b,%al
  800ed8:	75 05                	jne    800edf <strtol+0x39>
		s++;
  800eda:	ff 45 08             	incl   0x8(%ebp)
  800edd:	eb 13                	jmp    800ef2 <strtol+0x4c>
	else if (*s == '-')
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	3c 2d                	cmp    $0x2d,%al
  800ee6:	75 0a                	jne    800ef2 <strtol+0x4c>
		s++, neg = 1;
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ef2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef6:	74 06                	je     800efe <strtol+0x58>
  800ef8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800efc:	75 20                	jne    800f1e <strtol+0x78>
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	3c 30                	cmp    $0x30,%al
  800f05:	75 17                	jne    800f1e <strtol+0x78>
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	40                   	inc    %eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	3c 78                	cmp    $0x78,%al
  800f0f:	75 0d                	jne    800f1e <strtol+0x78>
		s += 2, base = 16;
  800f11:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f15:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f1c:	eb 28                	jmp    800f46 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f22:	75 15                	jne    800f39 <strtol+0x93>
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	3c 30                	cmp    $0x30,%al
  800f2b:	75 0c                	jne    800f39 <strtol+0x93>
		s++, base = 8;
  800f2d:	ff 45 08             	incl   0x8(%ebp)
  800f30:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f37:	eb 0d                	jmp    800f46 <strtol+0xa0>
	else if (base == 0)
  800f39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3d:	75 07                	jne    800f46 <strtol+0xa0>
		base = 10;
  800f3f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	3c 2f                	cmp    $0x2f,%al
  800f4d:	7e 19                	jle    800f68 <strtol+0xc2>
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	3c 39                	cmp    $0x39,%al
  800f56:	7f 10                	jg     800f68 <strtol+0xc2>
			dig = *s - '0';
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	0f be c0             	movsbl %al,%eax
  800f60:	83 e8 30             	sub    $0x30,%eax
  800f63:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f66:	eb 42                	jmp    800faa <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3c 60                	cmp    $0x60,%al
  800f6f:	7e 19                	jle    800f8a <strtol+0xe4>
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	3c 7a                	cmp    $0x7a,%al
  800f78:	7f 10                	jg     800f8a <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	0f be c0             	movsbl %al,%eax
  800f82:	83 e8 57             	sub    $0x57,%eax
  800f85:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f88:	eb 20                	jmp    800faa <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 40                	cmp    $0x40,%al
  800f91:	7e 39                	jle    800fcc <strtol+0x126>
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 5a                	cmp    $0x5a,%al
  800f9a:	7f 30                	jg     800fcc <strtol+0x126>
			dig = *s - 'A' + 10;
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	0f be c0             	movsbl %al,%eax
  800fa4:	83 e8 37             	sub    $0x37,%eax
  800fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800faa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fad:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fb0:	7d 19                	jge    800fcb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fb2:	ff 45 08             	incl   0x8(%ebp)
  800fb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb8:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fbc:	89 c2                	mov    %eax,%edx
  800fbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc1:	01 d0                	add    %edx,%eax
  800fc3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fc6:	e9 7b ff ff ff       	jmp    800f46 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fcb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fcc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd0:	74 08                	je     800fda <strtol+0x134>
		*endptr = (char *) s;
  800fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fda:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fde:	74 07                	je     800fe7 <strtol+0x141>
  800fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe3:	f7 d8                	neg    %eax
  800fe5:	eb 03                	jmp    800fea <strtol+0x144>
  800fe7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <ltostr>:

void
ltostr(long value, char *str)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
  800fef:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ff2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ff9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801000:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801004:	79 13                	jns    801019 <ltostr+0x2d>
	{
		neg = 1;
  801006:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80100d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801010:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801013:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801016:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801021:	99                   	cltd   
  801022:	f7 f9                	idiv   %ecx
  801024:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801027:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80102a:	8d 50 01             	lea    0x1(%eax),%edx
  80102d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801030:	89 c2                	mov    %eax,%edx
  801032:	8b 45 0c             	mov    0xc(%ebp),%eax
  801035:	01 d0                	add    %edx,%eax
  801037:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80103a:	83 c2 30             	add    $0x30,%edx
  80103d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80103f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801042:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801047:	f7 e9                	imul   %ecx
  801049:	c1 fa 02             	sar    $0x2,%edx
  80104c:	89 c8                	mov    %ecx,%eax
  80104e:	c1 f8 1f             	sar    $0x1f,%eax
  801051:	29 c2                	sub    %eax,%edx
  801053:	89 d0                	mov    %edx,%eax
  801055:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801058:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80105b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801060:	f7 e9                	imul   %ecx
  801062:	c1 fa 02             	sar    $0x2,%edx
  801065:	89 c8                	mov    %ecx,%eax
  801067:	c1 f8 1f             	sar    $0x1f,%eax
  80106a:	29 c2                	sub    %eax,%edx
  80106c:	89 d0                	mov    %edx,%eax
  80106e:	c1 e0 02             	shl    $0x2,%eax
  801071:	01 d0                	add    %edx,%eax
  801073:	01 c0                	add    %eax,%eax
  801075:	29 c1                	sub    %eax,%ecx
  801077:	89 ca                	mov    %ecx,%edx
  801079:	85 d2                	test   %edx,%edx
  80107b:	75 9c                	jne    801019 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80107d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	48                   	dec    %eax
  801088:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80108b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80108f:	74 3d                	je     8010ce <ltostr+0xe2>
		start = 1 ;
  801091:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801098:	eb 34                	jmp    8010ce <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80109a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a0:	01 d0                	add    %edx,%eax
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ad:	01 c2                	add    %eax,%edx
  8010af:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b5:	01 c8                	add    %ecx,%eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010bb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c1:	01 c2                	add    %eax,%edx
  8010c3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010c6:	88 02                	mov    %al,(%edx)
		start++ ;
  8010c8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010cb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010d4:	7c c4                	jl     80109a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dc:	01 d0                	add    %edx,%eax
  8010de:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010e1:	90                   	nop
  8010e2:	c9                   	leave  
  8010e3:	c3                   	ret    

008010e4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010e4:	55                   	push   %ebp
  8010e5:	89 e5                	mov    %esp,%ebp
  8010e7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010ea:	ff 75 08             	pushl  0x8(%ebp)
  8010ed:	e8 54 fa ff ff       	call   800b46 <strlen>
  8010f2:	83 c4 04             	add    $0x4,%esp
  8010f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010f8:	ff 75 0c             	pushl  0xc(%ebp)
  8010fb:	e8 46 fa ff ff       	call   800b46 <strlen>
  801100:	83 c4 04             	add    $0x4,%esp
  801103:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80110d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801114:	eb 17                	jmp    80112d <strcconcat+0x49>
		final[s] = str1[s] ;
  801116:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801119:	8b 45 10             	mov    0x10(%ebp),%eax
  80111c:	01 c2                	add    %eax,%edx
  80111e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801121:	8b 45 08             	mov    0x8(%ebp),%eax
  801124:	01 c8                	add    %ecx,%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80112a:	ff 45 fc             	incl   -0x4(%ebp)
  80112d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801130:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801133:	7c e1                	jl     801116 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801135:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80113c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801143:	eb 1f                	jmp    801164 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801145:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801148:	8d 50 01             	lea    0x1(%eax),%edx
  80114b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80114e:	89 c2                	mov    %eax,%edx
  801150:	8b 45 10             	mov    0x10(%ebp),%eax
  801153:	01 c2                	add    %eax,%edx
  801155:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	01 c8                	add    %ecx,%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801161:	ff 45 f8             	incl   -0x8(%ebp)
  801164:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801167:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80116a:	7c d9                	jl     801145 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80116c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116f:	8b 45 10             	mov    0x10(%ebp),%eax
  801172:	01 d0                	add    %edx,%eax
  801174:	c6 00 00             	movb   $0x0,(%eax)
}
  801177:	90                   	nop
  801178:	c9                   	leave  
  801179:	c3                   	ret    

0080117a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80117d:	8b 45 14             	mov    0x14(%ebp),%eax
  801180:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801186:	8b 45 14             	mov    0x14(%ebp),%eax
  801189:	8b 00                	mov    (%eax),%eax
  80118b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801192:	8b 45 10             	mov    0x10(%ebp),%eax
  801195:	01 d0                	add    %edx,%eax
  801197:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119d:	eb 0c                	jmp    8011ab <strsplit+0x31>
			*string++ = 0;
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8d 50 01             	lea    0x1(%eax),%edx
  8011a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8011a8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	84 c0                	test   %al,%al
  8011b2:	74 18                	je     8011cc <strsplit+0x52>
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	0f be c0             	movsbl %al,%eax
  8011bc:	50                   	push   %eax
  8011bd:	ff 75 0c             	pushl  0xc(%ebp)
  8011c0:	e8 13 fb ff ff       	call   800cd8 <strchr>
  8011c5:	83 c4 08             	add    $0x8,%esp
  8011c8:	85 c0                	test   %eax,%eax
  8011ca:	75 d3                	jne    80119f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	8a 00                	mov    (%eax),%al
  8011d1:	84 c0                	test   %al,%al
  8011d3:	74 5a                	je     80122f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8011d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d8:	8b 00                	mov    (%eax),%eax
  8011da:	83 f8 0f             	cmp    $0xf,%eax
  8011dd:	75 07                	jne    8011e6 <strsplit+0x6c>
		{
			return 0;
  8011df:	b8 00 00 00 00       	mov    $0x0,%eax
  8011e4:	eb 66                	jmp    80124c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e9:	8b 00                	mov    (%eax),%eax
  8011eb:	8d 48 01             	lea    0x1(%eax),%ecx
  8011ee:	8b 55 14             	mov    0x14(%ebp),%edx
  8011f1:	89 0a                	mov    %ecx,(%edx)
  8011f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fd:	01 c2                	add    %eax,%edx
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801204:	eb 03                	jmp    801209 <strsplit+0x8f>
			string++;
  801206:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801209:	8b 45 08             	mov    0x8(%ebp),%eax
  80120c:	8a 00                	mov    (%eax),%al
  80120e:	84 c0                	test   %al,%al
  801210:	74 8b                	je     80119d <strsplit+0x23>
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	0f be c0             	movsbl %al,%eax
  80121a:	50                   	push   %eax
  80121b:	ff 75 0c             	pushl  0xc(%ebp)
  80121e:	e8 b5 fa ff ff       	call   800cd8 <strchr>
  801223:	83 c4 08             	add    $0x8,%esp
  801226:	85 c0                	test   %eax,%eax
  801228:	74 dc                	je     801206 <strsplit+0x8c>
			string++;
	}
  80122a:	e9 6e ff ff ff       	jmp    80119d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80122f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801230:	8b 45 14             	mov    0x14(%ebp),%eax
  801233:	8b 00                	mov    (%eax),%eax
  801235:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123c:	8b 45 10             	mov    0x10(%ebp),%eax
  80123f:	01 d0                	add    %edx,%eax
  801241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801247:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
  801251:	57                   	push   %edi
  801252:	56                   	push   %esi
  801253:	53                   	push   %ebx
  801254:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80125d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801260:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801263:	8b 7d 18             	mov    0x18(%ebp),%edi
  801266:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801269:	cd 30                	int    $0x30
  80126b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80126e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801271:	83 c4 10             	add    $0x10,%esp
  801274:	5b                   	pop    %ebx
  801275:	5e                   	pop    %esi
  801276:	5f                   	pop    %edi
  801277:	5d                   	pop    %ebp
  801278:	c3                   	ret    

00801279 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
  80127c:	83 ec 04             	sub    $0x4,%esp
  80127f:	8b 45 10             	mov    0x10(%ebp),%eax
  801282:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801285:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	52                   	push   %edx
  801291:	ff 75 0c             	pushl  0xc(%ebp)
  801294:	50                   	push   %eax
  801295:	6a 00                	push   $0x0
  801297:	e8 b2 ff ff ff       	call   80124e <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 01                	push   $0x1
  8012b1:	e8 98 ff ff ff       	call   80124e <syscall>
  8012b6:	83 c4 18             	add    $0x18,%esp
}
  8012b9:	c9                   	leave  
  8012ba:	c3                   	ret    

008012bb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	50                   	push   %eax
  8012ca:	6a 05                	push   $0x5
  8012cc:	e8 7d ff ff ff       	call   80124e <syscall>
  8012d1:	83 c4 18             	add    $0x18,%esp
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 02                	push   $0x2
  8012e5:	e8 64 ff ff ff       	call   80124e <syscall>
  8012ea:	83 c4 18             	add    $0x18,%esp
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 03                	push   $0x3
  8012fe:	e8 4b ff ff ff       	call   80124e <syscall>
  801303:	83 c4 18             	add    $0x18,%esp
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 04                	push   $0x4
  801317:	e8 32 ff ff ff       	call   80124e <syscall>
  80131c:	83 c4 18             	add    $0x18,%esp
}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <sys_env_exit>:


void sys_env_exit(void)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 06                	push   $0x6
  801330:	e8 19 ff ff ff       	call   80124e <syscall>
  801335:	83 c4 18             	add    $0x18,%esp
}
  801338:	90                   	nop
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80133e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	52                   	push   %edx
  80134b:	50                   	push   %eax
  80134c:	6a 07                	push   $0x7
  80134e:	e8 fb fe ff ff       	call   80124e <syscall>
  801353:	83 c4 18             	add    $0x18,%esp
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
  80135b:	56                   	push   %esi
  80135c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80135d:	8b 75 18             	mov    0x18(%ebp),%esi
  801360:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801363:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801366:	8b 55 0c             	mov    0xc(%ebp),%edx
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
  80136c:	56                   	push   %esi
  80136d:	53                   	push   %ebx
  80136e:	51                   	push   %ecx
  80136f:	52                   	push   %edx
  801370:	50                   	push   %eax
  801371:	6a 08                	push   $0x8
  801373:	e8 d6 fe ff ff       	call   80124e <syscall>
  801378:	83 c4 18             	add    $0x18,%esp
}
  80137b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80137e:	5b                   	pop    %ebx
  80137f:	5e                   	pop    %esi
  801380:	5d                   	pop    %ebp
  801381:	c3                   	ret    

00801382 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801385:	8b 55 0c             	mov    0xc(%ebp),%edx
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	52                   	push   %edx
  801392:	50                   	push   %eax
  801393:	6a 09                	push   $0x9
  801395:	e8 b4 fe ff ff       	call   80124e <syscall>
  80139a:	83 c4 18             	add    $0x18,%esp
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	ff 75 0c             	pushl  0xc(%ebp)
  8013ab:	ff 75 08             	pushl  0x8(%ebp)
  8013ae:	6a 0a                	push   $0xa
  8013b0:	e8 99 fe ff ff       	call   80124e <syscall>
  8013b5:	83 c4 18             	add    $0x18,%esp
}
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 0b                	push   $0xb
  8013c9:	e8 80 fe ff ff       	call   80124e <syscall>
  8013ce:	83 c4 18             	add    $0x18,%esp
}
  8013d1:	c9                   	leave  
  8013d2:	c3                   	ret    

008013d3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 0c                	push   $0xc
  8013e2:	e8 67 fe ff ff       	call   80124e <syscall>
  8013e7:	83 c4 18             	add    $0x18,%esp
}
  8013ea:	c9                   	leave  
  8013eb:	c3                   	ret    

008013ec <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013ec:	55                   	push   %ebp
  8013ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 0d                	push   $0xd
  8013fb:	e8 4e fe ff ff       	call   80124e <syscall>
  801400:	83 c4 18             	add    $0x18,%esp
}
  801403:	c9                   	leave  
  801404:	c3                   	ret    

00801405 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801405:	55                   	push   %ebp
  801406:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	ff 75 0c             	pushl  0xc(%ebp)
  801411:	ff 75 08             	pushl  0x8(%ebp)
  801414:	6a 11                	push   $0x11
  801416:	e8 33 fe ff ff       	call   80124e <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
	return;
  80141e:	90                   	nop
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	ff 75 08             	pushl  0x8(%ebp)
  801430:	6a 12                	push   $0x12
  801432:	e8 17 fe ff ff       	call   80124e <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
	return ;
  80143a:	90                   	nop
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 0e                	push   $0xe
  80144c:	e8 fd fd ff ff       	call   80124e <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	ff 75 08             	pushl  0x8(%ebp)
  801464:	6a 0f                	push   $0xf
  801466:	e8 e3 fd ff ff       	call   80124e <syscall>
  80146b:	83 c4 18             	add    $0x18,%esp
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 10                	push   $0x10
  80147f:	e8 ca fd ff ff       	call   80124e <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
}
  801487:	90                   	nop
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 14                	push   $0x14
  801499:	e8 b0 fd ff ff       	call   80124e <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
}
  8014a1:	90                   	nop
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 15                	push   $0x15
  8014b3:	e8 96 fd ff ff       	call   80124e <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	90                   	nop
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <sys_cputc>:


void
sys_cputc(const char c)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
  8014c1:	83 ec 04             	sub    $0x4,%esp
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014ca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	50                   	push   %eax
  8014d7:	6a 16                	push   $0x16
  8014d9:	e8 70 fd ff ff       	call   80124e <syscall>
  8014de:	83 c4 18             	add    $0x18,%esp
}
  8014e1:	90                   	nop
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 17                	push   $0x17
  8014f3:	e8 56 fd ff ff       	call   80124e <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
}
  8014fb:	90                   	nop
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	ff 75 0c             	pushl  0xc(%ebp)
  80150d:	50                   	push   %eax
  80150e:	6a 18                	push   $0x18
  801510:	e8 39 fd ff ff       	call   80124e <syscall>
  801515:	83 c4 18             	add    $0x18,%esp
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80151d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	52                   	push   %edx
  80152a:	50                   	push   %eax
  80152b:	6a 1b                	push   $0x1b
  80152d:	e8 1c fd ff ff       	call   80124e <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80153a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	52                   	push   %edx
  801547:	50                   	push   %eax
  801548:	6a 19                	push   $0x19
  80154a:	e8 ff fc ff ff       	call   80124e <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
}
  801552:	90                   	nop
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	52                   	push   %edx
  801565:	50                   	push   %eax
  801566:	6a 1a                	push   $0x1a
  801568:	e8 e1 fc ff ff       	call   80124e <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	90                   	nop
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
  801576:	83 ec 04             	sub    $0x4,%esp
  801579:	8b 45 10             	mov    0x10(%ebp),%eax
  80157c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80157f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801582:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	51                   	push   %ecx
  80158c:	52                   	push   %edx
  80158d:	ff 75 0c             	pushl  0xc(%ebp)
  801590:	50                   	push   %eax
  801591:	6a 1c                	push   $0x1c
  801593:	e8 b6 fc ff ff       	call   80124e <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	52                   	push   %edx
  8015ad:	50                   	push   %eax
  8015ae:	6a 1d                	push   $0x1d
  8015b0:	e8 99 fc ff ff       	call   80124e <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	51                   	push   %ecx
  8015cb:	52                   	push   %edx
  8015cc:	50                   	push   %eax
  8015cd:	6a 1e                	push   $0x1e
  8015cf:	e8 7a fc ff ff       	call   80124e <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	52                   	push   %edx
  8015e9:	50                   	push   %eax
  8015ea:	6a 1f                	push   $0x1f
  8015ec:	e8 5d fc ff ff       	call   80124e <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 20                	push   $0x20
  801605:	e8 44 fc ff ff       	call   80124e <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	ff 75 10             	pushl  0x10(%ebp)
  80161c:	ff 75 0c             	pushl  0xc(%ebp)
  80161f:	50                   	push   %eax
  801620:	6a 21                	push   $0x21
  801622:	e8 27 fc ff ff       	call   80124e <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	50                   	push   %eax
  80163b:	6a 22                	push   $0x22
  80163d:	e8 0c fc ff ff       	call   80124e <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	90                   	nop
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	50                   	push   %eax
  801657:	6a 23                	push   $0x23
  801659:	e8 f0 fb ff ff       	call   80124e <syscall>
  80165e:	83 c4 18             	add    $0x18,%esp
}
  801661:	90                   	nop
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
  801667:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80166a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80166d:	8d 50 04             	lea    0x4(%eax),%edx
  801670:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	52                   	push   %edx
  80167a:	50                   	push   %eax
  80167b:	6a 24                	push   $0x24
  80167d:	e8 cc fb ff ff       	call   80124e <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
	return result;
  801685:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801688:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80168b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80168e:	89 01                	mov    %eax,(%ecx)
  801690:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	c9                   	leave  
  801697:	c2 04 00             	ret    $0x4

0080169a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	ff 75 10             	pushl  0x10(%ebp)
  8016a4:	ff 75 0c             	pushl  0xc(%ebp)
  8016a7:	ff 75 08             	pushl  0x8(%ebp)
  8016aa:	6a 13                	push   $0x13
  8016ac:	e8 9d fb ff ff       	call   80124e <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b4:	90                   	nop
}
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 25                	push   $0x25
  8016c6:	e8 83 fb ff ff       	call   80124e <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 04             	sub    $0x4,%esp
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016dc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	50                   	push   %eax
  8016e9:	6a 26                	push   $0x26
  8016eb:	e8 5e fb ff ff       	call   80124e <syscall>
  8016f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f3:	90                   	nop
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <rsttst>:
void rsttst()
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 28                	push   $0x28
  801705:	e8 44 fb ff ff       	call   80124e <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
	return ;
  80170d:	90                   	nop
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
  801713:	83 ec 04             	sub    $0x4,%esp
  801716:	8b 45 14             	mov    0x14(%ebp),%eax
  801719:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80171c:	8b 55 18             	mov    0x18(%ebp),%edx
  80171f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801723:	52                   	push   %edx
  801724:	50                   	push   %eax
  801725:	ff 75 10             	pushl  0x10(%ebp)
  801728:	ff 75 0c             	pushl  0xc(%ebp)
  80172b:	ff 75 08             	pushl  0x8(%ebp)
  80172e:	6a 27                	push   $0x27
  801730:	e8 19 fb ff ff       	call   80124e <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
	return ;
  801738:	90                   	nop
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <chktst>:
void chktst(uint32 n)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	ff 75 08             	pushl  0x8(%ebp)
  801749:	6a 29                	push   $0x29
  80174b:	e8 fe fa ff ff       	call   80124e <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
	return ;
  801753:	90                   	nop
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <inctst>:

void inctst()
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 2a                	push   $0x2a
  801765:	e8 e4 fa ff ff       	call   80124e <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
	return ;
  80176d:	90                   	nop
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <gettst>:
uint32 gettst()
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 2b                	push   $0x2b
  80177f:	e8 ca fa ff ff       	call   80124e <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
  80178c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 2c                	push   $0x2c
  80179b:	e8 ae fa ff ff       	call   80124e <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
  8017a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017a6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017aa:	75 07                	jne    8017b3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017ac:	b8 01 00 00 00       	mov    $0x1,%eax
  8017b1:	eb 05                	jmp    8017b8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 2c                	push   $0x2c
  8017cc:	e8 7d fa ff ff       	call   80124e <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
  8017d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017d7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017db:	75 07                	jne    8017e4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e2:	eb 05                	jmp    8017e9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
  8017ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 2c                	push   $0x2c
  8017fd:	e8 4c fa ff ff       	call   80124e <syscall>
  801802:	83 c4 18             	add    $0x18,%esp
  801805:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801808:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80180c:	75 07                	jne    801815 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80180e:	b8 01 00 00 00       	mov    $0x1,%eax
  801813:	eb 05                	jmp    80181a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801815:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80181a:	c9                   	leave  
  80181b:	c3                   	ret    

0080181c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80181c:	55                   	push   %ebp
  80181d:	89 e5                	mov    %esp,%ebp
  80181f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 2c                	push   $0x2c
  80182e:	e8 1b fa ff ff       	call   80124e <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
  801836:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801839:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80183d:	75 07                	jne    801846 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80183f:	b8 01 00 00 00       	mov    $0x1,%eax
  801844:	eb 05                	jmp    80184b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801846:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	ff 75 08             	pushl  0x8(%ebp)
  80185b:	6a 2d                	push   $0x2d
  80185d:	e8 ec f9 ff ff       	call   80124e <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
	return ;
  801865:	90                   	nop
}
  801866:	c9                   	leave  
  801867:	c3                   	ret    

00801868 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801868:	55                   	push   %ebp
  801869:	89 e5                	mov    %esp,%ebp
  80186b:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80186e:	8b 55 08             	mov    0x8(%ebp),%edx
  801871:	89 d0                	mov    %edx,%eax
  801873:	c1 e0 02             	shl    $0x2,%eax
  801876:	01 d0                	add    %edx,%eax
  801878:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80187f:	01 d0                	add    %edx,%eax
  801881:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801888:	01 d0                	add    %edx,%eax
  80188a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801891:	01 d0                	add    %edx,%eax
  801893:	c1 e0 04             	shl    $0x4,%eax
  801896:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801899:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8018a0:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8018a3:	83 ec 0c             	sub    $0xc,%esp
  8018a6:	50                   	push   %eax
  8018a7:	e8 b8 fd ff ff       	call   801664 <sys_get_virtual_time>
  8018ac:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8018af:	eb 41                	jmp    8018f2 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8018b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8018b4:	83 ec 0c             	sub    $0xc,%esp
  8018b7:	50                   	push   %eax
  8018b8:	e8 a7 fd ff ff       	call   801664 <sys_get_virtual_time>
  8018bd:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8018c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018c6:	29 c2                	sub    %eax,%edx
  8018c8:	89 d0                	mov    %edx,%eax
  8018ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8018cd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8018d3:	89 d1                	mov    %edx,%ecx
  8018d5:	29 c1                	sub    %eax,%ecx
  8018d7:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8018da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018dd:	39 c2                	cmp    %eax,%edx
  8018df:	0f 97 c0             	seta   %al
  8018e2:	0f b6 c0             	movzbl %al,%eax
  8018e5:	29 c1                	sub    %eax,%ecx
  8018e7:	89 c8                	mov    %ecx,%eax
  8018e9:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8018ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8018ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8018f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018f8:	72 b7                	jb     8018b1 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  8018fa:	90                   	nop
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
  801900:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801903:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80190a:	eb 03                	jmp    80190f <busy_wait+0x12>
  80190c:	ff 45 fc             	incl   -0x4(%ebp)
  80190f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801912:	3b 45 08             	cmp    0x8(%ebp),%eax
  801915:	72 f5                	jb     80190c <busy_wait+0xf>
	return i;
  801917:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
  80191f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801928:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80192c:	83 ec 0c             	sub    $0xc,%esp
  80192f:	50                   	push   %eax
  801930:	e8 89 fb ff ff       	call   8014be <sys_cputc>
  801935:	83 c4 10             	add    $0x10,%esp
}
  801938:	90                   	nop
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
  80193e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801941:	e8 44 fb ff ff       	call   80148a <sys_disable_interrupt>
	char c = ch;
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80194c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801950:	83 ec 0c             	sub    $0xc,%esp
  801953:	50                   	push   %eax
  801954:	e8 65 fb ff ff       	call   8014be <sys_cputc>
  801959:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80195c:	e8 43 fb ff ff       	call   8014a4 <sys_enable_interrupt>
}
  801961:	90                   	nop
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <getchar>:

int
getchar(void)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
  801967:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80196a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801971:	eb 08                	jmp    80197b <getchar+0x17>
	{
		c = sys_cgetc();
  801973:	e8 2a f9 ff ff       	call   8012a2 <sys_cgetc>
  801978:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80197b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80197f:	74 f2                	je     801973 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801981:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <atomic_getchar>:

int
atomic_getchar(void)
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
  801989:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80198c:	e8 f9 fa ff ff       	call   80148a <sys_disable_interrupt>
	int c=0;
  801991:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801998:	eb 08                	jmp    8019a2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  80199a:	e8 03 f9 ff ff       	call   8012a2 <sys_cgetc>
  80199f:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8019a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019a6:	74 f2                	je     80199a <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8019a8:	e8 f7 fa ff ff       	call   8014a4 <sys_enable_interrupt>
	return c;
  8019ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <iscons>:

int iscons(int fdnum)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8019b5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ba:	5d                   	pop    %ebp
  8019bb:	c3                   	ret    

008019bc <__udivdi3>:
  8019bc:	55                   	push   %ebp
  8019bd:	57                   	push   %edi
  8019be:	56                   	push   %esi
  8019bf:	53                   	push   %ebx
  8019c0:	83 ec 1c             	sub    $0x1c,%esp
  8019c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8019c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8019cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8019cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019d3:	89 ca                	mov    %ecx,%edx
  8019d5:	89 f8                	mov    %edi,%eax
  8019d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019db:	85 f6                	test   %esi,%esi
  8019dd:	75 2d                	jne    801a0c <__udivdi3+0x50>
  8019df:	39 cf                	cmp    %ecx,%edi
  8019e1:	77 65                	ja     801a48 <__udivdi3+0x8c>
  8019e3:	89 fd                	mov    %edi,%ebp
  8019e5:	85 ff                	test   %edi,%edi
  8019e7:	75 0b                	jne    8019f4 <__udivdi3+0x38>
  8019e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ee:	31 d2                	xor    %edx,%edx
  8019f0:	f7 f7                	div    %edi
  8019f2:	89 c5                	mov    %eax,%ebp
  8019f4:	31 d2                	xor    %edx,%edx
  8019f6:	89 c8                	mov    %ecx,%eax
  8019f8:	f7 f5                	div    %ebp
  8019fa:	89 c1                	mov    %eax,%ecx
  8019fc:	89 d8                	mov    %ebx,%eax
  8019fe:	f7 f5                	div    %ebp
  801a00:	89 cf                	mov    %ecx,%edi
  801a02:	89 fa                	mov    %edi,%edx
  801a04:	83 c4 1c             	add    $0x1c,%esp
  801a07:	5b                   	pop    %ebx
  801a08:	5e                   	pop    %esi
  801a09:	5f                   	pop    %edi
  801a0a:	5d                   	pop    %ebp
  801a0b:	c3                   	ret    
  801a0c:	39 ce                	cmp    %ecx,%esi
  801a0e:	77 28                	ja     801a38 <__udivdi3+0x7c>
  801a10:	0f bd fe             	bsr    %esi,%edi
  801a13:	83 f7 1f             	xor    $0x1f,%edi
  801a16:	75 40                	jne    801a58 <__udivdi3+0x9c>
  801a18:	39 ce                	cmp    %ecx,%esi
  801a1a:	72 0a                	jb     801a26 <__udivdi3+0x6a>
  801a1c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a20:	0f 87 9e 00 00 00    	ja     801ac4 <__udivdi3+0x108>
  801a26:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2b:	89 fa                	mov    %edi,%edx
  801a2d:	83 c4 1c             	add    $0x1c,%esp
  801a30:	5b                   	pop    %ebx
  801a31:	5e                   	pop    %esi
  801a32:	5f                   	pop    %edi
  801a33:	5d                   	pop    %ebp
  801a34:	c3                   	ret    
  801a35:	8d 76 00             	lea    0x0(%esi),%esi
  801a38:	31 ff                	xor    %edi,%edi
  801a3a:	31 c0                	xor    %eax,%eax
  801a3c:	89 fa                	mov    %edi,%edx
  801a3e:	83 c4 1c             	add    $0x1c,%esp
  801a41:	5b                   	pop    %ebx
  801a42:	5e                   	pop    %esi
  801a43:	5f                   	pop    %edi
  801a44:	5d                   	pop    %ebp
  801a45:	c3                   	ret    
  801a46:	66 90                	xchg   %ax,%ax
  801a48:	89 d8                	mov    %ebx,%eax
  801a4a:	f7 f7                	div    %edi
  801a4c:	31 ff                	xor    %edi,%edi
  801a4e:	89 fa                	mov    %edi,%edx
  801a50:	83 c4 1c             	add    $0x1c,%esp
  801a53:	5b                   	pop    %ebx
  801a54:	5e                   	pop    %esi
  801a55:	5f                   	pop    %edi
  801a56:	5d                   	pop    %ebp
  801a57:	c3                   	ret    
  801a58:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a5d:	89 eb                	mov    %ebp,%ebx
  801a5f:	29 fb                	sub    %edi,%ebx
  801a61:	89 f9                	mov    %edi,%ecx
  801a63:	d3 e6                	shl    %cl,%esi
  801a65:	89 c5                	mov    %eax,%ebp
  801a67:	88 d9                	mov    %bl,%cl
  801a69:	d3 ed                	shr    %cl,%ebp
  801a6b:	89 e9                	mov    %ebp,%ecx
  801a6d:	09 f1                	or     %esi,%ecx
  801a6f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a73:	89 f9                	mov    %edi,%ecx
  801a75:	d3 e0                	shl    %cl,%eax
  801a77:	89 c5                	mov    %eax,%ebp
  801a79:	89 d6                	mov    %edx,%esi
  801a7b:	88 d9                	mov    %bl,%cl
  801a7d:	d3 ee                	shr    %cl,%esi
  801a7f:	89 f9                	mov    %edi,%ecx
  801a81:	d3 e2                	shl    %cl,%edx
  801a83:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a87:	88 d9                	mov    %bl,%cl
  801a89:	d3 e8                	shr    %cl,%eax
  801a8b:	09 c2                	or     %eax,%edx
  801a8d:	89 d0                	mov    %edx,%eax
  801a8f:	89 f2                	mov    %esi,%edx
  801a91:	f7 74 24 0c          	divl   0xc(%esp)
  801a95:	89 d6                	mov    %edx,%esi
  801a97:	89 c3                	mov    %eax,%ebx
  801a99:	f7 e5                	mul    %ebp
  801a9b:	39 d6                	cmp    %edx,%esi
  801a9d:	72 19                	jb     801ab8 <__udivdi3+0xfc>
  801a9f:	74 0b                	je     801aac <__udivdi3+0xf0>
  801aa1:	89 d8                	mov    %ebx,%eax
  801aa3:	31 ff                	xor    %edi,%edi
  801aa5:	e9 58 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801aaa:	66 90                	xchg   %ax,%ax
  801aac:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ab0:	89 f9                	mov    %edi,%ecx
  801ab2:	d3 e2                	shl    %cl,%edx
  801ab4:	39 c2                	cmp    %eax,%edx
  801ab6:	73 e9                	jae    801aa1 <__udivdi3+0xe5>
  801ab8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801abb:	31 ff                	xor    %edi,%edi
  801abd:	e9 40 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801ac2:	66 90                	xchg   %ax,%ax
  801ac4:	31 c0                	xor    %eax,%eax
  801ac6:	e9 37 ff ff ff       	jmp    801a02 <__udivdi3+0x46>
  801acb:	90                   	nop

00801acc <__umoddi3>:
  801acc:	55                   	push   %ebp
  801acd:	57                   	push   %edi
  801ace:	56                   	push   %esi
  801acf:	53                   	push   %ebx
  801ad0:	83 ec 1c             	sub    $0x1c,%esp
  801ad3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ad7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801adb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801adf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ae3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ae7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aeb:	89 f3                	mov    %esi,%ebx
  801aed:	89 fa                	mov    %edi,%edx
  801aef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801af3:	89 34 24             	mov    %esi,(%esp)
  801af6:	85 c0                	test   %eax,%eax
  801af8:	75 1a                	jne    801b14 <__umoddi3+0x48>
  801afa:	39 f7                	cmp    %esi,%edi
  801afc:	0f 86 a2 00 00 00    	jbe    801ba4 <__umoddi3+0xd8>
  801b02:	89 c8                	mov    %ecx,%eax
  801b04:	89 f2                	mov    %esi,%edx
  801b06:	f7 f7                	div    %edi
  801b08:	89 d0                	mov    %edx,%eax
  801b0a:	31 d2                	xor    %edx,%edx
  801b0c:	83 c4 1c             	add    $0x1c,%esp
  801b0f:	5b                   	pop    %ebx
  801b10:	5e                   	pop    %esi
  801b11:	5f                   	pop    %edi
  801b12:	5d                   	pop    %ebp
  801b13:	c3                   	ret    
  801b14:	39 f0                	cmp    %esi,%eax
  801b16:	0f 87 ac 00 00 00    	ja     801bc8 <__umoddi3+0xfc>
  801b1c:	0f bd e8             	bsr    %eax,%ebp
  801b1f:	83 f5 1f             	xor    $0x1f,%ebp
  801b22:	0f 84 ac 00 00 00    	je     801bd4 <__umoddi3+0x108>
  801b28:	bf 20 00 00 00       	mov    $0x20,%edi
  801b2d:	29 ef                	sub    %ebp,%edi
  801b2f:	89 fe                	mov    %edi,%esi
  801b31:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b35:	89 e9                	mov    %ebp,%ecx
  801b37:	d3 e0                	shl    %cl,%eax
  801b39:	89 d7                	mov    %edx,%edi
  801b3b:	89 f1                	mov    %esi,%ecx
  801b3d:	d3 ef                	shr    %cl,%edi
  801b3f:	09 c7                	or     %eax,%edi
  801b41:	89 e9                	mov    %ebp,%ecx
  801b43:	d3 e2                	shl    %cl,%edx
  801b45:	89 14 24             	mov    %edx,(%esp)
  801b48:	89 d8                	mov    %ebx,%eax
  801b4a:	d3 e0                	shl    %cl,%eax
  801b4c:	89 c2                	mov    %eax,%edx
  801b4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b52:	d3 e0                	shl    %cl,%eax
  801b54:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b58:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b5c:	89 f1                	mov    %esi,%ecx
  801b5e:	d3 e8                	shr    %cl,%eax
  801b60:	09 d0                	or     %edx,%eax
  801b62:	d3 eb                	shr    %cl,%ebx
  801b64:	89 da                	mov    %ebx,%edx
  801b66:	f7 f7                	div    %edi
  801b68:	89 d3                	mov    %edx,%ebx
  801b6a:	f7 24 24             	mull   (%esp)
  801b6d:	89 c6                	mov    %eax,%esi
  801b6f:	89 d1                	mov    %edx,%ecx
  801b71:	39 d3                	cmp    %edx,%ebx
  801b73:	0f 82 87 00 00 00    	jb     801c00 <__umoddi3+0x134>
  801b79:	0f 84 91 00 00 00    	je     801c10 <__umoddi3+0x144>
  801b7f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b83:	29 f2                	sub    %esi,%edx
  801b85:	19 cb                	sbb    %ecx,%ebx
  801b87:	89 d8                	mov    %ebx,%eax
  801b89:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b8d:	d3 e0                	shl    %cl,%eax
  801b8f:	89 e9                	mov    %ebp,%ecx
  801b91:	d3 ea                	shr    %cl,%edx
  801b93:	09 d0                	or     %edx,%eax
  801b95:	89 e9                	mov    %ebp,%ecx
  801b97:	d3 eb                	shr    %cl,%ebx
  801b99:	89 da                	mov    %ebx,%edx
  801b9b:	83 c4 1c             	add    $0x1c,%esp
  801b9e:	5b                   	pop    %ebx
  801b9f:	5e                   	pop    %esi
  801ba0:	5f                   	pop    %edi
  801ba1:	5d                   	pop    %ebp
  801ba2:	c3                   	ret    
  801ba3:	90                   	nop
  801ba4:	89 fd                	mov    %edi,%ebp
  801ba6:	85 ff                	test   %edi,%edi
  801ba8:	75 0b                	jne    801bb5 <__umoddi3+0xe9>
  801baa:	b8 01 00 00 00       	mov    $0x1,%eax
  801baf:	31 d2                	xor    %edx,%edx
  801bb1:	f7 f7                	div    %edi
  801bb3:	89 c5                	mov    %eax,%ebp
  801bb5:	89 f0                	mov    %esi,%eax
  801bb7:	31 d2                	xor    %edx,%edx
  801bb9:	f7 f5                	div    %ebp
  801bbb:	89 c8                	mov    %ecx,%eax
  801bbd:	f7 f5                	div    %ebp
  801bbf:	89 d0                	mov    %edx,%eax
  801bc1:	e9 44 ff ff ff       	jmp    801b0a <__umoddi3+0x3e>
  801bc6:	66 90                	xchg   %ax,%ax
  801bc8:	89 c8                	mov    %ecx,%eax
  801bca:	89 f2                	mov    %esi,%edx
  801bcc:	83 c4 1c             	add    $0x1c,%esp
  801bcf:	5b                   	pop    %ebx
  801bd0:	5e                   	pop    %esi
  801bd1:	5f                   	pop    %edi
  801bd2:	5d                   	pop    %ebp
  801bd3:	c3                   	ret    
  801bd4:	3b 04 24             	cmp    (%esp),%eax
  801bd7:	72 06                	jb     801bdf <__umoddi3+0x113>
  801bd9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bdd:	77 0f                	ja     801bee <__umoddi3+0x122>
  801bdf:	89 f2                	mov    %esi,%edx
  801be1:	29 f9                	sub    %edi,%ecx
  801be3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801be7:	89 14 24             	mov    %edx,(%esp)
  801bea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bee:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bf2:	8b 14 24             	mov    (%esp),%edx
  801bf5:	83 c4 1c             	add    $0x1c,%esp
  801bf8:	5b                   	pop    %ebx
  801bf9:	5e                   	pop    %esi
  801bfa:	5f                   	pop    %edi
  801bfb:	5d                   	pop    %ebp
  801bfc:	c3                   	ret    
  801bfd:	8d 76 00             	lea    0x0(%esi),%esi
  801c00:	2b 04 24             	sub    (%esp),%eax
  801c03:	19 fa                	sbb    %edi,%edx
  801c05:	89 d1                	mov    %edx,%ecx
  801c07:	89 c6                	mov    %eax,%esi
  801c09:	e9 71 ff ff ff       	jmp    801b7f <__umoddi3+0xb3>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c14:	72 ea                	jb     801c00 <__umoddi3+0x134>
  801c16:	89 d9                	mov    %ebx,%ecx
  801c18:	e9 62 ff ff ff       	jmp    801b7f <__umoddi3+0xb3>
