
obj/user/tst_free_1:     file format elf32-i386


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
  800031:	e8 5c 18 00 00       	call   801892 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	short b;
	int c;
};

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 90 01 00 00    	sub    $0x190,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004e:	eb 29                	jmp    800079 <_main+0x41>
		{
			if (myEnv->__uptr_pws[i].empty)
  800050:	a1 20 40 80 00       	mov    0x804020,%eax
  800055:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80005b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005e:	89 d0                	mov    %edx,%eax
  800060:	01 c0                	add    %eax,%eax
  800062:	01 d0                	add    %edx,%eax
  800064:	c1 e0 02             	shl    $0x2,%eax
  800067:	01 c8                	add    %ecx,%eax
  800069:	8a 40 04             	mov    0x4(%eax),%al
  80006c:	84 c0                	test   %al,%al
  80006e:	74 06                	je     800076 <_main+0x3e>
			{
				fullWS = 0;
  800070:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800074:	eb 12                	jmp    800088 <_main+0x50>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800076:	ff 45 f0             	incl   -0x10(%ebp)
  800079:	a1 20 40 80 00       	mov    0x804020,%eax
  80007e:	8b 50 74             	mov    0x74(%eax),%edx
  800081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800084:	39 c2                	cmp    %eax,%edx
  800086:	77 c8                	ja     800050 <_main+0x18>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800088:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008c:	74 14                	je     8000a2 <_main+0x6a>
  80008e:	83 ec 04             	sub    $0x4,%esp
  800091:	68 a0 35 80 00       	push   $0x8035a0
  800096:	6a 1a                	push   $0x1a
  800098:	68 bc 35 80 00       	push   $0x8035bc
  80009d:	e8 ff 18 00 00       	call   8019a1 <_panic>


	
	

	int Mega = 1024*1024;
  8000a2:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  8000a9:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)
	char minByte = 1<<7;
  8000b0:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  8000b4:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1<<15 ;
  8000b8:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  8000be:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1<<31 ;
  8000c4:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cb:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d2:	e8 b0 2d 00 00       	call   802e87 <sys_calculate_free_frames>
  8000d7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	void* ptr_allocations[20] = {0};
  8000da:	8d 95 68 fe ff ff    	lea    -0x198(%ebp),%edx
  8000e0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ea:	89 d7                	mov    %edx,%edi
  8000ec:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ee:	e8 17 2e 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8000f3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 bd 2a 00 00       	call   802bc4 <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 85 68 fe ff ff    	mov    %eax,-0x198(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800116:	85 c0                	test   %eax,%eax
  800118:	79 0d                	jns    800127 <_main+0xef>
  80011a:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800120:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800125:	76 14                	jbe    80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 d0 35 80 00       	push   $0x8035d0
  80012f:	6a 36                	push   $0x36
  800131:	68 bc 35 80 00       	push   $0x8035bc
  800136:	e8 66 18 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013b:	e8 ca 2d 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800140:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800143:	3d 00 02 00 00       	cmp    $0x200,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 38 36 80 00       	push   $0x803638
  800152:	6a 37                	push   $0x37
  800154:	68 bc 35 80 00       	push   $0x8035bc
  800159:	e8 43 18 00 00       	call   8019a1 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 24 2d 00 00       	call   802e87 <sys_calculate_free_frames>
  800163:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800166:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80016e:	48                   	dec    %eax
  80016f:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800172:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800178:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr[0] = minByte ;
  80017b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80017e:	8a 55 db             	mov    -0x25(%ebp),%dl
  800181:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800183:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800186:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800189:	01 c2                	add    %eax,%edx
  80018b:	8a 45 da             	mov    -0x26(%ebp),%al
  80018e:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800190:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800193:	e8 ef 2c 00 00       	call   802e87 <sys_calculate_free_frames>
  800198:	29 c3                	sub    %eax,%ebx
  80019a:	89 d8                	mov    %ebx,%eax
  80019c:	83 f8 03             	cmp    $0x3,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 68 36 80 00       	push   $0x803668
  8001a9:	6a 3e                	push   $0x3e
  8001ab:	68 bc 35 80 00       	push   $0x8035bc
  8001b0:	e8 ec 17 00 00       	call   8019a1 <_panic>
		int var;
		int found = 0;
  8001b5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c3:	e9 82 00 00 00       	jmp    80024a <_main+0x212>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8001cd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001d6:	89 d0                	mov    %edx,%eax
  8001d8:	01 c0                	add    %eax,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	c1 e0 02             	shl    $0x2,%eax
  8001df:	01 c8                	add    %ecx,%eax
  8001e1:	8b 00                	mov    (%eax),%eax
  8001e3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001e6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001f3:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8001f6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8001f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001fe:	39 c2                	cmp    %eax,%edx
  800200:	75 03                	jne    800205 <_main+0x1cd>
				found++;
  800202:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800205:	a1 20 40 80 00       	mov    0x804020,%eax
  80020a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800210:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800213:	89 d0                	mov    %edx,%eax
  800215:	01 c0                	add    %eax,%eax
  800217:	01 d0                	add    %edx,%eax
  800219:	c1 e0 02             	shl    $0x2,%eax
  80021c:	01 c8                	add    %ecx,%eax
  80021e:	8b 00                	mov    (%eax),%eax
  800220:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800223:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022b:	89 c1                	mov    %eax,%ecx
  80022d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800230:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800233:	01 d0                	add    %edx,%eax
  800235:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800238:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80023b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800240:	39 c1                	cmp    %eax,%ecx
  800242:	75 03                	jne    800247 <_main+0x20f>
				found++;
  800244:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr[0] = minByte ;
		byteArr[lastIndexOfByte] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		int found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800247:	ff 45 ec             	incl   -0x14(%ebp)
  80024a:	a1 20 40 80 00       	mov    0x804020,%eax
  80024f:	8b 50 74             	mov    0x74(%eax),%edx
  800252:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800255:	39 c2                	cmp    %eax,%edx
  800257:	0f 87 6b ff ff ff    	ja     8001c8 <_main+0x190>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80025d:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 ac 36 80 00       	push   $0x8036ac
  80026b:	6a 48                	push   $0x48
  80026d:	68 bc 35 80 00       	push   $0x8035bc
  800272:	e8 2a 17 00 00       	call   8019a1 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800277:	e8 8e 2c 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80027c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80027f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800282:	01 c0                	add    %eax,%eax
  800284:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	50                   	push   %eax
  80028b:	e8 34 29 00 00       	call   802bc4 <malloc>
  800290:	83 c4 10             	add    $0x10,%esp
  800293:	89 85 6c fe ff ff    	mov    %eax,-0x194(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800299:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  80029f:	89 c2                	mov    %eax,%edx
  8002a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a4:	01 c0                	add    %eax,%eax
  8002a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ab:	39 c2                	cmp    %eax,%edx
  8002ad:	72 16                	jb     8002c5 <_main+0x28d>
  8002af:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  8002b5:	89 c2                	mov    %eax,%edx
  8002b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ba:	01 c0                	add    %eax,%eax
  8002bc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c1:	39 c2                	cmp    %eax,%edx
  8002c3:	76 14                	jbe    8002d9 <_main+0x2a1>
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	68 d0 35 80 00       	push   $0x8035d0
  8002cd:	6a 4d                	push   $0x4d
  8002cf:	68 bc 35 80 00       	push   $0x8035bc
  8002d4:	e8 c8 16 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002d9:	e8 2c 2c 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8002de:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8002e1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 38 36 80 00       	push   $0x803638
  8002f0:	6a 4e                	push   $0x4e
  8002f2:	68 bc 35 80 00       	push   $0x8035bc
  8002f7:	e8 a5 16 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 86 2b 00 00       	call   802e87 <sys_calculate_free_frames>
  800301:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800304:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  80030a:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80030d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800310:	01 c0                	add    %eax,%eax
  800312:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800315:	d1 e8                	shr    %eax
  800317:	48                   	dec    %eax
  800318:	89 45 a0             	mov    %eax,-0x60(%ebp)
		shortArr[0] = minShort;
  80031b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  80031e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800321:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800324:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800327:	01 c0                	add    %eax,%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80032e:	01 c2                	add    %eax,%edx
  800330:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800334:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800337:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  80033a:	e8 48 2b 00 00       	call   802e87 <sys_calculate_free_frames>
  80033f:	29 c3                	sub    %eax,%ebx
  800341:	89 d8                	mov    %ebx,%eax
  800343:	83 f8 02             	cmp    $0x2,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 68 36 80 00       	push   $0x803668
  800350:	6a 55                	push   $0x55
  800352:	68 bc 35 80 00       	push   $0x8035bc
  800357:	e8 45 16 00 00       	call   8019a1 <_panic>
		found = 0;
  80035c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800363:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80036a:	e9 86 00 00 00       	jmp    8003f5 <_main+0x3bd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80036f:	a1 20 40 80 00       	mov    0x804020,%eax
  800374:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80037a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80037d:	89 d0                	mov    %edx,%eax
  80037f:	01 c0                	add    %eax,%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	c1 e0 02             	shl    $0x2,%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80038d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	89 c2                	mov    %eax,%edx
  800397:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80039a:	89 45 98             	mov    %eax,-0x68(%ebp)
  80039d:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a5:	39 c2                	cmp    %eax,%edx
  8003a7:	75 03                	jne    8003ac <_main+0x374>
				found++;
  8003a9:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8003b1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003ba:	89 d0                	mov    %edx,%eax
  8003bc:	01 c0                	add    %eax,%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	c1 e0 02             	shl    $0x2,%eax
  8003c3:	01 c8                	add    %ecx,%eax
  8003c5:	8b 00                	mov    (%eax),%eax
  8003c7:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003ca:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	89 c1                	mov    %eax,%ecx
  8003db:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003de:	01 c8                	add    %ecx,%eax
  8003e0:	89 45 90             	mov    %eax,-0x70(%ebp)
  8003e3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003eb:	39 c2                	cmp    %eax,%edx
  8003ed:	75 03                	jne    8003f2 <_main+0x3ba>
				found++;
  8003ef:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003f2:	ff 45 ec             	incl   -0x14(%ebp)
  8003f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8003fa:	8b 50 74             	mov    0x74(%eax),%edx
  8003fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800400:	39 c2                	cmp    %eax,%edx
  800402:	0f 87 67 ff ff ff    	ja     80036f <_main+0x337>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800408:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  80040c:	74 14                	je     800422 <_main+0x3ea>
  80040e:	83 ec 04             	sub    $0x4,%esp
  800411:	68 ac 36 80 00       	push   $0x8036ac
  800416:	6a 5e                	push   $0x5e
  800418:	68 bc 35 80 00       	push   $0x8035bc
  80041d:	e8 7f 15 00 00       	call   8019a1 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800422:	e8 e3 2a 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800427:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80042d:	01 c0                	add    %eax,%eax
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	50                   	push   %eax
  800433:	e8 8c 27 00 00       	call   802bc4 <malloc>
  800438:	83 c4 10             	add    $0x10,%esp
  80043b:	89 85 70 fe ff ff    	mov    %eax,-0x190(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800441:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  800447:	89 c2                	mov    %eax,%edx
  800449:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80044c:	c1 e0 02             	shl    $0x2,%eax
  80044f:	05 00 00 00 80       	add    $0x80000000,%eax
  800454:	39 c2                	cmp    %eax,%edx
  800456:	72 17                	jb     80046f <_main+0x437>
  800458:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  80045e:	89 c2                	mov    %eax,%edx
  800460:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800463:	c1 e0 02             	shl    $0x2,%eax
  800466:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80046b:	39 c2                	cmp    %eax,%edx
  80046d:	76 14                	jbe    800483 <_main+0x44b>
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 d0 35 80 00       	push   $0x8035d0
  800477:	6a 63                	push   $0x63
  800479:	68 bc 35 80 00       	push   $0x8035bc
  80047e:	e8 1e 15 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800483:	e8 82 2a 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800488:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80048b:	83 f8 01             	cmp    $0x1,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 38 36 80 00       	push   $0x803638
  800498:	6a 64                	push   $0x64
  80049a:	68 bc 35 80 00       	push   $0x8035bc
  80049f:	e8 fd 14 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a4:	e8 de 29 00 00       	call   802e87 <sys_calculate_free_frames>
  8004a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004ac:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  8004b2:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b8:	01 c0                	add    %eax,%eax
  8004ba:	c1 e8 02             	shr    $0x2,%eax
  8004bd:	48                   	dec    %eax
  8004be:	89 45 88             	mov    %eax,-0x78(%ebp)
		intArr[0] = minInt;
  8004c1:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004c4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004c7:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004c9:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004d6:	01 c2                	add    %eax,%edx
  8004d8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004db:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004dd:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8004e0:	e8 a2 29 00 00       	call   802e87 <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	83 f8 02             	cmp    $0x2,%eax
  8004ec:	74 14                	je     800502 <_main+0x4ca>
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	68 68 36 80 00       	push   $0x803668
  8004f6:	6a 6b                	push   $0x6b
  8004f8:	68 bc 35 80 00       	push   $0x8035bc
  8004fd:	e8 9f 14 00 00       	call   8019a1 <_panic>
		found = 0;
  800502:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800510:	e9 95 00 00 00       	jmp    8005aa <_main+0x572>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800515:	a1 20 40 80 00       	mov    0x804020,%eax
  80051a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800520:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800523:	89 d0                	mov    %edx,%eax
  800525:	01 c0                	add    %eax,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	c1 e0 02             	shl    $0x2,%eax
  80052c:	01 c8                	add    %ecx,%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800533:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800536:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053b:	89 c2                	mov    %eax,%edx
  80053d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800540:	89 45 80             	mov    %eax,-0x80(%ebp)
  800543:	8b 45 80             	mov    -0x80(%ebp),%eax
  800546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80054b:	39 c2                	cmp    %eax,%edx
  80054d:	75 03                	jne    800552 <_main+0x51a>
				found++;
  80054f:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800552:	a1 20 40 80 00       	mov    0x804020,%eax
  800557:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80055d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800560:	89 d0                	mov    %edx,%eax
  800562:	01 c0                	add    %eax,%eax
  800564:	01 d0                	add    %edx,%eax
  800566:	c1 e0 02             	shl    $0x2,%eax
  800569:	01 c8                	add    %ecx,%eax
  80056b:	8b 00                	mov    (%eax),%eax
  80056d:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  800573:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800579:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80057e:	89 c2                	mov    %eax,%edx
  800580:	8b 45 88             	mov    -0x78(%ebp),%eax
  800583:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80058a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80058d:	01 c8                	add    %ecx,%eax
  80058f:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  800595:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80059b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005a0:	39 c2                	cmp    %eax,%edx
  8005a2:	75 03                	jne    8005a7 <_main+0x56f>
				found++;
  8005a4:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005a7:	ff 45 ec             	incl   -0x14(%ebp)
  8005aa:	a1 20 40 80 00       	mov    0x804020,%eax
  8005af:	8b 50 74             	mov    0x74(%eax),%edx
  8005b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005b5:	39 c2                	cmp    %eax,%edx
  8005b7:	0f 87 58 ff ff ff    	ja     800515 <_main+0x4dd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005bd:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005c1:	74 14                	je     8005d7 <_main+0x59f>
  8005c3:	83 ec 04             	sub    $0x4,%esp
  8005c6:	68 ac 36 80 00       	push   $0x8036ac
  8005cb:	6a 74                	push   $0x74
  8005cd:	68 bc 35 80 00       	push   $0x8035bc
  8005d2:	e8 ca 13 00 00       	call   8019a1 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d7:	e8 ab 28 00 00       	call   802e87 <sys_calculate_free_frames>
  8005dc:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005df:	e8 26 29 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8005e4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ea:	01 c0                	add    %eax,%eax
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	50                   	push   %eax
  8005f0:	e8 cf 25 00 00       	call   802bc4 <malloc>
  8005f5:	83 c4 10             	add    $0x10,%esp
  8005f8:	89 85 74 fe ff ff    	mov    %eax,-0x18c(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005fe:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  800604:	89 c2                	mov    %eax,%edx
  800606:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800609:	c1 e0 02             	shl    $0x2,%eax
  80060c:	89 c1                	mov    %eax,%ecx
  80060e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800611:	c1 e0 02             	shl    $0x2,%eax
  800614:	01 c8                	add    %ecx,%eax
  800616:	05 00 00 00 80       	add    $0x80000000,%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	72 21                	jb     800640 <_main+0x608>
  80061f:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  800625:	89 c2                	mov    %eax,%edx
  800627:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062a:	c1 e0 02             	shl    $0x2,%eax
  80062d:	89 c1                	mov    %eax,%ecx
  80062f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800632:	c1 e0 02             	shl    $0x2,%eax
  800635:	01 c8                	add    %ecx,%eax
  800637:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80063c:	39 c2                	cmp    %eax,%edx
  80063e:	76 14                	jbe    800654 <_main+0x61c>
  800640:	83 ec 04             	sub    $0x4,%esp
  800643:	68 d0 35 80 00       	push   $0x8035d0
  800648:	6a 7a                	push   $0x7a
  80064a:	68 bc 35 80 00       	push   $0x8035bc
  80064f:	e8 4d 13 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800654:	e8 b1 28 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800659:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80065c:	83 f8 01             	cmp    $0x1,%eax
  80065f:	74 14                	je     800675 <_main+0x63d>
  800661:	83 ec 04             	sub    $0x4,%esp
  800664:	68 38 36 80 00       	push   $0x803638
  800669:	6a 7b                	push   $0x7b
  80066b:	68 bc 35 80 00       	push   $0x8035bc
  800670:	e8 2c 13 00 00       	call   8019a1 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800675:	e8 90 28 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80067a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80067d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800680:	89 d0                	mov    %edx,%eax
  800682:	01 c0                	add    %eax,%eax
  800684:	01 d0                	add    %edx,%eax
  800686:	01 c0                	add    %eax,%eax
  800688:	01 d0                	add    %edx,%eax
  80068a:	83 ec 0c             	sub    $0xc,%esp
  80068d:	50                   	push   %eax
  80068e:	e8 31 25 00 00       	call   802bc4 <malloc>
  800693:	83 c4 10             	add    $0x10,%esp
  800696:	89 85 78 fe ff ff    	mov    %eax,-0x188(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80069c:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006a2:	89 c2                	mov    %eax,%edx
  8006a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a7:	c1 e0 02             	shl    $0x2,%eax
  8006aa:	89 c1                	mov    %eax,%ecx
  8006ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006af:	c1 e0 03             	shl    $0x3,%eax
  8006b2:	01 c8                	add    %ecx,%eax
  8006b4:	05 00 00 00 80       	add    $0x80000000,%eax
  8006b9:	39 c2                	cmp    %eax,%edx
  8006bb:	72 21                	jb     8006de <_main+0x6a6>
  8006bd:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  8006c3:	89 c2                	mov    %eax,%edx
  8006c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c8:	c1 e0 02             	shl    $0x2,%eax
  8006cb:	89 c1                	mov    %eax,%ecx
  8006cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006d0:	c1 e0 03             	shl    $0x3,%eax
  8006d3:	01 c8                	add    %ecx,%eax
  8006d5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006da:	39 c2                	cmp    %eax,%edx
  8006dc:	76 17                	jbe    8006f5 <_main+0x6bd>
  8006de:	83 ec 04             	sub    $0x4,%esp
  8006e1:	68 d0 35 80 00       	push   $0x8035d0
  8006e6:	68 81 00 00 00       	push   $0x81
  8006eb:	68 bc 35 80 00       	push   $0x8035bc
  8006f0:	e8 ac 12 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006f5:	e8 10 28 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8006fa:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8006fd:	83 f8 02             	cmp    $0x2,%eax
  800700:	74 17                	je     800719 <_main+0x6e1>
  800702:	83 ec 04             	sub    $0x4,%esp
  800705:	68 38 36 80 00       	push   $0x803638
  80070a:	68 82 00 00 00       	push   $0x82
  80070f:	68 bc 35 80 00       	push   $0x8035bc
  800714:	e8 88 12 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800719:	e8 69 27 00 00       	call   802e87 <sys_calculate_free_frames>
  80071e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800721:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  800727:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80072d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800730:	89 d0                	mov    %edx,%eax
  800732:	01 c0                	add    %eax,%eax
  800734:	01 d0                	add    %edx,%eax
  800736:	01 c0                	add    %eax,%eax
  800738:	01 d0                	add    %edx,%eax
  80073a:	c1 e8 03             	shr    $0x3,%eax
  80073d:	48                   	dec    %eax
  80073e:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  800744:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80074a:	8a 55 db             	mov    -0x25(%ebp),%dl
  80074d:	88 10                	mov    %dl,(%eax)
  80074f:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
  800755:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800758:	66 89 42 02          	mov    %ax,0x2(%edx)
  80075c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800762:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800765:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800768:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80076e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800775:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80077b:	01 c2                	add    %eax,%edx
  80077d:	8a 45 da             	mov    -0x26(%ebp),%al
  800780:	88 02                	mov    %al,(%edx)
  800782:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800788:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80078f:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800795:	01 c2                	add    %eax,%edx
  800797:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  80079b:	66 89 42 02          	mov    %ax,0x2(%edx)
  80079f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007a5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007ac:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007b2:	01 c2                	add    %eax,%edx
  8007b4:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007b7:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007ba:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8007bd:	e8 c5 26 00 00       	call   802e87 <sys_calculate_free_frames>
  8007c2:	29 c3                	sub    %eax,%ebx
  8007c4:	89 d8                	mov    %ebx,%eax
  8007c6:	83 f8 02             	cmp    $0x2,%eax
  8007c9:	74 17                	je     8007e2 <_main+0x7aa>
  8007cb:	83 ec 04             	sub    $0x4,%esp
  8007ce:	68 68 36 80 00       	push   $0x803668
  8007d3:	68 89 00 00 00       	push   $0x89
  8007d8:	68 bc 35 80 00       	push   $0x8035bc
  8007dd:	e8 bf 11 00 00       	call   8019a1 <_panic>
		found = 0;
  8007e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007f0:	e9 aa 00 00 00       	jmp    80089f <_main+0x867>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8007fa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800800:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800803:	89 d0                	mov    %edx,%eax
  800805:	01 c0                	add    %eax,%eax
  800807:	01 d0                	add    %edx,%eax
  800809:	c1 e0 02             	shl    $0x2,%eax
  80080c:	01 c8                	add    %ecx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800816:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80081c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800821:	89 c2                	mov    %eax,%edx
  800823:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800829:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80082f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800835:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80083a:	39 c2                	cmp    %eax,%edx
  80083c:	75 03                	jne    800841 <_main+0x809>
				found++;
  80083e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800841:	a1 20 40 80 00       	mov    0x804020,%eax
  800846:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80084c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80084f:	89 d0                	mov    %edx,%eax
  800851:	01 c0                	add    %eax,%eax
  800853:	01 d0                	add    %edx,%eax
  800855:	c1 e0 02             	shl    $0x2,%eax
  800858:	01 c8                	add    %ecx,%eax
  80085a:	8b 00                	mov    (%eax),%eax
  80085c:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800862:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800868:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80086d:	89 c2                	mov    %eax,%edx
  80086f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800875:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80087c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800882:	01 c8                	add    %ecx,%eax
  800884:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  80088a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800890:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800895:	39 c2                	cmp    %eax,%edx
  800897:	75 03                	jne    80089c <_main+0x864>
				found++;
  800899:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80089c:	ff 45 ec             	incl   -0x14(%ebp)
  80089f:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a4:	8b 50 74             	mov    0x74(%eax),%edx
  8008a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008aa:	39 c2                	cmp    %eax,%edx
  8008ac:	0f 87 43 ff ff ff    	ja     8007f5 <_main+0x7bd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008b2:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008b6:	74 17                	je     8008cf <_main+0x897>
  8008b8:	83 ec 04             	sub    $0x4,%esp
  8008bb:	68 ac 36 80 00       	push   $0x8036ac
  8008c0:	68 92 00 00 00       	push   $0x92
  8008c5:	68 bc 35 80 00       	push   $0x8035bc
  8008ca:	e8 d2 10 00 00       	call   8019a1 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008cf:	e8 b3 25 00 00       	call   802e87 <sys_calculate_free_frames>
  8008d4:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d7:	e8 2e 26 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8008dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008df:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e2:	89 c2                	mov    %eax,%edx
  8008e4:	01 d2                	add    %edx,%edx
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008eb:	83 ec 0c             	sub    $0xc,%esp
  8008ee:	50                   	push   %eax
  8008ef:	e8 d0 22 00 00       	call   802bc4 <malloc>
  8008f4:	83 c4 10             	add    $0x10,%esp
  8008f7:	89 85 7c fe ff ff    	mov    %eax,-0x184(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008fd:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  800903:	89 c2                	mov    %eax,%edx
  800905:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800908:	c1 e0 02             	shl    $0x2,%eax
  80090b:	89 c1                	mov    %eax,%ecx
  80090d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800910:	c1 e0 04             	shl    $0x4,%eax
  800913:	01 c8                	add    %ecx,%eax
  800915:	05 00 00 00 80       	add    $0x80000000,%eax
  80091a:	39 c2                	cmp    %eax,%edx
  80091c:	72 21                	jb     80093f <_main+0x907>
  80091e:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  800924:	89 c2                	mov    %eax,%edx
  800926:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800929:	c1 e0 02             	shl    $0x2,%eax
  80092c:	89 c1                	mov    %eax,%ecx
  80092e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800931:	c1 e0 04             	shl    $0x4,%eax
  800934:	01 c8                	add    %ecx,%eax
  800936:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80093b:	39 c2                	cmp    %eax,%edx
  80093d:	76 17                	jbe    800956 <_main+0x91e>
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	68 d0 35 80 00       	push   $0x8035d0
  800947:	68 98 00 00 00       	push   $0x98
  80094c:	68 bc 35 80 00       	push   $0x8035bc
  800951:	e8 4b 10 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800956:	e8 af 25 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80095b:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80095e:	89 c2                	mov    %eax,%edx
  800960:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800963:	89 c1                	mov    %eax,%ecx
  800965:	01 c9                	add    %ecx,%ecx
  800967:	01 c8                	add    %ecx,%eax
  800969:	85 c0                	test   %eax,%eax
  80096b:	79 05                	jns    800972 <_main+0x93a>
  80096d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800972:	c1 f8 0c             	sar    $0xc,%eax
  800975:	39 c2                	cmp    %eax,%edx
  800977:	74 17                	je     800990 <_main+0x958>
  800979:	83 ec 04             	sub    $0x4,%esp
  80097c:	68 38 36 80 00       	push   $0x803638
  800981:	68 99 00 00 00       	push   $0x99
  800986:	68 bc 35 80 00       	push   $0x8035bc
  80098b:	e8 11 10 00 00       	call   8019a1 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800990:	e8 75 25 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800995:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800998:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099b:	89 d0                	mov    %edx,%eax
  80099d:	01 c0                	add    %eax,%eax
  80099f:	01 d0                	add    %edx,%eax
  8009a1:	01 c0                	add    %eax,%eax
  8009a3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009a6:	83 ec 0c             	sub    $0xc,%esp
  8009a9:	50                   	push   %eax
  8009aa:	e8 15 22 00 00       	call   802bc4 <malloc>
  8009af:	83 c4 10             	add    $0x10,%esp
  8009b2:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009b8:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009be:	89 c1                	mov    %eax,%ecx
  8009c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009c3:	89 d0                	mov    %edx,%eax
  8009c5:	01 c0                	add    %eax,%eax
  8009c7:	01 d0                	add    %edx,%eax
  8009c9:	01 c0                	add    %eax,%eax
  8009cb:	01 d0                	add    %edx,%eax
  8009cd:	89 c2                	mov    %eax,%edx
  8009cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009d2:	c1 e0 04             	shl    $0x4,%eax
  8009d5:	01 d0                	add    %edx,%eax
  8009d7:	05 00 00 00 80       	add    $0x80000000,%eax
  8009dc:	39 c1                	cmp    %eax,%ecx
  8009de:	72 28                	jb     800a08 <_main+0x9d0>
  8009e0:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8009e6:	89 c1                	mov    %eax,%ecx
  8009e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009eb:	89 d0                	mov    %edx,%eax
  8009ed:	01 c0                	add    %eax,%eax
  8009ef:	01 d0                	add    %edx,%eax
  8009f1:	01 c0                	add    %eax,%eax
  8009f3:	01 d0                	add    %edx,%eax
  8009f5:	89 c2                	mov    %eax,%edx
  8009f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009fa:	c1 e0 04             	shl    $0x4,%eax
  8009fd:	01 d0                	add    %edx,%eax
  8009ff:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a04:	39 c1                	cmp    %eax,%ecx
  800a06:	76 17                	jbe    800a1f <_main+0x9e7>
  800a08:	83 ec 04             	sub    $0x4,%esp
  800a0b:	68 d0 35 80 00       	push   $0x8035d0
  800a10:	68 9f 00 00 00       	push   $0x9f
  800a15:	68 bc 35 80 00       	push   $0x8035bc
  800a1a:	e8 82 0f 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a1f:	e8 e6 24 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800a24:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800a27:	89 c1                	mov    %eax,%ecx
  800a29:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a2c:	89 d0                	mov    %edx,%eax
  800a2e:	01 c0                	add    %eax,%eax
  800a30:	01 d0                	add    %edx,%eax
  800a32:	01 c0                	add    %eax,%eax
  800a34:	85 c0                	test   %eax,%eax
  800a36:	79 05                	jns    800a3d <_main+0xa05>
  800a38:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a3d:	c1 f8 0c             	sar    $0xc,%eax
  800a40:	39 c1                	cmp    %eax,%ecx
  800a42:	74 17                	je     800a5b <_main+0xa23>
  800a44:	83 ec 04             	sub    $0x4,%esp
  800a47:	68 38 36 80 00       	push   $0x803638
  800a4c:	68 a0 00 00 00       	push   $0xa0
  800a51:	68 bc 35 80 00       	push   $0x8035bc
  800a56:	e8 46 0f 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a5b:	e8 27 24 00 00       	call   802e87 <sys_calculate_free_frames>
  800a60:	89 45 c0             	mov    %eax,-0x40(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a63:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a66:	89 d0                	mov    %edx,%eax
  800a68:	01 c0                	add    %eax,%eax
  800a6a:	01 d0                	add    %edx,%eax
  800a6c:	01 c0                	add    %eax,%eax
  800a6e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a71:	48                   	dec    %eax
  800a72:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a78:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  800a7e:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2[0] = minByte ;
  800a84:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800a8a:	8a 55 db             	mov    -0x25(%ebp),%dl
  800a8d:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a8f:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a95:	89 c2                	mov    %eax,%edx
  800a97:	c1 ea 1f             	shr    $0x1f,%edx
  800a9a:	01 d0                	add    %edx,%eax
  800a9c:	d1 f8                	sar    %eax
  800a9e:	89 c2                	mov    %eax,%edx
  800aa0:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aa6:	01 c2                	add    %eax,%edx
  800aa8:	8a 45 da             	mov    -0x26(%ebp),%al
  800aab:	88 c1                	mov    %al,%cl
  800aad:	c0 e9 07             	shr    $0x7,%cl
  800ab0:	01 c8                	add    %ecx,%eax
  800ab2:	d0 f8                	sar    %al
  800ab4:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ab6:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800abc:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ac2:	01 c2                	add    %eax,%edx
  800ac4:	8a 45 da             	mov    -0x26(%ebp),%al
  800ac7:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ac9:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800acc:	e8 b6 23 00 00       	call   802e87 <sys_calculate_free_frames>
  800ad1:	29 c3                	sub    %eax,%ebx
  800ad3:	89 d8                	mov    %ebx,%eax
  800ad5:	83 f8 05             	cmp    $0x5,%eax
  800ad8:	74 17                	je     800af1 <_main+0xab9>
  800ada:	83 ec 04             	sub    $0x4,%esp
  800add:	68 68 36 80 00       	push   $0x803668
  800ae2:	68 a8 00 00 00       	push   $0xa8
  800ae7:	68 bc 35 80 00       	push   $0x8035bc
  800aec:	e8 b0 0e 00 00       	call   8019a1 <_panic>
		found = 0;
  800af1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800af8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800aff:	e9 02 01 00 00       	jmp    800c06 <_main+0xbce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b04:	a1 20 40 80 00       	mov    0x804020,%eax
  800b09:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b0f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b12:	89 d0                	mov    %edx,%eax
  800b14:	01 c0                	add    %eax,%eax
  800b16:	01 d0                	add    %edx,%eax
  800b18:	c1 e0 02             	shl    $0x2,%eax
  800b1b:	01 c8                	add    %ecx,%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b25:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b30:	89 c2                	mov    %eax,%edx
  800b32:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b38:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b3e:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b44:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b49:	39 c2                	cmp    %eax,%edx
  800b4b:	75 03                	jne    800b50 <_main+0xb18>
				found++;
  800b4d:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b50:	a1 20 40 80 00       	mov    0x804020,%eax
  800b55:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b5b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b5e:	89 d0                	mov    %edx,%eax
  800b60:	01 c0                	add    %eax,%eax
  800b62:	01 d0                	add    %edx,%eax
  800b64:	c1 e0 02             	shl    $0x2,%eax
  800b67:	01 c8                	add    %ecx,%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b71:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b77:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b7c:	89 c2                	mov    %eax,%edx
  800b7e:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b84:	89 c1                	mov    %eax,%ecx
  800b86:	c1 e9 1f             	shr    $0x1f,%ecx
  800b89:	01 c8                	add    %ecx,%eax
  800b8b:	d1 f8                	sar    %eax
  800b8d:	89 c1                	mov    %eax,%ecx
  800b8f:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b95:	01 c8                	add    %ecx,%eax
  800b97:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b9d:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800ba3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba8:	39 c2                	cmp    %eax,%edx
  800baa:	75 03                	jne    800baf <_main+0xb77>
				found++;
  800bac:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800baf:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bbd:	89 d0                	mov    %edx,%eax
  800bbf:	01 c0                	add    %eax,%eax
  800bc1:	01 d0                	add    %edx,%eax
  800bc3:	c1 e0 02             	shl    $0x2,%eax
  800bc6:	01 c8                	add    %ecx,%eax
  800bc8:	8b 00                	mov    (%eax),%eax
  800bca:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800bd0:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bd6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bdb:	89 c1                	mov    %eax,%ecx
  800bdd:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  800be3:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800be9:	01 d0                	add    %edx,%eax
  800beb:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bf1:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bf7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bfc:	39 c1                	cmp    %eax,%ecx
  800bfe:	75 03                	jne    800c03 <_main+0xbcb>
				found++;
  800c00:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c03:	ff 45 ec             	incl   -0x14(%ebp)
  800c06:	a1 20 40 80 00       	mov    0x804020,%eax
  800c0b:	8b 50 74             	mov    0x74(%eax),%edx
  800c0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c11:	39 c2                	cmp    %eax,%edx
  800c13:	0f 87 eb fe ff ff    	ja     800b04 <_main+0xacc>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c19:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c1d:	74 17                	je     800c36 <_main+0xbfe>
  800c1f:	83 ec 04             	sub    $0x4,%esp
  800c22:	68 ac 36 80 00       	push   $0x8036ac
  800c27:	68 b3 00 00 00       	push   $0xb3
  800c2c:	68 bc 35 80 00       	push   $0x8035bc
  800c31:	e8 6b 0d 00 00       	call   8019a1 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c36:	e8 cf 22 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800c3b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c3e:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c41:	89 d0                	mov    %edx,%eax
  800c43:	01 c0                	add    %eax,%eax
  800c45:	01 d0                	add    %edx,%eax
  800c47:	01 c0                	add    %eax,%eax
  800c49:	01 d0                	add    %edx,%eax
  800c4b:	01 c0                	add    %eax,%eax
  800c4d:	83 ec 0c             	sub    $0xc,%esp
  800c50:	50                   	push   %eax
  800c51:	e8 6e 1f 00 00       	call   802bc4 <malloc>
  800c56:	83 c4 10             	add    $0x10,%esp
  800c59:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c5f:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c65:	89 c1                	mov    %eax,%ecx
  800c67:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6a:	89 d0                	mov    %edx,%eax
  800c6c:	01 c0                	add    %eax,%eax
  800c6e:	01 d0                	add    %edx,%eax
  800c70:	c1 e0 02             	shl    $0x2,%eax
  800c73:	01 d0                	add    %edx,%eax
  800c75:	89 c2                	mov    %eax,%edx
  800c77:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c7a:	c1 e0 04             	shl    $0x4,%eax
  800c7d:	01 d0                	add    %edx,%eax
  800c7f:	05 00 00 00 80       	add    $0x80000000,%eax
  800c84:	39 c1                	cmp    %eax,%ecx
  800c86:	72 29                	jb     800cb1 <_main+0xc79>
  800c88:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800c8e:	89 c1                	mov    %eax,%ecx
  800c90:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c93:	89 d0                	mov    %edx,%eax
  800c95:	01 c0                	add    %eax,%eax
  800c97:	01 d0                	add    %edx,%eax
  800c99:	c1 e0 02             	shl    $0x2,%eax
  800c9c:	01 d0                	add    %edx,%eax
  800c9e:	89 c2                	mov    %eax,%edx
  800ca0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ca3:	c1 e0 04             	shl    $0x4,%eax
  800ca6:	01 d0                	add    %edx,%eax
  800ca8:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cad:	39 c1                	cmp    %eax,%ecx
  800caf:	76 17                	jbe    800cc8 <_main+0xc90>
  800cb1:	83 ec 04             	sub    $0x4,%esp
  800cb4:	68 d0 35 80 00       	push   $0x8035d0
  800cb9:	68 b8 00 00 00       	push   $0xb8
  800cbe:	68 bc 35 80 00       	push   $0x8035bc
  800cc3:	e8 d9 0c 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc8:	e8 3d 22 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800ccd:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800cd0:	83 f8 04             	cmp    $0x4,%eax
  800cd3:	74 17                	je     800cec <_main+0xcb4>
  800cd5:	83 ec 04             	sub    $0x4,%esp
  800cd8:	68 38 36 80 00       	push   $0x803638
  800cdd:	68 b9 00 00 00       	push   $0xb9
  800ce2:	68 bc 35 80 00       	push   $0x8035bc
  800ce7:	e8 b5 0c 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800cec:	e8 96 21 00 00       	call   802e87 <sys_calculate_free_frames>
  800cf1:	89 45 c0             	mov    %eax,-0x40(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cf4:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800cfa:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800d00:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d03:	89 d0                	mov    %edx,%eax
  800d05:	01 c0                	add    %eax,%eax
  800d07:	01 d0                	add    %edx,%eax
  800d09:	01 c0                	add    %eax,%eax
  800d0b:	01 d0                	add    %edx,%eax
  800d0d:	01 c0                	add    %eax,%eax
  800d0f:	d1 e8                	shr    %eax
  800d11:	48                   	dec    %eax
  800d12:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		shortArr2[0] = minShort;
  800d18:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800d1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d21:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d24:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d2a:	01 c0                	add    %eax,%eax
  800d2c:	89 c2                	mov    %eax,%edx
  800d2e:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d34:	01 c2                	add    %eax,%edx
  800d36:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d3a:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d3d:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800d40:	e8 42 21 00 00       	call   802e87 <sys_calculate_free_frames>
  800d45:	29 c3                	sub    %eax,%ebx
  800d47:	89 d8                	mov    %ebx,%eax
  800d49:	83 f8 02             	cmp    $0x2,%eax
  800d4c:	74 17                	je     800d65 <_main+0xd2d>
  800d4e:	83 ec 04             	sub    $0x4,%esp
  800d51:	68 68 36 80 00       	push   $0x803668
  800d56:	68 c0 00 00 00       	push   $0xc0
  800d5b:	68 bc 35 80 00       	push   $0x8035bc
  800d60:	e8 3c 0c 00 00       	call   8019a1 <_panic>
		found = 0;
  800d65:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d6c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d73:	e9 a7 00 00 00       	jmp    800e1f <_main+0xde7>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d78:	a1 20 40 80 00       	mov    0x804020,%eax
  800d7d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d83:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d86:	89 d0                	mov    %edx,%eax
  800d88:	01 c0                	add    %eax,%eax
  800d8a:	01 d0                	add    %edx,%eax
  800d8c:	c1 e0 02             	shl    $0x2,%eax
  800d8f:	01 c8                	add    %ecx,%eax
  800d91:	8b 00                	mov    (%eax),%eax
  800d93:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d99:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800da4:	89 c2                	mov    %eax,%edx
  800da6:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800dac:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800db2:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800db8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dbd:	39 c2                	cmp    %eax,%edx
  800dbf:	75 03                	jne    800dc4 <_main+0xd8c>
				found++;
  800dc1:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dc4:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dcf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd2:	89 d0                	mov    %edx,%eax
  800dd4:	01 c0                	add    %eax,%eax
  800dd6:	01 d0                	add    %edx,%eax
  800dd8:	c1 e0 02             	shl    $0x2,%eax
  800ddb:	01 c8                	add    %ecx,%eax
  800ddd:	8b 00                	mov    (%eax),%eax
  800ddf:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800de5:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800deb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800df0:	89 c2                	mov    %eax,%edx
  800df2:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800df8:	01 c0                	add    %eax,%eax
  800dfa:	89 c1                	mov    %eax,%ecx
  800dfc:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800e02:	01 c8                	add    %ecx,%eax
  800e04:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800e0a:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800e10:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e15:	39 c2                	cmp    %eax,%edx
  800e17:	75 03                	jne    800e1c <_main+0xde4>
				found++;
  800e19:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e1c:	ff 45 ec             	incl   -0x14(%ebp)
  800e1f:	a1 20 40 80 00       	mov    0x804020,%eax
  800e24:	8b 50 74             	mov    0x74(%eax),%edx
  800e27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e2a:	39 c2                	cmp    %eax,%edx
  800e2c:	0f 87 46 ff ff ff    	ja     800d78 <_main+0xd40>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e32:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e36:	74 17                	je     800e4f <_main+0xe17>
  800e38:	83 ec 04             	sub    $0x4,%esp
  800e3b:	68 ac 36 80 00       	push   $0x8036ac
  800e40:	68 c9 00 00 00       	push   $0xc9
  800e45:	68 bc 35 80 00       	push   $0x8035bc
  800e4a:	e8 52 0b 00 00       	call   8019a1 <_panic>
	}

	{
		//Free 1st 2 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e4f:	e8 33 20 00 00       	call   802e87 <sys_calculate_free_frames>
  800e54:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e5a:	e8 ab 20 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800e5f:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[0]);
  800e65:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800e6b:	83 ec 0c             	sub    $0xc,%esp
  800e6e:	50                   	push   %eax
  800e6f:	e8 de 1d 00 00       	call   802c52 <free>
  800e74:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e77:	e8 8e 20 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800e7c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800e82:	29 c2                	sub    %eax,%edx
  800e84:	89 d0                	mov    %edx,%eax
  800e86:	3d 00 02 00 00       	cmp    $0x200,%eax
  800e8b:	74 17                	je     800ea4 <_main+0xe6c>
  800e8d:	83 ec 04             	sub    $0x4,%esp
  800e90:	68 cc 36 80 00       	push   $0x8036cc
  800e95:	68 d1 00 00 00       	push   $0xd1
  800e9a:	68 bc 35 80 00       	push   $0x8035bc
  800e9f:	e8 fd 0a 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ea4:	e8 de 1f 00 00       	call   802e87 <sys_calculate_free_frames>
  800ea9:	89 c2                	mov    %eax,%edx
  800eab:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800eb1:	29 c2                	sub    %eax,%edx
  800eb3:	89 d0                	mov    %edx,%eax
  800eb5:	83 f8 02             	cmp    $0x2,%eax
  800eb8:	74 17                	je     800ed1 <_main+0xe99>
  800eba:	83 ec 04             	sub    $0x4,%esp
  800ebd:	68 08 37 80 00       	push   $0x803708
  800ec2:	68 d2 00 00 00       	push   $0xd2
  800ec7:	68 bc 35 80 00       	push   $0x8035bc
  800ecc:	e8 d0 0a 00 00       	call   8019a1 <_panic>
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800ed1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800ed8:	e9 c2 00 00 00       	jmp    800f9f <_main+0xf67>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  800edd:	a1 20 40 80 00       	mov    0x804020,%eax
  800ee2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ee8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800eeb:	89 d0                	mov    %edx,%eax
  800eed:	01 c0                	add    %eax,%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	c1 e0 02             	shl    $0x2,%eax
  800ef4:	01 c8                	add    %ecx,%eax
  800ef6:	8b 00                	mov    (%eax),%eax
  800ef8:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800efe:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800f04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f09:	89 c2                	mov    %eax,%edx
  800f0b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f0e:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800f14:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800f1a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f1f:	39 c2                	cmp    %eax,%edx
  800f21:	75 17                	jne    800f3a <_main+0xf02>
				panic("free: page is not removed from WS");
  800f23:	83 ec 04             	sub    $0x4,%esp
  800f26:	68 54 37 80 00       	push   $0x803754
  800f2b:	68 d7 00 00 00       	push   $0xd7
  800f30:	68 bc 35 80 00       	push   $0x8035bc
  800f35:	e8 67 0a 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800f3a:	a1 20 40 80 00       	mov    0x804020,%eax
  800f3f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800f45:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800f48:	89 d0                	mov    %edx,%eax
  800f4a:	01 c0                	add    %eax,%eax
  800f4c:	01 d0                	add    %edx,%eax
  800f4e:	c1 e0 02             	shl    $0x2,%eax
  800f51:	01 c8                	add    %ecx,%eax
  800f53:	8b 00                	mov    (%eax),%eax
  800f55:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800f5b:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800f61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f66:	89 c1                	mov    %eax,%ecx
  800f68:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800f6b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800f6e:	01 d0                	add    %edx,%eax
  800f70:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800f76:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800f7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f81:	39 c1                	cmp    %eax,%ecx
  800f83:	75 17                	jne    800f9c <_main+0xf64>
				panic("free: page is not removed from WS");
  800f85:	83 ec 04             	sub    $0x4,%esp
  800f88:	68 54 37 80 00       	push   $0x803754
  800f8d:	68 d9 00 00 00       	push   $0xd9
  800f92:	68 bc 35 80 00       	push   $0x8035bc
  800f97:	e8 05 0a 00 00       	call   8019a1 <_panic>
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[0]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800f9c:	ff 45 e4             	incl   -0x1c(%ebp)
  800f9f:	a1 20 40 80 00       	mov    0x804020,%eax
  800fa4:	8b 50 74             	mov    0x74(%eax),%edx
  800fa7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800faa:	39 c2                	cmp    %eax,%edx
  800fac:	0f 87 2b ff ff ff    	ja     800edd <_main+0xea5>
				panic("free: page is not removed from WS");
		}


		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800fb2:	e8 d0 1e 00 00       	call   802e87 <sys_calculate_free_frames>
  800fb7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fbd:	e8 48 1f 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800fc2:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[1]);
  800fc8:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  800fce:	83 ec 0c             	sub    $0xc,%esp
  800fd1:	50                   	push   %eax
  800fd2:	e8 7b 1c 00 00       	call   802c52 <free>
  800fd7:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fda:	e8 2b 1f 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  800fdf:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800fe5:	29 c2                	sub    %eax,%edx
  800fe7:	89 d0                	mov    %edx,%eax
  800fe9:	3d 00 02 00 00       	cmp    $0x200,%eax
  800fee:	74 17                	je     801007 <_main+0xfcf>
  800ff0:	83 ec 04             	sub    $0x4,%esp
  800ff3:	68 cc 36 80 00       	push   $0x8036cc
  800ff8:	68 e1 00 00 00       	push   $0xe1
  800ffd:	68 bc 35 80 00       	push   $0x8035bc
  801002:	e8 9a 09 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801007:	e8 7b 1e 00 00       	call   802e87 <sys_calculate_free_frames>
  80100c:	89 c2                	mov    %eax,%edx
  80100e:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801014:	29 c2                	sub    %eax,%edx
  801016:	89 d0                	mov    %edx,%eax
  801018:	83 f8 03             	cmp    $0x3,%eax
  80101b:	74 17                	je     801034 <_main+0xffc>
  80101d:	83 ec 04             	sub    $0x4,%esp
  801020:	68 08 37 80 00       	push   $0x803708
  801025:	68 e2 00 00 00       	push   $0xe2
  80102a:	68 bc 35 80 00       	push   $0x8035bc
  80102f:	e8 6d 09 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801034:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80103b:	e9 c6 00 00 00       	jmp    801106 <_main+0x10ce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  801040:	a1 20 40 80 00       	mov    0x804020,%eax
  801045:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80104b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80104e:	89 d0                	mov    %edx,%eax
  801050:	01 c0                	add    %eax,%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	c1 e0 02             	shl    $0x2,%eax
  801057:	01 c8                	add    %ecx,%eax
  801059:	8b 00                	mov    (%eax),%eax
  80105b:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  801061:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801067:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80106c:	89 c2                	mov    %eax,%edx
  80106e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  801071:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  801077:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  80107d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801082:	39 c2                	cmp    %eax,%edx
  801084:	75 17                	jne    80109d <_main+0x1065>
				panic("free: page is not removed from WS");
  801086:	83 ec 04             	sub    $0x4,%esp
  801089:	68 54 37 80 00       	push   $0x803754
  80108e:	68 e6 00 00 00       	push   $0xe6
  801093:	68 bc 35 80 00       	push   $0x8035bc
  801098:	e8 04 09 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  80109d:	a1 20 40 80 00       	mov    0x804020,%eax
  8010a2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8010a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010ab:	89 d0                	mov    %edx,%eax
  8010ad:	01 c0                	add    %eax,%eax
  8010af:	01 d0                	add    %edx,%eax
  8010b1:	c1 e0 02             	shl    $0x2,%eax
  8010b4:	01 c8                	add    %ecx,%eax
  8010b6:	8b 00                	mov    (%eax),%eax
  8010b8:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  8010be:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  8010c4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010c9:	89 c2                	mov    %eax,%edx
  8010cb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8010ce:	01 c0                	add    %eax,%eax
  8010d0:	89 c1                	mov    %eax,%ecx
  8010d2:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8010d5:	01 c8                	add    %ecx,%eax
  8010d7:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  8010dd:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  8010e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010e8:	39 c2                	cmp    %eax,%edx
  8010ea:	75 17                	jne    801103 <_main+0x10cb>
				panic("free: page is not removed from WS");
  8010ec:	83 ec 04             	sub    $0x4,%esp
  8010ef:	68 54 37 80 00       	push   $0x803754
  8010f4:	68 e8 00 00 00       	push   $0xe8
  8010f9:	68 bc 35 80 00       	push   $0x8035bc
  8010fe:	e8 9e 08 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[1]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801103:	ff 45 e4             	incl   -0x1c(%ebp)
  801106:	a1 20 40 80 00       	mov    0x804020,%eax
  80110b:	8b 50 74             	mov    0x74(%eax),%edx
  80110e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801111:	39 c2                	cmp    %eax,%edx
  801113:	0f 87 27 ff ff ff    	ja     801040 <_main+0x1008>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 6 MB
		freeFrames = sys_calculate_free_frames() ;
  801119:	e8 69 1d 00 00       	call   802e87 <sys_calculate_free_frames>
  80111e:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801124:	e8 e1 1d 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  801129:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[6]);
  80112f:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  801135:	83 ec 0c             	sub    $0xc,%esp
  801138:	50                   	push   %eax
  801139:	e8 14 1b 00 00       	call   802c52 <free>
  80113e:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801141:	e8 c4 1d 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  801146:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80114c:	89 d1                	mov    %edx,%ecx
  80114e:	29 c1                	sub    %eax,%ecx
  801150:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801153:	89 d0                	mov    %edx,%eax
  801155:	01 c0                	add    %eax,%eax
  801157:	01 d0                	add    %edx,%eax
  801159:	01 c0                	add    %eax,%eax
  80115b:	85 c0                	test   %eax,%eax
  80115d:	79 05                	jns    801164 <_main+0x112c>
  80115f:	05 ff 0f 00 00       	add    $0xfff,%eax
  801164:	c1 f8 0c             	sar    $0xc,%eax
  801167:	39 c1                	cmp    %eax,%ecx
  801169:	74 17                	je     801182 <_main+0x114a>
  80116b:	83 ec 04             	sub    $0x4,%esp
  80116e:	68 cc 36 80 00       	push   $0x8036cc
  801173:	68 ef 00 00 00       	push   $0xef
  801178:	68 bc 35 80 00       	push   $0x8035bc
  80117d:	e8 1f 08 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801182:	e8 00 1d 00 00       	call   802e87 <sys_calculate_free_frames>
  801187:	89 c2                	mov    %eax,%edx
  801189:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80118f:	29 c2                	sub    %eax,%edx
  801191:	89 d0                	mov    %edx,%eax
  801193:	83 f8 04             	cmp    $0x4,%eax
  801196:	74 17                	je     8011af <_main+0x1177>
  801198:	83 ec 04             	sub    $0x4,%esp
  80119b:	68 08 37 80 00       	push   $0x803708
  8011a0:	68 f0 00 00 00       	push   $0xf0
  8011a5:	68 bc 35 80 00       	push   $0x8035bc
  8011aa:	e8 f2 07 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8011b6:	e9 3e 01 00 00       	jmp    8012f9 <_main+0x12c1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8011bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8011c0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8011c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8011c9:	89 d0                	mov    %edx,%eax
  8011cb:	01 c0                	add    %eax,%eax
  8011cd:	01 d0                	add    %edx,%eax
  8011cf:	c1 e0 02             	shl    $0x2,%eax
  8011d2:	01 c8                	add    %ecx,%eax
  8011d4:	8b 00                	mov    (%eax),%eax
  8011d6:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8011dc:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8011e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011e7:	89 c2                	mov    %eax,%edx
  8011e9:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8011ef:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  8011f5:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  8011fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801200:	39 c2                	cmp    %eax,%edx
  801202:	75 17                	jne    80121b <_main+0x11e3>
				panic("free: page is not removed from WS");
  801204:	83 ec 04             	sub    $0x4,%esp
  801207:	68 54 37 80 00       	push   $0x803754
  80120c:	68 f4 00 00 00       	push   $0xf4
  801211:	68 bc 35 80 00       	push   $0x8035bc
  801216:	e8 86 07 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  80121b:	a1 20 40 80 00       	mov    0x804020,%eax
  801220:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801226:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801229:	89 d0                	mov    %edx,%eax
  80122b:	01 c0                	add    %eax,%eax
  80122d:	01 d0                	add    %edx,%eax
  80122f:	c1 e0 02             	shl    $0x2,%eax
  801232:	01 c8                	add    %ecx,%eax
  801234:	8b 00                	mov    (%eax),%eax
  801236:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  80123c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  801242:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801247:	89 c2                	mov    %eax,%edx
  801249:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  80124f:	89 c1                	mov    %eax,%ecx
  801251:	c1 e9 1f             	shr    $0x1f,%ecx
  801254:	01 c8                	add    %ecx,%eax
  801256:	d1 f8                	sar    %eax
  801258:	89 c1                	mov    %eax,%ecx
  80125a:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  801260:	01 c8                	add    %ecx,%eax
  801262:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  801268:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80126e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801273:	39 c2                	cmp    %eax,%edx
  801275:	75 17                	jne    80128e <_main+0x1256>
				panic("free: page is not removed from WS");
  801277:	83 ec 04             	sub    $0x4,%esp
  80127a:	68 54 37 80 00       	push   $0x803754
  80127f:	68 f6 00 00 00       	push   $0xf6
  801284:	68 bc 35 80 00       	push   $0x8035bc
  801289:	e8 13 07 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  80128e:	a1 20 40 80 00       	mov    0x804020,%eax
  801293:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801299:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80129c:	89 d0                	mov    %edx,%eax
  80129e:	01 c0                	add    %eax,%eax
  8012a0:	01 d0                	add    %edx,%eax
  8012a2:	c1 e0 02             	shl    $0x2,%eax
  8012a5:	01 c8                	add    %ecx,%eax
  8012a7:	8b 00                	mov    (%eax),%eax
  8012a9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  8012af:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8012b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012ba:	89 c1                	mov    %eax,%ecx
  8012bc:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
  8012c2:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8012c8:	01 d0                	add    %edx,%eax
  8012ca:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  8012d0:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8012d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012db:	39 c1                	cmp    %eax,%ecx
  8012dd:	75 17                	jne    8012f6 <_main+0x12be>
				panic("free: page is not removed from WS");
  8012df:	83 ec 04             	sub    $0x4,%esp
  8012e2:	68 54 37 80 00       	push   $0x803754
  8012e7:	68 f8 00 00 00       	push   $0xf8
  8012ec:	68 bc 35 80 00       	push   $0x8035bc
  8012f1:	e8 ab 06 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[6]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8012f6:	ff 45 e4             	incl   -0x1c(%ebp)
  8012f9:	a1 20 40 80 00       	mov    0x804020,%eax
  8012fe:	8b 50 74             	mov    0x74(%eax),%edx
  801301:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801304:	39 c2                	cmp    %eax,%edx
  801306:	0f 87 af fe ff ff    	ja     8011bb <_main+0x1183>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  80130c:	e8 76 1b 00 00       	call   802e87 <sys_calculate_free_frames>
  801311:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801317:	e8 ee 1b 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80131c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[4]);
  801322:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  801328:	83 ec 0c             	sub    $0xc,%esp
  80132b:	50                   	push   %eax
  80132c:	e8 21 19 00 00       	call   802c52 <free>
  801331:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801334:	e8 d1 1b 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  801339:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80133f:	29 c2                	sub    %eax,%edx
  801341:	89 d0                	mov    %edx,%eax
  801343:	83 f8 02             	cmp    $0x2,%eax
  801346:	74 17                	je     80135f <_main+0x1327>
  801348:	83 ec 04             	sub    $0x4,%esp
  80134b:	68 cc 36 80 00       	push   $0x8036cc
  801350:	68 ff 00 00 00       	push   $0xff
  801355:	68 bc 35 80 00       	push   $0x8035bc
  80135a:	e8 42 06 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80135f:	e8 23 1b 00 00       	call   802e87 <sys_calculate_free_frames>
  801364:	89 c2                	mov    %eax,%edx
  801366:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80136c:	29 c2                	sub    %eax,%edx
  80136e:	89 d0                	mov    %edx,%eax
  801370:	83 f8 02             	cmp    $0x2,%eax
  801373:	74 17                	je     80138c <_main+0x1354>
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	68 08 37 80 00       	push   $0x803708
  80137d:	68 00 01 00 00       	push   $0x100
  801382:	68 bc 35 80 00       	push   $0x8035bc
  801387:	e8 15 06 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80138c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801393:	e9 d2 00 00 00       	jmp    80146a <_main+0x1432>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  801398:	a1 20 40 80 00       	mov    0x804020,%eax
  80139d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8013a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8013a6:	89 d0                	mov    %edx,%eax
  8013a8:	01 c0                	add    %eax,%eax
  8013aa:	01 d0                	add    %edx,%eax
  8013ac:	c1 e0 02             	shl    $0x2,%eax
  8013af:	01 c8                	add    %ecx,%eax
  8013b1:	8b 00                	mov    (%eax),%eax
  8013b3:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  8013b9:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8013bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013c4:	89 c2                	mov    %eax,%edx
  8013c6:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8013cc:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  8013d2:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8013d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013dd:	39 c2                	cmp    %eax,%edx
  8013df:	75 17                	jne    8013f8 <_main+0x13c0>
				panic("free: page is not removed from WS");
  8013e1:	83 ec 04             	sub    $0x4,%esp
  8013e4:	68 54 37 80 00       	push   $0x803754
  8013e9:	68 04 01 00 00       	push   $0x104
  8013ee:	68 bc 35 80 00       	push   $0x8035bc
  8013f3:	e8 a9 05 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  8013f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8013fd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801403:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801406:	89 d0                	mov    %edx,%eax
  801408:	01 c0                	add    %eax,%eax
  80140a:	01 d0                	add    %edx,%eax
  80140c:	c1 e0 02             	shl    $0x2,%eax
  80140f:	01 c8                	add    %ecx,%eax
  801411:	8b 00                	mov    (%eax),%eax
  801413:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801419:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80141f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801424:	89 c2                	mov    %eax,%edx
  801426:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80142c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  801433:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  801439:	01 c8                	add    %ecx,%eax
  80143b:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801441:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  801447:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80144c:	39 c2                	cmp    %eax,%edx
  80144e:	75 17                	jne    801467 <_main+0x142f>
				panic("free: page is not removed from WS");
  801450:	83 ec 04             	sub    $0x4,%esp
  801453:	68 54 37 80 00       	push   $0x803754
  801458:	68 06 01 00 00       	push   $0x106
  80145d:	68 bc 35 80 00       	push   $0x8035bc
  801462:	e8 3a 05 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[4]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801467:	ff 45 e4             	incl   -0x1c(%ebp)
  80146a:	a1 20 40 80 00       	mov    0x804020,%eax
  80146f:	8b 50 74             	mov    0x74(%eax),%edx
  801472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801475:	39 c2                	cmp    %eax,%edx
  801477:	0f 87 1b ff ff ff    	ja     801398 <_main+0x1360>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80147d:	e8 05 1a 00 00       	call   802e87 <sys_calculate_free_frames>
  801482:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801488:	e8 7d 1a 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80148d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[5]);
  801493:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  801499:	83 ec 0c             	sub    $0xc,%esp
  80149c:	50                   	push   %eax
  80149d:	e8 b0 17 00 00       	call   802c52 <free>
  8014a2:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014a5:	e8 60 1a 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8014aa:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8014b0:	89 d1                	mov    %edx,%ecx
  8014b2:	29 c1                	sub    %eax,%ecx
  8014b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014b7:	89 c2                	mov    %eax,%edx
  8014b9:	01 d2                	add    %edx,%edx
  8014bb:	01 d0                	add    %edx,%eax
  8014bd:	85 c0                	test   %eax,%eax
  8014bf:	79 05                	jns    8014c6 <_main+0x148e>
  8014c1:	05 ff 0f 00 00       	add    $0xfff,%eax
  8014c6:	c1 f8 0c             	sar    $0xc,%eax
  8014c9:	39 c1                	cmp    %eax,%ecx
  8014cb:	74 17                	je     8014e4 <_main+0x14ac>
  8014cd:	83 ec 04             	sub    $0x4,%esp
  8014d0:	68 cc 36 80 00       	push   $0x8036cc
  8014d5:	68 0d 01 00 00       	push   $0x10d
  8014da:	68 bc 35 80 00       	push   $0x8035bc
  8014df:	e8 bd 04 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014e4:	e8 9e 19 00 00       	call   802e87 <sys_calculate_free_frames>
  8014e9:	89 c2                	mov    %eax,%edx
  8014eb:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8014f1:	39 c2                	cmp    %eax,%edx
  8014f3:	74 17                	je     80150c <_main+0x14d4>
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	68 08 37 80 00       	push   $0x803708
  8014fd:	68 0e 01 00 00       	push   $0x10e
  801502:	68 bc 35 80 00       	push   $0x8035bc
  801507:	e8 95 04 00 00       	call   8019a1 <_panic>

		//Free 1st 2 KB
		freeFrames = sys_calculate_free_frames() ;
  80150c:	e8 76 19 00 00       	call   802e87 <sys_calculate_free_frames>
  801511:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801517:	e8 ee 19 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80151c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[2]);
  801522:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  801528:	83 ec 0c             	sub    $0xc,%esp
  80152b:	50                   	push   %eax
  80152c:	e8 21 17 00 00       	call   802c52 <free>
  801531:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801534:	e8 d1 19 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  801539:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
  801543:	83 f8 01             	cmp    $0x1,%eax
  801546:	74 17                	je     80155f <_main+0x1527>
  801548:	83 ec 04             	sub    $0x4,%esp
  80154b:	68 cc 36 80 00       	push   $0x8036cc
  801550:	68 14 01 00 00       	push   $0x114
  801555:	68 bc 35 80 00       	push   $0x8035bc
  80155a:	e8 42 04 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80155f:	e8 23 19 00 00       	call   802e87 <sys_calculate_free_frames>
  801564:	89 c2                	mov    %eax,%edx
  801566:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80156c:	29 c2                	sub    %eax,%edx
  80156e:	89 d0                	mov    %edx,%eax
  801570:	83 f8 02             	cmp    $0x2,%eax
  801573:	74 17                	je     80158c <_main+0x1554>
  801575:	83 ec 04             	sub    $0x4,%esp
  801578:	68 08 37 80 00       	push   $0x803708
  80157d:	68 15 01 00 00       	push   $0x115
  801582:	68 bc 35 80 00       	push   $0x8035bc
  801587:	e8 15 04 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80158c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801593:	e9 c9 00 00 00       	jmp    801661 <_main+0x1629>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  801598:	a1 20 40 80 00       	mov    0x804020,%eax
  80159d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8015a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8015a6:	89 d0                	mov    %edx,%eax
  8015a8:	01 c0                	add    %eax,%eax
  8015aa:	01 d0                	add    %edx,%eax
  8015ac:	c1 e0 02             	shl    $0x2,%eax
  8015af:	01 c8                	add    %ecx,%eax
  8015b1:	8b 00                	mov    (%eax),%eax
  8015b3:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8015b9:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8015bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015c4:	89 c2                	mov    %eax,%edx
  8015c6:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8015c9:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  8015cf:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8015d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8015da:	39 c2                	cmp    %eax,%edx
  8015dc:	75 17                	jne    8015f5 <_main+0x15bd>
				panic("free: page is not removed from WS");
  8015de:	83 ec 04             	sub    $0x4,%esp
  8015e1:	68 54 37 80 00       	push   $0x803754
  8015e6:	68 19 01 00 00       	push   $0x119
  8015eb:	68 bc 35 80 00       	push   $0x8035bc
  8015f0:	e8 ac 03 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  8015f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8015fa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801603:	89 d0                	mov    %edx,%eax
  801605:	01 c0                	add    %eax,%eax
  801607:	01 d0                	add    %edx,%eax
  801609:	c1 e0 02             	shl    $0x2,%eax
  80160c:	01 c8                	add    %ecx,%eax
  80160e:	8b 00                	mov    (%eax),%eax
  801610:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  801616:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80161c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801621:	89 c2                	mov    %eax,%edx
  801623:	8b 45 88             	mov    -0x78(%ebp),%eax
  801626:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80162d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  801630:	01 c8                	add    %ecx,%eax
  801632:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
  801638:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80163e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801643:	39 c2                	cmp    %eax,%edx
  801645:	75 17                	jne    80165e <_main+0x1626>
				panic("free: page is not removed from WS");
  801647:	83 ec 04             	sub    $0x4,%esp
  80164a:	68 54 37 80 00       	push   $0x803754
  80164f:	68 1b 01 00 00       	push   $0x11b
  801654:	68 bc 35 80 00       	push   $0x8035bc
  801659:	e8 43 03 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[2]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80165e:	ff 45 e4             	incl   -0x1c(%ebp)
  801661:	a1 20 40 80 00       	mov    0x804020,%eax
  801666:	8b 50 74             	mov    0x74(%eax),%edx
  801669:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80166c:	39 c2                	cmp    %eax,%edx
  80166e:	0f 87 24 ff ff ff    	ja     801598 <_main+0x1560>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 2nd 2 KB
		freeFrames = sys_calculate_free_frames() ;
  801674:	e8 0e 18 00 00       	call   802e87 <sys_calculate_free_frames>
  801679:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80167f:	e8 86 18 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  801684:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[3]);
  80168a:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  801690:	83 ec 0c             	sub    $0xc,%esp
  801693:	50                   	push   %eax
  801694:	e8 b9 15 00 00       	call   802c52 <free>
  801699:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80169c:	e8 69 18 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8016a1:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8016a7:	29 c2                	sub    %eax,%edx
  8016a9:	89 d0                	mov    %edx,%eax
  8016ab:	83 f8 01             	cmp    $0x1,%eax
  8016ae:	74 17                	je     8016c7 <_main+0x168f>
  8016b0:	83 ec 04             	sub    $0x4,%esp
  8016b3:	68 cc 36 80 00       	push   $0x8036cc
  8016b8:	68 22 01 00 00       	push   $0x122
  8016bd:	68 bc 35 80 00       	push   $0x8035bc
  8016c2:	e8 da 02 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8016c7:	e8 bb 17 00 00       	call   802e87 <sys_calculate_free_frames>
  8016cc:	89 c2                	mov    %eax,%edx
  8016ce:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8016d4:	39 c2                	cmp    %eax,%edx
  8016d6:	74 17                	je     8016ef <_main+0x16b7>
  8016d8:	83 ec 04             	sub    $0x4,%esp
  8016db:	68 08 37 80 00       	push   $0x803708
  8016e0:	68 23 01 00 00       	push   $0x123
  8016e5:	68 bc 35 80 00       	push   $0x8035bc
  8016ea:	e8 b2 02 00 00       	call   8019a1 <_panic>


		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  8016ef:	e8 93 17 00 00       	call   802e87 <sys_calculate_free_frames>
  8016f4:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8016fa:	e8 0b 18 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  8016ff:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[7]);
  801705:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80170b:	83 ec 0c             	sub    $0xc,%esp
  80170e:	50                   	push   %eax
  80170f:	e8 3e 15 00 00       	call   802c52 <free>
  801714:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801717:	e8 ee 17 00 00       	call   802f0a <sys_pf_calculate_allocated_pages>
  80171c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  801722:	29 c2                	sub    %eax,%edx
  801724:	89 d0                	mov    %edx,%eax
  801726:	83 f8 04             	cmp    $0x4,%eax
  801729:	74 17                	je     801742 <_main+0x170a>
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	68 cc 36 80 00       	push   $0x8036cc
  801733:	68 2a 01 00 00       	push   $0x12a
  801738:	68 bc 35 80 00       	push   $0x8035bc
  80173d:	e8 5f 02 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801742:	e8 40 17 00 00       	call   802e87 <sys_calculate_free_frames>
  801747:	89 c2                	mov    %eax,%edx
  801749:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80174f:	29 c2                	sub    %eax,%edx
  801751:	89 d0                	mov    %edx,%eax
  801753:	83 f8 03             	cmp    $0x3,%eax
  801756:	74 17                	je     80176f <_main+0x1737>
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	68 08 37 80 00       	push   $0x803708
  801760:	68 2b 01 00 00       	push   $0x12b
  801765:	68 bc 35 80 00       	push   $0x8035bc
  80176a:	e8 32 02 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80176f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801776:	e9 c6 00 00 00       	jmp    801841 <_main+0x1809>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80177b:	a1 20 40 80 00       	mov    0x804020,%eax
  801780:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801786:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801789:	89 d0                	mov    %edx,%eax
  80178b:	01 c0                	add    %eax,%eax
  80178d:	01 d0                	add    %edx,%eax
  80178f:	c1 e0 02             	shl    $0x2,%eax
  801792:	01 c8                	add    %ecx,%eax
  801794:	8b 00                	mov    (%eax),%eax
  801796:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
  80179c:	8b 85 c4 fe ff ff    	mov    -0x13c(%ebp),%eax
  8017a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017a7:	89 c2                	mov    %eax,%edx
  8017a9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8017ac:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
  8017b2:	8b 85 c0 fe ff ff    	mov    -0x140(%ebp),%eax
  8017b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017bd:	39 c2                	cmp    %eax,%edx
  8017bf:	75 17                	jne    8017d8 <_main+0x17a0>
				panic("free: page is not removed from WS");
  8017c1:	83 ec 04             	sub    $0x4,%esp
  8017c4:	68 54 37 80 00       	push   $0x803754
  8017c9:	68 2f 01 00 00       	push   $0x12f
  8017ce:	68 bc 35 80 00       	push   $0x8035bc
  8017d3:	e8 c9 01 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8017d8:	a1 20 40 80 00       	mov    0x804020,%eax
  8017dd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8017e3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017e6:	89 d0                	mov    %edx,%eax
  8017e8:	01 c0                	add    %eax,%eax
  8017ea:	01 d0                	add    %edx,%eax
  8017ec:	c1 e0 02             	shl    $0x2,%eax
  8017ef:	01 c8                	add    %ecx,%eax
  8017f1:	8b 00                	mov    (%eax),%eax
  8017f3:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
  8017f9:	8b 85 bc fe ff ff    	mov    -0x144(%ebp),%eax
  8017ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801804:	89 c2                	mov    %eax,%edx
  801806:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801809:	01 c0                	add    %eax,%eax
  80180b:	89 c1                	mov    %eax,%ecx
  80180d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  801810:	01 c8                	add    %ecx,%eax
  801812:	89 85 b8 fe ff ff    	mov    %eax,-0x148(%ebp)
  801818:	8b 85 b8 fe ff ff    	mov    -0x148(%ebp),%eax
  80181e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801823:	39 c2                	cmp    %eax,%edx
  801825:	75 17                	jne    80183e <_main+0x1806>
				panic("free: page is not removed from WS");
  801827:	83 ec 04             	sub    $0x4,%esp
  80182a:	68 54 37 80 00       	push   $0x803754
  80182f:	68 31 01 00 00       	push   $0x131
  801834:	68 bc 35 80 00       	push   $0x8035bc
  801839:	e8 63 01 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[7]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80183e:	ff 45 e4             	incl   -0x1c(%ebp)
  801841:	a1 20 40 80 00       	mov    0x804020,%eax
  801846:	8b 50 74             	mov    0x74(%eax),%edx
  801849:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80184c:	39 c2                	cmp    %eax,%edx
  80184e:	0f 87 27 ff ff ff    	ja     80177b <_main+0x1743>
				panic("free: page is not removed from WS");
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801854:	e8 2e 16 00 00       	call   802e87 <sys_calculate_free_frames>
  801859:	8d 50 04             	lea    0x4(%eax),%edx
  80185c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80185f:	39 c2                	cmp    %eax,%edx
  801861:	74 17                	je     80187a <_main+0x1842>
  801863:	83 ec 04             	sub    $0x4,%esp
  801866:	68 78 37 80 00       	push   $0x803778
  80186b:	68 34 01 00 00       	push   $0x134
  801870:	68 bc 35 80 00       	push   $0x8035bc
  801875:	e8 27 01 00 00       	call   8019a1 <_panic>
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  80187a:	83 ec 0c             	sub    $0xc,%esp
  80187d:	68 ac 37 80 00       	push   $0x8037ac
  801882:	e8 ce 03 00 00       	call   801c55 <cprintf>
  801887:	83 c4 10             	add    $0x10,%esp

	return;
  80188a:	90                   	nop
}
  80188b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80188e:	5b                   	pop    %ebx
  80188f:	5f                   	pop    %edi
  801890:	5d                   	pop    %ebp
  801891:	c3                   	ret    

