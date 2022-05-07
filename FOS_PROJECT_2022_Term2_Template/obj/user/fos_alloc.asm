
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
  80005c:	68 20 1d 80 00       	push   $0x801d20
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
  8000b9:	68 33 1d 80 00       	push   $0x801d33
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
  80010f:	68 33 1d 80 00       	push   $0x801d33
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
  80013e:	e8 0c 12 00 00       	call   80134f <sys_getenvindex>
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
  8001ad:	e8 38 13 00 00       	call   8014ea <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 58 1d 80 00       	push   $0x801d58
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
  8001dd:	68 80 1d 80 00       	push   $0x801d80
  8001e2:	e8 34 01 00 00       	call   80031b <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ef:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001f5:	83 ec 08             	sub    $0x8,%esp
  8001f8:	50                   	push   %eax
  8001f9:	68 a5 1d 80 00       	push   $0x801da5
  8001fe:	e8 18 01 00 00       	call   80031b <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 58 1d 80 00       	push   $0x801d58
  80020e:	e8 08 01 00 00       	call   80031b <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800216:	e8 e9 12 00 00       	call   801504 <sys_enable_interrupt>

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
  80022e:	e8 e8 10 00 00       	call   80131b <sys_env_destroy>
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
  80023f:	e8 3d 11 00 00       	call   801381 <sys_env_exit>
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
  80028d:	e8 47 10 00 00       	call   8012d9 <sys_cputs>
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
  800304:	e8 d0 0f 00 00       	call   8012d9 <sys_cputs>
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
  80034e:	e8 97 11 00 00       	call   8014ea <sys_disable_interrupt>
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
  80036e:	e8 91 11 00 00       	call   801504 <sys_enable_interrupt>
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
  8003b8:	e8 eb 16 00 00       	call   801aa8 <__udivdi3>
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
  800408:	e8 ab 17 00 00       	call   801bb8 <__umoddi3>
  80040d:	83 c4 10             	add    $0x10,%esp
  800410:	05 d4 1f 80 00       	add    $0x801fd4,%eax
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
  800563:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
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
  800644:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  80064b:	85 f6                	test   %esi,%esi
  80064d:	75 19                	jne    800668 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80064f:	53                   	push   %ebx
  800650:	68 e5 1f 80 00       	push   $0x801fe5
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
  800669:	68 ee 1f 80 00       	push   $0x801fee
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
  800696:	be f1 1f 80 00       	mov    $0x801ff1,%esi
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
} uHeapArr[kilo];

void* malloc(uint32 size) {
  8010a5:	55                   	push   %ebp
  8010a6:	89 e5                	mov    %esp,%ebp
  8010a8:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8010ab:	e8 9b 07 00 00       	call   80184b <sys_isUHeapPlacementStrategyNEXTFIT>
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
  8011f1:	e8 8b 02 00 00       	call   801481 <sys_allocateMem>
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
  801232:	68 50 21 80 00       	push   $0x802150
  801237:	6a 59                	push   $0x59
  801239:	68 6f 21 80 00       	push   $0x80216f
  80123e:	e8 85 06 00 00       	call   8018c8 <_panic>

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
  80124c:	68 7b 21 80 00       	push   $0x80217b
  801251:	6a 5f                	push   $0x5f
  801253:	68 6f 21 80 00       	push   $0x80216f
  801258:	e8 6b 06 00 00       	call   8018c8 <_panic>

0080125d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801263:	83 ec 04             	sub    $0x4,%esp
  801266:	68 98 21 80 00       	push   $0x802198
  80126b:	6a 70                	push   $0x70
  80126d:	68 6f 21 80 00       	push   $0x80216f
  801272:	e8 51 06 00 00       	call   8018c8 <_panic>

00801277 <sfree>:

}


void sfree(void* virtual_address)
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
  80127a:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  80127d:	83 ec 04             	sub    $0x4,%esp
  801280:	68 bb 21 80 00       	push   $0x8021bb
  801285:	6a 7b                	push   $0x7b
  801287:	68 6f 21 80 00       	push   $0x80216f
  80128c:	e8 37 06 00 00       	call   8018c8 <_panic>

00801291 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801297:	83 ec 04             	sub    $0x4,%esp
  80129a:	68 d8 21 80 00       	push   $0x8021d8
  80129f:	68 93 00 00 00       	push   $0x93
  8012a4:	68 6f 21 80 00       	push   $0x80216f
  8012a9:	e8 1a 06 00 00       	call   8018c8 <_panic>

008012ae <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	57                   	push   %edi
  8012b2:	56                   	push   %esi
  8012b3:	53                   	push   %ebx
  8012b4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012c0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012c3:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012c6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012c9:	cd 30                	int    $0x30
  8012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012d1:	83 c4 10             	add    $0x10,%esp
  8012d4:	5b                   	pop    %ebx
  8012d5:	5e                   	pop    %esi
  8012d6:	5f                   	pop    %edi
  8012d7:	5d                   	pop    %ebp
  8012d8:	c3                   	ret    

