
obj/user/fos_alloc:     file format elf32-i386


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
  800031:	e8 02 01 00 00       	call   800138 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//uint32 size = 2*1024*1024 +120*4096+1;
	//uint32 size = 1*1024*1024 + 256*1024;
	//uint32 size = 1*1024*1024;
	uint32 size = 100;
  80003e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)

	unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800045:	83 ec 0c             	sub    $0xc,%esp
  800048:	ff 75 f0             	pushl  -0x10(%ebp)
  80004b:	e8 55 10 00 00       	call   8010a5 <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 c0 1d 80 00       	push   $0x801dc0
  800061:	e8 e2 02 00 00       	call   800348 <atomic_cprintf>
  800066:	83 c4 10             	add    $0x10,%esp

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  800069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800070:	eb 20                	jmp    800092 <_main+0x5a>
	{
		x[i] = i%256 ;
  800072:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800075:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800078:	01 c2                	add    %eax,%edx
  80007a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007d:	25 ff 00 00 80       	and    $0x800000ff,%eax
  800082:	85 c0                	test   %eax,%eax
  800084:	79 07                	jns    80008d <_main+0x55>
  800086:	48                   	dec    %eax
  800087:	0d 00 ff ff ff       	or     $0xffffff00,%eax
  80008c:	40                   	inc    %eax
  80008d:	88 02                	mov    %al,(%edx)

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  80008f:	ff 45 f4             	incl   -0xc(%ebp)
  800092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800095:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800098:	72 d8                	jb     800072 <_main+0x3a>
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  80009a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80009d:	83 e8 07             	sub    $0x7,%eax
  8000a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000a3:	eb 24                	jmp    8000c9 <_main+0x91>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
  8000a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8a 00                	mov    (%eax),%al
  8000af:	0f b6 c0             	movzbl %al,%eax
  8000b2:	83 ec 04             	sub    $0x4,%esp
  8000b5:	50                   	push   %eax
  8000b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b9:	68 d3 1d 80 00       	push   $0x801dd3
  8000be:	e8 85 02 00 00       	call   800348 <atomic_cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  8000c6:	ff 45 f4             	incl   -0xc(%ebp)
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cf:	72 d4                	jb     8000a5 <_main+0x6d>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
	
	free(x);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 81 11 00 00       	call   80125d <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 bb 0f 00 00       	call   8010a5 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
	
	for (i = size-7 ; i < size ; i++)
  8000f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f3:	83 e8 07             	sub    $0x7,%eax
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000f9:	eb 24                	jmp    80011f <_main+0xe7>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
  8000fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	8a 00                	mov    (%eax),%al
  800105:	0f b6 c0             	movzbl %al,%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	50                   	push   %eax
  80010c:	ff 75 f4             	pushl  -0xc(%ebp)
  80010f:	68 d3 1d 80 00       	push   $0x801dd3
  800114:	e8 2f 02 00 00       	call   800348 <atomic_cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
	
	free(x);

	x = malloc(sizeof(unsigned char)*size) ;
	
	for (i = size-7 ; i < size ; i++)
  80011c:	ff 45 f4             	incl   -0xc(%ebp)
  80011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800125:	72 d4                	jb     8000fb <_main+0xc3>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
	}

	free(x);
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	ff 75 ec             	pushl  -0x14(%ebp)
  80012d:	e8 2b 11 00 00       	call   80125d <free>
  800132:	83 c4 10             	add    $0x10,%esp
	
	return;	
  800135:	90                   	nop
}
  800136:	c9                   	leave  
  800137:	c3                   	ret    

00800138 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800138:	55                   	push   %ebp
  800139:	89 e5                	mov    %esp,%ebp
  80013b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80013e:	e8 a2 12 00 00       	call   8013e5 <sys_getenvindex>
  800143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800146:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800149:	89 d0                	mov    %edx,%eax
  80014b:	c1 e0 02             	shl    $0x2,%eax
  80014e:	01 d0                	add    %edx,%eax
  800150:	01 c0                	add    %eax,%eax
  800152:	01 d0                	add    %edx,%eax
  800154:	01 c0                	add    %eax,%eax
  800156:	01 d0                	add    %edx,%eax
  800158:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80015f:	01 d0                	add    %edx,%eax
  800161:	c1 e0 02             	shl    $0x2,%eax
  800164:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800169:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80016e:	a1 20 30 80 00       	mov    0x803020,%eax
  800173:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800179:	84 c0                	test   %al,%al
  80017b:	74 0f                	je     80018c <libmain+0x54>
		binaryname = myEnv->prog_name;
  80017d:	a1 20 30 80 00       	mov    0x803020,%eax
  800182:	05 f4 02 00 00       	add    $0x2f4,%eax
  800187:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80018c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800190:	7e 0a                	jle    80019c <libmain+0x64>
		binaryname = argv[0];
  800192:	8b 45 0c             	mov    0xc(%ebp),%eax
  800195:	8b 00                	mov    (%eax),%eax
  800197:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80019c:	83 ec 08             	sub    $0x8,%esp
  80019f:	ff 75 0c             	pushl  0xc(%ebp)
  8001a2:	ff 75 08             	pushl  0x8(%ebp)
  8001a5:	e8 8e fe ff ff       	call   800038 <_main>
  8001aa:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001ad:	e8 ce 13 00 00       	call   801580 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 f8 1d 80 00       	push   $0x801df8
  8001ba:	e8 5c 01 00 00       	call   80031b <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c7:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d2:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	52                   	push   %edx
  8001dc:	50                   	push   %eax
  8001dd:	68 20 1e 80 00       	push   $0x801e20
  8001e2:	e8 34 01 00 00       	call   80031b <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ef:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001f5:	83 ec 08             	sub    $0x8,%esp
  8001f8:	50                   	push   %eax
  8001f9:	68 45 1e 80 00       	push   $0x801e45
  8001fe:	e8 18 01 00 00       	call   80031b <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 f8 1d 80 00       	push   $0x801df8
  80020e:	e8 08 01 00 00       	call   80031b <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800216:	e8 7f 13 00 00       	call   80159a <sys_enable_interrupt>

	// exit gracefully
	exit();
  80021b:	e8 19 00 00 00       	call   800239 <exit>
}
  800220:	90                   	nop
  800221:	c9                   	leave  
  800222:	c3                   	ret    

00800223 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800223:	55                   	push   %ebp
  800224:	89 e5                	mov    %esp,%ebp
  800226:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800229:	83 ec 0c             	sub    $0xc,%esp
  80022c:	6a 00                	push   $0x0
  80022e:	e8 7e 11 00 00       	call   8013b1 <sys_env_destroy>
  800233:	83 c4 10             	add    $0x10,%esp
}
  800236:	90                   	nop
  800237:	c9                   	leave  
  800238:	c3                   	ret    

00800239 <exit>:

void
exit(void)
{
  800239:	55                   	push   %ebp
  80023a:	89 e5                	mov    %esp,%ebp
  80023c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80023f:	e8 d3 11 00 00       	call   801417 <sys_env_exit>
}
  800244:	90                   	nop
  800245:	c9                   	leave  
  800246:	c3                   	ret    

00800247 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800247:	55                   	push   %ebp
  800248:	89 e5                	mov    %esp,%ebp
  80024a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80024d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800250:	8b 00                	mov    (%eax),%eax
  800252:	8d 48 01             	lea    0x1(%eax),%ecx
  800255:	8b 55 0c             	mov    0xc(%ebp),%edx
  800258:	89 0a                	mov    %ecx,(%edx)
  80025a:	8b 55 08             	mov    0x8(%ebp),%edx
  80025d:	88 d1                	mov    %dl,%cl
  80025f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800262:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800266:	8b 45 0c             	mov    0xc(%ebp),%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800270:	75 2c                	jne    80029e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800272:	a0 24 30 80 00       	mov    0x803024,%al
  800277:	0f b6 c0             	movzbl %al,%eax
  80027a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027d:	8b 12                	mov    (%edx),%edx
  80027f:	89 d1                	mov    %edx,%ecx
  800281:	8b 55 0c             	mov    0xc(%ebp),%edx
  800284:	83 c2 08             	add    $0x8,%edx
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	50                   	push   %eax
  80028b:	51                   	push   %ecx
  80028c:	52                   	push   %edx
  80028d:	e8 dd 10 00 00       	call   80136f <sys_cputs>
  800292:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800295:	8b 45 0c             	mov    0xc(%ebp),%eax
  800298:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80029e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a1:	8b 40 04             	mov    0x4(%eax),%eax
  8002a4:	8d 50 01             	lea    0x1(%eax),%edx
  8002a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002aa:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002ad:	90                   	nop
  8002ae:	c9                   	leave  
  8002af:	c3                   	ret    

008002b0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002b9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002c0:	00 00 00 
	b.cnt = 0;
  8002c3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002ca:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002cd:	ff 75 0c             	pushl  0xc(%ebp)
  8002d0:	ff 75 08             	pushl  0x8(%ebp)
  8002d3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002d9:	50                   	push   %eax
  8002da:	68 47 02 80 00       	push   $0x800247
  8002df:	e8 11 02 00 00       	call   8004f5 <vprintfmt>
  8002e4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002e7:	a0 24 30 80 00       	mov    0x803024,%al
  8002ec:	0f b6 c0             	movzbl %al,%eax
  8002ef:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002f5:	83 ec 04             	sub    $0x4,%esp
  8002f8:	50                   	push   %eax
  8002f9:	52                   	push   %edx
  8002fa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800300:	83 c0 08             	add    $0x8,%eax
  800303:	50                   	push   %eax
  800304:	e8 66 10 00 00       	call   80136f <sys_cputs>
  800309:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80030c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800313:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <cprintf>:

int cprintf(const char *fmt, ...) {
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800321:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800328:	8d 45 0c             	lea    0xc(%ebp),%eax
  80032b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80032e:	8b 45 08             	mov    0x8(%ebp),%eax
  800331:	83 ec 08             	sub    $0x8,%esp
  800334:	ff 75 f4             	pushl  -0xc(%ebp)
  800337:	50                   	push   %eax
  800338:	e8 73 ff ff ff       	call   8002b0 <vcprintf>
  80033d:	83 c4 10             	add    $0x10,%esp
  800340:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800343:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800346:	c9                   	leave  
  800347:	c3                   	ret    

00800348 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800348:	55                   	push   %ebp
  800349:	89 e5                	mov    %esp,%ebp
  80034b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80034e:	e8 2d 12 00 00       	call   801580 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800353:	8d 45 0c             	lea    0xc(%ebp),%eax
  800356:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800359:	8b 45 08             	mov    0x8(%ebp),%eax
  80035c:	83 ec 08             	sub    $0x8,%esp
  80035f:	ff 75 f4             	pushl  -0xc(%ebp)
  800362:	50                   	push   %eax
  800363:	e8 48 ff ff ff       	call   8002b0 <vcprintf>
  800368:	83 c4 10             	add    $0x10,%esp
  80036b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80036e:	e8 27 12 00 00       	call   80159a <sys_enable_interrupt>
	return cnt;
  800373:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800376:	c9                   	leave  
  800377:	c3                   	ret    

00800378 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800378:	55                   	push   %ebp
  800379:	89 e5                	mov    %esp,%ebp
  80037b:	53                   	push   %ebx
  80037c:	83 ec 14             	sub    $0x14,%esp
  80037f:	8b 45 10             	mov    0x10(%ebp),%eax
  800382:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800385:	8b 45 14             	mov    0x14(%ebp),%eax
  800388:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80038b:	8b 45 18             	mov    0x18(%ebp),%eax
  80038e:	ba 00 00 00 00       	mov    $0x0,%edx
  800393:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800396:	77 55                	ja     8003ed <printnum+0x75>
  800398:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80039b:	72 05                	jb     8003a2 <printnum+0x2a>
  80039d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003a0:	77 4b                	ja     8003ed <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003a2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003a5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003a8:	8b 45 18             	mov    0x18(%ebp),%eax
  8003ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8003b0:	52                   	push   %edx
  8003b1:	50                   	push   %eax
  8003b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b5:	ff 75 f0             	pushl  -0x10(%ebp)
  8003b8:	e8 83 17 00 00       	call   801b40 <__udivdi3>
  8003bd:	83 c4 10             	add    $0x10,%esp
  8003c0:	83 ec 04             	sub    $0x4,%esp
  8003c3:	ff 75 20             	pushl  0x20(%ebp)
  8003c6:	53                   	push   %ebx
  8003c7:	ff 75 18             	pushl  0x18(%ebp)
  8003ca:	52                   	push   %edx
  8003cb:	50                   	push   %eax
  8003cc:	ff 75 0c             	pushl  0xc(%ebp)
  8003cf:	ff 75 08             	pushl  0x8(%ebp)
  8003d2:	e8 a1 ff ff ff       	call   800378 <printnum>
  8003d7:	83 c4 20             	add    $0x20,%esp
  8003da:	eb 1a                	jmp    8003f6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003dc:	83 ec 08             	sub    $0x8,%esp
  8003df:	ff 75 0c             	pushl  0xc(%ebp)
  8003e2:	ff 75 20             	pushl  0x20(%ebp)
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	ff d0                	call   *%eax
  8003ea:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ed:	ff 4d 1c             	decl   0x1c(%ebp)
  8003f0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003f4:	7f e6                	jg     8003dc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003f6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003f9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800401:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800404:	53                   	push   %ebx
  800405:	51                   	push   %ecx
  800406:	52                   	push   %edx
  800407:	50                   	push   %eax
  800408:	e8 43 18 00 00       	call   801c50 <__umoddi3>
  80040d:	83 c4 10             	add    $0x10,%esp
  800410:	05 74 20 80 00       	add    $0x802074,%eax
  800415:	8a 00                	mov    (%eax),%al
  800417:	0f be c0             	movsbl %al,%eax
  80041a:	83 ec 08             	sub    $0x8,%esp
  80041d:	ff 75 0c             	pushl  0xc(%ebp)
  800420:	50                   	push   %eax
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	ff d0                	call   *%eax
  800426:	83 c4 10             	add    $0x10,%esp
}
  800429:	90                   	nop
  80042a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80042d:	c9                   	leave  
  80042e:	c3                   	ret    

