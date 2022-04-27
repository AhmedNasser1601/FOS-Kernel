
obj/user/tst_buffer_1:     file format elf32-i386


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
  800031:	e8 7f 05 00 00       	call   8005b5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define arrSize PAGE_SIZE*8 / 4
int src[arrSize];
int dst[arrSize];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80004e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 80 1f 80 00       	push   $0x801f80
  800065:	6a 16                	push   $0x16
  800067:	68 c8 1f 80 00       	push   $0x801fc8
  80006c:	e8 53 06 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800084:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 80 1f 80 00       	push   $0x801f80
  80009b:	6a 17                	push   $0x17
  80009d:	68 c8 1f 80 00       	push   $0x801fc8
  8000a2:	e8 1d 06 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 80 1f 80 00       	push   $0x801f80
  8000d1:	6a 18                	push   $0x18
  8000d3:	68 c8 1f 80 00       	push   $0x801fc8
  8000d8:	e8 e7 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 80 1f 80 00       	push   $0x801f80
  800107:	6a 19                	push   $0x19
  800109:	68 c8 1f 80 00       	push   $0x801fc8
  80010e:	e8 b1 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800126:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 80 1f 80 00       	push   $0x801f80
  80013d:	6a 1a                	push   $0x1a
  80013f:	68 c8 1f 80 00       	push   $0x801fc8
  800144:	e8 7b 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 80 1f 80 00       	push   $0x801f80
  800173:	6a 1b                	push   $0x1b
  800175:	68 c8 1f 80 00       	push   $0x801fc8
  80017a:	e8 45 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800192:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 80 1f 80 00       	push   $0x801f80
  8001a9:	6a 1c                	push   $0x1c
  8001ab:	68 c8 1f 80 00       	push   $0x801fc8
  8001b0:	e8 0f 05 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001c8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 80 1f 80 00       	push   $0x801f80
  8001df:	6a 1d                	push   $0x1d
  8001e1:	68 c8 1f 80 00       	push   $0x801fc8
  8001e6:	e8 d9 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 80 1f 80 00       	push   $0x801f80
  800215:	6a 1e                	push   $0x1e
  800217:	68 c8 1f 80 00       	push   $0x801fc8
  80021c:	e8 a3 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800234:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 80 1f 80 00       	push   $0x801f80
  80024b:	6a 1f                	push   $0x1f
  80024d:	68 c8 1f 80 00       	push   $0x801fc8
  800252:	e8 6d 04 00 00       	call   8006c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80026a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 80 1f 80 00       	push   $0x801f80
  800281:	6a 20                	push   $0x20
  800283:	68 c8 1f 80 00       	push   $0x801fc8
  800288:	e8 37 04 00 00       	call   8006c4 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 dc 1f 80 00       	push   $0x801fdc
  8002a4:	6a 21                	push   $0x21
  8002a6:	68 c8 1f 80 00       	push   $0x801fc8
  8002ab:	e8 14 04 00 00       	call   8006c4 <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b0:	e8 d2 15 00 00       	call   801887 <sys_calculate_modified_frames>
  8002b5:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002b8:	e8 e3 15 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  8002bd:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c0:	e8 2c 16 00 00       	call   8018f1 <sys_pf_calculate_allocated_pages>
  8002c5:	89 45 a8             	mov    %eax,-0x58(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
  8002d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  8002dd:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8002e4:	eb 33                	jmp    800319 <_main+0x2e1>
	{
		dst[i] = i;
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002ec:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
		dstSum1 += i;
  8002f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f6:	01 45 f0             	add    %eax,-0x10(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8002f9:	e8 a2 15 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  8002fe:	89 c2                	mov    %eax,%edx
  800300:	a1 20 30 80 00       	mov    0x803020,%eax
  800305:	8b 40 4c             	mov    0x4c(%eax),%eax
  800308:	01 c2                	add    %eax,%edx
  80030a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80030d:	01 d0                	add    %edx,%eax
  80030f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
	int dstSum1 = 0;
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800312:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800319:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800320:	7e c4                	jle    8002e6 <_main+0x2ae>
		dstSum1 += i;
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}


	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800322:	e8 79 15 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  800327:	89 c2                	mov    %eax,%edx
  800329:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80032c:	29 c2                	sub    %eax,%edx
  80032e:	89 d0                	mov    %edx,%eax
  800330:	83 f8 07             	cmp    $0x7,%eax
  800333:	74 14                	je     800349 <_main+0x311>
  800335:	83 ec 04             	sub    $0x4,%esp
  800338:	68 2c 20 80 00       	push   $0x80202c
  80033d:	6a 35                	push   $0x35
  80033f:	68 c8 1f 80 00       	push   $0x801fc8
  800344:	e8 7b 03 00 00       	call   8006c4 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800349:	e8 39 15 00 00       	call   801887 <sys_calculate_modified_frames>
  80034e:	89 c2                	mov    %eax,%edx
  800350:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	74 14                	je     80036b <_main+0x333>
  800357:	83 ec 04             	sub    $0x4,%esp
  80035a:	68 90 20 80 00       	push   $0x802090
  80035f:	6a 36                	push   $0x36
  800361:	68 c8 1f 80 00       	push   $0x801fc8
  800366:	e8 59 03 00 00       	call   8006c4 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036b:	e8 30 15 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  800370:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800373:	e8 0f 15 00 00       	call   801887 <sys_calculate_modified_frames>
  800378:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
  80037b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	i = PAGE_SIZE/4;
  800382:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	for(;i<arrSize;i+=PAGE_SIZE/4)
  800389:	eb 2d                	jmp    8003b8 <_main+0x380>
	{
		srcSum1 += src[i];
  80038b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80038e:	8b 04 85 60 b0 80 00 	mov    0x80b060(,%eax,4),%eax
  800395:	01 45 e8             	add    %eax,-0x18(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  800398:	e8 03 15 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  80039d:	89 c2                	mov    %eax,%edx
  80039f:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a4:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003a7:	01 c2                	add    %eax,%edx
  8003a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003ac:	01 d0                	add    %edx,%eax
  8003ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
	i = PAGE_SIZE/4;
	for(;i<arrSize;i+=PAGE_SIZE/4)
  8003b1:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  8003b8:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  8003bf:	7e ca                	jle    80038b <_main+0x353>
		srcSum1 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c1:	e8 da 14 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  8003c6:	89 c2                	mov    %eax,%edx
  8003c8:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003cb:	39 c2                	cmp    %eax,%edx
  8003cd:	74 14                	je     8003e3 <_main+0x3ab>
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 2c 20 80 00       	push   $0x80202c
  8003d7:	6a 45                	push   $0x45
  8003d9:	68 c8 1f 80 00       	push   $0x801fc8
  8003de:	e8 e1 02 00 00       	call   8006c4 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e3:	e8 9f 14 00 00       	call   801887 <sys_calculate_modified_frames>
  8003e8:	89 c2                	mov    %eax,%edx
  8003ea:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003ed:	29 c2                	sub    %eax,%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	83 f8 07             	cmp    $0x7,%eax
  8003f4:	74 14                	je     80040a <_main+0x3d2>
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	68 90 20 80 00       	push   $0x802090
  8003fe:	6a 46                	push   $0x46
  800400:	68 c8 1f 80 00       	push   $0x801fc8
  800405:	e8 ba 02 00 00       	call   8006c4 <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040a:	e8 91 14 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  80040f:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800412:	e8 70 14 00 00       	call   801887 <sys_calculate_modified_frames>
  800417:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
  80041a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum2 = 0 ;
  800421:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800428:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  80042f:	eb 2d                	jmp    80045e <_main+0x426>
	{
		dstSum2 += dst[i];
  800431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800434:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80043b:	01 45 e4             	add    %eax,-0x1c(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  80043e:	e8 5d 14 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  800443:	89 c2                	mov    %eax,%edx
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 40 4c             	mov    0x4c(%eax),%eax
  80044d:	01 c2                	add    %eax,%edx
  80044f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800457:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80045e:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800465:	7e ca                	jle    800431 <_main+0x3f9>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800467:	e8 34 14 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  80046c:	89 c2                	mov    %eax,%edx
  80046e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800471:	29 c2                	sub    %eax,%edx
  800473:	89 d0                	mov    %edx,%eax
  800475:	83 f8 07             	cmp    $0x7,%eax
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 2c 20 80 00       	push   $0x80202c
  800482:	6a 53                	push   $0x53
  800484:	68 c8 1f 80 00       	push   $0x801fc8
  800489:	e8 36 02 00 00       	call   8006c4 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80048e:	e8 f4 13 00 00       	call   801887 <sys_calculate_modified_frames>
  800493:	89 c2                	mov    %eax,%edx
  800495:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800498:	29 c2                	sub    %eax,%edx
  80049a:	89 d0                	mov    %edx,%eax
  80049c:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 90 20 80 00       	push   $0x802090
  8004a9:	6a 54                	push   $0x54
  8004ab:	68 c8 1f 80 00       	push   $0x801fc8
  8004b0:	e8 0f 02 00 00       	call   8006c4 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b5:	e8 e6 13 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  8004ba:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004bd:	e8 c5 13 00 00       	call   801887 <sys_calculate_modified_frames>
  8004c2:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
  8004c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int srcSum2 = 0 ;
  8004cc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  8004d3:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8004da:	eb 2d                	jmp    800509 <_main+0x4d1>
	{
		srcSum2 += src[i];
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	8b 04 85 60 b0 80 00 	mov    0x80b060(,%eax,4),%eax
  8004e6:	01 45 e0             	add    %eax,-0x20(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8004e9:	e8 b2 13 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  8004ee:	89 c2                	mov    %eax,%edx
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004f8:	01 c2                	add    %eax,%edx
  8004fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fd:	01 d0                	add    %edx,%eax
  8004ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
	int srcSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800502:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800509:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800510:	7e ca                	jle    8004dc <_main+0x4a4>
	{
		srcSum2 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800512:	e8 89 13 00 00       	call   8018a0 <sys_calculate_notmod_frames>
  800517:	89 c2                	mov    %eax,%edx
  800519:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80051c:	29 c2                	sub    %eax,%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800523:	74 14                	je     800539 <_main+0x501>
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	68 2c 20 80 00       	push   $0x80202c
  80052d:	6a 62                	push   $0x62
  80052f:	68 c8 1f 80 00       	push   $0x801fc8
  800534:	e8 8b 01 00 00       	call   8006c4 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800539:	e8 49 13 00 00       	call   801887 <sys_calculate_modified_frames>
  80053e:	89 c2                	mov    %eax,%edx
  800540:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800543:	29 c2                	sub    %eax,%edx
  800545:	89 d0                	mov    %edx,%eax
  800547:	83 f8 07             	cmp    $0x7,%eax
  80054a:	74 14                	je     800560 <_main+0x528>
  80054c:	83 ec 04             	sub    $0x4,%esp
  80054f:	68 90 20 80 00       	push   $0x802090
  800554:	6a 63                	push   $0x63
  800556:	68 c8 1f 80 00       	push   $0x801fc8
  80055b:	e8 64 01 00 00       	call   8006c4 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800560:	e8 8c 13 00 00       	call   8018f1 <sys_pf_calculate_allocated_pages>
  800565:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 fc 20 80 00       	push   $0x8020fc
  800572:	6a 65                	push   $0x65
  800574:	68 c8 1f 80 00       	push   $0x801fc8
  800579:	e8 46 01 00 00       	call   8006c4 <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  80057e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800581:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800584:	75 08                	jne    80058e <_main+0x556>
  800586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800589:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058c:	74 14                	je     8005a2 <_main+0x56a>
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 6c 21 80 00       	push   $0x80216c
  800596:	6a 67                	push   $0x67
  800598:	68 c8 1f 80 00       	push   $0x801fc8
  80059d:	e8 22 01 00 00       	call   8006c4 <_panic>

	cprintf("Congratulations!! test buffered pages inside REPLACEMENT is completed successfully.\n");
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	68 a8 21 80 00       	push   $0x8021a8
  8005aa:	e8 c9 03 00 00       	call   800978 <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp
	return;
  8005b2:	90                   	nop

}
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005bb:	e8 e3 11 00 00       	call   8017a3 <sys_getenvindex>
  8005c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005c6:	89 d0                	mov    %edx,%eax
  8005c8:	c1 e0 02             	shl    $0x2,%eax
  8005cb:	01 d0                	add    %edx,%eax
  8005cd:	01 c0                	add    %eax,%eax
  8005cf:	01 d0                	add    %edx,%eax
  8005d1:	01 c0                	add    %eax,%eax
  8005d3:	01 d0                	add    %edx,%eax
  8005d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005dc:	01 d0                	add    %edx,%eax
  8005de:	c1 e0 02             	shl    $0x2,%eax
  8005e1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005e6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f0:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005f6:	84 c0                	test   %al,%al
  8005f8:	74 0f                	je     800609 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8005fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ff:	05 f4 02 00 00       	add    $0x2f4,%eax
  800604:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800609:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80060d:	7e 0a                	jle    800619 <libmain+0x64>
		binaryname = argv[0];
  80060f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800612:	8b 00                	mov    (%eax),%eax
  800614:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800619:	83 ec 08             	sub    $0x8,%esp
  80061c:	ff 75 0c             	pushl  0xc(%ebp)
  80061f:	ff 75 08             	pushl  0x8(%ebp)
  800622:	e8 11 fa ff ff       	call   800038 <_main>
  800627:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80062a:	e8 0f 13 00 00       	call   80193e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80062f:	83 ec 0c             	sub    $0xc,%esp
  800632:	68 18 22 80 00       	push   $0x802218
  800637:	e8 3c 03 00 00       	call   800978 <cprintf>
  80063c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80063f:	a1 20 30 80 00       	mov    0x803020,%eax
  800644:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80064a:	a1 20 30 80 00       	mov    0x803020,%eax
  80064f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800655:	83 ec 04             	sub    $0x4,%esp
  800658:	52                   	push   %edx
  800659:	50                   	push   %eax
  80065a:	68 40 22 80 00       	push   $0x802240
  80065f:	e8 14 03 00 00       	call   800978 <cprintf>
  800664:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800667:	a1 20 30 80 00       	mov    0x803020,%eax
  80066c:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800672:	83 ec 08             	sub    $0x8,%esp
  800675:	50                   	push   %eax
  800676:	68 65 22 80 00       	push   $0x802265
  80067b:	e8 f8 02 00 00       	call   800978 <cprintf>
  800680:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800683:	83 ec 0c             	sub    $0xc,%esp
  800686:	68 18 22 80 00       	push   $0x802218
  80068b:	e8 e8 02 00 00       	call   800978 <cprintf>
  800690:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800693:	e8 c0 12 00 00       	call   801958 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800698:	e8 19 00 00 00       	call   8006b6 <exit>
}
  80069d:	90                   	nop
  80069e:	c9                   	leave  
  80069f:	c3                   	ret    

008006a0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006a0:	55                   	push   %ebp
  8006a1:	89 e5                	mov    %esp,%ebp
  8006a3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006a6:	83 ec 0c             	sub    $0xc,%esp
  8006a9:	6a 00                	push   $0x0
  8006ab:	e8 bf 10 00 00       	call   80176f <sys_env_destroy>
  8006b0:	83 c4 10             	add    $0x10,%esp
}
  8006b3:	90                   	nop
  8006b4:	c9                   	leave  
  8006b5:	c3                   	ret    

008006b6 <exit>:

void
exit(void)
{
  8006b6:	55                   	push   %ebp
  8006b7:	89 e5                	mov    %esp,%ebp
  8006b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006bc:	e8 14 11 00 00       	call   8017d5 <sys_env_exit>
}
  8006c1:	90                   	nop
  8006c2:	c9                   	leave  
  8006c3:	c3                   	ret    

008006c4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006c4:	55                   	push   %ebp
  8006c5:	89 e5                	mov    %esp,%ebp
  8006c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006ca:	8d 45 10             	lea    0x10(%ebp),%eax
  8006cd:	83 c0 04             	add    $0x4,%eax
  8006d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006d3:	a1 64 30 81 00       	mov    0x813064,%eax
  8006d8:	85 c0                	test   %eax,%eax
  8006da:	74 16                	je     8006f2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006dc:	a1 64 30 81 00       	mov    0x813064,%eax
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	50                   	push   %eax
  8006e5:	68 7c 22 80 00       	push   $0x80227c
  8006ea:	e8 89 02 00 00       	call   800978 <cprintf>
  8006ef:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006f2:	a1 00 30 80 00       	mov    0x803000,%eax
  8006f7:	ff 75 0c             	pushl  0xc(%ebp)
  8006fa:	ff 75 08             	pushl  0x8(%ebp)
  8006fd:	50                   	push   %eax
  8006fe:	68 81 22 80 00       	push   $0x802281
  800703:	e8 70 02 00 00       	call   800978 <cprintf>
  800708:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80070b:	8b 45 10             	mov    0x10(%ebp),%eax
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 f4             	pushl  -0xc(%ebp)
  800714:	50                   	push   %eax
  800715:	e8 f3 01 00 00       	call   80090d <vcprintf>
  80071a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	6a 00                	push   $0x0
  800722:	68 9d 22 80 00       	push   $0x80229d
  800727:	e8 e1 01 00 00       	call   80090d <vcprintf>
  80072c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80072f:	e8 82 ff ff ff       	call   8006b6 <exit>

	// should not return here
	while (1) ;
  800734:	eb fe                	jmp    800734 <_panic+0x70>

00800736 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80073c:	a1 20 30 80 00       	mov    0x803020,%eax
  800741:	8b 50 74             	mov    0x74(%eax),%edx
  800744:	8b 45 0c             	mov    0xc(%ebp),%eax
  800747:	39 c2                	cmp    %eax,%edx
  800749:	74 14                	je     80075f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80074b:	83 ec 04             	sub    $0x4,%esp
  80074e:	68 a0 22 80 00       	push   $0x8022a0
  800753:	6a 26                	push   $0x26
  800755:	68 ec 22 80 00       	push   $0x8022ec
  80075a:	e8 65 ff ff ff       	call   8006c4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80075f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800766:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80076d:	e9 c2 00 00 00       	jmp    800834 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800772:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800775:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	01 d0                	add    %edx,%eax
  800781:	8b 00                	mov    (%eax),%eax
  800783:	85 c0                	test   %eax,%eax
  800785:	75 08                	jne    80078f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800787:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80078a:	e9 a2 00 00 00       	jmp    800831 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80078f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800796:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80079d:	eb 69                	jmp    800808 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80079f:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007aa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ad:	89 d0                	mov    %edx,%eax
  8007af:	01 c0                	add    %eax,%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	c1 e0 02             	shl    $0x2,%eax
  8007b6:	01 c8                	add    %ecx,%eax
  8007b8:	8a 40 04             	mov    0x4(%eax),%al
  8007bb:	84 c0                	test   %al,%al
  8007bd:	75 46                	jne    800805 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007ca:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007cd:	89 d0                	mov    %edx,%eax
  8007cf:	01 c0                	add    %eax,%eax
  8007d1:	01 d0                	add    %edx,%eax
  8007d3:	c1 e0 02             	shl    $0x2,%eax
  8007d6:	01 c8                	add    %ecx,%eax
  8007d8:	8b 00                	mov    (%eax),%eax
  8007da:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007dd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007e5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ea:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	01 c8                	add    %ecx,%eax
  8007f6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f8:	39 c2                	cmp    %eax,%edx
  8007fa:	75 09                	jne    800805 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007fc:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800803:	eb 12                	jmp    800817 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800805:	ff 45 e8             	incl   -0x18(%ebp)
  800808:	a1 20 30 80 00       	mov    0x803020,%eax
  80080d:	8b 50 74             	mov    0x74(%eax),%edx
  800810:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800813:	39 c2                	cmp    %eax,%edx
  800815:	77 88                	ja     80079f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800817:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80081b:	75 14                	jne    800831 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80081d:	83 ec 04             	sub    $0x4,%esp
  800820:	68 f8 22 80 00       	push   $0x8022f8
  800825:	6a 3a                	push   $0x3a
  800827:	68 ec 22 80 00       	push   $0x8022ec
  80082c:	e8 93 fe ff ff       	call   8006c4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800831:	ff 45 f0             	incl   -0x10(%ebp)
  800834:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800837:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80083a:	0f 8c 32 ff ff ff    	jl     800772 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800840:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800847:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80084e:	eb 26                	jmp    800876 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800850:	a1 20 30 80 00       	mov    0x803020,%eax
  800855:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80085b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80085e:	89 d0                	mov    %edx,%eax
  800860:	01 c0                	add    %eax,%eax
  800862:	01 d0                	add    %edx,%eax
  800864:	c1 e0 02             	shl    $0x2,%eax
  800867:	01 c8                	add    %ecx,%eax
  800869:	8a 40 04             	mov    0x4(%eax),%al
  80086c:	3c 01                	cmp    $0x1,%al
  80086e:	75 03                	jne    800873 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800870:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800873:	ff 45 e0             	incl   -0x20(%ebp)
  800876:	a1 20 30 80 00       	mov    0x803020,%eax
  80087b:	8b 50 74             	mov    0x74(%eax),%edx
  80087e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800881:	39 c2                	cmp    %eax,%edx
  800883:	77 cb                	ja     800850 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800885:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800888:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80088b:	74 14                	je     8008a1 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80088d:	83 ec 04             	sub    $0x4,%esp
  800890:	68 4c 23 80 00       	push   $0x80234c
  800895:	6a 44                	push   $0x44
  800897:	68 ec 22 80 00       	push   $0x8022ec
  80089c:	e8 23 fe ff ff       	call   8006c4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a1:	90                   	nop
  8008a2:	c9                   	leave  
  8008a3:	c3                   	ret    

008008a4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008a4:	55                   	push   %ebp
  8008a5:	89 e5                	mov    %esp,%ebp
  8008a7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ad:	8b 00                	mov    (%eax),%eax
  8008af:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b5:	89 0a                	mov    %ecx,(%edx)
  8008b7:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ba:	88 d1                	mov    %dl,%cl
  8008bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bf:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008cd:	75 2c                	jne    8008fb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008cf:	a0 24 30 80 00       	mov    0x803024,%al
  8008d4:	0f b6 c0             	movzbl %al,%eax
  8008d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008da:	8b 12                	mov    (%edx),%edx
  8008dc:	89 d1                	mov    %edx,%ecx
  8008de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e1:	83 c2 08             	add    $0x8,%edx
  8008e4:	83 ec 04             	sub    $0x4,%esp
  8008e7:	50                   	push   %eax
  8008e8:	51                   	push   %ecx
  8008e9:	52                   	push   %edx
  8008ea:	e8 3e 0e 00 00       	call   80172d <sys_cputs>
  8008ef:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8b 40 04             	mov    0x4(%eax),%eax
  800901:	8d 50 01             	lea    0x1(%eax),%edx
  800904:	8b 45 0c             	mov    0xc(%ebp),%eax
  800907:	89 50 04             	mov    %edx,0x4(%eax)
}
  80090a:	90                   	nop
  80090b:	c9                   	leave  
  80090c:	c3                   	ret    

0080090d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80090d:	55                   	push   %ebp
  80090e:	89 e5                	mov    %esp,%ebp
  800910:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800916:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80091d:	00 00 00 
	b.cnt = 0;
  800920:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800927:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80092a:	ff 75 0c             	pushl  0xc(%ebp)
  80092d:	ff 75 08             	pushl  0x8(%ebp)
  800930:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800936:	50                   	push   %eax
  800937:	68 a4 08 80 00       	push   $0x8008a4
  80093c:	e8 11 02 00 00       	call   800b52 <vprintfmt>
  800941:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800944:	a0 24 30 80 00       	mov    0x803024,%al
  800949:	0f b6 c0             	movzbl %al,%eax
  80094c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800952:	83 ec 04             	sub    $0x4,%esp
  800955:	50                   	push   %eax
  800956:	52                   	push   %edx
  800957:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80095d:	83 c0 08             	add    $0x8,%eax
  800960:	50                   	push   %eax
  800961:	e8 c7 0d 00 00       	call   80172d <sys_cputs>
  800966:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800969:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800970:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800976:	c9                   	leave  
  800977:	c3                   	ret    

00800978 <cprintf>:

int cprintf(const char *fmt, ...) {
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80097e:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800985:	8d 45 0c             	lea    0xc(%ebp),%eax
  800988:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	83 ec 08             	sub    $0x8,%esp
  800991:	ff 75 f4             	pushl  -0xc(%ebp)
  800994:	50                   	push   %eax
  800995:	e8 73 ff ff ff       	call   80090d <vcprintf>
  80099a:	83 c4 10             	add    $0x10,%esp
  80099d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a3:	c9                   	leave  
  8009a4:	c3                   	ret    

008009a5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a5:	55                   	push   %ebp
  8009a6:	89 e5                	mov    %esp,%ebp
  8009a8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ab:	e8 8e 0f 00 00       	call   80193e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009b0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b9:	83 ec 08             	sub    $0x8,%esp
  8009bc:	ff 75 f4             	pushl  -0xc(%ebp)
  8009bf:	50                   	push   %eax
  8009c0:	e8 48 ff ff ff       	call   80090d <vcprintf>
  8009c5:	83 c4 10             	add    $0x10,%esp
  8009c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009cb:	e8 88 0f 00 00       	call   801958 <sys_enable_interrupt>
	return cnt;
  8009d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d3:	c9                   	leave  
  8009d4:	c3                   	ret    

008009d5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d5:	55                   	push   %ebp
  8009d6:	89 e5                	mov    %esp,%ebp
  8009d8:	53                   	push   %ebx
  8009d9:	83 ec 14             	sub    $0x14,%esp
  8009dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8009df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009e8:	8b 45 18             	mov    0x18(%ebp),%eax
  8009eb:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f3:	77 55                	ja     800a4a <printnum+0x75>
  8009f5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f8:	72 05                	jb     8009ff <printnum+0x2a>
  8009fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009fd:	77 4b                	ja     800a4a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009ff:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a02:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a05:	8b 45 18             	mov    0x18(%ebp),%eax
  800a08:	ba 00 00 00 00       	mov    $0x0,%edx
  800a0d:	52                   	push   %edx
  800a0e:	50                   	push   %eax
  800a0f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a12:	ff 75 f0             	pushl  -0x10(%ebp)
  800a15:	e8 02 13 00 00       	call   801d1c <__udivdi3>
  800a1a:	83 c4 10             	add    $0x10,%esp
  800a1d:	83 ec 04             	sub    $0x4,%esp
  800a20:	ff 75 20             	pushl  0x20(%ebp)
  800a23:	53                   	push   %ebx
  800a24:	ff 75 18             	pushl  0x18(%ebp)
  800a27:	52                   	push   %edx
  800a28:	50                   	push   %eax
  800a29:	ff 75 0c             	pushl  0xc(%ebp)
  800a2c:	ff 75 08             	pushl  0x8(%ebp)
  800a2f:	e8 a1 ff ff ff       	call   8009d5 <printnum>
  800a34:	83 c4 20             	add    $0x20,%esp
  800a37:	eb 1a                	jmp    800a53 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 0c             	pushl  0xc(%ebp)
  800a3f:	ff 75 20             	pushl  0x20(%ebp)
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	ff d0                	call   *%eax
  800a47:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a4a:	ff 4d 1c             	decl   0x1c(%ebp)
  800a4d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a51:	7f e6                	jg     800a39 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a53:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a56:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a61:	53                   	push   %ebx
  800a62:	51                   	push   %ecx
  800a63:	52                   	push   %edx
  800a64:	50                   	push   %eax
  800a65:	e8 c2 13 00 00       	call   801e2c <__umoddi3>
  800a6a:	83 c4 10             	add    $0x10,%esp
  800a6d:	05 b4 25 80 00       	add    $0x8025b4,%eax
  800a72:	8a 00                	mov    (%eax),%al
  800a74:	0f be c0             	movsbl %al,%eax
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	50                   	push   %eax
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	ff d0                	call   *%eax
  800a83:	83 c4 10             	add    $0x10,%esp
}
  800a86:	90                   	nop
  800a87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a8a:	c9                   	leave  
  800a8b:	c3                   	ret    

00800a8c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a8c:	55                   	push   %ebp
  800a8d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a8f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a93:	7e 1c                	jle    800ab1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8b 00                	mov    (%eax),%eax
  800a9a:	8d 50 08             	lea    0x8(%eax),%edx
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	89 10                	mov    %edx,(%eax)
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	8b 00                	mov    (%eax),%eax
  800aa7:	83 e8 08             	sub    $0x8,%eax
  800aaa:	8b 50 04             	mov    0x4(%eax),%edx
  800aad:	8b 00                	mov    (%eax),%eax
  800aaf:	eb 40                	jmp    800af1 <getuint+0x65>
	else if (lflag)
  800ab1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab5:	74 1e                	je     800ad5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	8d 50 04             	lea    0x4(%eax),%edx
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	89 10                	mov    %edx,(%eax)
  800ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac7:	8b 00                	mov    (%eax),%eax
  800ac9:	83 e8 04             	sub    $0x4,%eax
  800acc:	8b 00                	mov    (%eax),%eax
  800ace:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad3:	eb 1c                	jmp    800af1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	8b 00                	mov    (%eax),%eax
  800ada:	8d 50 04             	lea    0x4(%eax),%edx
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	89 10                	mov    %edx,(%eax)
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	8b 00                	mov    (%eax),%eax
  800ae7:	83 e8 04             	sub    $0x4,%eax
  800aea:	8b 00                	mov    (%eax),%eax
  800aec:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af1:	5d                   	pop    %ebp
  800af2:	c3                   	ret    

00800af3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800afa:	7e 1c                	jle    800b18 <getint+0x25>
		return va_arg(*ap, long long);
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	8d 50 08             	lea    0x8(%eax),%edx
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	89 10                	mov    %edx,(%eax)
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	83 e8 08             	sub    $0x8,%eax
  800b11:	8b 50 04             	mov    0x4(%eax),%edx
  800b14:	8b 00                	mov    (%eax),%eax
  800b16:	eb 38                	jmp    800b50 <getint+0x5d>
	else if (lflag)
  800b18:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1c:	74 1a                	je     800b38 <getint+0x45>
		return va_arg(*ap, long);
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	8d 50 04             	lea    0x4(%eax),%edx
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 10                	mov    %edx,(%eax)
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	83 e8 04             	sub    $0x4,%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	99                   	cltd   
  800b36:	eb 18                	jmp    800b50 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	8d 50 04             	lea    0x4(%eax),%edx
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	89 10                	mov    %edx,(%eax)
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	83 e8 04             	sub    $0x4,%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	99                   	cltd   
}
  800b50:	5d                   	pop    %ebp
  800b51:	c3                   	ret    

00800b52 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
  800b55:	56                   	push   %esi
  800b56:	53                   	push   %ebx
  800b57:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b5a:	eb 17                	jmp    800b73 <vprintfmt+0x21>
			if (ch == '\0')
  800b5c:	85 db                	test   %ebx,%ebx
  800b5e:	0f 84 af 03 00 00    	je     800f13 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b64:	83 ec 08             	sub    $0x8,%esp
  800b67:	ff 75 0c             	pushl  0xc(%ebp)
  800b6a:	53                   	push   %ebx
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	ff d0                	call   *%eax
  800b70:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b73:	8b 45 10             	mov    0x10(%ebp),%eax
  800b76:	8d 50 01             	lea    0x1(%eax),%edx
  800b79:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7c:	8a 00                	mov    (%eax),%al
  800b7e:	0f b6 d8             	movzbl %al,%ebx
  800b81:	83 fb 25             	cmp    $0x25,%ebx
  800b84:	75 d6                	jne    800b5c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b86:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b8a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b91:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b98:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b9f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba9:	8d 50 01             	lea    0x1(%eax),%edx
  800bac:	89 55 10             	mov    %edx,0x10(%ebp)
  800baf:	8a 00                	mov    (%eax),%al
  800bb1:	0f b6 d8             	movzbl %al,%ebx
  800bb4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bb7:	83 f8 55             	cmp    $0x55,%eax
  800bba:	0f 87 2b 03 00 00    	ja     800eeb <vprintfmt+0x399>
  800bc0:	8b 04 85 d8 25 80 00 	mov    0x8025d8(,%eax,4),%eax
  800bc7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bc9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bcd:	eb d7                	jmp    800ba6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bcf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd3:	eb d1                	jmp    800ba6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bdc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bdf:	89 d0                	mov    %edx,%eax
  800be1:	c1 e0 02             	shl    $0x2,%eax
  800be4:	01 d0                	add    %edx,%eax
  800be6:	01 c0                	add    %eax,%eax
  800be8:	01 d8                	add    %ebx,%eax
  800bea:	83 e8 30             	sub    $0x30,%eax
  800bed:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bf8:	83 fb 2f             	cmp    $0x2f,%ebx
  800bfb:	7e 3e                	jle    800c3b <vprintfmt+0xe9>
  800bfd:	83 fb 39             	cmp    $0x39,%ebx
  800c00:	7f 39                	jg     800c3b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c02:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c05:	eb d5                	jmp    800bdc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c07:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0a:	83 c0 04             	add    $0x4,%eax
  800c0d:	89 45 14             	mov    %eax,0x14(%ebp)
  800c10:	8b 45 14             	mov    0x14(%ebp),%eax
  800c13:	83 e8 04             	sub    $0x4,%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c1b:	eb 1f                	jmp    800c3c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c21:	79 83                	jns    800ba6 <vprintfmt+0x54>
				width = 0;
  800c23:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c2a:	e9 77 ff ff ff       	jmp    800ba6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c2f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c36:	e9 6b ff ff ff       	jmp    800ba6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c3b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c40:	0f 89 60 ff ff ff    	jns    800ba6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c49:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c4c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c53:	e9 4e ff ff ff       	jmp    800ba6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c58:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c5b:	e9 46 ff ff ff       	jmp    800ba6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c60:	8b 45 14             	mov    0x14(%ebp),%eax
  800c63:	83 c0 04             	add    $0x4,%eax
  800c66:	89 45 14             	mov    %eax,0x14(%ebp)
  800c69:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6c:	83 e8 04             	sub    $0x4,%eax
  800c6f:	8b 00                	mov    (%eax),%eax
  800c71:	83 ec 08             	sub    $0x8,%esp
  800c74:	ff 75 0c             	pushl  0xc(%ebp)
  800c77:	50                   	push   %eax
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	ff d0                	call   *%eax
  800c7d:	83 c4 10             	add    $0x10,%esp
			break;
  800c80:	e9 89 02 00 00       	jmp    800f0e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c85:	8b 45 14             	mov    0x14(%ebp),%eax
  800c88:	83 c0 04             	add    $0x4,%eax
  800c8b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c91:	83 e8 04             	sub    $0x4,%eax
  800c94:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c96:	85 db                	test   %ebx,%ebx
  800c98:	79 02                	jns    800c9c <vprintfmt+0x14a>
				err = -err;
  800c9a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c9c:	83 fb 64             	cmp    $0x64,%ebx
  800c9f:	7f 0b                	jg     800cac <vprintfmt+0x15a>
  800ca1:	8b 34 9d 20 24 80 00 	mov    0x802420(,%ebx,4),%esi
  800ca8:	85 f6                	test   %esi,%esi
  800caa:	75 19                	jne    800cc5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cac:	53                   	push   %ebx
  800cad:	68 c5 25 80 00       	push   $0x8025c5
  800cb2:	ff 75 0c             	pushl  0xc(%ebp)
  800cb5:	ff 75 08             	pushl  0x8(%ebp)
  800cb8:	e8 5e 02 00 00       	call   800f1b <printfmt>
  800cbd:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cc0:	e9 49 02 00 00       	jmp    800f0e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc5:	56                   	push   %esi
  800cc6:	68 ce 25 80 00       	push   $0x8025ce
  800ccb:	ff 75 0c             	pushl  0xc(%ebp)
  800cce:	ff 75 08             	pushl  0x8(%ebp)
  800cd1:	e8 45 02 00 00       	call   800f1b <printfmt>
  800cd6:	83 c4 10             	add    $0x10,%esp
			break;
  800cd9:	e9 30 02 00 00       	jmp    800f0e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cde:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce1:	83 c0 04             	add    $0x4,%eax
  800ce4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cea:	83 e8 04             	sub    $0x4,%eax
  800ced:	8b 30                	mov    (%eax),%esi
  800cef:	85 f6                	test   %esi,%esi
  800cf1:	75 05                	jne    800cf8 <vprintfmt+0x1a6>
				p = "(null)";
  800cf3:	be d1 25 80 00       	mov    $0x8025d1,%esi
			if (width > 0 && padc != '-')
  800cf8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cfc:	7e 6d                	jle    800d6b <vprintfmt+0x219>
  800cfe:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d02:	74 67                	je     800d6b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d04:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d07:	83 ec 08             	sub    $0x8,%esp
  800d0a:	50                   	push   %eax
  800d0b:	56                   	push   %esi
  800d0c:	e8 0c 03 00 00       	call   80101d <strnlen>
  800d11:	83 c4 10             	add    $0x10,%esp
  800d14:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d17:	eb 16                	jmp    800d2f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d19:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d1d:	83 ec 08             	sub    $0x8,%esp
  800d20:	ff 75 0c             	pushl  0xc(%ebp)
  800d23:	50                   	push   %eax
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	ff d0                	call   *%eax
  800d29:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d2c:	ff 4d e4             	decl   -0x1c(%ebp)
  800d2f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d33:	7f e4                	jg     800d19 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d35:	eb 34                	jmp    800d6b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d37:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d3b:	74 1c                	je     800d59 <vprintfmt+0x207>
  800d3d:	83 fb 1f             	cmp    $0x1f,%ebx
  800d40:	7e 05                	jle    800d47 <vprintfmt+0x1f5>
  800d42:	83 fb 7e             	cmp    $0x7e,%ebx
  800d45:	7e 12                	jle    800d59 <vprintfmt+0x207>
					putch('?', putdat);
  800d47:	83 ec 08             	sub    $0x8,%esp
  800d4a:	ff 75 0c             	pushl  0xc(%ebp)
  800d4d:	6a 3f                	push   $0x3f
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	ff d0                	call   *%eax
  800d54:	83 c4 10             	add    $0x10,%esp
  800d57:	eb 0f                	jmp    800d68 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d59:	83 ec 08             	sub    $0x8,%esp
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	53                   	push   %ebx
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	ff d0                	call   *%eax
  800d65:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d68:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6b:	89 f0                	mov    %esi,%eax
  800d6d:	8d 70 01             	lea    0x1(%eax),%esi
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f be d8             	movsbl %al,%ebx
  800d75:	85 db                	test   %ebx,%ebx
  800d77:	74 24                	je     800d9d <vprintfmt+0x24b>
  800d79:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d7d:	78 b8                	js     800d37 <vprintfmt+0x1e5>
  800d7f:	ff 4d e0             	decl   -0x20(%ebp)
  800d82:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d86:	79 af                	jns    800d37 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d88:	eb 13                	jmp    800d9d <vprintfmt+0x24b>
				putch(' ', putdat);
  800d8a:	83 ec 08             	sub    $0x8,%esp
  800d8d:	ff 75 0c             	pushl  0xc(%ebp)
  800d90:	6a 20                	push   $0x20
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	ff d0                	call   *%eax
  800d97:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9a:	ff 4d e4             	decl   -0x1c(%ebp)
  800d9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da1:	7f e7                	jg     800d8a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da3:	e9 66 01 00 00       	jmp    800f0e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800da8:	83 ec 08             	sub    $0x8,%esp
  800dab:	ff 75 e8             	pushl  -0x18(%ebp)
  800dae:	8d 45 14             	lea    0x14(%ebp),%eax
  800db1:	50                   	push   %eax
  800db2:	e8 3c fd ff ff       	call   800af3 <getint>
  800db7:	83 c4 10             	add    $0x10,%esp
  800dba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dbd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc6:	85 d2                	test   %edx,%edx
  800dc8:	79 23                	jns    800ded <vprintfmt+0x29b>
				putch('-', putdat);
  800dca:	83 ec 08             	sub    $0x8,%esp
  800dcd:	ff 75 0c             	pushl  0xc(%ebp)
  800dd0:	6a 2d                	push   $0x2d
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	ff d0                	call   *%eax
  800dd7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de0:	f7 d8                	neg    %eax
  800de2:	83 d2 00             	adc    $0x0,%edx
  800de5:	f7 da                	neg    %edx
  800de7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ded:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df4:	e9 bc 00 00 00       	jmp    800eb5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800df9:	83 ec 08             	sub    $0x8,%esp
  800dfc:	ff 75 e8             	pushl  -0x18(%ebp)
  800dff:	8d 45 14             	lea    0x14(%ebp),%eax
  800e02:	50                   	push   %eax
  800e03:	e8 84 fc ff ff       	call   800a8c <getuint>
  800e08:	83 c4 10             	add    $0x10,%esp
  800e0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e11:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e18:	e9 98 00 00 00       	jmp    800eb5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e1d:	83 ec 08             	sub    $0x8,%esp
  800e20:	ff 75 0c             	pushl  0xc(%ebp)
  800e23:	6a 58                	push   $0x58
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	ff d0                	call   *%eax
  800e2a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e2d:	83 ec 08             	sub    $0x8,%esp
  800e30:	ff 75 0c             	pushl  0xc(%ebp)
  800e33:	6a 58                	push   $0x58
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	ff d0                	call   *%eax
  800e3a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e3d:	83 ec 08             	sub    $0x8,%esp
  800e40:	ff 75 0c             	pushl  0xc(%ebp)
  800e43:	6a 58                	push   $0x58
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	ff d0                	call   *%eax
  800e4a:	83 c4 10             	add    $0x10,%esp
			break;
  800e4d:	e9 bc 00 00 00       	jmp    800f0e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e52:	83 ec 08             	sub    $0x8,%esp
  800e55:	ff 75 0c             	pushl  0xc(%ebp)
  800e58:	6a 30                	push   $0x30
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	ff d0                	call   *%eax
  800e5f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e62:	83 ec 08             	sub    $0x8,%esp
  800e65:	ff 75 0c             	pushl  0xc(%ebp)
  800e68:	6a 78                	push   $0x78
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	ff d0                	call   *%eax
  800e6f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e72:	8b 45 14             	mov    0x14(%ebp),%eax
  800e75:	83 c0 04             	add    $0x4,%eax
  800e78:	89 45 14             	mov    %eax,0x14(%ebp)
  800e7b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7e:	83 e8 04             	sub    $0x4,%eax
  800e81:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e83:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e8d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e94:	eb 1f                	jmp    800eb5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e96:	83 ec 08             	sub    $0x8,%esp
  800e99:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9c:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9f:	50                   	push   %eax
  800ea0:	e8 e7 fb ff ff       	call   800a8c <getuint>
  800ea5:	83 c4 10             	add    $0x10,%esp
  800ea8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ebc:	83 ec 04             	sub    $0x4,%esp
  800ebf:	52                   	push   %edx
  800ec0:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec3:	50                   	push   %eax
  800ec4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ec7:	ff 75 f0             	pushl  -0x10(%ebp)
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	ff 75 08             	pushl  0x8(%ebp)
  800ed0:	e8 00 fb ff ff       	call   8009d5 <printnum>
  800ed5:	83 c4 20             	add    $0x20,%esp
			break;
  800ed8:	eb 34                	jmp    800f0e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eda:	83 ec 08             	sub    $0x8,%esp
  800edd:	ff 75 0c             	pushl  0xc(%ebp)
  800ee0:	53                   	push   %ebx
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	ff d0                	call   *%eax
  800ee6:	83 c4 10             	add    $0x10,%esp
			break;
  800ee9:	eb 23                	jmp    800f0e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eeb:	83 ec 08             	sub    $0x8,%esp
  800eee:	ff 75 0c             	pushl  0xc(%ebp)
  800ef1:	6a 25                	push   $0x25
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	ff d0                	call   *%eax
  800ef8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800efb:	ff 4d 10             	decl   0x10(%ebp)
  800efe:	eb 03                	jmp    800f03 <vprintfmt+0x3b1>
  800f00:	ff 4d 10             	decl   0x10(%ebp)
  800f03:	8b 45 10             	mov    0x10(%ebp),%eax
  800f06:	48                   	dec    %eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	3c 25                	cmp    $0x25,%al
  800f0b:	75 f3                	jne    800f00 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f0d:	90                   	nop
		}
	}
  800f0e:	e9 47 fc ff ff       	jmp    800b5a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f13:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f14:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f17:	5b                   	pop    %ebx
  800f18:	5e                   	pop    %esi
  800f19:	5d                   	pop    %ebp
  800f1a:	c3                   	ret    

00800f1b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f1b:	55                   	push   %ebp
  800f1c:	89 e5                	mov    %esp,%ebp
  800f1e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f21:	8d 45 10             	lea    0x10(%ebp),%eax
  800f24:	83 c0 04             	add    $0x4,%eax
  800f27:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f30:	50                   	push   %eax
  800f31:	ff 75 0c             	pushl  0xc(%ebp)
  800f34:	ff 75 08             	pushl  0x8(%ebp)
  800f37:	e8 16 fc ff ff       	call   800b52 <vprintfmt>
  800f3c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f3f:	90                   	nop
  800f40:	c9                   	leave  
  800f41:	c3                   	ret    

00800f42 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f42:	55                   	push   %ebp
  800f43:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	8b 40 08             	mov    0x8(%eax),%eax
  800f4b:	8d 50 01             	lea    0x1(%eax),%edx
  800f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f51:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	8b 10                	mov    (%eax),%edx
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	8b 40 04             	mov    0x4(%eax),%eax
  800f5f:	39 c2                	cmp    %eax,%edx
  800f61:	73 12                	jae    800f75 <sprintputch+0x33>
		*b->buf++ = ch;
  800f63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f66:	8b 00                	mov    (%eax),%eax
  800f68:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6e:	89 0a                	mov    %ecx,(%edx)
  800f70:	8b 55 08             	mov    0x8(%ebp),%edx
  800f73:	88 10                	mov    %dl,(%eax)
}
  800f75:	90                   	nop
  800f76:	5d                   	pop    %ebp
  800f77:	c3                   	ret    

00800f78 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f78:	55                   	push   %ebp
  800f79:	89 e5                	mov    %esp,%ebp
  800f7b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	01 d0                	add    %edx,%eax
  800f8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f99:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f9d:	74 06                	je     800fa5 <vsnprintf+0x2d>
  800f9f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa3:	7f 07                	jg     800fac <vsnprintf+0x34>
		return -E_INVAL;
  800fa5:	b8 03 00 00 00       	mov    $0x3,%eax
  800faa:	eb 20                	jmp    800fcc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fac:	ff 75 14             	pushl  0x14(%ebp)
  800faf:	ff 75 10             	pushl  0x10(%ebp)
  800fb2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb5:	50                   	push   %eax
  800fb6:	68 42 0f 80 00       	push   $0x800f42
  800fbb:	e8 92 fb ff ff       	call   800b52 <vprintfmt>
  800fc0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fcc:	c9                   	leave  
  800fcd:	c3                   	ret    

00800fce <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
  800fd1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fd4:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd7:	83 c0 04             	add    $0x4,%eax
  800fda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe3:	50                   	push   %eax
  800fe4:	ff 75 0c             	pushl  0xc(%ebp)
  800fe7:	ff 75 08             	pushl  0x8(%ebp)
  800fea:	e8 89 ff ff ff       	call   800f78 <vsnprintf>
  800fef:	83 c4 10             	add    $0x10,%esp
  800ff2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff8:	c9                   	leave  
  800ff9:	c3                   	ret    

00800ffa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ffa:	55                   	push   %ebp
  800ffb:	89 e5                	mov    %esp,%ebp
  800ffd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801000:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801007:	eb 06                	jmp    80100f <strlen+0x15>
		n++;
  801009:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80100c:	ff 45 08             	incl   0x8(%ebp)
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	84 c0                	test   %al,%al
  801016:	75 f1                	jne    801009 <strlen+0xf>
		n++;
	return n;
  801018:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101b:	c9                   	leave  
  80101c:	c3                   	ret    

0080101d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80101d:	55                   	push   %ebp
  80101e:	89 e5                	mov    %esp,%ebp
  801020:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801023:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102a:	eb 09                	jmp    801035 <strnlen+0x18>
		n++;
  80102c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80102f:	ff 45 08             	incl   0x8(%ebp)
  801032:	ff 4d 0c             	decl   0xc(%ebp)
  801035:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801039:	74 09                	je     801044 <strnlen+0x27>
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	84 c0                	test   %al,%al
  801042:	75 e8                	jne    80102c <strnlen+0xf>
		n++;
	return n;
  801044:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801047:	c9                   	leave  
  801048:	c3                   	ret    

00801049 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801049:	55                   	push   %ebp
  80104a:	89 e5                	mov    %esp,%ebp
  80104c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801055:	90                   	nop
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	8d 50 01             	lea    0x1(%eax),%edx
  80105c:	89 55 08             	mov    %edx,0x8(%ebp)
  80105f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801062:	8d 4a 01             	lea    0x1(%edx),%ecx
  801065:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801068:	8a 12                	mov    (%edx),%dl
  80106a:	88 10                	mov    %dl,(%eax)
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	84 c0                	test   %al,%al
  801070:	75 e4                	jne    801056 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801072:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
  80107a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801083:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80108a:	eb 1f                	jmp    8010ab <strncpy+0x34>
		*dst++ = *src;
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8d 50 01             	lea    0x1(%eax),%edx
  801092:	89 55 08             	mov    %edx,0x8(%ebp)
  801095:	8b 55 0c             	mov    0xc(%ebp),%edx
  801098:	8a 12                	mov    (%edx),%dl
  80109a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80109c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	84 c0                	test   %al,%al
  8010a3:	74 03                	je     8010a8 <strncpy+0x31>
			src++;
  8010a5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010a8:	ff 45 fc             	incl   -0x4(%ebp)
  8010ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ae:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b1:	72 d9                	jb     80108c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
  8010bb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010c8:	74 30                	je     8010fa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010ca:	eb 16                	jmp    8010e2 <strlcpy+0x2a>
			*dst++ = *src++;
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	8d 50 01             	lea    0x1(%eax),%edx
  8010d2:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010db:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010de:	8a 12                	mov    (%edx),%dl
  8010e0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010e2:	ff 4d 10             	decl   0x10(%ebp)
  8010e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e9:	74 09                	je     8010f4 <strlcpy+0x3c>
  8010eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	84 c0                	test   %al,%al
  8010f2:	75 d8                	jne    8010cc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8010fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801100:	29 c2                	sub    %eax,%edx
  801102:	89 d0                	mov    %edx,%eax
}
  801104:	c9                   	leave  
  801105:	c3                   	ret    

