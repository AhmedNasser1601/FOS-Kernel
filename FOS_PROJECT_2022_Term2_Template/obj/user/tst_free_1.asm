
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
  800091:	68 00 33 80 00       	push   $0x803300
  800096:	6a 1a                	push   $0x1a
  800098:	68 1c 33 80 00       	push   $0x80331c
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
  8000d2:	e8 16 2b 00 00       	call   802bed <sys_calculate_free_frames>
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
  8000ee:	e8 7d 2b 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8000f3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 d8 28 00 00       	call   8029df <malloc>
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
  80012a:	68 30 33 80 00       	push   $0x803330
  80012f:	6a 36                	push   $0x36
  800131:	68 1c 33 80 00       	push   $0x80331c
  800136:	e8 66 18 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80013b:	e8 30 2b 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800140:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800143:	3d 00 02 00 00       	cmp    $0x200,%eax
  800148:	74 14                	je     80015e <_main+0x126>
  80014a:	83 ec 04             	sub    $0x4,%esp
  80014d:	68 98 33 80 00       	push   $0x803398
  800152:	6a 37                	push   $0x37
  800154:	68 1c 33 80 00       	push   $0x80331c
  800159:	e8 43 18 00 00       	call   8019a1 <_panic>

		int freeFrames = sys_calculate_free_frames() ;
  80015e:	e8 8a 2a 00 00       	call   802bed <sys_calculate_free_frames>
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
  800193:	e8 55 2a 00 00       	call   802bed <sys_calculate_free_frames>
  800198:	29 c3                	sub    %eax,%ebx
  80019a:	89 d8                	mov    %ebx,%eax
  80019c:	83 f8 03             	cmp    $0x3,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 c8 33 80 00       	push   $0x8033c8
  8001a9:	6a 3e                	push   $0x3e
  8001ab:	68 1c 33 80 00       	push   $0x80331c
  8001b0:	e8 ec 17 00 00       	call   8019a1 <_panic>
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
  800205:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800266:	68 0c 34 80 00       	push   $0x80340c
  80026b:	6a 48                	push   $0x48
  80026d:	68 1c 33 80 00       	push   $0x80331c
  800272:	e8 2a 17 00 00       	call   8019a1 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800277:	e8 f4 29 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  80027c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80027f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800282:	01 c0                	add    %eax,%eax
  800284:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800287:	83 ec 0c             	sub    $0xc,%esp
  80028a:	50                   	push   %eax
  80028b:	e8 4f 27 00 00       	call   8029df <malloc>
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
  8002c8:	68 30 33 80 00       	push   $0x803330
  8002cd:	6a 4d                	push   $0x4d
  8002cf:	68 1c 33 80 00       	push   $0x80331c
  8002d4:	e8 c8 16 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002d9:	e8 92 29 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8002de:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8002e1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 98 33 80 00       	push   $0x803398
  8002f0:	6a 4e                	push   $0x4e
  8002f2:	68 1c 33 80 00       	push   $0x80331c
  8002f7:	e8 a5 16 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8002fc:	e8 ec 28 00 00       	call   802bed <sys_calculate_free_frames>
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
  80033a:	e8 ae 28 00 00       	call   802bed <sys_calculate_free_frames>
  80033f:	29 c3                	sub    %eax,%ebx
  800341:	89 d8                	mov    %ebx,%eax
  800343:	83 f8 02             	cmp    $0x2,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 c8 33 80 00       	push   $0x8033c8
  800350:	6a 55                	push   $0x55
  800352:	68 1c 33 80 00       	push   $0x80331c
  800357:	e8 45 16 00 00       	call   8019a1 <_panic>
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
  8003ac:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800411:	68 0c 34 80 00       	push   $0x80340c
  800416:	6a 5e                	push   $0x5e
  800418:	68 1c 33 80 00       	push   $0x80331c
  80041d:	e8 7f 15 00 00       	call   8019a1 <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800422:	e8 49 28 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800427:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  80042a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80042d:	01 c0                	add    %eax,%eax
  80042f:	83 ec 0c             	sub    $0xc,%esp
  800432:	50                   	push   %eax
  800433:	e8 a7 25 00 00       	call   8029df <malloc>
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
  800472:	68 30 33 80 00       	push   $0x803330
  800477:	6a 63                	push   $0x63
  800479:	68 1c 33 80 00       	push   $0x80331c
  80047e:	e8 1e 15 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800483:	e8 e8 27 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800488:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80048b:	83 f8 01             	cmp    $0x1,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 98 33 80 00       	push   $0x803398
  800498:	6a 64                	push   $0x64
  80049a:	68 1c 33 80 00       	push   $0x80331c
  80049f:	e8 fd 14 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004a4:	e8 44 27 00 00       	call   802bed <sys_calculate_free_frames>
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
  8004e0:	e8 08 27 00 00       	call   802bed <sys_calculate_free_frames>
  8004e5:	29 c3                	sub    %eax,%ebx
  8004e7:	89 d8                	mov    %ebx,%eax
  8004e9:	83 f8 02             	cmp    $0x2,%eax
  8004ec:	74 14                	je     800502 <_main+0x4ca>
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	68 c8 33 80 00       	push   $0x8033c8
  8004f6:	6a 6b                	push   $0x6b
  8004f8:	68 1c 33 80 00       	push   $0x80331c
  8004fd:	e8 9f 14 00 00       	call   8019a1 <_panic>
		found = 0;
  800502:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800509:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800510:	e9 95 00 00 00       	jmp    8005aa <_main+0x572>
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
  800552:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8005aa:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8005c6:	68 0c 34 80 00       	push   $0x80340c
  8005cb:	6a 74                	push   $0x74
  8005cd:	68 1c 33 80 00       	push   $0x80331c
  8005d2:	e8 ca 13 00 00       	call   8019a1 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8005d7:	e8 11 26 00 00       	call   802bed <sys_calculate_free_frames>
  8005dc:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005df:	e8 8c 26 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8005e4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8005e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ea:	01 c0                	add    %eax,%eax
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	50                   	push   %eax
  8005f0:	e8 ea 23 00 00       	call   8029df <malloc>
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
  800643:	68 30 33 80 00       	push   $0x803330
  800648:	6a 7a                	push   $0x7a
  80064a:	68 1c 33 80 00       	push   $0x80331c
  80064f:	e8 4d 13 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800654:	e8 17 26 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800659:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80065c:	83 f8 01             	cmp    $0x1,%eax
  80065f:	74 14                	je     800675 <_main+0x63d>
  800661:	83 ec 04             	sub    $0x4,%esp
  800664:	68 98 33 80 00       	push   $0x803398
  800669:	6a 7b                	push   $0x7b
  80066b:	68 1c 33 80 00       	push   $0x80331c
  800670:	e8 2c 13 00 00       	call   8019a1 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800675:	e8 f6 25 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  80068e:	e8 4c 23 00 00       	call   8029df <malloc>
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
  8006e1:	68 30 33 80 00       	push   $0x803330
  8006e6:	68 81 00 00 00       	push   $0x81
  8006eb:	68 1c 33 80 00       	push   $0x80331c
  8006f0:	e8 ac 12 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006f5:	e8 76 25 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8006fa:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8006fd:	83 f8 02             	cmp    $0x2,%eax
  800700:	74 17                	je     800719 <_main+0x6e1>
  800702:	83 ec 04             	sub    $0x4,%esp
  800705:	68 98 33 80 00       	push   $0x803398
  80070a:	68 82 00 00 00       	push   $0x82
  80070f:	68 1c 33 80 00       	push   $0x80331c
  800714:	e8 88 12 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800719:	e8 cf 24 00 00       	call   802bed <sys_calculate_free_frames>
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
  8007bd:	e8 2b 24 00 00       	call   802bed <sys_calculate_free_frames>
  8007c2:	29 c3                	sub    %eax,%ebx
  8007c4:	89 d8                	mov    %ebx,%eax
  8007c6:	83 f8 02             	cmp    $0x2,%eax
  8007c9:	74 17                	je     8007e2 <_main+0x7aa>
  8007cb:	83 ec 04             	sub    $0x4,%esp
  8007ce:	68 c8 33 80 00       	push   $0x8033c8
  8007d3:	68 89 00 00 00       	push   $0x89
  8007d8:	68 1c 33 80 00       	push   $0x80331c
  8007dd:	e8 bf 11 00 00       	call   8019a1 <_panic>
		found = 0;
  8007e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007f0:	e9 aa 00 00 00       	jmp    80089f <_main+0x867>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007f5:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800841:	a1 04 40 80 00       	mov    0x804004,%eax
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
  80089f:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8008bb:	68 0c 34 80 00       	push   $0x80340c
  8008c0:	68 92 00 00 00       	push   $0x92
  8008c5:	68 1c 33 80 00       	push   $0x80331c
  8008ca:	e8 d2 10 00 00       	call   8019a1 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008cf:	e8 19 23 00 00       	call   802bed <sys_calculate_free_frames>
  8008d4:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d7:	e8 94 23 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8008dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008df:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e2:	89 c2                	mov    %eax,%edx
  8008e4:	01 d2                	add    %edx,%edx
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008eb:	83 ec 0c             	sub    $0xc,%esp
  8008ee:	50                   	push   %eax
  8008ef:	e8 eb 20 00 00       	call   8029df <malloc>
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
  800942:	68 30 33 80 00       	push   $0x803330
  800947:	68 98 00 00 00       	push   $0x98
  80094c:	68 1c 33 80 00       	push   $0x80331c
  800951:	e8 4b 10 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800956:	e8 15 23 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  80097c:	68 98 33 80 00       	push   $0x803398
  800981:	68 99 00 00 00       	push   $0x99
  800986:	68 1c 33 80 00       	push   $0x80331c
  80098b:	e8 11 10 00 00       	call   8019a1 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800990:	e8 db 22 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  8009aa:	e8 30 20 00 00       	call   8029df <malloc>
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
  800a0b:	68 30 33 80 00       	push   $0x803330
  800a10:	68 9f 00 00 00       	push   $0x9f
  800a15:	68 1c 33 80 00       	push   $0x80331c
  800a1a:	e8 82 0f 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a1f:	e8 4c 22 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  800a47:	68 98 33 80 00       	push   $0x803398
  800a4c:	68 a0 00 00 00       	push   $0xa0
  800a51:	68 1c 33 80 00       	push   $0x80331c
  800a56:	e8 46 0f 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800a5b:	e8 8d 21 00 00       	call   802bed <sys_calculate_free_frames>
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
  800acc:	e8 1c 21 00 00       	call   802bed <sys_calculate_free_frames>
  800ad1:	29 c3                	sub    %eax,%ebx
  800ad3:	89 d8                	mov    %ebx,%eax
  800ad5:	83 f8 05             	cmp    $0x5,%eax
  800ad8:	74 17                	je     800af1 <_main+0xab9>
  800ada:	83 ec 04             	sub    $0x4,%esp
  800add:	68 c8 33 80 00       	push   $0x8033c8
  800ae2:	68 a8 00 00 00       	push   $0xa8
  800ae7:	68 1c 33 80 00       	push   $0x80331c
  800aec:	e8 b0 0e 00 00       	call   8019a1 <_panic>
		found = 0;
  800af1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800af8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800aff:	e9 02 01 00 00       	jmp    800c06 <_main+0xbce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b04:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800b50:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800baf:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800c06:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800c22:	68 0c 34 80 00       	push   $0x80340c
  800c27:	68 b3 00 00 00       	push   $0xb3
  800c2c:	68 1c 33 80 00       	push   $0x80331c
  800c31:	e8 6b 0d 00 00       	call   8019a1 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c36:	e8 35 20 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  800c51:	e8 89 1d 00 00       	call   8029df <malloc>
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
  800cb4:	68 30 33 80 00       	push   $0x803330
  800cb9:	68 b8 00 00 00       	push   $0xb8
  800cbe:	68 1c 33 80 00       	push   $0x80331c
  800cc3:	e8 d9 0c 00 00       	call   8019a1 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc8:	e8 a3 1f 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800ccd:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800cd0:	83 f8 04             	cmp    $0x4,%eax
  800cd3:	74 17                	je     800cec <_main+0xcb4>
  800cd5:	83 ec 04             	sub    $0x4,%esp
  800cd8:	68 98 33 80 00       	push   $0x803398
  800cdd:	68 b9 00 00 00       	push   $0xb9
  800ce2:	68 1c 33 80 00       	push   $0x80331c
  800ce7:	e8 b5 0c 00 00       	call   8019a1 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800cec:	e8 fc 1e 00 00       	call   802bed <sys_calculate_free_frames>
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
  800d40:	e8 a8 1e 00 00       	call   802bed <sys_calculate_free_frames>
  800d45:	29 c3                	sub    %eax,%ebx
  800d47:	89 d8                	mov    %ebx,%eax
  800d49:	83 f8 02             	cmp    $0x2,%eax
  800d4c:	74 17                	je     800d65 <_main+0xd2d>
  800d4e:	83 ec 04             	sub    $0x4,%esp
  800d51:	68 c8 33 80 00       	push   $0x8033c8
  800d56:	68 c0 00 00 00       	push   $0xc0
  800d5b:	68 1c 33 80 00       	push   $0x80331c
  800d60:	e8 3c 0c 00 00       	call   8019a1 <_panic>
		found = 0;
  800d65:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d6c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d73:	e9 a7 00 00 00       	jmp    800e1f <_main+0xde7>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d78:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800dc4:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800e1f:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800e3b:	68 0c 34 80 00       	push   $0x80340c
  800e40:	68 c9 00 00 00       	push   $0xc9
  800e45:	68 1c 33 80 00       	push   $0x80331c
  800e4a:	e8 52 0b 00 00       	call   8019a1 <_panic>
	}

	{
		//Free 1st 2 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e4f:	e8 99 1d 00 00       	call   802bed <sys_calculate_free_frames>
  800e54:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e5a:	e8 11 1e 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800e5f:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[0]);
  800e65:	8b 85 68 fe ff ff    	mov    -0x198(%ebp),%eax
  800e6b:	83 ec 0c             	sub    $0xc,%esp
  800e6e:	50                   	push   %eax
  800e6f:	e8 bf 1b 00 00       	call   802a33 <free>
  800e74:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e77:	e8 f4 1d 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800e7c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800e82:	29 c2                	sub    %eax,%edx
  800e84:	89 d0                	mov    %edx,%eax
  800e86:	3d 00 02 00 00       	cmp    $0x200,%eax
  800e8b:	74 17                	je     800ea4 <_main+0xe6c>
  800e8d:	83 ec 04             	sub    $0x4,%esp
  800e90:	68 2c 34 80 00       	push   $0x80342c
  800e95:	68 d1 00 00 00       	push   $0xd1
  800e9a:	68 1c 33 80 00       	push   $0x80331c
  800e9f:	e8 fd 0a 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ea4:	e8 44 1d 00 00       	call   802bed <sys_calculate_free_frames>
  800ea9:	89 c2                	mov    %eax,%edx
  800eab:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800eb1:	29 c2                	sub    %eax,%edx
  800eb3:	89 d0                	mov    %edx,%eax
  800eb5:	83 f8 02             	cmp    $0x2,%eax
  800eb8:	74 17                	je     800ed1 <_main+0xe99>
  800eba:	83 ec 04             	sub    $0x4,%esp
  800ebd:	68 68 34 80 00       	push   $0x803468
  800ec2:	68 d2 00 00 00       	push   $0xd2
  800ec7:	68 1c 33 80 00       	push   $0x80331c
  800ecc:	e8 d0 0a 00 00       	call   8019a1 <_panic>
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800ed1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800ed8:	e9 c2 00 00 00       	jmp    800f9f <_main+0xf67>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  800edd:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800f26:	68 b4 34 80 00       	push   $0x8034b4
  800f2b:	68 d7 00 00 00       	push   $0xd7
  800f30:	68 1c 33 80 00       	push   $0x80331c
  800f35:	e8 67 0a 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800f3a:	a1 04 40 80 00       	mov    0x804004,%eax
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
  800f88:	68 b4 34 80 00       	push   $0x8034b4
  800f8d:	68 d9 00 00 00       	push   $0xd9
  800f92:	68 1c 33 80 00       	push   $0x80331c
  800f97:	e8 05 0a 00 00       	call   8019a1 <_panic>
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[0]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		int var;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800f9c:	ff 45 e4             	incl   -0x1c(%ebp)
  800f9f:	a1 04 40 80 00       	mov    0x804004,%eax
  800fa4:	8b 50 74             	mov    0x74(%eax),%edx
  800fa7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800faa:	39 c2                	cmp    %eax,%edx
  800fac:	0f 87 2b ff ff ff    	ja     800edd <_main+0xea5>
				panic("free: page is not removed from WS");
		}


		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800fb2:	e8 36 1c 00 00       	call   802bed <sys_calculate_free_frames>
  800fb7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fbd:	e8 ae 1c 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800fc2:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[1]);
  800fc8:	8b 85 6c fe ff ff    	mov    -0x194(%ebp),%eax
  800fce:	83 ec 0c             	sub    $0xc,%esp
  800fd1:	50                   	push   %eax
  800fd2:	e8 5c 1a 00 00       	call   802a33 <free>
  800fd7:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fda:	e8 91 1c 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  800fdf:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  800fe5:	29 c2                	sub    %eax,%edx
  800fe7:	89 d0                	mov    %edx,%eax
  800fe9:	3d 00 02 00 00       	cmp    $0x200,%eax
  800fee:	74 17                	je     801007 <_main+0xfcf>
  800ff0:	83 ec 04             	sub    $0x4,%esp
  800ff3:	68 2c 34 80 00       	push   $0x80342c
  800ff8:	68 e1 00 00 00       	push   $0xe1
  800ffd:	68 1c 33 80 00       	push   $0x80331c
  801002:	e8 9a 09 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801007:	e8 e1 1b 00 00       	call   802bed <sys_calculate_free_frames>
  80100c:	89 c2                	mov    %eax,%edx
  80100e:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  801014:	29 c2                	sub    %eax,%edx
  801016:	89 d0                	mov    %edx,%eax
  801018:	83 f8 03             	cmp    $0x3,%eax
  80101b:	74 17                	je     801034 <_main+0xffc>
  80101d:	83 ec 04             	sub    $0x4,%esp
  801020:	68 68 34 80 00       	push   $0x803468
  801025:	68 e2 00 00 00       	push   $0xe2
  80102a:	68 1c 33 80 00       	push   $0x80331c
  80102f:	e8 6d 09 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801034:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80103b:	e9 c6 00 00 00       	jmp    801106 <_main+0x10ce>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  801040:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801089:	68 b4 34 80 00       	push   $0x8034b4
  80108e:	68 e6 00 00 00       	push   $0xe6
  801093:	68 1c 33 80 00       	push   $0x80331c
  801098:	e8 04 09 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  80109d:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8010ef:	68 b4 34 80 00       	push   $0x8034b4
  8010f4:	68 e8 00 00 00       	push   $0xe8
  8010f9:	68 1c 33 80 00       	push   $0x80331c
  8010fe:	e8 9e 08 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[1]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801103:	ff 45 e4             	incl   -0x1c(%ebp)
  801106:	a1 04 40 80 00       	mov    0x804004,%eax
  80110b:	8b 50 74             	mov    0x74(%eax),%edx
  80110e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801111:	39 c2                	cmp    %eax,%edx
  801113:	0f 87 27 ff ff ff    	ja     801040 <_main+0x1008>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 6 MB
		freeFrames = sys_calculate_free_frames() ;
  801119:	e8 cf 1a 00 00       	call   802bed <sys_calculate_free_frames>
  80111e:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801124:	e8 47 1b 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  801129:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[6]);
  80112f:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  801135:	83 ec 0c             	sub    $0xc,%esp
  801138:	50                   	push   %eax
  801139:	e8 f5 18 00 00       	call   802a33 <free>
  80113e:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801141:	e8 2a 1b 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  80116e:	68 2c 34 80 00       	push   $0x80342c
  801173:	68 ef 00 00 00       	push   $0xef
  801178:	68 1c 33 80 00       	push   $0x80331c
  80117d:	e8 1f 08 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801182:	e8 66 1a 00 00       	call   802bed <sys_calculate_free_frames>
  801187:	89 c2                	mov    %eax,%edx
  801189:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80118f:	29 c2                	sub    %eax,%edx
  801191:	89 d0                	mov    %edx,%eax
  801193:	83 f8 04             	cmp    $0x4,%eax
  801196:	74 17                	je     8011af <_main+0x1177>
  801198:	83 ec 04             	sub    $0x4,%esp
  80119b:	68 68 34 80 00       	push   $0x803468
  8011a0:	68 f0 00 00 00       	push   $0xf0
  8011a5:	68 1c 33 80 00       	push   $0x80331c
  8011aa:	e8 f2 07 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8011b6:	e9 3e 01 00 00       	jmp    8012f9 <_main+0x12c1>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8011bb:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801207:	68 b4 34 80 00       	push   $0x8034b4
  80120c:	68 f4 00 00 00       	push   $0xf4
  801211:	68 1c 33 80 00       	push   $0x80331c
  801216:	e8 86 07 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  80121b:	a1 04 40 80 00       	mov    0x804004,%eax
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
  80127a:	68 b4 34 80 00       	push   $0x8034b4
  80127f:	68 f6 00 00 00       	push   $0xf6
  801284:	68 1c 33 80 00       	push   $0x80331c
  801289:	e8 13 07 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  80128e:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8012e2:	68 b4 34 80 00       	push   $0x8034b4
  8012e7:	68 f8 00 00 00       	push   $0xf8
  8012ec:	68 1c 33 80 00       	push   $0x80331c
  8012f1:	e8 ab 06 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[6]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8012f6:	ff 45 e4             	incl   -0x1c(%ebp)
  8012f9:	a1 04 40 80 00       	mov    0x804004,%eax
  8012fe:	8b 50 74             	mov    0x74(%eax),%edx
  801301:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801304:	39 c2                	cmp    %eax,%edx
  801306:	0f 87 af fe ff ff    	ja     8011bb <_main+0x1183>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  80130c:	e8 dc 18 00 00       	call   802bed <sys_calculate_free_frames>
  801311:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801317:	e8 54 19 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  80131c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[4]);
  801322:	8b 85 78 fe ff ff    	mov    -0x188(%ebp),%eax
  801328:	83 ec 0c             	sub    $0xc,%esp
  80132b:	50                   	push   %eax
  80132c:	e8 02 17 00 00       	call   802a33 <free>
  801331:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801334:	e8 37 19 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  801339:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80133f:	29 c2                	sub    %eax,%edx
  801341:	89 d0                	mov    %edx,%eax
  801343:	83 f8 02             	cmp    $0x2,%eax
  801346:	74 17                	je     80135f <_main+0x1327>
  801348:	83 ec 04             	sub    $0x4,%esp
  80134b:	68 2c 34 80 00       	push   $0x80342c
  801350:	68 ff 00 00 00       	push   $0xff
  801355:	68 1c 33 80 00       	push   $0x80331c
  80135a:	e8 42 06 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80135f:	e8 89 18 00 00       	call   802bed <sys_calculate_free_frames>
  801364:	89 c2                	mov    %eax,%edx
  801366:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80136c:	29 c2                	sub    %eax,%edx
  80136e:	89 d0                	mov    %edx,%eax
  801370:	83 f8 02             	cmp    $0x2,%eax
  801373:	74 17                	je     80138c <_main+0x1354>
  801375:	83 ec 04             	sub    $0x4,%esp
  801378:	68 68 34 80 00       	push   $0x803468
  80137d:	68 00 01 00 00       	push   $0x100
  801382:	68 1c 33 80 00       	push   $0x80331c
  801387:	e8 15 06 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80138c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801393:	e9 d2 00 00 00       	jmp    80146a <_main+0x1432>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  801398:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8013e4:	68 b4 34 80 00       	push   $0x8034b4
  8013e9:	68 04 01 00 00       	push   $0x104
  8013ee:	68 1c 33 80 00       	push   $0x80331c
  8013f3:	e8 a9 05 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  8013f8:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801453:	68 b4 34 80 00       	push   $0x8034b4
  801458:	68 06 01 00 00       	push   $0x106
  80145d:	68 1c 33 80 00       	push   $0x80331c
  801462:	e8 3a 05 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[4]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801467:	ff 45 e4             	incl   -0x1c(%ebp)
  80146a:	a1 04 40 80 00       	mov    0x804004,%eax
  80146f:	8b 50 74             	mov    0x74(%eax),%edx
  801472:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801475:	39 c2                	cmp    %eax,%edx
  801477:	0f 87 1b ff ff ff    	ja     801398 <_main+0x1360>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80147d:	e8 6b 17 00 00       	call   802bed <sys_calculate_free_frames>
  801482:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801488:	e8 e3 17 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  80148d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[5]);
  801493:	8b 85 7c fe ff ff    	mov    -0x184(%ebp),%eax
  801499:	83 ec 0c             	sub    $0xc,%esp
  80149c:	50                   	push   %eax
  80149d:	e8 91 15 00 00       	call   802a33 <free>
  8014a2:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014a5:	e8 c6 17 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
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
  8014d0:	68 2c 34 80 00       	push   $0x80342c
  8014d5:	68 0d 01 00 00       	push   $0x10d
  8014da:	68 1c 33 80 00       	push   $0x80331c
  8014df:	e8 bd 04 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014e4:	e8 04 17 00 00       	call   802bed <sys_calculate_free_frames>
  8014e9:	89 c2                	mov    %eax,%edx
  8014eb:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8014f1:	39 c2                	cmp    %eax,%edx
  8014f3:	74 17                	je     80150c <_main+0x14d4>
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	68 68 34 80 00       	push   $0x803468
  8014fd:	68 0e 01 00 00       	push   $0x10e
  801502:	68 1c 33 80 00       	push   $0x80331c
  801507:	e8 95 04 00 00       	call   8019a1 <_panic>

		//Free 1st 2 KB
		freeFrames = sys_calculate_free_frames() ;
  80150c:	e8 dc 16 00 00       	call   802bed <sys_calculate_free_frames>
  801511:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801517:	e8 54 17 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  80151c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[2]);
  801522:	8b 85 70 fe ff ff    	mov    -0x190(%ebp),%eax
  801528:	83 ec 0c             	sub    $0xc,%esp
  80152b:	50                   	push   %eax
  80152c:	e8 02 15 00 00       	call   802a33 <free>
  801531:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801534:	e8 37 17 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  801539:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
  801543:	83 f8 01             	cmp    $0x1,%eax
  801546:	74 17                	je     80155f <_main+0x1527>
  801548:	83 ec 04             	sub    $0x4,%esp
  80154b:	68 2c 34 80 00       	push   $0x80342c
  801550:	68 14 01 00 00       	push   $0x114
  801555:	68 1c 33 80 00       	push   $0x80331c
  80155a:	e8 42 04 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80155f:	e8 89 16 00 00       	call   802bed <sys_calculate_free_frames>
  801564:	89 c2                	mov    %eax,%edx
  801566:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80156c:	29 c2                	sub    %eax,%edx
  80156e:	89 d0                	mov    %edx,%eax
  801570:	83 f8 02             	cmp    $0x2,%eax
  801573:	74 17                	je     80158c <_main+0x1554>
  801575:	83 ec 04             	sub    $0x4,%esp
  801578:	68 68 34 80 00       	push   $0x803468
  80157d:	68 15 01 00 00       	push   $0x115
  801582:	68 1c 33 80 00       	push   $0x80331c
  801587:	e8 15 04 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80158c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801593:	e9 c9 00 00 00       	jmp    801661 <_main+0x1629>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  801598:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8015e1:	68 b4 34 80 00       	push   $0x8034b4
  8015e6:	68 19 01 00 00       	push   $0x119
  8015eb:	68 1c 33 80 00       	push   $0x80331c
  8015f0:	e8 ac 03 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  8015f5:	a1 04 40 80 00       	mov    0x804004,%eax
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
  80164a:	68 b4 34 80 00       	push   $0x8034b4
  80164f:	68 1b 01 00 00       	push   $0x11b
  801654:	68 1c 33 80 00       	push   $0x80331c
  801659:	e8 43 03 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[2]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80165e:	ff 45 e4             	incl   -0x1c(%ebp)
  801661:	a1 04 40 80 00       	mov    0x804004,%eax
  801666:	8b 50 74             	mov    0x74(%eax),%edx
  801669:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80166c:	39 c2                	cmp    %eax,%edx
  80166e:	0f 87 24 ff ff ff    	ja     801598 <_main+0x1560>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		//Free 2nd 2 KB
		freeFrames = sys_calculate_free_frames() ;
  801674:	e8 74 15 00 00       	call   802bed <sys_calculate_free_frames>
  801679:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80167f:	e8 ec 15 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  801684:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[3]);
  80168a:	8b 85 74 fe ff ff    	mov    -0x18c(%ebp),%eax
  801690:	83 ec 0c             	sub    $0xc,%esp
  801693:	50                   	push   %eax
  801694:	e8 9a 13 00 00       	call   802a33 <free>
  801699:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80169c:	e8 cf 15 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8016a1:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  8016a7:	29 c2                	sub    %eax,%edx
  8016a9:	89 d0                	mov    %edx,%eax
  8016ab:	83 f8 01             	cmp    $0x1,%eax
  8016ae:	74 17                	je     8016c7 <_main+0x168f>
  8016b0:	83 ec 04             	sub    $0x4,%esp
  8016b3:	68 2c 34 80 00       	push   $0x80342c
  8016b8:	68 22 01 00 00       	push   $0x122
  8016bd:	68 1c 33 80 00       	push   $0x80331c
  8016c2:	e8 da 02 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8016c7:	e8 21 15 00 00       	call   802bed <sys_calculate_free_frames>
  8016cc:	89 c2                	mov    %eax,%edx
  8016ce:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8016d4:	39 c2                	cmp    %eax,%edx
  8016d6:	74 17                	je     8016ef <_main+0x16b7>
  8016d8:	83 ec 04             	sub    $0x4,%esp
  8016db:	68 68 34 80 00       	push   $0x803468
  8016e0:	68 23 01 00 00       	push   $0x123
  8016e5:	68 1c 33 80 00       	push   $0x80331c
  8016ea:	e8 b2 02 00 00       	call   8019a1 <_panic>


		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  8016ef:	e8 f9 14 00 00       	call   802bed <sys_calculate_free_frames>
  8016f4:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8016fa:	e8 71 15 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  8016ff:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		free(ptr_allocations[7]);
  801705:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80170b:	83 ec 0c             	sub    $0xc,%esp
  80170e:	50                   	push   %eax
  80170f:	e8 1f 13 00 00       	call   802a33 <free>
  801714:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801717:	e8 54 15 00 00       	call   802c70 <sys_pf_calculate_allocated_pages>
  80171c:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
  801722:	29 c2                	sub    %eax,%edx
  801724:	89 d0                	mov    %edx,%eax
  801726:	83 f8 04             	cmp    $0x4,%eax
  801729:	74 17                	je     801742 <_main+0x170a>
  80172b:	83 ec 04             	sub    $0x4,%esp
  80172e:	68 2c 34 80 00       	push   $0x80342c
  801733:	68 2a 01 00 00       	push   $0x12a
  801738:	68 1c 33 80 00       	push   $0x80331c
  80173d:	e8 5f 02 00 00       	call   8019a1 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801742:	e8 a6 14 00 00       	call   802bed <sys_calculate_free_frames>
  801747:	89 c2                	mov    %eax,%edx
  801749:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  80174f:	29 c2                	sub    %eax,%edx
  801751:	89 d0                	mov    %edx,%eax
  801753:	83 f8 03             	cmp    $0x3,%eax
  801756:	74 17                	je     80176f <_main+0x1737>
  801758:	83 ec 04             	sub    $0x4,%esp
  80175b:	68 68 34 80 00       	push   $0x803468
  801760:	68 2b 01 00 00       	push   $0x12b
  801765:	68 1c 33 80 00       	push   $0x80331c
  80176a:	e8 32 02 00 00       	call   8019a1 <_panic>
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80176f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801776:	e9 c6 00 00 00       	jmp    801841 <_main+0x1809>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  80177b:	a1 04 40 80 00       	mov    0x804004,%eax
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
  8017c4:	68 b4 34 80 00       	push   $0x8034b4
  8017c9:	68 2f 01 00 00       	push   $0x12f
  8017ce:	68 1c 33 80 00       	push   $0x80331c
  8017d3:	e8 c9 01 00 00       	call   8019a1 <_panic>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8017d8:	a1 04 40 80 00       	mov    0x804004,%eax
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
  80182a:	68 b4 34 80 00       	push   $0x8034b4
  80182f:	68 31 01 00 00       	push   $0x131
  801834:	68 1c 33 80 00       	push   $0x80331c
  801839:	e8 63 01 00 00       	call   8019a1 <_panic>
		freeFrames = sys_calculate_free_frames() ;
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
		free(ptr_allocations[7]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80183e:	ff 45 e4             	incl   -0x1c(%ebp)
  801841:	a1 04 40 80 00       	mov    0x804004,%eax
  801846:	8b 50 74             	mov    0x74(%eax),%edx
  801849:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80184c:	39 c2                	cmp    %eax,%edx
  80184e:	0f 87 27 ff ff ff    	ja     80177b <_main+0x1743>
				panic("free: page is not removed from WS");
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				panic("free: page is not removed from WS");
		}

		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801854:	e8 94 13 00 00       	call   802bed <sys_calculate_free_frames>
  801859:	8d 50 04             	lea    0x4(%eax),%edx
  80185c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80185f:	39 c2                	cmp    %eax,%edx
  801861:	74 17                	je     80187a <_main+0x1842>
  801863:	83 ec 04             	sub    $0x4,%esp
  801866:	68 d8 34 80 00       	push   $0x8034d8
  80186b:	68 34 01 00 00       	push   $0x134
  801870:	68 1c 33 80 00       	push   $0x80331c
  801875:	e8 27 01 00 00       	call   8019a1 <_panic>
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  80187a:	83 ec 0c             	sub    $0xc,%esp
  80187d:	68 0c 35 80 00       	push   $0x80350c
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
  801898:	e8 85 12 00 00       	call   802b22 <sys_getenvindex>
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
  8018c3:	a3 04 40 80 00       	mov    %eax,0x804004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8018c8:	a1 04 40 80 00       	mov    0x804004,%eax
  8018cd:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8018d3:	84 c0                	test   %al,%al
  8018d5:	74 0f                	je     8018e6 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8018d7:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801907:	e8 b1 13 00 00       	call   802cbd <sys_disable_interrupt>
	cprintf("**************************************\n");
  80190c:	83 ec 0c             	sub    $0xc,%esp
  80190f:	68 60 35 80 00       	push   $0x803560
  801914:	e8 3c 03 00 00       	call   801c55 <cprintf>
  801919:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80191c:	a1 04 40 80 00       	mov    0x804004,%eax
  801921:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801927:	a1 04 40 80 00       	mov    0x804004,%eax
  80192c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801932:	83 ec 04             	sub    $0x4,%esp
  801935:	52                   	push   %edx
  801936:	50                   	push   %eax
  801937:	68 88 35 80 00       	push   $0x803588
  80193c:	e8 14 03 00 00       	call   801c55 <cprintf>
  801941:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801944:	a1 04 40 80 00       	mov    0x804004,%eax
  801949:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80194f:	83 ec 08             	sub    $0x8,%esp
  801952:	50                   	push   %eax
  801953:	68 ad 35 80 00       	push   $0x8035ad
  801958:	e8 f8 02 00 00       	call   801c55 <cprintf>
  80195d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801960:	83 ec 0c             	sub    $0xc,%esp
  801963:	68 60 35 80 00       	push   $0x803560
  801968:	e8 e8 02 00 00       	call   801c55 <cprintf>
  80196d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801970:	e8 62 13 00 00       	call   802cd7 <sys_enable_interrupt>

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
  801988:	e8 61 11 00 00       	call   802aee <sys_env_destroy>
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
  801999:	e8 b6 11 00 00       	call   802b54 <sys_env_exit>
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
  8019b0:	a1 14 40 80 00       	mov    0x804014,%eax
  8019b5:	85 c0                	test   %eax,%eax
  8019b7:	74 16                	je     8019cf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8019b9:	a1 14 40 80 00       	mov    0x804014,%eax
  8019be:	83 ec 08             	sub    $0x8,%esp
  8019c1:	50                   	push   %eax
  8019c2:	68 c4 35 80 00       	push   $0x8035c4
  8019c7:	e8 89 02 00 00       	call   801c55 <cprintf>
  8019cc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8019cf:	a1 00 40 80 00       	mov    0x804000,%eax
  8019d4:	ff 75 0c             	pushl  0xc(%ebp)
  8019d7:	ff 75 08             	pushl  0x8(%ebp)
  8019da:	50                   	push   %eax
  8019db:	68 c9 35 80 00       	push   $0x8035c9
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
  8019ff:	68 e5 35 80 00       	push   $0x8035e5
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
  801a19:	a1 04 40 80 00       	mov    0x804004,%eax
  801a1e:	8b 50 74             	mov    0x74(%eax),%edx
  801a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a24:	39 c2                	cmp    %eax,%edx
  801a26:	74 14                	je     801a3c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801a28:	83 ec 04             	sub    $0x4,%esp
  801a2b:	68 e8 35 80 00       	push   $0x8035e8
  801a30:	6a 26                	push   $0x26
  801a32:	68 34 36 80 00       	push   $0x803634
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
  801a7c:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801a9c:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801ae5:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801afd:	68 40 36 80 00       	push   $0x803640
  801b02:	6a 3a                	push   $0x3a
  801b04:	68 34 36 80 00       	push   $0x803634
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
  801b2d:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801b53:	a1 04 40 80 00       	mov    0x804004,%eax
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
  801b6d:	68 94 36 80 00       	push   $0x803694
  801b72:	6a 44                	push   $0x44
  801b74:	68 34 36 80 00       	push   $0x803634
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
  801bac:	a0 08 40 80 00       	mov    0x804008,%al
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
  801bc7:	e8 e0 0e 00 00       	call   802aac <sys_cputs>
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
  801c21:	a0 08 40 80 00       	mov    0x804008,%al
  801c26:	0f b6 c0             	movzbl %al,%eax
  801c29:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801c2f:	83 ec 04             	sub    $0x4,%esp
  801c32:	50                   	push   %eax
  801c33:	52                   	push   %edx
  801c34:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801c3a:	83 c0 08             	add    $0x8,%eax
  801c3d:	50                   	push   %eax
  801c3e:	e8 69 0e 00 00       	call   802aac <sys_cputs>
  801c43:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801c46:	c6 05 08 40 80 00 00 	movb   $0x0,0x804008
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
  801c5b:	c6 05 08 40 80 00 01 	movb   $0x1,0x804008
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
  801c88:	e8 30 10 00 00       	call   802cbd <sys_disable_interrupt>
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
  801ca8:	e8 2a 10 00 00       	call   802cd7 <sys_enable_interrupt>
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
  801cf2:	e8 a5 13 00 00       	call   80309c <__udivdi3>
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
  801d42:	e8 65 14 00 00       	call   8031ac <__umoddi3>
  801d47:	83 c4 10             	add    $0x10,%esp
  801d4a:	05 f4 38 80 00       	add    $0x8038f4,%eax
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
  801e9d:	8b 04 85 18 39 80 00 	mov    0x803918(,%eax,4),%eax
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
  801f7e:	8b 34 9d 60 37 80 00 	mov    0x803760(,%ebx,4),%esi
  801f85:	85 f6                	test   %esi,%esi
  801f87:	75 19                	jne    801fa2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801f89:	53                   	push   %ebx
  801f8a:	68 05 39 80 00       	push   $0x803905
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
  801fa3:	68 0e 39 80 00       	push   $0x80390e
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
  801fd0:	be 11 39 80 00       	mov    $0x803911,%esi
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

