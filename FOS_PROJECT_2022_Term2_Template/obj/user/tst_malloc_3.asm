
obj/user/tst_malloc_3:     file format elf32-i386


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
  800031:	e8 2b 0e 00 00       	call   800e61 <libmain>
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
  80003d:	81 ec 20 01 00 00    	sub    $0x120,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004e:	eb 29                	jmp    800079 <_main+0x41>
		{
			if (myEnv->__uptr_pws[i].empty)
  800050:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800079:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800091:	68 e0 28 80 00       	push   $0x8028e0
  800096:	6a 1a                	push   $0x1a
  800098:	68 fc 28 80 00       	push   $0x8028fc
  80009d:	e8 ce 0e 00 00       	call   800f70 <_panic>


	
	

	int Mega = 1024*1024;
  8000a2:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  8000a9:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	char minByte = 1<<7;
  8000b0:	c6 45 df 80          	movb   $0x80,-0x21(%ebp)
	char maxByte = 0x7F;
  8000b4:	c6 45 de 7f          	movb   $0x7f,-0x22(%ebp)
	short minShort = 1<<15 ;
  8000b8:	66 c7 45 dc 00 80    	movw   $0x8000,-0x24(%ebp)
	short maxShort = 0x7FFF;
  8000be:	66 c7 45 da ff 7f    	movw   $0x7fff,-0x26(%ebp)
	int minInt = 1<<31 ;
  8000c4:	c7 45 d4 00 00 00 80 	movl   $0x80000000,-0x2c(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cb:	c7 45 d0 ff ff ff 7f 	movl   $0x7fffffff,-0x30(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000d2:	e8 e5 20 00 00       	call   8021bc <sys_calculate_free_frames>
  8000d7:	89 45 cc             	mov    %eax,-0x34(%ebp)

	void* ptr_allocations[20] = {0};
  8000da:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  8000e0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ea:	89 d7                	mov    %edx,%edi
  8000ec:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000ee:	e8 4c 21 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  8000f3:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 a7 1e 00 00       	call   801fae <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800116:	85 c0                	test   %eax,%eax
  800118:	79 0d                	jns    800127 <_main+0xef>
  80011a:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800120:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800125:	76 14                	jbe    80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 10 29 80 00       	push   $0x802910
  80012f:	6a 36                	push   $0x36
  800131:	68 fc 28 80 00       	push   $0x8028fc
  800136:	e8 35 0e 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013b:	e8 ff 20 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800140:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800143:	3d 00 02 00 00       	cmp    $0x200,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 78 29 80 00       	push   $0x802978
  800152:	6a 37                	push   $0x37
  800154:	68 fc 28 80 00       	push   $0x8028fc
  800159:	e8 12 0e 00 00       	call   800f70 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 59 20 00 00       	call   8021bc <sys_calculate_free_frames>
  800163:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800166:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800169:	01 c0                	add    %eax,%eax
  80016b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80016e:	48                   	dec    %eax
  80016f:	89 45 c0             	mov    %eax,-0x40(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800172:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800178:	89 45 bc             	mov    %eax,-0x44(%ebp)
		byteArr[0] = minByte ;
  80017b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80017e:	8a 55 df             	mov    -0x21(%ebp),%dl
  800181:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800183:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800186:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800189:	01 c2                	add    %eax,%edx
  80018b:	8a 45 de             	mov    -0x22(%ebp),%al
  80018e:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800190:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800193:	e8 24 20 00 00       	call   8021bc <sys_calculate_free_frames>
  800198:	29 c3                	sub    %eax,%ebx
  80019a:	89 d8                	mov    %ebx,%eax
  80019c:	83 f8 03             	cmp    $0x3,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 a8 29 80 00       	push   $0x8029a8
  8001a9:	6a 3e                	push   $0x3e
  8001ab:	68 fc 28 80 00       	push   $0x8028fc
  8001b0:	e8 bb 0d 00 00       	call   800f70 <_panic>
		int var;
		int found = 0;
  8001b5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c3:	e9 82 00 00 00       	jmp    80024a <_main+0x212>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001c8:	a1 04 40 80 00       	mov    0x804004,%eax
  8001cd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8001d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001d6:	89 d0                	mov    %edx,%eax
  8001d8:	01 c0                	add    %eax,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	c1 e0 02             	shl    $0x2,%eax
  8001df:	01 c8                	add    %ecx,%eax
  8001e1:	8b 00                	mov    (%eax),%eax
  8001e3:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ee:	89 c2                	mov    %eax,%edx
  8001f0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001f3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8001f6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001fe:	39 c2                	cmp    %eax,%edx
  800200:	75 03                	jne    800205 <_main+0x1cd>
				found++;
  800202:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800205:	a1 04 40 80 00       	mov    0x804004,%eax
  80020a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800210:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800213:	89 d0                	mov    %edx,%eax
  800215:	01 c0                	add    %eax,%eax
  800217:	01 d0                	add    %edx,%eax
  800219:	c1 e0 02             	shl    $0x2,%eax
  80021c:	01 c8                	add    %ecx,%eax
  80021e:	8b 00                	mov    (%eax),%eax
  800220:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800223:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800226:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022b:	89 c1                	mov    %eax,%ecx
  80022d:	8b 55 c0             	mov    -0x40(%ebp),%edx
  800230:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800233:	01 d0                	add    %edx,%eax
  800235:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800238:	8b 45 ac             	mov    -0x54(%ebp),%eax
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
  80024a:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800266:	68 ec 29 80 00       	push   $0x8029ec
  80026b:	6a 48                	push   $0x48
  80026d:	68 fc 28 80 00       	push   $0x8028fc
  800272:	e8 f9 0c 00 00       	call   800f70 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800277:	e8 c3 1f 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  80027c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80027f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800282:	01 c0                	add    %eax,%eax
  800284:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	50                   	push   %eax
  80028b:	e8 1e 1d 00 00       	call   801fae <malloc>
  800290:	83 c4 10             	add    $0x10,%esp
  800293:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800299:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80029f:	89 c2                	mov    %eax,%edx
  8002a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a4:	01 c0                	add    %eax,%eax
  8002a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ab:	39 c2                	cmp    %eax,%edx
  8002ad:	72 16                	jb     8002c5 <_main+0x28d>
  8002af:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8002b5:	89 c2                	mov    %eax,%edx
  8002b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002ba:	01 c0                	add    %eax,%eax
  8002bc:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002c1:	39 c2                	cmp    %eax,%edx
  8002c3:	76 14                	jbe    8002d9 <_main+0x2a1>
  8002c5:	83 ec 04             	sub    $0x4,%esp
  8002c8:	68 10 29 80 00       	push   $0x802910
  8002cd:	6a 4d                	push   $0x4d
  8002cf:	68 fc 28 80 00       	push   $0x8028fc
  8002d4:	e8 97 0c 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002d9:	e8 61 1f 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  8002de:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8002e1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 78 29 80 00       	push   $0x802978
  8002f0:	6a 4e                	push   $0x4e
  8002f2:	68 fc 28 80 00       	push   $0x8028fc
  8002f7:	e8 74 0c 00 00       	call   800f70 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 bb 1e 00 00       	call   8021bc <sys_calculate_free_frames>
  800301:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr = (short *) ptr_allocations[1];
  800304:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80030a:	89 45 a8             	mov    %eax,-0x58(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80030d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800310:	01 c0                	add    %eax,%eax
  800312:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800315:	d1 e8                	shr    %eax
  800317:	48                   	dec    %eax
  800318:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		shortArr[0] = minShort;
  80031b:	8b 55 a8             	mov    -0x58(%ebp),%edx
  80031e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800321:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800324:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800327:	01 c0                	add    %eax,%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80032e:	01 c2                	add    %eax,%edx
  800330:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800334:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800337:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  80033a:	e8 7d 1e 00 00       	call   8021bc <sys_calculate_free_frames>
  80033f:	29 c3                	sub    %eax,%ebx
  800341:	89 d8                	mov    %ebx,%eax
  800343:	83 f8 02             	cmp    $0x2,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 a8 29 80 00       	push   $0x8029a8
  800350:	6a 55                	push   $0x55
  800352:	68 fc 28 80 00       	push   $0x8028fc
  800357:	e8 14 0c 00 00       	call   800f70 <_panic>
		found = 0;
  80035c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800363:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80036a:	e9 86 00 00 00       	jmp    8003f5 <_main+0x3bd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80036f:	a1 04 40 80 00       	mov    0x804004,%eax
  800374:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80037a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80037d:	89 d0                	mov    %edx,%eax
  80037f:	01 c0                	add    %eax,%eax
  800381:	01 d0                	add    %edx,%eax
  800383:	c1 e0 02             	shl    $0x2,%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80038d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800390:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800395:	89 c2                	mov    %eax,%edx
  800397:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80039a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80039d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a5:	39 c2                	cmp    %eax,%edx
  8003a7:	75 03                	jne    8003ac <_main+0x374>
				found++;
  8003a9:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003ac:	a1 04 40 80 00       	mov    0x804004,%eax
  8003b1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8003b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003ba:	89 d0                	mov    %edx,%eax
  8003bc:	01 c0                	add    %eax,%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	c1 e0 02             	shl    $0x2,%eax
  8003c3:	01 c8                	add    %ecx,%eax
  8003c5:	8b 00                	mov    (%eax),%eax
  8003c7:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	89 c1                	mov    %eax,%ecx
  8003db:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003de:	01 c8                	add    %ecx,%eax
  8003e0:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003e3:	8b 45 94             	mov    -0x6c(%ebp),%eax
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
  8003f5:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800411:	68 ec 29 80 00       	push   $0x8029ec
  800416:	6a 5e                	push   $0x5e
  800418:	68 fc 28 80 00       	push   $0x8028fc
  80041d:	e8 4e 0b 00 00       	call   800f70 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800422:	e8 18 1e 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800427:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80042d:	01 c0                	add    %eax,%eax
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	50                   	push   %eax
  800433:	e8 76 1b 00 00       	call   801fae <malloc>
  800438:	83 c4 10             	add    $0x10,%esp
  80043b:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800441:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800447:	89 c2                	mov    %eax,%edx
  800449:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044c:	c1 e0 02             	shl    $0x2,%eax
  80044f:	05 00 00 00 80       	add    $0x80000000,%eax
  800454:	39 c2                	cmp    %eax,%edx
  800456:	72 17                	jb     80046f <_main+0x437>
  800458:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80045e:	89 c2                	mov    %eax,%edx
  800460:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800463:	c1 e0 02             	shl    $0x2,%eax
  800466:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80046b:	39 c2                	cmp    %eax,%edx
  80046d:	76 14                	jbe    800483 <_main+0x44b>
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 10 29 80 00       	push   $0x802910
  800477:	6a 63                	push   $0x63
  800479:	68 fc 28 80 00       	push   $0x8028fc
  80047e:	e8 ed 0a 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800483:	e8 b7 1d 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800488:	2b 45 c8             	sub    -0x38(%ebp),%eax
  80048b:	83 f8 01             	cmp    $0x1,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 78 29 80 00       	push   $0x802978
  800498:	6a 64                	push   $0x64
  80049a:	68 fc 28 80 00       	push   $0x8028fc
  80049f:	e8 cc 0a 00 00       	call   800f70 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a4:	e8 13 1d 00 00       	call   8021bc <sys_calculate_free_frames>
  8004a9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004ac:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8004b2:	89 45 90             	mov    %eax,-0x70(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  8004b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004b8:	01 c0                	add    %eax,%eax
  8004ba:	c1 e8 02             	shr    $0x2,%eax
  8004bd:	48                   	dec    %eax
  8004be:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr[0] = minInt;
  8004c1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004c4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004c7:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004c9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	8b 45 90             	mov    -0x70(%ebp),%eax
  8004d6:	01 c2                	add    %eax,%edx
  8004d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004db:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004dd:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8004e0:	e8 d7 1c 00 00       	call   8021bc <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	83 f8 02             	cmp    $0x2,%eax
  8004ec:	74 14                	je     800502 <_main+0x4ca>
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	68 a8 29 80 00       	push   $0x8029a8
  8004f6:	6a 6b                	push   $0x6b
  8004f8:	68 fc 28 80 00       	push   $0x8028fc
  8004fd:	e8 6e 0a 00 00       	call   800f70 <_panic>
		found = 0;
  800502:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800510:	e9 8f 00 00 00       	jmp    8005a4 <_main+0x56c>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800515:	a1 04 40 80 00       	mov    0x804004,%eax
  80051a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800520:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800523:	89 d0                	mov    %edx,%eax
  800525:	01 c0                	add    %eax,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	c1 e0 02             	shl    $0x2,%eax
  80052c:	01 c8                	add    %ecx,%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	89 45 88             	mov    %eax,-0x78(%ebp)
  800533:	8b 45 88             	mov    -0x78(%ebp),%eax
  800536:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053b:	89 c2                	mov    %eax,%edx
  80053d:	8b 45 90             	mov    -0x70(%ebp),%eax
  800540:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800543:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80054b:	39 c2                	cmp    %eax,%edx
  80054d:	75 03                	jne    800552 <_main+0x51a>
				found++;
  80054f:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800552:	a1 04 40 80 00       	mov    0x804004,%eax
  800557:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80055d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800560:	89 d0                	mov    %edx,%eax
  800562:	01 c0                	add    %eax,%eax
  800564:	01 d0                	add    %edx,%eax
  800566:	c1 e0 02             	shl    $0x2,%eax
  800569:	01 c8                	add    %ecx,%eax
  80056b:	8b 00                	mov    (%eax),%eax
  80056d:	89 45 80             	mov    %eax,-0x80(%ebp)
  800570:	8b 45 80             	mov    -0x80(%ebp),%eax
  800573:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800578:	89 c2                	mov    %eax,%edx
  80057a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80057d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800584:	8b 45 90             	mov    -0x70(%ebp),%eax
  800587:	01 c8                	add    %ecx,%eax
  800589:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80058f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800595:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059a:	39 c2                	cmp    %eax,%edx
  80059c:	75 03                	jne    8005a1 <_main+0x569>
				found++;
  80059e:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005a1:	ff 45 ec             	incl   -0x14(%ebp)
  8005a4:	a1 04 40 80 00       	mov    0x804004,%eax
  8005a9:	8b 50 74             	mov    0x74(%eax),%edx
  8005ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	0f 87 5e ff ff ff    	ja     800515 <_main+0x4dd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005b7:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005bb:	74 14                	je     8005d1 <_main+0x599>
  8005bd:	83 ec 04             	sub    $0x4,%esp
  8005c0:	68 ec 29 80 00       	push   $0x8029ec
  8005c5:	6a 74                	push   $0x74
  8005c7:	68 fc 28 80 00       	push   $0x8028fc
  8005cc:	e8 9f 09 00 00       	call   800f70 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d1:	e8 e6 1b 00 00       	call   8021bc <sys_calculate_free_frames>
  8005d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005d9:	e8 61 1c 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  8005de:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005e4:	01 c0                	add    %eax,%eax
  8005e6:	83 ec 0c             	sub    $0xc,%esp
  8005e9:	50                   	push   %eax
  8005ea:	e8 bf 19 00 00       	call   801fae <malloc>
  8005ef:	83 c4 10             	add    $0x10,%esp
  8005f2:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005f8:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  8005fe:	89 c2                	mov    %eax,%edx
  800600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800603:	c1 e0 02             	shl    $0x2,%eax
  800606:	89 c1                	mov    %eax,%ecx
  800608:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060b:	c1 e0 02             	shl    $0x2,%eax
  80060e:	01 c8                	add    %ecx,%eax
  800610:	05 00 00 00 80       	add    $0x80000000,%eax
  800615:	39 c2                	cmp    %eax,%edx
  800617:	72 21                	jb     80063a <_main+0x602>
  800619:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  80061f:	89 c2                	mov    %eax,%edx
  800621:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800624:	c1 e0 02             	shl    $0x2,%eax
  800627:	89 c1                	mov    %eax,%ecx
  800629:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062c:	c1 e0 02             	shl    $0x2,%eax
  80062f:	01 c8                	add    %ecx,%eax
  800631:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800636:	39 c2                	cmp    %eax,%edx
  800638:	76 14                	jbe    80064e <_main+0x616>
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	68 10 29 80 00       	push   $0x802910
  800642:	6a 7a                	push   $0x7a
  800644:	68 fc 28 80 00       	push   $0x8028fc
  800649:	e8 22 09 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80064e:	e8 ec 1b 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800653:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800656:	83 f8 01             	cmp    $0x1,%eax
  800659:	74 14                	je     80066f <_main+0x637>
  80065b:	83 ec 04             	sub    $0x4,%esp
  80065e:	68 78 29 80 00       	push   $0x802978
  800663:	6a 7b                	push   $0x7b
  800665:	68 fc 28 80 00       	push   $0x8028fc
  80066a:	e8 01 09 00 00       	call   800f70 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80066f:	e8 cb 1b 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800674:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800677:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80067a:	89 d0                	mov    %edx,%eax
  80067c:	01 c0                	add    %eax,%eax
  80067e:	01 d0                	add    %edx,%eax
  800680:	01 c0                	add    %eax,%eax
  800682:	01 d0                	add    %edx,%eax
  800684:	83 ec 0c             	sub    $0xc,%esp
  800687:	50                   	push   %eax
  800688:	e8 21 19 00 00       	call   801fae <malloc>
  80068d:	83 c4 10             	add    $0x10,%esp
  800690:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800696:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  80069c:	89 c2                	mov    %eax,%edx
  80069e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006a1:	c1 e0 02             	shl    $0x2,%eax
  8006a4:	89 c1                	mov    %eax,%ecx
  8006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a9:	c1 e0 03             	shl    $0x3,%eax
  8006ac:	01 c8                	add    %ecx,%eax
  8006ae:	05 00 00 00 80       	add    $0x80000000,%eax
  8006b3:	39 c2                	cmp    %eax,%edx
  8006b5:	72 21                	jb     8006d8 <_main+0x6a0>
  8006b7:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  8006bd:	89 c2                	mov    %eax,%edx
  8006bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c2:	c1 e0 02             	shl    $0x2,%eax
  8006c5:	89 c1                	mov    %eax,%ecx
  8006c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006ca:	c1 e0 03             	shl    $0x3,%eax
  8006cd:	01 c8                	add    %ecx,%eax
  8006cf:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006d4:	39 c2                	cmp    %eax,%edx
  8006d6:	76 17                	jbe    8006ef <_main+0x6b7>
  8006d8:	83 ec 04             	sub    $0x4,%esp
  8006db:	68 10 29 80 00       	push   $0x802910
  8006e0:	68 81 00 00 00       	push   $0x81
  8006e5:	68 fc 28 80 00       	push   $0x8028fc
  8006ea:	e8 81 08 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006ef:	e8 4b 1b 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  8006f4:	2b 45 c8             	sub    -0x38(%ebp),%eax
  8006f7:	83 f8 02             	cmp    $0x2,%eax
  8006fa:	74 17                	je     800713 <_main+0x6db>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 78 29 80 00       	push   $0x802978
  800704:	68 82 00 00 00       	push   $0x82
  800709:	68 fc 28 80 00       	push   $0x8028fc
  80070e:	e8 5d 08 00 00       	call   800f70 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800713:	e8 a4 1a 00 00       	call   8021bc <sys_calculate_free_frames>
  800718:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  80071b:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800721:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800727:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80072a:	89 d0                	mov    %edx,%eax
  80072c:	01 c0                	add    %eax,%eax
  80072e:	01 d0                	add    %edx,%eax
  800730:	01 c0                	add    %eax,%eax
  800732:	01 d0                	add    %edx,%eax
  800734:	c1 e8 03             	shr    $0x3,%eax
  800737:	48                   	dec    %eax
  800738:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  80073e:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800744:	8a 55 df             	mov    -0x21(%ebp),%dl
  800747:	88 10                	mov    %dl,(%eax)
  800749:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  80074f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800752:	66 89 42 02          	mov    %ax,0x2(%edx)
  800756:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80075c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80075f:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800762:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800768:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80076f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800775:	01 c2                	add    %eax,%edx
  800777:	8a 45 de             	mov    -0x22(%ebp),%al
  80077a:	88 02                	mov    %al,(%edx)
  80077c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800782:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800789:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80078f:	01 c2                	add    %eax,%edx
  800791:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800795:	66 89 42 02          	mov    %ax,0x2(%edx)
  800799:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80079f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007a6:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8007ac:	01 c2                	add    %eax,%edx
  8007ae:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b1:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007b4:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  8007b7:	e8 00 1a 00 00       	call   8021bc <sys_calculate_free_frames>
  8007bc:	29 c3                	sub    %eax,%ebx
  8007be:	89 d8                	mov    %ebx,%eax
  8007c0:	83 f8 02             	cmp    $0x2,%eax
  8007c3:	74 17                	je     8007dc <_main+0x7a4>
  8007c5:	83 ec 04             	sub    $0x4,%esp
  8007c8:	68 a8 29 80 00       	push   $0x8029a8
  8007cd:	68 89 00 00 00       	push   $0x89
  8007d2:	68 fc 28 80 00       	push   $0x8028fc
  8007d7:	e8 94 07 00 00       	call   800f70 <_panic>
		found = 0;
  8007dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007ea:	e9 aa 00 00 00       	jmp    800899 <_main+0x861>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007ef:	a1 04 40 80 00       	mov    0x804004,%eax
  8007f4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007fd:	89 d0                	mov    %edx,%eax
  8007ff:	01 c0                	add    %eax,%eax
  800801:	01 d0                	add    %edx,%eax
  800803:	c1 e0 02             	shl    $0x2,%eax
  800806:	01 c8                	add    %ecx,%eax
  800808:	8b 00                	mov    (%eax),%eax
  80080a:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  800810:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800816:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80081b:	89 c2                	mov    %eax,%edx
  80081d:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800823:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800829:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80082f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800834:	39 c2                	cmp    %eax,%edx
  800836:	75 03                	jne    80083b <_main+0x803>
				found++;
  800838:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80083b:	a1 04 40 80 00       	mov    0x804004,%eax
  800840:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800846:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800849:	89 d0                	mov    %edx,%eax
  80084b:	01 c0                	add    %eax,%eax
  80084d:	01 d0                	add    %edx,%eax
  80084f:	c1 e0 02             	shl    $0x2,%eax
  800852:	01 c8                	add    %ecx,%eax
  800854:	8b 00                	mov    (%eax),%eax
  800856:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80085c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800862:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800867:	89 c2                	mov    %eax,%edx
  800869:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80086f:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800876:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80087c:	01 c8                	add    %ecx,%eax
  80087e:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800884:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80088a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80088f:	39 c2                	cmp    %eax,%edx
  800891:	75 03                	jne    800896 <_main+0x85e>
				found++;
  800893:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800896:	ff 45 ec             	incl   -0x14(%ebp)
  800899:	a1 04 40 80 00       	mov    0x804004,%eax
  80089e:	8b 50 74             	mov    0x74(%eax),%edx
  8008a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a4:	39 c2                	cmp    %eax,%edx
  8008a6:	0f 87 43 ff ff ff    	ja     8007ef <_main+0x7b7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8008ac:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008b0:	74 17                	je     8008c9 <_main+0x891>
  8008b2:	83 ec 04             	sub    $0x4,%esp
  8008b5:	68 ec 29 80 00       	push   $0x8029ec
  8008ba:	68 92 00 00 00       	push   $0x92
  8008bf:	68 fc 28 80 00       	push   $0x8028fc
  8008c4:	e8 a7 06 00 00       	call   800f70 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008c9:	e8 ee 18 00 00       	call   8021bc <sys_calculate_free_frames>
  8008ce:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d1:	e8 69 19 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  8008d6:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008dc:	89 c2                	mov    %eax,%edx
  8008de:	01 d2                	add    %edx,%edx
  8008e0:	01 d0                	add    %edx,%eax
  8008e2:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e5:	83 ec 0c             	sub    $0xc,%esp
  8008e8:	50                   	push   %eax
  8008e9:	e8 c0 16 00 00       	call   801fae <malloc>
  8008ee:	83 c4 10             	add    $0x10,%esp
  8008f1:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008f7:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  8008fd:	89 c2                	mov    %eax,%edx
  8008ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800902:	c1 e0 02             	shl    $0x2,%eax
  800905:	89 c1                	mov    %eax,%ecx
  800907:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090a:	c1 e0 04             	shl    $0x4,%eax
  80090d:	01 c8                	add    %ecx,%eax
  80090f:	05 00 00 00 80       	add    $0x80000000,%eax
  800914:	39 c2                	cmp    %eax,%edx
  800916:	72 21                	jb     800939 <_main+0x901>
  800918:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80091e:	89 c2                	mov    %eax,%edx
  800920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800923:	c1 e0 02             	shl    $0x2,%eax
  800926:	89 c1                	mov    %eax,%ecx
  800928:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092b:	c1 e0 04             	shl    $0x4,%eax
  80092e:	01 c8                	add    %ecx,%eax
  800930:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800935:	39 c2                	cmp    %eax,%edx
  800937:	76 17                	jbe    800950 <_main+0x918>
  800939:	83 ec 04             	sub    $0x4,%esp
  80093c:	68 10 29 80 00       	push   $0x802910
  800941:	68 98 00 00 00       	push   $0x98
  800946:	68 fc 28 80 00       	push   $0x8028fc
  80094b:	e8 20 06 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800950:	e8 ea 18 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800955:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800958:	89 c2                	mov    %eax,%edx
  80095a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80095d:	89 c1                	mov    %eax,%ecx
  80095f:	01 c9                	add    %ecx,%ecx
  800961:	01 c8                	add    %ecx,%eax
  800963:	85 c0                	test   %eax,%eax
  800965:	79 05                	jns    80096c <_main+0x934>
  800967:	05 ff 0f 00 00       	add    $0xfff,%eax
  80096c:	c1 f8 0c             	sar    $0xc,%eax
  80096f:	39 c2                	cmp    %eax,%edx
  800971:	74 17                	je     80098a <_main+0x952>
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	68 78 29 80 00       	push   $0x802978
  80097b:	68 99 00 00 00       	push   $0x99
  800980:	68 fc 28 80 00       	push   $0x8028fc
  800985:	e8 e6 05 00 00       	call   800f70 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80098a:	e8 b0 18 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  80098f:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800992:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800995:	89 d0                	mov    %edx,%eax
  800997:	01 c0                	add    %eax,%eax
  800999:	01 d0                	add    %edx,%eax
  80099b:	01 c0                	add    %eax,%eax
  80099d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8009a0:	83 ec 0c             	sub    $0xc,%esp
  8009a3:	50                   	push   %eax
  8009a4:	e8 05 16 00 00       	call   801fae <malloc>
  8009a9:	83 c4 10             	add    $0x10,%esp
  8009ac:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009b2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009b8:	89 c1                	mov    %eax,%ecx
  8009ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009bd:	89 d0                	mov    %edx,%eax
  8009bf:	01 c0                	add    %eax,%eax
  8009c1:	01 d0                	add    %edx,%eax
  8009c3:	01 c0                	add    %eax,%eax
  8009c5:	01 d0                	add    %edx,%eax
  8009c7:	89 c2                	mov    %eax,%edx
  8009c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009cc:	c1 e0 04             	shl    $0x4,%eax
  8009cf:	01 d0                	add    %edx,%eax
  8009d1:	05 00 00 00 80       	add    $0x80000000,%eax
  8009d6:	39 c1                	cmp    %eax,%ecx
  8009d8:	72 28                	jb     800a02 <_main+0x9ca>
  8009da:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  8009e0:	89 c1                	mov    %eax,%ecx
  8009e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8009e5:	89 d0                	mov    %edx,%eax
  8009e7:	01 c0                	add    %eax,%eax
  8009e9:	01 d0                	add    %edx,%eax
  8009eb:	01 c0                	add    %eax,%eax
  8009ed:	01 d0                	add    %edx,%eax
  8009ef:	89 c2                	mov    %eax,%edx
  8009f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009f4:	c1 e0 04             	shl    $0x4,%eax
  8009f7:	01 d0                	add    %edx,%eax
  8009f9:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8009fe:	39 c1                	cmp    %eax,%ecx
  800a00:	76 17                	jbe    800a19 <_main+0x9e1>
  800a02:	83 ec 04             	sub    $0x4,%esp
  800a05:	68 10 29 80 00       	push   $0x802910
  800a0a:	68 9f 00 00 00       	push   $0x9f
  800a0f:	68 fc 28 80 00       	push   $0x8028fc
  800a14:	e8 57 05 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a19:	e8 21 18 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800a1e:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800a21:	89 c1                	mov    %eax,%ecx
  800a23:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a26:	89 d0                	mov    %edx,%eax
  800a28:	01 c0                	add    %eax,%eax
  800a2a:	01 d0                	add    %edx,%eax
  800a2c:	01 c0                	add    %eax,%eax
  800a2e:	85 c0                	test   %eax,%eax
  800a30:	79 05                	jns    800a37 <_main+0x9ff>
  800a32:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a37:	c1 f8 0c             	sar    $0xc,%eax
  800a3a:	39 c1                	cmp    %eax,%ecx
  800a3c:	74 17                	je     800a55 <_main+0xa1d>
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	68 78 29 80 00       	push   $0x802978
  800a46:	68 a0 00 00 00       	push   $0xa0
  800a4b:	68 fc 28 80 00       	push   $0x8028fc
  800a50:	e8 1b 05 00 00       	call   800f70 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a55:	e8 62 17 00 00       	call   8021bc <sys_calculate_free_frames>
  800a5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a5d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a60:	89 d0                	mov    %edx,%eax
  800a62:	01 c0                	add    %eax,%eax
  800a64:	01 d0                	add    %edx,%eax
  800a66:	01 c0                	add    %eax,%eax
  800a68:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a6b:	48                   	dec    %eax
  800a6c:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a72:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800a78:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		byteArr2[0] = minByte ;
  800a7e:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800a84:	8a 55 df             	mov    -0x21(%ebp),%dl
  800a87:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a89:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800a8f:	89 c2                	mov    %eax,%edx
  800a91:	c1 ea 1f             	shr    $0x1f,%edx
  800a94:	01 d0                	add    %edx,%eax
  800a96:	d1 f8                	sar    %eax
  800a98:	89 c2                	mov    %eax,%edx
  800a9a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800aa0:	01 c2                	add    %eax,%edx
  800aa2:	8a 45 de             	mov    -0x22(%ebp),%al
  800aa5:	88 c1                	mov    %al,%cl
  800aa7:	c0 e9 07             	shr    $0x7,%cl
  800aaa:	01 c8                	add    %ecx,%eax
  800aac:	d0 f8                	sar    %al
  800aae:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ab0:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800ab6:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800abc:	01 c2                	add    %eax,%edx
  800abe:	8a 45 de             	mov    -0x22(%ebp),%al
  800ac1:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ac3:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800ac6:	e8 f1 16 00 00       	call   8021bc <sys_calculate_free_frames>
  800acb:	29 c3                	sub    %eax,%ebx
  800acd:	89 d8                	mov    %ebx,%eax
  800acf:	83 f8 05             	cmp    $0x5,%eax
  800ad2:	74 17                	je     800aeb <_main+0xab3>
  800ad4:	83 ec 04             	sub    $0x4,%esp
  800ad7:	68 a8 29 80 00       	push   $0x8029a8
  800adc:	68 a8 00 00 00       	push   $0xa8
  800ae1:	68 fc 28 80 00       	push   $0x8028fc
  800ae6:	e8 85 04 00 00       	call   800f70 <_panic>
		found = 0;
  800aeb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800af2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800af9:	e9 02 01 00 00       	jmp    800c00 <_main+0xbc8>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800afe:	a1 04 40 80 00       	mov    0x804004,%eax
  800b03:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b09:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b0c:	89 d0                	mov    %edx,%eax
  800b0e:	01 c0                	add    %eax,%eax
  800b10:	01 d0                	add    %edx,%eax
  800b12:	c1 e0 02             	shl    $0x2,%eax
  800b15:	01 c8                	add    %ecx,%eax
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800b1f:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b2a:	89 c2                	mov    %eax,%edx
  800b2c:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b32:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800b38:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b3e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b43:	39 c2                	cmp    %eax,%edx
  800b45:	75 03                	jne    800b4a <_main+0xb12>
				found++;
  800b47:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b4a:	a1 04 40 80 00       	mov    0x804004,%eax
  800b4f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b55:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b58:	89 d0                	mov    %edx,%eax
  800b5a:	01 c0                	add    %eax,%eax
  800b5c:	01 d0                	add    %edx,%eax
  800b5e:	c1 e0 02             	shl    $0x2,%eax
  800b61:	01 c8                	add    %ecx,%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b6b:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b71:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b76:	89 c2                	mov    %eax,%edx
  800b78:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800b7e:	89 c1                	mov    %eax,%ecx
  800b80:	c1 e9 1f             	shr    $0x1f,%ecx
  800b83:	01 c8                	add    %ecx,%eax
  800b85:	d1 f8                	sar    %eax
  800b87:	89 c1                	mov    %eax,%ecx
  800b89:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800b8f:	01 c8                	add    %ecx,%eax
  800b91:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b97:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba2:	39 c2                	cmp    %eax,%edx
  800ba4:	75 03                	jne    800ba9 <_main+0xb71>
				found++;
  800ba6:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800ba9:	a1 04 40 80 00       	mov    0x804004,%eax
  800bae:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bb4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bb7:	89 d0                	mov    %edx,%eax
  800bb9:	01 c0                	add    %eax,%eax
  800bbb:	01 d0                	add    %edx,%eax
  800bbd:	c1 e0 02             	shl    $0x2,%eax
  800bc0:	01 c8                	add    %ecx,%eax
  800bc2:	8b 00                	mov    (%eax),%eax
  800bc4:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800bca:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800bd0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bd5:	89 c1                	mov    %eax,%ecx
  800bd7:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
  800bdd:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800beb:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bf1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bf6:	39 c1                	cmp    %eax,%ecx
  800bf8:	75 03                	jne    800bfd <_main+0xbc5>
				found++;
  800bfa:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800bfd:	ff 45 ec             	incl   -0x14(%ebp)
  800c00:	a1 04 40 80 00       	mov    0x804004,%eax
  800c05:	8b 50 74             	mov    0x74(%eax),%edx
  800c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c0b:	39 c2                	cmp    %eax,%edx
  800c0d:	0f 87 eb fe ff ff    	ja     800afe <_main+0xac6>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c13:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c17:	74 17                	je     800c30 <_main+0xbf8>
  800c19:	83 ec 04             	sub    $0x4,%esp
  800c1c:	68 ec 29 80 00       	push   $0x8029ec
  800c21:	68 b3 00 00 00       	push   $0xb3
  800c26:	68 fc 28 80 00       	push   $0x8028fc
  800c2b:	e8 40 03 00 00       	call   800f70 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c30:	e8 0a 16 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800c35:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c38:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3b:	89 d0                	mov    %edx,%eax
  800c3d:	01 c0                	add    %eax,%eax
  800c3f:	01 d0                	add    %edx,%eax
  800c41:	01 c0                	add    %eax,%eax
  800c43:	01 d0                	add    %edx,%eax
  800c45:	01 c0                	add    %eax,%eax
  800c47:	83 ec 0c             	sub    $0xc,%esp
  800c4a:	50                   	push   %eax
  800c4b:	e8 5e 13 00 00       	call   801fae <malloc>
  800c50:	83 c4 10             	add    $0x10,%esp
  800c53:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c59:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c5f:	89 c1                	mov    %eax,%ecx
  800c61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c64:	89 d0                	mov    %edx,%eax
  800c66:	01 c0                	add    %eax,%eax
  800c68:	01 d0                	add    %edx,%eax
  800c6a:	c1 e0 02             	shl    $0x2,%eax
  800c6d:	01 d0                	add    %edx,%eax
  800c6f:	89 c2                	mov    %eax,%edx
  800c71:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c74:	c1 e0 04             	shl    $0x4,%eax
  800c77:	01 d0                	add    %edx,%eax
  800c79:	05 00 00 00 80       	add    $0x80000000,%eax
  800c7e:	39 c1                	cmp    %eax,%ecx
  800c80:	72 29                	jb     800cab <_main+0xc73>
  800c82:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800c88:	89 c1                	mov    %eax,%ecx
  800c8a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c8d:	89 d0                	mov    %edx,%eax
  800c8f:	01 c0                	add    %eax,%eax
  800c91:	01 d0                	add    %edx,%eax
  800c93:	c1 e0 02             	shl    $0x2,%eax
  800c96:	01 d0                	add    %edx,%eax
  800c98:	89 c2                	mov    %eax,%edx
  800c9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c9d:	c1 e0 04             	shl    $0x4,%eax
  800ca0:	01 d0                	add    %edx,%eax
  800ca2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800ca7:	39 c1                	cmp    %eax,%ecx
  800ca9:	76 17                	jbe    800cc2 <_main+0xc8a>
  800cab:	83 ec 04             	sub    $0x4,%esp
  800cae:	68 10 29 80 00       	push   $0x802910
  800cb3:	68 b8 00 00 00       	push   $0xb8
  800cb8:	68 fc 28 80 00       	push   $0x8028fc
  800cbd:	e8 ae 02 00 00       	call   800f70 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc2:	e8 78 15 00 00       	call   80223f <sys_pf_calculate_allocated_pages>
  800cc7:	2b 45 c8             	sub    -0x38(%ebp),%eax
  800cca:	83 f8 04             	cmp    $0x4,%eax
  800ccd:	74 17                	je     800ce6 <_main+0xcae>
  800ccf:	83 ec 04             	sub    $0x4,%esp
  800cd2:	68 78 29 80 00       	push   $0x802978
  800cd7:	68 b9 00 00 00       	push   $0xb9
  800cdc:	68 fc 28 80 00       	push   $0x8028fc
  800ce1:	e8 8a 02 00 00       	call   800f70 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800ce6:	e8 d1 14 00 00       	call   8021bc <sys_calculate_free_frames>
  800ceb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cee:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800cf4:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800cfa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cfd:	89 d0                	mov    %edx,%eax
  800cff:	01 c0                	add    %eax,%eax
  800d01:	01 d0                	add    %edx,%eax
  800d03:	01 c0                	add    %eax,%eax
  800d05:	01 d0                	add    %edx,%eax
  800d07:	01 c0                	add    %eax,%eax
  800d09:	d1 e8                	shr    %eax
  800d0b:	48                   	dec    %eax
  800d0c:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
		shortArr2[0] = minShort;
  800d12:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  800d18:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d1b:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d1e:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800d24:	01 c0                	add    %eax,%eax
  800d26:	89 c2                	mov    %eax,%edx
  800d28:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800d2e:	01 c2                	add    %eax,%edx
  800d30:	66 8b 45 da          	mov    -0x26(%ebp),%ax
  800d34:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d37:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
  800d3a:	e8 7d 14 00 00       	call   8021bc <sys_calculate_free_frames>
  800d3f:	29 c3                	sub    %eax,%ebx
  800d41:	89 d8                	mov    %ebx,%eax
  800d43:	83 f8 02             	cmp    $0x2,%eax
  800d46:	74 17                	je     800d5f <_main+0xd27>
  800d48:	83 ec 04             	sub    $0x4,%esp
  800d4b:	68 a8 29 80 00       	push   $0x8029a8
  800d50:	68 c0 00 00 00       	push   $0xc0
  800d55:	68 fc 28 80 00       	push   $0x8028fc
  800d5a:	e8 11 02 00 00       	call   800f70 <_panic>
		found = 0;
  800d5f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d66:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d6d:	e9 a7 00 00 00       	jmp    800e19 <_main+0xde1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d72:	a1 04 40 80 00       	mov    0x804004,%eax
  800d77:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d7d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d80:	89 d0                	mov    %edx,%eax
  800d82:	01 c0                	add    %eax,%eax
  800d84:	01 d0                	add    %edx,%eax
  800d86:	c1 e0 02             	shl    $0x2,%eax
  800d89:	01 c8                	add    %ecx,%eax
  800d8b:	8b 00                	mov    (%eax),%eax
  800d8d:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800d93:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d9e:	89 c2                	mov    %eax,%edx
  800da0:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800da6:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800dac:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db7:	39 c2                	cmp    %eax,%edx
  800db9:	75 03                	jne    800dbe <_main+0xd86>
				found++;
  800dbb:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dbe:	a1 04 40 80 00       	mov    0x804004,%eax
  800dc3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dc9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcc:	89 d0                	mov    %edx,%eax
  800dce:	01 c0                	add    %eax,%eax
  800dd0:	01 d0                	add    %edx,%eax
  800dd2:	c1 e0 02             	shl    $0x2,%eax
  800dd5:	01 c8                	add    %ecx,%eax
  800dd7:	8b 00                	mov    (%eax),%eax
  800dd9:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800ddf:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800de5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dea:	89 c2                	mov    %eax,%edx
  800dec:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800df2:	01 c0                	add    %eax,%eax
  800df4:	89 c1                	mov    %eax,%ecx
  800df6:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800dfc:	01 c8                	add    %ecx,%eax
  800dfe:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800e04:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800e0a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e0f:	39 c2                	cmp    %eax,%edx
  800e11:	75 03                	jne    800e16 <_main+0xdde>
				found++;
  800e13:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e16:	ff 45 ec             	incl   -0x14(%ebp)
  800e19:	a1 04 40 80 00       	mov    0x804004,%eax
  800e1e:	8b 50 74             	mov    0x74(%eax),%edx
  800e21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e24:	39 c2                	cmp    %eax,%edx
  800e26:	0f 87 46 ff ff ff    	ja     800d72 <_main+0xd3a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e2c:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e30:	74 17                	je     800e49 <_main+0xe11>
  800e32:	83 ec 04             	sub    $0x4,%esp
  800e35:	68 ec 29 80 00       	push   $0x8029ec
  800e3a:	68 c9 00 00 00       	push   $0xc9
  800e3f:	68 fc 28 80 00       	push   $0x8028fc
  800e44:	e8 27 01 00 00       	call   800f70 <_panic>
	}

	cprintf("Congratulations!! test malloc [3] completed successfully.\n");
  800e49:	83 ec 0c             	sub    $0xc,%esp
  800e4c:	68 0c 2a 80 00       	push   $0x802a0c
  800e51:	e8 ce 03 00 00       	call   801224 <cprintf>
  800e56:	83 c4 10             	add    $0x10,%esp

	return;
  800e59:	90                   	nop
}
  800e5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e5d:	5b                   	pop    %ebx
  800e5e:	5f                   	pop    %edi
  800e5f:	5d                   	pop    %ebp
  800e60:	c3                   	ret    

00800e61 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800e61:	55                   	push   %ebp
  800e62:	89 e5                	mov    %esp,%ebp
  800e64:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800e67:	e8 85 12 00 00       	call   8020f1 <sys_getenvindex>
  800e6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800e6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e72:	89 d0                	mov    %edx,%eax
  800e74:	c1 e0 02             	shl    $0x2,%eax
  800e77:	01 d0                	add    %edx,%eax
  800e79:	01 c0                	add    %eax,%eax
  800e7b:	01 d0                	add    %edx,%eax
  800e7d:	01 c0                	add    %eax,%eax
  800e7f:	01 d0                	add    %edx,%eax
  800e81:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800e88:	01 d0                	add    %edx,%eax
  800e8a:	c1 e0 02             	shl    $0x2,%eax
  800e8d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800e92:	a3 04 40 80 00       	mov    %eax,0x804004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800e97:	a1 04 40 80 00       	mov    0x804004,%eax
  800e9c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800ea2:	84 c0                	test   %al,%al
  800ea4:	74 0f                	je     800eb5 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800ea6:	a1 04 40 80 00       	mov    0x804004,%eax
  800eab:	05 f4 02 00 00       	add    $0x2f4,%eax
  800eb0:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800eb5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800eb9:	7e 0a                	jle    800ec5 <libmain+0x64>
		binaryname = argv[0];
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	8b 00                	mov    (%eax),%eax
  800ec0:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	ff 75 08             	pushl  0x8(%ebp)
  800ece:	e8 65 f1 ff ff       	call   800038 <_main>
  800ed3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800ed6:	e8 b1 13 00 00       	call   80228c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800edb:	83 ec 0c             	sub    $0xc,%esp
  800ede:	68 60 2a 80 00       	push   $0x802a60
  800ee3:	e8 3c 03 00 00       	call   801224 <cprintf>
  800ee8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800eeb:	a1 04 40 80 00       	mov    0x804004,%eax
  800ef0:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800ef6:	a1 04 40 80 00       	mov    0x804004,%eax
  800efb:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800f01:	83 ec 04             	sub    $0x4,%esp
  800f04:	52                   	push   %edx
  800f05:	50                   	push   %eax
  800f06:	68 88 2a 80 00       	push   $0x802a88
  800f0b:	e8 14 03 00 00       	call   801224 <cprintf>
  800f10:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800f13:	a1 04 40 80 00       	mov    0x804004,%eax
  800f18:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800f1e:	83 ec 08             	sub    $0x8,%esp
  800f21:	50                   	push   %eax
  800f22:	68 ad 2a 80 00       	push   $0x802aad
  800f27:	e8 f8 02 00 00       	call   801224 <cprintf>
  800f2c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800f2f:	83 ec 0c             	sub    $0xc,%esp
  800f32:	68 60 2a 80 00       	push   $0x802a60
  800f37:	e8 e8 02 00 00       	call   801224 <cprintf>
  800f3c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800f3f:	e8 62 13 00 00       	call   8022a6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800f44:	e8 19 00 00 00       	call   800f62 <exit>
}
  800f49:	90                   	nop
  800f4a:	c9                   	leave  
  800f4b:	c3                   	ret    

00800f4c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800f4c:	55                   	push   %ebp
  800f4d:	89 e5                	mov    %esp,%ebp
  800f4f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800f52:	83 ec 0c             	sub    $0xc,%esp
  800f55:	6a 00                	push   $0x0
  800f57:	e8 61 11 00 00       	call   8020bd <sys_env_destroy>
  800f5c:	83 c4 10             	add    $0x10,%esp
}
  800f5f:	90                   	nop
  800f60:	c9                   	leave  
  800f61:	c3                   	ret    

00800f62 <exit>:

void
exit(void)
{
  800f62:	55                   	push   %ebp
  800f63:	89 e5                	mov    %esp,%ebp
  800f65:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800f68:	e8 b6 11 00 00       	call   802123 <sys_env_exit>
}
  800f6d:	90                   	nop
  800f6e:	c9                   	leave  
  800f6f:	c3                   	ret    

00800f70 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800f70:	55                   	push   %ebp
  800f71:	89 e5                	mov    %esp,%ebp
  800f73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800f76:	8d 45 10             	lea    0x10(%ebp),%eax
  800f79:	83 c0 04             	add    $0x4,%eax
  800f7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800f7f:	a1 14 40 80 00       	mov    0x804014,%eax
  800f84:	85 c0                	test   %eax,%eax
  800f86:	74 16                	je     800f9e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800f88:	a1 14 40 80 00       	mov    0x804014,%eax
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	50                   	push   %eax
  800f91:	68 c4 2a 80 00       	push   $0x802ac4
  800f96:	e8 89 02 00 00       	call   801224 <cprintf>
  800f9b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800f9e:	a1 00 40 80 00       	mov    0x804000,%eax
  800fa3:	ff 75 0c             	pushl  0xc(%ebp)
  800fa6:	ff 75 08             	pushl  0x8(%ebp)
  800fa9:	50                   	push   %eax
  800faa:	68 c9 2a 80 00       	push   $0x802ac9
  800faf:	e8 70 02 00 00       	call   801224 <cprintf>
  800fb4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800fb7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800fc0:	50                   	push   %eax
  800fc1:	e8 f3 01 00 00       	call   8011b9 <vcprintf>
  800fc6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800fc9:	83 ec 08             	sub    $0x8,%esp
  800fcc:	6a 00                	push   $0x0
  800fce:	68 e5 2a 80 00       	push   $0x802ae5
  800fd3:	e8 e1 01 00 00       	call   8011b9 <vcprintf>
  800fd8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800fdb:	e8 82 ff ff ff       	call   800f62 <exit>

	// should not return here
	while (1) ;
  800fe0:	eb fe                	jmp    800fe0 <_panic+0x70>

00800fe2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800fe8:	a1 04 40 80 00       	mov    0x804004,%eax
  800fed:	8b 50 74             	mov    0x74(%eax),%edx
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	39 c2                	cmp    %eax,%edx
  800ff5:	74 14                	je     80100b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ff7:	83 ec 04             	sub    $0x4,%esp
  800ffa:	68 e8 2a 80 00       	push   $0x802ae8
  800fff:	6a 26                	push   $0x26
  801001:	68 34 2b 80 00       	push   $0x802b34
  801006:	e8 65 ff ff ff       	call   800f70 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80100b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801012:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801019:	e9 c2 00 00 00       	jmp    8010e0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80101e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801021:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	01 d0                	add    %edx,%eax
  80102d:	8b 00                	mov    (%eax),%eax
  80102f:	85 c0                	test   %eax,%eax
  801031:	75 08                	jne    80103b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801033:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801036:	e9 a2 00 00 00       	jmp    8010dd <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80103b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801042:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801049:	eb 69                	jmp    8010b4 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80104b:	a1 04 40 80 00       	mov    0x804004,%eax
  801050:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801056:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801059:	89 d0                	mov    %edx,%eax
  80105b:	01 c0                	add    %eax,%eax
  80105d:	01 d0                	add    %edx,%eax
  80105f:	c1 e0 02             	shl    $0x2,%eax
  801062:	01 c8                	add    %ecx,%eax
  801064:	8a 40 04             	mov    0x4(%eax),%al
  801067:	84 c0                	test   %al,%al
  801069:	75 46                	jne    8010b1 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80106b:	a1 04 40 80 00       	mov    0x804004,%eax
  801070:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801076:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801079:	89 d0                	mov    %edx,%eax
  80107b:	01 c0                	add    %eax,%eax
  80107d:	01 d0                	add    %edx,%eax
  80107f:	c1 e0 02             	shl    $0x2,%eax
  801082:	01 c8                	add    %ecx,%eax
  801084:	8b 00                	mov    (%eax),%eax
  801086:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801089:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80108c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801091:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801093:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801096:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	01 c8                	add    %ecx,%eax
  8010a2:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8010a4:	39 c2                	cmp    %eax,%edx
  8010a6:	75 09                	jne    8010b1 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8010a8:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8010af:	eb 12                	jmp    8010c3 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010b1:	ff 45 e8             	incl   -0x18(%ebp)
  8010b4:	a1 04 40 80 00       	mov    0x804004,%eax
  8010b9:	8b 50 74             	mov    0x74(%eax),%edx
  8010bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010bf:	39 c2                	cmp    %eax,%edx
  8010c1:	77 88                	ja     80104b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8010c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010c7:	75 14                	jne    8010dd <CheckWSWithoutLastIndex+0xfb>
			panic(
  8010c9:	83 ec 04             	sub    $0x4,%esp
  8010cc:	68 40 2b 80 00       	push   $0x802b40
  8010d1:	6a 3a                	push   $0x3a
  8010d3:	68 34 2b 80 00       	push   $0x802b34
  8010d8:	e8 93 fe ff ff       	call   800f70 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8010dd:	ff 45 f0             	incl   -0x10(%ebp)
  8010e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8010e6:	0f 8c 32 ff ff ff    	jl     80101e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8010ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8010fa:	eb 26                	jmp    801122 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8010fc:	a1 04 40 80 00       	mov    0x804004,%eax
  801101:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801107:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80110a:	89 d0                	mov    %edx,%eax
  80110c:	01 c0                	add    %eax,%eax
  80110e:	01 d0                	add    %edx,%eax
  801110:	c1 e0 02             	shl    $0x2,%eax
  801113:	01 c8                	add    %ecx,%eax
  801115:	8a 40 04             	mov    0x4(%eax),%al
  801118:	3c 01                	cmp    $0x1,%al
  80111a:	75 03                	jne    80111f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80111c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80111f:	ff 45 e0             	incl   -0x20(%ebp)
  801122:	a1 04 40 80 00       	mov    0x804004,%eax
  801127:	8b 50 74             	mov    0x74(%eax),%edx
  80112a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80112d:	39 c2                	cmp    %eax,%edx
  80112f:	77 cb                	ja     8010fc <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801131:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801134:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801137:	74 14                	je     80114d <CheckWSWithoutLastIndex+0x16b>
		panic(
  801139:	83 ec 04             	sub    $0x4,%esp
  80113c:	68 94 2b 80 00       	push   $0x802b94
  801141:	6a 44                	push   $0x44
  801143:	68 34 2b 80 00       	push   $0x802b34
  801148:	e8 23 fe ff ff       	call   800f70 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80114d:	90                   	nop
  80114e:	c9                   	leave  
  80114f:	c3                   	ret    

00801150 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
  801153:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	8b 00                	mov    (%eax),%eax
  80115b:	8d 48 01             	lea    0x1(%eax),%ecx
  80115e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801161:	89 0a                	mov    %ecx,(%edx)
  801163:	8b 55 08             	mov    0x8(%ebp),%edx
  801166:	88 d1                	mov    %dl,%cl
  801168:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80116f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801172:	8b 00                	mov    (%eax),%eax
  801174:	3d ff 00 00 00       	cmp    $0xff,%eax
  801179:	75 2c                	jne    8011a7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80117b:	a0 08 40 80 00       	mov    0x804008,%al
  801180:	0f b6 c0             	movzbl %al,%eax
  801183:	8b 55 0c             	mov    0xc(%ebp),%edx
  801186:	8b 12                	mov    (%edx),%edx
  801188:	89 d1                	mov    %edx,%ecx
  80118a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118d:	83 c2 08             	add    $0x8,%edx
  801190:	83 ec 04             	sub    $0x4,%esp
  801193:	50                   	push   %eax
  801194:	51                   	push   %ecx
  801195:	52                   	push   %edx
  801196:	e8 e0 0e 00 00       	call   80207b <sys_cputs>
  80119b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80119e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8011a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011aa:	8b 40 04             	mov    0x4(%eax),%eax
  8011ad:	8d 50 01             	lea    0x1(%eax),%edx
  8011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8011b6:	90                   	nop
  8011b7:	c9                   	leave  
  8011b8:	c3                   	ret    

008011b9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8011b9:	55                   	push   %ebp
  8011ba:	89 e5                	mov    %esp,%ebp
  8011bc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8011c2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8011c9:	00 00 00 
	b.cnt = 0;
  8011cc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8011d3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8011d6:	ff 75 0c             	pushl  0xc(%ebp)
  8011d9:	ff 75 08             	pushl  0x8(%ebp)
  8011dc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8011e2:	50                   	push   %eax
  8011e3:	68 50 11 80 00       	push   $0x801150
  8011e8:	e8 11 02 00 00       	call   8013fe <vprintfmt>
  8011ed:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8011f0:	a0 08 40 80 00       	mov    0x804008,%al
  8011f5:	0f b6 c0             	movzbl %al,%eax
  8011f8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8011fe:	83 ec 04             	sub    $0x4,%esp
  801201:	50                   	push   %eax
  801202:	52                   	push   %edx
  801203:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801209:	83 c0 08             	add    $0x8,%eax
  80120c:	50                   	push   %eax
  80120d:	e8 69 0e 00 00       	call   80207b <sys_cputs>
  801212:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801215:	c6 05 08 40 80 00 00 	movb   $0x0,0x804008
	return b.cnt;
  80121c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <cprintf>:

int cprintf(const char *fmt, ...) {
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80122a:	c6 05 08 40 80 00 01 	movb   $0x1,0x804008
	va_start(ap, fmt);
  801231:	8d 45 0c             	lea    0xc(%ebp),%eax
  801234:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	83 ec 08             	sub    $0x8,%esp
  80123d:	ff 75 f4             	pushl  -0xc(%ebp)
  801240:	50                   	push   %eax
  801241:	e8 73 ff ff ff       	call   8011b9 <vcprintf>
  801246:	83 c4 10             	add    $0x10,%esp
  801249:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80124c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80124f:	c9                   	leave  
  801250:	c3                   	ret    

00801251 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801251:	55                   	push   %ebp
  801252:	89 e5                	mov    %esp,%ebp
  801254:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801257:	e8 30 10 00 00       	call   80228c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80125c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80125f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	83 ec 08             	sub    $0x8,%esp
  801268:	ff 75 f4             	pushl  -0xc(%ebp)
  80126b:	50                   	push   %eax
  80126c:	e8 48 ff ff ff       	call   8011b9 <vcprintf>
  801271:	83 c4 10             	add    $0x10,%esp
  801274:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801277:	e8 2a 10 00 00       	call   8022a6 <sys_enable_interrupt>
	return cnt;
  80127c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80127f:	c9                   	leave  
  801280:	c3                   	ret    

00801281 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801281:	55                   	push   %ebp
  801282:	89 e5                	mov    %esp,%ebp
  801284:	53                   	push   %ebx
  801285:	83 ec 14             	sub    $0x14,%esp
  801288:	8b 45 10             	mov    0x10(%ebp),%eax
  80128b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80128e:	8b 45 14             	mov    0x14(%ebp),%eax
  801291:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801294:	8b 45 18             	mov    0x18(%ebp),%eax
  801297:	ba 00 00 00 00       	mov    $0x0,%edx
  80129c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80129f:	77 55                	ja     8012f6 <printnum+0x75>
  8012a1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8012a4:	72 05                	jb     8012ab <printnum+0x2a>
  8012a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012a9:	77 4b                	ja     8012f6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8012ab:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8012ae:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8012b1:	8b 45 18             	mov    0x18(%ebp),%eax
  8012b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8012b9:	52                   	push   %edx
  8012ba:	50                   	push   %eax
  8012bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8012be:	ff 75 f0             	pushl  -0x10(%ebp)
  8012c1:	e8 a6 13 00 00       	call   80266c <__udivdi3>
  8012c6:	83 c4 10             	add    $0x10,%esp
  8012c9:	83 ec 04             	sub    $0x4,%esp
  8012cc:	ff 75 20             	pushl  0x20(%ebp)
  8012cf:	53                   	push   %ebx
  8012d0:	ff 75 18             	pushl  0x18(%ebp)
  8012d3:	52                   	push   %edx
  8012d4:	50                   	push   %eax
  8012d5:	ff 75 0c             	pushl  0xc(%ebp)
  8012d8:	ff 75 08             	pushl  0x8(%ebp)
  8012db:	e8 a1 ff ff ff       	call   801281 <printnum>
  8012e0:	83 c4 20             	add    $0x20,%esp
  8012e3:	eb 1a                	jmp    8012ff <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8012e5:	83 ec 08             	sub    $0x8,%esp
  8012e8:	ff 75 0c             	pushl  0xc(%ebp)
  8012eb:	ff 75 20             	pushl  0x20(%ebp)
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	ff d0                	call   *%eax
  8012f3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8012f6:	ff 4d 1c             	decl   0x1c(%ebp)
  8012f9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8012fd:	7f e6                	jg     8012e5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8012ff:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801302:	bb 00 00 00 00       	mov    $0x0,%ebx
  801307:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80130a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80130d:	53                   	push   %ebx
  80130e:	51                   	push   %ecx
  80130f:	52                   	push   %edx
  801310:	50                   	push   %eax
  801311:	e8 66 14 00 00       	call   80277c <__umoddi3>
  801316:	83 c4 10             	add    $0x10,%esp
  801319:	05 f4 2d 80 00       	add    $0x802df4,%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	0f be c0             	movsbl %al,%eax
  801323:	83 ec 08             	sub    $0x8,%esp
  801326:	ff 75 0c             	pushl  0xc(%ebp)
  801329:	50                   	push   %eax
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	ff d0                	call   *%eax
  80132f:	83 c4 10             	add    $0x10,%esp
}
  801332:	90                   	nop
  801333:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80133b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80133f:	7e 1c                	jle    80135d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8b 00                	mov    (%eax),%eax
  801346:	8d 50 08             	lea    0x8(%eax),%edx
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	89 10                	mov    %edx,(%eax)
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8b 00                	mov    (%eax),%eax
  801353:	83 e8 08             	sub    $0x8,%eax
  801356:	8b 50 04             	mov    0x4(%eax),%edx
  801359:	8b 00                	mov    (%eax),%eax
  80135b:	eb 40                	jmp    80139d <getuint+0x65>
	else if (lflag)
  80135d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801361:	74 1e                	je     801381 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	8b 00                	mov    (%eax),%eax
  801368:	8d 50 04             	lea    0x4(%eax),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	89 10                	mov    %edx,(%eax)
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8b 00                	mov    (%eax),%eax
  801375:	83 e8 04             	sub    $0x4,%eax
  801378:	8b 00                	mov    (%eax),%eax
  80137a:	ba 00 00 00 00       	mov    $0x0,%edx
  80137f:	eb 1c                	jmp    80139d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8b 00                	mov    (%eax),%eax
  801386:	8d 50 04             	lea    0x4(%eax),%edx
  801389:	8b 45 08             	mov    0x8(%ebp),%eax
  80138c:	89 10                	mov    %edx,(%eax)
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8b 00                	mov    (%eax),%eax
  801393:	83 e8 04             	sub    $0x4,%eax
  801396:	8b 00                	mov    (%eax),%eax
  801398:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80139d:	5d                   	pop    %ebp
  80139e:	c3                   	ret    

0080139f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8013a2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8013a6:	7e 1c                	jle    8013c4 <getint+0x25>
		return va_arg(*ap, long long);
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8b 00                	mov    (%eax),%eax
  8013ad:	8d 50 08             	lea    0x8(%eax),%edx
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	89 10                	mov    %edx,(%eax)
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8b 00                	mov    (%eax),%eax
  8013ba:	83 e8 08             	sub    $0x8,%eax
  8013bd:	8b 50 04             	mov    0x4(%eax),%edx
  8013c0:	8b 00                	mov    (%eax),%eax
  8013c2:	eb 38                	jmp    8013fc <getint+0x5d>
	else if (lflag)
  8013c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013c8:	74 1a                	je     8013e4 <getint+0x45>
		return va_arg(*ap, long);
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8b 00                	mov    (%eax),%eax
  8013cf:	8d 50 04             	lea    0x4(%eax),%edx
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	89 10                	mov    %edx,(%eax)
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8b 00                	mov    (%eax),%eax
  8013dc:	83 e8 04             	sub    $0x4,%eax
  8013df:	8b 00                	mov    (%eax),%eax
  8013e1:	99                   	cltd   
  8013e2:	eb 18                	jmp    8013fc <getint+0x5d>
	else
		return va_arg(*ap, int);
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8b 00                	mov    (%eax),%eax
  8013e9:	8d 50 04             	lea    0x4(%eax),%edx
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	89 10                	mov    %edx,(%eax)
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8b 00                	mov    (%eax),%eax
  8013f6:	83 e8 04             	sub    $0x4,%eax
  8013f9:	8b 00                	mov    (%eax),%eax
  8013fb:	99                   	cltd   
}
  8013fc:	5d                   	pop    %ebp
  8013fd:	c3                   	ret    

008013fe <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
  801401:	56                   	push   %esi
  801402:	53                   	push   %ebx
  801403:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801406:	eb 17                	jmp    80141f <vprintfmt+0x21>
			if (ch == '\0')
  801408:	85 db                	test   %ebx,%ebx
  80140a:	0f 84 af 03 00 00    	je     8017bf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801410:	83 ec 08             	sub    $0x8,%esp
  801413:	ff 75 0c             	pushl  0xc(%ebp)
  801416:	53                   	push   %ebx
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	ff d0                	call   *%eax
  80141c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80141f:	8b 45 10             	mov    0x10(%ebp),%eax
  801422:	8d 50 01             	lea    0x1(%eax),%edx
  801425:	89 55 10             	mov    %edx,0x10(%ebp)
  801428:	8a 00                	mov    (%eax),%al
  80142a:	0f b6 d8             	movzbl %al,%ebx
  80142d:	83 fb 25             	cmp    $0x25,%ebx
  801430:	75 d6                	jne    801408 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801432:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801436:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80143d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801444:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80144b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801452:	8b 45 10             	mov    0x10(%ebp),%eax
  801455:	8d 50 01             	lea    0x1(%eax),%edx
  801458:	89 55 10             	mov    %edx,0x10(%ebp)
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	0f b6 d8             	movzbl %al,%ebx
  801460:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801463:	83 f8 55             	cmp    $0x55,%eax
  801466:	0f 87 2b 03 00 00    	ja     801797 <vprintfmt+0x399>
  80146c:	8b 04 85 18 2e 80 00 	mov    0x802e18(,%eax,4),%eax
  801473:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801475:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801479:	eb d7                	jmp    801452 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80147b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80147f:	eb d1                	jmp    801452 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801481:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801488:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80148b:	89 d0                	mov    %edx,%eax
  80148d:	c1 e0 02             	shl    $0x2,%eax
  801490:	01 d0                	add    %edx,%eax
  801492:	01 c0                	add    %eax,%eax
  801494:	01 d8                	add    %ebx,%eax
  801496:	83 e8 30             	sub    $0x30,%eax
  801499:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80149c:	8b 45 10             	mov    0x10(%ebp),%eax
  80149f:	8a 00                	mov    (%eax),%al
  8014a1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8014a4:	83 fb 2f             	cmp    $0x2f,%ebx
  8014a7:	7e 3e                	jle    8014e7 <vprintfmt+0xe9>
  8014a9:	83 fb 39             	cmp    $0x39,%ebx
  8014ac:	7f 39                	jg     8014e7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8014ae:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8014b1:	eb d5                	jmp    801488 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8014b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b6:	83 c0 04             	add    $0x4,%eax
  8014b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8014bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8014bf:	83 e8 04             	sub    $0x4,%eax
  8014c2:	8b 00                	mov    (%eax),%eax
  8014c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8014c7:	eb 1f                	jmp    8014e8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8014c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014cd:	79 83                	jns    801452 <vprintfmt+0x54>
				width = 0;
  8014cf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8014d6:	e9 77 ff ff ff       	jmp    801452 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8014db:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8014e2:	e9 6b ff ff ff       	jmp    801452 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8014e7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8014e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014ec:	0f 89 60 ff ff ff    	jns    801452 <vprintfmt+0x54>
				width = precision, precision = -1;
  8014f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8014f8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8014ff:	e9 4e ff ff ff       	jmp    801452 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801504:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801507:	e9 46 ff ff ff       	jmp    801452 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80150c:	8b 45 14             	mov    0x14(%ebp),%eax
  80150f:	83 c0 04             	add    $0x4,%eax
  801512:	89 45 14             	mov    %eax,0x14(%ebp)
  801515:	8b 45 14             	mov    0x14(%ebp),%eax
  801518:	83 e8 04             	sub    $0x4,%eax
  80151b:	8b 00                	mov    (%eax),%eax
  80151d:	83 ec 08             	sub    $0x8,%esp
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	50                   	push   %eax
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	ff d0                	call   *%eax
  801529:	83 c4 10             	add    $0x10,%esp
			break;
  80152c:	e9 89 02 00 00       	jmp    8017ba <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801531:	8b 45 14             	mov    0x14(%ebp),%eax
  801534:	83 c0 04             	add    $0x4,%eax
  801537:	89 45 14             	mov    %eax,0x14(%ebp)
  80153a:	8b 45 14             	mov    0x14(%ebp),%eax
  80153d:	83 e8 04             	sub    $0x4,%eax
  801540:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801542:	85 db                	test   %ebx,%ebx
  801544:	79 02                	jns    801548 <vprintfmt+0x14a>
				err = -err;
  801546:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801548:	83 fb 64             	cmp    $0x64,%ebx
  80154b:	7f 0b                	jg     801558 <vprintfmt+0x15a>
  80154d:	8b 34 9d 60 2c 80 00 	mov    0x802c60(,%ebx,4),%esi
  801554:	85 f6                	test   %esi,%esi
  801556:	75 19                	jne    801571 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801558:	53                   	push   %ebx
  801559:	68 05 2e 80 00       	push   $0x802e05
  80155e:	ff 75 0c             	pushl  0xc(%ebp)
  801561:	ff 75 08             	pushl  0x8(%ebp)
  801564:	e8 5e 02 00 00       	call   8017c7 <printfmt>
  801569:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80156c:	e9 49 02 00 00       	jmp    8017ba <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801571:	56                   	push   %esi
  801572:	68 0e 2e 80 00       	push   $0x802e0e
  801577:	ff 75 0c             	pushl  0xc(%ebp)
  80157a:	ff 75 08             	pushl  0x8(%ebp)
  80157d:	e8 45 02 00 00       	call   8017c7 <printfmt>
  801582:	83 c4 10             	add    $0x10,%esp
			break;
  801585:	e9 30 02 00 00       	jmp    8017ba <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80158a:	8b 45 14             	mov    0x14(%ebp),%eax
  80158d:	83 c0 04             	add    $0x4,%eax
  801590:	89 45 14             	mov    %eax,0x14(%ebp)
  801593:	8b 45 14             	mov    0x14(%ebp),%eax
  801596:	83 e8 04             	sub    $0x4,%eax
  801599:	8b 30                	mov    (%eax),%esi
  80159b:	85 f6                	test   %esi,%esi
  80159d:	75 05                	jne    8015a4 <vprintfmt+0x1a6>
				p = "(null)";
  80159f:	be 11 2e 80 00       	mov    $0x802e11,%esi
			if (width > 0 && padc != '-')
  8015a4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015a8:	7e 6d                	jle    801617 <vprintfmt+0x219>
  8015aa:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8015ae:	74 67                	je     801617 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8015b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015b3:	83 ec 08             	sub    $0x8,%esp
  8015b6:	50                   	push   %eax
  8015b7:	56                   	push   %esi
  8015b8:	e8 0c 03 00 00       	call   8018c9 <strnlen>
  8015bd:	83 c4 10             	add    $0x10,%esp
  8015c0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8015c3:	eb 16                	jmp    8015db <vprintfmt+0x1dd>
					putch(padc, putdat);
  8015c5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8015c9:	83 ec 08             	sub    $0x8,%esp
  8015cc:	ff 75 0c             	pushl  0xc(%ebp)
  8015cf:	50                   	push   %eax
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	ff d0                	call   *%eax
  8015d5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8015d8:	ff 4d e4             	decl   -0x1c(%ebp)
  8015db:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015df:	7f e4                	jg     8015c5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8015e1:	eb 34                	jmp    801617 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8015e3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8015e7:	74 1c                	je     801605 <vprintfmt+0x207>
  8015e9:	83 fb 1f             	cmp    $0x1f,%ebx
  8015ec:	7e 05                	jle    8015f3 <vprintfmt+0x1f5>
  8015ee:	83 fb 7e             	cmp    $0x7e,%ebx
  8015f1:	7e 12                	jle    801605 <vprintfmt+0x207>
					putch('?', putdat);
  8015f3:	83 ec 08             	sub    $0x8,%esp
  8015f6:	ff 75 0c             	pushl  0xc(%ebp)
  8015f9:	6a 3f                	push   $0x3f
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	ff d0                	call   *%eax
  801600:	83 c4 10             	add    $0x10,%esp
  801603:	eb 0f                	jmp    801614 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801605:	83 ec 08             	sub    $0x8,%esp
  801608:	ff 75 0c             	pushl  0xc(%ebp)
  80160b:	53                   	push   %ebx
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	ff d0                	call   *%eax
  801611:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801614:	ff 4d e4             	decl   -0x1c(%ebp)
  801617:	89 f0                	mov    %esi,%eax
  801619:	8d 70 01             	lea    0x1(%eax),%esi
  80161c:	8a 00                	mov    (%eax),%al
  80161e:	0f be d8             	movsbl %al,%ebx
  801621:	85 db                	test   %ebx,%ebx
  801623:	74 24                	je     801649 <vprintfmt+0x24b>
  801625:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801629:	78 b8                	js     8015e3 <vprintfmt+0x1e5>
  80162b:	ff 4d e0             	decl   -0x20(%ebp)
  80162e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801632:	79 af                	jns    8015e3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801634:	eb 13                	jmp    801649 <vprintfmt+0x24b>
				putch(' ', putdat);
  801636:	83 ec 08             	sub    $0x8,%esp
  801639:	ff 75 0c             	pushl  0xc(%ebp)
  80163c:	6a 20                	push   $0x20
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	ff d0                	call   *%eax
  801643:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801646:	ff 4d e4             	decl   -0x1c(%ebp)
  801649:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80164d:	7f e7                	jg     801636 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80164f:	e9 66 01 00 00       	jmp    8017ba <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801654:	83 ec 08             	sub    $0x8,%esp
  801657:	ff 75 e8             	pushl  -0x18(%ebp)
  80165a:	8d 45 14             	lea    0x14(%ebp),%eax
  80165d:	50                   	push   %eax
  80165e:	e8 3c fd ff ff       	call   80139f <getint>
  801663:	83 c4 10             	add    $0x10,%esp
  801666:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801669:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80166c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80166f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801672:	85 d2                	test   %edx,%edx
  801674:	79 23                	jns    801699 <vprintfmt+0x29b>
				putch('-', putdat);
  801676:	83 ec 08             	sub    $0x8,%esp
  801679:	ff 75 0c             	pushl  0xc(%ebp)
  80167c:	6a 2d                	push   $0x2d
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	ff d0                	call   *%eax
  801683:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801686:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801689:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168c:	f7 d8                	neg    %eax
  80168e:	83 d2 00             	adc    $0x0,%edx
  801691:	f7 da                	neg    %edx
  801693:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801696:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801699:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016a0:	e9 bc 00 00 00       	jmp    801761 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8016a5:	83 ec 08             	sub    $0x8,%esp
  8016a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8016ab:	8d 45 14             	lea    0x14(%ebp),%eax
  8016ae:	50                   	push   %eax
  8016af:	e8 84 fc ff ff       	call   801338 <getuint>
  8016b4:	83 c4 10             	add    $0x10,%esp
  8016b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8016bd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8016c4:	e9 98 00 00 00       	jmp    801761 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8016c9:	83 ec 08             	sub    $0x8,%esp
  8016cc:	ff 75 0c             	pushl  0xc(%ebp)
  8016cf:	6a 58                	push   $0x58
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	ff d0                	call   *%eax
  8016d6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8016d9:	83 ec 08             	sub    $0x8,%esp
  8016dc:	ff 75 0c             	pushl  0xc(%ebp)
  8016df:	6a 58                	push   $0x58
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	ff d0                	call   *%eax
  8016e6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8016e9:	83 ec 08             	sub    $0x8,%esp
  8016ec:	ff 75 0c             	pushl  0xc(%ebp)
  8016ef:	6a 58                	push   $0x58
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	ff d0                	call   *%eax
  8016f6:	83 c4 10             	add    $0x10,%esp
			break;
  8016f9:	e9 bc 00 00 00       	jmp    8017ba <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8016fe:	83 ec 08             	sub    $0x8,%esp
  801701:	ff 75 0c             	pushl  0xc(%ebp)
  801704:	6a 30                	push   $0x30
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	ff d0                	call   *%eax
  80170b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80170e:	83 ec 08             	sub    $0x8,%esp
  801711:	ff 75 0c             	pushl  0xc(%ebp)
  801714:	6a 78                	push   $0x78
  801716:	8b 45 08             	mov    0x8(%ebp),%eax
  801719:	ff d0                	call   *%eax
  80171b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80171e:	8b 45 14             	mov    0x14(%ebp),%eax
  801721:	83 c0 04             	add    $0x4,%eax
  801724:	89 45 14             	mov    %eax,0x14(%ebp)
  801727:	8b 45 14             	mov    0x14(%ebp),%eax
  80172a:	83 e8 04             	sub    $0x4,%eax
  80172d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80172f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801732:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801739:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801740:	eb 1f                	jmp    801761 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801742:	83 ec 08             	sub    $0x8,%esp
  801745:	ff 75 e8             	pushl  -0x18(%ebp)
  801748:	8d 45 14             	lea    0x14(%ebp),%eax
  80174b:	50                   	push   %eax
  80174c:	e8 e7 fb ff ff       	call   801338 <getuint>
  801751:	83 c4 10             	add    $0x10,%esp
  801754:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801757:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80175a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801761:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801765:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801768:	83 ec 04             	sub    $0x4,%esp
  80176b:	52                   	push   %edx
  80176c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80176f:	50                   	push   %eax
  801770:	ff 75 f4             	pushl  -0xc(%ebp)
  801773:	ff 75 f0             	pushl  -0x10(%ebp)
  801776:	ff 75 0c             	pushl  0xc(%ebp)
  801779:	ff 75 08             	pushl  0x8(%ebp)
  80177c:	e8 00 fb ff ff       	call   801281 <printnum>
  801781:	83 c4 20             	add    $0x20,%esp
			break;
  801784:	eb 34                	jmp    8017ba <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801786:	83 ec 08             	sub    $0x8,%esp
  801789:	ff 75 0c             	pushl  0xc(%ebp)
  80178c:	53                   	push   %ebx
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
  801790:	ff d0                	call   *%eax
  801792:	83 c4 10             	add    $0x10,%esp
			break;
  801795:	eb 23                	jmp    8017ba <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801797:	83 ec 08             	sub    $0x8,%esp
  80179a:	ff 75 0c             	pushl  0xc(%ebp)
  80179d:	6a 25                	push   $0x25
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	ff d0                	call   *%eax
  8017a4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8017a7:	ff 4d 10             	decl   0x10(%ebp)
  8017aa:	eb 03                	jmp    8017af <vprintfmt+0x3b1>
  8017ac:	ff 4d 10             	decl   0x10(%ebp)
  8017af:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b2:	48                   	dec    %eax
  8017b3:	8a 00                	mov    (%eax),%al
  8017b5:	3c 25                	cmp    $0x25,%al
  8017b7:	75 f3                	jne    8017ac <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8017b9:	90                   	nop
		}
	}
  8017ba:	e9 47 fc ff ff       	jmp    801406 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8017bf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8017c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017c3:	5b                   	pop    %ebx
  8017c4:	5e                   	pop    %esi
  8017c5:	5d                   	pop    %ebp
  8017c6:	c3                   	ret    

008017c7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
  8017ca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8017cd:	8d 45 10             	lea    0x10(%ebp),%eax
  8017d0:	83 c0 04             	add    $0x4,%eax
  8017d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8017d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8017dc:	50                   	push   %eax
  8017dd:	ff 75 0c             	pushl  0xc(%ebp)
  8017e0:	ff 75 08             	pushl  0x8(%ebp)
  8017e3:	e8 16 fc ff ff       	call   8013fe <vprintfmt>
  8017e8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8017eb:	90                   	nop
  8017ec:	c9                   	leave  
  8017ed:	c3                   	ret    

008017ee <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8017ee:	55                   	push   %ebp
  8017ef:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8017f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f4:	8b 40 08             	mov    0x8(%eax),%eax
  8017f7:	8d 50 01             	lea    0x1(%eax),%edx
  8017fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801800:	8b 45 0c             	mov    0xc(%ebp),%eax
  801803:	8b 10                	mov    (%eax),%edx
  801805:	8b 45 0c             	mov    0xc(%ebp),%eax
  801808:	8b 40 04             	mov    0x4(%eax),%eax
  80180b:	39 c2                	cmp    %eax,%edx
  80180d:	73 12                	jae    801821 <sprintputch+0x33>
		*b->buf++ = ch;
  80180f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801812:	8b 00                	mov    (%eax),%eax
  801814:	8d 48 01             	lea    0x1(%eax),%ecx
  801817:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181a:	89 0a                	mov    %ecx,(%edx)
  80181c:	8b 55 08             	mov    0x8(%ebp),%edx
  80181f:	88 10                	mov    %dl,(%eax)
}
  801821:	90                   	nop
  801822:	5d                   	pop    %ebp
  801823:	c3                   	ret    

