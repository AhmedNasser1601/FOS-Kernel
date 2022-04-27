
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 45 03 00 00       	call   80037b <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 60 1d 80 00       	push   $0x801d60
  800066:	6a 12                	push   $0x12
  800068:	68 a4 1d 80 00       	push   $0x801da4
  80006d:	e8 18 04 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007d:	83 c0 0c             	add    $0xc,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 60 1d 80 00       	push   $0x801d60
  80009c:	6a 13                	push   $0x13
  80009e:	68 a4 1d 80 00       	push   $0x801da4
  8000a3:	e8 e2 03 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b3:	83 c0 18             	add    $0x18,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 60 1d 80 00       	push   $0x801d60
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 a4 1d 80 00       	push   $0x801da4
  8000d9:	e8 ac 03 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e9:	83 c0 24             	add    $0x24,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 60 1d 80 00       	push   $0x801d60
  800108:	6a 15                	push   $0x15
  80010a:	68 a4 1d 80 00       	push   $0x801da4
  80010f:	e8 76 03 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011f:	83 c0 30             	add    $0x30,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 60 1d 80 00       	push   $0x801d60
  80013e:	6a 16                	push   $0x16
  800140:	68 a4 1d 80 00       	push   $0x801da4
  800145:	e8 40 03 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800155:	83 c0 3c             	add    $0x3c,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 60 1d 80 00       	push   $0x801d60
  800174:	6a 17                	push   $0x17
  800176:	68 a4 1d 80 00       	push   $0x801da4
  80017b:	e8 0a 03 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018b:	83 c0 48             	add    $0x48,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 60 1d 80 00       	push   $0x801d60
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 a4 1d 80 00       	push   $0x801da4
  8001b1:	e8 d4 02 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c1:	83 c0 54             	add    $0x54,%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 60 1d 80 00       	push   $0x801d60
  8001e0:	6a 19                	push   $0x19
  8001e2:	68 a4 1d 80 00       	push   $0x801da4
  8001e7:	e8 9e 02 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f7:	83 c0 60             	add    $0x60,%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800207:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020c:	74 14                	je     800222 <_main+0x1ea>
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	68 60 1d 80 00       	push   $0x801d60
  800216:	6a 1a                	push   $0x1a
  800218:	68 a4 1d 80 00       	push   $0x801da4
  80021d:	e8 68 02 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022d:	83 c0 6c             	add    $0x6c,%eax
  800230:	8b 00                	mov    (%eax),%eax
  800232:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800235:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800238:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023d:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800242:	74 14                	je     800258 <_main+0x220>
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	68 60 1d 80 00       	push   $0x801d60
  80024c:	6a 1b                	push   $0x1b
  80024e:	68 a4 1d 80 00       	push   $0x801da4
  800253:	e8 32 02 00 00       	call   80048a <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800263:	83 c0 78             	add    $0x78,%eax
  800266:	8b 00                	mov    (%eax),%eax
  800268:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800273:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800278:	74 14                	je     80028e <_main+0x256>
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	68 60 1d 80 00       	push   $0x801d60
  800282:	6a 1c                	push   $0x1c
  800284:	68 a4 1d 80 00       	push   $0x801da4
  800289:	e8 fc 01 00 00       	call   80048a <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028e:	a1 20 30 80 00       	mov    0x803020,%eax
  800293:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800299:	85 c0                	test   %eax,%eax
  80029b:	74 14                	je     8002b1 <_main+0x279>
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	68 c8 1d 80 00       	push   $0x801dc8
  8002a5:	6a 1d                	push   $0x1d
  8002a7:	68 a4 1d 80 00       	push   $0x801da4
  8002ac:	e8 d9 01 00 00       	call   80048a <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b1:	e8 7e 13 00 00       	call   801634 <sys_calculate_free_frames>
  8002b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b9:	e8 f9 13 00 00       	call   8016b7 <sys_pf_calculate_allocated_pages>
  8002be:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c1:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002c6:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002c9:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002ce:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002d8:	eb 37                	jmp    800311 <_main+0x2d9>
	{
		arr[i] = -1 ;
  8002da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002dd:	05 40 30 80 00       	add    $0x803040,%eax
  8002e2:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002e5:	a1 04 30 80 00       	mov    0x803004,%eax
  8002ea:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002f0:	8a 12                	mov    (%edx),%dl
  8002f2:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002f4:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f9:	40                   	inc    %eax
  8002fa:	a3 00 30 80 00       	mov    %eax,0x803000
  8002ff:	a1 04 30 80 00       	mov    0x803004,%eax
  800304:	40                   	inc    %eax
  800305:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80030a:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800311:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800318:	7e c0                	jle    8002da <_main+0x2a2>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  80031a:	e8 98 13 00 00       	call   8016b7 <sys_pf_calculate_allocated_pages>
  80031f:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800322:	74 14                	je     800338 <_main+0x300>
  800324:	83 ec 04             	sub    $0x4,%esp
  800327:	68 10 1e 80 00       	push   $0x801e10
  80032c:	6a 38                	push   $0x38
  80032e:	68 a4 1d 80 00       	push   $0x801da4
  800333:	e8 52 01 00 00       	call   80048a <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800338:	e8 f7 12 00 00       	call   801634 <sys_calculate_free_frames>
  80033d:	89 c3                	mov    %eax,%ebx
  80033f:	e8 09 13 00 00       	call   80164d <sys_calculate_modified_frames>
  800344:	01 d8                	add    %ebx,%eax
  800346:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800349:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80034c:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  80034f:	74 14                	je     800365 <_main+0x32d>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  800351:	83 ec 04             	sub    $0x4,%esp
  800354:	68 7c 1e 80 00       	push   $0x801e7c
  800359:	6a 3c                	push   $0x3c
  80035b:	68 a4 1d 80 00       	push   $0x801da4
  800360:	e8 25 01 00 00       	call   80048a <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE is completed successfully.\n");
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	68 e0 1e 80 00       	push   $0x801ee0
  80036d:	e8 cc 03 00 00       	call   80073e <cprintf>
  800372:	83 c4 10             	add    $0x10,%esp
	return;
  800375:	90                   	nop
}
  800376:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800379:	c9                   	leave  
  80037a:	c3                   	ret    

0080037b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80037b:	55                   	push   %ebp
  80037c:	89 e5                	mov    %esp,%ebp
  80037e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800381:	e8 e3 11 00 00       	call   801569 <sys_getenvindex>
  800386:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800389:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80038c:	89 d0                	mov    %edx,%eax
  80038e:	c1 e0 02             	shl    $0x2,%eax
  800391:	01 d0                	add    %edx,%eax
  800393:	01 c0                	add    %eax,%eax
  800395:	01 d0                	add    %edx,%eax
  800397:	01 c0                	add    %eax,%eax
  800399:	01 d0                	add    %edx,%eax
  80039b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003a2:	01 d0                	add    %edx,%eax
  8003a4:	c1 e0 02             	shl    $0x2,%eax
  8003a7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003ac:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b6:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8003bc:	84 c0                	test   %al,%al
  8003be:	74 0f                	je     8003cf <libmain+0x54>
		binaryname = myEnv->prog_name;
  8003c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c5:	05 f4 02 00 00       	add    $0x2f4,%eax
  8003ca:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003d3:	7e 0a                	jle    8003df <libmain+0x64>
		binaryname = argv[0];
  8003d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8003df:	83 ec 08             	sub    $0x8,%esp
  8003e2:	ff 75 0c             	pushl  0xc(%ebp)
  8003e5:	ff 75 08             	pushl  0x8(%ebp)
  8003e8:	e8 4b fc ff ff       	call   800038 <_main>
  8003ed:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003f0:	e8 0f 13 00 00       	call   801704 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	68 64 1f 80 00       	push   $0x801f64
  8003fd:	e8 3c 03 00 00       	call   80073e <cprintf>
  800402:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800405:	a1 20 30 80 00       	mov    0x803020,%eax
  80040a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800410:	a1 20 30 80 00       	mov    0x803020,%eax
  800415:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80041b:	83 ec 04             	sub    $0x4,%esp
  80041e:	52                   	push   %edx
  80041f:	50                   	push   %eax
  800420:	68 8c 1f 80 00       	push   $0x801f8c
  800425:	e8 14 03 00 00       	call   80073e <cprintf>
  80042a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80042d:	a1 20 30 80 00       	mov    0x803020,%eax
  800432:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800438:	83 ec 08             	sub    $0x8,%esp
  80043b:	50                   	push   %eax
  80043c:	68 b1 1f 80 00       	push   $0x801fb1
  800441:	e8 f8 02 00 00       	call   80073e <cprintf>
  800446:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800449:	83 ec 0c             	sub    $0xc,%esp
  80044c:	68 64 1f 80 00       	push   $0x801f64
  800451:	e8 e8 02 00 00       	call   80073e <cprintf>
  800456:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800459:	e8 c0 12 00 00       	call   80171e <sys_enable_interrupt>

	// exit gracefully
	exit();
  80045e:	e8 19 00 00 00       	call   80047c <exit>
}
  800463:	90                   	nop
  800464:	c9                   	leave  
  800465:	c3                   	ret    

00800466 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800466:	55                   	push   %ebp
  800467:	89 e5                	mov    %esp,%ebp
  800469:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80046c:	83 ec 0c             	sub    $0xc,%esp
  80046f:	6a 00                	push   $0x0
  800471:	e8 bf 10 00 00       	call   801535 <sys_env_destroy>
  800476:	83 c4 10             	add    $0x10,%esp
}
  800479:	90                   	nop
  80047a:	c9                   	leave  
  80047b:	c3                   	ret    

0080047c <exit>:

void
exit(void)
{
  80047c:	55                   	push   %ebp
  80047d:	89 e5                	mov    %esp,%ebp
  80047f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800482:	e8 14 11 00 00       	call   80159b <sys_env_exit>
}
  800487:	90                   	nop
  800488:	c9                   	leave  
  800489:	c3                   	ret    

0080048a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80048a:	55                   	push   %ebp
  80048b:	89 e5                	mov    %esp,%ebp
  80048d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800490:	8d 45 10             	lea    0x10(%ebp),%eax
  800493:	83 c0 04             	add    $0x4,%eax
  800496:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800499:	a1 48 f0 80 00       	mov    0x80f048,%eax
  80049e:	85 c0                	test   %eax,%eax
  8004a0:	74 16                	je     8004b8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004a2:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	50                   	push   %eax
  8004ab:	68 c8 1f 80 00       	push   $0x801fc8
  8004b0:	e8 89 02 00 00       	call   80073e <cprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004b8:	a1 08 30 80 00       	mov    0x803008,%eax
  8004bd:	ff 75 0c             	pushl  0xc(%ebp)
  8004c0:	ff 75 08             	pushl  0x8(%ebp)
  8004c3:	50                   	push   %eax
  8004c4:	68 cd 1f 80 00       	push   $0x801fcd
  8004c9:	e8 70 02 00 00       	call   80073e <cprintf>
  8004ce:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d4:	83 ec 08             	sub    $0x8,%esp
  8004d7:	ff 75 f4             	pushl  -0xc(%ebp)
  8004da:	50                   	push   %eax
  8004db:	e8 f3 01 00 00       	call   8006d3 <vcprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004e3:	83 ec 08             	sub    $0x8,%esp
  8004e6:	6a 00                	push   $0x0
  8004e8:	68 e9 1f 80 00       	push   $0x801fe9
  8004ed:	e8 e1 01 00 00       	call   8006d3 <vcprintf>
  8004f2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004f5:	e8 82 ff ff ff       	call   80047c <exit>

	// should not return here
	while (1) ;
  8004fa:	eb fe                	jmp    8004fa <_panic+0x70>

