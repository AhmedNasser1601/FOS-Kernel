
obj/user/tst_buffer_2_slave:     file format elf32-i386


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
  800031:	e8 74 06 00 00       	call   8006aa <libmain>
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
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80004e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 40 21 80 00       	push   $0x802140
  800065:	6a 17                	push   $0x17
  800067:	68 88 21 80 00       	push   $0x802188
  80006c:	e8 48 07 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800084:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 40 21 80 00       	push   $0x802140
  80009b:	6a 18                	push   $0x18
  80009d:	68 88 21 80 00       	push   $0x802188
  8000a2:	e8 12 07 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 40 21 80 00       	push   $0x802140
  8000d1:	6a 19                	push   $0x19
  8000d3:	68 88 21 80 00       	push   $0x802188
  8000d8:	e8 dc 06 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 40 21 80 00       	push   $0x802140
  800107:	6a 1a                	push   $0x1a
  800109:	68 88 21 80 00       	push   $0x802188
  80010e:	e8 a6 06 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800126:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 40 21 80 00       	push   $0x802140
  80013d:	6a 1b                	push   $0x1b
  80013f:	68 88 21 80 00       	push   $0x802188
  800144:	e8 70 06 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80015c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 40 21 80 00       	push   $0x802140
  800173:	6a 1c                	push   $0x1c
  800175:	68 88 21 80 00       	push   $0x802188
  80017a:	e8 3a 06 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800192:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 40 21 80 00       	push   $0x802140
  8001a9:	6a 1d                	push   $0x1d
  8001ab:	68 88 21 80 00       	push   $0x802188
  8001b0:	e8 04 06 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001c8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 40 21 80 00       	push   $0x802140
  8001df:	6a 1e                	push   $0x1e
  8001e1:	68 88 21 80 00       	push   $0x802188
  8001e6:	e8 ce 05 00 00       	call   8007b9 <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001fe:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 40 21 80 00       	push   $0x802140
  800215:	6a 20                	push   $0x20
  800217:	68 88 21 80 00       	push   $0x802188
  80021c:	e8 98 05 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800234:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 40 21 80 00       	push   $0x802140
  80024b:	6a 21                	push   $0x21
  80024d:	68 88 21 80 00       	push   $0x802188
  800252:	e8 62 05 00 00       	call   8007b9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80026a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 40 21 80 00       	push   $0x802140
  800281:	6a 22                	push   $0x22
  800283:	68 88 21 80 00       	push   $0x802188
  800288:	e8 2c 05 00 00       	call   8007b9 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 a4 21 80 00       	push   $0x8021a4
  8002a4:	6a 23                	push   $0x23
  8002a6:	68 88 21 80 00       	push   $0x802188
  8002ab:	e8 09 05 00 00       	call   8007b9 <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b0:	e8 c7 16 00 00       	call   80197c <sys_calculate_modified_frames>
  8002b5:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002b8:	e8 d8 16 00 00       	call   801995 <sys_calculate_notmod_frames>
  8002bd:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c0:	e8 21 17 00 00       	call   8019e6 <sys_pf_calculate_allocated_pages>
  8002c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8002f9:	e8 97 16 00 00       	call   801995 <sys_calculate_notmod_frames>
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
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800312:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800319:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800320:	7e c4                	jle    8002e6 <_main+0x2ae>
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}



	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800322:	e8 6e 16 00 00       	call   801995 <sys_calculate_notmod_frames>
  800327:	89 c2                	mov    %eax,%edx
  800329:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80032c:	29 c2                	sub    %eax,%edx
  80032e:	89 d0                	mov    %edx,%eax
  800330:	83 f8 07             	cmp    $0x7,%eax
  800333:	74 14                	je     800349 <_main+0x311>
  800335:	83 ec 04             	sub    $0x4,%esp
  800338:	68 f4 21 80 00       	push   $0x8021f4
  80033d:	6a 37                	push   $0x37
  80033f:	68 88 21 80 00       	push   $0x802188
  800344:	e8 70 04 00 00       	call   8007b9 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800349:	e8 2e 16 00 00       	call   80197c <sys_calculate_modified_frames>
  80034e:	89 c2                	mov    %eax,%edx
  800350:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	74 14                	je     80036b <_main+0x333>
  800357:	83 ec 04             	sub    $0x4,%esp
  80035a:	68 58 22 80 00       	push   $0x802258
  80035f:	6a 38                	push   $0x38
  800361:	68 88 21 80 00       	push   $0x802188
  800366:	e8 4e 04 00 00       	call   8007b9 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036b:	e8 25 16 00 00       	call   801995 <sys_calculate_notmod_frames>
  800370:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800373:	e8 04 16 00 00       	call   80197c <sys_calculate_modified_frames>
  800378:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800398:	e8 f8 15 00 00       	call   801995 <sys_calculate_notmod_frames>
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c1:	e8 cf 15 00 00       	call   801995 <sys_calculate_notmod_frames>
  8003c6:	89 c2                	mov    %eax,%edx
  8003c8:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003cb:	39 c2                	cmp    %eax,%edx
  8003cd:	74 14                	je     8003e3 <_main+0x3ab>
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 f4 21 80 00       	push   $0x8021f4
  8003d7:	6a 47                	push   $0x47
  8003d9:	68 88 21 80 00       	push   $0x802188
  8003de:	e8 d6 03 00 00       	call   8007b9 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e3:	e8 94 15 00 00       	call   80197c <sys_calculate_modified_frames>
  8003e8:	89 c2                	mov    %eax,%edx
  8003ea:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003ed:	29 c2                	sub    %eax,%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	83 f8 07             	cmp    $0x7,%eax
  8003f4:	74 14                	je     80040a <_main+0x3d2>
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	68 58 22 80 00       	push   $0x802258
  8003fe:	6a 48                	push   $0x48
  800400:	68 88 21 80 00       	push   $0x802188
  800405:	e8 af 03 00 00       	call   8007b9 <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040a:	e8 86 15 00 00       	call   801995 <sys_calculate_notmod_frames>
  80040f:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800412:	e8 65 15 00 00       	call   80197c <sys_calculate_modified_frames>
  800417:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80043e:	e8 52 15 00 00       	call   801995 <sys_calculate_notmod_frames>
  800443:	89 c2                	mov    %eax,%edx
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 40 4c             	mov    0x4c(%eax),%eax
  80044d:	01 c2                	add    %eax,%edx
  80044f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800457:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80045e:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800465:	7e ca                	jle    800431 <_main+0x3f9>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800467:	e8 29 15 00 00       	call   801995 <sys_calculate_notmod_frames>
  80046c:	89 c2                	mov    %eax,%edx
  80046e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800471:	29 c2                	sub    %eax,%edx
  800473:	89 d0                	mov    %edx,%eax
  800475:	83 f8 07             	cmp    $0x7,%eax
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 f4 21 80 00       	push   $0x8021f4
  800482:	6a 56                	push   $0x56
  800484:	68 88 21 80 00       	push   $0x802188
  800489:	e8 2b 03 00 00       	call   8007b9 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80048e:	e8 e9 14 00 00       	call   80197c <sys_calculate_modified_frames>
  800493:	89 c2                	mov    %eax,%edx
  800495:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800498:	29 c2                	sub    %eax,%edx
  80049a:	89 d0                	mov    %edx,%eax
  80049c:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 58 22 80 00       	push   $0x802258
  8004a9:	6a 57                	push   $0x57
  8004ab:	68 88 21 80 00       	push   $0x802188
  8004b0:	e8 04 03 00 00       	call   8007b9 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b5:	e8 db 14 00 00       	call   801995 <sys_calculate_notmod_frames>
  8004ba:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004bd:	e8 ba 14 00 00       	call   80197c <sys_calculate_modified_frames>
  8004c2:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004e9:	e8 a7 14 00 00       	call   801995 <sys_calculate_notmod_frames>
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800512:	e8 7e 14 00 00       	call   801995 <sys_calculate_notmod_frames>
  800517:	89 c2                	mov    %eax,%edx
  800519:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80051c:	29 c2                	sub    %eax,%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800523:	74 14                	je     800539 <_main+0x501>
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	68 f4 21 80 00       	push   $0x8021f4
  80052d:	6a 65                	push   $0x65
  80052f:	68 88 21 80 00       	push   $0x802188
  800534:	e8 80 02 00 00       	call   8007b9 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800539:	e8 3e 14 00 00       	call   80197c <sys_calculate_modified_frames>
  80053e:	89 c2                	mov    %eax,%edx
  800540:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800543:	29 c2                	sub    %eax,%edx
  800545:	89 d0                	mov    %edx,%eax
  800547:	83 f8 07             	cmp    $0x7,%eax
  80054a:	74 14                	je     800560 <_main+0x528>
  80054c:	83 ec 04             	sub    $0x4,%esp
  80054f:	68 58 22 80 00       	push   $0x802258
  800554:	6a 66                	push   $0x66
  800556:	68 88 21 80 00       	push   $0x802188
  80055b:	e8 59 02 00 00       	call   8007b9 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800560:	e8 81 14 00 00       	call   8019e6 <sys_pf_calculate_allocated_pages>
  800565:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 c4 22 80 00       	push   $0x8022c4
  800572:	6a 68                	push   $0x68
  800574:	68 88 21 80 00       	push   $0x802188
  800579:	e8 3b 02 00 00       	call   8007b9 <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  80057e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800581:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800584:	75 08                	jne    80058e <_main+0x556>
  800586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800589:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058c:	74 14                	je     8005a2 <_main+0x56a>
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 34 23 80 00       	push   $0x802334
  800596:	6a 6a                	push   $0x6a
  800598:	68 88 21 80 00       	push   $0x802188
  80059d:	e8 17 02 00 00       	call   8007b9 <_panic>

	/*[5] BUSY-WAIT FOR A WHILE TILL FINISHING THE MASTER PROGRAM */
	env_sleep(5000);
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	68 88 13 00 00       	push   $0x1388
  8005aa:	e8 62 18 00 00       	call   801e11 <env_sleep>
  8005af:	83 c4 10             	add    $0x10,%esp

	/*[6] Read the modified pages of this slave program (after they have been written on page file) */
	initFreeBufCnt = sys_calculate_notmod_frames();
  8005b2:	e8 de 13 00 00       	call   801995 <sys_calculate_notmod_frames>
  8005b7:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8005ba:	e8 bd 13 00 00       	call   80197c <sys_calculate_modified_frames>
  8005bf:	89 45 ac             	mov    %eax,-0x54(%ebp)
	i = 0;
  8005c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum3 = 0 ;
  8005c9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	dummy = 0;
  8005d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  8005d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005de:	eb 2d                	jmp    80060d <_main+0x5d5>
	{
		dstSum3 += dst[i];
  8005e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e3:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8005ea:	01 45 dc             	add    %eax,-0x24(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005ed:	e8 a3 13 00 00       	call   801995 <sys_calculate_notmod_frames>
  8005f2:	89 c2                	mov    %eax,%edx
  8005f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f9:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005fc:	01 c2                	add    %eax,%edx
  8005fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800601:	01 d0                	add    %edx,%eax
  800603:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initFreeBufCnt = sys_calculate_notmod_frames();
	initModBufCnt = sys_calculate_modified_frames();
	i = 0;
	int dstSum3 = 0 ;
	dummy = 0;
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  800606:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80060d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800614:	7e ca                	jle    8005e0 <_main+0x5a8>
	{
		dstSum3 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800616:	e8 7a 13 00 00       	call   801995 <sys_calculate_notmod_frames>
  80061b:	89 c2                	mov    %eax,%edx
  80061d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800620:	39 c2                	cmp    %eax,%edx
  800622:	74 14                	je     800638 <_main+0x600>
  800624:	83 ec 04             	sub    $0x4,%esp
  800627:	68 f4 21 80 00       	push   $0x8021f4
  80062c:	6a 7b                	push   $0x7b
  80062e:	68 88 21 80 00       	push   $0x802188
  800633:	e8 81 01 00 00       	call   8007b9 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800638:	e8 3f 13 00 00       	call   80197c <sys_calculate_modified_frames>
  80063d:	89 c2                	mov    %eax,%edx
  80063f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800642:	39 c2                	cmp    %eax,%edx
  800644:	74 14                	je     80065a <_main+0x622>
  800646:	83 ec 04             	sub    $0x4,%esp
  800649:	68 58 22 80 00       	push   $0x802258
  80064e:	6a 7c                	push   $0x7c
  800650:	68 88 21 80 00       	push   $0x802188
  800655:	e8 5f 01 00 00       	call   8007b9 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  80065a:	e8 87 13 00 00       	call   8019e6 <sys_pf_calculate_allocated_pages>
  80065f:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800662:	74 14                	je     800678 <_main+0x640>
  800664:	83 ec 04             	sub    $0x4,%esp
  800667:	68 c4 22 80 00       	push   $0x8022c4
  80066c:	6a 7e                	push   $0x7e
  80066e:	68 88 21 80 00       	push   $0x802188
  800673:	e8 41 01 00 00       	call   8007b9 <_panic>

	if (dstSum1 != dstSum3) 	panic("Error in buffering/restoring modified pages after freeing the modified list") ;
  800678:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067b:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80067e:	74 17                	je     800697 <_main+0x65f>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 70 23 80 00       	push   $0x802370
  800688:	68 80 00 00 00       	push   $0x80
  80068d:	68 88 21 80 00       	push   $0x802188
  800692:	e8 22 01 00 00       	call   8007b9 <_panic>

	cprintf("Congratulations!! modified list is cleared and updated successfully.\n");
  800697:	83 ec 0c             	sub    $0xc,%esp
  80069a:	68 bc 23 80 00       	push   $0x8023bc
  80069f:	e8 c9 03 00 00       	call   800a6d <cprintf>
  8006a4:	83 c4 10             	add    $0x10,%esp

	return;
  8006a7:	90                   	nop

}
  8006a8:	c9                   	leave  
  8006a9:	c3                   	ret    

008006aa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006aa:	55                   	push   %ebp
  8006ab:	89 e5                	mov    %esp,%ebp
  8006ad:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b0:	e8 e3 11 00 00       	call   801898 <sys_getenvindex>
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bb:	89 d0                	mov    %edx,%eax
  8006bd:	c1 e0 02             	shl    $0x2,%eax
  8006c0:	01 d0                	add    %edx,%eax
  8006c2:	01 c0                	add    %eax,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	01 c0                	add    %eax,%eax
  8006c8:	01 d0                	add    %edx,%eax
  8006ca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8006d1:	01 d0                	add    %edx,%eax
  8006d3:	c1 e0 02             	shl    $0x2,%eax
  8006d6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006db:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e5:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006eb:	84 c0                	test   %al,%al
  8006ed:	74 0f                	je     8006fe <libmain+0x54>
		binaryname = myEnv->prog_name;
  8006ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8006f4:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006f9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800702:	7e 0a                	jle    80070e <libmain+0x64>
		binaryname = argv[0];
  800704:	8b 45 0c             	mov    0xc(%ebp),%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	ff 75 08             	pushl  0x8(%ebp)
  800717:	e8 1c f9 ff ff       	call   800038 <_main>
  80071c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80071f:	e8 0f 13 00 00       	call   801a33 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800724:	83 ec 0c             	sub    $0xc,%esp
  800727:	68 1c 24 80 00       	push   $0x80241c
  80072c:	e8 3c 03 00 00       	call   800a6d <cprintf>
  800731:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800734:	a1 20 30 80 00       	mov    0x803020,%eax
  800739:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80073f:	a1 20 30 80 00       	mov    0x803020,%eax
  800744:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80074a:	83 ec 04             	sub    $0x4,%esp
  80074d:	52                   	push   %edx
  80074e:	50                   	push   %eax
  80074f:	68 44 24 80 00       	push   $0x802444
  800754:	e8 14 03 00 00       	call   800a6d <cprintf>
  800759:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80075c:	a1 20 30 80 00       	mov    0x803020,%eax
  800761:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	50                   	push   %eax
  80076b:	68 69 24 80 00       	push   $0x802469
  800770:	e8 f8 02 00 00       	call   800a6d <cprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800778:	83 ec 0c             	sub    $0xc,%esp
  80077b:	68 1c 24 80 00       	push   $0x80241c
  800780:	e8 e8 02 00 00       	call   800a6d <cprintf>
  800785:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800788:	e8 c0 12 00 00       	call   801a4d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80078d:	e8 19 00 00 00       	call   8007ab <exit>
}
  800792:	90                   	nop
  800793:	c9                   	leave  
  800794:	c3                   	ret    

00800795 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800795:	55                   	push   %ebp
  800796:	89 e5                	mov    %esp,%ebp
  800798:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80079b:	83 ec 0c             	sub    $0xc,%esp
  80079e:	6a 00                	push   $0x0
  8007a0:	e8 bf 10 00 00       	call   801864 <sys_env_destroy>
  8007a5:	83 c4 10             	add    $0x10,%esp
}
  8007a8:	90                   	nop
  8007a9:	c9                   	leave  
  8007aa:	c3                   	ret    

