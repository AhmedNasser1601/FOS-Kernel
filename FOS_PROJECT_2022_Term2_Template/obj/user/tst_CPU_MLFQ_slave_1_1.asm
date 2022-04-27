
obj/user/tst_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 92 00 00 00       	call   8000c8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 3; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 2f                	jmp    800076 <_main+0x3e>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),0);
  800047:	a1 04 20 80 00       	mov    0x802004,%eax
  80004c:	8b 40 74             	mov    0x74(%eax),%eax
  80004f:	83 ec 04             	sub    $0x4,%esp
  800052:	6a 00                	push   $0x0
  800054:	50                   	push   %eax
  800055:	68 80 19 80 00       	push   $0x801980
  80005a:	e8 97 13 00 00       	call   8013f6 <sys_create_env>
  80005f:	83 c4 10             	add    $0x10,%esp
  800062:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  800065:	83 ec 0c             	sub    $0xc,%esp
  800068:	ff 75 f0             	pushl  -0x10(%ebp)
  80006b:	e8 a3 13 00 00       	call   801413 <sys_run_env>
  800070:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 3; ++i) {
  800073:	ff 45 f4             	incl   -0xc(%ebp)
  800076:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80007a:	7e cb                	jle    800047 <_main+0xf>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),0);
		sys_run_env(ID);
	}
	env_sleep(50);
  80007c:	83 ec 0c             	sub    $0xc,%esp
  80007f:	6a 32                	push   $0x32
  800081:	e8 c9 15 00 00       	call   80164f <env_sleep>
  800086:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("cpuMLFQ1Slave_2", (myEnv->page_WS_max_size), 0);
  800089:	a1 04 20 80 00       	mov    0x802004,%eax
  80008e:	8b 40 74             	mov    0x74(%eax),%eax
  800091:	83 ec 04             	sub    $0x4,%esp
  800094:	6a 00                	push   $0x0
  800096:	50                   	push   %eax
  800097:	68 8e 19 80 00       	push   $0x80198e
  80009c:	e8 55 13 00 00       	call   8013f6 <sys_create_env>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  8000a7:	83 ec 0c             	sub    $0xc,%esp
  8000aa:	ff 75 f0             	pushl  -0x10(%ebp)
  8000ad:	e8 61 13 00 00       	call   801413 <sys_run_env>
  8000b2:	83 c4 10             	add    $0x10,%esp

	env_sleep(5000);
  8000b5:	83 ec 0c             	sub    $0xc,%esp
  8000b8:	68 88 13 00 00       	push   $0x1388
  8000bd:	e8 8d 15 00 00       	call   80164f <env_sleep>
  8000c2:	83 c4 10             	add    $0x10,%esp

	return;
  8000c5:	90                   	nop
}
  8000c6:	c9                   	leave  
  8000c7:	c3                   	ret    

008000c8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c8:	55                   	push   %ebp
  8000c9:	89 e5                	mov    %esp,%ebp
  8000cb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000ce:	e8 03 10 00 00       	call   8010d6 <sys_getenvindex>
  8000d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d9:	89 d0                	mov    %edx,%eax
  8000db:	c1 e0 02             	shl    $0x2,%eax
  8000de:	01 d0                	add    %edx,%eax
  8000e0:	01 c0                	add    %eax,%eax
  8000e2:	01 d0                	add    %edx,%eax
  8000e4:	01 c0                	add    %eax,%eax
  8000e6:	01 d0                	add    %edx,%eax
  8000e8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000ef:	01 d0                	add    %edx,%eax
  8000f1:	c1 e0 02             	shl    $0x2,%eax
  8000f4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f9:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000fe:	a1 04 20 80 00       	mov    0x802004,%eax
  800103:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800109:	84 c0                	test   %al,%al
  80010b:	74 0f                	je     80011c <libmain+0x54>
		binaryname = myEnv->prog_name;
  80010d:	a1 04 20 80 00       	mov    0x802004,%eax
  800112:	05 f4 02 00 00       	add    $0x2f4,%eax
  800117:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80011c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800120:	7e 0a                	jle    80012c <libmain+0x64>
		binaryname = argv[0];
  800122:	8b 45 0c             	mov    0xc(%ebp),%eax
  800125:	8b 00                	mov    (%eax),%eax
  800127:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80012c:	83 ec 08             	sub    $0x8,%esp
  80012f:	ff 75 0c             	pushl  0xc(%ebp)
  800132:	ff 75 08             	pushl  0x8(%ebp)
  800135:	e8 fe fe ff ff       	call   800038 <_main>
  80013a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80013d:	e8 2f 11 00 00       	call   801271 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800142:	83 ec 0c             	sub    $0xc,%esp
  800145:	68 b8 19 80 00       	push   $0x8019b8
  80014a:	e8 5c 01 00 00       	call   8002ab <cprintf>
  80014f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800152:	a1 04 20 80 00       	mov    0x802004,%eax
  800157:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80015d:	a1 04 20 80 00       	mov    0x802004,%eax
  800162:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800168:	83 ec 04             	sub    $0x4,%esp
  80016b:	52                   	push   %edx
  80016c:	50                   	push   %eax
  80016d:	68 e0 19 80 00       	push   $0x8019e0
  800172:	e8 34 01 00 00       	call   8002ab <cprintf>
  800177:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80017a:	a1 04 20 80 00       	mov    0x802004,%eax
  80017f:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800185:	83 ec 08             	sub    $0x8,%esp
  800188:	50                   	push   %eax
  800189:	68 05 1a 80 00       	push   $0x801a05
  80018e:	e8 18 01 00 00       	call   8002ab <cprintf>
  800193:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800196:	83 ec 0c             	sub    $0xc,%esp
  800199:	68 b8 19 80 00       	push   $0x8019b8
  80019e:	e8 08 01 00 00       	call   8002ab <cprintf>
  8001a3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001a6:	e8 e0 10 00 00       	call   80128b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001ab:	e8 19 00 00 00       	call   8001c9 <exit>
}
  8001b0:	90                   	nop
  8001b1:	c9                   	leave  
  8001b2:	c3                   	ret    

008001b3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b3:	55                   	push   %ebp
  8001b4:	89 e5                	mov    %esp,%ebp
  8001b6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001b9:	83 ec 0c             	sub    $0xc,%esp
  8001bc:	6a 00                	push   $0x0
  8001be:	e8 df 0e 00 00       	call   8010a2 <sys_env_destroy>
  8001c3:	83 c4 10             	add    $0x10,%esp
}
  8001c6:	90                   	nop
  8001c7:	c9                   	leave  
  8001c8:	c3                   	ret    

008001c9 <exit>:

void
exit(void)
{
  8001c9:	55                   	push   %ebp
  8001ca:	89 e5                	mov    %esp,%ebp
  8001cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001cf:	e8 34 0f 00 00       	call   801108 <sys_env_exit>
}
  8001d4:	90                   	nop
  8001d5:	c9                   	leave  
  8001d6:	c3                   	ret    

008001d7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001d7:	55                   	push   %ebp
  8001d8:	89 e5                	mov    %esp,%ebp
  8001da:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e0:	8b 00                	mov    (%eax),%eax
  8001e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8001e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e8:	89 0a                	mov    %ecx,(%edx)
  8001ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8001ed:	88 d1                	mov    %dl,%cl
  8001ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	3d ff 00 00 00       	cmp    $0xff,%eax
  800200:	75 2c                	jne    80022e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800202:	a0 08 20 80 00       	mov    0x802008,%al
  800207:	0f b6 c0             	movzbl %al,%eax
  80020a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020d:	8b 12                	mov    (%edx),%edx
  80020f:	89 d1                	mov    %edx,%ecx
  800211:	8b 55 0c             	mov    0xc(%ebp),%edx
  800214:	83 c2 08             	add    $0x8,%edx
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	50                   	push   %eax
  80021b:	51                   	push   %ecx
  80021c:	52                   	push   %edx
  80021d:	e8 3e 0e 00 00       	call   801060 <sys_cputs>
  800222:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800225:	8b 45 0c             	mov    0xc(%ebp),%eax
  800228:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80022e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800231:	8b 40 04             	mov    0x4(%eax),%eax
  800234:	8d 50 01             	lea    0x1(%eax),%edx
  800237:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80023d:	90                   	nop
  80023e:	c9                   	leave  
  80023f:	c3                   	ret    

00800240 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800240:	55                   	push   %ebp
  800241:	89 e5                	mov    %esp,%ebp
  800243:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800249:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800250:	00 00 00 
	b.cnt = 0;
  800253:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80025a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80025d:	ff 75 0c             	pushl  0xc(%ebp)
  800260:	ff 75 08             	pushl  0x8(%ebp)
  800263:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800269:	50                   	push   %eax
  80026a:	68 d7 01 80 00       	push   $0x8001d7
  80026f:	e8 11 02 00 00       	call   800485 <vprintfmt>
  800274:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800277:	a0 08 20 80 00       	mov    0x802008,%al
  80027c:	0f b6 c0             	movzbl %al,%eax
  80027f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800285:	83 ec 04             	sub    $0x4,%esp
  800288:	50                   	push   %eax
  800289:	52                   	push   %edx
  80028a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800290:	83 c0 08             	add    $0x8,%eax
  800293:	50                   	push   %eax
  800294:	e8 c7 0d 00 00       	call   801060 <sys_cputs>
  800299:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80029c:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  8002a3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002a9:	c9                   	leave  
  8002aa:	c3                   	ret    

008002ab <cprintf>:

