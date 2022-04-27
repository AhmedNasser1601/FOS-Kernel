
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
  800045:	e8 7f 20 00 00       	call   8020c9 <sys_set_uheap_strategy>
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
  80005a:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800083:	a1 04 30 80 00       	mov    0x803004,%eax
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
  80009b:	68 60 23 80 00       	push   $0x802360
  8000a0:	6a 1b                	push   $0x1b
  8000a2:	68 7c 23 80 00       	push   $0x80237c
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
  8000e8:	68 94 23 80 00       	push   $0x802394
  8000ed:	6a 25                	push   $0x25
  8000ef:	68 7c 23 80 00       	push   $0x80237c
  8000f4:	e8 f1 08 00 00       	call   8009ea <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 38 1b 00 00       	call   801c36 <sys_calculate_free_frames>
  8000fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800101:	e8 b3 1b 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80012d:	68 d8 23 80 00       	push   $0x8023d8
  800132:	6a 2e                	push   $0x2e
  800134:	68 7c 23 80 00       	push   $0x80237c
  800139:	e8 ac 08 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013e:	e8 76 1b 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  800143:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800146:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 08 24 80 00       	push   $0x802408
  800155:	6a 30                	push   $0x30
  800157:	68 7c 23 80 00       	push   $0x80237c
  80015c:	e8 89 08 00 00       	call   8009ea <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800161:	e8 d0 1a 00 00       	call   801c36 <sys_calculate_free_frames>
  800166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800169:	e8 4b 1b 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80019e:	68 d8 23 80 00       	push   $0x8023d8
  8001a3:	6a 36                	push   $0x36
  8001a5:	68 7c 23 80 00       	push   $0x80237c
  8001aa:	e8 3b 08 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001af:	e8 05 1b 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8001b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 08 24 80 00       	push   $0x802408
  8001c6:	6a 38                	push   $0x38
  8001c8:	68 7c 23 80 00       	push   $0x80237c
  8001cd:	e8 18 08 00 00       	call   8009ea <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d2:	e8 5f 1a 00 00       	call   801c36 <sys_calculate_free_frames>
  8001d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001da:	e8 da 1a 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80020d:	68 d8 23 80 00       	push   $0x8023d8
  800212:	6a 3e                	push   $0x3e
  800214:	68 7c 23 80 00       	push   $0x80237c
  800219:	e8 cc 07 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021e:	e8 96 1a 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  800223:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800226:	83 f8 01             	cmp    $0x1,%eax
  800229:	74 14                	je     80023f <_main+0x207>
  80022b:	83 ec 04             	sub    $0x4,%esp
  80022e:	68 08 24 80 00       	push   $0x802408
  800233:	6a 40                	push   $0x40
  800235:	68 7c 23 80 00       	push   $0x80237c
  80023a:	e8 ab 07 00 00       	call   8009ea <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80023f:	e8 f2 19 00 00       	call   801c36 <sys_calculate_free_frames>
  800244:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800247:	e8 6d 1a 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  800284:	68 d8 23 80 00       	push   $0x8023d8
  800289:	6a 46                	push   $0x46
  80028b:	68 7c 23 80 00       	push   $0x80237c
  800290:	e8 55 07 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800295:	e8 1f 1a 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  80029a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029d:	83 f8 01             	cmp    $0x1,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 08 24 80 00       	push   $0x802408
  8002aa:	6a 48                	push   $0x48
  8002ac:	68 7c 23 80 00       	push   $0x80237c
  8002b1:	e8 34 07 00 00       	call   8009ea <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 7b 19 00 00       	call   801c36 <sys_calculate_free_frames>
  8002bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002be:	e8 f6 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 aa 17 00 00       	call   801a7c <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d5:	e8 df 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	29 c2                	sub    %eax,%edx
  8002df:	89 d0                	mov    %edx,%eax
  8002e1:	83 f8 01             	cmp    $0x1,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 25 24 80 00       	push   $0x802425
  8002ee:	6a 4f                	push   $0x4f
  8002f0:	68 7c 23 80 00       	push   $0x80237c
  8002f5:	e8 f0 06 00 00       	call   8009ea <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 37 19 00 00       	call   801c36 <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800302:	e8 b2 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  800347:	68 d8 23 80 00       	push   $0x8023d8
  80034c:	6a 55                	push   $0x55
  80034e:	68 7c 23 80 00       	push   $0x80237c
  800353:	e8 92 06 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800358:	e8 5c 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  80035d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800360:	83 f8 02             	cmp    $0x2,%eax
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 08 24 80 00       	push   $0x802408
  80036d:	6a 57                	push   $0x57
  80036f:	68 7c 23 80 00       	push   $0x80237c
  800374:	e8 71 06 00 00       	call   8009ea <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800379:	e8 b8 18 00 00       	call   801c36 <sys_calculate_free_frames>
  80037e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800381:	e8 33 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800389:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	50                   	push   %eax
  800390:	e8 e7 16 00 00       	call   801a7c <free>
  800395:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800398:	e8 1c 19 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  80039d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a0:	29 c2                	sub    %eax,%edx
  8003a2:	89 d0                	mov    %edx,%eax
  8003a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a9:	74 14                	je     8003bf <_main+0x387>
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 25 24 80 00       	push   $0x802425
  8003b3:	6a 5e                	push   $0x5e
  8003b5:	68 7c 23 80 00       	push   $0x80237c
  8003ba:	e8 2b 06 00 00       	call   8009ea <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 72 18 00 00       	call   801c36 <sys_calculate_free_frames>
  8003c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c7:	e8 ed 18 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80040b:	68 d8 23 80 00       	push   $0x8023d8
  800410:	6a 64                	push   $0x64
  800412:	68 7c 23 80 00       	push   $0x80237c
  800417:	e8 ce 05 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041c:	e8 98 18 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  800442:	68 08 24 80 00       	push   $0x802408
  800447:	6a 66                	push   $0x66
  800449:	68 7c 23 80 00       	push   $0x80237c
  80044e:	e8 97 05 00 00       	call   8009ea <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800453:	e8 de 17 00 00       	call   801c36 <sys_calculate_free_frames>
  800458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045b:	e8 59 18 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  8004aa:	68 d8 23 80 00       	push   $0x8023d8
  8004af:	6a 6c                	push   $0x6c
  8004b1:	68 7c 23 80 00       	push   $0x80237c
  8004b6:	e8 2f 05 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bb:	e8 f9 17 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8004c0:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 08 24 80 00       	push   $0x802408
  8004d2:	6a 6e                	push   $0x6e
  8004d4:	68 7c 23 80 00       	push   $0x80237c
  8004d9:	e8 0c 05 00 00       	call   8009ea <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 53 17 00 00       	call   801c36 <sys_calculate_free_frames>
  8004e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 ce 17 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  800535:	68 d8 23 80 00       	push   $0x8023d8
  80053a:	6a 74                	push   $0x74
  80053c:	68 7c 23 80 00       	push   $0x80237c
  800541:	e8 a4 04 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  800546:	e8 6e 17 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80056d:	68 08 24 80 00       	push   $0x802408
  800572:	6a 76                	push   $0x76
  800574:	68 7c 23 80 00       	push   $0x80237c
  800579:	e8 6c 04 00 00       	call   8009ea <_panic>

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80057e:	e8 b3 16 00 00       	call   801c36 <sys_calculate_free_frames>
  800583:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800586:	e8 2e 17 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  80058b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  80058e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800591:	83 ec 0c             	sub    $0xc,%esp
  800594:	50                   	push   %eax
  800595:	e8 e2 14 00 00       	call   801a7c <free>
  80059a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");
  80059d:	e8 17 17 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8005a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a5:	29 c2                	sub    %eax,%edx
  8005a7:	89 d0                	mov    %edx,%eax
  8005a9:	3d 02 02 00 00       	cmp    $0x202,%eax
  8005ae:	74 14                	je     8005c4 <_main+0x58c>
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	68 25 24 80 00       	push   $0x802425
  8005b8:	6a 7d                	push   $0x7d
  8005ba:	68 7c 23 80 00       	push   $0x80237c
  8005bf:	e8 26 04 00 00       	call   8009ea <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005c4:	e8 6d 16 00 00       	call   801c36 <sys_calculate_free_frames>
  8005c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005cc:	e8 e8 16 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8005d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005d4:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005d7:	83 ec 0c             	sub    $0xc,%esp
  8005da:	50                   	push   %eax
  8005db:	e8 9c 14 00 00       	call   801a7c <free>
  8005e0:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  8005e3:	e8 d1 16 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8005e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005eb:	29 c2                	sub    %eax,%edx
  8005ed:	89 d0                	mov    %edx,%eax
  8005ef:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005f4:	74 17                	je     80060d <_main+0x5d5>
  8005f6:	83 ec 04             	sub    $0x4,%esp
  8005f9:	68 25 24 80 00       	push   $0x802425
  8005fe:	68 84 00 00 00       	push   $0x84
  800603:	68 7c 23 80 00       	push   $0x80237c
  800608:	e8 dd 03 00 00       	call   8009ea <_panic>

		//2 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  80060d:	e8 24 16 00 00       	call   801c36 <sys_calculate_free_frames>
  800612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800615:	e8 9f 16 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80065c:	68 d8 23 80 00       	push   $0x8023d8
  800661:	68 8a 00 00 00       	push   $0x8a
  800666:	68 7c 23 80 00       	push   $0x80237c
  80066b:	e8 7a 03 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800670:	e8 44 16 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  800675:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800678:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067d:	74 17                	je     800696 <_main+0x65e>
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 08 24 80 00       	push   $0x802408
  800687:	68 8c 00 00 00       	push   $0x8c
  80068c:	68 7c 23 80 00       	push   $0x80237c
  800691:	e8 54 03 00 00       	call   8009ea <_panic>

		//6 KB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800696:	e8 9b 15 00 00       	call   801c36 <sys_calculate_free_frames>
  80069b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80069e:	e8 16 16 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  8006e5:	68 d8 23 80 00       	push   $0x8023d8
  8006ea:	68 92 00 00 00       	push   $0x92
  8006ef:	68 7c 23 80 00       	push   $0x80237c
  8006f4:	e8 f1 02 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  8006f9:	e8 bb 15 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  8006fe:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800701:	83 f8 02             	cmp    $0x2,%eax
  800704:	74 17                	je     80071d <_main+0x6e5>
  800706:	83 ec 04             	sub    $0x4,%esp
  800709:	68 08 24 80 00       	push   $0x802408
  80070e:	68 94 00 00 00       	push   $0x94
  800713:	68 7c 23 80 00       	push   $0x80237c
  800718:	e8 cd 02 00 00       	call   8009ea <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80071d:	e8 14 15 00 00       	call   801c36 <sys_calculate_free_frames>
  800722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800725:	e8 8f 15 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  80072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80072d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800730:	83 ec 0c             	sub    $0xc,%esp
  800733:	50                   	push   %eax
  800734:	e8 43 13 00 00       	call   801a7c <free>
  800739:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  80073c:	e8 78 15 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
  800741:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800744:	29 c2                	sub    %eax,%edx
  800746:	89 d0                	mov    %edx,%eax
  800748:	3d 00 03 00 00       	cmp    $0x300,%eax
  80074d:	74 17                	je     800766 <_main+0x72e>
  80074f:	83 ec 04             	sub    $0x4,%esp
  800752:	68 25 24 80 00       	push   $0x802425
  800757:	68 9b 00 00 00       	push   $0x9b
  80075c:	68 7c 23 80 00       	push   $0x80237c
  800761:	e8 84 02 00 00       	call   8009ea <_panic>

		//3 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800766:	e8 cb 14 00 00       	call   801c36 <sys_calculate_free_frames>
  80076b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80076e:	e8 46 15 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  8007b2:	68 d8 23 80 00       	push   $0x8023d8
  8007b7:	68 a1 00 00 00       	push   $0xa1
  8007bc:	68 7c 23 80 00       	push   $0x80237c
  8007c1:	e8 24 02 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  8007c6:	e8 ee 14 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  8007ec:	68 08 24 80 00       	push   $0x802408
  8007f1:	68 a3 00 00 00       	push   $0xa3
  8007f6:	68 7c 23 80 00       	push   $0x80237c
  8007fb:	e8 ea 01 00 00       	call   8009ea <_panic>

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800800:	e8 31 14 00 00       	call   801c36 <sys_calculate_free_frames>
  800805:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800808:	e8 ac 14 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  800835:	68 d8 23 80 00       	push   $0x8023d8
  80083a:	68 a9 00 00 00       	push   $0xa9
  80083f:	68 7c 23 80 00       	push   $0x80237c
  800844:	e8 a1 01 00 00       	call   8009ea <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 4*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/4096) panic("Wrong page file allocation: ");
  800849:	e8 6b 14 00 00       	call   801cb9 <sys_pf_calculate_allocated_pages>
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
  80086c:	68 08 24 80 00       	push   $0x802408
  800871:	68 ab 00 00 00       	push   $0xab
  800876:	68 7c 23 80 00       	push   $0x80237c
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
  8008af:	68 3c 24 80 00       	push   $0x80243c
  8008b4:	68 b4 00 00 00       	push   $0xb4
  8008b9:	68 7c 23 80 00       	push   $0x80237c
  8008be:	e8 27 01 00 00       	call   8009ea <_panic>

		cprintf("Congratulations!! test BEST FIT allocation (2) completed successfully.\n");
  8008c3:	83 ec 0c             	sub    $0xc,%esp
  8008c6:	68 a0 24 80 00       	push   $0x8024a0
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
  8008e1:	e8 85 12 00 00       	call   801b6b <sys_getenvindex>
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
  80090c:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800911:	a1 04 30 80 00       	mov    0x803004,%eax
  800916:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80091c:	84 c0                	test   %al,%al
  80091e:	74 0f                	je     80092f <libmain+0x54>
		binaryname = myEnv->prog_name;
  800920:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800950:	e8 b1 13 00 00       	call   801d06 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800955:	83 ec 0c             	sub    $0xc,%esp
  800958:	68 00 25 80 00       	push   $0x802500
  80095d:	e8 3c 03 00 00       	call   800c9e <cprintf>
  800962:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800965:	a1 04 30 80 00       	mov    0x803004,%eax
  80096a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800970:	a1 04 30 80 00       	mov    0x803004,%eax
  800975:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80097b:	83 ec 04             	sub    $0x4,%esp
  80097e:	52                   	push   %edx
  80097f:	50                   	push   %eax
  800980:	68 28 25 80 00       	push   $0x802528
  800985:	e8 14 03 00 00       	call   800c9e <cprintf>
  80098a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80098d:	a1 04 30 80 00       	mov    0x803004,%eax
  800992:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	50                   	push   %eax
  80099c:	68 4d 25 80 00       	push   $0x80254d
  8009a1:	e8 f8 02 00 00       	call   800c9e <cprintf>
  8009a6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009a9:	83 ec 0c             	sub    $0xc,%esp
  8009ac:	68 00 25 80 00       	push   $0x802500
  8009b1:	e8 e8 02 00 00       	call   800c9e <cprintf>
  8009b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009b9:	e8 62 13 00 00       	call   801d20 <sys_enable_interrupt>

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
  8009d1:	e8 61 11 00 00       	call   801b37 <sys_env_destroy>
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
  8009e2:	e8 b6 11 00 00       	call   801b9d <sys_env_exit>
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
  8009f9:	a1 14 30 80 00       	mov    0x803014,%eax
  8009fe:	85 c0                	test   %eax,%eax
  800a00:	74 16                	je     800a18 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a02:	a1 14 30 80 00       	mov    0x803014,%eax
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	50                   	push   %eax
  800a0b:	68 64 25 80 00       	push   $0x802564
  800a10:	e8 89 02 00 00       	call   800c9e <cprintf>
  800a15:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a18:	a1 00 30 80 00       	mov    0x803000,%eax
  800a1d:	ff 75 0c             	pushl  0xc(%ebp)
  800a20:	ff 75 08             	pushl  0x8(%ebp)
  800a23:	50                   	push   %eax
  800a24:	68 69 25 80 00       	push   $0x802569
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
  800a48:	68 85 25 80 00       	push   $0x802585
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
  800a62:	a1 04 30 80 00       	mov    0x803004,%eax
  800a67:	8b 50 74             	mov    0x74(%eax),%edx
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	39 c2                	cmp    %eax,%edx
  800a6f:	74 14                	je     800a85 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a71:	83 ec 04             	sub    $0x4,%esp
  800a74:	68 88 25 80 00       	push   $0x802588
  800a79:	6a 26                	push   $0x26
  800a7b:	68 d4 25 80 00       	push   $0x8025d4
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
  800ac5:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800ae5:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800b2e:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800b46:	68 e0 25 80 00       	push   $0x8025e0
  800b4b:	6a 3a                	push   $0x3a
  800b4d:	68 d4 25 80 00       	push   $0x8025d4
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
  800b76:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800b9c:	a1 04 30 80 00       	mov    0x803004,%eax
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
  800bb6:	68 34 26 80 00       	push   $0x802634
  800bbb:	6a 44                	push   $0x44
  800bbd:	68 d4 25 80 00       	push   $0x8025d4
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
  800bf5:	a0 08 30 80 00       	mov    0x803008,%al
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
  800c10:	e8 e0 0e 00 00       	call   801af5 <sys_cputs>
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
  800c6a:	a0 08 30 80 00       	mov    0x803008,%al
  800c6f:	0f b6 c0             	movzbl %al,%eax
  800c72:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c78:	83 ec 04             	sub    $0x4,%esp
  800c7b:	50                   	push   %eax
  800c7c:	52                   	push   %edx
  800c7d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c83:	83 c0 08             	add    $0x8,%eax
  800c86:	50                   	push   %eax
  800c87:	e8 69 0e 00 00       	call   801af5 <sys_cputs>
  800c8c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c8f:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
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
  800ca4:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
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
  800cd1:	e8 30 10 00 00       	call   801d06 <sys_disable_interrupt>
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
  800cf1:	e8 2a 10 00 00       	call   801d20 <sys_enable_interrupt>
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
  800d3b:	e8 a4 13 00 00       	call   8020e4 <__udivdi3>
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
  800d8b:	e8 64 14 00 00       	call   8021f4 <__umoddi3>
  800d90:	83 c4 10             	add    $0x10,%esp
  800d93:	05 94 28 80 00       	add    $0x802894,%eax
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
  800ee6:	8b 04 85 b8 28 80 00 	mov    0x8028b8(,%eax,4),%eax
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
  800fc7:	8b 34 9d 00 27 80 00 	mov    0x802700(,%ebx,4),%esi
  800fce:	85 f6                	test   %esi,%esi
  800fd0:	75 19                	jne    800feb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fd2:	53                   	push   %ebx
  800fd3:	68 a5 28 80 00       	push   $0x8028a5
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
  800fec:	68 ae 28 80 00       	push   $0x8028ae
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
  801019:	be b1 28 80 00       	mov    $0x8028b1,%esi
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
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
  801a2b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801a2e:	83 ec 04             	sub    $0x4,%esp
  801a31:	68 10 2a 80 00       	push   $0x802a10
  801a36:	6a 19                	push   $0x19
  801a38:	68 35 2a 80 00       	push   $0x802a35
  801a3d:	e8 a8 ef ff ff       	call   8009ea <_panic>

