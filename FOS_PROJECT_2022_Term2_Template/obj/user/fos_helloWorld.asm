
obj/user/fos_helloWorld:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
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
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);		
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 60 18 80 00       	push   $0x801860
  800046:	e8 2c 02 00 00       	call   800277 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 51 18 80 00       	mov    0x801851,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 88 18 80 00       	push   $0x801888
  80005c:	e8 16 02 00 00       	call   800277 <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
}
  800064:	90                   	nop
  800065:	c9                   	leave  
  800066:	c3                   	ret    

00800067 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80006d:	e8 03 10 00 00       	call   801075 <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	c1 e0 02             	shl    $0x2,%eax
  80007d:	01 d0                	add    %edx,%eax
  80007f:	01 c0                	add    %eax,%eax
  800081:	01 d0                	add    %edx,%eax
  800083:	01 c0                	add    %eax,%eax
  800085:	01 d0                	add    %edx,%eax
  800087:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80008e:	01 d0                	add    %edx,%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800098:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80009d:	a1 04 20 80 00       	mov    0x802004,%eax
  8000a2:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8000a8:	84 c0                	test   %al,%al
  8000aa:	74 0f                	je     8000bb <libmain+0x54>
		binaryname = myEnv->prog_name;
  8000ac:	a1 04 20 80 00       	mov    0x802004,%eax
  8000b1:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000b6:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000bf:	7e 0a                	jle    8000cb <libmain+0x64>
		binaryname = argv[0];
  8000c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000c4:	8b 00                	mov    (%eax),%eax
  8000c6:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000cb:	83 ec 08             	sub    $0x8,%esp
  8000ce:	ff 75 0c             	pushl  0xc(%ebp)
  8000d1:	ff 75 08             	pushl  0x8(%ebp)
  8000d4:	e8 5f ff ff ff       	call   800038 <_main>
  8000d9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000dc:	e8 2f 11 00 00       	call   801210 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000e1:	83 ec 0c             	sub    $0xc,%esp
  8000e4:	68 b4 18 80 00       	push   $0x8018b4
  8000e9:	e8 5c 01 00 00       	call   80024a <cprintf>
  8000ee:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000f1:	a1 04 20 80 00       	mov    0x802004,%eax
  8000f6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000fc:	a1 04 20 80 00       	mov    0x802004,%eax
  800101:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800107:	83 ec 04             	sub    $0x4,%esp
  80010a:	52                   	push   %edx
  80010b:	50                   	push   %eax
  80010c:	68 dc 18 80 00       	push   $0x8018dc
  800111:	e8 34 01 00 00       	call   80024a <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800119:	a1 04 20 80 00       	mov    0x802004,%eax
  80011e:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800124:	83 ec 08             	sub    $0x8,%esp
  800127:	50                   	push   %eax
  800128:	68 01 19 80 00       	push   $0x801901
  80012d:	e8 18 01 00 00       	call   80024a <cprintf>
  800132:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800135:	83 ec 0c             	sub    $0xc,%esp
  800138:	68 b4 18 80 00       	push   $0x8018b4
  80013d:	e8 08 01 00 00       	call   80024a <cprintf>
  800142:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800145:	e8 e0 10 00 00       	call   80122a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80014a:	e8 19 00 00 00       	call   800168 <exit>
}
  80014f:	90                   	nop
  800150:	c9                   	leave  
  800151:	c3                   	ret    

00800152 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800152:	55                   	push   %ebp
  800153:	89 e5                	mov    %esp,%ebp
  800155:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800158:	83 ec 0c             	sub    $0xc,%esp
  80015b:	6a 00                	push   $0x0
  80015d:	e8 df 0e 00 00       	call   801041 <sys_env_destroy>
  800162:	83 c4 10             	add    $0x10,%esp
}
  800165:	90                   	nop
  800166:	c9                   	leave  
  800167:	c3                   	ret    

00800168 <exit>:

void
exit(void)
{
  800168:	55                   	push   %ebp
  800169:	89 e5                	mov    %esp,%ebp
  80016b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80016e:	e8 34 0f 00 00       	call   8010a7 <sys_env_exit>
}
  800173:	90                   	nop
  800174:	c9                   	leave  
  800175:	c3                   	ret    

00800176 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800176:	55                   	push   %ebp
  800177:	89 e5                	mov    %esp,%ebp
  800179:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80017c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80017f:	8b 00                	mov    (%eax),%eax
  800181:	8d 48 01             	lea    0x1(%eax),%ecx
  800184:	8b 55 0c             	mov    0xc(%ebp),%edx
  800187:	89 0a                	mov    %ecx,(%edx)
  800189:	8b 55 08             	mov    0x8(%ebp),%edx
  80018c:	88 d1                	mov    %dl,%cl
  80018e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800191:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800195:	8b 45 0c             	mov    0xc(%ebp),%eax
  800198:	8b 00                	mov    (%eax),%eax
  80019a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80019f:	75 2c                	jne    8001cd <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001a1:	a0 08 20 80 00       	mov    0x802008,%al
  8001a6:	0f b6 c0             	movzbl %al,%eax
  8001a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ac:	8b 12                	mov    (%edx),%edx
  8001ae:	89 d1                	mov    %edx,%ecx
  8001b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b3:	83 c2 08             	add    $0x8,%edx
  8001b6:	83 ec 04             	sub    $0x4,%esp
  8001b9:	50                   	push   %eax
  8001ba:	51                   	push   %ecx
  8001bb:	52                   	push   %edx
  8001bc:	e8 3e 0e 00 00       	call   800fff <sys_cputs>
  8001c1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d0:	8b 40 04             	mov    0x4(%eax),%eax
  8001d3:	8d 50 01             	lea    0x1(%eax),%edx
  8001d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001dc:	90                   	nop
  8001dd:	c9                   	leave  
  8001de:	c3                   	ret    

008001df <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001df:	55                   	push   %ebp
  8001e0:	89 e5                	mov    %esp,%ebp
  8001e2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001e8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001ef:	00 00 00 
	b.cnt = 0;
  8001f2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001f9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001fc:	ff 75 0c             	pushl  0xc(%ebp)
  8001ff:	ff 75 08             	pushl  0x8(%ebp)
  800202:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800208:	50                   	push   %eax
  800209:	68 76 01 80 00       	push   $0x800176
  80020e:	e8 11 02 00 00       	call   800424 <vprintfmt>
  800213:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800216:	a0 08 20 80 00       	mov    0x802008,%al
  80021b:	0f b6 c0             	movzbl %al,%eax
  80021e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	50                   	push   %eax
  800228:	52                   	push   %edx
  800229:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80022f:	83 c0 08             	add    $0x8,%eax
  800232:	50                   	push   %eax
  800233:	e8 c7 0d 00 00       	call   800fff <sys_cputs>
  800238:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80023b:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  800242:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800248:	c9                   	leave  
  800249:	c3                   	ret    

0080024a <cprintf>:

int cprintf(const char *fmt, ...) {
  80024a:	55                   	push   %ebp
  80024b:	89 e5                	mov    %esp,%ebp
  80024d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800250:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  800257:	8d 45 0c             	lea    0xc(%ebp),%eax
  80025a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80025d:	8b 45 08             	mov    0x8(%ebp),%eax
  800260:	83 ec 08             	sub    $0x8,%esp
  800263:	ff 75 f4             	pushl  -0xc(%ebp)
  800266:	50                   	push   %eax
  800267:	e8 73 ff ff ff       	call   8001df <vcprintf>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800272:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800275:	c9                   	leave  
  800276:	c3                   	ret    

00800277 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800277:	55                   	push   %ebp
  800278:	89 e5                	mov    %esp,%ebp
  80027a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80027d:	e8 8e 0f 00 00       	call   801210 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800282:	8d 45 0c             	lea    0xc(%ebp),%eax
  800285:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800288:	8b 45 08             	mov    0x8(%ebp),%eax
  80028b:	83 ec 08             	sub    $0x8,%esp
  80028e:	ff 75 f4             	pushl  -0xc(%ebp)
  800291:	50                   	push   %eax
  800292:	e8 48 ff ff ff       	call   8001df <vcprintf>
  800297:	83 c4 10             	add    $0x10,%esp
  80029a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80029d:	e8 88 0f 00 00       	call   80122a <sys_enable_interrupt>
	return cnt;
  8002a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a5:	c9                   	leave  
  8002a6:	c3                   	ret    

008002a7 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002a7:	55                   	push   %ebp
  8002a8:	89 e5                	mov    %esp,%ebp
  8002aa:	53                   	push   %ebx
  8002ab:	83 ec 14             	sub    $0x14,%esp
  8002ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8002b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002ba:	8b 45 18             	mov    0x18(%ebp),%eax
  8002bd:	ba 00 00 00 00       	mov    $0x0,%edx
  8002c2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c5:	77 55                	ja     80031c <printnum+0x75>
  8002c7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002ca:	72 05                	jb     8002d1 <printnum+0x2a>
  8002cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002cf:	77 4b                	ja     80031c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002d1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002d4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002d7:	8b 45 18             	mov    0x18(%ebp),%eax
  8002da:	ba 00 00 00 00       	mov    $0x0,%edx
  8002df:	52                   	push   %edx
  8002e0:	50                   	push   %eax
  8002e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e4:	ff 75 f0             	pushl  -0x10(%ebp)
  8002e7:	e8 04 13 00 00       	call   8015f0 <__udivdi3>
  8002ec:	83 c4 10             	add    $0x10,%esp
  8002ef:	83 ec 04             	sub    $0x4,%esp
  8002f2:	ff 75 20             	pushl  0x20(%ebp)
  8002f5:	53                   	push   %ebx
  8002f6:	ff 75 18             	pushl  0x18(%ebp)
  8002f9:	52                   	push   %edx
  8002fa:	50                   	push   %eax
  8002fb:	ff 75 0c             	pushl  0xc(%ebp)
  8002fe:	ff 75 08             	pushl  0x8(%ebp)
  800301:	e8 a1 ff ff ff       	call   8002a7 <printnum>
  800306:	83 c4 20             	add    $0x20,%esp
  800309:	eb 1a                	jmp    800325 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80030b:	83 ec 08             	sub    $0x8,%esp
  80030e:	ff 75 0c             	pushl  0xc(%ebp)
  800311:	ff 75 20             	pushl  0x20(%ebp)
  800314:	8b 45 08             	mov    0x8(%ebp),%eax
  800317:	ff d0                	call   *%eax
  800319:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80031c:	ff 4d 1c             	decl   0x1c(%ebp)
  80031f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800323:	7f e6                	jg     80030b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800325:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800328:	bb 00 00 00 00       	mov    $0x0,%ebx
  80032d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800330:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800333:	53                   	push   %ebx
  800334:	51                   	push   %ecx
  800335:	52                   	push   %edx
  800336:	50                   	push   %eax
  800337:	e8 c4 13 00 00       	call   801700 <__umoddi3>
  80033c:	83 c4 10             	add    $0x10,%esp
  80033f:	05 34 1b 80 00       	add    $0x801b34,%eax
  800344:	8a 00                	mov    (%eax),%al
  800346:	0f be c0             	movsbl %al,%eax
  800349:	83 ec 08             	sub    $0x8,%esp
  80034c:	ff 75 0c             	pushl  0xc(%ebp)
  80034f:	50                   	push   %eax
  800350:	8b 45 08             	mov    0x8(%ebp),%eax
  800353:	ff d0                	call   *%eax
  800355:	83 c4 10             	add    $0x10,%esp
}
  800358:	90                   	nop
  800359:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80035c:	c9                   	leave  
  80035d:	c3                   	ret    