00801106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801106:	55                   	push   %ebp
  801107:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801109:	eb 06                	jmp    801111 <strcmp+0xb>
		p++, q++;
  80110b:	ff 45 08             	incl   0x8(%ebp)
  80110e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	84 c0                	test   %al,%al
  801118:	74 0e                	je     801128 <strcmp+0x22>
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	8a 10                	mov    (%eax),%dl
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	8a 00                	mov    (%eax),%al
  801124:	38 c2                	cmp    %al,%dl
  801126:	74 e3                	je     80110b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	8a 00                	mov    (%eax),%al
  80112d:	0f b6 d0             	movzbl %al,%edx
  801130:	8b 45 0c             	mov    0xc(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	0f b6 c0             	movzbl %al,%eax
  801138:	29 c2                	sub    %eax,%edx
  80113a:	89 d0                	mov    %edx,%eax
}
  80113c:	5d                   	pop    %ebp
  80113d:	c3                   	ret    

0080113e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80113e:	55                   	push   %ebp
  80113f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801141:	eb 09                	jmp    80114c <strncmp+0xe>
		n--, p++, q++;
  801143:	ff 4d 10             	decl   0x10(%ebp)
  801146:	ff 45 08             	incl   0x8(%ebp)
  801149:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80114c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801150:	74 17                	je     801169 <strncmp+0x2b>
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	8a 00                	mov    (%eax),%al
  801157:	84 c0                	test   %al,%al
  801159:	74 0e                	je     801169 <strncmp+0x2b>
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 10                	mov    (%eax),%dl
  801160:	8b 45 0c             	mov    0xc(%ebp),%eax
  801163:	8a 00                	mov    (%eax),%al
  801165:	38 c2                	cmp    %al,%dl
  801167:	74 da                	je     801143 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801169:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80116d:	75 07                	jne    801176 <strncmp+0x38>
		return 0;
  80116f:	b8 00 00 00 00       	mov    $0x0,%eax
  801174:	eb 14                	jmp    80118a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	8a 00                	mov    (%eax),%al
  80117b:	0f b6 d0             	movzbl %al,%edx
  80117e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801181:	8a 00                	mov    (%eax),%al
  801183:	0f b6 c0             	movzbl %al,%eax
  801186:	29 c2                	sub    %eax,%edx
  801188:	89 d0                	mov    %edx,%eax
}
  80118a:	5d                   	pop    %ebp
  80118b:	c3                   	ret    