008029df <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  8029df:	55                   	push   %ebp
  8029e0:	89 e5                	mov    %esp,%ebp
  8029e2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8029e5:	83 ec 04             	sub    $0x4,%esp
  8029e8:	68 70 3a 80 00       	push   $0x803a70
  8029ed:	6a 19                	push   $0x19
  8029ef:	68 95 3a 80 00       	push   $0x803a95
  8029f4:	e8 a8 ef ff ff       	call   8019a1 <_panic>

008029f9 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8029f9:	55                   	push   %ebp
  8029fa:	89 e5                	mov    %esp,%ebp
  8029fc:	83 ec 18             	sub    $0x18,%esp
  8029ff:	8b 45 10             	mov    0x10(%ebp),%eax
  802a02:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  802a05:	83 ec 04             	sub    $0x4,%esp
  802a08:	68 a4 3a 80 00       	push   $0x803aa4
  802a0d:	6a 30                	push   $0x30
  802a0f:	68 95 3a 80 00       	push   $0x803a95
  802a14:	e8 88 ef ff ff       	call   8019a1 <_panic>

00802a19 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802a19:	55                   	push   %ebp
  802a1a:	89 e5                	mov    %esp,%ebp
  802a1c:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  802a1f:	83 ec 04             	sub    $0x4,%esp
  802a22:	68 c3 3a 80 00       	push   $0x803ac3
  802a27:	6a 36                	push   $0x36
  802a29:	68 95 3a 80 00       	push   $0x803a95
  802a2e:	e8 6e ef ff ff       	call   8019a1 <_panic>