008007ab <exit>:

void
exit(void)
{
  8007ab:	55                   	push   %ebp
  8007ac:	89 e5                	mov    %esp,%ebp
  8007ae:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007b1:	e8 14 11 00 00       	call   8018ca <sys_env_exit>
}
  8007b6:	90                   	nop
  8007b7:	c9                   	leave  
  8007b8:	c3                   	ret    

008007b9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007b9:	55                   	push   %ebp
  8007ba:	89 e5                	mov    %esp,%ebp
  8007bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007bf:	8d 45 10             	lea    0x10(%ebp),%eax
  8007c2:	83 c0 04             	add    $0x4,%eax
  8007c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007c8:	a1 64 30 81 00       	mov    0x813064,%eax
  8007cd:	85 c0                	test   %eax,%eax
  8007cf:	74 16                	je     8007e7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007d1:	a1 64 30 81 00       	mov    0x813064,%eax
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	50                   	push   %eax
  8007da:	68 80 24 80 00       	push   $0x802480
  8007df:	e8 89 02 00 00       	call   800a6d <cprintf>
  8007e4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007e7:	a1 00 30 80 00       	mov    0x803000,%eax
  8007ec:	ff 75 0c             	pushl  0xc(%ebp)
  8007ef:	ff 75 08             	pushl  0x8(%ebp)
  8007f2:	50                   	push   %eax
  8007f3:	68 85 24 80 00       	push   $0x802485
  8007f8:	e8 70 02 00 00       	call   800a6d <cprintf>
  8007fd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800800:	8b 45 10             	mov    0x10(%ebp),%eax
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	ff 75 f4             	pushl  -0xc(%ebp)
  800809:	50                   	push   %eax
  80080a:	e8 f3 01 00 00       	call   800a02 <vcprintf>
  80080f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	6a 00                	push   $0x0
  800817:	68 a1 24 80 00       	push   $0x8024a1
  80081c:	e8 e1 01 00 00       	call   800a02 <vcprintf>
  800821:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800824:	e8 82 ff ff ff       	call   8007ab <exit>

	// should not return here
	while (1) ;
  800829:	eb fe                	jmp    800829 <_panic+0x70>

0080082b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
  80082e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800831:	a1 20 30 80 00       	mov    0x803020,%eax
  800836:	8b 50 74             	mov    0x74(%eax),%edx
  800839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083c:	39 c2                	cmp    %eax,%edx
  80083e:	74 14                	je     800854 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800840:	83 ec 04             	sub    $0x4,%esp
  800843:	68 a4 24 80 00       	push   $0x8024a4
  800848:	6a 26                	push   $0x26
  80084a:	68 f0 24 80 00       	push   $0x8024f0
  80084f:	e8 65 ff ff ff       	call   8007b9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800854:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80085b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800862:	e9 c2 00 00 00       	jmp    800929 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800867:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800871:	8b 45 08             	mov    0x8(%ebp),%eax
  800874:	01 d0                	add    %edx,%eax
  800876:	8b 00                	mov    (%eax),%eax
  800878:	85 c0                	test   %eax,%eax
  80087a:	75 08                	jne    800884 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80087c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80087f:	e9 a2 00 00 00       	jmp    800926 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800884:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800892:	eb 69                	jmp    8008fd <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800894:	a1 20 30 80 00       	mov    0x803020,%eax
  800899:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80089f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008a2:	89 d0                	mov    %edx,%eax
  8008a4:	01 c0                	add    %eax,%eax
  8008a6:	01 d0                	add    %edx,%eax
  8008a8:	c1 e0 02             	shl    $0x2,%eax
  8008ab:	01 c8                	add    %ecx,%eax
  8008ad:	8a 40 04             	mov    0x4(%eax),%al
  8008b0:	84 c0                	test   %al,%al
  8008b2:	75 46                	jne    8008fa <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008c2:	89 d0                	mov    %edx,%eax
  8008c4:	01 c0                	add    %eax,%eax
  8008c6:	01 d0                	add    %edx,%eax
  8008c8:	c1 e0 02             	shl    $0x2,%eax
  8008cb:	01 c8                	add    %ecx,%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008da:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008df:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	01 c8                	add    %ecx,%eax
  8008eb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008ed:	39 c2                	cmp    %eax,%edx
  8008ef:	75 09                	jne    8008fa <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008f1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008f8:	eb 12                	jmp    80090c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008fa:	ff 45 e8             	incl   -0x18(%ebp)
  8008fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800902:	8b 50 74             	mov    0x74(%eax),%edx
  800905:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800908:	39 c2                	cmp    %eax,%edx
  80090a:	77 88                	ja     800894 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80090c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800910:	75 14                	jne    800926 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800912:	83 ec 04             	sub    $0x4,%esp
  800915:	68 fc 24 80 00       	push   $0x8024fc
  80091a:	6a 3a                	push   $0x3a
  80091c:	68 f0 24 80 00       	push   $0x8024f0
  800921:	e8 93 fe ff ff       	call   8007b9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800926:	ff 45 f0             	incl   -0x10(%ebp)
  800929:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80092f:	0f 8c 32 ff ff ff    	jl     800867 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800935:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80093c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800943:	eb 26                	jmp    80096b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800945:	a1 20 30 80 00       	mov    0x803020,%eax
  80094a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800950:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800953:	89 d0                	mov    %edx,%eax
  800955:	01 c0                	add    %eax,%eax
  800957:	01 d0                	add    %edx,%eax
  800959:	c1 e0 02             	shl    $0x2,%eax
  80095c:	01 c8                	add    %ecx,%eax
  80095e:	8a 40 04             	mov    0x4(%eax),%al
  800961:	3c 01                	cmp    $0x1,%al
  800963:	75 03                	jne    800968 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800965:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800968:	ff 45 e0             	incl   -0x20(%ebp)
  80096b:	a1 20 30 80 00       	mov    0x803020,%eax
  800970:	8b 50 74             	mov    0x74(%eax),%edx
  800973:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800976:	39 c2                	cmp    %eax,%edx
  800978:	77 cb                	ja     800945 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80097a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80097d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800980:	74 14                	je     800996 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800982:	83 ec 04             	sub    $0x4,%esp
  800985:	68 50 25 80 00       	push   $0x802550
  80098a:	6a 44                	push   $0x44
  80098c:	68 f0 24 80 00       	push   $0x8024f0
  800991:	e8 23 fe ff ff       	call   8007b9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800996:	90                   	nop
  800997:	c9                   	leave  
  800998:	c3                   	ret    

00800999 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800999:	55                   	push   %ebp
  80099a:	89 e5                	mov    %esp,%ebp
  80099c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80099f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8009a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009aa:	89 0a                	mov    %ecx,(%edx)
  8009ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8009af:	88 d1                	mov    %dl,%cl
  8009b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bb:	8b 00                	mov    (%eax),%eax
  8009bd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009c2:	75 2c                	jne    8009f0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009c4:	a0 24 30 80 00       	mov    0x803024,%al
  8009c9:	0f b6 c0             	movzbl %al,%eax
  8009cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cf:	8b 12                	mov    (%edx),%edx
  8009d1:	89 d1                	mov    %edx,%ecx
  8009d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d6:	83 c2 08             	add    $0x8,%edx
  8009d9:	83 ec 04             	sub    $0x4,%esp
  8009dc:	50                   	push   %eax
  8009dd:	51                   	push   %ecx
  8009de:	52                   	push   %edx
  8009df:	e8 3e 0e 00 00       	call   801822 <sys_cputs>
  8009e4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f3:	8b 40 04             	mov    0x4(%eax),%eax
  8009f6:	8d 50 01             	lea    0x1(%eax),%edx
  8009f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009ff:	90                   	nop
  800a00:	c9                   	leave  
  800a01:	c3                   	ret    

00800a02 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a02:	55                   	push   %ebp
  800a03:	89 e5                	mov    %esp,%ebp
  800a05:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a0b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a12:	00 00 00 
	b.cnt = 0;
  800a15:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a1c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	ff 75 08             	pushl  0x8(%ebp)
  800a25:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a2b:	50                   	push   %eax
  800a2c:	68 99 09 80 00       	push   $0x800999
  800a31:	e8 11 02 00 00       	call   800c47 <vprintfmt>
  800a36:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a39:	a0 24 30 80 00       	mov    0x803024,%al
  800a3e:	0f b6 c0             	movzbl %al,%eax
  800a41:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a47:	83 ec 04             	sub    $0x4,%esp
  800a4a:	50                   	push   %eax
  800a4b:	52                   	push   %edx
  800a4c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a52:	83 c0 08             	add    $0x8,%eax
  800a55:	50                   	push   %eax
  800a56:	e8 c7 0d 00 00       	call   801822 <sys_cputs>
  800a5b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a5e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a65:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a6b:	c9                   	leave  
  800a6c:	c3                   	ret    