00801892 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
  801895:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801898:	e8 1f 15 00 00       	call   802dbc <sys_getenvindex>
  80189d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8018a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a3:	89 d0                	mov    %edx,%eax
  8018a5:	c1 e0 02             	shl    $0x2,%eax
  8018a8:	01 d0                	add    %edx,%eax
  8018aa:	01 c0                	add    %eax,%eax
  8018ac:	01 d0                	add    %edx,%eax
  8018ae:	01 c0                	add    %eax,%eax
  8018b0:	01 d0                	add    %edx,%eax
  8018b2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8018b9:	01 d0                	add    %edx,%eax
  8018bb:	c1 e0 02             	shl    $0x2,%eax
  8018be:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8018c3:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8018c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8018cd:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8018d3:	84 c0                	test   %al,%al
  8018d5:	74 0f                	je     8018e6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8018d7:	a1 20 40 80 00       	mov    0x804020,%eax
  8018dc:	05 f4 02 00 00       	add    $0x2f4,%eax
  8018e1:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8018e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018ea:	7e 0a                	jle    8018f6 <libmain+0x64>
		binaryname = argv[0];
  8018ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ef:	8b 00                	mov    (%eax),%eax
  8018f1:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8018f6:	83 ec 08             	sub    $0x8,%esp
  8018f9:	ff 75 0c             	pushl  0xc(%ebp)
  8018fc:	ff 75 08             	pushl  0x8(%ebp)
  8018ff:	e8 34 e7 ff ff       	call   800038 <_main>
  801904:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801907:	e8 4b 16 00 00       	call   802f57 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80190c:	83 ec 0c             	sub    $0xc,%esp
  80190f:	68 00 38 80 00       	push   $0x803800
  801914:	e8 3c 03 00 00       	call   801c55 <cprintf>
  801919:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80191c:	a1 20 40 80 00       	mov    0x804020,%eax
  801921:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801927:	a1 20 40 80 00       	mov    0x804020,%eax
  80192c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801932:	83 ec 04             	sub    $0x4,%esp
  801935:	52                   	push   %edx
  801936:	50                   	push   %eax
  801937:	68 28 38 80 00       	push   $0x803828
  80193c:	e8 14 03 00 00       	call   801c55 <cprintf>
  801941:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801944:	a1 20 40 80 00       	mov    0x804020,%eax
  801949:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80194f:	83 ec 08             	sub    $0x8,%esp
  801952:	50                   	push   %eax
  801953:	68 4d 38 80 00       	push   $0x80384d
  801958:	e8 f8 02 00 00       	call   801c55 <cprintf>
  80195d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801960:	83 ec 0c             	sub    $0xc,%esp
  801963:	68 00 38 80 00       	push   $0x803800
  801968:	e8 e8 02 00 00       	call   801c55 <cprintf>
  80196d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801970:	e8 fc 15 00 00       	call   802f71 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801975:	e8 19 00 00 00       	call   801993 <exit>
}
  80197a:	90                   	nop
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
  801980:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801983:	83 ec 0c             	sub    $0xc,%esp
  801986:	6a 00                	push   $0x0
  801988:	e8 fb 13 00 00       	call   802d88 <sys_env_destroy>
  80198d:	83 c4 10             	add    $0x10,%esp
}
  801990:	90                   	nop
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <exit>:

void
exit(void)
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
  801996:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801999:	e8 50 14 00 00       	call   802dee <sys_env_exit>
}
  80199e:	90                   	nop
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
  8019a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8019a7:	8d 45 10             	lea    0x10(%ebp),%eax
  8019aa:	83 c0 04             	add    $0x4,%eax
  8019ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8019b0:	a1 48 40 88 00       	mov    0x884048,%eax
  8019b5:	85 c0                	test   %eax,%eax
  8019b7:	74 16                	je     8019cf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8019b9:	a1 48 40 88 00       	mov    0x884048,%eax
  8019be:	83 ec 08             	sub    $0x8,%esp
  8019c1:	50                   	push   %eax
  8019c2:	68 64 38 80 00       	push   $0x803864
  8019c7:	e8 89 02 00 00       	call   801c55 <cprintf>
  8019cc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8019cf:	a1 00 40 80 00       	mov    0x804000,%eax
  8019d4:	ff 75 0c             	pushl  0xc(%ebp)
  8019d7:	ff 75 08             	pushl  0x8(%ebp)
  8019da:	50                   	push   %eax
  8019db:	68 69 38 80 00       	push   $0x803869
  8019e0:	e8 70 02 00 00       	call   801c55 <cprintf>
  8019e5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8019e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019eb:	83 ec 08             	sub    $0x8,%esp
  8019ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8019f1:	50                   	push   %eax
  8019f2:	e8 f3 01 00 00       	call   801bea <vcprintf>
  8019f7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8019fa:	83 ec 08             	sub    $0x8,%esp
  8019fd:	6a 00                	push   $0x0
  8019ff:	68 85 38 80 00       	push   $0x803885
  801a04:	e8 e1 01 00 00       	call   801bea <vcprintf>
  801a09:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801a0c:	e8 82 ff ff ff       	call   801993 <exit>

	// should not return here
	while (1) ;
  801a11:	eb fe                	jmp    801a11 <_panic+0x70>