int cprintf(const char *fmt, ...) {
  8002ab:	55                   	push   %ebp
  8002ac:	89 e5                	mov    %esp,%ebp
  8002ae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b1:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002b8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002be:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c7:	50                   	push   %eax
  8002c8:	e8 73 ff ff ff       	call   800240 <vcprintf>
  8002cd:	83 c4 10             	add    $0x10,%esp
  8002d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d6:	c9                   	leave  
  8002d7:	c3                   	ret    

008002d8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002d8:	55                   	push   %ebp
  8002d9:	89 e5                	mov    %esp,%ebp
  8002db:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002de:	e8 8e 0f 00 00       	call   801271 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ec:	83 ec 08             	sub    $0x8,%esp
  8002ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f2:	50                   	push   %eax
  8002f3:	e8 48 ff ff ff       	call   800240 <vcprintf>
  8002f8:	83 c4 10             	add    $0x10,%esp
  8002fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002fe:	e8 88 0f 00 00       	call   80128b <sys_enable_interrupt>
	return cnt;
  800303:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800306:	c9                   	leave  
  800307:	c3                   	ret    

00800308 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800308:	55                   	push   %ebp
  800309:	89 e5                	mov    %esp,%ebp
  80030b:	53                   	push   %ebx
  80030c:	83 ec 14             	sub    $0x14,%esp
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800315:	8b 45 14             	mov    0x14(%ebp),%eax
  800318:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80031b:	8b 45 18             	mov    0x18(%ebp),%eax
  80031e:	ba 00 00 00 00       	mov    $0x0,%edx
  800323:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800326:	77 55                	ja     80037d <printnum+0x75>
  800328:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032b:	72 05                	jb     800332 <printnum+0x2a>
  80032d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800330:	77 4b                	ja     80037d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800332:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800335:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800338:	8b 45 18             	mov    0x18(%ebp),%eax
  80033b:	ba 00 00 00 00       	mov    $0x0,%edx
  800340:	52                   	push   %edx
  800341:	50                   	push   %eax
  800342:	ff 75 f4             	pushl  -0xc(%ebp)
  800345:	ff 75 f0             	pushl  -0x10(%ebp)
  800348:	e8 b7 13 00 00       	call   801704 <__udivdi3>
  80034d:	83 c4 10             	add    $0x10,%esp
  800350:	83 ec 04             	sub    $0x4,%esp
  800353:	ff 75 20             	pushl  0x20(%ebp)
  800356:	53                   	push   %ebx
  800357:	ff 75 18             	pushl  0x18(%ebp)
  80035a:	52                   	push   %edx
  80035b:	50                   	push   %eax
  80035c:	ff 75 0c             	pushl  0xc(%ebp)
  80035f:	ff 75 08             	pushl  0x8(%ebp)
  800362:	e8 a1 ff ff ff       	call   800308 <printnum>
  800367:	83 c4 20             	add    $0x20,%esp
  80036a:	eb 1a                	jmp    800386 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80036c:	83 ec 08             	sub    $0x8,%esp
  80036f:	ff 75 0c             	pushl  0xc(%ebp)
  800372:	ff 75 20             	pushl  0x20(%ebp)
  800375:	8b 45 08             	mov    0x8(%ebp),%eax
  800378:	ff d0                	call   *%eax
  80037a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80037d:	ff 4d 1c             	decl   0x1c(%ebp)
  800380:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800384:	7f e6                	jg     80036c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800386:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800389:	bb 00 00 00 00       	mov    $0x0,%ebx
  80038e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800391:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800394:	53                   	push   %ebx
  800395:	51                   	push   %ecx
  800396:	52                   	push   %edx
  800397:	50                   	push   %eax
  800398:	e8 77 14 00 00       	call   801814 <__umoddi3>
  80039d:	83 c4 10             	add    $0x10,%esp
  8003a0:	05 34 1c 80 00       	add    $0x801c34,%eax
  8003a5:	8a 00                	mov    (%eax),%al
  8003a7:	0f be c0             	movsbl %al,%eax
  8003aa:	83 ec 08             	sub    $0x8,%esp
  8003ad:	ff 75 0c             	pushl  0xc(%ebp)
  8003b0:	50                   	push   %eax
  8003b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b4:	ff d0                	call   *%eax
  8003b6:	83 c4 10             	add    $0x10,%esp
}
  8003b9:	90                   	nop
  8003ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003bd:	c9                   	leave  
  8003be:	c3                   	ret    

008003bf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003bf:	55                   	push   %ebp
  8003c0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c6:	7e 1c                	jle    8003e4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	8d 50 08             	lea    0x8(%eax),%edx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	89 10                	mov    %edx,(%eax)
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	83 e8 08             	sub    $0x8,%eax
  8003dd:	8b 50 04             	mov    0x4(%eax),%edx
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	eb 40                	jmp    800424 <getuint+0x65>
	else if (lflag)
  8003e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e8:	74 1e                	je     800408 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	8d 50 04             	lea    0x4(%eax),%edx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	89 10                	mov    %edx,(%eax)
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	83 e8 04             	sub    $0x4,%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	ba 00 00 00 00       	mov    $0x0,%edx
  800406:	eb 1c                	jmp    800424 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800408:	8b 45 08             	mov    0x8(%ebp),%eax
  80040b:	8b 00                	mov    (%eax),%eax
  80040d:	8d 50 04             	lea    0x4(%eax),%edx
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	89 10                	mov    %edx,(%eax)
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	8b 00                	mov    (%eax),%eax
  80041a:	83 e8 04             	sub    $0x4,%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800424:	5d                   	pop    %ebp
  800425:	c3                   	ret    

00800426 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800426:	55                   	push   %ebp
  800427:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800429:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80042d:	7e 1c                	jle    80044b <getint+0x25>
		return va_arg(*ap, long long);
  80042f:	8b 45 08             	mov    0x8(%ebp),%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	8d 50 08             	lea    0x8(%eax),%edx
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	89 10                	mov    %edx,(%eax)
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	83 e8 08             	sub    $0x8,%eax
  800444:	8b 50 04             	mov    0x4(%eax),%edx
  800447:	8b 00                	mov    (%eax),%eax
  800449:	eb 38                	jmp    800483 <getint+0x5d>
	else if (lflag)
  80044b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80044f:	74 1a                	je     80046b <getint+0x45>
		return va_arg(*ap, long);
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	8d 50 04             	lea    0x4(%eax),%edx
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	89 10                	mov    %edx,(%eax)
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	83 e8 04             	sub    $0x4,%eax
  800466:	8b 00                	mov    (%eax),%eax
  800468:	99                   	cltd   
  800469:	eb 18                	jmp    800483 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	8d 50 04             	lea    0x4(%eax),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	89 10                	mov    %edx,(%eax)
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	83 e8 04             	sub    $0x4,%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	99                   	cltd   
}
  800483:	5d                   	pop    %ebp
  800484:	c3                   	ret    

