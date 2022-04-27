
obj/user/fos_static_data_section:     file format elf32-i386


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
  800031:	e8 1b 00 00 00       	call   800051 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

/// Adding array of 20000 integer on user data section
int arr[20000];

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	atomic_cprintf("user data section contains 20,000 integer\n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 40 18 80 00       	push   $0x801840
  800046:	e8 16 02 00 00       	call   800261 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	
	return;	
  80004e:	90                   	nop
}
  80004f:	c9                   	leave  
  800050:	c3                   	ret    

00800051 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800051:	55                   	push   %ebp
  800052:	89 e5                	mov    %esp,%ebp
  800054:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800057:	e8 03 10 00 00       	call   80105f <sys_getenvindex>
  80005c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80005f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800062:	89 d0                	mov    %edx,%eax
  800064:	c1 e0 02             	shl    $0x2,%eax
  800067:	01 d0                	add    %edx,%eax
  800069:	01 c0                	add    %eax,%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	01 c0                	add    %eax,%eax
  80006f:	01 d0                	add    %edx,%eax
  800071:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800078:	01 d0                	add    %edx,%eax
  80007a:	c1 e0 02             	shl    $0x2,%eax
  80007d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800082:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800087:	a1 20 20 80 00       	mov    0x802020,%eax
  80008c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800092:	84 c0                	test   %al,%al
  800094:	74 0f                	je     8000a5 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800096:	a1 20 20 80 00       	mov    0x802020,%eax
  80009b:	05 f4 02 00 00       	add    $0x2f4,%eax
  8000a0:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000a5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000a9:	7e 0a                	jle    8000b5 <libmain+0x64>
		binaryname = argv[0];
  8000ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000ae:	8b 00                	mov    (%eax),%eax
  8000b0:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000b5:	83 ec 08             	sub    $0x8,%esp
  8000b8:	ff 75 0c             	pushl  0xc(%ebp)
  8000bb:	ff 75 08             	pushl  0x8(%ebp)
  8000be:	e8 75 ff ff ff       	call   800038 <_main>
  8000c3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000c6:	e8 2f 11 00 00       	call   8011fa <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	68 84 18 80 00       	push   $0x801884
  8000d3:	e8 5c 01 00 00       	call   800234 <cprintf>
  8000d8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000db:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e0:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8000e6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000eb:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8000f1:	83 ec 04             	sub    $0x4,%esp
  8000f4:	52                   	push   %edx
  8000f5:	50                   	push   %eax
  8000f6:	68 ac 18 80 00       	push   $0x8018ac
  8000fb:	e8 34 01 00 00       	call   800234 <cprintf>
  800100:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800103:	a1 20 20 80 00       	mov    0x802020,%eax
  800108:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80010e:	83 ec 08             	sub    $0x8,%esp
  800111:	50                   	push   %eax
  800112:	68 d1 18 80 00       	push   $0x8018d1
  800117:	e8 18 01 00 00       	call   800234 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	68 84 18 80 00       	push   $0x801884
  800127:	e8 08 01 00 00       	call   800234 <cprintf>
  80012c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80012f:	e8 e0 10 00 00       	call   801214 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800134:	e8 19 00 00 00       	call   800152 <exit>
}
  800139:	90                   	nop
  80013a:	c9                   	leave  
  80013b:	c3                   	ret    

0080013c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80013c:	55                   	push   %ebp
  80013d:	89 e5                	mov    %esp,%ebp
  80013f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800142:	83 ec 0c             	sub    $0xc,%esp
  800145:	6a 00                	push   $0x0
  800147:	e8 df 0e 00 00       	call   80102b <sys_env_destroy>
  80014c:	83 c4 10             	add    $0x10,%esp
}
  80014f:	90                   	nop
  800150:	c9                   	leave  
  800151:	c3                   	ret    

00800152 <exit>:

void
exit(void)
{
  800152:	55                   	push   %ebp
  800153:	89 e5                	mov    %esp,%ebp
  800155:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800158:	e8 34 0f 00 00       	call   801091 <sys_env_exit>
}
  80015d:	90                   	nop
  80015e:	c9                   	leave  
  80015f:	c3                   	ret    

00800160 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800160:	55                   	push   %ebp
  800161:	89 e5                	mov    %esp,%ebp
  800163:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800166:	8b 45 0c             	mov    0xc(%ebp),%eax
  800169:	8b 00                	mov    (%eax),%eax
  80016b:	8d 48 01             	lea    0x1(%eax),%ecx
  80016e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800171:	89 0a                	mov    %ecx,(%edx)
  800173:	8b 55 08             	mov    0x8(%ebp),%edx
  800176:	88 d1                	mov    %dl,%cl
  800178:	8b 55 0c             	mov    0xc(%ebp),%edx
  80017b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80017f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800182:	8b 00                	mov    (%eax),%eax
  800184:	3d ff 00 00 00       	cmp    $0xff,%eax
  800189:	75 2c                	jne    8001b7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80018b:	a0 24 20 80 00       	mov    0x802024,%al
  800190:	0f b6 c0             	movzbl %al,%eax
  800193:	8b 55 0c             	mov    0xc(%ebp),%edx
  800196:	8b 12                	mov    (%edx),%edx
  800198:	89 d1                	mov    %edx,%ecx
  80019a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80019d:	83 c2 08             	add    $0x8,%edx
  8001a0:	83 ec 04             	sub    $0x4,%esp
  8001a3:	50                   	push   %eax
  8001a4:	51                   	push   %ecx
  8001a5:	52                   	push   %edx
  8001a6:	e8 3e 0e 00 00       	call   800fe9 <sys_cputs>
  8001ab:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ba:	8b 40 04             	mov    0x4(%eax),%eax
  8001bd:	8d 50 01             	lea    0x1(%eax),%edx
  8001c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001c6:	90                   	nop
  8001c7:	c9                   	leave  
  8001c8:	c3                   	ret    

008001c9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001c9:	55                   	push   %ebp
  8001ca:	89 e5                	mov    %esp,%ebp
  8001cc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001d2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001d9:	00 00 00 
	b.cnt = 0;
  8001dc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001e3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001e6:	ff 75 0c             	pushl  0xc(%ebp)
  8001e9:	ff 75 08             	pushl  0x8(%ebp)
  8001ec:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001f2:	50                   	push   %eax
  8001f3:	68 60 01 80 00       	push   $0x800160
  8001f8:	e8 11 02 00 00       	call   80040e <vprintfmt>
  8001fd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800200:	a0 24 20 80 00       	mov    0x802024,%al
  800205:	0f b6 c0             	movzbl %al,%eax
  800208:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	50                   	push   %eax
  800212:	52                   	push   %edx
  800213:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800219:	83 c0 08             	add    $0x8,%eax
  80021c:	50                   	push   %eax
  80021d:	e8 c7 0d 00 00       	call   800fe9 <sys_cputs>
  800222:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800225:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80022c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800232:	c9                   	leave  
  800233:	c3                   	ret    

00800234 <cprintf>:

int cprintf(const char *fmt, ...) {
  800234:	55                   	push   %ebp
  800235:	89 e5                	mov    %esp,%ebp
  800237:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80023a:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800241:	8d 45 0c             	lea    0xc(%ebp),%eax
  800244:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800247:	8b 45 08             	mov    0x8(%ebp),%eax
  80024a:	83 ec 08             	sub    $0x8,%esp
  80024d:	ff 75 f4             	pushl  -0xc(%ebp)
  800250:	50                   	push   %eax
  800251:	e8 73 ff ff ff       	call   8001c9 <vcprintf>
  800256:	83 c4 10             	add    $0x10,%esp
  800259:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80025c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80025f:	c9                   	leave  
  800260:	c3                   	ret    

00800261 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800261:	55                   	push   %ebp
  800262:	89 e5                	mov    %esp,%ebp
  800264:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800267:	e8 8e 0f 00 00       	call   8011fa <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80026c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80026f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800272:	8b 45 08             	mov    0x8(%ebp),%eax
  800275:	83 ec 08             	sub    $0x8,%esp
  800278:	ff 75 f4             	pushl  -0xc(%ebp)
  80027b:	50                   	push   %eax
  80027c:	e8 48 ff ff ff       	call   8001c9 <vcprintf>
  800281:	83 c4 10             	add    $0x10,%esp
  800284:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800287:	e8 88 0f 00 00       	call   801214 <sys_enable_interrupt>
	return cnt;
  80028c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80028f:	c9                   	leave  
  800290:	c3                   	ret    

00800291 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800291:	55                   	push   %ebp
  800292:	89 e5                	mov    %esp,%ebp
  800294:	53                   	push   %ebx
  800295:	83 ec 14             	sub    $0x14,%esp
  800298:	8b 45 10             	mov    0x10(%ebp),%eax
  80029b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80029e:	8b 45 14             	mov    0x14(%ebp),%eax
  8002a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002a4:	8b 45 18             	mov    0x18(%ebp),%eax
  8002a7:	ba 00 00 00 00       	mov    $0x0,%edx
  8002ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002af:	77 55                	ja     800306 <printnum+0x75>
  8002b1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002b4:	72 05                	jb     8002bb <printnum+0x2a>
  8002b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002b9:	77 4b                	ja     800306 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002bb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002be:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002c1:	8b 45 18             	mov    0x18(%ebp),%eax
  8002c4:	ba 00 00 00 00       	mov    $0x0,%edx
  8002c9:	52                   	push   %edx
  8002ca:	50                   	push   %eax
  8002cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ce:	ff 75 f0             	pushl  -0x10(%ebp)
  8002d1:	e8 02 13 00 00       	call   8015d8 <__udivdi3>
  8002d6:	83 c4 10             	add    $0x10,%esp
  8002d9:	83 ec 04             	sub    $0x4,%esp
  8002dc:	ff 75 20             	pushl  0x20(%ebp)
  8002df:	53                   	push   %ebx
  8002e0:	ff 75 18             	pushl  0x18(%ebp)
  8002e3:	52                   	push   %edx
  8002e4:	50                   	push   %eax
  8002e5:	ff 75 0c             	pushl  0xc(%ebp)
  8002e8:	ff 75 08             	pushl  0x8(%ebp)
  8002eb:	e8 a1 ff ff ff       	call   800291 <printnum>
  8002f0:	83 c4 20             	add    $0x20,%esp
  8002f3:	eb 1a                	jmp    80030f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8002f5:	83 ec 08             	sub    $0x8,%esp
  8002f8:	ff 75 0c             	pushl  0xc(%ebp)
  8002fb:	ff 75 20             	pushl  0x20(%ebp)
  8002fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800301:	ff d0                	call   *%eax
  800303:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800306:	ff 4d 1c             	decl   0x1c(%ebp)
  800309:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80030d:	7f e6                	jg     8002f5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80030f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800312:	bb 00 00 00 00       	mov    $0x0,%ebx
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80031d:	53                   	push   %ebx
  80031e:	51                   	push   %ecx
  80031f:	52                   	push   %edx
  800320:	50                   	push   %eax
  800321:	e8 c2 13 00 00       	call   8016e8 <__umoddi3>
  800326:	83 c4 10             	add    $0x10,%esp
  800329:	05 14 1b 80 00       	add    $0x801b14,%eax
  80032e:	8a 00                	mov    (%eax),%al
  800330:	0f be c0             	movsbl %al,%eax
  800333:	83 ec 08             	sub    $0x8,%esp
  800336:	ff 75 0c             	pushl  0xc(%ebp)
  800339:	50                   	push   %eax
  80033a:	8b 45 08             	mov    0x8(%ebp),%eax
  80033d:	ff d0                	call   *%eax
  80033f:	83 c4 10             	add    $0x10,%esp
}
  800342:	90                   	nop
  800343:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800346:	c9                   	leave  
  800347:	c3                   	ret    

