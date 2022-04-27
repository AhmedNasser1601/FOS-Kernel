
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
  800066:	e8 0b 13 00 00       	call   801376 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 fa 12 00 00       	call   801376 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 80 15 00 00       	call   801607 <sys_pf_calculate_allocated_pages>
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
  8000d1:	e8 f4 12 00 00       	call   8013ca <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 e6 12 00 00       	call   8013ca <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 98 14 00 00       	call   801584 <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 7c 12 00 00       	call   801376 <malloc>
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
  800144:	bb 60 1d 80 00       	mov    $0x801d60,%ebx
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
  800176:	a1 04 30 80 00       	mov    0x803004,%eax
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
  8001ac:	a1 04 30 80 00       	mov    0x803004,%eax
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
  8001c4:	68 a0 1c 80 00       	push   $0x801ca0
  8001c9:	6a 41                	push   $0x41
  8001cb:	68 d8 1c 80 00       	push   $0x801cd8
  8001d0:	e8 63 01 00 00       	call   800338 <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001d5:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d8:	a1 04 30 80 00       	mov    0x803004,%eax
  8001dd:	8b 50 74             	mov    0x74(%eax),%edx
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	39 c2                	cmp    %eax,%edx
  8001e5:	0f 87 74 ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001eb:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001ee:	e8 91 13 00 00       	call   801584 <sys_calculate_free_frames>
  8001f3:	29 c3                	sub    %eax,%ebx
  8001f5:	89 d8                	mov    %ebx,%eax
  8001f7:	83 f8 08             	cmp    $0x8,%eax
  8001fa:	74 14                	je     800210 <_main+0x1d8>
  8001fc:	83 ec 04             	sub    $0x4,%esp
  8001ff:	68 ec 1c 80 00       	push   $0x801cec
  800204:	6a 45                	push   $0x45
  800206:	68 d8 1c 80 00       	push   $0x801cd8
  80020b:	e8 28 01 00 00       	call   800338 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 14 1d 80 00       	push   $0x801d14
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
  80022f:	e8 85 12 00 00       	call   8014b9 <sys_getenvindex>
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
  80025a:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80025f:	a1 04 30 80 00       	mov    0x803004,%eax
  800264:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80026a:	84 c0                	test   %al,%al
  80026c:	74 0f                	je     80027d <libmain+0x54>
		binaryname = myEnv->prog_name;
  80026e:	a1 04 30 80 00       	mov    0x803004,%eax
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
  80029e:	e8 b1 13 00 00       	call   801654 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8002a3:	83 ec 0c             	sub    $0xc,%esp
  8002a6:	68 98 1d 80 00       	push   $0x801d98
  8002ab:	e8 3c 03 00 00       	call   8005ec <cprintf>
  8002b0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002b3:	a1 04 30 80 00       	mov    0x803004,%eax
  8002b8:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8002be:	a1 04 30 80 00       	mov    0x803004,%eax
  8002c3:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8002c9:	83 ec 04             	sub    $0x4,%esp
  8002cc:	52                   	push   %edx
  8002cd:	50                   	push   %eax
  8002ce:	68 c0 1d 80 00       	push   $0x801dc0
  8002d3:	e8 14 03 00 00       	call   8005ec <cprintf>
  8002d8:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002db:	a1 04 30 80 00       	mov    0x803004,%eax
  8002e0:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8002e6:	83 ec 08             	sub    $0x8,%esp
  8002e9:	50                   	push   %eax
  8002ea:	68 e5 1d 80 00       	push   $0x801de5
  8002ef:	e8 f8 02 00 00       	call   8005ec <cprintf>
  8002f4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002f7:	83 ec 0c             	sub    $0xc,%esp
  8002fa:	68 98 1d 80 00       	push   $0x801d98
  8002ff:	e8 e8 02 00 00       	call   8005ec <cprintf>
  800304:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800307:	e8 62 13 00 00       	call   80166e <sys_enable_interrupt>

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
  80031f:	e8 61 11 00 00       	call   801485 <sys_env_destroy>
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
  800330:	e8 b6 11 00 00       	call   8014eb <sys_env_exit>
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
  800347:	a1 14 30 80 00       	mov    0x803014,%eax
  80034c:	85 c0                	test   %eax,%eax
  80034e:	74 16                	je     800366 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800350:	a1 14 30 80 00       	mov    0x803014,%eax
  800355:	83 ec 08             	sub    $0x8,%esp
  800358:	50                   	push   %eax
  800359:	68 fc 1d 80 00       	push   $0x801dfc
  80035e:	e8 89 02 00 00       	call   8005ec <cprintf>
  800363:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800366:	a1 00 30 80 00       	mov    0x803000,%eax
  80036b:	ff 75 0c             	pushl  0xc(%ebp)
  80036e:	ff 75 08             	pushl  0x8(%ebp)
  800371:	50                   	push   %eax
  800372:	68 01 1e 80 00       	push   $0x801e01
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
  800396:	68 1d 1e 80 00       	push   $0x801e1d
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
  8003b0:	a1 04 30 80 00       	mov    0x803004,%eax
  8003b5:	8b 50 74             	mov    0x74(%eax),%edx
  8003b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003bb:	39 c2                	cmp    %eax,%edx
  8003bd:	74 14                	je     8003d3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003bf:	83 ec 04             	sub    $0x4,%esp
  8003c2:	68 20 1e 80 00       	push   $0x801e20
  8003c7:	6a 26                	push   $0x26
  8003c9:	68 6c 1e 80 00       	push   $0x801e6c
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
  800413:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800433:	a1 04 30 80 00       	mov    0x803004,%eax
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
  80047c:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800494:	68 78 1e 80 00       	push   $0x801e78
  800499:	6a 3a                	push   $0x3a
  80049b:	68 6c 1e 80 00       	push   $0x801e6c
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
  8004c4:	a1 04 30 80 00       	mov    0x803004,%eax
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
  8004ea:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800504:	68 cc 1e 80 00       	push   $0x801ecc
  800509:	6a 44                	push   $0x44
  80050b:	68 6c 1e 80 00       	push   $0x801e6c
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
  800543:	a0 08 30 80 00       	mov    0x803008,%al
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
  80055e:	e8 e0 0e 00 00       	call   801443 <sys_cputs>
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
  8005b8:	a0 08 30 80 00       	mov    0x803008,%al
  8005bd:	0f b6 c0             	movzbl %al,%eax
  8005c0:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005c6:	83 ec 04             	sub    $0x4,%esp
  8005c9:	50                   	push   %eax
  8005ca:	52                   	push   %edx
  8005cb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005d1:	83 c0 08             	add    $0x8,%eax
  8005d4:	50                   	push   %eax
  8005d5:	e8 69 0e 00 00       	call   801443 <sys_cputs>
  8005da:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005dd:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
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
  8005f2:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
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
  80061f:	e8 30 10 00 00       	call   801654 <sys_disable_interrupt>
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
  80063f:	e8 2a 10 00 00       	call   80166e <sys_enable_interrupt>
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
  800689:	e8 a6 13 00 00       	call   801a34 <__udivdi3>
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
  8006d9:	e8 66 14 00 00       	call   801b44 <__umoddi3>
  8006de:	83 c4 10             	add    $0x10,%esp
  8006e1:	05 34 21 80 00       	add    $0x802134,%eax
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
  800834:	8b 04 85 58 21 80 00 	mov    0x802158(,%eax,4),%eax
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
  800915:	8b 34 9d a0 1f 80 00 	mov    0x801fa0(,%ebx,4),%esi
  80091c:	85 f6                	test   %esi,%esi
  80091e:	75 19                	jne    800939 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800920:	53                   	push   %ebx
  800921:	68 45 21 80 00       	push   $0x802145
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
  80093a:	68 4e 21 80 00       	push   $0x80214e
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
  800967:	be 51 21 80 00       	mov    $0x802151,%esi
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

