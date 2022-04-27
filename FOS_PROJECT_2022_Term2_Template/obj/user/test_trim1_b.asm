
obj/user/test_trim1_b:     file format elf32-i386


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
  800031:	e8 21 01 00 00       	call   800157 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int first = 1;
uint32 ws_size_first=0;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	if(first == 1)
  80003e:	a1 00 20 80 00       	mov    0x802000,%eax
  800043:	83 f8 01             	cmp    $0x1,%eax
  800046:	0f 85 85 00 00 00    	jne    8000d1 <_main+0x99>
	{
		first = 0;
  80004c:	c7 05 00 20 80 00 00 	movl   $0x0,0x802000
  800053:	00 00 00 

		int envID = sys_getenvid();
  800056:	e8 f1 10 00 00       	call   80114c <sys_getenvid>
  80005b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("envID = %d\n",envID);
  80005e:	83 ec 08             	sub    $0x8,%esp
  800061:	ff 75 e8             	pushl  -0x18(%ebp)
  800064:	68 60 19 80 00       	push   $0x801960
  800069:	e8 cc 02 00 00       	call   80033a <cprintf>
  80006e:	83 c4 10             	add    $0x10,%esp


		uint32 i=0;
  800071:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		}
		cprintf("\n");
		}
		*/

		cprintf("testing trim: hello from B\n");
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	68 6c 19 80 00       	push   $0x80196c
  800080:	e8 b5 02 00 00       	call   80033a <cprintf>
  800085:	83 c4 10             	add    $0x10,%esp
		i=0;
  800088:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  80008f:	eb 2e                	jmp    8000bf <_main+0x87>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  800091:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800096:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80009c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009f:	89 d0                	mov    %edx,%eax
  8000a1:	01 c0                	add    %eax,%eax
  8000a3:	01 d0                	add    %edx,%eax
  8000a5:	c1 e0 02             	shl    $0x2,%eax
  8000a8:	01 c8                	add    %ecx,%eax
  8000aa:	8a 40 04             	mov    0x4(%eax),%al
  8000ad:	84 c0                	test   %al,%al
  8000af:	75 0b                	jne    8000bc <_main+0x84>
			{
				ws_size_first++;
  8000b1:	a1 08 20 80 00       	mov    0x802008,%eax
  8000b6:	40                   	inc    %eax
  8000b7:	a3 08 20 80 00       	mov    %eax,0x802008
		}
		*/

		cprintf("testing trim: hello from B\n");
		i=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  8000bc:	ff 45 f4             	incl   -0xc(%ebp)
  8000bf:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8000c4:	8b 40 74             	mov    0x74(%eax),%eax
  8000c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000ca:	77 c5                	ja     800091 <_main+0x59>
		uint32 reduced_frames = ws_size_first-ws_size;
		//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 B: WS size after trimming is reduced by %d frames\n", reduced_frames);
	}
}
  8000cc:	e9 83 00 00 00       	jmp    800154 <_main+0x11c>
		}
		//cprintf("ws_size_first = %d\n",ws_size_first);
	}
	else
	{
		int envID = sys_getenvid();
  8000d1:	e8 76 10 00 00       	call   80114c <sys_getenvid>
  8000d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("envID = %d\n",envID);
  8000d9:	83 ec 08             	sub    $0x8,%esp
  8000dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000df:	68 60 19 80 00       	push   $0x801960
  8000e4:	e8 51 02 00 00       	call   80033a <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp

		uint32 i=0;
  8000ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		}
		cprintf("\n");
		}
		*/

		i=0;
  8000f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		uint32 ws_size=0;
  8000fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(; i< (myEnv->page_WS_max_size); i++)
  800101:	eb 26                	jmp    800129 <_main+0xf1>
		{
			if(myEnv->__uptr_pws[i].empty == 0)
  800103:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800108:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80010e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800111:	89 d0                	mov    %edx,%eax
  800113:	01 c0                	add    %eax,%eax
  800115:	01 d0                	add    %edx,%eax
  800117:	c1 e0 02             	shl    $0x2,%eax
  80011a:	01 c8                	add    %ecx,%eax
  80011c:	8a 40 04             	mov    0x4(%eax),%al
  80011f:	84 c0                	test   %al,%al
  800121:	75 03                	jne    800126 <_main+0xee>
			{
				ws_size++;
  800123:	ff 45 ec             	incl   -0x14(%ebp)
		}
		*/

		i=0;
		uint32 ws_size=0;
		for(; i< (myEnv->page_WS_max_size); i++)
  800126:	ff 45 f0             	incl   -0x10(%ebp)
  800129:	a1 0c 20 80 00       	mov    0x80200c,%eax
  80012e:	8b 40 74             	mov    0x74(%eax),%eax
  800131:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800134:	77 cd                	ja     800103 <_main+0xcb>
			{
				ws_size++;
			}
		}

		uint32 reduced_frames = ws_size_first-ws_size;
  800136:	a1 08 20 80 00       	mov    0x802008,%eax
  80013b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80013e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		//		cprintf("ws_size_first = %d\n",ws_size_first);
		//cprintf("ws_size = %d\n",ws_size);
		cprintf("test trim 1 B: WS size after trimming is reduced by %d frames\n", reduced_frames);
  800141:	83 ec 08             	sub    $0x8,%esp
  800144:	ff 75 e0             	pushl  -0x20(%ebp)
  800147:	68 88 19 80 00       	push   $0x801988
  80014c:	e8 e9 01 00 00       	call   80033a <cprintf>
  800151:	83 c4 10             	add    $0x10,%esp
	}
}
  800154:	90                   	nop
  800155:	c9                   	leave  
  800156:	c3                   	ret    

00800157 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800157:	55                   	push   %ebp
  800158:	89 e5                	mov    %esp,%ebp
  80015a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80015d:	e8 03 10 00 00       	call   801165 <sys_getenvindex>
  800162:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800165:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800168:	89 d0                	mov    %edx,%eax
  80016a:	c1 e0 02             	shl    $0x2,%eax
  80016d:	01 d0                	add    %edx,%eax
  80016f:	01 c0                	add    %eax,%eax
  800171:	01 d0                	add    %edx,%eax
  800173:	01 c0                	add    %eax,%eax
  800175:	01 d0                	add    %edx,%eax
  800177:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80017e:	01 d0                	add    %edx,%eax
  800180:	c1 e0 02             	shl    $0x2,%eax
  800183:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800188:	a3 0c 20 80 00       	mov    %eax,0x80200c

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80018d:	a1 0c 20 80 00       	mov    0x80200c,%eax
  800192:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800198:	84 c0                	test   %al,%al
  80019a:	74 0f                	je     8001ab <libmain+0x54>
		binaryname = myEnv->prog_name;
  80019c:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8001a1:	05 f4 02 00 00       	add    $0x2f4,%eax
  8001a6:	a3 04 20 80 00       	mov    %eax,0x802004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001af:	7e 0a                	jle    8001bb <libmain+0x64>
		binaryname = argv[0];
  8001b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b4:	8b 00                	mov    (%eax),%eax
  8001b6:	a3 04 20 80 00       	mov    %eax,0x802004

	// call user main routine
	_main(argc, argv);
  8001bb:	83 ec 08             	sub    $0x8,%esp
  8001be:	ff 75 0c             	pushl  0xc(%ebp)
  8001c1:	ff 75 08             	pushl  0x8(%ebp)
  8001c4:	e8 6f fe ff ff       	call   800038 <_main>
  8001c9:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001cc:	e8 2f 11 00 00       	call   801300 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	68 e0 19 80 00       	push   $0x8019e0
  8001d9:	e8 5c 01 00 00       	call   80033a <cprintf>
  8001de:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001e1:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8001e6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001ec:	a1 0c 20 80 00       	mov    0x80200c,%eax
  8001f1:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001f7:	83 ec 04             	sub    $0x4,%esp
  8001fa:	52                   	push   %edx
  8001fb:	50                   	push   %eax
  8001fc:	68 08 1a 80 00       	push   $0x801a08
  800201:	e8 34 01 00 00       	call   80033a <cprintf>
  800206:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800209:	a1 0c 20 80 00       	mov    0x80200c,%eax
  80020e:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800214:	83 ec 08             	sub    $0x8,%esp
  800217:	50                   	push   %eax
  800218:	68 2d 1a 80 00       	push   $0x801a2d
  80021d:	e8 18 01 00 00       	call   80033a <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800225:	83 ec 0c             	sub    $0xc,%esp
  800228:	68 e0 19 80 00       	push   $0x8019e0
  80022d:	e8 08 01 00 00       	call   80033a <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800235:	e8 e0 10 00 00       	call   80131a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80023a:	e8 19 00 00 00       	call   800258 <exit>
}
  80023f:	90                   	nop
  800240:	c9                   	leave  
  800241:	c3                   	ret    

00800242 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800242:	55                   	push   %ebp
  800243:	89 e5                	mov    %esp,%ebp
  800245:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	6a 00                	push   $0x0
  80024d:	e8 df 0e 00 00       	call   801131 <sys_env_destroy>
  800252:	83 c4 10             	add    $0x10,%esp
}
  800255:	90                   	nop
  800256:	c9                   	leave  
  800257:	c3                   	ret    

00800258 <exit>:

void
exit(void)
{
  800258:	55                   	push   %ebp
  800259:	89 e5                	mov    %esp,%ebp
  80025b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80025e:	e8 34 0f 00 00       	call   801197 <sys_env_exit>
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80026c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	8d 48 01             	lea    0x1(%eax),%ecx
  800274:	8b 55 0c             	mov    0xc(%ebp),%edx
  800277:	89 0a                	mov    %ecx,(%edx)
  800279:	8b 55 08             	mov    0x8(%ebp),%edx
  80027c:	88 d1                	mov    %dl,%cl
  80027e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800281:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800285:	8b 45 0c             	mov    0xc(%ebp),%eax
  800288:	8b 00                	mov    (%eax),%eax
  80028a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80028f:	75 2c                	jne    8002bd <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800291:	a0 10 20 80 00       	mov    0x802010,%al
  800296:	0f b6 c0             	movzbl %al,%eax
  800299:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029c:	8b 12                	mov    (%edx),%edx
  80029e:	89 d1                	mov    %edx,%ecx
  8002a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002a3:	83 c2 08             	add    $0x8,%edx
  8002a6:	83 ec 04             	sub    $0x4,%esp
  8002a9:	50                   	push   %eax
  8002aa:	51                   	push   %ecx
  8002ab:	52                   	push   %edx
  8002ac:	e8 3e 0e 00 00       	call   8010ef <sys_cputs>
  8002b1:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c0:	8b 40 04             	mov    0x4(%eax),%eax
  8002c3:	8d 50 01             	lea    0x1(%eax),%edx
  8002c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002cc:	90                   	nop
  8002cd:	c9                   	leave  
  8002ce:	c3                   	ret    

008002cf <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002cf:	55                   	push   %ebp
  8002d0:	89 e5                	mov    %esp,%ebp
  8002d2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002d8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002df:	00 00 00 
	b.cnt = 0;
  8002e2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002e9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002ec:	ff 75 0c             	pushl  0xc(%ebp)
  8002ef:	ff 75 08             	pushl  0x8(%ebp)
  8002f2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f8:	50                   	push   %eax
  8002f9:	68 66 02 80 00       	push   $0x800266
  8002fe:	e8 11 02 00 00       	call   800514 <vprintfmt>
  800303:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800306:	a0 10 20 80 00       	mov    0x802010,%al
  80030b:	0f b6 c0             	movzbl %al,%eax
  80030e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800314:	83 ec 04             	sub    $0x4,%esp
  800317:	50                   	push   %eax
  800318:	52                   	push   %edx
  800319:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80031f:	83 c0 08             	add    $0x8,%eax
  800322:	50                   	push   %eax
  800323:	e8 c7 0d 00 00       	call   8010ef <sys_cputs>
  800328:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80032b:	c6 05 10 20 80 00 00 	movb   $0x0,0x802010
	return b.cnt;
  800332:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800338:	c9                   	leave  
  800339:	c3                   	ret    

0080033a <cprintf>:

int cprintf(const char *fmt, ...) {
  80033a:	55                   	push   %ebp
  80033b:	89 e5                	mov    %esp,%ebp
  80033d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800340:	c6 05 10 20 80 00 01 	movb   $0x1,0x802010
	va_start(ap, fmt);
  800347:	8d 45 0c             	lea    0xc(%ebp),%eax
  80034a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	83 ec 08             	sub    $0x8,%esp
  800353:	ff 75 f4             	pushl  -0xc(%ebp)
  800356:	50                   	push   %eax
  800357:	e8 73 ff ff ff       	call   8002cf <vcprintf>
  80035c:	83 c4 10             	add    $0x10,%esp
  80035f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800362:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800365:	c9                   	leave  
  800366:	c3                   	ret    

00800367 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800367:	55                   	push   %ebp
  800368:	89 e5                	mov    %esp,%ebp
  80036a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80036d:	e8 8e 0f 00 00       	call   801300 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800372:	8d 45 0c             	lea    0xc(%ebp),%eax
  800375:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	83 ec 08             	sub    $0x8,%esp
  80037e:	ff 75 f4             	pushl  -0xc(%ebp)
  800381:	50                   	push   %eax
  800382:	e8 48 ff ff ff       	call   8002cf <vcprintf>
  800387:	83 c4 10             	add    $0x10,%esp
  80038a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80038d:	e8 88 0f 00 00       	call   80131a <sys_enable_interrupt>
	return cnt;
  800392:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800395:	c9                   	leave  
  800396:	c3                   	ret    

00800397 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800397:	55                   	push   %ebp
  800398:	89 e5                	mov    %esp,%ebp
  80039a:	53                   	push   %ebx
  80039b:	83 ec 14             	sub    $0x14,%esp
  80039e:	8b 45 10             	mov    0x10(%ebp),%eax
  8003a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8003a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003aa:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8003b2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b5:	77 55                	ja     80040c <printnum+0x75>
  8003b7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003ba:	72 05                	jb     8003c1 <printnum+0x2a>
  8003bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003bf:	77 4b                	ja     80040c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003c1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003c4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003c7:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8003cf:	52                   	push   %edx
  8003d0:	50                   	push   %eax
  8003d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8003d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8003d7:	e8 04 13 00 00       	call   8016e0 <__udivdi3>
  8003dc:	83 c4 10             	add    $0x10,%esp
  8003df:	83 ec 04             	sub    $0x4,%esp
  8003e2:	ff 75 20             	pushl  0x20(%ebp)
  8003e5:	53                   	push   %ebx
  8003e6:	ff 75 18             	pushl  0x18(%ebp)
  8003e9:	52                   	push   %edx
  8003ea:	50                   	push   %eax
  8003eb:	ff 75 0c             	pushl  0xc(%ebp)
  8003ee:	ff 75 08             	pushl  0x8(%ebp)
  8003f1:	e8 a1 ff ff ff       	call   800397 <printnum>
  8003f6:	83 c4 20             	add    $0x20,%esp
  8003f9:	eb 1a                	jmp    800415 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003fb:	83 ec 08             	sub    $0x8,%esp
  8003fe:	ff 75 0c             	pushl  0xc(%ebp)
  800401:	ff 75 20             	pushl  0x20(%ebp)
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	ff d0                	call   *%eax
  800409:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80040c:	ff 4d 1c             	decl   0x1c(%ebp)
  80040f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800413:	7f e6                	jg     8003fb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800415:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800418:	bb 00 00 00 00       	mov    $0x0,%ebx
  80041d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800420:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800423:	53                   	push   %ebx
  800424:	51                   	push   %ecx
  800425:	52                   	push   %edx
  800426:	50                   	push   %eax
  800427:	e8 c4 13 00 00       	call   8017f0 <__umoddi3>
  80042c:	83 c4 10             	add    $0x10,%esp
  80042f:	05 74 1c 80 00       	add    $0x801c74,%eax
  800434:	8a 00                	mov    (%eax),%al
  800436:	0f be c0             	movsbl %al,%eax
  800439:	83 ec 08             	sub    $0x8,%esp
  80043c:	ff 75 0c             	pushl  0xc(%ebp)
  80043f:	50                   	push   %eax
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	ff d0                	call   *%eax
  800445:	83 c4 10             	add    $0x10,%esp
}
  800448:	90                   	nop
  800449:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80044c:	c9                   	leave  
  80044d:	c3                   	ret    

0080044e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80044e:	55                   	push   %ebp
  80044f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800451:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800455:	7e 1c                	jle    800473 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	8d 50 08             	lea    0x8(%eax),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	89 10                	mov    %edx,(%eax)
  800464:	8b 45 08             	mov    0x8(%ebp),%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	83 e8 08             	sub    $0x8,%eax
  80046c:	8b 50 04             	mov    0x4(%eax),%edx
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	eb 40                	jmp    8004b3 <getuint+0x65>
	else if (lflag)
  800473:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800477:	74 1e                	je     800497 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	8b 00                	mov    (%eax),%eax
  80047e:	8d 50 04             	lea    0x4(%eax),%edx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	89 10                	mov    %edx,(%eax)
  800486:	8b 45 08             	mov    0x8(%ebp),%eax
  800489:	8b 00                	mov    (%eax),%eax
  80048b:	83 e8 04             	sub    $0x4,%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	ba 00 00 00 00       	mov    $0x0,%edx
  800495:	eb 1c                	jmp    8004b3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	8b 00                	mov    (%eax),%eax
  80049c:	8d 50 04             	lea    0x4(%eax),%edx
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	89 10                	mov    %edx,(%eax)
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	83 e8 04             	sub    $0x4,%eax
  8004ac:	8b 00                	mov    (%eax),%eax
  8004ae:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004b3:	5d                   	pop    %ebp
  8004b4:	c3                   	ret    

008004b5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004b5:	55                   	push   %ebp
  8004b6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004b8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004bc:	7e 1c                	jle    8004da <getint+0x25>
		return va_arg(*ap, long long);
  8004be:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	8d 50 08             	lea    0x8(%eax),%edx
  8004c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c9:	89 10                	mov    %edx,(%eax)
  8004cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ce:	8b 00                	mov    (%eax),%eax
  8004d0:	83 e8 08             	sub    $0x8,%eax
  8004d3:	8b 50 04             	mov    0x4(%eax),%edx
  8004d6:	8b 00                	mov    (%eax),%eax
  8004d8:	eb 38                	jmp    800512 <getint+0x5d>
	else if (lflag)
  8004da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004de:	74 1a                	je     8004fa <getint+0x45>
		return va_arg(*ap, long);
  8004e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e3:	8b 00                	mov    (%eax),%eax
  8004e5:	8d 50 04             	lea    0x4(%eax),%edx
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	89 10                	mov    %edx,(%eax)
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	83 e8 04             	sub    $0x4,%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	99                   	cltd   
  8004f8:	eb 18                	jmp    800512 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	8b 00                	mov    (%eax),%eax
  8004ff:	8d 50 04             	lea    0x4(%eax),%edx
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	89 10                	mov    %edx,(%eax)
  800507:	8b 45 08             	mov    0x8(%ebp),%eax
  80050a:	8b 00                	mov    (%eax),%eax
  80050c:	83 e8 04             	sub    $0x4,%eax
  80050f:	8b 00                	mov    (%eax),%eax
  800511:	99                   	cltd   
}
  800512:	5d                   	pop    %ebp
  800513:	c3                   	ret    

