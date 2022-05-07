
obj/user/tst_first_fit_2:     file format elf32-i386


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
  800031:	e8 bb 06 00 00       	call   8006f1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 fc 1f 00 00       	call   802046 <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 29                	jmp    800083 <_main+0x4b>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	89 d0                	mov    %edx,%eax
  80006a:	01 c0                	add    %eax,%eax
  80006c:	01 d0                	add    %edx,%eax
  80006e:	c1 e0 02             	shl    $0x2,%eax
  800071:	01 c8                	add    %ecx,%eax
  800073:	8a 40 04             	mov    0x4(%eax),%al
  800076:	84 c0                	test   %al,%al
  800078:	74 06                	je     800080 <_main+0x48>
			{
				fullWS = 0;
  80007a:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80007e:	eb 12                	jmp    800092 <_main+0x5a>
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800080:	ff 45 f0             	incl   -0x10(%ebp)
  800083:	a1 20 30 80 00       	mov    0x803020,%eax
  800088:	8b 50 74             	mov    0x74(%eax),%edx
  80008b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80008e:	39 c2                	cmp    %eax,%edx
  800090:	77 c8                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800092:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800096:	74 14                	je     8000ac <_main+0x74>
  800098:	83 ec 04             	sub    $0x4,%esp
  80009b:	68 e0 22 80 00       	push   $0x8022e0
  8000a0:	6a 1b                	push   $0x1b
  8000a2:	68 fc 22 80 00       	push   $0x8022fc
  8000a7:	e8 54 07 00 00       	call   800800 <_panic>
	}


	int Mega = 1024*1024;
  8000ac:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b3:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000ba:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000bd:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c7:	89 d7                	mov    %edx,%edi
  8000c9:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	68 01 00 00 20       	push   $0x20000001
  8000d3:	e8 66 17 00 00       	call   80183e <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000de:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e1:	85 c0                	test   %eax,%eax
  8000e3:	74 14                	je     8000f9 <_main+0xc1>
  8000e5:	83 ec 04             	sub    $0x4,%esp
  8000e8:	68 14 23 80 00       	push   $0x802314
  8000ed:	6a 26                	push   $0x26
  8000ef:	68 fc 22 80 00       	push   $0x8022fc
  8000f4:	e8 07 07 00 00       	call   800800 <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 b5 1a 00 00       	call   801bb3 <sys_calculate_free_frames>
  8000fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800101:	e8 30 1b 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800106:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	50                   	push   %eax
  800115:	e8 24 17 00 00       	call   80183e <malloc>
  80011a:	83 c4 10             	add    $0x10,%esp
  80011d:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800120:	8b 45 90             	mov    -0x70(%ebp),%eax
  800123:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800128:	74 14                	je     80013e <_main+0x106>
  80012a:	83 ec 04             	sub    $0x4,%esp
  80012d:	68 58 23 80 00       	push   $0x802358
  800132:	6a 2f                	push   $0x2f
  800134:	68 fc 22 80 00       	push   $0x8022fc
  800139:	e8 c2 06 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013e:	e8 f3 1a 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800143:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800146:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 88 23 80 00       	push   $0x802388
  800155:	6a 31                	push   $0x31
  800157:	68 fc 22 80 00       	push   $0x8022fc
  80015c:	e8 9f 06 00 00       	call   800800 <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800161:	e8 4d 1a 00 00       	call   801bb3 <sys_calculate_free_frames>
  800166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800169:	e8 c8 1a 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80016e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800171:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800174:	01 c0                	add    %eax,%eax
  800176:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	50                   	push   %eax
  80017d:	e8 bc 16 00 00       	call   80183e <malloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800188:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018b:	89 c2                	mov    %eax,%edx
  80018d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800190:	01 c0                	add    %eax,%eax
  800192:	05 00 00 00 80       	add    $0x80000000,%eax
  800197:	39 c2                	cmp    %eax,%edx
  800199:	74 14                	je     8001af <_main+0x177>
  80019b:	83 ec 04             	sub    $0x4,%esp
  80019e:	68 58 23 80 00       	push   $0x802358
  8001a3:	6a 37                	push   $0x37
  8001a5:	68 fc 22 80 00       	push   $0x8022fc
  8001aa:	e8 51 06 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001af:	e8 82 1a 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8001b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 88 23 80 00       	push   $0x802388
  8001c6:	6a 39                	push   $0x39
  8001c8:	68 fc 22 80 00       	push   $0x8022fc
  8001cd:	e8 2e 06 00 00       	call   800800 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d2:	e8 dc 19 00 00       	call   801bb3 <sys_calculate_free_frames>
  8001d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001da:	e8 57 1a 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8001df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	50                   	push   %eax
  8001eb:	e8 4e 16 00 00       	call   80183e <malloc>
  8001f0:	83 c4 10             	add    $0x10,%esp
  8001f3:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8001f6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001f9:	89 c2                	mov    %eax,%edx
  8001fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001fe:	c1 e0 02             	shl    $0x2,%eax
  800201:	05 00 00 00 80       	add    $0x80000000,%eax
  800206:	39 c2                	cmp    %eax,%edx
  800208:	74 14                	je     80021e <_main+0x1e6>
  80020a:	83 ec 04             	sub    $0x4,%esp
  80020d:	68 58 23 80 00       	push   $0x802358
  800212:	6a 3f                	push   $0x3f
  800214:	68 fc 22 80 00       	push   $0x8022fc
  800219:	e8 e2 05 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021e:	e8 13 1a 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800223:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800226:	83 f8 01             	cmp    $0x1,%eax
  800229:	74 14                	je     80023f <_main+0x207>
  80022b:	83 ec 04             	sub    $0x4,%esp
  80022e:	68 88 23 80 00       	push   $0x802388
  800233:	6a 41                	push   $0x41
  800235:	68 fc 22 80 00       	push   $0x8022fc
  80023a:	e8 c1 05 00 00       	call   800800 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80023f:	e8 6f 19 00 00       	call   801bb3 <sys_calculate_free_frames>
  800244:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800247:	e8 ea 19 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80024c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  80024f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800252:	01 c0                	add    %eax,%eax
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	50                   	push   %eax
  800258:	e8 e1 15 00 00       	call   80183e <malloc>
  80025d:	83 c4 10             	add    $0x10,%esp
  800260:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... ");
  800263:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800266:	89 c2                	mov    %eax,%edx
  800268:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80026b:	c1 e0 02             	shl    $0x2,%eax
  80026e:	89 c1                	mov    %eax,%ecx
  800270:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800273:	c1 e0 02             	shl    $0x2,%eax
  800276:	01 c8                	add    %ecx,%eax
  800278:	05 00 00 00 80       	add    $0x80000000,%eax
  80027d:	39 c2                	cmp    %eax,%edx
  80027f:	74 14                	je     800295 <_main+0x25d>
  800281:	83 ec 04             	sub    $0x4,%esp
  800284:	68 58 23 80 00       	push   $0x802358
  800289:	6a 47                	push   $0x47
  80028b:	68 fc 22 80 00       	push   $0x8022fc
  800290:	e8 6b 05 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800295:	e8 9c 19 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80029a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029d:	83 f8 01             	cmp    $0x1,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 88 23 80 00       	push   $0x802388
  8002aa:	6a 49                	push   $0x49
  8002ac:	68 fc 22 80 00       	push   $0x8022fc
  8002b1:	e8 4a 05 00 00       	call   800800 <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 f8 18 00 00       	call   801bb3 <sys_calculate_free_frames>
  8002bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002be:	e8 73 19 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 24 17 00 00       	call   8019f6 <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d5:	e8 5c 19 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	29 c2                	sub    %eax,%edx
  8002df:	89 d0                	mov    %edx,%eax
  8002e1:	83 f8 01             	cmp    $0x1,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 a5 23 80 00       	push   $0x8023a5
  8002ee:	6a 50                	push   $0x50
  8002f0:	68 fc 22 80 00       	push   $0x8022fc
  8002f5:	e8 06 05 00 00       	call   800800 <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 b4 18 00 00       	call   801bb3 <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800302:	e8 2f 19 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800307:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80030a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80030d:	89 d0                	mov    %edx,%eax
  80030f:	01 c0                	add    %eax,%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	01 c0                	add    %eax,%eax
  800315:	01 d0                	add    %edx,%eax
  800317:	83 ec 0c             	sub    $0xc,%esp
  80031a:	50                   	push   %eax
  80031b:	e8 1e 15 00 00       	call   80183e <malloc>
  800320:	83 c4 10             	add    $0x10,%esp
  800323:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... ");
  800326:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80032e:	c1 e0 02             	shl    $0x2,%eax
  800331:	89 c1                	mov    %eax,%ecx
  800333:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800336:	c1 e0 03             	shl    $0x3,%eax
  800339:	01 c8                	add    %ecx,%eax
  80033b:	05 00 00 00 80       	add    $0x80000000,%eax
  800340:	39 c2                	cmp    %eax,%edx
  800342:	74 14                	je     800358 <_main+0x320>
  800344:	83 ec 04             	sub    $0x4,%esp
  800347:	68 58 23 80 00       	push   $0x802358
  80034c:	6a 56                	push   $0x56
  80034e:	68 fc 22 80 00       	push   $0x8022fc
  800353:	e8 a8 04 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800358:	e8 d9 18 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80035d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800360:	83 f8 02             	cmp    $0x2,%eax
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 88 23 80 00       	push   $0x802388
  80036d:	6a 58                	push   $0x58
  80036f:	68 fc 22 80 00       	push   $0x8022fc
  800374:	e8 87 04 00 00       	call   800800 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800379:	e8 35 18 00 00       	call   801bb3 <sys_calculate_free_frames>
  80037e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800381:	e8 b0 18 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800389:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	50                   	push   %eax
  800390:	e8 61 16 00 00       	call   8019f6 <free>
  800395:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800398:	e8 99 18 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80039d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a0:	29 c2                	sub    %eax,%edx
  8003a2:	89 d0                	mov    %edx,%eax
  8003a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a9:	74 14                	je     8003bf <_main+0x387>
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 a5 23 80 00       	push   $0x8023a5
  8003b3:	6a 5f                	push   $0x5f
  8003b5:	68 fc 22 80 00       	push   $0x8022fc
  8003ba:	e8 41 04 00 00       	call   800800 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 ef 17 00 00       	call   801bb3 <sys_calculate_free_frames>
  8003c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c7:	e8 6a 18 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8003cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	01 d2                	add    %edx,%edx
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	50                   	push   %eax
  8003df:	e8 5a 14 00 00       	call   80183e <malloc>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8003ea:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ed:	89 c2                	mov    %eax,%edx
  8003ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003f2:	c1 e0 02             	shl    $0x2,%eax
  8003f5:	89 c1                	mov    %eax,%ecx
  8003f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003fa:	c1 e0 04             	shl    $0x4,%eax
  8003fd:	01 c8                	add    %ecx,%eax
  8003ff:	05 00 00 00 80       	add    $0x80000000,%eax
  800404:	39 c2                	cmp    %eax,%edx
  800406:	74 14                	je     80041c <_main+0x3e4>
  800408:	83 ec 04             	sub    $0x4,%esp
  80040b:	68 58 23 80 00       	push   $0x802358
  800410:	6a 65                	push   $0x65
  800412:	68 fc 22 80 00       	push   $0x8022fc
  800417:	e8 e4 03 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041c:	e8 15 18 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800421:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800424:	89 c2                	mov    %eax,%edx
  800426:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800429:	89 c1                	mov    %eax,%ecx
  80042b:	01 c9                	add    %ecx,%ecx
  80042d:	01 c8                	add    %ecx,%eax
  80042f:	85 c0                	test   %eax,%eax
  800431:	79 05                	jns    800438 <_main+0x400>
  800433:	05 ff 0f 00 00       	add    $0xfff,%eax
  800438:	c1 f8 0c             	sar    $0xc,%eax
  80043b:	39 c2                	cmp    %eax,%edx
  80043d:	74 14                	je     800453 <_main+0x41b>
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	68 88 23 80 00       	push   $0x802388
  800447:	6a 67                	push   $0x67
  800449:	68 fc 22 80 00       	push   $0x8022fc
  80044e:	e8 ad 03 00 00       	call   800800 <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800453:	e8 5b 17 00 00       	call   801bb3 <sys_calculate_free_frames>
  800458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045b:	e8 d6 17 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800460:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  800463:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800466:	89 c2                	mov    %eax,%edx
  800468:	01 d2                	add    %edx,%edx
  80046a:	01 c2                	add    %eax,%edx
  80046c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046f:	01 d0                	add    %edx,%eax
  800471:	01 c0                	add    %eax,%eax
  800473:	83 ec 0c             	sub    $0xc,%esp
  800476:	50                   	push   %eax
  800477:	e8 c2 13 00 00       	call   80183e <malloc>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800482:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800485:	89 c1                	mov    %eax,%ecx
  800487:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80048a:	89 d0                	mov    %edx,%eax
  80048c:	01 c0                	add    %eax,%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	01 c0                	add    %eax,%eax
  800492:	01 d0                	add    %edx,%eax
  800494:	89 c2                	mov    %eax,%edx
  800496:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800499:	c1 e0 04             	shl    $0x4,%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	05 00 00 00 80       	add    $0x80000000,%eax
  8004a3:	39 c1                	cmp    %eax,%ecx
  8004a5:	74 14                	je     8004bb <_main+0x483>
  8004a7:	83 ec 04             	sub    $0x4,%esp
  8004aa:	68 58 23 80 00       	push   $0x802358
  8004af:	6a 6d                	push   $0x6d
  8004b1:	68 fc 22 80 00       	push   $0x8022fc
  8004b6:	e8 45 03 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bb:	e8 76 17 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8004c0:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 88 23 80 00       	push   $0x802388
  8004d2:	6a 6f                	push   $0x6f
  8004d4:	68 fc 22 80 00       	push   $0x8022fc
  8004d9:	e8 22 03 00 00       	call   800800 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 d0 16 00 00       	call   801bb3 <sys_calculate_free_frames>
  8004e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 4b 17 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  8004ee:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004f1:	83 ec 0c             	sub    $0xc,%esp
  8004f4:	50                   	push   %eax
  8004f5:	e8 fc 14 00 00       	call   8019f6 <free>
  8004fa:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  8004fd:	e8 34 17 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800502:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800505:	29 c2                	sub    %eax,%edx
  800507:	89 d0                	mov    %edx,%eax
  800509:	3d 00 03 00 00       	cmp    $0x300,%eax
  80050e:	74 14                	je     800524 <_main+0x4ec>
  800510:	83 ec 04             	sub    $0x4,%esp
  800513:	68 a5 23 80 00       	push   $0x8023a5
  800518:	6a 76                	push   $0x76
  80051a:	68 fc 22 80 00       	push   $0x8022fc
  80051f:	e8 dc 02 00 00       	call   800800 <_panic>

		//2 MB Hole [Resulting Hole = 2 MB + 2 MB + 4 KB = 4 MB + 4 KB]
		freeFrames = sys_calculate_free_frames() ;
  800524:	e8 8a 16 00 00       	call   801bb3 <sys_calculate_free_frames>
  800529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80052c:	e8 05 17 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800531:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800534:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800537:	83 ec 0c             	sub    $0xc,%esp
  80053a:	50                   	push   %eax
  80053b:	e8 b6 14 00 00       	call   8019f6 <free>
  800540:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800543:	e8 ee 16 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800548:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054b:	29 c2                	sub    %eax,%edx
  80054d:	89 d0                	mov    %edx,%eax
  80054f:	3d 00 02 00 00       	cmp    $0x200,%eax
  800554:	74 14                	je     80056a <_main+0x532>
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	68 a5 23 80 00       	push   $0x8023a5
  80055e:	6a 7d                	push   $0x7d
  800560:	68 fc 22 80 00       	push   $0x8022fc
  800565:	e8 96 02 00 00       	call   800800 <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  80056a:	e8 44 16 00 00       	call   801bb3 <sys_calculate_free_frames>
  80056f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800572:	e8 bf 16 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800577:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  80057a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80057d:	89 d0                	mov    %edx,%eax
  80057f:	c1 e0 02             	shl    $0x2,%eax
  800582:	01 d0                	add    %edx,%eax
  800584:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800587:	83 ec 0c             	sub    $0xc,%esp
  80058a:	50                   	push   %eax
  80058b:	e8 ae 12 00 00       	call   80183e <malloc>
  800590:	83 c4 10             	add    $0x10,%esp
  800593:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  800596:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800599:	89 c1                	mov    %eax,%ecx
  80059b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80059e:	89 d0                	mov    %edx,%eax
  8005a0:	c1 e0 03             	shl    $0x3,%eax
  8005a3:	01 d0                	add    %edx,%eax
  8005a5:	89 c3                	mov    %eax,%ebx
  8005a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005aa:	89 d0                	mov    %edx,%eax
  8005ac:	01 c0                	add    %eax,%eax
  8005ae:	01 d0                	add    %edx,%eax
  8005b0:	c1 e0 03             	shl    $0x3,%eax
  8005b3:	01 d8                	add    %ebx,%eax
  8005b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8005ba:	39 c1                	cmp    %eax,%ecx
  8005bc:	74 17                	je     8005d5 <_main+0x59d>
  8005be:	83 ec 04             	sub    $0x4,%esp
  8005c1:	68 58 23 80 00       	push   $0x802358
  8005c6:	68 83 00 00 00       	push   $0x83
  8005cb:	68 fc 22 80 00       	push   $0x8022fc
  8005d0:	e8 2b 02 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  8005d5:	e8 5c 16 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  8005da:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005dd:	89 c1                	mov    %eax,%ecx
  8005df:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e2:	89 d0                	mov    %edx,%eax
  8005e4:	c1 e0 02             	shl    $0x2,%eax
  8005e7:	01 d0                	add    %edx,%eax
  8005e9:	85 c0                	test   %eax,%eax
  8005eb:	79 05                	jns    8005f2 <_main+0x5ba>
  8005ed:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f2:	c1 f8 0c             	sar    $0xc,%eax
  8005f5:	39 c1                	cmp    %eax,%ecx
  8005f7:	74 17                	je     800610 <_main+0x5d8>
  8005f9:	83 ec 04             	sub    $0x4,%esp
  8005fc:	68 88 23 80 00       	push   $0x802388
  800601:	68 85 00 00 00       	push   $0x85
  800606:	68 fc 22 80 00       	push   $0x8022fc
  80060b:	e8 f0 01 00 00       	call   800800 <_panic>