00801824 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
  801827:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801830:	8b 45 0c             	mov    0xc(%ebp),%eax
  801833:	8d 50 ff             	lea    -0x1(%eax),%edx
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	01 d0                	add    %edx,%eax
  80183b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80183e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801845:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801849:	74 06                	je     801851 <vsnprintf+0x2d>
  80184b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80184f:	7f 07                	jg     801858 <vsnprintf+0x34>
		return -E_INVAL;
  801851:	b8 03 00 00 00       	mov    $0x3,%eax
  801856:	eb 20                	jmp    801878 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801858:	ff 75 14             	pushl  0x14(%ebp)
  80185b:	ff 75 10             	pushl  0x10(%ebp)
  80185e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801861:	50                   	push   %eax
  801862:	68 ee 17 80 00       	push   $0x8017ee
  801867:	e8 92 fb ff ff       	call   8013fe <vprintfmt>
  80186c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80186f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801872:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801875:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801878:	c9                   	leave  
  801879:	c3                   	ret    

0080187a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
  80187d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801880:	8d 45 10             	lea    0x10(%ebp),%eax
  801883:	83 c0 04             	add    $0x4,%eax
  801886:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801889:	8b 45 10             	mov    0x10(%ebp),%eax
  80188c:	ff 75 f4             	pushl  -0xc(%ebp)
  80188f:	50                   	push   %eax
  801890:	ff 75 0c             	pushl  0xc(%ebp)
  801893:	ff 75 08             	pushl  0x8(%ebp)
  801896:	e8 89 ff ff ff       	call   801824 <vsnprintf>
  80189b:	83 c4 10             	add    $0x10,%esp
  80189e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8018a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
  8018a9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8018ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018b3:	eb 06                	jmp    8018bb <strlen+0x15>
		n++;
  8018b5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8018b8:	ff 45 08             	incl   0x8(%ebp)
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	8a 00                	mov    (%eax),%al
  8018c0:	84 c0                	test   %al,%al
  8018c2:	75 f1                	jne    8018b5 <strlen+0xf>
		n++;
	return n;
  8018c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018c7:	c9                   	leave  
  8018c8:	c3                   	ret    