00800514 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800514:	55                   	push   %ebp
  800515:	89 e5                	mov    %esp,%ebp
  800517:	56                   	push   %esi
  800518:	53                   	push   %ebx
  800519:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80051c:	eb 17                	jmp    800535 <vprintfmt+0x21>
			if (ch == '\0')
  80051e:	85 db                	test   %ebx,%ebx
  800520:	0f 84 af 03 00 00    	je     8008d5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800526:	83 ec 08             	sub    $0x8,%esp
  800529:	ff 75 0c             	pushl  0xc(%ebp)
  80052c:	53                   	push   %ebx
  80052d:	8b 45 08             	mov    0x8(%ebp),%eax
  800530:	ff d0                	call   *%eax
  800532:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800535:	8b 45 10             	mov    0x10(%ebp),%eax
  800538:	8d 50 01             	lea    0x1(%eax),%edx
  80053b:	89 55 10             	mov    %edx,0x10(%ebp)
  80053e:	8a 00                	mov    (%eax),%al
  800540:	0f b6 d8             	movzbl %al,%ebx
  800543:	83 fb 25             	cmp    $0x25,%ebx
  800546:	75 d6                	jne    80051e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800548:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80054c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800553:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80055a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800561:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800568:	8b 45 10             	mov    0x10(%ebp),%eax
  80056b:	8d 50 01             	lea    0x1(%eax),%edx
  80056e:	89 55 10             	mov    %edx,0x10(%ebp)
  800571:	8a 00                	mov    (%eax),%al
  800573:	0f b6 d8             	movzbl %al,%ebx
  800576:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800579:	83 f8 55             	cmp    $0x55,%eax
  80057c:	0f 87 2b 03 00 00    	ja     8008ad <vprintfmt+0x399>
  800582:	8b 04 85 98 1c 80 00 	mov    0x801c98(,%eax,4),%eax
  800589:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80058b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80058f:	eb d7                	jmp    800568 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800591:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800595:	eb d1                	jmp    800568 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800597:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80059e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a1:	89 d0                	mov    %edx,%eax
  8005a3:	c1 e0 02             	shl    $0x2,%eax
  8005a6:	01 d0                	add    %edx,%eax
  8005a8:	01 c0                	add    %eax,%eax
  8005aa:	01 d8                	add    %ebx,%eax
  8005ac:	83 e8 30             	sub    $0x30,%eax
  8005af:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b5:	8a 00                	mov    (%eax),%al
  8005b7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005ba:	83 fb 2f             	cmp    $0x2f,%ebx
  8005bd:	7e 3e                	jle    8005fd <vprintfmt+0xe9>
  8005bf:	83 fb 39             	cmp    $0x39,%ebx
  8005c2:	7f 39                	jg     8005fd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005c4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005c7:	eb d5                	jmp    80059e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cc:	83 c0 04             	add    $0x4,%eax
  8005cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d5:	83 e8 04             	sub    $0x4,%eax
  8005d8:	8b 00                	mov    (%eax),%eax
  8005da:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005dd:	eb 1f                	jmp    8005fe <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e3:	79 83                	jns    800568 <vprintfmt+0x54>
				width = 0;
  8005e5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005ec:	e9 77 ff ff ff       	jmp    800568 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005f1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005f8:	e9 6b ff ff ff       	jmp    800568 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005fd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005fe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800602:	0f 89 60 ff ff ff    	jns    800568 <vprintfmt+0x54>
				width = precision, precision = -1;
  800608:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80060e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800615:	e9 4e ff ff ff       	jmp    800568 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80061a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80061d:	e9 46 ff ff ff       	jmp    800568 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800622:	8b 45 14             	mov    0x14(%ebp),%eax
  800625:	83 c0 04             	add    $0x4,%eax
  800628:	89 45 14             	mov    %eax,0x14(%ebp)
  80062b:	8b 45 14             	mov    0x14(%ebp),%eax
  80062e:	83 e8 04             	sub    $0x4,%eax
  800631:	8b 00                	mov    (%eax),%eax
  800633:	83 ec 08             	sub    $0x8,%esp
  800636:	ff 75 0c             	pushl  0xc(%ebp)
  800639:	50                   	push   %eax
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	ff d0                	call   *%eax
  80063f:	83 c4 10             	add    $0x10,%esp
			break;
  800642:	e9 89 02 00 00       	jmp    8008d0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800647:	8b 45 14             	mov    0x14(%ebp),%eax
  80064a:	83 c0 04             	add    $0x4,%eax
  80064d:	89 45 14             	mov    %eax,0x14(%ebp)
  800650:	8b 45 14             	mov    0x14(%ebp),%eax
  800653:	83 e8 04             	sub    $0x4,%eax
  800656:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800658:	85 db                	test   %ebx,%ebx
  80065a:	79 02                	jns    80065e <vprintfmt+0x14a>
				err = -err;
  80065c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80065e:	83 fb 64             	cmp    $0x64,%ebx
  800661:	7f 0b                	jg     80066e <vprintfmt+0x15a>
  800663:	8b 34 9d e0 1a 80 00 	mov    0x801ae0(,%ebx,4),%esi
  80066a:	85 f6                	test   %esi,%esi
  80066c:	75 19                	jne    800687 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80066e:	53                   	push   %ebx
  80066f:	68 85 1c 80 00       	push   $0x801c85
  800674:	ff 75 0c             	pushl  0xc(%ebp)
  800677:	ff 75 08             	pushl  0x8(%ebp)
  80067a:	e8 5e 02 00 00       	call   8008dd <printfmt>
  80067f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800682:	e9 49 02 00 00       	jmp    8008d0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800687:	56                   	push   %esi
  800688:	68 8e 1c 80 00       	push   $0x801c8e
  80068d:	ff 75 0c             	pushl  0xc(%ebp)
  800690:	ff 75 08             	pushl  0x8(%ebp)
  800693:	e8 45 02 00 00       	call   8008dd <printfmt>
  800698:	83 c4 10             	add    $0x10,%esp
			break;
  80069b:	e9 30 02 00 00       	jmp    8008d0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a3:	83 c0 04             	add    $0x4,%eax
  8006a6:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ac:	83 e8 04             	sub    $0x4,%eax
  8006af:	8b 30                	mov    (%eax),%esi
  8006b1:	85 f6                	test   %esi,%esi
  8006b3:	75 05                	jne    8006ba <vprintfmt+0x1a6>
				p = "(null)";
  8006b5:	be 91 1c 80 00       	mov    $0x801c91,%esi
			if (width > 0 && padc != '-')
  8006ba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006be:	7e 6d                	jle    80072d <vprintfmt+0x219>
  8006c0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006c4:	74 67                	je     80072d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c9:	83 ec 08             	sub    $0x8,%esp
  8006cc:	50                   	push   %eax
  8006cd:	56                   	push   %esi
  8006ce:	e8 0c 03 00 00       	call   8009df <strnlen>
  8006d3:	83 c4 10             	add    $0x10,%esp
  8006d6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006d9:	eb 16                	jmp    8006f1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006db:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	ff 75 0c             	pushl  0xc(%ebp)
  8006e5:	50                   	push   %eax
  8006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e9:	ff d0                	call   *%eax
  8006eb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ee:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f5:	7f e4                	jg     8006db <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006f7:	eb 34                	jmp    80072d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006fd:	74 1c                	je     80071b <vprintfmt+0x207>
  8006ff:	83 fb 1f             	cmp    $0x1f,%ebx
  800702:	7e 05                	jle    800709 <vprintfmt+0x1f5>
  800704:	83 fb 7e             	cmp    $0x7e,%ebx
  800707:	7e 12                	jle    80071b <vprintfmt+0x207>
					putch('?', putdat);
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	6a 3f                	push   $0x3f
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	ff d0                	call   *%eax
  800716:	83 c4 10             	add    $0x10,%esp
  800719:	eb 0f                	jmp    80072a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80071b:	83 ec 08             	sub    $0x8,%esp
  80071e:	ff 75 0c             	pushl  0xc(%ebp)
  800721:	53                   	push   %ebx
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	ff d0                	call   *%eax
  800727:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80072a:	ff 4d e4             	decl   -0x1c(%ebp)
  80072d:	89 f0                	mov    %esi,%eax
  80072f:	8d 70 01             	lea    0x1(%eax),%esi
  800732:	8a 00                	mov    (%eax),%al
  800734:	0f be d8             	movsbl %al,%ebx
  800737:	85 db                	test   %ebx,%ebx
  800739:	74 24                	je     80075f <vprintfmt+0x24b>
  80073b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80073f:	78 b8                	js     8006f9 <vprintfmt+0x1e5>
  800741:	ff 4d e0             	decl   -0x20(%ebp)
  800744:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800748:	79 af                	jns    8006f9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80074a:	eb 13                	jmp    80075f <vprintfmt+0x24b>
				putch(' ', putdat);
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 0c             	pushl  0xc(%ebp)
  800752:	6a 20                	push   $0x20
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	ff d0                	call   *%eax
  800759:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80075c:	ff 4d e4             	decl   -0x1c(%ebp)
  80075f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800763:	7f e7                	jg     80074c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800765:	e9 66 01 00 00       	jmp    8008d0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80076a:	83 ec 08             	sub    $0x8,%esp
  80076d:	ff 75 e8             	pushl  -0x18(%ebp)
  800770:	8d 45 14             	lea    0x14(%ebp),%eax
  800773:	50                   	push   %eax
  800774:	e8 3c fd ff ff       	call   8004b5 <getint>
  800779:	83 c4 10             	add    $0x10,%esp
  80077c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800782:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800785:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800788:	85 d2                	test   %edx,%edx
  80078a:	79 23                	jns    8007af <vprintfmt+0x29b>
				putch('-', putdat);
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	6a 2d                	push   $0x2d
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	ff d0                	call   *%eax
  800799:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80079c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80079f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007a2:	f7 d8                	neg    %eax
  8007a4:	83 d2 00             	adc    $0x0,%edx
  8007a7:	f7 da                	neg    %edx
  8007a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007af:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007b6:	e9 bc 00 00 00       	jmp    800877 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	ff 75 e8             	pushl  -0x18(%ebp)
  8007c1:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c4:	50                   	push   %eax
  8007c5:	e8 84 fc ff ff       	call   80044e <getuint>
  8007ca:	83 c4 10             	add    $0x10,%esp
  8007cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007d3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007da:	e9 98 00 00 00       	jmp    800877 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	6a 58                	push   $0x58
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	ff d0                	call   *%eax
  8007ec:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	ff 75 0c             	pushl  0xc(%ebp)
  8007f5:	6a 58                	push   $0x58
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	ff d0                	call   *%eax
  8007fc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007ff:	83 ec 08             	sub    $0x8,%esp
  800802:	ff 75 0c             	pushl  0xc(%ebp)
  800805:	6a 58                	push   $0x58
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	ff d0                	call   *%eax
  80080c:	83 c4 10             	add    $0x10,%esp
			break;
  80080f:	e9 bc 00 00 00       	jmp    8008d0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800814:	83 ec 08             	sub    $0x8,%esp
  800817:	ff 75 0c             	pushl  0xc(%ebp)
  80081a:	6a 30                	push   $0x30
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	ff d0                	call   *%eax
  800821:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800824:	83 ec 08             	sub    $0x8,%esp
  800827:	ff 75 0c             	pushl  0xc(%ebp)
  80082a:	6a 78                	push   $0x78
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	ff d0                	call   *%eax
  800831:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800834:	8b 45 14             	mov    0x14(%ebp),%eax
  800837:	83 c0 04             	add    $0x4,%eax
  80083a:	89 45 14             	mov    %eax,0x14(%ebp)
  80083d:	8b 45 14             	mov    0x14(%ebp),%eax
  800840:	83 e8 04             	sub    $0x4,%eax
  800843:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800845:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800848:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80084f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800856:	eb 1f                	jmp    800877 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800858:	83 ec 08             	sub    $0x8,%esp
  80085b:	ff 75 e8             	pushl  -0x18(%ebp)
  80085e:	8d 45 14             	lea    0x14(%ebp),%eax
  800861:	50                   	push   %eax
  800862:	e8 e7 fb ff ff       	call   80044e <getuint>
  800867:	83 c4 10             	add    $0x10,%esp
  80086a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800870:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800877:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80087b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	52                   	push   %edx
  800882:	ff 75 e4             	pushl  -0x1c(%ebp)
  800885:	50                   	push   %eax
  800886:	ff 75 f4             	pushl  -0xc(%ebp)
  800889:	ff 75 f0             	pushl  -0x10(%ebp)
  80088c:	ff 75 0c             	pushl  0xc(%ebp)
  80088f:	ff 75 08             	pushl  0x8(%ebp)
  800892:	e8 00 fb ff ff       	call   800397 <printnum>
  800897:	83 c4 20             	add    $0x20,%esp
			break;
  80089a:	eb 34                	jmp    8008d0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80089c:	83 ec 08             	sub    $0x8,%esp
  80089f:	ff 75 0c             	pushl  0xc(%ebp)
  8008a2:	53                   	push   %ebx
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	ff d0                	call   *%eax
  8008a8:	83 c4 10             	add    $0x10,%esp
			break;
  8008ab:	eb 23                	jmp    8008d0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	6a 25                	push   $0x25
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	ff d0                	call   *%eax
  8008ba:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008bd:	ff 4d 10             	decl   0x10(%ebp)
  8008c0:	eb 03                	jmp    8008c5 <vprintfmt+0x3b1>
  8008c2:	ff 4d 10             	decl   0x10(%ebp)
  8008c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c8:	48                   	dec    %eax
  8008c9:	8a 00                	mov    (%eax),%al
  8008cb:	3c 25                	cmp    $0x25,%al
  8008cd:	75 f3                	jne    8008c2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008cf:	90                   	nop
		}
	}
  8008d0:	e9 47 fc ff ff       	jmp    80051c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008d5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d9:	5b                   	pop    %ebx
  8008da:	5e                   	pop    %esi
  8008db:	5d                   	pop    %ebp
  8008dc:	c3                   	ret    

008008dd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008dd:	55                   	push   %ebp
  8008de:	89 e5                	mov    %esp,%ebp
  8008e0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008e3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e6:	83 c0 04             	add    $0x4,%eax
  8008e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f2:	50                   	push   %eax
  8008f3:	ff 75 0c             	pushl  0xc(%ebp)
  8008f6:	ff 75 08             	pushl  0x8(%ebp)
  8008f9:	e8 16 fc ff ff       	call   800514 <vprintfmt>
  8008fe:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800901:	90                   	nop
  800902:	c9                   	leave  
  800903:	c3                   	ret    

