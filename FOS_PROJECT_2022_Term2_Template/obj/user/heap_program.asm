
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 f3 01 00 00       	call   800229 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 f0 14 00 00       	call   80155b <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 df 14 00 00       	call   80155b <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 1a 18 00 00       	call   8018a1 <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000a8:	c1 e0 03             	shl    $0x3,%eax
  8000ab:	89 c2                	mov    %eax,%edx
  8000ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 02             	shl    $0x2,%eax
  8000c1:	89 c2                	mov    %eax,%edx
  8000c3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c6 00 ff             	movb   $0xff,(%eax)

		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;

		free(x);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 cc             	pushl  -0x34(%ebp)
  8000d1:	e8 13 15 00 00       	call   8015e9 <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 05 15 00 00       	call   8015e9 <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 32 17 00 00       	call   80181e <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 61 14 00 00       	call   80155b <malloc>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 cc             	mov    %eax,-0x34(%ebp)

		x[1]=-2;
  800100:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800103:	40                   	inc    %eax
  800104:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800107:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80010a:	89 d0                	mov    %edx,%eax
  80010c:	c1 e0 02             	shl    $0x2,%eax
  80010f:	01 d0                	add    %edx,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80011b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011e:	c1 e0 03             	shl    $0x3,%eax
  800121:	89 c2                	mov    %eax,%edx
  800123:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	01 c0                	add    %eax,%eax
  800132:	01 d0                	add    %edx,%eax
  800134:	c1 e0 02             	shl    $0x2,%eax
  800137:	89 c2                	mov    %eax,%edx
  800139:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 fe             	movb   $0xfe,(%eax)

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};
  800141:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800144:	bb 00 20 80 00       	mov    $0x802000,%ebx
  800149:	ba 08 00 00 00       	mov    $0x8,%edx
  80014e:	89 c7                	mov    %eax,%edi
  800150:	89 de                	mov    %ebx,%esi
  800152:	89 d1                	mov    %edx,%ecx
  800154:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800156:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  80015d:	eb 79                	jmp    8001d8 <_main+0x1a0>
		{
			int found = 0 ;
  80015f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80016d:	eb 3d                	jmp    8001ac <_main+0x174>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  80016f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800172:	8b 4c 85 9c          	mov    -0x64(%ebp,%eax,4),%ecx
  800176:	a1 20 30 80 00       	mov    0x803020,%eax
  80017b:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  800181:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800184:	89 d0                	mov    %edx,%eax
  800186:	01 c0                	add    %eax,%eax
  800188:	01 d0                	add    %edx,%eax
  80018a:	c1 e0 02             	shl    $0x2,%eax
  80018d:	01 d8                	add    %ebx,%eax
  80018f:	8b 00                	mov    (%eax),%eax
  800191:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800194:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800197:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019c:	39 c1                	cmp    %eax,%ecx
  80019e:	75 09                	jne    8001a9 <_main+0x171>
				{
					found = 1 ;
  8001a0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001a7:	eb 12                	jmp    8001bb <_main+0x183>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001a9:	ff 45 e0             	incl   -0x20(%ebp)
  8001ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b1:	8b 50 74             	mov    0x74(%eax),%edx
  8001b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b7:	39 c2                	cmp    %eax,%edx
  8001b9:	77 b4                	ja     80016f <_main+0x137>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001bb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001bf:	75 14                	jne    8001d5 <_main+0x19d>
				panic("PAGE Placement algorithm failed after applying freeHeap");
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 40 1f 80 00       	push   $0x801f40
  8001c9:	6a 41                	push   $0x41
  8001cb:	68 78 1f 80 00       	push   $0x801f78
  8001d0:	e8 63 01 00 00       	call   800338 <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001d5:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 50 74             	mov    0x74(%eax),%edx
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	39 c2                	cmp    %eax,%edx
  8001e5:	0f 87 74 ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001eb:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001ee:	e8 2b 16 00 00       	call   80181e <sys_calculate_free_frames>
  8001f3:	29 c3                	sub    %eax,%ebx
  8001f5:	89 d8                	mov    %ebx,%eax
  8001f7:	83 f8 08             	cmp    $0x8,%eax
  8001fa:	74 14                	je     800210 <_main+0x1d8>
  8001fc:	83 ec 04             	sub    $0x4,%esp
  8001ff:	68 8c 1f 80 00       	push   $0x801f8c
  800204:	6a 45                	push   $0x45
  800206:	68 78 1f 80 00       	push   $0x801f78
  80020b:	e8 28 01 00 00       	call   800338 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 b4 1f 80 00       	push   $0x801fb4
  800218:	e8 cf 03 00 00       	call   8005ec <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp


	return;
  800220:	90                   	nop
}
  800221:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800224:	5b                   	pop    %ebx
  800225:	5e                   	pop    %esi
  800226:	5f                   	pop    %edi
  800227:	5d                   	pop    %ebp
  800228:	c3                   	ret    

00800229 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800229:	55                   	push   %ebp
  80022a:	89 e5                	mov    %esp,%ebp
  80022c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80022f:	e8 1f 15 00 00       	call   801753 <sys_getenvindex>
  800234:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800237:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80023a:	89 d0                	mov    %edx,%eax
  80023c:	c1 e0 02             	shl    $0x2,%eax
  80023f:	01 d0                	add    %edx,%eax
  800241:	01 c0                	add    %eax,%eax
  800243:	01 d0                	add    %edx,%eax
  800245:	01 c0                	add    %eax,%eax
  800247:	01 d0                	add    %edx,%eax
  800249:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800250:	01 d0                	add    %edx,%eax
  800252:	c1 e0 02             	shl    $0x2,%eax
  800255:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80025a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80025f:	a1 20 30 80 00       	mov    0x803020,%eax
  800264:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80026a:	84 c0                	test   %al,%al
  80026c:	74 0f                	je     80027d <libmain+0x54>
		binaryname = myEnv->prog_name;
  80026e:	a1 20 30 80 00       	mov    0x803020,%eax
  800273:	05 f4 02 00 00       	add    $0x2f4,%eax
  800278:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80027d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800281:	7e 0a                	jle    80028d <libmain+0x64>
		binaryname = argv[0];
  800283:	8b 45 0c             	mov    0xc(%ebp),%eax
  800286:	8b 00                	mov    (%eax),%eax
  800288:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80028d:	83 ec 08             	sub    $0x8,%esp
  800290:	ff 75 0c             	pushl  0xc(%ebp)
  800293:	ff 75 08             	pushl  0x8(%ebp)
  800296:	e8 9d fd ff ff       	call   800038 <_main>
  80029b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80029e:	e8 4b 16 00 00       	call   8018ee <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002a3:	83 ec 0c             	sub    $0xc,%esp
  8002a6:	68 38 20 80 00       	push   $0x802038
  8002ab:	e8 3c 03 00 00       	call   8005ec <cprintf>
  8002b0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8002be:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8002c9:	83 ec 04             	sub    $0x4,%esp
  8002cc:	52                   	push   %edx
  8002cd:	50                   	push   %eax
  8002ce:	68 60 20 80 00       	push   $0x802060
  8002d3:	e8 14 03 00 00       	call   8005ec <cprintf>
  8002d8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002db:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e0:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8002e6:	83 ec 08             	sub    $0x8,%esp
  8002e9:	50                   	push   %eax
  8002ea:	68 85 20 80 00       	push   $0x802085
  8002ef:	e8 f8 02 00 00       	call   8005ec <cprintf>
  8002f4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002f7:	83 ec 0c             	sub    $0xc,%esp
  8002fa:	68 38 20 80 00       	push   $0x802038
  8002ff:	e8 e8 02 00 00       	call   8005ec <cprintf>
  800304:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800307:	e8 fc 15 00 00       	call   801908 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80030c:	e8 19 00 00 00       	call   80032a <exit>
}
  800311:	90                   	nop
  800312:	c9                   	leave  
  800313:	c3                   	ret    

00800314 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800314:	55                   	push   %ebp
  800315:	89 e5                	mov    %esp,%ebp
  800317:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80031a:	83 ec 0c             	sub    $0xc,%esp
  80031d:	6a 00                	push   $0x0
  80031f:	e8 fb 13 00 00       	call   80171f <sys_env_destroy>
  800324:	83 c4 10             	add    $0x10,%esp
}
  800327:	90                   	nop
  800328:	c9                   	leave  
  800329:	c3                   	ret    

0080032a <exit>:

void
exit(void)
{
  80032a:	55                   	push   %ebp
  80032b:	89 e5                	mov    %esp,%ebp
  80032d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800330:	e8 50 14 00 00       	call   801785 <sys_env_exit>
}
  800335:	90                   	nop
  800336:	c9                   	leave  
  800337:	c3                   	ret    

00800338 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800338:	55                   	push   %ebp
  800339:	89 e5                	mov    %esp,%ebp
  80033b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80033e:	8d 45 10             	lea    0x10(%ebp),%eax
  800341:	83 c0 04             	add    $0x4,%eax
  800344:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800347:	a1 48 30 88 00       	mov    0x883048,%eax
  80034c:	85 c0                	test   %eax,%eax
  80034e:	74 16                	je     800366 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800350:	a1 48 30 88 00       	mov    0x883048,%eax
  800355:	83 ec 08             	sub    $0x8,%esp
  800358:	50                   	push   %eax
  800359:	68 9c 20 80 00       	push   $0x80209c
  80035e:	e8 89 02 00 00       	call   8005ec <cprintf>
  800363:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800366:	a1 00 30 80 00       	mov    0x803000,%eax
  80036b:	ff 75 0c             	pushl  0xc(%ebp)
  80036e:	ff 75 08             	pushl  0x8(%ebp)
  800371:	50                   	push   %eax
  800372:	68 a1 20 80 00       	push   $0x8020a1
  800377:	e8 70 02 00 00       	call   8005ec <cprintf>
  80037c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80037f:	8b 45 10             	mov    0x10(%ebp),%eax
  800382:	83 ec 08             	sub    $0x8,%esp
  800385:	ff 75 f4             	pushl  -0xc(%ebp)
  800388:	50                   	push   %eax
  800389:	e8 f3 01 00 00       	call   800581 <vcprintf>
  80038e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800391:	83 ec 08             	sub    $0x8,%esp
  800394:	6a 00                	push   $0x0
  800396:	68 bd 20 80 00       	push   $0x8020bd
  80039b:	e8 e1 01 00 00       	call   800581 <vcprintf>
  8003a0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003a3:	e8 82 ff ff ff       	call   80032a <exit>

	// should not return here
	while (1) ;
  8003a8:	eb fe                	jmp    8003a8 <_panic+0x70>