00801a13 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
  801a16:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801a19:	a1 20 40 80 00       	mov    0x804020,%eax
  801a1e:	8b 50 74             	mov    0x74(%eax),%edx
  801a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a24:	39 c2                	cmp    %eax,%edx
  801a26:	74 14                	je     801a3c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801a28:	83 ec 04             	sub    $0x4,%esp
  801a2b:	68 88 38 80 00       	push   $0x803888
  801a30:	6a 26                	push   $0x26
  801a32:	68 d4 38 80 00       	push   $0x8038d4
  801a37:	e8 65 ff ff ff       	call   8019a1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801a3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a43:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a4a:	e9 c2 00 00 00       	jmp    801b11 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801a4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a52:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a59:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5c:	01 d0                	add    %edx,%eax
  801a5e:	8b 00                	mov    (%eax),%eax
  801a60:	85 c0                	test   %eax,%eax
  801a62:	75 08                	jne    801a6c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a64:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a67:	e9 a2 00 00 00       	jmp    801b0e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801a6c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a73:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a7a:	eb 69                	jmp    801ae5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a7c:	a1 20 40 80 00       	mov    0x804020,%eax
  801a81:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801a87:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801a8a:	89 d0                	mov    %edx,%eax
  801a8c:	01 c0                	add    %eax,%eax
  801a8e:	01 d0                	add    %edx,%eax
  801a90:	c1 e0 02             	shl    $0x2,%eax
  801a93:	01 c8                	add    %ecx,%eax
  801a95:	8a 40 04             	mov    0x4(%eax),%al
  801a98:	84 c0                	test   %al,%al
  801a9a:	75 46                	jne    801ae2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801a9c:	a1 20 40 80 00       	mov    0x804020,%eax
  801aa1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801aa7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801aaa:	89 d0                	mov    %edx,%eax
  801aac:	01 c0                	add    %eax,%eax
  801aae:	01 d0                	add    %edx,%eax
  801ab0:	c1 e0 02             	shl    $0x2,%eax
  801ab3:	01 c8                	add    %ecx,%eax
  801ab5:	8b 00                	mov    (%eax),%eax
  801ab7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801aba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801abd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ac2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801ac4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ac7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801ace:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad1:	01 c8                	add    %ecx,%eax
  801ad3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801ad5:	39 c2                	cmp    %eax,%edx
  801ad7:	75 09                	jne    801ae2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801ad9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801ae0:	eb 12                	jmp    801af4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ae2:	ff 45 e8             	incl   -0x18(%ebp)
  801ae5:	a1 20 40 80 00       	mov    0x804020,%eax
  801aea:	8b 50 74             	mov    0x74(%eax),%edx
  801aed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801af0:	39 c2                	cmp    %eax,%edx
  801af2:	77 88                	ja     801a7c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801af4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801af8:	75 14                	jne    801b0e <CheckWSWithoutLastIndex+0xfb>
			panic(
  801afa:	83 ec 04             	sub    $0x4,%esp
  801afd:	68 e0 38 80 00       	push   $0x8038e0
  801b02:	6a 3a                	push   $0x3a
  801b04:	68 d4 38 80 00       	push   $0x8038d4
  801b09:	e8 93 fe ff ff       	call   8019a1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b0e:	ff 45 f0             	incl   -0x10(%ebp)
  801b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b14:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801b17:	0f 8c 32 ff ff ff    	jl     801a4f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801b1d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b24:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801b2b:	eb 26                	jmp    801b53 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801b2d:	a1 20 40 80 00       	mov    0x804020,%eax
  801b32:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801b38:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801b3b:	89 d0                	mov    %edx,%eax
  801b3d:	01 c0                	add    %eax,%eax
  801b3f:	01 d0                	add    %edx,%eax
  801b41:	c1 e0 02             	shl    $0x2,%eax
  801b44:	01 c8                	add    %ecx,%eax
  801b46:	8a 40 04             	mov    0x4(%eax),%al
  801b49:	3c 01                	cmp    $0x1,%al
  801b4b:	75 03                	jne    801b50 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801b4d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b50:	ff 45 e0             	incl   -0x20(%ebp)
  801b53:	a1 20 40 80 00       	mov    0x804020,%eax
  801b58:	8b 50 74             	mov    0x74(%eax),%edx
  801b5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b5e:	39 c2                	cmp    %eax,%edx
  801b60:	77 cb                	ja     801b2d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b65:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b68:	74 14                	je     801b7e <CheckWSWithoutLastIndex+0x16b>
		panic(
  801b6a:	83 ec 04             	sub    $0x4,%esp
  801b6d:	68 34 39 80 00       	push   $0x803934
  801b72:	6a 44                	push   $0x44
  801b74:	68 d4 38 80 00       	push   $0x8038d4
  801b79:	e8 23 fe ff ff       	call   8019a1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b7e:	90                   	nop
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
  801b84:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b8a:	8b 00                	mov    (%eax),%eax
  801b8c:	8d 48 01             	lea    0x1(%eax),%ecx
  801b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b92:	89 0a                	mov    %ecx,(%edx)
  801b94:	8b 55 08             	mov    0x8(%ebp),%edx
  801b97:	88 d1                	mov    %dl,%cl
  801b99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ba3:	8b 00                	mov    (%eax),%eax
  801ba5:	3d ff 00 00 00       	cmp    $0xff,%eax
  801baa:	75 2c                	jne    801bd8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801bac:	a0 24 40 80 00       	mov    0x804024,%al
  801bb1:	0f b6 c0             	movzbl %al,%eax
  801bb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb7:	8b 12                	mov    (%edx),%edx
  801bb9:	89 d1                	mov    %edx,%ecx
  801bbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbe:	83 c2 08             	add    $0x8,%edx
  801bc1:	83 ec 04             	sub    $0x4,%esp
  801bc4:	50                   	push   %eax
  801bc5:	51                   	push   %ecx
  801bc6:	52                   	push   %edx
  801bc7:	e8 7a 11 00 00       	call   802d46 <sys_cputs>
  801bcc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bd2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bdb:	8b 40 04             	mov    0x4(%eax),%eax
  801bde:	8d 50 01             	lea    0x1(%eax),%edx
  801be1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be4:	89 50 04             	mov    %edx,0x4(%eax)
}
  801be7:	90                   	nop
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
  801bed:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801bf3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801bfa:	00 00 00 
	b.cnt = 0;
  801bfd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801c04:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801c07:	ff 75 0c             	pushl  0xc(%ebp)
  801c0a:	ff 75 08             	pushl  0x8(%ebp)
  801c0d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c13:	50                   	push   %eax
  801c14:	68 81 1b 80 00       	push   $0x801b81
  801c19:	e8 11 02 00 00       	call   801e2f <vprintfmt>
  801c1e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801c21:	a0 24 40 80 00       	mov    0x804024,%al
  801c26:	0f b6 c0             	movzbl %al,%eax
  801c29:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801c2f:	83 ec 04             	sub    $0x4,%esp
  801c32:	50                   	push   %eax
  801c33:	52                   	push   %edx
  801c34:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c3a:	83 c0 08             	add    $0x8,%eax
  801c3d:	50                   	push   %eax
  801c3e:	e8 03 11 00 00       	call   802d46 <sys_cputs>
  801c43:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801c46:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801c4d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801c53:	c9                   	leave  
  801c54:	c3                   	ret    

00801c55 <cprintf>:

int cprintf(const char *fmt, ...) {
  801c55:	55                   	push   %ebp
  801c56:	89 e5                	mov    %esp,%ebp
  801c58:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801c5b:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801c62:	8d 45 0c             	lea    0xc(%ebp),%eax
  801c65:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801c68:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6b:	83 ec 08             	sub    $0x8,%esp
  801c6e:	ff 75 f4             	pushl  -0xc(%ebp)
  801c71:	50                   	push   %eax
  801c72:	e8 73 ff ff ff       	call   801bea <vcprintf>
  801c77:	83 c4 10             	add    $0x10,%esp
  801c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801c7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
  801c85:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801c88:	e8 ca 12 00 00       	call   802f57 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801c8d:	8d 45 0c             	lea    0xc(%ebp),%eax
  801c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801c93:	8b 45 08             	mov    0x8(%ebp),%eax
  801c96:	83 ec 08             	sub    $0x8,%esp
  801c99:	ff 75 f4             	pushl  -0xc(%ebp)
  801c9c:	50                   	push   %eax
  801c9d:	e8 48 ff ff ff       	call   801bea <vcprintf>
  801ca2:	83 c4 10             	add    $0x10,%esp
  801ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801ca8:	e8 c4 12 00 00       	call   802f71 <sys_enable_interrupt>
	return cnt;
  801cad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
  801cb5:	53                   	push   %ebx
  801cb6:	83 ec 14             	sub    $0x14,%esp
  801cb9:	8b 45 10             	mov    0x10(%ebp),%eax
  801cbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cbf:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801cc5:	8b 45 18             	mov    0x18(%ebp),%eax
  801cc8:	ba 00 00 00 00       	mov    $0x0,%edx
  801ccd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801cd0:	77 55                	ja     801d27 <printnum+0x75>
  801cd2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801cd5:	72 05                	jb     801cdc <printnum+0x2a>
  801cd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801cda:	77 4b                	ja     801d27 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801cdc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801cdf:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801ce2:	8b 45 18             	mov    0x18(%ebp),%eax
  801ce5:	ba 00 00 00 00       	mov    $0x0,%edx
  801cea:	52                   	push   %edx
  801ceb:	50                   	push   %eax
  801cec:	ff 75 f4             	pushl  -0xc(%ebp)
  801cef:	ff 75 f0             	pushl  -0x10(%ebp)
  801cf2:	e8 41 16 00 00       	call   803338 <__udivdi3>
  801cf7:	83 c4 10             	add    $0x10,%esp
  801cfa:	83 ec 04             	sub    $0x4,%esp
  801cfd:	ff 75 20             	pushl  0x20(%ebp)
  801d00:	53                   	push   %ebx
  801d01:	ff 75 18             	pushl  0x18(%ebp)
  801d04:	52                   	push   %edx
  801d05:	50                   	push   %eax
  801d06:	ff 75 0c             	pushl  0xc(%ebp)
  801d09:	ff 75 08             	pushl  0x8(%ebp)
  801d0c:	e8 a1 ff ff ff       	call   801cb2 <printnum>
  801d11:	83 c4 20             	add    $0x20,%esp
  801d14:	eb 1a                	jmp    801d30 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801d16:	83 ec 08             	sub    $0x8,%esp
  801d19:	ff 75 0c             	pushl  0xc(%ebp)
  801d1c:	ff 75 20             	pushl  0x20(%ebp)
  801d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d22:	ff d0                	call   *%eax
  801d24:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801d27:	ff 4d 1c             	decl   0x1c(%ebp)
  801d2a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801d2e:	7f e6                	jg     801d16 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801d30:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801d33:	bb 00 00 00 00       	mov    $0x0,%ebx
  801d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d3e:	53                   	push   %ebx
  801d3f:	51                   	push   %ecx
  801d40:	52                   	push   %edx
  801d41:	50                   	push   %eax
  801d42:	e8 01 17 00 00       	call   803448 <__umoddi3>
  801d47:	83 c4 10             	add    $0x10,%esp
  801d4a:	05 94 3b 80 00       	add    $0x803b94,%eax
  801d4f:	8a 00                	mov    (%eax),%al
  801d51:	0f be c0             	movsbl %al,%eax
  801d54:	83 ec 08             	sub    $0x8,%esp
  801d57:	ff 75 0c             	pushl  0xc(%ebp)
  801d5a:	50                   	push   %eax
  801d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5e:	ff d0                	call   *%eax
  801d60:	83 c4 10             	add    $0x10,%esp
}
  801d63:	90                   	nop
  801d64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801d6c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801d70:	7e 1c                	jle    801d8e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	8b 00                	mov    (%eax),%eax
  801d77:	8d 50 08             	lea    0x8(%eax),%edx
  801d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7d:	89 10                	mov    %edx,(%eax)
  801d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d82:	8b 00                	mov    (%eax),%eax
  801d84:	83 e8 08             	sub    $0x8,%eax
  801d87:	8b 50 04             	mov    0x4(%eax),%edx
  801d8a:	8b 00                	mov    (%eax),%eax
  801d8c:	eb 40                	jmp    801dce <getuint+0x65>
	else if (lflag)
  801d8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d92:	74 1e                	je     801db2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801d94:	8b 45 08             	mov    0x8(%ebp),%eax
  801d97:	8b 00                	mov    (%eax),%eax
  801d99:	8d 50 04             	lea    0x4(%eax),%edx
  801d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9f:	89 10                	mov    %edx,(%eax)
  801da1:	8b 45 08             	mov    0x8(%ebp),%eax
  801da4:	8b 00                	mov    (%eax),%eax
  801da6:	83 e8 04             	sub    $0x4,%eax
  801da9:	8b 00                	mov    (%eax),%eax
  801dab:	ba 00 00 00 00       	mov    $0x0,%edx
  801db0:	eb 1c                	jmp    801dce <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	8b 00                	mov    (%eax),%eax
  801db7:	8d 50 04             	lea    0x4(%eax),%edx
  801dba:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbd:	89 10                	mov    %edx,(%eax)
  801dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc2:	8b 00                	mov    (%eax),%eax
  801dc4:	83 e8 04             	sub    $0x4,%eax
  801dc7:	8b 00                	mov    (%eax),%eax
  801dc9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801dce:	5d                   	pop    %ebp
  801dcf:	c3                   	ret    

00801dd0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801dd3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801dd7:	7e 1c                	jle    801df5 <getint+0x25>
		return va_arg(*ap, long long);
  801dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddc:	8b 00                	mov    (%eax),%eax
  801dde:	8d 50 08             	lea    0x8(%eax),%edx
  801de1:	8b 45 08             	mov    0x8(%ebp),%eax
  801de4:	89 10                	mov    %edx,(%eax)
  801de6:	8b 45 08             	mov    0x8(%ebp),%eax
  801de9:	8b 00                	mov    (%eax),%eax
  801deb:	83 e8 08             	sub    $0x8,%eax
  801dee:	8b 50 04             	mov    0x4(%eax),%edx
  801df1:	8b 00                	mov    (%eax),%eax
  801df3:	eb 38                	jmp    801e2d <getint+0x5d>
	else if (lflag)
  801df5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801df9:	74 1a                	je     801e15 <getint+0x45>
		return va_arg(*ap, long);
  801dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfe:	8b 00                	mov    (%eax),%eax
  801e00:	8d 50 04             	lea    0x4(%eax),%edx
  801e03:	8b 45 08             	mov    0x8(%ebp),%eax
  801e06:	89 10                	mov    %edx,(%eax)
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0b:	8b 00                	mov    (%eax),%eax
  801e0d:	83 e8 04             	sub    $0x4,%eax
  801e10:	8b 00                	mov    (%eax),%eax
  801e12:	99                   	cltd   
  801e13:	eb 18                	jmp    801e2d <getint+0x5d>
	else
		return va_arg(*ap, int);
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	8b 00                	mov    (%eax),%eax
  801e1a:	8d 50 04             	lea    0x4(%eax),%edx
  801e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e20:	89 10                	mov    %edx,(%eax)
  801e22:	8b 45 08             	mov    0x8(%ebp),%eax
  801e25:	8b 00                	mov    (%eax),%eax
  801e27:	83 e8 04             	sub    $0x4,%eax
  801e2a:	8b 00                	mov    (%eax),%eax
  801e2c:	99                   	cltd   
}
  801e2d:	5d                   	pop    %ebp
  801e2e:	c3                   	ret    