0080035e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80035e:	55                   	push   %ebp
  80035f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800361:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800365:	7e 1c                	jle    800383 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800367:	8b 45 08             	mov    0x8(%ebp),%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	8d 50 08             	lea    0x8(%eax),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	89 10                	mov    %edx,(%eax)
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	8b 00                	mov    (%eax),%eax
  800379:	83 e8 08             	sub    $0x8,%eax
  80037c:	8b 50 04             	mov    0x4(%eax),%edx
  80037f:	8b 00                	mov    (%eax),%eax
  800381:	eb 40                	jmp    8003c3 <getuint+0x65>
	else if (lflag)
  800383:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800387:	74 1e                	je     8003a7 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800389:	8b 45 08             	mov    0x8(%ebp),%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	8d 50 04             	lea    0x4(%eax),%edx
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	89 10                	mov    %edx,(%eax)
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	8b 00                	mov    (%eax),%eax
  80039b:	83 e8 04             	sub    $0x4,%eax
  80039e:	8b 00                	mov    (%eax),%eax
  8003a0:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a5:	eb 1c                	jmp    8003c3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	8b 00                	mov    (%eax),%eax
  8003ac:	8d 50 04             	lea    0x4(%eax),%edx
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	89 10                	mov    %edx,(%eax)
  8003b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	83 e8 04             	sub    $0x4,%eax
  8003bc:	8b 00                	mov    (%eax),%eax
  8003be:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003c3:	5d                   	pop    %ebp
  8003c4:	c3                   	ret    

008003c5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003c5:	55                   	push   %ebp
  8003c6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003cc:	7e 1c                	jle    8003ea <getint+0x25>
		return va_arg(*ap, long long);
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	8d 50 08             	lea    0x8(%eax),%edx
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	89 10                	mov    %edx,(%eax)
  8003db:	8b 45 08             	mov    0x8(%ebp),%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	83 e8 08             	sub    $0x8,%eax
  8003e3:	8b 50 04             	mov    0x4(%eax),%edx
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	eb 38                	jmp    800422 <getint+0x5d>
	else if (lflag)
  8003ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ee:	74 1a                	je     80040a <getint+0x45>
		return va_arg(*ap, long);
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	8d 50 04             	lea    0x4(%eax),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	89 10                	mov    %edx,(%eax)
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	83 e8 04             	sub    $0x4,%eax
  800405:	8b 00                	mov    (%eax),%eax
  800407:	99                   	cltd   
  800408:	eb 18                	jmp    800422 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	8d 50 04             	lea    0x4(%eax),%edx
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	89 10                	mov    %edx,(%eax)
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	83 e8 04             	sub    $0x4,%eax
  80041f:	8b 00                	mov    (%eax),%eax
  800421:	99                   	cltd   
}
  800422:	5d                   	pop    %ebp
  800423:	c3                   	ret    

00800424 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800424:	55                   	push   %ebp
  800425:	89 e5                	mov    %esp,%ebp
  800427:	56                   	push   %esi
  800428:	53                   	push   %ebx
  800429:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80042c:	eb 17                	jmp    800445 <vprintfmt+0x21>
			if (ch == '\0')
  80042e:	85 db                	test   %ebx,%ebx
  800430:	0f 84 af 03 00 00    	je     8007e5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800436:	83 ec 08             	sub    $0x8,%esp
  800439:	ff 75 0c             	pushl  0xc(%ebp)
  80043c:	53                   	push   %ebx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	ff d0                	call   *%eax
  800442:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800445:	8b 45 10             	mov    0x10(%ebp),%eax
  800448:	8d 50 01             	lea    0x1(%eax),%edx
  80044b:	89 55 10             	mov    %edx,0x10(%ebp)
  80044e:	8a 00                	mov    (%eax),%al
  800450:	0f b6 d8             	movzbl %al,%ebx
  800453:	83 fb 25             	cmp    $0x25,%ebx
  800456:	75 d6                	jne    80042e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800458:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80045c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800463:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80046a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800471:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800478:	8b 45 10             	mov    0x10(%ebp),%eax
  80047b:	8d 50 01             	lea    0x1(%eax),%edx
  80047e:	89 55 10             	mov    %edx,0x10(%ebp)
  800481:	8a 00                	mov    (%eax),%al
  800483:	0f b6 d8             	movzbl %al,%ebx
  800486:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800489:	83 f8 55             	cmp    $0x55,%eax
  80048c:	0f 87 2b 03 00 00    	ja     8007bd <vprintfmt+0x399>
  800492:	8b 04 85 58 1b 80 00 	mov    0x801b58(,%eax,4),%eax
  800499:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80049b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80049f:	eb d7                	jmp    800478 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004a1:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004a5:	eb d1                	jmp    800478 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004a7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004ae:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b1:	89 d0                	mov    %edx,%eax
  8004b3:	c1 e0 02             	shl    $0x2,%eax
  8004b6:	01 d0                	add    %edx,%eax
  8004b8:	01 c0                	add    %eax,%eax
  8004ba:	01 d8                	add    %ebx,%eax
  8004bc:	83 e8 30             	sub    $0x30,%eax
  8004bf:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c5:	8a 00                	mov    (%eax),%al
  8004c7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004ca:	83 fb 2f             	cmp    $0x2f,%ebx
  8004cd:	7e 3e                	jle    80050d <vprintfmt+0xe9>
  8004cf:	83 fb 39             	cmp    $0x39,%ebx
  8004d2:	7f 39                	jg     80050d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004d7:	eb d5                	jmp    8004ae <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8004dc:	83 c0 04             	add    $0x4,%eax
  8004df:	89 45 14             	mov    %eax,0x14(%ebp)
  8004e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e5:	83 e8 04             	sub    $0x4,%eax
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004ed:	eb 1f                	jmp    80050e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004f3:	79 83                	jns    800478 <vprintfmt+0x54>
				width = 0;
  8004f5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004fc:	e9 77 ff ff ff       	jmp    800478 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800501:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800508:	e9 6b ff ff ff       	jmp    800478 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80050d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80050e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800512:	0f 89 60 ff ff ff    	jns    800478 <vprintfmt+0x54>
				width = precision, precision = -1;
  800518:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80051e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800525:	e9 4e ff ff ff       	jmp    800478 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80052a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80052d:	e9 46 ff ff ff       	jmp    800478 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800532:	8b 45 14             	mov    0x14(%ebp),%eax
  800535:	83 c0 04             	add    $0x4,%eax
  800538:	89 45 14             	mov    %eax,0x14(%ebp)
  80053b:	8b 45 14             	mov    0x14(%ebp),%eax
  80053e:	83 e8 04             	sub    $0x4,%eax
  800541:	8b 00                	mov    (%eax),%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	ff 75 0c             	pushl  0xc(%ebp)
  800549:	50                   	push   %eax
  80054a:	8b 45 08             	mov    0x8(%ebp),%eax
  80054d:	ff d0                	call   *%eax
  80054f:	83 c4 10             	add    $0x10,%esp
			break;
  800552:	e9 89 02 00 00       	jmp    8007e0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800557:	8b 45 14             	mov    0x14(%ebp),%eax
  80055a:	83 c0 04             	add    $0x4,%eax
  80055d:	89 45 14             	mov    %eax,0x14(%ebp)
  800560:	8b 45 14             	mov    0x14(%ebp),%eax
  800563:	83 e8 04             	sub    $0x4,%eax
  800566:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800568:	85 db                	test   %ebx,%ebx
  80056a:	79 02                	jns    80056e <vprintfmt+0x14a>
				err = -err;
  80056c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80056e:	83 fb 64             	cmp    $0x64,%ebx
  800571:	7f 0b                	jg     80057e <vprintfmt+0x15a>
  800573:	8b 34 9d a0 19 80 00 	mov    0x8019a0(,%ebx,4),%esi
  80057a:	85 f6                	test   %esi,%esi
  80057c:	75 19                	jne    800597 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80057e:	53                   	push   %ebx
  80057f:	68 45 1b 80 00       	push   $0x801b45
  800584:	ff 75 0c             	pushl  0xc(%ebp)
  800587:	ff 75 08             	pushl  0x8(%ebp)
  80058a:	e8 5e 02 00 00       	call   8007ed <printfmt>
  80058f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800592:	e9 49 02 00 00       	jmp    8007e0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800597:	56                   	push   %esi
  800598:	68 4e 1b 80 00       	push   $0x801b4e
  80059d:	ff 75 0c             	pushl  0xc(%ebp)
  8005a0:	ff 75 08             	pushl  0x8(%ebp)
  8005a3:	e8 45 02 00 00       	call   8007ed <printfmt>
  8005a8:	83 c4 10             	add    $0x10,%esp
			break;
  8005ab:	e9 30 02 00 00       	jmp    8007e0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b3:	83 c0 04             	add    $0x4,%eax
  8005b6:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bc:	83 e8 04             	sub    $0x4,%eax
  8005bf:	8b 30                	mov    (%eax),%esi
  8005c1:	85 f6                	test   %esi,%esi
  8005c3:	75 05                	jne    8005ca <vprintfmt+0x1a6>
				p = "(null)";
  8005c5:	be 51 1b 80 00       	mov    $0x801b51,%esi
			if (width > 0 && padc != '-')
  8005ca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ce:	7e 6d                	jle    80063d <vprintfmt+0x219>
  8005d0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005d4:	74 67                	je     80063d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d9:	83 ec 08             	sub    $0x8,%esp
  8005dc:	50                   	push   %eax
  8005dd:	56                   	push   %esi
  8005de:	e8 0c 03 00 00       	call   8008ef <strnlen>
  8005e3:	83 c4 10             	add    $0x10,%esp
  8005e6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005e9:	eb 16                	jmp    800601 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005eb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005ef:	83 ec 08             	sub    $0x8,%esp
  8005f2:	ff 75 0c             	pushl  0xc(%ebp)
  8005f5:	50                   	push   %eax
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	ff d0                	call   *%eax
  8005fb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005fe:	ff 4d e4             	decl   -0x1c(%ebp)
  800601:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800605:	7f e4                	jg     8005eb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800607:	eb 34                	jmp    80063d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800609:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80060d:	74 1c                	je     80062b <vprintfmt+0x207>
  80060f:	83 fb 1f             	cmp    $0x1f,%ebx
  800612:	7e 05                	jle    800619 <vprintfmt+0x1f5>
  800614:	83 fb 7e             	cmp    $0x7e,%ebx
  800617:	7e 12                	jle    80062b <vprintfmt+0x207>
					putch('?', putdat);
  800619:	83 ec 08             	sub    $0x8,%esp
  80061c:	ff 75 0c             	pushl  0xc(%ebp)
  80061f:	6a 3f                	push   $0x3f
  800621:	8b 45 08             	mov    0x8(%ebp),%eax
  800624:	ff d0                	call   *%eax
  800626:	83 c4 10             	add    $0x10,%esp
  800629:	eb 0f                	jmp    80063a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80062b:	83 ec 08             	sub    $0x8,%esp
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	53                   	push   %ebx
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	ff d0                	call   *%eax
  800637:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80063a:	ff 4d e4             	decl   -0x1c(%ebp)
  80063d:	89 f0                	mov    %esi,%eax
  80063f:	8d 70 01             	lea    0x1(%eax),%esi
  800642:	8a 00                	mov    (%eax),%al
  800644:	0f be d8             	movsbl %al,%ebx
  800647:	85 db                	test   %ebx,%ebx
  800649:	74 24                	je     80066f <vprintfmt+0x24b>
  80064b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80064f:	78 b8                	js     800609 <vprintfmt+0x1e5>
  800651:	ff 4d e0             	decl   -0x20(%ebp)
  800654:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800658:	79 af                	jns    800609 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80065a:	eb 13                	jmp    80066f <vprintfmt+0x24b>
				putch(' ', putdat);
  80065c:	83 ec 08             	sub    $0x8,%esp
  80065f:	ff 75 0c             	pushl  0xc(%ebp)
  800662:	6a 20                	push   $0x20
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	ff d0                	call   *%eax
  800669:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80066c:	ff 4d e4             	decl   -0x1c(%ebp)
  80066f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800673:	7f e7                	jg     80065c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800675:	e9 66 01 00 00       	jmp    8007e0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 e8             	pushl  -0x18(%ebp)
  800680:	8d 45 14             	lea    0x14(%ebp),%eax
  800683:	50                   	push   %eax
  800684:	e8 3c fd ff ff       	call   8003c5 <getint>
  800689:	83 c4 10             	add    $0x10,%esp
  80068c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80068f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800692:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800695:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800698:	85 d2                	test   %edx,%edx
  80069a:	79 23                	jns    8006bf <vprintfmt+0x29b>
				putch('-', putdat);
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 0c             	pushl  0xc(%ebp)
  8006a2:	6a 2d                	push   $0x2d
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	ff d0                	call   *%eax
  8006a9:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b2:	f7 d8                	neg    %eax
  8006b4:	83 d2 00             	adc    $0x0,%edx
  8006b7:	f7 da                	neg    %edx
  8006b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006bc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006bf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006c6:	e9 bc 00 00 00       	jmp    800787 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006cb:	83 ec 08             	sub    $0x8,%esp
  8006ce:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d4:	50                   	push   %eax
  8006d5:	e8 84 fc ff ff       	call   80035e <getuint>
  8006da:	83 c4 10             	add    $0x10,%esp
  8006dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006e3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006ea:	e9 98 00 00 00       	jmp    800787 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006ef:	83 ec 08             	sub    $0x8,%esp
  8006f2:	ff 75 0c             	pushl  0xc(%ebp)
  8006f5:	6a 58                	push   $0x58
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	ff d0                	call   *%eax
  8006fc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006ff:	83 ec 08             	sub    $0x8,%esp
  800702:	ff 75 0c             	pushl  0xc(%ebp)
  800705:	6a 58                	push   $0x58
  800707:	8b 45 08             	mov    0x8(%ebp),%eax
  80070a:	ff d0                	call   *%eax
  80070c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80070f:	83 ec 08             	sub    $0x8,%esp
  800712:	ff 75 0c             	pushl  0xc(%ebp)
  800715:	6a 58                	push   $0x58
  800717:	8b 45 08             	mov    0x8(%ebp),%eax
  80071a:	ff d0                	call   *%eax
  80071c:	83 c4 10             	add    $0x10,%esp
			break;
  80071f:	e9 bc 00 00 00       	jmp    8007e0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800724:	83 ec 08             	sub    $0x8,%esp
  800727:	ff 75 0c             	pushl  0xc(%ebp)
  80072a:	6a 30                	push   $0x30
  80072c:	8b 45 08             	mov    0x8(%ebp),%eax
  80072f:	ff d0                	call   *%eax
  800731:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 0c             	pushl  0xc(%ebp)
  80073a:	6a 78                	push   $0x78
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	ff d0                	call   *%eax
  800741:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800744:	8b 45 14             	mov    0x14(%ebp),%eax
  800747:	83 c0 04             	add    $0x4,%eax
  80074a:	89 45 14             	mov    %eax,0x14(%ebp)
  80074d:	8b 45 14             	mov    0x14(%ebp),%eax
  800750:	83 e8 04             	sub    $0x4,%eax
  800753:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800755:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800758:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80075f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800766:	eb 1f                	jmp    800787 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	ff 75 e8             	pushl  -0x18(%ebp)
  80076e:	8d 45 14             	lea    0x14(%ebp),%eax
  800771:	50                   	push   %eax
  800772:	e8 e7 fb ff ff       	call   80035e <getuint>
  800777:	83 c4 10             	add    $0x10,%esp
  80077a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800780:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800787:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80078b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80078e:	83 ec 04             	sub    $0x4,%esp
  800791:	52                   	push   %edx
  800792:	ff 75 e4             	pushl  -0x1c(%ebp)
  800795:	50                   	push   %eax
  800796:	ff 75 f4             	pushl  -0xc(%ebp)
  800799:	ff 75 f0             	pushl  -0x10(%ebp)
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	ff 75 08             	pushl  0x8(%ebp)
  8007a2:	e8 00 fb ff ff       	call   8002a7 <printnum>
  8007a7:	83 c4 20             	add    $0x20,%esp
			break;
  8007aa:	eb 34                	jmp    8007e0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007ac:	83 ec 08             	sub    $0x8,%esp
  8007af:	ff 75 0c             	pushl  0xc(%ebp)
  8007b2:	53                   	push   %ebx
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	ff d0                	call   *%eax
  8007b8:	83 c4 10             	add    $0x10,%esp
			break;
  8007bb:	eb 23                	jmp    8007e0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	ff 75 0c             	pushl  0xc(%ebp)
  8007c3:	6a 25                	push   $0x25
  8007c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c8:	ff d0                	call   *%eax
  8007ca:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007cd:	ff 4d 10             	decl   0x10(%ebp)
  8007d0:	eb 03                	jmp    8007d5 <vprintfmt+0x3b1>
  8007d2:	ff 4d 10             	decl   0x10(%ebp)
  8007d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d8:	48                   	dec    %eax
  8007d9:	8a 00                	mov    (%eax),%al
  8007db:	3c 25                	cmp    $0x25,%al
  8007dd:	75 f3                	jne    8007d2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007df:	90                   	nop
		}
	}
  8007e0:	e9 47 fc ff ff       	jmp    80042c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007e5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007e9:	5b                   	pop    %ebx
  8007ea:	5e                   	pop    %esi
  8007eb:	5d                   	pop    %ebp
  8007ec:	c3                   	ret    

