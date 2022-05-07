
obj/user/tst_best_fit_2:     file format elf32-i386


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
  800031:	e8 a5 08 00 00       	call   8008db <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 e6 21 00 00       	call   802230 <sys_set_uheap_strategy>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

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
  80009b:	68 c0 24 80 00       	push   $0x8024c0
  8000a0:	6a 1b                	push   $0x1b
  8000a2:	68 dc 24 80 00       	push   $0x8024dc
  8000a7:	e8 3e 09 00 00       	call   8009ea <_panic>
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
  8000d3:	e8 50 19 00 00       	call   801a28 <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000de:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e1:	85 c0                	test   %eax,%eax
  8000e3:	74 14                	je     8000f9 <_main+0xc1>
  8000e5:	83 ec 04             	sub    $0x4,%esp
  8000e8:	68 f4 24 80 00       	push   $0x8024f4
  8000ed:	6a 25                	push   $0x25
  8000ef:	68 dc 24 80 00       	push   $0x8024dc
  8000f4:	e8 f1 08 00 00       	call   8009ea <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 9f 1c 00 00       	call   801d9d <sys_calculate_free_frames>
  8000fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800101:	e8 1a 1d 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800106:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	50                   	push   %eax
  800115:	e8 0e 19 00 00       	call   801a28 <malloc>
  80011a:	83 c4 10             	add    $0x10,%esp
  80011d:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START) ) panic("Wrong start address for the allocated space... ");
  800120:	8b 45 90             	mov    -0x70(%ebp),%eax
  800123:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800128:	74 14                	je     80013e <_main+0x106>
  80012a:	83 ec 04             	sub    $0x4,%esp
  80012d:	68 38 25 80 00       	push   $0x802538
  800132:	6a 2e                	push   $0x2e
  800134:	68 dc 24 80 00       	push   $0x8024dc
  800139:	e8 ac 08 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013e:	e8 dd 1c 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800143:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800146:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 68 25 80 00       	push   $0x802568
  800155:	6a 30                	push   $0x30
  800157:	68 dc 24 80 00       	push   $0x8024dc
  80015c:	e8 89 08 00 00       	call   8009ea <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800161:	e8 37 1c 00 00       	call   801d9d <sys_calculate_free_frames>
  800166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800169:	e8 b2 1c 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80016e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800171:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800174:	01 c0                	add    %eax,%eax
  800176:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	50                   	push   %eax
  80017d:	e8 a6 18 00 00       	call   801a28 <malloc>
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
  80019e:	68 38 25 80 00       	push   $0x802538
  8001a3:	6a 36                	push   $0x36
  8001a5:	68 dc 24 80 00       	push   $0x8024dc
  8001aa:	e8 3b 08 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001af:	e8 6c 1c 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8001b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 68 25 80 00       	push   $0x802568
  8001c6:	6a 38                	push   $0x38
  8001c8:	68 dc 24 80 00       	push   $0x8024dc
  8001cd:	e8 18 08 00 00       	call   8009ea <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d2:	e8 c6 1b 00 00       	call   801d9d <sys_calculate_free_frames>
  8001d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001da:	e8 41 1c 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8001df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	50                   	push   %eax
  8001eb:	e8 38 18 00 00       	call   801a28 <malloc>
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
  80020d:	68 38 25 80 00       	push   $0x802538
  800212:	6a 3e                	push   $0x3e
  800214:	68 dc 24 80 00       	push   $0x8024dc
  800219:	e8 cc 07 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021e:	e8 fd 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800223:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800226:	83 f8 01             	cmp    $0x1,%eax
  800229:	74 14                	je     80023f <_main+0x207>
  80022b:	83 ec 04             	sub    $0x4,%esp
  80022e:	68 68 25 80 00       	push   $0x802568
  800233:	6a 40                	push   $0x40
  800235:	68 dc 24 80 00       	push   $0x8024dc
  80023a:	e8 ab 07 00 00       	call   8009ea <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80023f:	e8 59 1b 00 00       	call   801d9d <sys_calculate_free_frames>
  800244:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800247:	e8 d4 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80024c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  80024f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800252:	01 c0                	add    %eax,%eax
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	50                   	push   %eax
  800258:	e8 cb 17 00 00       	call   801a28 <malloc>
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
  800284:	68 38 25 80 00       	push   $0x802538
  800289:	6a 46                	push   $0x46
  80028b:	68 dc 24 80 00       	push   $0x8024dc
  800290:	e8 55 07 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800295:	e8 86 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80029a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029d:	83 f8 01             	cmp    $0x1,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 68 25 80 00       	push   $0x802568
  8002aa:	6a 48                	push   $0x48
  8002ac:	68 dc 24 80 00       	push   $0x8024dc
  8002b1:	e8 34 07 00 00       	call   8009ea <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 e2 1a 00 00       	call   801d9d <sys_calculate_free_frames>
  8002bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002be:	e8 5d 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 0e 19 00 00       	call   801be0 <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d5:	e8 46 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	29 c2                	sub    %eax,%edx
  8002df:	89 d0                	mov    %edx,%eax
  8002e1:	83 f8 01             	cmp    $0x1,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 85 25 80 00       	push   $0x802585
  8002ee:	6a 4f                	push   $0x4f
  8002f0:	68 dc 24 80 00       	push   $0x8024dc
  8002f5:	e8 f0 06 00 00       	call   8009ea <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 9e 1a 00 00       	call   801d9d <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800302:	e8 19 1b 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
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
  80031b:	e8 08 17 00 00       	call   801a28 <malloc>
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
  800347:	68 38 25 80 00       	push   $0x802538
  80034c:	6a 55                	push   $0x55
  80034e:	68 dc 24 80 00       	push   $0x8024dc
  800353:	e8 92 06 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800358:	e8 c3 1a 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80035d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800360:	83 f8 02             	cmp    $0x2,%eax
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 68 25 80 00       	push   $0x802568
  80036d:	6a 57                	push   $0x57
  80036f:	68 dc 24 80 00       	push   $0x8024dc
  800374:	e8 71 06 00 00       	call   8009ea <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800379:	e8 1f 1a 00 00       	call   801d9d <sys_calculate_free_frames>
  80037e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800381:	e8 9a 1a 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800389:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	50                   	push   %eax
  800390:	e8 4b 18 00 00       	call   801be0 <free>
  800395:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800398:	e8 83 1a 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80039d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a0:	29 c2                	sub    %eax,%edx
  8003a2:	89 d0                	mov    %edx,%eax
  8003a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a9:	74 14                	je     8003bf <_main+0x387>
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 85 25 80 00       	push   $0x802585
  8003b3:	6a 5e                	push   $0x5e
  8003b5:	68 dc 24 80 00       	push   $0x8024dc
  8003ba:	e8 2b 06 00 00       	call   8009ea <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 d9 19 00 00       	call   801d9d <sys_calculate_free_frames>
  8003c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c7:	e8 54 1a 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8003cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	01 d2                	add    %edx,%edx
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	50                   	push   %eax
  8003df:	e8 44 16 00 00       	call   801a28 <malloc>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  80040b:	68 38 25 80 00       	push   $0x802538
  800410:	6a 64                	push   $0x64
  800412:	68 dc 24 80 00       	push   $0x8024dc
  800417:	e8 ce 05 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041c:	e8 ff 19 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
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
  800442:	68 68 25 80 00       	push   $0x802568
  800447:	6a 66                	push   $0x66
  800449:	68 dc 24 80 00       	push   $0x8024dc
  80044e:	e8 97 05 00 00       	call   8009ea <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800453:	e8 45 19 00 00       	call   801d9d <sys_calculate_free_frames>
  800458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045b:	e8 c0 19 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
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
  800477:	e8 ac 15 00 00       	call   801a28 <malloc>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  8004aa:	68 38 25 80 00       	push   $0x802538
  8004af:	6a 6c                	push   $0x6c
  8004b1:	68 dc 24 80 00       	push   $0x8024dc
  8004b6:	e8 2f 05 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bb:	e8 60 19 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8004c0:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 68 25 80 00       	push   $0x802568
  8004d2:	6a 6e                	push   $0x6e
  8004d4:	68 dc 24 80 00       	push   $0x8024dc
  8004d9:	e8 0c 05 00 00       	call   8009ea <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 ba 18 00 00       	call   801d9d <sys_calculate_free_frames>
  8004e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 35 19 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004f1:	89 d0                	mov    %edx,%eax
  8004f3:	c1 e0 02             	shl    $0x2,%eax
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004fb:	83 ec 0c             	sub    $0xc,%esp
  8004fe:	50                   	push   %eax
  8004ff:	e8 24 15 00 00       	call   801a28 <malloc>
  800504:	83 c4 10             	add    $0x10,%esp
  800507:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  80050a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80050d:	89 c1                	mov    %eax,%ecx
  80050f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800512:	89 d0                	mov    %edx,%eax
  800514:	c1 e0 03             	shl    $0x3,%eax
  800517:	01 d0                	add    %edx,%eax
  800519:	89 c3                	mov    %eax,%ebx
  80051b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	01 c0                	add    %eax,%eax
  800522:	01 d0                	add    %edx,%eax
  800524:	c1 e0 03             	shl    $0x3,%eax
  800527:	01 d8                	add    %ebx,%eax
  800529:	05 00 00 00 80       	add    $0x80000000,%eax
  80052e:	39 c1                	cmp    %eax,%ecx
  800530:	74 14                	je     800546 <_main+0x50e>
  800532:	83 ec 04             	sub    $0x4,%esp
  800535:	68 38 25 80 00       	push   $0x802538
  80053a:	6a 74                	push   $0x74
  80053c:	68 dc 24 80 00       	push   $0x8024dc
  800541:	e8 a4 04 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  800546:	e8 d5 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80054b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80054e:	89 c1                	mov    %eax,%ecx
  800550:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800553:	89 d0                	mov    %edx,%eax
  800555:	c1 e0 02             	shl    $0x2,%eax
  800558:	01 d0                	add    %edx,%eax
  80055a:	85 c0                	test   %eax,%eax
  80055c:	79 05                	jns    800563 <_main+0x52b>
  80055e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800563:	c1 f8 0c             	sar    $0xc,%eax
  800566:	39 c1                	cmp    %eax,%ecx
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 68 25 80 00       	push   $0x802568
  800572:	6a 76                	push   $0x76
  800574:	68 dc 24 80 00       	push   $0x8024dc
  800579:	e8 6c 04 00 00       	call   8009ea <_panic>

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80057e:	e8 1a 18 00 00       	call   801d9d <sys_calculate_free_frames>
  800583:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800586:	e8 95 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80058b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  80058e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800591:	83 ec 0c             	sub    $0xc,%esp
  800594:	50                   	push   %eax
  800595:	e8 46 16 00 00       	call   801be0 <free>
  80059a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");
  80059d:	e8 7e 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8005a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a5:	29 c2                	sub    %eax,%edx
  8005a7:	89 d0                	mov    %edx,%eax
  8005a9:	3d 02 02 00 00       	cmp    $0x202,%eax
  8005ae:	74 14                	je     8005c4 <_main+0x58c>
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	68 85 25 80 00       	push   $0x802585
  8005b8:	6a 7d                	push   $0x7d
  8005ba:	68 dc 24 80 00       	push   $0x8024dc
  8005bf:	e8 26 04 00 00       	call   8009ea <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005c4:	e8 d4 17 00 00       	call   801d9d <sys_calculate_free_frames>
  8005c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005cc:	e8 4f 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8005d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005d4:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005d7:	83 ec 0c             	sub    $0xc,%esp
  8005da:	50                   	push   %eax
  8005db:	e8 00 16 00 00       	call   801be0 <free>
  8005e0:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  8005e3:	e8 38 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8005e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005eb:	29 c2                	sub    %eax,%edx
  8005ed:	89 d0                	mov    %edx,%eax
  8005ef:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005f4:	74 17                	je     80060d <_main+0x5d5>
  8005f6:	83 ec 04             	sub    $0x4,%esp
  8005f9:	68 85 25 80 00       	push   $0x802585
  8005fe:	68 84 00 00 00       	push   $0x84
  800603:	68 dc 24 80 00       	push   $0x8024dc
  800608:	e8 dd 03 00 00       	call   8009ea <_panic>

		//2 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  80060d:	e8 8b 17 00 00       	call   801d9d <sys_calculate_free_frames>
  800612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800615:	e8 06 18 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80061a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(2*Mega-kilo);
  80061d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800620:	01 c0                	add    %eax,%eax
  800622:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800625:	83 ec 0c             	sub    $0xc,%esp
  800628:	50                   	push   %eax
  800629:	e8 fa 13 00 00       	call   801a28 <malloc>
  80062e:	83 c4 10             	add    $0x10,%esp
  800631:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800634:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800637:	89 c1                	mov    %eax,%ecx
  800639:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80063c:	89 d0                	mov    %edx,%eax
  80063e:	01 c0                	add    %eax,%eax
  800640:	01 d0                	add    %edx,%eax
  800642:	01 c0                	add    %eax,%eax
  800644:	01 d0                	add    %edx,%eax
  800646:	89 c2                	mov    %eax,%edx
  800648:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80064b:	c1 e0 04             	shl    $0x4,%eax
  80064e:	01 d0                	add    %edx,%eax
  800650:	05 00 00 00 80       	add    $0x80000000,%eax
  800655:	39 c1                	cmp    %eax,%ecx
  800657:	74 17                	je     800670 <_main+0x638>
  800659:	83 ec 04             	sub    $0x4,%esp
  80065c:	68 38 25 80 00       	push   $0x802538
  800661:	68 8a 00 00 00       	push   $0x8a
  800666:	68 dc 24 80 00       	push   $0x8024dc
  80066b:	e8 7a 03 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800670:	e8 ab 17 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800675:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800678:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067d:	74 17                	je     800696 <_main+0x65e>
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 68 25 80 00       	push   $0x802568
  800687:	68 8c 00 00 00       	push   $0x8c
  80068c:	68 dc 24 80 00       	push   $0x8024dc
  800691:	e8 54 03 00 00       	call   8009ea <_panic>

		//6 KB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800696:	e8 02 17 00 00       	call   801d9d <sys_calculate_free_frames>
  80069b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80069e:	e8 7d 17 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8006a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(6*kilo);
  8006a6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006a9:	89 d0                	mov    %edx,%eax
  8006ab:	01 c0                	add    %eax,%eax
  8006ad:	01 d0                	add    %edx,%eax
  8006af:	01 c0                	add    %eax,%eax
  8006b1:	83 ec 0c             	sub    $0xc,%esp
  8006b4:	50                   	push   %eax
  8006b5:	e8 6e 13 00 00       	call   801a28 <malloc>
  8006ba:	83 c4 10             	add    $0x10,%esp
  8006bd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 9*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8006c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006c3:	89 c1                	mov    %eax,%ecx
  8006c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c8:	89 d0                	mov    %edx,%eax
  8006ca:	c1 e0 03             	shl    $0x3,%eax
  8006cd:	01 d0                	add    %edx,%eax
  8006cf:	89 c2                	mov    %eax,%edx
  8006d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d4:	c1 e0 04             	shl    $0x4,%eax
  8006d7:	01 d0                	add    %edx,%eax
  8006d9:	05 00 00 00 80       	add    $0x80000000,%eax
  8006de:	39 c1                	cmp    %eax,%ecx
  8006e0:	74 17                	je     8006f9 <_main+0x6c1>
  8006e2:	83 ec 04             	sub    $0x4,%esp
  8006e5:	68 38 25 80 00       	push   $0x802538
  8006ea:	68 92 00 00 00       	push   $0x92
  8006ef:	68 dc 24 80 00       	push   $0x8024dc
  8006f4:	e8 f1 02 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  8006f9:	e8 22 17 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8006fe:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800701:	83 f8 02             	cmp    $0x2,%eax
  800704:	74 17                	je     80071d <_main+0x6e5>
  800706:	83 ec 04             	sub    $0x4,%esp
  800709:	68 68 25 80 00       	push   $0x802568
  80070e:	68 94 00 00 00       	push   $0x94
  800713:	68 dc 24 80 00       	push   $0x8024dc
  800718:	e8 cd 02 00 00       	call   8009ea <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80071d:	e8 7b 16 00 00       	call   801d9d <sys_calculate_free_frames>
  800722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800725:	e8 f6 16 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80072d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800730:	83 ec 0c             	sub    $0xc,%esp
  800733:	50                   	push   %eax
  800734:	e8 a7 14 00 00       	call   801be0 <free>
  800739:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  80073c:	e8 df 16 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800741:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800744:	29 c2                	sub    %eax,%edx
  800746:	89 d0                	mov    %edx,%eax
  800748:	3d 00 03 00 00       	cmp    $0x300,%eax
  80074d:	74 17                	je     800766 <_main+0x72e>
  80074f:	83 ec 04             	sub    $0x4,%esp
  800752:	68 85 25 80 00       	push   $0x802585
  800757:	68 9b 00 00 00       	push   $0x9b
  80075c:	68 dc 24 80 00       	push   $0x8024dc
  800761:	e8 84 02 00 00       	call   8009ea <_panic>

		//3 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800766:	e8 32 16 00 00       	call   801d9d <sys_calculate_free_frames>
  80076b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80076e:	e8 ad 16 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  800773:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(3*Mega-kilo);
  800776:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800779:	89 c2                	mov    %eax,%edx
  80077b:	01 d2                	add    %edx,%edx
  80077d:	01 d0                	add    %edx,%eax
  80077f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800782:	83 ec 0c             	sub    $0xc,%esp
  800785:	50                   	push   %eax
  800786:	e8 9d 12 00 00       	call   801a28 <malloc>
  80078b:	83 c4 10             	add    $0x10,%esp
  80078e:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800791:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800794:	89 c2                	mov    %eax,%edx
  800796:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800799:	c1 e0 02             	shl    $0x2,%eax
  80079c:	89 c1                	mov    %eax,%ecx
  80079e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007a1:	c1 e0 04             	shl    $0x4,%eax
  8007a4:	01 c8                	add    %ecx,%eax
  8007a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8007ab:	39 c2                	cmp    %eax,%edx
  8007ad:	74 17                	je     8007c6 <_main+0x78e>
  8007af:	83 ec 04             	sub    $0x4,%esp
  8007b2:	68 38 25 80 00       	push   $0x802538
  8007b7:	68 a1 00 00 00       	push   $0xa1
  8007bc:	68 dc 24 80 00       	push   $0x8024dc
  8007c1:	e8 24 02 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  8007c6:	e8 55 16 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  8007cb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007ce:	89 c2                	mov    %eax,%edx
  8007d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d3:	89 c1                	mov    %eax,%ecx
  8007d5:	01 c9                	add    %ecx,%ecx
  8007d7:	01 c8                	add    %ecx,%eax
  8007d9:	85 c0                	test   %eax,%eax
  8007db:	79 05                	jns    8007e2 <_main+0x7aa>
  8007dd:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007e2:	c1 f8 0c             	sar    $0xc,%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 17                	je     800800 <_main+0x7c8>
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 68 25 80 00       	push   $0x802568
  8007f1:	68 a3 00 00 00       	push   $0xa3
  8007f6:	68 dc 24 80 00       	push   $0x8024dc
  8007fb:	e8 ea 01 00 00       	call   8009ea <_panic>

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800800:	e8 98 15 00 00       	call   801d9d <sys_calculate_free_frames>
  800805:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800808:	e8 13 16 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80080d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega-kilo);
  800810:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800813:	c1 e0 02             	shl    $0x2,%eax
  800816:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800819:	83 ec 0c             	sub    $0xc,%esp
  80081c:	50                   	push   %eax
  80081d:	e8 06 12 00 00       	call   801a28 <malloc>
  800822:	83 c4 10             	add    $0x10,%esp
  800825:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800828:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80082b:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800830:	74 17                	je     800849 <_main+0x811>
  800832:	83 ec 04             	sub    $0x4,%esp
  800835:	68 38 25 80 00       	push   $0x802538
  80083a:	68 a9 00 00 00       	push   $0xa9
  80083f:	68 dc 24 80 00       	push   $0x8024dc
  800844:	e8 a1 01 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 4*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/4096) panic("Wrong page file allocation: ");
  800849:	e8 d2 15 00 00       	call   801e20 <sys_pf_calculate_allocated_pages>
  80084e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800851:	89 c2                	mov    %eax,%edx
  800853:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800856:	c1 e0 02             	shl    $0x2,%eax
  800859:	85 c0                	test   %eax,%eax
  80085b:	79 05                	jns    800862 <_main+0x82a>
  80085d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800862:	c1 f8 0c             	sar    $0xc,%eax
  800865:	39 c2                	cmp    %eax,%edx
  800867:	74 17                	je     800880 <_main+0x848>
  800869:	83 ec 04             	sub    $0x4,%esp
  80086c:	68 68 25 80 00       	push   $0x802568
  800871:	68 ab 00 00 00       	push   $0xab
  800876:	68 dc 24 80 00       	push   $0x8024dc
  80087b:	e8 6a 01 00 00       	call   8009ea <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[12] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800880:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800883:	89 d0                	mov    %edx,%eax
  800885:	01 c0                	add    %eax,%eax
  800887:	01 d0                	add    %edx,%eax
  800889:	01 c0                	add    %eax,%eax
  80088b:	01 d0                	add    %edx,%eax
  80088d:	01 c0                	add    %eax,%eax
  80088f:	f7 d8                	neg    %eax
  800891:	05 00 00 00 20       	add    $0x20000000,%eax
  800896:	83 ec 0c             	sub    $0xc,%esp
  800899:	50                   	push   %eax
  80089a:	e8 89 11 00 00       	call   801a28 <malloc>
  80089f:	83 c4 10             	add    $0x10,%esp
  8008a2:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if (ptr_allocations[12] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8008a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a8:	85 c0                	test   %eax,%eax
  8008aa:	74 17                	je     8008c3 <_main+0x88b>
  8008ac:	83 ec 04             	sub    $0x4,%esp
  8008af:	68 9c 25 80 00       	push   $0x80259c
  8008b4:	68 b4 00 00 00       	push   $0xb4
  8008b9:	68 dc 24 80 00       	push   $0x8024dc
  8008be:	e8 27 01 00 00       	call   8009ea <_panic>

		cprintf("Congratulations!! test BEST FIT allocation (2) completed successfully.\n");
  8008c3:	83 ec 0c             	sub    $0xc,%esp
  8008c6:	68 00 26 80 00       	push   $0x802600
  8008cb:	e8 ce 03 00 00       	call   800c9e <cprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp

		return;
  8008d3:	90                   	nop
	}
}
  8008d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d7:	5b                   	pop    %ebx
  8008d8:	5f                   	pop    %edi
  8008d9:	5d                   	pop    %ebp
  8008da:	c3                   	ret    

