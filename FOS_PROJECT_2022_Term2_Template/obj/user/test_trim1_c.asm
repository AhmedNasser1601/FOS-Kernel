
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
  80003e:	e8 51 12 00 00       	call   801294 <sys_calculate_free_frames>
  800043:	a3 0c 30 80 00       	mov    %eax,0x80300c
	memFramesToAllocate = (remainingfreeframes+0);
  800048:	a1 0c 30 80 00       	mov    0x80300c,%eax
  80004d:	a3 1c 30 80 00       	mov    %eax,0x80301c

	requiredMemFrames = sys_calculate_required_frames(USER_HEAP_START, memFramesToAllocate*PAGE_SIZE);
  800052:	a1 1c 30 80 00       	mov    0x80301c,%eax
  800057:	c1 e0 0c             	shl    $0xc,%eax
  80005a:	83 ec 08             	sub    $0x8,%esp
  80005d:	50                   	push   %eax
  80005e:	68 00 00 00 80       	push   $0x80000000
  800063:	e8 11 12 00 00       	call   801279 <sys_calculate_required_frames>
  800068:	83 c4 10             	add    $0x10,%esp
  80006b:	a3 10 30 80 00       	mov    %eax,0x803010
	extraFramesNeeded = requiredMemFrames - remainingfreeframes;
  800070:	8b 15 10 30 80 00    	mov    0x803010,%edx
  800076:	a1 0c 30 80 00       	mov    0x80300c,%eax
  80007b:	29 c2                	sub    %eax,%edx
  80007d:	89 d0                	mov    %edx,%eax
  80007f:	a3 18 30 80 00       	mov    %eax,0x803018
	
	//cprintf("remaining frames = %d\n",remainingfreeframes);
	//cprintf("frames desired to be allocated = %d\n",memFramesToAllocate);
	//cprintf("req frames = %d\n",requiredMemFrames);
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
  800084:	a1 1c 30 80 00       	mov    0x80301c,%eax
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
  8000cd:	a1 18 30 80 00       	mov    0x803018,%eax
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
  800109:	68 a0 1b 80 00       	push   $0x801ba0
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
  80011f:	e8 a5 10 00 00       	call   8011c9 <sys_getenvindex>
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
  80014a:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80014f:	a1 04 30 80 00       	mov    0x803004,%eax
  800154:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80015a:	84 c0                	test   %al,%al
  80015c:	74 0f                	je     80016d <libmain+0x54>
		binaryname = myEnv->prog_name;
  80015e:	a1 04 30 80 00       	mov    0x803004,%eax
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
  80018e:	e8 d1 11 00 00       	call   801364 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	68 e0 1b 80 00       	push   $0x801be0
  80019b:	e8 5c 01 00 00       	call   8002fc <cprintf>
  8001a0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001a3:	a1 04 30 80 00       	mov    0x803004,%eax
  8001a8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001ae:	a1 04 30 80 00       	mov    0x803004,%eax
  8001b3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001b9:	83 ec 04             	sub    $0x4,%esp
  8001bc:	52                   	push   %edx
  8001bd:	50                   	push   %eax
  8001be:	68 08 1c 80 00       	push   $0x801c08
  8001c3:	e8 34 01 00 00       	call   8002fc <cprintf>
  8001c8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001cb:	a1 04 30 80 00       	mov    0x803004,%eax
  8001d0:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001d6:	83 ec 08             	sub    $0x8,%esp
  8001d9:	50                   	push   %eax
  8001da:	68 2d 1c 80 00       	push   $0x801c2d
  8001df:	e8 18 01 00 00       	call   8002fc <cprintf>
  8001e4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	68 e0 1b 80 00       	push   $0x801be0
  8001ef:	e8 08 01 00 00       	call   8002fc <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001f7:	e8 82 11 00 00       	call   80137e <sys_enable_interrupt>

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
  80020f:	e8 81 0f 00 00       	call   801195 <sys_env_destroy>
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
  800220:	e8 d6 0f 00 00       	call   8011fb <sys_env_exit>
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
  800253:	a0 08 30 80 00       	mov    0x803008,%al
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
  80026e:	e8 e0 0e 00 00       	call   801153 <sys_cputs>
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
  8002c8:	a0 08 30 80 00       	mov    0x803008,%al
  8002cd:	0f b6 c0             	movzbl %al,%eax
  8002d0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	50                   	push   %eax
  8002da:	52                   	push   %edx
  8002db:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002e1:	83 c0 08             	add    $0x8,%eax
  8002e4:	50                   	push   %eax
  8002e5:	e8 69 0e 00 00       	call   801153 <sys_cputs>
  8002ea:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ed:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
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
  800302:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
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
  80032f:	e8 30 10 00 00       	call   801364 <sys_disable_interrupt>
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
  80034f:	e8 2a 10 00 00       	call   80137e <sys_enable_interrupt>
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
  800399:	e8 86 15 00 00       	call   801924 <__udivdi3>
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
  8003e9:	e8 46 16 00 00       	call   801a34 <__umoddi3>
  8003ee:	83 c4 10             	add    $0x10,%esp
  8003f1:	05 74 1e 80 00       	add    $0x801e74,%eax
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
  800544:	8b 04 85 98 1e 80 00 	mov    0x801e98(,%eax,4),%eax
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
  800625:	8b 34 9d e0 1c 80 00 	mov    0x801ce0(,%ebx,4),%esi
  80062c:	85 f6                	test   %esi,%esi
  80062e:	75 19                	jne    800649 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800630:	53                   	push   %ebx
  800631:	68 85 1e 80 00       	push   $0x801e85
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
  80064a:	68 8e 1e 80 00       	push   $0x801e8e
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
  800677:	be 91 1e 80 00       	mov    $0x801e91,%esi
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
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80108c:	83 ec 04             	sub    $0x4,%esp
  80108f:	68 f0 1f 80 00       	push   $0x801ff0
  801094:	6a 19                	push   $0x19
  801096:	68 15 20 80 00       	push   $0x802015
  80109b:	e8 a2 06 00 00       	call   801742 <_panic>