00800485 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800485:	55                   	push   %ebp
  800486:	89 e5                	mov    %esp,%ebp
  800488:	56                   	push   %esi
  800489:	53                   	push   %ebx
  80048a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80048d:	eb 17                	jmp    8004a6 <vprintfmt+0x21>
			if (ch == '\0')
  80048f:	85 db                	test   %ebx,%ebx
  800491:	0f 84 af 03 00 00    	je     800846 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800497:	83 ec 08             	sub    $0x8,%esp
  80049a:	ff 75 0c             	pushl  0xc(%ebp)
  80049d:	53                   	push   %ebx
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	ff d0                	call   *%eax
  8004a3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a9:	8d 50 01             	lea    0x1(%eax),%edx
  8004ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8004af:	8a 00                	mov    (%eax),%al
  8004b1:	0f b6 d8             	movzbl %al,%ebx
  8004b4:	83 fb 25             	cmp    $0x25,%ebx
  8004b7:	75 d6                	jne    80048f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004b9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004bd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004c4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004cb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004d2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004dc:	8d 50 01             	lea    0x1(%eax),%edx
  8004df:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e2:	8a 00                	mov    (%eax),%al
  8004e4:	0f b6 d8             	movzbl %al,%ebx
  8004e7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ea:	83 f8 55             	cmp    $0x55,%eax
  8004ed:	0f 87 2b 03 00 00    	ja     80081e <vprintfmt+0x399>
  8004f3:	8b 04 85 58 1c 80 00 	mov    0x801c58(,%eax,4),%eax
  8004fa:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004fc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800500:	eb d7                	jmp    8004d9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800502:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800506:	eb d1                	jmp    8004d9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800508:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80050f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800512:	89 d0                	mov    %edx,%eax
  800514:	c1 e0 02             	shl    $0x2,%eax
  800517:	01 d0                	add    %edx,%eax
  800519:	01 c0                	add    %eax,%eax
  80051b:	01 d8                	add    %ebx,%eax
  80051d:	83 e8 30             	sub    $0x30,%eax
  800520:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800523:	8b 45 10             	mov    0x10(%ebp),%eax
  800526:	8a 00                	mov    (%eax),%al
  800528:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80052b:	83 fb 2f             	cmp    $0x2f,%ebx
  80052e:	7e 3e                	jle    80056e <vprintfmt+0xe9>
  800530:	83 fb 39             	cmp    $0x39,%ebx
  800533:	7f 39                	jg     80056e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800535:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800538:	eb d5                	jmp    80050f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80053a:	8b 45 14             	mov    0x14(%ebp),%eax
  80053d:	83 c0 04             	add    $0x4,%eax
  800540:	89 45 14             	mov    %eax,0x14(%ebp)
  800543:	8b 45 14             	mov    0x14(%ebp),%eax
  800546:	83 e8 04             	sub    $0x4,%eax
  800549:	8b 00                	mov    (%eax),%eax
  80054b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80054e:	eb 1f                	jmp    80056f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800550:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800554:	79 83                	jns    8004d9 <vprintfmt+0x54>
				width = 0;
  800556:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80055d:	e9 77 ff ff ff       	jmp    8004d9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800562:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800569:	e9 6b ff ff ff       	jmp    8004d9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80056e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80056f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800573:	0f 89 60 ff ff ff    	jns    8004d9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800579:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80057c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80057f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800586:	e9 4e ff ff ff       	jmp    8004d9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80058b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80058e:	e9 46 ff ff ff       	jmp    8004d9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800593:	8b 45 14             	mov    0x14(%ebp),%eax
  800596:	83 c0 04             	add    $0x4,%eax
  800599:	89 45 14             	mov    %eax,0x14(%ebp)
  80059c:	8b 45 14             	mov    0x14(%ebp),%eax
  80059f:	83 e8 04             	sub    $0x4,%eax
  8005a2:	8b 00                	mov    (%eax),%eax
  8005a4:	83 ec 08             	sub    $0x8,%esp
  8005a7:	ff 75 0c             	pushl  0xc(%ebp)
  8005aa:	50                   	push   %eax
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	ff d0                	call   *%eax
  8005b0:	83 c4 10             	add    $0x10,%esp
			break;
  8005b3:	e9 89 02 00 00       	jmp    800841 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bb:	83 c0 04             	add    $0x4,%eax
  8005be:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c4:	83 e8 04             	sub    $0x4,%eax
  8005c7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005c9:	85 db                	test   %ebx,%ebx
  8005cb:	79 02                	jns    8005cf <vprintfmt+0x14a>
				err = -err;
  8005cd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005cf:	83 fb 64             	cmp    $0x64,%ebx
  8005d2:	7f 0b                	jg     8005df <vprintfmt+0x15a>
  8005d4:	8b 34 9d a0 1a 80 00 	mov    0x801aa0(,%ebx,4),%esi
  8005db:	85 f6                	test   %esi,%esi
  8005dd:	75 19                	jne    8005f8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005df:	53                   	push   %ebx
  8005e0:	68 45 1c 80 00       	push   $0x801c45
  8005e5:	ff 75 0c             	pushl  0xc(%ebp)
  8005e8:	ff 75 08             	pushl  0x8(%ebp)
  8005eb:	e8 5e 02 00 00       	call   80084e <printfmt>
  8005f0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f3:	e9 49 02 00 00       	jmp    800841 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005f8:	56                   	push   %esi
  8005f9:	68 4e 1c 80 00       	push   $0x801c4e
  8005fe:	ff 75 0c             	pushl  0xc(%ebp)
  800601:	ff 75 08             	pushl  0x8(%ebp)
  800604:	e8 45 02 00 00       	call   80084e <printfmt>
  800609:	83 c4 10             	add    $0x10,%esp
			break;
  80060c:	e9 30 02 00 00       	jmp    800841 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800611:	8b 45 14             	mov    0x14(%ebp),%eax
  800614:	83 c0 04             	add    $0x4,%eax
  800617:	89 45 14             	mov    %eax,0x14(%ebp)
  80061a:	8b 45 14             	mov    0x14(%ebp),%eax
  80061d:	83 e8 04             	sub    $0x4,%eax
  800620:	8b 30                	mov    (%eax),%esi
  800622:	85 f6                	test   %esi,%esi
  800624:	75 05                	jne    80062b <vprintfmt+0x1a6>
				p = "(null)";
  800626:	be 51 1c 80 00       	mov    $0x801c51,%esi
			if (width > 0 && padc != '-')
  80062b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062f:	7e 6d                	jle    80069e <vprintfmt+0x219>
  800631:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800635:	74 67                	je     80069e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800637:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	50                   	push   %eax
  80063e:	56                   	push   %esi
  80063f:	e8 0c 03 00 00       	call   800950 <strnlen>
  800644:	83 c4 10             	add    $0x10,%esp
  800647:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80064a:	eb 16                	jmp    800662 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80064c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800650:	83 ec 08             	sub    $0x8,%esp
  800653:	ff 75 0c             	pushl  0xc(%ebp)
  800656:	50                   	push   %eax
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	ff d0                	call   *%eax
  80065c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80065f:	ff 4d e4             	decl   -0x1c(%ebp)
  800662:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800666:	7f e4                	jg     80064c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800668:	eb 34                	jmp    80069e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80066a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80066e:	74 1c                	je     80068c <vprintfmt+0x207>
  800670:	83 fb 1f             	cmp    $0x1f,%ebx
  800673:	7e 05                	jle    80067a <vprintfmt+0x1f5>
  800675:	83 fb 7e             	cmp    $0x7e,%ebx
  800678:	7e 12                	jle    80068c <vprintfmt+0x207>
					putch('?', putdat);
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 0c             	pushl  0xc(%ebp)
  800680:	6a 3f                	push   $0x3f
  800682:	8b 45 08             	mov    0x8(%ebp),%eax
  800685:	ff d0                	call   *%eax
  800687:	83 c4 10             	add    $0x10,%esp
  80068a:	eb 0f                	jmp    80069b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80068c:	83 ec 08             	sub    $0x8,%esp
  80068f:	ff 75 0c             	pushl  0xc(%ebp)
  800692:	53                   	push   %ebx
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	ff d0                	call   *%eax
  800698:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80069b:	ff 4d e4             	decl   -0x1c(%ebp)
  80069e:	89 f0                	mov    %esi,%eax
  8006a0:	8d 70 01             	lea    0x1(%eax),%esi
  8006a3:	8a 00                	mov    (%eax),%al
  8006a5:	0f be d8             	movsbl %al,%ebx
  8006a8:	85 db                	test   %ebx,%ebx
  8006aa:	74 24                	je     8006d0 <vprintfmt+0x24b>
  8006ac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b0:	78 b8                	js     80066a <vprintfmt+0x1e5>
  8006b2:	ff 4d e0             	decl   -0x20(%ebp)
  8006b5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b9:	79 af                	jns    80066a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006bb:	eb 13                	jmp    8006d0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006bd:	83 ec 08             	sub    $0x8,%esp
  8006c0:	ff 75 0c             	pushl  0xc(%ebp)
  8006c3:	6a 20                	push   $0x20
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	ff d0                	call   *%eax
  8006ca:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006cd:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d4:	7f e7                	jg     8006bd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006d6:	e9 66 01 00 00       	jmp    800841 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006db:	83 ec 08             	sub    $0x8,%esp
  8006de:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e4:	50                   	push   %eax
  8006e5:	e8 3c fd ff ff       	call   800426 <getint>
  8006ea:	83 c4 10             	add    $0x10,%esp
  8006ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f9:	85 d2                	test   %edx,%edx
  8006fb:	79 23                	jns    800720 <vprintfmt+0x29b>
				putch('-', putdat);
  8006fd:	83 ec 08             	sub    $0x8,%esp
  800700:	ff 75 0c             	pushl  0xc(%ebp)
  800703:	6a 2d                	push   $0x2d
  800705:	8b 45 08             	mov    0x8(%ebp),%eax
  800708:	ff d0                	call   *%eax
  80070a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80070d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800710:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800713:	f7 d8                	neg    %eax
  800715:	83 d2 00             	adc    $0x0,%edx
  800718:	f7 da                	neg    %edx
  80071a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800720:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800727:	e9 bc 00 00 00       	jmp    8007e8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 e8             	pushl  -0x18(%ebp)
  800732:	8d 45 14             	lea    0x14(%ebp),%eax
  800735:	50                   	push   %eax
  800736:	e8 84 fc ff ff       	call   8003bf <getuint>
  80073b:	83 c4 10             	add    $0x10,%esp
  80073e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800741:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800744:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80074b:	e9 98 00 00 00       	jmp    8007e8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	6a 58                	push   $0x58
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	ff d0                	call   *%eax
  80077d:	83 c4 10             	add    $0x10,%esp
			break;
  800780:	e9 bc 00 00 00       	jmp    800841 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800785:	83 ec 08             	sub    $0x8,%esp
  800788:	ff 75 0c             	pushl  0xc(%ebp)
  80078b:	6a 30                	push   $0x30
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	ff d0                	call   *%eax
  800792:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800795:	83 ec 08             	sub    $0x8,%esp
  800798:	ff 75 0c             	pushl  0xc(%ebp)
  80079b:	6a 78                	push   $0x78
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a8:	83 c0 04             	add    $0x4,%eax
  8007ab:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007c7:	eb 1f                	jmp    8007e8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	ff 75 e8             	pushl  -0x18(%ebp)
  8007cf:	8d 45 14             	lea    0x14(%ebp),%eax
  8007d2:	50                   	push   %eax
  8007d3:	e8 e7 fb ff ff       	call   8003bf <getuint>
  8007d8:	83 c4 10             	add    $0x10,%esp
  8007db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007de:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007e8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ef:	83 ec 04             	sub    $0x4,%esp
  8007f2:	52                   	push   %edx
  8007f3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007f6:	50                   	push   %eax
  8007f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fd:	ff 75 0c             	pushl  0xc(%ebp)
  800800:	ff 75 08             	pushl  0x8(%ebp)
  800803:	e8 00 fb ff ff       	call   800308 <printnum>
  800808:	83 c4 20             	add    $0x20,%esp
			break;
  80080b:	eb 34                	jmp    800841 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	53                   	push   %ebx
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	ff d0                	call   *%eax
  800819:	83 c4 10             	add    $0x10,%esp
			break;
  80081c:	eb 23                	jmp    800841 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 0c             	pushl  0xc(%ebp)
  800824:	6a 25                	push   $0x25
  800826:	8b 45 08             	mov    0x8(%ebp),%eax
  800829:	ff d0                	call   *%eax
  80082b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80082e:	ff 4d 10             	decl   0x10(%ebp)
  800831:	eb 03                	jmp    800836 <vprintfmt+0x3b1>
  800833:	ff 4d 10             	decl   0x10(%ebp)
  800836:	8b 45 10             	mov    0x10(%ebp),%eax
  800839:	48                   	dec    %eax
  80083a:	8a 00                	mov    (%eax),%al
  80083c:	3c 25                	cmp    $0x25,%al
  80083e:	75 f3                	jne    800833 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800840:	90                   	nop
		}
	}
  800841:	e9 47 fc ff ff       	jmp    80048d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800846:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800847:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80084a:	5b                   	pop    %ebx
  80084b:	5e                   	pop    %esi
  80084c:	5d                   	pop    %ebp
  80084d:	c3                   	ret    

0080084e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80084e:	55                   	push   %ebp
  80084f:	89 e5                	mov    %esp,%ebp
  800851:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800854:	8d 45 10             	lea    0x10(%ebp),%eax
  800857:	83 c0 04             	add    $0x4,%eax
  80085a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80085d:	8b 45 10             	mov    0x10(%ebp),%eax
  800860:	ff 75 f4             	pushl  -0xc(%ebp)
  800863:	50                   	push   %eax
  800864:	ff 75 0c             	pushl  0xc(%ebp)
  800867:	ff 75 08             	pushl  0x8(%ebp)
  80086a:	e8 16 fc ff ff       	call   800485 <vprintfmt>
  80086f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800872:	90                   	nop
  800873:	c9                   	leave  
  800874:	c3                   	ret    

00800875 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800875:	55                   	push   %ebp
  800876:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800878:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087b:	8b 40 08             	mov    0x8(%eax),%eax
  80087e:	8d 50 01             	lea    0x1(%eax),%edx
  800881:	8b 45 0c             	mov    0xc(%ebp),%eax
  800884:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800887:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088a:	8b 10                	mov    (%eax),%edx
  80088c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088f:	8b 40 04             	mov    0x4(%eax),%eax
  800892:	39 c2                	cmp    %eax,%edx
  800894:	73 12                	jae    8008a8 <sprintputch+0x33>
		*b->buf++ = ch;
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	8d 48 01             	lea    0x1(%eax),%ecx
  80089e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a1:	89 0a                	mov    %ecx,(%edx)
  8008a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a6:	88 10                	mov    %dl,(%eax)
}
  8008a8:	90                   	nop
  8008a9:	5d                   	pop    %ebp
  8008aa:	c3                   	ret    

008008ab <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008ab:	55                   	push   %ebp
  8008ac:	89 e5                	mov    %esp,%ebp
  8008ae:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c0:	01 d0                	add    %edx,%eax
  8008c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d0:	74 06                	je     8008d8 <vsnprintf+0x2d>
  8008d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d6:	7f 07                	jg     8008df <vsnprintf+0x34>
		return -E_INVAL;
  8008d8:	b8 03 00 00 00       	mov    $0x3,%eax
  8008dd:	eb 20                	jmp    8008ff <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008df:	ff 75 14             	pushl  0x14(%ebp)
  8008e2:	ff 75 10             	pushl  0x10(%ebp)
  8008e5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008e8:	50                   	push   %eax
  8008e9:	68 75 08 80 00       	push   $0x800875
  8008ee:	e8 92 fb ff ff       	call   800485 <vprintfmt>
  8008f3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008f9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008ff:	c9                   	leave  
  800900:	c3                   	ret    

00800901 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800901:	55                   	push   %ebp
  800902:	89 e5                	mov    %esp,%ebp
  800904:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800907:	8d 45 10             	lea    0x10(%ebp),%eax
  80090a:	83 c0 04             	add    $0x4,%eax
  80090d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800910:	8b 45 10             	mov    0x10(%ebp),%eax
  800913:	ff 75 f4             	pushl  -0xc(%ebp)
  800916:	50                   	push   %eax
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	ff 75 08             	pushl  0x8(%ebp)
  80091d:	e8 89 ff ff ff       	call   8008ab <vsnprintf>
  800922:	83 c4 10             	add    $0x10,%esp
  800925:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800928:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80092b:	c9                   	leave  
  80092c:	c3                   	ret    

0080092d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80092d:	55                   	push   %ebp
  80092e:	89 e5                	mov    %esp,%ebp
  800930:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800933:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80093a:	eb 06                	jmp    800942 <strlen+0x15>
		n++;
  80093c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80093f:	ff 45 08             	incl   0x8(%ebp)
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	8a 00                	mov    (%eax),%al
  800947:	84 c0                	test   %al,%al
  800949:	75 f1                	jne    80093c <strlen+0xf>
		n++;
	return n;
  80094b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094e:	c9                   	leave  
  80094f:	c3                   	ret    