0080118c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80118c:	55                   	push   %ebp
  80118d:	89 e5                	mov    %esp,%ebp
  80118f:	83 ec 04             	sub    $0x4,%esp
  801192:	8b 45 0c             	mov    0xc(%ebp),%eax
  801195:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801198:	eb 12                	jmp    8011ac <strchr+0x20>
		if (*s == c)
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a2:	75 05                	jne    8011a9 <strchr+0x1d>
			return (char *) s;
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	eb 11                	jmp    8011ba <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011a9:	ff 45 08             	incl   0x8(%ebp)
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	84 c0                	test   %al,%al
  8011b3:	75 e5                	jne    80119a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
  8011bf:	83 ec 04             	sub    $0x4,%esp
  8011c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c8:	eb 0d                	jmp    8011d7 <strfind+0x1b>
		if (*s == c)
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d2:	74 0e                	je     8011e2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011d4:	ff 45 08             	incl   0x8(%ebp)
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	8a 00                	mov    (%eax),%al
  8011dc:	84 c0                	test   %al,%al
  8011de:	75 ea                	jne    8011ca <strfind+0xe>
  8011e0:	eb 01                	jmp    8011e3 <strfind+0x27>
		if (*s == c)
			break;
  8011e2:	90                   	nop
	return (char *) s;
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e6:	c9                   	leave  
  8011e7:	c3                   	ret    