//		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
//		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");

		//[FIRST FIT Case]
		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800610:	e8 9e 15 00 00       	call   801bb3 <sys_calculate_free_frames>
  800615:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800618:	e8 19 16 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  80061d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(3*Mega-kilo);
  800620:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800623:	89 c2                	mov    %eax,%edx
  800625:	01 d2                	add    %edx,%edx
  800627:	01 d0                	add    %edx,%eax
  800629:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80062c:	83 ec 0c             	sub    $0xc,%esp
  80062f:	50                   	push   %eax
  800630:	e8 09 12 00 00       	call   80183e <malloc>
  800635:	83 c4 10             	add    $0x10,%esp
  800638:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80063b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80063e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800643:	74 17                	je     80065c <_main+0x624>
  800645:	83 ec 04             	sub    $0x4,%esp
  800648:	68 58 23 80 00       	push   $0x802358
  80064d:	68 93 00 00 00       	push   $0x93
  800652:	68 fc 22 80 00       	push   $0x8022fc
  800657:	e8 a4 01 00 00       	call   800800 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80065c:	e8 d5 15 00 00       	call   801c36 <sys_pf_calculate_allocated_pages>
  800661:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800664:	89 c2                	mov    %eax,%edx
  800666:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800669:	89 c1                	mov    %eax,%ecx
  80066b:	01 c9                	add    %ecx,%ecx
  80066d:	01 c8                	add    %ecx,%eax
  80066f:	85 c0                	test   %eax,%eax
  800671:	79 05                	jns    800678 <_main+0x640>
  800673:	05 ff 0f 00 00       	add    $0xfff,%eax
  800678:	c1 f8 0c             	sar    $0xc,%eax
  80067b:	39 c2                	cmp    %eax,%edx
  80067d:	74 17                	je     800696 <_main+0x65e>
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 88 23 80 00       	push   $0x802388
  800687:	68 95 00 00 00       	push   $0x95
  80068c:	68 fc 22 80 00       	push   $0x8022fc
  800691:	e8 6a 01 00 00       	call   800800 <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800696:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800699:	89 d0                	mov    %edx,%eax
  80069b:	01 c0                	add    %eax,%eax
  80069d:	01 d0                	add    %edx,%eax
  80069f:	01 c0                	add    %eax,%eax
  8006a1:	01 d0                	add    %edx,%eax
  8006a3:	01 c0                	add    %eax,%eax
  8006a5:	f7 d8                	neg    %eax
  8006a7:	05 00 00 00 20       	add    $0x20000000,%eax
  8006ac:	83 ec 0c             	sub    $0xc,%esp
  8006af:	50                   	push   %eax
  8006b0:	e8 89 11 00 00       	call   80183e <malloc>
  8006b5:	83 c4 10             	add    $0x10,%esp
  8006b8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if (ptr_allocations[9] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8006bb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006be:	85 c0                	test   %eax,%eax
  8006c0:	74 17                	je     8006d9 <_main+0x6a1>
  8006c2:	83 ec 04             	sub    $0x4,%esp
  8006c5:	68 bc 23 80 00       	push   $0x8023bc
  8006ca:	68 9e 00 00 00       	push   $0x9e
  8006cf:	68 fc 22 80 00       	push   $0x8022fc
  8006d4:	e8 27 01 00 00       	call   800800 <_panic>

		cprintf("Congratulations!! test FIRST FIT allocation (2) completed successfully.\n");
  8006d9:	83 ec 0c             	sub    $0xc,%esp
  8006dc:	68 20 24 80 00       	push   $0x802420
  8006e1:	e8 ce 03 00 00       	call   800ab4 <cprintf>
  8006e6:	83 c4 10             	add    $0x10,%esp

		return;
  8006e9:	90                   	nop
	}
}
  8006ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8006ed:	5b                   	pop    %ebx
  8006ee:	5f                   	pop    %edi
  8006ef:	5d                   	pop    %ebp
  8006f0:	c3                   	ret    

008006f1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006f1:	55                   	push   %ebp
  8006f2:	89 e5                	mov    %esp,%ebp
  8006f4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006f7:	e8 ec 13 00 00       	call   801ae8 <sys_getenvindex>
  8006fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800702:	89 d0                	mov    %edx,%eax
  800704:	c1 e0 02             	shl    $0x2,%eax
  800707:	01 d0                	add    %edx,%eax
  800709:	01 c0                	add    %eax,%eax
  80070b:	01 d0                	add    %edx,%eax
  80070d:	01 c0                	add    %eax,%eax
  80070f:	01 d0                	add    %edx,%eax
  800711:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800718:	01 d0                	add    %edx,%eax
  80071a:	c1 e0 02             	shl    $0x2,%eax
  80071d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800722:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800727:	a1 20 30 80 00       	mov    0x803020,%eax
  80072c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800732:	84 c0                	test   %al,%al
  800734:	74 0f                	je     800745 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800736:	a1 20 30 80 00       	mov    0x803020,%eax
  80073b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800740:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800745:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800749:	7e 0a                	jle    800755 <libmain+0x64>
		binaryname = argv[0];
  80074b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074e:	8b 00                	mov    (%eax),%eax
  800750:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 0c             	pushl  0xc(%ebp)
  80075b:	ff 75 08             	pushl  0x8(%ebp)
  80075e:	e8 d5 f8 ff ff       	call   800038 <_main>
  800763:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800766:	e8 18 15 00 00       	call   801c83 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80076b:	83 ec 0c             	sub    $0xc,%esp
  80076e:	68 84 24 80 00       	push   $0x802484
  800773:	e8 3c 03 00 00       	call   800ab4 <cprintf>
  800778:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80077b:	a1 20 30 80 00       	mov    0x803020,%eax
  800780:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800786:	a1 20 30 80 00       	mov    0x803020,%eax
  80078b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800791:	83 ec 04             	sub    $0x4,%esp
  800794:	52                   	push   %edx
  800795:	50                   	push   %eax
  800796:	68 ac 24 80 00       	push   $0x8024ac
  80079b:	e8 14 03 00 00       	call   800ab4 <cprintf>
  8007a0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a8:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	50                   	push   %eax
  8007b2:	68 d1 24 80 00       	push   $0x8024d1
  8007b7:	e8 f8 02 00 00       	call   800ab4 <cprintf>
  8007bc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007bf:	83 ec 0c             	sub    $0xc,%esp
  8007c2:	68 84 24 80 00       	push   $0x802484
  8007c7:	e8 e8 02 00 00       	call   800ab4 <cprintf>
  8007cc:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007cf:	e8 c9 14 00 00       	call   801c9d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007d4:	e8 19 00 00 00       	call   8007f2 <exit>
}
  8007d9:	90                   	nop
  8007da:	c9                   	leave  
  8007db:	c3                   	ret    

008007dc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007dc:	55                   	push   %ebp
  8007dd:	89 e5                	mov    %esp,%ebp
  8007df:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007e2:	83 ec 0c             	sub    $0xc,%esp
  8007e5:	6a 00                	push   $0x0
  8007e7:	e8 c8 12 00 00       	call   801ab4 <sys_env_destroy>
  8007ec:	83 c4 10             	add    $0x10,%esp
}
  8007ef:	90                   	nop
  8007f0:	c9                   	leave  
  8007f1:	c3                   	ret    

008007f2 <exit>:

void
exit(void)
{
  8007f2:	55                   	push   %ebp
  8007f3:	89 e5                	mov    %esp,%ebp
  8007f5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007f8:	e8 1d 13 00 00       	call   801b1a <sys_env_exit>
}
  8007fd:	90                   	nop
  8007fe:	c9                   	leave  
  8007ff:	c3                   	ret    

00800800 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800800:	55                   	push   %ebp
  800801:	89 e5                	mov    %esp,%ebp
  800803:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800806:	8d 45 10             	lea    0x10(%ebp),%eax
  800809:	83 c0 04             	add    $0x4,%eax
  80080c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80080f:	a1 34 30 80 00       	mov    0x803034,%eax
  800814:	85 c0                	test   %eax,%eax
  800816:	74 16                	je     80082e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800818:	a1 34 30 80 00       	mov    0x803034,%eax
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	50                   	push   %eax
  800821:	68 e8 24 80 00       	push   $0x8024e8
  800826:	e8 89 02 00 00       	call   800ab4 <cprintf>
  80082b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80082e:	a1 00 30 80 00       	mov    0x803000,%eax
  800833:	ff 75 0c             	pushl  0xc(%ebp)
  800836:	ff 75 08             	pushl  0x8(%ebp)
  800839:	50                   	push   %eax
  80083a:	68 ed 24 80 00       	push   $0x8024ed
  80083f:	e8 70 02 00 00       	call   800ab4 <cprintf>
  800844:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800847:	8b 45 10             	mov    0x10(%ebp),%eax
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	ff 75 f4             	pushl  -0xc(%ebp)
  800850:	50                   	push   %eax
  800851:	e8 f3 01 00 00       	call   800a49 <vcprintf>
  800856:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800859:	83 ec 08             	sub    $0x8,%esp
  80085c:	6a 00                	push   $0x0
  80085e:	68 09 25 80 00       	push   $0x802509
  800863:	e8 e1 01 00 00       	call   800a49 <vcprintf>
  800868:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80086b:	e8 82 ff ff ff       	call   8007f2 <exit>

	// should not return here
	while (1) ;
  800870:	eb fe                	jmp    800870 <_panic+0x70>

