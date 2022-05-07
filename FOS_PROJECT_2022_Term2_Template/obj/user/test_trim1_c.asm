
obj/user/test_trim1_c:     file format elf32-i386


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
  800031:	e8 e3 00 00 00       	call   800119 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 requiredMemFrames;
uint32 extraFramesNeeded ;
uint32 memFramesToAllocate;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	remainingfreeframes = sys_calculate_free_frames();
  80003e:	e8 b8 13 00 00       	call   8013fb <sys_calculate_free_frames>
  800043:	a3 2c 30 80 00       	mov    %eax,0x80302c
	memFramesToAllocate = (remainingfreeframes+0);
  800048:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80004d:	a3 3c 30 80 00       	mov    %eax,0x80303c

	requiredMemFrames = sys_calculate_required_frames(USER_HEAP_START, memFramesToAllocate*PAGE_SIZE);
  800052:	a1 3c 30 80 00       	mov    0x80303c,%eax
  800057:	c1 e0 0c             	shl    $0xc,%eax
  80005a:	83 ec 08             	sub    $0x8,%esp
  80005d:	50                   	push   %eax
  80005e:	68 00 00 00 80       	push   $0x80000000
  800063:	e8 78 13 00 00       	call   8013e0 <sys_calculate_required_frames>
  800068:	83 c4 10             	add    $0x10,%esp
  80006b:	a3 30 30 80 00       	mov    %eax,0x803030
	extraFramesNeeded = requiredMemFrames - remainingfreeframes;
  800070:	8b 15 30 30 80 00    	mov    0x803030,%edx
  800076:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80007b:	29 c2                	sub    %eax,%edx
  80007d:	89 d0                	mov    %edx,%eax
  80007f:	a3 38 30 80 00       	mov    %eax,0x803038
	
	//cprintf("remaining frames = %d\n",remainingfreeframes);
	//cprintf("frames desired to be allocated = %d\n",memFramesToAllocate);
	//cprintf("req frames = %d\n",requiredMemFrames);
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
  800084:	a1 3c 30 80 00       	mov    0x80303c,%eax
  800089:	c1 e0 0c             	shl    $0xc,%eax
  80008c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char* x = malloc(sizeof(char)*size);
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	ff 75 f0             	pushl  -0x10(%ebp)
  800095:	e8 ec 0f 00 00       	call   801086 <malloc>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	uint32 i=0;
  8000a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(i=0; i<size;i++ )
  8000a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ae:	eb 0e                	jmp    8000be <_main+0x86>
	{
		x[i]=-1;
  8000b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	01 d0                	add    %edx,%eax
  8000b8:	c6 00 ff             	movb   $0xff,(%eax)
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
	char* x = malloc(sizeof(char)*size);

	uint32 i=0;
	for(i=0; i<size;i++ )
  8000bb:	ff 45 f4             	incl   -0xc(%ebp)
  8000be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000c4:	72 ea                	jb     8000b0 <_main+0x78>
	{
		x[i]=-1;
	}

	uint32 all_frames_to_be_trimmed = ROUNDUP(extraFramesNeeded*2, 3);
  8000c6:	c7 45 e8 03 00 00 00 	movl   $0x3,-0x18(%ebp)
  8000cd:	a1 38 30 80 00       	mov    0x803038,%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	48                   	dec    %eax
  8000dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8000e7:	f7 75 e8             	divl   -0x18(%ebp)
  8000ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000ed:	29 d0                	sub    %edx,%eax
  8000ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 frames_to_trimmed_every_env = all_frames_to_be_trimmed/3;
  8000f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f5:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
  8000fa:	f7 e2                	mul    %edx
  8000fc:	89 d0                	mov    %edx,%eax
  8000fe:	d1 e8                	shr    %eax
  800100:	89 45 dc             	mov    %eax,-0x24(%ebp)

	cprintf("Frames to be trimmed from A or B = %d\n", frames_to_trimmed_every_env);
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	ff 75 dc             	pushl  -0x24(%ebp)
  800109:	68 00 1d 80 00       	push   $0x801d00
  80010e:	e8 e9 01 00 00       	call   8002fc <cprintf>
  800113:	83 c4 10             	add    $0x10,%esp

	return;	
  800116:	90                   	nop
}
  800117:	c9                   	leave  
  800118:	c3                   	ret    

00800119 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800119:	55                   	push   %ebp
  80011a:	89 e5                	mov    %esp,%ebp
  80011c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011f:	e8 0c 12 00 00       	call   801330 <sys_getenvindex>
  800124:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800127:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80012a:	89 d0                	mov    %edx,%eax
  80012c:	c1 e0 02             	shl    $0x2,%eax
  80012f:	01 d0                	add    %edx,%eax
  800131:	01 c0                	add    %eax,%eax
  800133:	01 d0                	add    %edx,%eax
  800135:	01 c0                	add    %eax,%eax
  800137:	01 d0                	add    %edx,%eax
  800139:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800140:	01 d0                	add    %edx,%eax
  800142:	c1 e0 02             	shl    $0x2,%eax
  800145:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80014a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80015a:	84 c0                	test   %al,%al
  80015c:	74 0f                	je     80016d <libmain+0x54>
		binaryname = myEnv->prog_name;
  80015e:	a1 20 30 80 00       	mov    0x803020,%eax
  800163:	05 f4 02 00 00       	add    $0x2f4,%eax
  800168:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80016d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800171:	7e 0a                	jle    80017d <libmain+0x64>
		binaryname = argv[0];
  800173:	8b 45 0c             	mov    0xc(%ebp),%eax
  800176:	8b 00                	mov    (%eax),%eax
  800178:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80017d:	83 ec 08             	sub    $0x8,%esp
  800180:	ff 75 0c             	pushl  0xc(%ebp)
  800183:	ff 75 08             	pushl  0x8(%ebp)
  800186:	e8 ad fe ff ff       	call   800038 <_main>
  80018b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80018e:	e8 38 13 00 00       	call   8014cb <sys_disable_interrupt>
	cprintf("**************************************\n");
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	68 40 1d 80 00       	push   $0x801d40
  80019b:	e8 5c 01 00 00       	call   8002fc <cprintf>
  8001a0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001b9:	83 ec 04             	sub    $0x4,%esp
  8001bc:	52                   	push   %edx
  8001bd:	50                   	push   %eax
  8001be:	68 68 1d 80 00       	push   $0x801d68
  8001c3:	e8 34 01 00 00       	call   8002fc <cprintf>
  8001c8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d0:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001d6:	83 ec 08             	sub    $0x8,%esp
  8001d9:	50                   	push   %eax
  8001da:	68 8d 1d 80 00       	push   $0x801d8d
  8001df:	e8 18 01 00 00       	call   8002fc <cprintf>
  8001e4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	68 40 1d 80 00       	push   $0x801d40
  8001ef:	e8 08 01 00 00       	call   8002fc <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001f7:	e8 e9 12 00 00       	call   8014e5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001fc:	e8 19 00 00 00       	call   80021a <exit>
}
  800201:	90                   	nop
  800202:	c9                   	leave  
  800203:	c3                   	ret    

00800204 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800204:	55                   	push   %ebp
  800205:	89 e5                	mov    %esp,%ebp
  800207:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	6a 00                	push   $0x0
  80020f:	e8 e8 10 00 00       	call   8012fc <sys_env_destroy>
  800214:	83 c4 10             	add    $0x10,%esp
}
  800217:	90                   	nop
  800218:	c9                   	leave  
  800219:	c3                   	ret    

0080021a <exit>:

void
exit(void)
{
  80021a:	55                   	push   %ebp
  80021b:	89 e5                	mov    %esp,%ebp
  80021d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800220:	e8 3d 11 00 00       	call   801362 <sys_env_exit>
}
  800225:	90                   	nop
  800226:	c9                   	leave  
  800227:	c3                   	ret    

00800228 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800228:	55                   	push   %ebp
  800229:	89 e5                	mov    %esp,%ebp
  80022b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80022e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800231:	8b 00                	mov    (%eax),%eax
  800233:	8d 48 01             	lea    0x1(%eax),%ecx
  800236:	8b 55 0c             	mov    0xc(%ebp),%edx
  800239:	89 0a                	mov    %ecx,(%edx)
  80023b:	8b 55 08             	mov    0x8(%ebp),%edx
  80023e:	88 d1                	mov    %dl,%cl
  800240:	8b 55 0c             	mov    0xc(%ebp),%edx
  800243:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024a:	8b 00                	mov    (%eax),%eax
  80024c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800251:	75 2c                	jne    80027f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800253:	a0 24 30 80 00       	mov    0x803024,%al
  800258:	0f b6 c0             	movzbl %al,%eax
  80025b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80025e:	8b 12                	mov    (%edx),%edx
  800260:	89 d1                	mov    %edx,%ecx
  800262:	8b 55 0c             	mov    0xc(%ebp),%edx
  800265:	83 c2 08             	add    $0x8,%edx
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	50                   	push   %eax
  80026c:	51                   	push   %ecx
  80026d:	52                   	push   %edx
  80026e:	e8 47 10 00 00       	call   8012ba <sys_cputs>
  800273:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800276:	8b 45 0c             	mov    0xc(%ebp),%eax
  800279:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80027f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800282:	8b 40 04             	mov    0x4(%eax),%eax
  800285:	8d 50 01             	lea    0x1(%eax),%edx
  800288:	8b 45 0c             	mov    0xc(%ebp),%eax
  80028b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80028e:	90                   	nop
  80028f:	c9                   	leave  
  800290:	c3                   	ret    

00800291 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800291:	55                   	push   %ebp
  800292:	89 e5                	mov    %esp,%ebp
  800294:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80029a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002a1:	00 00 00 
	b.cnt = 0;
  8002a4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002ab:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002ae:	ff 75 0c             	pushl  0xc(%ebp)
  8002b1:	ff 75 08             	pushl  0x8(%ebp)
  8002b4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ba:	50                   	push   %eax
  8002bb:	68 28 02 80 00       	push   $0x800228
  8002c0:	e8 11 02 00 00       	call   8004d6 <vprintfmt>
  8002c5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002c8:	a0 24 30 80 00       	mov    0x803024,%al
  8002cd:	0f b6 c0             	movzbl %al,%eax
  8002d0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	50                   	push   %eax
  8002da:	52                   	push   %edx
  8002db:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002e1:	83 c0 08             	add    $0x8,%eax
  8002e4:	50                   	push   %eax
  8002e5:	e8 d0 0f 00 00       	call   8012ba <sys_cputs>
  8002ea:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ed:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002f4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002fa:	c9                   	leave  
  8002fb:	c3                   	ret    

008002fc <cprintf>:

int cprintf(const char *fmt, ...) {
  8002fc:	55                   	push   %ebp
  8002fd:	89 e5                	mov    %esp,%ebp
  8002ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800302:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800309:	8d 45 0c             	lea    0xc(%ebp),%eax
  80030c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80030f:	8b 45 08             	mov    0x8(%ebp),%eax
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	ff 75 f4             	pushl  -0xc(%ebp)
  800318:	50                   	push   %eax
  800319:	e8 73 ff ff ff       	call   800291 <vcprintf>
  80031e:	83 c4 10             	add    $0x10,%esp
  800321:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800324:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80032f:	e8 97 11 00 00       	call   8014cb <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800334:	8d 45 0c             	lea    0xc(%ebp),%eax
  800337:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80033a:	8b 45 08             	mov    0x8(%ebp),%eax
  80033d:	83 ec 08             	sub    $0x8,%esp
  800340:	ff 75 f4             	pushl  -0xc(%ebp)
  800343:	50                   	push   %eax
  800344:	e8 48 ff ff ff       	call   800291 <vcprintf>
  800349:	83 c4 10             	add    $0x10,%esp
  80034c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80034f:	e8 91 11 00 00       	call   8014e5 <sys_enable_interrupt>
	return cnt;
  800354:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800357:	c9                   	leave  
  800358:	c3                   	ret    

00800359 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800359:	55                   	push   %ebp
  80035a:	89 e5                	mov    %esp,%ebp
  80035c:	53                   	push   %ebx
  80035d:	83 ec 14             	sub    $0x14,%esp
  800360:	8b 45 10             	mov    0x10(%ebp),%eax
  800363:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800366:	8b 45 14             	mov    0x14(%ebp),%eax
  800369:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80036c:	8b 45 18             	mov    0x18(%ebp),%eax
  80036f:	ba 00 00 00 00       	mov    $0x0,%edx
  800374:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800377:	77 55                	ja     8003ce <printnum+0x75>
  800379:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80037c:	72 05                	jb     800383 <printnum+0x2a>
  80037e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800381:	77 4b                	ja     8003ce <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800383:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800386:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800389:	8b 45 18             	mov    0x18(%ebp),%eax
  80038c:	ba 00 00 00 00       	mov    $0x0,%edx
  800391:	52                   	push   %edx
  800392:	50                   	push   %eax
  800393:	ff 75 f4             	pushl  -0xc(%ebp)
  800396:	ff 75 f0             	pushl  -0x10(%ebp)
  800399:	e8 ee 16 00 00       	call   801a8c <__udivdi3>
  80039e:	83 c4 10             	add    $0x10,%esp
  8003a1:	83 ec 04             	sub    $0x4,%esp
  8003a4:	ff 75 20             	pushl  0x20(%ebp)
  8003a7:	53                   	push   %ebx
  8003a8:	ff 75 18             	pushl  0x18(%ebp)
  8003ab:	52                   	push   %edx
  8003ac:	50                   	push   %eax
  8003ad:	ff 75 0c             	pushl  0xc(%ebp)
  8003b0:	ff 75 08             	pushl  0x8(%ebp)
  8003b3:	e8 a1 ff ff ff       	call   800359 <printnum>
  8003b8:	83 c4 20             	add    $0x20,%esp
  8003bb:	eb 1a                	jmp    8003d7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003bd:	83 ec 08             	sub    $0x8,%esp
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 20             	pushl  0x20(%ebp)
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	ff d0                	call   *%eax
  8003cb:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ce:	ff 4d 1c             	decl   0x1c(%ebp)
  8003d1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003d5:	7f e6                	jg     8003bd <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003d7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003da:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003e5:	53                   	push   %ebx
  8003e6:	51                   	push   %ecx
  8003e7:	52                   	push   %edx
  8003e8:	50                   	push   %eax
  8003e9:	e8 ae 17 00 00       	call   801b9c <__umoddi3>
  8003ee:	83 c4 10             	add    $0x10,%esp
  8003f1:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  8003f6:	8a 00                	mov    (%eax),%al
  8003f8:	0f be c0             	movsbl %al,%eax
  8003fb:	83 ec 08             	sub    $0x8,%esp
  8003fe:	ff 75 0c             	pushl  0xc(%ebp)
  800401:	50                   	push   %eax
  800402:	8b 45 08             	mov    0x8(%ebp),%eax
  800405:	ff d0                	call   *%eax
  800407:	83 c4 10             	add    $0x10,%esp
}
  80040a:	90                   	nop
  80040b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80040e:	c9                   	leave  
  80040f:	c3                   	ret    

00800410 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800410:	55                   	push   %ebp
  800411:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800413:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800417:	7e 1c                	jle    800435 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	8d 50 08             	lea    0x8(%eax),%edx
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	89 10                	mov    %edx,(%eax)
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	83 e8 08             	sub    $0x8,%eax
  80042e:	8b 50 04             	mov    0x4(%eax),%edx
  800431:	8b 00                	mov    (%eax),%eax
  800433:	eb 40                	jmp    800475 <getuint+0x65>
	else if (lflag)
  800435:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800439:	74 1e                	je     800459 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	8b 00                	mov    (%eax),%eax
  800440:	8d 50 04             	lea    0x4(%eax),%edx
  800443:	8b 45 08             	mov    0x8(%ebp),%eax
  800446:	89 10                	mov    %edx,(%eax)
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	83 e8 04             	sub    $0x4,%eax
  800450:	8b 00                	mov    (%eax),%eax
  800452:	ba 00 00 00 00       	mov    $0x0,%edx
  800457:	eb 1c                	jmp    800475 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	8d 50 04             	lea    0x4(%eax),%edx
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	89 10                	mov    %edx,(%eax)
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	83 e8 04             	sub    $0x4,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800475:	5d                   	pop    %ebp
  800476:	c3                   	ret    

00800477 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800477:	55                   	push   %ebp
  800478:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80047a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80047e:	7e 1c                	jle    80049c <getint+0x25>
		return va_arg(*ap, long long);
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	8d 50 08             	lea    0x8(%eax),%edx
  800488:	8b 45 08             	mov    0x8(%ebp),%eax
  80048b:	89 10                	mov    %edx,(%eax)
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 e8 08             	sub    $0x8,%eax
  800495:	8b 50 04             	mov    0x4(%eax),%edx
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	eb 38                	jmp    8004d4 <getint+0x5d>
	else if (lflag)
  80049c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004a0:	74 1a                	je     8004bc <getint+0x45>
		return va_arg(*ap, long);
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	8d 50 04             	lea    0x4(%eax),%edx
  8004aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ad:	89 10                	mov    %edx,(%eax)
  8004af:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b2:	8b 00                	mov    (%eax),%eax
  8004b4:	83 e8 04             	sub    $0x4,%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	99                   	cltd   
  8004ba:	eb 18                	jmp    8004d4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bf:	8b 00                	mov    (%eax),%eax
  8004c1:	8d 50 04             	lea    0x4(%eax),%edx
  8004c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c7:	89 10                	mov    %edx,(%eax)
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	8b 00                	mov    (%eax),%eax
  8004ce:	83 e8 04             	sub    $0x4,%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	99                   	cltd   
}
  8004d4:	5d                   	pop    %ebp
  8004d5:	c3                   	ret    

008004d6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004d6:	55                   	push   %ebp
  8004d7:	89 e5                	mov    %esp,%ebp
  8004d9:	56                   	push   %esi
  8004da:	53                   	push   %ebx
  8004db:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004de:	eb 17                	jmp    8004f7 <vprintfmt+0x21>
			if (ch == '\0')
  8004e0:	85 db                	test   %ebx,%ebx
  8004e2:	0f 84 af 03 00 00    	je     800897 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004e8:	83 ec 08             	sub    $0x8,%esp
  8004eb:	ff 75 0c             	pushl  0xc(%ebp)
  8004ee:	53                   	push   %ebx
  8004ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f2:	ff d0                	call   *%eax
  8004f4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fa:	8d 50 01             	lea    0x1(%eax),%edx
  8004fd:	89 55 10             	mov    %edx,0x10(%ebp)
  800500:	8a 00                	mov    (%eax),%al
  800502:	0f b6 d8             	movzbl %al,%ebx
  800505:	83 fb 25             	cmp    $0x25,%ebx
  800508:	75 d6                	jne    8004e0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80050a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80050e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800515:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80051c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800523:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80052a:	8b 45 10             	mov    0x10(%ebp),%eax
  80052d:	8d 50 01             	lea    0x1(%eax),%edx
  800530:	89 55 10             	mov    %edx,0x10(%ebp)
  800533:	8a 00                	mov    (%eax),%al
  800535:	0f b6 d8             	movzbl %al,%ebx
  800538:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80053b:	83 f8 55             	cmp    $0x55,%eax
  80053e:	0f 87 2b 03 00 00    	ja     80086f <vprintfmt+0x399>
  800544:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  80054b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80054d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800551:	eb d7                	jmp    80052a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800553:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800557:	eb d1                	jmp    80052a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800559:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800560:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800563:	89 d0                	mov    %edx,%eax
  800565:	c1 e0 02             	shl    $0x2,%eax
  800568:	01 d0                	add    %edx,%eax
  80056a:	01 c0                	add    %eax,%eax
  80056c:	01 d8                	add    %ebx,%eax
  80056e:	83 e8 30             	sub    $0x30,%eax
  800571:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800574:	8b 45 10             	mov    0x10(%ebp),%eax
  800577:	8a 00                	mov    (%eax),%al
  800579:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80057c:	83 fb 2f             	cmp    $0x2f,%ebx
  80057f:	7e 3e                	jle    8005bf <vprintfmt+0xe9>
  800581:	83 fb 39             	cmp    $0x39,%ebx
  800584:	7f 39                	jg     8005bf <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800586:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800589:	eb d5                	jmp    800560 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80058b:	8b 45 14             	mov    0x14(%ebp),%eax
  80058e:	83 c0 04             	add    $0x4,%eax
  800591:	89 45 14             	mov    %eax,0x14(%ebp)
  800594:	8b 45 14             	mov    0x14(%ebp),%eax
  800597:	83 e8 04             	sub    $0x4,%eax
  80059a:	8b 00                	mov    (%eax),%eax
  80059c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80059f:	eb 1f                	jmp    8005c0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005a5:	79 83                	jns    80052a <vprintfmt+0x54>
				width = 0;
  8005a7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005ae:	e9 77 ff ff ff       	jmp    80052a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005b3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005ba:	e9 6b ff ff ff       	jmp    80052a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005bf:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c4:	0f 89 60 ff ff ff    	jns    80052a <vprintfmt+0x54>
				width = precision, precision = -1;
  8005ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005d0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005d7:	e9 4e ff ff ff       	jmp    80052a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005dc:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005df:	e9 46 ff ff ff       	jmp    80052a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e7:	83 c0 04             	add    $0x4,%eax
  8005ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f0:	83 e8 04             	sub    $0x4,%eax
  8005f3:	8b 00                	mov    (%eax),%eax
  8005f5:	83 ec 08             	sub    $0x8,%esp
  8005f8:	ff 75 0c             	pushl  0xc(%ebp)
  8005fb:	50                   	push   %eax
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	ff d0                	call   *%eax
  800601:	83 c4 10             	add    $0x10,%esp
			break;
  800604:	e9 89 02 00 00       	jmp    800892 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800609:	8b 45 14             	mov    0x14(%ebp),%eax
  80060c:	83 c0 04             	add    $0x4,%eax
  80060f:	89 45 14             	mov    %eax,0x14(%ebp)
  800612:	8b 45 14             	mov    0x14(%ebp),%eax
  800615:	83 e8 04             	sub    $0x4,%eax
  800618:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80061a:	85 db                	test   %ebx,%ebx
  80061c:	79 02                	jns    800620 <vprintfmt+0x14a>
				err = -err;
  80061e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800620:	83 fb 64             	cmp    $0x64,%ebx
  800623:	7f 0b                	jg     800630 <vprintfmt+0x15a>
  800625:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  80062c:	85 f6                	test   %esi,%esi
  80062e:	75 19                	jne    800649 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800630:	53                   	push   %ebx
  800631:	68 e5 1f 80 00       	push   $0x801fe5
  800636:	ff 75 0c             	pushl  0xc(%ebp)
  800639:	ff 75 08             	pushl  0x8(%ebp)
  80063c:	e8 5e 02 00 00       	call   80089f <printfmt>
  800641:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800644:	e9 49 02 00 00       	jmp    800892 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800649:	56                   	push   %esi
  80064a:	68 ee 1f 80 00       	push   $0x801fee
  80064f:	ff 75 0c             	pushl  0xc(%ebp)
  800652:	ff 75 08             	pushl  0x8(%ebp)
  800655:	e8 45 02 00 00       	call   80089f <printfmt>
  80065a:	83 c4 10             	add    $0x10,%esp
			break;
  80065d:	e9 30 02 00 00       	jmp    800892 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800662:	8b 45 14             	mov    0x14(%ebp),%eax
  800665:	83 c0 04             	add    $0x4,%eax
  800668:	89 45 14             	mov    %eax,0x14(%ebp)
  80066b:	8b 45 14             	mov    0x14(%ebp),%eax
  80066e:	83 e8 04             	sub    $0x4,%eax
  800671:	8b 30                	mov    (%eax),%esi
  800673:	85 f6                	test   %esi,%esi
  800675:	75 05                	jne    80067c <vprintfmt+0x1a6>
				p = "(null)";
  800677:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  80067c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800680:	7e 6d                	jle    8006ef <vprintfmt+0x219>
  800682:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800686:	74 67                	je     8006ef <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800688:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80068b:	83 ec 08             	sub    $0x8,%esp
  80068e:	50                   	push   %eax
  80068f:	56                   	push   %esi
  800690:	e8 0c 03 00 00       	call   8009a1 <strnlen>
  800695:	83 c4 10             	add    $0x10,%esp
  800698:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80069b:	eb 16                	jmp    8006b3 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80069d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 0c             	pushl  0xc(%ebp)
  8006a7:	50                   	push   %eax
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006b0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b7:	7f e4                	jg     80069d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b9:	eb 34                	jmp    8006ef <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006bb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006bf:	74 1c                	je     8006dd <vprintfmt+0x207>
  8006c1:	83 fb 1f             	cmp    $0x1f,%ebx
  8006c4:	7e 05                	jle    8006cb <vprintfmt+0x1f5>
  8006c6:	83 fb 7e             	cmp    $0x7e,%ebx
  8006c9:	7e 12                	jle    8006dd <vprintfmt+0x207>
					putch('?', putdat);
  8006cb:	83 ec 08             	sub    $0x8,%esp
  8006ce:	ff 75 0c             	pushl  0xc(%ebp)
  8006d1:	6a 3f                	push   $0x3f
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	ff d0                	call   *%eax
  8006d8:	83 c4 10             	add    $0x10,%esp
  8006db:	eb 0f                	jmp    8006ec <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006dd:	83 ec 08             	sub    $0x8,%esp
  8006e0:	ff 75 0c             	pushl  0xc(%ebp)
  8006e3:	53                   	push   %ebx
  8006e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e7:	ff d0                	call   *%eax
  8006e9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ec:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ef:	89 f0                	mov    %esi,%eax
  8006f1:	8d 70 01             	lea    0x1(%eax),%esi
  8006f4:	8a 00                	mov    (%eax),%al
  8006f6:	0f be d8             	movsbl %al,%ebx
  8006f9:	85 db                	test   %ebx,%ebx
  8006fb:	74 24                	je     800721 <vprintfmt+0x24b>
  8006fd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800701:	78 b8                	js     8006bb <vprintfmt+0x1e5>
  800703:	ff 4d e0             	decl   -0x20(%ebp)
  800706:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80070a:	79 af                	jns    8006bb <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80070c:	eb 13                	jmp    800721 <vprintfmt+0x24b>
				putch(' ', putdat);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	6a 20                	push   $0x20
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	ff d0                	call   *%eax
  80071b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80071e:	ff 4d e4             	decl   -0x1c(%ebp)
  800721:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800725:	7f e7                	jg     80070e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800727:	e9 66 01 00 00       	jmp    800892 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 e8             	pushl  -0x18(%ebp)
  800732:	8d 45 14             	lea    0x14(%ebp),%eax
  800735:	50                   	push   %eax
  800736:	e8 3c fd ff ff       	call   800477 <getint>
  80073b:	83 c4 10             	add    $0x10,%esp
  80073e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800741:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800744:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800747:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80074a:	85 d2                	test   %edx,%edx
  80074c:	79 23                	jns    800771 <vprintfmt+0x29b>
				putch('-', putdat);
  80074e:	83 ec 08             	sub    $0x8,%esp
  800751:	ff 75 0c             	pushl  0xc(%ebp)
  800754:	6a 2d                	push   $0x2d
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	ff d0                	call   *%eax
  80075b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80075e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800761:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800764:	f7 d8                	neg    %eax
  800766:	83 d2 00             	adc    $0x0,%edx
  800769:	f7 da                	neg    %edx
  80076b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800771:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800778:	e9 bc 00 00 00       	jmp    800839 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80077d:	83 ec 08             	sub    $0x8,%esp
  800780:	ff 75 e8             	pushl  -0x18(%ebp)
  800783:	8d 45 14             	lea    0x14(%ebp),%eax
  800786:	50                   	push   %eax
  800787:	e8 84 fc ff ff       	call   800410 <getuint>
  80078c:	83 c4 10             	add    $0x10,%esp
  80078f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800792:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800795:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80079c:	e9 98 00 00 00       	jmp    800839 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	6a 58                	push   $0x58
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	ff d0                	call   *%eax
  8007ae:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007b1:	83 ec 08             	sub    $0x8,%esp
  8007b4:	ff 75 0c             	pushl  0xc(%ebp)
  8007b7:	6a 58                	push   $0x58
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	ff d0                	call   *%eax
  8007be:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007c1:	83 ec 08             	sub    $0x8,%esp
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	6a 58                	push   $0x58
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	ff d0                	call   *%eax
  8007ce:	83 c4 10             	add    $0x10,%esp
			break;
  8007d1:	e9 bc 00 00 00       	jmp    800892 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	ff 75 0c             	pushl  0xc(%ebp)
  8007dc:	6a 30                	push   $0x30
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	ff d0                	call   *%eax
  8007e3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007e6:	83 ec 08             	sub    $0x8,%esp
  8007e9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ec:	6a 78                	push   $0x78
  8007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f1:	ff d0                	call   *%eax
  8007f3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f9:	83 c0 04             	add    $0x4,%eax
  8007fc:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800802:	83 e8 04             	sub    $0x4,%eax
  800805:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800807:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800811:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800818:	eb 1f                	jmp    800839 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80081a:	83 ec 08             	sub    $0x8,%esp
  80081d:	ff 75 e8             	pushl  -0x18(%ebp)
  800820:	8d 45 14             	lea    0x14(%ebp),%eax
  800823:	50                   	push   %eax
  800824:	e8 e7 fb ff ff       	call   800410 <getuint>
  800829:	83 c4 10             	add    $0x10,%esp
  80082c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80082f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800832:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800839:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80083d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800840:	83 ec 04             	sub    $0x4,%esp
  800843:	52                   	push   %edx
  800844:	ff 75 e4             	pushl  -0x1c(%ebp)
  800847:	50                   	push   %eax
  800848:	ff 75 f4             	pushl  -0xc(%ebp)
  80084b:	ff 75 f0             	pushl  -0x10(%ebp)
  80084e:	ff 75 0c             	pushl  0xc(%ebp)
  800851:	ff 75 08             	pushl  0x8(%ebp)
  800854:	e8 00 fb ff ff       	call   800359 <printnum>
  800859:	83 c4 20             	add    $0x20,%esp
			break;
  80085c:	eb 34                	jmp    800892 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80085e:	83 ec 08             	sub    $0x8,%esp
  800861:	ff 75 0c             	pushl  0xc(%ebp)
  800864:	53                   	push   %ebx
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	ff d0                	call   *%eax
  80086a:	83 c4 10             	add    $0x10,%esp
			break;
  80086d:	eb 23                	jmp    800892 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80086f:	83 ec 08             	sub    $0x8,%esp
  800872:	ff 75 0c             	pushl  0xc(%ebp)
  800875:	6a 25                	push   $0x25
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	ff d0                	call   *%eax
  80087c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80087f:	ff 4d 10             	decl   0x10(%ebp)
  800882:	eb 03                	jmp    800887 <vprintfmt+0x3b1>
  800884:	ff 4d 10             	decl   0x10(%ebp)
  800887:	8b 45 10             	mov    0x10(%ebp),%eax
  80088a:	48                   	dec    %eax
  80088b:	8a 00                	mov    (%eax),%al
  80088d:	3c 25                	cmp    $0x25,%al
  80088f:	75 f3                	jne    800884 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800891:	90                   	nop
		}
	}
  800892:	e9 47 fc ff ff       	jmp    8004de <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800897:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800898:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80089b:	5b                   	pop    %ebx
  80089c:	5e                   	pop    %esi
  80089d:	5d                   	pop    %ebp
  80089e:	c3                   	ret    