00801a42 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 18             	sub    $0x18,%esp
  801a48:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4b:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801a4e:	83 ec 04             	sub    $0x4,%esp
  801a51:	68 44 2a 80 00       	push   $0x802a44
  801a56:	6a 30                	push   $0x30
  801a58:	68 35 2a 80 00       	push   $0x802a35
  801a5d:	e8 88 ef ff ff       	call   8009ea <_panic>

00801a62 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
  801a65:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801a68:	83 ec 04             	sub    $0x4,%esp
  801a6b:	68 63 2a 80 00       	push   $0x802a63
  801a70:	6a 36                	push   $0x36
  801a72:	68 35 2a 80 00       	push   $0x802a35
  801a77:	e8 6e ef ff ff       	call   8009ea <_panic>

00801a7c <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
  801a7f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a82:	83 ec 04             	sub    $0x4,%esp
  801a85:	68 80 2a 80 00       	push   $0x802a80
  801a8a:	6a 48                	push   $0x48
  801a8c:	68 35 2a 80 00       	push   $0x802a35
  801a91:	e8 54 ef ff ff       	call   8009ea <_panic>

00801a96 <sfree>:

}


void sfree(void* virtual_address)
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
  801a99:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801a9c:	83 ec 04             	sub    $0x4,%esp
  801a9f:	68 a3 2a 80 00       	push   $0x802aa3
  801aa4:	6a 53                	push   $0x53
  801aa6:	68 35 2a 80 00       	push   $0x802a35
  801aab:	e8 3a ef ff ff       	call   8009ea <_panic>