008018c9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8018c9:	55                   	push   %ebp
  8018ca:	89 e5                	mov    %esp,%ebp
  8018cc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018d6:	eb 09                	jmp    8018e1 <strnlen+0x18>
		n++;
  8018d8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8018db:	ff 45 08             	incl   0x8(%ebp)
  8018de:	ff 4d 0c             	decl   0xc(%ebp)
  8018e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018e5:	74 09                	je     8018f0 <strnlen+0x27>
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	8a 00                	mov    (%eax),%al
  8018ec:	84 c0                	test   %al,%al
  8018ee:	75 e8                	jne    8018d8 <strnlen+0xf>
		n++;
	return n;
  8018f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
  8018f8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801901:	90                   	nop
  801902:	8b 45 08             	mov    0x8(%ebp),%eax
  801905:	8d 50 01             	lea    0x1(%eax),%edx
  801908:	89 55 08             	mov    %edx,0x8(%ebp)
  80190b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801911:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801914:	8a 12                	mov    (%edx),%dl
  801916:	88 10                	mov    %dl,(%eax)
  801918:	8a 00                	mov    (%eax),%al
  80191a:	84 c0                	test   %al,%al
  80191c:	75 e4                	jne    801902 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80191e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801929:	8b 45 08             	mov    0x8(%ebp),%eax
  80192c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80192f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801936:	eb 1f                	jmp    801957 <strncpy+0x34>
		*dst++ = *src;
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	8d 50 01             	lea    0x1(%eax),%edx
  80193e:	89 55 08             	mov    %edx,0x8(%ebp)
  801941:	8b 55 0c             	mov    0xc(%ebp),%edx
  801944:	8a 12                	mov    (%edx),%dl
  801946:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194b:	8a 00                	mov    (%eax),%al
  80194d:	84 c0                	test   %al,%al
  80194f:	74 03                	je     801954 <strncpy+0x31>
			src++;
  801951:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801954:	ff 45 fc             	incl   -0x4(%ebp)
  801957:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80195a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80195d:	72 d9                	jb     801938 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80195f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
  801967:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80196a:	8b 45 08             	mov    0x8(%ebp),%eax
  80196d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801970:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801974:	74 30                	je     8019a6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801976:	eb 16                	jmp    80198e <strlcpy+0x2a>
			*dst++ = *src++;
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	8d 50 01             	lea    0x1(%eax),%edx
  80197e:	89 55 08             	mov    %edx,0x8(%ebp)
  801981:	8b 55 0c             	mov    0xc(%ebp),%edx
  801984:	8d 4a 01             	lea    0x1(%edx),%ecx
  801987:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80198a:	8a 12                	mov    (%edx),%dl
  80198c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80198e:	ff 4d 10             	decl   0x10(%ebp)
  801991:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801995:	74 09                	je     8019a0 <strlcpy+0x3c>
  801997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199a:	8a 00                	mov    (%eax),%al
  80199c:	84 c0                	test   %al,%al
  80199e:	75 d8                	jne    801978 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8019a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8019a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ac:	29 c2                	sub    %eax,%edx
  8019ae:	89 d0                	mov    %edx,%eax
}
  8019b0:	c9                   	leave  
  8019b1:	c3                   	ret    

