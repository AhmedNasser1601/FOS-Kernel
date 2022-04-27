
obj/user/fos_data_on_stack:     file format elf32-i386


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
  800031:	e8 1e 00 00 00       	call   800054 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 40 18 80 00       	push   $0x801840
  800049:	e8 16 02 00 00       	call   800264 <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	return;	
  800051:	90                   	nop
}
  800052:	c9                   	leave  
  800053:	c3                   	ret    

00800054 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800054:	55                   	push   %ebp
  800055:	89 e5                	mov    %esp,%ebp
  800057:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80005a:	e8 03 10 00 00       	call   801062 <sys_getenvindex>
  80005f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800062:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800065:	89 d0                	mov    %edx,%eax
  800067:	c1 e0 02             	shl    $0x2,%eax
  80006a:	01 d0                	add    %edx,%eax
  80006c:	01 c0                	add    %eax,%eax
  80006e:	01 d0                	add    %edx,%eax
  800070:	01 c0                	add    %eax,%eax
  800072:	01 d0                	add    %edx,%eax
  800074:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80007b:	01 d0                	add    %edx,%eax
  80007d:	c1 e0 02             	shl    $0x2,%eax
  800080:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800085:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80008a:	a1 04 20 80 00       	mov    0x802004,%eax
  80008f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800095:	84 c0                	test   %al,%al
  800097:	74 0f                	je     8000a8 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800099:	a1 04 20 80 00       	mov    0x802004,%eax
  80009e:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000a3:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ac:	7e 0a                	jle    8000b8 <libmain+0x64>
		binaryname = argv[0];
  8000ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000b1:	8b 00                	mov    (%eax),%eax
  8000b3:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000b8:	83 ec 08             	sub    $0x8,%esp
  8000bb:	ff 75 0c             	pushl  0xc(%ebp)
  8000be:	ff 75 08             	pushl  0x8(%ebp)
  8000c1:	e8 72 ff ff ff       	call   800038 <_main>
  8000c6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000c9:	e8 2f 11 00 00       	call   8011fd <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	68 7c 18 80 00       	push   $0x80187c
  8000d6:	e8 5c 01 00 00       	call   800237 <cprintf>
  8000db:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000de:	a1 04 20 80 00       	mov    0x802004,%eax
  8000e3:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000e9:	a1 04 20 80 00       	mov    0x802004,%eax
  8000ee:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8000f4:	83 ec 04             	sub    $0x4,%esp
  8000f7:	52                   	push   %edx
  8000f8:	50                   	push   %eax
  8000f9:	68 a4 18 80 00       	push   $0x8018a4
  8000fe:	e8 34 01 00 00       	call   800237 <cprintf>
  800103:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800106:	a1 04 20 80 00       	mov    0x802004,%eax
  80010b:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800111:	83 ec 08             	sub    $0x8,%esp
  800114:	50                   	push   %eax
  800115:	68 c9 18 80 00       	push   $0x8018c9
  80011a:	e8 18 01 00 00       	call   800237 <cprintf>
  80011f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800122:	83 ec 0c             	sub    $0xc,%esp
  800125:	68 7c 18 80 00       	push   $0x80187c
  80012a:	e8 08 01 00 00       	call   800237 <cprintf>
  80012f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800132:	e8 e0 10 00 00       	call   801217 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800137:	e8 19 00 00 00       	call   800155 <exit>
}
  80013c:	90                   	nop
  80013d:	c9                   	leave  
  80013e:	c3                   	ret    

0080013f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80013f:	55                   	push   %ebp
  800140:	89 e5                	mov    %esp,%ebp
  800142:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800145:	83 ec 0c             	sub    $0xc,%esp
  800148:	6a 00                	push   $0x0
  80014a:	e8 df 0e 00 00       	call   80102e <sys_env_destroy>
  80014f:	83 c4 10             	add    $0x10,%esp
}
  800152:	90                   	nop
  800153:	c9                   	leave  
  800154:	c3                   	ret    

00800155 <exit>:

void
exit(void)
{
  800155:	55                   	push   %ebp
  800156:	89 e5                	mov    %esp,%ebp
  800158:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80015b:	e8 34 0f 00 00       	call   801094 <sys_env_exit>
}
  800160:	90                   	nop
  800161:	c9                   	leave  
  800162:	c3                   	ret    

00800163 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800163:	55                   	push   %ebp
  800164:	89 e5                	mov    %esp,%ebp
  800166:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80016c:	8b 00                	mov    (%eax),%eax
  80016e:	8d 48 01             	lea    0x1(%eax),%ecx
  800171:	8b 55 0c             	mov    0xc(%ebp),%edx
  800174:	89 0a                	mov    %ecx,(%edx)
  800176:	8b 55 08             	mov    0x8(%ebp),%edx
  800179:	88 d1                	mov    %dl,%cl
  80017b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80017e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800182:	8b 45 0c             	mov    0xc(%ebp),%eax
  800185:	8b 00                	mov    (%eax),%eax
  800187:	3d ff 00 00 00       	cmp    $0xff,%eax
  80018c:	75 2c                	jne    8001ba <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80018e:	a0 08 20 80 00       	mov    0x802008,%al
  800193:	0f b6 c0             	movzbl %al,%eax
  800196:	8b 55 0c             	mov    0xc(%ebp),%edx
  800199:	8b 12                	mov    (%edx),%edx
  80019b:	89 d1                	mov    %edx,%ecx
  80019d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a0:	83 c2 08             	add    $0x8,%edx
  8001a3:	83 ec 04             	sub    $0x4,%esp
  8001a6:	50                   	push   %eax
  8001a7:	51                   	push   %ecx
  8001a8:	52                   	push   %edx
  8001a9:	e8 3e 0e 00 00       	call   800fec <sys_cputs>
  8001ae:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001bd:	8b 40 04             	mov    0x4(%eax),%eax
  8001c0:	8d 50 01             	lea    0x1(%eax),%edx
  8001c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001c9:	90                   	nop
  8001ca:	c9                   	leave  
  8001cb:	c3                   	ret    

008001cc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001cc:	55                   	push   %ebp
  8001cd:	89 e5                	mov    %esp,%ebp
  8001cf:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001d5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001dc:	00 00 00 
	b.cnt = 0;
  8001df:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001e6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001e9:	ff 75 0c             	pushl  0xc(%ebp)
  8001ec:	ff 75 08             	pushl  0x8(%ebp)
  8001ef:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001f5:	50                   	push   %eax
  8001f6:	68 63 01 80 00       	push   $0x800163
  8001fb:	e8 11 02 00 00       	call   800411 <vprintfmt>
  800200:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800203:	a0 08 20 80 00       	mov    0x802008,%al
  800208:	0f b6 c0             	movzbl %al,%eax
  80020b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800211:	83 ec 04             	sub    $0x4,%esp
  800214:	50                   	push   %eax
  800215:	52                   	push   %edx
  800216:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80021c:	83 c0 08             	add    $0x8,%eax
  80021f:	50                   	push   %eax
  800220:	e8 c7 0d 00 00       	call   800fec <sys_cputs>
  800225:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800228:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80022f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800235:	c9                   	leave  
  800236:	c3                   	ret    

00800237 <cprintf>:

int cprintf(const char *fmt, ...) {
  800237:	55                   	push   %ebp
  800238:	89 e5                	mov    %esp,%ebp
  80023a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80023d:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800244:	8d 45 0c             	lea    0xc(%ebp),%eax
  800247:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80024a:	8b 45 08             	mov    0x8(%ebp),%eax
  80024d:	83 ec 08             	sub    $0x8,%esp
  800250:	ff 75 f4             	pushl  -0xc(%ebp)
  800253:	50                   	push   %eax
  800254:	e8 73 ff ff ff       	call   8001cc <vcprintf>
  800259:	83 c4 10             	add    $0x10,%esp
  80025c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80025f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800262:	c9                   	leave  
  800263:	c3                   	ret    

00800264 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800264:	55                   	push   %ebp
  800265:	89 e5                	mov    %esp,%ebp
  800267:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80026a:	e8 8e 0f 00 00       	call   8011fd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80026f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800272:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800275:	8b 45 08             	mov    0x8(%ebp),%eax
  800278:	83 ec 08             	sub    $0x8,%esp
  80027b:	ff 75 f4             	pushl  -0xc(%ebp)
  80027e:	50                   	push   %eax
  80027f:	e8 48 ff ff ff       	call   8001cc <vcprintf>
  800284:	83 c4 10             	add    $0x10,%esp
  800287:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80028a:	e8 88 0f 00 00       	call   801217 <sys_enable_interrupt>
	return cnt;
  80028f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800292:	c9                   	leave  
  800293:	c3                   	ret    

00800294 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800294:	55                   	push   %ebp
  800295:	89 e5                	mov    %esp,%ebp
  800297:	53                   	push   %ebx
  800298:	83 ec 14             	sub    $0x14,%esp
  80029b:	8b 45 10             	mov    0x10(%ebp),%eax
  80029e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8002a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002a7:	8b 45 18             	mov    0x18(%ebp),%eax
  8002aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8002af:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002b2:	77 55                	ja     800309 <printnum+0x75>
  8002b4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002b7:	72 05                	jb     8002be <printnum+0x2a>
  8002b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002bc:	77 4b                	ja     800309 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002be:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002c4:	8b 45 18             	mov    0x18(%ebp),%eax
  8002c7:	ba 00 00 00 00       	mov    $0x0,%edx
  8002cc:	52                   	push   %edx
  8002cd:	50                   	push   %eax
  8002ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8002d4:	e8 03 13 00 00       	call   8015dc <__udivdi3>
  8002d9:	83 c4 10             	add    $0x10,%esp
  8002dc:	83 ec 04             	sub    $0x4,%esp
  8002df:	ff 75 20             	pushl  0x20(%ebp)
  8002e2:	53                   	push   %ebx
  8002e3:	ff 75 18             	pushl  0x18(%ebp)
  8002e6:	52                   	push   %edx
  8002e7:	50                   	push   %eax
  8002e8:	ff 75 0c             	pushl  0xc(%ebp)
  8002eb:	ff 75 08             	pushl  0x8(%ebp)
  8002ee:	e8 a1 ff ff ff       	call   800294 <printnum>
  8002f3:	83 c4 20             	add    $0x20,%esp
  8002f6:	eb 1a                	jmp    800312 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8002f8:	83 ec 08             	sub    $0x8,%esp
  8002fb:	ff 75 0c             	pushl  0xc(%ebp)
  8002fe:	ff 75 20             	pushl  0x20(%ebp)
  800301:	8b 45 08             	mov    0x8(%ebp),%eax
  800304:	ff d0                	call   *%eax
  800306:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800309:	ff 4d 1c             	decl   0x1c(%ebp)
  80030c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800310:	7f e6                	jg     8002f8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800312:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800315:	bb 00 00 00 00       	mov    $0x0,%ebx
  80031a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800320:	53                   	push   %ebx
  800321:	51                   	push   %ecx
  800322:	52                   	push   %edx
  800323:	50                   	push   %eax
  800324:	e8 c3 13 00 00       	call   8016ec <__umoddi3>
  800329:	83 c4 10             	add    $0x10,%esp
  80032c:	05 f4 1a 80 00       	add    $0x801af4,%eax
  800331:	8a 00                	mov    (%eax),%al
  800333:	0f be c0             	movsbl %al,%eax
  800336:	83 ec 08             	sub    $0x8,%esp
  800339:	ff 75 0c             	pushl  0xc(%ebp)
  80033c:	50                   	push   %eax
  80033d:	8b 45 08             	mov    0x8(%ebp),%eax
  800340:	ff d0                	call   *%eax
  800342:	83 c4 10             	add    $0x10,%esp
}
  800345:	90                   	nop
  800346:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800349:	c9                   	leave  
  80034a:	c3                   	ret    

