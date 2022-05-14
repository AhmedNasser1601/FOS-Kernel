
obj/user/tst_malloc_1:     file format elf32-i386


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
  800031:	e8 97 05 00 00       	call   8005cd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800040:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800044:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004b:	eb 29                	jmp    800076 <_main+0x3e>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004d:	a1 20 30 80 00       	mov    0x803020,%eax
  800052:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800058:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005b:	89 d0                	mov    %edx,%eax
  80005d:	01 c0                	add    %eax,%eax
  80005f:	01 d0                	add    %edx,%eax
  800061:	c1 e0 02             	shl    $0x2,%eax
  800064:	01 c8                	add    %ecx,%eax
  800066:	8a 40 04             	mov    0x4(%eax),%al
  800069:	84 c0                	test   %al,%al
  80006b:	74 06                	je     800073 <_main+0x3b>
			{
				fullWS = 0;
  80006d:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800071:	eb 12                	jmp    800085 <_main+0x4d>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800073:	ff 45 f0             	incl   -0x10(%ebp)
  800076:	a1 20 30 80 00       	mov    0x803020,%eax
  80007b:	8b 50 74             	mov    0x74(%eax),%edx
  80007e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800081:	39 c2                	cmp    %eax,%edx
  800083:	77 c8                	ja     80004d <_main+0x15>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800085:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800089:	74 14                	je     80009f <_main+0x67>
  80008b:	83 ec 04             	sub    $0x4,%esp
  80008e:	68 40 22 80 00       	push   $0x802240
  800093:	6a 14                	push   $0x14
  800095:	68 5c 22 80 00       	push   $0x80225c
  80009a:	e8 3d 06 00 00       	call   8006dc <_panic>
	}


	int Mega = 1024*1024;
  80009f:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a6:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	void* ptr_allocations[20] = {0};
  8000ad:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ba:	89 d7                	mov    %edx,%edi
  8000bc:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000be:	e8 62 1a 00 00       	call   801b25 <sys_calculate_free_frames>
  8000c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000c6:	e8 dd 1a 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8000cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d1:	01 c0                	add    %eax,%eax
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 ec 0c             	sub    $0xc,%esp
  8000d9:	50                   	push   %eax
  8000da:	e8 3b 16 00 00       	call   80171a <malloc>
  8000df:	83 c4 10             	add    $0x10,%esp
  8000e2:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8000e5:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e8:	85 c0                	test   %eax,%eax
  8000ea:	79 0a                	jns    8000f6 <_main+0xbe>
  8000ec:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000ef:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  8000f4:	76 14                	jbe    80010a <_main+0xd2>
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	68 70 22 80 00       	push   $0x802270
  8000fe:	6a 20                	push   $0x20
  800100:	68 5c 22 80 00       	push   $0x80225c
  800105:	e8 d2 05 00 00       	call   8006dc <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80010a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80010d:	e8 13 1a 00 00       	call   801b25 <sys_calculate_free_frames>
  800112:	29 c3                	sub    %eax,%ebx
  800114:	89 d8                	mov    %ebx,%eax
  800116:	83 f8 01             	cmp    $0x1,%eax
  800119:	74 14                	je     80012f <_main+0xf7>
  80011b:	83 ec 04             	sub    $0x4,%esp
  80011e:	68 a0 22 80 00       	push   $0x8022a0
  800123:	6a 22                	push   $0x22
  800125:	68 5c 22 80 00       	push   $0x80225c
  80012a:	e8 ad 05 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80012f:	e8 74 1a 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800134:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800137:	3d 00 02 00 00       	cmp    $0x200,%eax
  80013c:	74 14                	je     800152 <_main+0x11a>
  80013e:	83 ec 04             	sub    $0x4,%esp
  800141:	68 0c 23 80 00       	push   $0x80230c
  800146:	6a 23                	push   $0x23
  800148:	68 5c 22 80 00       	push   $0x80225c
  80014d:	e8 8a 05 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800152:	e8 ce 19 00 00       	call   801b25 <sys_calculate_free_frames>
  800157:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80015a:	e8 49 1a 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  80015f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800162:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800165:	01 c0                	add    %eax,%eax
  800167:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	50                   	push   %eax
  80016e:	e8 a7 15 00 00       	call   80171a <malloc>
  800173:	83 c4 10             	add    $0x10,%esp
  800176:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START + 2*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800179:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80017c:	89 c2                	mov    %eax,%edx
  80017e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800181:	01 c0                	add    %eax,%eax
  800183:	05 00 00 00 80       	add    $0x80000000,%eax
  800188:	39 c2                	cmp    %eax,%edx
  80018a:	72 13                	jb     80019f <_main+0x167>
  80018c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018f:	89 c2                	mov    %eax,%edx
  800191:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800194:	01 c0                	add    %eax,%eax
  800196:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80019b:	39 c2                	cmp    %eax,%edx
  80019d:	76 14                	jbe    8001b3 <_main+0x17b>
  80019f:	83 ec 04             	sub    $0x4,%esp
  8001a2:	68 70 22 80 00       	push   $0x802270
  8001a7:	6a 28                	push   $0x28
  8001a9:	68 5c 22 80 00       	push   $0x80225c
  8001ae:	e8 29 05 00 00       	call   8006dc <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001b3:	e8 6d 19 00 00       	call   801b25 <sys_calculate_free_frames>
  8001b8:	89 c2                	mov    %eax,%edx
  8001ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001bd:	39 c2                	cmp    %eax,%edx
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 a0 22 80 00       	push   $0x8022a0
  8001c9:	6a 2a                	push   $0x2a
  8001cb:	68 5c 22 80 00       	push   $0x80225c
  8001d0:	e8 07 05 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001d5:	e8 ce 19 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8001da:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001dd:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001e2:	74 14                	je     8001f8 <_main+0x1c0>
  8001e4:	83 ec 04             	sub    $0x4,%esp
  8001e7:	68 0c 23 80 00       	push   $0x80230c
  8001ec:	6a 2b                	push   $0x2b
  8001ee:	68 5c 22 80 00       	push   $0x80225c
  8001f3:	e8 e4 04 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8001f8:	e8 28 19 00 00       	call   801b25 <sys_calculate_free_frames>
  8001fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800200:	e8 a3 19 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800205:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800208:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80020b:	01 c0                	add    %eax,%eax
  80020d:	83 ec 0c             	sub    $0xc,%esp
  800210:	50                   	push   %eax
  800211:	e8 04 15 00 00       	call   80171a <malloc>
  800216:	83 c4 10             	add    $0x10,%esp
  800219:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START + 4*Mega + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80021c:	8b 45 98             	mov    -0x68(%ebp),%eax
  80021f:	89 c2                	mov    %eax,%edx
  800221:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800224:	c1 e0 02             	shl    $0x2,%eax
  800227:	05 00 00 00 80       	add    $0x80000000,%eax
  80022c:	39 c2                	cmp    %eax,%edx
  80022e:	72 14                	jb     800244 <_main+0x20c>
  800230:	8b 45 98             	mov    -0x68(%ebp),%eax
  800233:	89 c2                	mov    %eax,%edx
  800235:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800238:	c1 e0 02             	shl    $0x2,%eax
  80023b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800240:	39 c2                	cmp    %eax,%edx
  800242:	76 14                	jbe    800258 <_main+0x220>
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	68 70 22 80 00       	push   $0x802270
  80024c:	6a 30                	push   $0x30
  80024e:	68 5c 22 80 00       	push   $0x80225c
  800253:	e8 84 04 00 00       	call   8006dc <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800258:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80025b:	e8 c5 18 00 00       	call   801b25 <sys_calculate_free_frames>
  800260:	29 c3                	sub    %eax,%ebx
  800262:	89 d8                	mov    %ebx,%eax
  800264:	83 f8 01             	cmp    $0x1,%eax
  800267:	74 14                	je     80027d <_main+0x245>
  800269:	83 ec 04             	sub    $0x4,%esp
  80026c:	68 a0 22 80 00       	push   $0x8022a0
  800271:	6a 32                	push   $0x32
  800273:	68 5c 22 80 00       	push   $0x80225c
  800278:	e8 5f 04 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80027d:	e8 26 19 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800282:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800285:	83 f8 01             	cmp    $0x1,%eax
  800288:	74 14                	je     80029e <_main+0x266>
  80028a:	83 ec 04             	sub    $0x4,%esp
  80028d:	68 0c 23 80 00       	push   $0x80230c
  800292:	6a 33                	push   $0x33
  800294:	68 5c 22 80 00       	push   $0x80225c
  800299:	e8 3e 04 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80029e:	e8 82 18 00 00       	call   801b25 <sys_calculate_free_frames>
  8002a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002a6:	e8 fd 18 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8002ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8002ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002b1:	01 c0                	add    %eax,%eax
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	50                   	push   %eax
  8002b7:	e8 5e 14 00 00       	call   80171a <malloc>
  8002bc:	83 c4 10             	add    $0x10,%esp
  8002bf:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  8002c2:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002c5:	89 c2                	mov    %eax,%edx
  8002c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002ca:	c1 e0 02             	shl    $0x2,%eax
  8002cd:	89 c1                	mov    %eax,%ecx
  8002cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d2:	c1 e0 02             	shl    $0x2,%eax
  8002d5:	01 c8                	add    %ecx,%eax
  8002d7:	05 00 00 00 80       	add    $0x80000000,%eax
  8002dc:	39 c2                	cmp    %eax,%edx
  8002de:	72 1e                	jb     8002fe <_main+0x2c6>
  8002e0:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002e3:	89 c2                	mov    %eax,%edx
  8002e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002e8:	c1 e0 02             	shl    $0x2,%eax
  8002eb:	89 c1                	mov    %eax,%ecx
  8002ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f0:	c1 e0 02             	shl    $0x2,%eax
  8002f3:	01 c8                	add    %ecx,%eax
  8002f5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002fa:	39 c2                	cmp    %eax,%edx
  8002fc:	76 14                	jbe    800312 <_main+0x2da>
  8002fe:	83 ec 04             	sub    $0x4,%esp
  800301:	68 70 22 80 00       	push   $0x802270
  800306:	6a 38                	push   $0x38
  800308:	68 5c 22 80 00       	push   $0x80225c
  80030d:	e8 ca 03 00 00       	call   8006dc <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800312:	e8 0e 18 00 00       	call   801b25 <sys_calculate_free_frames>
  800317:	89 c2                	mov    %eax,%edx
  800319:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80031c:	39 c2                	cmp    %eax,%edx
  80031e:	74 14                	je     800334 <_main+0x2fc>
  800320:	83 ec 04             	sub    $0x4,%esp
  800323:	68 a0 22 80 00       	push   $0x8022a0
  800328:	6a 3a                	push   $0x3a
  80032a:	68 5c 22 80 00       	push   $0x80225c
  80032f:	e8 a8 03 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800334:	e8 6f 18 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800339:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80033c:	83 f8 01             	cmp    $0x1,%eax
  80033f:	74 14                	je     800355 <_main+0x31d>
  800341:	83 ec 04             	sub    $0x4,%esp
  800344:	68 0c 23 80 00       	push   $0x80230c
  800349:	6a 3b                	push   $0x3b
  80034b:	68 5c 22 80 00       	push   $0x80225c
  800350:	e8 87 03 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800355:	e8 cb 17 00 00       	call   801b25 <sys_calculate_free_frames>
  80035a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80035d:	e8 46 18 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800362:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800365:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800368:	89 d0                	mov    %edx,%eax
  80036a:	01 c0                	add    %eax,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	01 c0                	add    %eax,%eax
  800370:	01 d0                	add    %edx,%eax
  800372:	83 ec 0c             	sub    $0xc,%esp
  800375:	50                   	push   %eax
  800376:	e8 9f 13 00 00       	call   80171a <malloc>
  80037b:	83 c4 10             	add    $0x10,%esp
  80037e:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo) || (uint32) ptr_allocations[4] > (USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  800381:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800384:	89 c2                	mov    %eax,%edx
  800386:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800389:	c1 e0 02             	shl    $0x2,%eax
  80038c:	89 c1                	mov    %eax,%ecx
  80038e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800391:	c1 e0 03             	shl    $0x3,%eax
  800394:	01 c8                	add    %ecx,%eax
  800396:	05 00 00 00 80       	add    $0x80000000,%eax
  80039b:	39 c2                	cmp    %eax,%edx
  80039d:	72 1e                	jb     8003bd <_main+0x385>
  80039f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003a2:	89 c2                	mov    %eax,%edx
  8003a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003a7:	c1 e0 02             	shl    $0x2,%eax
  8003aa:	89 c1                	mov    %eax,%ecx
  8003ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003af:	c1 e0 03             	shl    $0x3,%eax
  8003b2:	01 c8                	add    %ecx,%eax
  8003b4:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8003b9:	39 c2                	cmp    %eax,%edx
  8003bb:	76 14                	jbe    8003d1 <_main+0x399>
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	68 70 22 80 00       	push   $0x802270
  8003c5:	6a 40                	push   $0x40
  8003c7:	68 5c 22 80 00       	push   $0x80225c
  8003cc:	e8 0b 03 00 00       	call   8006dc <_panic>
		//		if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003d1:	e8 4f 17 00 00       	call   801b25 <sys_calculate_free_frames>
  8003d6:	89 c2                	mov    %eax,%edx
  8003d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	74 14                	je     8003f3 <_main+0x3bb>
  8003df:	83 ec 04             	sub    $0x4,%esp
  8003e2:	68 a0 22 80 00       	push   $0x8022a0
  8003e7:	6a 42                	push   $0x42
  8003e9:	68 5c 22 80 00       	push   $0x80225c
  8003ee:	e8 e9 02 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8003f3:	e8 b0 17 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8003f8:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003fb:	83 f8 02             	cmp    $0x2,%eax
  8003fe:	74 14                	je     800414 <_main+0x3dc>
  800400:	83 ec 04             	sub    $0x4,%esp
  800403:	68 0c 23 80 00       	push   $0x80230c
  800408:	6a 43                	push   $0x43
  80040a:	68 5c 22 80 00       	push   $0x80225c
  80040f:	e8 c8 02 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800414:	e8 0c 17 00 00       	call   801b25 <sys_calculate_free_frames>
  800419:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041c:	e8 87 17 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800421:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800424:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800427:	89 c2                	mov    %eax,%edx
  800429:	01 d2                	add    %edx,%edx
  80042b:	01 d0                	add    %edx,%eax
  80042d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	50                   	push   %eax
  800434:	e8 e1 12 00 00       	call   80171a <malloc>
  800439:	83 c4 10             	add    $0x10,%esp
  80043c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80043f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800442:	89 c2                	mov    %eax,%edx
  800444:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800447:	c1 e0 02             	shl    $0x2,%eax
  80044a:	89 c1                	mov    %eax,%ecx
  80044c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80044f:	c1 e0 04             	shl    $0x4,%eax
  800452:	01 c8                	add    %ecx,%eax
  800454:	05 00 00 00 80       	add    $0x80000000,%eax
  800459:	39 c2                	cmp    %eax,%edx
  80045b:	72 1e                	jb     80047b <_main+0x443>
  80045d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800460:	89 c2                	mov    %eax,%edx
  800462:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800465:	c1 e0 02             	shl    $0x2,%eax
  800468:	89 c1                	mov    %eax,%ecx
  80046a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80046d:	c1 e0 04             	shl    $0x4,%eax
  800470:	01 c8                	add    %ecx,%eax
  800472:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800477:	39 c2                	cmp    %eax,%edx
  800479:	76 14                	jbe    80048f <_main+0x457>
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 70 22 80 00       	push   $0x802270
  800483:	6a 48                	push   $0x48
  800485:	68 5c 22 80 00       	push   $0x80225c
  80048a:	e8 4d 02 00 00       	call   8006dc <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  80048f:	e8 91 16 00 00       	call   801b25 <sys_calculate_free_frames>
  800494:	89 c2                	mov    %eax,%edx
  800496:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800499:	39 c2                	cmp    %eax,%edx
  80049b:	74 14                	je     8004b1 <_main+0x479>
  80049d:	83 ec 04             	sub    $0x4,%esp
  8004a0:	68 3a 23 80 00       	push   $0x80233a
  8004a5:	6a 49                	push   $0x49
  8004a7:	68 5c 22 80 00       	push   $0x80225c
  8004ac:	e8 2b 02 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8004b1:	e8 f2 16 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8004b6:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b9:	89 c2                	mov    %eax,%edx
  8004bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004be:	89 c1                	mov    %eax,%ecx
  8004c0:	01 c9                	add    %ecx,%ecx
  8004c2:	01 c8                	add    %ecx,%eax
  8004c4:	85 c0                	test   %eax,%eax
  8004c6:	79 05                	jns    8004cd <_main+0x495>
  8004c8:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004cd:	c1 f8 0c             	sar    $0xc,%eax
  8004d0:	39 c2                	cmp    %eax,%edx
  8004d2:	74 14                	je     8004e8 <_main+0x4b0>
  8004d4:	83 ec 04             	sub    $0x4,%esp
  8004d7:	68 0c 23 80 00       	push   $0x80230c
  8004dc:	6a 4a                	push   $0x4a
  8004de:	68 5c 22 80 00       	push   $0x80225c
  8004e3:	e8 f4 01 00 00       	call   8006dc <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8004e8:	e8 38 16 00 00       	call   801b25 <sys_calculate_free_frames>
  8004ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004f0:	e8 b3 16 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  8004f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  8004f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fb:	01 c0                	add    %eax,%eax
  8004fd:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800500:	83 ec 0c             	sub    $0xc,%esp
  800503:	50                   	push   %eax
  800504:	e8 11 12 00 00       	call   80171a <malloc>
  800509:	83 c4 10             	add    $0x10,%esp
  80050c:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE)) panic("Wrong start address for the allocated space... ");
  80050f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800512:	89 c1                	mov    %eax,%ecx
  800514:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800517:	89 d0                	mov    %edx,%eax
  800519:	01 c0                	add    %eax,%eax
  80051b:	01 d0                	add    %edx,%eax
  80051d:	01 c0                	add    %eax,%eax
  80051f:	01 d0                	add    %edx,%eax
  800521:	89 c2                	mov    %eax,%edx
  800523:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800526:	c1 e0 04             	shl    $0x4,%eax
  800529:	01 d0                	add    %edx,%eax
  80052b:	05 00 00 00 80       	add    $0x80000000,%eax
  800530:	39 c1                	cmp    %eax,%ecx
  800532:	72 25                	jb     800559 <_main+0x521>
  800534:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800537:	89 c1                	mov    %eax,%ecx
  800539:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80053c:	89 d0                	mov    %edx,%eax
  80053e:	01 c0                	add    %eax,%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	01 c0                	add    %eax,%eax
  800544:	01 d0                	add    %edx,%eax
  800546:	89 c2                	mov    %eax,%edx
  800548:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80054b:	c1 e0 04             	shl    $0x4,%eax
  80054e:	01 d0                	add    %edx,%eax
  800550:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800555:	39 c1                	cmp    %eax,%ecx
  800557:	76 14                	jbe    80056d <_main+0x535>
  800559:	83 ec 04             	sub    $0x4,%esp
  80055c:	68 70 22 80 00       	push   $0x802270
  800561:	6a 4f                	push   $0x4f
  800563:	68 5c 22 80 00       	push   $0x80225c
  800568:	e8 6f 01 00 00       	call   8006dc <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  80056d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800570:	e8 b0 15 00 00       	call   801b25 <sys_calculate_free_frames>
  800575:	29 c3                	sub    %eax,%ebx
  800577:	89 d8                	mov    %ebx,%eax
  800579:	83 f8 01             	cmp    $0x1,%eax
  80057c:	74 14                	je     800592 <_main+0x55a>
  80057e:	83 ec 04             	sub    $0x4,%esp
  800581:	68 3a 23 80 00       	push   $0x80233a
  800586:	6a 50                	push   $0x50
  800588:	68 5c 22 80 00       	push   $0x80225c
  80058d:	e8 4a 01 00 00       	call   8006dc <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800592:	e8 11 16 00 00       	call   801ba8 <sys_pf_calculate_allocated_pages>
  800597:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80059a:	3d 00 02 00 00       	cmp    $0x200,%eax
  80059f:	74 14                	je     8005b5 <_main+0x57d>
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	68 0c 23 80 00       	push   $0x80230c
  8005a9:	6a 51                	push   $0x51
  8005ab:	68 5c 22 80 00       	push   $0x80225c
  8005b0:	e8 27 01 00 00       	call   8006dc <_panic>
	}

	cprintf("Congratulations!! test malloc (1) completed successfully.\n");
  8005b5:	83 ec 0c             	sub    $0xc,%esp
  8005b8:	68 50 23 80 00       	push   $0x802350
  8005bd:	e8 ce 03 00 00       	call   800990 <cprintf>
  8005c2:	83 c4 10             	add    $0x10,%esp

	return;
  8005c5:	90                   	nop
}
  8005c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005c9:	5b                   	pop    %ebx
  8005ca:	5f                   	pop    %edi
  8005cb:	5d                   	pop    %ebp
  8005cc:	c3                   	ret    