00802a33 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802a33:	55                   	push   %ebp
  802a34:	89 e5                	mov    %esp,%ebp
  802a36:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  802a39:	83 ec 04             	sub    $0x4,%esp
  802a3c:	68 e0 3a 80 00       	push   $0x803ae0
  802a41:	6a 48                	push   $0x48
  802a43:	68 95 3a 80 00       	push   $0x803a95
  802a48:	e8 54 ef ff ff       	call   8019a1 <_panic>

00802a4d <sfree>:

}


void sfree(void* virtual_address)
{
  802a4d:	55                   	push   %ebp
  802a4e:	89 e5                	mov    %esp,%ebp
  802a50:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  802a53:	83 ec 04             	sub    $0x4,%esp
  802a56:	68 03 3b 80 00       	push   $0x803b03
  802a5b:	6a 53                	push   $0x53
  802a5d:	68 95 3a 80 00       	push   $0x803a95
  802a62:	e8 3a ef ff ff       	call   8019a1 <_panic>

00802a67 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802a67:	55                   	push   %ebp
  802a68:	89 e5                	mov    %esp,%ebp
  802a6a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  802a6d:	83 ec 04             	sub    $0x4,%esp
  802a70:	68 20 3b 80 00       	push   $0x803b20
  802a75:	6a 6c                	push   $0x6c
  802a77:	68 95 3a 80 00       	push   $0x803a95
  802a7c:	e8 20 ef ff ff       	call   8019a1 <_panic>

00802a81 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802a81:	55                   	push   %ebp
  802a82:	89 e5                	mov    %esp,%ebp
  802a84:	57                   	push   %edi
  802a85:	56                   	push   %esi
  802a86:	53                   	push   %ebx
  802a87:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  802a8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a90:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802a93:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802a96:	8b 7d 18             	mov    0x18(%ebp),%edi
  802a99:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802a9c:	cd 30                	int    $0x30
  802a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802aa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802aa4:	83 c4 10             	add    $0x10,%esp
  802aa7:	5b                   	pop    %ebx
  802aa8:	5e                   	pop    %esi
  802aa9:	5f                   	pop    %edi
  802aaa:	5d                   	pop    %ebp
  802aab:	c3                   	ret    

00802aac <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802aac:	55                   	push   %ebp
  802aad:	89 e5                	mov    %esp,%ebp
  802aaf:	83 ec 04             	sub    $0x4,%esp
  802ab2:	8b 45 10             	mov    0x10(%ebp),%eax
  802ab5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802ab8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802abc:	8b 45 08             	mov    0x8(%ebp),%eax
  802abf:	6a 00                	push   $0x0
  802ac1:	6a 00                	push   $0x0
  802ac3:	52                   	push   %edx
  802ac4:	ff 75 0c             	pushl  0xc(%ebp)
  802ac7:	50                   	push   %eax
  802ac8:	6a 00                	push   $0x0
  802aca:	e8 b2 ff ff ff       	call   802a81 <syscall>
  802acf:	83 c4 18             	add    $0x18,%esp
}
  802ad2:	90                   	nop
  802ad3:	c9                   	leave  
  802ad4:	c3                   	ret    