0080034b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80034b:	55                   	push   %ebp
  80034c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80034e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800352:	7e 1c                	jle    800370 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800354:	8b 45 08             	mov    0x8(%ebp),%eax
  800357:	8b 00                	mov    (%eax),%eax
  800359:	8d 50 08             	lea    0x8(%eax),%edx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	89 10                	mov    %edx,(%eax)
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	8b 00                	mov    (%eax),%eax
  800366:	83 e8 08             	sub    $0x8,%eax
  800369:	8b 50 04             	mov    0x4(%eax),%edx
  80036c:	8b 00                	mov    (%eax),%eax
  80036e:	eb 40                	jmp    8003b0 <getuint+0x65>
	else if (lflag)
  800370:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800374:	74 1e                	je     800394 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800376:	8b 45 08             	mov    0x8(%ebp),%eax
  800379:	8b 00                	mov    (%eax),%eax
  80037b:	8d 50 04             	lea    0x4(%eax),%edx
  80037e:	8b 45 08             	mov    0x8(%ebp),%eax
  800381:	89 10                	mov    %edx,(%eax)
  800383:	8b 45 08             	mov    0x8(%ebp),%eax
  800386:	8b 00                	mov    (%eax),%eax
  800388:	83 e8 04             	sub    $0x4,%eax
  80038b:	8b 00                	mov    (%eax),%eax
  80038d:	ba 00 00 00 00       	mov    $0x0,%edx
  800392:	eb 1c                	jmp    8003b0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800394:	8b 45 08             	mov    0x8(%ebp),%eax
  800397:	8b 00                	mov    (%eax),%eax
  800399:	8d 50 04             	lea    0x4(%eax),%edx
  80039c:	8b 45 08             	mov    0x8(%ebp),%eax
  80039f:	89 10                	mov    %edx,(%eax)
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	8b 00                	mov    (%eax),%eax
  8003a6:	83 e8 04             	sub    $0x4,%eax
  8003a9:	8b 00                	mov    (%eax),%eax
  8003ab:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003b0:	5d                   	pop    %ebp
  8003b1:	c3                   	ret    

008003b2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003b2:	55                   	push   %ebp
  8003b3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003b9:	7e 1c                	jle    8003d7 <getint+0x25>
		return va_arg(*ap, long long);
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	8b 00                	mov    (%eax),%eax
  8003c0:	8d 50 08             	lea    0x8(%eax),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	89 10                	mov    %edx,(%eax)
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	83 e8 08             	sub    $0x8,%eax
  8003d0:	8b 50 04             	mov    0x4(%eax),%edx
  8003d3:	8b 00                	mov    (%eax),%eax
  8003d5:	eb 38                	jmp    80040f <getint+0x5d>
	else if (lflag)
  8003d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003db:	74 1a                	je     8003f7 <getint+0x45>
		return va_arg(*ap, long);
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	8d 50 04             	lea    0x4(%eax),%edx
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	89 10                	mov    %edx,(%eax)
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	83 e8 04             	sub    $0x4,%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	99                   	cltd   
  8003f5:	eb 18                	jmp    80040f <getint+0x5d>
	else
		return va_arg(*ap, int);
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	8d 50 04             	lea    0x4(%eax),%edx
  8003ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800402:	89 10                	mov    %edx,(%eax)
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	83 e8 04             	sub    $0x4,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	99                   	cltd   
}
  80040f:	5d                   	pop    %ebp
  800410:	c3                   	ret    

00800411 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800411:	55                   	push   %ebp
  800412:	89 e5                	mov    %esp,%ebp
  800414:	56                   	push   %esi
  800415:	53                   	push   %ebx
  800416:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800419:	eb 17                	jmp    800432 <vprintfmt+0x21>
			if (ch == '\0')
  80041b:	85 db                	test   %ebx,%ebx
  80041d:	0f 84 af 03 00 00    	je     8007d2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800423:	83 ec 08             	sub    $0x8,%esp
  800426:	ff 75 0c             	pushl  0xc(%ebp)
  800429:	53                   	push   %ebx
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	ff d0                	call   *%eax
  80042f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800432:	8b 45 10             	mov    0x10(%ebp),%eax
  800435:	8d 50 01             	lea    0x1(%eax),%edx
  800438:	89 55 10             	mov    %edx,0x10(%ebp)
  80043b:	8a 00                	mov    (%eax),%al
  80043d:	0f b6 d8             	movzbl %al,%ebx
  800440:	83 fb 25             	cmp    $0x25,%ebx
  800443:	75 d6                	jne    80041b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800445:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800449:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800450:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800457:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80045e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800465:	8b 45 10             	mov    0x10(%ebp),%eax
  800468:	8d 50 01             	lea    0x1(%eax),%edx
  80046b:	89 55 10             	mov    %edx,0x10(%ebp)
  80046e:	8a 00                	mov    (%eax),%al
  800470:	0f b6 d8             	movzbl %al,%ebx
  800473:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800476:	83 f8 55             	cmp    $0x55,%eax
  800479:	0f 87 2b 03 00 00    	ja     8007aa <vprintfmt+0x399>
  80047f:	8b 04 85 18 1b 80 00 	mov    0x801b18(,%eax,4),%eax
  800486:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800488:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80048c:	eb d7                	jmp    800465 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80048e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800492:	eb d1                	jmp    800465 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800494:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80049b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80049e:	89 d0                	mov    %edx,%eax
  8004a0:	c1 e0 02             	shl    $0x2,%eax
  8004a3:	01 d0                	add    %edx,%eax
  8004a5:	01 c0                	add    %eax,%eax
  8004a7:	01 d8                	add    %ebx,%eax
  8004a9:	83 e8 30             	sub    $0x30,%eax
  8004ac:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004af:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b2:	8a 00                	mov    (%eax),%al
  8004b4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004b7:	83 fb 2f             	cmp    $0x2f,%ebx
  8004ba:	7e 3e                	jle    8004fa <vprintfmt+0xe9>
  8004bc:	83 fb 39             	cmp    $0x39,%ebx
  8004bf:	7f 39                	jg     8004fa <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004c1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004c4:	eb d5                	jmp    80049b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c9:	83 c0 04             	add    $0x4,%eax
  8004cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8004cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d2:	83 e8 04             	sub    $0x4,%eax
  8004d5:	8b 00                	mov    (%eax),%eax
  8004d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004da:	eb 1f                	jmp    8004fb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004dc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004e0:	79 83                	jns    800465 <vprintfmt+0x54>
				width = 0;
  8004e2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004e9:	e9 77 ff ff ff       	jmp    800465 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004ee:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004f5:	e9 6b ff ff ff       	jmp    800465 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8004fa:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8004fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004ff:	0f 89 60 ff ff ff    	jns    800465 <vprintfmt+0x54>
				width = precision, precision = -1;
  800505:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800508:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80050b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800512:	e9 4e ff ff ff       	jmp    800465 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800517:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80051a:	e9 46 ff ff ff       	jmp    800465 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80051f:	8b 45 14             	mov    0x14(%ebp),%eax
  800522:	83 c0 04             	add    $0x4,%eax
  800525:	89 45 14             	mov    %eax,0x14(%ebp)
  800528:	8b 45 14             	mov    0x14(%ebp),%eax
  80052b:	83 e8 04             	sub    $0x4,%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	83 ec 08             	sub    $0x8,%esp
  800533:	ff 75 0c             	pushl  0xc(%ebp)
  800536:	50                   	push   %eax
  800537:	8b 45 08             	mov    0x8(%ebp),%eax
  80053a:	ff d0                	call   *%eax
  80053c:	83 c4 10             	add    $0x10,%esp
			break;
  80053f:	e9 89 02 00 00       	jmp    8007cd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800544:	8b 45 14             	mov    0x14(%ebp),%eax
  800547:	83 c0 04             	add    $0x4,%eax
  80054a:	89 45 14             	mov    %eax,0x14(%ebp)
  80054d:	8b 45 14             	mov    0x14(%ebp),%eax
  800550:	83 e8 04             	sub    $0x4,%eax
  800553:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800555:	85 db                	test   %ebx,%ebx
  800557:	79 02                	jns    80055b <vprintfmt+0x14a>
				err = -err;
  800559:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80055b:	83 fb 64             	cmp    $0x64,%ebx
  80055e:	7f 0b                	jg     80056b <vprintfmt+0x15a>
  800560:	8b 34 9d 60 19 80 00 	mov    0x801960(,%ebx,4),%esi
  800567:	85 f6                	test   %esi,%esi
  800569:	75 19                	jne    800584 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80056b:	53                   	push   %ebx
  80056c:	68 05 1b 80 00       	push   $0x801b05
  800571:	ff 75 0c             	pushl  0xc(%ebp)
  800574:	ff 75 08             	pushl  0x8(%ebp)
  800577:	e8 5e 02 00 00       	call   8007da <printfmt>
  80057c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80057f:	e9 49 02 00 00       	jmp    8007cd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800584:	56                   	push   %esi
  800585:	68 0e 1b 80 00       	push   $0x801b0e
  80058a:	ff 75 0c             	pushl  0xc(%ebp)
  80058d:	ff 75 08             	pushl  0x8(%ebp)
  800590:	e8 45 02 00 00       	call   8007da <printfmt>
  800595:	83 c4 10             	add    $0x10,%esp
			break;
  800598:	e9 30 02 00 00       	jmp    8007cd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80059d:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a0:	83 c0 04             	add    $0x4,%eax
  8005a3:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a9:	83 e8 04             	sub    $0x4,%eax
  8005ac:	8b 30                	mov    (%eax),%esi
  8005ae:	85 f6                	test   %esi,%esi
  8005b0:	75 05                	jne    8005b7 <vprintfmt+0x1a6>
				p = "(null)";
  8005b2:	be 11 1b 80 00       	mov    $0x801b11,%esi
			if (width > 0 && padc != '-')
  8005b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005bb:	7e 6d                	jle    80062a <vprintfmt+0x219>
  8005bd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005c1:	74 67                	je     80062a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c6:	83 ec 08             	sub    $0x8,%esp
  8005c9:	50                   	push   %eax
  8005ca:	56                   	push   %esi
  8005cb:	e8 0c 03 00 00       	call   8008dc <strnlen>
  8005d0:	83 c4 10             	add    $0x10,%esp
  8005d3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005d6:	eb 16                	jmp    8005ee <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005d8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005dc:	83 ec 08             	sub    $0x8,%esp
  8005df:	ff 75 0c             	pushl  0xc(%ebp)
  8005e2:	50                   	push   %eax
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	ff d0                	call   *%eax
  8005e8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005eb:	ff 4d e4             	decl   -0x1c(%ebp)
  8005ee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f2:	7f e4                	jg     8005d8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005f4:	eb 34                	jmp    80062a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8005f6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8005fa:	74 1c                	je     800618 <vprintfmt+0x207>
  8005fc:	83 fb 1f             	cmp    $0x1f,%ebx
  8005ff:	7e 05                	jle    800606 <vprintfmt+0x1f5>
  800601:	83 fb 7e             	cmp    $0x7e,%ebx
  800604:	7e 12                	jle    800618 <vprintfmt+0x207>
					putch('?', putdat);
  800606:	83 ec 08             	sub    $0x8,%esp
  800609:	ff 75 0c             	pushl  0xc(%ebp)
  80060c:	6a 3f                	push   $0x3f
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	ff d0                	call   *%eax
  800613:	83 c4 10             	add    $0x10,%esp
  800616:	eb 0f                	jmp    800627 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	ff 75 0c             	pushl  0xc(%ebp)
  80061e:	53                   	push   %ebx
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	ff d0                	call   *%eax
  800624:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800627:	ff 4d e4             	decl   -0x1c(%ebp)
  80062a:	89 f0                	mov    %esi,%eax
  80062c:	8d 70 01             	lea    0x1(%eax),%esi
  80062f:	8a 00                	mov    (%eax),%al
  800631:	0f be d8             	movsbl %al,%ebx
  800634:	85 db                	test   %ebx,%ebx
  800636:	74 24                	je     80065c <vprintfmt+0x24b>
  800638:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80063c:	78 b8                	js     8005f6 <vprintfmt+0x1e5>
  80063e:	ff 4d e0             	decl   -0x20(%ebp)
  800641:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800645:	79 af                	jns    8005f6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800647:	eb 13                	jmp    80065c <vprintfmt+0x24b>
				putch(' ', putdat);
  800649:	83 ec 08             	sub    $0x8,%esp
  80064c:	ff 75 0c             	pushl  0xc(%ebp)
  80064f:	6a 20                	push   $0x20
  800651:	8b 45 08             	mov    0x8(%ebp),%eax
  800654:	ff d0                	call   *%eax
  800656:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800659:	ff 4d e4             	decl   -0x1c(%ebp)
  80065c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800660:	7f e7                	jg     800649 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800662:	e9 66 01 00 00       	jmp    8007cd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800667:	83 ec 08             	sub    $0x8,%esp
  80066a:	ff 75 e8             	pushl  -0x18(%ebp)
  80066d:	8d 45 14             	lea    0x14(%ebp),%eax
  800670:	50                   	push   %eax
  800671:	e8 3c fd ff ff       	call   8003b2 <getint>
  800676:	83 c4 10             	add    $0x10,%esp
  800679:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80067c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80067f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800682:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800685:	85 d2                	test   %edx,%edx
  800687:	79 23                	jns    8006ac <vprintfmt+0x29b>
				putch('-', putdat);
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	ff 75 0c             	pushl  0xc(%ebp)
  80068f:	6a 2d                	push   $0x2d
  800691:	8b 45 08             	mov    0x8(%ebp),%eax
  800694:	ff d0                	call   *%eax
  800696:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800699:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80069f:	f7 d8                	neg    %eax
  8006a1:	83 d2 00             	adc    $0x0,%edx
  8006a4:	f7 da                	neg    %edx
  8006a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006ac:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006b3:	e9 bc 00 00 00       	jmp    800774 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	ff 75 e8             	pushl  -0x18(%ebp)
  8006be:	8d 45 14             	lea    0x14(%ebp),%eax
  8006c1:	50                   	push   %eax
  8006c2:	e8 84 fc ff ff       	call   80034b <getuint>
  8006c7:	83 c4 10             	add    $0x10,%esp
  8006ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006cd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006d0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006d7:	e9 98 00 00 00       	jmp    800774 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006dc:	83 ec 08             	sub    $0x8,%esp
  8006df:	ff 75 0c             	pushl  0xc(%ebp)
  8006e2:	6a 58                	push   $0x58
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	ff d0                	call   *%eax
  8006e9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	6a 58                	push   $0x58
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	ff d0                	call   *%eax
  8006f9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 0c             	pushl  0xc(%ebp)
  800702:	6a 58                	push   $0x58
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	ff d0                	call   *%eax
  800709:	83 c4 10             	add    $0x10,%esp
			break;
  80070c:	e9 bc 00 00 00       	jmp    8007cd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800711:	83 ec 08             	sub    $0x8,%esp
  800714:	ff 75 0c             	pushl  0xc(%ebp)
  800717:	6a 30                	push   $0x30
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	ff d0                	call   *%eax
  80071e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	6a 78                	push   $0x78
  800729:	8b 45 08             	mov    0x8(%ebp),%eax
  80072c:	ff d0                	call   *%eax
  80072e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800731:	8b 45 14             	mov    0x14(%ebp),%eax
  800734:	83 c0 04             	add    $0x4,%eax
  800737:	89 45 14             	mov    %eax,0x14(%ebp)
  80073a:	8b 45 14             	mov    0x14(%ebp),%eax
  80073d:	83 e8 04             	sub    $0x4,%eax
  800740:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800742:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800745:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80074c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800753:	eb 1f                	jmp    800774 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 e8             	pushl  -0x18(%ebp)
  80075b:	8d 45 14             	lea    0x14(%ebp),%eax
  80075e:	50                   	push   %eax
  80075f:	e8 e7 fb ff ff       	call   80034b <getuint>
  800764:	83 c4 10             	add    $0x10,%esp
  800767:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80076d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800774:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800778:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077b:	83 ec 04             	sub    $0x4,%esp
  80077e:	52                   	push   %edx
  80077f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800782:	50                   	push   %eax
  800783:	ff 75 f4             	pushl  -0xc(%ebp)
  800786:	ff 75 f0             	pushl  -0x10(%ebp)
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	ff 75 08             	pushl  0x8(%ebp)
  80078f:	e8 00 fb ff ff       	call   800294 <printnum>
  800794:	83 c4 20             	add    $0x20,%esp
			break;
  800797:	eb 34                	jmp    8007cd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	53                   	push   %ebx
  8007a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a3:	ff d0                	call   *%eax
  8007a5:	83 c4 10             	add    $0x10,%esp
			break;
  8007a8:	eb 23                	jmp    8007cd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007aa:	83 ec 08             	sub    $0x8,%esp
  8007ad:	ff 75 0c             	pushl  0xc(%ebp)
  8007b0:	6a 25                	push   $0x25
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	ff d0                	call   *%eax
  8007b7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007ba:	ff 4d 10             	decl   0x10(%ebp)
  8007bd:	eb 03                	jmp    8007c2 <vprintfmt+0x3b1>
  8007bf:	ff 4d 10             	decl   0x10(%ebp)
  8007c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c5:	48                   	dec    %eax
  8007c6:	8a 00                	mov    (%eax),%al
  8007c8:	3c 25                	cmp    $0x25,%al
  8007ca:	75 f3                	jne    8007bf <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007cc:	90                   	nop
		}
	}
  8007cd:	e9 47 fc ff ff       	jmp    800419 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007d2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007d6:	5b                   	pop    %ebx
  8007d7:	5e                   	pop    %esi
  8007d8:	5d                   	pop    %ebp
  8007d9:	c3                   	ret    

