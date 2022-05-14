
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
  80003e:	e8 4e 14 00 00       	call   801491 <sys_calculate_free_frames>
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
  800063:	e8 0e 14 00 00       	call   801476 <sys_calculate_required_frames>
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
  800109:	68 a0 1d 80 00       	push   $0x801da0
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
  80011f:	e8 a2 12 00 00       	call   8013c6 <sys_getenvindex>
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
  80018e:	e8 ce 13 00 00       	call   801561 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	68 e0 1d 80 00       	push   $0x801de0
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
  8001be:	68 08 1e 80 00       	push   $0x801e08
  8001c3:	e8 34 01 00 00       	call   8002fc <cprintf>
  8001c8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d0:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001d6:	83 ec 08             	sub    $0x8,%esp
  8001d9:	50                   	push   %eax
  8001da:	68 2d 1e 80 00       	push   $0x801e2d
  8001df:	e8 18 01 00 00       	call   8002fc <cprintf>
  8001e4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	68 e0 1d 80 00       	push   $0x801de0
  8001ef:	e8 08 01 00 00       	call   8002fc <cprintf>
  8001f4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001f7:	e8 7f 13 00 00       	call   80157b <sys_enable_interrupt>

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
  80020f:	e8 7e 11 00 00       	call   801392 <sys_env_destroy>
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
  800220:	e8 d3 11 00 00       	call   8013f8 <sys_env_exit>
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
  80026e:	e8 dd 10 00 00       	call   801350 <sys_cputs>
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
  8002e5:	e8 66 10 00 00       	call   801350 <sys_cputs>
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
  80032f:	e8 2d 12 00 00       	call   801561 <sys_disable_interrupt>
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
  80034f:	e8 27 12 00 00       	call   80157b <sys_enable_interrupt>
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
  800399:	e8 82 17 00 00       	call   801b20 <__udivdi3>
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
  8003e9:	e8 42 18 00 00       	call   801c30 <__umoddi3>
  8003ee:	83 c4 10             	add    $0x10,%esp
  8003f1:	05 74 20 80 00       	add    $0x802074,%eax
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
  800544:	8b 04 85 98 20 80 00 	mov    0x802098(,%eax,4),%eax
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
  800625:	8b 34 9d e0 1e 80 00 	mov    0x801ee0(,%ebx,4),%esi
  80062c:	85 f6                	test   %esi,%esi
  80062e:	75 19                	jne    800649 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800630:	53                   	push   %ebx
  800631:	68 85 20 80 00       	push   $0x802085
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
  80064a:	68 8e 20 80 00       	push   $0x80208e
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
  800677:	be 91 20 80 00       	mov    $0x802091,%esi
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
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  80108c:	e8 31 08 00 00       	call   8018c2 <sys_isUHeapPlacementStrategyNEXTFIT>
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
  8011d2:	e8 21 03 00 00       	call   8014f8 <sys_allocateMem>
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
  801213:	68 f0 21 80 00       	push   $0x8021f0
  801218:	6a 5a                	push   $0x5a
  80121a:	68 0f 22 80 00       	push   $0x80220f
  80121f:	e8 1b 07 00 00       	call   80193f <_panic>

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
  80122d:	68 1b 22 80 00       	push   $0x80221b
  801232:	6a 60                	push   $0x60
  801234:	68 0f 22 80 00       	push   $0x80220f
  801239:	e8 01 07 00 00       	call   80193f <_panic>

0080123e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
  801241:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801244:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80124b:	e9 8a 00 00 00       	jmp    8012da <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  801250:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801253:	8b 04 c5 60 30 88 00 	mov    0x883060(,%eax,8),%eax
  80125a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80125d:	75 78                	jne    8012d7 <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  80125f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801262:	8b 04 c5 60 30 88 00 	mov    0x883060(,%eax,8),%eax
  801269:	05 00 00 00 80       	add    $0x80000000,%eax
  80126e:	c1 e8 0c             	shr    $0xc,%eax
  801271:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801274:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801277:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  80127e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801281:	01 d0                	add    %edx,%eax
  801283:	85 c0                	test   %eax,%eax
  801285:	79 05                	jns    80128c <free+0x4e>
  801287:	05 ff 0f 00 00       	add    $0xfff,%eax
  80128c:	c1 f8 0c             	sar    $0xc,%eax
  80128f:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801292:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801295:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801298:	eb 19                	jmp    8012b3 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  80129a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80129d:	83 ec 08             	sub    $0x8,%esp
  8012a0:	50                   	push   %eax
  8012a1:	ff 75 f0             	pushl  -0x10(%ebp)
  8012a4:	e8 33 02 00 00       	call   8014dc <sys_freeMem>
  8012a9:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  8012ac:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  8012b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012b6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8012b9:	72 df                	jb     80129a <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  8012bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012be:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  8012c5:	00 00 00 00 
  8012c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012cc:	c7 04 c5 60 30 88 00 	movl   $0x0,0x883060(,%eax,8)
  8012d3:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  8012d7:	ff 45 f4             	incl   -0xc(%ebp)
  8012da:	a1 28 30 80 00       	mov    0x803028,%eax
  8012df:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  8012e2:	0f 8c 68 ff ff ff    	jl     801250 <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  8012e8:	90                   	nop
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sfree>:


