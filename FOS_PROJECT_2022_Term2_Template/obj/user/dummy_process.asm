
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 8d 00 00 00       	call   8000c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 38             	sub    $0x38,%esp
	uint32 end1 = RAND(0, 5000);
  80004c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	50                   	push   %eax
  800053:	e8 ee 13 00 00       	call   801446 <sys_get_virtual_time>
  800058:	83 c4 0c             	add    $0xc,%esp
  80005b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80005e:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800063:	ba 00 00 00 00       	mov    $0x0,%edx
  800068:	f7 f1                	div    %ecx
  80006a:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  80006d:	8d 45 dc             	lea    -0x24(%ebp),%eax
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	50                   	push   %eax
  800074:	e8 cd 13 00 00       	call   801446 <sys_get_virtual_time>
  800079:	83 c4 0c             	add    $0xc,%esp
  80007c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80007f:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800084:	ba 00 00 00 00       	mov    $0x0,%edx
  800089:	f7 f1                	div    %ecx
  80008b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int x = 10;
  80008e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	for(int i = 0; i <= end1; i++)
  800095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009c:	eb 1a                	jmp    8000b8 <high_complexity_function+0x72>
	{
		for(int i = 0; i <= end2; i++)
  80009e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000a5:	eb 06                	jmp    8000ad <high_complexity_function+0x67>
		{
			{
				 x++;
  8000a7:	ff 45 f4             	incl   -0xc(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000aa:	ff 45 ec             	incl   -0x14(%ebp)
  8000ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8000b3:	76 f2                	jbe    8000a7 <high_complexity_function+0x61>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000b5:	ff 45 f0             	incl   -0x10(%ebp)
  8000b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8000be:	76 de                	jbe    80009e <high_complexity_function+0x58>
			{
				 x++;
			}
		}
	}
}
  8000c0:	90                   	nop
  8000c1:	c9                   	leave  
  8000c2:	c3                   	ret    

008000c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c3:	55                   	push   %ebp
  8000c4:	89 e5                	mov    %esp,%ebp
  8000c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c9:	e8 03 10 00 00       	call   8010d1 <sys_getenvindex>
  8000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d4:	89 d0                	mov    %edx,%eax
  8000d6:	c1 e0 02             	shl    $0x2,%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	01 c0                	add    %eax,%eax
  8000dd:	01 d0                	add    %edx,%eax
  8000df:	01 c0                	add    %eax,%eax
  8000e1:	01 d0                	add    %edx,%eax
  8000e3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000ea:	01 d0                	add    %edx,%eax
  8000ec:	c1 e0 02             	shl    $0x2,%eax
  8000ef:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f4:	a3 04 20 80 00       	mov    %eax,0x802004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f9:	a1 04 20 80 00       	mov    0x802004,%eax
  8000fe:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800104:	84 c0                	test   %al,%al
  800106:	74 0f                	je     800117 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800108:	a1 04 20 80 00       	mov    0x802004,%eax
  80010d:	05 f4 02 00 00       	add    $0x2f4,%eax
  800112:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800117:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011b:	7e 0a                	jle    800127 <libmain+0x64>
		binaryname = argv[0];
  80011d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800120:	8b 00                	mov    (%eax),%eax
  800122:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800127:	83 ec 08             	sub    $0x8,%esp
  80012a:	ff 75 0c             	pushl  0xc(%ebp)
  80012d:	ff 75 08             	pushl  0x8(%ebp)
  800130:	e8 03 ff ff ff       	call   800038 <_main>
  800135:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800138:	e8 2f 11 00 00       	call   80126c <sys_disable_interrupt>
	cprintf("**************************************\n");
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	68 d8 18 80 00       	push   $0x8018d8
  800145:	e8 5c 01 00 00       	call   8002a6 <cprintf>
  80014a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80014d:	a1 04 20 80 00       	mov    0x802004,%eax
  800152:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800158:	a1 04 20 80 00       	mov    0x802004,%eax
  80015d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800163:	83 ec 04             	sub    $0x4,%esp
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	68 00 19 80 00       	push   $0x801900
  80016d:	e8 34 01 00 00       	call   8002a6 <cprintf>
  800172:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800175:	a1 04 20 80 00       	mov    0x802004,%eax
  80017a:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800180:	83 ec 08             	sub    $0x8,%esp
  800183:	50                   	push   %eax
  800184:	68 25 19 80 00       	push   $0x801925
  800189:	e8 18 01 00 00       	call   8002a6 <cprintf>
  80018e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800191:	83 ec 0c             	sub    $0xc,%esp
  800194:	68 d8 18 80 00       	push   $0x8018d8
  800199:	e8 08 01 00 00       	call   8002a6 <cprintf>
  80019e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001a1:	e8 e0 10 00 00       	call   801286 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001a6:	e8 19 00 00 00       	call   8001c4 <exit>
}
  8001ab:	90                   	nop
  8001ac:	c9                   	leave  
  8001ad:	c3                   	ret    

008001ae <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001ae:	55                   	push   %ebp
  8001af:	89 e5                	mov    %esp,%ebp
  8001b1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001b4:	83 ec 0c             	sub    $0xc,%esp
  8001b7:	6a 00                	push   $0x0
  8001b9:	e8 df 0e 00 00       	call   80109d <sys_env_destroy>
  8001be:	83 c4 10             	add    $0x10,%esp
}
  8001c1:	90                   	nop
  8001c2:	c9                   	leave  
  8001c3:	c3                   	ret    

008001c4 <exit>:

void
exit(void)
{
  8001c4:	55                   	push   %ebp
  8001c5:	89 e5                	mov    %esp,%ebp
  8001c7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001ca:	e8 34 0f 00 00       	call   801103 <sys_env_exit>
}
  8001cf:	90                   	nop
  8001d0:	c9                   	leave  
  8001d1:	c3                   	ret    

008001d2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001d2:	55                   	push   %ebp
  8001d3:	89 e5                	mov    %esp,%ebp
  8001d5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001db:	8b 00                	mov    (%eax),%eax
  8001dd:	8d 48 01             	lea    0x1(%eax),%ecx
  8001e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e3:	89 0a                	mov    %ecx,(%edx)
  8001e5:	8b 55 08             	mov    0x8(%ebp),%edx
  8001e8:	88 d1                	mov    %dl,%cl
  8001ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ed:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f4:	8b 00                	mov    (%eax),%eax
  8001f6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001fb:	75 2c                	jne    800229 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001fd:	a0 08 20 80 00       	mov    0x802008,%al
  800202:	0f b6 c0             	movzbl %al,%eax
  800205:	8b 55 0c             	mov    0xc(%ebp),%edx
  800208:	8b 12                	mov    (%edx),%edx
  80020a:	89 d1                	mov    %edx,%ecx
  80020c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020f:	83 c2 08             	add    $0x8,%edx
  800212:	83 ec 04             	sub    $0x4,%esp
  800215:	50                   	push   %eax
  800216:	51                   	push   %ecx
  800217:	52                   	push   %edx
  800218:	e8 3e 0e 00 00       	call   80105b <sys_cputs>
  80021d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800220:	8b 45 0c             	mov    0xc(%ebp),%eax
  800223:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800229:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022c:	8b 40 04             	mov    0x4(%eax),%eax
  80022f:	8d 50 01             	lea    0x1(%eax),%edx
  800232:	8b 45 0c             	mov    0xc(%ebp),%eax
  800235:	89 50 04             	mov    %edx,0x4(%eax)
}
  800238:	90                   	nop
  800239:	c9                   	leave  
  80023a:	c3                   	ret    

0080023b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80023b:	55                   	push   %ebp
  80023c:	89 e5                	mov    %esp,%ebp
  80023e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800244:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80024b:	00 00 00 
	b.cnt = 0;
  80024e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800255:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800258:	ff 75 0c             	pushl  0xc(%ebp)
  80025b:	ff 75 08             	pushl  0x8(%ebp)
  80025e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800264:	50                   	push   %eax
  800265:	68 d2 01 80 00       	push   $0x8001d2
  80026a:	e8 11 02 00 00       	call   800480 <vprintfmt>
  80026f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800272:	a0 08 20 80 00       	mov    0x802008,%al
  800277:	0f b6 c0             	movzbl %al,%eax
  80027a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	50                   	push   %eax
  800284:	52                   	push   %edx
  800285:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80028b:	83 c0 08             	add    $0x8,%eax
  80028e:	50                   	push   %eax
  80028f:	e8 c7 0d 00 00       	call   80105b <sys_cputs>
  800294:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800297:	c6 05 08 20 80 00 00 	movb   $0x0,0x802008
	return b.cnt;
  80029e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002a4:	c9                   	leave  
  8002a5:	c3                   	ret    

008002a6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002a6:	55                   	push   %ebp
  8002a7:	89 e5                	mov    %esp,%ebp
  8002a9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002ac:	c6 05 08 20 80 00 01 	movb   $0x1,0x802008
	va_start(ap, fmt);
  8002b3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bc:	83 ec 08             	sub    $0x8,%esp
  8002bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c2:	50                   	push   %eax
  8002c3:	e8 73 ff ff ff       	call   80023b <vcprintf>
  8002c8:	83 c4 10             	add    $0x10,%esp
  8002cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d1:	c9                   	leave  
  8002d2:	c3                   	ret    

008002d3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002d3:	55                   	push   %ebp
  8002d4:	89 e5                	mov    %esp,%ebp
  8002d6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002d9:	e8 8e 0f 00 00       	call   80126c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	83 ec 08             	sub    $0x8,%esp
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	50                   	push   %eax
  8002ee:	e8 48 ff ff ff       	call   80023b <vcprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
  8002f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002f9:	e8 88 0f 00 00       	call   801286 <sys_enable_interrupt>
	return cnt;
  8002fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800301:	c9                   	leave  
  800302:	c3                   	ret    

