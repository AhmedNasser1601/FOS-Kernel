
obj/user/tst_page_replacement_mod_clock:     file format elf32-i386


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
  800031:	e8 59 05 00 00       	call   80058f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 60 1f 80 00       	push   $0x801f60
  800065:	6a 15                	push   $0x15
  800067:	68 a4 1f 80 00       	push   $0x801fa4
  80006c:	e8 2d 06 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800084:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 60 1f 80 00       	push   $0x801f60
  80009b:	6a 16                	push   $0x16
  80009d:	68 a4 1f 80 00       	push   $0x801fa4
  8000a2:	e8 f7 05 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 60 1f 80 00       	push   $0x801f60
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 a4 1f 80 00       	push   $0x801fa4
  8000d8:	e8 c1 05 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 60 1f 80 00       	push   $0x801f60
  800107:	6a 18                	push   $0x18
  800109:	68 a4 1f 80 00       	push   $0x801fa4
  80010e:	e8 8b 05 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800126:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 60 1f 80 00       	push   $0x801f60
  80013d:	6a 19                	push   $0x19
  80013f:	68 a4 1f 80 00       	push   $0x801fa4
  800144:	e8 55 05 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 60 1f 80 00       	push   $0x801f60
  800173:	6a 1a                	push   $0x1a
  800175:	68 a4 1f 80 00       	push   $0x801fa4
  80017a:	e8 1f 05 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800192:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 60 1f 80 00       	push   $0x801f60
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 a4 1f 80 00       	push   $0x801fa4
  8001b0:	e8 e9 04 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 60 1f 80 00       	push   $0x801f60
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 a4 1f 80 00       	push   $0x801fa4
  8001e6:	e8 b3 04 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 60 1f 80 00       	push   $0x801f60
  800215:	6a 1d                	push   $0x1d
  800217:	68 a4 1f 80 00       	push   $0x801fa4
  80021c:	e8 7d 04 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800234:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 60 1f 80 00       	push   $0x801f60
  80024b:	6a 1e                	push   $0x1e
  80024d:	68 a4 1f 80 00       	push   $0x801fa4
  800252:	e8 47 04 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 60 1f 80 00       	push   $0x801f60
  800281:	6a 1f                	push   $0x1f
  800283:	68 a4 1f 80 00       	push   $0x801fa4
  800288:	e8 11 04 00 00       	call   80069e <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 cc 1f 80 00       	push   $0x801fcc
  8002a4:	6a 20                	push   $0x20
  8002a6:	68 a4 1f 80 00       	push   $0x801fa4
  8002ab:	e8 ee 03 00 00       	call   80069e <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002b0:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002b5:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002b8:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002bd:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002c7:	eb 37                	jmp    800300 <_main+0x2c8>
	{
		arr[i] = -1 ;
  8002c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002cc:	05 40 30 80 00       	add    $0x803040,%eax
  8002d1:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d9:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002df:	8a 12                	mov    (%edx),%dl
  8002e1:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002e3:	a1 00 30 80 00       	mov    0x803000,%eax
  8002e8:	40                   	inc    %eax
  8002e9:	a3 00 30 80 00       	mov    %eax,0x803000
  8002ee:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f3:	40                   	inc    %eax
  8002f4:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002f9:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800300:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800307:	7e c0                	jle    8002c9 <_main+0x291>
		ptr++ ; ptr2++ ;
	}

	//===================
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x809000)  panic("modified clock algo failed");
  800309:	a1 20 30 80 00       	mov    0x803020,%eax
  80030e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800314:	8b 00                	mov    (%eax),%eax
  800316:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800319:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80031c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800321:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 12 20 80 00       	push   $0x802012
  800330:	6a 36                	push   $0x36
  800332:	68 a4 1f 80 00       	push   $0x801fa4
  800337:	e8 62 03 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("modified clock algo failed");
  80033c:	a1 20 30 80 00       	mov    0x803020,%eax
  800341:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800347:	83 c0 0c             	add    $0xc,%eax
  80034a:	8b 00                	mov    (%eax),%eax
  80034c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80034f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800352:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800357:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80035c:	74 14                	je     800372 <_main+0x33a>
  80035e:	83 ec 04             	sub    $0x4,%esp
  800361:	68 12 20 80 00       	push   $0x802012
  800366:	6a 37                	push   $0x37
  800368:	68 a4 1f 80 00       	push   $0x801fa4
  80036d:	e8 2c 03 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("modified clock algo failed");
  800372:	a1 20 30 80 00       	mov    0x803020,%eax
  800377:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80037d:	83 c0 18             	add    $0x18,%eax
  800380:	8b 00                	mov    (%eax),%eax
  800382:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800385:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800388:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80038d:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800392:	74 14                	je     8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 12 20 80 00       	push   $0x802012
  80039c:	6a 38                	push   $0x38
  80039e:	68 a4 1f 80 00       	push   $0x801fa4
  8003a3:	e8 f6 02 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("modified clock algo failed");
  8003a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ad:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003b3:	83 c0 24             	add    $0x24,%eax
  8003b6:	8b 00                	mov    (%eax),%eax
  8003b8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8003bb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8003be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c3:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8003c8:	74 14                	je     8003de <_main+0x3a6>
  8003ca:	83 ec 04             	sub    $0x4,%esp
  8003cd:	68 12 20 80 00       	push   $0x802012
  8003d2:	6a 39                	push   $0x39
  8003d4:	68 a4 1f 80 00       	push   $0x801fa4
  8003d9:	e8 c0 02 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("modified clock algo failed");
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003e9:	83 c0 30             	add    $0x30,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8003f1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f9:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  8003fe:	74 14                	je     800414 <_main+0x3dc>
  800400:	83 ec 04             	sub    $0x4,%esp
  800403:	68 12 20 80 00       	push   $0x802012
  800408:	6a 3a                	push   $0x3a
  80040a:	68 a4 1f 80 00       	push   $0x801fa4
  80040f:	e8 8a 02 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("modified clock algo failed");
  800414:	a1 20 30 80 00       	mov    0x803020,%eax
  800419:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80041f:	83 c0 3c             	add    $0x3c,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800427:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80042a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80042f:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800434:	74 14                	je     80044a <_main+0x412>
  800436:	83 ec 04             	sub    $0x4,%esp
  800439:	68 12 20 80 00       	push   $0x802012
  80043e:	6a 3b                	push   $0x3b
  800440:	68 a4 1f 80 00       	push   $0x801fa4
  800445:	e8 54 02 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("modified clock algo failed");
  80044a:	a1 20 30 80 00       	mov    0x803020,%eax
  80044f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800455:	83 c0 48             	add    $0x48,%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80045d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800460:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800465:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80046a:	74 14                	je     800480 <_main+0x448>
  80046c:	83 ec 04             	sub    $0x4,%esp
  80046f:	68 12 20 80 00       	push   $0x802012
  800474:	6a 3c                	push   $0x3c
  800476:	68 a4 1f 80 00       	push   $0x801fa4
  80047b:	e8 1e 02 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("modified clock algo failed");
  800480:	a1 20 30 80 00       	mov    0x803020,%eax
  800485:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80048b:	83 c0 54             	add    $0x54,%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800493:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800496:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80049b:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004a0:	74 14                	je     8004b6 <_main+0x47e>
  8004a2:	83 ec 04             	sub    $0x4,%esp
  8004a5:	68 12 20 80 00       	push   $0x802012
  8004aa:	6a 3d                	push   $0x3d
  8004ac:	68 a4 1f 80 00       	push   $0x801fa4
  8004b1:	e8 e8 01 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x808000)  panic("modified clock algo failed");
  8004b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004c1:	83 c0 60             	add    $0x60,%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8004c9:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d1:	3d 00 80 80 00       	cmp    $0x808000,%eax
  8004d6:	74 14                	je     8004ec <_main+0x4b4>
  8004d8:	83 ec 04             	sub    $0x4,%esp
  8004db:	68 12 20 80 00       	push   $0x802012
  8004e0:	6a 3e                	push   $0x3e
  8004e2:	68 a4 1f 80 00       	push   $0x801fa4
  8004e7:	e8 b2 01 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("modified clock algo failed");
  8004ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004f7:	83 c0 6c             	add    $0x6c,%eax
  8004fa:	8b 00                	mov    (%eax),%eax
  8004fc:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8004ff:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800502:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800507:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80050c:	74 14                	je     800522 <_main+0x4ea>
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	68 12 20 80 00       	push   $0x802012
  800516:	6a 3f                	push   $0x3f
  800518:	68 a4 1f 80 00       	push   $0x801fa4
  80051d:	e8 7c 01 00 00       	call   80069e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("modified clock algo failed");
  800522:	a1 20 30 80 00       	mov    0x803020,%eax
  800527:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80052d:	83 c0 78             	add    $0x78,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	89 45 98             	mov    %eax,-0x68(%ebp)
  800535:	8b 45 98             	mov    -0x68(%ebp),%eax
  800538:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800542:	74 14                	je     800558 <_main+0x520>
  800544:	83 ec 04             	sub    $0x4,%esp
  800547:	68 12 20 80 00       	push   $0x802012
  80054c:	6a 40                	push   $0x40
  80054e:	68 a4 1f 80 00       	push   $0x801fa4
  800553:	e8 46 01 00 00       	call   80069e <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800563:	83 f8 05             	cmp    $0x5,%eax
  800566:	74 14                	je     80057c <_main+0x544>
  800568:	83 ec 04             	sub    $0x4,%esp
  80056b:	68 30 20 80 00       	push   $0x802030
  800570:	6a 42                	push   $0x42
  800572:	68 a4 1f 80 00       	push   $0x801fa4
  800577:	e8 22 01 00 00       	call   80069e <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [Modified CLOCK Alg.] is completed successfully.\n");
  80057c:	83 ec 0c             	sub    $0xc,%esp
  80057f:	68 50 20 80 00       	push   $0x802050
  800584:	e8 c9 03 00 00       	call   800952 <cprintf>
  800589:	83 c4 10             	add    $0x10,%esp
	return;
  80058c:	90                   	nop
}
  80058d:	c9                   	leave  
  80058e:	c3                   	ret    

0080058f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80058f:	55                   	push   %ebp
  800590:	89 e5                	mov    %esp,%ebp
  800592:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800595:	e8 e3 11 00 00       	call   80177d <sys_getenvindex>
  80059a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80059d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005a0:	89 d0                	mov    %edx,%eax
  8005a2:	c1 e0 02             	shl    $0x2,%eax
  8005a5:	01 d0                	add    %edx,%eax
  8005a7:	01 c0                	add    %eax,%eax
  8005a9:	01 d0                	add    %edx,%eax
  8005ab:	01 c0                	add    %eax,%eax
  8005ad:	01 d0                	add    %edx,%eax
  8005af:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005b6:	01 d0                	add    %edx,%eax
  8005b8:	c1 e0 02             	shl    $0x2,%eax
  8005bb:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005c0:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ca:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005d0:	84 c0                	test   %al,%al
  8005d2:	74 0f                	je     8005e3 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8005d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d9:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005de:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005e7:	7e 0a                	jle    8005f3 <libmain+0x64>
		binaryname = argv[0];
  8005e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ec:	8b 00                	mov    (%eax),%eax
  8005ee:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8005f3:	83 ec 08             	sub    $0x8,%esp
  8005f6:	ff 75 0c             	pushl  0xc(%ebp)
  8005f9:	ff 75 08             	pushl  0x8(%ebp)
  8005fc:	e8 37 fa ff ff       	call   800038 <_main>
  800601:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800604:	e8 0f 13 00 00       	call   801918 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800609:	83 ec 0c             	sub    $0xc,%esp
  80060c:	68 c4 20 80 00       	push   $0x8020c4
  800611:	e8 3c 03 00 00       	call   800952 <cprintf>
  800616:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800619:	a1 20 30 80 00       	mov    0x803020,%eax
  80061e:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800624:	a1 20 30 80 00       	mov    0x803020,%eax
  800629:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80062f:	83 ec 04             	sub    $0x4,%esp
  800632:	52                   	push   %edx
  800633:	50                   	push   %eax
  800634:	68 ec 20 80 00       	push   $0x8020ec
  800639:	e8 14 03 00 00       	call   800952 <cprintf>
  80063e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800641:	a1 20 30 80 00       	mov    0x803020,%eax
  800646:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80064c:	83 ec 08             	sub    $0x8,%esp
  80064f:	50                   	push   %eax
  800650:	68 11 21 80 00       	push   $0x802111
  800655:	e8 f8 02 00 00       	call   800952 <cprintf>
  80065a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80065d:	83 ec 0c             	sub    $0xc,%esp
  800660:	68 c4 20 80 00       	push   $0x8020c4
  800665:	e8 e8 02 00 00       	call   800952 <cprintf>
  80066a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066d:	e8 c0 12 00 00       	call   801932 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800672:	e8 19 00 00 00       	call   800690 <exit>
}
  800677:	90                   	nop
  800678:	c9                   	leave  
  800679:	c3                   	ret    