008004fc <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004fc:	55                   	push   %ebp
  8004fd:	89 e5                	mov    %esp,%ebp
  8004ff:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800502:	a1 20 30 80 00       	mov    0x803020,%eax
  800507:	8b 50 74             	mov    0x74(%eax),%edx
  80050a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050d:	39 c2                	cmp    %eax,%edx
  80050f:	74 14                	je     800525 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800511:	83 ec 04             	sub    $0x4,%esp
  800514:	68 ec 1f 80 00       	push   $0x801fec
  800519:	6a 26                	push   $0x26
  80051b:	68 38 20 80 00       	push   $0x802038
  800520:	e8 65 ff ff ff       	call   80048a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800525:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80052c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800533:	e9 c2 00 00 00       	jmp    8005fa <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800538:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800542:	8b 45 08             	mov    0x8(%ebp),%eax
  800545:	01 d0                	add    %edx,%eax
  800547:	8b 00                	mov    (%eax),%eax
  800549:	85 c0                	test   %eax,%eax
  80054b:	75 08                	jne    800555 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80054d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800550:	e9 a2 00 00 00       	jmp    8005f7 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800555:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80055c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800563:	eb 69                	jmp    8005ce <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800565:	a1 20 30 80 00       	mov    0x803020,%eax
  80056a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800570:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800573:	89 d0                	mov    %edx,%eax
  800575:	01 c0                	add    %eax,%eax
  800577:	01 d0                	add    %edx,%eax
  800579:	c1 e0 02             	shl    $0x2,%eax
  80057c:	01 c8                	add    %ecx,%eax
  80057e:	8a 40 04             	mov    0x4(%eax),%al
  800581:	84 c0                	test   %al,%al
  800583:	75 46                	jne    8005cb <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800585:	a1 20 30 80 00       	mov    0x803020,%eax
  80058a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800590:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800593:	89 d0                	mov    %edx,%eax
  800595:	01 c0                	add    %eax,%eax
  800597:	01 d0                	add    %edx,%eax
  800599:	c1 e0 02             	shl    $0x2,%eax
  80059c:	01 c8                	add    %ecx,%eax
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005ab:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005be:	39 c2                	cmp    %eax,%edx
  8005c0:	75 09                	jne    8005cb <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8005c2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005c9:	eb 12                	jmp    8005dd <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005cb:	ff 45 e8             	incl   -0x18(%ebp)
  8005ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d3:	8b 50 74             	mov    0x74(%eax),%edx
  8005d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d9:	39 c2                	cmp    %eax,%edx
  8005db:	77 88                	ja     800565 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005e1:	75 14                	jne    8005f7 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8005e3:	83 ec 04             	sub    $0x4,%esp
  8005e6:	68 44 20 80 00       	push   $0x802044
  8005eb:	6a 3a                	push   $0x3a
  8005ed:	68 38 20 80 00       	push   $0x802038
  8005f2:	e8 93 fe ff ff       	call   80048a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005f7:	ff 45 f0             	incl   -0x10(%ebp)
  8005fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005fd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800600:	0f 8c 32 ff ff ff    	jl     800538 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800606:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80060d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800614:	eb 26                	jmp    80063c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800616:	a1 20 30 80 00       	mov    0x803020,%eax
  80061b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800621:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800624:	89 d0                	mov    %edx,%eax
  800626:	01 c0                	add    %eax,%eax
  800628:	01 d0                	add    %edx,%eax
  80062a:	c1 e0 02             	shl    $0x2,%eax
  80062d:	01 c8                	add    %ecx,%eax
  80062f:	8a 40 04             	mov    0x4(%eax),%al
  800632:	3c 01                	cmp    $0x1,%al
  800634:	75 03                	jne    800639 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800636:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800639:	ff 45 e0             	incl   -0x20(%ebp)
  80063c:	a1 20 30 80 00       	mov    0x803020,%eax
  800641:	8b 50 74             	mov    0x74(%eax),%edx
  800644:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800647:	39 c2                	cmp    %eax,%edx
  800649:	77 cb                	ja     800616 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80064b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80064e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800651:	74 14                	je     800667 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800653:	83 ec 04             	sub    $0x4,%esp
  800656:	68 98 20 80 00       	push   $0x802098
  80065b:	6a 44                	push   $0x44
  80065d:	68 38 20 80 00       	push   $0x802038
  800662:	e8 23 fe ff ff       	call   80048a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800667:	90                   	nop
  800668:	c9                   	leave  
  800669:	c3                   	ret    

0080066a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80066a:	55                   	push   %ebp
  80066b:	89 e5                	mov    %esp,%ebp
  80066d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800670:	8b 45 0c             	mov    0xc(%ebp),%eax
  800673:	8b 00                	mov    (%eax),%eax
  800675:	8d 48 01             	lea    0x1(%eax),%ecx
  800678:	8b 55 0c             	mov    0xc(%ebp),%edx
  80067b:	89 0a                	mov    %ecx,(%edx)
  80067d:	8b 55 08             	mov    0x8(%ebp),%edx
  800680:	88 d1                	mov    %dl,%cl
  800682:	8b 55 0c             	mov    0xc(%ebp),%edx
  800685:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800689:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068c:	8b 00                	mov    (%eax),%eax
  80068e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800693:	75 2c                	jne    8006c1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800695:	a0 24 30 80 00       	mov    0x803024,%al
  80069a:	0f b6 c0             	movzbl %al,%eax
  80069d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a0:	8b 12                	mov    (%edx),%edx
  8006a2:	89 d1                	mov    %edx,%ecx
  8006a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a7:	83 c2 08             	add    $0x8,%edx
  8006aa:	83 ec 04             	sub    $0x4,%esp
  8006ad:	50                   	push   %eax
  8006ae:	51                   	push   %ecx
  8006af:	52                   	push   %edx
  8006b0:	e8 3e 0e 00 00       	call   8014f3 <sys_cputs>
  8006b5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c4:	8b 40 04             	mov    0x4(%eax),%eax
  8006c7:	8d 50 01             	lea    0x1(%eax),%edx
  8006ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006cd:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006d0:	90                   	nop
  8006d1:	c9                   	leave  
  8006d2:	c3                   	ret    

008006d3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006d3:	55                   	push   %ebp
  8006d4:	89 e5                	mov    %esp,%ebp
  8006d6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006dc:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006e3:	00 00 00 
	b.cnt = 0;
  8006e6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006ed:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006f0:	ff 75 0c             	pushl  0xc(%ebp)
  8006f3:	ff 75 08             	pushl  0x8(%ebp)
  8006f6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006fc:	50                   	push   %eax
  8006fd:	68 6a 06 80 00       	push   $0x80066a
  800702:	e8 11 02 00 00       	call   800918 <vprintfmt>
  800707:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80070a:	a0 24 30 80 00       	mov    0x803024,%al
  80070f:	0f b6 c0             	movzbl %al,%eax
  800712:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800718:	83 ec 04             	sub    $0x4,%esp
  80071b:	50                   	push   %eax
  80071c:	52                   	push   %edx
  80071d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800723:	83 c0 08             	add    $0x8,%eax
  800726:	50                   	push   %eax
  800727:	e8 c7 0d 00 00       	call   8014f3 <sys_cputs>
  80072c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80072f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800736:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <cprintf>:

int cprintf(const char *fmt, ...) {
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800744:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80074b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80074e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 f4             	pushl  -0xc(%ebp)
  80075a:	50                   	push   %eax
  80075b:	e8 73 ff ff ff       	call   8006d3 <vcprintf>
  800760:	83 c4 10             	add    $0x10,%esp
  800763:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800766:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800769:	c9                   	leave  
  80076a:	c3                   	ret    

0080076b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80076b:	55                   	push   %ebp
  80076c:	89 e5                	mov    %esp,%ebp
  80076e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800771:	e8 8e 0f 00 00       	call   801704 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800776:	8d 45 0c             	lea    0xc(%ebp),%eax
  800779:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	83 ec 08             	sub    $0x8,%esp
  800782:	ff 75 f4             	pushl  -0xc(%ebp)
  800785:	50                   	push   %eax
  800786:	e8 48 ff ff ff       	call   8006d3 <vcprintf>
  80078b:	83 c4 10             	add    $0x10,%esp
  80078e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800791:	e8 88 0f 00 00       	call   80171e <sys_enable_interrupt>
	return cnt;
  800796:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800799:	c9                   	leave  
  80079a:	c3                   	ret    

0080079b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80079b:	55                   	push   %ebp
  80079c:	89 e5                	mov    %esp,%ebp
  80079e:	53                   	push   %ebx
  80079f:	83 ec 14             	sub    $0x14,%esp
  8007a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007ae:	8b 45 18             	mov    0x18(%ebp),%eax
  8007b1:	ba 00 00 00 00       	mov    $0x0,%edx
  8007b6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007b9:	77 55                	ja     800810 <printnum+0x75>
  8007bb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007be:	72 05                	jb     8007c5 <printnum+0x2a>
  8007c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007c3:	77 4b                	ja     800810 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007c5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007c8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007cb:	8b 45 18             	mov    0x18(%ebp),%eax
  8007ce:	ba 00 00 00 00       	mov    $0x0,%edx
  8007d3:	52                   	push   %edx
  8007d4:	50                   	push   %eax
  8007d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d8:	ff 75 f0             	pushl  -0x10(%ebp)
  8007db:	e8 04 13 00 00       	call   801ae4 <__udivdi3>
  8007e0:	83 c4 10             	add    $0x10,%esp
  8007e3:	83 ec 04             	sub    $0x4,%esp
  8007e6:	ff 75 20             	pushl  0x20(%ebp)
  8007e9:	53                   	push   %ebx
  8007ea:	ff 75 18             	pushl  0x18(%ebp)
  8007ed:	52                   	push   %edx
  8007ee:	50                   	push   %eax
  8007ef:	ff 75 0c             	pushl  0xc(%ebp)
  8007f2:	ff 75 08             	pushl  0x8(%ebp)
  8007f5:	e8 a1 ff ff ff       	call   80079b <printnum>
  8007fa:	83 c4 20             	add    $0x20,%esp
  8007fd:	eb 1a                	jmp    800819 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007ff:	83 ec 08             	sub    $0x8,%esp
  800802:	ff 75 0c             	pushl  0xc(%ebp)
  800805:	ff 75 20             	pushl  0x20(%ebp)
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800810:	ff 4d 1c             	decl   0x1c(%ebp)
  800813:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800817:	7f e6                	jg     8007ff <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800819:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80081c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800821:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800824:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800827:	53                   	push   %ebx
  800828:	51                   	push   %ecx
  800829:	52                   	push   %edx
  80082a:	50                   	push   %eax
  80082b:	e8 c4 13 00 00       	call   801bf4 <__umoddi3>
  800830:	83 c4 10             	add    $0x10,%esp
  800833:	05 14 23 80 00       	add    $0x802314,%eax
  800838:	8a 00                	mov    (%eax),%al
  80083a:	0f be c0             	movsbl %al,%eax
  80083d:	83 ec 08             	sub    $0x8,%esp
  800840:	ff 75 0c             	pushl  0xc(%ebp)
  800843:	50                   	push   %eax
  800844:	8b 45 08             	mov    0x8(%ebp),%eax
  800847:	ff d0                	call   *%eax
  800849:	83 c4 10             	add    $0x10,%esp
}
  80084c:	90                   	nop
  80084d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800850:	c9                   	leave  
  800851:	c3                   	ret    

