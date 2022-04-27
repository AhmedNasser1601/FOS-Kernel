
obj/user/ef_fos_add:     file format elf32-i386


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
  800031:	e8 60 00 00 00       	call   800096 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	int i1=0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	i1 = strtol("1", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 a0 18 80 00       	push   $0x8018a0
  800058:	e8 fe 0b 00 00       	call   800c5b <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 a2 18 80 00       	push   $0x8018a2
  80006f:	e8 e7 0b 00 00       	call   800c5b <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 a4 18 80 00       	push   $0x8018a4
  80008b:	e8 16 02 00 00       	call   8002a6 <atomic_cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//cprintf("number 1 + number 2 = \n");

	return;
  800093:	90                   	nop
}
  800094:	c9                   	leave  
  800095:	c3                   	ret    

00800096 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800096:	55                   	push   %ebp
  800097:	89 e5                	mov    %esp,%ebp
  800099:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80009c:	e8 03 10 00 00       	call   8010a4 <sys_getenvindex>
  8000a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a7:	89 d0                	mov    %edx,%eax
  8000a9:	c1 e0 02             	shl    $0x2,%eax
  8000ac:	01 d0                	add    %edx,%eax
  8000ae:	01 c0                	add    %eax,%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	01 c0                	add    %eax,%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000bd:	01 d0                	add    %edx,%eax
  8000bf:	c1 e0 02             	shl    $0x2,%eax
  8000c2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c7:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000cc:	a1 04 20 80 00       	mov    0x802004,%eax
  8000d1:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000d7:	84 c0                	test   %al,%al
  8000d9:	74 0f                	je     8000ea <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000db:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000e5:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ee:	7e 0a                	jle    8000fa <libmain+0x64>
		binaryname = argv[0];
  8000f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f3:	8b 00                	mov    (%eax),%eax
  8000f5:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000fa:	83 ec 08             	sub    $0x8,%esp
  8000fd:	ff 75 0c             	pushl  0xc(%ebp)
  800100:	ff 75 08             	pushl  0x8(%ebp)
  800103:	e8 30 ff ff ff       	call   800038 <_main>
  800108:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80010b:	e8 2f 11 00 00       	call   80123f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	68 d8 18 80 00       	push   $0x8018d8
  800118:	e8 5c 01 00 00       	call   800279 <cprintf>
  80011d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800120:	a1 04 20 80 00       	mov    0x802004,%eax
  800125:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80012b:	a1 04 20 80 00       	mov    0x802004,%eax
  800130:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	52                   	push   %edx
  80013a:	50                   	push   %eax
  80013b:	68 00 19 80 00       	push   $0x801900
  800140:	e8 34 01 00 00       	call   800279 <cprintf>
  800145:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800148:	a1 04 20 80 00       	mov    0x802004,%eax
  80014d:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	50                   	push   %eax
  800157:	68 25 19 80 00       	push   $0x801925
  80015c:	e8 18 01 00 00       	call   800279 <cprintf>
  800161:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800164:	83 ec 0c             	sub    $0xc,%esp
  800167:	68 d8 18 80 00       	push   $0x8018d8
  80016c:	e8 08 01 00 00       	call   800279 <cprintf>
  800171:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800174:	e8 e0 10 00 00       	call   801259 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800179:	e8 19 00 00 00       	call   800197 <exit>
}
  80017e:	90                   	nop
  80017f:	c9                   	leave  
  800180:	c3                   	ret    

00800181 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800181:	55                   	push   %ebp
  800182:	89 e5                	mov    %esp,%ebp
  800184:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800187:	83 ec 0c             	sub    $0xc,%esp
  80018a:	6a 00                	push   $0x0
  80018c:	e8 df 0e 00 00       	call   801070 <sys_env_destroy>
  800191:	83 c4 10             	add    $0x10,%esp
}
  800194:	90                   	nop
  800195:	c9                   	leave  
  800196:	c3                   	ret    

00800197 <exit>:

void
exit(void)
{
  800197:	55                   	push   %ebp
  800198:	89 e5                	mov    %esp,%ebp
  80019a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80019d:	e8 34 0f 00 00       	call   8010d6 <sys_env_exit>
}
  8001a2:	90                   	nop
  8001a3:	c9                   	leave  
  8001a4:	c3                   	ret    

008001a5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001a5:	55                   	push   %ebp
  8001a6:	89 e5                	mov    %esp,%ebp
  8001a8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ae:	8b 00                	mov    (%eax),%eax
  8001b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8001b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b6:	89 0a                	mov    %ecx,(%edx)
  8001b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8001bb:	88 d1                	mov    %dl,%cl
  8001bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c7:	8b 00                	mov    (%eax),%eax
  8001c9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001ce:	75 2c                	jne    8001fc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001d0:	a0 08 20 80 00       	mov    0x802008,%al
  8001d5:	0f b6 c0             	movzbl %al,%eax
  8001d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001db:	8b 12                	mov    (%edx),%edx
  8001dd:	89 d1                	mov    %edx,%ecx
  8001df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e2:	83 c2 08             	add    $0x8,%edx
  8001e5:	83 ec 04             	sub    $0x4,%esp
  8001e8:	50                   	push   %eax
  8001e9:	51                   	push   %ecx
  8001ea:	52                   	push   %edx
  8001eb:	e8 3e 0e 00 00       	call   80102e <sys_cputs>
  8001f0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ff:	8b 40 04             	mov    0x4(%eax),%eax
  800202:	8d 50 01             	lea    0x1(%eax),%edx
  800205:	8b 45 0c             	mov    0xc(%ebp),%eax
  800208:	89 50 04             	mov    %edx,0x4(%eax)
}
  80020b:	90                   	nop
  80020c:	c9                   	leave  
  80020d:	c3                   	ret    

0080020e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80020e:	55                   	push   %ebp
  80020f:	89 e5                	mov    %esp,%ebp
  800211:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800217:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80021e:	00 00 00 
	b.cnt = 0;
  800221:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800228:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80022b:	ff 75 0c             	pushl  0xc(%ebp)
  80022e:	ff 75 08             	pushl  0x8(%ebp)
  800231:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800237:	50                   	push   %eax
  800238:	68 a5 01 80 00       	push   $0x8001a5
  80023d:	e8 11 02 00 00       	call   800453 <vprintfmt>
  800242:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800245:	a0 08 20 80 00       	mov    0x802008,%al
  80024a:	0f b6 c0             	movzbl %al,%eax
  80024d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800253:	83 ec 04             	sub    $0x4,%esp
  800256:	50                   	push   %eax
  800257:	52                   	push   %edx
  800258:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80025e:	83 c0 08             	add    $0x8,%eax
  800261:	50                   	push   %eax
  800262:	e8 c7 0d 00 00       	call   80102e <sys_cputs>
  800267:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80026a:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800271:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800277:	c9                   	leave  
  800278:	c3                   	ret    

00800279 <cprintf>:

int cprintf(const char *fmt, ...) {
  800279:	55                   	push   %ebp
  80027a:	89 e5                	mov    %esp,%ebp
  80027c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80027f:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800286:	8d 45 0c             	lea    0xc(%ebp),%eax
  800289:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80028c:	8b 45 08             	mov    0x8(%ebp),%eax
  80028f:	83 ec 08             	sub    $0x8,%esp
  800292:	ff 75 f4             	pushl  -0xc(%ebp)
  800295:	50                   	push   %eax
  800296:	e8 73 ff ff ff       	call   80020e <vcprintf>
  80029b:	83 c4 10             	add    $0x10,%esp
  80029e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a4:	c9                   	leave  
  8002a5:	c3                   	ret    

008002a6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002a6:	55                   	push   %ebp
  8002a7:	89 e5                	mov    %esp,%ebp
  8002a9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ac:	e8 8e 0f 00 00       	call   80123f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002b1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c0:	50                   	push   %eax
  8002c1:	e8 48 ff ff ff       	call   80020e <vcprintf>
  8002c6:	83 c4 10             	add    $0x10,%esp
  8002c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002cc:	e8 88 0f 00 00       	call   801259 <sys_enable_interrupt>
	return cnt;
  8002d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d4:	c9                   	leave  
  8002d5:	c3                   	ret    

008002d6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002d6:	55                   	push   %ebp
  8002d7:	89 e5                	mov    %esp,%ebp
  8002d9:	53                   	push   %ebx
  8002da:	83 ec 14             	sub    $0x14,%esp
  8002dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8002e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002e9:	8b 45 18             	mov    0x18(%ebp),%eax
  8002ec:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f4:	77 55                	ja     80034b <printnum+0x75>
  8002f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002f9:	72 05                	jb     800300 <printnum+0x2a>
  8002fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fe:	77 4b                	ja     80034b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800300:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800303:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800306:	8b 45 18             	mov    0x18(%ebp),%eax
  800309:	ba 00 00 00 00       	mov    $0x0,%edx
  80030e:	52                   	push   %edx
  80030f:	50                   	push   %eax
  800310:	ff 75 f4             	pushl  -0xc(%ebp)
  800313:	ff 75 f0             	pushl  -0x10(%ebp)
  800316:	e8 05 13 00 00       	call   801620 <__udivdi3>
  80031b:	83 c4 10             	add    $0x10,%esp
  80031e:	83 ec 04             	sub    $0x4,%esp
  800321:	ff 75 20             	pushl  0x20(%ebp)
  800324:	53                   	push   %ebx
  800325:	ff 75 18             	pushl  0x18(%ebp)
  800328:	52                   	push   %edx
  800329:	50                   	push   %eax
  80032a:	ff 75 0c             	pushl  0xc(%ebp)
  80032d:	ff 75 08             	pushl  0x8(%ebp)
  800330:	e8 a1 ff ff ff       	call   8002d6 <printnum>
  800335:	83 c4 20             	add    $0x20,%esp
  800338:	eb 1a                	jmp    800354 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80033a:	83 ec 08             	sub    $0x8,%esp
  80033d:	ff 75 0c             	pushl  0xc(%ebp)
  800340:	ff 75 20             	pushl  0x20(%ebp)
  800343:	8b 45 08             	mov    0x8(%ebp),%eax
  800346:	ff d0                	call   *%eax
  800348:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80034b:	ff 4d 1c             	decl   0x1c(%ebp)
  80034e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800352:	7f e6                	jg     80033a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800354:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800357:	bb 00 00 00 00       	mov    $0x0,%ebx
  80035c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80035f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800362:	53                   	push   %ebx
  800363:	51                   	push   %ecx
  800364:	52                   	push   %edx
  800365:	50                   	push   %eax
  800366:	e8 c5 13 00 00       	call   801730 <__umoddi3>
  80036b:	83 c4 10             	add    $0x10,%esp
  80036e:	05 54 1b 80 00       	add    $0x801b54,%eax
  800373:	8a 00                	mov    (%eax),%al
  800375:	0f be c0             	movsbl %al,%eax
  800378:	83 ec 08             	sub    $0x8,%esp
  80037b:	ff 75 0c             	pushl  0xc(%ebp)
  80037e:	50                   	push   %eax
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	ff d0                	call   *%eax
  800384:	83 c4 10             	add    $0x10,%esp
}
  800387:	90                   	nop
  800388:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80038b:	c9                   	leave  
  80038c:	c3                   	ret    