008011e8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011e8:	55                   	push   %ebp
  8011e9:	89 e5                	mov    %esp,%ebp
  8011eb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011fa:	eb 0e                	jmp    80120a <memset+0x22>
		*p++ = c;
  8011fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ff:	8d 50 01             	lea    0x1(%eax),%edx
  801202:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801205:	8b 55 0c             	mov    0xc(%ebp),%edx
  801208:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80120a:	ff 4d f8             	decl   -0x8(%ebp)
  80120d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801211:	79 e9                	jns    8011fc <memset+0x14>
		*p++ = c;

	return v;
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
  80121b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80122a:	eb 16                	jmp    801242 <memcpy+0x2a>
		*d++ = *s++;
  80122c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122f:	8d 50 01             	lea    0x1(%eax),%edx
  801232:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801235:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801238:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80123e:	8a 12                	mov    (%edx),%dl
  801240:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801242:	8b 45 10             	mov    0x10(%ebp),%eax
  801245:	8d 50 ff             	lea    -0x1(%eax),%edx
  801248:	89 55 10             	mov    %edx,0x10(%ebp)
  80124b:	85 c0                	test   %eax,%eax
  80124d:	75 dd                	jne    80122c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
  801257:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80125a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801266:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801269:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80126c:	73 50                	jae    8012be <memmove+0x6a>
  80126e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801271:	8b 45 10             	mov    0x10(%ebp),%eax
  801274:	01 d0                	add    %edx,%eax
  801276:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801279:	76 43                	jbe    8012be <memmove+0x6a>
		s += n;
  80127b:	8b 45 10             	mov    0x10(%ebp),%eax
  80127e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801287:	eb 10                	jmp    801299 <memmove+0x45>
			*--d = *--s;
  801289:	ff 4d f8             	decl   -0x8(%ebp)
  80128c:	ff 4d fc             	decl   -0x4(%ebp)
  80128f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801292:	8a 10                	mov    (%eax),%dl
  801294:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801297:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801299:	8b 45 10             	mov    0x10(%ebp),%eax
  80129c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80129f:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a2:	85 c0                	test   %eax,%eax
  8012a4:	75 e3                	jne    801289 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a6:	eb 23                	jmp    8012cb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ab:	8d 50 01             	lea    0x1(%eax),%edx
  8012ae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ba:	8a 12                	mov    (%edx),%dl
  8012bc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012be:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c4:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c7:	85 c0                	test   %eax,%eax
  8012c9:	75 dd                	jne    8012a8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012df:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012e2:	eb 2a                	jmp    80130e <memcmp+0x3e>
		if (*s1 != *s2)
  8012e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e7:	8a 10                	mov    (%eax),%dl
  8012e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	38 c2                	cmp    %al,%dl
  8012f0:	74 16                	je     801308 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f5:	8a 00                	mov    (%eax),%al
  8012f7:	0f b6 d0             	movzbl %al,%edx
  8012fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	0f b6 c0             	movzbl %al,%eax
  801302:	29 c2                	sub    %eax,%edx
  801304:	89 d0                	mov    %edx,%eax
  801306:	eb 18                	jmp    801320 <memcmp+0x50>
		s1++, s2++;
  801308:	ff 45 fc             	incl   -0x4(%ebp)
  80130b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80130e:	8b 45 10             	mov    0x10(%ebp),%eax
  801311:	8d 50 ff             	lea    -0x1(%eax),%edx
  801314:	89 55 10             	mov    %edx,0x10(%ebp)
  801317:	85 c0                	test   %eax,%eax
  801319:	75 c9                	jne    8012e4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80131b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
  801325:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801328:	8b 55 08             	mov    0x8(%ebp),%edx
  80132b:	8b 45 10             	mov    0x10(%ebp),%eax
  80132e:	01 d0                	add    %edx,%eax
  801330:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801333:	eb 15                	jmp    80134a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	8a 00                	mov    (%eax),%al
  80133a:	0f b6 d0             	movzbl %al,%edx
  80133d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801340:	0f b6 c0             	movzbl %al,%eax
  801343:	39 c2                	cmp    %eax,%edx
  801345:	74 0d                	je     801354 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801347:	ff 45 08             	incl   0x8(%ebp)
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801350:	72 e3                	jb     801335 <memfind+0x13>
  801352:	eb 01                	jmp    801355 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801354:	90                   	nop
	return (void *) s;
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
  80135d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801360:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801367:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80136e:	eb 03                	jmp    801373 <strtol+0x19>
		s++;
  801370:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	3c 20                	cmp    $0x20,%al
  80137a:	74 f4                	je     801370 <strtol+0x16>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	3c 09                	cmp    $0x9,%al
  801383:	74 eb                	je     801370 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	3c 2b                	cmp    $0x2b,%al
  80138c:	75 05                	jne    801393 <strtol+0x39>
		s++;
  80138e:	ff 45 08             	incl   0x8(%ebp)
  801391:	eb 13                	jmp    8013a6 <strtol+0x4c>
	else if (*s == '-')
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	8a 00                	mov    (%eax),%al
  801398:	3c 2d                	cmp    $0x2d,%al
  80139a:	75 0a                	jne    8013a6 <strtol+0x4c>
		s++, neg = 1;
  80139c:	ff 45 08             	incl   0x8(%ebp)
  80139f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013aa:	74 06                	je     8013b2 <strtol+0x58>
  8013ac:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013b0:	75 20                	jne    8013d2 <strtol+0x78>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	3c 30                	cmp    $0x30,%al
  8013b9:	75 17                	jne    8013d2 <strtol+0x78>
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	40                   	inc    %eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	3c 78                	cmp    $0x78,%al
  8013c3:	75 0d                	jne    8013d2 <strtol+0x78>
		s += 2, base = 16;
  8013c5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013c9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013d0:	eb 28                	jmp    8013fa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d6:	75 15                	jne    8013ed <strtol+0x93>
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	3c 30                	cmp    $0x30,%al
  8013df:	75 0c                	jne    8013ed <strtol+0x93>
		s++, base = 8;
  8013e1:	ff 45 08             	incl   0x8(%ebp)
  8013e4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013eb:	eb 0d                	jmp    8013fa <strtol+0xa0>
	else if (base == 0)
  8013ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f1:	75 07                	jne    8013fa <strtol+0xa0>
		base = 10;
  8013f3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	3c 2f                	cmp    $0x2f,%al
  801401:	7e 19                	jle    80141c <strtol+0xc2>
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	3c 39                	cmp    $0x39,%al
  80140a:	7f 10                	jg     80141c <strtol+0xc2>
			dig = *s - '0';
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	0f be c0             	movsbl %al,%eax
  801414:	83 e8 30             	sub    $0x30,%eax
  801417:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80141a:	eb 42                	jmp    80145e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	3c 60                	cmp    $0x60,%al
  801423:	7e 19                	jle    80143e <strtol+0xe4>
  801425:	8b 45 08             	mov    0x8(%ebp),%eax
  801428:	8a 00                	mov    (%eax),%al
  80142a:	3c 7a                	cmp    $0x7a,%al
  80142c:	7f 10                	jg     80143e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80142e:	8b 45 08             	mov    0x8(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	0f be c0             	movsbl %al,%eax
  801436:	83 e8 57             	sub    $0x57,%eax
  801439:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143c:	eb 20                	jmp    80145e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	3c 40                	cmp    $0x40,%al
  801445:	7e 39                	jle    801480 <strtol+0x126>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	3c 5a                	cmp    $0x5a,%al
  80144e:	7f 30                	jg     801480 <strtol+0x126>
			dig = *s - 'A' + 10;
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	0f be c0             	movsbl %al,%eax
  801458:	83 e8 37             	sub    $0x37,%eax
  80145b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80145e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801461:	3b 45 10             	cmp    0x10(%ebp),%eax
  801464:	7d 19                	jge    80147f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801466:	ff 45 08             	incl   0x8(%ebp)
  801469:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801470:	89 c2                	mov    %eax,%edx
  801472:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801475:	01 d0                	add    %edx,%eax
  801477:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80147a:	e9 7b ff ff ff       	jmp    8013fa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80147f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801480:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801484:	74 08                	je     80148e <strtol+0x134>
		*endptr = (char *) s;
  801486:	8b 45 0c             	mov    0xc(%ebp),%eax
  801489:	8b 55 08             	mov    0x8(%ebp),%edx
  80148c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80148e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801492:	74 07                	je     80149b <strtol+0x141>
  801494:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801497:	f7 d8                	neg    %eax
  801499:	eb 03                	jmp    80149e <strtol+0x144>
  80149b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80149e:	c9                   	leave  
  80149f:	c3                   	ret    

008014a0 <ltostr>:

void
ltostr(long value, char *str)
{
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
  8014a3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014ad:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014b4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014b8:	79 13                	jns    8014cd <ltostr+0x2d>
	{
		neg = 1;
  8014ba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014c7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014ca:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d5:	99                   	cltd   
  8014d6:	f7 f9                	idiv   %ecx
  8014d8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014db:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014de:	8d 50 01             	lea    0x1(%eax),%edx
  8014e1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e4:	89 c2                	mov    %eax,%edx
  8014e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e9:	01 d0                	add    %edx,%eax
  8014eb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014ee:	83 c2 30             	add    $0x30,%edx
  8014f1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014fb:	f7 e9                	imul   %ecx
  8014fd:	c1 fa 02             	sar    $0x2,%edx
  801500:	89 c8                	mov    %ecx,%eax
  801502:	c1 f8 1f             	sar    $0x1f,%eax
  801505:	29 c2                	sub    %eax,%edx
  801507:	89 d0                	mov    %edx,%eax
  801509:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80150c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801514:	f7 e9                	imul   %ecx
  801516:	c1 fa 02             	sar    $0x2,%edx
  801519:	89 c8                	mov    %ecx,%eax
  80151b:	c1 f8 1f             	sar    $0x1f,%eax
  80151e:	29 c2                	sub    %eax,%edx
  801520:	89 d0                	mov    %edx,%eax
  801522:	c1 e0 02             	shl    $0x2,%eax
  801525:	01 d0                	add    %edx,%eax
  801527:	01 c0                	add    %eax,%eax
  801529:	29 c1                	sub    %eax,%ecx
  80152b:	89 ca                	mov    %ecx,%edx
  80152d:	85 d2                	test   %edx,%edx
  80152f:	75 9c                	jne    8014cd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801531:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801538:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153b:	48                   	dec    %eax
  80153c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80153f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801543:	74 3d                	je     801582 <ltostr+0xe2>
		start = 1 ;
  801545:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80154c:	eb 34                	jmp    801582 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80154e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801551:	8b 45 0c             	mov    0xc(%ebp),%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	8a 00                	mov    (%eax),%al
  801558:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80155b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801561:	01 c2                	add    %eax,%edx
  801563:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801566:	8b 45 0c             	mov    0xc(%ebp),%eax
  801569:	01 c8                	add    %ecx,%eax
  80156b:	8a 00                	mov    (%eax),%al
  80156d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80156f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	01 c2                	add    %eax,%edx
  801577:	8a 45 eb             	mov    -0x15(%ebp),%al
  80157a:	88 02                	mov    %al,(%edx)
		start++ ;
  80157c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80157f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801582:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801585:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801588:	7c c4                	jl     80154e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80158a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80158d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801590:	01 d0                	add    %edx,%eax
  801592:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801595:	90                   	nop
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80159e:	ff 75 08             	pushl  0x8(%ebp)
  8015a1:	e8 54 fa ff ff       	call   800ffa <strlen>
  8015a6:	83 c4 04             	add    $0x4,%esp
  8015a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015ac:	ff 75 0c             	pushl  0xc(%ebp)
  8015af:	e8 46 fa ff ff       	call   800ffa <strlen>
  8015b4:	83 c4 04             	add    $0x4,%esp
  8015b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c8:	eb 17                	jmp    8015e1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d0:	01 c2                	add    %eax,%edx
  8015d2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	01 c8                	add    %ecx,%eax
  8015da:	8a 00                	mov    (%eax),%al
  8015dc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015de:	ff 45 fc             	incl   -0x4(%ebp)
  8015e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015e7:	7c e1                	jl     8015ca <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015f7:	eb 1f                	jmp    801618 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015fc:	8d 50 01             	lea    0x1(%eax),%edx
  8015ff:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801602:	89 c2                	mov    %eax,%edx
  801604:	8b 45 10             	mov    0x10(%ebp),%eax
  801607:	01 c2                	add    %eax,%edx
  801609:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80160c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160f:	01 c8                	add    %ecx,%eax
  801611:	8a 00                	mov    (%eax),%al
  801613:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801615:	ff 45 f8             	incl   -0x8(%ebp)
  801618:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80161e:	7c d9                	jl     8015f9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801620:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801623:	8b 45 10             	mov    0x10(%ebp),%eax
  801626:	01 d0                	add    %edx,%eax
  801628:	c6 00 00             	movb   $0x0,(%eax)
}
  80162b:	90                   	nop
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801631:	8b 45 14             	mov    0x14(%ebp),%eax
  801634:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80163a:	8b 45 14             	mov    0x14(%ebp),%eax
  80163d:	8b 00                	mov    (%eax),%eax
  80163f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801646:	8b 45 10             	mov    0x10(%ebp),%eax
  801649:	01 d0                	add    %edx,%eax
  80164b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801651:	eb 0c                	jmp    80165f <strsplit+0x31>
			*string++ = 0;
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8d 50 01             	lea    0x1(%eax),%edx
  801659:	89 55 08             	mov    %edx,0x8(%ebp)
  80165c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	84 c0                	test   %al,%al
  801666:	74 18                	je     801680 <strsplit+0x52>
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	0f be c0             	movsbl %al,%eax
  801670:	50                   	push   %eax
  801671:	ff 75 0c             	pushl  0xc(%ebp)
  801674:	e8 13 fb ff ff       	call   80118c <strchr>
  801679:	83 c4 08             	add    $0x8,%esp
  80167c:	85 c0                	test   %eax,%eax
  80167e:	75 d3                	jne    801653 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	84 c0                	test   %al,%al
  801687:	74 5a                	je     8016e3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801689:	8b 45 14             	mov    0x14(%ebp),%eax
  80168c:	8b 00                	mov    (%eax),%eax
  80168e:	83 f8 0f             	cmp    $0xf,%eax
  801691:	75 07                	jne    80169a <strsplit+0x6c>
		{
			return 0;
  801693:	b8 00 00 00 00       	mov    $0x0,%eax
  801698:	eb 66                	jmp    801700 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80169a:	8b 45 14             	mov    0x14(%ebp),%eax
  80169d:	8b 00                	mov    (%eax),%eax
  80169f:	8d 48 01             	lea    0x1(%eax),%ecx
  8016a2:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a5:	89 0a                	mov    %ecx,(%edx)
  8016a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b1:	01 c2                	add    %eax,%edx
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b8:	eb 03                	jmp    8016bd <strsplit+0x8f>
			string++;
  8016ba:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	84 c0                	test   %al,%al
  8016c4:	74 8b                	je     801651 <strsplit+0x23>
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	8a 00                	mov    (%eax),%al
  8016cb:	0f be c0             	movsbl %al,%eax
  8016ce:	50                   	push   %eax
  8016cf:	ff 75 0c             	pushl  0xc(%ebp)
  8016d2:	e8 b5 fa ff ff       	call   80118c <strchr>
  8016d7:	83 c4 08             	add    $0x8,%esp
  8016da:	85 c0                	test   %eax,%eax
  8016dc:	74 dc                	je     8016ba <strsplit+0x8c>
			string++;
	}
  8016de:	e9 6e ff ff ff       	jmp    801651 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016e3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f3:	01 d0                	add    %edx,%eax
  8016f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	57                   	push   %edi
  801706:	56                   	push   %esi
  801707:	53                   	push   %ebx
  801708:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801711:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801714:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801717:	8b 7d 18             	mov    0x18(%ebp),%edi
  80171a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80171d:	cd 30                	int    $0x30
  80171f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801722:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801725:	83 c4 10             	add    $0x10,%esp
  801728:	5b                   	pop    %ebx
  801729:	5e                   	pop    %esi
  80172a:	5f                   	pop    %edi
  80172b:	5d                   	pop    %ebp
  80172c:	c3                   	ret    

0080172d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
  801730:	83 ec 04             	sub    $0x4,%esp
  801733:	8b 45 10             	mov    0x10(%ebp),%eax
  801736:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801739:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80173d:	8b 45 08             	mov    0x8(%ebp),%eax
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	52                   	push   %edx
  801745:	ff 75 0c             	pushl  0xc(%ebp)
  801748:	50                   	push   %eax
  801749:	6a 00                	push   $0x0
  80174b:	e8 b2 ff ff ff       	call   801702 <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	90                   	nop
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_cgetc>:

int
sys_cgetc(void)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 01                	push   $0x1
  801765:	e8 98 ff ff ff       	call   801702 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	50                   	push   %eax
  80177e:	6a 05                	push   $0x5
  801780:	e8 7d ff ff ff       	call   801702 <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 02                	push   $0x2
  801799:	e8 64 ff ff ff       	call   801702 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 03                	push   $0x3
  8017b2:	e8 4b ff ff ff       	call   801702 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 04                	push   $0x4
  8017cb:	e8 32 ff ff ff       	call   801702 <syscall>
  8017d0:	83 c4 18             	add    $0x18,%esp
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_env_exit>:


void sys_env_exit(void)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 06                	push   $0x6
  8017e4:	e8 19 ff ff ff       	call   801702 <syscall>
  8017e9:	83 c4 18             	add    $0x18,%esp
}
  8017ec:	90                   	nop
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	52                   	push   %edx
  8017ff:	50                   	push   %eax
  801800:	6a 07                	push   $0x7
  801802:	e8 fb fe ff ff       	call   801702 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	56                   	push   %esi
  801810:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801811:	8b 75 18             	mov    0x18(%ebp),%esi
  801814:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801817:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	56                   	push   %esi
  801821:	53                   	push   %ebx
  801822:	51                   	push   %ecx
  801823:	52                   	push   %edx
  801824:	50                   	push   %eax
  801825:	6a 08                	push   $0x8
  801827:	e8 d6 fe ff ff       	call   801702 <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
}
  80182f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801832:	5b                   	pop    %ebx
  801833:	5e                   	pop    %esi
  801834:	5d                   	pop    %ebp
  801835:	c3                   	ret    

