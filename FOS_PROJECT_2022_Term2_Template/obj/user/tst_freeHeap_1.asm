
obj/user/tst_freeHeap_1:     file format elf32-i386


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
  800031:	e8 cf 08 00 00       	call   800905 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	
	//	cprintf("envID = %d\n",envID);

	
	
	int kilo = 1024;
  800042:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	int Mega = 1024*1024;
  800049:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800050:	a1 20 30 80 00       	mov    0x803020,%eax
  800055:	8b 40 7c             	mov    0x7c(%eax),%eax
  800058:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80005b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80005e:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800063:	85 c0                	test   %eax,%eax
  800065:	74 14                	je     80007b <_main+0x43>
  800067:	83 ec 04             	sub    $0x4,%esp
  80006a:	68 e0 24 80 00       	push   $0x8024e0
  80006f:	6a 14                	push   $0x14
  800071:	68 29 25 80 00       	push   $0x802529
  800076:	e8 99 09 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  80007b:	a1 20 30 80 00       	mov    0x803020,%eax
  800080:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  800086:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800089:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80008c:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800091:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800096:	74 14                	je     8000ac <_main+0x74>
  800098:	83 ec 04             	sub    $0x4,%esp
  80009b:	68 e0 24 80 00       	push   $0x8024e0
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 29 25 80 00       	push   $0x802529
  8000a7:	e8 68 09 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b1:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8000b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bd:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000c2:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 e0 24 80 00       	push   $0x8024e0
  8000d1:	6a 16                	push   $0x16
  8000d3:	68 29 25 80 00       	push   $0x802529
  8000d8:	e8 37 09 00 00       	call   800a14 <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  8000e8:	3c 01                	cmp    $0x1,%al
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 e0 24 80 00       	push   $0x8024e0
  8000f4:	6a 17                	push   $0x17
  8000f6:	68 29 25 80 00       	push   $0x802529
  8000fb:	e8 14 09 00 00       	call   800a14 <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800100:	a1 20 30 80 00       	mov    0x803020,%eax
  800105:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80010b:	83 c0 0c             	add    $0xc,%eax
  80010e:	8b 00                	mov    (%eax),%eax
  800110:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800113:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800116:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80011b:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800120:	74 14                	je     800136 <_main+0xfe>
  800122:	83 ec 04             	sub    $0x4,%esp
  800125:	68 40 25 80 00       	push   $0x802540
  80012a:	6a 19                	push   $0x19
  80012c:	68 29 25 80 00       	push   $0x802529
  800131:	e8 de 08 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800136:	a1 20 30 80 00       	mov    0x803020,%eax
  80013b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800141:	83 c0 18             	add    $0x18,%eax
  800144:	8b 00                	mov    (%eax),%eax
  800146:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800149:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80014c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800151:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800156:	74 14                	je     80016c <_main+0x134>
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	68 40 25 80 00       	push   $0x802540
  800160:	6a 1a                	push   $0x1a
  800162:	68 29 25 80 00       	push   $0x802529
  800167:	e8 a8 08 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800177:	83 c0 24             	add    $0x24,%eax
  80017a:	8b 00                	mov    (%eax),%eax
  80017c:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80017f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800182:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800187:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80018c:	74 14                	je     8001a2 <_main+0x16a>
  80018e:	83 ec 04             	sub    $0x4,%esp
  800191:	68 40 25 80 00       	push   $0x802540
  800196:	6a 1b                	push   $0x1b
  800198:	68 29 25 80 00       	push   $0x802529
  80019d:	e8 72 08 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001ad:	83 c0 30             	add    $0x30,%eax
  8001b0:	8b 00                	mov    (%eax),%eax
  8001b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001bd:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001c2:	74 14                	je     8001d8 <_main+0x1a0>
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	68 40 25 80 00       	push   $0x802540
  8001cc:	6a 1c                	push   $0x1c
  8001ce:	68 29 25 80 00       	push   $0x802529
  8001d3:	e8 3c 08 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001e3:	83 c0 3c             	add    $0x3c,%eax
  8001e6:	8b 00                	mov    (%eax),%eax
  8001e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001eb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001ee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001f3:	3d 00 50 20 00       	cmp    $0x205000,%eax
  8001f8:	74 14                	je     80020e <_main+0x1d6>
  8001fa:	83 ec 04             	sub    $0x4,%esp
  8001fd:	68 40 25 80 00       	push   $0x802540
  800202:	6a 1d                	push   $0x1d
  800204:	68 29 25 80 00       	push   $0x802529
  800209:	e8 06 08 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800219:	83 c0 48             	add    $0x48,%eax
  80021c:	8b 00                	mov    (%eax),%eax
  80021e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800221:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800224:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800229:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 40 25 80 00       	push   $0x802540
  800238:	6a 1e                	push   $0x1e
  80023a:	68 29 25 80 00       	push   $0x802529
  80023f:	e8 d0 07 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800244:	a1 20 30 80 00       	mov    0x803020,%eax
  800249:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80024f:	83 c0 54             	add    $0x54,%eax
  800252:	8b 00                	mov    (%eax),%eax
  800254:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800257:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80025a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80025f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800264:	74 14                	je     80027a <_main+0x242>
  800266:	83 ec 04             	sub    $0x4,%esp
  800269:	68 40 25 80 00       	push   $0x802540
  80026e:	6a 1f                	push   $0x1f
  800270:	68 29 25 80 00       	push   $0x802529
  800275:	e8 9a 07 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80027a:	a1 20 30 80 00       	mov    0x803020,%eax
  80027f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800285:	83 c0 60             	add    $0x60,%eax
  800288:	8b 00                	mov    (%eax),%eax
  80028a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80028d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800290:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800295:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 40 25 80 00       	push   $0x802540
  8002a4:	6a 20                	push   $0x20
  8002a6:	68 29 25 80 00       	push   $0x802529
  8002ab:	e8 64 07 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002bb:	83 c0 6c             	add    $0x6c,%eax
  8002be:	8b 00                	mov    (%eax),%eax
  8002c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8002c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002cb:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002d0:	74 14                	je     8002e6 <_main+0x2ae>
  8002d2:	83 ec 04             	sub    $0x4,%esp
  8002d5:	68 40 25 80 00       	push   $0x802540
  8002da:	6a 21                	push   $0x21
  8002dc:	68 29 25 80 00       	push   $0x802529
  8002e1:	e8 2e 07 00 00       	call   800a14 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002eb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002f1:	83 c0 78             	add    $0x78,%eax
  8002f4:	8b 00                	mov    (%eax),%eax
  8002f6:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8002f9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800301:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800306:	74 14                	je     80031c <_main+0x2e4>
  800308:	83 ec 04             	sub    $0x4,%esp
  80030b:	68 40 25 80 00       	push   $0x802540
  800310:	6a 22                	push   $0x22
  800312:	68 29 25 80 00       	push   $0x802529
  800317:	e8 f8 06 00 00       	call   800a14 <_panic>

		if( myEnv->page_last_WS_index !=  11)  										panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80031c:	a1 20 30 80 00       	mov    0x803020,%eax
  800321:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800327:	83 f8 0b             	cmp    $0xb,%eax
  80032a:	74 14                	je     800340 <_main+0x308>
  80032c:	83 ec 04             	sub    $0x4,%esp
  80032f:	68 40 25 80 00       	push   $0x802540
  800334:	6a 24                	push   $0x24
  800336:	68 29 25 80 00       	push   $0x802529
  80033b:	e8 d4 06 00 00       	call   800a14 <_panic>
	}


	/// testing freeHeap()
	{
		int freeFrames = sys_calculate_free_frames() ;
  800340:	e8 82 1a 00 00       	call   801dc7 <sys_calculate_free_frames>
  800345:	89 45 b8             	mov    %eax,-0x48(%ebp)
		int origFreeFrames = freeFrames ;
  800348:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80034b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034e:	e8 f7 1a 00 00       	call   801e4a <sys_pf_calculate_allocated_pages>
  800353:	89 45 b0             	mov    %eax,-0x50(%ebp)

		uint32 size = 12*Mega;
  800356:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800359:	89 d0                	mov    %edx,%eax
  80035b:	01 c0                	add    %eax,%eax
  80035d:	01 d0                	add    %edx,%eax
  80035f:	c1 e0 02             	shl    $0x2,%eax
  800362:	89 45 ac             	mov    %eax,-0x54(%ebp)
		unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	ff 75 ac             	pushl  -0x54(%ebp)
  80036b:	e8 e2 16 00 00       	call   801a52 <malloc>
  800370:	83 c4 10             	add    $0x10,%esp
  800373:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if(!(((uint32)x == USER_HEAP_START) && (freeFrames - sys_calculate_free_frames()) == 3))
  800376:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800379:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80037e:	75 11                	jne    800391 <_main+0x359>
  800380:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  800383:	e8 3f 1a 00 00       	call   801dc7 <sys_calculate_free_frames>
  800388:	29 c3                	sub    %eax,%ebx
  80038a:	89 d8                	mov    %ebx,%eax
  80038c:	83 f8 03             	cmp    $0x3,%eax
  80038f:	74 14                	je     8003a5 <_main+0x36d>
			panic("malloc() does not work correctly... check it before checking freeHeap") ;
  800391:	83 ec 04             	sub    $0x4,%esp
  800394:	68 88 25 80 00       	push   $0x802588
  800399:	6a 31                	push   $0x31
  80039b:	68 29 25 80 00       	push   $0x802529
  8003a0:	e8 6f 06 00 00       	call   800a14 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8003a5:	e8 1d 1a 00 00       	call   801dc7 <sys_calculate_free_frames>
  8003aa:	89 45 b8             	mov    %eax,-0x48(%ebp)
		size = 2*kilo;
  8003ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003b0:	01 c0                	add    %eax,%eax
  8003b2:	89 45 ac             	mov    %eax,-0x54(%ebp)
		unsigned char *y = malloc(sizeof(unsigned char)*size) ;
  8003b5:	83 ec 0c             	sub    $0xc,%esp
  8003b8:	ff 75 ac             	pushl  -0x54(%ebp)
  8003bb:	e8 92 16 00 00       	call   801a52 <malloc>
  8003c0:	83 c4 10             	add    $0x10,%esp
  8003c3:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if(!(((uint32)y == USER_HEAP_START + 12*Mega) && (freeFrames - sys_calculate_free_frames()) == 1))
  8003c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8003c9:	89 d0                	mov    %edx,%eax
  8003cb:	01 c0                	add    %eax,%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	c1 e0 02             	shl    $0x2,%eax
  8003d2:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8003d8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	75 11                	jne    8003f0 <_main+0x3b8>
  8003df:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  8003e2:	e8 e0 19 00 00       	call   801dc7 <sys_calculate_free_frames>
  8003e7:	29 c3                	sub    %eax,%ebx
  8003e9:	89 d8                	mov    %ebx,%eax
  8003eb:	83 f8 01             	cmp    $0x1,%eax
  8003ee:	74 14                	je     800404 <_main+0x3cc>
			panic("malloc() does not work correctly... check it before checking freeHeap") ;
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 88 25 80 00       	push   $0x802588
  8003f8:	6a 37                	push   $0x37
  8003fa:	68 29 25 80 00       	push   $0x802529
  8003ff:	e8 10 06 00 00       	call   800a14 <_panic>


		x[1]=-1;
  800404:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800407:	40                   	inc    %eax
  800408:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  80040b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040e:	c1 e0 03             	shl    $0x3,%eax
  800411:	89 c2                	mov    %eax,%edx
  800413:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800416:	01 d0                	add    %edx,%eax
  800418:	c6 00 ff             	movb   $0xff,(%eax)

		x[512*kilo]=-1;
  80041b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041e:	c1 e0 09             	shl    $0x9,%eax
  800421:	89 c2                	mov    %eax,%edx
  800423:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800426:	01 d0                	add    %edx,%eax
  800428:	c6 00 ff             	movb   $0xff,(%eax)

		free(x);
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	ff 75 a8             	pushl  -0x58(%ebp)
  800431:	e8 d4 17 00 00       	call   801c0a <free>
  800436:	83 c4 10             	add    $0x10,%esp
		free(y);
  800439:	83 ec 0c             	sub    $0xc,%esp
  80043c:	ff 75 a4             	pushl  -0x5c(%ebp)
  80043f:	e8 c6 17 00 00       	call   801c0a <free>
  800444:	83 c4 10             	add    $0x10,%esp

		if((origFreeFrames - sys_calculate_free_frames()) != 4 ) panic("FreeHeap didn't correctly free the allocated memory (pages and/or tables)");
  800447:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
  80044a:	e8 78 19 00 00       	call   801dc7 <sys_calculate_free_frames>
  80044f:	29 c3                	sub    %eax,%ebx
  800451:	89 d8                	mov    %ebx,%eax
  800453:	83 f8 04             	cmp    $0x4,%eax
  800456:	74 14                	je     80046c <_main+0x434>
  800458:	83 ec 04             	sub    $0x4,%esp
  80045b:	68 d0 25 80 00       	push   $0x8025d0
  800460:	6a 43                	push   $0x43
  800462:	68 29 25 80 00       	push   $0x802529
  800467:	e8 a8 05 00 00       	call   800a14 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("FreeHeap didn't correctly free the allocated space (pages and/or tables) in PageFile");
  80046c:	e8 d9 19 00 00       	call   801e4a <sys_pf_calculate_allocated_pages>
  800471:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  800474:	74 14                	je     80048a <_main+0x452>
  800476:	83 ec 04             	sub    $0x4,%esp
  800479:	68 1c 26 80 00       	push   $0x80261c
  80047e:	6a 44                	push   $0x44
  800480:	68 29 25 80 00       	push   $0x802529
  800485:	e8 8a 05 00 00       	call   800a14 <_panic>

		{
			if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  panic("TABLE WS entry checking failed");
  80048a:	a1 20 30 80 00       	mov    0x803020,%eax
  80048f:	8b 40 7c             	mov    0x7c(%eax),%eax
  800492:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800495:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800498:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  80049d:	85 c0                	test   %eax,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 74 26 80 00       	push   $0x802674
  8004a9:	6a 47                	push   $0x47
  8004ab:	68 29 25 80 00       	push   $0x802529
  8004b0:	e8 5f 05 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  panic("TABLE WS entry checking failed");
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  8004c0:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8004c3:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004c6:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8004cb:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8004d0:	74 14                	je     8004e6 <_main+0x4ae>
  8004d2:	83 ec 04             	sub    $0x4,%esp
  8004d5:	68 74 26 80 00       	push   $0x802674
  8004da:	6a 48                	push   $0x48
  8004dc:	68 29 25 80 00       	push   $0x802529
  8004e1:	e8 2e 05 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("TABLE WS entry checking failed");
  8004e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004eb:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
  8004f1:	89 45 98             	mov    %eax,-0x68(%ebp)
  8004f4:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004f7:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8004fc:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  800501:	74 14                	je     800517 <_main+0x4df>
  800503:	83 ec 04             	sub    $0x4,%esp
  800506:	68 74 26 80 00       	push   $0x802674
  80050b:	6a 49                	push   $0x49
  80050d:	68 29 25 80 00       	push   $0x802529
  800512:	e8 fd 04 00 00       	call   800a14 <_panic>
			if( myEnv->__ptr_tws[3].empty != 1 )  panic("TABLE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  800517:	a1 20 30 80 00       	mov    0x803020,%eax
  80051c:	8a 80 a4 00 00 00    	mov    0xa4(%eax),%al
  800522:	3c 01                	cmp    $0x1,%al
  800524:	74 14                	je     80053a <_main+0x502>
  800526:	83 ec 04             	sub    $0x4,%esp
  800529:	68 94 26 80 00       	push   $0x802694
  80052e:	6a 4a                	push   $0x4a
  800530:	68 29 25 80 00       	push   $0x802529
  800535:	e8 da 04 00 00       	call   800a14 <_panic>
			if( myEnv->__ptr_tws[4].empty != 1 )  panic("TABLE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  80053a:	a1 20 30 80 00       	mov    0x803020,%eax
  80053f:	8a 80 b0 00 00 00    	mov    0xb0(%eax),%al
  800545:	3c 01                	cmp    $0x1,%al
  800547:	74 14                	je     80055d <_main+0x525>
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	68 94 26 80 00       	push   $0x802694
  800551:	6a 4b                	push   $0x4b
  800553:	68 29 25 80 00       	push   $0x802529
  800558:	e8 b7 04 00 00       	call   800a14 <_panic>

			if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  panic("PAGE WS entry checking failed");
  80055d:	a1 20 30 80 00       	mov    0x803020,%eax
  800562:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800568:	8b 00                	mov    (%eax),%eax
  80056a:	89 45 94             	mov    %eax,-0x6c(%ebp)
  80056d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800570:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800575:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 d9 26 80 00       	push   $0x8026d9
  800584:	6a 4d                	push   $0x4d
  800586:	68 29 25 80 00       	push   $0x802529
  80058b:	e8 84 04 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("PAGE WS entry checking failed");
  800590:	a1 20 30 80 00       	mov    0x803020,%eax
  800595:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80059b:	83 c0 0c             	add    $0xc,%eax
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	89 45 90             	mov    %eax,-0x70(%ebp)
  8005a3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8005a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005ab:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8005b0:	74 14                	je     8005c6 <_main+0x58e>
  8005b2:	83 ec 04             	sub    $0x4,%esp
  8005b5:	68 d9 26 80 00       	push   $0x8026d9
  8005ba:	6a 4e                	push   $0x4e
  8005bc:	68 29 25 80 00       	push   $0x802529
  8005c1:	e8 4e 04 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("PAGE WS entry checking failed");
  8005c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005d1:	83 c0 18             	add    $0x18,%eax
  8005d4:	8b 00                	mov    (%eax),%eax
  8005d6:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8005d9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8005dc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005e1:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8005e6:	74 14                	je     8005fc <_main+0x5c4>
  8005e8:	83 ec 04             	sub    $0x4,%esp
  8005eb:	68 d9 26 80 00       	push   $0x8026d9
  8005f0:	6a 4f                	push   $0x4f
  8005f2:	68 29 25 80 00       	push   $0x802529
  8005f7:	e8 18 04 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("PAGE WS entry checking failed");
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800607:	83 c0 24             	add    $0x24,%eax
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	89 45 88             	mov    %eax,-0x78(%ebp)
  80060f:	8b 45 88             	mov    -0x78(%ebp),%eax
  800612:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800617:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80061c:	74 14                	je     800632 <_main+0x5fa>
  80061e:	83 ec 04             	sub    $0x4,%esp
  800621:	68 d9 26 80 00       	push   $0x8026d9
  800626:	6a 50                	push   $0x50
  800628:	68 29 25 80 00       	push   $0x802529
  80062d:	e8 e2 03 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("PAGE WS entry checking failed");
  800632:	a1 20 30 80 00       	mov    0x803020,%eax
  800637:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80063d:	83 c0 30             	add    $0x30,%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800645:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800648:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064d:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800652:	74 14                	je     800668 <_main+0x630>
  800654:	83 ec 04             	sub    $0x4,%esp
  800657:	68 d9 26 80 00       	push   $0x8026d9
  80065c:	6a 51                	push   $0x51
  80065e:	68 29 25 80 00       	push   $0x802529
  800663:	e8 ac 03 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("PAGE WS entry checking failed");
  800668:	a1 20 30 80 00       	mov    0x803020,%eax
  80066d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800673:	83 c0 3c             	add    $0x3c,%eax
  800676:	8b 00                	mov    (%eax),%eax
  800678:	89 45 80             	mov    %eax,-0x80(%ebp)
  80067b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80067e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800683:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800688:	74 14                	je     80069e <_main+0x666>
  80068a:	83 ec 04             	sub    $0x4,%esp
  80068d:	68 d9 26 80 00       	push   $0x8026d9
  800692:	6a 52                	push   $0x52
  800694:	68 29 25 80 00       	push   $0x802529
  800699:	e8 76 03 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("PAGE WS entry checking failed");
  80069e:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006a9:	83 c0 48             	add    $0x48,%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  8006b4:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006bf:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8006c4:	74 14                	je     8006da <_main+0x6a2>
  8006c6:	83 ec 04             	sub    $0x4,%esp
  8006c9:	68 d9 26 80 00       	push   $0x8026d9
  8006ce:	6a 53                	push   $0x53
  8006d0:	68 29 25 80 00       	push   $0x802529
  8006d5:	e8 3a 03 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("PAGE WS entry checking failed");
  8006da:	a1 20 30 80 00       	mov    0x803020,%eax
  8006df:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006e5:	83 c0 54             	add    $0x54,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  8006f0:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8006f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006fb:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800700:	74 14                	je     800716 <_main+0x6de>
  800702:	83 ec 04             	sub    $0x4,%esp
  800705:	68 d9 26 80 00       	push   $0x8026d9
  80070a:	6a 54                	push   $0x54
  80070c:	68 29 25 80 00       	push   $0x802529
  800711:	e8 fe 02 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("PAGE WS entry checking failed");
  800716:	a1 20 30 80 00       	mov    0x803020,%eax
  80071b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800721:	83 c0 60             	add    $0x60,%eax
  800724:	8b 00                	mov    (%eax),%eax
  800726:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  80072c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800732:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800737:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80073c:	74 14                	je     800752 <_main+0x71a>
  80073e:	83 ec 04             	sub    $0x4,%esp
  800741:	68 d9 26 80 00       	push   $0x8026d9
  800746:	6a 55                	push   $0x55
  800748:	68 29 25 80 00       	push   $0x802529
  80074d:	e8 c2 02 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("PAGE WS entry checking failed");
  800752:	a1 20 30 80 00       	mov    0x803020,%eax
  800757:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80075d:	83 c0 6c             	add    $0x6c,%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  800768:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80076e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800773:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800778:	74 14                	je     80078e <_main+0x756>
  80077a:	83 ec 04             	sub    $0x4,%esp
  80077d:	68 d9 26 80 00       	push   $0x8026d9
  800782:	6a 56                	push   $0x56
  800784:	68 29 25 80 00       	push   $0x802529
  800789:	e8 86 02 00 00       	call   800a14 <_panic>
			if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("PAGE WS entry checking failed");
  80078e:	a1 20 30 80 00       	mov    0x803020,%eax
  800793:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800799:	83 c0 78             	add    $0x78,%eax
  80079c:	8b 00                	mov    (%eax),%eax
  80079e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  8007a4:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007af:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8007b4:	74 14                	je     8007ca <_main+0x792>
  8007b6:	83 ec 04             	sub    $0x4,%esp
  8007b9:	68 d9 26 80 00       	push   $0x8026d9
  8007be:	6a 57                	push   $0x57
  8007c0:	68 29 25 80 00       	push   $0x802529
  8007c5:	e8 4a 02 00 00       	call   800a14 <_panic>
			if( myEnv->__uptr_pws[11].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  8007ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8007cf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8007d5:	05 84 00 00 00       	add    $0x84,%eax
  8007da:	8a 40 04             	mov    0x4(%eax),%al
  8007dd:	3c 01                	cmp    $0x1,%al
  8007df:	74 14                	je     8007f5 <_main+0x7bd>
  8007e1:	83 ec 04             	sub    $0x4,%esp
  8007e4:	68 f8 26 80 00       	push   $0x8026f8
  8007e9:	6a 58                	push   $0x58
  8007eb:	68 29 25 80 00       	push   $0x802529
  8007f0:	e8 1f 02 00 00       	call   800a14 <_panic>
			if( myEnv->__uptr_pws[12].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  8007f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fa:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800800:	05 90 00 00 00       	add    $0x90,%eax
  800805:	8a 40 04             	mov    0x4(%eax),%al
  800808:	3c 01                	cmp    $0x1,%al
  80080a:	74 14                	je     800820 <_main+0x7e8>
  80080c:	83 ec 04             	sub    $0x4,%esp
  80080f:	68 f8 26 80 00       	push   $0x8026f8
  800814:	6a 59                	push   $0x59
  800816:	68 29 25 80 00       	push   $0x802529
  80081b:	e8 f4 01 00 00       	call   800a14 <_panic>
			if( myEnv->__uptr_pws[13].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  800820:	a1 20 30 80 00       	mov    0x803020,%eax
  800825:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80082b:	05 9c 00 00 00       	add    $0x9c,%eax
  800830:	8a 40 04             	mov    0x4(%eax),%al
  800833:	3c 01                	cmp    $0x1,%al
  800835:	74 14                	je     80084b <_main+0x813>
  800837:	83 ec 04             	sub    $0x4,%esp
  80083a:	68 f8 26 80 00       	push   $0x8026f8
  80083f:	6a 5a                	push   $0x5a
  800841:	68 29 25 80 00       	push   $0x802529
  800846:	e8 c9 01 00 00       	call   800a14 <_panic>
			if( myEnv->__uptr_pws[14].empty != 1)  panic("PAGE WS entry checking failed.. Expected to be EMPTY after FreeHeap");
  80084b:	a1 20 30 80 00       	mov    0x803020,%eax
  800850:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800856:	05 a8 00 00 00       	add    $0xa8,%eax
  80085b:	8a 40 04             	mov    0x4(%eax),%al
  80085e:	3c 01                	cmp    $0x1,%al
  800860:	74 14                	je     800876 <_main+0x83e>
  800862:	83 ec 04             	sub    $0x4,%esp
  800865:	68 f8 26 80 00       	push   $0x8026f8
  80086a:	6a 5b                	push   $0x5b
  80086c:	68 29 25 80 00       	push   $0x802529
  800871:	e8 9e 01 00 00       	call   800a14 <_panic>
		}

		//Checking if freeHeap RESET the HEAP POINTER or not
		{
			unsigned char *z = malloc(sizeof(unsigned char)*1) ;
  800876:	83 ec 0c             	sub    $0xc,%esp
  800879:	6a 01                	push   $0x1
  80087b:	e8 d2 11 00 00       	call   801a52 <malloc>
  800880:	83 c4 10             	add    $0x10,%esp
  800883:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)

			if(!((uint32)z == USER_HEAP_START) )
  800889:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  80088f:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800894:	74 14                	je     8008aa <_main+0x872>
				panic("ERROR: freeHeap didn't reset the HEAP POINTER after finishing... Kindly reset it!!") ;
  800896:	83 ec 04             	sub    $0x4,%esp
  800899:	68 3c 27 80 00       	push   $0x80273c
  80089e:	6a 63                	push   $0x63
  8008a0:	68 29 25 80 00       	push   $0x802529
  8008a5:	e8 6a 01 00 00       	call   800a14 <_panic>
		}
		cprintf("Congratulations!! test freeHeap completed successfully.\n");
  8008aa:	83 ec 0c             	sub    $0xc,%esp
  8008ad:	68 90 27 80 00       	push   $0x802790
  8008b2:	e8 11 04 00 00       	call   800cc8 <cprintf>
  8008b7:	83 c4 10             	add    $0x10,%esp

		//Try to access any of the removed buffered pages in the Heap [It's ILLEGAL ACCESS now]
		{
			cprintf("\nNow, trying to access the removed pages in the HEAP, you should make the kernel PANIC with ILLEGAL MEMORY ACCESS in page_fault_handler() since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK.\n\n\n");
  8008ba:	83 ec 0c             	sub    $0xc,%esp
  8008bd:	68 cc 27 80 00       	push   $0x8027cc
  8008c2:	e8 01 04 00 00       	call   800cc8 <cprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp

			x[1]=-1;
  8008ca:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008cd:	40                   	inc    %eax
  8008ce:	c6 00 ff             	movb   $0xff,(%eax)

			x[8*Mega] = -1;
  8008d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d4:	c1 e0 03             	shl    $0x3,%eax
  8008d7:	89 c2                	mov    %eax,%edx
  8008d9:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008dc:	01 d0                	add    %edx,%eax
  8008de:	c6 00 ff             	movb   $0xff,(%eax)

			x[512*kilo]=-1;
  8008e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e4:	c1 e0 09             	shl    $0x9,%eax
  8008e7:	89 c2                	mov    %eax,%edx
  8008e9:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8008ec:	01 d0                	add    %edx,%eax
  8008ee:	c6 00 ff             	movb   $0xff,(%eax)

		}
		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for stack pages\n");
  8008f1:	83 ec 04             	sub    $0x4,%esp
  8008f4:	68 b0 28 80 00       	push   $0x8028b0
  8008f9:	6a 72                	push   $0x72
  8008fb:	68 29 25 80 00       	push   $0x802529
  800900:	e8 0f 01 00 00       	call   800a14 <_panic>

00800905 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800905:	55                   	push   %ebp
  800906:	89 e5                	mov    %esp,%ebp
  800908:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80090b:	e8 ec 13 00 00       	call   801cfc <sys_getenvindex>
  800910:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800913:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800916:	89 d0                	mov    %edx,%eax
  800918:	c1 e0 02             	shl    $0x2,%eax
  80091b:	01 d0                	add    %edx,%eax
  80091d:	01 c0                	add    %eax,%eax
  80091f:	01 d0                	add    %edx,%eax
  800921:	01 c0                	add    %eax,%eax
  800923:	01 d0                	add    %edx,%eax
  800925:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80092c:	01 d0                	add    %edx,%eax
  80092e:	c1 e0 02             	shl    $0x2,%eax
  800931:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800936:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80093b:	a1 20 30 80 00       	mov    0x803020,%eax
  800940:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800946:	84 c0                	test   %al,%al
  800948:	74 0f                	je     800959 <libmain+0x54>
		binaryname = myEnv->prog_name;
  80094a:	a1 20 30 80 00       	mov    0x803020,%eax
  80094f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800954:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800959:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80095d:	7e 0a                	jle    800969 <libmain+0x64>
		binaryname = argv[0];
  80095f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800962:	8b 00                	mov    (%eax),%eax
  800964:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800969:	83 ec 08             	sub    $0x8,%esp
  80096c:	ff 75 0c             	pushl  0xc(%ebp)
  80096f:	ff 75 08             	pushl  0x8(%ebp)
  800972:	e8 c1 f6 ff ff       	call   800038 <_main>
  800977:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80097a:	e8 18 15 00 00       	call   801e97 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80097f:	83 ec 0c             	sub    $0xc,%esp
  800982:	68 d0 29 80 00       	push   $0x8029d0
  800987:	e8 3c 03 00 00       	call   800cc8 <cprintf>
  80098c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80098f:	a1 20 30 80 00       	mov    0x803020,%eax
  800994:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80099a:	a1 20 30 80 00       	mov    0x803020,%eax
  80099f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8009a5:	83 ec 04             	sub    $0x4,%esp
  8009a8:	52                   	push   %edx
  8009a9:	50                   	push   %eax
  8009aa:	68 f8 29 80 00       	push   $0x8029f8
  8009af:	e8 14 03 00 00       	call   800cc8 <cprintf>
  8009b4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8009b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8009bc:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8009c2:	83 ec 08             	sub    $0x8,%esp
  8009c5:	50                   	push   %eax
  8009c6:	68 1d 2a 80 00       	push   $0x802a1d
  8009cb:	e8 f8 02 00 00       	call   800cc8 <cprintf>
  8009d0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009d3:	83 ec 0c             	sub    $0xc,%esp
  8009d6:	68 d0 29 80 00       	push   $0x8029d0
  8009db:	e8 e8 02 00 00       	call   800cc8 <cprintf>
  8009e0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009e3:	e8 c9 14 00 00       	call   801eb1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009e8:	e8 19 00 00 00       	call   800a06 <exit>
}
  8009ed:	90                   	nop
  8009ee:	c9                   	leave  
  8009ef:	c3                   	ret    

008009f0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009f0:	55                   	push   %ebp
  8009f1:	89 e5                	mov    %esp,%ebp
  8009f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009f6:	83 ec 0c             	sub    $0xc,%esp
  8009f9:	6a 00                	push   $0x0
  8009fb:	e8 c8 12 00 00       	call   801cc8 <sys_env_destroy>
  800a00:	83 c4 10             	add    $0x10,%esp
}
  800a03:	90                   	nop
  800a04:	c9                   	leave  
  800a05:	c3                   	ret    

00800a06 <exit>:

void
exit(void)
{
  800a06:	55                   	push   %ebp
  800a07:	89 e5                	mov    %esp,%ebp
  800a09:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800a0c:	e8 1d 13 00 00       	call   801d2e <sys_env_exit>
}
  800a11:	90                   	nop
  800a12:	c9                   	leave  
  800a13:	c3                   	ret    

00800a14 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a14:	55                   	push   %ebp
  800a15:	89 e5                	mov    %esp,%ebp
  800a17:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a1a:	8d 45 10             	lea    0x10(%ebp),%eax
  800a1d:	83 c0 04             	add    $0x4,%eax
  800a20:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a23:	a1 34 30 80 00       	mov    0x803034,%eax
  800a28:	85 c0                	test   %eax,%eax
  800a2a:	74 16                	je     800a42 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a2c:	a1 34 30 80 00       	mov    0x803034,%eax
  800a31:	83 ec 08             	sub    $0x8,%esp
  800a34:	50                   	push   %eax
  800a35:	68 34 2a 80 00       	push   $0x802a34
  800a3a:	e8 89 02 00 00       	call   800cc8 <cprintf>
  800a3f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a42:	a1 00 30 80 00       	mov    0x803000,%eax
  800a47:	ff 75 0c             	pushl  0xc(%ebp)
  800a4a:	ff 75 08             	pushl  0x8(%ebp)
  800a4d:	50                   	push   %eax
  800a4e:	68 39 2a 80 00       	push   $0x802a39
  800a53:	e8 70 02 00 00       	call   800cc8 <cprintf>
  800a58:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5e:	83 ec 08             	sub    $0x8,%esp
  800a61:	ff 75 f4             	pushl  -0xc(%ebp)
  800a64:	50                   	push   %eax
  800a65:	e8 f3 01 00 00       	call   800c5d <vcprintf>
  800a6a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	6a 00                	push   $0x0
  800a72:	68 55 2a 80 00       	push   $0x802a55
  800a77:	e8 e1 01 00 00       	call   800c5d <vcprintf>
  800a7c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a7f:	e8 82 ff ff ff       	call   800a06 <exit>

	// should not return here
	while (1) ;
  800a84:	eb fe                	jmp    800a84 <_panic+0x70>

00800a86 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a86:	55                   	push   %ebp
  800a87:	89 e5                	mov    %esp,%ebp
  800a89:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a8c:	a1 20 30 80 00       	mov    0x803020,%eax
  800a91:	8b 50 74             	mov    0x74(%eax),%edx
  800a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a97:	39 c2                	cmp    %eax,%edx
  800a99:	74 14                	je     800aaf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a9b:	83 ec 04             	sub    $0x4,%esp
  800a9e:	68 58 2a 80 00       	push   $0x802a58
  800aa3:	6a 26                	push   $0x26
  800aa5:	68 a4 2a 80 00       	push   $0x802aa4
  800aaa:	e8 65 ff ff ff       	call   800a14 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800aaf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800ab6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800abd:	e9 c2 00 00 00       	jmp    800b84 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	01 d0                	add    %edx,%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	85 c0                	test   %eax,%eax
  800ad5:	75 08                	jne    800adf <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800ad7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ada:	e9 a2 00 00 00       	jmp    800b81 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800adf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ae6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800aed:	eb 69                	jmp    800b58 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800aef:	a1 20 30 80 00       	mov    0x803020,%eax
  800af4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800afa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800afd:	89 d0                	mov    %edx,%eax
  800aff:	01 c0                	add    %eax,%eax
  800b01:	01 d0                	add    %edx,%eax
  800b03:	c1 e0 02             	shl    $0x2,%eax
  800b06:	01 c8                	add    %ecx,%eax
  800b08:	8a 40 04             	mov    0x4(%eax),%al
  800b0b:	84 c0                	test   %al,%al
  800b0d:	75 46                	jne    800b55 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b0f:	a1 20 30 80 00       	mov    0x803020,%eax
  800b14:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b1a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b1d:	89 d0                	mov    %edx,%eax
  800b1f:	01 c0                	add    %eax,%eax
  800b21:	01 d0                	add    %edx,%eax
  800b23:	c1 e0 02             	shl    $0x2,%eax
  800b26:	01 c8                	add    %ecx,%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b30:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b35:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b3a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	01 c8                	add    %ecx,%eax
  800b46:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b48:	39 c2                	cmp    %eax,%edx
  800b4a:	75 09                	jne    800b55 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b4c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b53:	eb 12                	jmp    800b67 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b55:	ff 45 e8             	incl   -0x18(%ebp)
  800b58:	a1 20 30 80 00       	mov    0x803020,%eax
  800b5d:	8b 50 74             	mov    0x74(%eax),%edx
  800b60:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b63:	39 c2                	cmp    %eax,%edx
  800b65:	77 88                	ja     800aef <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b67:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b6b:	75 14                	jne    800b81 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800b6d:	83 ec 04             	sub    $0x4,%esp
  800b70:	68 b0 2a 80 00       	push   $0x802ab0
  800b75:	6a 3a                	push   $0x3a
  800b77:	68 a4 2a 80 00       	push   $0x802aa4
  800b7c:	e8 93 fe ff ff       	call   800a14 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b81:	ff 45 f0             	incl   -0x10(%ebp)
  800b84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b87:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b8a:	0f 8c 32 ff ff ff    	jl     800ac2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b90:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b97:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b9e:	eb 26                	jmp    800bc6 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800ba0:	a1 20 30 80 00       	mov    0x803020,%eax
  800ba5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bab:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bae:	89 d0                	mov    %edx,%eax
  800bb0:	01 c0                	add    %eax,%eax
  800bb2:	01 d0                	add    %edx,%eax
  800bb4:	c1 e0 02             	shl    $0x2,%eax
  800bb7:	01 c8                	add    %ecx,%eax
  800bb9:	8a 40 04             	mov    0x4(%eax),%al
  800bbc:	3c 01                	cmp    $0x1,%al
  800bbe:	75 03                	jne    800bc3 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800bc0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bc3:	ff 45 e0             	incl   -0x20(%ebp)
  800bc6:	a1 20 30 80 00       	mov    0x803020,%eax
  800bcb:	8b 50 74             	mov    0x74(%eax),%edx
  800bce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bd1:	39 c2                	cmp    %eax,%edx
  800bd3:	77 cb                	ja     800ba0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bd8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bdb:	74 14                	je     800bf1 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800bdd:	83 ec 04             	sub    $0x4,%esp
  800be0:	68 04 2b 80 00       	push   $0x802b04
  800be5:	6a 44                	push   $0x44
  800be7:	68 a4 2a 80 00       	push   $0x802aa4
  800bec:	e8 23 fe ff ff       	call   800a14 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bf1:	90                   	nop
  800bf2:	c9                   	leave  
  800bf3:	c3                   	ret    

00800bf4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800bf4:	55                   	push   %ebp
  800bf5:	89 e5                	mov    %esp,%ebp
  800bf7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfd:	8b 00                	mov    (%eax),%eax
  800bff:	8d 48 01             	lea    0x1(%eax),%ecx
  800c02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c05:	89 0a                	mov    %ecx,(%edx)
  800c07:	8b 55 08             	mov    0x8(%ebp),%edx
  800c0a:	88 d1                	mov    %dl,%cl
  800c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c0f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c1d:	75 2c                	jne    800c4b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c1f:	a0 24 30 80 00       	mov    0x803024,%al
  800c24:	0f b6 c0             	movzbl %al,%eax
  800c27:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2a:	8b 12                	mov    (%edx),%edx
  800c2c:	89 d1                	mov    %edx,%ecx
  800c2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c31:	83 c2 08             	add    $0x8,%edx
  800c34:	83 ec 04             	sub    $0x4,%esp
  800c37:	50                   	push   %eax
  800c38:	51                   	push   %ecx
  800c39:	52                   	push   %edx
  800c3a:	e8 47 10 00 00       	call   801c86 <sys_cputs>
  800c3f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c45:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4e:	8b 40 04             	mov    0x4(%eax),%eax
  800c51:	8d 50 01             	lea    0x1(%eax),%edx
  800c54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c57:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c5a:	90                   	nop
  800c5b:	c9                   	leave  
  800c5c:	c3                   	ret    

00800c5d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c5d:	55                   	push   %ebp
  800c5e:	89 e5                	mov    %esp,%ebp
  800c60:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c66:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c6d:	00 00 00 
	b.cnt = 0;
  800c70:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c77:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c7a:	ff 75 0c             	pushl  0xc(%ebp)
  800c7d:	ff 75 08             	pushl  0x8(%ebp)
  800c80:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c86:	50                   	push   %eax
  800c87:	68 f4 0b 80 00       	push   $0x800bf4
  800c8c:	e8 11 02 00 00       	call   800ea2 <vprintfmt>
  800c91:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c94:	a0 24 30 80 00       	mov    0x803024,%al
  800c99:	0f b6 c0             	movzbl %al,%eax
  800c9c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800ca2:	83 ec 04             	sub    $0x4,%esp
  800ca5:	50                   	push   %eax
  800ca6:	52                   	push   %edx
  800ca7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800cad:	83 c0 08             	add    $0x8,%eax
  800cb0:	50                   	push   %eax
  800cb1:	e8 d0 0f 00 00       	call   801c86 <sys_cputs>
  800cb6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800cb9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cc0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cc6:	c9                   	leave  
  800cc7:	c3                   	ret    

00800cc8 <cprintf>:

int cprintf(const char *fmt, ...) {
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
  800ccb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cce:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cd5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cd8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	83 ec 08             	sub    $0x8,%esp
  800ce1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce4:	50                   	push   %eax
  800ce5:	e8 73 ff ff ff       	call   800c5d <vcprintf>
  800cea:	83 c4 10             	add    $0x10,%esp
  800ced:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf3:	c9                   	leave  
  800cf4:	c3                   	ret    

00800cf5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800cf5:	55                   	push   %ebp
  800cf6:	89 e5                	mov    %esp,%ebp
  800cf8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cfb:	e8 97 11 00 00       	call   801e97 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800d00:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d03:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d0f:	50                   	push   %eax
  800d10:	e8 48 ff ff ff       	call   800c5d <vcprintf>
  800d15:	83 c4 10             	add    $0x10,%esp
  800d18:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d1b:	e8 91 11 00 00       	call   801eb1 <sys_enable_interrupt>
	return cnt;
  800d20:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d23:	c9                   	leave  
  800d24:	c3                   	ret    

00800d25 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d25:	55                   	push   %ebp
  800d26:	89 e5                	mov    %esp,%ebp
  800d28:	53                   	push   %ebx
  800d29:	83 ec 14             	sub    $0x14,%esp
  800d2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d32:	8b 45 14             	mov    0x14(%ebp),%eax
  800d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d38:	8b 45 18             	mov    0x18(%ebp),%eax
  800d3b:	ba 00 00 00 00       	mov    $0x0,%edx
  800d40:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d43:	77 55                	ja     800d9a <printnum+0x75>
  800d45:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d48:	72 05                	jb     800d4f <printnum+0x2a>
  800d4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d4d:	77 4b                	ja     800d9a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d4f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d52:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d55:	8b 45 18             	mov    0x18(%ebp),%eax
  800d58:	ba 00 00 00 00       	mov    $0x0,%edx
  800d5d:	52                   	push   %edx
  800d5e:	50                   	push   %eax
  800d5f:	ff 75 f4             	pushl  -0xc(%ebp)
  800d62:	ff 75 f0             	pushl  -0x10(%ebp)
  800d65:	e8 0e 15 00 00       	call   802278 <__udivdi3>
  800d6a:	83 c4 10             	add    $0x10,%esp
  800d6d:	83 ec 04             	sub    $0x4,%esp
  800d70:	ff 75 20             	pushl  0x20(%ebp)
  800d73:	53                   	push   %ebx
  800d74:	ff 75 18             	pushl  0x18(%ebp)
  800d77:	52                   	push   %edx
  800d78:	50                   	push   %eax
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	ff 75 08             	pushl  0x8(%ebp)
  800d7f:	e8 a1 ff ff ff       	call   800d25 <printnum>
  800d84:	83 c4 20             	add    $0x20,%esp
  800d87:	eb 1a                	jmp    800da3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d89:	83 ec 08             	sub    $0x8,%esp
  800d8c:	ff 75 0c             	pushl  0xc(%ebp)
  800d8f:	ff 75 20             	pushl  0x20(%ebp)
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	ff d0                	call   *%eax
  800d97:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d9a:	ff 4d 1c             	decl   0x1c(%ebp)
  800d9d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800da1:	7f e6                	jg     800d89 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800da3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800da6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800dab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db1:	53                   	push   %ebx
  800db2:	51                   	push   %ecx
  800db3:	52                   	push   %edx
  800db4:	50                   	push   %eax
  800db5:	e8 ce 15 00 00       	call   802388 <__umoddi3>
  800dba:	83 c4 10             	add    $0x10,%esp
  800dbd:	05 74 2d 80 00       	add    $0x802d74,%eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	0f be c0             	movsbl %al,%eax
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	50                   	push   %eax
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	ff d0                	call   *%eax
  800dd3:	83 c4 10             	add    $0x10,%esp
}
  800dd6:	90                   	nop
  800dd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ddf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800de3:	7e 1c                	jle    800e01 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	8b 00                	mov    (%eax),%eax
  800dea:	8d 50 08             	lea    0x8(%eax),%edx
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	89 10                	mov    %edx,(%eax)
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	8b 00                	mov    (%eax),%eax
  800df7:	83 e8 08             	sub    $0x8,%eax
  800dfa:	8b 50 04             	mov    0x4(%eax),%edx
  800dfd:	8b 00                	mov    (%eax),%eax
  800dff:	eb 40                	jmp    800e41 <getuint+0x65>
	else if (lflag)
  800e01:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e05:	74 1e                	je     800e25 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8b 00                	mov    (%eax),%eax
  800e0c:	8d 50 04             	lea    0x4(%eax),%edx
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	89 10                	mov    %edx,(%eax)
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	8b 00                	mov    (%eax),%eax
  800e19:	83 e8 04             	sub    $0x4,%eax
  800e1c:	8b 00                	mov    (%eax),%eax
  800e1e:	ba 00 00 00 00       	mov    $0x0,%edx
  800e23:	eb 1c                	jmp    800e41 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8b 00                	mov    (%eax),%eax
  800e2a:	8d 50 04             	lea    0x4(%eax),%edx
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	89 10                	mov    %edx,(%eax)
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	83 e8 04             	sub    $0x4,%eax
  800e3a:	8b 00                	mov    (%eax),%eax
  800e3c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e41:	5d                   	pop    %ebp
  800e42:	c3                   	ret    

00800e43 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e43:	55                   	push   %ebp
  800e44:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e46:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e4a:	7e 1c                	jle    800e68 <getint+0x25>
		return va_arg(*ap, long long);
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	8b 00                	mov    (%eax),%eax
  800e51:	8d 50 08             	lea    0x8(%eax),%edx
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	89 10                	mov    %edx,(%eax)
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	8b 00                	mov    (%eax),%eax
  800e5e:	83 e8 08             	sub    $0x8,%eax
  800e61:	8b 50 04             	mov    0x4(%eax),%edx
  800e64:	8b 00                	mov    (%eax),%eax
  800e66:	eb 38                	jmp    800ea0 <getint+0x5d>
	else if (lflag)
  800e68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e6c:	74 1a                	je     800e88 <getint+0x45>
		return va_arg(*ap, long);
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8b 00                	mov    (%eax),%eax
  800e73:	8d 50 04             	lea    0x4(%eax),%edx
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	89 10                	mov    %edx,(%eax)
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	8b 00                	mov    (%eax),%eax
  800e80:	83 e8 04             	sub    $0x4,%eax
  800e83:	8b 00                	mov    (%eax),%eax
  800e85:	99                   	cltd   
  800e86:	eb 18                	jmp    800ea0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8b 00                	mov    (%eax),%eax
  800e8d:	8d 50 04             	lea    0x4(%eax),%edx
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	89 10                	mov    %edx,(%eax)
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	8b 00                	mov    (%eax),%eax
  800e9a:	83 e8 04             	sub    $0x4,%eax
  800e9d:	8b 00                	mov    (%eax),%eax
  800e9f:	99                   	cltd   
}
  800ea0:	5d                   	pop    %ebp
  800ea1:	c3                   	ret    

00800ea2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ea2:	55                   	push   %ebp
  800ea3:	89 e5                	mov    %esp,%ebp
  800ea5:	56                   	push   %esi
  800ea6:	53                   	push   %ebx
  800ea7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eaa:	eb 17                	jmp    800ec3 <vprintfmt+0x21>
			if (ch == '\0')
  800eac:	85 db                	test   %ebx,%ebx
  800eae:	0f 84 af 03 00 00    	je     801263 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800eb4:	83 ec 08             	sub    $0x8,%esp
  800eb7:	ff 75 0c             	pushl  0xc(%ebp)
  800eba:	53                   	push   %ebx
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	ff d0                	call   *%eax
  800ec0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	8d 50 01             	lea    0x1(%eax),%edx
  800ec9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	0f b6 d8             	movzbl %al,%ebx
  800ed1:	83 fb 25             	cmp    $0x25,%ebx
  800ed4:	75 d6                	jne    800eac <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ed6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800eda:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ee1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ee8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800eef:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ef6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef9:	8d 50 01             	lea    0x1(%eax),%edx
  800efc:	89 55 10             	mov    %edx,0x10(%ebp)
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	0f b6 d8             	movzbl %al,%ebx
  800f04:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800f07:	83 f8 55             	cmp    $0x55,%eax
  800f0a:	0f 87 2b 03 00 00    	ja     80123b <vprintfmt+0x399>
  800f10:	8b 04 85 98 2d 80 00 	mov    0x802d98(,%eax,4),%eax
  800f17:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f19:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f1d:	eb d7                	jmp    800ef6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f1f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f23:	eb d1                	jmp    800ef6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f25:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f2c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f2f:	89 d0                	mov    %edx,%eax
  800f31:	c1 e0 02             	shl    $0x2,%eax
  800f34:	01 d0                	add    %edx,%eax
  800f36:	01 c0                	add    %eax,%eax
  800f38:	01 d8                	add    %ebx,%eax
  800f3a:	83 e8 30             	sub    $0x30,%eax
  800f3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f40:	8b 45 10             	mov    0x10(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f48:	83 fb 2f             	cmp    $0x2f,%ebx
  800f4b:	7e 3e                	jle    800f8b <vprintfmt+0xe9>
  800f4d:	83 fb 39             	cmp    $0x39,%ebx
  800f50:	7f 39                	jg     800f8b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f52:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f55:	eb d5                	jmp    800f2c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f57:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5a:	83 c0 04             	add    $0x4,%eax
  800f5d:	89 45 14             	mov    %eax,0x14(%ebp)
  800f60:	8b 45 14             	mov    0x14(%ebp),%eax
  800f63:	83 e8 04             	sub    $0x4,%eax
  800f66:	8b 00                	mov    (%eax),%eax
  800f68:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f6b:	eb 1f                	jmp    800f8c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f71:	79 83                	jns    800ef6 <vprintfmt+0x54>
				width = 0;
  800f73:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f7a:	e9 77 ff ff ff       	jmp    800ef6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f7f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f86:	e9 6b ff ff ff       	jmp    800ef6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f8b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f90:	0f 89 60 ff ff ff    	jns    800ef6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f96:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f9c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800fa3:	e9 4e ff ff ff       	jmp    800ef6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800fa8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800fab:	e9 46 ff ff ff       	jmp    800ef6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb3:	83 c0 04             	add    $0x4,%eax
  800fb6:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbc:	83 e8 04             	sub    $0x4,%eax
  800fbf:	8b 00                	mov    (%eax),%eax
  800fc1:	83 ec 08             	sub    $0x8,%esp
  800fc4:	ff 75 0c             	pushl  0xc(%ebp)
  800fc7:	50                   	push   %eax
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	ff d0                	call   *%eax
  800fcd:	83 c4 10             	add    $0x10,%esp
			break;
  800fd0:	e9 89 02 00 00       	jmp    80125e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd8:	83 c0 04             	add    $0x4,%eax
  800fdb:	89 45 14             	mov    %eax,0x14(%ebp)
  800fde:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe1:	83 e8 04             	sub    $0x4,%eax
  800fe4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fe6:	85 db                	test   %ebx,%ebx
  800fe8:	79 02                	jns    800fec <vprintfmt+0x14a>
				err = -err;
  800fea:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fec:	83 fb 64             	cmp    $0x64,%ebx
  800fef:	7f 0b                	jg     800ffc <vprintfmt+0x15a>
  800ff1:	8b 34 9d e0 2b 80 00 	mov    0x802be0(,%ebx,4),%esi
  800ff8:	85 f6                	test   %esi,%esi
  800ffa:	75 19                	jne    801015 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ffc:	53                   	push   %ebx
  800ffd:	68 85 2d 80 00       	push   $0x802d85
  801002:	ff 75 0c             	pushl  0xc(%ebp)
  801005:	ff 75 08             	pushl  0x8(%ebp)
  801008:	e8 5e 02 00 00       	call   80126b <printfmt>
  80100d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801010:	e9 49 02 00 00       	jmp    80125e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801015:	56                   	push   %esi
  801016:	68 8e 2d 80 00       	push   $0x802d8e
  80101b:	ff 75 0c             	pushl  0xc(%ebp)
  80101e:	ff 75 08             	pushl  0x8(%ebp)
  801021:	e8 45 02 00 00       	call   80126b <printfmt>
  801026:	83 c4 10             	add    $0x10,%esp
			break;
  801029:	e9 30 02 00 00       	jmp    80125e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80102e:	8b 45 14             	mov    0x14(%ebp),%eax
  801031:	83 c0 04             	add    $0x4,%eax
  801034:	89 45 14             	mov    %eax,0x14(%ebp)
  801037:	8b 45 14             	mov    0x14(%ebp),%eax
  80103a:	83 e8 04             	sub    $0x4,%eax
  80103d:	8b 30                	mov    (%eax),%esi
  80103f:	85 f6                	test   %esi,%esi
  801041:	75 05                	jne    801048 <vprintfmt+0x1a6>
				p = "(null)";
  801043:	be 91 2d 80 00       	mov    $0x802d91,%esi
			if (width > 0 && padc != '-')
  801048:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80104c:	7e 6d                	jle    8010bb <vprintfmt+0x219>
  80104e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801052:	74 67                	je     8010bb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801054:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801057:	83 ec 08             	sub    $0x8,%esp
  80105a:	50                   	push   %eax
  80105b:	56                   	push   %esi
  80105c:	e8 0c 03 00 00       	call   80136d <strnlen>
  801061:	83 c4 10             	add    $0x10,%esp
  801064:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801067:	eb 16                	jmp    80107f <vprintfmt+0x1dd>
					putch(padc, putdat);
  801069:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	ff 75 0c             	pushl  0xc(%ebp)
  801073:	50                   	push   %eax
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80107c:	ff 4d e4             	decl   -0x1c(%ebp)
  80107f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801083:	7f e4                	jg     801069 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801085:	eb 34                	jmp    8010bb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801087:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80108b:	74 1c                	je     8010a9 <vprintfmt+0x207>
  80108d:	83 fb 1f             	cmp    $0x1f,%ebx
  801090:	7e 05                	jle    801097 <vprintfmt+0x1f5>
  801092:	83 fb 7e             	cmp    $0x7e,%ebx
  801095:	7e 12                	jle    8010a9 <vprintfmt+0x207>
					putch('?', putdat);
  801097:	83 ec 08             	sub    $0x8,%esp
  80109a:	ff 75 0c             	pushl  0xc(%ebp)
  80109d:	6a 3f                	push   $0x3f
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	ff d0                	call   *%eax
  8010a4:	83 c4 10             	add    $0x10,%esp
  8010a7:	eb 0f                	jmp    8010b8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8010a9:	83 ec 08             	sub    $0x8,%esp
  8010ac:	ff 75 0c             	pushl  0xc(%ebp)
  8010af:	53                   	push   %ebx
  8010b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b3:	ff d0                	call   *%eax
  8010b5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010b8:	ff 4d e4             	decl   -0x1c(%ebp)
  8010bb:	89 f0                	mov    %esi,%eax
  8010bd:	8d 70 01             	lea    0x1(%eax),%esi
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	0f be d8             	movsbl %al,%ebx
  8010c5:	85 db                	test   %ebx,%ebx
  8010c7:	74 24                	je     8010ed <vprintfmt+0x24b>
  8010c9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010cd:	78 b8                	js     801087 <vprintfmt+0x1e5>
  8010cf:	ff 4d e0             	decl   -0x20(%ebp)
  8010d2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010d6:	79 af                	jns    801087 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010d8:	eb 13                	jmp    8010ed <vprintfmt+0x24b>
				putch(' ', putdat);
  8010da:	83 ec 08             	sub    $0x8,%esp
  8010dd:	ff 75 0c             	pushl  0xc(%ebp)
  8010e0:	6a 20                	push   $0x20
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	ff d0                	call   *%eax
  8010e7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010ea:	ff 4d e4             	decl   -0x1c(%ebp)
  8010ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010f1:	7f e7                	jg     8010da <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010f3:	e9 66 01 00 00       	jmp    80125e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010f8:	83 ec 08             	sub    $0x8,%esp
  8010fb:	ff 75 e8             	pushl  -0x18(%ebp)
  8010fe:	8d 45 14             	lea    0x14(%ebp),%eax
  801101:	50                   	push   %eax
  801102:	e8 3c fd ff ff       	call   800e43 <getint>
  801107:	83 c4 10             	add    $0x10,%esp
  80110a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80110d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801110:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801113:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801116:	85 d2                	test   %edx,%edx
  801118:	79 23                	jns    80113d <vprintfmt+0x29b>
				putch('-', putdat);
  80111a:	83 ec 08             	sub    $0x8,%esp
  80111d:	ff 75 0c             	pushl  0xc(%ebp)
  801120:	6a 2d                	push   $0x2d
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	ff d0                	call   *%eax
  801127:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80112a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80112d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801130:	f7 d8                	neg    %eax
  801132:	83 d2 00             	adc    $0x0,%edx
  801135:	f7 da                	neg    %edx
  801137:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80113a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80113d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801144:	e9 bc 00 00 00       	jmp    801205 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801149:	83 ec 08             	sub    $0x8,%esp
  80114c:	ff 75 e8             	pushl  -0x18(%ebp)
  80114f:	8d 45 14             	lea    0x14(%ebp),%eax
  801152:	50                   	push   %eax
  801153:	e8 84 fc ff ff       	call   800ddc <getuint>
  801158:	83 c4 10             	add    $0x10,%esp
  80115b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80115e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801161:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801168:	e9 98 00 00 00       	jmp    801205 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80116d:	83 ec 08             	sub    $0x8,%esp
  801170:	ff 75 0c             	pushl  0xc(%ebp)
  801173:	6a 58                	push   $0x58
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	ff d0                	call   *%eax
  80117a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80117d:	83 ec 08             	sub    $0x8,%esp
  801180:	ff 75 0c             	pushl  0xc(%ebp)
  801183:	6a 58                	push   $0x58
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	ff d0                	call   *%eax
  80118a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80118d:	83 ec 08             	sub    $0x8,%esp
  801190:	ff 75 0c             	pushl  0xc(%ebp)
  801193:	6a 58                	push   $0x58
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	ff d0                	call   *%eax
  80119a:	83 c4 10             	add    $0x10,%esp
			break;
  80119d:	e9 bc 00 00 00       	jmp    80125e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8011a2:	83 ec 08             	sub    $0x8,%esp
  8011a5:	ff 75 0c             	pushl  0xc(%ebp)
  8011a8:	6a 30                	push   $0x30
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	ff d0                	call   *%eax
  8011af:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011b2:	83 ec 08             	sub    $0x8,%esp
  8011b5:	ff 75 0c             	pushl  0xc(%ebp)
  8011b8:	6a 78                	push   $0x78
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	ff d0                	call   *%eax
  8011bf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c5:	83 c0 04             	add    $0x4,%eax
  8011c8:	89 45 14             	mov    %eax,0x14(%ebp)
  8011cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ce:	83 e8 04             	sub    $0x4,%eax
  8011d1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011dd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011e4:	eb 1f                	jmp    801205 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011e6:	83 ec 08             	sub    $0x8,%esp
  8011e9:	ff 75 e8             	pushl  -0x18(%ebp)
  8011ec:	8d 45 14             	lea    0x14(%ebp),%eax
  8011ef:	50                   	push   %eax
  8011f0:	e8 e7 fb ff ff       	call   800ddc <getuint>
  8011f5:	83 c4 10             	add    $0x10,%esp
  8011f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011fe:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801205:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801209:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80120c:	83 ec 04             	sub    $0x4,%esp
  80120f:	52                   	push   %edx
  801210:	ff 75 e4             	pushl  -0x1c(%ebp)
  801213:	50                   	push   %eax
  801214:	ff 75 f4             	pushl  -0xc(%ebp)
  801217:	ff 75 f0             	pushl  -0x10(%ebp)
  80121a:	ff 75 0c             	pushl  0xc(%ebp)
  80121d:	ff 75 08             	pushl  0x8(%ebp)
  801220:	e8 00 fb ff ff       	call   800d25 <printnum>
  801225:	83 c4 20             	add    $0x20,%esp
			break;
  801228:	eb 34                	jmp    80125e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80122a:	83 ec 08             	sub    $0x8,%esp
  80122d:	ff 75 0c             	pushl  0xc(%ebp)
  801230:	53                   	push   %ebx
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	ff d0                	call   *%eax
  801236:	83 c4 10             	add    $0x10,%esp
			break;
  801239:	eb 23                	jmp    80125e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80123b:	83 ec 08             	sub    $0x8,%esp
  80123e:	ff 75 0c             	pushl  0xc(%ebp)
  801241:	6a 25                	push   $0x25
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	ff d0                	call   *%eax
  801248:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80124b:	ff 4d 10             	decl   0x10(%ebp)
  80124e:	eb 03                	jmp    801253 <vprintfmt+0x3b1>
  801250:	ff 4d 10             	decl   0x10(%ebp)
  801253:	8b 45 10             	mov    0x10(%ebp),%eax
  801256:	48                   	dec    %eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	3c 25                	cmp    $0x25,%al
  80125b:	75 f3                	jne    801250 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80125d:	90                   	nop
		}
	}
  80125e:	e9 47 fc ff ff       	jmp    800eaa <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801263:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801264:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801267:	5b                   	pop    %ebx
  801268:	5e                   	pop    %esi
  801269:	5d                   	pop    %ebp
  80126a:	c3                   	ret    

0080126b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
  80126e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801271:	8d 45 10             	lea    0x10(%ebp),%eax
  801274:	83 c0 04             	add    $0x4,%eax
  801277:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80127a:	8b 45 10             	mov    0x10(%ebp),%eax
  80127d:	ff 75 f4             	pushl  -0xc(%ebp)
  801280:	50                   	push   %eax
  801281:	ff 75 0c             	pushl  0xc(%ebp)
  801284:	ff 75 08             	pushl  0x8(%ebp)
  801287:	e8 16 fc ff ff       	call   800ea2 <vprintfmt>
  80128c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80128f:	90                   	nop
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	8b 40 08             	mov    0x8(%eax),%eax
  80129b:	8d 50 01             	lea    0x1(%eax),%edx
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8012a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a7:	8b 10                	mov    (%eax),%edx
  8012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ac:	8b 40 04             	mov    0x4(%eax),%eax
  8012af:	39 c2                	cmp    %eax,%edx
  8012b1:	73 12                	jae    8012c5 <sprintputch+0x33>
		*b->buf++ = ch;
  8012b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b6:	8b 00                	mov    (%eax),%eax
  8012b8:	8d 48 01             	lea    0x1(%eax),%ecx
  8012bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012be:	89 0a                	mov    %ecx,(%edx)
  8012c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c3:	88 10                	mov    %dl,(%eax)
}
  8012c5:	90                   	nop
  8012c6:	5d                   	pop    %ebp
  8012c7:	c3                   	ret    