008007da <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007da:	55                   	push   %ebp
  8007db:	89 e5                	mov    %esp,%ebp
  8007dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007e0:	8d 45 10             	lea    0x10(%ebp),%eax
  8007e3:	83 c0 04             	add    $0x4,%eax
  8007e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ef:	50                   	push   %eax
  8007f0:	ff 75 0c             	pushl  0xc(%ebp)
  8007f3:	ff 75 08             	pushl  0x8(%ebp)
  8007f6:	e8 16 fc ff ff       	call   800411 <vprintfmt>
  8007fb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8007fe:	90                   	nop
  8007ff:	c9                   	leave  
  800800:	c3                   	ret    

00800801 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800801:	55                   	push   %ebp
  800802:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800804:	8b 45 0c             	mov    0xc(%ebp),%eax
  800807:	8b 40 08             	mov    0x8(%eax),%eax
  80080a:	8d 50 01             	lea    0x1(%eax),%edx
  80080d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800810:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800813:	8b 45 0c             	mov    0xc(%ebp),%eax
  800816:	8b 10                	mov    (%eax),%edx
  800818:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081b:	8b 40 04             	mov    0x4(%eax),%eax
  80081e:	39 c2                	cmp    %eax,%edx
  800820:	73 12                	jae    800834 <sprintputch+0x33>
		*b->buf++ = ch;
  800822:	8b 45 0c             	mov    0xc(%ebp),%eax
  800825:	8b 00                	mov    (%eax),%eax
  800827:	8d 48 01             	lea    0x1(%eax),%ecx
  80082a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80082d:	89 0a                	mov    %ecx,(%edx)
  80082f:	8b 55 08             	mov    0x8(%ebp),%edx
  800832:	88 10                	mov    %dl,(%eax)
}
  800834:	90                   	nop
  800835:	5d                   	pop    %ebp
  800836:	c3                   	ret    

00800837 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800837:	55                   	push   %ebp
  800838:	89 e5                	mov    %esp,%ebp
  80083a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800843:	8b 45 0c             	mov    0xc(%ebp),%eax
  800846:	8d 50 ff             	lea    -0x1(%eax),%edx
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	01 d0                	add    %edx,%eax
  80084e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800851:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800858:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80085c:	74 06                	je     800864 <vsnprintf+0x2d>
  80085e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800862:	7f 07                	jg     80086b <vsnprintf+0x34>
		return -E_INVAL;
  800864:	b8 03 00 00 00       	mov    $0x3,%eax
  800869:	eb 20                	jmp    80088b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80086b:	ff 75 14             	pushl  0x14(%ebp)
  80086e:	ff 75 10             	pushl  0x10(%ebp)
  800871:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800874:	50                   	push   %eax
  800875:	68 01 08 80 00       	push   $0x800801
  80087a:	e8 92 fb ff ff       	call   800411 <vprintfmt>
  80087f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800882:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800885:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800888:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80088b:	c9                   	leave  
  80088c:	c3                   	ret    

0080088d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80088d:	55                   	push   %ebp
  80088e:	89 e5                	mov    %esp,%ebp
  800890:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800893:	8d 45 10             	lea    0x10(%ebp),%eax
  800896:	83 c0 04             	add    $0x4,%eax
  800899:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80089c:	8b 45 10             	mov    0x10(%ebp),%eax
  80089f:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a2:	50                   	push   %eax
  8008a3:	ff 75 0c             	pushl  0xc(%ebp)
  8008a6:	ff 75 08             	pushl  0x8(%ebp)
  8008a9:	e8 89 ff ff ff       	call   800837 <vsnprintf>
  8008ae:	83 c4 10             	add    $0x10,%esp
  8008b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008b7:	c9                   	leave  
  8008b8:	c3                   	ret    

008008b9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
  8008bc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008c6:	eb 06                	jmp    8008ce <strlen+0x15>
		n++;
  8008c8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008cb:	ff 45 08             	incl   0x8(%ebp)
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	8a 00                	mov    (%eax),%al
  8008d3:	84 c0                	test   %al,%al
  8008d5:	75 f1                	jne    8008c8 <strlen+0xf>
		n++;
	return n;
  8008d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008da:	c9                   	leave  
  8008db:	c3                   	ret    

