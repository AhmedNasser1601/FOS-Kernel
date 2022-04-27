
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
  80005c:	68 c0 1b 80 00       	push   $0x801bc0
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
  8000b9:	68 d3 1b 80 00       	push   $0x801bd3
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
  8000d7:	e8 1d 10 00 00       	call   8010f9 <free>
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
  80010f:	68 d3 1b 80 00       	push   $0x801bd3
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
  80012d:	e8 c7 0f 00 00       	call   8010f9 <free>
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
  80013e:	e8 a5 10 00 00       	call   8011e8 <sys_getenvindex>
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
  800169:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80016e:	a1 04 30 80 00       	mov    0x803004,%eax
  800173:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800179:	84 c0                	test   %al,%al
  80017b:	74 0f                	je     80018c <libmain+0x54>
		binaryname = myEnv->prog_name;
  80017d:	a1 04 30 80 00       	mov    0x803004,%eax
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
  8001ad:	e8 d1 11 00 00       	call   801383 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 f8 1b 80 00       	push   $0x801bf8
  8001ba:	e8 5c 01 00 00       	call   80031b <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001c2:	a1 04 30 80 00       	mov    0x803004,%eax
  8001c7:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8001cd:	a1 04 30 80 00       	mov    0x803004,%eax
  8001d2:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	52                   	push   %edx
  8001dc:	50                   	push   %eax
  8001dd:	68 20 1c 80 00       	push   $0x801c20
  8001e2:	e8 34 01 00 00       	call   80031b <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001ea:	a1 04 30 80 00       	mov    0x803004,%eax
  8001ef:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8001f5:	83 ec 08             	sub    $0x8,%esp
  8001f8:	50                   	push   %eax
  8001f9:	68 45 1c 80 00       	push   $0x801c45
  8001fe:	e8 18 01 00 00       	call   80031b <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 f8 1b 80 00       	push   $0x801bf8
  80020e:	e8 08 01 00 00       	call   80031b <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800216:	e8 82 11 00 00       	call   80139d <sys_enable_interrupt>

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
  80022e:	e8 81 0f 00 00       	call   8011b4 <sys_env_destroy>
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
  80023f:	e8 d6 0f 00 00       	call   80121a <sys_env_exit>
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
  800272:	a0 08 30 80 00       	mov    0x803008,%al
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
  80028d:	e8 e0 0e 00 00       	call   801172 <sys_cputs>
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
  8002e7:	a0 08 30 80 00       	mov    0x803008,%al
  8002ec:	0f b6 c0             	movzbl %al,%eax
  8002ef:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002f5:	83 ec 04             	sub    $0x4,%esp
  8002f8:	50                   	push   %eax
  8002f9:	52                   	push   %edx
  8002fa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800300:	83 c0 08             	add    $0x8,%eax
  800303:	50                   	push   %eax
  800304:	e8 69 0e 00 00       	call   801172 <sys_cputs>
  800309:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80030c:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
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
  800321:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
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
  80034e:	e8 30 10 00 00       	call   801383 <sys_disable_interrupt>
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
  80036e:	e8 2a 10 00 00       	call   80139d <sys_enable_interrupt>
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
  8003b8:	e8 87 15 00 00       	call   801944 <__udivdi3>
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
  800408:	e8 47 16 00 00       	call   801a54 <__umoddi3>
  80040d:	83 c4 10             	add    $0x10,%esp
  800410:	05 74 1e 80 00       	add    $0x801e74,%eax
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
  800563:	8b 04 85 98 1e 80 00 	mov    0x801e98(,%eax,4),%eax
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
  800644:	8b 34 9d e0 1c 80 00 	mov    0x801ce0(,%ebx,4),%esi
  80064b:	85 f6                	test   %esi,%esi
  80064d:	75 19                	jne    800668 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80064f:	53                   	push   %ebx
  800650:	68 85 1e 80 00       	push   $0x801e85
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
  800669:	68 8e 1e 80 00       	push   $0x801e8e
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
  800696:	be 91 1e 80 00       	mov    $0x801e91,%esi
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
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  8010a5:	55                   	push   %ebp
  8010a6:	89 e5                	mov    %esp,%ebp
  8010a8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8010ab:	83 ec 04             	sub    $0x4,%esp
  8010ae:	68 f0 1f 80 00       	push   $0x801ff0
  8010b3:	6a 19                	push   $0x19
  8010b5:	68 15 20 80 00       	push   $0x802015
  8010ba:	e8 a2 06 00 00       	call   801761 <_panic>

008010bf <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8010bf:	55                   	push   %ebp
  8010c0:	89 e5                	mov    %esp,%ebp
  8010c2:	83 ec 18             	sub    $0x18,%esp
  8010c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c8:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8010cb:	83 ec 04             	sub    $0x4,%esp
  8010ce:	68 24 20 80 00       	push   $0x802024
  8010d3:	6a 30                	push   $0x30
  8010d5:	68 15 20 80 00       	push   $0x802015
  8010da:	e8 82 06 00 00       	call   801761 <_panic>

008010df <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
  8010e2:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8010e5:	83 ec 04             	sub    $0x4,%esp
  8010e8:	68 43 20 80 00       	push   $0x802043
  8010ed:	6a 36                	push   $0x36
  8010ef:	68 15 20 80 00       	push   $0x802015
  8010f4:	e8 68 06 00 00       	call   801761 <_panic>