008012d9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 04             	sub    $0x4,%esp
  8012df:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012e5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	52                   	push   %edx
  8012f1:	ff 75 0c             	pushl  0xc(%ebp)
  8012f4:	50                   	push   %eax
  8012f5:	6a 00                	push   $0x0
  8012f7:	e8 b2 ff ff ff       	call   8012ae <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
}
  8012ff:	90                   	nop
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_cgetc>:

int
sys_cgetc(void)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 01                	push   $0x1
  801311:	e8 98 ff ff ff       	call   8012ae <syscall>
  801316:	83 c4 18             	add    $0x18,%esp
}
  801319:	c9                   	leave  
  80131a:	c3                   	ret    

0080131b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80131b:	55                   	push   %ebp
  80131c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80131e:	8b 45 08             	mov    0x8(%ebp),%eax
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	50                   	push   %eax
  80132a:	6a 05                	push   $0x5
  80132c:	e8 7d ff ff ff       	call   8012ae <syscall>
  801331:	83 c4 18             	add    $0x18,%esp
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 02                	push   $0x2
  801345:	e8 64 ff ff ff       	call   8012ae <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 03                	push   $0x3
  80135e:	e8 4b ff ff ff       	call   8012ae <syscall>
  801363:	83 c4 18             	add    $0x18,%esp
}
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 04                	push   $0x4
  801377:	e8 32 ff ff ff       	call   8012ae <syscall>
  80137c:	83 c4 18             	add    $0x18,%esp
}
  80137f:	c9                   	leave  
  801380:	c3                   	ret    

00801381 <sys_env_exit>:


void sys_env_exit(void)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 06                	push   $0x6
  801390:	e8 19 ff ff ff       	call   8012ae <syscall>
  801395:	83 c4 18             	add    $0x18,%esp
}
  801398:	90                   	nop
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80139e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	52                   	push   %edx
  8013ab:	50                   	push   %eax
  8013ac:	6a 07                	push   $0x7
  8013ae:	e8 fb fe ff ff       	call   8012ae <syscall>
  8013b3:	83 c4 18             	add    $0x18,%esp
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
  8013bb:	56                   	push   %esi
  8013bc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8013bd:	8b 75 18             	mov    0x18(%ebp),%esi
  8013c0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8013c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	56                   	push   %esi
  8013cd:	53                   	push   %ebx
  8013ce:	51                   	push   %ecx
  8013cf:	52                   	push   %edx
  8013d0:	50                   	push   %eax
  8013d1:	6a 08                	push   $0x8
  8013d3:	e8 d6 fe ff ff       	call   8012ae <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013de:	5b                   	pop    %ebx
  8013df:	5e                   	pop    %esi
  8013e0:	5d                   	pop    %ebp
  8013e1:	c3                   	ret    

008013e2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	52                   	push   %edx
  8013f2:	50                   	push   %eax
  8013f3:	6a 09                	push   $0x9
  8013f5:	e8 b4 fe ff ff       	call   8012ae <syscall>
  8013fa:	83 c4 18             	add    $0x18,%esp
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	ff 75 0c             	pushl  0xc(%ebp)
  80140b:	ff 75 08             	pushl  0x8(%ebp)
  80140e:	6a 0a                	push   $0xa
  801410:	e8 99 fe ff ff       	call   8012ae <syscall>
  801415:	83 c4 18             	add    $0x18,%esp
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	6a 0b                	push   $0xb
  801429:	e8 80 fe ff ff       	call   8012ae <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 0c                	push   $0xc
  801442:	e8 67 fe ff ff       	call   8012ae <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 0d                	push   $0xd
  80145b:	e8 4e fe ff ff       	call   8012ae <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	ff 75 08             	pushl  0x8(%ebp)
  801474:	6a 11                	push   $0x11
  801476:	e8 33 fe ff ff       	call   8012ae <syscall>
  80147b:	83 c4 18             	add    $0x18,%esp
	return;
  80147e:	90                   	nop
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	ff 75 0c             	pushl  0xc(%ebp)
  80148d:	ff 75 08             	pushl  0x8(%ebp)
  801490:	6a 12                	push   $0x12
  801492:	e8 17 fe ff ff       	call   8012ae <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
	return ;
  80149a:	90                   	nop
}
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 0e                	push   $0xe
  8014ac:	e8 fd fd ff ff       	call   8012ae <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	ff 75 08             	pushl  0x8(%ebp)
  8014c4:	6a 0f                	push   $0xf
  8014c6:	e8 e3 fd ff ff       	call   8012ae <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 10                	push   $0x10
  8014df:	e8 ca fd ff ff       	call   8012ae <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
}
  8014e7:	90                   	nop
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 14                	push   $0x14
  8014f9:	e8 b0 fd ff ff       	call   8012ae <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
}
  801501:	90                   	nop
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 15                	push   $0x15
  801513:	e8 96 fd ff ff       	call   8012ae <syscall>
  801518:	83 c4 18             	add    $0x18,%esp
}
  80151b:	90                   	nop
  80151c:	c9                   	leave  
  80151d:	c3                   	ret    