00801ab0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801ab6:	83 ec 04             	sub    $0x4,%esp
  801ab9:	68 c0 2a 80 00       	push   $0x802ac0
  801abe:	6a 6c                	push   $0x6c
  801ac0:	68 35 2a 80 00       	push   $0x802a35
  801ac5:	e8 20 ef ff ff       	call   8009ea <_panic>

00801aca <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
  801acd:	57                   	push   %edi
  801ace:	56                   	push   %esi
  801acf:	53                   	push   %ebx
  801ad0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801adc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801adf:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ae2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ae5:	cd 30                	int    $0x30
  801ae7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801aea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801aed:	83 c4 10             	add    $0x10,%esp
  801af0:	5b                   	pop    %ebx
  801af1:	5e                   	pop    %esi
  801af2:	5f                   	pop    %edi
  801af3:	5d                   	pop    %ebp
  801af4:	c3                   	ret    

00801af5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
  801af8:	83 ec 04             	sub    $0x4,%esp
  801afb:	8b 45 10             	mov    0x10(%ebp),%eax
  801afe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b01:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b05:	8b 45 08             	mov    0x8(%ebp),%eax
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	52                   	push   %edx
  801b0d:	ff 75 0c             	pushl  0xc(%ebp)
  801b10:	50                   	push   %eax
  801b11:	6a 00                	push   $0x0
  801b13:	e8 b2 ff ff ff       	call   801aca <syscall>
  801b18:	83 c4 18             	add    $0x18,%esp
}
  801b1b:	90                   	nop
  801b1c:	c9                   	leave  
  801b1d:	c3                   	ret    