00800303 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800303:	55                   	push   %ebp
  800304:	89 e5                	mov    %esp,%ebp
  800306:	53                   	push   %ebx
  800307:	83 ec 14             	sub    $0x14,%esp
  80030a:	8b 45 10             	mov    0x10(%ebp),%eax
  80030d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800310:	8b 45 14             	mov    0x14(%ebp),%eax
  800313:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800316:	8b 45 18             	mov    0x18(%ebp),%eax
  800319:	ba 00 00 00 00       	mov    $0x0,%edx
  80031e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800321:	77 55                	ja     800378 <printnum+0x75>
  800323:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800326:	72 05                	jb     80032d <printnum+0x2a>
  800328:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032b:	77 4b                	ja     800378 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80032d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800330:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800333:	8b 45 18             	mov    0x18(%ebp),%eax
  800336:	ba 00 00 00 00       	mov    $0x0,%edx
  80033b:	52                   	push   %edx
  80033c:	50                   	push   %eax
  80033d:	ff 75 f4             	pushl  -0xc(%ebp)
  800340:	ff 75 f0             	pushl  -0x10(%ebp)
  800343:	e8 04 13 00 00       	call   80164c <__udivdi3>
  800348:	83 c4 10             	add    $0x10,%esp
  80034b:	83 ec 04             	sub    $0x4,%esp
  80034e:	ff 75 20             	pushl  0x20(%ebp)
  800351:	53                   	push   %ebx
  800352:	ff 75 18             	pushl  0x18(%ebp)
  800355:	52                   	push   %edx
  800356:	50                   	push   %eax
  800357:	ff 75 0c             	pushl  0xc(%ebp)
  80035a:	ff 75 08             	pushl  0x8(%ebp)
  80035d:	e8 a1 ff ff ff       	call   800303 <printnum>
  800362:	83 c4 20             	add    $0x20,%esp
  800365:	eb 1a                	jmp    800381 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800367:	83 ec 08             	sub    $0x8,%esp
  80036a:	ff 75 0c             	pushl  0xc(%ebp)
  80036d:	ff 75 20             	pushl  0x20(%ebp)
  800370:	8b 45 08             	mov    0x8(%ebp),%eax
  800373:	ff d0                	call   *%eax
  800375:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800378:	ff 4d 1c             	decl   0x1c(%ebp)
  80037b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80037f:	7f e6                	jg     800367 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800381:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800384:	bb 00 00 00 00       	mov    $0x0,%ebx
  800389:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80038f:	53                   	push   %ebx
  800390:	51                   	push   %ecx
  800391:	52                   	push   %edx
  800392:	50                   	push   %eax
  800393:	e8 c4 13 00 00       	call   80175c <__umoddi3>
  800398:	83 c4 10             	add    $0x10,%esp
  80039b:	05 54 1b 80 00       	add    $0x801b54,%eax
  8003a0:	8a 00                	mov    (%eax),%al
  8003a2:	0f be c0             	movsbl %al,%eax
  8003a5:	83 ec 08             	sub    $0x8,%esp
  8003a8:	ff 75 0c             	pushl  0xc(%ebp)
  8003ab:	50                   	push   %eax
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	ff d0                	call   *%eax
  8003b1:	83 c4 10             	add    $0x10,%esp
}
  8003b4:	90                   	nop
  8003b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003b8:	c9                   	leave  
  8003b9:	c3                   	ret    

008003ba <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003ba:	55                   	push   %ebp
  8003bb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003bd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c1:	7e 1c                	jle    8003df <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	8d 50 08             	lea    0x8(%eax),%edx
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	89 10                	mov    %edx,(%eax)
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	8b 00                	mov    (%eax),%eax
  8003d5:	83 e8 08             	sub    $0x8,%eax
  8003d8:	8b 50 04             	mov    0x4(%eax),%edx
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	eb 40                	jmp    80041f <getuint+0x65>
	else if (lflag)
  8003df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e3:	74 1e                	je     800403 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	8d 50 04             	lea    0x4(%eax),%edx
  8003ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f0:	89 10                	mov    %edx,(%eax)
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	83 e8 04             	sub    $0x4,%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800401:	eb 1c                	jmp    80041f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  80041f:	5d                   	pop    %ebp
  800420:	c3                   	ret    

00800421 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800421:	55                   	push   %ebp
  800422:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800424:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800428:	7e 1c                	jle    800446 <getint+0x25>
		return va_arg(*ap, long long);
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	8d 50 08             	lea    0x8(%eax),%edx
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	89 10                	mov    %edx,(%eax)
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	83 e8 08             	sub    $0x8,%eax
  80043f:	8b 50 04             	mov    0x4(%eax),%edx
  800442:	8b 00                	mov    (%eax),%eax
  800444:	eb 38                	jmp    80047e <getint+0x5d>
	else if (lflag)
  800446:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80044a:	74 1a                	je     800466 <getint+0x45>
		return va_arg(*ap, long);
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	8d 50 04             	lea    0x4(%eax),%edx
  800454:	8b 45 08             	mov    0x8(%ebp),%eax
  800457:	89 10                	mov    %edx,(%eax)
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	83 e8 04             	sub    $0x4,%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	99                   	cltd   
  800464:	eb 18                	jmp    80047e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	8d 50 04             	lea    0x4(%eax),%edx
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	89 10                	mov    %edx,(%eax)
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	83 e8 04             	sub    $0x4,%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	99                   	cltd   
}
  80047e:	5d                   	pop    %ebp
  80047f:	c3                   	ret    