00800348 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800348:	55                   	push   %ebp
  800349:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80034b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80034f:	7e 1c                	jle    80036d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800351:	8b 45 08             	mov    0x8(%ebp),%eax
  800354:	8b 00                	mov    (%eax),%eax
  800356:	8d 50 08             	lea    0x8(%eax),%edx
  800359:	8b 45 08             	mov    0x8(%ebp),%eax
  80035c:	89 10                	mov    %edx,(%eax)
  80035e:	8b 45 08             	mov    0x8(%ebp),%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	83 e8 08             	sub    $0x8,%eax
  800366:	8b 50 04             	mov    0x4(%eax),%edx
  800369:	8b 00                	mov    (%eax),%eax
  80036b:	eb 40                	jmp    8003ad <getuint+0x65>
	else if (lflag)
  80036d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800371:	74 1e                	je     800391 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800373:	8b 45 08             	mov    0x8(%ebp),%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	8d 50 04             	lea    0x4(%eax),%edx
  80037b:	8b 45 08             	mov    0x8(%ebp),%eax
  80037e:	89 10                	mov    %edx,(%eax)
  800380:	8b 45 08             	mov    0x8(%ebp),%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	83 e8 04             	sub    $0x4,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	ba 00 00 00 00       	mov    $0x0,%edx
  80038f:	eb 1c                	jmp    8003ad <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	8b 00                	mov    (%eax),%eax
  800396:	8d 50 04             	lea    0x4(%eax),%edx
  800399:	8b 45 08             	mov    0x8(%ebp),%eax
  80039c:	89 10                	mov    %edx,(%eax)
  80039e:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	83 e8 04             	sub    $0x4,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003ad:	5d                   	pop    %ebp
  8003ae:	c3                   	ret    

008003af <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003af:	55                   	push   %ebp
  8003b0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003b6:	7e 1c                	jle    8003d4 <getint+0x25>
		return va_arg(*ap, long long);
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
  8003d2:	eb 38                	jmp    80040c <getint+0x5d>
	else if (lflag)
  8003d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003d8:	74 1a                	je     8003f4 <getint+0x45>
		return va_arg(*ap, long);
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	8d 50 04             	lea    0x4(%eax),%edx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	89 10                	mov    %edx,(%eax)
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	83 e8 04             	sub    $0x4,%eax
  8003ef:	8b 00                	mov    (%eax),%eax
  8003f1:	99                   	cltd   
  8003f2:	eb 18                	jmp    80040c <getint+0x5d>
	else
		return va_arg(*ap, int);
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	8d 50 04             	lea    0x4(%eax),%edx
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	89 10                	mov    %edx,(%eax)
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	83 e8 04             	sub    $0x4,%eax
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	99                   	cltd   
}
  80040c:	5d                   	pop    %ebp
  80040d:	c3                   	ret    

0080040e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80040e:	55                   	push   %ebp
  80040f:	89 e5                	mov    %esp,%ebp
  800411:	56                   	push   %esi
  800412:	53                   	push   %ebx
  800413:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800416:	eb 17                	jmp    80042f <vprintfmt+0x21>
			if (ch == '\0')
  800418:	85 db                	test   %ebx,%ebx
  80041a:	0f 84 af 03 00 00    	je     8007cf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800420:	83 ec 08             	sub    $0x8,%esp
  800423:	ff 75 0c             	pushl  0xc(%ebp)
  800426:	53                   	push   %ebx
  800427:	8b 45 08             	mov    0x8(%ebp),%eax
  80042a:	ff d0                	call   *%eax
  80042c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80042f:	8b 45 10             	mov    0x10(%ebp),%eax
  800432:	8d 50 01             	lea    0x1(%eax),%edx
  800435:	89 55 10             	mov    %edx,0x10(%ebp)
  800438:	8a 00                	mov    (%eax),%al
  80043a:	0f b6 d8             	movzbl %al,%ebx
  80043d:	83 fb 25             	cmp    $0x25,%ebx
  800440:	75 d6                	jne    800418 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800442:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800446:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80044d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800454:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80045b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800462:	8b 45 10             	mov    0x10(%ebp),%eax
  800465:	8d 50 01             	lea    0x1(%eax),%edx
  800468:	89 55 10             	mov    %edx,0x10(%ebp)
  80046b:	8a 00                	mov    (%eax),%al
  80046d:	0f b6 d8             	movzbl %al,%ebx
  800470:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800473:	83 f8 55             	cmp    $0x55,%eax
  800476:	0f 87 2b 03 00 00    	ja     8007a7 <vprintfmt+0x399>
  80047c:	8b 04 85 38 1b 80 00 	mov    0x801b38(,%eax,4),%eax
  800483:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800485:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800489:	eb d7                	jmp    800462 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80048b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80048f:	eb d1                	jmp    800462 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800491:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800498:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80049b:	89 d0                	mov    %edx,%eax
  80049d:	c1 e0 02             	shl    $0x2,%eax
  8004a0:	01 d0                	add    %edx,%eax
  8004a2:	01 c0                	add    %eax,%eax
  8004a4:	01 d8                	add    %ebx,%eax
  8004a6:	83 e8 30             	sub    $0x30,%eax
  8004a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8004af:	8a 00                	mov    (%eax),%al
  8004b1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004b4:	83 fb 2f             	cmp    $0x2f,%ebx
  8004b7:	7e 3e                	jle    8004f7 <vprintfmt+0xe9>
  8004b9:	83 fb 39             	cmp    $0x39,%ebx
  8004bc:	7f 39                	jg     8004f7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004be:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004c1:	eb d5                	jmp    800498 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8004c6:	83 c0 04             	add    $0x4,%eax
  8004c9:	89 45 14             	mov    %eax,0x14(%ebp)
  8004cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004cf:	83 e8 04             	sub    $0x4,%eax
  8004d2:	8b 00                	mov    (%eax),%eax
  8004d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004d7:	eb 1f                	jmp    8004f8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004dd:	79 83                	jns    800462 <vprintfmt+0x54>
				width = 0;
  8004df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004e6:	e9 77 ff ff ff       	jmp    800462 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004eb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004f2:	e9 6b ff ff ff       	jmp    800462 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8004f7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8004f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004fc:	0f 89 60 ff ff ff    	jns    800462 <vprintfmt+0x54>
				width = precision, precision = -1;
  800502:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800505:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800508:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80050f:	e9 4e ff ff ff       	jmp    800462 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800514:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800517:	e9 46 ff ff ff       	jmp    800462 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80051c:	8b 45 14             	mov    0x14(%ebp),%eax
  80051f:	83 c0 04             	add    $0x4,%eax
  800522:	89 45 14             	mov    %eax,0x14(%ebp)
  800525:	8b 45 14             	mov    0x14(%ebp),%eax
  800528:	83 e8 04             	sub    $0x4,%eax
  80052b:	8b 00                	mov    (%eax),%eax
  80052d:	83 ec 08             	sub    $0x8,%esp
  800530:	ff 75 0c             	pushl  0xc(%ebp)
  800533:	50                   	push   %eax
  800534:	8b 45 08             	mov    0x8(%ebp),%eax
  800537:	ff d0                	call   *%eax
  800539:	83 c4 10             	add    $0x10,%esp
			break;
  80053c:	e9 89 02 00 00       	jmp    8007ca <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800541:	8b 45 14             	mov    0x14(%ebp),%eax
  800544:	83 c0 04             	add    $0x4,%eax
  800547:	89 45 14             	mov    %eax,0x14(%ebp)
  80054a:	8b 45 14             	mov    0x14(%ebp),%eax
  80054d:	83 e8 04             	sub    $0x4,%eax
  800550:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800552:	85 db                	test   %ebx,%ebx
  800554:	79 02                	jns    800558 <vprintfmt+0x14a>
				err = -err;
  800556:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800558:	83 fb 64             	cmp    $0x64,%ebx
  80055b:	7f 0b                	jg     800568 <vprintfmt+0x15a>
  80055d:	8b 34 9d 80 19 80 00 	mov    0x801980(,%ebx,4),%esi
  800564:	85 f6                	test   %esi,%esi
  800566:	75 19                	jne    800581 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800568:	53                   	push   %ebx
  800569:	68 25 1b 80 00       	push   $0x801b25
  80056e:	ff 75 0c             	pushl  0xc(%ebp)
  800571:	ff 75 08             	pushl  0x8(%ebp)
  800574:	e8 5e 02 00 00       	call   8007d7 <printfmt>
  800579:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80057c:	e9 49 02 00 00       	jmp    8007ca <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800581:	56                   	push   %esi
  800582:	68 2e 1b 80 00       	push   $0x801b2e
  800587:	ff 75 0c             	pushl  0xc(%ebp)
  80058a:	ff 75 08             	pushl  0x8(%ebp)
  80058d:	e8 45 02 00 00       	call   8007d7 <printfmt>
  800592:	83 c4 10             	add    $0x10,%esp
			break;
  800595:	e9 30 02 00 00       	jmp    8007ca <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80059a:	8b 45 14             	mov    0x14(%ebp),%eax
  80059d:	83 c0 04             	add    $0x4,%eax
  8005a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 e8 04             	sub    $0x4,%eax
  8005a9:	8b 30                	mov    (%eax),%esi
  8005ab:	85 f6                	test   %esi,%esi
  8005ad:	75 05                	jne    8005b4 <vprintfmt+0x1a6>
				p = "(null)";
  8005af:	be 31 1b 80 00       	mov    $0x801b31,%esi
			if (width > 0 && padc != '-')
  8005b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005b8:	7e 6d                	jle    800627 <vprintfmt+0x219>
  8005ba:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005be:	74 67                	je     800627 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c3:	83 ec 08             	sub    $0x8,%esp
  8005c6:	50                   	push   %eax
  8005c7:	56                   	push   %esi
  8005c8:	e8 0c 03 00 00       	call   8008d9 <strnlen>
  8005cd:	83 c4 10             	add    $0x10,%esp
  8005d0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005d3:	eb 16                	jmp    8005eb <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005d5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005d9:	83 ec 08             	sub    $0x8,%esp
  8005dc:	ff 75 0c             	pushl  0xc(%ebp)
  8005df:	50                   	push   %eax
  8005e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e3:	ff d0                	call   *%eax
  8005e5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005e8:	ff 4d e4             	decl   -0x1c(%ebp)
  8005eb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ef:	7f e4                	jg     8005d5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005f1:	eb 34                	jmp    800627 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8005f3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8005f7:	74 1c                	je     800615 <vprintfmt+0x207>
  8005f9:	83 fb 1f             	cmp    $0x1f,%ebx
  8005fc:	7e 05                	jle    800603 <vprintfmt+0x1f5>
  8005fe:	83 fb 7e             	cmp    $0x7e,%ebx
  800601:	7e 12                	jle    800615 <vprintfmt+0x207>
					putch('?', putdat);
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	ff 75 0c             	pushl  0xc(%ebp)
  800609:	6a 3f                	push   $0x3f
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	ff d0                	call   *%eax
  800610:	83 c4 10             	add    $0x10,%esp
  800613:	eb 0f                	jmp    800624 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800615:	83 ec 08             	sub    $0x8,%esp
  800618:	ff 75 0c             	pushl  0xc(%ebp)
  80061b:	53                   	push   %ebx
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	ff d0                	call   *%eax
  800621:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800624:	ff 4d e4             	decl   -0x1c(%ebp)
  800627:	89 f0                	mov    %esi,%eax
  800629:	8d 70 01             	lea    0x1(%eax),%esi
  80062c:	8a 00                	mov    (%eax),%al
  80062e:	0f be d8             	movsbl %al,%ebx
  800631:	85 db                	test   %ebx,%ebx
  800633:	74 24                	je     800659 <vprintfmt+0x24b>
  800635:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800639:	78 b8                	js     8005f3 <vprintfmt+0x1e5>
  80063b:	ff 4d e0             	decl   -0x20(%ebp)
  80063e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800642:	79 af                	jns    8005f3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800644:	eb 13                	jmp    800659 <vprintfmt+0x24b>
				putch(' ', putdat);
  800646:	83 ec 08             	sub    $0x8,%esp
  800649:	ff 75 0c             	pushl  0xc(%ebp)
  80064c:	6a 20                	push   $0x20
  80064e:	8b 45 08             	mov    0x8(%ebp),%eax
  800651:	ff d0                	call   *%eax
  800653:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800656:	ff 4d e4             	decl   -0x1c(%ebp)
  800659:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065d:	7f e7                	jg     800646 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80065f:	e9 66 01 00 00       	jmp    8007ca <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800664:	83 ec 08             	sub    $0x8,%esp
  800667:	ff 75 e8             	pushl  -0x18(%ebp)
  80066a:	8d 45 14             	lea    0x14(%ebp),%eax
  80066d:	50                   	push   %eax
  80066e:	e8 3c fd ff ff       	call   8003af <getint>
  800673:	83 c4 10             	add    $0x10,%esp
  800676:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800679:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80067c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800682:	85 d2                	test   %edx,%edx
  800684:	79 23                	jns    8006a9 <vprintfmt+0x29b>
				putch('-', putdat);
  800686:	83 ec 08             	sub    $0x8,%esp
  800689:	ff 75 0c             	pushl  0xc(%ebp)
  80068c:	6a 2d                	push   $0x2d
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	ff d0                	call   *%eax
  800693:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800699:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80069c:	f7 d8                	neg    %eax
  80069e:	83 d2 00             	adc    $0x0,%edx
  8006a1:	f7 da                	neg    %edx
  8006a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006a9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006b0:	e9 bc 00 00 00       	jmp    800771 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8006bb:	8d 45 14             	lea    0x14(%ebp),%eax
  8006be:	50                   	push   %eax
  8006bf:	e8 84 fc ff ff       	call   800348 <getuint>
  8006c4:	83 c4 10             	add    $0x10,%esp
  8006c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006cd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006d4:	e9 98 00 00 00       	jmp    800771 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006d9:	83 ec 08             	sub    $0x8,%esp
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	6a 58                	push   $0x58
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	ff d0                	call   *%eax
  8006e6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	6a 58                	push   $0x58
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	ff 75 0c             	pushl  0xc(%ebp)
  8006ff:	6a 58                	push   $0x58
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	ff d0                	call   *%eax
  800706:	83 c4 10             	add    $0x10,%esp
			break;
  800709:	e9 bc 00 00 00       	jmp    8007ca <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	6a 30                	push   $0x30
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	ff d0                	call   *%eax
  80071b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80071e:	83 ec 08             	sub    $0x8,%esp
  800721:	ff 75 0c             	pushl  0xc(%ebp)
  800724:	6a 78                	push   $0x78
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	ff d0                	call   *%eax
  80072b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80072e:	8b 45 14             	mov    0x14(%ebp),%eax
  800731:	83 c0 04             	add    $0x4,%eax
  800734:	89 45 14             	mov    %eax,0x14(%ebp)
  800737:	8b 45 14             	mov    0x14(%ebp),%eax
  80073a:	83 e8 04             	sub    $0x4,%eax
  80073d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80073f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800742:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800749:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800750:	eb 1f                	jmp    800771 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800752:	83 ec 08             	sub    $0x8,%esp
  800755:	ff 75 e8             	pushl  -0x18(%ebp)
  800758:	8d 45 14             	lea    0x14(%ebp),%eax
  80075b:	50                   	push   %eax
  80075c:	e8 e7 fb ff ff       	call   800348 <getuint>
  800761:	83 c4 10             	add    $0x10,%esp
  800764:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800767:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80076a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800771:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800775:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800778:	83 ec 04             	sub    $0x4,%esp
  80077b:	52                   	push   %edx
  80077c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80077f:	50                   	push   %eax
  800780:	ff 75 f4             	pushl  -0xc(%ebp)
  800783:	ff 75 f0             	pushl  -0x10(%ebp)
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	ff 75 08             	pushl  0x8(%ebp)
  80078c:	e8 00 fb ff ff       	call   800291 <printnum>
  800791:	83 c4 20             	add    $0x20,%esp
			break;
  800794:	eb 34                	jmp    8007ca <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	53                   	push   %ebx
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
			break;
  8007a5:	eb 23                	jmp    8007ca <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	ff 75 0c             	pushl  0xc(%ebp)
  8007ad:	6a 25                	push   $0x25
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	ff d0                	call   *%eax
  8007b4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007b7:	ff 4d 10             	decl   0x10(%ebp)
  8007ba:	eb 03                	jmp    8007bf <vprintfmt+0x3b1>
  8007bc:	ff 4d 10             	decl   0x10(%ebp)
  8007bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c2:	48                   	dec    %eax
  8007c3:	8a 00                	mov    (%eax),%al
  8007c5:	3c 25                	cmp    $0x25,%al
  8007c7:	75 f3                	jne    8007bc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007c9:	90                   	nop
		}
	}
  8007ca:	e9 47 fc ff ff       	jmp    800416 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007cf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007d3:	5b                   	pop    %ebx
  8007d4:	5e                   	pop    %esi
  8007d5:	5d                   	pop    %ebp
  8007d6:	c3                   	ret    