0080042f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80042f:	55                   	push   %ebp
  800430:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800432:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800436:	7e 1c                	jle    800454 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	8d 50 08             	lea    0x8(%eax),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	89 10                	mov    %edx,(%eax)
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	83 e8 08             	sub    $0x8,%eax
  80044d:	8b 50 04             	mov    0x4(%eax),%edx
  800450:	8b 00                	mov    (%eax),%eax
  800452:	eb 40                	jmp    800494 <getuint+0x65>
	else if (lflag)
  800454:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800458:	74 1e                	je     800478 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80045a:	8b 45 08             	mov    0x8(%ebp),%eax
  80045d:	8b 00                	mov    (%eax),%eax
  80045f:	8d 50 04             	lea    0x4(%eax),%edx
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	89 10                	mov    %edx,(%eax)
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	83 e8 04             	sub    $0x4,%eax
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	ba 00 00 00 00       	mov    $0x0,%edx
  800476:	eb 1c                	jmp    800494 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	8d 50 04             	lea    0x4(%eax),%edx
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	89 10                	mov    %edx,(%eax)
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	83 e8 04             	sub    $0x4,%eax
  80048d:	8b 00                	mov    (%eax),%eax
  80048f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800494:	5d                   	pop    %ebp
  800495:	c3                   	ret    

00800496 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800496:	55                   	push   %ebp
  800497:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800499:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80049d:	7e 1c                	jle    8004bb <getint+0x25>
		return va_arg(*ap, long long);
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	8b 00                	mov    (%eax),%eax
  8004a4:	8d 50 08             	lea    0x8(%eax),%edx
  8004a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004aa:	89 10                	mov    %edx,(%eax)
  8004ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	83 e8 08             	sub    $0x8,%eax
  8004b4:	8b 50 04             	mov    0x4(%eax),%edx
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	eb 38                	jmp    8004f3 <getint+0x5d>
	else if (lflag)
  8004bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004bf:	74 1a                	je     8004db <getint+0x45>
		return va_arg(*ap, long);
  8004c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	8d 50 04             	lea    0x4(%eax),%edx
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	89 10                	mov    %edx,(%eax)
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	83 e8 04             	sub    $0x4,%eax
  8004d6:	8b 00                	mov    (%eax),%eax
  8004d8:	99                   	cltd   
  8004d9:	eb 18                	jmp    8004f3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	8d 50 04             	lea    0x4(%eax),%edx
  8004e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e6:	89 10                	mov    %edx,(%eax)
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	8b 00                	mov    (%eax),%eax
  8004ed:	83 e8 04             	sub    $0x4,%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	99                   	cltd   
}
  8004f3:	5d                   	pop    %ebp
  8004f4:	c3                   	ret    

008004f5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004f5:	55                   	push   %ebp
  8004f6:	89 e5                	mov    %esp,%ebp
  8004f8:	56                   	push   %esi
  8004f9:	53                   	push   %ebx
  8004fa:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004fd:	eb 17                	jmp    800516 <vprintfmt+0x21>
			if (ch == '\0')
  8004ff:	85 db                	test   %ebx,%ebx
  800501:	0f 84 af 03 00 00    	je     8008b6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800507:	83 ec 08             	sub    $0x8,%esp
  80050a:	ff 75 0c             	pushl  0xc(%ebp)
  80050d:	53                   	push   %ebx
  80050e:	8b 45 08             	mov    0x8(%ebp),%eax
  800511:	ff d0                	call   *%eax
  800513:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800516:	8b 45 10             	mov    0x10(%ebp),%eax
  800519:	8d 50 01             	lea    0x1(%eax),%edx
  80051c:	89 55 10             	mov    %edx,0x10(%ebp)
  80051f:	8a 00                	mov    (%eax),%al
  800521:	0f b6 d8             	movzbl %al,%ebx
  800524:	83 fb 25             	cmp    $0x25,%ebx
  800527:	75 d6                	jne    8004ff <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800529:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80052d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800534:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80053b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800542:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800549:	8b 45 10             	mov    0x10(%ebp),%eax
  80054c:	8d 50 01             	lea    0x1(%eax),%edx
  80054f:	89 55 10             	mov    %edx,0x10(%ebp)
  800552:	8a 00                	mov    (%eax),%al
  800554:	0f b6 d8             	movzbl %al,%ebx
  800557:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80055a:	83 f8 55             	cmp    $0x55,%eax
  80055d:	0f 87 2b 03 00 00    	ja     80088e <vprintfmt+0x399>
  800563:	8b 04 85 98 20 80 00 	mov    0x802098(,%eax,4),%eax
  80056a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80056c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800570:	eb d7                	jmp    800549 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800572:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800576:	eb d1                	jmp    800549 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800578:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80057f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800582:	89 d0                	mov    %edx,%eax
  800584:	c1 e0 02             	shl    $0x2,%eax
  800587:	01 d0                	add    %edx,%eax
  800589:	01 c0                	add    %eax,%eax
  80058b:	01 d8                	add    %ebx,%eax
  80058d:	83 e8 30             	sub    $0x30,%eax
  800590:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800593:	8b 45 10             	mov    0x10(%ebp),%eax
  800596:	8a 00                	mov    (%eax),%al
  800598:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80059b:	83 fb 2f             	cmp    $0x2f,%ebx
  80059e:	7e 3e                	jle    8005de <vprintfmt+0xe9>
  8005a0:	83 fb 39             	cmp    $0x39,%ebx
  8005a3:	7f 39                	jg     8005de <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005a5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005a8:	eb d5                	jmp    80057f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ad:	83 c0 04             	add    $0x4,%eax
  8005b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b6:	83 e8 04             	sub    $0x4,%eax
  8005b9:	8b 00                	mov    (%eax),%eax
  8005bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005be:	eb 1f                	jmp    8005df <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005c0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c4:	79 83                	jns    800549 <vprintfmt+0x54>
				width = 0;
  8005c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005cd:	e9 77 ff ff ff       	jmp    800549 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005d2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005d9:	e9 6b ff ff ff       	jmp    800549 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005de:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e3:	0f 89 60 ff ff ff    	jns    800549 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ef:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005f6:	e9 4e ff ff ff       	jmp    800549 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005fb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005fe:	e9 46 ff ff ff       	jmp    800549 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800603:	8b 45 14             	mov    0x14(%ebp),%eax
  800606:	83 c0 04             	add    $0x4,%eax
  800609:	89 45 14             	mov    %eax,0x14(%ebp)
  80060c:	8b 45 14             	mov    0x14(%ebp),%eax
  80060f:	83 e8 04             	sub    $0x4,%eax
  800612:	8b 00                	mov    (%eax),%eax
  800614:	83 ec 08             	sub    $0x8,%esp
  800617:	ff 75 0c             	pushl  0xc(%ebp)
  80061a:	50                   	push   %eax
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	ff d0                	call   *%eax
  800620:	83 c4 10             	add    $0x10,%esp
			break;
  800623:	e9 89 02 00 00       	jmp    8008b1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800628:	8b 45 14             	mov    0x14(%ebp),%eax
  80062b:	83 c0 04             	add    $0x4,%eax
  80062e:	89 45 14             	mov    %eax,0x14(%ebp)
  800631:	8b 45 14             	mov    0x14(%ebp),%eax
  800634:	83 e8 04             	sub    $0x4,%eax
  800637:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800639:	85 db                	test   %ebx,%ebx
  80063b:	79 02                	jns    80063f <vprintfmt+0x14a>
				err = -err;
  80063d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80063f:	83 fb 64             	cmp    $0x64,%ebx
  800642:	7f 0b                	jg     80064f <vprintfmt+0x15a>
  800644:	8b 34 9d e0 1e 80 00 	mov    0x801ee0(,%ebx,4),%esi
  80064b:	85 f6                	test   %esi,%esi
  80064d:	75 19                	jne    800668 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80064f:	53                   	push   %ebx
  800650:	68 85 20 80 00       	push   $0x802085
  800655:	ff 75 0c             	pushl  0xc(%ebp)
  800658:	ff 75 08             	pushl  0x8(%ebp)
  80065b:	e8 5e 02 00 00       	call   8008be <printfmt>
  800660:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800663:	e9 49 02 00 00       	jmp    8008b1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800668:	56                   	push   %esi
  800669:	68 8e 20 80 00       	push   $0x80208e
  80066e:	ff 75 0c             	pushl  0xc(%ebp)
  800671:	ff 75 08             	pushl  0x8(%ebp)
  800674:	e8 45 02 00 00       	call   8008be <printfmt>
  800679:	83 c4 10             	add    $0x10,%esp
			break;
  80067c:	e9 30 02 00 00       	jmp    8008b1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800681:	8b 45 14             	mov    0x14(%ebp),%eax
  800684:	83 c0 04             	add    $0x4,%eax
  800687:	89 45 14             	mov    %eax,0x14(%ebp)
  80068a:	8b 45 14             	mov    0x14(%ebp),%eax
  80068d:	83 e8 04             	sub    $0x4,%eax
  800690:	8b 30                	mov    (%eax),%esi
  800692:	85 f6                	test   %esi,%esi
  800694:	75 05                	jne    80069b <vprintfmt+0x1a6>
				p = "(null)";
  800696:	be 91 20 80 00       	mov    $0x802091,%esi
			if (width > 0 && padc != '-')
  80069b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80069f:	7e 6d                	jle    80070e <vprintfmt+0x219>
  8006a1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006a5:	74 67                	je     80070e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006aa:	83 ec 08             	sub    $0x8,%esp
  8006ad:	50                   	push   %eax
  8006ae:	56                   	push   %esi
  8006af:	e8 0c 03 00 00       	call   8009c0 <strnlen>
  8006b4:	83 c4 10             	add    $0x10,%esp
  8006b7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006ba:	eb 16                	jmp    8006d2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006bc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006c0:	83 ec 08             	sub    $0x8,%esp
  8006c3:	ff 75 0c             	pushl  0xc(%ebp)
  8006c6:	50                   	push   %eax
  8006c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ca:	ff d0                	call   *%eax
  8006cc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006cf:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d6:	7f e4                	jg     8006bc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006d8:	eb 34                	jmp    80070e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006da:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006de:	74 1c                	je     8006fc <vprintfmt+0x207>
  8006e0:	83 fb 1f             	cmp    $0x1f,%ebx
  8006e3:	7e 05                	jle    8006ea <vprintfmt+0x1f5>
  8006e5:	83 fb 7e             	cmp    $0x7e,%ebx
  8006e8:	7e 12                	jle    8006fc <vprintfmt+0x207>
					putch('?', putdat);
  8006ea:	83 ec 08             	sub    $0x8,%esp
  8006ed:	ff 75 0c             	pushl  0xc(%ebp)
  8006f0:	6a 3f                	push   $0x3f
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	ff d0                	call   *%eax
  8006f7:	83 c4 10             	add    $0x10,%esp
  8006fa:	eb 0f                	jmp    80070b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 0c             	pushl  0xc(%ebp)
  800702:	53                   	push   %ebx
  800703:	8b 45 08             	mov    0x8(%ebp),%eax
  800706:	ff d0                	call   *%eax
  800708:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80070b:	ff 4d e4             	decl   -0x1c(%ebp)
  80070e:	89 f0                	mov    %esi,%eax
  800710:	8d 70 01             	lea    0x1(%eax),%esi
  800713:	8a 00                	mov    (%eax),%al
  800715:	0f be d8             	movsbl %al,%ebx
  800718:	85 db                	test   %ebx,%ebx
  80071a:	74 24                	je     800740 <vprintfmt+0x24b>
  80071c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800720:	78 b8                	js     8006da <vprintfmt+0x1e5>
  800722:	ff 4d e0             	decl   -0x20(%ebp)
  800725:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800729:	79 af                	jns    8006da <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80072b:	eb 13                	jmp    800740 <vprintfmt+0x24b>
				putch(' ', putdat);
  80072d:	83 ec 08             	sub    $0x8,%esp
  800730:	ff 75 0c             	pushl  0xc(%ebp)
  800733:	6a 20                	push   $0x20
  800735:	8b 45 08             	mov    0x8(%ebp),%eax
  800738:	ff d0                	call   *%eax
  80073a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80073d:	ff 4d e4             	decl   -0x1c(%ebp)
  800740:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800744:	7f e7                	jg     80072d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800746:	e9 66 01 00 00       	jmp    8008b1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 e8             	pushl  -0x18(%ebp)
  800751:	8d 45 14             	lea    0x14(%ebp),%eax
  800754:	50                   	push   %eax
  800755:	e8 3c fd ff ff       	call   800496 <getint>
  80075a:	83 c4 10             	add    $0x10,%esp
  80075d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800760:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800763:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800766:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800769:	85 d2                	test   %edx,%edx
  80076b:	79 23                	jns    800790 <vprintfmt+0x29b>
				putch('-', putdat);
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	6a 2d                	push   $0x2d
  800775:	8b 45 08             	mov    0x8(%ebp),%eax
  800778:	ff d0                	call   *%eax
  80077a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80077d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800780:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800783:	f7 d8                	neg    %eax
  800785:	83 d2 00             	adc    $0x0,%edx
  800788:	f7 da                	neg    %edx
  80078a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800790:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800797:	e9 bc 00 00 00       	jmp    800858 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80079c:	83 ec 08             	sub    $0x8,%esp
  80079f:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a2:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a5:	50                   	push   %eax
  8007a6:	e8 84 fc ff ff       	call   80042f <getuint>
  8007ab:	83 c4 10             	add    $0x10,%esp
  8007ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007b4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007bb:	e9 98 00 00 00       	jmp    800858 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007c0:	83 ec 08             	sub    $0x8,%esp
  8007c3:	ff 75 0c             	pushl  0xc(%ebp)
  8007c6:	6a 58                	push   $0x58
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007d0:	83 ec 08             	sub    $0x8,%esp
  8007d3:	ff 75 0c             	pushl  0xc(%ebp)
  8007d6:	6a 58                	push   $0x58
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	ff d0                	call   *%eax
  8007dd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007e0:	83 ec 08             	sub    $0x8,%esp
  8007e3:	ff 75 0c             	pushl  0xc(%ebp)
  8007e6:	6a 58                	push   $0x58
  8007e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007eb:	ff d0                	call   *%eax
  8007ed:	83 c4 10             	add    $0x10,%esp
			break;
  8007f0:	e9 bc 00 00 00       	jmp    8008b1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	6a 30                	push   $0x30
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	6a 78                	push   $0x78
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	ff d0                	call   *%eax
  800812:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 14             	mov    %eax,0x14(%ebp)
  80081e:	8b 45 14             	mov    0x14(%ebp),%eax
  800821:	83 e8 04             	sub    $0x4,%eax
  800824:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800826:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800829:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800830:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800837:	eb 1f                	jmp    800858 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	ff 75 e8             	pushl  -0x18(%ebp)
  80083f:	8d 45 14             	lea    0x14(%ebp),%eax
  800842:	50                   	push   %eax
  800843:	e8 e7 fb ff ff       	call   80042f <getuint>
  800848:	83 c4 10             	add    $0x10,%esp
  80084b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800851:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800858:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80085c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80085f:	83 ec 04             	sub    $0x4,%esp
  800862:	52                   	push   %edx
  800863:	ff 75 e4             	pushl  -0x1c(%ebp)
  800866:	50                   	push   %eax
  800867:	ff 75 f4             	pushl  -0xc(%ebp)
  80086a:	ff 75 f0             	pushl  -0x10(%ebp)
  80086d:	ff 75 0c             	pushl  0xc(%ebp)
  800870:	ff 75 08             	pushl  0x8(%ebp)
  800873:	e8 00 fb ff ff       	call   800378 <printnum>
  800878:	83 c4 20             	add    $0x20,%esp
			break;
  80087b:	eb 34                	jmp    8008b1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80087d:	83 ec 08             	sub    $0x8,%esp
  800880:	ff 75 0c             	pushl  0xc(%ebp)
  800883:	53                   	push   %ebx
  800884:	8b 45 08             	mov    0x8(%ebp),%eax
  800887:	ff d0                	call   *%eax
  800889:	83 c4 10             	add    $0x10,%esp
			break;
  80088c:	eb 23                	jmp    8008b1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	ff 75 0c             	pushl  0xc(%ebp)
  800894:	6a 25                	push   $0x25
  800896:	8b 45 08             	mov    0x8(%ebp),%eax
  800899:	ff d0                	call   *%eax
  80089b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80089e:	ff 4d 10             	decl   0x10(%ebp)
  8008a1:	eb 03                	jmp    8008a6 <vprintfmt+0x3b1>
  8008a3:	ff 4d 10             	decl   0x10(%ebp)
  8008a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a9:	48                   	dec    %eax
  8008aa:	8a 00                	mov    (%eax),%al
  8008ac:	3c 25                	cmp    $0x25,%al
  8008ae:	75 f3                	jne    8008a3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008b0:	90                   	nop
		}
	}
  8008b1:	e9 47 fc ff ff       	jmp    8004fd <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008b6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008ba:	5b                   	pop    %ebx
  8008bb:	5e                   	pop    %esi
  8008bc:	5d                   	pop    %ebp
  8008bd:	c3                   	ret    

