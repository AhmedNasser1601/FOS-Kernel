
obj/user/tst_free_3:     file format elf32-i386


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
  800031:	e8 08 14 00 00       	call   80143e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

#define numOfAccessesFor3MB 7
#define numOfAccessesFor8MB 4
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 7c 01 00 00    	sub    $0x17c,%esp



	int Mega = 1024*1024;
  800044:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)
	int kilo = 1024;
  80004b:	c7 45 d0 00 04 00 00 	movl   $0x400,-0x30(%ebp)
	char minByte = 1<<7;
  800052:	c6 45 cf 80          	movb   $0x80,-0x31(%ebp)
	char maxByte = 0x7F;
  800056:	c6 45 ce 7f          	movb   $0x7f,-0x32(%ebp)
	short minShort = 1<<15 ;
  80005a:	66 c7 45 cc 00 80    	movw   $0x8000,-0x34(%ebp)
	short maxShort = 0x7FFF;
  800060:	66 c7 45 ca ff 7f    	movw   $0x7fff,-0x36(%ebp)
	int minInt = 1<<31 ;
  800066:	c7 45 c4 00 00 00 80 	movl   $0x80000000,-0x3c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006d:	c7 45 c0 ff ff ff 7f 	movl   $0x7fffffff,-0x40(%ebp)
	int *intArr;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 04 40 80 00       	mov    0x804004,%eax
  800079:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800084:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 c0 2e 80 00       	push   $0x802ec0
  80009b:	6a 1e                	push   $0x1e
  80009d:	68 01 2f 80 00       	push   $0x802f01
  8000a2:	e8 a6 14 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 04 40 80 00       	mov    0x804004,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 0c             	add    $0xc,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8000ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 c0 2e 80 00       	push   $0x802ec0
  8000d1:	6a 1f                	push   $0x1f
  8000d3:	68 01 2f 80 00       	push   $0x802f01
  8000d8:	e8 70 14 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 04 40 80 00       	mov    0x804004,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 18             	add    $0x18,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8000f0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 c0 2e 80 00       	push   $0x802ec0
  800107:	6a 20                	push   $0x20
  800109:	68 01 2f 80 00       	push   $0x802f01
  80010e:	e8 3a 14 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 04 40 80 00       	mov    0x804004,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 24             	add    $0x24,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800126:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 c0 2e 80 00       	push   $0x802ec0
  80013d:	6a 21                	push   $0x21
  80013f:	68 01 2f 80 00       	push   $0x802f01
  800144:	e8 04 14 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 04 40 80 00       	mov    0x804004,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 30             	add    $0x30,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80015c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 c0 2e 80 00       	push   $0x802ec0
  800173:	6a 22                	push   $0x22
  800175:	68 01 2f 80 00       	push   $0x802f01
  80017a:	e8 ce 13 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 04 40 80 00       	mov    0x804004,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 3c             	add    $0x3c,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800192:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 c0 2e 80 00       	push   $0x802ec0
  8001a9:	6a 23                	push   $0x23
  8001ab:	68 01 2f 80 00       	push   $0x802f01
  8001b0:	e8 98 13 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 04 40 80 00       	mov    0x804004,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 48             	add    $0x48,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8001c8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 c0 2e 80 00       	push   $0x802ec0
  8001df:	6a 24                	push   $0x24
  8001e1:	68 01 2f 80 00       	push   $0x802f01
  8001e6:	e8 62 13 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 04 40 80 00       	mov    0x804004,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 54             	add    $0x54,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8001fe:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 c0 2e 80 00       	push   $0x802ec0
  800215:	6a 25                	push   $0x25
  800217:	68 01 2f 80 00       	push   $0x802f01
  80021c:	e8 2c 13 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 04 40 80 00       	mov    0x804004,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 60             	add    $0x60,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800234:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 c0 2e 80 00       	push   $0x802ec0
  80024b:	6a 26                	push   $0x26
  80024d:	68 01 2f 80 00       	push   $0x802f01
  800252:	e8 f6 12 00 00       	call   80154d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 04 40 80 00       	mov    0x804004,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 6c             	add    $0x6c,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 98             	mov    %eax,-0x68(%ebp)
  80026a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 c0 2e 80 00       	push   $0x802ec0
  800281:	6a 27                	push   $0x27
  800283:	68 01 2f 80 00       	push   $0x802f01
  800288:	e8 c0 12 00 00       	call   80154d <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028d:	a1 04 40 80 00       	mov    0x804004,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 14 2f 80 00       	push   $0x802f14
  8002a4:	6a 28                	push   $0x28
  8002a6:	68 01 2f 80 00       	push   $0x802f01
  8002ab:	e8 9d 12 00 00       	call   80154d <_panic>
	}

	int start_freeFrames = sys_calculate_free_frames() ;
  8002b0:	e8 e4 24 00 00       	call   802799 <sys_calculate_free_frames>
  8002b5:	89 45 94             	mov    %eax,-0x6c(%ebp)

	int indicesOf3MB[numOfAccessesFor3MB];
	int indicesOf8MB[numOfAccessesFor8MB];
	int var, i, j;

	void* ptr_allocations[20] = {0};
  8002b8:	8d 95 80 fe ff ff    	lea    -0x180(%ebp),%edx
  8002be:	b9 14 00 00 00       	mov    $0x14,%ecx
  8002c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8002c8:	89 d7                	mov    %edx,%edi
  8002ca:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		/*ALLOCATE 2 MB*/
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002cc:	e8 4b 25 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8002d1:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8002d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002d7:	01 c0                	add    %eax,%eax
  8002d9:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	50                   	push   %eax
  8002e0:	e8 a6 22 00 00       	call   80258b <malloc>
  8002e5:	83 c4 10             	add    $0x10,%esp
  8002e8:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8002ee:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002f4:	85 c0                	test   %eax,%eax
  8002f6:	79 0d                	jns    800305 <_main+0x2cd>
  8002f8:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002fe:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800303:	76 14                	jbe    800319 <_main+0x2e1>
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	68 5c 2f 80 00       	push   $0x802f5c
  80030d:	6a 37                	push   $0x37
  80030f:	68 01 2f 80 00       	push   $0x802f01
  800314:	e8 34 12 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800319:	e8 fe 24 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  80031e:	2b 45 90             	sub    -0x70(%ebp),%eax
  800321:	3d 00 02 00 00       	cmp    $0x200,%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 c4 2f 80 00       	push   $0x802fc4
  800330:	6a 38                	push   $0x38
  800332:	68 01 2f 80 00       	push   $0x802f01
  800337:	e8 11 12 00 00       	call   80154d <_panic>

		/*ALLOCATE 3 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033c:	e8 db 24 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800341:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  800344:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800347:	89 c2                	mov    %eax,%edx
  800349:	01 d2                	add    %edx,%edx
  80034b:	01 d0                	add    %edx,%eax
  80034d:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800350:	83 ec 0c             	sub    $0xc,%esp
  800353:	50                   	push   %eax
  800354:	e8 32 22 00 00       	call   80258b <malloc>
  800359:	83 c4 10             	add    $0x10,%esp
  80035c:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800362:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800368:	89 c2                	mov    %eax,%edx
  80036a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80036d:	01 c0                	add    %eax,%eax
  80036f:	05 00 00 00 80       	add    $0x80000000,%eax
  800374:	39 c2                	cmp    %eax,%edx
  800376:	72 16                	jb     80038e <_main+0x356>
  800378:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80037e:	89 c2                	mov    %eax,%edx
  800380:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800383:	01 c0                	add    %eax,%eax
  800385:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80038a:	39 c2                	cmp    %eax,%edx
  80038c:	76 14                	jbe    8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 5c 2f 80 00       	push   $0x802f5c
  800396:	6a 3e                	push   $0x3e
  800398:	68 01 2f 80 00       	push   $0x802f01
  80039d:	e8 ab 11 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8003a2:	e8 75 24 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8003a7:	2b 45 90             	sub    -0x70(%ebp),%eax
  8003aa:	89 c2                	mov    %eax,%edx
  8003ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003af:	89 c1                	mov    %eax,%ecx
  8003b1:	01 c9                	add    %ecx,%ecx
  8003b3:	01 c8                	add    %ecx,%eax
  8003b5:	85 c0                	test   %eax,%eax
  8003b7:	79 05                	jns    8003be <_main+0x386>
  8003b9:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003be:	c1 f8 0c             	sar    $0xc,%eax
  8003c1:	39 c2                	cmp    %eax,%edx
  8003c3:	74 14                	je     8003d9 <_main+0x3a1>
  8003c5:	83 ec 04             	sub    $0x4,%esp
  8003c8:	68 c4 2f 80 00       	push   $0x802fc4
  8003cd:	6a 3f                	push   $0x3f
  8003cf:	68 01 2f 80 00       	push   $0x802f01
  8003d4:	e8 74 11 00 00       	call   80154d <_panic>

		/*ALLOCATE 8 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003d9:	e8 3e 24 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8003de:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(8*Mega-kilo);
  8003e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e4:	c1 e0 03             	shl    $0x3,%eax
  8003e7:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8003ea:	83 ec 0c             	sub    $0xc,%esp
  8003ed:	50                   	push   %eax
  8003ee:	e8 98 21 00 00       	call   80258b <malloc>
  8003f3:	83 c4 10             	add    $0x10,%esp
  8003f6:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 5*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 5*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8003fc:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800402:	89 c1                	mov    %eax,%ecx
  800404:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800407:	89 d0                	mov    %edx,%eax
  800409:	c1 e0 02             	shl    $0x2,%eax
  80040c:	01 d0                	add    %edx,%eax
  80040e:	05 00 00 00 80       	add    $0x80000000,%eax
  800413:	39 c1                	cmp    %eax,%ecx
  800415:	72 1b                	jb     800432 <_main+0x3fa>
  800417:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  80041d:	89 c1                	mov    %eax,%ecx
  80041f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800422:	89 d0                	mov    %edx,%eax
  800424:	c1 e0 02             	shl    $0x2,%eax
  800427:	01 d0                	add    %edx,%eax
  800429:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80042e:	39 c1                	cmp    %eax,%ecx
  800430:	76 14                	jbe    800446 <_main+0x40e>
  800432:	83 ec 04             	sub    $0x4,%esp
  800435:	68 5c 2f 80 00       	push   $0x802f5c
  80043a:	6a 45                	push   $0x45
  80043c:	68 01 2f 80 00       	push   $0x802f01
  800441:	e8 07 11 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  800446:	e8 d1 23 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  80044b:	2b 45 90             	sub    -0x70(%ebp),%eax
  80044e:	89 c2                	mov    %eax,%edx
  800450:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800453:	c1 e0 03             	shl    $0x3,%eax
  800456:	85 c0                	test   %eax,%eax
  800458:	79 05                	jns    80045f <_main+0x427>
  80045a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80045f:	c1 f8 0c             	sar    $0xc,%eax
  800462:	39 c2                	cmp    %eax,%edx
  800464:	74 14                	je     80047a <_main+0x442>
  800466:	83 ec 04             	sub    $0x4,%esp
  800469:	68 c4 2f 80 00       	push   $0x802fc4
  80046e:	6a 46                	push   $0x46
  800470:	68 01 2f 80 00       	push   $0x802f01
  800475:	e8 d3 10 00 00       	call   80154d <_panic>

		/*ALLOCATE 7 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80047a:	e8 9d 23 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  80047f:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(7*Mega-kilo);
  800482:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800485:	89 d0                	mov    %edx,%eax
  800487:	01 c0                	add    %eax,%eax
  800489:	01 d0                	add    %edx,%eax
  80048b:	01 c0                	add    %eax,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800492:	83 ec 0c             	sub    $0xc,%esp
  800495:	50                   	push   %eax
  800496:	e8 f0 20 00 00       	call   80258b <malloc>
  80049b:	83 c4 10             	add    $0x10,%esp
  80049e:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 13*Mega) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 13*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8004a4:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004aa:	89 c1                	mov    %eax,%ecx
  8004ac:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004af:	89 d0                	mov    %edx,%eax
  8004b1:	01 c0                	add    %eax,%eax
  8004b3:	01 d0                	add    %edx,%eax
  8004b5:	c1 e0 02             	shl    $0x2,%eax
  8004b8:	01 d0                	add    %edx,%eax
  8004ba:	05 00 00 00 80       	add    $0x80000000,%eax
  8004bf:	39 c1                	cmp    %eax,%ecx
  8004c1:	72 1f                	jb     8004e2 <_main+0x4aa>
  8004c3:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004c9:	89 c1                	mov    %eax,%ecx
  8004cb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004ce:	89 d0                	mov    %edx,%eax
  8004d0:	01 c0                	add    %eax,%eax
  8004d2:	01 d0                	add    %edx,%eax
  8004d4:	c1 e0 02             	shl    $0x2,%eax
  8004d7:	01 d0                	add    %edx,%eax
  8004d9:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8004de:	39 c1                	cmp    %eax,%ecx
  8004e0:	76 14                	jbe    8004f6 <_main+0x4be>
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	68 5c 2f 80 00       	push   $0x802f5c
  8004ea:	6a 4c                	push   $0x4c
  8004ec:	68 01 2f 80 00       	push   $0x802f01
  8004f1:	e8 57 10 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 7*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8004f6:	e8 21 23 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8004fb:	2b 45 90             	sub    -0x70(%ebp),%eax
  8004fe:	89 c1                	mov    %eax,%ecx
  800500:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800503:	89 d0                	mov    %edx,%eax
  800505:	01 c0                	add    %eax,%eax
  800507:	01 d0                	add    %edx,%eax
  800509:	01 c0                	add    %eax,%eax
  80050b:	01 d0                	add    %edx,%eax
  80050d:	85 c0                	test   %eax,%eax
  80050f:	79 05                	jns    800516 <_main+0x4de>
  800511:	05 ff 0f 00 00       	add    $0xfff,%eax
  800516:	c1 f8 0c             	sar    $0xc,%eax
  800519:	39 c1                	cmp    %eax,%ecx
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 c4 2f 80 00       	push   $0x802fc4
  800525:	6a 4d                	push   $0x4d
  800527:	68 01 2f 80 00       	push   $0x802f01
  80052c:	e8 1c 10 00 00       	call   80154d <_panic>

		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
  800531:	e8 63 22 00 00       	call   802799 <sys_calculate_free_frames>
  800536:	89 45 8c             	mov    %eax,-0x74(%ebp)
		int modFrames = sys_calculate_modified_frames();
  800539:	e8 74 22 00 00       	call   8027b2 <sys_calculate_modified_frames>
  80053e:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
  800541:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800544:	89 c2                	mov    %eax,%edx
  800546:	01 d2                	add    %edx,%edx
  800548:	01 d0                	add    %edx,%eax
  80054a:	2b 45 d0             	sub    -0x30(%ebp),%eax
  80054d:	48                   	dec    %eax
  80054e:	89 45 84             	mov    %eax,-0x7c(%ebp)
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
  800551:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800554:	bf 07 00 00 00       	mov    $0x7,%edi
  800559:	99                   	cltd   
  80055a:	f7 ff                	idiv   %edi
  80055c:	89 45 80             	mov    %eax,-0x80(%ebp)
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  80055f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800566:	eb 16                	jmp    80057e <_main+0x546>
		{
			indicesOf3MB[var] = var * inc ;
  800568:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80056b:	0f af 45 80          	imul   -0x80(%ebp),%eax
  80056f:	89 c2                	mov    %eax,%edx
  800571:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800574:	89 94 85 e0 fe ff ff 	mov    %edx,-0x120(%ebp,%eax,4)
		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
		int modFrames = sys_calculate_modified_frames();
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  80057b:	ff 45 e4             	incl   -0x1c(%ebp)
  80057e:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800582:	7e e4                	jle    800568 <_main+0x530>
		{
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
  800584:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80058a:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		//3 reads
		int sum = 0;
  800590:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  800597:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80059e:	eb 1f                	jmp    8005bf <_main+0x587>
		{
			sum += byteArr[indicesOf3MB[var]] ;
  8005a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a3:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005b2:	01 d0                	add    %edx,%eax
  8005b4:	8a 00                	mov    (%eax),%al
  8005b6:	0f be c0             	movsbl %al,%eax
  8005b9:	01 45 dc             	add    %eax,-0x24(%ebp)
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
		//3 reads
		int sum = 0;
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  8005bc:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bf:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8005c3:	7e db                	jle    8005a0 <_main+0x568>
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005c5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
  8005cc:	eb 1c                	jmp    8005ea <_main+0x5b2>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
  8005ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d1:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005d8:	89 c2                	mov    %eax,%edx
  8005da:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005e0:	01 c2                	add    %eax,%edx
  8005e2:	8a 45 ce             	mov    -0x32(%ebp),%al
  8005e5:	88 02                	mov    %al,(%edx)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005e7:	ff 45 e4             	incl   -0x1c(%ebp)
  8005ea:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8005ee:	7e de                	jle    8005ce <_main+0x596>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8005f0:	8b 55 8c             	mov    -0x74(%ebp),%edx
  8005f3:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005f6:	01 d0                	add    %edx,%eax
  8005f8:	89 c6                	mov    %eax,%esi
  8005fa:	e8 9a 21 00 00       	call   802799 <sys_calculate_free_frames>
  8005ff:	89 c3                	mov    %eax,%ebx
  800601:	e8 ac 21 00 00       	call   8027b2 <sys_calculate_modified_frames>
  800606:	01 d8                	add    %ebx,%eax
  800608:	29 c6                	sub    %eax,%esi
  80060a:	89 f0                	mov    %esi,%eax
  80060c:	83 f8 02             	cmp    $0x2,%eax
  80060f:	74 14                	je     800625 <_main+0x5ed>
  800611:	83 ec 04             	sub    $0x4,%esp
  800614:	68 f4 2f 80 00       	push   $0x802ff4
  800619:	6a 65                	push   $0x65
  80061b:	68 01 2f 80 00       	push   $0x802f01
  800620:	e8 28 0f 00 00       	call   80154d <_panic>
		int found = 0;
  800625:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  80062c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800633:	eb 78                	jmp    8006ad <_main+0x675>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800635:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063c:	eb 5d                	jmp    80069b <_main+0x663>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  80063e:	a1 04 40 80 00       	mov    0x804004,%eax
  800643:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800649:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064c:	89 d0                	mov    %edx,%eax
  80064e:	01 c0                	add    %eax,%eax
  800650:	01 d0                	add    %edx,%eax
  800652:	c1 e0 02             	shl    $0x2,%eax
  800655:	01 c8                	add    %ecx,%eax
  800657:	8b 00                	mov    (%eax),%eax
  800659:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80065f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800665:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80066a:	89 c2                	mov    %eax,%edx
  80066c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80066f:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  800676:	89 c1                	mov    %eax,%ecx
  800678:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80067e:	01 c8                	add    %ecx,%eax
  800680:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  800686:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80068c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800691:	39 c2                	cmp    %eax,%edx
  800693:	75 03                	jne    800698 <_main+0x660>
				{
					found++;
  800695:	ff 45 d8             	incl   -0x28(%ebp)
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800698:	ff 45 e0             	incl   -0x20(%ebp)
  80069b:	a1 04 40 80 00       	mov    0x804004,%eax
  8006a0:	8b 50 74             	mov    0x74(%eax),%edx
  8006a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a6:	39 c2                	cmp    %eax,%edx
  8006a8:	77 94                	ja     80063e <_main+0x606>
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  8006aa:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ad:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8006b1:	7e 82                	jle    800635 <_main+0x5fd>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor3MB) panic("malloc: page is not added to WS");
  8006b3:	83 7d d8 07          	cmpl   $0x7,-0x28(%ebp)
  8006b7:	74 14                	je     8006cd <_main+0x695>
  8006b9:	83 ec 04             	sub    $0x4,%esp
  8006bc:	68 38 30 80 00       	push   $0x803038
  8006c1:	6a 71                	push   $0x71
  8006c3:	68 01 2f 80 00       	push   $0x802f01
  8006c8:	e8 80 0e 00 00       	call   80154d <_panic>

		/*access 8 MB*/// should bring 4 pages into WS (2 r, 2 w) and victimize 4 pages from 3 MB allocation
		freeFrames = sys_calculate_free_frames() ;
  8006cd:	e8 c7 20 00 00       	call   802799 <sys_calculate_free_frames>
  8006d2:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8006d5:	e8 d8 20 00 00       	call   8027b2 <sys_calculate_modified_frames>
  8006da:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfShort = (8*Mega-kilo)/sizeof(short) - 1;
  8006dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e0:	c1 e0 03             	shl    $0x3,%eax
  8006e3:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8006e6:	d1 e8                	shr    %eax
  8006e8:	48                   	dec    %eax
  8006e9:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		indicesOf8MB[0] = lastIndexOfShort * 1 / 2;
  8006ef:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8006f5:	89 c2                	mov    %eax,%edx
  8006f7:	c1 ea 1f             	shr    $0x1f,%edx
  8006fa:	01 d0                	add    %edx,%eax
  8006fc:	d1 f8                	sar    %eax
  8006fe:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		indicesOf8MB[1] = lastIndexOfShort * 2 / 3;
  800704:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80070a:	01 c0                	add    %eax,%eax
  80070c:	89 c1                	mov    %eax,%ecx
  80070e:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800713:	f7 e9                	imul   %ecx
  800715:	c1 f9 1f             	sar    $0x1f,%ecx
  800718:	89 d0                	mov    %edx,%eax
  80071a:	29 c8                	sub    %ecx,%eax
  80071c:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		indicesOf8MB[2] = lastIndexOfShort * 3 / 4;
  800722:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800728:	89 c2                	mov    %eax,%edx
  80072a:	01 d2                	add    %edx,%edx
  80072c:	01 d0                	add    %edx,%eax
  80072e:	85 c0                	test   %eax,%eax
  800730:	79 03                	jns    800735 <_main+0x6fd>
  800732:	83 c0 03             	add    $0x3,%eax
  800735:	c1 f8 02             	sar    $0x2,%eax
  800738:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		indicesOf8MB[3] = lastIndexOfShort ;
  80073e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800744:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)

		//use one of the read pages from 3 MB to avoid victimizing it
		sum += byteArr[indicesOf3MB[0]] ;
  80074a:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800750:	89 c2                	mov    %eax,%edx
  800752:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800758:	01 d0                	add    %edx,%eax
  80075a:	8a 00                	mov    (%eax),%al
  80075c:	0f be c0             	movsbl %al,%eax
  80075f:	01 45 dc             	add    %eax,-0x24(%ebp)

		shortArr = (short *) ptr_allocations[2];
  800762:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800768:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		//2 reads
		sum = 0;
  80076e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  800775:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80077c:	eb 20                	jmp    80079e <_main+0x766>
		{
			sum += shortArr[indicesOf8MB[var]] ;
  80077e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800781:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  800788:	01 c0                	add    %eax,%eax
  80078a:	89 c2                	mov    %eax,%edx
  80078c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800792:	01 d0                	add    %edx,%eax
  800794:	66 8b 00             	mov    (%eax),%ax
  800797:	98                   	cwtl   
  800798:	01 45 dc             	add    %eax,-0x24(%ebp)
		sum += byteArr[indicesOf3MB[0]] ;

		shortArr = (short *) ptr_allocations[2];
		//2 reads
		sum = 0;
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  80079b:	ff 45 e4             	incl   -0x1c(%ebp)
  80079e:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8007a2:	7e da                	jle    80077e <_main+0x746>
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007a4:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8007ab:	eb 20                	jmp    8007cd <_main+0x795>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
  8007ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007b0:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  8007b7:	01 c0                	add    %eax,%eax
  8007b9:	89 c2                	mov    %eax,%edx
  8007bb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007c1:	01 c2                	add    %eax,%edx
  8007c3:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  8007c7:	66 89 02             	mov    %ax,(%edx)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007ca:	ff 45 e4             	incl   -0x1c(%ebp)
  8007cd:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007d1:	7e da                	jle    8007ad <_main+0x775>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007d3:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8007d6:	e8 be 1f 00 00       	call   802799 <sys_calculate_free_frames>
  8007db:	29 c3                	sub    %eax,%ebx
  8007dd:	89 d8                	mov    %ebx,%eax
  8007df:	83 f8 04             	cmp    $0x4,%eax
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 f4 2f 80 00       	push   $0x802ff4
  8007ec:	68 8c 00 00 00       	push   $0x8c
  8007f1:	68 01 2f 80 00       	push   $0x802f01
  8007f6:	e8 52 0d 00 00       	call   80154d <_panic>
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007fb:	8b 5d 88             	mov    -0x78(%ebp),%ebx
  8007fe:	e8 af 1f 00 00       	call   8027b2 <sys_calculate_modified_frames>
  800803:	29 c3                	sub    %eax,%ebx
  800805:	89 d8                	mov    %ebx,%eax
  800807:	83 f8 fe             	cmp    $0xfffffffe,%eax
  80080a:	74 17                	je     800823 <_main+0x7eb>
  80080c:	83 ec 04             	sub    $0x4,%esp
  80080f:	68 f4 2f 80 00       	push   $0x802ff4
  800814:	68 8d 00 00 00       	push   $0x8d
  800819:	68 01 2f 80 00       	push   $0x802f01
  80081e:	e8 2a 0d 00 00       	call   80154d <_panic>
		found = 0;
  800823:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  80082a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800831:	eb 7a                	jmp    8008ad <_main+0x875>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800833:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80083a:	eb 5f                	jmp    80089b <_main+0x863>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[indicesOf8MB[var]])), PAGE_SIZE))
  80083c:	a1 04 40 80 00       	mov    0x804004,%eax
  800841:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800847:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80084a:	89 d0                	mov    %edx,%eax
  80084c:	01 c0                	add    %eax,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	c1 e0 02             	shl    $0x2,%eax
  800853:	01 c8                	add    %ecx,%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80085d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800863:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800868:	89 c2                	mov    %eax,%edx
  80086a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80086d:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  800874:	01 c0                	add    %eax,%eax
  800876:	89 c1                	mov    %eax,%ecx
  800878:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80087e:	01 c8                	add    %ecx,%eax
  800880:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800886:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80088c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800891:	39 c2                	cmp    %eax,%edx
  800893:	75 03                	jne    800898 <_main+0x860>
				{
					found++;
  800895:	ff 45 d8             	incl   -0x28(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800898:	ff 45 e0             	incl   -0x20(%ebp)
  80089b:	a1 04 40 80 00       	mov    0x804004,%eax
  8008a0:	8b 50 74             	mov    0x74(%eax),%edx
  8008a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a6:	39 c2                	cmp    %eax,%edx
  8008a8:	77 92                	ja     80083c <_main+0x804>
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  8008aa:	ff 45 e4             	incl   -0x1c(%ebp)
  8008ad:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8008b1:	7e 80                	jle    800833 <_main+0x7fb>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor8MB) panic("malloc: page is not added to WS");
  8008b3:	83 7d d8 04          	cmpl   $0x4,-0x28(%ebp)
  8008b7:	74 17                	je     8008d0 <_main+0x898>
  8008b9:	83 ec 04             	sub    $0x4,%esp
  8008bc:	68 38 30 80 00       	push   $0x803038
  8008c1:	68 99 00 00 00       	push   $0x99
  8008c6:	68 01 2f 80 00       	push   $0x802f01
  8008cb:	e8 7d 0c 00 00       	call   80154d <_panic>

		/* Free 3 MB */// remove 3 pages from WS, 2 from free buffer, 2 from mod buffer and 2 tables
		freeFrames = sys_calculate_free_frames() ;
  8008d0:	e8 c4 1e 00 00       	call   802799 <sys_calculate_free_frames>
  8008d5:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8008d8:	e8 d5 1e 00 00       	call   8027b2 <sys_calculate_modified_frames>
  8008dd:	89 45 88             	mov    %eax,-0x78(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008e0:	e8 37 1f 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8008e5:	89 45 90             	mov    %eax,-0x70(%ebp)

		free(ptr_allocations[1]);
  8008e8:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  8008ee:	83 ec 0c             	sub    $0xc,%esp
  8008f1:	50                   	push   %eax
  8008f2:	e8 e8 1c 00 00       	call   8025df <free>
  8008f7:	83 c4 10             	add    $0x10,%esp

		//check page file
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  8008fa:	e8 1d 1f 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8008ff:	8b 55 90             	mov    -0x70(%ebp),%edx
  800902:	89 d1                	mov    %edx,%ecx
  800904:	29 c1                	sub    %eax,%ecx
  800906:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800909:	89 c2                	mov    %eax,%edx
  80090b:	01 d2                	add    %edx,%edx
  80090d:	01 d0                	add    %edx,%eax
  80090f:	85 c0                	test   %eax,%eax
  800911:	79 05                	jns    800918 <_main+0x8e0>
  800913:	05 ff 0f 00 00       	add    $0xfff,%eax
  800918:	c1 f8 0c             	sar    $0xc,%eax
  80091b:	39 c1                	cmp    %eax,%ecx
  80091d:	74 17                	je     800936 <_main+0x8fe>
  80091f:	83 ec 04             	sub    $0x4,%esp
  800922:	68 58 30 80 00       	push   $0x803058
  800927:	68 a3 00 00 00       	push   $0xa3
  80092c:	68 01 2f 80 00       	push   $0x802f01
  800931:	e8 17 0c 00 00       	call   80154d <_panic>
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
  800936:	e8 5e 1e 00 00       	call   802799 <sys_calculate_free_frames>
  80093b:	89 c2                	mov    %eax,%edx
  80093d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800940:	29 c2                	sub    %eax,%edx
  800942:	89 d0                	mov    %edx,%eax
  800944:	83 f8 07             	cmp    $0x7,%eax
  800947:	74 17                	je     800960 <_main+0x928>
  800949:	83 ec 04             	sub    $0x4,%esp
  80094c:	68 94 30 80 00       	push   $0x803094
  800951:	68 a5 00 00 00       	push   $0xa5
  800956:	68 01 2f 80 00       	push   $0x802f01
  80095b:	e8 ed 0b 00 00       	call   80154d <_panic>
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
  800960:	e8 4d 1e 00 00       	call   8027b2 <sys_calculate_modified_frames>
  800965:	89 c2                	mov    %eax,%edx
  800967:	8b 45 88             	mov    -0x78(%ebp),%eax
  80096a:	29 c2                	sub    %eax,%edx
  80096c:	89 d0                	mov    %edx,%eax
  80096e:	83 f8 02             	cmp    $0x2,%eax
  800971:	74 17                	je     80098a <_main+0x952>
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	68 e8 30 80 00       	push   $0x8030e8
  80097b:	68 a6 00 00 00       	push   $0xa6
  800980:	68 01 2f 80 00       	push   $0x802f01
  800985:	e8 c3 0b 00 00       	call   80154d <_panic>
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  80098a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800991:	e9 8c 00 00 00       	jmp    800a22 <_main+0x9ea>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800996:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80099d:	eb 71                	jmp    800a10 <_main+0x9d8>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  80099f:	a1 04 40 80 00       	mov    0x804004,%eax
  8009a4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ad:	89 d0                	mov    %edx,%eax
  8009af:	01 c0                	add    %eax,%eax
  8009b1:	01 d0                	add    %edx,%eax
  8009b3:	c1 e0 02             	shl    $0x2,%eax
  8009b6:	01 c8                	add    %ecx,%eax
  8009b8:	8b 00                	mov    (%eax),%eax
  8009ba:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8009c0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8009c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009cb:	89 c2                	mov    %eax,%edx
  8009cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009d0:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8009d7:	89 c1                	mov    %eax,%ecx
  8009d9:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8009df:	01 c8                	add    %ecx,%eax
  8009e1:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8009e7:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8009ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f2:	39 c2                	cmp    %eax,%edx
  8009f4:	75 17                	jne    800a0d <_main+0x9d5>
				{
					panic("free: page is not removed from WS");
  8009f6:	83 ec 04             	sub    $0x4,%esp
  8009f9:	68 20 31 80 00       	push   $0x803120
  8009fe:	68 ae 00 00 00       	push   $0xae
  800a03:	68 01 2f 80 00       	push   $0x802f01
  800a08:	e8 40 0b 00 00       	call   80154d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800a0d:	ff 45 e0             	incl   -0x20(%ebp)
  800a10:	a1 04 40 80 00       	mov    0x804004,%eax
  800a15:	8b 50 74             	mov    0x74(%eax),%edx
  800a18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1b:	39 c2                	cmp    %eax,%edx
  800a1d:	77 80                	ja     80099f <_main+0x967>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800a1f:	ff 45 e4             	incl   -0x1c(%ebp)
  800a22:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800a26:	0f 8e 6a ff ff ff    	jle    800996 <_main+0x95e>
			}
		}



		freeFrames = sys_calculate_free_frames() ;
  800a2c:	e8 68 1d 00 00       	call   802799 <sys_calculate_free_frames>
  800a31:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr = (short *) ptr_allocations[2];
  800a34:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800a3a:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800a40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a43:	01 c0                	add    %eax,%eax
  800a45:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800a48:	d1 e8                	shr    %eax
  800a4a:	48                   	dec    %eax
  800a4b:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		shortArr[0] = minShort;
  800a51:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  800a57:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800a5a:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800a5d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800a63:	01 c0                	add    %eax,%eax
  800a65:	89 c2                	mov    %eax,%edx
  800a67:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a6d:	01 c2                	add    %eax,%edx
  800a6f:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  800a73:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800a76:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800a79:	e8 1b 1d 00 00       	call   802799 <sys_calculate_free_frames>
  800a7e:	29 c3                	sub    %eax,%ebx
  800a80:	89 d8                	mov    %ebx,%eax
  800a82:	83 f8 02             	cmp    $0x2,%eax
  800a85:	74 17                	je     800a9e <_main+0xa66>
  800a87:	83 ec 04             	sub    $0x4,%esp
  800a8a:	68 f4 2f 80 00       	push   $0x802ff4
  800a8f:	68 ba 00 00 00       	push   $0xba
  800a94:	68 01 2f 80 00       	push   $0x802f01
  800a99:	e8 af 0a 00 00       	call   80154d <_panic>
		found = 0;
  800a9e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800aa5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800aac:	e9 a7 00 00 00       	jmp    800b58 <_main+0xb20>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800ab1:	a1 04 40 80 00       	mov    0x804004,%eax
  800ab6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800abc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800abf:	89 d0                	mov    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	01 d0                	add    %edx,%eax
  800ac5:	c1 e0 02             	shl    $0x2,%eax
  800ac8:	01 c8                	add    %ecx,%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800ad2:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ad8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800add:	89 c2                	mov    %eax,%edx
  800adf:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800ae5:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800aeb:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800af1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800af6:	39 c2                	cmp    %eax,%edx
  800af8:	75 03                	jne    800afd <_main+0xac5>
				found++;
  800afa:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  800afd:	a1 04 40 80 00       	mov    0x804004,%eax
  800b02:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b08:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b0b:	89 d0                	mov    %edx,%eax
  800b0d:	01 c0                	add    %eax,%eax
  800b0f:	01 d0                	add    %edx,%eax
  800b11:	c1 e0 02             	shl    $0x2,%eax
  800b14:	01 c8                	add    %ecx,%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b1e:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b24:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b29:	89 c2                	mov    %eax,%edx
  800b2b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800b31:	01 c0                	add    %eax,%eax
  800b33:	89 c1                	mov    %eax,%ecx
  800b35:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b3b:	01 c8                	add    %ecx,%eax
  800b3d:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b43:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b49:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b4e:	39 c2                	cmp    %eax,%edx
  800b50:	75 03                	jne    800b55 <_main+0xb1d>
				found++;
  800b52:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b55:	ff 45 e4             	incl   -0x1c(%ebp)
  800b58:	a1 04 40 80 00       	mov    0x804004,%eax
  800b5d:	8b 50 74             	mov    0x74(%eax),%edx
  800b60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b63:	39 c2                	cmp    %eax,%edx
  800b65:	0f 87 46 ff ff ff    	ja     800ab1 <_main+0xa79>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800b6b:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800b6f:	74 17                	je     800b88 <_main+0xb50>
  800b71:	83 ec 04             	sub    $0x4,%esp
  800b74:	68 38 30 80 00       	push   $0x803038
  800b79:	68 c3 00 00 00       	push   $0xc3
  800b7e:	68 01 2f 80 00       	push   $0x802f01
  800b83:	e8 c5 09 00 00       	call   80154d <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b88:	e8 8f 1c 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800b8d:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800b90:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b93:	01 c0                	add    %eax,%eax
  800b95:	83 ec 0c             	sub    $0xc,%esp
  800b98:	50                   	push   %eax
  800b99:	e8 ed 19 00 00       	call   80258b <malloc>
  800b9e:	83 c4 10             	add    $0x10,%esp
  800ba1:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ba7:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bad:	89 c2                	mov    %eax,%edx
  800baf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bb2:	c1 e0 02             	shl    $0x2,%eax
  800bb5:	05 00 00 00 80       	add    $0x80000000,%eax
  800bba:	39 c2                	cmp    %eax,%edx
  800bbc:	72 17                	jb     800bd5 <_main+0xb9d>
  800bbe:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800bc4:	89 c2                	mov    %eax,%edx
  800bc6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bc9:	c1 e0 02             	shl    $0x2,%eax
  800bcc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800bd1:	39 c2                	cmp    %eax,%edx
  800bd3:	76 17                	jbe    800bec <_main+0xbb4>
  800bd5:	83 ec 04             	sub    $0x4,%esp
  800bd8:	68 5c 2f 80 00       	push   $0x802f5c
  800bdd:	68 c8 00 00 00       	push   $0xc8
  800be2:	68 01 2f 80 00       	push   $0x802f01
  800be7:	e8 61 09 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800bec:	e8 2b 1c 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800bf1:	2b 45 90             	sub    -0x70(%ebp),%eax
  800bf4:	83 f8 01             	cmp    $0x1,%eax
  800bf7:	74 17                	je     800c10 <_main+0xbd8>
  800bf9:	83 ec 04             	sub    $0x4,%esp
  800bfc:	68 c4 2f 80 00       	push   $0x802fc4
  800c01:	68 c9 00 00 00       	push   $0xc9
  800c06:	68 01 2f 80 00       	push   $0x802f01
  800c0b:	e8 3d 09 00 00       	call   80154d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800c10:	e8 84 1b 00 00       	call   802799 <sys_calculate_free_frames>
  800c15:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr = (int *) ptr_allocations[2];
  800c18:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800c1e:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800c24:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c27:	01 c0                	add    %eax,%eax
  800c29:	c1 e8 02             	shr    $0x2,%eax
  800c2c:	48                   	dec    %eax
  800c2d:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
		intArr[0] = minInt;
  800c33:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c39:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800c3c:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800c3e:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800c44:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c4b:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c51:	01 c2                	add    %eax,%edx
  800c53:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800c56:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800c58:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800c5b:	e8 39 1b 00 00       	call   802799 <sys_calculate_free_frames>
  800c60:	29 c3                	sub    %eax,%ebx
  800c62:	89 d8                	mov    %ebx,%eax
  800c64:	83 f8 02             	cmp    $0x2,%eax
  800c67:	74 17                	je     800c80 <_main+0xc48>
  800c69:	83 ec 04             	sub    $0x4,%esp
  800c6c:	68 f4 2f 80 00       	push   $0x802ff4
  800c71:	68 d0 00 00 00       	push   $0xd0
  800c76:	68 01 2f 80 00       	push   $0x802f01
  800c7b:	e8 cd 08 00 00       	call   80154d <_panic>
		found = 0;
  800c80:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c87:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800c8e:	e9 aa 00 00 00       	jmp    800d3d <_main+0xd05>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800c93:	a1 04 40 80 00       	mov    0x804004,%eax
  800c98:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800c9e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ca1:	89 d0                	mov    %edx,%eax
  800ca3:	01 c0                	add    %eax,%eax
  800ca5:	01 d0                	add    %edx,%eax
  800ca7:	c1 e0 02             	shl    $0x2,%eax
  800caa:	01 c8                	add    %ecx,%eax
  800cac:	8b 00                	mov    (%eax),%eax
  800cae:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800cb4:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800cba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cbf:	89 c2                	mov    %eax,%edx
  800cc1:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800cc7:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800ccd:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800cd3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cd8:	39 c2                	cmp    %eax,%edx
  800cda:	75 03                	jne    800cdf <_main+0xca7>
				found++;
  800cdc:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800cdf:	a1 04 40 80 00       	mov    0x804004,%eax
  800ce4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ced:	89 d0                	mov    %edx,%eax
  800cef:	01 c0                	add    %eax,%eax
  800cf1:	01 d0                	add    %edx,%eax
  800cf3:	c1 e0 02             	shl    $0x2,%eax
  800cf6:	01 c8                	add    %ecx,%eax
  800cf8:	8b 00                	mov    (%eax),%eax
  800cfa:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d00:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d0b:	89 c2                	mov    %eax,%edx
  800d0d:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800d13:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d1a:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800d20:	01 c8                	add    %ecx,%eax
  800d22:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d28:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d2e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d33:	39 c2                	cmp    %eax,%edx
  800d35:	75 03                	jne    800d3a <_main+0xd02>
				found++;
  800d37:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d3a:	ff 45 e4             	incl   -0x1c(%ebp)
  800d3d:	a1 04 40 80 00       	mov    0x804004,%eax
  800d42:	8b 50 74             	mov    0x74(%eax),%edx
  800d45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800d48:	39 c2                	cmp    %eax,%edx
  800d4a:	0f 87 43 ff ff ff    	ja     800c93 <_main+0xc5b>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800d50:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800d54:	74 17                	je     800d6d <_main+0xd35>
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	68 38 30 80 00       	push   $0x803038
  800d5e:	68 d9 00 00 00       	push   $0xd9
  800d63:	68 01 2f 80 00       	push   $0x802f01
  800d68:	e8 e0 07 00 00       	call   80154d <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800d6d:	e8 27 1a 00 00       	call   802799 <sys_calculate_free_frames>
  800d72:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d75:	e8 a2 1a 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800d7a:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800d7d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d80:	01 c0                	add    %eax,%eax
  800d82:	83 ec 0c             	sub    $0xc,%esp
  800d85:	50                   	push   %eax
  800d86:	e8 00 18 00 00       	call   80258b <malloc>
  800d8b:	83 c4 10             	add    $0x10,%esp
  800d8e:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800d94:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800d9a:	89 c2                	mov    %eax,%edx
  800d9c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d9f:	c1 e0 02             	shl    $0x2,%eax
  800da2:	89 c1                	mov    %eax,%ecx
  800da4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800da7:	c1 e0 02             	shl    $0x2,%eax
  800daa:	01 c8                	add    %ecx,%eax
  800dac:	05 00 00 00 80       	add    $0x80000000,%eax
  800db1:	39 c2                	cmp    %eax,%edx
  800db3:	72 21                	jb     800dd6 <_main+0xd9e>
  800db5:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800dbb:	89 c2                	mov    %eax,%edx
  800dbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dc0:	c1 e0 02             	shl    $0x2,%eax
  800dc3:	89 c1                	mov    %eax,%ecx
  800dc5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800dc8:	c1 e0 02             	shl    $0x2,%eax
  800dcb:	01 c8                	add    %ecx,%eax
  800dcd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800dd2:	39 c2                	cmp    %eax,%edx
  800dd4:	76 17                	jbe    800ded <_main+0xdb5>
  800dd6:	83 ec 04             	sub    $0x4,%esp
  800dd9:	68 5c 2f 80 00       	push   $0x802f5c
  800dde:	68 df 00 00 00       	push   $0xdf
  800de3:	68 01 2f 80 00       	push   $0x802f01
  800de8:	e8 60 07 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800ded:	e8 2a 1a 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800df2:	2b 45 90             	sub    -0x70(%ebp),%eax
  800df5:	83 f8 01             	cmp    $0x1,%eax
  800df8:	74 17                	je     800e11 <_main+0xdd9>
  800dfa:	83 ec 04             	sub    $0x4,%esp
  800dfd:	68 c4 2f 80 00       	push   $0x802fc4
  800e02:	68 e0 00 00 00       	push   $0xe0
  800e07:	68 01 2f 80 00       	push   $0x802f01
  800e0c:	e8 3c 07 00 00       	call   80154d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e11:	e8 06 1a 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800e16:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800e19:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800e1c:	89 d0                	mov    %edx,%eax
  800e1e:	01 c0                	add    %eax,%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	01 c0                	add    %eax,%eax
  800e24:	01 d0                	add    %edx,%eax
  800e26:	83 ec 0c             	sub    $0xc,%esp
  800e29:	50                   	push   %eax
  800e2a:	e8 5c 17 00 00       	call   80258b <malloc>
  800e2f:	83 c4 10             	add    $0x10,%esp
  800e32:	89 85 90 fe ff ff    	mov    %eax,-0x170(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800e38:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e3e:	89 c2                	mov    %eax,%edx
  800e40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e43:	c1 e0 02             	shl    $0x2,%eax
  800e46:	89 c1                	mov    %eax,%ecx
  800e48:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e4b:	c1 e0 03             	shl    $0x3,%eax
  800e4e:	01 c8                	add    %ecx,%eax
  800e50:	05 00 00 00 80       	add    $0x80000000,%eax
  800e55:	39 c2                	cmp    %eax,%edx
  800e57:	72 21                	jb     800e7a <_main+0xe42>
  800e59:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e5f:	89 c2                	mov    %eax,%edx
  800e61:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e64:	c1 e0 02             	shl    $0x2,%eax
  800e67:	89 c1                	mov    %eax,%ecx
  800e69:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e6c:	c1 e0 03             	shl    $0x3,%eax
  800e6f:	01 c8                	add    %ecx,%eax
  800e71:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800e76:	39 c2                	cmp    %eax,%edx
  800e78:	76 17                	jbe    800e91 <_main+0xe59>
  800e7a:	83 ec 04             	sub    $0x4,%esp
  800e7d:	68 5c 2f 80 00       	push   $0x802f5c
  800e82:	68 e6 00 00 00       	push   $0xe6
  800e87:	68 01 2f 80 00       	push   $0x802f01
  800e8c:	e8 bc 06 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800e91:	e8 86 19 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800e96:	2b 45 90             	sub    -0x70(%ebp),%eax
  800e99:	83 f8 02             	cmp    $0x2,%eax
  800e9c:	74 17                	je     800eb5 <_main+0xe7d>
  800e9e:	83 ec 04             	sub    $0x4,%esp
  800ea1:	68 c4 2f 80 00       	push   $0x802fc4
  800ea6:	68 e7 00 00 00       	push   $0xe7
  800eab:	68 01 2f 80 00       	push   $0x802f01
  800eb0:	e8 98 06 00 00       	call   80154d <_panic>


		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800eb5:	e8 df 18 00 00       	call   802799 <sys_calculate_free_frames>
  800eba:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800ebd:	e8 5a 19 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800ec2:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800ec5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ec8:	89 c2                	mov    %eax,%edx
  800eca:	01 d2                	add    %edx,%edx
  800ecc:	01 d0                	add    %edx,%eax
  800ece:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800ed1:	83 ec 0c             	sub    $0xc,%esp
  800ed4:	50                   	push   %eax
  800ed5:	e8 b1 16 00 00       	call   80258b <malloc>
  800eda:	83 c4 10             	add    $0x10,%esp
  800edd:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ee3:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800ee9:	89 c2                	mov    %eax,%edx
  800eeb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800eee:	c1 e0 02             	shl    $0x2,%eax
  800ef1:	89 c1                	mov    %eax,%ecx
  800ef3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ef6:	c1 e0 04             	shl    $0x4,%eax
  800ef9:	01 c8                	add    %ecx,%eax
  800efb:	05 00 00 00 80       	add    $0x80000000,%eax
  800f00:	39 c2                	cmp    %eax,%edx
  800f02:	72 21                	jb     800f25 <_main+0xeed>
  800f04:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800f0a:	89 c2                	mov    %eax,%edx
  800f0c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f0f:	c1 e0 02             	shl    $0x2,%eax
  800f12:	89 c1                	mov    %eax,%ecx
  800f14:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800f17:	c1 e0 04             	shl    $0x4,%eax
  800f1a:	01 c8                	add    %ecx,%eax
  800f1c:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800f21:	39 c2                	cmp    %eax,%edx
  800f23:	76 17                	jbe    800f3c <_main+0xf04>
  800f25:	83 ec 04             	sub    $0x4,%esp
  800f28:	68 5c 2f 80 00       	push   $0x802f5c
  800f2d:	68 ee 00 00 00       	push   $0xee
  800f32:	68 01 2f 80 00       	push   $0x802f01
  800f37:	e8 11 06 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800f3c:	e8 db 18 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800f41:	2b 45 90             	sub    -0x70(%ebp),%eax
  800f44:	89 c2                	mov    %eax,%edx
  800f46:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f49:	89 c1                	mov    %eax,%ecx
  800f4b:	01 c9                	add    %ecx,%ecx
  800f4d:	01 c8                	add    %ecx,%eax
  800f4f:	85 c0                	test   %eax,%eax
  800f51:	79 05                	jns    800f58 <_main+0xf20>
  800f53:	05 ff 0f 00 00       	add    $0xfff,%eax
  800f58:	c1 f8 0c             	sar    $0xc,%eax
  800f5b:	39 c2                	cmp    %eax,%edx
  800f5d:	74 17                	je     800f76 <_main+0xf3e>
  800f5f:	83 ec 04             	sub    $0x4,%esp
  800f62:	68 c4 2f 80 00       	push   $0x802fc4
  800f67:	68 ef 00 00 00       	push   $0xef
  800f6c:	68 01 2f 80 00       	push   $0x802f01
  800f71:	e8 d7 05 00 00       	call   80154d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f76:	e8 a1 18 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  800f7b:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800f7e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800f81:	89 d0                	mov    %edx,%eax
  800f83:	01 c0                	add    %eax,%eax
  800f85:	01 d0                	add    %edx,%eax
  800f87:	01 c0                	add    %eax,%eax
  800f89:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800f8c:	83 ec 0c             	sub    $0xc,%esp
  800f8f:	50                   	push   %eax
  800f90:	e8 f6 15 00 00       	call   80258b <malloc>
  800f95:	83 c4 10             	add    $0x10,%esp
  800f98:	89 85 98 fe ff ff    	mov    %eax,-0x168(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800f9e:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fa4:	89 c1                	mov    %eax,%ecx
  800fa6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fa9:	89 d0                	mov    %edx,%eax
  800fab:	01 c0                	add    %eax,%eax
  800fad:	01 d0                	add    %edx,%eax
  800faf:	01 c0                	add    %eax,%eax
  800fb1:	01 d0                	add    %edx,%eax
  800fb3:	89 c2                	mov    %eax,%edx
  800fb5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fb8:	c1 e0 04             	shl    $0x4,%eax
  800fbb:	01 d0                	add    %edx,%eax
  800fbd:	05 00 00 00 80       	add    $0x80000000,%eax
  800fc2:	39 c1                	cmp    %eax,%ecx
  800fc4:	72 28                	jb     800fee <_main+0xfb6>
  800fc6:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fcc:	89 c1                	mov    %eax,%ecx
  800fce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fd1:	89 d0                	mov    %edx,%eax
  800fd3:	01 c0                	add    %eax,%eax
  800fd5:	01 d0                	add    %edx,%eax
  800fd7:	01 c0                	add    %eax,%eax
  800fd9:	01 d0                	add    %edx,%eax
  800fdb:	89 c2                	mov    %eax,%edx
  800fdd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fe0:	c1 e0 04             	shl    $0x4,%eax
  800fe3:	01 d0                	add    %edx,%eax
  800fe5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800fea:	39 c1                	cmp    %eax,%ecx
  800fec:	76 17                	jbe    801005 <_main+0xfcd>
  800fee:	83 ec 04             	sub    $0x4,%esp
  800ff1:	68 5c 2f 80 00       	push   $0x802f5c
  800ff6:	68 f5 00 00 00       	push   $0xf5
  800ffb:	68 01 2f 80 00       	push   $0x802f01
  801000:	e8 48 05 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  801005:	e8 12 18 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  80100a:	2b 45 90             	sub    -0x70(%ebp),%eax
  80100d:	89 c1                	mov    %eax,%ecx
  80100f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801012:	89 d0                	mov    %edx,%eax
  801014:	01 c0                	add    %eax,%eax
  801016:	01 d0                	add    %edx,%eax
  801018:	01 c0                	add    %eax,%eax
  80101a:	85 c0                	test   %eax,%eax
  80101c:	79 05                	jns    801023 <_main+0xfeb>
  80101e:	05 ff 0f 00 00       	add    $0xfff,%eax
  801023:	c1 f8 0c             	sar    $0xc,%eax
  801026:	39 c1                	cmp    %eax,%ecx
  801028:	74 17                	je     801041 <_main+0x1009>
  80102a:	83 ec 04             	sub    $0x4,%esp
  80102d:	68 c4 2f 80 00       	push   $0x802fc4
  801032:	68 f6 00 00 00       	push   $0xf6
  801037:	68 01 2f 80 00       	push   $0x802f01
  80103c:	e8 0c 05 00 00       	call   80154d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  801041:	e8 53 17 00 00       	call   802799 <sys_calculate_free_frames>
  801046:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  801049:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80104c:	89 d0                	mov    %edx,%eax
  80104e:	01 c0                	add    %eax,%eax
  801050:	01 d0                	add    %edx,%eax
  801052:	01 c0                	add    %eax,%eax
  801054:	2b 45 d0             	sub    -0x30(%ebp),%eax
  801057:	48                   	dec    %eax
  801058:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  80105e:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  801064:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		byteArr2[0] = minByte ;
  80106a:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801070:	8a 55 cf             	mov    -0x31(%ebp),%dl
  801073:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  801075:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80107b:	89 c2                	mov    %eax,%edx
  80107d:	c1 ea 1f             	shr    $0x1f,%edx
  801080:	01 d0                	add    %edx,%eax
  801082:	d1 f8                	sar    %eax
  801084:	89 c2                	mov    %eax,%edx
  801086:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80108c:	01 c2                	add    %eax,%edx
  80108e:	8a 45 ce             	mov    -0x32(%ebp),%al
  801091:	88 c1                	mov    %al,%cl
  801093:	c0 e9 07             	shr    $0x7,%cl
  801096:	01 c8                	add    %ecx,%eax
  801098:	d0 f8                	sar    %al
  80109a:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  80109c:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8010a2:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8010a8:	01 c2                	add    %eax,%edx
  8010aa:	8a 45 ce             	mov    -0x32(%ebp),%al
  8010ad:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8010af:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8010b2:	e8 e2 16 00 00       	call   802799 <sys_calculate_free_frames>
  8010b7:	29 c3                	sub    %eax,%ebx
  8010b9:	89 d8                	mov    %ebx,%eax
  8010bb:	83 f8 05             	cmp    $0x5,%eax
  8010be:	74 17                	je     8010d7 <_main+0x109f>
  8010c0:	83 ec 04             	sub    $0x4,%esp
  8010c3:	68 f4 2f 80 00       	push   $0x802ff4
  8010c8:	68 fe 00 00 00       	push   $0xfe
  8010cd:	68 01 2f 80 00       	push   $0x802f01
  8010d2:	e8 76 04 00 00       	call   80154d <_panic>
		found = 0;
  8010d7:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8010de:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8010e5:	e9 02 01 00 00       	jmp    8011ec <_main+0x11b4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8010ea:	a1 04 40 80 00       	mov    0x804004,%eax
  8010ef:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8010f5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010f8:	89 d0                	mov    %edx,%eax
  8010fa:	01 c0                	add    %eax,%eax
  8010fc:	01 d0                	add    %edx,%eax
  8010fe:	c1 e0 02             	shl    $0x2,%eax
  801101:	01 c8                	add    %ecx,%eax
  801103:	8b 00                	mov    (%eax),%eax
  801105:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  80110b:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  801111:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801116:	89 c2                	mov    %eax,%edx
  801118:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80111e:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  801124:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80112a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80112f:	39 c2                	cmp    %eax,%edx
  801131:	75 03                	jne    801136 <_main+0x10fe>
				found++;
  801133:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  801136:	a1 04 40 80 00       	mov    0x804004,%eax
  80113b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801141:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801144:	89 d0                	mov    %edx,%eax
  801146:	01 c0                	add    %eax,%eax
  801148:	01 d0                	add    %edx,%eax
  80114a:	c1 e0 02             	shl    $0x2,%eax
  80114d:	01 c8                	add    %ecx,%eax
  80114f:	8b 00                	mov    (%eax),%eax
  801151:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  801157:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80115d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801162:	89 c2                	mov    %eax,%edx
  801164:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80116a:	89 c1                	mov    %eax,%ecx
  80116c:	c1 e9 1f             	shr    $0x1f,%ecx
  80116f:	01 c8                	add    %ecx,%eax
  801171:	d1 f8                	sar    %eax
  801173:	89 c1                	mov    %eax,%ecx
  801175:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  80117b:	01 c8                	add    %ecx,%eax
  80117d:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  801183:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  801189:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80118e:	39 c2                	cmp    %eax,%edx
  801190:	75 03                	jne    801195 <_main+0x115d>
				found++;
  801192:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  801195:	a1 04 40 80 00       	mov    0x804004,%eax
  80119a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011a3:	89 d0                	mov    %edx,%eax
  8011a5:	01 c0                	add    %eax,%eax
  8011a7:	01 d0                	add    %edx,%eax
  8011a9:	c1 e0 02             	shl    $0x2,%eax
  8011ac:	01 c8                	add    %ecx,%eax
  8011ae:	8b 00                	mov    (%eax),%eax
  8011b0:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  8011b6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  8011bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011c1:	89 c1                	mov    %eax,%ecx
  8011c3:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  8011c9:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8011cf:	01 d0                	add    %edx,%eax
  8011d1:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  8011d7:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  8011dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011e2:	39 c1                	cmp    %eax,%ecx
  8011e4:	75 03                	jne    8011e9 <_main+0x11b1>
				found++;
  8011e6:	ff 45 d8             	incl   -0x28(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8011ec:	a1 04 40 80 00       	mov    0x804004,%eax
  8011f1:	8b 50 74             	mov    0x74(%eax),%edx
  8011f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8011f7:	39 c2                	cmp    %eax,%edx
  8011f9:	0f 87 eb fe ff ff    	ja     8010ea <_main+0x10b2>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  8011ff:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
  801203:	74 17                	je     80121c <_main+0x11e4>
  801205:	83 ec 04             	sub    $0x4,%esp
  801208:	68 38 30 80 00       	push   $0x803038
  80120d:	68 09 01 00 00       	push   $0x109
  801212:	68 01 2f 80 00       	push   $0x802f01
  801217:	e8 31 03 00 00       	call   80154d <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80121c:	e8 fb 15 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  801221:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  801224:	8b 55 d0             	mov    -0x30(%ebp),%edx
  801227:	89 d0                	mov    %edx,%eax
  801229:	01 c0                	add    %eax,%eax
  80122b:	01 d0                	add    %edx,%eax
  80122d:	01 c0                	add    %eax,%eax
  80122f:	01 d0                	add    %edx,%eax
  801231:	01 c0                	add    %eax,%eax
  801233:	83 ec 0c             	sub    $0xc,%esp
  801236:	50                   	push   %eax
  801237:	e8 4f 13 00 00       	call   80258b <malloc>
  80123c:	83 c4 10             	add    $0x10,%esp
  80123f:	89 85 9c fe ff ff    	mov    %eax,-0x164(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  801245:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  80124b:	89 c1                	mov    %eax,%ecx
  80124d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801250:	89 d0                	mov    %edx,%eax
  801252:	01 c0                	add    %eax,%eax
  801254:	01 d0                	add    %edx,%eax
  801256:	c1 e0 02             	shl    $0x2,%eax
  801259:	01 d0                	add    %edx,%eax
  80125b:	89 c2                	mov    %eax,%edx
  80125d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801260:	c1 e0 04             	shl    $0x4,%eax
  801263:	01 d0                	add    %edx,%eax
  801265:	05 00 00 00 80       	add    $0x80000000,%eax
  80126a:	39 c1                	cmp    %eax,%ecx
  80126c:	72 29                	jb     801297 <_main+0x125f>
  80126e:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  801274:	89 c1                	mov    %eax,%ecx
  801276:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801279:	89 d0                	mov    %edx,%eax
  80127b:	01 c0                	add    %eax,%eax
  80127d:	01 d0                	add    %edx,%eax
  80127f:	c1 e0 02             	shl    $0x2,%eax
  801282:	01 d0                	add    %edx,%eax
  801284:	89 c2                	mov    %eax,%edx
  801286:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801289:	c1 e0 04             	shl    $0x4,%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  801293:	39 c1                	cmp    %eax,%ecx
  801295:	76 17                	jbe    8012ae <_main+0x1276>
  801297:	83 ec 04             	sub    $0x4,%esp
  80129a:	68 5c 2f 80 00       	push   $0x802f5c
  80129f:	68 0e 01 00 00       	push   $0x10e
  8012a4:	68 01 2f 80 00       	push   $0x802f01
  8012a9:	e8 9f 02 00 00       	call   80154d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  8012ae:	e8 69 15 00 00       	call   80281c <sys_pf_calculate_allocated_pages>
  8012b3:	2b 45 90             	sub    -0x70(%ebp),%eax
  8012b6:	83 f8 04             	cmp    $0x4,%eax
  8012b9:	74 17                	je     8012d2 <_main+0x129a>
  8012bb:	83 ec 04             	sub    $0x4,%esp
  8012be:	68 c4 2f 80 00       	push   $0x802fc4
  8012c3:	68 0f 01 00 00       	push   $0x10f
  8012c8:	68 01 2f 80 00       	push   $0x802f01
  8012cd:	e8 7b 02 00 00       	call   80154d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8012d2:	e8 c2 14 00 00       	call   802799 <sys_calculate_free_frames>
  8012d7:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  8012da:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  8012e0:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  8012e6:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8012e9:	89 d0                	mov    %edx,%eax
  8012eb:	01 c0                	add    %eax,%eax
  8012ed:	01 d0                	add    %edx,%eax
  8012ef:	01 c0                	add    %eax,%eax
  8012f1:	01 d0                	add    %edx,%eax
  8012f3:	01 c0                	add    %eax,%eax
  8012f5:	d1 e8                	shr    %eax
  8012f7:	48                   	dec    %eax
  8012f8:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
		shortArr2[0] = minShort;
  8012fe:	8b 95 10 ff ff ff    	mov    -0xf0(%ebp),%edx
  801304:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801307:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  80130a:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801310:	01 c0                	add    %eax,%eax
  801312:	89 c2                	mov    %eax,%edx
  801314:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  80131a:	01 c2                	add    %eax,%edx
  80131c:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  801320:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  801323:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  801326:	e8 6e 14 00 00       	call   802799 <sys_calculate_free_frames>
  80132b:	29 c3                	sub    %eax,%ebx
  80132d:	89 d8                	mov    %ebx,%eax
  80132f:	83 f8 02             	cmp    $0x2,%eax
  801332:	74 17                	je     80134b <_main+0x1313>
  801334:	83 ec 04             	sub    $0x4,%esp
  801337:	68 f4 2f 80 00       	push   $0x802ff4
  80133c:	68 16 01 00 00       	push   $0x116
  801341:	68 01 2f 80 00       	push   $0x802f01
  801346:	e8 02 02 00 00       	call   80154d <_panic>
		found = 0;
  80134b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801352:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801359:	e9 a7 00 00 00       	jmp    801405 <_main+0x13cd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  80135e:	a1 04 40 80 00       	mov    0x804004,%eax
  801363:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801369:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80136c:	89 d0                	mov    %edx,%eax
  80136e:	01 c0                	add    %eax,%eax
  801370:	01 d0                	add    %edx,%eax
  801372:	c1 e0 02             	shl    $0x2,%eax
  801375:	01 c8                	add    %ecx,%eax
  801377:	8b 00                	mov    (%eax),%eax
  801379:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  80137f:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  801385:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80138a:	89 c2                	mov    %eax,%edx
  80138c:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  801392:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  801398:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  80139e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013a3:	39 c2                	cmp    %eax,%edx
  8013a5:	75 03                	jne    8013aa <_main+0x1372>
				found++;
  8013a7:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  8013aa:	a1 04 40 80 00       	mov    0x804004,%eax
  8013af:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8013b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013b8:	89 d0                	mov    %edx,%eax
  8013ba:	01 c0                	add    %eax,%eax
  8013bc:	01 d0                	add    %edx,%eax
  8013be:	c1 e0 02             	shl    $0x2,%eax
  8013c1:	01 c8                	add    %ecx,%eax
  8013c3:	8b 00                	mov    (%eax),%eax
  8013c5:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8013cb:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8013d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013d6:	89 c2                	mov    %eax,%edx
  8013d8:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  8013de:	01 c0                	add    %eax,%eax
  8013e0:	89 c1                	mov    %eax,%ecx
  8013e2:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8013e8:	01 c8                	add    %ecx,%eax
  8013ea:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8013f0:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8013f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013fb:	39 c2                	cmp    %eax,%edx
  8013fd:	75 03                	jne    801402 <_main+0x13ca>
				found++;
  8013ff:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801402:	ff 45 e4             	incl   -0x1c(%ebp)
  801405:	a1 04 40 80 00       	mov    0x804004,%eax
  80140a:	8b 50 74             	mov    0x74(%eax),%edx
  80140d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801410:	39 c2                	cmp    %eax,%edx
  801412:	0f 87 46 ff ff ff    	ja     80135e <_main+0x1326>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  801418:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  80141c:	74 17                	je     801435 <_main+0x13fd>
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	68 38 30 80 00       	push   $0x803038
  801426:	68 1f 01 00 00       	push   $0x11f
  80142b:	68 01 2f 80 00       	push   $0x802f01
  801430:	e8 18 01 00 00       	call   80154d <_panic>
		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
*/
	return;
  801435:	90                   	nop
}
  801436:	8d 65 f4             	lea    -0xc(%ebp),%esp
  801439:	5b                   	pop    %ebx
  80143a:	5e                   	pop    %esi
  80143b:	5f                   	pop    %edi
  80143c:	5d                   	pop    %ebp
  80143d:	c3                   	ret    

0080143e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801444:	e8 85 12 00 00       	call   8026ce <sys_getenvindex>
  801449:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80144c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80144f:	89 d0                	mov    %edx,%eax
  801451:	c1 e0 02             	shl    $0x2,%eax
  801454:	01 d0                	add    %edx,%eax
  801456:	01 c0                	add    %eax,%eax
  801458:	01 d0                	add    %edx,%eax
  80145a:	01 c0                	add    %eax,%eax
  80145c:	01 d0                	add    %edx,%eax
  80145e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801465:	01 d0                	add    %edx,%eax
  801467:	c1 e0 02             	shl    $0x2,%eax
  80146a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80146f:	a3 04 40 80 00       	mov    %eax,0x804004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801474:	a1 04 40 80 00       	mov    0x804004,%eax
  801479:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80147f:	84 c0                	test   %al,%al
  801481:	74 0f                	je     801492 <libmain+0x54>
		binaryname = myEnv->prog_name;
  801483:	a1 04 40 80 00       	mov    0x804004,%eax
  801488:	05 f4 02 00 00       	add    $0x2f4,%eax
  80148d:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801492:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801496:	7e 0a                	jle    8014a2 <libmain+0x64>
		binaryname = argv[0];
  801498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149b:	8b 00                	mov    (%eax),%eax
  80149d:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8014a2:	83 ec 08             	sub    $0x8,%esp
  8014a5:	ff 75 0c             	pushl  0xc(%ebp)
  8014a8:	ff 75 08             	pushl  0x8(%ebp)
  8014ab:	e8 88 eb ff ff       	call   800038 <_main>
  8014b0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8014b3:	e8 b1 13 00 00       	call   802869 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8014b8:	83 ec 0c             	sub    $0xc,%esp
  8014bb:	68 5c 31 80 00       	push   $0x80315c
  8014c0:	e8 3c 03 00 00       	call   801801 <cprintf>
  8014c5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8014c8:	a1 04 40 80 00       	mov    0x804004,%eax
  8014cd:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8014d3:	a1 04 40 80 00       	mov    0x804004,%eax
  8014d8:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8014de:	83 ec 04             	sub    $0x4,%esp
  8014e1:	52                   	push   %edx
  8014e2:	50                   	push   %eax
  8014e3:	68 84 31 80 00       	push   $0x803184
  8014e8:	e8 14 03 00 00       	call   801801 <cprintf>
  8014ed:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8014f0:	a1 04 40 80 00       	mov    0x804004,%eax
  8014f5:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8014fb:	83 ec 08             	sub    $0x8,%esp
  8014fe:	50                   	push   %eax
  8014ff:	68 a9 31 80 00       	push   $0x8031a9
  801504:	e8 f8 02 00 00       	call   801801 <cprintf>
  801509:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80150c:	83 ec 0c             	sub    $0xc,%esp
  80150f:	68 5c 31 80 00       	push   $0x80315c
  801514:	e8 e8 02 00 00       	call   801801 <cprintf>
  801519:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80151c:	e8 62 13 00 00       	call   802883 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801521:	e8 19 00 00 00       	call   80153f <exit>
}
  801526:	90                   	nop
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80152f:	83 ec 0c             	sub    $0xc,%esp
  801532:	6a 00                	push   $0x0
  801534:	e8 61 11 00 00       	call   80269a <sys_env_destroy>
  801539:	83 c4 10             	add    $0x10,%esp
}
  80153c:	90                   	nop
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <exit>:

void
exit(void)
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
  801542:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801545:	e8 b6 11 00 00       	call   802700 <sys_env_exit>
}
  80154a:	90                   	nop
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
  801550:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801553:	8d 45 10             	lea    0x10(%ebp),%eax
  801556:	83 c0 04             	add    $0x4,%eax
  801559:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80155c:	a1 14 40 80 00       	mov    0x804014,%eax
  801561:	85 c0                	test   %eax,%eax
  801563:	74 16                	je     80157b <_panic+0x2e>
		cprintf("%s: ", argv0);
  801565:	a1 14 40 80 00       	mov    0x804014,%eax
  80156a:	83 ec 08             	sub    $0x8,%esp
  80156d:	50                   	push   %eax
  80156e:	68 c0 31 80 00       	push   $0x8031c0
  801573:	e8 89 02 00 00       	call   801801 <cprintf>
  801578:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80157b:	a1 00 40 80 00       	mov    0x804000,%eax
  801580:	ff 75 0c             	pushl  0xc(%ebp)
  801583:	ff 75 08             	pushl  0x8(%ebp)
  801586:	50                   	push   %eax
  801587:	68 c5 31 80 00       	push   $0x8031c5
  80158c:	e8 70 02 00 00       	call   801801 <cprintf>
  801591:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801594:	8b 45 10             	mov    0x10(%ebp),%eax
  801597:	83 ec 08             	sub    $0x8,%esp
  80159a:	ff 75 f4             	pushl  -0xc(%ebp)
  80159d:	50                   	push   %eax
  80159e:	e8 f3 01 00 00       	call   801796 <vcprintf>
  8015a3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8015a6:	83 ec 08             	sub    $0x8,%esp
  8015a9:	6a 00                	push   $0x0
  8015ab:	68 e1 31 80 00       	push   $0x8031e1
  8015b0:	e8 e1 01 00 00       	call   801796 <vcprintf>
  8015b5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015b8:	e8 82 ff ff ff       	call   80153f <exit>

	// should not return here
	while (1) ;
  8015bd:	eb fe                	jmp    8015bd <_panic+0x70>

008015bf <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
  8015c2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015c5:	a1 04 40 80 00       	mov    0x804004,%eax
  8015ca:	8b 50 74             	mov    0x74(%eax),%edx
  8015cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d0:	39 c2                	cmp    %eax,%edx
  8015d2:	74 14                	je     8015e8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8015d4:	83 ec 04             	sub    $0x4,%esp
  8015d7:	68 e4 31 80 00       	push   $0x8031e4
  8015dc:	6a 26                	push   $0x26
  8015de:	68 30 32 80 00       	push   $0x803230
  8015e3:	e8 65 ff ff ff       	call   80154d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8015e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8015ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015f6:	e9 c2 00 00 00       	jmp    8016bd <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8015fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801605:	8b 45 08             	mov    0x8(%ebp),%eax
  801608:	01 d0                	add    %edx,%eax
  80160a:	8b 00                	mov    (%eax),%eax
  80160c:	85 c0                	test   %eax,%eax
  80160e:	75 08                	jne    801618 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801610:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801613:	e9 a2 00 00 00       	jmp    8016ba <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801618:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80161f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801626:	eb 69                	jmp    801691 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801628:	a1 04 40 80 00       	mov    0x804004,%eax
  80162d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801633:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801636:	89 d0                	mov    %edx,%eax
  801638:	01 c0                	add    %eax,%eax
  80163a:	01 d0                	add    %edx,%eax
  80163c:	c1 e0 02             	shl    $0x2,%eax
  80163f:	01 c8                	add    %ecx,%eax
  801641:	8a 40 04             	mov    0x4(%eax),%al
  801644:	84 c0                	test   %al,%al
  801646:	75 46                	jne    80168e <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801648:	a1 04 40 80 00       	mov    0x804004,%eax
  80164d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801653:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801656:	89 d0                	mov    %edx,%eax
  801658:	01 c0                	add    %eax,%eax
  80165a:	01 d0                	add    %edx,%eax
  80165c:	c1 e0 02             	shl    $0x2,%eax
  80165f:	01 c8                	add    %ecx,%eax
  801661:	8b 00                	mov    (%eax),%eax
  801663:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801666:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801669:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80166e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801670:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801673:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	01 c8                	add    %ecx,%eax
  80167f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801681:	39 c2                	cmp    %eax,%edx
  801683:	75 09                	jne    80168e <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801685:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80168c:	eb 12                	jmp    8016a0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80168e:	ff 45 e8             	incl   -0x18(%ebp)
  801691:	a1 04 40 80 00       	mov    0x804004,%eax
  801696:	8b 50 74             	mov    0x74(%eax),%edx
  801699:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80169c:	39 c2                	cmp    %eax,%edx
  80169e:	77 88                	ja     801628 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8016a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8016a4:	75 14                	jne    8016ba <CheckWSWithoutLastIndex+0xfb>
			panic(
  8016a6:	83 ec 04             	sub    $0x4,%esp
  8016a9:	68 3c 32 80 00       	push   $0x80323c
  8016ae:	6a 3a                	push   $0x3a
  8016b0:	68 30 32 80 00       	push   $0x803230
  8016b5:	e8 93 fe ff ff       	call   80154d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8016ba:	ff 45 f0             	incl   -0x10(%ebp)
  8016bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016c0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016c3:	0f 8c 32 ff ff ff    	jl     8015fb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8016d7:	eb 26                	jmp    8016ff <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8016d9:	a1 04 40 80 00       	mov    0x804004,%eax
  8016de:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8016e4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016e7:	89 d0                	mov    %edx,%eax
  8016e9:	01 c0                	add    %eax,%eax
  8016eb:	01 d0                	add    %edx,%eax
  8016ed:	c1 e0 02             	shl    $0x2,%eax
  8016f0:	01 c8                	add    %ecx,%eax
  8016f2:	8a 40 04             	mov    0x4(%eax),%al
  8016f5:	3c 01                	cmp    $0x1,%al
  8016f7:	75 03                	jne    8016fc <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8016f9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016fc:	ff 45 e0             	incl   -0x20(%ebp)
  8016ff:	a1 04 40 80 00       	mov    0x804004,%eax
  801704:	8b 50 74             	mov    0x74(%eax),%edx
  801707:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80170a:	39 c2                	cmp    %eax,%edx
  80170c:	77 cb                	ja     8016d9 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80170e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801711:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801714:	74 14                	je     80172a <CheckWSWithoutLastIndex+0x16b>
		panic(
  801716:	83 ec 04             	sub    $0x4,%esp
  801719:	68 90 32 80 00       	push   $0x803290
  80171e:	6a 44                	push   $0x44
  801720:	68 30 32 80 00       	push   $0x803230
  801725:	e8 23 fe ff ff       	call   80154d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80172a:	90                   	nop
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
  801730:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801733:	8b 45 0c             	mov    0xc(%ebp),%eax
  801736:	8b 00                	mov    (%eax),%eax
  801738:	8d 48 01             	lea    0x1(%eax),%ecx
  80173b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173e:	89 0a                	mov    %ecx,(%edx)
  801740:	8b 55 08             	mov    0x8(%ebp),%edx
  801743:	88 d1                	mov    %dl,%cl
  801745:	8b 55 0c             	mov    0xc(%ebp),%edx
  801748:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80174c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174f:	8b 00                	mov    (%eax),%eax
  801751:	3d ff 00 00 00       	cmp    $0xff,%eax
  801756:	75 2c                	jne    801784 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801758:	a0 08 40 80 00       	mov    0x804008,%al
  80175d:	0f b6 c0             	movzbl %al,%eax
  801760:	8b 55 0c             	mov    0xc(%ebp),%edx
  801763:	8b 12                	mov    (%edx),%edx
  801765:	89 d1                	mov    %edx,%ecx
  801767:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176a:	83 c2 08             	add    $0x8,%edx
  80176d:	83 ec 04             	sub    $0x4,%esp
  801770:	50                   	push   %eax
  801771:	51                   	push   %ecx
  801772:	52                   	push   %edx
  801773:	e8 e0 0e 00 00       	call   802658 <sys_cputs>
  801778:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80177b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801784:	8b 45 0c             	mov    0xc(%ebp),%eax
  801787:	8b 40 04             	mov    0x4(%eax),%eax
  80178a:	8d 50 01             	lea    0x1(%eax),%edx
  80178d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801790:	89 50 04             	mov    %edx,0x4(%eax)
}
  801793:	90                   	nop
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
  801799:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80179f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8017a6:	00 00 00 
	b.cnt = 0;
  8017a9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8017b0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8017b3:	ff 75 0c             	pushl  0xc(%ebp)
  8017b6:	ff 75 08             	pushl  0x8(%ebp)
  8017b9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017bf:	50                   	push   %eax
  8017c0:	68 2d 17 80 00       	push   $0x80172d
  8017c5:	e8 11 02 00 00       	call   8019db <vprintfmt>
  8017ca:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8017cd:	a0 08 40 80 00       	mov    0x804008,%al
  8017d2:	0f b6 c0             	movzbl %al,%eax
  8017d5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8017db:	83 ec 04             	sub    $0x4,%esp
  8017de:	50                   	push   %eax
  8017df:	52                   	push   %edx
  8017e0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017e6:	83 c0 08             	add    $0x8,%eax
  8017e9:	50                   	push   %eax
  8017ea:	e8 69 0e 00 00       	call   802658 <sys_cputs>
  8017ef:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8017f2:	c6 05 08 40 80 00 00 	movb   $0x0,0x804008
	return b.cnt;
  8017f9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <cprintf>:

int cprintf(const char *fmt, ...) {
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
  801804:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801807:	c6 05 08 40 80 00 01 	movb   $0x1,0x804008
	va_start(ap, fmt);
  80180e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801811:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801814:	8b 45 08             	mov    0x8(%ebp),%eax
  801817:	83 ec 08             	sub    $0x8,%esp
  80181a:	ff 75 f4             	pushl  -0xc(%ebp)
  80181d:	50                   	push   %eax
  80181e:	e8 73 ff ff ff       	call   801796 <vcprintf>
  801823:	83 c4 10             	add    $0x10,%esp
  801826:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801829:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801834:	e8 30 10 00 00       	call   802869 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801839:	8d 45 0c             	lea    0xc(%ebp),%eax
  80183c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80183f:	8b 45 08             	mov    0x8(%ebp),%eax
  801842:	83 ec 08             	sub    $0x8,%esp
  801845:	ff 75 f4             	pushl  -0xc(%ebp)
  801848:	50                   	push   %eax
  801849:	e8 48 ff ff ff       	call   801796 <vcprintf>
  80184e:	83 c4 10             	add    $0x10,%esp
  801851:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801854:	e8 2a 10 00 00       	call   802883 <sys_enable_interrupt>
	return cnt;
  801859:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80185c:	c9                   	leave  
  80185d:	c3                   	ret    

0080185e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
  801861:	53                   	push   %ebx
  801862:	83 ec 14             	sub    $0x14,%esp
  801865:	8b 45 10             	mov    0x10(%ebp),%eax
  801868:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80186b:	8b 45 14             	mov    0x14(%ebp),%eax
  80186e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801871:	8b 45 18             	mov    0x18(%ebp),%eax
  801874:	ba 00 00 00 00       	mov    $0x0,%edx
  801879:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80187c:	77 55                	ja     8018d3 <printnum+0x75>
  80187e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801881:	72 05                	jb     801888 <printnum+0x2a>
  801883:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801886:	77 4b                	ja     8018d3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801888:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80188b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80188e:	8b 45 18             	mov    0x18(%ebp),%eax
  801891:	ba 00 00 00 00       	mov    $0x0,%edx
  801896:	52                   	push   %edx
  801897:	50                   	push   %eax
  801898:	ff 75 f4             	pushl  -0xc(%ebp)
  80189b:	ff 75 f0             	pushl  -0x10(%ebp)
  80189e:	e8 a5 13 00 00       	call   802c48 <__udivdi3>
  8018a3:	83 c4 10             	add    $0x10,%esp
  8018a6:	83 ec 04             	sub    $0x4,%esp
  8018a9:	ff 75 20             	pushl  0x20(%ebp)
  8018ac:	53                   	push   %ebx
  8018ad:	ff 75 18             	pushl  0x18(%ebp)
  8018b0:	52                   	push   %edx
  8018b1:	50                   	push   %eax
  8018b2:	ff 75 0c             	pushl  0xc(%ebp)
  8018b5:	ff 75 08             	pushl  0x8(%ebp)
  8018b8:	e8 a1 ff ff ff       	call   80185e <printnum>
  8018bd:	83 c4 20             	add    $0x20,%esp
  8018c0:	eb 1a                	jmp    8018dc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018c2:	83 ec 08             	sub    $0x8,%esp
  8018c5:	ff 75 0c             	pushl  0xc(%ebp)
  8018c8:	ff 75 20             	pushl  0x20(%ebp)
  8018cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ce:	ff d0                	call   *%eax
  8018d0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8018d3:	ff 4d 1c             	decl   0x1c(%ebp)
  8018d6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8018da:	7f e6                	jg     8018c2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8018dc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8018df:	bb 00 00 00 00       	mov    $0x0,%ebx
  8018e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018ea:	53                   	push   %ebx
  8018eb:	51                   	push   %ecx
  8018ec:	52                   	push   %edx
  8018ed:	50                   	push   %eax
  8018ee:	e8 65 14 00 00       	call   802d58 <__umoddi3>
  8018f3:	83 c4 10             	add    $0x10,%esp
  8018f6:	05 f4 34 80 00       	add    $0x8034f4,%eax
  8018fb:	8a 00                	mov    (%eax),%al
  8018fd:	0f be c0             	movsbl %al,%eax
  801900:	83 ec 08             	sub    $0x8,%esp
  801903:	ff 75 0c             	pushl  0xc(%ebp)
  801906:	50                   	push   %eax
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	ff d0                	call   *%eax
  80190c:	83 c4 10             	add    $0x10,%esp
}
  80190f:	90                   	nop
  801910:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801918:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80191c:	7e 1c                	jle    80193a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	8b 00                	mov    (%eax),%eax
  801923:	8d 50 08             	lea    0x8(%eax),%edx
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	89 10                	mov    %edx,(%eax)
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	8b 00                	mov    (%eax),%eax
  801930:	83 e8 08             	sub    $0x8,%eax
  801933:	8b 50 04             	mov    0x4(%eax),%edx
  801936:	8b 00                	mov    (%eax),%eax
  801938:	eb 40                	jmp    80197a <getuint+0x65>
	else if (lflag)
  80193a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80193e:	74 1e                	je     80195e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	8b 00                	mov    (%eax),%eax
  801945:	8d 50 04             	lea    0x4(%eax),%edx
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	89 10                	mov    %edx,(%eax)
  80194d:	8b 45 08             	mov    0x8(%ebp),%eax
  801950:	8b 00                	mov    (%eax),%eax
  801952:	83 e8 04             	sub    $0x4,%eax
  801955:	8b 00                	mov    (%eax),%eax
  801957:	ba 00 00 00 00       	mov    $0x0,%edx
  80195c:	eb 1c                	jmp    80197a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	8b 00                	mov    (%eax),%eax
  801963:	8d 50 04             	lea    0x4(%eax),%edx
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	89 10                	mov    %edx,(%eax)
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	8b 00                	mov    (%eax),%eax
  801970:	83 e8 04             	sub    $0x4,%eax
  801973:	8b 00                	mov    (%eax),%eax
  801975:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80197a:	5d                   	pop    %ebp
  80197b:	c3                   	ret    

0080197c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80197f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801983:	7e 1c                	jle    8019a1 <getint+0x25>
		return va_arg(*ap, long long);
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8b 00                	mov    (%eax),%eax
  80198a:	8d 50 08             	lea    0x8(%eax),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	89 10                	mov    %edx,(%eax)
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	8b 00                	mov    (%eax),%eax
  801997:	83 e8 08             	sub    $0x8,%eax
  80199a:	8b 50 04             	mov    0x4(%eax),%edx
  80199d:	8b 00                	mov    (%eax),%eax
  80199f:	eb 38                	jmp    8019d9 <getint+0x5d>
	else if (lflag)
  8019a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019a5:	74 1a                	je     8019c1 <getint+0x45>
		return va_arg(*ap, long);
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	8b 00                	mov    (%eax),%eax
  8019ac:	8d 50 04             	lea    0x4(%eax),%edx
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	89 10                	mov    %edx,(%eax)
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	8b 00                	mov    (%eax),%eax
  8019b9:	83 e8 04             	sub    $0x4,%eax
  8019bc:	8b 00                	mov    (%eax),%eax
  8019be:	99                   	cltd   
  8019bf:	eb 18                	jmp    8019d9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8b 00                	mov    (%eax),%eax
  8019c6:	8d 50 04             	lea    0x4(%eax),%edx
  8019c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cc:	89 10                	mov    %edx,(%eax)
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	8b 00                	mov    (%eax),%eax
  8019d3:	83 e8 04             	sub    $0x4,%eax
  8019d6:	8b 00                	mov    (%eax),%eax
  8019d8:	99                   	cltd   
}
  8019d9:	5d                   	pop    %ebp
  8019da:	c3                   	ret    

008019db <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
  8019de:	56                   	push   %esi
  8019df:	53                   	push   %ebx
  8019e0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019e3:	eb 17                	jmp    8019fc <vprintfmt+0x21>
			if (ch == '\0')
  8019e5:	85 db                	test   %ebx,%ebx
  8019e7:	0f 84 af 03 00 00    	je     801d9c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8019ed:	83 ec 08             	sub    $0x8,%esp
  8019f0:	ff 75 0c             	pushl  0xc(%ebp)
  8019f3:	53                   	push   %ebx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	ff d0                	call   *%eax
  8019f9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ff:	8d 50 01             	lea    0x1(%eax),%edx
  801a02:	89 55 10             	mov    %edx,0x10(%ebp)
  801a05:	8a 00                	mov    (%eax),%al
  801a07:	0f b6 d8             	movzbl %al,%ebx
  801a0a:	83 fb 25             	cmp    $0x25,%ebx
  801a0d:	75 d6                	jne    8019e5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a0f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a13:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a1a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a21:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a28:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a2f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a32:	8d 50 01             	lea    0x1(%eax),%edx
  801a35:	89 55 10             	mov    %edx,0x10(%ebp)
  801a38:	8a 00                	mov    (%eax),%al
  801a3a:	0f b6 d8             	movzbl %al,%ebx
  801a3d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a40:	83 f8 55             	cmp    $0x55,%eax
  801a43:	0f 87 2b 03 00 00    	ja     801d74 <vprintfmt+0x399>
  801a49:	8b 04 85 18 35 80 00 	mov    0x803518(,%eax,4),%eax
  801a50:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a52:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a56:	eb d7                	jmp    801a2f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a58:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a5c:	eb d1                	jmp    801a2f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a5e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a65:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a68:	89 d0                	mov    %edx,%eax
  801a6a:	c1 e0 02             	shl    $0x2,%eax
  801a6d:	01 d0                	add    %edx,%eax
  801a6f:	01 c0                	add    %eax,%eax
  801a71:	01 d8                	add    %ebx,%eax
  801a73:	83 e8 30             	sub    $0x30,%eax
  801a76:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801a79:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7c:	8a 00                	mov    (%eax),%al
  801a7e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801a81:	83 fb 2f             	cmp    $0x2f,%ebx
  801a84:	7e 3e                	jle    801ac4 <vprintfmt+0xe9>
  801a86:	83 fb 39             	cmp    $0x39,%ebx
  801a89:	7f 39                	jg     801ac4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a8b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801a8e:	eb d5                	jmp    801a65 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801a90:	8b 45 14             	mov    0x14(%ebp),%eax
  801a93:	83 c0 04             	add    $0x4,%eax
  801a96:	89 45 14             	mov    %eax,0x14(%ebp)
  801a99:	8b 45 14             	mov    0x14(%ebp),%eax
  801a9c:	83 e8 04             	sub    $0x4,%eax
  801a9f:	8b 00                	mov    (%eax),%eax
  801aa1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801aa4:	eb 1f                	jmp    801ac5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801aa6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801aaa:	79 83                	jns    801a2f <vprintfmt+0x54>
				width = 0;
  801aac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801ab3:	e9 77 ff ff ff       	jmp    801a2f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801ab8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801abf:	e9 6b ff ff ff       	jmp    801a2f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801ac4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801ac5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ac9:	0f 89 60 ff ff ff    	jns    801a2f <vprintfmt+0x54>
				width = precision, precision = -1;
  801acf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ad2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801ad5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801adc:	e9 4e ff ff ff       	jmp    801a2f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801ae1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801ae4:	e9 46 ff ff ff       	jmp    801a2f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801ae9:	8b 45 14             	mov    0x14(%ebp),%eax
  801aec:	83 c0 04             	add    $0x4,%eax
  801aef:	89 45 14             	mov    %eax,0x14(%ebp)
  801af2:	8b 45 14             	mov    0x14(%ebp),%eax
  801af5:	83 e8 04             	sub    $0x4,%eax
  801af8:	8b 00                	mov    (%eax),%eax
  801afa:	83 ec 08             	sub    $0x8,%esp
  801afd:	ff 75 0c             	pushl  0xc(%ebp)
  801b00:	50                   	push   %eax
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	ff d0                	call   *%eax
  801b06:	83 c4 10             	add    $0x10,%esp
			break;
  801b09:	e9 89 02 00 00       	jmp    801d97 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b0e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b11:	83 c0 04             	add    $0x4,%eax
  801b14:	89 45 14             	mov    %eax,0x14(%ebp)
  801b17:	8b 45 14             	mov    0x14(%ebp),%eax
  801b1a:	83 e8 04             	sub    $0x4,%eax
  801b1d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b1f:	85 db                	test   %ebx,%ebx
  801b21:	79 02                	jns    801b25 <vprintfmt+0x14a>
				err = -err;
  801b23:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b25:	83 fb 64             	cmp    $0x64,%ebx
  801b28:	7f 0b                	jg     801b35 <vprintfmt+0x15a>
  801b2a:	8b 34 9d 60 33 80 00 	mov    0x803360(,%ebx,4),%esi
  801b31:	85 f6                	test   %esi,%esi
  801b33:	75 19                	jne    801b4e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b35:	53                   	push   %ebx
  801b36:	68 05 35 80 00       	push   $0x803505
  801b3b:	ff 75 0c             	pushl  0xc(%ebp)
  801b3e:	ff 75 08             	pushl  0x8(%ebp)
  801b41:	e8 5e 02 00 00       	call   801da4 <printfmt>
  801b46:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b49:	e9 49 02 00 00       	jmp    801d97 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b4e:	56                   	push   %esi
  801b4f:	68 0e 35 80 00       	push   $0x80350e
  801b54:	ff 75 0c             	pushl  0xc(%ebp)
  801b57:	ff 75 08             	pushl  0x8(%ebp)
  801b5a:	e8 45 02 00 00       	call   801da4 <printfmt>
  801b5f:	83 c4 10             	add    $0x10,%esp
			break;
  801b62:	e9 30 02 00 00       	jmp    801d97 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b67:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6a:	83 c0 04             	add    $0x4,%eax
  801b6d:	89 45 14             	mov    %eax,0x14(%ebp)
  801b70:	8b 45 14             	mov    0x14(%ebp),%eax
  801b73:	83 e8 04             	sub    $0x4,%eax
  801b76:	8b 30                	mov    (%eax),%esi
  801b78:	85 f6                	test   %esi,%esi
  801b7a:	75 05                	jne    801b81 <vprintfmt+0x1a6>
				p = "(null)";
  801b7c:	be 11 35 80 00       	mov    $0x803511,%esi
			if (width > 0 && padc != '-')
  801b81:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b85:	7e 6d                	jle    801bf4 <vprintfmt+0x219>
  801b87:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801b8b:	74 67                	je     801bf4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801b8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b90:	83 ec 08             	sub    $0x8,%esp
  801b93:	50                   	push   %eax
  801b94:	56                   	push   %esi
  801b95:	e8 0c 03 00 00       	call   801ea6 <strnlen>
  801b9a:	83 c4 10             	add    $0x10,%esp
  801b9d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801ba0:	eb 16                	jmp    801bb8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801ba2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801ba6:	83 ec 08             	sub    $0x8,%esp
  801ba9:	ff 75 0c             	pushl  0xc(%ebp)
  801bac:	50                   	push   %eax
  801bad:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb0:	ff d0                	call   *%eax
  801bb2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801bb5:	ff 4d e4             	decl   -0x1c(%ebp)
  801bb8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bbc:	7f e4                	jg     801ba2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bbe:	eb 34                	jmp    801bf4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801bc0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801bc4:	74 1c                	je     801be2 <vprintfmt+0x207>
  801bc6:	83 fb 1f             	cmp    $0x1f,%ebx
  801bc9:	7e 05                	jle    801bd0 <vprintfmt+0x1f5>
  801bcb:	83 fb 7e             	cmp    $0x7e,%ebx
  801bce:	7e 12                	jle    801be2 <vprintfmt+0x207>
					putch('?', putdat);
  801bd0:	83 ec 08             	sub    $0x8,%esp
  801bd3:	ff 75 0c             	pushl  0xc(%ebp)
  801bd6:	6a 3f                	push   $0x3f
  801bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdb:	ff d0                	call   *%eax
  801bdd:	83 c4 10             	add    $0x10,%esp
  801be0:	eb 0f                	jmp    801bf1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801be2:	83 ec 08             	sub    $0x8,%esp
  801be5:	ff 75 0c             	pushl  0xc(%ebp)
  801be8:	53                   	push   %ebx
  801be9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bec:	ff d0                	call   *%eax
  801bee:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bf1:	ff 4d e4             	decl   -0x1c(%ebp)
  801bf4:	89 f0                	mov    %esi,%eax
  801bf6:	8d 70 01             	lea    0x1(%eax),%esi
  801bf9:	8a 00                	mov    (%eax),%al
  801bfb:	0f be d8             	movsbl %al,%ebx
  801bfe:	85 db                	test   %ebx,%ebx
  801c00:	74 24                	je     801c26 <vprintfmt+0x24b>
  801c02:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c06:	78 b8                	js     801bc0 <vprintfmt+0x1e5>
  801c08:	ff 4d e0             	decl   -0x20(%ebp)
  801c0b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c0f:	79 af                	jns    801bc0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c11:	eb 13                	jmp    801c26 <vprintfmt+0x24b>
				putch(' ', putdat);
  801c13:	83 ec 08             	sub    $0x8,%esp
  801c16:	ff 75 0c             	pushl  0xc(%ebp)
  801c19:	6a 20                	push   $0x20
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	ff d0                	call   *%eax
  801c20:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c23:	ff 4d e4             	decl   -0x1c(%ebp)
  801c26:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c2a:	7f e7                	jg     801c13 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c2c:	e9 66 01 00 00       	jmp    801d97 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c31:	83 ec 08             	sub    $0x8,%esp
  801c34:	ff 75 e8             	pushl  -0x18(%ebp)
  801c37:	8d 45 14             	lea    0x14(%ebp),%eax
  801c3a:	50                   	push   %eax
  801c3b:	e8 3c fd ff ff       	call   80197c <getint>
  801c40:	83 c4 10             	add    $0x10,%esp
  801c43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c4f:	85 d2                	test   %edx,%edx
  801c51:	79 23                	jns    801c76 <vprintfmt+0x29b>
				putch('-', putdat);
  801c53:	83 ec 08             	sub    $0x8,%esp
  801c56:	ff 75 0c             	pushl  0xc(%ebp)
  801c59:	6a 2d                	push   $0x2d
  801c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5e:	ff d0                	call   *%eax
  801c60:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c63:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c66:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c69:	f7 d8                	neg    %eax
  801c6b:	83 d2 00             	adc    $0x0,%edx
  801c6e:	f7 da                	neg    %edx
  801c70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c73:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801c76:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801c7d:	e9 bc 00 00 00       	jmp    801d3e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801c82:	83 ec 08             	sub    $0x8,%esp
  801c85:	ff 75 e8             	pushl  -0x18(%ebp)
  801c88:	8d 45 14             	lea    0x14(%ebp),%eax
  801c8b:	50                   	push   %eax
  801c8c:	e8 84 fc ff ff       	call   801915 <getuint>
  801c91:	83 c4 10             	add    $0x10,%esp
  801c94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801c9a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ca1:	e9 98 00 00 00       	jmp    801d3e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801ca6:	83 ec 08             	sub    $0x8,%esp
  801ca9:	ff 75 0c             	pushl  0xc(%ebp)
  801cac:	6a 58                	push   $0x58
  801cae:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb1:	ff d0                	call   *%eax
  801cb3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cb6:	83 ec 08             	sub    $0x8,%esp
  801cb9:	ff 75 0c             	pushl  0xc(%ebp)
  801cbc:	6a 58                	push   $0x58
  801cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc1:	ff d0                	call   *%eax
  801cc3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801cc6:	83 ec 08             	sub    $0x8,%esp
  801cc9:	ff 75 0c             	pushl  0xc(%ebp)
  801ccc:	6a 58                	push   $0x58
  801cce:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd1:	ff d0                	call   *%eax
  801cd3:	83 c4 10             	add    $0x10,%esp
			break;
  801cd6:	e9 bc 00 00 00       	jmp    801d97 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801cdb:	83 ec 08             	sub    $0x8,%esp
  801cde:	ff 75 0c             	pushl  0xc(%ebp)
  801ce1:	6a 30                	push   $0x30
  801ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce6:	ff d0                	call   *%eax
  801ce8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801ceb:	83 ec 08             	sub    $0x8,%esp
  801cee:	ff 75 0c             	pushl  0xc(%ebp)
  801cf1:	6a 78                	push   $0x78
  801cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf6:	ff d0                	call   *%eax
  801cf8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801cfb:	8b 45 14             	mov    0x14(%ebp),%eax
  801cfe:	83 c0 04             	add    $0x4,%eax
  801d01:	89 45 14             	mov    %eax,0x14(%ebp)
  801d04:	8b 45 14             	mov    0x14(%ebp),%eax
  801d07:	83 e8 04             	sub    $0x4,%eax
  801d0a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801d0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d16:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d1d:	eb 1f                	jmp    801d3e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d1f:	83 ec 08             	sub    $0x8,%esp
  801d22:	ff 75 e8             	pushl  -0x18(%ebp)
  801d25:	8d 45 14             	lea    0x14(%ebp),%eax
  801d28:	50                   	push   %eax
  801d29:	e8 e7 fb ff ff       	call   801915 <getuint>
  801d2e:	83 c4 10             	add    $0x10,%esp
  801d31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d34:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d37:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d3e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d42:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d45:	83 ec 04             	sub    $0x4,%esp
  801d48:	52                   	push   %edx
  801d49:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d4c:	50                   	push   %eax
  801d4d:	ff 75 f4             	pushl  -0xc(%ebp)
  801d50:	ff 75 f0             	pushl  -0x10(%ebp)
  801d53:	ff 75 0c             	pushl  0xc(%ebp)
  801d56:	ff 75 08             	pushl  0x8(%ebp)
  801d59:	e8 00 fb ff ff       	call   80185e <printnum>
  801d5e:	83 c4 20             	add    $0x20,%esp
			break;
  801d61:	eb 34                	jmp    801d97 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d63:	83 ec 08             	sub    $0x8,%esp
  801d66:	ff 75 0c             	pushl  0xc(%ebp)
  801d69:	53                   	push   %ebx
  801d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6d:	ff d0                	call   *%eax
  801d6f:	83 c4 10             	add    $0x10,%esp
			break;
  801d72:	eb 23                	jmp    801d97 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801d74:	83 ec 08             	sub    $0x8,%esp
  801d77:	ff 75 0c             	pushl  0xc(%ebp)
  801d7a:	6a 25                	push   $0x25
  801d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7f:	ff d0                	call   *%eax
  801d81:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801d84:	ff 4d 10             	decl   0x10(%ebp)
  801d87:	eb 03                	jmp    801d8c <vprintfmt+0x3b1>
  801d89:	ff 4d 10             	decl   0x10(%ebp)
  801d8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801d8f:	48                   	dec    %eax
  801d90:	8a 00                	mov    (%eax),%al
  801d92:	3c 25                	cmp    $0x25,%al
  801d94:	75 f3                	jne    801d89 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801d96:	90                   	nop
		}
	}
  801d97:	e9 47 fc ff ff       	jmp    8019e3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801d9c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801d9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801da0:	5b                   	pop    %ebx
  801da1:	5e                   	pop    %esi
  801da2:	5d                   	pop    %ebp
  801da3:	c3                   	ret    