008010a0 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8010a0:	55                   	push   %ebp
  8010a1:	89 e5                	mov    %esp,%ebp
  8010a3:	83 ec 18             	sub    $0x18,%esp
  8010a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8010ac:	83 ec 04             	sub    $0x4,%esp
  8010af:	68 24 20 80 00       	push   $0x802024
  8010b4:	6a 30                	push   $0x30
  8010b6:	68 15 20 80 00       	push   $0x802015
  8010bb:	e8 82 06 00 00       	call   801742 <_panic>

008010c0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8010c6:	83 ec 04             	sub    $0x4,%esp
  8010c9:	68 43 20 80 00       	push   $0x802043
  8010ce:	6a 36                	push   $0x36
  8010d0:	68 15 20 80 00       	push   $0x802015
  8010d5:	e8 68 06 00 00       	call   801742 <_panic>

008010da <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
  8010dd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8010e0:	83 ec 04             	sub    $0x4,%esp
  8010e3:	68 60 20 80 00       	push   $0x802060
  8010e8:	6a 48                	push   $0x48
  8010ea:	68 15 20 80 00       	push   $0x802015
  8010ef:	e8 4e 06 00 00       	call   801742 <_panic>

008010f4 <sfree>:

}


void sfree(void* virtual_address)
{
  8010f4:	55                   	push   %ebp
  8010f5:	89 e5                	mov    %esp,%ebp
  8010f7:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8010fa:	83 ec 04             	sub    $0x4,%esp
  8010fd:	68 83 20 80 00       	push   $0x802083
  801102:	6a 53                	push   $0x53
  801104:	68 15 20 80 00       	push   $0x802015
  801109:	e8 34 06 00 00       	call   801742 <_panic>

0080110e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80110e:	55                   	push   %ebp
  80110f:	89 e5                	mov    %esp,%ebp
  801111:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801114:	83 ec 04             	sub    $0x4,%esp
  801117:	68 a0 20 80 00       	push   $0x8020a0
  80111c:	6a 6c                	push   $0x6c
  80111e:	68 15 20 80 00       	push   $0x802015
  801123:	e8 1a 06 00 00       	call   801742 <_panic>

00801128 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	57                   	push   %edi
  80112c:	56                   	push   %esi
  80112d:	53                   	push   %ebx
  80112e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8b 55 0c             	mov    0xc(%ebp),%edx
  801137:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80113a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80113d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801140:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801143:	cd 30                	int    $0x30
  801145:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801148:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80114b:	83 c4 10             	add    $0x10,%esp
  80114e:	5b                   	pop    %ebx
  80114f:	5e                   	pop    %esi
  801150:	5f                   	pop    %edi
  801151:	5d                   	pop    %ebp
  801152:	c3                   	ret    

00801153 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
  801156:	83 ec 04             	sub    $0x4,%esp
  801159:	8b 45 10             	mov    0x10(%ebp),%eax
  80115c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80115f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	52                   	push   %edx
  80116b:	ff 75 0c             	pushl  0xc(%ebp)
  80116e:	50                   	push   %eax
  80116f:	6a 00                	push   $0x0
  801171:	e8 b2 ff ff ff       	call   801128 <syscall>
  801176:	83 c4 18             	add    $0x18,%esp
}
  801179:	90                   	nop
  80117a:	c9                   	leave  
  80117b:	c3                   	ret    

0080117c <sys_cgetc>:

int
sys_cgetc(void)
{
  80117c:	55                   	push   %ebp
  80117d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	6a 01                	push   $0x1
  80118b:	e8 98 ff ff ff       	call   801128 <syscall>
  801190:	83 c4 18             	add    $0x18,%esp
}
  801193:	c9                   	leave  
  801194:	c3                   	ret    

00801195 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801195:	55                   	push   %ebp
  801196:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	6a 00                	push   $0x0
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 00                	push   $0x0
  8011a3:	50                   	push   %eax
  8011a4:	6a 05                	push   $0x5
  8011a6:	e8 7d ff ff ff       	call   801128 <syscall>
  8011ab:	83 c4 18             	add    $0x18,%esp
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 02                	push   $0x2
  8011bf:	e8 64 ff ff ff       	call   801128 <syscall>
  8011c4:	83 c4 18             	add    $0x18,%esp
}
  8011c7:	c9                   	leave  
  8011c8:	c3                   	ret    

008011c9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 03                	push   $0x3
  8011d8:	e8 4b ff ff ff       	call   801128 <syscall>
  8011dd:	83 c4 18             	add    $0x18,%esp
}
  8011e0:	c9                   	leave  
  8011e1:	c3                   	ret    

008011e2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011e2:	55                   	push   %ebp
  8011e3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	6a 04                	push   $0x4
  8011f1:	e8 32 ff ff ff       	call   801128 <syscall>
  8011f6:	83 c4 18             	add    $0x18,%esp
}
  8011f9:	c9                   	leave  
  8011fa:	c3                   	ret    

008011fb <sys_env_exit>:


void sys_env_exit(void)
{
  8011fb:	55                   	push   %ebp
  8011fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 06                	push   $0x6
  80120a:	e8 19 ff ff ff       	call   801128 <syscall>
  80120f:	83 c4 18             	add    $0x18,%esp
}
  801212:	90                   	nop
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801218:	8b 55 0c             	mov    0xc(%ebp),%edx
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	6a 00                	push   $0x0
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	52                   	push   %edx
  801225:	50                   	push   %eax
  801226:	6a 07                	push   $0x7
  801228:	e8 fb fe ff ff       	call   801128 <syscall>
  80122d:	83 c4 18             	add    $0x18,%esp
}
  801230:	c9                   	leave  
  801231:	c3                   	ret    

00801232 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
  801235:	56                   	push   %esi
  801236:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801237:	8b 75 18             	mov    0x18(%ebp),%esi
  80123a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80123d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801240:	8b 55 0c             	mov    0xc(%ebp),%edx
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	56                   	push   %esi
  801247:	53                   	push   %ebx
  801248:	51                   	push   %ecx
  801249:	52                   	push   %edx
  80124a:	50                   	push   %eax
  80124b:	6a 08                	push   $0x8
  80124d:	e8 d6 fe ff ff       	call   801128 <syscall>
  801252:	83 c4 18             	add    $0x18,%esp
}
  801255:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801258:	5b                   	pop    %ebx
  801259:	5e                   	pop    %esi
  80125a:	5d                   	pop    %ebp
  80125b:	c3                   	ret    

0080125c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80125f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	52                   	push   %edx
  80126c:	50                   	push   %eax
  80126d:	6a 09                	push   $0x9
  80126f:	e8 b4 fe ff ff       	call   801128 <syscall>
  801274:	83 c4 18             	add    $0x18,%esp
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	ff 75 0c             	pushl  0xc(%ebp)
  801285:	ff 75 08             	pushl  0x8(%ebp)
  801288:	6a 0a                	push   $0xa
  80128a:	e8 99 fe ff ff       	call   801128 <syscall>
  80128f:	83 c4 18             	add    $0x18,%esp
}
  801292:	c9                   	leave  
  801293:	c3                   	ret    

00801294 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801294:	55                   	push   %ebp
  801295:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 0b                	push   $0xb
  8012a3:	e8 80 fe ff ff       	call   801128 <syscall>
  8012a8:	83 c4 18             	add    $0x18,%esp
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 0c                	push   $0xc
  8012bc:	e8 67 fe ff ff       	call   801128 <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 0d                	push   $0xd
  8012d5:	e8 4e fe ff ff       	call   801128 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	ff 75 0c             	pushl  0xc(%ebp)
  8012eb:	ff 75 08             	pushl  0x8(%ebp)
  8012ee:	6a 11                	push   $0x11
  8012f0:	e8 33 fe ff ff       	call   801128 <syscall>
  8012f5:	83 c4 18             	add    $0x18,%esp
	return;
  8012f8:	90                   	nop
}
  8012f9:	c9                   	leave  
  8012fa:	c3                   	ret    

008012fb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8012fb:	55                   	push   %ebp
  8012fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	ff 75 0c             	pushl  0xc(%ebp)
  801307:	ff 75 08             	pushl  0x8(%ebp)
  80130a:	6a 12                	push   $0x12
  80130c:	e8 17 fe ff ff       	call   801128 <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
	return ;
  801314:	90                   	nop
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 0e                	push   $0xe
  801326:	e8 fd fd ff ff       	call   801128 <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	ff 75 08             	pushl  0x8(%ebp)
  80133e:	6a 0f                	push   $0xf
  801340:	e8 e3 fd ff ff       	call   801128 <syscall>
  801345:	83 c4 18             	add    $0x18,%esp
}
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 10                	push   $0x10
  801359:	e8 ca fd ff ff       	call   801128 <syscall>
  80135e:	83 c4 18             	add    $0x18,%esp
}
  801361:	90                   	nop
  801362:	c9                   	leave  
  801363:	c3                   	ret    

00801364 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801364:	55                   	push   %ebp
  801365:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 14                	push   $0x14
  801373:	e8 b0 fd ff ff       	call   801128 <syscall>
  801378:	83 c4 18             	add    $0x18,%esp
}
  80137b:	90                   	nop
  80137c:	c9                   	leave  
  80137d:	c3                   	ret    

0080137e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	6a 15                	push   $0x15
  80138d:	e8 96 fd ff ff       	call   801128 <syscall>
  801392:	83 c4 18             	add    $0x18,%esp
}
  801395:	90                   	nop
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_cputc>:


void
sys_cputc(const char c)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
  80139b:	83 ec 04             	sub    $0x4,%esp
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8013a4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	50                   	push   %eax
  8013b1:	6a 16                	push   $0x16
  8013b3:	e8 70 fd ff ff       	call   801128 <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	90                   	nop
  8013bc:	c9                   	leave  
  8013bd:	c3                   	ret    