008007ed <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007ed:	55                   	push   %ebp
  8007ee:	89 e5                	mov    %esp,%ebp
  8007f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8007f6:	83 c0 04             	add    $0x4,%eax
  8007f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800802:	50                   	push   %eax
  800803:	ff 75 0c             	pushl  0xc(%ebp)
  800806:	ff 75 08             	pushl  0x8(%ebp)
  800809:	e8 16 fc ff ff       	call   800424 <vprintfmt>
  80080e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800811:	90                   	nop
  800812:	c9                   	leave  
  800813:	c3                   	ret    

00800814 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800814:	55                   	push   %ebp
  800815:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081a:	8b 40 08             	mov    0x8(%eax),%eax
  80081d:	8d 50 01             	lea    0x1(%eax),%edx
  800820:	8b 45 0c             	mov    0xc(%ebp),%eax
  800823:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800826:	8b 45 0c             	mov    0xc(%ebp),%eax
  800829:	8b 10                	mov    (%eax),%edx
  80082b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082e:	8b 40 04             	mov    0x4(%eax),%eax
  800831:	39 c2                	cmp    %eax,%edx
  800833:	73 12                	jae    800847 <sprintputch+0x33>
		*b->buf++ = ch;
  800835:	8b 45 0c             	mov    0xc(%ebp),%eax
  800838:	8b 00                	mov    (%eax),%eax
  80083a:	8d 48 01             	lea    0x1(%eax),%ecx
  80083d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800840:	89 0a                	mov    %ecx,(%edx)
  800842:	8b 55 08             	mov    0x8(%ebp),%edx
  800845:	88 10                	mov    %dl,(%eax)
}
  800847:	90                   	nop
  800848:	5d                   	pop    %ebp
  800849:	c3                   	ret    

0080084a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80084a:	55                   	push   %ebp
  80084b:	89 e5                	mov    %esp,%ebp
  80084d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800856:	8b 45 0c             	mov    0xc(%ebp),%eax
  800859:	8d 50 ff             	lea    -0x1(%eax),%edx
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	01 d0                	add    %edx,%eax
  800861:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800864:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80086b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80086f:	74 06                	je     800877 <vsnprintf+0x2d>
  800871:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800875:	7f 07                	jg     80087e <vsnprintf+0x34>
		return -E_INVAL;
  800877:	b8 03 00 00 00       	mov    $0x3,%eax
  80087c:	eb 20                	jmp    80089e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80087e:	ff 75 14             	pushl  0x14(%ebp)
  800881:	ff 75 10             	pushl  0x10(%ebp)
  800884:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800887:	50                   	push   %eax
  800888:	68 14 08 80 00       	push   $0x800814
  80088d:	e8 92 fb ff ff       	call   800424 <vprintfmt>
  800892:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800895:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800898:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80089b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80089e:	c9                   	leave  
  80089f:	c3                   	ret    

008008a0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008a0:	55                   	push   %ebp
  8008a1:	89 e5                	mov    %esp,%ebp
  8008a3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008a6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a9:	83 c0 04             	add    $0x4,%eax
  8008ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008af:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b5:	50                   	push   %eax
  8008b6:	ff 75 0c             	pushl  0xc(%ebp)
  8008b9:	ff 75 08             	pushl  0x8(%ebp)
  8008bc:	e8 89 ff ff ff       	call   80084a <vsnprintf>
  8008c1:	83 c4 10             	add    $0x10,%esp
  8008c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008ca:	c9                   	leave  
  8008cb:	c3                   	ret    

008008cc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008cc:	55                   	push   %ebp
  8008cd:	89 e5                	mov    %esp,%ebp
  8008cf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008d9:	eb 06                	jmp    8008e1 <strlen+0x15>
		n++;
  8008db:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008de:	ff 45 08             	incl   0x8(%ebp)
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	8a 00                	mov    (%eax),%al
  8008e6:	84 c0                	test   %al,%al
  8008e8:	75 f1                	jne    8008db <strlen+0xf>
		n++;
	return n;
  8008ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008ed:	c9                   	leave  
  8008ee:	c3                   	ret    

008008ef <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008ef:	55                   	push   %ebp
  8008f0:	89 e5                	mov    %esp,%ebp
  8008f2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008fc:	eb 09                	jmp    800907 <strnlen+0x18>
		n++;
  8008fe:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800901:	ff 45 08             	incl   0x8(%ebp)
  800904:	ff 4d 0c             	decl   0xc(%ebp)
  800907:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090b:	74 09                	je     800916 <strnlen+0x27>
  80090d:	8b 45 08             	mov    0x8(%ebp),%eax
  800910:	8a 00                	mov    (%eax),%al
  800912:	84 c0                	test   %al,%al
  800914:	75 e8                	jne    8008fe <strnlen+0xf>
		n++;
	return n;
  800916:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800919:	c9                   	leave  
  80091a:	c3                   	ret    