void sfree(void* virtual_address)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8012f1:	83 ec 04             	sub    $0x4,%esp
  8012f4:	68 37 22 80 00       	push   $0x802237
  8012f9:	68 87 00 00 00       	push   $0x87
  8012fe:	68 0f 22 80 00       	push   $0x80220f
  801303:	e8 37 06 00 00       	call   80193f <_panic>

00801308 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80130e:	83 ec 04             	sub    $0x4,%esp
  801311:	68 54 22 80 00       	push   $0x802254
  801316:	68 9f 00 00 00       	push   $0x9f
  80131b:	68 0f 22 80 00       	push   $0x80220f
  801320:	e8 1a 06 00 00       	call   80193f <_panic>

00801325 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	57                   	push   %edi
  801329:	56                   	push   %esi
  80132a:	53                   	push   %ebx
  80132b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	8b 55 0c             	mov    0xc(%ebp),%edx
  801334:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801337:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80133a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80133d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801340:	cd 30                	int    $0x30
  801342:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801345:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801348:	83 c4 10             	add    $0x10,%esp
  80134b:	5b                   	pop    %ebx
  80134c:	5e                   	pop    %esi
  80134d:	5f                   	pop    %edi
  80134e:	5d                   	pop    %ebp
  80134f:	c3                   	ret    

00801350 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801350:	55                   	push   %ebp
  801351:	89 e5                	mov    %esp,%ebp
  801353:	83 ec 04             	sub    $0x4,%esp
  801356:	8b 45 10             	mov    0x10(%ebp),%eax
  801359:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80135c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	52                   	push   %edx
  801368:	ff 75 0c             	pushl  0xc(%ebp)
  80136b:	50                   	push   %eax
  80136c:	6a 00                	push   $0x0
  80136e:	e8 b2 ff ff ff       	call   801325 <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	90                   	nop
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <sys_cgetc>:

int
sys_cgetc(void)
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 01                	push   $0x1
  801388:	e8 98 ff ff ff       	call   801325 <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	50                   	push   %eax
  8013a1:	6a 05                	push   $0x5
  8013a3:	e8 7d ff ff ff       	call   801325 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 02                	push   $0x2
  8013bc:	e8 64 ff ff ff       	call   801325 <syscall>
  8013c1:	83 c4 18             	add    $0x18,%esp
}
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 03                	push   $0x3
  8013d5:	e8 4b ff ff ff       	call   801325 <syscall>
  8013da:	83 c4 18             	add    $0x18,%esp
}
  8013dd:	c9                   	leave  
  8013de:	c3                   	ret    

008013df <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 04                	push   $0x4
  8013ee:	e8 32 ff ff ff       	call   801325 <syscall>
  8013f3:	83 c4 18             	add    $0x18,%esp
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_env_exit>:


void sys_env_exit(void)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 06                	push   $0x6
  801407:	e8 19 ff ff ff       	call   801325 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	90                   	nop
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801415:	8b 55 0c             	mov    0xc(%ebp),%edx
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	52                   	push   %edx
  801422:	50                   	push   %eax
  801423:	6a 07                	push   $0x7
  801425:	e8 fb fe ff ff       	call   801325 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
  801432:	56                   	push   %esi
  801433:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801434:	8b 75 18             	mov    0x18(%ebp),%esi
  801437:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80143a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80143d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	56                   	push   %esi
  801444:	53                   	push   %ebx
  801445:	51                   	push   %ecx
  801446:	52                   	push   %edx
  801447:	50                   	push   %eax
  801448:	6a 08                	push   $0x8
  80144a:	e8 d6 fe ff ff       	call   801325 <syscall>
  80144f:	83 c4 18             	add    $0x18,%esp
}
  801452:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801455:	5b                   	pop    %ebx
  801456:	5e                   	pop    %esi
  801457:	5d                   	pop    %ebp
  801458:	c3                   	ret    

00801459 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80145c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	52                   	push   %edx
  801469:	50                   	push   %eax
  80146a:	6a 09                	push   $0x9
  80146c:	e8 b4 fe ff ff       	call   801325 <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
}
  801474:	c9                   	leave  
  801475:	c3                   	ret    

00801476 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	ff 75 0c             	pushl  0xc(%ebp)
  801482:	ff 75 08             	pushl  0x8(%ebp)
  801485:	6a 0a                	push   $0xa
  801487:	e8 99 fe ff ff       	call   801325 <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 0b                	push   $0xb
  8014a0:	e8 80 fe ff ff       	call   801325 <syscall>
  8014a5:	83 c4 18             	add    $0x18,%esp
}
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 0c                	push   $0xc
  8014b9:	e8 67 fe ff ff       	call   801325 <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
}
  8014c1:	c9                   	leave  
  8014c2:	c3                   	ret    