0080038d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80038d:	55                   	push   %ebp
  80038e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800390:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800394:	7e 1c                	jle    8003b2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	8b 00                	mov    (%eax),%eax
  80039b:	8d 50 08             	lea    0x8(%eax),%edx
  80039e:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a1:	89 10                	mov    %edx,(%eax)
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	83 e8 08             	sub    $0x8,%eax
  8003ab:	8b 50 04             	mov    0x4(%eax),%edx
  8003ae:	8b 00                	mov    (%eax),%eax
  8003b0:	eb 40                	jmp    8003f2 <getuint+0x65>
	else if (lflag)
  8003b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003b6:	74 1e                	je     8003d6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	8d 50 04             	lea    0x4(%eax),%edx
  8003c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c3:	89 10                	mov    %edx,(%eax)
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	8b 00                	mov    (%eax),%eax
  8003ca:	83 e8 04             	sub    $0x4,%eax
  8003cd:	8b 00                	mov    (%eax),%eax
  8003cf:	ba 00 00 00 00       	mov    $0x0,%edx
  8003d4:	eb 1c                	jmp    8003f2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	8d 50 04             	lea    0x4(%eax),%edx
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	89 10                	mov    %edx,(%eax)
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	83 e8 04             	sub    $0x4,%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003f2:	5d                   	pop    %ebp
  8003f3:	c3                   	ret    

008003f4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003f4:	55                   	push   %ebp
  8003f5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003fb:	7e 1c                	jle    800419 <getint+0x25>
		return va_arg(*ap, long long);
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	8d 50 08             	lea    0x8(%eax),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	89 10                	mov    %edx,(%eax)
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	83 e8 08             	sub    $0x8,%eax
  800412:	8b 50 04             	mov    0x4(%eax),%edx
  800415:	8b 00                	mov    (%eax),%eax
  800417:	eb 38                	jmp    800451 <getint+0x5d>
	else if (lflag)
  800419:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80041d:	74 1a                	je     800439 <getint+0x45>
		return va_arg(*ap, long);
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	8d 50 04             	lea    0x4(%eax),%edx
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	89 10                	mov    %edx,(%eax)
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	83 e8 04             	sub    $0x4,%eax
  800434:	8b 00                	mov    (%eax),%eax
  800436:	99                   	cltd   
  800437:	eb 18                	jmp    800451 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	8d 50 04             	lea    0x4(%eax),%edx
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	89 10                	mov    %edx,(%eax)
  800446:	8b 45 08             	mov    0x8(%ebp),%eax
  800449:	8b 00                	mov    (%eax),%eax
  80044b:	83 e8 04             	sub    $0x4,%eax
  80044e:	8b 00                	mov    (%eax),%eax
  800450:	99                   	cltd   
}
  800451:	5d                   	pop    %ebp
  800452:	c3                   	ret    

00800453 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800453:	55                   	push   %ebp
  800454:	89 e5                	mov    %esp,%ebp
  800456:	56                   	push   %esi
  800457:	53                   	push   %ebx
  800458:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80045b:	eb 17                	jmp    800474 <vprintfmt+0x21>
			if (ch == '\0')
  80045d:	85 db                	test   %ebx,%ebx
  80045f:	0f 84 af 03 00 00    	je     800814 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800465:	83 ec 08             	sub    $0x8,%esp
  800468:	ff 75 0c             	pushl  0xc(%ebp)
  80046b:	53                   	push   %ebx
  80046c:	8b 45 08             	mov    0x8(%ebp),%eax
  80046f:	ff d0                	call   *%eax
  800471:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800474:	8b 45 10             	mov    0x10(%ebp),%eax
  800477:	8d 50 01             	lea    0x1(%eax),%edx
  80047a:	89 55 10             	mov    %edx,0x10(%ebp)
  80047d:	8a 00                	mov    (%eax),%al
  80047f:	0f b6 d8             	movzbl %al,%ebx
  800482:	83 fb 25             	cmp    $0x25,%ebx
  800485:	75 d6                	jne    80045d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800487:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80048b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800492:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800499:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004a0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004aa:	8d 50 01             	lea    0x1(%eax),%edx
  8004ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b0:	8a 00                	mov    (%eax),%al
  8004b2:	0f b6 d8             	movzbl %al,%ebx
  8004b5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004b8:	83 f8 55             	cmp    $0x55,%eax
  8004bb:	0f 87 2b 03 00 00    	ja     8007ec <vprintfmt+0x399>
  8004c1:	8b 04 85 78 1b 80 00 	mov    0x801b78(,%eax,4),%eax
  8004c8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004ca:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004ce:	eb d7                	jmp    8004a7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004d0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004d4:	eb d1                	jmp    8004a7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004dd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004e0:	89 d0                	mov    %edx,%eax
  8004e2:	c1 e0 02             	shl    $0x2,%eax
  8004e5:	01 d0                	add    %edx,%eax
  8004e7:	01 c0                	add    %eax,%eax
  8004e9:	01 d8                	add    %ebx,%eax
  8004eb:	83 e8 30             	sub    $0x30,%eax
  8004ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f4:	8a 00                	mov    (%eax),%al
  8004f6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004f9:	83 fb 2f             	cmp    $0x2f,%ebx
  8004fc:	7e 3e                	jle    80053c <vprintfmt+0xe9>
  8004fe:	83 fb 39             	cmp    $0x39,%ebx
  800501:	7f 39                	jg     80053c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800503:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800506:	eb d5                	jmp    8004dd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800508:	8b 45 14             	mov    0x14(%ebp),%eax
  80050b:	83 c0 04             	add    $0x4,%eax
  80050e:	89 45 14             	mov    %eax,0x14(%ebp)
  800511:	8b 45 14             	mov    0x14(%ebp),%eax
  800514:	83 e8 04             	sub    $0x4,%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80051c:	eb 1f                	jmp    80053d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80051e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800522:	79 83                	jns    8004a7 <vprintfmt+0x54>
				width = 0;
  800524:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80052b:	e9 77 ff ff ff       	jmp    8004a7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800530:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800537:	e9 6b ff ff ff       	jmp    8004a7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80053c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80053d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800541:	0f 89 60 ff ff ff    	jns    8004a7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800547:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80054a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80054d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800554:	e9 4e ff ff ff       	jmp    8004a7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800559:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80055c:	e9 46 ff ff ff       	jmp    8004a7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800561:	8b 45 14             	mov    0x14(%ebp),%eax
  800564:	83 c0 04             	add    $0x4,%eax
  800567:	89 45 14             	mov    %eax,0x14(%ebp)
  80056a:	8b 45 14             	mov    0x14(%ebp),%eax
  80056d:	83 e8 04             	sub    $0x4,%eax
  800570:	8b 00                	mov    (%eax),%eax
  800572:	83 ec 08             	sub    $0x8,%esp
  800575:	ff 75 0c             	pushl  0xc(%ebp)
  800578:	50                   	push   %eax
  800579:	8b 45 08             	mov    0x8(%ebp),%eax
  80057c:	ff d0                	call   *%eax
  80057e:	83 c4 10             	add    $0x10,%esp
			break;
  800581:	e9 89 02 00 00       	jmp    80080f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800586:	8b 45 14             	mov    0x14(%ebp),%eax
  800589:	83 c0 04             	add    $0x4,%eax
  80058c:	89 45 14             	mov    %eax,0x14(%ebp)
  80058f:	8b 45 14             	mov    0x14(%ebp),%eax
  800592:	83 e8 04             	sub    $0x4,%eax
  800595:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800597:	85 db                	test   %ebx,%ebx
  800599:	79 02                	jns    80059d <vprintfmt+0x14a>
				err = -err;
  80059b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80059d:	83 fb 64             	cmp    $0x64,%ebx
  8005a0:	7f 0b                	jg     8005ad <vprintfmt+0x15a>
  8005a2:	8b 34 9d c0 19 80 00 	mov    0x8019c0(,%ebx,4),%esi
  8005a9:	85 f6                	test   %esi,%esi
  8005ab:	75 19                	jne    8005c6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ad:	53                   	push   %ebx
  8005ae:	68 65 1b 80 00       	push   $0x801b65
  8005b3:	ff 75 0c             	pushl  0xc(%ebp)
  8005b6:	ff 75 08             	pushl  0x8(%ebp)
  8005b9:	e8 5e 02 00 00       	call   80081c <printfmt>
  8005be:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005c1:	e9 49 02 00 00       	jmp    80080f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005c6:	56                   	push   %esi
  8005c7:	68 6e 1b 80 00       	push   $0x801b6e
  8005cc:	ff 75 0c             	pushl  0xc(%ebp)
  8005cf:	ff 75 08             	pushl  0x8(%ebp)
  8005d2:	e8 45 02 00 00       	call   80081c <printfmt>
  8005d7:	83 c4 10             	add    $0x10,%esp
			break;
  8005da:	e9 30 02 00 00       	jmp    80080f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005df:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e2:	83 c0 04             	add    $0x4,%eax
  8005e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005eb:	83 e8 04             	sub    $0x4,%eax
  8005ee:	8b 30                	mov    (%eax),%esi
  8005f0:	85 f6                	test   %esi,%esi
  8005f2:	75 05                	jne    8005f9 <vprintfmt+0x1a6>
				p = "(null)";
  8005f4:	be 71 1b 80 00       	mov    $0x801b71,%esi
			if (width > 0 && padc != '-')
  8005f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fd:	7e 6d                	jle    80066c <vprintfmt+0x219>
  8005ff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800603:	74 67                	je     80066c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800605:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800608:	83 ec 08             	sub    $0x8,%esp
  80060b:	50                   	push   %eax
  80060c:	56                   	push   %esi
  80060d:	e8 0c 03 00 00       	call   80091e <strnlen>
  800612:	83 c4 10             	add    $0x10,%esp
  800615:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800618:	eb 16                	jmp    800630 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80061a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80061e:	83 ec 08             	sub    $0x8,%esp
  800621:	ff 75 0c             	pushl  0xc(%ebp)
  800624:	50                   	push   %eax
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	ff d0                	call   *%eax
  80062a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80062d:	ff 4d e4             	decl   -0x1c(%ebp)
  800630:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800634:	7f e4                	jg     80061a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800636:	eb 34                	jmp    80066c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800638:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80063c:	74 1c                	je     80065a <vprintfmt+0x207>
  80063e:	83 fb 1f             	cmp    $0x1f,%ebx
  800641:	7e 05                	jle    800648 <vprintfmt+0x1f5>
  800643:	83 fb 7e             	cmp    $0x7e,%ebx
  800646:	7e 12                	jle    80065a <vprintfmt+0x207>
					putch('?', putdat);
  800648:	83 ec 08             	sub    $0x8,%esp
  80064b:	ff 75 0c             	pushl  0xc(%ebp)
  80064e:	6a 3f                	push   $0x3f
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	ff d0                	call   *%eax
  800655:	83 c4 10             	add    $0x10,%esp
  800658:	eb 0f                	jmp    800669 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80065a:	83 ec 08             	sub    $0x8,%esp
  80065d:	ff 75 0c             	pushl  0xc(%ebp)
  800660:	53                   	push   %ebx
  800661:	8b 45 08             	mov    0x8(%ebp),%eax
  800664:	ff d0                	call   *%eax
  800666:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800669:	ff 4d e4             	decl   -0x1c(%ebp)
  80066c:	89 f0                	mov    %esi,%eax
  80066e:	8d 70 01             	lea    0x1(%eax),%esi
  800671:	8a 00                	mov    (%eax),%al
  800673:	0f be d8             	movsbl %al,%ebx
  800676:	85 db                	test   %ebx,%ebx
  800678:	74 24                	je     80069e <vprintfmt+0x24b>
  80067a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80067e:	78 b8                	js     800638 <vprintfmt+0x1e5>
  800680:	ff 4d e0             	decl   -0x20(%ebp)
  800683:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800687:	79 af                	jns    800638 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800689:	eb 13                	jmp    80069e <vprintfmt+0x24b>
				putch(' ', putdat);
  80068b:	83 ec 08             	sub    $0x8,%esp
  80068e:	ff 75 0c             	pushl  0xc(%ebp)
  800691:	6a 20                	push   $0x20
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	ff d0                	call   *%eax
  800698:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069b:	ff 4d e4             	decl   -0x1c(%ebp)
  80069e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a2:	7f e7                	jg     80068b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006a4:	e9 66 01 00 00       	jmp    80080f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 e8             	pushl  -0x18(%ebp)
  8006af:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b2:	50                   	push   %eax
  8006b3:	e8 3c fd ff ff       	call   8003f4 <getint>
  8006b8:	83 c4 10             	add    $0x10,%esp
  8006bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006be:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c7:	85 d2                	test   %edx,%edx
  8006c9:	79 23                	jns    8006ee <vprintfmt+0x29b>
				putch('-', putdat);
  8006cb:	83 ec 08             	sub    $0x8,%esp
  8006ce:	ff 75 0c             	pushl  0xc(%ebp)
  8006d1:	6a 2d                	push   $0x2d
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	ff d0                	call   *%eax
  8006d8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e1:	f7 d8                	neg    %eax
  8006e3:	83 d2 00             	adc    $0x0,%edx
  8006e6:	f7 da                	neg    %edx
  8006e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006f5:	e9 bc 00 00 00       	jmp    8007b6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006fa:	83 ec 08             	sub    $0x8,%esp
  8006fd:	ff 75 e8             	pushl  -0x18(%ebp)
  800700:	8d 45 14             	lea    0x14(%ebp),%eax
  800703:	50                   	push   %eax
  800704:	e8 84 fc ff ff       	call   80038d <getuint>
  800709:	83 c4 10             	add    $0x10,%esp
  80070c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800712:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800719:	e9 98 00 00 00       	jmp    8007b6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80071e:	83 ec 08             	sub    $0x8,%esp
  800721:	ff 75 0c             	pushl  0xc(%ebp)
  800724:	6a 58                	push   $0x58
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	ff d0                	call   *%eax
  80072b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80072e:	83 ec 08             	sub    $0x8,%esp
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	6a 58                	push   $0x58
  800736:	8b 45 08             	mov    0x8(%ebp),%eax
  800739:	ff d0                	call   *%eax
  80073b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	6a 58                	push   $0x58
  800746:	8b 45 08             	mov    0x8(%ebp),%eax
  800749:	ff d0                	call   *%eax
  80074b:	83 c4 10             	add    $0x10,%esp
			break;
  80074e:	e9 bc 00 00 00       	jmp    80080f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	ff 75 0c             	pushl  0xc(%ebp)
  800759:	6a 30                	push   $0x30
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	ff d0                	call   *%eax
  800760:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800763:	83 ec 08             	sub    $0x8,%esp
  800766:	ff 75 0c             	pushl  0xc(%ebp)
  800769:	6a 78                	push   $0x78
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	ff d0                	call   *%eax
  800770:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800773:	8b 45 14             	mov    0x14(%ebp),%eax
  800776:	83 c0 04             	add    $0x4,%eax
  800779:	89 45 14             	mov    %eax,0x14(%ebp)
  80077c:	8b 45 14             	mov    0x14(%ebp),%eax
  80077f:	83 e8 04             	sub    $0x4,%eax
  800782:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800784:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800787:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80078e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800795:	eb 1f                	jmp    8007b6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800797:	83 ec 08             	sub    $0x8,%esp
  80079a:	ff 75 e8             	pushl  -0x18(%ebp)
  80079d:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a0:	50                   	push   %eax
  8007a1:	e8 e7 fb ff ff       	call   80038d <getuint>
  8007a6:	83 c4 10             	add    $0x10,%esp
  8007a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007af:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007b6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007bd:	83 ec 04             	sub    $0x4,%esp
  8007c0:	52                   	push   %edx
  8007c1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007c4:	50                   	push   %eax
  8007c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c8:	ff 75 f0             	pushl  -0x10(%ebp)
  8007cb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ce:	ff 75 08             	pushl  0x8(%ebp)
  8007d1:	e8 00 fb ff ff       	call   8002d6 <printnum>
  8007d6:	83 c4 20             	add    $0x20,%esp
			break;
  8007d9:	eb 34                	jmp    80080f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007db:	83 ec 08             	sub    $0x8,%esp
  8007de:	ff 75 0c             	pushl  0xc(%ebp)
  8007e1:	53                   	push   %ebx
  8007e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e5:	ff d0                	call   *%eax
  8007e7:	83 c4 10             	add    $0x10,%esp
			break;
  8007ea:	eb 23                	jmp    80080f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007ec:	83 ec 08             	sub    $0x8,%esp
  8007ef:	ff 75 0c             	pushl  0xc(%ebp)
  8007f2:	6a 25                	push   $0x25
  8007f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f7:	ff d0                	call   *%eax
  8007f9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007fc:	ff 4d 10             	decl   0x10(%ebp)
  8007ff:	eb 03                	jmp    800804 <vprintfmt+0x3b1>
  800801:	ff 4d 10             	decl   0x10(%ebp)
  800804:	8b 45 10             	mov    0x10(%ebp),%eax
  800807:	48                   	dec    %eax
  800808:	8a 00                	mov    (%eax),%al
  80080a:	3c 25                	cmp    $0x25,%al
  80080c:	75 f3                	jne    800801 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80080e:	90                   	nop
		}
	}
  80080f:	e9 47 fc ff ff       	jmp    80045b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800814:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800815:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800818:	5b                   	pop    %ebx
  800819:	5e                   	pop    %esi
  80081a:	5d                   	pop    %ebp
  80081b:	c3                   	ret    