008013be <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013be:	55                   	push   %ebp
  8013bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 17                	push   $0x17
  8013cd:	e8 56 fd ff ff       	call   801128 <syscall>
  8013d2:	83 c4 18             	add    $0x18,%esp
}
  8013d5:	90                   	nop
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	ff 75 0c             	pushl  0xc(%ebp)
  8013e7:	50                   	push   %eax
  8013e8:	6a 18                	push   $0x18
  8013ea:	e8 39 fd ff ff       	call   801128 <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	52                   	push   %edx
  801404:	50                   	push   %eax
  801405:	6a 1b                	push   $0x1b
  801407:	e8 1c fd ff ff       	call   801128 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801414:	8b 55 0c             	mov    0xc(%ebp),%edx
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	52                   	push   %edx
  801421:	50                   	push   %eax
  801422:	6a 19                	push   $0x19
  801424:	e8 ff fc ff ff       	call   801128 <syscall>
  801429:	83 c4 18             	add    $0x18,%esp
}
  80142c:	90                   	nop
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801432:	8b 55 0c             	mov    0xc(%ebp),%edx
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	52                   	push   %edx
  80143f:	50                   	push   %eax
  801440:	6a 1a                	push   $0x1a
  801442:	e8 e1 fc ff ff       	call   801128 <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	90                   	nop
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
  801450:	83 ec 04             	sub    $0x4,%esp
  801453:	8b 45 10             	mov    0x10(%ebp),%eax
  801456:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801459:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80145c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	6a 00                	push   $0x0
  801465:	51                   	push   %ecx
  801466:	52                   	push   %edx
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	50                   	push   %eax
  80146b:	6a 1c                	push   $0x1c
  80146d:	e8 b6 fc ff ff       	call   801128 <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80147a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	52                   	push   %edx
  801487:	50                   	push   %eax
  801488:	6a 1d                	push   $0x1d
  80148a:	e8 99 fc ff ff       	call   801128 <syscall>
  80148f:	83 c4 18             	add    $0x18,%esp
}
  801492:	c9                   	leave  
  801493:	c3                   	ret    

00801494 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801494:	55                   	push   %ebp
  801495:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801497:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80149a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	51                   	push   %ecx
  8014a5:	52                   	push   %edx
  8014a6:	50                   	push   %eax
  8014a7:	6a 1e                	push   $0x1e
  8014a9:	e8 7a fc ff ff       	call   801128 <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8014b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	52                   	push   %edx
  8014c3:	50                   	push   %eax
  8014c4:	6a 1f                	push   $0x1f
  8014c6:	e8 5d fc ff ff       	call   801128 <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 20                	push   $0x20
  8014df:	e8 44 fc ff ff       	call   801128 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	ff 75 10             	pushl  0x10(%ebp)
  8014f6:	ff 75 0c             	pushl  0xc(%ebp)
  8014f9:	50                   	push   %eax
  8014fa:	6a 21                	push   $0x21
  8014fc:	e8 27 fc ff ff       	call   801128 <syscall>
  801501:	83 c4 18             	add    $0x18,%esp
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	50                   	push   %eax
  801515:	6a 22                	push   $0x22
  801517:	e8 0c fc ff ff       	call   801128 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
}
  80151f:	90                   	nop
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801525:	8b 45 08             	mov    0x8(%ebp),%eax
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	50                   	push   %eax
  801531:	6a 23                	push   $0x23
  801533:	e8 f0 fb ff ff       	call   801128 <syscall>
  801538:	83 c4 18             	add    $0x18,%esp
}
  80153b:	90                   	nop
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
  801541:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801544:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801547:	8d 50 04             	lea    0x4(%eax),%edx
  80154a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	52                   	push   %edx
  801554:	50                   	push   %eax
  801555:	6a 24                	push   $0x24
  801557:	e8 cc fb ff ff       	call   801128 <syscall>
  80155c:	83 c4 18             	add    $0x18,%esp
	return result;
  80155f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801562:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801565:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801568:	89 01                	mov    %eax,(%ecx)
  80156a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	c9                   	leave  
  801571:	c2 04 00             	ret    $0x4

00801574 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801574:	55                   	push   %ebp
  801575:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	ff 75 10             	pushl  0x10(%ebp)
  80157e:	ff 75 0c             	pushl  0xc(%ebp)
  801581:	ff 75 08             	pushl  0x8(%ebp)
  801584:	6a 13                	push   $0x13
  801586:	e8 9d fb ff ff       	call   801128 <syscall>
  80158b:	83 c4 18             	add    $0x18,%esp
	return ;
  80158e:	90                   	nop
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_rcr2>:
uint32 sys_rcr2()
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 25                	push   $0x25
  8015a0:	e8 83 fb ff ff       	call   801128 <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 04             	sub    $0x4,%esp
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015b6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	50                   	push   %eax
  8015c3:	6a 26                	push   $0x26
  8015c5:	e8 5e fb ff ff       	call   801128 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8015cd:	90                   	nop
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <rsttst>:
void rsttst()
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 28                	push   $0x28
  8015df:	e8 44 fb ff ff       	call   801128 <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e7:	90                   	nop
}
  8015e8:	c9                   	leave  
  8015e9:	c3                   	ret    

008015ea <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8015ea:	55                   	push   %ebp
  8015eb:	89 e5                	mov    %esp,%ebp
  8015ed:	83 ec 04             	sub    $0x4,%esp
  8015f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8015f6:	8b 55 18             	mov    0x18(%ebp),%edx
  8015f9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015fd:	52                   	push   %edx
  8015fe:	50                   	push   %eax
  8015ff:	ff 75 10             	pushl  0x10(%ebp)
  801602:	ff 75 0c             	pushl  0xc(%ebp)
  801605:	ff 75 08             	pushl  0x8(%ebp)
  801608:	6a 27                	push   $0x27
  80160a:	e8 19 fb ff ff       	call   801128 <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
	return ;
  801612:	90                   	nop
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <chktst>:
void chktst(uint32 n)
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	ff 75 08             	pushl  0x8(%ebp)
  801623:	6a 29                	push   $0x29
  801625:	e8 fe fa ff ff       	call   801128 <syscall>
  80162a:	83 c4 18             	add    $0x18,%esp
	return ;
  80162d:	90                   	nop
}
  80162e:	c9                   	leave  
  80162f:	c3                   	ret    