00800950 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800950:	55                   	push   %ebp
  800951:	89 e5                	mov    %esp,%ebp
  800953:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800956:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095d:	eb 09                	jmp    800968 <strnlen+0x18>
		n++;
  80095f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800962:	ff 45 08             	incl   0x8(%ebp)
  800965:	ff 4d 0c             	decl   0xc(%ebp)
  800968:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096c:	74 09                	je     800977 <strnlen+0x27>
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	8a 00                	mov    (%eax),%al
  800973:	84 c0                	test   %al,%al
  800975:	75 e8                	jne    80095f <strnlen+0xf>
		n++;
	return n;
  800977:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097a:	c9                   	leave  
  80097b:	c3                   	ret    

0080097c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80097c:	55                   	push   %ebp
  80097d:	89 e5                	mov    %esp,%ebp
  80097f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800988:	90                   	nop
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	8d 50 01             	lea    0x1(%eax),%edx
  80098f:	89 55 08             	mov    %edx,0x8(%ebp)
  800992:	8b 55 0c             	mov    0xc(%ebp),%edx
  800995:	8d 4a 01             	lea    0x1(%edx),%ecx
  800998:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80099b:	8a 12                	mov    (%edx),%dl
  80099d:	88 10                	mov    %dl,(%eax)
  80099f:	8a 00                	mov    (%eax),%al
  8009a1:	84 c0                	test   %al,%al
  8009a3:	75 e4                	jne    800989 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009a8:	c9                   	leave  
  8009a9:	c3                   	ret    

008009aa <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009aa:	55                   	push   %ebp
  8009ab:	89 e5                	mov    %esp,%ebp
  8009ad:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009bd:	eb 1f                	jmp    8009de <strncpy+0x34>
		*dst++ = *src;
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	8d 50 01             	lea    0x1(%eax),%edx
  8009c5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cb:	8a 12                	mov    (%edx),%dl
  8009cd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d2:	8a 00                	mov    (%eax),%al
  8009d4:	84 c0                	test   %al,%al
  8009d6:	74 03                	je     8009db <strncpy+0x31>
			src++;
  8009d8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009db:	ff 45 fc             	incl   -0x4(%ebp)
  8009de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009e1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009e4:	72 d9                	jb     8009bf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009e9:	c9                   	leave  
  8009ea:	c3                   	ret    

008009eb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009eb:	55                   	push   %ebp
  8009ec:	89 e5                	mov    %esp,%ebp
  8009ee:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009fb:	74 30                	je     800a2d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009fd:	eb 16                	jmp    800a15 <strlcpy+0x2a>
			*dst++ = *src++;
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	8d 50 01             	lea    0x1(%eax),%edx
  800a05:	89 55 08             	mov    %edx,0x8(%ebp)
  800a08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a0e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a11:	8a 12                	mov    (%edx),%dl
  800a13:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a15:	ff 4d 10             	decl   0x10(%ebp)
  800a18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a1c:	74 09                	je     800a27 <strlcpy+0x3c>
  800a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a21:	8a 00                	mov    (%eax),%al
  800a23:	84 c0                	test   %al,%al
  800a25:	75 d8                	jne    8009ff <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a2d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a33:	29 c2                	sub    %eax,%edx
  800a35:	89 d0                	mov    %edx,%eax
}
  800a37:	c9                   	leave  
  800a38:	c3                   	ret    

00800a39 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a39:	55                   	push   %ebp
  800a3a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a3c:	eb 06                	jmp    800a44 <strcmp+0xb>
		p++, q++;
  800a3e:	ff 45 08             	incl   0x8(%ebp)
  800a41:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a44:	8b 45 08             	mov    0x8(%ebp),%eax
  800a47:	8a 00                	mov    (%eax),%al
  800a49:	84 c0                	test   %al,%al
  800a4b:	74 0e                	je     800a5b <strcmp+0x22>
  800a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a50:	8a 10                	mov    (%eax),%dl
  800a52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a55:	8a 00                	mov    (%eax),%al
  800a57:	38 c2                	cmp    %al,%dl
  800a59:	74 e3                	je     800a3e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5e:	8a 00                	mov    (%eax),%al
  800a60:	0f b6 d0             	movzbl %al,%edx
  800a63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	0f b6 c0             	movzbl %al,%eax
  800a6b:	29 c2                	sub    %eax,%edx
  800a6d:	89 d0                	mov    %edx,%eax
}
  800a6f:	5d                   	pop    %ebp
  800a70:	c3                   	ret    

00800a71 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a71:	55                   	push   %ebp
  800a72:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a74:	eb 09                	jmp    800a7f <strncmp+0xe>
		n--, p++, q++;
  800a76:	ff 4d 10             	decl   0x10(%ebp)
  800a79:	ff 45 08             	incl   0x8(%ebp)
  800a7c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a83:	74 17                	je     800a9c <strncmp+0x2b>
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	8a 00                	mov    (%eax),%al
  800a8a:	84 c0                	test   %al,%al
  800a8c:	74 0e                	je     800a9c <strncmp+0x2b>
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	8a 10                	mov    (%eax),%dl
  800a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a96:	8a 00                	mov    (%eax),%al
  800a98:	38 c2                	cmp    %al,%dl
  800a9a:	74 da                	je     800a76 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa0:	75 07                	jne    800aa9 <strncmp+0x38>
		return 0;
  800aa2:	b8 00 00 00 00       	mov    $0x0,%eax
  800aa7:	eb 14                	jmp    800abd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	0f b6 d0             	movzbl %al,%edx
  800ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	0f b6 c0             	movzbl %al,%eax
  800ab9:	29 c2                	sub    %eax,%edx
  800abb:	89 d0                	mov    %edx,%eax
}
  800abd:	5d                   	pop    %ebp
  800abe:	c3                   	ret    

00800abf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800abf:	55                   	push   %ebp
  800ac0:	89 e5                	mov    %esp,%ebp
  800ac2:	83 ec 04             	sub    $0x4,%esp
  800ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800acb:	eb 12                	jmp    800adf <strchr+0x20>
		if (*s == c)
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	8a 00                	mov    (%eax),%al
  800ad2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad5:	75 05                	jne    800adc <strchr+0x1d>
			return (char *) s;
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	eb 11                	jmp    800aed <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800adc:	ff 45 08             	incl   0x8(%ebp)
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8a 00                	mov    (%eax),%al
  800ae4:	84 c0                	test   %al,%al
  800ae6:	75 e5                	jne    800acd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ae8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aed:	c9                   	leave  
  800aee:	c3                   	ret    

00800aef <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 04             	sub    $0x4,%esp
  800af5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800afb:	eb 0d                	jmp    800b0a <strfind+0x1b>
		if (*s == c)
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8a 00                	mov    (%eax),%al
  800b02:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b05:	74 0e                	je     800b15 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b07:	ff 45 08             	incl   0x8(%ebp)
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8a 00                	mov    (%eax),%al
  800b0f:	84 c0                	test   %al,%al
  800b11:	75 ea                	jne    800afd <strfind+0xe>
  800b13:	eb 01                	jmp    800b16 <strfind+0x27>
		if (*s == c)
			break;
  800b15:	90                   	nop
	return (char *) s;
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b19:	c9                   	leave  
  800b1a:	c3                   	ret    

00800b1b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b1b:	55                   	push   %ebp
  800b1c:	89 e5                	mov    %esp,%ebp
  800b1e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b27:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b2d:	eb 0e                	jmp    800b3d <memset+0x22>
		*p++ = c;
  800b2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b32:	8d 50 01             	lea    0x1(%eax),%edx
  800b35:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b38:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b3b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b3d:	ff 4d f8             	decl   -0x8(%ebp)
  800b40:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b44:	79 e9                	jns    800b2f <memset+0x14>
		*p++ = c;

	return v;
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b49:	c9                   	leave  
  800b4a:	c3                   	ret    

00800b4b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b4b:	55                   	push   %ebp
  800b4c:	89 e5                	mov    %esp,%ebp
  800b4e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b5d:	eb 16                	jmp    800b75 <memcpy+0x2a>
		*d++ = *s++;
  800b5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b62:	8d 50 01             	lea    0x1(%eax),%edx
  800b65:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b6b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b6e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b71:	8a 12                	mov    (%edx),%dl
  800b73:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b75:	8b 45 10             	mov    0x10(%ebp),%eax
  800b78:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b7b:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7e:	85 c0                	test   %eax,%eax
  800b80:	75 dd                	jne    800b5f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b85:	c9                   	leave  
  800b86:	c3                   	ret    

00800b87 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b87:	55                   	push   %ebp
  800b88:	89 e5                	mov    %esp,%ebp
  800b8a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b90:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b9f:	73 50                	jae    800bf1 <memmove+0x6a>
  800ba1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ba4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba7:	01 d0                	add    %edx,%eax
  800ba9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bac:	76 43                	jbe    800bf1 <memmove+0x6a>
		s += n;
  800bae:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bba:	eb 10                	jmp    800bcc <memmove+0x45>
			*--d = *--s;
  800bbc:	ff 4d f8             	decl   -0x8(%ebp)
  800bbf:	ff 4d fc             	decl   -0x4(%ebp)
  800bc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc5:	8a 10                	mov    (%eax),%dl
  800bc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bca:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd5:	85 c0                	test   %eax,%eax
  800bd7:	75 e3                	jne    800bbc <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bd9:	eb 23                	jmp    800bfe <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bdb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bde:	8d 50 01             	lea    0x1(%eax),%edx
  800be1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800be4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800be7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bea:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bed:	8a 12                	mov    (%edx),%dl
  800bef:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfa:	85 c0                	test   %eax,%eax
  800bfc:	75 dd                	jne    800bdb <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c01:	c9                   	leave  
  800c02:	c3                   	ret    

00800c03 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c03:	55                   	push   %ebp
  800c04:	89 e5                	mov    %esp,%ebp
  800c06:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c12:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c15:	eb 2a                	jmp    800c41 <memcmp+0x3e>
		if (*s1 != *s2)
  800c17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1a:	8a 10                	mov    (%eax),%dl
  800c1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1f:	8a 00                	mov    (%eax),%al
  800c21:	38 c2                	cmp    %al,%dl
  800c23:	74 16                	je     800c3b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c28:	8a 00                	mov    (%eax),%al
  800c2a:	0f b6 d0             	movzbl %al,%edx
  800c2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c30:	8a 00                	mov    (%eax),%al
  800c32:	0f b6 c0             	movzbl %al,%eax
  800c35:	29 c2                	sub    %eax,%edx
  800c37:	89 d0                	mov    %edx,%eax
  800c39:	eb 18                	jmp    800c53 <memcmp+0x50>
		s1++, s2++;
  800c3b:	ff 45 fc             	incl   -0x4(%ebp)
  800c3e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c47:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4a:	85 c0                	test   %eax,%eax
  800c4c:	75 c9                	jne    800c17 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c4e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c53:	c9                   	leave  
  800c54:	c3                   	ret    

00800c55 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c55:	55                   	push   %ebp
  800c56:	89 e5                	mov    %esp,%ebp
  800c58:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c5b:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c61:	01 d0                	add    %edx,%eax
  800c63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c66:	eb 15                	jmp    800c7d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	0f b6 d0             	movzbl %al,%edx
  800c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c73:	0f b6 c0             	movzbl %al,%eax
  800c76:	39 c2                	cmp    %eax,%edx
  800c78:	74 0d                	je     800c87 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c7a:	ff 45 08             	incl   0x8(%ebp)
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c83:	72 e3                	jb     800c68 <memfind+0x13>
  800c85:	eb 01                	jmp    800c88 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c87:	90                   	nop
	return (void *) s;
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8b:	c9                   	leave  
  800c8c:	c3                   	ret    