008007d7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007d7:	55                   	push   %ebp
  8007d8:	89 e5                	mov    %esp,%ebp
  8007da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8007e0:	83 c0 04             	add    $0x4,%eax
  8007e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ec:	50                   	push   %eax
  8007ed:	ff 75 0c             	pushl  0xc(%ebp)
  8007f0:	ff 75 08             	pushl  0x8(%ebp)
  8007f3:	e8 16 fc ff ff       	call   80040e <vprintfmt>
  8007f8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8007fb:	90                   	nop
  8007fc:	c9                   	leave  
  8007fd:	c3                   	ret    

008007fe <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8007fe:	55                   	push   %ebp
  8007ff:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800801:	8b 45 0c             	mov    0xc(%ebp),%eax
  800804:	8b 40 08             	mov    0x8(%eax),%eax
  800807:	8d 50 01             	lea    0x1(%eax),%edx
  80080a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800810:	8b 45 0c             	mov    0xc(%ebp),%eax
  800813:	8b 10                	mov    (%eax),%edx
  800815:	8b 45 0c             	mov    0xc(%ebp),%eax
  800818:	8b 40 04             	mov    0x4(%eax),%eax
  80081b:	39 c2                	cmp    %eax,%edx
  80081d:	73 12                	jae    800831 <sprintputch+0x33>
		*b->buf++ = ch;
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	8d 48 01             	lea    0x1(%eax),%ecx
  800827:	8b 55 0c             	mov    0xc(%ebp),%edx
  80082a:	89 0a                	mov    %ecx,(%edx)
  80082c:	8b 55 08             	mov    0x8(%ebp),%edx
  80082f:	88 10                	mov    %dl,(%eax)
}
  800831:	90                   	nop
  800832:	5d                   	pop    %ebp
  800833:	c3                   	ret    

00800834 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800834:	55                   	push   %ebp
  800835:	89 e5                	mov    %esp,%ebp
  800837:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800840:	8b 45 0c             	mov    0xc(%ebp),%eax
  800843:	8d 50 ff             	lea    -0x1(%eax),%edx
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	01 d0                	add    %edx,%eax
  80084b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800855:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800859:	74 06                	je     800861 <vsnprintf+0x2d>
  80085b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80085f:	7f 07                	jg     800868 <vsnprintf+0x34>
		return -E_INVAL;
  800861:	b8 03 00 00 00       	mov    $0x3,%eax
  800866:	eb 20                	jmp    800888 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800868:	ff 75 14             	pushl  0x14(%ebp)
  80086b:	ff 75 10             	pushl  0x10(%ebp)
  80086e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800871:	50                   	push   %eax
  800872:	68 fe 07 80 00       	push   $0x8007fe
  800877:	e8 92 fb ff ff       	call   80040e <vprintfmt>
  80087c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80087f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800882:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800885:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800888:	c9                   	leave  
  800889:	c3                   	ret    

0080088a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80088a:	55                   	push   %ebp
  80088b:	89 e5                	mov    %esp,%ebp
  80088d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800890:	8d 45 10             	lea    0x10(%ebp),%eax
  800893:	83 c0 04             	add    $0x4,%eax
  800896:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800899:	8b 45 10             	mov    0x10(%ebp),%eax
  80089c:	ff 75 f4             	pushl  -0xc(%ebp)
  80089f:	50                   	push   %eax
  8008a0:	ff 75 0c             	pushl  0xc(%ebp)
  8008a3:	ff 75 08             	pushl  0x8(%ebp)
  8008a6:	e8 89 ff ff ff       	call   800834 <vsnprintf>
  8008ab:	83 c4 10             	add    $0x10,%esp
  8008ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008b4:	c9                   	leave  
  8008b5:	c3                   	ret    

008008b6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008b6:	55                   	push   %ebp
  8008b7:	89 e5                	mov    %esp,%ebp
  8008b9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008c3:	eb 06                	jmp    8008cb <strlen+0x15>
		n++;
  8008c5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008c8:	ff 45 08             	incl   0x8(%ebp)
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	8a 00                	mov    (%eax),%al
  8008d0:	84 c0                	test   %al,%al
  8008d2:	75 f1                	jne    8008c5 <strlen+0xf>
		n++;
	return n;
  8008d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008d7:	c9                   	leave  
  8008d8:	c3                   	ret    

008008d9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
  8008dc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008e6:	eb 09                	jmp    8008f1 <strnlen+0x18>
		n++;
  8008e8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008eb:	ff 45 08             	incl   0x8(%ebp)
  8008ee:	ff 4d 0c             	decl   0xc(%ebp)
  8008f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f5:	74 09                	je     800900 <strnlen+0x27>
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	8a 00                	mov    (%eax),%al
  8008fc:	84 c0                	test   %al,%al
  8008fe:	75 e8                	jne    8008e8 <strnlen+0xf>
		n++;
	return n;
  800900:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800903:	c9                   	leave  
  800904:	c3                   	ret    