0080089f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80089f:	55                   	push   %ebp
  8008a0:	89 e5                	mov    %esp,%ebp
  8008a2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008a5:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a8:	83 c0 04             	add    $0x4,%eax
  8008ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b4:	50                   	push   %eax
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	ff 75 08             	pushl  0x8(%ebp)
  8008bb:	e8 16 fc ff ff       	call   8004d6 <vprintfmt>
  8008c0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008c3:	90                   	nop
  8008c4:	c9                   	leave  
  8008c5:	c3                   	ret    

008008c6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008c6:	55                   	push   %ebp
  8008c7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cc:	8b 40 08             	mov    0x8(%eax),%eax
  8008cf:	8d 50 01             	lea    0x1(%eax),%edx
  8008d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008db:	8b 10                	mov    (%eax),%edx
  8008dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e0:	8b 40 04             	mov    0x4(%eax),%eax
  8008e3:	39 c2                	cmp    %eax,%edx
  8008e5:	73 12                	jae    8008f9 <sprintputch+0x33>
		*b->buf++ = ch;
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 00                	mov    (%eax),%eax
  8008ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f2:	89 0a                	mov    %ecx,(%edx)
  8008f4:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f7:	88 10                	mov    %dl,(%eax)
}
  8008f9:	90                   	nop
  8008fa:	5d                   	pop    %ebp
  8008fb:	c3                   	ret    

008008fc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800908:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	01 d0                	add    %edx,%eax
  800913:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800916:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80091d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800921:	74 06                	je     800929 <vsnprintf+0x2d>
  800923:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800927:	7f 07                	jg     800930 <vsnprintf+0x34>
		return -E_INVAL;
  800929:	b8 03 00 00 00       	mov    $0x3,%eax
  80092e:	eb 20                	jmp    800950 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800930:	ff 75 14             	pushl  0x14(%ebp)
  800933:	ff 75 10             	pushl  0x10(%ebp)
  800936:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800939:	50                   	push   %eax
  80093a:	68 c6 08 80 00       	push   $0x8008c6
  80093f:	e8 92 fb ff ff       	call   8004d6 <vprintfmt>
  800944:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800947:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80094a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80094d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800950:	c9                   	leave  
  800951:	c3                   	ret    

00800952 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800958:	8d 45 10             	lea    0x10(%ebp),%eax
  80095b:	83 c0 04             	add    $0x4,%eax
  80095e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800961:	8b 45 10             	mov    0x10(%ebp),%eax
  800964:	ff 75 f4             	pushl  -0xc(%ebp)
  800967:	50                   	push   %eax
  800968:	ff 75 0c             	pushl  0xc(%ebp)
  80096b:	ff 75 08             	pushl  0x8(%ebp)
  80096e:	e8 89 ff ff ff       	call   8008fc <vsnprintf>
  800973:	83 c4 10             	add    $0x10,%esp
  800976:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800979:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800984:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098b:	eb 06                	jmp    800993 <strlen+0x15>
		n++;
  80098d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800990:	ff 45 08             	incl   0x8(%ebp)
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	8a 00                	mov    (%eax),%al
  800998:	84 c0                	test   %al,%al
  80099a:	75 f1                	jne    80098d <strlen+0xf>
		n++;
	return n;
  80099c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80099f:	c9                   	leave  
  8009a0:	c3                   	ret    

008009a1 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009a1:	55                   	push   %ebp
  8009a2:	89 e5                	mov    %esp,%ebp
  8009a4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ae:	eb 09                	jmp    8009b9 <strnlen+0x18>
		n++;
  8009b0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009b3:	ff 45 08             	incl   0x8(%ebp)
  8009b6:	ff 4d 0c             	decl   0xc(%ebp)
  8009b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009bd:	74 09                	je     8009c8 <strnlen+0x27>
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	8a 00                	mov    (%eax),%al
  8009c4:	84 c0                	test   %al,%al
  8009c6:	75 e8                	jne    8009b0 <strnlen+0xf>
		n++;
	return n;
  8009c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009cb:	c9                   	leave  
  8009cc:	c3                   	ret    

008009cd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009cd:	55                   	push   %ebp
  8009ce:	89 e5                	mov    %esp,%ebp
  8009d0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009d9:	90                   	nop
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	8d 50 01             	lea    0x1(%eax),%edx
  8009e0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009ec:	8a 12                	mov    (%edx),%dl
  8009ee:	88 10                	mov    %dl,(%eax)
  8009f0:	8a 00                	mov    (%eax),%al
  8009f2:	84 c0                	test   %al,%al
  8009f4:	75 e4                	jne    8009da <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009f9:	c9                   	leave  
  8009fa:	c3                   	ret    

008009fb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009fb:	55                   	push   %ebp
  8009fc:	89 e5                	mov    %esp,%ebp
  8009fe:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a0e:	eb 1f                	jmp    800a2f <strncpy+0x34>
		*dst++ = *src;
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	8d 50 01             	lea    0x1(%eax),%edx
  800a16:	89 55 08             	mov    %edx,0x8(%ebp)
  800a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1c:	8a 12                	mov    (%edx),%dl
  800a1e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a23:	8a 00                	mov    (%eax),%al
  800a25:	84 c0                	test   %al,%al
  800a27:	74 03                	je     800a2c <strncpy+0x31>
			src++;
  800a29:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a2c:	ff 45 fc             	incl   -0x4(%ebp)
  800a2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a32:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a35:	72 d9                	jb     800a10 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a37:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a3a:	c9                   	leave  
  800a3b:	c3                   	ret    