008019b2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8019b5:	eb 06                	jmp    8019bd <strcmp+0xb>
		p++, q++;
  8019b7:	ff 45 08             	incl   0x8(%ebp)
  8019ba:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8019bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c0:	8a 00                	mov    (%eax),%al
  8019c2:	84 c0                	test   %al,%al
  8019c4:	74 0e                	je     8019d4 <strcmp+0x22>
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	8a 10                	mov    (%eax),%dl
  8019cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ce:	8a 00                	mov    (%eax),%al
  8019d0:	38 c2                	cmp    %al,%dl
  8019d2:	74 e3                	je     8019b7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	8a 00                	mov    (%eax),%al
  8019d9:	0f b6 d0             	movzbl %al,%edx
  8019dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019df:	8a 00                	mov    (%eax),%al
  8019e1:	0f b6 c0             	movzbl %al,%eax
  8019e4:	29 c2                	sub    %eax,%edx
  8019e6:	89 d0                	mov    %edx,%eax
}
  8019e8:	5d                   	pop    %ebp
  8019e9:	c3                   	ret    

008019ea <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8019ed:	eb 09                	jmp    8019f8 <strncmp+0xe>
		n--, p++, q++;
  8019ef:	ff 4d 10             	decl   0x10(%ebp)
  8019f2:	ff 45 08             	incl   0x8(%ebp)
  8019f5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8019f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019fc:	74 17                	je     801a15 <strncmp+0x2b>
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	8a 00                	mov    (%eax),%al
  801a03:	84 c0                	test   %al,%al
  801a05:	74 0e                	je     801a15 <strncmp+0x2b>
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	8a 10                	mov    (%eax),%dl
  801a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0f:	8a 00                	mov    (%eax),%al
  801a11:	38 c2                	cmp    %al,%dl
  801a13:	74 da                	je     8019ef <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801a15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a19:	75 07                	jne    801a22 <strncmp+0x38>
		return 0;
  801a1b:	b8 00 00 00 00       	mov    $0x0,%eax
  801a20:	eb 14                	jmp    801a36 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801a22:	8b 45 08             	mov    0x8(%ebp),%eax
  801a25:	8a 00                	mov    (%eax),%al
  801a27:	0f b6 d0             	movzbl %al,%edx
  801a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2d:	8a 00                	mov    (%eax),%al
  801a2f:	0f b6 c0             	movzbl %al,%eax
  801a32:	29 c2                	sub    %eax,%edx
  801a34:	89 d0                	mov    %edx,%eax
}
  801a36:	5d                   	pop    %ebp
  801a37:	c3                   	ret    