00800480 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800480:	55                   	push   %ebp
  800481:	89 e5                	mov    %esp,%ebp
  800483:	56                   	push   %esi
  800484:	53                   	push   %ebx
  800485:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800488:	eb 17                	jmp    8004a1 <vprintfmt+0x21>
			if (ch == '\0')
  80048a:	85 db                	test   %ebx,%ebx
  80048c:	0f 84 af 03 00 00    	je     800841 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	ff 75 0c             	pushl  0xc(%ebp)
  800498:	53                   	push   %ebx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	ff d0                	call   *%eax
  80049e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a4:	8d 50 01             	lea    0x1(%eax),%edx
  8004a7:	89 55 10             	mov    %edx,0x10(%ebp)
  8004aa:	8a 00                	mov    (%eax),%al
  8004ac:	0f b6 d8             	movzbl %al,%ebx
  8004af:	83 fb 25             	cmp    $0x25,%ebx
  8004b2:	75 d6                	jne    80048a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004b4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004b8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004bf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004c6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004cd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d7:	8d 50 01             	lea    0x1(%eax),%edx
  8004da:	89 55 10             	mov    %edx,0x10(%ebp)
  8004dd:	8a 00                	mov    (%eax),%al
  8004df:	0f b6 d8             	movzbl %al,%ebx
  8004e2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004e5:	83 f8 55             	cmp    $0x55,%eax
  8004e8:	0f 87 2b 03 00 00    	ja     800819 <vprintfmt+0x399>
  8004ee:	8b 04 85 78 1b 80 00 	mov    0x801b78(,%eax,4),%eax
  8004f5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004f7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004fb:	eb d7                	jmp    8004d4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004fd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800501:	eb d1                	jmp    8004d4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800503:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80050a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80050d:	89 d0                	mov    %edx,%eax
  80050f:	c1 e0 02             	shl    $0x2,%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	01 c0                	add    %eax,%eax
  800516:	01 d8                	add    %ebx,%eax
  800518:	83 e8 30             	sub    $0x30,%eax
  80051b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80051e:	8b 45 10             	mov    0x10(%ebp),%eax
  800521:	8a 00                	mov    (%eax),%al
  800523:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800526:	83 fb 2f             	cmp    $0x2f,%ebx
  800529:	7e 3e                	jle    800569 <vprintfmt+0xe9>
  80052b:	83 fb 39             	cmp    $0x39,%ebx
  80052e:	7f 39                	jg     800569 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800530:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800533:	eb d5                	jmp    80050a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800535:	8b 45 14             	mov    0x14(%ebp),%eax
  800538:	83 c0 04             	add    $0x4,%eax
  80053b:	89 45 14             	mov    %eax,0x14(%ebp)
  80053e:	8b 45 14             	mov    0x14(%ebp),%eax
  800541:	83 e8 04             	sub    $0x4,%eax
  800544:	8b 00                	mov    (%eax),%eax
  800546:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800549:	eb 1f                	jmp    80056a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80054b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80054f:	79 83                	jns    8004d4 <vprintfmt+0x54>
				width = 0;
  800551:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800558:	e9 77 ff ff ff       	jmp    8004d4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80055d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800564:	e9 6b ff ff ff       	jmp    8004d4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800569:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80056a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80056e:	0f 89 60 ff ff ff    	jns    8004d4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800574:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800577:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80057a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800581:	e9 4e ff ff ff       	jmp    8004d4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800586:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800589:	e9 46 ff ff ff       	jmp    8004d4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80058e:	8b 45 14             	mov    0x14(%ebp),%eax
  800591:	83 c0 04             	add    $0x4,%eax
  800594:	89 45 14             	mov    %eax,0x14(%ebp)
  800597:	8b 45 14             	mov    0x14(%ebp),%eax
  80059a:	83 e8 04             	sub    $0x4,%eax
  80059d:	8b 00                	mov    (%eax),%eax
  80059f:	83 ec 08             	sub    $0x8,%esp
  8005a2:	ff 75 0c             	pushl  0xc(%ebp)
  8005a5:	50                   	push   %eax
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	ff d0                	call   *%eax
  8005ab:	83 c4 10             	add    $0x10,%esp
			break;
  8005ae:	e9 89 02 00 00       	jmp    80083c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b6:	83 c0 04             	add    $0x4,%eax
  8005b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 e8 04             	sub    $0x4,%eax
  8005c2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005c4:	85 db                	test   %ebx,%ebx
  8005c6:	79 02                	jns    8005ca <vprintfmt+0x14a>
				err = -err;
  8005c8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005ca:	83 fb 64             	cmp    $0x64,%ebx
  8005cd:	7f 0b                	jg     8005da <vprintfmt+0x15a>
  8005cf:	8b 34 9d c0 19 80 00 	mov    0x8019c0(,%ebx,4),%esi
  8005d6:	85 f6                	test   %esi,%esi
  8005d8:	75 19                	jne    8005f3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005da:	53                   	push   %ebx
  8005db:	68 65 1b 80 00       	push   $0x801b65
  8005e0:	ff 75 0c             	pushl  0xc(%ebp)
  8005e3:	ff 75 08             	pushl  0x8(%ebp)
  8005e6:	e8 5e 02 00 00       	call   800849 <printfmt>
  8005eb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ee:	e9 49 02 00 00       	jmp    80083c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005f3:	56                   	push   %esi
  8005f4:	68 6e 1b 80 00       	push   $0x801b6e
  8005f9:	ff 75 0c             	pushl  0xc(%ebp)
  8005fc:	ff 75 08             	pushl  0x8(%ebp)
  8005ff:	e8 45 02 00 00       	call   800849 <printfmt>
  800604:	83 c4 10             	add    $0x10,%esp
			break;
  800607:	e9 30 02 00 00       	jmp    80083c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80060c:	8b 45 14             	mov    0x14(%ebp),%eax
  80060f:	83 c0 04             	add    $0x4,%eax
  800612:	89 45 14             	mov    %eax,0x14(%ebp)
  800615:	8b 45 14             	mov    0x14(%ebp),%eax
  800618:	83 e8 04             	sub    $0x4,%eax
  80061b:	8b 30                	mov    (%eax),%esi
  80061d:	85 f6                	test   %esi,%esi
  80061f:	75 05                	jne    800626 <vprintfmt+0x1a6>
				p = "(null)";
  800621:	be 71 1b 80 00       	mov    $0x801b71,%esi
			if (width > 0 && padc != '-')
  800626:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062a:	7e 6d                	jle    800699 <vprintfmt+0x219>
  80062c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800630:	74 67                	je     800699 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800632:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800635:	83 ec 08             	sub    $0x8,%esp
  800638:	50                   	push   %eax
  800639:	56                   	push   %esi
  80063a:	e8 0c 03 00 00       	call   80094b <strnlen>
  80063f:	83 c4 10             	add    $0x10,%esp
  800642:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800645:	eb 16                	jmp    80065d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800647:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80064b:	83 ec 08             	sub    $0x8,%esp
  80064e:	ff 75 0c             	pushl  0xc(%ebp)
  800651:	50                   	push   %eax
  800652:	8b 45 08             	mov    0x8(%ebp),%eax
  800655:	ff d0                	call   *%eax
  800657:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80065a:	ff 4d e4             	decl   -0x1c(%ebp)
  80065d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800661:	7f e4                	jg     800647 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800663:	eb 34                	jmp    800699 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800665:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800669:	74 1c                	je     800687 <vprintfmt+0x207>
  80066b:	83 fb 1f             	cmp    $0x1f,%ebx
  80066e:	7e 05                	jle    800675 <vprintfmt+0x1f5>
  800670:	83 fb 7e             	cmp    $0x7e,%ebx
  800673:	7e 12                	jle    800687 <vprintfmt+0x207>
					putch('?', putdat);
  800675:	83 ec 08             	sub    $0x8,%esp
  800678:	ff 75 0c             	pushl  0xc(%ebp)
  80067b:	6a 3f                	push   $0x3f
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	ff d0                	call   *%eax
  800682:	83 c4 10             	add    $0x10,%esp
  800685:	eb 0f                	jmp    800696 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800687:	83 ec 08             	sub    $0x8,%esp
  80068a:	ff 75 0c             	pushl  0xc(%ebp)
  80068d:	53                   	push   %ebx
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	ff d0                	call   *%eax
  800693:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800696:	ff 4d e4             	decl   -0x1c(%ebp)
  800699:	89 f0                	mov    %esi,%eax
  80069b:	8d 70 01             	lea    0x1(%eax),%esi
  80069e:	8a 00                	mov    (%eax),%al
  8006a0:	0f be d8             	movsbl %al,%ebx
  8006a3:	85 db                	test   %ebx,%ebx
  8006a5:	74 24                	je     8006cb <vprintfmt+0x24b>
  8006a7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ab:	78 b8                	js     800665 <vprintfmt+0x1e5>
  8006ad:	ff 4d e0             	decl   -0x20(%ebp)
  8006b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b4:	79 af                	jns    800665 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b6:	eb 13                	jmp    8006cb <vprintfmt+0x24b>
				putch(' ', putdat);
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	6a 20                	push   $0x20
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	ff d0                	call   *%eax
  8006c5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c8:	ff 4d e4             	decl   -0x1c(%ebp)
  8006cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006cf:	7f e7                	jg     8006b8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006d1:	e9 66 01 00 00       	jmp    80083c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006d6:	83 ec 08             	sub    $0x8,%esp
  8006d9:	ff 75 e8             	pushl  -0x18(%ebp)
  8006dc:	8d 45 14             	lea    0x14(%ebp),%eax
  8006df:	50                   	push   %eax
  8006e0:	e8 3c fd ff ff       	call   800421 <getint>
  8006e5:	83 c4 10             	add    $0x10,%esp
  8006e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f4:	85 d2                	test   %edx,%edx
  8006f6:	79 23                	jns    80071b <vprintfmt+0x29b>
				putch('-', putdat);
  8006f8:	83 ec 08             	sub    $0x8,%esp
  8006fb:	ff 75 0c             	pushl  0xc(%ebp)
  8006fe:	6a 2d                	push   $0x2d
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	ff d0                	call   *%eax
  800705:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800708:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070e:	f7 d8                	neg    %eax
  800710:	83 d2 00             	adc    $0x0,%edx
  800713:	f7 da                	neg    %edx
  800715:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800718:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80071b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800722:	e9 bc 00 00 00       	jmp    8007e3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 e8             	pushl  -0x18(%ebp)
  80072d:	8d 45 14             	lea    0x14(%ebp),%eax
  800730:	50                   	push   %eax
  800731:	e8 84 fc ff ff       	call   8003ba <getuint>
  800736:	83 c4 10             	add    $0x10,%esp
  800739:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80073c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80073f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800746:	e9 98 00 00 00       	jmp    8007e3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 0c             	pushl  0xc(%ebp)
  800751:	6a 58                	push   $0x58
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	ff d0                	call   *%eax
  800758:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 0c             	pushl  0xc(%ebp)
  800761:	6a 58                	push   $0x58
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	ff d0                	call   *%eax
  800768:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	ff 75 0c             	pushl  0xc(%ebp)
  800771:	6a 58                	push   $0x58
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	ff d0                	call   *%eax
  800778:	83 c4 10             	add    $0x10,%esp
			break;
  80077b:	e9 bc 00 00 00       	jmp    80083c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	6a 30                	push   $0x30
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800790:	83 ec 08             	sub    $0x8,%esp
  800793:	ff 75 0c             	pushl  0xc(%ebp)
  800796:	6a 78                	push   $0x78
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	ff d0                	call   *%eax
  80079d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a3:	83 c0 04             	add    $0x4,%eax
  8007a6:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ac:	83 e8 04             	sub    $0x4,%eax
  8007af:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007bb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007c2:	eb 1f                	jmp    8007e3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ca:	8d 45 14             	lea    0x14(%ebp),%eax
  8007cd:	50                   	push   %eax
  8007ce:	e8 e7 fb ff ff       	call   8003ba <getuint>
  8007d3:	83 c4 10             	add    $0x10,%esp
  8007d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007dc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007e3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ea:	83 ec 04             	sub    $0x4,%esp
  8007ed:	52                   	push   %edx
  8007ee:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007f1:	50                   	push   %eax
  8007f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	ff 75 08             	pushl  0x8(%ebp)
  8007fe:	e8 00 fb ff ff       	call   800303 <printnum>
  800803:	83 c4 20             	add    $0x20,%esp
			break;
  800806:	eb 34                	jmp    80083c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800808:	83 ec 08             	sub    $0x8,%esp
  80080b:	ff 75 0c             	pushl  0xc(%ebp)
  80080e:	53                   	push   %ebx
  80080f:	8b 45 08             	mov    0x8(%ebp),%eax
  800812:	ff d0                	call   *%eax
  800814:	83 c4 10             	add    $0x10,%esp
			break;
  800817:	eb 23                	jmp    80083c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800819:	83 ec 08             	sub    $0x8,%esp
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	6a 25                	push   $0x25
  800821:	8b 45 08             	mov    0x8(%ebp),%eax
  800824:	ff d0                	call   *%eax
  800826:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800829:	ff 4d 10             	decl   0x10(%ebp)
  80082c:	eb 03                	jmp    800831 <vprintfmt+0x3b1>
  80082e:	ff 4d 10             	decl   0x10(%ebp)
  800831:	8b 45 10             	mov    0x10(%ebp),%eax
  800834:	48                   	dec    %eax
  800835:	8a 00                	mov    (%eax),%al
  800837:	3c 25                	cmp    $0x25,%al
  800839:	75 f3                	jne    80082e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80083b:	90                   	nop
		}
	}
  80083c:	e9 47 fc ff ff       	jmp    800488 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800841:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800842:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800845:	5b                   	pop    %ebx
  800846:	5e                   	pop    %esi
  800847:	5d                   	pop    %ebp
  800848:	c3                   	ret    

00800849 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800849:	55                   	push   %ebp
  80084a:	89 e5                	mov    %esp,%ebp
  80084c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80084f:	8d 45 10             	lea    0x10(%ebp),%eax
  800852:	83 c0 04             	add    $0x4,%eax
  800855:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800858:	8b 45 10             	mov    0x10(%ebp),%eax
  80085b:	ff 75 f4             	pushl  -0xc(%ebp)
  80085e:	50                   	push   %eax
  80085f:	ff 75 0c             	pushl  0xc(%ebp)
  800862:	ff 75 08             	pushl  0x8(%ebp)
  800865:	e8 16 fc ff ff       	call   800480 <vprintfmt>
  80086a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80086d:	90                   	nop
  80086e:	c9                   	leave  
  80086f:	c3                   	ret    

00800870 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800870:	55                   	push   %ebp
  800871:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800873:	8b 45 0c             	mov    0xc(%ebp),%eax
  800876:	8b 40 08             	mov    0x8(%eax),%eax
  800879:	8d 50 01             	lea    0x1(%eax),%edx
  80087c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800882:	8b 45 0c             	mov    0xc(%ebp),%eax
  800885:	8b 10                	mov    (%eax),%edx
  800887:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088a:	8b 40 04             	mov    0x4(%eax),%eax
  80088d:	39 c2                	cmp    %eax,%edx
  80088f:	73 12                	jae    8008a3 <sprintputch+0x33>
		*b->buf++ = ch;
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	8b 00                	mov    (%eax),%eax
  800896:	8d 48 01             	lea    0x1(%eax),%ecx
  800899:	8b 55 0c             	mov    0xc(%ebp),%edx
  80089c:	89 0a                	mov    %ecx,(%edx)
  80089e:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a1:	88 10                	mov    %dl,(%eax)
}
  8008a3:	90                   	nop
  8008a4:	5d                   	pop    %ebp
  8008a5:	c3                   	ret    

008008a6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008a6:	55                   	push   %ebp
  8008a7:	89 e5                	mov    %esp,%ebp
  8008a9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bb:	01 d0                	add    %edx,%eax
  8008bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008cb:	74 06                	je     8008d3 <vsnprintf+0x2d>
  8008cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d1:	7f 07                	jg     8008da <vsnprintf+0x34>
		return -E_INVAL;
  8008d3:	b8 03 00 00 00       	mov    $0x3,%eax
  8008d8:	eb 20                	jmp    8008fa <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008da:	ff 75 14             	pushl  0x14(%ebp)
  8008dd:	ff 75 10             	pushl  0x10(%ebp)
  8008e0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008e3:	50                   	push   %eax
  8008e4:	68 70 08 80 00       	push   $0x800870
  8008e9:	e8 92 fb ff ff       	call   800480 <vprintfmt>
  8008ee:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008f4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800902:	8d 45 10             	lea    0x10(%ebp),%eax
  800905:	83 c0 04             	add    $0x4,%eax
  800908:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80090b:	8b 45 10             	mov    0x10(%ebp),%eax
  80090e:	ff 75 f4             	pushl  -0xc(%ebp)
  800911:	50                   	push   %eax
  800912:	ff 75 0c             	pushl  0xc(%ebp)
  800915:	ff 75 08             	pushl  0x8(%ebp)
  800918:	e8 89 ff ff ff       	call   8008a6 <vsnprintf>
  80091d:	83 c4 10             	add    $0x10,%esp
  800920:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800923:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800926:	c9                   	leave  
  800927:	c3                   	ret    

00800928 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800928:	55                   	push   %ebp
  800929:	89 e5                	mov    %esp,%ebp
  80092b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80092e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800935:	eb 06                	jmp    80093d <strlen+0x15>
		n++;
  800937:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80093a:	ff 45 08             	incl   0x8(%ebp)
  80093d:	8b 45 08             	mov    0x8(%ebp),%eax
  800940:	8a 00                	mov    (%eax),%al
  800942:	84 c0                	test   %al,%al
  800944:	75 f1                	jne    800937 <strlen+0xf>
		n++;
	return n;
  800946:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800949:	c9                   	leave  
  80094a:	c3                   	ret    