00801e2f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801e2f:	55                   	push   %ebp
  801e30:	89 e5                	mov    %esp,%ebp
  801e32:	56                   	push   %esi
  801e33:	53                   	push   %ebx
  801e34:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e37:	eb 17                	jmp    801e50 <vprintfmt+0x21>
			if (ch == '\0')
  801e39:	85 db                	test   %ebx,%ebx
  801e3b:	0f 84 af 03 00 00    	je     8021f0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801e41:	83 ec 08             	sub    $0x8,%esp
  801e44:	ff 75 0c             	pushl  0xc(%ebp)
  801e47:	53                   	push   %ebx
  801e48:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4b:	ff d0                	call   *%eax
  801e4d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801e50:	8b 45 10             	mov    0x10(%ebp),%eax
  801e53:	8d 50 01             	lea    0x1(%eax),%edx
  801e56:	89 55 10             	mov    %edx,0x10(%ebp)
  801e59:	8a 00                	mov    (%eax),%al
  801e5b:	0f b6 d8             	movzbl %al,%ebx
  801e5e:	83 fb 25             	cmp    $0x25,%ebx
  801e61:	75 d6                	jne    801e39 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801e63:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801e67:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801e6e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801e75:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801e7c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801e83:	8b 45 10             	mov    0x10(%ebp),%eax
  801e86:	8d 50 01             	lea    0x1(%eax),%edx
  801e89:	89 55 10             	mov    %edx,0x10(%ebp)
  801e8c:	8a 00                	mov    (%eax),%al
  801e8e:	0f b6 d8             	movzbl %al,%ebx
  801e91:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801e94:	83 f8 55             	cmp    $0x55,%eax
  801e97:	0f 87 2b 03 00 00    	ja     8021c8 <vprintfmt+0x399>
  801e9d:	8b 04 85 b8 3b 80 00 	mov    0x803bb8(,%eax,4),%eax
  801ea4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801ea6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801eaa:	eb d7                	jmp    801e83 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801eac:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801eb0:	eb d1                	jmp    801e83 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801eb2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801eb9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ebc:	89 d0                	mov    %edx,%eax
  801ebe:	c1 e0 02             	shl    $0x2,%eax
  801ec1:	01 d0                	add    %edx,%eax
  801ec3:	01 c0                	add    %eax,%eax
  801ec5:	01 d8                	add    %ebx,%eax
  801ec7:	83 e8 30             	sub    $0x30,%eax
  801eca:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ed0:	8a 00                	mov    (%eax),%al
  801ed2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ed5:	83 fb 2f             	cmp    $0x2f,%ebx
  801ed8:	7e 3e                	jle    801f18 <vprintfmt+0xe9>
  801eda:	83 fb 39             	cmp    $0x39,%ebx
  801edd:	7f 39                	jg     801f18 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801edf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801ee2:	eb d5                	jmp    801eb9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801ee4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ee7:	83 c0 04             	add    $0x4,%eax
  801eea:	89 45 14             	mov    %eax,0x14(%ebp)
  801eed:	8b 45 14             	mov    0x14(%ebp),%eax
  801ef0:	83 e8 04             	sub    $0x4,%eax
  801ef3:	8b 00                	mov    (%eax),%eax
  801ef5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801ef8:	eb 1f                	jmp    801f19 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801efa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801efe:	79 83                	jns    801e83 <vprintfmt+0x54>
				width = 0;
  801f00:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801f07:	e9 77 ff ff ff       	jmp    801e83 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801f0c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801f13:	e9 6b ff ff ff       	jmp    801e83 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801f18:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801f19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f1d:	0f 89 60 ff ff ff    	jns    801e83 <vprintfmt+0x54>
				width = precision, precision = -1;
  801f23:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801f29:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801f30:	e9 4e ff ff ff       	jmp    801e83 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801f35:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801f38:	e9 46 ff ff ff       	jmp    801e83 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801f3d:	8b 45 14             	mov    0x14(%ebp),%eax
  801f40:	83 c0 04             	add    $0x4,%eax
  801f43:	89 45 14             	mov    %eax,0x14(%ebp)
  801f46:	8b 45 14             	mov    0x14(%ebp),%eax
  801f49:	83 e8 04             	sub    $0x4,%eax
  801f4c:	8b 00                	mov    (%eax),%eax
  801f4e:	83 ec 08             	sub    $0x8,%esp
  801f51:	ff 75 0c             	pushl  0xc(%ebp)
  801f54:	50                   	push   %eax
  801f55:	8b 45 08             	mov    0x8(%ebp),%eax
  801f58:	ff d0                	call   *%eax
  801f5a:	83 c4 10             	add    $0x10,%esp
			break;
  801f5d:	e9 89 02 00 00       	jmp    8021eb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801f62:	8b 45 14             	mov    0x14(%ebp),%eax
  801f65:	83 c0 04             	add    $0x4,%eax
  801f68:	89 45 14             	mov    %eax,0x14(%ebp)
  801f6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801f6e:	83 e8 04             	sub    $0x4,%eax
  801f71:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801f73:	85 db                	test   %ebx,%ebx
  801f75:	79 02                	jns    801f79 <vprintfmt+0x14a>
				err = -err;
  801f77:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801f79:	83 fb 64             	cmp    $0x64,%ebx
  801f7c:	7f 0b                	jg     801f89 <vprintfmt+0x15a>
  801f7e:	8b 34 9d 00 3a 80 00 	mov    0x803a00(,%ebx,4),%esi
  801f85:	85 f6                	test   %esi,%esi
  801f87:	75 19                	jne    801fa2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801f89:	53                   	push   %ebx
  801f8a:	68 a5 3b 80 00       	push   $0x803ba5
  801f8f:	ff 75 0c             	pushl  0xc(%ebp)
  801f92:	ff 75 08             	pushl  0x8(%ebp)
  801f95:	e8 5e 02 00 00       	call   8021f8 <printfmt>
  801f9a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801f9d:	e9 49 02 00 00       	jmp    8021eb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801fa2:	56                   	push   %esi
  801fa3:	68 ae 3b 80 00       	push   $0x803bae
  801fa8:	ff 75 0c             	pushl  0xc(%ebp)
  801fab:	ff 75 08             	pushl  0x8(%ebp)
  801fae:	e8 45 02 00 00       	call   8021f8 <printfmt>
  801fb3:	83 c4 10             	add    $0x10,%esp
			break;
  801fb6:	e9 30 02 00 00       	jmp    8021eb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801fbb:	8b 45 14             	mov    0x14(%ebp),%eax
  801fbe:	83 c0 04             	add    $0x4,%eax
  801fc1:	89 45 14             	mov    %eax,0x14(%ebp)
  801fc4:	8b 45 14             	mov    0x14(%ebp),%eax
  801fc7:	83 e8 04             	sub    $0x4,%eax
  801fca:	8b 30                	mov    (%eax),%esi
  801fcc:	85 f6                	test   %esi,%esi
  801fce:	75 05                	jne    801fd5 <vprintfmt+0x1a6>
				p = "(null)";
  801fd0:	be b1 3b 80 00       	mov    $0x803bb1,%esi
			if (width > 0 && padc != '-')
  801fd5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801fd9:	7e 6d                	jle    802048 <vprintfmt+0x219>
  801fdb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801fdf:	74 67                	je     802048 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801fe1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801fe4:	83 ec 08             	sub    $0x8,%esp
  801fe7:	50                   	push   %eax
  801fe8:	56                   	push   %esi
  801fe9:	e8 0c 03 00 00       	call   8022fa <strnlen>
  801fee:	83 c4 10             	add    $0x10,%esp
  801ff1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801ff4:	eb 16                	jmp    80200c <vprintfmt+0x1dd>
					putch(padc, putdat);
  801ff6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801ffa:	83 ec 08             	sub    $0x8,%esp
  801ffd:	ff 75 0c             	pushl  0xc(%ebp)
  802000:	50                   	push   %eax
  802001:	8b 45 08             	mov    0x8(%ebp),%eax
  802004:	ff d0                	call   *%eax
  802006:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  802009:	ff 4d e4             	decl   -0x1c(%ebp)
  80200c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802010:	7f e4                	jg     801ff6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  802012:	eb 34                	jmp    802048 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  802014:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  802018:	74 1c                	je     802036 <vprintfmt+0x207>
  80201a:	83 fb 1f             	cmp    $0x1f,%ebx
  80201d:	7e 05                	jle    802024 <vprintfmt+0x1f5>
  80201f:	83 fb 7e             	cmp    $0x7e,%ebx
  802022:	7e 12                	jle    802036 <vprintfmt+0x207>
					putch('?', putdat);
  802024:	83 ec 08             	sub    $0x8,%esp
  802027:	ff 75 0c             	pushl  0xc(%ebp)
  80202a:	6a 3f                	push   $0x3f
  80202c:	8b 45 08             	mov    0x8(%ebp),%eax
  80202f:	ff d0                	call   *%eax
  802031:	83 c4 10             	add    $0x10,%esp
  802034:	eb 0f                	jmp    802045 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  802036:	83 ec 08             	sub    $0x8,%esp
  802039:	ff 75 0c             	pushl  0xc(%ebp)
  80203c:	53                   	push   %ebx
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	ff d0                	call   *%eax
  802042:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  802045:	ff 4d e4             	decl   -0x1c(%ebp)
  802048:	89 f0                	mov    %esi,%eax
  80204a:	8d 70 01             	lea    0x1(%eax),%esi
  80204d:	8a 00                	mov    (%eax),%al
  80204f:	0f be d8             	movsbl %al,%ebx
  802052:	85 db                	test   %ebx,%ebx
  802054:	74 24                	je     80207a <vprintfmt+0x24b>
  802056:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80205a:	78 b8                	js     802014 <vprintfmt+0x1e5>
  80205c:	ff 4d e0             	decl   -0x20(%ebp)
  80205f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  802063:	79 af                	jns    802014 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  802065:	eb 13                	jmp    80207a <vprintfmt+0x24b>
				putch(' ', putdat);
  802067:	83 ec 08             	sub    $0x8,%esp
  80206a:	ff 75 0c             	pushl  0xc(%ebp)
  80206d:	6a 20                	push   $0x20
  80206f:	8b 45 08             	mov    0x8(%ebp),%eax
  802072:	ff d0                	call   *%eax
  802074:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  802077:	ff 4d e4             	decl   -0x1c(%ebp)
  80207a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80207e:	7f e7                	jg     802067 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  802080:	e9 66 01 00 00       	jmp    8021eb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  802085:	83 ec 08             	sub    $0x8,%esp
  802088:	ff 75 e8             	pushl  -0x18(%ebp)
  80208b:	8d 45 14             	lea    0x14(%ebp),%eax
  80208e:	50                   	push   %eax
  80208f:	e8 3c fd ff ff       	call   801dd0 <getint>
  802094:	83 c4 10             	add    $0x10,%esp
  802097:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80209a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80209d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020a3:	85 d2                	test   %edx,%edx
  8020a5:	79 23                	jns    8020ca <vprintfmt+0x29b>
				putch('-', putdat);
  8020a7:	83 ec 08             	sub    $0x8,%esp
  8020aa:	ff 75 0c             	pushl  0xc(%ebp)
  8020ad:	6a 2d                	push   $0x2d
  8020af:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b2:	ff d0                	call   *%eax
  8020b4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8020b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020bd:	f7 d8                	neg    %eax
  8020bf:	83 d2 00             	adc    $0x0,%edx
  8020c2:	f7 da                	neg    %edx
  8020c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8020ca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8020d1:	e9 bc 00 00 00       	jmp    802192 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8020d6:	83 ec 08             	sub    $0x8,%esp
  8020d9:	ff 75 e8             	pushl  -0x18(%ebp)
  8020dc:	8d 45 14             	lea    0x14(%ebp),%eax
  8020df:	50                   	push   %eax
  8020e0:	e8 84 fc ff ff       	call   801d69 <getuint>
  8020e5:	83 c4 10             	add    $0x10,%esp
  8020e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8020ee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8020f5:	e9 98 00 00 00       	jmp    802192 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8020fa:	83 ec 08             	sub    $0x8,%esp
  8020fd:	ff 75 0c             	pushl  0xc(%ebp)
  802100:	6a 58                	push   $0x58
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	ff d0                	call   *%eax
  802107:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80210a:	83 ec 08             	sub    $0x8,%esp
  80210d:	ff 75 0c             	pushl  0xc(%ebp)
  802110:	6a 58                	push   $0x58
  802112:	8b 45 08             	mov    0x8(%ebp),%eax
  802115:	ff d0                	call   *%eax
  802117:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80211a:	83 ec 08             	sub    $0x8,%esp
  80211d:	ff 75 0c             	pushl  0xc(%ebp)
  802120:	6a 58                	push   $0x58
  802122:	8b 45 08             	mov    0x8(%ebp),%eax
  802125:	ff d0                	call   *%eax
  802127:	83 c4 10             	add    $0x10,%esp
			break;
  80212a:	e9 bc 00 00 00       	jmp    8021eb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80212f:	83 ec 08             	sub    $0x8,%esp
  802132:	ff 75 0c             	pushl  0xc(%ebp)
  802135:	6a 30                	push   $0x30
  802137:	8b 45 08             	mov    0x8(%ebp),%eax
  80213a:	ff d0                	call   *%eax
  80213c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80213f:	83 ec 08             	sub    $0x8,%esp
  802142:	ff 75 0c             	pushl  0xc(%ebp)
  802145:	6a 78                	push   $0x78
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
  80214a:	ff d0                	call   *%eax
  80214c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80214f:	8b 45 14             	mov    0x14(%ebp),%eax
  802152:	83 c0 04             	add    $0x4,%eax
  802155:	89 45 14             	mov    %eax,0x14(%ebp)
  802158:	8b 45 14             	mov    0x14(%ebp),%eax
  80215b:	83 e8 04             	sub    $0x4,%eax
  80215e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  802160:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802163:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80216a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  802171:	eb 1f                	jmp    802192 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  802173:	83 ec 08             	sub    $0x8,%esp
  802176:	ff 75 e8             	pushl  -0x18(%ebp)
  802179:	8d 45 14             	lea    0x14(%ebp),%eax
  80217c:	50                   	push   %eax
  80217d:	e8 e7 fb ff ff       	call   801d69 <getuint>
  802182:	83 c4 10             	add    $0x10,%esp
  802185:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802188:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80218b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  802192:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  802196:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802199:	83 ec 04             	sub    $0x4,%esp
  80219c:	52                   	push   %edx
  80219d:	ff 75 e4             	pushl  -0x1c(%ebp)
  8021a0:	50                   	push   %eax
  8021a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8021a4:	ff 75 f0             	pushl  -0x10(%ebp)
  8021a7:	ff 75 0c             	pushl  0xc(%ebp)
  8021aa:	ff 75 08             	pushl  0x8(%ebp)
  8021ad:	e8 00 fb ff ff       	call   801cb2 <printnum>
  8021b2:	83 c4 20             	add    $0x20,%esp
			break;
  8021b5:	eb 34                	jmp    8021eb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8021b7:	83 ec 08             	sub    $0x8,%esp
  8021ba:	ff 75 0c             	pushl  0xc(%ebp)
  8021bd:	53                   	push   %ebx
  8021be:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c1:	ff d0                	call   *%eax
  8021c3:	83 c4 10             	add    $0x10,%esp
			break;
  8021c6:	eb 23                	jmp    8021eb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8021c8:	83 ec 08             	sub    $0x8,%esp
  8021cb:	ff 75 0c             	pushl  0xc(%ebp)
  8021ce:	6a 25                	push   $0x25
  8021d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d3:	ff d0                	call   *%eax
  8021d5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8021d8:	ff 4d 10             	decl   0x10(%ebp)
  8021db:	eb 03                	jmp    8021e0 <vprintfmt+0x3b1>
  8021dd:	ff 4d 10             	decl   0x10(%ebp)
  8021e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8021e3:	48                   	dec    %eax
  8021e4:	8a 00                	mov    (%eax),%al
  8021e6:	3c 25                	cmp    $0x25,%al
  8021e8:	75 f3                	jne    8021dd <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8021ea:	90                   	nop
		}
	}
  8021eb:	e9 47 fc ff ff       	jmp    801e37 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8021f0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8021f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8021f4:	5b                   	pop    %ebx
  8021f5:	5e                   	pop    %esi
  8021f6:	5d                   	pop    %ebp
  8021f7:	c3                   	ret    

008021f8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8021f8:	55                   	push   %ebp
  8021f9:	89 e5                	mov    %esp,%ebp
  8021fb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8021fe:	8d 45 10             	lea    0x10(%ebp),%eax
  802201:	83 c0 04             	add    $0x4,%eax
  802204:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  802207:	8b 45 10             	mov    0x10(%ebp),%eax
  80220a:	ff 75 f4             	pushl  -0xc(%ebp)
  80220d:	50                   	push   %eax
  80220e:	ff 75 0c             	pushl  0xc(%ebp)
  802211:	ff 75 08             	pushl  0x8(%ebp)
  802214:	e8 16 fc ff ff       	call   801e2f <vprintfmt>
  802219:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80221c:	90                   	nop
  80221d:	c9                   	leave  
  80221e:	c3                   	ret    

0080221f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80221f:	55                   	push   %ebp
  802220:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  802222:	8b 45 0c             	mov    0xc(%ebp),%eax
  802225:	8b 40 08             	mov    0x8(%eax),%eax
  802228:	8d 50 01             	lea    0x1(%eax),%edx
  80222b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80222e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802231:	8b 45 0c             	mov    0xc(%ebp),%eax
  802234:	8b 10                	mov    (%eax),%edx
  802236:	8b 45 0c             	mov    0xc(%ebp),%eax
  802239:	8b 40 04             	mov    0x4(%eax),%eax
  80223c:	39 c2                	cmp    %eax,%edx
  80223e:	73 12                	jae    802252 <sprintputch+0x33>
		*b->buf++ = ch;
  802240:	8b 45 0c             	mov    0xc(%ebp),%eax
  802243:	8b 00                	mov    (%eax),%eax
  802245:	8d 48 01             	lea    0x1(%eax),%ecx
  802248:	8b 55 0c             	mov    0xc(%ebp),%edx
  80224b:	89 0a                	mov    %ecx,(%edx)
  80224d:	8b 55 08             	mov    0x8(%ebp),%edx
  802250:	88 10                	mov    %dl,(%eax)
}
  802252:	90                   	nop
  802253:	5d                   	pop    %ebp
  802254:	c3                   	ret    

00802255 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  802255:	55                   	push   %ebp
  802256:	89 e5                	mov    %esp,%ebp
  802258:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80225b:	8b 45 08             	mov    0x8(%ebp),%eax
  80225e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802261:	8b 45 0c             	mov    0xc(%ebp),%eax
  802264:	8d 50 ff             	lea    -0x1(%eax),%edx
  802267:	8b 45 08             	mov    0x8(%ebp),%eax
  80226a:	01 d0                	add    %edx,%eax
  80226c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80226f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  802276:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80227a:	74 06                	je     802282 <vsnprintf+0x2d>
  80227c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802280:	7f 07                	jg     802289 <vsnprintf+0x34>
		return -E_INVAL;
  802282:	b8 03 00 00 00       	mov    $0x3,%eax
  802287:	eb 20                	jmp    8022a9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  802289:	ff 75 14             	pushl  0x14(%ebp)
  80228c:	ff 75 10             	pushl  0x10(%ebp)
  80228f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  802292:	50                   	push   %eax
  802293:	68 1f 22 80 00       	push   $0x80221f
  802298:	e8 92 fb ff ff       	call   801e2f <vprintfmt>
  80229d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8022a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8022a3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8022a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8022a9:	c9                   	leave  
  8022aa:	c3                   	ret    

008022ab <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8022ab:	55                   	push   %ebp
  8022ac:	89 e5                	mov    %esp,%ebp
  8022ae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8022b1:	8d 45 10             	lea    0x10(%ebp),%eax
  8022b4:	83 c0 04             	add    $0x4,%eax
  8022b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8022ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8022bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8022c0:	50                   	push   %eax
  8022c1:	ff 75 0c             	pushl  0xc(%ebp)
  8022c4:	ff 75 08             	pushl  0x8(%ebp)
  8022c7:	e8 89 ff ff ff       	call   802255 <vsnprintf>
  8022cc:	83 c4 10             	add    $0x10,%esp
  8022cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8022d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8022d5:	c9                   	leave  
  8022d6:	c3                   	ret    

008022d7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8022d7:	55                   	push   %ebp
  8022d8:	89 e5                	mov    %esp,%ebp
  8022da:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8022dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8022e4:	eb 06                	jmp    8022ec <strlen+0x15>
		n++;
  8022e6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8022e9:	ff 45 08             	incl   0x8(%ebp)
  8022ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ef:	8a 00                	mov    (%eax),%al
  8022f1:	84 c0                	test   %al,%al
  8022f3:	75 f1                	jne    8022e6 <strlen+0xf>
		n++;
	return n;
  8022f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8022f8:	c9                   	leave  
  8022f9:	c3                   	ret    

008022fa <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8022fa:	55                   	push   %ebp
  8022fb:	89 e5                	mov    %esp,%ebp
  8022fd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802300:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802307:	eb 09                	jmp    802312 <strnlen+0x18>
		n++;
  802309:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80230c:	ff 45 08             	incl   0x8(%ebp)
  80230f:	ff 4d 0c             	decl   0xc(%ebp)
  802312:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802316:	74 09                	je     802321 <strnlen+0x27>
  802318:	8b 45 08             	mov    0x8(%ebp),%eax
  80231b:	8a 00                	mov    (%eax),%al
  80231d:	84 c0                	test   %al,%al
  80231f:	75 e8                	jne    802309 <strnlen+0xf>
		n++;
	return n;
  802321:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802324:	c9                   	leave  
  802325:	c3                   	ret    

00802326 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  802326:	55                   	push   %ebp
  802327:	89 e5                	mov    %esp,%ebp
  802329:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80232c:	8b 45 08             	mov    0x8(%ebp),%eax
  80232f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802332:	90                   	nop
  802333:	8b 45 08             	mov    0x8(%ebp),%eax
  802336:	8d 50 01             	lea    0x1(%eax),%edx
  802339:	89 55 08             	mov    %edx,0x8(%ebp)
  80233c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80233f:	8d 4a 01             	lea    0x1(%edx),%ecx
  802342:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802345:	8a 12                	mov    (%edx),%dl
  802347:	88 10                	mov    %dl,(%eax)
  802349:	8a 00                	mov    (%eax),%al
  80234b:	84 c0                	test   %al,%al
  80234d:	75 e4                	jne    802333 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80234f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802352:	c9                   	leave  
  802353:	c3                   	ret    

00802354 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  802354:	55                   	push   %ebp
  802355:	89 e5                	mov    %esp,%ebp
  802357:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80235a:	8b 45 08             	mov    0x8(%ebp),%eax
  80235d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802360:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802367:	eb 1f                	jmp    802388 <strncpy+0x34>
		*dst++ = *src;
  802369:	8b 45 08             	mov    0x8(%ebp),%eax
  80236c:	8d 50 01             	lea    0x1(%eax),%edx
  80236f:	89 55 08             	mov    %edx,0x8(%ebp)
  802372:	8b 55 0c             	mov    0xc(%ebp),%edx
  802375:	8a 12                	mov    (%edx),%dl
  802377:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  802379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80237c:	8a 00                	mov    (%eax),%al
  80237e:	84 c0                	test   %al,%al
  802380:	74 03                	je     802385 <strncpy+0x31>
			src++;
  802382:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  802385:	ff 45 fc             	incl   -0x4(%ebp)
  802388:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80238b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80238e:	72 d9                	jb     802369 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  802390:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802393:	c9                   	leave  
  802394:	c3                   	ret    

00802395 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  802395:	55                   	push   %ebp
  802396:	89 e5                	mov    %esp,%ebp
  802398:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80239b:	8b 45 08             	mov    0x8(%ebp),%eax
  80239e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8023a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023a5:	74 30                	je     8023d7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8023a7:	eb 16                	jmp    8023bf <strlcpy+0x2a>
			*dst++ = *src++;
  8023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ac:	8d 50 01             	lea    0x1(%eax),%edx
  8023af:	89 55 08             	mov    %edx,0x8(%ebp)
  8023b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8023b8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8023bb:	8a 12                	mov    (%edx),%dl
  8023bd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8023bf:	ff 4d 10             	decl   0x10(%ebp)
  8023c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023c6:	74 09                	je     8023d1 <strlcpy+0x3c>
  8023c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023cb:	8a 00                	mov    (%eax),%al
  8023cd:	84 c0                	test   %al,%al
  8023cf:	75 d8                	jne    8023a9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8023d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8023d7:	8b 55 08             	mov    0x8(%ebp),%edx
  8023da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023dd:	29 c2                	sub    %eax,%edx
  8023df:	89 d0                	mov    %edx,%eax
}
  8023e1:	c9                   	leave  
  8023e2:	c3                   	ret    

008023e3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8023e3:	55                   	push   %ebp
  8023e4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8023e6:	eb 06                	jmp    8023ee <strcmp+0xb>
		p++, q++;
  8023e8:	ff 45 08             	incl   0x8(%ebp)
  8023eb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8023ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f1:	8a 00                	mov    (%eax),%al
  8023f3:	84 c0                	test   %al,%al
  8023f5:	74 0e                	je     802405 <strcmp+0x22>
  8023f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023fa:	8a 10                	mov    (%eax),%dl
  8023fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023ff:	8a 00                	mov    (%eax),%al
  802401:	38 c2                	cmp    %al,%dl
  802403:	74 e3                	je     8023e8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802405:	8b 45 08             	mov    0x8(%ebp),%eax
  802408:	8a 00                	mov    (%eax),%al
  80240a:	0f b6 d0             	movzbl %al,%edx
  80240d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802410:	8a 00                	mov    (%eax),%al
  802412:	0f b6 c0             	movzbl %al,%eax
  802415:	29 c2                	sub    %eax,%edx
  802417:	89 d0                	mov    %edx,%eax
}
  802419:	5d                   	pop    %ebp
  80241a:	c3                   	ret    

0080241b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80241b:	55                   	push   %ebp
  80241c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80241e:	eb 09                	jmp    802429 <strncmp+0xe>
		n--, p++, q++;
  802420:	ff 4d 10             	decl   0x10(%ebp)
  802423:	ff 45 08             	incl   0x8(%ebp)
  802426:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  802429:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80242d:	74 17                	je     802446 <strncmp+0x2b>
  80242f:	8b 45 08             	mov    0x8(%ebp),%eax
  802432:	8a 00                	mov    (%eax),%al
  802434:	84 c0                	test   %al,%al
  802436:	74 0e                	je     802446 <strncmp+0x2b>
  802438:	8b 45 08             	mov    0x8(%ebp),%eax
  80243b:	8a 10                	mov    (%eax),%dl
  80243d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802440:	8a 00                	mov    (%eax),%al
  802442:	38 c2                	cmp    %al,%dl
  802444:	74 da                	je     802420 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802446:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80244a:	75 07                	jne    802453 <strncmp+0x38>
		return 0;
  80244c:	b8 00 00 00 00       	mov    $0x0,%eax
  802451:	eb 14                	jmp    802467 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802453:	8b 45 08             	mov    0x8(%ebp),%eax
  802456:	8a 00                	mov    (%eax),%al
  802458:	0f b6 d0             	movzbl %al,%edx
  80245b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80245e:	8a 00                	mov    (%eax),%al
  802460:	0f b6 c0             	movzbl %al,%eax
  802463:	29 c2                	sub    %eax,%edx
  802465:	89 d0                	mov    %edx,%eax
}
  802467:	5d                   	pop    %ebp
  802468:	c3                   	ret    

00802469 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802469:	55                   	push   %ebp
  80246a:	89 e5                	mov    %esp,%ebp
  80246c:	83 ec 04             	sub    $0x4,%esp
  80246f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802472:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802475:	eb 12                	jmp    802489 <strchr+0x20>
		if (*s == c)
  802477:	8b 45 08             	mov    0x8(%ebp),%eax
  80247a:	8a 00                	mov    (%eax),%al
  80247c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80247f:	75 05                	jne    802486 <strchr+0x1d>
			return (char *) s;
  802481:	8b 45 08             	mov    0x8(%ebp),%eax
  802484:	eb 11                	jmp    802497 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802486:	ff 45 08             	incl   0x8(%ebp)
  802489:	8b 45 08             	mov    0x8(%ebp),%eax
  80248c:	8a 00                	mov    (%eax),%al
  80248e:	84 c0                	test   %al,%al
  802490:	75 e5                	jne    802477 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802492:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802497:	c9                   	leave  
  802498:	c3                   	ret    

00802499 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802499:	55                   	push   %ebp
  80249a:	89 e5                	mov    %esp,%ebp
  80249c:	83 ec 04             	sub    $0x4,%esp
  80249f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024a2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8024a5:	eb 0d                	jmp    8024b4 <strfind+0x1b>
		if (*s == c)
  8024a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024aa:	8a 00                	mov    (%eax),%al
  8024ac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8024af:	74 0e                	je     8024bf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8024b1:	ff 45 08             	incl   0x8(%ebp)
  8024b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b7:	8a 00                	mov    (%eax),%al
  8024b9:	84 c0                	test   %al,%al
  8024bb:	75 ea                	jne    8024a7 <strfind+0xe>
  8024bd:	eb 01                	jmp    8024c0 <strfind+0x27>
		if (*s == c)
			break;
  8024bf:	90                   	nop
	return (char *) s;
  8024c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024c3:	c9                   	leave  
  8024c4:	c3                   	ret    

008024c5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8024c5:	55                   	push   %ebp
  8024c6:	89 e5                	mov    %esp,%ebp
  8024c8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8024cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8024d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8024d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8024d7:	eb 0e                	jmp    8024e7 <memset+0x22>
		*p++ = c;
  8024d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024dc:	8d 50 01             	lea    0x1(%eax),%edx
  8024df:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024e5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8024e7:	ff 4d f8             	decl   -0x8(%ebp)
  8024ea:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8024ee:	79 e9                	jns    8024d9 <memset+0x14>
		*p++ = c;

	return v;
  8024f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024f3:	c9                   	leave  
  8024f4:	c3                   	ret    

008024f5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8024f5:	55                   	push   %ebp
  8024f6:	89 e5                	mov    %esp,%ebp
  8024f8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8024fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802501:	8b 45 08             	mov    0x8(%ebp),%eax
  802504:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802507:	eb 16                	jmp    80251f <memcpy+0x2a>
		*d++ = *s++;
  802509:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80250c:	8d 50 01             	lea    0x1(%eax),%edx
  80250f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802512:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802515:	8d 4a 01             	lea    0x1(%edx),%ecx
  802518:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80251b:	8a 12                	mov    (%edx),%dl
  80251d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80251f:	8b 45 10             	mov    0x10(%ebp),%eax
  802522:	8d 50 ff             	lea    -0x1(%eax),%edx
  802525:	89 55 10             	mov    %edx,0x10(%ebp)
  802528:	85 c0                	test   %eax,%eax
  80252a:	75 dd                	jne    802509 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80252c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80252f:	c9                   	leave  
  802530:	c3                   	ret    

00802531 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802531:	55                   	push   %ebp
  802532:	89 e5                	mov    %esp,%ebp
  802534:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  802537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80253a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80253d:	8b 45 08             	mov    0x8(%ebp),%eax
  802540:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802543:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802546:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802549:	73 50                	jae    80259b <memmove+0x6a>
  80254b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80254e:	8b 45 10             	mov    0x10(%ebp),%eax
  802551:	01 d0                	add    %edx,%eax
  802553:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802556:	76 43                	jbe    80259b <memmove+0x6a>
		s += n;
  802558:	8b 45 10             	mov    0x10(%ebp),%eax
  80255b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80255e:	8b 45 10             	mov    0x10(%ebp),%eax
  802561:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802564:	eb 10                	jmp    802576 <memmove+0x45>
			*--d = *--s;
  802566:	ff 4d f8             	decl   -0x8(%ebp)
  802569:	ff 4d fc             	decl   -0x4(%ebp)
  80256c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80256f:	8a 10                	mov    (%eax),%dl
  802571:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802574:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802576:	8b 45 10             	mov    0x10(%ebp),%eax
  802579:	8d 50 ff             	lea    -0x1(%eax),%edx
  80257c:	89 55 10             	mov    %edx,0x10(%ebp)
  80257f:	85 c0                	test   %eax,%eax
  802581:	75 e3                	jne    802566 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802583:	eb 23                	jmp    8025a8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802585:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802588:	8d 50 01             	lea    0x1(%eax),%edx
  80258b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80258e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802591:	8d 4a 01             	lea    0x1(%edx),%ecx
  802594:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802597:	8a 12                	mov    (%edx),%dl
  802599:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80259b:	8b 45 10             	mov    0x10(%ebp),%eax
  80259e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8025a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8025a4:	85 c0                	test   %eax,%eax
  8025a6:	75 dd                	jne    802585 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8025a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8025ab:	c9                   	leave  
  8025ac:	c3                   	ret    