008014c3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014c3:	55                   	push   %ebp
  8014c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 0d                	push   $0xd
  8014d2:	e8 4e fe ff ff       	call   801325 <syscall>
  8014d7:	83 c4 18             	add    $0x18,%esp
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	ff 75 0c             	pushl  0xc(%ebp)
  8014e8:	ff 75 08             	pushl  0x8(%ebp)
  8014eb:	6a 11                	push   $0x11
  8014ed:	e8 33 fe ff ff       	call   801325 <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
	return;
  8014f5:	90                   	nop
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	ff 75 0c             	pushl  0xc(%ebp)
  801504:	ff 75 08             	pushl  0x8(%ebp)
  801507:	6a 12                	push   $0x12
  801509:	e8 17 fe ff ff       	call   801325 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
	return ;
  801511:	90                   	nop
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 0e                	push   $0xe
  801523:	e8 fd fd ff ff       	call   801325 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	ff 75 08             	pushl  0x8(%ebp)
  80153b:	6a 0f                	push   $0xf
  80153d:	e8 e3 fd ff ff       	call   801325 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 10                	push   $0x10
  801556:	e8 ca fd ff ff       	call   801325 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
}
  80155e:	90                   	nop
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 14                	push   $0x14
  801570:	e8 b0 fd ff ff       	call   801325 <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
}
  801578:	90                   	nop
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 15                	push   $0x15
  80158a:	e8 96 fd ff ff       	call   801325 <syscall>
  80158f:	83 c4 18             	add    $0x18,%esp
}
  801592:	90                   	nop
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <sys_cputc>:


void
sys_cputc(const char c)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 04             	sub    $0x4,%esp
  80159b:	8b 45 08             	mov    0x8(%ebp),%eax
  80159e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	50                   	push   %eax
  8015ae:	6a 16                	push   $0x16
  8015b0:	e8 70 fd ff ff       	call   801325 <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	90                   	nop
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 17                	push   $0x17
  8015ca:	e8 56 fd ff ff       	call   801325 <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
}
  8015d2:	90                   	nop
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	ff 75 0c             	pushl  0xc(%ebp)
  8015e4:	50                   	push   %eax
  8015e5:	6a 18                	push   $0x18
  8015e7:	e8 39 fd ff ff       	call   801325 <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	52                   	push   %edx
  801601:	50                   	push   %eax
  801602:	6a 1b                	push   $0x1b
  801604:	e8 1c fd ff ff       	call   801325 <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 19                	push   $0x19
  801621:	e8 ff fc ff ff       	call   801325 <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	90                   	nop
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	52                   	push   %edx
  80163c:	50                   	push   %eax
  80163d:	6a 1a                	push   $0x1a
  80163f:	e8 e1 fc ff ff       	call   801325 <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
}
  801647:	90                   	nop
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
  80164d:	83 ec 04             	sub    $0x4,%esp
  801650:	8b 45 10             	mov    0x10(%ebp),%eax
  801653:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801656:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801659:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80165d:	8b 45 08             	mov    0x8(%ebp),%eax
  801660:	6a 00                	push   $0x0
  801662:	51                   	push   %ecx
  801663:	52                   	push   %edx
  801664:	ff 75 0c             	pushl  0xc(%ebp)
  801667:	50                   	push   %eax
  801668:	6a 1c                	push   $0x1c
  80166a:	e8 b6 fc ff ff       	call   801325 <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801677:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	52                   	push   %edx
  801684:	50                   	push   %eax
  801685:	6a 1d                	push   $0x1d
  801687:	e8 99 fc ff ff       	call   801325 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
}
  80168f:	c9                   	leave  
  801690:	c3                   	ret    

00801691 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801691:	55                   	push   %ebp
  801692:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801694:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801697:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	51                   	push   %ecx
  8016a2:	52                   	push   %edx
  8016a3:	50                   	push   %eax
  8016a4:	6a 1e                	push   $0x1e
  8016a6:	e8 7a fc ff ff       	call   801325 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	52                   	push   %edx
  8016c0:	50                   	push   %eax
  8016c1:	6a 1f                	push   $0x1f
  8016c3:	e8 5d fc ff ff       	call   801325 <syscall>
  8016c8:	83 c4 18             	add    $0x18,%esp
}
  8016cb:	c9                   	leave  
  8016cc:	c3                   	ret    

008016cd <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016cd:	55                   	push   %ebp
  8016ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 20                	push   $0x20
  8016dc:	e8 44 fc ff ff       	call   801325 <syscall>
  8016e1:	83 c4 18             	add    $0x18,%esp
}
  8016e4:	c9                   	leave  
  8016e5:	c3                   	ret    