00800904 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800904:	55                   	push   %ebp
  800905:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	8b 40 08             	mov    0x8(%eax),%eax
  80090d:	8d 50 01             	lea    0x1(%eax),%edx
  800910:	8b 45 0c             	mov    0xc(%ebp),%eax
  800913:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800916:	8b 45 0c             	mov    0xc(%ebp),%eax
  800919:	8b 10                	mov    (%eax),%edx
  80091b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091e:	8b 40 04             	mov    0x4(%eax),%eax
  800921:	39 c2                	cmp    %eax,%edx
  800923:	73 12                	jae    800937 <sprintputch+0x33>
		*b->buf++ = ch;
  800925:	8b 45 0c             	mov    0xc(%ebp),%eax
  800928:	8b 00                	mov    (%eax),%eax
  80092a:	8d 48 01             	lea    0x1(%eax),%ecx
  80092d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800930:	89 0a                	mov    %ecx,(%edx)
  800932:	8b 55 08             	mov    0x8(%ebp),%edx
  800935:	88 10                	mov    %dl,(%eax)
}
  800937:	90                   	nop
  800938:	5d                   	pop    %ebp
  800939:	c3                   	ret    

0080093a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80093a:	55                   	push   %ebp
  80093b:	89 e5                	mov    %esp,%ebp
  80093d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800940:	8b 45 08             	mov    0x8(%ebp),%eax
  800943:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800946:	8b 45 0c             	mov    0xc(%ebp),%eax
  800949:	8d 50 ff             	lea    -0x1(%eax),%edx
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	01 d0                	add    %edx,%eax
  800951:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800954:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80095b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80095f:	74 06                	je     800967 <vsnprintf+0x2d>
  800961:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800965:	7f 07                	jg     80096e <vsnprintf+0x34>
		return -E_INVAL;
  800967:	b8 03 00 00 00       	mov    $0x3,%eax
  80096c:	eb 20                	jmp    80098e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80096e:	ff 75 14             	pushl  0x14(%ebp)
  800971:	ff 75 10             	pushl  0x10(%ebp)
  800974:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800977:	50                   	push   %eax
  800978:	68 04 09 80 00       	push   $0x800904
  80097d:	e8 92 fb ff ff       	call   800514 <vprintfmt>
  800982:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800985:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800988:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80098b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800996:	8d 45 10             	lea    0x10(%ebp),%eax
  800999:	83 c0 04             	add    $0x4,%eax
  80099c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80099f:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a5:	50                   	push   %eax
  8009a6:	ff 75 0c             	pushl  0xc(%ebp)
  8009a9:	ff 75 08             	pushl  0x8(%ebp)
  8009ac:	e8 89 ff ff ff       	call   80093a <vsnprintf>
  8009b1:	83 c4 10             	add    $0x10,%esp
  8009b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ba:	c9                   	leave  
  8009bb:	c3                   	ret    

008009bc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009bc:	55                   	push   %ebp
  8009bd:	89 e5                	mov    %esp,%ebp
  8009bf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c9:	eb 06                	jmp    8009d1 <strlen+0x15>
		n++;
  8009cb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009ce:	ff 45 08             	incl   0x8(%ebp)
  8009d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d4:	8a 00                	mov    (%eax),%al
  8009d6:	84 c0                	test   %al,%al
  8009d8:	75 f1                	jne    8009cb <strlen+0xf>
		n++;
	return n;
  8009da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ec:	eb 09                	jmp    8009f7 <strnlen+0x18>
		n++;
  8009ee:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009f1:	ff 45 08             	incl   0x8(%ebp)
  8009f4:	ff 4d 0c             	decl   0xc(%ebp)
  8009f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009fb:	74 09                	je     800a06 <strnlen+0x27>
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	8a 00                	mov    (%eax),%al
  800a02:	84 c0                	test   %al,%al
  800a04:	75 e8                	jne    8009ee <strnlen+0xf>
		n++;
	return n;
  800a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a09:	c9                   	leave  
  800a0a:	c3                   	ret    

00800a0b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a0b:	55                   	push   %ebp
  800a0c:	89 e5                	mov    %esp,%ebp
  800a0e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a17:	90                   	nop
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	8d 50 01             	lea    0x1(%eax),%edx
  800a1e:	89 55 08             	mov    %edx,0x8(%ebp)
  800a21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a24:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a27:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a2a:	8a 12                	mov    (%edx),%dl
  800a2c:	88 10                	mov    %dl,(%eax)
  800a2e:	8a 00                	mov    (%eax),%al
  800a30:	84 c0                	test   %al,%al
  800a32:	75 e4                	jne    800a18 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a37:	c9                   	leave  
  800a38:	c3                   	ret    

00800a39 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a39:	55                   	push   %ebp
  800a3a:	89 e5                	mov    %esp,%ebp
  800a3c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a4c:	eb 1f                	jmp    800a6d <strncpy+0x34>
		*dst++ = *src;
  800a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a51:	8d 50 01             	lea    0x1(%eax),%edx
  800a54:	89 55 08             	mov    %edx,0x8(%ebp)
  800a57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5a:	8a 12                	mov    (%edx),%dl
  800a5c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a61:	8a 00                	mov    (%eax),%al
  800a63:	84 c0                	test   %al,%al
  800a65:	74 03                	je     800a6a <strncpy+0x31>
			src++;
  800a67:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a6a:	ff 45 fc             	incl   -0x4(%ebp)
  800a6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a70:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a73:	72 d9                	jb     800a4e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a75:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a78:	c9                   	leave  
  800a79:	c3                   	ret    

00800a7a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a7a:	55                   	push   %ebp
  800a7b:	89 e5                	mov    %esp,%ebp
  800a7d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8a:	74 30                	je     800abc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a8c:	eb 16                	jmp    800aa4 <strlcpy+0x2a>
			*dst++ = *src++;
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	8d 50 01             	lea    0x1(%eax),%edx
  800a94:	89 55 08             	mov    %edx,0x8(%ebp)
  800a97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a9a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a9d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aa0:	8a 12                	mov    (%edx),%dl
  800aa2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aa4:	ff 4d 10             	decl   0x10(%ebp)
  800aa7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aab:	74 09                	je     800ab6 <strlcpy+0x3c>
  800aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab0:	8a 00                	mov    (%eax),%al
  800ab2:	84 c0                	test   %al,%al
  800ab4:	75 d8                	jne    800a8e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800abc:	8b 55 08             	mov    0x8(%ebp),%edx
  800abf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ac2:	29 c2                	sub    %eax,%edx
  800ac4:	89 d0                	mov    %edx,%eax
}
  800ac6:	c9                   	leave  
  800ac7:	c3                   	ret    

00800ac8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ac8:	55                   	push   %ebp
  800ac9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800acb:	eb 06                	jmp    800ad3 <strcmp+0xb>
		p++, q++;
  800acd:	ff 45 08             	incl   0x8(%ebp)
  800ad0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	8a 00                	mov    (%eax),%al
  800ad8:	84 c0                	test   %al,%al
  800ada:	74 0e                	je     800aea <strcmp+0x22>
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8a 10                	mov    (%eax),%dl
  800ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	38 c2                	cmp    %al,%dl
  800ae8:	74 e3                	je     800acd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	8a 00                	mov    (%eax),%al
  800aef:	0f b6 d0             	movzbl %al,%edx
  800af2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af5:	8a 00                	mov    (%eax),%al
  800af7:	0f b6 c0             	movzbl %al,%eax
  800afa:	29 c2                	sub    %eax,%edx
  800afc:	89 d0                	mov    %edx,%eax
}
  800afe:	5d                   	pop    %ebp
  800aff:	c3                   	ret    

00800b00 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b00:	55                   	push   %ebp
  800b01:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b03:	eb 09                	jmp    800b0e <strncmp+0xe>
		n--, p++, q++;
  800b05:	ff 4d 10             	decl   0x10(%ebp)
  800b08:	ff 45 08             	incl   0x8(%ebp)
  800b0b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b12:	74 17                	je     800b2b <strncmp+0x2b>
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	8a 00                	mov    (%eax),%al
  800b19:	84 c0                	test   %al,%al
  800b1b:	74 0e                	je     800b2b <strncmp+0x2b>
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8a 10                	mov    (%eax),%dl
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	8a 00                	mov    (%eax),%al
  800b27:	38 c2                	cmp    %al,%dl
  800b29:	74 da                	je     800b05 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b2f:	75 07                	jne    800b38 <strncmp+0x38>
		return 0;
  800b31:	b8 00 00 00 00       	mov    $0x0,%eax
  800b36:	eb 14                	jmp    800b4c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	8a 00                	mov    (%eax),%al
  800b3d:	0f b6 d0             	movzbl %al,%edx
  800b40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b43:	8a 00                	mov    (%eax),%al
  800b45:	0f b6 c0             	movzbl %al,%eax
  800b48:	29 c2                	sub    %eax,%edx
  800b4a:	89 d0                	mov    %edx,%eax
}
  800b4c:	5d                   	pop    %ebp
  800b4d:	c3                   	ret    

00800b4e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
  800b51:	83 ec 04             	sub    $0x4,%esp
  800b54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b57:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b5a:	eb 12                	jmp    800b6e <strchr+0x20>
		if (*s == c)
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	8a 00                	mov    (%eax),%al
  800b61:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b64:	75 05                	jne    800b6b <strchr+0x1d>
			return (char *) s;
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	eb 11                	jmp    800b7c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b6b:	ff 45 08             	incl   0x8(%ebp)
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	8a 00                	mov    (%eax),%al
  800b73:	84 c0                	test   %al,%al
  800b75:	75 e5                	jne    800b5c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b77:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b7c:	c9                   	leave  
  800b7d:	c3                   	ret    

00800b7e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b7e:	55                   	push   %ebp
  800b7f:	89 e5                	mov    %esp,%ebp
  800b81:	83 ec 04             	sub    $0x4,%esp
  800b84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b87:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b8a:	eb 0d                	jmp    800b99 <strfind+0x1b>
		if (*s == c)
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8a 00                	mov    (%eax),%al
  800b91:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b94:	74 0e                	je     800ba4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b96:	ff 45 08             	incl   0x8(%ebp)
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	8a 00                	mov    (%eax),%al
  800b9e:	84 c0                	test   %al,%al
  800ba0:	75 ea                	jne    800b8c <strfind+0xe>
  800ba2:	eb 01                	jmp    800ba5 <strfind+0x27>
		if (*s == c)
			break;
  800ba4:	90                   	nop
	return (char *) s;
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba8:	c9                   	leave  
  800ba9:	c3                   	ret    

00800baa <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800baa:	55                   	push   %ebp
  800bab:	89 e5                	mov    %esp,%ebp
  800bad:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bbc:	eb 0e                	jmp    800bcc <memset+0x22>
		*p++ = c;
  800bbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bca:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bcc:	ff 4d f8             	decl   -0x8(%ebp)
  800bcf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bd3:	79 e9                	jns    800bbe <memset+0x14>
		*p++ = c;

	return v;
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd8:	c9                   	leave  
  800bd9:	c3                   	ret    