008012c8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
  8012cb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	01 d0                	add    %edx,%eax
  8012df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012ed:	74 06                	je     8012f5 <vsnprintf+0x2d>
  8012ef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012f3:	7f 07                	jg     8012fc <vsnprintf+0x34>
		return -E_INVAL;
  8012f5:	b8 03 00 00 00       	mov    $0x3,%eax
  8012fa:	eb 20                	jmp    80131c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012fc:	ff 75 14             	pushl  0x14(%ebp)
  8012ff:	ff 75 10             	pushl  0x10(%ebp)
  801302:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801305:	50                   	push   %eax
  801306:	68 92 12 80 00       	push   $0x801292
  80130b:	e8 92 fb ff ff       	call   800ea2 <vprintfmt>
  801310:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801313:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801316:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801319:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
  801321:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801324:	8d 45 10             	lea    0x10(%ebp),%eax
  801327:	83 c0 04             	add    $0x4,%eax
  80132a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80132d:	8b 45 10             	mov    0x10(%ebp),%eax
  801330:	ff 75 f4             	pushl  -0xc(%ebp)
  801333:	50                   	push   %eax
  801334:	ff 75 0c             	pushl  0xc(%ebp)
  801337:	ff 75 08             	pushl  0x8(%ebp)
  80133a:	e8 89 ff ff ff       	call   8012c8 <vsnprintf>
  80133f:	83 c4 10             	add    $0x10,%esp
  801342:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801345:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
  80134d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801350:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801357:	eb 06                	jmp    80135f <strlen+0x15>
		n++;
  801359:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80135c:	ff 45 08             	incl   0x8(%ebp)
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	84 c0                	test   %al,%al
  801366:	75 f1                	jne    801359 <strlen+0xf>
		n++;
	return n;
  801368:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80136b:	c9                   	leave  
  80136c:	c3                   	ret    