00801b1e <sys_cgetc>:

int
sys_cgetc(void)
{
  801b1e:	55                   	push   %ebp
  801b1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 01                	push   $0x1
  801b2d:	e8 98 ff ff ff       	call   801aca <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	50                   	push   %eax
  801b46:	6a 05                	push   $0x5
  801b48:	e8 7d ff ff ff       	call   801aca <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 02                	push   $0x2
  801b61:	e8 64 ff ff ff       	call   801aca <syscall>
  801b66:	83 c4 18             	add    $0x18,%esp
}
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 03                	push   $0x3
  801b7a:	e8 4b ff ff ff       	call   801aca <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
}
  801b82:	c9                   	leave  
  801b83:	c3                   	ret    

00801b84 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 04                	push   $0x4
  801b93:	e8 32 ff ff ff       	call   801aca <syscall>
  801b98:	83 c4 18             	add    $0x18,%esp
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <sys_env_exit>:


void sys_env_exit(void)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 06                	push   $0x6
  801bac:	e8 19 ff ff ff       	call   801aca <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
}
  801bb4:	90                   	nop
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	52                   	push   %edx
  801bc7:	50                   	push   %eax
  801bc8:	6a 07                	push   $0x7
  801bca:	e8 fb fe ff ff       	call   801aca <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	56                   	push   %esi
  801bd8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bd9:	8b 75 18             	mov    0x18(%ebp),%esi
  801bdc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	56                   	push   %esi
  801be9:	53                   	push   %ebx
  801bea:	51                   	push   %ecx
  801beb:	52                   	push   %edx
  801bec:	50                   	push   %eax
  801bed:	6a 08                	push   $0x8
  801bef:	e8 d6 fe ff ff       	call   801aca <syscall>
  801bf4:	83 c4 18             	add    $0x18,%esp
}
  801bf7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bfa:	5b                   	pop    %ebx
  801bfb:	5e                   	pop    %esi
  801bfc:	5d                   	pop    %ebp
  801bfd:	c3                   	ret    

00801bfe <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c04:	8b 45 08             	mov    0x8(%ebp),%eax
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	52                   	push   %edx
  801c0e:	50                   	push   %eax
  801c0f:	6a 09                	push   $0x9
  801c11:	e8 b4 fe ff ff       	call   801aca <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
}
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    

00801c1b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	ff 75 0c             	pushl  0xc(%ebp)
  801c27:	ff 75 08             	pushl  0x8(%ebp)
  801c2a:	6a 0a                	push   $0xa
  801c2c:	e8 99 fe ff ff       	call   801aca <syscall>
  801c31:	83 c4 18             	add    $0x18,%esp
}
  801c34:	c9                   	leave  
  801c35:	c3                   	ret    