008008db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
  8008de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008e1:	e8 ec 13 00 00       	call   801cd2 <sys_getenvindex>
  8008e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ec:	89 d0                	mov    %edx,%eax
  8008ee:	c1 e0 02             	shl    $0x2,%eax
  8008f1:	01 d0                	add    %edx,%eax
  8008f3:	01 c0                	add    %eax,%eax
  8008f5:	01 d0                	add    %edx,%eax
  8008f7:	01 c0                	add    %eax,%eax
  8008f9:	01 d0                	add    %edx,%eax
  8008fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800902:	01 d0                	add    %edx,%eax
  800904:	c1 e0 02             	shl    $0x2,%eax
  800907:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80090c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800911:	a1 20 30 80 00       	mov    0x803020,%eax
  800916:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80091c:	84 c0                	test   %al,%al
  80091e:	74 0f                	je     80092f <libmain+0x54>
		binaryname = myEnv->prog_name;
  800920:	a1 20 30 80 00       	mov    0x803020,%eax
  800925:	05 f4 02 00 00       	add    $0x2f4,%eax
  80092a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80092f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800933:	7e 0a                	jle    80093f <libmain+0x64>
		binaryname = argv[0];
  800935:	8b 45 0c             	mov    0xc(%ebp),%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	ff 75 08             	pushl  0x8(%ebp)
  800948:	e8 eb f6 ff ff       	call   800038 <_main>
  80094d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800950:	e8 18 15 00 00       	call   801e6d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800955:	83 ec 0c             	sub    $0xc,%esp
  800958:	68 60 26 80 00       	push   $0x802660
  80095d:	e8 3c 03 00 00       	call   800c9e <cprintf>
  800962:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800965:	a1 20 30 80 00       	mov    0x803020,%eax
  80096a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800970:	a1 20 30 80 00       	mov    0x803020,%eax
  800975:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80097b:	83 ec 04             	sub    $0x4,%esp
  80097e:	52                   	push   %edx
  80097f:	50                   	push   %eax
  800980:	68 88 26 80 00       	push   $0x802688
  800985:	e8 14 03 00 00       	call   800c9e <cprintf>
  80098a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80098d:	a1 20 30 80 00       	mov    0x803020,%eax
  800992:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	50                   	push   %eax
  80099c:	68 ad 26 80 00       	push   $0x8026ad
  8009a1:	e8 f8 02 00 00       	call   800c9e <cprintf>
  8009a6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009a9:	83 ec 0c             	sub    $0xc,%esp
  8009ac:	68 60 26 80 00       	push   $0x802660
  8009b1:	e8 e8 02 00 00       	call   800c9e <cprintf>
  8009b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009b9:	e8 c9 14 00 00       	call   801e87 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009be:	e8 19 00 00 00       	call   8009dc <exit>
}
  8009c3:	90                   	nop
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009cc:	83 ec 0c             	sub    $0xc,%esp
  8009cf:	6a 00                	push   $0x0
  8009d1:	e8 c8 12 00 00       	call   801c9e <sys_env_destroy>
  8009d6:	83 c4 10             	add    $0x10,%esp
}
  8009d9:	90                   	nop
  8009da:	c9                   	leave  
  8009db:	c3                   	ret    

008009dc <exit>:

void
exit(void)
{
  8009dc:	55                   	push   %ebp
  8009dd:	89 e5                	mov    %esp,%ebp
  8009df:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009e2:	e8 1d 13 00 00       	call   801d04 <sys_env_exit>
}
  8009e7:	90                   	nop
  8009e8:	c9                   	leave  
  8009e9:	c3                   	ret    

008009ea <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009ea:	55                   	push   %ebp
  8009eb:	89 e5                	mov    %esp,%ebp
  8009ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009f0:	8d 45 10             	lea    0x10(%ebp),%eax
  8009f3:	83 c0 04             	add    $0x4,%eax
  8009f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009f9:	a1 34 30 80 00       	mov    0x803034,%eax
  8009fe:	85 c0                	test   %eax,%eax
  800a00:	74 16                	je     800a18 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a02:	a1 34 30 80 00       	mov    0x803034,%eax
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	50                   	push   %eax
  800a0b:	68 c4 26 80 00       	push   $0x8026c4
  800a10:	e8 89 02 00 00       	call   800c9e <cprintf>
  800a15:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a18:	a1 00 30 80 00       	mov    0x803000,%eax
  800a1d:	ff 75 0c             	pushl  0xc(%ebp)
  800a20:	ff 75 08             	pushl  0x8(%ebp)
  800a23:	50                   	push   %eax
  800a24:	68 c9 26 80 00       	push   $0x8026c9
  800a29:	e8 70 02 00 00       	call   800c9e <cprintf>
  800a2e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a31:	8b 45 10             	mov    0x10(%ebp),%eax
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3a:	50                   	push   %eax
  800a3b:	e8 f3 01 00 00       	call   800c33 <vcprintf>
  800a40:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a43:	83 ec 08             	sub    $0x8,%esp
  800a46:	6a 00                	push   $0x0
  800a48:	68 e5 26 80 00       	push   $0x8026e5
  800a4d:	e8 e1 01 00 00       	call   800c33 <vcprintf>
  800a52:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a55:	e8 82 ff ff ff       	call   8009dc <exit>

	// should not return here
	while (1) ;
  800a5a:	eb fe                	jmp    800a5a <_panic+0x70>