0080136d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80136d:	55                   	push   %ebp
  80136e:	89 e5                	mov    %esp,%ebp
  801370:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801373:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80137a:	eb 09                	jmp    801385 <strnlen+0x18>
		n++;
  80137c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80137f:	ff 45 08             	incl   0x8(%ebp)
  801382:	ff 4d 0c             	decl   0xc(%ebp)
  801385:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801389:	74 09                	je     801394 <strnlen+0x27>
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8a 00                	mov    (%eax),%al
  801390:	84 c0                	test   %al,%al
  801392:	75 e8                	jne    80137c <strnlen+0xf>
		n++;
	return n;
  801394:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801397:	c9                   	leave  
  801398:	c3                   	ret    

00801399 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801399:	55                   	push   %ebp
  80139a:	89 e5                	mov    %esp,%ebp
  80139c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8013a5:	90                   	nop
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8d 50 01             	lea    0x1(%eax),%edx
  8013ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8013af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013b8:	8a 12                	mov    (%edx),%dl
  8013ba:	88 10                	mov    %dl,(%eax)
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	84 c0                	test   %al,%al
  8013c0:	75 e4                	jne    8013a6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
  8013ca:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013da:	eb 1f                	jmp    8013fb <strncpy+0x34>
		*dst++ = *src;
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	8d 50 01             	lea    0x1(%eax),%edx
  8013e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e8:	8a 12                	mov    (%edx),%dl
  8013ea:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	84 c0                	test   %al,%al
  8013f3:	74 03                	je     8013f8 <strncpy+0x31>
			src++;
  8013f5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013f8:	ff 45 fc             	incl   -0x4(%ebp)
  8013fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013fe:	3b 45 10             	cmp    0x10(%ebp),%eax
  801401:	72 d9                	jb     8013dc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801403:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801406:	c9                   	leave  
  801407:	c3                   	ret    