00801a38 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 04             	sub    $0x4,%esp
  801a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a41:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a44:	eb 12                	jmp    801a58 <strchr+0x20>
		if (*s == c)
  801a46:	8b 45 08             	mov    0x8(%ebp),%eax
  801a49:	8a 00                	mov    (%eax),%al
  801a4b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a4e:	75 05                	jne    801a55 <strchr+0x1d>
			return (char *) s;
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	eb 11                	jmp    801a66 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801a55:	ff 45 08             	incl   0x8(%ebp)
  801a58:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5b:	8a 00                	mov    (%eax),%al
  801a5d:	84 c0                	test   %al,%al
  801a5f:	75 e5                	jne    801a46 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801a61:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
  801a6b:	83 ec 04             	sub    $0x4,%esp
  801a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a71:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a74:	eb 0d                	jmp    801a83 <strfind+0x1b>
		if (*s == c)
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	8a 00                	mov    (%eax),%al
  801a7b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a7e:	74 0e                	je     801a8e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801a80:	ff 45 08             	incl   0x8(%ebp)
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	8a 00                	mov    (%eax),%al
  801a88:	84 c0                	test   %al,%al
  801a8a:	75 ea                	jne    801a76 <strfind+0xe>
  801a8c:	eb 01                	jmp    801a8f <strfind+0x27>
		if (*s == c)
			break;
  801a8e:	90                   	nop
	return (char *) s;
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a92:	c9                   	leave  
  801a93:	c3                   	ret    

00801a94 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
  801a97:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801aa0:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801aa6:	eb 0e                	jmp    801ab6 <memset+0x22>
		*p++ = c;
  801aa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aab:	8d 50 01             	lea    0x1(%eax),%edx
  801aae:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801ab6:	ff 4d f8             	decl   -0x8(%ebp)
  801ab9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801abd:	79 e9                	jns    801aa8 <memset+0x14>
		*p++ = c;

	return v;
  801abf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
  801ac7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801acd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801ad6:	eb 16                	jmp    801aee <memcpy+0x2a>
		*d++ = *s++;
  801ad8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801adb:	8d 50 01             	lea    0x1(%eax),%edx
  801ade:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801ae1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae4:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ae7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801aea:	8a 12                	mov    (%edx),%dl
  801aec:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801aee:	8b 45 10             	mov    0x10(%ebp),%eax
  801af1:	8d 50 ff             	lea    -0x1(%eax),%edx
  801af4:	89 55 10             	mov    %edx,0x10(%ebp)
  801af7:	85 c0                	test   %eax,%eax
  801af9:	75 dd                	jne    801ad8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801afb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
  801b03:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801b12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b15:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b18:	73 50                	jae    801b6a <memmove+0x6a>
  801b1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b1d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b20:	01 d0                	add    %edx,%eax
  801b22:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801b25:	76 43                	jbe    801b6a <memmove+0x6a>
		s += n;
  801b27:	8b 45 10             	mov    0x10(%ebp),%eax
  801b2a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b30:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801b33:	eb 10                	jmp    801b45 <memmove+0x45>
			*--d = *--s;
  801b35:	ff 4d f8             	decl   -0x8(%ebp)
  801b38:	ff 4d fc             	decl   -0x4(%ebp)
  801b3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b3e:	8a 10                	mov    (%eax),%dl
  801b40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b43:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801b45:	8b 45 10             	mov    0x10(%ebp),%eax
  801b48:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b4b:	89 55 10             	mov    %edx,0x10(%ebp)
  801b4e:	85 c0                	test   %eax,%eax
  801b50:	75 e3                	jne    801b35 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801b52:	eb 23                	jmp    801b77 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801b54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b57:	8d 50 01             	lea    0x1(%eax),%edx
  801b5a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b60:	8d 4a 01             	lea    0x1(%edx),%ecx
  801b63:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801b66:	8a 12                	mov    (%edx),%dl
  801b68:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801b6a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b70:	89 55 10             	mov    %edx,0x10(%ebp)
  801b73:	85 c0                	test   %eax,%eax
  801b75:	75 dd                	jne    801b54 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b7a:	c9                   	leave  
  801b7b:	c3                   	ret    

00801b7c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801b7c:	55                   	push   %ebp
  801b7d:	89 e5                	mov    %esp,%ebp
  801b7f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b8b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801b8e:	eb 2a                	jmp    801bba <memcmp+0x3e>
		if (*s1 != *s2)
  801b90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b93:	8a 10                	mov    (%eax),%dl
  801b95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b98:	8a 00                	mov    (%eax),%al
  801b9a:	38 c2                	cmp    %al,%dl
  801b9c:	74 16                	je     801bb4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801b9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ba1:	8a 00                	mov    (%eax),%al
  801ba3:	0f b6 d0             	movzbl %al,%edx
  801ba6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ba9:	8a 00                	mov    (%eax),%al
  801bab:	0f b6 c0             	movzbl %al,%eax
  801bae:	29 c2                	sub    %eax,%edx
  801bb0:	89 d0                	mov    %edx,%eax
  801bb2:	eb 18                	jmp    801bcc <memcmp+0x50>
		s1++, s2++;
  801bb4:	ff 45 fc             	incl   -0x4(%ebp)
  801bb7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801bba:	8b 45 10             	mov    0x10(%ebp),%eax
  801bbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801bc0:	89 55 10             	mov    %edx,0x10(%ebp)
  801bc3:	85 c0                	test   %eax,%eax
  801bc5:	75 c9                	jne    801b90 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801bc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bcc:	c9                   	leave  
  801bcd:	c3                   	ret    

00801bce <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801bce:	55                   	push   %ebp
  801bcf:	89 e5                	mov    %esp,%ebp
  801bd1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801bd4:	8b 55 08             	mov    0x8(%ebp),%edx
  801bd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801bda:	01 d0                	add    %edx,%eax
  801bdc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801bdf:	eb 15                	jmp    801bf6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801be1:	8b 45 08             	mov    0x8(%ebp),%eax
  801be4:	8a 00                	mov    (%eax),%al
  801be6:	0f b6 d0             	movzbl %al,%edx
  801be9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bec:	0f b6 c0             	movzbl %al,%eax
  801bef:	39 c2                	cmp    %eax,%edx
  801bf1:	74 0d                	je     801c00 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801bf3:	ff 45 08             	incl   0x8(%ebp)
  801bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801bfc:	72 e3                	jb     801be1 <memfind+0x13>
  801bfe:	eb 01                	jmp    801c01 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801c00:	90                   	nop
	return (void *) s;
  801c01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801c04:	c9                   	leave  
  801c05:	c3                   	ret    