00800bda <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bda:	55                   	push   %ebp
  800bdb:	89 e5                	mov    %esp,%ebp
  800bdd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bec:	eb 16                	jmp    800c04 <memcpy+0x2a>
		*d++ = *s++;
  800bee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf1:	8d 50 01             	lea    0x1(%eax),%edx
  800bf4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bfa:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bfd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c00:	8a 12                	mov    (%edx),%dl
  800c02:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c04:	8b 45 10             	mov    0x10(%ebp),%eax
  800c07:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c0a:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0d:	85 c0                	test   %eax,%eax
  800c0f:	75 dd                	jne    800bee <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c14:	c9                   	leave  
  800c15:	c3                   	ret    

00800c16 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c16:	55                   	push   %ebp
  800c17:	89 e5                	mov    %esp,%ebp
  800c19:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c2e:	73 50                	jae    800c80 <memmove+0x6a>
  800c30:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c33:	8b 45 10             	mov    0x10(%ebp),%eax
  800c36:	01 d0                	add    %edx,%eax
  800c38:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c3b:	76 43                	jbe    800c80 <memmove+0x6a>
		s += n;
  800c3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c40:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c43:	8b 45 10             	mov    0x10(%ebp),%eax
  800c46:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c49:	eb 10                	jmp    800c5b <memmove+0x45>
			*--d = *--s;
  800c4b:	ff 4d f8             	decl   -0x8(%ebp)
  800c4e:	ff 4d fc             	decl   -0x4(%ebp)
  800c51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c54:	8a 10                	mov    (%eax),%dl
  800c56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c59:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c61:	89 55 10             	mov    %edx,0x10(%ebp)
  800c64:	85 c0                	test   %eax,%eax
  800c66:	75 e3                	jne    800c4b <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c68:	eb 23                	jmp    800c8d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c6d:	8d 50 01             	lea    0x1(%eax),%edx
  800c70:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c73:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c79:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c7c:	8a 12                	mov    (%edx),%dl
  800c7e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c80:	8b 45 10             	mov    0x10(%ebp),%eax
  800c83:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c86:	89 55 10             	mov    %edx,0x10(%ebp)
  800c89:	85 c0                	test   %eax,%eax
  800c8b:	75 dd                	jne    800c6a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c90:	c9                   	leave  
  800c91:	c3                   	ret    

00800c92 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ca4:	eb 2a                	jmp    800cd0 <memcmp+0x3e>
		if (*s1 != *s2)
  800ca6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca9:	8a 10                	mov    (%eax),%dl
  800cab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cae:	8a 00                	mov    (%eax),%al
  800cb0:	38 c2                	cmp    %al,%dl
  800cb2:	74 16                	je     800cca <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	0f b6 d0             	movzbl %al,%edx
  800cbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	0f b6 c0             	movzbl %al,%eax
  800cc4:	29 c2                	sub    %eax,%edx
  800cc6:	89 d0                	mov    %edx,%eax
  800cc8:	eb 18                	jmp    800ce2 <memcmp+0x50>
		s1++, s2++;
  800cca:	ff 45 fc             	incl   -0x4(%ebp)
  800ccd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd6:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd9:	85 c0                	test   %eax,%eax
  800cdb:	75 c9                	jne    800ca6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ce2:	c9                   	leave  
  800ce3:	c3                   	ret    

00800ce4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ce4:	55                   	push   %ebp
  800ce5:	89 e5                	mov    %esp,%ebp
  800ce7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cea:	8b 55 08             	mov    0x8(%ebp),%edx
  800ced:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf0:	01 d0                	add    %edx,%eax
  800cf2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cf5:	eb 15                	jmp    800d0c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	0f b6 d0             	movzbl %al,%edx
  800cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d02:	0f b6 c0             	movzbl %al,%eax
  800d05:	39 c2                	cmp    %eax,%edx
  800d07:	74 0d                	je     800d16 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d09:	ff 45 08             	incl   0x8(%ebp)
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d12:	72 e3                	jb     800cf7 <memfind+0x13>
  800d14:	eb 01                	jmp    800d17 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d16:	90                   	nop
	return (void *) s;
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d1a:	c9                   	leave  
  800d1b:	c3                   	ret    

00800d1c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
  800d1f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d29:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d30:	eb 03                	jmp    800d35 <strtol+0x19>
		s++;
  800d32:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	3c 20                	cmp    $0x20,%al
  800d3c:	74 f4                	je     800d32 <strtol+0x16>
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	3c 09                	cmp    $0x9,%al
  800d45:	74 eb                	je     800d32 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	3c 2b                	cmp    $0x2b,%al
  800d4e:	75 05                	jne    800d55 <strtol+0x39>
		s++;
  800d50:	ff 45 08             	incl   0x8(%ebp)
  800d53:	eb 13                	jmp    800d68 <strtol+0x4c>
	else if (*s == '-')
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 2d                	cmp    $0x2d,%al
  800d5c:	75 0a                	jne    800d68 <strtol+0x4c>
		s++, neg = 1;
  800d5e:	ff 45 08             	incl   0x8(%ebp)
  800d61:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6c:	74 06                	je     800d74 <strtol+0x58>
  800d6e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d72:	75 20                	jne    800d94 <strtol+0x78>
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	8a 00                	mov    (%eax),%al
  800d79:	3c 30                	cmp    $0x30,%al
  800d7b:	75 17                	jne    800d94 <strtol+0x78>
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	40                   	inc    %eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	3c 78                	cmp    $0x78,%al
  800d85:	75 0d                	jne    800d94 <strtol+0x78>
		s += 2, base = 16;
  800d87:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d8b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d92:	eb 28                	jmp    800dbc <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d98:	75 15                	jne    800daf <strtol+0x93>
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	8a 00                	mov    (%eax),%al
  800d9f:	3c 30                	cmp    $0x30,%al
  800da1:	75 0c                	jne    800daf <strtol+0x93>
		s++, base = 8;
  800da3:	ff 45 08             	incl   0x8(%ebp)
  800da6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800dad:	eb 0d                	jmp    800dbc <strtol+0xa0>
	else if (base == 0)
  800daf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db3:	75 07                	jne    800dbc <strtol+0xa0>
		base = 10;
  800db5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	3c 2f                	cmp    $0x2f,%al
  800dc3:	7e 19                	jle    800dde <strtol+0xc2>
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	3c 39                	cmp    $0x39,%al
  800dcc:	7f 10                	jg     800dde <strtol+0xc2>
			dig = *s - '0';
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	0f be c0             	movsbl %al,%eax
  800dd6:	83 e8 30             	sub    $0x30,%eax
  800dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ddc:	eb 42                	jmp    800e20 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	3c 60                	cmp    $0x60,%al
  800de5:	7e 19                	jle    800e00 <strtol+0xe4>
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8a 00                	mov    (%eax),%al
  800dec:	3c 7a                	cmp    $0x7a,%al
  800dee:	7f 10                	jg     800e00 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	8a 00                	mov    (%eax),%al
  800df5:	0f be c0             	movsbl %al,%eax
  800df8:	83 e8 57             	sub    $0x57,%eax
  800dfb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dfe:	eb 20                	jmp    800e20 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	3c 40                	cmp    $0x40,%al
  800e07:	7e 39                	jle    800e42 <strtol+0x126>
  800e09:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	3c 5a                	cmp    $0x5a,%al
  800e10:	7f 30                	jg     800e42 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	8a 00                	mov    (%eax),%al
  800e17:	0f be c0             	movsbl %al,%eax
  800e1a:	83 e8 37             	sub    $0x37,%eax
  800e1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e23:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e26:	7d 19                	jge    800e41 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e28:	ff 45 08             	incl   0x8(%ebp)
  800e2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e32:	89 c2                	mov    %eax,%edx
  800e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e37:	01 d0                	add    %edx,%eax
  800e39:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e3c:	e9 7b ff ff ff       	jmp    800dbc <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e41:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e42:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e46:	74 08                	je     800e50 <strtol+0x134>
		*endptr = (char *) s;
  800e48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800e4e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e50:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e54:	74 07                	je     800e5d <strtol+0x141>
  800e56:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e59:	f7 d8                	neg    %eax
  800e5b:	eb 03                	jmp    800e60 <strtol+0x144>
  800e5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e60:	c9                   	leave  
  800e61:	c3                   	ret    

00800e62 <ltostr>:

void
ltostr(long value, char *str)
{
  800e62:	55                   	push   %ebp
  800e63:	89 e5                	mov    %esp,%ebp
  800e65:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e6f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e76:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e7a:	79 13                	jns    800e8f <ltostr+0x2d>
	{
		neg = 1;
  800e7c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e86:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e89:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e8c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e97:	99                   	cltd   
  800e98:	f7 f9                	idiv   %ecx
  800e9a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea0:	8d 50 01             	lea    0x1(%eax),%edx
  800ea3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea6:	89 c2                	mov    %eax,%edx
  800ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eab:	01 d0                	add    %edx,%eax
  800ead:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800eb0:	83 c2 30             	add    $0x30,%edx
  800eb3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800eb5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ebd:	f7 e9                	imul   %ecx
  800ebf:	c1 fa 02             	sar    $0x2,%edx
  800ec2:	89 c8                	mov    %ecx,%eax
  800ec4:	c1 f8 1f             	sar    $0x1f,%eax
  800ec7:	29 c2                	sub    %eax,%edx
  800ec9:	89 d0                	mov    %edx,%eax
  800ecb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ece:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ed1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ed6:	f7 e9                	imul   %ecx
  800ed8:	c1 fa 02             	sar    $0x2,%edx
  800edb:	89 c8                	mov    %ecx,%eax
  800edd:	c1 f8 1f             	sar    $0x1f,%eax
  800ee0:	29 c2                	sub    %eax,%edx
  800ee2:	89 d0                	mov    %edx,%eax
  800ee4:	c1 e0 02             	shl    $0x2,%eax
  800ee7:	01 d0                	add    %edx,%eax
  800ee9:	01 c0                	add    %eax,%eax
  800eeb:	29 c1                	sub    %eax,%ecx
  800eed:	89 ca                	mov    %ecx,%edx
  800eef:	85 d2                	test   %edx,%edx
  800ef1:	75 9c                	jne    800e8f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ef3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800efa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efd:	48                   	dec    %eax
  800efe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f01:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f05:	74 3d                	je     800f44 <ltostr+0xe2>
		start = 1 ;
  800f07:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f0e:	eb 34                	jmp    800f44 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f16:	01 d0                	add    %edx,%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	01 c2                	add    %eax,%edx
  800f25:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	01 c8                	add    %ecx,%eax
  800f2d:	8a 00                	mov    (%eax),%al
  800f2f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f31:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	01 c2                	add    %eax,%edx
  800f39:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f3c:	88 02                	mov    %al,(%edx)
		start++ ;
  800f3e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f41:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f47:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f4a:	7c c4                	jl     800f10 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f4c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f52:	01 d0                	add    %edx,%eax
  800f54:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f57:	90                   	nop
  800f58:	c9                   	leave  
  800f59:	c3                   	ret    

00800f5a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f5a:	55                   	push   %ebp
  800f5b:	89 e5                	mov    %esp,%ebp
  800f5d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f60:	ff 75 08             	pushl  0x8(%ebp)
  800f63:	e8 54 fa ff ff       	call   8009bc <strlen>
  800f68:	83 c4 04             	add    $0x4,%esp
  800f6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f6e:	ff 75 0c             	pushl  0xc(%ebp)
  800f71:	e8 46 fa ff ff       	call   8009bc <strlen>
  800f76:	83 c4 04             	add    $0x4,%esp
  800f79:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f8a:	eb 17                	jmp    800fa3 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f8c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	01 c2                	add    %eax,%edx
  800f94:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	01 c8                	add    %ecx,%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fa0:	ff 45 fc             	incl   -0x4(%ebp)
  800fa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fa9:	7c e1                	jl     800f8c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fb2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fb9:	eb 1f                	jmp    800fda <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fbe:	8d 50 01             	lea    0x1(%eax),%edx
  800fc1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fc4:	89 c2                	mov    %eax,%edx
  800fc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc9:	01 c2                	add    %eax,%edx
  800fcb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd1:	01 c8                	add    %ecx,%eax
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fd7:	ff 45 f8             	incl   -0x8(%ebp)
  800fda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fdd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fe0:	7c d9                	jl     800fbb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fe2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe8:	01 d0                	add    %edx,%eax
  800fea:	c6 00 00             	movb   $0x0,(%eax)
}
  800fed:	90                   	nop
  800fee:	c9                   	leave  
  800fef:	c3                   	ret    

00800ff0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ff0:	55                   	push   %ebp
  800ff1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800ff3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ffc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fff:	8b 00                	mov    (%eax),%eax
  801001:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	01 d0                	add    %edx,%eax
  80100d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801013:	eb 0c                	jmp    801021 <strsplit+0x31>
			*string++ = 0;
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8d 50 01             	lea    0x1(%eax),%edx
  80101b:	89 55 08             	mov    %edx,0x8(%ebp)
  80101e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	84 c0                	test   %al,%al
  801028:	74 18                	je     801042 <strsplit+0x52>
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	8a 00                	mov    (%eax),%al
  80102f:	0f be c0             	movsbl %al,%eax
  801032:	50                   	push   %eax
  801033:	ff 75 0c             	pushl  0xc(%ebp)
  801036:	e8 13 fb ff ff       	call   800b4e <strchr>
  80103b:	83 c4 08             	add    $0x8,%esp
  80103e:	85 c0                	test   %eax,%eax
  801040:	75 d3                	jne    801015 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8a 00                	mov    (%eax),%al
  801047:	84 c0                	test   %al,%al
  801049:	74 5a                	je     8010a5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80104b:	8b 45 14             	mov    0x14(%ebp),%eax
  80104e:	8b 00                	mov    (%eax),%eax
  801050:	83 f8 0f             	cmp    $0xf,%eax
  801053:	75 07                	jne    80105c <strsplit+0x6c>
		{
			return 0;
  801055:	b8 00 00 00 00       	mov    $0x0,%eax
  80105a:	eb 66                	jmp    8010c2 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80105c:	8b 45 14             	mov    0x14(%ebp),%eax
  80105f:	8b 00                	mov    (%eax),%eax
  801061:	8d 48 01             	lea    0x1(%eax),%ecx
  801064:	8b 55 14             	mov    0x14(%ebp),%edx
  801067:	89 0a                	mov    %ecx,(%edx)
  801069:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801070:	8b 45 10             	mov    0x10(%ebp),%eax
  801073:	01 c2                	add    %eax,%edx
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80107a:	eb 03                	jmp    80107f <strsplit+0x8f>
			string++;
  80107c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	84 c0                	test   %al,%al
  801086:	74 8b                	je     801013 <strsplit+0x23>
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	0f be c0             	movsbl %al,%eax
  801090:	50                   	push   %eax
  801091:	ff 75 0c             	pushl  0xc(%ebp)
  801094:	e8 b5 fa ff ff       	call   800b4e <strchr>
  801099:	83 c4 08             	add    $0x8,%esp
  80109c:	85 c0                	test   %eax,%eax
  80109e:	74 dc                	je     80107c <strsplit+0x8c>
			string++;
	}
  8010a0:	e9 6e ff ff ff       	jmp    801013 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010a5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a9:	8b 00                	mov    (%eax),%eax
  8010ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b5:	01 d0                	add    %edx,%eax
  8010b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010bd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	57                   	push   %edi
  8010c8:	56                   	push   %esi
  8010c9:	53                   	push   %ebx
  8010ca:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010d6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010d9:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010dc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010df:	cd 30                	int    $0x30
  8010e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e7:	83 c4 10             	add    $0x10,%esp
  8010ea:	5b                   	pop    %ebx
  8010eb:	5e                   	pop    %esi
  8010ec:	5f                   	pop    %edi
  8010ed:	5d                   	pop    %ebp
  8010ee:	c3                   	ret    

008010ef <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
  8010f2:	83 ec 04             	sub    $0x4,%esp
  8010f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010fb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801102:	6a 00                	push   $0x0
  801104:	6a 00                	push   $0x0
  801106:	52                   	push   %edx
  801107:	ff 75 0c             	pushl  0xc(%ebp)
  80110a:	50                   	push   %eax
  80110b:	6a 00                	push   $0x0
  80110d:	e8 b2 ff ff ff       	call   8010c4 <syscall>
  801112:	83 c4 18             	add    $0x18,%esp
}
  801115:	90                   	nop
  801116:	c9                   	leave  
  801117:	c3                   	ret    

00801118 <sys_cgetc>:

int
sys_cgetc(void)
{
  801118:	55                   	push   %ebp
  801119:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	6a 00                	push   $0x0
  801121:	6a 00                	push   $0x0
  801123:	6a 00                	push   $0x0
  801125:	6a 01                	push   $0x1
  801127:	e8 98 ff ff ff       	call   8010c4 <syscall>
  80112c:	83 c4 18             	add    $0x18,%esp
}
  80112f:	c9                   	leave  
  801130:	c3                   	ret    

00801131 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801131:	55                   	push   %ebp
  801132:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	6a 00                	push   $0x0
  801139:	6a 00                	push   $0x0
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	50                   	push   %eax
  801140:	6a 05                	push   $0x5
  801142:	e8 7d ff ff ff       	call   8010c4 <syscall>
  801147:	83 c4 18             	add    $0x18,%esp
}
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 00                	push   $0x0
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	6a 02                	push   $0x2
  80115b:	e8 64 ff ff ff       	call   8010c4 <syscall>
  801160:	83 c4 18             	add    $0x18,%esp
}
  801163:	c9                   	leave  
  801164:	c3                   	ret    

00801165 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801165:	55                   	push   %ebp
  801166:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 00                	push   $0x0
  80116e:	6a 00                	push   $0x0
  801170:	6a 00                	push   $0x0
  801172:	6a 03                	push   $0x3
  801174:	e8 4b ff ff ff       	call   8010c4 <syscall>
  801179:	83 c4 18             	add    $0x18,%esp
}
  80117c:	c9                   	leave  
  80117d:	c3                   	ret    

0080117e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80117e:	55                   	push   %ebp
  80117f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	6a 04                	push   $0x4
  80118d:	e8 32 ff ff ff       	call   8010c4 <syscall>
  801192:	83 c4 18             	add    $0x18,%esp
}
  801195:	c9                   	leave  
  801196:	c3                   	ret    

00801197 <sys_env_exit>:


void sys_env_exit(void)
{
  801197:	55                   	push   %ebp
  801198:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 06                	push   $0x6
  8011a6:	e8 19 ff ff ff       	call   8010c4 <syscall>
  8011ab:	83 c4 18             	add    $0x18,%esp
}
  8011ae:	90                   	nop
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	52                   	push   %edx
  8011c1:	50                   	push   %eax
  8011c2:	6a 07                	push   $0x7
  8011c4:	e8 fb fe ff ff       	call   8010c4 <syscall>
  8011c9:	83 c4 18             	add    $0x18,%esp
}
  8011cc:	c9                   	leave  
  8011cd:	c3                   	ret    

008011ce <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011ce:	55                   	push   %ebp
  8011cf:	89 e5                	mov    %esp,%ebp
  8011d1:	56                   	push   %esi
  8011d2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011d3:	8b 75 18             	mov    0x18(%ebp),%esi
  8011d6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	56                   	push   %esi
  8011e3:	53                   	push   %ebx
  8011e4:	51                   	push   %ecx
  8011e5:	52                   	push   %edx
  8011e6:	50                   	push   %eax
  8011e7:	6a 08                	push   $0x8
  8011e9:	e8 d6 fe ff ff       	call   8010c4 <syscall>
  8011ee:	83 c4 18             	add    $0x18,%esp
}
  8011f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011f4:	5b                   	pop    %ebx
  8011f5:	5e                   	pop    %esi
  8011f6:	5d                   	pop    %ebp
  8011f7:	c3                   	ret    

008011f8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	52                   	push   %edx
  801208:	50                   	push   %eax
  801209:	6a 09                	push   $0x9
  80120b:	e8 b4 fe ff ff       	call   8010c4 <syscall>
  801210:	83 c4 18             	add    $0x18,%esp
}
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 00                	push   $0x0
  80121e:	ff 75 0c             	pushl  0xc(%ebp)
  801221:	ff 75 08             	pushl  0x8(%ebp)
  801224:	6a 0a                	push   $0xa
  801226:	e8 99 fe ff ff       	call   8010c4 <syscall>
  80122b:	83 c4 18             	add    $0x18,%esp
}
  80122e:	c9                   	leave  
  80122f:	c3                   	ret    

00801230 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801230:	55                   	push   %ebp
  801231:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 0b                	push   $0xb
  80123f:	e8 80 fe ff ff       	call   8010c4 <syscall>
  801244:	83 c4 18             	add    $0x18,%esp
}
  801247:	c9                   	leave  
  801248:	c3                   	ret    

00801249 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801249:	55                   	push   %ebp
  80124a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 00                	push   $0x0
  801256:	6a 0c                	push   $0xc
  801258:	e8 67 fe ff ff       	call   8010c4 <syscall>
  80125d:	83 c4 18             	add    $0x18,%esp
}
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 0d                	push   $0xd
  801271:	e8 4e fe ff ff       	call   8010c4 <syscall>
  801276:	83 c4 18             	add    $0x18,%esp
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	ff 75 0c             	pushl  0xc(%ebp)
  801287:	ff 75 08             	pushl  0x8(%ebp)
  80128a:	6a 11                	push   $0x11
  80128c:	e8 33 fe ff ff       	call   8010c4 <syscall>
  801291:	83 c4 18             	add    $0x18,%esp
	return;
  801294:	90                   	nop
}
  801295:	c9                   	leave  
  801296:	c3                   	ret    

00801297 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	ff 75 0c             	pushl  0xc(%ebp)
  8012a3:	ff 75 08             	pushl  0x8(%ebp)
  8012a6:	6a 12                	push   $0x12
  8012a8:	e8 17 fe ff ff       	call   8010c4 <syscall>
  8012ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8012b0:	90                   	nop
}
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 0e                	push   $0xe
  8012c2:	e8 fd fd ff ff       	call   8010c4 <syscall>
  8012c7:	83 c4 18             	add    $0x18,%esp
}
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	ff 75 08             	pushl  0x8(%ebp)
  8012da:	6a 0f                	push   $0xf
  8012dc:	e8 e3 fd ff ff       	call   8010c4 <syscall>
  8012e1:	83 c4 18             	add    $0x18,%esp
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 10                	push   $0x10
  8012f5:	e8 ca fd ff ff       	call   8010c4 <syscall>
  8012fa:	83 c4 18             	add    $0x18,%esp
}
  8012fd:	90                   	nop
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 14                	push   $0x14
  80130f:	e8 b0 fd ff ff       	call   8010c4 <syscall>
  801314:	83 c4 18             	add    $0x18,%esp
}
  801317:	90                   	nop
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 15                	push   $0x15
  801329:	e8 96 fd ff ff       	call   8010c4 <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	90                   	nop
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <sys_cputc>:


void
sys_cputc(const char c)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
  801337:	83 ec 04             	sub    $0x4,%esp
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801340:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	50                   	push   %eax
  80134d:	6a 16                	push   $0x16
  80134f:	e8 70 fd ff ff       	call   8010c4 <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	90                   	nop
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 17                	push   $0x17
  801369:	e8 56 fd ff ff       	call   8010c4 <syscall>
  80136e:	83 c4 18             	add    $0x18,%esp
}
  801371:	90                   	nop
  801372:	c9                   	leave  
  801373:	c3                   	ret    

00801374 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801374:	55                   	push   %ebp
  801375:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	ff 75 0c             	pushl  0xc(%ebp)
  801383:	50                   	push   %eax
  801384:	6a 18                	push   $0x18
  801386:	e8 39 fd ff ff       	call   8010c4 <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801393:	8b 55 0c             	mov    0xc(%ebp),%edx
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	52                   	push   %edx
  8013a0:	50                   	push   %eax
  8013a1:	6a 1b                	push   $0x1b
  8013a3:	e8 1c fd ff ff       	call   8010c4 <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	52                   	push   %edx
  8013bd:	50                   	push   %eax
  8013be:	6a 19                	push   $0x19
  8013c0:	e8 ff fc ff ff       	call   8010c4 <syscall>
  8013c5:	83 c4 18             	add    $0x18,%esp
}
  8013c8:	90                   	nop
  8013c9:	c9                   	leave  
  8013ca:	c3                   	ret    

008013cb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	52                   	push   %edx
  8013db:	50                   	push   %eax
  8013dc:	6a 1a                	push   $0x1a
  8013de:	e8 e1 fc ff ff       	call   8010c4 <syscall>
  8013e3:	83 c4 18             	add    $0x18,%esp
}
  8013e6:	90                   	nop
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
  8013ec:	83 ec 04             	sub    $0x4,%esp
  8013ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013f5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013f8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	6a 00                	push   $0x0
  801401:	51                   	push   %ecx
  801402:	52                   	push   %edx
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	50                   	push   %eax
  801407:	6a 1c                	push   $0x1c
  801409:	e8 b6 fc ff ff       	call   8010c4 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	52                   	push   %edx
  801423:	50                   	push   %eax
  801424:	6a 1d                	push   $0x1d
  801426:	e8 99 fc ff ff       	call   8010c4 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801433:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801436:	8b 55 0c             	mov    0xc(%ebp),%edx
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	51                   	push   %ecx
  801441:	52                   	push   %edx
  801442:	50                   	push   %eax
  801443:	6a 1e                	push   $0x1e
  801445:	e8 7a fc ff ff       	call   8010c4 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801452:	8b 55 0c             	mov    0xc(%ebp),%edx
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	52                   	push   %edx
  80145f:	50                   	push   %eax
  801460:	6a 1f                	push   $0x1f
  801462:	e8 5d fc ff ff       	call   8010c4 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 20                	push   $0x20
  80147b:	e8 44 fc ff ff       	call   8010c4 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	ff 75 10             	pushl  0x10(%ebp)
  801492:	ff 75 0c             	pushl  0xc(%ebp)
  801495:	50                   	push   %eax
  801496:	6a 21                	push   $0x21
  801498:	e8 27 fc ff ff       	call   8010c4 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
}
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	50                   	push   %eax
  8014b1:	6a 22                	push   $0x22
  8014b3:	e8 0c fc ff ff       	call   8010c4 <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	90                   	nop
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	50                   	push   %eax
  8014cd:	6a 23                	push   $0x23
  8014cf:	e8 f0 fb ff ff       	call   8010c4 <syscall>
  8014d4:	83 c4 18             	add    $0x18,%esp
}
  8014d7:	90                   	nop
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014e0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014e3:	8d 50 04             	lea    0x4(%eax),%edx
  8014e6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	52                   	push   %edx
  8014f0:	50                   	push   %eax
  8014f1:	6a 24                	push   $0x24
  8014f3:	e8 cc fb ff ff       	call   8010c4 <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
	return result;
  8014fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801501:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801504:	89 01                	mov    %eax,(%ecx)
  801506:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	c9                   	leave  
  80150d:	c2 04 00             	ret    $0x4

00801510 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	ff 75 10             	pushl  0x10(%ebp)
  80151a:	ff 75 0c             	pushl  0xc(%ebp)
  80151d:	ff 75 08             	pushl  0x8(%ebp)
  801520:	6a 13                	push   $0x13
  801522:	e8 9d fb ff ff       	call   8010c4 <syscall>
  801527:	83 c4 18             	add    $0x18,%esp
	return ;
  80152a:	90                   	nop
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_rcr2>:
uint32 sys_rcr2()
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 25                	push   $0x25
  80153c:	e8 83 fb ff ff       	call   8010c4 <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 04             	sub    $0x4,%esp
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801552:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	50                   	push   %eax
  80155f:	6a 26                	push   $0x26
  801561:	e8 5e fb ff ff       	call   8010c4 <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
	return ;
  801569:	90                   	nop
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <rsttst>:
void rsttst()
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 28                	push   $0x28
  80157b:	e8 44 fb ff ff       	call   8010c4 <syscall>
  801580:	83 c4 18             	add    $0x18,%esp
	return ;
  801583:	90                   	nop
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 04             	sub    $0x4,%esp
  80158c:	8b 45 14             	mov    0x14(%ebp),%eax
  80158f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801592:	8b 55 18             	mov    0x18(%ebp),%edx
  801595:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801599:	52                   	push   %edx
  80159a:	50                   	push   %eax
  80159b:	ff 75 10             	pushl  0x10(%ebp)
  80159e:	ff 75 0c             	pushl  0xc(%ebp)
  8015a1:	ff 75 08             	pushl  0x8(%ebp)
  8015a4:	6a 27                	push   $0x27
  8015a6:	e8 19 fb ff ff       	call   8010c4 <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ae:	90                   	nop
}
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <chktst>:
void chktst(uint32 n)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	ff 75 08             	pushl  0x8(%ebp)
  8015bf:	6a 29                	push   $0x29
  8015c1:	e8 fe fa ff ff       	call   8010c4 <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c9:	90                   	nop
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <inctst>:

void inctst()
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 2a                	push   $0x2a
  8015db:	e8 e4 fa ff ff       	call   8010c4 <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e3:	90                   	nop
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <gettst>:
uint32 gettst()
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 2b                	push   $0x2b
  8015f5:	e8 ca fa ff ff       	call   8010c4 <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
}
  8015fd:	c9                   	leave  
  8015fe:	c3                   	ret    

008015ff <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015ff:	55                   	push   %ebp
  801600:	89 e5                	mov    %esp,%ebp
  801602:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 2c                	push   $0x2c
  801611:	e8 ae fa ff ff       	call   8010c4 <syscall>
  801616:	83 c4 18             	add    $0x18,%esp
  801619:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80161c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801620:	75 07                	jne    801629 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801622:	b8 01 00 00 00       	mov    $0x1,%eax
  801627:	eb 05                	jmp    80162e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801629:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80162e:	c9                   	leave  
  80162f:	c3                   	ret    

00801630 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
  801633:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 2c                	push   $0x2c
  801642:	e8 7d fa ff ff       	call   8010c4 <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
  80164a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80164d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801651:	75 07                	jne    80165a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801653:	b8 01 00 00 00       	mov    $0x1,%eax
  801658:	eb 05                	jmp    80165f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80165a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 2c                	push   $0x2c
  801673:	e8 4c fa ff ff       	call   8010c4 <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
  80167b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80167e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801682:	75 07                	jne    80168b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801684:	b8 01 00 00 00       	mov    $0x1,%eax
  801689:	eb 05                	jmp    801690 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80168b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
  801695:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 2c                	push   $0x2c
  8016a4:	e8 1b fa ff ff       	call   8010c4 <syscall>
  8016a9:	83 c4 18             	add    $0x18,%esp
  8016ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016af:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016b3:	75 07                	jne    8016bc <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ba:	eb 05                	jmp    8016c1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8016bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	ff 75 08             	pushl  0x8(%ebp)
  8016d1:	6a 2d                	push   $0x2d
  8016d3:	e8 ec f9 ff ff       	call   8010c4 <syscall>
  8016d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016db:	90                   	nop
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    
  8016de:	66 90                	xchg   %ax,%ax