008008be <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008be:	55                   	push   %ebp
  8008bf:	89 e5                	mov    %esp,%ebp
  8008c1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008c4:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c7:	83 c0 04             	add    $0x4,%eax
  8008ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d3:	50                   	push   %eax
  8008d4:	ff 75 0c             	pushl  0xc(%ebp)
  8008d7:	ff 75 08             	pushl  0x8(%ebp)
  8008da:	e8 16 fc ff ff       	call   8004f5 <vprintfmt>
  8008df:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008e2:	90                   	nop
  8008e3:	c9                   	leave  
  8008e4:	c3                   	ret    

008008e5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008e5:	55                   	push   %ebp
  8008e6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008eb:	8b 40 08             	mov    0x8(%eax),%eax
  8008ee:	8d 50 01             	lea    0x1(%eax),%edx
  8008f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fa:	8b 10                	mov    (%eax),%edx
  8008fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ff:	8b 40 04             	mov    0x4(%eax),%eax
  800902:	39 c2                	cmp    %eax,%edx
  800904:	73 12                	jae    800918 <sprintputch+0x33>
		*b->buf++ = ch;
  800906:	8b 45 0c             	mov    0xc(%ebp),%eax
  800909:	8b 00                	mov    (%eax),%eax
  80090b:	8d 48 01             	lea    0x1(%eax),%ecx
  80090e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800911:	89 0a                	mov    %ecx,(%edx)
  800913:	8b 55 08             	mov    0x8(%ebp),%edx
  800916:	88 10                	mov    %dl,(%eax)
}
  800918:	90                   	nop
  800919:	5d                   	pop    %ebp
  80091a:	c3                   	ret    

0080091b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80091b:	55                   	push   %ebp
  80091c:	89 e5                	mov    %esp,%ebp
  80091e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800927:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	01 d0                	add    %edx,%eax
  800932:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800935:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80093c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800940:	74 06                	je     800948 <vsnprintf+0x2d>
  800942:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800946:	7f 07                	jg     80094f <vsnprintf+0x34>
		return -E_INVAL;
  800948:	b8 03 00 00 00       	mov    $0x3,%eax
  80094d:	eb 20                	jmp    80096f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80094f:	ff 75 14             	pushl  0x14(%ebp)
  800952:	ff 75 10             	pushl  0x10(%ebp)
  800955:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800958:	50                   	push   %eax
  800959:	68 e5 08 80 00       	push   $0x8008e5
  80095e:	e8 92 fb ff ff       	call   8004f5 <vprintfmt>
  800963:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800966:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800969:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80096c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80096f:	c9                   	leave  
  800970:	c3                   	ret    

00800971 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800971:	55                   	push   %ebp
  800972:	89 e5                	mov    %esp,%ebp
  800974:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800977:	8d 45 10             	lea    0x10(%ebp),%eax
  80097a:	83 c0 04             	add    $0x4,%eax
  80097d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800980:	8b 45 10             	mov    0x10(%ebp),%eax
  800983:	ff 75 f4             	pushl  -0xc(%ebp)
  800986:	50                   	push   %eax
  800987:	ff 75 0c             	pushl  0xc(%ebp)
  80098a:	ff 75 08             	pushl  0x8(%ebp)
  80098d:	e8 89 ff ff ff       	call   80091b <vsnprintf>
  800992:	83 c4 10             	add    $0x10,%esp
  800995:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800998:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80099b:	c9                   	leave  
  80099c:	c3                   	ret    

0080099d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80099d:	55                   	push   %ebp
  80099e:	89 e5                	mov    %esp,%ebp
  8009a0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009aa:	eb 06                	jmp    8009b2 <strlen+0x15>
		n++;
  8009ac:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009af:	ff 45 08             	incl   0x8(%ebp)
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	8a 00                	mov    (%eax),%al
  8009b7:	84 c0                	test   %al,%al
  8009b9:	75 f1                	jne    8009ac <strlen+0xf>
		n++;
	return n;
  8009bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009be:	c9                   	leave  
  8009bf:	c3                   	ret    

008009c0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009cd:	eb 09                	jmp    8009d8 <strnlen+0x18>
		n++;
  8009cf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009d2:	ff 45 08             	incl   0x8(%ebp)
  8009d5:	ff 4d 0c             	decl   0xc(%ebp)
  8009d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009dc:	74 09                	je     8009e7 <strnlen+0x27>
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	8a 00                	mov    (%eax),%al
  8009e3:	84 c0                	test   %al,%al
  8009e5:	75 e8                	jne    8009cf <strnlen+0xf>
		n++;
	return n;
  8009e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ea:	c9                   	leave  
  8009eb:	c3                   	ret    

008009ec <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009ec:	55                   	push   %ebp
  8009ed:	89 e5                	mov    %esp,%ebp
  8009ef:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009f8:	90                   	nop
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8d 50 01             	lea    0x1(%eax),%edx
  8009ff:	89 55 08             	mov    %edx,0x8(%ebp)
  800a02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a05:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a08:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a0b:	8a 12                	mov    (%edx),%dl
  800a0d:	88 10                	mov    %dl,(%eax)
  800a0f:	8a 00                	mov    (%eax),%al
  800a11:	84 c0                	test   %al,%al
  800a13:	75 e4                	jne    8009f9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a15:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
  800a1d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a2d:	eb 1f                	jmp    800a4e <strncpy+0x34>
		*dst++ = *src;
  800a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a32:	8d 50 01             	lea    0x1(%eax),%edx
  800a35:	89 55 08             	mov    %edx,0x8(%ebp)
  800a38:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3b:	8a 12                	mov    (%edx),%dl
  800a3d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	84 c0                	test   %al,%al
  800a46:	74 03                	je     800a4b <strncpy+0x31>
			src++;
  800a48:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a4b:	ff 45 fc             	incl   -0x4(%ebp)
  800a4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a51:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a54:	72 d9                	jb     800a2f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a56:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a59:	c9                   	leave  
  800a5a:	c3                   	ret    