008010f9 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
  8010fc:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8010ff:	83 ec 04             	sub    $0x4,%esp
  801102:	68 60 20 80 00       	push   $0x802060
  801107:	6a 48                	push   $0x48
  801109:	68 15 20 80 00       	push   $0x802015
  80110e:	e8 4e 06 00 00       	call   801761 <_panic>

00801113 <sfree>:

}


void sfree(void* virtual_address)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801119:	83 ec 04             	sub    $0x4,%esp
  80111c:	68 83 20 80 00       	push   $0x802083
  801121:	6a 53                	push   $0x53
  801123:	68 15 20 80 00       	push   $0x802015
  801128:	e8 34 06 00 00       	call   801761 <_panic>

0080112d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801133:	83 ec 04             	sub    $0x4,%esp
  801136:	68 a0 20 80 00       	push   $0x8020a0
  80113b:	6a 6c                	push   $0x6c
  80113d:	68 15 20 80 00       	push   $0x802015
  801142:	e8 1a 06 00 00       	call   801761 <_panic>

00801147 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801147:	55                   	push   %ebp
  801148:	89 e5                	mov    %esp,%ebp
  80114a:	57                   	push   %edi
  80114b:	56                   	push   %esi
  80114c:	53                   	push   %ebx
  80114d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8b 55 0c             	mov    0xc(%ebp),%edx
  801156:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801159:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80115c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80115f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801162:	cd 30                	int    $0x30
  801164:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801167:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80116a:	83 c4 10             	add    $0x10,%esp
  80116d:	5b                   	pop    %ebx
  80116e:	5e                   	pop    %esi
  80116f:	5f                   	pop    %edi
  801170:	5d                   	pop    %ebp
  801171:	c3                   	ret    

00801172 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801172:	55                   	push   %ebp
  801173:	89 e5                	mov    %esp,%ebp
  801175:	83 ec 04             	sub    $0x4,%esp
  801178:	8b 45 10             	mov    0x10(%ebp),%eax
  80117b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80117e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	52                   	push   %edx
  80118a:	ff 75 0c             	pushl  0xc(%ebp)
  80118d:	50                   	push   %eax
  80118e:	6a 00                	push   $0x0
  801190:	e8 b2 ff ff ff       	call   801147 <syscall>
  801195:	83 c4 18             	add    $0x18,%esp
}
  801198:	90                   	nop
  801199:	c9                   	leave  
  80119a:	c3                   	ret    

0080119b <sys_cgetc>:

int
sys_cgetc(void)
{
  80119b:	55                   	push   %ebp
  80119c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 01                	push   $0x1
  8011aa:	e8 98 ff ff ff       	call   801147 <syscall>
  8011af:	83 c4 18             	add    $0x18,%esp
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	50                   	push   %eax
  8011c3:	6a 05                	push   $0x5
  8011c5:	e8 7d ff ff ff       	call   801147 <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_getenvid>:

int32 sys_getenvid(void)
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 02                	push   $0x2
  8011de:	e8 64 ff ff ff       	call   801147 <syscall>
  8011e3:	83 c4 18             	add    $0x18,%esp
}
  8011e6:	c9                   	leave  
  8011e7:	c3                   	ret    

008011e8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011e8:	55                   	push   %ebp
  8011e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 03                	push   $0x3
  8011f7:	e8 4b ff ff ff       	call   801147 <syscall>
  8011fc:	83 c4 18             	add    $0x18,%esp
}
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 04                	push   $0x4
  801210:	e8 32 ff ff ff       	call   801147 <syscall>
  801215:	83 c4 18             	add    $0x18,%esp
}
  801218:	c9                   	leave  
  801219:	c3                   	ret    

0080121a <sys_env_exit>:


void sys_env_exit(void)
{
  80121a:	55                   	push   %ebp
  80121b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 06                	push   $0x6
  801229:	e8 19 ff ff ff       	call   801147 <syscall>
  80122e:	83 c4 18             	add    $0x18,%esp
}
  801231:	90                   	nop
  801232:	c9                   	leave  
  801233:	c3                   	ret    

00801234 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801234:	55                   	push   %ebp
  801235:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	52                   	push   %edx
  801244:	50                   	push   %eax
  801245:	6a 07                	push   $0x7
  801247:	e8 fb fe ff ff       	call   801147 <syscall>
  80124c:	83 c4 18             	add    $0x18,%esp
}
  80124f:	c9                   	leave  
  801250:	c3                   	ret    

00801251 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801251:	55                   	push   %ebp
  801252:	89 e5                	mov    %esp,%ebp
  801254:	56                   	push   %esi
  801255:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801256:	8b 75 18             	mov    0x18(%ebp),%esi
  801259:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80125c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80125f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	56                   	push   %esi
  801266:	53                   	push   %ebx
  801267:	51                   	push   %ecx
  801268:	52                   	push   %edx
  801269:	50                   	push   %eax
  80126a:	6a 08                	push   $0x8
  80126c:	e8 d6 fe ff ff       	call   801147 <syscall>
  801271:	83 c4 18             	add    $0x18,%esp
}
  801274:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801277:	5b                   	pop    %ebx
  801278:	5e                   	pop    %esi
  801279:	5d                   	pop    %ebp
  80127a:	c3                   	ret    