0080151e <sys_cputc>:


void
sys_cputc(const char c)
{
  80151e:	55                   	push   %ebp
  80151f:	89 e5                	mov    %esp,%ebp
  801521:	83 ec 04             	sub    $0x4,%esp
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80152a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	50                   	push   %eax
  801537:	6a 16                	push   $0x16
  801539:	e8 70 fd ff ff       	call   8012ae <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	90                   	nop
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 17                	push   $0x17
  801553:	e8 56 fd ff ff       	call   8012ae <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	90                   	nop
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	ff 75 0c             	pushl  0xc(%ebp)
  80156d:	50                   	push   %eax
  80156e:	6a 18                	push   $0x18
  801570:	e8 39 fd ff ff       	call   8012ae <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80157d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	52                   	push   %edx
  80158a:	50                   	push   %eax
  80158b:	6a 1b                	push   $0x1b
  80158d:	e8 1c fd ff ff       	call   8012ae <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80159a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	52                   	push   %edx
  8015a7:	50                   	push   %eax
  8015a8:	6a 19                	push   $0x19
  8015aa:	e8 ff fc ff ff       	call   8012ae <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	90                   	nop
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	52                   	push   %edx
  8015c5:	50                   	push   %eax
  8015c6:	6a 1a                	push   $0x1a
  8015c8:	e8 e1 fc ff ff       	call   8012ae <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	90                   	nop
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
  8015d6:	83 ec 04             	sub    $0x4,%esp
  8015d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015df:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015e2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e9:	6a 00                	push   $0x0
  8015eb:	51                   	push   %ecx
  8015ec:	52                   	push   %edx
  8015ed:	ff 75 0c             	pushl  0xc(%ebp)
  8015f0:	50                   	push   %eax
  8015f1:	6a 1c                	push   $0x1c
  8015f3:	e8 b6 fc ff ff       	call   8012ae <syscall>
  8015f8:	83 c4 18             	add    $0x18,%esp
}
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801600:	8b 55 0c             	mov    0xc(%ebp),%edx
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	52                   	push   %edx
  80160d:	50                   	push   %eax
  80160e:	6a 1d                	push   $0x1d
  801610:	e8 99 fc ff ff       	call   8012ae <syscall>
  801615:	83 c4 18             	add    $0x18,%esp
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80161d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801620:	8b 55 0c             	mov    0xc(%ebp),%edx
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	51                   	push   %ecx
  80162b:	52                   	push   %edx
  80162c:	50                   	push   %eax
  80162d:	6a 1e                	push   $0x1e
  80162f:	e8 7a fc ff ff       	call   8012ae <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80163c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	52                   	push   %edx
  801649:	50                   	push   %eax
  80164a:	6a 1f                	push   $0x1f
  80164c:	e8 5d fc ff ff       	call   8012ae <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 20                	push   $0x20
  801665:	e8 44 fc ff ff       	call   8012ae <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	ff 75 10             	pushl  0x10(%ebp)
  80167c:	ff 75 0c             	pushl  0xc(%ebp)
  80167f:	50                   	push   %eax
  801680:	6a 21                	push   $0x21
  801682:	e8 27 fc ff ff       	call   8012ae <syscall>
  801687:	83 c4 18             	add    $0x18,%esp
}
  80168a:	c9                   	leave  
  80168b:	c3                   	ret    

0080168c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	50                   	push   %eax
  80169b:	6a 22                	push   $0x22
  80169d:	e8 0c fc ff ff       	call   8012ae <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	90                   	nop
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	50                   	push   %eax
  8016b7:	6a 23                	push   $0x23
  8016b9:	e8 f0 fb ff ff       	call   8012ae <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
}
  8016c1:	90                   	nop
  8016c2:	c9                   	leave  
  8016c3:	c3                   	ret    

008016c4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016c4:	55                   	push   %ebp
  8016c5:	89 e5                	mov    %esp,%ebp
  8016c7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016ca:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016cd:	8d 50 04             	lea    0x4(%eax),%edx
  8016d0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	52                   	push   %edx
  8016da:	50                   	push   %eax
  8016db:	6a 24                	push   $0x24
  8016dd:	e8 cc fb ff ff       	call   8012ae <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
	return result;
  8016e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ee:	89 01                	mov    %eax,(%ecx)
  8016f0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	c9                   	leave  
  8016f7:	c2 04 00             	ret    $0x4

008016fa <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	ff 75 10             	pushl  0x10(%ebp)
  801704:	ff 75 0c             	pushl  0xc(%ebp)
  801707:	ff 75 08             	pushl  0x8(%ebp)
  80170a:	6a 13                	push   $0x13
  80170c:	e8 9d fb ff ff       	call   8012ae <syscall>
  801711:	83 c4 18             	add    $0x18,%esp
	return ;
  801714:	90                   	nop
}
  801715:	c9                   	leave  
  801716:	c3                   	ret    