008016e6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8016e6:	55                   	push   %ebp
  8016e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	ff 75 10             	pushl  0x10(%ebp)
  8016f3:	ff 75 0c             	pushl  0xc(%ebp)
  8016f6:	50                   	push   %eax
  8016f7:	6a 21                	push   $0x21
  8016f9:	e8 27 fc ff ff       	call   801325 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	50                   	push   %eax
  801712:	6a 22                	push   $0x22
  801714:	e8 0c fc ff ff       	call   801325 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	90                   	nop
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	50                   	push   %eax
  80172e:	6a 23                	push   $0x23
  801730:	e8 f0 fb ff ff       	call   801325 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	90                   	nop
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
  80173e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801741:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801744:	8d 50 04             	lea    0x4(%eax),%edx
  801747:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	52                   	push   %edx
  801751:	50                   	push   %eax
  801752:	6a 24                	push   $0x24
  801754:	e8 cc fb ff ff       	call   801325 <syscall>
  801759:	83 c4 18             	add    $0x18,%esp
	return result;
  80175c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80175f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801762:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801765:	89 01                	mov    %eax,(%ecx)
  801767:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80176a:	8b 45 08             	mov    0x8(%ebp),%eax
  80176d:	c9                   	leave  
  80176e:	c2 04 00             	ret    $0x4

00801771 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	ff 75 10             	pushl  0x10(%ebp)
  80177b:	ff 75 0c             	pushl  0xc(%ebp)
  80177e:	ff 75 08             	pushl  0x8(%ebp)
  801781:	6a 13                	push   $0x13
  801783:	e8 9d fb ff ff       	call   801325 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
	return ;
  80178b:	90                   	nop
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    

0080178e <sys_rcr2>:
uint32 sys_rcr2()
{
  80178e:	55                   	push   %ebp
  80178f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 25                	push   $0x25
  80179d:	e8 83 fb ff ff       	call   801325 <syscall>
  8017a2:	83 c4 18             	add    $0x18,%esp
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
  8017aa:	83 ec 04             	sub    $0x4,%esp
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017b3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	50                   	push   %eax
  8017c0:	6a 26                	push   $0x26
  8017c2:	e8 5e fb ff ff       	call   801325 <syscall>
  8017c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ca:	90                   	nop
}
  8017cb:	c9                   	leave  
  8017cc:	c3                   	ret    

008017cd <rsttst>:
void rsttst()
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 28                	push   $0x28
  8017dc:	e8 44 fb ff ff       	call   801325 <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e4:	90                   	nop
}
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
  8017ea:	83 ec 04             	sub    $0x4,%esp
  8017ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8017f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017f3:	8b 55 18             	mov    0x18(%ebp),%edx
  8017f6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017fa:	52                   	push   %edx
  8017fb:	50                   	push   %eax
  8017fc:	ff 75 10             	pushl  0x10(%ebp)
  8017ff:	ff 75 0c             	pushl  0xc(%ebp)
  801802:	ff 75 08             	pushl  0x8(%ebp)
  801805:	6a 27                	push   $0x27
  801807:	e8 19 fb ff ff       	call   801325 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
	return ;
  80180f:	90                   	nop
}
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <chktst>:
void chktst(uint32 n)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	ff 75 08             	pushl  0x8(%ebp)
  801820:	6a 29                	push   $0x29
  801822:	e8 fe fa ff ff       	call   801325 <syscall>
  801827:	83 c4 18             	add    $0x18,%esp
	return ;
  80182a:	90                   	nop
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <inctst>:

void inctst()
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 2a                	push   $0x2a
  80183c:	e8 e4 fa ff ff       	call   801325 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
	return ;
  801844:	90                   	nop
}
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <gettst>:
uint32 gettst()
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 2b                	push   $0x2b
  801856:	e8 ca fa ff ff       	call   801325 <syscall>
  80185b:	83 c4 18             	add    $0x18,%esp
}
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
  801863:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 2c                	push   $0x2c
  801872:	e8 ae fa ff ff       	call   801325 <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
  80187a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80187d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801881:	75 07                	jne    80188a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801883:	b8 01 00 00 00       	mov    $0x1,%eax
  801888:	eb 05                	jmp    80188f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80188a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
  801894:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 2c                	push   $0x2c
  8018a3:	e8 7d fa ff ff       	call   801325 <syscall>
  8018a8:	83 c4 18             	add    $0x18,%esp
  8018ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018ae:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018b2:	75 07                	jne    8018bb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018b4:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b9:	eb 05                	jmp    8018c0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c0:	c9                   	leave  
  8018c1:	c3                   	ret    