0080127b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80127e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	52                   	push   %edx
  80128b:	50                   	push   %eax
  80128c:	6a 09                	push   $0x9
  80128e:	e8 b4 fe ff ff       	call   801147 <syscall>
  801293:	83 c4 18             	add    $0x18,%esp
}
  801296:	c9                   	leave  
  801297:	c3                   	ret    

00801298 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801298:	55                   	push   %ebp
  801299:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	ff 75 0c             	pushl  0xc(%ebp)
  8012a4:	ff 75 08             	pushl  0x8(%ebp)
  8012a7:	6a 0a                	push   $0xa
  8012a9:	e8 99 fe ff ff       	call   801147 <syscall>
  8012ae:	83 c4 18             	add    $0x18,%esp
}
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 0b                	push   $0xb
  8012c2:	e8 80 fe ff ff       	call   801147 <syscall>
  8012c7:	83 c4 18             	add    $0x18,%esp
}
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 0c                	push   $0xc
  8012db:	e8 67 fe ff ff       	call   801147 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 0d                	push   $0xd
  8012f4:	e8 4e fe ff ff       	call   801147 <syscall>
  8012f9:	83 c4 18             	add    $0x18,%esp
}
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	ff 75 0c             	pushl  0xc(%ebp)
  80130a:	ff 75 08             	pushl  0x8(%ebp)
  80130d:	6a 11                	push   $0x11
  80130f:	e8 33 fe ff ff       	call   801147 <syscall>
  801314:	83 c4 18             	add    $0x18,%esp
	return;
  801317:	90                   	nop
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	ff 75 0c             	pushl  0xc(%ebp)
  801326:	ff 75 08             	pushl  0x8(%ebp)
  801329:	6a 12                	push   $0x12
  80132b:	e8 17 fe ff ff       	call   801147 <syscall>
  801330:	83 c4 18             	add    $0x18,%esp
	return ;
  801333:	90                   	nop
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 0e                	push   $0xe
  801345:	e8 fd fd ff ff       	call   801147 <syscall>
  80134a:	83 c4 18             	add    $0x18,%esp
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	ff 75 08             	pushl  0x8(%ebp)
  80135d:	6a 0f                	push   $0xf
  80135f:	e8 e3 fd ff ff       	call   801147 <syscall>
  801364:	83 c4 18             	add    $0x18,%esp
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 10                	push   $0x10
  801378:	e8 ca fd ff ff       	call   801147 <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	90                   	nop
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 14                	push   $0x14
  801392:	e8 b0 fd ff ff       	call   801147 <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	90                   	nop
  80139b:	c9                   	leave  
  80139c:	c3                   	ret    

0080139d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 15                	push   $0x15
  8013ac:	e8 96 fd ff ff       	call   801147 <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	90                   	nop
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
  8013ba:	83 ec 04             	sub    $0x4,%esp
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8013c3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	50                   	push   %eax
  8013d0:	6a 16                	push   $0x16
  8013d2:	e8 70 fd ff ff       	call   801147 <syscall>
  8013d7:	83 c4 18             	add    $0x18,%esp
}
  8013da:	90                   	nop
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 17                	push   $0x17
  8013ec:	e8 56 fd ff ff       	call   801147 <syscall>
  8013f1:	83 c4 18             	add    $0x18,%esp
}
  8013f4:	90                   	nop
  8013f5:	c9                   	leave  
  8013f6:	c3                   	ret    

008013f7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	ff 75 0c             	pushl  0xc(%ebp)
  801406:	50                   	push   %eax
  801407:	6a 18                	push   $0x18
  801409:	e8 39 fd ff ff       	call   801147 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	52                   	push   %edx
  801423:	50                   	push   %eax
  801424:	6a 1b                	push   $0x1b
  801426:	e8 1c fd ff ff       	call   801147 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801433:	8b 55 0c             	mov    0xc(%ebp),%edx
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	52                   	push   %edx
  801440:	50                   	push   %eax
  801441:	6a 19                	push   $0x19
  801443:	e8 ff fc ff ff       	call   801147 <syscall>
  801448:	83 c4 18             	add    $0x18,%esp
}
  80144b:	90                   	nop
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801451:	8b 55 0c             	mov    0xc(%ebp),%edx
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	52                   	push   %edx
  80145e:	50                   	push   %eax
  80145f:	6a 1a                	push   $0x1a
  801461:	e8 e1 fc ff ff       	call   801147 <syscall>
  801466:	83 c4 18             	add    $0x18,%esp
}
  801469:	90                   	nop
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
  80146f:	83 ec 04             	sub    $0x4,%esp
  801472:	8b 45 10             	mov    0x10(%ebp),%eax
  801475:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801478:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80147b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	6a 00                	push   $0x0
  801484:	51                   	push   %ecx
  801485:	52                   	push   %edx
  801486:	ff 75 0c             	pushl  0xc(%ebp)
  801489:	50                   	push   %eax
  80148a:	6a 1c                	push   $0x1c
  80148c:	e8 b6 fc ff ff       	call   801147 <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801499:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	52                   	push   %edx
  8014a6:	50                   	push   %eax
  8014a7:	6a 1d                	push   $0x1d
  8014a9:	e8 99 fc ff ff       	call   801147 <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8014b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	51                   	push   %ecx
  8014c4:	52                   	push   %edx
  8014c5:	50                   	push   %eax
  8014c6:	6a 1e                	push   $0x1e
  8014c8:	e8 7a fc ff ff       	call   801147 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8014d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	52                   	push   %edx
  8014e2:	50                   	push   %eax
  8014e3:	6a 1f                	push   $0x1f
  8014e5:	e8 5d fc ff ff       	call   801147 <syscall>
  8014ea:	83 c4 18             	add    $0x18,%esp
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 20                	push   $0x20
  8014fe:	e8 44 fc ff ff       	call   801147 <syscall>
  801503:	83 c4 18             	add    $0x18,%esp
}
  801506:	c9                   	leave  
  801507:	c3                   	ret    