00800a5c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a5c:	55                   	push   %ebp
  800a5d:	89 e5                	mov    %esp,%ebp
  800a5f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a62:	a1 20 30 80 00       	mov    0x803020,%eax
  800a67:	8b 50 74             	mov    0x74(%eax),%edx
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	39 c2                	cmp    %eax,%edx
  800a6f:	74 14                	je     800a85 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a71:	83 ec 04             	sub    $0x4,%esp
  800a74:	68 e8 26 80 00       	push   $0x8026e8
  800a79:	6a 26                	push   $0x26
  800a7b:	68 34 27 80 00       	push   $0x802734
  800a80:	e8 65 ff ff ff       	call   8009ea <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a8c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a93:	e9 c2 00 00 00       	jmp    800b5a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	01 d0                	add    %edx,%eax
  800aa7:	8b 00                	mov    (%eax),%eax
  800aa9:	85 c0                	test   %eax,%eax
  800aab:	75 08                	jne    800ab5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800aad:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ab0:	e9 a2 00 00 00       	jmp    800b57 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800ab5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800abc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800ac3:	eb 69                	jmp    800b2e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800ac5:	a1 20 30 80 00       	mov    0x803020,%eax
  800aca:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ad0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ad3:	89 d0                	mov    %edx,%eax
  800ad5:	01 c0                	add    %eax,%eax
  800ad7:	01 d0                	add    %edx,%eax
  800ad9:	c1 e0 02             	shl    $0x2,%eax
  800adc:	01 c8                	add    %ecx,%eax
  800ade:	8a 40 04             	mov    0x4(%eax),%al
  800ae1:	84 c0                	test   %al,%al
  800ae3:	75 46                	jne    800b2b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ae5:	a1 20 30 80 00       	mov    0x803020,%eax
  800aea:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800af0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800af3:	89 d0                	mov    %edx,%eax
  800af5:	01 c0                	add    %eax,%eax
  800af7:	01 d0                	add    %edx,%eax
  800af9:	c1 e0 02             	shl    $0x2,%eax
  800afc:	01 c8                	add    %ecx,%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b03:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b0b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b10:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	01 c8                	add    %ecx,%eax
  800b1c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b1e:	39 c2                	cmp    %eax,%edx
  800b20:	75 09                	jne    800b2b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b22:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b29:	eb 12                	jmp    800b3d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b2b:	ff 45 e8             	incl   -0x18(%ebp)
  800b2e:	a1 20 30 80 00       	mov    0x803020,%eax
  800b33:	8b 50 74             	mov    0x74(%eax),%edx
  800b36:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b39:	39 c2                	cmp    %eax,%edx
  800b3b:	77 88                	ja     800ac5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b41:	75 14                	jne    800b57 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800b43:	83 ec 04             	sub    $0x4,%esp
  800b46:	68 40 27 80 00       	push   $0x802740
  800b4b:	6a 3a                	push   $0x3a
  800b4d:	68 34 27 80 00       	push   $0x802734
  800b52:	e8 93 fe ff ff       	call   8009ea <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b57:	ff 45 f0             	incl   -0x10(%ebp)
  800b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b60:	0f 8c 32 ff ff ff    	jl     800a98 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b66:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b6d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b74:	eb 26                	jmp    800b9c <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b76:	a1 20 30 80 00       	mov    0x803020,%eax
  800b7b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b81:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b84:	89 d0                	mov    %edx,%eax
  800b86:	01 c0                	add    %eax,%eax
  800b88:	01 d0                	add    %edx,%eax
  800b8a:	c1 e0 02             	shl    $0x2,%eax
  800b8d:	01 c8                	add    %ecx,%eax
  800b8f:	8a 40 04             	mov    0x4(%eax),%al
  800b92:	3c 01                	cmp    $0x1,%al
  800b94:	75 03                	jne    800b99 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b96:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b99:	ff 45 e0             	incl   -0x20(%ebp)
  800b9c:	a1 20 30 80 00       	mov    0x803020,%eax
  800ba1:	8b 50 74             	mov    0x74(%eax),%edx
  800ba4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ba7:	39 c2                	cmp    %eax,%edx
  800ba9:	77 cb                	ja     800b76 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bae:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bb1:	74 14                	je     800bc7 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800bb3:	83 ec 04             	sub    $0x4,%esp
  800bb6:	68 94 27 80 00       	push   $0x802794
  800bbb:	6a 44                	push   $0x44
  800bbd:	68 34 27 80 00       	push   $0x802734
  800bc2:	e8 23 fe ff ff       	call   8009ea <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bc7:	90                   	nop
  800bc8:	c9                   	leave  
  800bc9:	c3                   	ret    

00800bca <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800bca:	55                   	push   %ebp
  800bcb:	89 e5                	mov    %esp,%ebp
  800bcd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	8d 48 01             	lea    0x1(%eax),%ecx
  800bd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bdb:	89 0a                	mov    %ecx,(%edx)
  800bdd:	8b 55 08             	mov    0x8(%ebp),%edx
  800be0:	88 d1                	mov    %dl,%cl
  800be2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800be9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bec:	8b 00                	mov    (%eax),%eax
  800bee:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bf3:	75 2c                	jne    800c21 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800bf5:	a0 24 30 80 00       	mov    0x803024,%al
  800bfa:	0f b6 c0             	movzbl %al,%eax
  800bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c00:	8b 12                	mov    (%edx),%edx
  800c02:	89 d1                	mov    %edx,%ecx
  800c04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c07:	83 c2 08             	add    $0x8,%edx
  800c0a:	83 ec 04             	sub    $0x4,%esp
  800c0d:	50                   	push   %eax
  800c0e:	51                   	push   %ecx
  800c0f:	52                   	push   %edx
  800c10:	e8 47 10 00 00       	call   801c5c <sys_cputs>
  800c15:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c24:	8b 40 04             	mov    0x4(%eax),%eax
  800c27:	8d 50 01             	lea    0x1(%eax),%edx
  800c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c30:	90                   	nop
  800c31:	c9                   	leave  
  800c32:	c3                   	ret    

00800c33 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c33:	55                   	push   %ebp
  800c34:	89 e5                	mov    %esp,%ebp
  800c36:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c3c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c43:	00 00 00 
	b.cnt = 0;
  800c46:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c4d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c50:	ff 75 0c             	pushl  0xc(%ebp)
  800c53:	ff 75 08             	pushl  0x8(%ebp)
  800c56:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c5c:	50                   	push   %eax
  800c5d:	68 ca 0b 80 00       	push   $0x800bca
  800c62:	e8 11 02 00 00       	call   800e78 <vprintfmt>
  800c67:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c6a:	a0 24 30 80 00       	mov    0x803024,%al
  800c6f:	0f b6 c0             	movzbl %al,%eax
  800c72:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c78:	83 ec 04             	sub    $0x4,%esp
  800c7b:	50                   	push   %eax
  800c7c:	52                   	push   %edx
  800c7d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c83:	83 c0 08             	add    $0x8,%eax
  800c86:	50                   	push   %eax
  800c87:	e8 d0 0f 00 00       	call   801c5c <sys_cputs>
  800c8c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c8f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800c96:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c9c:	c9                   	leave  
  800c9d:	c3                   	ret    

00800c9e <cprintf>:

int cprintf(const char *fmt, ...) {
  800c9e:	55                   	push   %ebp
  800c9f:	89 e5                	mov    %esp,%ebp
  800ca1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ca4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cab:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	83 ec 08             	sub    $0x8,%esp
  800cb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800cba:	50                   	push   %eax
  800cbb:	e8 73 ff ff ff       	call   800c33 <vcprintf>
  800cc0:	83 c4 10             	add    $0x10,%esp
  800cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cc9:	c9                   	leave  
  800cca:	c3                   	ret    

00800ccb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ccb:	55                   	push   %ebp
  800ccc:	89 e5                	mov    %esp,%ebp
  800cce:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cd1:	e8 97 11 00 00       	call   801e6d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cd6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	83 ec 08             	sub    $0x8,%esp
  800ce2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce5:	50                   	push   %eax
  800ce6:	e8 48 ff ff ff       	call   800c33 <vcprintf>
  800ceb:	83 c4 10             	add    $0x10,%esp
  800cee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800cf1:	e8 91 11 00 00       	call   801e87 <sys_enable_interrupt>
	return cnt;
  800cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cf9:	c9                   	leave  
  800cfa:	c3                   	ret    

00800cfb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800cfb:	55                   	push   %ebp
  800cfc:	89 e5                	mov    %esp,%ebp
  800cfe:	53                   	push   %ebx
  800cff:	83 ec 14             	sub    $0x14,%esp
  800d02:	8b 45 10             	mov    0x10(%ebp),%eax
  800d05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d08:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d0e:	8b 45 18             	mov    0x18(%ebp),%eax
  800d11:	ba 00 00 00 00       	mov    $0x0,%edx
  800d16:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d19:	77 55                	ja     800d70 <printnum+0x75>
  800d1b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d1e:	72 05                	jb     800d25 <printnum+0x2a>
  800d20:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d23:	77 4b                	ja     800d70 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d25:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d28:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800d2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800d33:	52                   	push   %edx
  800d34:	50                   	push   %eax
  800d35:	ff 75 f4             	pushl  -0xc(%ebp)
  800d38:	ff 75 f0             	pushl  -0x10(%ebp)
  800d3b:	e8 0c 15 00 00       	call   80224c <__udivdi3>
  800d40:	83 c4 10             	add    $0x10,%esp
  800d43:	83 ec 04             	sub    $0x4,%esp
  800d46:	ff 75 20             	pushl  0x20(%ebp)
  800d49:	53                   	push   %ebx
  800d4a:	ff 75 18             	pushl  0x18(%ebp)
  800d4d:	52                   	push   %edx
  800d4e:	50                   	push   %eax
  800d4f:	ff 75 0c             	pushl  0xc(%ebp)
  800d52:	ff 75 08             	pushl  0x8(%ebp)
  800d55:	e8 a1 ff ff ff       	call   800cfb <printnum>
  800d5a:	83 c4 20             	add    $0x20,%esp
  800d5d:	eb 1a                	jmp    800d79 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	ff 75 20             	pushl  0x20(%ebp)
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6b:	ff d0                	call   *%eax
  800d6d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d70:	ff 4d 1c             	decl   0x1c(%ebp)
  800d73:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d77:	7f e6                	jg     800d5f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d79:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d7c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d87:	53                   	push   %ebx
  800d88:	51                   	push   %ecx
  800d89:	52                   	push   %edx
  800d8a:	50                   	push   %eax
  800d8b:	e8 cc 15 00 00       	call   80235c <__umoddi3>
  800d90:	83 c4 10             	add    $0x10,%esp
  800d93:	05 f4 29 80 00       	add    $0x8029f4,%eax
  800d98:	8a 00                	mov    (%eax),%al
  800d9a:	0f be c0             	movsbl %al,%eax
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	50                   	push   %eax
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
  800da7:	ff d0                	call   *%eax
  800da9:	83 c4 10             	add    $0x10,%esp
}
  800dac:	90                   	nop
  800dad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800db0:	c9                   	leave  
  800db1:	c3                   	ret    

00800db2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800db2:	55                   	push   %ebp
  800db3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800db5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800db9:	7e 1c                	jle    800dd7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8b 00                	mov    (%eax),%eax
  800dc0:	8d 50 08             	lea    0x8(%eax),%edx
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	89 10                	mov    %edx,(%eax)
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8b 00                	mov    (%eax),%eax
  800dcd:	83 e8 08             	sub    $0x8,%eax
  800dd0:	8b 50 04             	mov    0x4(%eax),%edx
  800dd3:	8b 00                	mov    (%eax),%eax
  800dd5:	eb 40                	jmp    800e17 <getuint+0x65>
	else if (lflag)
  800dd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ddb:	74 1e                	je     800dfb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8b 00                	mov    (%eax),%eax
  800de2:	8d 50 04             	lea    0x4(%eax),%edx
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 10                	mov    %edx,(%eax)
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8b 00                	mov    (%eax),%eax
  800def:	83 e8 04             	sub    $0x4,%eax
  800df2:	8b 00                	mov    (%eax),%eax
  800df4:	ba 00 00 00 00       	mov    $0x0,%edx
  800df9:	eb 1c                	jmp    800e17 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	8b 00                	mov    (%eax),%eax
  800e00:	8d 50 04             	lea    0x4(%eax),%edx
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	89 10                	mov    %edx,(%eax)
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	83 e8 04             	sub    $0x4,%eax
  800e10:	8b 00                	mov    (%eax),%eax
  800e12:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e17:	5d                   	pop    %ebp
  800e18:	c3                   	ret    

00800e19 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e19:	55                   	push   %ebp
  800e1a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e1c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e20:	7e 1c                	jle    800e3e <getint+0x25>
		return va_arg(*ap, long long);
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	8b 00                	mov    (%eax),%eax
  800e27:	8d 50 08             	lea    0x8(%eax),%edx
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	89 10                	mov    %edx,(%eax)
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	8b 00                	mov    (%eax),%eax
  800e34:	83 e8 08             	sub    $0x8,%eax
  800e37:	8b 50 04             	mov    0x4(%eax),%edx
  800e3a:	8b 00                	mov    (%eax),%eax
  800e3c:	eb 38                	jmp    800e76 <getint+0x5d>
	else if (lflag)
  800e3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e42:	74 1a                	je     800e5e <getint+0x45>
		return va_arg(*ap, long);
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8b 00                	mov    (%eax),%eax
  800e49:	8d 50 04             	lea    0x4(%eax),%edx
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	89 10                	mov    %edx,(%eax)
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8b 00                	mov    (%eax),%eax
  800e56:	83 e8 04             	sub    $0x4,%eax
  800e59:	8b 00                	mov    (%eax),%eax
  800e5b:	99                   	cltd   
  800e5c:	eb 18                	jmp    800e76 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8b 00                	mov    (%eax),%eax
  800e63:	8d 50 04             	lea    0x4(%eax),%edx
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	89 10                	mov    %edx,(%eax)
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	8b 00                	mov    (%eax),%eax
  800e70:	83 e8 04             	sub    $0x4,%eax
  800e73:	8b 00                	mov    (%eax),%eax
  800e75:	99                   	cltd   
}
  800e76:	5d                   	pop    %ebp
  800e77:	c3                   	ret    