00800c8d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
  800c90:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c9a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca1:	eb 03                	jmp    800ca6 <strtol+0x19>
		s++;
  800ca3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	3c 20                	cmp    $0x20,%al
  800cad:	74 f4                	je     800ca3 <strtol+0x16>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	3c 09                	cmp    $0x9,%al
  800cb6:	74 eb                	je     800ca3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8a 00                	mov    (%eax),%al
  800cbd:	3c 2b                	cmp    $0x2b,%al
  800cbf:	75 05                	jne    800cc6 <strtol+0x39>
		s++;
  800cc1:	ff 45 08             	incl   0x8(%ebp)
  800cc4:	eb 13                	jmp    800cd9 <strtol+0x4c>
	else if (*s == '-')
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	3c 2d                	cmp    $0x2d,%al
  800ccd:	75 0a                	jne    800cd9 <strtol+0x4c>
		s++, neg = 1;
  800ccf:	ff 45 08             	incl   0x8(%ebp)
  800cd2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cdd:	74 06                	je     800ce5 <strtol+0x58>
  800cdf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ce3:	75 20                	jne    800d05 <strtol+0x78>
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	3c 30                	cmp    $0x30,%al
  800cec:	75 17                	jne    800d05 <strtol+0x78>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	40                   	inc    %eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	3c 78                	cmp    $0x78,%al
  800cf6:	75 0d                	jne    800d05 <strtol+0x78>
		s += 2, base = 16;
  800cf8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cfc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d03:	eb 28                	jmp    800d2d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d09:	75 15                	jne    800d20 <strtol+0x93>
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 00                	mov    (%eax),%al
  800d10:	3c 30                	cmp    $0x30,%al
  800d12:	75 0c                	jne    800d20 <strtol+0x93>
		s++, base = 8;
  800d14:	ff 45 08             	incl   0x8(%ebp)
  800d17:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d1e:	eb 0d                	jmp    800d2d <strtol+0xa0>
	else if (base == 0)
  800d20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d24:	75 07                	jne    800d2d <strtol+0xa0>
		base = 10;
  800d26:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	3c 2f                	cmp    $0x2f,%al
  800d34:	7e 19                	jle    800d4f <strtol+0xc2>
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	3c 39                	cmp    $0x39,%al
  800d3d:	7f 10                	jg     800d4f <strtol+0xc2>
			dig = *s - '0';
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	0f be c0             	movsbl %al,%eax
  800d47:	83 e8 30             	sub    $0x30,%eax
  800d4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d4d:	eb 42                	jmp    800d91 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 60                	cmp    $0x60,%al
  800d56:	7e 19                	jle    800d71 <strtol+0xe4>
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8a 00                	mov    (%eax),%al
  800d5d:	3c 7a                	cmp    $0x7a,%al
  800d5f:	7f 10                	jg     800d71 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	0f be c0             	movsbl %al,%eax
  800d69:	83 e8 57             	sub    $0x57,%eax
  800d6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d6f:	eb 20                	jmp    800d91 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	3c 40                	cmp    $0x40,%al
  800d78:	7e 39                	jle    800db3 <strtol+0x126>
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3c 5a                	cmp    $0x5a,%al
  800d81:	7f 30                	jg     800db3 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f be c0             	movsbl %al,%eax
  800d8b:	83 e8 37             	sub    $0x37,%eax
  800d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d94:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d97:	7d 19                	jge    800db2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d99:	ff 45 08             	incl   0x8(%ebp)
  800d9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9f:	0f af 45 10          	imul   0x10(%ebp),%eax
  800da3:	89 c2                	mov    %eax,%edx
  800da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da8:	01 d0                	add    %edx,%eax
  800daa:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dad:	e9 7b ff ff ff       	jmp    800d2d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800db2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800db3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db7:	74 08                	je     800dc1 <strtol+0x134>
		*endptr = (char *) s;
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8b 55 08             	mov    0x8(%ebp),%edx
  800dbf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dc1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dc5:	74 07                	je     800dce <strtol+0x141>
  800dc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dca:	f7 d8                	neg    %eax
  800dcc:	eb 03                	jmp    800dd1 <strtol+0x144>
  800dce:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dd1:	c9                   	leave  
  800dd2:	c3                   	ret    

00800dd3 <ltostr>:

void
ltostr(long value, char *str)
{
  800dd3:	55                   	push   %ebp
  800dd4:	89 e5                	mov    %esp,%ebp
  800dd6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dd9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800de0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800de7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800deb:	79 13                	jns    800e00 <ltostr+0x2d>
	{
		neg = 1;
  800ded:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800df4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dfa:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dfd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e08:	99                   	cltd   
  800e09:	f7 f9                	idiv   %ecx
  800e0b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e11:	8d 50 01             	lea    0x1(%eax),%edx
  800e14:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e17:	89 c2                	mov    %eax,%edx
  800e19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1c:	01 d0                	add    %edx,%eax
  800e1e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e21:	83 c2 30             	add    $0x30,%edx
  800e24:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e29:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e2e:	f7 e9                	imul   %ecx
  800e30:	c1 fa 02             	sar    $0x2,%edx
  800e33:	89 c8                	mov    %ecx,%eax
  800e35:	c1 f8 1f             	sar    $0x1f,%eax
  800e38:	29 c2                	sub    %eax,%edx
  800e3a:	89 d0                	mov    %edx,%eax
  800e3c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e42:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e47:	f7 e9                	imul   %ecx
  800e49:	c1 fa 02             	sar    $0x2,%edx
  800e4c:	89 c8                	mov    %ecx,%eax
  800e4e:	c1 f8 1f             	sar    $0x1f,%eax
  800e51:	29 c2                	sub    %eax,%edx
  800e53:	89 d0                	mov    %edx,%eax
  800e55:	c1 e0 02             	shl    $0x2,%eax
  800e58:	01 d0                	add    %edx,%eax
  800e5a:	01 c0                	add    %eax,%eax
  800e5c:	29 c1                	sub    %eax,%ecx
  800e5e:	89 ca                	mov    %ecx,%edx
  800e60:	85 d2                	test   %edx,%edx
  800e62:	75 9c                	jne    800e00 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e64:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6e:	48                   	dec    %eax
  800e6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e72:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e76:	74 3d                	je     800eb5 <ltostr+0xe2>
		start = 1 ;
  800e78:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e7f:	eb 34                	jmp    800eb5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e81:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	01 d0                	add    %edx,%eax
  800e89:	8a 00                	mov    (%eax),%al
  800e8b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e94:	01 c2                	add    %eax,%edx
  800e96:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	01 c8                	add    %ecx,%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ea2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea8:	01 c2                	add    %eax,%edx
  800eaa:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ead:	88 02                	mov    %al,(%edx)
		start++ ;
  800eaf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800eb2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eb8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ebb:	7c c4                	jl     800e81 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ebd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ec0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec3:	01 d0                	add    %edx,%eax
  800ec5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ec8:	90                   	nop
  800ec9:	c9                   	leave  
  800eca:	c3                   	ret    

00800ecb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ecb:	55                   	push   %ebp
  800ecc:	89 e5                	mov    %esp,%ebp
  800ece:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ed1:	ff 75 08             	pushl  0x8(%ebp)
  800ed4:	e8 54 fa ff ff       	call   80092d <strlen>
  800ed9:	83 c4 04             	add    $0x4,%esp
  800edc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800edf:	ff 75 0c             	pushl  0xc(%ebp)
  800ee2:	e8 46 fa ff ff       	call   80092d <strlen>
  800ee7:	83 c4 04             	add    $0x4,%esp
  800eea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800eed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ef4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800efb:	eb 17                	jmp    800f14 <strcconcat+0x49>
		final[s] = str1[s] ;
  800efd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f00:	8b 45 10             	mov    0x10(%ebp),%eax
  800f03:	01 c2                	add    %eax,%edx
  800f05:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	01 c8                	add    %ecx,%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f11:	ff 45 fc             	incl   -0x4(%ebp)
  800f14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f17:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f1a:	7c e1                	jl     800efd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f1c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f2a:	eb 1f                	jmp    800f4b <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2f:	8d 50 01             	lea    0x1(%eax),%edx
  800f32:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f35:	89 c2                	mov    %eax,%edx
  800f37:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3a:	01 c2                	add    %eax,%edx
  800f3c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f42:	01 c8                	add    %ecx,%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f48:	ff 45 f8             	incl   -0x8(%ebp)
  800f4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f51:	7c d9                	jl     800f2c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f53:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f56:	8b 45 10             	mov    0x10(%ebp),%eax
  800f59:	01 d0                	add    %edx,%eax
  800f5b:	c6 00 00             	movb   $0x0,(%eax)
}
  800f5e:	90                   	nop
  800f5f:	c9                   	leave  
  800f60:	c3                   	ret    

00800f61 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f61:	55                   	push   %ebp
  800f62:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f64:	8b 45 14             	mov    0x14(%ebp),%eax
  800f67:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f70:	8b 00                	mov    (%eax),%eax
  800f72:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f79:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7c:	01 d0                	add    %edx,%eax
  800f7e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f84:	eb 0c                	jmp    800f92 <strsplit+0x31>
			*string++ = 0;
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8d 50 01             	lea    0x1(%eax),%edx
  800f8c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f8f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	84 c0                	test   %al,%al
  800f99:	74 18                	je     800fb3 <strsplit+0x52>
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8a 00                	mov    (%eax),%al
  800fa0:	0f be c0             	movsbl %al,%eax
  800fa3:	50                   	push   %eax
  800fa4:	ff 75 0c             	pushl  0xc(%ebp)
  800fa7:	e8 13 fb ff ff       	call   800abf <strchr>
  800fac:	83 c4 08             	add    $0x8,%esp
  800faf:	85 c0                	test   %eax,%eax
  800fb1:	75 d3                	jne    800f86 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	84 c0                	test   %al,%al
  800fba:	74 5a                	je     801016 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800fbc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbf:	8b 00                	mov    (%eax),%eax
  800fc1:	83 f8 0f             	cmp    $0xf,%eax
  800fc4:	75 07                	jne    800fcd <strsplit+0x6c>
		{
			return 0;
  800fc6:	b8 00 00 00 00       	mov    $0x0,%eax
  800fcb:	eb 66                	jmp    801033 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd0:	8b 00                	mov    (%eax),%eax
  800fd2:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd5:	8b 55 14             	mov    0x14(%ebp),%edx
  800fd8:	89 0a                	mov    %ecx,(%edx)
  800fda:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe4:	01 c2                	add    %eax,%edx
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800feb:	eb 03                	jmp    800ff0 <strsplit+0x8f>
			string++;
  800fed:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	84 c0                	test   %al,%al
  800ff7:	74 8b                	je     800f84 <strsplit+0x23>
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	0f be c0             	movsbl %al,%eax
  801001:	50                   	push   %eax
  801002:	ff 75 0c             	pushl  0xc(%ebp)
  801005:	e8 b5 fa ff ff       	call   800abf <strchr>
  80100a:	83 c4 08             	add    $0x8,%esp
  80100d:	85 c0                	test   %eax,%eax
  80100f:	74 dc                	je     800fed <strsplit+0x8c>
			string++;
	}
  801011:	e9 6e ff ff ff       	jmp    800f84 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801016:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801017:	8b 45 14             	mov    0x14(%ebp),%eax
  80101a:	8b 00                	mov    (%eax),%eax
  80101c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	01 d0                	add    %edx,%eax
  801028:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80102e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	57                   	push   %edi
  801039:	56                   	push   %esi
  80103a:	53                   	push   %ebx
  80103b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8b 55 0c             	mov    0xc(%ebp),%edx
  801044:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801047:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80104a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80104d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801050:	cd 30                	int    $0x30
  801052:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801055:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801058:	83 c4 10             	add    $0x10,%esp
  80105b:	5b                   	pop    %ebx
  80105c:	5e                   	pop    %esi
  80105d:	5f                   	pop    %edi
  80105e:	5d                   	pop    %ebp
  80105f:	c3                   	ret    

00801060 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801060:	55                   	push   %ebp
  801061:	89 e5                	mov    %esp,%ebp
  801063:	83 ec 04             	sub    $0x4,%esp
  801066:	8b 45 10             	mov    0x10(%ebp),%eax
  801069:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80106c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	52                   	push   %edx
  801078:	ff 75 0c             	pushl  0xc(%ebp)
  80107b:	50                   	push   %eax
  80107c:	6a 00                	push   $0x0
  80107e:	e8 b2 ff ff ff       	call   801035 <syscall>
  801083:	83 c4 18             	add    $0x18,%esp
}
  801086:	90                   	nop
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <sys_cgetc>:

int
sys_cgetc(void)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80108c:	6a 00                	push   $0x0
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 00                	push   $0x0
  801096:	6a 01                	push   $0x1
  801098:	e8 98 ff ff ff       	call   801035 <syscall>
  80109d:	83 c4 18             	add    $0x18,%esp
}
  8010a0:	c9                   	leave  
  8010a1:	c3                   	ret    

008010a2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010a2:	55                   	push   %ebp
  8010a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	50                   	push   %eax
  8010b1:	6a 05                	push   $0x5
  8010b3:	e8 7d ff ff ff       	call   801035 <syscall>
  8010b8:	83 c4 18             	add    $0x18,%esp
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 02                	push   $0x2
  8010cc:	e8 64 ff ff ff       	call   801035 <syscall>
  8010d1:	83 c4 18             	add    $0x18,%esp
}
  8010d4:	c9                   	leave  
  8010d5:	c3                   	ret    

008010d6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010d6:	55                   	push   %ebp
  8010d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 03                	push   $0x3
  8010e5:	e8 4b ff ff ff       	call   801035 <syscall>
  8010ea:	83 c4 18             	add    $0x18,%esp
}
  8010ed:	c9                   	leave  
  8010ee:	c3                   	ret    

008010ef <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 00                	push   $0x0
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 04                	push   $0x4
  8010fe:	e8 32 ff ff ff       	call   801035 <syscall>
  801103:	83 c4 18             	add    $0x18,%esp
}
  801106:	c9                   	leave  
  801107:	c3                   	ret    

00801108 <sys_env_exit>:


void sys_env_exit(void)
{
  801108:	55                   	push   %ebp
  801109:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80110b:	6a 00                	push   $0x0
  80110d:	6a 00                	push   $0x0
  80110f:	6a 00                	push   $0x0
  801111:	6a 00                	push   $0x0
  801113:	6a 00                	push   $0x0
  801115:	6a 06                	push   $0x6
  801117:	e8 19 ff ff ff       	call   801035 <syscall>
  80111c:	83 c4 18             	add    $0x18,%esp
}
  80111f:	90                   	nop
  801120:	c9                   	leave  
  801121:	c3                   	ret    

00801122 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801122:	55                   	push   %ebp
  801123:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801125:	8b 55 0c             	mov    0xc(%ebp),%edx
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	6a 00                	push   $0x0
  80112d:	6a 00                	push   $0x0
  80112f:	6a 00                	push   $0x0
  801131:	52                   	push   %edx
  801132:	50                   	push   %eax
  801133:	6a 07                	push   $0x7
  801135:	e8 fb fe ff ff       	call   801035 <syscall>
  80113a:	83 c4 18             	add    $0x18,%esp
}
  80113d:	c9                   	leave  
  80113e:	c3                   	ret    

0080113f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80113f:	55                   	push   %ebp
  801140:	89 e5                	mov    %esp,%ebp
  801142:	56                   	push   %esi
  801143:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801144:	8b 75 18             	mov    0x18(%ebp),%esi
  801147:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80114a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80114d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	56                   	push   %esi
  801154:	53                   	push   %ebx
  801155:	51                   	push   %ecx
  801156:	52                   	push   %edx
  801157:	50                   	push   %eax
  801158:	6a 08                	push   $0x8
  80115a:	e8 d6 fe ff ff       	call   801035 <syscall>
  80115f:	83 c4 18             	add    $0x18,%esp
}
  801162:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801165:	5b                   	pop    %ebx
  801166:	5e                   	pop    %esi
  801167:	5d                   	pop    %ebp
  801168:	c3                   	ret    

00801169 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801169:	55                   	push   %ebp
  80116a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80116c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	52                   	push   %edx
  801179:	50                   	push   %eax
  80117a:	6a 09                	push   $0x9
  80117c:	e8 b4 fe ff ff       	call   801035 <syscall>
  801181:	83 c4 18             	add    $0x18,%esp
}
  801184:	c9                   	leave  
  801185:	c3                   	ret    

00801186 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801186:	55                   	push   %ebp
  801187:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801189:	6a 00                	push   $0x0
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	ff 75 0c             	pushl  0xc(%ebp)
  801192:	ff 75 08             	pushl  0x8(%ebp)
  801195:	6a 0a                	push   $0xa
  801197:	e8 99 fe ff ff       	call   801035 <syscall>
  80119c:	83 c4 18             	add    $0x18,%esp
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 0b                	push   $0xb
  8011b0:	e8 80 fe ff ff       	call   801035 <syscall>
  8011b5:	83 c4 18             	add    $0x18,%esp
}
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 0c                	push   $0xc
  8011c9:	e8 67 fe ff ff       	call   801035 <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 0d                	push   $0xd
  8011e2:	e8 4e fe ff ff       	call   801035 <syscall>
  8011e7:	83 c4 18             	add    $0x18,%esp
}
  8011ea:	c9                   	leave  
  8011eb:	c3                   	ret    

008011ec <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011ec:	55                   	push   %ebp
  8011ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	ff 75 0c             	pushl  0xc(%ebp)
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	6a 11                	push   $0x11
  8011fd:	e8 33 fe ff ff       	call   801035 <syscall>
  801202:	83 c4 18             	add    $0x18,%esp
	return;
  801205:	90                   	nop
}
  801206:	c9                   	leave  
  801207:	c3                   	ret    

00801208 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801208:	55                   	push   %ebp
  801209:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	ff 75 0c             	pushl  0xc(%ebp)
  801214:	ff 75 08             	pushl  0x8(%ebp)
  801217:	6a 12                	push   $0x12
  801219:	e8 17 fe ff ff       	call   801035 <syscall>
  80121e:	83 c4 18             	add    $0x18,%esp
	return ;
  801221:	90                   	nop
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 0e                	push   $0xe
  801233:	e8 fd fd ff ff       	call   801035 <syscall>
  801238:	83 c4 18             	add    $0x18,%esp
}
  80123b:	c9                   	leave  
  80123c:	c3                   	ret    

0080123d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80123d:	55                   	push   %ebp
  80123e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	ff 75 08             	pushl  0x8(%ebp)
  80124b:	6a 0f                	push   $0xf
  80124d:	e8 e3 fd ff ff       	call   801035 <syscall>
  801252:	83 c4 18             	add    $0x18,%esp
}
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	6a 10                	push   $0x10
  801266:	e8 ca fd ff ff       	call   801035 <syscall>
  80126b:	83 c4 18             	add    $0x18,%esp
}
  80126e:	90                   	nop
  80126f:	c9                   	leave  
  801270:	c3                   	ret    

00801271 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801271:	55                   	push   %ebp
  801272:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 14                	push   $0x14
  801280:	e8 b0 fd ff ff       	call   801035 <syscall>
  801285:	83 c4 18             	add    $0x18,%esp
}
  801288:	90                   	nop
  801289:	c9                   	leave  
  80128a:	c3                   	ret    

0080128b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80128b:	55                   	push   %ebp
  80128c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 00                	push   $0x0
  801296:	6a 00                	push   $0x0
  801298:	6a 15                	push   $0x15
  80129a:	e8 96 fd ff ff       	call   801035 <syscall>
  80129f:	83 c4 18             	add    $0x18,%esp
}
  8012a2:	90                   	nop
  8012a3:	c9                   	leave  
  8012a4:	c3                   	ret    

008012a5 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012a5:	55                   	push   %ebp
  8012a6:	89 e5                	mov    %esp,%ebp
  8012a8:	83 ec 04             	sub    $0x4,%esp
  8012ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012b1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	50                   	push   %eax
  8012be:	6a 16                	push   $0x16
  8012c0:	e8 70 fd ff ff       	call   801035 <syscall>
  8012c5:	83 c4 18             	add    $0x18,%esp
}
  8012c8:	90                   	nop
  8012c9:	c9                   	leave  
  8012ca:	c3                   	ret    

008012cb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 17                	push   $0x17
  8012da:	e8 56 fd ff ff       	call   801035 <syscall>
  8012df:	83 c4 18             	add    $0x18,%esp
}
  8012e2:	90                   	nop
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	ff 75 0c             	pushl  0xc(%ebp)
  8012f4:	50                   	push   %eax
  8012f5:	6a 18                	push   $0x18
  8012f7:	e8 39 fd ff ff       	call   801035 <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	c9                   	leave  
  801300:	c3                   	ret    

00801301 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801304:	8b 55 0c             	mov    0xc(%ebp),%edx
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	52                   	push   %edx
  801311:	50                   	push   %eax
  801312:	6a 1b                	push   $0x1b
  801314:	e8 1c fd ff ff       	call   801035 <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801321:	8b 55 0c             	mov    0xc(%ebp),%edx
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	52                   	push   %edx
  80132e:	50                   	push   %eax
  80132f:	6a 19                	push   $0x19
  801331:	e8 ff fc ff ff       	call   801035 <syscall>
  801336:	83 c4 18             	add    $0x18,%esp
}
  801339:	90                   	nop
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80133f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	52                   	push   %edx
  80134c:	50                   	push   %eax
  80134d:	6a 1a                	push   $0x1a
  80134f:	e8 e1 fc ff ff       	call   801035 <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	90                   	nop
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
  80135d:	83 ec 04             	sub    $0x4,%esp
  801360:	8b 45 10             	mov    0x10(%ebp),%eax
  801363:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801366:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801369:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	6a 00                	push   $0x0
  801372:	51                   	push   %ecx
  801373:	52                   	push   %edx
  801374:	ff 75 0c             	pushl  0xc(%ebp)
  801377:	50                   	push   %eax
  801378:	6a 1c                	push   $0x1c
  80137a:	e8 b6 fc ff ff       	call   801035 <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	52                   	push   %edx
  801394:	50                   	push   %eax
  801395:	6a 1d                	push   $0x1d
  801397:	e8 99 fc ff ff       	call   801035 <syscall>
  80139c:	83 c4 18             	add    $0x18,%esp
}
  80139f:	c9                   	leave  
  8013a0:	c3                   	ret    