00800a3c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a3c:	55                   	push   %ebp
  800a3d:	89 e5                	mov    %esp,%ebp
  800a3f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a4c:	74 30                	je     800a7e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a4e:	eb 16                	jmp    800a66 <strlcpy+0x2a>
			*dst++ = *src++;
  800a50:	8b 45 08             	mov    0x8(%ebp),%eax
  800a53:	8d 50 01             	lea    0x1(%eax),%edx
  800a56:	89 55 08             	mov    %edx,0x8(%ebp)
  800a59:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a5f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a62:	8a 12                	mov    (%edx),%dl
  800a64:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a66:	ff 4d 10             	decl   0x10(%ebp)
  800a69:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6d:	74 09                	je     800a78 <strlcpy+0x3c>
  800a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a72:	8a 00                	mov    (%eax),%al
  800a74:	84 c0                	test   %al,%al
  800a76:	75 d8                	jne    800a50 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a7e:	8b 55 08             	mov    0x8(%ebp),%edx
  800a81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a84:	29 c2                	sub    %eax,%edx
  800a86:	89 d0                	mov    %edx,%eax
}
  800a88:	c9                   	leave  
  800a89:	c3                   	ret    

00800a8a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a8a:	55                   	push   %ebp
  800a8b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a8d:	eb 06                	jmp    800a95 <strcmp+0xb>
		p++, q++;
  800a8f:	ff 45 08             	incl   0x8(%ebp)
  800a92:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8a 00                	mov    (%eax),%al
  800a9a:	84 c0                	test   %al,%al
  800a9c:	74 0e                	je     800aac <strcmp+0x22>
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	8a 10                	mov    (%eax),%dl
  800aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa6:	8a 00                	mov    (%eax),%al
  800aa8:	38 c2                	cmp    %al,%dl
  800aaa:	74 e3                	je     800a8f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	8a 00                	mov    (%eax),%al
  800ab1:	0f b6 d0             	movzbl %al,%edx
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	0f b6 c0             	movzbl %al,%eax
  800abc:	29 c2                	sub    %eax,%edx
  800abe:	89 d0                	mov    %edx,%eax
}
  800ac0:	5d                   	pop    %ebp
  800ac1:	c3                   	ret    

00800ac2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ac2:	55                   	push   %ebp
  800ac3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ac5:	eb 09                	jmp    800ad0 <strncmp+0xe>
		n--, p++, q++;
  800ac7:	ff 4d 10             	decl   0x10(%ebp)
  800aca:	ff 45 08             	incl   0x8(%ebp)
  800acd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ad0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ad4:	74 17                	je     800aed <strncmp+0x2b>
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	8a 00                	mov    (%eax),%al
  800adb:	84 c0                	test   %al,%al
  800add:	74 0e                	je     800aed <strncmp+0x2b>
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8a 10                	mov    (%eax),%dl
  800ae4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	38 c2                	cmp    %al,%dl
  800aeb:	74 da                	je     800ac7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af1:	75 07                	jne    800afa <strncmp+0x38>
		return 0;
  800af3:	b8 00 00 00 00       	mov    $0x0,%eax
  800af8:	eb 14                	jmp    800b0e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	0f b6 d0             	movzbl %al,%edx
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	8a 00                	mov    (%eax),%al
  800b07:	0f b6 c0             	movzbl %al,%eax
  800b0a:	29 c2                	sub    %eax,%edx
  800b0c:	89 d0                	mov    %edx,%eax
}
  800b0e:	5d                   	pop    %ebp
  800b0f:	c3                   	ret    

00800b10 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
  800b13:	83 ec 04             	sub    $0x4,%esp
  800b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b19:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b1c:	eb 12                	jmp    800b30 <strchr+0x20>
		if (*s == c)
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8a 00                	mov    (%eax),%al
  800b23:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b26:	75 05                	jne    800b2d <strchr+0x1d>
			return (char *) s;
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	eb 11                	jmp    800b3e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b2d:	ff 45 08             	incl   0x8(%ebp)
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8a 00                	mov    (%eax),%al
  800b35:	84 c0                	test   %al,%al
  800b37:	75 e5                	jne    800b1e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b39:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b3e:	c9                   	leave  
  800b3f:	c3                   	ret    

00800b40 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b40:	55                   	push   %ebp
  800b41:	89 e5                	mov    %esp,%ebp
  800b43:	83 ec 04             	sub    $0x4,%esp
  800b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b49:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b4c:	eb 0d                	jmp    800b5b <strfind+0x1b>
		if (*s == c)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8a 00                	mov    (%eax),%al
  800b53:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b56:	74 0e                	je     800b66 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b58:	ff 45 08             	incl   0x8(%ebp)
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	84 c0                	test   %al,%al
  800b62:	75 ea                	jne    800b4e <strfind+0xe>
  800b64:	eb 01                	jmp    800b67 <strfind+0x27>
		if (*s == c)
			break;
  800b66:	90                   	nop
	return (char *) s;
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
  800b6f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b78:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b7e:	eb 0e                	jmp    800b8e <memset+0x22>
		*p++ = c;
  800b80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b83:	8d 50 01             	lea    0x1(%eax),%edx
  800b86:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b89:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b8c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b8e:	ff 4d f8             	decl   -0x8(%ebp)
  800b91:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b95:	79 e9                	jns    800b80 <memset+0x14>
		*p++ = c;

	return v;
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9a:	c9                   	leave  
  800b9b:	c3                   	ret    

00800b9c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ba2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bae:	eb 16                	jmp    800bc6 <memcpy+0x2a>
		*d++ = *s++;
  800bb0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb3:	8d 50 01             	lea    0x1(%eax),%edx
  800bb6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bbc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc2:	8a 12                	mov    (%edx),%dl
  800bc4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcc:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcf:	85 c0                	test   %eax,%eax
  800bd1:	75 dd                	jne    800bb0 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd6:	c9                   	leave  
  800bd7:	c3                   	ret    

00800bd8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bd8:	55                   	push   %ebp
  800bd9:	89 e5                	mov    %esp,%ebp
  800bdb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800bde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bf0:	73 50                	jae    800c42 <memmove+0x6a>
  800bf2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf8:	01 d0                	add    %edx,%eax
  800bfa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bfd:	76 43                	jbe    800c42 <memmove+0x6a>
		s += n;
  800bff:	8b 45 10             	mov    0x10(%ebp),%eax
  800c02:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c05:	8b 45 10             	mov    0x10(%ebp),%eax
  800c08:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c0b:	eb 10                	jmp    800c1d <memmove+0x45>
			*--d = *--s;
  800c0d:	ff 4d f8             	decl   -0x8(%ebp)
  800c10:	ff 4d fc             	decl   -0x4(%ebp)
  800c13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c16:	8a 10                	mov    (%eax),%dl
  800c18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c20:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c23:	89 55 10             	mov    %edx,0x10(%ebp)
  800c26:	85 c0                	test   %eax,%eax
  800c28:	75 e3                	jne    800c0d <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c2a:	eb 23                	jmp    800c4f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2f:	8d 50 01             	lea    0x1(%eax),%edx
  800c32:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c35:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c38:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c3b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c3e:	8a 12                	mov    (%edx),%dl
  800c40:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c42:	8b 45 10             	mov    0x10(%ebp),%eax
  800c45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c48:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4b:	85 c0                	test   %eax,%eax
  800c4d:	75 dd                	jne    800c2c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c52:	c9                   	leave  
  800c53:	c3                   	ret    

00800c54 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c54:	55                   	push   %ebp
  800c55:	89 e5                	mov    %esp,%ebp
  800c57:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c63:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c66:	eb 2a                	jmp    800c92 <memcmp+0x3e>
		if (*s1 != *s2)
  800c68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6b:	8a 10                	mov    (%eax),%dl
  800c6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	38 c2                	cmp    %al,%dl
  800c74:	74 16                	je     800c8c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	0f b6 d0             	movzbl %al,%edx
  800c7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	0f b6 c0             	movzbl %al,%eax
  800c86:	29 c2                	sub    %eax,%edx
  800c88:	89 d0                	mov    %edx,%eax
  800c8a:	eb 18                	jmp    800ca4 <memcmp+0x50>
		s1++, s2++;
  800c8c:	ff 45 fc             	incl   -0x4(%ebp)
  800c8f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c92:	8b 45 10             	mov    0x10(%ebp),%eax
  800c95:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c98:	89 55 10             	mov    %edx,0x10(%ebp)
  800c9b:	85 c0                	test   %eax,%eax
  800c9d:	75 c9                	jne    800c68 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ca4:	c9                   	leave  
  800ca5:	c3                   	ret    

00800ca6 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ca6:	55                   	push   %ebp
  800ca7:	89 e5                	mov    %esp,%ebp
  800ca9:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cac:	8b 55 08             	mov    0x8(%ebp),%edx
  800caf:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb2:	01 d0                	add    %edx,%eax
  800cb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cb7:	eb 15                	jmp    800cce <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	0f b6 d0             	movzbl %al,%edx
  800cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc4:	0f b6 c0             	movzbl %al,%eax
  800cc7:	39 c2                	cmp    %eax,%edx
  800cc9:	74 0d                	je     800cd8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ccb:	ff 45 08             	incl   0x8(%ebp)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cd4:	72 e3                	jb     800cb9 <memfind+0x13>
  800cd6:	eb 01                	jmp    800cd9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cd8:	90                   	nop
	return (void *) s;
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cdc:	c9                   	leave  
  800cdd:	c3                   	ret    

00800cde <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ce4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ceb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cf2:	eb 03                	jmp    800cf7 <strtol+0x19>
		s++;
  800cf4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3c 20                	cmp    $0x20,%al
  800cfe:	74 f4                	je     800cf4 <strtol+0x16>
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	3c 09                	cmp    $0x9,%al
  800d07:	74 eb                	je     800cf4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8a 00                	mov    (%eax),%al
  800d0e:	3c 2b                	cmp    $0x2b,%al
  800d10:	75 05                	jne    800d17 <strtol+0x39>
		s++;
  800d12:	ff 45 08             	incl   0x8(%ebp)
  800d15:	eb 13                	jmp    800d2a <strtol+0x4c>
	else if (*s == '-')
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1a:	8a 00                	mov    (%eax),%al
  800d1c:	3c 2d                	cmp    $0x2d,%al
  800d1e:	75 0a                	jne    800d2a <strtol+0x4c>
		s++, neg = 1;
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2e:	74 06                	je     800d36 <strtol+0x58>
  800d30:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d34:	75 20                	jne    800d56 <strtol+0x78>
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	3c 30                	cmp    $0x30,%al
  800d3d:	75 17                	jne    800d56 <strtol+0x78>
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	40                   	inc    %eax
  800d43:	8a 00                	mov    (%eax),%al
  800d45:	3c 78                	cmp    $0x78,%al
  800d47:	75 0d                	jne    800d56 <strtol+0x78>
		s += 2, base = 16;
  800d49:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d4d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d54:	eb 28                	jmp    800d7e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5a:	75 15                	jne    800d71 <strtol+0x93>
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	3c 30                	cmp    $0x30,%al
  800d63:	75 0c                	jne    800d71 <strtol+0x93>
		s++, base = 8;
  800d65:	ff 45 08             	incl   0x8(%ebp)
  800d68:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d6f:	eb 0d                	jmp    800d7e <strtol+0xa0>
	else if (base == 0)
  800d71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d75:	75 07                	jne    800d7e <strtol+0xa0>
		base = 10;
  800d77:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	3c 2f                	cmp    $0x2f,%al
  800d85:	7e 19                	jle    800da0 <strtol+0xc2>
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	3c 39                	cmp    $0x39,%al
  800d8e:	7f 10                	jg     800da0 <strtol+0xc2>
			dig = *s - '0';
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8a 00                	mov    (%eax),%al
  800d95:	0f be c0             	movsbl %al,%eax
  800d98:	83 e8 30             	sub    $0x30,%eax
  800d9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d9e:	eb 42                	jmp    800de2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	3c 60                	cmp    $0x60,%al
  800da7:	7e 19                	jle    800dc2 <strtol+0xe4>
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	3c 7a                	cmp    $0x7a,%al
  800db0:	7f 10                	jg     800dc2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f be c0             	movsbl %al,%eax
  800dba:	83 e8 57             	sub    $0x57,%eax
  800dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dc0:	eb 20                	jmp    800de2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	8a 00                	mov    (%eax),%al
  800dc7:	3c 40                	cmp    $0x40,%al
  800dc9:	7e 39                	jle    800e04 <strtol+0x126>
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8a 00                	mov    (%eax),%al
  800dd0:	3c 5a                	cmp    $0x5a,%al
  800dd2:	7f 30                	jg     800e04 <strtol+0x126>
			dig = *s - 'A' + 10;
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	0f be c0             	movsbl %al,%eax
  800ddc:	83 e8 37             	sub    $0x37,%eax
  800ddf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800de2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800de5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800de8:	7d 19                	jge    800e03 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dea:	ff 45 08             	incl   0x8(%ebp)
  800ded:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df0:	0f af 45 10          	imul   0x10(%ebp),%eax
  800df4:	89 c2                	mov    %eax,%edx
  800df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800df9:	01 d0                	add    %edx,%eax
  800dfb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dfe:	e9 7b ff ff ff       	jmp    800d7e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e03:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e08:	74 08                	je     800e12 <strtol+0x134>
		*endptr = (char *) s;
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e10:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e12:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e16:	74 07                	je     800e1f <strtol+0x141>
  800e18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1b:	f7 d8                	neg    %eax
  800e1d:	eb 03                	jmp    800e22 <strtol+0x144>
  800e1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e22:	c9                   	leave  
  800e23:	c3                   	ret    