00801836 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801839:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	52                   	push   %edx
  801846:	50                   	push   %eax
  801847:	6a 09                	push   $0x9
  801849:	e8 b4 fe ff ff       	call   801702 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	ff 75 0c             	pushl  0xc(%ebp)
  80185f:	ff 75 08             	pushl  0x8(%ebp)
  801862:	6a 0a                	push   $0xa
  801864:	e8 99 fe ff ff       	call   801702 <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
}
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 0b                	push   $0xb
  80187d:	e8 80 fe ff ff       	call   801702 <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 0c                	push   $0xc
  801896:	e8 67 fe ff ff       	call   801702 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 0d                	push   $0xd
  8018af:	e8 4e fe ff ff       	call   801702 <syscall>
  8018b4:	83 c4 18             	add    $0x18,%esp
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	ff 75 0c             	pushl  0xc(%ebp)
  8018c5:	ff 75 08             	pushl  0x8(%ebp)
  8018c8:	6a 11                	push   $0x11
  8018ca:	e8 33 fe ff ff       	call   801702 <syscall>
  8018cf:	83 c4 18             	add    $0x18,%esp
	return;
  8018d2:	90                   	nop
}
  8018d3:	c9                   	leave  
  8018d4:	c3                   	ret    

008018d5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018d5:	55                   	push   %ebp
  8018d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	ff 75 0c             	pushl  0xc(%ebp)
  8018e1:	ff 75 08             	pushl  0x8(%ebp)
  8018e4:	6a 12                	push   $0x12
  8018e6:	e8 17 fe ff ff       	call   801702 <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ee:	90                   	nop
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 0e                	push   $0xe
  801900:	e8 fd fd ff ff       	call   801702 <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
}
  801908:	c9                   	leave  
  801909:	c3                   	ret    