00802ad5 <sys_cgetc>:

int
sys_cgetc(void)
{
  802ad5:	55                   	push   %ebp
  802ad6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802ad8:	6a 00                	push   $0x0
  802ada:	6a 00                	push   $0x0
  802adc:	6a 00                	push   $0x0
  802ade:	6a 00                	push   $0x0
  802ae0:	6a 00                	push   $0x0
  802ae2:	6a 01                	push   $0x1
  802ae4:	e8 98 ff ff ff       	call   802a81 <syscall>
  802ae9:	83 c4 18             	add    $0x18,%esp
}
  802aec:	c9                   	leave  
  802aed:	c3                   	ret    

00802aee <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802aee:	55                   	push   %ebp
  802aef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802af1:	8b 45 08             	mov    0x8(%ebp),%eax
  802af4:	6a 00                	push   $0x0
  802af6:	6a 00                	push   $0x0
  802af8:	6a 00                	push   $0x0
  802afa:	6a 00                	push   $0x0
  802afc:	50                   	push   %eax
  802afd:	6a 05                	push   $0x5
  802aff:	e8 7d ff ff ff       	call   802a81 <syscall>
  802b04:	83 c4 18             	add    $0x18,%esp
}
  802b07:	c9                   	leave  
  802b08:	c3                   	ret    