00800e24 <ltostr>:

void
ltostr(long value, char *str)
{
  800e24:	55                   	push   %ebp
  800e25:	89 e5                	mov    %esp,%ebp
  800e27:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e2a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e31:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e38:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e3c:	79 13                	jns    800e51 <ltostr+0x2d>
	{
		neg = 1;
  800e3e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e48:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e4b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e4e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e59:	99                   	cltd   
  800e5a:	f7 f9                	idiv   %ecx
  800e5c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e62:	8d 50 01             	lea    0x1(%eax),%edx
  800e65:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e68:	89 c2                	mov    %eax,%edx
  800e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6d:	01 d0                	add    %edx,%eax
  800e6f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e72:	83 c2 30             	add    $0x30,%edx
  800e75:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e7a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e7f:	f7 e9                	imul   %ecx
  800e81:	c1 fa 02             	sar    $0x2,%edx
  800e84:	89 c8                	mov    %ecx,%eax
  800e86:	c1 f8 1f             	sar    $0x1f,%eax
  800e89:	29 c2                	sub    %eax,%edx
  800e8b:	89 d0                	mov    %edx,%eax
  800e8d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e90:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e93:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e98:	f7 e9                	imul   %ecx
  800e9a:	c1 fa 02             	sar    $0x2,%edx
  800e9d:	89 c8                	mov    %ecx,%eax
  800e9f:	c1 f8 1f             	sar    $0x1f,%eax
  800ea2:	29 c2                	sub    %eax,%edx
  800ea4:	89 d0                	mov    %edx,%eax
  800ea6:	c1 e0 02             	shl    $0x2,%eax
  800ea9:	01 d0                	add    %edx,%eax
  800eab:	01 c0                	add    %eax,%eax
  800ead:	29 c1                	sub    %eax,%ecx
  800eaf:	89 ca                	mov    %ecx,%edx
  800eb1:	85 d2                	test   %edx,%edx
  800eb3:	75 9c                	jne    800e51 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800eb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ebc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ebf:	48                   	dec    %eax
  800ec0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ec3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ec7:	74 3d                	je     800f06 <ltostr+0xe2>
		start = 1 ;
  800ec9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ed0:	eb 34                	jmp    800f06 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed8:	01 d0                	add    %edx,%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800edf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee5:	01 c2                	add    %eax,%edx
  800ee7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	01 c8                	add    %ecx,%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ef3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef9:	01 c2                	add    %eax,%edx
  800efb:	8a 45 eb             	mov    -0x15(%ebp),%al
  800efe:	88 02                	mov    %al,(%edx)
		start++ ;
  800f00:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f03:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f09:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f0c:	7c c4                	jl     800ed2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f0e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f14:	01 d0                	add    %edx,%eax
  800f16:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f19:	90                   	nop
  800f1a:	c9                   	leave  
  800f1b:	c3                   	ret    

00800f1c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f1c:	55                   	push   %ebp
  800f1d:	89 e5                	mov    %esp,%ebp
  800f1f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f22:	ff 75 08             	pushl  0x8(%ebp)
  800f25:	e8 54 fa ff ff       	call   80097e <strlen>
  800f2a:	83 c4 04             	add    $0x4,%esp
  800f2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	e8 46 fa ff ff       	call   80097e <strlen>
  800f38:	83 c4 04             	add    $0x4,%esp
  800f3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f4c:	eb 17                	jmp    800f65 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f4e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f51:	8b 45 10             	mov    0x10(%ebp),%eax
  800f54:	01 c2                	add    %eax,%edx
  800f56:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	01 c8                	add    %ecx,%eax
  800f5e:	8a 00                	mov    (%eax),%al
  800f60:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f62:	ff 45 fc             	incl   -0x4(%ebp)
  800f65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f68:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f6b:	7c e1                	jl     800f4e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f6d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f74:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f7b:	eb 1f                	jmp    800f9c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f80:	8d 50 01             	lea    0x1(%eax),%edx
  800f83:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f86:	89 c2                	mov    %eax,%edx
  800f88:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8b:	01 c2                	add    %eax,%edx
  800f8d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	01 c8                	add    %ecx,%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f99:	ff 45 f8             	incl   -0x8(%ebp)
  800f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fa2:	7c d9                	jl     800f7d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fa4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800faa:	01 d0                	add    %edx,%eax
  800fac:	c6 00 00             	movb   $0x0,(%eax)
}
  800faf:	90                   	nop
  800fb0:	c9                   	leave  
  800fb1:	c3                   	ret    

00800fb2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fb2:	55                   	push   %ebp
  800fb3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fbe:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc1:	8b 00                	mov    (%eax),%eax
  800fc3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fca:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcd:	01 d0                	add    %edx,%eax
  800fcf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fd5:	eb 0c                	jmp    800fe3 <strsplit+0x31>
			*string++ = 0;
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8d 50 01             	lea    0x1(%eax),%edx
  800fdd:	89 55 08             	mov    %edx,0x8(%ebp)
  800fe0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	84 c0                	test   %al,%al
  800fea:	74 18                	je     801004 <strsplit+0x52>
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	0f be c0             	movsbl %al,%eax
  800ff4:	50                   	push   %eax
  800ff5:	ff 75 0c             	pushl  0xc(%ebp)
  800ff8:	e8 13 fb ff ff       	call   800b10 <strchr>
  800ffd:	83 c4 08             	add    $0x8,%esp
  801000:	85 c0                	test   %eax,%eax
  801002:	75 d3                	jne    800fd7 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	84 c0                	test   %al,%al
  80100b:	74 5a                	je     801067 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80100d:	8b 45 14             	mov    0x14(%ebp),%eax
  801010:	8b 00                	mov    (%eax),%eax
  801012:	83 f8 0f             	cmp    $0xf,%eax
  801015:	75 07                	jne    80101e <strsplit+0x6c>
		{
			return 0;
  801017:	b8 00 00 00 00       	mov    $0x0,%eax
  80101c:	eb 66                	jmp    801084 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80101e:	8b 45 14             	mov    0x14(%ebp),%eax
  801021:	8b 00                	mov    (%eax),%eax
  801023:	8d 48 01             	lea    0x1(%eax),%ecx
  801026:	8b 55 14             	mov    0x14(%ebp),%edx
  801029:	89 0a                	mov    %ecx,(%edx)
  80102b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	01 c2                	add    %eax,%edx
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80103c:	eb 03                	jmp    801041 <strsplit+0x8f>
			string++;
  80103e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	84 c0                	test   %al,%al
  801048:	74 8b                	je     800fd5 <strsplit+0x23>
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	8a 00                	mov    (%eax),%al
  80104f:	0f be c0             	movsbl %al,%eax
  801052:	50                   	push   %eax
  801053:	ff 75 0c             	pushl  0xc(%ebp)
  801056:	e8 b5 fa ff ff       	call   800b10 <strchr>
  80105b:	83 c4 08             	add    $0x8,%esp
  80105e:	85 c0                	test   %eax,%eax
  801060:	74 dc                	je     80103e <strsplit+0x8c>
			string++;
	}
  801062:	e9 6e ff ff ff       	jmp    800fd5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801067:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801068:	8b 45 14             	mov    0x14(%ebp),%eax
  80106b:	8b 00                	mov    (%eax),%eax
  80106d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801074:	8b 45 10             	mov    0x10(%ebp),%eax
  801077:	01 d0                	add    %edx,%eax
  801079:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80107f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801084:	c9                   	leave  
  801085:	c3                   	ret    

00801086 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  80108c:	e8 9b 07 00 00       	call   80182c <sys_isUHeapPlacementStrategyNEXTFIT>
  801091:	85 c0                	test   %eax,%eax
  801093:	0f 84 64 01 00 00    	je     8011fd <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801099:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  80109f:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  8010a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010ac:	01 d0                	add    %edx,%eax
  8010ae:	48                   	dec    %eax
  8010af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8010b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8010b5:	ba 00 00 00 00       	mov    $0x0,%edx
  8010ba:	f7 75 e8             	divl   -0x18(%ebp)
  8010bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8010c0:	29 d0                	sub    %edx,%eax
  8010c2:	89 04 cd 64 30 88 00 	mov    %eax,0x883064(,%ecx,8)
		uint32 maxSize = startAdd+size;
  8010c9:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	01 d0                	add    %edx,%eax
  8010d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  8010d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  8010de:	a1 28 30 80 00       	mov    0x803028,%eax
  8010e3:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  8010ea:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8010ed:	0f 83 0a 01 00 00    	jae    8011fd <malloc+0x177>
  8010f3:	a1 28 30 80 00       	mov    0x803028,%eax
  8010f8:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  8010ff:	85 c0                	test   %eax,%eax
  801101:	0f 84 f6 00 00 00    	je     8011fd <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801107:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80110e:	e9 dc 00 00 00       	jmp    8011ef <malloc+0x169>
				flag++;
  801113:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801116:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801119:	8b 04 85 60 30 80 00 	mov    0x803060(,%eax,4),%eax
  801120:	85 c0                	test   %eax,%eax
  801122:	74 07                	je     80112b <malloc+0xa5>
					flag=0;
  801124:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  80112b:	a1 28 30 80 00       	mov    0x803028,%eax
  801130:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801137:	85 c0                	test   %eax,%eax
  801139:	79 05                	jns    801140 <malloc+0xba>
  80113b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801140:	c1 f8 0c             	sar    $0xc,%eax
  801143:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801146:	0f 85 a0 00 00 00    	jne    8011ec <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  80114c:	a1 28 30 80 00       	mov    0x803028,%eax
  801151:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801158:	85 c0                	test   %eax,%eax
  80115a:	79 05                	jns    801161 <malloc+0xdb>
  80115c:	05 ff 0f 00 00       	add    $0xfff,%eax
  801161:	c1 f8 0c             	sar    $0xc,%eax
  801164:	89 c2                	mov    %eax,%edx
  801166:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801169:	29 d0                	sub    %edx,%eax
  80116b:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  80116e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801171:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801174:	eb 11                	jmp    801187 <malloc+0x101>
						hFreeArr[j] = 1;
  801176:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801179:	c7 04 85 60 30 80 00 	movl   $0x1,0x803060(,%eax,4)
  801180:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801184:	ff 45 ec             	incl   -0x14(%ebp)
  801187:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80118a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80118d:	7e e7                	jle    801176 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  80118f:	a1 28 30 80 00       	mov    0x803028,%eax
  801194:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801197:	81 c2 01 00 08 00    	add    $0x80001,%edx
  80119d:	c1 e2 0c             	shl    $0xc,%edx
  8011a0:	89 15 04 30 80 00    	mov    %edx,0x803004
  8011a6:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8011ac:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  8011b3:	a1 28 30 80 00       	mov    0x803028,%eax
  8011b8:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  8011bf:	89 c2                	mov    %eax,%edx
  8011c1:	a1 28 30 80 00       	mov    0x803028,%eax
  8011c6:	8b 04 c5 60 30 88 00 	mov    0x883060(,%eax,8),%eax
  8011cd:	83 ec 08             	sub    $0x8,%esp
  8011d0:	52                   	push   %edx
  8011d1:	50                   	push   %eax
  8011d2:	e8 8b 02 00 00       	call   801462 <sys_allocateMem>
  8011d7:	83 c4 10             	add    $0x10,%esp

					idx++;
  8011da:	a1 28 30 80 00       	mov    0x803028,%eax
  8011df:	40                   	inc    %eax
  8011e0:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  8011e5:	a1 04 30 80 00       	mov    0x803004,%eax
  8011ea:	eb 16                	jmp    801202 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8011ec:	ff 45 f0             	incl   -0x10(%ebp)
  8011ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011f2:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8011f7:	0f 86 16 ff ff ff    	jbe    801113 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  8011fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 18             	sub    $0x18,%esp
  80120a:	8b 45 10             	mov    0x10(%ebp),%eax
  80120d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801210:	83 ec 04             	sub    $0x4,%esp
  801213:	68 50 21 80 00       	push   $0x802150
  801218:	6a 59                	push   $0x59
  80121a:	68 6f 21 80 00       	push   $0x80216f
  80121f:	e8 85 06 00 00       	call   8018a9 <_panic>

00801224 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80122a:	83 ec 04             	sub    $0x4,%esp
  80122d:	68 7b 21 80 00       	push   $0x80217b
  801232:	6a 5f                	push   $0x5f
  801234:	68 6f 21 80 00       	push   $0x80216f
  801239:	e8 6b 06 00 00       	call   8018a9 <_panic>

0080123e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
  801241:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801244:	83 ec 04             	sub    $0x4,%esp
  801247:	68 98 21 80 00       	push   $0x802198
  80124c:	6a 70                	push   $0x70
  80124e:	68 6f 21 80 00       	push   $0x80216f
  801253:	e8 51 06 00 00       	call   8018a9 <_panic>

00801258 <sfree>:

}