0080091b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80091b:	55                   	push   %ebp
  80091c:	89 e5                	mov    %esp,%ebp
  80091e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800927:	90                   	nop
  800928:	8b 45 08             	mov    0x8(%ebp),%eax
  80092b:	8d 50 01             	lea    0x1(%eax),%edx
  80092e:	89 55 08             	mov    %edx,0x8(%ebp)
  800931:	8b 55 0c             	mov    0xc(%ebp),%edx
  800934:	8d 4a 01             	lea    0x1(%edx),%ecx
  800937:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80093a:	8a 12                	mov    (%edx),%dl
  80093c:	88 10                	mov    %dl,(%eax)
  80093e:	8a 00                	mov    (%eax),%al
  800940:	84 c0                	test   %al,%al
  800942:	75 e4                	jne    800928 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800944:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800947:	c9                   	leave  
  800948:	c3                   	ret    

00800949 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800949:	55                   	push   %ebp
  80094a:	89 e5                	mov    %esp,%ebp
  80094c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80094f:	8b 45 08             	mov    0x8(%ebp),%eax
  800952:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800955:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095c:	eb 1f                	jmp    80097d <strncpy+0x34>
		*dst++ = *src;
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	8d 50 01             	lea    0x1(%eax),%edx
  800964:	89 55 08             	mov    %edx,0x8(%ebp)
  800967:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096a:	8a 12                	mov    (%edx),%dl
  80096c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80096e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800971:	8a 00                	mov    (%eax),%al
  800973:	84 c0                	test   %al,%al
  800975:	74 03                	je     80097a <strncpy+0x31>
			src++;
  800977:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80097a:	ff 45 fc             	incl   -0x4(%ebp)
  80097d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800980:	3b 45 10             	cmp    0x10(%ebp),%eax
  800983:	72 d9                	jb     80095e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800985:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800988:	c9                   	leave  
  800989:	c3                   	ret    

0080098a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80098a:	55                   	push   %ebp
  80098b:	89 e5                	mov    %esp,%ebp
  80098d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800996:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80099a:	74 30                	je     8009cc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80099c:	eb 16                	jmp    8009b4 <strlcpy+0x2a>
			*dst++ = *src++;
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	8d 50 01             	lea    0x1(%eax),%edx
  8009a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009b0:	8a 12                	mov    (%edx),%dl
  8009b2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009b4:	ff 4d 10             	decl   0x10(%ebp)
  8009b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009bb:	74 09                	je     8009c6 <strlcpy+0x3c>
  8009bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c0:	8a 00                	mov    (%eax),%al
  8009c2:	84 c0                	test   %al,%al
  8009c4:	75 d8                	jne    80099e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8009cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d2:	29 c2                	sub    %eax,%edx
  8009d4:	89 d0                	mov    %edx,%eax
}
  8009d6:	c9                   	leave  
  8009d7:	c3                   	ret    

008009d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009d8:	55                   	push   %ebp
  8009d9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009db:	eb 06                	jmp    8009e3 <strcmp+0xb>
		p++, q++;
  8009dd:	ff 45 08             	incl   0x8(%ebp)
  8009e0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	8a 00                	mov    (%eax),%al
  8009e8:	84 c0                	test   %al,%al
  8009ea:	74 0e                	je     8009fa <strcmp+0x22>
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	8a 10                	mov    (%eax),%dl
  8009f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f4:	8a 00                	mov    (%eax),%al
  8009f6:	38 c2                	cmp    %al,%dl
  8009f8:	74 e3                	je     8009dd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	8a 00                	mov    (%eax),%al
  8009ff:	0f b6 d0             	movzbl %al,%edx
  800a02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a05:	8a 00                	mov    (%eax),%al
  800a07:	0f b6 c0             	movzbl %al,%eax
  800a0a:	29 c2                	sub    %eax,%edx
  800a0c:	89 d0                	mov    %edx,%eax
}
  800a0e:	5d                   	pop    %ebp
  800a0f:	c3                   	ret    

00800a10 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a10:	55                   	push   %ebp
  800a11:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a13:	eb 09                	jmp    800a1e <strncmp+0xe>
		n--, p++, q++;
  800a15:	ff 4d 10             	decl   0x10(%ebp)
  800a18:	ff 45 08             	incl   0x8(%ebp)
  800a1b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a22:	74 17                	je     800a3b <strncmp+0x2b>
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	8a 00                	mov    (%eax),%al
  800a29:	84 c0                	test   %al,%al
  800a2b:	74 0e                	je     800a3b <strncmp+0x2b>
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	8a 10                	mov    (%eax),%dl
  800a32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a35:	8a 00                	mov    (%eax),%al
  800a37:	38 c2                	cmp    %al,%dl
  800a39:	74 da                	je     800a15 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a3b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a3f:	75 07                	jne    800a48 <strncmp+0x38>
		return 0;
  800a41:	b8 00 00 00 00       	mov    $0x0,%eax
  800a46:	eb 14                	jmp    800a5c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	8a 00                	mov    (%eax),%al
  800a4d:	0f b6 d0             	movzbl %al,%edx
  800a50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a53:	8a 00                	mov    (%eax),%al
  800a55:	0f b6 c0             	movzbl %al,%eax
  800a58:	29 c2                	sub    %eax,%edx
  800a5a:	89 d0                	mov    %edx,%eax
}
  800a5c:	5d                   	pop    %ebp
  800a5d:	c3                   	ret    

00800a5e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a5e:	55                   	push   %ebp
  800a5f:	89 e5                	mov    %esp,%ebp
  800a61:	83 ec 04             	sub    $0x4,%esp
  800a64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a67:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a6a:	eb 12                	jmp    800a7e <strchr+0x20>
		if (*s == c)
  800a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6f:	8a 00                	mov    (%eax),%al
  800a71:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a74:	75 05                	jne    800a7b <strchr+0x1d>
			return (char *) s;
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	eb 11                	jmp    800a8c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a7b:	ff 45 08             	incl   0x8(%ebp)
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	84 c0                	test   %al,%al
  800a85:	75 e5                	jne    800a6c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a87:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a8c:	c9                   	leave  
  800a8d:	c3                   	ret    

00800a8e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a8e:	55                   	push   %ebp
  800a8f:	89 e5                	mov    %esp,%ebp
  800a91:	83 ec 04             	sub    $0x4,%esp
  800a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a97:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a9a:	eb 0d                	jmp    800aa9 <strfind+0x1b>
		if (*s == c)
  800a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9f:	8a 00                	mov    (%eax),%al
  800aa1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa4:	74 0e                	je     800ab4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aa6:	ff 45 08             	incl   0x8(%ebp)
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	84 c0                	test   %al,%al
  800ab0:	75 ea                	jne    800a9c <strfind+0xe>
  800ab2:	eb 01                	jmp    800ab5 <strfind+0x27>
		if (*s == c)
			break;
  800ab4:	90                   	nop
	return (char *) s;
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ab8:	c9                   	leave  
  800ab9:	c3                   	ret    

00800aba <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aba:	55                   	push   %ebp
  800abb:	89 e5                	mov    %esp,%ebp
  800abd:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ac6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800acc:	eb 0e                	jmp    800adc <memset+0x22>
		*p++ = c;
  800ace:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ad1:	8d 50 01             	lea    0x1(%eax),%edx
  800ad4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ad7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ada:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800adc:	ff 4d f8             	decl   -0x8(%ebp)
  800adf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ae3:	79 e9                	jns    800ace <memset+0x14>
		*p++ = c;

	return v;
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae8:	c9                   	leave  
  800ae9:	c3                   	ret    

00800aea <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800aea:	55                   	push   %ebp
  800aeb:	89 e5                	mov    %esp,%ebp
  800aed:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800af0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800afc:	eb 16                	jmp    800b14 <memcpy+0x2a>
		*d++ = *s++;
  800afe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b01:	8d 50 01             	lea    0x1(%eax),%edx
  800b04:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b07:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b0a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b0d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b10:	8a 12                	mov    (%edx),%dl
  800b12:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b14:	8b 45 10             	mov    0x10(%ebp),%eax
  800b17:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b1d:	85 c0                	test   %eax,%eax
  800b1f:	75 dd                	jne    800afe <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b24:	c9                   	leave  
  800b25:	c3                   	ret    

00800b26 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b26:	55                   	push   %ebp
  800b27:	89 e5                	mov    %esp,%ebp
  800b29:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b3b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b3e:	73 50                	jae    800b90 <memmove+0x6a>
  800b40:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b43:	8b 45 10             	mov    0x10(%ebp),%eax
  800b46:	01 d0                	add    %edx,%eax
  800b48:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b4b:	76 43                	jbe    800b90 <memmove+0x6a>
		s += n;
  800b4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b50:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b53:	8b 45 10             	mov    0x10(%ebp),%eax
  800b56:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b59:	eb 10                	jmp    800b6b <memmove+0x45>
			*--d = *--s;
  800b5b:	ff 4d f8             	decl   -0x8(%ebp)
  800b5e:	ff 4d fc             	decl   -0x4(%ebp)
  800b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b64:	8a 10                	mov    (%eax),%dl
  800b66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b69:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b71:	89 55 10             	mov    %edx,0x10(%ebp)
  800b74:	85 c0                	test   %eax,%eax
  800b76:	75 e3                	jne    800b5b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b78:	eb 23                	jmp    800b9d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b7d:	8d 50 01             	lea    0x1(%eax),%edx
  800b80:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b83:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b86:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b89:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b8c:	8a 12                	mov    (%edx),%dl
  800b8e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b90:	8b 45 10             	mov    0x10(%ebp),%eax
  800b93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b96:	89 55 10             	mov    %edx,0x10(%ebp)
  800b99:	85 c0                	test   %eax,%eax
  800b9b:	75 dd                	jne    800b7a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bb4:	eb 2a                	jmp    800be0 <memcmp+0x3e>
		if (*s1 != *s2)
  800bb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb9:	8a 10                	mov    (%eax),%dl
  800bbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bbe:	8a 00                	mov    (%eax),%al
  800bc0:	38 c2                	cmp    %al,%dl
  800bc2:	74 16                	je     800bda <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	0f b6 d0             	movzbl %al,%edx
  800bcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bcf:	8a 00                	mov    (%eax),%al
  800bd1:	0f b6 c0             	movzbl %al,%eax
  800bd4:	29 c2                	sub    %eax,%edx
  800bd6:	89 d0                	mov    %edx,%eax
  800bd8:	eb 18                	jmp    800bf2 <memcmp+0x50>
		s1++, s2++;
  800bda:	ff 45 fc             	incl   -0x4(%ebp)
  800bdd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800be0:	8b 45 10             	mov    0x10(%ebp),%eax
  800be3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be6:	89 55 10             	mov    %edx,0x10(%ebp)
  800be9:	85 c0                	test   %eax,%eax
  800beb:	75 c9                	jne    800bb6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bf2:	c9                   	leave  
  800bf3:	c3                   	ret    