00802b09 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802b09:	55                   	push   %ebp
  802b0a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802b0c:	6a 00                	push   $0x0
  802b0e:	6a 00                	push   $0x0
  802b10:	6a 00                	push   $0x0
  802b12:	6a 00                	push   $0x0
  802b14:	6a 00                	push   $0x0
  802b16:	6a 02                	push   $0x2
  802b18:	e8 64 ff ff ff       	call   802a81 <syscall>
  802b1d:	83 c4 18             	add    $0x18,%esp
}
  802b20:	c9                   	leave  
  802b21:	c3                   	ret    

00802b22 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802b22:	55                   	push   %ebp
  802b23:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802b25:	6a 00                	push   $0x0
  802b27:	6a 00                	push   $0x0
  802b29:	6a 00                	push   $0x0
  802b2b:	6a 00                	push   $0x0
  802b2d:	6a 00                	push   $0x0
  802b2f:	6a 03                	push   $0x3
  802b31:	e8 4b ff ff ff       	call   802a81 <syscall>
  802b36:	83 c4 18             	add    $0x18,%esp
}
  802b39:	c9                   	leave  
  802b3a:	c3                   	ret    

00802b3b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802b3b:	55                   	push   %ebp
  802b3c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802b3e:	6a 00                	push   $0x0
  802b40:	6a 00                	push   $0x0
  802b42:	6a 00                	push   $0x0
  802b44:	6a 00                	push   $0x0
  802b46:	6a 00                	push   $0x0
  802b48:	6a 04                	push   $0x4
  802b4a:	e8 32 ff ff ff       	call   802a81 <syscall>
  802b4f:	83 c4 18             	add    $0x18,%esp
}
  802b52:	c9                   	leave  
  802b53:	c3                   	ret    

00802b54 <sys_env_exit>:


void sys_env_exit(void)
{
  802b54:	55                   	push   %ebp
  802b55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802b57:	6a 00                	push   $0x0
  802b59:	6a 00                	push   $0x0
  802b5b:	6a 00                	push   $0x0
  802b5d:	6a 00                	push   $0x0
  802b5f:	6a 00                	push   $0x0
  802b61:	6a 06                	push   $0x6
  802b63:	e8 19 ff ff ff       	call   802a81 <syscall>
  802b68:	83 c4 18             	add    $0x18,%esp
}
  802b6b:	90                   	nop
  802b6c:	c9                   	leave  
  802b6d:	c3                   	ret    

00802b6e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802b6e:	55                   	push   %ebp
  802b6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802b71:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b74:	8b 45 08             	mov    0x8(%ebp),%eax
  802b77:	6a 00                	push   $0x0
  802b79:	6a 00                	push   $0x0
  802b7b:	6a 00                	push   $0x0
  802b7d:	52                   	push   %edx
  802b7e:	50                   	push   %eax
  802b7f:	6a 07                	push   $0x7
  802b81:	e8 fb fe ff ff       	call   802a81 <syscall>
  802b86:	83 c4 18             	add    $0x18,%esp
}
  802b89:	c9                   	leave  
  802b8a:	c3                   	ret    

00802b8b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802b8b:	55                   	push   %ebp
  802b8c:	89 e5                	mov    %esp,%ebp
  802b8e:	56                   	push   %esi
  802b8f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802b90:	8b 75 18             	mov    0x18(%ebp),%esi
  802b93:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802b96:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b99:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  802b9f:	56                   	push   %esi
  802ba0:	53                   	push   %ebx
  802ba1:	51                   	push   %ecx
  802ba2:	52                   	push   %edx
  802ba3:	50                   	push   %eax
  802ba4:	6a 08                	push   $0x8
  802ba6:	e8 d6 fe ff ff       	call   802a81 <syscall>
  802bab:	83 c4 18             	add    $0x18,%esp
}
  802bae:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802bb1:	5b                   	pop    %ebx
  802bb2:	5e                   	pop    %esi
  802bb3:	5d                   	pop    %ebp
  802bb4:	c3                   	ret    

00802bb5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802bb5:	55                   	push   %ebp
  802bb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  802bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  802bbe:	6a 00                	push   $0x0
  802bc0:	6a 00                	push   $0x0
  802bc2:	6a 00                	push   $0x0
  802bc4:	52                   	push   %edx
  802bc5:	50                   	push   %eax
  802bc6:	6a 09                	push   $0x9
  802bc8:	e8 b4 fe ff ff       	call   802a81 <syscall>
  802bcd:	83 c4 18             	add    $0x18,%esp
}
  802bd0:	c9                   	leave  
  802bd1:	c3                   	ret    

00802bd2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802bd2:	55                   	push   %ebp
  802bd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802bd5:	6a 00                	push   $0x0
  802bd7:	6a 00                	push   $0x0
  802bd9:	6a 00                	push   $0x0
  802bdb:	ff 75 0c             	pushl  0xc(%ebp)
  802bde:	ff 75 08             	pushl  0x8(%ebp)
  802be1:	6a 0a                	push   $0xa
  802be3:	e8 99 fe ff ff       	call   802a81 <syscall>
  802be8:	83 c4 18             	add    $0x18,%esp
}
  802beb:	c9                   	leave  
  802bec:	c3                   	ret    

00802bed <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802bed:	55                   	push   %ebp
  802bee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802bf0:	6a 00                	push   $0x0
  802bf2:	6a 00                	push   $0x0
  802bf4:	6a 00                	push   $0x0
  802bf6:	6a 00                	push   $0x0
  802bf8:	6a 00                	push   $0x0
  802bfa:	6a 0b                	push   $0xb
  802bfc:	e8 80 fe ff ff       	call   802a81 <syscall>
  802c01:	83 c4 18             	add    $0x18,%esp
}
  802c04:	c9                   	leave  
  802c05:	c3                   	ret    

00802c06 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802c06:	55                   	push   %ebp
  802c07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802c09:	6a 00                	push   $0x0
  802c0b:	6a 00                	push   $0x0
  802c0d:	6a 00                	push   $0x0
  802c0f:	6a 00                	push   $0x0
  802c11:	6a 00                	push   $0x0
  802c13:	6a 0c                	push   $0xc
  802c15:	e8 67 fe ff ff       	call   802a81 <syscall>
  802c1a:	83 c4 18             	add    $0x18,%esp
}
  802c1d:	c9                   	leave  
  802c1e:	c3                   	ret    

00802c1f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802c1f:	55                   	push   %ebp
  802c20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802c22:	6a 00                	push   $0x0
  802c24:	6a 00                	push   $0x0
  802c26:	6a 00                	push   $0x0
  802c28:	6a 00                	push   $0x0
  802c2a:	6a 00                	push   $0x0
  802c2c:	6a 0d                	push   $0xd
  802c2e:	e8 4e fe ff ff       	call   802a81 <syscall>
  802c33:	83 c4 18             	add    $0x18,%esp
}
  802c36:	c9                   	leave  
  802c37:	c3                   	ret    

00802c38 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802c38:	55                   	push   %ebp
  802c39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802c3b:	6a 00                	push   $0x0
  802c3d:	6a 00                	push   $0x0
  802c3f:	6a 00                	push   $0x0
  802c41:	ff 75 0c             	pushl  0xc(%ebp)
  802c44:	ff 75 08             	pushl  0x8(%ebp)
  802c47:	6a 11                	push   $0x11
  802c49:	e8 33 fe ff ff       	call   802a81 <syscall>
  802c4e:	83 c4 18             	add    $0x18,%esp
	return;
  802c51:	90                   	nop
}
  802c52:	c9                   	leave  
  802c53:	c3                   	ret    

00802c54 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802c54:	55                   	push   %ebp
  802c55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802c57:	6a 00                	push   $0x0
  802c59:	6a 00                	push   $0x0
  802c5b:	6a 00                	push   $0x0
  802c5d:	ff 75 0c             	pushl  0xc(%ebp)
  802c60:	ff 75 08             	pushl  0x8(%ebp)
  802c63:	6a 12                	push   $0x12
  802c65:	e8 17 fe ff ff       	call   802a81 <syscall>
  802c6a:	83 c4 18             	add    $0x18,%esp
	return ;
  802c6d:	90                   	nop
}
  802c6e:	c9                   	leave  
  802c6f:	c3                   	ret    

00802c70 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802c70:	55                   	push   %ebp
  802c71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802c73:	6a 00                	push   $0x0
  802c75:	6a 00                	push   $0x0
  802c77:	6a 00                	push   $0x0
  802c79:	6a 00                	push   $0x0
  802c7b:	6a 00                	push   $0x0
  802c7d:	6a 0e                	push   $0xe
  802c7f:	e8 fd fd ff ff       	call   802a81 <syscall>
  802c84:	83 c4 18             	add    $0x18,%esp
}
  802c87:	c9                   	leave  
  802c88:	c3                   	ret    

00802c89 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802c89:	55                   	push   %ebp
  802c8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802c8c:	6a 00                	push   $0x0
  802c8e:	6a 00                	push   $0x0
  802c90:	6a 00                	push   $0x0
  802c92:	6a 00                	push   $0x0
  802c94:	ff 75 08             	pushl  0x8(%ebp)
  802c97:	6a 0f                	push   $0xf
  802c99:	e8 e3 fd ff ff       	call   802a81 <syscall>
  802c9e:	83 c4 18             	add    $0x18,%esp
}
  802ca1:	c9                   	leave  
  802ca2:	c3                   	ret    

00802ca3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802ca3:	55                   	push   %ebp
  802ca4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802ca6:	6a 00                	push   $0x0
  802ca8:	6a 00                	push   $0x0
  802caa:	6a 00                	push   $0x0
  802cac:	6a 00                	push   $0x0
  802cae:	6a 00                	push   $0x0
  802cb0:	6a 10                	push   $0x10
  802cb2:	e8 ca fd ff ff       	call   802a81 <syscall>
  802cb7:	83 c4 18             	add    $0x18,%esp
}
  802cba:	90                   	nop
  802cbb:	c9                   	leave  
  802cbc:	c3                   	ret    

00802cbd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802cbd:	55                   	push   %ebp
  802cbe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802cc0:	6a 00                	push   $0x0
  802cc2:	6a 00                	push   $0x0
  802cc4:	6a 00                	push   $0x0
  802cc6:	6a 00                	push   $0x0
  802cc8:	6a 00                	push   $0x0
  802cca:	6a 14                	push   $0x14
  802ccc:	e8 b0 fd ff ff       	call   802a81 <syscall>
  802cd1:	83 c4 18             	add    $0x18,%esp
}
  802cd4:	90                   	nop
  802cd5:	c9                   	leave  
  802cd6:	c3                   	ret    

00802cd7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802cd7:	55                   	push   %ebp
  802cd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802cda:	6a 00                	push   $0x0
  802cdc:	6a 00                	push   $0x0
  802cde:	6a 00                	push   $0x0
  802ce0:	6a 00                	push   $0x0
  802ce2:	6a 00                	push   $0x0
  802ce4:	6a 15                	push   $0x15
  802ce6:	e8 96 fd ff ff       	call   802a81 <syscall>
  802ceb:	83 c4 18             	add    $0x18,%esp
}
  802cee:	90                   	nop
  802cef:	c9                   	leave  
  802cf0:	c3                   	ret    