00801da4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
  801da7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801daa:	8d 45 10             	lea    0x10(%ebp),%eax
  801dad:	83 c0 04             	add    $0x4,%eax
  801db0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801db3:	8b 45 10             	mov    0x10(%ebp),%eax
  801db6:	ff 75 f4             	pushl  -0xc(%ebp)
  801db9:	50                   	push   %eax
  801dba:	ff 75 0c             	pushl  0xc(%ebp)
  801dbd:	ff 75 08             	pushl  0x8(%ebp)
  801dc0:	e8 16 fc ff ff       	call   8019db <vprintfmt>
  801dc5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801dc8:	90                   	nop
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dd1:	8b 40 08             	mov    0x8(%eax),%eax
  801dd4:	8d 50 01             	lea    0x1(%eax),%edx
  801dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dda:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801de0:	8b 10                	mov    (%eax),%edx
  801de2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801de5:	8b 40 04             	mov    0x4(%eax),%eax
  801de8:	39 c2                	cmp    %eax,%edx
  801dea:	73 12                	jae    801dfe <sprintputch+0x33>
		*b->buf++ = ch;
  801dec:	8b 45 0c             	mov    0xc(%ebp),%eax
  801def:	8b 00                	mov    (%eax),%eax
  801df1:	8d 48 01             	lea    0x1(%eax),%ecx
  801df4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df7:	89 0a                	mov    %ecx,(%edx)
  801df9:	8b 55 08             	mov    0x8(%ebp),%edx
  801dfc:	88 10                	mov    %dl,(%eax)
}
  801dfe:	90                   	nop
  801dff:	5d                   	pop    %ebp
  801e00:	c3                   	ret    