0080067a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80067a:	55                   	push   %ebp
  80067b:	89 e5                	mov    %esp,%ebp
  80067d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800680:	83 ec 0c             	sub    $0xc,%esp
  800683:	6a 00                	push   $0x0
  800685:	e8 bf 10 00 00       	call   801749 <sys_env_destroy>
  80068a:	83 c4 10             	add    $0x10,%esp
}
  80068d:	90                   	nop
  80068e:	c9                   	leave  
  80068f:	c3                   	ret    

00800690 <exit>:

void
exit(void)
{
  800690:	55                   	push   %ebp
  800691:	89 e5                	mov    %esp,%ebp
  800693:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800696:	e8 14 11 00 00       	call   8017af <sys_env_exit>
}
  80069b:	90                   	nop
  80069c:	c9                   	leave  
  80069d:	c3                   	ret    

0080069e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80069e:	55                   	push   %ebp
  80069f:	89 e5                	mov    %esp,%ebp
  8006a1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006a4:	8d 45 10             	lea    0x10(%ebp),%eax
  8006a7:	83 c0 04             	add    $0x4,%eax
  8006aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006ad:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006b2:	85 c0                	test   %eax,%eax
  8006b4:	74 16                	je     8006cc <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006b6:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006bb:	83 ec 08             	sub    $0x8,%esp
  8006be:	50                   	push   %eax
  8006bf:	68 28 21 80 00       	push   $0x802128
  8006c4:	e8 89 02 00 00       	call   800952 <cprintf>
  8006c9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006cc:	a1 08 30 80 00       	mov    0x803008,%eax
  8006d1:	ff 75 0c             	pushl  0xc(%ebp)
  8006d4:	ff 75 08             	pushl  0x8(%ebp)
  8006d7:	50                   	push   %eax
  8006d8:	68 2d 21 80 00       	push   $0x80212d
  8006dd:	e8 70 02 00 00       	call   800952 <cprintf>
  8006e2:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e8:	83 ec 08             	sub    $0x8,%esp
  8006eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ee:	50                   	push   %eax
  8006ef:	e8 f3 01 00 00       	call   8008e7 <vcprintf>
  8006f4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8006f7:	83 ec 08             	sub    $0x8,%esp
  8006fa:	6a 00                	push   $0x0
  8006fc:	68 49 21 80 00       	push   $0x802149
  800701:	e8 e1 01 00 00       	call   8008e7 <vcprintf>
  800706:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800709:	e8 82 ff ff ff       	call   800690 <exit>

	// should not return here
	while (1) ;
  80070e:	eb fe                	jmp    80070e <_panic+0x70>