0080081c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80081c:	55                   	push   %ebp
  80081d:	89 e5                	mov    %esp,%ebp
  80081f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800822:	8d 45 10             	lea    0x10(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80082b:	8b 45 10             	mov    0x10(%ebp),%eax
  80082e:	ff 75 f4             	pushl  -0xc(%ebp)
  800831:	50                   	push   %eax
  800832:	ff 75 0c             	pushl  0xc(%ebp)
  800835:	ff 75 08             	pushl  0x8(%ebp)
  800838:	e8 16 fc ff ff       	call   800453 <vprintfmt>
  80083d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800840:	90                   	nop
  800841:	c9                   	leave  
  800842:	c3                   	ret    

00800843 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800843:	55                   	push   %ebp
  800844:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800846:	8b 45 0c             	mov    0xc(%ebp),%eax
  800849:	8b 40 08             	mov    0x8(%eax),%eax
  80084c:	8d 50 01             	lea    0x1(%eax),%edx
  80084f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800852:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800855:	8b 45 0c             	mov    0xc(%ebp),%eax
  800858:	8b 10                	mov    (%eax),%edx
  80085a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085d:	8b 40 04             	mov    0x4(%eax),%eax
  800860:	39 c2                	cmp    %eax,%edx
  800862:	73 12                	jae    800876 <sprintputch+0x33>
		*b->buf++ = ch;
  800864:	8b 45 0c             	mov    0xc(%ebp),%eax
  800867:	8b 00                	mov    (%eax),%eax
  800869:	8d 48 01             	lea    0x1(%eax),%ecx
  80086c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80086f:	89 0a                	mov    %ecx,(%edx)
  800871:	8b 55 08             	mov    0x8(%ebp),%edx
  800874:	88 10                	mov    %dl,(%eax)
}
  800876:	90                   	nop
  800877:	5d                   	pop    %ebp
  800878:	c3                   	ret    

00800879 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800879:	55                   	push   %ebp
  80087a:	89 e5                	mov    %esp,%ebp
  80087c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800885:	8b 45 0c             	mov    0xc(%ebp),%eax
  800888:	8d 50 ff             	lea    -0x1(%eax),%edx
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	01 d0                	add    %edx,%eax
  800890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800893:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80089a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80089e:	74 06                	je     8008a6 <vsnprintf+0x2d>
  8008a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a4:	7f 07                	jg     8008ad <vsnprintf+0x34>
		return -E_INVAL;
  8008a6:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ab:	eb 20                	jmp    8008cd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ad:	ff 75 14             	pushl  0x14(%ebp)
  8008b0:	ff 75 10             	pushl  0x10(%ebp)
  8008b3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008b6:	50                   	push   %eax
  8008b7:	68 43 08 80 00       	push   $0x800843
  8008bc:	e8 92 fb ff ff       	call   800453 <vprintfmt>
  8008c1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008cd:	c9                   	leave  
  8008ce:	c3                   	ret    

008008cf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008cf:	55                   	push   %ebp
  8008d0:	89 e5                	mov    %esp,%ebp
  8008d2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008d5:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d8:	83 c0 04             	add    $0x4,%eax
  8008db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008de:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e4:	50                   	push   %eax
  8008e5:	ff 75 0c             	pushl  0xc(%ebp)
  8008e8:	ff 75 08             	pushl  0x8(%ebp)
  8008eb:	e8 89 ff ff ff       	call   800879 <vsnprintf>
  8008f0:	83 c4 10             	add    $0x10,%esp
  8008f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008f9:	c9                   	leave  
  8008fa:	c3                   	ret    