00800905 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800905:	55                   	push   %ebp
  800906:	89 e5                	mov    %esp,%ebp
  800908:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800911:	90                   	nop
  800912:	8b 45 08             	mov    0x8(%ebp),%eax
  800915:	8d 50 01             	lea    0x1(%eax),%edx
  800918:	89 55 08             	mov    %edx,0x8(%ebp)
  80091b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800921:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800924:	8a 12                	mov    (%edx),%dl
  800926:	88 10                	mov    %dl,(%eax)
  800928:	8a 00                	mov    (%eax),%al
  80092a:	84 c0                	test   %al,%al
  80092c:	75 e4                	jne    800912 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80092e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800931:	c9                   	leave  
  800932:	c3                   	ret    

00800933 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800933:	55                   	push   %ebp
  800934:	89 e5                	mov    %esp,%ebp
  800936:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80093f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800946:	eb 1f                	jmp    800967 <strncpy+0x34>
		*dst++ = *src;
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	8d 50 01             	lea    0x1(%eax),%edx
  80094e:	89 55 08             	mov    %edx,0x8(%ebp)
  800951:	8b 55 0c             	mov    0xc(%ebp),%edx
  800954:	8a 12                	mov    (%edx),%dl
  800956:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800958:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095b:	8a 00                	mov    (%eax),%al
  80095d:	84 c0                	test   %al,%al
  80095f:	74 03                	je     800964 <strncpy+0x31>
			src++;
  800961:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800964:	ff 45 fc             	incl   -0x4(%ebp)
  800967:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80096a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80096d:	72 d9                	jb     800948 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80096f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800972:	c9                   	leave  
  800973:	c3                   	ret    

00800974 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800974:	55                   	push   %ebp
  800975:	89 e5                	mov    %esp,%ebp
  800977:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800980:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800984:	74 30                	je     8009b6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800986:	eb 16                	jmp    80099e <strlcpy+0x2a>
			*dst++ = *src++;
  800988:	8b 45 08             	mov    0x8(%ebp),%eax
  80098b:	8d 50 01             	lea    0x1(%eax),%edx
  80098e:	89 55 08             	mov    %edx,0x8(%ebp)
  800991:	8b 55 0c             	mov    0xc(%ebp),%edx
  800994:	8d 4a 01             	lea    0x1(%edx),%ecx
  800997:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80099a:	8a 12                	mov    (%edx),%dl
  80099c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80099e:	ff 4d 10             	decl   0x10(%ebp)
  8009a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009a5:	74 09                	je     8009b0 <strlcpy+0x3c>
  8009a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009aa:	8a 00                	mov    (%eax),%al
  8009ac:	84 c0                	test   %al,%al
  8009ae:	75 d8                	jne    800988 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009b6:	8b 55 08             	mov    0x8(%ebp),%edx
  8009b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009bc:	29 c2                	sub    %eax,%edx
  8009be:	89 d0                	mov    %edx,%eax
}
  8009c0:	c9                   	leave  
  8009c1:	c3                   	ret    

008009c2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009c2:	55                   	push   %ebp
  8009c3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009c5:	eb 06                	jmp    8009cd <strcmp+0xb>
		p++, q++;
  8009c7:	ff 45 08             	incl   0x8(%ebp)
  8009ca:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	8a 00                	mov    (%eax),%al
  8009d2:	84 c0                	test   %al,%al
  8009d4:	74 0e                	je     8009e4 <strcmp+0x22>
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	8a 10                	mov    (%eax),%dl
  8009db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009de:	8a 00                	mov    (%eax),%al
  8009e0:	38 c2                	cmp    %al,%dl
  8009e2:	74 e3                	je     8009c7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	8a 00                	mov    (%eax),%al
  8009e9:	0f b6 d0             	movzbl %al,%edx
  8009ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ef:	8a 00                	mov    (%eax),%al
  8009f1:	0f b6 c0             	movzbl %al,%eax
  8009f4:	29 c2                	sub    %eax,%edx
  8009f6:	89 d0                	mov    %edx,%eax
}
  8009f8:	5d                   	pop    %ebp
  8009f9:	c3                   	ret    

008009fa <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8009fa:	55                   	push   %ebp
  8009fb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8009fd:	eb 09                	jmp    800a08 <strncmp+0xe>
		n--, p++, q++;
  8009ff:	ff 4d 10             	decl   0x10(%ebp)
  800a02:	ff 45 08             	incl   0x8(%ebp)
  800a05:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0c:	74 17                	je     800a25 <strncmp+0x2b>
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	8a 00                	mov    (%eax),%al
  800a13:	84 c0                	test   %al,%al
  800a15:	74 0e                	je     800a25 <strncmp+0x2b>
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	8a 10                	mov    (%eax),%dl
  800a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1f:	8a 00                	mov    (%eax),%al
  800a21:	38 c2                	cmp    %al,%dl
  800a23:	74 da                	je     8009ff <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a29:	75 07                	jne    800a32 <strncmp+0x38>
		return 0;
  800a2b:	b8 00 00 00 00       	mov    $0x0,%eax
  800a30:	eb 14                	jmp    800a46 <strncmp+0x4c>
	else
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

00800a48 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a48:	55                   	push   %ebp
  800a49:	89 e5                	mov    %esp,%ebp
  800a4b:	83 ec 04             	sub    $0x4,%esp
  800a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a51:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a54:	eb 12                	jmp    800a68 <strchr+0x20>
		if (*s == c)
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a5e:	75 05                	jne    800a65 <strchr+0x1d>
			return (char *) s;
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	eb 11                	jmp    800a76 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a65:	ff 45 08             	incl   0x8(%ebp)
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	84 c0                	test   %al,%al
  800a6f:	75 e5                	jne    800a56 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a76:	c9                   	leave  
  800a77:	c3                   	ret    

00800a78 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a78:	55                   	push   %ebp
  800a79:	89 e5                	mov    %esp,%ebp
  800a7b:	83 ec 04             	sub    $0x4,%esp
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a84:	eb 0d                	jmp    800a93 <strfind+0x1b>
		if (*s == c)
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	8a 00                	mov    (%eax),%al
  800a8b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a8e:	74 0e                	je     800a9e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a90:	ff 45 08             	incl   0x8(%ebp)
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	8a 00                	mov    (%eax),%al
  800a98:	84 c0                	test   %al,%al
  800a9a:	75 ea                	jne    800a86 <strfind+0xe>
  800a9c:	eb 01                	jmp    800a9f <strfind+0x27>
		if (*s == c)
			break;
  800a9e:	90                   	nop
	return (char *) s;
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aa2:	c9                   	leave  
  800aa3:	c3                   	ret    

00800aa4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
  800aa7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ab0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ab6:	eb 0e                	jmp    800ac6 <memset+0x22>
		*p++ = c;
  800ab8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800abb:	8d 50 01             	lea    0x1(%eax),%edx
  800abe:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ac1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ac6:	ff 4d f8             	decl   -0x8(%ebp)
  800ac9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800acd:	79 e9                	jns    800ab8 <memset+0x14>
		*p++ = c;

	return v;
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ad2:	c9                   	leave  
  800ad3:	c3                   	ret    

00800ad4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
  800ad7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ada:	8b 45 0c             	mov    0xc(%ebp),%eax
  800add:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ae6:	eb 16                	jmp    800afe <memcpy+0x2a>
		*d++ = *s++;
  800ae8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800aeb:	8d 50 01             	lea    0x1(%eax),%edx
  800aee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800af1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800af4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800af7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800afa:	8a 12                	mov    (%edx),%dl
  800afc:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800afe:	8b 45 10             	mov    0x10(%ebp),%eax
  800b01:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b04:	89 55 10             	mov    %edx,0x10(%ebp)
  800b07:	85 c0                	test   %eax,%eax
  800b09:	75 dd                	jne    800ae8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b0e:	c9                   	leave  
  800b0f:	c3                   	ret    

00800b10 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
  800b13:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b25:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b28:	73 50                	jae    800b7a <memmove+0x6a>
  800b2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b30:	01 d0                	add    %edx,%eax
  800b32:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b35:	76 43                	jbe    800b7a <memmove+0x6a>
		s += n;
  800b37:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b40:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b43:	eb 10                	jmp    800b55 <memmove+0x45>
			*--d = *--s;
  800b45:	ff 4d f8             	decl   -0x8(%ebp)
  800b48:	ff 4d fc             	decl   -0x4(%ebp)
  800b4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b4e:	8a 10                	mov    (%eax),%dl
  800b50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b53:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b55:	8b 45 10             	mov    0x10(%ebp),%eax
  800b58:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5b:	89 55 10             	mov    %edx,0x10(%ebp)
  800b5e:	85 c0                	test   %eax,%eax
  800b60:	75 e3                	jne    800b45 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b62:	eb 23                	jmp    800b87 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b67:	8d 50 01             	lea    0x1(%eax),%edx
  800b6a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b73:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b76:	8a 12                	mov    (%edx),%dl
  800b78:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b80:	89 55 10             	mov    %edx,0x10(%ebp)
  800b83:	85 c0                	test   %eax,%eax
  800b85:	75 dd                	jne    800b64 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8a:	c9                   	leave  
  800b8b:	c3                   	ret    

00800b8c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b8c:	55                   	push   %ebp
  800b8d:	89 e5                	mov    %esp,%ebp
  800b8f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800b98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800b9e:	eb 2a                	jmp    800bca <memcmp+0x3e>
		if (*s1 != *s2)
  800ba0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba3:	8a 10                	mov    (%eax),%dl
  800ba5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba8:	8a 00                	mov    (%eax),%al
  800baa:	38 c2                	cmp    %al,%dl
  800bac:	74 16                	je     800bc4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb1:	8a 00                	mov    (%eax),%al
  800bb3:	0f b6 d0             	movzbl %al,%edx
  800bb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb9:	8a 00                	mov    (%eax),%al
  800bbb:	0f b6 c0             	movzbl %al,%eax
  800bbe:	29 c2                	sub    %eax,%edx
  800bc0:	89 d0                	mov    %edx,%eax
  800bc2:	eb 18                	jmp    800bdc <memcmp+0x50>
		s1++, s2++;
  800bc4:	ff 45 fc             	incl   -0x4(%ebp)
  800bc7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bca:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd3:	85 c0                	test   %eax,%eax
  800bd5:	75 c9                	jne    800ba0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bd7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bdc:	c9                   	leave  
  800bdd:	c3                   	ret    

00800bde <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
  800be1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800be4:	8b 55 08             	mov    0x8(%ebp),%edx
  800be7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bea:	01 d0                	add    %edx,%eax
  800bec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800bef:	eb 15                	jmp    800c06 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	0f b6 d0             	movzbl %al,%edx
  800bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfc:	0f b6 c0             	movzbl %al,%eax
  800bff:	39 c2                	cmp    %eax,%edx
  800c01:	74 0d                	je     800c10 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c03:	ff 45 08             	incl   0x8(%ebp)
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c0c:	72 e3                	jb     800bf1 <memfind+0x13>
  800c0e:	eb 01                	jmp    800c11 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c10:	90                   	nop
	return (void *) s;
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c14:	c9                   	leave  
  800c15:	c3                   	ret    