00801c36 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 0b                	push   $0xb
  801c45:	e8 80 fe ff ff       	call   801aca <syscall>
  801c4a:	83 c4 18             	add    $0x18,%esp
}
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 0c                	push   $0xc
  801c5e:	e8 67 fe ff ff       	call   801aca <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 0d                	push   $0xd
  801c77:	e8 4e fe ff ff       	call   801aca <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	ff 75 0c             	pushl  0xc(%ebp)
  801c8d:	ff 75 08             	pushl  0x8(%ebp)
  801c90:	6a 11                	push   $0x11
  801c92:	e8 33 fe ff ff       	call   801aca <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
	return;
  801c9a:	90                   	nop
}
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	ff 75 0c             	pushl  0xc(%ebp)
  801ca9:	ff 75 08             	pushl  0x8(%ebp)
  801cac:	6a 12                	push   $0x12
  801cae:	e8 17 fe ff ff       	call   801aca <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb6:	90                   	nop
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 0e                	push   $0xe
  801cc8:	e8 fd fd ff ff       	call   801aca <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	ff 75 08             	pushl  0x8(%ebp)
  801ce0:	6a 0f                	push   $0xf
  801ce2:	e8 e3 fd ff ff       	call   801aca <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
}
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 10                	push   $0x10
  801cfb:	e8 ca fd ff ff       	call   801aca <syscall>
  801d00:	83 c4 18             	add    $0x18,%esp
}
  801d03:	90                   	nop
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 14                	push   $0x14
  801d15:	e8 b0 fd ff ff       	call   801aca <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	90                   	nop
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 15                	push   $0x15
  801d2f:	e8 96 fd ff ff       	call   801aca <syscall>
  801d34:	83 c4 18             	add    $0x18,%esp
}
  801d37:	90                   	nop
  801d38:	c9                   	leave  
  801d39:	c3                   	ret    

00801d3a <sys_cputc>:


void
sys_cputc(const char c)
{
  801d3a:	55                   	push   %ebp
  801d3b:	89 e5                	mov    %esp,%ebp
  801d3d:	83 ec 04             	sub    $0x4,%esp
  801d40:	8b 45 08             	mov    0x8(%ebp),%eax
  801d43:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d46:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	50                   	push   %eax
  801d53:	6a 16                	push   $0x16
  801d55:	e8 70 fd ff ff       	call   801aca <syscall>
  801d5a:	83 c4 18             	add    $0x18,%esp
}
  801d5d:	90                   	nop
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 17                	push   $0x17
  801d6f:	e8 56 fd ff ff       	call   801aca <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	90                   	nop
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	ff 75 0c             	pushl  0xc(%ebp)
  801d89:	50                   	push   %eax
  801d8a:	6a 18                	push   $0x18
  801d8c:	e8 39 fd ff ff       	call   801aca <syscall>
  801d91:	83 c4 18             	add    $0x18,%esp
}
  801d94:	c9                   	leave  
  801d95:	c3                   	ret    

00801d96 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d96:	55                   	push   %ebp
  801d97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	52                   	push   %edx
  801da6:	50                   	push   %eax
  801da7:	6a 1b                	push   $0x1b
  801da9:	e8 1c fd ff ff       	call   801aca <syscall>
  801dae:	83 c4 18             	add    $0x18,%esp
}
  801db1:	c9                   	leave  
  801db2:	c3                   	ret    

00801db3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801db3:	55                   	push   %ebp
  801db4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801db6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	52                   	push   %edx
  801dc3:	50                   	push   %eax
  801dc4:	6a 19                	push   $0x19
  801dc6:	e8 ff fc ff ff       	call   801aca <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	90                   	nop
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	52                   	push   %edx
  801de1:	50                   	push   %eax
  801de2:	6a 1a                	push   $0x1a
  801de4:	e8 e1 fc ff ff       	call   801aca <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	90                   	nop
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
  801df2:	83 ec 04             	sub    $0x4,%esp
  801df5:	8b 45 10             	mov    0x10(%ebp),%eax
  801df8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dfb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dfe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e02:	8b 45 08             	mov    0x8(%ebp),%eax
  801e05:	6a 00                	push   $0x0
  801e07:	51                   	push   %ecx
  801e08:	52                   	push   %edx
  801e09:	ff 75 0c             	pushl  0xc(%ebp)
  801e0c:	50                   	push   %eax
  801e0d:	6a 1c                	push   $0x1c
  801e0f:	e8 b6 fc ff ff       	call   801aca <syscall>
  801e14:	83 c4 18             	add    $0x18,%esp
}
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	52                   	push   %edx
  801e29:	50                   	push   %eax
  801e2a:	6a 1d                	push   $0x1d
  801e2c:	e8 99 fc ff ff       	call   801aca <syscall>
  801e31:	83 c4 18             	add    $0x18,%esp
}
  801e34:	c9                   	leave  
  801e35:	c3                   	ret    

00801e36 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e36:	55                   	push   %ebp
  801e37:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e39:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	51                   	push   %ecx
  801e47:	52                   	push   %edx
  801e48:	50                   	push   %eax
  801e49:	6a 1e                	push   $0x1e
  801e4b:	e8 7a fc ff ff       	call   801aca <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	52                   	push   %edx
  801e65:	50                   	push   %eax
  801e66:	6a 1f                	push   $0x1f
  801e68:	e8 5d fc ff ff       	call   801aca <syscall>
  801e6d:	83 c4 18             	add    $0x18,%esp
}
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 20                	push   $0x20
  801e81:	e8 44 fc ff ff       	call   801aca <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	ff 75 10             	pushl  0x10(%ebp)
  801e98:	ff 75 0c             	pushl  0xc(%ebp)
  801e9b:	50                   	push   %eax
  801e9c:	6a 21                	push   $0x21
  801e9e:	e8 27 fc ff ff       	call   801aca <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	50                   	push   %eax
  801eb7:	6a 22                	push   $0x22
  801eb9:	e8 0c fc ff ff       	call   801aca <syscall>
  801ebe:	83 c4 18             	add    $0x18,%esp
}
  801ec1:	90                   	nop
  801ec2:	c9                   	leave  
  801ec3:	c3                   	ret    

00801ec4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	50                   	push   %eax
  801ed3:	6a 23                	push   $0x23
  801ed5:	e8 f0 fb ff ff       	call   801aca <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
}
  801edd:	90                   	nop
  801ede:	c9                   	leave  
  801edf:	c3                   	ret    

00801ee0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ee0:	55                   	push   %ebp
  801ee1:	89 e5                	mov    %esp,%ebp
  801ee3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ee6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee9:	8d 50 04             	lea    0x4(%eax),%edx
  801eec:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	52                   	push   %edx
  801ef6:	50                   	push   %eax
  801ef7:	6a 24                	push   $0x24
  801ef9:	e8 cc fb ff ff       	call   801aca <syscall>
  801efe:	83 c4 18             	add    $0x18,%esp
	return result;
  801f01:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f07:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f0a:	89 01                	mov    %eax,(%ecx)
  801f0c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f12:	c9                   	leave  
  801f13:	c2 04 00             	ret    $0x4