008008fb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008fb:	55                   	push   %ebp
  8008fc:	89 e5                	mov    %esp,%ebp
  8008fe:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800901:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800908:	eb 06                	jmp    800910 <strlen+0x15>
		n++;
  80090a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80090d:	ff 45 08             	incl   0x8(%ebp)
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	8a 00                	mov    (%eax),%al
  800915:	84 c0                	test   %al,%al
  800917:	75 f1                	jne    80090a <strlen+0xf>
		n++;
	return n;
  800919:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80091c:	c9                   	leave  
  80091d:	c3                   	ret    

0080091e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80091e:	55                   	push   %ebp
  80091f:	89 e5                	mov    %esp,%ebp
  800921:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800924:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80092b:	eb 09                	jmp    800936 <strnlen+0x18>
		n++;
  80092d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800930:	ff 45 08             	incl   0x8(%ebp)
  800933:	ff 4d 0c             	decl   0xc(%ebp)
  800936:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80093a:	74 09                	je     800945 <strnlen+0x27>
  80093c:	8b 45 08             	mov    0x8(%ebp),%eax
  80093f:	8a 00                	mov    (%eax),%al
  800941:	84 c0                	test   %al,%al
  800943:	75 e8                	jne    80092d <strnlen+0xf>
		n++;
	return n;
  800945:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800948:	c9                   	leave  
  800949:	c3                   	ret    

0080094a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80094a:	55                   	push   %ebp
  80094b:	89 e5                	mov    %esp,%ebp
  80094d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800956:	90                   	nop
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	8d 50 01             	lea    0x1(%eax),%edx
  80095d:	89 55 08             	mov    %edx,0x8(%ebp)
  800960:	8b 55 0c             	mov    0xc(%ebp),%edx
  800963:	8d 4a 01             	lea    0x1(%edx),%ecx
  800966:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800969:	8a 12                	mov    (%edx),%dl
  80096b:	88 10                	mov    %dl,(%eax)
  80096d:	8a 00                	mov    (%eax),%al
  80096f:	84 c0                	test   %al,%al
  800971:	75 e4                	jne    800957 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800973:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800976:	c9                   	leave  
  800977:	c3                   	ret    

00800978 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800984:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098b:	eb 1f                	jmp    8009ac <strncpy+0x34>
		*dst++ = *src;
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8d 50 01             	lea    0x1(%eax),%edx
  800993:	89 55 08             	mov    %edx,0x8(%ebp)
  800996:	8b 55 0c             	mov    0xc(%ebp),%edx
  800999:	8a 12                	mov    (%edx),%dl
  80099b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80099d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a0:	8a 00                	mov    (%eax),%al
  8009a2:	84 c0                	test   %al,%al
  8009a4:	74 03                	je     8009a9 <strncpy+0x31>
			src++;
  8009a6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009a9:	ff 45 fc             	incl   -0x4(%ebp)
  8009ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009b2:	72 d9                	jb     80098d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009c9:	74 30                	je     8009fb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009cb:	eb 16                	jmp    8009e3 <strlcpy+0x2a>
			*dst++ = *src++;
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	8d 50 01             	lea    0x1(%eax),%edx
  8009d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009dc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009df:	8a 12                	mov    (%edx),%dl
  8009e1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009e3:	ff 4d 10             	decl   0x10(%ebp)
  8009e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ea:	74 09                	je     8009f5 <strlcpy+0x3c>
  8009ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ef:	8a 00                	mov    (%eax),%al
  8009f1:	84 c0                	test   %al,%al
  8009f3:	75 d8                	jne    8009cd <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8009fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a01:	29 c2                	sub    %eax,%edx
  800a03:	89 d0                	mov    %edx,%eax
}
  800a05:	c9                   	leave  
  800a06:	c3                   	ret    

00800a07 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a0a:	eb 06                	jmp    800a12 <strcmp+0xb>
		p++, q++;
  800a0c:	ff 45 08             	incl   0x8(%ebp)
  800a0f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a12:	8b 45 08             	mov    0x8(%ebp),%eax
  800a15:	8a 00                	mov    (%eax),%al
  800a17:	84 c0                	test   %al,%al
  800a19:	74 0e                	je     800a29 <strcmp+0x22>
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	8a 10                	mov    (%eax),%dl
  800a20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a23:	8a 00                	mov    (%eax),%al
  800a25:	38 c2                	cmp    %al,%dl
  800a27:	74 e3                	je     800a0c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a29:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2c:	8a 00                	mov    (%eax),%al
  800a2e:	0f b6 d0             	movzbl %al,%edx
  800a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a34:	8a 00                	mov    (%eax),%al
  800a36:	0f b6 c0             	movzbl %al,%eax
  800a39:	29 c2                	sub    %eax,%edx
  800a3b:	89 d0                	mov    %edx,%eax
}
  800a3d:	5d                   	pop    %ebp
  800a3e:	c3                   	ret    

00800a3f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a3f:	55                   	push   %ebp
  800a40:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a42:	eb 09                	jmp    800a4d <strncmp+0xe>
		n--, p++, q++;
  800a44:	ff 4d 10             	decl   0x10(%ebp)
  800a47:	ff 45 08             	incl   0x8(%ebp)
  800a4a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a51:	74 17                	je     800a6a <strncmp+0x2b>
  800a53:	8b 45 08             	mov    0x8(%ebp),%eax
  800a56:	8a 00                	mov    (%eax),%al
  800a58:	84 c0                	test   %al,%al
  800a5a:	74 0e                	je     800a6a <strncmp+0x2b>
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	8a 10                	mov    (%eax),%dl
  800a61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a64:	8a 00                	mov    (%eax),%al
  800a66:	38 c2                	cmp    %al,%dl
  800a68:	74 da                	je     800a44 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6e:	75 07                	jne    800a77 <strncmp+0x38>
		return 0;
  800a70:	b8 00 00 00 00       	mov    $0x0,%eax
  800a75:	eb 14                	jmp    800a8b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	8a 00                	mov    (%eax),%al
  800a7c:	0f b6 d0             	movzbl %al,%edx
  800a7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a82:	8a 00                	mov    (%eax),%al
  800a84:	0f b6 c0             	movzbl %al,%eax
  800a87:	29 c2                	sub    %eax,%edx
  800a89:	89 d0                	mov    %edx,%eax
}
  800a8b:	5d                   	pop    %ebp
  800a8c:	c3                   	ret    

00800a8d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 04             	sub    $0x4,%esp
  800a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a96:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a99:	eb 12                	jmp    800aad <strchr+0x20>
		if (*s == c)
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa3:	75 05                	jne    800aaa <strchr+0x1d>
			return (char *) s;
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	eb 11                	jmp    800abb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aaa:	ff 45 08             	incl   0x8(%ebp)
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	8a 00                	mov    (%eax),%al
  800ab2:	84 c0                	test   %al,%al
  800ab4:	75 e5                	jne    800a9b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ab6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800abb:	c9                   	leave  
  800abc:	c3                   	ret    

00800abd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800abd:	55                   	push   %ebp
  800abe:	89 e5                	mov    %esp,%ebp
  800ac0:	83 ec 04             	sub    $0x4,%esp
  800ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ac9:	eb 0d                	jmp    800ad8 <strfind+0x1b>
		if (*s == c)
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad3:	74 0e                	je     800ae3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ad5:	ff 45 08             	incl   0x8(%ebp)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	84 c0                	test   %al,%al
  800adf:	75 ea                	jne    800acb <strfind+0xe>
  800ae1:	eb 01                	jmp    800ae4 <strfind+0x27>
		if (*s == c)
			break;
  800ae3:	90                   	nop
	return (char *) s;
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae7:	c9                   	leave  
  800ae8:	c3                   	ret    

00800ae9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ae9:	55                   	push   %ebp
  800aea:	89 e5                	mov    %esp,%ebp
  800aec:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800af5:	8b 45 10             	mov    0x10(%ebp),%eax
  800af8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800afb:	eb 0e                	jmp    800b0b <memset+0x22>
		*p++ = c;
  800afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b00:	8d 50 01             	lea    0x1(%eax),%edx
  800b03:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b09:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b0b:	ff 4d f8             	decl   -0x8(%ebp)
  800b0e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b12:	79 e9                	jns    800afd <memset+0x14>
		*p++ = c;

	return v;
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b17:	c9                   	leave  
  800b18:	c3                   	ret    

00800b19 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b19:	55                   	push   %ebp
  800b1a:	89 e5                	mov    %esp,%ebp
  800b1c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b2b:	eb 16                	jmp    800b43 <memcpy+0x2a>
		*d++ = *s++;
  800b2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b30:	8d 50 01             	lea    0x1(%eax),%edx
  800b33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b36:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b39:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b3c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b3f:	8a 12                	mov    (%edx),%dl
  800b41:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b43:	8b 45 10             	mov    0x10(%ebp),%eax
  800b46:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b49:	89 55 10             	mov    %edx,0x10(%ebp)
  800b4c:	85 c0                	test   %eax,%eax
  800b4e:	75 dd                	jne    800b2d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b53:	c9                   	leave  
  800b54:	c3                   	ret    

00800b55 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b6a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b6d:	73 50                	jae    800bbf <memmove+0x6a>
  800b6f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b72:	8b 45 10             	mov    0x10(%ebp),%eax
  800b75:	01 d0                	add    %edx,%eax
  800b77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b7a:	76 43                	jbe    800bbf <memmove+0x6a>
		s += n;
  800b7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b82:	8b 45 10             	mov    0x10(%ebp),%eax
  800b85:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b88:	eb 10                	jmp    800b9a <memmove+0x45>
			*--d = *--s;
  800b8a:	ff 4d f8             	decl   -0x8(%ebp)
  800b8d:	ff 4d fc             	decl   -0x4(%ebp)
  800b90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b93:	8a 10                	mov    (%eax),%dl
  800b95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b98:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba3:	85 c0                	test   %eax,%eax
  800ba5:	75 e3                	jne    800b8a <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ba7:	eb 23                	jmp    800bcc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ba9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bac:	8d 50 01             	lea    0x1(%eax),%edx
  800baf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bb8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bbb:	8a 12                	mov    (%edx),%dl
  800bbd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc5:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc8:	85 c0                	test   %eax,%eax
  800bca:	75 dd                	jne    800ba9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800be3:	eb 2a                	jmp    800c0f <memcmp+0x3e>
		if (*s1 != *s2)
  800be5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be8:	8a 10                	mov    (%eax),%dl
  800bea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bed:	8a 00                	mov    (%eax),%al
  800bef:	38 c2                	cmp    %al,%dl
  800bf1:	74 16                	je     800c09 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	0f b6 d0             	movzbl %al,%edx
  800bfb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bfe:	8a 00                	mov    (%eax),%al
  800c00:	0f b6 c0             	movzbl %al,%eax
  800c03:	29 c2                	sub    %eax,%edx
  800c05:	89 d0                	mov    %edx,%eax
  800c07:	eb 18                	jmp    800c21 <memcmp+0x50>
		s1++, s2++;
  800c09:	ff 45 fc             	incl   -0x4(%ebp)
  800c0c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c12:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c15:	89 55 10             	mov    %edx,0x10(%ebp)
  800c18:	85 c0                	test   %eax,%eax
  800c1a:	75 c9                	jne    800be5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c21:	c9                   	leave  
  800c22:	c3                   	ret    