008008dc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008e9:	eb 09                	jmp    8008f4 <strnlen+0x18>
		n++;
  8008eb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008ee:	ff 45 08             	incl   0x8(%ebp)
  8008f1:	ff 4d 0c             	decl   0xc(%ebp)
  8008f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f8:	74 09                	je     800903 <strnlen+0x27>
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	8a 00                	mov    (%eax),%al
  8008ff:	84 c0                	test   %al,%al
  800901:	75 e8                	jne    8008eb <strnlen+0xf>
		n++;
	return n;
  800903:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800906:	c9                   	leave  
  800907:	c3                   	ret    

00800908 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800908:	55                   	push   %ebp
  800909:	89 e5                	mov    %esp,%ebp
  80090b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800914:	90                   	nop
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	8d 50 01             	lea    0x1(%eax),%edx
  80091b:	89 55 08             	mov    %edx,0x8(%ebp)
  80091e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800921:	8d 4a 01             	lea    0x1(%edx),%ecx
  800924:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800927:	8a 12                	mov    (%edx),%dl
  800929:	88 10                	mov    %dl,(%eax)
  80092b:	8a 00                	mov    (%eax),%al
  80092d:	84 c0                	test   %al,%al
  80092f:	75 e4                	jne    800915 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800931:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800934:	c9                   	leave  
  800935:	c3                   	ret    

00800936 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800936:	55                   	push   %ebp
  800937:	89 e5                	mov    %esp,%ebp
  800939:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80093c:	8b 45 08             	mov    0x8(%ebp),%eax
  80093f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800942:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800949:	eb 1f                	jmp    80096a <strncpy+0x34>
		*dst++ = *src;
  80094b:	8b 45 08             	mov    0x8(%ebp),%eax
  80094e:	8d 50 01             	lea    0x1(%eax),%edx
  800951:	89 55 08             	mov    %edx,0x8(%ebp)
  800954:	8b 55 0c             	mov    0xc(%ebp),%edx
  800957:	8a 12                	mov    (%edx),%dl
  800959:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80095b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095e:	8a 00                	mov    (%eax),%al
  800960:	84 c0                	test   %al,%al
  800962:	74 03                	je     800967 <strncpy+0x31>
			src++;
  800964:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800967:	ff 45 fc             	incl   -0x4(%ebp)
  80096a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80096d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800970:	72 d9                	jb     80094b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800972:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800975:	c9                   	leave  
  800976:	c3                   	ret    

00800977 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800977:	55                   	push   %ebp
  800978:	89 e5                	mov    %esp,%ebp
  80097a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800983:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800987:	74 30                	je     8009b9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800989:	eb 16                	jmp    8009a1 <strlcpy+0x2a>
			*dst++ = *src++;
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	8d 50 01             	lea    0x1(%eax),%edx
  800991:	89 55 08             	mov    %edx,0x8(%ebp)
  800994:	8b 55 0c             	mov    0xc(%ebp),%edx
  800997:	8d 4a 01             	lea    0x1(%edx),%ecx
  80099a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80099d:	8a 12                	mov    (%edx),%dl
  80099f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009a1:	ff 4d 10             	decl   0x10(%ebp)
  8009a4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009a8:	74 09                	je     8009b3 <strlcpy+0x3c>
  8009aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ad:	8a 00                	mov    (%eax),%al
  8009af:	84 c0                	test   %al,%al
  8009b1:	75 d8                	jne    80098b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8009bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009bf:	29 c2                	sub    %eax,%edx
  8009c1:	89 d0                	mov    %edx,%eax
}
  8009c3:	c9                   	leave  
  8009c4:	c3                   	ret    

008009c5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009c5:	55                   	push   %ebp
  8009c6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009c8:	eb 06                	jmp    8009d0 <strcmp+0xb>
		p++, q++;
  8009ca:	ff 45 08             	incl   0x8(%ebp)
  8009cd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	8a 00                	mov    (%eax),%al
  8009d5:	84 c0                	test   %al,%al
  8009d7:	74 0e                	je     8009e7 <strcmp+0x22>
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	8a 10                	mov    (%eax),%dl
  8009de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e1:	8a 00                	mov    (%eax),%al
  8009e3:	38 c2                	cmp    %al,%dl
  8009e5:	74 e3                	je     8009ca <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	8a 00                	mov    (%eax),%al
  8009ec:	0f b6 d0             	movzbl %al,%edx
  8009ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f2:	8a 00                	mov    (%eax),%al
  8009f4:	0f b6 c0             	movzbl %al,%eax
  8009f7:	29 c2                	sub    %eax,%edx
  8009f9:	89 d0                	mov    %edx,%eax
}
  8009fb:	5d                   	pop    %ebp
  8009fc:	c3                   	ret    

008009fd <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8009fd:	55                   	push   %ebp
  8009fe:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a00:	eb 09                	jmp    800a0b <strncmp+0xe>
		n--, p++, q++;
  800a02:	ff 4d 10             	decl   0x10(%ebp)
  800a05:	ff 45 08             	incl   0x8(%ebp)
  800a08:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0f:	74 17                	je     800a28 <strncmp+0x2b>
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	8a 00                	mov    (%eax),%al
  800a16:	84 c0                	test   %al,%al
  800a18:	74 0e                	je     800a28 <strncmp+0x2b>
  800a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1d:	8a 10                	mov    (%eax),%dl
  800a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a22:	8a 00                	mov    (%eax),%al
  800a24:	38 c2                	cmp    %al,%dl
  800a26:	74 da                	je     800a02 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a2c:	75 07                	jne    800a35 <strncmp+0x38>
		return 0;
  800a2e:	b8 00 00 00 00       	mov    $0x0,%eax
  800a33:	eb 14                	jmp    800a49 <strncmp+0x4c>
	else
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

00800a4b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a4b:	55                   	push   %ebp
  800a4c:	89 e5                	mov    %esp,%ebp
  800a4e:	83 ec 04             	sub    $0x4,%esp
  800a51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a54:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a57:	eb 12                	jmp    800a6b <strchr+0x20>
		if (*s == c)
  800a59:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5c:	8a 00                	mov    (%eax),%al
  800a5e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a61:	75 05                	jne    800a68 <strchr+0x1d>
			return (char *) s;
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	eb 11                	jmp    800a79 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a68:	ff 45 08             	incl   0x8(%ebp)
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	8a 00                	mov    (%eax),%al
  800a70:	84 c0                	test   %al,%al
  800a72:	75 e5                	jne    800a59 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a79:	c9                   	leave  
  800a7a:	c3                   	ret    

00800a7b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a7b:	55                   	push   %ebp
  800a7c:	89 e5                	mov    %esp,%ebp
  800a7e:	83 ec 04             	sub    $0x4,%esp
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a87:	eb 0d                	jmp    800a96 <strfind+0x1b>
		if (*s == c)
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a91:	74 0e                	je     800aa1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a93:	ff 45 08             	incl   0x8(%ebp)
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	8a 00                	mov    (%eax),%al
  800a9b:	84 c0                	test   %al,%al
  800a9d:	75 ea                	jne    800a89 <strfind+0xe>
  800a9f:	eb 01                	jmp    800aa2 <strfind+0x27>
		if (*s == c)
			break;
  800aa1:	90                   	nop
	return (char *) s;
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aa5:	c9                   	leave  
  800aa6:	c3                   	ret    

00800aa7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aa7:	55                   	push   %ebp
  800aa8:	89 e5                	mov    %esp,%ebp
  800aaa:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ab3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ab9:	eb 0e                	jmp    800ac9 <memset+0x22>
		*p++ = c;
  800abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800abe:	8d 50 01             	lea    0x1(%eax),%edx
  800ac1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ac4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ac9:	ff 4d f8             	decl   -0x8(%ebp)
  800acc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ad0:	79 e9                	jns    800abb <memset+0x14>
		*p++ = c;

	return v;
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ad5:	c9                   	leave  
  800ad6:	c3                   	ret    

00800ad7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ad7:	55                   	push   %ebp
  800ad8:	89 e5                	mov    %esp,%ebp
  800ada:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800add:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ae9:	eb 16                	jmp    800b01 <memcpy+0x2a>
		*d++ = *s++;
  800aeb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800aee:	8d 50 01             	lea    0x1(%eax),%edx
  800af1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800af4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800af7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800afa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800afd:	8a 12                	mov    (%edx),%dl
  800aff:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b01:	8b 45 10             	mov    0x10(%ebp),%eax
  800b04:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b07:	89 55 10             	mov    %edx,0x10(%ebp)
  800b0a:	85 c0                	test   %eax,%eax
  800b0c:	75 dd                	jne    800aeb <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b11:	c9                   	leave  
  800b12:	c3                   	ret    

00800b13 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b13:	55                   	push   %ebp
  800b14:	89 e5                	mov    %esp,%ebp
  800b16:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b28:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b2b:	73 50                	jae    800b7d <memmove+0x6a>
  800b2d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b30:	8b 45 10             	mov    0x10(%ebp),%eax
  800b33:	01 d0                	add    %edx,%eax
  800b35:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b38:	76 43                	jbe    800b7d <memmove+0x6a>
		s += n;
  800b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b40:	8b 45 10             	mov    0x10(%ebp),%eax
  800b43:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b46:	eb 10                	jmp    800b58 <memmove+0x45>
			*--d = *--s;
  800b48:	ff 4d f8             	decl   -0x8(%ebp)
  800b4b:	ff 4d fc             	decl   -0x4(%ebp)
  800b4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b51:	8a 10                	mov    (%eax),%dl
  800b53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b56:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b58:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5e:	89 55 10             	mov    %edx,0x10(%ebp)
  800b61:	85 c0                	test   %eax,%eax
  800b63:	75 e3                	jne    800b48 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b65:	eb 23                	jmp    800b8a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b6a:	8d 50 01             	lea    0x1(%eax),%edx
  800b6d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b70:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b73:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b76:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b79:	8a 12                	mov    (%edx),%dl
  800b7b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b80:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b83:	89 55 10             	mov    %edx,0x10(%ebp)
  800b86:	85 c0                	test   %eax,%eax
  800b88:	75 dd                	jne    800b67 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8d:	c9                   	leave  
  800b8e:	c3                   	ret    

00800b8f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800b9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ba1:	eb 2a                	jmp    800bcd <memcmp+0x3e>
		if (*s1 != *s2)
  800ba3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba6:	8a 10                	mov    (%eax),%dl
  800ba8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	38 c2                	cmp    %al,%dl
  800baf:	74 16                	je     800bc7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb4:	8a 00                	mov    (%eax),%al
  800bb6:	0f b6 d0             	movzbl %al,%edx
  800bb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bbc:	8a 00                	mov    (%eax),%al
  800bbe:	0f b6 c0             	movzbl %al,%eax
  800bc1:	29 c2                	sub    %eax,%edx
  800bc3:	89 d0                	mov    %edx,%eax
  800bc5:	eb 18                	jmp    800bdf <memcmp+0x50>
		s1++, s2++;
  800bc7:	ff 45 fc             	incl   -0x4(%ebp)
  800bca:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd6:	85 c0                	test   %eax,%eax
  800bd8:	75 c9                	jne    800ba3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bda:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bdf:	c9                   	leave  
  800be0:	c3                   	ret    