00800a6d <cprintf>:

int cprintf(const char *fmt, ...) {
  800a6d:	55                   	push   %ebp
  800a6e:	89 e5                	mov    %esp,%ebp
  800a70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a73:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a7a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	83 ec 08             	sub    $0x8,%esp
  800a86:	ff 75 f4             	pushl  -0xc(%ebp)
  800a89:	50                   	push   %eax
  800a8a:	e8 73 ff ff ff       	call   800a02 <vcprintf>
  800a8f:	83 c4 10             	add    $0x10,%esp
  800a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a98:	c9                   	leave  
  800a99:	c3                   	ret    

00800a9a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a9a:	55                   	push   %ebp
  800a9b:	89 e5                	mov    %esp,%ebp
  800a9d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800aa0:	e8 8e 0f 00 00       	call   801a33 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aa5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	83 ec 08             	sub    $0x8,%esp
  800ab1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab4:	50                   	push   %eax
  800ab5:	e8 48 ff ff ff       	call   800a02 <vcprintf>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ac0:	e8 88 0f 00 00       	call   801a4d <sys_enable_interrupt>
	return cnt;
  800ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	53                   	push   %ebx
  800ace:	83 ec 14             	sub    $0x14,%esp
  800ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad7:	8b 45 14             	mov    0x14(%ebp),%eax
  800ada:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800add:	8b 45 18             	mov    0x18(%ebp),%eax
  800ae0:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae8:	77 55                	ja     800b3f <printnum+0x75>
  800aea:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aed:	72 05                	jb     800af4 <printnum+0x2a>
  800aef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800af2:	77 4b                	ja     800b3f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800af4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800af7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800afa:	8b 45 18             	mov    0x18(%ebp),%eax
  800afd:	ba 00 00 00 00       	mov    $0x0,%edx
  800b02:	52                   	push   %edx
  800b03:	50                   	push   %eax
  800b04:	ff 75 f4             	pushl  -0xc(%ebp)
  800b07:	ff 75 f0             	pushl  -0x10(%ebp)
  800b0a:	e8 b9 13 00 00       	call   801ec8 <__udivdi3>
  800b0f:	83 c4 10             	add    $0x10,%esp
  800b12:	83 ec 04             	sub    $0x4,%esp
  800b15:	ff 75 20             	pushl  0x20(%ebp)
  800b18:	53                   	push   %ebx
  800b19:	ff 75 18             	pushl  0x18(%ebp)
  800b1c:	52                   	push   %edx
  800b1d:	50                   	push   %eax
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	ff 75 08             	pushl  0x8(%ebp)
  800b24:	e8 a1 ff ff ff       	call   800aca <printnum>
  800b29:	83 c4 20             	add    $0x20,%esp
  800b2c:	eb 1a                	jmp    800b48 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b2e:	83 ec 08             	sub    $0x8,%esp
  800b31:	ff 75 0c             	pushl  0xc(%ebp)
  800b34:	ff 75 20             	pushl  0x20(%ebp)
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b3f:	ff 4d 1c             	decl   0x1c(%ebp)
  800b42:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b46:	7f e6                	jg     800b2e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b48:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b4b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b56:	53                   	push   %ebx
  800b57:	51                   	push   %ecx
  800b58:	52                   	push   %edx
  800b59:	50                   	push   %eax
  800b5a:	e8 79 14 00 00       	call   801fd8 <__umoddi3>
  800b5f:	83 c4 10             	add    $0x10,%esp
  800b62:	05 b4 27 80 00       	add    $0x8027b4,%eax
  800b67:	8a 00                	mov    (%eax),%al
  800b69:	0f be c0             	movsbl %al,%eax
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	50                   	push   %eax
  800b73:	8b 45 08             	mov    0x8(%ebp),%eax
  800b76:	ff d0                	call   *%eax
  800b78:	83 c4 10             	add    $0x10,%esp
}
  800b7b:	90                   	nop
  800b7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b7f:	c9                   	leave  
  800b80:	c3                   	ret    

00800b81 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b84:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b88:	7e 1c                	jle    800ba6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	8d 50 08             	lea    0x8(%eax),%edx
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	89 10                	mov    %edx,(%eax)
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8b 00                	mov    (%eax),%eax
  800b9c:	83 e8 08             	sub    $0x8,%eax
  800b9f:	8b 50 04             	mov    0x4(%eax),%edx
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	eb 40                	jmp    800be6 <getuint+0x65>
	else if (lflag)
  800ba6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800baa:	74 1e                	je     800bca <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8b 00                	mov    (%eax),%eax
  800bb1:	8d 50 04             	lea    0x4(%eax),%edx
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	89 10                	mov    %edx,(%eax)
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	8b 00                	mov    (%eax),%eax
  800bbe:	83 e8 04             	sub    $0x4,%eax
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	ba 00 00 00 00       	mov    $0x0,%edx
  800bc8:	eb 1c                	jmp    800be6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	8d 50 04             	lea    0x4(%eax),%edx
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	89 10                	mov    %edx,(%eax)
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	8b 00                	mov    (%eax),%eax
  800bdc:	83 e8 04             	sub    $0x4,%eax
  800bdf:	8b 00                	mov    (%eax),%eax
  800be1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800be6:	5d                   	pop    %ebp
  800be7:	c3                   	ret    

00800be8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800beb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bef:	7e 1c                	jle    800c0d <getint+0x25>
		return va_arg(*ap, long long);
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	8d 50 08             	lea    0x8(%eax),%edx
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	89 10                	mov    %edx,(%eax)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8b 00                	mov    (%eax),%eax
  800c03:	83 e8 08             	sub    $0x8,%eax
  800c06:	8b 50 04             	mov    0x4(%eax),%edx
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	eb 38                	jmp    800c45 <getint+0x5d>
	else if (lflag)
  800c0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c11:	74 1a                	je     800c2d <getint+0x45>
		return va_arg(*ap, long);
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	8d 50 04             	lea    0x4(%eax),%edx
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	89 10                	mov    %edx,(%eax)
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	83 e8 04             	sub    $0x4,%eax
  800c28:	8b 00                	mov    (%eax),%eax
  800c2a:	99                   	cltd   
  800c2b:	eb 18                	jmp    800c45 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	8d 50 04             	lea    0x4(%eax),%edx
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	89 10                	mov    %edx,(%eax)
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	8b 00                	mov    (%eax),%eax
  800c3f:	83 e8 04             	sub    $0x4,%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	99                   	cltd   
}
  800c45:	5d                   	pop    %ebp
  800c46:	c3                   	ret    