00800c16 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c16:	55                   	push   %ebp
  800c17:	89 e5                	mov    %esp,%ebp
  800c19:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c2a:	eb 03                	jmp    800c2f <strtol+0x19>
		s++;
  800c2c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	8a 00                	mov    (%eax),%al
  800c34:	3c 20                	cmp    $0x20,%al
  800c36:	74 f4                	je     800c2c <strtol+0x16>
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	8a 00                	mov    (%eax),%al
  800c3d:	3c 09                	cmp    $0x9,%al
  800c3f:	74 eb                	je     800c2c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	3c 2b                	cmp    $0x2b,%al
  800c48:	75 05                	jne    800c4f <strtol+0x39>
		s++;
  800c4a:	ff 45 08             	incl   0x8(%ebp)
  800c4d:	eb 13                	jmp    800c62 <strtol+0x4c>
	else if (*s == '-')
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	3c 2d                	cmp    $0x2d,%al
  800c56:	75 0a                	jne    800c62 <strtol+0x4c>
		s++, neg = 1;
  800c58:	ff 45 08             	incl   0x8(%ebp)
  800c5b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c62:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c66:	74 06                	je     800c6e <strtol+0x58>
  800c68:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c6c:	75 20                	jne    800c8e <strtol+0x78>
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	3c 30                	cmp    $0x30,%al
  800c75:	75 17                	jne    800c8e <strtol+0x78>
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	40                   	inc    %eax
  800c7b:	8a 00                	mov    (%eax),%al
  800c7d:	3c 78                	cmp    $0x78,%al
  800c7f:	75 0d                	jne    800c8e <strtol+0x78>
		s += 2, base = 16;
  800c81:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c85:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c8c:	eb 28                	jmp    800cb6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c92:	75 15                	jne    800ca9 <strtol+0x93>
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	3c 30                	cmp    $0x30,%al
  800c9b:	75 0c                	jne    800ca9 <strtol+0x93>
		s++, base = 8;
  800c9d:	ff 45 08             	incl   0x8(%ebp)
  800ca0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ca7:	eb 0d                	jmp    800cb6 <strtol+0xa0>
	else if (base == 0)
  800ca9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cad:	75 07                	jne    800cb6 <strtol+0xa0>
		base = 10;
  800caf:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 00                	mov    (%eax),%al
  800cbb:	3c 2f                	cmp    $0x2f,%al
  800cbd:	7e 19                	jle    800cd8 <strtol+0xc2>
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	3c 39                	cmp    $0x39,%al
  800cc6:	7f 10                	jg     800cd8 <strtol+0xc2>
			dig = *s - '0';
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	0f be c0             	movsbl %al,%eax
  800cd0:	83 e8 30             	sub    $0x30,%eax
  800cd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cd6:	eb 42                	jmp    800d1a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	3c 60                	cmp    $0x60,%al
  800cdf:	7e 19                	jle    800cfa <strtol+0xe4>
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8a 00                	mov    (%eax),%al
  800ce6:	3c 7a                	cmp    $0x7a,%al
  800ce8:	7f 10                	jg     800cfa <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	0f be c0             	movsbl %al,%eax
  800cf2:	83 e8 57             	sub    $0x57,%eax
  800cf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cf8:	eb 20                	jmp    800d1a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	3c 40                	cmp    $0x40,%al
  800d01:	7e 39                	jle    800d3c <strtol+0x126>
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	3c 5a                	cmp    $0x5a,%al
  800d0a:	7f 30                	jg     800d3c <strtol+0x126>
			dig = *s - 'A' + 10;
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	0f be c0             	movsbl %al,%eax
  800d14:	83 e8 37             	sub    $0x37,%eax
  800d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d1d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d20:	7d 19                	jge    800d3b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d22:	ff 45 08             	incl   0x8(%ebp)
  800d25:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d28:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d2c:	89 c2                	mov    %eax,%edx
  800d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d31:	01 d0                	add    %edx,%eax
  800d33:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d36:	e9 7b ff ff ff       	jmp    800cb6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d3b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d40:	74 08                	je     800d4a <strtol+0x134>
		*endptr = (char *) s;
  800d42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d45:	8b 55 08             	mov    0x8(%ebp),%edx
  800d48:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d4e:	74 07                	je     800d57 <strtol+0x141>
  800d50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d53:	f7 d8                	neg    %eax
  800d55:	eb 03                	jmp    800d5a <strtol+0x144>
  800d57:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d5a:	c9                   	leave  
  800d5b:	c3                   	ret    

00800d5c <ltostr>:

void
ltostr(long value, char *str)
{
  800d5c:	55                   	push   %ebp
  800d5d:	89 e5                	mov    %esp,%ebp
  800d5f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d69:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d70:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d74:	79 13                	jns    800d89 <ltostr+0x2d>
	{
		neg = 1;
  800d76:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d80:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d83:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d86:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d91:	99                   	cltd   
  800d92:	f7 f9                	idiv   %ecx
  800d94:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800d97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9a:	8d 50 01             	lea    0x1(%eax),%edx
  800d9d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800da0:	89 c2                	mov    %eax,%edx
  800da2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da5:	01 d0                	add    %edx,%eax
  800da7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800daa:	83 c2 30             	add    $0x30,%edx
  800dad:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800daf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800db2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800db7:	f7 e9                	imul   %ecx
  800db9:	c1 fa 02             	sar    $0x2,%edx
  800dbc:	89 c8                	mov    %ecx,%eax
  800dbe:	c1 f8 1f             	sar    $0x1f,%eax
  800dc1:	29 c2                	sub    %eax,%edx
  800dc3:	89 d0                	mov    %edx,%eax
  800dc5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dc8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dcb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dd0:	f7 e9                	imul   %ecx
  800dd2:	c1 fa 02             	sar    $0x2,%edx
  800dd5:	89 c8                	mov    %ecx,%eax
  800dd7:	c1 f8 1f             	sar    $0x1f,%eax
  800dda:	29 c2                	sub    %eax,%edx
  800ddc:	89 d0                	mov    %edx,%eax
  800dde:	c1 e0 02             	shl    $0x2,%eax
  800de1:	01 d0                	add    %edx,%eax
  800de3:	01 c0                	add    %eax,%eax
  800de5:	29 c1                	sub    %eax,%ecx
  800de7:	89 ca                	mov    %ecx,%edx
  800de9:	85 d2                	test   %edx,%edx
  800deb:	75 9c                	jne    800d89 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ded:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800df4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df7:	48                   	dec    %eax
  800df8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800dfb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dff:	74 3d                	je     800e3e <ltostr+0xe2>
		start = 1 ;
  800e01:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e08:	eb 34                	jmp    800e3e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e0a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e10:	01 d0                	add    %edx,%eax
  800e12:	8a 00                	mov    (%eax),%al
  800e14:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1d:	01 c2                	add    %eax,%edx
  800e1f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	01 c8                	add    %ecx,%eax
  800e27:	8a 00                	mov    (%eax),%al
  800e29:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e2b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e31:	01 c2                	add    %eax,%edx
  800e33:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e36:	88 02                	mov    %al,(%edx)
		start++ ;
  800e38:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e3b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e41:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e44:	7c c4                	jl     800e0a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e46:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4c:	01 d0                	add    %edx,%eax
  800e4e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e51:	90                   	nop
  800e52:	c9                   	leave  
  800e53:	c3                   	ret    

00800e54 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e54:	55                   	push   %ebp
  800e55:	89 e5                	mov    %esp,%ebp
  800e57:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e5a:	ff 75 08             	pushl  0x8(%ebp)
  800e5d:	e8 54 fa ff ff       	call   8008b6 <strlen>
  800e62:	83 c4 04             	add    $0x4,%esp
  800e65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	e8 46 fa ff ff       	call   8008b6 <strlen>
  800e70:	83 c4 04             	add    $0x4,%esp
  800e73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e84:	eb 17                	jmp    800e9d <strcconcat+0x49>
		final[s] = str1[s] ;
  800e86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e89:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8c:	01 c2                	add    %eax,%edx
  800e8e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	01 c8                	add    %ecx,%eax
  800e96:	8a 00                	mov    (%eax),%al
  800e98:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800e9a:	ff 45 fc             	incl   -0x4(%ebp)
  800e9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ea3:	7c e1                	jl     800e86 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ea5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800eac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800eb3:	eb 1f                	jmp    800ed4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800eb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb8:	8d 50 01             	lea    0x1(%eax),%edx
  800ebb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ebe:	89 c2                	mov    %eax,%edx
  800ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec3:	01 c2                	add    %eax,%edx
  800ec5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	01 c8                	add    %ecx,%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ed1:	ff 45 f8             	incl   -0x8(%ebp)
  800ed4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eda:	7c d9                	jl     800eb5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800edc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800edf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee2:	01 d0                	add    %edx,%eax
  800ee4:	c6 00 00             	movb   $0x0,(%eax)
}
  800ee7:	90                   	nop
  800ee8:	c9                   	leave  
  800ee9:	c3                   	ret    

00800eea <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800eea:	55                   	push   %ebp
  800eeb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800eed:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ef6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef9:	8b 00                	mov    (%eax),%eax
  800efb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	01 d0                	add    %edx,%eax
  800f07:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f0d:	eb 0c                	jmp    800f1b <strsplit+0x31>
			*string++ = 0;
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8d 50 01             	lea    0x1(%eax),%edx
  800f15:	89 55 08             	mov    %edx,0x8(%ebp)
  800f18:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	84 c0                	test   %al,%al
  800f22:	74 18                	je     800f3c <strsplit+0x52>
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	0f be c0             	movsbl %al,%eax
  800f2c:	50                   	push   %eax
  800f2d:	ff 75 0c             	pushl  0xc(%ebp)
  800f30:	e8 13 fb ff ff       	call   800a48 <strchr>
  800f35:	83 c4 08             	add    $0x8,%esp
  800f38:	85 c0                	test   %eax,%eax
  800f3a:	75 d3                	jne    800f0f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	84 c0                	test   %al,%al
  800f43:	74 5a                	je     800f9f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800f45:	8b 45 14             	mov    0x14(%ebp),%eax
  800f48:	8b 00                	mov    (%eax),%eax
  800f4a:	83 f8 0f             	cmp    $0xf,%eax
  800f4d:	75 07                	jne    800f56 <strsplit+0x6c>
		{
			return 0;
  800f4f:	b8 00 00 00 00       	mov    $0x0,%eax
  800f54:	eb 66                	jmp    800fbc <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f56:	8b 45 14             	mov    0x14(%ebp),%eax
  800f59:	8b 00                	mov    (%eax),%eax
  800f5b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f5e:	8b 55 14             	mov    0x14(%ebp),%edx
  800f61:	89 0a                	mov    %ecx,(%edx)
  800f63:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6d:	01 c2                	add    %eax,%edx
  800f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f72:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f74:	eb 03                	jmp    800f79 <strsplit+0x8f>
			string++;
  800f76:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	84 c0                	test   %al,%al
  800f80:	74 8b                	je     800f0d <strsplit+0x23>
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	0f be c0             	movsbl %al,%eax
  800f8a:	50                   	push   %eax
  800f8b:	ff 75 0c             	pushl  0xc(%ebp)
  800f8e:	e8 b5 fa ff ff       	call   800a48 <strchr>
  800f93:	83 c4 08             	add    $0x8,%esp
  800f96:	85 c0                	test   %eax,%eax
  800f98:	74 dc                	je     800f76 <strsplit+0x8c>
			string++;
	}
  800f9a:	e9 6e ff ff ff       	jmp    800f0d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800f9f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fa0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa3:	8b 00                	mov    (%eax),%eax
  800fa5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fac:	8b 45 10             	mov    0x10(%ebp),%eax
  800faf:	01 d0                	add    %edx,%eax
  800fb1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fb7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fbc:	c9                   	leave  
  800fbd:	c3                   	ret    

00800fbe <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fbe:	55                   	push   %ebp
  800fbf:	89 e5                	mov    %esp,%ebp
  800fc1:	57                   	push   %edi
  800fc2:	56                   	push   %esi
  800fc3:	53                   	push   %ebx
  800fc4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fcd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fd0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fd3:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fd6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fd9:	cd 30                	int    $0x30
  800fdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fde:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fe1:	83 c4 10             	add    $0x10,%esp
  800fe4:	5b                   	pop    %ebx
  800fe5:	5e                   	pop    %esi
  800fe6:	5f                   	pop    %edi
  800fe7:	5d                   	pop    %ebp
  800fe8:	c3                   	ret    

00800fe9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800fe9:	55                   	push   %ebp
  800fea:	89 e5                	mov    %esp,%ebp
  800fec:	83 ec 04             	sub    $0x4,%esp
  800fef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  800ff5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	6a 00                	push   $0x0
  800ffe:	6a 00                	push   $0x0
  801000:	52                   	push   %edx
  801001:	ff 75 0c             	pushl  0xc(%ebp)
  801004:	50                   	push   %eax
  801005:	6a 00                	push   $0x0
  801007:	e8 b2 ff ff ff       	call   800fbe <syscall>
  80100c:	83 c4 18             	add    $0x18,%esp
}
  80100f:	90                   	nop
  801010:	c9                   	leave  
  801011:	c3                   	ret    