00801376 <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
  801379:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80137c:	83 ec 04             	sub    $0x4,%esp
  80137f:	68 b0 22 80 00       	push   $0x8022b0
  801384:	6a 19                	push   $0x19
  801386:	68 d5 22 80 00       	push   $0x8022d5
  80138b:	e8 a8 ef ff ff       	call   800338 <_panic>

00801390 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
  801393:	83 ec 18             	sub    $0x18,%esp
  801396:	8b 45 10             	mov    0x10(%ebp),%eax
  801399:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  80139c:	83 ec 04             	sub    $0x4,%esp
  80139f:	68 e4 22 80 00       	push   $0x8022e4
  8013a4:	6a 30                	push   $0x30
  8013a6:	68 d5 22 80 00       	push   $0x8022d5
  8013ab:	e8 88 ef ff ff       	call   800338 <_panic>

008013b0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
  8013b3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8013b6:	83 ec 04             	sub    $0x4,%esp
  8013b9:	68 03 23 80 00       	push   $0x802303
  8013be:	6a 36                	push   $0x36
  8013c0:	68 d5 22 80 00       	push   $0x8022d5
  8013c5:	e8 6e ef ff ff       	call   800338 <_panic>

008013ca <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
  8013cd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8013d0:	83 ec 04             	sub    $0x4,%esp
  8013d3:	68 20 23 80 00       	push   $0x802320
  8013d8:	6a 48                	push   $0x48
  8013da:	68 d5 22 80 00       	push   $0x8022d5
  8013df:	e8 54 ef ff ff       	call   800338 <_panic>