008005cd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005cd:	55                   	push   %ebp
  8005ce:	89 e5                	mov    %esp,%ebp
  8005d0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005d3:	e8 82 14 00 00       	call   801a5a <sys_getenvindex>
  8005d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005de:	89 d0                	mov    %edx,%eax
  8005e0:	c1 e0 02             	shl    $0x2,%eax
  8005e3:	01 d0                	add    %edx,%eax
  8005e5:	01 c0                	add    %eax,%eax
  8005e7:	01 d0                	add    %edx,%eax
  8005e9:	01 c0                	add    %eax,%eax
  8005eb:	01 d0                	add    %edx,%eax
  8005ed:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005f4:	01 d0                	add    %edx,%eax
  8005f6:	c1 e0 02             	shl    $0x2,%eax
  8005f9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005fe:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800603:	a1 20 30 80 00       	mov    0x803020,%eax
  800608:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80060e:	84 c0                	test   %al,%al
  800610:	74 0f                	je     800621 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800612:	a1 20 30 80 00       	mov    0x803020,%eax
  800617:	05 f4 02 00 00       	add    $0x2f4,%eax
  80061c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800621:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800625:	7e 0a                	jle    800631 <libmain+0x64>
		binaryname = argv[0];
  800627:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062a:	8b 00                	mov    (%eax),%eax
  80062c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800631:	83 ec 08             	sub    $0x8,%esp
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	ff 75 08             	pushl  0x8(%ebp)
  80063a:	e8 f9 f9 ff ff       	call   800038 <_main>
  80063f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800642:	e8 ae 15 00 00       	call   801bf5 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	68 a4 23 80 00       	push   $0x8023a4
  80064f:	e8 3c 03 00 00       	call   800990 <cprintf>
  800654:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800657:	a1 20 30 80 00       	mov    0x803020,%eax
  80065c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800662:	a1 20 30 80 00       	mov    0x803020,%eax
  800667:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80066d:	83 ec 04             	sub    $0x4,%esp
  800670:	52                   	push   %edx
  800671:	50                   	push   %eax
  800672:	68 cc 23 80 00       	push   $0x8023cc
  800677:	e8 14 03 00 00       	call   800990 <cprintf>
  80067c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067f:	a1 20 30 80 00       	mov    0x803020,%eax
  800684:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	50                   	push   %eax
  80068e:	68 f1 23 80 00       	push   $0x8023f1
  800693:	e8 f8 02 00 00       	call   800990 <cprintf>
  800698:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	68 a4 23 80 00       	push   $0x8023a4
  8006a3:	e8 e8 02 00 00       	call   800990 <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ab:	e8 5f 15 00 00       	call   801c0f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006b0:	e8 19 00 00 00       	call   8006ce <exit>
}
  8006b5:	90                   	nop
  8006b6:	c9                   	leave  
  8006b7:	c3                   	ret    

008006b8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b8:	55                   	push   %ebp
  8006b9:	89 e5                	mov    %esp,%ebp
  8006bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006be:	83 ec 0c             	sub    $0xc,%esp
  8006c1:	6a 00                	push   $0x0
  8006c3:	e8 5e 13 00 00       	call   801a26 <sys_env_destroy>
  8006c8:	83 c4 10             	add    $0x10,%esp
}
  8006cb:	90                   	nop
  8006cc:	c9                   	leave  
  8006cd:	c3                   	ret    

008006ce <exit>:

void
exit(void)
{
  8006ce:	55                   	push   %ebp
  8006cf:	89 e5                	mov    %esp,%ebp
  8006d1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006d4:	e8 b3 13 00 00       	call   801a8c <sys_env_exit>
}
  8006d9:	90                   	nop
  8006da:	c9                   	leave  
  8006db:	c3                   	ret    

008006dc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e5:	83 c0 04             	add    $0x4,%eax
  8006e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006eb:	a1 34 30 80 00       	mov    0x803034,%eax
  8006f0:	85 c0                	test   %eax,%eax
  8006f2:	74 16                	je     80070a <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006f4:	a1 34 30 80 00       	mov    0x803034,%eax
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	50                   	push   %eax
  8006fd:	68 08 24 80 00       	push   $0x802408
  800702:	e8 89 02 00 00       	call   800990 <cprintf>
  800707:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80070a:	a1 00 30 80 00       	mov    0x803000,%eax
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	ff 75 08             	pushl  0x8(%ebp)
  800715:	50                   	push   %eax
  800716:	68 0d 24 80 00       	push   $0x80240d
  80071b:	e8 70 02 00 00       	call   800990 <cprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800723:	8b 45 10             	mov    0x10(%ebp),%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 f4             	pushl  -0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	e8 f3 01 00 00       	call   800925 <vcprintf>
  800732:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800735:	83 ec 08             	sub    $0x8,%esp
  800738:	6a 00                	push   $0x0
  80073a:	68 29 24 80 00       	push   $0x802429
  80073f:	e8 e1 01 00 00       	call   800925 <vcprintf>
  800744:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800747:	e8 82 ff ff ff       	call   8006ce <exit>

	// should not return here
	while (1) ;
  80074c:	eb fe                	jmp    80074c <_panic+0x70>