00801f16 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	ff 75 10             	pushl  0x10(%ebp)
  801f20:	ff 75 0c             	pushl  0xc(%ebp)
  801f23:	ff 75 08             	pushl  0x8(%ebp)
  801f26:	6a 13                	push   $0x13
  801f28:	e8 9d fb ff ff       	call   801aca <syscall>
  801f2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f30:	90                   	nop
}
  801f31:	c9                   	leave  
  801f32:	c3                   	ret    

00801f33 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f33:	55                   	push   %ebp
  801f34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 25                	push   $0x25
  801f42:	e8 83 fb ff ff       	call   801aca <syscall>
  801f47:	83 c4 18             	add    $0x18,%esp
}
  801f4a:	c9                   	leave  
  801f4b:	c3                   	ret    

00801f4c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f4c:	55                   	push   %ebp
  801f4d:	89 e5                	mov    %esp,%ebp
  801f4f:	83 ec 04             	sub    $0x4,%esp
  801f52:	8b 45 08             	mov    0x8(%ebp),%eax
  801f55:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f58:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	50                   	push   %eax
  801f65:	6a 26                	push   $0x26
  801f67:	e8 5e fb ff ff       	call   801aca <syscall>
  801f6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6f:	90                   	nop
}
  801f70:	c9                   	leave  
  801f71:	c3                   	ret    

00801f72 <rsttst>:
void rsttst()
{
  801f72:	55                   	push   %ebp
  801f73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 28                	push   $0x28
  801f81:	e8 44 fb ff ff       	call   801aca <syscall>
  801f86:	83 c4 18             	add    $0x18,%esp
	return ;
  801f89:	90                   	nop
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	83 ec 04             	sub    $0x4,%esp
  801f92:	8b 45 14             	mov    0x14(%ebp),%eax
  801f95:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f98:	8b 55 18             	mov    0x18(%ebp),%edx
  801f9b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f9f:	52                   	push   %edx
  801fa0:	50                   	push   %eax
  801fa1:	ff 75 10             	pushl  0x10(%ebp)
  801fa4:	ff 75 0c             	pushl  0xc(%ebp)
  801fa7:	ff 75 08             	pushl  0x8(%ebp)
  801faa:	6a 27                	push   $0x27
  801fac:	e8 19 fb ff ff       	call   801aca <syscall>
  801fb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb4:	90                   	nop
}
  801fb5:	c9                   	leave  
  801fb6:	c3                   	ret    

00801fb7 <chktst>:
void chktst(uint32 n)
{
  801fb7:	55                   	push   %ebp
  801fb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	ff 75 08             	pushl  0x8(%ebp)
  801fc5:	6a 29                	push   $0x29
  801fc7:	e8 fe fa ff ff       	call   801aca <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
	return ;
  801fcf:	90                   	nop
}
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <inctst>:

void inctst()
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 2a                	push   $0x2a
  801fe1:	e8 e4 fa ff ff       	call   801aca <syscall>
  801fe6:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe9:	90                   	nop
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <gettst>:
uint32 gettst()
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 2b                	push   $0x2b
  801ffb:	e8 ca fa ff ff       	call   801aca <syscall>
  802000:	83 c4 18             	add    $0x18,%esp
}
  802003:	c9                   	leave  
  802004:	c3                   	ret    

00802005 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802005:	55                   	push   %ebp
  802006:	89 e5                	mov    %esp,%ebp
  802008:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 2c                	push   $0x2c
  802017:	e8 ae fa ff ff       	call   801aca <syscall>
  80201c:	83 c4 18             	add    $0x18,%esp
  80201f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802022:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802026:	75 07                	jne    80202f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802028:	b8 01 00 00 00       	mov    $0x1,%eax
  80202d:	eb 05                	jmp    802034 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80202f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
  802039:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 2c                	push   $0x2c
  802048:	e8 7d fa ff ff       	call   801aca <syscall>
  80204d:	83 c4 18             	add    $0x18,%esp
  802050:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802053:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802057:	75 07                	jne    802060 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802059:	b8 01 00 00 00       	mov    $0x1,%eax
  80205e:	eb 05                	jmp    802065 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802060:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802065:	c9                   	leave  
  802066:	c3                   	ret    

00802067 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802067:	55                   	push   %ebp
  802068:	89 e5                	mov    %esp,%ebp
  80206a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 2c                	push   $0x2c
  802079:	e8 4c fa ff ff       	call   801aca <syscall>
  80207e:	83 c4 18             	add    $0x18,%esp
  802081:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802084:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802088:	75 07                	jne    802091 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80208a:	b8 01 00 00 00       	mov    $0x1,%eax
  80208f:	eb 05                	jmp    802096 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802091:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
  80209b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 2c                	push   $0x2c
  8020aa:	e8 1b fa ff ff       	call   801aca <syscall>
  8020af:	83 c4 18             	add    $0x18,%esp
  8020b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020b5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020b9:	75 07                	jne    8020c2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8020c0:	eb 05                	jmp    8020c7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020c7:	c9                   	leave  
  8020c8:	c3                   	ret    