00800872 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
  800875:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800878:	a1 20 30 80 00       	mov    0x803020,%eax
  80087d:	8b 50 74             	mov    0x74(%eax),%edx
  800880:	8b 45 0c             	mov    0xc(%ebp),%eax
  800883:	39 c2                	cmp    %eax,%edx
  800885:	74 14                	je     80089b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800887:	83 ec 04             	sub    $0x4,%esp
  80088a:	68 0c 25 80 00       	push   $0x80250c
  80088f:	6a 26                	push   $0x26
  800891:	68 58 25 80 00       	push   $0x802558
  800896:	e8 65 ff ff ff       	call   800800 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80089b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008a9:	e9 c2 00 00 00       	jmp    800970 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8008ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bb:	01 d0                	add    %edx,%eax
  8008bd:	8b 00                	mov    (%eax),%eax
  8008bf:	85 c0                	test   %eax,%eax
  8008c1:	75 08                	jne    8008cb <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008c3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008c6:	e9 a2 00 00 00       	jmp    80096d <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8008cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008d2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008d9:	eb 69                	jmp    800944 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008db:	a1 20 30 80 00       	mov    0x803020,%eax
  8008e0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008e9:	89 d0                	mov    %edx,%eax
  8008eb:	01 c0                	add    %eax,%eax
  8008ed:	01 d0                	add    %edx,%eax
  8008ef:	c1 e0 02             	shl    $0x2,%eax
  8008f2:	01 c8                	add    %ecx,%eax
  8008f4:	8a 40 04             	mov    0x4(%eax),%al
  8008f7:	84 c0                	test   %al,%al
  8008f9:	75 46                	jne    800941 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800900:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800906:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800909:	89 d0                	mov    %edx,%eax
  80090b:	01 c0                	add    %eax,%eax
  80090d:	01 d0                	add    %edx,%eax
  80090f:	c1 e0 02             	shl    $0x2,%eax
  800912:	01 c8                	add    %ecx,%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800919:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80091c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800921:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800923:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800926:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	01 c8                	add    %ecx,%eax
  800932:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800934:	39 c2                	cmp    %eax,%edx
  800936:	75 09                	jne    800941 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800938:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80093f:	eb 12                	jmp    800953 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800941:	ff 45 e8             	incl   -0x18(%ebp)
  800944:	a1 20 30 80 00       	mov    0x803020,%eax
  800949:	8b 50 74             	mov    0x74(%eax),%edx
  80094c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80094f:	39 c2                	cmp    %eax,%edx
  800951:	77 88                	ja     8008db <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800953:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800957:	75 14                	jne    80096d <CheckWSWithoutLastIndex+0xfb>
			panic(
  800959:	83 ec 04             	sub    $0x4,%esp
  80095c:	68 64 25 80 00       	push   $0x802564
  800961:	6a 3a                	push   $0x3a
  800963:	68 58 25 80 00       	push   $0x802558
  800968:	e8 93 fe ff ff       	call   800800 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80096d:	ff 45 f0             	incl   -0x10(%ebp)
  800970:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800973:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800976:	0f 8c 32 ff ff ff    	jl     8008ae <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80097c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800983:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80098a:	eb 26                	jmp    8009b2 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80098c:	a1 20 30 80 00       	mov    0x803020,%eax
  800991:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800997:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099a:	89 d0                	mov    %edx,%eax
  80099c:	01 c0                	add    %eax,%eax
  80099e:	01 d0                	add    %edx,%eax
  8009a0:	c1 e0 02             	shl    $0x2,%eax
  8009a3:	01 c8                	add    %ecx,%eax
  8009a5:	8a 40 04             	mov    0x4(%eax),%al
  8009a8:	3c 01                	cmp    $0x1,%al
  8009aa:	75 03                	jne    8009af <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8009ac:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009af:	ff 45 e0             	incl   -0x20(%ebp)
  8009b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8009b7:	8b 50 74             	mov    0x74(%eax),%edx
  8009ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009bd:	39 c2                	cmp    %eax,%edx
  8009bf:	77 cb                	ja     80098c <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009c7:	74 14                	je     8009dd <CheckWSWithoutLastIndex+0x16b>
		panic(
  8009c9:	83 ec 04             	sub    $0x4,%esp
  8009cc:	68 b8 25 80 00       	push   $0x8025b8
  8009d1:	6a 44                	push   $0x44
  8009d3:	68 58 25 80 00       	push   $0x802558
  8009d8:	e8 23 fe ff ff       	call   800800 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009dd:	90                   	nop
  8009de:	c9                   	leave  
  8009df:	c3                   	ret    

008009e0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009e0:	55                   	push   %ebp
  8009e1:	89 e5                	mov    %esp,%ebp
  8009e3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e9:	8b 00                	mov    (%eax),%eax
  8009eb:	8d 48 01             	lea    0x1(%eax),%ecx
  8009ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f1:	89 0a                	mov    %ecx,(%edx)
  8009f3:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f6:	88 d1                	mov    %dl,%cl
  8009f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a02:	8b 00                	mov    (%eax),%eax
  800a04:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a09:	75 2c                	jne    800a37 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a0b:	a0 24 30 80 00       	mov    0x803024,%al
  800a10:	0f b6 c0             	movzbl %al,%eax
  800a13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a16:	8b 12                	mov    (%edx),%edx
  800a18:	89 d1                	mov    %edx,%ecx
  800a1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1d:	83 c2 08             	add    $0x8,%edx
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	50                   	push   %eax
  800a24:	51                   	push   %ecx
  800a25:	52                   	push   %edx
  800a26:	e8 47 10 00 00       	call   801a72 <sys_cputs>
  800a2b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a31:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3a:	8b 40 04             	mov    0x4(%eax),%eax
  800a3d:	8d 50 01             	lea    0x1(%eax),%edx
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a46:	90                   	nop
  800a47:	c9                   	leave  
  800a48:	c3                   	ret    

00800a49 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a49:	55                   	push   %ebp
  800a4a:	89 e5                	mov    %esp,%ebp
  800a4c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a52:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a59:	00 00 00 
	b.cnt = 0;
  800a5c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a63:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	ff 75 08             	pushl  0x8(%ebp)
  800a6c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a72:	50                   	push   %eax
  800a73:	68 e0 09 80 00       	push   $0x8009e0
  800a78:	e8 11 02 00 00       	call   800c8e <vprintfmt>
  800a7d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a80:	a0 24 30 80 00       	mov    0x803024,%al
  800a85:	0f b6 c0             	movzbl %al,%eax
  800a88:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a8e:	83 ec 04             	sub    $0x4,%esp
  800a91:	50                   	push   %eax
  800a92:	52                   	push   %edx
  800a93:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a99:	83 c0 08             	add    $0x8,%eax
  800a9c:	50                   	push   %eax
  800a9d:	e8 d0 0f 00 00       	call   801a72 <sys_cputs>
  800aa2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aa5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800aac:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
  800ab7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800aba:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ac1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	83 ec 08             	sub    $0x8,%esp
  800acd:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad0:	50                   	push   %eax
  800ad1:	e8 73 ff ff ff       	call   800a49 <vcprintf>
  800ad6:	83 c4 10             	add    $0x10,%esp
  800ad9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800adc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800adf:	c9                   	leave  
  800ae0:	c3                   	ret    

00800ae1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
  800ae4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ae7:	e8 97 11 00 00       	call   801c83 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aec:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	83 ec 08             	sub    $0x8,%esp
  800af8:	ff 75 f4             	pushl  -0xc(%ebp)
  800afb:	50                   	push   %eax
  800afc:	e8 48 ff ff ff       	call   800a49 <vcprintf>
  800b01:	83 c4 10             	add    $0x10,%esp
  800b04:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b07:	e8 91 11 00 00       	call   801c9d <sys_enable_interrupt>
	return cnt;
  800b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b0f:	c9                   	leave  
  800b10:	c3                   	ret    

00800b11 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b11:	55                   	push   %ebp
  800b12:	89 e5                	mov    %esp,%ebp
  800b14:	53                   	push   %ebx
  800b15:	83 ec 14             	sub    $0x14,%esp
  800b18:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b24:	8b 45 18             	mov    0x18(%ebp),%eax
  800b27:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b2f:	77 55                	ja     800b86 <printnum+0x75>
  800b31:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b34:	72 05                	jb     800b3b <printnum+0x2a>
  800b36:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b39:	77 4b                	ja     800b86 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b3b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b3e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b41:	8b 45 18             	mov    0x18(%ebp),%eax
  800b44:	ba 00 00 00 00       	mov    $0x0,%edx
  800b49:	52                   	push   %edx
  800b4a:	50                   	push   %eax
  800b4b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4e:	ff 75 f0             	pushl  -0x10(%ebp)
  800b51:	e8 0e 15 00 00       	call   802064 <__udivdi3>
  800b56:	83 c4 10             	add    $0x10,%esp
  800b59:	83 ec 04             	sub    $0x4,%esp
  800b5c:	ff 75 20             	pushl  0x20(%ebp)
  800b5f:	53                   	push   %ebx
  800b60:	ff 75 18             	pushl  0x18(%ebp)
  800b63:	52                   	push   %edx
  800b64:	50                   	push   %eax
  800b65:	ff 75 0c             	pushl  0xc(%ebp)
  800b68:	ff 75 08             	pushl  0x8(%ebp)
  800b6b:	e8 a1 ff ff ff       	call   800b11 <printnum>
  800b70:	83 c4 20             	add    $0x20,%esp
  800b73:	eb 1a                	jmp    800b8f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b75:	83 ec 08             	sub    $0x8,%esp
  800b78:	ff 75 0c             	pushl  0xc(%ebp)
  800b7b:	ff 75 20             	pushl  0x20(%ebp)
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	ff d0                	call   *%eax
  800b83:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b86:	ff 4d 1c             	decl   0x1c(%ebp)
  800b89:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b8d:	7f e6                	jg     800b75 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b8f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b92:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b9d:	53                   	push   %ebx
  800b9e:	51                   	push   %ecx
  800b9f:	52                   	push   %edx
  800ba0:	50                   	push   %eax
  800ba1:	e8 ce 15 00 00       	call   802174 <__umoddi3>
  800ba6:	83 c4 10             	add    $0x10,%esp
  800ba9:	05 34 28 80 00       	add    $0x802834,%eax
  800bae:	8a 00                	mov    (%eax),%al
  800bb0:	0f be c0             	movsbl %al,%eax
  800bb3:	83 ec 08             	sub    $0x8,%esp
  800bb6:	ff 75 0c             	pushl  0xc(%ebp)
  800bb9:	50                   	push   %eax
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	ff d0                	call   *%eax
  800bbf:	83 c4 10             	add    $0x10,%esp
}
  800bc2:	90                   	nop
  800bc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bc6:	c9                   	leave  
  800bc7:	c3                   	ret    

00800bc8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bc8:	55                   	push   %ebp
  800bc9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bcb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bcf:	7e 1c                	jle    800bed <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	8d 50 08             	lea    0x8(%eax),%edx
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	89 10                	mov    %edx,(%eax)
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	8b 00                	mov    (%eax),%eax
  800be3:	83 e8 08             	sub    $0x8,%eax
  800be6:	8b 50 04             	mov    0x4(%eax),%edx
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	eb 40                	jmp    800c2d <getuint+0x65>
	else if (lflag)
  800bed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf1:	74 1e                	je     800c11 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	8b 00                	mov    (%eax),%eax
  800bf8:	8d 50 04             	lea    0x4(%eax),%edx
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	89 10                	mov    %edx,(%eax)
  800c00:	8b 45 08             	mov    0x8(%ebp),%eax
  800c03:	8b 00                	mov    (%eax),%eax
  800c05:	83 e8 04             	sub    $0x4,%eax
  800c08:	8b 00                	mov    (%eax),%eax
  800c0a:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0f:	eb 1c                	jmp    800c2d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8b 00                	mov    (%eax),%eax
  800c16:	8d 50 04             	lea    0x4(%eax),%edx
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	89 10                	mov    %edx,(%eax)
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	8b 00                	mov    (%eax),%eax
  800c23:	83 e8 04             	sub    $0x4,%eax
  800c26:	8b 00                	mov    (%eax),%eax
  800c28:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c2d:	5d                   	pop    %ebp
  800c2e:	c3                   	ret    

00800c2f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c32:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c36:	7e 1c                	jle    800c54 <getint+0x25>
		return va_arg(*ap, long long);
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	8b 00                	mov    (%eax),%eax
  800c3d:	8d 50 08             	lea    0x8(%eax),%edx
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	89 10                	mov    %edx,(%eax)
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	8b 00                	mov    (%eax),%eax
  800c4a:	83 e8 08             	sub    $0x8,%eax
  800c4d:	8b 50 04             	mov    0x4(%eax),%edx
  800c50:	8b 00                	mov    (%eax),%eax
  800c52:	eb 38                	jmp    800c8c <getint+0x5d>
	else if (lflag)
  800c54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c58:	74 1a                	je     800c74 <getint+0x45>
		return va_arg(*ap, long);
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8b 00                	mov    (%eax),%eax
  800c5f:	8d 50 04             	lea    0x4(%eax),%edx
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
  800c65:	89 10                	mov    %edx,(%eax)
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8b 00                	mov    (%eax),%eax
  800c6c:	83 e8 04             	sub    $0x4,%eax
  800c6f:	8b 00                	mov    (%eax),%eax
  800c71:	99                   	cltd   
  800c72:	eb 18                	jmp    800c8c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	8b 00                	mov    (%eax),%eax
  800c79:	8d 50 04             	lea    0x4(%eax),%edx
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	89 10                	mov    %edx,(%eax)
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8b 00                	mov    (%eax),%eax
  800c86:	83 e8 04             	sub    $0x4,%eax
  800c89:	8b 00                	mov    (%eax),%eax
  800c8b:	99                   	cltd   
}
  800c8c:	5d                   	pop    %ebp
  800c8d:	c3                   	ret    