00800852 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800852:	55                   	push   %ebp
  800853:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800855:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800859:	7e 1c                	jle    800877 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	8d 50 08             	lea    0x8(%eax),%edx
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	89 10                	mov    %edx,(%eax)
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	83 e8 08             	sub    $0x8,%eax
  800870:	8b 50 04             	mov    0x4(%eax),%edx
  800873:	8b 00                	mov    (%eax),%eax
  800875:	eb 40                	jmp    8008b7 <getuint+0x65>
	else if (lflag)
  800877:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80087b:	74 1e                	je     80089b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 50 04             	lea    0x4(%eax),%edx
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	89 10                	mov    %edx,(%eax)
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	8b 00                	mov    (%eax),%eax
  80088f:	83 e8 04             	sub    $0x4,%eax
  800892:	8b 00                	mov    (%eax),%eax
  800894:	ba 00 00 00 00       	mov    $0x0,%edx
  800899:	eb 1c                	jmp    8008b7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	8d 50 04             	lea    0x4(%eax),%edx
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	89 10                	mov    %edx,(%eax)
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	8b 00                	mov    (%eax),%eax
  8008ad:	83 e8 04             	sub    $0x4,%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008b7:	5d                   	pop    %ebp
  8008b8:	c3                   	ret    

008008b9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008bc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008c0:	7e 1c                	jle    8008de <getint+0x25>
		return va_arg(*ap, long long);
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	8d 50 08             	lea    0x8(%eax),%edx
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	89 10                	mov    %edx,(%eax)
  8008cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	83 e8 08             	sub    $0x8,%eax
  8008d7:	8b 50 04             	mov    0x4(%eax),%edx
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	eb 38                	jmp    800916 <getint+0x5d>
	else if (lflag)
  8008de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e2:	74 1a                	je     8008fe <getint+0x45>
		return va_arg(*ap, long);
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	8d 50 04             	lea    0x4(%eax),%edx
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	89 10                	mov    %edx,(%eax)
  8008f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f4:	8b 00                	mov    (%eax),%eax
  8008f6:	83 e8 04             	sub    $0x4,%eax
  8008f9:	8b 00                	mov    (%eax),%eax
  8008fb:	99                   	cltd   
  8008fc:	eb 18                	jmp    800916 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800901:	8b 00                	mov    (%eax),%eax
  800903:	8d 50 04             	lea    0x4(%eax),%edx
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	89 10                	mov    %edx,(%eax)
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	8b 00                	mov    (%eax),%eax
  800910:	83 e8 04             	sub    $0x4,%eax
  800913:	8b 00                	mov    (%eax),%eax
  800915:	99                   	cltd   
}
  800916:	5d                   	pop    %ebp
  800917:	c3                   	ret    

00800918 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800918:	55                   	push   %ebp
  800919:	89 e5                	mov    %esp,%ebp
  80091b:	56                   	push   %esi
  80091c:	53                   	push   %ebx
  80091d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800920:	eb 17                	jmp    800939 <vprintfmt+0x21>
			if (ch == '\0')
  800922:	85 db                	test   %ebx,%ebx
  800924:	0f 84 af 03 00 00    	je     800cd9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	53                   	push   %ebx
  800931:	8b 45 08             	mov    0x8(%ebp),%eax
  800934:	ff d0                	call   *%eax
  800936:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800939:	8b 45 10             	mov    0x10(%ebp),%eax
  80093c:	8d 50 01             	lea    0x1(%eax),%edx
  80093f:	89 55 10             	mov    %edx,0x10(%ebp)
  800942:	8a 00                	mov    (%eax),%al
  800944:	0f b6 d8             	movzbl %al,%ebx
  800947:	83 fb 25             	cmp    $0x25,%ebx
  80094a:	75 d6                	jne    800922 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80094c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800950:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800957:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80095e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800965:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80096c:	8b 45 10             	mov    0x10(%ebp),%eax
  80096f:	8d 50 01             	lea    0x1(%eax),%edx
  800972:	89 55 10             	mov    %edx,0x10(%ebp)
  800975:	8a 00                	mov    (%eax),%al
  800977:	0f b6 d8             	movzbl %al,%ebx
  80097a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80097d:	83 f8 55             	cmp    $0x55,%eax
  800980:	0f 87 2b 03 00 00    	ja     800cb1 <vprintfmt+0x399>
  800986:	8b 04 85 38 23 80 00 	mov    0x802338(,%eax,4),%eax
  80098d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80098f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800993:	eb d7                	jmp    80096c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800995:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800999:	eb d1                	jmp    80096c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80099b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009a5:	89 d0                	mov    %edx,%eax
  8009a7:	c1 e0 02             	shl    $0x2,%eax
  8009aa:	01 d0                	add    %edx,%eax
  8009ac:	01 c0                	add    %eax,%eax
  8009ae:	01 d8                	add    %ebx,%eax
  8009b0:	83 e8 30             	sub    $0x30,%eax
  8009b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b9:	8a 00                	mov    (%eax),%al
  8009bb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009be:	83 fb 2f             	cmp    $0x2f,%ebx
  8009c1:	7e 3e                	jle    800a01 <vprintfmt+0xe9>
  8009c3:	83 fb 39             	cmp    $0x39,%ebx
  8009c6:	7f 39                	jg     800a01 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009c8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009cb:	eb d5                	jmp    8009a2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d0:	83 c0 04             	add    $0x4,%eax
  8009d3:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d9:	83 e8 04             	sub    $0x4,%eax
  8009dc:	8b 00                	mov    (%eax),%eax
  8009de:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009e1:	eb 1f                	jmp    800a02 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e7:	79 83                	jns    80096c <vprintfmt+0x54>
				width = 0;
  8009e9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009f0:	e9 77 ff ff ff       	jmp    80096c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009f5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009fc:	e9 6b ff ff ff       	jmp    80096c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a01:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a06:	0f 89 60 ff ff ff    	jns    80096c <vprintfmt+0x54>
				width = precision, precision = -1;
  800a0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a12:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a19:	e9 4e ff ff ff       	jmp    80096c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a1e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a21:	e9 46 ff ff ff       	jmp    80096c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a26:	8b 45 14             	mov    0x14(%ebp),%eax
  800a29:	83 c0 04             	add    $0x4,%eax
  800a2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a32:	83 e8 04             	sub    $0x4,%eax
  800a35:	8b 00                	mov    (%eax),%eax
  800a37:	83 ec 08             	sub    $0x8,%esp
  800a3a:	ff 75 0c             	pushl  0xc(%ebp)
  800a3d:	50                   	push   %eax
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	ff d0                	call   *%eax
  800a43:	83 c4 10             	add    $0x10,%esp
			break;
  800a46:	e9 89 02 00 00       	jmp    800cd4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4e:	83 c0 04             	add    $0x4,%eax
  800a51:	89 45 14             	mov    %eax,0x14(%ebp)
  800a54:	8b 45 14             	mov    0x14(%ebp),%eax
  800a57:	83 e8 04             	sub    $0x4,%eax
  800a5a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a5c:	85 db                	test   %ebx,%ebx
  800a5e:	79 02                	jns    800a62 <vprintfmt+0x14a>
				err = -err;
  800a60:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a62:	83 fb 64             	cmp    $0x64,%ebx
  800a65:	7f 0b                	jg     800a72 <vprintfmt+0x15a>
  800a67:	8b 34 9d 80 21 80 00 	mov    0x802180(,%ebx,4),%esi
  800a6e:	85 f6                	test   %esi,%esi
  800a70:	75 19                	jne    800a8b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a72:	53                   	push   %ebx
  800a73:	68 25 23 80 00       	push   $0x802325
  800a78:	ff 75 0c             	pushl  0xc(%ebp)
  800a7b:	ff 75 08             	pushl  0x8(%ebp)
  800a7e:	e8 5e 02 00 00       	call   800ce1 <printfmt>
  800a83:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a86:	e9 49 02 00 00       	jmp    800cd4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a8b:	56                   	push   %esi
  800a8c:	68 2e 23 80 00       	push   $0x80232e
  800a91:	ff 75 0c             	pushl  0xc(%ebp)
  800a94:	ff 75 08             	pushl  0x8(%ebp)
  800a97:	e8 45 02 00 00       	call   800ce1 <printfmt>
  800a9c:	83 c4 10             	add    $0x10,%esp
			break;
  800a9f:	e9 30 02 00 00       	jmp    800cd4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aa4:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa7:	83 c0 04             	add    $0x4,%eax
  800aaa:	89 45 14             	mov    %eax,0x14(%ebp)
  800aad:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab0:	83 e8 04             	sub    $0x4,%eax
  800ab3:	8b 30                	mov    (%eax),%esi
  800ab5:	85 f6                	test   %esi,%esi
  800ab7:	75 05                	jne    800abe <vprintfmt+0x1a6>
				p = "(null)";
  800ab9:	be 31 23 80 00       	mov    $0x802331,%esi
			if (width > 0 && padc != '-')
  800abe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac2:	7e 6d                	jle    800b31 <vprintfmt+0x219>
  800ac4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ac8:	74 67                	je     800b31 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800aca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800acd:	83 ec 08             	sub    $0x8,%esp
  800ad0:	50                   	push   %eax
  800ad1:	56                   	push   %esi
  800ad2:	e8 0c 03 00 00       	call   800de3 <strnlen>
  800ad7:	83 c4 10             	add    $0x10,%esp
  800ada:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800add:	eb 16                	jmp    800af5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800adf:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	50                   	push   %eax
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800af2:	ff 4d e4             	decl   -0x1c(%ebp)
  800af5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800af9:	7f e4                	jg     800adf <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800afb:	eb 34                	jmp    800b31 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800afd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b01:	74 1c                	je     800b1f <vprintfmt+0x207>
  800b03:	83 fb 1f             	cmp    $0x1f,%ebx
  800b06:	7e 05                	jle    800b0d <vprintfmt+0x1f5>
  800b08:	83 fb 7e             	cmp    $0x7e,%ebx
  800b0b:	7e 12                	jle    800b1f <vprintfmt+0x207>
					putch('?', putdat);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 0c             	pushl  0xc(%ebp)
  800b13:	6a 3f                	push   $0x3f
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	ff d0                	call   *%eax
  800b1a:	83 c4 10             	add    $0x10,%esp
  800b1d:	eb 0f                	jmp    800b2e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b1f:	83 ec 08             	sub    $0x8,%esp
  800b22:	ff 75 0c             	pushl  0xc(%ebp)
  800b25:	53                   	push   %ebx
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	ff d0                	call   *%eax
  800b2b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b2e:	ff 4d e4             	decl   -0x1c(%ebp)
  800b31:	89 f0                	mov    %esi,%eax
  800b33:	8d 70 01             	lea    0x1(%eax),%esi
  800b36:	8a 00                	mov    (%eax),%al
  800b38:	0f be d8             	movsbl %al,%ebx
  800b3b:	85 db                	test   %ebx,%ebx
  800b3d:	74 24                	je     800b63 <vprintfmt+0x24b>
  800b3f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b43:	78 b8                	js     800afd <vprintfmt+0x1e5>
  800b45:	ff 4d e0             	decl   -0x20(%ebp)
  800b48:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b4c:	79 af                	jns    800afd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b4e:	eb 13                	jmp    800b63 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b50:	83 ec 08             	sub    $0x8,%esp
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	6a 20                	push   $0x20
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	ff d0                	call   *%eax
  800b5d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b60:	ff 4d e4             	decl   -0x1c(%ebp)
  800b63:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b67:	7f e7                	jg     800b50 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b69:	e9 66 01 00 00       	jmp    800cd4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b6e:	83 ec 08             	sub    $0x8,%esp
  800b71:	ff 75 e8             	pushl  -0x18(%ebp)
  800b74:	8d 45 14             	lea    0x14(%ebp),%eax
  800b77:	50                   	push   %eax
  800b78:	e8 3c fd ff ff       	call   8008b9 <getint>
  800b7d:	83 c4 10             	add    $0x10,%esp
  800b80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b83:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b8c:	85 d2                	test   %edx,%edx
  800b8e:	79 23                	jns    800bb3 <vprintfmt+0x29b>
				putch('-', putdat);
  800b90:	83 ec 08             	sub    $0x8,%esp
  800b93:	ff 75 0c             	pushl  0xc(%ebp)
  800b96:	6a 2d                	push   $0x2d
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	ff d0                	call   *%eax
  800b9d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ba0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ba3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ba6:	f7 d8                	neg    %eax
  800ba8:	83 d2 00             	adc    $0x0,%edx
  800bab:	f7 da                	neg    %edx
  800bad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bb3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bba:	e9 bc 00 00 00       	jmp    800c7b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 e8             	pushl  -0x18(%ebp)
  800bc5:	8d 45 14             	lea    0x14(%ebp),%eax
  800bc8:	50                   	push   %eax
  800bc9:	e8 84 fc ff ff       	call   800852 <getuint>
  800bce:	83 c4 10             	add    $0x10,%esp
  800bd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bd7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bde:	e9 98 00 00 00       	jmp    800c7b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800be3:	83 ec 08             	sub    $0x8,%esp
  800be6:	ff 75 0c             	pushl  0xc(%ebp)
  800be9:	6a 58                	push   $0x58
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	ff d0                	call   *%eax
  800bf0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bf3:	83 ec 08             	sub    $0x8,%esp
  800bf6:	ff 75 0c             	pushl  0xc(%ebp)
  800bf9:	6a 58                	push   $0x58
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	ff d0                	call   *%eax
  800c00:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c03:	83 ec 08             	sub    $0x8,%esp
  800c06:	ff 75 0c             	pushl  0xc(%ebp)
  800c09:	6a 58                	push   $0x58
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	ff d0                	call   *%eax
  800c10:	83 c4 10             	add    $0x10,%esp
			break;
  800c13:	e9 bc 00 00 00       	jmp    800cd4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c18:	83 ec 08             	sub    $0x8,%esp
  800c1b:	ff 75 0c             	pushl  0xc(%ebp)
  800c1e:	6a 30                	push   $0x30
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	ff d0                	call   *%eax
  800c25:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c28:	83 ec 08             	sub    $0x8,%esp
  800c2b:	ff 75 0c             	pushl  0xc(%ebp)
  800c2e:	6a 78                	push   $0x78
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	ff d0                	call   *%eax
  800c35:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c38:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3b:	83 c0 04             	add    $0x4,%eax
  800c3e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c41:	8b 45 14             	mov    0x14(%ebp),%eax
  800c44:	83 e8 04             	sub    $0x4,%eax
  800c47:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c53:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c5a:	eb 1f                	jmp    800c7b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c5c:	83 ec 08             	sub    $0x8,%esp
  800c5f:	ff 75 e8             	pushl  -0x18(%ebp)
  800c62:	8d 45 14             	lea    0x14(%ebp),%eax
  800c65:	50                   	push   %eax
  800c66:	e8 e7 fb ff ff       	call   800852 <getuint>
  800c6b:	83 c4 10             	add    $0x10,%esp
  800c6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c71:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c74:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c7b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c82:	83 ec 04             	sub    $0x4,%esp
  800c85:	52                   	push   %edx
  800c86:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c89:	50                   	push   %eax
  800c8a:	ff 75 f4             	pushl  -0xc(%ebp)
  800c8d:	ff 75 f0             	pushl  -0x10(%ebp)
  800c90:	ff 75 0c             	pushl  0xc(%ebp)
  800c93:	ff 75 08             	pushl  0x8(%ebp)
  800c96:	e8 00 fb ff ff       	call   80079b <printnum>
  800c9b:	83 c4 20             	add    $0x20,%esp
			break;
  800c9e:	eb 34                	jmp    800cd4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 0c             	pushl  0xc(%ebp)
  800ca6:	53                   	push   %ebx
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
			break;
  800caf:	eb 23                	jmp    800cd4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cb1:	83 ec 08             	sub    $0x8,%esp
  800cb4:	ff 75 0c             	pushl  0xc(%ebp)
  800cb7:	6a 25                	push   $0x25
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	ff d0                	call   *%eax
  800cbe:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cc1:	ff 4d 10             	decl   0x10(%ebp)
  800cc4:	eb 03                	jmp    800cc9 <vprintfmt+0x3b1>
  800cc6:	ff 4d 10             	decl   0x10(%ebp)
  800cc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccc:	48                   	dec    %eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	3c 25                	cmp    $0x25,%al
  800cd1:	75 f3                	jne    800cc6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cd3:	90                   	nop
		}
	}
  800cd4:	e9 47 fc ff ff       	jmp    800920 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cd9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cda:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cdd:	5b                   	pop    %ebx
  800cde:	5e                   	pop    %esi
  800cdf:	5d                   	pop    %ebp
  800ce0:	c3                   	ret    