0080074e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80074e:	55                   	push   %ebp
  80074f:	89 e5                	mov    %esp,%ebp
  800751:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800754:	a1 20 30 80 00       	mov    0x803020,%eax
  800759:	8b 50 74             	mov    0x74(%eax),%edx
  80075c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075f:	39 c2                	cmp    %eax,%edx
  800761:	74 14                	je     800777 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800763:	83 ec 04             	sub    $0x4,%esp
  800766:	68 2c 24 80 00       	push   $0x80242c
  80076b:	6a 26                	push   $0x26
  80076d:	68 78 24 80 00       	push   $0x802478
  800772:	e8 65 ff ff ff       	call   8006dc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800777:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80077e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800785:	e9 c2 00 00 00       	jmp    80084c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80078a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	85 c0                	test   %eax,%eax
  80079d:	75 08                	jne    8007a7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007a2:	e9 a2 00 00 00       	jmp    800849 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b5:	eb 69                	jmp    800820 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007bc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c5:	89 d0                	mov    %edx,%eax
  8007c7:	01 c0                	add    %eax,%eax
  8007c9:	01 d0                	add    %edx,%eax
  8007cb:	c1 e0 02             	shl    $0x2,%eax
  8007ce:	01 c8                	add    %ecx,%eax
  8007d0:	8a 40 04             	mov    0x4(%eax),%al
  8007d3:	84 c0                	test   %al,%al
  8007d5:	75 46                	jne    80081d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007dc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e5:	89 d0                	mov    %edx,%eax
  8007e7:	01 c0                	add    %eax,%eax
  8007e9:	01 d0                	add    %edx,%eax
  8007eb:	c1 e0 02             	shl    $0x2,%eax
  8007ee:	01 c8                	add    %ecx,%eax
  8007f0:	8b 00                	mov    (%eax),%eax
  8007f2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007fd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800802:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	01 c8                	add    %ecx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800810:	39 c2                	cmp    %eax,%edx
  800812:	75 09                	jne    80081d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800814:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80081b:	eb 12                	jmp    80082f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80081d:	ff 45 e8             	incl   -0x18(%ebp)
  800820:	a1 20 30 80 00       	mov    0x803020,%eax
  800825:	8b 50 74             	mov    0x74(%eax),%edx
  800828:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80082b:	39 c2                	cmp    %eax,%edx
  80082d:	77 88                	ja     8007b7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80082f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800833:	75 14                	jne    800849 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800835:	83 ec 04             	sub    $0x4,%esp
  800838:	68 84 24 80 00       	push   $0x802484
  80083d:	6a 3a                	push   $0x3a
  80083f:	68 78 24 80 00       	push   $0x802478
  800844:	e8 93 fe ff ff       	call   8006dc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800849:	ff 45 f0             	incl   -0x10(%ebp)
  80084c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800852:	0f 8c 32 ff ff ff    	jl     80078a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800858:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800866:	eb 26                	jmp    80088e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800868:	a1 20 30 80 00       	mov    0x803020,%eax
  80086d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800873:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800876:	89 d0                	mov    %edx,%eax
  800878:	01 c0                	add    %eax,%eax
  80087a:	01 d0                	add    %edx,%eax
  80087c:	c1 e0 02             	shl    $0x2,%eax
  80087f:	01 c8                	add    %ecx,%eax
  800881:	8a 40 04             	mov    0x4(%eax),%al
  800884:	3c 01                	cmp    $0x1,%al
  800886:	75 03                	jne    80088b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800888:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	ff 45 e0             	incl   -0x20(%ebp)
  80088e:	a1 20 30 80 00       	mov    0x803020,%eax
  800893:	8b 50 74             	mov    0x74(%eax),%edx
  800896:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800899:	39 c2                	cmp    %eax,%edx
  80089b:	77 cb                	ja     800868 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80089d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008a0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008a3:	74 14                	je     8008b9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008a5:	83 ec 04             	sub    $0x4,%esp
  8008a8:	68 d8 24 80 00       	push   $0x8024d8
  8008ad:	6a 44                	push   $0x44
  8008af:	68 78 24 80 00       	push   $0x802478
  8008b4:	e8 23 fe ff ff       	call   8006dc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	89 0a                	mov    %ecx,(%edx)
  8008cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d2:	88 d1                	mov    %dl,%cl
  8008d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008de:	8b 00                	mov    (%eax),%eax
  8008e0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008e5:	75 2c                	jne    800913 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008e7:	a0 24 30 80 00       	mov    0x803024,%al
  8008ec:	0f b6 c0             	movzbl %al,%eax
  8008ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f2:	8b 12                	mov    (%edx),%edx
  8008f4:	89 d1                	mov    %edx,%ecx
  8008f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f9:	83 c2 08             	add    $0x8,%edx
  8008fc:	83 ec 04             	sub    $0x4,%esp
  8008ff:	50                   	push   %eax
  800900:	51                   	push   %ecx
  800901:	52                   	push   %edx
  800902:	e8 dd 10 00 00       	call   8019e4 <sys_cputs>
  800907:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80090a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	8b 40 04             	mov    0x4(%eax),%eax
  800919:	8d 50 01             	lea    0x1(%eax),%edx
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800922:	90                   	nop
  800923:	c9                   	leave  
  800924:	c3                   	ret    

00800925 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800925:	55                   	push   %ebp
  800926:	89 e5                	mov    %esp,%ebp
  800928:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80092e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800935:	00 00 00 
	b.cnt = 0;
  800938:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80093f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	ff 75 08             	pushl  0x8(%ebp)
  800948:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80094e:	50                   	push   %eax
  80094f:	68 bc 08 80 00       	push   $0x8008bc
  800954:	e8 11 02 00 00       	call   800b6a <vprintfmt>
  800959:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80095c:	a0 24 30 80 00       	mov    0x803024,%al
  800961:	0f b6 c0             	movzbl %al,%eax
  800964:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80096a:	83 ec 04             	sub    $0x4,%esp
  80096d:	50                   	push   %eax
  80096e:	52                   	push   %edx
  80096f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800975:	83 c0 08             	add    $0x8,%eax
  800978:	50                   	push   %eax
  800979:	e8 66 10 00 00       	call   8019e4 <sys_cputs>
  80097e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800981:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800988:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <cprintf>:

int cprintf(const char *fmt, ...) {
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800996:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80099d:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ac:	50                   	push   %eax
  8009ad:	e8 73 ff ff ff       	call   800925 <vcprintf>
  8009b2:	83 c4 10             	add    $0x10,%esp
  8009b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009c3:	e8 2d 12 00 00       	call   801bf5 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009c8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d1:	83 ec 08             	sub    $0x8,%esp
  8009d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d7:	50                   	push   %eax
  8009d8:	e8 48 ff ff ff       	call   800925 <vcprintf>
  8009dd:	83 c4 10             	add    $0x10,%esp
  8009e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009e3:	e8 27 12 00 00       	call   801c0f <sys_enable_interrupt>
	return cnt;
  8009e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009eb:	c9                   	leave  
  8009ec:	c3                   	ret    

008009ed <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009ed:	55                   	push   %ebp
  8009ee:	89 e5                	mov    %esp,%ebp
  8009f0:	53                   	push   %ebx
  8009f1:	83 ec 14             	sub    $0x14,%esp
  8009f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a00:	8b 45 18             	mov    0x18(%ebp),%eax
  800a03:	ba 00 00 00 00       	mov    $0x0,%edx
  800a08:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a0b:	77 55                	ja     800a62 <printnum+0x75>
  800a0d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a10:	72 05                	jb     800a17 <printnum+0x2a>
  800a12:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a15:	77 4b                	ja     800a62 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a17:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a1d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a20:	ba 00 00 00 00       	mov    $0x0,%edx
  800a25:	52                   	push   %edx
  800a26:	50                   	push   %eax
  800a27:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2a:	ff 75 f0             	pushl  -0x10(%ebp)
  800a2d:	e8 a2 15 00 00       	call   801fd4 <__udivdi3>
  800a32:	83 c4 10             	add    $0x10,%esp
  800a35:	83 ec 04             	sub    $0x4,%esp
  800a38:	ff 75 20             	pushl  0x20(%ebp)
  800a3b:	53                   	push   %ebx
  800a3c:	ff 75 18             	pushl  0x18(%ebp)
  800a3f:	52                   	push   %edx
  800a40:	50                   	push   %eax
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	ff 75 08             	pushl  0x8(%ebp)
  800a47:	e8 a1 ff ff ff       	call   8009ed <printnum>
  800a4c:	83 c4 20             	add    $0x20,%esp
  800a4f:	eb 1a                	jmp    800a6b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 0c             	pushl  0xc(%ebp)
  800a57:	ff 75 20             	pushl  0x20(%ebp)
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a62:	ff 4d 1c             	decl   0x1c(%ebp)
  800a65:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a69:	7f e6                	jg     800a51 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a6b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a6e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a79:	53                   	push   %ebx
  800a7a:	51                   	push   %ecx
  800a7b:	52                   	push   %edx
  800a7c:	50                   	push   %eax
  800a7d:	e8 62 16 00 00       	call   8020e4 <__umoddi3>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	05 54 27 80 00       	add    $0x802754,%eax
  800a8a:	8a 00                	mov    (%eax),%al
  800a8c:	0f be c0             	movsbl %al,%eax
  800a8f:	83 ec 08             	sub    $0x8,%esp
  800a92:	ff 75 0c             	pushl  0xc(%ebp)
  800a95:	50                   	push   %eax
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	ff d0                	call   *%eax
  800a9b:	83 c4 10             	add    $0x10,%esp
}
  800a9e:	90                   	nop
  800a9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aa2:	c9                   	leave  
  800aa3:	c3                   	ret    

00800aa4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aa7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aab:	7e 1c                	jle    800ac9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	8d 50 08             	lea    0x8(%eax),%edx
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	89 10                	mov    %edx,(%eax)
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	83 e8 08             	sub    $0x8,%eax
  800ac2:	8b 50 04             	mov    0x4(%eax),%edx
  800ac5:	8b 00                	mov    (%eax),%eax
  800ac7:	eb 40                	jmp    800b09 <getuint+0x65>
	else if (lflag)
  800ac9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800acd:	74 1e                	je     800aed <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	8d 50 04             	lea    0x4(%eax),%edx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	89 10                	mov    %edx,(%eax)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 e8 04             	sub    $0x4,%eax
  800ae4:	8b 00                	mov    (%eax),%eax
  800ae6:	ba 00 00 00 00       	mov    $0x0,%edx
  800aeb:	eb 1c                	jmp    800b09 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	8d 50 04             	lea    0x4(%eax),%edx
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 10                	mov    %edx,(%eax)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	83 e8 04             	sub    $0x4,%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b09:	5d                   	pop    %ebp
  800b0a:	c3                   	ret    

00800b0b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b12:	7e 1c                	jle    800b30 <getint+0x25>
		return va_arg(*ap, long long);
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	8d 50 08             	lea    0x8(%eax),%edx
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	89 10                	mov    %edx,(%eax)
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	83 e8 08             	sub    $0x8,%eax
  800b29:	8b 50 04             	mov    0x4(%eax),%edx
  800b2c:	8b 00                	mov    (%eax),%eax
  800b2e:	eb 38                	jmp    800b68 <getint+0x5d>
	else if (lflag)
  800b30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b34:	74 1a                	je     800b50 <getint+0x45>
		return va_arg(*ap, long);
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	8d 50 04             	lea    0x4(%eax),%edx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	89 10                	mov    %edx,(%eax)
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	83 e8 04             	sub    $0x4,%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	99                   	cltd   
  800b4e:	eb 18                	jmp    800b68 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	8d 50 04             	lea    0x4(%eax),%edx
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	89 10                	mov    %edx,(%eax)
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	8b 00                	mov    (%eax),%eax
  800b62:	83 e8 04             	sub    $0x4,%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	99                   	cltd   
}
  800b68:	5d                   	pop    %ebp
  800b69:	c3                   	ret    