008003aa <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003aa:	55                   	push   %ebp
  8003ab:	89 e5                	mov    %esp,%ebp
  8003ad:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b5:	8b 50 74             	mov    0x74(%eax),%edx
  8003b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003bb:	39 c2                	cmp    %eax,%edx
  8003bd:	74 14                	je     8003d3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003bf:	83 ec 04             	sub    $0x4,%esp
  8003c2:	68 c0 20 80 00       	push   $0x8020c0
  8003c7:	6a 26                	push   $0x26
  8003c9:	68 0c 21 80 00       	push   $0x80210c
  8003ce:	e8 65 ff ff ff       	call   800338 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003e1:	e9 c2 00 00 00       	jmp    8004a8 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8003e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	01 d0                	add    %edx,%eax
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	85 c0                	test   %eax,%eax
  8003f9:	75 08                	jne    800403 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003fb:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003fe:	e9 a2 00 00 00       	jmp    8004a5 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800403:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80040a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800411:	eb 69                	jmp    80047c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800413:	a1 20 30 80 00       	mov    0x803020,%eax
  800418:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80041e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800421:	89 d0                	mov    %edx,%eax
  800423:	01 c0                	add    %eax,%eax
  800425:	01 d0                	add    %edx,%eax
  800427:	c1 e0 02             	shl    $0x2,%eax
  80042a:	01 c8                	add    %ecx,%eax
  80042c:	8a 40 04             	mov    0x4(%eax),%al
  80042f:	84 c0                	test   %al,%al
  800431:	75 46                	jne    800479 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800433:	a1 20 30 80 00       	mov    0x803020,%eax
  800438:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80043e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800441:	89 d0                	mov    %edx,%eax
  800443:	01 c0                	add    %eax,%eax
  800445:	01 d0                	add    %edx,%eax
  800447:	c1 e0 02             	shl    $0x2,%eax
  80044a:	01 c8                	add    %ecx,%eax
  80044c:	8b 00                	mov    (%eax),%eax
  80044e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800451:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800454:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800459:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80045b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80045e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800465:	8b 45 08             	mov    0x8(%ebp),%eax
  800468:	01 c8                	add    %ecx,%eax
  80046a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80046c:	39 c2                	cmp    %eax,%edx
  80046e:	75 09                	jne    800479 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800470:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800477:	eb 12                	jmp    80048b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800479:	ff 45 e8             	incl   -0x18(%ebp)
  80047c:	a1 20 30 80 00       	mov    0x803020,%eax
  800481:	8b 50 74             	mov    0x74(%eax),%edx
  800484:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800487:	39 c2                	cmp    %eax,%edx
  800489:	77 88                	ja     800413 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80048b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80048f:	75 14                	jne    8004a5 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800491:	83 ec 04             	sub    $0x4,%esp
  800494:	68 18 21 80 00       	push   $0x802118
  800499:	6a 3a                	push   $0x3a
  80049b:	68 0c 21 80 00       	push   $0x80210c
  8004a0:	e8 93 fe ff ff       	call   800338 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004a5:	ff 45 f0             	incl   -0x10(%ebp)
  8004a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ae:	0f 8c 32 ff ff ff    	jl     8003e6 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004c2:	eb 26                	jmp    8004ea <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8004cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004d2:	89 d0                	mov    %edx,%eax
  8004d4:	01 c0                	add    %eax,%eax
  8004d6:	01 d0                	add    %edx,%eax
  8004d8:	c1 e0 02             	shl    $0x2,%eax
  8004db:	01 c8                	add    %ecx,%eax
  8004dd:	8a 40 04             	mov    0x4(%eax),%al
  8004e0:	3c 01                	cmp    $0x1,%al
  8004e2:	75 03                	jne    8004e7 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8004e4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004e7:	ff 45 e0             	incl   -0x20(%ebp)
  8004ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ef:	8b 50 74             	mov    0x74(%eax),%edx
  8004f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004f5:	39 c2                	cmp    %eax,%edx
  8004f7:	77 cb                	ja     8004c4 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004fc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004ff:	74 14                	je     800515 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800501:	83 ec 04             	sub    $0x4,%esp
  800504:	68 6c 21 80 00       	push   $0x80216c
  800509:	6a 44                	push   $0x44
  80050b:	68 0c 21 80 00       	push   $0x80210c
  800510:	e8 23 fe ff ff       	call   800338 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800515:	90                   	nop
  800516:	c9                   	leave  
  800517:	c3                   	ret    

00800518 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800518:	55                   	push   %ebp
  800519:	89 e5                	mov    %esp,%ebp
  80051b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80051e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800521:	8b 00                	mov    (%eax),%eax
  800523:	8d 48 01             	lea    0x1(%eax),%ecx
  800526:	8b 55 0c             	mov    0xc(%ebp),%edx
  800529:	89 0a                	mov    %ecx,(%edx)
  80052b:	8b 55 08             	mov    0x8(%ebp),%edx
  80052e:	88 d1                	mov    %dl,%cl
  800530:	8b 55 0c             	mov    0xc(%ebp),%edx
  800533:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053a:	8b 00                	mov    (%eax),%eax
  80053c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800541:	75 2c                	jne    80056f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800543:	a0 24 30 80 00       	mov    0x803024,%al
  800548:	0f b6 c0             	movzbl %al,%eax
  80054b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80054e:	8b 12                	mov    (%edx),%edx
  800550:	89 d1                	mov    %edx,%ecx
  800552:	8b 55 0c             	mov    0xc(%ebp),%edx
  800555:	83 c2 08             	add    $0x8,%edx
  800558:	83 ec 04             	sub    $0x4,%esp
  80055b:	50                   	push   %eax
  80055c:	51                   	push   %ecx
  80055d:	52                   	push   %edx
  80055e:	e8 7a 11 00 00       	call   8016dd <sys_cputs>
  800563:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800566:	8b 45 0c             	mov    0xc(%ebp),%eax
  800569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80056f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800572:	8b 40 04             	mov    0x4(%eax),%eax
  800575:	8d 50 01             	lea    0x1(%eax),%edx
  800578:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80057e:	90                   	nop
  80057f:	c9                   	leave  
  800580:	c3                   	ret    

00800581 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800581:	55                   	push   %ebp
  800582:	89 e5                	mov    %esp,%ebp
  800584:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80058a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800591:	00 00 00 
	b.cnt = 0;
  800594:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80059b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80059e:	ff 75 0c             	pushl  0xc(%ebp)
  8005a1:	ff 75 08             	pushl  0x8(%ebp)
  8005a4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005aa:	50                   	push   %eax
  8005ab:	68 18 05 80 00       	push   $0x800518
  8005b0:	e8 11 02 00 00       	call   8007c6 <vprintfmt>
  8005b5:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005b8:	a0 24 30 80 00       	mov    0x803024,%al
  8005bd:	0f b6 c0             	movzbl %al,%eax
  8005c0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005c6:	83 ec 04             	sub    $0x4,%esp
  8005c9:	50                   	push   %eax
  8005ca:	52                   	push   %edx
  8005cb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005d1:	83 c0 08             	add    $0x8,%eax
  8005d4:	50                   	push   %eax
  8005d5:	e8 03 11 00 00       	call   8016dd <sys_cputs>
  8005da:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005dd:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005e4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005ea:	c9                   	leave  
  8005eb:	c3                   	ret    

008005ec <cprintf>:

int cprintf(const char *fmt, ...) {
  8005ec:	55                   	push   %ebp
  8005ed:	89 e5                	mov    %esp,%ebp
  8005ef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005f2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005f9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800602:	83 ec 08             	sub    $0x8,%esp
  800605:	ff 75 f4             	pushl  -0xc(%ebp)
  800608:	50                   	push   %eax
  800609:	e8 73 ff ff ff       	call   800581 <vcprintf>
  80060e:	83 c4 10             	add    $0x10,%esp
  800611:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800614:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800617:	c9                   	leave  
  800618:	c3                   	ret    

00800619 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800619:	55                   	push   %ebp
  80061a:	89 e5                	mov    %esp,%ebp
  80061c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80061f:	e8 ca 12 00 00       	call   8018ee <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800624:	8d 45 0c             	lea    0xc(%ebp),%eax
  800627:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80062a:	8b 45 08             	mov    0x8(%ebp),%eax
  80062d:	83 ec 08             	sub    $0x8,%esp
  800630:	ff 75 f4             	pushl  -0xc(%ebp)
  800633:	50                   	push   %eax
  800634:	e8 48 ff ff ff       	call   800581 <vcprintf>
  800639:	83 c4 10             	add    $0x10,%esp
  80063c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80063f:	e8 c4 12 00 00       	call   801908 <sys_enable_interrupt>
	return cnt;
  800644:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800647:	c9                   	leave  
  800648:	c3                   	ret    

00800649 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800649:	55                   	push   %ebp
  80064a:	89 e5                	mov    %esp,%ebp
  80064c:	53                   	push   %ebx
  80064d:	83 ec 14             	sub    $0x14,%esp
  800650:	8b 45 10             	mov    0x10(%ebp),%eax
  800653:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800656:	8b 45 14             	mov    0x14(%ebp),%eax
  800659:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80065c:	8b 45 18             	mov    0x18(%ebp),%eax
  80065f:	ba 00 00 00 00       	mov    $0x0,%edx
  800664:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800667:	77 55                	ja     8006be <printnum+0x75>
  800669:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80066c:	72 05                	jb     800673 <printnum+0x2a>
  80066e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800671:	77 4b                	ja     8006be <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800673:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800676:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800679:	8b 45 18             	mov    0x18(%ebp),%eax
  80067c:	ba 00 00 00 00       	mov    $0x0,%edx
  800681:	52                   	push   %edx
  800682:	50                   	push   %eax
  800683:	ff 75 f4             	pushl  -0xc(%ebp)
  800686:	ff 75 f0             	pushl  -0x10(%ebp)
  800689:	e8 3e 16 00 00       	call   801ccc <__udivdi3>
  80068e:	83 c4 10             	add    $0x10,%esp
  800691:	83 ec 04             	sub    $0x4,%esp
  800694:	ff 75 20             	pushl  0x20(%ebp)
  800697:	53                   	push   %ebx
  800698:	ff 75 18             	pushl  0x18(%ebp)
  80069b:	52                   	push   %edx
  80069c:	50                   	push   %eax
  80069d:	ff 75 0c             	pushl  0xc(%ebp)
  8006a0:	ff 75 08             	pushl  0x8(%ebp)
  8006a3:	e8 a1 ff ff ff       	call   800649 <printnum>
  8006a8:	83 c4 20             	add    $0x20,%esp
  8006ab:	eb 1a                	jmp    8006c7 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006ad:	83 ec 08             	sub    $0x8,%esp
  8006b0:	ff 75 0c             	pushl  0xc(%ebp)
  8006b3:	ff 75 20             	pushl  0x20(%ebp)
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	ff d0                	call   *%eax
  8006bb:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006be:	ff 4d 1c             	decl   0x1c(%ebp)
  8006c1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006c5:	7f e6                	jg     8006ad <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006c7:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006ca:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d5:	53                   	push   %ebx
  8006d6:	51                   	push   %ecx
  8006d7:	52                   	push   %edx
  8006d8:	50                   	push   %eax
  8006d9:	e8 fe 16 00 00       	call   801ddc <__umoddi3>
  8006de:	83 c4 10             	add    $0x10,%esp
  8006e1:	05 d4 23 80 00       	add    $0x8023d4,%eax
  8006e6:	8a 00                	mov    (%eax),%al
  8006e8:	0f be c0             	movsbl %al,%eax
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 0c             	pushl  0xc(%ebp)
  8006f1:	50                   	push   %eax
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	ff d0                	call   *%eax
  8006f7:	83 c4 10             	add    $0x10,%esp
}
  8006fa:	90                   	nop
  8006fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006fe:	c9                   	leave  
  8006ff:	c3                   	ret    

00800700 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800700:	55                   	push   %ebp
  800701:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800703:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800707:	7e 1c                	jle    800725 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	8b 00                	mov    (%eax),%eax
  80070e:	8d 50 08             	lea    0x8(%eax),%edx
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	89 10                	mov    %edx,(%eax)
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	83 e8 08             	sub    $0x8,%eax
  80071e:	8b 50 04             	mov    0x4(%eax),%edx
  800721:	8b 00                	mov    (%eax),%eax
  800723:	eb 40                	jmp    800765 <getuint+0x65>
	else if (lflag)
  800725:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800729:	74 1e                	je     800749 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	8d 50 04             	lea    0x4(%eax),%edx
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	89 10                	mov    %edx,(%eax)
  800738:	8b 45 08             	mov    0x8(%ebp),%eax
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	83 e8 04             	sub    $0x4,%eax
  800740:	8b 00                	mov    (%eax),%eax
  800742:	ba 00 00 00 00       	mov    $0x0,%edx
  800747:	eb 1c                	jmp    800765 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	8b 00                	mov    (%eax),%eax
  80074e:	8d 50 04             	lea    0x4(%eax),%edx
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	89 10                	mov    %edx,(%eax)
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	8b 00                	mov    (%eax),%eax
  80075b:	83 e8 04             	sub    $0x4,%eax
  80075e:	8b 00                	mov    (%eax),%eax
  800760:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800765:	5d                   	pop    %ebp
  800766:	c3                   	ret    

00800767 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800767:	55                   	push   %ebp
  800768:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80076a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80076e:	7e 1c                	jle    80078c <getint+0x25>
		return va_arg(*ap, long long);
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	8b 00                	mov    (%eax),%eax
  800775:	8d 50 08             	lea    0x8(%eax),%edx
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	89 10                	mov    %edx,(%eax)
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	83 e8 08             	sub    $0x8,%eax
  800785:	8b 50 04             	mov    0x4(%eax),%edx
  800788:	8b 00                	mov    (%eax),%eax
  80078a:	eb 38                	jmp    8007c4 <getint+0x5d>
	else if (lflag)
  80078c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800790:	74 1a                	je     8007ac <getint+0x45>
		return va_arg(*ap, long);
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	8b 00                	mov    (%eax),%eax
  800797:	8d 50 04             	lea    0x4(%eax),%edx
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	89 10                	mov    %edx,(%eax)
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	83 e8 04             	sub    $0x4,%eax
  8007a7:	8b 00                	mov    (%eax),%eax
  8007a9:	99                   	cltd   
  8007aa:	eb 18                	jmp    8007c4 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	8d 50 04             	lea    0x4(%eax),%edx
  8007b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b7:	89 10                	mov    %edx,(%eax)
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	8b 00                	mov    (%eax),%eax
  8007be:	83 e8 04             	sub    $0x4,%eax
  8007c1:	8b 00                	mov    (%eax),%eax
  8007c3:	99                   	cltd   
}
  8007c4:	5d                   	pop    %ebp
  8007c5:	c3                   	ret    