008020c9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020c9:	55                   	push   %ebp
  8020ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	ff 75 08             	pushl  0x8(%ebp)
  8020d7:	6a 2d                	push   $0x2d
  8020d9:	e8 ec f9 ff ff       	call   801aca <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e1:	90                   	nop
}
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <__udivdi3>:
  8020e4:	55                   	push   %ebp
  8020e5:	57                   	push   %edi
  8020e6:	56                   	push   %esi
  8020e7:	53                   	push   %ebx
  8020e8:	83 ec 1c             	sub    $0x1c,%esp
  8020eb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020ef:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020f7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020fb:	89 ca                	mov    %ecx,%edx
  8020fd:	89 f8                	mov    %edi,%eax
  8020ff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802103:	85 f6                	test   %esi,%esi
  802105:	75 2d                	jne    802134 <__udivdi3+0x50>
  802107:	39 cf                	cmp    %ecx,%edi
  802109:	77 65                	ja     802170 <__udivdi3+0x8c>
  80210b:	89 fd                	mov    %edi,%ebp
  80210d:	85 ff                	test   %edi,%edi
  80210f:	75 0b                	jne    80211c <__udivdi3+0x38>
  802111:	b8 01 00 00 00       	mov    $0x1,%eax
  802116:	31 d2                	xor    %edx,%edx
  802118:	f7 f7                	div    %edi
  80211a:	89 c5                	mov    %eax,%ebp
  80211c:	31 d2                	xor    %edx,%edx
  80211e:	89 c8                	mov    %ecx,%eax
  802120:	f7 f5                	div    %ebp
  802122:	89 c1                	mov    %eax,%ecx
  802124:	89 d8                	mov    %ebx,%eax
  802126:	f7 f5                	div    %ebp
  802128:	89 cf                	mov    %ecx,%edi
  80212a:	89 fa                	mov    %edi,%edx
  80212c:	83 c4 1c             	add    $0x1c,%esp
  80212f:	5b                   	pop    %ebx
  802130:	5e                   	pop    %esi
  802131:	5f                   	pop    %edi
  802132:	5d                   	pop    %ebp
  802133:	c3                   	ret    
  802134:	39 ce                	cmp    %ecx,%esi
  802136:	77 28                	ja     802160 <__udivdi3+0x7c>
  802138:	0f bd fe             	bsr    %esi,%edi
  80213b:	83 f7 1f             	xor    $0x1f,%edi
  80213e:	75 40                	jne    802180 <__udivdi3+0x9c>
  802140:	39 ce                	cmp    %ecx,%esi
  802142:	72 0a                	jb     80214e <__udivdi3+0x6a>
  802144:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802148:	0f 87 9e 00 00 00    	ja     8021ec <__udivdi3+0x108>
  80214e:	b8 01 00 00 00       	mov    $0x1,%eax
  802153:	89 fa                	mov    %edi,%edx
  802155:	83 c4 1c             	add    $0x1c,%esp
  802158:	5b                   	pop    %ebx
  802159:	5e                   	pop    %esi
  80215a:	5f                   	pop    %edi
  80215b:	5d                   	pop    %ebp
  80215c:	c3                   	ret    
  80215d:	8d 76 00             	lea    0x0(%esi),%esi
  802160:	31 ff                	xor    %edi,%edi
  802162:	31 c0                	xor    %eax,%eax
  802164:	89 fa                	mov    %edi,%edx
  802166:	83 c4 1c             	add    $0x1c,%esp
  802169:	5b                   	pop    %ebx
  80216a:	5e                   	pop    %esi
  80216b:	5f                   	pop    %edi
  80216c:	5d                   	pop    %ebp
  80216d:	c3                   	ret    
  80216e:	66 90                	xchg   %ax,%ax
  802170:	89 d8                	mov    %ebx,%eax
  802172:	f7 f7                	div    %edi
  802174:	31 ff                	xor    %edi,%edi
  802176:	89 fa                	mov    %edi,%edx
  802178:	83 c4 1c             	add    $0x1c,%esp
  80217b:	5b                   	pop    %ebx
  80217c:	5e                   	pop    %esi
  80217d:	5f                   	pop    %edi
  80217e:	5d                   	pop    %ebp
  80217f:	c3                   	ret    
  802180:	bd 20 00 00 00       	mov    $0x20,%ebp
  802185:	89 eb                	mov    %ebp,%ebx
  802187:	29 fb                	sub    %edi,%ebx
  802189:	89 f9                	mov    %edi,%ecx
  80218b:	d3 e6                	shl    %cl,%esi
  80218d:	89 c5                	mov    %eax,%ebp
  80218f:	88 d9                	mov    %bl,%cl
  802191:	d3 ed                	shr    %cl,%ebp
  802193:	89 e9                	mov    %ebp,%ecx
  802195:	09 f1                	or     %esi,%ecx
  802197:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80219b:	89 f9                	mov    %edi,%ecx
  80219d:	d3 e0                	shl    %cl,%eax
  80219f:	89 c5                	mov    %eax,%ebp
  8021a1:	89 d6                	mov    %edx,%esi
  8021a3:	88 d9                	mov    %bl,%cl
  8021a5:	d3 ee                	shr    %cl,%esi
  8021a7:	89 f9                	mov    %edi,%ecx
  8021a9:	d3 e2                	shl    %cl,%edx
  8021ab:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021af:	88 d9                	mov    %bl,%cl
  8021b1:	d3 e8                	shr    %cl,%eax
  8021b3:	09 c2                	or     %eax,%edx
  8021b5:	89 d0                	mov    %edx,%eax
  8021b7:	89 f2                	mov    %esi,%edx
  8021b9:	f7 74 24 0c          	divl   0xc(%esp)
  8021bd:	89 d6                	mov    %edx,%esi
  8021bf:	89 c3                	mov    %eax,%ebx
  8021c1:	f7 e5                	mul    %ebp
  8021c3:	39 d6                	cmp    %edx,%esi
  8021c5:	72 19                	jb     8021e0 <__udivdi3+0xfc>
  8021c7:	74 0b                	je     8021d4 <__udivdi3+0xf0>
  8021c9:	89 d8                	mov    %ebx,%eax
  8021cb:	31 ff                	xor    %edi,%edi
  8021cd:	e9 58 ff ff ff       	jmp    80212a <__udivdi3+0x46>
  8021d2:	66 90                	xchg   %ax,%ax
  8021d4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021d8:	89 f9                	mov    %edi,%ecx
  8021da:	d3 e2                	shl    %cl,%edx
  8021dc:	39 c2                	cmp    %eax,%edx
  8021de:	73 e9                	jae    8021c9 <__udivdi3+0xe5>
  8021e0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021e3:	31 ff                	xor    %edi,%edi
  8021e5:	e9 40 ff ff ff       	jmp    80212a <__udivdi3+0x46>
  8021ea:	66 90                	xchg   %ax,%ax
  8021ec:	31 c0                	xor    %eax,%eax
  8021ee:	e9 37 ff ff ff       	jmp    80212a <__udivdi3+0x46>
  8021f3:	90                   	nop