00801012 <sys_cgetc>:

int
sys_cgetc(void)
{
  801012:	55                   	push   %ebp
  801013:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801015:	6a 00                	push   $0x0
  801017:	6a 00                	push   $0x0
  801019:	6a 00                	push   $0x0
  80101b:	6a 00                	push   $0x0
  80101d:	6a 00                	push   $0x0
  80101f:	6a 01                	push   $0x1
  801021:	e8 98 ff ff ff       	call   800fbe <syscall>
  801026:	83 c4 18             	add    $0x18,%esp
}
  801029:	c9                   	leave  
  80102a:	c3                   	ret    

0080102b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80102b:	55                   	push   %ebp
  80102c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	6a 00                	push   $0x0
  801033:	6a 00                	push   $0x0
  801035:	6a 00                	push   $0x0
  801037:	6a 00                	push   $0x0
  801039:	50                   	push   %eax
  80103a:	6a 05                	push   $0x5
  80103c:	e8 7d ff ff ff       	call   800fbe <syscall>
  801041:	83 c4 18             	add    $0x18,%esp
}
  801044:	c9                   	leave  
  801045:	c3                   	ret    

00801046 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801046:	55                   	push   %ebp
  801047:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801049:	6a 00                	push   $0x0
  80104b:	6a 00                	push   $0x0
  80104d:	6a 00                	push   $0x0
  80104f:	6a 00                	push   $0x0
  801051:	6a 00                	push   $0x0
  801053:	6a 02                	push   $0x2
  801055:	e8 64 ff ff ff       	call   800fbe <syscall>
  80105a:	83 c4 18             	add    $0x18,%esp
}
  80105d:	c9                   	leave  
  80105e:	c3                   	ret    

0080105f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80105f:	55                   	push   %ebp
  801060:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801062:	6a 00                	push   $0x0
  801064:	6a 00                	push   $0x0
  801066:	6a 00                	push   $0x0
  801068:	6a 00                	push   $0x0
  80106a:	6a 00                	push   $0x0
  80106c:	6a 03                	push   $0x3
  80106e:	e8 4b ff ff ff       	call   800fbe <syscall>
  801073:	83 c4 18             	add    $0x18,%esp
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	6a 00                	push   $0x0
  801081:	6a 00                	push   $0x0
  801083:	6a 00                	push   $0x0
  801085:	6a 04                	push   $0x4
  801087:	e8 32 ff ff ff       	call   800fbe <syscall>
  80108c:	83 c4 18             	add    $0x18,%esp
}
  80108f:	c9                   	leave  
  801090:	c3                   	ret    

00801091 <sys_env_exit>:


void sys_env_exit(void)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 06                	push   $0x6
  8010a0:	e8 19 ff ff ff       	call   800fbe <syscall>
  8010a5:	83 c4 18             	add    $0x18,%esp
}
  8010a8:	90                   	nop
  8010a9:	c9                   	leave  
  8010aa:	c3                   	ret    

008010ab <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	52                   	push   %edx
  8010bb:	50                   	push   %eax
  8010bc:	6a 07                	push   $0x7
  8010be:	e8 fb fe ff ff       	call   800fbe <syscall>
  8010c3:	83 c4 18             	add    $0x18,%esp
}
  8010c6:	c9                   	leave  
  8010c7:	c3                   	ret    

008010c8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010c8:	55                   	push   %ebp
  8010c9:	89 e5                	mov    %esp,%ebp
  8010cb:	56                   	push   %esi
  8010cc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010cd:	8b 75 18             	mov    0x18(%ebp),%esi
  8010d0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dc:	56                   	push   %esi
  8010dd:	53                   	push   %ebx
  8010de:	51                   	push   %ecx
  8010df:	52                   	push   %edx
  8010e0:	50                   	push   %eax
  8010e1:	6a 08                	push   $0x8
  8010e3:	e8 d6 fe ff ff       	call   800fbe <syscall>
  8010e8:	83 c4 18             	add    $0x18,%esp
}
  8010eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010ee:	5b                   	pop    %ebx
  8010ef:	5e                   	pop    %esi
  8010f0:	5d                   	pop    %ebp
  8010f1:	c3                   	ret    

008010f2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8010f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	52                   	push   %edx
  801102:	50                   	push   %eax
  801103:	6a 09                	push   $0x9
  801105:	e8 b4 fe ff ff       	call   800fbe <syscall>
  80110a:	83 c4 18             	add    $0x18,%esp
}
  80110d:	c9                   	leave  
  80110e:	c3                   	ret    

0080110f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801112:	6a 00                	push   $0x0
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	ff 75 0c             	pushl  0xc(%ebp)
  80111b:	ff 75 08             	pushl  0x8(%ebp)
  80111e:	6a 0a                	push   $0xa
  801120:	e8 99 fe ff ff       	call   800fbe <syscall>
  801125:	83 c4 18             	add    $0x18,%esp
}
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80112d:	6a 00                	push   $0x0
  80112f:	6a 00                	push   $0x0
  801131:	6a 00                	push   $0x0
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 0b                	push   $0xb
  801139:	e8 80 fe ff ff       	call   800fbe <syscall>
  80113e:	83 c4 18             	add    $0x18,%esp
}
  801141:	c9                   	leave  
  801142:	c3                   	ret    

00801143 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801146:	6a 00                	push   $0x0
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	6a 00                	push   $0x0
  80114e:	6a 00                	push   $0x0
  801150:	6a 0c                	push   $0xc
  801152:	e8 67 fe ff ff       	call   800fbe <syscall>
  801157:	83 c4 18             	add    $0x18,%esp
}
  80115a:	c9                   	leave  
  80115b:	c3                   	ret    

0080115c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80115c:	55                   	push   %ebp
  80115d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 00                	push   $0x0
  801165:	6a 00                	push   $0x0
  801167:	6a 00                	push   $0x0
  801169:	6a 0d                	push   $0xd
  80116b:	e8 4e fe ff ff       	call   800fbe <syscall>
  801170:	83 c4 18             	add    $0x18,%esp
}
  801173:	c9                   	leave  
  801174:	c3                   	ret    

00801175 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801175:	55                   	push   %ebp
  801176:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	ff 75 0c             	pushl  0xc(%ebp)
  801181:	ff 75 08             	pushl  0x8(%ebp)
  801184:	6a 11                	push   $0x11
  801186:	e8 33 fe ff ff       	call   800fbe <syscall>
  80118b:	83 c4 18             	add    $0x18,%esp
	return;
  80118e:	90                   	nop
}
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	ff 75 0c             	pushl  0xc(%ebp)
  80119d:	ff 75 08             	pushl  0x8(%ebp)
  8011a0:	6a 12                	push   $0x12
  8011a2:	e8 17 fe ff ff       	call   800fbe <syscall>
  8011a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8011aa:	90                   	nop
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	6a 00                	push   $0x0
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 0e                	push   $0xe
  8011bc:	e8 fd fd ff ff       	call   800fbe <syscall>
  8011c1:	83 c4 18             	add    $0x18,%esp
}
  8011c4:	c9                   	leave  
  8011c5:	c3                   	ret    

008011c6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 00                	push   $0x0
  8011cd:	6a 00                	push   $0x0
  8011cf:	6a 00                	push   $0x0
  8011d1:	ff 75 08             	pushl  0x8(%ebp)
  8011d4:	6a 0f                	push   $0xf
  8011d6:	e8 e3 fd ff ff       	call   800fbe <syscall>
  8011db:	83 c4 18             	add    $0x18,%esp
}
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 10                	push   $0x10
  8011ef:	e8 ca fd ff ff       	call   800fbe <syscall>
  8011f4:	83 c4 18             	add    $0x18,%esp
}
  8011f7:	90                   	nop
  8011f8:	c9                   	leave  
  8011f9:	c3                   	ret    

008011fa <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8011fa:	55                   	push   %ebp
  8011fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	6a 14                	push   $0x14
  801209:	e8 b0 fd ff ff       	call   800fbe <syscall>
  80120e:	83 c4 18             	add    $0x18,%esp
}
  801211:	90                   	nop
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 15                	push   $0x15
  801223:	e8 96 fd ff ff       	call   800fbe <syscall>
  801228:	83 c4 18             	add    $0x18,%esp
}
  80122b:	90                   	nop
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <sys_cputc>:


void
sys_cputc(const char c)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
  801231:	83 ec 04             	sub    $0x4,%esp
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80123a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	50                   	push   %eax
  801247:	6a 16                	push   $0x16
  801249:	e8 70 fd ff ff       	call   800fbe <syscall>
  80124e:	83 c4 18             	add    $0x18,%esp
}
  801251:	90                   	nop
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 00                	push   $0x0
  801261:	6a 17                	push   $0x17
  801263:	e8 56 fd ff ff       	call   800fbe <syscall>
  801268:	83 c4 18             	add    $0x18,%esp
}
  80126b:	90                   	nop
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	ff 75 0c             	pushl  0xc(%ebp)
  80127d:	50                   	push   %eax
  80127e:	6a 18                	push   $0x18
  801280:	e8 39 fd ff ff       	call   800fbe <syscall>
  801285:	83 c4 18             	add    $0x18,%esp
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80128d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	52                   	push   %edx
  80129a:	50                   	push   %eax
  80129b:	6a 1b                	push   $0x1b
  80129d:	e8 1c fd ff ff       	call   800fbe <syscall>
  8012a2:	83 c4 18             	add    $0x18,%esp
}
  8012a5:	c9                   	leave  
  8012a6:	c3                   	ret    