void sfree(void* virtual_address)
{
  801258:	55                   	push   %ebp
  801259:	89 e5                	mov    %esp,%ebp
  80125b:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  80125e:	83 ec 04             	sub    $0x4,%esp
  801261:	68 bb 21 80 00       	push   $0x8021bb
  801266:	6a 7b                	push   $0x7b
  801268:	68 6f 21 80 00       	push   $0x80216f
  80126d:	e8 37 06 00 00       	call   8018a9 <_panic>

00801272 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
  801275:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801278:	83 ec 04             	sub    $0x4,%esp
  80127b:	68 d8 21 80 00       	push   $0x8021d8
  801280:	68 93 00 00 00       	push   $0x93
  801285:	68 6f 21 80 00       	push   $0x80216f
  80128a:	e8 1a 06 00 00       	call   8018a9 <_panic>

0080128f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
  801292:	57                   	push   %edi
  801293:	56                   	push   %esi
  801294:	53                   	push   %ebx
  801295:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012a1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012a4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012aa:	cd 30                	int    $0x30
  8012ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012af:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b2:	83 c4 10             	add    $0x10,%esp
  8012b5:	5b                   	pop    %ebx
  8012b6:	5e                   	pop    %esi
  8012b7:	5f                   	pop    %edi
  8012b8:	5d                   	pop    %ebp
  8012b9:	c3                   	ret    

008012ba <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 04             	sub    $0x4,%esp
  8012c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	52                   	push   %edx
  8012d2:	ff 75 0c             	pushl  0xc(%ebp)
  8012d5:	50                   	push   %eax
  8012d6:	6a 00                	push   $0x0
  8012d8:	e8 b2 ff ff ff       	call   80128f <syscall>
  8012dd:	83 c4 18             	add    $0x18,%esp
}
  8012e0:	90                   	nop
  8012e1:	c9                   	leave  
  8012e2:	c3                   	ret    

008012e3 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012e3:	55                   	push   %ebp
  8012e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 01                	push   $0x1
  8012f2:	e8 98 ff ff ff       	call   80128f <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	50                   	push   %eax
  80130b:	6a 05                	push   $0x5
  80130d:	e8 7d ff ff ff       	call   80128f <syscall>
  801312:	83 c4 18             	add    $0x18,%esp
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 02                	push   $0x2
  801326:	e8 64 ff ff ff       	call   80128f <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 03                	push   $0x3
  80133f:	e8 4b ff ff ff       	call   80128f <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 04                	push   $0x4
  801358:	e8 32 ff ff ff       	call   80128f <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_env_exit>:


void sys_env_exit(void)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 06                	push   $0x6
  801371:	e8 19 ff ff ff       	call   80128f <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	90                   	nop
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80137f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	52                   	push   %edx
  80138c:	50                   	push   %eax
  80138d:	6a 07                	push   $0x7
  80138f:	e8 fb fe ff ff       	call   80128f <syscall>
  801394:	83 c4 18             	add    $0x18,%esp
}
  801397:	c9                   	leave  
  801398:	c3                   	ret    

00801399 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801399:	55                   	push   %ebp
  80139a:	89 e5                	mov    %esp,%ebp
  80139c:	56                   	push   %esi
  80139d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80139e:	8b 75 18             	mov    0x18(%ebp),%esi
  8013a1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	56                   	push   %esi
  8013ae:	53                   	push   %ebx
  8013af:	51                   	push   %ecx
  8013b0:	52                   	push   %edx
  8013b1:	50                   	push   %eax
  8013b2:	6a 08                	push   $0x8
  8013b4:	e8 d6 fe ff ff       	call   80128f <syscall>
  8013b9:	83 c4 18             	add    $0x18,%esp
}
  8013bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013bf:	5b                   	pop    %ebx
  8013c0:	5e                   	pop    %esi
  8013c1:	5d                   	pop    %ebp
  8013c2:	c3                   	ret    

008013c3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	52                   	push   %edx
  8013d3:	50                   	push   %eax
  8013d4:	6a 09                	push   $0x9
  8013d6:	e8 b4 fe ff ff       	call   80128f <syscall>
  8013db:	83 c4 18             	add    $0x18,%esp
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ec:	ff 75 08             	pushl  0x8(%ebp)
  8013ef:	6a 0a                	push   $0xa
  8013f1:	e8 99 fe ff ff       	call   80128f <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 0b                	push   $0xb
  80140a:	e8 80 fe ff ff       	call   80128f <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
}
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 0c                	push   $0xc
  801423:	e8 67 fe ff ff       	call   80128f <syscall>
  801428:	83 c4 18             	add    $0x18,%esp
}
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 0d                	push   $0xd
  80143c:	e8 4e fe ff ff       	call   80128f <syscall>
  801441:	83 c4 18             	add    $0x18,%esp
}
  801444:	c9                   	leave  
  801445:	c3                   	ret    

00801446 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801446:	55                   	push   %ebp
  801447:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	ff 75 0c             	pushl  0xc(%ebp)
  801452:	ff 75 08             	pushl  0x8(%ebp)
  801455:	6a 11                	push   $0x11
  801457:	e8 33 fe ff ff       	call   80128f <syscall>
  80145c:	83 c4 18             	add    $0x18,%esp
	return;
  80145f:	90                   	nop
}
  801460:	c9                   	leave  
  801461:	c3                   	ret    

00801462 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	ff 75 0c             	pushl  0xc(%ebp)
  80146e:	ff 75 08             	pushl  0x8(%ebp)
  801471:	6a 12                	push   $0x12
  801473:	e8 17 fe ff ff       	call   80128f <syscall>
  801478:	83 c4 18             	add    $0x18,%esp
	return ;
  80147b:	90                   	nop
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 0e                	push   $0xe
  80148d:	e8 fd fd ff ff       	call   80128f <syscall>
  801492:	83 c4 18             	add    $0x18,%esp
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	ff 75 08             	pushl  0x8(%ebp)
  8014a5:	6a 0f                	push   $0xf
  8014a7:	e8 e3 fd ff ff       	call   80128f <syscall>
  8014ac:	83 c4 18             	add    $0x18,%esp
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 10                	push   $0x10
  8014c0:	e8 ca fd ff ff       	call   80128f <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
}
  8014c8:	90                   	nop
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 14                	push   $0x14
  8014da:	e8 b0 fd ff ff       	call   80128f <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
}
  8014e2:	90                   	nop
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 15                	push   $0x15
  8014f4:	e8 96 fd ff ff       	call   80128f <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	90                   	nop
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <sys_cputc>:


void
sys_cputc(const char c)
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
  801502:	83 ec 04             	sub    $0x4,%esp
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
  801508:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80150b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	50                   	push   %eax
  801518:	6a 16                	push   $0x16
  80151a:	e8 70 fd ff ff       	call   80128f <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
}
  801522:	90                   	nop
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 17                	push   $0x17
  801534:	e8 56 fd ff ff       	call   80128f <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	90                   	nop
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	ff 75 0c             	pushl  0xc(%ebp)
  80154e:	50                   	push   %eax
  80154f:	6a 18                	push   $0x18
  801551:	e8 39 fd ff ff       	call   80128f <syscall>
  801556:	83 c4 18             	add    $0x18,%esp
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80155e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	52                   	push   %edx
  80156b:	50                   	push   %eax
  80156c:	6a 1b                	push   $0x1b
  80156e:	e8 1c fd ff ff       	call   80128f <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80157b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	52                   	push   %edx
  801588:	50                   	push   %eax
  801589:	6a 19                	push   $0x19
  80158b:	e8 ff fc ff ff       	call   80128f <syscall>
  801590:	83 c4 18             	add    $0x18,%esp
}
  801593:	90                   	nop
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801599:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	52                   	push   %edx
  8015a6:	50                   	push   %eax
  8015a7:	6a 1a                	push   $0x1a
  8015a9:	e8 e1 fc ff ff       	call   80128f <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	90                   	nop
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
  8015b7:	83 ec 04             	sub    $0x4,%esp
  8015ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015c0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015c3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ca:	6a 00                	push   $0x0
  8015cc:	51                   	push   %ecx
  8015cd:	52                   	push   %edx
  8015ce:	ff 75 0c             	pushl  0xc(%ebp)
  8015d1:	50                   	push   %eax
  8015d2:	6a 1c                	push   $0x1c
  8015d4:	e8 b6 fc ff ff       	call   80128f <syscall>
  8015d9:	83 c4 18             	add    $0x18,%esp
}
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	52                   	push   %edx
  8015ee:	50                   	push   %eax
  8015ef:	6a 1d                	push   $0x1d
  8015f1:	e8 99 fc ff ff       	call   80128f <syscall>
  8015f6:	83 c4 18             	add    $0x18,%esp
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015fe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801601:	8b 55 0c             	mov    0xc(%ebp),%edx
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	51                   	push   %ecx
  80160c:	52                   	push   %edx
  80160d:	50                   	push   %eax
  80160e:	6a 1e                	push   $0x1e
  801610:	e8 7a fc ff ff       	call   80128f <syscall>
  801615:	83 c4 18             	add    $0x18,%esp
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80161d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	52                   	push   %edx
  80162a:	50                   	push   %eax
  80162b:	6a 1f                	push   $0x1f
  80162d:	e8 5d fc ff ff       	call   80128f <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
}
  801635:	c9                   	leave  
  801636:	c3                   	ret    

00801637 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801637:	55                   	push   %ebp
  801638:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 20                	push   $0x20
  801646:	e8 44 fc ff ff       	call   80128f <syscall>
  80164b:	83 c4 18             	add    $0x18,%esp
}
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	ff 75 10             	pushl  0x10(%ebp)
  80165d:	ff 75 0c             	pushl  0xc(%ebp)
  801660:	50                   	push   %eax
  801661:	6a 21                	push   $0x21
  801663:	e8 27 fc ff ff       	call   80128f <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	c9                   	leave  
  80166c:	c3                   	ret    

0080166d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80166d:	55                   	push   %ebp
  80166e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	50                   	push   %eax
  80167c:	6a 22                	push   $0x22
  80167e:	e8 0c fc ff ff       	call   80128f <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	90                   	nop
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	50                   	push   %eax
  801698:	6a 23                	push   $0x23
  80169a:	e8 f0 fb ff ff       	call   80128f <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
}
  8016a2:	90                   	nop
  8016a3:	c9                   	leave  
  8016a4:	c3                   	ret    

008016a5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
  8016a8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016ab:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016ae:	8d 50 04             	lea    0x4(%eax),%edx
  8016b1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	52                   	push   %edx
  8016bb:	50                   	push   %eax
  8016bc:	6a 24                	push   $0x24
  8016be:	e8 cc fb ff ff       	call   80128f <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
	return result;
  8016c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016cf:	89 01                	mov    %eax,(%ecx)
  8016d1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	c9                   	leave  
  8016d8:	c2 04 00             	ret    $0x4