00800c47 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c47:	55                   	push   %ebp
  800c48:	89 e5                	mov    %esp,%ebp
  800c4a:	56                   	push   %esi
  800c4b:	53                   	push   %ebx
  800c4c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c4f:	eb 17                	jmp    800c68 <vprintfmt+0x21>
			if (ch == '\0')
  800c51:	85 db                	test   %ebx,%ebx
  800c53:	0f 84 af 03 00 00    	je     801008 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c59:	83 ec 08             	sub    $0x8,%esp
  800c5c:	ff 75 0c             	pushl  0xc(%ebp)
  800c5f:	53                   	push   %ebx
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	ff d0                	call   *%eax
  800c65:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c68:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6b:	8d 50 01             	lea    0x1(%eax),%edx
  800c6e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	0f b6 d8             	movzbl %al,%ebx
  800c76:	83 fb 25             	cmp    $0x25,%ebx
  800c79:	75 d6                	jne    800c51 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c7b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c7f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c86:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c8d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c94:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9e:	8d 50 01             	lea    0x1(%eax),%edx
  800ca1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	0f b6 d8             	movzbl %al,%ebx
  800ca9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cac:	83 f8 55             	cmp    $0x55,%eax
  800caf:	0f 87 2b 03 00 00    	ja     800fe0 <vprintfmt+0x399>
  800cb5:	8b 04 85 d8 27 80 00 	mov    0x8027d8(,%eax,4),%eax
  800cbc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cbe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cc2:	eb d7                	jmp    800c9b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cc4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cc8:	eb d1                	jmp    800c9b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cd4:	89 d0                	mov    %edx,%eax
  800cd6:	c1 e0 02             	shl    $0x2,%eax
  800cd9:	01 d0                	add    %edx,%eax
  800cdb:	01 c0                	add    %eax,%eax
  800cdd:	01 d8                	add    %ebx,%eax
  800cdf:	83 e8 30             	sub    $0x30,%eax
  800ce2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ced:	83 fb 2f             	cmp    $0x2f,%ebx
  800cf0:	7e 3e                	jle    800d30 <vprintfmt+0xe9>
  800cf2:	83 fb 39             	cmp    $0x39,%ebx
  800cf5:	7f 39                	jg     800d30 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cfa:	eb d5                	jmp    800cd1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 c0 04             	add    $0x4,%eax
  800d02:	89 45 14             	mov    %eax,0x14(%ebp)
  800d05:	8b 45 14             	mov    0x14(%ebp),%eax
  800d08:	83 e8 04             	sub    $0x4,%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d10:	eb 1f                	jmp    800d31 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d12:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d16:	79 83                	jns    800c9b <vprintfmt+0x54>
				width = 0;
  800d18:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d1f:	e9 77 ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d24:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d2b:	e9 6b ff ff ff       	jmp    800c9b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d30:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d35:	0f 89 60 ff ff ff    	jns    800c9b <vprintfmt+0x54>
				width = precision, precision = -1;
  800d3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d41:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d48:	e9 4e ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d4d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d50:	e9 46 ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d55:	8b 45 14             	mov    0x14(%ebp),%eax
  800d58:	83 c0 04             	add    $0x4,%eax
  800d5b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d61:	83 e8 04             	sub    $0x4,%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	ff 75 0c             	pushl  0xc(%ebp)
  800d6c:	50                   	push   %eax
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	ff d0                	call   *%eax
  800d72:	83 c4 10             	add    $0x10,%esp
			break;
  800d75:	e9 89 02 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7d:	83 c0 04             	add    $0x4,%eax
  800d80:	89 45 14             	mov    %eax,0x14(%ebp)
  800d83:	8b 45 14             	mov    0x14(%ebp),%eax
  800d86:	83 e8 04             	sub    $0x4,%eax
  800d89:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d8b:	85 db                	test   %ebx,%ebx
  800d8d:	79 02                	jns    800d91 <vprintfmt+0x14a>
				err = -err;
  800d8f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d91:	83 fb 64             	cmp    $0x64,%ebx
  800d94:	7f 0b                	jg     800da1 <vprintfmt+0x15a>
  800d96:	8b 34 9d 20 26 80 00 	mov    0x802620(,%ebx,4),%esi
  800d9d:	85 f6                	test   %esi,%esi
  800d9f:	75 19                	jne    800dba <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800da1:	53                   	push   %ebx
  800da2:	68 c5 27 80 00       	push   $0x8027c5
  800da7:	ff 75 0c             	pushl  0xc(%ebp)
  800daa:	ff 75 08             	pushl  0x8(%ebp)
  800dad:	e8 5e 02 00 00       	call   801010 <printfmt>
  800db2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800db5:	e9 49 02 00 00       	jmp    801003 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dba:	56                   	push   %esi
  800dbb:	68 ce 27 80 00       	push   $0x8027ce
  800dc0:	ff 75 0c             	pushl  0xc(%ebp)
  800dc3:	ff 75 08             	pushl  0x8(%ebp)
  800dc6:	e8 45 02 00 00       	call   801010 <printfmt>
  800dcb:	83 c4 10             	add    $0x10,%esp
			break;
  800dce:	e9 30 02 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd6:	83 c0 04             	add    $0x4,%eax
  800dd9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ddc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ddf:	83 e8 04             	sub    $0x4,%eax
  800de2:	8b 30                	mov    (%eax),%esi
  800de4:	85 f6                	test   %esi,%esi
  800de6:	75 05                	jne    800ded <vprintfmt+0x1a6>
				p = "(null)";
  800de8:	be d1 27 80 00       	mov    $0x8027d1,%esi
			if (width > 0 && padc != '-')
  800ded:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df1:	7e 6d                	jle    800e60 <vprintfmt+0x219>
  800df3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800df7:	74 67                	je     800e60 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800df9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dfc:	83 ec 08             	sub    $0x8,%esp
  800dff:	50                   	push   %eax
  800e00:	56                   	push   %esi
  800e01:	e8 0c 03 00 00       	call   801112 <strnlen>
  800e06:	83 c4 10             	add    $0x10,%esp
  800e09:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e0c:	eb 16                	jmp    800e24 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e0e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e12:	83 ec 08             	sub    $0x8,%esp
  800e15:	ff 75 0c             	pushl  0xc(%ebp)
  800e18:	50                   	push   %eax
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	ff d0                	call   *%eax
  800e1e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e21:	ff 4d e4             	decl   -0x1c(%ebp)
  800e24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e28:	7f e4                	jg     800e0e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e2a:	eb 34                	jmp    800e60 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e2c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e30:	74 1c                	je     800e4e <vprintfmt+0x207>
  800e32:	83 fb 1f             	cmp    $0x1f,%ebx
  800e35:	7e 05                	jle    800e3c <vprintfmt+0x1f5>
  800e37:	83 fb 7e             	cmp    $0x7e,%ebx
  800e3a:	7e 12                	jle    800e4e <vprintfmt+0x207>
					putch('?', putdat);
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	6a 3f                	push   $0x3f
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	ff d0                	call   *%eax
  800e49:	83 c4 10             	add    $0x10,%esp
  800e4c:	eb 0f                	jmp    800e5d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	53                   	push   %ebx
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	ff d0                	call   *%eax
  800e5a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e5d:	ff 4d e4             	decl   -0x1c(%ebp)
  800e60:	89 f0                	mov    %esi,%eax
  800e62:	8d 70 01             	lea    0x1(%eax),%esi
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	0f be d8             	movsbl %al,%ebx
  800e6a:	85 db                	test   %ebx,%ebx
  800e6c:	74 24                	je     800e92 <vprintfmt+0x24b>
  800e6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e72:	78 b8                	js     800e2c <vprintfmt+0x1e5>
  800e74:	ff 4d e0             	decl   -0x20(%ebp)
  800e77:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e7b:	79 af                	jns    800e2c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e7d:	eb 13                	jmp    800e92 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e7f:	83 ec 08             	sub    $0x8,%esp
  800e82:	ff 75 0c             	pushl  0xc(%ebp)
  800e85:	6a 20                	push   $0x20
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	ff d0                	call   *%eax
  800e8c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e8f:	ff 4d e4             	decl   -0x1c(%ebp)
  800e92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e96:	7f e7                	jg     800e7f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e98:	e9 66 01 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e9d:	83 ec 08             	sub    $0x8,%esp
  800ea0:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea3:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea6:	50                   	push   %eax
  800ea7:	e8 3c fd ff ff       	call   800be8 <getint>
  800eac:	83 c4 10             	add    $0x10,%esp
  800eaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ebb:	85 d2                	test   %edx,%edx
  800ebd:	79 23                	jns    800ee2 <vprintfmt+0x29b>
				putch('-', putdat);
  800ebf:	83 ec 08             	sub    $0x8,%esp
  800ec2:	ff 75 0c             	pushl  0xc(%ebp)
  800ec5:	6a 2d                	push   $0x2d
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	ff d0                	call   *%eax
  800ecc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed5:	f7 d8                	neg    %eax
  800ed7:	83 d2 00             	adc    $0x0,%edx
  800eda:	f7 da                	neg    %edx
  800edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800edf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ee2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ee9:	e9 bc 00 00 00       	jmp    800faa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef7:	50                   	push   %eax
  800ef8:	e8 84 fc ff ff       	call   800b81 <getuint>
  800efd:	83 c4 10             	add    $0x10,%esp
  800f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f03:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f06:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f0d:	e9 98 00 00 00       	jmp    800faa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f12:	83 ec 08             	sub    $0x8,%esp
  800f15:	ff 75 0c             	pushl  0xc(%ebp)
  800f18:	6a 58                	push   $0x58
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	ff d0                	call   *%eax
  800f1f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f22:	83 ec 08             	sub    $0x8,%esp
  800f25:	ff 75 0c             	pushl  0xc(%ebp)
  800f28:	6a 58                	push   $0x58
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f32:	83 ec 08             	sub    $0x8,%esp
  800f35:	ff 75 0c             	pushl  0xc(%ebp)
  800f38:	6a 58                	push   $0x58
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	ff d0                	call   *%eax
  800f3f:	83 c4 10             	add    $0x10,%esp
			break;
  800f42:	e9 bc 00 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f47:	83 ec 08             	sub    $0x8,%esp
  800f4a:	ff 75 0c             	pushl  0xc(%ebp)
  800f4d:	6a 30                	push   $0x30
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	ff d0                	call   *%eax
  800f54:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f57:	83 ec 08             	sub    $0x8,%esp
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	6a 78                	push   $0x78
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	ff d0                	call   *%eax
  800f64:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f67:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6a:	83 c0 04             	add    $0x4,%eax
  800f6d:	89 45 14             	mov    %eax,0x14(%ebp)
  800f70:	8b 45 14             	mov    0x14(%ebp),%eax
  800f73:	83 e8 04             	sub    $0x4,%eax
  800f76:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f82:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f89:	eb 1f                	jmp    800faa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 e8             	pushl  -0x18(%ebp)
  800f91:	8d 45 14             	lea    0x14(%ebp),%eax
  800f94:	50                   	push   %eax
  800f95:	e8 e7 fb ff ff       	call   800b81 <getuint>
  800f9a:	83 c4 10             	add    $0x10,%esp
  800f9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fa3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800faa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb1:	83 ec 04             	sub    $0x4,%esp
  800fb4:	52                   	push   %edx
  800fb5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fb8:	50                   	push   %eax
  800fb9:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbc:	ff 75 f0             	pushl  -0x10(%ebp)
  800fbf:	ff 75 0c             	pushl  0xc(%ebp)
  800fc2:	ff 75 08             	pushl  0x8(%ebp)
  800fc5:	e8 00 fb ff ff       	call   800aca <printnum>
  800fca:	83 c4 20             	add    $0x20,%esp
			break;
  800fcd:	eb 34                	jmp    801003 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fcf:	83 ec 08             	sub    $0x8,%esp
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	53                   	push   %ebx
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	ff d0                	call   *%eax
  800fdb:	83 c4 10             	add    $0x10,%esp
			break;
  800fde:	eb 23                	jmp    801003 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fe0:	83 ec 08             	sub    $0x8,%esp
  800fe3:	ff 75 0c             	pushl  0xc(%ebp)
  800fe6:	6a 25                	push   $0x25
  800fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  800feb:	ff d0                	call   *%eax
  800fed:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ff0:	ff 4d 10             	decl   0x10(%ebp)
  800ff3:	eb 03                	jmp    800ff8 <vprintfmt+0x3b1>
  800ff5:	ff 4d 10             	decl   0x10(%ebp)
  800ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffb:	48                   	dec    %eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 25                	cmp    $0x25,%al
  801000:	75 f3                	jne    800ff5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801002:	90                   	nop
		}
	}
  801003:	e9 47 fc ff ff       	jmp    800c4f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801008:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801009:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80100c:	5b                   	pop    %ebx
  80100d:	5e                   	pop    %esi
  80100e:	5d                   	pop    %ebp
  80100f:	c3                   	ret    

00801010 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801010:	55                   	push   %ebp
  801011:	89 e5                	mov    %esp,%ebp
  801013:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801016:	8d 45 10             	lea    0x10(%ebp),%eax
  801019:	83 c0 04             	add    $0x4,%eax
  80101c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	ff 75 f4             	pushl  -0xc(%ebp)
  801025:	50                   	push   %eax
  801026:	ff 75 0c             	pushl  0xc(%ebp)
  801029:	ff 75 08             	pushl  0x8(%ebp)
  80102c:	e8 16 fc ff ff       	call   800c47 <vprintfmt>
  801031:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801034:	90                   	nop
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	8b 40 08             	mov    0x8(%eax),%eax
  801040:	8d 50 01             	lea    0x1(%eax),%edx
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	8b 10                	mov    (%eax),%edx
  80104e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801051:	8b 40 04             	mov    0x4(%eax),%eax
  801054:	39 c2                	cmp    %eax,%edx
  801056:	73 12                	jae    80106a <sprintputch+0x33>
		*b->buf++ = ch;
  801058:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105b:	8b 00                	mov    (%eax),%eax
  80105d:	8d 48 01             	lea    0x1(%eax),%ecx
  801060:	8b 55 0c             	mov    0xc(%ebp),%edx
  801063:	89 0a                	mov    %ecx,(%edx)
  801065:	8b 55 08             	mov    0x8(%ebp),%edx
  801068:	88 10                	mov    %dl,(%eax)
}
  80106a:	90                   	nop
  80106b:	5d                   	pop    %ebp
  80106c:	c3                   	ret    

0080106d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80106d:	55                   	push   %ebp
  80106e:	89 e5                	mov    %esp,%ebp
  801070:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801079:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	01 d0                	add    %edx,%eax
  801084:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801087:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80108e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801092:	74 06                	je     80109a <vsnprintf+0x2d>
  801094:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801098:	7f 07                	jg     8010a1 <vsnprintf+0x34>
		return -E_INVAL;
  80109a:	b8 03 00 00 00       	mov    $0x3,%eax
  80109f:	eb 20                	jmp    8010c1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010a1:	ff 75 14             	pushl  0x14(%ebp)
  8010a4:	ff 75 10             	pushl  0x10(%ebp)
  8010a7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010aa:	50                   	push   %eax
  8010ab:	68 37 10 80 00       	push   $0x801037
  8010b0:	e8 92 fb ff ff       	call   800c47 <vprintfmt>
  8010b5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010bb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010c1:	c9                   	leave  
  8010c2:	c3                   	ret    

008010c3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010c3:	55                   	push   %ebp
  8010c4:	89 e5                	mov    %esp,%ebp
  8010c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010c9:	8d 45 10             	lea    0x10(%ebp),%eax
  8010cc:	83 c0 04             	add    $0x4,%eax
  8010cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d8:	50                   	push   %eax
  8010d9:	ff 75 0c             	pushl  0xc(%ebp)
  8010dc:	ff 75 08             	pushl  0x8(%ebp)
  8010df:	e8 89 ff ff ff       	call   80106d <vsnprintf>
  8010e4:	83 c4 10             	add    $0x10,%esp
  8010e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010ed:	c9                   	leave  
  8010ee:	c3                   	ret    

008010ef <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
  8010f2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8010f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010fc:	eb 06                	jmp    801104 <strlen+0x15>
		n++;
  8010fe:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801101:	ff 45 08             	incl   0x8(%ebp)
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	84 c0                	test   %al,%al
  80110b:	75 f1                	jne    8010fe <strlen+0xf>
		n++;
	return n;
  80110d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
  801115:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801118:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80111f:	eb 09                	jmp    80112a <strnlen+0x18>
		n++;
  801121:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801124:	ff 45 08             	incl   0x8(%ebp)
  801127:	ff 4d 0c             	decl   0xc(%ebp)
  80112a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80112e:	74 09                	je     801139 <strnlen+0x27>
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	84 c0                	test   %al,%al
  801137:	75 e8                	jne    801121 <strnlen+0xf>
		n++;
	return n;
  801139:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80113c:	c9                   	leave  
  80113d:	c3                   	ret    

0080113e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80113e:	55                   	push   %ebp
  80113f:	89 e5                	mov    %esp,%ebp
  801141:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80114a:	90                   	nop
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	8d 50 01             	lea    0x1(%eax),%edx
  801151:	89 55 08             	mov    %edx,0x8(%ebp)
  801154:	8b 55 0c             	mov    0xc(%ebp),%edx
  801157:	8d 4a 01             	lea    0x1(%edx),%ecx
  80115a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80115d:	8a 12                	mov    (%edx),%dl
  80115f:	88 10                	mov    %dl,(%eax)
  801161:	8a 00                	mov    (%eax),%al
  801163:	84 c0                	test   %al,%al
  801165:	75 e4                	jne    80114b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801167:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80116a:	c9                   	leave  
  80116b:	c3                   	ret    

0080116c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80116c:	55                   	push   %ebp
  80116d:	89 e5                	mov    %esp,%ebp
  80116f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801178:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80117f:	eb 1f                	jmp    8011a0 <strncpy+0x34>
		*dst++ = *src;
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	8d 50 01             	lea    0x1(%eax),%edx
  801187:	89 55 08             	mov    %edx,0x8(%ebp)
  80118a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118d:	8a 12                	mov    (%edx),%dl
  80118f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	84 c0                	test   %al,%al
  801198:	74 03                	je     80119d <strncpy+0x31>
			src++;
  80119a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80119d:	ff 45 fc             	incl   -0x4(%ebp)
  8011a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011a6:	72 d9                	jb     801181 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
  8011b0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8011b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011bd:	74 30                	je     8011ef <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8011bf:	eb 16                	jmp    8011d7 <strlcpy+0x2a>
			*dst++ = *src++;
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8d 50 01             	lea    0x1(%eax),%edx
  8011c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011d3:	8a 12                	mov    (%edx),%dl
  8011d5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8011d7:	ff 4d 10             	decl   0x10(%ebp)
  8011da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011de:	74 09                	je     8011e9 <strlcpy+0x3c>
  8011e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	84 c0                	test   %al,%al
  8011e7:	75 d8                	jne    8011c1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8011ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8011f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f5:	29 c2                	sub    %eax,%edx
  8011f7:	89 d0                	mov    %edx,%eax
}
  8011f9:	c9                   	leave  
  8011fa:	c3                   	ret    