00800710 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800710:	55                   	push   %ebp
  800711:	89 e5                	mov    %esp,%ebp
  800713:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800716:	a1 20 30 80 00       	mov    0x803020,%eax
  80071b:	8b 50 74             	mov    0x74(%eax),%edx
  80071e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800721:	39 c2                	cmp    %eax,%edx
  800723:	74 14                	je     800739 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800725:	83 ec 04             	sub    $0x4,%esp
  800728:	68 4c 21 80 00       	push   $0x80214c
  80072d:	6a 26                	push   $0x26
  80072f:	68 98 21 80 00       	push   $0x802198
  800734:	e8 65 ff ff ff       	call   80069e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800739:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800740:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800747:	e9 c2 00 00 00       	jmp    80080e <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80074c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80074f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	01 d0                	add    %edx,%eax
  80075b:	8b 00                	mov    (%eax),%eax
  80075d:	85 c0                	test   %eax,%eax
  80075f:	75 08                	jne    800769 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800761:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800764:	e9 a2 00 00 00       	jmp    80080b <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800769:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800770:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800777:	eb 69                	jmp    8007e2 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800779:	a1 20 30 80 00       	mov    0x803020,%eax
  80077e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800784:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800787:	89 d0                	mov    %edx,%eax
  800789:	01 c0                	add    %eax,%eax
  80078b:	01 d0                	add    %edx,%eax
  80078d:	c1 e0 02             	shl    $0x2,%eax
  800790:	01 c8                	add    %ecx,%eax
  800792:	8a 40 04             	mov    0x4(%eax),%al
  800795:	84 c0                	test   %al,%al
  800797:	75 46                	jne    8007df <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800799:	a1 20 30 80 00       	mov    0x803020,%eax
  80079e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007a4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007a7:	89 d0                	mov    %edx,%eax
  8007a9:	01 c0                	add    %eax,%eax
  8007ab:	01 d0                	add    %edx,%eax
  8007ad:	c1 e0 02             	shl    $0x2,%eax
  8007b0:	01 c8                	add    %ecx,%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007bf:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	01 c8                	add    %ecx,%eax
  8007d0:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d2:	39 c2                	cmp    %eax,%edx
  8007d4:	75 09                	jne    8007df <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007d6:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007dd:	eb 12                	jmp    8007f1 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007df:	ff 45 e8             	incl   -0x18(%ebp)
  8007e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e7:	8b 50 74             	mov    0x74(%eax),%edx
  8007ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007ed:	39 c2                	cmp    %eax,%edx
  8007ef:	77 88                	ja     800779 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007f5:	75 14                	jne    80080b <CheckWSWithoutLastIndex+0xfb>
			panic(
  8007f7:	83 ec 04             	sub    $0x4,%esp
  8007fa:	68 a4 21 80 00       	push   $0x8021a4
  8007ff:	6a 3a                	push   $0x3a
  800801:	68 98 21 80 00       	push   $0x802198
  800806:	e8 93 fe ff ff       	call   80069e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80080b:	ff 45 f0             	incl   -0x10(%ebp)
  80080e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800811:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800814:	0f 8c 32 ff ff ff    	jl     80074c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80081a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800821:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800828:	eb 26                	jmp    800850 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80082a:	a1 20 30 80 00       	mov    0x803020,%eax
  80082f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800835:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800838:	89 d0                	mov    %edx,%eax
  80083a:	01 c0                	add    %eax,%eax
  80083c:	01 d0                	add    %edx,%eax
  80083e:	c1 e0 02             	shl    $0x2,%eax
  800841:	01 c8                	add    %ecx,%eax
  800843:	8a 40 04             	mov    0x4(%eax),%al
  800846:	3c 01                	cmp    $0x1,%al
  800848:	75 03                	jne    80084d <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80084a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80084d:	ff 45 e0             	incl   -0x20(%ebp)
  800850:	a1 20 30 80 00       	mov    0x803020,%eax
  800855:	8b 50 74             	mov    0x74(%eax),%edx
  800858:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80085b:	39 c2                	cmp    %eax,%edx
  80085d:	77 cb                	ja     80082a <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80085f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800862:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800865:	74 14                	je     80087b <CheckWSWithoutLastIndex+0x16b>
		panic(
  800867:	83 ec 04             	sub    $0x4,%esp
  80086a:	68 f8 21 80 00       	push   $0x8021f8
  80086f:	6a 44                	push   $0x44
  800871:	68 98 21 80 00       	push   $0x802198
  800876:	e8 23 fe ff ff       	call   80069e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80087b:	90                   	nop
  80087c:	c9                   	leave  
  80087d:	c3                   	ret    

0080087e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80087e:	55                   	push   %ebp
  80087f:	89 e5                	mov    %esp,%ebp
  800881:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	8b 00                	mov    (%eax),%eax
  800889:	8d 48 01             	lea    0x1(%eax),%ecx
  80088c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80088f:	89 0a                	mov    %ecx,(%edx)
  800891:	8b 55 08             	mov    0x8(%ebp),%edx
  800894:	88 d1                	mov    %dl,%cl
  800896:	8b 55 0c             	mov    0xc(%ebp),%edx
  800899:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a0:	8b 00                	mov    (%eax),%eax
  8008a2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008a7:	75 2c                	jne    8008d5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008a9:	a0 24 30 80 00       	mov    0x803024,%al
  8008ae:	0f b6 c0             	movzbl %al,%eax
  8008b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b4:	8b 12                	mov    (%edx),%edx
  8008b6:	89 d1                	mov    %edx,%ecx
  8008b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bb:	83 c2 08             	add    $0x8,%edx
  8008be:	83 ec 04             	sub    $0x4,%esp
  8008c1:	50                   	push   %eax
  8008c2:	51                   	push   %ecx
  8008c3:	52                   	push   %edx
  8008c4:	e8 3e 0e 00 00       	call   801707 <sys_cputs>
  8008c9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d8:	8b 40 04             	mov    0x4(%eax),%eax
  8008db:	8d 50 01             	lea    0x1(%eax),%edx
  8008de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008e4:	90                   	nop
  8008e5:	c9                   	leave  
  8008e6:	c3                   	ret    

008008e7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008e7:	55                   	push   %ebp
  8008e8:	89 e5                	mov    %esp,%ebp
  8008ea:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008f0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008f7:	00 00 00 
	b.cnt = 0;
  8008fa:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800901:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800904:	ff 75 0c             	pushl  0xc(%ebp)
  800907:	ff 75 08             	pushl  0x8(%ebp)
  80090a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800910:	50                   	push   %eax
  800911:	68 7e 08 80 00       	push   $0x80087e
  800916:	e8 11 02 00 00       	call   800b2c <vprintfmt>
  80091b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80091e:	a0 24 30 80 00       	mov    0x803024,%al
  800923:	0f b6 c0             	movzbl %al,%eax
  800926:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80092c:	83 ec 04             	sub    $0x4,%esp
  80092f:	50                   	push   %eax
  800930:	52                   	push   %edx
  800931:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800937:	83 c0 08             	add    $0x8,%eax
  80093a:	50                   	push   %eax
  80093b:	e8 c7 0d 00 00       	call   801707 <sys_cputs>
  800940:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800943:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80094a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800950:	c9                   	leave  
  800951:	c3                   	ret    

00800952 <cprintf>:

int cprintf(const char *fmt, ...) {
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800958:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80095f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800962:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	83 ec 08             	sub    $0x8,%esp
  80096b:	ff 75 f4             	pushl  -0xc(%ebp)
  80096e:	50                   	push   %eax
  80096f:	e8 73 ff ff ff       	call   8008e7 <vcprintf>
  800974:	83 c4 10             	add    $0x10,%esp
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80097a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80097d:	c9                   	leave  
  80097e:	c3                   	ret    

0080097f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80097f:	55                   	push   %ebp
  800980:	89 e5                	mov    %esp,%ebp
  800982:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800985:	e8 8e 0f 00 00       	call   801918 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80098a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80098d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	83 ec 08             	sub    $0x8,%esp
  800996:	ff 75 f4             	pushl  -0xc(%ebp)
  800999:	50                   	push   %eax
  80099a:	e8 48 ff ff ff       	call   8008e7 <vcprintf>
  80099f:	83 c4 10             	add    $0x10,%esp
  8009a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009a5:	e8 88 0f 00 00       	call   801932 <sys_enable_interrupt>
	return cnt;
  8009aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ad:	c9                   	leave  
  8009ae:	c3                   	ret    

008009af <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009af:	55                   	push   %ebp
  8009b0:	89 e5                	mov    %esp,%ebp
  8009b2:	53                   	push   %ebx
  8009b3:	83 ec 14             	sub    $0x14,%esp
  8009b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009c2:	8b 45 18             	mov    0x18(%ebp),%eax
  8009c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8009ca:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009cd:	77 55                	ja     800a24 <printnum+0x75>
  8009cf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009d2:	72 05                	jb     8009d9 <printnum+0x2a>
  8009d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009d7:	77 4b                	ja     800a24 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009d9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009dc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009df:	8b 45 18             	mov    0x18(%ebp),%eax
  8009e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8009e7:	52                   	push   %edx
  8009e8:	50                   	push   %eax
  8009e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ec:	ff 75 f0             	pushl  -0x10(%ebp)
  8009ef:	e8 04 13 00 00       	call   801cf8 <__udivdi3>
  8009f4:	83 c4 10             	add    $0x10,%esp
  8009f7:	83 ec 04             	sub    $0x4,%esp
  8009fa:	ff 75 20             	pushl  0x20(%ebp)
  8009fd:	53                   	push   %ebx
  8009fe:	ff 75 18             	pushl  0x18(%ebp)
  800a01:	52                   	push   %edx
  800a02:	50                   	push   %eax
  800a03:	ff 75 0c             	pushl  0xc(%ebp)
  800a06:	ff 75 08             	pushl  0x8(%ebp)
  800a09:	e8 a1 ff ff ff       	call   8009af <printnum>
  800a0e:	83 c4 20             	add    $0x20,%esp
  800a11:	eb 1a                	jmp    800a2d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a13:	83 ec 08             	sub    $0x8,%esp
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	ff 75 20             	pushl  0x20(%ebp)
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a24:	ff 4d 1c             	decl   0x1c(%ebp)
  800a27:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a2b:	7f e6                	jg     800a13 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a2d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a30:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a38:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a3b:	53                   	push   %ebx
  800a3c:	51                   	push   %ecx
  800a3d:	52                   	push   %edx
  800a3e:	50                   	push   %eax
  800a3f:	e8 c4 13 00 00       	call   801e08 <__umoddi3>
  800a44:	83 c4 10             	add    $0x10,%esp
  800a47:	05 74 24 80 00       	add    $0x802474,%eax
  800a4c:	8a 00                	mov    (%eax),%al
  800a4e:	0f be c0             	movsbl %al,%eax
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	50                   	push   %eax
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	ff d0                	call   *%eax
  800a5d:	83 c4 10             	add    $0x10,%esp
}
  800a60:	90                   	nop
  800a61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a64:	c9                   	leave  
  800a65:	c3                   	ret    

00800a66 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a66:	55                   	push   %ebp
  800a67:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a69:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a6d:	7e 1c                	jle    800a8b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8b 00                	mov    (%eax),%eax
  800a74:	8d 50 08             	lea    0x8(%eax),%edx
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	89 10                	mov    %edx,(%eax)
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	8b 00                	mov    (%eax),%eax
  800a81:	83 e8 08             	sub    $0x8,%eax
  800a84:	8b 50 04             	mov    0x4(%eax),%edx
  800a87:	8b 00                	mov    (%eax),%eax
  800a89:	eb 40                	jmp    800acb <getuint+0x65>
	else if (lflag)
  800a8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a8f:	74 1e                	je     800aaf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	8b 00                	mov    (%eax),%eax
  800a96:	8d 50 04             	lea    0x4(%eax),%edx
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	89 10                	mov    %edx,(%eax)
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	8b 00                	mov    (%eax),%eax
  800aa3:	83 e8 04             	sub    $0x4,%eax
  800aa6:	8b 00                	mov    (%eax),%eax
  800aa8:	ba 00 00 00 00       	mov    $0x0,%edx
  800aad:	eb 1c                	jmp    800acb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	8b 00                	mov    (%eax),%eax
  800ab4:	8d 50 04             	lea    0x4(%eax),%edx
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	89 10                	mov    %edx,(%eax)
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	8b 00                	mov    (%eax),%eax
  800ac1:	83 e8 04             	sub    $0x4,%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800acb:	5d                   	pop    %ebp
  800acc:	c3                   	ret    

00800acd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad4:	7e 1c                	jle    800af2 <getint+0x25>
		return va_arg(*ap, long long);
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	8b 00                	mov    (%eax),%eax
  800adb:	8d 50 08             	lea    0x8(%eax),%edx
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	89 10                	mov    %edx,(%eax)
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8b 00                	mov    (%eax),%eax
  800ae8:	83 e8 08             	sub    $0x8,%eax
  800aeb:	8b 50 04             	mov    0x4(%eax),%edx
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	eb 38                	jmp    800b2a <getint+0x5d>
	else if (lflag)
  800af2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af6:	74 1a                	je     800b12 <getint+0x45>
		return va_arg(*ap, long);
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	8d 50 04             	lea    0x4(%eax),%edx
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	89 10                	mov    %edx,(%eax)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	83 e8 04             	sub    $0x4,%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	99                   	cltd   
  800b10:	eb 18                	jmp    800b2a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	8d 50 04             	lea    0x4(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 10                	mov    %edx,(%eax)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	99                   	cltd   
}
  800b2a:	5d                   	pop    %ebp
  800b2b:	c3                   	ret    

00800b2c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	56                   	push   %esi
  800b30:	53                   	push   %ebx
  800b31:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b34:	eb 17                	jmp    800b4d <vprintfmt+0x21>
			if (ch == '\0')
  800b36:	85 db                	test   %ebx,%ebx
  800b38:	0f 84 af 03 00 00    	je     800eed <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b3e:	83 ec 08             	sub    $0x8,%esp
  800b41:	ff 75 0c             	pushl  0xc(%ebp)
  800b44:	53                   	push   %ebx
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	ff d0                	call   *%eax
  800b4a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b50:	8d 50 01             	lea    0x1(%eax),%edx
  800b53:	89 55 10             	mov    %edx,0x10(%ebp)
  800b56:	8a 00                	mov    (%eax),%al
  800b58:	0f b6 d8             	movzbl %al,%ebx
  800b5b:	83 fb 25             	cmp    $0x25,%ebx
  800b5e:	75 d6                	jne    800b36 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b60:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b64:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b6b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b72:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b79:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b80:	8b 45 10             	mov    0x10(%ebp),%eax
  800b83:	8d 50 01             	lea    0x1(%eax),%edx
  800b86:	89 55 10             	mov    %edx,0x10(%ebp)
  800b89:	8a 00                	mov    (%eax),%al
  800b8b:	0f b6 d8             	movzbl %al,%ebx
  800b8e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b91:	83 f8 55             	cmp    $0x55,%eax
  800b94:	0f 87 2b 03 00 00    	ja     800ec5 <vprintfmt+0x399>
  800b9a:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  800ba1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ba3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ba7:	eb d7                	jmp    800b80 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ba9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bad:	eb d1                	jmp    800b80 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800baf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bb6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bb9:	89 d0                	mov    %edx,%eax
  800bbb:	c1 e0 02             	shl    $0x2,%eax
  800bbe:	01 d0                	add    %edx,%eax
  800bc0:	01 c0                	add    %eax,%eax
  800bc2:	01 d8                	add    %ebx,%eax
  800bc4:	83 e8 30             	sub    $0x30,%eax
  800bc7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bca:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bd2:	83 fb 2f             	cmp    $0x2f,%ebx
  800bd5:	7e 3e                	jle    800c15 <vprintfmt+0xe9>
  800bd7:	83 fb 39             	cmp    $0x39,%ebx
  800bda:	7f 39                	jg     800c15 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bdc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bdf:	eb d5                	jmp    800bb6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800be1:	8b 45 14             	mov    0x14(%ebp),%eax
  800be4:	83 c0 04             	add    $0x4,%eax
  800be7:	89 45 14             	mov    %eax,0x14(%ebp)
  800bea:	8b 45 14             	mov    0x14(%ebp),%eax
  800bed:	83 e8 04             	sub    $0x4,%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800bf5:	eb 1f                	jmp    800c16 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bf7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bfb:	79 83                	jns    800b80 <vprintfmt+0x54>
				width = 0;
  800bfd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c04:	e9 77 ff ff ff       	jmp    800b80 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c09:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c10:	e9 6b ff ff ff       	jmp    800b80 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c15:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c1a:	0f 89 60 ff ff ff    	jns    800b80 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c20:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c26:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c2d:	e9 4e ff ff ff       	jmp    800b80 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c32:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c35:	e9 46 ff ff ff       	jmp    800b80 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c3a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3d:	83 c0 04             	add    $0x4,%eax
  800c40:	89 45 14             	mov    %eax,0x14(%ebp)
  800c43:	8b 45 14             	mov    0x14(%ebp),%eax
  800c46:	83 e8 04             	sub    $0x4,%eax
  800c49:	8b 00                	mov    (%eax),%eax
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 0c             	pushl  0xc(%ebp)
  800c51:	50                   	push   %eax
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
			break;
  800c5a:	e9 89 02 00 00       	jmp    800ee8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c62:	83 c0 04             	add    $0x4,%eax
  800c65:	89 45 14             	mov    %eax,0x14(%ebp)
  800c68:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6b:	83 e8 04             	sub    $0x4,%eax
  800c6e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c70:	85 db                	test   %ebx,%ebx
  800c72:	79 02                	jns    800c76 <vprintfmt+0x14a>
				err = -err;
  800c74:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c76:	83 fb 64             	cmp    $0x64,%ebx
  800c79:	7f 0b                	jg     800c86 <vprintfmt+0x15a>
  800c7b:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800c82:	85 f6                	test   %esi,%esi
  800c84:	75 19                	jne    800c9f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c86:	53                   	push   %ebx
  800c87:	68 85 24 80 00       	push   $0x802485
  800c8c:	ff 75 0c             	pushl  0xc(%ebp)
  800c8f:	ff 75 08             	pushl  0x8(%ebp)
  800c92:	e8 5e 02 00 00       	call   800ef5 <printfmt>
  800c97:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c9a:	e9 49 02 00 00       	jmp    800ee8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c9f:	56                   	push   %esi
  800ca0:	68 8e 24 80 00       	push   $0x80248e
  800ca5:	ff 75 0c             	pushl  0xc(%ebp)
  800ca8:	ff 75 08             	pushl  0x8(%ebp)
  800cab:	e8 45 02 00 00       	call   800ef5 <printfmt>
  800cb0:	83 c4 10             	add    $0x10,%esp
			break;
  800cb3:	e9 30 02 00 00       	jmp    800ee8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cb8:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbb:	83 c0 04             	add    $0x4,%eax
  800cbe:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc4:	83 e8 04             	sub    $0x4,%eax
  800cc7:	8b 30                	mov    (%eax),%esi
  800cc9:	85 f6                	test   %esi,%esi
  800ccb:	75 05                	jne    800cd2 <vprintfmt+0x1a6>
				p = "(null)";
  800ccd:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  800cd2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd6:	7e 6d                	jle    800d45 <vprintfmt+0x219>
  800cd8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cdc:	74 67                	je     800d45 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce1:	83 ec 08             	sub    $0x8,%esp
  800ce4:	50                   	push   %eax
  800ce5:	56                   	push   %esi
  800ce6:	e8 0c 03 00 00       	call   800ff7 <strnlen>
  800ceb:	83 c4 10             	add    $0x10,%esp
  800cee:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800cf1:	eb 16                	jmp    800d09 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cf3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cf7:	83 ec 08             	sub    $0x8,%esp
  800cfa:	ff 75 0c             	pushl  0xc(%ebp)
  800cfd:	50                   	push   %eax
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	ff d0                	call   *%eax
  800d03:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d06:	ff 4d e4             	decl   -0x1c(%ebp)
  800d09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d0d:	7f e4                	jg     800cf3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d0f:	eb 34                	jmp    800d45 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d11:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d15:	74 1c                	je     800d33 <vprintfmt+0x207>
  800d17:	83 fb 1f             	cmp    $0x1f,%ebx
  800d1a:	7e 05                	jle    800d21 <vprintfmt+0x1f5>
  800d1c:	83 fb 7e             	cmp    $0x7e,%ebx
  800d1f:	7e 12                	jle    800d33 <vprintfmt+0x207>
					putch('?', putdat);
  800d21:	83 ec 08             	sub    $0x8,%esp
  800d24:	ff 75 0c             	pushl  0xc(%ebp)
  800d27:	6a 3f                	push   $0x3f
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	ff d0                	call   *%eax
  800d2e:	83 c4 10             	add    $0x10,%esp
  800d31:	eb 0f                	jmp    800d42 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	53                   	push   %ebx
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	ff d0                	call   *%eax
  800d3f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d42:	ff 4d e4             	decl   -0x1c(%ebp)
  800d45:	89 f0                	mov    %esi,%eax
  800d47:	8d 70 01             	lea    0x1(%eax),%esi
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	0f be d8             	movsbl %al,%ebx
  800d4f:	85 db                	test   %ebx,%ebx
  800d51:	74 24                	je     800d77 <vprintfmt+0x24b>
  800d53:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d57:	78 b8                	js     800d11 <vprintfmt+0x1e5>
  800d59:	ff 4d e0             	decl   -0x20(%ebp)
  800d5c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d60:	79 af                	jns    800d11 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d62:	eb 13                	jmp    800d77 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d64:	83 ec 08             	sub    $0x8,%esp
  800d67:	ff 75 0c             	pushl  0xc(%ebp)
  800d6a:	6a 20                	push   $0x20
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	ff d0                	call   *%eax
  800d71:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d74:	ff 4d e4             	decl   -0x1c(%ebp)
  800d77:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7b:	7f e7                	jg     800d64 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d7d:	e9 66 01 00 00       	jmp    800ee8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d82:	83 ec 08             	sub    $0x8,%esp
  800d85:	ff 75 e8             	pushl  -0x18(%ebp)
  800d88:	8d 45 14             	lea    0x14(%ebp),%eax
  800d8b:	50                   	push   %eax
  800d8c:	e8 3c fd ff ff       	call   800acd <getint>
  800d91:	83 c4 10             	add    $0x10,%esp
  800d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da0:	85 d2                	test   %edx,%edx
  800da2:	79 23                	jns    800dc7 <vprintfmt+0x29b>
				putch('-', putdat);
  800da4:	83 ec 08             	sub    $0x8,%esp
  800da7:	ff 75 0c             	pushl  0xc(%ebp)
  800daa:	6a 2d                	push   $0x2d
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	ff d0                	call   *%eax
  800db1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800db4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dba:	f7 d8                	neg    %eax
  800dbc:	83 d2 00             	adc    $0x0,%edx
  800dbf:	f7 da                	neg    %edx
  800dc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dc7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dce:	e9 bc 00 00 00       	jmp    800e8f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dd3:	83 ec 08             	sub    $0x8,%esp
  800dd6:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd9:	8d 45 14             	lea    0x14(%ebp),%eax
  800ddc:	50                   	push   %eax
  800ddd:	e8 84 fc ff ff       	call   800a66 <getuint>
  800de2:	83 c4 10             	add    $0x10,%esp
  800de5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800deb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df2:	e9 98 00 00 00       	jmp    800e8f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800df7:	83 ec 08             	sub    $0x8,%esp
  800dfa:	ff 75 0c             	pushl  0xc(%ebp)
  800dfd:	6a 58                	push   $0x58
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
  800e02:	ff d0                	call   *%eax
  800e04:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e07:	83 ec 08             	sub    $0x8,%esp
  800e0a:	ff 75 0c             	pushl  0xc(%ebp)
  800e0d:	6a 58                	push   $0x58
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	ff d0                	call   *%eax
  800e14:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e17:	83 ec 08             	sub    $0x8,%esp
  800e1a:	ff 75 0c             	pushl  0xc(%ebp)
  800e1d:	6a 58                	push   $0x58
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	ff d0                	call   *%eax
  800e24:	83 c4 10             	add    $0x10,%esp
			break;
  800e27:	e9 bc 00 00 00       	jmp    800ee8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e2c:	83 ec 08             	sub    $0x8,%esp
  800e2f:	ff 75 0c             	pushl  0xc(%ebp)
  800e32:	6a 30                	push   $0x30
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	ff d0                	call   *%eax
  800e39:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	6a 78                	push   $0x78
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	ff d0                	call   *%eax
  800e49:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4f:	83 c0 04             	add    $0x4,%eax
  800e52:	89 45 14             	mov    %eax,0x14(%ebp)
  800e55:	8b 45 14             	mov    0x14(%ebp),%eax
  800e58:	83 e8 04             	sub    $0x4,%eax
  800e5b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e67:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e6e:	eb 1f                	jmp    800e8f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e70:	83 ec 08             	sub    $0x8,%esp
  800e73:	ff 75 e8             	pushl  -0x18(%ebp)
  800e76:	8d 45 14             	lea    0x14(%ebp),%eax
  800e79:	50                   	push   %eax
  800e7a:	e8 e7 fb ff ff       	call   800a66 <getuint>
  800e7f:	83 c4 10             	add    $0x10,%esp
  800e82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e85:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e88:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e8f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e93:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e96:	83 ec 04             	sub    $0x4,%esp
  800e99:	52                   	push   %edx
  800e9a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e9d:	50                   	push   %eax
  800e9e:	ff 75 f4             	pushl  -0xc(%ebp)
  800ea1:	ff 75 f0             	pushl  -0x10(%ebp)
  800ea4:	ff 75 0c             	pushl  0xc(%ebp)
  800ea7:	ff 75 08             	pushl  0x8(%ebp)
  800eaa:	e8 00 fb ff ff       	call   8009af <printnum>
  800eaf:	83 c4 20             	add    $0x20,%esp
			break;
  800eb2:	eb 34                	jmp    800ee8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eb4:	83 ec 08             	sub    $0x8,%esp
  800eb7:	ff 75 0c             	pushl  0xc(%ebp)
  800eba:	53                   	push   %ebx
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	ff d0                	call   *%eax
  800ec0:	83 c4 10             	add    $0x10,%esp
			break;
  800ec3:	eb 23                	jmp    800ee8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	6a 25                	push   $0x25
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ed5:	ff 4d 10             	decl   0x10(%ebp)
  800ed8:	eb 03                	jmp    800edd <vprintfmt+0x3b1>
  800eda:	ff 4d 10             	decl   0x10(%ebp)
  800edd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee0:	48                   	dec    %eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3c 25                	cmp    $0x25,%al
  800ee5:	75 f3                	jne    800eda <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ee7:	90                   	nop
		}
	}
  800ee8:	e9 47 fc ff ff       	jmp    800b34 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800eed:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800eee:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ef1:	5b                   	pop    %ebx
  800ef2:	5e                   	pop    %esi
  800ef3:	5d                   	pop    %ebp
  800ef4:	c3                   	ret    