00800c23 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
  800c26:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c29:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2f:	01 d0                	add    %edx,%eax
  800c31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c34:	eb 15                	jmp    800c4b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	8a 00                	mov    (%eax),%al
  800c3b:	0f b6 d0             	movzbl %al,%edx
  800c3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c41:	0f b6 c0             	movzbl %al,%eax
  800c44:	39 c2                	cmp    %eax,%edx
  800c46:	74 0d                	je     800c55 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c48:	ff 45 08             	incl   0x8(%ebp)
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c51:	72 e3                	jb     800c36 <memfind+0x13>
  800c53:	eb 01                	jmp    800c56 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c55:	90                   	nop
	return (void *) s;
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c59:	c9                   	leave  
  800c5a:	c3                   	ret    

00800c5b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
  800c5e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c61:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c68:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c6f:	eb 03                	jmp    800c74 <strtol+0x19>
		s++;
  800c71:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	8a 00                	mov    (%eax),%al
  800c79:	3c 20                	cmp    $0x20,%al
  800c7b:	74 f4                	je     800c71 <strtol+0x16>
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8a 00                	mov    (%eax),%al
  800c82:	3c 09                	cmp    $0x9,%al
  800c84:	74 eb                	je     800c71 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	8a 00                	mov    (%eax),%al
  800c8b:	3c 2b                	cmp    $0x2b,%al
  800c8d:	75 05                	jne    800c94 <strtol+0x39>
		s++;
  800c8f:	ff 45 08             	incl   0x8(%ebp)
  800c92:	eb 13                	jmp    800ca7 <strtol+0x4c>
	else if (*s == '-')
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	3c 2d                	cmp    $0x2d,%al
  800c9b:	75 0a                	jne    800ca7 <strtol+0x4c>
		s++, neg = 1;
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ca7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cab:	74 06                	je     800cb3 <strtol+0x58>
  800cad:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cb1:	75 20                	jne    800cd3 <strtol+0x78>
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	3c 30                	cmp    $0x30,%al
  800cba:	75 17                	jne    800cd3 <strtol+0x78>
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	40                   	inc    %eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	3c 78                	cmp    $0x78,%al
  800cc4:	75 0d                	jne    800cd3 <strtol+0x78>
		s += 2, base = 16;
  800cc6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cca:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cd1:	eb 28                	jmp    800cfb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cd3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd7:	75 15                	jne    800cee <strtol+0x93>
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	3c 30                	cmp    $0x30,%al
  800ce0:	75 0c                	jne    800cee <strtol+0x93>
		s++, base = 8;
  800ce2:	ff 45 08             	incl   0x8(%ebp)
  800ce5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cec:	eb 0d                	jmp    800cfb <strtol+0xa0>
	else if (base == 0)
  800cee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf2:	75 07                	jne    800cfb <strtol+0xa0>
		base = 10;
  800cf4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	3c 2f                	cmp    $0x2f,%al
  800d02:	7e 19                	jle    800d1d <strtol+0xc2>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	3c 39                	cmp    $0x39,%al
  800d0b:	7f 10                	jg     800d1d <strtol+0xc2>
			dig = *s - '0';
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	0f be c0             	movsbl %al,%eax
  800d15:	83 e8 30             	sub    $0x30,%eax
  800d18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d1b:	eb 42                	jmp    800d5f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	3c 60                	cmp    $0x60,%al
  800d24:	7e 19                	jle    800d3f <strtol+0xe4>
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 7a                	cmp    $0x7a,%al
  800d2d:	7f 10                	jg     800d3f <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	0f be c0             	movsbl %al,%eax
  800d37:	83 e8 57             	sub    $0x57,%eax
  800d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d3d:	eb 20                	jmp    800d5f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	3c 40                	cmp    $0x40,%al
  800d46:	7e 39                	jle    800d81 <strtol+0x126>
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	3c 5a                	cmp    $0x5a,%al
  800d4f:	7f 30                	jg     800d81 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	0f be c0             	movsbl %al,%eax
  800d59:	83 e8 37             	sub    $0x37,%eax
  800d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d62:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d65:	7d 19                	jge    800d80 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d67:	ff 45 08             	incl   0x8(%ebp)
  800d6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6d:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d71:	89 c2                	mov    %eax,%edx
  800d73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d76:	01 d0                	add    %edx,%eax
  800d78:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d7b:	e9 7b ff ff ff       	jmp    800cfb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d80:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d85:	74 08                	je     800d8f <strtol+0x134>
		*endptr = (char *) s;
  800d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800d8d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d8f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d93:	74 07                	je     800d9c <strtol+0x141>
  800d95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d98:	f7 d8                	neg    %eax
  800d9a:	eb 03                	jmp    800d9f <strtol+0x144>
  800d9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d9f:	c9                   	leave  
  800da0:	c3                   	ret    

00800da1 <ltostr>:

void
ltostr(long value, char *str)
{
  800da1:	55                   	push   %ebp
  800da2:	89 e5                	mov    %esp,%ebp
  800da4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800da7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800db5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800db9:	79 13                	jns    800dce <ltostr+0x2d>
	{
		neg = 1;
  800dbb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dc8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dcb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dd6:	99                   	cltd   
  800dd7:	f7 f9                	idiv   %ecx
  800dd9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ddc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddf:	8d 50 01             	lea    0x1(%eax),%edx
  800de2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800de5:	89 c2                	mov    %eax,%edx
  800de7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dea:	01 d0                	add    %edx,%eax
  800dec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800def:	83 c2 30             	add    $0x30,%edx
  800df2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800df4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800df7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dfc:	f7 e9                	imul   %ecx
  800dfe:	c1 fa 02             	sar    $0x2,%edx
  800e01:	89 c8                	mov    %ecx,%eax
  800e03:	c1 f8 1f             	sar    $0x1f,%eax
  800e06:	29 c2                	sub    %eax,%edx
  800e08:	89 d0                	mov    %edx,%eax
  800e0a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e10:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e15:	f7 e9                	imul   %ecx
  800e17:	c1 fa 02             	sar    $0x2,%edx
  800e1a:	89 c8                	mov    %ecx,%eax
  800e1c:	c1 f8 1f             	sar    $0x1f,%eax
  800e1f:	29 c2                	sub    %eax,%edx
  800e21:	89 d0                	mov    %edx,%eax
  800e23:	c1 e0 02             	shl    $0x2,%eax
  800e26:	01 d0                	add    %edx,%eax
  800e28:	01 c0                	add    %eax,%eax
  800e2a:	29 c1                	sub    %eax,%ecx
  800e2c:	89 ca                	mov    %ecx,%edx
  800e2e:	85 d2                	test   %edx,%edx
  800e30:	75 9c                	jne    800dce <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3c:	48                   	dec    %eax
  800e3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e40:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e44:	74 3d                	je     800e83 <ltostr+0xe2>
		start = 1 ;
  800e46:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e4d:	eb 34                	jmp    800e83 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e55:	01 d0                	add    %edx,%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	01 c2                	add    %eax,%edx
  800e64:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6a:	01 c8                	add    %ecx,%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e70:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e76:	01 c2                	add    %eax,%edx
  800e78:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e7b:	88 02                	mov    %al,(%edx)
		start++ ;
  800e7d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e80:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e86:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e89:	7c c4                	jl     800e4f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e8b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	01 d0                	add    %edx,%eax
  800e93:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e96:	90                   	nop
  800e97:	c9                   	leave  
  800e98:	c3                   	ret    

00800e99 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e99:	55                   	push   %ebp
  800e9a:	89 e5                	mov    %esp,%ebp
  800e9c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e9f:	ff 75 08             	pushl  0x8(%ebp)
  800ea2:	e8 54 fa ff ff       	call   8008fb <strlen>
  800ea7:	83 c4 04             	add    $0x4,%esp
  800eaa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ead:	ff 75 0c             	pushl  0xc(%ebp)
  800eb0:	e8 46 fa ff ff       	call   8008fb <strlen>
  800eb5:	83 c4 04             	add    $0x4,%esp
  800eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ebb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ec2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec9:	eb 17                	jmp    800ee2 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ecb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ece:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed1:	01 c2                	add    %eax,%edx
  800ed3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed9:	01 c8                	add    %ecx,%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800edf:	ff 45 fc             	incl   -0x4(%ebp)
  800ee2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ee8:	7c e1                	jl     800ecb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ef1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ef8:	eb 1f                	jmp    800f19 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800efa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efd:	8d 50 01             	lea    0x1(%eax),%edx
  800f00:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f03:	89 c2                	mov    %eax,%edx
  800f05:	8b 45 10             	mov    0x10(%ebp),%eax
  800f08:	01 c2                	add    %eax,%edx
  800f0a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	01 c8                	add    %ecx,%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f16:	ff 45 f8             	incl   -0x8(%ebp)
  800f19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f1f:	7c d9                	jl     800efa <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f21:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f24:	8b 45 10             	mov    0x10(%ebp),%eax
  800f27:	01 d0                	add    %edx,%eax
  800f29:	c6 00 00             	movb   $0x0,(%eax)
}
  800f2c:	90                   	nop
  800f2d:	c9                   	leave  
  800f2e:	c3                   	ret    

00800f2f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f2f:	55                   	push   %ebp
  800f30:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f32:	8b 45 14             	mov    0x14(%ebp),%eax
  800f35:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3e:	8b 00                	mov    (%eax),%eax
  800f40:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f47:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4a:	01 d0                	add    %edx,%eax
  800f4c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f52:	eb 0c                	jmp    800f60 <strsplit+0x31>
			*string++ = 0;
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	8d 50 01             	lea    0x1(%eax),%edx
  800f5a:	89 55 08             	mov    %edx,0x8(%ebp)
  800f5d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	84 c0                	test   %al,%al
  800f67:	74 18                	je     800f81 <strsplit+0x52>
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8a 00                	mov    (%eax),%al
  800f6e:	0f be c0             	movsbl %al,%eax
  800f71:	50                   	push   %eax
  800f72:	ff 75 0c             	pushl  0xc(%ebp)
  800f75:	e8 13 fb ff ff       	call   800a8d <strchr>
  800f7a:	83 c4 08             	add    $0x8,%esp
  800f7d:	85 c0                	test   %eax,%eax
  800f7f:	75 d3                	jne    800f54 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	84 c0                	test   %al,%al
  800f88:	74 5a                	je     800fe4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8d:	8b 00                	mov    (%eax),%eax
  800f8f:	83 f8 0f             	cmp    $0xf,%eax
  800f92:	75 07                	jne    800f9b <strsplit+0x6c>
		{
			return 0;
  800f94:	b8 00 00 00 00       	mov    $0x0,%eax
  800f99:	eb 66                	jmp    801001 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9e:	8b 00                	mov    (%eax),%eax
  800fa0:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa3:	8b 55 14             	mov    0x14(%ebp),%edx
  800fa6:	89 0a                	mov    %ecx,(%edx)
  800fa8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800faf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb2:	01 c2                	add    %eax,%edx
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fb9:	eb 03                	jmp    800fbe <strsplit+0x8f>
			string++;
  800fbb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	84 c0                	test   %al,%al
  800fc5:	74 8b                	je     800f52 <strsplit+0x23>
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	0f be c0             	movsbl %al,%eax
  800fcf:	50                   	push   %eax
  800fd0:	ff 75 0c             	pushl  0xc(%ebp)
  800fd3:	e8 b5 fa ff ff       	call   800a8d <strchr>
  800fd8:	83 c4 08             	add    $0x8,%esp
  800fdb:	85 c0                	test   %eax,%eax
  800fdd:	74 dc                	je     800fbb <strsplit+0x8c>
			string++;
	}
  800fdf:	e9 6e ff ff ff       	jmp    800f52 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fe4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fe5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe8:	8b 00                	mov    (%eax),%eax
  800fea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	01 d0                	add    %edx,%eax
  800ff6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800ffc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801001:	c9                   	leave  
  801002:	c3                   	ret    

00801003 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	57                   	push   %edi
  801007:	56                   	push   %esi
  801008:	53                   	push   %ebx
  801009:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801012:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801015:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801018:	8b 7d 18             	mov    0x18(%ebp),%edi
  80101b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80101e:	cd 30                	int    $0x30
  801020:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801023:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801026:	83 c4 10             	add    $0x10,%esp
  801029:	5b                   	pop    %ebx
  80102a:	5e                   	pop    %esi
  80102b:	5f                   	pop    %edi
  80102c:	5d                   	pop    %ebp
  80102d:	c3                   	ret    

0080102e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80102e:	55                   	push   %ebp
  80102f:	89 e5                	mov    %esp,%ebp
  801031:	83 ec 04             	sub    $0x4,%esp
  801034:	8b 45 10             	mov    0x10(%ebp),%eax
  801037:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80103a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	6a 00                	push   $0x0
  801043:	6a 00                	push   $0x0
  801045:	52                   	push   %edx
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	50                   	push   %eax
  80104a:	6a 00                	push   $0x0
  80104c:	e8 b2 ff ff ff       	call   801003 <syscall>
  801051:	83 c4 18             	add    $0x18,%esp
}
  801054:	90                   	nop
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <sys_cgetc>:

int
sys_cgetc(void)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80105a:	6a 00                	push   $0x0
  80105c:	6a 00                	push   $0x0
  80105e:	6a 00                	push   $0x0
  801060:	6a 00                	push   $0x0
  801062:	6a 00                	push   $0x0
  801064:	6a 01                	push   $0x1
  801066:	e8 98 ff ff ff       	call   801003 <syscall>
  80106b:	83 c4 18             	add    $0x18,%esp
}
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	6a 00                	push   $0x0
  801078:	6a 00                	push   $0x0
  80107a:	6a 00                	push   $0x0
  80107c:	6a 00                	push   $0x0
  80107e:	50                   	push   %eax
  80107f:	6a 05                	push   $0x5
  801081:	e8 7d ff ff ff       	call   801003 <syscall>
  801086:	83 c4 18             	add    $0x18,%esp
}
  801089:	c9                   	leave  
  80108a:	c3                   	ret    

0080108b <sys_getenvid>:

int32 sys_getenvid(void)
{
  80108b:	55                   	push   %ebp
  80108c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 02                	push   $0x2
  80109a:	e8 64 ff ff ff       	call   801003 <syscall>
  80109f:	83 c4 18             	add    $0x18,%esp
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 03                	push   $0x3
  8010b3:	e8 4b ff ff ff       	call   801003 <syscall>
  8010b8:	83 c4 18             	add    $0x18,%esp
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 04                	push   $0x4
  8010cc:	e8 32 ff ff ff       	call   801003 <syscall>
  8010d1:	83 c4 18             	add    $0x18,%esp
}
  8010d4:	c9                   	leave  
  8010d5:	c3                   	ret    

008010d6 <sys_env_exit>:


void sys_env_exit(void)
{
  8010d6:	55                   	push   %ebp
  8010d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 06                	push   $0x6
  8010e5:	e8 19 ff ff ff       	call   801003 <syscall>
  8010ea:	83 c4 18             	add    $0x18,%esp
}
  8010ed:	90                   	nop
  8010ee:	c9                   	leave  
  8010ef:	c3                   	ret    

008010f0 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010f0:	55                   	push   %ebp
  8010f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f9:	6a 00                	push   $0x0
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	52                   	push   %edx
  801100:	50                   	push   %eax
  801101:	6a 07                	push   $0x7
  801103:	e8 fb fe ff ff       	call   801003 <syscall>
  801108:	83 c4 18             	add    $0x18,%esp
}
  80110b:	c9                   	leave  
  80110c:	c3                   	ret    

0080110d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80110d:	55                   	push   %ebp
  80110e:	89 e5                	mov    %esp,%ebp
  801110:	56                   	push   %esi
  801111:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801112:	8b 75 18             	mov    0x18(%ebp),%esi
  801115:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801118:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80111b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	56                   	push   %esi
  801122:	53                   	push   %ebx
  801123:	51                   	push   %ecx
  801124:	52                   	push   %edx
  801125:	50                   	push   %eax
  801126:	6a 08                	push   $0x8
  801128:	e8 d6 fe ff ff       	call   801003 <syscall>
  80112d:	83 c4 18             	add    $0x18,%esp
}
  801130:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801133:	5b                   	pop    %ebx
  801134:	5e                   	pop    %esi
  801135:	5d                   	pop    %ebp
  801136:	c3                   	ret    

00801137 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80113a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	52                   	push   %edx
  801147:	50                   	push   %eax
  801148:	6a 09                	push   $0x9
  80114a:	e8 b4 fe ff ff       	call   801003 <syscall>
  80114f:	83 c4 18             	add    $0x18,%esp
}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801157:	6a 00                	push   $0x0
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	ff 75 0c             	pushl  0xc(%ebp)
  801160:	ff 75 08             	pushl  0x8(%ebp)
  801163:	6a 0a                	push   $0xa
  801165:	e8 99 fe ff ff       	call   801003 <syscall>
  80116a:	83 c4 18             	add    $0x18,%esp
}
  80116d:	c9                   	leave  
  80116e:	c3                   	ret    

0080116f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80116f:	55                   	push   %ebp
  801170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 0b                	push   $0xb
  80117e:	e8 80 fe ff ff       	call   801003 <syscall>
  801183:	83 c4 18             	add    $0x18,%esp
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 0c                	push   $0xc
  801197:	e8 67 fe ff ff       	call   801003 <syscall>
  80119c:	83 c4 18             	add    $0x18,%esp
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 0d                	push   $0xd
  8011b0:	e8 4e fe ff ff       	call   801003 <syscall>
  8011b5:	83 c4 18             	add    $0x18,%esp
}
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	ff 75 0c             	pushl  0xc(%ebp)
  8011c6:	ff 75 08             	pushl  0x8(%ebp)
  8011c9:	6a 11                	push   $0x11
  8011cb:	e8 33 fe ff ff       	call   801003 <syscall>
  8011d0:	83 c4 18             	add    $0x18,%esp
	return;
  8011d3:	90                   	nop
}
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	ff 75 0c             	pushl  0xc(%ebp)
  8011e2:	ff 75 08             	pushl  0x8(%ebp)
  8011e5:	6a 12                	push   $0x12
  8011e7:	e8 17 fe ff ff       	call   801003 <syscall>
  8011ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8011ef:	90                   	nop
}
  8011f0:	c9                   	leave  
  8011f1:	c3                   	ret    

008011f2 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011f2:	55                   	push   %ebp
  8011f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 0e                	push   $0xe
  801201:	e8 fd fd ff ff       	call   801003 <syscall>
  801206:	83 c4 18             	add    $0x18,%esp
}
  801209:	c9                   	leave  
  80120a:	c3                   	ret    

0080120b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80120b:	55                   	push   %ebp
  80120c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	ff 75 08             	pushl  0x8(%ebp)
  801219:	6a 0f                	push   $0xf
  80121b:	e8 e3 fd ff ff       	call   801003 <syscall>
  801220:	83 c4 18             	add    $0x18,%esp
}
  801223:	c9                   	leave  
  801224:	c3                   	ret    

00801225 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801225:	55                   	push   %ebp
  801226:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 10                	push   $0x10
  801234:	e8 ca fd ff ff       	call   801003 <syscall>
  801239:	83 c4 18             	add    $0x18,%esp
}
  80123c:	90                   	nop
  80123d:	c9                   	leave  
  80123e:	c3                   	ret    

0080123f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80123f:	55                   	push   %ebp
  801240:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 14                	push   $0x14
  80124e:	e8 b0 fd ff ff       	call   801003 <syscall>
  801253:	83 c4 18             	add    $0x18,%esp
}
  801256:	90                   	nop
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 15                	push   $0x15
  801268:	e8 96 fd ff ff       	call   801003 <syscall>
  80126d:	83 c4 18             	add    $0x18,%esp
}
  801270:	90                   	nop
  801271:	c9                   	leave  
  801272:	c3                   	ret    

00801273 <sys_cputc>:


void
sys_cputc(const char c)
{
  801273:	55                   	push   %ebp
  801274:	89 e5                	mov    %esp,%ebp
  801276:	83 ec 04             	sub    $0x4,%esp
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
  80127c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80127f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	50                   	push   %eax
  80128c:	6a 16                	push   $0x16
  80128e:	e8 70 fd ff ff       	call   801003 <syscall>
  801293:	83 c4 18             	add    $0x18,%esp
}
  801296:	90                   	nop
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 17                	push   $0x17
  8012a8:	e8 56 fd ff ff       	call   801003 <syscall>
  8012ad:	83 c4 18             	add    $0x18,%esp
}
  8012b0:	90                   	nop
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	ff 75 0c             	pushl  0xc(%ebp)
  8012c2:	50                   	push   %eax
  8012c3:	6a 18                	push   $0x18
  8012c5:	e8 39 fd ff ff       	call   801003 <syscall>
  8012ca:	83 c4 18             	add    $0x18,%esp
}
  8012cd:	c9                   	leave  
  8012ce:	c3                   	ret    