00800a5b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a5b:	55                   	push   %ebp
  800a5c:	89 e5                	mov    %esp,%ebp
  800a5e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6b:	74 30                	je     800a9d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a6d:	eb 16                	jmp    800a85 <strlcpy+0x2a>
			*dst++ = *src++;
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8d 50 01             	lea    0x1(%eax),%edx
  800a75:	89 55 08             	mov    %edx,0x8(%ebp)
  800a78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a7e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a81:	8a 12                	mov    (%edx),%dl
  800a83:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a85:	ff 4d 10             	decl   0x10(%ebp)
  800a88:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8c:	74 09                	je     800a97 <strlcpy+0x3c>
  800a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a91:	8a 00                	mov    (%eax),%al
  800a93:	84 c0                	test   %al,%al
  800a95:	75 d8                	jne    800a6f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a9d:	8b 55 08             	mov    0x8(%ebp),%edx
  800aa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aa3:	29 c2                	sub    %eax,%edx
  800aa5:	89 d0                	mov    %edx,%eax
}
  800aa7:	c9                   	leave  
  800aa8:	c3                   	ret    

00800aa9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800aa9:	55                   	push   %ebp
  800aaa:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800aac:	eb 06                	jmp    800ab4 <strcmp+0xb>
		p++, q++;
  800aae:	ff 45 08             	incl   0x8(%ebp)
  800ab1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	84 c0                	test   %al,%al
  800abb:	74 0e                	je     800acb <strcmp+0x22>
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	8a 10                	mov    (%eax),%dl
  800ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac5:	8a 00                	mov    (%eax),%al
  800ac7:	38 c2                	cmp    %al,%dl
  800ac9:	74 e3                	je     800aae <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	0f b6 d0             	movzbl %al,%edx
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8a 00                	mov    (%eax),%al
  800ad8:	0f b6 c0             	movzbl %al,%eax
  800adb:	29 c2                	sub    %eax,%edx
  800add:	89 d0                	mov    %edx,%eax
}
  800adf:	5d                   	pop    %ebp
  800ae0:	c3                   	ret    

00800ae1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ae4:	eb 09                	jmp    800aef <strncmp+0xe>
		n--, p++, q++;
  800ae6:	ff 4d 10             	decl   0x10(%ebp)
  800ae9:	ff 45 08             	incl   0x8(%ebp)
  800aec:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800aef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af3:	74 17                	je     800b0c <strncmp+0x2b>
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	84 c0                	test   %al,%al
  800afc:	74 0e                	je     800b0c <strncmp+0x2b>
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8a 10                	mov    (%eax),%dl
  800b03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b06:	8a 00                	mov    (%eax),%al
  800b08:	38 c2                	cmp    %al,%dl
  800b0a:	74 da                	je     800ae6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b0c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b10:	75 07                	jne    800b19 <strncmp+0x38>
		return 0;
  800b12:	b8 00 00 00 00       	mov    $0x0,%eax
  800b17:	eb 14                	jmp    800b2d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	8a 00                	mov    (%eax),%al
  800b1e:	0f b6 d0             	movzbl %al,%edx
  800b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b24:	8a 00                	mov    (%eax),%al
  800b26:	0f b6 c0             	movzbl %al,%eax
  800b29:	29 c2                	sub    %eax,%edx
  800b2b:	89 d0                	mov    %edx,%eax
}
  800b2d:	5d                   	pop    %ebp
  800b2e:	c3                   	ret    

00800b2f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b2f:	55                   	push   %ebp
  800b30:	89 e5                	mov    %esp,%ebp
  800b32:	83 ec 04             	sub    $0x4,%esp
  800b35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b38:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b3b:	eb 12                	jmp    800b4f <strchr+0x20>
		if (*s == c)
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8a 00                	mov    (%eax),%al
  800b42:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b45:	75 05                	jne    800b4c <strchr+0x1d>
			return (char *) s;
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	eb 11                	jmp    800b5d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b4c:	ff 45 08             	incl   0x8(%ebp)
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	8a 00                	mov    (%eax),%al
  800b54:	84 c0                	test   %al,%al
  800b56:	75 e5                	jne    800b3d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 04             	sub    $0x4,%esp
  800b65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b68:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b6b:	eb 0d                	jmp    800b7a <strfind+0x1b>
		if (*s == c)
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8a 00                	mov    (%eax),%al
  800b72:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b75:	74 0e                	je     800b85 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b77:	ff 45 08             	incl   0x8(%ebp)
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8a 00                	mov    (%eax),%al
  800b7f:	84 c0                	test   %al,%al
  800b81:	75 ea                	jne    800b6d <strfind+0xe>
  800b83:	eb 01                	jmp    800b86 <strfind+0x27>
		if (*s == c)
			break;
  800b85:	90                   	nop
	return (char *) s;
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b89:	c9                   	leave  
  800b8a:	c3                   	ret    

00800b8b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b8b:	55                   	push   %ebp
  800b8c:	89 e5                	mov    %esp,%ebp
  800b8e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b97:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b9d:	eb 0e                	jmp    800bad <memset+0x22>
		*p++ = c;
  800b9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba2:	8d 50 01             	lea    0x1(%eax),%edx
  800ba5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bab:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bad:	ff 4d f8             	decl   -0x8(%ebp)
  800bb0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bb4:	79 e9                	jns    800b9f <memset+0x14>
		*p++ = c;

	return v;
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
  800bbe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bcd:	eb 16                	jmp    800be5 <memcpy+0x2a>
		*d++ = *s++;
  800bcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd2:	8d 50 01             	lea    0x1(%eax),%edx
  800bd5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bd8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bdb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bde:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800be1:	8a 12                	mov    (%edx),%dl
  800be3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800be5:	8b 45 10             	mov    0x10(%ebp),%eax
  800be8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800beb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bee:	85 c0                	test   %eax,%eax
  800bf0:	75 dd                	jne    800bcf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c0f:	73 50                	jae    800c61 <memmove+0x6a>
  800c11:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c14:	8b 45 10             	mov    0x10(%ebp),%eax
  800c17:	01 d0                	add    %edx,%eax
  800c19:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c1c:	76 43                	jbe    800c61 <memmove+0x6a>
		s += n;
  800c1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c21:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c24:	8b 45 10             	mov    0x10(%ebp),%eax
  800c27:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c2a:	eb 10                	jmp    800c3c <memmove+0x45>
			*--d = *--s;
  800c2c:	ff 4d f8             	decl   -0x8(%ebp)
  800c2f:	ff 4d fc             	decl   -0x4(%ebp)
  800c32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c35:	8a 10                	mov    (%eax),%dl
  800c37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c3a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c42:	89 55 10             	mov    %edx,0x10(%ebp)
  800c45:	85 c0                	test   %eax,%eax
  800c47:	75 e3                	jne    800c2c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c49:	eb 23                	jmp    800c6e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c4e:	8d 50 01             	lea    0x1(%eax),%edx
  800c51:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c54:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c57:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c5a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c5d:	8a 12                	mov    (%edx),%dl
  800c5f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c61:	8b 45 10             	mov    0x10(%ebp),%eax
  800c64:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c67:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6a:	85 c0                	test   %eax,%eax
  800c6c:	75 dd                	jne    800c4b <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
  800c76:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c82:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c85:	eb 2a                	jmp    800cb1 <memcmp+0x3e>
		if (*s1 != *s2)
  800c87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c8a:	8a 10                	mov    (%eax),%dl
  800c8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	38 c2                	cmp    %al,%dl
  800c93:	74 16                	je     800cab <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	0f b6 d0             	movzbl %al,%edx
  800c9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	0f b6 c0             	movzbl %al,%eax
  800ca5:	29 c2                	sub    %eax,%edx
  800ca7:	89 d0                	mov    %edx,%eax
  800ca9:	eb 18                	jmp    800cc3 <memcmp+0x50>
		s1++, s2++;
  800cab:	ff 45 fc             	incl   -0x4(%ebp)
  800cae:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cb7:	89 55 10             	mov    %edx,0x10(%ebp)
  800cba:	85 c0                	test   %eax,%eax
  800cbc:	75 c9                	jne    800c87 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cc3:	c9                   	leave  
  800cc4:	c3                   	ret    

00800cc5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cc5:	55                   	push   %ebp
  800cc6:	89 e5                	mov    %esp,%ebp
  800cc8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ccb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cce:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd1:	01 d0                	add    %edx,%eax
  800cd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cd6:	eb 15                	jmp    800ced <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f b6 d0             	movzbl %al,%edx
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	0f b6 c0             	movzbl %al,%eax
  800ce6:	39 c2                	cmp    %eax,%edx
  800ce8:	74 0d                	je     800cf7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cea:	ff 45 08             	incl   0x8(%ebp)
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cf3:	72 e3                	jb     800cd8 <memfind+0x13>
  800cf5:	eb 01                	jmp    800cf8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cf7:	90                   	nop
	return (void *) s;
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d03:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d0a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d11:	eb 03                	jmp    800d16 <strtol+0x19>
		s++;
  800d13:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	3c 20                	cmp    $0x20,%al
  800d1d:	74 f4                	je     800d13 <strtol+0x16>
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	3c 09                	cmp    $0x9,%al
  800d26:	74 eb                	je     800d13 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	3c 2b                	cmp    $0x2b,%al
  800d2f:	75 05                	jne    800d36 <strtol+0x39>
		s++;
  800d31:	ff 45 08             	incl   0x8(%ebp)
  800d34:	eb 13                	jmp    800d49 <strtol+0x4c>
	else if (*s == '-')
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	3c 2d                	cmp    $0x2d,%al
  800d3d:	75 0a                	jne    800d49 <strtol+0x4c>
		s++, neg = 1;
  800d3f:	ff 45 08             	incl   0x8(%ebp)
  800d42:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d49:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4d:	74 06                	je     800d55 <strtol+0x58>
  800d4f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d53:	75 20                	jne    800d75 <strtol+0x78>
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 30                	cmp    $0x30,%al
  800d5c:	75 17                	jne    800d75 <strtol+0x78>
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	40                   	inc    %eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	3c 78                	cmp    $0x78,%al
  800d66:	75 0d                	jne    800d75 <strtol+0x78>
		s += 2, base = 16;
  800d68:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d6c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d73:	eb 28                	jmp    800d9d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d75:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d79:	75 15                	jne    800d90 <strtol+0x93>
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	8a 00                	mov    (%eax),%al
  800d80:	3c 30                	cmp    $0x30,%al
  800d82:	75 0c                	jne    800d90 <strtol+0x93>
		s++, base = 8;
  800d84:	ff 45 08             	incl   0x8(%ebp)
  800d87:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d8e:	eb 0d                	jmp    800d9d <strtol+0xa0>
	else if (base == 0)
  800d90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d94:	75 07                	jne    800d9d <strtol+0xa0>
		base = 10;
  800d96:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	8a 00                	mov    (%eax),%al
  800da2:	3c 2f                	cmp    $0x2f,%al
  800da4:	7e 19                	jle    800dbf <strtol+0xc2>
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	8a 00                	mov    (%eax),%al
  800dab:	3c 39                	cmp    $0x39,%al
  800dad:	7f 10                	jg     800dbf <strtol+0xc2>
			dig = *s - '0';
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	0f be c0             	movsbl %al,%eax
  800db7:	83 e8 30             	sub    $0x30,%eax
  800dba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dbd:	eb 42                	jmp    800e01 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	3c 60                	cmp    $0x60,%al
  800dc6:	7e 19                	jle    800de1 <strtol+0xe4>
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	3c 7a                	cmp    $0x7a,%al
  800dcf:	7f 10                	jg     800de1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8a 00                	mov    (%eax),%al
  800dd6:	0f be c0             	movsbl %al,%eax
  800dd9:	83 e8 57             	sub    $0x57,%eax
  800ddc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ddf:	eb 20                	jmp    800e01 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	3c 40                	cmp    $0x40,%al
  800de8:	7e 39                	jle    800e23 <strtol+0x126>
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	3c 5a                	cmp    $0x5a,%al
  800df1:	7f 30                	jg     800e23 <strtol+0x126>
			dig = *s - 'A' + 10;
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	0f be c0             	movsbl %al,%eax
  800dfb:	83 e8 37             	sub    $0x37,%eax
  800dfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e04:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e07:	7d 19                	jge    800e22 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e09:	ff 45 08             	incl   0x8(%ebp)
  800e0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0f:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e13:	89 c2                	mov    %eax,%edx
  800e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e18:	01 d0                	add    %edx,%eax
  800e1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e1d:	e9 7b ff ff ff       	jmp    800d9d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e22:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e23:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e27:	74 08                	je     800e31 <strtol+0x134>
		*endptr = (char *) s;
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e2f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e31:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e35:	74 07                	je     800e3e <strtol+0x141>
  800e37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3a:	f7 d8                	neg    %eax
  800e3c:	eb 03                	jmp    800e41 <strtol+0x144>
  800e3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e41:	c9                   	leave  
  800e42:	c3                   	ret    