00800ce1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ce1:	55                   	push   %ebp
  800ce2:	89 e5                	mov    %esp,%ebp
  800ce4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ce7:	8d 45 10             	lea    0x10(%ebp),%eax
  800cea:	83 c0 04             	add    $0x4,%eax
  800ced:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf3:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf6:	50                   	push   %eax
  800cf7:	ff 75 0c             	pushl  0xc(%ebp)
  800cfa:	ff 75 08             	pushl  0x8(%ebp)
  800cfd:	e8 16 fc ff ff       	call   800918 <vprintfmt>
  800d02:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d05:	90                   	nop
  800d06:	c9                   	leave  
  800d07:	c3                   	ret    

00800d08 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d08:	55                   	push   %ebp
  800d09:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0e:	8b 40 08             	mov    0x8(%eax),%eax
  800d11:	8d 50 01             	lea    0x1(%eax),%edx
  800d14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d17:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	8b 10                	mov    (%eax),%edx
  800d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d22:	8b 40 04             	mov    0x4(%eax),%eax
  800d25:	39 c2                	cmp    %eax,%edx
  800d27:	73 12                	jae    800d3b <sprintputch+0x33>
		*b->buf++ = ch;
  800d29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2c:	8b 00                	mov    (%eax),%eax
  800d2e:	8d 48 01             	lea    0x1(%eax),%ecx
  800d31:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d34:	89 0a                	mov    %ecx,(%edx)
  800d36:	8b 55 08             	mov    0x8(%ebp),%edx
  800d39:	88 10                	mov    %dl,(%eax)
}
  800d3b:	90                   	nop
  800d3c:	5d                   	pop    %ebp
  800d3d:	c3                   	ret    

00800d3e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	01 d0                	add    %edx,%eax
  800d55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d5f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d63:	74 06                	je     800d6b <vsnprintf+0x2d>
  800d65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d69:	7f 07                	jg     800d72 <vsnprintf+0x34>
		return -E_INVAL;
  800d6b:	b8 03 00 00 00       	mov    $0x3,%eax
  800d70:	eb 20                	jmp    800d92 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d72:	ff 75 14             	pushl  0x14(%ebp)
  800d75:	ff 75 10             	pushl  0x10(%ebp)
  800d78:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d7b:	50                   	push   %eax
  800d7c:	68 08 0d 80 00       	push   $0x800d08
  800d81:	e8 92 fb ff ff       	call   800918 <vprintfmt>
  800d86:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d89:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d8c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d92:	c9                   	leave  
  800d93:	c3                   	ret    

00800d94 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
  800d97:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d9a:	8d 45 10             	lea    0x10(%ebp),%eax
  800d9d:	83 c0 04             	add    $0x4,%eax
  800da0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800da3:	8b 45 10             	mov    0x10(%ebp),%eax
  800da6:	ff 75 f4             	pushl  -0xc(%ebp)
  800da9:	50                   	push   %eax
  800daa:	ff 75 0c             	pushl  0xc(%ebp)
  800dad:	ff 75 08             	pushl  0x8(%ebp)
  800db0:	e8 89 ff ff ff       	call   800d3e <vsnprintf>
  800db5:	83 c4 10             	add    $0x10,%esp
  800db8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dbe:	c9                   	leave  
  800dbf:	c3                   	ret    

00800dc0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dc0:	55                   	push   %ebp
  800dc1:	89 e5                	mov    %esp,%ebp
  800dc3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dc6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dcd:	eb 06                	jmp    800dd5 <strlen+0x15>
		n++;
  800dcf:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dd2:	ff 45 08             	incl   0x8(%ebp)
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	84 c0                	test   %al,%al
  800ddc:	75 f1                	jne    800dcf <strlen+0xf>
		n++;
	return n;
  800dde:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de1:	c9                   	leave  
  800de2:	c3                   	ret    

00800de3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800de3:	55                   	push   %ebp
  800de4:	89 e5                	mov    %esp,%ebp
  800de6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800de9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df0:	eb 09                	jmp    800dfb <strnlen+0x18>
		n++;
  800df2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800df5:	ff 45 08             	incl   0x8(%ebp)
  800df8:	ff 4d 0c             	decl   0xc(%ebp)
  800dfb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dff:	74 09                	je     800e0a <strnlen+0x27>
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	84 c0                	test   %al,%al
  800e08:	75 e8                	jne    800df2 <strnlen+0xf>
		n++;
	return n;
  800e0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e0d:	c9                   	leave  
  800e0e:	c3                   	ret    

00800e0f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
  800e12:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e1b:	90                   	nop
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8d 50 01             	lea    0x1(%eax),%edx
  800e22:	89 55 08             	mov    %edx,0x8(%ebp)
  800e25:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e28:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e2b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e2e:	8a 12                	mov    (%edx),%dl
  800e30:	88 10                	mov    %dl,(%eax)
  800e32:	8a 00                	mov    (%eax),%al
  800e34:	84 c0                	test   %al,%al
  800e36:	75 e4                	jne    800e1c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e38:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e50:	eb 1f                	jmp    800e71 <strncpy+0x34>
		*dst++ = *src;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8d 50 01             	lea    0x1(%eax),%edx
  800e58:	89 55 08             	mov    %edx,0x8(%ebp)
  800e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5e:	8a 12                	mov    (%edx),%dl
  800e60:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	84 c0                	test   %al,%al
  800e69:	74 03                	je     800e6e <strncpy+0x31>
			src++;
  800e6b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e6e:	ff 45 fc             	incl   -0x4(%ebp)
  800e71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e74:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e77:	72 d9                	jb     800e52 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e7c:	c9                   	leave  
  800e7d:	c3                   	ret    

00800e7e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e7e:	55                   	push   %ebp
  800e7f:	89 e5                	mov    %esp,%ebp
  800e81:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e8e:	74 30                	je     800ec0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e90:	eb 16                	jmp    800ea8 <strlcpy+0x2a>
			*dst++ = *src++;
  800e92:	8b 45 08             	mov    0x8(%ebp),%eax
  800e95:	8d 50 01             	lea    0x1(%eax),%edx
  800e98:	89 55 08             	mov    %edx,0x8(%ebp)
  800e9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ea1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ea4:	8a 12                	mov    (%edx),%dl
  800ea6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ea8:	ff 4d 10             	decl   0x10(%ebp)
  800eab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eaf:	74 09                	je     800eba <strlcpy+0x3c>
  800eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb4:	8a 00                	mov    (%eax),%al
  800eb6:	84 c0                	test   %al,%al
  800eb8:	75 d8                	jne    800e92 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ec0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec6:	29 c2                	sub    %eax,%edx
  800ec8:	89 d0                	mov    %edx,%eax
}
  800eca:	c9                   	leave  
  800ecb:	c3                   	ret    

00800ecc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ecc:	55                   	push   %ebp
  800ecd:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ecf:	eb 06                	jmp    800ed7 <strcmp+0xb>
		p++, q++;
  800ed1:	ff 45 08             	incl   0x8(%ebp)
  800ed4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	84 c0                	test   %al,%al
  800ede:	74 0e                	je     800eee <strcmp+0x22>
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	8a 10                	mov    (%eax),%dl
  800ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	38 c2                	cmp    %al,%dl
  800eec:	74 e3                	je     800ed1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	0f b6 d0             	movzbl %al,%edx
  800ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	0f b6 c0             	movzbl %al,%eax
  800efe:	29 c2                	sub    %eax,%edx
  800f00:	89 d0                	mov    %edx,%eax
}
  800f02:	5d                   	pop    %ebp
  800f03:	c3                   	ret    