00801e01 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
  801e04:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801e07:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e10:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e13:	8b 45 08             	mov    0x8(%ebp),%eax
  801e16:	01 d0                	add    %edx,%eax
  801e18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e22:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e26:	74 06                	je     801e2e <vsnprintf+0x2d>
  801e28:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e2c:	7f 07                	jg     801e35 <vsnprintf+0x34>
		return -E_INVAL;
  801e2e:	b8 03 00 00 00       	mov    $0x3,%eax
  801e33:	eb 20                	jmp    801e55 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e35:	ff 75 14             	pushl  0x14(%ebp)
  801e38:	ff 75 10             	pushl  0x10(%ebp)
  801e3b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e3e:	50                   	push   %eax
  801e3f:	68 cb 1d 80 00       	push   $0x801dcb
  801e44:	e8 92 fb ff ff       	call   8019db <vprintfmt>
  801e49:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e4f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e55:	c9                   	leave  
  801e56:	c3                   	ret    

00801e57 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
  801e5a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e5d:	8d 45 10             	lea    0x10(%ebp),%eax
  801e60:	83 c0 04             	add    $0x4,%eax
  801e63:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e66:	8b 45 10             	mov    0x10(%ebp),%eax
  801e69:	ff 75 f4             	pushl  -0xc(%ebp)
  801e6c:	50                   	push   %eax
  801e6d:	ff 75 0c             	pushl  0xc(%ebp)
  801e70:	ff 75 08             	pushl  0x8(%ebp)
  801e73:	e8 89 ff ff ff       	call   801e01 <vsnprintf>
  801e78:	83 c4 10             	add    $0x10,%esp
  801e7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801e7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e81:	c9                   	leave  
  801e82:	c3                   	ret    