00800b6a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b6a:	55                   	push   %ebp
  800b6b:	89 e5                	mov    %esp,%ebp
  800b6d:	56                   	push   %esi
  800b6e:	53                   	push   %ebx
  800b6f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b72:	eb 17                	jmp    800b8b <vprintfmt+0x21>
			if (ch == '\0')
  800b74:	85 db                	test   %ebx,%ebx
  800b76:	0f 84 af 03 00 00    	je     800f2b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b7c:	83 ec 08             	sub    $0x8,%esp
  800b7f:	ff 75 0c             	pushl  0xc(%ebp)
  800b82:	53                   	push   %ebx
  800b83:	8b 45 08             	mov    0x8(%ebp),%eax
  800b86:	ff d0                	call   *%eax
  800b88:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8e:	8d 50 01             	lea    0x1(%eax),%edx
  800b91:	89 55 10             	mov    %edx,0x10(%ebp)
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	0f b6 d8             	movzbl %al,%ebx
  800b99:	83 fb 25             	cmp    $0x25,%ebx
  800b9c:	75 d6                	jne    800b74 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b9e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ba2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ba9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bb0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bb7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	0f b6 d8             	movzbl %al,%ebx
  800bcc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bcf:	83 f8 55             	cmp    $0x55,%eax
  800bd2:	0f 87 2b 03 00 00    	ja     800f03 <vprintfmt+0x399>
  800bd8:	8b 04 85 78 27 80 00 	mov    0x802778(,%eax,4),%eax
  800bdf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800be1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800be5:	eb d7                	jmp    800bbe <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800be7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800beb:	eb d1                	jmp    800bbe <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bf4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bf7:	89 d0                	mov    %edx,%eax
  800bf9:	c1 e0 02             	shl    $0x2,%eax
  800bfc:	01 d0                	add    %edx,%eax
  800bfe:	01 c0                	add    %eax,%eax
  800c00:	01 d8                	add    %ebx,%eax
  800c02:	83 e8 30             	sub    $0x30,%eax
  800c05:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c08:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c10:	83 fb 2f             	cmp    $0x2f,%ebx
  800c13:	7e 3e                	jle    800c53 <vprintfmt+0xe9>
  800c15:	83 fb 39             	cmp    $0x39,%ebx
  800c18:	7f 39                	jg     800c53 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c1d:	eb d5                	jmp    800bf4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c22:	83 c0 04             	add    $0x4,%eax
  800c25:	89 45 14             	mov    %eax,0x14(%ebp)
  800c28:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2b:	83 e8 04             	sub    $0x4,%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c33:	eb 1f                	jmp    800c54 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c39:	79 83                	jns    800bbe <vprintfmt+0x54>
				width = 0;
  800c3b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c42:	e9 77 ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c47:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c4e:	e9 6b ff ff ff       	jmp    800bbe <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c53:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c58:	0f 89 60 ff ff ff    	jns    800bbe <vprintfmt+0x54>
				width = precision, precision = -1;
  800c5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c64:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c6b:	e9 4e ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c70:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c73:	e9 46 ff ff ff       	jmp    800bbe <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c78:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7b:	83 c0 04             	add    $0x4,%eax
  800c7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 e8 04             	sub    $0x4,%eax
  800c87:	8b 00                	mov    (%eax),%eax
  800c89:	83 ec 08             	sub    $0x8,%esp
  800c8c:	ff 75 0c             	pushl  0xc(%ebp)
  800c8f:	50                   	push   %eax
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	ff d0                	call   *%eax
  800c95:	83 c4 10             	add    $0x10,%esp
			break;
  800c98:	e9 89 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca0:	83 c0 04             	add    $0x4,%eax
  800ca3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca9:	83 e8 04             	sub    $0x4,%eax
  800cac:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cae:	85 db                	test   %ebx,%ebx
  800cb0:	79 02                	jns    800cb4 <vprintfmt+0x14a>
				err = -err;
  800cb2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cb4:	83 fb 64             	cmp    $0x64,%ebx
  800cb7:	7f 0b                	jg     800cc4 <vprintfmt+0x15a>
  800cb9:	8b 34 9d c0 25 80 00 	mov    0x8025c0(,%ebx,4),%esi
  800cc0:	85 f6                	test   %esi,%esi
  800cc2:	75 19                	jne    800cdd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cc4:	53                   	push   %ebx
  800cc5:	68 65 27 80 00       	push   $0x802765
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	ff 75 08             	pushl  0x8(%ebp)
  800cd0:	e8 5e 02 00 00       	call   800f33 <printfmt>
  800cd5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cd8:	e9 49 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cdd:	56                   	push   %esi
  800cde:	68 6e 27 80 00       	push   $0x80276e
  800ce3:	ff 75 0c             	pushl  0xc(%ebp)
  800ce6:	ff 75 08             	pushl  0x8(%ebp)
  800ce9:	e8 45 02 00 00       	call   800f33 <printfmt>
  800cee:	83 c4 10             	add    $0x10,%esp
			break;
  800cf1:	e9 30 02 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf9:	83 c0 04             	add    $0x4,%eax
  800cfc:	89 45 14             	mov    %eax,0x14(%ebp)
  800cff:	8b 45 14             	mov    0x14(%ebp),%eax
  800d02:	83 e8 04             	sub    $0x4,%eax
  800d05:	8b 30                	mov    (%eax),%esi
  800d07:	85 f6                	test   %esi,%esi
  800d09:	75 05                	jne    800d10 <vprintfmt+0x1a6>
				p = "(null)";
  800d0b:	be 71 27 80 00       	mov    $0x802771,%esi
			if (width > 0 && padc != '-')
  800d10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d14:	7e 6d                	jle    800d83 <vprintfmt+0x219>
  800d16:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d1a:	74 67                	je     800d83 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1f:	83 ec 08             	sub    $0x8,%esp
  800d22:	50                   	push   %eax
  800d23:	56                   	push   %esi
  800d24:	e8 0c 03 00 00       	call   801035 <strnlen>
  800d29:	83 c4 10             	add    $0x10,%esp
  800d2c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d2f:	eb 16                	jmp    800d47 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d31:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d35:	83 ec 08             	sub    $0x8,%esp
  800d38:	ff 75 0c             	pushl  0xc(%ebp)
  800d3b:	50                   	push   %eax
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	ff d0                	call   *%eax
  800d41:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d44:	ff 4d e4             	decl   -0x1c(%ebp)
  800d47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4b:	7f e4                	jg     800d31 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d4d:	eb 34                	jmp    800d83 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d4f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d53:	74 1c                	je     800d71 <vprintfmt+0x207>
  800d55:	83 fb 1f             	cmp    $0x1f,%ebx
  800d58:	7e 05                	jle    800d5f <vprintfmt+0x1f5>
  800d5a:	83 fb 7e             	cmp    $0x7e,%ebx
  800d5d:	7e 12                	jle    800d71 <vprintfmt+0x207>
					putch('?', putdat);
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	6a 3f                	push   $0x3f
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	ff d0                	call   *%eax
  800d6c:	83 c4 10             	add    $0x10,%esp
  800d6f:	eb 0f                	jmp    800d80 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 0c             	pushl  0xc(%ebp)
  800d77:	53                   	push   %ebx
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	ff d0                	call   *%eax
  800d7d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d80:	ff 4d e4             	decl   -0x1c(%ebp)
  800d83:	89 f0                	mov    %esi,%eax
  800d85:	8d 70 01             	lea    0x1(%eax),%esi
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	0f be d8             	movsbl %al,%ebx
  800d8d:	85 db                	test   %ebx,%ebx
  800d8f:	74 24                	je     800db5 <vprintfmt+0x24b>
  800d91:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d95:	78 b8                	js     800d4f <vprintfmt+0x1e5>
  800d97:	ff 4d e0             	decl   -0x20(%ebp)
  800d9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9e:	79 af                	jns    800d4f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da0:	eb 13                	jmp    800db5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	6a 20                	push   $0x20
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800db2:	ff 4d e4             	decl   -0x1c(%ebp)
  800db5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db9:	7f e7                	jg     800da2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dbb:	e9 66 01 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dc0:	83 ec 08             	sub    $0x8,%esp
  800dc3:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc6:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc9:	50                   	push   %eax
  800dca:	e8 3c fd ff ff       	call   800b0b <getint>
  800dcf:	83 c4 10             	add    $0x10,%esp
  800dd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dde:	85 d2                	test   %edx,%edx
  800de0:	79 23                	jns    800e05 <vprintfmt+0x29b>
				putch('-', putdat);
  800de2:	83 ec 08             	sub    $0x8,%esp
  800de5:	ff 75 0c             	pushl  0xc(%ebp)
  800de8:	6a 2d                	push   $0x2d
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	ff d0                	call   *%eax
  800def:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df8:	f7 d8                	neg    %eax
  800dfa:	83 d2 00             	adc    $0x0,%edx
  800dfd:	f7 da                	neg    %edx
  800dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e02:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e05:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e0c:	e9 bc 00 00 00       	jmp    800ecd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e11:	83 ec 08             	sub    $0x8,%esp
  800e14:	ff 75 e8             	pushl  -0x18(%ebp)
  800e17:	8d 45 14             	lea    0x14(%ebp),%eax
  800e1a:	50                   	push   %eax
  800e1b:	e8 84 fc ff ff       	call   800aa4 <getuint>
  800e20:	83 c4 10             	add    $0x10,%esp
  800e23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e26:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e29:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e30:	e9 98 00 00 00       	jmp    800ecd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e35:	83 ec 08             	sub    $0x8,%esp
  800e38:	ff 75 0c             	pushl  0xc(%ebp)
  800e3b:	6a 58                	push   $0x58
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	ff d0                	call   *%eax
  800e42:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	6a 58                	push   $0x58
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	ff d0                	call   *%eax
  800e52:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 58                	push   $0x58
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			break;
  800e65:	e9 bc 00 00 00       	jmp    800f26 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	6a 30                	push   $0x30
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	ff d0                	call   *%eax
  800e77:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e7a:	83 ec 08             	sub    $0x8,%esp
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	6a 78                	push   $0x78
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8d:	83 c0 04             	add    $0x4,%eax
  800e90:	89 45 14             	mov    %eax,0x14(%ebp)
  800e93:	8b 45 14             	mov    0x14(%ebp),%eax
  800e96:	83 e8 04             	sub    $0x4,%eax
  800e99:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ea5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eac:	eb 1f                	jmp    800ecd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eae:	83 ec 08             	sub    $0x8,%esp
  800eb1:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb4:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb7:	50                   	push   %eax
  800eb8:	e8 e7 fb ff ff       	call   800aa4 <getuint>
  800ebd:	83 c4 10             	add    $0x10,%esp
  800ec0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ec6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ecd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ed1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ed4:	83 ec 04             	sub    $0x4,%esp
  800ed7:	52                   	push   %edx
  800ed8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800edb:	50                   	push   %eax
  800edc:	ff 75 f4             	pushl  -0xc(%ebp)
  800edf:	ff 75 f0             	pushl  -0x10(%ebp)
  800ee2:	ff 75 0c             	pushl  0xc(%ebp)
  800ee5:	ff 75 08             	pushl  0x8(%ebp)
  800ee8:	e8 00 fb ff ff       	call   8009ed <printnum>
  800eed:	83 c4 20             	add    $0x20,%esp
			break;
  800ef0:	eb 34                	jmp    800f26 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	53                   	push   %ebx
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			break;
  800f01:	eb 23                	jmp    800f26 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f03:	83 ec 08             	sub    $0x8,%esp
  800f06:	ff 75 0c             	pushl  0xc(%ebp)
  800f09:	6a 25                	push   $0x25
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	ff d0                	call   *%eax
  800f10:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f13:	ff 4d 10             	decl   0x10(%ebp)
  800f16:	eb 03                	jmp    800f1b <vprintfmt+0x3b1>
  800f18:	ff 4d 10             	decl   0x10(%ebp)
  800f1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1e:	48                   	dec    %eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	3c 25                	cmp    $0x25,%al
  800f23:	75 f3                	jne    800f18 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f25:	90                   	nop
		}
	}
  800f26:	e9 47 fc ff ff       	jmp    800b72 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f2b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f2c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f2f:	5b                   	pop    %ebx
  800f30:	5e                   	pop    %esi
  800f31:	5d                   	pop    %ebp
  800f32:	c3                   	ret    

00800f33 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f33:	55                   	push   %ebp
  800f34:	89 e5                	mov    %esp,%ebp
  800f36:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f39:	8d 45 10             	lea    0x10(%ebp),%eax
  800f3c:	83 c0 04             	add    $0x4,%eax
  800f3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f42:	8b 45 10             	mov    0x10(%ebp),%eax
  800f45:	ff 75 f4             	pushl  -0xc(%ebp)
  800f48:	50                   	push   %eax
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	ff 75 08             	pushl  0x8(%ebp)
  800f4f:	e8 16 fc ff ff       	call   800b6a <vprintfmt>
  800f54:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f57:	90                   	nop
  800f58:	c9                   	leave  
  800f59:	c3                   	ret    

00800f5a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f5a:	55                   	push   %ebp
  800f5b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	8b 40 08             	mov    0x8(%eax),%eax
  800f63:	8d 50 01             	lea    0x1(%eax),%edx
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6f:	8b 10                	mov    (%eax),%edx
  800f71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f74:	8b 40 04             	mov    0x4(%eax),%eax
  800f77:	39 c2                	cmp    %eax,%edx
  800f79:	73 12                	jae    800f8d <sprintputch+0x33>
		*b->buf++ = ch;
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	8b 00                	mov    (%eax),%eax
  800f80:	8d 48 01             	lea    0x1(%eax),%ecx
  800f83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f86:	89 0a                	mov    %ecx,(%edx)
  800f88:	8b 55 08             	mov    0x8(%ebp),%edx
  800f8b:	88 10                	mov    %dl,(%eax)
}
  800f8d:	90                   	nop
  800f8e:	5d                   	pop    %ebp
  800f8f:	c3                   	ret    

00800f90 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f90:	55                   	push   %ebp
  800f91:	89 e5                	mov    %esp,%ebp
  800f93:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	01 d0                	add    %edx,%eax
  800fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800faa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fb1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb5:	74 06                	je     800fbd <vsnprintf+0x2d>
  800fb7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fbb:	7f 07                	jg     800fc4 <vsnprintf+0x34>
		return -E_INVAL;
  800fbd:	b8 03 00 00 00       	mov    $0x3,%eax
  800fc2:	eb 20                	jmp    800fe4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fc4:	ff 75 14             	pushl  0x14(%ebp)
  800fc7:	ff 75 10             	pushl  0x10(%ebp)
  800fca:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fcd:	50                   	push   %eax
  800fce:	68 5a 0f 80 00       	push   $0x800f5a
  800fd3:	e8 92 fb ff ff       	call   800b6a <vprintfmt>
  800fd8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fdb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fde:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fec:	8d 45 10             	lea    0x10(%ebp),%eax
  800fef:	83 c0 04             	add    $0x4,%eax
  800ff2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ff5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ffb:	50                   	push   %eax
  800ffc:	ff 75 0c             	pushl  0xc(%ebp)
  800fff:	ff 75 08             	pushl  0x8(%ebp)
  801002:	e8 89 ff ff ff       	call   800f90 <vsnprintf>
  801007:	83 c4 10             	add    $0x10,%esp
  80100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801010:	c9                   	leave  
  801011:	c3                   	ret    

00801012 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801012:	55                   	push   %ebp
  801013:	89 e5                	mov    %esp,%ebp
  801015:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801018:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80101f:	eb 06                	jmp    801027 <strlen+0x15>
		n++;
  801021:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801024:	ff 45 08             	incl   0x8(%ebp)
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	84 c0                	test   %al,%al
  80102e:	75 f1                	jne    801021 <strlen+0xf>
		n++;
	return n;
  801030:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80103b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801042:	eb 09                	jmp    80104d <strnlen+0x18>
		n++;
  801044:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801047:	ff 45 08             	incl   0x8(%ebp)
  80104a:	ff 4d 0c             	decl   0xc(%ebp)
  80104d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801051:	74 09                	je     80105c <strnlen+0x27>
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	84 c0                	test   %al,%al
  80105a:	75 e8                	jne    801044 <strnlen+0xf>
		n++;
	return n;
  80105c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80106d:	90                   	nop
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	8d 50 01             	lea    0x1(%eax),%edx
  801074:	89 55 08             	mov    %edx,0x8(%ebp)
  801077:	8b 55 0c             	mov    0xc(%ebp),%edx
  80107a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80107d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801080:	8a 12                	mov    (%edx),%dl
  801082:	88 10                	mov    %dl,(%eax)
  801084:	8a 00                	mov    (%eax),%al
  801086:	84 c0                	test   %al,%al
  801088:	75 e4                	jne    80106e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80108a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80108d:	c9                   	leave  
  80108e:	c3                   	ret    