00800be1 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800be1:	55                   	push   %ebp
  800be2:	89 e5                	mov    %esp,%ebp
  800be4:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800be7:	8b 55 08             	mov    0x8(%ebp),%edx
  800bea:	8b 45 10             	mov    0x10(%ebp),%eax
  800bed:	01 d0                	add    %edx,%eax
  800bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800bf2:	eb 15                	jmp    800c09 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8a 00                	mov    (%eax),%al
  800bf9:	0f b6 d0             	movzbl %al,%edx
  800bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bff:	0f b6 c0             	movzbl %al,%eax
  800c02:	39 c2                	cmp    %eax,%edx
  800c04:	74 0d                	je     800c13 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c06:	ff 45 08             	incl   0x8(%ebp)
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c0f:	72 e3                	jb     800bf4 <memfind+0x13>
  800c11:	eb 01                	jmp    800c14 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c13:	90                   	nop
	return (void *) s;
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c17:	c9                   	leave  
  800c18:	c3                   	ret    

00800c19 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c19:	55                   	push   %ebp
  800c1a:	89 e5                	mov    %esp,%ebp
  800c1c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c1f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c26:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c2d:	eb 03                	jmp    800c32 <strtol+0x19>
		s++;
  800c2f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	3c 20                	cmp    $0x20,%al
  800c39:	74 f4                	je     800c2f <strtol+0x16>
  800c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3e:	8a 00                	mov    (%eax),%al
  800c40:	3c 09                	cmp    $0x9,%al
  800c42:	74 eb                	je     800c2f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	8a 00                	mov    (%eax),%al
  800c49:	3c 2b                	cmp    $0x2b,%al
  800c4b:	75 05                	jne    800c52 <strtol+0x39>
		s++;
  800c4d:	ff 45 08             	incl   0x8(%ebp)
  800c50:	eb 13                	jmp    800c65 <strtol+0x4c>
	else if (*s == '-')
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	8a 00                	mov    (%eax),%al
  800c57:	3c 2d                	cmp    $0x2d,%al
  800c59:	75 0a                	jne    800c65 <strtol+0x4c>
		s++, neg = 1;
  800c5b:	ff 45 08             	incl   0x8(%ebp)
  800c5e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c69:	74 06                	je     800c71 <strtol+0x58>
  800c6b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c6f:	75 20                	jne    800c91 <strtol+0x78>
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	8a 00                	mov    (%eax),%al
  800c76:	3c 30                	cmp    $0x30,%al
  800c78:	75 17                	jne    800c91 <strtol+0x78>
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	40                   	inc    %eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 78                	cmp    $0x78,%al
  800c82:	75 0d                	jne    800c91 <strtol+0x78>
		s += 2, base = 16;
  800c84:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c88:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c8f:	eb 28                	jmp    800cb9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c95:	75 15                	jne    800cac <strtol+0x93>
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	8a 00                	mov    (%eax),%al
  800c9c:	3c 30                	cmp    $0x30,%al
  800c9e:	75 0c                	jne    800cac <strtol+0x93>
		s++, base = 8;
  800ca0:	ff 45 08             	incl   0x8(%ebp)
  800ca3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800caa:	eb 0d                	jmp    800cb9 <strtol+0xa0>
	else if (base == 0)
  800cac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb0:	75 07                	jne    800cb9 <strtol+0xa0>
		base = 10;
  800cb2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	3c 2f                	cmp    $0x2f,%al
  800cc0:	7e 19                	jle    800cdb <strtol+0xc2>
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	3c 39                	cmp    $0x39,%al
  800cc9:	7f 10                	jg     800cdb <strtol+0xc2>
			dig = *s - '0';
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	0f be c0             	movsbl %al,%eax
  800cd3:	83 e8 30             	sub    $0x30,%eax
  800cd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cd9:	eb 42                	jmp    800d1d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	3c 60                	cmp    $0x60,%al
  800ce2:	7e 19                	jle    800cfd <strtol+0xe4>
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8a 00                	mov    (%eax),%al
  800ce9:	3c 7a                	cmp    $0x7a,%al
  800ceb:	7f 10                	jg     800cfd <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	0f be c0             	movsbl %al,%eax
  800cf5:	83 e8 57             	sub    $0x57,%eax
  800cf8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cfb:	eb 20                	jmp    800d1d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	3c 40                	cmp    $0x40,%al
  800d04:	7e 39                	jle    800d3f <strtol+0x126>
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	3c 5a                	cmp    $0x5a,%al
  800d0d:	7f 30                	jg     800d3f <strtol+0x126>
			dig = *s - 'A' + 10;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	0f be c0             	movsbl %al,%eax
  800d17:	83 e8 37             	sub    $0x37,%eax
  800d1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d20:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d23:	7d 19                	jge    800d3e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d25:	ff 45 08             	incl   0x8(%ebp)
  800d28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d2b:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d2f:	89 c2                	mov    %eax,%edx
  800d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d34:	01 d0                	add    %edx,%eax
  800d36:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d39:	e9 7b ff ff ff       	jmp    800cb9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d3e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d3f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d43:	74 08                	je     800d4d <strtol+0x134>
		*endptr = (char *) s;
  800d45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d48:	8b 55 08             	mov    0x8(%ebp),%edx
  800d4b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d4d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d51:	74 07                	je     800d5a <strtol+0x141>
  800d53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d56:	f7 d8                	neg    %eax
  800d58:	eb 03                	jmp    800d5d <strtol+0x144>
  800d5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d5d:	c9                   	leave  
  800d5e:	c3                   	ret    

00800d5f <ltostr>:

void
ltostr(long value, char *str)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d65:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d6c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d73:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d77:	79 13                	jns    800d8c <ltostr+0x2d>
	{
		neg = 1;
  800d79:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d83:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d86:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d89:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d94:	99                   	cltd   
  800d95:	f7 f9                	idiv   %ecx
  800d97:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800d9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9d:	8d 50 01             	lea    0x1(%eax),%edx
  800da0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da3:	89 c2                	mov    %eax,%edx
  800da5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da8:	01 d0                	add    %edx,%eax
  800daa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dad:	83 c2 30             	add    $0x30,%edx
  800db0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800db2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800db5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dba:	f7 e9                	imul   %ecx
  800dbc:	c1 fa 02             	sar    $0x2,%edx
  800dbf:	89 c8                	mov    %ecx,%eax
  800dc1:	c1 f8 1f             	sar    $0x1f,%eax
  800dc4:	29 c2                	sub    %eax,%edx
  800dc6:	89 d0                	mov    %edx,%eax
  800dc8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dcb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dce:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dd3:	f7 e9                	imul   %ecx
  800dd5:	c1 fa 02             	sar    $0x2,%edx
  800dd8:	89 c8                	mov    %ecx,%eax
  800dda:	c1 f8 1f             	sar    $0x1f,%eax
  800ddd:	29 c2                	sub    %eax,%edx
  800ddf:	89 d0                	mov    %edx,%eax
  800de1:	c1 e0 02             	shl    $0x2,%eax
  800de4:	01 d0                	add    %edx,%eax
  800de6:	01 c0                	add    %eax,%eax
  800de8:	29 c1                	sub    %eax,%ecx
  800dea:	89 ca                	mov    %ecx,%edx
  800dec:	85 d2                	test   %edx,%edx
  800dee:	75 9c                	jne    800d8c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800df0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800df7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfa:	48                   	dec    %eax
  800dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800dfe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e02:	74 3d                	je     800e41 <ltostr+0xe2>
		start = 1 ;
  800e04:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e0b:	eb 34                	jmp    800e41 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e13:	01 d0                	add    %edx,%eax
  800e15:	8a 00                	mov    (%eax),%al
  800e17:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	01 c2                	add    %eax,%edx
  800e22:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e28:	01 c8                	add    %ecx,%eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e2e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	01 c2                	add    %eax,%edx
  800e36:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e39:	88 02                	mov    %al,(%edx)
		start++ ;
  800e3b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e3e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e44:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e47:	7c c4                	jl     800e0d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e49:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4f:	01 d0                	add    %edx,%eax
  800e51:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e54:	90                   	nop
  800e55:	c9                   	leave  
  800e56:	c3                   	ret    

00800e57 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e57:	55                   	push   %ebp
  800e58:	89 e5                	mov    %esp,%ebp
  800e5a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e5d:	ff 75 08             	pushl  0x8(%ebp)
  800e60:	e8 54 fa ff ff       	call   8008b9 <strlen>
  800e65:	83 c4 04             	add    $0x4,%esp
  800e68:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e6b:	ff 75 0c             	pushl  0xc(%ebp)
  800e6e:	e8 46 fa ff ff       	call   8008b9 <strlen>
  800e73:	83 c4 04             	add    $0x4,%esp
  800e76:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e87:	eb 17                	jmp    800ea0 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8f:	01 c2                	add    %eax,%edx
  800e91:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	01 c8                	add    %ecx,%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800e9d:	ff 45 fc             	incl   -0x4(%ebp)
  800ea0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ea6:	7c e1                	jl     800e89 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ea8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800eaf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800eb6:	eb 1f                	jmp    800ed7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800eb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebb:	8d 50 01             	lea    0x1(%eax),%edx
  800ebe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ec1:	89 c2                	mov    %eax,%edx
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	01 c2                	add    %eax,%edx
  800ec8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ece:	01 c8                	add    %ecx,%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ed4:	ff 45 f8             	incl   -0x8(%ebp)
  800ed7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eda:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800edd:	7c d9                	jl     800eb8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800edf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee5:	01 d0                	add    %edx,%eax
  800ee7:	c6 00 00             	movb   $0x0,(%eax)
}
  800eea:	90                   	nop
  800eeb:	c9                   	leave  
  800eec:	c3                   	ret    

00800eed <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800eed:	55                   	push   %ebp
  800eee:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ef0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ef9:	8b 45 14             	mov    0x14(%ebp),%eax
  800efc:	8b 00                	mov    (%eax),%eax
  800efe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f05:	8b 45 10             	mov    0x10(%ebp),%eax
  800f08:	01 d0                	add    %edx,%eax
  800f0a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f10:	eb 0c                	jmp    800f1e <strsplit+0x31>
			*string++ = 0;
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	8d 50 01             	lea    0x1(%eax),%edx
  800f18:	89 55 08             	mov    %edx,0x8(%ebp)
  800f1b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	84 c0                	test   %al,%al
  800f25:	74 18                	je     800f3f <strsplit+0x52>
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	8a 00                	mov    (%eax),%al
  800f2c:	0f be c0             	movsbl %al,%eax
  800f2f:	50                   	push   %eax
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	e8 13 fb ff ff       	call   800a4b <strchr>
  800f38:	83 c4 08             	add    $0x8,%esp
  800f3b:	85 c0                	test   %eax,%eax
  800f3d:	75 d3                	jne    800f12 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f42:	8a 00                	mov    (%eax),%al
  800f44:	84 c0                	test   %al,%al
  800f46:	74 5a                	je     800fa2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f48:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4b:	8b 00                	mov    (%eax),%eax
  800f4d:	83 f8 0f             	cmp    $0xf,%eax
  800f50:	75 07                	jne    800f59 <strsplit+0x6c>
		{
			return 0;
  800f52:	b8 00 00 00 00       	mov    $0x0,%eax
  800f57:	eb 66                	jmp    800fbf <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f59:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5c:	8b 00                	mov    (%eax),%eax
  800f5e:	8d 48 01             	lea    0x1(%eax),%ecx
  800f61:	8b 55 14             	mov    0x14(%ebp),%edx
  800f64:	89 0a                	mov    %ecx,(%edx)
  800f66:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f70:	01 c2                	add    %eax,%edx
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f77:	eb 03                	jmp    800f7c <strsplit+0x8f>
			string++;
  800f79:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	84 c0                	test   %al,%al
  800f83:	74 8b                	je     800f10 <strsplit+0x23>
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	0f be c0             	movsbl %al,%eax
  800f8d:	50                   	push   %eax
  800f8e:	ff 75 0c             	pushl  0xc(%ebp)
  800f91:	e8 b5 fa ff ff       	call   800a4b <strchr>
  800f96:	83 c4 08             	add    $0x8,%esp
  800f99:	85 c0                	test   %eax,%eax
  800f9b:	74 dc                	je     800f79 <strsplit+0x8c>
			string++;
	}
  800f9d:	e9 6e ff ff ff       	jmp    800f10 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fa2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	8b 00                	mov    (%eax),%eax
  800fa8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800faf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb2:	01 d0                	add    %edx,%eax
  800fb4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fba:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fbf:	c9                   	leave  
  800fc0:	c3                   	ret    