00800ef5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ef5:	55                   	push   %ebp
  800ef6:	89 e5                	mov    %esp,%ebp
  800ef8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800efb:	8d 45 10             	lea    0x10(%ebp),%eax
  800efe:	83 c0 04             	add    $0x4,%eax
  800f01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f04:	8b 45 10             	mov    0x10(%ebp),%eax
  800f07:	ff 75 f4             	pushl  -0xc(%ebp)
  800f0a:	50                   	push   %eax
  800f0b:	ff 75 0c             	pushl  0xc(%ebp)
  800f0e:	ff 75 08             	pushl  0x8(%ebp)
  800f11:	e8 16 fc ff ff       	call   800b2c <vprintfmt>
  800f16:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f19:	90                   	nop
  800f1a:	c9                   	leave  
  800f1b:	c3                   	ret    

00800f1c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f1c:	55                   	push   %ebp
  800f1d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f22:	8b 40 08             	mov    0x8(%eax),%eax
  800f25:	8d 50 01             	lea    0x1(%eax),%edx
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f31:	8b 10                	mov    (%eax),%edx
  800f33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f36:	8b 40 04             	mov    0x4(%eax),%eax
  800f39:	39 c2                	cmp    %eax,%edx
  800f3b:	73 12                	jae    800f4f <sprintputch+0x33>
		*b->buf++ = ch;
  800f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f40:	8b 00                	mov    (%eax),%eax
  800f42:	8d 48 01             	lea    0x1(%eax),%ecx
  800f45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f48:	89 0a                	mov    %ecx,(%edx)
  800f4a:	8b 55 08             	mov    0x8(%ebp),%edx
  800f4d:	88 10                	mov    %dl,(%eax)
}
  800f4f:	90                   	nop
  800f50:	5d                   	pop    %ebp
  800f51:	c3                   	ret    

00800f52 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f61:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	01 d0                	add    %edx,%eax
  800f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f73:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f77:	74 06                	je     800f7f <vsnprintf+0x2d>
  800f79:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f7d:	7f 07                	jg     800f86 <vsnprintf+0x34>
		return -E_INVAL;
  800f7f:	b8 03 00 00 00       	mov    $0x3,%eax
  800f84:	eb 20                	jmp    800fa6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f86:	ff 75 14             	pushl  0x14(%ebp)
  800f89:	ff 75 10             	pushl  0x10(%ebp)
  800f8c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f8f:	50                   	push   %eax
  800f90:	68 1c 0f 80 00       	push   $0x800f1c
  800f95:	e8 92 fb ff ff       	call   800b2c <vprintfmt>
  800f9a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fa0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fa6:	c9                   	leave  
  800fa7:	c3                   	ret    

00800fa8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fa8:	55                   	push   %ebp
  800fa9:	89 e5                	mov    %esp,%ebp
  800fab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fae:	8d 45 10             	lea    0x10(%ebp),%eax
  800fb1:	83 c0 04             	add    $0x4,%eax
  800fb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fb7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fba:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbd:	50                   	push   %eax
  800fbe:	ff 75 0c             	pushl  0xc(%ebp)
  800fc1:	ff 75 08             	pushl  0x8(%ebp)
  800fc4:	e8 89 ff ff ff       	call   800f52 <vsnprintf>
  800fc9:	83 c4 10             	add    $0x10,%esp
  800fcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fd2:	c9                   	leave  
  800fd3:	c3                   	ret    

00800fd4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fe1:	eb 06                	jmp    800fe9 <strlen+0x15>
		n++;
  800fe3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fe6:	ff 45 08             	incl   0x8(%ebp)
  800fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fec:	8a 00                	mov    (%eax),%al
  800fee:	84 c0                	test   %al,%al
  800ff0:	75 f1                	jne    800fe3 <strlen+0xf>
		n++;
	return n;
  800ff2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ff5:	c9                   	leave  
  800ff6:	c3                   	ret    

00800ff7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ff7:	55                   	push   %ebp
  800ff8:	89 e5                	mov    %esp,%ebp
  800ffa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ffd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801004:	eb 09                	jmp    80100f <strnlen+0x18>
		n++;
  801006:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801009:	ff 45 08             	incl   0x8(%ebp)
  80100c:	ff 4d 0c             	decl   0xc(%ebp)
  80100f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801013:	74 09                	je     80101e <strnlen+0x27>
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	84 c0                	test   %al,%al
  80101c:	75 e8                	jne    801006 <strnlen+0xf>
		n++;
	return n;
  80101e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801021:	c9                   	leave  
  801022:	c3                   	ret    

00801023 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801023:	55                   	push   %ebp
  801024:	89 e5                	mov    %esp,%ebp
  801026:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80102f:	90                   	nop
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	8d 50 01             	lea    0x1(%eax),%edx
  801036:	89 55 08             	mov    %edx,0x8(%ebp)
  801039:	8b 55 0c             	mov    0xc(%ebp),%edx
  80103c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80103f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801042:	8a 12                	mov    (%edx),%dl
  801044:	88 10                	mov    %dl,(%eax)
  801046:	8a 00                	mov    (%eax),%al
  801048:	84 c0                	test   %al,%al
  80104a:	75 e4                	jne    801030 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80104c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80104f:	c9                   	leave  
  801050:	c3                   	ret    