00801630 <inctst>:

void inctst()
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 2a                	push   $0x2a
  80163f:	e8 e4 fa ff ff       	call   801128 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
	return ;
  801647:	90                   	nop
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <gettst>:
uint32 gettst()
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 2b                	push   $0x2b
  801659:	e8 ca fa ff ff       	call   801128 <syscall>
  80165e:	83 c4 18             	add    $0x18,%esp
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 2c                	push   $0x2c
  801675:	e8 ae fa ff ff       	call   801128 <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
  80167d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801680:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801684:	75 07                	jne    80168d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801686:	b8 01 00 00 00       	mov    $0x1,%eax
  80168b:	eb 05                	jmp    801692 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80168d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
  801697:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 2c                	push   $0x2c
  8016a6:	e8 7d fa ff ff       	call   801128 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
  8016ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8016b1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8016b5:	75 07                	jne    8016be <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8016b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8016bc:	eb 05                	jmp    8016c3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016c3:	c9                   	leave  
  8016c4:	c3                   	ret    

008016c5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
  8016c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 2c                	push   $0x2c
  8016d7:	e8 4c fa ff ff       	call   801128 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
  8016df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016e2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016e6:	75 07                	jne    8016ef <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ed:	eb 05                	jmp    8016f4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8016ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
  8016f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 2c                	push   $0x2c
  801708:	e8 1b fa ff ff       	call   801128 <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
  801710:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801713:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801717:	75 07                	jne    801720 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801719:	b8 01 00 00 00       	mov    $0x1,%eax
  80171e:	eb 05                	jmp    801725 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801720:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	ff 75 08             	pushl  0x8(%ebp)
  801735:	6a 2d                	push   $0x2d
  801737:	e8 ec f9 ff ff       	call   801128 <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
	return ;
  80173f:	90                   	nop
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
  801745:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801748:	8d 45 10             	lea    0x10(%ebp),%eax
  80174b:	83 c0 04             	add    $0x4,%eax
  80174e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801751:	a1 24 30 80 00       	mov    0x803024,%eax
  801756:	85 c0                	test   %eax,%eax
  801758:	74 16                	je     801770 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80175a:	a1 24 30 80 00       	mov    0x803024,%eax
  80175f:	83 ec 08             	sub    $0x8,%esp
  801762:	50                   	push   %eax
  801763:	68 c8 20 80 00       	push   $0x8020c8
  801768:	e8 8f eb ff ff       	call   8002fc <cprintf>
  80176d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801770:	a1 00 30 80 00       	mov    0x803000,%eax
  801775:	ff 75 0c             	pushl  0xc(%ebp)
  801778:	ff 75 08             	pushl  0x8(%ebp)
  80177b:	50                   	push   %eax
  80177c:	68 cd 20 80 00       	push   $0x8020cd
  801781:	e8 76 eb ff ff       	call   8002fc <cprintf>
  801786:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801789:	8b 45 10             	mov    0x10(%ebp),%eax
  80178c:	83 ec 08             	sub    $0x8,%esp
  80178f:	ff 75 f4             	pushl  -0xc(%ebp)
  801792:	50                   	push   %eax
  801793:	e8 f9 ea ff ff       	call   800291 <vcprintf>
  801798:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80179b:	83 ec 08             	sub    $0x8,%esp
  80179e:	6a 00                	push   $0x0
  8017a0:	68 e9 20 80 00       	push   $0x8020e9
  8017a5:	e8 e7 ea ff ff       	call   800291 <vcprintf>
  8017aa:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8017ad:	e8 68 ea ff ff       	call   80021a <exit>

	// should not return here
	while (1) ;
  8017b2:	eb fe                	jmp    8017b2 <_panic+0x70>