00800bf4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bf4:	55                   	push   %ebp
  800bf5:	89 e5                	mov    %esp,%ebp
  800bf7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bfa:	8b 55 08             	mov    0x8(%ebp),%edx
  800bfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800c00:	01 d0                	add    %edx,%eax
  800c02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c05:	eb 15                	jmp    800c1c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	0f b6 d0             	movzbl %al,%edx
  800c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c12:	0f b6 c0             	movzbl %al,%eax
  800c15:	39 c2                	cmp    %eax,%edx
  800c17:	74 0d                	je     800c26 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c19:	ff 45 08             	incl   0x8(%ebp)
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c22:	72 e3                	jb     800c07 <memfind+0x13>
  800c24:	eb 01                	jmp    800c27 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c26:	90                   	nop
	return (void *) s;
  800c27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c2a:	c9                   	leave  
  800c2b:	c3                   	ret    

00800c2c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
  800c2f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c39:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c40:	eb 03                	jmp    800c45 <strtol+0x19>
		s++;
  800c42:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	8a 00                	mov    (%eax),%al
  800c4a:	3c 20                	cmp    $0x20,%al
  800c4c:	74 f4                	je     800c42 <strtol+0x16>
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	3c 09                	cmp    $0x9,%al
  800c55:	74 eb                	je     800c42 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8a 00                	mov    (%eax),%al
  800c5c:	3c 2b                	cmp    $0x2b,%al
  800c5e:	75 05                	jne    800c65 <strtol+0x39>
		s++;
  800c60:	ff 45 08             	incl   0x8(%ebp)
  800c63:	eb 13                	jmp    800c78 <strtol+0x4c>
	else if (*s == '-')
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	3c 2d                	cmp    $0x2d,%al
  800c6c:	75 0a                	jne    800c78 <strtol+0x4c>
		s++, neg = 1;
  800c6e:	ff 45 08             	incl   0x8(%ebp)
  800c71:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7c:	74 06                	je     800c84 <strtol+0x58>
  800c7e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c82:	75 20                	jne    800ca4 <strtol+0x78>
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	3c 30                	cmp    $0x30,%al
  800c8b:	75 17                	jne    800ca4 <strtol+0x78>
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	40                   	inc    %eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	3c 78                	cmp    $0x78,%al
  800c95:	75 0d                	jne    800ca4 <strtol+0x78>
		s += 2, base = 16;
  800c97:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c9b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ca2:	eb 28                	jmp    800ccc <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ca4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca8:	75 15                	jne    800cbf <strtol+0x93>
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	3c 30                	cmp    $0x30,%al
  800cb1:	75 0c                	jne    800cbf <strtol+0x93>
		s++, base = 8;
  800cb3:	ff 45 08             	incl   0x8(%ebp)
  800cb6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cbd:	eb 0d                	jmp    800ccc <strtol+0xa0>
	else if (base == 0)
  800cbf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc3:	75 07                	jne    800ccc <strtol+0xa0>
		base = 10;
  800cc5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3c 2f                	cmp    $0x2f,%al
  800cd3:	7e 19                	jle    800cee <strtol+0xc2>
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	3c 39                	cmp    $0x39,%al
  800cdc:	7f 10                	jg     800cee <strtol+0xc2>
			dig = *s - '0';
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	8a 00                	mov    (%eax),%al
  800ce3:	0f be c0             	movsbl %al,%eax
  800ce6:	83 e8 30             	sub    $0x30,%eax
  800ce9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cec:	eb 42                	jmp    800d30 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3c 60                	cmp    $0x60,%al
  800cf5:	7e 19                	jle    800d10 <strtol+0xe4>
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3c 7a                	cmp    $0x7a,%al
  800cfe:	7f 10                	jg     800d10 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	0f be c0             	movsbl %al,%eax
  800d08:	83 e8 57             	sub    $0x57,%eax
  800d0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d0e:	eb 20                	jmp    800d30 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 40                	cmp    $0x40,%al
  800d17:	7e 39                	jle    800d52 <strtol+0x126>
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	3c 5a                	cmp    $0x5a,%al
  800d20:	7f 30                	jg     800d52 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	0f be c0             	movsbl %al,%eax
  800d2a:	83 e8 37             	sub    $0x37,%eax
  800d2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d33:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d36:	7d 19                	jge    800d51 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d38:	ff 45 08             	incl   0x8(%ebp)
  800d3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d3e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d42:	89 c2                	mov    %eax,%edx
  800d44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d47:	01 d0                	add    %edx,%eax
  800d49:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d4c:	e9 7b ff ff ff       	jmp    800ccc <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d51:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d56:	74 08                	je     800d60 <strtol+0x134>
		*endptr = (char *) s;
  800d58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d5e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d60:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d64:	74 07                	je     800d6d <strtol+0x141>
  800d66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d69:	f7 d8                	neg    %eax
  800d6b:	eb 03                	jmp    800d70 <strtol+0x144>
  800d6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d70:	c9                   	leave  
  800d71:	c3                   	ret    

00800d72 <ltostr>:

void
ltostr(long value, char *str)
{
  800d72:	55                   	push   %ebp
  800d73:	89 e5                	mov    %esp,%ebp
  800d75:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d7f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d86:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d8a:	79 13                	jns    800d9f <ltostr+0x2d>
	{
		neg = 1;
  800d8c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d99:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d9c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800da7:	99                   	cltd   
  800da8:	f7 f9                	idiv   %ecx
  800daa:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db0:	8d 50 01             	lea    0x1(%eax),%edx
  800db3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800db6:	89 c2                	mov    %eax,%edx
  800db8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbb:	01 d0                	add    %edx,%eax
  800dbd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dc0:	83 c2 30             	add    $0x30,%edx
  800dc3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dc5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dc8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dcd:	f7 e9                	imul   %ecx
  800dcf:	c1 fa 02             	sar    $0x2,%edx
  800dd2:	89 c8                	mov    %ecx,%eax
  800dd4:	c1 f8 1f             	sar    $0x1f,%eax
  800dd7:	29 c2                	sub    %eax,%edx
  800dd9:	89 d0                	mov    %edx,%eax
  800ddb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dde:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800de1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de6:	f7 e9                	imul   %ecx
  800de8:	c1 fa 02             	sar    $0x2,%edx
  800deb:	89 c8                	mov    %ecx,%eax
  800ded:	c1 f8 1f             	sar    $0x1f,%eax
  800df0:	29 c2                	sub    %eax,%edx
  800df2:	89 d0                	mov    %edx,%eax
  800df4:	c1 e0 02             	shl    $0x2,%eax
  800df7:	01 d0                	add    %edx,%eax
  800df9:	01 c0                	add    %eax,%eax
  800dfb:	29 c1                	sub    %eax,%ecx
  800dfd:	89 ca                	mov    %ecx,%edx
  800dff:	85 d2                	test   %edx,%edx
  800e01:	75 9c                	jne    800d9f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0d:	48                   	dec    %eax
  800e0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e11:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e15:	74 3d                	je     800e54 <ltostr+0xe2>
		start = 1 ;
  800e17:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e1e:	eb 34                	jmp    800e54 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	01 d0                	add    %edx,%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e33:	01 c2                	add    %eax,%edx
  800e35:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3b:	01 c8                	add    %ecx,%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e41:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	01 c2                	add    %eax,%edx
  800e49:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e4c:	88 02                	mov    %al,(%edx)
		start++ ;
  800e4e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e51:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e57:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e5a:	7c c4                	jl     800e20 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e5c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	01 d0                	add    %edx,%eax
  800e64:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e67:	90                   	nop
  800e68:	c9                   	leave  
  800e69:	c3                   	ret    

00800e6a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e6a:	55                   	push   %ebp
  800e6b:	89 e5                	mov    %esp,%ebp
  800e6d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e70:	ff 75 08             	pushl  0x8(%ebp)
  800e73:	e8 54 fa ff ff       	call   8008cc <strlen>
  800e78:	83 c4 04             	add    $0x4,%esp
  800e7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	e8 46 fa ff ff       	call   8008cc <strlen>
  800e86:	83 c4 04             	add    $0x4,%esp
  800e89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e8c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e9a:	eb 17                	jmp    800eb3 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea2:	01 c2                	add    %eax,%edx
  800ea4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	01 c8                	add    %ecx,%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eb0:	ff 45 fc             	incl   -0x4(%ebp)
  800eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eb9:	7c e1                	jl     800e9c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ebb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ec2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ec9:	eb 1f                	jmp    800eea <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ecb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ece:	8d 50 01             	lea    0x1(%eax),%edx
  800ed1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ed4:	89 c2                	mov    %eax,%edx
  800ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed9:	01 c2                	add    %eax,%edx
  800edb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ede:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee1:	01 c8                	add    %ecx,%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ee7:	ff 45 f8             	incl   -0x8(%ebp)
  800eea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ef0:	7c d9                	jl     800ecb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ef2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef8:	01 d0                	add    %edx,%eax
  800efa:	c6 00 00             	movb   $0x0,(%eax)
}
  800efd:	90                   	nop
  800efe:	c9                   	leave  
  800eff:	c3                   	ret    

00800f00 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f00:	55                   	push   %ebp
  800f01:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f03:	8b 45 14             	mov    0x14(%ebp),%eax
  800f06:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0f:	8b 00                	mov    (%eax),%eax
  800f11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f18:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1b:	01 d0                	add    %edx,%eax
  800f1d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f23:	eb 0c                	jmp    800f31 <strsplit+0x31>
			*string++ = 0;
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	8d 50 01             	lea    0x1(%eax),%edx
  800f2b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	84 c0                	test   %al,%al
  800f38:	74 18                	je     800f52 <strsplit+0x52>
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	0f be c0             	movsbl %al,%eax
  800f42:	50                   	push   %eax
  800f43:	ff 75 0c             	pushl  0xc(%ebp)
  800f46:	e8 13 fb ff ff       	call   800a5e <strchr>
  800f4b:	83 c4 08             	add    $0x8,%esp
  800f4e:	85 c0                	test   %eax,%eax
  800f50:	75 d3                	jne    800f25 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	84 c0                	test   %al,%al
  800f59:	74 5a                	je     800fb5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5e:	8b 00                	mov    (%eax),%eax
  800f60:	83 f8 0f             	cmp    $0xf,%eax
  800f63:	75 07                	jne    800f6c <strsplit+0x6c>
		{
			return 0;
  800f65:	b8 00 00 00 00       	mov    $0x0,%eax
  800f6a:	eb 66                	jmp    800fd2 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6f:	8b 00                	mov    (%eax),%eax
  800f71:	8d 48 01             	lea    0x1(%eax),%ecx
  800f74:	8b 55 14             	mov    0x14(%ebp),%edx
  800f77:	89 0a                	mov    %ecx,(%edx)
  800f79:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f80:	8b 45 10             	mov    0x10(%ebp),%eax
  800f83:	01 c2                	add    %eax,%edx
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f8a:	eb 03                	jmp    800f8f <strsplit+0x8f>
			string++;
  800f8c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	84 c0                	test   %al,%al
  800f96:	74 8b                	je     800f23 <strsplit+0x23>
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	0f be c0             	movsbl %al,%eax
  800fa0:	50                   	push   %eax
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	e8 b5 fa ff ff       	call   800a5e <strchr>
  800fa9:	83 c4 08             	add    $0x8,%esp
  800fac:	85 c0                	test   %eax,%eax
  800fae:	74 dc                	je     800f8c <strsplit+0x8c>
			string++;
	}
  800fb0:	e9 6e ff ff ff       	jmp    800f23 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fb5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb9:	8b 00                	mov    (%eax),%eax
  800fbb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc5:	01 d0                	add    %edx,%eax
  800fc7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fcd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fd2:	c9                   	leave  
  800fd3:	c3                   	ret    

00800fd4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	57                   	push   %edi
  800fd8:	56                   	push   %esi
  800fd9:	53                   	push   %ebx
  800fda:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fe3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fe6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fe9:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fec:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fef:	cd 30                	int    $0x30
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800ff4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff7:	83 c4 10             	add    $0x10,%esp
  800ffa:	5b                   	pop    %ebx
  800ffb:	5e                   	pop    %esi
  800ffc:	5f                   	pop    %edi
  800ffd:	5d                   	pop    %ebp
  800ffe:	c3                   	ret    

00800fff <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800fff:	55                   	push   %ebp
  801000:	89 e5                	mov    %esp,%ebp
  801002:	83 ec 04             	sub    $0x4,%esp
  801005:	8b 45 10             	mov    0x10(%ebp),%eax
  801008:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80100b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	6a 00                	push   $0x0
  801014:	6a 00                	push   $0x0
  801016:	52                   	push   %edx
  801017:	ff 75 0c             	pushl  0xc(%ebp)
  80101a:	50                   	push   %eax
  80101b:	6a 00                	push   $0x0
  80101d:	e8 b2 ff ff ff       	call   800fd4 <syscall>
  801022:	83 c4 18             	add    $0x18,%esp
}
  801025:	90                   	nop
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <sys_cgetc>:

int
sys_cgetc(void)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80102b:	6a 00                	push   $0x0
  80102d:	6a 00                	push   $0x0
  80102f:	6a 00                	push   $0x0
  801031:	6a 00                	push   $0x0
  801033:	6a 00                	push   $0x0
  801035:	6a 01                	push   $0x1
  801037:	e8 98 ff ff ff       	call   800fd4 <syscall>
  80103c:	83 c4 18             	add    $0x18,%esp
}
  80103f:	c9                   	leave  
  801040:	c3                   	ret    

00801041 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801041:	55                   	push   %ebp
  801042:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	6a 00                	push   $0x0
  801049:	6a 00                	push   $0x0
  80104b:	6a 00                	push   $0x0
  80104d:	6a 00                	push   $0x0
  80104f:	50                   	push   %eax
  801050:	6a 05                	push   $0x5
  801052:	e8 7d ff ff ff       	call   800fd4 <syscall>
  801057:	83 c4 18             	add    $0x18,%esp
}
  80105a:	c9                   	leave  
  80105b:	c3                   	ret    

0080105c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80105c:	55                   	push   %ebp
  80105d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80105f:	6a 00                	push   $0x0
  801061:	6a 00                	push   $0x0
  801063:	6a 00                	push   $0x0
  801065:	6a 00                	push   $0x0
  801067:	6a 00                	push   $0x0
  801069:	6a 02                	push   $0x2
  80106b:	e8 64 ff ff ff       	call   800fd4 <syscall>
  801070:	83 c4 18             	add    $0x18,%esp
}
  801073:	c9                   	leave  
  801074:	c3                   	ret    

00801075 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801075:	55                   	push   %ebp
  801076:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801078:	6a 00                	push   $0x0
  80107a:	6a 00                	push   $0x0
  80107c:	6a 00                	push   $0x0
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 03                	push   $0x3
  801084:	e8 4b ff ff ff       	call   800fd4 <syscall>
  801089:	83 c4 18             	add    $0x18,%esp
}
  80108c:	c9                   	leave  
  80108d:	c3                   	ret    

0080108e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 04                	push   $0x4
  80109d:	e8 32 ff ff ff       	call   800fd4 <syscall>
  8010a2:	83 c4 18             	add    $0x18,%esp
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <sys_env_exit>:


void sys_env_exit(void)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 06                	push   $0x6
  8010b6:	e8 19 ff ff ff       	call   800fd4 <syscall>
  8010bb:	83 c4 18             	add    $0x18,%esp
}
  8010be:	90                   	nop
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	52                   	push   %edx
  8010d1:	50                   	push   %eax
  8010d2:	6a 07                	push   $0x7
  8010d4:	e8 fb fe ff ff       	call   800fd4 <syscall>
  8010d9:	83 c4 18             	add    $0x18,%esp
}
  8010dc:	c9                   	leave  
  8010dd:	c3                   	ret    

008010de <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010de:	55                   	push   %ebp
  8010df:	89 e5                	mov    %esp,%ebp
  8010e1:	56                   	push   %esi
  8010e2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010e3:	8b 75 18             	mov    0x18(%ebp),%esi
  8010e6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f2:	56                   	push   %esi
  8010f3:	53                   	push   %ebx
  8010f4:	51                   	push   %ecx
  8010f5:	52                   	push   %edx
  8010f6:	50                   	push   %eax
  8010f7:	6a 08                	push   $0x8
  8010f9:	e8 d6 fe ff ff       	call   800fd4 <syscall>
  8010fe:	83 c4 18             	add    $0x18,%esp
}
  801101:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801104:	5b                   	pop    %ebx
  801105:	5e                   	pop    %esi
  801106:	5d                   	pop    %ebp
  801107:	c3                   	ret    

00801108 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801108:	55                   	push   %ebp
  801109:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80110b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	6a 00                	push   $0x0
  801113:	6a 00                	push   $0x0
  801115:	6a 00                	push   $0x0
  801117:	52                   	push   %edx
  801118:	50                   	push   %eax
  801119:	6a 09                	push   $0x9
  80111b:	e8 b4 fe ff ff       	call   800fd4 <syscall>
  801120:	83 c4 18             	add    $0x18,%esp
}
  801123:	c9                   	leave  
  801124:	c3                   	ret    

00801125 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801128:	6a 00                	push   $0x0
  80112a:	6a 00                	push   $0x0
  80112c:	6a 00                	push   $0x0
  80112e:	ff 75 0c             	pushl  0xc(%ebp)
  801131:	ff 75 08             	pushl  0x8(%ebp)
  801134:	6a 0a                	push   $0xa
  801136:	e8 99 fe ff ff       	call   800fd4 <syscall>
  80113b:	83 c4 18             	add    $0x18,%esp
}
  80113e:	c9                   	leave  
  80113f:	c3                   	ret    

00801140 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801140:	55                   	push   %ebp
  801141:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801143:	6a 00                	push   $0x0
  801145:	6a 00                	push   $0x0
  801147:	6a 00                	push   $0x0
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	6a 0b                	push   $0xb
  80114f:	e8 80 fe ff ff       	call   800fd4 <syscall>
  801154:	83 c4 18             	add    $0x18,%esp
}
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80115c:	6a 00                	push   $0x0
  80115e:	6a 00                	push   $0x0
  801160:	6a 00                	push   $0x0
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 0c                	push   $0xc
  801168:	e8 67 fe ff ff       	call   800fd4 <syscall>
  80116d:	83 c4 18             	add    $0x18,%esp
}
  801170:	c9                   	leave  
  801171:	c3                   	ret    

00801172 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801172:	55                   	push   %ebp
  801173:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801175:	6a 00                	push   $0x0
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 0d                	push   $0xd
  801181:	e8 4e fe ff ff       	call   800fd4 <syscall>
  801186:	83 c4 18             	add    $0x18,%esp
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80118e:	6a 00                	push   $0x0
  801190:	6a 00                	push   $0x0
  801192:	6a 00                	push   $0x0
  801194:	ff 75 0c             	pushl  0xc(%ebp)
  801197:	ff 75 08             	pushl  0x8(%ebp)
  80119a:	6a 11                	push   $0x11
  80119c:	e8 33 fe ff ff       	call   800fd4 <syscall>
  8011a1:	83 c4 18             	add    $0x18,%esp
	return;
  8011a4:	90                   	nop
}
  8011a5:	c9                   	leave  
  8011a6:	c3                   	ret    

008011a7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011a7:	55                   	push   %ebp
  8011a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	ff 75 0c             	pushl  0xc(%ebp)
  8011b3:	ff 75 08             	pushl  0x8(%ebp)
  8011b6:	6a 12                	push   $0x12
  8011b8:	e8 17 fe ff ff       	call   800fd4 <syscall>
  8011bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8011c0:	90                   	nop
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 0e                	push   $0xe
  8011d2:	e8 fd fd ff ff       	call   800fd4 <syscall>
  8011d7:	83 c4 18             	add    $0x18,%esp
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	ff 75 08             	pushl  0x8(%ebp)
  8011ea:	6a 0f                	push   $0xf
  8011ec:	e8 e3 fd ff ff       	call   800fd4 <syscall>
  8011f1:	83 c4 18             	add    $0x18,%esp
}
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 10                	push   $0x10
  801205:	e8 ca fd ff ff       	call   800fd4 <syscall>
  80120a:	83 c4 18             	add    $0x18,%esp
}
  80120d:	90                   	nop
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 14                	push   $0x14
  80121f:	e8 b0 fd ff ff       	call   800fd4 <syscall>
  801224:	83 c4 18             	add    $0x18,%esp
}
  801227:	90                   	nop
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 15                	push   $0x15
  801239:	e8 96 fd ff ff       	call   800fd4 <syscall>
  80123e:	83 c4 18             	add    $0x18,%esp
}
  801241:	90                   	nop
  801242:	c9                   	leave  
  801243:	c3                   	ret    

00801244 <sys_cputc>:


void
sys_cputc(const char c)
{
  801244:	55                   	push   %ebp
  801245:	89 e5                	mov    %esp,%ebp
  801247:	83 ec 04             	sub    $0x4,%esp
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801250:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801254:	6a 00                	push   $0x0
  801256:	6a 00                	push   $0x0
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	50                   	push   %eax
  80125d:	6a 16                	push   $0x16
  80125f:	e8 70 fd ff ff       	call   800fd4 <syscall>
  801264:	83 c4 18             	add    $0x18,%esp
}
  801267:	90                   	nop
  801268:	c9                   	leave  
  801269:	c3                   	ret    

0080126a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80126a:	55                   	push   %ebp
  80126b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 17                	push   $0x17
  801279:	e8 56 fd ff ff       	call   800fd4 <syscall>
  80127e:	83 c4 18             	add    $0x18,%esp
}
  801281:	90                   	nop
  801282:	c9                   	leave  
  801283:	c3                   	ret    

00801284 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801284:	55                   	push   %ebp
  801285:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801287:	8b 45 08             	mov    0x8(%ebp),%eax
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	ff 75 0c             	pushl  0xc(%ebp)
  801293:	50                   	push   %eax
  801294:	6a 18                	push   $0x18
  801296:	e8 39 fd ff ff       	call   800fd4 <syscall>
  80129b:	83 c4 18             	add    $0x18,%esp
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	52                   	push   %edx
  8012b0:	50                   	push   %eax
  8012b1:	6a 1b                	push   $0x1b
  8012b3:	e8 1c fd ff ff       	call   800fd4 <syscall>
  8012b8:	83 c4 18             	add    $0x18,%esp
}
  8012bb:	c9                   	leave  
  8012bc:	c3                   	ret    