008025ad <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8025ad:	55                   	push   %ebp
  8025ae:	89 e5                	mov    %esp,%ebp
  8025b0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8025b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8025b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025bc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8025bf:	eb 2a                	jmp    8025eb <memcmp+0x3e>
		if (*s1 != *s2)
  8025c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025c4:	8a 10                	mov    (%eax),%dl
  8025c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025c9:	8a 00                	mov    (%eax),%al
  8025cb:	38 c2                	cmp    %al,%dl
  8025cd:	74 16                	je     8025e5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8025cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8025d2:	8a 00                	mov    (%eax),%al
  8025d4:	0f b6 d0             	movzbl %al,%edx
  8025d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025da:	8a 00                	mov    (%eax),%al
  8025dc:	0f b6 c0             	movzbl %al,%eax
  8025df:	29 c2                	sub    %eax,%edx
  8025e1:	89 d0                	mov    %edx,%eax
  8025e3:	eb 18                	jmp    8025fd <memcmp+0x50>
		s1++, s2++;
  8025e5:	ff 45 fc             	incl   -0x4(%ebp)
  8025e8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8025eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8025ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8025f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8025f4:	85 c0                	test   %eax,%eax
  8025f6:	75 c9                	jne    8025c1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8025f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025fd:	c9                   	leave  
  8025fe:	c3                   	ret    

008025ff <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8025ff:	55                   	push   %ebp
  802600:	89 e5                	mov    %esp,%ebp
  802602:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802605:	8b 55 08             	mov    0x8(%ebp),%edx
  802608:	8b 45 10             	mov    0x10(%ebp),%eax
  80260b:	01 d0                	add    %edx,%eax
  80260d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802610:	eb 15                	jmp    802627 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802612:	8b 45 08             	mov    0x8(%ebp),%eax
  802615:	8a 00                	mov    (%eax),%al
  802617:	0f b6 d0             	movzbl %al,%edx
  80261a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80261d:	0f b6 c0             	movzbl %al,%eax
  802620:	39 c2                	cmp    %eax,%edx
  802622:	74 0d                	je     802631 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802624:	ff 45 08             	incl   0x8(%ebp)
  802627:	8b 45 08             	mov    0x8(%ebp),%eax
  80262a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80262d:	72 e3                	jb     802612 <memfind+0x13>
  80262f:	eb 01                	jmp    802632 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802631:	90                   	nop
	return (void *) s;
  802632:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802635:	c9                   	leave  
  802636:	c3                   	ret    

00802637 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802637:	55                   	push   %ebp
  802638:	89 e5                	mov    %esp,%ebp
  80263a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80263d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802644:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80264b:	eb 03                	jmp    802650 <strtol+0x19>
		s++;
  80264d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802650:	8b 45 08             	mov    0x8(%ebp),%eax
  802653:	8a 00                	mov    (%eax),%al
  802655:	3c 20                	cmp    $0x20,%al
  802657:	74 f4                	je     80264d <strtol+0x16>
  802659:	8b 45 08             	mov    0x8(%ebp),%eax
  80265c:	8a 00                	mov    (%eax),%al
  80265e:	3c 09                	cmp    $0x9,%al
  802660:	74 eb                	je     80264d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802662:	8b 45 08             	mov    0x8(%ebp),%eax
  802665:	8a 00                	mov    (%eax),%al
  802667:	3c 2b                	cmp    $0x2b,%al
  802669:	75 05                	jne    802670 <strtol+0x39>
		s++;
  80266b:	ff 45 08             	incl   0x8(%ebp)
  80266e:	eb 13                	jmp    802683 <strtol+0x4c>
	else if (*s == '-')
  802670:	8b 45 08             	mov    0x8(%ebp),%eax
  802673:	8a 00                	mov    (%eax),%al
  802675:	3c 2d                	cmp    $0x2d,%al
  802677:	75 0a                	jne    802683 <strtol+0x4c>
		s++, neg = 1;
  802679:	ff 45 08             	incl   0x8(%ebp)
  80267c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802683:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802687:	74 06                	je     80268f <strtol+0x58>
  802689:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80268d:	75 20                	jne    8026af <strtol+0x78>
  80268f:	8b 45 08             	mov    0x8(%ebp),%eax
  802692:	8a 00                	mov    (%eax),%al
  802694:	3c 30                	cmp    $0x30,%al
  802696:	75 17                	jne    8026af <strtol+0x78>
  802698:	8b 45 08             	mov    0x8(%ebp),%eax
  80269b:	40                   	inc    %eax
  80269c:	8a 00                	mov    (%eax),%al
  80269e:	3c 78                	cmp    $0x78,%al
  8026a0:	75 0d                	jne    8026af <strtol+0x78>
		s += 2, base = 16;
  8026a2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8026a6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8026ad:	eb 28                	jmp    8026d7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8026af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026b3:	75 15                	jne    8026ca <strtol+0x93>
  8026b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8026b8:	8a 00                	mov    (%eax),%al
  8026ba:	3c 30                	cmp    $0x30,%al
  8026bc:	75 0c                	jne    8026ca <strtol+0x93>
		s++, base = 8;
  8026be:	ff 45 08             	incl   0x8(%ebp)
  8026c1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8026c8:	eb 0d                	jmp    8026d7 <strtol+0xa0>
	else if (base == 0)
  8026ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8026ce:	75 07                	jne    8026d7 <strtol+0xa0>
		base = 10;
  8026d0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8026d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8026da:	8a 00                	mov    (%eax),%al
  8026dc:	3c 2f                	cmp    $0x2f,%al
  8026de:	7e 19                	jle    8026f9 <strtol+0xc2>
  8026e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8026e3:	8a 00                	mov    (%eax),%al
  8026e5:	3c 39                	cmp    $0x39,%al
  8026e7:	7f 10                	jg     8026f9 <strtol+0xc2>
			dig = *s - '0';
  8026e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ec:	8a 00                	mov    (%eax),%al
  8026ee:	0f be c0             	movsbl %al,%eax
  8026f1:	83 e8 30             	sub    $0x30,%eax
  8026f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8026f7:	eb 42                	jmp    80273b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8026f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8026fc:	8a 00                	mov    (%eax),%al
  8026fe:	3c 60                	cmp    $0x60,%al
  802700:	7e 19                	jle    80271b <strtol+0xe4>
  802702:	8b 45 08             	mov    0x8(%ebp),%eax
  802705:	8a 00                	mov    (%eax),%al
  802707:	3c 7a                	cmp    $0x7a,%al
  802709:	7f 10                	jg     80271b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80270b:	8b 45 08             	mov    0x8(%ebp),%eax
  80270e:	8a 00                	mov    (%eax),%al
  802710:	0f be c0             	movsbl %al,%eax
  802713:	83 e8 57             	sub    $0x57,%eax
  802716:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802719:	eb 20                	jmp    80273b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80271b:	8b 45 08             	mov    0x8(%ebp),%eax
  80271e:	8a 00                	mov    (%eax),%al
  802720:	3c 40                	cmp    $0x40,%al
  802722:	7e 39                	jle    80275d <strtol+0x126>
  802724:	8b 45 08             	mov    0x8(%ebp),%eax
  802727:	8a 00                	mov    (%eax),%al
  802729:	3c 5a                	cmp    $0x5a,%al
  80272b:	7f 30                	jg     80275d <strtol+0x126>
			dig = *s - 'A' + 10;
  80272d:	8b 45 08             	mov    0x8(%ebp),%eax
  802730:	8a 00                	mov    (%eax),%al
  802732:	0f be c0             	movsbl %al,%eax
  802735:	83 e8 37             	sub    $0x37,%eax
  802738:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80273b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80273e:	3b 45 10             	cmp    0x10(%ebp),%eax
  802741:	7d 19                	jge    80275c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802743:	ff 45 08             	incl   0x8(%ebp)
  802746:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802749:	0f af 45 10          	imul   0x10(%ebp),%eax
  80274d:	89 c2                	mov    %eax,%edx
  80274f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802752:	01 d0                	add    %edx,%eax
  802754:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802757:	e9 7b ff ff ff       	jmp    8026d7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80275c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80275d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802761:	74 08                	je     80276b <strtol+0x134>
		*endptr = (char *) s;
  802763:	8b 45 0c             	mov    0xc(%ebp),%eax
  802766:	8b 55 08             	mov    0x8(%ebp),%edx
  802769:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80276b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80276f:	74 07                	je     802778 <strtol+0x141>
  802771:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802774:	f7 d8                	neg    %eax
  802776:	eb 03                	jmp    80277b <strtol+0x144>
  802778:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80277b:	c9                   	leave  
  80277c:	c3                   	ret    

0080277d <ltostr>:

void
ltostr(long value, char *str)
{
  80277d:	55                   	push   %ebp
  80277e:	89 e5                	mov    %esp,%ebp
  802780:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802783:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80278a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802791:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802795:	79 13                	jns    8027aa <ltostr+0x2d>
	{
		neg = 1;
  802797:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80279e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027a1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8027a4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8027a7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8027aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8027ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8027b2:	99                   	cltd   
  8027b3:	f7 f9                	idiv   %ecx
  8027b5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8027b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027bb:	8d 50 01             	lea    0x1(%eax),%edx
  8027be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8027c1:	89 c2                	mov    %eax,%edx
  8027c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027c6:	01 d0                	add    %edx,%eax
  8027c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8027cb:	83 c2 30             	add    $0x30,%edx
  8027ce:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8027d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8027d3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8027d8:	f7 e9                	imul   %ecx
  8027da:	c1 fa 02             	sar    $0x2,%edx
  8027dd:	89 c8                	mov    %ecx,%eax
  8027df:	c1 f8 1f             	sar    $0x1f,%eax
  8027e2:	29 c2                	sub    %eax,%edx
  8027e4:	89 d0                	mov    %edx,%eax
  8027e6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8027e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8027ec:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8027f1:	f7 e9                	imul   %ecx
  8027f3:	c1 fa 02             	sar    $0x2,%edx
  8027f6:	89 c8                	mov    %ecx,%eax
  8027f8:	c1 f8 1f             	sar    $0x1f,%eax
  8027fb:	29 c2                	sub    %eax,%edx
  8027fd:	89 d0                	mov    %edx,%eax
  8027ff:	c1 e0 02             	shl    $0x2,%eax
  802802:	01 d0                	add    %edx,%eax
  802804:	01 c0                	add    %eax,%eax
  802806:	29 c1                	sub    %eax,%ecx
  802808:	89 ca                	mov    %ecx,%edx
  80280a:	85 d2                	test   %edx,%edx
  80280c:	75 9c                	jne    8027aa <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80280e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802815:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802818:	48                   	dec    %eax
  802819:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80281c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802820:	74 3d                	je     80285f <ltostr+0xe2>
		start = 1 ;
  802822:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802829:	eb 34                	jmp    80285f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80282b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80282e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802831:	01 d0                	add    %edx,%eax
  802833:	8a 00                	mov    (%eax),%al
  802835:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802838:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80283b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80283e:	01 c2                	add    %eax,%edx
  802840:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802843:	8b 45 0c             	mov    0xc(%ebp),%eax
  802846:	01 c8                	add    %ecx,%eax
  802848:	8a 00                	mov    (%eax),%al
  80284a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80284c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80284f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802852:	01 c2                	add    %eax,%edx
  802854:	8a 45 eb             	mov    -0x15(%ebp),%al
  802857:	88 02                	mov    %al,(%edx)
		start++ ;
  802859:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80285c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80285f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802862:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802865:	7c c4                	jl     80282b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802867:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80286a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80286d:	01 d0                	add    %edx,%eax
  80286f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802872:	90                   	nop
  802873:	c9                   	leave  
  802874:	c3                   	ret    

00802875 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802875:	55                   	push   %ebp
  802876:	89 e5                	mov    %esp,%ebp
  802878:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80287b:	ff 75 08             	pushl  0x8(%ebp)
  80287e:	e8 54 fa ff ff       	call   8022d7 <strlen>
  802883:	83 c4 04             	add    $0x4,%esp
  802886:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802889:	ff 75 0c             	pushl  0xc(%ebp)
  80288c:	e8 46 fa ff ff       	call   8022d7 <strlen>
  802891:	83 c4 04             	add    $0x4,%esp
  802894:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802897:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80289e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8028a5:	eb 17                	jmp    8028be <strcconcat+0x49>
		final[s] = str1[s] ;
  8028a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8028aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8028ad:	01 c2                	add    %eax,%edx
  8028af:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8028b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8028b5:	01 c8                	add    %ecx,%eax
  8028b7:	8a 00                	mov    (%eax),%al
  8028b9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8028bb:	ff 45 fc             	incl   -0x4(%ebp)
  8028be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8028c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8028c4:	7c e1                	jl     8028a7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8028c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8028cd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8028d4:	eb 1f                	jmp    8028f5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8028d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8028d9:	8d 50 01             	lea    0x1(%eax),%edx
  8028dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8028df:	89 c2                	mov    %eax,%edx
  8028e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8028e4:	01 c2                	add    %eax,%edx
  8028e6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8028e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8028ec:	01 c8                	add    %ecx,%eax
  8028ee:	8a 00                	mov    (%eax),%al
  8028f0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8028f2:	ff 45 f8             	incl   -0x8(%ebp)
  8028f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8028f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8028fb:	7c d9                	jl     8028d6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8028fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802900:	8b 45 10             	mov    0x10(%ebp),%eax
  802903:	01 d0                	add    %edx,%eax
  802905:	c6 00 00             	movb   $0x0,(%eax)
}
  802908:	90                   	nop
  802909:	c9                   	leave  
  80290a:	c3                   	ret    

0080290b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80290b:	55                   	push   %ebp
  80290c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80290e:	8b 45 14             	mov    0x14(%ebp),%eax
  802911:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802917:	8b 45 14             	mov    0x14(%ebp),%eax
  80291a:	8b 00                	mov    (%eax),%eax
  80291c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802923:	8b 45 10             	mov    0x10(%ebp),%eax
  802926:	01 d0                	add    %edx,%eax
  802928:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80292e:	eb 0c                	jmp    80293c <strsplit+0x31>
			*string++ = 0;
  802930:	8b 45 08             	mov    0x8(%ebp),%eax
  802933:	8d 50 01             	lea    0x1(%eax),%edx
  802936:	89 55 08             	mov    %edx,0x8(%ebp)
  802939:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80293c:	8b 45 08             	mov    0x8(%ebp),%eax
  80293f:	8a 00                	mov    (%eax),%al
  802941:	84 c0                	test   %al,%al
  802943:	74 18                	je     80295d <strsplit+0x52>
  802945:	8b 45 08             	mov    0x8(%ebp),%eax
  802948:	8a 00                	mov    (%eax),%al
  80294a:	0f be c0             	movsbl %al,%eax
  80294d:	50                   	push   %eax
  80294e:	ff 75 0c             	pushl  0xc(%ebp)
  802951:	e8 13 fb ff ff       	call   802469 <strchr>
  802956:	83 c4 08             	add    $0x8,%esp
  802959:	85 c0                	test   %eax,%eax
  80295b:	75 d3                	jne    802930 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80295d:	8b 45 08             	mov    0x8(%ebp),%eax
  802960:	8a 00                	mov    (%eax),%al
  802962:	84 c0                	test   %al,%al
  802964:	74 5a                	je     8029c0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802966:	8b 45 14             	mov    0x14(%ebp),%eax
  802969:	8b 00                	mov    (%eax),%eax
  80296b:	83 f8 0f             	cmp    $0xf,%eax
  80296e:	75 07                	jne    802977 <strsplit+0x6c>
		{
			return 0;
  802970:	b8 00 00 00 00       	mov    $0x0,%eax
  802975:	eb 66                	jmp    8029dd <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802977:	8b 45 14             	mov    0x14(%ebp),%eax
  80297a:	8b 00                	mov    (%eax),%eax
  80297c:	8d 48 01             	lea    0x1(%eax),%ecx
  80297f:	8b 55 14             	mov    0x14(%ebp),%edx
  802982:	89 0a                	mov    %ecx,(%edx)
  802984:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80298b:	8b 45 10             	mov    0x10(%ebp),%eax
  80298e:	01 c2                	add    %eax,%edx
  802990:	8b 45 08             	mov    0x8(%ebp),%eax
  802993:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802995:	eb 03                	jmp    80299a <strsplit+0x8f>
			string++;
  802997:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80299a:	8b 45 08             	mov    0x8(%ebp),%eax
  80299d:	8a 00                	mov    (%eax),%al
  80299f:	84 c0                	test   %al,%al
  8029a1:	74 8b                	je     80292e <strsplit+0x23>
  8029a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8029a6:	8a 00                	mov    (%eax),%al
  8029a8:	0f be c0             	movsbl %al,%eax
  8029ab:	50                   	push   %eax
  8029ac:	ff 75 0c             	pushl  0xc(%ebp)
  8029af:	e8 b5 fa ff ff       	call   802469 <strchr>
  8029b4:	83 c4 08             	add    $0x8,%esp
  8029b7:	85 c0                	test   %eax,%eax
  8029b9:	74 dc                	je     802997 <strsplit+0x8c>
			string++;
	}
  8029bb:	e9 6e ff ff ff       	jmp    80292e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8029c0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8029c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8029c4:	8b 00                	mov    (%eax),%eax
  8029c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8029cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8029d0:	01 d0                	add    %edx,%eax
  8029d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8029d8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8029dd:	c9                   	leave  
  8029de:	c3                   	ret    

008029df <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  8029df:	55                   	push   %ebp
  8029e0:	89 e5                	mov    %esp,%ebp
  8029e2:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8029e5:	a1 04 40 80 00       	mov    0x804004,%eax
  8029ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8029ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  8029f4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8029fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  802a02:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  802a09:	e9 f9 00 00 00       	jmp    802b07 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  802a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a11:	05 00 00 00 80       	add    $0x80000000,%eax
  802a16:	c1 e8 0c             	shr    $0xc,%eax
  802a19:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802a20:	85 c0                	test   %eax,%eax
  802a22:	75 1c                	jne    802a40 <nextFitAlgo+0x61>
  802a24:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  802a28:	74 16                	je     802a40 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  802a2a:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  802a31:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  802a38:	ff 4d e0             	decl   -0x20(%ebp)
  802a3b:	e9 90 00 00 00       	jmp    802ad0 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  802a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a43:	05 00 00 00 80       	add    $0x80000000,%eax
  802a48:	c1 e8 0c             	shr    $0xc,%eax
  802a4b:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802a52:	85 c0                	test   %eax,%eax
  802a54:	75 26                	jne    802a7c <nextFitAlgo+0x9d>
  802a56:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  802a5a:	75 20                	jne    802a7c <nextFitAlgo+0x9d>
			flag = 1;
  802a5c:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  802a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a66:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  802a69:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  802a70:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  802a77:	ff 4d e0             	decl   -0x20(%ebp)
  802a7a:	eb 54                	jmp    802ad0 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  802a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a7f:	3b 45 08             	cmp    0x8(%ebp),%eax
  802a82:	72 11                	jb     802a95 <nextFitAlgo+0xb6>
				startAdd = tmp;
  802a84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a87:	a3 04 40 80 00       	mov    %eax,0x804004
				found = 1;
  802a8c:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  802a93:	eb 7c                	jmp    802b11 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  802a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a98:	05 00 00 00 80       	add    $0x80000000,%eax
  802a9d:	c1 e8 0c             	shr    $0xc,%eax
  802aa0:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802aa7:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  802aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802aad:	05 00 00 00 80       	add    $0x80000000,%eax
  802ab2:	c1 e8 0c             	shr    $0xc,%eax
  802ab5:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802abc:	c1 e0 0c             	shl    $0xc,%eax
  802abf:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  802ac2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802ac9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  802ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802ad3:	3b 45 08             	cmp    0x8(%ebp),%eax
  802ad6:	72 11                	jb     802ae9 <nextFitAlgo+0x10a>
			startAdd = tmp;
  802ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802adb:	a3 04 40 80 00       	mov    %eax,0x804004
			found = 1;
  802ae0:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  802ae7:	eb 28                	jmp    802b11 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  802ae9:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  802af0:	76 15                	jbe    802b07 <nextFitAlgo+0x128>
			flag = newSize = 0;
  802af2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802af9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  802b00:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  802b07:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  802b0b:	0f 85 fd fe ff ff    	jne    802a0e <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  802b11:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802b15:	75 1a                	jne    802b31 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  802b17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b1a:	3b 45 08             	cmp    0x8(%ebp),%eax
  802b1d:	73 0a                	jae    802b29 <nextFitAlgo+0x14a>
  802b1f:	b8 00 00 00 00       	mov    $0x0,%eax
  802b24:	e9 99 00 00 00       	jmp    802bc2 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  802b29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802b2c:	a3 04 40 80 00       	mov    %eax,0x804004
	}

	uint32 returnHolder = startAdd;
  802b31:	a1 04 40 80 00       	mov    0x804004,%eax
  802b36:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  802b39:	a1 04 40 80 00       	mov    0x804004,%eax
  802b3e:	05 00 00 00 80       	add    $0x80000000,%eax
  802b43:	c1 e8 0c             	shr    $0xc,%eax
  802b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  802b49:	8b 45 08             	mov    0x8(%ebp),%eax
  802b4c:	c1 e8 0c             	shr    $0xc,%eax
  802b4f:	89 c2                	mov    %eax,%edx
  802b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802b54:	89 14 85 40 40 80 00 	mov    %edx,0x804040(,%eax,4)
	sys_allocateMem(startAdd, size);
  802b5b:	a1 04 40 80 00       	mov    0x804004,%eax
  802b60:	83 ec 08             	sub    $0x8,%esp
  802b63:	ff 75 08             	pushl  0x8(%ebp)
  802b66:	50                   	push   %eax
  802b67:	e8 82 03 00 00       	call   802eee <sys_allocateMem>
  802b6c:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  802b6f:	a1 04 40 80 00       	mov    0x804004,%eax
  802b74:	05 00 00 00 80       	add    $0x80000000,%eax
  802b79:	c1 e8 0c             	shr    $0xc,%eax
  802b7c:	89 c2                	mov    %eax,%edx
  802b7e:	a1 04 40 80 00       	mov    0x804004,%eax
  802b83:	89 04 d5 60 40 88 00 	mov    %eax,0x884060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  802b8a:	a1 04 40 80 00       	mov    0x804004,%eax
  802b8f:	05 00 00 00 80       	add    $0x80000000,%eax
  802b94:	c1 e8 0c             	shr    $0xc,%eax
  802b97:	89 c2                	mov    %eax,%edx
  802b99:	8b 45 08             	mov    0x8(%ebp),%eax
  802b9c:	89 04 d5 64 40 88 00 	mov    %eax,0x884064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  802ba3:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  802bac:	01 d0                	add    %edx,%eax
  802bae:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  802bb3:	76 0a                	jbe    802bbf <nextFitAlgo+0x1e0>
  802bb5:	c7 05 04 40 80 00 00 	movl   $0x80000000,0x804004
  802bbc:	00 00 80 

	return (void*)returnHolder;
  802bbf:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  802bc2:	c9                   	leave  
  802bc3:	c3                   	ret    

00802bc4 <malloc>:

void* malloc(uint32 size) {
  802bc4:	55                   	push   %ebp
  802bc5:	89 e5                	mov    %esp,%ebp
  802bc7:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  802bca:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  802bd1:	8b 55 08             	mov    0x8(%ebp),%edx
  802bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802bd7:	01 d0                	add    %edx,%eax
  802bd9:	48                   	dec    %eax
  802bda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802bdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802be0:	ba 00 00 00 00       	mov    $0x0,%edx
  802be5:	f7 75 f4             	divl   -0xc(%ebp)
  802be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802beb:	29 d0                	sub    %edx,%eax
  802bed:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  802bf0:	e8 c3 06 00 00       	call   8032b8 <sys_isUHeapPlacementStrategyNEXTFIT>
  802bf5:	85 c0                	test   %eax,%eax
  802bf7:	74 10                	je     802c09 <malloc+0x45>
		return nextFitAlgo(size);
  802bf9:	83 ec 0c             	sub    $0xc,%esp
  802bfc:	ff 75 08             	pushl  0x8(%ebp)
  802bff:	e8 db fd ff ff       	call   8029df <nextFitAlgo>
  802c04:	83 c4 10             	add    $0x10,%esp
  802c07:	eb 0a                	jmp    802c13 <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  802c09:	e8 79 06 00 00       	call   803287 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  802c0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c13:	c9                   	leave  
  802c14:	c3                   	ret    

00802c15 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802c15:	55                   	push   %ebp
  802c16:	89 e5                	mov    %esp,%ebp
  802c18:	83 ec 18             	sub    $0x18,%esp
  802c1b:	8b 45 10             	mov    0x10(%ebp),%eax
  802c1e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  802c21:	83 ec 04             	sub    $0x4,%esp
  802c24:	68 10 3d 80 00       	push   $0x803d10
  802c29:	6a 7e                	push   $0x7e
  802c2b:	68 2f 3d 80 00       	push   $0x803d2f
  802c30:	e8 6c ed ff ff       	call   8019a1 <_panic>

00802c35 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802c35:	55                   	push   %ebp
  802c36:	89 e5                	mov    %esp,%ebp
  802c38:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  802c3b:	83 ec 04             	sub    $0x4,%esp
  802c3e:	68 3b 3d 80 00       	push   $0x803d3b
  802c43:	68 84 00 00 00       	push   $0x84
  802c48:	68 2f 3d 80 00       	push   $0x803d2f
  802c4d:	e8 4f ed ff ff       	call   8019a1 <_panic>

00802c52 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  802c52:	55                   	push   %ebp
  802c53:	89 e5                	mov    %esp,%ebp
  802c55:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  802c58:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802c5f:	eb 61                	jmp    802cc2 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  802c61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c64:	8b 14 c5 60 40 88 00 	mov    0x884060(,%eax,8),%edx
  802c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  802c6e:	39 c2                	cmp    %eax,%edx
  802c70:	75 4d                	jne    802cbf <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  802c72:	8b 45 08             	mov    0x8(%ebp),%eax
  802c75:	05 00 00 00 80       	add    $0x80000000,%eax
  802c7a:	c1 e8 0c             	shr    $0xc,%eax
  802c7d:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  802c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c83:	8b 04 c5 64 40 88 00 	mov    0x884064(,%eax,8),%eax
  802c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  802c8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802c90:	c7 04 85 40 40 80 00 	movl   $0x0,0x804040(,%eax,4)
  802c97:	00 00 00 00 
  802c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c9e:	c7 04 c5 64 40 88 00 	movl   $0x0,0x884064(,%eax,8)
  802ca5:	00 00 00 00 
  802ca9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802cac:	8b 14 c5 64 40 88 00 	mov    0x884064(,%eax,8),%edx
  802cb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802cb6:	89 14 c5 60 40 88 00 	mov    %edx,0x884060(,%eax,8)
			break;
  802cbd:	eb 0d                	jmp    802ccc <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  802cbf:	ff 45 f0             	incl   -0x10(%ebp)
  802cc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802cc5:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  802cca:	76 95                	jbe    802c61 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  802ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  802ccf:	83 ec 08             	sub    $0x8,%esp
  802cd2:	ff 75 f4             	pushl  -0xc(%ebp)
  802cd5:	50                   	push   %eax
  802cd6:	e8 f7 01 00 00       	call   802ed2 <sys_freeMem>
  802cdb:	83 c4 10             	add    $0x10,%esp
}
  802cde:	90                   	nop
  802cdf:	c9                   	leave  
  802ce0:	c3                   	ret    

00802ce1 <sfree>:


void sfree(void* virtual_address)
{
  802ce1:	55                   	push   %ebp
  802ce2:	89 e5                	mov    %esp,%ebp
  802ce4:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  802ce7:	83 ec 04             	sub    $0x4,%esp
  802cea:	68 57 3d 80 00       	push   $0x803d57
  802cef:	68 ac 00 00 00       	push   $0xac
  802cf4:	68 2f 3d 80 00       	push   $0x803d2f
  802cf9:	e8 a3 ec ff ff       	call   8019a1 <_panic>

00802cfe <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  802cfe:	55                   	push   %ebp
  802cff:	89 e5                	mov    %esp,%ebp
  802d01:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  802d04:	83 ec 04             	sub    $0x4,%esp
  802d07:	68 74 3d 80 00       	push   $0x803d74
  802d0c:	68 c4 00 00 00       	push   $0xc4
  802d11:	68 2f 3d 80 00       	push   $0x803d2f
  802d16:	e8 86 ec ff ff       	call   8019a1 <_panic>

00802d1b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802d1b:	55                   	push   %ebp
  802d1c:	89 e5                	mov    %esp,%ebp
  802d1e:	57                   	push   %edi
  802d1f:	56                   	push   %esi
  802d20:	53                   	push   %ebx
  802d21:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802d24:	8b 45 08             	mov    0x8(%ebp),%eax
  802d27:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d2a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802d2d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802d30:	8b 7d 18             	mov    0x18(%ebp),%edi
  802d33:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802d36:	cd 30                	int    $0x30
  802d38:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802d3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802d3e:	83 c4 10             	add    $0x10,%esp
  802d41:	5b                   	pop    %ebx
  802d42:	5e                   	pop    %esi
  802d43:	5f                   	pop    %edi
  802d44:	5d                   	pop    %ebp
  802d45:	c3                   	ret    

00802d46 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802d46:	55                   	push   %ebp
  802d47:	89 e5                	mov    %esp,%ebp
  802d49:	83 ec 04             	sub    $0x4,%esp
  802d4c:	8b 45 10             	mov    0x10(%ebp),%eax
  802d4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802d52:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802d56:	8b 45 08             	mov    0x8(%ebp),%eax
  802d59:	6a 00                	push   $0x0
  802d5b:	6a 00                	push   $0x0
  802d5d:	52                   	push   %edx
  802d5e:	ff 75 0c             	pushl  0xc(%ebp)
  802d61:	50                   	push   %eax
  802d62:	6a 00                	push   $0x0
  802d64:	e8 b2 ff ff ff       	call   802d1b <syscall>
  802d69:	83 c4 18             	add    $0x18,%esp
}
  802d6c:	90                   	nop
  802d6d:	c9                   	leave  
  802d6e:	c3                   	ret    

00802d6f <sys_cgetc>:

int
sys_cgetc(void)
{
  802d6f:	55                   	push   %ebp
  802d70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802d72:	6a 00                	push   $0x0
  802d74:	6a 00                	push   $0x0
  802d76:	6a 00                	push   $0x0
  802d78:	6a 00                	push   $0x0
  802d7a:	6a 00                	push   $0x0
  802d7c:	6a 01                	push   $0x1
  802d7e:	e8 98 ff ff ff       	call   802d1b <syscall>
  802d83:	83 c4 18             	add    $0x18,%esp
}
  802d86:	c9                   	leave  
  802d87:	c3                   	ret    

00802d88 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802d88:	55                   	push   %ebp
  802d89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  802d8e:	6a 00                	push   $0x0
  802d90:	6a 00                	push   $0x0
  802d92:	6a 00                	push   $0x0
  802d94:	6a 00                	push   $0x0
  802d96:	50                   	push   %eax
  802d97:	6a 05                	push   $0x5
  802d99:	e8 7d ff ff ff       	call   802d1b <syscall>
  802d9e:	83 c4 18             	add    $0x18,%esp
}
  802da1:	c9                   	leave  
  802da2:	c3                   	ret    

00802da3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802da3:	55                   	push   %ebp
  802da4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802da6:	6a 00                	push   $0x0
  802da8:	6a 00                	push   $0x0
  802daa:	6a 00                	push   $0x0
  802dac:	6a 00                	push   $0x0
  802dae:	6a 00                	push   $0x0
  802db0:	6a 02                	push   $0x2
  802db2:	e8 64 ff ff ff       	call   802d1b <syscall>
  802db7:	83 c4 18             	add    $0x18,%esp
}
  802dba:	c9                   	leave  
  802dbb:	c3                   	ret    

00802dbc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802dbc:	55                   	push   %ebp
  802dbd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802dbf:	6a 00                	push   $0x0
  802dc1:	6a 00                	push   $0x0
  802dc3:	6a 00                	push   $0x0
  802dc5:	6a 00                	push   $0x0
  802dc7:	6a 00                	push   $0x0
  802dc9:	6a 03                	push   $0x3
  802dcb:	e8 4b ff ff ff       	call   802d1b <syscall>
  802dd0:	83 c4 18             	add    $0x18,%esp
}
  802dd3:	c9                   	leave  
  802dd4:	c3                   	ret    

00802dd5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802dd5:	55                   	push   %ebp
  802dd6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802dd8:	6a 00                	push   $0x0
  802dda:	6a 00                	push   $0x0
  802ddc:	6a 00                	push   $0x0
  802dde:	6a 00                	push   $0x0
  802de0:	6a 00                	push   $0x0
  802de2:	6a 04                	push   $0x4
  802de4:	e8 32 ff ff ff       	call   802d1b <syscall>
  802de9:	83 c4 18             	add    $0x18,%esp
}
  802dec:	c9                   	leave  
  802ded:	c3                   	ret    

00802dee <sys_env_exit>:


void sys_env_exit(void)
{
  802dee:	55                   	push   %ebp
  802def:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802df1:	6a 00                	push   $0x0
  802df3:	6a 00                	push   $0x0
  802df5:	6a 00                	push   $0x0
  802df7:	6a 00                	push   $0x0
  802df9:	6a 00                	push   $0x0
  802dfb:	6a 06                	push   $0x6
  802dfd:	e8 19 ff ff ff       	call   802d1b <syscall>
  802e02:	83 c4 18             	add    $0x18,%esp
}
  802e05:	90                   	nop
  802e06:	c9                   	leave  
  802e07:	c3                   	ret    

00802e08 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802e08:	55                   	push   %ebp
  802e09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802e0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  802e11:	6a 00                	push   $0x0
  802e13:	6a 00                	push   $0x0
  802e15:	6a 00                	push   $0x0
  802e17:	52                   	push   %edx
  802e18:	50                   	push   %eax
  802e19:	6a 07                	push   $0x7
  802e1b:	e8 fb fe ff ff       	call   802d1b <syscall>
  802e20:	83 c4 18             	add    $0x18,%esp
}
  802e23:	c9                   	leave  
  802e24:	c3                   	ret    

00802e25 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802e25:	55                   	push   %ebp
  802e26:	89 e5                	mov    %esp,%ebp
  802e28:	56                   	push   %esi
  802e29:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802e2a:	8b 75 18             	mov    0x18(%ebp),%esi
  802e2d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802e30:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802e33:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e36:	8b 45 08             	mov    0x8(%ebp),%eax
  802e39:	56                   	push   %esi
  802e3a:	53                   	push   %ebx
  802e3b:	51                   	push   %ecx
  802e3c:	52                   	push   %edx
  802e3d:	50                   	push   %eax
  802e3e:	6a 08                	push   $0x8
  802e40:	e8 d6 fe ff ff       	call   802d1b <syscall>
  802e45:	83 c4 18             	add    $0x18,%esp
}
  802e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802e4b:	5b                   	pop    %ebx
  802e4c:	5e                   	pop    %esi
  802e4d:	5d                   	pop    %ebp
  802e4e:	c3                   	ret    

00802e4f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802e4f:	55                   	push   %ebp
  802e50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802e52:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e55:	8b 45 08             	mov    0x8(%ebp),%eax
  802e58:	6a 00                	push   $0x0
  802e5a:	6a 00                	push   $0x0
  802e5c:	6a 00                	push   $0x0
  802e5e:	52                   	push   %edx
  802e5f:	50                   	push   %eax
  802e60:	6a 09                	push   $0x9
  802e62:	e8 b4 fe ff ff       	call   802d1b <syscall>
  802e67:	83 c4 18             	add    $0x18,%esp
}
  802e6a:	c9                   	leave  
  802e6b:	c3                   	ret    

00802e6c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802e6c:	55                   	push   %ebp
  802e6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802e6f:	6a 00                	push   $0x0
  802e71:	6a 00                	push   $0x0
  802e73:	6a 00                	push   $0x0
  802e75:	ff 75 0c             	pushl  0xc(%ebp)
  802e78:	ff 75 08             	pushl  0x8(%ebp)
  802e7b:	6a 0a                	push   $0xa
  802e7d:	e8 99 fe ff ff       	call   802d1b <syscall>
  802e82:	83 c4 18             	add    $0x18,%esp
}
  802e85:	c9                   	leave  
  802e86:	c3                   	ret    

00802e87 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802e87:	55                   	push   %ebp
  802e88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802e8a:	6a 00                	push   $0x0
  802e8c:	6a 00                	push   $0x0
  802e8e:	6a 00                	push   $0x0
  802e90:	6a 00                	push   $0x0
  802e92:	6a 00                	push   $0x0
  802e94:	6a 0b                	push   $0xb
  802e96:	e8 80 fe ff ff       	call   802d1b <syscall>
  802e9b:	83 c4 18             	add    $0x18,%esp
}
  802e9e:	c9                   	leave  
  802e9f:	c3                   	ret    

00802ea0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802ea0:	55                   	push   %ebp
  802ea1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802ea3:	6a 00                	push   $0x0
  802ea5:	6a 00                	push   $0x0
  802ea7:	6a 00                	push   $0x0
  802ea9:	6a 00                	push   $0x0
  802eab:	6a 00                	push   $0x0
  802ead:	6a 0c                	push   $0xc
  802eaf:	e8 67 fe ff ff       	call   802d1b <syscall>
  802eb4:	83 c4 18             	add    $0x18,%esp
}
  802eb7:	c9                   	leave  
  802eb8:	c3                   	ret    

00802eb9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802eb9:	55                   	push   %ebp
  802eba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802ebc:	6a 00                	push   $0x0
  802ebe:	6a 00                	push   $0x0
  802ec0:	6a 00                	push   $0x0
  802ec2:	6a 00                	push   $0x0
  802ec4:	6a 00                	push   $0x0
  802ec6:	6a 0d                	push   $0xd
  802ec8:	e8 4e fe ff ff       	call   802d1b <syscall>
  802ecd:	83 c4 18             	add    $0x18,%esp
}
  802ed0:	c9                   	leave  
  802ed1:	c3                   	ret    

00802ed2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802ed2:	55                   	push   %ebp
  802ed3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802ed5:	6a 00                	push   $0x0
  802ed7:	6a 00                	push   $0x0
  802ed9:	6a 00                	push   $0x0
  802edb:	ff 75 0c             	pushl  0xc(%ebp)
  802ede:	ff 75 08             	pushl  0x8(%ebp)
  802ee1:	6a 11                	push   $0x11
  802ee3:	e8 33 fe ff ff       	call   802d1b <syscall>
  802ee8:	83 c4 18             	add    $0x18,%esp
	return;
  802eeb:	90                   	nop
}
  802eec:	c9                   	leave  
  802eed:	c3                   	ret    

00802eee <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802eee:	55                   	push   %ebp
  802eef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802ef1:	6a 00                	push   $0x0
  802ef3:	6a 00                	push   $0x0
  802ef5:	6a 00                	push   $0x0
  802ef7:	ff 75 0c             	pushl  0xc(%ebp)
  802efa:	ff 75 08             	pushl  0x8(%ebp)
  802efd:	6a 12                	push   $0x12
  802eff:	e8 17 fe ff ff       	call   802d1b <syscall>
  802f04:	83 c4 18             	add    $0x18,%esp
	return ;
  802f07:	90                   	nop
}
  802f08:	c9                   	leave  
  802f09:	c3                   	ret    

00802f0a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802f0a:	55                   	push   %ebp
  802f0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802f0d:	6a 00                	push   $0x0
  802f0f:	6a 00                	push   $0x0
  802f11:	6a 00                	push   $0x0
  802f13:	6a 00                	push   $0x0
  802f15:	6a 00                	push   $0x0
  802f17:	6a 0e                	push   $0xe
  802f19:	e8 fd fd ff ff       	call   802d1b <syscall>
  802f1e:	83 c4 18             	add    $0x18,%esp
}
  802f21:	c9                   	leave  
  802f22:	c3                   	ret    

00802f23 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802f23:	55                   	push   %ebp
  802f24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802f26:	6a 00                	push   $0x0
  802f28:	6a 00                	push   $0x0
  802f2a:	6a 00                	push   $0x0
  802f2c:	6a 00                	push   $0x0
  802f2e:	ff 75 08             	pushl  0x8(%ebp)
  802f31:	6a 0f                	push   $0xf
  802f33:	e8 e3 fd ff ff       	call   802d1b <syscall>
  802f38:	83 c4 18             	add    $0x18,%esp
}
  802f3b:	c9                   	leave  
  802f3c:	c3                   	ret    

00802f3d <sys_scarce_memory>:

void sys_scarce_memory()
{
  802f3d:	55                   	push   %ebp
  802f3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802f40:	6a 00                	push   $0x0
  802f42:	6a 00                	push   $0x0
  802f44:	6a 00                	push   $0x0
  802f46:	6a 00                	push   $0x0
  802f48:	6a 00                	push   $0x0
  802f4a:	6a 10                	push   $0x10
  802f4c:	e8 ca fd ff ff       	call   802d1b <syscall>
  802f51:	83 c4 18             	add    $0x18,%esp
}
  802f54:	90                   	nop
  802f55:	c9                   	leave  
  802f56:	c3                   	ret    

00802f57 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802f57:	55                   	push   %ebp
  802f58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802f5a:	6a 00                	push   $0x0
  802f5c:	6a 00                	push   $0x0
  802f5e:	6a 00                	push   $0x0
  802f60:	6a 00                	push   $0x0
  802f62:	6a 00                	push   $0x0
  802f64:	6a 14                	push   $0x14
  802f66:	e8 b0 fd ff ff       	call   802d1b <syscall>
  802f6b:	83 c4 18             	add    $0x18,%esp
}
  802f6e:	90                   	nop
  802f6f:	c9                   	leave  
  802f70:	c3                   	ret    

00802f71 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802f71:	55                   	push   %ebp
  802f72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802f74:	6a 00                	push   $0x0
  802f76:	6a 00                	push   $0x0
  802f78:	6a 00                	push   $0x0
  802f7a:	6a 00                	push   $0x0
  802f7c:	6a 00                	push   $0x0
  802f7e:	6a 15                	push   $0x15
  802f80:	e8 96 fd ff ff       	call   802d1b <syscall>
  802f85:	83 c4 18             	add    $0x18,%esp
}
  802f88:	90                   	nop
  802f89:	c9                   	leave  
  802f8a:	c3                   	ret    

00802f8b <sys_cputc>:


void
sys_cputc(const char c)
{
  802f8b:	55                   	push   %ebp
  802f8c:	89 e5                	mov    %esp,%ebp
  802f8e:	83 ec 04             	sub    $0x4,%esp
  802f91:	8b 45 08             	mov    0x8(%ebp),%eax
  802f94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802f97:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802f9b:	6a 00                	push   $0x0
  802f9d:	6a 00                	push   $0x0
  802f9f:	6a 00                	push   $0x0
  802fa1:	6a 00                	push   $0x0
  802fa3:	50                   	push   %eax
  802fa4:	6a 16                	push   $0x16
  802fa6:	e8 70 fd ff ff       	call   802d1b <syscall>
  802fab:	83 c4 18             	add    $0x18,%esp
}
  802fae:	90                   	nop
  802faf:	c9                   	leave  
  802fb0:	c3                   	ret    

00802fb1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802fb1:	55                   	push   %ebp
  802fb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802fb4:	6a 00                	push   $0x0
  802fb6:	6a 00                	push   $0x0
  802fb8:	6a 00                	push   $0x0
  802fba:	6a 00                	push   $0x0
  802fbc:	6a 00                	push   $0x0
  802fbe:	6a 17                	push   $0x17
  802fc0:	e8 56 fd ff ff       	call   802d1b <syscall>
  802fc5:	83 c4 18             	add    $0x18,%esp
}
  802fc8:	90                   	nop
  802fc9:	c9                   	leave  
  802fca:	c3                   	ret    

00802fcb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802fcb:	55                   	push   %ebp
  802fcc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802fce:	8b 45 08             	mov    0x8(%ebp),%eax
  802fd1:	6a 00                	push   $0x0
  802fd3:	6a 00                	push   $0x0
  802fd5:	6a 00                	push   $0x0
  802fd7:	ff 75 0c             	pushl  0xc(%ebp)
  802fda:	50                   	push   %eax
  802fdb:	6a 18                	push   $0x18
  802fdd:	e8 39 fd ff ff       	call   802d1b <syscall>
  802fe2:	83 c4 18             	add    $0x18,%esp
}
  802fe5:	c9                   	leave  
  802fe6:	c3                   	ret    

00802fe7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802fe7:	55                   	push   %ebp
  802fe8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802fea:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fed:	8b 45 08             	mov    0x8(%ebp),%eax
  802ff0:	6a 00                	push   $0x0
  802ff2:	6a 00                	push   $0x0
  802ff4:	6a 00                	push   $0x0
  802ff6:	52                   	push   %edx
  802ff7:	50                   	push   %eax
  802ff8:	6a 1b                	push   $0x1b
  802ffa:	e8 1c fd ff ff       	call   802d1b <syscall>
  802fff:	83 c4 18             	add    $0x18,%esp
}
  803002:	c9                   	leave  
  803003:	c3                   	ret    

00803004 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  803004:	55                   	push   %ebp
  803005:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  803007:	8b 55 0c             	mov    0xc(%ebp),%edx
  80300a:	8b 45 08             	mov    0x8(%ebp),%eax
  80300d:	6a 00                	push   $0x0
  80300f:	6a 00                	push   $0x0
  803011:	6a 00                	push   $0x0
  803013:	52                   	push   %edx
  803014:	50                   	push   %eax
  803015:	6a 19                	push   $0x19
  803017:	e8 ff fc ff ff       	call   802d1b <syscall>
  80301c:	83 c4 18             	add    $0x18,%esp
}
  80301f:	90                   	nop
  803020:	c9                   	leave  
  803021:	c3                   	ret    

00803022 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  803022:	55                   	push   %ebp
  803023:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  803025:	8b 55 0c             	mov    0xc(%ebp),%edx
  803028:	8b 45 08             	mov    0x8(%ebp),%eax
  80302b:	6a 00                	push   $0x0
  80302d:	6a 00                	push   $0x0
  80302f:	6a 00                	push   $0x0
  803031:	52                   	push   %edx
  803032:	50                   	push   %eax
  803033:	6a 1a                	push   $0x1a
  803035:	e8 e1 fc ff ff       	call   802d1b <syscall>
  80303a:	83 c4 18             	add    $0x18,%esp
}
  80303d:	90                   	nop
  80303e:	c9                   	leave  
  80303f:	c3                   	ret    

00803040 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  803040:	55                   	push   %ebp
  803041:	89 e5                	mov    %esp,%ebp
  803043:	83 ec 04             	sub    $0x4,%esp
  803046:	8b 45 10             	mov    0x10(%ebp),%eax
  803049:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80304c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80304f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  803053:	8b 45 08             	mov    0x8(%ebp),%eax
  803056:	6a 00                	push   $0x0
  803058:	51                   	push   %ecx
  803059:	52                   	push   %edx
  80305a:	ff 75 0c             	pushl  0xc(%ebp)
  80305d:	50                   	push   %eax
  80305e:	6a 1c                	push   $0x1c
  803060:	e8 b6 fc ff ff       	call   802d1b <syscall>
  803065:	83 c4 18             	add    $0x18,%esp
}
  803068:	c9                   	leave  
  803069:	c3                   	ret    

0080306a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80306a:	55                   	push   %ebp
  80306b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80306d:	8b 55 0c             	mov    0xc(%ebp),%edx
  803070:	8b 45 08             	mov    0x8(%ebp),%eax
  803073:	6a 00                	push   $0x0
  803075:	6a 00                	push   $0x0
  803077:	6a 00                	push   $0x0
  803079:	52                   	push   %edx
  80307a:	50                   	push   %eax
  80307b:	6a 1d                	push   $0x1d
  80307d:	e8 99 fc ff ff       	call   802d1b <syscall>
  803082:	83 c4 18             	add    $0x18,%esp
}
  803085:	c9                   	leave  
  803086:	c3                   	ret    

00803087 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  803087:	55                   	push   %ebp
  803088:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80308a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80308d:	8b 55 0c             	mov    0xc(%ebp),%edx
  803090:	8b 45 08             	mov    0x8(%ebp),%eax
  803093:	6a 00                	push   $0x0
  803095:	6a 00                	push   $0x0
  803097:	51                   	push   %ecx
  803098:	52                   	push   %edx
  803099:	50                   	push   %eax
  80309a:	6a 1e                	push   $0x1e
  80309c:	e8 7a fc ff ff       	call   802d1b <syscall>
  8030a1:	83 c4 18             	add    $0x18,%esp
}
  8030a4:	c9                   	leave  
  8030a5:	c3                   	ret    

008030a6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8030a6:	55                   	push   %ebp
  8030a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8030a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8030ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8030af:	6a 00                	push   $0x0
  8030b1:	6a 00                	push   $0x0
  8030b3:	6a 00                	push   $0x0
  8030b5:	52                   	push   %edx
  8030b6:	50                   	push   %eax
  8030b7:	6a 1f                	push   $0x1f
  8030b9:	e8 5d fc ff ff       	call   802d1b <syscall>
  8030be:	83 c4 18             	add    $0x18,%esp
}
  8030c1:	c9                   	leave  
  8030c2:	c3                   	ret    

008030c3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8030c3:	55                   	push   %ebp
  8030c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8030c6:	6a 00                	push   $0x0
  8030c8:	6a 00                	push   $0x0
  8030ca:	6a 00                	push   $0x0
  8030cc:	6a 00                	push   $0x0
  8030ce:	6a 00                	push   $0x0
  8030d0:	6a 20                	push   $0x20
  8030d2:	e8 44 fc ff ff       	call   802d1b <syscall>
  8030d7:	83 c4 18             	add    $0x18,%esp
}
  8030da:	c9                   	leave  
  8030db:	c3                   	ret    

008030dc <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8030dc:	55                   	push   %ebp
  8030dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8030df:	8b 45 08             	mov    0x8(%ebp),%eax
  8030e2:	6a 00                	push   $0x0
  8030e4:	6a 00                	push   $0x0
  8030e6:	ff 75 10             	pushl  0x10(%ebp)
  8030e9:	ff 75 0c             	pushl  0xc(%ebp)
  8030ec:	50                   	push   %eax
  8030ed:	6a 21                	push   $0x21
  8030ef:	e8 27 fc ff ff       	call   802d1b <syscall>
  8030f4:	83 c4 18             	add    $0x18,%esp
}
  8030f7:	c9                   	leave  
  8030f8:	c3                   	ret    