008013a1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013a1:	55                   	push   %ebp
  8013a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	51                   	push   %ecx
  8013b2:	52                   	push   %edx
  8013b3:	50                   	push   %eax
  8013b4:	6a 1e                	push   $0x1e
  8013b6:	e8 7a fc ff ff       	call   801035 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	52                   	push   %edx
  8013d0:	50                   	push   %eax
  8013d1:	6a 1f                	push   $0x1f
  8013d3:	e8 5d fc ff ff       	call   801035 <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 20                	push   $0x20
  8013ec:	e8 44 fc ff ff       	call   801035 <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	c9                   	leave  
  8013f5:	c3                   	ret    

008013f6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013f6:	55                   	push   %ebp
  8013f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	ff 75 10             	pushl  0x10(%ebp)
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	50                   	push   %eax
  801407:	6a 21                	push   $0x21
  801409:	e8 27 fc ff ff       	call   801035 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	50                   	push   %eax
  801422:	6a 22                	push   $0x22
  801424:	e8 0c fc ff ff       	call   801035 <syscall>
  801429:	83 c4 18             	add    $0x18,%esp
}
  80142c:	90                   	nop
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	50                   	push   %eax
  80143e:	6a 23                	push   $0x23
  801440:	e8 f0 fb ff ff       	call   801035 <syscall>
  801445:	83 c4 18             	add    $0x18,%esp
}
  801448:	90                   	nop
  801449:	c9                   	leave  
  80144a:	c3                   	ret    

0080144b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80144b:	55                   	push   %ebp
  80144c:	89 e5                	mov    %esp,%ebp
  80144e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801451:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801454:	8d 50 04             	lea    0x4(%eax),%edx
  801457:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	52                   	push   %edx
  801461:	50                   	push   %eax
  801462:	6a 24                	push   $0x24
  801464:	e8 cc fb ff ff       	call   801035 <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
	return result;
  80146c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80146f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801472:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801475:	89 01                	mov    %eax,(%ecx)
  801477:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	c9                   	leave  
  80147e:	c2 04 00             	ret    $0x4

00801481 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	ff 75 10             	pushl  0x10(%ebp)
  80148b:	ff 75 0c             	pushl  0xc(%ebp)
  80148e:	ff 75 08             	pushl  0x8(%ebp)
  801491:	6a 13                	push   $0x13
  801493:	e8 9d fb ff ff       	call   801035 <syscall>
  801498:	83 c4 18             	add    $0x18,%esp
	return ;
  80149b:	90                   	nop
}
  80149c:	c9                   	leave  
  80149d:	c3                   	ret    

0080149e <sys_rcr2>:
uint32 sys_rcr2()
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 25                	push   $0x25
  8014ad:	e8 83 fb ff ff       	call   801035 <syscall>
  8014b2:	83 c4 18             	add    $0x18,%esp
}
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014c3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	50                   	push   %eax
  8014d0:	6a 26                	push   $0x26
  8014d2:	e8 5e fb ff ff       	call   801035 <syscall>
  8014d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014da:	90                   	nop
}
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <rsttst>:
void rsttst()
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 28                	push   $0x28
  8014ec:	e8 44 fb ff ff       	call   801035 <syscall>
  8014f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f4:	90                   	nop
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	83 ec 04             	sub    $0x4,%esp
  8014fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801500:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801503:	8b 55 18             	mov    0x18(%ebp),%edx
  801506:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80150a:	52                   	push   %edx
  80150b:	50                   	push   %eax
  80150c:	ff 75 10             	pushl  0x10(%ebp)
  80150f:	ff 75 0c             	pushl  0xc(%ebp)
  801512:	ff 75 08             	pushl  0x8(%ebp)
  801515:	6a 27                	push   $0x27
  801517:	e8 19 fb ff ff       	call   801035 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
	return ;
  80151f:	90                   	nop
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <chktst>:
void chktst(uint32 n)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	ff 75 08             	pushl  0x8(%ebp)
  801530:	6a 29                	push   $0x29
  801532:	e8 fe fa ff ff       	call   801035 <syscall>
  801537:	83 c4 18             	add    $0x18,%esp
	return ;
  80153a:	90                   	nop
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <inctst>:

void inctst()
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 2a                	push   $0x2a
  80154c:	e8 e4 fa ff ff       	call   801035 <syscall>
  801551:	83 c4 18             	add    $0x18,%esp
	return ;
  801554:	90                   	nop
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <gettst>:
uint32 gettst()
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 2b                	push   $0x2b
  801566:	e8 ca fa ff ff       	call   801035 <syscall>
  80156b:	83 c4 18             	add    $0x18,%esp
}
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
  801573:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 2c                	push   $0x2c
  801582:	e8 ae fa ff ff       	call   801035 <syscall>
  801587:	83 c4 18             	add    $0x18,%esp
  80158a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80158d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801591:	75 07                	jne    80159a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801593:	b8 01 00 00 00       	mov    $0x1,%eax
  801598:	eb 05                	jmp    80159f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80159a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 2c                	push   $0x2c
  8015b3:	e8 7d fa ff ff       	call   801035 <syscall>
  8015b8:	83 c4 18             	add    $0x18,%esp
  8015bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015be:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015c2:	75 07                	jne    8015cb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015c4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c9:	eb 05                	jmp    8015d0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
  8015d5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 2c                	push   $0x2c
  8015e4:	e8 4c fa ff ff       	call   801035 <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
  8015ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015ef:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015f3:	75 07                	jne    8015fc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015fa:	eb 05                	jmp    801601 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
  801606:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 2c                	push   $0x2c
  801615:	e8 1b fa ff ff       	call   801035 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
  80161d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801620:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801624:	75 07                	jne    80162d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801626:	b8 01 00 00 00       	mov    $0x1,%eax
  80162b:	eb 05                	jmp    801632 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80162d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	ff 75 08             	pushl  0x8(%ebp)
  801642:	6a 2d                	push   $0x2d
  801644:	e8 ec f9 ff ff       	call   801035 <syscall>
  801649:	83 c4 18             	add    $0x18,%esp
	return ;
  80164c:	90                   	nop
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
  801652:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801655:	8b 55 08             	mov    0x8(%ebp),%edx
  801658:	89 d0                	mov    %edx,%eax
  80165a:	c1 e0 02             	shl    $0x2,%eax
  80165d:	01 d0                	add    %edx,%eax
  80165f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801666:	01 d0                	add    %edx,%eax
  801668:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80166f:	01 d0                	add    %edx,%eax
  801671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801678:	01 d0                	add    %edx,%eax
  80167a:	c1 e0 04             	shl    $0x4,%eax
  80167d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801680:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801687:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80168a:	83 ec 0c             	sub    $0xc,%esp
  80168d:	50                   	push   %eax
  80168e:	e8 b8 fd ff ff       	call   80144b <sys_get_virtual_time>
  801693:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801696:	eb 41                	jmp    8016d9 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801698:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80169b:	83 ec 0c             	sub    $0xc,%esp
  80169e:	50                   	push   %eax
  80169f:	e8 a7 fd ff ff       	call   80144b <sys_get_virtual_time>
  8016a4:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8016a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016ad:	29 c2                	sub    %eax,%edx
  8016af:	89 d0                	mov    %edx,%eax
  8016b1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8016b4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016ba:	89 d1                	mov    %edx,%ecx
  8016bc:	29 c1                	sub    %eax,%ecx
  8016be:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8016c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016c4:	39 c2                	cmp    %eax,%edx
  8016c6:	0f 97 c0             	seta   %al
  8016c9:	0f b6 c0             	movzbl %al,%eax
  8016cc:	29 c1                	sub    %eax,%ecx
  8016ce:	89 c8                	mov    %ecx,%eax
  8016d0:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016d3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016df:	72 b7                	jb     801698 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  8016e1:	90                   	nop
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
  8016e7:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8016ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8016f1:	eb 03                	jmp    8016f6 <busy_wait+0x12>
  8016f3:	ff 45 fc             	incl   -0x4(%ebp)
  8016f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f9:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016fc:	72 f5                	jb     8016f3 <busy_wait+0xf>
	return i;
  8016fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    
  801703:	90                   	nop