00801e83 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801e83:	55                   	push   %ebp
  801e84:	89 e5                	mov    %esp,%ebp
  801e86:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801e89:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e90:	eb 06                	jmp    801e98 <strlen+0x15>
		n++;
  801e92:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801e95:	ff 45 08             	incl   0x8(%ebp)
  801e98:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9b:	8a 00                	mov    (%eax),%al
  801e9d:	84 c0                	test   %al,%al
  801e9f:	75 f1                	jne    801e92 <strlen+0xf>
		n++;
	return n;
  801ea1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
  801ea9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801eac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801eb3:	eb 09                	jmp    801ebe <strnlen+0x18>
		n++;
  801eb5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801eb8:	ff 45 08             	incl   0x8(%ebp)
  801ebb:	ff 4d 0c             	decl   0xc(%ebp)
  801ebe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ec2:	74 09                	je     801ecd <strnlen+0x27>
  801ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec7:	8a 00                	mov    (%eax),%al
  801ec9:	84 c0                	test   %al,%al
  801ecb:	75 e8                	jne    801eb5 <strnlen+0xf>
		n++;
	return n;
  801ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
  801ed5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801ede:	90                   	nop
  801edf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee2:	8d 50 01             	lea    0x1(%eax),%edx
  801ee5:	89 55 08             	mov    %edx,0x8(%ebp)
  801ee8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eeb:	8d 4a 01             	lea    0x1(%edx),%ecx
  801eee:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801ef1:	8a 12                	mov    (%edx),%dl
  801ef3:	88 10                	mov    %dl,(%eax)
  801ef5:	8a 00                	mov    (%eax),%al
  801ef7:	84 c0                	test   %al,%al
  801ef9:	75 e4                	jne    801edf <strcpy+0xd>
		/* do nothing */;
	return ret;
  801efb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801efe:	c9                   	leave  
  801eff:	c3                   	ret    