0080108f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80108f:	55                   	push   %ebp
  801090:	89 e5                	mov    %esp,%ebp
  801092:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80109b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010a2:	eb 1f                	jmp    8010c3 <strncpy+0x34>
		*dst++ = *src;
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	8d 50 01             	lea    0x1(%eax),%edx
  8010aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b0:	8a 12                	mov    (%edx),%dl
  8010b2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	84 c0                	test   %al,%al
  8010bb:	74 03                	je     8010c0 <strncpy+0x31>
			src++;
  8010bd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010c0:	ff 45 fc             	incl   -0x4(%ebp)
  8010c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010c9:	72 d9                	jb     8010a4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
  8010d3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e0:	74 30                	je     801112 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010e2:	eb 16                	jmp    8010fa <strlcpy+0x2a>
			*dst++ = *src++;
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8d 50 01             	lea    0x1(%eax),%edx
  8010ea:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010f6:	8a 12                	mov    (%edx),%dl
  8010f8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010fa:	ff 4d 10             	decl   0x10(%ebp)
  8010fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801101:	74 09                	je     80110c <strlcpy+0x3c>
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	84 c0                	test   %al,%al
  80110a:	75 d8                	jne    8010e4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801112:	8b 55 08             	mov    0x8(%ebp),%edx
  801115:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801118:	29 c2                	sub    %eax,%edx
  80111a:	89 d0                	mov    %edx,%eax
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801121:	eb 06                	jmp    801129 <strcmp+0xb>
		p++, q++;
  801123:	ff 45 08             	incl   0x8(%ebp)
  801126:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	84 c0                	test   %al,%al
  801130:	74 0e                	je     801140 <strcmp+0x22>
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 10                	mov    (%eax),%dl
  801137:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113a:	8a 00                	mov    (%eax),%al
  80113c:	38 c2                	cmp    %al,%dl
  80113e:	74 e3                	je     801123 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	0f b6 d0             	movzbl %al,%edx
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	8a 00                	mov    (%eax),%al
  80114d:	0f b6 c0             	movzbl %al,%eax
  801150:	29 c2                	sub    %eax,%edx
  801152:	89 d0                	mov    %edx,%eax
}
  801154:	5d                   	pop    %ebp
  801155:	c3                   	ret    

00801156 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801156:	55                   	push   %ebp
  801157:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801159:	eb 09                	jmp    801164 <strncmp+0xe>
		n--, p++, q++;
  80115b:	ff 4d 10             	decl   0x10(%ebp)
  80115e:	ff 45 08             	incl   0x8(%ebp)
  801161:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801164:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801168:	74 17                	je     801181 <strncmp+0x2b>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	84 c0                	test   %al,%al
  801171:	74 0e                	je     801181 <strncmp+0x2b>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 10                	mov    (%eax),%dl
  801178:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	38 c2                	cmp    %al,%dl
  80117f:	74 da                	je     80115b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801181:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801185:	75 07                	jne    80118e <strncmp+0x38>
		return 0;
  801187:	b8 00 00 00 00       	mov    $0x0,%eax
  80118c:	eb 14                	jmp    8011a2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
  801191:	8a 00                	mov    (%eax),%al
  801193:	0f b6 d0             	movzbl %al,%edx
  801196:	8b 45 0c             	mov    0xc(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	0f b6 c0             	movzbl %al,%eax
  80119e:	29 c2                	sub    %eax,%edx
  8011a0:	89 d0                	mov    %edx,%eax
}
  8011a2:	5d                   	pop    %ebp
  8011a3:	c3                   	ret    

008011a4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
  8011a7:	83 ec 04             	sub    $0x4,%esp
  8011aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b0:	eb 12                	jmp    8011c4 <strchr+0x20>
		if (*s == c)
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ba:	75 05                	jne    8011c1 <strchr+0x1d>
			return (char *) s;
  8011bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bf:	eb 11                	jmp    8011d2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011c1:	ff 45 08             	incl   0x8(%ebp)
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	84 c0                	test   %al,%al
  8011cb:	75 e5                	jne    8011b2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 04             	sub    $0x4,%esp
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e0:	eb 0d                	jmp    8011ef <strfind+0x1b>
		if (*s == c)
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ea:	74 0e                	je     8011fa <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011ec:	ff 45 08             	incl   0x8(%ebp)
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	75 ea                	jne    8011e2 <strfind+0xe>
  8011f8:	eb 01                	jmp    8011fb <strfind+0x27>
		if (*s == c)
			break;
  8011fa:	90                   	nop
	return (char *) s;
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011fe:	c9                   	leave  
  8011ff:	c3                   	ret    

00801200 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801200:	55                   	push   %ebp
  801201:	89 e5                	mov    %esp,%ebp
  801203:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80120c:	8b 45 10             	mov    0x10(%ebp),%eax
  80120f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801212:	eb 0e                	jmp    801222 <memset+0x22>
		*p++ = c;
  801214:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801217:	8d 50 01             	lea    0x1(%eax),%edx
  80121a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80121d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801220:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801222:	ff 4d f8             	decl   -0x8(%ebp)
  801225:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801229:	79 e9                	jns    801214 <memset+0x14>
		*p++ = c;

	return v;
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122e:	c9                   	leave  
  80122f:	c3                   	ret    

00801230 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801230:	55                   	push   %ebp
  801231:	89 e5                	mov    %esp,%ebp
  801233:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801236:	8b 45 0c             	mov    0xc(%ebp),%eax
  801239:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801242:	eb 16                	jmp    80125a <memcpy+0x2a>
		*d++ = *s++;
  801244:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801247:	8d 50 01             	lea    0x1(%eax),%edx
  80124a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80124d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801250:	8d 4a 01             	lea    0x1(%edx),%ecx
  801253:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801256:	8a 12                	mov    (%edx),%dl
  801258:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80125a:	8b 45 10             	mov    0x10(%ebp),%eax
  80125d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801260:	89 55 10             	mov    %edx,0x10(%ebp)
  801263:	85 c0                	test   %eax,%eax
  801265:	75 dd                	jne    801244 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
  80126f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80127e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801281:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801284:	73 50                	jae    8012d6 <memmove+0x6a>
  801286:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801289:	8b 45 10             	mov    0x10(%ebp),%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801291:	76 43                	jbe    8012d6 <memmove+0x6a>
		s += n;
  801293:	8b 45 10             	mov    0x10(%ebp),%eax
  801296:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801299:	8b 45 10             	mov    0x10(%ebp),%eax
  80129c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80129f:	eb 10                	jmp    8012b1 <memmove+0x45>
			*--d = *--s;
  8012a1:	ff 4d f8             	decl   -0x8(%ebp)
  8012a4:	ff 4d fc             	decl   -0x4(%ebp)
  8012a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012aa:	8a 10                	mov    (%eax),%dl
  8012ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012af:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ba:	85 c0                	test   %eax,%eax
  8012bc:	75 e3                	jne    8012a1 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012be:	eb 23                	jmp    8012e3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c3:	8d 50 01             	lea    0x1(%eax),%edx
  8012c6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012cc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012cf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012d2:	8a 12                	mov    (%edx),%dl
  8012d4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8012df:	85 c0                	test   %eax,%eax
  8012e1:	75 dd                	jne    8012c0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
  8012eb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012fa:	eb 2a                	jmp    801326 <memcmp+0x3e>
		if (*s1 != *s2)
  8012fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ff:	8a 10                	mov    (%eax),%dl
  801301:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	38 c2                	cmp    %al,%dl
  801308:	74 16                	je     801320 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80130a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	0f b6 d0             	movzbl %al,%edx
  801312:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	0f b6 c0             	movzbl %al,%eax
  80131a:	29 c2                	sub    %eax,%edx
  80131c:	89 d0                	mov    %edx,%eax
  80131e:	eb 18                	jmp    801338 <memcmp+0x50>
		s1++, s2++;
  801320:	ff 45 fc             	incl   -0x4(%ebp)
  801323:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	8d 50 ff             	lea    -0x1(%eax),%edx
  80132c:	89 55 10             	mov    %edx,0x10(%ebp)
  80132f:	85 c0                	test   %eax,%eax
  801331:	75 c9                	jne    8012fc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801333:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
  80133d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801340:	8b 55 08             	mov    0x8(%ebp),%edx
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	01 d0                	add    %edx,%eax
  801348:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80134b:	eb 15                	jmp    801362 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	0f b6 d0             	movzbl %al,%edx
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	0f b6 c0             	movzbl %al,%eax
  80135b:	39 c2                	cmp    %eax,%edx
  80135d:	74 0d                	je     80136c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80135f:	ff 45 08             	incl   0x8(%ebp)
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801368:	72 e3                	jb     80134d <memfind+0x13>
  80136a:	eb 01                	jmp    80136d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80136c:	90                   	nop
	return (void *) s;
  80136d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801378:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80137f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801386:	eb 03                	jmp    80138b <strtol+0x19>
		s++;
  801388:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8a 00                	mov    (%eax),%al
  801390:	3c 20                	cmp    $0x20,%al
  801392:	74 f4                	je     801388 <strtol+0x16>
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	3c 09                	cmp    $0x9,%al
  80139b:	74 eb                	je     801388 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	3c 2b                	cmp    $0x2b,%al
  8013a4:	75 05                	jne    8013ab <strtol+0x39>
		s++;
  8013a6:	ff 45 08             	incl   0x8(%ebp)
  8013a9:	eb 13                	jmp    8013be <strtol+0x4c>
	else if (*s == '-')
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	3c 2d                	cmp    $0x2d,%al
  8013b2:	75 0a                	jne    8013be <strtol+0x4c>
		s++, neg = 1;
  8013b4:	ff 45 08             	incl   0x8(%ebp)
  8013b7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c2:	74 06                	je     8013ca <strtol+0x58>
  8013c4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013c8:	75 20                	jne    8013ea <strtol+0x78>
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	3c 30                	cmp    $0x30,%al
  8013d1:	75 17                	jne    8013ea <strtol+0x78>
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	40                   	inc    %eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	3c 78                	cmp    $0x78,%al
  8013db:	75 0d                	jne    8013ea <strtol+0x78>
		s += 2, base = 16;
  8013dd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013e1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013e8:	eb 28                	jmp    801412 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ee:	75 15                	jne    801405 <strtol+0x93>
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3c 30                	cmp    $0x30,%al
  8013f7:	75 0c                	jne    801405 <strtol+0x93>
		s++, base = 8;
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801403:	eb 0d                	jmp    801412 <strtol+0xa0>
	else if (base == 0)
  801405:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801409:	75 07                	jne    801412 <strtol+0xa0>
		base = 10;
  80140b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	3c 2f                	cmp    $0x2f,%al
  801419:	7e 19                	jle    801434 <strtol+0xc2>
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	3c 39                	cmp    $0x39,%al
  801422:	7f 10                	jg     801434 <strtol+0xc2>
			dig = *s - '0';
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	0f be c0             	movsbl %al,%eax
  80142c:	83 e8 30             	sub    $0x30,%eax
  80142f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801432:	eb 42                	jmp    801476 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	3c 60                	cmp    $0x60,%al
  80143b:	7e 19                	jle    801456 <strtol+0xe4>
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 7a                	cmp    $0x7a,%al
  801444:	7f 10                	jg     801456 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	0f be c0             	movsbl %al,%eax
  80144e:	83 e8 57             	sub    $0x57,%eax
  801451:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801454:	eb 20                	jmp    801476 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	3c 40                	cmp    $0x40,%al
  80145d:	7e 39                	jle    801498 <strtol+0x126>
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	3c 5a                	cmp    $0x5a,%al
  801466:	7f 30                	jg     801498 <strtol+0x126>
			dig = *s - 'A' + 10;
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f be c0             	movsbl %al,%eax
  801470:	83 e8 37             	sub    $0x37,%eax
  801473:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801476:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801479:	3b 45 10             	cmp    0x10(%ebp),%eax
  80147c:	7d 19                	jge    801497 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80147e:	ff 45 08             	incl   0x8(%ebp)
  801481:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801484:	0f af 45 10          	imul   0x10(%ebp),%eax
  801488:	89 c2                	mov    %eax,%edx
  80148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80148d:	01 d0                	add    %edx,%eax
  80148f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801492:	e9 7b ff ff ff       	jmp    801412 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801497:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801498:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80149c:	74 08                	je     8014a6 <strtol+0x134>
		*endptr = (char *) s;
  80149e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a1:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014aa:	74 07                	je     8014b3 <strtol+0x141>
  8014ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014af:	f7 d8                	neg    %eax
  8014b1:	eb 03                	jmp    8014b6 <strtol+0x144>
  8014b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014b6:	c9                   	leave  
  8014b7:	c3                   	ret    

008014b8 <ltostr>:

void
ltostr(long value, char *str)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
  8014bb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014d0:	79 13                	jns    8014e5 <ltostr+0x2d>
	{
		neg = 1;
  8014d2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014df:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014e2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014ed:	99                   	cltd   
  8014ee:	f7 f9                	idiv   %ecx
  8014f0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f6:	8d 50 01             	lea    0x1(%eax),%edx
  8014f9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014fc:	89 c2                	mov    %eax,%edx
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801506:	83 c2 30             	add    $0x30,%edx
  801509:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80150b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801513:	f7 e9                	imul   %ecx
  801515:	c1 fa 02             	sar    $0x2,%edx
  801518:	89 c8                	mov    %ecx,%eax
  80151a:	c1 f8 1f             	sar    $0x1f,%eax
  80151d:	29 c2                	sub    %eax,%edx
  80151f:	89 d0                	mov    %edx,%eax
  801521:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801524:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801527:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80152c:	f7 e9                	imul   %ecx
  80152e:	c1 fa 02             	sar    $0x2,%edx
  801531:	89 c8                	mov    %ecx,%eax
  801533:	c1 f8 1f             	sar    $0x1f,%eax
  801536:	29 c2                	sub    %eax,%edx
  801538:	89 d0                	mov    %edx,%eax
  80153a:	c1 e0 02             	shl    $0x2,%eax
  80153d:	01 d0                	add    %edx,%eax
  80153f:	01 c0                	add    %eax,%eax
  801541:	29 c1                	sub    %eax,%ecx
  801543:	89 ca                	mov    %ecx,%edx
  801545:	85 d2                	test   %edx,%edx
  801547:	75 9c                	jne    8014e5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801549:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801550:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801553:	48                   	dec    %eax
  801554:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801557:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80155b:	74 3d                	je     80159a <ltostr+0xe2>
		start = 1 ;
  80155d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801564:	eb 34                	jmp    80159a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801566:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156c:	01 d0                	add    %edx,%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801573:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801576:	8b 45 0c             	mov    0xc(%ebp),%eax
  801579:	01 c2                	add    %eax,%edx
  80157b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	01 c8                	add    %ecx,%eax
  801583:	8a 00                	mov    (%eax),%al
  801585:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801587:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80158a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158d:	01 c2                	add    %eax,%edx
  80158f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801592:	88 02                	mov    %al,(%edx)
		start++ ;
  801594:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801597:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015a0:	7c c4                	jl     801566 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a8:	01 d0                	add    %edx,%eax
  8015aa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015ad:	90                   	nop
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015b6:	ff 75 08             	pushl  0x8(%ebp)
  8015b9:	e8 54 fa ff ff       	call   801012 <strlen>
  8015be:	83 c4 04             	add    $0x4,%esp
  8015c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015c4:	ff 75 0c             	pushl  0xc(%ebp)
  8015c7:	e8 46 fa ff ff       	call   801012 <strlen>
  8015cc:	83 c4 04             	add    $0x4,%esp
  8015cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015e0:	eb 17                	jmp    8015f9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e8:	01 c2                	add    %eax,%edx
  8015ea:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	01 c8                	add    %ecx,%eax
  8015f2:	8a 00                	mov    (%eax),%al
  8015f4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015f6:	ff 45 fc             	incl   -0x4(%ebp)
  8015f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ff:	7c e1                	jl     8015e2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801601:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801608:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80160f:	eb 1f                	jmp    801630 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801611:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801614:	8d 50 01             	lea    0x1(%eax),%edx
  801617:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80161a:	89 c2                	mov    %eax,%edx
  80161c:	8b 45 10             	mov    0x10(%ebp),%eax
  80161f:	01 c2                	add    %eax,%edx
  801621:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801624:	8b 45 0c             	mov    0xc(%ebp),%eax
  801627:	01 c8                	add    %ecx,%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80162d:	ff 45 f8             	incl   -0x8(%ebp)
  801630:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801633:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801636:	7c d9                	jl     801611 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801638:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163b:	8b 45 10             	mov    0x10(%ebp),%eax
  80163e:	01 d0                	add    %edx,%eax
  801640:	c6 00 00             	movb   $0x0,(%eax)
}
  801643:	90                   	nop
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801649:	8b 45 14             	mov    0x14(%ebp),%eax
  80164c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801652:	8b 45 14             	mov    0x14(%ebp),%eax
  801655:	8b 00                	mov    (%eax),%eax
  801657:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80165e:	8b 45 10             	mov    0x10(%ebp),%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801669:	eb 0c                	jmp    801677 <strsplit+0x31>
			*string++ = 0;
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8d 50 01             	lea    0x1(%eax),%edx
  801671:	89 55 08             	mov    %edx,0x8(%ebp)
  801674:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	84 c0                	test   %al,%al
  80167e:	74 18                	je     801698 <strsplit+0x52>
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	0f be c0             	movsbl %al,%eax
  801688:	50                   	push   %eax
  801689:	ff 75 0c             	pushl  0xc(%ebp)
  80168c:	e8 13 fb ff ff       	call   8011a4 <strchr>
  801691:	83 c4 08             	add    $0x8,%esp
  801694:	85 c0                	test   %eax,%eax
  801696:	75 d3                	jne    80166b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	84 c0                	test   %al,%al
  80169f:	74 5a                	je     8016fb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8016a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a4:	8b 00                	mov    (%eax),%eax
  8016a6:	83 f8 0f             	cmp    $0xf,%eax
  8016a9:	75 07                	jne    8016b2 <strsplit+0x6c>
		{
			return 0;
  8016ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b0:	eb 66                	jmp    801718 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b5:	8b 00                	mov    (%eax),%eax
  8016b7:	8d 48 01             	lea    0x1(%eax),%ecx
  8016ba:	8b 55 14             	mov    0x14(%ebp),%edx
  8016bd:	89 0a                	mov    %ecx,(%edx)
  8016bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c9:	01 c2                	add    %eax,%edx
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d0:	eb 03                	jmp    8016d5 <strsplit+0x8f>
			string++;
  8016d2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	8a 00                	mov    (%eax),%al
  8016da:	84 c0                	test   %al,%al
  8016dc:	74 8b                	je     801669 <strsplit+0x23>
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	8a 00                	mov    (%eax),%al
  8016e3:	0f be c0             	movsbl %al,%eax
  8016e6:	50                   	push   %eax
  8016e7:	ff 75 0c             	pushl  0xc(%ebp)
  8016ea:	e8 b5 fa ff ff       	call   8011a4 <strchr>
  8016ef:	83 c4 08             	add    $0x8,%esp
  8016f2:	85 c0                	test   %eax,%eax
  8016f4:	74 dc                	je     8016d2 <strsplit+0x8c>
			string++;
	}
  8016f6:	e9 6e ff ff ff       	jmp    801669 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016fb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ff:	8b 00                	mov    (%eax),%eax
  801701:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801708:	8b 45 10             	mov    0x10(%ebp),%eax
  80170b:	01 d0                	add    %edx,%eax
  80170d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801713:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
  80171d:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801720:	e8 31 08 00 00       	call   801f56 <sys_isUHeapPlacementStrategyNEXTFIT>
  801725:	85 c0                	test   %eax,%eax
  801727:	0f 84 64 01 00 00    	je     801891 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  80172d:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801733:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  80173a:	8b 55 08             	mov    0x8(%ebp),%edx
  80173d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801740:	01 d0                	add    %edx,%eax
  801742:	48                   	dec    %eax
  801743:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801749:	ba 00 00 00 00       	mov    $0x0,%edx
  80174e:	f7 75 e8             	divl   -0x18(%ebp)
  801751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801754:	29 d0                	sub    %edx,%eax
  801756:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  80175d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	01 d0                	add    %edx,%eax
  801768:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  80176b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801772:	a1 28 30 80 00       	mov    0x803028,%eax
  801777:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  80177e:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801781:	0f 83 0a 01 00 00    	jae    801891 <malloc+0x177>
  801787:	a1 28 30 80 00       	mov    0x803028,%eax
  80178c:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801793:	85 c0                	test   %eax,%eax
  801795:	0f 84 f6 00 00 00    	je     801891 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80179b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017a2:	e9 dc 00 00 00       	jmp    801883 <malloc+0x169>
				flag++;
  8017a7:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8017aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017ad:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8017b4:	85 c0                	test   %eax,%eax
  8017b6:	74 07                	je     8017bf <malloc+0xa5>
					flag=0;
  8017b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8017bf:	a1 28 30 80 00       	mov    0x803028,%eax
  8017c4:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8017cb:	85 c0                	test   %eax,%eax
  8017cd:	79 05                	jns    8017d4 <malloc+0xba>
  8017cf:	05 ff 0f 00 00       	add    $0xfff,%eax
  8017d4:	c1 f8 0c             	sar    $0xc,%eax
  8017d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017da:	0f 85 a0 00 00 00    	jne    801880 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  8017e0:	a1 28 30 80 00       	mov    0x803028,%eax
  8017e5:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8017ec:	85 c0                	test   %eax,%eax
  8017ee:	79 05                	jns    8017f5 <malloc+0xdb>
  8017f0:	05 ff 0f 00 00       	add    $0xfff,%eax
  8017f5:	c1 f8 0c             	sar    $0xc,%eax
  8017f8:	89 c2                	mov    %eax,%edx
  8017fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017fd:	29 d0                	sub    %edx,%eax
  8017ff:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801802:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801805:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801808:	eb 11                	jmp    80181b <malloc+0x101>
						hFreeArr[j] = 1;
  80180a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80180d:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801814:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801818:	ff 45 ec             	incl   -0x14(%ebp)
  80181b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80181e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801821:	7e e7                	jle    80180a <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801823:	a1 28 30 80 00       	mov    0x803028,%eax
  801828:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80182b:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801831:	c1 e2 0c             	shl    $0xc,%edx
  801834:	89 15 04 30 80 00    	mov    %edx,0x803004
  80183a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801840:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801847:	a1 28 30 80 00       	mov    0x803028,%eax
  80184c:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801853:	89 c2                	mov    %eax,%edx
  801855:	a1 28 30 80 00       	mov    0x803028,%eax
  80185a:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801861:	83 ec 08             	sub    $0x8,%esp
  801864:	52                   	push   %edx
  801865:	50                   	push   %eax
  801866:	e8 21 03 00 00       	call   801b8c <sys_allocateMem>
  80186b:	83 c4 10             	add    $0x10,%esp

					idx++;
  80186e:	a1 28 30 80 00       	mov    0x803028,%eax
  801873:	40                   	inc    %eax
  801874:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801879:	a1 04 30 80 00       	mov    0x803004,%eax
  80187e:	eb 16                	jmp    801896 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801880:	ff 45 f0             	incl   -0x10(%ebp)
  801883:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801886:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80188b:	0f 86 16 ff ff ff    	jbe    8017a7 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801891:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
  80189b:	83 ec 18             	sub    $0x18,%esp
  80189e:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8018a4:	83 ec 04             	sub    $0x4,%esp
  8018a7:	68 d0 28 80 00       	push   $0x8028d0
  8018ac:	6a 5a                	push   $0x5a
  8018ae:	68 ef 28 80 00       	push   $0x8028ef
  8018b3:	e8 24 ee ff ff       	call   8006dc <_panic>

008018b8 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
  8018bb:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8018be:	83 ec 04             	sub    $0x4,%esp
  8018c1:	68 fb 28 80 00       	push   $0x8028fb
  8018c6:	6a 60                	push   $0x60
  8018c8:	68 ef 28 80 00       	push   $0x8028ef
  8018cd:	e8 0a ee ff ff       	call   8006dc <_panic>

008018d2 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
  8018d5:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  8018d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018df:	e9 8a 00 00 00       	jmp    80196e <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  8018e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e7:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  8018ee:	3b 45 08             	cmp    0x8(%ebp),%eax
  8018f1:	75 78                	jne    80196b <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  8018f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018f6:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  8018fd:	05 00 00 00 80       	add    $0x80000000,%eax
  801902:	c1 e8 0c             	shr    $0xc,%eax
  801905:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801908:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80190b:	8b 14 c5 44 30 88 00 	mov    0x883044(,%eax,8),%edx
  801912:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801915:	01 d0                	add    %edx,%eax
  801917:	85 c0                	test   %eax,%eax
  801919:	79 05                	jns    801920 <free+0x4e>
  80191b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801920:	c1 f8 0c             	sar    $0xc,%eax
  801923:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801926:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801929:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80192c:	eb 19                	jmp    801947 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  80192e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801931:	83 ec 08             	sub    $0x8,%esp
  801934:	50                   	push   %eax
  801935:	ff 75 f0             	pushl  -0x10(%ebp)
  801938:	e8 33 02 00 00       	call   801b70 <sys_freeMem>
  80193d:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801940:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  801947:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80194a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80194d:	72 df                	jb     80192e <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  80194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801952:	c7 04 c5 44 30 88 00 	movl   $0x0,0x883044(,%eax,8)
  801959:	00 00 00 00 
  80195d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801960:	c7 04 c5 40 30 88 00 	movl   $0x0,0x883040(,%eax,8)
  801967:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  80196b:	ff 45 f4             	incl   -0xc(%ebp)
  80196e:	a1 28 30 80 00       	mov    0x803028,%eax
  801973:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801976:	0f 8c 68 ff ff ff    	jl     8018e4 <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sfree>:


void sfree(void* virtual_address)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
  801982:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801985:	83 ec 04             	sub    $0x4,%esp
  801988:	68 17 29 80 00       	push   $0x802917
  80198d:	68 87 00 00 00       	push   $0x87
  801992:	68 ef 28 80 00       	push   $0x8028ef
  801997:	e8 40 ed ff ff       	call   8006dc <_panic>

0080199c <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
  80199f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8019a2:	83 ec 04             	sub    $0x4,%esp
  8019a5:	68 34 29 80 00       	push   $0x802934
  8019aa:	68 9f 00 00 00       	push   $0x9f
  8019af:	68 ef 28 80 00       	push   $0x8028ef
  8019b4:	e8 23 ed ff ff       	call   8006dc <_panic>

008019b9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
  8019bc:	57                   	push   %edi
  8019bd:	56                   	push   %esi
  8019be:	53                   	push   %ebx
  8019bf:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019cb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019ce:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019d1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019d4:	cd 30                	int    $0x30
  8019d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019dc:	83 c4 10             	add    $0x10,%esp
  8019df:	5b                   	pop    %ebx
  8019e0:	5e                   	pop    %esi
  8019e1:	5f                   	pop    %edi
  8019e2:	5d                   	pop    %ebp
  8019e3:	c3                   	ret    

008019e4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
  8019e7:	83 ec 04             	sub    $0x4,%esp
  8019ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8019f0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	52                   	push   %edx
  8019fc:	ff 75 0c             	pushl  0xc(%ebp)
  8019ff:	50                   	push   %eax
  801a00:	6a 00                	push   $0x0
  801a02:	e8 b2 ff ff ff       	call   8019b9 <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
}
  801a0a:	90                   	nop
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_cgetc>:

int
sys_cgetc(void)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 01                	push   $0x1
  801a1c:	e8 98 ff ff ff       	call   8019b9 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a29:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	50                   	push   %eax
  801a35:	6a 05                	push   $0x5
  801a37:	e8 7d ff ff ff       	call   8019b9 <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 02                	push   $0x2
  801a50:	e8 64 ff ff ff       	call   8019b9 <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 03                	push   $0x3
  801a69:	e8 4b ff ff ff       	call   8019b9 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 04                	push   $0x4
  801a82:	e8 32 ff ff ff       	call   8019b9 <syscall>
  801a87:	83 c4 18             	add    $0x18,%esp
}
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <sys_env_exit>:


void sys_env_exit(void)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 06                	push   $0x6
  801a9b:	e8 19 ff ff ff       	call   8019b9 <syscall>
  801aa0:	83 c4 18             	add    $0x18,%esp
}
  801aa3:	90                   	nop
  801aa4:	c9                   	leave  
  801aa5:	c3                   	ret    

00801aa6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801aa9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aac:	8b 45 08             	mov    0x8(%ebp),%eax
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	52                   	push   %edx
  801ab6:	50                   	push   %eax
  801ab7:	6a 07                	push   $0x7
  801ab9:	e8 fb fe ff ff       	call   8019b9 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
  801ac6:	56                   	push   %esi
  801ac7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ac8:	8b 75 18             	mov    0x18(%ebp),%esi
  801acb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ace:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad7:	56                   	push   %esi
  801ad8:	53                   	push   %ebx
  801ad9:	51                   	push   %ecx
  801ada:	52                   	push   %edx
  801adb:	50                   	push   %eax
  801adc:	6a 08                	push   $0x8
  801ade:	e8 d6 fe ff ff       	call   8019b9 <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ae9:	5b                   	pop    %ebx
  801aea:	5e                   	pop    %esi
  801aeb:	5d                   	pop    %ebp
  801aec:	c3                   	ret    

00801aed <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801aed:	55                   	push   %ebp
  801aee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801af0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	52                   	push   %edx
  801afd:	50                   	push   %eax
  801afe:	6a 09                	push   $0x9
  801b00:	e8 b4 fe ff ff       	call   8019b9 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	ff 75 0c             	pushl  0xc(%ebp)
  801b16:	ff 75 08             	pushl  0x8(%ebp)
  801b19:	6a 0a                	push   $0xa
  801b1b:	e8 99 fe ff ff       	call   8019b9 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 0b                	push   $0xb
  801b34:	e8 80 fe ff ff       	call   8019b9 <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
}
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 0c                	push   $0xc
  801b4d:	e8 67 fe ff ff       	call   8019b9 <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 0d                	push   $0xd
  801b66:	e8 4e fe ff ff       	call   8019b9 <syscall>
  801b6b:	83 c4 18             	add    $0x18,%esp
}
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	ff 75 0c             	pushl  0xc(%ebp)
  801b7c:	ff 75 08             	pushl  0x8(%ebp)
  801b7f:	6a 11                	push   $0x11
  801b81:	e8 33 fe ff ff       	call   8019b9 <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
	return;
  801b89:	90                   	nop
}
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	ff 75 0c             	pushl  0xc(%ebp)
  801b98:	ff 75 08             	pushl  0x8(%ebp)
  801b9b:	6a 12                	push   $0x12
  801b9d:	e8 17 fe ff ff       	call   8019b9 <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba5:	90                   	nop
}
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 0e                	push   $0xe
  801bb7:	e8 fd fd ff ff       	call   8019b9 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	ff 75 08             	pushl  0x8(%ebp)
  801bcf:	6a 0f                	push   $0xf
  801bd1:	e8 e3 fd ff ff       	call   8019b9 <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
}
  801bd9:	c9                   	leave  
  801bda:	c3                   	ret    

00801bdb <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bdb:	55                   	push   %ebp
  801bdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 10                	push   $0x10
  801bea:	e8 ca fd ff ff       	call   8019b9 <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
}
  801bf2:	90                   	nop
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 14                	push   $0x14
  801c04:	e8 b0 fd ff ff       	call   8019b9 <syscall>
  801c09:	83 c4 18             	add    $0x18,%esp
}
  801c0c:	90                   	nop
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 15                	push   $0x15
  801c1e:	e8 96 fd ff ff       	call   8019b9 <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	90                   	nop
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
  801c2c:	83 ec 04             	sub    $0x4,%esp
  801c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c32:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c35:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	50                   	push   %eax
  801c42:	6a 16                	push   $0x16
  801c44:	e8 70 fd ff ff       	call   8019b9 <syscall>
  801c49:	83 c4 18             	add    $0x18,%esp
}
  801c4c:	90                   	nop
  801c4d:	c9                   	leave  
  801c4e:	c3                   	ret    

00801c4f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c4f:	55                   	push   %ebp
  801c50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 17                	push   $0x17
  801c5e:	e8 56 fd ff ff       	call   8019b9 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	90                   	nop
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	ff 75 0c             	pushl  0xc(%ebp)
  801c78:	50                   	push   %eax
  801c79:	6a 18                	push   $0x18
  801c7b:	e8 39 fd ff ff       	call   8019b9 <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
}
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	52                   	push   %edx
  801c95:	50                   	push   %eax
  801c96:	6a 1b                	push   $0x1b
  801c98:	e8 1c fd ff ff       	call   8019b9 <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ca5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	52                   	push   %edx
  801cb2:	50                   	push   %eax
  801cb3:	6a 19                	push   $0x19
  801cb5:	e8 ff fc ff ff       	call   8019b9 <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
}
  801cbd:	90                   	nop
  801cbe:	c9                   	leave  
  801cbf:	c3                   	ret    

00801cc0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	52                   	push   %edx
  801cd0:	50                   	push   %eax
  801cd1:	6a 1a                	push   $0x1a
  801cd3:	e8 e1 fc ff ff       	call   8019b9 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	90                   	nop
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
  801ce1:	83 ec 04             	sub    $0x4,%esp
  801ce4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce7:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801cea:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ced:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf4:	6a 00                	push   $0x0
  801cf6:	51                   	push   %ecx
  801cf7:	52                   	push   %edx
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	50                   	push   %eax
  801cfc:	6a 1c                	push   $0x1c
  801cfe:	e8 b6 fc ff ff       	call   8019b9 <syscall>
  801d03:	83 c4 18             	add    $0x18,%esp
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	52                   	push   %edx
  801d18:	50                   	push   %eax
  801d19:	6a 1d                	push   $0x1d
  801d1b:	e8 99 fc ff ff       	call   8019b9 <syscall>
  801d20:	83 c4 18             	add    $0x18,%esp
}
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	51                   	push   %ecx
  801d36:	52                   	push   %edx
  801d37:	50                   	push   %eax
  801d38:	6a 1e                	push   $0x1e
  801d3a:	e8 7a fc ff ff       	call   8019b9 <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	52                   	push   %edx
  801d54:	50                   	push   %eax
  801d55:	6a 1f                	push   $0x1f
  801d57:	e8 5d fc ff ff       	call   8019b9 <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 20                	push   $0x20
  801d70:	e8 44 fc ff ff       	call   8019b9 <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
}
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	ff 75 10             	pushl  0x10(%ebp)
  801d87:	ff 75 0c             	pushl  0xc(%ebp)
  801d8a:	50                   	push   %eax
  801d8b:	6a 21                	push   $0x21
  801d8d:	e8 27 fc ff ff       	call   8019b9 <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	50                   	push   %eax
  801da6:	6a 22                	push   $0x22
  801da8:	e8 0c fc ff ff       	call   8019b9 <syscall>
  801dad:	83 c4 18             	add    $0x18,%esp
}
  801db0:	90                   	nop
  801db1:	c9                   	leave  
  801db2:	c3                   	ret    

00801db3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801db3:	55                   	push   %ebp
  801db4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801db6:	8b 45 08             	mov    0x8(%ebp),%eax
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	50                   	push   %eax
  801dc2:	6a 23                	push   $0x23
  801dc4:	e8 f0 fb ff ff       	call   8019b9 <syscall>
  801dc9:	83 c4 18             	add    $0x18,%esp
}
  801dcc:	90                   	nop
  801dcd:	c9                   	leave  
  801dce:	c3                   	ret    

00801dcf <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801dcf:	55                   	push   %ebp
  801dd0:	89 e5                	mov    %esp,%ebp
  801dd2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801dd5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801dd8:	8d 50 04             	lea    0x4(%eax),%edx
  801ddb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	52                   	push   %edx
  801de5:	50                   	push   %eax
  801de6:	6a 24                	push   $0x24
  801de8:	e8 cc fb ff ff       	call   8019b9 <syscall>
  801ded:	83 c4 18             	add    $0x18,%esp
	return result;
  801df0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801df3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801df9:	89 01                	mov    %eax,(%ecx)
  801dfb:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801e01:	c9                   	leave  
  801e02:	c2 04 00             	ret    $0x4

00801e05 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	ff 75 10             	pushl  0x10(%ebp)
  801e0f:	ff 75 0c             	pushl  0xc(%ebp)
  801e12:	ff 75 08             	pushl  0x8(%ebp)
  801e15:	6a 13                	push   $0x13
  801e17:	e8 9d fb ff ff       	call   8019b9 <syscall>
  801e1c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e1f:	90                   	nop
}
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    

00801e22 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e22:	55                   	push   %ebp
  801e23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 25                	push   $0x25
  801e31:	e8 83 fb ff ff       	call   8019b9 <syscall>
  801e36:	83 c4 18             	add    $0x18,%esp
}
  801e39:	c9                   	leave  
  801e3a:	c3                   	ret    

00801e3b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e3b:	55                   	push   %ebp
  801e3c:	89 e5                	mov    %esp,%ebp
  801e3e:	83 ec 04             	sub    $0x4,%esp
  801e41:	8b 45 08             	mov    0x8(%ebp),%eax
  801e44:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e47:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	50                   	push   %eax
  801e54:	6a 26                	push   $0x26
  801e56:	e8 5e fb ff ff       	call   8019b9 <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801e5e:	90                   	nop
}
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <rsttst>:
void rsttst()
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 28                	push   $0x28
  801e70:	e8 44 fb ff ff       	call   8019b9 <syscall>
  801e75:	83 c4 18             	add    $0x18,%esp
	return ;
  801e78:	90                   	nop
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
  801e7e:	83 ec 04             	sub    $0x4,%esp
  801e81:	8b 45 14             	mov    0x14(%ebp),%eax
  801e84:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e87:	8b 55 18             	mov    0x18(%ebp),%edx
  801e8a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e8e:	52                   	push   %edx
  801e8f:	50                   	push   %eax
  801e90:	ff 75 10             	pushl  0x10(%ebp)
  801e93:	ff 75 0c             	pushl  0xc(%ebp)
  801e96:	ff 75 08             	pushl  0x8(%ebp)
  801e99:	6a 27                	push   $0x27
  801e9b:	e8 19 fb ff ff       	call   8019b9 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea3:	90                   	nop
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <chktst>:
void chktst(uint32 n)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	ff 75 08             	pushl  0x8(%ebp)
  801eb4:	6a 29                	push   $0x29
  801eb6:	e8 fe fa ff ff       	call   8019b9 <syscall>
  801ebb:	83 c4 18             	add    $0x18,%esp
	return ;
  801ebe:	90                   	nop
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <inctst>:

void inctst()
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 2a                	push   $0x2a
  801ed0:	e8 e4 fa ff ff       	call   8019b9 <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed8:	90                   	nop
}
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    

00801edb <gettst>:
uint32 gettst()
{
  801edb:	55                   	push   %ebp
  801edc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 2b                	push   $0x2b
  801eea:	e8 ca fa ff ff       	call   8019b9 <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
}
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
  801ef7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 2c                	push   $0x2c
  801f06:	e8 ae fa ff ff       	call   8019b9 <syscall>
  801f0b:	83 c4 18             	add    $0x18,%esp
  801f0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f11:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f15:	75 07                	jne    801f1e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f17:	b8 01 00 00 00       	mov    $0x1,%eax
  801f1c:	eb 05                	jmp    801f23 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f23:	c9                   	leave  
  801f24:	c3                   	ret    

00801f25 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f25:	55                   	push   %ebp
  801f26:	89 e5                	mov    %esp,%ebp
  801f28:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 2c                	push   $0x2c
  801f37:	e8 7d fa ff ff       	call   8019b9 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
  801f3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f42:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f46:	75 07                	jne    801f4f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f48:	b8 01 00 00 00       	mov    $0x1,%eax
  801f4d:	eb 05                	jmp    801f54 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
  801f59:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 2c                	push   $0x2c
  801f68:	e8 4c fa ff ff       	call   8019b9 <syscall>
  801f6d:	83 c4 18             	add    $0x18,%esp
  801f70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f73:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f77:	75 07                	jne    801f80 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f79:	b8 01 00 00 00       	mov    $0x1,%eax
  801f7e:	eb 05                	jmp    801f85 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f85:	c9                   	leave  
  801f86:	c3                   	ret    

00801f87 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f87:	55                   	push   %ebp
  801f88:	89 e5                	mov    %esp,%ebp
  801f8a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 2c                	push   $0x2c
  801f99:	e8 1b fa ff ff       	call   8019b9 <syscall>
  801f9e:	83 c4 18             	add    $0x18,%esp
  801fa1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fa4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fa8:	75 07                	jne    801fb1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801faa:	b8 01 00 00 00       	mov    $0x1,%eax
  801faf:	eb 05                	jmp    801fb6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fb1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb6:	c9                   	leave  
  801fb7:	c3                   	ret    

00801fb8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	ff 75 08             	pushl  0x8(%ebp)
  801fc6:	6a 2d                	push   $0x2d
  801fc8:	e8 ec f9 ff ff       	call   8019b9 <syscall>
  801fcd:	83 c4 18             	add    $0x18,%esp
	return ;
  801fd0:	90                   	nop
}
  801fd1:	c9                   	leave  
  801fd2:	c3                   	ret    
  801fd3:	90                   	nop