008007c6 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007c6:	55                   	push   %ebp
  8007c7:	89 e5                	mov    %esp,%ebp
  8007c9:	56                   	push   %esi
  8007ca:	53                   	push   %ebx
  8007cb:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007ce:	eb 17                	jmp    8007e7 <vprintfmt+0x21>
			if (ch == '\0')
  8007d0:	85 db                	test   %ebx,%ebx
  8007d2:	0f 84 af 03 00 00    	je     800b87 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007d8:	83 ec 08             	sub    $0x8,%esp
  8007db:	ff 75 0c             	pushl  0xc(%ebp)
  8007de:	53                   	push   %ebx
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	ff d0                	call   *%eax
  8007e4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ea:	8d 50 01             	lea    0x1(%eax),%edx
  8007ed:	89 55 10             	mov    %edx,0x10(%ebp)
  8007f0:	8a 00                	mov    (%eax),%al
  8007f2:	0f b6 d8             	movzbl %al,%ebx
  8007f5:	83 fb 25             	cmp    $0x25,%ebx
  8007f8:	75 d6                	jne    8007d0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007fa:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007fe:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800805:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80080c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800813:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80081a:	8b 45 10             	mov    0x10(%ebp),%eax
  80081d:	8d 50 01             	lea    0x1(%eax),%edx
  800820:	89 55 10             	mov    %edx,0x10(%ebp)
  800823:	8a 00                	mov    (%eax),%al
  800825:	0f b6 d8             	movzbl %al,%ebx
  800828:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80082b:	83 f8 55             	cmp    $0x55,%eax
  80082e:	0f 87 2b 03 00 00    	ja     800b5f <vprintfmt+0x399>
  800834:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  80083b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80083d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800841:	eb d7                	jmp    80081a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800843:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800847:	eb d1                	jmp    80081a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800849:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800850:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800853:	89 d0                	mov    %edx,%eax
  800855:	c1 e0 02             	shl    $0x2,%eax
  800858:	01 d0                	add    %edx,%eax
  80085a:	01 c0                	add    %eax,%eax
  80085c:	01 d8                	add    %ebx,%eax
  80085e:	83 e8 30             	sub    $0x30,%eax
  800861:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800864:	8b 45 10             	mov    0x10(%ebp),%eax
  800867:	8a 00                	mov    (%eax),%al
  800869:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80086c:	83 fb 2f             	cmp    $0x2f,%ebx
  80086f:	7e 3e                	jle    8008af <vprintfmt+0xe9>
  800871:	83 fb 39             	cmp    $0x39,%ebx
  800874:	7f 39                	jg     8008af <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800876:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800879:	eb d5                	jmp    800850 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80087b:	8b 45 14             	mov    0x14(%ebp),%eax
  80087e:	83 c0 04             	add    $0x4,%eax
  800881:	89 45 14             	mov    %eax,0x14(%ebp)
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 e8 04             	sub    $0x4,%eax
  80088a:	8b 00                	mov    (%eax),%eax
  80088c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80088f:	eb 1f                	jmp    8008b0 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800891:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800895:	79 83                	jns    80081a <vprintfmt+0x54>
				width = 0;
  800897:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80089e:	e9 77 ff ff ff       	jmp    80081a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008a3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008aa:	e9 6b ff ff ff       	jmp    80081a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008af:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b4:	0f 89 60 ff ff ff    	jns    80081a <vprintfmt+0x54>
				width = precision, precision = -1;
  8008ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008c0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008c7:	e9 4e ff ff ff       	jmp    80081a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008cc:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008cf:	e9 46 ff ff ff       	jmp    80081a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d7:	83 c0 04             	add    $0x4,%eax
  8008da:	89 45 14             	mov    %eax,0x14(%ebp)
  8008dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e0:	83 e8 04             	sub    $0x4,%eax
  8008e3:	8b 00                	mov    (%eax),%eax
  8008e5:	83 ec 08             	sub    $0x8,%esp
  8008e8:	ff 75 0c             	pushl  0xc(%ebp)
  8008eb:	50                   	push   %eax
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	ff d0                	call   *%eax
  8008f1:	83 c4 10             	add    $0x10,%esp
			break;
  8008f4:	e9 89 02 00 00       	jmp    800b82 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fc:	83 c0 04             	add    $0x4,%eax
  8008ff:	89 45 14             	mov    %eax,0x14(%ebp)
  800902:	8b 45 14             	mov    0x14(%ebp),%eax
  800905:	83 e8 04             	sub    $0x4,%eax
  800908:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80090a:	85 db                	test   %ebx,%ebx
  80090c:	79 02                	jns    800910 <vprintfmt+0x14a>
				err = -err;
  80090e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800910:	83 fb 64             	cmp    $0x64,%ebx
  800913:	7f 0b                	jg     800920 <vprintfmt+0x15a>
  800915:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  80091c:	85 f6                	test   %esi,%esi
  80091e:	75 19                	jne    800939 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800920:	53                   	push   %ebx
  800921:	68 e5 23 80 00       	push   $0x8023e5
  800926:	ff 75 0c             	pushl  0xc(%ebp)
  800929:	ff 75 08             	pushl  0x8(%ebp)
  80092c:	e8 5e 02 00 00       	call   800b8f <printfmt>
  800931:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800934:	e9 49 02 00 00       	jmp    800b82 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800939:	56                   	push   %esi
  80093a:	68 ee 23 80 00       	push   $0x8023ee
  80093f:	ff 75 0c             	pushl  0xc(%ebp)
  800942:	ff 75 08             	pushl  0x8(%ebp)
  800945:	e8 45 02 00 00       	call   800b8f <printfmt>
  80094a:	83 c4 10             	add    $0x10,%esp
			break;
  80094d:	e9 30 02 00 00       	jmp    800b82 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800952:	8b 45 14             	mov    0x14(%ebp),%eax
  800955:	83 c0 04             	add    $0x4,%eax
  800958:	89 45 14             	mov    %eax,0x14(%ebp)
  80095b:	8b 45 14             	mov    0x14(%ebp),%eax
  80095e:	83 e8 04             	sub    $0x4,%eax
  800961:	8b 30                	mov    (%eax),%esi
  800963:	85 f6                	test   %esi,%esi
  800965:	75 05                	jne    80096c <vprintfmt+0x1a6>
				p = "(null)";
  800967:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  80096c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800970:	7e 6d                	jle    8009df <vprintfmt+0x219>
  800972:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800976:	74 67                	je     8009df <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800978:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80097b:	83 ec 08             	sub    $0x8,%esp
  80097e:	50                   	push   %eax
  80097f:	56                   	push   %esi
  800980:	e8 0c 03 00 00       	call   800c91 <strnlen>
  800985:	83 c4 10             	add    $0x10,%esp
  800988:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80098b:	eb 16                	jmp    8009a3 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80098d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 0c             	pushl  0xc(%ebp)
  800997:	50                   	push   %eax
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	ff d0                	call   *%eax
  80099d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009a0:	ff 4d e4             	decl   -0x1c(%ebp)
  8009a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a7:	7f e4                	jg     80098d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009a9:	eb 34                	jmp    8009df <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009ab:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009af:	74 1c                	je     8009cd <vprintfmt+0x207>
  8009b1:	83 fb 1f             	cmp    $0x1f,%ebx
  8009b4:	7e 05                	jle    8009bb <vprintfmt+0x1f5>
  8009b6:	83 fb 7e             	cmp    $0x7e,%ebx
  8009b9:	7e 12                	jle    8009cd <vprintfmt+0x207>
					putch('?', putdat);
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 0c             	pushl  0xc(%ebp)
  8009c1:	6a 3f                	push   $0x3f
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	ff d0                	call   *%eax
  8009c8:	83 c4 10             	add    $0x10,%esp
  8009cb:	eb 0f                	jmp    8009dc <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 0c             	pushl  0xc(%ebp)
  8009d3:	53                   	push   %ebx
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	ff d0                	call   *%eax
  8009d9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009dc:	ff 4d e4             	decl   -0x1c(%ebp)
  8009df:	89 f0                	mov    %esi,%eax
  8009e1:	8d 70 01             	lea    0x1(%eax),%esi
  8009e4:	8a 00                	mov    (%eax),%al
  8009e6:	0f be d8             	movsbl %al,%ebx
  8009e9:	85 db                	test   %ebx,%ebx
  8009eb:	74 24                	je     800a11 <vprintfmt+0x24b>
  8009ed:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009f1:	78 b8                	js     8009ab <vprintfmt+0x1e5>
  8009f3:	ff 4d e0             	decl   -0x20(%ebp)
  8009f6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009fa:	79 af                	jns    8009ab <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009fc:	eb 13                	jmp    800a11 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	6a 20                	push   $0x20
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a0e:	ff 4d e4             	decl   -0x1c(%ebp)
  800a11:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a15:	7f e7                	jg     8009fe <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a17:	e9 66 01 00 00       	jmp    800b82 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a1c:	83 ec 08             	sub    $0x8,%esp
  800a1f:	ff 75 e8             	pushl  -0x18(%ebp)
  800a22:	8d 45 14             	lea    0x14(%ebp),%eax
  800a25:	50                   	push   %eax
  800a26:	e8 3c fd ff ff       	call   800767 <getint>
  800a2b:	83 c4 10             	add    $0x10,%esp
  800a2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a31:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a37:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a3a:	85 d2                	test   %edx,%edx
  800a3c:	79 23                	jns    800a61 <vprintfmt+0x29b>
				putch('-', putdat);
  800a3e:	83 ec 08             	sub    $0x8,%esp
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	6a 2d                	push   $0x2d
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	ff d0                	call   *%eax
  800a4b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a51:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a54:	f7 d8                	neg    %eax
  800a56:	83 d2 00             	adc    $0x0,%edx
  800a59:	f7 da                	neg    %edx
  800a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a61:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a68:	e9 bc 00 00 00       	jmp    800b29 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	ff 75 e8             	pushl  -0x18(%ebp)
  800a73:	8d 45 14             	lea    0x14(%ebp),%eax
  800a76:	50                   	push   %eax
  800a77:	e8 84 fc ff ff       	call   800700 <getuint>
  800a7c:	83 c4 10             	add    $0x10,%esp
  800a7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a82:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a85:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a8c:	e9 98 00 00 00       	jmp    800b29 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a91:	83 ec 08             	sub    $0x8,%esp
  800a94:	ff 75 0c             	pushl  0xc(%ebp)
  800a97:	6a 58                	push   $0x58
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	ff d0                	call   *%eax
  800a9e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	ff 75 0c             	pushl  0xc(%ebp)
  800aa7:	6a 58                	push   $0x58
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	ff d0                	call   *%eax
  800aae:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ab1:	83 ec 08             	sub    $0x8,%esp
  800ab4:	ff 75 0c             	pushl  0xc(%ebp)
  800ab7:	6a 58                	push   $0x58
  800ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  800abc:	ff d0                	call   *%eax
  800abe:	83 c4 10             	add    $0x10,%esp
			break;
  800ac1:	e9 bc 00 00 00       	jmp    800b82 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ac6:	83 ec 08             	sub    $0x8,%esp
  800ac9:	ff 75 0c             	pushl  0xc(%ebp)
  800acc:	6a 30                	push   $0x30
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	6a 78                	push   $0x78
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	ff d0                	call   *%eax
  800ae3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ae6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae9:	83 c0 04             	add    $0x4,%eax
  800aec:	89 45 14             	mov    %eax,0x14(%ebp)
  800aef:	8b 45 14             	mov    0x14(%ebp),%eax
  800af2:	83 e8 04             	sub    $0x4,%eax
  800af5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800af7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800afa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b01:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b08:	eb 1f                	jmp    800b29 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b0a:	83 ec 08             	sub    $0x8,%esp
  800b0d:	ff 75 e8             	pushl  -0x18(%ebp)
  800b10:	8d 45 14             	lea    0x14(%ebp),%eax
  800b13:	50                   	push   %eax
  800b14:	e8 e7 fb ff ff       	call   800700 <getuint>
  800b19:	83 c4 10             	add    $0x10,%esp
  800b1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b22:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b29:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b30:	83 ec 04             	sub    $0x4,%esp
  800b33:	52                   	push   %edx
  800b34:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b37:	50                   	push   %eax
  800b38:	ff 75 f4             	pushl  -0xc(%ebp)
  800b3b:	ff 75 f0             	pushl  -0x10(%ebp)
  800b3e:	ff 75 0c             	pushl  0xc(%ebp)
  800b41:	ff 75 08             	pushl  0x8(%ebp)
  800b44:	e8 00 fb ff ff       	call   800649 <printnum>
  800b49:	83 c4 20             	add    $0x20,%esp
			break;
  800b4c:	eb 34                	jmp    800b82 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b4e:	83 ec 08             	sub    $0x8,%esp
  800b51:	ff 75 0c             	pushl  0xc(%ebp)
  800b54:	53                   	push   %ebx
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	ff d0                	call   *%eax
  800b5a:	83 c4 10             	add    $0x10,%esp
			break;
  800b5d:	eb 23                	jmp    800b82 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	6a 25                	push   $0x25
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	ff d0                	call   *%eax
  800b6c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b6f:	ff 4d 10             	decl   0x10(%ebp)
  800b72:	eb 03                	jmp    800b77 <vprintfmt+0x3b1>
  800b74:	ff 4d 10             	decl   0x10(%ebp)
  800b77:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7a:	48                   	dec    %eax
  800b7b:	8a 00                	mov    (%eax),%al
  800b7d:	3c 25                	cmp    $0x25,%al
  800b7f:	75 f3                	jne    800b74 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b81:	90                   	nop
		}
	}
  800b82:	e9 47 fc ff ff       	jmp    8007ce <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b87:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b88:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b8b:	5b                   	pop    %ebx
  800b8c:	5e                   	pop    %esi
  800b8d:	5d                   	pop    %ebp
  800b8e:	c3                   	ret    