008012cf <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012cf:	55                   	push   %ebp
  8012d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	52                   	push   %edx
  8012df:	50                   	push   %eax
  8012e0:	6a 1b                	push   $0x1b
  8012e2:	e8 1c fd ff ff       	call   801003 <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	52                   	push   %edx
  8012fc:	50                   	push   %eax
  8012fd:	6a 19                	push   $0x19
  8012ff:	e8 ff fc ff ff       	call   801003 <syscall>
  801304:	83 c4 18             	add    $0x18,%esp
}
  801307:	90                   	nop
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80130d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	52                   	push   %edx
  80131a:	50                   	push   %eax
  80131b:	6a 1a                	push   $0x1a
  80131d:	e8 e1 fc ff ff       	call   801003 <syscall>
  801322:	83 c4 18             	add    $0x18,%esp
}
  801325:	90                   	nop
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
  80132b:	83 ec 04             	sub    $0x4,%esp
  80132e:	8b 45 10             	mov    0x10(%ebp),%eax
  801331:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801334:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801337:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	6a 00                	push   $0x0
  801340:	51                   	push   %ecx
  801341:	52                   	push   %edx
  801342:	ff 75 0c             	pushl  0xc(%ebp)
  801345:	50                   	push   %eax
  801346:	6a 1c                	push   $0x1c
  801348:	e8 b6 fc ff ff       	call   801003 <syscall>
  80134d:	83 c4 18             	add    $0x18,%esp
}
  801350:	c9                   	leave  
  801351:	c3                   	ret    

00801352 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801355:	8b 55 0c             	mov    0xc(%ebp),%edx
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	6a 00                	push   $0x0
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	52                   	push   %edx
  801362:	50                   	push   %eax
  801363:	6a 1d                	push   $0x1d
  801365:	e8 99 fc ff ff       	call   801003 <syscall>
  80136a:	83 c4 18             	add    $0x18,%esp
}
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801372:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801375:	8b 55 0c             	mov    0xc(%ebp),%edx
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	51                   	push   %ecx
  801380:	52                   	push   %edx
  801381:	50                   	push   %eax
  801382:	6a 1e                	push   $0x1e
  801384:	e8 7a fc ff ff       	call   801003 <syscall>
  801389:	83 c4 18             	add    $0x18,%esp
}
  80138c:	c9                   	leave  
  80138d:	c3                   	ret    

0080138e <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80138e:	55                   	push   %ebp
  80138f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801391:	8b 55 0c             	mov    0xc(%ebp),%edx
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	52                   	push   %edx
  80139e:	50                   	push   %eax
  80139f:	6a 1f                	push   $0x1f
  8013a1:	e8 5d fc ff ff       	call   801003 <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 20                	push   $0x20
  8013ba:	e8 44 fc ff ff       	call   801003 <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	ff 75 10             	pushl  0x10(%ebp)
  8013d1:	ff 75 0c             	pushl  0xc(%ebp)
  8013d4:	50                   	push   %eax
  8013d5:	6a 21                	push   $0x21
  8013d7:	e8 27 fc ff ff       	call   801003 <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	50                   	push   %eax
  8013f0:	6a 22                	push   $0x22
  8013f2:	e8 0c fc ff ff       	call   801003 <syscall>
  8013f7:	83 c4 18             	add    $0x18,%esp
}
  8013fa:	90                   	nop
  8013fb:	c9                   	leave  
  8013fc:	c3                   	ret    

008013fd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	50                   	push   %eax
  80140c:	6a 23                	push   $0x23
  80140e:	e8 f0 fb ff ff       	call   801003 <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	90                   	nop
  801417:	c9                   	leave  
  801418:	c3                   	ret    

00801419 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801419:	55                   	push   %ebp
  80141a:	89 e5                	mov    %esp,%ebp
  80141c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80141f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801422:	8d 50 04             	lea    0x4(%eax),%edx
  801425:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	52                   	push   %edx
  80142f:	50                   	push   %eax
  801430:	6a 24                	push   $0x24
  801432:	e8 cc fb ff ff       	call   801003 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
	return result;
  80143a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80143d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801440:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801443:	89 01                	mov    %eax,(%ecx)
  801445:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	c9                   	leave  
  80144c:	c2 04 00             	ret    $0x4

0080144f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	ff 75 10             	pushl  0x10(%ebp)
  801459:	ff 75 0c             	pushl  0xc(%ebp)
  80145c:	ff 75 08             	pushl  0x8(%ebp)
  80145f:	6a 13                	push   $0x13
  801461:	e8 9d fb ff ff       	call   801003 <syscall>
  801466:	83 c4 18             	add    $0x18,%esp
	return ;
  801469:	90                   	nop
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_rcr2>:
uint32 sys_rcr2()
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 25                	push   $0x25
  80147b:	e8 83 fb ff ff       	call   801003 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
  801488:	83 ec 04             	sub    $0x4,%esp
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801491:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	50                   	push   %eax
  80149e:	6a 26                	push   $0x26
  8014a0:	e8 5e fb ff ff       	call   801003 <syscall>
  8014a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a8:	90                   	nop
}
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <rsttst>:
void rsttst()
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 28                	push   $0x28
  8014ba:	e8 44 fb ff ff       	call   801003 <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c2:	90                   	nop
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 04             	sub    $0x4,%esp
  8014cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014d1:	8b 55 18             	mov    0x18(%ebp),%edx
  8014d4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d8:	52                   	push   %edx
  8014d9:	50                   	push   %eax
  8014da:	ff 75 10             	pushl  0x10(%ebp)
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	ff 75 08             	pushl  0x8(%ebp)
  8014e3:	6a 27                	push   $0x27
  8014e5:	e8 19 fb ff ff       	call   801003 <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ed:	90                   	nop
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <chktst>:
void chktst(uint32 n)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	ff 75 08             	pushl  0x8(%ebp)
  8014fe:	6a 29                	push   $0x29
  801500:	e8 fe fa ff ff       	call   801003 <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
	return ;
  801508:	90                   	nop
}
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <inctst>:

void inctst()
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 2a                	push   $0x2a
  80151a:	e8 e4 fa ff ff       	call   801003 <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
	return ;
  801522:	90                   	nop
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <gettst>:
uint32 gettst()
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 2b                	push   $0x2b
  801534:	e8 ca fa ff ff       	call   801003 <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
  801541:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 2c                	push   $0x2c
  801550:	e8 ae fa ff ff       	call   801003 <syscall>
  801555:	83 c4 18             	add    $0x18,%esp
  801558:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80155b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80155f:	75 07                	jne    801568 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801561:	b8 01 00 00 00       	mov    $0x1,%eax
  801566:	eb 05                	jmp    80156d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801568:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
  801572:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 2c                	push   $0x2c
  801581:	e8 7d fa ff ff       	call   801003 <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
  801589:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80158c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801590:	75 07                	jne    801599 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801592:	b8 01 00 00 00       	mov    $0x1,%eax
  801597:	eb 05                	jmp    80159e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801599:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159e:	c9                   	leave  
  80159f:	c3                   	ret    

008015a0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
  8015a3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 2c                	push   $0x2c
  8015b2:	e8 4c fa ff ff       	call   801003 <syscall>
  8015b7:	83 c4 18             	add    $0x18,%esp
  8015ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015bd:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015c1:	75 07                	jne    8015ca <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c8:	eb 05                	jmp    8015cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015cf:	c9                   	leave  
  8015d0:	c3                   	ret    

008015d1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
  8015d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 2c                	push   $0x2c
  8015e3:	e8 1b fa ff ff       	call   801003 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
  8015eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015ee:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015f2:	75 07                	jne    8015fb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f9:	eb 05                	jmp    801600 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	ff 75 08             	pushl  0x8(%ebp)
  801610:	6a 2d                	push   $0x2d
  801612:	e8 ec f9 ff ff       	call   801003 <syscall>
  801617:	83 c4 18             	add    $0x18,%esp
	return ;
  80161a:	90                   	nop
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    
  80161d:	66 90                	xchg   %ax,%ax
  80161f:	90                   	nop