00801051 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801051:	55                   	push   %ebp
  801052:	89 e5                	mov    %esp,%ebp
  801054:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80105d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801064:	eb 1f                	jmp    801085 <strncpy+0x34>
		*dst++ = *src;
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	8d 50 01             	lea    0x1(%eax),%edx
  80106c:	89 55 08             	mov    %edx,0x8(%ebp)
  80106f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801072:	8a 12                	mov    (%edx),%dl
  801074:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	84 c0                	test   %al,%al
  80107d:	74 03                	je     801082 <strncpy+0x31>
			src++;
  80107f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801082:	ff 45 fc             	incl   -0x4(%ebp)
  801085:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801088:	3b 45 10             	cmp    0x10(%ebp),%eax
  80108b:	72 d9                	jb     801066 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80108d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80109e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a2:	74 30                	je     8010d4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010a4:	eb 16                	jmp    8010bc <strlcpy+0x2a>
			*dst++ = *src++;
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8d 50 01             	lea    0x1(%eax),%edx
  8010ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8010af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b8:	8a 12                	mov    (%edx),%dl
  8010ba:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010bc:	ff 4d 10             	decl   0x10(%ebp)
  8010bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c3:	74 09                	je     8010ce <strlcpy+0x3c>
  8010c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c8:	8a 00                	mov    (%eax),%al
  8010ca:	84 c0                	test   %al,%al
  8010cc:	75 d8                	jne    8010a6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010da:	29 c2                	sub    %eax,%edx
  8010dc:	89 d0                	mov    %edx,%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010e3:	eb 06                	jmp    8010eb <strcmp+0xb>
		p++, q++;
  8010e5:	ff 45 08             	incl   0x8(%ebp)
  8010e8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	84 c0                	test   %al,%al
  8010f2:	74 0e                	je     801102 <strcmp+0x22>
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8a 10                	mov    (%eax),%dl
  8010f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fc:	8a 00                	mov    (%eax),%al
  8010fe:	38 c2                	cmp    %al,%dl
  801100:	74 e3                	je     8010e5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	8a 00                	mov    (%eax),%al
  801107:	0f b6 d0             	movzbl %al,%edx
  80110a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110d:	8a 00                	mov    (%eax),%al
  80110f:	0f b6 c0             	movzbl %al,%eax
  801112:	29 c2                	sub    %eax,%edx
  801114:	89 d0                	mov    %edx,%eax
}
  801116:	5d                   	pop    %ebp
  801117:	c3                   	ret    

00801118 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801118:	55                   	push   %ebp
  801119:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80111b:	eb 09                	jmp    801126 <strncmp+0xe>
		n--, p++, q++;
  80111d:	ff 4d 10             	decl   0x10(%ebp)
  801120:	ff 45 08             	incl   0x8(%ebp)
  801123:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801126:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112a:	74 17                	je     801143 <strncmp+0x2b>
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	84 c0                	test   %al,%al
  801133:	74 0e                	je     801143 <strncmp+0x2b>
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	8a 10                	mov    (%eax),%dl
  80113a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	38 c2                	cmp    %al,%dl
  801141:	74 da                	je     80111d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801143:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801147:	75 07                	jne    801150 <strncmp+0x38>
		return 0;
  801149:	b8 00 00 00 00       	mov    $0x0,%eax
  80114e:	eb 14                	jmp    801164 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	0f b6 d0             	movzbl %al,%edx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	0f b6 c0             	movzbl %al,%eax
  801160:	29 c2                	sub    %eax,%edx
  801162:	89 d0                	mov    %edx,%eax
}
  801164:	5d                   	pop    %ebp
  801165:	c3                   	ret    

00801166 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
  801169:	83 ec 04             	sub    $0x4,%esp
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801172:	eb 12                	jmp    801186 <strchr+0x20>
		if (*s == c)
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80117c:	75 05                	jne    801183 <strchr+0x1d>
			return (char *) s;
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	eb 11                	jmp    801194 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801183:	ff 45 08             	incl   0x8(%ebp)
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	84 c0                	test   %al,%al
  80118d:	75 e5                	jne    801174 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80118f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801194:	c9                   	leave  
  801195:	c3                   	ret    

00801196 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801196:	55                   	push   %ebp
  801197:	89 e5                	mov    %esp,%ebp
  801199:	83 ec 04             	sub    $0x4,%esp
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011a2:	eb 0d                	jmp    8011b1 <strfind+0x1b>
		if (*s == c)
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ac:	74 0e                	je     8011bc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011ae:	ff 45 08             	incl   0x8(%ebp)
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	84 c0                	test   %al,%al
  8011b8:	75 ea                	jne    8011a4 <strfind+0xe>
  8011ba:	eb 01                	jmp    8011bd <strfind+0x27>
		if (*s == c)
			break;
  8011bc:	90                   	nop
	return (char *) s;
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011d4:	eb 0e                	jmp    8011e4 <memset+0x22>
		*p++ = c;
  8011d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d9:	8d 50 01             	lea    0x1(%eax),%edx
  8011dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011e2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011e4:	ff 4d f8             	decl   -0x8(%ebp)
  8011e7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011eb:	79 e9                	jns    8011d6 <memset+0x14>
		*p++ = c;

	return v;
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011f0:	c9                   	leave  
  8011f1:	c3                   	ret    

008011f2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011f2:	55                   	push   %ebp
  8011f3:	89 e5                	mov    %esp,%ebp
  8011f5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801204:	eb 16                	jmp    80121c <memcpy+0x2a>
		*d++ = *s++;
  801206:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801209:	8d 50 01             	lea    0x1(%eax),%edx
  80120c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80120f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801212:	8d 4a 01             	lea    0x1(%edx),%ecx
  801215:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801218:	8a 12                	mov    (%edx),%dl
  80121a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801222:	89 55 10             	mov    %edx,0x10(%ebp)
  801225:	85 c0                	test   %eax,%eax
  801227:	75 dd                	jne    801206 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
  801231:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801234:	8b 45 0c             	mov    0xc(%ebp),%eax
  801237:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801240:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801243:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801246:	73 50                	jae    801298 <memmove+0x6a>
  801248:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124b:	8b 45 10             	mov    0x10(%ebp),%eax
  80124e:	01 d0                	add    %edx,%eax
  801250:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801253:	76 43                	jbe    801298 <memmove+0x6a>
		s += n;
  801255:	8b 45 10             	mov    0x10(%ebp),%eax
  801258:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80125b:	8b 45 10             	mov    0x10(%ebp),%eax
  80125e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801261:	eb 10                	jmp    801273 <memmove+0x45>
			*--d = *--s;
  801263:	ff 4d f8             	decl   -0x8(%ebp)
  801266:	ff 4d fc             	decl   -0x4(%ebp)
  801269:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126c:	8a 10                	mov    (%eax),%dl
  80126e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801271:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801273:	8b 45 10             	mov    0x10(%ebp),%eax
  801276:	8d 50 ff             	lea    -0x1(%eax),%edx
  801279:	89 55 10             	mov    %edx,0x10(%ebp)
  80127c:	85 c0                	test   %eax,%eax
  80127e:	75 e3                	jne    801263 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801280:	eb 23                	jmp    8012a5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801282:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801285:	8d 50 01             	lea    0x1(%eax),%edx
  801288:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80128b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80128e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801291:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801294:	8a 12                	mov    (%edx),%dl
  801296:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801298:	8b 45 10             	mov    0x10(%ebp),%eax
  80129b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80129e:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a1:	85 c0                	test   %eax,%eax
  8012a3:	75 dd                	jne    801282 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
  8012ad:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012bc:	eb 2a                	jmp    8012e8 <memcmp+0x3e>
		if (*s1 != *s2)
  8012be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c1:	8a 10                	mov    (%eax),%dl
  8012c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	38 c2                	cmp    %al,%dl
  8012ca:	74 16                	je     8012e2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012cf:	8a 00                	mov    (%eax),%al
  8012d1:	0f b6 d0             	movzbl %al,%edx
  8012d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d7:	8a 00                	mov    (%eax),%al
  8012d9:	0f b6 c0             	movzbl %al,%eax
  8012dc:	29 c2                	sub    %eax,%edx
  8012de:	89 d0                	mov    %edx,%eax
  8012e0:	eb 18                	jmp    8012fa <memcmp+0x50>
		s1++, s2++;
  8012e2:	ff 45 fc             	incl   -0x4(%ebp)
  8012e5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ee:	89 55 10             	mov    %edx,0x10(%ebp)
  8012f1:	85 c0                	test   %eax,%eax
  8012f3:	75 c9                	jne    8012be <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
  8012ff:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801302:	8b 55 08             	mov    0x8(%ebp),%edx
  801305:	8b 45 10             	mov    0x10(%ebp),%eax
  801308:	01 d0                	add    %edx,%eax
  80130a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80130d:	eb 15                	jmp    801324 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8a 00                	mov    (%eax),%al
  801314:	0f b6 d0             	movzbl %al,%edx
  801317:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131a:	0f b6 c0             	movzbl %al,%eax
  80131d:	39 c2                	cmp    %eax,%edx
  80131f:	74 0d                	je     80132e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801321:	ff 45 08             	incl   0x8(%ebp)
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80132a:	72 e3                	jb     80130f <memfind+0x13>
  80132c:	eb 01                	jmp    80132f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80132e:	90                   	nop
	return (void *) s;
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
  801337:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80133a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801341:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801348:	eb 03                	jmp    80134d <strtol+0x19>
		s++;
  80134a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	3c 20                	cmp    $0x20,%al
  801354:	74 f4                	je     80134a <strtol+0x16>
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	3c 09                	cmp    $0x9,%al
  80135d:	74 eb                	je     80134a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	3c 2b                	cmp    $0x2b,%al
  801366:	75 05                	jne    80136d <strtol+0x39>
		s++;
  801368:	ff 45 08             	incl   0x8(%ebp)
  80136b:	eb 13                	jmp    801380 <strtol+0x4c>
	else if (*s == '-')
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
  801370:	8a 00                	mov    (%eax),%al
  801372:	3c 2d                	cmp    $0x2d,%al
  801374:	75 0a                	jne    801380 <strtol+0x4c>
		s++, neg = 1;
  801376:	ff 45 08             	incl   0x8(%ebp)
  801379:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801380:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801384:	74 06                	je     80138c <strtol+0x58>
  801386:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80138a:	75 20                	jne    8013ac <strtol+0x78>
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
  80138f:	8a 00                	mov    (%eax),%al
  801391:	3c 30                	cmp    $0x30,%al
  801393:	75 17                	jne    8013ac <strtol+0x78>
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	40                   	inc    %eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	3c 78                	cmp    $0x78,%al
  80139d:	75 0d                	jne    8013ac <strtol+0x78>
		s += 2, base = 16;
  80139f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013a3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013aa:	eb 28                	jmp    8013d4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b0:	75 15                	jne    8013c7 <strtol+0x93>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	3c 30                	cmp    $0x30,%al
  8013b9:	75 0c                	jne    8013c7 <strtol+0x93>
		s++, base = 8;
  8013bb:	ff 45 08             	incl   0x8(%ebp)
  8013be:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013c5:	eb 0d                	jmp    8013d4 <strtol+0xa0>
	else if (base == 0)
  8013c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cb:	75 07                	jne    8013d4 <strtol+0xa0>
		base = 10;
  8013cd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	3c 2f                	cmp    $0x2f,%al
  8013db:	7e 19                	jle    8013f6 <strtol+0xc2>
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	3c 39                	cmp    $0x39,%al
  8013e4:	7f 10                	jg     8013f6 <strtol+0xc2>
			dig = *s - '0';
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	0f be c0             	movsbl %al,%eax
  8013ee:	83 e8 30             	sub    $0x30,%eax
  8013f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013f4:	eb 42                	jmp    801438 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 60                	cmp    $0x60,%al
  8013fd:	7e 19                	jle    801418 <strtol+0xe4>
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	3c 7a                	cmp    $0x7a,%al
  801406:	7f 10                	jg     801418 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	0f be c0             	movsbl %al,%eax
  801410:	83 e8 57             	sub    $0x57,%eax
  801413:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801416:	eb 20                	jmp    801438 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	3c 40                	cmp    $0x40,%al
  80141f:	7e 39                	jle    80145a <strtol+0x126>
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	3c 5a                	cmp    $0x5a,%al
  801428:	7f 30                	jg     80145a <strtol+0x126>
			dig = *s - 'A' + 10;
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	0f be c0             	movsbl %al,%eax
  801432:	83 e8 37             	sub    $0x37,%eax
  801435:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801438:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80143b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80143e:	7d 19                	jge    801459 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801440:	ff 45 08             	incl   0x8(%ebp)
  801443:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801446:	0f af 45 10          	imul   0x10(%ebp),%eax
  80144a:	89 c2                	mov    %eax,%edx
  80144c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80144f:	01 d0                	add    %edx,%eax
  801451:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801454:	e9 7b ff ff ff       	jmp    8013d4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801459:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80145a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80145e:	74 08                	je     801468 <strtol+0x134>
		*endptr = (char *) s;
  801460:	8b 45 0c             	mov    0xc(%ebp),%eax
  801463:	8b 55 08             	mov    0x8(%ebp),%edx
  801466:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801468:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80146c:	74 07                	je     801475 <strtol+0x141>
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801471:	f7 d8                	neg    %eax
  801473:	eb 03                	jmp    801478 <strtol+0x144>
  801475:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <ltostr>:

void
ltostr(long value, char *str)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801480:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801487:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80148e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801492:	79 13                	jns    8014a7 <ltostr+0x2d>
	{
		neg = 1;
  801494:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80149b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014a1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014a4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014af:	99                   	cltd   
  8014b0:	f7 f9                	idiv   %ecx
  8014b2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b8:	8d 50 01             	lea    0x1(%eax),%edx
  8014bb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014be:	89 c2                	mov    %eax,%edx
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	01 d0                	add    %edx,%eax
  8014c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014c8:	83 c2 30             	add    $0x30,%edx
  8014cb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014d0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014d5:	f7 e9                	imul   %ecx
  8014d7:	c1 fa 02             	sar    $0x2,%edx
  8014da:	89 c8                	mov    %ecx,%eax
  8014dc:	c1 f8 1f             	sar    $0x1f,%eax
  8014df:	29 c2                	sub    %eax,%edx
  8014e1:	89 d0                	mov    %edx,%eax
  8014e3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014ee:	f7 e9                	imul   %ecx
  8014f0:	c1 fa 02             	sar    $0x2,%edx
  8014f3:	89 c8                	mov    %ecx,%eax
  8014f5:	c1 f8 1f             	sar    $0x1f,%eax
  8014f8:	29 c2                	sub    %eax,%edx
  8014fa:	89 d0                	mov    %edx,%eax
  8014fc:	c1 e0 02             	shl    $0x2,%eax
  8014ff:	01 d0                	add    %edx,%eax
  801501:	01 c0                	add    %eax,%eax
  801503:	29 c1                	sub    %eax,%ecx
  801505:	89 ca                	mov    %ecx,%edx
  801507:	85 d2                	test   %edx,%edx
  801509:	75 9c                	jne    8014a7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80150b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801512:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801515:	48                   	dec    %eax
  801516:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801519:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80151d:	74 3d                	je     80155c <ltostr+0xe2>
		start = 1 ;
  80151f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801526:	eb 34                	jmp    80155c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801528:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80152b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152e:	01 d0                	add    %edx,%eax
  801530:	8a 00                	mov    (%eax),%al
  801532:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801535:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801538:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153b:	01 c2                	add    %eax,%edx
  80153d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801540:	8b 45 0c             	mov    0xc(%ebp),%eax
  801543:	01 c8                	add    %ecx,%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801549:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80154c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154f:	01 c2                	add    %eax,%edx
  801551:	8a 45 eb             	mov    -0x15(%ebp),%al
  801554:	88 02                	mov    %al,(%edx)
		start++ ;
  801556:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801559:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80155c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80155f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801562:	7c c4                	jl     801528 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801564:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801567:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156a:	01 d0                	add    %edx,%eax
  80156c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80156f:	90                   	nop
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
  801575:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801578:	ff 75 08             	pushl  0x8(%ebp)
  80157b:	e8 54 fa ff ff       	call   800fd4 <strlen>
  801580:	83 c4 04             	add    $0x4,%esp
  801583:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801586:	ff 75 0c             	pushl  0xc(%ebp)
  801589:	e8 46 fa ff ff       	call   800fd4 <strlen>
  80158e:	83 c4 04             	add    $0x4,%esp
  801591:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801594:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80159b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015a2:	eb 17                	jmp    8015bb <strcconcat+0x49>
		final[s] = str1[s] ;
  8015a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015aa:	01 c2                	add    %eax,%edx
  8015ac:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	01 c8                	add    %ecx,%eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015b8:	ff 45 fc             	incl   -0x4(%ebp)
  8015bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015c1:	7c e1                	jl     8015a4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015d1:	eb 1f                	jmp    8015f2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d6:	8d 50 01             	lea    0x1(%eax),%edx
  8015d9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015dc:	89 c2                	mov    %eax,%edx
  8015de:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e1:	01 c2                	add    %eax,%edx
  8015e3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e9:	01 c8                	add    %ecx,%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015ef:	ff 45 f8             	incl   -0x8(%ebp)
  8015f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015f8:	7c d9                	jl     8015d3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801600:	01 d0                	add    %edx,%eax
  801602:	c6 00 00             	movb   $0x0,(%eax)
}
  801605:	90                   	nop
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80160b:	8b 45 14             	mov    0x14(%ebp),%eax
  80160e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801614:	8b 45 14             	mov    0x14(%ebp),%eax
  801617:	8b 00                	mov    (%eax),%eax
  801619:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801620:	8b 45 10             	mov    0x10(%ebp),%eax
  801623:	01 d0                	add    %edx,%eax
  801625:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80162b:	eb 0c                	jmp    801639 <strsplit+0x31>
			*string++ = 0;
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	8d 50 01             	lea    0x1(%eax),%edx
  801633:	89 55 08             	mov    %edx,0x8(%ebp)
  801636:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	84 c0                	test   %al,%al
  801640:	74 18                	je     80165a <strsplit+0x52>
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	0f be c0             	movsbl %al,%eax
  80164a:	50                   	push   %eax
  80164b:	ff 75 0c             	pushl  0xc(%ebp)
  80164e:	e8 13 fb ff ff       	call   801166 <strchr>
  801653:	83 c4 08             	add    $0x8,%esp
  801656:	85 c0                	test   %eax,%eax
  801658:	75 d3                	jne    80162d <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	84 c0                	test   %al,%al
  801661:	74 5a                	je     8016bd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801663:	8b 45 14             	mov    0x14(%ebp),%eax
  801666:	8b 00                	mov    (%eax),%eax
  801668:	83 f8 0f             	cmp    $0xf,%eax
  80166b:	75 07                	jne    801674 <strsplit+0x6c>
		{
			return 0;
  80166d:	b8 00 00 00 00       	mov    $0x0,%eax
  801672:	eb 66                	jmp    8016da <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801674:	8b 45 14             	mov    0x14(%ebp),%eax
  801677:	8b 00                	mov    (%eax),%eax
  801679:	8d 48 01             	lea    0x1(%eax),%ecx
  80167c:	8b 55 14             	mov    0x14(%ebp),%edx
  80167f:	89 0a                	mov    %ecx,(%edx)
  801681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801688:	8b 45 10             	mov    0x10(%ebp),%eax
  80168b:	01 c2                	add    %eax,%edx
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801692:	eb 03                	jmp    801697 <strsplit+0x8f>
			string++;
  801694:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	84 c0                	test   %al,%al
  80169e:	74 8b                	je     80162b <strsplit+0x23>
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	0f be c0             	movsbl %al,%eax
  8016a8:	50                   	push   %eax
  8016a9:	ff 75 0c             	pushl  0xc(%ebp)
  8016ac:	e8 b5 fa ff ff       	call   801166 <strchr>
  8016b1:	83 c4 08             	add    $0x8,%esp
  8016b4:	85 c0                	test   %eax,%eax
  8016b6:	74 dc                	je     801694 <strsplit+0x8c>
			string++;
	}
  8016b8:	e9 6e ff ff ff       	jmp    80162b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016bd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016be:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c1:	8b 00                	mov    (%eax),%eax
  8016c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cd:	01 d0                	add    %edx,%eax
  8016cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016d5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016da:	c9                   	leave  
  8016db:	c3                   	ret    

008016dc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016dc:	55                   	push   %ebp
  8016dd:	89 e5                	mov    %esp,%ebp
  8016df:	57                   	push   %edi
  8016e0:	56                   	push   %esi
  8016e1:	53                   	push   %ebx
  8016e2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016ee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016f1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016f4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016f7:	cd 30                	int    $0x30
  8016f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ff:	83 c4 10             	add    $0x10,%esp
  801702:	5b                   	pop    %ebx
  801703:	5e                   	pop    %esi
  801704:	5f                   	pop    %edi
  801705:	5d                   	pop    %ebp
  801706:	c3                   	ret    

00801707 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801707:	55                   	push   %ebp
  801708:	89 e5                	mov    %esp,%ebp
  80170a:	83 ec 04             	sub    $0x4,%esp
  80170d:	8b 45 10             	mov    0x10(%ebp),%eax
  801710:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801713:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	52                   	push   %edx
  80171f:	ff 75 0c             	pushl  0xc(%ebp)
  801722:	50                   	push   %eax
  801723:	6a 00                	push   $0x0
  801725:	e8 b2 ff ff ff       	call   8016dc <syscall>
  80172a:	83 c4 18             	add    $0x18,%esp
}
  80172d:	90                   	nop
  80172e:	c9                   	leave  
  80172f:	c3                   	ret    

00801730 <sys_cgetc>:

int
sys_cgetc(void)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 01                	push   $0x1
  80173f:	e8 98 ff ff ff       	call   8016dc <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80174c:	8b 45 08             	mov    0x8(%ebp),%eax
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	50                   	push   %eax
  801758:	6a 05                	push   $0x5
  80175a:	e8 7d ff ff ff       	call   8016dc <syscall>
  80175f:	83 c4 18             	add    $0x18,%esp
}
  801762:	c9                   	leave  
  801763:	c3                   	ret    

00801764 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801764:	55                   	push   %ebp
  801765:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 02                	push   $0x2
  801773:	e8 64 ff ff ff       	call   8016dc <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 03                	push   $0x3
  80178c:	e8 4b ff ff ff       	call   8016dc <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 04                	push   $0x4
  8017a5:	e8 32 ff ff ff       	call   8016dc <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_env_exit>:


void sys_env_exit(void)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 06                	push   $0x6
  8017be:	e8 19 ff ff ff       	call   8016dc <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	90                   	nop
  8017c7:	c9                   	leave  
  8017c8:	c3                   	ret    

008017c9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017c9:	55                   	push   %ebp
  8017ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	52                   	push   %edx
  8017d9:	50                   	push   %eax
  8017da:	6a 07                	push   $0x7
  8017dc:	e8 fb fe ff ff       	call   8016dc <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
}
  8017e4:	c9                   	leave  
  8017e5:	c3                   	ret    

008017e6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
  8017e9:	56                   	push   %esi
  8017ea:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017eb:	8b 75 18             	mov    0x18(%ebp),%esi
  8017ee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	56                   	push   %esi
  8017fb:	53                   	push   %ebx
  8017fc:	51                   	push   %ecx
  8017fd:	52                   	push   %edx
  8017fe:	50                   	push   %eax
  8017ff:	6a 08                	push   $0x8
  801801:	e8 d6 fe ff ff       	call   8016dc <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80180c:	5b                   	pop    %ebx
  80180d:	5e                   	pop    %esi
  80180e:	5d                   	pop    %ebp
  80180f:	c3                   	ret    

00801810 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801813:	8b 55 0c             	mov    0xc(%ebp),%edx
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	52                   	push   %edx
  801820:	50                   	push   %eax
  801821:	6a 09                	push   $0x9
  801823:	e8 b4 fe ff ff       	call   8016dc <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	ff 75 0c             	pushl  0xc(%ebp)
  801839:	ff 75 08             	pushl  0x8(%ebp)
  80183c:	6a 0a                	push   $0xa
  80183e:	e8 99 fe ff ff       	call   8016dc <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
}
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 0b                	push   $0xb
  801857:	e8 80 fe ff ff       	call   8016dc <syscall>
  80185c:	83 c4 18             	add    $0x18,%esp
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 0c                	push   $0xc
  801870:	e8 67 fe ff ff       	call   8016dc <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
}
  801878:	c9                   	leave  
  801879:	c3                   	ret    

0080187a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 0d                	push   $0xd
  801889:	e8 4e fe ff ff       	call   8016dc <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	ff 75 0c             	pushl  0xc(%ebp)
  80189f:	ff 75 08             	pushl  0x8(%ebp)
  8018a2:	6a 11                	push   $0x11
  8018a4:	e8 33 fe ff ff       	call   8016dc <syscall>
  8018a9:	83 c4 18             	add    $0x18,%esp
	return;
  8018ac:	90                   	nop
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	ff 75 0c             	pushl  0xc(%ebp)
  8018bb:	ff 75 08             	pushl  0x8(%ebp)
  8018be:	6a 12                	push   $0x12
  8018c0:	e8 17 fe ff ff       	call   8016dc <syscall>
  8018c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c8:	90                   	nop
}
  8018c9:	c9                   	leave  
  8018ca:	c3                   	ret    