00800b8f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b95:	8d 45 10             	lea    0x10(%ebp),%eax
  800b98:	83 c0 04             	add    $0x4,%eax
  800b9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba4:	50                   	push   %eax
  800ba5:	ff 75 0c             	pushl  0xc(%ebp)
  800ba8:	ff 75 08             	pushl  0x8(%ebp)
  800bab:	e8 16 fc ff ff       	call   8007c6 <vprintfmt>
  800bb0:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bb3:	90                   	nop
  800bb4:	c9                   	leave  
  800bb5:	c3                   	ret    

00800bb6 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bb6:	55                   	push   %ebp
  800bb7:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbc:	8b 40 08             	mov    0x8(%eax),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc5:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcb:	8b 10                	mov    (%eax),%edx
  800bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd0:	8b 40 04             	mov    0x4(%eax),%eax
  800bd3:	39 c2                	cmp    %eax,%edx
  800bd5:	73 12                	jae    800be9 <sprintputch+0x33>
		*b->buf++ = ch;
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	8b 00                	mov    (%eax),%eax
  800bdc:	8d 48 01             	lea    0x1(%eax),%ecx
  800bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be2:	89 0a                	mov    %ecx,(%edx)
  800be4:	8b 55 08             	mov    0x8(%ebp),%edx
  800be7:	88 10                	mov    %dl,(%eax)
}
  800be9:	90                   	nop
  800bea:	5d                   	pop    %ebp
  800beb:	c3                   	ret    

00800bec <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bec:	55                   	push   %ebp
  800bed:	89 e5                	mov    %esp,%ebp
  800bef:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	01 d0                	add    %edx,%eax
  800c03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c11:	74 06                	je     800c19 <vsnprintf+0x2d>
  800c13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c17:	7f 07                	jg     800c20 <vsnprintf+0x34>
		return -E_INVAL;
  800c19:	b8 03 00 00 00       	mov    $0x3,%eax
  800c1e:	eb 20                	jmp    800c40 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c20:	ff 75 14             	pushl  0x14(%ebp)
  800c23:	ff 75 10             	pushl  0x10(%ebp)
  800c26:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c29:	50                   	push   %eax
  800c2a:	68 b6 0b 80 00       	push   $0x800bb6
  800c2f:	e8 92 fb ff ff       	call   8007c6 <vprintfmt>
  800c34:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c3a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
  800c45:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c48:	8d 45 10             	lea    0x10(%ebp),%eax
  800c4b:	83 c0 04             	add    $0x4,%eax
  800c4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c51:	8b 45 10             	mov    0x10(%ebp),%eax
  800c54:	ff 75 f4             	pushl  -0xc(%ebp)
  800c57:	50                   	push   %eax
  800c58:	ff 75 0c             	pushl  0xc(%ebp)
  800c5b:	ff 75 08             	pushl  0x8(%ebp)
  800c5e:	e8 89 ff ff ff       	call   800bec <vsnprintf>
  800c63:	83 c4 10             	add    $0x10,%esp
  800c66:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c7b:	eb 06                	jmp    800c83 <strlen+0x15>
		n++;
  800c7d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c80:	ff 45 08             	incl   0x8(%ebp)
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	84 c0                	test   %al,%al
  800c8a:	75 f1                	jne    800c7d <strlen+0xf>
		n++;
	return n;
  800c8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c9e:	eb 09                	jmp    800ca9 <strnlen+0x18>
		n++;
  800ca0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ca3:	ff 45 08             	incl   0x8(%ebp)
  800ca6:	ff 4d 0c             	decl   0xc(%ebp)
  800ca9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cad:	74 09                	je     800cb8 <strnlen+0x27>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	84 c0                	test   %al,%al
  800cb6:	75 e8                	jne    800ca0 <strnlen+0xf>
		n++;
	return n;
  800cb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cbb:	c9                   	leave  
  800cbc:	c3                   	ret    

00800cbd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
  800cc0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cc9:	90                   	nop
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	8d 50 01             	lea    0x1(%eax),%edx
  800cd0:	89 55 08             	mov    %edx,0x8(%ebp)
  800cd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cd9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cdc:	8a 12                	mov    (%edx),%dl
  800cde:	88 10                	mov    %dl,(%eax)
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	84 c0                	test   %al,%al
  800ce4:	75 e4                	jne    800cca <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ce6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cf7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cfe:	eb 1f                	jmp    800d1f <strncpy+0x34>
		*dst++ = *src;
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8d 50 01             	lea    0x1(%eax),%edx
  800d06:	89 55 08             	mov    %edx,0x8(%ebp)
  800d09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d0c:	8a 12                	mov    (%edx),%dl
  800d0e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	84 c0                	test   %al,%al
  800d17:	74 03                	je     800d1c <strncpy+0x31>
			src++;
  800d19:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d1c:	ff 45 fc             	incl   -0x4(%ebp)
  800d1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d22:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d25:	72 d9                	jb     800d00 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d27:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d2a:	c9                   	leave  
  800d2b:	c3                   	ret    

00800d2c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d2c:	55                   	push   %ebp
  800d2d:	89 e5                	mov    %esp,%ebp
  800d2f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d38:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3c:	74 30                	je     800d6e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d3e:	eb 16                	jmp    800d56 <strlcpy+0x2a>
			*dst++ = *src++;
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
  800d43:	8d 50 01             	lea    0x1(%eax),%edx
  800d46:	89 55 08             	mov    %edx,0x8(%ebp)
  800d49:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d4f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d52:	8a 12                	mov    (%edx),%dl
  800d54:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d56:	ff 4d 10             	decl   0x10(%ebp)
  800d59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5d:	74 09                	je     800d68 <strlcpy+0x3c>
  800d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d62:	8a 00                	mov    (%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 d8                	jne    800d40 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d6e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d74:	29 c2                	sub    %eax,%edx
  800d76:	89 d0                	mov    %edx,%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d7d:	eb 06                	jmp    800d85 <strcmp+0xb>
		p++, q++;
  800d7f:	ff 45 08             	incl   0x8(%ebp)
  800d82:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	84 c0                	test   %al,%al
  800d8c:	74 0e                	je     800d9c <strcmp+0x22>
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8a 10                	mov    (%eax),%dl
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	38 c2                	cmp    %al,%dl
  800d9a:	74 e3                	je     800d7f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	0f b6 d0             	movzbl %al,%edx
  800da4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da7:	8a 00                	mov    (%eax),%al
  800da9:	0f b6 c0             	movzbl %al,%eax
  800dac:	29 c2                	sub    %eax,%edx
  800dae:	89 d0                	mov    %edx,%eax
}
  800db0:	5d                   	pop    %ebp
  800db1:	c3                   	ret    

00800db2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800db2:	55                   	push   %ebp
  800db3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800db5:	eb 09                	jmp    800dc0 <strncmp+0xe>
		n--, p++, q++;
  800db7:	ff 4d 10             	decl   0x10(%ebp)
  800dba:	ff 45 08             	incl   0x8(%ebp)
  800dbd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc4:	74 17                	je     800ddd <strncmp+0x2b>
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	84 c0                	test   %al,%al
  800dcd:	74 0e                	je     800ddd <strncmp+0x2b>
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8a 10                	mov    (%eax),%dl
  800dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	38 c2                	cmp    %al,%dl
  800ddb:	74 da                	je     800db7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ddd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de1:	75 07                	jne    800dea <strncmp+0x38>
		return 0;
  800de3:	b8 00 00 00 00       	mov    $0x0,%eax
  800de8:	eb 14                	jmp    800dfe <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8a 00                	mov    (%eax),%al
  800def:	0f b6 d0             	movzbl %al,%edx
  800df2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	0f b6 c0             	movzbl %al,%eax
  800dfa:	29 c2                	sub    %eax,%edx
  800dfc:	89 d0                	mov    %edx,%eax
}
  800dfe:	5d                   	pop    %ebp
  800dff:	c3                   	ret    

00800e00 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	83 ec 04             	sub    $0x4,%esp
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e0c:	eb 12                	jmp    800e20 <strchr+0x20>
		if (*s == c)
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 00                	mov    (%eax),%al
  800e13:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e16:	75 05                	jne    800e1d <strchr+0x1d>
			return (char *) s;
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	eb 11                	jmp    800e2e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e1d:	ff 45 08             	incl   0x8(%ebp)
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	84 c0                	test   %al,%al
  800e27:	75 e5                	jne    800e0e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e29:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 04             	sub    $0x4,%esp
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e3c:	eb 0d                	jmp    800e4b <strfind+0x1b>
		if (*s == c)
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e46:	74 0e                	je     800e56 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e48:	ff 45 08             	incl   0x8(%ebp)
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	84 c0                	test   %al,%al
  800e52:	75 ea                	jne    800e3e <strfind+0xe>
  800e54:	eb 01                	jmp    800e57 <strfind+0x27>
		if (*s == c)
			break;
  800e56:	90                   	nop
	return (char *) s;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e5a:	c9                   	leave  
  800e5b:	c3                   	ret    

00800e5c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e5c:	55                   	push   %ebp
  800e5d:	89 e5                	mov    %esp,%ebp
  800e5f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e68:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e6e:	eb 0e                	jmp    800e7e <memset+0x22>
		*p++ = c;
  800e70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e73:	8d 50 01             	lea    0x1(%eax),%edx
  800e76:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e79:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e7c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e7e:	ff 4d f8             	decl   -0x8(%ebp)
  800e81:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e85:	79 e9                	jns    800e70 <memset+0x14>
		*p++ = c;

	return v;
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
  800e8f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e98:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e9e:	eb 16                	jmp    800eb6 <memcpy+0x2a>
		*d++ = *s++;
  800ea0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea3:	8d 50 01             	lea    0x1(%eax),%edx
  800ea6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eac:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eaf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eb2:	8a 12                	mov    (%edx),%dl
  800eb4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ebc:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebf:	85 c0                	test   %eax,%eax
  800ec1:	75 dd                	jne    800ea0 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec6:	c9                   	leave  
  800ec7:	c3                   	ret    

00800ec8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ec8:	55                   	push   %ebp
  800ec9:	89 e5                	mov    %esp,%ebp
  800ecb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800ece:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800eda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ee0:	73 50                	jae    800f32 <memmove+0x6a>
  800ee2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee8:	01 d0                	add    %edx,%eax
  800eea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eed:	76 43                	jbe    800f32 <memmove+0x6a>
		s += n;
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800efb:	eb 10                	jmp    800f0d <memmove+0x45>
			*--d = *--s;
  800efd:	ff 4d f8             	decl   -0x8(%ebp)
  800f00:	ff 4d fc             	decl   -0x4(%ebp)
  800f03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f06:	8a 10                	mov    (%eax),%dl
  800f08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f0b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f10:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f13:	89 55 10             	mov    %edx,0x10(%ebp)
  800f16:	85 c0                	test   %eax,%eax
  800f18:	75 e3                	jne    800efd <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f1a:	eb 23                	jmp    800f3f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1f:	8d 50 01             	lea    0x1(%eax),%edx
  800f22:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f25:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f28:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f2b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f2e:	8a 12                	mov    (%edx),%dl
  800f30:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f32:	8b 45 10             	mov    0x10(%ebp),%eax
  800f35:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f38:	89 55 10             	mov    %edx,0x10(%ebp)
  800f3b:	85 c0                	test   %eax,%eax
  800f3d:	75 dd                	jne    800f1c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f3f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f42:	c9                   	leave  
  800f43:	c3                   	ret    