0080094b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80094b:	55                   	push   %ebp
  80094c:	89 e5                	mov    %esp,%ebp
  80094e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800951:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800958:	eb 09                	jmp    800963 <strnlen+0x18>
		n++;
  80095a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80095d:	ff 45 08             	incl   0x8(%ebp)
  800960:	ff 4d 0c             	decl   0xc(%ebp)
  800963:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800967:	74 09                	je     800972 <strnlen+0x27>
  800969:	8b 45 08             	mov    0x8(%ebp),%eax
  80096c:	8a 00                	mov    (%eax),%al
  80096e:	84 c0                	test   %al,%al
  800970:	75 e8                	jne    80095a <strnlen+0xf>
		n++;
	return n;
  800972:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800975:	c9                   	leave  
  800976:	c3                   	ret    

00800977 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800977:	55                   	push   %ebp
  800978:	89 e5                	mov    %esp,%ebp
  80097a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800983:	90                   	nop
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	8d 50 01             	lea    0x1(%eax),%edx
  80098a:	89 55 08             	mov    %edx,0x8(%ebp)
  80098d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800990:	8d 4a 01             	lea    0x1(%edx),%ecx
  800993:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800996:	8a 12                	mov    (%edx),%dl
  800998:	88 10                	mov    %dl,(%eax)
  80099a:	8a 00                	mov    (%eax),%al
  80099c:	84 c0                	test   %al,%al
  80099e:	75 e4                	jne    800984 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009a3:	c9                   	leave  
  8009a4:	c3                   	ret    

008009a5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009a5:	55                   	push   %ebp
  8009a6:	89 e5                	mov    %esp,%ebp
  8009a8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009b8:	eb 1f                	jmp    8009d9 <strncpy+0x34>
		*dst++ = *src;
  8009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bd:	8d 50 01             	lea    0x1(%eax),%edx
  8009c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c6:	8a 12                	mov    (%edx),%dl
  8009c8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cd:	8a 00                	mov    (%eax),%al
  8009cf:	84 c0                	test   %al,%al
  8009d1:	74 03                	je     8009d6 <strncpy+0x31>
			src++;
  8009d3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009d6:	ff 45 fc             	incl   -0x4(%ebp)
  8009d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009dc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009df:	72 d9                	jb     8009ba <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f6:	74 30                	je     800a28 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009f8:	eb 16                	jmp    800a10 <strlcpy+0x2a>
			*dst++ = *src++;
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	8d 50 01             	lea    0x1(%eax),%edx
  800a00:	89 55 08             	mov    %edx,0x8(%ebp)
  800a03:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a06:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a09:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a0c:	8a 12                	mov    (%edx),%dl
  800a0e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a10:	ff 4d 10             	decl   0x10(%ebp)
  800a13:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a17:	74 09                	je     800a22 <strlcpy+0x3c>
  800a19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1c:	8a 00                	mov    (%eax),%al
  800a1e:	84 c0                	test   %al,%al
  800a20:	75 d8                	jne    8009fa <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a28:	8b 55 08             	mov    0x8(%ebp),%edx
  800a2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a2e:	29 c2                	sub    %eax,%edx
  800a30:	89 d0                	mov    %edx,%eax
}
  800a32:	c9                   	leave  
  800a33:	c3                   	ret    

00800a34 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a34:	55                   	push   %ebp
  800a35:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a37:	eb 06                	jmp    800a3f <strcmp+0xb>
		p++, q++;
  800a39:	ff 45 08             	incl   0x8(%ebp)
  800a3c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	84 c0                	test   %al,%al
  800a46:	74 0e                	je     800a56 <strcmp+0x22>
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	8a 10                	mov    (%eax),%dl
  800a4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a50:	8a 00                	mov    (%eax),%al
  800a52:	38 c2                	cmp    %al,%dl
  800a54:	74 e3                	je     800a39 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	0f b6 d0             	movzbl %al,%edx
  800a5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a61:	8a 00                	mov    (%eax),%al
  800a63:	0f b6 c0             	movzbl %al,%eax
  800a66:	29 c2                	sub    %eax,%edx
  800a68:	89 d0                	mov    %edx,%eax
}
  800a6a:	5d                   	pop    %ebp
  800a6b:	c3                   	ret    

00800a6c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a6c:	55                   	push   %ebp
  800a6d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a6f:	eb 09                	jmp    800a7a <strncmp+0xe>
		n--, p++, q++;
  800a71:	ff 4d 10             	decl   0x10(%ebp)
  800a74:	ff 45 08             	incl   0x8(%ebp)
  800a77:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7e:	74 17                	je     800a97 <strncmp+0x2b>
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	8a 00                	mov    (%eax),%al
  800a85:	84 c0                	test   %al,%al
  800a87:	74 0e                	je     800a97 <strncmp+0x2b>
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8a 10                	mov    (%eax),%dl
  800a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a91:	8a 00                	mov    (%eax),%al
  800a93:	38 c2                	cmp    %al,%dl
  800a95:	74 da                	je     800a71 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a9b:	75 07                	jne    800aa4 <strncmp+0x38>
		return 0;
  800a9d:	b8 00 00 00 00       	mov    $0x0,%eax
  800aa2:	eb 14                	jmp    800ab8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	0f b6 d0             	movzbl %al,%edx
  800aac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaf:	8a 00                	mov    (%eax),%al
  800ab1:	0f b6 c0             	movzbl %al,%eax
  800ab4:	29 c2                	sub    %eax,%edx
  800ab6:	89 d0                	mov    %edx,%eax
}
  800ab8:	5d                   	pop    %ebp
  800ab9:	c3                   	ret    

00800aba <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aba:	55                   	push   %ebp
  800abb:	89 e5                	mov    %esp,%ebp
  800abd:	83 ec 04             	sub    $0x4,%esp
  800ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ac6:	eb 12                	jmp    800ada <strchr+0x20>
		if (*s == c)
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	8a 00                	mov    (%eax),%al
  800acd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad0:	75 05                	jne    800ad7 <strchr+0x1d>
			return (char *) s;
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	eb 11                	jmp    800ae8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ad7:	ff 45 08             	incl   0x8(%ebp)
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8a 00                	mov    (%eax),%al
  800adf:	84 c0                	test   %al,%al
  800ae1:	75 e5                	jne    800ac8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ae3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ae8:	c9                   	leave  
  800ae9:	c3                   	ret    

00800aea <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aea:	55                   	push   %ebp
  800aeb:	89 e5                	mov    %esp,%ebp
  800aed:	83 ec 04             	sub    $0x4,%esp
  800af0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800af6:	eb 0d                	jmp    800b05 <strfind+0x1b>
		if (*s == c)
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8a 00                	mov    (%eax),%al
  800afd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b00:	74 0e                	je     800b10 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b02:	ff 45 08             	incl   0x8(%ebp)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	84 c0                	test   %al,%al
  800b0c:	75 ea                	jne    800af8 <strfind+0xe>
  800b0e:	eb 01                	jmp    800b11 <strfind+0x27>
		if (*s == c)
			break;
  800b10:	90                   	nop
	return (char *) s;
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b14:	c9                   	leave  
  800b15:	c3                   	ret    

00800b16 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b16:	55                   	push   %ebp
  800b17:	89 e5                	mov    %esp,%ebp
  800b19:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b22:	8b 45 10             	mov    0x10(%ebp),%eax
  800b25:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b28:	eb 0e                	jmp    800b38 <memset+0x22>
		*p++ = c;
  800b2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b2d:	8d 50 01             	lea    0x1(%eax),%edx
  800b30:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b33:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b36:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b38:	ff 4d f8             	decl   -0x8(%ebp)
  800b3b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b3f:	79 e9                	jns    800b2a <memset+0x14>
		*p++ = c;

	return v;
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b44:	c9                   	leave  
  800b45:	c3                   	ret    

00800b46 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b46:	55                   	push   %ebp
  800b47:	89 e5                	mov    %esp,%ebp
  800b49:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b58:	eb 16                	jmp    800b70 <memcpy+0x2a>
		*d++ = *s++;
  800b5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b5d:	8d 50 01             	lea    0x1(%eax),%edx
  800b60:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b66:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b69:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b6c:	8a 12                	mov    (%edx),%dl
  800b6e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b70:	8b 45 10             	mov    0x10(%ebp),%eax
  800b73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b76:	89 55 10             	mov    %edx,0x10(%ebp)
  800b79:	85 c0                	test   %eax,%eax
  800b7b:	75 dd                	jne    800b5a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b97:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b9a:	73 50                	jae    800bec <memmove+0x6a>
  800b9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba2:	01 d0                	add    %edx,%eax
  800ba4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba7:	76 43                	jbe    800bec <memmove+0x6a>
		s += n;
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800baf:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bb5:	eb 10                	jmp    800bc7 <memmove+0x45>
			*--d = *--s;
  800bb7:	ff 4d f8             	decl   -0x8(%ebp)
  800bba:	ff 4d fc             	decl   -0x4(%ebp)
  800bbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc0:	8a 10                	mov    (%eax),%dl
  800bc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bca:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcd:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd0:	85 c0                	test   %eax,%eax
  800bd2:	75 e3                	jne    800bb7 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bd4:	eb 23                	jmp    800bf9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bd6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd9:	8d 50 01             	lea    0x1(%eax),%edx
  800bdc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bdf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800be2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800be5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800be8:	8a 12                	mov    (%edx),%dl
  800bea:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bec:	8b 45 10             	mov    0x10(%ebp),%eax
  800bef:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf5:	85 c0                	test   %eax,%eax
  800bf7:	75 dd                	jne    800bd6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c10:	eb 2a                	jmp    800c3c <memcmp+0x3e>
		if (*s1 != *s2)
  800c12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c15:	8a 10                	mov    (%eax),%dl
  800c17:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1a:	8a 00                	mov    (%eax),%al
  800c1c:	38 c2                	cmp    %al,%dl
  800c1e:	74 16                	je     800c36 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c23:	8a 00                	mov    (%eax),%al
  800c25:	0f b6 d0             	movzbl %al,%edx
  800c28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2b:	8a 00                	mov    (%eax),%al
  800c2d:	0f b6 c0             	movzbl %al,%eax
  800c30:	29 c2                	sub    %eax,%edx
  800c32:	89 d0                	mov    %edx,%eax
  800c34:	eb 18                	jmp    800c4e <memcmp+0x50>
		s1++, s2++;
  800c36:	ff 45 fc             	incl   -0x4(%ebp)
  800c39:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c42:	89 55 10             	mov    %edx,0x10(%ebp)
  800c45:	85 c0                	test   %eax,%eax
  800c47:	75 c9                	jne    800c12 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c49:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c4e:	c9                   	leave  
  800c4f:	c3                   	ret    