00801c06 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801c06:	55                   	push   %ebp
  801c07:	89 e5                	mov    %esp,%ebp
  801c09:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801c0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801c13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c1a:	eb 03                	jmp    801c1f <strtol+0x19>
		s++;
  801c1c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c22:	8a 00                	mov    (%eax),%al
  801c24:	3c 20                	cmp    $0x20,%al
  801c26:	74 f4                	je     801c1c <strtol+0x16>
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	8a 00                	mov    (%eax),%al
  801c2d:	3c 09                	cmp    $0x9,%al
  801c2f:	74 eb                	je     801c1c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801c31:	8b 45 08             	mov    0x8(%ebp),%eax
  801c34:	8a 00                	mov    (%eax),%al
  801c36:	3c 2b                	cmp    $0x2b,%al
  801c38:	75 05                	jne    801c3f <strtol+0x39>
		s++;
  801c3a:	ff 45 08             	incl   0x8(%ebp)
  801c3d:	eb 13                	jmp    801c52 <strtol+0x4c>
	else if (*s == '-')
  801c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c42:	8a 00                	mov    (%eax),%al
  801c44:	3c 2d                	cmp    $0x2d,%al
  801c46:	75 0a                	jne    801c52 <strtol+0x4c>
		s++, neg = 1;
  801c48:	ff 45 08             	incl   0x8(%ebp)
  801c4b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801c52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c56:	74 06                	je     801c5e <strtol+0x58>
  801c58:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801c5c:	75 20                	jne    801c7e <strtol+0x78>
  801c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c61:	8a 00                	mov    (%eax),%al
  801c63:	3c 30                	cmp    $0x30,%al
  801c65:	75 17                	jne    801c7e <strtol+0x78>
  801c67:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6a:	40                   	inc    %eax
  801c6b:	8a 00                	mov    (%eax),%al
  801c6d:	3c 78                	cmp    $0x78,%al
  801c6f:	75 0d                	jne    801c7e <strtol+0x78>
		s += 2, base = 16;
  801c71:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801c75:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801c7c:	eb 28                	jmp    801ca6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801c7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c82:	75 15                	jne    801c99 <strtol+0x93>
  801c84:	8b 45 08             	mov    0x8(%ebp),%eax
  801c87:	8a 00                	mov    (%eax),%al
  801c89:	3c 30                	cmp    $0x30,%al
  801c8b:	75 0c                	jne    801c99 <strtol+0x93>
		s++, base = 8;
  801c8d:	ff 45 08             	incl   0x8(%ebp)
  801c90:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801c97:	eb 0d                	jmp    801ca6 <strtol+0xa0>
	else if (base == 0)
  801c99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c9d:	75 07                	jne    801ca6 <strtol+0xa0>
		base = 10;
  801c9f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca9:	8a 00                	mov    (%eax),%al
  801cab:	3c 2f                	cmp    $0x2f,%al
  801cad:	7e 19                	jle    801cc8 <strtol+0xc2>
  801caf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb2:	8a 00                	mov    (%eax),%al
  801cb4:	3c 39                	cmp    $0x39,%al
  801cb6:	7f 10                	jg     801cc8 <strtol+0xc2>
			dig = *s - '0';
  801cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbb:	8a 00                	mov    (%eax),%al
  801cbd:	0f be c0             	movsbl %al,%eax
  801cc0:	83 e8 30             	sub    $0x30,%eax
  801cc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801cc6:	eb 42                	jmp    801d0a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccb:	8a 00                	mov    (%eax),%al
  801ccd:	3c 60                	cmp    $0x60,%al
  801ccf:	7e 19                	jle    801cea <strtol+0xe4>
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	8a 00                	mov    (%eax),%al
  801cd6:	3c 7a                	cmp    $0x7a,%al
  801cd8:	7f 10                	jg     801cea <strtol+0xe4>
			dig = *s - 'a' + 10;
  801cda:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdd:	8a 00                	mov    (%eax),%al
  801cdf:	0f be c0             	movsbl %al,%eax
  801ce2:	83 e8 57             	sub    $0x57,%eax
  801ce5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ce8:	eb 20                	jmp    801d0a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801cea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ced:	8a 00                	mov    (%eax),%al
  801cef:	3c 40                	cmp    $0x40,%al
  801cf1:	7e 39                	jle    801d2c <strtol+0x126>
  801cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf6:	8a 00                	mov    (%eax),%al
  801cf8:	3c 5a                	cmp    $0x5a,%al
  801cfa:	7f 30                	jg     801d2c <strtol+0x126>
			dig = *s - 'A' + 10;
  801cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cff:	8a 00                	mov    (%eax),%al
  801d01:	0f be c0             	movsbl %al,%eax
  801d04:	83 e8 37             	sub    $0x37,%eax
  801d07:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801d0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d0d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801d10:	7d 19                	jge    801d2b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801d12:	ff 45 08             	incl   0x8(%ebp)
  801d15:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d18:	0f af 45 10          	imul   0x10(%ebp),%eax
  801d1c:	89 c2                	mov    %eax,%edx
  801d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d21:	01 d0                	add    %edx,%eax
  801d23:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801d26:	e9 7b ff ff ff       	jmp    801ca6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801d2b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801d2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d30:	74 08                	je     801d3a <strtol+0x134>
		*endptr = (char *) s;
  801d32:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d35:	8b 55 08             	mov    0x8(%ebp),%edx
  801d38:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801d3a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d3e:	74 07                	je     801d47 <strtol+0x141>
  801d40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d43:	f7 d8                	neg    %eax
  801d45:	eb 03                	jmp    801d4a <strtol+0x144>
  801d47:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801d4a:	c9                   	leave  
  801d4b:	c3                   	ret    

00801d4c <ltostr>:

void
ltostr(long value, char *str)
{
  801d4c:	55                   	push   %ebp
  801d4d:	89 e5                	mov    %esp,%ebp
  801d4f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801d52:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801d59:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801d60:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d64:	79 13                	jns    801d79 <ltostr+0x2d>
	{
		neg = 1;
  801d66:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801d6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d70:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801d73:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801d76:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801d79:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801d81:	99                   	cltd   
  801d82:	f7 f9                	idiv   %ecx
  801d84:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801d87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d8a:	8d 50 01             	lea    0x1(%eax),%edx
  801d8d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801d90:	89 c2                	mov    %eax,%edx
  801d92:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d95:	01 d0                	add    %edx,%eax
  801d97:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d9a:	83 c2 30             	add    $0x30,%edx
  801d9d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801d9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801da2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801da7:	f7 e9                	imul   %ecx
  801da9:	c1 fa 02             	sar    $0x2,%edx
  801dac:	89 c8                	mov    %ecx,%eax
  801dae:	c1 f8 1f             	sar    $0x1f,%eax
  801db1:	29 c2                	sub    %eax,%edx
  801db3:	89 d0                	mov    %edx,%eax
  801db5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801db8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801dbb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801dc0:	f7 e9                	imul   %ecx
  801dc2:	c1 fa 02             	sar    $0x2,%edx
  801dc5:	89 c8                	mov    %ecx,%eax
  801dc7:	c1 f8 1f             	sar    $0x1f,%eax
  801dca:	29 c2                	sub    %eax,%edx
  801dcc:	89 d0                	mov    %edx,%eax
  801dce:	c1 e0 02             	shl    $0x2,%eax
  801dd1:	01 d0                	add    %edx,%eax
  801dd3:	01 c0                	add    %eax,%eax
  801dd5:	29 c1                	sub    %eax,%ecx
  801dd7:	89 ca                	mov    %ecx,%edx
  801dd9:	85 d2                	test   %edx,%edx
  801ddb:	75 9c                	jne    801d79 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801ddd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801de4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801de7:	48                   	dec    %eax
  801de8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801deb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801def:	74 3d                	je     801e2e <ltostr+0xe2>
		start = 1 ;
  801df1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801df8:	eb 34                	jmp    801e2e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801dfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e00:	01 d0                	add    %edx,%eax
  801e02:	8a 00                	mov    (%eax),%al
  801e04:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801e07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e0d:	01 c2                	add    %eax,%edx
  801e0f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801e12:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e15:	01 c8                	add    %ecx,%eax
  801e17:	8a 00                	mov    (%eax),%al
  801e19:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801e1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e21:	01 c2                	add    %eax,%edx
  801e23:	8a 45 eb             	mov    -0x15(%ebp),%al
  801e26:	88 02                	mov    %al,(%edx)
		start++ ;
  801e28:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801e2b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e31:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e34:	7c c4                	jl     801dfa <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801e36:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801e39:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e3c:	01 d0                	add    %edx,%eax
  801e3e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801e41:	90                   	nop
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
  801e47:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801e4a:	ff 75 08             	pushl  0x8(%ebp)
  801e4d:	e8 54 fa ff ff       	call   8018a6 <strlen>
  801e52:	83 c4 04             	add    $0x4,%esp
  801e55:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801e58:	ff 75 0c             	pushl  0xc(%ebp)
  801e5b:	e8 46 fa ff ff       	call   8018a6 <strlen>
  801e60:	83 c4 04             	add    $0x4,%esp
  801e63:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801e66:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801e6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e74:	eb 17                	jmp    801e8d <strcconcat+0x49>
		final[s] = str1[s] ;
  801e76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e79:	8b 45 10             	mov    0x10(%ebp),%eax
  801e7c:	01 c2                	add    %eax,%edx
  801e7e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e81:	8b 45 08             	mov    0x8(%ebp),%eax
  801e84:	01 c8                	add    %ecx,%eax
  801e86:	8a 00                	mov    (%eax),%al
  801e88:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801e8a:	ff 45 fc             	incl   -0x4(%ebp)
  801e8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e90:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e93:	7c e1                	jl     801e76 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801e95:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801e9c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ea3:	eb 1f                	jmp    801ec4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ea5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ea8:	8d 50 01             	lea    0x1(%eax),%edx
  801eab:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801eae:	89 c2                	mov    %eax,%edx
  801eb0:	8b 45 10             	mov    0x10(%ebp),%eax
  801eb3:	01 c2                	add    %eax,%edx
  801eb5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ebb:	01 c8                	add    %ecx,%eax
  801ebd:	8a 00                	mov    (%eax),%al
  801ebf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ec1:	ff 45 f8             	incl   -0x8(%ebp)
  801ec4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ec7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801eca:	7c d9                	jl     801ea5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ecc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ecf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ed2:	01 d0                	add    %edx,%eax
  801ed4:	c6 00 00             	movb   $0x0,(%eax)
}
  801ed7:	90                   	nop
  801ed8:	c9                   	leave  
  801ed9:	c3                   	ret    

00801eda <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801eda:	55                   	push   %ebp
  801edb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801edd:	8b 45 14             	mov    0x14(%ebp),%eax
  801ee0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ee6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ee9:	8b 00                	mov    (%eax),%eax
  801eeb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ef2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ef5:	01 d0                	add    %edx,%eax
  801ef7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801efd:	eb 0c                	jmp    801f0b <strsplit+0x31>
			*string++ = 0;
  801eff:	8b 45 08             	mov    0x8(%ebp),%eax
  801f02:	8d 50 01             	lea    0x1(%eax),%edx
  801f05:	89 55 08             	mov    %edx,0x8(%ebp)
  801f08:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0e:	8a 00                	mov    (%eax),%al
  801f10:	84 c0                	test   %al,%al
  801f12:	74 18                	je     801f2c <strsplit+0x52>
  801f14:	8b 45 08             	mov    0x8(%ebp),%eax
  801f17:	8a 00                	mov    (%eax),%al
  801f19:	0f be c0             	movsbl %al,%eax
  801f1c:	50                   	push   %eax
  801f1d:	ff 75 0c             	pushl  0xc(%ebp)
  801f20:	e8 13 fb ff ff       	call   801a38 <strchr>
  801f25:	83 c4 08             	add    $0x8,%esp
  801f28:	85 c0                	test   %eax,%eax
  801f2a:	75 d3                	jne    801eff <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2f:	8a 00                	mov    (%eax),%al
  801f31:	84 c0                	test   %al,%al
  801f33:	74 5a                	je     801f8f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801f35:	8b 45 14             	mov    0x14(%ebp),%eax
  801f38:	8b 00                	mov    (%eax),%eax
  801f3a:	83 f8 0f             	cmp    $0xf,%eax
  801f3d:	75 07                	jne    801f46 <strsplit+0x6c>
		{
			return 0;
  801f3f:	b8 00 00 00 00       	mov    $0x0,%eax
  801f44:	eb 66                	jmp    801fac <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801f46:	8b 45 14             	mov    0x14(%ebp),%eax
  801f49:	8b 00                	mov    (%eax),%eax
  801f4b:	8d 48 01             	lea    0x1(%eax),%ecx
  801f4e:	8b 55 14             	mov    0x14(%ebp),%edx
  801f51:	89 0a                	mov    %ecx,(%edx)
  801f53:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  801f5d:	01 c2                	add    %eax,%edx
  801f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f62:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f64:	eb 03                	jmp    801f69 <strsplit+0x8f>
			string++;
  801f66:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	8a 00                	mov    (%eax),%al
  801f6e:	84 c0                	test   %al,%al
  801f70:	74 8b                	je     801efd <strsplit+0x23>
  801f72:	8b 45 08             	mov    0x8(%ebp),%eax
  801f75:	8a 00                	mov    (%eax),%al
  801f77:	0f be c0             	movsbl %al,%eax
  801f7a:	50                   	push   %eax
  801f7b:	ff 75 0c             	pushl  0xc(%ebp)
  801f7e:	e8 b5 fa ff ff       	call   801a38 <strchr>
  801f83:	83 c4 08             	add    $0x8,%esp
  801f86:	85 c0                	test   %eax,%eax
  801f88:	74 dc                	je     801f66 <strsplit+0x8c>
			string++;
	}
  801f8a:	e9 6e ff ff ff       	jmp    801efd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801f8f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801f90:	8b 45 14             	mov    0x14(%ebp),%eax
  801f93:	8b 00                	mov    (%eax),%eax
  801f95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f9f:	01 d0                	add    %edx,%eax
  801fa1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801fa7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
  801fb1:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801fb4:	83 ec 04             	sub    $0x4,%esp
  801fb7:	68 70 2f 80 00       	push   $0x802f70
  801fbc:	6a 19                	push   $0x19
  801fbe:	68 95 2f 80 00       	push   $0x802f95
  801fc3:	e8 a8 ef ff ff       	call   800f70 <_panic>

00801fc8 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
  801fcb:	83 ec 18             	sub    $0x18,%esp
  801fce:	8b 45 10             	mov    0x10(%ebp),%eax
  801fd1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801fd4:	83 ec 04             	sub    $0x4,%esp
  801fd7:	68 a4 2f 80 00       	push   $0x802fa4
  801fdc:	6a 30                	push   $0x30
  801fde:	68 95 2f 80 00       	push   $0x802f95
  801fe3:	e8 88 ef ff ff       	call   800f70 <_panic>

00801fe8 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801fe8:	55                   	push   %ebp
  801fe9:	89 e5                	mov    %esp,%ebp
  801feb:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801fee:	83 ec 04             	sub    $0x4,%esp
  801ff1:	68 c3 2f 80 00       	push   $0x802fc3
  801ff6:	6a 36                	push   $0x36
  801ff8:	68 95 2f 80 00       	push   $0x802f95
  801ffd:	e8 6e ef ff ff       	call   800f70 <_panic>

00802002 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802002:	55                   	push   %ebp
  802003:	89 e5                	mov    %esp,%ebp
  802005:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  802008:	83 ec 04             	sub    $0x4,%esp
  80200b:	68 e0 2f 80 00       	push   $0x802fe0
  802010:	6a 48                	push   $0x48
  802012:	68 95 2f 80 00       	push   $0x802f95
  802017:	e8 54 ef ff ff       	call   800f70 <_panic>

0080201c <sfree>:

}


void sfree(void* virtual_address)
{
  80201c:	55                   	push   %ebp
  80201d:	89 e5                	mov    %esp,%ebp
  80201f:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  802022:	83 ec 04             	sub    $0x4,%esp
  802025:	68 03 30 80 00       	push   $0x803003
  80202a:	6a 53                	push   $0x53
  80202c:	68 95 2f 80 00       	push   $0x802f95
  802031:	e8 3a ef ff ff       	call   800f70 <_panic>

00802036 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
  802039:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80203c:	83 ec 04             	sub    $0x4,%esp
  80203f:	68 20 30 80 00       	push   $0x803020
  802044:	6a 6c                	push   $0x6c
  802046:	68 95 2f 80 00       	push   $0x802f95
  80204b:	e8 20 ef ff ff       	call   800f70 <_panic>

00802050 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802050:	55                   	push   %ebp
  802051:	89 e5                	mov    %esp,%ebp
  802053:	57                   	push   %edi
  802054:	56                   	push   %esi
  802055:	53                   	push   %ebx
  802056:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80205f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802062:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802065:	8b 7d 18             	mov    0x18(%ebp),%edi
  802068:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80206b:	cd 30                	int    $0x30
  80206d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802070:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802073:	83 c4 10             	add    $0x10,%esp
  802076:	5b                   	pop    %ebx
  802077:	5e                   	pop    %esi
  802078:	5f                   	pop    %edi
  802079:	5d                   	pop    %ebp
  80207a:	c3                   	ret    

0080207b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
  80207e:	83 ec 04             	sub    $0x4,%esp
  802081:	8b 45 10             	mov    0x10(%ebp),%eax
  802084:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802087:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80208b:	8b 45 08             	mov    0x8(%ebp),%eax
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	52                   	push   %edx
  802093:	ff 75 0c             	pushl  0xc(%ebp)
  802096:	50                   	push   %eax
  802097:	6a 00                	push   $0x0
  802099:	e8 b2 ff ff ff       	call   802050 <syscall>
  80209e:	83 c4 18             	add    $0x18,%esp
}
  8020a1:	90                   	nop
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 01                	push   $0x1
  8020b3:	e8 98 ff ff ff       	call   802050 <syscall>
  8020b8:	83 c4 18             	add    $0x18,%esp
}
  8020bb:	c9                   	leave  
  8020bc:	c3                   	ret    

008020bd <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8020bd:	55                   	push   %ebp
  8020be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8020c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	50                   	push   %eax
  8020cc:	6a 05                	push   $0x5
  8020ce:	e8 7d ff ff ff       	call   802050 <syscall>
  8020d3:	83 c4 18             	add    $0x18,%esp
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 02                	push   $0x2
  8020e7:	e8 64 ff ff ff       	call   802050 <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
}
  8020ef:	c9                   	leave  
  8020f0:	c3                   	ret    

008020f1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8020f1:	55                   	push   %ebp
  8020f2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 03                	push   $0x3
  802100:	e8 4b ff ff ff       	call   802050 <syscall>
  802105:	83 c4 18             	add    $0x18,%esp
}
  802108:	c9                   	leave  
  802109:	c3                   	ret    

0080210a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80210a:	55                   	push   %ebp
  80210b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 04                	push   $0x4
  802119:	e8 32 ff ff ff       	call   802050 <syscall>
  80211e:	83 c4 18             	add    $0x18,%esp
}
  802121:	c9                   	leave  
  802122:	c3                   	ret    

00802123 <sys_env_exit>:


void sys_env_exit(void)
{
  802123:	55                   	push   %ebp
  802124:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 06                	push   $0x6
  802132:	e8 19 ff ff ff       	call   802050 <syscall>
  802137:	83 c4 18             	add    $0x18,%esp
}
  80213a:	90                   	nop
  80213b:	c9                   	leave  
  80213c:	c3                   	ret    