00800e43 <ltostr>:

void
ltostr(long value, char *str)
{
  800e43:	55                   	push   %ebp
  800e44:	89 e5                	mov    %esp,%ebp
  800e46:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e50:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e57:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e5b:	79 13                	jns    800e70 <ltostr+0x2d>
	{
		neg = 1;
  800e5d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e67:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e6a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e6d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e78:	99                   	cltd   
  800e79:	f7 f9                	idiv   %ecx
  800e7b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e7e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e81:	8d 50 01             	lea    0x1(%eax),%edx
  800e84:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e87:	89 c2                	mov    %eax,%edx
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	01 d0                	add    %edx,%eax
  800e8e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e91:	83 c2 30             	add    $0x30,%edx
  800e94:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e96:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e99:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e9e:	f7 e9                	imul   %ecx
  800ea0:	c1 fa 02             	sar    $0x2,%edx
  800ea3:	89 c8                	mov    %ecx,%eax
  800ea5:	c1 f8 1f             	sar    $0x1f,%eax
  800ea8:	29 c2                	sub    %eax,%edx
  800eaa:	89 d0                	mov    %edx,%eax
  800eac:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800eaf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb7:	f7 e9                	imul   %ecx
  800eb9:	c1 fa 02             	sar    $0x2,%edx
  800ebc:	89 c8                	mov    %ecx,%eax
  800ebe:	c1 f8 1f             	sar    $0x1f,%eax
  800ec1:	29 c2                	sub    %eax,%edx
  800ec3:	89 d0                	mov    %edx,%eax
  800ec5:	c1 e0 02             	shl    $0x2,%eax
  800ec8:	01 d0                	add    %edx,%eax
  800eca:	01 c0                	add    %eax,%eax
  800ecc:	29 c1                	sub    %eax,%ecx
  800ece:	89 ca                	mov    %ecx,%edx
  800ed0:	85 d2                	test   %edx,%edx
  800ed2:	75 9c                	jne    800e70 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ed4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800edb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ede:	48                   	dec    %eax
  800edf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ee2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ee6:	74 3d                	je     800f25 <ltostr+0xe2>
		start = 1 ;
  800ee8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800eef:	eb 34                	jmp    800f25 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ef1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef7:	01 d0                	add    %edx,%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800efe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f04:	01 c2                	add    %eax,%edx
  800f06:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0c:	01 c8                	add    %ecx,%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f12:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f18:	01 c2                	add    %eax,%edx
  800f1a:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f1d:	88 02                	mov    %al,(%edx)
		start++ ;
  800f1f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f22:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f28:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f2b:	7c c4                	jl     800ef1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f2d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	01 d0                	add    %edx,%eax
  800f35:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f38:	90                   	nop
  800f39:	c9                   	leave  
  800f3a:	c3                   	ret    

00800f3b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f3b:	55                   	push   %ebp
  800f3c:	89 e5                	mov    %esp,%ebp
  800f3e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f41:	ff 75 08             	pushl  0x8(%ebp)
  800f44:	e8 54 fa ff ff       	call   80099d <strlen>
  800f49:	83 c4 04             	add    $0x4,%esp
  800f4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f4f:	ff 75 0c             	pushl  0xc(%ebp)
  800f52:	e8 46 fa ff ff       	call   80099d <strlen>
  800f57:	83 c4 04             	add    $0x4,%esp
  800f5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f5d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f64:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f6b:	eb 17                	jmp    800f84 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f70:	8b 45 10             	mov    0x10(%ebp),%eax
  800f73:	01 c2                	add    %eax,%edx
  800f75:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	01 c8                	add    %ecx,%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f81:	ff 45 fc             	incl   -0x4(%ebp)
  800f84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f87:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f8a:	7c e1                	jl     800f6d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f93:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f9a:	eb 1f                	jmp    800fbb <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9f:	8d 50 01             	lea    0x1(%eax),%edx
  800fa2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa5:	89 c2                	mov    %eax,%edx
  800fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800faa:	01 c2                	add    %eax,%edx
  800fac:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800faf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb2:	01 c8                	add    %ecx,%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fb8:	ff 45 f8             	incl   -0x8(%ebp)
  800fbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fc1:	7c d9                	jl     800f9c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fc3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc9:	01 d0                	add    %edx,%eax
  800fcb:	c6 00 00             	movb   $0x0,(%eax)
}
  800fce:	90                   	nop
  800fcf:	c9                   	leave  
  800fd0:	c3                   	ret    

00800fd1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fd4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe0:	8b 00                	mov    (%eax),%eax
  800fe2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	01 d0                	add    %edx,%eax
  800fee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800ff4:	eb 0c                	jmp    801002 <strsplit+0x31>
			*string++ = 0;
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	8d 50 01             	lea    0x1(%eax),%edx
  800ffc:	89 55 08             	mov    %edx,0x8(%ebp)
  800fff:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	84 c0                	test   %al,%al
  801009:	74 18                	je     801023 <strsplit+0x52>
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8a 00                	mov    (%eax),%al
  801010:	0f be c0             	movsbl %al,%eax
  801013:	50                   	push   %eax
  801014:	ff 75 0c             	pushl  0xc(%ebp)
  801017:	e8 13 fb ff ff       	call   800b2f <strchr>
  80101c:	83 c4 08             	add    $0x8,%esp
  80101f:	85 c0                	test   %eax,%eax
  801021:	75 d3                	jne    800ff6 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	8a 00                	mov    (%eax),%al
  801028:	84 c0                	test   %al,%al
  80102a:	74 5a                	je     801086 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80102c:	8b 45 14             	mov    0x14(%ebp),%eax
  80102f:	8b 00                	mov    (%eax),%eax
  801031:	83 f8 0f             	cmp    $0xf,%eax
  801034:	75 07                	jne    80103d <strsplit+0x6c>
		{
			return 0;
  801036:	b8 00 00 00 00       	mov    $0x0,%eax
  80103b:	eb 66                	jmp    8010a3 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80103d:	8b 45 14             	mov    0x14(%ebp),%eax
  801040:	8b 00                	mov    (%eax),%eax
  801042:	8d 48 01             	lea    0x1(%eax),%ecx
  801045:	8b 55 14             	mov    0x14(%ebp),%edx
  801048:	89 0a                	mov    %ecx,(%edx)
  80104a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801051:	8b 45 10             	mov    0x10(%ebp),%eax
  801054:	01 c2                	add    %eax,%edx
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80105b:	eb 03                	jmp    801060 <strsplit+0x8f>
			string++;
  80105d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	84 c0                	test   %al,%al
  801067:	74 8b                	je     800ff4 <strsplit+0x23>
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	0f be c0             	movsbl %al,%eax
  801071:	50                   	push   %eax
  801072:	ff 75 0c             	pushl  0xc(%ebp)
  801075:	e8 b5 fa ff ff       	call   800b2f <strchr>
  80107a:	83 c4 08             	add    $0x8,%esp
  80107d:	85 c0                	test   %eax,%eax
  80107f:	74 dc                	je     80105d <strsplit+0x8c>
			string++;
	}
  801081:	e9 6e ff ff ff       	jmp    800ff4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801086:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801087:	8b 45 14             	mov    0x14(%ebp),%eax
  80108a:	8b 00                	mov    (%eax),%eax
  80108c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801093:	8b 45 10             	mov    0x10(%ebp),%eax
  801096:	01 d0                	add    %edx,%eax
  801098:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80109e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010a3:	c9                   	leave  
  8010a4:	c3                   	ret    

008010a5 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  8010a5:	55                   	push   %ebp
  8010a6:	89 e5                	mov    %esp,%ebp
  8010a8:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8010ab:	e8 31 08 00 00       	call   8018e1 <sys_isUHeapPlacementStrategyNEXTFIT>
  8010b0:	85 c0                	test   %eax,%eax
  8010b2:	0f 84 64 01 00 00    	je     80121c <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  8010b8:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  8010be:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  8010c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010cb:	01 d0                	add    %edx,%eax
  8010cd:	48                   	dec    %eax
  8010ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8010d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8010d4:	ba 00 00 00 00       	mov    $0x0,%edx
  8010d9:	f7 75 e8             	divl   -0x18(%ebp)
  8010dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8010df:	29 d0                	sub    %edx,%eax
  8010e1:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  8010e8:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	01 d0                	add    %edx,%eax
  8010f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  8010f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  8010fd:	a1 28 30 80 00       	mov    0x803028,%eax
  801102:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801109:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80110c:	0f 83 0a 01 00 00    	jae    80121c <malloc+0x177>
  801112:	a1 28 30 80 00       	mov    0x803028,%eax
  801117:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80111e:	85 c0                	test   %eax,%eax
  801120:	0f 84 f6 00 00 00    	je     80121c <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801126:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80112d:	e9 dc 00 00 00       	jmp    80120e <malloc+0x169>
				flag++;
  801132:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801135:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801138:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80113f:	85 c0                	test   %eax,%eax
  801141:	74 07                	je     80114a <malloc+0xa5>
					flag=0;
  801143:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  80114a:	a1 28 30 80 00       	mov    0x803028,%eax
  80114f:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801156:	85 c0                	test   %eax,%eax
  801158:	79 05                	jns    80115f <malloc+0xba>
  80115a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80115f:	c1 f8 0c             	sar    $0xc,%eax
  801162:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801165:	0f 85 a0 00 00 00    	jne    80120b <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  80116b:	a1 28 30 80 00       	mov    0x803028,%eax
  801170:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801177:	85 c0                	test   %eax,%eax
  801179:	79 05                	jns    801180 <malloc+0xdb>
  80117b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801180:	c1 f8 0c             	sar    $0xc,%eax
  801183:	89 c2                	mov    %eax,%edx
  801185:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801188:	29 d0                	sub    %edx,%eax
  80118a:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  80118d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801190:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801193:	eb 11                	jmp    8011a6 <malloc+0x101>
						hFreeArr[j] = 1;
  801195:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801198:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  80119f:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  8011a3:	ff 45 ec             	incl   -0x14(%ebp)
  8011a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011ac:	7e e7                	jle    801195 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  8011ae:	a1 28 30 80 00       	mov    0x803028,%eax
  8011b3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8011b6:	81 c2 01 00 08 00    	add    $0x80001,%edx
  8011bc:	c1 e2 0c             	shl    $0xc,%edx
  8011bf:	89 15 04 30 80 00    	mov    %edx,0x803004
  8011c5:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8011cb:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  8011d2:	a1 28 30 80 00       	mov    0x803028,%eax
  8011d7:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8011de:	89 c2                	mov    %eax,%edx
  8011e0:	a1 28 30 80 00       	mov    0x803028,%eax
  8011e5:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  8011ec:	83 ec 08             	sub    $0x8,%esp
  8011ef:	52                   	push   %edx
  8011f0:	50                   	push   %eax
  8011f1:	e8 21 03 00 00       	call   801517 <sys_allocateMem>
  8011f6:	83 c4 10             	add    $0x10,%esp

					idx++;
  8011f9:	a1 28 30 80 00       	mov    0x803028,%eax
  8011fe:	40                   	inc    %eax
  8011ff:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801204:	a1 04 30 80 00       	mov    0x803004,%eax
  801209:	eb 16                	jmp    801221 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80120b:	ff 45 f0             	incl   -0x10(%ebp)
  80120e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801211:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801216:	0f 86 16 ff ff ff    	jbe    801132 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  80121c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801221:	c9                   	leave  
  801222:	c3                   	ret    

00801223 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801223:	55                   	push   %ebp
  801224:	89 e5                	mov    %esp,%ebp
  801226:	83 ec 18             	sub    $0x18,%esp
  801229:	8b 45 10             	mov    0x10(%ebp),%eax
  80122c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  80122f:	83 ec 04             	sub    $0x4,%esp
  801232:	68 f0 21 80 00       	push   $0x8021f0
  801237:	6a 5a                	push   $0x5a
  801239:	68 0f 22 80 00       	push   $0x80220f
  80123e:	e8 1b 07 00 00       	call   80195e <_panic>

00801243 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801249:	83 ec 04             	sub    $0x4,%esp
  80124c:	68 1b 22 80 00       	push   $0x80221b
  801251:	6a 60                	push   $0x60
  801253:	68 0f 22 80 00       	push   $0x80220f
  801258:	e8 01 07 00 00       	call   80195e <_panic>

0080125d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801263:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80126a:	e9 8a 00 00 00       	jmp    8012f9 <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  80126f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801272:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801279:	3b 45 08             	cmp    0x8(%ebp),%eax
  80127c:	75 78                	jne    8012f6 <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  80127e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801281:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801288:	05 00 00 00 80       	add    $0x80000000,%eax
  80128d:	c1 e8 0c             	shr    $0xc,%eax
  801290:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801293:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801296:	8b 14 c5 44 30 88 00 	mov    0x883044(,%eax,8),%edx
  80129d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012a0:	01 d0                	add    %edx,%eax
  8012a2:	85 c0                	test   %eax,%eax
  8012a4:	79 05                	jns    8012ab <free+0x4e>
  8012a6:	05 ff 0f 00 00       	add    $0xfff,%eax
  8012ab:	c1 f8 0c             	sar    $0xc,%eax
  8012ae:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  8012b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b7:	eb 19                	jmp    8012d2 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  8012b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012bc:	83 ec 08             	sub    $0x8,%esp
  8012bf:	50                   	push   %eax
  8012c0:	ff 75 f0             	pushl  -0x10(%ebp)
  8012c3:	e8 33 02 00 00       	call   8014fb <sys_freeMem>
  8012c8:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  8012cb:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  8012d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012d5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8012d8:	72 df                	jb     8012b9 <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  8012da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012dd:	c7 04 c5 44 30 88 00 	movl   $0x0,0x883044(,%eax,8)
  8012e4:	00 00 00 00 
  8012e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012eb:	c7 04 c5 40 30 88 00 	movl   $0x0,0x883040(,%eax,8)
  8012f2:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  8012f6:	ff 45 f4             	incl   -0xc(%ebp)
  8012f9:	a1 28 30 80 00       	mov    0x803028,%eax
  8012fe:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801301:	0f 8c 68 ff ff ff    	jl     80126f <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  801307:	90                   	nop
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <sfree>:


void sfree(void* virtual_address)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
  80130d:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801310:	83 ec 04             	sub    $0x4,%esp
  801313:	68 37 22 80 00       	push   $0x802237
  801318:	68 87 00 00 00       	push   $0x87
  80131d:	68 0f 22 80 00       	push   $0x80220f
  801322:	e8 37 06 00 00       	call   80195e <_panic>

00801327 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80132d:	83 ec 04             	sub    $0x4,%esp
  801330:	68 54 22 80 00       	push   $0x802254
  801335:	68 9f 00 00 00       	push   $0x9f
  80133a:	68 0f 22 80 00       	push   $0x80220f
  80133f:	e8 1a 06 00 00       	call   80195e <_panic>

00801344 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
  801347:	57                   	push   %edi
  801348:	56                   	push   %esi
  801349:	53                   	push   %ebx
  80134a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8b 55 0c             	mov    0xc(%ebp),%edx
  801353:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801356:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801359:	8b 7d 18             	mov    0x18(%ebp),%edi
  80135c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80135f:	cd 30                	int    $0x30
  801361:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801364:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801367:	83 c4 10             	add    $0x10,%esp
  80136a:	5b                   	pop    %ebx
  80136b:	5e                   	pop    %esi
  80136c:	5f                   	pop    %edi
  80136d:	5d                   	pop    %ebp
  80136e:	c3                   	ret    

0080136f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
  801372:	83 ec 04             	sub    $0x4,%esp
  801375:	8b 45 10             	mov    0x10(%ebp),%eax
  801378:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80137b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	52                   	push   %edx
  801387:	ff 75 0c             	pushl  0xc(%ebp)
  80138a:	50                   	push   %eax
  80138b:	6a 00                	push   $0x0
  80138d:	e8 b2 ff ff ff       	call   801344 <syscall>
  801392:	83 c4 18             	add    $0x18,%esp
}
  801395:	90                   	nop
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_cgetc>:

int
sys_cgetc(void)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 01                	push   $0x1
  8013a7:	e8 98 ff ff ff       	call   801344 <syscall>
  8013ac:	83 c4 18             	add    $0x18,%esp
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	50                   	push   %eax
  8013c0:	6a 05                	push   $0x5
  8013c2:	e8 7d ff ff ff       	call   801344 <syscall>
  8013c7:	83 c4 18             	add    $0x18,%esp
}
  8013ca:	c9                   	leave  
  8013cb:	c3                   	ret    

008013cc <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013cc:	55                   	push   %ebp
  8013cd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 02                	push   $0x2
  8013db:	e8 64 ff ff ff       	call   801344 <syscall>
  8013e0:	83 c4 18             	add    $0x18,%esp
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 03                	push   $0x3
  8013f4:	e8 4b ff ff ff       	call   801344 <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 04                	push   $0x4
  80140d:	e8 32 ff ff ff       	call   801344 <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_env_exit>:


void sys_env_exit(void)
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 06                	push   $0x6
  801426:	e8 19 ff ff ff       	call   801344 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	90                   	nop
  80142f:	c9                   	leave  
  801430:	c3                   	ret    

00801431 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801434:	8b 55 0c             	mov    0xc(%ebp),%edx
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	52                   	push   %edx
  801441:	50                   	push   %eax
  801442:	6a 07                	push   $0x7
  801444:	e8 fb fe ff ff       	call   801344 <syscall>
  801449:	83 c4 18             	add    $0x18,%esp
}
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
  801451:	56                   	push   %esi
  801452:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801453:	8b 75 18             	mov    0x18(%ebp),%esi
  801456:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801459:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80145c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	56                   	push   %esi
  801463:	53                   	push   %ebx
  801464:	51                   	push   %ecx
  801465:	52                   	push   %edx
  801466:	50                   	push   %eax
  801467:	6a 08                	push   $0x8
  801469:	e8 d6 fe ff ff       	call   801344 <syscall>
  80146e:	83 c4 18             	add    $0x18,%esp
}
  801471:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801474:	5b                   	pop    %ebx
  801475:	5e                   	pop    %esi
  801476:	5d                   	pop    %ebp
  801477:	c3                   	ret    

00801478 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80147b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147e:	8b 45 08             	mov    0x8(%ebp),%eax
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	52                   	push   %edx
  801488:	50                   	push   %eax
  801489:	6a 09                	push   $0x9
  80148b:	e8 b4 fe ff ff       	call   801344 <syscall>
  801490:	83 c4 18             	add    $0x18,%esp
}
  801493:	c9                   	leave  
  801494:	c3                   	ret    

00801495 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	ff 75 0c             	pushl  0xc(%ebp)
  8014a1:	ff 75 08             	pushl  0x8(%ebp)
  8014a4:	6a 0a                	push   $0xa
  8014a6:	e8 99 fe ff ff       	call   801344 <syscall>
  8014ab:	83 c4 18             	add    $0x18,%esp
}
  8014ae:	c9                   	leave  
  8014af:	c3                   	ret    

008014b0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 0b                	push   $0xb
  8014bf:	e8 80 fe ff ff       	call   801344 <syscall>
  8014c4:	83 c4 18             	add    $0x18,%esp
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 0c                	push   $0xc
  8014d8:	e8 67 fe ff ff       	call   801344 <syscall>
  8014dd:	83 c4 18             	add    $0x18,%esp
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 0d                	push   $0xd
  8014f1:	e8 4e fe ff ff       	call   801344 <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	6a 11                	push   $0x11
  80150c:	e8 33 fe ff ff       	call   801344 <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
	return;
  801514:	90                   	nop
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	ff 75 08             	pushl  0x8(%ebp)
  801526:	6a 12                	push   $0x12
  801528:	e8 17 fe ff ff       	call   801344 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
	return ;
  801530:	90                   	nop
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 0e                	push   $0xe
  801542:	e8 fd fd ff ff       	call   801344 <syscall>
  801547:	83 c4 18             	add    $0x18,%esp
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	ff 75 08             	pushl  0x8(%ebp)
  80155a:	6a 0f                	push   $0xf
  80155c:	e8 e3 fd ff ff       	call   801344 <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 10                	push   $0x10
  801575:	e8 ca fd ff ff       	call   801344 <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 14                	push   $0x14
  80158f:	e8 b0 fd ff ff       	call   801344 <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
}
  801597:	90                   	nop
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 15                	push   $0x15
  8015a9:	e8 96 fd ff ff       	call   801344 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	90                   	nop
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
  8015b7:	83 ec 04             	sub    $0x4,%esp
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015c0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	50                   	push   %eax
  8015cd:	6a 16                	push   $0x16
  8015cf:	e8 70 fd ff ff       	call   801344 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	90                   	nop
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 17                	push   $0x17
  8015e9:	e8 56 fd ff ff       	call   801344 <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	90                   	nop
  8015f2:	c9                   	leave  
  8015f3:	c3                   	ret    

008015f4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	ff 75 0c             	pushl  0xc(%ebp)
  801603:	50                   	push   %eax
  801604:	6a 18                	push   $0x18
  801606:	e8 39 fd ff ff       	call   801344 <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801613:	8b 55 0c             	mov    0xc(%ebp),%edx
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	52                   	push   %edx
  801620:	50                   	push   %eax
  801621:	6a 1b                	push   $0x1b
  801623:	e8 1c fd ff ff       	call   801344 <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
}
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801630:	8b 55 0c             	mov    0xc(%ebp),%edx
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	6a 19                	push   $0x19
  801640:	e8 ff fc ff ff       	call   801344 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	90                   	nop
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80164e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	52                   	push   %edx
  80165b:	50                   	push   %eax
  80165c:	6a 1a                	push   $0x1a
  80165e:	e8 e1 fc ff ff       	call   801344 <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
}
  801666:	90                   	nop
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
  80166c:	83 ec 04             	sub    $0x4,%esp
  80166f:	8b 45 10             	mov    0x10(%ebp),%eax
  801672:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801675:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801678:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	6a 00                	push   $0x0
  801681:	51                   	push   %ecx
  801682:	52                   	push   %edx
  801683:	ff 75 0c             	pushl  0xc(%ebp)
  801686:	50                   	push   %eax
  801687:	6a 1c                	push   $0x1c
  801689:	e8 b6 fc ff ff       	call   801344 <syscall>
  80168e:	83 c4 18             	add    $0x18,%esp
}
  801691:	c9                   	leave  
  801692:	c3                   	ret    

00801693 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801696:	8b 55 0c             	mov    0xc(%ebp),%edx
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	52                   	push   %edx
  8016a3:	50                   	push   %eax
  8016a4:	6a 1d                	push   $0x1d
  8016a6:	e8 99 fc ff ff       	call   801344 <syscall>
  8016ab:	83 c4 18             	add    $0x18,%esp
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	51                   	push   %ecx
  8016c1:	52                   	push   %edx
  8016c2:	50                   	push   %eax
  8016c3:	6a 1e                	push   $0x1e
  8016c5:	e8 7a fc ff ff       	call   801344 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	52                   	push   %edx
  8016df:	50                   	push   %eax
  8016e0:	6a 1f                	push   $0x1f
  8016e2:	e8 5d fc ff ff       	call   801344 <syscall>
  8016e7:	83 c4 18             	add    $0x18,%esp
}
  8016ea:	c9                   	leave  
  8016eb:	c3                   	ret    

008016ec <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 20                	push   $0x20
  8016fb:	e8 44 fc ff ff       	call   801344 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	ff 75 10             	pushl  0x10(%ebp)
  801712:	ff 75 0c             	pushl  0xc(%ebp)
  801715:	50                   	push   %eax
  801716:	6a 21                	push   $0x21
  801718:	e8 27 fc ff ff       	call   801344 <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	50                   	push   %eax
  801731:	6a 22                	push   $0x22
  801733:	e8 0c fc ff ff       	call   801344 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	50                   	push   %eax
  80174d:	6a 23                	push   $0x23
  80174f:	e8 f0 fb ff ff       	call   801344 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	90                   	nop
  801758:	c9                   	leave  
  801759:	c3                   	ret    