008018cb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018cb:	55                   	push   %ebp
  8018cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 0e                	push   $0xe
  8018da:	e8 fd fd ff ff       	call   8016dc <syscall>
  8018df:	83 c4 18             	add    $0x18,%esp
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	ff 75 08             	pushl  0x8(%ebp)
  8018f2:	6a 0f                	push   $0xf
  8018f4:	e8 e3 fd ff ff       	call   8016dc <syscall>
  8018f9:	83 c4 18             	add    $0x18,%esp
}
  8018fc:	c9                   	leave  
  8018fd:	c3                   	ret    

008018fe <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018fe:	55                   	push   %ebp
  8018ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 10                	push   $0x10
  80190d:	e8 ca fd ff ff       	call   8016dc <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
}
  801915:	90                   	nop
  801916:	c9                   	leave  
  801917:	c3                   	ret    

00801918 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 14                	push   $0x14
  801927:	e8 b0 fd ff ff       	call   8016dc <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
}
  80192f:	90                   	nop
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 15                	push   $0x15
  801941:	e8 96 fd ff ff       	call   8016dc <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	90                   	nop
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_cputc>:


void
sys_cputc(const char c)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
  80194f:	83 ec 04             	sub    $0x4,%esp
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801958:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	50                   	push   %eax
  801965:	6a 16                	push   $0x16
  801967:	e8 70 fd ff ff       	call   8016dc <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 17                	push   $0x17
  801981:	e8 56 fd ff ff       	call   8016dc <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
}
  801989:	90                   	nop
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	ff 75 0c             	pushl  0xc(%ebp)
  80199b:	50                   	push   %eax
  80199c:	6a 18                	push   $0x18
  80199e:	e8 39 fd ff ff       	call   8016dc <syscall>
  8019a3:	83 c4 18             	add    $0x18,%esp
}
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	52                   	push   %edx
  8019b8:	50                   	push   %eax
  8019b9:	6a 1b                	push   $0x1b
  8019bb:	e8 1c fd ff ff       	call   8016dc <syscall>
  8019c0:	83 c4 18             	add    $0x18,%esp
}
  8019c3:	c9                   	leave  
  8019c4:	c3                   	ret    

008019c5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019c5:	55                   	push   %ebp
  8019c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	52                   	push   %edx
  8019d5:	50                   	push   %eax
  8019d6:	6a 19                	push   $0x19
  8019d8:	e8 ff fc ff ff       	call   8016dc <syscall>
  8019dd:	83 c4 18             	add    $0x18,%esp
}
  8019e0:	90                   	nop
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	52                   	push   %edx
  8019f3:	50                   	push   %eax
  8019f4:	6a 1a                	push   $0x1a
  8019f6:	e8 e1 fc ff ff       	call   8016dc <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
}
  8019fe:	90                   	nop
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
  801a04:	83 ec 04             	sub    $0x4,%esp
  801a07:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a0d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a10:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a14:	8b 45 08             	mov    0x8(%ebp),%eax
  801a17:	6a 00                	push   $0x0
  801a19:	51                   	push   %ecx
  801a1a:	52                   	push   %edx
  801a1b:	ff 75 0c             	pushl  0xc(%ebp)
  801a1e:	50                   	push   %eax
  801a1f:	6a 1c                	push   $0x1c
  801a21:	e8 b6 fc ff ff       	call   8016dc <syscall>
  801a26:	83 c4 18             	add    $0x18,%esp
}
  801a29:	c9                   	leave  
  801a2a:	c3                   	ret    

00801a2b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a2b:	55                   	push   %ebp
  801a2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a31:	8b 45 08             	mov    0x8(%ebp),%eax
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	52                   	push   %edx
  801a3b:	50                   	push   %eax
  801a3c:	6a 1d                	push   $0x1d
  801a3e:	e8 99 fc ff ff       	call   8016dc <syscall>
  801a43:	83 c4 18             	add    $0x18,%esp
}
  801a46:	c9                   	leave  
  801a47:	c3                   	ret    

00801a48 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a48:	55                   	push   %ebp
  801a49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a51:	8b 45 08             	mov    0x8(%ebp),%eax
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	51                   	push   %ecx
  801a59:	52                   	push   %edx
  801a5a:	50                   	push   %eax
  801a5b:	6a 1e                	push   $0x1e
  801a5d:	e8 7a fc ff ff       	call   8016dc <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
}
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	52                   	push   %edx
  801a77:	50                   	push   %eax
  801a78:	6a 1f                	push   $0x1f
  801a7a:	e8 5d fc ff ff       	call   8016dc <syscall>
  801a7f:	83 c4 18             	add    $0x18,%esp
}
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 20                	push   $0x20
  801a93:	e8 44 fc ff ff       	call   8016dc <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	ff 75 10             	pushl  0x10(%ebp)
  801aaa:	ff 75 0c             	pushl  0xc(%ebp)
  801aad:	50                   	push   %eax
  801aae:	6a 21                	push   $0x21
  801ab0:	e8 27 fc ff ff       	call   8016dc <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801abd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	50                   	push   %eax
  801ac9:	6a 22                	push   $0x22
  801acb:	e8 0c fc ff ff       	call   8016dc <syscall>
  801ad0:	83 c4 18             	add    $0x18,%esp
}
  801ad3:	90                   	nop
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	50                   	push   %eax
  801ae5:	6a 23                	push   $0x23
  801ae7:	e8 f0 fb ff ff       	call   8016dc <syscall>
  801aec:	83 c4 18             	add    $0x18,%esp
}
  801aef:	90                   	nop
  801af0:	c9                   	leave  
  801af1:	c3                   	ret    

00801af2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801af2:	55                   	push   %ebp
  801af3:	89 e5                	mov    %esp,%ebp
  801af5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801af8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801afb:	8d 50 04             	lea    0x4(%eax),%edx
  801afe:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	52                   	push   %edx
  801b08:	50                   	push   %eax
  801b09:	6a 24                	push   $0x24
  801b0b:	e8 cc fb ff ff       	call   8016dc <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
	return result;
  801b13:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b19:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b1c:	89 01                	mov    %eax,(%ecx)
  801b1e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	c9                   	leave  
  801b25:	c2 04 00             	ret    $0x4

00801b28 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	ff 75 10             	pushl  0x10(%ebp)
  801b32:	ff 75 0c             	pushl  0xc(%ebp)
  801b35:	ff 75 08             	pushl  0x8(%ebp)
  801b38:	6a 13                	push   $0x13
  801b3a:	e8 9d fb ff ff       	call   8016dc <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b42:	90                   	nop
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 25                	push   $0x25
  801b54:	e8 83 fb ff ff       	call   8016dc <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
  801b61:	83 ec 04             	sub    $0x4,%esp
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b6a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	50                   	push   %eax
  801b77:	6a 26                	push   $0x26
  801b79:	e8 5e fb ff ff       	call   8016dc <syscall>
  801b7e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b81:	90                   	nop
}
  801b82:	c9                   	leave  
  801b83:	c3                   	ret    

00801b84 <rsttst>:
void rsttst()
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 28                	push   $0x28
  801b93:	e8 44 fb ff ff       	call   8016dc <syscall>
  801b98:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9b:	90                   	nop
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	83 ec 04             	sub    $0x4,%esp
  801ba4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801baa:	8b 55 18             	mov    0x18(%ebp),%edx
  801bad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bb1:	52                   	push   %edx
  801bb2:	50                   	push   %eax
  801bb3:	ff 75 10             	pushl  0x10(%ebp)
  801bb6:	ff 75 0c             	pushl  0xc(%ebp)
  801bb9:	ff 75 08             	pushl  0x8(%ebp)
  801bbc:	6a 27                	push   $0x27
  801bbe:	e8 19 fb ff ff       	call   8016dc <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc6:	90                   	nop
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <chktst>:
void chktst(uint32 n)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	ff 75 08             	pushl  0x8(%ebp)
  801bd7:	6a 29                	push   $0x29
  801bd9:	e8 fe fa ff ff       	call   8016dc <syscall>
  801bde:	83 c4 18             	add    $0x18,%esp
	return ;
  801be1:	90                   	nop
}
  801be2:	c9                   	leave  
  801be3:	c3                   	ret    

00801be4 <inctst>:

void inctst()
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 2a                	push   $0x2a
  801bf3:	e8 e4 fa ff ff       	call   8016dc <syscall>
  801bf8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfb:	90                   	nop
}
  801bfc:	c9                   	leave  
  801bfd:	c3                   	ret    

00801bfe <gettst>:
uint32 gettst()
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 2b                	push   $0x2b
  801c0d:	e8 ca fa ff ff       	call   8016dc <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    

00801c17 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c17:	55                   	push   %ebp
  801c18:	89 e5                	mov    %esp,%ebp
  801c1a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 2c                	push   $0x2c
  801c29:	e8 ae fa ff ff       	call   8016dc <syscall>
  801c2e:	83 c4 18             	add    $0x18,%esp
  801c31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c34:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c38:	75 07                	jne    801c41 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c3f:	eb 05                	jmp    801c46 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c41:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
  801c4b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 2c                	push   $0x2c
  801c5a:	e8 7d fa ff ff       	call   8016dc <syscall>
  801c5f:	83 c4 18             	add    $0x18,%esp
  801c62:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c65:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c69:	75 07                	jne    801c72 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c6b:	b8 01 00 00 00       	mov    $0x1,%eax
  801c70:	eb 05                	jmp    801c77 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
  801c7c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 2c                	push   $0x2c
  801c8b:	e8 4c fa ff ff       	call   8016dc <syscall>
  801c90:	83 c4 18             	add    $0x18,%esp
  801c93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c96:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c9a:	75 07                	jne    801ca3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c9c:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca1:	eb 05                	jmp    801ca8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ca3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
  801cad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 2c                	push   $0x2c
  801cbc:	e8 1b fa ff ff       	call   8016dc <syscall>
  801cc1:	83 c4 18             	add    $0x18,%esp
  801cc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cc7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ccb:	75 07                	jne    801cd4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ccd:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd2:	eb 05                	jmp    801cd9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	ff 75 08             	pushl  0x8(%ebp)
  801ce9:	6a 2d                	push   $0x2d
  801ceb:	e8 ec f9 ff ff       	call   8016dc <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf3:	90                   	nop
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    
  801cf6:	66 90                	xchg   %ax,%ax