00800fc1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	57                   	push   %edi
  800fc5:	56                   	push   %esi
  800fc6:	53                   	push   %ebx
  800fc7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fd0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fd3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fd6:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fd9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fdc:	cd 30                	int    $0x30
  800fde:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fe1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fe4:	83 c4 10             	add    $0x10,%esp
  800fe7:	5b                   	pop    %ebx
  800fe8:	5e                   	pop    %esi
  800fe9:	5f                   	pop    %edi
  800fea:	5d                   	pop    %ebp
  800feb:	c3                   	ret    

00800fec <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
  800fef:	83 ec 04             	sub    $0x4,%esp
  800ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  800ff8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	6a 00                	push   $0x0
  801001:	6a 00                	push   $0x0
  801003:	52                   	push   %edx
  801004:	ff 75 0c             	pushl  0xc(%ebp)
  801007:	50                   	push   %eax
  801008:	6a 00                	push   $0x0
  80100a:	e8 b2 ff ff ff       	call   800fc1 <syscall>
  80100f:	83 c4 18             	add    $0x18,%esp
}
  801012:	90                   	nop
  801013:	c9                   	leave  
  801014:	c3                   	ret    

00801015 <sys_cgetc>:

int
sys_cgetc(void)
{
  801015:	55                   	push   %ebp
  801016:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801018:	6a 00                	push   $0x0
  80101a:	6a 00                	push   $0x0
  80101c:	6a 00                	push   $0x0
  80101e:	6a 00                	push   $0x0
  801020:	6a 00                	push   $0x0
  801022:	6a 01                	push   $0x1
  801024:	e8 98 ff ff ff       	call   800fc1 <syscall>
  801029:	83 c4 18             	add    $0x18,%esp
}
  80102c:	c9                   	leave  
  80102d:	c3                   	ret    

0080102e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80102e:	55                   	push   %ebp
  80102f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	6a 00                	push   $0x0
  801036:	6a 00                	push   $0x0
  801038:	6a 00                	push   $0x0
  80103a:	6a 00                	push   $0x0
  80103c:	50                   	push   %eax
  80103d:	6a 05                	push   $0x5
  80103f:	e8 7d ff ff ff       	call   800fc1 <syscall>
  801044:	83 c4 18             	add    $0x18,%esp
}
  801047:	c9                   	leave  
  801048:	c3                   	ret    

00801049 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801049:	55                   	push   %ebp
  80104a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80104c:	6a 00                	push   $0x0
  80104e:	6a 00                	push   $0x0
  801050:	6a 00                	push   $0x0
  801052:	6a 00                	push   $0x0
  801054:	6a 00                	push   $0x0
  801056:	6a 02                	push   $0x2
  801058:	e8 64 ff ff ff       	call   800fc1 <syscall>
  80105d:	83 c4 18             	add    $0x18,%esp
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801065:	6a 00                	push   $0x0
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	6a 00                	push   $0x0
  80106d:	6a 00                	push   $0x0
  80106f:	6a 03                	push   $0x3
  801071:	e8 4b ff ff ff       	call   800fc1 <syscall>
  801076:	83 c4 18             	add    $0x18,%esp
}
  801079:	c9                   	leave  
  80107a:	c3                   	ret    

0080107b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80107b:	55                   	push   %ebp
  80107c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	6a 04                	push   $0x4
  80108a:	e8 32 ff ff ff       	call   800fc1 <syscall>
  80108f:	83 c4 18             	add    $0x18,%esp
}
  801092:	c9                   	leave  
  801093:	c3                   	ret    

00801094 <sys_env_exit>:


void sys_env_exit(void)
{
  801094:	55                   	push   %ebp
  801095:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 00                	push   $0x0
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 06                	push   $0x6
  8010a3:	e8 19 ff ff ff       	call   800fc1 <syscall>
  8010a8:	83 c4 18             	add    $0x18,%esp
}
  8010ab:	90                   	nop
  8010ac:	c9                   	leave  
  8010ad:	c3                   	ret    

008010ae <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010ae:	55                   	push   %ebp
  8010af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b7:	6a 00                	push   $0x0
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	52                   	push   %edx
  8010be:	50                   	push   %eax
  8010bf:	6a 07                	push   $0x7
  8010c1:	e8 fb fe ff ff       	call   800fc1 <syscall>
  8010c6:	83 c4 18             	add    $0x18,%esp
}
  8010c9:	c9                   	leave  
  8010ca:	c3                   	ret    

008010cb <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010cb:	55                   	push   %ebp
  8010cc:	89 e5                	mov    %esp,%ebp
  8010ce:	56                   	push   %esi
  8010cf:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010d0:	8b 75 18             	mov    0x18(%ebp),%esi
  8010d3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	56                   	push   %esi
  8010e0:	53                   	push   %ebx
  8010e1:	51                   	push   %ecx
  8010e2:	52                   	push   %edx
  8010e3:	50                   	push   %eax
  8010e4:	6a 08                	push   $0x8
  8010e6:	e8 d6 fe ff ff       	call   800fc1 <syscall>
  8010eb:	83 c4 18             	add    $0x18,%esp
}
  8010ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010f1:	5b                   	pop    %ebx
  8010f2:	5e                   	pop    %esi
  8010f3:	5d                   	pop    %ebp
  8010f4:	c3                   	ret    

008010f5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8010f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	6a 00                	push   $0x0
  801100:	6a 00                	push   $0x0
  801102:	6a 00                	push   $0x0
  801104:	52                   	push   %edx
  801105:	50                   	push   %eax
  801106:	6a 09                	push   $0x9
  801108:	e8 b4 fe ff ff       	call   800fc1 <syscall>
  80110d:	83 c4 18             	add    $0x18,%esp
}
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801115:	6a 00                	push   $0x0
  801117:	6a 00                	push   $0x0
  801119:	6a 00                	push   $0x0
  80111b:	ff 75 0c             	pushl  0xc(%ebp)
  80111e:	ff 75 08             	pushl  0x8(%ebp)
  801121:	6a 0a                	push   $0xa
  801123:	e8 99 fe ff ff       	call   800fc1 <syscall>
  801128:	83 c4 18             	add    $0x18,%esp
}
  80112b:	c9                   	leave  
  80112c:	c3                   	ret    

0080112d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801130:	6a 00                	push   $0x0
  801132:	6a 00                	push   $0x0
  801134:	6a 00                	push   $0x0
  801136:	6a 00                	push   $0x0
  801138:	6a 00                	push   $0x0
  80113a:	6a 0b                	push   $0xb
  80113c:	e8 80 fe ff ff       	call   800fc1 <syscall>
  801141:	83 c4 18             	add    $0x18,%esp
}
  801144:	c9                   	leave  
  801145:	c3                   	ret    

00801146 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801146:	55                   	push   %ebp
  801147:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 0c                	push   $0xc
  801155:	e8 67 fe ff ff       	call   800fc1 <syscall>
  80115a:	83 c4 18             	add    $0x18,%esp
}
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 0d                	push   $0xd
  80116e:	e8 4e fe ff ff       	call   800fc1 <syscall>
  801173:	83 c4 18             	add    $0x18,%esp
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	ff 75 0c             	pushl  0xc(%ebp)
  801184:	ff 75 08             	pushl  0x8(%ebp)
  801187:	6a 11                	push   $0x11
  801189:	e8 33 fe ff ff       	call   800fc1 <syscall>
  80118e:	83 c4 18             	add    $0x18,%esp
	return;
  801191:	90                   	nop
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801197:	6a 00                	push   $0x0
  801199:	6a 00                	push   $0x0
  80119b:	6a 00                	push   $0x0
  80119d:	ff 75 0c             	pushl  0xc(%ebp)
  8011a0:	ff 75 08             	pushl  0x8(%ebp)
  8011a3:	6a 12                	push   $0x12
  8011a5:	e8 17 fe ff ff       	call   800fc1 <syscall>
  8011aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8011ad:	90                   	nop
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 0e                	push   $0xe
  8011bf:	e8 fd fd ff ff       	call   800fc1 <syscall>
  8011c4:	83 c4 18             	add    $0x18,%esp
}
  8011c7:	c9                   	leave  
  8011c8:	c3                   	ret    

008011c9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	ff 75 08             	pushl  0x8(%ebp)
  8011d7:	6a 0f                	push   $0xf
  8011d9:	e8 e3 fd ff ff       	call   800fc1 <syscall>
  8011de:	83 c4 18             	add    $0x18,%esp
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 00                	push   $0x0
  8011ea:	6a 00                	push   $0x0
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 10                	push   $0x10
  8011f2:	e8 ca fd ff ff       	call   800fc1 <syscall>
  8011f7:	83 c4 18             	add    $0x18,%esp
}
  8011fa:	90                   	nop
  8011fb:	c9                   	leave  
  8011fc:	c3                   	ret    

008011fd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8011fd:	55                   	push   %ebp
  8011fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 14                	push   $0x14
  80120c:	e8 b0 fd ff ff       	call   800fc1 <syscall>
  801211:	83 c4 18             	add    $0x18,%esp
}
  801214:	90                   	nop
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80121a:	6a 00                	push   $0x0
  80121c:	6a 00                	push   $0x0
  80121e:	6a 00                	push   $0x0
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 15                	push   $0x15
  801226:	e8 96 fd ff ff       	call   800fc1 <syscall>
  80122b:	83 c4 18             	add    $0x18,%esp
}
  80122e:	90                   	nop
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <sys_cputc>:


void
sys_cputc(const char c)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
  801234:	83 ec 04             	sub    $0x4,%esp
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80123d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	50                   	push   %eax
  80124a:	6a 16                	push   $0x16
  80124c:	e8 70 fd ff ff       	call   800fc1 <syscall>
  801251:	83 c4 18             	add    $0x18,%esp
}
  801254:	90                   	nop
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	6a 17                	push   $0x17
  801266:	e8 56 fd ff ff       	call   800fc1 <syscall>
  80126b:	83 c4 18             	add    $0x18,%esp
}
  80126e:	90                   	nop
  80126f:	c9                   	leave  
  801270:	c3                   	ret    

00801271 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801271:	55                   	push   %ebp
  801272:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 00                	push   $0x0
  80127d:	ff 75 0c             	pushl  0xc(%ebp)
  801280:	50                   	push   %eax
  801281:	6a 18                	push   $0x18
  801283:	e8 39 fd ff ff       	call   800fc1 <syscall>
  801288:	83 c4 18             	add    $0x18,%esp
}
  80128b:	c9                   	leave  
  80128c:	c3                   	ret    