0080190a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80190a:	55                   	push   %ebp
  80190b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	ff 75 08             	pushl  0x8(%ebp)
  801918:	6a 0f                	push   $0xf
  80191a:	e8 e3 fd ff ff       	call   801702 <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	c9                   	leave  
  801923:	c3                   	ret    

00801924 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 10                	push   $0x10
  801933:	e8 ca fd ff ff       	call   801702 <syscall>
  801938:	83 c4 18             	add    $0x18,%esp
}
  80193b:	90                   	nop
  80193c:	c9                   	leave  
  80193d:	c3                   	ret    

0080193e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 14                	push   $0x14
  80194d:	e8 b0 fd ff ff       	call   801702 <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	90                   	nop
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 15                	push   $0x15
  801967:	e8 96 fd ff ff       	call   801702 <syscall>
  80196c:	83 c4 18             	add    $0x18,%esp
}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_cputc>:


void
sys_cputc(const char c)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
  801975:	83 ec 04             	sub    $0x4,%esp
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80197e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	50                   	push   %eax
  80198b:	6a 16                	push   $0x16
  80198d:	e8 70 fd ff ff       	call   801702 <syscall>
  801992:	83 c4 18             	add    $0x18,%esp
}
  801995:	90                   	nop
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 17                	push   $0x17
  8019a7:	e8 56 fd ff ff       	call   801702 <syscall>
  8019ac:	83 c4 18             	add    $0x18,%esp
}
  8019af:	90                   	nop
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	ff 75 0c             	pushl  0xc(%ebp)
  8019c1:	50                   	push   %eax
  8019c2:	6a 18                	push   $0x18
  8019c4:	e8 39 fd ff ff       	call   801702 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	52                   	push   %edx
  8019de:	50                   	push   %eax
  8019df:	6a 1b                	push   $0x1b
  8019e1:	e8 1c fd ff ff       	call   801702 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	52                   	push   %edx
  8019fb:	50                   	push   %eax
  8019fc:	6a 19                	push   $0x19
  8019fe:	e8 ff fc ff ff       	call   801702 <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
}
  801a06:	90                   	nop
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	52                   	push   %edx
  801a19:	50                   	push   %eax
  801a1a:	6a 1a                	push   $0x1a
  801a1c:	e8 e1 fc ff ff       	call   801702 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	90                   	nop
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
  801a2a:	83 ec 04             	sub    $0x4,%esp
  801a2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a30:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a33:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a36:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3d:	6a 00                	push   $0x0
  801a3f:	51                   	push   %ecx
  801a40:	52                   	push   %edx
  801a41:	ff 75 0c             	pushl  0xc(%ebp)
  801a44:	50                   	push   %eax
  801a45:	6a 1c                	push   $0x1c
  801a47:	e8 b6 fc ff ff       	call   801702 <syscall>
  801a4c:	83 c4 18             	add    $0x18,%esp
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a57:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	52                   	push   %edx
  801a61:	50                   	push   %eax
  801a62:	6a 1d                	push   $0x1d
  801a64:	e8 99 fc ff ff       	call   801702 <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
}
  801a6c:	c9                   	leave  
  801a6d:	c3                   	ret    