00801cf8 <__udivdi3>:
  801cf8:	55                   	push   %ebp
  801cf9:	57                   	push   %edi
  801cfa:	56                   	push   %esi
  801cfb:	53                   	push   %ebx
  801cfc:	83 ec 1c             	sub    $0x1c,%esp
  801cff:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d03:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d07:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d0b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d0f:	89 ca                	mov    %ecx,%edx
  801d11:	89 f8                	mov    %edi,%eax
  801d13:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d17:	85 f6                	test   %esi,%esi
  801d19:	75 2d                	jne    801d48 <__udivdi3+0x50>
  801d1b:	39 cf                	cmp    %ecx,%edi
  801d1d:	77 65                	ja     801d84 <__udivdi3+0x8c>
  801d1f:	89 fd                	mov    %edi,%ebp
  801d21:	85 ff                	test   %edi,%edi
  801d23:	75 0b                	jne    801d30 <__udivdi3+0x38>
  801d25:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2a:	31 d2                	xor    %edx,%edx
  801d2c:	f7 f7                	div    %edi
  801d2e:	89 c5                	mov    %eax,%ebp
  801d30:	31 d2                	xor    %edx,%edx
  801d32:	89 c8                	mov    %ecx,%eax
  801d34:	f7 f5                	div    %ebp
  801d36:	89 c1                	mov    %eax,%ecx
  801d38:	89 d8                	mov    %ebx,%eax
  801d3a:	f7 f5                	div    %ebp
  801d3c:	89 cf                	mov    %ecx,%edi
  801d3e:	89 fa                	mov    %edi,%edx
  801d40:	83 c4 1c             	add    $0x1c,%esp
  801d43:	5b                   	pop    %ebx
  801d44:	5e                   	pop    %esi
  801d45:	5f                   	pop    %edi
  801d46:	5d                   	pop    %ebp
  801d47:	c3                   	ret    
  801d48:	39 ce                	cmp    %ecx,%esi
  801d4a:	77 28                	ja     801d74 <__udivdi3+0x7c>
  801d4c:	0f bd fe             	bsr    %esi,%edi
  801d4f:	83 f7 1f             	xor    $0x1f,%edi
  801d52:	75 40                	jne    801d94 <__udivdi3+0x9c>
  801d54:	39 ce                	cmp    %ecx,%esi
  801d56:	72 0a                	jb     801d62 <__udivdi3+0x6a>
  801d58:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d5c:	0f 87 9e 00 00 00    	ja     801e00 <__udivdi3+0x108>
  801d62:	b8 01 00 00 00       	mov    $0x1,%eax
  801d67:	89 fa                	mov    %edi,%edx
  801d69:	83 c4 1c             	add    $0x1c,%esp
  801d6c:	5b                   	pop    %ebx
  801d6d:	5e                   	pop    %esi
  801d6e:	5f                   	pop    %edi
  801d6f:	5d                   	pop    %ebp
  801d70:	c3                   	ret    
  801d71:	8d 76 00             	lea    0x0(%esi),%esi
  801d74:	31 ff                	xor    %edi,%edi
  801d76:	31 c0                	xor    %eax,%eax
  801d78:	89 fa                	mov    %edi,%edx
  801d7a:	83 c4 1c             	add    $0x1c,%esp
  801d7d:	5b                   	pop    %ebx
  801d7e:	5e                   	pop    %esi
  801d7f:	5f                   	pop    %edi
  801d80:	5d                   	pop    %ebp
  801d81:	c3                   	ret    
  801d82:	66 90                	xchg   %ax,%ax
  801d84:	89 d8                	mov    %ebx,%eax
  801d86:	f7 f7                	div    %edi
  801d88:	31 ff                	xor    %edi,%edi
  801d8a:	89 fa                	mov    %edi,%edx
  801d8c:	83 c4 1c             	add    $0x1c,%esp
  801d8f:	5b                   	pop    %ebx
  801d90:	5e                   	pop    %esi
  801d91:	5f                   	pop    %edi
  801d92:	5d                   	pop    %ebp
  801d93:	c3                   	ret    
  801d94:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d99:	89 eb                	mov    %ebp,%ebx
  801d9b:	29 fb                	sub    %edi,%ebx
  801d9d:	89 f9                	mov    %edi,%ecx
  801d9f:	d3 e6                	shl    %cl,%esi
  801da1:	89 c5                	mov    %eax,%ebp
  801da3:	88 d9                	mov    %bl,%cl
  801da5:	d3 ed                	shr    %cl,%ebp
  801da7:	89 e9                	mov    %ebp,%ecx
  801da9:	09 f1                	or     %esi,%ecx
  801dab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801daf:	89 f9                	mov    %edi,%ecx
  801db1:	d3 e0                	shl    %cl,%eax
  801db3:	89 c5                	mov    %eax,%ebp
  801db5:	89 d6                	mov    %edx,%esi
  801db7:	88 d9                	mov    %bl,%cl
  801db9:	d3 ee                	shr    %cl,%esi
  801dbb:	89 f9                	mov    %edi,%ecx
  801dbd:	d3 e2                	shl    %cl,%edx
  801dbf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dc3:	88 d9                	mov    %bl,%cl
  801dc5:	d3 e8                	shr    %cl,%eax
  801dc7:	09 c2                	or     %eax,%edx
  801dc9:	89 d0                	mov    %edx,%eax
  801dcb:	89 f2                	mov    %esi,%edx
  801dcd:	f7 74 24 0c          	divl   0xc(%esp)
  801dd1:	89 d6                	mov    %edx,%esi
  801dd3:	89 c3                	mov    %eax,%ebx
  801dd5:	f7 e5                	mul    %ebp
  801dd7:	39 d6                	cmp    %edx,%esi
  801dd9:	72 19                	jb     801df4 <__udivdi3+0xfc>
  801ddb:	74 0b                	je     801de8 <__udivdi3+0xf0>
  801ddd:	89 d8                	mov    %ebx,%eax
  801ddf:	31 ff                	xor    %edi,%edi
  801de1:	e9 58 ff ff ff       	jmp    801d3e <__udivdi3+0x46>
  801de6:	66 90                	xchg   %ax,%ax
  801de8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dec:	89 f9                	mov    %edi,%ecx
  801dee:	d3 e2                	shl    %cl,%edx
  801df0:	39 c2                	cmp    %eax,%edx
  801df2:	73 e9                	jae    801ddd <__udivdi3+0xe5>
  801df4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801df7:	31 ff                	xor    %edi,%edi
  801df9:	e9 40 ff ff ff       	jmp    801d3e <__udivdi3+0x46>
  801dfe:	66 90                	xchg   %ax,%ax
  801e00:	31 c0                	xor    %eax,%eax
  801e02:	e9 37 ff ff ff       	jmp    801d3e <__udivdi3+0x46>
  801e07:	90                   	nop

00801e08 <__umoddi3>:
  801e08:	55                   	push   %ebp
  801e09:	57                   	push   %edi
  801e0a:	56                   	push   %esi
  801e0b:	53                   	push   %ebx
  801e0c:	83 ec 1c             	sub    $0x1c,%esp
  801e0f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e13:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e1b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e23:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e27:	89 f3                	mov    %esi,%ebx
  801e29:	89 fa                	mov    %edi,%edx
  801e2b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e2f:	89 34 24             	mov    %esi,(%esp)
  801e32:	85 c0                	test   %eax,%eax
  801e34:	75 1a                	jne    801e50 <__umoddi3+0x48>
  801e36:	39 f7                	cmp    %esi,%edi
  801e38:	0f 86 a2 00 00 00    	jbe    801ee0 <__umoddi3+0xd8>
  801e3e:	89 c8                	mov    %ecx,%eax
  801e40:	89 f2                	mov    %esi,%edx
  801e42:	f7 f7                	div    %edi
  801e44:	89 d0                	mov    %edx,%eax
  801e46:	31 d2                	xor    %edx,%edx
  801e48:	83 c4 1c             	add    $0x1c,%esp
  801e4b:	5b                   	pop    %ebx
  801e4c:	5e                   	pop    %esi
  801e4d:	5f                   	pop    %edi
  801e4e:	5d                   	pop    %ebp
  801e4f:	c3                   	ret    
  801e50:	39 f0                	cmp    %esi,%eax
  801e52:	0f 87 ac 00 00 00    	ja     801f04 <__umoddi3+0xfc>
  801e58:	0f bd e8             	bsr    %eax,%ebp
  801e5b:	83 f5 1f             	xor    $0x1f,%ebp
  801e5e:	0f 84 ac 00 00 00    	je     801f10 <__umoddi3+0x108>
  801e64:	bf 20 00 00 00       	mov    $0x20,%edi
  801e69:	29 ef                	sub    %ebp,%edi
  801e6b:	89 fe                	mov    %edi,%esi
  801e6d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e71:	89 e9                	mov    %ebp,%ecx
  801e73:	d3 e0                	shl    %cl,%eax
  801e75:	89 d7                	mov    %edx,%edi
  801e77:	89 f1                	mov    %esi,%ecx
  801e79:	d3 ef                	shr    %cl,%edi
  801e7b:	09 c7                	or     %eax,%edi
  801e7d:	89 e9                	mov    %ebp,%ecx
  801e7f:	d3 e2                	shl    %cl,%edx
  801e81:	89 14 24             	mov    %edx,(%esp)
  801e84:	89 d8                	mov    %ebx,%eax
  801e86:	d3 e0                	shl    %cl,%eax
  801e88:	89 c2                	mov    %eax,%edx
  801e8a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e8e:	d3 e0                	shl    %cl,%eax
  801e90:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e94:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e98:	89 f1                	mov    %esi,%ecx
  801e9a:	d3 e8                	shr    %cl,%eax
  801e9c:	09 d0                	or     %edx,%eax
  801e9e:	d3 eb                	shr    %cl,%ebx
  801ea0:	89 da                	mov    %ebx,%edx
  801ea2:	f7 f7                	div    %edi
  801ea4:	89 d3                	mov    %edx,%ebx
  801ea6:	f7 24 24             	mull   (%esp)
  801ea9:	89 c6                	mov    %eax,%esi
  801eab:	89 d1                	mov    %edx,%ecx
  801ead:	39 d3                	cmp    %edx,%ebx
  801eaf:	0f 82 87 00 00 00    	jb     801f3c <__umoddi3+0x134>
  801eb5:	0f 84 91 00 00 00    	je     801f4c <__umoddi3+0x144>
  801ebb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ebf:	29 f2                	sub    %esi,%edx
  801ec1:	19 cb                	sbb    %ecx,%ebx
  801ec3:	89 d8                	mov    %ebx,%eax
  801ec5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ec9:	d3 e0                	shl    %cl,%eax
  801ecb:	89 e9                	mov    %ebp,%ecx
  801ecd:	d3 ea                	shr    %cl,%edx
  801ecf:	09 d0                	or     %edx,%eax
  801ed1:	89 e9                	mov    %ebp,%ecx
  801ed3:	d3 eb                	shr    %cl,%ebx
  801ed5:	89 da                	mov    %ebx,%edx
  801ed7:	83 c4 1c             	add    $0x1c,%esp
  801eda:	5b                   	pop    %ebx
  801edb:	5e                   	pop    %esi
  801edc:	5f                   	pop    %edi
  801edd:	5d                   	pop    %ebp
  801ede:	c3                   	ret    
  801edf:	90                   	nop
  801ee0:	89 fd                	mov    %edi,%ebp
  801ee2:	85 ff                	test   %edi,%edi
  801ee4:	75 0b                	jne    801ef1 <__umoddi3+0xe9>
  801ee6:	b8 01 00 00 00       	mov    $0x1,%eax
  801eeb:	31 d2                	xor    %edx,%edx
  801eed:	f7 f7                	div    %edi
  801eef:	89 c5                	mov    %eax,%ebp
  801ef1:	89 f0                	mov    %esi,%eax
  801ef3:	31 d2                	xor    %edx,%edx
  801ef5:	f7 f5                	div    %ebp
  801ef7:	89 c8                	mov    %ecx,%eax
  801ef9:	f7 f5                	div    %ebp
  801efb:	89 d0                	mov    %edx,%eax
  801efd:	e9 44 ff ff ff       	jmp    801e46 <__umoddi3+0x3e>
  801f02:	66 90                	xchg   %ax,%ax
  801f04:	89 c8                	mov    %ecx,%eax
  801f06:	89 f2                	mov    %esi,%edx
  801f08:	83 c4 1c             	add    $0x1c,%esp
  801f0b:	5b                   	pop    %ebx
  801f0c:	5e                   	pop    %esi
  801f0d:	5f                   	pop    %edi
  801f0e:	5d                   	pop    %ebp
  801f0f:	c3                   	ret    
  801f10:	3b 04 24             	cmp    (%esp),%eax
  801f13:	72 06                	jb     801f1b <__umoddi3+0x113>
  801f15:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f19:	77 0f                	ja     801f2a <__umoddi3+0x122>
  801f1b:	89 f2                	mov    %esi,%edx
  801f1d:	29 f9                	sub    %edi,%ecx
  801f1f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f23:	89 14 24             	mov    %edx,(%esp)
  801f26:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f2a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f2e:	8b 14 24             	mov    (%esp),%edx
  801f31:	83 c4 1c             	add    $0x1c,%esp
  801f34:	5b                   	pop    %ebx
  801f35:	5e                   	pop    %esi
  801f36:	5f                   	pop    %edi
  801f37:	5d                   	pop    %ebp
  801f38:	c3                   	ret    
  801f39:	8d 76 00             	lea    0x0(%esi),%esi
  801f3c:	2b 04 24             	sub    (%esp),%eax
  801f3f:	19 fa                	sbb    %edi,%edx
  801f41:	89 d1                	mov    %edx,%ecx
  801f43:	89 c6                	mov    %eax,%esi
  801f45:	e9 71 ff ff ff       	jmp    801ebb <__umoddi3+0xb3>
  801f4a:	66 90                	xchg   %ax,%ax
  801f4c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f50:	72 ea                	jb     801f3c <__umoddi3+0x134>
  801f52:	89 d9                	mov    %ebx,%ecx
  801f54:	e9 62 ff ff ff       	jmp    801ebb <__umoddi3+0xb3>