008012a7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012a7:	55                   	push   %ebp
  8012a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	52                   	push   %edx
  8012b7:	50                   	push   %eax
  8012b8:	6a 19                	push   $0x19
  8012ba:	e8 ff fc ff ff       	call   800fbe <syscall>
  8012bf:	83 c4 18             	add    $0x18,%esp
}
  8012c2:	90                   	nop
  8012c3:	c9                   	leave  
  8012c4:	c3                   	ret    

008012c5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012c5:	55                   	push   %ebp
  8012c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	52                   	push   %edx
  8012d5:	50                   	push   %eax
  8012d6:	6a 1a                	push   $0x1a
  8012d8:	e8 e1 fc ff ff       	call   800fbe <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	90                   	nop
  8012e1:	c9                   	leave  
  8012e2:	c3                   	ret    

008012e3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012e3:	55                   	push   %ebp
  8012e4:	89 e5                	mov    %esp,%ebp
  8012e6:	83 ec 04             	sub    $0x4,%esp
  8012e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012ef:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012f2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f9:	6a 00                	push   $0x0
  8012fb:	51                   	push   %ecx
  8012fc:	52                   	push   %edx
  8012fd:	ff 75 0c             	pushl  0xc(%ebp)
  801300:	50                   	push   %eax
  801301:	6a 1c                	push   $0x1c
  801303:	e8 b6 fc ff ff       	call   800fbe <syscall>
  801308:	83 c4 18             	add    $0x18,%esp
}
  80130b:	c9                   	leave  
  80130c:	c3                   	ret    

0080130d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80130d:	55                   	push   %ebp
  80130e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801310:	8b 55 0c             	mov    0xc(%ebp),%edx
  801313:	8b 45 08             	mov    0x8(%ebp),%eax
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	52                   	push   %edx
  80131d:	50                   	push   %eax
  80131e:	6a 1d                	push   $0x1d
  801320:	e8 99 fc ff ff       	call   800fbe <syscall>
  801325:	83 c4 18             	add    $0x18,%esp
}
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80132d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801330:	8b 55 0c             	mov    0xc(%ebp),%edx
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	51                   	push   %ecx
  80133b:	52                   	push   %edx
  80133c:	50                   	push   %eax
  80133d:	6a 1e                	push   $0x1e
  80133f:	e8 7a fc ff ff       	call   800fbe <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80134c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	52                   	push   %edx
  801359:	50                   	push   %eax
  80135a:	6a 1f                	push   $0x1f
  80135c:	e8 5d fc ff ff       	call   800fbe <syscall>
  801361:	83 c4 18             	add    $0x18,%esp
}
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 20                	push   $0x20
  801375:	e8 44 fc ff ff       	call   800fbe <syscall>
  80137a:	83 c4 18             	add    $0x18,%esp
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	ff 75 10             	pushl  0x10(%ebp)
  80138c:	ff 75 0c             	pushl  0xc(%ebp)
  80138f:	50                   	push   %eax
  801390:	6a 21                	push   $0x21
  801392:	e8 27 fc ff ff       	call   800fbe <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	50                   	push   %eax
  8013ab:	6a 22                	push   $0x22
  8013ad:	e8 0c fc ff ff       	call   800fbe <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	90                   	nop
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	50                   	push   %eax
  8013c7:	6a 23                	push   $0x23
  8013c9:	e8 f0 fb ff ff       	call   800fbe <syscall>
  8013ce:	83 c4 18             	add    $0x18,%esp
}
  8013d1:	90                   	nop
  8013d2:	c9                   	leave  
  8013d3:	c3                   	ret    

008013d4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013d4:	55                   	push   %ebp
  8013d5:	89 e5                	mov    %esp,%ebp
  8013d7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013da:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013dd:	8d 50 04             	lea    0x4(%eax),%edx
  8013e0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	52                   	push   %edx
  8013ea:	50                   	push   %eax
  8013eb:	6a 24                	push   $0x24
  8013ed:	e8 cc fb ff ff       	call   800fbe <syscall>
  8013f2:	83 c4 18             	add    $0x18,%esp
	return result;
  8013f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013fe:	89 01                	mov    %eax,(%ecx)
  801400:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	c9                   	leave  
  801407:	c2 04 00             	ret    $0x4

0080140a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	ff 75 10             	pushl  0x10(%ebp)
  801414:	ff 75 0c             	pushl  0xc(%ebp)
  801417:	ff 75 08             	pushl  0x8(%ebp)
  80141a:	6a 13                	push   $0x13
  80141c:	e8 9d fb ff ff       	call   800fbe <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
	return ;
  801424:	90                   	nop
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_rcr2>:
uint32 sys_rcr2()
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 25                	push   $0x25
  801436:	e8 83 fb ff ff       	call   800fbe <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
  801443:	83 ec 04             	sub    $0x4,%esp
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80144c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	50                   	push   %eax
  801459:	6a 26                	push   $0x26
  80145b:	e8 5e fb ff ff       	call   800fbe <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
	return ;
  801463:	90                   	nop
}
  801464:	c9                   	leave  
  801465:	c3                   	ret    

00801466 <rsttst>:
void rsttst()
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 28                	push   $0x28
  801475:	e8 44 fb ff ff       	call   800fbe <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
	return ;
  80147d:	90                   	nop
}
  80147e:	c9                   	leave  
  80147f:	c3                   	ret    

00801480 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
  801483:	83 ec 04             	sub    $0x4,%esp
  801486:	8b 45 14             	mov    0x14(%ebp),%eax
  801489:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80148c:	8b 55 18             	mov    0x18(%ebp),%edx
  80148f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801493:	52                   	push   %edx
  801494:	50                   	push   %eax
  801495:	ff 75 10             	pushl  0x10(%ebp)
  801498:	ff 75 0c             	pushl  0xc(%ebp)
  80149b:	ff 75 08             	pushl  0x8(%ebp)
  80149e:	6a 27                	push   $0x27
  8014a0:	e8 19 fb ff ff       	call   800fbe <syscall>
  8014a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a8:	90                   	nop
}
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <chktst>:
void chktst(uint32 n)
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	ff 75 08             	pushl  0x8(%ebp)
  8014b9:	6a 29                	push   $0x29
  8014bb:	e8 fe fa ff ff       	call   800fbe <syscall>
  8014c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c3:	90                   	nop
}
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <inctst>:

void inctst()
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 2a                	push   $0x2a
  8014d5:	e8 e4 fa ff ff       	call   800fbe <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
	return ;
  8014dd:	90                   	nop
}
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <gettst>:
uint32 gettst()
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 2b                	push   $0x2b
  8014ef:	e8 ca fa ff ff       	call   800fbe <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
  8014fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	6a 2c                	push   $0x2c
  80150b:	e8 ae fa ff ff       	call   800fbe <syscall>
  801510:	83 c4 18             	add    $0x18,%esp
  801513:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801516:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80151a:	75 07                	jne    801523 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80151c:	b8 01 00 00 00       	mov    $0x1,%eax
  801521:	eb 05                	jmp    801528 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801523:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801528:	c9                   	leave  
  801529:	c3                   	ret    

0080152a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
  80152d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 2c                	push   $0x2c
  80153c:	e8 7d fa ff ff       	call   800fbe <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
  801544:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801547:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80154b:	75 07                	jne    801554 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80154d:	b8 01 00 00 00       	mov    $0x1,%eax
  801552:	eb 05                	jmp    801559 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801554:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 2c                	push   $0x2c
  80156d:	e8 4c fa ff ff       	call   800fbe <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
  801575:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801578:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80157c:	75 07                	jne    801585 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80157e:	b8 01 00 00 00       	mov    $0x1,%eax
  801583:	eb 05                	jmp    80158a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801585:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 2c                	push   $0x2c
  80159e:	e8 1b fa ff ff       	call   800fbe <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
  8015a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015a9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015ad:	75 07                	jne    8015b6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015af:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b4:	eb 05                	jmp    8015bb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	ff 75 08             	pushl  0x8(%ebp)
  8015cb:	6a 2d                	push   $0x2d
  8015cd:	e8 ec f9 ff ff       	call   800fbe <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d5:	90                   	nop
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <__udivdi3>:
  8015d8:	55                   	push   %ebp
  8015d9:	57                   	push   %edi
  8015da:	56                   	push   %esi
  8015db:	53                   	push   %ebx
  8015dc:	83 ec 1c             	sub    $0x1c,%esp
  8015df:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8015e3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8015e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8015eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8015ef:	89 ca                	mov    %ecx,%edx
  8015f1:	89 f8                	mov    %edi,%eax
  8015f3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8015f7:	85 f6                	test   %esi,%esi
  8015f9:	75 2d                	jne    801628 <__udivdi3+0x50>
  8015fb:	39 cf                	cmp    %ecx,%edi
  8015fd:	77 65                	ja     801664 <__udivdi3+0x8c>
  8015ff:	89 fd                	mov    %edi,%ebp
  801601:	85 ff                	test   %edi,%edi
  801603:	75 0b                	jne    801610 <__udivdi3+0x38>
  801605:	b8 01 00 00 00       	mov    $0x1,%eax
  80160a:	31 d2                	xor    %edx,%edx
  80160c:	f7 f7                	div    %edi
  80160e:	89 c5                	mov    %eax,%ebp
  801610:	31 d2                	xor    %edx,%edx
  801612:	89 c8                	mov    %ecx,%eax
  801614:	f7 f5                	div    %ebp
  801616:	89 c1                	mov    %eax,%ecx
  801618:	89 d8                	mov    %ebx,%eax
  80161a:	f7 f5                	div    %ebp
  80161c:	89 cf                	mov    %ecx,%edi
  80161e:	89 fa                	mov    %edi,%edx
  801620:	83 c4 1c             	add    $0x1c,%esp
  801623:	5b                   	pop    %ebx
  801624:	5e                   	pop    %esi
  801625:	5f                   	pop    %edi
  801626:	5d                   	pop    %ebp
  801627:	c3                   	ret    
  801628:	39 ce                	cmp    %ecx,%esi
  80162a:	77 28                	ja     801654 <__udivdi3+0x7c>
  80162c:	0f bd fe             	bsr    %esi,%edi
  80162f:	83 f7 1f             	xor    $0x1f,%edi
  801632:	75 40                	jne    801674 <__udivdi3+0x9c>
  801634:	39 ce                	cmp    %ecx,%esi
  801636:	72 0a                	jb     801642 <__udivdi3+0x6a>
  801638:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80163c:	0f 87 9e 00 00 00    	ja     8016e0 <__udivdi3+0x108>
  801642:	b8 01 00 00 00       	mov    $0x1,%eax
  801647:	89 fa                	mov    %edi,%edx
  801649:	83 c4 1c             	add    $0x1c,%esp
  80164c:	5b                   	pop    %ebx
  80164d:	5e                   	pop    %esi
  80164e:	5f                   	pop    %edi
  80164f:	5d                   	pop    %ebp
  801650:	c3                   	ret    
  801651:	8d 76 00             	lea    0x0(%esi),%esi
  801654:	31 ff                	xor    %edi,%edi
  801656:	31 c0                	xor    %eax,%eax
  801658:	89 fa                	mov    %edi,%edx
  80165a:	83 c4 1c             	add    $0x1c,%esp
  80165d:	5b                   	pop    %ebx
  80165e:	5e                   	pop    %esi
  80165f:	5f                   	pop    %edi
  801660:	5d                   	pop    %ebp
  801661:	c3                   	ret    
  801662:	66 90                	xchg   %ax,%ax
  801664:	89 d8                	mov    %ebx,%eax
  801666:	f7 f7                	div    %edi
  801668:	31 ff                	xor    %edi,%edi
  80166a:	89 fa                	mov    %edi,%edx
  80166c:	83 c4 1c             	add    $0x1c,%esp
  80166f:	5b                   	pop    %ebx
  801670:	5e                   	pop    %esi
  801671:	5f                   	pop    %edi
  801672:	5d                   	pop    %ebp
  801673:	c3                   	ret    
  801674:	bd 20 00 00 00       	mov    $0x20,%ebp
  801679:	89 eb                	mov    %ebp,%ebx
  80167b:	29 fb                	sub    %edi,%ebx
  80167d:	89 f9                	mov    %edi,%ecx
  80167f:	d3 e6                	shl    %cl,%esi
  801681:	89 c5                	mov    %eax,%ebp
  801683:	88 d9                	mov    %bl,%cl
  801685:	d3 ed                	shr    %cl,%ebp
  801687:	89 e9                	mov    %ebp,%ecx
  801689:	09 f1                	or     %esi,%ecx
  80168b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80168f:	89 f9                	mov    %edi,%ecx
  801691:	d3 e0                	shl    %cl,%eax
  801693:	89 c5                	mov    %eax,%ebp
  801695:	89 d6                	mov    %edx,%esi
  801697:	88 d9                	mov    %bl,%cl
  801699:	d3 ee                	shr    %cl,%esi
  80169b:	89 f9                	mov    %edi,%ecx
  80169d:	d3 e2                	shl    %cl,%edx
  80169f:	8b 44 24 08          	mov    0x8(%esp),%eax
  8016a3:	88 d9                	mov    %bl,%cl
  8016a5:	d3 e8                	shr    %cl,%eax
  8016a7:	09 c2                	or     %eax,%edx
  8016a9:	89 d0                	mov    %edx,%eax
  8016ab:	89 f2                	mov    %esi,%edx
  8016ad:	f7 74 24 0c          	divl   0xc(%esp)
  8016b1:	89 d6                	mov    %edx,%esi
  8016b3:	89 c3                	mov    %eax,%ebx
  8016b5:	f7 e5                	mul    %ebp
  8016b7:	39 d6                	cmp    %edx,%esi
  8016b9:	72 19                	jb     8016d4 <__udivdi3+0xfc>
  8016bb:	74 0b                	je     8016c8 <__udivdi3+0xf0>
  8016bd:	89 d8                	mov    %ebx,%eax
  8016bf:	31 ff                	xor    %edi,%edi
  8016c1:	e9 58 ff ff ff       	jmp    80161e <__udivdi3+0x46>
  8016c6:	66 90                	xchg   %ax,%ax
  8016c8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8016cc:	89 f9                	mov    %edi,%ecx
  8016ce:	d3 e2                	shl    %cl,%edx
  8016d0:	39 c2                	cmp    %eax,%edx
  8016d2:	73 e9                	jae    8016bd <__udivdi3+0xe5>
  8016d4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8016d7:	31 ff                	xor    %edi,%edi
  8016d9:	e9 40 ff ff ff       	jmp    80161e <__udivdi3+0x46>
  8016de:	66 90                	xchg   %ax,%ax
  8016e0:	31 c0                	xor    %eax,%eax
  8016e2:	e9 37 ff ff ff       	jmp    80161e <__udivdi3+0x46>
  8016e7:	90                   	nop