00801717 <sys_rcr2>:
uint32 sys_rcr2()
{
  801717:	55                   	push   %ebp
  801718:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 25                	push   $0x25
  801726:	e8 83 fb ff ff       	call   8012ae <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
  801733:	83 ec 04             	sub    $0x4,%esp
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80173c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	50                   	push   %eax
  801749:	6a 26                	push   $0x26
  80174b:	e8 5e fb ff ff       	call   8012ae <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
	return ;
  801753:	90                   	nop
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <rsttst>:
void rsttst()
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 28                	push   $0x28
  801765:	e8 44 fb ff ff       	call   8012ae <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
	return ;
  80176d:	90                   	nop
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
  801773:	83 ec 04             	sub    $0x4,%esp
  801776:	8b 45 14             	mov    0x14(%ebp),%eax
  801779:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80177c:	8b 55 18             	mov    0x18(%ebp),%edx
  80177f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801783:	52                   	push   %edx
  801784:	50                   	push   %eax
  801785:	ff 75 10             	pushl  0x10(%ebp)
  801788:	ff 75 0c             	pushl  0xc(%ebp)
  80178b:	ff 75 08             	pushl  0x8(%ebp)
  80178e:	6a 27                	push   $0x27
  801790:	e8 19 fb ff ff       	call   8012ae <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
	return ;
  801798:	90                   	nop
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <chktst>:
void chktst(uint32 n)
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	ff 75 08             	pushl  0x8(%ebp)
  8017a9:	6a 29                	push   $0x29
  8017ab:	e8 fe fa ff ff       	call   8012ae <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b3:	90                   	nop
}
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <inctst>:

void inctst()
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 2a                	push   $0x2a
  8017c5:	e8 e4 fa ff ff       	call   8012ae <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8017cd:	90                   	nop
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <gettst>:
uint32 gettst()
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 2b                	push   $0x2b
  8017df:	e8 ca fa ff ff       	call   8012ae <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
  8017ec:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 2c                	push   $0x2c
  8017fb:	e8 ae fa ff ff       	call   8012ae <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
  801803:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801806:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80180a:	75 07                	jne    801813 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80180c:	b8 01 00 00 00       	mov    $0x1,%eax
  801811:	eb 05                	jmp    801818 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801813:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
  80181d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 2c                	push   $0x2c
  80182c:	e8 7d fa ff ff       	call   8012ae <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
  801834:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801837:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80183b:	75 07                	jne    801844 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80183d:	b8 01 00 00 00       	mov    $0x1,%eax
  801842:	eb 05                	jmp    801849 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801844:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
  80184e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 2c                	push   $0x2c
  80185d:	e8 4c fa ff ff       	call   8012ae <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
  801865:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801868:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80186c:	75 07                	jne    801875 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80186e:	b8 01 00 00 00       	mov    $0x1,%eax
  801873:	eb 05                	jmp    80187a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801875:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
  80187f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 2c                	push   $0x2c
  80188e:	e8 1b fa ff ff       	call   8012ae <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
  801896:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801899:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80189d:	75 07                	jne    8018a6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80189f:	b8 01 00 00 00       	mov    $0x1,%eax
  8018a4:	eb 05                	jmp    8018ab <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8018a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018ab:	c9                   	leave  
  8018ac:	c3                   	ret    

008018ad <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	ff 75 08             	pushl  0x8(%ebp)
  8018bb:	6a 2d                	push   $0x2d
  8018bd:	e8 ec f9 ff ff       	call   8012ae <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c5:	90                   	nop
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
  8018cb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8018ce:	8d 45 10             	lea    0x10(%ebp),%eax
  8018d1:	83 c0 04             	add    $0x4,%eax
  8018d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8018d7:	a1 40 50 88 00       	mov    0x885040,%eax
  8018dc:	85 c0                	test   %eax,%eax
  8018de:	74 16                	je     8018f6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8018e0:	a1 40 50 88 00       	mov    0x885040,%eax
  8018e5:	83 ec 08             	sub    $0x8,%esp
  8018e8:	50                   	push   %eax
  8018e9:	68 00 22 80 00       	push   $0x802200
  8018ee:	e8 28 ea ff ff       	call   80031b <cprintf>
  8018f3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8018f6:	a1 00 30 80 00       	mov    0x803000,%eax
  8018fb:	ff 75 0c             	pushl  0xc(%ebp)
  8018fe:	ff 75 08             	pushl  0x8(%ebp)
  801901:	50                   	push   %eax
  801902:	68 05 22 80 00       	push   $0x802205
  801907:	e8 0f ea ff ff       	call   80031b <cprintf>
  80190c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80190f:	8b 45 10             	mov    0x10(%ebp),%eax
  801912:	83 ec 08             	sub    $0x8,%esp
  801915:	ff 75 f4             	pushl  -0xc(%ebp)
  801918:	50                   	push   %eax
  801919:	e8 92 e9 ff ff       	call   8002b0 <vcprintf>
  80191e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801921:	83 ec 08             	sub    $0x8,%esp
  801924:	6a 00                	push   $0x0
  801926:	68 21 22 80 00       	push   $0x802221
  80192b:	e8 80 e9 ff ff       	call   8002b0 <vcprintf>
  801930:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801933:	e8 01 e9 ff ff       	call   800239 <exit>

	// should not return here
	while (1) ;
  801938:	eb fe                	jmp    801938 <_panic+0x70>