008017b4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8017ba:	a1 04 30 80 00       	mov    0x803004,%eax
  8017bf:	8b 50 74             	mov    0x74(%eax),%edx
  8017c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c5:	39 c2                	cmp    %eax,%edx
  8017c7:	74 14                	je     8017dd <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8017c9:	83 ec 04             	sub    $0x4,%esp
  8017cc:	68 ec 20 80 00       	push   $0x8020ec
  8017d1:	6a 26                	push   $0x26
  8017d3:	68 38 21 80 00       	push   $0x802138
  8017d8:	e8 65 ff ff ff       	call   801742 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8017dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8017e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017eb:	e9 c2 00 00 00       	jmp    8018b2 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8017f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	01 d0                	add    %edx,%eax
  8017ff:	8b 00                	mov    (%eax),%eax
  801801:	85 c0                	test   %eax,%eax
  801803:	75 08                	jne    80180d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801805:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801808:	e9 a2 00 00 00       	jmp    8018af <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80180d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801814:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80181b:	eb 69                	jmp    801886 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80181d:	a1 04 30 80 00       	mov    0x803004,%eax
  801822:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801828:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80182b:	89 d0                	mov    %edx,%eax
  80182d:	01 c0                	add    %eax,%eax
  80182f:	01 d0                	add    %edx,%eax
  801831:	c1 e0 02             	shl    $0x2,%eax
  801834:	01 c8                	add    %ecx,%eax
  801836:	8a 40 04             	mov    0x4(%eax),%al
  801839:	84 c0                	test   %al,%al
  80183b:	75 46                	jne    801883 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80183d:	a1 04 30 80 00       	mov    0x803004,%eax
  801842:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801848:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80184b:	89 d0                	mov    %edx,%eax
  80184d:	01 c0                	add    %eax,%eax
  80184f:	01 d0                	add    %edx,%eax
  801851:	c1 e0 02             	shl    $0x2,%eax
  801854:	01 c8                	add    %ecx,%eax
  801856:	8b 00                	mov    (%eax),%eax
  801858:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80185b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80185e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801863:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801865:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801868:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	01 c8                	add    %ecx,%eax
  801874:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801876:	39 c2                	cmp    %eax,%edx
  801878:	75 09                	jne    801883 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80187a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801881:	eb 12                	jmp    801895 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801883:	ff 45 e8             	incl   -0x18(%ebp)
  801886:	a1 04 30 80 00       	mov    0x803004,%eax
  80188b:	8b 50 74             	mov    0x74(%eax),%edx
  80188e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801891:	39 c2                	cmp    %eax,%edx
  801893:	77 88                	ja     80181d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801895:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801899:	75 14                	jne    8018af <CheckWSWithoutLastIndex+0xfb>
			panic(
  80189b:	83 ec 04             	sub    $0x4,%esp
  80189e:	68 44 21 80 00       	push   $0x802144
  8018a3:	6a 3a                	push   $0x3a
  8018a5:	68 38 21 80 00       	push   $0x802138
  8018aa:	e8 93 fe ff ff       	call   801742 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8018af:	ff 45 f0             	incl   -0x10(%ebp)
  8018b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8018b8:	0f 8c 32 ff ff ff    	jl     8017f0 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8018be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8018cc:	eb 26                	jmp    8018f4 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8018ce:	a1 04 30 80 00       	mov    0x803004,%eax
  8018d3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8018d9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018dc:	89 d0                	mov    %edx,%eax
  8018de:	01 c0                	add    %eax,%eax
  8018e0:	01 d0                	add    %edx,%eax
  8018e2:	c1 e0 02             	shl    $0x2,%eax
  8018e5:	01 c8                	add    %ecx,%eax
  8018e7:	8a 40 04             	mov    0x4(%eax),%al
  8018ea:	3c 01                	cmp    $0x1,%al
  8018ec:	75 03                	jne    8018f1 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8018ee:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018f1:	ff 45 e0             	incl   -0x20(%ebp)
  8018f4:	a1 04 30 80 00       	mov    0x803004,%eax
  8018f9:	8b 50 74             	mov    0x74(%eax),%edx
  8018fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018ff:	39 c2                	cmp    %eax,%edx
  801901:	77 cb                	ja     8018ce <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801903:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801906:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801909:	74 14                	je     80191f <CheckWSWithoutLastIndex+0x16b>
		panic(
  80190b:	83 ec 04             	sub    $0x4,%esp
  80190e:	68 98 21 80 00       	push   $0x802198
  801913:	6a 44                	push   $0x44
  801915:	68 38 21 80 00       	push   $0x802138
  80191a:	e8 23 fe ff ff       	call   801742 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80191f:	90                   	nop
  801920:	c9                   	leave  
  801921:	c3                   	ret    
  801922:	66 90                	xchg   %ax,%ax

00801924 <__udivdi3>:
  801924:	55                   	push   %ebp
  801925:	57                   	push   %edi
  801926:	56                   	push   %esi
  801927:	53                   	push   %ebx
  801928:	83 ec 1c             	sub    $0x1c,%esp
  80192b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80192f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801933:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801937:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80193b:	89 ca                	mov    %ecx,%edx
  80193d:	89 f8                	mov    %edi,%eax
  80193f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801943:	85 f6                	test   %esi,%esi
  801945:	75 2d                	jne    801974 <__udivdi3+0x50>
  801947:	39 cf                	cmp    %ecx,%edi
  801949:	77 65                	ja     8019b0 <__udivdi3+0x8c>
  80194b:	89 fd                	mov    %edi,%ebp
  80194d:	85 ff                	test   %edi,%edi
  80194f:	75 0b                	jne    80195c <__udivdi3+0x38>
  801951:	b8 01 00 00 00       	mov    $0x1,%eax
  801956:	31 d2                	xor    %edx,%edx
  801958:	f7 f7                	div    %edi
  80195a:	89 c5                	mov    %eax,%ebp
  80195c:	31 d2                	xor    %edx,%edx
  80195e:	89 c8                	mov    %ecx,%eax
  801960:	f7 f5                	div    %ebp
  801962:	89 c1                	mov    %eax,%ecx
  801964:	89 d8                	mov    %ebx,%eax
  801966:	f7 f5                	div    %ebp
  801968:	89 cf                	mov    %ecx,%edi
  80196a:	89 fa                	mov    %edi,%edx
  80196c:	83 c4 1c             	add    $0x1c,%esp
  80196f:	5b                   	pop    %ebx
  801970:	5e                   	pop    %esi
  801971:	5f                   	pop    %edi
  801972:	5d                   	pop    %ebp
  801973:	c3                   	ret    
  801974:	39 ce                	cmp    %ecx,%esi
  801976:	77 28                	ja     8019a0 <__udivdi3+0x7c>
  801978:	0f bd fe             	bsr    %esi,%edi
  80197b:	83 f7 1f             	xor    $0x1f,%edi
  80197e:	75 40                	jne    8019c0 <__udivdi3+0x9c>
  801980:	39 ce                	cmp    %ecx,%esi
  801982:	72 0a                	jb     80198e <__udivdi3+0x6a>
  801984:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801988:	0f 87 9e 00 00 00    	ja     801a2c <__udivdi3+0x108>
  80198e:	b8 01 00 00 00       	mov    $0x1,%eax
  801993:	89 fa                	mov    %edi,%edx
  801995:	83 c4 1c             	add    $0x1c,%esp
  801998:	5b                   	pop    %ebx
  801999:	5e                   	pop    %esi
  80199a:	5f                   	pop    %edi
  80199b:	5d                   	pop    %ebp
  80199c:	c3                   	ret    
  80199d:	8d 76 00             	lea    0x0(%esi),%esi
  8019a0:	31 ff                	xor    %edi,%edi
  8019a2:	31 c0                	xor    %eax,%eax
  8019a4:	89 fa                	mov    %edi,%edx
  8019a6:	83 c4 1c             	add    $0x1c,%esp
  8019a9:	5b                   	pop    %ebx
  8019aa:	5e                   	pop    %esi
  8019ab:	5f                   	pop    %edi
  8019ac:	5d                   	pop    %ebp
  8019ad:	c3                   	ret    
  8019ae:	66 90                	xchg   %ax,%ax
  8019b0:	89 d8                	mov    %ebx,%eax
  8019b2:	f7 f7                	div    %edi
  8019b4:	31 ff                	xor    %edi,%edi
  8019b6:	89 fa                	mov    %edi,%edx
  8019b8:	83 c4 1c             	add    $0x1c,%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5f                   	pop    %edi
  8019be:	5d                   	pop    %ebp
  8019bf:	c3                   	ret    
  8019c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019c5:	89 eb                	mov    %ebp,%ebx
  8019c7:	29 fb                	sub    %edi,%ebx
  8019c9:	89 f9                	mov    %edi,%ecx
  8019cb:	d3 e6                	shl    %cl,%esi
  8019cd:	89 c5                	mov    %eax,%ebp
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 ed                	shr    %cl,%ebp
  8019d3:	89 e9                	mov    %ebp,%ecx
  8019d5:	09 f1                	or     %esi,%ecx
  8019d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019db:	89 f9                	mov    %edi,%ecx
  8019dd:	d3 e0                	shl    %cl,%eax
  8019df:	89 c5                	mov    %eax,%ebp
  8019e1:	89 d6                	mov    %edx,%esi
  8019e3:	88 d9                	mov    %bl,%cl
  8019e5:	d3 ee                	shr    %cl,%esi
  8019e7:	89 f9                	mov    %edi,%ecx
  8019e9:	d3 e2                	shl    %cl,%edx
  8019eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019ef:	88 d9                	mov    %bl,%cl
  8019f1:	d3 e8                	shr    %cl,%eax
  8019f3:	09 c2                	or     %eax,%edx
  8019f5:	89 d0                	mov    %edx,%eax
  8019f7:	89 f2                	mov    %esi,%edx
  8019f9:	f7 74 24 0c          	divl   0xc(%esp)
  8019fd:	89 d6                	mov    %edx,%esi
  8019ff:	89 c3                	mov    %eax,%ebx
  801a01:	f7 e5                	mul    %ebp
  801a03:	39 d6                	cmp    %edx,%esi
  801a05:	72 19                	jb     801a20 <__udivdi3+0xfc>
  801a07:	74 0b                	je     801a14 <__udivdi3+0xf0>
  801a09:	89 d8                	mov    %ebx,%eax
  801a0b:	31 ff                	xor    %edi,%edi
  801a0d:	e9 58 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a12:	66 90                	xchg   %ax,%ax
  801a14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a18:	89 f9                	mov    %edi,%ecx
  801a1a:	d3 e2                	shl    %cl,%edx
  801a1c:	39 c2                	cmp    %eax,%edx
  801a1e:	73 e9                	jae    801a09 <__udivdi3+0xe5>
  801a20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a23:	31 ff                	xor    %edi,%edi
  801a25:	e9 40 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a2a:	66 90                	xchg   %ax,%ax
  801a2c:	31 c0                	xor    %eax,%eax
  801a2e:	e9 37 ff ff ff       	jmp    80196a <__udivdi3+0x46>
  801a33:	90                   	nop

00801a34 <__umoddi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a53:	89 f3                	mov    %esi,%ebx
  801a55:	89 fa                	mov    %edi,%edx
  801a57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a5b:	89 34 24             	mov    %esi,(%esp)
  801a5e:	85 c0                	test   %eax,%eax
  801a60:	75 1a                	jne    801a7c <__umoddi3+0x48>
  801a62:	39 f7                	cmp    %esi,%edi
  801a64:	0f 86 a2 00 00 00    	jbe    801b0c <__umoddi3+0xd8>
  801a6a:	89 c8                	mov    %ecx,%eax
  801a6c:	89 f2                	mov    %esi,%edx
  801a6e:	f7 f7                	div    %edi
  801a70:	89 d0                	mov    %edx,%eax
  801a72:	31 d2                	xor    %edx,%edx
  801a74:	83 c4 1c             	add    $0x1c,%esp
  801a77:	5b                   	pop    %ebx
  801a78:	5e                   	pop    %esi
  801a79:	5f                   	pop    %edi
  801a7a:	5d                   	pop    %ebp
  801a7b:	c3                   	ret    
  801a7c:	39 f0                	cmp    %esi,%eax
  801a7e:	0f 87 ac 00 00 00    	ja     801b30 <__umoddi3+0xfc>
  801a84:	0f bd e8             	bsr    %eax,%ebp
  801a87:	83 f5 1f             	xor    $0x1f,%ebp
  801a8a:	0f 84 ac 00 00 00    	je     801b3c <__umoddi3+0x108>
  801a90:	bf 20 00 00 00       	mov    $0x20,%edi
  801a95:	29 ef                	sub    %ebp,%edi
  801a97:	89 fe                	mov    %edi,%esi
  801a99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a9d:	89 e9                	mov    %ebp,%ecx
  801a9f:	d3 e0                	shl    %cl,%eax
  801aa1:	89 d7                	mov    %edx,%edi
  801aa3:	89 f1                	mov    %esi,%ecx
  801aa5:	d3 ef                	shr    %cl,%edi
  801aa7:	09 c7                	or     %eax,%edi
  801aa9:	89 e9                	mov    %ebp,%ecx
  801aab:	d3 e2                	shl    %cl,%edx
  801aad:	89 14 24             	mov    %edx,(%esp)
  801ab0:	89 d8                	mov    %ebx,%eax
  801ab2:	d3 e0                	shl    %cl,%eax
  801ab4:	89 c2                	mov    %eax,%edx
  801ab6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aba:	d3 e0                	shl    %cl,%eax
  801abc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ac0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ac4:	89 f1                	mov    %esi,%ecx
  801ac6:	d3 e8                	shr    %cl,%eax
  801ac8:	09 d0                	or     %edx,%eax
  801aca:	d3 eb                	shr    %cl,%ebx
  801acc:	89 da                	mov    %ebx,%edx
  801ace:	f7 f7                	div    %edi
  801ad0:	89 d3                	mov    %edx,%ebx
  801ad2:	f7 24 24             	mull   (%esp)
  801ad5:	89 c6                	mov    %eax,%esi
  801ad7:	89 d1                	mov    %edx,%ecx
  801ad9:	39 d3                	cmp    %edx,%ebx
  801adb:	0f 82 87 00 00 00    	jb     801b68 <__umoddi3+0x134>
  801ae1:	0f 84 91 00 00 00    	je     801b78 <__umoddi3+0x144>
  801ae7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801aeb:	29 f2                	sub    %esi,%edx
  801aed:	19 cb                	sbb    %ecx,%ebx
  801aef:	89 d8                	mov    %ebx,%eax
  801af1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801af5:	d3 e0                	shl    %cl,%eax
  801af7:	89 e9                	mov    %ebp,%ecx
  801af9:	d3 ea                	shr    %cl,%edx
  801afb:	09 d0                	or     %edx,%eax
  801afd:	89 e9                	mov    %ebp,%ecx
  801aff:	d3 eb                	shr    %cl,%ebx
  801b01:	89 da                	mov    %ebx,%edx
  801b03:	83 c4 1c             	add    $0x1c,%esp
  801b06:	5b                   	pop    %ebx
  801b07:	5e                   	pop    %esi
  801b08:	5f                   	pop    %edi
  801b09:	5d                   	pop    %ebp
  801b0a:	c3                   	ret    
  801b0b:	90                   	nop
  801b0c:	89 fd                	mov    %edi,%ebp
  801b0e:	85 ff                	test   %edi,%edi
  801b10:	75 0b                	jne    801b1d <__umoddi3+0xe9>
  801b12:	b8 01 00 00 00       	mov    $0x1,%eax
  801b17:	31 d2                	xor    %edx,%edx
  801b19:	f7 f7                	div    %edi
  801b1b:	89 c5                	mov    %eax,%ebp
  801b1d:	89 f0                	mov    %esi,%eax
  801b1f:	31 d2                	xor    %edx,%edx
  801b21:	f7 f5                	div    %ebp
  801b23:	89 c8                	mov    %ecx,%eax
  801b25:	f7 f5                	div    %ebp
  801b27:	89 d0                	mov    %edx,%eax
  801b29:	e9 44 ff ff ff       	jmp    801a72 <__umoddi3+0x3e>
  801b2e:	66 90                	xchg   %ax,%ax
  801b30:	89 c8                	mov    %ecx,%eax
  801b32:	89 f2                	mov    %esi,%edx
  801b34:	83 c4 1c             	add    $0x1c,%esp
  801b37:	5b                   	pop    %ebx
  801b38:	5e                   	pop    %esi
  801b39:	5f                   	pop    %edi
  801b3a:	5d                   	pop    %ebp
  801b3b:	c3                   	ret    
  801b3c:	3b 04 24             	cmp    (%esp),%eax
  801b3f:	72 06                	jb     801b47 <__umoddi3+0x113>
  801b41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b45:	77 0f                	ja     801b56 <__umoddi3+0x122>
  801b47:	89 f2                	mov    %esi,%edx
  801b49:	29 f9                	sub    %edi,%ecx
  801b4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b4f:	89 14 24             	mov    %edx,(%esp)
  801b52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b5a:	8b 14 24             	mov    (%esp),%edx
  801b5d:	83 c4 1c             	add    $0x1c,%esp
  801b60:	5b                   	pop    %ebx
  801b61:	5e                   	pop    %esi
  801b62:	5f                   	pop    %edi
  801b63:	5d                   	pop    %ebp
  801b64:	c3                   	ret    
  801b65:	8d 76 00             	lea    0x0(%esi),%esi
  801b68:	2b 04 24             	sub    (%esp),%eax
  801b6b:	19 fa                	sbb    %edi,%edx
  801b6d:	89 d1                	mov    %edx,%ecx
  801b6f:	89 c6                	mov    %eax,%esi
  801b71:	e9 71 ff ff ff       	jmp    801ae7 <__umoddi3+0xb3>
  801b76:	66 90                	xchg   %ax,%ax
  801b78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b7c:	72 ea                	jb     801b68 <__umoddi3+0x134>
  801b7e:	89 d9                	mov    %ebx,%ecx
  801b80:	e9 62 ff ff ff       	jmp    801ae7 <__umoddi3+0xb3>