00800e78 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e78:	55                   	push   %ebp
  800e79:	89 e5                	mov    %esp,%ebp
  800e7b:	56                   	push   %esi
  800e7c:	53                   	push   %ebx
  800e7d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e80:	eb 17                	jmp    800e99 <vprintfmt+0x21>
			if (ch == '\0')
  800e82:	85 db                	test   %ebx,%ebx
  800e84:	0f 84 af 03 00 00    	je     801239 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e8a:	83 ec 08             	sub    $0x8,%esp
  800e8d:	ff 75 0c             	pushl  0xc(%ebp)
  800e90:	53                   	push   %ebx
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	ff d0                	call   *%eax
  800e96:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e99:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9c:	8d 50 01             	lea    0x1(%eax),%edx
  800e9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800ea2:	8a 00                	mov    (%eax),%al
  800ea4:	0f b6 d8             	movzbl %al,%ebx
  800ea7:	83 fb 25             	cmp    $0x25,%ebx
  800eaa:	75 d6                	jne    800e82 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800eac:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800eb0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800eb7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ebe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ec5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ecc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecf:	8d 50 01             	lea    0x1(%eax),%edx
  800ed2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	0f b6 d8             	movzbl %al,%ebx
  800eda:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800edd:	83 f8 55             	cmp    $0x55,%eax
  800ee0:	0f 87 2b 03 00 00    	ja     801211 <vprintfmt+0x399>
  800ee6:	8b 04 85 18 2a 80 00 	mov    0x802a18(,%eax,4),%eax
  800eed:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800eef:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ef3:	eb d7                	jmp    800ecc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ef5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ef9:	eb d1                	jmp    800ecc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800efb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f02:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f05:	89 d0                	mov    %edx,%eax
  800f07:	c1 e0 02             	shl    $0x2,%eax
  800f0a:	01 d0                	add    %edx,%eax
  800f0c:	01 c0                	add    %eax,%eax
  800f0e:	01 d8                	add    %ebx,%eax
  800f10:	83 e8 30             	sub    $0x30,%eax
  800f13:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f1e:	83 fb 2f             	cmp    $0x2f,%ebx
  800f21:	7e 3e                	jle    800f61 <vprintfmt+0xe9>
  800f23:	83 fb 39             	cmp    $0x39,%ebx
  800f26:	7f 39                	jg     800f61 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f28:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f2b:	eb d5                	jmp    800f02 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f30:	83 c0 04             	add    $0x4,%eax
  800f33:	89 45 14             	mov    %eax,0x14(%ebp)
  800f36:	8b 45 14             	mov    0x14(%ebp),%eax
  800f39:	83 e8 04             	sub    $0x4,%eax
  800f3c:	8b 00                	mov    (%eax),%eax
  800f3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f41:	eb 1f                	jmp    800f62 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f47:	79 83                	jns    800ecc <vprintfmt+0x54>
				width = 0;
  800f49:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f50:	e9 77 ff ff ff       	jmp    800ecc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f55:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f5c:	e9 6b ff ff ff       	jmp    800ecc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f61:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f66:	0f 89 60 ff ff ff    	jns    800ecc <vprintfmt+0x54>
				width = precision, precision = -1;
  800f6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f6f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f72:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f79:	e9 4e ff ff ff       	jmp    800ecc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f7e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f81:	e9 46 ff ff ff       	jmp    800ecc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f86:	8b 45 14             	mov    0x14(%ebp),%eax
  800f89:	83 c0 04             	add    $0x4,%eax
  800f8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f92:	83 e8 04             	sub    $0x4,%eax
  800f95:	8b 00                	mov    (%eax),%eax
  800f97:	83 ec 08             	sub    $0x8,%esp
  800f9a:	ff 75 0c             	pushl  0xc(%ebp)
  800f9d:	50                   	push   %eax
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	ff d0                	call   *%eax
  800fa3:	83 c4 10             	add    $0x10,%esp
			break;
  800fa6:	e9 89 02 00 00       	jmp    801234 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fab:	8b 45 14             	mov    0x14(%ebp),%eax
  800fae:	83 c0 04             	add    $0x4,%eax
  800fb1:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb7:	83 e8 04             	sub    $0x4,%eax
  800fba:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fbc:	85 db                	test   %ebx,%ebx
  800fbe:	79 02                	jns    800fc2 <vprintfmt+0x14a>
				err = -err;
  800fc0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fc2:	83 fb 64             	cmp    $0x64,%ebx
  800fc5:	7f 0b                	jg     800fd2 <vprintfmt+0x15a>
  800fc7:	8b 34 9d 60 28 80 00 	mov    0x802860(,%ebx,4),%esi
  800fce:	85 f6                	test   %esi,%esi
  800fd0:	75 19                	jne    800feb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fd2:	53                   	push   %ebx
  800fd3:	68 05 2a 80 00       	push   $0x802a05
  800fd8:	ff 75 0c             	pushl  0xc(%ebp)
  800fdb:	ff 75 08             	pushl  0x8(%ebp)
  800fde:	e8 5e 02 00 00       	call   801241 <printfmt>
  800fe3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fe6:	e9 49 02 00 00       	jmp    801234 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800feb:	56                   	push   %esi
  800fec:	68 0e 2a 80 00       	push   $0x802a0e
  800ff1:	ff 75 0c             	pushl  0xc(%ebp)
  800ff4:	ff 75 08             	pushl  0x8(%ebp)
  800ff7:	e8 45 02 00 00       	call   801241 <printfmt>
  800ffc:	83 c4 10             	add    $0x10,%esp
			break;
  800fff:	e9 30 02 00 00       	jmp    801234 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801004:	8b 45 14             	mov    0x14(%ebp),%eax
  801007:	83 c0 04             	add    $0x4,%eax
  80100a:	89 45 14             	mov    %eax,0x14(%ebp)
  80100d:	8b 45 14             	mov    0x14(%ebp),%eax
  801010:	83 e8 04             	sub    $0x4,%eax
  801013:	8b 30                	mov    (%eax),%esi
  801015:	85 f6                	test   %esi,%esi
  801017:	75 05                	jne    80101e <vprintfmt+0x1a6>
				p = "(null)";
  801019:	be 11 2a 80 00       	mov    $0x802a11,%esi
			if (width > 0 && padc != '-')
  80101e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801022:	7e 6d                	jle    801091 <vprintfmt+0x219>
  801024:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801028:	74 67                	je     801091 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80102a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80102d:	83 ec 08             	sub    $0x8,%esp
  801030:	50                   	push   %eax
  801031:	56                   	push   %esi
  801032:	e8 0c 03 00 00       	call   801343 <strnlen>
  801037:	83 c4 10             	add    $0x10,%esp
  80103a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80103d:	eb 16                	jmp    801055 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80103f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	ff 75 0c             	pushl  0xc(%ebp)
  801049:	50                   	push   %eax
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	ff d0                	call   *%eax
  80104f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801052:	ff 4d e4             	decl   -0x1c(%ebp)
  801055:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801059:	7f e4                	jg     80103f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80105b:	eb 34                	jmp    801091 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80105d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801061:	74 1c                	je     80107f <vprintfmt+0x207>
  801063:	83 fb 1f             	cmp    $0x1f,%ebx
  801066:	7e 05                	jle    80106d <vprintfmt+0x1f5>
  801068:	83 fb 7e             	cmp    $0x7e,%ebx
  80106b:	7e 12                	jle    80107f <vprintfmt+0x207>
					putch('?', putdat);
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	ff 75 0c             	pushl  0xc(%ebp)
  801073:	6a 3f                	push   $0x3f
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	ff d0                	call   *%eax
  80107a:	83 c4 10             	add    $0x10,%esp
  80107d:	eb 0f                	jmp    80108e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80107f:	83 ec 08             	sub    $0x8,%esp
  801082:	ff 75 0c             	pushl  0xc(%ebp)
  801085:	53                   	push   %ebx
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	ff d0                	call   *%eax
  80108b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80108e:	ff 4d e4             	decl   -0x1c(%ebp)
  801091:	89 f0                	mov    %esi,%eax
  801093:	8d 70 01             	lea    0x1(%eax),%esi
  801096:	8a 00                	mov    (%eax),%al
  801098:	0f be d8             	movsbl %al,%ebx
  80109b:	85 db                	test   %ebx,%ebx
  80109d:	74 24                	je     8010c3 <vprintfmt+0x24b>
  80109f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010a3:	78 b8                	js     80105d <vprintfmt+0x1e5>
  8010a5:	ff 4d e0             	decl   -0x20(%ebp)
  8010a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010ac:	79 af                	jns    80105d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010ae:	eb 13                	jmp    8010c3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010b0:	83 ec 08             	sub    $0x8,%esp
  8010b3:	ff 75 0c             	pushl  0xc(%ebp)
  8010b6:	6a 20                	push   $0x20
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	ff d0                	call   *%eax
  8010bd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010c0:	ff 4d e4             	decl   -0x1c(%ebp)
  8010c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010c7:	7f e7                	jg     8010b0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010c9:	e9 66 01 00 00       	jmp    801234 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010ce:	83 ec 08             	sub    $0x8,%esp
  8010d1:	ff 75 e8             	pushl  -0x18(%ebp)
  8010d4:	8d 45 14             	lea    0x14(%ebp),%eax
  8010d7:	50                   	push   %eax
  8010d8:	e8 3c fd ff ff       	call   800e19 <getint>
  8010dd:	83 c4 10             	add    $0x10,%esp
  8010e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ec:	85 d2                	test   %edx,%edx
  8010ee:	79 23                	jns    801113 <vprintfmt+0x29b>
				putch('-', putdat);
  8010f0:	83 ec 08             	sub    $0x8,%esp
  8010f3:	ff 75 0c             	pushl  0xc(%ebp)
  8010f6:	6a 2d                	push   $0x2d
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	ff d0                	call   *%eax
  8010fd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801100:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801103:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801106:	f7 d8                	neg    %eax
  801108:	83 d2 00             	adc    $0x0,%edx
  80110b:	f7 da                	neg    %edx
  80110d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801110:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801113:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80111a:	e9 bc 00 00 00       	jmp    8011db <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80111f:	83 ec 08             	sub    $0x8,%esp
  801122:	ff 75 e8             	pushl  -0x18(%ebp)
  801125:	8d 45 14             	lea    0x14(%ebp),%eax
  801128:	50                   	push   %eax
  801129:	e8 84 fc ff ff       	call   800db2 <getuint>
  80112e:	83 c4 10             	add    $0x10,%esp
  801131:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801134:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801137:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80113e:	e9 98 00 00 00       	jmp    8011db <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801143:	83 ec 08             	sub    $0x8,%esp
  801146:	ff 75 0c             	pushl  0xc(%ebp)
  801149:	6a 58                	push   $0x58
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	ff d0                	call   *%eax
  801150:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801153:	83 ec 08             	sub    $0x8,%esp
  801156:	ff 75 0c             	pushl  0xc(%ebp)
  801159:	6a 58                	push   $0x58
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	ff d0                	call   *%eax
  801160:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801163:	83 ec 08             	sub    $0x8,%esp
  801166:	ff 75 0c             	pushl  0xc(%ebp)
  801169:	6a 58                	push   $0x58
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	ff d0                	call   *%eax
  801170:	83 c4 10             	add    $0x10,%esp
			break;
  801173:	e9 bc 00 00 00       	jmp    801234 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801178:	83 ec 08             	sub    $0x8,%esp
  80117b:	ff 75 0c             	pushl  0xc(%ebp)
  80117e:	6a 30                	push   $0x30
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	ff d0                	call   *%eax
  801185:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801188:	83 ec 08             	sub    $0x8,%esp
  80118b:	ff 75 0c             	pushl  0xc(%ebp)
  80118e:	6a 78                	push   $0x78
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	ff d0                	call   *%eax
  801195:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801198:	8b 45 14             	mov    0x14(%ebp),%eax
  80119b:	83 c0 04             	add    $0x4,%eax
  80119e:	89 45 14             	mov    %eax,0x14(%ebp)
  8011a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a4:	83 e8 04             	sub    $0x4,%eax
  8011a7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011b3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011ba:	eb 1f                	jmp    8011db <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011bc:	83 ec 08             	sub    $0x8,%esp
  8011bf:	ff 75 e8             	pushl  -0x18(%ebp)
  8011c2:	8d 45 14             	lea    0x14(%ebp),%eax
  8011c5:	50                   	push   %eax
  8011c6:	e8 e7 fb ff ff       	call   800db2 <getuint>
  8011cb:	83 c4 10             	add    $0x10,%esp
  8011ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011d4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011db:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e2:	83 ec 04             	sub    $0x4,%esp
  8011e5:	52                   	push   %edx
  8011e6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011e9:	50                   	push   %eax
  8011ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ed:	ff 75 f0             	pushl  -0x10(%ebp)
  8011f0:	ff 75 0c             	pushl  0xc(%ebp)
  8011f3:	ff 75 08             	pushl  0x8(%ebp)
  8011f6:	e8 00 fb ff ff       	call   800cfb <printnum>
  8011fb:	83 c4 20             	add    $0x20,%esp
			break;
  8011fe:	eb 34                	jmp    801234 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801200:	83 ec 08             	sub    $0x8,%esp
  801203:	ff 75 0c             	pushl  0xc(%ebp)
  801206:	53                   	push   %ebx
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	ff d0                	call   *%eax
  80120c:	83 c4 10             	add    $0x10,%esp
			break;
  80120f:	eb 23                	jmp    801234 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801211:	83 ec 08             	sub    $0x8,%esp
  801214:	ff 75 0c             	pushl  0xc(%ebp)
  801217:	6a 25                	push   $0x25
  801219:	8b 45 08             	mov    0x8(%ebp),%eax
  80121c:	ff d0                	call   *%eax
  80121e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801221:	ff 4d 10             	decl   0x10(%ebp)
  801224:	eb 03                	jmp    801229 <vprintfmt+0x3b1>
  801226:	ff 4d 10             	decl   0x10(%ebp)
  801229:	8b 45 10             	mov    0x10(%ebp),%eax
  80122c:	48                   	dec    %eax
  80122d:	8a 00                	mov    (%eax),%al
  80122f:	3c 25                	cmp    $0x25,%al
  801231:	75 f3                	jne    801226 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801233:	90                   	nop
		}
	}
  801234:	e9 47 fc ff ff       	jmp    800e80 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801239:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80123a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80123d:	5b                   	pop    %ebx
  80123e:	5e                   	pop    %esi
  80123f:	5d                   	pop    %ebp
  801240:	c3                   	ret    

00801241 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801241:	55                   	push   %ebp
  801242:	89 e5                	mov    %esp,%ebp
  801244:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801247:	8d 45 10             	lea    0x10(%ebp),%eax
  80124a:	83 c0 04             	add    $0x4,%eax
  80124d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801250:	8b 45 10             	mov    0x10(%ebp),%eax
  801253:	ff 75 f4             	pushl  -0xc(%ebp)
  801256:	50                   	push   %eax
  801257:	ff 75 0c             	pushl  0xc(%ebp)
  80125a:	ff 75 08             	pushl  0x8(%ebp)
  80125d:	e8 16 fc ff ff       	call   800e78 <vprintfmt>
  801262:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801265:	90                   	nop
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80126b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126e:	8b 40 08             	mov    0x8(%eax),%eax
  801271:	8d 50 01             	lea    0x1(%eax),%edx
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	8b 10                	mov    (%eax),%edx
  80127f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801282:	8b 40 04             	mov    0x4(%eax),%eax
  801285:	39 c2                	cmp    %eax,%edx
  801287:	73 12                	jae    80129b <sprintputch+0x33>
		*b->buf++ = ch;
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	8b 00                	mov    (%eax),%eax
  80128e:	8d 48 01             	lea    0x1(%eax),%ecx
  801291:	8b 55 0c             	mov    0xc(%ebp),%edx
  801294:	89 0a                	mov    %ecx,(%edx)
  801296:	8b 55 08             	mov    0x8(%ebp),%edx
  801299:	88 10                	mov    %dl,(%eax)
}
  80129b:	90                   	nop
  80129c:	5d                   	pop    %ebp
  80129d:	c3                   	ret    

0080129e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
  8012a1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	01 d0                	add    %edx,%eax
  8012b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c3:	74 06                	je     8012cb <vsnprintf+0x2d>
  8012c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012c9:	7f 07                	jg     8012d2 <vsnprintf+0x34>
		return -E_INVAL;
  8012cb:	b8 03 00 00 00       	mov    $0x3,%eax
  8012d0:	eb 20                	jmp    8012f2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012d2:	ff 75 14             	pushl  0x14(%ebp)
  8012d5:	ff 75 10             	pushl  0x10(%ebp)
  8012d8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012db:	50                   	push   %eax
  8012dc:	68 68 12 80 00       	push   $0x801268
  8012e1:	e8 92 fb ff ff       	call   800e78 <vprintfmt>
  8012e6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012ec:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012f2:	c9                   	leave  
  8012f3:	c3                   	ret    

008012f4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012f4:	55                   	push   %ebp
  8012f5:	89 e5                	mov    %esp,%ebp
  8012f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012fa:	8d 45 10             	lea    0x10(%ebp),%eax
  8012fd:	83 c0 04             	add    $0x4,%eax
  801300:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801303:	8b 45 10             	mov    0x10(%ebp),%eax
  801306:	ff 75 f4             	pushl  -0xc(%ebp)
  801309:	50                   	push   %eax
  80130a:	ff 75 0c             	pushl  0xc(%ebp)
  80130d:	ff 75 08             	pushl  0x8(%ebp)
  801310:	e8 89 ff ff ff       	call   80129e <vsnprintf>
  801315:	83 c4 10             	add    $0x10,%esp
  801318:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80131b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80131e:	c9                   	leave  
  80131f:	c3                   	ret    