00801a6e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a6e:	55                   	push   %ebp
  801a6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a71:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a74:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a77:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	51                   	push   %ecx
  801a7f:	52                   	push   %edx
  801a80:	50                   	push   %eax
  801a81:	6a 1e                	push   $0x1e
  801a83:	e8 7a fc ff ff       	call   801702 <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	52                   	push   %edx
  801a9d:	50                   	push   %eax
  801a9e:	6a 1f                	push   $0x1f
  801aa0:	e8 5d fc ff ff       	call   801702 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 20                	push   $0x20
  801ab9:	e8 44 fc ff ff       	call   801702 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	ff 75 10             	pushl  0x10(%ebp)
  801ad0:	ff 75 0c             	pushl  0xc(%ebp)
  801ad3:	50                   	push   %eax
  801ad4:	6a 21                	push   $0x21
  801ad6:	e8 27 fc ff ff       	call   801702 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	50                   	push   %eax
  801aef:	6a 22                	push   $0x22
  801af1:	e8 0c fc ff ff       	call   801702 <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	90                   	nop
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aff:	8b 45 08             	mov    0x8(%ebp),%eax
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	50                   	push   %eax
  801b0b:	6a 23                	push   $0x23
  801b0d:	e8 f0 fb ff ff       	call   801702 <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	90                   	nop
  801b16:	c9                   	leave  
  801b17:	c3                   	ret    

00801b18 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b18:	55                   	push   %ebp
  801b19:	89 e5                	mov    %esp,%ebp
  801b1b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b1e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b21:	8d 50 04             	lea    0x4(%eax),%edx
  801b24:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	52                   	push   %edx
  801b2e:	50                   	push   %eax
  801b2f:	6a 24                	push   $0x24
  801b31:	e8 cc fb ff ff       	call   801702 <syscall>
  801b36:	83 c4 18             	add    $0x18,%esp
	return result;
  801b39:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b42:	89 01                	mov    %eax,(%ecx)
  801b44:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b47:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4a:	c9                   	leave  
  801b4b:	c2 04 00             	ret    $0x4

00801b4e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	ff 75 10             	pushl  0x10(%ebp)
  801b58:	ff 75 0c             	pushl  0xc(%ebp)
  801b5b:	ff 75 08             	pushl  0x8(%ebp)
  801b5e:	6a 13                	push   $0x13
  801b60:	e8 9d fb ff ff       	call   801702 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
	return ;
  801b68:	90                   	nop
}
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <sys_rcr2>:
uint32 sys_rcr2()
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 25                	push   $0x25
  801b7a:	e8 83 fb ff ff       	call   801702 <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
}
  801b82:	c9                   	leave  
  801b83:	c3                   	ret    

00801b84 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
  801b87:	83 ec 04             	sub    $0x4,%esp
  801b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b90:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	50                   	push   %eax
  801b9d:	6a 26                	push   $0x26
  801b9f:	e8 5e fb ff ff       	call   801702 <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba7:	90                   	nop
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <rsttst>:
void rsttst()
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 28                	push   $0x28
  801bb9:	e8 44 fb ff ff       	call   801702 <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc1:	90                   	nop
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
  801bc7:	83 ec 04             	sub    $0x4,%esp
  801bca:	8b 45 14             	mov    0x14(%ebp),%eax
  801bcd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bd0:	8b 55 18             	mov    0x18(%ebp),%edx
  801bd3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd7:	52                   	push   %edx
  801bd8:	50                   	push   %eax
  801bd9:	ff 75 10             	pushl  0x10(%ebp)
  801bdc:	ff 75 0c             	pushl  0xc(%ebp)
  801bdf:	ff 75 08             	pushl  0x8(%ebp)
  801be2:	6a 27                	push   $0x27
  801be4:	e8 19 fb ff ff       	call   801702 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bec:	90                   	nop
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <chktst>:
void chktst(uint32 n)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	ff 75 08             	pushl  0x8(%ebp)
  801bfd:	6a 29                	push   $0x29
  801bff:	e8 fe fa ff ff       	call   801702 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
	return ;
  801c07:	90                   	nop
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <inctst>:

void inctst()
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 2a                	push   $0x2a
  801c19:	e8 e4 fa ff ff       	call   801702 <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801c21:	90                   	nop
}
  801c22:	c9                   	leave  
  801c23:	c3                   	ret    

00801c24 <gettst>:
uint32 gettst()
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 2b                	push   $0x2b
  801c33:	e8 ca fa ff ff       	call   801702 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
  801c40:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 2c                	push   $0x2c
  801c4f:	e8 ae fa ff ff       	call   801702 <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
  801c57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c5a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c5e:	75 07                	jne    801c67 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c60:	b8 01 00 00 00       	mov    $0x1,%eax
  801c65:	eb 05                	jmp    801c6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6c:	c9                   	leave  
  801c6d:	c3                   	ret    

00801c6e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
  801c71:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 2c                	push   $0x2c
  801c80:	e8 7d fa ff ff       	call   801702 <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
  801c88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c8b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c8f:	75 07                	jne    801c98 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c91:	b8 01 00 00 00       	mov    $0x1,%eax
  801c96:	eb 05                	jmp    801c9d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c98:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
  801ca2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 2c                	push   $0x2c
  801cb1:	e8 4c fa ff ff       	call   801702 <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
  801cb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cbc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cc0:	75 07                	jne    801cc9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc2:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc7:	eb 05                	jmp    801cce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
  801cd3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 2c                	push   $0x2c
  801ce2:	e8 1b fa ff ff       	call   801702 <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
  801cea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ced:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf1:	75 07                	jne    801cfa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cf3:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf8:	eb 05                	jmp    801cff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cff:	c9                   	leave  
  801d00:	c3                   	ret    