0080193a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
  80193d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801940:	a1 20 30 80 00       	mov    0x803020,%eax
  801945:	8b 50 74             	mov    0x74(%eax),%edx
  801948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194b:	39 c2                	cmp    %eax,%edx
  80194d:	74 14                	je     801963 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80194f:	83 ec 04             	sub    $0x4,%esp
  801952:	68 24 22 80 00       	push   $0x802224
  801957:	6a 26                	push   $0x26
  801959:	68 70 22 80 00       	push   $0x802270
  80195e:	e8 65 ff ff ff       	call   8018c8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801963:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80196a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801971:	e9 c2 00 00 00       	jmp    801a38 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801976:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801979:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801980:	8b 45 08             	mov    0x8(%ebp),%eax
  801983:	01 d0                	add    %edx,%eax
  801985:	8b 00                	mov    (%eax),%eax
  801987:	85 c0                	test   %eax,%eax
  801989:	75 08                	jne    801993 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80198b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80198e:	e9 a2 00 00 00       	jmp    801a35 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801993:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80199a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8019a1:	eb 69                	jmp    801a0c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8019a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8019a8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8019ae:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8019b1:	89 d0                	mov    %edx,%eax
  8019b3:	01 c0                	add    %eax,%eax
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	c1 e0 02             	shl    $0x2,%eax
  8019ba:	01 c8                	add    %ecx,%eax
  8019bc:	8a 40 04             	mov    0x4(%eax),%al
  8019bf:	84 c0                	test   %al,%al
  8019c1:	75 46                	jne    801a09 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8019c8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8019ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8019d1:	89 d0                	mov    %edx,%eax
  8019d3:	01 c0                	add    %eax,%eax
  8019d5:	01 d0                	add    %edx,%eax
  8019d7:	c1 e0 02             	shl    $0x2,%eax
  8019da:	01 c8                	add    %ecx,%eax
  8019dc:	8b 00                	mov    (%eax),%eax
  8019de:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8019e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019e4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8019e9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8019eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ee:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f8:	01 c8                	add    %ecx,%eax
  8019fa:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019fc:	39 c2                	cmp    %eax,%edx
  8019fe:	75 09                	jne    801a09 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801a00:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801a07:	eb 12                	jmp    801a1b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a09:	ff 45 e8             	incl   -0x18(%ebp)
  801a0c:	a1 20 30 80 00       	mov    0x803020,%eax
  801a11:	8b 50 74             	mov    0x74(%eax),%edx
  801a14:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a17:	39 c2                	cmp    %eax,%edx
  801a19:	77 88                	ja     8019a3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801a1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a1f:	75 14                	jne    801a35 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801a21:	83 ec 04             	sub    $0x4,%esp
  801a24:	68 7c 22 80 00       	push   $0x80227c
  801a29:	6a 3a                	push   $0x3a
  801a2b:	68 70 22 80 00       	push   $0x802270
  801a30:	e8 93 fe ff ff       	call   8018c8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801a35:	ff 45 f0             	incl   -0x10(%ebp)
  801a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801a3e:	0f 8c 32 ff ff ff    	jl     801976 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a44:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a4b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801a52:	eb 26                	jmp    801a7a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801a54:	a1 20 30 80 00       	mov    0x803020,%eax
  801a59:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a62:	89 d0                	mov    %edx,%eax
  801a64:	01 c0                	add    %eax,%eax
  801a66:	01 d0                	add    %edx,%eax
  801a68:	c1 e0 02             	shl    $0x2,%eax
  801a6b:	01 c8                	add    %ecx,%eax
  801a6d:	8a 40 04             	mov    0x4(%eax),%al
  801a70:	3c 01                	cmp    $0x1,%al
  801a72:	75 03                	jne    801a77 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801a74:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a77:	ff 45 e0             	incl   -0x20(%ebp)
  801a7a:	a1 20 30 80 00       	mov    0x803020,%eax
  801a7f:	8b 50 74             	mov    0x74(%eax),%edx
  801a82:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a85:	39 c2                	cmp    %eax,%edx
  801a87:	77 cb                	ja     801a54 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a8c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a8f:	74 14                	je     801aa5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801a91:	83 ec 04             	sub    $0x4,%esp
  801a94:	68 d0 22 80 00       	push   $0x8022d0
  801a99:	6a 44                	push   $0x44
  801a9b:	68 70 22 80 00       	push   $0x802270
  801aa0:	e8 23 fe ff ff       	call   8018c8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801aa5:	90                   	nop
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <__udivdi3>:
  801aa8:	55                   	push   %ebp
  801aa9:	57                   	push   %edi
  801aaa:	56                   	push   %esi
  801aab:	53                   	push   %ebx
  801aac:	83 ec 1c             	sub    $0x1c,%esp
  801aaf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ab3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ab7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801abb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801abf:	89 ca                	mov    %ecx,%edx
  801ac1:	89 f8                	mov    %edi,%eax
  801ac3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ac7:	85 f6                	test   %esi,%esi
  801ac9:	75 2d                	jne    801af8 <__udivdi3+0x50>
  801acb:	39 cf                	cmp    %ecx,%edi
  801acd:	77 65                	ja     801b34 <__udivdi3+0x8c>
  801acf:	89 fd                	mov    %edi,%ebp
  801ad1:	85 ff                	test   %edi,%edi
  801ad3:	75 0b                	jne    801ae0 <__udivdi3+0x38>
  801ad5:	b8 01 00 00 00       	mov    $0x1,%eax
  801ada:	31 d2                	xor    %edx,%edx
  801adc:	f7 f7                	div    %edi
  801ade:	89 c5                	mov    %eax,%ebp
  801ae0:	31 d2                	xor    %edx,%edx
  801ae2:	89 c8                	mov    %ecx,%eax
  801ae4:	f7 f5                	div    %ebp
  801ae6:	89 c1                	mov    %eax,%ecx
  801ae8:	89 d8                	mov    %ebx,%eax
  801aea:	f7 f5                	div    %ebp
  801aec:	89 cf                	mov    %ecx,%edi
  801aee:	89 fa                	mov    %edi,%edx
  801af0:	83 c4 1c             	add    $0x1c,%esp
  801af3:	5b                   	pop    %ebx
  801af4:	5e                   	pop    %esi
  801af5:	5f                   	pop    %edi
  801af6:	5d                   	pop    %ebp
  801af7:	c3                   	ret    
  801af8:	39 ce                	cmp    %ecx,%esi
  801afa:	77 28                	ja     801b24 <__udivdi3+0x7c>
  801afc:	0f bd fe             	bsr    %esi,%edi
  801aff:	83 f7 1f             	xor    $0x1f,%edi
  801b02:	75 40                	jne    801b44 <__udivdi3+0x9c>
  801b04:	39 ce                	cmp    %ecx,%esi
  801b06:	72 0a                	jb     801b12 <__udivdi3+0x6a>
  801b08:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b0c:	0f 87 9e 00 00 00    	ja     801bb0 <__udivdi3+0x108>
  801b12:	b8 01 00 00 00       	mov    $0x1,%eax
  801b17:	89 fa                	mov    %edi,%edx
  801b19:	83 c4 1c             	add    $0x1c,%esp
  801b1c:	5b                   	pop    %ebx
  801b1d:	5e                   	pop    %esi
  801b1e:	5f                   	pop    %edi
  801b1f:	5d                   	pop    %ebp
  801b20:	c3                   	ret    
  801b21:	8d 76 00             	lea    0x0(%esi),%esi
  801b24:	31 ff                	xor    %edi,%edi
  801b26:	31 c0                	xor    %eax,%eax
  801b28:	89 fa                	mov    %edi,%edx
  801b2a:	83 c4 1c             	add    $0x1c,%esp
  801b2d:	5b                   	pop    %ebx
  801b2e:	5e                   	pop    %esi
  801b2f:	5f                   	pop    %edi
  801b30:	5d                   	pop    %ebp
  801b31:	c3                   	ret    
  801b32:	66 90                	xchg   %ax,%ax
  801b34:	89 d8                	mov    %ebx,%eax
  801b36:	f7 f7                	div    %edi
  801b38:	31 ff                	xor    %edi,%edi
  801b3a:	89 fa                	mov    %edi,%edx
  801b3c:	83 c4 1c             	add    $0x1c,%esp
  801b3f:	5b                   	pop    %ebx
  801b40:	5e                   	pop    %esi
  801b41:	5f                   	pop    %edi
  801b42:	5d                   	pop    %ebp
  801b43:	c3                   	ret    
  801b44:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b49:	89 eb                	mov    %ebp,%ebx
  801b4b:	29 fb                	sub    %edi,%ebx
  801b4d:	89 f9                	mov    %edi,%ecx
  801b4f:	d3 e6                	shl    %cl,%esi
  801b51:	89 c5                	mov    %eax,%ebp
  801b53:	88 d9                	mov    %bl,%cl
  801b55:	d3 ed                	shr    %cl,%ebp
  801b57:	89 e9                	mov    %ebp,%ecx
  801b59:	09 f1                	or     %esi,%ecx
  801b5b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b5f:	89 f9                	mov    %edi,%ecx
  801b61:	d3 e0                	shl    %cl,%eax
  801b63:	89 c5                	mov    %eax,%ebp
  801b65:	89 d6                	mov    %edx,%esi
  801b67:	88 d9                	mov    %bl,%cl
  801b69:	d3 ee                	shr    %cl,%esi
  801b6b:	89 f9                	mov    %edi,%ecx
  801b6d:	d3 e2                	shl    %cl,%edx
  801b6f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b73:	88 d9                	mov    %bl,%cl
  801b75:	d3 e8                	shr    %cl,%eax
  801b77:	09 c2                	or     %eax,%edx
  801b79:	89 d0                	mov    %edx,%eax
  801b7b:	89 f2                	mov    %esi,%edx
  801b7d:	f7 74 24 0c          	divl   0xc(%esp)
  801b81:	89 d6                	mov    %edx,%esi
  801b83:	89 c3                	mov    %eax,%ebx
  801b85:	f7 e5                	mul    %ebp
  801b87:	39 d6                	cmp    %edx,%esi
  801b89:	72 19                	jb     801ba4 <__udivdi3+0xfc>
  801b8b:	74 0b                	je     801b98 <__udivdi3+0xf0>
  801b8d:	89 d8                	mov    %ebx,%eax
  801b8f:	31 ff                	xor    %edi,%edi
  801b91:	e9 58 ff ff ff       	jmp    801aee <__udivdi3+0x46>
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b9c:	89 f9                	mov    %edi,%ecx
  801b9e:	d3 e2                	shl    %cl,%edx
  801ba0:	39 c2                	cmp    %eax,%edx
  801ba2:	73 e9                	jae    801b8d <__udivdi3+0xe5>
  801ba4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ba7:	31 ff                	xor    %edi,%edi
  801ba9:	e9 40 ff ff ff       	jmp    801aee <__udivdi3+0x46>
  801bae:	66 90                	xchg   %ax,%ax
  801bb0:	31 c0                	xor    %eax,%eax
  801bb2:	e9 37 ff ff ff       	jmp    801aee <__udivdi3+0x46>
  801bb7:	90                   	nop