00801f00 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801f00:	55                   	push   %ebp
  801f01:	89 e5                	mov    %esp,%ebp
  801f03:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801f06:	8b 45 08             	mov    0x8(%ebp),%eax
  801f09:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801f0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f13:	eb 1f                	jmp    801f34 <strncpy+0x34>
		*dst++ = *src;
  801f15:	8b 45 08             	mov    0x8(%ebp),%eax
  801f18:	8d 50 01             	lea    0x1(%eax),%edx
  801f1b:	89 55 08             	mov    %edx,0x8(%ebp)
  801f1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f21:	8a 12                	mov    (%edx),%dl
  801f23:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f25:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f28:	8a 00                	mov    (%eax),%al
  801f2a:	84 c0                	test   %al,%al
  801f2c:	74 03                	je     801f31 <strncpy+0x31>
			src++;
  801f2e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f31:	ff 45 fc             	incl   -0x4(%ebp)
  801f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f37:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f3a:	72 d9                	jb     801f15 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f3f:	c9                   	leave  
  801f40:	c3                   	ret    

00801f41 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f41:	55                   	push   %ebp
  801f42:	89 e5                	mov    %esp,%ebp
  801f44:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f47:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f51:	74 30                	je     801f83 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f53:	eb 16                	jmp    801f6b <strlcpy+0x2a>
			*dst++ = *src++;
  801f55:	8b 45 08             	mov    0x8(%ebp),%eax
  801f58:	8d 50 01             	lea    0x1(%eax),%edx
  801f5b:	89 55 08             	mov    %edx,0x8(%ebp)
  801f5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f61:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f64:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f67:	8a 12                	mov    (%edx),%dl
  801f69:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801f6b:	ff 4d 10             	decl   0x10(%ebp)
  801f6e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f72:	74 09                	je     801f7d <strlcpy+0x3c>
  801f74:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f77:	8a 00                	mov    (%eax),%al
  801f79:	84 c0                	test   %al,%al
  801f7b:	75 d8                	jne    801f55 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f80:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801f83:	8b 55 08             	mov    0x8(%ebp),%edx
  801f86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f89:	29 c2                	sub    %eax,%edx
  801f8b:	89 d0                	mov    %edx,%eax
}
  801f8d:	c9                   	leave  
  801f8e:	c3                   	ret    

00801f8f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801f92:	eb 06                	jmp    801f9a <strcmp+0xb>
		p++, q++;
  801f94:	ff 45 08             	incl   0x8(%ebp)
  801f97:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9d:	8a 00                	mov    (%eax),%al
  801f9f:	84 c0                	test   %al,%al
  801fa1:	74 0e                	je     801fb1 <strcmp+0x22>
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	8a 10                	mov    (%eax),%dl
  801fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fab:	8a 00                	mov    (%eax),%al
  801fad:	38 c2                	cmp    %al,%dl
  801faf:	74 e3                	je     801f94 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb4:	8a 00                	mov    (%eax),%al
  801fb6:	0f b6 d0             	movzbl %al,%edx
  801fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fbc:	8a 00                	mov    (%eax),%al
  801fbe:	0f b6 c0             	movzbl %al,%eax
  801fc1:	29 c2                	sub    %eax,%edx
  801fc3:	89 d0                	mov    %edx,%eax
}
  801fc5:	5d                   	pop    %ebp
  801fc6:	c3                   	ret    

00801fc7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801fc7:	55                   	push   %ebp
  801fc8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801fca:	eb 09                	jmp    801fd5 <strncmp+0xe>
		n--, p++, q++;
  801fcc:	ff 4d 10             	decl   0x10(%ebp)
  801fcf:	ff 45 08             	incl   0x8(%ebp)
  801fd2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fd9:	74 17                	je     801ff2 <strncmp+0x2b>
  801fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fde:	8a 00                	mov    (%eax),%al
  801fe0:	84 c0                	test   %al,%al
  801fe2:	74 0e                	je     801ff2 <strncmp+0x2b>
  801fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe7:	8a 10                	mov    (%eax),%dl
  801fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fec:	8a 00                	mov    (%eax),%al
  801fee:	38 c2                	cmp    %al,%dl
  801ff0:	74 da                	je     801fcc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801ff2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ff6:	75 07                	jne    801fff <strncmp+0x38>
		return 0;
  801ff8:	b8 00 00 00 00       	mov    $0x0,%eax
  801ffd:	eb 14                	jmp    802013 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801fff:	8b 45 08             	mov    0x8(%ebp),%eax
  802002:	8a 00                	mov    (%eax),%al
  802004:	0f b6 d0             	movzbl %al,%edx
  802007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80200a:	8a 00                	mov    (%eax),%al
  80200c:	0f b6 c0             	movzbl %al,%eax
  80200f:	29 c2                	sub    %eax,%edx
  802011:	89 d0                	mov    %edx,%eax
}
  802013:	5d                   	pop    %ebp
  802014:	c3                   	ret    

00802015 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 04             	sub    $0x4,%esp
  80201b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80201e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802021:	eb 12                	jmp    802035 <strchr+0x20>
		if (*s == c)
  802023:	8b 45 08             	mov    0x8(%ebp),%eax
  802026:	8a 00                	mov    (%eax),%al
  802028:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80202b:	75 05                	jne    802032 <strchr+0x1d>
			return (char *) s;
  80202d:	8b 45 08             	mov    0x8(%ebp),%eax
  802030:	eb 11                	jmp    802043 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802032:	ff 45 08             	incl   0x8(%ebp)
  802035:	8b 45 08             	mov    0x8(%ebp),%eax
  802038:	8a 00                	mov    (%eax),%al
  80203a:	84 c0                	test   %al,%al
  80203c:	75 e5                	jne    802023 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80203e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802043:	c9                   	leave  
  802044:	c3                   	ret    

00802045 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802045:	55                   	push   %ebp
  802046:	89 e5                	mov    %esp,%ebp
  802048:	83 ec 04             	sub    $0x4,%esp
  80204b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80204e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802051:	eb 0d                	jmp    802060 <strfind+0x1b>
		if (*s == c)
  802053:	8b 45 08             	mov    0x8(%ebp),%eax
  802056:	8a 00                	mov    (%eax),%al
  802058:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80205b:	74 0e                	je     80206b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80205d:	ff 45 08             	incl   0x8(%ebp)
  802060:	8b 45 08             	mov    0x8(%ebp),%eax
  802063:	8a 00                	mov    (%eax),%al
  802065:	84 c0                	test   %al,%al
  802067:	75 ea                	jne    802053 <strfind+0xe>
  802069:	eb 01                	jmp    80206c <strfind+0x27>
		if (*s == c)
			break;
  80206b:	90                   	nop
	return (char *) s;
  80206c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
  802074:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  802077:	8b 45 08             	mov    0x8(%ebp),%eax
  80207a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80207d:	8b 45 10             	mov    0x10(%ebp),%eax
  802080:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802083:	eb 0e                	jmp    802093 <memset+0x22>
		*p++ = c;
  802085:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802088:	8d 50 01             	lea    0x1(%eax),%edx
  80208b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80208e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802091:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802093:	ff 4d f8             	decl   -0x8(%ebp)
  802096:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80209a:	79 e9                	jns    802085 <memset+0x14>
		*p++ = c;

	return v;
  80209c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80209f:	c9                   	leave  
  8020a0:	c3                   	ret    