00801508 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801508:	55                   	push   %ebp
  801509:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	ff 75 10             	pushl  0x10(%ebp)
  801515:	ff 75 0c             	pushl  0xc(%ebp)
  801518:	50                   	push   %eax
  801519:	6a 21                	push   $0x21
  80151b:	e8 27 fc ff ff       	call   801147 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	50                   	push   %eax
  801534:	6a 22                	push   $0x22
  801536:	e8 0c fc ff ff       	call   801147 <syscall>
  80153b:	83 c4 18             	add    $0x18,%esp
}
  80153e:	90                   	nop
  80153f:	c9                   	leave  
  801540:	c3                   	ret    

00801541 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801541:	55                   	push   %ebp
  801542:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	50                   	push   %eax
  801550:	6a 23                	push   $0x23
  801552:	e8 f0 fb ff ff       	call   801147 <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
}
  80155a:	90                   	nop
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
  801560:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801563:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801566:	8d 50 04             	lea    0x4(%eax),%edx
  801569:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	52                   	push   %edx
  801573:	50                   	push   %eax
  801574:	6a 24                	push   $0x24
  801576:	e8 cc fb ff ff       	call   801147 <syscall>
  80157b:	83 c4 18             	add    $0x18,%esp
	return result;
  80157e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801584:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801587:	89 01                	mov    %eax,(%ecx)
  801589:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	c9                   	leave  
  801590:	c2 04 00             	ret    $0x4

00801593 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	ff 75 10             	pushl  0x10(%ebp)
  80159d:	ff 75 0c             	pushl  0xc(%ebp)
  8015a0:	ff 75 08             	pushl  0x8(%ebp)
  8015a3:	6a 13                	push   $0x13
  8015a5:	e8 9d fb ff ff       	call   801147 <syscall>
  8015aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ad:	90                   	nop
}
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 25                	push   $0x25
  8015bf:	e8 83 fb ff ff       	call   801147 <syscall>
  8015c4:	83 c4 18             	add    $0x18,%esp
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
  8015cc:	83 ec 04             	sub    $0x4,%esp
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015d5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	50                   	push   %eax
  8015e2:	6a 26                	push   $0x26
  8015e4:	e8 5e fb ff ff       	call   801147 <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ec:	90                   	nop
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <rsttst>:
void rsttst()
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 28                	push   $0x28
  8015fe:	e8 44 fb ff ff       	call   801147 <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
	return ;
  801606:	90                   	nop
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
  80160c:	83 ec 04             	sub    $0x4,%esp
  80160f:	8b 45 14             	mov    0x14(%ebp),%eax
  801612:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801615:	8b 55 18             	mov    0x18(%ebp),%edx
  801618:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80161c:	52                   	push   %edx
  80161d:	50                   	push   %eax
  80161e:	ff 75 10             	pushl  0x10(%ebp)
  801621:	ff 75 0c             	pushl  0xc(%ebp)
  801624:	ff 75 08             	pushl  0x8(%ebp)
  801627:	6a 27                	push   $0x27
  801629:	e8 19 fb ff ff       	call   801147 <syscall>
  80162e:	83 c4 18             	add    $0x18,%esp
	return ;
  801631:	90                   	nop
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <chktst>:
void chktst(uint32 n)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	ff 75 08             	pushl  0x8(%ebp)
  801642:	6a 29                	push   $0x29
  801644:	e8 fe fa ff ff       	call   801147 <syscall>
  801649:	83 c4 18             	add    $0x18,%esp
	return ;
  80164c:	90                   	nop
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <inctst>:

void inctst()
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 2a                	push   $0x2a
  80165e:	e8 e4 fa ff ff       	call   801147 <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
	return ;
  801666:	90                   	nop
}
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <gettst>:
uint32 gettst()
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 2b                	push   $0x2b
  801678:	e8 ca fa ff ff       	call   801147 <syscall>
  80167d:	83 c4 18             	add    $0x18,%esp
}
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
  801685:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 2c                	push   $0x2c
  801694:	e8 ae fa ff ff       	call   801147 <syscall>
  801699:	83 c4 18             	add    $0x18,%esp
  80169c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80169f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8016a3:	75 07                	jne    8016ac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8016a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016aa:	eb 05                	jmp    8016b1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8016ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
  8016b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 2c                	push   $0x2c
  8016c5:	e8 7d fa ff ff       	call   801147 <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
  8016cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8016d0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8016d4:	75 07                	jne    8016dd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8016d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8016db:	eb 05                	jmp    8016e2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
  8016e7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 2c                	push   $0x2c
  8016f6:	e8 4c fa ff ff       	call   801147 <syscall>
  8016fb:	83 c4 18             	add    $0x18,%esp
  8016fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801701:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801705:	75 07                	jne    80170e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801707:	b8 01 00 00 00       	mov    $0x1,%eax
  80170c:	eb 05                	jmp    801713 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80170e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
  801718:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 2c                	push   $0x2c
  801727:	e8 1b fa ff ff       	call   801147 <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
  80172f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801732:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801736:	75 07                	jne    80173f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801738:	b8 01 00 00 00       	mov    $0x1,%eax
  80173d:	eb 05                	jmp    801744 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80173f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	ff 75 08             	pushl  0x8(%ebp)
  801754:	6a 2d                	push   $0x2d
  801756:	e8 ec f9 ff ff       	call   801147 <syscall>
  80175b:	83 c4 18             	add    $0x18,%esp
	return ;
  80175e:	90                   	nop
}
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
  801764:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801767:	8d 45 10             	lea    0x10(%ebp),%eax
  80176a:	83 c0 04             	add    $0x4,%eax
  80176d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801770:	a1 14 30 80 00       	mov    0x803014,%eax
  801775:	85 c0                	test   %eax,%eax
  801777:	74 16                	je     80178f <_panic+0x2e>
		cprintf("%s: ", argv0);
  801779:	a1 14 30 80 00       	mov    0x803014,%eax
  80177e:	83 ec 08             	sub    $0x8,%esp
  801781:	50                   	push   %eax
  801782:	68 c8 20 80 00       	push   $0x8020c8
  801787:	e8 8f eb ff ff       	call   80031b <cprintf>
  80178c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80178f:	a1 00 30 80 00       	mov    0x803000,%eax
  801794:	ff 75 0c             	pushl  0xc(%ebp)
  801797:	ff 75 08             	pushl  0x8(%ebp)
  80179a:	50                   	push   %eax
  80179b:	68 cd 20 80 00       	push   $0x8020cd
  8017a0:	e8 76 eb ff ff       	call   80031b <cprintf>
  8017a5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8017a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ab:	83 ec 08             	sub    $0x8,%esp
  8017ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8017b1:	50                   	push   %eax
  8017b2:	e8 f9 ea ff ff       	call   8002b0 <vcprintf>
  8017b7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8017ba:	83 ec 08             	sub    $0x8,%esp
  8017bd:	6a 00                	push   $0x0
  8017bf:	68 e9 20 80 00       	push   $0x8020e9
  8017c4:	e8 e7 ea ff ff       	call   8002b0 <vcprintf>
  8017c9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8017cc:	e8 68 ea ff ff       	call   800239 <exit>

	// should not return here
	while (1) ;
  8017d1:	eb fe                	jmp    8017d1 <_panic+0x70>