00801bb8 <__umoddi3>:
  801bb8:	55                   	push   %ebp
  801bb9:	57                   	push   %edi
  801bba:	56                   	push   %esi
  801bbb:	53                   	push   %ebx
  801bbc:	83 ec 1c             	sub    $0x1c,%esp
  801bbf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bc3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bcb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bcf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bd3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bd7:	89 f3                	mov    %esi,%ebx
  801bd9:	89 fa                	mov    %edi,%edx
  801bdb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bdf:	89 34 24             	mov    %esi,(%esp)
  801be2:	85 c0                	test   %eax,%eax
  801be4:	75 1a                	jne    801c00 <__umoddi3+0x48>
  801be6:	39 f7                	cmp    %esi,%edi
  801be8:	0f 86 a2 00 00 00    	jbe    801c90 <__umoddi3+0xd8>
  801bee:	89 c8                	mov    %ecx,%eax
  801bf0:	89 f2                	mov    %esi,%edx
  801bf2:	f7 f7                	div    %edi
  801bf4:	89 d0                	mov    %edx,%eax
  801bf6:	31 d2                	xor    %edx,%edx
  801bf8:	83 c4 1c             	add    $0x1c,%esp
  801bfb:	5b                   	pop    %ebx
  801bfc:	5e                   	pop    %esi
  801bfd:	5f                   	pop    %edi
  801bfe:	5d                   	pop    %ebp
  801bff:	c3                   	ret    
  801c00:	39 f0                	cmp    %esi,%eax
  801c02:	0f 87 ac 00 00 00    	ja     801cb4 <__umoddi3+0xfc>
  801c08:	0f bd e8             	bsr    %eax,%ebp
  801c0b:	83 f5 1f             	xor    $0x1f,%ebp
  801c0e:	0f 84 ac 00 00 00    	je     801cc0 <__umoddi3+0x108>
  801c14:	bf 20 00 00 00       	mov    $0x20,%edi
  801c19:	29 ef                	sub    %ebp,%edi
  801c1b:	89 fe                	mov    %edi,%esi
  801c1d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c21:	89 e9                	mov    %ebp,%ecx
  801c23:	d3 e0                	shl    %cl,%eax
  801c25:	89 d7                	mov    %edx,%edi
  801c27:	89 f1                	mov    %esi,%ecx
  801c29:	d3 ef                	shr    %cl,%edi
  801c2b:	09 c7                	or     %eax,%edi
  801c2d:	89 e9                	mov    %ebp,%ecx
  801c2f:	d3 e2                	shl    %cl,%edx
  801c31:	89 14 24             	mov    %edx,(%esp)
  801c34:	89 d8                	mov    %ebx,%eax
  801c36:	d3 e0                	shl    %cl,%eax
  801c38:	89 c2                	mov    %eax,%edx
  801c3a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c3e:	d3 e0                	shl    %cl,%eax
  801c40:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c44:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c48:	89 f1                	mov    %esi,%ecx
  801c4a:	d3 e8                	shr    %cl,%eax
  801c4c:	09 d0                	or     %edx,%eax
  801c4e:	d3 eb                	shr    %cl,%ebx
  801c50:	89 da                	mov    %ebx,%edx
  801c52:	f7 f7                	div    %edi
  801c54:	89 d3                	mov    %edx,%ebx
  801c56:	f7 24 24             	mull   (%esp)
  801c59:	89 c6                	mov    %eax,%esi
  801c5b:	89 d1                	mov    %edx,%ecx
  801c5d:	39 d3                	cmp    %edx,%ebx
  801c5f:	0f 82 87 00 00 00    	jb     801cec <__umoddi3+0x134>
  801c65:	0f 84 91 00 00 00    	je     801cfc <__umoddi3+0x144>
  801c6b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c6f:	29 f2                	sub    %esi,%edx
  801c71:	19 cb                	sbb    %ecx,%ebx
  801c73:	89 d8                	mov    %ebx,%eax
  801c75:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c79:	d3 e0                	shl    %cl,%eax
  801c7b:	89 e9                	mov    %ebp,%ecx
  801c7d:	d3 ea                	shr    %cl,%edx
  801c7f:	09 d0                	or     %edx,%eax
  801c81:	89 e9                	mov    %ebp,%ecx
  801c83:	d3 eb                	shr    %cl,%ebx
  801c85:	89 da                	mov    %ebx,%edx
  801c87:	83 c4 1c             	add    $0x1c,%esp
  801c8a:	5b                   	pop    %ebx
  801c8b:	5e                   	pop    %esi
  801c8c:	5f                   	pop    %edi
  801c8d:	5d                   	pop    %ebp
  801c8e:	c3                   	ret    
  801c8f:	90                   	nop
  801c90:	89 fd                	mov    %edi,%ebp
  801c92:	85 ff                	test   %edi,%edi
  801c94:	75 0b                	jne    801ca1 <__umoddi3+0xe9>
  801c96:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9b:	31 d2                	xor    %edx,%edx
  801c9d:	f7 f7                	div    %edi
  801c9f:	89 c5                	mov    %eax,%ebp
  801ca1:	89 f0                	mov    %esi,%eax
  801ca3:	31 d2                	xor    %edx,%edx
  801ca5:	f7 f5                	div    %ebp
  801ca7:	89 c8                	mov    %ecx,%eax
  801ca9:	f7 f5                	div    %ebp
  801cab:	89 d0                	mov    %edx,%eax
  801cad:	e9 44 ff ff ff       	jmp    801bf6 <__umoddi3+0x3e>
  801cb2:	66 90                	xchg   %ax,%ax
  801cb4:	89 c8                	mov    %ecx,%eax
  801cb6:	89 f2                	mov    %esi,%edx
  801cb8:	83 c4 1c             	add    $0x1c,%esp
  801cbb:	5b                   	pop    %ebx
  801cbc:	5e                   	pop    %esi
  801cbd:	5f                   	pop    %edi
  801cbe:	5d                   	pop    %ebp
  801cbf:	c3                   	ret    
  801cc0:	3b 04 24             	cmp    (%esp),%eax
  801cc3:	72 06                	jb     801ccb <__umoddi3+0x113>
  801cc5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cc9:	77 0f                	ja     801cda <__umoddi3+0x122>
  801ccb:	89 f2                	mov    %esi,%edx
  801ccd:	29 f9                	sub    %edi,%ecx
  801ccf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cd3:	89 14 24             	mov    %edx,(%esp)
  801cd6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cda:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cde:	8b 14 24             	mov    (%esp),%edx
  801ce1:	83 c4 1c             	add    $0x1c,%esp
  801ce4:	5b                   	pop    %ebx
  801ce5:	5e                   	pop    %esi
  801ce6:	5f                   	pop    %edi
  801ce7:	5d                   	pop    %ebp
  801ce8:	c3                   	ret    
  801ce9:	8d 76 00             	lea    0x0(%esi),%esi
  801cec:	2b 04 24             	sub    (%esp),%eax
  801cef:	19 fa                	sbb    %edi,%edx
  801cf1:	89 d1                	mov    %edx,%ecx
  801cf3:	89 c6                	mov    %eax,%esi
  801cf5:	e9 71 ff ff ff       	jmp    801c6b <__umoddi3+0xb3>
  801cfa:	66 90                	xchg   %ax,%ax
  801cfc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d00:	72 ea                	jb     801cec <__umoddi3+0x134>
  801d02:	89 d9                	mov    %ebx,%ecx
  801d04:	e9 62 ff ff ff       	jmp    801c6b <__umoddi3+0xb3>