00802cf1 <sys_cputc>:


void
sys_cputc(const char c)
{
  802cf1:	55                   	push   %ebp
  802cf2:	89 e5                	mov    %esp,%ebp
  802cf4:	83 ec 04             	sub    $0x4,%esp
  802cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  802cfa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802cfd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802d01:	6a 00                	push   $0x0
  802d03:	6a 00                	push   $0x0
  802d05:	6a 00                	push   $0x0
  802d07:	6a 00                	push   $0x0
  802d09:	50                   	push   %eax
  802d0a:	6a 16                	push   $0x16
  802d0c:	e8 70 fd ff ff       	call   802a81 <syscall>
  802d11:	83 c4 18             	add    $0x18,%esp
}
  802d14:	90                   	nop
  802d15:	c9                   	leave  
  802d16:	c3                   	ret    

00802d17 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802d17:	55                   	push   %ebp
  802d18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802d1a:	6a 00                	push   $0x0
  802d1c:	6a 00                	push   $0x0
  802d1e:	6a 00                	push   $0x0
  802d20:	6a 00                	push   $0x0
  802d22:	6a 00                	push   $0x0
  802d24:	6a 17                	push   $0x17
  802d26:	e8 56 fd ff ff       	call   802a81 <syscall>
  802d2b:	83 c4 18             	add    $0x18,%esp
}
  802d2e:	90                   	nop
  802d2f:	c9                   	leave  
  802d30:	c3                   	ret    

00802d31 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802d31:	55                   	push   %ebp
  802d32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802d34:	8b 45 08             	mov    0x8(%ebp),%eax
  802d37:	6a 00                	push   $0x0
  802d39:	6a 00                	push   $0x0
  802d3b:	6a 00                	push   $0x0
  802d3d:	ff 75 0c             	pushl  0xc(%ebp)
  802d40:	50                   	push   %eax
  802d41:	6a 18                	push   $0x18
  802d43:	e8 39 fd ff ff       	call   802a81 <syscall>
  802d48:	83 c4 18             	add    $0x18,%esp
}
  802d4b:	c9                   	leave  
  802d4c:	c3                   	ret    

00802d4d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802d4d:	55                   	push   %ebp
  802d4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802d50:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d53:	8b 45 08             	mov    0x8(%ebp),%eax
  802d56:	6a 00                	push   $0x0
  802d58:	6a 00                	push   $0x0
  802d5a:	6a 00                	push   $0x0
  802d5c:	52                   	push   %edx
  802d5d:	50                   	push   %eax
  802d5e:	6a 1b                	push   $0x1b
  802d60:	e8 1c fd ff ff       	call   802a81 <syscall>
  802d65:	83 c4 18             	add    $0x18,%esp
}
  802d68:	c9                   	leave  
  802d69:	c3                   	ret    

00802d6a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802d6a:	55                   	push   %ebp
  802d6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802d6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d70:	8b 45 08             	mov    0x8(%ebp),%eax
  802d73:	6a 00                	push   $0x0
  802d75:	6a 00                	push   $0x0
  802d77:	6a 00                	push   $0x0
  802d79:	52                   	push   %edx
  802d7a:	50                   	push   %eax
  802d7b:	6a 19                	push   $0x19
  802d7d:	e8 ff fc ff ff       	call   802a81 <syscall>
  802d82:	83 c4 18             	add    $0x18,%esp
}
  802d85:	90                   	nop
  802d86:	c9                   	leave  
  802d87:	c3                   	ret    

00802d88 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802d88:	55                   	push   %ebp
  802d89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  802d91:	6a 00                	push   $0x0
  802d93:	6a 00                	push   $0x0
  802d95:	6a 00                	push   $0x0
  802d97:	52                   	push   %edx
  802d98:	50                   	push   %eax
  802d99:	6a 1a                	push   $0x1a
  802d9b:	e8 e1 fc ff ff       	call   802a81 <syscall>
  802da0:	83 c4 18             	add    $0x18,%esp
}
  802da3:	90                   	nop
  802da4:	c9                   	leave  
  802da5:	c3                   	ret    

00802da6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802da6:	55                   	push   %ebp
  802da7:	89 e5                	mov    %esp,%ebp
  802da9:	83 ec 04             	sub    $0x4,%esp
  802dac:	8b 45 10             	mov    0x10(%ebp),%eax
  802daf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802db2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802db5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802db9:	8b 45 08             	mov    0x8(%ebp),%eax
  802dbc:	6a 00                	push   $0x0
  802dbe:	51                   	push   %ecx
  802dbf:	52                   	push   %edx
  802dc0:	ff 75 0c             	pushl  0xc(%ebp)
  802dc3:	50                   	push   %eax
  802dc4:	6a 1c                	push   $0x1c
  802dc6:	e8 b6 fc ff ff       	call   802a81 <syscall>
  802dcb:	83 c4 18             	add    $0x18,%esp
}
  802dce:	c9                   	leave  
  802dcf:	c3                   	ret    

00802dd0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802dd0:	55                   	push   %ebp
  802dd1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802dd3:	8b 55 0c             	mov    0xc(%ebp),%edx
  802dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  802dd9:	6a 00                	push   $0x0
  802ddb:	6a 00                	push   $0x0
  802ddd:	6a 00                	push   $0x0
  802ddf:	52                   	push   %edx
  802de0:	50                   	push   %eax
  802de1:	6a 1d                	push   $0x1d
  802de3:	e8 99 fc ff ff       	call   802a81 <syscall>
  802de8:	83 c4 18             	add    $0x18,%esp
}
  802deb:	c9                   	leave  
  802dec:	c3                   	ret    

00802ded <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802ded:	55                   	push   %ebp
  802dee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802df0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802df3:	8b 55 0c             	mov    0xc(%ebp),%edx
  802df6:	8b 45 08             	mov    0x8(%ebp),%eax
  802df9:	6a 00                	push   $0x0
  802dfb:	6a 00                	push   $0x0
  802dfd:	51                   	push   %ecx
  802dfe:	52                   	push   %edx
  802dff:	50                   	push   %eax
  802e00:	6a 1e                	push   $0x1e
  802e02:	e8 7a fc ff ff       	call   802a81 <syscall>
  802e07:	83 c4 18             	add    $0x18,%esp
}
  802e0a:	c9                   	leave  
  802e0b:	c3                   	ret    

00802e0c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802e0c:	55                   	push   %ebp
  802e0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802e0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e12:	8b 45 08             	mov    0x8(%ebp),%eax
  802e15:	6a 00                	push   $0x0
  802e17:	6a 00                	push   $0x0
  802e19:	6a 00                	push   $0x0
  802e1b:	52                   	push   %edx
  802e1c:	50                   	push   %eax
  802e1d:	6a 1f                	push   $0x1f
  802e1f:	e8 5d fc ff ff       	call   802a81 <syscall>
  802e24:	83 c4 18             	add    $0x18,%esp
}
  802e27:	c9                   	leave  
  802e28:	c3                   	ret    

00802e29 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802e29:	55                   	push   %ebp
  802e2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802e2c:	6a 00                	push   $0x0
  802e2e:	6a 00                	push   $0x0
  802e30:	6a 00                	push   $0x0
  802e32:	6a 00                	push   $0x0
  802e34:	6a 00                	push   $0x0
  802e36:	6a 20                	push   $0x20
  802e38:	e8 44 fc ff ff       	call   802a81 <syscall>
  802e3d:	83 c4 18             	add    $0x18,%esp
}
  802e40:	c9                   	leave  
  802e41:	c3                   	ret    

00802e42 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802e42:	55                   	push   %ebp
  802e43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802e45:	8b 45 08             	mov    0x8(%ebp),%eax
  802e48:	6a 00                	push   $0x0
  802e4a:	6a 00                	push   $0x0
  802e4c:	ff 75 10             	pushl  0x10(%ebp)
  802e4f:	ff 75 0c             	pushl  0xc(%ebp)
  802e52:	50                   	push   %eax
  802e53:	6a 21                	push   $0x21
  802e55:	e8 27 fc ff ff       	call   802a81 <syscall>
  802e5a:	83 c4 18             	add    $0x18,%esp
}
  802e5d:	c9                   	leave  
  802e5e:	c3                   	ret    

00802e5f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802e5f:	55                   	push   %ebp
  802e60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802e62:	8b 45 08             	mov    0x8(%ebp),%eax
  802e65:	6a 00                	push   $0x0
  802e67:	6a 00                	push   $0x0
  802e69:	6a 00                	push   $0x0
  802e6b:	6a 00                	push   $0x0
  802e6d:	50                   	push   %eax
  802e6e:	6a 22                	push   $0x22
  802e70:	e8 0c fc ff ff       	call   802a81 <syscall>
  802e75:	83 c4 18             	add    $0x18,%esp
}
  802e78:	90                   	nop
  802e79:	c9                   	leave  
  802e7a:	c3                   	ret    

00802e7b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802e7b:	55                   	push   %ebp
  802e7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  802e81:	6a 00                	push   $0x0
  802e83:	6a 00                	push   $0x0
  802e85:	6a 00                	push   $0x0
  802e87:	6a 00                	push   $0x0
  802e89:	50                   	push   %eax
  802e8a:	6a 23                	push   $0x23
  802e8c:	e8 f0 fb ff ff       	call   802a81 <syscall>
  802e91:	83 c4 18             	add    $0x18,%esp
}
  802e94:	90                   	nop
  802e95:	c9                   	leave  
  802e96:	c3                   	ret    

00802e97 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802e97:	55                   	push   %ebp
  802e98:	89 e5                	mov    %esp,%ebp
  802e9a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802e9d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802ea0:	8d 50 04             	lea    0x4(%eax),%edx
  802ea3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802ea6:	6a 00                	push   $0x0
  802ea8:	6a 00                	push   $0x0
  802eaa:	6a 00                	push   $0x0
  802eac:	52                   	push   %edx
  802ead:	50                   	push   %eax
  802eae:	6a 24                	push   $0x24
  802eb0:	e8 cc fb ff ff       	call   802a81 <syscall>
  802eb5:	83 c4 18             	add    $0x18,%esp
	return result;
  802eb8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802ebb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802ebe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802ec1:	89 01                	mov    %eax,(%ecx)
  802ec3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  802ec9:	c9                   	leave  
  802eca:	c2 04 00             	ret    $0x4

00802ecd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802ecd:	55                   	push   %ebp
  802ece:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802ed0:	6a 00                	push   $0x0
  802ed2:	6a 00                	push   $0x0
  802ed4:	ff 75 10             	pushl  0x10(%ebp)
  802ed7:	ff 75 0c             	pushl  0xc(%ebp)
  802eda:	ff 75 08             	pushl  0x8(%ebp)
  802edd:	6a 13                	push   $0x13
  802edf:	e8 9d fb ff ff       	call   802a81 <syscall>
  802ee4:	83 c4 18             	add    $0x18,%esp
	return ;
  802ee7:	90                   	nop
}
  802ee8:	c9                   	leave  
  802ee9:	c3                   	ret    

00802eea <sys_rcr2>:
uint32 sys_rcr2()
{
  802eea:	55                   	push   %ebp
  802eeb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802eed:	6a 00                	push   $0x0
  802eef:	6a 00                	push   $0x0
  802ef1:	6a 00                	push   $0x0
  802ef3:	6a 00                	push   $0x0
  802ef5:	6a 00                	push   $0x0
  802ef7:	6a 25                	push   $0x25
  802ef9:	e8 83 fb ff ff       	call   802a81 <syscall>
  802efe:	83 c4 18             	add    $0x18,%esp
}
  802f01:	c9                   	leave  
  802f02:	c3                   	ret    