008011fb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8011fb:	55                   	push   %ebp
  8011fc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8011fe:	eb 06                	jmp    801206 <strcmp+0xb>
		p++, q++;
  801200:	ff 45 08             	incl   0x8(%ebp)
  801203:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	84 c0                	test   %al,%al
  80120d:	74 0e                	je     80121d <strcmp+0x22>
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 10                	mov    (%eax),%dl
  801214:	8b 45 0c             	mov    0xc(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	38 c2                	cmp    %al,%dl
  80121b:	74 e3                	je     801200 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	0f b6 d0             	movzbl %al,%edx
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	0f b6 c0             	movzbl %al,%eax
  80122d:	29 c2                	sub    %eax,%edx
  80122f:	89 d0                	mov    %edx,%eax
}
  801231:	5d                   	pop    %ebp
  801232:	c3                   	ret    

00801233 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801233:	55                   	push   %ebp
  801234:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801236:	eb 09                	jmp    801241 <strncmp+0xe>
		n--, p++, q++;
  801238:	ff 4d 10             	decl   0x10(%ebp)
  80123b:	ff 45 08             	incl   0x8(%ebp)
  80123e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801241:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801245:	74 17                	je     80125e <strncmp+0x2b>
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	84 c0                	test   %al,%al
  80124e:	74 0e                	je     80125e <strncmp+0x2b>
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 10                	mov    (%eax),%dl
  801255:	8b 45 0c             	mov    0xc(%ebp),%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	38 c2                	cmp    %al,%dl
  80125c:	74 da                	je     801238 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80125e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801262:	75 07                	jne    80126b <strncmp+0x38>
		return 0;
  801264:	b8 00 00 00 00       	mov    $0x0,%eax
  801269:	eb 14                	jmp    80127f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	0f b6 d0             	movzbl %al,%edx
  801273:	8b 45 0c             	mov    0xc(%ebp),%eax
  801276:	8a 00                	mov    (%eax),%al
  801278:	0f b6 c0             	movzbl %al,%eax
  80127b:	29 c2                	sub    %eax,%edx
  80127d:	89 d0                	mov    %edx,%eax
}
  80127f:	5d                   	pop    %ebp
  801280:	c3                   	ret    

00801281 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801281:	55                   	push   %ebp
  801282:	89 e5                	mov    %esp,%ebp
  801284:	83 ec 04             	sub    $0x4,%esp
  801287:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80128d:	eb 12                	jmp    8012a1 <strchr+0x20>
		if (*s == c)
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801297:	75 05                	jne    80129e <strchr+0x1d>
			return (char *) s;
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	eb 11                	jmp    8012af <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80129e:	ff 45 08             	incl   0x8(%ebp)
  8012a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a4:	8a 00                	mov    (%eax),%al
  8012a6:	84 c0                	test   %al,%al
  8012a8:	75 e5                	jne    80128f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012af:	c9                   	leave  
  8012b0:	c3                   	ret    

008012b1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012b1:	55                   	push   %ebp
  8012b2:	89 e5                	mov    %esp,%ebp
  8012b4:	83 ec 04             	sub    $0x4,%esp
  8012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012bd:	eb 0d                	jmp    8012cc <strfind+0x1b>
		if (*s == c)
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012c7:	74 0e                	je     8012d7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8012c9:	ff 45 08             	incl   0x8(%ebp)
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	8a 00                	mov    (%eax),%al
  8012d1:	84 c0                	test   %al,%al
  8012d3:	75 ea                	jne    8012bf <strfind+0xe>
  8012d5:	eb 01                	jmp    8012d8 <strfind+0x27>
		if (*s == c)
			break;
  8012d7:	90                   	nop
	return (char *) s;
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012db:	c9                   	leave  
  8012dc:	c3                   	ret    

008012dd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8012dd:	55                   	push   %ebp
  8012de:	89 e5                	mov    %esp,%ebp
  8012e0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8012e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8012ef:	eb 0e                	jmp    8012ff <memset+0x22>
		*p++ = c;
  8012f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f4:	8d 50 01             	lea    0x1(%eax),%edx
  8012f7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8012ff:	ff 4d f8             	decl   -0x8(%ebp)
  801302:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801306:	79 e9                	jns    8012f1 <memset+0x14>
		*p++ = c;

	return v;
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80130b:	c9                   	leave  
  80130c:	c3                   	ret    

0080130d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80130d:	55                   	push   %ebp
  80130e:	89 e5                	mov    %esp,%ebp
  801310:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801313:	8b 45 0c             	mov    0xc(%ebp),%eax
  801316:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80131f:	eb 16                	jmp    801337 <memcpy+0x2a>
		*d++ = *s++;
  801321:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801324:	8d 50 01             	lea    0x1(%eax),%edx
  801327:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80132a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80132d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801330:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801333:	8a 12                	mov    (%edx),%dl
  801335:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801337:	8b 45 10             	mov    0x10(%ebp),%eax
  80133a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80133d:	89 55 10             	mov    %edx,0x10(%ebp)
  801340:	85 c0                	test   %eax,%eax
  801342:	75 dd                	jne    801321 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
  80134c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80134f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801352:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
  801358:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80135b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801361:	73 50                	jae    8013b3 <memmove+0x6a>
  801363:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801366:	8b 45 10             	mov    0x10(%ebp),%eax
  801369:	01 d0                	add    %edx,%eax
  80136b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80136e:	76 43                	jbe    8013b3 <memmove+0x6a>
		s += n;
  801370:	8b 45 10             	mov    0x10(%ebp),%eax
  801373:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801376:	8b 45 10             	mov    0x10(%ebp),%eax
  801379:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80137c:	eb 10                	jmp    80138e <memmove+0x45>
			*--d = *--s;
  80137e:	ff 4d f8             	decl   -0x8(%ebp)
  801381:	ff 4d fc             	decl   -0x4(%ebp)
  801384:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801387:	8a 10                	mov    (%eax),%dl
  801389:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80138c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	8d 50 ff             	lea    -0x1(%eax),%edx
  801394:	89 55 10             	mov    %edx,0x10(%ebp)
  801397:	85 c0                	test   %eax,%eax
  801399:	75 e3                	jne    80137e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80139b:	eb 23                	jmp    8013c0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80139d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a0:	8d 50 01             	lea    0x1(%eax),%edx
  8013a3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013a9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013ac:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013af:	8a 12                	mov    (%edx),%dl
  8013b1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8013bc:	85 c0                	test   %eax,%eax
  8013be:	75 dd                	jne    80139d <memmove+0x54>
			*d++ = *s++;

	return dst;
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013c3:	c9                   	leave  
  8013c4:	c3                   	ret    

008013c5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
  8013c8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8013d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8013d7:	eb 2a                	jmp    801403 <memcmp+0x3e>
		if (*s1 != *s2)
  8013d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013dc:	8a 10                	mov    (%eax),%dl
  8013de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	38 c2                	cmp    %al,%dl
  8013e5:	74 16                	je     8013fd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8013e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ea:	8a 00                	mov    (%eax),%al
  8013ec:	0f b6 d0             	movzbl %al,%edx
  8013ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	0f b6 c0             	movzbl %al,%eax
  8013f7:	29 c2                	sub    %eax,%edx
  8013f9:	89 d0                	mov    %edx,%eax
  8013fb:	eb 18                	jmp    801415 <memcmp+0x50>
		s1++, s2++;
  8013fd:	ff 45 fc             	incl   -0x4(%ebp)
  801400:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801403:	8b 45 10             	mov    0x10(%ebp),%eax
  801406:	8d 50 ff             	lea    -0x1(%eax),%edx
  801409:	89 55 10             	mov    %edx,0x10(%ebp)
  80140c:	85 c0                	test   %eax,%eax
  80140e:	75 c9                	jne    8013d9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801410:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
  80141a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80141d:	8b 55 08             	mov    0x8(%ebp),%edx
  801420:	8b 45 10             	mov    0x10(%ebp),%eax
  801423:	01 d0                	add    %edx,%eax
  801425:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801428:	eb 15                	jmp    80143f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	0f b6 d0             	movzbl %al,%edx
  801432:	8b 45 0c             	mov    0xc(%ebp),%eax
  801435:	0f b6 c0             	movzbl %al,%eax
  801438:	39 c2                	cmp    %eax,%edx
  80143a:	74 0d                	je     801449 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80143c:	ff 45 08             	incl   0x8(%ebp)
  80143f:	8b 45 08             	mov    0x8(%ebp),%eax
  801442:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801445:	72 e3                	jb     80142a <memfind+0x13>
  801447:	eb 01                	jmp    80144a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801449:	90                   	nop
	return (void *) s;
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
  801452:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801455:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80145c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801463:	eb 03                	jmp    801468 <strtol+0x19>
		s++;
  801465:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	3c 20                	cmp    $0x20,%al
  80146f:	74 f4                	je     801465 <strtol+0x16>
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	3c 09                	cmp    $0x9,%al
  801478:	74 eb                	je     801465 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	8a 00                	mov    (%eax),%al
  80147f:	3c 2b                	cmp    $0x2b,%al
  801481:	75 05                	jne    801488 <strtol+0x39>
		s++;
  801483:	ff 45 08             	incl   0x8(%ebp)
  801486:	eb 13                	jmp    80149b <strtol+0x4c>
	else if (*s == '-')
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	3c 2d                	cmp    $0x2d,%al
  80148f:	75 0a                	jne    80149b <strtol+0x4c>
		s++, neg = 1;
  801491:	ff 45 08             	incl   0x8(%ebp)
  801494:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80149b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80149f:	74 06                	je     8014a7 <strtol+0x58>
  8014a1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014a5:	75 20                	jne    8014c7 <strtol+0x78>
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	8a 00                	mov    (%eax),%al
  8014ac:	3c 30                	cmp    $0x30,%al
  8014ae:	75 17                	jne    8014c7 <strtol+0x78>
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	40                   	inc    %eax
  8014b4:	8a 00                	mov    (%eax),%al
  8014b6:	3c 78                	cmp    $0x78,%al
  8014b8:	75 0d                	jne    8014c7 <strtol+0x78>
		s += 2, base = 16;
  8014ba:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8014be:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8014c5:	eb 28                	jmp    8014ef <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8014c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014cb:	75 15                	jne    8014e2 <strtol+0x93>
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	3c 30                	cmp    $0x30,%al
  8014d4:	75 0c                	jne    8014e2 <strtol+0x93>
		s++, base = 8;
  8014d6:	ff 45 08             	incl   0x8(%ebp)
  8014d9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8014e0:	eb 0d                	jmp    8014ef <strtol+0xa0>
	else if (base == 0)
  8014e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e6:	75 07                	jne    8014ef <strtol+0xa0>
		base = 10;
  8014e8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	3c 2f                	cmp    $0x2f,%al
  8014f6:	7e 19                	jle    801511 <strtol+0xc2>
  8014f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fb:	8a 00                	mov    (%eax),%al
  8014fd:	3c 39                	cmp    $0x39,%al
  8014ff:	7f 10                	jg     801511 <strtol+0xc2>
			dig = *s - '0';
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
  801504:	8a 00                	mov    (%eax),%al
  801506:	0f be c0             	movsbl %al,%eax
  801509:	83 e8 30             	sub    $0x30,%eax
  80150c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80150f:	eb 42                	jmp    801553 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	8a 00                	mov    (%eax),%al
  801516:	3c 60                	cmp    $0x60,%al
  801518:	7e 19                	jle    801533 <strtol+0xe4>
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	3c 7a                	cmp    $0x7a,%al
  801521:	7f 10                	jg     801533 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	8a 00                	mov    (%eax),%al
  801528:	0f be c0             	movsbl %al,%eax
  80152b:	83 e8 57             	sub    $0x57,%eax
  80152e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801531:	eb 20                	jmp    801553 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	8a 00                	mov    (%eax),%al
  801538:	3c 40                	cmp    $0x40,%al
  80153a:	7e 39                	jle    801575 <strtol+0x126>
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	8a 00                	mov    (%eax),%al
  801541:	3c 5a                	cmp    $0x5a,%al
  801543:	7f 30                	jg     801575 <strtol+0x126>
			dig = *s - 'A' + 10;
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	8a 00                	mov    (%eax),%al
  80154a:	0f be c0             	movsbl %al,%eax
  80154d:	83 e8 37             	sub    $0x37,%eax
  801550:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801553:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801556:	3b 45 10             	cmp    0x10(%ebp),%eax
  801559:	7d 19                	jge    801574 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80155b:	ff 45 08             	incl   0x8(%ebp)
  80155e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801561:	0f af 45 10          	imul   0x10(%ebp),%eax
  801565:	89 c2                	mov    %eax,%edx
  801567:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80156a:	01 d0                	add    %edx,%eax
  80156c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80156f:	e9 7b ff ff ff       	jmp    8014ef <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801574:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801575:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801579:	74 08                	je     801583 <strtol+0x134>
		*endptr = (char *) s;
  80157b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157e:	8b 55 08             	mov    0x8(%ebp),%edx
  801581:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801583:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801587:	74 07                	je     801590 <strtol+0x141>
  801589:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158c:	f7 d8                	neg    %eax
  80158e:	eb 03                	jmp    801593 <strtol+0x144>
  801590:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <ltostr>:

void
ltostr(long value, char *str)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80159b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015ad:	79 13                	jns    8015c2 <ltostr+0x2d>
	{
		neg = 1;
  8015af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8015bc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8015bf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8015ca:	99                   	cltd   
  8015cb:	f7 f9                	idiv   %ecx
  8015cd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8015d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d3:	8d 50 01             	lea    0x1(%eax),%edx
  8015d6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015d9:	89 c2                	mov    %eax,%edx
  8015db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015de:	01 d0                	add    %edx,%eax
  8015e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015e3:	83 c2 30             	add    $0x30,%edx
  8015e6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8015e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015eb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015f0:	f7 e9                	imul   %ecx
  8015f2:	c1 fa 02             	sar    $0x2,%edx
  8015f5:	89 c8                	mov    %ecx,%eax
  8015f7:	c1 f8 1f             	sar    $0x1f,%eax
  8015fa:	29 c2                	sub    %eax,%edx
  8015fc:	89 d0                	mov    %edx,%eax
  8015fe:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801601:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801604:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801609:	f7 e9                	imul   %ecx
  80160b:	c1 fa 02             	sar    $0x2,%edx
  80160e:	89 c8                	mov    %ecx,%eax
  801610:	c1 f8 1f             	sar    $0x1f,%eax
  801613:	29 c2                	sub    %eax,%edx
  801615:	89 d0                	mov    %edx,%eax
  801617:	c1 e0 02             	shl    $0x2,%eax
  80161a:	01 d0                	add    %edx,%eax
  80161c:	01 c0                	add    %eax,%eax
  80161e:	29 c1                	sub    %eax,%ecx
  801620:	89 ca                	mov    %ecx,%edx
  801622:	85 d2                	test   %edx,%edx
  801624:	75 9c                	jne    8015c2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801626:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80162d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801630:	48                   	dec    %eax
  801631:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801634:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801638:	74 3d                	je     801677 <ltostr+0xe2>
		start = 1 ;
  80163a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801641:	eb 34                	jmp    801677 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801643:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	01 d0                	add    %edx,%eax
  80164b:	8a 00                	mov    (%eax),%al
  80164d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801650:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801653:	8b 45 0c             	mov    0xc(%ebp),%eax
  801656:	01 c2                	add    %eax,%edx
  801658:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80165b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165e:	01 c8                	add    %ecx,%eax
  801660:	8a 00                	mov    (%eax),%al
  801662:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801664:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166a:	01 c2                	add    %eax,%edx
  80166c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80166f:	88 02                	mov    %al,(%edx)
		start++ ;
  801671:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801674:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801677:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80167d:	7c c4                	jl     801643 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80167f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801682:	8b 45 0c             	mov    0xc(%ebp),%eax
  801685:	01 d0                	add    %edx,%eax
  801687:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80168a:	90                   	nop
  80168b:	c9                   	leave  
  80168c:	c3                   	ret    

0080168d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80168d:	55                   	push   %ebp
  80168e:	89 e5                	mov    %esp,%ebp
  801690:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801693:	ff 75 08             	pushl  0x8(%ebp)
  801696:	e8 54 fa ff ff       	call   8010ef <strlen>
  80169b:	83 c4 04             	add    $0x4,%esp
  80169e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016a1:	ff 75 0c             	pushl  0xc(%ebp)
  8016a4:	e8 46 fa ff ff       	call   8010ef <strlen>
  8016a9:	83 c4 04             	add    $0x4,%esp
  8016ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016bd:	eb 17                	jmp    8016d6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8016bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c5:	01 c2                	add    %eax,%edx
  8016c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	01 c8                	add    %ecx,%eax
  8016cf:	8a 00                	mov    (%eax),%al
  8016d1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8016d3:	ff 45 fc             	incl   -0x4(%ebp)
  8016d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016dc:	7c e1                	jl     8016bf <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8016de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8016e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8016ec:	eb 1f                	jmp    80170d <strcconcat+0x80>
		final[s++] = str2[i] ;
  8016ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f1:	8d 50 01             	lea    0x1(%eax),%edx
  8016f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016f7:	89 c2                	mov    %eax,%edx
  8016f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fc:	01 c2                	add    %eax,%edx
  8016fe:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801701:	8b 45 0c             	mov    0xc(%ebp),%eax
  801704:	01 c8                	add    %ecx,%eax
  801706:	8a 00                	mov    (%eax),%al
  801708:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80170a:	ff 45 f8             	incl   -0x8(%ebp)
  80170d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801710:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801713:	7c d9                	jl     8016ee <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801715:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	c6 00 00             	movb   $0x0,(%eax)
}
  801720:	90                   	nop
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801726:	8b 45 14             	mov    0x14(%ebp),%eax
  801729:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80172f:	8b 45 14             	mov    0x14(%ebp),%eax
  801732:	8b 00                	mov    (%eax),%eax
  801734:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80173b:	8b 45 10             	mov    0x10(%ebp),%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801746:	eb 0c                	jmp    801754 <strsplit+0x31>
			*string++ = 0;
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	8d 50 01             	lea    0x1(%eax),%edx
  80174e:	89 55 08             	mov    %edx,0x8(%ebp)
  801751:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	8a 00                	mov    (%eax),%al
  801759:	84 c0                	test   %al,%al
  80175b:	74 18                	je     801775 <strsplit+0x52>
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	0f be c0             	movsbl %al,%eax
  801765:	50                   	push   %eax
  801766:	ff 75 0c             	pushl  0xc(%ebp)
  801769:	e8 13 fb ff ff       	call   801281 <strchr>
  80176e:	83 c4 08             	add    $0x8,%esp
  801771:	85 c0                	test   %eax,%eax
  801773:	75 d3                	jne    801748 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	8a 00                	mov    (%eax),%al
  80177a:	84 c0                	test   %al,%al
  80177c:	74 5a                	je     8017d8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80177e:	8b 45 14             	mov    0x14(%ebp),%eax
  801781:	8b 00                	mov    (%eax),%eax
  801783:	83 f8 0f             	cmp    $0xf,%eax
  801786:	75 07                	jne    80178f <strsplit+0x6c>
		{
			return 0;
  801788:	b8 00 00 00 00       	mov    $0x0,%eax
  80178d:	eb 66                	jmp    8017f5 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80178f:	8b 45 14             	mov    0x14(%ebp),%eax
  801792:	8b 00                	mov    (%eax),%eax
  801794:	8d 48 01             	lea    0x1(%eax),%ecx
  801797:	8b 55 14             	mov    0x14(%ebp),%edx
  80179a:	89 0a                	mov    %ecx,(%edx)
  80179c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a6:	01 c2                	add    %eax,%edx
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017ad:	eb 03                	jmp    8017b2 <strsplit+0x8f>
			string++;
  8017af:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b5:	8a 00                	mov    (%eax),%al
  8017b7:	84 c0                	test   %al,%al
  8017b9:	74 8b                	je     801746 <strsplit+0x23>
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	8a 00                	mov    (%eax),%al
  8017c0:	0f be c0             	movsbl %al,%eax
  8017c3:	50                   	push   %eax
  8017c4:	ff 75 0c             	pushl  0xc(%ebp)
  8017c7:	e8 b5 fa ff ff       	call   801281 <strchr>
  8017cc:	83 c4 08             	add    $0x8,%esp
  8017cf:	85 c0                	test   %eax,%eax
  8017d1:	74 dc                	je     8017af <strsplit+0x8c>
			string++;
	}
  8017d3:	e9 6e ff ff ff       	jmp    801746 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8017d8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8017d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8017dc:	8b 00                	mov    (%eax),%eax
  8017de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e8:	01 d0                	add    %edx,%eax
  8017ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8017f0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
  8017fa:	57                   	push   %edi
  8017fb:	56                   	push   %esi
  8017fc:	53                   	push   %ebx
  8017fd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	8b 55 0c             	mov    0xc(%ebp),%edx
  801806:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801809:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80180c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80180f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801812:	cd 30                	int    $0x30
  801814:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801817:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80181a:	83 c4 10             	add    $0x10,%esp
  80181d:	5b                   	pop    %ebx
  80181e:	5e                   	pop    %esi
  80181f:	5f                   	pop    %edi
  801820:	5d                   	pop    %ebp
  801821:	c3                   	ret    

00801822 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	83 ec 04             	sub    $0x4,%esp
  801828:	8b 45 10             	mov    0x10(%ebp),%eax
  80182b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80182e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	52                   	push   %edx
  80183a:	ff 75 0c             	pushl  0xc(%ebp)
  80183d:	50                   	push   %eax
  80183e:	6a 00                	push   $0x0
  801840:	e8 b2 ff ff ff       	call   8017f7 <syscall>
  801845:	83 c4 18             	add    $0x18,%esp
}
  801848:	90                   	nop
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_cgetc>:

int
sys_cgetc(void)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 01                	push   $0x1
  80185a:	e8 98 ff ff ff       	call   8017f7 <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	50                   	push   %eax
  801873:	6a 05                	push   $0x5
  801875:	e8 7d ff ff ff       	call   8017f7 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 02                	push   $0x2
  80188e:	e8 64 ff ff ff       	call   8017f7 <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 03                	push   $0x3
  8018a7:	e8 4b ff ff ff       	call   8017f7 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 04                	push   $0x4
  8018c0:	e8 32 ff ff ff       	call   8017f7 <syscall>
  8018c5:	83 c4 18             	add    $0x18,%esp
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_env_exit>:


void sys_env_exit(void)
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 06                	push   $0x6
  8018d9:	e8 19 ff ff ff       	call   8017f7 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	90                   	nop
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	52                   	push   %edx
  8018f4:	50                   	push   %eax
  8018f5:	6a 07                	push   $0x7
  8018f7:	e8 fb fe ff ff       	call   8017f7 <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
}
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
  801904:	56                   	push   %esi
  801905:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801906:	8b 75 18             	mov    0x18(%ebp),%esi
  801909:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80190c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80190f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	56                   	push   %esi
  801916:	53                   	push   %ebx
  801917:	51                   	push   %ecx
  801918:	52                   	push   %edx
  801919:	50                   	push   %eax
  80191a:	6a 08                	push   $0x8
  80191c:	e8 d6 fe ff ff       	call   8017f7 <syscall>
  801921:	83 c4 18             	add    $0x18,%esp
}
  801924:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801927:	5b                   	pop    %ebx
  801928:	5e                   	pop    %esi
  801929:	5d                   	pop    %ebp
  80192a:	c3                   	ret    

0080192b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80192e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	52                   	push   %edx
  80193b:	50                   	push   %eax
  80193c:	6a 09                	push   $0x9
  80193e:	e8 b4 fe ff ff       	call   8017f7 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	ff 75 0c             	pushl  0xc(%ebp)
  801954:	ff 75 08             	pushl  0x8(%ebp)
  801957:	6a 0a                	push   $0xa
  801959:	e8 99 fe ff ff       	call   8017f7 <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
}
  801961:	c9                   	leave  
  801962:	c3                   	ret    

00801963 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 0b                	push   $0xb
  801972:	e8 80 fe ff ff       	call   8017f7 <syscall>
  801977:	83 c4 18             	add    $0x18,%esp
}
  80197a:	c9                   	leave  
  80197b:	c3                   	ret    

0080197c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 0c                	push   $0xc
  80198b:	e8 67 fe ff ff       	call   8017f7 <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 0d                	push   $0xd
  8019a4:	e8 4e fe ff ff       	call   8017f7 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ba:	ff 75 08             	pushl  0x8(%ebp)
  8019bd:	6a 11                	push   $0x11
  8019bf:	e8 33 fe ff ff       	call   8017f7 <syscall>
  8019c4:	83 c4 18             	add    $0x18,%esp
	return;
  8019c7:	90                   	nop
}
  8019c8:	c9                   	leave  
  8019c9:	c3                   	ret    

008019ca <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	ff 75 0c             	pushl  0xc(%ebp)
  8019d6:	ff 75 08             	pushl  0x8(%ebp)
  8019d9:	6a 12                	push   $0x12
  8019db:	e8 17 fe ff ff       	call   8017f7 <syscall>
  8019e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e3:	90                   	nop
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 0e                	push   $0xe
  8019f5:	e8 fd fd ff ff       	call   8017f7 <syscall>
  8019fa:	83 c4 18             	add    $0x18,%esp
}
  8019fd:	c9                   	leave  
  8019fe:	c3                   	ret    