00800c50 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c50:	55                   	push   %ebp
  800c51:	89 e5                	mov    %esp,%ebp
  800c53:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c56:	8b 55 08             	mov    0x8(%ebp),%edx
  800c59:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5c:	01 d0                	add    %edx,%eax
  800c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c61:	eb 15                	jmp    800c78 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	0f b6 d0             	movzbl %al,%edx
  800c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6e:	0f b6 c0             	movzbl %al,%eax
  800c71:	39 c2                	cmp    %eax,%edx
  800c73:	74 0d                	je     800c82 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c75:	ff 45 08             	incl   0x8(%ebp)
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c7e:	72 e3                	jb     800c63 <memfind+0x13>
  800c80:	eb 01                	jmp    800c83 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c82:	90                   	nop
	return (void *) s;
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c86:	c9                   	leave  
  800c87:	c3                   	ret    

00800c88 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c88:	55                   	push   %ebp
  800c89:	89 e5                	mov    %esp,%ebp
  800c8b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c8e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c95:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c9c:	eb 03                	jmp    800ca1 <strtol+0x19>
		s++;
  800c9e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	3c 20                	cmp    $0x20,%al
  800ca8:	74 f4                	je     800c9e <strtol+0x16>
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	3c 09                	cmp    $0x9,%al
  800cb1:	74 eb                	je     800c9e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	8a 00                	mov    (%eax),%al
  800cb8:	3c 2b                	cmp    $0x2b,%al
  800cba:	75 05                	jne    800cc1 <strtol+0x39>
		s++;
  800cbc:	ff 45 08             	incl   0x8(%ebp)
  800cbf:	eb 13                	jmp    800cd4 <strtol+0x4c>
	else if (*s == '-')
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8a 00                	mov    (%eax),%al
  800cc6:	3c 2d                	cmp    $0x2d,%al
  800cc8:	75 0a                	jne    800cd4 <strtol+0x4c>
		s++, neg = 1;
  800cca:	ff 45 08             	incl   0x8(%ebp)
  800ccd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd8:	74 06                	je     800ce0 <strtol+0x58>
  800cda:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cde:	75 20                	jne    800d00 <strtol+0x78>
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	3c 30                	cmp    $0x30,%al
  800ce7:	75 17                	jne    800d00 <strtol+0x78>
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	40                   	inc    %eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	3c 78                	cmp    $0x78,%al
  800cf1:	75 0d                	jne    800d00 <strtol+0x78>
		s += 2, base = 16;
  800cf3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cf7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cfe:	eb 28                	jmp    800d28 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d00:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d04:	75 15                	jne    800d1b <strtol+0x93>
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	3c 30                	cmp    $0x30,%al
  800d0d:	75 0c                	jne    800d1b <strtol+0x93>
		s++, base = 8;
  800d0f:	ff 45 08             	incl   0x8(%ebp)
  800d12:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d19:	eb 0d                	jmp    800d28 <strtol+0xa0>
	else if (base == 0)
  800d1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1f:	75 07                	jne    800d28 <strtol+0xa0>
		base = 10;
  800d21:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	3c 2f                	cmp    $0x2f,%al
  800d2f:	7e 19                	jle    800d4a <strtol+0xc2>
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	3c 39                	cmp    $0x39,%al
  800d38:	7f 10                	jg     800d4a <strtol+0xc2>
			dig = *s - '0';
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	0f be c0             	movsbl %al,%eax
  800d42:	83 e8 30             	sub    $0x30,%eax
  800d45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d48:	eb 42                	jmp    800d8c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8a 00                	mov    (%eax),%al
  800d4f:	3c 60                	cmp    $0x60,%al
  800d51:	7e 19                	jle    800d6c <strtol+0xe4>
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	8a 00                	mov    (%eax),%al
  800d58:	3c 7a                	cmp    $0x7a,%al
  800d5a:	7f 10                	jg     800d6c <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	0f be c0             	movsbl %al,%eax
  800d64:	83 e8 57             	sub    $0x57,%eax
  800d67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d6a:	eb 20                	jmp    800d8c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	3c 40                	cmp    $0x40,%al
  800d73:	7e 39                	jle    800dae <strtol+0x126>
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	3c 5a                	cmp    $0x5a,%al
  800d7c:	7f 30                	jg     800dae <strtol+0x126>
			dig = *s - 'A' + 10;
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	0f be c0             	movsbl %al,%eax
  800d86:	83 e8 37             	sub    $0x37,%eax
  800d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d8f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d92:	7d 19                	jge    800dad <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d94:	ff 45 08             	incl   0x8(%ebp)
  800d97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9a:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d9e:	89 c2                	mov    %eax,%edx
  800da0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da3:	01 d0                	add    %edx,%eax
  800da5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800da8:	e9 7b ff ff ff       	jmp    800d28 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dad:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db2:	74 08                	je     800dbc <strtol+0x134>
		*endptr = (char *) s;
  800db4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db7:	8b 55 08             	mov    0x8(%ebp),%edx
  800dba:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dbc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dc0:	74 07                	je     800dc9 <strtol+0x141>
  800dc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc5:	f7 d8                	neg    %eax
  800dc7:	eb 03                	jmp    800dcc <strtol+0x144>
  800dc9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dcc:	c9                   	leave  
  800dcd:	c3                   	ret    

00800dce <ltostr>:

void
ltostr(long value, char *str)
{
  800dce:	55                   	push   %ebp
  800dcf:	89 e5                	mov    %esp,%ebp
  800dd1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dd4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ddb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800de2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800de6:	79 13                	jns    800dfb <ltostr+0x2d>
	{
		neg = 1;
  800de8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800def:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800df5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800df8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e03:	99                   	cltd   
  800e04:	f7 f9                	idiv   %ecx
  800e06:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0c:	8d 50 01             	lea    0x1(%eax),%edx
  800e0f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e12:	89 c2                	mov    %eax,%edx
  800e14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e17:	01 d0                	add    %edx,%eax
  800e19:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e1c:	83 c2 30             	add    $0x30,%edx
  800e1f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e21:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e24:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e29:	f7 e9                	imul   %ecx
  800e2b:	c1 fa 02             	sar    $0x2,%edx
  800e2e:	89 c8                	mov    %ecx,%eax
  800e30:	c1 f8 1f             	sar    $0x1f,%eax
  800e33:	29 c2                	sub    %eax,%edx
  800e35:	89 d0                	mov    %edx,%eax
  800e37:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e3d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e42:	f7 e9                	imul   %ecx
  800e44:	c1 fa 02             	sar    $0x2,%edx
  800e47:	89 c8                	mov    %ecx,%eax
  800e49:	c1 f8 1f             	sar    $0x1f,%eax
  800e4c:	29 c2                	sub    %eax,%edx
  800e4e:	89 d0                	mov    %edx,%eax
  800e50:	c1 e0 02             	shl    $0x2,%eax
  800e53:	01 d0                	add    %edx,%eax
  800e55:	01 c0                	add    %eax,%eax
  800e57:	29 c1                	sub    %eax,%ecx
  800e59:	89 ca                	mov    %ecx,%edx
  800e5b:	85 d2                	test   %edx,%edx
  800e5d:	75 9c                	jne    800dfb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e69:	48                   	dec    %eax
  800e6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e6d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e71:	74 3d                	je     800eb0 <ltostr+0xe2>
		start = 1 ;
  800e73:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e7a:	eb 34                	jmp    800eb0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e82:	01 d0                	add    %edx,%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8f:	01 c2                	add    %eax,%edx
  800e91:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e97:	01 c8                	add    %ecx,%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e9d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	01 c2                	add    %eax,%edx
  800ea5:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ea8:	88 02                	mov    %al,(%edx)
		start++ ;
  800eaa:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ead:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eb3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eb6:	7c c4                	jl     800e7c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eb8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	01 d0                	add    %edx,%eax
  800ec0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ec3:	90                   	nop
  800ec4:	c9                   	leave  
  800ec5:	c3                   	ret    

00800ec6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ec6:	55                   	push   %ebp
  800ec7:	89 e5                	mov    %esp,%ebp
  800ec9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ecc:	ff 75 08             	pushl  0x8(%ebp)
  800ecf:	e8 54 fa ff ff       	call   800928 <strlen>
  800ed4:	83 c4 04             	add    $0x4,%esp
  800ed7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eda:	ff 75 0c             	pushl  0xc(%ebp)
  800edd:	e8 46 fa ff ff       	call   800928 <strlen>
  800ee2:	83 c4 04             	add    $0x4,%esp
  800ee5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800eef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef6:	eb 17                	jmp    800f0f <strcconcat+0x49>
		final[s] = str1[s] ;
  800ef8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800efb:	8b 45 10             	mov    0x10(%ebp),%eax
  800efe:	01 c2                	add    %eax,%edx
  800f00:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f03:	8b 45 08             	mov    0x8(%ebp),%eax
  800f06:	01 c8                	add    %ecx,%eax
  800f08:	8a 00                	mov    (%eax),%al
  800f0a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f0c:	ff 45 fc             	incl   -0x4(%ebp)
  800f0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f12:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f15:	7c e1                	jl     800ef8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f1e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f25:	eb 1f                	jmp    800f46 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2a:	8d 50 01             	lea    0x1(%eax),%edx
  800f2d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f30:	89 c2                	mov    %eax,%edx
  800f32:	8b 45 10             	mov    0x10(%ebp),%eax
  800f35:	01 c2                	add    %eax,%edx
  800f37:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3d:	01 c8                	add    %ecx,%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f43:	ff 45 f8             	incl   -0x8(%ebp)
  800f46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f49:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f4c:	7c d9                	jl     800f27 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f51:	8b 45 10             	mov    0x10(%ebp),%eax
  800f54:	01 d0                	add    %edx,%eax
  800f56:	c6 00 00             	movb   $0x0,(%eax)
}
  800f59:	90                   	nop
  800f5a:	c9                   	leave  
  800f5b:	c3                   	ret    

00800f5c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f5c:	55                   	push   %ebp
  800f5d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f62:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f68:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6b:	8b 00                	mov    (%eax),%eax
  800f6d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f74:	8b 45 10             	mov    0x10(%ebp),%eax
  800f77:	01 d0                	add    %edx,%eax
  800f79:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f7f:	eb 0c                	jmp    800f8d <strsplit+0x31>
			*string++ = 0;
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8d 50 01             	lea    0x1(%eax),%edx
  800f87:	89 55 08             	mov    %edx,0x8(%ebp)
  800f8a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	84 c0                	test   %al,%al
  800f94:	74 18                	je     800fae <strsplit+0x52>
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	0f be c0             	movsbl %al,%eax
  800f9e:	50                   	push   %eax
  800f9f:	ff 75 0c             	pushl  0xc(%ebp)
  800fa2:	e8 13 fb ff ff       	call   800aba <strchr>
  800fa7:	83 c4 08             	add    $0x8,%esp
  800faa:	85 c0                	test   %eax,%eax
  800fac:	75 d3                	jne    800f81 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	84 c0                	test   %al,%al
  800fb5:	74 5a                	je     801011 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  800fb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800fba:	8b 00                	mov    (%eax),%eax
  800fbc:	83 f8 0f             	cmp    $0xf,%eax
  800fbf:	75 07                	jne    800fc8 <strsplit+0x6c>
		{
			return 0;
  800fc1:	b8 00 00 00 00       	mov    $0x0,%eax
  800fc6:	eb 66                	jmp    80102e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcb:	8b 00                	mov    (%eax),%eax
  800fcd:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd0:	8b 55 14             	mov    0x14(%ebp),%edx
  800fd3:	89 0a                	mov    %ecx,(%edx)
  800fd5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdf:	01 c2                	add    %eax,%edx
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fe6:	eb 03                	jmp    800feb <strsplit+0x8f>
			string++;
  800fe8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	84 c0                	test   %al,%al
  800ff2:	74 8b                	je     800f7f <strsplit+0x23>
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	8a 00                	mov    (%eax),%al
  800ff9:	0f be c0             	movsbl %al,%eax
  800ffc:	50                   	push   %eax
  800ffd:	ff 75 0c             	pushl  0xc(%ebp)
  801000:	e8 b5 fa ff ff       	call   800aba <strchr>
  801005:	83 c4 08             	add    $0x8,%esp
  801008:	85 c0                	test   %eax,%eax
  80100a:	74 dc                	je     800fe8 <strsplit+0x8c>
			string++;
	}
  80100c:	e9 6e ff ff ff       	jmp    800f7f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801011:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801012:	8b 45 14             	mov    0x14(%ebp),%eax
  801015:	8b 00                	mov    (%eax),%eax
  801017:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80101e:	8b 45 10             	mov    0x10(%ebp),%eax
  801021:	01 d0                	add    %edx,%eax
  801023:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801029:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80102e:	c9                   	leave  
  80102f:	c3                   	ret    

00801030 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
  801033:	57                   	push   %edi
  801034:	56                   	push   %esi
  801035:	53                   	push   %ebx
  801036:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80103f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801042:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801045:	8b 7d 18             	mov    0x18(%ebp),%edi
  801048:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80104b:	cd 30                	int    $0x30
  80104d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801050:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801053:	83 c4 10             	add    $0x10,%esp
  801056:	5b                   	pop    %ebx
  801057:	5e                   	pop    %esi
  801058:	5f                   	pop    %edi
  801059:	5d                   	pop    %ebp
  80105a:	c3                   	ret    

0080105b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
  80105e:	83 ec 04             	sub    $0x4,%esp
  801061:	8b 45 10             	mov    0x10(%ebp),%eax
  801064:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801067:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	6a 00                	push   $0x0
  801070:	6a 00                	push   $0x0
  801072:	52                   	push   %edx
  801073:	ff 75 0c             	pushl  0xc(%ebp)
  801076:	50                   	push   %eax
  801077:	6a 00                	push   $0x0
  801079:	e8 b2 ff ff ff       	call   801030 <syscall>
  80107e:	83 c4 18             	add    $0x18,%esp
}
  801081:	90                   	nop
  801082:	c9                   	leave  
  801083:	c3                   	ret    