00801408 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801408:	55                   	push   %ebp
  801409:	89 e5                	mov    %esp,%ebp
  80140b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801414:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801418:	74 30                	je     80144a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80141a:	eb 16                	jmp    801432 <strlcpy+0x2a>
			*dst++ = *src++;
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8d 50 01             	lea    0x1(%eax),%edx
  801422:	89 55 08             	mov    %edx,0x8(%ebp)
  801425:	8b 55 0c             	mov    0xc(%ebp),%edx
  801428:	8d 4a 01             	lea    0x1(%edx),%ecx
  80142b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80142e:	8a 12                	mov    (%edx),%dl
  801430:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801432:	ff 4d 10             	decl   0x10(%ebp)
  801435:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801439:	74 09                	je     801444 <strlcpy+0x3c>
  80143b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143e:	8a 00                	mov    (%eax),%al
  801440:	84 c0                	test   %al,%al
  801442:	75 d8                	jne    80141c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80144a:	8b 55 08             	mov    0x8(%ebp),%edx
  80144d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801450:	29 c2                	sub    %eax,%edx
  801452:	89 d0                	mov    %edx,%eax
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801459:	eb 06                	jmp    801461 <strcmp+0xb>
		p++, q++;
  80145b:	ff 45 08             	incl   0x8(%ebp)
  80145e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	84 c0                	test   %al,%al
  801468:	74 0e                	je     801478 <strcmp+0x22>
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	8a 10                	mov    (%eax),%dl
  80146f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	38 c2                	cmp    %al,%dl
  801476:	74 e3                	je     80145b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	0f b6 d0             	movzbl %al,%edx
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	0f b6 c0             	movzbl %al,%eax
  801488:	29 c2                	sub    %eax,%edx
  80148a:	89 d0                	mov    %edx,%eax
}
  80148c:	5d                   	pop    %ebp
  80148d:	c3                   	ret    