008019ff <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	ff 75 08             	pushl  0x8(%ebp)
  801a0d:	6a 0f                	push   $0xf
  801a0f:	e8 e3 fd ff ff       	call   8017f7 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 10                	push   $0x10
  801a28:	e8 ca fd ff ff       	call   8017f7 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	90                   	nop
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 14                	push   $0x14
  801a42:	e8 b0 fd ff ff       	call   8017f7 <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
}
  801a4a:	90                   	nop
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 15                	push   $0x15
  801a5c:	e8 96 fd ff ff       	call   8017f7 <syscall>
  801a61:	83 c4 18             	add    $0x18,%esp
}
  801a64:	90                   	nop
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
  801a6a:	83 ec 04             	sub    $0x4,%esp
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a73:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	50                   	push   %eax
  801a80:	6a 16                	push   $0x16
  801a82:	e8 70 fd ff ff       	call   8017f7 <syscall>
  801a87:	83 c4 18             	add    $0x18,%esp
}
  801a8a:	90                   	nop
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 17                	push   $0x17
  801a9c:	e8 56 fd ff ff       	call   8017f7 <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	90                   	nop
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	ff 75 0c             	pushl  0xc(%ebp)
  801ab6:	50                   	push   %eax
  801ab7:	6a 18                	push   $0x18
  801ab9:	e8 39 fd ff ff       	call   8017f7 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	52                   	push   %edx
  801ad3:	50                   	push   %eax
  801ad4:	6a 1b                	push   $0x1b
  801ad6:	e8 1c fd ff ff       	call   8017f7 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	52                   	push   %edx
  801af0:	50                   	push   %eax
  801af1:	6a 19                	push   $0x19
  801af3:	e8 ff fc ff ff       	call   8017f7 <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	90                   	nop
  801afc:	c9                   	leave  
  801afd:	c3                   	ret    

00801afe <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b04:	8b 45 08             	mov    0x8(%ebp),%eax
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	52                   	push   %edx
  801b0e:	50                   	push   %eax
  801b0f:	6a 1a                	push   $0x1a
  801b11:	e8 e1 fc ff ff       	call   8017f7 <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	90                   	nop
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
  801b1f:	83 ec 04             	sub    $0x4,%esp
  801b22:	8b 45 10             	mov    0x10(%ebp),%eax
  801b25:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b28:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b2b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b32:	6a 00                	push   $0x0
  801b34:	51                   	push   %ecx
  801b35:	52                   	push   %edx
  801b36:	ff 75 0c             	pushl  0xc(%ebp)
  801b39:	50                   	push   %eax
  801b3a:	6a 1c                	push   $0x1c
  801b3c:	e8 b6 fc ff ff       	call   8017f7 <syscall>
  801b41:	83 c4 18             	add    $0x18,%esp
}
  801b44:	c9                   	leave  
  801b45:	c3                   	ret    

00801b46 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	52                   	push   %edx
  801b56:	50                   	push   %eax
  801b57:	6a 1d                	push   $0x1d
  801b59:	e8 99 fc ff ff       	call   8017f7 <syscall>
  801b5e:	83 c4 18             	add    $0x18,%esp
}
  801b61:	c9                   	leave  
  801b62:	c3                   	ret    

00801b63 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b66:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b69:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	51                   	push   %ecx
  801b74:	52                   	push   %edx
  801b75:	50                   	push   %eax
  801b76:	6a 1e                	push   $0x1e
  801b78:	e8 7a fc ff ff       	call   8017f7 <syscall>
  801b7d:	83 c4 18             	add    $0x18,%esp
}
  801b80:	c9                   	leave  
  801b81:	c3                   	ret    

00801b82 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b82:	55                   	push   %ebp
  801b83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b85:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b88:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	52                   	push   %edx
  801b92:	50                   	push   %eax
  801b93:	6a 1f                	push   $0x1f
  801b95:	e8 5d fc ff ff       	call   8017f7 <syscall>
  801b9a:	83 c4 18             	add    $0x18,%esp
}
  801b9d:	c9                   	leave  
  801b9e:	c3                   	ret    

00801b9f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b9f:	55                   	push   %ebp
  801ba0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 20                	push   $0x20
  801bae:	e8 44 fc ff ff       	call   8017f7 <syscall>
  801bb3:	83 c4 18             	add    $0x18,%esp
}
  801bb6:	c9                   	leave  
  801bb7:	c3                   	ret    

00801bb8 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	ff 75 10             	pushl  0x10(%ebp)
  801bc5:	ff 75 0c             	pushl  0xc(%ebp)
  801bc8:	50                   	push   %eax
  801bc9:	6a 21                	push   $0x21
  801bcb:	e8 27 fc ff ff       	call   8017f7 <syscall>
  801bd0:	83 c4 18             	add    $0x18,%esp
}
  801bd3:	c9                   	leave  
  801bd4:	c3                   	ret    

00801bd5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	50                   	push   %eax
  801be4:	6a 22                	push   $0x22
  801be6:	e8 0c fc ff ff       	call   8017f7 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	90                   	nop
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	50                   	push   %eax
  801c00:	6a 23                	push   $0x23
  801c02:	e8 f0 fb ff ff       	call   8017f7 <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	90                   	nop
  801c0b:	c9                   	leave  
  801c0c:	c3                   	ret    

00801c0d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c0d:	55                   	push   %ebp
  801c0e:	89 e5                	mov    %esp,%ebp
  801c10:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c13:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c16:	8d 50 04             	lea    0x4(%eax),%edx
  801c19:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	52                   	push   %edx
  801c23:	50                   	push   %eax
  801c24:	6a 24                	push   $0x24
  801c26:	e8 cc fb ff ff       	call   8017f7 <syscall>
  801c2b:	83 c4 18             	add    $0x18,%esp
	return result;
  801c2e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c31:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c34:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c37:	89 01                	mov    %eax,(%ecx)
  801c39:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3f:	c9                   	leave  
  801c40:	c2 04 00             	ret    $0x4

00801c43 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	ff 75 10             	pushl  0x10(%ebp)
  801c4d:	ff 75 0c             	pushl  0xc(%ebp)
  801c50:	ff 75 08             	pushl  0x8(%ebp)
  801c53:	6a 13                	push   $0x13
  801c55:	e8 9d fb ff ff       	call   8017f7 <syscall>
  801c5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5d:	90                   	nop
}
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 25                	push   $0x25
  801c6f:	e8 83 fb ff ff       	call   8017f7 <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
  801c7c:	83 ec 04             	sub    $0x4,%esp
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c85:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	50                   	push   %eax
  801c92:	6a 26                	push   $0x26
  801c94:	e8 5e fb ff ff       	call   8017f7 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
	return ;
  801c9c:	90                   	nop
}
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <rsttst>:
void rsttst()
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 28                	push   $0x28
  801cae:	e8 44 fb ff ff       	call   8017f7 <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb6:	90                   	nop
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
  801cbc:	83 ec 04             	sub    $0x4,%esp
  801cbf:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cc5:	8b 55 18             	mov    0x18(%ebp),%edx
  801cc8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ccc:	52                   	push   %edx
  801ccd:	50                   	push   %eax
  801cce:	ff 75 10             	pushl  0x10(%ebp)
  801cd1:	ff 75 0c             	pushl  0xc(%ebp)
  801cd4:	ff 75 08             	pushl  0x8(%ebp)
  801cd7:	6a 27                	push   $0x27
  801cd9:	e8 19 fb ff ff       	call   8017f7 <syscall>
  801cde:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce1:	90                   	nop
}
  801ce2:	c9                   	leave  
  801ce3:	c3                   	ret    

00801ce4 <chktst>:
void chktst(uint32 n)
{
  801ce4:	55                   	push   %ebp
  801ce5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	ff 75 08             	pushl  0x8(%ebp)
  801cf2:	6a 29                	push   $0x29
  801cf4:	e8 fe fa ff ff       	call   8017f7 <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
	return ;
  801cfc:	90                   	nop
}
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <inctst>:

void inctst()
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 2a                	push   $0x2a
  801d0e:	e8 e4 fa ff ff       	call   8017f7 <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
	return ;
  801d16:	90                   	nop
}
  801d17:	c9                   	leave  
  801d18:	c3                   	ret    

00801d19 <gettst>:
uint32 gettst()
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 2b                	push   $0x2b
  801d28:	e8 ca fa ff ff       	call   8017f7 <syscall>
  801d2d:	83 c4 18             	add    $0x18,%esp
}
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    

00801d32 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
  801d35:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 2c                	push   $0x2c
  801d44:	e8 ae fa ff ff       	call   8017f7 <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
  801d4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d4f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d53:	75 07                	jne    801d5c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d55:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5a:	eb 05                	jmp    801d61 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
  801d66:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 2c                	push   $0x2c
  801d75:	e8 7d fa ff ff       	call   8017f7 <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
  801d7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d80:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d84:	75 07                	jne    801d8d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d86:	b8 01 00 00 00       	mov    $0x1,%eax
  801d8b:	eb 05                	jmp    801d92 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
  801d97:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 2c                	push   $0x2c
  801da6:	e8 4c fa ff ff       	call   8017f7 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
  801dae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801db1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801db5:	75 07                	jne    801dbe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801db7:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbc:	eb 05                	jmp    801dc3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801dbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
  801dc8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 2c                	push   $0x2c
  801dd7:	e8 1b fa ff ff       	call   8017f7 <syscall>
  801ddc:	83 c4 18             	add    $0x18,%esp
  801ddf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801de2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801de6:	75 07                	jne    801def <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801de8:	b8 01 00 00 00       	mov    $0x1,%eax
  801ded:	eb 05                	jmp    801df4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801def:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801df4:	c9                   	leave  
  801df5:	c3                   	ret    

00801df6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801df6:	55                   	push   %ebp
  801df7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	ff 75 08             	pushl  0x8(%ebp)
  801e04:	6a 2d                	push   $0x2d
  801e06:	e8 ec f9 ff ff       	call   8017f7 <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801e0e:	90                   	nop
}
  801e0f:	c9                   	leave  
  801e10:	c3                   	ret    

00801e11 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801e11:	55                   	push   %ebp
  801e12:	89 e5                	mov    %esp,%ebp
  801e14:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801e17:	8b 55 08             	mov    0x8(%ebp),%edx
  801e1a:	89 d0                	mov    %edx,%eax
  801e1c:	c1 e0 02             	shl    $0x2,%eax
  801e1f:	01 d0                	add    %edx,%eax
  801e21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e28:	01 d0                	add    %edx,%eax
  801e2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e31:	01 d0                	add    %edx,%eax
  801e33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e3a:	01 d0                	add    %edx,%eax
  801e3c:	c1 e0 04             	shl    $0x4,%eax
  801e3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801e42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801e49:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801e4c:	83 ec 0c             	sub    $0xc,%esp
  801e4f:	50                   	push   %eax
  801e50:	e8 b8 fd ff ff       	call   801c0d <sys_get_virtual_time>
  801e55:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801e58:	eb 41                	jmp    801e9b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801e5a:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801e5d:	83 ec 0c             	sub    $0xc,%esp
  801e60:	50                   	push   %eax
  801e61:	e8 a7 fd ff ff       	call   801c0d <sys_get_virtual_time>
  801e66:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801e69:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e6c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e6f:	29 c2                	sub    %eax,%edx
  801e71:	89 d0                	mov    %edx,%eax
  801e73:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801e76:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e79:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e7c:	89 d1                	mov    %edx,%ecx
  801e7e:	29 c1                	sub    %eax,%ecx
  801e80:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801e83:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e86:	39 c2                	cmp    %eax,%edx
  801e88:	0f 97 c0             	seta   %al
  801e8b:	0f b6 c0             	movzbl %al,%eax
  801e8e:	29 c1                	sub    %eax,%ecx
  801e90:	89 c8                	mov    %ecx,%eax
  801e92:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801e95:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e98:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801e9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e9e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ea1:	72 b7                	jb     801e5a <env_sleep+0x49>
//				,cycles_counter
//				);
	}
//	cprintf("%s wake up now!\n", myEnv->prog_name);

}
  801ea3:	90                   	nop
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
  801ea9:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801eac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801eb3:	eb 03                	jmp    801eb8 <busy_wait+0x12>
  801eb5:	ff 45 fc             	incl   -0x4(%ebp)
  801eb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ebb:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ebe:	72 f5                	jb     801eb5 <busy_wait+0xf>
	return i;
  801ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    
  801ec5:	66 90                	xchg   %ax,%ax
  801ec7:	90                   	nop