008018c2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
  8018c5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 2c                	push   $0x2c
  8018d4:	e8 4c fa ff ff       	call   801325 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
  8018dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018df:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018e3:	75 07                	jne    8018ec <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ea:	eb 05                	jmp    8018f1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
  8018f6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 2c                	push   $0x2c
  801905:	e8 1b fa ff ff       	call   801325 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
  80190d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801910:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801914:	75 07                	jne    80191d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801916:	b8 01 00 00 00       	mov    $0x1,%eax
  80191b:	eb 05                	jmp    801922 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80191d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	ff 75 08             	pushl  0x8(%ebp)
  801932:	6a 2d                	push   $0x2d
  801934:	e8 ec f9 ff ff       	call   801325 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
	return ;
  80193c:	90                   	nop
}
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
  801942:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801945:	8d 45 10             	lea    0x10(%ebp),%eax
  801948:	83 c0 04             	add    $0x4,%eax
  80194b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80194e:	a1 60 30 98 00       	mov    0x983060,%eax
  801953:	85 c0                	test   %eax,%eax
  801955:	74 16                	je     80196d <_panic+0x2e>
		cprintf("%s: ", argv0);
  801957:	a1 60 30 98 00       	mov    0x983060,%eax
  80195c:	83 ec 08             	sub    $0x8,%esp
  80195f:	50                   	push   %eax
  801960:	68 7c 22 80 00       	push   $0x80227c
  801965:	e8 92 e9 ff ff       	call   8002fc <cprintf>
  80196a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80196d:	a1 00 30 80 00       	mov    0x803000,%eax
  801972:	ff 75 0c             	pushl  0xc(%ebp)
  801975:	ff 75 08             	pushl  0x8(%ebp)
  801978:	50                   	push   %eax
  801979:	68 81 22 80 00       	push   $0x802281
  80197e:	e8 79 e9 ff ff       	call   8002fc <cprintf>
  801983:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801986:	8b 45 10             	mov    0x10(%ebp),%eax
  801989:	83 ec 08             	sub    $0x8,%esp
  80198c:	ff 75 f4             	pushl  -0xc(%ebp)
  80198f:	50                   	push   %eax
  801990:	e8 fc e8 ff ff       	call   800291 <vcprintf>
  801995:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801998:	83 ec 08             	sub    $0x8,%esp
  80199b:	6a 00                	push   $0x0
  80199d:	68 9d 22 80 00       	push   $0x80229d
  8019a2:	e8 ea e8 ff ff       	call   800291 <vcprintf>
  8019a7:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8019aa:	e8 6b e8 ff ff       	call   80021a <exit>

	// should not return here
	while (1) ;
  8019af:	eb fe                	jmp    8019af <_panic+0x70>