00801320 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801320:	55                   	push   %ebp
  801321:	89 e5                	mov    %esp,%ebp
  801323:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80132d:	eb 06                	jmp    801335 <strlen+0x15>
		n++;
  80132f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801332:	ff 45 08             	incl   0x8(%ebp)
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	8a 00                	mov    (%eax),%al
  80133a:	84 c0                	test   %al,%al
  80133c:	75 f1                	jne    80132f <strlen+0xf>
		n++;
	return n;
  80133e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
  801346:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801349:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801350:	eb 09                	jmp    80135b <strnlen+0x18>
		n++;
  801352:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801355:	ff 45 08             	incl   0x8(%ebp)
  801358:	ff 4d 0c             	decl   0xc(%ebp)
  80135b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80135f:	74 09                	je     80136a <strnlen+0x27>
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	84 c0                	test   %al,%al
  801368:	75 e8                	jne    801352 <strnlen+0xf>
		n++;
	return n;
  80136a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
  801372:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80137b:	90                   	nop
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8d 50 01             	lea    0x1(%eax),%edx
  801382:	89 55 08             	mov    %edx,0x8(%ebp)
  801385:	8b 55 0c             	mov    0xc(%ebp),%edx
  801388:	8d 4a 01             	lea    0x1(%edx),%ecx
  80138b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80138e:	8a 12                	mov    (%edx),%dl
  801390:	88 10                	mov    %dl,(%eax)
  801392:	8a 00                	mov    (%eax),%al
  801394:	84 c0                	test   %al,%al
  801396:	75 e4                	jne    80137c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801398:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80139b:	c9                   	leave  
  80139c:	c3                   	ret    

0080139d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
  8013a0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b0:	eb 1f                	jmp    8013d1 <strncpy+0x34>
		*dst++ = *src;
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8d 50 01             	lea    0x1(%eax),%edx
  8013b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8013bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013be:	8a 12                	mov    (%edx),%dl
  8013c0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	84 c0                	test   %al,%al
  8013c9:	74 03                	je     8013ce <strncpy+0x31>
			src++;
  8013cb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013ce:	ff 45 fc             	incl   -0x4(%ebp)
  8013d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013d4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013d7:	72 d9                	jb     8013b2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013dc:	c9                   	leave  
  8013dd:	c3                   	ret    

008013de <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
  8013e1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ee:	74 30                	je     801420 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013f0:	eb 16                	jmp    801408 <strlcpy+0x2a>
			*dst++ = *src++;
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f5:	8d 50 01             	lea    0x1(%eax),%edx
  8013f8:	89 55 08             	mov    %edx,0x8(%ebp)
  8013fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801401:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801404:	8a 12                	mov    (%edx),%dl
  801406:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801408:	ff 4d 10             	decl   0x10(%ebp)
  80140b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140f:	74 09                	je     80141a <strlcpy+0x3c>
  801411:	8b 45 0c             	mov    0xc(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	84 c0                	test   %al,%al
  801418:	75 d8                	jne    8013f2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801420:	8b 55 08             	mov    0x8(%ebp),%edx
  801423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801426:	29 c2                	sub    %eax,%edx
  801428:	89 d0                	mov    %edx,%eax
}
  80142a:	c9                   	leave  
  80142b:	c3                   	ret    

0080142c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80142c:	55                   	push   %ebp
  80142d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80142f:	eb 06                	jmp    801437 <strcmp+0xb>
		p++, q++;
  801431:	ff 45 08             	incl   0x8(%ebp)
  801434:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	8a 00                	mov    (%eax),%al
  80143c:	84 c0                	test   %al,%al
  80143e:	74 0e                	je     80144e <strcmp+0x22>
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 10                	mov    (%eax),%dl
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	8a 00                	mov    (%eax),%al
  80144a:	38 c2                	cmp    %al,%dl
  80144c:	74 e3                	je     801431 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	0f b6 d0             	movzbl %al,%edx
  801456:	8b 45 0c             	mov    0xc(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	0f b6 c0             	movzbl %al,%eax
  80145e:	29 c2                	sub    %eax,%edx
  801460:	89 d0                	mov    %edx,%eax
}
  801462:	5d                   	pop    %ebp
  801463:	c3                   	ret    

00801464 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801467:	eb 09                	jmp    801472 <strncmp+0xe>
		n--, p++, q++;
  801469:	ff 4d 10             	decl   0x10(%ebp)
  80146c:	ff 45 08             	incl   0x8(%ebp)
  80146f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801472:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801476:	74 17                	je     80148f <strncmp+0x2b>
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	84 c0                	test   %al,%al
  80147f:	74 0e                	je     80148f <strncmp+0x2b>
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	8a 10                	mov    (%eax),%dl
  801486:	8b 45 0c             	mov    0xc(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	38 c2                	cmp    %al,%dl
  80148d:	74 da                	je     801469 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80148f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801493:	75 07                	jne    80149c <strncmp+0x38>
		return 0;
  801495:	b8 00 00 00 00       	mov    $0x0,%eax
  80149a:	eb 14                	jmp    8014b0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8a 00                	mov    (%eax),%al
  8014a1:	0f b6 d0             	movzbl %al,%edx
  8014a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	0f b6 c0             	movzbl %al,%eax
  8014ac:	29 c2                	sub    %eax,%edx
  8014ae:	89 d0                	mov    %edx,%eax
}
  8014b0:	5d                   	pop    %ebp
  8014b1:	c3                   	ret    

008014b2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
  8014b5:	83 ec 04             	sub    $0x4,%esp
  8014b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014be:	eb 12                	jmp    8014d2 <strchr+0x20>
		if (*s == c)
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	8a 00                	mov    (%eax),%al
  8014c5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014c8:	75 05                	jne    8014cf <strchr+0x1d>
			return (char *) s;
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	eb 11                	jmp    8014e0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014cf:	ff 45 08             	incl   0x8(%ebp)
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d5:	8a 00                	mov    (%eax),%al
  8014d7:	84 c0                	test   %al,%al
  8014d9:	75 e5                	jne    8014c0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
  8014e5:	83 ec 04             	sub    $0x4,%esp
  8014e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014ee:	eb 0d                	jmp    8014fd <strfind+0x1b>
		if (*s == c)
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8a 00                	mov    (%eax),%al
  8014f5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014f8:	74 0e                	je     801508 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014fa:	ff 45 08             	incl   0x8(%ebp)
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	8a 00                	mov    (%eax),%al
  801502:	84 c0                	test   %al,%al
  801504:	75 ea                	jne    8014f0 <strfind+0xe>
  801506:	eb 01                	jmp    801509 <strfind+0x27>
		if (*s == c)
			break;
  801508:	90                   	nop
	return (char *) s;
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
  801511:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801520:	eb 0e                	jmp    801530 <memset+0x22>
		*p++ = c;
  801522:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801525:	8d 50 01             	lea    0x1(%eax),%edx
  801528:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80152b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801530:	ff 4d f8             	decl   -0x8(%ebp)
  801533:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801537:	79 e9                	jns    801522 <memset+0x14>
		*p++ = c;

	return v;
  801539:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
  801541:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801544:	8b 45 0c             	mov    0xc(%ebp),%eax
  801547:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801550:	eb 16                	jmp    801568 <memcpy+0x2a>
		*d++ = *s++;
  801552:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801555:	8d 50 01             	lea    0x1(%eax),%edx
  801558:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80155b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80155e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801561:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801564:	8a 12                	mov    (%edx),%dl
  801566:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801568:	8b 45 10             	mov    0x10(%ebp),%eax
  80156b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80156e:	89 55 10             	mov    %edx,0x10(%ebp)
  801571:	85 c0                	test   %eax,%eax
  801573:	75 dd                	jne    801552 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
  80157d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801580:	8b 45 0c             	mov    0xc(%ebp),%eax
  801583:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80158c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801592:	73 50                	jae    8015e4 <memmove+0x6a>
  801594:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801597:	8b 45 10             	mov    0x10(%ebp),%eax
  80159a:	01 d0                	add    %edx,%eax
  80159c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80159f:	76 43                	jbe    8015e4 <memmove+0x6a>
		s += n;
  8015a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015aa:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015ad:	eb 10                	jmp    8015bf <memmove+0x45>
			*--d = *--s;
  8015af:	ff 4d f8             	decl   -0x8(%ebp)
  8015b2:	ff 4d fc             	decl   -0x4(%ebp)
  8015b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b8:	8a 10                	mov    (%eax),%dl
  8015ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015bd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c8:	85 c0                	test   %eax,%eax
  8015ca:	75 e3                	jne    8015af <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015cc:	eb 23                	jmp    8015f1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d1:	8d 50 01             	lea    0x1(%eax),%edx
  8015d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015dd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015e0:	8a 12                	mov    (%edx),%dl
  8015e2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ed:	85 c0                	test   %eax,%eax
  8015ef:	75 dd                	jne    8015ce <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
  8015f9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801602:	8b 45 0c             	mov    0xc(%ebp),%eax
  801605:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801608:	eb 2a                	jmp    801634 <memcmp+0x3e>
		if (*s1 != *s2)
  80160a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160d:	8a 10                	mov    (%eax),%dl
  80160f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801612:	8a 00                	mov    (%eax),%al
  801614:	38 c2                	cmp    %al,%dl
  801616:	74 16                	je     80162e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801618:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161b:	8a 00                	mov    (%eax),%al
  80161d:	0f b6 d0             	movzbl %al,%edx
  801620:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	0f b6 c0             	movzbl %al,%eax
  801628:	29 c2                	sub    %eax,%edx
  80162a:	89 d0                	mov    %edx,%eax
  80162c:	eb 18                	jmp    801646 <memcmp+0x50>
		s1++, s2++;
  80162e:	ff 45 fc             	incl   -0x4(%ebp)
  801631:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801634:	8b 45 10             	mov    0x10(%ebp),%eax
  801637:	8d 50 ff             	lea    -0x1(%eax),%edx
  80163a:	89 55 10             	mov    %edx,0x10(%ebp)
  80163d:	85 c0                	test   %eax,%eax
  80163f:	75 c9                	jne    80160a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801641:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801646:	c9                   	leave  
  801647:	c3                   	ret    

00801648 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801648:	55                   	push   %ebp
  801649:	89 e5                	mov    %esp,%ebp
  80164b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80164e:	8b 55 08             	mov    0x8(%ebp),%edx
  801651:	8b 45 10             	mov    0x10(%ebp),%eax
  801654:	01 d0                	add    %edx,%eax
  801656:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801659:	eb 15                	jmp    801670 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8a 00                	mov    (%eax),%al
  801660:	0f b6 d0             	movzbl %al,%edx
  801663:	8b 45 0c             	mov    0xc(%ebp),%eax
  801666:	0f b6 c0             	movzbl %al,%eax
  801669:	39 c2                	cmp    %eax,%edx
  80166b:	74 0d                	je     80167a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80166d:	ff 45 08             	incl   0x8(%ebp)
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801676:	72 e3                	jb     80165b <memfind+0x13>
  801678:	eb 01                	jmp    80167b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80167a:	90                   	nop
	return (void *) s;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801686:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80168d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801694:	eb 03                	jmp    801699 <strtol+0x19>
		s++;
  801696:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	3c 20                	cmp    $0x20,%al
  8016a0:	74 f4                	je     801696 <strtol+0x16>
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	3c 09                	cmp    $0x9,%al
  8016a9:	74 eb                	je     801696 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	3c 2b                	cmp    $0x2b,%al
  8016b2:	75 05                	jne    8016b9 <strtol+0x39>
		s++;
  8016b4:	ff 45 08             	incl   0x8(%ebp)
  8016b7:	eb 13                	jmp    8016cc <strtol+0x4c>
	else if (*s == '-')
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	3c 2d                	cmp    $0x2d,%al
  8016c0:	75 0a                	jne    8016cc <strtol+0x4c>
		s++, neg = 1;
  8016c2:	ff 45 08             	incl   0x8(%ebp)
  8016c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d0:	74 06                	je     8016d8 <strtol+0x58>
  8016d2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016d6:	75 20                	jne    8016f8 <strtol+0x78>
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	8a 00                	mov    (%eax),%al
  8016dd:	3c 30                	cmp    $0x30,%al
  8016df:	75 17                	jne    8016f8 <strtol+0x78>
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	40                   	inc    %eax
  8016e5:	8a 00                	mov    (%eax),%al
  8016e7:	3c 78                	cmp    $0x78,%al
  8016e9:	75 0d                	jne    8016f8 <strtol+0x78>
		s += 2, base = 16;
  8016eb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016ef:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016f6:	eb 28                	jmp    801720 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016fc:	75 15                	jne    801713 <strtol+0x93>
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	3c 30                	cmp    $0x30,%al
  801705:	75 0c                	jne    801713 <strtol+0x93>
		s++, base = 8;
  801707:	ff 45 08             	incl   0x8(%ebp)
  80170a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801711:	eb 0d                	jmp    801720 <strtol+0xa0>
	else if (base == 0)
  801713:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801717:	75 07                	jne    801720 <strtol+0xa0>
		base = 10;
  801719:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	8a 00                	mov    (%eax),%al
  801725:	3c 2f                	cmp    $0x2f,%al
  801727:	7e 19                	jle    801742 <strtol+0xc2>
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	8a 00                	mov    (%eax),%al
  80172e:	3c 39                	cmp    $0x39,%al
  801730:	7f 10                	jg     801742 <strtol+0xc2>
			dig = *s - '0';
  801732:	8b 45 08             	mov    0x8(%ebp),%eax
  801735:	8a 00                	mov    (%eax),%al
  801737:	0f be c0             	movsbl %al,%eax
  80173a:	83 e8 30             	sub    $0x30,%eax
  80173d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801740:	eb 42                	jmp    801784 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 00                	mov    (%eax),%al
  801747:	3c 60                	cmp    $0x60,%al
  801749:	7e 19                	jle    801764 <strtol+0xe4>
  80174b:	8b 45 08             	mov    0x8(%ebp),%eax
  80174e:	8a 00                	mov    (%eax),%al
  801750:	3c 7a                	cmp    $0x7a,%al
  801752:	7f 10                	jg     801764 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801754:	8b 45 08             	mov    0x8(%ebp),%eax
  801757:	8a 00                	mov    (%eax),%al
  801759:	0f be c0             	movsbl %al,%eax
  80175c:	83 e8 57             	sub    $0x57,%eax
  80175f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801762:	eb 20                	jmp    801784 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	8a 00                	mov    (%eax),%al
  801769:	3c 40                	cmp    $0x40,%al
  80176b:	7e 39                	jle    8017a6 <strtol+0x126>
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	3c 5a                	cmp    $0x5a,%al
  801774:	7f 30                	jg     8017a6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801776:	8b 45 08             	mov    0x8(%ebp),%eax
  801779:	8a 00                	mov    (%eax),%al
  80177b:	0f be c0             	movsbl %al,%eax
  80177e:	83 e8 37             	sub    $0x37,%eax
  801781:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801784:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801787:	3b 45 10             	cmp    0x10(%ebp),%eax
  80178a:	7d 19                	jge    8017a5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80178c:	ff 45 08             	incl   0x8(%ebp)
  80178f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801792:	0f af 45 10          	imul   0x10(%ebp),%eax
  801796:	89 c2                	mov    %eax,%edx
  801798:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179b:	01 d0                	add    %edx,%eax
  80179d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017a0:	e9 7b ff ff ff       	jmp    801720 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017a5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017aa:	74 08                	je     8017b4 <strtol+0x134>
		*endptr = (char *) s;
  8017ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017af:	8b 55 08             	mov    0x8(%ebp),%edx
  8017b2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017b8:	74 07                	je     8017c1 <strtol+0x141>
  8017ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017bd:	f7 d8                	neg    %eax
  8017bf:	eb 03                	jmp    8017c4 <strtol+0x144>
  8017c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <ltostr>:

void
ltostr(long value, char *str)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017de:	79 13                	jns    8017f3 <ltostr+0x2d>
	{
		neg = 1;
  8017e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ea:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017ed:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017f0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017fb:	99                   	cltd   
  8017fc:	f7 f9                	idiv   %ecx
  8017fe:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801801:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801804:	8d 50 01             	lea    0x1(%eax),%edx
  801807:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80180a:	89 c2                	mov    %eax,%edx
  80180c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180f:	01 d0                	add    %edx,%eax
  801811:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801814:	83 c2 30             	add    $0x30,%edx
  801817:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801819:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80181c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801821:	f7 e9                	imul   %ecx
  801823:	c1 fa 02             	sar    $0x2,%edx
  801826:	89 c8                	mov    %ecx,%eax
  801828:	c1 f8 1f             	sar    $0x1f,%eax
  80182b:	29 c2                	sub    %eax,%edx
  80182d:	89 d0                	mov    %edx,%eax
  80182f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801832:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801835:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183a:	f7 e9                	imul   %ecx
  80183c:	c1 fa 02             	sar    $0x2,%edx
  80183f:	89 c8                	mov    %ecx,%eax
  801841:	c1 f8 1f             	sar    $0x1f,%eax
  801844:	29 c2                	sub    %eax,%edx
  801846:	89 d0                	mov    %edx,%eax
  801848:	c1 e0 02             	shl    $0x2,%eax
  80184b:	01 d0                	add    %edx,%eax
  80184d:	01 c0                	add    %eax,%eax
  80184f:	29 c1                	sub    %eax,%ecx
  801851:	89 ca                	mov    %ecx,%edx
  801853:	85 d2                	test   %edx,%edx
  801855:	75 9c                	jne    8017f3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801857:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80185e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801861:	48                   	dec    %eax
  801862:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801865:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801869:	74 3d                	je     8018a8 <ltostr+0xe2>
		start = 1 ;
  80186b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801872:	eb 34                	jmp    8018a8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801874:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187a:	01 d0                	add    %edx,%eax
  80187c:	8a 00                	mov    (%eax),%al
  80187e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801881:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801884:	8b 45 0c             	mov    0xc(%ebp),%eax
  801887:	01 c2                	add    %eax,%edx
  801889:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80188c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188f:	01 c8                	add    %ecx,%eax
  801891:	8a 00                	mov    (%eax),%al
  801893:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801895:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189b:	01 c2                	add    %eax,%edx
  80189d:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018a0:	88 02                	mov    %al,(%edx)
		start++ ;
  8018a2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018a5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018ae:	7c c4                	jl     801874 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b6:	01 d0                	add    %edx,%eax
  8018b8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018bb:	90                   	nop
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
  8018c1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018c4:	ff 75 08             	pushl  0x8(%ebp)
  8018c7:	e8 54 fa ff ff       	call   801320 <strlen>
  8018cc:	83 c4 04             	add    $0x4,%esp
  8018cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018d2:	ff 75 0c             	pushl  0xc(%ebp)
  8018d5:	e8 46 fa ff ff       	call   801320 <strlen>
  8018da:	83 c4 04             	add    $0x4,%esp
  8018dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018ee:	eb 17                	jmp    801907 <strcconcat+0x49>
		final[s] = str1[s] ;
  8018f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f6:	01 c2                	add    %eax,%edx
  8018f8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	01 c8                	add    %ecx,%eax
  801900:	8a 00                	mov    (%eax),%al
  801902:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801904:	ff 45 fc             	incl   -0x4(%ebp)
  801907:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80190a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80190d:	7c e1                	jl     8018f0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80190f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801916:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80191d:	eb 1f                	jmp    80193e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80191f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801922:	8d 50 01             	lea    0x1(%eax),%edx
  801925:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801928:	89 c2                	mov    %eax,%edx
  80192a:	8b 45 10             	mov    0x10(%ebp),%eax
  80192d:	01 c2                	add    %eax,%edx
  80192f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801932:	8b 45 0c             	mov    0xc(%ebp),%eax
  801935:	01 c8                	add    %ecx,%eax
  801937:	8a 00                	mov    (%eax),%al
  801939:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80193b:	ff 45 f8             	incl   -0x8(%ebp)
  80193e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801941:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801944:	7c d9                	jl     80191f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801946:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801949:	8b 45 10             	mov    0x10(%ebp),%eax
  80194c:	01 d0                	add    %edx,%eax
  80194e:	c6 00 00             	movb   $0x0,(%eax)
}
  801951:	90                   	nop
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801957:	8b 45 14             	mov    0x14(%ebp),%eax
  80195a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801960:	8b 45 14             	mov    0x14(%ebp),%eax
  801963:	8b 00                	mov    (%eax),%eax
  801965:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80196c:	8b 45 10             	mov    0x10(%ebp),%eax
  80196f:	01 d0                	add    %edx,%eax
  801971:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801977:	eb 0c                	jmp    801985 <strsplit+0x31>
			*string++ = 0;
  801979:	8b 45 08             	mov    0x8(%ebp),%eax
  80197c:	8d 50 01             	lea    0x1(%eax),%edx
  80197f:	89 55 08             	mov    %edx,0x8(%ebp)
  801982:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	84 c0                	test   %al,%al
  80198c:	74 18                	je     8019a6 <strsplit+0x52>
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	8a 00                	mov    (%eax),%al
  801993:	0f be c0             	movsbl %al,%eax
  801996:	50                   	push   %eax
  801997:	ff 75 0c             	pushl  0xc(%ebp)
  80199a:	e8 13 fb ff ff       	call   8014b2 <strchr>
  80199f:	83 c4 08             	add    $0x8,%esp
  8019a2:	85 c0                	test   %eax,%eax
  8019a4:	75 d3                	jne    801979 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8019a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a9:	8a 00                	mov    (%eax),%al
  8019ab:	84 c0                	test   %al,%al
  8019ad:	74 5a                	je     801a09 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8019af:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b2:	8b 00                	mov    (%eax),%eax
  8019b4:	83 f8 0f             	cmp    $0xf,%eax
  8019b7:	75 07                	jne    8019c0 <strsplit+0x6c>
		{
			return 0;
  8019b9:	b8 00 00 00 00       	mov    $0x0,%eax
  8019be:	eb 66                	jmp    801a26 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c3:	8b 00                	mov    (%eax),%eax
  8019c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8019c8:	8b 55 14             	mov    0x14(%ebp),%edx
  8019cb:	89 0a                	mov    %ecx,(%edx)
  8019cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d7:	01 c2                	add    %eax,%edx
  8019d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019de:	eb 03                	jmp    8019e3 <strsplit+0x8f>
			string++;
  8019e0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	8a 00                	mov    (%eax),%al
  8019e8:	84 c0                	test   %al,%al
  8019ea:	74 8b                	je     801977 <strsplit+0x23>
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	8a 00                	mov    (%eax),%al
  8019f1:	0f be c0             	movsbl %al,%eax
  8019f4:	50                   	push   %eax
  8019f5:	ff 75 0c             	pushl  0xc(%ebp)
  8019f8:	e8 b5 fa ff ff       	call   8014b2 <strchr>
  8019fd:	83 c4 08             	add    $0x8,%esp
  801a00:	85 c0                	test   %eax,%eax
  801a02:	74 dc                	je     8019e0 <strsplit+0x8c>
			string++;
	}
  801a04:	e9 6e ff ff ff       	jmp    801977 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a09:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a0a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0d:	8b 00                	mov    (%eax),%eax
  801a0f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a16:	8b 45 10             	mov    0x10(%ebp),%eax
  801a19:	01 d0                	add    %edx,%eax
  801a1b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a21:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a26:	c9                   	leave  
  801a27:	c3                   	ret    

00801a28 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
  801a2b:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801a2e:	e8 9b 07 00 00       	call   8021ce <sys_isUHeapPlacementStrategyNEXTFIT>
  801a33:	85 c0                	test   %eax,%eax
  801a35:	0f 84 64 01 00 00    	je     801b9f <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801a3b:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801a41:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801a48:	8b 55 08             	mov    0x8(%ebp),%edx
  801a4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a4e:	01 d0                	add    %edx,%eax
  801a50:	48                   	dec    %eax
  801a51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801a54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a57:	ba 00 00 00 00       	mov    $0x0,%edx
  801a5c:	f7 75 e8             	divl   -0x18(%ebp)
  801a5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a62:	29 d0                	sub    %edx,%eax
  801a64:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801a6b:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	01 d0                	add    %edx,%eax
  801a76:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801a79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801a80:	a1 28 30 80 00       	mov    0x803028,%eax
  801a85:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a8c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801a8f:	0f 83 0a 01 00 00    	jae    801b9f <malloc+0x177>
  801a95:	a1 28 30 80 00       	mov    0x803028,%eax
  801a9a:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801aa1:	85 c0                	test   %eax,%eax
  801aa3:	0f 84 f6 00 00 00    	je     801b9f <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801aa9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ab0:	e9 dc 00 00 00       	jmp    801b91 <malloc+0x169>
				flag++;
  801ab5:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801abb:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801ac2:	85 c0                	test   %eax,%eax
  801ac4:	74 07                	je     801acd <malloc+0xa5>
					flag=0;
  801ac6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801acd:	a1 28 30 80 00       	mov    0x803028,%eax
  801ad2:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801ad9:	85 c0                	test   %eax,%eax
  801adb:	79 05                	jns    801ae2 <malloc+0xba>
  801add:	05 ff 0f 00 00       	add    $0xfff,%eax
  801ae2:	c1 f8 0c             	sar    $0xc,%eax
  801ae5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ae8:	0f 85 a0 00 00 00    	jne    801b8e <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801aee:	a1 28 30 80 00       	mov    0x803028,%eax
  801af3:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801afa:	85 c0                	test   %eax,%eax
  801afc:	79 05                	jns    801b03 <malloc+0xdb>
  801afe:	05 ff 0f 00 00       	add    $0xfff,%eax
  801b03:	c1 f8 0c             	sar    $0xc,%eax
  801b06:	89 c2                	mov    %eax,%edx
  801b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b0b:	29 d0                	sub    %edx,%eax
  801b0d:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801b10:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b16:	eb 11                	jmp    801b29 <malloc+0x101>
						hFreeArr[j] = 1;
  801b18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b1b:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801b22:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801b26:	ff 45 ec             	incl   -0x14(%ebp)
  801b29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b2c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b2f:	7e e7                	jle    801b18 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801b31:	a1 28 30 80 00       	mov    0x803028,%eax
  801b36:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801b39:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801b3f:	c1 e2 0c             	shl    $0xc,%edx
  801b42:	89 15 04 30 80 00    	mov    %edx,0x803004
  801b48:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b4e:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801b55:	a1 28 30 80 00       	mov    0x803028,%eax
  801b5a:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b61:	89 c2                	mov    %eax,%edx
  801b63:	a1 28 30 80 00       	mov    0x803028,%eax
  801b68:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801b6f:	83 ec 08             	sub    $0x8,%esp
  801b72:	52                   	push   %edx
  801b73:	50                   	push   %eax
  801b74:	e8 8b 02 00 00       	call   801e04 <sys_allocateMem>
  801b79:	83 c4 10             	add    $0x10,%esp

					idx++;
  801b7c:	a1 28 30 80 00       	mov    0x803028,%eax
  801b81:	40                   	inc    %eax
  801b82:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801b87:	a1 04 30 80 00       	mov    0x803004,%eax
  801b8c:	eb 16                	jmp    801ba4 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801b8e:	ff 45 f0             	incl   -0x10(%ebp)
  801b91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b94:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b99:	0f 86 16 ff ff ff    	jbe    801ab5 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801b9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
  801ba9:	83 ec 18             	sub    $0x18,%esp
  801bac:	8b 45 10             	mov    0x10(%ebp),%eax
  801baf:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801bb2:	83 ec 04             	sub    $0x4,%esp
  801bb5:	68 70 2b 80 00       	push   $0x802b70
  801bba:	6a 59                	push   $0x59
  801bbc:	68 8f 2b 80 00       	push   $0x802b8f
  801bc1:	e8 24 ee ff ff       	call   8009ea <_panic>

00801bc6 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
  801bc9:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801bcc:	83 ec 04             	sub    $0x4,%esp
  801bcf:	68 9b 2b 80 00       	push   $0x802b9b
  801bd4:	6a 5f                	push   $0x5f
  801bd6:	68 8f 2b 80 00       	push   $0x802b8f
  801bdb:	e8 0a ee ff ff       	call   8009ea <_panic>

00801be0 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
  801be3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801be6:	83 ec 04             	sub    $0x4,%esp
  801be9:	68 b8 2b 80 00       	push   $0x802bb8
  801bee:	6a 70                	push   $0x70
  801bf0:	68 8f 2b 80 00       	push   $0x802b8f
  801bf5:	e8 f0 ed ff ff       	call   8009ea <_panic>

00801bfa <sfree>:

}


void sfree(void* virtual_address)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
  801bfd:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801c00:	83 ec 04             	sub    $0x4,%esp
  801c03:	68 db 2b 80 00       	push   $0x802bdb
  801c08:	6a 7b                	push   $0x7b
  801c0a:	68 8f 2b 80 00       	push   $0x802b8f
  801c0f:	e8 d6 ed ff ff       	call   8009ea <_panic>

00801c14 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
  801c17:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c1a:	83 ec 04             	sub    $0x4,%esp
  801c1d:	68 f8 2b 80 00       	push   $0x802bf8
  801c22:	68 93 00 00 00       	push   $0x93
  801c27:	68 8f 2b 80 00       	push   $0x802b8f
  801c2c:	e8 b9 ed ff ff       	call   8009ea <_panic>

00801c31 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c31:	55                   	push   %ebp
  801c32:	89 e5                	mov    %esp,%ebp
  801c34:	57                   	push   %edi
  801c35:	56                   	push   %esi
  801c36:	53                   	push   %ebx
  801c37:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c40:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c43:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c46:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c49:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c4c:	cd 30                	int    $0x30
  801c4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c54:	83 c4 10             	add    $0x10,%esp
  801c57:	5b                   	pop    %ebx
  801c58:	5e                   	pop    %esi
  801c59:	5f                   	pop    %edi
  801c5a:	5d                   	pop    %ebp
  801c5b:	c3                   	ret    