008013e4 <sfree>:

}


void sfree(void* virtual_address)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
  8013e7:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8013ea:	83 ec 04             	sub    $0x4,%esp
  8013ed:	68 43 23 80 00       	push   $0x802343
  8013f2:	6a 53                	push   $0x53
  8013f4:	68 d5 22 80 00       	push   $0x8022d5
  8013f9:	e8 3a ef ff ff       	call   800338 <_panic>

008013fe <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
  801401:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801404:	83 ec 04             	sub    $0x4,%esp
  801407:	68 60 23 80 00       	push   $0x802360
  80140c:	6a 6c                	push   $0x6c
  80140e:	68 d5 22 80 00       	push   $0x8022d5
  801413:	e8 20 ef ff ff       	call   800338 <_panic>

00801418 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	57                   	push   %edi
  80141c:	56                   	push   %esi
  80141d:	53                   	push   %ebx
  80141e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8b 55 0c             	mov    0xc(%ebp),%edx
  801427:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80142a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80142d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801430:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801433:	cd 30                	int    $0x30
  801435:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801438:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80143b:	83 c4 10             	add    $0x10,%esp
  80143e:	5b                   	pop    %ebx
  80143f:	5e                   	pop    %esi
  801440:	5f                   	pop    %edi
  801441:	5d                   	pop    %ebp
  801442:	c3                   	ret    

00801443 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
  801446:	83 ec 04             	sub    $0x4,%esp
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80144f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	52                   	push   %edx
  80145b:	ff 75 0c             	pushl  0xc(%ebp)
  80145e:	50                   	push   %eax
  80145f:	6a 00                	push   $0x0
  801461:	e8 b2 ff ff ff       	call   801418 <syscall>
  801466:	83 c4 18             	add    $0x18,%esp
}
  801469:	90                   	nop
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_cgetc>:

int
sys_cgetc(void)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 01                	push   $0x1
  80147b:	e8 98 ff ff ff       	call   801418 <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	50                   	push   %eax
  801494:	6a 05                	push   $0x5
  801496:	e8 7d ff ff ff       	call   801418 <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
}
  80149e:	c9                   	leave  
  80149f:	c3                   	ret    

008014a0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 02                	push   $0x2
  8014af:	e8 64 ff ff ff       	call   801418 <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 03                	push   $0x3
  8014c8:	e8 4b ff ff ff       	call   801418 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 04                	push   $0x4
  8014e1:	e8 32 ff ff ff       	call   801418 <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
}
  8014e9:	c9                   	leave  
  8014ea:	c3                   	ret    

008014eb <sys_env_exit>:


void sys_env_exit(void)
{
  8014eb:	55                   	push   %ebp
  8014ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 06                	push   $0x6
  8014fa:	e8 19 ff ff ff       	call   801418 <syscall>
  8014ff:	83 c4 18             	add    $0x18,%esp
}
  801502:	90                   	nop
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	52                   	push   %edx
  801515:	50                   	push   %eax
  801516:	6a 07                	push   $0x7
  801518:	e8 fb fe ff ff       	call   801418 <syscall>
  80151d:	83 c4 18             	add    $0x18,%esp
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
  801525:	56                   	push   %esi
  801526:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801527:	8b 75 18             	mov    0x18(%ebp),%esi
  80152a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80152d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	56                   	push   %esi
  801537:	53                   	push   %ebx
  801538:	51                   	push   %ecx
  801539:	52                   	push   %edx
  80153a:	50                   	push   %eax
  80153b:	6a 08                	push   $0x8
  80153d:	e8 d6 fe ff ff       	call   801418 <syscall>
  801542:	83 c4 18             	add    $0x18,%esp
}
  801545:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801548:	5b                   	pop    %ebx
  801549:	5e                   	pop    %esi
  80154a:	5d                   	pop    %ebp
  80154b:	c3                   	ret    