008012bd <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012bd:	55                   	push   %ebp
  8012be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	52                   	push   %edx
  8012cd:	50                   	push   %eax
  8012ce:	6a 19                	push   $0x19
  8012d0:	e8 ff fc ff ff       	call   800fd4 <syscall>
  8012d5:	83 c4 18             	add    $0x18,%esp
}
  8012d8:	90                   	nop
  8012d9:	c9                   	leave  
  8012da:	c3                   	ret    

008012db <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012db:	55                   	push   %ebp
  8012dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	52                   	push   %edx
  8012eb:	50                   	push   %eax
  8012ec:	6a 1a                	push   $0x1a
  8012ee:	e8 e1 fc ff ff       	call   800fd4 <syscall>
  8012f3:	83 c4 18             	add    $0x18,%esp
}
  8012f6:	90                   	nop
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
  8012fc:	83 ec 04             	sub    $0x4,%esp
  8012ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801302:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801305:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801308:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	6a 00                	push   $0x0
  801311:	51                   	push   %ecx
  801312:	52                   	push   %edx
  801313:	ff 75 0c             	pushl  0xc(%ebp)
  801316:	50                   	push   %eax
  801317:	6a 1c                	push   $0x1c
  801319:	e8 b6 fc ff ff       	call   800fd4 <syscall>
  80131e:	83 c4 18             	add    $0x18,%esp
}
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	52                   	push   %edx
  801333:	50                   	push   %eax
  801334:	6a 1d                	push   $0x1d
  801336:	e8 99 fc ff ff       	call   800fd4 <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	c9                   	leave  
  80133f:	c3                   	ret    

00801340 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801343:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801346:	8b 55 0c             	mov    0xc(%ebp),%edx
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	51                   	push   %ecx
  801351:	52                   	push   %edx
  801352:	50                   	push   %eax
  801353:	6a 1e                	push   $0x1e
  801355:	e8 7a fc ff ff       	call   800fd4 <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801362:	8b 55 0c             	mov    0xc(%ebp),%edx
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	52                   	push   %edx
  80136f:	50                   	push   %eax
  801370:	6a 1f                	push   $0x1f
  801372:	e8 5d fc ff ff       	call   800fd4 <syscall>
  801377:	83 c4 18             	add    $0x18,%esp
}
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 20                	push   $0x20
  80138b:	e8 44 fc ff ff       	call   800fd4 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	ff 75 10             	pushl  0x10(%ebp)
  8013a2:	ff 75 0c             	pushl  0xc(%ebp)
  8013a5:	50                   	push   %eax
  8013a6:	6a 21                	push   $0x21
  8013a8:	e8 27 fc ff ff       	call   800fd4 <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	50                   	push   %eax
  8013c1:	6a 22                	push   $0x22
  8013c3:	e8 0c fc ff ff       	call   800fd4 <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	90                   	nop
  8013cc:	c9                   	leave  
  8013cd:	c3                   	ret    

008013ce <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013ce:	55                   	push   %ebp
  8013cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	50                   	push   %eax
  8013dd:	6a 23                	push   $0x23
  8013df:	e8 f0 fb ff ff       	call   800fd4 <syscall>
  8013e4:	83 c4 18             	add    $0x18,%esp
}
  8013e7:	90                   	nop
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
  8013ed:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013f0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f3:	8d 50 04             	lea    0x4(%eax),%edx
  8013f6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	52                   	push   %edx
  801400:	50                   	push   %eax
  801401:	6a 24                	push   $0x24
  801403:	e8 cc fb ff ff       	call   800fd4 <syscall>
  801408:	83 c4 18             	add    $0x18,%esp
	return result;
  80140b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80140e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801411:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801414:	89 01                	mov    %eax,(%ecx)
  801416:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	c9                   	leave  
  80141d:	c2 04 00             	ret    $0x4

00801420 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	ff 75 10             	pushl  0x10(%ebp)
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	ff 75 08             	pushl  0x8(%ebp)
  801430:	6a 13                	push   $0x13
  801432:	e8 9d fb ff ff       	call   800fd4 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
	return ;
  80143a:	90                   	nop
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_rcr2>:
uint32 sys_rcr2()
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 25                	push   $0x25
  80144c:	e8 83 fb ff ff       	call   800fd4 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
  801459:	83 ec 04             	sub    $0x4,%esp
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801462:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	50                   	push   %eax
  80146f:	6a 26                	push   $0x26
  801471:	e8 5e fb ff ff       	call   800fd4 <syscall>
  801476:	83 c4 18             	add    $0x18,%esp
	return ;
  801479:	90                   	nop
}
  80147a:	c9                   	leave  
  80147b:	c3                   	ret    