00800f44 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f44:	55                   	push   %ebp
  800f45:	89 e5                	mov    %esp,%ebp
  800f47:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f56:	eb 2a                	jmp    800f82 <memcmp+0x3e>
		if (*s1 != *s2)
  800f58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5b:	8a 10                	mov    (%eax),%dl
  800f5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	38 c2                	cmp    %al,%dl
  800f64:	74 16                	je     800f7c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f69:	8a 00                	mov    (%eax),%al
  800f6b:	0f b6 d0             	movzbl %al,%edx
  800f6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	0f b6 c0             	movzbl %al,%eax
  800f76:	29 c2                	sub    %eax,%edx
  800f78:	89 d0                	mov    %edx,%eax
  800f7a:	eb 18                	jmp    800f94 <memcmp+0x50>
		s1++, s2++;
  800f7c:	ff 45 fc             	incl   -0x4(%ebp)
  800f7f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f82:	8b 45 10             	mov    0x10(%ebp),%eax
  800f85:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f88:	89 55 10             	mov    %edx,0x10(%ebp)
  800f8b:	85 c0                	test   %eax,%eax
  800f8d:	75 c9                	jne    800f58 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f94:	c9                   	leave  
  800f95:	c3                   	ret    

00800f96 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f96:	55                   	push   %ebp
  800f97:	89 e5                	mov    %esp,%ebp
  800f99:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f9c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	01 d0                	add    %edx,%eax
  800fa4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fa7:	eb 15                	jmp    800fbe <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	0f b6 d0             	movzbl %al,%edx
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	0f b6 c0             	movzbl %al,%eax
  800fb7:	39 c2                	cmp    %eax,%edx
  800fb9:	74 0d                	je     800fc8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fbb:	ff 45 08             	incl   0x8(%ebp)
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fc4:	72 e3                	jb     800fa9 <memfind+0x13>
  800fc6:	eb 01                	jmp    800fc9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fc8:	90                   	nop
	return (void *) s;
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fcc:	c9                   	leave  
  800fcd:	c3                   	ret    

00800fce <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
  800fd1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fd4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fdb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fe2:	eb 03                	jmp    800fe7 <strtol+0x19>
		s++;
  800fe4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fea:	8a 00                	mov    (%eax),%al
  800fec:	3c 20                	cmp    $0x20,%al
  800fee:	74 f4                	je     800fe4 <strtol+0x16>
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3c 09                	cmp    $0x9,%al
  800ff7:	74 eb                	je     800fe4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 2b                	cmp    $0x2b,%al
  801000:	75 05                	jne    801007 <strtol+0x39>
		s++;
  801002:	ff 45 08             	incl   0x8(%ebp)
  801005:	eb 13                	jmp    80101a <strtol+0x4c>
	else if (*s == '-')
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	8a 00                	mov    (%eax),%al
  80100c:	3c 2d                	cmp    $0x2d,%al
  80100e:	75 0a                	jne    80101a <strtol+0x4c>
		s++, neg = 1;
  801010:	ff 45 08             	incl   0x8(%ebp)
  801013:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80101a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101e:	74 06                	je     801026 <strtol+0x58>
  801020:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801024:	75 20                	jne    801046 <strtol+0x78>
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	3c 30                	cmp    $0x30,%al
  80102d:	75 17                	jne    801046 <strtol+0x78>
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	40                   	inc    %eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	3c 78                	cmp    $0x78,%al
  801037:	75 0d                	jne    801046 <strtol+0x78>
		s += 2, base = 16;
  801039:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80103d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801044:	eb 28                	jmp    80106e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801046:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80104a:	75 15                	jne    801061 <strtol+0x93>
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	8a 00                	mov    (%eax),%al
  801051:	3c 30                	cmp    $0x30,%al
  801053:	75 0c                	jne    801061 <strtol+0x93>
		s++, base = 8;
  801055:	ff 45 08             	incl   0x8(%ebp)
  801058:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80105f:	eb 0d                	jmp    80106e <strtol+0xa0>
	else if (base == 0)
  801061:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801065:	75 07                	jne    80106e <strtol+0xa0>
		base = 10;
  801067:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	8a 00                	mov    (%eax),%al
  801073:	3c 2f                	cmp    $0x2f,%al
  801075:	7e 19                	jle    801090 <strtol+0xc2>
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	8a 00                	mov    (%eax),%al
  80107c:	3c 39                	cmp    $0x39,%al
  80107e:	7f 10                	jg     801090 <strtol+0xc2>
			dig = *s - '0';
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	0f be c0             	movsbl %al,%eax
  801088:	83 e8 30             	sub    $0x30,%eax
  80108b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80108e:	eb 42                	jmp    8010d2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	3c 60                	cmp    $0x60,%al
  801097:	7e 19                	jle    8010b2 <strtol+0xe4>
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	3c 7a                	cmp    $0x7a,%al
  8010a0:	7f 10                	jg     8010b2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	0f be c0             	movsbl %al,%eax
  8010aa:	83 e8 57             	sub    $0x57,%eax
  8010ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010b0:	eb 20                	jmp    8010d2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	3c 40                	cmp    $0x40,%al
  8010b9:	7e 39                	jle    8010f4 <strtol+0x126>
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	3c 5a                	cmp    $0x5a,%al
  8010c2:	7f 30                	jg     8010f4 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	0f be c0             	movsbl %al,%eax
  8010cc:	83 e8 37             	sub    $0x37,%eax
  8010cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010d8:	7d 19                	jge    8010f3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010da:	ff 45 08             	incl   0x8(%ebp)
  8010dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010e4:	89 c2                	mov    %eax,%edx
  8010e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e9:	01 d0                	add    %edx,%eax
  8010eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010ee:	e9 7b ff ff ff       	jmp    80106e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010f3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010f8:	74 08                	je     801102 <strtol+0x134>
		*endptr = (char *) s;
  8010fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801100:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801102:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801106:	74 07                	je     80110f <strtol+0x141>
  801108:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110b:	f7 d8                	neg    %eax
  80110d:	eb 03                	jmp    801112 <strtol+0x144>
  80110f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <ltostr>:

void
ltostr(long value, char *str)
{
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
  801117:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80111a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801121:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801128:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80112c:	79 13                	jns    801141 <ltostr+0x2d>
	{
		neg = 1;
  80112e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801135:	8b 45 0c             	mov    0xc(%ebp),%eax
  801138:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80113b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80113e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801141:	8b 45 08             	mov    0x8(%ebp),%eax
  801144:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801149:	99                   	cltd   
  80114a:	f7 f9                	idiv   %ecx
  80114c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80114f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801152:	8d 50 01             	lea    0x1(%eax),%edx
  801155:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801158:	89 c2                	mov    %eax,%edx
  80115a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115d:	01 d0                	add    %edx,%eax
  80115f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801162:	83 c2 30             	add    $0x30,%edx
  801165:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801167:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80116a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80116f:	f7 e9                	imul   %ecx
  801171:	c1 fa 02             	sar    $0x2,%edx
  801174:	89 c8                	mov    %ecx,%eax
  801176:	c1 f8 1f             	sar    $0x1f,%eax
  801179:	29 c2                	sub    %eax,%edx
  80117b:	89 d0                	mov    %edx,%eax
  80117d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801180:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801183:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801188:	f7 e9                	imul   %ecx
  80118a:	c1 fa 02             	sar    $0x2,%edx
  80118d:	89 c8                	mov    %ecx,%eax
  80118f:	c1 f8 1f             	sar    $0x1f,%eax
  801192:	29 c2                	sub    %eax,%edx
  801194:	89 d0                	mov    %edx,%eax
  801196:	c1 e0 02             	shl    $0x2,%eax
  801199:	01 d0                	add    %edx,%eax
  80119b:	01 c0                	add    %eax,%eax
  80119d:	29 c1                	sub    %eax,%ecx
  80119f:	89 ca                	mov    %ecx,%edx
  8011a1:	85 d2                	test   %edx,%edx
  8011a3:	75 9c                	jne    801141 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011af:	48                   	dec    %eax
  8011b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011b7:	74 3d                	je     8011f6 <ltostr+0xe2>
		start = 1 ;
  8011b9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011c0:	eb 34                	jmp    8011f6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c8:	01 d0                	add    %edx,%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d5:	01 c2                	add    %eax,%edx
  8011d7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	01 c8                	add    %ecx,%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	01 c2                	add    %eax,%edx
  8011eb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011ee:	88 02                	mov    %al,(%edx)
		start++ ;
  8011f0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011f3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011fc:	7c c4                	jl     8011c2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801201:	8b 45 0c             	mov    0xc(%ebp),%eax
  801204:	01 d0                	add    %edx,%eax
  801206:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801209:	90                   	nop
  80120a:	c9                   	leave  
  80120b:	c3                   	ret    

0080120c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
  80120f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801212:	ff 75 08             	pushl  0x8(%ebp)
  801215:	e8 54 fa ff ff       	call   800c6e <strlen>
  80121a:	83 c4 04             	add    $0x4,%esp
  80121d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801220:	ff 75 0c             	pushl  0xc(%ebp)
  801223:	e8 46 fa ff ff       	call   800c6e <strlen>
  801228:	83 c4 04             	add    $0x4,%esp
  80122b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80122e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801235:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80123c:	eb 17                	jmp    801255 <strcconcat+0x49>
		final[s] = str1[s] ;
  80123e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801241:	8b 45 10             	mov    0x10(%ebp),%eax
  801244:	01 c2                	add    %eax,%edx
  801246:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	01 c8                	add    %ecx,%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801252:	ff 45 fc             	incl   -0x4(%ebp)
  801255:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801258:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80125b:	7c e1                	jl     80123e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80125d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801264:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80126b:	eb 1f                	jmp    80128c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801270:	8d 50 01             	lea    0x1(%eax),%edx
  801273:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801276:	89 c2                	mov    %eax,%edx
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	01 c2                	add    %eax,%edx
  80127d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801280:	8b 45 0c             	mov    0xc(%ebp),%eax
  801283:	01 c8                	add    %ecx,%eax
  801285:	8a 00                	mov    (%eax),%al
  801287:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801289:	ff 45 f8             	incl   -0x8(%ebp)
  80128c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801292:	7c d9                	jl     80126d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801294:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801297:	8b 45 10             	mov    0x10(%ebp),%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	c6 00 00             	movb   $0x0,(%eax)
}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b1:	8b 00                	mov    (%eax),%eax
  8012b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	01 d0                	add    %edx,%eax
  8012bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012c5:	eb 0c                	jmp    8012d3 <strsplit+0x31>
			*string++ = 0;
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	8d 50 01             	lea    0x1(%eax),%edx
  8012cd:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d6:	8a 00                	mov    (%eax),%al
  8012d8:	84 c0                	test   %al,%al
  8012da:	74 18                	je     8012f4 <strsplit+0x52>
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	0f be c0             	movsbl %al,%eax
  8012e4:	50                   	push   %eax
  8012e5:	ff 75 0c             	pushl  0xc(%ebp)
  8012e8:	e8 13 fb ff ff       	call   800e00 <strchr>
  8012ed:	83 c4 08             	add    $0x8,%esp
  8012f0:	85 c0                	test   %eax,%eax
  8012f2:	75 d3                	jne    8012c7 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	8a 00                	mov    (%eax),%al
  8012f9:	84 c0                	test   %al,%al
  8012fb:	74 5a                	je     801357 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8012fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801300:	8b 00                	mov    (%eax),%eax
  801302:	83 f8 0f             	cmp    $0xf,%eax
  801305:	75 07                	jne    80130e <strsplit+0x6c>
		{
			return 0;
  801307:	b8 00 00 00 00       	mov    $0x0,%eax
  80130c:	eb 66                	jmp    801374 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80130e:	8b 45 14             	mov    0x14(%ebp),%eax
  801311:	8b 00                	mov    (%eax),%eax
  801313:	8d 48 01             	lea    0x1(%eax),%ecx
  801316:	8b 55 14             	mov    0x14(%ebp),%edx
  801319:	89 0a                	mov    %ecx,(%edx)
  80131b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801322:	8b 45 10             	mov    0x10(%ebp),%eax
  801325:	01 c2                	add    %eax,%edx
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80132c:	eb 03                	jmp    801331 <strsplit+0x8f>
			string++;
  80132e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8a 00                	mov    (%eax),%al
  801336:	84 c0                	test   %al,%al
  801338:	74 8b                	je     8012c5 <strsplit+0x23>
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	0f be c0             	movsbl %al,%eax
  801342:	50                   	push   %eax
  801343:	ff 75 0c             	pushl  0xc(%ebp)
  801346:	e8 b5 fa ff ff       	call   800e00 <strchr>
  80134b:	83 c4 08             	add    $0x8,%esp
  80134e:	85 c0                	test   %eax,%eax
  801350:	74 dc                	je     80132e <strsplit+0x8c>
			string++;
	}
  801352:	e9 6e ff ff ff       	jmp    8012c5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801357:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801358:	8b 45 14             	mov    0x14(%ebp),%eax
  80135b:	8b 00                	mov    (%eax),%eax
  80135d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801364:	8b 45 10             	mov    0x10(%ebp),%eax
  801367:	01 d0                	add    %edx,%eax
  801369:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80136f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
  801379:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  80137c:	a1 04 30 80 00       	mov    0x803004,%eax
  801381:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801384:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  80138b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801392:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801399:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  8013a0:	e9 f9 00 00 00       	jmp    80149e <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  8013a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a8:	05 00 00 00 80       	add    $0x80000000,%eax
  8013ad:	c1 e8 0c             	shr    $0xc,%eax
  8013b0:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8013b7:	85 c0                	test   %eax,%eax
  8013b9:	75 1c                	jne    8013d7 <nextFitAlgo+0x61>
  8013bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8013bf:	74 16                	je     8013d7 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  8013c1:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8013c8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  8013cf:	ff 4d e0             	decl   -0x20(%ebp)
  8013d2:	e9 90 00 00 00       	jmp    801467 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  8013d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013da:	05 00 00 00 80       	add    $0x80000000,%eax
  8013df:	c1 e8 0c             	shr    $0xc,%eax
  8013e2:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8013e9:	85 c0                	test   %eax,%eax
  8013eb:	75 26                	jne    801413 <nextFitAlgo+0x9d>
  8013ed:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8013f1:	75 20                	jne    801413 <nextFitAlgo+0x9d>
			flag = 1;
  8013f3:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  8013fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  801400:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801407:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  80140e:	ff 4d e0             	decl   -0x20(%ebp)
  801411:	eb 54                	jmp    801467 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801413:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801416:	3b 45 08             	cmp    0x8(%ebp),%eax
  801419:	72 11                	jb     80142c <nextFitAlgo+0xb6>
				startAdd = tmp;
  80141b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80141e:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  801423:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  80142a:	eb 7c                	jmp    8014a8 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  80142c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80142f:	05 00 00 00 80       	add    $0x80000000,%eax
  801434:	c1 e8 0c             	shr    $0xc,%eax
  801437:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80143e:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801441:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801444:	05 00 00 00 80       	add    $0x80000000,%eax
  801449:	c1 e8 0c             	shr    $0xc,%eax
  80144c:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801453:	c1 e0 0c             	shl    $0xc,%eax
  801456:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801459:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801460:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801467:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80146a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80146d:	72 11                	jb     801480 <nextFitAlgo+0x10a>
			startAdd = tmp;
  80146f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801472:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801477:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  80147e:	eb 28                	jmp    8014a8 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801480:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801487:	76 15                	jbe    80149e <nextFitAlgo+0x128>
			flag = newSize = 0;
  801489:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801490:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801497:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  80149e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8014a2:	0f 85 fd fe ff ff    	jne    8013a5 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  8014a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014ac:	75 1a                	jne    8014c8 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  8014ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014b1:	3b 45 08             	cmp    0x8(%ebp),%eax
  8014b4:	73 0a                	jae    8014c0 <nextFitAlgo+0x14a>
  8014b6:	b8 00 00 00 00       	mov    $0x0,%eax
  8014bb:	e9 99 00 00 00       	jmp    801559 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  8014c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014c3:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  8014c8:	a1 04 30 80 00       	mov    0x803004,%eax
  8014cd:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  8014d0:	a1 04 30 80 00       	mov    0x803004,%eax
  8014d5:	05 00 00 00 80       	add    $0x80000000,%eax
  8014da:	c1 e8 0c             	shr    $0xc,%eax
  8014dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	c1 e8 0c             	shr    $0xc,%eax
  8014e6:	89 c2                	mov    %eax,%edx
  8014e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014eb:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  8014f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8014f7:	83 ec 08             	sub    $0x8,%esp
  8014fa:	ff 75 08             	pushl  0x8(%ebp)
  8014fd:	50                   	push   %eax
  8014fe:	e8 82 03 00 00       	call   801885 <sys_allocateMem>
  801503:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801506:	a1 04 30 80 00       	mov    0x803004,%eax
  80150b:	05 00 00 00 80       	add    $0x80000000,%eax
  801510:	c1 e8 0c             	shr    $0xc,%eax
  801513:	89 c2                	mov    %eax,%edx
  801515:	a1 04 30 80 00       	mov    0x803004,%eax
  80151a:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801521:	a1 04 30 80 00       	mov    0x803004,%eax
  801526:	05 00 00 00 80       	add    $0x80000000,%eax
  80152b:	c1 e8 0c             	shr    $0xc,%eax
  80152e:	89 c2                	mov    %eax,%edx
  801530:	8b 45 08             	mov    0x8(%ebp),%eax
  801533:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  80153a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	01 d0                	add    %edx,%eax
  801545:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  80154a:	76 0a                	jbe    801556 <nextFitAlgo+0x1e0>
  80154c:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801553:	00 00 80 

	return (void*)returnHolder;
  801556:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <malloc>:

void* malloc(uint32 size) {
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
  80155e:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801561:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801568:	8b 55 08             	mov    0x8(%ebp),%edx
  80156b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80156e:	01 d0                	add    %edx,%eax
  801570:	48                   	dec    %eax
  801571:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801574:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801577:	ba 00 00 00 00       	mov    $0x0,%edx
  80157c:	f7 75 f4             	divl   -0xc(%ebp)
  80157f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801582:	29 d0                	sub    %edx,%eax
  801584:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801587:	e8 c3 06 00 00       	call   801c4f <sys_isUHeapPlacementStrategyNEXTFIT>
  80158c:	85 c0                	test   %eax,%eax
  80158e:	74 10                	je     8015a0 <malloc+0x45>
		return nextFitAlgo(size);
  801590:	83 ec 0c             	sub    $0xc,%esp
  801593:	ff 75 08             	pushl  0x8(%ebp)
  801596:	e8 db fd ff ff       	call   801376 <nextFitAlgo>
  80159b:	83 c4 10             	add    $0x10,%esp
  80159e:	eb 0a                	jmp    8015aa <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  8015a0:	e8 79 06 00 00       	call   801c1e <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  8015a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
  8015af:	83 ec 18             	sub    $0x18,%esp
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8015b8:	83 ec 04             	sub    $0x4,%esp
  8015bb:	68 50 25 80 00       	push   $0x802550
  8015c0:	6a 7e                	push   $0x7e
  8015c2:	68 6f 25 80 00       	push   $0x80256f
  8015c7:	e8 6c ed ff ff       	call   800338 <_panic>

008015cc <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8015d2:	83 ec 04             	sub    $0x4,%esp
  8015d5:	68 7b 25 80 00       	push   $0x80257b
  8015da:	68 84 00 00 00       	push   $0x84
  8015df:	68 6f 25 80 00       	push   $0x80256f
  8015e4:	e8 4f ed ff ff       	call   800338 <_panic>

008015e9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8015ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015f6:	eb 61                	jmp    801659 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  8015f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015fb:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	39 c2                	cmp    %eax,%edx
  801607:	75 4d                	jne    801656 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	05 00 00 00 80       	add    $0x80000000,%eax
  801611:	c1 e8 0c             	shr    $0xc,%eax
  801614:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801617:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80161a:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801621:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801624:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801627:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  80162e:	00 00 00 00 
  801632:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801635:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  80163c:	00 00 00 00 
  801640:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801643:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  80164a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80164d:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801654:	eb 0d                	jmp    801663 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801656:	ff 45 f0             	incl   -0x10(%ebp)
  801659:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80165c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801661:	76 95                	jbe    8015f8 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	83 ec 08             	sub    $0x8,%esp
  801669:	ff 75 f4             	pushl  -0xc(%ebp)
  80166c:	50                   	push   %eax
  80166d:	e8 f7 01 00 00       	call   801869 <sys_freeMem>
  801672:	83 c4 10             	add    $0x10,%esp
}
  801675:	90                   	nop
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sfree>:


void sfree(void* virtual_address)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  80167e:	83 ec 04             	sub    $0x4,%esp
  801681:	68 97 25 80 00       	push   $0x802597
  801686:	68 ac 00 00 00       	push   $0xac
  80168b:	68 6f 25 80 00       	push   $0x80256f
  801690:	e8 a3 ec ff ff       	call   800338 <_panic>

00801695 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
  801698:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80169b:	83 ec 04             	sub    $0x4,%esp
  80169e:	68 b4 25 80 00       	push   $0x8025b4
  8016a3:	68 c4 00 00 00       	push   $0xc4
  8016a8:	68 6f 25 80 00       	push   $0x80256f
  8016ad:	e8 86 ec ff ff       	call   800338 <_panic>

008016b2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
  8016b5:	57                   	push   %edi
  8016b6:	56                   	push   %esi
  8016b7:	53                   	push   %ebx
  8016b8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016c4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016c7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016ca:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016cd:	cd 30                	int    $0x30
  8016cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016d5:	83 c4 10             	add    $0x10,%esp
  8016d8:	5b                   	pop    %ebx
  8016d9:	5e                   	pop    %esi
  8016da:	5f                   	pop    %edi
  8016db:	5d                   	pop    %ebp
  8016dc:	c3                   	ret    

008016dd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
  8016e0:	83 ec 04             	sub    $0x4,%esp
  8016e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016e9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	52                   	push   %edx
  8016f5:	ff 75 0c             	pushl  0xc(%ebp)
  8016f8:	50                   	push   %eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	e8 b2 ff ff ff       	call   8016b2 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	90                   	nop
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_cgetc>:

int
sys_cgetc(void)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 01                	push   $0x1
  801715:	e8 98 ff ff ff       	call   8016b2 <syscall>
  80171a:	83 c4 18             	add    $0x18,%esp
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	50                   	push   %eax
  80172e:	6a 05                	push   $0x5
  801730:	e8 7d ff ff ff       	call   8016b2 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 02                	push   $0x2
  801749:	e8 64 ff ff ff       	call   8016b2 <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 03                	push   $0x3
  801762:	e8 4b ff ff ff       	call   8016b2 <syscall>
  801767:	83 c4 18             	add    $0x18,%esp
}
  80176a:	c9                   	leave  
  80176b:	c3                   	ret    

0080176c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 04                	push   $0x4
  80177b:	e8 32 ff ff ff       	call   8016b2 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_env_exit>:


void sys_env_exit(void)
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 06                	push   $0x6
  801794:	e8 19 ff ff ff       	call   8016b2 <syscall>
  801799:	83 c4 18             	add    $0x18,%esp
}
  80179c:	90                   	nop
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	52                   	push   %edx
  8017af:	50                   	push   %eax
  8017b0:	6a 07                	push   $0x7
  8017b2:	e8 fb fe ff ff       	call   8016b2 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
  8017bf:	56                   	push   %esi
  8017c0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017c1:	8b 75 18             	mov    0x18(%ebp),%esi
  8017c4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d0:	56                   	push   %esi
  8017d1:	53                   	push   %ebx
  8017d2:	51                   	push   %ecx
  8017d3:	52                   	push   %edx
  8017d4:	50                   	push   %eax
  8017d5:	6a 08                	push   $0x8
  8017d7:	e8 d6 fe ff ff       	call   8016b2 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017e2:	5b                   	pop    %ebx
  8017e3:	5e                   	pop    %esi
  8017e4:	5d                   	pop    %ebp
  8017e5:	c3                   	ret    