008017d3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8017d3:	55                   	push   %ebp
  8017d4:	89 e5                	mov    %esp,%ebp
  8017d6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8017d9:	a1 04 30 80 00       	mov    0x803004,%eax
  8017de:	8b 50 74             	mov    0x74(%eax),%edx
  8017e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e4:	39 c2                	cmp    %eax,%edx
  8017e6:	74 14                	je     8017fc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8017e8:	83 ec 04             	sub    $0x4,%esp
  8017eb:	68 ec 20 80 00       	push   $0x8020ec
  8017f0:	6a 26                	push   $0x26
  8017f2:	68 38 21 80 00       	push   $0x802138
  8017f7:	e8 65 ff ff ff       	call   801761 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8017fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801803:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80180a:	e9 c2 00 00 00       	jmp    8018d1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80180f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801812:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801819:	8b 45 08             	mov    0x8(%ebp),%eax
  80181c:	01 d0                	add    %edx,%eax
  80181e:	8b 00                	mov    (%eax),%eax
  801820:	85 c0                	test   %eax,%eax
  801822:	75 08                	jne    80182c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801824:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801827:	e9 a2 00 00 00       	jmp    8018ce <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80182c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801833:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80183a:	eb 69                	jmp    8018a5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80183c:	a1 04 30 80 00       	mov    0x803004,%eax
  801841:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801847:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80184a:	89 d0                	mov    %edx,%eax
  80184c:	01 c0                	add    %eax,%eax
  80184e:	01 d0                	add    %edx,%eax
  801850:	c1 e0 02             	shl    $0x2,%eax
  801853:	01 c8                	add    %ecx,%eax
  801855:	8a 40 04             	mov    0x4(%eax),%al
  801858:	84 c0                	test   %al,%al
  80185a:	75 46                	jne    8018a2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80185c:	a1 04 30 80 00       	mov    0x803004,%eax
  801861:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801867:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80186a:	89 d0                	mov    %edx,%eax
  80186c:	01 c0                	add    %eax,%eax
  80186e:	01 d0                	add    %edx,%eax
  801870:	c1 e0 02             	shl    $0x2,%eax
  801873:	01 c8                	add    %ecx,%eax
  801875:	8b 00                	mov    (%eax),%eax
  801877:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80187a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80187d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801882:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801884:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801887:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	01 c8                	add    %ecx,%eax
  801893:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801895:	39 c2                	cmp    %eax,%edx
  801897:	75 09                	jne    8018a2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801899:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8018a0:	eb 12                	jmp    8018b4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018a2:	ff 45 e8             	incl   -0x18(%ebp)
  8018a5:	a1 04 30 80 00       	mov    0x803004,%eax
  8018aa:	8b 50 74             	mov    0x74(%eax),%edx
  8018ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018b0:	39 c2                	cmp    %eax,%edx
  8018b2:	77 88                	ja     80183c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8018b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8018b8:	75 14                	jne    8018ce <CheckWSWithoutLastIndex+0xfb>
			panic(
  8018ba:	83 ec 04             	sub    $0x4,%esp
  8018bd:	68 44 21 80 00       	push   $0x802144
  8018c2:	6a 3a                	push   $0x3a
  8018c4:	68 38 21 80 00       	push   $0x802138
  8018c9:	e8 93 fe ff ff       	call   801761 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8018ce:	ff 45 f0             	incl   -0x10(%ebp)
  8018d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8018d7:	0f 8c 32 ff ff ff    	jl     80180f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8018dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018e4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8018eb:	eb 26                	jmp    801913 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8018ed:	a1 04 30 80 00       	mov    0x803004,%eax
  8018f2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8018f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8018fb:	89 d0                	mov    %edx,%eax
  8018fd:	01 c0                	add    %eax,%eax
  8018ff:	01 d0                	add    %edx,%eax
  801901:	c1 e0 02             	shl    $0x2,%eax
  801904:	01 c8                	add    %ecx,%eax
  801906:	8a 40 04             	mov    0x4(%eax),%al
  801909:	3c 01                	cmp    $0x1,%al
  80190b:	75 03                	jne    801910 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80190d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801910:	ff 45 e0             	incl   -0x20(%ebp)
  801913:	a1 04 30 80 00       	mov    0x803004,%eax
  801918:	8b 50 74             	mov    0x74(%eax),%edx
  80191b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80191e:	39 c2                	cmp    %eax,%edx
  801920:	77 cb                	ja     8018ed <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801922:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801925:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801928:	74 14                	je     80193e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80192a:	83 ec 04             	sub    $0x4,%esp
  80192d:	68 98 21 80 00       	push   $0x802198
  801932:	6a 44                	push   $0x44
  801934:	68 38 21 80 00       	push   $0x802138
  801939:	e8 23 fe ff ff       	call   801761 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80193e:	90                   	nop
  80193f:	c9                   	leave  
  801940:	c3                   	ret    
  801941:	66 90                	xchg   %ax,%ax
  801943:	90                   	nop

00801944 <__udivdi3>:
  801944:	55                   	push   %ebp
  801945:	57                   	push   %edi
  801946:	56                   	push   %esi
  801947:	53                   	push   %ebx
  801948:	83 ec 1c             	sub    $0x1c,%esp
  80194b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80194f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801953:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801957:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80195b:	89 ca                	mov    %ecx,%edx
  80195d:	89 f8                	mov    %edi,%eax
  80195f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801963:	85 f6                	test   %esi,%esi
  801965:	75 2d                	jne    801994 <__udivdi3+0x50>
  801967:	39 cf                	cmp    %ecx,%edi
  801969:	77 65                	ja     8019d0 <__udivdi3+0x8c>
  80196b:	89 fd                	mov    %edi,%ebp
  80196d:	85 ff                	test   %edi,%edi
  80196f:	75 0b                	jne    80197c <__udivdi3+0x38>
  801971:	b8 01 00 00 00       	mov    $0x1,%eax
  801976:	31 d2                	xor    %edx,%edx
  801978:	f7 f7                	div    %edi
  80197a:	89 c5                	mov    %eax,%ebp
  80197c:	31 d2                	xor    %edx,%edx
  80197e:	89 c8                	mov    %ecx,%eax
  801980:	f7 f5                	div    %ebp
  801982:	89 c1                	mov    %eax,%ecx
  801984:	89 d8                	mov    %ebx,%eax
  801986:	f7 f5                	div    %ebp
  801988:	89 cf                	mov    %ecx,%edi
  80198a:	89 fa                	mov    %edi,%edx
  80198c:	83 c4 1c             	add    $0x1c,%esp
  80198f:	5b                   	pop    %ebx
  801990:	5e                   	pop    %esi
  801991:	5f                   	pop    %edi
  801992:	5d                   	pop    %ebp
  801993:	c3                   	ret    
  801994:	39 ce                	cmp    %ecx,%esi
  801996:	77 28                	ja     8019c0 <__udivdi3+0x7c>
  801998:	0f bd fe             	bsr    %esi,%edi
  80199b:	83 f7 1f             	xor    $0x1f,%edi
  80199e:	75 40                	jne    8019e0 <__udivdi3+0x9c>
  8019a0:	39 ce                	cmp    %ecx,%esi
  8019a2:	72 0a                	jb     8019ae <__udivdi3+0x6a>
  8019a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019a8:	0f 87 9e 00 00 00    	ja     801a4c <__udivdi3+0x108>
  8019ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b3:	89 fa                	mov    %edi,%edx
  8019b5:	83 c4 1c             	add    $0x1c,%esp
  8019b8:	5b                   	pop    %ebx
  8019b9:	5e                   	pop    %esi
  8019ba:	5f                   	pop    %edi
  8019bb:	5d                   	pop    %ebp
  8019bc:	c3                   	ret    
  8019bd:	8d 76 00             	lea    0x0(%esi),%esi
  8019c0:	31 ff                	xor    %edi,%edi
  8019c2:	31 c0                	xor    %eax,%eax
  8019c4:	89 fa                	mov    %edi,%edx
  8019c6:	83 c4 1c             	add    $0x1c,%esp
  8019c9:	5b                   	pop    %ebx
  8019ca:	5e                   	pop    %esi
  8019cb:	5f                   	pop    %edi
  8019cc:	5d                   	pop    %ebp
  8019cd:	c3                   	ret    
  8019ce:	66 90                	xchg   %ax,%ax
  8019d0:	89 d8                	mov    %ebx,%eax
  8019d2:	f7 f7                	div    %edi
  8019d4:	31 ff                	xor    %edi,%edi
  8019d6:	89 fa                	mov    %edi,%edx
  8019d8:	83 c4 1c             	add    $0x1c,%esp
  8019db:	5b                   	pop    %ebx
  8019dc:	5e                   	pop    %esi
  8019dd:	5f                   	pop    %edi
  8019de:	5d                   	pop    %ebp
  8019df:	c3                   	ret    
  8019e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019e5:	89 eb                	mov    %ebp,%ebx
  8019e7:	29 fb                	sub    %edi,%ebx
  8019e9:	89 f9                	mov    %edi,%ecx
  8019eb:	d3 e6                	shl    %cl,%esi
  8019ed:	89 c5                	mov    %eax,%ebp
  8019ef:	88 d9                	mov    %bl,%cl
  8019f1:	d3 ed                	shr    %cl,%ebp
  8019f3:	89 e9                	mov    %ebp,%ecx
  8019f5:	09 f1                	or     %esi,%ecx
  8019f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019fb:	89 f9                	mov    %edi,%ecx
  8019fd:	d3 e0                	shl    %cl,%eax
  8019ff:	89 c5                	mov    %eax,%ebp
  801a01:	89 d6                	mov    %edx,%esi
  801a03:	88 d9                	mov    %bl,%cl
  801a05:	d3 ee                	shr    %cl,%esi
  801a07:	89 f9                	mov    %edi,%ecx
  801a09:	d3 e2                	shl    %cl,%edx
  801a0b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a0f:	88 d9                	mov    %bl,%cl
  801a11:	d3 e8                	shr    %cl,%eax
  801a13:	09 c2                	or     %eax,%edx
  801a15:	89 d0                	mov    %edx,%eax
  801a17:	89 f2                	mov    %esi,%edx
  801a19:	f7 74 24 0c          	divl   0xc(%esp)
  801a1d:	89 d6                	mov    %edx,%esi
  801a1f:	89 c3                	mov    %eax,%ebx
  801a21:	f7 e5                	mul    %ebp
  801a23:	39 d6                	cmp    %edx,%esi
  801a25:	72 19                	jb     801a40 <__udivdi3+0xfc>
  801a27:	74 0b                	je     801a34 <__udivdi3+0xf0>
  801a29:	89 d8                	mov    %ebx,%eax
  801a2b:	31 ff                	xor    %edi,%edi
  801a2d:	e9 58 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a32:	66 90                	xchg   %ax,%ax
  801a34:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a38:	89 f9                	mov    %edi,%ecx
  801a3a:	d3 e2                	shl    %cl,%edx
  801a3c:	39 c2                	cmp    %eax,%edx
  801a3e:	73 e9                	jae    801a29 <__udivdi3+0xe5>
  801a40:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a43:	31 ff                	xor    %edi,%edi
  801a45:	e9 40 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a4a:	66 90                	xchg   %ax,%ax
  801a4c:	31 c0                	xor    %eax,%eax
  801a4e:	e9 37 ff ff ff       	jmp    80198a <__udivdi3+0x46>
  801a53:	90                   	nop

00801a54 <__umoddi3>:
  801a54:	55                   	push   %ebp
  801a55:	57                   	push   %edi
  801a56:	56                   	push   %esi
  801a57:	53                   	push   %ebx
  801a58:	83 ec 1c             	sub    $0x1c,%esp
  801a5b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a5f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a63:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a67:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a6b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a6f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a73:	89 f3                	mov    %esi,%ebx
  801a75:	89 fa                	mov    %edi,%edx
  801a77:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a7b:	89 34 24             	mov    %esi,(%esp)
  801a7e:	85 c0                	test   %eax,%eax
  801a80:	75 1a                	jne    801a9c <__umoddi3+0x48>
  801a82:	39 f7                	cmp    %esi,%edi
  801a84:	0f 86 a2 00 00 00    	jbe    801b2c <__umoddi3+0xd8>
  801a8a:	89 c8                	mov    %ecx,%eax
  801a8c:	89 f2                	mov    %esi,%edx
  801a8e:	f7 f7                	div    %edi
  801a90:	89 d0                	mov    %edx,%eax
  801a92:	31 d2                	xor    %edx,%edx
  801a94:	83 c4 1c             	add    $0x1c,%esp
  801a97:	5b                   	pop    %ebx
  801a98:	5e                   	pop    %esi
  801a99:	5f                   	pop    %edi
  801a9a:	5d                   	pop    %ebp
  801a9b:	c3                   	ret    
  801a9c:	39 f0                	cmp    %esi,%eax
  801a9e:	0f 87 ac 00 00 00    	ja     801b50 <__umoddi3+0xfc>
  801aa4:	0f bd e8             	bsr    %eax,%ebp
  801aa7:	83 f5 1f             	xor    $0x1f,%ebp
  801aaa:	0f 84 ac 00 00 00    	je     801b5c <__umoddi3+0x108>
  801ab0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ab5:	29 ef                	sub    %ebp,%edi
  801ab7:	89 fe                	mov    %edi,%esi
  801ab9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801abd:	89 e9                	mov    %ebp,%ecx
  801abf:	d3 e0                	shl    %cl,%eax
  801ac1:	89 d7                	mov    %edx,%edi
  801ac3:	89 f1                	mov    %esi,%ecx
  801ac5:	d3 ef                	shr    %cl,%edi
  801ac7:	09 c7                	or     %eax,%edi
  801ac9:	89 e9                	mov    %ebp,%ecx
  801acb:	d3 e2                	shl    %cl,%edx
  801acd:	89 14 24             	mov    %edx,(%esp)
  801ad0:	89 d8                	mov    %ebx,%eax
  801ad2:	d3 e0                	shl    %cl,%eax
  801ad4:	89 c2                	mov    %eax,%edx
  801ad6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ada:	d3 e0                	shl    %cl,%eax
  801adc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ae0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ae4:	89 f1                	mov    %esi,%ecx
  801ae6:	d3 e8                	shr    %cl,%eax
  801ae8:	09 d0                	or     %edx,%eax
  801aea:	d3 eb                	shr    %cl,%ebx
  801aec:	89 da                	mov    %ebx,%edx
  801aee:	f7 f7                	div    %edi
  801af0:	89 d3                	mov    %edx,%ebx
  801af2:	f7 24 24             	mull   (%esp)
  801af5:	89 c6                	mov    %eax,%esi
  801af7:	89 d1                	mov    %edx,%ecx
  801af9:	39 d3                	cmp    %edx,%ebx
  801afb:	0f 82 87 00 00 00    	jb     801b88 <__umoddi3+0x134>
  801b01:	0f 84 91 00 00 00    	je     801b98 <__umoddi3+0x144>
  801b07:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b0b:	29 f2                	sub    %esi,%edx
  801b0d:	19 cb                	sbb    %ecx,%ebx
  801b0f:	89 d8                	mov    %ebx,%eax
  801b11:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b15:	d3 e0                	shl    %cl,%eax
  801b17:	89 e9                	mov    %ebp,%ecx
  801b19:	d3 ea                	shr    %cl,%edx
  801b1b:	09 d0                	or     %edx,%eax
  801b1d:	89 e9                	mov    %ebp,%ecx
  801b1f:	d3 eb                	shr    %cl,%ebx
  801b21:	89 da                	mov    %ebx,%edx
  801b23:	83 c4 1c             	add    $0x1c,%esp
  801b26:	5b                   	pop    %ebx
  801b27:	5e                   	pop    %esi
  801b28:	5f                   	pop    %edi
  801b29:	5d                   	pop    %ebp
  801b2a:	c3                   	ret    
  801b2b:	90                   	nop
  801b2c:	89 fd                	mov    %edi,%ebp
  801b2e:	85 ff                	test   %edi,%edi
  801b30:	75 0b                	jne    801b3d <__umoddi3+0xe9>
  801b32:	b8 01 00 00 00       	mov    $0x1,%eax
  801b37:	31 d2                	xor    %edx,%edx
  801b39:	f7 f7                	div    %edi
  801b3b:	89 c5                	mov    %eax,%ebp
  801b3d:	89 f0                	mov    %esi,%eax
  801b3f:	31 d2                	xor    %edx,%edx
  801b41:	f7 f5                	div    %ebp
  801b43:	89 c8                	mov    %ecx,%eax
  801b45:	f7 f5                	div    %ebp
  801b47:	89 d0                	mov    %edx,%eax
  801b49:	e9 44 ff ff ff       	jmp    801a92 <__umoddi3+0x3e>
  801b4e:	66 90                	xchg   %ax,%ax
  801b50:	89 c8                	mov    %ecx,%eax
  801b52:	89 f2                	mov    %esi,%edx
  801b54:	83 c4 1c             	add    $0x1c,%esp
  801b57:	5b                   	pop    %ebx
  801b58:	5e                   	pop    %esi
  801b59:	5f                   	pop    %edi
  801b5a:	5d                   	pop    %ebp
  801b5b:	c3                   	ret    
  801b5c:	3b 04 24             	cmp    (%esp),%eax
  801b5f:	72 06                	jb     801b67 <__umoddi3+0x113>
  801b61:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b65:	77 0f                	ja     801b76 <__umoddi3+0x122>
  801b67:	89 f2                	mov    %esi,%edx
  801b69:	29 f9                	sub    %edi,%ecx
  801b6b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b6f:	89 14 24             	mov    %edx,(%esp)
  801b72:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b76:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b7a:	8b 14 24             	mov    (%esp),%edx
  801b7d:	83 c4 1c             	add    $0x1c,%esp
  801b80:	5b                   	pop    %ebx
  801b81:	5e                   	pop    %esi
  801b82:	5f                   	pop    %edi
  801b83:	5d                   	pop    %ebp
  801b84:	c3                   	ret    
  801b85:	8d 76 00             	lea    0x0(%esi),%esi
  801b88:	2b 04 24             	sub    (%esp),%eax
  801b8b:	19 fa                	sbb    %edi,%edx
  801b8d:	89 d1                	mov    %edx,%ecx
  801b8f:	89 c6                	mov    %eax,%esi
  801b91:	e9 71 ff ff ff       	jmp    801b07 <__umoddi3+0xb3>
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b9c:	72 ea                	jb     801b88 <__umoddi3+0x134>
  801b9e:	89 d9                	mov    %ebx,%ecx
  801ba0:	e9 62 ff ff ff       	jmp    801b07 <__umoddi3+0xb3>