00800f04 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f04:	55                   	push   %ebp
  800f05:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f07:	eb 09                	jmp    800f12 <strncmp+0xe>
		n--, p++, q++;
  800f09:	ff 4d 10             	decl   0x10(%ebp)
  800f0c:	ff 45 08             	incl   0x8(%ebp)
  800f0f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f12:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f16:	74 17                	je     800f2f <strncmp+0x2b>
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	84 c0                	test   %al,%al
  800f1f:	74 0e                	je     800f2f <strncmp+0x2b>
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 10                	mov    (%eax),%dl
  800f26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f29:	8a 00                	mov    (%eax),%al
  800f2b:	38 c2                	cmp    %al,%dl
  800f2d:	74 da                	je     800f09 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f2f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f33:	75 07                	jne    800f3c <strncmp+0x38>
		return 0;
  800f35:	b8 00 00 00 00       	mov    $0x0,%eax
  800f3a:	eb 14                	jmp    800f50 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	0f b6 d0             	movzbl %al,%edx
  800f44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f47:	8a 00                	mov    (%eax),%al
  800f49:	0f b6 c0             	movzbl %al,%eax
  800f4c:	29 c2                	sub    %eax,%edx
  800f4e:	89 d0                	mov    %edx,%eax
}
  800f50:	5d                   	pop    %ebp
  800f51:	c3                   	ret    

00800f52 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 04             	sub    $0x4,%esp
  800f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f5e:	eb 12                	jmp    800f72 <strchr+0x20>
		if (*s == c)
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f68:	75 05                	jne    800f6f <strchr+0x1d>
			return (char *) s;
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	eb 11                	jmp    800f80 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f6f:	ff 45 08             	incl   0x8(%ebp)
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	84 c0                	test   %al,%al
  800f79:	75 e5                	jne    800f60 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f7b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f80:	c9                   	leave  
  800f81:	c3                   	ret    

00800f82 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f82:	55                   	push   %ebp
  800f83:	89 e5                	mov    %esp,%ebp
  800f85:	83 ec 04             	sub    $0x4,%esp
  800f88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f8e:	eb 0d                	jmp    800f9d <strfind+0x1b>
		if (*s == c)
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f98:	74 0e                	je     800fa8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f9a:	ff 45 08             	incl   0x8(%ebp)
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	84 c0                	test   %al,%al
  800fa4:	75 ea                	jne    800f90 <strfind+0xe>
  800fa6:	eb 01                	jmp    800fa9 <strfind+0x27>
		if (*s == c)
			break;
  800fa8:	90                   	nop
	return (char *) s;
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fac:	c9                   	leave  
  800fad:	c3                   	ret    

00800fae <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fae:	55                   	push   %ebp
  800faf:	89 e5                	mov    %esp,%ebp
  800fb1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fba:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fc0:	eb 0e                	jmp    800fd0 <memset+0x22>
		*p++ = c;
  800fc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fc5:	8d 50 01             	lea    0x1(%eax),%edx
  800fc8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fce:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fd0:	ff 4d f8             	decl   -0x8(%ebp)
  800fd3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fd7:	79 e9                	jns    800fc2 <memset+0x14>
		*p++ = c;

	return v;
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
  800fe1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fe4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ff0:	eb 16                	jmp    801008 <memcpy+0x2a>
		*d++ = *s++;
  800ff2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff5:	8d 50 01             	lea    0x1(%eax),%edx
  800ff8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ffb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ffe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801001:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801004:	8a 12                	mov    (%edx),%dl
  801006:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100e:	89 55 10             	mov    %edx,0x10(%ebp)
  801011:	85 c0                	test   %eax,%eax
  801013:	75 dd                	jne    800ff2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801018:	c9                   	leave  
  801019:	c3                   	ret    

0080101a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80101a:	55                   	push   %ebp
  80101b:	89 e5                	mov    %esp,%ebp
  80101d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801020:	8b 45 0c             	mov    0xc(%ebp),%eax
  801023:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80102c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801032:	73 50                	jae    801084 <memmove+0x6a>
  801034:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801037:	8b 45 10             	mov    0x10(%ebp),%eax
  80103a:	01 d0                	add    %edx,%eax
  80103c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80103f:	76 43                	jbe    801084 <memmove+0x6a>
		s += n;
  801041:	8b 45 10             	mov    0x10(%ebp),%eax
  801044:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801047:	8b 45 10             	mov    0x10(%ebp),%eax
  80104a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80104d:	eb 10                	jmp    80105f <memmove+0x45>
			*--d = *--s;
  80104f:	ff 4d f8             	decl   -0x8(%ebp)
  801052:	ff 4d fc             	decl   -0x4(%ebp)
  801055:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801058:	8a 10                	mov    (%eax),%dl
  80105a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80105f:	8b 45 10             	mov    0x10(%ebp),%eax
  801062:	8d 50 ff             	lea    -0x1(%eax),%edx
  801065:	89 55 10             	mov    %edx,0x10(%ebp)
  801068:	85 c0                	test   %eax,%eax
  80106a:	75 e3                	jne    80104f <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80106c:	eb 23                	jmp    801091 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80106e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801071:	8d 50 01             	lea    0x1(%eax),%edx
  801074:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801077:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801080:	8a 12                	mov    (%edx),%dl
  801082:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801084:	8b 45 10             	mov    0x10(%ebp),%eax
  801087:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108a:	89 55 10             	mov    %edx,0x10(%ebp)
  80108d:	85 c0                	test   %eax,%eax
  80108f:	75 dd                	jne    80106e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801094:	c9                   	leave  
  801095:	c3                   	ret    

00801096 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801096:	55                   	push   %ebp
  801097:	89 e5                	mov    %esp,%ebp
  801099:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010a8:	eb 2a                	jmp    8010d4 <memcmp+0x3e>
		if (*s1 != *s2)
  8010aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ad:	8a 10                	mov    (%eax),%dl
  8010af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b2:	8a 00                	mov    (%eax),%al
  8010b4:	38 c2                	cmp    %al,%dl
  8010b6:	74 16                	je     8010ce <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010bb:	8a 00                	mov    (%eax),%al
  8010bd:	0f b6 d0             	movzbl %al,%edx
  8010c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f b6 c0             	movzbl %al,%eax
  8010c8:	29 c2                	sub    %eax,%edx
  8010ca:	89 d0                	mov    %edx,%eax
  8010cc:	eb 18                	jmp    8010e6 <memcmp+0x50>
		s1++, s2++;
  8010ce:	ff 45 fc             	incl   -0x4(%ebp)
  8010d1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010da:	89 55 10             	mov    %edx,0x10(%ebp)
  8010dd:	85 c0                	test   %eax,%eax
  8010df:	75 c9                	jne    8010aa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010e6:	c9                   	leave  
  8010e7:	c3                   	ret    

008010e8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010e8:	55                   	push   %ebp
  8010e9:	89 e5                	mov    %esp,%ebp
  8010eb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f4:	01 d0                	add    %edx,%eax
  8010f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010f9:	eb 15                	jmp    801110 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	0f b6 d0             	movzbl %al,%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	0f b6 c0             	movzbl %al,%eax
  801109:	39 c2                	cmp    %eax,%edx
  80110b:	74 0d                	je     80111a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80110d:	ff 45 08             	incl   0x8(%ebp)
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801116:	72 e3                	jb     8010fb <memfind+0x13>
  801118:	eb 01                	jmp    80111b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80111a:	90                   	nop
	return (void *) s;
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111e:	c9                   	leave  
  80111f:	c3                   	ret    

00801120 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801126:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80112d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801134:	eb 03                	jmp    801139 <strtol+0x19>
		s++;
  801136:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	3c 20                	cmp    $0x20,%al
  801140:	74 f4                	je     801136 <strtol+0x16>
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	8a 00                	mov    (%eax),%al
  801147:	3c 09                	cmp    $0x9,%al
  801149:	74 eb                	je     801136 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	3c 2b                	cmp    $0x2b,%al
  801152:	75 05                	jne    801159 <strtol+0x39>
		s++;
  801154:	ff 45 08             	incl   0x8(%ebp)
  801157:	eb 13                	jmp    80116c <strtol+0x4c>
	else if (*s == '-')
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	3c 2d                	cmp    $0x2d,%al
  801160:	75 0a                	jne    80116c <strtol+0x4c>
		s++, neg = 1;
  801162:	ff 45 08             	incl   0x8(%ebp)
  801165:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80116c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801170:	74 06                	je     801178 <strtol+0x58>
  801172:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801176:	75 20                	jne    801198 <strtol+0x78>
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	3c 30                	cmp    $0x30,%al
  80117f:	75 17                	jne    801198 <strtol+0x78>
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	40                   	inc    %eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	3c 78                	cmp    $0x78,%al
  801189:	75 0d                	jne    801198 <strtol+0x78>
		s += 2, base = 16;
  80118b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80118f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801196:	eb 28                	jmp    8011c0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801198:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119c:	75 15                	jne    8011b3 <strtol+0x93>
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	3c 30                	cmp    $0x30,%al
  8011a5:	75 0c                	jne    8011b3 <strtol+0x93>
		s++, base = 8;
  8011a7:	ff 45 08             	incl   0x8(%ebp)
  8011aa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011b1:	eb 0d                	jmp    8011c0 <strtol+0xa0>
	else if (base == 0)
  8011b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b7:	75 07                	jne    8011c0 <strtol+0xa0>
		base = 10;
  8011b9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 2f                	cmp    $0x2f,%al
  8011c7:	7e 19                	jle    8011e2 <strtol+0xc2>
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3c 39                	cmp    $0x39,%al
  8011d0:	7f 10                	jg     8011e2 <strtol+0xc2>
			dig = *s - '0';
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	0f be c0             	movsbl %al,%eax
  8011da:	83 e8 30             	sub    $0x30,%eax
  8011dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011e0:	eb 42                	jmp    801224 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3c 60                	cmp    $0x60,%al
  8011e9:	7e 19                	jle    801204 <strtol+0xe4>
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3c 7a                	cmp    $0x7a,%al
  8011f2:	7f 10                	jg     801204 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	8a 00                	mov    (%eax),%al
  8011f9:	0f be c0             	movsbl %al,%eax
  8011fc:	83 e8 57             	sub    $0x57,%eax
  8011ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801202:	eb 20                	jmp    801224 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	8a 00                	mov    (%eax),%al
  801209:	3c 40                	cmp    $0x40,%al
  80120b:	7e 39                	jle    801246 <strtol+0x126>
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	3c 5a                	cmp    $0x5a,%al
  801214:	7f 30                	jg     801246 <strtol+0x126>
			dig = *s - 'A' + 10;
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	0f be c0             	movsbl %al,%eax
  80121e:	83 e8 37             	sub    $0x37,%eax
  801221:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801224:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801227:	3b 45 10             	cmp    0x10(%ebp),%eax
  80122a:	7d 19                	jge    801245 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80122c:	ff 45 08             	incl   0x8(%ebp)
  80122f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801232:	0f af 45 10          	imul   0x10(%ebp),%eax
  801236:	89 c2                	mov    %eax,%edx
  801238:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801240:	e9 7b ff ff ff       	jmp    8011c0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801245:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801246:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80124a:	74 08                	je     801254 <strtol+0x134>
		*endptr = (char *) s;
  80124c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124f:	8b 55 08             	mov    0x8(%ebp),%edx
  801252:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801254:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801258:	74 07                	je     801261 <strtol+0x141>
  80125a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125d:	f7 d8                	neg    %eax
  80125f:	eb 03                	jmp    801264 <strtol+0x144>
  801261:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801264:	c9                   	leave  
  801265:	c3                   	ret    

00801266 <ltostr>:

void
ltostr(long value, char *str)
{
  801266:	55                   	push   %ebp
  801267:	89 e5                	mov    %esp,%ebp
  801269:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80126c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801273:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80127a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80127e:	79 13                	jns    801293 <ltostr+0x2d>
	{
		neg = 1;
  801280:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801287:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80128d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801290:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80129b:	99                   	cltd   
  80129c:	f7 f9                	idiv   %ecx
  80129e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a4:	8d 50 01             	lea    0x1(%eax),%edx
  8012a7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012aa:	89 c2                	mov    %eax,%edx
  8012ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012af:	01 d0                	add    %edx,%eax
  8012b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b4:	83 c2 30             	add    $0x30,%edx
  8012b7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012bc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012c1:	f7 e9                	imul   %ecx
  8012c3:	c1 fa 02             	sar    $0x2,%edx
  8012c6:	89 c8                	mov    %ecx,%eax
  8012c8:	c1 f8 1f             	sar    $0x1f,%eax
  8012cb:	29 c2                	sub    %eax,%edx
  8012cd:	89 d0                	mov    %edx,%eax
  8012cf:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012d5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012da:	f7 e9                	imul   %ecx
  8012dc:	c1 fa 02             	sar    $0x2,%edx
  8012df:	89 c8                	mov    %ecx,%eax
  8012e1:	c1 f8 1f             	sar    $0x1f,%eax
  8012e4:	29 c2                	sub    %eax,%edx
  8012e6:	89 d0                	mov    %edx,%eax
  8012e8:	c1 e0 02             	shl    $0x2,%eax
  8012eb:	01 d0                	add    %edx,%eax
  8012ed:	01 c0                	add    %eax,%eax
  8012ef:	29 c1                	sub    %eax,%ecx
  8012f1:	89 ca                	mov    %ecx,%edx
  8012f3:	85 d2                	test   %edx,%edx
  8012f5:	75 9c                	jne    801293 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801301:	48                   	dec    %eax
  801302:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801305:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801309:	74 3d                	je     801348 <ltostr+0xe2>
		start = 1 ;
  80130b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801312:	eb 34                	jmp    801348 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801314:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801317:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	8a 00                	mov    (%eax),%al
  80131e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801321:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801324:	8b 45 0c             	mov    0xc(%ebp),%eax
  801327:	01 c2                	add    %eax,%edx
  801329:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80132c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132f:	01 c8                	add    %ecx,%eax
  801331:	8a 00                	mov    (%eax),%al
  801333:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801335:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	01 c2                	add    %eax,%edx
  80133d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801340:	88 02                	mov    %al,(%edx)
		start++ ;
  801342:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801345:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801348:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80134b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80134e:	7c c4                	jl     801314 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801350:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801353:	8b 45 0c             	mov    0xc(%ebp),%eax
  801356:	01 d0                	add    %edx,%eax
  801358:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80135b:	90                   	nop
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801364:	ff 75 08             	pushl  0x8(%ebp)
  801367:	e8 54 fa ff ff       	call   800dc0 <strlen>
  80136c:	83 c4 04             	add    $0x4,%esp
  80136f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801372:	ff 75 0c             	pushl  0xc(%ebp)
  801375:	e8 46 fa ff ff       	call   800dc0 <strlen>
  80137a:	83 c4 04             	add    $0x4,%esp
  80137d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801380:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801387:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80138e:	eb 17                	jmp    8013a7 <strcconcat+0x49>
		final[s] = str1[s] ;
  801390:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801393:	8b 45 10             	mov    0x10(%ebp),%eax
  801396:	01 c2                	add    %eax,%edx
  801398:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	01 c8                	add    %ecx,%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013a4:	ff 45 fc             	incl   -0x4(%ebp)
  8013a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013ad:	7c e1                	jl     801390 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013bd:	eb 1f                	jmp    8013de <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c2:	8d 50 01             	lea    0x1(%eax),%edx
  8013c5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013c8:	89 c2                	mov    %eax,%edx
  8013ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cd:	01 c2                	add    %eax,%edx
  8013cf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	01 c8                	add    %ecx,%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013db:	ff 45 f8             	incl   -0x8(%ebp)
  8013de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013e4:	7c d9                	jl     8013bf <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ec:	01 d0                	add    %edx,%eax
  8013ee:	c6 00 00             	movb   $0x0,(%eax)
}
  8013f1:	90                   	nop
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801400:	8b 45 14             	mov    0x14(%ebp),%eax
  801403:	8b 00                	mov    (%eax),%eax
  801405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80140c:	8b 45 10             	mov    0x10(%ebp),%eax
  80140f:	01 d0                	add    %edx,%eax
  801411:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801417:	eb 0c                	jmp    801425 <strsplit+0x31>
			*string++ = 0;
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	8d 50 01             	lea    0x1(%eax),%edx
  80141f:	89 55 08             	mov    %edx,0x8(%ebp)
  801422:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801425:	8b 45 08             	mov    0x8(%ebp),%eax
  801428:	8a 00                	mov    (%eax),%al
  80142a:	84 c0                	test   %al,%al
  80142c:	74 18                	je     801446 <strsplit+0x52>
  80142e:	8b 45 08             	mov    0x8(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	0f be c0             	movsbl %al,%eax
  801436:	50                   	push   %eax
  801437:	ff 75 0c             	pushl  0xc(%ebp)
  80143a:	e8 13 fb ff ff       	call   800f52 <strchr>
  80143f:	83 c4 08             	add    $0x8,%esp
  801442:	85 c0                	test   %eax,%eax
  801444:	75 d3                	jne    801419 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	84 c0                	test   %al,%al
  80144d:	74 5a                	je     8014a9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80144f:	8b 45 14             	mov    0x14(%ebp),%eax
  801452:	8b 00                	mov    (%eax),%eax
  801454:	83 f8 0f             	cmp    $0xf,%eax
  801457:	75 07                	jne    801460 <strsplit+0x6c>
		{
			return 0;
  801459:	b8 00 00 00 00       	mov    $0x0,%eax
  80145e:	eb 66                	jmp    8014c6 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801460:	8b 45 14             	mov    0x14(%ebp),%eax
  801463:	8b 00                	mov    (%eax),%eax
  801465:	8d 48 01             	lea    0x1(%eax),%ecx
  801468:	8b 55 14             	mov    0x14(%ebp),%edx
  80146b:	89 0a                	mov    %ecx,(%edx)
  80146d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801474:	8b 45 10             	mov    0x10(%ebp),%eax
  801477:	01 c2                	add    %eax,%edx
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80147e:	eb 03                	jmp    801483 <strsplit+0x8f>
			string++;
  801480:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8a 00                	mov    (%eax),%al
  801488:	84 c0                	test   %al,%al
  80148a:	74 8b                	je     801417 <strsplit+0x23>
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	8a 00                	mov    (%eax),%al
  801491:	0f be c0             	movsbl %al,%eax
  801494:	50                   	push   %eax
  801495:	ff 75 0c             	pushl  0xc(%ebp)
  801498:	e8 b5 fa ff ff       	call   800f52 <strchr>
  80149d:	83 c4 08             	add    $0x8,%esp
  8014a0:	85 c0                	test   %eax,%eax
  8014a2:	74 dc                	je     801480 <strsplit+0x8c>
			string++;
	}
  8014a4:	e9 6e ff ff ff       	jmp    801417 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014a9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ad:	8b 00                	mov    (%eax),%eax
  8014af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b9:	01 d0                	add    %edx,%eax
  8014bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014c1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	57                   	push   %edi
  8014cc:	56                   	push   %esi
  8014cd:	53                   	push   %ebx
  8014ce:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014dd:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014e0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014e3:	cd 30                	int    $0x30
  8014e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014eb:	83 c4 10             	add    $0x10,%esp
  8014ee:	5b                   	pop    %ebx
  8014ef:	5e                   	pop    %esi
  8014f0:	5f                   	pop    %edi
  8014f1:	5d                   	pop    %ebp
  8014f2:	c3                   	ret    

008014f3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
  8014f6:	83 ec 04             	sub    $0x4,%esp
  8014f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014ff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	52                   	push   %edx
  80150b:	ff 75 0c             	pushl  0xc(%ebp)
  80150e:	50                   	push   %eax
  80150f:	6a 00                	push   $0x0
  801511:	e8 b2 ff ff ff       	call   8014c8 <syscall>
  801516:	83 c4 18             	add    $0x18,%esp
}
  801519:	90                   	nop
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_cgetc>:

int
sys_cgetc(void)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 01                	push   $0x1
  80152b:	e8 98 ff ff ff       	call   8014c8 <syscall>
  801530:	83 c4 18             	add    $0x18,%esp
}
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	50                   	push   %eax
  801544:	6a 05                	push   $0x5
  801546:	e8 7d ff ff ff       	call   8014c8 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
}
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 02                	push   $0x2
  80155f:	e8 64 ff ff ff       	call   8014c8 <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 03                	push   $0x3
  801578:	e8 4b ff ff ff       	call   8014c8 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 04                	push   $0x4
  801591:	e8 32 ff ff ff       	call   8014c8 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
}
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <sys_env_exit>:


void sys_env_exit(void)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 06                	push   $0x6
  8015aa:	e8 19 ff ff ff       	call   8014c8 <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	90                   	nop
  8015b3:	c9                   	leave  
  8015b4:	c3                   	ret    

008015b5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	52                   	push   %edx
  8015c5:	50                   	push   %eax
  8015c6:	6a 07                	push   $0x7
  8015c8:	e8 fb fe ff ff       	call   8014c8 <syscall>
  8015cd:	83 c4 18             	add    $0x18,%esp
}
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
  8015d5:	56                   	push   %esi
  8015d6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015d7:	8b 75 18             	mov    0x18(%ebp),%esi
  8015da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	56                   	push   %esi
  8015e7:	53                   	push   %ebx
  8015e8:	51                   	push   %ecx
  8015e9:	52                   	push   %edx
  8015ea:	50                   	push   %eax
  8015eb:	6a 08                	push   $0x8
  8015ed:	e8 d6 fe ff ff       	call   8014c8 <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
}
  8015f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015f8:	5b                   	pop    %ebx
  8015f9:	5e                   	pop    %esi
  8015fa:	5d                   	pop    %ebp
  8015fb:	c3                   	ret    

008015fc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	52                   	push   %edx
  80160c:	50                   	push   %eax
  80160d:	6a 09                	push   $0x9
  80160f:	e8 b4 fe ff ff       	call   8014c8 <syscall>
  801614:	83 c4 18             	add    $0x18,%esp
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	ff 75 0c             	pushl  0xc(%ebp)
  801625:	ff 75 08             	pushl  0x8(%ebp)
  801628:	6a 0a                	push   $0xa
  80162a:	e8 99 fe ff ff       	call   8014c8 <syscall>
  80162f:	83 c4 18             	add    $0x18,%esp
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 0b                	push   $0xb
  801643:	e8 80 fe ff ff       	call   8014c8 <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 0c                	push   $0xc
  80165c:	e8 67 fe ff ff       	call   8014c8 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 0d                	push   $0xd
  801675:	e8 4e fe ff ff       	call   8014c8 <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
}
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	ff 75 0c             	pushl  0xc(%ebp)
  80168b:	ff 75 08             	pushl  0x8(%ebp)
  80168e:	6a 11                	push   $0x11
  801690:	e8 33 fe ff ff       	call   8014c8 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
	return;
  801698:	90                   	nop
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	ff 75 0c             	pushl  0xc(%ebp)
  8016a7:	ff 75 08             	pushl  0x8(%ebp)
  8016aa:	6a 12                	push   $0x12
  8016ac:	e8 17 fe ff ff       	call   8014c8 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b4:	90                   	nop
}
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 0e                	push   $0xe
  8016c6:	e8 fd fd ff ff       	call   8014c8 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	ff 75 08             	pushl  0x8(%ebp)
  8016de:	6a 0f                	push   $0xf
  8016e0:	e8 e3 fd ff ff       	call   8014c8 <syscall>
  8016e5:	83 c4 18             	add    $0x18,%esp
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 10                	push   $0x10
  8016f9:	e8 ca fd ff ff       	call   8014c8 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	90                   	nop
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 14                	push   $0x14
  801713:	e8 b0 fd ff ff       	call   8014c8 <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
}
  80171b:	90                   	nop
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 15                	push   $0x15
  80172d:	e8 96 fd ff ff       	call   8014c8 <syscall>
  801732:	83 c4 18             	add    $0x18,%esp
}
  801735:	90                   	nop
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <sys_cputc>:


void
sys_cputc(const char c)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	83 ec 04             	sub    $0x4,%esp
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801744:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	50                   	push   %eax
  801751:	6a 16                	push   $0x16
  801753:	e8 70 fd ff ff       	call   8014c8 <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	90                   	nop
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 17                	push   $0x17
  80176d:	e8 56 fd ff ff       	call   8014c8 <syscall>
  801772:	83 c4 18             	add    $0x18,%esp
}
  801775:	90                   	nop
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	ff 75 0c             	pushl  0xc(%ebp)
  801787:	50                   	push   %eax
  801788:	6a 18                	push   $0x18
  80178a:	e8 39 fd ff ff       	call   8014c8 <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801797:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	52                   	push   %edx
  8017a4:	50                   	push   %eax
  8017a5:	6a 1b                	push   $0x1b
  8017a7:	e8 1c fd ff ff       	call   8014c8 <syscall>
  8017ac:	83 c4 18             	add    $0x18,%esp
}
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	52                   	push   %edx
  8017c1:	50                   	push   %eax
  8017c2:	6a 19                	push   $0x19
  8017c4:	e8 ff fc ff ff       	call   8014c8 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	90                   	nop
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	52                   	push   %edx
  8017df:	50                   	push   %eax
  8017e0:	6a 1a                	push   $0x1a
  8017e2:	e8 e1 fc ff ff       	call   8014c8 <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	90                   	nop
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
  8017f0:	83 ec 04             	sub    $0x4,%esp
  8017f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017f9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017fc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	6a 00                	push   $0x0
  801805:	51                   	push   %ecx
  801806:	52                   	push   %edx
  801807:	ff 75 0c             	pushl  0xc(%ebp)
  80180a:	50                   	push   %eax
  80180b:	6a 1c                	push   $0x1c
  80180d:	e8 b6 fc ff ff       	call   8014c8 <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
}
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	52                   	push   %edx
  801827:	50                   	push   %eax
  801828:	6a 1d                	push   $0x1d
  80182a:	e8 99 fc ff ff       	call   8014c8 <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801837:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80183a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	51                   	push   %ecx
  801845:	52                   	push   %edx
  801846:	50                   	push   %eax
  801847:	6a 1e                	push   $0x1e
  801849:	e8 7a fc ff ff       	call   8014c8 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801856:	8b 55 0c             	mov    0xc(%ebp),%edx
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	52                   	push   %edx
  801863:	50                   	push   %eax
  801864:	6a 1f                	push   $0x1f
  801866:	e8 5d fc ff ff       	call   8014c8 <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
}
  80186e:	c9                   	leave  
  80186f:	c3                   	ret    

00801870 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 20                	push   $0x20
  80187f:	e8 44 fc ff ff       	call   8014c8 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	ff 75 10             	pushl  0x10(%ebp)
  801896:	ff 75 0c             	pushl  0xc(%ebp)
  801899:	50                   	push   %eax
  80189a:	6a 21                	push   $0x21
  80189c:	e8 27 fc ff ff       	call   8014c8 <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	50                   	push   %eax
  8018b5:	6a 22                	push   $0x22
  8018b7:	e8 0c fc ff ff       	call   8014c8 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	90                   	nop
  8018c0:	c9                   	leave  
  8018c1:	c3                   	ret    

008018c2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	50                   	push   %eax
  8018d1:	6a 23                	push   $0x23
  8018d3:	e8 f0 fb ff ff       	call   8014c8 <syscall>
  8018d8:	83 c4 18             	add    $0x18,%esp
}
  8018db:	90                   	nop
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
  8018e1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018e4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018e7:	8d 50 04             	lea    0x4(%eax),%edx
  8018ea:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	52                   	push   %edx
  8018f4:	50                   	push   %eax
  8018f5:	6a 24                	push   $0x24
  8018f7:	e8 cc fb ff ff       	call   8014c8 <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
	return result;
  8018ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801902:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801905:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801908:	89 01                	mov    %eax,(%ecx)
  80190a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	c9                   	leave  
  801911:	c2 04 00             	ret    $0x4

00801914 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	ff 75 10             	pushl  0x10(%ebp)
  80191e:	ff 75 0c             	pushl  0xc(%ebp)
  801921:	ff 75 08             	pushl  0x8(%ebp)
  801924:	6a 13                	push   $0x13
  801926:	e8 9d fb ff ff       	call   8014c8 <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
	return ;
  80192e:	90                   	nop
}
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <sys_rcr2>:
uint32 sys_rcr2()
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 25                	push   $0x25
  801940:	e8 83 fb ff ff       	call   8014c8 <syscall>
  801945:	83 c4 18             	add    $0x18,%esp
}
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
  80194d:	83 ec 04             	sub    $0x4,%esp
  801950:	8b 45 08             	mov    0x8(%ebp),%eax
  801953:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801956:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	50                   	push   %eax
  801963:	6a 26                	push   $0x26
  801965:	e8 5e fb ff ff       	call   8014c8 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
	return ;
  80196d:	90                   	nop
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <rsttst>:
void rsttst()
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 28                	push   $0x28
  80197f:	e8 44 fb ff ff       	call   8014c8 <syscall>
  801984:	83 c4 18             	add    $0x18,%esp
	return ;
  801987:	90                   	nop
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    

0080198a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
  80198d:	83 ec 04             	sub    $0x4,%esp
  801990:	8b 45 14             	mov    0x14(%ebp),%eax
  801993:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801996:	8b 55 18             	mov    0x18(%ebp),%edx
  801999:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80199d:	52                   	push   %edx
  80199e:	50                   	push   %eax
  80199f:	ff 75 10             	pushl  0x10(%ebp)
  8019a2:	ff 75 0c             	pushl  0xc(%ebp)
  8019a5:	ff 75 08             	pushl  0x8(%ebp)
  8019a8:	6a 27                	push   $0x27
  8019aa:	e8 19 fb ff ff       	call   8014c8 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b2:	90                   	nop
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <chktst>:
void chktst(uint32 n)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	ff 75 08             	pushl  0x8(%ebp)
  8019c3:	6a 29                	push   $0x29
  8019c5:	e8 fe fa ff ff       	call   8014c8 <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8019cd:	90                   	nop
}
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <inctst>:

void inctst()
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 2a                	push   $0x2a
  8019df:	e8 e4 fa ff ff       	call   8014c8 <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e7:	90                   	nop
}
  8019e8:	c9                   	leave  
  8019e9:	c3                   	ret    

008019ea <gettst>:
uint32 gettst()
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 2b                	push   $0x2b
  8019f9:	e8 ca fa ff ff       	call   8014c8 <syscall>
  8019fe:	83 c4 18             	add    $0x18,%esp
}
  801a01:	c9                   	leave  
  801a02:	c3                   	ret    

00801a03 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a03:	55                   	push   %ebp
  801a04:	89 e5                	mov    %esp,%ebp
  801a06:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 2c                	push   $0x2c
  801a15:	e8 ae fa ff ff       	call   8014c8 <syscall>
  801a1a:	83 c4 18             	add    $0x18,%esp
  801a1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a20:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a24:	75 07                	jne    801a2d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a26:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2b:	eb 05                	jmp    801a32 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a2d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
  801a37:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 2c                	push   $0x2c
  801a46:	e8 7d fa ff ff       	call   8014c8 <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
  801a4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a51:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a55:	75 07                	jne    801a5e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a57:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5c:	eb 05                	jmp    801a63 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a63:	c9                   	leave  
  801a64:	c3                   	ret    

00801a65 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a65:	55                   	push   %ebp
  801a66:	89 e5                	mov    %esp,%ebp
  801a68:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 2c                	push   $0x2c
  801a77:	e8 4c fa ff ff       	call   8014c8 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
  801a7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a82:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a86:	75 07                	jne    801a8f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a88:	b8 01 00 00 00       	mov    $0x1,%eax
  801a8d:	eb 05                	jmp    801a94 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a94:	c9                   	leave  
  801a95:	c3                   	ret    

00801a96 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
  801a99:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 2c                	push   $0x2c
  801aa8:	e8 1b fa ff ff       	call   8014c8 <syscall>
  801aad:	83 c4 18             	add    $0x18,%esp
  801ab0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ab3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ab7:	75 07                	jne    801ac0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ab9:	b8 01 00 00 00       	mov    $0x1,%eax
  801abe:	eb 05                	jmp    801ac5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ac0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	ff 75 08             	pushl  0x8(%ebp)
  801ad5:	6a 2d                	push   $0x2d
  801ad7:	e8 ec f9 ff ff       	call   8014c8 <syscall>
  801adc:	83 c4 18             	add    $0x18,%esp
	return ;
  801adf:	90                   	nop
}
  801ae0:	c9                   	leave  
  801ae1:	c3                   	ret    
  801ae2:	66 90                	xchg   %ax,%ax