008016db <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	ff 75 10             	pushl  0x10(%ebp)
  8016e5:	ff 75 0c             	pushl  0xc(%ebp)
  8016e8:	ff 75 08             	pushl  0x8(%ebp)
  8016eb:	6a 13                	push   $0x13
  8016ed:	e8 9d fb ff ff       	call   80128f <syscall>
  8016f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f5:	90                   	nop
}
  8016f6:	c9                   	leave  
  8016f7:	c3                   	ret    

008016f8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016f8:	55                   	push   %ebp
  8016f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	6a 25                	push   $0x25
  801707:	e8 83 fb ff ff       	call   80128f <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
  801714:	83 ec 04             	sub    $0x4,%esp
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80171d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	50                   	push   %eax
  80172a:	6a 26                	push   $0x26
  80172c:	e8 5e fb ff ff       	call   80128f <syscall>
  801731:	83 c4 18             	add    $0x18,%esp
	return ;
  801734:	90                   	nop
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <rsttst>:
void rsttst()
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 28                	push   $0x28
  801746:	e8 44 fb ff ff       	call   80128f <syscall>
  80174b:	83 c4 18             	add    $0x18,%esp
	return ;
  80174e:	90                   	nop
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
  801754:	83 ec 04             	sub    $0x4,%esp
  801757:	8b 45 14             	mov    0x14(%ebp),%eax
  80175a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80175d:	8b 55 18             	mov    0x18(%ebp),%edx
  801760:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801764:	52                   	push   %edx
  801765:	50                   	push   %eax
  801766:	ff 75 10             	pushl  0x10(%ebp)
  801769:	ff 75 0c             	pushl  0xc(%ebp)
  80176c:	ff 75 08             	pushl  0x8(%ebp)
  80176f:	6a 27                	push   $0x27
  801771:	e8 19 fb ff ff       	call   80128f <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
	return ;
  801779:	90                   	nop
}
  80177a:	c9                   	leave  
  80177b:	c3                   	ret    

0080177c <chktst>:
void chktst(uint32 n)
{
  80177c:	55                   	push   %ebp
  80177d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	ff 75 08             	pushl  0x8(%ebp)
  80178a:	6a 29                	push   $0x29
  80178c:	e8 fe fa ff ff       	call   80128f <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
	return ;
  801794:	90                   	nop
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <inctst>:

void inctst()
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 2a                	push   $0x2a
  8017a6:	e8 e4 fa ff ff       	call   80128f <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ae:	90                   	nop
}
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <gettst>:
uint32 gettst()
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 2b                	push   $0x2b
  8017c0:	e8 ca fa ff ff       	call   80128f <syscall>
  8017c5:	83 c4 18             	add    $0x18,%esp
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
  8017cd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 2c                	push   $0x2c
  8017dc:	e8 ae fa ff ff       	call   80128f <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
  8017e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017e7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017eb:	75 07                	jne    8017f4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f2:	eb 05                	jmp    8017f9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
  8017fe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 2c                	push   $0x2c
  80180d:	e8 7d fa ff ff       	call   80128f <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
  801815:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801818:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80181c:	75 07                	jne    801825 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80181e:	b8 01 00 00 00       	mov    $0x1,%eax
  801823:	eb 05                	jmp    80182a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801825:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182a:	c9                   	leave  
  80182b:	c3                   	ret    

0080182c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80182c:	55                   	push   %ebp
  80182d:	89 e5                	mov    %esp,%ebp
  80182f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 2c                	push   $0x2c
  80183e:	e8 4c fa ff ff       	call   80128f <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
  801846:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801849:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80184d:	75 07                	jne    801856 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80184f:	b8 01 00 00 00       	mov    $0x1,%eax
  801854:	eb 05                	jmp    80185b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801856:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185b:	c9                   	leave  
  80185c:	c3                   	ret    

0080185d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80185d:	55                   	push   %ebp
  80185e:	89 e5                	mov    %esp,%ebp
  801860:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 2c                	push   $0x2c
  80186f:	e8 1b fa ff ff       	call   80128f <syscall>
  801874:	83 c4 18             	add    $0x18,%esp
  801877:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80187a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80187e:	75 07                	jne    801887 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801880:	b8 01 00 00 00       	mov    $0x1,%eax
  801885:	eb 05                	jmp    80188c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801887:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	ff 75 08             	pushl  0x8(%ebp)
  80189c:	6a 2d                	push   $0x2d
  80189e:	e8 ec f9 ff ff       	call   80128f <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a6:	90                   	nop
}
  8018a7:	c9                   	leave  
  8018a8:	c3                   	ret    

008018a9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
  8018ac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8018af:	8d 45 10             	lea    0x10(%ebp),%eax
  8018b2:	83 c0 04             	add    $0x4,%eax
  8018b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8018b8:	a1 60 50 88 00       	mov    0x885060,%eax
  8018bd:	85 c0                	test   %eax,%eax
  8018bf:	74 16                	je     8018d7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8018c1:	a1 60 50 88 00       	mov    0x885060,%eax
  8018c6:	83 ec 08             	sub    $0x8,%esp
  8018c9:	50                   	push   %eax
  8018ca:	68 00 22 80 00       	push   $0x802200
  8018cf:	e8 28 ea ff ff       	call   8002fc <cprintf>
  8018d4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8018d7:	a1 00 30 80 00       	mov    0x803000,%eax
  8018dc:	ff 75 0c             	pushl  0xc(%ebp)
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	50                   	push   %eax
  8018e3:	68 05 22 80 00       	push   $0x802205
  8018e8:	e8 0f ea ff ff       	call   8002fc <cprintf>
  8018ed:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8018f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f3:	83 ec 08             	sub    $0x8,%esp
  8018f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8018f9:	50                   	push   %eax
  8018fa:	e8 92 e9 ff ff       	call   800291 <vcprintf>
  8018ff:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801902:	83 ec 08             	sub    $0x8,%esp
  801905:	6a 00                	push   $0x0
  801907:	68 21 22 80 00       	push   $0x802221
  80190c:	e8 80 e9 ff ff       	call   800291 <vcprintf>
  801911:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801914:	e8 01 e9 ff ff       	call   80021a <exit>

	// should not return here
	while (1) ;
  801919:	eb fe                	jmp    801919 <_panic+0x70>

0080191b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
  80191e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801921:	a1 20 30 80 00       	mov    0x803020,%eax
  801926:	8b 50 74             	mov    0x74(%eax),%edx
  801929:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192c:	39 c2                	cmp    %eax,%edx
  80192e:	74 14                	je     801944 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801930:	83 ec 04             	sub    $0x4,%esp
  801933:	68 24 22 80 00       	push   $0x802224
  801938:	6a 26                	push   $0x26
  80193a:	68 70 22 80 00       	push   $0x802270
  80193f:	e8 65 ff ff ff       	call   8018a9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801944:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80194b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801952:	e9 c2 00 00 00       	jmp    801a19 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801957:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80195a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	85 c0                	test   %eax,%eax
  80196a:	75 08                	jne    801974 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80196c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80196f:	e9 a2 00 00 00       	jmp    801a16 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801974:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80197b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801982:	eb 69                	jmp    8019ed <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801984:	a1 20 30 80 00       	mov    0x803020,%eax
  801989:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80198f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801992:	89 d0                	mov    %edx,%eax
  801994:	01 c0                	add    %eax,%eax
  801996:	01 d0                	add    %edx,%eax
  801998:	c1 e0 02             	shl    $0x2,%eax
  80199b:	01 c8                	add    %ecx,%eax
  80199d:	8a 40 04             	mov    0x4(%eax),%al
  8019a0:	84 c0                	test   %al,%al
  8019a2:	75 46                	jne    8019ea <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8019a9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8019af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8019b2:	89 d0                	mov    %edx,%eax
  8019b4:	01 c0                	add    %eax,%eax
  8019b6:	01 d0                	add    %edx,%eax
  8019b8:	c1 e0 02             	shl    $0x2,%eax
  8019bb:	01 c8                	add    %ecx,%eax
  8019bd:	8b 00                	mov    (%eax),%eax
  8019bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8019c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8019ca:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8019cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019cf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8019d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d9:	01 c8                	add    %ecx,%eax
  8019db:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019dd:	39 c2                	cmp    %eax,%edx
  8019df:	75 09                	jne    8019ea <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8019e1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019e8:	eb 12                	jmp    8019fc <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ea:	ff 45 e8             	incl   -0x18(%ebp)
  8019ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8019f2:	8b 50 74             	mov    0x74(%eax),%edx
  8019f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019f8:	39 c2                	cmp    %eax,%edx
  8019fa:	77 88                	ja     801984 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a00:	75 14                	jne    801a16 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801a02:	83 ec 04             	sub    $0x4,%esp
  801a05:	68 7c 22 80 00       	push   $0x80227c
  801a0a:	6a 3a                	push   $0x3a
  801a0c:	68 70 22 80 00       	push   $0x802270
  801a11:	e8 93 fe ff ff       	call   8018a9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801a16:	ff 45 f0             	incl   -0x10(%ebp)
  801a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a1c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801a1f:	0f 8c 32 ff ff ff    	jl     801957 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a25:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a2c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801a33:	eb 26                	jmp    801a5b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801a35:	a1 20 30 80 00       	mov    0x803020,%eax
  801a3a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a40:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a43:	89 d0                	mov    %edx,%eax
  801a45:	01 c0                	add    %eax,%eax
  801a47:	01 d0                	add    %edx,%eax
  801a49:	c1 e0 02             	shl    $0x2,%eax
  801a4c:	01 c8                	add    %ecx,%eax
  801a4e:	8a 40 04             	mov    0x4(%eax),%al
  801a51:	3c 01                	cmp    $0x1,%al
  801a53:	75 03                	jne    801a58 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801a55:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a58:	ff 45 e0             	incl   -0x20(%ebp)
  801a5b:	a1 20 30 80 00       	mov    0x803020,%eax
  801a60:	8b 50 74             	mov    0x74(%eax),%edx
  801a63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a66:	39 c2                	cmp    %eax,%edx
  801a68:	77 cb                	ja     801a35 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a6d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a70:	74 14                	je     801a86 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801a72:	83 ec 04             	sub    $0x4,%esp
  801a75:	68 d0 22 80 00       	push   $0x8022d0
  801a7a:	6a 44                	push   $0x44
  801a7c:	68 70 22 80 00       	push   $0x802270
  801a81:	e8 23 fe ff ff       	call   8018a9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a86:	90                   	nop
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    
  801a89:	66 90                	xchg   %ax,%ax
  801a8b:	90                   	nop