00801c5c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
  801c5f:	83 ec 04             	sub    $0x4,%esp
  801c62:	8b 45 10             	mov    0x10(%ebp),%eax
  801c65:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c68:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	52                   	push   %edx
  801c74:	ff 75 0c             	pushl  0xc(%ebp)
  801c77:	50                   	push   %eax
  801c78:	6a 00                	push   $0x0
  801c7a:	e8 b2 ff ff ff       	call   801c31 <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	90                   	nop
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 01                	push   $0x1
  801c94:	e8 98 ff ff ff       	call   801c31 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
}
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	50                   	push   %eax
  801cad:	6a 05                	push   $0x5
  801caf:	e8 7d ff ff ff       	call   801c31 <syscall>
  801cb4:	83 c4 18             	add    $0x18,%esp
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 02                	push   $0x2
  801cc8:	e8 64 ff ff ff       	call   801c31 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 03                	push   $0x3
  801ce1:	e8 4b ff ff ff       	call   801c31 <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 04                	push   $0x4
  801cfa:	e8 32 ff ff ff       	call   801c31 <syscall>
  801cff:	83 c4 18             	add    $0x18,%esp
}
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <sys_env_exit>:


void sys_env_exit(void)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 06                	push   $0x6
  801d13:	e8 19 ff ff ff       	call   801c31 <syscall>
  801d18:	83 c4 18             	add    $0x18,%esp
}
  801d1b:	90                   	nop
  801d1c:	c9                   	leave  
  801d1d:	c3                   	ret    

00801d1e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d1e:	55                   	push   %ebp
  801d1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d24:	8b 45 08             	mov    0x8(%ebp),%eax
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	52                   	push   %edx
  801d2e:	50                   	push   %eax
  801d2f:	6a 07                	push   $0x7
  801d31:	e8 fb fe ff ff       	call   801c31 <syscall>
  801d36:	83 c4 18             	add    $0x18,%esp
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
  801d3e:	56                   	push   %esi
  801d3f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d40:	8b 75 18             	mov    0x18(%ebp),%esi
  801d43:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d46:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4f:	56                   	push   %esi
  801d50:	53                   	push   %ebx
  801d51:	51                   	push   %ecx
  801d52:	52                   	push   %edx
  801d53:	50                   	push   %eax
  801d54:	6a 08                	push   $0x8
  801d56:	e8 d6 fe ff ff       	call   801c31 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
}
  801d5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d61:	5b                   	pop    %ebx
  801d62:	5e                   	pop    %esi
  801d63:	5d                   	pop    %ebp
  801d64:	c3                   	ret    

00801d65 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d68:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	52                   	push   %edx
  801d75:	50                   	push   %eax
  801d76:	6a 09                	push   $0x9
  801d78:	e8 b4 fe ff ff       	call   801c31 <syscall>
  801d7d:	83 c4 18             	add    $0x18,%esp
}
  801d80:	c9                   	leave  
  801d81:	c3                   	ret    

00801d82 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d82:	55                   	push   %ebp
  801d83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	ff 75 0c             	pushl  0xc(%ebp)
  801d8e:	ff 75 08             	pushl  0x8(%ebp)
  801d91:	6a 0a                	push   $0xa
  801d93:	e8 99 fe ff ff       	call   801c31 <syscall>
  801d98:	83 c4 18             	add    $0x18,%esp
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 0b                	push   $0xb
  801dac:	e8 80 fe ff ff       	call   801c31 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 0c                	push   $0xc
  801dc5:	e8 67 fe ff ff       	call   801c31 <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
}
  801dcd:	c9                   	leave  
  801dce:	c3                   	ret    

00801dcf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dcf:	55                   	push   %ebp
  801dd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 0d                	push   $0xd
  801dde:	e8 4e fe ff ff       	call   801c31 <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	ff 75 0c             	pushl  0xc(%ebp)
  801df4:	ff 75 08             	pushl  0x8(%ebp)
  801df7:	6a 11                	push   $0x11
  801df9:	e8 33 fe ff ff       	call   801c31 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
	return;
  801e01:	90                   	nop
}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	ff 75 0c             	pushl  0xc(%ebp)
  801e10:	ff 75 08             	pushl  0x8(%ebp)
  801e13:	6a 12                	push   $0x12
  801e15:	e8 17 fe ff ff       	call   801c31 <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e1d:	90                   	nop
}
  801e1e:	c9                   	leave  
  801e1f:	c3                   	ret    

00801e20 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e20:	55                   	push   %ebp
  801e21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 0e                	push   $0xe
  801e2f:	e8 fd fd ff ff       	call   801c31 <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
}
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	ff 75 08             	pushl  0x8(%ebp)
  801e47:	6a 0f                	push   $0xf
  801e49:	e8 e3 fd ff ff       	call   801c31 <syscall>
  801e4e:	83 c4 18             	add    $0x18,%esp
}
  801e51:	c9                   	leave  
  801e52:	c3                   	ret    

00801e53 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e53:	55                   	push   %ebp
  801e54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 10                	push   $0x10
  801e62:	e8 ca fd ff ff       	call   801c31 <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
}
  801e6a:	90                   	nop
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 14                	push   $0x14
  801e7c:	e8 b0 fd ff ff       	call   801c31 <syscall>
  801e81:	83 c4 18             	add    $0x18,%esp
}
  801e84:	90                   	nop
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 15                	push   $0x15
  801e96:	e8 96 fd ff ff       	call   801c31 <syscall>
  801e9b:	83 c4 18             	add    $0x18,%esp
}
  801e9e:	90                   	nop
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
  801ea4:	83 ec 04             	sub    $0x4,%esp
  801ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ead:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	50                   	push   %eax
  801eba:	6a 16                	push   $0x16
  801ebc:	e8 70 fd ff ff       	call   801c31 <syscall>
  801ec1:	83 c4 18             	add    $0x18,%esp
}
  801ec4:	90                   	nop
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 17                	push   $0x17
  801ed6:	e8 56 fd ff ff       	call   801c31 <syscall>
  801edb:	83 c4 18             	add    $0x18,%esp
}
  801ede:	90                   	nop
  801edf:	c9                   	leave  
  801ee0:	c3                   	ret    

00801ee1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ee1:	55                   	push   %ebp
  801ee2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	ff 75 0c             	pushl  0xc(%ebp)
  801ef0:	50                   	push   %eax
  801ef1:	6a 18                	push   $0x18
  801ef3:	e8 39 fd ff ff       	call   801c31 <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	52                   	push   %edx
  801f0d:	50                   	push   %eax
  801f0e:	6a 1b                	push   $0x1b
  801f10:	e8 1c fd ff ff       	call   801c31 <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
}
  801f18:	c9                   	leave  
  801f19:	c3                   	ret    

00801f1a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f1a:	55                   	push   %ebp
  801f1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f20:	8b 45 08             	mov    0x8(%ebp),%eax
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	52                   	push   %edx
  801f2a:	50                   	push   %eax
  801f2b:	6a 19                	push   $0x19
  801f2d:	e8 ff fc ff ff       	call   801c31 <syscall>
  801f32:	83 c4 18             	add    $0x18,%esp
}
  801f35:	90                   	nop
  801f36:	c9                   	leave  
  801f37:	c3                   	ret    

00801f38 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f38:	55                   	push   %ebp
  801f39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	52                   	push   %edx
  801f48:	50                   	push   %eax
  801f49:	6a 1a                	push   $0x1a
  801f4b:	e8 e1 fc ff ff       	call   801c31 <syscall>
  801f50:	83 c4 18             	add    $0x18,%esp
}
  801f53:	90                   	nop
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
  801f59:	83 ec 04             	sub    $0x4,%esp
  801f5c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f5f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f62:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f65:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	6a 00                	push   $0x0
  801f6e:	51                   	push   %ecx
  801f6f:	52                   	push   %edx
  801f70:	ff 75 0c             	pushl  0xc(%ebp)
  801f73:	50                   	push   %eax
  801f74:	6a 1c                	push   $0x1c
  801f76:	e8 b6 fc ff ff       	call   801c31 <syscall>
  801f7b:	83 c4 18             	add    $0x18,%esp
}
  801f7e:	c9                   	leave  
  801f7f:	c3                   	ret    

00801f80 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f80:	55                   	push   %ebp
  801f81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f86:	8b 45 08             	mov    0x8(%ebp),%eax
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	52                   	push   %edx
  801f90:	50                   	push   %eax
  801f91:	6a 1d                	push   $0x1d
  801f93:	e8 99 fc ff ff       	call   801c31 <syscall>
  801f98:	83 c4 18             	add    $0x18,%esp
}
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fa0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	51                   	push   %ecx
  801fae:	52                   	push   %edx
  801faf:	50                   	push   %eax
  801fb0:	6a 1e                	push   $0x1e
  801fb2:	e8 7a fc ff ff       	call   801c31 <syscall>
  801fb7:	83 c4 18             	add    $0x18,%esp
}
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	52                   	push   %edx
  801fcc:	50                   	push   %eax
  801fcd:	6a 1f                	push   $0x1f
  801fcf:	e8 5d fc ff ff       	call   801c31 <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
}
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 20                	push   $0x20
  801fe8:	e8 44 fc ff ff       	call   801c31 <syscall>
  801fed:	83 c4 18             	add    $0x18,%esp
}
  801ff0:	c9                   	leave  
  801ff1:	c3                   	ret    

00801ff2 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ff2:	55                   	push   %ebp
  801ff3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	ff 75 10             	pushl  0x10(%ebp)
  801fff:	ff 75 0c             	pushl  0xc(%ebp)
  802002:	50                   	push   %eax
  802003:	6a 21                	push   $0x21
  802005:	e8 27 fc ff ff       	call   801c31 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802012:	8b 45 08             	mov    0x8(%ebp),%eax
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	50                   	push   %eax
  80201e:	6a 22                	push   $0x22
  802020:	e8 0c fc ff ff       	call   801c31 <syscall>
  802025:	83 c4 18             	add    $0x18,%esp
}
  802028:	90                   	nop
  802029:	c9                   	leave  
  80202a:	c3                   	ret    

0080202b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80202b:	55                   	push   %ebp
  80202c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80202e:	8b 45 08             	mov    0x8(%ebp),%eax
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	50                   	push   %eax
  80203a:	6a 23                	push   $0x23
  80203c:	e8 f0 fb ff ff       	call   801c31 <syscall>
  802041:	83 c4 18             	add    $0x18,%esp
}
  802044:	90                   	nop
  802045:	c9                   	leave  
  802046:	c3                   	ret    

00802047 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
  80204a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80204d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802050:	8d 50 04             	lea    0x4(%eax),%edx
  802053:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	52                   	push   %edx
  80205d:	50                   	push   %eax
  80205e:	6a 24                	push   $0x24
  802060:	e8 cc fb ff ff       	call   801c31 <syscall>
  802065:	83 c4 18             	add    $0x18,%esp
	return result;
  802068:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80206b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80206e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802071:	89 01                	mov    %eax,(%ecx)
  802073:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802076:	8b 45 08             	mov    0x8(%ebp),%eax
  802079:	c9                   	leave  
  80207a:	c2 04 00             	ret    $0x4

0080207d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	ff 75 10             	pushl  0x10(%ebp)
  802087:	ff 75 0c             	pushl  0xc(%ebp)
  80208a:	ff 75 08             	pushl  0x8(%ebp)
  80208d:	6a 13                	push   $0x13
  80208f:	e8 9d fb ff ff       	call   801c31 <syscall>
  802094:	83 c4 18             	add    $0x18,%esp
	return ;
  802097:	90                   	nop
}
  802098:	c9                   	leave  
  802099:	c3                   	ret    

0080209a <sys_rcr2>:
uint32 sys_rcr2()
{
  80209a:	55                   	push   %ebp
  80209b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 25                	push   $0x25
  8020a9:	e8 83 fb ff ff       	call   801c31 <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
  8020b6:	83 ec 04             	sub    $0x4,%esp
  8020b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020bf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	50                   	push   %eax
  8020cc:	6a 26                	push   $0x26
  8020ce:	e8 5e fb ff ff       	call   801c31 <syscall>
  8020d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d6:	90                   	nop
}
  8020d7:	c9                   	leave  
  8020d8:	c3                   	ret    

008020d9 <rsttst>:
void rsttst()
{
  8020d9:	55                   	push   %ebp
  8020da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 28                	push   $0x28
  8020e8:	e8 44 fb ff ff       	call   801c31 <syscall>
  8020ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f0:	90                   	nop
}
  8020f1:	c9                   	leave  
  8020f2:	c3                   	ret    

008020f3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
  8020f6:	83 ec 04             	sub    $0x4,%esp
  8020f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8020fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020ff:	8b 55 18             	mov    0x18(%ebp),%edx
  802102:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802106:	52                   	push   %edx
  802107:	50                   	push   %eax
  802108:	ff 75 10             	pushl  0x10(%ebp)
  80210b:	ff 75 0c             	pushl  0xc(%ebp)
  80210e:	ff 75 08             	pushl  0x8(%ebp)
  802111:	6a 27                	push   $0x27
  802113:	e8 19 fb ff ff       	call   801c31 <syscall>
  802118:	83 c4 18             	add    $0x18,%esp
	return ;
  80211b:	90                   	nop
}
  80211c:	c9                   	leave  
  80211d:	c3                   	ret    

0080211e <chktst>:
void chktst(uint32 n)
{
  80211e:	55                   	push   %ebp
  80211f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	ff 75 08             	pushl  0x8(%ebp)
  80212c:	6a 29                	push   $0x29
  80212e:	e8 fe fa ff ff       	call   801c31 <syscall>
  802133:	83 c4 18             	add    $0x18,%esp
	return ;
  802136:	90                   	nop
}
  802137:	c9                   	leave  
  802138:	c3                   	ret    

00802139 <inctst>:

void inctst()
{
  802139:	55                   	push   %ebp
  80213a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 2a                	push   $0x2a
  802148:	e8 e4 fa ff ff       	call   801c31 <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
	return ;
  802150:	90                   	nop
}
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <gettst>:
uint32 gettst()
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 2b                	push   $0x2b
  802162:	e8 ca fa ff ff       	call   801c31 <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
}
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
  80216f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 2c                	push   $0x2c
  80217e:	e8 ae fa ff ff       	call   801c31 <syscall>
  802183:	83 c4 18             	add    $0x18,%esp
  802186:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802189:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80218d:	75 07                	jne    802196 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80218f:	b8 01 00 00 00       	mov    $0x1,%eax
  802194:	eb 05                	jmp    80219b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802196:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80219b:	c9                   	leave  
  80219c:	c3                   	ret    

0080219d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80219d:	55                   	push   %ebp
  80219e:	89 e5                	mov    %esp,%ebp
  8021a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 2c                	push   $0x2c
  8021af:	e8 7d fa ff ff       	call   801c31 <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
  8021b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021ba:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021be:	75 07                	jne    8021c7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c5:	eb 05                	jmp    8021cc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021cc:	c9                   	leave  
  8021cd:	c3                   	ret    

008021ce <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021ce:	55                   	push   %ebp
  8021cf:	89 e5                	mov    %esp,%ebp
  8021d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 2c                	push   $0x2c
  8021e0:	e8 4c fa ff ff       	call   801c31 <syscall>
  8021e5:	83 c4 18             	add    $0x18,%esp
  8021e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021eb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021ef:	75 07                	jne    8021f8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f6:	eb 05                	jmp    8021fd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021fd:	c9                   	leave  
  8021fe:	c3                   	ret    