00801ae4 <__udivdi3>:
  801ae4:	55                   	push   %ebp
  801ae5:	57                   	push   %edi
  801ae6:	56                   	push   %esi
  801ae7:	53                   	push   %ebx
  801ae8:	83 ec 1c             	sub    $0x1c,%esp
  801aeb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801aef:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801af3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801af7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801afb:	89 ca                	mov    %ecx,%edx
  801afd:	89 f8                	mov    %edi,%eax
  801aff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b03:	85 f6                	test   %esi,%esi
  801b05:	75 2d                	jne    801b34 <__udivdi3+0x50>
  801b07:	39 cf                	cmp    %ecx,%edi
  801b09:	77 65                	ja     801b70 <__udivdi3+0x8c>
  801b0b:	89 fd                	mov    %edi,%ebp
  801b0d:	85 ff                	test   %edi,%edi
  801b0f:	75 0b                	jne    801b1c <__udivdi3+0x38>
  801b11:	b8 01 00 00 00       	mov    $0x1,%eax
  801b16:	31 d2                	xor    %edx,%edx
  801b18:	f7 f7                	div    %edi
  801b1a:	89 c5                	mov    %eax,%ebp
  801b1c:	31 d2                	xor    %edx,%edx
  801b1e:	89 c8                	mov    %ecx,%eax
  801b20:	f7 f5                	div    %ebp
  801b22:	89 c1                	mov    %eax,%ecx
  801b24:	89 d8                	mov    %ebx,%eax
  801b26:	f7 f5                	div    %ebp
  801b28:	89 cf                	mov    %ecx,%edi
  801b2a:	89 fa                	mov    %edi,%edx
  801b2c:	83 c4 1c             	add    $0x1c,%esp
  801b2f:	5b                   	pop    %ebx
  801b30:	5e                   	pop    %esi
  801b31:	5f                   	pop    %edi
  801b32:	5d                   	pop    %ebp
  801b33:	c3                   	ret    
  801b34:	39 ce                	cmp    %ecx,%esi
  801b36:	77 28                	ja     801b60 <__udivdi3+0x7c>
  801b38:	0f bd fe             	bsr    %esi,%edi
  801b3b:	83 f7 1f             	xor    $0x1f,%edi
  801b3e:	75 40                	jne    801b80 <__udivdi3+0x9c>
  801b40:	39 ce                	cmp    %ecx,%esi
  801b42:	72 0a                	jb     801b4e <__udivdi3+0x6a>
  801b44:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b48:	0f 87 9e 00 00 00    	ja     801bec <__udivdi3+0x108>
  801b4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b53:	89 fa                	mov    %edi,%edx
  801b55:	83 c4 1c             	add    $0x1c,%esp
  801b58:	5b                   	pop    %ebx
  801b59:	5e                   	pop    %esi
  801b5a:	5f                   	pop    %edi
  801b5b:	5d                   	pop    %ebp
  801b5c:	c3                   	ret    
  801b5d:	8d 76 00             	lea    0x0(%esi),%esi
  801b60:	31 ff                	xor    %edi,%edi
  801b62:	31 c0                	xor    %eax,%eax
  801b64:	89 fa                	mov    %edi,%edx
  801b66:	83 c4 1c             	add    $0x1c,%esp
  801b69:	5b                   	pop    %ebx
  801b6a:	5e                   	pop    %esi
  801b6b:	5f                   	pop    %edi
  801b6c:	5d                   	pop    %ebp
  801b6d:	c3                   	ret    
  801b6e:	66 90                	xchg   %ax,%ax
  801b70:	89 d8                	mov    %ebx,%eax
  801b72:	f7 f7                	div    %edi
  801b74:	31 ff                	xor    %edi,%edi
  801b76:	89 fa                	mov    %edi,%edx
  801b78:	83 c4 1c             	add    $0x1c,%esp
  801b7b:	5b                   	pop    %ebx
  801b7c:	5e                   	pop    %esi
  801b7d:	5f                   	pop    %edi
  801b7e:	5d                   	pop    %ebp
  801b7f:	c3                   	ret    
  801b80:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b85:	89 eb                	mov    %ebp,%ebx
  801b87:	29 fb                	sub    %edi,%ebx
  801b89:	89 f9                	mov    %edi,%ecx
  801b8b:	d3 e6                	shl    %cl,%esi
  801b8d:	89 c5                	mov    %eax,%ebp
  801b8f:	88 d9                	mov    %bl,%cl
  801b91:	d3 ed                	shr    %cl,%ebp
  801b93:	89 e9                	mov    %ebp,%ecx
  801b95:	09 f1                	or     %esi,%ecx
  801b97:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b9b:	89 f9                	mov    %edi,%ecx
  801b9d:	d3 e0                	shl    %cl,%eax
  801b9f:	89 c5                	mov    %eax,%ebp
  801ba1:	89 d6                	mov    %edx,%esi
  801ba3:	88 d9                	mov    %bl,%cl
  801ba5:	d3 ee                	shr    %cl,%esi
  801ba7:	89 f9                	mov    %edi,%ecx
  801ba9:	d3 e2                	shl    %cl,%edx
  801bab:	8b 44 24 08          	mov    0x8(%esp),%eax
  801baf:	88 d9                	mov    %bl,%cl
  801bb1:	d3 e8                	shr    %cl,%eax
  801bb3:	09 c2                	or     %eax,%edx
  801bb5:	89 d0                	mov    %edx,%eax
  801bb7:	89 f2                	mov    %esi,%edx
  801bb9:	f7 74 24 0c          	divl   0xc(%esp)
  801bbd:	89 d6                	mov    %edx,%esi
  801bbf:	89 c3                	mov    %eax,%ebx
  801bc1:	f7 e5                	mul    %ebp
  801bc3:	39 d6                	cmp    %edx,%esi
  801bc5:	72 19                	jb     801be0 <__udivdi3+0xfc>
  801bc7:	74 0b                	je     801bd4 <__udivdi3+0xf0>
  801bc9:	89 d8                	mov    %ebx,%eax
  801bcb:	31 ff                	xor    %edi,%edi
  801bcd:	e9 58 ff ff ff       	jmp    801b2a <__udivdi3+0x46>
  801bd2:	66 90                	xchg   %ax,%ax
  801bd4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bd8:	89 f9                	mov    %edi,%ecx
  801bda:	d3 e2                	shl    %cl,%edx
  801bdc:	39 c2                	cmp    %eax,%edx
  801bde:	73 e9                	jae    801bc9 <__udivdi3+0xe5>
  801be0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801be3:	31 ff                	xor    %edi,%edi
  801be5:	e9 40 ff ff ff       	jmp    801b2a <__udivdi3+0x46>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	31 c0                	xor    %eax,%eax
  801bee:	e9 37 ff ff ff       	jmp    801b2a <__udivdi3+0x46>
  801bf3:	90                   	nop

00801bf4 <__umoddi3>:
  801bf4:	55                   	push   %ebp
  801bf5:	57                   	push   %edi
  801bf6:	56                   	push   %esi
  801bf7:	53                   	push   %ebx
  801bf8:	83 ec 1c             	sub    $0x1c,%esp
  801bfb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bff:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c03:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c07:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c0b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c0f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c13:	89 f3                	mov    %esi,%ebx
  801c15:	89 fa                	mov    %edi,%edx
  801c17:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c1b:	89 34 24             	mov    %esi,(%esp)
  801c1e:	85 c0                	test   %eax,%eax
  801c20:	75 1a                	jne    801c3c <__umoddi3+0x48>
  801c22:	39 f7                	cmp    %esi,%edi
  801c24:	0f 86 a2 00 00 00    	jbe    801ccc <__umoddi3+0xd8>
  801c2a:	89 c8                	mov    %ecx,%eax
  801c2c:	89 f2                	mov    %esi,%edx
  801c2e:	f7 f7                	div    %edi
  801c30:	89 d0                	mov    %edx,%eax
  801c32:	31 d2                	xor    %edx,%edx
  801c34:	83 c4 1c             	add    $0x1c,%esp
  801c37:	5b                   	pop    %ebx
  801c38:	5e                   	pop    %esi
  801c39:	5f                   	pop    %edi
  801c3a:	5d                   	pop    %ebp
  801c3b:	c3                   	ret    
  801c3c:	39 f0                	cmp    %esi,%eax
  801c3e:	0f 87 ac 00 00 00    	ja     801cf0 <__umoddi3+0xfc>
  801c44:	0f bd e8             	bsr    %eax,%ebp
  801c47:	83 f5 1f             	xor    $0x1f,%ebp
  801c4a:	0f 84 ac 00 00 00    	je     801cfc <__umoddi3+0x108>
  801c50:	bf 20 00 00 00       	mov    $0x20,%edi
  801c55:	29 ef                	sub    %ebp,%edi
  801c57:	89 fe                	mov    %edi,%esi
  801c59:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c5d:	89 e9                	mov    %ebp,%ecx
  801c5f:	d3 e0                	shl    %cl,%eax
  801c61:	89 d7                	mov    %edx,%edi
  801c63:	89 f1                	mov    %esi,%ecx
  801c65:	d3 ef                	shr    %cl,%edi
  801c67:	09 c7                	or     %eax,%edi
  801c69:	89 e9                	mov    %ebp,%ecx
  801c6b:	d3 e2                	shl    %cl,%edx
  801c6d:	89 14 24             	mov    %edx,(%esp)
  801c70:	89 d8                	mov    %ebx,%eax
  801c72:	d3 e0                	shl    %cl,%eax
  801c74:	89 c2                	mov    %eax,%edx
  801c76:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c7a:	d3 e0                	shl    %cl,%eax
  801c7c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c80:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c84:	89 f1                	mov    %esi,%ecx
  801c86:	d3 e8                	shr    %cl,%eax
  801c88:	09 d0                	or     %edx,%eax
  801c8a:	d3 eb                	shr    %cl,%ebx
  801c8c:	89 da                	mov    %ebx,%edx
  801c8e:	f7 f7                	div    %edi
  801c90:	89 d3                	mov    %edx,%ebx
  801c92:	f7 24 24             	mull   (%esp)
  801c95:	89 c6                	mov    %eax,%esi
  801c97:	89 d1                	mov    %edx,%ecx
  801c99:	39 d3                	cmp    %edx,%ebx
  801c9b:	0f 82 87 00 00 00    	jb     801d28 <__umoddi3+0x134>
  801ca1:	0f 84 91 00 00 00    	je     801d38 <__umoddi3+0x144>
  801ca7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cab:	29 f2                	sub    %esi,%edx
  801cad:	19 cb                	sbb    %ecx,%ebx
  801caf:	89 d8                	mov    %ebx,%eax
  801cb1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cb5:	d3 e0                	shl    %cl,%eax
  801cb7:	89 e9                	mov    %ebp,%ecx
  801cb9:	d3 ea                	shr    %cl,%edx
  801cbb:	09 d0                	or     %edx,%eax
  801cbd:	89 e9                	mov    %ebp,%ecx
  801cbf:	d3 eb                	shr    %cl,%ebx
  801cc1:	89 da                	mov    %ebx,%edx
  801cc3:	83 c4 1c             	add    $0x1c,%esp
  801cc6:	5b                   	pop    %ebx
  801cc7:	5e                   	pop    %esi
  801cc8:	5f                   	pop    %edi
  801cc9:	5d                   	pop    %ebp
  801cca:	c3                   	ret    
  801ccb:	90                   	nop
  801ccc:	89 fd                	mov    %edi,%ebp
  801cce:	85 ff                	test   %edi,%edi
  801cd0:	75 0b                	jne    801cdd <__umoddi3+0xe9>
  801cd2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd7:	31 d2                	xor    %edx,%edx
  801cd9:	f7 f7                	div    %edi
  801cdb:	89 c5                	mov    %eax,%ebp
  801cdd:	89 f0                	mov    %esi,%eax
  801cdf:	31 d2                	xor    %edx,%edx
  801ce1:	f7 f5                	div    %ebp
  801ce3:	89 c8                	mov    %ecx,%eax
  801ce5:	f7 f5                	div    %ebp
  801ce7:	89 d0                	mov    %edx,%eax
  801ce9:	e9 44 ff ff ff       	jmp    801c32 <__umoddi3+0x3e>
  801cee:	66 90                	xchg   %ax,%ax
  801cf0:	89 c8                	mov    %ecx,%eax
  801cf2:	89 f2                	mov    %esi,%edx
  801cf4:	83 c4 1c             	add    $0x1c,%esp
  801cf7:	5b                   	pop    %ebx
  801cf8:	5e                   	pop    %esi
  801cf9:	5f                   	pop    %edi
  801cfa:	5d                   	pop    %ebp
  801cfb:	c3                   	ret    
  801cfc:	3b 04 24             	cmp    (%esp),%eax
  801cff:	72 06                	jb     801d07 <__umoddi3+0x113>
  801d01:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d05:	77 0f                	ja     801d16 <__umoddi3+0x122>
  801d07:	89 f2                	mov    %esi,%edx
  801d09:	29 f9                	sub    %edi,%ecx
  801d0b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d0f:	89 14 24             	mov    %edx,(%esp)
  801d12:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d16:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d1a:	8b 14 24             	mov    (%esp),%edx
  801d1d:	83 c4 1c             	add    $0x1c,%esp
  801d20:	5b                   	pop    %ebx
  801d21:	5e                   	pop    %esi
  801d22:	5f                   	pop    %edi
  801d23:	5d                   	pop    %ebp
  801d24:	c3                   	ret    
  801d25:	8d 76 00             	lea    0x0(%esi),%esi
  801d28:	2b 04 24             	sub    (%esp),%eax
  801d2b:	19 fa                	sbb    %edi,%edx
  801d2d:	89 d1                	mov    %edx,%ecx
  801d2f:	89 c6                	mov    %eax,%esi
  801d31:	e9 71 ff ff ff       	jmp    801ca7 <__umoddi3+0xb3>
  801d36:	66 90                	xchg   %ax,%ax
  801d38:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d3c:	72 ea                	jb     801d28 <__umoddi3+0x134>
  801d3e:	89 d9                	mov    %ebx,%ecx
  801d40:	e9 62 ff ff ff       	jmp    801ca7 <__umoddi3+0xb3>