0080154c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80154f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	52                   	push   %edx
  80155c:	50                   	push   %eax
  80155d:	6a 09                	push   $0x9
  80155f:	e8 b4 fe ff ff       	call   801418 <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	ff 75 0c             	pushl  0xc(%ebp)
  801575:	ff 75 08             	pushl  0x8(%ebp)
  801578:	6a 0a                	push   $0xa
  80157a:	e8 99 fe ff ff       	call   801418 <syscall>
  80157f:	83 c4 18             	add    $0x18,%esp
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 0b                	push   $0xb
  801593:	e8 80 fe ff ff       	call   801418 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 0c                	push   $0xc
  8015ac:	e8 67 fe ff ff       	call   801418 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 0d                	push   $0xd
  8015c5:	e8 4e fe ff ff       	call   801418 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	ff 75 0c             	pushl  0xc(%ebp)
  8015db:	ff 75 08             	pushl  0x8(%ebp)
  8015de:	6a 11                	push   $0x11
  8015e0:	e8 33 fe ff ff       	call   801418 <syscall>
  8015e5:	83 c4 18             	add    $0x18,%esp
	return;
  8015e8:	90                   	nop
}
  8015e9:	c9                   	leave  
  8015ea:	c3                   	ret    

008015eb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015eb:	55                   	push   %ebp
  8015ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	ff 75 0c             	pushl  0xc(%ebp)
  8015f7:	ff 75 08             	pushl  0x8(%ebp)
  8015fa:	6a 12                	push   $0x12
  8015fc:	e8 17 fe ff ff       	call   801418 <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
	return ;
  801604:	90                   	nop
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 0e                	push   $0xe
  801616:	e8 fd fd ff ff       	call   801418 <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	ff 75 08             	pushl  0x8(%ebp)
  80162e:	6a 0f                	push   $0xf
  801630:	e8 e3 fd ff ff       	call   801418 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 10                	push   $0x10
  801649:	e8 ca fd ff ff       	call   801418 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	90                   	nop
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 14                	push   $0x14
  801663:	e8 b0 fd ff ff       	call   801418 <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	90                   	nop
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 15                	push   $0x15
  80167d:	e8 96 fd ff ff       	call   801418 <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	90                   	nop
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_cputc>:


void
sys_cputc(const char c)
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
  80168b:	83 ec 04             	sub    $0x4,%esp
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801694:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	50                   	push   %eax
  8016a1:	6a 16                	push   $0x16
  8016a3:	e8 70 fd ff ff       	call   801418 <syscall>
  8016a8:	83 c4 18             	add    $0x18,%esp
}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 17                	push   $0x17
  8016bd:	e8 56 fd ff ff       	call   801418 <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	90                   	nop
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	ff 75 0c             	pushl  0xc(%ebp)
  8016d7:	50                   	push   %eax
  8016d8:	6a 18                	push   $0x18
  8016da:	e8 39 fd ff ff       	call   801418 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	52                   	push   %edx
  8016f4:	50                   	push   %eax
  8016f5:	6a 1b                	push   $0x1b
  8016f7:	e8 1c fd ff ff       	call   801418 <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801704:	8b 55 0c             	mov    0xc(%ebp),%edx
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	52                   	push   %edx
  801711:	50                   	push   %eax
  801712:	6a 19                	push   $0x19
  801714:	e8 ff fc ff ff       	call   801418 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	90                   	nop
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801722:	8b 55 0c             	mov    0xc(%ebp),%edx
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	52                   	push   %edx
  80172f:	50                   	push   %eax
  801730:	6a 1a                	push   $0x1a
  801732:	e8 e1 fc ff ff       	call   801418 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	90                   	nop
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
  801740:	83 ec 04             	sub    $0x4,%esp
  801743:	8b 45 10             	mov    0x10(%ebp),%eax
  801746:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801749:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80174c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	6a 00                	push   $0x0
  801755:	51                   	push   %ecx
  801756:	52                   	push   %edx
  801757:	ff 75 0c             	pushl  0xc(%ebp)
  80175a:	50                   	push   %eax
  80175b:	6a 1c                	push   $0x1c
  80175d:	e8 b6 fc ff ff       	call   801418 <syscall>
  801762:	83 c4 18             	add    $0x18,%esp
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    