00802f03 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802f03:	55                   	push   %ebp
  802f04:	89 e5                	mov    %esp,%ebp
  802f06:	83 ec 04             	sub    $0x4,%esp
  802f09:	8b 45 08             	mov    0x8(%ebp),%eax
  802f0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802f0f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802f13:	6a 00                	push   $0x0
  802f15:	6a 00                	push   $0x0
  802f17:	6a 00                	push   $0x0
  802f19:	6a 00                	push   $0x0
  802f1b:	50                   	push   %eax
  802f1c:	6a 26                	push   $0x26
  802f1e:	e8 5e fb ff ff       	call   802a81 <syscall>
  802f23:	83 c4 18             	add    $0x18,%esp
	return ;
  802f26:	90                   	nop
}
  802f27:	c9                   	leave  
  802f28:	c3                   	ret    

00802f29 <rsttst>:
void rsttst()
{
  802f29:	55                   	push   %ebp
  802f2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802f2c:	6a 00                	push   $0x0
  802f2e:	6a 00                	push   $0x0
  802f30:	6a 00                	push   $0x0
  802f32:	6a 00                	push   $0x0
  802f34:	6a 00                	push   $0x0
  802f36:	6a 28                	push   $0x28
  802f38:	e8 44 fb ff ff       	call   802a81 <syscall>
  802f3d:	83 c4 18             	add    $0x18,%esp
	return ;
  802f40:	90                   	nop
}
  802f41:	c9                   	leave  
  802f42:	c3                   	ret    

00802f43 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802f43:	55                   	push   %ebp
  802f44:	89 e5                	mov    %esp,%ebp
  802f46:	83 ec 04             	sub    $0x4,%esp
  802f49:	8b 45 14             	mov    0x14(%ebp),%eax
  802f4c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802f4f:	8b 55 18             	mov    0x18(%ebp),%edx
  802f52:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802f56:	52                   	push   %edx
  802f57:	50                   	push   %eax
  802f58:	ff 75 10             	pushl  0x10(%ebp)
  802f5b:	ff 75 0c             	pushl  0xc(%ebp)
  802f5e:	ff 75 08             	pushl  0x8(%ebp)
  802f61:	6a 27                	push   $0x27
  802f63:	e8 19 fb ff ff       	call   802a81 <syscall>
  802f68:	83 c4 18             	add    $0x18,%esp
	return ;
  802f6b:	90                   	nop
}
  802f6c:	c9                   	leave  
  802f6d:	c3                   	ret    

00802f6e <chktst>:
void chktst(uint32 n)
{
  802f6e:	55                   	push   %ebp
  802f6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802f71:	6a 00                	push   $0x0
  802f73:	6a 00                	push   $0x0
  802f75:	6a 00                	push   $0x0
  802f77:	6a 00                	push   $0x0
  802f79:	ff 75 08             	pushl  0x8(%ebp)
  802f7c:	6a 29                	push   $0x29
  802f7e:	e8 fe fa ff ff       	call   802a81 <syscall>
  802f83:	83 c4 18             	add    $0x18,%esp
	return ;
  802f86:	90                   	nop
}
  802f87:	c9                   	leave  
  802f88:	c3                   	ret    

00802f89 <inctst>:

void inctst()
{
  802f89:	55                   	push   %ebp
  802f8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802f8c:	6a 00                	push   $0x0
  802f8e:	6a 00                	push   $0x0
  802f90:	6a 00                	push   $0x0
  802f92:	6a 00                	push   $0x0
  802f94:	6a 00                	push   $0x0
  802f96:	6a 2a                	push   $0x2a
  802f98:	e8 e4 fa ff ff       	call   802a81 <syscall>
  802f9d:	83 c4 18             	add    $0x18,%esp
	return ;
  802fa0:	90                   	nop
}
  802fa1:	c9                   	leave  
  802fa2:	c3                   	ret    

00802fa3 <gettst>:
uint32 gettst()
{
  802fa3:	55                   	push   %ebp
  802fa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802fa6:	6a 00                	push   $0x0
  802fa8:	6a 00                	push   $0x0
  802faa:	6a 00                	push   $0x0
  802fac:	6a 00                	push   $0x0
  802fae:	6a 00                	push   $0x0
  802fb0:	6a 2b                	push   $0x2b
  802fb2:	e8 ca fa ff ff       	call   802a81 <syscall>
  802fb7:	83 c4 18             	add    $0x18,%esp
}
  802fba:	c9                   	leave  
  802fbb:	c3                   	ret    

00802fbc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802fbc:	55                   	push   %ebp
  802fbd:	89 e5                	mov    %esp,%ebp
  802fbf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802fc2:	6a 00                	push   $0x0
  802fc4:	6a 00                	push   $0x0
  802fc6:	6a 00                	push   $0x0
  802fc8:	6a 00                	push   $0x0
  802fca:	6a 00                	push   $0x0
  802fcc:	6a 2c                	push   $0x2c
  802fce:	e8 ae fa ff ff       	call   802a81 <syscall>
  802fd3:	83 c4 18             	add    $0x18,%esp
  802fd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802fd9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802fdd:	75 07                	jne    802fe6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802fdf:	b8 01 00 00 00       	mov    $0x1,%eax
  802fe4:	eb 05                	jmp    802feb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802fe6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802feb:	c9                   	leave  
  802fec:	c3                   	ret    

00802fed <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802fed:	55                   	push   %ebp
  802fee:	89 e5                	mov    %esp,%ebp
  802ff0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802ff3:	6a 00                	push   $0x0
  802ff5:	6a 00                	push   $0x0
  802ff7:	6a 00                	push   $0x0
  802ff9:	6a 00                	push   $0x0
  802ffb:	6a 00                	push   $0x0
  802ffd:	6a 2c                	push   $0x2c
  802fff:	e8 7d fa ff ff       	call   802a81 <syscall>
  803004:	83 c4 18             	add    $0x18,%esp
  803007:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80300a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80300e:	75 07                	jne    803017 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  803010:	b8 01 00 00 00       	mov    $0x1,%eax
  803015:	eb 05                	jmp    80301c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  803017:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80301c:	c9                   	leave  
  80301d:	c3                   	ret    

0080301e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80301e:	55                   	push   %ebp
  80301f:	89 e5                	mov    %esp,%ebp
  803021:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803024:	6a 00                	push   $0x0
  803026:	6a 00                	push   $0x0
  803028:	6a 00                	push   $0x0
  80302a:	6a 00                	push   $0x0
  80302c:	6a 00                	push   $0x0
  80302e:	6a 2c                	push   $0x2c
  803030:	e8 4c fa ff ff       	call   802a81 <syscall>
  803035:	83 c4 18             	add    $0x18,%esp
  803038:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80303b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80303f:	75 07                	jne    803048 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  803041:	b8 01 00 00 00       	mov    $0x1,%eax
  803046:	eb 05                	jmp    80304d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  803048:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80304d:	c9                   	leave  
  80304e:	c3                   	ret    

0080304f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80304f:	55                   	push   %ebp
  803050:	89 e5                	mov    %esp,%ebp
  803052:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803055:	6a 00                	push   $0x0
  803057:	6a 00                	push   $0x0
  803059:	6a 00                	push   $0x0
  80305b:	6a 00                	push   $0x0
  80305d:	6a 00                	push   $0x0
  80305f:	6a 2c                	push   $0x2c
  803061:	e8 1b fa ff ff       	call   802a81 <syscall>
  803066:	83 c4 18             	add    $0x18,%esp
  803069:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80306c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803070:	75 07                	jne    803079 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803072:	b8 01 00 00 00       	mov    $0x1,%eax
  803077:	eb 05                	jmp    80307e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803079:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80307e:	c9                   	leave  
  80307f:	c3                   	ret    

00803080 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  803080:	55                   	push   %ebp
  803081:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  803083:	6a 00                	push   $0x0
  803085:	6a 00                	push   $0x0
  803087:	6a 00                	push   $0x0
  803089:	6a 00                	push   $0x0
  80308b:	ff 75 08             	pushl  0x8(%ebp)
  80308e:	6a 2d                	push   $0x2d
  803090:	e8 ec f9 ff ff       	call   802a81 <syscall>
  803095:	83 c4 18             	add    $0x18,%esp
	return ;
  803098:	90                   	nop
}
  803099:	c9                   	leave  
  80309a:	c3                   	ret    
  80309b:	90                   	nop