00801084 <sys_cgetc>:

int
sys_cgetc(void)
{
  801084:	55                   	push   %ebp
  801085:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 01                	push   $0x1
  801093:	e8 98 ff ff ff       	call   801030 <syscall>
  801098:	83 c4 18             	add    $0x18,%esp
}
  80109b:	c9                   	leave  
  80109c:	c3                   	ret    

0080109d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80109d:	55                   	push   %ebp
  80109e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	50                   	push   %eax
  8010ac:	6a 05                	push   $0x5
  8010ae:	e8 7d ff ff ff       	call   801030 <syscall>
  8010b3:	83 c4 18             	add    $0x18,%esp
}
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 02                	push   $0x2
  8010c7:	e8 64 ff ff ff       	call   801030 <syscall>
  8010cc:	83 c4 18             	add    $0x18,%esp
}
  8010cf:	c9                   	leave  
  8010d0:	c3                   	ret    

008010d1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010d1:	55                   	push   %ebp
  8010d2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010d4:	6a 00                	push   $0x0
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	6a 03                	push   $0x3
  8010e0:	e8 4b ff ff ff       	call   801030 <syscall>
  8010e5:	83 c4 18             	add    $0x18,%esp
}
  8010e8:	c9                   	leave  
  8010e9:	c3                   	ret    

008010ea <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010ea:	55                   	push   %ebp
  8010eb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010ed:	6a 00                	push   $0x0
  8010ef:	6a 00                	push   $0x0
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 04                	push   $0x4
  8010f9:	e8 32 ff ff ff       	call   801030 <syscall>
  8010fe:	83 c4 18             	add    $0x18,%esp
}
  801101:	c9                   	leave  
  801102:	c3                   	ret    

00801103 <sys_env_exit>:


void sys_env_exit(void)
{
  801103:	55                   	push   %ebp
  801104:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801106:	6a 00                	push   $0x0
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	6a 06                	push   $0x6
  801112:	e8 19 ff ff ff       	call   801030 <syscall>
  801117:	83 c4 18             	add    $0x18,%esp
}
  80111a:	90                   	nop
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801120:	8b 55 0c             	mov    0xc(%ebp),%edx
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	6a 00                	push   $0x0
  801128:	6a 00                	push   $0x0
  80112a:	6a 00                	push   $0x0
  80112c:	52                   	push   %edx
  80112d:	50                   	push   %eax
  80112e:	6a 07                	push   $0x7
  801130:	e8 fb fe ff ff       	call   801030 <syscall>
  801135:	83 c4 18             	add    $0x18,%esp
}
  801138:	c9                   	leave  
  801139:	c3                   	ret    

0080113a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	56                   	push   %esi
  80113e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80113f:	8b 75 18             	mov    0x18(%ebp),%esi
  801142:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801145:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801148:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	56                   	push   %esi
  80114f:	53                   	push   %ebx
  801150:	51                   	push   %ecx
  801151:	52                   	push   %edx
  801152:	50                   	push   %eax
  801153:	6a 08                	push   $0x8
  801155:	e8 d6 fe ff ff       	call   801030 <syscall>
  80115a:	83 c4 18             	add    $0x18,%esp
}
  80115d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801160:	5b                   	pop    %ebx
  801161:	5e                   	pop    %esi
  801162:	5d                   	pop    %ebp
  801163:	c3                   	ret    

00801164 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801164:	55                   	push   %ebp
  801165:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801167:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	52                   	push   %edx
  801174:	50                   	push   %eax
  801175:	6a 09                	push   $0x9
  801177:	e8 b4 fe ff ff       	call   801030 <syscall>
  80117c:	83 c4 18             	add    $0x18,%esp
}
  80117f:	c9                   	leave  
  801180:	c3                   	ret    

00801181 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801181:	55                   	push   %ebp
  801182:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	6a 00                	push   $0x0
  80118a:	ff 75 0c             	pushl  0xc(%ebp)
  80118d:	ff 75 08             	pushl  0x8(%ebp)
  801190:	6a 0a                	push   $0xa
  801192:	e8 99 fe ff ff       	call   801030 <syscall>
  801197:	83 c4 18             	add    $0x18,%esp
}
  80119a:	c9                   	leave  
  80119b:	c3                   	ret    

0080119c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80119c:	55                   	push   %ebp
  80119d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 0b                	push   $0xb
  8011ab:	e8 80 fe ff ff       	call   801030 <syscall>
  8011b0:	83 c4 18             	add    $0x18,%esp
}
  8011b3:	c9                   	leave  
  8011b4:	c3                   	ret    

008011b5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011b5:	55                   	push   %ebp
  8011b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011b8:	6a 00                	push   $0x0
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 0c                	push   $0xc
  8011c4:	e8 67 fe ff ff       	call   801030 <syscall>
  8011c9:	83 c4 18             	add    $0x18,%esp
}
  8011cc:	c9                   	leave  
  8011cd:	c3                   	ret    

008011ce <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011ce:	55                   	push   %ebp
  8011cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011d1:	6a 00                	push   $0x0
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 0d                	push   $0xd
  8011dd:	e8 4e fe ff ff       	call   801030 <syscall>
  8011e2:	83 c4 18             	add    $0x18,%esp
}
  8011e5:	c9                   	leave  
  8011e6:	c3                   	ret    

008011e7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011ea:	6a 00                	push   $0x0
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	ff 75 0c             	pushl  0xc(%ebp)
  8011f3:	ff 75 08             	pushl  0x8(%ebp)
  8011f6:	6a 11                	push   $0x11
  8011f8:	e8 33 fe ff ff       	call   801030 <syscall>
  8011fd:	83 c4 18             	add    $0x18,%esp
	return;
  801200:	90                   	nop
}
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	ff 75 0c             	pushl  0xc(%ebp)
  80120f:	ff 75 08             	pushl  0x8(%ebp)
  801212:	6a 12                	push   $0x12
  801214:	e8 17 fe ff ff       	call   801030 <syscall>
  801219:	83 c4 18             	add    $0x18,%esp
	return ;
  80121c:	90                   	nop
}
  80121d:	c9                   	leave  
  80121e:	c3                   	ret    

0080121f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80121f:	55                   	push   %ebp
  801220:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 0e                	push   $0xe
  80122e:	e8 fd fd ff ff       	call   801030 <syscall>
  801233:	83 c4 18             	add    $0x18,%esp
}
  801236:	c9                   	leave  
  801237:	c3                   	ret    