008016e0 <__udivdi3>:
  8016e0:	55                   	push   %ebp
  8016e1:	57                   	push   %edi
  8016e2:	56                   	push   %esi
  8016e3:	53                   	push   %ebx
  8016e4:	83 ec 1c             	sub    $0x1c,%esp
  8016e7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016eb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016f3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016f7:	89 ca                	mov    %ecx,%edx
  8016f9:	89 f8                	mov    %edi,%eax
  8016fb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016ff:	85 f6                	test   %esi,%esi
  801701:	75 2d                	jne    801730 <__udivdi3+0x50>
  801703:	39 cf                	cmp    %ecx,%edi
  801705:	77 65                	ja     80176c <__udivdi3+0x8c>
  801707:	89 fd                	mov    %edi,%ebp
  801709:	85 ff                	test   %edi,%edi
  80170b:	75 0b                	jne    801718 <__udivdi3+0x38>
  80170d:	b8 01 00 00 00       	mov    $0x1,%eax
  801712:	31 d2                	xor    %edx,%edx
  801714:	f7 f7                	div    %edi
  801716:	89 c5                	mov    %eax,%ebp
  801718:	31 d2                	xor    %edx,%edx
  80171a:	89 c8                	mov    %ecx,%eax
  80171c:	f7 f5                	div    %ebp
  80171e:	89 c1                	mov    %eax,%ecx
  801720:	89 d8                	mov    %ebx,%eax
  801722:	f7 f5                	div    %ebp
  801724:	89 cf                	mov    %ecx,%edi
  801726:	89 fa                	mov    %edi,%edx
  801728:	83 c4 1c             	add    $0x1c,%esp
  80172b:	5b                   	pop    %ebx
  80172c:	5e                   	pop    %esi
  80172d:	5f                   	pop    %edi
  80172e:	5d                   	pop    %ebp
  80172f:	c3                   	ret    
  801730:	39 ce                	cmp    %ecx,%esi
  801732:	77 28                	ja     80175c <__udivdi3+0x7c>
  801734:	0f bd fe             	bsr    %esi,%edi
  801737:	83 f7 1f             	xor    $0x1f,%edi
  80173a:	75 40                	jne    80177c <__udivdi3+0x9c>
  80173c:	39 ce                	cmp    %ecx,%esi
  80173e:	72 0a                	jb     80174a <__udivdi3+0x6a>
  801740:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801744:	0f 87 9e 00 00 00    	ja     8017e8 <__udivdi3+0x108>
  80174a:	b8 01 00 00 00       	mov    $0x1,%eax
  80174f:	89 fa                	mov    %edi,%edx
  801751:	83 c4 1c             	add    $0x1c,%esp
  801754:	5b                   	pop    %ebx
  801755:	5e                   	pop    %esi
  801756:	5f                   	pop    %edi
  801757:	5d                   	pop    %ebp
  801758:	c3                   	ret    
  801759:	8d 76 00             	lea    0x0(%esi),%esi
  80175c:	31 ff                	xor    %edi,%edi
  80175e:	31 c0                	xor    %eax,%eax
  801760:	89 fa                	mov    %edi,%edx
  801762:	83 c4 1c             	add    $0x1c,%esp
  801765:	5b                   	pop    %ebx
  801766:	5e                   	pop    %esi
  801767:	5f                   	pop    %edi
  801768:	5d                   	pop    %ebp
  801769:	c3                   	ret    
  80176a:	66 90                	xchg   %ax,%ax
  80176c:	89 d8                	mov    %ebx,%eax
  80176e:	f7 f7                	div    %edi
  801770:	31 ff                	xor    %edi,%edi
  801772:	89 fa                	mov    %edi,%edx
  801774:	83 c4 1c             	add    $0x1c,%esp
  801777:	5b                   	pop    %ebx
  801778:	5e                   	pop    %esi
  801779:	5f                   	pop    %edi
  80177a:	5d                   	pop    %ebp
  80177b:	c3                   	ret    
  80177c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801781:	89 eb                	mov    %ebp,%ebx
  801783:	29 fb                	sub    %edi,%ebx
  801785:	89 f9                	mov    %edi,%ecx
  801787:	d3 e6                	shl    %cl,%esi
  801789:	89 c5                	mov    %eax,%ebp
  80178b:	88 d9                	mov    %bl,%cl
  80178d:	d3 ed                	shr    %cl,%ebp
  80178f:	89 e9                	mov    %ebp,%ecx
  801791:	09 f1                	or     %esi,%ecx
  801793:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801797:	89 f9                	mov    %edi,%ecx
  801799:	d3 e0                	shl    %cl,%eax
  80179b:	89 c5                	mov    %eax,%ebp
  80179d:	89 d6                	mov    %edx,%esi
  80179f:	88 d9                	mov    %bl,%cl
  8017a1:	d3 ee                	shr    %cl,%esi
  8017a3:	89 f9                	mov    %edi,%ecx
  8017a5:	d3 e2                	shl    %cl,%edx
  8017a7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017ab:	88 d9                	mov    %bl,%cl
  8017ad:	d3 e8                	shr    %cl,%eax
  8017af:	09 c2                	or     %eax,%edx
  8017b1:	89 d0                	mov    %edx,%eax
  8017b3:	89 f2                	mov    %esi,%edx
  8017b5:	f7 74 24 0c          	divl   0xc(%esp)
  8017b9:	89 d6                	mov    %edx,%esi
  8017bb:	89 c3                	mov    %eax,%ebx
  8017bd:	f7 e5                	mul    %ebp
  8017bf:	39 d6                	cmp    %edx,%esi
  8017c1:	72 19                	jb     8017dc <__udivdi3+0xfc>
  8017c3:	74 0b                	je     8017d0 <__udivdi3+0xf0>
  8017c5:	89 d8                	mov    %ebx,%eax
  8017c7:	31 ff                	xor    %edi,%edi
  8017c9:	e9 58 ff ff ff       	jmp    801726 <__udivdi3+0x46>
  8017ce:	66 90                	xchg   %ax,%ax
  8017d0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017d4:	89 f9                	mov    %edi,%ecx
  8017d6:	d3 e2                	shl    %cl,%edx
  8017d8:	39 c2                	cmp    %eax,%edx
  8017da:	73 e9                	jae    8017c5 <__udivdi3+0xe5>
  8017dc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017df:	31 ff                	xor    %edi,%edi
  8017e1:	e9 40 ff ff ff       	jmp    801726 <__udivdi3+0x46>
  8017e6:	66 90                	xchg   %ax,%ax
  8017e8:	31 c0                	xor    %eax,%eax
  8017ea:	e9 37 ff ff ff       	jmp    801726 <__udivdi3+0x46>
  8017ef:	90                   	nop

008017f0 <__umoddi3>:
  8017f0:	55                   	push   %ebp
  8017f1:	57                   	push   %edi
  8017f2:	56                   	push   %esi
  8017f3:	53                   	push   %ebx
  8017f4:	83 ec 1c             	sub    $0x1c,%esp
  8017f7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017fb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801803:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801807:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80180b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80180f:	89 f3                	mov    %esi,%ebx
  801811:	89 fa                	mov    %edi,%edx
  801813:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801817:	89 34 24             	mov    %esi,(%esp)
  80181a:	85 c0                	test   %eax,%eax
  80181c:	75 1a                	jne    801838 <__umoddi3+0x48>
  80181e:	39 f7                	cmp    %esi,%edi
  801820:	0f 86 a2 00 00 00    	jbe    8018c8 <__umoddi3+0xd8>
  801826:	89 c8                	mov    %ecx,%eax
  801828:	89 f2                	mov    %esi,%edx
  80182a:	f7 f7                	div    %edi
  80182c:	89 d0                	mov    %edx,%eax
  80182e:	31 d2                	xor    %edx,%edx
  801830:	83 c4 1c             	add    $0x1c,%esp
  801833:	5b                   	pop    %ebx
  801834:	5e                   	pop    %esi
  801835:	5f                   	pop    %edi
  801836:	5d                   	pop    %ebp
  801837:	c3                   	ret    
  801838:	39 f0                	cmp    %esi,%eax
  80183a:	0f 87 ac 00 00 00    	ja     8018ec <__umoddi3+0xfc>
  801840:	0f bd e8             	bsr    %eax,%ebp
  801843:	83 f5 1f             	xor    $0x1f,%ebp
  801846:	0f 84 ac 00 00 00    	je     8018f8 <__umoddi3+0x108>
  80184c:	bf 20 00 00 00       	mov    $0x20,%edi
  801851:	29 ef                	sub    %ebp,%edi
  801853:	89 fe                	mov    %edi,%esi
  801855:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801859:	89 e9                	mov    %ebp,%ecx
  80185b:	d3 e0                	shl    %cl,%eax
  80185d:	89 d7                	mov    %edx,%edi
  80185f:	89 f1                	mov    %esi,%ecx
  801861:	d3 ef                	shr    %cl,%edi
  801863:	09 c7                	or     %eax,%edi
  801865:	89 e9                	mov    %ebp,%ecx
  801867:	d3 e2                	shl    %cl,%edx
  801869:	89 14 24             	mov    %edx,(%esp)
  80186c:	89 d8                	mov    %ebx,%eax
  80186e:	d3 e0                	shl    %cl,%eax
  801870:	89 c2                	mov    %eax,%edx
  801872:	8b 44 24 08          	mov    0x8(%esp),%eax
  801876:	d3 e0                	shl    %cl,%eax
  801878:	89 44 24 04          	mov    %eax,0x4(%esp)
  80187c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801880:	89 f1                	mov    %esi,%ecx
  801882:	d3 e8                	shr    %cl,%eax
  801884:	09 d0                	or     %edx,%eax
  801886:	d3 eb                	shr    %cl,%ebx
  801888:	89 da                	mov    %ebx,%edx
  80188a:	f7 f7                	div    %edi
  80188c:	89 d3                	mov    %edx,%ebx
  80188e:	f7 24 24             	mull   (%esp)
  801891:	89 c6                	mov    %eax,%esi
  801893:	89 d1                	mov    %edx,%ecx
  801895:	39 d3                	cmp    %edx,%ebx
  801897:	0f 82 87 00 00 00    	jb     801924 <__umoddi3+0x134>
  80189d:	0f 84 91 00 00 00    	je     801934 <__umoddi3+0x144>
  8018a3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018a7:	29 f2                	sub    %esi,%edx
  8018a9:	19 cb                	sbb    %ecx,%ebx
  8018ab:	89 d8                	mov    %ebx,%eax
  8018ad:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018b1:	d3 e0                	shl    %cl,%eax
  8018b3:	89 e9                	mov    %ebp,%ecx
  8018b5:	d3 ea                	shr    %cl,%edx
  8018b7:	09 d0                	or     %edx,%eax
  8018b9:	89 e9                	mov    %ebp,%ecx
  8018bb:	d3 eb                	shr    %cl,%ebx
  8018bd:	89 da                	mov    %ebx,%edx
  8018bf:	83 c4 1c             	add    $0x1c,%esp
  8018c2:	5b                   	pop    %ebx
  8018c3:	5e                   	pop    %esi
  8018c4:	5f                   	pop    %edi
  8018c5:	5d                   	pop    %ebp
  8018c6:	c3                   	ret    
  8018c7:	90                   	nop
  8018c8:	89 fd                	mov    %edi,%ebp
  8018ca:	85 ff                	test   %edi,%edi
  8018cc:	75 0b                	jne    8018d9 <__umoddi3+0xe9>
  8018ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8018d3:	31 d2                	xor    %edx,%edx
  8018d5:	f7 f7                	div    %edi
  8018d7:	89 c5                	mov    %eax,%ebp
  8018d9:	89 f0                	mov    %esi,%eax
  8018db:	31 d2                	xor    %edx,%edx
  8018dd:	f7 f5                	div    %ebp
  8018df:	89 c8                	mov    %ecx,%eax
  8018e1:	f7 f5                	div    %ebp
  8018e3:	89 d0                	mov    %edx,%eax
  8018e5:	e9 44 ff ff ff       	jmp    80182e <__umoddi3+0x3e>
  8018ea:	66 90                	xchg   %ax,%ax
  8018ec:	89 c8                	mov    %ecx,%eax
  8018ee:	89 f2                	mov    %esi,%edx
  8018f0:	83 c4 1c             	add    $0x1c,%esp
  8018f3:	5b                   	pop    %ebx
  8018f4:	5e                   	pop    %esi
  8018f5:	5f                   	pop    %edi
  8018f6:	5d                   	pop    %ebp
  8018f7:	c3                   	ret    
  8018f8:	3b 04 24             	cmp    (%esp),%eax
  8018fb:	72 06                	jb     801903 <__umoddi3+0x113>
  8018fd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801901:	77 0f                	ja     801912 <__umoddi3+0x122>
  801903:	89 f2                	mov    %esi,%edx
  801905:	29 f9                	sub    %edi,%ecx
  801907:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80190b:	89 14 24             	mov    %edx,(%esp)
  80190e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801912:	8b 44 24 04          	mov    0x4(%esp),%eax
  801916:	8b 14 24             	mov    (%esp),%edx
  801919:	83 c4 1c             	add    $0x1c,%esp
  80191c:	5b                   	pop    %ebx
  80191d:	5e                   	pop    %esi
  80191e:	5f                   	pop    %edi
  80191f:	5d                   	pop    %ebp
  801920:	c3                   	ret    
  801921:	8d 76 00             	lea    0x0(%esi),%esi
  801924:	2b 04 24             	sub    (%esp),%eax
  801927:	19 fa                	sbb    %edi,%edx
  801929:	89 d1                	mov    %edx,%ecx
  80192b:	89 c6                	mov    %eax,%esi
  80192d:	e9 71 ff ff ff       	jmp    8018a3 <__umoddi3+0xb3>
  801932:	66 90                	xchg   %ax,%ax
  801934:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801938:	72 ea                	jb     801924 <__umoddi3+0x134>
  80193a:	89 d9                	mov    %ebx,%ecx
  80193c:	e9 62 ff ff ff       	jmp    8018a3 <__umoddi3+0xb3>