008017e6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	52                   	push   %edx
  8017f6:	50                   	push   %eax
  8017f7:	6a 09                	push   $0x9
  8017f9:	e8 b4 fe ff ff       	call   8016b2 <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
}
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	ff 75 0c             	pushl  0xc(%ebp)
  80180f:	ff 75 08             	pushl  0x8(%ebp)
  801812:	6a 0a                	push   $0xa
  801814:	e8 99 fe ff ff       	call   8016b2 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
}
  80181c:	c9                   	leave  
  80181d:	c3                   	ret    

0080181e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 0b                	push   $0xb
  80182d:	e8 80 fe ff ff       	call   8016b2 <syscall>
  801832:	83 c4 18             	add    $0x18,%esp
}
  801835:	c9                   	leave  
  801836:	c3                   	ret    

00801837 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801837:	55                   	push   %ebp
  801838:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 0c                	push   $0xc
  801846:	e8 67 fe ff ff       	call   8016b2 <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 0d                	push   $0xd
  80185f:	e8 4e fe ff ff       	call   8016b2 <syscall>
  801864:	83 c4 18             	add    $0x18,%esp
}
  801867:	c9                   	leave  
  801868:	c3                   	ret    

00801869 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801869:	55                   	push   %ebp
  80186a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	ff 75 0c             	pushl  0xc(%ebp)
  801875:	ff 75 08             	pushl  0x8(%ebp)
  801878:	6a 11                	push   $0x11
  80187a:	e8 33 fe ff ff       	call   8016b2 <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
	return;
  801882:	90                   	nop
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	ff 75 0c             	pushl  0xc(%ebp)
  801891:	ff 75 08             	pushl  0x8(%ebp)
  801894:	6a 12                	push   $0x12
  801896:	e8 17 fe ff ff       	call   8016b2 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
	return ;
  80189e:	90                   	nop
}
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 0e                	push   $0xe
  8018b0:	e8 fd fd ff ff       	call   8016b2 <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	ff 75 08             	pushl  0x8(%ebp)
  8018c8:	6a 0f                	push   $0xf
  8018ca:	e8 e3 fd ff ff       	call   8016b2 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
}
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 10                	push   $0x10
  8018e3:	e8 ca fd ff ff       	call   8016b2 <syscall>
  8018e8:	83 c4 18             	add    $0x18,%esp
}
  8018eb:	90                   	nop
  8018ec:	c9                   	leave  
  8018ed:	c3                   	ret    

008018ee <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8018ee:	55                   	push   %ebp
  8018ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 14                	push   $0x14
  8018fd:	e8 b0 fd ff ff       	call   8016b2 <syscall>
  801902:	83 c4 18             	add    $0x18,%esp
}
  801905:	90                   	nop
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 15                	push   $0x15
  801917:	e8 96 fd ff ff       	call   8016b2 <syscall>
  80191c:	83 c4 18             	add    $0x18,%esp
}
  80191f:	90                   	nop
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_cputc>:


void
sys_cputc(const char c)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	83 ec 04             	sub    $0x4,%esp
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80192e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	50                   	push   %eax
  80193b:	6a 16                	push   $0x16
  80193d:	e8 70 fd ff ff       	call   8016b2 <syscall>
  801942:	83 c4 18             	add    $0x18,%esp
}
  801945:	90                   	nop
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 17                	push   $0x17
  801957:	e8 56 fd ff ff       	call   8016b2 <syscall>
  80195c:	83 c4 18             	add    $0x18,%esp
}
  80195f:	90                   	nop
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801965:	8b 45 08             	mov    0x8(%ebp),%eax
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	ff 75 0c             	pushl  0xc(%ebp)
  801971:	50                   	push   %eax
  801972:	6a 18                	push   $0x18
  801974:	e8 39 fd ff ff       	call   8016b2 <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801981:	8b 55 0c             	mov    0xc(%ebp),%edx
  801984:	8b 45 08             	mov    0x8(%ebp),%eax
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	52                   	push   %edx
  80198e:	50                   	push   %eax
  80198f:	6a 1b                	push   $0x1b
  801991:	e8 1c fd ff ff       	call   8016b2 <syscall>
  801996:	83 c4 18             	add    $0x18,%esp
}
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80199e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	52                   	push   %edx
  8019ab:	50                   	push   %eax
  8019ac:	6a 19                	push   $0x19
  8019ae:	e8 ff fc ff ff       	call   8016b2 <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
}
  8019b6:	90                   	nop
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	52                   	push   %edx
  8019c9:	50                   	push   %eax
  8019ca:	6a 1a                	push   $0x1a
  8019cc:	e8 e1 fc ff ff       	call   8016b2 <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
}
  8019d4:	90                   	nop
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
  8019da:	83 ec 04             	sub    $0x4,%esp
  8019dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019e3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019e6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ed:	6a 00                	push   $0x0
  8019ef:	51                   	push   %ecx
  8019f0:	52                   	push   %edx
  8019f1:	ff 75 0c             	pushl  0xc(%ebp)
  8019f4:	50                   	push   %eax
  8019f5:	6a 1c                	push   $0x1c
  8019f7:	e8 b6 fc ff ff       	call   8016b2 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	52                   	push   %edx
  801a11:	50                   	push   %eax
  801a12:	6a 1d                	push   $0x1d
  801a14:	e8 99 fc ff ff       	call   8016b2 <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a21:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	51                   	push   %ecx
  801a2f:	52                   	push   %edx
  801a30:	50                   	push   %eax
  801a31:	6a 1e                	push   $0x1e
  801a33:	e8 7a fc ff ff       	call   8016b2 <syscall>
  801a38:	83 c4 18             	add    $0x18,%esp
}
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a43:	8b 45 08             	mov    0x8(%ebp),%eax
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	52                   	push   %edx
  801a4d:	50                   	push   %eax
  801a4e:	6a 1f                	push   $0x1f
  801a50:	e8 5d fc ff ff       	call   8016b2 <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 20                	push   $0x20
  801a69:	e8 44 fc ff ff       	call   8016b2 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	ff 75 10             	pushl  0x10(%ebp)
  801a80:	ff 75 0c             	pushl  0xc(%ebp)
  801a83:	50                   	push   %eax
  801a84:	6a 21                	push   $0x21
  801a86:	e8 27 fc ff ff       	call   8016b2 <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	50                   	push   %eax
  801a9f:	6a 22                	push   $0x22
  801aa1:	e8 0c fc ff ff       	call   8016b2 <syscall>
  801aa6:	83 c4 18             	add    $0x18,%esp
}
  801aa9:	90                   	nop
  801aaa:	c9                   	leave  
  801aab:	c3                   	ret    

00801aac <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801aac:	55                   	push   %ebp
  801aad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	50                   	push   %eax
  801abb:	6a 23                	push   $0x23
  801abd:	e8 f0 fb ff ff       	call   8016b2 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	90                   	nop
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
  801acb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ace:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ad1:	8d 50 04             	lea    0x4(%eax),%edx
  801ad4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	52                   	push   %edx
  801ade:	50                   	push   %eax
  801adf:	6a 24                	push   $0x24
  801ae1:	e8 cc fb ff ff       	call   8016b2 <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
	return result;
  801ae9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801aec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801af2:	89 01                	mov    %eax,(%ecx)
  801af4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	c9                   	leave  
  801afb:	c2 04 00             	ret    $0x4

00801afe <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	ff 75 10             	pushl  0x10(%ebp)
  801b08:	ff 75 0c             	pushl  0xc(%ebp)
  801b0b:	ff 75 08             	pushl  0x8(%ebp)
  801b0e:	6a 13                	push   $0x13
  801b10:	e8 9d fb ff ff       	call   8016b2 <syscall>
  801b15:	83 c4 18             	add    $0x18,%esp
	return ;
  801b18:	90                   	nop
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_rcr2>:
uint32 sys_rcr2()
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 25                	push   $0x25
  801b2a:	e8 83 fb ff ff       	call   8016b2 <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
  801b37:	83 ec 04             	sub    $0x4,%esp
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b40:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	50                   	push   %eax
  801b4d:	6a 26                	push   $0x26
  801b4f:	e8 5e fb ff ff       	call   8016b2 <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
	return ;
  801b57:	90                   	nop
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <rsttst>:
void rsttst()
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 28                	push   $0x28
  801b69:	e8 44 fb ff ff       	call   8016b2 <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b71:	90                   	nop
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
  801b77:	83 ec 04             	sub    $0x4,%esp
  801b7a:	8b 45 14             	mov    0x14(%ebp),%eax
  801b7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b80:	8b 55 18             	mov    0x18(%ebp),%edx
  801b83:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b87:	52                   	push   %edx
  801b88:	50                   	push   %eax
  801b89:	ff 75 10             	pushl  0x10(%ebp)
  801b8c:	ff 75 0c             	pushl  0xc(%ebp)
  801b8f:	ff 75 08             	pushl  0x8(%ebp)
  801b92:	6a 27                	push   $0x27
  801b94:	e8 19 fb ff ff       	call   8016b2 <syscall>
  801b99:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9c:	90                   	nop
}
  801b9d:	c9                   	leave  
  801b9e:	c3                   	ret    

00801b9f <chktst>:
void chktst(uint32 n)
{
  801b9f:	55                   	push   %ebp
  801ba0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	ff 75 08             	pushl  0x8(%ebp)
  801bad:	6a 29                	push   $0x29
  801baf:	e8 fe fa ff ff       	call   8016b2 <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb7:	90                   	nop
}
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <inctst>:

void inctst()
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 2a                	push   $0x2a
  801bc9:	e8 e4 fa ff ff       	call   8016b2 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd1:	90                   	nop
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <gettst>:
uint32 gettst()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 2b                	push   $0x2b
  801be3:	e8 ca fa ff ff       	call   8016b2 <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
}
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 2c                	push   $0x2c
  801bff:	e8 ae fa ff ff       	call   8016b2 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
  801c07:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c0a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c0e:	75 07                	jne    801c17 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c10:	b8 01 00 00 00       	mov    $0x1,%eax
  801c15:	eb 05                	jmp    801c1c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
  801c21:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 2c                	push   $0x2c
  801c30:	e8 7d fa ff ff       	call   8016b2 <syscall>
  801c35:	83 c4 18             	add    $0x18,%esp
  801c38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c3b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c3f:	75 07                	jne    801c48 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c41:	b8 01 00 00 00       	mov    $0x1,%eax
  801c46:	eb 05                	jmp    801c4d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
  801c52:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 2c                	push   $0x2c
  801c61:	e8 4c fa ff ff       	call   8016b2 <syscall>
  801c66:	83 c4 18             	add    $0x18,%esp
  801c69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c6c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c70:	75 07                	jne    801c79 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c72:	b8 01 00 00 00       	mov    $0x1,%eax
  801c77:	eb 05                	jmp    801c7e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c79:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c7e:	c9                   	leave  
  801c7f:	c3                   	ret    

00801c80 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
  801c83:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 2c                	push   $0x2c
  801c92:	e8 1b fa ff ff       	call   8016b2 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
  801c9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c9d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ca1:	75 07                	jne    801caa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ca3:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca8:	eb 05                	jmp    801caf <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801caa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	ff 75 08             	pushl  0x8(%ebp)
  801cbf:	6a 2d                	push   $0x2d
  801cc1:	e8 ec f9 ff ff       	call   8016b2 <syscall>
  801cc6:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc9:	90                   	nop
}
  801cca:	c9                   	leave  
  801ccb:	c3                   	ret    