008019b1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
  8019b4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8019b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8019bc:	8b 50 74             	mov    0x74(%eax),%edx
  8019bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c2:	39 c2                	cmp    %eax,%edx
  8019c4:	74 14                	je     8019da <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8019c6:	83 ec 04             	sub    $0x4,%esp
  8019c9:	68 a0 22 80 00       	push   $0x8022a0
  8019ce:	6a 26                	push   $0x26
  8019d0:	68 ec 22 80 00       	push   $0x8022ec
  8019d5:	e8 65 ff ff ff       	call   80193f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8019da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8019e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019e8:	e9 c2 00 00 00       	jmp    801aaf <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8019ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	01 d0                	add    %edx,%eax
  8019fc:	8b 00                	mov    (%eax),%eax
  8019fe:	85 c0                	test   %eax,%eax
  801a00:	75 08                	jne    801a0a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a02:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a05:	e9 a2 00 00 00       	jmp    801aac <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a0a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a11:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a18:	eb 69                	jmp    801a83 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a1a:	a1 20 30 80 00       	mov    0x803020,%eax
  801a1f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a25:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a28:	89 d0                	mov    %edx,%eax
  801a2a:	01 c0                	add    %eax,%eax
  801a2c:	01 d0                	add    %edx,%eax
  801a2e:	c1 e0 02             	shl    $0x2,%eax
  801a31:	01 c8                	add    %ecx,%eax
  801a33:	8a 40 04             	mov    0x4(%eax),%al
  801a36:	84 c0                	test   %al,%al
  801a38:	75 46                	jne    801a80 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a3a:	a1 20 30 80 00       	mov    0x803020,%eax
  801a3f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a45:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a48:	89 d0                	mov    %edx,%eax
  801a4a:	01 c0                	add    %eax,%eax
  801a4c:	01 d0                	add    %edx,%eax
  801a4e:	c1 e0 02             	shl    $0x2,%eax
  801a51:	01 c8                	add    %ecx,%eax
  801a53:	8b 00                	mov    (%eax),%eax
  801a55:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a58:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a60:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a65:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6f:	01 c8                	add    %ecx,%eax
  801a71:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a73:	39 c2                	cmp    %eax,%edx
  801a75:	75 09                	jne    801a80 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a77:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801a7e:	eb 12                	jmp    801a92 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a80:	ff 45 e8             	incl   -0x18(%ebp)
  801a83:	a1 20 30 80 00       	mov    0x803020,%eax
  801a88:	8b 50 74             	mov    0x74(%eax),%edx
  801a8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a8e:	39 c2                	cmp    %eax,%edx
  801a90:	77 88                	ja     801a1a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801a92:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a96:	75 14                	jne    801aac <CheckWSWithoutLastIndex+0xfb>
			panic(
  801a98:	83 ec 04             	sub    $0x4,%esp
  801a9b:	68 f8 22 80 00       	push   $0x8022f8
  801aa0:	6a 3a                	push   $0x3a
  801aa2:	68 ec 22 80 00       	push   $0x8022ec
  801aa7:	e8 93 fe ff ff       	call   80193f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801aac:	ff 45 f0             	incl   -0x10(%ebp)
  801aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ab2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ab5:	0f 8c 32 ff ff ff    	jl     8019ed <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801abb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ac2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ac9:	eb 26                	jmp    801af1 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801acb:	a1 20 30 80 00       	mov    0x803020,%eax
  801ad0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801ad6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ad9:	89 d0                	mov    %edx,%eax
  801adb:	01 c0                	add    %eax,%eax
  801add:	01 d0                	add    %edx,%eax
  801adf:	c1 e0 02             	shl    $0x2,%eax
  801ae2:	01 c8                	add    %ecx,%eax
  801ae4:	8a 40 04             	mov    0x4(%eax),%al
  801ae7:	3c 01                	cmp    $0x1,%al
  801ae9:	75 03                	jne    801aee <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801aeb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801aee:	ff 45 e0             	incl   -0x20(%ebp)
  801af1:	a1 20 30 80 00       	mov    0x803020,%eax
  801af6:	8b 50 74             	mov    0x74(%eax),%edx
  801af9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801afc:	39 c2                	cmp    %eax,%edx
  801afe:	77 cb                	ja     801acb <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b03:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b06:	74 14                	je     801b1c <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b08:	83 ec 04             	sub    $0x4,%esp
  801b0b:	68 4c 23 80 00       	push   $0x80234c
  801b10:	6a 44                	push   $0x44
  801b12:	68 ec 22 80 00       	push   $0x8022ec
  801b17:	e8 23 fe ff ff       	call   80193f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b1c:	90                   	nop
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    
  801b1f:	90                   	nop

00801b20 <__udivdi3>:
  801b20:	55                   	push   %ebp
  801b21:	57                   	push   %edi
  801b22:	56                   	push   %esi
  801b23:	53                   	push   %ebx
  801b24:	83 ec 1c             	sub    $0x1c,%esp
  801b27:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b2b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b33:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b37:	89 ca                	mov    %ecx,%edx
  801b39:	89 f8                	mov    %edi,%eax
  801b3b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b3f:	85 f6                	test   %esi,%esi
  801b41:	75 2d                	jne    801b70 <__udivdi3+0x50>
  801b43:	39 cf                	cmp    %ecx,%edi
  801b45:	77 65                	ja     801bac <__udivdi3+0x8c>
  801b47:	89 fd                	mov    %edi,%ebp
  801b49:	85 ff                	test   %edi,%edi
  801b4b:	75 0b                	jne    801b58 <__udivdi3+0x38>
  801b4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b52:	31 d2                	xor    %edx,%edx
  801b54:	f7 f7                	div    %edi
  801b56:	89 c5                	mov    %eax,%ebp
  801b58:	31 d2                	xor    %edx,%edx
  801b5a:	89 c8                	mov    %ecx,%eax
  801b5c:	f7 f5                	div    %ebp
  801b5e:	89 c1                	mov    %eax,%ecx
  801b60:	89 d8                	mov    %ebx,%eax
  801b62:	f7 f5                	div    %ebp
  801b64:	89 cf                	mov    %ecx,%edi
  801b66:	89 fa                	mov    %edi,%edx
  801b68:	83 c4 1c             	add    $0x1c,%esp
  801b6b:	5b                   	pop    %ebx
  801b6c:	5e                   	pop    %esi
  801b6d:	5f                   	pop    %edi
  801b6e:	5d                   	pop    %ebp
  801b6f:	c3                   	ret    
  801b70:	39 ce                	cmp    %ecx,%esi
  801b72:	77 28                	ja     801b9c <__udivdi3+0x7c>
  801b74:	0f bd fe             	bsr    %esi,%edi
  801b77:	83 f7 1f             	xor    $0x1f,%edi
  801b7a:	75 40                	jne    801bbc <__udivdi3+0x9c>
  801b7c:	39 ce                	cmp    %ecx,%esi
  801b7e:	72 0a                	jb     801b8a <__udivdi3+0x6a>
  801b80:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b84:	0f 87 9e 00 00 00    	ja     801c28 <__udivdi3+0x108>
  801b8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b8f:	89 fa                	mov    %edi,%edx
  801b91:	83 c4 1c             	add    $0x1c,%esp
  801b94:	5b                   	pop    %ebx
  801b95:	5e                   	pop    %esi
  801b96:	5f                   	pop    %edi
  801b97:	5d                   	pop    %ebp
  801b98:	c3                   	ret    
  801b99:	8d 76 00             	lea    0x0(%esi),%esi
  801b9c:	31 ff                	xor    %edi,%edi
  801b9e:	31 c0                	xor    %eax,%eax
  801ba0:	89 fa                	mov    %edi,%edx
  801ba2:	83 c4 1c             	add    $0x1c,%esp
  801ba5:	5b                   	pop    %ebx
  801ba6:	5e                   	pop    %esi
  801ba7:	5f                   	pop    %edi
  801ba8:	5d                   	pop    %ebp
  801ba9:	c3                   	ret    
  801baa:	66 90                	xchg   %ax,%ax
  801bac:	89 d8                	mov    %ebx,%eax
  801bae:	f7 f7                	div    %edi
  801bb0:	31 ff                	xor    %edi,%edi
  801bb2:	89 fa                	mov    %edi,%edx
  801bb4:	83 c4 1c             	add    $0x1c,%esp
  801bb7:	5b                   	pop    %ebx
  801bb8:	5e                   	pop    %esi
  801bb9:	5f                   	pop    %edi
  801bba:	5d                   	pop    %ebp
  801bbb:	c3                   	ret    
  801bbc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bc1:	89 eb                	mov    %ebp,%ebx
  801bc3:	29 fb                	sub    %edi,%ebx
  801bc5:	89 f9                	mov    %edi,%ecx
  801bc7:	d3 e6                	shl    %cl,%esi
  801bc9:	89 c5                	mov    %eax,%ebp
  801bcb:	88 d9                	mov    %bl,%cl
  801bcd:	d3 ed                	shr    %cl,%ebp
  801bcf:	89 e9                	mov    %ebp,%ecx
  801bd1:	09 f1                	or     %esi,%ecx
  801bd3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bd7:	89 f9                	mov    %edi,%ecx
  801bd9:	d3 e0                	shl    %cl,%eax
  801bdb:	89 c5                	mov    %eax,%ebp
  801bdd:	89 d6                	mov    %edx,%esi
  801bdf:	88 d9                	mov    %bl,%cl
  801be1:	d3 ee                	shr    %cl,%esi
  801be3:	89 f9                	mov    %edi,%ecx
  801be5:	d3 e2                	shl    %cl,%edx
  801be7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801beb:	88 d9                	mov    %bl,%cl
  801bed:	d3 e8                	shr    %cl,%eax
  801bef:	09 c2                	or     %eax,%edx
  801bf1:	89 d0                	mov    %edx,%eax
  801bf3:	89 f2                	mov    %esi,%edx
  801bf5:	f7 74 24 0c          	divl   0xc(%esp)
  801bf9:	89 d6                	mov    %edx,%esi
  801bfb:	89 c3                	mov    %eax,%ebx
  801bfd:	f7 e5                	mul    %ebp
  801bff:	39 d6                	cmp    %edx,%esi
  801c01:	72 19                	jb     801c1c <__udivdi3+0xfc>
  801c03:	74 0b                	je     801c10 <__udivdi3+0xf0>
  801c05:	89 d8                	mov    %ebx,%eax
  801c07:	31 ff                	xor    %edi,%edi
  801c09:	e9 58 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c14:	89 f9                	mov    %edi,%ecx
  801c16:	d3 e2                	shl    %cl,%edx
  801c18:	39 c2                	cmp    %eax,%edx
  801c1a:	73 e9                	jae    801c05 <__udivdi3+0xe5>
  801c1c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c1f:	31 ff                	xor    %edi,%edi
  801c21:	e9 40 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c26:	66 90                	xchg   %ax,%ax
  801c28:	31 c0                	xor    %eax,%eax
  801c2a:	e9 37 ff ff ff       	jmp    801b66 <__udivdi3+0x46>
  801c2f:	90                   	nop

00801c30 <__umoddi3>:
  801c30:	55                   	push   %ebp
  801c31:	57                   	push   %edi
  801c32:	56                   	push   %esi
  801c33:	53                   	push   %ebx
  801c34:	83 ec 1c             	sub    $0x1c,%esp
  801c37:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c3b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c43:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c4f:	89 f3                	mov    %esi,%ebx
  801c51:	89 fa                	mov    %edi,%edx
  801c53:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c57:	89 34 24             	mov    %esi,(%esp)
  801c5a:	85 c0                	test   %eax,%eax
  801c5c:	75 1a                	jne    801c78 <__umoddi3+0x48>
  801c5e:	39 f7                	cmp    %esi,%edi
  801c60:	0f 86 a2 00 00 00    	jbe    801d08 <__umoddi3+0xd8>
  801c66:	89 c8                	mov    %ecx,%eax
  801c68:	89 f2                	mov    %esi,%edx
  801c6a:	f7 f7                	div    %edi
  801c6c:	89 d0                	mov    %edx,%eax
  801c6e:	31 d2                	xor    %edx,%edx
  801c70:	83 c4 1c             	add    $0x1c,%esp
  801c73:	5b                   	pop    %ebx
  801c74:	5e                   	pop    %esi
  801c75:	5f                   	pop    %edi
  801c76:	5d                   	pop    %ebp
  801c77:	c3                   	ret    
  801c78:	39 f0                	cmp    %esi,%eax
  801c7a:	0f 87 ac 00 00 00    	ja     801d2c <__umoddi3+0xfc>
  801c80:	0f bd e8             	bsr    %eax,%ebp
  801c83:	83 f5 1f             	xor    $0x1f,%ebp
  801c86:	0f 84 ac 00 00 00    	je     801d38 <__umoddi3+0x108>
  801c8c:	bf 20 00 00 00       	mov    $0x20,%edi
  801c91:	29 ef                	sub    %ebp,%edi
  801c93:	89 fe                	mov    %edi,%esi
  801c95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c99:	89 e9                	mov    %ebp,%ecx
  801c9b:	d3 e0                	shl    %cl,%eax
  801c9d:	89 d7                	mov    %edx,%edi
  801c9f:	89 f1                	mov    %esi,%ecx
  801ca1:	d3 ef                	shr    %cl,%edi
  801ca3:	09 c7                	or     %eax,%edi
  801ca5:	89 e9                	mov    %ebp,%ecx
  801ca7:	d3 e2                	shl    %cl,%edx
  801ca9:	89 14 24             	mov    %edx,(%esp)
  801cac:	89 d8                	mov    %ebx,%eax
  801cae:	d3 e0                	shl    %cl,%eax
  801cb0:	89 c2                	mov    %eax,%edx
  801cb2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cb6:	d3 e0                	shl    %cl,%eax
  801cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cbc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cc0:	89 f1                	mov    %esi,%ecx
  801cc2:	d3 e8                	shr    %cl,%eax
  801cc4:	09 d0                	or     %edx,%eax
  801cc6:	d3 eb                	shr    %cl,%ebx
  801cc8:	89 da                	mov    %ebx,%edx
  801cca:	f7 f7                	div    %edi
  801ccc:	89 d3                	mov    %edx,%ebx
  801cce:	f7 24 24             	mull   (%esp)
  801cd1:	89 c6                	mov    %eax,%esi
  801cd3:	89 d1                	mov    %edx,%ecx
  801cd5:	39 d3                	cmp    %edx,%ebx
  801cd7:	0f 82 87 00 00 00    	jb     801d64 <__umoddi3+0x134>
  801cdd:	0f 84 91 00 00 00    	je     801d74 <__umoddi3+0x144>
  801ce3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ce7:	29 f2                	sub    %esi,%edx
  801ce9:	19 cb                	sbb    %ecx,%ebx
  801ceb:	89 d8                	mov    %ebx,%eax
  801ced:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cf1:	d3 e0                	shl    %cl,%eax
  801cf3:	89 e9                	mov    %ebp,%ecx
  801cf5:	d3 ea                	shr    %cl,%edx
  801cf7:	09 d0                	or     %edx,%eax
  801cf9:	89 e9                	mov    %ebp,%ecx
  801cfb:	d3 eb                	shr    %cl,%ebx
  801cfd:	89 da                	mov    %ebx,%edx
  801cff:	83 c4 1c             	add    $0x1c,%esp
  801d02:	5b                   	pop    %ebx
  801d03:	5e                   	pop    %esi
  801d04:	5f                   	pop    %edi
  801d05:	5d                   	pop    %ebp
  801d06:	c3                   	ret    
  801d07:	90                   	nop
  801d08:	89 fd                	mov    %edi,%ebp
  801d0a:	85 ff                	test   %edi,%edi
  801d0c:	75 0b                	jne    801d19 <__umoddi3+0xe9>
  801d0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d13:	31 d2                	xor    %edx,%edx
  801d15:	f7 f7                	div    %edi
  801d17:	89 c5                	mov    %eax,%ebp
  801d19:	89 f0                	mov    %esi,%eax
  801d1b:	31 d2                	xor    %edx,%edx
  801d1d:	f7 f5                	div    %ebp
  801d1f:	89 c8                	mov    %ecx,%eax
  801d21:	f7 f5                	div    %ebp
  801d23:	89 d0                	mov    %edx,%eax
  801d25:	e9 44 ff ff ff       	jmp    801c6e <__umoddi3+0x3e>
  801d2a:	66 90                	xchg   %ax,%ax
  801d2c:	89 c8                	mov    %ecx,%eax
  801d2e:	89 f2                	mov    %esi,%edx
  801d30:	83 c4 1c             	add    $0x1c,%esp
  801d33:	5b                   	pop    %ebx
  801d34:	5e                   	pop    %esi
  801d35:	5f                   	pop    %edi
  801d36:	5d                   	pop    %ebp
  801d37:	c3                   	ret    
  801d38:	3b 04 24             	cmp    (%esp),%eax
  801d3b:	72 06                	jb     801d43 <__umoddi3+0x113>
  801d3d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d41:	77 0f                	ja     801d52 <__umoddi3+0x122>
  801d43:	89 f2                	mov    %esi,%edx
  801d45:	29 f9                	sub    %edi,%ecx
  801d47:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d4b:	89 14 24             	mov    %edx,(%esp)
  801d4e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d52:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d56:	8b 14 24             	mov    (%esp),%edx
  801d59:	83 c4 1c             	add    $0x1c,%esp
  801d5c:	5b                   	pop    %ebx
  801d5d:	5e                   	pop    %esi
  801d5e:	5f                   	pop    %edi
  801d5f:	5d                   	pop    %ebp
  801d60:	c3                   	ret    
  801d61:	8d 76 00             	lea    0x0(%esi),%esi
  801d64:	2b 04 24             	sub    (%esp),%eax
  801d67:	19 fa                	sbb    %edi,%edx
  801d69:	89 d1                	mov    %edx,%ecx
  801d6b:	89 c6                	mov    %eax,%esi
  801d6d:	e9 71 ff ff ff       	jmp    801ce3 <__umoddi3+0xb3>
  801d72:	66 90                	xchg   %ax,%ax
  801d74:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d78:	72 ea                	jb     801d64 <__umoddi3+0x134>
  801d7a:	89 d9                	mov    %ebx,%ecx
  801d7c:	e9 62 ff ff ff       	jmp    801ce3 <__umoddi3+0xb3>