00801620 <__udivdi3>:
  801620:	55                   	push   %ebp
  801621:	57                   	push   %edi
  801622:	56                   	push   %esi
  801623:	53                   	push   %ebx
  801624:	83 ec 1c             	sub    $0x1c,%esp
  801627:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80162b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80162f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801633:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801637:	89 ca                	mov    %ecx,%edx
  801639:	89 f8                	mov    %edi,%eax
  80163b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80163f:	85 f6                	test   %esi,%esi
  801641:	75 2d                	jne    801670 <__udivdi3+0x50>
  801643:	39 cf                	cmp    %ecx,%edi
  801645:	77 65                	ja     8016ac <__udivdi3+0x8c>
  801647:	89 fd                	mov    %edi,%ebp
  801649:	85 ff                	test   %edi,%edi
  80164b:	75 0b                	jne    801658 <__udivdi3+0x38>
  80164d:	b8 01 00 00 00       	mov    $0x1,%eax
  801652:	31 d2                	xor    %edx,%edx
  801654:	f7 f7                	div    %edi
  801656:	89 c5                	mov    %eax,%ebp
  801658:	31 d2                	xor    %edx,%edx
  80165a:	89 c8                	mov    %ecx,%eax
  80165c:	f7 f5                	div    %ebp
  80165e:	89 c1                	mov    %eax,%ecx
  801660:	89 d8                	mov    %ebx,%eax
  801662:	f7 f5                	div    %ebp
  801664:	89 cf                	mov    %ecx,%edi
  801666:	89 fa                	mov    %edi,%edx
  801668:	83 c4 1c             	add    $0x1c,%esp
  80166b:	5b                   	pop    %ebx
  80166c:	5e                   	pop    %esi
  80166d:	5f                   	pop    %edi
  80166e:	5d                   	pop    %ebp
  80166f:	c3                   	ret    
  801670:	39 ce                	cmp    %ecx,%esi
  801672:	77 28                	ja     80169c <__udivdi3+0x7c>
  801674:	0f bd fe             	bsr    %esi,%edi
  801677:	83 f7 1f             	xor    $0x1f,%edi
  80167a:	75 40                	jne    8016bc <__udivdi3+0x9c>
  80167c:	39 ce                	cmp    %ecx,%esi
  80167e:	72 0a                	jb     80168a <__udivdi3+0x6a>
  801680:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801684:	0f 87 9e 00 00 00    	ja     801728 <__udivdi3+0x108>
  80168a:	b8 01 00 00 00       	mov    $0x1,%eax
  80168f:	89 fa                	mov    %edi,%edx
  801691:	83 c4 1c             	add    $0x1c,%esp
  801694:	5b                   	pop    %ebx
  801695:	5e                   	pop    %esi
  801696:	5f                   	pop    %edi
  801697:	5d                   	pop    %ebp
  801698:	c3                   	ret    
  801699:	8d 76 00             	lea    0x0(%esi),%esi
  80169c:	31 ff                	xor    %edi,%edi
  80169e:	31 c0                	xor    %eax,%eax
  8016a0:	89 fa                	mov    %edi,%edx
  8016a2:	83 c4 1c             	add    $0x1c,%esp
  8016a5:	5b                   	pop    %ebx
  8016a6:	5e                   	pop    %esi
  8016a7:	5f                   	pop    %edi
  8016a8:	5d                   	pop    %ebp
  8016a9:	c3                   	ret    
  8016aa:	66 90                	xchg   %ax,%ax
  8016ac:	89 d8                	mov    %ebx,%eax
  8016ae:	f7 f7                	div    %edi
  8016b0:	31 ff                	xor    %edi,%edi
  8016b2:	89 fa                	mov    %edi,%edx
  8016b4:	83 c4 1c             	add    $0x1c,%esp
  8016b7:	5b                   	pop    %ebx
  8016b8:	5e                   	pop    %esi
  8016b9:	5f                   	pop    %edi
  8016ba:	5d                   	pop    %ebp
  8016bb:	c3                   	ret    
  8016bc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016c1:	89 eb                	mov    %ebp,%ebx
  8016c3:	29 fb                	sub    %edi,%ebx
  8016c5:	89 f9                	mov    %edi,%ecx
  8016c7:	d3 e6                	shl    %cl,%esi
  8016c9:	89 c5                	mov    %eax,%ebp
  8016cb:	88 d9                	mov    %bl,%cl
  8016cd:	d3 ed                	shr    %cl,%ebp
  8016cf:	89 e9                	mov    %ebp,%ecx
  8016d1:	09 f1                	or     %esi,%ecx
  8016d3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016d7:	89 f9                	mov    %edi,%ecx
  8016d9:	d3 e0                	shl    %cl,%eax
  8016db:	89 c5                	mov    %eax,%ebp
  8016dd:	89 d6                	mov    %edx,%esi
  8016df:	88 d9                	mov    %bl,%cl
  8016e1:	d3 ee                	shr    %cl,%esi
  8016e3:	89 f9                	mov    %edi,%ecx
  8016e5:	d3 e2                	shl    %cl,%edx
  8016e7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016eb:	88 d9                	mov    %bl,%cl
  8016ed:	d3 e8                	shr    %cl,%eax
  8016ef:	09 c2                	or     %eax,%edx
  8016f1:	89 d0                	mov    %edx,%eax
  8016f3:	89 f2                	mov    %esi,%edx
  8016f5:	f7 74 24 0c          	divl   0xc(%esp)
  8016f9:	89 d6                	mov    %edx,%esi
  8016fb:	89 c3                	mov    %eax,%ebx
  8016fd:	f7 e5                	mul    %ebp
  8016ff:	39 d6                	cmp    %edx,%esi
  801701:	72 19                	jb     80171c <__udivdi3+0xfc>
  801703:	74 0b                	je     801710 <__udivdi3+0xf0>
  801705:	89 d8                	mov    %ebx,%eax
  801707:	31 ff                	xor    %edi,%edi
  801709:	e9 58 ff ff ff       	jmp    801666 <__udivdi3+0x46>
  80170e:	66 90                	xchg   %ax,%ax
  801710:	8b 54 24 08          	mov    0x8(%esp),%edx
  801714:	89 f9                	mov    %edi,%ecx
  801716:	d3 e2                	shl    %cl,%edx
  801718:	39 c2                	cmp    %eax,%edx
  80171a:	73 e9                	jae    801705 <__udivdi3+0xe5>
  80171c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80171f:	31 ff                	xor    %edi,%edi
  801721:	e9 40 ff ff ff       	jmp    801666 <__udivdi3+0x46>
  801726:	66 90                	xchg   %ax,%ax
  801728:	31 c0                	xor    %eax,%eax
  80172a:	e9 37 ff ff ff       	jmp    801666 <__udivdi3+0x46>
  80172f:	90                   	nop

00801730 <__umoddi3>:
  801730:	55                   	push   %ebp
  801731:	57                   	push   %edi
  801732:	56                   	push   %esi
  801733:	53                   	push   %ebx
  801734:	83 ec 1c             	sub    $0x1c,%esp
  801737:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80173b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80173f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801743:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801747:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80174b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80174f:	89 f3                	mov    %esi,%ebx
  801751:	89 fa                	mov    %edi,%edx
  801753:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801757:	89 34 24             	mov    %esi,(%esp)
  80175a:	85 c0                	test   %eax,%eax
  80175c:	75 1a                	jne    801778 <__umoddi3+0x48>
  80175e:	39 f7                	cmp    %esi,%edi
  801760:	0f 86 a2 00 00 00    	jbe    801808 <__umoddi3+0xd8>
  801766:	89 c8                	mov    %ecx,%eax
  801768:	89 f2                	mov    %esi,%edx
  80176a:	f7 f7                	div    %edi
  80176c:	89 d0                	mov    %edx,%eax
  80176e:	31 d2                	xor    %edx,%edx
  801770:	83 c4 1c             	add    $0x1c,%esp
  801773:	5b                   	pop    %ebx
  801774:	5e                   	pop    %esi
  801775:	5f                   	pop    %edi
  801776:	5d                   	pop    %ebp
  801777:	c3                   	ret    
  801778:	39 f0                	cmp    %esi,%eax
  80177a:	0f 87 ac 00 00 00    	ja     80182c <__umoddi3+0xfc>
  801780:	0f bd e8             	bsr    %eax,%ebp
  801783:	83 f5 1f             	xor    $0x1f,%ebp
  801786:	0f 84 ac 00 00 00    	je     801838 <__umoddi3+0x108>
  80178c:	bf 20 00 00 00       	mov    $0x20,%edi
  801791:	29 ef                	sub    %ebp,%edi
  801793:	89 fe                	mov    %edi,%esi
  801795:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801799:	89 e9                	mov    %ebp,%ecx
  80179b:	d3 e0                	shl    %cl,%eax
  80179d:	89 d7                	mov    %edx,%edi
  80179f:	89 f1                	mov    %esi,%ecx
  8017a1:	d3 ef                	shr    %cl,%edi
  8017a3:	09 c7                	or     %eax,%edi
  8017a5:	89 e9                	mov    %ebp,%ecx
  8017a7:	d3 e2                	shl    %cl,%edx
  8017a9:	89 14 24             	mov    %edx,(%esp)
  8017ac:	89 d8                	mov    %ebx,%eax
  8017ae:	d3 e0                	shl    %cl,%eax
  8017b0:	89 c2                	mov    %eax,%edx
  8017b2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017b6:	d3 e0                	shl    %cl,%eax
  8017b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017bc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017c0:	89 f1                	mov    %esi,%ecx
  8017c2:	d3 e8                	shr    %cl,%eax
  8017c4:	09 d0                	or     %edx,%eax
  8017c6:	d3 eb                	shr    %cl,%ebx
  8017c8:	89 da                	mov    %ebx,%edx
  8017ca:	f7 f7                	div    %edi
  8017cc:	89 d3                	mov    %edx,%ebx
  8017ce:	f7 24 24             	mull   (%esp)
  8017d1:	89 c6                	mov    %eax,%esi
  8017d3:	89 d1                	mov    %edx,%ecx
  8017d5:	39 d3                	cmp    %edx,%ebx
  8017d7:	0f 82 87 00 00 00    	jb     801864 <__umoddi3+0x134>
  8017dd:	0f 84 91 00 00 00    	je     801874 <__umoddi3+0x144>
  8017e3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017e7:	29 f2                	sub    %esi,%edx
  8017e9:	19 cb                	sbb    %ecx,%ebx
  8017eb:	89 d8                	mov    %ebx,%eax
  8017ed:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017f1:	d3 e0                	shl    %cl,%eax
  8017f3:	89 e9                	mov    %ebp,%ecx
  8017f5:	d3 ea                	shr    %cl,%edx
  8017f7:	09 d0                	or     %edx,%eax
  8017f9:	89 e9                	mov    %ebp,%ecx
  8017fb:	d3 eb                	shr    %cl,%ebx
  8017fd:	89 da                	mov    %ebx,%edx
  8017ff:	83 c4 1c             	add    $0x1c,%esp
  801802:	5b                   	pop    %ebx
  801803:	5e                   	pop    %esi
  801804:	5f                   	pop    %edi
  801805:	5d                   	pop    %ebp
  801806:	c3                   	ret    
  801807:	90                   	nop
  801808:	89 fd                	mov    %edi,%ebp
  80180a:	85 ff                	test   %edi,%edi
  80180c:	75 0b                	jne    801819 <__umoddi3+0xe9>
  80180e:	b8 01 00 00 00       	mov    $0x1,%eax
  801813:	31 d2                	xor    %edx,%edx
  801815:	f7 f7                	div    %edi
  801817:	89 c5                	mov    %eax,%ebp
  801819:	89 f0                	mov    %esi,%eax
  80181b:	31 d2                	xor    %edx,%edx
  80181d:	f7 f5                	div    %ebp
  80181f:	89 c8                	mov    %ecx,%eax
  801821:	f7 f5                	div    %ebp
  801823:	89 d0                	mov    %edx,%eax
  801825:	e9 44 ff ff ff       	jmp    80176e <__umoddi3+0x3e>
  80182a:	66 90                	xchg   %ax,%ax
  80182c:	89 c8                	mov    %ecx,%eax
  80182e:	89 f2                	mov    %esi,%edx
  801830:	83 c4 1c             	add    $0x1c,%esp
  801833:	5b                   	pop    %ebx
  801834:	5e                   	pop    %esi
  801835:	5f                   	pop    %edi
  801836:	5d                   	pop    %ebp
  801837:	c3                   	ret    
  801838:	3b 04 24             	cmp    (%esp),%eax
  80183b:	72 06                	jb     801843 <__umoddi3+0x113>
  80183d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801841:	77 0f                	ja     801852 <__umoddi3+0x122>
  801843:	89 f2                	mov    %esi,%edx
  801845:	29 f9                	sub    %edi,%ecx
  801847:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80184b:	89 14 24             	mov    %edx,(%esp)
  80184e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801852:	8b 44 24 04          	mov    0x4(%esp),%eax
  801856:	8b 14 24             	mov    (%esp),%edx
  801859:	83 c4 1c             	add    $0x1c,%esp
  80185c:	5b                   	pop    %ebx
  80185d:	5e                   	pop    %esi
  80185e:	5f                   	pop    %edi
  80185f:	5d                   	pop    %ebp
  801860:	c3                   	ret    
  801861:	8d 76 00             	lea    0x0(%esi),%esi
  801864:	2b 04 24             	sub    (%esp),%eax
  801867:	19 fa                	sbb    %edi,%edx
  801869:	89 d1                	mov    %edx,%ecx
  80186b:	89 c6                	mov    %eax,%esi
  80186d:	e9 71 ff ff ff       	jmp    8017e3 <__umoddi3+0xb3>
  801872:	66 90                	xchg   %ax,%ax
  801874:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801878:	72 ea                	jb     801864 <__umoddi3+0x134>
  80187a:	89 d9                	mov    %ebx,%ecx
  80187c:	e9 62 ff ff ff       	jmp    8017e3 <__umoddi3+0xb3>