00801238 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801238:	55                   	push   %ebp
  801239:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	ff 75 08             	pushl  0x8(%ebp)
  801246:	6a 0f                	push   $0xf
  801248:	e8 e3 fd ff ff       	call   801030 <syscall>
  80124d:	83 c4 18             	add    $0x18,%esp
}
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 10                	push   $0x10
  801261:	e8 ca fd ff ff       	call   801030 <syscall>
  801266:	83 c4 18             	add    $0x18,%esp
}
  801269:	90                   	nop
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 14                	push   $0x14
  80127b:	e8 b0 fd ff ff       	call   801030 <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	90                   	nop
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 15                	push   $0x15
  801295:	e8 96 fd ff ff       	call   801030 <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	90                   	nop
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 04             	sub    $0x4,%esp
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012ac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	50                   	push   %eax
  8012b9:	6a 16                	push   $0x16
  8012bb:	e8 70 fd ff ff       	call   801030 <syscall>
  8012c0:	83 c4 18             	add    $0x18,%esp
}
  8012c3:	90                   	nop
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 17                	push   $0x17
  8012d5:	e8 56 fd ff ff       	call   801030 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	ff 75 0c             	pushl  0xc(%ebp)
  8012ef:	50                   	push   %eax
  8012f0:	6a 18                	push   $0x18
  8012f2:	e8 39 fd ff ff       	call   801030 <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	52                   	push   %edx
  80130c:	50                   	push   %eax
  80130d:	6a 1b                	push   $0x1b
  80130f:	e8 1c fd ff ff       	call   801030 <syscall>
  801314:	83 c4 18             	add    $0x18,%esp
}
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80131c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	52                   	push   %edx
  801329:	50                   	push   %eax
  80132a:	6a 19                	push   $0x19
  80132c:	e8 ff fc ff ff       	call   801030 <syscall>
  801331:	83 c4 18             	add    $0x18,%esp
}
  801334:	90                   	nop
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80133a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	52                   	push   %edx
  801347:	50                   	push   %eax
  801348:	6a 1a                	push   $0x1a
  80134a:	e8 e1 fc ff ff       	call   801030 <syscall>
  80134f:	83 c4 18             	add    $0x18,%esp
}
  801352:	90                   	nop
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
  801358:	83 ec 04             	sub    $0x4,%esp
  80135b:	8b 45 10             	mov    0x10(%ebp),%eax
  80135e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801361:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801364:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	6a 00                	push   $0x0
  80136d:	51                   	push   %ecx
  80136e:	52                   	push   %edx
  80136f:	ff 75 0c             	pushl  0xc(%ebp)
  801372:	50                   	push   %eax
  801373:	6a 1c                	push   $0x1c
  801375:	e8 b6 fc ff ff       	call   801030 <syscall>
  80137a:	83 c4 18             	add    $0x18,%esp
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	52                   	push   %edx
  80138f:	50                   	push   %eax
  801390:	6a 1d                	push   $0x1d
  801392:	e8 99 fc ff ff       	call   801030 <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80139f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	51                   	push   %ecx
  8013ad:	52                   	push   %edx
  8013ae:	50                   	push   %eax
  8013af:	6a 1e                	push   $0x1e
  8013b1:	e8 7a fc ff ff       	call   801030 <syscall>
  8013b6:	83 c4 18             	add    $0x18,%esp
}
  8013b9:	c9                   	leave  
  8013ba:	c3                   	ret    

008013bb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	52                   	push   %edx
  8013cb:	50                   	push   %eax
  8013cc:	6a 1f                	push   $0x1f
  8013ce:	e8 5d fc ff ff       	call   801030 <syscall>
  8013d3:	83 c4 18             	add    $0x18,%esp
}
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 20                	push   $0x20
  8013e7:	e8 44 fc ff ff       	call   801030 <syscall>
  8013ec:	83 c4 18             	add    $0x18,%esp
}
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	ff 75 10             	pushl  0x10(%ebp)
  8013fe:	ff 75 0c             	pushl  0xc(%ebp)
  801401:	50                   	push   %eax
  801402:	6a 21                	push   $0x21
  801404:	e8 27 fc ff ff       	call   801030 <syscall>
  801409:	83 c4 18             	add    $0x18,%esp
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 00                	push   $0x0
  80141c:	50                   	push   %eax
  80141d:	6a 22                	push   $0x22
  80141f:	e8 0c fc ff ff       	call   801030 <syscall>
  801424:	83 c4 18             	add    $0x18,%esp
}
  801427:	90                   	nop
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	50                   	push   %eax
  801439:	6a 23                	push   $0x23
  80143b:	e8 f0 fb ff ff       	call   801030 <syscall>
  801440:	83 c4 18             	add    $0x18,%esp
}
  801443:	90                   	nop
  801444:	c9                   	leave  
  801445:	c3                   	ret    

00801446 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801446:	55                   	push   %ebp
  801447:	89 e5                	mov    %esp,%ebp
  801449:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80144c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80144f:	8d 50 04             	lea    0x4(%eax),%edx
  801452:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	52                   	push   %edx
  80145c:	50                   	push   %eax
  80145d:	6a 24                	push   $0x24
  80145f:	e8 cc fb ff ff       	call   801030 <syscall>
  801464:	83 c4 18             	add    $0x18,%esp
	return result;
  801467:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80146a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801470:	89 01                	mov    %eax,(%ecx)
  801472:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	c9                   	leave  
  801479:	c2 04 00             	ret    $0x4

0080147c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80147c:	55                   	push   %ebp
  80147d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	ff 75 10             	pushl  0x10(%ebp)
  801486:	ff 75 0c             	pushl  0xc(%ebp)
  801489:	ff 75 08             	pushl  0x8(%ebp)
  80148c:	6a 13                	push   $0x13
  80148e:	e8 9d fb ff ff       	call   801030 <syscall>
  801493:	83 c4 18             	add    $0x18,%esp
	return ;
  801496:	90                   	nop
}
  801497:	c9                   	leave  
  801498:	c3                   	ret    

00801499 <sys_rcr2>:
uint32 sys_rcr2()
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 25                	push   $0x25
  8014a8:	e8 83 fb ff ff       	call   801030 <syscall>
  8014ad:	83 c4 18             	add    $0x18,%esp
}
  8014b0:	c9                   	leave  
  8014b1:	c3                   	ret    

008014b2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
  8014b5:	83 ec 04             	sub    $0x4,%esp
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014be:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	50                   	push   %eax
  8014cb:	6a 26                	push   $0x26
  8014cd:	e8 5e fb ff ff       	call   801030 <syscall>
  8014d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d5:	90                   	nop
}
  8014d6:	c9                   	leave  
  8014d7:	c3                   	ret    

008014d8 <rsttst>:
void rsttst()
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 28                	push   $0x28
  8014e7:	e8 44 fb ff ff       	call   801030 <syscall>
  8014ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ef:	90                   	nop
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014fe:	8b 55 18             	mov    0x18(%ebp),%edx
  801501:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801505:	52                   	push   %edx
  801506:	50                   	push   %eax
  801507:	ff 75 10             	pushl  0x10(%ebp)
  80150a:	ff 75 0c             	pushl  0xc(%ebp)
  80150d:	ff 75 08             	pushl  0x8(%ebp)
  801510:	6a 27                	push   $0x27
  801512:	e8 19 fb ff ff       	call   801030 <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
	return ;
  80151a:	90                   	nop
}
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <chktst>:
void chktst(uint32 n)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	ff 75 08             	pushl  0x8(%ebp)
  80152b:	6a 29                	push   $0x29
  80152d:	e8 fe fa ff ff       	call   801030 <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
	return ;
  801535:	90                   	nop
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <inctst>:

void inctst()
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 2a                	push   $0x2a
  801547:	e8 e4 fa ff ff       	call   801030 <syscall>
  80154c:	83 c4 18             	add    $0x18,%esp
	return ;
  80154f:	90                   	nop
}
  801550:	c9                   	leave  
  801551:	c3                   	ret    

00801552 <gettst>:
uint32 gettst()
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 2b                	push   $0x2b
  801561:	e8 ca fa ff ff       	call   801030 <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
}
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
  80156e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 2c                	push   $0x2c
  80157d:	e8 ae fa ff ff       	call   801030 <syscall>
  801582:	83 c4 18             	add    $0x18,%esp
  801585:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801588:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80158c:	75 07                	jne    801595 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80158e:	b8 01 00 00 00       	mov    $0x1,%eax
  801593:	eb 05                	jmp    80159a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801595:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
  80159f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 2c                	push   $0x2c
  8015ae:	e8 7d fa ff ff       	call   801030 <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
  8015b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015b9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015bd:	75 07                	jne    8015c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015bf:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c4:	eb 05                	jmp    8015cb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 2c                	push   $0x2c
  8015df:	e8 4c fa ff ff       	call   801030 <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
  8015e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015ea:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015ee:	75 07                	jne    8015f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f5:	eb 05                	jmp    8015fc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
  801601:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 2c                	push   $0x2c
  801610:	e8 1b fa ff ff       	call   801030 <syscall>
  801615:	83 c4 18             	add    $0x18,%esp
  801618:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80161b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80161f:	75 07                	jne    801628 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801621:	b8 01 00 00 00       	mov    $0x1,%eax
  801626:	eb 05                	jmp    80162d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801628:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80162d:	c9                   	leave  
  80162e:	c3                   	ret    

0080162f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	ff 75 08             	pushl  0x8(%ebp)
  80163d:	6a 2d                	push   $0x2d
  80163f:	e8 ec f9 ff ff       	call   801030 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
	return ;
  801647:	90                   	nop
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    
  80164a:	66 90                	xchg   %ax,%ax