0080148e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801491:	eb 09                	jmp    80149c <strncmp+0xe>
		n--, p++, q++;
  801493:	ff 4d 10             	decl   0x10(%ebp)
  801496:	ff 45 08             	incl   0x8(%ebp)
  801499:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80149c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014a0:	74 17                	je     8014b9 <strncmp+0x2b>
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	84 c0                	test   %al,%al
  8014a9:	74 0e                	je     8014b9 <strncmp+0x2b>
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 10                	mov    (%eax),%dl
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	38 c2                	cmp    %al,%dl
  8014b7:	74 da                	je     801493 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014bd:	75 07                	jne    8014c6 <strncmp+0x38>
		return 0;
  8014bf:	b8 00 00 00 00       	mov    $0x0,%eax
  8014c4:	eb 14                	jmp    8014da <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	8a 00                	mov    (%eax),%al
  8014cb:	0f b6 d0             	movzbl %al,%edx
  8014ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d1:	8a 00                	mov    (%eax),%al
  8014d3:	0f b6 c0             	movzbl %al,%eax
  8014d6:	29 c2                	sub    %eax,%edx
  8014d8:	89 d0                	mov    %edx,%eax
}
  8014da:	5d                   	pop    %ebp
  8014db:	c3                   	ret    

008014dc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
  8014df:	83 ec 04             	sub    $0x4,%esp
  8014e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014e8:	eb 12                	jmp    8014fc <strchr+0x20>
		if (*s == c)
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	8a 00                	mov    (%eax),%al
  8014ef:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014f2:	75 05                	jne    8014f9 <strchr+0x1d>
			return (char *) s;
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	eb 11                	jmp    80150a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014f9:	ff 45 08             	incl   0x8(%ebp)
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	8a 00                	mov    (%eax),%al
  801501:	84 c0                	test   %al,%al
  801503:	75 e5                	jne    8014ea <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801505:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
  80150f:	83 ec 04             	sub    $0x4,%esp
  801512:	8b 45 0c             	mov    0xc(%ebp),%eax
  801515:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801518:	eb 0d                	jmp    801527 <strfind+0x1b>
		if (*s == c)
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801522:	74 0e                	je     801532 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801524:	ff 45 08             	incl   0x8(%ebp)
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	8a 00                	mov    (%eax),%al
  80152c:	84 c0                	test   %al,%al
  80152e:	75 ea                	jne    80151a <strfind+0xe>
  801530:	eb 01                	jmp    801533 <strfind+0x27>
		if (*s == c)
			break;
  801532:	90                   	nop
	return (char *) s;
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
  80153b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801544:	8b 45 10             	mov    0x10(%ebp),%eax
  801547:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80154a:	eb 0e                	jmp    80155a <memset+0x22>
		*p++ = c;
  80154c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154f:	8d 50 01             	lea    0x1(%eax),%edx
  801552:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801555:	8b 55 0c             	mov    0xc(%ebp),%edx
  801558:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80155a:	ff 4d f8             	decl   -0x8(%ebp)
  80155d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801561:	79 e9                	jns    80154c <memset+0x14>
		*p++ = c;

	return v;
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
  80156b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80156e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801571:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80157a:	eb 16                	jmp    801592 <memcpy+0x2a>
		*d++ = *s++;
  80157c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157f:	8d 50 01             	lea    0x1(%eax),%edx
  801582:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801585:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801588:	8d 4a 01             	lea    0x1(%edx),%ecx
  80158b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80158e:	8a 12                	mov    (%edx),%dl
  801590:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801592:	8b 45 10             	mov    0x10(%ebp),%eax
  801595:	8d 50 ff             	lea    -0x1(%eax),%edx
  801598:	89 55 10             	mov    %edx,0x10(%ebp)
  80159b:	85 c0                	test   %eax,%eax
  80159d:	75 dd                	jne    80157c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
  8015a7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8015aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015bc:	73 50                	jae    80160e <memmove+0x6a>
  8015be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c4:	01 d0                	add    %edx,%eax
  8015c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015c9:	76 43                	jbe    80160e <memmove+0x6a>
		s += n;
  8015cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ce:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015d7:	eb 10                	jmp    8015e9 <memmove+0x45>
			*--d = *--s;
  8015d9:	ff 4d f8             	decl   -0x8(%ebp)
  8015dc:	ff 4d fc             	decl   -0x4(%ebp)
  8015df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e2:	8a 10                	mov    (%eax),%dl
  8015e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8015f2:	85 c0                	test   %eax,%eax
  8015f4:	75 e3                	jne    8015d9 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015f6:	eb 23                	jmp    80161b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015fb:	8d 50 01             	lea    0x1(%eax),%edx
  8015fe:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801601:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801604:	8d 4a 01             	lea    0x1(%edx),%ecx
  801607:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80160a:	8a 12                	mov    (%edx),%dl
  80160c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80160e:	8b 45 10             	mov    0x10(%ebp),%eax
  801611:	8d 50 ff             	lea    -0x1(%eax),%edx
  801614:	89 55 10             	mov    %edx,0x10(%ebp)
  801617:	85 c0                	test   %eax,%eax
  801619:	75 dd                	jne    8015f8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
  801623:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80162c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801632:	eb 2a                	jmp    80165e <memcmp+0x3e>
		if (*s1 != *s2)
  801634:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801637:	8a 10                	mov    (%eax),%dl
  801639:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	38 c2                	cmp    %al,%dl
  801640:	74 16                	je     801658 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801642:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	0f b6 d0             	movzbl %al,%edx
  80164a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80164d:	8a 00                	mov    (%eax),%al
  80164f:	0f b6 c0             	movzbl %al,%eax
  801652:	29 c2                	sub    %eax,%edx
  801654:	89 d0                	mov    %edx,%eax
  801656:	eb 18                	jmp    801670 <memcmp+0x50>
		s1++, s2++;
  801658:	ff 45 fc             	incl   -0x4(%ebp)
  80165b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	8d 50 ff             	lea    -0x1(%eax),%edx
  801664:	89 55 10             	mov    %edx,0x10(%ebp)
  801667:	85 c0                	test   %eax,%eax
  801669:	75 c9                	jne    801634 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80166b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
  801675:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801678:	8b 55 08             	mov    0x8(%ebp),%edx
  80167b:	8b 45 10             	mov    0x10(%ebp),%eax
  80167e:	01 d0                	add    %edx,%eax
  801680:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801683:	eb 15                	jmp    80169a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	8a 00                	mov    (%eax),%al
  80168a:	0f b6 d0             	movzbl %al,%edx
  80168d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801690:	0f b6 c0             	movzbl %al,%eax
  801693:	39 c2                	cmp    %eax,%edx
  801695:	74 0d                	je     8016a4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801697:	ff 45 08             	incl   0x8(%ebp)
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
  80169d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016a0:	72 e3                	jb     801685 <memfind+0x13>
  8016a2:	eb 01                	jmp    8016a5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8016a4:	90                   	nop
	return (void *) s;
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016be:	eb 03                	jmp    8016c3 <strtol+0x19>
		s++;
  8016c0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 00                	mov    (%eax),%al
  8016c8:	3c 20                	cmp    $0x20,%al
  8016ca:	74 f4                	je     8016c0 <strtol+0x16>
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	8a 00                	mov    (%eax),%al
  8016d1:	3c 09                	cmp    $0x9,%al
  8016d3:	74 eb                	je     8016c0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	8a 00                	mov    (%eax),%al
  8016da:	3c 2b                	cmp    $0x2b,%al
  8016dc:	75 05                	jne    8016e3 <strtol+0x39>
		s++;
  8016de:	ff 45 08             	incl   0x8(%ebp)
  8016e1:	eb 13                	jmp    8016f6 <strtol+0x4c>
	else if (*s == '-')
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	3c 2d                	cmp    $0x2d,%al
  8016ea:	75 0a                	jne    8016f6 <strtol+0x4c>
		s++, neg = 1;
  8016ec:	ff 45 08             	incl   0x8(%ebp)
  8016ef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016fa:	74 06                	je     801702 <strtol+0x58>
  8016fc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801700:	75 20                	jne    801722 <strtol+0x78>
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	3c 30                	cmp    $0x30,%al
  801709:	75 17                	jne    801722 <strtol+0x78>
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	40                   	inc    %eax
  80170f:	8a 00                	mov    (%eax),%al
  801711:	3c 78                	cmp    $0x78,%al
  801713:	75 0d                	jne    801722 <strtol+0x78>
		s += 2, base = 16;
  801715:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801719:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801720:	eb 28                	jmp    80174a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801722:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801726:	75 15                	jne    80173d <strtol+0x93>
  801728:	8b 45 08             	mov    0x8(%ebp),%eax
  80172b:	8a 00                	mov    (%eax),%al
  80172d:	3c 30                	cmp    $0x30,%al
  80172f:	75 0c                	jne    80173d <strtol+0x93>
		s++, base = 8;
  801731:	ff 45 08             	incl   0x8(%ebp)
  801734:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80173b:	eb 0d                	jmp    80174a <strtol+0xa0>
	else if (base == 0)
  80173d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801741:	75 07                	jne    80174a <strtol+0xa0>
		base = 10;
  801743:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	8a 00                	mov    (%eax),%al
  80174f:	3c 2f                	cmp    $0x2f,%al
  801751:	7e 19                	jle    80176c <strtol+0xc2>
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	8a 00                	mov    (%eax),%al
  801758:	3c 39                	cmp    $0x39,%al
  80175a:	7f 10                	jg     80176c <strtol+0xc2>
			dig = *s - '0';
  80175c:	8b 45 08             	mov    0x8(%ebp),%eax
  80175f:	8a 00                	mov    (%eax),%al
  801761:	0f be c0             	movsbl %al,%eax
  801764:	83 e8 30             	sub    $0x30,%eax
  801767:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80176a:	eb 42                	jmp    8017ae <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80176c:	8b 45 08             	mov    0x8(%ebp),%eax
  80176f:	8a 00                	mov    (%eax),%al
  801771:	3c 60                	cmp    $0x60,%al
  801773:	7e 19                	jle    80178e <strtol+0xe4>
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	8a 00                	mov    (%eax),%al
  80177a:	3c 7a                	cmp    $0x7a,%al
  80177c:	7f 10                	jg     80178e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	8a 00                	mov    (%eax),%al
  801783:	0f be c0             	movsbl %al,%eax
  801786:	83 e8 57             	sub    $0x57,%eax
  801789:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80178c:	eb 20                	jmp    8017ae <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80178e:	8b 45 08             	mov    0x8(%ebp),%eax
  801791:	8a 00                	mov    (%eax),%al
  801793:	3c 40                	cmp    $0x40,%al
  801795:	7e 39                	jle    8017d0 <strtol+0x126>
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	8a 00                	mov    (%eax),%al
  80179c:	3c 5a                	cmp    $0x5a,%al
  80179e:	7f 30                	jg     8017d0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	8a 00                	mov    (%eax),%al
  8017a5:	0f be c0             	movsbl %al,%eax
  8017a8:	83 e8 37             	sub    $0x37,%eax
  8017ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017b4:	7d 19                	jge    8017cf <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017b6:	ff 45 08             	incl   0x8(%ebp)
  8017b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017bc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017c0:	89 c2                	mov    %eax,%edx
  8017c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017c5:	01 d0                	add    %edx,%eax
  8017c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017ca:	e9 7b ff ff ff       	jmp    80174a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017cf:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017d4:	74 08                	je     8017de <strtol+0x134>
		*endptr = (char *) s;
  8017d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8017dc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017de:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017e2:	74 07                	je     8017eb <strtol+0x141>
  8017e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e7:	f7 d8                	neg    %eax
  8017e9:	eb 03                	jmp    8017ee <strtol+0x144>
  8017eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <ltostr>:

void
ltostr(long value, char *str)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
  8017f3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801804:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801808:	79 13                	jns    80181d <ltostr+0x2d>
	{
		neg = 1;
  80180a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801811:	8b 45 0c             	mov    0xc(%ebp),%eax
  801814:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801817:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80181a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801825:	99                   	cltd   
  801826:	f7 f9                	idiv   %ecx
  801828:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80182b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80182e:	8d 50 01             	lea    0x1(%eax),%edx
  801831:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801834:	89 c2                	mov    %eax,%edx
  801836:	8b 45 0c             	mov    0xc(%ebp),%eax
  801839:	01 d0                	add    %edx,%eax
  80183b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80183e:	83 c2 30             	add    $0x30,%edx
  801841:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801843:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801846:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80184b:	f7 e9                	imul   %ecx
  80184d:	c1 fa 02             	sar    $0x2,%edx
  801850:	89 c8                	mov    %ecx,%eax
  801852:	c1 f8 1f             	sar    $0x1f,%eax
  801855:	29 c2                	sub    %eax,%edx
  801857:	89 d0                	mov    %edx,%eax
  801859:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80185c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80185f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801864:	f7 e9                	imul   %ecx
  801866:	c1 fa 02             	sar    $0x2,%edx
  801869:	89 c8                	mov    %ecx,%eax
  80186b:	c1 f8 1f             	sar    $0x1f,%eax
  80186e:	29 c2                	sub    %eax,%edx
  801870:	89 d0                	mov    %edx,%eax
  801872:	c1 e0 02             	shl    $0x2,%eax
  801875:	01 d0                	add    %edx,%eax
  801877:	01 c0                	add    %eax,%eax
  801879:	29 c1                	sub    %eax,%ecx
  80187b:	89 ca                	mov    %ecx,%edx
  80187d:	85 d2                	test   %edx,%edx
  80187f:	75 9c                	jne    80181d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801881:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801888:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188b:	48                   	dec    %eax
  80188c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80188f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801893:	74 3d                	je     8018d2 <ltostr+0xe2>
		start = 1 ;
  801895:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80189c:	eb 34                	jmp    8018d2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80189e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a4:	01 d0                	add    %edx,%eax
  8018a6:	8a 00                	mov    (%eax),%al
  8018a8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8018ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b1:	01 c2                	add    %eax,%edx
  8018b3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b9:	01 c8                	add    %ecx,%eax
  8018bb:	8a 00                	mov    (%eax),%al
  8018bd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018bf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c5:	01 c2                	add    %eax,%edx
  8018c7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018ca:	88 02                	mov    %al,(%edx)
		start++ ;
  8018cc:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018cf:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018d8:	7c c4                	jl     80189e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018da:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e0:	01 d0                	add    %edx,%eax
  8018e2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018e5:	90                   	nop
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
  8018eb:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018ee:	ff 75 08             	pushl  0x8(%ebp)
  8018f1:	e8 54 fa ff ff       	call   80134a <strlen>
  8018f6:	83 c4 04             	add    $0x4,%esp
  8018f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018fc:	ff 75 0c             	pushl  0xc(%ebp)
  8018ff:	e8 46 fa ff ff       	call   80134a <strlen>
  801904:	83 c4 04             	add    $0x4,%esp
  801907:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80190a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801911:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801918:	eb 17                	jmp    801931 <strcconcat+0x49>
		final[s] = str1[s] ;
  80191a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80191d:	8b 45 10             	mov    0x10(%ebp),%eax
  801920:	01 c2                	add    %eax,%edx
  801922:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	01 c8                	add    %ecx,%eax
  80192a:	8a 00                	mov    (%eax),%al
  80192c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80192e:	ff 45 fc             	incl   -0x4(%ebp)
  801931:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801934:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801937:	7c e1                	jl     80191a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801939:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801940:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801947:	eb 1f                	jmp    801968 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801949:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80194c:	8d 50 01             	lea    0x1(%eax),%edx
  80194f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801952:	89 c2                	mov    %eax,%edx
  801954:	8b 45 10             	mov    0x10(%ebp),%eax
  801957:	01 c2                	add    %eax,%edx
  801959:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80195c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195f:	01 c8                	add    %ecx,%eax
  801961:	8a 00                	mov    (%eax),%al
  801963:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801965:	ff 45 f8             	incl   -0x8(%ebp)
  801968:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80196b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80196e:	7c d9                	jl     801949 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801970:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801973:	8b 45 10             	mov    0x10(%ebp),%eax
  801976:	01 d0                	add    %edx,%eax
  801978:	c6 00 00             	movb   $0x0,(%eax)
}
  80197b:	90                   	nop
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801981:	8b 45 14             	mov    0x14(%ebp),%eax
  801984:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80198a:	8b 45 14             	mov    0x14(%ebp),%eax
  80198d:	8b 00                	mov    (%eax),%eax
  80198f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801996:	8b 45 10             	mov    0x10(%ebp),%eax
  801999:	01 d0                	add    %edx,%eax
  80199b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a1:	eb 0c                	jmp    8019af <strsplit+0x31>
			*string++ = 0;
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	8d 50 01             	lea    0x1(%eax),%edx
  8019a9:	89 55 08             	mov    %edx,0x8(%ebp)
  8019ac:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	8a 00                	mov    (%eax),%al
  8019b4:	84 c0                	test   %al,%al
  8019b6:	74 18                	je     8019d0 <strsplit+0x52>
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	8a 00                	mov    (%eax),%al
  8019bd:	0f be c0             	movsbl %al,%eax
  8019c0:	50                   	push   %eax
  8019c1:	ff 75 0c             	pushl  0xc(%ebp)
  8019c4:	e8 13 fb ff ff       	call   8014dc <strchr>
  8019c9:	83 c4 08             	add    $0x8,%esp
  8019cc:	85 c0                	test   %eax,%eax
  8019ce:	75 d3                	jne    8019a3 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	8a 00                	mov    (%eax),%al
  8019d5:	84 c0                	test   %al,%al
  8019d7:	74 5a                	je     801a33 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8019d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8019dc:	8b 00                	mov    (%eax),%eax
  8019de:	83 f8 0f             	cmp    $0xf,%eax
  8019e1:	75 07                	jne    8019ea <strsplit+0x6c>
		{
			return 0;
  8019e3:	b8 00 00 00 00       	mov    $0x0,%eax
  8019e8:	eb 66                	jmp    801a50 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ed:	8b 00                	mov    (%eax),%eax
  8019ef:	8d 48 01             	lea    0x1(%eax),%ecx
  8019f2:	8b 55 14             	mov    0x14(%ebp),%edx
  8019f5:	89 0a                	mov    %ecx,(%edx)
  8019f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801a01:	01 c2                	add    %eax,%edx
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a08:	eb 03                	jmp    801a0d <strsplit+0x8f>
			string++;
  801a0a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	8a 00                	mov    (%eax),%al
  801a12:	84 c0                	test   %al,%al
  801a14:	74 8b                	je     8019a1 <strsplit+0x23>
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	8a 00                	mov    (%eax),%al
  801a1b:	0f be c0             	movsbl %al,%eax
  801a1e:	50                   	push   %eax
  801a1f:	ff 75 0c             	pushl  0xc(%ebp)
  801a22:	e8 b5 fa ff ff       	call   8014dc <strchr>
  801a27:	83 c4 08             	add    $0x8,%esp
  801a2a:	85 c0                	test   %eax,%eax
  801a2c:	74 dc                	je     801a0a <strsplit+0x8c>
			string++;
	}
  801a2e:	e9 6e ff ff ff       	jmp    8019a1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a33:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a34:	8b 45 14             	mov    0x14(%ebp),%eax
  801a37:	8b 00                	mov    (%eax),%eax
  801a39:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a40:	8b 45 10             	mov    0x10(%ebp),%eax
  801a43:	01 d0                	add    %edx,%eax
  801a45:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a4b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801a58:	e8 9b 07 00 00       	call   8021f8 <sys_isUHeapPlacementStrategyNEXTFIT>
  801a5d:	85 c0                	test   %eax,%eax
  801a5f:	0f 84 64 01 00 00    	je     801bc9 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801a65:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801a6b:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801a72:	8b 55 08             	mov    0x8(%ebp),%edx
  801a75:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a78:	01 d0                	add    %edx,%eax
  801a7a:	48                   	dec    %eax
  801a7b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801a7e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a81:	ba 00 00 00 00       	mov    $0x0,%edx
  801a86:	f7 75 e8             	divl   -0x18(%ebp)
  801a89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a8c:	29 d0                	sub    %edx,%eax
  801a8e:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801a95:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9e:	01 d0                	add    %edx,%eax
  801aa0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801aa3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801aaa:	a1 28 30 80 00       	mov    0x803028,%eax
  801aaf:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801ab6:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801ab9:	0f 83 0a 01 00 00    	jae    801bc9 <malloc+0x177>
  801abf:	a1 28 30 80 00       	mov    0x803028,%eax
  801ac4:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801acb:	85 c0                	test   %eax,%eax
  801acd:	0f 84 f6 00 00 00    	je     801bc9 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801ad3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ada:	e9 dc 00 00 00       	jmp    801bbb <malloc+0x169>
				flag++;
  801adf:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae5:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801aec:	85 c0                	test   %eax,%eax
  801aee:	74 07                	je     801af7 <malloc+0xa5>
					flag=0;
  801af0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801af7:	a1 28 30 80 00       	mov    0x803028,%eax
  801afc:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b03:	85 c0                	test   %eax,%eax
  801b05:	79 05                	jns    801b0c <malloc+0xba>
  801b07:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b0c:	c1 f8 0c             	sar    $0xc,%eax
  801b0f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b12:	0f 85 a0 00 00 00    	jne    801bb8 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801b18:	a1 28 30 80 00       	mov    0x803028,%eax
  801b1d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b24:	85 c0                	test   %eax,%eax
  801b26:	79 05                	jns    801b2d <malloc+0xdb>
  801b28:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b2d:	c1 f8 0c             	sar    $0xc,%eax
  801b30:	89 c2                	mov    %eax,%edx
  801b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b35:	29 d0                	sub    %edx,%eax
  801b37:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801b3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b40:	eb 11                	jmp    801b53 <malloc+0x101>
						hFreeArr[j] = 1;
  801b42:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b45:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801b4c:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801b50:	ff 45 ec             	incl   -0x14(%ebp)
  801b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b59:	7e e7                	jle    801b42 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801b5b:	a1 28 30 80 00       	mov    0x803028,%eax
  801b60:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801b63:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801b69:	c1 e2 0c             	shl    $0xc,%edx
  801b6c:	89 15 04 30 80 00    	mov    %edx,0x803004
  801b72:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b78:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801b7f:	a1 28 30 80 00       	mov    0x803028,%eax
  801b84:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b8b:	89 c2                	mov    %eax,%edx
  801b8d:	a1 28 30 80 00       	mov    0x803028,%eax
  801b92:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801b99:	83 ec 08             	sub    $0x8,%esp
  801b9c:	52                   	push   %edx
  801b9d:	50                   	push   %eax
  801b9e:	e8 8b 02 00 00       	call   801e2e <sys_allocateMem>
  801ba3:	83 c4 10             	add    $0x10,%esp

					idx++;
  801ba6:	a1 28 30 80 00       	mov    0x803028,%eax
  801bab:	40                   	inc    %eax
  801bac:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801bb1:	a1 04 30 80 00       	mov    0x803004,%eax
  801bb6:	eb 16                	jmp    801bce <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801bb8:	ff 45 f0             	incl   -0x10(%ebp)
  801bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bbe:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bc3:	0f 86 16 ff ff ff    	jbe    801adf <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801bc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	83 ec 18             	sub    $0x18,%esp
  801bd6:	8b 45 10             	mov    0x10(%ebp),%eax
  801bd9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801bdc:	83 ec 04             	sub    $0x4,%esp
  801bdf:	68 f0 2e 80 00       	push   $0x802ef0
  801be4:	6a 59                	push   $0x59
  801be6:	68 0f 2f 80 00       	push   $0x802f0f
  801beb:	e8 24 ee ff ff       	call   800a14 <_panic>

00801bf0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
  801bf3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801bf6:	83 ec 04             	sub    $0x4,%esp
  801bf9:	68 1b 2f 80 00       	push   $0x802f1b
  801bfe:	6a 5f                	push   $0x5f
  801c00:	68 0f 2f 80 00       	push   $0x802f0f
  801c05:	e8 0a ee ff ff       	call   800a14 <_panic>

00801c0a <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801c10:	83 ec 04             	sub    $0x4,%esp
  801c13:	68 38 2f 80 00       	push   $0x802f38
  801c18:	6a 70                	push   $0x70
  801c1a:	68 0f 2f 80 00       	push   $0x802f0f
  801c1f:	e8 f0 ed ff ff       	call   800a14 <_panic>

00801c24 <sfree>:

}


void sfree(void* virtual_address)
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
  801c27:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801c2a:	83 ec 04             	sub    $0x4,%esp
  801c2d:	68 5b 2f 80 00       	push   $0x802f5b
  801c32:	6a 7b                	push   $0x7b
  801c34:	68 0f 2f 80 00       	push   $0x802f0f
  801c39:	e8 d6 ed ff ff       	call   800a14 <_panic>

00801c3e <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
  801c41:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c44:	83 ec 04             	sub    $0x4,%esp
  801c47:	68 78 2f 80 00       	push   $0x802f78
  801c4c:	68 93 00 00 00       	push   $0x93
  801c51:	68 0f 2f 80 00       	push   $0x802f0f
  801c56:	e8 b9 ed ff ff       	call   800a14 <_panic>

00801c5b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c5b:	55                   	push   %ebp
  801c5c:	89 e5                	mov    %esp,%ebp
  801c5e:	57                   	push   %edi
  801c5f:	56                   	push   %esi
  801c60:	53                   	push   %ebx
  801c61:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c64:	8b 45 08             	mov    0x8(%ebp),%eax
  801c67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c70:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c73:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c76:	cd 30                	int    $0x30
  801c78:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c7e:	83 c4 10             	add    $0x10,%esp
  801c81:	5b                   	pop    %ebx
  801c82:	5e                   	pop    %esi
  801c83:	5f                   	pop    %edi
  801c84:	5d                   	pop    %ebp
  801c85:	c3                   	ret    