008020a1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
  8020a4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8020a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8020b3:	eb 16                	jmp    8020cb <memcpy+0x2a>
		*d++ = *s++;
  8020b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020b8:	8d 50 01             	lea    0x1(%eax),%edx
  8020bb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8020be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020c1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020c4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020c7:	8a 12                	mov    (%edx),%dl
  8020c9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8020cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8020ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8020d4:	85 c0                	test   %eax,%eax
  8020d6:	75 dd                	jne    8020b5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8020d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
  8020e0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8020e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8020ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8020f5:	73 50                	jae    802147 <memmove+0x6a>
  8020f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8020fd:	01 d0                	add    %edx,%eax
  8020ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802102:	76 43                	jbe    802147 <memmove+0x6a>
		s += n;
  802104:	8b 45 10             	mov    0x10(%ebp),%eax
  802107:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80210a:	8b 45 10             	mov    0x10(%ebp),%eax
  80210d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802110:	eb 10                	jmp    802122 <memmove+0x45>
			*--d = *--s;
  802112:	ff 4d f8             	decl   -0x8(%ebp)
  802115:	ff 4d fc             	decl   -0x4(%ebp)
  802118:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80211b:	8a 10                	mov    (%eax),%dl
  80211d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802120:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802122:	8b 45 10             	mov    0x10(%ebp),%eax
  802125:	8d 50 ff             	lea    -0x1(%eax),%edx
  802128:	89 55 10             	mov    %edx,0x10(%ebp)
  80212b:	85 c0                	test   %eax,%eax
  80212d:	75 e3                	jne    802112 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80212f:	eb 23                	jmp    802154 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802131:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802134:	8d 50 01             	lea    0x1(%eax),%edx
  802137:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80213a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80213d:	8d 4a 01             	lea    0x1(%edx),%ecx
  802140:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802143:	8a 12                	mov    (%edx),%dl
  802145:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  802147:	8b 45 10             	mov    0x10(%ebp),%eax
  80214a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80214d:	89 55 10             	mov    %edx,0x10(%ebp)
  802150:	85 c0                	test   %eax,%eax
  802152:	75 dd                	jne    802131 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802154:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802157:	c9                   	leave  
  802158:	c3                   	ret    

00802159 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  802159:	55                   	push   %ebp
  80215a:	89 e5                	mov    %esp,%ebp
  80215c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80215f:	8b 45 08             	mov    0x8(%ebp),%eax
  802162:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802165:	8b 45 0c             	mov    0xc(%ebp),%eax
  802168:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80216b:	eb 2a                	jmp    802197 <memcmp+0x3e>
		if (*s1 != *s2)
  80216d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802170:	8a 10                	mov    (%eax),%dl
  802172:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802175:	8a 00                	mov    (%eax),%al
  802177:	38 c2                	cmp    %al,%dl
  802179:	74 16                	je     802191 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80217b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80217e:	8a 00                	mov    (%eax),%al
  802180:	0f b6 d0             	movzbl %al,%edx
  802183:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802186:	8a 00                	mov    (%eax),%al
  802188:	0f b6 c0             	movzbl %al,%eax
  80218b:	29 c2                	sub    %eax,%edx
  80218d:	89 d0                	mov    %edx,%eax
  80218f:	eb 18                	jmp    8021a9 <memcmp+0x50>
		s1++, s2++;
  802191:	ff 45 fc             	incl   -0x4(%ebp)
  802194:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802197:	8b 45 10             	mov    0x10(%ebp),%eax
  80219a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80219d:	89 55 10             	mov    %edx,0x10(%ebp)
  8021a0:	85 c0                	test   %eax,%eax
  8021a2:	75 c9                	jne    80216d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8021a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a9:	c9                   	leave  
  8021aa:	c3                   	ret    

008021ab <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8021ab:	55                   	push   %ebp
  8021ac:	89 e5                	mov    %esp,%ebp
  8021ae:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8021b1:	8b 55 08             	mov    0x8(%ebp),%edx
  8021b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8021b7:	01 d0                	add    %edx,%eax
  8021b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8021bc:	eb 15                	jmp    8021d3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8021be:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c1:	8a 00                	mov    (%eax),%al
  8021c3:	0f b6 d0             	movzbl %al,%edx
  8021c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021c9:	0f b6 c0             	movzbl %al,%eax
  8021cc:	39 c2                	cmp    %eax,%edx
  8021ce:	74 0d                	je     8021dd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8021d0:	ff 45 08             	incl   0x8(%ebp)
  8021d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8021d9:	72 e3                	jb     8021be <memfind+0x13>
  8021db:	eb 01                	jmp    8021de <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8021dd:	90                   	nop
	return (void *) s;
  8021de:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8021e1:	c9                   	leave  
  8021e2:	c3                   	ret    

008021e3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8021e3:	55                   	push   %ebp
  8021e4:	89 e5                	mov    %esp,%ebp
  8021e6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8021e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8021f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021f7:	eb 03                	jmp    8021fc <strtol+0x19>
		s++;
  8021f9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ff:	8a 00                	mov    (%eax),%al
  802201:	3c 20                	cmp    $0x20,%al
  802203:	74 f4                	je     8021f9 <strtol+0x16>
  802205:	8b 45 08             	mov    0x8(%ebp),%eax
  802208:	8a 00                	mov    (%eax),%al
  80220a:	3c 09                	cmp    $0x9,%al
  80220c:	74 eb                	je     8021f9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80220e:	8b 45 08             	mov    0x8(%ebp),%eax
  802211:	8a 00                	mov    (%eax),%al
  802213:	3c 2b                	cmp    $0x2b,%al
  802215:	75 05                	jne    80221c <strtol+0x39>
		s++;
  802217:	ff 45 08             	incl   0x8(%ebp)
  80221a:	eb 13                	jmp    80222f <strtol+0x4c>
	else if (*s == '-')
  80221c:	8b 45 08             	mov    0x8(%ebp),%eax
  80221f:	8a 00                	mov    (%eax),%al
  802221:	3c 2d                	cmp    $0x2d,%al
  802223:	75 0a                	jne    80222f <strtol+0x4c>
		s++, neg = 1;
  802225:	ff 45 08             	incl   0x8(%ebp)
  802228:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80222f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802233:	74 06                	je     80223b <strtol+0x58>
  802235:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  802239:	75 20                	jne    80225b <strtol+0x78>
  80223b:	8b 45 08             	mov    0x8(%ebp),%eax
  80223e:	8a 00                	mov    (%eax),%al
  802240:	3c 30                	cmp    $0x30,%al
  802242:	75 17                	jne    80225b <strtol+0x78>
  802244:	8b 45 08             	mov    0x8(%ebp),%eax
  802247:	40                   	inc    %eax
  802248:	8a 00                	mov    (%eax),%al
  80224a:	3c 78                	cmp    $0x78,%al
  80224c:	75 0d                	jne    80225b <strtol+0x78>
		s += 2, base = 16;
  80224e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802252:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  802259:	eb 28                	jmp    802283 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80225b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80225f:	75 15                	jne    802276 <strtol+0x93>
  802261:	8b 45 08             	mov    0x8(%ebp),%eax
  802264:	8a 00                	mov    (%eax),%al
  802266:	3c 30                	cmp    $0x30,%al
  802268:	75 0c                	jne    802276 <strtol+0x93>
		s++, base = 8;
  80226a:	ff 45 08             	incl   0x8(%ebp)
  80226d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802274:	eb 0d                	jmp    802283 <strtol+0xa0>
	else if (base == 0)
  802276:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80227a:	75 07                	jne    802283 <strtol+0xa0>
		base = 10;
  80227c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802283:	8b 45 08             	mov    0x8(%ebp),%eax
  802286:	8a 00                	mov    (%eax),%al
  802288:	3c 2f                	cmp    $0x2f,%al
  80228a:	7e 19                	jle    8022a5 <strtol+0xc2>
  80228c:	8b 45 08             	mov    0x8(%ebp),%eax
  80228f:	8a 00                	mov    (%eax),%al
  802291:	3c 39                	cmp    $0x39,%al
  802293:	7f 10                	jg     8022a5 <strtol+0xc2>
			dig = *s - '0';
  802295:	8b 45 08             	mov    0x8(%ebp),%eax
  802298:	8a 00                	mov    (%eax),%al
  80229a:	0f be c0             	movsbl %al,%eax
  80229d:	83 e8 30             	sub    $0x30,%eax
  8022a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022a3:	eb 42                	jmp    8022e7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8022a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a8:	8a 00                	mov    (%eax),%al
  8022aa:	3c 60                	cmp    $0x60,%al
  8022ac:	7e 19                	jle    8022c7 <strtol+0xe4>
  8022ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b1:	8a 00                	mov    (%eax),%al
  8022b3:	3c 7a                	cmp    $0x7a,%al
  8022b5:	7f 10                	jg     8022c7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8022b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ba:	8a 00                	mov    (%eax),%al
  8022bc:	0f be c0             	movsbl %al,%eax
  8022bf:	83 e8 57             	sub    $0x57,%eax
  8022c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022c5:	eb 20                	jmp    8022e7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ca:	8a 00                	mov    (%eax),%al
  8022cc:	3c 40                	cmp    $0x40,%al
  8022ce:	7e 39                	jle    802309 <strtol+0x126>
  8022d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d3:	8a 00                	mov    (%eax),%al
  8022d5:	3c 5a                	cmp    $0x5a,%al
  8022d7:	7f 30                	jg     802309 <strtol+0x126>
			dig = *s - 'A' + 10;
  8022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022dc:	8a 00                	mov    (%eax),%al
  8022de:	0f be c0             	movsbl %al,%eax
  8022e1:	83 e8 37             	sub    $0x37,%eax
  8022e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8022e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022ea:	3b 45 10             	cmp    0x10(%ebp),%eax
  8022ed:	7d 19                	jge    802308 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8022ef:	ff 45 08             	incl   0x8(%ebp)
  8022f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022f5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8022f9:	89 c2                	mov    %eax,%edx
  8022fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022fe:	01 d0                	add    %edx,%eax
  802300:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802303:	e9 7b ff ff ff       	jmp    802283 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  802308:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802309:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80230d:	74 08                	je     802317 <strtol+0x134>
		*endptr = (char *) s;
  80230f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802312:	8b 55 08             	mov    0x8(%ebp),%edx
  802315:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  802317:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80231b:	74 07                	je     802324 <strtol+0x141>
  80231d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802320:	f7 d8                	neg    %eax
  802322:	eb 03                	jmp    802327 <strtol+0x144>
  802324:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802327:	c9                   	leave  
  802328:	c3                   	ret    

00802329 <ltostr>:

void
ltostr(long value, char *str)
{
  802329:	55                   	push   %ebp
  80232a:	89 e5                	mov    %esp,%ebp
  80232c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80232f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802336:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80233d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802341:	79 13                	jns    802356 <ltostr+0x2d>
	{
		neg = 1;
  802343:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80234a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80234d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802350:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802353:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802356:	8b 45 08             	mov    0x8(%ebp),%eax
  802359:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80235e:	99                   	cltd   
  80235f:	f7 f9                	idiv   %ecx
  802361:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802364:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802367:	8d 50 01             	lea    0x1(%eax),%edx
  80236a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80236d:	89 c2                	mov    %eax,%edx
  80236f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802372:	01 d0                	add    %edx,%eax
  802374:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802377:	83 c2 30             	add    $0x30,%edx
  80237a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80237c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80237f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802384:	f7 e9                	imul   %ecx
  802386:	c1 fa 02             	sar    $0x2,%edx
  802389:	89 c8                	mov    %ecx,%eax
  80238b:	c1 f8 1f             	sar    $0x1f,%eax
  80238e:	29 c2                	sub    %eax,%edx
  802390:	89 d0                	mov    %edx,%eax
  802392:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802395:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802398:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80239d:	f7 e9                	imul   %ecx
  80239f:	c1 fa 02             	sar    $0x2,%edx
  8023a2:	89 c8                	mov    %ecx,%eax
  8023a4:	c1 f8 1f             	sar    $0x1f,%eax
  8023a7:	29 c2                	sub    %eax,%edx
  8023a9:	89 d0                	mov    %edx,%eax
  8023ab:	c1 e0 02             	shl    $0x2,%eax
  8023ae:	01 d0                	add    %edx,%eax
  8023b0:	01 c0                	add    %eax,%eax
  8023b2:	29 c1                	sub    %eax,%ecx
  8023b4:	89 ca                	mov    %ecx,%edx
  8023b6:	85 d2                	test   %edx,%edx
  8023b8:	75 9c                	jne    802356 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8023ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8023c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023c4:	48                   	dec    %eax
  8023c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8023cc:	74 3d                	je     80240b <ltostr+0xe2>
		start = 1 ;
  8023ce:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8023d5:	eb 34                	jmp    80240b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8023d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023dd:	01 d0                	add    %edx,%eax
  8023df:	8a 00                	mov    (%eax),%al
  8023e1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8023e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023ea:	01 c2                	add    %eax,%edx
  8023ec:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8023ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023f2:	01 c8                	add    %ecx,%eax
  8023f4:	8a 00                	mov    (%eax),%al
  8023f6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8023f8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8023fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023fe:	01 c2                	add    %eax,%edx
  802400:	8a 45 eb             	mov    -0x15(%ebp),%al
  802403:	88 02                	mov    %al,(%edx)
		start++ ;
  802405:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  802408:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80240b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80240e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802411:	7c c4                	jl     8023d7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802413:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802416:	8b 45 0c             	mov    0xc(%ebp),%eax
  802419:	01 d0                	add    %edx,%eax
  80241b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80241e:	90                   	nop
  80241f:	c9                   	leave  
  802420:	c3                   	ret    

00802421 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802421:	55                   	push   %ebp
  802422:	89 e5                	mov    %esp,%ebp
  802424:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  802427:	ff 75 08             	pushl  0x8(%ebp)
  80242a:	e8 54 fa ff ff       	call   801e83 <strlen>
  80242f:	83 c4 04             	add    $0x4,%esp
  802432:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802435:	ff 75 0c             	pushl  0xc(%ebp)
  802438:	e8 46 fa ff ff       	call   801e83 <strlen>
  80243d:	83 c4 04             	add    $0x4,%esp
  802440:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802443:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80244a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802451:	eb 17                	jmp    80246a <strcconcat+0x49>
		final[s] = str1[s] ;
  802453:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802456:	8b 45 10             	mov    0x10(%ebp),%eax
  802459:	01 c2                	add    %eax,%edx
  80245b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80245e:	8b 45 08             	mov    0x8(%ebp),%eax
  802461:	01 c8                	add    %ecx,%eax
  802463:	8a 00                	mov    (%eax),%al
  802465:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802467:	ff 45 fc             	incl   -0x4(%ebp)
  80246a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80246d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802470:	7c e1                	jl     802453 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802472:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  802479:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802480:	eb 1f                	jmp    8024a1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802485:	8d 50 01             	lea    0x1(%eax),%edx
  802488:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80248b:	89 c2                	mov    %eax,%edx
  80248d:	8b 45 10             	mov    0x10(%ebp),%eax
  802490:	01 c2                	add    %eax,%edx
  802492:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802495:	8b 45 0c             	mov    0xc(%ebp),%eax
  802498:	01 c8                	add    %ecx,%eax
  80249a:	8a 00                	mov    (%eax),%al
  80249c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80249e:	ff 45 f8             	incl   -0x8(%ebp)
  8024a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024a4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8024a7:	7c d9                	jl     802482 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8024a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8024af:	01 d0                	add    %edx,%eax
  8024b1:	c6 00 00             	movb   $0x0,(%eax)
}
  8024b4:	90                   	nop
  8024b5:	c9                   	leave  
  8024b6:	c3                   	ret    

008024b7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8024b7:	55                   	push   %ebp
  8024b8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8024ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8024bd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8024c6:	8b 00                	mov    (%eax),%eax
  8024c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8024cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8024d2:	01 d0                	add    %edx,%eax
  8024d4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024da:	eb 0c                	jmp    8024e8 <strsplit+0x31>
			*string++ = 0;
  8024dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8024df:	8d 50 01             	lea    0x1(%eax),%edx
  8024e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8024e5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024eb:	8a 00                	mov    (%eax),%al
  8024ed:	84 c0                	test   %al,%al
  8024ef:	74 18                	je     802509 <strsplit+0x52>
  8024f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f4:	8a 00                	mov    (%eax),%al
  8024f6:	0f be c0             	movsbl %al,%eax
  8024f9:	50                   	push   %eax
  8024fa:	ff 75 0c             	pushl  0xc(%ebp)
  8024fd:	e8 13 fb ff ff       	call   802015 <strchr>
  802502:	83 c4 08             	add    $0x8,%esp
  802505:	85 c0                	test   %eax,%eax
  802507:	75 d3                	jne    8024dc <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  802509:	8b 45 08             	mov    0x8(%ebp),%eax
  80250c:	8a 00                	mov    (%eax),%al
  80250e:	84 c0                	test   %al,%al
  802510:	74 5a                	je     80256c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802512:	8b 45 14             	mov    0x14(%ebp),%eax
  802515:	8b 00                	mov    (%eax),%eax
  802517:	83 f8 0f             	cmp    $0xf,%eax
  80251a:	75 07                	jne    802523 <strsplit+0x6c>
		{
			return 0;
  80251c:	b8 00 00 00 00       	mov    $0x0,%eax
  802521:	eb 66                	jmp    802589 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802523:	8b 45 14             	mov    0x14(%ebp),%eax
  802526:	8b 00                	mov    (%eax),%eax
  802528:	8d 48 01             	lea    0x1(%eax),%ecx
  80252b:	8b 55 14             	mov    0x14(%ebp),%edx
  80252e:	89 0a                	mov    %ecx,(%edx)
  802530:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802537:	8b 45 10             	mov    0x10(%ebp),%eax
  80253a:	01 c2                	add    %eax,%edx
  80253c:	8b 45 08             	mov    0x8(%ebp),%eax
  80253f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802541:	eb 03                	jmp    802546 <strsplit+0x8f>
			string++;
  802543:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802546:	8b 45 08             	mov    0x8(%ebp),%eax
  802549:	8a 00                	mov    (%eax),%al
  80254b:	84 c0                	test   %al,%al
  80254d:	74 8b                	je     8024da <strsplit+0x23>
  80254f:	8b 45 08             	mov    0x8(%ebp),%eax
  802552:	8a 00                	mov    (%eax),%al
  802554:	0f be c0             	movsbl %al,%eax
  802557:	50                   	push   %eax
  802558:	ff 75 0c             	pushl  0xc(%ebp)
  80255b:	e8 b5 fa ff ff       	call   802015 <strchr>
  802560:	83 c4 08             	add    $0x8,%esp
  802563:	85 c0                	test   %eax,%eax
  802565:	74 dc                	je     802543 <strsplit+0x8c>
			string++;
	}
  802567:	e9 6e ff ff ff       	jmp    8024da <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80256c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80256d:	8b 45 14             	mov    0x14(%ebp),%eax
  802570:	8b 00                	mov    (%eax),%eax
  802572:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802579:	8b 45 10             	mov    0x10(%ebp),%eax
  80257c:	01 d0                	add    %edx,%eax
  80257e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802584:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802589:	c9                   	leave  
  80258a:	c3                   	ret    

0080258b <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  80258b:	55                   	push   %ebp
  80258c:	89 e5                	mov    %esp,%ebp
  80258e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  802591:	83 ec 04             	sub    $0x4,%esp
  802594:	68 70 36 80 00       	push   $0x803670
  802599:	6a 19                	push   $0x19
  80259b:	68 95 36 80 00       	push   $0x803695
  8025a0:	e8 a8 ef ff ff       	call   80154d <_panic>

008025a5 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8025a5:	55                   	push   %ebp
  8025a6:	89 e5                	mov    %esp,%ebp
  8025a8:	83 ec 18             	sub    $0x18,%esp
  8025ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8025ae:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8025b1:	83 ec 04             	sub    $0x4,%esp
  8025b4:	68 a4 36 80 00       	push   $0x8036a4
  8025b9:	6a 30                	push   $0x30
  8025bb:	68 95 36 80 00       	push   $0x803695
  8025c0:	e8 88 ef ff ff       	call   80154d <_panic>

008025c5 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8025c5:	55                   	push   %ebp
  8025c6:	89 e5                	mov    %esp,%ebp
  8025c8:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8025cb:	83 ec 04             	sub    $0x4,%esp
  8025ce:	68 c3 36 80 00       	push   $0x8036c3
  8025d3:	6a 36                	push   $0x36
  8025d5:	68 95 36 80 00       	push   $0x803695
  8025da:	e8 6e ef ff ff       	call   80154d <_panic>

008025df <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8025df:	55                   	push   %ebp
  8025e0:	89 e5                	mov    %esp,%ebp
  8025e2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8025e5:	83 ec 04             	sub    $0x4,%esp
  8025e8:	68 e0 36 80 00       	push   $0x8036e0
  8025ed:	6a 48                	push   $0x48
  8025ef:	68 95 36 80 00       	push   $0x803695
  8025f4:	e8 54 ef ff ff       	call   80154d <_panic>

008025f9 <sfree>:

}


void sfree(void* virtual_address)
{
  8025f9:	55                   	push   %ebp
  8025fa:	89 e5                	mov    %esp,%ebp
  8025fc:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8025ff:	83 ec 04             	sub    $0x4,%esp
  802602:	68 03 37 80 00       	push   $0x803703
  802607:	6a 53                	push   $0x53
  802609:	68 95 36 80 00       	push   $0x803695
  80260e:	e8 3a ef ff ff       	call   80154d <_panic>

00802613 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802613:	55                   	push   %ebp
  802614:	89 e5                	mov    %esp,%ebp
  802616:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  802619:	83 ec 04             	sub    $0x4,%esp
  80261c:	68 20 37 80 00       	push   $0x803720
  802621:	6a 6c                	push   $0x6c
  802623:	68 95 36 80 00       	push   $0x803695
  802628:	e8 20 ef ff ff       	call   80154d <_panic>

0080262d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80262d:	55                   	push   %ebp
  80262e:	89 e5                	mov    %esp,%ebp
  802630:	57                   	push   %edi
  802631:	56                   	push   %esi
  802632:	53                   	push   %ebx
  802633:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802636:	8b 45 08             	mov    0x8(%ebp),%eax
  802639:	8b 55 0c             	mov    0xc(%ebp),%edx
  80263c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80263f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802642:	8b 7d 18             	mov    0x18(%ebp),%edi
  802645:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802648:	cd 30                	int    $0x30
  80264a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80264d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802650:	83 c4 10             	add    $0x10,%esp
  802653:	5b                   	pop    %ebx
  802654:	5e                   	pop    %esi
  802655:	5f                   	pop    %edi
  802656:	5d                   	pop    %ebp
  802657:	c3                   	ret    

00802658 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802658:	55                   	push   %ebp
  802659:	89 e5                	mov    %esp,%ebp
  80265b:	83 ec 04             	sub    $0x4,%esp
  80265e:	8b 45 10             	mov    0x10(%ebp),%eax
  802661:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802664:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802668:	8b 45 08             	mov    0x8(%ebp),%eax
  80266b:	6a 00                	push   $0x0
  80266d:	6a 00                	push   $0x0
  80266f:	52                   	push   %edx
  802670:	ff 75 0c             	pushl  0xc(%ebp)
  802673:	50                   	push   %eax
  802674:	6a 00                	push   $0x0
  802676:	e8 b2 ff ff ff       	call   80262d <syscall>
  80267b:	83 c4 18             	add    $0x18,%esp
}
  80267e:	90                   	nop
  80267f:	c9                   	leave  
  802680:	c3                   	ret    

00802681 <sys_cgetc>:

int
sys_cgetc(void)
{
  802681:	55                   	push   %ebp
  802682:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802684:	6a 00                	push   $0x0
  802686:	6a 00                	push   $0x0
  802688:	6a 00                	push   $0x0
  80268a:	6a 00                	push   $0x0
  80268c:	6a 00                	push   $0x0
  80268e:	6a 01                	push   $0x1
  802690:	e8 98 ff ff ff       	call   80262d <syscall>
  802695:	83 c4 18             	add    $0x18,%esp
}
  802698:	c9                   	leave  
  802699:	c3                   	ret    

0080269a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80269a:	55                   	push   %ebp
  80269b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80269d:	8b 45 08             	mov    0x8(%ebp),%eax
  8026a0:	6a 00                	push   $0x0
  8026a2:	6a 00                	push   $0x0
  8026a4:	6a 00                	push   $0x0
  8026a6:	6a 00                	push   $0x0
  8026a8:	50                   	push   %eax
  8026a9:	6a 05                	push   $0x5
  8026ab:	e8 7d ff ff ff       	call   80262d <syscall>
  8026b0:	83 c4 18             	add    $0x18,%esp
}
  8026b3:	c9                   	leave  
  8026b4:	c3                   	ret    

008026b5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8026b5:	55                   	push   %ebp
  8026b6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8026b8:	6a 00                	push   $0x0
  8026ba:	6a 00                	push   $0x0
  8026bc:	6a 00                	push   $0x0
  8026be:	6a 00                	push   $0x0
  8026c0:	6a 00                	push   $0x0
  8026c2:	6a 02                	push   $0x2
  8026c4:	e8 64 ff ff ff       	call   80262d <syscall>
  8026c9:	83 c4 18             	add    $0x18,%esp
}
  8026cc:	c9                   	leave  
  8026cd:	c3                   	ret    

008026ce <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8026ce:	55                   	push   %ebp
  8026cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8026d1:	6a 00                	push   $0x0
  8026d3:	6a 00                	push   $0x0
  8026d5:	6a 00                	push   $0x0
  8026d7:	6a 00                	push   $0x0
  8026d9:	6a 00                	push   $0x0
  8026db:	6a 03                	push   $0x3
  8026dd:	e8 4b ff ff ff       	call   80262d <syscall>
  8026e2:	83 c4 18             	add    $0x18,%esp
}
  8026e5:	c9                   	leave  
  8026e6:	c3                   	ret    

008026e7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8026e7:	55                   	push   %ebp
  8026e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8026ea:	6a 00                	push   $0x0
  8026ec:	6a 00                	push   $0x0
  8026ee:	6a 00                	push   $0x0
  8026f0:	6a 00                	push   $0x0
  8026f2:	6a 00                	push   $0x0
  8026f4:	6a 04                	push   $0x4
  8026f6:	e8 32 ff ff ff       	call   80262d <syscall>
  8026fb:	83 c4 18             	add    $0x18,%esp
}
  8026fe:	c9                   	leave  
  8026ff:	c3                   	ret    

00802700 <sys_env_exit>:


void sys_env_exit(void)
{
  802700:	55                   	push   %ebp
  802701:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802703:	6a 00                	push   $0x0
  802705:	6a 00                	push   $0x0
  802707:	6a 00                	push   $0x0
  802709:	6a 00                	push   $0x0
  80270b:	6a 00                	push   $0x0
  80270d:	6a 06                	push   $0x6
  80270f:	e8 19 ff ff ff       	call   80262d <syscall>
  802714:	83 c4 18             	add    $0x18,%esp
}
  802717:	90                   	nop
  802718:	c9                   	leave  
  802719:	c3                   	ret    

0080271a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80271a:	55                   	push   %ebp
  80271b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80271d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802720:	8b 45 08             	mov    0x8(%ebp),%eax
  802723:	6a 00                	push   $0x0
  802725:	6a 00                	push   $0x0
  802727:	6a 00                	push   $0x0
  802729:	52                   	push   %edx
  80272a:	50                   	push   %eax
  80272b:	6a 07                	push   $0x7
  80272d:	e8 fb fe ff ff       	call   80262d <syscall>
  802732:	83 c4 18             	add    $0x18,%esp
}
  802735:	c9                   	leave  
  802736:	c3                   	ret    

00802737 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802737:	55                   	push   %ebp
  802738:	89 e5                	mov    %esp,%ebp
  80273a:	56                   	push   %esi
  80273b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80273c:	8b 75 18             	mov    0x18(%ebp),%esi
  80273f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802742:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802745:	8b 55 0c             	mov    0xc(%ebp),%edx
  802748:	8b 45 08             	mov    0x8(%ebp),%eax
  80274b:	56                   	push   %esi
  80274c:	53                   	push   %ebx
  80274d:	51                   	push   %ecx
  80274e:	52                   	push   %edx
  80274f:	50                   	push   %eax
  802750:	6a 08                	push   $0x8
  802752:	e8 d6 fe ff ff       	call   80262d <syscall>
  802757:	83 c4 18             	add    $0x18,%esp
}
  80275a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80275d:	5b                   	pop    %ebx
  80275e:	5e                   	pop    %esi
  80275f:	5d                   	pop    %ebp
  802760:	c3                   	ret    

00802761 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802761:	55                   	push   %ebp
  802762:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802764:	8b 55 0c             	mov    0xc(%ebp),%edx
  802767:	8b 45 08             	mov    0x8(%ebp),%eax
  80276a:	6a 00                	push   $0x0
  80276c:	6a 00                	push   $0x0
  80276e:	6a 00                	push   $0x0
  802770:	52                   	push   %edx
  802771:	50                   	push   %eax
  802772:	6a 09                	push   $0x9
  802774:	e8 b4 fe ff ff       	call   80262d <syscall>
  802779:	83 c4 18             	add    $0x18,%esp
}
  80277c:	c9                   	leave  
  80277d:	c3                   	ret    

0080277e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80277e:	55                   	push   %ebp
  80277f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802781:	6a 00                	push   $0x0
  802783:	6a 00                	push   $0x0
  802785:	6a 00                	push   $0x0
  802787:	ff 75 0c             	pushl  0xc(%ebp)
  80278a:	ff 75 08             	pushl  0x8(%ebp)
  80278d:	6a 0a                	push   $0xa
  80278f:	e8 99 fe ff ff       	call   80262d <syscall>
  802794:	83 c4 18             	add    $0x18,%esp
}
  802797:	c9                   	leave  
  802798:	c3                   	ret    

00802799 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802799:	55                   	push   %ebp
  80279a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80279c:	6a 00                	push   $0x0
  80279e:	6a 00                	push   $0x0
  8027a0:	6a 00                	push   $0x0
  8027a2:	6a 00                	push   $0x0
  8027a4:	6a 00                	push   $0x0
  8027a6:	6a 0b                	push   $0xb
  8027a8:	e8 80 fe ff ff       	call   80262d <syscall>
  8027ad:	83 c4 18             	add    $0x18,%esp
}
  8027b0:	c9                   	leave  
  8027b1:	c3                   	ret    

008027b2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8027b2:	55                   	push   %ebp
  8027b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8027b5:	6a 00                	push   $0x0
  8027b7:	6a 00                	push   $0x0
  8027b9:	6a 00                	push   $0x0
  8027bb:	6a 00                	push   $0x0
  8027bd:	6a 00                	push   $0x0
  8027bf:	6a 0c                	push   $0xc
  8027c1:	e8 67 fe ff ff       	call   80262d <syscall>
  8027c6:	83 c4 18             	add    $0x18,%esp
}
  8027c9:	c9                   	leave  
  8027ca:	c3                   	ret    

008027cb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8027cb:	55                   	push   %ebp
  8027cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8027ce:	6a 00                	push   $0x0
  8027d0:	6a 00                	push   $0x0
  8027d2:	6a 00                	push   $0x0
  8027d4:	6a 00                	push   $0x0
  8027d6:	6a 00                	push   $0x0
  8027d8:	6a 0d                	push   $0xd
  8027da:	e8 4e fe ff ff       	call   80262d <syscall>
  8027df:	83 c4 18             	add    $0x18,%esp
}
  8027e2:	c9                   	leave  
  8027e3:	c3                   	ret    

008027e4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8027e4:	55                   	push   %ebp
  8027e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8027e7:	6a 00                	push   $0x0
  8027e9:	6a 00                	push   $0x0
  8027eb:	6a 00                	push   $0x0
  8027ed:	ff 75 0c             	pushl  0xc(%ebp)
  8027f0:	ff 75 08             	pushl  0x8(%ebp)
  8027f3:	6a 11                	push   $0x11
  8027f5:	e8 33 fe ff ff       	call   80262d <syscall>
  8027fa:	83 c4 18             	add    $0x18,%esp
	return;
  8027fd:	90                   	nop
}
  8027fe:	c9                   	leave  
  8027ff:	c3                   	ret    

00802800 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802800:	55                   	push   %ebp
  802801:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802803:	6a 00                	push   $0x0
  802805:	6a 00                	push   $0x0
  802807:	6a 00                	push   $0x0
  802809:	ff 75 0c             	pushl  0xc(%ebp)
  80280c:	ff 75 08             	pushl  0x8(%ebp)
  80280f:	6a 12                	push   $0x12
  802811:	e8 17 fe ff ff       	call   80262d <syscall>
  802816:	83 c4 18             	add    $0x18,%esp
	return ;
  802819:	90                   	nop
}
  80281a:	c9                   	leave  
  80281b:	c3                   	ret    

0080281c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80281c:	55                   	push   %ebp
  80281d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80281f:	6a 00                	push   $0x0
  802821:	6a 00                	push   $0x0
  802823:	6a 00                	push   $0x0
  802825:	6a 00                	push   $0x0
  802827:	6a 00                	push   $0x0
  802829:	6a 0e                	push   $0xe
  80282b:	e8 fd fd ff ff       	call   80262d <syscall>
  802830:	83 c4 18             	add    $0x18,%esp
}
  802833:	c9                   	leave  
  802834:	c3                   	ret    

00802835 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802835:	55                   	push   %ebp
  802836:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802838:	6a 00                	push   $0x0
  80283a:	6a 00                	push   $0x0
  80283c:	6a 00                	push   $0x0
  80283e:	6a 00                	push   $0x0
  802840:	ff 75 08             	pushl  0x8(%ebp)
  802843:	6a 0f                	push   $0xf
  802845:	e8 e3 fd ff ff       	call   80262d <syscall>
  80284a:	83 c4 18             	add    $0x18,%esp
}
  80284d:	c9                   	leave  
  80284e:	c3                   	ret    

0080284f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80284f:	55                   	push   %ebp
  802850:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802852:	6a 00                	push   $0x0
  802854:	6a 00                	push   $0x0
  802856:	6a 00                	push   $0x0
  802858:	6a 00                	push   $0x0
  80285a:	6a 00                	push   $0x0
  80285c:	6a 10                	push   $0x10
  80285e:	e8 ca fd ff ff       	call   80262d <syscall>
  802863:	83 c4 18             	add    $0x18,%esp
}
  802866:	90                   	nop
  802867:	c9                   	leave  
  802868:	c3                   	ret    

00802869 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802869:	55                   	push   %ebp
  80286a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80286c:	6a 00                	push   $0x0
  80286e:	6a 00                	push   $0x0
  802870:	6a 00                	push   $0x0
  802872:	6a 00                	push   $0x0
  802874:	6a 00                	push   $0x0
  802876:	6a 14                	push   $0x14
  802878:	e8 b0 fd ff ff       	call   80262d <syscall>
  80287d:	83 c4 18             	add    $0x18,%esp
}
  802880:	90                   	nop
  802881:	c9                   	leave  
  802882:	c3                   	ret    

00802883 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802883:	55                   	push   %ebp
  802884:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802886:	6a 00                	push   $0x0
  802888:	6a 00                	push   $0x0
  80288a:	6a 00                	push   $0x0
  80288c:	6a 00                	push   $0x0
  80288e:	6a 00                	push   $0x0
  802890:	6a 15                	push   $0x15
  802892:	e8 96 fd ff ff       	call   80262d <syscall>
  802897:	83 c4 18             	add    $0x18,%esp
}
  80289a:	90                   	nop
  80289b:	c9                   	leave  
  80289c:	c3                   	ret    

0080289d <sys_cputc>:


void
sys_cputc(const char c)
{
  80289d:	55                   	push   %ebp
  80289e:	89 e5                	mov    %esp,%ebp
  8028a0:	83 ec 04             	sub    $0x4,%esp
  8028a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8028a9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8028ad:	6a 00                	push   $0x0
  8028af:	6a 00                	push   $0x0
  8028b1:	6a 00                	push   $0x0
  8028b3:	6a 00                	push   $0x0
  8028b5:	50                   	push   %eax
  8028b6:	6a 16                	push   $0x16
  8028b8:	e8 70 fd ff ff       	call   80262d <syscall>
  8028bd:	83 c4 18             	add    $0x18,%esp
}
  8028c0:	90                   	nop
  8028c1:	c9                   	leave  
  8028c2:	c3                   	ret    

008028c3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8028c3:	55                   	push   %ebp
  8028c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8028c6:	6a 00                	push   $0x0
  8028c8:	6a 00                	push   $0x0
  8028ca:	6a 00                	push   $0x0
  8028cc:	6a 00                	push   $0x0
  8028ce:	6a 00                	push   $0x0
  8028d0:	6a 17                	push   $0x17
  8028d2:	e8 56 fd ff ff       	call   80262d <syscall>
  8028d7:	83 c4 18             	add    $0x18,%esp
}
  8028da:	90                   	nop
  8028db:	c9                   	leave  
  8028dc:	c3                   	ret    

008028dd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8028dd:	55                   	push   %ebp
  8028de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8028e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e3:	6a 00                	push   $0x0
  8028e5:	6a 00                	push   $0x0
  8028e7:	6a 00                	push   $0x0
  8028e9:	ff 75 0c             	pushl  0xc(%ebp)
  8028ec:	50                   	push   %eax
  8028ed:	6a 18                	push   $0x18
  8028ef:	e8 39 fd ff ff       	call   80262d <syscall>
  8028f4:	83 c4 18             	add    $0x18,%esp
}
  8028f7:	c9                   	leave  
  8028f8:	c3                   	ret    

008028f9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8028f9:	55                   	push   %ebp
  8028fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802902:	6a 00                	push   $0x0
  802904:	6a 00                	push   $0x0
  802906:	6a 00                	push   $0x0
  802908:	52                   	push   %edx
  802909:	50                   	push   %eax
  80290a:	6a 1b                	push   $0x1b
  80290c:	e8 1c fd ff ff       	call   80262d <syscall>
  802911:	83 c4 18             	add    $0x18,%esp
}
  802914:	c9                   	leave  
  802915:	c3                   	ret    

00802916 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802916:	55                   	push   %ebp
  802917:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802919:	8b 55 0c             	mov    0xc(%ebp),%edx
  80291c:	8b 45 08             	mov    0x8(%ebp),%eax
  80291f:	6a 00                	push   $0x0
  802921:	6a 00                	push   $0x0
  802923:	6a 00                	push   $0x0
  802925:	52                   	push   %edx
  802926:	50                   	push   %eax
  802927:	6a 19                	push   $0x19
  802929:	e8 ff fc ff ff       	call   80262d <syscall>
  80292e:	83 c4 18             	add    $0x18,%esp
}
  802931:	90                   	nop
  802932:	c9                   	leave  
  802933:	c3                   	ret    

00802934 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802934:	55                   	push   %ebp
  802935:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802937:	8b 55 0c             	mov    0xc(%ebp),%edx
  80293a:	8b 45 08             	mov    0x8(%ebp),%eax
  80293d:	6a 00                	push   $0x0
  80293f:	6a 00                	push   $0x0
  802941:	6a 00                	push   $0x0
  802943:	52                   	push   %edx
  802944:	50                   	push   %eax
  802945:	6a 1a                	push   $0x1a
  802947:	e8 e1 fc ff ff       	call   80262d <syscall>
  80294c:	83 c4 18             	add    $0x18,%esp
}
  80294f:	90                   	nop
  802950:	c9                   	leave  
  802951:	c3                   	ret    

00802952 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802952:	55                   	push   %ebp
  802953:	89 e5                	mov    %esp,%ebp
  802955:	83 ec 04             	sub    $0x4,%esp
  802958:	8b 45 10             	mov    0x10(%ebp),%eax
  80295b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80295e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802961:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802965:	8b 45 08             	mov    0x8(%ebp),%eax
  802968:	6a 00                	push   $0x0
  80296a:	51                   	push   %ecx
  80296b:	52                   	push   %edx
  80296c:	ff 75 0c             	pushl  0xc(%ebp)
  80296f:	50                   	push   %eax
  802970:	6a 1c                	push   $0x1c
  802972:	e8 b6 fc ff ff       	call   80262d <syscall>
  802977:	83 c4 18             	add    $0x18,%esp
}
  80297a:	c9                   	leave  
  80297b:	c3                   	ret    

0080297c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80297c:	55                   	push   %ebp
  80297d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80297f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802982:	8b 45 08             	mov    0x8(%ebp),%eax
  802985:	6a 00                	push   $0x0
  802987:	6a 00                	push   $0x0
  802989:	6a 00                	push   $0x0
  80298b:	52                   	push   %edx
  80298c:	50                   	push   %eax
  80298d:	6a 1d                	push   $0x1d
  80298f:	e8 99 fc ff ff       	call   80262d <syscall>
  802994:	83 c4 18             	add    $0x18,%esp
}
  802997:	c9                   	leave  
  802998:	c3                   	ret    

00802999 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802999:	55                   	push   %ebp
  80299a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80299c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80299f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8029a5:	6a 00                	push   $0x0
  8029a7:	6a 00                	push   $0x0
  8029a9:	51                   	push   %ecx
  8029aa:	52                   	push   %edx
  8029ab:	50                   	push   %eax
  8029ac:	6a 1e                	push   $0x1e
  8029ae:	e8 7a fc ff ff       	call   80262d <syscall>
  8029b3:	83 c4 18             	add    $0x18,%esp
}
  8029b6:	c9                   	leave  
  8029b7:	c3                   	ret    

008029b8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8029b8:	55                   	push   %ebp
  8029b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8029bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029be:	8b 45 08             	mov    0x8(%ebp),%eax
  8029c1:	6a 00                	push   $0x0
  8029c3:	6a 00                	push   $0x0
  8029c5:	6a 00                	push   $0x0
  8029c7:	52                   	push   %edx
  8029c8:	50                   	push   %eax
  8029c9:	6a 1f                	push   $0x1f
  8029cb:	e8 5d fc ff ff       	call   80262d <syscall>
  8029d0:	83 c4 18             	add    $0x18,%esp
}
  8029d3:	c9                   	leave  
  8029d4:	c3                   	ret    

008029d5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8029d5:	55                   	push   %ebp
  8029d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8029d8:	6a 00                	push   $0x0
  8029da:	6a 00                	push   $0x0
  8029dc:	6a 00                	push   $0x0
  8029de:	6a 00                	push   $0x0
  8029e0:	6a 00                	push   $0x0
  8029e2:	6a 20                	push   $0x20
  8029e4:	e8 44 fc ff ff       	call   80262d <syscall>
  8029e9:	83 c4 18             	add    $0x18,%esp
}
  8029ec:	c9                   	leave  
  8029ed:	c3                   	ret    

008029ee <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8029ee:	55                   	push   %ebp
  8029ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8029f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f4:	6a 00                	push   $0x0
  8029f6:	6a 00                	push   $0x0
  8029f8:	ff 75 10             	pushl  0x10(%ebp)
  8029fb:	ff 75 0c             	pushl  0xc(%ebp)
  8029fe:	50                   	push   %eax
  8029ff:	6a 21                	push   $0x21
  802a01:	e8 27 fc ff ff       	call   80262d <syscall>
  802a06:	83 c4 18             	add    $0x18,%esp
}
  802a09:	c9                   	leave  
  802a0a:	c3                   	ret    

00802a0b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802a0b:	55                   	push   %ebp
  802a0c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  802a11:	6a 00                	push   $0x0
  802a13:	6a 00                	push   $0x0
  802a15:	6a 00                	push   $0x0
  802a17:	6a 00                	push   $0x0
  802a19:	50                   	push   %eax
  802a1a:	6a 22                	push   $0x22
  802a1c:	e8 0c fc ff ff       	call   80262d <syscall>
  802a21:	83 c4 18             	add    $0x18,%esp
}
  802a24:	90                   	nop
  802a25:	c9                   	leave  
  802a26:	c3                   	ret    

00802a27 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802a27:	55                   	push   %ebp
  802a28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  802a2d:	6a 00                	push   $0x0
  802a2f:	6a 00                	push   $0x0
  802a31:	6a 00                	push   $0x0
  802a33:	6a 00                	push   $0x0
  802a35:	50                   	push   %eax
  802a36:	6a 23                	push   $0x23
  802a38:	e8 f0 fb ff ff       	call   80262d <syscall>
  802a3d:	83 c4 18             	add    $0x18,%esp
}
  802a40:	90                   	nop
  802a41:	c9                   	leave  
  802a42:	c3                   	ret    

00802a43 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802a43:	55                   	push   %ebp
  802a44:	89 e5                	mov    %esp,%ebp
  802a46:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802a49:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a4c:	8d 50 04             	lea    0x4(%eax),%edx
  802a4f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a52:	6a 00                	push   $0x0
  802a54:	6a 00                	push   $0x0
  802a56:	6a 00                	push   $0x0
  802a58:	52                   	push   %edx
  802a59:	50                   	push   %eax
  802a5a:	6a 24                	push   $0x24
  802a5c:	e8 cc fb ff ff       	call   80262d <syscall>
  802a61:	83 c4 18             	add    $0x18,%esp
	return result;
  802a64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802a67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802a6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a6d:	89 01                	mov    %eax,(%ecx)
  802a6f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802a72:	8b 45 08             	mov    0x8(%ebp),%eax
  802a75:	c9                   	leave  
  802a76:	c2 04 00             	ret    $0x4

00802a79 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802a79:	55                   	push   %ebp
  802a7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802a7c:	6a 00                	push   $0x0
  802a7e:	6a 00                	push   $0x0
  802a80:	ff 75 10             	pushl  0x10(%ebp)
  802a83:	ff 75 0c             	pushl  0xc(%ebp)
  802a86:	ff 75 08             	pushl  0x8(%ebp)
  802a89:	6a 13                	push   $0x13
  802a8b:	e8 9d fb ff ff       	call   80262d <syscall>
  802a90:	83 c4 18             	add    $0x18,%esp
	return ;
  802a93:	90                   	nop
}
  802a94:	c9                   	leave  
  802a95:	c3                   	ret    

00802a96 <sys_rcr2>:
uint32 sys_rcr2()
{
  802a96:	55                   	push   %ebp
  802a97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802a99:	6a 00                	push   $0x0
  802a9b:	6a 00                	push   $0x0
  802a9d:	6a 00                	push   $0x0
  802a9f:	6a 00                	push   $0x0
  802aa1:	6a 00                	push   $0x0
  802aa3:	6a 25                	push   $0x25
  802aa5:	e8 83 fb ff ff       	call   80262d <syscall>
  802aaa:	83 c4 18             	add    $0x18,%esp
}
  802aad:	c9                   	leave  
  802aae:	c3                   	ret    