008021f4 <__umoddi3>:
  8021f4:	55                   	push   %ebp
  8021f5:	57                   	push   %edi
  8021f6:	56                   	push   %esi
  8021f7:	53                   	push   %ebx
  8021f8:	83 ec 1c             	sub    $0x1c,%esp
  8021fb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021ff:	8b 74 24 34          	mov    0x34(%esp),%esi
  802203:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802207:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80220b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80220f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802213:	89 f3                	mov    %esi,%ebx
  802215:	89 fa                	mov    %edi,%edx
  802217:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80221b:	89 34 24             	mov    %esi,(%esp)
  80221e:	85 c0                	test   %eax,%eax
  802220:	75 1a                	jne    80223c <__umoddi3+0x48>
  802222:	39 f7                	cmp    %esi,%edi
  802224:	0f 86 a2 00 00 00    	jbe    8022cc <__umoddi3+0xd8>
  80222a:	89 c8                	mov    %ecx,%eax
  80222c:	89 f2                	mov    %esi,%edx
  80222e:	f7 f7                	div    %edi
  802230:	89 d0                	mov    %edx,%eax
  802232:	31 d2                	xor    %edx,%edx
  802234:	83 c4 1c             	add    $0x1c,%esp
  802237:	5b                   	pop    %ebx
  802238:	5e                   	pop    %esi
  802239:	5f                   	pop    %edi
  80223a:	5d                   	pop    %ebp
  80223b:	c3                   	ret    
  80223c:	39 f0                	cmp    %esi,%eax
  80223e:	0f 87 ac 00 00 00    	ja     8022f0 <__umoddi3+0xfc>
  802244:	0f bd e8             	bsr    %eax,%ebp
  802247:	83 f5 1f             	xor    $0x1f,%ebp
  80224a:	0f 84 ac 00 00 00    	je     8022fc <__umoddi3+0x108>
  802250:	bf 20 00 00 00       	mov    $0x20,%edi
  802255:	29 ef                	sub    %ebp,%edi
  802257:	89 fe                	mov    %edi,%esi
  802259:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80225d:	89 e9                	mov    %ebp,%ecx
  80225f:	d3 e0                	shl    %cl,%eax
  802261:	89 d7                	mov    %edx,%edi
  802263:	89 f1                	mov    %esi,%ecx
  802265:	d3 ef                	shr    %cl,%edi
  802267:	09 c7                	or     %eax,%edi
  802269:	89 e9                	mov    %ebp,%ecx
  80226b:	d3 e2                	shl    %cl,%edx
  80226d:	89 14 24             	mov    %edx,(%esp)
  802270:	89 d8                	mov    %ebx,%eax
  802272:	d3 e0                	shl    %cl,%eax
  802274:	89 c2                	mov    %eax,%edx
  802276:	8b 44 24 08          	mov    0x8(%esp),%eax
  80227a:	d3 e0                	shl    %cl,%eax
  80227c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802280:	8b 44 24 08          	mov    0x8(%esp),%eax
  802284:	89 f1                	mov    %esi,%ecx
  802286:	d3 e8                	shr    %cl,%eax
  802288:	09 d0                	or     %edx,%eax
  80228a:	d3 eb                	shr    %cl,%ebx
  80228c:	89 da                	mov    %ebx,%edx
  80228e:	f7 f7                	div    %edi
  802290:	89 d3                	mov    %edx,%ebx
  802292:	f7 24 24             	mull   (%esp)
  802295:	89 c6                	mov    %eax,%esi
  802297:	89 d1                	mov    %edx,%ecx
  802299:	39 d3                	cmp    %edx,%ebx
  80229b:	0f 82 87 00 00 00    	jb     802328 <__umoddi3+0x134>
  8022a1:	0f 84 91 00 00 00    	je     802338 <__umoddi3+0x144>
  8022a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022ab:	29 f2                	sub    %esi,%edx
  8022ad:	19 cb                	sbb    %ecx,%ebx
  8022af:	89 d8                	mov    %ebx,%eax
  8022b1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022b5:	d3 e0                	shl    %cl,%eax
  8022b7:	89 e9                	mov    %ebp,%ecx
  8022b9:	d3 ea                	shr    %cl,%edx
  8022bb:	09 d0                	or     %edx,%eax
  8022bd:	89 e9                	mov    %ebp,%ecx
  8022bf:	d3 eb                	shr    %cl,%ebx
  8022c1:	89 da                	mov    %ebx,%edx
  8022c3:	83 c4 1c             	add    $0x1c,%esp
  8022c6:	5b                   	pop    %ebx
  8022c7:	5e                   	pop    %esi
  8022c8:	5f                   	pop    %edi
  8022c9:	5d                   	pop    %ebp
  8022ca:	c3                   	ret    
  8022cb:	90                   	nop
  8022cc:	89 fd                	mov    %edi,%ebp
  8022ce:	85 ff                	test   %edi,%edi
  8022d0:	75 0b                	jne    8022dd <__umoddi3+0xe9>
  8022d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022d7:	31 d2                	xor    %edx,%edx
  8022d9:	f7 f7                	div    %edi
  8022db:	89 c5                	mov    %eax,%ebp
  8022dd:	89 f0                	mov    %esi,%eax
  8022df:	31 d2                	xor    %edx,%edx
  8022e1:	f7 f5                	div    %ebp
  8022e3:	89 c8                	mov    %ecx,%eax
  8022e5:	f7 f5                	div    %ebp
  8022e7:	89 d0                	mov    %edx,%eax
  8022e9:	e9 44 ff ff ff       	jmp    802232 <__umoddi3+0x3e>
  8022ee:	66 90                	xchg   %ax,%ax
  8022f0:	89 c8                	mov    %ecx,%eax
  8022f2:	89 f2                	mov    %esi,%edx
  8022f4:	83 c4 1c             	add    $0x1c,%esp
  8022f7:	5b                   	pop    %ebx
  8022f8:	5e                   	pop    %esi
  8022f9:	5f                   	pop    %edi
  8022fa:	5d                   	pop    %ebp
  8022fb:	c3                   	ret    
  8022fc:	3b 04 24             	cmp    (%esp),%eax
  8022ff:	72 06                	jb     802307 <__umoddi3+0x113>
  802301:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802305:	77 0f                	ja     802316 <__umoddi3+0x122>
  802307:	89 f2                	mov    %esi,%edx
  802309:	29 f9                	sub    %edi,%ecx
  80230b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80230f:	89 14 24             	mov    %edx,(%esp)
  802312:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802316:	8b 44 24 04          	mov    0x4(%esp),%eax
  80231a:	8b 14 24             	mov    (%esp),%edx
  80231d:	83 c4 1c             	add    $0x1c,%esp
  802320:	5b                   	pop    %ebx
  802321:	5e                   	pop    %esi
  802322:	5f                   	pop    %edi
  802323:	5d                   	pop    %ebp
  802324:	c3                   	ret    
  802325:	8d 76 00             	lea    0x0(%esi),%esi
  802328:	2b 04 24             	sub    (%esp),%eax
  80232b:	19 fa                	sbb    %edi,%edx
  80232d:	89 d1                	mov    %edx,%ecx
  80232f:	89 c6                	mov    %eax,%esi
  802331:	e9 71 ff ff ff       	jmp    8022a7 <__umoddi3+0xb3>
  802336:	66 90                	xchg   %ax,%ax
  802338:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80233c:	72 ea                	jb     802328 <__umoddi3+0x134>
  80233e:	89 d9                	mov    %ebx,%ecx
  802340:	e9 62 ff ff ff       	jmp    8022a7 <__umoddi3+0xb3>