00801c86 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c86:	55                   	push   %ebp
  801c87:	89 e5                	mov    %esp,%ebp
  801c89:	83 ec 04             	sub    $0x4,%esp
  801c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c92:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c96:	8b 45 08             	mov    0x8(%ebp),%eax
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	52                   	push   %edx
  801c9e:	ff 75 0c             	pushl  0xc(%ebp)
  801ca1:	50                   	push   %eax
  801ca2:	6a 00                	push   $0x0
  801ca4:	e8 b2 ff ff ff       	call   801c5b <syscall>
  801ca9:	83 c4 18             	add    $0x18,%esp
}
  801cac:	90                   	nop
  801cad:	c9                   	leave  
  801cae:	c3                   	ret    

00801caf <sys_cgetc>:

int
sys_cgetc(void)
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 01                	push   $0x1
  801cbe:	e8 98 ff ff ff       	call   801c5b <syscall>
  801cc3:	83 c4 18             	add    $0x18,%esp
}
  801cc6:	c9                   	leave  
  801cc7:	c3                   	ret    

00801cc8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	50                   	push   %eax
  801cd7:	6a 05                	push   $0x5
  801cd9:	e8 7d ff ff ff       	call   801c5b <syscall>
  801cde:	83 c4 18             	add    $0x18,%esp
}
  801ce1:	c9                   	leave  
  801ce2:	c3                   	ret    

00801ce3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 02                	push   $0x2
  801cf2:	e8 64 ff ff ff       	call   801c5b <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
}
  801cfa:	c9                   	leave  
  801cfb:	c3                   	ret    

00801cfc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 03                	push   $0x3
  801d0b:	e8 4b ff ff ff       	call   801c5b <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
}
  801d13:	c9                   	leave  
  801d14:	c3                   	ret    

00801d15 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d15:	55                   	push   %ebp
  801d16:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 04                	push   $0x4
  801d24:	e8 32 ff ff ff       	call   801c5b <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_env_exit>:


void sys_env_exit(void)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 06                	push   $0x6
  801d3d:	e8 19 ff ff ff       	call   801c5b <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
}
  801d45:	90                   	nop
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	52                   	push   %edx
  801d58:	50                   	push   %eax
  801d59:	6a 07                	push   $0x7
  801d5b:	e8 fb fe ff ff       	call   801c5b <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
  801d68:	56                   	push   %esi
  801d69:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d6a:	8b 75 18             	mov    0x18(%ebp),%esi
  801d6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d70:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	56                   	push   %esi
  801d7a:	53                   	push   %ebx
  801d7b:	51                   	push   %ecx
  801d7c:	52                   	push   %edx
  801d7d:	50                   	push   %eax
  801d7e:	6a 08                	push   $0x8
  801d80:	e8 d6 fe ff ff       	call   801c5b <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
}
  801d88:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d8b:	5b                   	pop    %ebx
  801d8c:	5e                   	pop    %esi
  801d8d:	5d                   	pop    %ebp
  801d8e:	c3                   	ret    

00801d8f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d8f:	55                   	push   %ebp
  801d90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d95:	8b 45 08             	mov    0x8(%ebp),%eax
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	52                   	push   %edx
  801d9f:	50                   	push   %eax
  801da0:	6a 09                	push   $0x9
  801da2:	e8 b4 fe ff ff       	call   801c5b <syscall>
  801da7:	83 c4 18             	add    $0x18,%esp
}
  801daa:	c9                   	leave  
  801dab:	c3                   	ret    

00801dac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801dac:	55                   	push   %ebp
  801dad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	ff 75 0c             	pushl  0xc(%ebp)
  801db8:	ff 75 08             	pushl  0x8(%ebp)
  801dbb:	6a 0a                	push   $0xa
  801dbd:	e8 99 fe ff ff       	call   801c5b <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 0b                	push   $0xb
  801dd6:	e8 80 fe ff ff       	call   801c5b <syscall>
  801ddb:	83 c4 18             	add    $0x18,%esp
}
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 0c                	push   $0xc
  801def:	e8 67 fe ff ff       	call   801c5b <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 0d                	push   $0xd
  801e08:	e8 4e fe ff ff       	call   801c5b <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	c9                   	leave  
  801e11:	c3                   	ret    

00801e12 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e12:	55                   	push   %ebp
  801e13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	ff 75 0c             	pushl  0xc(%ebp)
  801e1e:	ff 75 08             	pushl  0x8(%ebp)
  801e21:	6a 11                	push   $0x11
  801e23:	e8 33 fe ff ff       	call   801c5b <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
	return;
  801e2b:	90                   	nop
}
  801e2c:	c9                   	leave  
  801e2d:	c3                   	ret    

00801e2e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e2e:	55                   	push   %ebp
  801e2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	ff 75 0c             	pushl  0xc(%ebp)
  801e3a:	ff 75 08             	pushl  0x8(%ebp)
  801e3d:	6a 12                	push   $0x12
  801e3f:	e8 17 fe ff ff       	call   801c5b <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
	return ;
  801e47:	90                   	nop
}
  801e48:	c9                   	leave  
  801e49:	c3                   	ret    

00801e4a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e4a:	55                   	push   %ebp
  801e4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 0e                	push   $0xe
  801e59:	e8 fd fd ff ff       	call   801c5b <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	ff 75 08             	pushl  0x8(%ebp)
  801e71:	6a 0f                	push   $0xf
  801e73:	e8 e3 fd ff ff       	call   801c5b <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
}
  801e7b:	c9                   	leave  
  801e7c:	c3                   	ret    

00801e7d <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e7d:	55                   	push   %ebp
  801e7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 10                	push   $0x10
  801e8c:	e8 ca fd ff ff       	call   801c5b <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
}
  801e94:	90                   	nop
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 14                	push   $0x14
  801ea6:	e8 b0 fd ff ff       	call   801c5b <syscall>
  801eab:	83 c4 18             	add    $0x18,%esp
}
  801eae:	90                   	nop
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 15                	push   $0x15
  801ec0:	e8 96 fd ff ff       	call   801c5b <syscall>
  801ec5:	83 c4 18             	add    $0x18,%esp
}
  801ec8:	90                   	nop
  801ec9:	c9                   	leave  
  801eca:	c3                   	ret    

00801ecb <sys_cputc>:


void
sys_cputc(const char c)
{
  801ecb:	55                   	push   %ebp
  801ecc:	89 e5                	mov    %esp,%ebp
  801ece:	83 ec 04             	sub    $0x4,%esp
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ed7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	50                   	push   %eax
  801ee4:	6a 16                	push   $0x16
  801ee6:	e8 70 fd ff ff       	call   801c5b <syscall>
  801eeb:	83 c4 18             	add    $0x18,%esp
}
  801eee:	90                   	nop
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 17                	push   $0x17
  801f00:	e8 56 fd ff ff       	call   801c5b <syscall>
  801f05:	83 c4 18             	add    $0x18,%esp
}
  801f08:	90                   	nop
  801f09:	c9                   	leave  
  801f0a:	c3                   	ret    

00801f0b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f0b:	55                   	push   %ebp
  801f0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	ff 75 0c             	pushl  0xc(%ebp)
  801f1a:	50                   	push   %eax
  801f1b:	6a 18                	push   $0x18
  801f1d:	e8 39 fd ff ff       	call   801c5b <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	52                   	push   %edx
  801f37:	50                   	push   %eax
  801f38:	6a 1b                	push   $0x1b
  801f3a:	e8 1c fd ff ff       	call   801c5b <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	52                   	push   %edx
  801f54:	50                   	push   %eax
  801f55:	6a 19                	push   $0x19
  801f57:	e8 ff fc ff ff       	call   801c5b <syscall>
  801f5c:	83 c4 18             	add    $0x18,%esp
}
  801f5f:	90                   	nop
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f68:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	52                   	push   %edx
  801f72:	50                   	push   %eax
  801f73:	6a 1a                	push   $0x1a
  801f75:	e8 e1 fc ff ff       	call   801c5b <syscall>
  801f7a:	83 c4 18             	add    $0x18,%esp
}
  801f7d:	90                   	nop
  801f7e:	c9                   	leave  
  801f7f:	c3                   	ret    

00801f80 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f80:	55                   	push   %ebp
  801f81:	89 e5                	mov    %esp,%ebp
  801f83:	83 ec 04             	sub    $0x4,%esp
  801f86:	8b 45 10             	mov    0x10(%ebp),%eax
  801f89:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f8c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f8f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f93:	8b 45 08             	mov    0x8(%ebp),%eax
  801f96:	6a 00                	push   $0x0
  801f98:	51                   	push   %ecx
  801f99:	52                   	push   %edx
  801f9a:	ff 75 0c             	pushl  0xc(%ebp)
  801f9d:	50                   	push   %eax
  801f9e:	6a 1c                	push   $0x1c
  801fa0:	e8 b6 fc ff ff       	call   801c5b <syscall>
  801fa5:	83 c4 18             	add    $0x18,%esp
}
  801fa8:	c9                   	leave  
  801fa9:	c3                   	ret    

00801faa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801faa:	55                   	push   %ebp
  801fab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	52                   	push   %edx
  801fba:	50                   	push   %eax
  801fbb:	6a 1d                	push   $0x1d
  801fbd:	e8 99 fc ff ff       	call   801c5b <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
}
  801fc5:	c9                   	leave  
  801fc6:	c3                   	ret    

00801fc7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fc7:	55                   	push   %ebp
  801fc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	51                   	push   %ecx
  801fd8:	52                   	push   %edx
  801fd9:	50                   	push   %eax
  801fda:	6a 1e                	push   $0x1e
  801fdc:	e8 7a fc ff ff       	call   801c5b <syscall>
  801fe1:	83 c4 18             	add    $0x18,%esp
}
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fe9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fec:	8b 45 08             	mov    0x8(%ebp),%eax
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	52                   	push   %edx
  801ff6:	50                   	push   %eax
  801ff7:	6a 1f                	push   $0x1f
  801ff9:	e8 5d fc ff ff       	call   801c5b <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 20                	push   $0x20
  802012:	e8 44 fc ff ff       	call   801c5b <syscall>
  802017:	83 c4 18             	add    $0x18,%esp
}
  80201a:	c9                   	leave  
  80201b:	c3                   	ret    

0080201c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80201c:	55                   	push   %ebp
  80201d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	ff 75 10             	pushl  0x10(%ebp)
  802029:	ff 75 0c             	pushl  0xc(%ebp)
  80202c:	50                   	push   %eax
  80202d:	6a 21                	push   $0x21
  80202f:	e8 27 fc ff ff       	call   801c5b <syscall>
  802034:	83 c4 18             	add    $0x18,%esp
}
  802037:	c9                   	leave  
  802038:	c3                   	ret    

00802039 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802039:	55                   	push   %ebp
  80203a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80203c:	8b 45 08             	mov    0x8(%ebp),%eax
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	50                   	push   %eax
  802048:	6a 22                	push   $0x22
  80204a:	e8 0c fc ff ff       	call   801c5b <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	90                   	nop
  802053:	c9                   	leave  
  802054:	c3                   	ret    

00802055 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802055:	55                   	push   %ebp
  802056:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802058:	8b 45 08             	mov    0x8(%ebp),%eax
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	50                   	push   %eax
  802064:	6a 23                	push   $0x23
  802066:	e8 f0 fb ff ff       	call   801c5b <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
}
  80206e:	90                   	nop
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
  802074:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802077:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80207a:	8d 50 04             	lea    0x4(%eax),%edx
  80207d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	52                   	push   %edx
  802087:	50                   	push   %eax
  802088:	6a 24                	push   $0x24
  80208a:	e8 cc fb ff ff       	call   801c5b <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
	return result;
  802092:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802095:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802098:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80209b:	89 01                	mov    %eax,(%ecx)
  80209d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a3:	c9                   	leave  
  8020a4:	c2 04 00             	ret    $0x4

008020a7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	ff 75 10             	pushl  0x10(%ebp)
  8020b1:	ff 75 0c             	pushl  0xc(%ebp)
  8020b4:	ff 75 08             	pushl  0x8(%ebp)
  8020b7:	6a 13                	push   $0x13
  8020b9:	e8 9d fb ff ff       	call   801c5b <syscall>
  8020be:	83 c4 18             	add    $0x18,%esp
	return ;
  8020c1:	90                   	nop
}
  8020c2:	c9                   	leave  
  8020c3:	c3                   	ret    

008020c4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020c4:	55                   	push   %ebp
  8020c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 25                	push   $0x25
  8020d3:	e8 83 fb ff ff       	call   801c5b <syscall>
  8020d8:	83 c4 18             	add    $0x18,%esp
}
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
  8020e0:	83 ec 04             	sub    $0x4,%esp
  8020e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020e9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	50                   	push   %eax
  8020f6:	6a 26                	push   $0x26
  8020f8:	e8 5e fb ff ff       	call   801c5b <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802100:	90                   	nop
}
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <rsttst>:
void rsttst()
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 28                	push   $0x28
  802112:	e8 44 fb ff ff       	call   801c5b <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
	return ;
  80211a:	90                   	nop
}
  80211b:	c9                   	leave  
  80211c:	c3                   	ret    

0080211d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80211d:	55                   	push   %ebp
  80211e:	89 e5                	mov    %esp,%ebp
  802120:	83 ec 04             	sub    $0x4,%esp
  802123:	8b 45 14             	mov    0x14(%ebp),%eax
  802126:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802129:	8b 55 18             	mov    0x18(%ebp),%edx
  80212c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802130:	52                   	push   %edx
  802131:	50                   	push   %eax
  802132:	ff 75 10             	pushl  0x10(%ebp)
  802135:	ff 75 0c             	pushl  0xc(%ebp)
  802138:	ff 75 08             	pushl  0x8(%ebp)
  80213b:	6a 27                	push   $0x27
  80213d:	e8 19 fb ff ff       	call   801c5b <syscall>
  802142:	83 c4 18             	add    $0x18,%esp
	return ;
  802145:	90                   	nop
}
  802146:	c9                   	leave  
  802147:	c3                   	ret    

00802148 <chktst>:
void chktst(uint32 n)
{
  802148:	55                   	push   %ebp
  802149:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	ff 75 08             	pushl  0x8(%ebp)
  802156:	6a 29                	push   $0x29
  802158:	e8 fe fa ff ff       	call   801c5b <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
	return ;
  802160:	90                   	nop
}
  802161:	c9                   	leave  
  802162:	c3                   	ret    

00802163 <inctst>:

void inctst()
{
  802163:	55                   	push   %ebp
  802164:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 2a                	push   $0x2a
  802172:	e8 e4 fa ff ff       	call   801c5b <syscall>
  802177:	83 c4 18             	add    $0x18,%esp
	return ;
  80217a:	90                   	nop
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <gettst>:
uint32 gettst()
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 2b                	push   $0x2b
  80218c:	e8 ca fa ff ff       	call   801c5b <syscall>
  802191:	83 c4 18             	add    $0x18,%esp
}
  802194:	c9                   	leave  
  802195:	c3                   	ret    

00802196 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802196:	55                   	push   %ebp
  802197:	89 e5                	mov    %esp,%ebp
  802199:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 2c                	push   $0x2c
  8021a8:	e8 ae fa ff ff       	call   801c5b <syscall>
  8021ad:	83 c4 18             	add    $0x18,%esp
  8021b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021b3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021b7:	75 07                	jne    8021c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021be:	eb 05                	jmp    8021c5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c5:	c9                   	leave  
  8021c6:	c3                   	ret    