0080213d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80213d:	55                   	push   %ebp
  80213e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802140:	8b 55 0c             	mov    0xc(%ebp),%edx
  802143:	8b 45 08             	mov    0x8(%ebp),%eax
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	52                   	push   %edx
  80214d:	50                   	push   %eax
  80214e:	6a 07                	push   $0x7
  802150:	e8 fb fe ff ff       	call   802050 <syscall>
  802155:	83 c4 18             	add    $0x18,%esp
}
  802158:	c9                   	leave  
  802159:	c3                   	ret    

0080215a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80215a:	55                   	push   %ebp
  80215b:	89 e5                	mov    %esp,%ebp
  80215d:	56                   	push   %esi
  80215e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80215f:	8b 75 18             	mov    0x18(%ebp),%esi
  802162:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802165:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802168:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216b:	8b 45 08             	mov    0x8(%ebp),%eax
  80216e:	56                   	push   %esi
  80216f:	53                   	push   %ebx
  802170:	51                   	push   %ecx
  802171:	52                   	push   %edx
  802172:	50                   	push   %eax
  802173:	6a 08                	push   $0x8
  802175:	e8 d6 fe ff ff       	call   802050 <syscall>
  80217a:	83 c4 18             	add    $0x18,%esp
}
  80217d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802180:	5b                   	pop    %ebx
  802181:	5e                   	pop    %esi
  802182:	5d                   	pop    %ebp
  802183:	c3                   	ret    

00802184 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802184:	55                   	push   %ebp
  802185:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802187:	8b 55 0c             	mov    0xc(%ebp),%edx
  80218a:	8b 45 08             	mov    0x8(%ebp),%eax
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	52                   	push   %edx
  802194:	50                   	push   %eax
  802195:	6a 09                	push   $0x9
  802197:	e8 b4 fe ff ff       	call   802050 <syscall>
  80219c:	83 c4 18             	add    $0x18,%esp
}
  80219f:	c9                   	leave  
  8021a0:	c3                   	ret    

008021a1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8021a1:	55                   	push   %ebp
  8021a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	ff 75 0c             	pushl  0xc(%ebp)
  8021ad:	ff 75 08             	pushl  0x8(%ebp)
  8021b0:	6a 0a                	push   $0xa
  8021b2:	e8 99 fe ff ff       	call   802050 <syscall>
  8021b7:	83 c4 18             	add    $0x18,%esp
}
  8021ba:	c9                   	leave  
  8021bb:	c3                   	ret    

008021bc <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8021bc:	55                   	push   %ebp
  8021bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 0b                	push   $0xb
  8021cb:	e8 80 fe ff ff       	call   802050 <syscall>
  8021d0:	83 c4 18             	add    $0x18,%esp
}
  8021d3:	c9                   	leave  
  8021d4:	c3                   	ret    

008021d5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8021d5:	55                   	push   %ebp
  8021d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 0c                	push   $0xc
  8021e4:	e8 67 fe ff ff       	call   802050 <syscall>
  8021e9:	83 c4 18             	add    $0x18,%esp
}
  8021ec:	c9                   	leave  
  8021ed:	c3                   	ret    

008021ee <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8021ee:	55                   	push   %ebp
  8021ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 00                	push   $0x0
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 0d                	push   $0xd
  8021fd:	e8 4e fe ff ff       	call   802050 <syscall>
  802202:	83 c4 18             	add    $0x18,%esp
}
  802205:	c9                   	leave  
  802206:	c3                   	ret    

00802207 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802207:	55                   	push   %ebp
  802208:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	ff 75 0c             	pushl  0xc(%ebp)
  802213:	ff 75 08             	pushl  0x8(%ebp)
  802216:	6a 11                	push   $0x11
  802218:	e8 33 fe ff ff       	call   802050 <syscall>
  80221d:	83 c4 18             	add    $0x18,%esp
	return;
  802220:	90                   	nop
}
  802221:	c9                   	leave  
  802222:	c3                   	ret    

00802223 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802223:	55                   	push   %ebp
  802224:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	ff 75 0c             	pushl  0xc(%ebp)
  80222f:	ff 75 08             	pushl  0x8(%ebp)
  802232:	6a 12                	push   $0x12
  802234:	e8 17 fe ff ff       	call   802050 <syscall>
  802239:	83 c4 18             	add    $0x18,%esp
	return ;
  80223c:	90                   	nop
}
  80223d:	c9                   	leave  
  80223e:	c3                   	ret    

0080223f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 0e                	push   $0xe
  80224e:	e8 fd fd ff ff       	call   802050 <syscall>
  802253:	83 c4 18             	add    $0x18,%esp
}
  802256:	c9                   	leave  
  802257:	c3                   	ret    

00802258 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802258:	55                   	push   %ebp
  802259:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	ff 75 08             	pushl  0x8(%ebp)
  802266:	6a 0f                	push   $0xf
  802268:	e8 e3 fd ff ff       	call   802050 <syscall>
  80226d:	83 c4 18             	add    $0x18,%esp
}
  802270:	c9                   	leave  
  802271:	c3                   	ret    

00802272 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802272:	55                   	push   %ebp
  802273:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 10                	push   $0x10
  802281:	e8 ca fd ff ff       	call   802050 <syscall>
  802286:	83 c4 18             	add    $0x18,%esp
}
  802289:	90                   	nop
  80228a:	c9                   	leave  
  80228b:	c3                   	ret    

0080228c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80228c:	55                   	push   %ebp
  80228d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 14                	push   $0x14
  80229b:	e8 b0 fd ff ff       	call   802050 <syscall>
  8022a0:	83 c4 18             	add    $0x18,%esp
}
  8022a3:	90                   	nop
  8022a4:	c9                   	leave  
  8022a5:	c3                   	ret    

008022a6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8022a6:	55                   	push   %ebp
  8022a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 15                	push   $0x15
  8022b5:	e8 96 fd ff ff       	call   802050 <syscall>
  8022ba:	83 c4 18             	add    $0x18,%esp
}
  8022bd:	90                   	nop
  8022be:	c9                   	leave  
  8022bf:	c3                   	ret    

008022c0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8022c0:	55                   	push   %ebp
  8022c1:	89 e5                	mov    %esp,%ebp
  8022c3:	83 ec 04             	sub    $0x4,%esp
  8022c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8022cc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 00                	push   $0x0
  8022d8:	50                   	push   %eax
  8022d9:	6a 16                	push   $0x16
  8022db:	e8 70 fd ff ff       	call   802050 <syscall>
  8022e0:	83 c4 18             	add    $0x18,%esp
}
  8022e3:	90                   	nop
  8022e4:	c9                   	leave  
  8022e5:	c3                   	ret    

008022e6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8022e6:	55                   	push   %ebp
  8022e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 17                	push   $0x17
  8022f5:	e8 56 fd ff ff       	call   802050 <syscall>
  8022fa:	83 c4 18             	add    $0x18,%esp
}
  8022fd:	90                   	nop
  8022fe:	c9                   	leave  
  8022ff:	c3                   	ret    

00802300 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802300:	55                   	push   %ebp
  802301:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802303:	8b 45 08             	mov    0x8(%ebp),%eax
  802306:	6a 00                	push   $0x0
  802308:	6a 00                	push   $0x0
  80230a:	6a 00                	push   $0x0
  80230c:	ff 75 0c             	pushl  0xc(%ebp)
  80230f:	50                   	push   %eax
  802310:	6a 18                	push   $0x18
  802312:	e8 39 fd ff ff       	call   802050 <syscall>
  802317:	83 c4 18             	add    $0x18,%esp
}
  80231a:	c9                   	leave  
  80231b:	c3                   	ret    

0080231c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80231c:	55                   	push   %ebp
  80231d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80231f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802322:	8b 45 08             	mov    0x8(%ebp),%eax
  802325:	6a 00                	push   $0x0
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	52                   	push   %edx
  80232c:	50                   	push   %eax
  80232d:	6a 1b                	push   $0x1b
  80232f:	e8 1c fd ff ff       	call   802050 <syscall>
  802334:	83 c4 18             	add    $0x18,%esp
}
  802337:	c9                   	leave  
  802338:	c3                   	ret    

00802339 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802339:	55                   	push   %ebp
  80233a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80233c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80233f:	8b 45 08             	mov    0x8(%ebp),%eax
  802342:	6a 00                	push   $0x0
  802344:	6a 00                	push   $0x0
  802346:	6a 00                	push   $0x0
  802348:	52                   	push   %edx
  802349:	50                   	push   %eax
  80234a:	6a 19                	push   $0x19
  80234c:	e8 ff fc ff ff       	call   802050 <syscall>
  802351:	83 c4 18             	add    $0x18,%esp
}
  802354:	90                   	nop
  802355:	c9                   	leave  
  802356:	c3                   	ret    

00802357 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802357:	55                   	push   %ebp
  802358:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80235a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80235d:	8b 45 08             	mov    0x8(%ebp),%eax
  802360:	6a 00                	push   $0x0
  802362:	6a 00                	push   $0x0
  802364:	6a 00                	push   $0x0
  802366:	52                   	push   %edx
  802367:	50                   	push   %eax
  802368:	6a 1a                	push   $0x1a
  80236a:	e8 e1 fc ff ff       	call   802050 <syscall>
  80236f:	83 c4 18             	add    $0x18,%esp
}
  802372:	90                   	nop
  802373:	c9                   	leave  
  802374:	c3                   	ret    

00802375 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802375:	55                   	push   %ebp
  802376:	89 e5                	mov    %esp,%ebp
  802378:	83 ec 04             	sub    $0x4,%esp
  80237b:	8b 45 10             	mov    0x10(%ebp),%eax
  80237e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802381:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802384:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802388:	8b 45 08             	mov    0x8(%ebp),%eax
  80238b:	6a 00                	push   $0x0
  80238d:	51                   	push   %ecx
  80238e:	52                   	push   %edx
  80238f:	ff 75 0c             	pushl  0xc(%ebp)
  802392:	50                   	push   %eax
  802393:	6a 1c                	push   $0x1c
  802395:	e8 b6 fc ff ff       	call   802050 <syscall>
  80239a:	83 c4 18             	add    $0x18,%esp
}
  80239d:	c9                   	leave  
  80239e:	c3                   	ret    

0080239f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80239f:	55                   	push   %ebp
  8023a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8023a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 00                	push   $0x0
  8023ac:	6a 00                	push   $0x0
  8023ae:	52                   	push   %edx
  8023af:	50                   	push   %eax
  8023b0:	6a 1d                	push   $0x1d
  8023b2:	e8 99 fc ff ff       	call   802050 <syscall>
  8023b7:	83 c4 18             	add    $0x18,%esp
}
  8023ba:	c9                   	leave  
  8023bb:	c3                   	ret    

008023bc <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8023bc:	55                   	push   %ebp
  8023bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8023bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c8:	6a 00                	push   $0x0
  8023ca:	6a 00                	push   $0x0
  8023cc:	51                   	push   %ecx
  8023cd:	52                   	push   %edx
  8023ce:	50                   	push   %eax
  8023cf:	6a 1e                	push   $0x1e
  8023d1:	e8 7a fc ff ff       	call   802050 <syscall>
  8023d6:	83 c4 18             	add    $0x18,%esp
}
  8023d9:	c9                   	leave  
  8023da:	c3                   	ret    

008023db <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8023db:	55                   	push   %ebp
  8023dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8023de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e4:	6a 00                	push   $0x0
  8023e6:	6a 00                	push   $0x0
  8023e8:	6a 00                	push   $0x0
  8023ea:	52                   	push   %edx
  8023eb:	50                   	push   %eax
  8023ec:	6a 1f                	push   $0x1f
  8023ee:	e8 5d fc ff ff       	call   802050 <syscall>
  8023f3:	83 c4 18             	add    $0x18,%esp
}
  8023f6:	c9                   	leave  
  8023f7:	c3                   	ret    

008023f8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8023f8:	55                   	push   %ebp
  8023f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 00                	push   $0x0
  802401:	6a 00                	push   $0x0
  802403:	6a 00                	push   $0x0
  802405:	6a 20                	push   $0x20
  802407:	e8 44 fc ff ff       	call   802050 <syscall>
  80240c:	83 c4 18             	add    $0x18,%esp
}
  80240f:	c9                   	leave  
  802410:	c3                   	ret    

00802411 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802411:	55                   	push   %ebp
  802412:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802414:	8b 45 08             	mov    0x8(%ebp),%eax
  802417:	6a 00                	push   $0x0
  802419:	6a 00                	push   $0x0
  80241b:	ff 75 10             	pushl  0x10(%ebp)
  80241e:	ff 75 0c             	pushl  0xc(%ebp)
  802421:	50                   	push   %eax
  802422:	6a 21                	push   $0x21
  802424:	e8 27 fc ff ff       	call   802050 <syscall>
  802429:	83 c4 18             	add    $0x18,%esp
}
  80242c:	c9                   	leave  
  80242d:	c3                   	ret    

0080242e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80242e:	55                   	push   %ebp
  80242f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802431:	8b 45 08             	mov    0x8(%ebp),%eax
  802434:	6a 00                	push   $0x0
  802436:	6a 00                	push   $0x0
  802438:	6a 00                	push   $0x0
  80243a:	6a 00                	push   $0x0
  80243c:	50                   	push   %eax
  80243d:	6a 22                	push   $0x22
  80243f:	e8 0c fc ff ff       	call   802050 <syscall>
  802444:	83 c4 18             	add    $0x18,%esp
}
  802447:	90                   	nop
  802448:	c9                   	leave  
  802449:	c3                   	ret    

0080244a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80244a:	55                   	push   %ebp
  80244b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80244d:	8b 45 08             	mov    0x8(%ebp),%eax
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	6a 00                	push   $0x0
  802458:	50                   	push   %eax
  802459:	6a 23                	push   $0x23
  80245b:	e8 f0 fb ff ff       	call   802050 <syscall>
  802460:	83 c4 18             	add    $0x18,%esp
}
  802463:	90                   	nop
  802464:	c9                   	leave  
  802465:	c3                   	ret    

00802466 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802466:	55                   	push   %ebp
  802467:	89 e5                	mov    %esp,%ebp
  802469:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80246c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80246f:	8d 50 04             	lea    0x4(%eax),%edx
  802472:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802475:	6a 00                	push   $0x0
  802477:	6a 00                	push   $0x0
  802479:	6a 00                	push   $0x0
  80247b:	52                   	push   %edx
  80247c:	50                   	push   %eax
  80247d:	6a 24                	push   $0x24
  80247f:	e8 cc fb ff ff       	call   802050 <syscall>
  802484:	83 c4 18             	add    $0x18,%esp
	return result;
  802487:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80248a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80248d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802490:	89 01                	mov    %eax,(%ecx)
  802492:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802495:	8b 45 08             	mov    0x8(%ebp),%eax
  802498:	c9                   	leave  
  802499:	c2 04 00             	ret    $0x4

0080249c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80249c:	55                   	push   %ebp
  80249d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80249f:	6a 00                	push   $0x0
  8024a1:	6a 00                	push   $0x0
  8024a3:	ff 75 10             	pushl  0x10(%ebp)
  8024a6:	ff 75 0c             	pushl  0xc(%ebp)
  8024a9:	ff 75 08             	pushl  0x8(%ebp)
  8024ac:	6a 13                	push   $0x13
  8024ae:	e8 9d fb ff ff       	call   802050 <syscall>
  8024b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8024b6:	90                   	nop
}
  8024b7:	c9                   	leave  
  8024b8:	c3                   	ret    

008024b9 <sys_rcr2>:
uint32 sys_rcr2()
{
  8024b9:	55                   	push   %ebp
  8024ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8024bc:	6a 00                	push   $0x0
  8024be:	6a 00                	push   $0x0
  8024c0:	6a 00                	push   $0x0
  8024c2:	6a 00                	push   $0x0
  8024c4:	6a 00                	push   $0x0
  8024c6:	6a 25                	push   $0x25
  8024c8:	e8 83 fb ff ff       	call   802050 <syscall>
  8024cd:	83 c4 18             	add    $0x18,%esp
}
  8024d0:	c9                   	leave  
  8024d1:	c3                   	ret    

008024d2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8024d2:	55                   	push   %ebp
  8024d3:	89 e5                	mov    %esp,%ebp
  8024d5:	83 ec 04             	sub    $0x4,%esp
  8024d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024db:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8024de:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8024e2:	6a 00                	push   $0x0
  8024e4:	6a 00                	push   $0x0
  8024e6:	6a 00                	push   $0x0
  8024e8:	6a 00                	push   $0x0
  8024ea:	50                   	push   %eax
  8024eb:	6a 26                	push   $0x26
  8024ed:	e8 5e fb ff ff       	call   802050 <syscall>
  8024f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8024f5:	90                   	nop
}
  8024f6:	c9                   	leave  
  8024f7:	c3                   	ret    

008024f8 <rsttst>:
void rsttst()
{
  8024f8:	55                   	push   %ebp
  8024f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8024fb:	6a 00                	push   $0x0
  8024fd:	6a 00                	push   $0x0
  8024ff:	6a 00                	push   $0x0
  802501:	6a 00                	push   $0x0
  802503:	6a 00                	push   $0x0
  802505:	6a 28                	push   $0x28
  802507:	e8 44 fb ff ff       	call   802050 <syscall>
  80250c:	83 c4 18             	add    $0x18,%esp
	return ;
  80250f:	90                   	nop
}
  802510:	c9                   	leave  
  802511:	c3                   	ret    

00802512 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802512:	55                   	push   %ebp
  802513:	89 e5                	mov    %esp,%ebp
  802515:	83 ec 04             	sub    $0x4,%esp
  802518:	8b 45 14             	mov    0x14(%ebp),%eax
  80251b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80251e:	8b 55 18             	mov    0x18(%ebp),%edx
  802521:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802525:	52                   	push   %edx
  802526:	50                   	push   %eax
  802527:	ff 75 10             	pushl  0x10(%ebp)
  80252a:	ff 75 0c             	pushl  0xc(%ebp)
  80252d:	ff 75 08             	pushl  0x8(%ebp)
  802530:	6a 27                	push   $0x27
  802532:	e8 19 fb ff ff       	call   802050 <syscall>
  802537:	83 c4 18             	add    $0x18,%esp
	return ;
  80253a:	90                   	nop
}
  80253b:	c9                   	leave  
  80253c:	c3                   	ret    

0080253d <chktst>:
void chktst(uint32 n)
{
  80253d:	55                   	push   %ebp
  80253e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802540:	6a 00                	push   $0x0
  802542:	6a 00                	push   $0x0
  802544:	6a 00                	push   $0x0
  802546:	6a 00                	push   $0x0
  802548:	ff 75 08             	pushl  0x8(%ebp)
  80254b:	6a 29                	push   $0x29
  80254d:	e8 fe fa ff ff       	call   802050 <syscall>
  802552:	83 c4 18             	add    $0x18,%esp
	return ;
  802555:	90                   	nop
}
  802556:	c9                   	leave  
  802557:	c3                   	ret    

00802558 <inctst>:

void inctst()
{
  802558:	55                   	push   %ebp
  802559:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80255b:	6a 00                	push   $0x0
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	6a 2a                	push   $0x2a
  802567:	e8 e4 fa ff ff       	call   802050 <syscall>
  80256c:	83 c4 18             	add    $0x18,%esp
	return ;
  80256f:	90                   	nop
}
  802570:	c9                   	leave  
  802571:	c3                   	ret    

00802572 <gettst>:
uint32 gettst()
{
  802572:	55                   	push   %ebp
  802573:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802575:	6a 00                	push   $0x0
  802577:	6a 00                	push   $0x0
  802579:	6a 00                	push   $0x0
  80257b:	6a 00                	push   $0x0
  80257d:	6a 00                	push   $0x0
  80257f:	6a 2b                	push   $0x2b
  802581:	e8 ca fa ff ff       	call   802050 <syscall>
  802586:	83 c4 18             	add    $0x18,%esp
}
  802589:	c9                   	leave  
  80258a:	c3                   	ret    

0080258b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80258b:	55                   	push   %ebp
  80258c:	89 e5                	mov    %esp,%ebp
  80258e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802591:	6a 00                	push   $0x0
  802593:	6a 00                	push   $0x0
  802595:	6a 00                	push   $0x0
  802597:	6a 00                	push   $0x0
  802599:	6a 00                	push   $0x0
  80259b:	6a 2c                	push   $0x2c
  80259d:	e8 ae fa ff ff       	call   802050 <syscall>
  8025a2:	83 c4 18             	add    $0x18,%esp
  8025a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8025a8:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8025ac:	75 07                	jne    8025b5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8025ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8025b3:	eb 05                	jmp    8025ba <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8025b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025ba:	c9                   	leave  
  8025bb:	c3                   	ret    

008025bc <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8025bc:	55                   	push   %ebp
  8025bd:	89 e5                	mov    %esp,%ebp
  8025bf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025c2:	6a 00                	push   $0x0
  8025c4:	6a 00                	push   $0x0
  8025c6:	6a 00                	push   $0x0
  8025c8:	6a 00                	push   $0x0
  8025ca:	6a 00                	push   $0x0
  8025cc:	6a 2c                	push   $0x2c
  8025ce:	e8 7d fa ff ff       	call   802050 <syscall>
  8025d3:	83 c4 18             	add    $0x18,%esp
  8025d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8025d9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8025dd:	75 07                	jne    8025e6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8025df:	b8 01 00 00 00       	mov    $0x1,%eax
  8025e4:	eb 05                	jmp    8025eb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8025e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025eb:	c9                   	leave  
  8025ec:	c3                   	ret    

008025ed <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8025ed:	55                   	push   %ebp
  8025ee:	89 e5                	mov    %esp,%ebp
  8025f0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025f3:	6a 00                	push   $0x0
  8025f5:	6a 00                	push   $0x0
  8025f7:	6a 00                	push   $0x0
  8025f9:	6a 00                	push   $0x0
  8025fb:	6a 00                	push   $0x0
  8025fd:	6a 2c                	push   $0x2c
  8025ff:	e8 4c fa ff ff       	call   802050 <syscall>
  802604:	83 c4 18             	add    $0x18,%esp
  802607:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80260a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80260e:	75 07                	jne    802617 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802610:	b8 01 00 00 00       	mov    $0x1,%eax
  802615:	eb 05                	jmp    80261c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802617:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80261c:	c9                   	leave  
  80261d:	c3                   	ret    

0080261e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80261e:	55                   	push   %ebp
  80261f:	89 e5                	mov    %esp,%ebp
  802621:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802624:	6a 00                	push   $0x0
  802626:	6a 00                	push   $0x0
  802628:	6a 00                	push   $0x0
  80262a:	6a 00                	push   $0x0
  80262c:	6a 00                	push   $0x0
  80262e:	6a 2c                	push   $0x2c
  802630:	e8 1b fa ff ff       	call   802050 <syscall>
  802635:	83 c4 18             	add    $0x18,%esp
  802638:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80263b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80263f:	75 07                	jne    802648 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802641:	b8 01 00 00 00       	mov    $0x1,%eax
  802646:	eb 05                	jmp    80264d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802648:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80264d:	c9                   	leave  
  80264e:	c3                   	ret    

0080264f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80264f:	55                   	push   %ebp
  802650:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802652:	6a 00                	push   $0x0
  802654:	6a 00                	push   $0x0
  802656:	6a 00                	push   $0x0
  802658:	6a 00                	push   $0x0
  80265a:	ff 75 08             	pushl  0x8(%ebp)
  80265d:	6a 2d                	push   $0x2d
  80265f:	e8 ec f9 ff ff       	call   802050 <syscall>
  802664:	83 c4 18             	add    $0x18,%esp
	return ;
  802667:	90                   	nop
}
  802668:	c9                   	leave  
  802669:	c3                   	ret    
  80266a:	66 90                	xchg   %ax,%ax

0080266c <__udivdi3>:
  80266c:	55                   	push   %ebp
  80266d:	57                   	push   %edi
  80266e:	56                   	push   %esi
  80266f:	53                   	push   %ebx
  802670:	83 ec 1c             	sub    $0x1c,%esp
  802673:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802677:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80267b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80267f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802683:	89 ca                	mov    %ecx,%edx
  802685:	89 f8                	mov    %edi,%eax
  802687:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80268b:	85 f6                	test   %esi,%esi
  80268d:	75 2d                	jne    8026bc <__udivdi3+0x50>
  80268f:	39 cf                	cmp    %ecx,%edi
  802691:	77 65                	ja     8026f8 <__udivdi3+0x8c>
  802693:	89 fd                	mov    %edi,%ebp
  802695:	85 ff                	test   %edi,%edi
  802697:	75 0b                	jne    8026a4 <__udivdi3+0x38>
  802699:	b8 01 00 00 00       	mov    $0x1,%eax
  80269e:	31 d2                	xor    %edx,%edx
  8026a0:	f7 f7                	div    %edi
  8026a2:	89 c5                	mov    %eax,%ebp
  8026a4:	31 d2                	xor    %edx,%edx
  8026a6:	89 c8                	mov    %ecx,%eax
  8026a8:	f7 f5                	div    %ebp
  8026aa:	89 c1                	mov    %eax,%ecx
  8026ac:	89 d8                	mov    %ebx,%eax
  8026ae:	f7 f5                	div    %ebp
  8026b0:	89 cf                	mov    %ecx,%edi
  8026b2:	89 fa                	mov    %edi,%edx
  8026b4:	83 c4 1c             	add    $0x1c,%esp
  8026b7:	5b                   	pop    %ebx
  8026b8:	5e                   	pop    %esi
  8026b9:	5f                   	pop    %edi
  8026ba:	5d                   	pop    %ebp
  8026bb:	c3                   	ret    
  8026bc:	39 ce                	cmp    %ecx,%esi
  8026be:	77 28                	ja     8026e8 <__udivdi3+0x7c>
  8026c0:	0f bd fe             	bsr    %esi,%edi
  8026c3:	83 f7 1f             	xor    $0x1f,%edi
  8026c6:	75 40                	jne    802708 <__udivdi3+0x9c>
  8026c8:	39 ce                	cmp    %ecx,%esi
  8026ca:	72 0a                	jb     8026d6 <__udivdi3+0x6a>
  8026cc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8026d0:	0f 87 9e 00 00 00    	ja     802774 <__udivdi3+0x108>
  8026d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026db:	89 fa                	mov    %edi,%edx
  8026dd:	83 c4 1c             	add    $0x1c,%esp
  8026e0:	5b                   	pop    %ebx
  8026e1:	5e                   	pop    %esi
  8026e2:	5f                   	pop    %edi
  8026e3:	5d                   	pop    %ebp
  8026e4:	c3                   	ret    
  8026e5:	8d 76 00             	lea    0x0(%esi),%esi
  8026e8:	31 ff                	xor    %edi,%edi
  8026ea:	31 c0                	xor    %eax,%eax
  8026ec:	89 fa                	mov    %edi,%edx
  8026ee:	83 c4 1c             	add    $0x1c,%esp
  8026f1:	5b                   	pop    %ebx
  8026f2:	5e                   	pop    %esi
  8026f3:	5f                   	pop    %edi
  8026f4:	5d                   	pop    %ebp
  8026f5:	c3                   	ret    
  8026f6:	66 90                	xchg   %ax,%ax
  8026f8:	89 d8                	mov    %ebx,%eax
  8026fa:	f7 f7                	div    %edi
  8026fc:	31 ff                	xor    %edi,%edi
  8026fe:	89 fa                	mov    %edi,%edx
  802700:	83 c4 1c             	add    $0x1c,%esp
  802703:	5b                   	pop    %ebx
  802704:	5e                   	pop    %esi
  802705:	5f                   	pop    %edi
  802706:	5d                   	pop    %ebp
  802707:	c3                   	ret    
  802708:	bd 20 00 00 00       	mov    $0x20,%ebp
  80270d:	89 eb                	mov    %ebp,%ebx
  80270f:	29 fb                	sub    %edi,%ebx
  802711:	89 f9                	mov    %edi,%ecx
  802713:	d3 e6                	shl    %cl,%esi
  802715:	89 c5                	mov    %eax,%ebp
  802717:	88 d9                	mov    %bl,%cl
  802719:	d3 ed                	shr    %cl,%ebp
  80271b:	89 e9                	mov    %ebp,%ecx
  80271d:	09 f1                	or     %esi,%ecx
  80271f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802723:	89 f9                	mov    %edi,%ecx
  802725:	d3 e0                	shl    %cl,%eax
  802727:	89 c5                	mov    %eax,%ebp
  802729:	89 d6                	mov    %edx,%esi
  80272b:	88 d9                	mov    %bl,%cl
  80272d:	d3 ee                	shr    %cl,%esi
  80272f:	89 f9                	mov    %edi,%ecx
  802731:	d3 e2                	shl    %cl,%edx
  802733:	8b 44 24 08          	mov    0x8(%esp),%eax
  802737:	88 d9                	mov    %bl,%cl
  802739:	d3 e8                	shr    %cl,%eax
  80273b:	09 c2                	or     %eax,%edx
  80273d:	89 d0                	mov    %edx,%eax
  80273f:	89 f2                	mov    %esi,%edx
  802741:	f7 74 24 0c          	divl   0xc(%esp)
  802745:	89 d6                	mov    %edx,%esi
  802747:	89 c3                	mov    %eax,%ebx
  802749:	f7 e5                	mul    %ebp
  80274b:	39 d6                	cmp    %edx,%esi
  80274d:	72 19                	jb     802768 <__udivdi3+0xfc>
  80274f:	74 0b                	je     80275c <__udivdi3+0xf0>
  802751:	89 d8                	mov    %ebx,%eax
  802753:	31 ff                	xor    %edi,%edi
  802755:	e9 58 ff ff ff       	jmp    8026b2 <__udivdi3+0x46>
  80275a:	66 90                	xchg   %ax,%ax
  80275c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802760:	89 f9                	mov    %edi,%ecx
  802762:	d3 e2                	shl    %cl,%edx
  802764:	39 c2                	cmp    %eax,%edx
  802766:	73 e9                	jae    802751 <__udivdi3+0xe5>
  802768:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80276b:	31 ff                	xor    %edi,%edi
  80276d:	e9 40 ff ff ff       	jmp    8026b2 <__udivdi3+0x46>
  802772:	66 90                	xchg   %ax,%ax
  802774:	31 c0                	xor    %eax,%eax
  802776:	e9 37 ff ff ff       	jmp    8026b2 <__udivdi3+0x46>
  80277b:	90                   	nop

0080277c <__umoddi3>:
  80277c:	55                   	push   %ebp
  80277d:	57                   	push   %edi
  80277e:	56                   	push   %esi
  80277f:	53                   	push   %ebx
  802780:	83 ec 1c             	sub    $0x1c,%esp
  802783:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802787:	8b 74 24 34          	mov    0x34(%esp),%esi
  80278b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80278f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802793:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802797:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80279b:	89 f3                	mov    %esi,%ebx
  80279d:	89 fa                	mov    %edi,%edx
  80279f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027a3:	89 34 24             	mov    %esi,(%esp)
  8027a6:	85 c0                	test   %eax,%eax
  8027a8:	75 1a                	jne    8027c4 <__umoddi3+0x48>
  8027aa:	39 f7                	cmp    %esi,%edi
  8027ac:	0f 86 a2 00 00 00    	jbe    802854 <__umoddi3+0xd8>
  8027b2:	89 c8                	mov    %ecx,%eax
  8027b4:	89 f2                	mov    %esi,%edx
  8027b6:	f7 f7                	div    %edi
  8027b8:	89 d0                	mov    %edx,%eax
  8027ba:	31 d2                	xor    %edx,%edx
  8027bc:	83 c4 1c             	add    $0x1c,%esp
  8027bf:	5b                   	pop    %ebx
  8027c0:	5e                   	pop    %esi
  8027c1:	5f                   	pop    %edi
  8027c2:	5d                   	pop    %ebp
  8027c3:	c3                   	ret    
  8027c4:	39 f0                	cmp    %esi,%eax
  8027c6:	0f 87 ac 00 00 00    	ja     802878 <__umoddi3+0xfc>
  8027cc:	0f bd e8             	bsr    %eax,%ebp
  8027cf:	83 f5 1f             	xor    $0x1f,%ebp
  8027d2:	0f 84 ac 00 00 00    	je     802884 <__umoddi3+0x108>
  8027d8:	bf 20 00 00 00       	mov    $0x20,%edi
  8027dd:	29 ef                	sub    %ebp,%edi
  8027df:	89 fe                	mov    %edi,%esi
  8027e1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8027e5:	89 e9                	mov    %ebp,%ecx
  8027e7:	d3 e0                	shl    %cl,%eax
  8027e9:	89 d7                	mov    %edx,%edi
  8027eb:	89 f1                	mov    %esi,%ecx
  8027ed:	d3 ef                	shr    %cl,%edi
  8027ef:	09 c7                	or     %eax,%edi
  8027f1:	89 e9                	mov    %ebp,%ecx
  8027f3:	d3 e2                	shl    %cl,%edx
  8027f5:	89 14 24             	mov    %edx,(%esp)
  8027f8:	89 d8                	mov    %ebx,%eax
  8027fa:	d3 e0                	shl    %cl,%eax
  8027fc:	89 c2                	mov    %eax,%edx
  8027fe:	8b 44 24 08          	mov    0x8(%esp),%eax
  802802:	d3 e0                	shl    %cl,%eax
  802804:	89 44 24 04          	mov    %eax,0x4(%esp)
  802808:	8b 44 24 08          	mov    0x8(%esp),%eax
  80280c:	89 f1                	mov    %esi,%ecx
  80280e:	d3 e8                	shr    %cl,%eax
  802810:	09 d0                	or     %edx,%eax
  802812:	d3 eb                	shr    %cl,%ebx
  802814:	89 da                	mov    %ebx,%edx
  802816:	f7 f7                	div    %edi
  802818:	89 d3                	mov    %edx,%ebx
  80281a:	f7 24 24             	mull   (%esp)
  80281d:	89 c6                	mov    %eax,%esi
  80281f:	89 d1                	mov    %edx,%ecx
  802821:	39 d3                	cmp    %edx,%ebx
  802823:	0f 82 87 00 00 00    	jb     8028b0 <__umoddi3+0x134>
  802829:	0f 84 91 00 00 00    	je     8028c0 <__umoddi3+0x144>
  80282f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802833:	29 f2                	sub    %esi,%edx
  802835:	19 cb                	sbb    %ecx,%ebx
  802837:	89 d8                	mov    %ebx,%eax
  802839:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80283d:	d3 e0                	shl    %cl,%eax
  80283f:	89 e9                	mov    %ebp,%ecx
  802841:	d3 ea                	shr    %cl,%edx
  802843:	09 d0                	or     %edx,%eax
  802845:	89 e9                	mov    %ebp,%ecx
  802847:	d3 eb                	shr    %cl,%ebx
  802849:	89 da                	mov    %ebx,%edx
  80284b:	83 c4 1c             	add    $0x1c,%esp
  80284e:	5b                   	pop    %ebx
  80284f:	5e                   	pop    %esi
  802850:	5f                   	pop    %edi
  802851:	5d                   	pop    %ebp
  802852:	c3                   	ret    
  802853:	90                   	nop
  802854:	89 fd                	mov    %edi,%ebp
  802856:	85 ff                	test   %edi,%edi
  802858:	75 0b                	jne    802865 <__umoddi3+0xe9>
  80285a:	b8 01 00 00 00       	mov    $0x1,%eax
  80285f:	31 d2                	xor    %edx,%edx
  802861:	f7 f7                	div    %edi
  802863:	89 c5                	mov    %eax,%ebp
  802865:	89 f0                	mov    %esi,%eax
  802867:	31 d2                	xor    %edx,%edx
  802869:	f7 f5                	div    %ebp
  80286b:	89 c8                	mov    %ecx,%eax
  80286d:	f7 f5                	div    %ebp
  80286f:	89 d0                	mov    %edx,%eax
  802871:	e9 44 ff ff ff       	jmp    8027ba <__umoddi3+0x3e>
  802876:	66 90                	xchg   %ax,%ax
  802878:	89 c8                	mov    %ecx,%eax
  80287a:	89 f2                	mov    %esi,%edx
  80287c:	83 c4 1c             	add    $0x1c,%esp
  80287f:	5b                   	pop    %ebx
  802880:	5e                   	pop    %esi
  802881:	5f                   	pop    %edi
  802882:	5d                   	pop    %ebp
  802883:	c3                   	ret    
  802884:	3b 04 24             	cmp    (%esp),%eax
  802887:	72 06                	jb     80288f <__umoddi3+0x113>
  802889:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80288d:	77 0f                	ja     80289e <__umoddi3+0x122>
  80288f:	89 f2                	mov    %esi,%edx
  802891:	29 f9                	sub    %edi,%ecx
  802893:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802897:	89 14 24             	mov    %edx,(%esp)
  80289a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80289e:	8b 44 24 04          	mov    0x4(%esp),%eax
  8028a2:	8b 14 24             	mov    (%esp),%edx
  8028a5:	83 c4 1c             	add    $0x1c,%esp
  8028a8:	5b                   	pop    %ebx
  8028a9:	5e                   	pop    %esi
  8028aa:	5f                   	pop    %edi
  8028ab:	5d                   	pop    %ebp
  8028ac:	c3                   	ret    
  8028ad:	8d 76 00             	lea    0x0(%esi),%esi
  8028b0:	2b 04 24             	sub    (%esp),%eax
  8028b3:	19 fa                	sbb    %edi,%edx
  8028b5:	89 d1                	mov    %edx,%ecx
  8028b7:	89 c6                	mov    %eax,%esi
  8028b9:	e9 71 ff ff ff       	jmp    80282f <__umoddi3+0xb3>
  8028be:	66 90                	xchg   %ax,%ax
  8028c0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028c4:	72 ea                	jb     8028b0 <__umoddi3+0x134>
  8028c6:	89 d9                	mov    %ebx,%ecx
  8028c8:	e9 62 ff ff ff       	jmp    80282f <__umoddi3+0xb3>