00801d01 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d01:	55                   	push   %ebp
  801d02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	ff 75 08             	pushl  0x8(%ebp)
  801d0f:	6a 2d                	push   $0x2d
  801d11:	e8 ec f9 ff ff       	call   801702 <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
	return ;
  801d19:	90                   	nop
}
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <__udivdi3>:
  801d1c:	55                   	push   %ebp
  801d1d:	57                   	push   %edi
  801d1e:	56                   	push   %esi
  801d1f:	53                   	push   %ebx
  801d20:	83 ec 1c             	sub    $0x1c,%esp
  801d23:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d27:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d2f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d33:	89 ca                	mov    %ecx,%edx
  801d35:	89 f8                	mov    %edi,%eax
  801d37:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d3b:	85 f6                	test   %esi,%esi
  801d3d:	75 2d                	jne    801d6c <__udivdi3+0x50>
  801d3f:	39 cf                	cmp    %ecx,%edi
  801d41:	77 65                	ja     801da8 <__udivdi3+0x8c>
  801d43:	89 fd                	mov    %edi,%ebp
  801d45:	85 ff                	test   %edi,%edi
  801d47:	75 0b                	jne    801d54 <__udivdi3+0x38>
  801d49:	b8 01 00 00 00       	mov    $0x1,%eax
  801d4e:	31 d2                	xor    %edx,%edx
  801d50:	f7 f7                	div    %edi
  801d52:	89 c5                	mov    %eax,%ebp
  801d54:	31 d2                	xor    %edx,%edx
  801d56:	89 c8                	mov    %ecx,%eax
  801d58:	f7 f5                	div    %ebp
  801d5a:	89 c1                	mov    %eax,%ecx
  801d5c:	89 d8                	mov    %ebx,%eax
  801d5e:	f7 f5                	div    %ebp
  801d60:	89 cf                	mov    %ecx,%edi
  801d62:	89 fa                	mov    %edi,%edx
  801d64:	83 c4 1c             	add    $0x1c,%esp
  801d67:	5b                   	pop    %ebx
  801d68:	5e                   	pop    %esi
  801d69:	5f                   	pop    %edi
  801d6a:	5d                   	pop    %ebp
  801d6b:	c3                   	ret    
  801d6c:	39 ce                	cmp    %ecx,%esi
  801d6e:	77 28                	ja     801d98 <__udivdi3+0x7c>
  801d70:	0f bd fe             	bsr    %esi,%edi
  801d73:	83 f7 1f             	xor    $0x1f,%edi
  801d76:	75 40                	jne    801db8 <__udivdi3+0x9c>
  801d78:	39 ce                	cmp    %ecx,%esi
  801d7a:	72 0a                	jb     801d86 <__udivdi3+0x6a>
  801d7c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d80:	0f 87 9e 00 00 00    	ja     801e24 <__udivdi3+0x108>
  801d86:	b8 01 00 00 00       	mov    $0x1,%eax
  801d8b:	89 fa                	mov    %edi,%edx
  801d8d:	83 c4 1c             	add    $0x1c,%esp
  801d90:	5b                   	pop    %ebx
  801d91:	5e                   	pop    %esi
  801d92:	5f                   	pop    %edi
  801d93:	5d                   	pop    %ebp
  801d94:	c3                   	ret    
  801d95:	8d 76 00             	lea    0x0(%esi),%esi
  801d98:	31 ff                	xor    %edi,%edi
  801d9a:	31 c0                	xor    %eax,%eax
  801d9c:	89 fa                	mov    %edi,%edx
  801d9e:	83 c4 1c             	add    $0x1c,%esp
  801da1:	5b                   	pop    %ebx
  801da2:	5e                   	pop    %esi
  801da3:	5f                   	pop    %edi
  801da4:	5d                   	pop    %ebp
  801da5:	c3                   	ret    
  801da6:	66 90                	xchg   %ax,%ax
  801da8:	89 d8                	mov    %ebx,%eax
  801daa:	f7 f7                	div    %edi
  801dac:	31 ff                	xor    %edi,%edi
  801dae:	89 fa                	mov    %edi,%edx
  801db0:	83 c4 1c             	add    $0x1c,%esp
  801db3:	5b                   	pop    %ebx
  801db4:	5e                   	pop    %esi
  801db5:	5f                   	pop    %edi
  801db6:	5d                   	pop    %ebp
  801db7:	c3                   	ret    
  801db8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dbd:	89 eb                	mov    %ebp,%ebx
  801dbf:	29 fb                	sub    %edi,%ebx
  801dc1:	89 f9                	mov    %edi,%ecx
  801dc3:	d3 e6                	shl    %cl,%esi
  801dc5:	89 c5                	mov    %eax,%ebp
  801dc7:	88 d9                	mov    %bl,%cl
  801dc9:	d3 ed                	shr    %cl,%ebp
  801dcb:	89 e9                	mov    %ebp,%ecx
  801dcd:	09 f1                	or     %esi,%ecx
  801dcf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dd3:	89 f9                	mov    %edi,%ecx
  801dd5:	d3 e0                	shl    %cl,%eax
  801dd7:	89 c5                	mov    %eax,%ebp
  801dd9:	89 d6                	mov    %edx,%esi
  801ddb:	88 d9                	mov    %bl,%cl
  801ddd:	d3 ee                	shr    %cl,%esi
  801ddf:	89 f9                	mov    %edi,%ecx
  801de1:	d3 e2                	shl    %cl,%edx
  801de3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801de7:	88 d9                	mov    %bl,%cl
  801de9:	d3 e8                	shr    %cl,%eax
  801deb:	09 c2                	or     %eax,%edx
  801ded:	89 d0                	mov    %edx,%eax
  801def:	89 f2                	mov    %esi,%edx
  801df1:	f7 74 24 0c          	divl   0xc(%esp)
  801df5:	89 d6                	mov    %edx,%esi
  801df7:	89 c3                	mov    %eax,%ebx
  801df9:	f7 e5                	mul    %ebp
  801dfb:	39 d6                	cmp    %edx,%esi
  801dfd:	72 19                	jb     801e18 <__udivdi3+0xfc>
  801dff:	74 0b                	je     801e0c <__udivdi3+0xf0>
  801e01:	89 d8                	mov    %ebx,%eax
  801e03:	31 ff                	xor    %edi,%edi
  801e05:	e9 58 ff ff ff       	jmp    801d62 <__udivdi3+0x46>
  801e0a:	66 90                	xchg   %ax,%ax
  801e0c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e10:	89 f9                	mov    %edi,%ecx
  801e12:	d3 e2                	shl    %cl,%edx
  801e14:	39 c2                	cmp    %eax,%edx
  801e16:	73 e9                	jae    801e01 <__udivdi3+0xe5>
  801e18:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e1b:	31 ff                	xor    %edi,%edi
  801e1d:	e9 40 ff ff ff       	jmp    801d62 <__udivdi3+0x46>
  801e22:	66 90                	xchg   %ax,%ax
  801e24:	31 c0                	xor    %eax,%eax
  801e26:	e9 37 ff ff ff       	jmp    801d62 <__udivdi3+0x46>
  801e2b:	90                   	nop

00801e2c <__umoddi3>:
  801e2c:	55                   	push   %ebp
  801e2d:	57                   	push   %edi
  801e2e:	56                   	push   %esi
  801e2f:	53                   	push   %ebx
  801e30:	83 ec 1c             	sub    $0x1c,%esp
  801e33:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e37:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e3b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e3f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e43:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e47:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e4b:	89 f3                	mov    %esi,%ebx
  801e4d:	89 fa                	mov    %edi,%edx
  801e4f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e53:	89 34 24             	mov    %esi,(%esp)
  801e56:	85 c0                	test   %eax,%eax
  801e58:	75 1a                	jne    801e74 <__umoddi3+0x48>
  801e5a:	39 f7                	cmp    %esi,%edi
  801e5c:	0f 86 a2 00 00 00    	jbe    801f04 <__umoddi3+0xd8>
  801e62:	89 c8                	mov    %ecx,%eax
  801e64:	89 f2                	mov    %esi,%edx
  801e66:	f7 f7                	div    %edi
  801e68:	89 d0                	mov    %edx,%eax
  801e6a:	31 d2                	xor    %edx,%edx
  801e6c:	83 c4 1c             	add    $0x1c,%esp
  801e6f:	5b                   	pop    %ebx
  801e70:	5e                   	pop    %esi
  801e71:	5f                   	pop    %edi
  801e72:	5d                   	pop    %ebp
  801e73:	c3                   	ret    
  801e74:	39 f0                	cmp    %esi,%eax
  801e76:	0f 87 ac 00 00 00    	ja     801f28 <__umoddi3+0xfc>
  801e7c:	0f bd e8             	bsr    %eax,%ebp
  801e7f:	83 f5 1f             	xor    $0x1f,%ebp
  801e82:	0f 84 ac 00 00 00    	je     801f34 <__umoddi3+0x108>
  801e88:	bf 20 00 00 00       	mov    $0x20,%edi
  801e8d:	29 ef                	sub    %ebp,%edi
  801e8f:	89 fe                	mov    %edi,%esi
  801e91:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e95:	89 e9                	mov    %ebp,%ecx
  801e97:	d3 e0                	shl    %cl,%eax
  801e99:	89 d7                	mov    %edx,%edi
  801e9b:	89 f1                	mov    %esi,%ecx
  801e9d:	d3 ef                	shr    %cl,%edi
  801e9f:	09 c7                	or     %eax,%edi
  801ea1:	89 e9                	mov    %ebp,%ecx
  801ea3:	d3 e2                	shl    %cl,%edx
  801ea5:	89 14 24             	mov    %edx,(%esp)
  801ea8:	89 d8                	mov    %ebx,%eax
  801eaa:	d3 e0                	shl    %cl,%eax
  801eac:	89 c2                	mov    %eax,%edx
  801eae:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb2:	d3 e0                	shl    %cl,%eax
  801eb4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801eb8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ebc:	89 f1                	mov    %esi,%ecx
  801ebe:	d3 e8                	shr    %cl,%eax
  801ec0:	09 d0                	or     %edx,%eax
  801ec2:	d3 eb                	shr    %cl,%ebx
  801ec4:	89 da                	mov    %ebx,%edx
  801ec6:	f7 f7                	div    %edi
  801ec8:	89 d3                	mov    %edx,%ebx
  801eca:	f7 24 24             	mull   (%esp)
  801ecd:	89 c6                	mov    %eax,%esi
  801ecf:	89 d1                	mov    %edx,%ecx
  801ed1:	39 d3                	cmp    %edx,%ebx
  801ed3:	0f 82 87 00 00 00    	jb     801f60 <__umoddi3+0x134>
  801ed9:	0f 84 91 00 00 00    	je     801f70 <__umoddi3+0x144>
  801edf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ee3:	29 f2                	sub    %esi,%edx
  801ee5:	19 cb                	sbb    %ecx,%ebx
  801ee7:	89 d8                	mov    %ebx,%eax
  801ee9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801eed:	d3 e0                	shl    %cl,%eax
  801eef:	89 e9                	mov    %ebp,%ecx
  801ef1:	d3 ea                	shr    %cl,%edx
  801ef3:	09 d0                	or     %edx,%eax
  801ef5:	89 e9                	mov    %ebp,%ecx
  801ef7:	d3 eb                	shr    %cl,%ebx
  801ef9:	89 da                	mov    %ebx,%edx
  801efb:	83 c4 1c             	add    $0x1c,%esp
  801efe:	5b                   	pop    %ebx
  801eff:	5e                   	pop    %esi
  801f00:	5f                   	pop    %edi
  801f01:	5d                   	pop    %ebp
  801f02:	c3                   	ret    
  801f03:	90                   	nop
  801f04:	89 fd                	mov    %edi,%ebp
  801f06:	85 ff                	test   %edi,%edi
  801f08:	75 0b                	jne    801f15 <__umoddi3+0xe9>
  801f0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f0f:	31 d2                	xor    %edx,%edx
  801f11:	f7 f7                	div    %edi
  801f13:	89 c5                	mov    %eax,%ebp
  801f15:	89 f0                	mov    %esi,%eax
  801f17:	31 d2                	xor    %edx,%edx
  801f19:	f7 f5                	div    %ebp
  801f1b:	89 c8                	mov    %ecx,%eax
  801f1d:	f7 f5                	div    %ebp
  801f1f:	89 d0                	mov    %edx,%eax
  801f21:	e9 44 ff ff ff       	jmp    801e6a <__umoddi3+0x3e>
  801f26:	66 90                	xchg   %ax,%ax
  801f28:	89 c8                	mov    %ecx,%eax
  801f2a:	89 f2                	mov    %esi,%edx
  801f2c:	83 c4 1c             	add    $0x1c,%esp
  801f2f:	5b                   	pop    %ebx
  801f30:	5e                   	pop    %esi
  801f31:	5f                   	pop    %edi
  801f32:	5d                   	pop    %ebp
  801f33:	c3                   	ret    
  801f34:	3b 04 24             	cmp    (%esp),%eax
  801f37:	72 06                	jb     801f3f <__umoddi3+0x113>
  801f39:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f3d:	77 0f                	ja     801f4e <__umoddi3+0x122>
  801f3f:	89 f2                	mov    %esi,%edx
  801f41:	29 f9                	sub    %edi,%ecx
  801f43:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f47:	89 14 24             	mov    %edx,(%esp)
  801f4a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f4e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f52:	8b 14 24             	mov    (%esp),%edx
  801f55:	83 c4 1c             	add    $0x1c,%esp
  801f58:	5b                   	pop    %ebx
  801f59:	5e                   	pop    %esi
  801f5a:	5f                   	pop    %edi
  801f5b:	5d                   	pop    %ebp
  801f5c:	c3                   	ret    
  801f5d:	8d 76 00             	lea    0x0(%esi),%esi
  801f60:	2b 04 24             	sub    (%esp),%eax
  801f63:	19 fa                	sbb    %edi,%edx
  801f65:	89 d1                	mov    %edx,%ecx
  801f67:	89 c6                	mov    %eax,%esi
  801f69:	e9 71 ff ff ff       	jmp    801edf <__umoddi3+0xb3>
  801f6e:	66 90                	xchg   %ax,%ax
  801f70:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f74:	72 ea                	jb     801f60 <__umoddi3+0x134>
  801f76:	89 d9                	mov    %ebx,%ecx
  801f78:	e9 62 ff ff ff       	jmp    801edf <__umoddi3+0xb3>