00801ec8 <__udivdi3>:
  801ec8:	55                   	push   %ebp
  801ec9:	57                   	push   %edi
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
  801ecc:	83 ec 1c             	sub    $0x1c,%esp
  801ecf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ed3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ed7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801edf:	89 ca                	mov    %ecx,%edx
  801ee1:	89 f8                	mov    %edi,%eax
  801ee3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ee7:	85 f6                	test   %esi,%esi
  801ee9:	75 2d                	jne    801f18 <__udivdi3+0x50>
  801eeb:	39 cf                	cmp    %ecx,%edi
  801eed:	77 65                	ja     801f54 <__udivdi3+0x8c>
  801eef:	89 fd                	mov    %edi,%ebp
  801ef1:	85 ff                	test   %edi,%edi
  801ef3:	75 0b                	jne    801f00 <__udivdi3+0x38>
  801ef5:	b8 01 00 00 00       	mov    $0x1,%eax
  801efa:	31 d2                	xor    %edx,%edx
  801efc:	f7 f7                	div    %edi
  801efe:	89 c5                	mov    %eax,%ebp
  801f00:	31 d2                	xor    %edx,%edx
  801f02:	89 c8                	mov    %ecx,%eax
  801f04:	f7 f5                	div    %ebp
  801f06:	89 c1                	mov    %eax,%ecx
  801f08:	89 d8                	mov    %ebx,%eax
  801f0a:	f7 f5                	div    %ebp
  801f0c:	89 cf                	mov    %ecx,%edi
  801f0e:	89 fa                	mov    %edi,%edx
  801f10:	83 c4 1c             	add    $0x1c,%esp
  801f13:	5b                   	pop    %ebx
  801f14:	5e                   	pop    %esi
  801f15:	5f                   	pop    %edi
  801f16:	5d                   	pop    %ebp
  801f17:	c3                   	ret    
  801f18:	39 ce                	cmp    %ecx,%esi
  801f1a:	77 28                	ja     801f44 <__udivdi3+0x7c>
  801f1c:	0f bd fe             	bsr    %esi,%edi
  801f1f:	83 f7 1f             	xor    $0x1f,%edi
  801f22:	75 40                	jne    801f64 <__udivdi3+0x9c>
  801f24:	39 ce                	cmp    %ecx,%esi
  801f26:	72 0a                	jb     801f32 <__udivdi3+0x6a>
  801f28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f2c:	0f 87 9e 00 00 00    	ja     801fd0 <__udivdi3+0x108>
  801f32:	b8 01 00 00 00       	mov    $0x1,%eax
  801f37:	89 fa                	mov    %edi,%edx
  801f39:	83 c4 1c             	add    $0x1c,%esp
  801f3c:	5b                   	pop    %ebx
  801f3d:	5e                   	pop    %esi
  801f3e:	5f                   	pop    %edi
  801f3f:	5d                   	pop    %ebp
  801f40:	c3                   	ret    
  801f41:	8d 76 00             	lea    0x0(%esi),%esi
  801f44:	31 ff                	xor    %edi,%edi
  801f46:	31 c0                	xor    %eax,%eax
  801f48:	89 fa                	mov    %edi,%edx
  801f4a:	83 c4 1c             	add    $0x1c,%esp
  801f4d:	5b                   	pop    %ebx
  801f4e:	5e                   	pop    %esi
  801f4f:	5f                   	pop    %edi
  801f50:	5d                   	pop    %ebp
  801f51:	c3                   	ret    
  801f52:	66 90                	xchg   %ax,%ax
  801f54:	89 d8                	mov    %ebx,%eax
  801f56:	f7 f7                	div    %edi
  801f58:	31 ff                	xor    %edi,%edi
  801f5a:	89 fa                	mov    %edi,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f69:	89 eb                	mov    %ebp,%ebx
  801f6b:	29 fb                	sub    %edi,%ebx
  801f6d:	89 f9                	mov    %edi,%ecx
  801f6f:	d3 e6                	shl    %cl,%esi
  801f71:	89 c5                	mov    %eax,%ebp
  801f73:	88 d9                	mov    %bl,%cl
  801f75:	d3 ed                	shr    %cl,%ebp
  801f77:	89 e9                	mov    %ebp,%ecx
  801f79:	09 f1                	or     %esi,%ecx
  801f7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f7f:	89 f9                	mov    %edi,%ecx
  801f81:	d3 e0                	shl    %cl,%eax
  801f83:	89 c5                	mov    %eax,%ebp
  801f85:	89 d6                	mov    %edx,%esi
  801f87:	88 d9                	mov    %bl,%cl
  801f89:	d3 ee                	shr    %cl,%esi
  801f8b:	89 f9                	mov    %edi,%ecx
  801f8d:	d3 e2                	shl    %cl,%edx
  801f8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f93:	88 d9                	mov    %bl,%cl
  801f95:	d3 e8                	shr    %cl,%eax
  801f97:	09 c2                	or     %eax,%edx
  801f99:	89 d0                	mov    %edx,%eax
  801f9b:	89 f2                	mov    %esi,%edx
  801f9d:	f7 74 24 0c          	divl   0xc(%esp)
  801fa1:	89 d6                	mov    %edx,%esi
  801fa3:	89 c3                	mov    %eax,%ebx
  801fa5:	f7 e5                	mul    %ebp
  801fa7:	39 d6                	cmp    %edx,%esi
  801fa9:	72 19                	jb     801fc4 <__udivdi3+0xfc>
  801fab:	74 0b                	je     801fb8 <__udivdi3+0xf0>
  801fad:	89 d8                	mov    %ebx,%eax
  801faf:	31 ff                	xor    %edi,%edi
  801fb1:	e9 58 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fb6:	66 90                	xchg   %ax,%ax
  801fb8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fbc:	89 f9                	mov    %edi,%ecx
  801fbe:	d3 e2                	shl    %cl,%edx
  801fc0:	39 c2                	cmp    %eax,%edx
  801fc2:	73 e9                	jae    801fad <__udivdi3+0xe5>
  801fc4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fc7:	31 ff                	xor    %edi,%edi
  801fc9:	e9 40 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fce:	66 90                	xchg   %ax,%ax
  801fd0:	31 c0                	xor    %eax,%eax
  801fd2:	e9 37 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fd7:	90                   	nop

00801fd8 <__umoddi3>:
  801fd8:	55                   	push   %ebp
  801fd9:	57                   	push   %edi
  801fda:	56                   	push   %esi
  801fdb:	53                   	push   %ebx
  801fdc:	83 ec 1c             	sub    $0x1c,%esp
  801fdf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fe3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fe7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801feb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ff3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ff7:	89 f3                	mov    %esi,%ebx
  801ff9:	89 fa                	mov    %edi,%edx
  801ffb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fff:	89 34 24             	mov    %esi,(%esp)
  802002:	85 c0                	test   %eax,%eax
  802004:	75 1a                	jne    802020 <__umoddi3+0x48>
  802006:	39 f7                	cmp    %esi,%edi
  802008:	0f 86 a2 00 00 00    	jbe    8020b0 <__umoddi3+0xd8>
  80200e:	89 c8                	mov    %ecx,%eax
  802010:	89 f2                	mov    %esi,%edx
  802012:	f7 f7                	div    %edi
  802014:	89 d0                	mov    %edx,%eax
  802016:	31 d2                	xor    %edx,%edx
  802018:	83 c4 1c             	add    $0x1c,%esp
  80201b:	5b                   	pop    %ebx
  80201c:	5e                   	pop    %esi
  80201d:	5f                   	pop    %edi
  80201e:	5d                   	pop    %ebp
  80201f:	c3                   	ret    
  802020:	39 f0                	cmp    %esi,%eax
  802022:	0f 87 ac 00 00 00    	ja     8020d4 <__umoddi3+0xfc>
  802028:	0f bd e8             	bsr    %eax,%ebp
  80202b:	83 f5 1f             	xor    $0x1f,%ebp
  80202e:	0f 84 ac 00 00 00    	je     8020e0 <__umoddi3+0x108>
  802034:	bf 20 00 00 00       	mov    $0x20,%edi
  802039:	29 ef                	sub    %ebp,%edi
  80203b:	89 fe                	mov    %edi,%esi
  80203d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802041:	89 e9                	mov    %ebp,%ecx
  802043:	d3 e0                	shl    %cl,%eax
  802045:	89 d7                	mov    %edx,%edi
  802047:	89 f1                	mov    %esi,%ecx
  802049:	d3 ef                	shr    %cl,%edi
  80204b:	09 c7                	or     %eax,%edi
  80204d:	89 e9                	mov    %ebp,%ecx
  80204f:	d3 e2                	shl    %cl,%edx
  802051:	89 14 24             	mov    %edx,(%esp)
  802054:	89 d8                	mov    %ebx,%eax
  802056:	d3 e0                	shl    %cl,%eax
  802058:	89 c2                	mov    %eax,%edx
  80205a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80205e:	d3 e0                	shl    %cl,%eax
  802060:	89 44 24 04          	mov    %eax,0x4(%esp)
  802064:	8b 44 24 08          	mov    0x8(%esp),%eax
  802068:	89 f1                	mov    %esi,%ecx
  80206a:	d3 e8                	shr    %cl,%eax
  80206c:	09 d0                	or     %edx,%eax
  80206e:	d3 eb                	shr    %cl,%ebx
  802070:	89 da                	mov    %ebx,%edx
  802072:	f7 f7                	div    %edi
  802074:	89 d3                	mov    %edx,%ebx
  802076:	f7 24 24             	mull   (%esp)
  802079:	89 c6                	mov    %eax,%esi
  80207b:	89 d1                	mov    %edx,%ecx
  80207d:	39 d3                	cmp    %edx,%ebx
  80207f:	0f 82 87 00 00 00    	jb     80210c <__umoddi3+0x134>
  802085:	0f 84 91 00 00 00    	je     80211c <__umoddi3+0x144>
  80208b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80208f:	29 f2                	sub    %esi,%edx
  802091:	19 cb                	sbb    %ecx,%ebx
  802093:	89 d8                	mov    %ebx,%eax
  802095:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802099:	d3 e0                	shl    %cl,%eax
  80209b:	89 e9                	mov    %ebp,%ecx
  80209d:	d3 ea                	shr    %cl,%edx
  80209f:	09 d0                	or     %edx,%eax
  8020a1:	89 e9                	mov    %ebp,%ecx
  8020a3:	d3 eb                	shr    %cl,%ebx
  8020a5:	89 da                	mov    %ebx,%edx
  8020a7:	83 c4 1c             	add    $0x1c,%esp
  8020aa:	5b                   	pop    %ebx
  8020ab:	5e                   	pop    %esi
  8020ac:	5f                   	pop    %edi
  8020ad:	5d                   	pop    %ebp
  8020ae:	c3                   	ret    
  8020af:	90                   	nop
  8020b0:	89 fd                	mov    %edi,%ebp
  8020b2:	85 ff                	test   %edi,%edi
  8020b4:	75 0b                	jne    8020c1 <__umoddi3+0xe9>
  8020b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bb:	31 d2                	xor    %edx,%edx
  8020bd:	f7 f7                	div    %edi
  8020bf:	89 c5                	mov    %eax,%ebp
  8020c1:	89 f0                	mov    %esi,%eax
  8020c3:	31 d2                	xor    %edx,%edx
  8020c5:	f7 f5                	div    %ebp
  8020c7:	89 c8                	mov    %ecx,%eax
  8020c9:	f7 f5                	div    %ebp
  8020cb:	89 d0                	mov    %edx,%eax
  8020cd:	e9 44 ff ff ff       	jmp    802016 <__umoddi3+0x3e>
  8020d2:	66 90                	xchg   %ax,%ax
  8020d4:	89 c8                	mov    %ecx,%eax
  8020d6:	89 f2                	mov    %esi,%edx
  8020d8:	83 c4 1c             	add    $0x1c,%esp
  8020db:	5b                   	pop    %ebx
  8020dc:	5e                   	pop    %esi
  8020dd:	5f                   	pop    %edi
  8020de:	5d                   	pop    %ebp
  8020df:	c3                   	ret    
  8020e0:	3b 04 24             	cmp    (%esp),%eax
  8020e3:	72 06                	jb     8020eb <__umoddi3+0x113>
  8020e5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020e9:	77 0f                	ja     8020fa <__umoddi3+0x122>
  8020eb:	89 f2                	mov    %esi,%edx
  8020ed:	29 f9                	sub    %edi,%ecx
  8020ef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020f3:	89 14 24             	mov    %edx,(%esp)
  8020f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020fa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020fe:	8b 14 24             	mov    (%esp),%edx
  802101:	83 c4 1c             	add    $0x1c,%esp
  802104:	5b                   	pop    %ebx
  802105:	5e                   	pop    %esi
  802106:	5f                   	pop    %edi
  802107:	5d                   	pop    %ebp
  802108:	c3                   	ret    
  802109:	8d 76 00             	lea    0x0(%esi),%esi
  80210c:	2b 04 24             	sub    (%esp),%eax
  80210f:	19 fa                	sbb    %edi,%edx
  802111:	89 d1                	mov    %edx,%ecx
  802113:	89 c6                	mov    %eax,%esi
  802115:	e9 71 ff ff ff       	jmp    80208b <__umoddi3+0xb3>
  80211a:	66 90                	xchg   %ax,%ax
  80211c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802120:	72 ea                	jb     80210c <__umoddi3+0x134>
  802122:	89 d9                	mov    %ebx,%ecx
  802124:	e9 62 ff ff ff       	jmp    80208b <__umoddi3+0xb3>