00800c8e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c8e:	55                   	push   %ebp
  800c8f:	89 e5                	mov    %esp,%ebp
  800c91:	56                   	push   %esi
  800c92:	53                   	push   %ebx
  800c93:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c96:	eb 17                	jmp    800caf <vprintfmt+0x21>
			if (ch == '\0')
  800c98:	85 db                	test   %ebx,%ebx
  800c9a:	0f 84 af 03 00 00    	je     80104f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 0c             	pushl  0xc(%ebp)
  800ca6:	53                   	push   %ebx
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800caf:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb2:	8d 50 01             	lea    0x1(%eax),%edx
  800cb5:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	0f b6 d8             	movzbl %al,%ebx
  800cbd:	83 fb 25             	cmp    $0x25,%ebx
  800cc0:	75 d6                	jne    800c98 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cc2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cc6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ccd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cd4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cdb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ce2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce5:	8d 50 01             	lea    0x1(%eax),%edx
  800ce8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	0f b6 d8             	movzbl %al,%ebx
  800cf0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cf3:	83 f8 55             	cmp    $0x55,%eax
  800cf6:	0f 87 2b 03 00 00    	ja     801027 <vprintfmt+0x399>
  800cfc:	8b 04 85 58 28 80 00 	mov    0x802858(,%eax,4),%eax
  800d03:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d05:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d09:	eb d7                	jmp    800ce2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d0b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d0f:	eb d1                	jmp    800ce2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d11:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d18:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d1b:	89 d0                	mov    %edx,%eax
  800d1d:	c1 e0 02             	shl    $0x2,%eax
  800d20:	01 d0                	add    %edx,%eax
  800d22:	01 c0                	add    %eax,%eax
  800d24:	01 d8                	add    %ebx,%eax
  800d26:	83 e8 30             	sub    $0x30,%eax
  800d29:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d34:	83 fb 2f             	cmp    $0x2f,%ebx
  800d37:	7e 3e                	jle    800d77 <vprintfmt+0xe9>
  800d39:	83 fb 39             	cmp    $0x39,%ebx
  800d3c:	7f 39                	jg     800d77 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d3e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d41:	eb d5                	jmp    800d18 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d43:	8b 45 14             	mov    0x14(%ebp),%eax
  800d46:	83 c0 04             	add    $0x4,%eax
  800d49:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4f:	83 e8 04             	sub    $0x4,%eax
  800d52:	8b 00                	mov    (%eax),%eax
  800d54:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d57:	eb 1f                	jmp    800d78 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d59:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5d:	79 83                	jns    800ce2 <vprintfmt+0x54>
				width = 0;
  800d5f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d66:	e9 77 ff ff ff       	jmp    800ce2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d6b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d72:	e9 6b ff ff ff       	jmp    800ce2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d77:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7c:	0f 89 60 ff ff ff    	jns    800ce2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d82:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d88:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d8f:	e9 4e ff ff ff       	jmp    800ce2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d94:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d97:	e9 46 ff ff ff       	jmp    800ce2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9f:	83 c0 04             	add    $0x4,%eax
  800da2:	89 45 14             	mov    %eax,0x14(%ebp)
  800da5:	8b 45 14             	mov    0x14(%ebp),%eax
  800da8:	83 e8 04             	sub    $0x4,%eax
  800dab:	8b 00                	mov    (%eax),%eax
  800dad:	83 ec 08             	sub    $0x8,%esp
  800db0:	ff 75 0c             	pushl  0xc(%ebp)
  800db3:	50                   	push   %eax
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	ff d0                	call   *%eax
  800db9:	83 c4 10             	add    $0x10,%esp
			break;
  800dbc:	e9 89 02 00 00       	jmp    80104a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc4:	83 c0 04             	add    $0x4,%eax
  800dc7:	89 45 14             	mov    %eax,0x14(%ebp)
  800dca:	8b 45 14             	mov    0x14(%ebp),%eax
  800dcd:	83 e8 04             	sub    $0x4,%eax
  800dd0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dd2:	85 db                	test   %ebx,%ebx
  800dd4:	79 02                	jns    800dd8 <vprintfmt+0x14a>
				err = -err;
  800dd6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dd8:	83 fb 64             	cmp    $0x64,%ebx
  800ddb:	7f 0b                	jg     800de8 <vprintfmt+0x15a>
  800ddd:	8b 34 9d a0 26 80 00 	mov    0x8026a0(,%ebx,4),%esi
  800de4:	85 f6                	test   %esi,%esi
  800de6:	75 19                	jne    800e01 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800de8:	53                   	push   %ebx
  800de9:	68 45 28 80 00       	push   $0x802845
  800dee:	ff 75 0c             	pushl  0xc(%ebp)
  800df1:	ff 75 08             	pushl  0x8(%ebp)
  800df4:	e8 5e 02 00 00       	call   801057 <printfmt>
  800df9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dfc:	e9 49 02 00 00       	jmp    80104a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e01:	56                   	push   %esi
  800e02:	68 4e 28 80 00       	push   $0x80284e
  800e07:	ff 75 0c             	pushl  0xc(%ebp)
  800e0a:	ff 75 08             	pushl  0x8(%ebp)
  800e0d:	e8 45 02 00 00       	call   801057 <printfmt>
  800e12:	83 c4 10             	add    $0x10,%esp
			break;
  800e15:	e9 30 02 00 00       	jmp    80104a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1d:	83 c0 04             	add    $0x4,%eax
  800e20:	89 45 14             	mov    %eax,0x14(%ebp)
  800e23:	8b 45 14             	mov    0x14(%ebp),%eax
  800e26:	83 e8 04             	sub    $0x4,%eax
  800e29:	8b 30                	mov    (%eax),%esi
  800e2b:	85 f6                	test   %esi,%esi
  800e2d:	75 05                	jne    800e34 <vprintfmt+0x1a6>
				p = "(null)";
  800e2f:	be 51 28 80 00       	mov    $0x802851,%esi
			if (width > 0 && padc != '-')
  800e34:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e38:	7e 6d                	jle    800ea7 <vprintfmt+0x219>
  800e3a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e3e:	74 67                	je     800ea7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e40:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	50                   	push   %eax
  800e47:	56                   	push   %esi
  800e48:	e8 0c 03 00 00       	call   801159 <strnlen>
  800e4d:	83 c4 10             	add    $0x10,%esp
  800e50:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e53:	eb 16                	jmp    800e6b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e55:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e59:	83 ec 08             	sub    $0x8,%esp
  800e5c:	ff 75 0c             	pushl  0xc(%ebp)
  800e5f:	50                   	push   %eax
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	ff d0                	call   *%eax
  800e65:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e68:	ff 4d e4             	decl   -0x1c(%ebp)
  800e6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6f:	7f e4                	jg     800e55 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e71:	eb 34                	jmp    800ea7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e73:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e77:	74 1c                	je     800e95 <vprintfmt+0x207>
  800e79:	83 fb 1f             	cmp    $0x1f,%ebx
  800e7c:	7e 05                	jle    800e83 <vprintfmt+0x1f5>
  800e7e:	83 fb 7e             	cmp    $0x7e,%ebx
  800e81:	7e 12                	jle    800e95 <vprintfmt+0x207>
					putch('?', putdat);
  800e83:	83 ec 08             	sub    $0x8,%esp
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	6a 3f                	push   $0x3f
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	ff d0                	call   *%eax
  800e90:	83 c4 10             	add    $0x10,%esp
  800e93:	eb 0f                	jmp    800ea4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e95:	83 ec 08             	sub    $0x8,%esp
  800e98:	ff 75 0c             	pushl  0xc(%ebp)
  800e9b:	53                   	push   %ebx
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	ff d0                	call   *%eax
  800ea1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ea4:	ff 4d e4             	decl   -0x1c(%ebp)
  800ea7:	89 f0                	mov    %esi,%eax
  800ea9:	8d 70 01             	lea    0x1(%eax),%esi
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	0f be d8             	movsbl %al,%ebx
  800eb1:	85 db                	test   %ebx,%ebx
  800eb3:	74 24                	je     800ed9 <vprintfmt+0x24b>
  800eb5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb9:	78 b8                	js     800e73 <vprintfmt+0x1e5>
  800ebb:	ff 4d e0             	decl   -0x20(%ebp)
  800ebe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ec2:	79 af                	jns    800e73 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec4:	eb 13                	jmp    800ed9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ec6:	83 ec 08             	sub    $0x8,%esp
  800ec9:	ff 75 0c             	pushl  0xc(%ebp)
  800ecc:	6a 20                	push   $0x20
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	ff d0                	call   *%eax
  800ed3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ed6:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800edd:	7f e7                	jg     800ec6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800edf:	e9 66 01 00 00       	jmp    80104a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ee4:	83 ec 08             	sub    $0x8,%esp
  800ee7:	ff 75 e8             	pushl  -0x18(%ebp)
  800eea:	8d 45 14             	lea    0x14(%ebp),%eax
  800eed:	50                   	push   %eax
  800eee:	e8 3c fd ff ff       	call   800c2f <getint>
  800ef3:	83 c4 10             	add    $0x10,%esp
  800ef6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800efc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f02:	85 d2                	test   %edx,%edx
  800f04:	79 23                	jns    800f29 <vprintfmt+0x29b>
				putch('-', putdat);
  800f06:	83 ec 08             	sub    $0x8,%esp
  800f09:	ff 75 0c             	pushl  0xc(%ebp)
  800f0c:	6a 2d                	push   $0x2d
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	ff d0                	call   *%eax
  800f13:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1c:	f7 d8                	neg    %eax
  800f1e:	83 d2 00             	adc    $0x0,%edx
  800f21:	f7 da                	neg    %edx
  800f23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f26:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f29:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f30:	e9 bc 00 00 00       	jmp    800ff1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f35:	83 ec 08             	sub    $0x8,%esp
  800f38:	ff 75 e8             	pushl  -0x18(%ebp)
  800f3b:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3e:	50                   	push   %eax
  800f3f:	e8 84 fc ff ff       	call   800bc8 <getuint>
  800f44:	83 c4 10             	add    $0x10,%esp
  800f47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f4a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f4d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f54:	e9 98 00 00 00       	jmp    800ff1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f59:	83 ec 08             	sub    $0x8,%esp
  800f5c:	ff 75 0c             	pushl  0xc(%ebp)
  800f5f:	6a 58                	push   $0x58
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	ff d0                	call   *%eax
  800f66:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f69:	83 ec 08             	sub    $0x8,%esp
  800f6c:	ff 75 0c             	pushl  0xc(%ebp)
  800f6f:	6a 58                	push   $0x58
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	ff d0                	call   *%eax
  800f76:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f79:	83 ec 08             	sub    $0x8,%esp
  800f7c:	ff 75 0c             	pushl  0xc(%ebp)
  800f7f:	6a 58                	push   $0x58
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	ff d0                	call   *%eax
  800f86:	83 c4 10             	add    $0x10,%esp
			break;
  800f89:	e9 bc 00 00 00       	jmp    80104a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f8e:	83 ec 08             	sub    $0x8,%esp
  800f91:	ff 75 0c             	pushl  0xc(%ebp)
  800f94:	6a 30                	push   $0x30
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	ff d0                	call   *%eax
  800f9b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f9e:	83 ec 08             	sub    $0x8,%esp
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	6a 78                	push   $0x78
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	ff d0                	call   *%eax
  800fab:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fae:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb1:	83 c0 04             	add    $0x4,%eax
  800fb4:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800fba:	83 e8 04             	sub    $0x4,%eax
  800fbd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fc9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fd0:	eb 1f                	jmp    800ff1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fd2:	83 ec 08             	sub    $0x8,%esp
  800fd5:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd8:	8d 45 14             	lea    0x14(%ebp),%eax
  800fdb:	50                   	push   %eax
  800fdc:	e8 e7 fb ff ff       	call   800bc8 <getuint>
  800fe1:	83 c4 10             	add    $0x10,%esp
  800fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fea:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ff1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ff5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff8:	83 ec 04             	sub    $0x4,%esp
  800ffb:	52                   	push   %edx
  800ffc:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fff:	50                   	push   %eax
  801000:	ff 75 f4             	pushl  -0xc(%ebp)
  801003:	ff 75 f0             	pushl  -0x10(%ebp)
  801006:	ff 75 0c             	pushl  0xc(%ebp)
  801009:	ff 75 08             	pushl  0x8(%ebp)
  80100c:	e8 00 fb ff ff       	call   800b11 <printnum>
  801011:	83 c4 20             	add    $0x20,%esp
			break;
  801014:	eb 34                	jmp    80104a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801016:	83 ec 08             	sub    $0x8,%esp
  801019:	ff 75 0c             	pushl  0xc(%ebp)
  80101c:	53                   	push   %ebx
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	ff d0                	call   *%eax
  801022:	83 c4 10             	add    $0x10,%esp
			break;
  801025:	eb 23                	jmp    80104a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801027:	83 ec 08             	sub    $0x8,%esp
  80102a:	ff 75 0c             	pushl  0xc(%ebp)
  80102d:	6a 25                	push   $0x25
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	ff d0                	call   *%eax
  801034:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801037:	ff 4d 10             	decl   0x10(%ebp)
  80103a:	eb 03                	jmp    80103f <vprintfmt+0x3b1>
  80103c:	ff 4d 10             	decl   0x10(%ebp)
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	48                   	dec    %eax
  801043:	8a 00                	mov    (%eax),%al
  801045:	3c 25                	cmp    $0x25,%al
  801047:	75 f3                	jne    80103c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801049:	90                   	nop
		}
	}
  80104a:	e9 47 fc ff ff       	jmp    800c96 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80104f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801050:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801053:	5b                   	pop    %ebx
  801054:	5e                   	pop    %esi
  801055:	5d                   	pop    %ebp
  801056:	c3                   	ret    

00801057 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
  80105a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80105d:	8d 45 10             	lea    0x10(%ebp),%eax
  801060:	83 c0 04             	add    $0x4,%eax
  801063:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801066:	8b 45 10             	mov    0x10(%ebp),%eax
  801069:	ff 75 f4             	pushl  -0xc(%ebp)
  80106c:	50                   	push   %eax
  80106d:	ff 75 0c             	pushl  0xc(%ebp)
  801070:	ff 75 08             	pushl  0x8(%ebp)
  801073:	e8 16 fc ff ff       	call   800c8e <vprintfmt>
  801078:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80107b:	90                   	nop
  80107c:	c9                   	leave  
  80107d:	c3                   	ret    

0080107e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80107e:	55                   	push   %ebp
  80107f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	8b 40 08             	mov    0x8(%eax),%eax
  801087:	8d 50 01             	lea    0x1(%eax),%edx
  80108a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801090:	8b 45 0c             	mov    0xc(%ebp),%eax
  801093:	8b 10                	mov    (%eax),%edx
  801095:	8b 45 0c             	mov    0xc(%ebp),%eax
  801098:	8b 40 04             	mov    0x4(%eax),%eax
  80109b:	39 c2                	cmp    %eax,%edx
  80109d:	73 12                	jae    8010b1 <sprintputch+0x33>
		*b->buf++ = ch;
  80109f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a2:	8b 00                	mov    (%eax),%eax
  8010a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010aa:	89 0a                	mov    %ecx,(%edx)
  8010ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8010af:	88 10                	mov    %dl,(%eax)
}
  8010b1:	90                   	nop
  8010b2:	5d                   	pop    %ebp
  8010b3:	c3                   	ret    

008010b4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
  8010b7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	01 d0                	add    %edx,%eax
  8010cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d9:	74 06                	je     8010e1 <vsnprintf+0x2d>
  8010db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010df:	7f 07                	jg     8010e8 <vsnprintf+0x34>
		return -E_INVAL;
  8010e1:	b8 03 00 00 00       	mov    $0x3,%eax
  8010e6:	eb 20                	jmp    801108 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010e8:	ff 75 14             	pushl  0x14(%ebp)
  8010eb:	ff 75 10             	pushl  0x10(%ebp)
  8010ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010f1:	50                   	push   %eax
  8010f2:	68 7e 10 80 00       	push   $0x80107e
  8010f7:	e8 92 fb ff ff       	call   800c8e <vprintfmt>
  8010fc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801102:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801105:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801108:	c9                   	leave  
  801109:	c3                   	ret    

0080110a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80110a:	55                   	push   %ebp
  80110b:	89 e5                	mov    %esp,%ebp
  80110d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801110:	8d 45 10             	lea    0x10(%ebp),%eax
  801113:	83 c0 04             	add    $0x4,%eax
  801116:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801119:	8b 45 10             	mov    0x10(%ebp),%eax
  80111c:	ff 75 f4             	pushl  -0xc(%ebp)
  80111f:	50                   	push   %eax
  801120:	ff 75 0c             	pushl  0xc(%ebp)
  801123:	ff 75 08             	pushl  0x8(%ebp)
  801126:	e8 89 ff ff ff       	call   8010b4 <vsnprintf>
  80112b:	83 c4 10             	add    $0x10,%esp
  80112e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801131:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
  801139:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80113c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801143:	eb 06                	jmp    80114b <strlen+0x15>
		n++;
  801145:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801148:	ff 45 08             	incl   0x8(%ebp)
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	84 c0                	test   %al,%al
  801152:	75 f1                	jne    801145 <strlen+0xf>
		n++;
	return n;
  801154:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
  80115c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80115f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801166:	eb 09                	jmp    801171 <strnlen+0x18>
		n++;
  801168:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80116b:	ff 45 08             	incl   0x8(%ebp)
  80116e:	ff 4d 0c             	decl   0xc(%ebp)
  801171:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801175:	74 09                	je     801180 <strnlen+0x27>
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
  80117a:	8a 00                	mov    (%eax),%al
  80117c:	84 c0                	test   %al,%al
  80117e:	75 e8                	jne    801168 <strnlen+0xf>
		n++;
	return n;
  801180:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801183:	c9                   	leave  
  801184:	c3                   	ret    