008021c7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021c7:	55                   	push   %ebp
  8021c8:	89 e5                	mov    %esp,%ebp
  8021ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	6a 2c                	push   $0x2c
  8021d9:	e8 7d fa ff ff       	call   801c5b <syscall>
  8021de:	83 c4 18             	add    $0x18,%esp
  8021e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021e4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021e8:	75 07                	jne    8021f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ef:	eb 05                	jmp    8021f6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021f6:	c9                   	leave  
  8021f7:	c3                   	ret    

008021f8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021f8:	55                   	push   %ebp
  8021f9:	89 e5                	mov    %esp,%ebp
  8021fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 2c                	push   $0x2c
  80220a:	e8 4c fa ff ff       	call   801c5b <syscall>
  80220f:	83 c4 18             	add    $0x18,%esp
  802212:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802215:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802219:	75 07                	jne    802222 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80221b:	b8 01 00 00 00       	mov    $0x1,%eax
  802220:	eb 05                	jmp    802227 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802222:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
  80222c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	6a 00                	push   $0x0
  802237:	6a 00                	push   $0x0
  802239:	6a 2c                	push   $0x2c
  80223b:	e8 1b fa ff ff       	call   801c5b <syscall>
  802240:	83 c4 18             	add    $0x18,%esp
  802243:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802246:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80224a:	75 07                	jne    802253 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80224c:	b8 01 00 00 00       	mov    $0x1,%eax
  802251:	eb 05                	jmp    802258 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802253:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802258:	c9                   	leave  
  802259:	c3                   	ret    

0080225a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80225a:	55                   	push   %ebp
  80225b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	ff 75 08             	pushl  0x8(%ebp)
  802268:	6a 2d                	push   $0x2d
  80226a:	e8 ec f9 ff ff       	call   801c5b <syscall>
  80226f:	83 c4 18             	add    $0x18,%esp
	return ;
  802272:	90                   	nop
}
  802273:	c9                   	leave  
  802274:	c3                   	ret    
  802275:	66 90                	xchg   %ax,%ax
  802277:	90                   	nop

00802278 <__udivdi3>:
  802278:	55                   	push   %ebp
  802279:	57                   	push   %edi
  80227a:	56                   	push   %esi
  80227b:	53                   	push   %ebx
  80227c:	83 ec 1c             	sub    $0x1c,%esp
  80227f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802283:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802287:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80228b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80228f:	89 ca                	mov    %ecx,%edx
  802291:	89 f8                	mov    %edi,%eax
  802293:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802297:	85 f6                	test   %esi,%esi
  802299:	75 2d                	jne    8022c8 <__udivdi3+0x50>
  80229b:	39 cf                	cmp    %ecx,%edi
  80229d:	77 65                	ja     802304 <__udivdi3+0x8c>
  80229f:	89 fd                	mov    %edi,%ebp
  8022a1:	85 ff                	test   %edi,%edi
  8022a3:	75 0b                	jne    8022b0 <__udivdi3+0x38>
  8022a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022aa:	31 d2                	xor    %edx,%edx
  8022ac:	f7 f7                	div    %edi
  8022ae:	89 c5                	mov    %eax,%ebp
  8022b0:	31 d2                	xor    %edx,%edx
  8022b2:	89 c8                	mov    %ecx,%eax
  8022b4:	f7 f5                	div    %ebp
  8022b6:	89 c1                	mov    %eax,%ecx
  8022b8:	89 d8                	mov    %ebx,%eax
  8022ba:	f7 f5                	div    %ebp
  8022bc:	89 cf                	mov    %ecx,%edi
  8022be:	89 fa                	mov    %edi,%edx
  8022c0:	83 c4 1c             	add    $0x1c,%esp
  8022c3:	5b                   	pop    %ebx
  8022c4:	5e                   	pop    %esi
  8022c5:	5f                   	pop    %edi
  8022c6:	5d                   	pop    %ebp
  8022c7:	c3                   	ret    
  8022c8:	39 ce                	cmp    %ecx,%esi
  8022ca:	77 28                	ja     8022f4 <__udivdi3+0x7c>
  8022cc:	0f bd fe             	bsr    %esi,%edi
  8022cf:	83 f7 1f             	xor    $0x1f,%edi
  8022d2:	75 40                	jne    802314 <__udivdi3+0x9c>
  8022d4:	39 ce                	cmp    %ecx,%esi
  8022d6:	72 0a                	jb     8022e2 <__udivdi3+0x6a>
  8022d8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022dc:	0f 87 9e 00 00 00    	ja     802380 <__udivdi3+0x108>
  8022e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e7:	89 fa                	mov    %edi,%edx
  8022e9:	83 c4 1c             	add    $0x1c,%esp
  8022ec:	5b                   	pop    %ebx
  8022ed:	5e                   	pop    %esi
  8022ee:	5f                   	pop    %edi
  8022ef:	5d                   	pop    %ebp
  8022f0:	c3                   	ret    
  8022f1:	8d 76 00             	lea    0x0(%esi),%esi
  8022f4:	31 ff                	xor    %edi,%edi
  8022f6:	31 c0                	xor    %eax,%eax
  8022f8:	89 fa                	mov    %edi,%edx
  8022fa:	83 c4 1c             	add    $0x1c,%esp
  8022fd:	5b                   	pop    %ebx
  8022fe:	5e                   	pop    %esi
  8022ff:	5f                   	pop    %edi
  802300:	5d                   	pop    %ebp
  802301:	c3                   	ret    
  802302:	66 90                	xchg   %ax,%ax
  802304:	89 d8                	mov    %ebx,%eax
  802306:	f7 f7                	div    %edi
  802308:	31 ff                	xor    %edi,%edi
  80230a:	89 fa                	mov    %edi,%edx
  80230c:	83 c4 1c             	add    $0x1c,%esp
  80230f:	5b                   	pop    %ebx
  802310:	5e                   	pop    %esi
  802311:	5f                   	pop    %edi
  802312:	5d                   	pop    %ebp
  802313:	c3                   	ret    
  802314:	bd 20 00 00 00       	mov    $0x20,%ebp
  802319:	89 eb                	mov    %ebp,%ebx
  80231b:	29 fb                	sub    %edi,%ebx
  80231d:	89 f9                	mov    %edi,%ecx
  80231f:	d3 e6                	shl    %cl,%esi
  802321:	89 c5                	mov    %eax,%ebp
  802323:	88 d9                	mov    %bl,%cl
  802325:	d3 ed                	shr    %cl,%ebp
  802327:	89 e9                	mov    %ebp,%ecx
  802329:	09 f1                	or     %esi,%ecx
  80232b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80232f:	89 f9                	mov    %edi,%ecx
  802331:	d3 e0                	shl    %cl,%eax
  802333:	89 c5                	mov    %eax,%ebp
  802335:	89 d6                	mov    %edx,%esi
  802337:	88 d9                	mov    %bl,%cl
  802339:	d3 ee                	shr    %cl,%esi
  80233b:	89 f9                	mov    %edi,%ecx
  80233d:	d3 e2                	shl    %cl,%edx
  80233f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802343:	88 d9                	mov    %bl,%cl
  802345:	d3 e8                	shr    %cl,%eax
  802347:	09 c2                	or     %eax,%edx
  802349:	89 d0                	mov    %edx,%eax
  80234b:	89 f2                	mov    %esi,%edx
  80234d:	f7 74 24 0c          	divl   0xc(%esp)
  802351:	89 d6                	mov    %edx,%esi
  802353:	89 c3                	mov    %eax,%ebx
  802355:	f7 e5                	mul    %ebp
  802357:	39 d6                	cmp    %edx,%esi
  802359:	72 19                	jb     802374 <__udivdi3+0xfc>
  80235b:	74 0b                	je     802368 <__udivdi3+0xf0>
  80235d:	89 d8                	mov    %ebx,%eax
  80235f:	31 ff                	xor    %edi,%edi
  802361:	e9 58 ff ff ff       	jmp    8022be <__udivdi3+0x46>
  802366:	66 90                	xchg   %ax,%ax
  802368:	8b 54 24 08          	mov    0x8(%esp),%edx
  80236c:	89 f9                	mov    %edi,%ecx
  80236e:	d3 e2                	shl    %cl,%edx
  802370:	39 c2                	cmp    %eax,%edx
  802372:	73 e9                	jae    80235d <__udivdi3+0xe5>
  802374:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802377:	31 ff                	xor    %edi,%edi
  802379:	e9 40 ff ff ff       	jmp    8022be <__udivdi3+0x46>
  80237e:	66 90                	xchg   %ax,%ax
  802380:	31 c0                	xor    %eax,%eax
  802382:	e9 37 ff ff ff       	jmp    8022be <__udivdi3+0x46>
  802387:	90                   	nop

00802388 <__umoddi3>:
  802388:	55                   	push   %ebp
  802389:	57                   	push   %edi
  80238a:	56                   	push   %esi
  80238b:	53                   	push   %ebx
  80238c:	83 ec 1c             	sub    $0x1c,%esp
  80238f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802393:	8b 74 24 34          	mov    0x34(%esp),%esi
  802397:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80239b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80239f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023a7:	89 f3                	mov    %esi,%ebx
  8023a9:	89 fa                	mov    %edi,%edx
  8023ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023af:	89 34 24             	mov    %esi,(%esp)
  8023b2:	85 c0                	test   %eax,%eax
  8023b4:	75 1a                	jne    8023d0 <__umoddi3+0x48>
  8023b6:	39 f7                	cmp    %esi,%edi
  8023b8:	0f 86 a2 00 00 00    	jbe    802460 <__umoddi3+0xd8>
  8023be:	89 c8                	mov    %ecx,%eax
  8023c0:	89 f2                	mov    %esi,%edx
  8023c2:	f7 f7                	div    %edi
  8023c4:	89 d0                	mov    %edx,%eax
  8023c6:	31 d2                	xor    %edx,%edx
  8023c8:	83 c4 1c             	add    $0x1c,%esp
  8023cb:	5b                   	pop    %ebx
  8023cc:	5e                   	pop    %esi
  8023cd:	5f                   	pop    %edi
  8023ce:	5d                   	pop    %ebp
  8023cf:	c3                   	ret    
  8023d0:	39 f0                	cmp    %esi,%eax
  8023d2:	0f 87 ac 00 00 00    	ja     802484 <__umoddi3+0xfc>
  8023d8:	0f bd e8             	bsr    %eax,%ebp
  8023db:	83 f5 1f             	xor    $0x1f,%ebp
  8023de:	0f 84 ac 00 00 00    	je     802490 <__umoddi3+0x108>
  8023e4:	bf 20 00 00 00       	mov    $0x20,%edi
  8023e9:	29 ef                	sub    %ebp,%edi
  8023eb:	89 fe                	mov    %edi,%esi
  8023ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023f1:	89 e9                	mov    %ebp,%ecx
  8023f3:	d3 e0                	shl    %cl,%eax
  8023f5:	89 d7                	mov    %edx,%edi
  8023f7:	89 f1                	mov    %esi,%ecx
  8023f9:	d3 ef                	shr    %cl,%edi
  8023fb:	09 c7                	or     %eax,%edi
  8023fd:	89 e9                	mov    %ebp,%ecx
  8023ff:	d3 e2                	shl    %cl,%edx
  802401:	89 14 24             	mov    %edx,(%esp)
  802404:	89 d8                	mov    %ebx,%eax
  802406:	d3 e0                	shl    %cl,%eax
  802408:	89 c2                	mov    %eax,%edx
  80240a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80240e:	d3 e0                	shl    %cl,%eax
  802410:	89 44 24 04          	mov    %eax,0x4(%esp)
  802414:	8b 44 24 08          	mov    0x8(%esp),%eax
  802418:	89 f1                	mov    %esi,%ecx
  80241a:	d3 e8                	shr    %cl,%eax
  80241c:	09 d0                	or     %edx,%eax
  80241e:	d3 eb                	shr    %cl,%ebx
  802420:	89 da                	mov    %ebx,%edx
  802422:	f7 f7                	div    %edi
  802424:	89 d3                	mov    %edx,%ebx
  802426:	f7 24 24             	mull   (%esp)
  802429:	89 c6                	mov    %eax,%esi
  80242b:	89 d1                	mov    %edx,%ecx
  80242d:	39 d3                	cmp    %edx,%ebx
  80242f:	0f 82 87 00 00 00    	jb     8024bc <__umoddi3+0x134>
  802435:	0f 84 91 00 00 00    	je     8024cc <__umoddi3+0x144>
  80243b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80243f:	29 f2                	sub    %esi,%edx
  802441:	19 cb                	sbb    %ecx,%ebx
  802443:	89 d8                	mov    %ebx,%eax
  802445:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802449:	d3 e0                	shl    %cl,%eax
  80244b:	89 e9                	mov    %ebp,%ecx
  80244d:	d3 ea                	shr    %cl,%edx
  80244f:	09 d0                	or     %edx,%eax
  802451:	89 e9                	mov    %ebp,%ecx
  802453:	d3 eb                	shr    %cl,%ebx
  802455:	89 da                	mov    %ebx,%edx
  802457:	83 c4 1c             	add    $0x1c,%esp
  80245a:	5b                   	pop    %ebx
  80245b:	5e                   	pop    %esi
  80245c:	5f                   	pop    %edi
  80245d:	5d                   	pop    %ebp
  80245e:	c3                   	ret    
  80245f:	90                   	nop
  802460:	89 fd                	mov    %edi,%ebp
  802462:	85 ff                	test   %edi,%edi
  802464:	75 0b                	jne    802471 <__umoddi3+0xe9>
  802466:	b8 01 00 00 00       	mov    $0x1,%eax
  80246b:	31 d2                	xor    %edx,%edx
  80246d:	f7 f7                	div    %edi
  80246f:	89 c5                	mov    %eax,%ebp
  802471:	89 f0                	mov    %esi,%eax
  802473:	31 d2                	xor    %edx,%edx
  802475:	f7 f5                	div    %ebp
  802477:	89 c8                	mov    %ecx,%eax
  802479:	f7 f5                	div    %ebp
  80247b:	89 d0                	mov    %edx,%eax
  80247d:	e9 44 ff ff ff       	jmp    8023c6 <__umoddi3+0x3e>
  802482:	66 90                	xchg   %ax,%ax
  802484:	89 c8                	mov    %ecx,%eax
  802486:	89 f2                	mov    %esi,%edx
  802488:	83 c4 1c             	add    $0x1c,%esp
  80248b:	5b                   	pop    %ebx
  80248c:	5e                   	pop    %esi
  80248d:	5f                   	pop    %edi
  80248e:	5d                   	pop    %ebp
  80248f:	c3                   	ret    
  802490:	3b 04 24             	cmp    (%esp),%eax
  802493:	72 06                	jb     80249b <__umoddi3+0x113>
  802495:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802499:	77 0f                	ja     8024aa <__umoddi3+0x122>
  80249b:	89 f2                	mov    %esi,%edx
  80249d:	29 f9                	sub    %edi,%ecx
  80249f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024a3:	89 14 24             	mov    %edx,(%esp)
  8024a6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024aa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024ae:	8b 14 24             	mov    (%esp),%edx
  8024b1:	83 c4 1c             	add    $0x1c,%esp
  8024b4:	5b                   	pop    %ebx
  8024b5:	5e                   	pop    %esi
  8024b6:	5f                   	pop    %edi
  8024b7:	5d                   	pop    %ebp
  8024b8:	c3                   	ret    
  8024b9:	8d 76 00             	lea    0x0(%esi),%esi
  8024bc:	2b 04 24             	sub    (%esp),%eax
  8024bf:	19 fa                	sbb    %edi,%edx
  8024c1:	89 d1                	mov    %edx,%ecx
  8024c3:	89 c6                	mov    %eax,%esi
  8024c5:	e9 71 ff ff ff       	jmp    80243b <__umoddi3+0xb3>
  8024ca:	66 90                	xchg   %ax,%ax
  8024cc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024d0:	72 ea                	jb     8024bc <__umoddi3+0x134>
  8024d2:	89 d9                	mov    %ebx,%ecx
  8024d4:	e9 62 ff ff ff       	jmp    80243b <__umoddi3+0xb3>