0080164c <__udivdi3>:
  80164c:	55                   	push   %ebp
  80164d:	57                   	push   %edi
  80164e:	56                   	push   %esi
  80164f:	53                   	push   %ebx
  801650:	83 ec 1c             	sub    $0x1c,%esp
  801653:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801657:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80165b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80165f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801663:	89 ca                	mov    %ecx,%edx
  801665:	89 f8                	mov    %edi,%eax
  801667:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80166b:	85 f6                	test   %esi,%esi
  80166d:	75 2d                	jne    80169c <__udivdi3+0x50>
  80166f:	39 cf                	cmp    %ecx,%edi
  801671:	77 65                	ja     8016d8 <__udivdi3+0x8c>
  801673:	89 fd                	mov    %edi,%ebp
  801675:	85 ff                	test   %edi,%edi
  801677:	75 0b                	jne    801684 <__udivdi3+0x38>
  801679:	b8 01 00 00 00       	mov    $0x1,%eax
  80167e:	31 d2                	xor    %edx,%edx
  801680:	f7 f7                	div    %edi
  801682:	89 c5                	mov    %eax,%ebp
  801684:	31 d2                	xor    %edx,%edx
  801686:	89 c8                	mov    %ecx,%eax
  801688:	f7 f5                	div    %ebp
  80168a:	89 c1                	mov    %eax,%ecx
  80168c:	89 d8                	mov    %ebx,%eax
  80168e:	f7 f5                	div    %ebp
  801690:	89 cf                	mov    %ecx,%edi
  801692:	89 fa                	mov    %edi,%edx
  801694:	83 c4 1c             	add    $0x1c,%esp
  801697:	5b                   	pop    %ebx
  801698:	5e                   	pop    %esi
  801699:	5f                   	pop    %edi
  80169a:	5d                   	pop    %ebp
  80169b:	c3                   	ret    
  80169c:	39 ce                	cmp    %ecx,%esi
  80169e:	77 28                	ja     8016c8 <__udivdi3+0x7c>
  8016a0:	0f bd fe             	bsr    %esi,%edi
  8016a3:	83 f7 1f             	xor    $0x1f,%edi
  8016a6:	75 40                	jne    8016e8 <__udivdi3+0x9c>
  8016a8:	39 ce                	cmp    %ecx,%esi
  8016aa:	72 0a                	jb     8016b6 <__udivdi3+0x6a>
  8016ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016b0:	0f 87 9e 00 00 00    	ja     801754 <__udivdi3+0x108>
  8016b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8016bb:	89 fa                	mov    %edi,%edx
  8016bd:	83 c4 1c             	add    $0x1c,%esp
  8016c0:	5b                   	pop    %ebx
  8016c1:	5e                   	pop    %esi
  8016c2:	5f                   	pop    %edi
  8016c3:	5d                   	pop    %ebp
  8016c4:	c3                   	ret    
  8016c5:	8d 76 00             	lea    0x0(%esi),%esi
  8016c8:	31 ff                	xor    %edi,%edi
  8016ca:	31 c0                	xor    %eax,%eax
  8016cc:	89 fa                	mov    %edi,%edx
  8016ce:	83 c4 1c             	add    $0x1c,%esp
  8016d1:	5b                   	pop    %ebx
  8016d2:	5e                   	pop    %esi
  8016d3:	5f                   	pop    %edi
  8016d4:	5d                   	pop    %ebp
  8016d5:	c3                   	ret    
  8016d6:	66 90                	xchg   %ax,%ax
  8016d8:	89 d8                	mov    %ebx,%eax
  8016da:	f7 f7                	div    %edi
  8016dc:	31 ff                	xor    %edi,%edi
  8016de:	89 fa                	mov    %edi,%edx
  8016e0:	83 c4 1c             	add    $0x1c,%esp
  8016e3:	5b                   	pop    %ebx
  8016e4:	5e                   	pop    %esi
  8016e5:	5f                   	pop    %edi
  8016e6:	5d                   	pop    %ebp
  8016e7:	c3                   	ret    
  8016e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016ed:	89 eb                	mov    %ebp,%ebx
  8016ef:	29 fb                	sub    %edi,%ebx
  8016f1:	89 f9                	mov    %edi,%ecx
  8016f3:	d3 e6                	shl    %cl,%esi
  8016f5:	89 c5                	mov    %eax,%ebp
  8016f7:	88 d9                	mov    %bl,%cl
  8016f9:	d3 ed                	shr    %cl,%ebp
  8016fb:	89 e9                	mov    %ebp,%ecx
  8016fd:	09 f1                	or     %esi,%ecx
  8016ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801703:	89 f9                	mov    %edi,%ecx
  801705:	d3 e0                	shl    %cl,%eax
  801707:	89 c5                	mov    %eax,%ebp
  801709:	89 d6                	mov    %edx,%esi
  80170b:	88 d9                	mov    %bl,%cl
  80170d:	d3 ee                	shr    %cl,%esi
  80170f:	89 f9                	mov    %edi,%ecx
  801711:	d3 e2                	shl    %cl,%edx
  801713:	8b 44 24 08          	mov    0x8(%esp),%eax
  801717:	88 d9                	mov    %bl,%cl
  801719:	d3 e8                	shr    %cl,%eax
  80171b:	09 c2                	or     %eax,%edx
  80171d:	89 d0                	mov    %edx,%eax
  80171f:	89 f2                	mov    %esi,%edx
  801721:	f7 74 24 0c          	divl   0xc(%esp)
  801725:	89 d6                	mov    %edx,%esi
  801727:	89 c3                	mov    %eax,%ebx
  801729:	f7 e5                	mul    %ebp
  80172b:	39 d6                	cmp    %edx,%esi
  80172d:	72 19                	jb     801748 <__udivdi3+0xfc>
  80172f:	74 0b                	je     80173c <__udivdi3+0xf0>
  801731:	89 d8                	mov    %ebx,%eax
  801733:	31 ff                	xor    %edi,%edi
  801735:	e9 58 ff ff ff       	jmp    801692 <__udivdi3+0x46>
  80173a:	66 90                	xchg   %ax,%ax
  80173c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801740:	89 f9                	mov    %edi,%ecx
  801742:	d3 e2                	shl    %cl,%edx
  801744:	39 c2                	cmp    %eax,%edx
  801746:	73 e9                	jae    801731 <__udivdi3+0xe5>
  801748:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80174b:	31 ff                	xor    %edi,%edi
  80174d:	e9 40 ff ff ff       	jmp    801692 <__udivdi3+0x46>
  801752:	66 90                	xchg   %ax,%ax
  801754:	31 c0                	xor    %eax,%eax
  801756:	e9 37 ff ff ff       	jmp    801692 <__udivdi3+0x46>
  80175b:	90                   	nop

0080175c <__umoddi3>:
  80175c:	55                   	push   %ebp
  80175d:	57                   	push   %edi
  80175e:	56                   	push   %esi
  80175f:	53                   	push   %ebx
  801760:	83 ec 1c             	sub    $0x1c,%esp
  801763:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801767:	8b 74 24 34          	mov    0x34(%esp),%esi
  80176b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80176f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801773:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801777:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80177b:	89 f3                	mov    %esi,%ebx
  80177d:	89 fa                	mov    %edi,%edx
  80177f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801783:	89 34 24             	mov    %esi,(%esp)
  801786:	85 c0                	test   %eax,%eax
  801788:	75 1a                	jne    8017a4 <__umoddi3+0x48>
  80178a:	39 f7                	cmp    %esi,%edi
  80178c:	0f 86 a2 00 00 00    	jbe    801834 <__umoddi3+0xd8>
  801792:	89 c8                	mov    %ecx,%eax
  801794:	89 f2                	mov    %esi,%edx
  801796:	f7 f7                	div    %edi
  801798:	89 d0                	mov    %edx,%eax
  80179a:	31 d2                	xor    %edx,%edx
  80179c:	83 c4 1c             	add    $0x1c,%esp
  80179f:	5b                   	pop    %ebx
  8017a0:	5e                   	pop    %esi
  8017a1:	5f                   	pop    %edi
  8017a2:	5d                   	pop    %ebp
  8017a3:	c3                   	ret    
  8017a4:	39 f0                	cmp    %esi,%eax
  8017a6:	0f 87 ac 00 00 00    	ja     801858 <__umoddi3+0xfc>
  8017ac:	0f bd e8             	bsr    %eax,%ebp
  8017af:	83 f5 1f             	xor    $0x1f,%ebp
  8017b2:	0f 84 ac 00 00 00    	je     801864 <__umoddi3+0x108>
  8017b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8017bd:	29 ef                	sub    %ebp,%edi
  8017bf:	89 fe                	mov    %edi,%esi
  8017c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017c5:	89 e9                	mov    %ebp,%ecx
  8017c7:	d3 e0                	shl    %cl,%eax
  8017c9:	89 d7                	mov    %edx,%edi
  8017cb:	89 f1                	mov    %esi,%ecx
  8017cd:	d3 ef                	shr    %cl,%edi
  8017cf:	09 c7                	or     %eax,%edi
  8017d1:	89 e9                	mov    %ebp,%ecx
  8017d3:	d3 e2                	shl    %cl,%edx
  8017d5:	89 14 24             	mov    %edx,(%esp)
  8017d8:	89 d8                	mov    %ebx,%eax
  8017da:	d3 e0                	shl    %cl,%eax
  8017dc:	89 c2                	mov    %eax,%edx
  8017de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e2:	d3 e0                	shl    %cl,%eax
  8017e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017ec:	89 f1                	mov    %esi,%ecx
  8017ee:	d3 e8                	shr    %cl,%eax
  8017f0:	09 d0                	or     %edx,%eax
  8017f2:	d3 eb                	shr    %cl,%ebx
  8017f4:	89 da                	mov    %ebx,%edx
  8017f6:	f7 f7                	div    %edi
  8017f8:	89 d3                	mov    %edx,%ebx
  8017fa:	f7 24 24             	mull   (%esp)
  8017fd:	89 c6                	mov    %eax,%esi
  8017ff:	89 d1                	mov    %edx,%ecx
  801801:	39 d3                	cmp    %edx,%ebx
  801803:	0f 82 87 00 00 00    	jb     801890 <__umoddi3+0x134>
  801809:	0f 84 91 00 00 00    	je     8018a0 <__umoddi3+0x144>
  80180f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801813:	29 f2                	sub    %esi,%edx
  801815:	19 cb                	sbb    %ecx,%ebx
  801817:	89 d8                	mov    %ebx,%eax
  801819:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80181d:	d3 e0                	shl    %cl,%eax
  80181f:	89 e9                	mov    %ebp,%ecx
  801821:	d3 ea                	shr    %cl,%edx
  801823:	09 d0                	or     %edx,%eax
  801825:	89 e9                	mov    %ebp,%ecx
  801827:	d3 eb                	shr    %cl,%ebx
  801829:	89 da                	mov    %ebx,%edx
  80182b:	83 c4 1c             	add    $0x1c,%esp
  80182e:	5b                   	pop    %ebx
  80182f:	5e                   	pop    %esi
  801830:	5f                   	pop    %edi
  801831:	5d                   	pop    %ebp
  801832:	c3                   	ret    
  801833:	90                   	nop
  801834:	89 fd                	mov    %edi,%ebp
  801836:	85 ff                	test   %edi,%edi
  801838:	75 0b                	jne    801845 <__umoddi3+0xe9>
  80183a:	b8 01 00 00 00       	mov    $0x1,%eax
  80183f:	31 d2                	xor    %edx,%edx
  801841:	f7 f7                	div    %edi
  801843:	89 c5                	mov    %eax,%ebp
  801845:	89 f0                	mov    %esi,%eax
  801847:	31 d2                	xor    %edx,%edx
  801849:	f7 f5                	div    %ebp
  80184b:	89 c8                	mov    %ecx,%eax
  80184d:	f7 f5                	div    %ebp
  80184f:	89 d0                	mov    %edx,%eax
  801851:	e9 44 ff ff ff       	jmp    80179a <__umoddi3+0x3e>
  801856:	66 90                	xchg   %ax,%ax
  801858:	89 c8                	mov    %ecx,%eax
  80185a:	89 f2                	mov    %esi,%edx
  80185c:	83 c4 1c             	add    $0x1c,%esp
  80185f:	5b                   	pop    %ebx
  801860:	5e                   	pop    %esi
  801861:	5f                   	pop    %edi
  801862:	5d                   	pop    %ebp
  801863:	c3                   	ret    
  801864:	3b 04 24             	cmp    (%esp),%eax
  801867:	72 06                	jb     80186f <__umoddi3+0x113>
  801869:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80186d:	77 0f                	ja     80187e <__umoddi3+0x122>
  80186f:	89 f2                	mov    %esi,%edx
  801871:	29 f9                	sub    %edi,%ecx
  801873:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801877:	89 14 24             	mov    %edx,(%esp)
  80187a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80187e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801882:	8b 14 24             	mov    (%esp),%edx
  801885:	83 c4 1c             	add    $0x1c,%esp
  801888:	5b                   	pop    %ebx
  801889:	5e                   	pop    %esi
  80188a:	5f                   	pop    %edi
  80188b:	5d                   	pop    %ebp
  80188c:	c3                   	ret    
  80188d:	8d 76 00             	lea    0x0(%esi),%esi
  801890:	2b 04 24             	sub    (%esp),%eax
  801893:	19 fa                	sbb    %edi,%edx
  801895:	89 d1                	mov    %edx,%ecx
  801897:	89 c6                	mov    %eax,%esi
  801899:	e9 71 ff ff ff       	jmp    80180f <__umoddi3+0xb3>
  80189e:	66 90                	xchg   %ax,%ax
  8018a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018a4:	72 ea                	jb     801890 <__umoddi3+0x134>
  8018a6:	89 d9                	mov    %ebx,%ecx
  8018a8:	e9 62 ff ff ff       	jmp    80180f <__umoddi3+0xb3>