00801704 <__udivdi3>:
  801704:	55                   	push   %ebp
  801705:	57                   	push   %edi
  801706:	56                   	push   %esi
  801707:	53                   	push   %ebx
  801708:	83 ec 1c             	sub    $0x1c,%esp
  80170b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80170f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801713:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801717:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80171b:	89 ca                	mov    %ecx,%edx
  80171d:	89 f8                	mov    %edi,%eax
  80171f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801723:	85 f6                	test   %esi,%esi
  801725:	75 2d                	jne    801754 <__udivdi3+0x50>
  801727:	39 cf                	cmp    %ecx,%edi
  801729:	77 65                	ja     801790 <__udivdi3+0x8c>
  80172b:	89 fd                	mov    %edi,%ebp
  80172d:	85 ff                	test   %edi,%edi
  80172f:	75 0b                	jne    80173c <__udivdi3+0x38>
  801731:	b8 01 00 00 00       	mov    $0x1,%eax
  801736:	31 d2                	xor    %edx,%edx
  801738:	f7 f7                	div    %edi
  80173a:	89 c5                	mov    %eax,%ebp
  80173c:	31 d2                	xor    %edx,%edx
  80173e:	89 c8                	mov    %ecx,%eax
  801740:	f7 f5                	div    %ebp
  801742:	89 c1                	mov    %eax,%ecx
  801744:	89 d8                	mov    %ebx,%eax
  801746:	f7 f5                	div    %ebp
  801748:	89 cf                	mov    %ecx,%edi
  80174a:	89 fa                	mov    %edi,%edx
  80174c:	83 c4 1c             	add    $0x1c,%esp
  80174f:	5b                   	pop    %ebx
  801750:	5e                   	pop    %esi
  801751:	5f                   	pop    %edi
  801752:	5d                   	pop    %ebp
  801753:	c3                   	ret    
  801754:	39 ce                	cmp    %ecx,%esi
  801756:	77 28                	ja     801780 <__udivdi3+0x7c>
  801758:	0f bd fe             	bsr    %esi,%edi
  80175b:	83 f7 1f             	xor    $0x1f,%edi
  80175e:	75 40                	jne    8017a0 <__udivdi3+0x9c>
  801760:	39 ce                	cmp    %ecx,%esi
  801762:	72 0a                	jb     80176e <__udivdi3+0x6a>
  801764:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801768:	0f 87 9e 00 00 00    	ja     80180c <__udivdi3+0x108>
  80176e:	b8 01 00 00 00       	mov    $0x1,%eax
  801773:	89 fa                	mov    %edi,%edx
  801775:	83 c4 1c             	add    $0x1c,%esp
  801778:	5b                   	pop    %ebx
  801779:	5e                   	pop    %esi
  80177a:	5f                   	pop    %edi
  80177b:	5d                   	pop    %ebp
  80177c:	c3                   	ret    
  80177d:	8d 76 00             	lea    0x0(%esi),%esi
  801780:	31 ff                	xor    %edi,%edi
  801782:	31 c0                	xor    %eax,%eax
  801784:	89 fa                	mov    %edi,%edx
  801786:	83 c4 1c             	add    $0x1c,%esp
  801789:	5b                   	pop    %ebx
  80178a:	5e                   	pop    %esi
  80178b:	5f                   	pop    %edi
  80178c:	5d                   	pop    %ebp
  80178d:	c3                   	ret    
  80178e:	66 90                	xchg   %ax,%ax
  801790:	89 d8                	mov    %ebx,%eax
  801792:	f7 f7                	div    %edi
  801794:	31 ff                	xor    %edi,%edi
  801796:	89 fa                	mov    %edi,%edx
  801798:	83 c4 1c             	add    $0x1c,%esp
  80179b:	5b                   	pop    %ebx
  80179c:	5e                   	pop    %esi
  80179d:	5f                   	pop    %edi
  80179e:	5d                   	pop    %ebp
  80179f:	c3                   	ret    
  8017a0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017a5:	89 eb                	mov    %ebp,%ebx
  8017a7:	29 fb                	sub    %edi,%ebx
  8017a9:	89 f9                	mov    %edi,%ecx
  8017ab:	d3 e6                	shl    %cl,%esi
  8017ad:	89 c5                	mov    %eax,%ebp
  8017af:	88 d9                	mov    %bl,%cl
  8017b1:	d3 ed                	shr    %cl,%ebp
  8017b3:	89 e9                	mov    %ebp,%ecx
  8017b5:	09 f1                	or     %esi,%ecx
  8017b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017bb:	89 f9                	mov    %edi,%ecx
  8017bd:	d3 e0                	shl    %cl,%eax
  8017bf:	89 c5                	mov    %eax,%ebp
  8017c1:	89 d6                	mov    %edx,%esi
  8017c3:	88 d9                	mov    %bl,%cl
  8017c5:	d3 ee                	shr    %cl,%esi
  8017c7:	89 f9                	mov    %edi,%ecx
  8017c9:	d3 e2                	shl    %cl,%edx
  8017cb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017cf:	88 d9                	mov    %bl,%cl
  8017d1:	d3 e8                	shr    %cl,%eax
  8017d3:	09 c2                	or     %eax,%edx
  8017d5:	89 d0                	mov    %edx,%eax
  8017d7:	89 f2                	mov    %esi,%edx
  8017d9:	f7 74 24 0c          	divl   0xc(%esp)
  8017dd:	89 d6                	mov    %edx,%esi
  8017df:	89 c3                	mov    %eax,%ebx
  8017e1:	f7 e5                	mul    %ebp
  8017e3:	39 d6                	cmp    %edx,%esi
  8017e5:	72 19                	jb     801800 <__udivdi3+0xfc>
  8017e7:	74 0b                	je     8017f4 <__udivdi3+0xf0>
  8017e9:	89 d8                	mov    %ebx,%eax
  8017eb:	31 ff                	xor    %edi,%edi
  8017ed:	e9 58 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  8017f2:	66 90                	xchg   %ax,%ax
  8017f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017f8:	89 f9                	mov    %edi,%ecx
  8017fa:	d3 e2                	shl    %cl,%edx
  8017fc:	39 c2                	cmp    %eax,%edx
  8017fe:	73 e9                	jae    8017e9 <__udivdi3+0xe5>
  801800:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801803:	31 ff                	xor    %edi,%edi
  801805:	e9 40 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  80180a:	66 90                	xchg   %ax,%ax
  80180c:	31 c0                	xor    %eax,%eax
  80180e:	e9 37 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  801813:	90                   	nop

00801814 <__umoddi3>:
  801814:	55                   	push   %ebp
  801815:	57                   	push   %edi
  801816:	56                   	push   %esi
  801817:	53                   	push   %ebx
  801818:	83 ec 1c             	sub    $0x1c,%esp
  80181b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80181f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801823:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801827:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80182b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80182f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801833:	89 f3                	mov    %esi,%ebx
  801835:	89 fa                	mov    %edi,%edx
  801837:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80183b:	89 34 24             	mov    %esi,(%esp)
  80183e:	85 c0                	test   %eax,%eax
  801840:	75 1a                	jne    80185c <__umoddi3+0x48>
  801842:	39 f7                	cmp    %esi,%edi
  801844:	0f 86 a2 00 00 00    	jbe    8018ec <__umoddi3+0xd8>
  80184a:	89 c8                	mov    %ecx,%eax
  80184c:	89 f2                	mov    %esi,%edx
  80184e:	f7 f7                	div    %edi
  801850:	89 d0                	mov    %edx,%eax
  801852:	31 d2                	xor    %edx,%edx
  801854:	83 c4 1c             	add    $0x1c,%esp
  801857:	5b                   	pop    %ebx
  801858:	5e                   	pop    %esi
  801859:	5f                   	pop    %edi
  80185a:	5d                   	pop    %ebp
  80185b:	c3                   	ret    
  80185c:	39 f0                	cmp    %esi,%eax
  80185e:	0f 87 ac 00 00 00    	ja     801910 <__umoddi3+0xfc>
  801864:	0f bd e8             	bsr    %eax,%ebp
  801867:	83 f5 1f             	xor    $0x1f,%ebp
  80186a:	0f 84 ac 00 00 00    	je     80191c <__umoddi3+0x108>
  801870:	bf 20 00 00 00       	mov    $0x20,%edi
  801875:	29 ef                	sub    %ebp,%edi
  801877:	89 fe                	mov    %edi,%esi
  801879:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80187d:	89 e9                	mov    %ebp,%ecx
  80187f:	d3 e0                	shl    %cl,%eax
  801881:	89 d7                	mov    %edx,%edi
  801883:	89 f1                	mov    %esi,%ecx
  801885:	d3 ef                	shr    %cl,%edi
  801887:	09 c7                	or     %eax,%edi
  801889:	89 e9                	mov    %ebp,%ecx
  80188b:	d3 e2                	shl    %cl,%edx
  80188d:	89 14 24             	mov    %edx,(%esp)
  801890:	89 d8                	mov    %ebx,%eax
  801892:	d3 e0                	shl    %cl,%eax
  801894:	89 c2                	mov    %eax,%edx
  801896:	8b 44 24 08          	mov    0x8(%esp),%eax
  80189a:	d3 e0                	shl    %cl,%eax
  80189c:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018a0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018a4:	89 f1                	mov    %esi,%ecx
  8018a6:	d3 e8                	shr    %cl,%eax
  8018a8:	09 d0                	or     %edx,%eax
  8018aa:	d3 eb                	shr    %cl,%ebx
  8018ac:	89 da                	mov    %ebx,%edx
  8018ae:	f7 f7                	div    %edi
  8018b0:	89 d3                	mov    %edx,%ebx
  8018b2:	f7 24 24             	mull   (%esp)
  8018b5:	89 c6                	mov    %eax,%esi
  8018b7:	89 d1                	mov    %edx,%ecx
  8018b9:	39 d3                	cmp    %edx,%ebx
  8018bb:	0f 82 87 00 00 00    	jb     801948 <__umoddi3+0x134>
  8018c1:	0f 84 91 00 00 00    	je     801958 <__umoddi3+0x144>
  8018c7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018cb:	29 f2                	sub    %esi,%edx
  8018cd:	19 cb                	sbb    %ecx,%ebx
  8018cf:	89 d8                	mov    %ebx,%eax
  8018d1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018d5:	d3 e0                	shl    %cl,%eax
  8018d7:	89 e9                	mov    %ebp,%ecx
  8018d9:	d3 ea                	shr    %cl,%edx
  8018db:	09 d0                	or     %edx,%eax
  8018dd:	89 e9                	mov    %ebp,%ecx
  8018df:	d3 eb                	shr    %cl,%ebx
  8018e1:	89 da                	mov    %ebx,%edx
  8018e3:	83 c4 1c             	add    $0x1c,%esp
  8018e6:	5b                   	pop    %ebx
  8018e7:	5e                   	pop    %esi
  8018e8:	5f                   	pop    %edi
  8018e9:	5d                   	pop    %ebp
  8018ea:	c3                   	ret    
  8018eb:	90                   	nop
  8018ec:	89 fd                	mov    %edi,%ebp
  8018ee:	85 ff                	test   %edi,%edi
  8018f0:	75 0b                	jne    8018fd <__umoddi3+0xe9>
  8018f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f7:	31 d2                	xor    %edx,%edx
  8018f9:	f7 f7                	div    %edi
  8018fb:	89 c5                	mov    %eax,%ebp
  8018fd:	89 f0                	mov    %esi,%eax
  8018ff:	31 d2                	xor    %edx,%edx
  801901:	f7 f5                	div    %ebp
  801903:	89 c8                	mov    %ecx,%eax
  801905:	f7 f5                	div    %ebp
  801907:	89 d0                	mov    %edx,%eax
  801909:	e9 44 ff ff ff       	jmp    801852 <__umoddi3+0x3e>
  80190e:	66 90                	xchg   %ax,%ax
  801910:	89 c8                	mov    %ecx,%eax
  801912:	89 f2                	mov    %esi,%edx
  801914:	83 c4 1c             	add    $0x1c,%esp
  801917:	5b                   	pop    %ebx
  801918:	5e                   	pop    %esi
  801919:	5f                   	pop    %edi
  80191a:	5d                   	pop    %ebp
  80191b:	c3                   	ret    
  80191c:	3b 04 24             	cmp    (%esp),%eax
  80191f:	72 06                	jb     801927 <__umoddi3+0x113>
  801921:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801925:	77 0f                	ja     801936 <__umoddi3+0x122>
  801927:	89 f2                	mov    %esi,%edx
  801929:	29 f9                	sub    %edi,%ecx
  80192b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80192f:	89 14 24             	mov    %edx,(%esp)
  801932:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801936:	8b 44 24 04          	mov    0x4(%esp),%eax
  80193a:	8b 14 24             	mov    (%esp),%edx
  80193d:	83 c4 1c             	add    $0x1c,%esp
  801940:	5b                   	pop    %ebx
  801941:	5e                   	pop    %esi
  801942:	5f                   	pop    %edi
  801943:	5d                   	pop    %ebp
  801944:	c3                   	ret    
  801945:	8d 76 00             	lea    0x0(%esi),%esi
  801948:	2b 04 24             	sub    (%esp),%eax
  80194b:	19 fa                	sbb    %edi,%edx
  80194d:	89 d1                	mov    %edx,%ecx
  80194f:	89 c6                	mov    %eax,%esi
  801951:	e9 71 ff ff ff       	jmp    8018c7 <__umoddi3+0xb3>
  801956:	66 90                	xchg   %ax,%ax
  801958:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80195c:	72 ea                	jb     801948 <__umoddi3+0x134>
  80195e:	89 d9                	mov    %ebx,%ecx
  801960:	e9 62 ff ff ff       	jmp    8018c7 <__umoddi3+0xb3>