00802aaf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802aaf:	55                   	push   %ebp
  802ab0:	89 e5                	mov    %esp,%ebp
  802ab2:	83 ec 04             	sub    $0x4,%esp
  802ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  802ab8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802abb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802abf:	6a 00                	push   $0x0
  802ac1:	6a 00                	push   $0x0
  802ac3:	6a 00                	push   $0x0
  802ac5:	6a 00                	push   $0x0
  802ac7:	50                   	push   %eax
  802ac8:	6a 26                	push   $0x26
  802aca:	e8 5e fb ff ff       	call   80262d <syscall>
  802acf:	83 c4 18             	add    $0x18,%esp
	return ;
  802ad2:	90                   	nop
}
  802ad3:	c9                   	leave  
  802ad4:	c3                   	ret    

00802ad5 <rsttst>:
void rsttst()
{
  802ad5:	55                   	push   %ebp
  802ad6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802ad8:	6a 00                	push   $0x0
  802ada:	6a 00                	push   $0x0
  802adc:	6a 00                	push   $0x0
  802ade:	6a 00                	push   $0x0
  802ae0:	6a 00                	push   $0x0
  802ae2:	6a 28                	push   $0x28
  802ae4:	e8 44 fb ff ff       	call   80262d <syscall>
  802ae9:	83 c4 18             	add    $0x18,%esp
	return ;
  802aec:	90                   	nop
}
  802aed:	c9                   	leave  
  802aee:	c3                   	ret    

00802aef <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802aef:	55                   	push   %ebp
  802af0:	89 e5                	mov    %esp,%ebp
  802af2:	83 ec 04             	sub    $0x4,%esp
  802af5:	8b 45 14             	mov    0x14(%ebp),%eax
  802af8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802afb:	8b 55 18             	mov    0x18(%ebp),%edx
  802afe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802b02:	52                   	push   %edx
  802b03:	50                   	push   %eax
  802b04:	ff 75 10             	pushl  0x10(%ebp)
  802b07:	ff 75 0c             	pushl  0xc(%ebp)
  802b0a:	ff 75 08             	pushl  0x8(%ebp)
  802b0d:	6a 27                	push   $0x27
  802b0f:	e8 19 fb ff ff       	call   80262d <syscall>
  802b14:	83 c4 18             	add    $0x18,%esp
	return ;
  802b17:	90                   	nop
}
  802b18:	c9                   	leave  
  802b19:	c3                   	ret    

00802b1a <chktst>:
void chktst(uint32 n)
{
  802b1a:	55                   	push   %ebp
  802b1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802b1d:	6a 00                	push   $0x0
  802b1f:	6a 00                	push   $0x0
  802b21:	6a 00                	push   $0x0
  802b23:	6a 00                	push   $0x0
  802b25:	ff 75 08             	pushl  0x8(%ebp)
  802b28:	6a 29                	push   $0x29
  802b2a:	e8 fe fa ff ff       	call   80262d <syscall>
  802b2f:	83 c4 18             	add    $0x18,%esp
	return ;
  802b32:	90                   	nop
}
  802b33:	c9                   	leave  
  802b34:	c3                   	ret    

00802b35 <inctst>:

void inctst()
{
  802b35:	55                   	push   %ebp
  802b36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802b38:	6a 00                	push   $0x0
  802b3a:	6a 00                	push   $0x0
  802b3c:	6a 00                	push   $0x0
  802b3e:	6a 00                	push   $0x0
  802b40:	6a 00                	push   $0x0
  802b42:	6a 2a                	push   $0x2a
  802b44:	e8 e4 fa ff ff       	call   80262d <syscall>
  802b49:	83 c4 18             	add    $0x18,%esp
	return ;
  802b4c:	90                   	nop
}
  802b4d:	c9                   	leave  
  802b4e:	c3                   	ret    

00802b4f <gettst>:
uint32 gettst()
{
  802b4f:	55                   	push   %ebp
  802b50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802b52:	6a 00                	push   $0x0
  802b54:	6a 00                	push   $0x0
  802b56:	6a 00                	push   $0x0
  802b58:	6a 00                	push   $0x0
  802b5a:	6a 00                	push   $0x0
  802b5c:	6a 2b                	push   $0x2b
  802b5e:	e8 ca fa ff ff       	call   80262d <syscall>
  802b63:	83 c4 18             	add    $0x18,%esp
}
  802b66:	c9                   	leave  
  802b67:	c3                   	ret    

00802b68 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802b68:	55                   	push   %ebp
  802b69:	89 e5                	mov    %esp,%ebp
  802b6b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b6e:	6a 00                	push   $0x0
  802b70:	6a 00                	push   $0x0
  802b72:	6a 00                	push   $0x0
  802b74:	6a 00                	push   $0x0
  802b76:	6a 00                	push   $0x0
  802b78:	6a 2c                	push   $0x2c
  802b7a:	e8 ae fa ff ff       	call   80262d <syscall>
  802b7f:	83 c4 18             	add    $0x18,%esp
  802b82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802b85:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802b89:	75 07                	jne    802b92 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802b8b:	b8 01 00 00 00       	mov    $0x1,%eax
  802b90:	eb 05                	jmp    802b97 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802b92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b97:	c9                   	leave  
  802b98:	c3                   	ret    

00802b99 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802b99:	55                   	push   %ebp
  802b9a:	89 e5                	mov    %esp,%ebp
  802b9c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b9f:	6a 00                	push   $0x0
  802ba1:	6a 00                	push   $0x0
  802ba3:	6a 00                	push   $0x0
  802ba5:	6a 00                	push   $0x0
  802ba7:	6a 00                	push   $0x0
  802ba9:	6a 2c                	push   $0x2c
  802bab:	e8 7d fa ff ff       	call   80262d <syscall>
  802bb0:	83 c4 18             	add    $0x18,%esp
  802bb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802bb6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802bba:	75 07                	jne    802bc3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802bbc:	b8 01 00 00 00       	mov    $0x1,%eax
  802bc1:	eb 05                	jmp    802bc8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802bc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bc8:	c9                   	leave  
  802bc9:	c3                   	ret    

00802bca <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802bca:	55                   	push   %ebp
  802bcb:	89 e5                	mov    %esp,%ebp
  802bcd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bd0:	6a 00                	push   $0x0
  802bd2:	6a 00                	push   $0x0
  802bd4:	6a 00                	push   $0x0
  802bd6:	6a 00                	push   $0x0
  802bd8:	6a 00                	push   $0x0
  802bda:	6a 2c                	push   $0x2c
  802bdc:	e8 4c fa ff ff       	call   80262d <syscall>
  802be1:	83 c4 18             	add    $0x18,%esp
  802be4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802be7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802beb:	75 07                	jne    802bf4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802bed:	b8 01 00 00 00       	mov    $0x1,%eax
  802bf2:	eb 05                	jmp    802bf9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802bf4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bf9:	c9                   	leave  
  802bfa:	c3                   	ret    

00802bfb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802bfb:	55                   	push   %ebp
  802bfc:	89 e5                	mov    %esp,%ebp
  802bfe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802c01:	6a 00                	push   $0x0
  802c03:	6a 00                	push   $0x0
  802c05:	6a 00                	push   $0x0
  802c07:	6a 00                	push   $0x0
  802c09:	6a 00                	push   $0x0
  802c0b:	6a 2c                	push   $0x2c
  802c0d:	e8 1b fa ff ff       	call   80262d <syscall>
  802c12:	83 c4 18             	add    $0x18,%esp
  802c15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802c18:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802c1c:	75 07                	jne    802c25 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802c1e:	b8 01 00 00 00       	mov    $0x1,%eax
  802c23:	eb 05                	jmp    802c2a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802c25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c2a:	c9                   	leave  
  802c2b:	c3                   	ret    

00802c2c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802c2c:	55                   	push   %ebp
  802c2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802c2f:	6a 00                	push   $0x0
  802c31:	6a 00                	push   $0x0
  802c33:	6a 00                	push   $0x0
  802c35:	6a 00                	push   $0x0
  802c37:	ff 75 08             	pushl  0x8(%ebp)
  802c3a:	6a 2d                	push   $0x2d
  802c3c:	e8 ec f9 ff ff       	call   80262d <syscall>
  802c41:	83 c4 18             	add    $0x18,%esp
	return ;
  802c44:	90                   	nop
}
  802c45:	c9                   	leave  
  802c46:	c3                   	ret    
  802c47:	90                   	nop

00802c48 <__udivdi3>:
  802c48:	55                   	push   %ebp
  802c49:	57                   	push   %edi
  802c4a:	56                   	push   %esi
  802c4b:	53                   	push   %ebx
  802c4c:	83 ec 1c             	sub    $0x1c,%esp
  802c4f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802c53:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802c57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802c5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802c5f:	89 ca                	mov    %ecx,%edx
  802c61:	89 f8                	mov    %edi,%eax
  802c63:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802c67:	85 f6                	test   %esi,%esi
  802c69:	75 2d                	jne    802c98 <__udivdi3+0x50>
  802c6b:	39 cf                	cmp    %ecx,%edi
  802c6d:	77 65                	ja     802cd4 <__udivdi3+0x8c>
  802c6f:	89 fd                	mov    %edi,%ebp
  802c71:	85 ff                	test   %edi,%edi
  802c73:	75 0b                	jne    802c80 <__udivdi3+0x38>
  802c75:	b8 01 00 00 00       	mov    $0x1,%eax
  802c7a:	31 d2                	xor    %edx,%edx
  802c7c:	f7 f7                	div    %edi
  802c7e:	89 c5                	mov    %eax,%ebp
  802c80:	31 d2                	xor    %edx,%edx
  802c82:	89 c8                	mov    %ecx,%eax
  802c84:	f7 f5                	div    %ebp
  802c86:	89 c1                	mov    %eax,%ecx
  802c88:	89 d8                	mov    %ebx,%eax
  802c8a:	f7 f5                	div    %ebp
  802c8c:	89 cf                	mov    %ecx,%edi
  802c8e:	89 fa                	mov    %edi,%edx
  802c90:	83 c4 1c             	add    $0x1c,%esp
  802c93:	5b                   	pop    %ebx
  802c94:	5e                   	pop    %esi
  802c95:	5f                   	pop    %edi
  802c96:	5d                   	pop    %ebp
  802c97:	c3                   	ret    
  802c98:	39 ce                	cmp    %ecx,%esi
  802c9a:	77 28                	ja     802cc4 <__udivdi3+0x7c>
  802c9c:	0f bd fe             	bsr    %esi,%edi
  802c9f:	83 f7 1f             	xor    $0x1f,%edi
  802ca2:	75 40                	jne    802ce4 <__udivdi3+0x9c>
  802ca4:	39 ce                	cmp    %ecx,%esi
  802ca6:	72 0a                	jb     802cb2 <__udivdi3+0x6a>
  802ca8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802cac:	0f 87 9e 00 00 00    	ja     802d50 <__udivdi3+0x108>
  802cb2:	b8 01 00 00 00       	mov    $0x1,%eax
  802cb7:	89 fa                	mov    %edi,%edx
  802cb9:	83 c4 1c             	add    $0x1c,%esp
  802cbc:	5b                   	pop    %ebx
  802cbd:	5e                   	pop    %esi
  802cbe:	5f                   	pop    %edi
  802cbf:	5d                   	pop    %ebp
  802cc0:	c3                   	ret    
  802cc1:	8d 76 00             	lea    0x0(%esi),%esi
  802cc4:	31 ff                	xor    %edi,%edi
  802cc6:	31 c0                	xor    %eax,%eax
  802cc8:	89 fa                	mov    %edi,%edx
  802cca:	83 c4 1c             	add    $0x1c,%esp
  802ccd:	5b                   	pop    %ebx
  802cce:	5e                   	pop    %esi
  802ccf:	5f                   	pop    %edi
  802cd0:	5d                   	pop    %ebp
  802cd1:	c3                   	ret    
  802cd2:	66 90                	xchg   %ax,%ax
  802cd4:	89 d8                	mov    %ebx,%eax
  802cd6:	f7 f7                	div    %edi
  802cd8:	31 ff                	xor    %edi,%edi
  802cda:	89 fa                	mov    %edi,%edx
  802cdc:	83 c4 1c             	add    $0x1c,%esp
  802cdf:	5b                   	pop    %ebx
  802ce0:	5e                   	pop    %esi
  802ce1:	5f                   	pop    %edi
  802ce2:	5d                   	pop    %ebp
  802ce3:	c3                   	ret    
  802ce4:	bd 20 00 00 00       	mov    $0x20,%ebp
  802ce9:	89 eb                	mov    %ebp,%ebx
  802ceb:	29 fb                	sub    %edi,%ebx
  802ced:	89 f9                	mov    %edi,%ecx
  802cef:	d3 e6                	shl    %cl,%esi
  802cf1:	89 c5                	mov    %eax,%ebp
  802cf3:	88 d9                	mov    %bl,%cl
  802cf5:	d3 ed                	shr    %cl,%ebp
  802cf7:	89 e9                	mov    %ebp,%ecx
  802cf9:	09 f1                	or     %esi,%ecx
  802cfb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802cff:	89 f9                	mov    %edi,%ecx
  802d01:	d3 e0                	shl    %cl,%eax
  802d03:	89 c5                	mov    %eax,%ebp
  802d05:	89 d6                	mov    %edx,%esi
  802d07:	88 d9                	mov    %bl,%cl
  802d09:	d3 ee                	shr    %cl,%esi
  802d0b:	89 f9                	mov    %edi,%ecx
  802d0d:	d3 e2                	shl    %cl,%edx
  802d0f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802d13:	88 d9                	mov    %bl,%cl
  802d15:	d3 e8                	shr    %cl,%eax
  802d17:	09 c2                	or     %eax,%edx
  802d19:	89 d0                	mov    %edx,%eax
  802d1b:	89 f2                	mov    %esi,%edx
  802d1d:	f7 74 24 0c          	divl   0xc(%esp)
  802d21:	89 d6                	mov    %edx,%esi
  802d23:	89 c3                	mov    %eax,%ebx
  802d25:	f7 e5                	mul    %ebp
  802d27:	39 d6                	cmp    %edx,%esi
  802d29:	72 19                	jb     802d44 <__udivdi3+0xfc>
  802d2b:	74 0b                	je     802d38 <__udivdi3+0xf0>
  802d2d:	89 d8                	mov    %ebx,%eax
  802d2f:	31 ff                	xor    %edi,%edi
  802d31:	e9 58 ff ff ff       	jmp    802c8e <__udivdi3+0x46>
  802d36:	66 90                	xchg   %ax,%ax
  802d38:	8b 54 24 08          	mov    0x8(%esp),%edx
  802d3c:	89 f9                	mov    %edi,%ecx
  802d3e:	d3 e2                	shl    %cl,%edx
  802d40:	39 c2                	cmp    %eax,%edx
  802d42:	73 e9                	jae    802d2d <__udivdi3+0xe5>
  802d44:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802d47:	31 ff                	xor    %edi,%edi
  802d49:	e9 40 ff ff ff       	jmp    802c8e <__udivdi3+0x46>
  802d4e:	66 90                	xchg   %ax,%ax
  802d50:	31 c0                	xor    %eax,%eax
  802d52:	e9 37 ff ff ff       	jmp    802c8e <__udivdi3+0x46>
  802d57:	90                   	nop

00802d58 <__umoddi3>:
  802d58:	55                   	push   %ebp
  802d59:	57                   	push   %edi
  802d5a:	56                   	push   %esi
  802d5b:	53                   	push   %ebx
  802d5c:	83 ec 1c             	sub    $0x1c,%esp
  802d5f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802d63:	8b 74 24 34          	mov    0x34(%esp),%esi
  802d67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802d6b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802d6f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802d73:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802d77:	89 f3                	mov    %esi,%ebx
  802d79:	89 fa                	mov    %edi,%edx
  802d7b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802d7f:	89 34 24             	mov    %esi,(%esp)
  802d82:	85 c0                	test   %eax,%eax
  802d84:	75 1a                	jne    802da0 <__umoddi3+0x48>
  802d86:	39 f7                	cmp    %esi,%edi
  802d88:	0f 86 a2 00 00 00    	jbe    802e30 <__umoddi3+0xd8>
  802d8e:	89 c8                	mov    %ecx,%eax
  802d90:	89 f2                	mov    %esi,%edx
  802d92:	f7 f7                	div    %edi
  802d94:	89 d0                	mov    %edx,%eax
  802d96:	31 d2                	xor    %edx,%edx
  802d98:	83 c4 1c             	add    $0x1c,%esp
  802d9b:	5b                   	pop    %ebx
  802d9c:	5e                   	pop    %esi
  802d9d:	5f                   	pop    %edi
  802d9e:	5d                   	pop    %ebp
  802d9f:	c3                   	ret    
  802da0:	39 f0                	cmp    %esi,%eax
  802da2:	0f 87 ac 00 00 00    	ja     802e54 <__umoddi3+0xfc>
  802da8:	0f bd e8             	bsr    %eax,%ebp
  802dab:	83 f5 1f             	xor    $0x1f,%ebp
  802dae:	0f 84 ac 00 00 00    	je     802e60 <__umoddi3+0x108>
  802db4:	bf 20 00 00 00       	mov    $0x20,%edi
  802db9:	29 ef                	sub    %ebp,%edi
  802dbb:	89 fe                	mov    %edi,%esi
  802dbd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802dc1:	89 e9                	mov    %ebp,%ecx
  802dc3:	d3 e0                	shl    %cl,%eax
  802dc5:	89 d7                	mov    %edx,%edi
  802dc7:	89 f1                	mov    %esi,%ecx
  802dc9:	d3 ef                	shr    %cl,%edi
  802dcb:	09 c7                	or     %eax,%edi
  802dcd:	89 e9                	mov    %ebp,%ecx
  802dcf:	d3 e2                	shl    %cl,%edx
  802dd1:	89 14 24             	mov    %edx,(%esp)
  802dd4:	89 d8                	mov    %ebx,%eax
  802dd6:	d3 e0                	shl    %cl,%eax
  802dd8:	89 c2                	mov    %eax,%edx
  802dda:	8b 44 24 08          	mov    0x8(%esp),%eax
  802dde:	d3 e0                	shl    %cl,%eax
  802de0:	89 44 24 04          	mov    %eax,0x4(%esp)
  802de4:	8b 44 24 08          	mov    0x8(%esp),%eax
  802de8:	89 f1                	mov    %esi,%ecx
  802dea:	d3 e8                	shr    %cl,%eax
  802dec:	09 d0                	or     %edx,%eax
  802dee:	d3 eb                	shr    %cl,%ebx
  802df0:	89 da                	mov    %ebx,%edx
  802df2:	f7 f7                	div    %edi
  802df4:	89 d3                	mov    %edx,%ebx
  802df6:	f7 24 24             	mull   (%esp)
  802df9:	89 c6                	mov    %eax,%esi
  802dfb:	89 d1                	mov    %edx,%ecx
  802dfd:	39 d3                	cmp    %edx,%ebx
  802dff:	0f 82 87 00 00 00    	jb     802e8c <__umoddi3+0x134>
  802e05:	0f 84 91 00 00 00    	je     802e9c <__umoddi3+0x144>
  802e0b:	8b 54 24 04          	mov    0x4(%esp),%edx
  802e0f:	29 f2                	sub    %esi,%edx
  802e11:	19 cb                	sbb    %ecx,%ebx
  802e13:	89 d8                	mov    %ebx,%eax
  802e15:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802e19:	d3 e0                	shl    %cl,%eax
  802e1b:	89 e9                	mov    %ebp,%ecx
  802e1d:	d3 ea                	shr    %cl,%edx
  802e1f:	09 d0                	or     %edx,%eax
  802e21:	89 e9                	mov    %ebp,%ecx
  802e23:	d3 eb                	shr    %cl,%ebx
  802e25:	89 da                	mov    %ebx,%edx
  802e27:	83 c4 1c             	add    $0x1c,%esp
  802e2a:	5b                   	pop    %ebx
  802e2b:	5e                   	pop    %esi
  802e2c:	5f                   	pop    %edi
  802e2d:	5d                   	pop    %ebp
  802e2e:	c3                   	ret    
  802e2f:	90                   	nop
  802e30:	89 fd                	mov    %edi,%ebp
  802e32:	85 ff                	test   %edi,%edi
  802e34:	75 0b                	jne    802e41 <__umoddi3+0xe9>
  802e36:	b8 01 00 00 00       	mov    $0x1,%eax
  802e3b:	31 d2                	xor    %edx,%edx
  802e3d:	f7 f7                	div    %edi
  802e3f:	89 c5                	mov    %eax,%ebp
  802e41:	89 f0                	mov    %esi,%eax
  802e43:	31 d2                	xor    %edx,%edx
  802e45:	f7 f5                	div    %ebp
  802e47:	89 c8                	mov    %ecx,%eax
  802e49:	f7 f5                	div    %ebp
  802e4b:	89 d0                	mov    %edx,%eax
  802e4d:	e9 44 ff ff ff       	jmp    802d96 <__umoddi3+0x3e>
  802e52:	66 90                	xchg   %ax,%ax
  802e54:	89 c8                	mov    %ecx,%eax
  802e56:	89 f2                	mov    %esi,%edx
  802e58:	83 c4 1c             	add    $0x1c,%esp
  802e5b:	5b                   	pop    %ebx
  802e5c:	5e                   	pop    %esi
  802e5d:	5f                   	pop    %edi
  802e5e:	5d                   	pop    %ebp
  802e5f:	c3                   	ret    
  802e60:	3b 04 24             	cmp    (%esp),%eax
  802e63:	72 06                	jb     802e6b <__umoddi3+0x113>
  802e65:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802e69:	77 0f                	ja     802e7a <__umoddi3+0x122>
  802e6b:	89 f2                	mov    %esi,%edx
  802e6d:	29 f9                	sub    %edi,%ecx
  802e6f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802e73:	89 14 24             	mov    %edx,(%esp)
  802e76:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802e7a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802e7e:	8b 14 24             	mov    (%esp),%edx
  802e81:	83 c4 1c             	add    $0x1c,%esp
  802e84:	5b                   	pop    %ebx
  802e85:	5e                   	pop    %esi
  802e86:	5f                   	pop    %edi
  802e87:	5d                   	pop    %ebp
  802e88:	c3                   	ret    
  802e89:	8d 76 00             	lea    0x0(%esi),%esi
  802e8c:	2b 04 24             	sub    (%esp),%eax
  802e8f:	19 fa                	sbb    %edi,%edx
  802e91:	89 d1                	mov    %edx,%ecx
  802e93:	89 c6                	mov    %eax,%esi
  802e95:	e9 71 ff ff ff       	jmp    802e0b <__umoddi3+0xb3>
  802e9a:	66 90                	xchg   %ax,%ax
  802e9c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802ea0:	72 ea                	jb     802e8c <__umoddi3+0x134>
  802ea2:	89 d9                	mov    %ebx,%ecx
  802ea4:	e9 62 ff ff ff       	jmp    802e0b <__umoddi3+0xb3>