00801fd4 <__udivdi3>:
  801fd4:	55                   	push   %ebp
  801fd5:	57                   	push   %edi
  801fd6:	56                   	push   %esi
  801fd7:	53                   	push   %ebx
  801fd8:	83 ec 1c             	sub    $0x1c,%esp
  801fdb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fdf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fe3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fe7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801feb:	89 ca                	mov    %ecx,%edx
  801fed:	89 f8                	mov    %edi,%eax
  801fef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ff3:	85 f6                	test   %esi,%esi
  801ff5:	75 2d                	jne    802024 <__udivdi3+0x50>
  801ff7:	39 cf                	cmp    %ecx,%edi
  801ff9:	77 65                	ja     802060 <__udivdi3+0x8c>
  801ffb:	89 fd                	mov    %edi,%ebp
  801ffd:	85 ff                	test   %edi,%edi
  801fff:	75 0b                	jne    80200c <__udivdi3+0x38>
  802001:	b8 01 00 00 00       	mov    $0x1,%eax
  802006:	31 d2                	xor    %edx,%edx
  802008:	f7 f7                	div    %edi
  80200a:	89 c5                	mov    %eax,%ebp
  80200c:	31 d2                	xor    %edx,%edx
  80200e:	89 c8                	mov    %ecx,%eax
  802010:	f7 f5                	div    %ebp
  802012:	89 c1                	mov    %eax,%ecx
  802014:	89 d8                	mov    %ebx,%eax
  802016:	f7 f5                	div    %ebp
  802018:	89 cf                	mov    %ecx,%edi
  80201a:	89 fa                	mov    %edi,%edx
  80201c:	83 c4 1c             	add    $0x1c,%esp
  80201f:	5b                   	pop    %ebx
  802020:	5e                   	pop    %esi
  802021:	5f                   	pop    %edi
  802022:	5d                   	pop    %ebp
  802023:	c3                   	ret    
  802024:	39 ce                	cmp    %ecx,%esi
  802026:	77 28                	ja     802050 <__udivdi3+0x7c>
  802028:	0f bd fe             	bsr    %esi,%edi
  80202b:	83 f7 1f             	xor    $0x1f,%edi
  80202e:	75 40                	jne    802070 <__udivdi3+0x9c>
  802030:	39 ce                	cmp    %ecx,%esi
  802032:	72 0a                	jb     80203e <__udivdi3+0x6a>
  802034:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802038:	0f 87 9e 00 00 00    	ja     8020dc <__udivdi3+0x108>
  80203e:	b8 01 00 00 00       	mov    $0x1,%eax
  802043:	89 fa                	mov    %edi,%edx
  802045:	83 c4 1c             	add    $0x1c,%esp
  802048:	5b                   	pop    %ebx
  802049:	5e                   	pop    %esi
  80204a:	5f                   	pop    %edi
  80204b:	5d                   	pop    %ebp
  80204c:	c3                   	ret    
  80204d:	8d 76 00             	lea    0x0(%esi),%esi
  802050:	31 ff                	xor    %edi,%edi
  802052:	31 c0                	xor    %eax,%eax
  802054:	89 fa                	mov    %edi,%edx
  802056:	83 c4 1c             	add    $0x1c,%esp
  802059:	5b                   	pop    %ebx
  80205a:	5e                   	pop    %esi
  80205b:	5f                   	pop    %edi
  80205c:	5d                   	pop    %ebp
  80205d:	c3                   	ret    
  80205e:	66 90                	xchg   %ax,%ax
  802060:	89 d8                	mov    %ebx,%eax
  802062:	f7 f7                	div    %edi
  802064:	31 ff                	xor    %edi,%edi
  802066:	89 fa                	mov    %edi,%edx
  802068:	83 c4 1c             	add    $0x1c,%esp
  80206b:	5b                   	pop    %ebx
  80206c:	5e                   	pop    %esi
  80206d:	5f                   	pop    %edi
  80206e:	5d                   	pop    %ebp
  80206f:	c3                   	ret    
  802070:	bd 20 00 00 00       	mov    $0x20,%ebp
  802075:	89 eb                	mov    %ebp,%ebx
  802077:	29 fb                	sub    %edi,%ebx
  802079:	89 f9                	mov    %edi,%ecx
  80207b:	d3 e6                	shl    %cl,%esi
  80207d:	89 c5                	mov    %eax,%ebp
  80207f:	88 d9                	mov    %bl,%cl
  802081:	d3 ed                	shr    %cl,%ebp
  802083:	89 e9                	mov    %ebp,%ecx
  802085:	09 f1                	or     %esi,%ecx
  802087:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80208b:	89 f9                	mov    %edi,%ecx
  80208d:	d3 e0                	shl    %cl,%eax
  80208f:	89 c5                	mov    %eax,%ebp
  802091:	89 d6                	mov    %edx,%esi
  802093:	88 d9                	mov    %bl,%cl
  802095:	d3 ee                	shr    %cl,%esi
  802097:	89 f9                	mov    %edi,%ecx
  802099:	d3 e2                	shl    %cl,%edx
  80209b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80209f:	88 d9                	mov    %bl,%cl
  8020a1:	d3 e8                	shr    %cl,%eax
  8020a3:	09 c2                	or     %eax,%edx
  8020a5:	89 d0                	mov    %edx,%eax
  8020a7:	89 f2                	mov    %esi,%edx
  8020a9:	f7 74 24 0c          	divl   0xc(%esp)
  8020ad:	89 d6                	mov    %edx,%esi
  8020af:	89 c3                	mov    %eax,%ebx
  8020b1:	f7 e5                	mul    %ebp
  8020b3:	39 d6                	cmp    %edx,%esi
  8020b5:	72 19                	jb     8020d0 <__udivdi3+0xfc>
  8020b7:	74 0b                	je     8020c4 <__udivdi3+0xf0>
  8020b9:	89 d8                	mov    %ebx,%eax
  8020bb:	31 ff                	xor    %edi,%edi
  8020bd:	e9 58 ff ff ff       	jmp    80201a <__udivdi3+0x46>
  8020c2:	66 90                	xchg   %ax,%ax
  8020c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020c8:	89 f9                	mov    %edi,%ecx
  8020ca:	d3 e2                	shl    %cl,%edx
  8020cc:	39 c2                	cmp    %eax,%edx
  8020ce:	73 e9                	jae    8020b9 <__udivdi3+0xe5>
  8020d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020d3:	31 ff                	xor    %edi,%edi
  8020d5:	e9 40 ff ff ff       	jmp    80201a <__udivdi3+0x46>
  8020da:	66 90                	xchg   %ax,%ax
  8020dc:	31 c0                	xor    %eax,%eax
  8020de:	e9 37 ff ff ff       	jmp    80201a <__udivdi3+0x46>
  8020e3:	90                   	nop

008020e4 <__umoddi3>:
  8020e4:	55                   	push   %ebp
  8020e5:	57                   	push   %edi
  8020e6:	56                   	push   %esi
  8020e7:	53                   	push   %ebx
  8020e8:	83 ec 1c             	sub    $0x1c,%esp
  8020eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802103:	89 f3                	mov    %esi,%ebx
  802105:	89 fa                	mov    %edi,%edx
  802107:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80210b:	89 34 24             	mov    %esi,(%esp)
  80210e:	85 c0                	test   %eax,%eax
  802110:	75 1a                	jne    80212c <__umoddi3+0x48>
  802112:	39 f7                	cmp    %esi,%edi
  802114:	0f 86 a2 00 00 00    	jbe    8021bc <__umoddi3+0xd8>
  80211a:	89 c8                	mov    %ecx,%eax
  80211c:	89 f2                	mov    %esi,%edx
  80211e:	f7 f7                	div    %edi
  802120:	89 d0                	mov    %edx,%eax
  802122:	31 d2                	xor    %edx,%edx
  802124:	83 c4 1c             	add    $0x1c,%esp
  802127:	5b                   	pop    %ebx
  802128:	5e                   	pop    %esi
  802129:	5f                   	pop    %edi
  80212a:	5d                   	pop    %ebp
  80212b:	c3                   	ret    
  80212c:	39 f0                	cmp    %esi,%eax
  80212e:	0f 87 ac 00 00 00    	ja     8021e0 <__umoddi3+0xfc>
  802134:	0f bd e8             	bsr    %eax,%ebp
  802137:	83 f5 1f             	xor    $0x1f,%ebp
  80213a:	0f 84 ac 00 00 00    	je     8021ec <__umoddi3+0x108>
  802140:	bf 20 00 00 00       	mov    $0x20,%edi
  802145:	29 ef                	sub    %ebp,%edi
  802147:	89 fe                	mov    %edi,%esi
  802149:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80214d:	89 e9                	mov    %ebp,%ecx
  80214f:	d3 e0                	shl    %cl,%eax
  802151:	89 d7                	mov    %edx,%edi
  802153:	89 f1                	mov    %esi,%ecx
  802155:	d3 ef                	shr    %cl,%edi
  802157:	09 c7                	or     %eax,%edi
  802159:	89 e9                	mov    %ebp,%ecx
  80215b:	d3 e2                	shl    %cl,%edx
  80215d:	89 14 24             	mov    %edx,(%esp)
  802160:	89 d8                	mov    %ebx,%eax
  802162:	d3 e0                	shl    %cl,%eax
  802164:	89 c2                	mov    %eax,%edx
  802166:	8b 44 24 08          	mov    0x8(%esp),%eax
  80216a:	d3 e0                	shl    %cl,%eax
  80216c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802170:	8b 44 24 08          	mov    0x8(%esp),%eax
  802174:	89 f1                	mov    %esi,%ecx
  802176:	d3 e8                	shr    %cl,%eax
  802178:	09 d0                	or     %edx,%eax
  80217a:	d3 eb                	shr    %cl,%ebx
  80217c:	89 da                	mov    %ebx,%edx
  80217e:	f7 f7                	div    %edi
  802180:	89 d3                	mov    %edx,%ebx
  802182:	f7 24 24             	mull   (%esp)
  802185:	89 c6                	mov    %eax,%esi
  802187:	89 d1                	mov    %edx,%ecx
  802189:	39 d3                	cmp    %edx,%ebx
  80218b:	0f 82 87 00 00 00    	jb     802218 <__umoddi3+0x134>
  802191:	0f 84 91 00 00 00    	je     802228 <__umoddi3+0x144>
  802197:	8b 54 24 04          	mov    0x4(%esp),%edx
  80219b:	29 f2                	sub    %esi,%edx
  80219d:	19 cb                	sbb    %ecx,%ebx
  80219f:	89 d8                	mov    %ebx,%eax
  8021a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021a5:	d3 e0                	shl    %cl,%eax
  8021a7:	89 e9                	mov    %ebp,%ecx
  8021a9:	d3 ea                	shr    %cl,%edx
  8021ab:	09 d0                	or     %edx,%eax
  8021ad:	89 e9                	mov    %ebp,%ecx
  8021af:	d3 eb                	shr    %cl,%ebx
  8021b1:	89 da                	mov    %ebx,%edx
  8021b3:	83 c4 1c             	add    $0x1c,%esp
  8021b6:	5b                   	pop    %ebx
  8021b7:	5e                   	pop    %esi
  8021b8:	5f                   	pop    %edi
  8021b9:	5d                   	pop    %ebp
  8021ba:	c3                   	ret    
  8021bb:	90                   	nop
  8021bc:	89 fd                	mov    %edi,%ebp
  8021be:	85 ff                	test   %edi,%edi
  8021c0:	75 0b                	jne    8021cd <__umoddi3+0xe9>
  8021c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c7:	31 d2                	xor    %edx,%edx
  8021c9:	f7 f7                	div    %edi
  8021cb:	89 c5                	mov    %eax,%ebp
  8021cd:	89 f0                	mov    %esi,%eax
  8021cf:	31 d2                	xor    %edx,%edx
  8021d1:	f7 f5                	div    %ebp
  8021d3:	89 c8                	mov    %ecx,%eax
  8021d5:	f7 f5                	div    %ebp
  8021d7:	89 d0                	mov    %edx,%eax
  8021d9:	e9 44 ff ff ff       	jmp    802122 <__umoddi3+0x3e>
  8021de:	66 90                	xchg   %ax,%ax
  8021e0:	89 c8                	mov    %ecx,%eax
  8021e2:	89 f2                	mov    %esi,%edx
  8021e4:	83 c4 1c             	add    $0x1c,%esp
  8021e7:	5b                   	pop    %ebx
  8021e8:	5e                   	pop    %esi
  8021e9:	5f                   	pop    %edi
  8021ea:	5d                   	pop    %ebp
  8021eb:	c3                   	ret    
  8021ec:	3b 04 24             	cmp    (%esp),%eax
  8021ef:	72 06                	jb     8021f7 <__umoddi3+0x113>
  8021f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021f5:	77 0f                	ja     802206 <__umoddi3+0x122>
  8021f7:	89 f2                	mov    %esi,%edx
  8021f9:	29 f9                	sub    %edi,%ecx
  8021fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021ff:	89 14 24             	mov    %edx,(%esp)
  802202:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802206:	8b 44 24 04          	mov    0x4(%esp),%eax
  80220a:	8b 14 24             	mov    (%esp),%edx
  80220d:	83 c4 1c             	add    $0x1c,%esp
  802210:	5b                   	pop    %ebx
  802211:	5e                   	pop    %esi
  802212:	5f                   	pop    %edi
  802213:	5d                   	pop    %ebp
  802214:	c3                   	ret    
  802215:	8d 76 00             	lea    0x0(%esi),%esi
  802218:	2b 04 24             	sub    (%esp),%eax
  80221b:	19 fa                	sbb    %edi,%edx
  80221d:	89 d1                	mov    %edx,%ecx
  80221f:	89 c6                	mov    %eax,%esi
  802221:	e9 71 ff ff ff       	jmp    802197 <__umoddi3+0xb3>
  802226:	66 90                	xchg   %ax,%ax
  802228:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80222c:	72 ea                	jb     802218 <__umoddi3+0x134>
  80222e:	89 d9                	mov    %ebx,%ecx
  802230:	e9 62 ff ff ff       	jmp    802197 <__umoddi3+0xb3>