0080309c <__udivdi3>:
  80309c:	55                   	push   %ebp
  80309d:	57                   	push   %edi
  80309e:	56                   	push   %esi
  80309f:	53                   	push   %ebx
  8030a0:	83 ec 1c             	sub    $0x1c,%esp
  8030a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8030a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8030ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8030af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8030b3:	89 ca                	mov    %ecx,%edx
  8030b5:	89 f8                	mov    %edi,%eax
  8030b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8030bb:	85 f6                	test   %esi,%esi
  8030bd:	75 2d                	jne    8030ec <__udivdi3+0x50>
  8030bf:	39 cf                	cmp    %ecx,%edi
  8030c1:	77 65                	ja     803128 <__udivdi3+0x8c>
  8030c3:	89 fd                	mov    %edi,%ebp
  8030c5:	85 ff                	test   %edi,%edi
  8030c7:	75 0b                	jne    8030d4 <__udivdi3+0x38>
  8030c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8030ce:	31 d2                	xor    %edx,%edx
  8030d0:	f7 f7                	div    %edi
  8030d2:	89 c5                	mov    %eax,%ebp
  8030d4:	31 d2                	xor    %edx,%edx
  8030d6:	89 c8                	mov    %ecx,%eax
  8030d8:	f7 f5                	div    %ebp
  8030da:	89 c1                	mov    %eax,%ecx
  8030dc:	89 d8                	mov    %ebx,%eax
  8030de:	f7 f5                	div    %ebp
  8030e0:	89 cf                	mov    %ecx,%edi
  8030e2:	89 fa                	mov    %edi,%edx
  8030e4:	83 c4 1c             	add    $0x1c,%esp
  8030e7:	5b                   	pop    %ebx
  8030e8:	5e                   	pop    %esi
  8030e9:	5f                   	pop    %edi
  8030ea:	5d                   	pop    %ebp
  8030eb:	c3                   	ret    
  8030ec:	39 ce                	cmp    %ecx,%esi
  8030ee:	77 28                	ja     803118 <__udivdi3+0x7c>
  8030f0:	0f bd fe             	bsr    %esi,%edi
  8030f3:	83 f7 1f             	xor    $0x1f,%edi
  8030f6:	75 40                	jne    803138 <__udivdi3+0x9c>
  8030f8:	39 ce                	cmp    %ecx,%esi
  8030fa:	72 0a                	jb     803106 <__udivdi3+0x6a>
  8030fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  803100:	0f 87 9e 00 00 00    	ja     8031a4 <__udivdi3+0x108>
  803106:	b8 01 00 00 00       	mov    $0x1,%eax
  80310b:	89 fa                	mov    %edi,%edx
  80310d:	83 c4 1c             	add    $0x1c,%esp
  803110:	5b                   	pop    %ebx
  803111:	5e                   	pop    %esi
  803112:	5f                   	pop    %edi
  803113:	5d                   	pop    %ebp
  803114:	c3                   	ret    
  803115:	8d 76 00             	lea    0x0(%esi),%esi
  803118:	31 ff                	xor    %edi,%edi
  80311a:	31 c0                	xor    %eax,%eax
  80311c:	89 fa                	mov    %edi,%edx
  80311e:	83 c4 1c             	add    $0x1c,%esp
  803121:	5b                   	pop    %ebx
  803122:	5e                   	pop    %esi
  803123:	5f                   	pop    %edi
  803124:	5d                   	pop    %ebp
  803125:	c3                   	ret    
  803126:	66 90                	xchg   %ax,%ax
  803128:	89 d8                	mov    %ebx,%eax
  80312a:	f7 f7                	div    %edi
  80312c:	31 ff                	xor    %edi,%edi
  80312e:	89 fa                	mov    %edi,%edx
  803130:	83 c4 1c             	add    $0x1c,%esp
  803133:	5b                   	pop    %ebx
  803134:	5e                   	pop    %esi
  803135:	5f                   	pop    %edi
  803136:	5d                   	pop    %ebp
  803137:	c3                   	ret    
  803138:	bd 20 00 00 00       	mov    $0x20,%ebp
  80313d:	89 eb                	mov    %ebp,%ebx
  80313f:	29 fb                	sub    %edi,%ebx
  803141:	89 f9                	mov    %edi,%ecx
  803143:	d3 e6                	shl    %cl,%esi
  803145:	89 c5                	mov    %eax,%ebp
  803147:	88 d9                	mov    %bl,%cl
  803149:	d3 ed                	shr    %cl,%ebp
  80314b:	89 e9                	mov    %ebp,%ecx
  80314d:	09 f1                	or     %esi,%ecx
  80314f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  803153:	89 f9                	mov    %edi,%ecx
  803155:	d3 e0                	shl    %cl,%eax
  803157:	89 c5                	mov    %eax,%ebp
  803159:	89 d6                	mov    %edx,%esi
  80315b:	88 d9                	mov    %bl,%cl
  80315d:	d3 ee                	shr    %cl,%esi
  80315f:	89 f9                	mov    %edi,%ecx
  803161:	d3 e2                	shl    %cl,%edx
  803163:	8b 44 24 08          	mov    0x8(%esp),%eax
  803167:	88 d9                	mov    %bl,%cl
  803169:	d3 e8                	shr    %cl,%eax
  80316b:	09 c2                	or     %eax,%edx
  80316d:	89 d0                	mov    %edx,%eax
  80316f:	89 f2                	mov    %esi,%edx
  803171:	f7 74 24 0c          	divl   0xc(%esp)
  803175:	89 d6                	mov    %edx,%esi
  803177:	89 c3                	mov    %eax,%ebx
  803179:	f7 e5                	mul    %ebp
  80317b:	39 d6                	cmp    %edx,%esi
  80317d:	72 19                	jb     803198 <__udivdi3+0xfc>
  80317f:	74 0b                	je     80318c <__udivdi3+0xf0>
  803181:	89 d8                	mov    %ebx,%eax
  803183:	31 ff                	xor    %edi,%edi
  803185:	e9 58 ff ff ff       	jmp    8030e2 <__udivdi3+0x46>
  80318a:	66 90                	xchg   %ax,%ax
  80318c:	8b 54 24 08          	mov    0x8(%esp),%edx
  803190:	89 f9                	mov    %edi,%ecx
  803192:	d3 e2                	shl    %cl,%edx
  803194:	39 c2                	cmp    %eax,%edx
  803196:	73 e9                	jae    803181 <__udivdi3+0xe5>
  803198:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80319b:	31 ff                	xor    %edi,%edi
  80319d:	e9 40 ff ff ff       	jmp    8030e2 <__udivdi3+0x46>
  8031a2:	66 90                	xchg   %ax,%ax
  8031a4:	31 c0                	xor    %eax,%eax
  8031a6:	e9 37 ff ff ff       	jmp    8030e2 <__udivdi3+0x46>
  8031ab:	90                   	nop

008031ac <__umoddi3>:
  8031ac:	55                   	push   %ebp
  8031ad:	57                   	push   %edi
  8031ae:	56                   	push   %esi
  8031af:	53                   	push   %ebx
  8031b0:	83 ec 1c             	sub    $0x1c,%esp
  8031b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8031b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8031bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8031bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8031c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8031c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8031cb:	89 f3                	mov    %esi,%ebx
  8031cd:	89 fa                	mov    %edi,%edx
  8031cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8031d3:	89 34 24             	mov    %esi,(%esp)
  8031d6:	85 c0                	test   %eax,%eax
  8031d8:	75 1a                	jne    8031f4 <__umoddi3+0x48>
  8031da:	39 f7                	cmp    %esi,%edi
  8031dc:	0f 86 a2 00 00 00    	jbe    803284 <__umoddi3+0xd8>
  8031e2:	89 c8                	mov    %ecx,%eax
  8031e4:	89 f2                	mov    %esi,%edx
  8031e6:	f7 f7                	div    %edi
  8031e8:	89 d0                	mov    %edx,%eax
  8031ea:	31 d2                	xor    %edx,%edx
  8031ec:	83 c4 1c             	add    $0x1c,%esp
  8031ef:	5b                   	pop    %ebx
  8031f0:	5e                   	pop    %esi
  8031f1:	5f                   	pop    %edi
  8031f2:	5d                   	pop    %ebp
  8031f3:	c3                   	ret    
  8031f4:	39 f0                	cmp    %esi,%eax
  8031f6:	0f 87 ac 00 00 00    	ja     8032a8 <__umoddi3+0xfc>
  8031fc:	0f bd e8             	bsr    %eax,%ebp
  8031ff:	83 f5 1f             	xor    $0x1f,%ebp
  803202:	0f 84 ac 00 00 00    	je     8032b4 <__umoddi3+0x108>
  803208:	bf 20 00 00 00       	mov    $0x20,%edi
  80320d:	29 ef                	sub    %ebp,%edi
  80320f:	89 fe                	mov    %edi,%esi
  803211:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803215:	89 e9                	mov    %ebp,%ecx
  803217:	d3 e0                	shl    %cl,%eax
  803219:	89 d7                	mov    %edx,%edi
  80321b:	89 f1                	mov    %esi,%ecx
  80321d:	d3 ef                	shr    %cl,%edi
  80321f:	09 c7                	or     %eax,%edi
  803221:	89 e9                	mov    %ebp,%ecx
  803223:	d3 e2                	shl    %cl,%edx
  803225:	89 14 24             	mov    %edx,(%esp)
  803228:	89 d8                	mov    %ebx,%eax
  80322a:	d3 e0                	shl    %cl,%eax
  80322c:	89 c2                	mov    %eax,%edx
  80322e:	8b 44 24 08          	mov    0x8(%esp),%eax
  803232:	d3 e0                	shl    %cl,%eax
  803234:	89 44 24 04          	mov    %eax,0x4(%esp)
  803238:	8b 44 24 08          	mov    0x8(%esp),%eax
  80323c:	89 f1                	mov    %esi,%ecx
  80323e:	d3 e8                	shr    %cl,%eax
  803240:	09 d0                	or     %edx,%eax
  803242:	d3 eb                	shr    %cl,%ebx
  803244:	89 da                	mov    %ebx,%edx
  803246:	f7 f7                	div    %edi
  803248:	89 d3                	mov    %edx,%ebx
  80324a:	f7 24 24             	mull   (%esp)
  80324d:	89 c6                	mov    %eax,%esi
  80324f:	89 d1                	mov    %edx,%ecx
  803251:	39 d3                	cmp    %edx,%ebx
  803253:	0f 82 87 00 00 00    	jb     8032e0 <__umoddi3+0x134>
  803259:	0f 84 91 00 00 00    	je     8032f0 <__umoddi3+0x144>
  80325f:	8b 54 24 04          	mov    0x4(%esp),%edx
  803263:	29 f2                	sub    %esi,%edx
  803265:	19 cb                	sbb    %ecx,%ebx
  803267:	89 d8                	mov    %ebx,%eax
  803269:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80326d:	d3 e0                	shl    %cl,%eax
  80326f:	89 e9                	mov    %ebp,%ecx
  803271:	d3 ea                	shr    %cl,%edx
  803273:	09 d0                	or     %edx,%eax
  803275:	89 e9                	mov    %ebp,%ecx
  803277:	d3 eb                	shr    %cl,%ebx
  803279:	89 da                	mov    %ebx,%edx
  80327b:	83 c4 1c             	add    $0x1c,%esp
  80327e:	5b                   	pop    %ebx
  80327f:	5e                   	pop    %esi
  803280:	5f                   	pop    %edi
  803281:	5d                   	pop    %ebp
  803282:	c3                   	ret    
  803283:	90                   	nop
  803284:	89 fd                	mov    %edi,%ebp
  803286:	85 ff                	test   %edi,%edi
  803288:	75 0b                	jne    803295 <__umoddi3+0xe9>
  80328a:	b8 01 00 00 00       	mov    $0x1,%eax
  80328f:	31 d2                	xor    %edx,%edx
  803291:	f7 f7                	div    %edi
  803293:	89 c5                	mov    %eax,%ebp
  803295:	89 f0                	mov    %esi,%eax
  803297:	31 d2                	xor    %edx,%edx
  803299:	f7 f5                	div    %ebp
  80329b:	89 c8                	mov    %ecx,%eax
  80329d:	f7 f5                	div    %ebp
  80329f:	89 d0                	mov    %edx,%eax
  8032a1:	e9 44 ff ff ff       	jmp    8031ea <__umoddi3+0x3e>
  8032a6:	66 90                	xchg   %ax,%ax
  8032a8:	89 c8                	mov    %ecx,%eax
  8032aa:	89 f2                	mov    %esi,%edx
  8032ac:	83 c4 1c             	add    $0x1c,%esp
  8032af:	5b                   	pop    %ebx
  8032b0:	5e                   	pop    %esi
  8032b1:	5f                   	pop    %edi
  8032b2:	5d                   	pop    %ebp
  8032b3:	c3                   	ret    
  8032b4:	3b 04 24             	cmp    (%esp),%eax
  8032b7:	72 06                	jb     8032bf <__umoddi3+0x113>
  8032b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8032bd:	77 0f                	ja     8032ce <__umoddi3+0x122>
  8032bf:	89 f2                	mov    %esi,%edx
  8032c1:	29 f9                	sub    %edi,%ecx
  8032c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8032c7:	89 14 24             	mov    %edx,(%esp)
  8032ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8032ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8032d2:	8b 14 24             	mov    (%esp),%edx
  8032d5:	83 c4 1c             	add    $0x1c,%esp
  8032d8:	5b                   	pop    %ebx
  8032d9:	5e                   	pop    %esi
  8032da:	5f                   	pop    %edi
  8032db:	5d                   	pop    %ebp
  8032dc:	c3                   	ret    
  8032dd:	8d 76 00             	lea    0x0(%esi),%esi
  8032e0:	2b 04 24             	sub    (%esp),%eax
  8032e3:	19 fa                	sbb    %edi,%edx
  8032e5:	89 d1                	mov    %edx,%ecx
  8032e7:	89 c6                	mov    %eax,%esi
  8032e9:	e9 71 ff ff ff       	jmp    80325f <__umoddi3+0xb3>
  8032ee:	66 90                	xchg   %ax,%ax
  8032f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8032f4:	72 ea                	jb     8032e0 <__umoddi3+0x134>
  8032f6:	89 d9                	mov    %ebx,%ecx
  8032f8:	e9 62 ff ff ff       	jmp    80325f <__umoddi3+0xb3>