0080175a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80175a:	55                   	push   %ebp
  80175b:	89 e5                	mov    %esp,%ebp
  80175d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801760:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801763:	8d 50 04             	lea    0x4(%eax),%edx
  801766:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 24                	push   $0x24
  801773:	e8 cc fb ff ff       	call   801344 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
	return result;
  80177b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80177e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801781:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801784:	89 01                	mov    %eax,(%ecx)
  801786:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	c9                   	leave  
  80178d:	c2 04 00             	ret    $0x4

00801790 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	ff 75 10             	pushl  0x10(%ebp)
  80179a:	ff 75 0c             	pushl  0xc(%ebp)
  80179d:	ff 75 08             	pushl  0x8(%ebp)
  8017a0:	6a 13                	push   $0x13
  8017a2:	e8 9d fb ff ff       	call   801344 <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017aa:	90                   	nop
}
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <sys_rcr2>:
uint32 sys_rcr2()
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 25                	push   $0x25
  8017bc:	e8 83 fb ff ff       	call   801344 <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	83 ec 04             	sub    $0x4,%esp
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017d2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	50                   	push   %eax
  8017df:	6a 26                	push   $0x26
  8017e1:	e8 5e fb ff ff       	call   801344 <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017e9:	90                   	nop
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <rsttst>:
void rsttst()
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 28                	push   $0x28
  8017fb:	e8 44 fb ff ff       	call   801344 <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
	return ;
  801803:	90                   	nop
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
  801809:	83 ec 04             	sub    $0x4,%esp
  80180c:	8b 45 14             	mov    0x14(%ebp),%eax
  80180f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801812:	8b 55 18             	mov    0x18(%ebp),%edx
  801815:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801819:	52                   	push   %edx
  80181a:	50                   	push   %eax
  80181b:	ff 75 10             	pushl  0x10(%ebp)
  80181e:	ff 75 0c             	pushl  0xc(%ebp)
  801821:	ff 75 08             	pushl  0x8(%ebp)
  801824:	6a 27                	push   $0x27
  801826:	e8 19 fb ff ff       	call   801344 <syscall>
  80182b:	83 c4 18             	add    $0x18,%esp
	return ;
  80182e:	90                   	nop
}
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <chktst>:
void chktst(uint32 n)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	ff 75 08             	pushl  0x8(%ebp)
  80183f:	6a 29                	push   $0x29
  801841:	e8 fe fa ff ff       	call   801344 <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
	return ;
  801849:	90                   	nop
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <inctst>:

void inctst()
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 2a                	push   $0x2a
  80185b:	e8 e4 fa ff ff       	call   801344 <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
	return ;
  801863:	90                   	nop
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <gettst>:
uint32 gettst()
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 2b                	push   $0x2b
  801875:	e8 ca fa ff ff       	call   801344 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 2c                	push   $0x2c
  801891:	e8 ae fa ff ff       	call   801344 <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
  801899:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80189c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018a0:	75 07                	jne    8018a9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018a7:	eb 05                	jmp    8018ae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 2c                	push   $0x2c
  8018c2:	e8 7d fa ff ff       	call   801344 <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
  8018ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018cd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018d1:	75 07                	jne    8018da <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018d3:	b8 01 00 00 00       	mov    $0x1,%eax
  8018d8:	eb 05                	jmp    8018df <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
  8018e4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 2c                	push   $0x2c
  8018f3:	e8 4c fa ff ff       	call   801344 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
  8018fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018fe:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801902:	75 07                	jne    80190b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801904:	b8 01 00 00 00       	mov    $0x1,%eax
  801909:	eb 05                	jmp    801910 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80190b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
  801915:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 2c                	push   $0x2c
  801924:	e8 1b fa ff ff       	call   801344 <syscall>
  801929:	83 c4 18             	add    $0x18,%esp
  80192c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80192f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801933:	75 07                	jne    80193c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801935:	b8 01 00 00 00       	mov    $0x1,%eax
  80193a:	eb 05                	jmp    801941 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80193c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	ff 75 08             	pushl  0x8(%ebp)
  801951:	6a 2d                	push   $0x2d
  801953:	e8 ec f9 ff ff       	call   801344 <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
	return ;
  80195b:	90                   	nop
}
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
  801961:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801964:	8d 45 10             	lea    0x10(%ebp),%eax
  801967:	83 c0 04             	add    $0x4,%eax
  80196a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80196d:	a1 40 30 98 00       	mov    0x983040,%eax
  801972:	85 c0                	test   %eax,%eax
  801974:	74 16                	je     80198c <_panic+0x2e>
		cprintf("%s: ", argv0);
  801976:	a1 40 30 98 00       	mov    0x983040,%eax
  80197b:	83 ec 08             	sub    $0x8,%esp
  80197e:	50                   	push   %eax
  80197f:	68 7c 22 80 00       	push   $0x80227c
  801984:	e8 92 e9 ff ff       	call   80031b <cprintf>
  801989:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80198c:	a1 00 30 80 00       	mov    0x803000,%eax
  801991:	ff 75 0c             	pushl  0xc(%ebp)
  801994:	ff 75 08             	pushl  0x8(%ebp)
  801997:	50                   	push   %eax
  801998:	68 81 22 80 00       	push   $0x802281
  80199d:	e8 79 e9 ff ff       	call   80031b <cprintf>
  8019a2:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8019a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a8:	83 ec 08             	sub    $0x8,%esp
  8019ab:	ff 75 f4             	pushl  -0xc(%ebp)
  8019ae:	50                   	push   %eax
  8019af:	e8 fc e8 ff ff       	call   8002b0 <vcprintf>
  8019b4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8019b7:	83 ec 08             	sub    $0x8,%esp
  8019ba:	6a 00                	push   $0x0
  8019bc:	68 9d 22 80 00       	push   $0x80229d
  8019c1:	e8 ea e8 ff ff       	call   8002b0 <vcprintf>
  8019c6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8019c9:	e8 6b e8 ff ff       	call   800239 <exit>

	// should not return here
	while (1) ;
  8019ce:	eb fe                	jmp    8019ce <_panic+0x70>