00801185 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801185:	55                   	push   %ebp
  801186:	89 e5                	mov    %esp,%ebp
  801188:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801191:	90                   	nop
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8d 50 01             	lea    0x1(%eax),%edx
  801198:	89 55 08             	mov    %edx,0x8(%ebp)
  80119b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80119e:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011a1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011a4:	8a 12                	mov    (%edx),%dl
  8011a6:	88 10                	mov    %dl,(%eax)
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	84 c0                	test   %al,%al
  8011ac:	75 e4                	jne    801192 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011b1:	c9                   	leave  
  8011b2:	c3                   	ret    

008011b3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011b3:	55                   	push   %ebp
  8011b4:	89 e5                	mov    %esp,%ebp
  8011b6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011c6:	eb 1f                	jmp    8011e7 <strncpy+0x34>
		*dst++ = *src;
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8d 50 01             	lea    0x1(%eax),%edx
  8011ce:	89 55 08             	mov    %edx,0x8(%ebp)
  8011d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011d4:	8a 12                	mov    (%edx),%dl
  8011d6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	84 c0                	test   %al,%al
  8011df:	74 03                	je     8011e4 <strncpy+0x31>
			src++;
  8011e1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8011e4:	ff 45 fc             	incl   -0x4(%ebp)
  8011e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ea:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ed:	72 d9                	jb     8011c8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801200:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801204:	74 30                	je     801236 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801206:	eb 16                	jmp    80121e <strlcpy+0x2a>
			*dst++ = *src++;
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8d 50 01             	lea    0x1(%eax),%edx
  80120e:	89 55 08             	mov    %edx,0x8(%ebp)
  801211:	8b 55 0c             	mov    0xc(%ebp),%edx
  801214:	8d 4a 01             	lea    0x1(%edx),%ecx
  801217:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80121a:	8a 12                	mov    (%edx),%dl
  80121c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80121e:	ff 4d 10             	decl   0x10(%ebp)
  801221:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801225:	74 09                	je     801230 <strlcpy+0x3c>
  801227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122a:	8a 00                	mov    (%eax),%al
  80122c:	84 c0                	test   %al,%al
  80122e:	75 d8                	jne    801208 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801236:	8b 55 08             	mov    0x8(%ebp),%edx
  801239:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123c:	29 c2                	sub    %eax,%edx
  80123e:	89 d0                	mov    %edx,%eax
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801245:	eb 06                	jmp    80124d <strcmp+0xb>
		p++, q++;
  801247:	ff 45 08             	incl   0x8(%ebp)
  80124a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	84 c0                	test   %al,%al
  801254:	74 0e                	je     801264 <strcmp+0x22>
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 10                	mov    (%eax),%dl
  80125b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125e:	8a 00                	mov    (%eax),%al
  801260:	38 c2                	cmp    %al,%dl
  801262:	74 e3                	je     801247 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8a 00                	mov    (%eax),%al
  801269:	0f b6 d0             	movzbl %al,%edx
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	8a 00                	mov    (%eax),%al
  801271:	0f b6 c0             	movzbl %al,%eax
  801274:	29 c2                	sub    %eax,%edx
  801276:	89 d0                	mov    %edx,%eax
}
  801278:	5d                   	pop    %ebp
  801279:	c3                   	ret    

0080127a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80127a:	55                   	push   %ebp
  80127b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80127d:	eb 09                	jmp    801288 <strncmp+0xe>
		n--, p++, q++;
  80127f:	ff 4d 10             	decl   0x10(%ebp)
  801282:	ff 45 08             	incl   0x8(%ebp)
  801285:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801288:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128c:	74 17                	je     8012a5 <strncmp+0x2b>
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8a 00                	mov    (%eax),%al
  801293:	84 c0                	test   %al,%al
  801295:	74 0e                	je     8012a5 <strncmp+0x2b>
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 10                	mov    (%eax),%dl
  80129c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129f:	8a 00                	mov    (%eax),%al
  8012a1:	38 c2                	cmp    %al,%dl
  8012a3:	74 da                	je     80127f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012a9:	75 07                	jne    8012b2 <strncmp+0x38>
		return 0;
  8012ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8012b0:	eb 14                	jmp    8012c6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	0f b6 d0             	movzbl %al,%edx
  8012ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bd:	8a 00                	mov    (%eax),%al
  8012bf:	0f b6 c0             	movzbl %al,%eax
  8012c2:	29 c2                	sub    %eax,%edx
  8012c4:	89 d0                	mov    %edx,%eax
}
  8012c6:	5d                   	pop    %ebp
  8012c7:	c3                   	ret    

008012c8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
  8012cb:	83 ec 04             	sub    $0x4,%esp
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012d4:	eb 12                	jmp    8012e8 <strchr+0x20>
		if (*s == c)
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012de:	75 05                	jne    8012e5 <strchr+0x1d>
			return (char *) s;
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	eb 11                	jmp    8012f6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8012e5:	ff 45 08             	incl   0x8(%ebp)
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	84 c0                	test   %al,%al
  8012ef:	75 e5                	jne    8012d6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
  8012fb:	83 ec 04             	sub    $0x4,%esp
  8012fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801301:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801304:	eb 0d                	jmp    801313 <strfind+0x1b>
		if (*s == c)
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80130e:	74 0e                	je     80131e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801310:	ff 45 08             	incl   0x8(%ebp)
  801313:	8b 45 08             	mov    0x8(%ebp),%eax
  801316:	8a 00                	mov    (%eax),%al
  801318:	84 c0                	test   %al,%al
  80131a:	75 ea                	jne    801306 <strfind+0xe>
  80131c:	eb 01                	jmp    80131f <strfind+0x27>
		if (*s == c)
			break;
  80131e:	90                   	nop
	return (char *) s;
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
  801327:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801330:	8b 45 10             	mov    0x10(%ebp),%eax
  801333:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801336:	eb 0e                	jmp    801346 <memset+0x22>
		*p++ = c;
  801338:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133b:	8d 50 01             	lea    0x1(%eax),%edx
  80133e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801341:	8b 55 0c             	mov    0xc(%ebp),%edx
  801344:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801346:	ff 4d f8             	decl   -0x8(%ebp)
  801349:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80134d:	79 e9                	jns    801338 <memset+0x14>
		*p++ = c;

	return v;
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801352:	c9                   	leave  
  801353:	c3                   	ret    

00801354 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801354:	55                   	push   %ebp
  801355:	89 e5                	mov    %esp,%ebp
  801357:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80135a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801366:	eb 16                	jmp    80137e <memcpy+0x2a>
		*d++ = *s++;
  801368:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80136b:	8d 50 01             	lea    0x1(%eax),%edx
  80136e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801371:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801374:	8d 4a 01             	lea    0x1(%edx),%ecx
  801377:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80137a:	8a 12                	mov    (%edx),%dl
  80137c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80137e:	8b 45 10             	mov    0x10(%ebp),%eax
  801381:	8d 50 ff             	lea    -0x1(%eax),%edx
  801384:	89 55 10             	mov    %edx,0x10(%ebp)
  801387:	85 c0                	test   %eax,%eax
  801389:	75 dd                	jne    801368 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
  801393:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801396:	8b 45 0c             	mov    0xc(%ebp),%eax
  801399:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013a8:	73 50                	jae    8013fa <memmove+0x6a>
  8013aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b0:	01 d0                	add    %edx,%eax
  8013b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013b5:	76 43                	jbe    8013fa <memmove+0x6a>
		s += n;
  8013b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ba:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013c3:	eb 10                	jmp    8013d5 <memmove+0x45>
			*--d = *--s;
  8013c5:	ff 4d f8             	decl   -0x8(%ebp)
  8013c8:	ff 4d fc             	decl   -0x4(%ebp)
  8013cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ce:	8a 10                	mov    (%eax),%dl
  8013d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013db:	89 55 10             	mov    %edx,0x10(%ebp)
  8013de:	85 c0                	test   %eax,%eax
  8013e0:	75 e3                	jne    8013c5 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013e2:	eb 23                	jmp    801407 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8013e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e7:	8d 50 01             	lea    0x1(%eax),%edx
  8013ea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013f3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013f6:	8a 12                	mov    (%edx),%dl
  8013f8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801400:	89 55 10             	mov    %edx,0x10(%ebp)
  801403:	85 c0                	test   %eax,%eax
  801405:	75 dd                	jne    8013e4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
  80140f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801418:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80141e:	eb 2a                	jmp    80144a <memcmp+0x3e>
		if (*s1 != *s2)
  801420:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801423:	8a 10                	mov    (%eax),%dl
  801425:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801428:	8a 00                	mov    (%eax),%al
  80142a:	38 c2                	cmp    %al,%dl
  80142c:	74 16                	je     801444 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80142e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	0f b6 d0             	movzbl %al,%edx
  801436:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801439:	8a 00                	mov    (%eax),%al
  80143b:	0f b6 c0             	movzbl %al,%eax
  80143e:	29 c2                	sub    %eax,%edx
  801440:	89 d0                	mov    %edx,%eax
  801442:	eb 18                	jmp    80145c <memcmp+0x50>
		s1++, s2++;
  801444:	ff 45 fc             	incl   -0x4(%ebp)
  801447:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80144a:	8b 45 10             	mov    0x10(%ebp),%eax
  80144d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801450:	89 55 10             	mov    %edx,0x10(%ebp)
  801453:	85 c0                	test   %eax,%eax
  801455:	75 c9                	jne    801420 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801457:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
  801461:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801464:	8b 55 08             	mov    0x8(%ebp),%edx
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	01 d0                	add    %edx,%eax
  80146c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80146f:	eb 15                	jmp    801486 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f b6 d0             	movzbl %al,%edx
  801479:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147c:	0f b6 c0             	movzbl %al,%eax
  80147f:	39 c2                	cmp    %eax,%edx
  801481:	74 0d                	je     801490 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801483:	ff 45 08             	incl   0x8(%ebp)
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80148c:	72 e3                	jb     801471 <memfind+0x13>
  80148e:	eb 01                	jmp    801491 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801490:	90                   	nop
	return (void *) s;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
  801499:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80149c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014aa:	eb 03                	jmp    8014af <strtol+0x19>
		s++;
  8014ac:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	8a 00                	mov    (%eax),%al
  8014b4:	3c 20                	cmp    $0x20,%al
  8014b6:	74 f4                	je     8014ac <strtol+0x16>
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	3c 09                	cmp    $0x9,%al
  8014bf:	74 eb                	je     8014ac <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	3c 2b                	cmp    $0x2b,%al
  8014c8:	75 05                	jne    8014cf <strtol+0x39>
		s++;
  8014ca:	ff 45 08             	incl   0x8(%ebp)
  8014cd:	eb 13                	jmp    8014e2 <strtol+0x4c>
	else if (*s == '-')
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	8a 00                	mov    (%eax),%al
  8014d4:	3c 2d                	cmp    $0x2d,%al
  8014d6:	75 0a                	jne    8014e2 <strtol+0x4c>
		s++, neg = 1;
  8014d8:	ff 45 08             	incl   0x8(%ebp)
  8014db:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e6:	74 06                	je     8014ee <strtol+0x58>
  8014e8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014ec:	75 20                	jne    80150e <strtol+0x78>
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	8a 00                	mov    (%eax),%al
  8014f3:	3c 30                	cmp    $0x30,%al
  8014f5:	75 17                	jne    80150e <strtol+0x78>
  8014f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fa:	40                   	inc    %eax
  8014fb:	8a 00                	mov    (%eax),%al
  8014fd:	3c 78                	cmp    $0x78,%al
  8014ff:	75 0d                	jne    80150e <strtol+0x78>
		s += 2, base = 16;
  801501:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801505:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80150c:	eb 28                	jmp    801536 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80150e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801512:	75 15                	jne    801529 <strtol+0x93>
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	8a 00                	mov    (%eax),%al
  801519:	3c 30                	cmp    $0x30,%al
  80151b:	75 0c                	jne    801529 <strtol+0x93>
		s++, base = 8;
  80151d:	ff 45 08             	incl   0x8(%ebp)
  801520:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801527:	eb 0d                	jmp    801536 <strtol+0xa0>
	else if (base == 0)
  801529:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80152d:	75 07                	jne    801536 <strtol+0xa0>
		base = 10;
  80152f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	8a 00                	mov    (%eax),%al
  80153b:	3c 2f                	cmp    $0x2f,%al
  80153d:	7e 19                	jle    801558 <strtol+0xc2>
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	3c 39                	cmp    $0x39,%al
  801546:	7f 10                	jg     801558 <strtol+0xc2>
			dig = *s - '0';
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	8a 00                	mov    (%eax),%al
  80154d:	0f be c0             	movsbl %al,%eax
  801550:	83 e8 30             	sub    $0x30,%eax
  801553:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801556:	eb 42                	jmp    80159a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	8a 00                	mov    (%eax),%al
  80155d:	3c 60                	cmp    $0x60,%al
  80155f:	7e 19                	jle    80157a <strtol+0xe4>
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
  801564:	8a 00                	mov    (%eax),%al
  801566:	3c 7a                	cmp    $0x7a,%al
  801568:	7f 10                	jg     80157a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	8a 00                	mov    (%eax),%al
  80156f:	0f be c0             	movsbl %al,%eax
  801572:	83 e8 57             	sub    $0x57,%eax
  801575:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801578:	eb 20                	jmp    80159a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80157a:	8b 45 08             	mov    0x8(%ebp),%eax
  80157d:	8a 00                	mov    (%eax),%al
  80157f:	3c 40                	cmp    $0x40,%al
  801581:	7e 39                	jle    8015bc <strtol+0x126>
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	8a 00                	mov    (%eax),%al
  801588:	3c 5a                	cmp    $0x5a,%al
  80158a:	7f 30                	jg     8015bc <strtol+0x126>
			dig = *s - 'A' + 10;
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	0f be c0             	movsbl %al,%eax
  801594:	83 e8 37             	sub    $0x37,%eax
  801597:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159d:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015a0:	7d 19                	jge    8015bb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015a2:	ff 45 08             	incl   0x8(%ebp)
  8015a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a8:	0f af 45 10          	imul   0x10(%ebp),%eax
  8015ac:	89 c2                	mov    %eax,%edx
  8015ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015b1:	01 d0                	add    %edx,%eax
  8015b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015b6:	e9 7b ff ff ff       	jmp    801536 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015bb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015c0:	74 08                	je     8015ca <strtol+0x134>
		*endptr = (char *) s;
  8015c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015ca:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015ce:	74 07                	je     8015d7 <strtol+0x141>
  8015d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d3:	f7 d8                	neg    %eax
  8015d5:	eb 03                	jmp    8015da <strtol+0x144>
  8015d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <ltostr>:

void
ltostr(long value, char *str)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
  8015df:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015f4:	79 13                	jns    801609 <ltostr+0x2d>
	{
		neg = 1;
  8015f6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801600:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801603:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801606:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801611:	99                   	cltd   
  801612:	f7 f9                	idiv   %ecx
  801614:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801617:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161a:	8d 50 01             	lea    0x1(%eax),%edx
  80161d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801620:	89 c2                	mov    %eax,%edx
  801622:	8b 45 0c             	mov    0xc(%ebp),%eax
  801625:	01 d0                	add    %edx,%eax
  801627:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80162a:	83 c2 30             	add    $0x30,%edx
  80162d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80162f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801632:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801637:	f7 e9                	imul   %ecx
  801639:	c1 fa 02             	sar    $0x2,%edx
  80163c:	89 c8                	mov    %ecx,%eax
  80163e:	c1 f8 1f             	sar    $0x1f,%eax
  801641:	29 c2                	sub    %eax,%edx
  801643:	89 d0                	mov    %edx,%eax
  801645:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801648:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80164b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801650:	f7 e9                	imul   %ecx
  801652:	c1 fa 02             	sar    $0x2,%edx
  801655:	89 c8                	mov    %ecx,%eax
  801657:	c1 f8 1f             	sar    $0x1f,%eax
  80165a:	29 c2                	sub    %eax,%edx
  80165c:	89 d0                	mov    %edx,%eax
  80165e:	c1 e0 02             	shl    $0x2,%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	01 c0                	add    %eax,%eax
  801665:	29 c1                	sub    %eax,%ecx
  801667:	89 ca                	mov    %ecx,%edx
  801669:	85 d2                	test   %edx,%edx
  80166b:	75 9c                	jne    801609 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80166d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801674:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801677:	48                   	dec    %eax
  801678:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80167b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80167f:	74 3d                	je     8016be <ltostr+0xe2>
		start = 1 ;
  801681:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801688:	eb 34                	jmp    8016be <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80168a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801690:	01 d0                	add    %edx,%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801697:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80169a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80169d:	01 c2                	add    %eax,%edx
  80169f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a5:	01 c8                	add    %ecx,%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8016ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b1:	01 c2                	add    %eax,%edx
  8016b3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016b6:	88 02                	mov    %al,(%edx)
		start++ ;
  8016b8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016bb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016c4:	7c c4                	jl     80168a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cc:	01 d0                	add    %edx,%eax
  8016ce:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016d1:	90                   	nop
  8016d2:	c9                   	leave  
  8016d3:	c3                   	ret    

008016d4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
  8016d7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016da:	ff 75 08             	pushl  0x8(%ebp)
  8016dd:	e8 54 fa ff ff       	call   801136 <strlen>
  8016e2:	83 c4 04             	add    $0x4,%esp
  8016e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016e8:	ff 75 0c             	pushl  0xc(%ebp)
  8016eb:	e8 46 fa ff ff       	call   801136 <strlen>
  8016f0:	83 c4 04             	add    $0x4,%esp
  8016f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801704:	eb 17                	jmp    80171d <strcconcat+0x49>
		final[s] = str1[s] ;
  801706:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801709:	8b 45 10             	mov    0x10(%ebp),%eax
  80170c:	01 c2                	add    %eax,%edx
  80170e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	01 c8                	add    %ecx,%eax
  801716:	8a 00                	mov    (%eax),%al
  801718:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80171a:	ff 45 fc             	incl   -0x4(%ebp)
  80171d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801720:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801723:	7c e1                	jl     801706 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801725:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80172c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801733:	eb 1f                	jmp    801754 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801735:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801738:	8d 50 01             	lea    0x1(%eax),%edx
  80173b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80173e:	89 c2                	mov    %eax,%edx
  801740:	8b 45 10             	mov    0x10(%ebp),%eax
  801743:	01 c2                	add    %eax,%edx
  801745:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801748:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174b:	01 c8                	add    %ecx,%eax
  80174d:	8a 00                	mov    (%eax),%al
  80174f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801751:	ff 45 f8             	incl   -0x8(%ebp)
  801754:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801757:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80175a:	7c d9                	jl     801735 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80175c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80175f:	8b 45 10             	mov    0x10(%ebp),%eax
  801762:	01 d0                	add    %edx,%eax
  801764:	c6 00 00             	movb   $0x0,(%eax)
}
  801767:	90                   	nop
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80176d:	8b 45 14             	mov    0x14(%ebp),%eax
  801770:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801776:	8b 45 14             	mov    0x14(%ebp),%eax
  801779:	8b 00                	mov    (%eax),%eax
  80177b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801782:	8b 45 10             	mov    0x10(%ebp),%eax
  801785:	01 d0                	add    %edx,%eax
  801787:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80178d:	eb 0c                	jmp    80179b <strsplit+0x31>
			*string++ = 0;
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	8d 50 01             	lea    0x1(%eax),%edx
  801795:	89 55 08             	mov    %edx,0x8(%ebp)
  801798:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	8a 00                	mov    (%eax),%al
  8017a0:	84 c0                	test   %al,%al
  8017a2:	74 18                	je     8017bc <strsplit+0x52>
  8017a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a7:	8a 00                	mov    (%eax),%al
  8017a9:	0f be c0             	movsbl %al,%eax
  8017ac:	50                   	push   %eax
  8017ad:	ff 75 0c             	pushl  0xc(%ebp)
  8017b0:	e8 13 fb ff ff       	call   8012c8 <strchr>
  8017b5:	83 c4 08             	add    $0x8,%esp
  8017b8:	85 c0                	test   %eax,%eax
  8017ba:	75 d3                	jne    80178f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	84 c0                	test   %al,%al
  8017c3:	74 5a                	je     80181f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8017c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8017c8:	8b 00                	mov    (%eax),%eax
  8017ca:	83 f8 0f             	cmp    $0xf,%eax
  8017cd:	75 07                	jne    8017d6 <strsplit+0x6c>
		{
			return 0;
  8017cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8017d4:	eb 66                	jmp    80183c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8017d9:	8b 00                	mov    (%eax),%eax
  8017db:	8d 48 01             	lea    0x1(%eax),%ecx
  8017de:	8b 55 14             	mov    0x14(%ebp),%edx
  8017e1:	89 0a                	mov    %ecx,(%edx)
  8017e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ed:	01 c2                	add    %eax,%edx
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017f4:	eb 03                	jmp    8017f9 <strsplit+0x8f>
			string++;
  8017f6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fc:	8a 00                	mov    (%eax),%al
  8017fe:	84 c0                	test   %al,%al
  801800:	74 8b                	je     80178d <strsplit+0x23>
  801802:	8b 45 08             	mov    0x8(%ebp),%eax
  801805:	8a 00                	mov    (%eax),%al
  801807:	0f be c0             	movsbl %al,%eax
  80180a:	50                   	push   %eax
  80180b:	ff 75 0c             	pushl  0xc(%ebp)
  80180e:	e8 b5 fa ff ff       	call   8012c8 <strchr>
  801813:	83 c4 08             	add    $0x8,%esp
  801816:	85 c0                	test   %eax,%eax
  801818:	74 dc                	je     8017f6 <strsplit+0x8c>
			string++;
	}
  80181a:	e9 6e ff ff ff       	jmp    80178d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80181f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801820:	8b 45 14             	mov    0x14(%ebp),%eax
  801823:	8b 00                	mov    (%eax),%eax
  801825:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80182c:	8b 45 10             	mov    0x10(%ebp),%eax
  80182f:	01 d0                	add    %edx,%eax
  801831:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801837:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
  801841:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801844:	e8 9b 07 00 00       	call   801fe4 <sys_isUHeapPlacementStrategyNEXTFIT>
  801849:	85 c0                	test   %eax,%eax
  80184b:	0f 84 64 01 00 00    	je     8019b5 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801851:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801857:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  80185e:	8b 55 08             	mov    0x8(%ebp),%edx
  801861:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801864:	01 d0                	add    %edx,%eax
  801866:	48                   	dec    %eax
  801867:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80186a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80186d:	ba 00 00 00 00       	mov    $0x0,%edx
  801872:	f7 75 e8             	divl   -0x18(%ebp)
  801875:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801878:	29 d0                	sub    %edx,%eax
  80187a:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801881:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801887:	8b 45 08             	mov    0x8(%ebp),%eax
  80188a:	01 d0                	add    %edx,%eax
  80188c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  80188f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801896:	a1 28 30 80 00       	mov    0x803028,%eax
  80189b:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8018a2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8018a5:	0f 83 0a 01 00 00    	jae    8019b5 <malloc+0x177>
  8018ab:	a1 28 30 80 00       	mov    0x803028,%eax
  8018b0:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8018b7:	85 c0                	test   %eax,%eax
  8018b9:	0f 84 f6 00 00 00    	je     8019b5 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8018bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018c6:	e9 dc 00 00 00       	jmp    8019a7 <malloc+0x169>
				flag++;
  8018cb:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8018ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d1:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8018d8:	85 c0                	test   %eax,%eax
  8018da:	74 07                	je     8018e3 <malloc+0xa5>
					flag=0;
  8018dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8018e3:	a1 28 30 80 00       	mov    0x803028,%eax
  8018e8:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8018ef:	85 c0                	test   %eax,%eax
  8018f1:	79 05                	jns    8018f8 <malloc+0xba>
  8018f3:	05 ff 0f 00 00       	add    $0xfff,%eax
  8018f8:	c1 f8 0c             	sar    $0xc,%eax
  8018fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018fe:	0f 85 a0 00 00 00    	jne    8019a4 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801904:	a1 28 30 80 00       	mov    0x803028,%eax
  801909:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801910:	85 c0                	test   %eax,%eax
  801912:	79 05                	jns    801919 <malloc+0xdb>
  801914:	05 ff 0f 00 00       	add    $0xfff,%eax
  801919:	c1 f8 0c             	sar    $0xc,%eax
  80191c:	89 c2                	mov    %eax,%edx
  80191e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801921:	29 d0                	sub    %edx,%eax
  801923:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801926:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801929:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80192c:	eb 11                	jmp    80193f <malloc+0x101>
						hFreeArr[j] = 1;
  80192e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801931:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801938:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  80193c:	ff 45 ec             	incl   -0x14(%ebp)
  80193f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801942:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801945:	7e e7                	jle    80192e <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801947:	a1 28 30 80 00       	mov    0x803028,%eax
  80194c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80194f:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801955:	c1 e2 0c             	shl    $0xc,%edx
  801958:	89 15 04 30 80 00    	mov    %edx,0x803004
  80195e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801964:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  80196b:	a1 28 30 80 00       	mov    0x803028,%eax
  801970:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801977:	89 c2                	mov    %eax,%edx
  801979:	a1 28 30 80 00       	mov    0x803028,%eax
  80197e:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801985:	83 ec 08             	sub    $0x8,%esp
  801988:	52                   	push   %edx
  801989:	50                   	push   %eax
  80198a:	e8 8b 02 00 00       	call   801c1a <sys_allocateMem>
  80198f:	83 c4 10             	add    $0x10,%esp

					idx++;
  801992:	a1 28 30 80 00       	mov    0x803028,%eax
  801997:	40                   	inc    %eax
  801998:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  80199d:	a1 04 30 80 00       	mov    0x803004,%eax
  8019a2:	eb 16                	jmp    8019ba <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8019a4:	ff 45 f0             	incl   -0x10(%ebp)
  8019a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019aa:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8019af:	0f 86 16 ff ff ff    	jbe    8018cb <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  8019b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
  8019bf:	83 ec 18             	sub    $0x18,%esp
  8019c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019c5:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8019c8:	83 ec 04             	sub    $0x4,%esp
  8019cb:	68 b0 29 80 00       	push   $0x8029b0
  8019d0:	6a 59                	push   $0x59
  8019d2:	68 cf 29 80 00       	push   $0x8029cf
  8019d7:	e8 24 ee ff ff       	call   800800 <_panic>

008019dc <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
  8019df:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8019e2:	83 ec 04             	sub    $0x4,%esp
  8019e5:	68 db 29 80 00       	push   $0x8029db
  8019ea:	6a 5f                	push   $0x5f
  8019ec:	68 cf 29 80 00       	push   $0x8029cf
  8019f1:	e8 0a ee ff ff       	call   800800 <_panic>

008019f6 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
  8019f9:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8019fc:	83 ec 04             	sub    $0x4,%esp
  8019ff:	68 f8 29 80 00       	push   $0x8029f8
  801a04:	6a 70                	push   $0x70
  801a06:	68 cf 29 80 00       	push   $0x8029cf
  801a0b:	e8 f0 ed ff ff       	call   800800 <_panic>

00801a10 <sfree>:

}


void sfree(void* virtual_address)
{
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
  801a13:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801a16:	83 ec 04             	sub    $0x4,%esp
  801a19:	68 1b 2a 80 00       	push   $0x802a1b
  801a1e:	6a 7b                	push   $0x7b
  801a20:	68 cf 29 80 00       	push   $0x8029cf
  801a25:	e8 d6 ed ff ff       	call   800800 <_panic>

00801a2a <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801a30:	83 ec 04             	sub    $0x4,%esp
  801a33:	68 38 2a 80 00       	push   $0x802a38
  801a38:	68 93 00 00 00       	push   $0x93
  801a3d:	68 cf 29 80 00       	push   $0x8029cf
  801a42:	e8 b9 ed ff ff       	call   800800 <_panic>

00801a47 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
  801a4a:	57                   	push   %edi
  801a4b:	56                   	push   %esi
  801a4c:	53                   	push   %ebx
  801a4d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a56:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a59:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a5f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a62:	cd 30                	int    $0x30
  801a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a6a:	83 c4 10             	add    $0x10,%esp
  801a6d:	5b                   	pop    %ebx
  801a6e:	5e                   	pop    %esi
  801a6f:	5f                   	pop    %edi
  801a70:	5d                   	pop    %ebp
  801a71:	c3                   	ret    

00801a72 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a72:	55                   	push   %ebp
  801a73:	89 e5                	mov    %esp,%ebp
  801a75:	83 ec 04             	sub    $0x4,%esp
  801a78:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a7e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	52                   	push   %edx
  801a8a:	ff 75 0c             	pushl  0xc(%ebp)
  801a8d:	50                   	push   %eax
  801a8e:	6a 00                	push   $0x0
  801a90:	e8 b2 ff ff ff       	call   801a47 <syscall>
  801a95:	83 c4 18             	add    $0x18,%esp
}
  801a98:	90                   	nop
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <sys_cgetc>:

int
sys_cgetc(void)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 01                	push   $0x1
  801aaa:	e8 98 ff ff ff       	call   801a47 <syscall>
  801aaf:	83 c4 18             	add    $0x18,%esp
}
  801ab2:	c9                   	leave  
  801ab3:	c3                   	ret    

00801ab4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	50                   	push   %eax
  801ac3:	6a 05                	push   $0x5
  801ac5:	e8 7d ff ff ff       	call   801a47 <syscall>
  801aca:	83 c4 18             	add    $0x18,%esp
}
  801acd:	c9                   	leave  
  801ace:	c3                   	ret    

00801acf <sys_getenvid>:

int32 sys_getenvid(void)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 02                	push   $0x2
  801ade:	e8 64 ff ff ff       	call   801a47 <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	c9                   	leave  
  801ae7:	c3                   	ret    

00801ae8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 03                	push   $0x3
  801af7:	e8 4b ff ff ff       	call   801a47 <syscall>
  801afc:	83 c4 18             	add    $0x18,%esp
}
  801aff:	c9                   	leave  
  801b00:	c3                   	ret    

00801b01 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b01:	55                   	push   %ebp
  801b02:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 04                	push   $0x4
  801b10:	e8 32 ff ff ff       	call   801a47 <syscall>
  801b15:	83 c4 18             	add    $0x18,%esp
}
  801b18:	c9                   	leave  
  801b19:	c3                   	ret    

00801b1a <sys_env_exit>:


void sys_env_exit(void)
{
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 06                	push   $0x6
  801b29:	e8 19 ff ff ff       	call   801a47 <syscall>
  801b2e:	83 c4 18             	add    $0x18,%esp
}
  801b31:	90                   	nop
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b37:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	52                   	push   %edx
  801b44:	50                   	push   %eax
  801b45:	6a 07                	push   $0x7
  801b47:	e8 fb fe ff ff       	call   801a47 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
  801b54:	56                   	push   %esi
  801b55:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b56:	8b 75 18             	mov    0x18(%ebp),%esi
  801b59:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b62:	8b 45 08             	mov    0x8(%ebp),%eax
  801b65:	56                   	push   %esi
  801b66:	53                   	push   %ebx
  801b67:	51                   	push   %ecx
  801b68:	52                   	push   %edx
  801b69:	50                   	push   %eax
  801b6a:	6a 08                	push   $0x8
  801b6c:	e8 d6 fe ff ff       	call   801a47 <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
}
  801b74:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b77:	5b                   	pop    %ebx
  801b78:	5e                   	pop    %esi
  801b79:	5d                   	pop    %ebp
  801b7a:	c3                   	ret    

00801b7b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b81:	8b 45 08             	mov    0x8(%ebp),%eax
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	52                   	push   %edx
  801b8b:	50                   	push   %eax
  801b8c:	6a 09                	push   $0x9
  801b8e:	e8 b4 fe ff ff       	call   801a47 <syscall>
  801b93:	83 c4 18             	add    $0x18,%esp
}
  801b96:	c9                   	leave  
  801b97:	c3                   	ret    

00801b98 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b98:	55                   	push   %ebp
  801b99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	ff 75 0c             	pushl  0xc(%ebp)
  801ba4:	ff 75 08             	pushl  0x8(%ebp)
  801ba7:	6a 0a                	push   $0xa
  801ba9:	e8 99 fe ff ff       	call   801a47 <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 0b                	push   $0xb
  801bc2:	e8 80 fe ff ff       	call   801a47 <syscall>
  801bc7:	83 c4 18             	add    $0x18,%esp
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 0c                	push   $0xc
  801bdb:	e8 67 fe ff ff       	call   801a47 <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 0d                	push   $0xd
  801bf4:	e8 4e fe ff ff       	call   801a47 <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
}
  801bfc:	c9                   	leave  
  801bfd:	c3                   	ret    

00801bfe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	ff 75 0c             	pushl  0xc(%ebp)
  801c0a:	ff 75 08             	pushl  0x8(%ebp)
  801c0d:	6a 11                	push   $0x11
  801c0f:	e8 33 fe ff ff       	call   801a47 <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
	return;
  801c17:	90                   	nop
}
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	ff 75 0c             	pushl  0xc(%ebp)
  801c26:	ff 75 08             	pushl  0x8(%ebp)
  801c29:	6a 12                	push   $0x12
  801c2b:	e8 17 fe ff ff       	call   801a47 <syscall>
  801c30:	83 c4 18             	add    $0x18,%esp
	return ;
  801c33:	90                   	nop
}
  801c34:	c9                   	leave  
  801c35:	c3                   	ret    

00801c36 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 0e                	push   $0xe
  801c45:	e8 fd fd ff ff       	call   801a47 <syscall>
  801c4a:	83 c4 18             	add    $0x18,%esp
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	ff 75 08             	pushl  0x8(%ebp)
  801c5d:	6a 0f                	push   $0xf
  801c5f:	e8 e3 fd ff ff       	call   801a47 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 10                	push   $0x10
  801c78:	e8 ca fd ff ff       	call   801a47 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	90                   	nop
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 14                	push   $0x14
  801c92:	e8 b0 fd ff ff       	call   801a47 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
}
  801c9a:	90                   	nop
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 15                	push   $0x15
  801cac:	e8 96 fd ff ff       	call   801a47 <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	90                   	nop
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <sys_cputc>:


void
sys_cputc(const char c)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
  801cba:	83 ec 04             	sub    $0x4,%esp
  801cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cc3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	50                   	push   %eax
  801cd0:	6a 16                	push   $0x16
  801cd2:	e8 70 fd ff ff       	call   801a47 <syscall>
  801cd7:	83 c4 18             	add    $0x18,%esp
}
  801cda:	90                   	nop
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 17                	push   $0x17
  801cec:	e8 56 fd ff ff       	call   801a47 <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	90                   	nop
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	ff 75 0c             	pushl  0xc(%ebp)
  801d06:	50                   	push   %eax
  801d07:	6a 18                	push   $0x18
  801d09:	e8 39 fd ff ff       	call   801a47 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d19:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	52                   	push   %edx
  801d23:	50                   	push   %eax
  801d24:	6a 1b                	push   $0x1b
  801d26:	e8 1c fd ff ff       	call   801a47 <syscall>
  801d2b:	83 c4 18             	add    $0x18,%esp
}
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d36:	8b 45 08             	mov    0x8(%ebp),%eax
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	52                   	push   %edx
  801d40:	50                   	push   %eax
  801d41:	6a 19                	push   $0x19
  801d43:	e8 ff fc ff ff       	call   801a47 <syscall>
  801d48:	83 c4 18             	add    $0x18,%esp
}
  801d4b:	90                   	nop
  801d4c:	c9                   	leave  
  801d4d:	c3                   	ret    

00801d4e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d4e:	55                   	push   %ebp
  801d4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d54:	8b 45 08             	mov    0x8(%ebp),%eax
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	52                   	push   %edx
  801d5e:	50                   	push   %eax
  801d5f:	6a 1a                	push   $0x1a
  801d61:	e8 e1 fc ff ff       	call   801a47 <syscall>
  801d66:	83 c4 18             	add    $0x18,%esp
}
  801d69:	90                   	nop
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
  801d6f:	83 ec 04             	sub    $0x4,%esp
  801d72:	8b 45 10             	mov    0x10(%ebp),%eax
  801d75:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d78:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d7b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d82:	6a 00                	push   $0x0
  801d84:	51                   	push   %ecx
  801d85:	52                   	push   %edx
  801d86:	ff 75 0c             	pushl  0xc(%ebp)
  801d89:	50                   	push   %eax
  801d8a:	6a 1c                	push   $0x1c
  801d8c:	e8 b6 fc ff ff       	call   801a47 <syscall>
  801d91:	83 c4 18             	add    $0x18,%esp
}
  801d94:	c9                   	leave  
  801d95:	c3                   	ret    

00801d96 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d96:	55                   	push   %ebp
  801d97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	52                   	push   %edx
  801da6:	50                   	push   %eax
  801da7:	6a 1d                	push   $0x1d
  801da9:	e8 99 fc ff ff       	call   801a47 <syscall>
  801dae:	83 c4 18             	add    $0x18,%esp
}
  801db1:	c9                   	leave  
  801db2:	c3                   	ret    

00801db3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801db3:	55                   	push   %ebp
  801db4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801db6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801db9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	51                   	push   %ecx
  801dc4:	52                   	push   %edx
  801dc5:	50                   	push   %eax
  801dc6:	6a 1e                	push   $0x1e
  801dc8:	e8 7a fc ff ff       	call   801a47 <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
}
  801dd0:	c9                   	leave  
  801dd1:	c3                   	ret    

00801dd2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dd2:	55                   	push   %ebp
  801dd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	52                   	push   %edx
  801de2:	50                   	push   %eax
  801de3:	6a 1f                	push   $0x1f
  801de5:	e8 5d fc ff ff       	call   801a47 <syscall>
  801dea:	83 c4 18             	add    $0x18,%esp
}
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 20                	push   $0x20
  801dfe:	e8 44 fc ff ff       	call   801a47 <syscall>
  801e03:	83 c4 18             	add    $0x18,%esp
}
  801e06:	c9                   	leave  
  801e07:	c3                   	ret    

00801e08 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e08:	55                   	push   %ebp
  801e09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	ff 75 10             	pushl  0x10(%ebp)
  801e15:	ff 75 0c             	pushl  0xc(%ebp)
  801e18:	50                   	push   %eax
  801e19:	6a 21                	push   $0x21
  801e1b:	e8 27 fc ff ff       	call   801a47 <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
}
  801e23:	c9                   	leave  
  801e24:	c3                   	ret    

00801e25 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e28:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	50                   	push   %eax
  801e34:	6a 22                	push   $0x22
  801e36:	e8 0c fc ff ff       	call   801a47 <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	90                   	nop
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e44:	8b 45 08             	mov    0x8(%ebp),%eax
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	50                   	push   %eax
  801e50:	6a 23                	push   $0x23
  801e52:	e8 f0 fb ff ff       	call   801a47 <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	90                   	nop
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    

00801e5d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
  801e60:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e63:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e66:	8d 50 04             	lea    0x4(%eax),%edx
  801e69:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	52                   	push   %edx
  801e73:	50                   	push   %eax
  801e74:	6a 24                	push   $0x24
  801e76:	e8 cc fb ff ff       	call   801a47 <syscall>
  801e7b:	83 c4 18             	add    $0x18,%esp
	return result;
  801e7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e87:	89 01                	mov    %eax,(%ecx)
  801e89:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8f:	c9                   	leave  
  801e90:	c2 04 00             	ret    $0x4

00801e93 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e93:	55                   	push   %ebp
  801e94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	ff 75 10             	pushl  0x10(%ebp)
  801e9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ea0:	ff 75 08             	pushl  0x8(%ebp)
  801ea3:	6a 13                	push   $0x13
  801ea5:	e8 9d fb ff ff       	call   801a47 <syscall>
  801eaa:	83 c4 18             	add    $0x18,%esp
	return ;
  801ead:	90                   	nop
}
  801eae:	c9                   	leave  
  801eaf:	c3                   	ret    

00801eb0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801eb0:	55                   	push   %ebp
  801eb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 25                	push   $0x25
  801ebf:	e8 83 fb ff ff       	call   801a47 <syscall>
  801ec4:	83 c4 18             	add    $0x18,%esp
}
  801ec7:	c9                   	leave  
  801ec8:	c3                   	ret    

00801ec9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ec9:	55                   	push   %ebp
  801eca:	89 e5                	mov    %esp,%ebp
  801ecc:	83 ec 04             	sub    $0x4,%esp
  801ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ed5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	50                   	push   %eax
  801ee2:	6a 26                	push   $0x26
  801ee4:	e8 5e fb ff ff       	call   801a47 <syscall>
  801ee9:	83 c4 18             	add    $0x18,%esp
	return ;
  801eec:	90                   	nop
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <rsttst>:
void rsttst()
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 28                	push   $0x28
  801efe:	e8 44 fb ff ff       	call   801a47 <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
	return ;
  801f06:	90                   	nop
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
  801f0c:	83 ec 04             	sub    $0x4,%esp
  801f0f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f15:	8b 55 18             	mov    0x18(%ebp),%edx
  801f18:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1c:	52                   	push   %edx
  801f1d:	50                   	push   %eax
  801f1e:	ff 75 10             	pushl  0x10(%ebp)
  801f21:	ff 75 0c             	pushl  0xc(%ebp)
  801f24:	ff 75 08             	pushl  0x8(%ebp)
  801f27:	6a 27                	push   $0x27
  801f29:	e8 19 fb ff ff       	call   801a47 <syscall>
  801f2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f31:	90                   	nop
}
  801f32:	c9                   	leave  
  801f33:	c3                   	ret    

00801f34 <chktst>:
void chktst(uint32 n)
{
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	ff 75 08             	pushl  0x8(%ebp)
  801f42:	6a 29                	push   $0x29
  801f44:	e8 fe fa ff ff       	call   801a47 <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4c:	90                   	nop
}
  801f4d:	c9                   	leave  
  801f4e:	c3                   	ret    

00801f4f <inctst>:

void inctst()
{
  801f4f:	55                   	push   %ebp
  801f50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 2a                	push   $0x2a
  801f5e:	e8 e4 fa ff ff       	call   801a47 <syscall>
  801f63:	83 c4 18             	add    $0x18,%esp
	return ;
  801f66:	90                   	nop
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <gettst>:
uint32 gettst()
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 2b                	push   $0x2b
  801f78:	e8 ca fa ff ff       	call   801a47 <syscall>
  801f7d:	83 c4 18             	add    $0x18,%esp
}
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
  801f85:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 2c                	push   $0x2c
  801f94:	e8 ae fa ff ff       	call   801a47 <syscall>
  801f99:	83 c4 18             	add    $0x18,%esp
  801f9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f9f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fa3:	75 07                	jne    801fac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fa5:	b8 01 00 00 00       	mov    $0x1,%eax
  801faa:	eb 05                	jmp    801fb1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb1:	c9                   	leave  
  801fb2:	c3                   	ret    

00801fb3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
  801fb6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 2c                	push   $0x2c
  801fc5:	e8 7d fa ff ff       	call   801a47 <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
  801fcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fd0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fd4:	75 07                	jne    801fdd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fd6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fdb:	eb 05                	jmp    801fe2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fe2:	c9                   	leave  
  801fe3:	c3                   	ret    

00801fe4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fe4:	55                   	push   %ebp
  801fe5:	89 e5                	mov    %esp,%ebp
  801fe7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 2c                	push   $0x2c
  801ff6:	e8 4c fa ff ff       	call   801a47 <syscall>
  801ffb:	83 c4 18             	add    $0x18,%esp
  801ffe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802001:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802005:	75 07                	jne    80200e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802007:	b8 01 00 00 00       	mov    $0x1,%eax
  80200c:	eb 05                	jmp    802013 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80200e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 2c                	push   $0x2c
  802027:	e8 1b fa ff ff       	call   801a47 <syscall>
  80202c:	83 c4 18             	add    $0x18,%esp
  80202f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802032:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802036:	75 07                	jne    80203f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802038:	b8 01 00 00 00       	mov    $0x1,%eax
  80203d:	eb 05                	jmp    802044 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80203f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802044:	c9                   	leave  
  802045:	c3                   	ret    