0080147c <rsttst>:
void rsttst()
{
  80147c:	55                   	push   %ebp
  80147d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 28                	push   $0x28
  80148b:	e8 44 fb ff ff       	call   800fd4 <syscall>
  801490:	83 c4 18             	add    $0x18,%esp
	return ;
  801493:	90                   	nop
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
  801499:	83 ec 04             	sub    $0x4,%esp
  80149c:	8b 45 14             	mov    0x14(%ebp),%eax
  80149f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014a2:	8b 55 18             	mov    0x18(%ebp),%edx
  8014a5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014a9:	52                   	push   %edx
  8014aa:	50                   	push   %eax
  8014ab:	ff 75 10             	pushl  0x10(%ebp)
  8014ae:	ff 75 0c             	pushl  0xc(%ebp)
  8014b1:	ff 75 08             	pushl  0x8(%ebp)
  8014b4:	6a 27                	push   $0x27
  8014b6:	e8 19 fb ff ff       	call   800fd4 <syscall>
  8014bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8014be:	90                   	nop
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <chktst>:
void chktst(uint32 n)
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	ff 75 08             	pushl  0x8(%ebp)
  8014cf:	6a 29                	push   $0x29
  8014d1:	e8 fe fa ff ff       	call   800fd4 <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d9:	90                   	nop
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <inctst>:

void inctst()
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 2a                	push   $0x2a
  8014eb:	e8 e4 fa ff ff       	call   800fd4 <syscall>
  8014f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f3:	90                   	nop
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <gettst>:
uint32 gettst()
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 2b                	push   $0x2b
  801505:	e8 ca fa ff ff       	call   800fd4 <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
  801512:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 2c                	push   $0x2c
  801521:	e8 ae fa ff ff       	call   800fd4 <syscall>
  801526:	83 c4 18             	add    $0x18,%esp
  801529:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80152c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801530:	75 07                	jne    801539 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801532:	b8 01 00 00 00       	mov    $0x1,%eax
  801537:	eb 05                	jmp    80153e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801539:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
  801543:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 2c                	push   $0x2c
  801552:	e8 7d fa ff ff       	call   800fd4 <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
  80155a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80155d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801561:	75 07                	jne    80156a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801563:	b8 01 00 00 00       	mov    $0x1,%eax
  801568:	eb 05                	jmp    80156f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80156a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156f:	c9                   	leave  
  801570:	c3                   	ret    

00801571 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
  801574:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 2c                	push   $0x2c
  801583:	e8 4c fa ff ff       	call   800fd4 <syscall>
  801588:	83 c4 18             	add    $0x18,%esp
  80158b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80158e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801592:	75 07                	jne    80159b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801594:	b8 01 00 00 00       	mov    $0x1,%eax
  801599:	eb 05                	jmp    8015a0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80159b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a0:	c9                   	leave  
  8015a1:	c3                   	ret    

008015a2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
  8015a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 2c                	push   $0x2c
  8015b4:	e8 1b fa ff ff       	call   800fd4 <syscall>
  8015b9:	83 c4 18             	add    $0x18,%esp
  8015bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015bf:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015c3:	75 07                	jne    8015cc <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ca:	eb 05                	jmp    8015d1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	ff 75 08             	pushl  0x8(%ebp)
  8015e1:	6a 2d                	push   $0x2d
  8015e3:	e8 ec f9 ff ff       	call   800fd4 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8015eb:	90                   	nop
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    
  8015ee:	66 90                	xchg   %ax,%ax

008015f0 <__udivdi3>:
  8015f0:	55                   	push   %ebp
  8015f1:	57                   	push   %edi
  8015f2:	56                   	push   %esi
  8015f3:	53                   	push   %ebx
  8015f4:	83 ec 1c             	sub    $0x1c,%esp
  8015f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801603:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801607:	89 ca                	mov    %ecx,%edx
  801609:	89 f8                	mov    %edi,%eax
  80160b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80160f:	85 f6                	test   %esi,%esi
  801611:	75 2d                	jne    801640 <__udivdi3+0x50>
  801613:	39 cf                	cmp    %ecx,%edi
  801615:	77 65                	ja     80167c <__udivdi3+0x8c>
  801617:	89 fd                	mov    %edi,%ebp
  801619:	85 ff                	test   %edi,%edi
  80161b:	75 0b                	jne    801628 <__udivdi3+0x38>
  80161d:	b8 01 00 00 00       	mov    $0x1,%eax
  801622:	31 d2                	xor    %edx,%edx
  801624:	f7 f7                	div    %edi
  801626:	89 c5                	mov    %eax,%ebp
  801628:	31 d2                	xor    %edx,%edx
  80162a:	89 c8                	mov    %ecx,%eax
  80162c:	f7 f5                	div    %ebp
  80162e:	89 c1                	mov    %eax,%ecx
  801630:	89 d8                	mov    %ebx,%eax
  801632:	f7 f5                	div    %ebp
  801634:	89 cf                	mov    %ecx,%edi
  801636:	89 fa                	mov    %edi,%edx
  801638:	83 c4 1c             	add    $0x1c,%esp
  80163b:	5b                   	pop    %ebx
  80163c:	5e                   	pop    %esi
  80163d:	5f                   	pop    %edi
  80163e:	5d                   	pop    %ebp
  80163f:	c3                   	ret    
  801640:	39 ce                	cmp    %ecx,%esi
  801642:	77 28                	ja     80166c <__udivdi3+0x7c>
  801644:	0f bd fe             	bsr    %esi,%edi
  801647:	83 f7 1f             	xor    $0x1f,%edi
  80164a:	75 40                	jne    80168c <__udivdi3+0x9c>
  80164c:	39 ce                	cmp    %ecx,%esi
  80164e:	72 0a                	jb     80165a <__udivdi3+0x6a>
  801650:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801654:	0f 87 9e 00 00 00    	ja     8016f8 <__udivdi3+0x108>
  80165a:	b8 01 00 00 00       	mov    $0x1,%eax
  80165f:	89 fa                	mov    %edi,%edx
  801661:	83 c4 1c             	add    $0x1c,%esp
  801664:	5b                   	pop    %ebx
  801665:	5e                   	pop    %esi
  801666:	5f                   	pop    %edi
  801667:	5d                   	pop    %ebp
  801668:	c3                   	ret    
  801669:	8d 76 00             	lea    0x0(%esi),%esi
  80166c:	31 ff                	xor    %edi,%edi
  80166e:	31 c0                	xor    %eax,%eax
  801670:	89 fa                	mov    %edi,%edx
  801672:	83 c4 1c             	add    $0x1c,%esp
  801675:	5b                   	pop    %ebx
  801676:	5e                   	pop    %esi
  801677:	5f                   	pop    %edi
  801678:	5d                   	pop    %ebp
  801679:	c3                   	ret    
  80167a:	66 90                	xchg   %ax,%ax
  80167c:	89 d8                	mov    %ebx,%eax
  80167e:	f7 f7                	div    %edi
  801680:	31 ff                	xor    %edi,%edi
  801682:	89 fa                	mov    %edi,%edx
  801684:	83 c4 1c             	add    $0x1c,%esp
  801687:	5b                   	pop    %ebx
  801688:	5e                   	pop    %esi
  801689:	5f                   	pop    %edi
  80168a:	5d                   	pop    %ebp
  80168b:	c3                   	ret    
  80168c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801691:	89 eb                	mov    %ebp,%ebx
  801693:	29 fb                	sub    %edi,%ebx
  801695:	89 f9                	mov    %edi,%ecx
  801697:	d3 e6                	shl    %cl,%esi
  801699:	89 c5                	mov    %eax,%ebp
  80169b:	88 d9                	mov    %bl,%cl
  80169d:	d3 ed                	shr    %cl,%ebp
  80169f:	89 e9                	mov    %ebp,%ecx
  8016a1:	09 f1                	or     %esi,%ecx
  8016a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016a7:	89 f9                	mov    %edi,%ecx
  8016a9:	d3 e0                	shl    %cl,%eax
  8016ab:	89 c5                	mov    %eax,%ebp
  8016ad:	89 d6                	mov    %edx,%esi
  8016af:	88 d9                	mov    %bl,%cl
  8016b1:	d3 ee                	shr    %cl,%esi
  8016b3:	89 f9                	mov    %edi,%ecx
  8016b5:	d3 e2                	shl    %cl,%edx
  8016b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016bb:	88 d9                	mov    %bl,%cl
  8016bd:	d3 e8                	shr    %cl,%eax
  8016bf:	09 c2                	or     %eax,%edx
  8016c1:	89 d0                	mov    %edx,%eax
  8016c3:	89 f2                	mov    %esi,%edx
  8016c5:	f7 74 24 0c          	divl   0xc(%esp)
  8016c9:	89 d6                	mov    %edx,%esi
  8016cb:	89 c3                	mov    %eax,%ebx
  8016cd:	f7 e5                	mul    %ebp
  8016cf:	39 d6                	cmp    %edx,%esi
  8016d1:	72 19                	jb     8016ec <__udivdi3+0xfc>
  8016d3:	74 0b                	je     8016e0 <__udivdi3+0xf0>
  8016d5:	89 d8                	mov    %ebx,%eax
  8016d7:	31 ff                	xor    %edi,%edi
  8016d9:	e9 58 ff ff ff       	jmp    801636 <__udivdi3+0x46>
  8016de:	66 90                	xchg   %ax,%ax
  8016e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016e4:	89 f9                	mov    %edi,%ecx
  8016e6:	d3 e2                	shl    %cl,%edx
  8016e8:	39 c2                	cmp    %eax,%edx
  8016ea:	73 e9                	jae    8016d5 <__udivdi3+0xe5>
  8016ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016ef:	31 ff                	xor    %edi,%edi
  8016f1:	e9 40 ff ff ff       	jmp    801636 <__udivdi3+0x46>
  8016f6:	66 90                	xchg   %ax,%ax
  8016f8:	31 c0                	xor    %eax,%eax
  8016fa:	e9 37 ff ff ff       	jmp    801636 <__udivdi3+0x46>
  8016ff:	90                   	nop

00801700 <__umoddi3>:
  801700:	55                   	push   %ebp
  801701:	57                   	push   %edi
  801702:	56                   	push   %esi
  801703:	53                   	push   %ebx
  801704:	83 ec 1c             	sub    $0x1c,%esp
  801707:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80170b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80170f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801713:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801717:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80171b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80171f:	89 f3                	mov    %esi,%ebx
  801721:	89 fa                	mov    %edi,%edx
  801723:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801727:	89 34 24             	mov    %esi,(%esp)
  80172a:	85 c0                	test   %eax,%eax
  80172c:	75 1a                	jne    801748 <__umoddi3+0x48>
  80172e:	39 f7                	cmp    %esi,%edi
  801730:	0f 86 a2 00 00 00    	jbe    8017d8 <__umoddi3+0xd8>
  801736:	89 c8                	mov    %ecx,%eax
  801738:	89 f2                	mov    %esi,%edx
  80173a:	f7 f7                	div    %edi
  80173c:	89 d0                	mov    %edx,%eax
  80173e:	31 d2                	xor    %edx,%edx
  801740:	83 c4 1c             	add    $0x1c,%esp
  801743:	5b                   	pop    %ebx
  801744:	5e                   	pop    %esi
  801745:	5f                   	pop    %edi
  801746:	5d                   	pop    %ebp
  801747:	c3                   	ret    
  801748:	39 f0                	cmp    %esi,%eax
  80174a:	0f 87 ac 00 00 00    	ja     8017fc <__umoddi3+0xfc>
  801750:	0f bd e8             	bsr    %eax,%ebp
  801753:	83 f5 1f             	xor    $0x1f,%ebp
  801756:	0f 84 ac 00 00 00    	je     801808 <__umoddi3+0x108>
  80175c:	bf 20 00 00 00       	mov    $0x20,%edi
  801761:	29 ef                	sub    %ebp,%edi
  801763:	89 fe                	mov    %edi,%esi
  801765:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801769:	89 e9                	mov    %ebp,%ecx
  80176b:	d3 e0                	shl    %cl,%eax
  80176d:	89 d7                	mov    %edx,%edi
  80176f:	89 f1                	mov    %esi,%ecx
  801771:	d3 ef                	shr    %cl,%edi
  801773:	09 c7                	or     %eax,%edi
  801775:	89 e9                	mov    %ebp,%ecx
  801777:	d3 e2                	shl    %cl,%edx
  801779:	89 14 24             	mov    %edx,(%esp)
  80177c:	89 d8                	mov    %ebx,%eax
  80177e:	d3 e0                	shl    %cl,%eax
  801780:	89 c2                	mov    %eax,%edx
  801782:	8b 44 24 08          	mov    0x8(%esp),%eax
  801786:	d3 e0                	shl    %cl,%eax
  801788:	89 44 24 04          	mov    %eax,0x4(%esp)
  80178c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801790:	89 f1                	mov    %esi,%ecx
  801792:	d3 e8                	shr    %cl,%eax
  801794:	09 d0                	or     %edx,%eax
  801796:	d3 eb                	shr    %cl,%ebx
  801798:	89 da                	mov    %ebx,%edx
  80179a:	f7 f7                	div    %edi
  80179c:	89 d3                	mov    %edx,%ebx
  80179e:	f7 24 24             	mull   (%esp)
  8017a1:	89 c6                	mov    %eax,%esi
  8017a3:	89 d1                	mov    %edx,%ecx
  8017a5:	39 d3                	cmp    %edx,%ebx
  8017a7:	0f 82 87 00 00 00    	jb     801834 <__umoddi3+0x134>
  8017ad:	0f 84 91 00 00 00    	je     801844 <__umoddi3+0x144>
  8017b3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8017b7:	29 f2                	sub    %esi,%edx
  8017b9:	19 cb                	sbb    %ecx,%ebx
  8017bb:	89 d8                	mov    %ebx,%eax
  8017bd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017c1:	d3 e0                	shl    %cl,%eax
  8017c3:	89 e9                	mov    %ebp,%ecx
  8017c5:	d3 ea                	shr    %cl,%edx
  8017c7:	09 d0                	or     %edx,%eax
  8017c9:	89 e9                	mov    %ebp,%ecx
  8017cb:	d3 eb                	shr    %cl,%ebx
  8017cd:	89 da                	mov    %ebx,%edx
  8017cf:	83 c4 1c             	add    $0x1c,%esp
  8017d2:	5b                   	pop    %ebx
  8017d3:	5e                   	pop    %esi
  8017d4:	5f                   	pop    %edi
  8017d5:	5d                   	pop    %ebp
  8017d6:	c3                   	ret    
  8017d7:	90                   	nop
  8017d8:	89 fd                	mov    %edi,%ebp
  8017da:	85 ff                	test   %edi,%edi
  8017dc:	75 0b                	jne    8017e9 <__umoddi3+0xe9>
  8017de:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e3:	31 d2                	xor    %edx,%edx
  8017e5:	f7 f7                	div    %edi
  8017e7:	89 c5                	mov    %eax,%ebp
  8017e9:	89 f0                	mov    %esi,%eax
  8017eb:	31 d2                	xor    %edx,%edx
  8017ed:	f7 f5                	div    %ebp
  8017ef:	89 c8                	mov    %ecx,%eax
  8017f1:	f7 f5                	div    %ebp
  8017f3:	89 d0                	mov    %edx,%eax
  8017f5:	e9 44 ff ff ff       	jmp    80173e <__umoddi3+0x3e>
  8017fa:	66 90                	xchg   %ax,%ax
  8017fc:	89 c8                	mov    %ecx,%eax
  8017fe:	89 f2                	mov    %esi,%edx
  801800:	83 c4 1c             	add    $0x1c,%esp
  801803:	5b                   	pop    %ebx
  801804:	5e                   	pop    %esi
  801805:	5f                   	pop    %edi
  801806:	5d                   	pop    %ebp
  801807:	c3                   	ret    
  801808:	3b 04 24             	cmp    (%esp),%eax
  80180b:	72 06                	jb     801813 <__umoddi3+0x113>
  80180d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801811:	77 0f                	ja     801822 <__umoddi3+0x122>
  801813:	89 f2                	mov    %esi,%edx
  801815:	29 f9                	sub    %edi,%ecx
  801817:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80181b:	89 14 24             	mov    %edx,(%esp)
  80181e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801822:	8b 44 24 04          	mov    0x4(%esp),%eax
  801826:	8b 14 24             	mov    (%esp),%edx
  801829:	83 c4 1c             	add    $0x1c,%esp
  80182c:	5b                   	pop    %ebx
  80182d:	5e                   	pop    %esi
  80182e:	5f                   	pop    %edi
  80182f:	5d                   	pop    %ebp
  801830:	c3                   	ret    
  801831:	8d 76 00             	lea    0x0(%esi),%esi
  801834:	2b 04 24             	sub    (%esp),%eax
  801837:	19 fa                	sbb    %edi,%edx
  801839:	89 d1                	mov    %edx,%ecx
  80183b:	89 c6                	mov    %eax,%esi
  80183d:	e9 71 ff ff ff       	jmp    8017b3 <__umoddi3+0xb3>
  801842:	66 90                	xchg   %ax,%ax
  801844:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801848:	72 ea                	jb     801834 <__umoddi3+0x134>
  80184a:	89 d9                	mov    %ebx,%ecx
  80184c:	e9 62 ff ff ff       	jmp    8017b3 <__umoddi3+0xb3>