008019d0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
  8019d3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8019d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8019db:	8b 50 74             	mov    0x74(%eax),%edx
  8019de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e1:	39 c2                	cmp    %eax,%edx
  8019e3:	74 14                	je     8019f9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8019e5:	83 ec 04             	sub    $0x4,%esp
  8019e8:	68 a0 22 80 00       	push   $0x8022a0
  8019ed:	6a 26                	push   $0x26
  8019ef:	68 ec 22 80 00       	push   $0x8022ec
  8019f4:	e8 65 ff ff ff       	call   80195e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8019f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a00:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a07:	e9 c2 00 00 00       	jmp    801ace <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801a0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a0f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	01 d0                	add    %edx,%eax
  801a1b:	8b 00                	mov    (%eax),%eax
  801a1d:	85 c0                	test   %eax,%eax
  801a1f:	75 08                	jne    801a29 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a21:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a24:	e9 a2 00 00 00       	jmp    801acb <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a30:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a37:	eb 69                	jmp    801aa2 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a39:	a1 20 30 80 00       	mov    0x803020,%eax
  801a3e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a44:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a47:	89 d0                	mov    %edx,%eax
  801a49:	01 c0                	add    %eax,%eax
  801a4b:	01 d0                	add    %edx,%eax
  801a4d:	c1 e0 02             	shl    $0x2,%eax
  801a50:	01 c8                	add    %ecx,%eax
  801a52:	8a 40 04             	mov    0x4(%eax),%al
  801a55:	84 c0                	test   %al,%al
  801a57:	75 46                	jne    801a9f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a59:	a1 20 30 80 00       	mov    0x803020,%eax
  801a5e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a64:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a67:	89 d0                	mov    %edx,%eax
  801a69:	01 c0                	add    %eax,%eax
  801a6b:	01 d0                	add    %edx,%eax
  801a6d:	c1 e0 02             	shl    $0x2,%eax
  801a70:	01 c8                	add    %ecx,%eax
  801a72:	8b 00                	mov    (%eax),%eax
  801a74:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a77:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a7a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801a7f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a84:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	01 c8                	add    %ecx,%eax
  801a90:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a92:	39 c2                	cmp    %eax,%edx
  801a94:	75 09                	jne    801a9f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a96:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801a9d:	eb 12                	jmp    801ab1 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a9f:	ff 45 e8             	incl   -0x18(%ebp)
  801aa2:	a1 20 30 80 00       	mov    0x803020,%eax
  801aa7:	8b 50 74             	mov    0x74(%eax),%edx
  801aaa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801aad:	39 c2                	cmp    %eax,%edx
  801aaf:	77 88                	ja     801a39 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801ab1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ab5:	75 14                	jne    801acb <CheckWSWithoutLastIndex+0xfb>
			panic(
  801ab7:	83 ec 04             	sub    $0x4,%esp
  801aba:	68 f8 22 80 00       	push   $0x8022f8
  801abf:	6a 3a                	push   $0x3a
  801ac1:	68 ec 22 80 00       	push   $0x8022ec
  801ac6:	e8 93 fe ff ff       	call   80195e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801acb:	ff 45 f0             	incl   -0x10(%ebp)
  801ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ad1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ad4:	0f 8c 32 ff ff ff    	jl     801a0c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801ada:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ae1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ae8:	eb 26                	jmp    801b10 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801aea:	a1 20 30 80 00       	mov    0x803020,%eax
  801aef:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801af5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801af8:	89 d0                	mov    %edx,%eax
  801afa:	01 c0                	add    %eax,%eax
  801afc:	01 d0                	add    %edx,%eax
  801afe:	c1 e0 02             	shl    $0x2,%eax
  801b01:	01 c8                	add    %ecx,%eax
  801b03:	8a 40 04             	mov    0x4(%eax),%al
  801b06:	3c 01                	cmp    $0x1,%al
  801b08:	75 03                	jne    801b0d <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801b0a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b0d:	ff 45 e0             	incl   -0x20(%ebp)
  801b10:	a1 20 30 80 00       	mov    0x803020,%eax
  801b15:	8b 50 74             	mov    0x74(%eax),%edx
  801b18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b1b:	39 c2                	cmp    %eax,%edx
  801b1d:	77 cb                	ja     801aea <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b22:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b25:	74 14                	je     801b3b <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b27:	83 ec 04             	sub    $0x4,%esp
  801b2a:	68 4c 23 80 00       	push   $0x80234c
  801b2f:	6a 44                	push   $0x44
  801b31:	68 ec 22 80 00       	push   $0x8022ec
  801b36:	e8 23 fe ff ff       	call   80195e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b3b:	90                   	nop
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    
  801b3e:	66 90                	xchg   %ax,%ax

00801b40 <__udivdi3>:
  801b40:	55                   	push   %ebp
  801b41:	57                   	push   %edi
  801b42:	56                   	push   %esi
  801b43:	53                   	push   %ebx
  801b44:	83 ec 1c             	sub    $0x1c,%esp
  801b47:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b4b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b53:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b57:	89 ca                	mov    %ecx,%edx
  801b59:	89 f8                	mov    %edi,%eax
  801b5b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b5f:	85 f6                	test   %esi,%esi
  801b61:	75 2d                	jne    801b90 <__udivdi3+0x50>
  801b63:	39 cf                	cmp    %ecx,%edi
  801b65:	77 65                	ja     801bcc <__udivdi3+0x8c>
  801b67:	89 fd                	mov    %edi,%ebp
  801b69:	85 ff                	test   %edi,%edi
  801b6b:	75 0b                	jne    801b78 <__udivdi3+0x38>
  801b6d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b72:	31 d2                	xor    %edx,%edx
  801b74:	f7 f7                	div    %edi
  801b76:	89 c5                	mov    %eax,%ebp
  801b78:	31 d2                	xor    %edx,%edx
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	f7 f5                	div    %ebp
  801b7e:	89 c1                	mov    %eax,%ecx
  801b80:	89 d8                	mov    %ebx,%eax
  801b82:	f7 f5                	div    %ebp
  801b84:	89 cf                	mov    %ecx,%edi
  801b86:	89 fa                	mov    %edi,%edx
  801b88:	83 c4 1c             	add    $0x1c,%esp
  801b8b:	5b                   	pop    %ebx
  801b8c:	5e                   	pop    %esi
  801b8d:	5f                   	pop    %edi
  801b8e:	5d                   	pop    %ebp
  801b8f:	c3                   	ret    
  801b90:	39 ce                	cmp    %ecx,%esi
  801b92:	77 28                	ja     801bbc <__udivdi3+0x7c>
  801b94:	0f bd fe             	bsr    %esi,%edi
  801b97:	83 f7 1f             	xor    $0x1f,%edi
  801b9a:	75 40                	jne    801bdc <__udivdi3+0x9c>
  801b9c:	39 ce                	cmp    %ecx,%esi
  801b9e:	72 0a                	jb     801baa <__udivdi3+0x6a>
  801ba0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ba4:	0f 87 9e 00 00 00    	ja     801c48 <__udivdi3+0x108>
  801baa:	b8 01 00 00 00       	mov    $0x1,%eax
  801baf:	89 fa                	mov    %edi,%edx
  801bb1:	83 c4 1c             	add    $0x1c,%esp
  801bb4:	5b                   	pop    %ebx
  801bb5:	5e                   	pop    %esi
  801bb6:	5f                   	pop    %edi
  801bb7:	5d                   	pop    %ebp
  801bb8:	c3                   	ret    
  801bb9:	8d 76 00             	lea    0x0(%esi),%esi
  801bbc:	31 ff                	xor    %edi,%edi
  801bbe:	31 c0                	xor    %eax,%eax
  801bc0:	89 fa                	mov    %edi,%edx
  801bc2:	83 c4 1c             	add    $0x1c,%esp
  801bc5:	5b                   	pop    %ebx
  801bc6:	5e                   	pop    %esi
  801bc7:	5f                   	pop    %edi
  801bc8:	5d                   	pop    %ebp
  801bc9:	c3                   	ret    
  801bca:	66 90                	xchg   %ax,%ax
  801bcc:	89 d8                	mov    %ebx,%eax
  801bce:	f7 f7                	div    %edi
  801bd0:	31 ff                	xor    %edi,%edi
  801bd2:	89 fa                	mov    %edi,%edx
  801bd4:	83 c4 1c             	add    $0x1c,%esp
  801bd7:	5b                   	pop    %ebx
  801bd8:	5e                   	pop    %esi
  801bd9:	5f                   	pop    %edi
  801bda:	5d                   	pop    %ebp
  801bdb:	c3                   	ret    
  801bdc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801be1:	89 eb                	mov    %ebp,%ebx
  801be3:	29 fb                	sub    %edi,%ebx
  801be5:	89 f9                	mov    %edi,%ecx
  801be7:	d3 e6                	shl    %cl,%esi
  801be9:	89 c5                	mov    %eax,%ebp
  801beb:	88 d9                	mov    %bl,%cl
  801bed:	d3 ed                	shr    %cl,%ebp
  801bef:	89 e9                	mov    %ebp,%ecx
  801bf1:	09 f1                	or     %esi,%ecx
  801bf3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bf7:	89 f9                	mov    %edi,%ecx
  801bf9:	d3 e0                	shl    %cl,%eax
  801bfb:	89 c5                	mov    %eax,%ebp
  801bfd:	89 d6                	mov    %edx,%esi
  801bff:	88 d9                	mov    %bl,%cl
  801c01:	d3 ee                	shr    %cl,%esi
  801c03:	89 f9                	mov    %edi,%ecx
  801c05:	d3 e2                	shl    %cl,%edx
  801c07:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c0b:	88 d9                	mov    %bl,%cl
  801c0d:	d3 e8                	shr    %cl,%eax
  801c0f:	09 c2                	or     %eax,%edx
  801c11:	89 d0                	mov    %edx,%eax
  801c13:	89 f2                	mov    %esi,%edx
  801c15:	f7 74 24 0c          	divl   0xc(%esp)
  801c19:	89 d6                	mov    %edx,%esi
  801c1b:	89 c3                	mov    %eax,%ebx
  801c1d:	f7 e5                	mul    %ebp
  801c1f:	39 d6                	cmp    %edx,%esi
  801c21:	72 19                	jb     801c3c <__udivdi3+0xfc>
  801c23:	74 0b                	je     801c30 <__udivdi3+0xf0>
  801c25:	89 d8                	mov    %ebx,%eax
  801c27:	31 ff                	xor    %edi,%edi
  801c29:	e9 58 ff ff ff       	jmp    801b86 <__udivdi3+0x46>
  801c2e:	66 90                	xchg   %ax,%ax
  801c30:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c34:	89 f9                	mov    %edi,%ecx
  801c36:	d3 e2                	shl    %cl,%edx
  801c38:	39 c2                	cmp    %eax,%edx
  801c3a:	73 e9                	jae    801c25 <__udivdi3+0xe5>
  801c3c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c3f:	31 ff                	xor    %edi,%edi
  801c41:	e9 40 ff ff ff       	jmp    801b86 <__udivdi3+0x46>
  801c46:	66 90                	xchg   %ax,%ax
  801c48:	31 c0                	xor    %eax,%eax
  801c4a:	e9 37 ff ff ff       	jmp    801b86 <__udivdi3+0x46>
  801c4f:	90                   	nop

00801c50 <__umoddi3>:
  801c50:	55                   	push   %ebp
  801c51:	57                   	push   %edi
  801c52:	56                   	push   %esi
  801c53:	53                   	push   %ebx
  801c54:	83 ec 1c             	sub    $0x1c,%esp
  801c57:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c5b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c63:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c67:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c6b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c6f:	89 f3                	mov    %esi,%ebx
  801c71:	89 fa                	mov    %edi,%edx
  801c73:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c77:	89 34 24             	mov    %esi,(%esp)
  801c7a:	85 c0                	test   %eax,%eax
  801c7c:	75 1a                	jne    801c98 <__umoddi3+0x48>
  801c7e:	39 f7                	cmp    %esi,%edi
  801c80:	0f 86 a2 00 00 00    	jbe    801d28 <__umoddi3+0xd8>
  801c86:	89 c8                	mov    %ecx,%eax
  801c88:	89 f2                	mov    %esi,%edx
  801c8a:	f7 f7                	div    %edi
  801c8c:	89 d0                	mov    %edx,%eax
  801c8e:	31 d2                	xor    %edx,%edx
  801c90:	83 c4 1c             	add    $0x1c,%esp
  801c93:	5b                   	pop    %ebx
  801c94:	5e                   	pop    %esi
  801c95:	5f                   	pop    %edi
  801c96:	5d                   	pop    %ebp
  801c97:	c3                   	ret    
  801c98:	39 f0                	cmp    %esi,%eax
  801c9a:	0f 87 ac 00 00 00    	ja     801d4c <__umoddi3+0xfc>
  801ca0:	0f bd e8             	bsr    %eax,%ebp
  801ca3:	83 f5 1f             	xor    $0x1f,%ebp
  801ca6:	0f 84 ac 00 00 00    	je     801d58 <__umoddi3+0x108>
  801cac:	bf 20 00 00 00       	mov    $0x20,%edi
  801cb1:	29 ef                	sub    %ebp,%edi
  801cb3:	89 fe                	mov    %edi,%esi
  801cb5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cb9:	89 e9                	mov    %ebp,%ecx
  801cbb:	d3 e0                	shl    %cl,%eax
  801cbd:	89 d7                	mov    %edx,%edi
  801cbf:	89 f1                	mov    %esi,%ecx
  801cc1:	d3 ef                	shr    %cl,%edi
  801cc3:	09 c7                	or     %eax,%edi
  801cc5:	89 e9                	mov    %ebp,%ecx
  801cc7:	d3 e2                	shl    %cl,%edx
  801cc9:	89 14 24             	mov    %edx,(%esp)
  801ccc:	89 d8                	mov    %ebx,%eax
  801cce:	d3 e0                	shl    %cl,%eax
  801cd0:	89 c2                	mov    %eax,%edx
  801cd2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cd6:	d3 e0                	shl    %cl,%eax
  801cd8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cdc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce0:	89 f1                	mov    %esi,%ecx
  801ce2:	d3 e8                	shr    %cl,%eax
  801ce4:	09 d0                	or     %edx,%eax
  801ce6:	d3 eb                	shr    %cl,%ebx
  801ce8:	89 da                	mov    %ebx,%edx
  801cea:	f7 f7                	div    %edi
  801cec:	89 d3                	mov    %edx,%ebx
  801cee:	f7 24 24             	mull   (%esp)
  801cf1:	89 c6                	mov    %eax,%esi
  801cf3:	89 d1                	mov    %edx,%ecx
  801cf5:	39 d3                	cmp    %edx,%ebx
  801cf7:	0f 82 87 00 00 00    	jb     801d84 <__umoddi3+0x134>
  801cfd:	0f 84 91 00 00 00    	je     801d94 <__umoddi3+0x144>
  801d03:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d07:	29 f2                	sub    %esi,%edx
  801d09:	19 cb                	sbb    %ecx,%ebx
  801d0b:	89 d8                	mov    %ebx,%eax
  801d0d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d11:	d3 e0                	shl    %cl,%eax
  801d13:	89 e9                	mov    %ebp,%ecx
  801d15:	d3 ea                	shr    %cl,%edx
  801d17:	09 d0                	or     %edx,%eax
  801d19:	89 e9                	mov    %ebp,%ecx
  801d1b:	d3 eb                	shr    %cl,%ebx
  801d1d:	89 da                	mov    %ebx,%edx
  801d1f:	83 c4 1c             	add    $0x1c,%esp
  801d22:	5b                   	pop    %ebx
  801d23:	5e                   	pop    %esi
  801d24:	5f                   	pop    %edi
  801d25:	5d                   	pop    %ebp
  801d26:	c3                   	ret    
  801d27:	90                   	nop
  801d28:	89 fd                	mov    %edi,%ebp
  801d2a:	85 ff                	test   %edi,%edi
  801d2c:	75 0b                	jne    801d39 <__umoddi3+0xe9>
  801d2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d33:	31 d2                	xor    %edx,%edx
  801d35:	f7 f7                	div    %edi
  801d37:	89 c5                	mov    %eax,%ebp
  801d39:	89 f0                	mov    %esi,%eax
  801d3b:	31 d2                	xor    %edx,%edx
  801d3d:	f7 f5                	div    %ebp
  801d3f:	89 c8                	mov    %ecx,%eax
  801d41:	f7 f5                	div    %ebp
  801d43:	89 d0                	mov    %edx,%eax
  801d45:	e9 44 ff ff ff       	jmp    801c8e <__umoddi3+0x3e>
  801d4a:	66 90                	xchg   %ax,%ax
  801d4c:	89 c8                	mov    %ecx,%eax
  801d4e:	89 f2                	mov    %esi,%edx
  801d50:	83 c4 1c             	add    $0x1c,%esp
  801d53:	5b                   	pop    %ebx
  801d54:	5e                   	pop    %esi
  801d55:	5f                   	pop    %edi
  801d56:	5d                   	pop    %ebp
  801d57:	c3                   	ret    
  801d58:	3b 04 24             	cmp    (%esp),%eax
  801d5b:	72 06                	jb     801d63 <__umoddi3+0x113>
  801d5d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d61:	77 0f                	ja     801d72 <__umoddi3+0x122>
  801d63:	89 f2                	mov    %esi,%edx
  801d65:	29 f9                	sub    %edi,%ecx
  801d67:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d6b:	89 14 24             	mov    %edx,(%esp)
  801d6e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d72:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d76:	8b 14 24             	mov    (%esp),%edx
  801d79:	83 c4 1c             	add    $0x1c,%esp
  801d7c:	5b                   	pop    %ebx
  801d7d:	5e                   	pop    %esi
  801d7e:	5f                   	pop    %edi
  801d7f:	5d                   	pop    %ebp
  801d80:	c3                   	ret    
  801d81:	8d 76 00             	lea    0x0(%esi),%esi
  801d84:	2b 04 24             	sub    (%esp),%eax
  801d87:	19 fa                	sbb    %edi,%edx
  801d89:	89 d1                	mov    %edx,%ecx
  801d8b:	89 c6                	mov    %eax,%esi
  801d8d:	e9 71 ff ff ff       	jmp    801d03 <__umoddi3+0xb3>
  801d92:	66 90                	xchg   %ax,%ax
  801d94:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d98:	72 ea                	jb     801d84 <__umoddi3+0x134>
  801d9a:	89 d9                	mov    %ebx,%ecx
  801d9c:	e9 62 ff ff ff       	jmp    801d03 <__umoddi3+0xb3>