00801a8c <__udivdi3>:
  801a8c:	55                   	push   %ebp
  801a8d:	57                   	push   %edi
  801a8e:	56                   	push   %esi
  801a8f:	53                   	push   %ebx
  801a90:	83 ec 1c             	sub    $0x1c,%esp
  801a93:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a97:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a9b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a9f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801aa3:	89 ca                	mov    %ecx,%edx
  801aa5:	89 f8                	mov    %edi,%eax
  801aa7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801aab:	85 f6                	test   %esi,%esi
  801aad:	75 2d                	jne    801adc <__udivdi3+0x50>
  801aaf:	39 cf                	cmp    %ecx,%edi
  801ab1:	77 65                	ja     801b18 <__udivdi3+0x8c>
  801ab3:	89 fd                	mov    %edi,%ebp
  801ab5:	85 ff                	test   %edi,%edi
  801ab7:	75 0b                	jne    801ac4 <__udivdi3+0x38>
  801ab9:	b8 01 00 00 00       	mov    $0x1,%eax
  801abe:	31 d2                	xor    %edx,%edx
  801ac0:	f7 f7                	div    %edi
  801ac2:	89 c5                	mov    %eax,%ebp
  801ac4:	31 d2                	xor    %edx,%edx
  801ac6:	89 c8                	mov    %ecx,%eax
  801ac8:	f7 f5                	div    %ebp
  801aca:	89 c1                	mov    %eax,%ecx
  801acc:	89 d8                	mov    %ebx,%eax
  801ace:	f7 f5                	div    %ebp
  801ad0:	89 cf                	mov    %ecx,%edi
  801ad2:	89 fa                	mov    %edi,%edx
  801ad4:	83 c4 1c             	add    $0x1c,%esp
  801ad7:	5b                   	pop    %ebx
  801ad8:	5e                   	pop    %esi
  801ad9:	5f                   	pop    %edi
  801ada:	5d                   	pop    %ebp
  801adb:	c3                   	ret    
  801adc:	39 ce                	cmp    %ecx,%esi
  801ade:	77 28                	ja     801b08 <__udivdi3+0x7c>
  801ae0:	0f bd fe             	bsr    %esi,%edi
  801ae3:	83 f7 1f             	xor    $0x1f,%edi
  801ae6:	75 40                	jne    801b28 <__udivdi3+0x9c>
  801ae8:	39 ce                	cmp    %ecx,%esi
  801aea:	72 0a                	jb     801af6 <__udivdi3+0x6a>
  801aec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801af0:	0f 87 9e 00 00 00    	ja     801b94 <__udivdi3+0x108>
  801af6:	b8 01 00 00 00       	mov    $0x1,%eax
  801afb:	89 fa                	mov    %edi,%edx
  801afd:	83 c4 1c             	add    $0x1c,%esp
  801b00:	5b                   	pop    %ebx
  801b01:	5e                   	pop    %esi
  801b02:	5f                   	pop    %edi
  801b03:	5d                   	pop    %ebp
  801b04:	c3                   	ret    
  801b05:	8d 76 00             	lea    0x0(%esi),%esi
  801b08:	31 ff                	xor    %edi,%edi
  801b0a:	31 c0                	xor    %eax,%eax
  801b0c:	89 fa                	mov    %edi,%edx
  801b0e:	83 c4 1c             	add    $0x1c,%esp
  801b11:	5b                   	pop    %ebx
  801b12:	5e                   	pop    %esi
  801b13:	5f                   	pop    %edi
  801b14:	5d                   	pop    %ebp
  801b15:	c3                   	ret    
  801b16:	66 90                	xchg   %ax,%ax
  801b18:	89 d8                	mov    %ebx,%eax
  801b1a:	f7 f7                	div    %edi
  801b1c:	31 ff                	xor    %edi,%edi
  801b1e:	89 fa                	mov    %edi,%edx
  801b20:	83 c4 1c             	add    $0x1c,%esp
  801b23:	5b                   	pop    %ebx
  801b24:	5e                   	pop    %esi
  801b25:	5f                   	pop    %edi
  801b26:	5d                   	pop    %ebp
  801b27:	c3                   	ret    
  801b28:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b2d:	89 eb                	mov    %ebp,%ebx
  801b2f:	29 fb                	sub    %edi,%ebx
  801b31:	89 f9                	mov    %edi,%ecx
  801b33:	d3 e6                	shl    %cl,%esi
  801b35:	89 c5                	mov    %eax,%ebp
  801b37:	88 d9                	mov    %bl,%cl
  801b39:	d3 ed                	shr    %cl,%ebp
  801b3b:	89 e9                	mov    %ebp,%ecx
  801b3d:	09 f1                	or     %esi,%ecx
  801b3f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b43:	89 f9                	mov    %edi,%ecx
  801b45:	d3 e0                	shl    %cl,%eax
  801b47:	89 c5                	mov    %eax,%ebp
  801b49:	89 d6                	mov    %edx,%esi
  801b4b:	88 d9                	mov    %bl,%cl
  801b4d:	d3 ee                	shr    %cl,%esi
  801b4f:	89 f9                	mov    %edi,%ecx
  801b51:	d3 e2                	shl    %cl,%edx
  801b53:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b57:	88 d9                	mov    %bl,%cl
  801b59:	d3 e8                	shr    %cl,%eax
  801b5b:	09 c2                	or     %eax,%edx
  801b5d:	89 d0                	mov    %edx,%eax
  801b5f:	89 f2                	mov    %esi,%edx
  801b61:	f7 74 24 0c          	divl   0xc(%esp)
  801b65:	89 d6                	mov    %edx,%esi
  801b67:	89 c3                	mov    %eax,%ebx
  801b69:	f7 e5                	mul    %ebp
  801b6b:	39 d6                	cmp    %edx,%esi
  801b6d:	72 19                	jb     801b88 <__udivdi3+0xfc>
  801b6f:	74 0b                	je     801b7c <__udivdi3+0xf0>
  801b71:	89 d8                	mov    %ebx,%eax
  801b73:	31 ff                	xor    %edi,%edi
  801b75:	e9 58 ff ff ff       	jmp    801ad2 <__udivdi3+0x46>
  801b7a:	66 90                	xchg   %ax,%ax
  801b7c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b80:	89 f9                	mov    %edi,%ecx
  801b82:	d3 e2                	shl    %cl,%edx
  801b84:	39 c2                	cmp    %eax,%edx
  801b86:	73 e9                	jae    801b71 <__udivdi3+0xe5>
  801b88:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b8b:	31 ff                	xor    %edi,%edi
  801b8d:	e9 40 ff ff ff       	jmp    801ad2 <__udivdi3+0x46>
  801b92:	66 90                	xchg   %ax,%ax
  801b94:	31 c0                	xor    %eax,%eax
  801b96:	e9 37 ff ff ff       	jmp    801ad2 <__udivdi3+0x46>
  801b9b:	90                   	nop

00801b9c <__umoddi3>:
  801b9c:	55                   	push   %ebp
  801b9d:	57                   	push   %edi
  801b9e:	56                   	push   %esi
  801b9f:	53                   	push   %ebx
  801ba0:	83 ec 1c             	sub    $0x1c,%esp
  801ba3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ba7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801baf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bb3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bb7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bbb:	89 f3                	mov    %esi,%ebx
  801bbd:	89 fa                	mov    %edi,%edx
  801bbf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bc3:	89 34 24             	mov    %esi,(%esp)
  801bc6:	85 c0                	test   %eax,%eax
  801bc8:	75 1a                	jne    801be4 <__umoddi3+0x48>
  801bca:	39 f7                	cmp    %esi,%edi
  801bcc:	0f 86 a2 00 00 00    	jbe    801c74 <__umoddi3+0xd8>
  801bd2:	89 c8                	mov    %ecx,%eax
  801bd4:	89 f2                	mov    %esi,%edx
  801bd6:	f7 f7                	div    %edi
  801bd8:	89 d0                	mov    %edx,%eax
  801bda:	31 d2                	xor    %edx,%edx
  801bdc:	83 c4 1c             	add    $0x1c,%esp
  801bdf:	5b                   	pop    %ebx
  801be0:	5e                   	pop    %esi
  801be1:	5f                   	pop    %edi
  801be2:	5d                   	pop    %ebp
  801be3:	c3                   	ret    
  801be4:	39 f0                	cmp    %esi,%eax
  801be6:	0f 87 ac 00 00 00    	ja     801c98 <__umoddi3+0xfc>
  801bec:	0f bd e8             	bsr    %eax,%ebp
  801bef:	83 f5 1f             	xor    $0x1f,%ebp
  801bf2:	0f 84 ac 00 00 00    	je     801ca4 <__umoddi3+0x108>
  801bf8:	bf 20 00 00 00       	mov    $0x20,%edi
  801bfd:	29 ef                	sub    %ebp,%edi
  801bff:	89 fe                	mov    %edi,%esi
  801c01:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c05:	89 e9                	mov    %ebp,%ecx
  801c07:	d3 e0                	shl    %cl,%eax
  801c09:	89 d7                	mov    %edx,%edi
  801c0b:	89 f1                	mov    %esi,%ecx
  801c0d:	d3 ef                	shr    %cl,%edi
  801c0f:	09 c7                	or     %eax,%edi
  801c11:	89 e9                	mov    %ebp,%ecx
  801c13:	d3 e2                	shl    %cl,%edx
  801c15:	89 14 24             	mov    %edx,(%esp)
  801c18:	89 d8                	mov    %ebx,%eax
  801c1a:	d3 e0                	shl    %cl,%eax
  801c1c:	89 c2                	mov    %eax,%edx
  801c1e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c22:	d3 e0                	shl    %cl,%eax
  801c24:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c28:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c2c:	89 f1                	mov    %esi,%ecx
  801c2e:	d3 e8                	shr    %cl,%eax
  801c30:	09 d0                	or     %edx,%eax
  801c32:	d3 eb                	shr    %cl,%ebx
  801c34:	89 da                	mov    %ebx,%edx
  801c36:	f7 f7                	div    %edi
  801c38:	89 d3                	mov    %edx,%ebx
  801c3a:	f7 24 24             	mull   (%esp)
  801c3d:	89 c6                	mov    %eax,%esi
  801c3f:	89 d1                	mov    %edx,%ecx
  801c41:	39 d3                	cmp    %edx,%ebx
  801c43:	0f 82 87 00 00 00    	jb     801cd0 <__umoddi3+0x134>
  801c49:	0f 84 91 00 00 00    	je     801ce0 <__umoddi3+0x144>
  801c4f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c53:	29 f2                	sub    %esi,%edx
  801c55:	19 cb                	sbb    %ecx,%ebx
  801c57:	89 d8                	mov    %ebx,%eax
  801c59:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c5d:	d3 e0                	shl    %cl,%eax
  801c5f:	89 e9                	mov    %ebp,%ecx
  801c61:	d3 ea                	shr    %cl,%edx
  801c63:	09 d0                	or     %edx,%eax
  801c65:	89 e9                	mov    %ebp,%ecx
  801c67:	d3 eb                	shr    %cl,%ebx
  801c69:	89 da                	mov    %ebx,%edx
  801c6b:	83 c4 1c             	add    $0x1c,%esp
  801c6e:	5b                   	pop    %ebx
  801c6f:	5e                   	pop    %esi
  801c70:	5f                   	pop    %edi
  801c71:	5d                   	pop    %ebp
  801c72:	c3                   	ret    
  801c73:	90                   	nop
  801c74:	89 fd                	mov    %edi,%ebp
  801c76:	85 ff                	test   %edi,%edi
  801c78:	75 0b                	jne    801c85 <__umoddi3+0xe9>
  801c7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7f:	31 d2                	xor    %edx,%edx
  801c81:	f7 f7                	div    %edi
  801c83:	89 c5                	mov    %eax,%ebp
  801c85:	89 f0                	mov    %esi,%eax
  801c87:	31 d2                	xor    %edx,%edx
  801c89:	f7 f5                	div    %ebp
  801c8b:	89 c8                	mov    %ecx,%eax
  801c8d:	f7 f5                	div    %ebp
  801c8f:	89 d0                	mov    %edx,%eax
  801c91:	e9 44 ff ff ff       	jmp    801bda <__umoddi3+0x3e>
  801c96:	66 90                	xchg   %ax,%ax
  801c98:	89 c8                	mov    %ecx,%eax
  801c9a:	89 f2                	mov    %esi,%edx
  801c9c:	83 c4 1c             	add    $0x1c,%esp
  801c9f:	5b                   	pop    %ebx
  801ca0:	5e                   	pop    %esi
  801ca1:	5f                   	pop    %edi
  801ca2:	5d                   	pop    %ebp
  801ca3:	c3                   	ret    
  801ca4:	3b 04 24             	cmp    (%esp),%eax
  801ca7:	72 06                	jb     801caf <__umoddi3+0x113>
  801ca9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cad:	77 0f                	ja     801cbe <__umoddi3+0x122>
  801caf:	89 f2                	mov    %esi,%edx
  801cb1:	29 f9                	sub    %edi,%ecx
  801cb3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cb7:	89 14 24             	mov    %edx,(%esp)
  801cba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cbe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cc2:	8b 14 24             	mov    (%esp),%edx
  801cc5:	83 c4 1c             	add    $0x1c,%esp
  801cc8:	5b                   	pop    %ebx
  801cc9:	5e                   	pop    %esi
  801cca:	5f                   	pop    %edi
  801ccb:	5d                   	pop    %ebp
  801ccc:	c3                   	ret    
  801ccd:	8d 76 00             	lea    0x0(%esi),%esi
  801cd0:	2b 04 24             	sub    (%esp),%eax
  801cd3:	19 fa                	sbb    %edi,%edx
  801cd5:	89 d1                	mov    %edx,%ecx
  801cd7:	89 c6                	mov    %eax,%esi
  801cd9:	e9 71 ff ff ff       	jmp    801c4f <__umoddi3+0xb3>
  801cde:	66 90                	xchg   %ax,%ax
  801ce0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ce4:	72 ea                	jb     801cd0 <__umoddi3+0x134>
  801ce6:	89 d9                	mov    %ebx,%ecx
  801ce8:	e9 62 ff ff ff       	jmp    801c4f <__umoddi3+0xb3>