0080128d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80128d:	55                   	push   %ebp
  80128e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801290:	8b 55 0c             	mov    0xc(%ebp),%edx
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	52                   	push   %edx
  80129d:	50                   	push   %eax
  80129e:	6a 1b                	push   $0x1b
  8012a0:	e8 1c fd ff ff       	call   800fc1 <syscall>
  8012a5:	83 c4 18             	add    $0x18,%esp
}
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	52                   	push   %edx
  8012ba:	50                   	push   %eax
  8012bb:	6a 19                	push   $0x19
  8012bd:	e8 ff fc ff ff       	call   800fc1 <syscall>
  8012c2:	83 c4 18             	add    $0x18,%esp
}
  8012c5:	90                   	nop
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	52                   	push   %edx
  8012d8:	50                   	push   %eax
  8012d9:	6a 1a                	push   $0x1a
  8012db:	e8 e1 fc ff ff       	call   800fc1 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	90                   	nop
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
  8012e9:	83 ec 04             	sub    $0x4,%esp
  8012ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012f2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012f5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	6a 00                	push   $0x0
  8012fe:	51                   	push   %ecx
  8012ff:	52                   	push   %edx
  801300:	ff 75 0c             	pushl  0xc(%ebp)
  801303:	50                   	push   %eax
  801304:	6a 1c                	push   $0x1c
  801306:	e8 b6 fc ff ff       	call   800fc1 <syscall>
  80130b:	83 c4 18             	add    $0x18,%esp
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801313:	8b 55 0c             	mov    0xc(%ebp),%edx
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	52                   	push   %edx
  801320:	50                   	push   %eax
  801321:	6a 1d                	push   $0x1d
  801323:	e8 99 fc ff ff       	call   800fc1 <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801330:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801333:	8b 55 0c             	mov    0xc(%ebp),%edx
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	51                   	push   %ecx
  80133e:	52                   	push   %edx
  80133f:	50                   	push   %eax
  801340:	6a 1e                	push   $0x1e
  801342:	e8 7a fc ff ff       	call   800fc1 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80134f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	52                   	push   %edx
  80135c:	50                   	push   %eax
  80135d:	6a 1f                	push   $0x1f
  80135f:	e8 5d fc ff ff       	call   800fc1 <syscall>
  801364:	83 c4 18             	add    $0x18,%esp
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 20                	push   $0x20
  801378:	e8 44 fc ff ff       	call   800fc1 <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	ff 75 10             	pushl  0x10(%ebp)
  80138f:	ff 75 0c             	pushl  0xc(%ebp)
  801392:	50                   	push   %eax
  801393:	6a 21                	push   $0x21
  801395:	e8 27 fc ff ff       	call   800fc1 <syscall>
  80139a:	83 c4 18             	add    $0x18,%esp
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	50                   	push   %eax
  8013ae:	6a 22                	push   $0x22
  8013b0:	e8 0c fc ff ff       	call   800fc1 <syscall>
  8013b5:	83 c4 18             	add    $0x18,%esp
}
  8013b8:	90                   	nop
  8013b9:	c9                   	leave  
  8013ba:	c3                   	ret    

008013bb <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	50                   	push   %eax
  8013ca:	6a 23                	push   $0x23
  8013cc:	e8 f0 fb ff ff       	call   800fc1 <syscall>
  8013d1:	83 c4 18             	add    $0x18,%esp
}
  8013d4:	90                   	nop
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
  8013da:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013dd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013e0:	8d 50 04             	lea    0x4(%eax),%edx
  8013e3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	52                   	push   %edx
  8013ed:	50                   	push   %eax
  8013ee:	6a 24                	push   $0x24
  8013f0:	e8 cc fb ff ff       	call   800fc1 <syscall>
  8013f5:	83 c4 18             	add    $0x18,%esp
	return result;
  8013f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801401:	89 01                	mov    %eax,(%ecx)
  801403:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	c9                   	leave  
  80140a:	c2 04 00             	ret    $0x4

0080140d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	ff 75 10             	pushl  0x10(%ebp)
  801417:	ff 75 0c             	pushl  0xc(%ebp)
  80141a:	ff 75 08             	pushl  0x8(%ebp)
  80141d:	6a 13                	push   $0x13
  80141f:	e8 9d fb ff ff       	call   800fc1 <syscall>
  801424:	83 c4 18             	add    $0x18,%esp
	return ;
  801427:	90                   	nop
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_rcr2>:
uint32 sys_rcr2()
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 25                	push   $0x25
  801439:	e8 83 fb ff ff       	call   800fc1 <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
}
  801441:	c9                   	leave  
  801442:	c3                   	ret    

00801443 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 04             	sub    $0x4,%esp
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80144f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	50                   	push   %eax
  80145c:	6a 26                	push   $0x26
  80145e:	e8 5e fb ff ff       	call   800fc1 <syscall>
  801463:	83 c4 18             	add    $0x18,%esp
	return ;
  801466:	90                   	nop
}
  801467:	c9                   	leave  
  801468:	c3                   	ret    

00801469 <rsttst>:
void rsttst()
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 28                	push   $0x28
  801478:	e8 44 fb ff ff       	call   800fc1 <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
	return ;
  801480:	90                   	nop
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
  801486:	83 ec 04             	sub    $0x4,%esp
  801489:	8b 45 14             	mov    0x14(%ebp),%eax
  80148c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80148f:	8b 55 18             	mov    0x18(%ebp),%edx
  801492:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801496:	52                   	push   %edx
  801497:	50                   	push   %eax
  801498:	ff 75 10             	pushl  0x10(%ebp)
  80149b:	ff 75 0c             	pushl  0xc(%ebp)
  80149e:	ff 75 08             	pushl  0x8(%ebp)
  8014a1:	6a 27                	push   $0x27
  8014a3:	e8 19 fb ff ff       	call   800fc1 <syscall>
  8014a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ab:	90                   	nop
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <chktst>:
void chktst(uint32 n)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	ff 75 08             	pushl  0x8(%ebp)
  8014bc:	6a 29                	push   $0x29
  8014be:	e8 fe fa ff ff       	call   800fc1 <syscall>
  8014c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c6:	90                   	nop
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <inctst>:

void inctst()
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 2a                	push   $0x2a
  8014d8:	e8 e4 fa ff ff       	call   800fc1 <syscall>
  8014dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e0:	90                   	nop
}
  8014e1:	c9                   	leave  
  8014e2:	c3                   	ret    

008014e3 <gettst>:
uint32 gettst()
{
  8014e3:	55                   	push   %ebp
  8014e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 2b                	push   $0x2b
  8014f2:	e8 ca fa ff ff       	call   800fc1 <syscall>
  8014f7:	83 c4 18             	add    $0x18,%esp
}
  8014fa:	c9                   	leave  
  8014fb:	c3                   	ret    

008014fc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8014fc:	55                   	push   %ebp
  8014fd:	89 e5                	mov    %esp,%ebp
  8014ff:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 2c                	push   $0x2c
  80150e:	e8 ae fa ff ff       	call   800fc1 <syscall>
  801513:	83 c4 18             	add    $0x18,%esp
  801516:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801519:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80151d:	75 07                	jne    801526 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80151f:	b8 01 00 00 00       	mov    $0x1,%eax
  801524:	eb 05                	jmp    80152b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801526:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
  801530:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 2c                	push   $0x2c
  80153f:	e8 7d fa ff ff       	call   800fc1 <syscall>
  801544:	83 c4 18             	add    $0x18,%esp
  801547:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80154a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80154e:	75 07                	jne    801557 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801550:	b8 01 00 00 00       	mov    $0x1,%eax
  801555:	eb 05                	jmp    80155c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801557:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
  801561:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 2c                	push   $0x2c
  801570:	e8 4c fa ff ff       	call   800fc1 <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
  801578:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80157b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80157f:	75 07                	jne    801588 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801581:	b8 01 00 00 00       	mov    $0x1,%eax
  801586:	eb 05                	jmp    80158d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801588:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 2c                	push   $0x2c
  8015a1:	e8 1b fa ff ff       	call   800fc1 <syscall>
  8015a6:	83 c4 18             	add    $0x18,%esp
  8015a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015ac:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015b0:	75 07                	jne    8015b9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b7:	eb 05                	jmp    8015be <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	ff 75 08             	pushl  0x8(%ebp)
  8015ce:	6a 2d                	push   $0x2d
  8015d0:	e8 ec f9 ff ff       	call   800fc1 <syscall>
  8015d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d8:	90                   	nop
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    
  8015db:	90                   	nop