00802046 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	ff 75 08             	pushl  0x8(%ebp)
  802054:	6a 2d                	push   $0x2d
  802056:	e8 ec f9 ff ff       	call   801a47 <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
	return ;
  80205e:	90                   	nop
}
  80205f:	c9                   	leave  
  802060:	c3                   	ret    
  802061:	66 90                	xchg   %ax,%ax
  802063:	90                   	nop

00802064 <__udivdi3>:
  802064:	55                   	push   %ebp
  802065:	57                   	push   %edi
  802066:	56                   	push   %esi
  802067:	53                   	push   %ebx
  802068:	83 ec 1c             	sub    $0x1c,%esp
  80206b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80206f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802073:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802077:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80207b:	89 ca                	mov    %ecx,%edx
  80207d:	89 f8                	mov    %edi,%eax
  80207f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802083:	85 f6                	test   %esi,%esi
  802085:	75 2d                	jne    8020b4 <__udivdi3+0x50>
  802087:	39 cf                	cmp    %ecx,%edi
  802089:	77 65                	ja     8020f0 <__udivdi3+0x8c>
  80208b:	89 fd                	mov    %edi,%ebp
  80208d:	85 ff                	test   %edi,%edi
  80208f:	75 0b                	jne    80209c <__udivdi3+0x38>
  802091:	b8 01 00 00 00       	mov    $0x1,%eax
  802096:	31 d2                	xor    %edx,%edx
  802098:	f7 f7                	div    %edi
  80209a:	89 c5                	mov    %eax,%ebp
  80209c:	31 d2                	xor    %edx,%edx
  80209e:	89 c8                	mov    %ecx,%eax
  8020a0:	f7 f5                	div    %ebp
  8020a2:	89 c1                	mov    %eax,%ecx
  8020a4:	89 d8                	mov    %ebx,%eax
  8020a6:	f7 f5                	div    %ebp
  8020a8:	89 cf                	mov    %ecx,%edi
  8020aa:	89 fa                	mov    %edi,%edx
  8020ac:	83 c4 1c             	add    $0x1c,%esp
  8020af:	5b                   	pop    %ebx
  8020b0:	5e                   	pop    %esi
  8020b1:	5f                   	pop    %edi
  8020b2:	5d                   	pop    %ebp
  8020b3:	c3                   	ret    
  8020b4:	39 ce                	cmp    %ecx,%esi
  8020b6:	77 28                	ja     8020e0 <__udivdi3+0x7c>
  8020b8:	0f bd fe             	bsr    %esi,%edi
  8020bb:	83 f7 1f             	xor    $0x1f,%edi
  8020be:	75 40                	jne    802100 <__udivdi3+0x9c>
  8020c0:	39 ce                	cmp    %ecx,%esi
  8020c2:	72 0a                	jb     8020ce <__udivdi3+0x6a>
  8020c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020c8:	0f 87 9e 00 00 00    	ja     80216c <__udivdi3+0x108>
  8020ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8020d3:	89 fa                	mov    %edi,%edx
  8020d5:	83 c4 1c             	add    $0x1c,%esp
  8020d8:	5b                   	pop    %ebx
  8020d9:	5e                   	pop    %esi
  8020da:	5f                   	pop    %edi
  8020db:	5d                   	pop    %ebp
  8020dc:	c3                   	ret    
  8020dd:	8d 76 00             	lea    0x0(%esi),%esi
  8020e0:	31 ff                	xor    %edi,%edi
  8020e2:	31 c0                	xor    %eax,%eax
  8020e4:	89 fa                	mov    %edi,%edx
  8020e6:	83 c4 1c             	add    $0x1c,%esp
  8020e9:	5b                   	pop    %ebx
  8020ea:	5e                   	pop    %esi
  8020eb:	5f                   	pop    %edi
  8020ec:	5d                   	pop    %ebp
  8020ed:	c3                   	ret    
  8020ee:	66 90                	xchg   %ax,%ax
  8020f0:	89 d8                	mov    %ebx,%eax
  8020f2:	f7 f7                	div    %edi
  8020f4:	31 ff                	xor    %edi,%edi
  8020f6:	89 fa                	mov    %edi,%edx
  8020f8:	83 c4 1c             	add    $0x1c,%esp
  8020fb:	5b                   	pop    %ebx
  8020fc:	5e                   	pop    %esi
  8020fd:	5f                   	pop    %edi
  8020fe:	5d                   	pop    %ebp
  8020ff:	c3                   	ret    
  802100:	bd 20 00 00 00       	mov    $0x20,%ebp
  802105:	89 eb                	mov    %ebp,%ebx
  802107:	29 fb                	sub    %edi,%ebx
  802109:	89 f9                	mov    %edi,%ecx
  80210b:	d3 e6                	shl    %cl,%esi
  80210d:	89 c5                	mov    %eax,%ebp
  80210f:	88 d9                	mov    %bl,%cl
  802111:	d3 ed                	shr    %cl,%ebp
  802113:	89 e9                	mov    %ebp,%ecx
  802115:	09 f1                	or     %esi,%ecx
  802117:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80211b:	89 f9                	mov    %edi,%ecx
  80211d:	d3 e0                	shl    %cl,%eax
  80211f:	89 c5                	mov    %eax,%ebp
  802121:	89 d6                	mov    %edx,%esi
  802123:	88 d9                	mov    %bl,%cl
  802125:	d3 ee                	shr    %cl,%esi
  802127:	89 f9                	mov    %edi,%ecx
  802129:	d3 e2                	shl    %cl,%edx
  80212b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80212f:	88 d9                	mov    %bl,%cl
  802131:	d3 e8                	shr    %cl,%eax
  802133:	09 c2                	or     %eax,%edx
  802135:	89 d0                	mov    %edx,%eax
  802137:	89 f2                	mov    %esi,%edx
  802139:	f7 74 24 0c          	divl   0xc(%esp)
  80213d:	89 d6                	mov    %edx,%esi
  80213f:	89 c3                	mov    %eax,%ebx
  802141:	f7 e5                	mul    %ebp
  802143:	39 d6                	cmp    %edx,%esi
  802145:	72 19                	jb     802160 <__udivdi3+0xfc>
  802147:	74 0b                	je     802154 <__udivdi3+0xf0>
  802149:	89 d8                	mov    %ebx,%eax
  80214b:	31 ff                	xor    %edi,%edi
  80214d:	e9 58 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  802152:	66 90                	xchg   %ax,%ax
  802154:	8b 54 24 08          	mov    0x8(%esp),%edx
  802158:	89 f9                	mov    %edi,%ecx
  80215a:	d3 e2                	shl    %cl,%edx
  80215c:	39 c2                	cmp    %eax,%edx
  80215e:	73 e9                	jae    802149 <__udivdi3+0xe5>
  802160:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802163:	31 ff                	xor    %edi,%edi
  802165:	e9 40 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  80216a:	66 90                	xchg   %ax,%ax
  80216c:	31 c0                	xor    %eax,%eax
  80216e:	e9 37 ff ff ff       	jmp    8020aa <__udivdi3+0x46>
  802173:	90                   	nop

00802174 <__umoddi3>:
  802174:	55                   	push   %ebp
  802175:	57                   	push   %edi
  802176:	56                   	push   %esi
  802177:	53                   	push   %ebx
  802178:	83 ec 1c             	sub    $0x1c,%esp
  80217b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80217f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802183:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802187:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80218b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80218f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802193:	89 f3                	mov    %esi,%ebx
  802195:	89 fa                	mov    %edi,%edx
  802197:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80219b:	89 34 24             	mov    %esi,(%esp)
  80219e:	85 c0                	test   %eax,%eax
  8021a0:	75 1a                	jne    8021bc <__umoddi3+0x48>
  8021a2:	39 f7                	cmp    %esi,%edi
  8021a4:	0f 86 a2 00 00 00    	jbe    80224c <__umoddi3+0xd8>
  8021aa:	89 c8                	mov    %ecx,%eax
  8021ac:	89 f2                	mov    %esi,%edx
  8021ae:	f7 f7                	div    %edi
  8021b0:	89 d0                	mov    %edx,%eax
  8021b2:	31 d2                	xor    %edx,%edx
  8021b4:	83 c4 1c             	add    $0x1c,%esp
  8021b7:	5b                   	pop    %ebx
  8021b8:	5e                   	pop    %esi
  8021b9:	5f                   	pop    %edi
  8021ba:	5d                   	pop    %ebp
  8021bb:	c3                   	ret    
  8021bc:	39 f0                	cmp    %esi,%eax
  8021be:	0f 87 ac 00 00 00    	ja     802270 <__umoddi3+0xfc>
  8021c4:	0f bd e8             	bsr    %eax,%ebp
  8021c7:	83 f5 1f             	xor    $0x1f,%ebp
  8021ca:	0f 84 ac 00 00 00    	je     80227c <__umoddi3+0x108>
  8021d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8021d5:	29 ef                	sub    %ebp,%edi
  8021d7:	89 fe                	mov    %edi,%esi
  8021d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021dd:	89 e9                	mov    %ebp,%ecx
  8021df:	d3 e0                	shl    %cl,%eax
  8021e1:	89 d7                	mov    %edx,%edi
  8021e3:	89 f1                	mov    %esi,%ecx
  8021e5:	d3 ef                	shr    %cl,%edi
  8021e7:	09 c7                	or     %eax,%edi
  8021e9:	89 e9                	mov    %ebp,%ecx
  8021eb:	d3 e2                	shl    %cl,%edx
  8021ed:	89 14 24             	mov    %edx,(%esp)
  8021f0:	89 d8                	mov    %ebx,%eax
  8021f2:	d3 e0                	shl    %cl,%eax
  8021f4:	89 c2                	mov    %eax,%edx
  8021f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021fa:	d3 e0                	shl    %cl,%eax
  8021fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802200:	8b 44 24 08          	mov    0x8(%esp),%eax
  802204:	89 f1                	mov    %esi,%ecx
  802206:	d3 e8                	shr    %cl,%eax
  802208:	09 d0                	or     %edx,%eax
  80220a:	d3 eb                	shr    %cl,%ebx
  80220c:	89 da                	mov    %ebx,%edx
  80220e:	f7 f7                	div    %edi
  802210:	89 d3                	mov    %edx,%ebx
  802212:	f7 24 24             	mull   (%esp)
  802215:	89 c6                	mov    %eax,%esi
  802217:	89 d1                	mov    %edx,%ecx
  802219:	39 d3                	cmp    %edx,%ebx
  80221b:	0f 82 87 00 00 00    	jb     8022a8 <__umoddi3+0x134>
  802221:	0f 84 91 00 00 00    	je     8022b8 <__umoddi3+0x144>
  802227:	8b 54 24 04          	mov    0x4(%esp),%edx
  80222b:	29 f2                	sub    %esi,%edx
  80222d:	19 cb                	sbb    %ecx,%ebx
  80222f:	89 d8                	mov    %ebx,%eax
  802231:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802235:	d3 e0                	shl    %cl,%eax
  802237:	89 e9                	mov    %ebp,%ecx
  802239:	d3 ea                	shr    %cl,%edx
  80223b:	09 d0                	or     %edx,%eax
  80223d:	89 e9                	mov    %ebp,%ecx
  80223f:	d3 eb                	shr    %cl,%ebx
  802241:	89 da                	mov    %ebx,%edx
  802243:	83 c4 1c             	add    $0x1c,%esp
  802246:	5b                   	pop    %ebx
  802247:	5e                   	pop    %esi
  802248:	5f                   	pop    %edi
  802249:	5d                   	pop    %ebp
  80224a:	c3                   	ret    
  80224b:	90                   	nop
  80224c:	89 fd                	mov    %edi,%ebp
  80224e:	85 ff                	test   %edi,%edi
  802250:	75 0b                	jne    80225d <__umoddi3+0xe9>
  802252:	b8 01 00 00 00       	mov    $0x1,%eax
  802257:	31 d2                	xor    %edx,%edx
  802259:	f7 f7                	div    %edi
  80225b:	89 c5                	mov    %eax,%ebp
  80225d:	89 f0                	mov    %esi,%eax
  80225f:	31 d2                	xor    %edx,%edx
  802261:	f7 f5                	div    %ebp
  802263:	89 c8                	mov    %ecx,%eax
  802265:	f7 f5                	div    %ebp
  802267:	89 d0                	mov    %edx,%eax
  802269:	e9 44 ff ff ff       	jmp    8021b2 <__umoddi3+0x3e>
  80226e:	66 90                	xchg   %ax,%ax
  802270:	89 c8                	mov    %ecx,%eax
  802272:	89 f2                	mov    %esi,%edx
  802274:	83 c4 1c             	add    $0x1c,%esp
  802277:	5b                   	pop    %ebx
  802278:	5e                   	pop    %esi
  802279:	5f                   	pop    %edi
  80227a:	5d                   	pop    %ebp
  80227b:	c3                   	ret    
  80227c:	3b 04 24             	cmp    (%esp),%eax
  80227f:	72 06                	jb     802287 <__umoddi3+0x113>
  802281:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802285:	77 0f                	ja     802296 <__umoddi3+0x122>
  802287:	89 f2                	mov    %esi,%edx
  802289:	29 f9                	sub    %edi,%ecx
  80228b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80228f:	89 14 24             	mov    %edx,(%esp)
  802292:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802296:	8b 44 24 04          	mov    0x4(%esp),%eax
  80229a:	8b 14 24             	mov    (%esp),%edx
  80229d:	83 c4 1c             	add    $0x1c,%esp
  8022a0:	5b                   	pop    %ebx
  8022a1:	5e                   	pop    %esi
  8022a2:	5f                   	pop    %edi
  8022a3:	5d                   	pop    %ebp
  8022a4:	c3                   	ret    
  8022a5:	8d 76 00             	lea    0x0(%esi),%esi
  8022a8:	2b 04 24             	sub    (%esp),%eax
  8022ab:	19 fa                	sbb    %edi,%edx
  8022ad:	89 d1                	mov    %edx,%ecx
  8022af:	89 c6                	mov    %eax,%esi
  8022b1:	e9 71 ff ff ff       	jmp    802227 <__umoddi3+0xb3>
  8022b6:	66 90                	xchg   %ax,%ax
  8022b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022bc:	72 ea                	jb     8022a8 <__umoddi3+0x134>
  8022be:	89 d9                	mov    %ebx,%ecx
  8022c0:	e9 62 ff ff ff       	jmp    802227 <__umoddi3+0xb3>