008021ff <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021ff:	55                   	push   %ebp
  802200:	89 e5                	mov    %esp,%ebp
  802202:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802205:	6a 00                	push   $0x0
  802207:	6a 00                	push   $0x0
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 2c                	push   $0x2c
  802211:	e8 1b fa ff ff       	call   801c31 <syscall>
  802216:	83 c4 18             	add    $0x18,%esp
  802219:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80221c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802220:	75 07                	jne    802229 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802222:	b8 01 00 00 00       	mov    $0x1,%eax
  802227:	eb 05                	jmp    80222e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802229:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80222e:	c9                   	leave  
  80222f:	c3                   	ret    

00802230 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802230:	55                   	push   %ebp
  802231:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802233:	6a 00                	push   $0x0
  802235:	6a 00                	push   $0x0
  802237:	6a 00                	push   $0x0
  802239:	6a 00                	push   $0x0
  80223b:	ff 75 08             	pushl  0x8(%ebp)
  80223e:	6a 2d                	push   $0x2d
  802240:	e8 ec f9 ff ff       	call   801c31 <syscall>
  802245:	83 c4 18             	add    $0x18,%esp
	return ;
  802248:	90                   	nop
}
  802249:	c9                   	leave  
  80224a:	c3                   	ret    
  80224b:	90                   	nop

0080224c <__udivdi3>:
  80224c:	55                   	push   %ebp
  80224d:	57                   	push   %edi
  80224e:	56                   	push   %esi
  80224f:	53                   	push   %ebx
  802250:	83 ec 1c             	sub    $0x1c,%esp
  802253:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802257:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80225b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80225f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802263:	89 ca                	mov    %ecx,%edx
  802265:	89 f8                	mov    %edi,%eax
  802267:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80226b:	85 f6                	test   %esi,%esi
  80226d:	75 2d                	jne    80229c <__udivdi3+0x50>
  80226f:	39 cf                	cmp    %ecx,%edi
  802271:	77 65                	ja     8022d8 <__udivdi3+0x8c>
  802273:	89 fd                	mov    %edi,%ebp
  802275:	85 ff                	test   %edi,%edi
  802277:	75 0b                	jne    802284 <__udivdi3+0x38>
  802279:	b8 01 00 00 00       	mov    $0x1,%eax
  80227e:	31 d2                	xor    %edx,%edx
  802280:	f7 f7                	div    %edi
  802282:	89 c5                	mov    %eax,%ebp
  802284:	31 d2                	xor    %edx,%edx
  802286:	89 c8                	mov    %ecx,%eax
  802288:	f7 f5                	div    %ebp
  80228a:	89 c1                	mov    %eax,%ecx
  80228c:	89 d8                	mov    %ebx,%eax
  80228e:	f7 f5                	div    %ebp
  802290:	89 cf                	mov    %ecx,%edi
  802292:	89 fa                	mov    %edi,%edx
  802294:	83 c4 1c             	add    $0x1c,%esp
  802297:	5b                   	pop    %ebx
  802298:	5e                   	pop    %esi
  802299:	5f                   	pop    %edi
  80229a:	5d                   	pop    %ebp
  80229b:	c3                   	ret    
  80229c:	39 ce                	cmp    %ecx,%esi
  80229e:	77 28                	ja     8022c8 <__udivdi3+0x7c>
  8022a0:	0f bd fe             	bsr    %esi,%edi
  8022a3:	83 f7 1f             	xor    $0x1f,%edi
  8022a6:	75 40                	jne    8022e8 <__udivdi3+0x9c>
  8022a8:	39 ce                	cmp    %ecx,%esi
  8022aa:	72 0a                	jb     8022b6 <__udivdi3+0x6a>
  8022ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022b0:	0f 87 9e 00 00 00    	ja     802354 <__udivdi3+0x108>
  8022b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022bb:	89 fa                	mov    %edi,%edx
  8022bd:	83 c4 1c             	add    $0x1c,%esp
  8022c0:	5b                   	pop    %ebx
  8022c1:	5e                   	pop    %esi
  8022c2:	5f                   	pop    %edi
  8022c3:	5d                   	pop    %ebp
  8022c4:	c3                   	ret    
  8022c5:	8d 76 00             	lea    0x0(%esi),%esi
  8022c8:	31 ff                	xor    %edi,%edi
  8022ca:	31 c0                	xor    %eax,%eax
  8022cc:	89 fa                	mov    %edi,%edx
  8022ce:	83 c4 1c             	add    $0x1c,%esp
  8022d1:	5b                   	pop    %ebx
  8022d2:	5e                   	pop    %esi
  8022d3:	5f                   	pop    %edi
  8022d4:	5d                   	pop    %ebp
  8022d5:	c3                   	ret    
  8022d6:	66 90                	xchg   %ax,%ax
  8022d8:	89 d8                	mov    %ebx,%eax
  8022da:	f7 f7                	div    %edi
  8022dc:	31 ff                	xor    %edi,%edi
  8022de:	89 fa                	mov    %edi,%edx
  8022e0:	83 c4 1c             	add    $0x1c,%esp
  8022e3:	5b                   	pop    %ebx
  8022e4:	5e                   	pop    %esi
  8022e5:	5f                   	pop    %edi
  8022e6:	5d                   	pop    %ebp
  8022e7:	c3                   	ret    
  8022e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022ed:	89 eb                	mov    %ebp,%ebx
  8022ef:	29 fb                	sub    %edi,%ebx
  8022f1:	89 f9                	mov    %edi,%ecx
  8022f3:	d3 e6                	shl    %cl,%esi
  8022f5:	89 c5                	mov    %eax,%ebp
  8022f7:	88 d9                	mov    %bl,%cl
  8022f9:	d3 ed                	shr    %cl,%ebp
  8022fb:	89 e9                	mov    %ebp,%ecx
  8022fd:	09 f1                	or     %esi,%ecx
  8022ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802303:	89 f9                	mov    %edi,%ecx
  802305:	d3 e0                	shl    %cl,%eax
  802307:	89 c5                	mov    %eax,%ebp
  802309:	89 d6                	mov    %edx,%esi
  80230b:	88 d9                	mov    %bl,%cl
  80230d:	d3 ee                	shr    %cl,%esi
  80230f:	89 f9                	mov    %edi,%ecx
  802311:	d3 e2                	shl    %cl,%edx
  802313:	8b 44 24 08          	mov    0x8(%esp),%eax
  802317:	88 d9                	mov    %bl,%cl
  802319:	d3 e8                	shr    %cl,%eax
  80231b:	09 c2                	or     %eax,%edx
  80231d:	89 d0                	mov    %edx,%eax
  80231f:	89 f2                	mov    %esi,%edx
  802321:	f7 74 24 0c          	divl   0xc(%esp)
  802325:	89 d6                	mov    %edx,%esi
  802327:	89 c3                	mov    %eax,%ebx
  802329:	f7 e5                	mul    %ebp
  80232b:	39 d6                	cmp    %edx,%esi
  80232d:	72 19                	jb     802348 <__udivdi3+0xfc>
  80232f:	74 0b                	je     80233c <__udivdi3+0xf0>
  802331:	89 d8                	mov    %ebx,%eax
  802333:	31 ff                	xor    %edi,%edi
  802335:	e9 58 ff ff ff       	jmp    802292 <__udivdi3+0x46>
  80233a:	66 90                	xchg   %ax,%ax
  80233c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802340:	89 f9                	mov    %edi,%ecx
  802342:	d3 e2                	shl    %cl,%edx
  802344:	39 c2                	cmp    %eax,%edx
  802346:	73 e9                	jae    802331 <__udivdi3+0xe5>
  802348:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80234b:	31 ff                	xor    %edi,%edi
  80234d:	e9 40 ff ff ff       	jmp    802292 <__udivdi3+0x46>
  802352:	66 90                	xchg   %ax,%ax
  802354:	31 c0                	xor    %eax,%eax
  802356:	e9 37 ff ff ff       	jmp    802292 <__udivdi3+0x46>
  80235b:	90                   	nop

0080235c <__umoddi3>:
  80235c:	55                   	push   %ebp
  80235d:	57                   	push   %edi
  80235e:	56                   	push   %esi
  80235f:	53                   	push   %ebx
  802360:	83 ec 1c             	sub    $0x1c,%esp
  802363:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802367:	8b 74 24 34          	mov    0x34(%esp),%esi
  80236b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80236f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802373:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802377:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80237b:	89 f3                	mov    %esi,%ebx
  80237d:	89 fa                	mov    %edi,%edx
  80237f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802383:	89 34 24             	mov    %esi,(%esp)
  802386:	85 c0                	test   %eax,%eax
  802388:	75 1a                	jne    8023a4 <__umoddi3+0x48>
  80238a:	39 f7                	cmp    %esi,%edi
  80238c:	0f 86 a2 00 00 00    	jbe    802434 <__umoddi3+0xd8>
  802392:	89 c8                	mov    %ecx,%eax
  802394:	89 f2                	mov    %esi,%edx
  802396:	f7 f7                	div    %edi
  802398:	89 d0                	mov    %edx,%eax
  80239a:	31 d2                	xor    %edx,%edx
  80239c:	83 c4 1c             	add    $0x1c,%esp
  80239f:	5b                   	pop    %ebx
  8023a0:	5e                   	pop    %esi
  8023a1:	5f                   	pop    %edi
  8023a2:	5d                   	pop    %ebp
  8023a3:	c3                   	ret    
  8023a4:	39 f0                	cmp    %esi,%eax
  8023a6:	0f 87 ac 00 00 00    	ja     802458 <__umoddi3+0xfc>
  8023ac:	0f bd e8             	bsr    %eax,%ebp
  8023af:	83 f5 1f             	xor    $0x1f,%ebp
  8023b2:	0f 84 ac 00 00 00    	je     802464 <__umoddi3+0x108>
  8023b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8023bd:	29 ef                	sub    %ebp,%edi
  8023bf:	89 fe                	mov    %edi,%esi
  8023c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023c5:	89 e9                	mov    %ebp,%ecx
  8023c7:	d3 e0                	shl    %cl,%eax
  8023c9:	89 d7                	mov    %edx,%edi
  8023cb:	89 f1                	mov    %esi,%ecx
  8023cd:	d3 ef                	shr    %cl,%edi
  8023cf:	09 c7                	or     %eax,%edi
  8023d1:	89 e9                	mov    %ebp,%ecx
  8023d3:	d3 e2                	shl    %cl,%edx
  8023d5:	89 14 24             	mov    %edx,(%esp)
  8023d8:	89 d8                	mov    %ebx,%eax
  8023da:	d3 e0                	shl    %cl,%eax
  8023dc:	89 c2                	mov    %eax,%edx
  8023de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023e2:	d3 e0                	shl    %cl,%eax
  8023e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ec:	89 f1                	mov    %esi,%ecx
  8023ee:	d3 e8                	shr    %cl,%eax
  8023f0:	09 d0                	or     %edx,%eax
  8023f2:	d3 eb                	shr    %cl,%ebx
  8023f4:	89 da                	mov    %ebx,%edx
  8023f6:	f7 f7                	div    %edi
  8023f8:	89 d3                	mov    %edx,%ebx
  8023fa:	f7 24 24             	mull   (%esp)
  8023fd:	89 c6                	mov    %eax,%esi
  8023ff:	89 d1                	mov    %edx,%ecx
  802401:	39 d3                	cmp    %edx,%ebx
  802403:	0f 82 87 00 00 00    	jb     802490 <__umoddi3+0x134>
  802409:	0f 84 91 00 00 00    	je     8024a0 <__umoddi3+0x144>
  80240f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802413:	29 f2                	sub    %esi,%edx
  802415:	19 cb                	sbb    %ecx,%ebx
  802417:	89 d8                	mov    %ebx,%eax
  802419:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80241d:	d3 e0                	shl    %cl,%eax
  80241f:	89 e9                	mov    %ebp,%ecx
  802421:	d3 ea                	shr    %cl,%edx
  802423:	09 d0                	or     %edx,%eax
  802425:	89 e9                	mov    %ebp,%ecx
  802427:	d3 eb                	shr    %cl,%ebx
  802429:	89 da                	mov    %ebx,%edx
  80242b:	83 c4 1c             	add    $0x1c,%esp
  80242e:	5b                   	pop    %ebx
  80242f:	5e                   	pop    %esi
  802430:	5f                   	pop    %edi
  802431:	5d                   	pop    %ebp
  802432:	c3                   	ret    
  802433:	90                   	nop
  802434:	89 fd                	mov    %edi,%ebp
  802436:	85 ff                	test   %edi,%edi
  802438:	75 0b                	jne    802445 <__umoddi3+0xe9>
  80243a:	b8 01 00 00 00       	mov    $0x1,%eax
  80243f:	31 d2                	xor    %edx,%edx
  802441:	f7 f7                	div    %edi
  802443:	89 c5                	mov    %eax,%ebp
  802445:	89 f0                	mov    %esi,%eax
  802447:	31 d2                	xor    %edx,%edx
  802449:	f7 f5                	div    %ebp
  80244b:	89 c8                	mov    %ecx,%eax
  80244d:	f7 f5                	div    %ebp
  80244f:	89 d0                	mov    %edx,%eax
  802451:	e9 44 ff ff ff       	jmp    80239a <__umoddi3+0x3e>
  802456:	66 90                	xchg   %ax,%ax
  802458:	89 c8                	mov    %ecx,%eax
  80245a:	89 f2                	mov    %esi,%edx
  80245c:	83 c4 1c             	add    $0x1c,%esp
  80245f:	5b                   	pop    %ebx
  802460:	5e                   	pop    %esi
  802461:	5f                   	pop    %edi
  802462:	5d                   	pop    %ebp
  802463:	c3                   	ret    
  802464:	3b 04 24             	cmp    (%esp),%eax
  802467:	72 06                	jb     80246f <__umoddi3+0x113>
  802469:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80246d:	77 0f                	ja     80247e <__umoddi3+0x122>
  80246f:	89 f2                	mov    %esi,%edx
  802471:	29 f9                	sub    %edi,%ecx
  802473:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802477:	89 14 24             	mov    %edx,(%esp)
  80247a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80247e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802482:	8b 14 24             	mov    (%esp),%edx
  802485:	83 c4 1c             	add    $0x1c,%esp
  802488:	5b                   	pop    %ebx
  802489:	5e                   	pop    %esi
  80248a:	5f                   	pop    %edi
  80248b:	5d                   	pop    %ebp
  80248c:	c3                   	ret    
  80248d:	8d 76 00             	lea    0x0(%esi),%esi
  802490:	2b 04 24             	sub    (%esp),%eax
  802493:	19 fa                	sbb    %edi,%edx
  802495:	89 d1                	mov    %edx,%ecx
  802497:	89 c6                	mov    %eax,%esi
  802499:	e9 71 ff ff ff       	jmp    80240f <__umoddi3+0xb3>
  80249e:	66 90                	xchg   %ax,%ax
  8024a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024a4:	72 ea                	jb     802490 <__umoddi3+0x134>
  8024a6:	89 d9                	mov    %ebx,%ecx
  8024a8:	e9 62 ff ff ff       	jmp    80240f <__umoddi3+0xb3>