008015dc <__udivdi3>:
  8015dc:	55                   	push   %ebp
  8015dd:	57                   	push   %edi
  8015de:	56                   	push   %esi
  8015df:	53                   	push   %ebx
  8015e0:	83 ec 1c             	sub    $0x1c,%esp
  8015e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8015ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8015f3:	89 ca                	mov    %ecx,%edx
  8015f5:	89 f8                	mov    %edi,%eax
  8015f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8015fb:	85 f6                	test   %esi,%esi
  8015fd:	75 2d                	jne    80162c <__udivdi3+0x50>
  8015ff:	39 cf                	cmp    %ecx,%edi
  801601:	77 65                	ja     801668 <__udivdi3+0x8c>
  801603:	89 fd                	mov    %edi,%ebp
  801605:	85 ff                	test   %edi,%edi
  801607:	75 0b                	jne    801614 <__udivdi3+0x38>
  801609:	b8 01 00 00 00       	mov    $0x1,%eax
  80160e:	31 d2                	xor    %edx,%edx
  801610:	f7 f7                	div    %edi
  801612:	89 c5                	mov    %eax,%ebp
  801614:	31 d2                	xor    %edx,%edx
  801616:	89 c8                	mov    %ecx,%eax
  801618:	f7 f5                	div    %ebp
  80161a:	89 c1                	mov    %eax,%ecx
  80161c:	89 d8                	mov    %ebx,%eax
  80161e:	f7 f5                	div    %ebp
  801620:	89 cf                	mov    %ecx,%edi
  801622:	89 fa                	mov    %edi,%edx
  801624:	83 c4 1c             	add    $0x1c,%esp
  801627:	5b                   	pop    %ebx
  801628:	5e                   	pop    %esi
  801629:	5f                   	pop    %edi
  80162a:	5d                   	pop    %ebp
  80162b:	c3                   	ret    
  80162c:	39 ce                	cmp    %ecx,%esi
  80162e:	77 28                	ja     801658 <__udivdi3+0x7c>
  801630:	0f bd fe             	bsr    %esi,%edi
  801633:	83 f7 1f             	xor    $0x1f,%edi
  801636:	75 40                	jne    801678 <__udivdi3+0x9c>
  801638:	39 ce                	cmp    %ecx,%esi
  80163a:	72 0a                	jb     801646 <__udivdi3+0x6a>
  80163c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801640:	0f 87 9e 00 00 00    	ja     8016e4 <__udivdi3+0x108>
  801646:	b8 01 00 00 00       	mov    $0x1,%eax
  80164b:	89 fa                	mov    %edi,%edx
  80164d:	83 c4 1c             	add    $0x1c,%esp
  801650:	5b                   	pop    %ebx
  801651:	5e                   	pop    %esi
  801652:	5f                   	pop    %edi
  801653:	5d                   	pop    %ebp
  801654:	c3                   	ret    
  801655:	8d 76 00             	lea    0x0(%esi),%esi
  801658:	31 ff                	xor    %edi,%edi
  80165a:	31 c0                	xor    %eax,%eax
  80165c:	89 fa                	mov    %edi,%edx
  80165e:	83 c4 1c             	add    $0x1c,%esp
  801661:	5b                   	pop    %ebx
  801662:	5e                   	pop    %esi
  801663:	5f                   	pop    %edi
  801664:	5d                   	pop    %ebp
  801665:	c3                   	ret    
  801666:	66 90                	xchg   %ax,%ax
  801668:	89 d8                	mov    %ebx,%eax
  80166a:	f7 f7                	div    %edi
  80166c:	31 ff                	xor    %edi,%edi
  80166e:	89 fa                	mov    %edi,%edx
  801670:	83 c4 1c             	add    $0x1c,%esp
  801673:	5b                   	pop    %ebx
  801674:	5e                   	pop    %esi
  801675:	5f                   	pop    %edi
  801676:	5d                   	pop    %ebp
  801677:	c3                   	ret    
  801678:	bd 20 00 00 00       	mov    $0x20,%ebp
  80167d:	89 eb                	mov    %ebp,%ebx
  80167f:	29 fb                	sub    %edi,%ebx
  801681:	89 f9                	mov    %edi,%ecx
  801683:	d3 e6                	shl    %cl,%esi
  801685:	89 c5                	mov    %eax,%ebp
  801687:	88 d9                	mov    %bl,%cl
  801689:	d3 ed                	shr    %cl,%ebp
  80168b:	89 e9                	mov    %ebp,%ecx
  80168d:	09 f1                	or     %esi,%ecx
  80168f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801693:	89 f9                	mov    %edi,%ecx
  801695:	d3 e0                	shl    %cl,%eax
  801697:	89 c5                	mov    %eax,%ebp
  801699:	89 d6                	mov    %edx,%esi
  80169b:	88 d9                	mov    %bl,%cl
  80169d:	d3 ee                	shr    %cl,%esi
  80169f:	89 f9                	mov    %edi,%ecx
  8016a1:	d3 e2                	shl    %cl,%edx
  8016a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016a7:	88 d9                	mov    %bl,%cl
  8016a9:	d3 e8                	shr    %cl,%eax
  8016ab:	09 c2                	or     %eax,%edx
  8016ad:	89 d0                	mov    %edx,%eax
  8016af:	89 f2                	mov    %esi,%edx
  8016b1:	f7 74 24 0c          	divl   0xc(%esp)
  8016b5:	89 d6                	mov    %edx,%esi
  8016b7:	89 c3                	mov    %eax,%ebx
  8016b9:	f7 e5                	mul    %ebp
  8016bb:	39 d6                	cmp    %edx,%esi
  8016bd:	72 19                	jb     8016d8 <__udivdi3+0xfc>
  8016bf:	74 0b                	je     8016cc <__udivdi3+0xf0>
  8016c1:	89 d8                	mov    %ebx,%eax
  8016c3:	31 ff                	xor    %edi,%edi
  8016c5:	e9 58 ff ff ff       	jmp    801622 <__udivdi3+0x46>
  8016ca:	66 90                	xchg   %ax,%ax
  8016cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016d0:	89 f9                	mov    %edi,%ecx
  8016d2:	d3 e2                	shl    %cl,%edx
  8016d4:	39 c2                	cmp    %eax,%edx
  8016d6:	73 e9                	jae    8016c1 <__udivdi3+0xe5>
  8016d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016db:	31 ff                	xor    %edi,%edi
  8016dd:	e9 40 ff ff ff       	jmp    801622 <__udivdi3+0x46>
  8016e2:	66 90                	xchg   %ax,%ax
  8016e4:	31 c0                	xor    %eax,%eax
  8016e6:	e9 37 ff ff ff       	jmp    801622 <__udivdi3+0x46>
  8016eb:	90                   	nop

008016ec <__umoddi3>:
  8016ec:	55                   	push   %ebp
  8016ed:	57                   	push   %edi
  8016ee:	56                   	push   %esi
  8016ef:	53                   	push   %ebx
  8016f0:	83 ec 1c             	sub    $0x1c,%esp
  8016f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8016f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8016fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801703:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801707:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80170b:	89 f3                	mov    %esi,%ebx
  80170d:	89 fa                	mov    %edi,%edx
  80170f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801713:	89 34 24             	mov    %esi,(%esp)
  801716:	85 c0                	test   %eax,%eax
  801718:	75 1a                	jne    801734 <__umoddi3+0x48>
  80171a:	39 f7                	cmp    %esi,%edi
  80171c:	0f 86 a2 00 00 00    	jbe    8017c4 <__umoddi3+0xd8>
  801722:	89 c8                	mov    %ecx,%eax
  801724:	89 f2                	mov    %esi,%edx
  801726:	f7 f7                	div    %edi
  801728:	89 d0                	mov    %edx,%eax
  80172a:	31 d2                	xor    %edx,%edx
  80172c:	83 c4 1c             	add    $0x1c,%esp
  80172f:	5b                   	pop    %ebx
  801730:	5e                   	pop    %esi
  801731:	5f                   	pop    %edi
  801732:	5d                   	pop    %ebp
  801733:	c3                   	ret    
  801734:	39 f0                	cmp    %esi,%eax
  801736:	0f 87 ac 00 00 00    	ja     8017e8 <__umoddi3+0xfc>
  80173c:	0f bd e8             	bsr    %eax,%ebp
  80173f:	83 f5 1f             	xor    $0x1f,%ebp
  801742:	0f 84 ac 00 00 00    	je     8017f4 <__umoddi3+0x108>
  801748:	bf 20 00 00 00       	mov    $0x20,%edi
  80174d:	29 ef                	sub    %ebp,%edi
  80174f:	89 fe                	mov    %edi,%esi
  801751:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801755:	89 e9                	mov    %ebp,%ecx
  801757:	d3 e0                	shl    %cl,%eax
  801759:	89 d7                	mov    %edx,%edi
  80175b:	89 f1                	mov    %esi,%ecx
  80175d:	d3 ef                	shr    %cl,%edi
  80175f:	09 c7                	or     %eax,%edi
  801761:	89 e9                	mov    %ebp,%ecx
  801763:	d3 e2                	shl    %cl,%edx
  801765:	89 14 24             	mov    %edx,(%esp)
  801768:	89 d8                	mov    %ebx,%eax
  80176a:	d3 e0                	shl    %cl,%eax
  80176c:	89 c2                	mov    %eax,%edx
  80176e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801772:	d3 e0                	shl    %cl,%eax
  801774:	89 44 24 04          	mov    %eax,0x4(%esp)
  801778:	8b 44 24 08          	mov    0x8(%esp),%eax
  80177c:	89 f1                	mov    %esi,%ecx
  80177e:	d3 e8                	shr    %cl,%eax
  801780:	09 d0                	or     %edx,%eax
  801782:	d3 eb                	shr    %cl,%ebx
  801784:	89 da                	mov    %ebx,%edx
  801786:	f7 f7                	div    %edi
  801788:	89 d3                	mov    %edx,%ebx
  80178a:	f7 24 24             	mull   (%esp)
  80178d:	89 c6                	mov    %eax,%esi
  80178f:	89 d1                	mov    %edx,%ecx
  801791:	39 d3                	cmp    %edx,%ebx
  801793:	0f 82 87 00 00 00    	jb     801820 <__umoddi3+0x134>
  801799:	0f 84 91 00 00 00    	je     801830 <__umoddi3+0x144>
  80179f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017a3:	29 f2                	sub    %esi,%edx
  8017a5:	19 cb                	sbb    %ecx,%ebx
  8017a7:	89 d8                	mov    %ebx,%eax
  8017a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017ad:	d3 e0                	shl    %cl,%eax
  8017af:	89 e9                	mov    %ebp,%ecx
  8017b1:	d3 ea                	shr    %cl,%edx
  8017b3:	09 d0                	or     %edx,%eax
  8017b5:	89 e9                	mov    %ebp,%ecx
  8017b7:	d3 eb                	shr    %cl,%ebx
  8017b9:	89 da                	mov    %ebx,%edx
  8017bb:	83 c4 1c             	add    $0x1c,%esp
  8017be:	5b                   	pop    %ebx
  8017bf:	5e                   	pop    %esi
  8017c0:	5f                   	pop    %edi
  8017c1:	5d                   	pop    %ebp
  8017c2:	c3                   	ret    
  8017c3:	90                   	nop
  8017c4:	89 fd                	mov    %edi,%ebp
  8017c6:	85 ff                	test   %edi,%edi
  8017c8:	75 0b                	jne    8017d5 <__umoddi3+0xe9>
  8017ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8017cf:	31 d2                	xor    %edx,%edx
  8017d1:	f7 f7                	div    %edi
  8017d3:	89 c5                	mov    %eax,%ebp
  8017d5:	89 f0                	mov    %esi,%eax
  8017d7:	31 d2                	xor    %edx,%edx
  8017d9:	f7 f5                	div    %ebp
  8017db:	89 c8                	mov    %ecx,%eax
  8017dd:	f7 f5                	div    %ebp
  8017df:	89 d0                	mov    %edx,%eax
  8017e1:	e9 44 ff ff ff       	jmp    80172a <__umoddi3+0x3e>
  8017e6:	66 90                	xchg   %ax,%ax
  8017e8:	89 c8                	mov    %ecx,%eax
  8017ea:	89 f2                	mov    %esi,%edx
  8017ec:	83 c4 1c             	add    $0x1c,%esp
  8017ef:	5b                   	pop    %ebx
  8017f0:	5e                   	pop    %esi
  8017f1:	5f                   	pop    %edi
  8017f2:	5d                   	pop    %ebp
  8017f3:	c3                   	ret    
  8017f4:	3b 04 24             	cmp    (%esp),%eax
  8017f7:	72 06                	jb     8017ff <__umoddi3+0x113>
  8017f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8017fd:	77 0f                	ja     80180e <__umoddi3+0x122>
  8017ff:	89 f2                	mov    %esi,%edx
  801801:	29 f9                	sub    %edi,%ecx
  801803:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801807:	89 14 24             	mov    %edx,(%esp)
  80180a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80180e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801812:	8b 14 24             	mov    (%esp),%edx
  801815:	83 c4 1c             	add    $0x1c,%esp
  801818:	5b                   	pop    %ebx
  801819:	5e                   	pop    %esi
  80181a:	5f                   	pop    %edi
  80181b:	5d                   	pop    %ebp
  80181c:	c3                   	ret    
  80181d:	8d 76 00             	lea    0x0(%esi),%esi
  801820:	2b 04 24             	sub    (%esp),%eax
  801823:	19 fa                	sbb    %edi,%edx
  801825:	89 d1                	mov    %edx,%ecx
  801827:	89 c6                	mov    %eax,%esi
  801829:	e9 71 ff ff ff       	jmp    80179f <__umoddi3+0xb3>
  80182e:	66 90                	xchg   %ax,%ax
  801830:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801834:	72 ea                	jb     801820 <__umoddi3+0x134>
  801836:	89 d9                	mov    %ebx,%ecx
  801838:	e9 62 ff ff ff       	jmp    80179f <__umoddi3+0xb3>