00801767 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80176a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	52                   	push   %edx
  801777:	50                   	push   %eax
  801778:	6a 1d                	push   $0x1d
  80177a:	e8 99 fc ff ff       	call   801418 <syscall>
  80177f:	83 c4 18             	add    $0x18,%esp
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801787:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80178a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	51                   	push   %ecx
  801795:	52                   	push   %edx
  801796:	50                   	push   %eax
  801797:	6a 1e                	push   $0x1e
  801799:	e8 7a fc ff ff       	call   801418 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	52                   	push   %edx
  8017b3:	50                   	push   %eax
  8017b4:	6a 1f                	push   $0x1f
  8017b6:	e8 5d fc ff ff       	call   801418 <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 20                	push   $0x20
  8017cf:	e8 44 fc ff ff       	call   801418 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	ff 75 10             	pushl  0x10(%ebp)
  8017e6:	ff 75 0c             	pushl  0xc(%ebp)
  8017e9:	50                   	push   %eax
  8017ea:	6a 21                	push   $0x21
  8017ec:	e8 27 fc ff ff       	call   801418 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	50                   	push   %eax
  801805:	6a 22                	push   $0x22
  801807:	e8 0c fc ff ff       	call   801418 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	90                   	nop
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	50                   	push   %eax
  801821:	6a 23                	push   $0x23
  801823:	e8 f0 fb ff ff       	call   801418 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	90                   	nop
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801834:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801837:	8d 50 04             	lea    0x4(%eax),%edx
  80183a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	52                   	push   %edx
  801844:	50                   	push   %eax
  801845:	6a 24                	push   $0x24
  801847:	e8 cc fb ff ff       	call   801418 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
	return result;
  80184f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801852:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801855:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801858:	89 01                	mov    %eax,(%ecx)
  80185a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	c9                   	leave  
  801861:	c2 04 00             	ret    $0x4

00801864 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	ff 75 10             	pushl  0x10(%ebp)
  80186e:	ff 75 0c             	pushl  0xc(%ebp)
  801871:	ff 75 08             	pushl  0x8(%ebp)
  801874:	6a 13                	push   $0x13
  801876:	e8 9d fb ff ff       	call   801418 <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
	return ;
  80187e:	90                   	nop
}
  80187f:	c9                   	leave  
  801880:	c3                   	ret    

00801881 <sys_rcr2>:
uint32 sys_rcr2()
{
  801881:	55                   	push   %ebp
  801882:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 25                	push   $0x25
  801890:	e8 83 fb ff ff       	call   801418 <syscall>
  801895:	83 c4 18             	add    $0x18,%esp
}
  801898:	c9                   	leave  
  801899:	c3                   	ret    

0080189a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80189a:	55                   	push   %ebp
  80189b:	89 e5                	mov    %esp,%ebp
  80189d:	83 ec 04             	sub    $0x4,%esp
  8018a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018a6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	50                   	push   %eax
  8018b3:	6a 26                	push   $0x26
  8018b5:	e8 5e fb ff ff       	call   801418 <syscall>
  8018ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8018bd:	90                   	nop
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <rsttst>:
void rsttst()
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 28                	push   $0x28
  8018cf:	e8 44 fb ff ff       	call   801418 <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d7:	90                   	nop
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
  8018dd:	83 ec 04             	sub    $0x4,%esp
  8018e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018e6:	8b 55 18             	mov    0x18(%ebp),%edx
  8018e9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018ed:	52                   	push   %edx
  8018ee:	50                   	push   %eax
  8018ef:	ff 75 10             	pushl  0x10(%ebp)
  8018f2:	ff 75 0c             	pushl  0xc(%ebp)
  8018f5:	ff 75 08             	pushl  0x8(%ebp)
  8018f8:	6a 27                	push   $0x27
  8018fa:	e8 19 fb ff ff       	call   801418 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801902:	90                   	nop
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <chktst>:
void chktst(uint32 n)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	ff 75 08             	pushl  0x8(%ebp)
  801913:	6a 29                	push   $0x29
  801915:	e8 fe fa ff ff       	call   801418 <syscall>
  80191a:	83 c4 18             	add    $0x18,%esp
	return ;
  80191d:	90                   	nop
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <inctst>:

void inctst()
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 2a                	push   $0x2a
  80192f:	e8 e4 fa ff ff       	call   801418 <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
	return ;
  801937:	90                   	nop
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <gettst>:
uint32 gettst()
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 2b                	push   $0x2b
  801949:	e8 ca fa ff ff       	call   801418 <syscall>
  80194e:	83 c4 18             	add    $0x18,%esp
}
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
  801956:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 2c                	push   $0x2c
  801965:	e8 ae fa ff ff       	call   801418 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
  80196d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801970:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801974:	75 07                	jne    80197d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801976:	b8 01 00 00 00       	mov    $0x1,%eax
  80197b:	eb 05                	jmp    801982 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80197d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
  801987:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 2c                	push   $0x2c
  801996:	e8 7d fa ff ff       	call   801418 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
  80199e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019a1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019a5:	75 07                	jne    8019ae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ac:	eb 05                	jmp    8019b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
  8019b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 2c                	push   $0x2c
  8019c7:	e8 4c fa ff ff       	call   801418 <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
  8019cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019d2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019d6:	75 07                	jne    8019df <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8019dd:	eb 05                	jmp    8019e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
  8019e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 2c                	push   $0x2c
  8019f8:	e8 1b fa ff ff       	call   801418 <syscall>
  8019fd:	83 c4 18             	add    $0x18,%esp
  801a00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a03:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a07:	75 07                	jne    801a10 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a09:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0e:	eb 05                	jmp    801a15 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	ff 75 08             	pushl  0x8(%ebp)
  801a25:	6a 2d                	push   $0x2d
  801a27:	e8 ec f9 ff ff       	call   801418 <syscall>
  801a2c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2f:	90                   	nop
}
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    
  801a32:	66 90                	xchg   %ax,%ax

00801a34 <__udivdi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4b:	89 ca                	mov    %ecx,%edx
  801a4d:	89 f8                	mov    %edi,%eax
  801a4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a53:	85 f6                	test   %esi,%esi
  801a55:	75 2d                	jne    801a84 <__udivdi3+0x50>
  801a57:	39 cf                	cmp    %ecx,%edi
  801a59:	77 65                	ja     801ac0 <__udivdi3+0x8c>
  801a5b:	89 fd                	mov    %edi,%ebp
  801a5d:	85 ff                	test   %edi,%edi
  801a5f:	75 0b                	jne    801a6c <__udivdi3+0x38>
  801a61:	b8 01 00 00 00       	mov    $0x1,%eax
  801a66:	31 d2                	xor    %edx,%edx
  801a68:	f7 f7                	div    %edi
  801a6a:	89 c5                	mov    %eax,%ebp
  801a6c:	31 d2                	xor    %edx,%edx
  801a6e:	89 c8                	mov    %ecx,%eax
  801a70:	f7 f5                	div    %ebp
  801a72:	89 c1                	mov    %eax,%ecx
  801a74:	89 d8                	mov    %ebx,%eax
  801a76:	f7 f5                	div    %ebp
  801a78:	89 cf                	mov    %ecx,%edi
  801a7a:	89 fa                	mov    %edi,%edx
  801a7c:	83 c4 1c             	add    $0x1c,%esp
  801a7f:	5b                   	pop    %ebx
  801a80:	5e                   	pop    %esi
  801a81:	5f                   	pop    %edi
  801a82:	5d                   	pop    %ebp
  801a83:	c3                   	ret    
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	77 28                	ja     801ab0 <__udivdi3+0x7c>
  801a88:	0f bd fe             	bsr    %esi,%edi
  801a8b:	83 f7 1f             	xor    $0x1f,%edi
  801a8e:	75 40                	jne    801ad0 <__udivdi3+0x9c>
  801a90:	39 ce                	cmp    %ecx,%esi
  801a92:	72 0a                	jb     801a9e <__udivdi3+0x6a>
  801a94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a98:	0f 87 9e 00 00 00    	ja     801b3c <__udivdi3+0x108>
  801a9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa3:	89 fa                	mov    %edi,%edx
  801aa5:	83 c4 1c             	add    $0x1c,%esp
  801aa8:	5b                   	pop    %ebx
  801aa9:	5e                   	pop    %esi
  801aaa:	5f                   	pop    %edi
  801aab:	5d                   	pop    %ebp
  801aac:	c3                   	ret    
  801aad:	8d 76 00             	lea    0x0(%esi),%esi
  801ab0:	31 ff                	xor    %edi,%edi
  801ab2:	31 c0                	xor    %eax,%eax
  801ab4:	89 fa                	mov    %edi,%edx
  801ab6:	83 c4 1c             	add    $0x1c,%esp
  801ab9:	5b                   	pop    %ebx
  801aba:	5e                   	pop    %esi
  801abb:	5f                   	pop    %edi
  801abc:	5d                   	pop    %ebp
  801abd:	c3                   	ret    
  801abe:	66 90                	xchg   %ax,%ax
  801ac0:	89 d8                	mov    %ebx,%eax
  801ac2:	f7 f7                	div    %edi
  801ac4:	31 ff                	xor    %edi,%edi
  801ac6:	89 fa                	mov    %edi,%edx
  801ac8:	83 c4 1c             	add    $0x1c,%esp
  801acb:	5b                   	pop    %ebx
  801acc:	5e                   	pop    %esi
  801acd:	5f                   	pop    %edi
  801ace:	5d                   	pop    %ebp
  801acf:	c3                   	ret    
  801ad0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad5:	89 eb                	mov    %ebp,%ebx
  801ad7:	29 fb                	sub    %edi,%ebx
  801ad9:	89 f9                	mov    %edi,%ecx
  801adb:	d3 e6                	shl    %cl,%esi
  801add:	89 c5                	mov    %eax,%ebp
  801adf:	88 d9                	mov    %bl,%cl
  801ae1:	d3 ed                	shr    %cl,%ebp
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	09 f1                	or     %esi,%ecx
  801ae7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e0                	shl    %cl,%eax
  801aef:	89 c5                	mov    %eax,%ebp
  801af1:	89 d6                	mov    %edx,%esi
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 ee                	shr    %cl,%esi
  801af7:	89 f9                	mov    %edi,%ecx
  801af9:	d3 e2                	shl    %cl,%edx
  801afb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 e8                	shr    %cl,%eax
  801b03:	09 c2                	or     %eax,%edx
  801b05:	89 d0                	mov    %edx,%eax
  801b07:	89 f2                	mov    %esi,%edx
  801b09:	f7 74 24 0c          	divl   0xc(%esp)
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	89 c3                	mov    %eax,%ebx
  801b11:	f7 e5                	mul    %ebp
  801b13:	39 d6                	cmp    %edx,%esi
  801b15:	72 19                	jb     801b30 <__udivdi3+0xfc>
  801b17:	74 0b                	je     801b24 <__udivdi3+0xf0>
  801b19:	89 d8                	mov    %ebx,%eax
  801b1b:	31 ff                	xor    %edi,%edi
  801b1d:	e9 58 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b22:	66 90                	xchg   %ax,%ax
  801b24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b28:	89 f9                	mov    %edi,%ecx
  801b2a:	d3 e2                	shl    %cl,%edx
  801b2c:	39 c2                	cmp    %eax,%edx
  801b2e:	73 e9                	jae    801b19 <__udivdi3+0xe5>
  801b30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b33:	31 ff                	xor    %edi,%edi
  801b35:	e9 40 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b3a:	66 90                	xchg   %ax,%ax
  801b3c:	31 c0                	xor    %eax,%eax
  801b3e:	e9 37 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b43:	90                   	nop