00801ccc <__udivdi3>:
  801ccc:	55                   	push   %ebp
  801ccd:	57                   	push   %edi
  801cce:	56                   	push   %esi
  801ccf:	53                   	push   %ebx
  801cd0:	83 ec 1c             	sub    $0x1c,%esp
  801cd3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cd7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cdb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cdf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ce3:	89 ca                	mov    %ecx,%edx
  801ce5:	89 f8                	mov    %edi,%eax
  801ce7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ceb:	85 f6                	test   %esi,%esi
  801ced:	75 2d                	jne    801d1c <__udivdi3+0x50>
  801cef:	39 cf                	cmp    %ecx,%edi
  801cf1:	77 65                	ja     801d58 <__udivdi3+0x8c>
  801cf3:	89 fd                	mov    %edi,%ebp
  801cf5:	85 ff                	test   %edi,%edi
  801cf7:	75 0b                	jne    801d04 <__udivdi3+0x38>
  801cf9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfe:	31 d2                	xor    %edx,%edx
  801d00:	f7 f7                	div    %edi
  801d02:	89 c5                	mov    %eax,%ebp
  801d04:	31 d2                	xor    %edx,%edx
  801d06:	89 c8                	mov    %ecx,%eax
  801d08:	f7 f5                	div    %ebp
  801d0a:	89 c1                	mov    %eax,%ecx
  801d0c:	89 d8                	mov    %ebx,%eax
  801d0e:	f7 f5                	div    %ebp
  801d10:	89 cf                	mov    %ecx,%edi
  801d12:	89 fa                	mov    %edi,%edx
  801d14:	83 c4 1c             	add    $0x1c,%esp
  801d17:	5b                   	pop    %ebx
  801d18:	5e                   	pop    %esi
  801d19:	5f                   	pop    %edi
  801d1a:	5d                   	pop    %ebp
  801d1b:	c3                   	ret    
  801d1c:	39 ce                	cmp    %ecx,%esi
  801d1e:	77 28                	ja     801d48 <__udivdi3+0x7c>
  801d20:	0f bd fe             	bsr    %esi,%edi
  801d23:	83 f7 1f             	xor    $0x1f,%edi
  801d26:	75 40                	jne    801d68 <__udivdi3+0x9c>
  801d28:	39 ce                	cmp    %ecx,%esi
  801d2a:	72 0a                	jb     801d36 <__udivdi3+0x6a>
  801d2c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d30:	0f 87 9e 00 00 00    	ja     801dd4 <__udivdi3+0x108>
  801d36:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3b:	89 fa                	mov    %edi,%edx
  801d3d:	83 c4 1c             	add    $0x1c,%esp
  801d40:	5b                   	pop    %ebx
  801d41:	5e                   	pop    %esi
  801d42:	5f                   	pop    %edi
  801d43:	5d                   	pop    %ebp
  801d44:	c3                   	ret    
  801d45:	8d 76 00             	lea    0x0(%esi),%esi
  801d48:	31 ff                	xor    %edi,%edi
  801d4a:	31 c0                	xor    %eax,%eax
  801d4c:	89 fa                	mov    %edi,%edx
  801d4e:	83 c4 1c             	add    $0x1c,%esp
  801d51:	5b                   	pop    %ebx
  801d52:	5e                   	pop    %esi
  801d53:	5f                   	pop    %edi
  801d54:	5d                   	pop    %ebp
  801d55:	c3                   	ret    
  801d56:	66 90                	xchg   %ax,%ax
  801d58:	89 d8                	mov    %ebx,%eax
  801d5a:	f7 f7                	div    %edi
  801d5c:	31 ff                	xor    %edi,%edi
  801d5e:	89 fa                	mov    %edi,%edx
  801d60:	83 c4 1c             	add    $0x1c,%esp
  801d63:	5b                   	pop    %ebx
  801d64:	5e                   	pop    %esi
  801d65:	5f                   	pop    %edi
  801d66:	5d                   	pop    %ebp
  801d67:	c3                   	ret    
  801d68:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d6d:	89 eb                	mov    %ebp,%ebx
  801d6f:	29 fb                	sub    %edi,%ebx
  801d71:	89 f9                	mov    %edi,%ecx
  801d73:	d3 e6                	shl    %cl,%esi
  801d75:	89 c5                	mov    %eax,%ebp
  801d77:	88 d9                	mov    %bl,%cl
  801d79:	d3 ed                	shr    %cl,%ebp
  801d7b:	89 e9                	mov    %ebp,%ecx
  801d7d:	09 f1                	or     %esi,%ecx
  801d7f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d83:	89 f9                	mov    %edi,%ecx
  801d85:	d3 e0                	shl    %cl,%eax
  801d87:	89 c5                	mov    %eax,%ebp
  801d89:	89 d6                	mov    %edx,%esi
  801d8b:	88 d9                	mov    %bl,%cl
  801d8d:	d3 ee                	shr    %cl,%esi
  801d8f:	89 f9                	mov    %edi,%ecx
  801d91:	d3 e2                	shl    %cl,%edx
  801d93:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d97:	88 d9                	mov    %bl,%cl
  801d99:	d3 e8                	shr    %cl,%eax
  801d9b:	09 c2                	or     %eax,%edx
  801d9d:	89 d0                	mov    %edx,%eax
  801d9f:	89 f2                	mov    %esi,%edx
  801da1:	f7 74 24 0c          	divl   0xc(%esp)
  801da5:	89 d6                	mov    %edx,%esi
  801da7:	89 c3                	mov    %eax,%ebx
  801da9:	f7 e5                	mul    %ebp
  801dab:	39 d6                	cmp    %edx,%esi
  801dad:	72 19                	jb     801dc8 <__udivdi3+0xfc>
  801daf:	74 0b                	je     801dbc <__udivdi3+0xf0>
  801db1:	89 d8                	mov    %ebx,%eax
  801db3:	31 ff                	xor    %edi,%edi
  801db5:	e9 58 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801dba:	66 90                	xchg   %ax,%ax
  801dbc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dc0:	89 f9                	mov    %edi,%ecx
  801dc2:	d3 e2                	shl    %cl,%edx
  801dc4:	39 c2                	cmp    %eax,%edx
  801dc6:	73 e9                	jae    801db1 <__udivdi3+0xe5>
  801dc8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dcb:	31 ff                	xor    %edi,%edi
  801dcd:	e9 40 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801dd2:	66 90                	xchg   %ax,%ax
  801dd4:	31 c0                	xor    %eax,%eax
  801dd6:	e9 37 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801ddb:	90                   	nop

00801ddc <__umoddi3>:
  801ddc:	55                   	push   %ebp
  801ddd:	57                   	push   %edi
  801dde:	56                   	push   %esi
  801ddf:	53                   	push   %ebx
  801de0:	83 ec 1c             	sub    $0x1c,%esp
  801de3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801de7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801deb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801def:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801df3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801df7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dfb:	89 f3                	mov    %esi,%ebx
  801dfd:	89 fa                	mov    %edi,%edx
  801dff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e03:	89 34 24             	mov    %esi,(%esp)
  801e06:	85 c0                	test   %eax,%eax
  801e08:	75 1a                	jne    801e24 <__umoddi3+0x48>
  801e0a:	39 f7                	cmp    %esi,%edi
  801e0c:	0f 86 a2 00 00 00    	jbe    801eb4 <__umoddi3+0xd8>
  801e12:	89 c8                	mov    %ecx,%eax
  801e14:	89 f2                	mov    %esi,%edx
  801e16:	f7 f7                	div    %edi
  801e18:	89 d0                	mov    %edx,%eax
  801e1a:	31 d2                	xor    %edx,%edx
  801e1c:	83 c4 1c             	add    $0x1c,%esp
  801e1f:	5b                   	pop    %ebx
  801e20:	5e                   	pop    %esi
  801e21:	5f                   	pop    %edi
  801e22:	5d                   	pop    %ebp
  801e23:	c3                   	ret    
  801e24:	39 f0                	cmp    %esi,%eax
  801e26:	0f 87 ac 00 00 00    	ja     801ed8 <__umoddi3+0xfc>
  801e2c:	0f bd e8             	bsr    %eax,%ebp
  801e2f:	83 f5 1f             	xor    $0x1f,%ebp
  801e32:	0f 84 ac 00 00 00    	je     801ee4 <__umoddi3+0x108>
  801e38:	bf 20 00 00 00       	mov    $0x20,%edi
  801e3d:	29 ef                	sub    %ebp,%edi
  801e3f:	89 fe                	mov    %edi,%esi
  801e41:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e45:	89 e9                	mov    %ebp,%ecx
  801e47:	d3 e0                	shl    %cl,%eax
  801e49:	89 d7                	mov    %edx,%edi
  801e4b:	89 f1                	mov    %esi,%ecx
  801e4d:	d3 ef                	shr    %cl,%edi
  801e4f:	09 c7                	or     %eax,%edi
  801e51:	89 e9                	mov    %ebp,%ecx
  801e53:	d3 e2                	shl    %cl,%edx
  801e55:	89 14 24             	mov    %edx,(%esp)
  801e58:	89 d8                	mov    %ebx,%eax
  801e5a:	d3 e0                	shl    %cl,%eax
  801e5c:	89 c2                	mov    %eax,%edx
  801e5e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e62:	d3 e0                	shl    %cl,%eax
  801e64:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e68:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6c:	89 f1                	mov    %esi,%ecx
  801e6e:	d3 e8                	shr    %cl,%eax
  801e70:	09 d0                	or     %edx,%eax
  801e72:	d3 eb                	shr    %cl,%ebx
  801e74:	89 da                	mov    %ebx,%edx
  801e76:	f7 f7                	div    %edi
  801e78:	89 d3                	mov    %edx,%ebx
  801e7a:	f7 24 24             	mull   (%esp)
  801e7d:	89 c6                	mov    %eax,%esi
  801e7f:	89 d1                	mov    %edx,%ecx
  801e81:	39 d3                	cmp    %edx,%ebx
  801e83:	0f 82 87 00 00 00    	jb     801f10 <__umoddi3+0x134>
  801e89:	0f 84 91 00 00 00    	je     801f20 <__umoddi3+0x144>
  801e8f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e93:	29 f2                	sub    %esi,%edx
  801e95:	19 cb                	sbb    %ecx,%ebx
  801e97:	89 d8                	mov    %ebx,%eax
  801e99:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e9d:	d3 e0                	shl    %cl,%eax
  801e9f:	89 e9                	mov    %ebp,%ecx
  801ea1:	d3 ea                	shr    %cl,%edx
  801ea3:	09 d0                	or     %edx,%eax
  801ea5:	89 e9                	mov    %ebp,%ecx
  801ea7:	d3 eb                	shr    %cl,%ebx
  801ea9:	89 da                	mov    %ebx,%edx
  801eab:	83 c4 1c             	add    $0x1c,%esp
  801eae:	5b                   	pop    %ebx
  801eaf:	5e                   	pop    %esi
  801eb0:	5f                   	pop    %edi
  801eb1:	5d                   	pop    %ebp
  801eb2:	c3                   	ret    
  801eb3:	90                   	nop
  801eb4:	89 fd                	mov    %edi,%ebp
  801eb6:	85 ff                	test   %edi,%edi
  801eb8:	75 0b                	jne    801ec5 <__umoddi3+0xe9>
  801eba:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebf:	31 d2                	xor    %edx,%edx
  801ec1:	f7 f7                	div    %edi
  801ec3:	89 c5                	mov    %eax,%ebp
  801ec5:	89 f0                	mov    %esi,%eax
  801ec7:	31 d2                	xor    %edx,%edx
  801ec9:	f7 f5                	div    %ebp
  801ecb:	89 c8                	mov    %ecx,%eax
  801ecd:	f7 f5                	div    %ebp
  801ecf:	89 d0                	mov    %edx,%eax
  801ed1:	e9 44 ff ff ff       	jmp    801e1a <__umoddi3+0x3e>
  801ed6:	66 90                	xchg   %ax,%ax
  801ed8:	89 c8                	mov    %ecx,%eax
  801eda:	89 f2                	mov    %esi,%edx
  801edc:	83 c4 1c             	add    $0x1c,%esp
  801edf:	5b                   	pop    %ebx
  801ee0:	5e                   	pop    %esi
  801ee1:	5f                   	pop    %edi
  801ee2:	5d                   	pop    %ebp
  801ee3:	c3                   	ret    
  801ee4:	3b 04 24             	cmp    (%esp),%eax
  801ee7:	72 06                	jb     801eef <__umoddi3+0x113>
  801ee9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801eed:	77 0f                	ja     801efe <__umoddi3+0x122>
  801eef:	89 f2                	mov    %esi,%edx
  801ef1:	29 f9                	sub    %edi,%ecx
  801ef3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ef7:	89 14 24             	mov    %edx,(%esp)
  801efa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801efe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f02:	8b 14 24             	mov    (%esp),%edx
  801f05:	83 c4 1c             	add    $0x1c,%esp
  801f08:	5b                   	pop    %ebx
  801f09:	5e                   	pop    %esi
  801f0a:	5f                   	pop    %edi
  801f0b:	5d                   	pop    %ebp
  801f0c:	c3                   	ret    
  801f0d:	8d 76 00             	lea    0x0(%esi),%esi
  801f10:	2b 04 24             	sub    (%esp),%eax
  801f13:	19 fa                	sbb    %edi,%edx
  801f15:	89 d1                	mov    %edx,%ecx
  801f17:	89 c6                	mov    %eax,%esi
  801f19:	e9 71 ff ff ff       	jmp    801e8f <__umoddi3+0xb3>
  801f1e:	66 90                	xchg   %ax,%ax
  801f20:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f24:	72 ea                	jb     801f10 <__umoddi3+0x134>
  801f26:	89 d9                	mov    %ebx,%ecx
  801f28:	e9 62 ff ff ff       	jmp    801e8f <__umoddi3+0xb3>