008016e8 <__umoddi3>:
  8016e8:	55                   	push   %ebp
  8016e9:	57                   	push   %edi
  8016ea:	56                   	push   %esi
  8016eb:	53                   	push   %ebx
  8016ec:	83 ec 1c             	sub    $0x1c,%esp
  8016ef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8016f3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8016f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016fb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8016ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801703:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801707:	89 f3                	mov    %esi,%ebx
  801709:	89 fa                	mov    %edi,%edx
  80170b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80170f:	89 34 24             	mov    %esi,(%esp)
  801712:	85 c0                	test   %eax,%eax
  801714:	75 1a                	jne    801730 <__umoddi3+0x48>
  801716:	39 f7                	cmp    %esi,%edi
  801718:	0f 86 a2 00 00 00    	jbe    8017c0 <__umoddi3+0xd8>
  80171e:	89 c8                	mov    %ecx,%eax
  801720:	89 f2                	mov    %esi,%edx
  801722:	f7 f7                	div    %edi
  801724:	89 d0                	mov    %edx,%eax
  801726:	31 d2                	xor    %edx,%edx
  801728:	83 c4 1c             	add    $0x1c,%esp
  80172b:	5b                   	pop    %ebx
  80172c:	5e                   	pop    %esi
  80172d:	5f                   	pop    %edi
  80172e:	5d                   	pop    %ebp
  80172f:	c3                   	ret    
  801730:	39 f0                	cmp    %esi,%eax
  801732:	0f 87 ac 00 00 00    	ja     8017e4 <__umoddi3+0xfc>
  801738:	0f bd e8             	bsr    %eax,%ebp
  80173b:	83 f5 1f             	xor    $0x1f,%ebp
  80173e:	0f 84 ac 00 00 00    	je     8017f0 <__umoddi3+0x108>
  801744:	bf 20 00 00 00       	mov    $0x20,%edi
  801749:	29 ef                	sub    %ebp,%edi
  80174b:	89 fe                	mov    %edi,%esi
  80174d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801751:	89 e9                	mov    %ebp,%ecx
  801753:	d3 e0                	shl    %cl,%eax
  801755:	89 d7                	mov    %edx,%edi
  801757:	89 f1                	mov    %esi,%ecx
  801759:	d3 ef                	shr    %cl,%edi
  80175b:	09 c7                	or     %eax,%edi
  80175d:	89 e9                	mov    %ebp,%ecx
  80175f:	d3 e2                	shl    %cl,%edx
  801761:	89 14 24             	mov    %edx,(%esp)
  801764:	89 d8                	mov    %ebx,%eax
  801766:	d3 e0                	shl    %cl,%eax
  801768:	89 c2                	mov    %eax,%edx
  80176a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80176e:	d3 e0                	shl    %cl,%eax
  801770:	89 44 24 04          	mov    %eax,0x4(%esp)
  801774:	8b 44 24 08          	mov    0x8(%esp),%eax
  801778:	89 f1                	mov    %esi,%ecx
  80177a:	d3 e8                	shr    %cl,%eax
  80177c:	09 d0                	or     %edx,%eax
  80177e:	d3 eb                	shr    %cl,%ebx
  801780:	89 da                	mov    %ebx,%edx
  801782:	f7 f7                	div    %edi
  801784:	89 d3                	mov    %edx,%ebx
  801786:	f7 24 24             	mull   (%esp)
  801789:	89 c6                	mov    %eax,%esi
  80178b:	89 d1                	mov    %edx,%ecx
  80178d:	39 d3                	cmp    %edx,%ebx
  80178f:	0f 82 87 00 00 00    	jb     80181c <__umoddi3+0x134>
  801795:	0f 84 91 00 00 00    	je     80182c <__umoddi3+0x144>
  80179b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80179f:	29 f2                	sub    %esi,%edx
  8017a1:	19 cb                	sbb    %ecx,%ebx
  8017a3:	89 d8                	mov    %ebx,%eax
  8017a5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8017a9:	d3 e0                	shl    %cl,%eax
  8017ab:	89 e9                	mov    %ebp,%ecx
  8017ad:	d3 ea                	shr    %cl,%edx
  8017af:	09 d0                	or     %edx,%eax
  8017b1:	89 e9                	mov    %ebp,%ecx
  8017b3:	d3 eb                	shr    %cl,%ebx
  8017b5:	89 da                	mov    %ebx,%edx
  8017b7:	83 c4 1c             	add    $0x1c,%esp
  8017ba:	5b                   	pop    %ebx
  8017bb:	5e                   	pop    %esi
  8017bc:	5f                   	pop    %edi
  8017bd:	5d                   	pop    %ebp
  8017be:	c3                   	ret    
  8017bf:	90                   	nop
  8017c0:	89 fd                	mov    %edi,%ebp
  8017c2:	85 ff                	test   %edi,%edi
  8017c4:	75 0b                	jne    8017d1 <__umoddi3+0xe9>
  8017c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017cb:	31 d2                	xor    %edx,%edx
  8017cd:	f7 f7                	div    %edi
  8017cf:	89 c5                	mov    %eax,%ebp
  8017d1:	89 f0                	mov    %esi,%eax
  8017d3:	31 d2                	xor    %edx,%edx
  8017d5:	f7 f5                	div    %ebp
  8017d7:	89 c8                	mov    %ecx,%eax
  8017d9:	f7 f5                	div    %ebp
  8017db:	89 d0                	mov    %edx,%eax
  8017dd:	e9 44 ff ff ff       	jmp    801726 <__umoddi3+0x3e>
  8017e2:	66 90                	xchg   %ax,%ax
  8017e4:	89 c8                	mov    %ecx,%eax
  8017e6:	89 f2                	mov    %esi,%edx
  8017e8:	83 c4 1c             	add    $0x1c,%esp
  8017eb:	5b                   	pop    %ebx
  8017ec:	5e                   	pop    %esi
  8017ed:	5f                   	pop    %edi
  8017ee:	5d                   	pop    %ebp
  8017ef:	c3                   	ret    
  8017f0:	3b 04 24             	cmp    (%esp),%eax
  8017f3:	72 06                	jb     8017fb <__umoddi3+0x113>
  8017f5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8017f9:	77 0f                	ja     80180a <__umoddi3+0x122>
  8017fb:	89 f2                	mov    %esi,%edx
  8017fd:	29 f9                	sub    %edi,%ecx
  8017ff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801803:	89 14 24             	mov    %edx,(%esp)
  801806:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80180a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80180e:	8b 14 24             	mov    (%esp),%edx
  801811:	83 c4 1c             	add    $0x1c,%esp
  801814:	5b                   	pop    %ebx
  801815:	5e                   	pop    %esi
  801816:	5f                   	pop    %edi
  801817:	5d                   	pop    %ebp
  801818:	c3                   	ret    
  801819:	8d 76 00             	lea    0x0(%esi),%esi
  80181c:	2b 04 24             	sub    (%esp),%eax
  80181f:	19 fa                	sbb    %edi,%edx
  801821:	89 d1                	mov    %edx,%ecx
  801823:	89 c6                	mov    %eax,%esi
  801825:	e9 71 ff ff ff       	jmp    80179b <__umoddi3+0xb3>
  80182a:	66 90                	xchg   %ax,%ax
  80182c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801830:	72 ea                	jb     80181c <__umoddi3+0x134>
  801832:	89 d9                	mov    %ebx,%ecx
  801834:	e9 62 ff ff ff       	jmp    80179b <__umoddi3+0xb3>