008030f9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8030f9:	55                   	push   %ebp
  8030fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8030fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8030ff:	6a 00                	push   $0x0
  803101:	6a 00                	push   $0x0
  803103:	6a 00                	push   $0x0
  803105:	6a 00                	push   $0x0
  803107:	50                   	push   %eax
  803108:	6a 22                	push   $0x22
  80310a:	e8 0c fc ff ff       	call   802d1b <syscall>
  80310f:	83 c4 18             	add    $0x18,%esp
}
  803112:	90                   	nop
  803113:	c9                   	leave  
  803114:	c3                   	ret    

00803115 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  803115:	55                   	push   %ebp
  803116:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  803118:	8b 45 08             	mov    0x8(%ebp),%eax
  80311b:	6a 00                	push   $0x0
  80311d:	6a 00                	push   $0x0
  80311f:	6a 00                	push   $0x0
  803121:	6a 00                	push   $0x0
  803123:	50                   	push   %eax
  803124:	6a 23                	push   $0x23
  803126:	e8 f0 fb ff ff       	call   802d1b <syscall>
  80312b:	83 c4 18             	add    $0x18,%esp
}
  80312e:	90                   	nop
  80312f:	c9                   	leave  
  803130:	c3                   	ret    

00803131 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  803131:	55                   	push   %ebp
  803132:	89 e5                	mov    %esp,%ebp
  803134:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  803137:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80313a:	8d 50 04             	lea    0x4(%eax),%edx
  80313d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803140:	6a 00                	push   $0x0
  803142:	6a 00                	push   $0x0
  803144:	6a 00                	push   $0x0
  803146:	52                   	push   %edx
  803147:	50                   	push   %eax
  803148:	6a 24                	push   $0x24
  80314a:	e8 cc fb ff ff       	call   802d1b <syscall>
  80314f:	83 c4 18             	add    $0x18,%esp
	return result;
  803152:	8b 4d 08             	mov    0x8(%ebp),%ecx
  803155:	8b 45 f8             	mov    -0x8(%ebp),%eax
  803158:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80315b:	89 01                	mov    %eax,(%ecx)
  80315d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  803160:	8b 45 08             	mov    0x8(%ebp),%eax
  803163:	c9                   	leave  
  803164:	c2 04 00             	ret    $0x4

00803167 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  803167:	55                   	push   %ebp
  803168:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80316a:	6a 00                	push   $0x0
  80316c:	6a 00                	push   $0x0
  80316e:	ff 75 10             	pushl  0x10(%ebp)
  803171:	ff 75 0c             	pushl  0xc(%ebp)
  803174:	ff 75 08             	pushl  0x8(%ebp)
  803177:	6a 13                	push   $0x13
  803179:	e8 9d fb ff ff       	call   802d1b <syscall>
  80317e:	83 c4 18             	add    $0x18,%esp
	return ;
  803181:	90                   	nop
}
  803182:	c9                   	leave  
  803183:	c3                   	ret    

00803184 <sys_rcr2>:
uint32 sys_rcr2()
{
  803184:	55                   	push   %ebp
  803185:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  803187:	6a 00                	push   $0x0
  803189:	6a 00                	push   $0x0
  80318b:	6a 00                	push   $0x0
  80318d:	6a 00                	push   $0x0
  80318f:	6a 00                	push   $0x0
  803191:	6a 25                	push   $0x25
  803193:	e8 83 fb ff ff       	call   802d1b <syscall>
  803198:	83 c4 18             	add    $0x18,%esp
}
  80319b:	c9                   	leave  
  80319c:	c3                   	ret    

0080319d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80319d:	55                   	push   %ebp
  80319e:	89 e5                	mov    %esp,%ebp
  8031a0:	83 ec 04             	sub    $0x4,%esp
  8031a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8031a6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8031a9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8031ad:	6a 00                	push   $0x0
  8031af:	6a 00                	push   $0x0
  8031b1:	6a 00                	push   $0x0
  8031b3:	6a 00                	push   $0x0
  8031b5:	50                   	push   %eax
  8031b6:	6a 26                	push   $0x26
  8031b8:	e8 5e fb ff ff       	call   802d1b <syscall>
  8031bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8031c0:	90                   	nop
}
  8031c1:	c9                   	leave  
  8031c2:	c3                   	ret    

008031c3 <rsttst>:
void rsttst()
{
  8031c3:	55                   	push   %ebp
  8031c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8031c6:	6a 00                	push   $0x0
  8031c8:	6a 00                	push   $0x0
  8031ca:	6a 00                	push   $0x0
  8031cc:	6a 00                	push   $0x0
  8031ce:	6a 00                	push   $0x0
  8031d0:	6a 28                	push   $0x28
  8031d2:	e8 44 fb ff ff       	call   802d1b <syscall>
  8031d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8031da:	90                   	nop
}
  8031db:	c9                   	leave  
  8031dc:	c3                   	ret    

008031dd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8031dd:	55                   	push   %ebp
  8031de:	89 e5                	mov    %esp,%ebp
  8031e0:	83 ec 04             	sub    $0x4,%esp
  8031e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8031e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8031e9:	8b 55 18             	mov    0x18(%ebp),%edx
  8031ec:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8031f0:	52                   	push   %edx
  8031f1:	50                   	push   %eax
  8031f2:	ff 75 10             	pushl  0x10(%ebp)
  8031f5:	ff 75 0c             	pushl  0xc(%ebp)
  8031f8:	ff 75 08             	pushl  0x8(%ebp)
  8031fb:	6a 27                	push   $0x27
  8031fd:	e8 19 fb ff ff       	call   802d1b <syscall>
  803202:	83 c4 18             	add    $0x18,%esp
	return ;
  803205:	90                   	nop
}
  803206:	c9                   	leave  
  803207:	c3                   	ret    

00803208 <chktst>:
void chktst(uint32 n)
{
  803208:	55                   	push   %ebp
  803209:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80320b:	6a 00                	push   $0x0
  80320d:	6a 00                	push   $0x0
  80320f:	6a 00                	push   $0x0
  803211:	6a 00                	push   $0x0
  803213:	ff 75 08             	pushl  0x8(%ebp)
  803216:	6a 29                	push   $0x29
  803218:	e8 fe fa ff ff       	call   802d1b <syscall>
  80321d:	83 c4 18             	add    $0x18,%esp
	return ;
  803220:	90                   	nop
}
  803221:	c9                   	leave  
  803222:	c3                   	ret    

00803223 <inctst>:

void inctst()
{
  803223:	55                   	push   %ebp
  803224:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  803226:	6a 00                	push   $0x0
  803228:	6a 00                	push   $0x0
  80322a:	6a 00                	push   $0x0
  80322c:	6a 00                	push   $0x0
  80322e:	6a 00                	push   $0x0
  803230:	6a 2a                	push   $0x2a
  803232:	e8 e4 fa ff ff       	call   802d1b <syscall>
  803237:	83 c4 18             	add    $0x18,%esp
	return ;
  80323a:	90                   	nop
}
  80323b:	c9                   	leave  
  80323c:	c3                   	ret    

0080323d <gettst>:
uint32 gettst()
{
  80323d:	55                   	push   %ebp
  80323e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  803240:	6a 00                	push   $0x0
  803242:	6a 00                	push   $0x0
  803244:	6a 00                	push   $0x0
  803246:	6a 00                	push   $0x0
  803248:	6a 00                	push   $0x0
  80324a:	6a 2b                	push   $0x2b
  80324c:	e8 ca fa ff ff       	call   802d1b <syscall>
  803251:	83 c4 18             	add    $0x18,%esp
}
  803254:	c9                   	leave  
  803255:	c3                   	ret    

00803256 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  803256:	55                   	push   %ebp
  803257:	89 e5                	mov    %esp,%ebp
  803259:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80325c:	6a 00                	push   $0x0
  80325e:	6a 00                	push   $0x0
  803260:	6a 00                	push   $0x0
  803262:	6a 00                	push   $0x0
  803264:	6a 00                	push   $0x0
  803266:	6a 2c                	push   $0x2c
  803268:	e8 ae fa ff ff       	call   802d1b <syscall>
  80326d:	83 c4 18             	add    $0x18,%esp
  803270:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803273:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  803277:	75 07                	jne    803280 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  803279:	b8 01 00 00 00       	mov    $0x1,%eax
  80327e:	eb 05                	jmp    803285 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  803280:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803285:	c9                   	leave  
  803286:	c3                   	ret    

00803287 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  803287:	55                   	push   %ebp
  803288:	89 e5                	mov    %esp,%ebp
  80328a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80328d:	6a 00                	push   $0x0
  80328f:	6a 00                	push   $0x0
  803291:	6a 00                	push   $0x0
  803293:	6a 00                	push   $0x0
  803295:	6a 00                	push   $0x0
  803297:	6a 2c                	push   $0x2c
  803299:	e8 7d fa ff ff       	call   802d1b <syscall>
  80329e:	83 c4 18             	add    $0x18,%esp
  8032a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8032a4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8032a8:	75 07                	jne    8032b1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8032aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8032af:	eb 05                	jmp    8032b6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8032b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8032b6:	c9                   	leave  
  8032b7:	c3                   	ret    

008032b8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8032b8:	55                   	push   %ebp
  8032b9:	89 e5                	mov    %esp,%ebp
  8032bb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8032be:	6a 00                	push   $0x0
  8032c0:	6a 00                	push   $0x0
  8032c2:	6a 00                	push   $0x0
  8032c4:	6a 00                	push   $0x0
  8032c6:	6a 00                	push   $0x0
  8032c8:	6a 2c                	push   $0x2c
  8032ca:	e8 4c fa ff ff       	call   802d1b <syscall>
  8032cf:	83 c4 18             	add    $0x18,%esp
  8032d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8032d5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8032d9:	75 07                	jne    8032e2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8032db:	b8 01 00 00 00       	mov    $0x1,%eax
  8032e0:	eb 05                	jmp    8032e7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8032e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8032e7:	c9                   	leave  
  8032e8:	c3                   	ret    

008032e9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8032e9:	55                   	push   %ebp
  8032ea:	89 e5                	mov    %esp,%ebp
  8032ec:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8032ef:	6a 00                	push   $0x0
  8032f1:	6a 00                	push   $0x0
  8032f3:	6a 00                	push   $0x0
  8032f5:	6a 00                	push   $0x0
  8032f7:	6a 00                	push   $0x0
  8032f9:	6a 2c                	push   $0x2c
  8032fb:	e8 1b fa ff ff       	call   802d1b <syscall>
  803300:	83 c4 18             	add    $0x18,%esp
  803303:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803306:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80330a:	75 07                	jne    803313 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80330c:	b8 01 00 00 00       	mov    $0x1,%eax
  803311:	eb 05                	jmp    803318 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803313:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803318:	c9                   	leave  
  803319:	c3                   	ret    

0080331a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80331a:	55                   	push   %ebp
  80331b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80331d:	6a 00                	push   $0x0
  80331f:	6a 00                	push   $0x0
  803321:	6a 00                	push   $0x0
  803323:	6a 00                	push   $0x0
  803325:	ff 75 08             	pushl  0x8(%ebp)
  803328:	6a 2d                	push   $0x2d
  80332a:	e8 ec f9 ff ff       	call   802d1b <syscall>
  80332f:	83 c4 18             	add    $0x18,%esp
	return ;
  803332:	90                   	nop
}
  803333:	c9                   	leave  
  803334:	c3                   	ret    
  803335:	66 90                	xchg   %ax,%ax
  803337:	90                   	nop

00803338 <__udivdi3>:
  803338:	55                   	push   %ebp
  803339:	57                   	push   %edi
  80333a:	56                   	push   %esi
  80333b:	53                   	push   %ebx
  80333c:	83 ec 1c             	sub    $0x1c,%esp
  80333f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  803343:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803347:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80334b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80334f:	89 ca                	mov    %ecx,%edx
  803351:	89 f8                	mov    %edi,%eax
  803353:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803357:	85 f6                	test   %esi,%esi
  803359:	75 2d                	jne    803388 <__udivdi3+0x50>
  80335b:	39 cf                	cmp    %ecx,%edi
  80335d:	77 65                	ja     8033c4 <__udivdi3+0x8c>
  80335f:	89 fd                	mov    %edi,%ebp
  803361:	85 ff                	test   %edi,%edi
  803363:	75 0b                	jne    803370 <__udivdi3+0x38>
  803365:	b8 01 00 00 00       	mov    $0x1,%eax
  80336a:	31 d2                	xor    %edx,%edx
  80336c:	f7 f7                	div    %edi
  80336e:	89 c5                	mov    %eax,%ebp
  803370:	31 d2                	xor    %edx,%edx
  803372:	89 c8                	mov    %ecx,%eax
  803374:	f7 f5                	div    %ebp
  803376:	89 c1                	mov    %eax,%ecx
  803378:	89 d8                	mov    %ebx,%eax
  80337a:	f7 f5                	div    %ebp
  80337c:	89 cf                	mov    %ecx,%edi
  80337e:	89 fa                	mov    %edi,%edx
  803380:	83 c4 1c             	add    $0x1c,%esp
  803383:	5b                   	pop    %ebx
  803384:	5e                   	pop    %esi
  803385:	5f                   	pop    %edi
  803386:	5d                   	pop    %ebp
  803387:	c3                   	ret    
  803388:	39 ce                	cmp    %ecx,%esi
  80338a:	77 28                	ja     8033b4 <__udivdi3+0x7c>
  80338c:	0f bd fe             	bsr    %esi,%edi
  80338f:	83 f7 1f             	xor    $0x1f,%edi
  803392:	75 40                	jne    8033d4 <__udivdi3+0x9c>
  803394:	39 ce                	cmp    %ecx,%esi
  803396:	72 0a                	jb     8033a2 <__udivdi3+0x6a>
  803398:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80339c:	0f 87 9e 00 00 00    	ja     803440 <__udivdi3+0x108>
  8033a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8033a7:	89 fa                	mov    %edi,%edx
  8033a9:	83 c4 1c             	add    $0x1c,%esp
  8033ac:	5b                   	pop    %ebx
  8033ad:	5e                   	pop    %esi
  8033ae:	5f                   	pop    %edi
  8033af:	5d                   	pop    %ebp
  8033b0:	c3                   	ret    
  8033b1:	8d 76 00             	lea    0x0(%esi),%esi
  8033b4:	31 ff                	xor    %edi,%edi
  8033b6:	31 c0                	xor    %eax,%eax
  8033b8:	89 fa                	mov    %edi,%edx
  8033ba:	83 c4 1c             	add    $0x1c,%esp
  8033bd:	5b                   	pop    %ebx
  8033be:	5e                   	pop    %esi
  8033bf:	5f                   	pop    %edi
  8033c0:	5d                   	pop    %ebp
  8033c1:	c3                   	ret    
  8033c2:	66 90                	xchg   %ax,%ax
  8033c4:	89 d8                	mov    %ebx,%eax
  8033c6:	f7 f7                	div    %edi
  8033c8:	31 ff                	xor    %edi,%edi
  8033ca:	89 fa                	mov    %edi,%edx
  8033cc:	83 c4 1c             	add    $0x1c,%esp
  8033cf:	5b                   	pop    %ebx
  8033d0:	5e                   	pop    %esi
  8033d1:	5f                   	pop    %edi
  8033d2:	5d                   	pop    %ebp
  8033d3:	c3                   	ret    
  8033d4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8033d9:	89 eb                	mov    %ebp,%ebx
  8033db:	29 fb                	sub    %edi,%ebx
  8033dd:	89 f9                	mov    %edi,%ecx
  8033df:	d3 e6                	shl    %cl,%esi
  8033e1:	89 c5                	mov    %eax,%ebp
  8033e3:	88 d9                	mov    %bl,%cl
  8033e5:	d3 ed                	shr    %cl,%ebp
  8033e7:	89 e9                	mov    %ebp,%ecx
  8033e9:	09 f1                	or     %esi,%ecx
  8033eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8033ef:	89 f9                	mov    %edi,%ecx
  8033f1:	d3 e0                	shl    %cl,%eax
  8033f3:	89 c5                	mov    %eax,%ebp
  8033f5:	89 d6                	mov    %edx,%esi
  8033f7:	88 d9                	mov    %bl,%cl
  8033f9:	d3 ee                	shr    %cl,%esi
  8033fb:	89 f9                	mov    %edi,%ecx
  8033fd:	d3 e2                	shl    %cl,%edx
  8033ff:	8b 44 24 08          	mov    0x8(%esp),%eax
  803403:	88 d9                	mov    %bl,%cl
  803405:	d3 e8                	shr    %cl,%eax
  803407:	09 c2                	or     %eax,%edx
  803409:	89 d0                	mov    %edx,%eax
  80340b:	89 f2                	mov    %esi,%edx
  80340d:	f7 74 24 0c          	divl   0xc(%esp)
  803411:	89 d6                	mov    %edx,%esi
  803413:	89 c3                	mov    %eax,%ebx
  803415:	f7 e5                	mul    %ebp
  803417:	39 d6                	cmp    %edx,%esi
  803419:	72 19                	jb     803434 <__udivdi3+0xfc>
  80341b:	74 0b                	je     803428 <__udivdi3+0xf0>
  80341d:	89 d8                	mov    %ebx,%eax
  80341f:	31 ff                	xor    %edi,%edi
  803421:	e9 58 ff ff ff       	jmp    80337e <__udivdi3+0x46>
  803426:	66 90                	xchg   %ax,%ax
  803428:	8b 54 24 08          	mov    0x8(%esp),%edx
  80342c:	89 f9                	mov    %edi,%ecx
  80342e:	d3 e2                	shl    %cl,%edx
  803430:	39 c2                	cmp    %eax,%edx
  803432:	73 e9                	jae    80341d <__udivdi3+0xe5>
  803434:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803437:	31 ff                	xor    %edi,%edi
  803439:	e9 40 ff ff ff       	jmp    80337e <__udivdi3+0x46>
  80343e:	66 90                	xchg   %ax,%ax
  803440:	31 c0                	xor    %eax,%eax
  803442:	e9 37 ff ff ff       	jmp    80337e <__udivdi3+0x46>
  803447:	90                   	nop

00803448 <__umoddi3>:
  803448:	55                   	push   %ebp
  803449:	57                   	push   %edi
  80344a:	56                   	push   %esi
  80344b:	53                   	push   %ebx
  80344c:	83 ec 1c             	sub    $0x1c,%esp
  80344f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  803453:	8b 74 24 34          	mov    0x34(%esp),%esi
  803457:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80345b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80345f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  803463:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  803467:	89 f3                	mov    %esi,%ebx
  803469:	89 fa                	mov    %edi,%edx
  80346b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80346f:	89 34 24             	mov    %esi,(%esp)
  803472:	85 c0                	test   %eax,%eax
  803474:	75 1a                	jne    803490 <__umoddi3+0x48>
  803476:	39 f7                	cmp    %esi,%edi
  803478:	0f 86 a2 00 00 00    	jbe    803520 <__umoddi3+0xd8>
  80347e:	89 c8                	mov    %ecx,%eax
  803480:	89 f2                	mov    %esi,%edx
  803482:	f7 f7                	div    %edi
  803484:	89 d0                	mov    %edx,%eax
  803486:	31 d2                	xor    %edx,%edx
  803488:	83 c4 1c             	add    $0x1c,%esp
  80348b:	5b                   	pop    %ebx
  80348c:	5e                   	pop    %esi
  80348d:	5f                   	pop    %edi
  80348e:	5d                   	pop    %ebp
  80348f:	c3                   	ret    
  803490:	39 f0                	cmp    %esi,%eax
  803492:	0f 87 ac 00 00 00    	ja     803544 <__umoddi3+0xfc>
  803498:	0f bd e8             	bsr    %eax,%ebp
  80349b:	83 f5 1f             	xor    $0x1f,%ebp
  80349e:	0f 84 ac 00 00 00    	je     803550 <__umoddi3+0x108>
  8034a4:	bf 20 00 00 00       	mov    $0x20,%edi
  8034a9:	29 ef                	sub    %ebp,%edi
  8034ab:	89 fe                	mov    %edi,%esi
  8034ad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8034b1:	89 e9                	mov    %ebp,%ecx
  8034b3:	d3 e0                	shl    %cl,%eax
  8034b5:	89 d7                	mov    %edx,%edi
  8034b7:	89 f1                	mov    %esi,%ecx
  8034b9:	d3 ef                	shr    %cl,%edi
  8034bb:	09 c7                	or     %eax,%edi
  8034bd:	89 e9                	mov    %ebp,%ecx
  8034bf:	d3 e2                	shl    %cl,%edx
  8034c1:	89 14 24             	mov    %edx,(%esp)
  8034c4:	89 d8                	mov    %ebx,%eax
  8034c6:	d3 e0                	shl    %cl,%eax
  8034c8:	89 c2                	mov    %eax,%edx
  8034ca:	8b 44 24 08          	mov    0x8(%esp),%eax
  8034ce:	d3 e0                	shl    %cl,%eax
  8034d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8034d4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8034d8:	89 f1                	mov    %esi,%ecx
  8034da:	d3 e8                	shr    %cl,%eax
  8034dc:	09 d0                	or     %edx,%eax
  8034de:	d3 eb                	shr    %cl,%ebx
  8034e0:	89 da                	mov    %ebx,%edx
  8034e2:	f7 f7                	div    %edi
  8034e4:	89 d3                	mov    %edx,%ebx
  8034e6:	f7 24 24             	mull   (%esp)
  8034e9:	89 c6                	mov    %eax,%esi
  8034eb:	89 d1                	mov    %edx,%ecx
  8034ed:	39 d3                	cmp    %edx,%ebx
  8034ef:	0f 82 87 00 00 00    	jb     80357c <__umoddi3+0x134>
  8034f5:	0f 84 91 00 00 00    	je     80358c <__umoddi3+0x144>
  8034fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8034ff:	29 f2                	sub    %esi,%edx
  803501:	19 cb                	sbb    %ecx,%ebx
  803503:	89 d8                	mov    %ebx,%eax
  803505:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803509:	d3 e0                	shl    %cl,%eax
  80350b:	89 e9                	mov    %ebp,%ecx
  80350d:	d3 ea                	shr    %cl,%edx
  80350f:	09 d0                	or     %edx,%eax
  803511:	89 e9                	mov    %ebp,%ecx
  803513:	d3 eb                	shr    %cl,%ebx
  803515:	89 da                	mov    %ebx,%edx
  803517:	83 c4 1c             	add    $0x1c,%esp
  80351a:	5b                   	pop    %ebx
  80351b:	5e                   	pop    %esi
  80351c:	5f                   	pop    %edi
  80351d:	5d                   	pop    %ebp
  80351e:	c3                   	ret    
  80351f:	90                   	nop
  803520:	89 fd                	mov    %edi,%ebp
  803522:	85 ff                	test   %edi,%edi
  803524:	75 0b                	jne    803531 <__umoddi3+0xe9>
  803526:	b8 01 00 00 00       	mov    $0x1,%eax
  80352b:	31 d2                	xor    %edx,%edx
  80352d:	f7 f7                	div    %edi
  80352f:	89 c5                	mov    %eax,%ebp
  803531:	89 f0                	mov    %esi,%eax
  803533:	31 d2                	xor    %edx,%edx
  803535:	f7 f5                	div    %ebp
  803537:	89 c8                	mov    %ecx,%eax
  803539:	f7 f5                	div    %ebp
  80353b:	89 d0                	mov    %edx,%eax
  80353d:	e9 44 ff ff ff       	jmp    803486 <__umoddi3+0x3e>
  803542:	66 90                	xchg   %ax,%ax
  803544:	89 c8                	mov    %ecx,%eax
  803546:	89 f2                	mov    %esi,%edx
  803548:	83 c4 1c             	add    $0x1c,%esp
  80354b:	5b                   	pop    %ebx
  80354c:	5e                   	pop    %esi
  80354d:	5f                   	pop    %edi
  80354e:	5d                   	pop    %ebp
  80354f:	c3                   	ret    
  803550:	3b 04 24             	cmp    (%esp),%eax
  803553:	72 06                	jb     80355b <__umoddi3+0x113>
  803555:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803559:	77 0f                	ja     80356a <__umoddi3+0x122>
  80355b:	89 f2                	mov    %esi,%edx
  80355d:	29 f9                	sub    %edi,%ecx
  80355f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  803563:	89 14 24             	mov    %edx,(%esp)
  803566:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80356a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80356e:	8b 14 24             	mov    (%esp),%edx
  803571:	83 c4 1c             	add    $0x1c,%esp
  803574:	5b                   	pop    %ebx
  803575:	5e                   	pop    %esi
  803576:	5f                   	pop    %edi
  803577:	5d                   	pop    %ebp
  803578:	c3                   	ret    
  803579:	8d 76 00             	lea    0x0(%esi),%esi
  80357c:	2b 04 24             	sub    (%esp),%eax
  80357f:	19 fa                	sbb    %edi,%edx
  803581:	89 d1                	mov    %edx,%ecx
  803583:	89 c6                	mov    %eax,%esi
  803585:	e9 71 ff ff ff       	jmp    8034fb <__umoddi3+0xb3>
  80358a:	66 90                	xchg   %ax,%ax
  80358c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  803590:	72 ea                	jb     80357c <__umoddi3+0x134>
  803592:	89 d9                	mov    %ebx,%ecx
  803594:	e9 62 ff ff ff       	jmp    8034fb <__umoddi3+0xb3>