00801b44 <__umoddi3>:
  801b44:	55                   	push   %ebp
  801b45:	57                   	push   %edi
  801b46:	56                   	push   %esi
  801b47:	53                   	push   %ebx
  801b48:	83 ec 1c             	sub    $0x1c,%esp
  801b4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b63:	89 f3                	mov    %esi,%ebx
  801b65:	89 fa                	mov    %edi,%edx
  801b67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6b:	89 34 24             	mov    %esi,(%esp)
  801b6e:	85 c0                	test   %eax,%eax
  801b70:	75 1a                	jne    801b8c <__umoddi3+0x48>
  801b72:	39 f7                	cmp    %esi,%edi
  801b74:	0f 86 a2 00 00 00    	jbe    801c1c <__umoddi3+0xd8>
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	89 f2                	mov    %esi,%edx
  801b7e:	f7 f7                	div    %edi
  801b80:	89 d0                	mov    %edx,%eax
  801b82:	31 d2                	xor    %edx,%edx
  801b84:	83 c4 1c             	add    $0x1c,%esp
  801b87:	5b                   	pop    %ebx
  801b88:	5e                   	pop    %esi
  801b89:	5f                   	pop    %edi
  801b8a:	5d                   	pop    %ebp
  801b8b:	c3                   	ret    
  801b8c:	39 f0                	cmp    %esi,%eax
  801b8e:	0f 87 ac 00 00 00    	ja     801c40 <__umoddi3+0xfc>
  801b94:	0f bd e8             	bsr    %eax,%ebp
  801b97:	83 f5 1f             	xor    $0x1f,%ebp
  801b9a:	0f 84 ac 00 00 00    	je     801c4c <__umoddi3+0x108>
  801ba0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba5:	29 ef                	sub    %ebp,%edi
  801ba7:	89 fe                	mov    %edi,%esi
  801ba9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e0                	shl    %cl,%eax
  801bb1:	89 d7                	mov    %edx,%edi
  801bb3:	89 f1                	mov    %esi,%ecx
  801bb5:	d3 ef                	shr    %cl,%edi
  801bb7:	09 c7                	or     %eax,%edi
  801bb9:	89 e9                	mov    %ebp,%ecx
  801bbb:	d3 e2                	shl    %cl,%edx
  801bbd:	89 14 24             	mov    %edx,(%esp)
  801bc0:	89 d8                	mov    %ebx,%eax
  801bc2:	d3 e0                	shl    %cl,%eax
  801bc4:	89 c2                	mov    %eax,%edx
  801bc6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bca:	d3 e0                	shl    %cl,%eax
  801bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd4:	89 f1                	mov    %esi,%ecx
  801bd6:	d3 e8                	shr    %cl,%eax
  801bd8:	09 d0                	or     %edx,%eax
  801bda:	d3 eb                	shr    %cl,%ebx
  801bdc:	89 da                	mov    %ebx,%edx
  801bde:	f7 f7                	div    %edi
  801be0:	89 d3                	mov    %edx,%ebx
  801be2:	f7 24 24             	mull   (%esp)
  801be5:	89 c6                	mov    %eax,%esi
  801be7:	89 d1                	mov    %edx,%ecx
  801be9:	39 d3                	cmp    %edx,%ebx
  801beb:	0f 82 87 00 00 00    	jb     801c78 <__umoddi3+0x134>
  801bf1:	0f 84 91 00 00 00    	je     801c88 <__umoddi3+0x144>
  801bf7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bfb:	29 f2                	sub    %esi,%edx
  801bfd:	19 cb                	sbb    %ecx,%ebx
  801bff:	89 d8                	mov    %ebx,%eax
  801c01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c05:	d3 e0                	shl    %cl,%eax
  801c07:	89 e9                	mov    %ebp,%ecx
  801c09:	d3 ea                	shr    %cl,%edx
  801c0b:	09 d0                	or     %edx,%eax
  801c0d:	89 e9                	mov    %ebp,%ecx
  801c0f:	d3 eb                	shr    %cl,%ebx
  801c11:	89 da                	mov    %ebx,%edx
  801c13:	83 c4 1c             	add    $0x1c,%esp
  801c16:	5b                   	pop    %ebx
  801c17:	5e                   	pop    %esi
  801c18:	5f                   	pop    %edi
  801c19:	5d                   	pop    %ebp
  801c1a:	c3                   	ret    
  801c1b:	90                   	nop
  801c1c:	89 fd                	mov    %edi,%ebp
  801c1e:	85 ff                	test   %edi,%edi
  801c20:	75 0b                	jne    801c2d <__umoddi3+0xe9>
  801c22:	b8 01 00 00 00       	mov    $0x1,%eax
  801c27:	31 d2                	xor    %edx,%edx
  801c29:	f7 f7                	div    %edi
  801c2b:	89 c5                	mov    %eax,%ebp
  801c2d:	89 f0                	mov    %esi,%eax
  801c2f:	31 d2                	xor    %edx,%edx
  801c31:	f7 f5                	div    %ebp
  801c33:	89 c8                	mov    %ecx,%eax
  801c35:	f7 f5                	div    %ebp
  801c37:	89 d0                	mov    %edx,%eax
  801c39:	e9 44 ff ff ff       	jmp    801b82 <__umoddi3+0x3e>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	89 c8                	mov    %ecx,%eax
  801c42:	89 f2                	mov    %esi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	3b 04 24             	cmp    (%esp),%eax
  801c4f:	72 06                	jb     801c57 <__umoddi3+0x113>
  801c51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c55:	77 0f                	ja     801c66 <__umoddi3+0x122>
  801c57:	89 f2                	mov    %esi,%edx
  801c59:	29 f9                	sub    %edi,%ecx
  801c5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5f:	89 14 24             	mov    %edx,(%esp)
  801c62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6a:	8b 14 24             	mov    (%esp),%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	2b 04 24             	sub    (%esp),%eax
  801c7b:	19 fa                	sbb    %edi,%edx
  801c7d:	89 d1                	mov    %edx,%ecx
  801c7f:	89 c6                	mov    %eax,%esi
  801c81:	e9 71 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c8c:	72 ea                	jb     801c78 <__umoddi3+0x134>
  801c8e:	89 d9                	mov    %ebx,%ecx
  801c90:	e9 62 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
