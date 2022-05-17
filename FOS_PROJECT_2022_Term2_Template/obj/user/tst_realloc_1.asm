
obj/user/tst_realloc_1:     file format elf32-i386


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
  800031:	e8 38 11 00 00       	call   80116e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 c4 80             	add    $0xffffff80,%esp
	int Mega = 1024*1024;
  800040:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
	int kilo = 1024;
  800047:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	void* ptr_allocations[20] = {0};
  80004e:	8d 55 80             	lea    -0x80(%ebp),%edx
  800051:	b9 14 00 00 00       	mov    $0x14,%ecx
  800056:	b8 00 00 00 00       	mov    $0x0,%eax
  80005b:	89 d7                	mov    %edx,%edi
  80005d:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 80 2e 80 00       	push   $0x802e80
  800067:	e8 c5 14 00 00       	call   801531 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80006f:	e8 ef 26 00 00       	call   802763 <sys_calculate_free_frames>
  800074:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800077:	e8 6a 27 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80007c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80007f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800082:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800085:	83 ec 0c             	sub    $0xc,%esp
  800088:	50                   	push   %eax
  800089:	e8 12 24 00 00       	call   8024a0 <malloc>
  80008e:	83 c4 10             	add    $0x10,%esp
  800091:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800094:	8b 45 80             	mov    -0x80(%ebp),%eax
  800097:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80009c:	74 14                	je     8000b2 <_main+0x7a>
  80009e:	83 ec 04             	sub    $0x4,%esp
  8000a1:	68 a4 2e 80 00       	push   $0x802ea4
  8000a6:	6a 11                	push   $0x11
  8000a8:	68 d4 2e 80 00       	push   $0x802ed4
  8000ad:	e8 cb 11 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000b2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000b5:	e8 a9 26 00 00       	call   802763 <sys_calculate_free_frames>
  8000ba:	29 c3                	sub    %eax,%ebx
  8000bc:	89 d8                	mov    %ebx,%eax
  8000be:	83 f8 01             	cmp    $0x1,%eax
  8000c1:	74 14                	je     8000d7 <_main+0x9f>
  8000c3:	83 ec 04             	sub    $0x4,%esp
  8000c6:	68 ec 2e 80 00       	push   $0x802eec
  8000cb:	6a 13                	push   $0x13
  8000cd:	68 d4 2e 80 00       	push   $0x802ed4
  8000d2:	e8 a6 11 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256)panic("Extra or less pages are allocated in PageFile");
  8000d7:	e8 0a 27 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8000dc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000df:	3d 00 01 00 00       	cmp    $0x100,%eax
  8000e4:	74 14                	je     8000fa <_main+0xc2>
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	68 58 2f 80 00       	push   $0x802f58
  8000ee:	6a 14                	push   $0x14
  8000f0:	68 d4 2e 80 00       	push   $0x802ed4
  8000f5:	e8 83 11 00 00       	call   80127d <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 64 26 00 00       	call   802763 <sys_calculate_free_frames>
  8000ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800102:	e8 df 26 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800107:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  80010a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80010d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	50                   	push   %eax
  800114:	e8 87 23 00 00       	call   8024a0 <malloc>
  800119:	83 c4 10             	add    $0x10,%esp
  80011c:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80011f:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800122:	89 c2                	mov    %eax,%edx
  800124:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800127:	05 00 00 00 80       	add    $0x80000000,%eax
  80012c:	39 c2                	cmp    %eax,%edx
  80012e:	74 14                	je     800144 <_main+0x10c>
  800130:	83 ec 04             	sub    $0x4,%esp
  800133:	68 a4 2e 80 00       	push   $0x802ea4
  800138:	6a 19                	push   $0x19
  80013a:	68 d4 2e 80 00       	push   $0x802ed4
  80013f:	e8 39 11 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800144:	e8 1a 26 00 00       	call   802763 <sys_calculate_free_frames>
  800149:	89 c2                	mov    %eax,%edx
  80014b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80014e:	39 c2                	cmp    %eax,%edx
  800150:	74 14                	je     800166 <_main+0x12e>
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	68 ec 2e 80 00       	push   $0x802eec
  80015a:	6a 1b                	push   $0x1b
  80015c:	68 d4 2e 80 00       	push   $0x802ed4
  800161:	e8 17 11 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800166:	e8 7b 26 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80016b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80016e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 58 2f 80 00       	push   $0x802f58
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 d4 2e 80 00       	push   $0x802ed4
  800184:	e8 f4 10 00 00       	call   80127d <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800189:	e8 d5 25 00 00       	call   802763 <sys_calculate_free_frames>
  80018e:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800191:	e8 50 26 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800196:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800199:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80019c:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	50                   	push   %eax
  8001a3:	e8 f8 22 00 00       	call   8024a0 <malloc>
  8001a8:	83 c4 10             	add    $0x10,%esp
  8001ab:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  8001ae:	8b 45 88             	mov    -0x78(%ebp),%eax
  8001b1:	89 c2                	mov    %eax,%edx
  8001b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001b6:	01 c0                	add    %eax,%eax
  8001b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8001bd:	39 c2                	cmp    %eax,%edx
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 a4 2e 80 00       	push   $0x802ea4
  8001c9:	6a 21                	push   $0x21
  8001cb:	68 d4 2e 80 00       	push   $0x802ed4
  8001d0:	e8 a8 10 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001d5:	e8 89 25 00 00       	call   802763 <sys_calculate_free_frames>
  8001da:	89 c2                	mov    %eax,%edx
  8001dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001df:	39 c2                	cmp    %eax,%edx
  8001e1:	74 14                	je     8001f7 <_main+0x1bf>
  8001e3:	83 ec 04             	sub    $0x4,%esp
  8001e6:	68 ec 2e 80 00       	push   $0x802eec
  8001eb:	6a 23                	push   $0x23
  8001ed:	68 d4 2e 80 00       	push   $0x802ed4
  8001f2:	e8 86 10 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  8001f7:	e8 ea 25 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8001fc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001ff:	3d 00 01 00 00       	cmp    $0x100,%eax
  800204:	74 14                	je     80021a <_main+0x1e2>
  800206:	83 ec 04             	sub    $0x4,%esp
  800209:	68 58 2f 80 00       	push   $0x802f58
  80020e:	6a 24                	push   $0x24
  800210:	68 d4 2e 80 00       	push   $0x802ed4
  800215:	e8 63 10 00 00       	call   80127d <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80021a:	e8 44 25 00 00       	call   802763 <sys_calculate_free_frames>
  80021f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800222:	e8 bf 25 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80022a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80022d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	50                   	push   %eax
  800234:	e8 67 22 00 00       	call   8024a0 <malloc>
  800239:	83 c4 10             	add    $0x10,%esp
  80023c:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  80023f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800242:	89 c1                	mov    %eax,%ecx
  800244:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800247:	89 c2                	mov    %eax,%edx
  800249:	01 d2                	add    %edx,%edx
  80024b:	01 d0                	add    %edx,%eax
  80024d:	05 00 00 00 80       	add    $0x80000000,%eax
  800252:	39 c1                	cmp    %eax,%ecx
  800254:	74 14                	je     80026a <_main+0x232>
  800256:	83 ec 04             	sub    $0x4,%esp
  800259:	68 a4 2e 80 00       	push   $0x802ea4
  80025e:	6a 2a                	push   $0x2a
  800260:	68 d4 2e 80 00       	push   $0x802ed4
  800265:	e8 13 10 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80026a:	e8 f4 24 00 00       	call   802763 <sys_calculate_free_frames>
  80026f:	89 c2                	mov    %eax,%edx
  800271:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800274:	39 c2                	cmp    %eax,%edx
  800276:	74 14                	je     80028c <_main+0x254>
  800278:	83 ec 04             	sub    $0x4,%esp
  80027b:	68 ec 2e 80 00       	push   $0x802eec
  800280:	6a 2c                	push   $0x2c
  800282:	68 d4 2e 80 00       	push   $0x802ed4
  800287:	e8 f1 0f 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  80028c:	e8 55 25 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800291:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800294:	3d 00 01 00 00       	cmp    $0x100,%eax
  800299:	74 14                	je     8002af <_main+0x277>
  80029b:	83 ec 04             	sub    $0x4,%esp
  80029e:	68 58 2f 80 00       	push   $0x802f58
  8002a3:	6a 2d                	push   $0x2d
  8002a5:	68 d4 2e 80 00       	push   $0x802ed4
  8002aa:	e8 ce 0f 00 00       	call   80127d <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8002af:	e8 af 24 00 00       	call   802763 <sys_calculate_free_frames>
  8002b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002b7:	e8 2a 25 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8002bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  8002bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c2:	01 c0                	add    %eax,%eax
  8002c4:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	50                   	push   %eax
  8002cb:	e8 d0 21 00 00       	call   8024a0 <malloc>
  8002d0:	83 c4 10             	add    $0x10,%esp
  8002d3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8002d6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8002d9:	89 c2                	mov    %eax,%edx
  8002db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002de:	c1 e0 02             	shl    $0x2,%eax
  8002e1:	05 00 00 00 80       	add    $0x80000000,%eax
  8002e6:	39 c2                	cmp    %eax,%edx
  8002e8:	74 14                	je     8002fe <_main+0x2c6>
  8002ea:	83 ec 04             	sub    $0x4,%esp
  8002ed:	68 a4 2e 80 00       	push   $0x802ea4
  8002f2:	6a 33                	push   $0x33
  8002f4:	68 d4 2e 80 00       	push   $0x802ed4
  8002f9:	e8 7f 0f 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002fe:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800301:	e8 5d 24 00 00       	call   802763 <sys_calculate_free_frames>
  800306:	29 c3                	sub    %eax,%ebx
  800308:	89 d8                	mov    %ebx,%eax
  80030a:	83 f8 01             	cmp    $0x1,%eax
  80030d:	74 14                	je     800323 <_main+0x2eb>
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 ec 2e 80 00       	push   $0x802eec
  800317:	6a 35                	push   $0x35
  800319:	68 d4 2e 80 00       	push   $0x802ed4
  80031e:	e8 5a 0f 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800323:	e8 be 24 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800328:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80032b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800330:	74 14                	je     800346 <_main+0x30e>
  800332:	83 ec 04             	sub    $0x4,%esp
  800335:	68 58 2f 80 00       	push   $0x802f58
  80033a:	6a 36                	push   $0x36
  80033c:	68 d4 2e 80 00       	push   $0x802ed4
  800341:	e8 37 0f 00 00       	call   80127d <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800346:	e8 18 24 00 00       	call   802763 <sys_calculate_free_frames>
  80034b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034e:	e8 93 24 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800353:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  800356:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800359:	01 c0                	add    %eax,%eax
  80035b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80035e:	83 ec 0c             	sub    $0xc,%esp
  800361:	50                   	push   %eax
  800362:	e8 39 21 00 00       	call   8024a0 <malloc>
  800367:	83 c4 10             	add    $0x10,%esp
  80036a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80036d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800370:	89 c1                	mov    %eax,%ecx
  800372:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800375:	89 d0                	mov    %edx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	05 00 00 00 80       	add    $0x80000000,%eax
  800382:	39 c1                	cmp    %eax,%ecx
  800384:	74 14                	je     80039a <_main+0x362>
  800386:	83 ec 04             	sub    $0x4,%esp
  800389:	68 a4 2e 80 00       	push   $0x802ea4
  80038e:	6a 3c                	push   $0x3c
  800390:	68 d4 2e 80 00       	push   $0x802ed4
  800395:	e8 e3 0e 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80039a:	e8 c4 23 00 00       	call   802763 <sys_calculate_free_frames>
  80039f:	89 c2                	mov    %eax,%edx
  8003a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a4:	39 c2                	cmp    %eax,%edx
  8003a6:	74 14                	je     8003bc <_main+0x384>
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 ec 2e 80 00       	push   $0x802eec
  8003b0:	6a 3e                	push   $0x3e
  8003b2:	68 d4 2e 80 00       	push   $0x802ed4
  8003b7:	e8 c1 0e 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8003bc:	e8 25 24 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8003c1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8003c4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003c9:	74 14                	je     8003df <_main+0x3a7>
  8003cb:	83 ec 04             	sub    $0x4,%esp
  8003ce:	68 58 2f 80 00       	push   $0x802f58
  8003d3:	6a 3f                	push   $0x3f
  8003d5:	68 d4 2e 80 00       	push   $0x802ed4
  8003da:	e8 9e 0e 00 00       	call   80127d <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003df:	e8 7f 23 00 00       	call   802763 <sys_calculate_free_frames>
  8003e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003e7:	e8 fa 23 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8003ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8003ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f2:	89 c2                	mov    %eax,%edx
  8003f4:	01 d2                	add    %edx,%edx
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8003fb:	83 ec 0c             	sub    $0xc,%esp
  8003fe:	50                   	push   %eax
  8003ff:	e8 9c 20 00 00       	call   8024a0 <malloc>
  800404:	83 c4 10             	add    $0x10,%esp
  800407:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  80040a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80040d:	89 c2                	mov    %eax,%edx
  80040f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800412:	c1 e0 03             	shl    $0x3,%eax
  800415:	05 00 00 00 80       	add    $0x80000000,%eax
  80041a:	39 c2                	cmp    %eax,%edx
  80041c:	74 14                	je     800432 <_main+0x3fa>
  80041e:	83 ec 04             	sub    $0x4,%esp
  800421:	68 a4 2e 80 00       	push   $0x802ea4
  800426:	6a 45                	push   $0x45
  800428:	68 d4 2e 80 00       	push   $0x802ed4
  80042d:	e8 4b 0e 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800432:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800435:	e8 29 23 00 00       	call   802763 <sys_calculate_free_frames>
  80043a:	29 c3                	sub    %eax,%ebx
  80043c:	89 d8                	mov    %ebx,%eax
  80043e:	83 f8 01             	cmp    $0x1,%eax
  800441:	74 14                	je     800457 <_main+0x41f>
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	68 ec 2e 80 00       	push   $0x802eec
  80044b:	6a 47                	push   $0x47
  80044d:	68 d4 2e 80 00       	push   $0x802ed4
  800452:	e8 26 0e 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800457:	e8 8a 23 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80045c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80045f:	3d 00 03 00 00       	cmp    $0x300,%eax
  800464:	74 14                	je     80047a <_main+0x442>
  800466:	83 ec 04             	sub    $0x4,%esp
  800469:	68 58 2f 80 00       	push   $0x802f58
  80046e:	6a 48                	push   $0x48
  800470:	68 d4 2e 80 00       	push   $0x802ed4
  800475:	e8 03 0e 00 00       	call   80127d <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80047a:	e8 e4 22 00 00       	call   802763 <sys_calculate_free_frames>
  80047f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800482:	e8 5f 23 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800487:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  80048a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048d:	89 c2                	mov    %eax,%edx
  80048f:	01 d2                	add    %edx,%edx
  800491:	01 d0                	add    %edx,%eax
  800493:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800496:	83 ec 0c             	sub    $0xc,%esp
  800499:	50                   	push   %eax
  80049a:	e8 01 20 00 00       	call   8024a0 <malloc>
  80049f:	83 c4 10             	add    $0x10,%esp
  8004a2:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[7] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004a5:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004a8:	89 c1                	mov    %eax,%ecx
  8004aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004ad:	89 d0                	mov    %edx,%eax
  8004af:	c1 e0 02             	shl    $0x2,%eax
  8004b2:	01 d0                	add    %edx,%eax
  8004b4:	01 c0                	add    %eax,%eax
  8004b6:	01 d0                	add    %edx,%eax
  8004b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8004bd:	39 c1                	cmp    %eax,%ecx
  8004bf:	74 14                	je     8004d5 <_main+0x49d>
  8004c1:	83 ec 04             	sub    $0x4,%esp
  8004c4:	68 a4 2e 80 00       	push   $0x802ea4
  8004c9:	6a 4e                	push   $0x4e
  8004cb:	68 d4 2e 80 00       	push   $0x802ed4
  8004d0:	e8 a8 0d 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004d5:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8004d8:	e8 86 22 00 00       	call   802763 <sys_calculate_free_frames>
  8004dd:	29 c3                	sub    %eax,%ebx
  8004df:	89 d8                	mov    %ebx,%eax
  8004e1:	83 f8 01             	cmp    $0x1,%eax
  8004e4:	74 14                	je     8004fa <_main+0x4c2>
  8004e6:	83 ec 04             	sub    $0x4,%esp
  8004e9:	68 ec 2e 80 00       	push   $0x802eec
  8004ee:	6a 50                	push   $0x50
  8004f0:	68 d4 2e 80 00       	push   $0x802ed4
  8004f5:	e8 83 0d 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  8004fa:	e8 e7 22 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8004ff:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800502:	3d 00 03 00 00       	cmp    $0x300,%eax
  800507:	74 14                	je     80051d <_main+0x4e5>
  800509:	83 ec 04             	sub    $0x4,%esp
  80050c:	68 58 2f 80 00       	push   $0x802f58
  800511:	6a 51                	push   $0x51
  800513:	68 d4 2e 80 00       	push   $0x802ed4
  800518:	e8 60 0d 00 00       	call   80127d <_panic>


		//NEW
		//Filling the remaining size of user heap
		freeFrames = sys_calculate_free_frames() ;
  80051d:	e8 41 22 00 00       	call   802763 <sys_calculate_free_frames>
  800522:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800525:	e8 bc 22 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80052a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		uint32 remainingSpaceInUHeap = (USER_HEAP_MAX - USER_HEAP_START) - 14 * Mega;
  80052d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800530:	89 d0                	mov    %edx,%eax
  800532:	01 c0                	add    %eax,%eax
  800534:	01 d0                	add    %edx,%eax
  800536:	01 c0                	add    %eax,%eax
  800538:	01 d0                	add    %edx,%eax
  80053a:	01 c0                	add    %eax,%eax
  80053c:	f7 d8                	neg    %eax
  80053e:	05 00 00 00 20       	add    $0x20000000,%eax
  800543:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(remainingSpaceInUHeap - kilo);
  800546:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800549:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054c:	29 c2                	sub    %eax,%edx
  80054e:	89 d0                	mov    %edx,%eax
  800550:	83 ec 0c             	sub    $0xc,%esp
  800553:	50                   	push   %eax
  800554:	e8 47 1f 00 00       	call   8024a0 <malloc>
  800559:	83 c4 10             	add    $0x10,%esp
  80055c:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80055f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800562:	89 c1                	mov    %eax,%ecx
  800564:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	01 c0                	add    %eax,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	01 c0                	add    %eax,%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	01 c0                	add    %eax,%eax
  800573:	05 00 00 00 80       	add    $0x80000000,%eax
  800578:	39 c1                	cmp    %eax,%ecx
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 a4 2e 80 00       	push   $0x802ea4
  800584:	6a 5a                	push   $0x5a
  800586:	68 d4 2e 80 00       	push   $0x802ed4
  80058b:	e8 ed 0c 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 124) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800590:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800593:	e8 cb 21 00 00       	call   802763 <sys_calculate_free_frames>
  800598:	29 c3                	sub    %eax,%ebx
  80059a:	89 d8                	mov    %ebx,%eax
  80059c:	83 f8 7c             	cmp    $0x7c,%eax
  80059f:	74 14                	je     8005b5 <_main+0x57d>
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	68 ec 2e 80 00       	push   $0x802eec
  8005a9:	6a 5c                	push   $0x5c
  8005ab:	68 d4 2e 80 00       	push   $0x802ed4
  8005b0:	e8 c8 0c 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 127488) panic("Extra or less pages are allocated in PageFile");
  8005b5:	e8 2c 22 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8005ba:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8005bd:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  8005c2:	74 14                	je     8005d8 <_main+0x5a0>
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 58 2f 80 00       	push   $0x802f58
  8005cc:	6a 5d                	push   $0x5d
  8005ce:	68 d4 2e 80 00       	push   $0x802ed4
  8005d3:	e8 a5 0c 00 00       	call   80127d <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005d8:	e8 86 21 00 00       	call   802763 <sys_calculate_free_frames>
  8005dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005e0:	e8 01 22 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8005e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[1]);
  8005e8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8005eb:	83 ec 0c             	sub    $0xc,%esp
  8005ee:	50                   	push   %eax
  8005ef:	e8 3a 1f 00 00       	call   80252e <free>
  8005f4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  8005f7:	e8 ea 21 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8005fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8005ff:	29 c2                	sub    %eax,%edx
  800601:	89 d0                	mov    %edx,%eax
  800603:	3d 00 01 00 00       	cmp    $0x100,%eax
  800608:	74 14                	je     80061e <_main+0x5e6>
  80060a:	83 ec 04             	sub    $0x4,%esp
  80060d:	68 88 2f 80 00       	push   $0x802f88
  800612:	6a 68                	push   $0x68
  800614:	68 d4 2e 80 00       	push   $0x802ed4
  800619:	e8 5f 0c 00 00       	call   80127d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80061e:	e8 40 21 00 00       	call   802763 <sys_calculate_free_frames>
  800623:	89 c2                	mov    %eax,%edx
  800625:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800628:	39 c2                	cmp    %eax,%edx
  80062a:	74 14                	je     800640 <_main+0x608>
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	68 c4 2f 80 00       	push   $0x802fc4
  800634:	6a 69                	push   $0x69
  800636:	68 d4 2e 80 00       	push   $0x802ed4
  80063b:	e8 3d 0c 00 00       	call   80127d <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800640:	e8 1e 21 00 00       	call   802763 <sys_calculate_free_frames>
  800645:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800648:	e8 99 21 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80064d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[4]);
  800650:	8b 45 90             	mov    -0x70(%ebp),%eax
  800653:	83 ec 0c             	sub    $0xc,%esp
  800656:	50                   	push   %eax
  800657:	e8 d2 1e 00 00       	call   80252e <free>
  80065c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80065f:	e8 82 21 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800664:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800667:	29 c2                	sub    %eax,%edx
  800669:	89 d0                	mov    %edx,%eax
  80066b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800670:	74 14                	je     800686 <_main+0x64e>
  800672:	83 ec 04             	sub    $0x4,%esp
  800675:	68 88 2f 80 00       	push   $0x802f88
  80067a:	6a 70                	push   $0x70
  80067c:	68 d4 2e 80 00       	push   $0x802ed4
  800681:	e8 f7 0b 00 00       	call   80127d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800686:	e8 d8 20 00 00       	call   802763 <sys_calculate_free_frames>
  80068b:	89 c2                	mov    %eax,%edx
  80068d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800690:	39 c2                	cmp    %eax,%edx
  800692:	74 14                	je     8006a8 <_main+0x670>
  800694:	83 ec 04             	sub    $0x4,%esp
  800697:	68 c4 2f 80 00       	push   $0x802fc4
  80069c:	6a 71                	push   $0x71
  80069e:	68 d4 2e 80 00       	push   $0x802ed4
  8006a3:	e8 d5 0b 00 00       	call   80127d <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8006a8:	e8 b6 20 00 00       	call   802763 <sys_calculate_free_frames>
  8006ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006b0:	e8 31 21 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8006b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[6]);
  8006b8:	8b 45 98             	mov    -0x68(%ebp),%eax
  8006bb:	83 ec 0c             	sub    $0xc,%esp
  8006be:	50                   	push   %eax
  8006bf:	e8 6a 1e 00 00       	call   80252e <free>
  8006c4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 768) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006c7:	e8 1a 21 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  8006cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006cf:	29 c2                	sub    %eax,%edx
  8006d1:	89 d0                	mov    %edx,%eax
  8006d3:	3d 00 03 00 00       	cmp    $0x300,%eax
  8006d8:	74 14                	je     8006ee <_main+0x6b6>
  8006da:	83 ec 04             	sub    $0x4,%esp
  8006dd:	68 88 2f 80 00       	push   $0x802f88
  8006e2:	6a 78                	push   $0x78
  8006e4:	68 d4 2e 80 00       	push   $0x802ed4
  8006e9:	e8 8f 0b 00 00       	call   80127d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8006ee:	e8 70 20 00 00       	call   802763 <sys_calculate_free_frames>
  8006f3:	89 c2                	mov    %eax,%edx
  8006f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f8:	39 c2                	cmp    %eax,%edx
  8006fa:	74 14                	je     800710 <_main+0x6d8>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 c4 2f 80 00       	push   $0x802fc4
  800704:	6a 79                	push   $0x79
  800706:	68 d4 2e 80 00       	push   $0x802ed4
  80070b:	e8 6d 0b 00 00       	call   80127d <_panic>

		//NEW
		//free the latest Hole (the big one)
		freeFrames = sys_calculate_free_frames() ;
  800710:	e8 4e 20 00 00       	call   802763 <sys_calculate_free_frames>
  800715:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800718:	e8 c9 20 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80071d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[8]);
  800720:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	50                   	push   %eax
  800727:	e8 02 1e 00 00       	call   80252e <free>
  80072c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 127488) panic("Wrong free: Extra or less pages are removed from PageFile");
  80072f:	e8 b2 20 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800734:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800737:	29 c2                	sub    %eax,%edx
  800739:	89 d0                	mov    %edx,%eax
  80073b:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  800740:	74 17                	je     800759 <_main+0x721>
  800742:	83 ec 04             	sub    $0x4,%esp
  800745:	68 88 2f 80 00       	push   $0x802f88
  80074a:	68 81 00 00 00       	push   $0x81
  80074f:	68 d4 2e 80 00       	push   $0x802ed4
  800754:	e8 24 0b 00 00       	call   80127d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800759:	e8 05 20 00 00       	call   802763 <sys_calculate_free_frames>
  80075e:	89 c2                	mov    %eax,%edx
  800760:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800763:	39 c2                	cmp    %eax,%edx
  800765:	74 17                	je     80077e <_main+0x746>
  800767:	83 ec 04             	sub    $0x4,%esp
  80076a:	68 c4 2f 80 00       	push   $0x802fc4
  80076f:	68 82 00 00 00       	push   $0x82
  800774:	68 d4 2e 80 00       	push   $0x802ed4
  800779:	e8 ff 0a 00 00       	call   80127d <_panic>
	}
	int cnt = 0;
  80077e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	//[3] Test Re-allocation
	{
		/*CASE1: Re-allocate that's fit in the same location*/

		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800785:	e8 d9 1f 00 00       	call   802763 <sys_calculate_free_frames>
  80078a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80078d:	e8 54 20 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800792:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(512*kilo - kilo);
  800795:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800798:	89 d0                	mov    %edx,%eax
  80079a:	c1 e0 09             	shl    $0x9,%eax
  80079d:	29 d0                	sub    %edx,%eax
  80079f:	83 ec 0c             	sub    $0xc,%esp
  8007a2:	50                   	push   %eax
  8007a3:	e8 f8 1c 00 00       	call   8024a0 <malloc>
  8007a8:	83 c4 10             	add    $0x10,%esp
  8007ab:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8007ae:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8007b1:	89 c2                	mov    %eax,%edx
  8007b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b6:	05 00 00 00 80       	add    $0x80000000,%eax
  8007bb:	39 c2                	cmp    %eax,%edx
  8007bd:	74 17                	je     8007d6 <_main+0x79e>
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	68 a4 2e 80 00       	push   $0x802ea4
  8007c7:	68 8e 00 00 00       	push   $0x8e
  8007cc:	68 d4 2e 80 00       	push   $0x802ed4
  8007d1:	e8 a7 0a 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8007d6:	e8 88 1f 00 00       	call   802763 <sys_calculate_free_frames>
  8007db:	89 c2                	mov    %eax,%edx
  8007dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 ec 2e 80 00       	push   $0x802eec
  8007ec:	68 90 00 00 00       	push   $0x90
  8007f1:	68 d4 2e 80 00       	push   $0x802ed4
  8007f6:	e8 82 0a 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 128) panic("Extra or less pages are allocated in PageFile");
  8007fb:	e8 e6 1f 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800800:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800803:	3d 80 00 00 00       	cmp    $0x80,%eax
  800808:	74 17                	je     800821 <_main+0x7e9>
  80080a:	83 ec 04             	sub    $0x4,%esp
  80080d:	68 58 2f 80 00       	push   $0x802f58
  800812:	68 91 00 00 00       	push   $0x91
  800817:	68 d4 2e 80 00       	push   $0x802ed4
  80081c:	e8 5c 0a 00 00       	call   80127d <_panic>

		//Fill it with data
		int *intArr = (int*) ptr_allocations[9];
  800821:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800824:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int lastIndexOfInt1 = ((512)*kilo)/sizeof(int) - 1;
  800827:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80082a:	c1 e0 09             	shl    $0x9,%eax
  80082d:	c1 e8 02             	shr    $0x2,%eax
  800830:	48                   	dec    %eax
  800831:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		int i = 0;
  800834:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  80083b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800842:	eb 17                	jmp    80085b <_main+0x823>
		{
			intArr[i] = i ;
  800844:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800847:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80084e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800851:	01 c2                	add    %eax,%edx
  800853:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800856:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800858:	ff 45 f4             	incl   -0xc(%ebp)
  80085b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80085f:	7e e3                	jle    800844 <_main+0x80c>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800861:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800864:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800867:	eb 17                	jmp    800880 <_main+0x848>
		{
			intArr[i] = i ;
  800869:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80086c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800873:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800876:	01 c2                	add    %eax,%edx
  800878:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80087b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  80087d:	ff 4d f4             	decl   -0xc(%ebp)
  800880:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800883:	83 e8 64             	sub    $0x64,%eax
  800886:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800889:	7c de                	jl     800869 <_main+0x831>
		{
			intArr[i] = i ;
		}

		//Reallocate it [expanded in the same place]
		freeFrames = sys_calculate_free_frames() ;
  80088b:	e8 d3 1e 00 00       	call   802763 <sys_calculate_free_frames>
  800890:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800893:	e8 4e 1f 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800898:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 512*kilo + 256*kilo - kilo);
  80089b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80089e:	89 d0                	mov    %edx,%eax
  8008a0:	01 c0                	add    %eax,%eax
  8008a2:	01 d0                	add    %edx,%eax
  8008a4:	c1 e0 08             	shl    $0x8,%eax
  8008a7:	29 d0                	sub    %edx,%eax
  8008a9:	89 c2                	mov    %eax,%edx
  8008ab:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008ae:	83 ec 08             	sub    $0x8,%esp
  8008b1:	52                   	push   %edx
  8008b2:	50                   	push   %eax
  8008b3:	e8 22 1d 00 00       	call   8025da <realloc>
  8008b8:	83 c4 10             	add    $0x10,%esp
  8008bb:	89 45 a4             	mov    %eax,-0x5c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the re-allocated space... ");
  8008be:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008c1:	89 c2                	mov    %eax,%edx
  8008c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c6:	05 00 00 00 80       	add    $0x80000000,%eax
  8008cb:	39 c2                	cmp    %eax,%edx
  8008cd:	74 17                	je     8008e6 <_main+0x8ae>
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 10 30 80 00       	push   $0x803010
  8008d7:	68 ae 00 00 00       	push   $0xae
  8008dc:	68 d4 2e 80 00       	push   $0x802ed4
  8008e1:	e8 97 09 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  8008e6:	e8 78 1e 00 00       	call   802763 <sys_calculate_free_frames>
  8008eb:	89 c2                	mov    %eax,%edx
  8008ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008f0:	39 c2                	cmp    %eax,%edx
  8008f2:	74 17                	je     80090b <_main+0x8d3>
  8008f4:	83 ec 04             	sub    $0x4,%esp
  8008f7:	68 44 30 80 00       	push   $0x803044
  8008fc:	68 b0 00 00 00       	push   $0xb0
  800901:	68 d4 2e 80 00       	push   $0x802ed4
  800906:	e8 72 09 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 64) panic("Extra or less pages are re-allocated in PageFile");
  80090b:	e8 d6 1e 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800910:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800913:	83 f8 40             	cmp    $0x40,%eax
  800916:	74 17                	je     80092f <_main+0x8f7>
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 b4 30 80 00       	push   $0x8030b4
  800920:	68 b1 00 00 00       	push   $0xb1
  800925:	68 d4 2e 80 00       	push   $0x802ed4
  80092a:	e8 4e 09 00 00       	call   80127d <_panic>


		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;
  80092f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800932:	89 d0                	mov    %edx,%eax
  800934:	01 c0                	add    %eax,%eax
  800936:	01 d0                	add    %edx,%eax
  800938:	c1 e0 08             	shl    $0x8,%eax
  80093b:	c1 e8 02             	shr    $0x2,%eax
  80093e:	48                   	dec    %eax
  80093f:	89 45 d0             	mov    %eax,-0x30(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800942:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800945:	40                   	inc    %eax
  800946:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800949:	eb 17                	jmp    800962 <_main+0x92a>
		{
			intArr[i] = i;
  80094b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80094e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800955:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800958:	01 c2                	add    %eax,%edx
  80095a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80095d:	89 02                	mov    %eax,(%edx)
		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  80095f:	ff 45 f4             	incl   -0xc(%ebp)
  800962:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800965:	83 c0 65             	add    $0x65,%eax
  800968:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80096b:	7f de                	jg     80094b <_main+0x913>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80096d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800970:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800973:	eb 17                	jmp    80098c <_main+0x954>
		{
			intArr[i] = i;
  800975:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800978:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800982:	01 c2                	add    %eax,%edx
  800984:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800987:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800989:	ff 4d f4             	decl   -0xc(%ebp)
  80098c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80098f:	83 e8 64             	sub    $0x64,%eax
  800992:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800995:	7c de                	jl     800975 <_main+0x93d>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80099e:	eb 30                	jmp    8009d0 <_main+0x998>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009ad:	01 d0                	add    %edx,%eax
  8009af:	8b 00                	mov    (%eax),%eax
  8009b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009b4:	74 17                	je     8009cd <_main+0x995>
  8009b6:	83 ec 04             	sub    $0x4,%esp
  8009b9:	68 e8 30 80 00       	push   $0x8030e8
  8009be:	68 c6 00 00 00       	push   $0xc6
  8009c3:	68 d4 2e 80 00       	push   $0x802ed4
  8009c8:	e8 b0 08 00 00       	call   80127d <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  8009cd:	ff 45 f4             	incl   -0xc(%ebp)
  8009d0:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  8009d4:	7e ca                	jle    8009a0 <_main+0x968>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  8009d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8009dc:	eb 30                	jmp    800a0e <_main+0x9d6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009eb:	01 d0                	add    %edx,%eax
  8009ed:	8b 00                	mov    (%eax),%eax
  8009ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009f2:	74 17                	je     800a0b <_main+0x9d3>
  8009f4:	83 ec 04             	sub    $0x4,%esp
  8009f7:	68 e8 30 80 00       	push   $0x8030e8
  8009fc:	68 cc 00 00 00       	push   $0xcc
  800a01:	68 d4 2e 80 00       	push   $0x802ed4
  800a06:	e8 72 08 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800a0b:	ff 4d f4             	decl   -0xc(%ebp)
  800a0e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a11:	83 e8 64             	sub    $0x64,%eax
  800a14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a17:	7c c5                	jl     8009de <_main+0x9a6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a19:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a1c:	40                   	inc    %eax
  800a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a20:	eb 30                	jmp    800a52 <_main+0xa1a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a25:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a2c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a2f:	01 d0                	add    %edx,%eax
  800a31:	8b 00                	mov    (%eax),%eax
  800a33:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a36:	74 17                	je     800a4f <_main+0xa17>
  800a38:	83 ec 04             	sub    $0x4,%esp
  800a3b:	68 e8 30 80 00       	push   $0x8030e8
  800a40:	68 d2 00 00 00       	push   $0xd2
  800a45:	68 d4 2e 80 00       	push   $0x802ed4
  800a4a:	e8 2e 08 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a4f:	ff 45 f4             	incl   -0xc(%ebp)
  800a52:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a55:	83 c0 65             	add    $0x65,%eax
  800a58:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a5b:	7f c5                	jg     800a22 <_main+0x9ea>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a5d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a63:	eb 30                	jmp    800a95 <_main+0xa5d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	8b 00                	mov    (%eax),%eax
  800a76:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a79:	74 17                	je     800a92 <_main+0xa5a>
  800a7b:	83 ec 04             	sub    $0x4,%esp
  800a7e:	68 e8 30 80 00       	push   $0x8030e8
  800a83:	68 d8 00 00 00       	push   $0xd8
  800a88:	68 d4 2e 80 00       	push   $0x802ed4
  800a8d:	e8 eb 07 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a92:	ff 4d f4             	decl   -0xc(%ebp)
  800a95:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a98:	83 e8 64             	sub    $0x64,%eax
  800a9b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a9e:	7c c5                	jl     800a65 <_main+0xa2d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800aa0:	e8 be 1c 00 00       	call   802763 <sys_calculate_free_frames>
  800aa5:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800aa8:	e8 39 1d 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800aad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800ab0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800ab3:	83 ec 0c             	sub    $0xc,%esp
  800ab6:	50                   	push   %eax
  800ab7:	e8 72 1a 00 00       	call   80252e <free>
  800abc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 192) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 192) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800abf:	e8 22 1d 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800ac4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ac7:	29 c2                	sub    %eax,%edx
  800ac9:	89 d0                	mov    %edx,%eax
  800acb:	3d c0 00 00 00       	cmp    $0xc0,%eax
  800ad0:	74 17                	je     800ae9 <_main+0xab1>
  800ad2:	83 ec 04             	sub    $0x4,%esp
  800ad5:	68 20 31 80 00       	push   $0x803120
  800ada:	68 e0 00 00 00       	push   $0xe0
  800adf:	68 d4 2e 80 00       	push   $0x802ed4
  800ae4:	e8 94 07 00 00       	call   80127d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ae9:	e8 75 1c 00 00       	call   802763 <sys_calculate_free_frames>
  800aee:	89 c2                	mov    %eax,%edx
  800af0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800af3:	29 c2                	sub    %eax,%edx
  800af5:	89 d0                	mov    %edx,%eax
  800af7:	83 f8 05             	cmp    $0x5,%eax
  800afa:	74 17                	je     800b13 <_main+0xadb>
  800afc:	83 ec 04             	sub    $0x4,%esp
  800aff:	68 c4 2f 80 00       	push   $0x802fc4
  800b04:	68 e1 00 00 00       	push   $0xe1
  800b09:	68 d4 2e 80 00       	push   $0x802ed4
  800b0e:	e8 6a 07 00 00       	call   80127d <_panic>

		vcprintf("\b\b\b40%", NULL);
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	6a 00                	push   $0x0
  800b18:	68 74 31 80 00       	push   $0x803174
  800b1d:	e8 a4 09 00 00       	call   8014c6 <vcprintf>
  800b22:	83 c4 10             	add    $0x10,%esp

		/*CASE2: Re-allocate that's not fit in the same location*/

		//Allocate 1.5 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800b25:	e8 39 1c 00 00       	call   802763 <sys_calculate_free_frames>
  800b2a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b2d:	e8 b4 1c 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800b32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(1*Mega + 512*kilo - kilo);
  800b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b38:	c1 e0 09             	shl    $0x9,%eax
  800b3b:	89 c2                	mov    %eax,%edx
  800b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800b45:	83 ec 0c             	sub    $0xc,%esp
  800b48:	50                   	push   %eax
  800b49:	e8 52 19 00 00       	call   8024a0 <malloc>
  800b4e:	83 c4 10             	add    $0x10,%esp
  800b51:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800b54:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800b57:	89 c2                	mov    %eax,%edx
  800b59:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5c:	c1 e0 02             	shl    $0x2,%eax
  800b5f:	05 00 00 00 80       	add    $0x80000000,%eax
  800b64:	39 c2                	cmp    %eax,%edx
  800b66:	74 17                	je     800b7f <_main+0xb47>
  800b68:	83 ec 04             	sub    $0x4,%esp
  800b6b:	68 a4 2e 80 00       	push   $0x802ea4
  800b70:	68 eb 00 00 00       	push   $0xeb
  800b75:	68 d4 2e 80 00       	push   $0x802ed4
  800b7a:	e8 fe 06 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 384) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800b7f:	e8 df 1b 00 00       	call   802763 <sys_calculate_free_frames>
  800b84:	89 c2                	mov    %eax,%edx
  800b86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b89:	39 c2                	cmp    %eax,%edx
  800b8b:	74 17                	je     800ba4 <_main+0xb6c>
  800b8d:	83 ec 04             	sub    $0x4,%esp
  800b90:	68 ec 2e 80 00       	push   $0x802eec
  800b95:	68 ed 00 00 00       	push   $0xed
  800b9a:	68 d4 2e 80 00       	push   $0x802ed4
  800b9f:	e8 d9 06 00 00       	call   80127d <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 384) panic("Extra or less pages are allocated in PageFile");
  800ba4:	e8 3d 1c 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800ba9:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800bac:	3d 80 01 00 00       	cmp    $0x180,%eax
  800bb1:	74 17                	je     800bca <_main+0xb92>
  800bb3:	83 ec 04             	sub    $0x4,%esp
  800bb6:	68 58 2f 80 00       	push   $0x802f58
  800bbb:	68 ee 00 00 00       	push   $0xee
  800bc0:	68 d4 2e 80 00       	push   $0x802ed4
  800bc5:	e8 b3 06 00 00       	call   80127d <_panic>

		//Fill it with data
		intArr = (int*) ptr_allocations[9];
  800bca:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800bcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
  800bd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd3:	c1 e0 09             	shl    $0x9,%eax
  800bd6:	89 c2                	mov    %eax,%edx
  800bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bdb:	01 d0                	add    %edx,%eax
  800bdd:	c1 e8 02             	shr    $0x2,%eax
  800be0:	48                   	dec    %eax
  800be1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		i = 0;
  800be4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800bf2:	eb 17                	jmp    800c0b <_main+0xbd3>
		{
			intArr[i] = i ;
  800bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bf7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800bfe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c01:	01 c2                	add    %eax,%edx
  800c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c06:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800c08:	ff 45 f4             	incl   -0xc(%ebp)
  800c0b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800c0f:	7e e3                	jle    800bf4 <_main+0xbbc>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c11:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800c17:	eb 17                	jmp    800c30 <_main+0xbf8>
		{
			intArr[i] = i ;
  800c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c1c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c23:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c26:	01 c2                	add    %eax,%edx
  800c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c2b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c2d:	ff 4d f4             	decl   -0xc(%ebp)
  800c30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c33:	83 e8 64             	sub    $0x64,%eax
  800c36:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800c39:	7c de                	jl     800c19 <_main+0xbe1>
		{
			intArr[i] = i ;
		}

		//Reallocate it to 2.5 MB [should be moved to next hole]
		freeFrames = sys_calculate_free_frames() ;
  800c3b:	e8 23 1b 00 00       	call   802763 <sys_calculate_free_frames>
  800c40:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c43:	e8 9e 1b 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800c48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 1*Mega + 512*kilo + 1*Mega - kilo);
  800c4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c4e:	c1 e0 09             	shl    $0x9,%eax
  800c51:	89 c2                	mov    %eax,%edx
  800c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c56:	01 c2                	add    %eax,%edx
  800c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5b:	01 d0                	add    %edx,%eax
  800c5d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800c60:	89 c2                	mov    %eax,%edx
  800c62:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	52                   	push   %edx
  800c69:	50                   	push   %eax
  800c6a:	e8 6b 19 00 00       	call   8025da <realloc>
  800c6f:	83 c4 10             	add    $0x10,%esp
  800c72:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the re-allocated space... ");
  800c75:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c78:	89 c2                	mov    %eax,%edx
  800c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7d:	c1 e0 03             	shl    $0x3,%eax
  800c80:	05 00 00 00 80       	add    $0x80000000,%eax
  800c85:	39 c2                	cmp    %eax,%edx
  800c87:	74 17                	je     800ca0 <_main+0xc68>
  800c89:	83 ec 04             	sub    $0x4,%esp
  800c8c:	68 10 30 80 00       	push   $0x803010
  800c91:	68 07 01 00 00       	push   $0x107
  800c96:	68 d4 2e 80 00       	push   $0x802ed4
  800c9b:	e8 dd 05 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong re-allocation");

		//if((sys_calculate_free_frames() - freeFrames) != 3) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are re-allocated in PageFile");
  800ca0:	e8 41 1b 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800ca5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800ca8:	3d 00 01 00 00       	cmp    $0x100,%eax
  800cad:	74 17                	je     800cc6 <_main+0xc8e>
  800caf:	83 ec 04             	sub    $0x4,%esp
  800cb2:	68 b4 30 80 00       	push   $0x8030b4
  800cb7:	68 0b 01 00 00       	push   $0x10b
  800cbc:	68 d4 2e 80 00       	push   $0x802ed4
  800cc1:	e8 b7 05 00 00       	call   80127d <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (2*Mega + 512*kilo)/sizeof(int) - 1;
  800cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc9:	c1 e0 08             	shl    $0x8,%eax
  800ccc:	89 c2                	mov    %eax,%edx
  800cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd1:	01 d0                	add    %edx,%eax
  800cd3:	01 c0                	add    %eax,%eax
  800cd5:	c1 e8 02             	shr    $0x2,%eax
  800cd8:	48                   	dec    %eax
  800cd9:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[9];
  800cdc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800cdf:	89 45 d8             	mov    %eax,-0x28(%ebp)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800ce2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ce5:	40                   	inc    %eax
  800ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ce9:	eb 17                	jmp    800d02 <_main+0xcca>
		{
			intArr[i] = i;
  800ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cf5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800cf8:	01 c2                	add    %eax,%edx
  800cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cfd:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800cff:	ff 45 f4             	incl   -0xc(%ebp)
  800d02:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d05:	83 c0 65             	add    $0x65,%eax
  800d08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d0b:	7f de                	jg     800ceb <_main+0xcb3>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d0d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d13:	eb 17                	jmp    800d2c <_main+0xcf4>
		{
			intArr[i] = i;
  800d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d18:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d22:	01 c2                	add    %eax,%edx
  800d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d27:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d29:	ff 4d f4             	decl   -0xc(%ebp)
  800d2c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d2f:	83 e8 64             	sub    $0x64,%eax
  800d32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d35:	7c de                	jl     800d15 <_main+0xcdd>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800d3e:	eb 30                	jmp    800d70 <_main+0xd38>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d4d:	01 d0                	add    %edx,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d54:	74 17                	je     800d6d <_main+0xd35>
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	68 e8 30 80 00       	push   $0x8030e8
  800d5e:	68 22 01 00 00       	push   $0x122
  800d63:	68 d4 2e 80 00       	push   $0x802ed4
  800d68:	e8 10 05 00 00       	call   80127d <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d6d:	ff 45 f4             	incl   -0xc(%ebp)
  800d70:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800d74:	7e ca                	jle    800d40 <_main+0xd08>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d76:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7c:	eb 30                	jmp    800dae <_main+0xd76>
		{
			if (intArr[i] != i)
  800d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d81:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d88:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d8b:	01 d0                	add    %edx,%eax
  800d8d:	8b 00                	mov    (%eax),%eax
  800d8f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d92:	74 17                	je     800dab <_main+0xd73>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800d94:	83 ec 04             	sub    $0x4,%esp
  800d97:	68 e8 30 80 00       	push   $0x8030e8
  800d9c:	68 2a 01 00 00       	push   $0x12a
  800da1:	68 d4 2e 80 00       	push   $0x802ed4
  800da6:	e8 d2 04 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800dab:	ff 4d f4             	decl   -0xc(%ebp)
  800dae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800db1:	83 e8 64             	sub    $0x64,%eax
  800db4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800db7:	7c c5                	jl     800d7e <_main+0xd46>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800db9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dbc:	40                   	inc    %eax
  800dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dc0:	eb 30                	jmp    800df2 <_main+0xdba>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dcc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800dcf:	01 d0                	add    %edx,%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dd6:	74 17                	je     800def <_main+0xdb7>
  800dd8:	83 ec 04             	sub    $0x4,%esp
  800ddb:	68 e8 30 80 00       	push   $0x8030e8
  800de0:	68 31 01 00 00       	push   $0x131
  800de5:	68 d4 2e 80 00       	push   $0x802ed4
  800dea:	e8 8e 04 00 00       	call   80127d <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800def:	ff 45 f4             	incl   -0xc(%ebp)
  800df2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800df5:	83 c0 65             	add    $0x65,%eax
  800df8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dfb:	7f c5                	jg     800dc2 <_main+0xd8a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800dfd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e03:	eb 30                	jmp    800e35 <_main+0xdfd>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800e0f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800e12:	01 d0                	add    %edx,%eax
  800e14:	8b 00                	mov    (%eax),%eax
  800e16:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e19:	74 17                	je     800e32 <_main+0xdfa>
  800e1b:	83 ec 04             	sub    $0x4,%esp
  800e1e:	68 e8 30 80 00       	push   $0x8030e8
  800e23:	68 37 01 00 00       	push   $0x137
  800e28:	68 d4 2e 80 00       	push   $0x802ed4
  800e2d:	e8 4b 04 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800e32:	ff 4d f4             	decl   -0xc(%ebp)
  800e35:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e38:	83 e8 64             	sub    $0x64,%eax
  800e3b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e3e:	7c c5                	jl     800e05 <_main+0xdcd>
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}


		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800e40:	e8 1e 19 00 00       	call   802763 <sys_calculate_free_frames>
  800e45:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e48:	e8 99 19 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800e4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800e50:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800e53:	83 ec 0c             	sub    $0xc,%esp
  800e56:	50                   	push   %eax
  800e57:	e8 d2 16 00 00       	call   80252e <free>
  800e5c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 640) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 640) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800e5f:	e8 82 19 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800e64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800e67:	29 c2                	sub    %eax,%edx
  800e69:	89 d0                	mov    %edx,%eax
  800e6b:	3d 80 02 00 00       	cmp    $0x280,%eax
  800e70:	74 17                	je     800e89 <_main+0xe51>
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	68 20 31 80 00       	push   $0x803120
  800e7a:	68 40 01 00 00       	push   $0x140
  800e7f:	68 d4 2e 80 00       	push   $0x802ed4
  800e84:	e8 f4 03 00 00       	call   80127d <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b70%", NULL);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	6a 00                	push   $0x0
  800e8e:	68 7b 31 80 00       	push   $0x80317b
  800e93:	e8 2e 06 00 00       	call   8014c6 <vcprintf>
  800e98:	83 c4 10             	add    $0x10,%esp

		/*CASE3: Re-allocate that's not fit in the same location*/

		//Fill it with data
		intArr = (int*) ptr_allocations[0];
  800e9b:	8b 45 80             	mov    -0x80(%ebp),%eax
  800e9e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;
  800ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea4:	c1 e8 02             	shr    $0x2,%eax
  800ea7:	48                   	dec    %eax
  800ea8:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		i = 0;
  800eab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800eb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800eb9:	eb 17                	jmp    800ed2 <_main+0xe9a>
		{
			intArr[i] = i ;
  800ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ec5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800ec8:	01 c2                	add    %eax,%edx
  800eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ecd:	89 02                	mov    %eax,(%edx)

		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800ecf:	ff 45 f4             	incl   -0xc(%ebp)
  800ed2:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800ed6:	7e e3                	jle    800ebb <_main+0xe83>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ed8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800edb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ede:	eb 17                	jmp    800ef7 <_main+0xebf>
		{
			intArr[i] = i ;
  800ee0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800eea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800eed:	01 c2                	add    %eax,%edx
  800eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ef2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ef4:	ff 4d f4             	decl   -0xc(%ebp)
  800ef7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800efa:	83 e8 64             	sub    $0x64,%eax
  800efd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f00:	7c de                	jl     800ee0 <_main+0xea8>
			intArr[i] = i ;
		}


		//Reallocate it to 4 MB [should be moved to last hole]
		freeFrames = sys_calculate_free_frames() ;
  800f02:	e8 5c 18 00 00       	call   802763 <sys_calculate_free_frames>
  800f07:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f0a:	e8 d7 18 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800f0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 1*Mega + 3*Mega - kilo);
  800f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f15:	c1 e0 02             	shl    $0x2,%eax
  800f18:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800f1b:	89 c2                	mov    %eax,%edx
  800f1d:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	52                   	push   %edx
  800f24:	50                   	push   %eax
  800f25:	e8 b0 16 00 00       	call   8025da <realloc>
  800f2a:	83 c4 10             	add    $0x10,%esp
  800f2d:	89 45 80             	mov    %eax,-0x80(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the re-allocated space... ");
  800f30:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f33:	89 c1                	mov    %eax,%ecx
  800f35:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f38:	89 d0                	mov    %edx,%eax
  800f3a:	01 c0                	add    %eax,%eax
  800f3c:	01 d0                	add    %edx,%eax
  800f3e:	01 c0                	add    %eax,%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	01 c0                	add    %eax,%eax
  800f44:	05 00 00 00 80       	add    $0x80000000,%eax
  800f49:	39 c1                	cmp    %eax,%ecx
  800f4b:	74 17                	je     800f64 <_main+0xf2c>
  800f4d:	83 ec 04             	sub    $0x4,%esp
  800f50:	68 10 30 80 00       	push   $0x803010
  800f55:	68 60 01 00 00       	push   $0x160
  800f5a:	68 d4 2e 80 00       	push   $0x802ed4
  800f5f:	e8 19 03 00 00       	call   80127d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong re-allocation");
		//if((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are re-allocated in PageFile");
  800f64:	e8 7d 18 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  800f69:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800f6c:	3d 00 03 00 00       	cmp    $0x300,%eax
  800f71:	74 17                	je     800f8a <_main+0xf52>
  800f73:	83 ec 04             	sub    $0x4,%esp
  800f76:	68 b4 30 80 00       	push   $0x8030b4
  800f7b:	68 63 01 00 00       	push   $0x163
  800f80:	68 d4 2e 80 00       	push   $0x802ed4
  800f85:	e8 f3 02 00 00       	call   80127d <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
  800f8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f8d:	c1 e0 02             	shl    $0x2,%eax
  800f90:	c1 e8 02             	shr    $0x2,%eax
  800f93:	48                   	dec    %eax
  800f94:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[0];
  800f97:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f9a:	89 45 d8             	mov    %eax,-0x28(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800f9d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fa0:	40                   	inc    %eax
  800fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa4:	eb 17                	jmp    800fbd <_main+0xf85>
		{
			intArr[i] = i;
  800fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fb3:	01 c2                	add    %eax,%edx
  800fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb8:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
		intArr = (int*) ptr_allocations[0];

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800fba:	ff 45 f4             	incl   -0xc(%ebp)
  800fbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fc0:	83 c0 65             	add    $0x65,%eax
  800fc3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fc6:	7f de                	jg     800fa6 <_main+0xf6e>
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fc8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fce:	eb 17                	jmp    800fe7 <_main+0xfaf>
		{
			intArr[i] = i;
  800fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fda:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fdd:	01 c2                	add    %eax,%edx
  800fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fe4:	ff 4d f4             	decl   -0xc(%ebp)
  800fe7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fea:	83 e8 64             	sub    $0x64,%eax
  800fed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff0:	7c de                	jl     800fd0 <_main+0xf98>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800ff2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800ff9:	eb 30                	jmp    80102b <_main+0xff3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801005:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	8b 00                	mov    (%eax),%eax
  80100c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80100f:	74 17                	je     801028 <_main+0xff0>
  801011:	83 ec 04             	sub    $0x4,%esp
  801014:	68 e8 30 80 00       	push   $0x8030e8
  801019:	68 79 01 00 00       	push   $0x179
  80101e:	68 d4 2e 80 00       	push   $0x802ed4
  801023:	e8 55 02 00 00       	call   80127d <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  801028:	ff 45 f4             	incl   -0xc(%ebp)
  80102b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80102f:	7e ca                	jle    800ffb <_main+0xfc3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801031:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801034:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801037:	eb 30                	jmp    801069 <_main+0x1031>
		{
			if (intArr[i] != i)
  801039:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80103c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801043:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801046:	01 d0                	add    %edx,%eax
  801048:	8b 00                	mov    (%eax),%eax
  80104a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80104d:	74 17                	je     801066 <_main+0x102e>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  80104f:	83 ec 04             	sub    $0x4,%esp
  801052:	68 e8 30 80 00       	push   $0x8030e8
  801057:	68 81 01 00 00       	push   $0x181
  80105c:	68 d4 2e 80 00       	push   $0x802ed4
  801061:	e8 17 02 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801066:	ff 4d f4             	decl   -0xc(%ebp)
  801069:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80106c:	83 e8 64             	sub    $0x64,%eax
  80106f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801072:	7c c5                	jl     801039 <_main+0x1001>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  801074:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801077:	40                   	inc    %eax
  801078:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80107b:	eb 30                	jmp    8010ad <_main+0x1075>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80107d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801080:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	8b 00                	mov    (%eax),%eax
  80108e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801091:	74 17                	je     8010aa <_main+0x1072>
  801093:	83 ec 04             	sub    $0x4,%esp
  801096:	68 e8 30 80 00       	push   $0x8030e8
  80109b:	68 88 01 00 00       	push   $0x188
  8010a0:	68 d4 2e 80 00       	push   $0x802ed4
  8010a5:	e8 d3 01 00 00       	call   80127d <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  8010aa:	ff 45 f4             	incl   -0xc(%ebp)
  8010ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8010b0:	83 c0 65             	add    $0x65,%eax
  8010b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010b6:	7f c5                	jg     80107d <_main+0x1045>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010be:	eb 30                	jmp    8010f0 <_main+0x10b8>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8010c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ca:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8010cd:	01 d0                	add    %edx,%eax
  8010cf:	8b 00                	mov    (%eax),%eax
  8010d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010d4:	74 17                	je     8010ed <_main+0x10b5>
  8010d6:	83 ec 04             	sub    $0x4,%esp
  8010d9:	68 e8 30 80 00       	push   $0x8030e8
  8010de:	68 8e 01 00 00       	push   $0x18e
  8010e3:	68 d4 2e 80 00       	push   $0x802ed4
  8010e8:	e8 90 01 00 00       	call   80127d <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010ed:	ff 4d f4             	decl   -0xc(%ebp)
  8010f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010f3:	83 e8 64             	sub    $0x64,%eax
  8010f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010f9:	7c c5                	jl     8010c0 <_main+0x1088>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  8010fb:	e8 63 16 00 00       	call   802763 <sys_calculate_free_frames>
  801100:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801103:	e8 de 16 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  801108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[0]);
  80110b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80110e:	83 ec 0c             	sub    $0xc,%esp
  801111:	50                   	push   %eax
  801112:	e8 17 14 00 00       	call   80252e <free>
  801117:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1024+1) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1024) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  80111a:	e8 c7 16 00 00       	call   8027e6 <sys_pf_calculate_allocated_pages>
  80111f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801122:	29 c2                	sub    %eax,%edx
  801124:	89 d0                	mov    %edx,%eax
  801126:	3d 00 04 00 00       	cmp    $0x400,%eax
  80112b:	74 17                	je     801144 <_main+0x110c>
  80112d:	83 ec 04             	sub    $0x4,%esp
  801130:	68 20 31 80 00       	push   $0x803120
  801135:	68 96 01 00 00       	push   $0x196
  80113a:	68 d4 2e 80 00       	push   $0x802ed4
  80113f:	e8 39 01 00 00       	call   80127d <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 2) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b100%\n", NULL);
  801144:	83 ec 08             	sub    $0x8,%esp
  801147:	6a 00                	push   $0x0
  801149:	68 82 31 80 00       	push   $0x803182
  80114e:	e8 73 03 00 00       	call   8014c6 <vcprintf>
  801153:	83 c4 10             	add    $0x10,%esp
	}

	cprintf("Congratulations!! test realloc [1] completed successfully.\n");
  801156:	83 ec 0c             	sub    $0xc,%esp
  801159:	68 8c 31 80 00       	push   $0x80318c
  80115e:	e8 ce 03 00 00       	call   801531 <cprintf>
  801163:	83 c4 10             	add    $0x10,%esp

	return;
  801166:	90                   	nop
}
  801167:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80116a:	5b                   	pop    %ebx
  80116b:	5f                   	pop    %edi
  80116c:	5d                   	pop    %ebp
  80116d:	c3                   	ret    

0080116e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
  801171:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801174:	e8 1f 15 00 00       	call   802698 <sys_getenvindex>
  801179:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80117c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80117f:	89 d0                	mov    %edx,%eax
  801181:	c1 e0 02             	shl    $0x2,%eax
  801184:	01 d0                	add    %edx,%eax
  801186:	01 c0                	add    %eax,%eax
  801188:	01 d0                	add    %edx,%eax
  80118a:	01 c0                	add    %eax,%eax
  80118c:	01 d0                	add    %edx,%eax
  80118e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801195:	01 d0                	add    %edx,%eax
  801197:	c1 e0 02             	shl    $0x2,%eax
  80119a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80119f:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8011a4:	a1 20 40 80 00       	mov    0x804020,%eax
  8011a9:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8011af:	84 c0                	test   %al,%al
  8011b1:	74 0f                	je     8011c2 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8011b3:	a1 20 40 80 00       	mov    0x804020,%eax
  8011b8:	05 f4 02 00 00       	add    $0x2f4,%eax
  8011bd:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8011c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c6:	7e 0a                	jle    8011d2 <libmain+0x64>
		binaryname = argv[0];
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	8b 00                	mov    (%eax),%eax
  8011cd:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8011d2:	83 ec 08             	sub    $0x8,%esp
  8011d5:	ff 75 0c             	pushl  0xc(%ebp)
  8011d8:	ff 75 08             	pushl  0x8(%ebp)
  8011db:	e8 58 ee ff ff       	call   800038 <_main>
  8011e0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8011e3:	e8 4b 16 00 00       	call   802833 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8011e8:	83 ec 0c             	sub    $0xc,%esp
  8011eb:	68 e0 31 80 00       	push   $0x8031e0
  8011f0:	e8 3c 03 00 00       	call   801531 <cprintf>
  8011f5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8011f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8011fd:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801203:	a1 20 40 80 00       	mov    0x804020,%eax
  801208:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80120e:	83 ec 04             	sub    $0x4,%esp
  801211:	52                   	push   %edx
  801212:	50                   	push   %eax
  801213:	68 08 32 80 00       	push   $0x803208
  801218:	e8 14 03 00 00       	call   801531 <cprintf>
  80121d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801220:	a1 20 40 80 00       	mov    0x804020,%eax
  801225:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80122b:	83 ec 08             	sub    $0x8,%esp
  80122e:	50                   	push   %eax
  80122f:	68 2d 32 80 00       	push   $0x80322d
  801234:	e8 f8 02 00 00       	call   801531 <cprintf>
  801239:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80123c:	83 ec 0c             	sub    $0xc,%esp
  80123f:	68 e0 31 80 00       	push   $0x8031e0
  801244:	e8 e8 02 00 00       	call   801531 <cprintf>
  801249:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80124c:	e8 fc 15 00 00       	call   80284d <sys_enable_interrupt>

	// exit gracefully
	exit();
  801251:	e8 19 00 00 00       	call   80126f <exit>
}
  801256:	90                   	nop
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80125f:	83 ec 0c             	sub    $0xc,%esp
  801262:	6a 00                	push   $0x0
  801264:	e8 fb 13 00 00       	call   802664 <sys_env_destroy>
  801269:	83 c4 10             	add    $0x10,%esp
}
  80126c:	90                   	nop
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <exit>:

void
exit(void)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
  801272:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801275:	e8 50 14 00 00       	call   8026ca <sys_env_exit>
}
  80127a:	90                   	nop
  80127b:	c9                   	leave  
  80127c:	c3                   	ret    

0080127d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80127d:	55                   	push   %ebp
  80127e:	89 e5                	mov    %esp,%ebp
  801280:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801283:	8d 45 10             	lea    0x10(%ebp),%eax
  801286:	83 c0 04             	add    $0x4,%eax
  801289:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80128c:	a1 48 40 88 00       	mov    0x884048,%eax
  801291:	85 c0                	test   %eax,%eax
  801293:	74 16                	je     8012ab <_panic+0x2e>
		cprintf("%s: ", argv0);
  801295:	a1 48 40 88 00       	mov    0x884048,%eax
  80129a:	83 ec 08             	sub    $0x8,%esp
  80129d:	50                   	push   %eax
  80129e:	68 44 32 80 00       	push   $0x803244
  8012a3:	e8 89 02 00 00       	call   801531 <cprintf>
  8012a8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8012ab:	a1 00 40 80 00       	mov    0x804000,%eax
  8012b0:	ff 75 0c             	pushl  0xc(%ebp)
  8012b3:	ff 75 08             	pushl  0x8(%ebp)
  8012b6:	50                   	push   %eax
  8012b7:	68 49 32 80 00       	push   $0x803249
  8012bc:	e8 70 02 00 00       	call   801531 <cprintf>
  8012c1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8012c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c7:	83 ec 08             	sub    $0x8,%esp
  8012ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8012cd:	50                   	push   %eax
  8012ce:	e8 f3 01 00 00       	call   8014c6 <vcprintf>
  8012d3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8012d6:	83 ec 08             	sub    $0x8,%esp
  8012d9:	6a 00                	push   $0x0
  8012db:	68 65 32 80 00       	push   $0x803265
  8012e0:	e8 e1 01 00 00       	call   8014c6 <vcprintf>
  8012e5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8012e8:	e8 82 ff ff ff       	call   80126f <exit>

	// should not return here
	while (1) ;
  8012ed:	eb fe                	jmp    8012ed <_panic+0x70>

008012ef <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
  8012f2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8012f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8012fa:	8b 50 74             	mov    0x74(%eax),%edx
  8012fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801300:	39 c2                	cmp    %eax,%edx
  801302:	74 14                	je     801318 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801304:	83 ec 04             	sub    $0x4,%esp
  801307:	68 68 32 80 00       	push   $0x803268
  80130c:	6a 26                	push   $0x26
  80130e:	68 b4 32 80 00       	push   $0x8032b4
  801313:	e8 65 ff ff ff       	call   80127d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801318:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80131f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801326:	e9 c2 00 00 00       	jmp    8013ed <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80132b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80132e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	01 d0                	add    %edx,%eax
  80133a:	8b 00                	mov    (%eax),%eax
  80133c:	85 c0                	test   %eax,%eax
  80133e:	75 08                	jne    801348 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801340:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801343:	e9 a2 00 00 00       	jmp    8013ea <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801348:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80134f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801356:	eb 69                	jmp    8013c1 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801358:	a1 20 40 80 00       	mov    0x804020,%eax
  80135d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801363:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801366:	89 d0                	mov    %edx,%eax
  801368:	01 c0                	add    %eax,%eax
  80136a:	01 d0                	add    %edx,%eax
  80136c:	c1 e0 02             	shl    $0x2,%eax
  80136f:	01 c8                	add    %ecx,%eax
  801371:	8a 40 04             	mov    0x4(%eax),%al
  801374:	84 c0                	test   %al,%al
  801376:	75 46                	jne    8013be <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801378:	a1 20 40 80 00       	mov    0x804020,%eax
  80137d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801383:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801386:	89 d0                	mov    %edx,%eax
  801388:	01 c0                	add    %eax,%eax
  80138a:	01 d0                	add    %edx,%eax
  80138c:	c1 e0 02             	shl    $0x2,%eax
  80138f:	01 c8                	add    %ecx,%eax
  801391:	8b 00                	mov    (%eax),%eax
  801393:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801396:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801399:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80139e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8013a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	01 c8                	add    %ecx,%eax
  8013af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8013b1:	39 c2                	cmp    %eax,%edx
  8013b3:	75 09                	jne    8013be <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8013b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8013bc:	eb 12                	jmp    8013d0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8013be:	ff 45 e8             	incl   -0x18(%ebp)
  8013c1:	a1 20 40 80 00       	mov    0x804020,%eax
  8013c6:	8b 50 74             	mov    0x74(%eax),%edx
  8013c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013cc:	39 c2                	cmp    %eax,%edx
  8013ce:	77 88                	ja     801358 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8013d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013d4:	75 14                	jne    8013ea <CheckWSWithoutLastIndex+0xfb>
			panic(
  8013d6:	83 ec 04             	sub    $0x4,%esp
  8013d9:	68 c0 32 80 00       	push   $0x8032c0
  8013de:	6a 3a                	push   $0x3a
  8013e0:	68 b4 32 80 00       	push   $0x8032b4
  8013e5:	e8 93 fe ff ff       	call   80127d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8013ea:	ff 45 f0             	incl   -0x10(%ebp)
  8013ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8013f3:	0f 8c 32 ff ff ff    	jl     80132b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8013f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801400:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801407:	eb 26                	jmp    80142f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801409:	a1 20 40 80 00       	mov    0x804020,%eax
  80140e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801414:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801417:	89 d0                	mov    %edx,%eax
  801419:	01 c0                	add    %eax,%eax
  80141b:	01 d0                	add    %edx,%eax
  80141d:	c1 e0 02             	shl    $0x2,%eax
  801420:	01 c8                	add    %ecx,%eax
  801422:	8a 40 04             	mov    0x4(%eax),%al
  801425:	3c 01                	cmp    $0x1,%al
  801427:	75 03                	jne    80142c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801429:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80142c:	ff 45 e0             	incl   -0x20(%ebp)
  80142f:	a1 20 40 80 00       	mov    0x804020,%eax
  801434:	8b 50 74             	mov    0x74(%eax),%edx
  801437:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80143a:	39 c2                	cmp    %eax,%edx
  80143c:	77 cb                	ja     801409 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80143e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801441:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801444:	74 14                	je     80145a <CheckWSWithoutLastIndex+0x16b>
		panic(
  801446:	83 ec 04             	sub    $0x4,%esp
  801449:	68 14 33 80 00       	push   $0x803314
  80144e:	6a 44                	push   $0x44
  801450:	68 b4 32 80 00       	push   $0x8032b4
  801455:	e8 23 fe ff ff       	call   80127d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80145a:	90                   	nop
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
  801460:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801463:	8b 45 0c             	mov    0xc(%ebp),%eax
  801466:	8b 00                	mov    (%eax),%eax
  801468:	8d 48 01             	lea    0x1(%eax),%ecx
  80146b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146e:	89 0a                	mov    %ecx,(%edx)
  801470:	8b 55 08             	mov    0x8(%ebp),%edx
  801473:	88 d1                	mov    %dl,%cl
  801475:	8b 55 0c             	mov    0xc(%ebp),%edx
  801478:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80147c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147f:	8b 00                	mov    (%eax),%eax
  801481:	3d ff 00 00 00       	cmp    $0xff,%eax
  801486:	75 2c                	jne    8014b4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801488:	a0 24 40 80 00       	mov    0x804024,%al
  80148d:	0f b6 c0             	movzbl %al,%eax
  801490:	8b 55 0c             	mov    0xc(%ebp),%edx
  801493:	8b 12                	mov    (%edx),%edx
  801495:	89 d1                	mov    %edx,%ecx
  801497:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149a:	83 c2 08             	add    $0x8,%edx
  80149d:	83 ec 04             	sub    $0x4,%esp
  8014a0:	50                   	push   %eax
  8014a1:	51                   	push   %ecx
  8014a2:	52                   	push   %edx
  8014a3:	e8 7a 11 00 00       	call   802622 <sys_cputs>
  8014a8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	8b 40 04             	mov    0x4(%eax),%eax
  8014ba:	8d 50 01             	lea    0x1(%eax),%edx
  8014bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8014c3:	90                   	nop
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
  8014c9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8014cf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8014d6:	00 00 00 
	b.cnt = 0;
  8014d9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8014e0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8014e3:	ff 75 0c             	pushl  0xc(%ebp)
  8014e6:	ff 75 08             	pushl  0x8(%ebp)
  8014e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8014ef:	50                   	push   %eax
  8014f0:	68 5d 14 80 00       	push   $0x80145d
  8014f5:	e8 11 02 00 00       	call   80170b <vprintfmt>
  8014fa:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8014fd:	a0 24 40 80 00       	mov    0x804024,%al
  801502:	0f b6 c0             	movzbl %al,%eax
  801505:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80150b:	83 ec 04             	sub    $0x4,%esp
  80150e:	50                   	push   %eax
  80150f:	52                   	push   %edx
  801510:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801516:	83 c0 08             	add    $0x8,%eax
  801519:	50                   	push   %eax
  80151a:	e8 03 11 00 00       	call   802622 <sys_cputs>
  80151f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801522:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801529:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <cprintf>:

int cprintf(const char *fmt, ...) {
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
  801534:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801537:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  80153e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801541:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	83 ec 08             	sub    $0x8,%esp
  80154a:	ff 75 f4             	pushl  -0xc(%ebp)
  80154d:	50                   	push   %eax
  80154e:	e8 73 ff ff ff       	call   8014c6 <vcprintf>
  801553:	83 c4 10             	add    $0x10,%esp
  801556:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801559:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
  801561:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801564:	e8 ca 12 00 00       	call   802833 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801569:	8d 45 0c             	lea    0xc(%ebp),%eax
  80156c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
  801572:	83 ec 08             	sub    $0x8,%esp
  801575:	ff 75 f4             	pushl  -0xc(%ebp)
  801578:	50                   	push   %eax
  801579:	e8 48 ff ff ff       	call   8014c6 <vcprintf>
  80157e:	83 c4 10             	add    $0x10,%esp
  801581:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801584:	e8 c4 12 00 00       	call   80284d <sys_enable_interrupt>
	return cnt;
  801589:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
  801591:	53                   	push   %ebx
  801592:	83 ec 14             	sub    $0x14,%esp
  801595:	8b 45 10             	mov    0x10(%ebp),%eax
  801598:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80159b:	8b 45 14             	mov    0x14(%ebp),%eax
  80159e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8015a1:	8b 45 18             	mov    0x18(%ebp),%eax
  8015a4:	ba 00 00 00 00       	mov    $0x0,%edx
  8015a9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8015ac:	77 55                	ja     801603 <printnum+0x75>
  8015ae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8015b1:	72 05                	jb     8015b8 <printnum+0x2a>
  8015b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015b6:	77 4b                	ja     801603 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8015b8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8015bb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8015be:	8b 45 18             	mov    0x18(%ebp),%eax
  8015c1:	ba 00 00 00 00       	mov    $0x0,%edx
  8015c6:	52                   	push   %edx
  8015c7:	50                   	push   %eax
  8015c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8015cb:	ff 75 f0             	pushl  -0x10(%ebp)
  8015ce:	e8 41 16 00 00       	call   802c14 <__udivdi3>
  8015d3:	83 c4 10             	add    $0x10,%esp
  8015d6:	83 ec 04             	sub    $0x4,%esp
  8015d9:	ff 75 20             	pushl  0x20(%ebp)
  8015dc:	53                   	push   %ebx
  8015dd:	ff 75 18             	pushl  0x18(%ebp)
  8015e0:	52                   	push   %edx
  8015e1:	50                   	push   %eax
  8015e2:	ff 75 0c             	pushl  0xc(%ebp)
  8015e5:	ff 75 08             	pushl  0x8(%ebp)
  8015e8:	e8 a1 ff ff ff       	call   80158e <printnum>
  8015ed:	83 c4 20             	add    $0x20,%esp
  8015f0:	eb 1a                	jmp    80160c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8015f2:	83 ec 08             	sub    $0x8,%esp
  8015f5:	ff 75 0c             	pushl  0xc(%ebp)
  8015f8:	ff 75 20             	pushl  0x20(%ebp)
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	ff d0                	call   *%eax
  801600:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801603:	ff 4d 1c             	decl   0x1c(%ebp)
  801606:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80160a:	7f e6                	jg     8015f2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80160c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80160f:	bb 00 00 00 00       	mov    $0x0,%ebx
  801614:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801617:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80161a:	53                   	push   %ebx
  80161b:	51                   	push   %ecx
  80161c:	52                   	push   %edx
  80161d:	50                   	push   %eax
  80161e:	e8 01 17 00 00       	call   802d24 <__umoddi3>
  801623:	83 c4 10             	add    $0x10,%esp
  801626:	05 74 35 80 00       	add    $0x803574,%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	0f be c0             	movsbl %al,%eax
  801630:	83 ec 08             	sub    $0x8,%esp
  801633:	ff 75 0c             	pushl  0xc(%ebp)
  801636:	50                   	push   %eax
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	ff d0                	call   *%eax
  80163c:	83 c4 10             	add    $0x10,%esp
}
  80163f:	90                   	nop
  801640:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801648:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80164c:	7e 1c                	jle    80166a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8b 00                	mov    (%eax),%eax
  801653:	8d 50 08             	lea    0x8(%eax),%edx
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	89 10                	mov    %edx,(%eax)
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8b 00                	mov    (%eax),%eax
  801660:	83 e8 08             	sub    $0x8,%eax
  801663:	8b 50 04             	mov    0x4(%eax),%edx
  801666:	8b 00                	mov    (%eax),%eax
  801668:	eb 40                	jmp    8016aa <getuint+0x65>
	else if (lflag)
  80166a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80166e:	74 1e                	je     80168e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8b 00                	mov    (%eax),%eax
  801675:	8d 50 04             	lea    0x4(%eax),%edx
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	89 10                	mov    %edx,(%eax)
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	8b 00                	mov    (%eax),%eax
  801682:	83 e8 04             	sub    $0x4,%eax
  801685:	8b 00                	mov    (%eax),%eax
  801687:	ba 00 00 00 00       	mov    $0x0,%edx
  80168c:	eb 1c                	jmp    8016aa <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8b 00                	mov    (%eax),%eax
  801693:	8d 50 04             	lea    0x4(%eax),%edx
  801696:	8b 45 08             	mov    0x8(%ebp),%eax
  801699:	89 10                	mov    %edx,(%eax)
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	8b 00                	mov    (%eax),%eax
  8016a0:	83 e8 04             	sub    $0x4,%eax
  8016a3:	8b 00                	mov    (%eax),%eax
  8016a5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8016aa:	5d                   	pop    %ebp
  8016ab:	c3                   	ret    

008016ac <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8016af:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8016b3:	7e 1c                	jle    8016d1 <getint+0x25>
		return va_arg(*ap, long long);
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8b 00                	mov    (%eax),%eax
  8016ba:	8d 50 08             	lea    0x8(%eax),%edx
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	89 10                	mov    %edx,(%eax)
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	8b 00                	mov    (%eax),%eax
  8016c7:	83 e8 08             	sub    $0x8,%eax
  8016ca:	8b 50 04             	mov    0x4(%eax),%edx
  8016cd:	8b 00                	mov    (%eax),%eax
  8016cf:	eb 38                	jmp    801709 <getint+0x5d>
	else if (lflag)
  8016d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016d5:	74 1a                	je     8016f1 <getint+0x45>
		return va_arg(*ap, long);
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8b 00                	mov    (%eax),%eax
  8016dc:	8d 50 04             	lea    0x4(%eax),%edx
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	89 10                	mov    %edx,(%eax)
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	83 e8 04             	sub    $0x4,%eax
  8016ec:	8b 00                	mov    (%eax),%eax
  8016ee:	99                   	cltd   
  8016ef:	eb 18                	jmp    801709 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8b 00                	mov    (%eax),%eax
  8016f6:	8d 50 04             	lea    0x4(%eax),%edx
  8016f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fc:	89 10                	mov    %edx,(%eax)
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8b 00                	mov    (%eax),%eax
  801703:	83 e8 04             	sub    $0x4,%eax
  801706:	8b 00                	mov    (%eax),%eax
  801708:	99                   	cltd   
}
  801709:	5d                   	pop    %ebp
  80170a:	c3                   	ret    

0080170b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
  80170e:	56                   	push   %esi
  80170f:	53                   	push   %ebx
  801710:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801713:	eb 17                	jmp    80172c <vprintfmt+0x21>
			if (ch == '\0')
  801715:	85 db                	test   %ebx,%ebx
  801717:	0f 84 af 03 00 00    	je     801acc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80171d:	83 ec 08             	sub    $0x8,%esp
  801720:	ff 75 0c             	pushl  0xc(%ebp)
  801723:	53                   	push   %ebx
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	ff d0                	call   *%eax
  801729:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80172c:	8b 45 10             	mov    0x10(%ebp),%eax
  80172f:	8d 50 01             	lea    0x1(%eax),%edx
  801732:	89 55 10             	mov    %edx,0x10(%ebp)
  801735:	8a 00                	mov    (%eax),%al
  801737:	0f b6 d8             	movzbl %al,%ebx
  80173a:	83 fb 25             	cmp    $0x25,%ebx
  80173d:	75 d6                	jne    801715 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80173f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801743:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80174a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801751:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801758:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80175f:	8b 45 10             	mov    0x10(%ebp),%eax
  801762:	8d 50 01             	lea    0x1(%eax),%edx
  801765:	89 55 10             	mov    %edx,0x10(%ebp)
  801768:	8a 00                	mov    (%eax),%al
  80176a:	0f b6 d8             	movzbl %al,%ebx
  80176d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801770:	83 f8 55             	cmp    $0x55,%eax
  801773:	0f 87 2b 03 00 00    	ja     801aa4 <vprintfmt+0x399>
  801779:	8b 04 85 98 35 80 00 	mov    0x803598(,%eax,4),%eax
  801780:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801782:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801786:	eb d7                	jmp    80175f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801788:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80178c:	eb d1                	jmp    80175f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80178e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801795:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801798:	89 d0                	mov    %edx,%eax
  80179a:	c1 e0 02             	shl    $0x2,%eax
  80179d:	01 d0                	add    %edx,%eax
  80179f:	01 c0                	add    %eax,%eax
  8017a1:	01 d8                	add    %ebx,%eax
  8017a3:	83 e8 30             	sub    $0x30,%eax
  8017a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8017a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8017b1:	83 fb 2f             	cmp    $0x2f,%ebx
  8017b4:	7e 3e                	jle    8017f4 <vprintfmt+0xe9>
  8017b6:	83 fb 39             	cmp    $0x39,%ebx
  8017b9:	7f 39                	jg     8017f4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8017bb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8017be:	eb d5                	jmp    801795 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8017c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8017c3:	83 c0 04             	add    $0x4,%eax
  8017c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8017c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8017cc:	83 e8 04             	sub    $0x4,%eax
  8017cf:	8b 00                	mov    (%eax),%eax
  8017d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8017d4:	eb 1f                	jmp    8017f5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8017d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8017da:	79 83                	jns    80175f <vprintfmt+0x54>
				width = 0;
  8017dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8017e3:	e9 77 ff ff ff       	jmp    80175f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8017e8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8017ef:	e9 6b ff ff ff       	jmp    80175f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8017f4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8017f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8017f9:	0f 89 60 ff ff ff    	jns    80175f <vprintfmt+0x54>
				width = precision, precision = -1;
  8017ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801802:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801805:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80180c:	e9 4e ff ff ff       	jmp    80175f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801811:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801814:	e9 46 ff ff ff       	jmp    80175f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801819:	8b 45 14             	mov    0x14(%ebp),%eax
  80181c:	83 c0 04             	add    $0x4,%eax
  80181f:	89 45 14             	mov    %eax,0x14(%ebp)
  801822:	8b 45 14             	mov    0x14(%ebp),%eax
  801825:	83 e8 04             	sub    $0x4,%eax
  801828:	8b 00                	mov    (%eax),%eax
  80182a:	83 ec 08             	sub    $0x8,%esp
  80182d:	ff 75 0c             	pushl  0xc(%ebp)
  801830:	50                   	push   %eax
  801831:	8b 45 08             	mov    0x8(%ebp),%eax
  801834:	ff d0                	call   *%eax
  801836:	83 c4 10             	add    $0x10,%esp
			break;
  801839:	e9 89 02 00 00       	jmp    801ac7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80183e:	8b 45 14             	mov    0x14(%ebp),%eax
  801841:	83 c0 04             	add    $0x4,%eax
  801844:	89 45 14             	mov    %eax,0x14(%ebp)
  801847:	8b 45 14             	mov    0x14(%ebp),%eax
  80184a:	83 e8 04             	sub    $0x4,%eax
  80184d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80184f:	85 db                	test   %ebx,%ebx
  801851:	79 02                	jns    801855 <vprintfmt+0x14a>
				err = -err;
  801853:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801855:	83 fb 64             	cmp    $0x64,%ebx
  801858:	7f 0b                	jg     801865 <vprintfmt+0x15a>
  80185a:	8b 34 9d e0 33 80 00 	mov    0x8033e0(,%ebx,4),%esi
  801861:	85 f6                	test   %esi,%esi
  801863:	75 19                	jne    80187e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801865:	53                   	push   %ebx
  801866:	68 85 35 80 00       	push   $0x803585
  80186b:	ff 75 0c             	pushl  0xc(%ebp)
  80186e:	ff 75 08             	pushl  0x8(%ebp)
  801871:	e8 5e 02 00 00       	call   801ad4 <printfmt>
  801876:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801879:	e9 49 02 00 00       	jmp    801ac7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80187e:	56                   	push   %esi
  80187f:	68 8e 35 80 00       	push   $0x80358e
  801884:	ff 75 0c             	pushl  0xc(%ebp)
  801887:	ff 75 08             	pushl  0x8(%ebp)
  80188a:	e8 45 02 00 00       	call   801ad4 <printfmt>
  80188f:	83 c4 10             	add    $0x10,%esp
			break;
  801892:	e9 30 02 00 00       	jmp    801ac7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801897:	8b 45 14             	mov    0x14(%ebp),%eax
  80189a:	83 c0 04             	add    $0x4,%eax
  80189d:	89 45 14             	mov    %eax,0x14(%ebp)
  8018a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a3:	83 e8 04             	sub    $0x4,%eax
  8018a6:	8b 30                	mov    (%eax),%esi
  8018a8:	85 f6                	test   %esi,%esi
  8018aa:	75 05                	jne    8018b1 <vprintfmt+0x1a6>
				p = "(null)";
  8018ac:	be 91 35 80 00       	mov    $0x803591,%esi
			if (width > 0 && padc != '-')
  8018b1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018b5:	7e 6d                	jle    801924 <vprintfmt+0x219>
  8018b7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8018bb:	74 67                	je     801924 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8018bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018c0:	83 ec 08             	sub    $0x8,%esp
  8018c3:	50                   	push   %eax
  8018c4:	56                   	push   %esi
  8018c5:	e8 0c 03 00 00       	call   801bd6 <strnlen>
  8018ca:	83 c4 10             	add    $0x10,%esp
  8018cd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8018d0:	eb 16                	jmp    8018e8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8018d2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8018d6:	83 ec 08             	sub    $0x8,%esp
  8018d9:	ff 75 0c             	pushl  0xc(%ebp)
  8018dc:	50                   	push   %eax
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	ff d0                	call   *%eax
  8018e2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8018e5:	ff 4d e4             	decl   -0x1c(%ebp)
  8018e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018ec:	7f e4                	jg     8018d2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8018ee:	eb 34                	jmp    801924 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8018f0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8018f4:	74 1c                	je     801912 <vprintfmt+0x207>
  8018f6:	83 fb 1f             	cmp    $0x1f,%ebx
  8018f9:	7e 05                	jle    801900 <vprintfmt+0x1f5>
  8018fb:	83 fb 7e             	cmp    $0x7e,%ebx
  8018fe:	7e 12                	jle    801912 <vprintfmt+0x207>
					putch('?', putdat);
  801900:	83 ec 08             	sub    $0x8,%esp
  801903:	ff 75 0c             	pushl  0xc(%ebp)
  801906:	6a 3f                	push   $0x3f
  801908:	8b 45 08             	mov    0x8(%ebp),%eax
  80190b:	ff d0                	call   *%eax
  80190d:	83 c4 10             	add    $0x10,%esp
  801910:	eb 0f                	jmp    801921 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801912:	83 ec 08             	sub    $0x8,%esp
  801915:	ff 75 0c             	pushl  0xc(%ebp)
  801918:	53                   	push   %ebx
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	ff d0                	call   *%eax
  80191e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801921:	ff 4d e4             	decl   -0x1c(%ebp)
  801924:	89 f0                	mov    %esi,%eax
  801926:	8d 70 01             	lea    0x1(%eax),%esi
  801929:	8a 00                	mov    (%eax),%al
  80192b:	0f be d8             	movsbl %al,%ebx
  80192e:	85 db                	test   %ebx,%ebx
  801930:	74 24                	je     801956 <vprintfmt+0x24b>
  801932:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801936:	78 b8                	js     8018f0 <vprintfmt+0x1e5>
  801938:	ff 4d e0             	decl   -0x20(%ebp)
  80193b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80193f:	79 af                	jns    8018f0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801941:	eb 13                	jmp    801956 <vprintfmt+0x24b>
				putch(' ', putdat);
  801943:	83 ec 08             	sub    $0x8,%esp
  801946:	ff 75 0c             	pushl  0xc(%ebp)
  801949:	6a 20                	push   $0x20
  80194b:	8b 45 08             	mov    0x8(%ebp),%eax
  80194e:	ff d0                	call   *%eax
  801950:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801953:	ff 4d e4             	decl   -0x1c(%ebp)
  801956:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80195a:	7f e7                	jg     801943 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80195c:	e9 66 01 00 00       	jmp    801ac7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801961:	83 ec 08             	sub    $0x8,%esp
  801964:	ff 75 e8             	pushl  -0x18(%ebp)
  801967:	8d 45 14             	lea    0x14(%ebp),%eax
  80196a:	50                   	push   %eax
  80196b:	e8 3c fd ff ff       	call   8016ac <getint>
  801970:	83 c4 10             	add    $0x10,%esp
  801973:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801976:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801979:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80197c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80197f:	85 d2                	test   %edx,%edx
  801981:	79 23                	jns    8019a6 <vprintfmt+0x29b>
				putch('-', putdat);
  801983:	83 ec 08             	sub    $0x8,%esp
  801986:	ff 75 0c             	pushl  0xc(%ebp)
  801989:	6a 2d                	push   $0x2d
  80198b:	8b 45 08             	mov    0x8(%ebp),%eax
  80198e:	ff d0                	call   *%eax
  801990:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801993:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801996:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801999:	f7 d8                	neg    %eax
  80199b:	83 d2 00             	adc    $0x0,%edx
  80199e:	f7 da                	neg    %edx
  8019a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8019a6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019ad:	e9 bc 00 00 00       	jmp    801a6e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8019b2:	83 ec 08             	sub    $0x8,%esp
  8019b5:	ff 75 e8             	pushl  -0x18(%ebp)
  8019b8:	8d 45 14             	lea    0x14(%ebp),%eax
  8019bb:	50                   	push   %eax
  8019bc:	e8 84 fc ff ff       	call   801645 <getuint>
  8019c1:	83 c4 10             	add    $0x10,%esp
  8019c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8019ca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019d1:	e9 98 00 00 00       	jmp    801a6e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8019d6:	83 ec 08             	sub    $0x8,%esp
  8019d9:	ff 75 0c             	pushl  0xc(%ebp)
  8019dc:	6a 58                	push   $0x58
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	ff d0                	call   *%eax
  8019e3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8019e6:	83 ec 08             	sub    $0x8,%esp
  8019e9:	ff 75 0c             	pushl  0xc(%ebp)
  8019ec:	6a 58                	push   $0x58
  8019ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f1:	ff d0                	call   *%eax
  8019f3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8019f6:	83 ec 08             	sub    $0x8,%esp
  8019f9:	ff 75 0c             	pushl  0xc(%ebp)
  8019fc:	6a 58                	push   $0x58
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	ff d0                	call   *%eax
  801a03:	83 c4 10             	add    $0x10,%esp
			break;
  801a06:	e9 bc 00 00 00       	jmp    801ac7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801a0b:	83 ec 08             	sub    $0x8,%esp
  801a0e:	ff 75 0c             	pushl  0xc(%ebp)
  801a11:	6a 30                	push   $0x30
  801a13:	8b 45 08             	mov    0x8(%ebp),%eax
  801a16:	ff d0                	call   *%eax
  801a18:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801a1b:	83 ec 08             	sub    $0x8,%esp
  801a1e:	ff 75 0c             	pushl  0xc(%ebp)
  801a21:	6a 78                	push   $0x78
  801a23:	8b 45 08             	mov    0x8(%ebp),%eax
  801a26:	ff d0                	call   *%eax
  801a28:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801a2b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2e:	83 c0 04             	add    $0x4,%eax
  801a31:	89 45 14             	mov    %eax,0x14(%ebp)
  801a34:	8b 45 14             	mov    0x14(%ebp),%eax
  801a37:	83 e8 04             	sub    $0x4,%eax
  801a3a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801a3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801a46:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801a4d:	eb 1f                	jmp    801a6e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801a4f:	83 ec 08             	sub    $0x8,%esp
  801a52:	ff 75 e8             	pushl  -0x18(%ebp)
  801a55:	8d 45 14             	lea    0x14(%ebp),%eax
  801a58:	50                   	push   %eax
  801a59:	e8 e7 fb ff ff       	call   801645 <getuint>
  801a5e:	83 c4 10             	add    $0x10,%esp
  801a61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a64:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801a67:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801a6e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801a72:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a75:	83 ec 04             	sub    $0x4,%esp
  801a78:	52                   	push   %edx
  801a79:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a7c:	50                   	push   %eax
  801a7d:	ff 75 f4             	pushl  -0xc(%ebp)
  801a80:	ff 75 f0             	pushl  -0x10(%ebp)
  801a83:	ff 75 0c             	pushl  0xc(%ebp)
  801a86:	ff 75 08             	pushl  0x8(%ebp)
  801a89:	e8 00 fb ff ff       	call   80158e <printnum>
  801a8e:	83 c4 20             	add    $0x20,%esp
			break;
  801a91:	eb 34                	jmp    801ac7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801a93:	83 ec 08             	sub    $0x8,%esp
  801a96:	ff 75 0c             	pushl  0xc(%ebp)
  801a99:	53                   	push   %ebx
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	ff d0                	call   *%eax
  801a9f:	83 c4 10             	add    $0x10,%esp
			break;
  801aa2:	eb 23                	jmp    801ac7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801aa4:	83 ec 08             	sub    $0x8,%esp
  801aa7:	ff 75 0c             	pushl  0xc(%ebp)
  801aaa:	6a 25                	push   $0x25
  801aac:	8b 45 08             	mov    0x8(%ebp),%eax
  801aaf:	ff d0                	call   *%eax
  801ab1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801ab4:	ff 4d 10             	decl   0x10(%ebp)
  801ab7:	eb 03                	jmp    801abc <vprintfmt+0x3b1>
  801ab9:	ff 4d 10             	decl   0x10(%ebp)
  801abc:	8b 45 10             	mov    0x10(%ebp),%eax
  801abf:	48                   	dec    %eax
  801ac0:	8a 00                	mov    (%eax),%al
  801ac2:	3c 25                	cmp    $0x25,%al
  801ac4:	75 f3                	jne    801ab9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801ac6:	90                   	nop
		}
	}
  801ac7:	e9 47 fc ff ff       	jmp    801713 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801acc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801acd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ad0:	5b                   	pop    %ebx
  801ad1:	5e                   	pop    %esi
  801ad2:	5d                   	pop    %ebp
  801ad3:	c3                   	ret    

00801ad4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
  801ad7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801ada:	8d 45 10             	lea    0x10(%ebp),%eax
  801add:	83 c0 04             	add    $0x4,%eax
  801ae0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801ae3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae6:	ff 75 f4             	pushl  -0xc(%ebp)
  801ae9:	50                   	push   %eax
  801aea:	ff 75 0c             	pushl  0xc(%ebp)
  801aed:	ff 75 08             	pushl  0x8(%ebp)
  801af0:	e8 16 fc ff ff       	call   80170b <vprintfmt>
  801af5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801afe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b01:	8b 40 08             	mov    0x8(%eax),%eax
  801b04:	8d 50 01             	lea    0x1(%eax),%edx
  801b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b0a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b10:	8b 10                	mov    (%eax),%edx
  801b12:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b15:	8b 40 04             	mov    0x4(%eax),%eax
  801b18:	39 c2                	cmp    %eax,%edx
  801b1a:	73 12                	jae    801b2e <sprintputch+0x33>
		*b->buf++ = ch;
  801b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b1f:	8b 00                	mov    (%eax),%eax
  801b21:	8d 48 01             	lea    0x1(%eax),%ecx
  801b24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b27:	89 0a                	mov    %ecx,(%edx)
  801b29:	8b 55 08             	mov    0x8(%ebp),%edx
  801b2c:	88 10                	mov    %dl,(%eax)
}
  801b2e:	90                   	nop
  801b2f:	5d                   	pop    %ebp
  801b30:	c3                   	ret    

00801b31 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
  801b34:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b40:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b43:	8b 45 08             	mov    0x8(%ebp),%eax
  801b46:	01 d0                	add    %edx,%eax
  801b48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801b52:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b56:	74 06                	je     801b5e <vsnprintf+0x2d>
  801b58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b5c:	7f 07                	jg     801b65 <vsnprintf+0x34>
		return -E_INVAL;
  801b5e:	b8 03 00 00 00       	mov    $0x3,%eax
  801b63:	eb 20                	jmp    801b85 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801b65:	ff 75 14             	pushl  0x14(%ebp)
  801b68:	ff 75 10             	pushl  0x10(%ebp)
  801b6b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801b6e:	50                   	push   %eax
  801b6f:	68 fb 1a 80 00       	push   $0x801afb
  801b74:	e8 92 fb ff ff       	call   80170b <vprintfmt>
  801b79:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801b7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b7f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801b82:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b85:	c9                   	leave  
  801b86:	c3                   	ret    

00801b87 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
  801b8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801b8d:	8d 45 10             	lea    0x10(%ebp),%eax
  801b90:	83 c0 04             	add    $0x4,%eax
  801b93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801b96:	8b 45 10             	mov    0x10(%ebp),%eax
  801b99:	ff 75 f4             	pushl  -0xc(%ebp)
  801b9c:	50                   	push   %eax
  801b9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ba0:	ff 75 08             	pushl  0x8(%ebp)
  801ba3:	e8 89 ff ff ff       	call   801b31 <vsnprintf>
  801ba8:	83 c4 10             	add    $0x10,%esp
  801bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
  801bb6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801bb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bc0:	eb 06                	jmp    801bc8 <strlen+0x15>
		n++;
  801bc2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801bc5:	ff 45 08             	incl   0x8(%ebp)
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	8a 00                	mov    (%eax),%al
  801bcd:	84 c0                	test   %al,%al
  801bcf:	75 f1                	jne    801bc2 <strlen+0xf>
		n++;
	return n;
  801bd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
  801bd9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801bdc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801be3:	eb 09                	jmp    801bee <strnlen+0x18>
		n++;
  801be5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801be8:	ff 45 08             	incl   0x8(%ebp)
  801beb:	ff 4d 0c             	decl   0xc(%ebp)
  801bee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bf2:	74 09                	je     801bfd <strnlen+0x27>
  801bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf7:	8a 00                	mov    (%eax),%al
  801bf9:	84 c0                	test   %al,%al
  801bfb:	75 e8                	jne    801be5 <strnlen+0xf>
		n++;
	return n;
  801bfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
  801c05:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801c08:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801c0e:	90                   	nop
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	8d 50 01             	lea    0x1(%eax),%edx
  801c15:	89 55 08             	mov    %edx,0x8(%ebp)
  801c18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1b:	8d 4a 01             	lea    0x1(%edx),%ecx
  801c1e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801c21:	8a 12                	mov    (%edx),%dl
  801c23:	88 10                	mov    %dl,(%eax)
  801c25:	8a 00                	mov    (%eax),%al
  801c27:	84 c0                	test   %al,%al
  801c29:	75 e4                	jne    801c0f <strcpy+0xd>
		/* do nothing */;
	return ret;
  801c2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
  801c33:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801c36:	8b 45 08             	mov    0x8(%ebp),%eax
  801c39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801c3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c43:	eb 1f                	jmp    801c64 <strncpy+0x34>
		*dst++ = *src;
  801c45:	8b 45 08             	mov    0x8(%ebp),%eax
  801c48:	8d 50 01             	lea    0x1(%eax),%edx
  801c4b:	89 55 08             	mov    %edx,0x8(%ebp)
  801c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c51:	8a 12                	mov    (%edx),%dl
  801c53:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801c55:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c58:	8a 00                	mov    (%eax),%al
  801c5a:	84 c0                	test   %al,%al
  801c5c:	74 03                	je     801c61 <strncpy+0x31>
			src++;
  801c5e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801c61:	ff 45 fc             	incl   -0x4(%ebp)
  801c64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c67:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c6a:	72 d9                	jb     801c45 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801c6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
  801c74:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801c77:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801c7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c81:	74 30                	je     801cb3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801c83:	eb 16                	jmp    801c9b <strlcpy+0x2a>
			*dst++ = *src++;
  801c85:	8b 45 08             	mov    0x8(%ebp),%eax
  801c88:	8d 50 01             	lea    0x1(%eax),%edx
  801c8b:	89 55 08             	mov    %edx,0x8(%ebp)
  801c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c91:	8d 4a 01             	lea    0x1(%edx),%ecx
  801c94:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801c97:	8a 12                	mov    (%edx),%dl
  801c99:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801c9b:	ff 4d 10             	decl   0x10(%ebp)
  801c9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ca2:	74 09                	je     801cad <strlcpy+0x3c>
  801ca4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ca7:	8a 00                	mov    (%eax),%al
  801ca9:	84 c0                	test   %al,%al
  801cab:	75 d8                	jne    801c85 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801cad:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801cb3:	8b 55 08             	mov    0x8(%ebp),%edx
  801cb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cb9:	29 c2                	sub    %eax,%edx
  801cbb:	89 d0                	mov    %edx,%eax
}
  801cbd:	c9                   	leave  
  801cbe:	c3                   	ret    

00801cbf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801cc2:	eb 06                	jmp    801cca <strcmp+0xb>
		p++, q++;
  801cc4:	ff 45 08             	incl   0x8(%ebp)
  801cc7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801cca:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccd:	8a 00                	mov    (%eax),%al
  801ccf:	84 c0                	test   %al,%al
  801cd1:	74 0e                	je     801ce1 <strcmp+0x22>
  801cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd6:	8a 10                	mov    (%eax),%dl
  801cd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cdb:	8a 00                	mov    (%eax),%al
  801cdd:	38 c2                	cmp    %al,%dl
  801cdf:	74 e3                	je     801cc4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce4:	8a 00                	mov    (%eax),%al
  801ce6:	0f b6 d0             	movzbl %al,%edx
  801ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cec:	8a 00                	mov    (%eax),%al
  801cee:	0f b6 c0             	movzbl %al,%eax
  801cf1:	29 c2                	sub    %eax,%edx
  801cf3:	89 d0                	mov    %edx,%eax
}
  801cf5:	5d                   	pop    %ebp
  801cf6:	c3                   	ret    

00801cf7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801cfa:	eb 09                	jmp    801d05 <strncmp+0xe>
		n--, p++, q++;
  801cfc:	ff 4d 10             	decl   0x10(%ebp)
  801cff:	ff 45 08             	incl   0x8(%ebp)
  801d02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801d05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d09:	74 17                	je     801d22 <strncmp+0x2b>
  801d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0e:	8a 00                	mov    (%eax),%al
  801d10:	84 c0                	test   %al,%al
  801d12:	74 0e                	je     801d22 <strncmp+0x2b>
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	8a 10                	mov    (%eax),%dl
  801d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d1c:	8a 00                	mov    (%eax),%al
  801d1e:	38 c2                	cmp    %al,%dl
  801d20:	74 da                	je     801cfc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801d22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d26:	75 07                	jne    801d2f <strncmp+0x38>
		return 0;
  801d28:	b8 00 00 00 00       	mov    $0x0,%eax
  801d2d:	eb 14                	jmp    801d43 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d32:	8a 00                	mov    (%eax),%al
  801d34:	0f b6 d0             	movzbl %al,%edx
  801d37:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d3a:	8a 00                	mov    (%eax),%al
  801d3c:	0f b6 c0             	movzbl %al,%eax
  801d3f:	29 c2                	sub    %eax,%edx
  801d41:	89 d0                	mov    %edx,%eax
}
  801d43:	5d                   	pop    %ebp
  801d44:	c3                   	ret    

00801d45 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
  801d48:	83 ec 04             	sub    $0x4,%esp
  801d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d4e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801d51:	eb 12                	jmp    801d65 <strchr+0x20>
		if (*s == c)
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	8a 00                	mov    (%eax),%al
  801d58:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801d5b:	75 05                	jne    801d62 <strchr+0x1d>
			return (char *) s;
  801d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d60:	eb 11                	jmp    801d73 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801d62:	ff 45 08             	incl   0x8(%ebp)
  801d65:	8b 45 08             	mov    0x8(%ebp),%eax
  801d68:	8a 00                	mov    (%eax),%al
  801d6a:	84 c0                	test   %al,%al
  801d6c:	75 e5                	jne    801d53 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801d6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d73:	c9                   	leave  
  801d74:	c3                   	ret    

00801d75 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801d75:	55                   	push   %ebp
  801d76:	89 e5                	mov    %esp,%ebp
  801d78:	83 ec 04             	sub    $0x4,%esp
  801d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801d81:	eb 0d                	jmp    801d90 <strfind+0x1b>
		if (*s == c)
  801d83:	8b 45 08             	mov    0x8(%ebp),%eax
  801d86:	8a 00                	mov    (%eax),%al
  801d88:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801d8b:	74 0e                	je     801d9b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801d8d:	ff 45 08             	incl   0x8(%ebp)
  801d90:	8b 45 08             	mov    0x8(%ebp),%eax
  801d93:	8a 00                	mov    (%eax),%al
  801d95:	84 c0                	test   %al,%al
  801d97:	75 ea                	jne    801d83 <strfind+0xe>
  801d99:	eb 01                	jmp    801d9c <strfind+0x27>
		if (*s == c)
			break;
  801d9b:	90                   	nop
	return (char *) s;
  801d9c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
  801da4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801dad:	8b 45 10             	mov    0x10(%ebp),%eax
  801db0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801db3:	eb 0e                	jmp    801dc3 <memset+0x22>
		*p++ = c;
  801db5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801db8:	8d 50 01             	lea    0x1(%eax),%edx
  801dbb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801dbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801dc3:	ff 4d f8             	decl   -0x8(%ebp)
  801dc6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801dca:	79 e9                	jns    801db5 <memset+0x14>
		*p++ = c;

	return v;
  801dcc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
  801dd4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dda:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  801de0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801de3:	eb 16                	jmp    801dfb <memcpy+0x2a>
		*d++ = *s++;
  801de5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801de8:	8d 50 01             	lea    0x1(%eax),%edx
  801deb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801dee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801df1:	8d 4a 01             	lea    0x1(%edx),%ecx
  801df4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801df7:	8a 12                	mov    (%edx),%dl
  801df9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801dfb:	8b 45 10             	mov    0x10(%ebp),%eax
  801dfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e01:	89 55 10             	mov    %edx,0x10(%ebp)
  801e04:	85 c0                	test   %eax,%eax
  801e06:	75 dd                	jne    801de5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
  801e10:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801e19:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801e1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e22:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e25:	73 50                	jae    801e77 <memmove+0x6a>
  801e27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e2a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e2d:	01 d0                	add    %edx,%eax
  801e2f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e32:	76 43                	jbe    801e77 <memmove+0x6a>
		s += n;
  801e34:	8b 45 10             	mov    0x10(%ebp),%eax
  801e37:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801e3a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e3d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801e40:	eb 10                	jmp    801e52 <memmove+0x45>
			*--d = *--s;
  801e42:	ff 4d f8             	decl   -0x8(%ebp)
  801e45:	ff 4d fc             	decl   -0x4(%ebp)
  801e48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e4b:	8a 10                	mov    (%eax),%dl
  801e4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e50:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801e52:	8b 45 10             	mov    0x10(%ebp),%eax
  801e55:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e58:	89 55 10             	mov    %edx,0x10(%ebp)
  801e5b:	85 c0                	test   %eax,%eax
  801e5d:	75 e3                	jne    801e42 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801e5f:	eb 23                	jmp    801e84 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801e61:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e64:	8d 50 01             	lea    0x1(%eax),%edx
  801e67:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801e6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e6d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e70:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801e73:	8a 12                	mov    (%edx),%dl
  801e75:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801e77:	8b 45 10             	mov    0x10(%ebp),%eax
  801e7a:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e7d:	89 55 10             	mov    %edx,0x10(%ebp)
  801e80:	85 c0                	test   %eax,%eax
  801e82:	75 dd                	jne    801e61 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801e84:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
  801e8c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e98:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801e9b:	eb 2a                	jmp    801ec7 <memcmp+0x3e>
		if (*s1 != *s2)
  801e9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ea0:	8a 10                	mov    (%eax),%dl
  801ea2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ea5:	8a 00                	mov    (%eax),%al
  801ea7:	38 c2                	cmp    %al,%dl
  801ea9:	74 16                	je     801ec1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801eae:	8a 00                	mov    (%eax),%al
  801eb0:	0f b6 d0             	movzbl %al,%edx
  801eb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801eb6:	8a 00                	mov    (%eax),%al
  801eb8:	0f b6 c0             	movzbl %al,%eax
  801ebb:	29 c2                	sub    %eax,%edx
  801ebd:	89 d0                	mov    %edx,%eax
  801ebf:	eb 18                	jmp    801ed9 <memcmp+0x50>
		s1++, s2++;
  801ec1:	ff 45 fc             	incl   -0x4(%ebp)
  801ec4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801ec7:	8b 45 10             	mov    0x10(%ebp),%eax
  801eca:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ecd:	89 55 10             	mov    %edx,0x10(%ebp)
  801ed0:	85 c0                	test   %eax,%eax
  801ed2:	75 c9                	jne    801e9d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801ed4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    

00801edb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801edb:	55                   	push   %ebp
  801edc:	89 e5                	mov    %esp,%ebp
  801ede:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801ee1:	8b 55 08             	mov    0x8(%ebp),%edx
  801ee4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ee7:	01 d0                	add    %edx,%eax
  801ee9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801eec:	eb 15                	jmp    801f03 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801eee:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef1:	8a 00                	mov    (%eax),%al
  801ef3:	0f b6 d0             	movzbl %al,%edx
  801ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ef9:	0f b6 c0             	movzbl %al,%eax
  801efc:	39 c2                	cmp    %eax,%edx
  801efe:	74 0d                	je     801f0d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801f00:	ff 45 08             	incl   0x8(%ebp)
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801f09:	72 e3                	jb     801eee <memfind+0x13>
  801f0b:	eb 01                	jmp    801f0e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801f0d:	90                   	nop
	return (void *) s;
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f11:	c9                   	leave  
  801f12:	c3                   	ret    

00801f13 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801f13:	55                   	push   %ebp
  801f14:	89 e5                	mov    %esp,%ebp
  801f16:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801f19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801f20:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f27:	eb 03                	jmp    801f2c <strtol+0x19>
		s++;
  801f29:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2f:	8a 00                	mov    (%eax),%al
  801f31:	3c 20                	cmp    $0x20,%al
  801f33:	74 f4                	je     801f29 <strtol+0x16>
  801f35:	8b 45 08             	mov    0x8(%ebp),%eax
  801f38:	8a 00                	mov    (%eax),%al
  801f3a:	3c 09                	cmp    $0x9,%al
  801f3c:	74 eb                	je     801f29 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f41:	8a 00                	mov    (%eax),%al
  801f43:	3c 2b                	cmp    $0x2b,%al
  801f45:	75 05                	jne    801f4c <strtol+0x39>
		s++;
  801f47:	ff 45 08             	incl   0x8(%ebp)
  801f4a:	eb 13                	jmp    801f5f <strtol+0x4c>
	else if (*s == '-')
  801f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4f:	8a 00                	mov    (%eax),%al
  801f51:	3c 2d                	cmp    $0x2d,%al
  801f53:	75 0a                	jne    801f5f <strtol+0x4c>
		s++, neg = 1;
  801f55:	ff 45 08             	incl   0x8(%ebp)
  801f58:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801f5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f63:	74 06                	je     801f6b <strtol+0x58>
  801f65:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801f69:	75 20                	jne    801f8b <strtol+0x78>
  801f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6e:	8a 00                	mov    (%eax),%al
  801f70:	3c 30                	cmp    $0x30,%al
  801f72:	75 17                	jne    801f8b <strtol+0x78>
  801f74:	8b 45 08             	mov    0x8(%ebp),%eax
  801f77:	40                   	inc    %eax
  801f78:	8a 00                	mov    (%eax),%al
  801f7a:	3c 78                	cmp    $0x78,%al
  801f7c:	75 0d                	jne    801f8b <strtol+0x78>
		s += 2, base = 16;
  801f7e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801f82:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801f89:	eb 28                	jmp    801fb3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801f8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f8f:	75 15                	jne    801fa6 <strtol+0x93>
  801f91:	8b 45 08             	mov    0x8(%ebp),%eax
  801f94:	8a 00                	mov    (%eax),%al
  801f96:	3c 30                	cmp    $0x30,%al
  801f98:	75 0c                	jne    801fa6 <strtol+0x93>
		s++, base = 8;
  801f9a:	ff 45 08             	incl   0x8(%ebp)
  801f9d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801fa4:	eb 0d                	jmp    801fb3 <strtol+0xa0>
	else if (base == 0)
  801fa6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801faa:	75 07                	jne    801fb3 <strtol+0xa0>
		base = 10;
  801fac:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb6:	8a 00                	mov    (%eax),%al
  801fb8:	3c 2f                	cmp    $0x2f,%al
  801fba:	7e 19                	jle    801fd5 <strtol+0xc2>
  801fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbf:	8a 00                	mov    (%eax),%al
  801fc1:	3c 39                	cmp    $0x39,%al
  801fc3:	7f 10                	jg     801fd5 <strtol+0xc2>
			dig = *s - '0';
  801fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc8:	8a 00                	mov    (%eax),%al
  801fca:	0f be c0             	movsbl %al,%eax
  801fcd:	83 e8 30             	sub    $0x30,%eax
  801fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801fd3:	eb 42                	jmp    802017 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd8:	8a 00                	mov    (%eax),%al
  801fda:	3c 60                	cmp    $0x60,%al
  801fdc:	7e 19                	jle    801ff7 <strtol+0xe4>
  801fde:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe1:	8a 00                	mov    (%eax),%al
  801fe3:	3c 7a                	cmp    $0x7a,%al
  801fe5:	7f 10                	jg     801ff7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fea:	8a 00                	mov    (%eax),%al
  801fec:	0f be c0             	movsbl %al,%eax
  801fef:	83 e8 57             	sub    $0x57,%eax
  801ff2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801ff5:	eb 20                	jmp    802017 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffa:	8a 00                	mov    (%eax),%al
  801ffc:	3c 40                	cmp    $0x40,%al
  801ffe:	7e 39                	jle    802039 <strtol+0x126>
  802000:	8b 45 08             	mov    0x8(%ebp),%eax
  802003:	8a 00                	mov    (%eax),%al
  802005:	3c 5a                	cmp    $0x5a,%al
  802007:	7f 30                	jg     802039 <strtol+0x126>
			dig = *s - 'A' + 10;
  802009:	8b 45 08             	mov    0x8(%ebp),%eax
  80200c:	8a 00                	mov    (%eax),%al
  80200e:	0f be c0             	movsbl %al,%eax
  802011:	83 e8 37             	sub    $0x37,%eax
  802014:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802017:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80201a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80201d:	7d 19                	jge    802038 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80201f:	ff 45 08             	incl   0x8(%ebp)
  802022:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802025:	0f af 45 10          	imul   0x10(%ebp),%eax
  802029:	89 c2                	mov    %eax,%edx
  80202b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80202e:	01 d0                	add    %edx,%eax
  802030:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802033:	e9 7b ff ff ff       	jmp    801fb3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  802038:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802039:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80203d:	74 08                	je     802047 <strtol+0x134>
		*endptr = (char *) s;
  80203f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802042:	8b 55 08             	mov    0x8(%ebp),%edx
  802045:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  802047:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80204b:	74 07                	je     802054 <strtol+0x141>
  80204d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802050:	f7 d8                	neg    %eax
  802052:	eb 03                	jmp    802057 <strtol+0x144>
  802054:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802057:	c9                   	leave  
  802058:	c3                   	ret    

00802059 <ltostr>:

void
ltostr(long value, char *str)
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
  80205c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80205f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802066:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80206d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802071:	79 13                	jns    802086 <ltostr+0x2d>
	{
		neg = 1;
  802073:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80207a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80207d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802080:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802083:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802086:	8b 45 08             	mov    0x8(%ebp),%eax
  802089:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80208e:	99                   	cltd   
  80208f:	f7 f9                	idiv   %ecx
  802091:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802094:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802097:	8d 50 01             	lea    0x1(%eax),%edx
  80209a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80209d:	89 c2                	mov    %eax,%edx
  80209f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020a2:	01 d0                	add    %edx,%eax
  8020a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020a7:	83 c2 30             	add    $0x30,%edx
  8020aa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8020ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020af:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020b4:	f7 e9                	imul   %ecx
  8020b6:	c1 fa 02             	sar    $0x2,%edx
  8020b9:	89 c8                	mov    %ecx,%eax
  8020bb:	c1 f8 1f             	sar    $0x1f,%eax
  8020be:	29 c2                	sub    %eax,%edx
  8020c0:	89 d0                	mov    %edx,%eax
  8020c2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8020c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020c8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020cd:	f7 e9                	imul   %ecx
  8020cf:	c1 fa 02             	sar    $0x2,%edx
  8020d2:	89 c8                	mov    %ecx,%eax
  8020d4:	c1 f8 1f             	sar    $0x1f,%eax
  8020d7:	29 c2                	sub    %eax,%edx
  8020d9:	89 d0                	mov    %edx,%eax
  8020db:	c1 e0 02             	shl    $0x2,%eax
  8020de:	01 d0                	add    %edx,%eax
  8020e0:	01 c0                	add    %eax,%eax
  8020e2:	29 c1                	sub    %eax,%ecx
  8020e4:	89 ca                	mov    %ecx,%edx
  8020e6:	85 d2                	test   %edx,%edx
  8020e8:	75 9c                	jne    802086 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8020ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8020f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020f4:	48                   	dec    %eax
  8020f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8020f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8020fc:	74 3d                	je     80213b <ltostr+0xe2>
		start = 1 ;
  8020fe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802105:	eb 34                	jmp    80213b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802107:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80210a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80210d:	01 d0                	add    %edx,%eax
  80210f:	8a 00                	mov    (%eax),%al
  802111:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802114:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802117:	8b 45 0c             	mov    0xc(%ebp),%eax
  80211a:	01 c2                	add    %eax,%edx
  80211c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80211f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802122:	01 c8                	add    %ecx,%eax
  802124:	8a 00                	mov    (%eax),%al
  802126:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  802128:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80212b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80212e:	01 c2                	add    %eax,%edx
  802130:	8a 45 eb             	mov    -0x15(%ebp),%al
  802133:	88 02                	mov    %al,(%edx)
		start++ ;
  802135:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  802138:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80213b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80213e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802141:	7c c4                	jl     802107 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802143:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802146:	8b 45 0c             	mov    0xc(%ebp),%eax
  802149:	01 d0                	add    %edx,%eax
  80214b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80214e:	90                   	nop
  80214f:	c9                   	leave  
  802150:	c3                   	ret    

00802151 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  802157:	ff 75 08             	pushl  0x8(%ebp)
  80215a:	e8 54 fa ff ff       	call   801bb3 <strlen>
  80215f:	83 c4 04             	add    $0x4,%esp
  802162:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802165:	ff 75 0c             	pushl  0xc(%ebp)
  802168:	e8 46 fa ff ff       	call   801bb3 <strlen>
  80216d:	83 c4 04             	add    $0x4,%esp
  802170:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802173:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80217a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802181:	eb 17                	jmp    80219a <strcconcat+0x49>
		final[s] = str1[s] ;
  802183:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802186:	8b 45 10             	mov    0x10(%ebp),%eax
  802189:	01 c2                	add    %eax,%edx
  80218b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80218e:	8b 45 08             	mov    0x8(%ebp),%eax
  802191:	01 c8                	add    %ecx,%eax
  802193:	8a 00                	mov    (%eax),%al
  802195:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802197:	ff 45 fc             	incl   -0x4(%ebp)
  80219a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80219d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8021a0:	7c e1                	jl     802183 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8021a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8021a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8021b0:	eb 1f                	jmp    8021d1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8021b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021b5:	8d 50 01             	lea    0x1(%eax),%edx
  8021b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8021bb:	89 c2                	mov    %eax,%edx
  8021bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8021c0:	01 c2                	add    %eax,%edx
  8021c2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8021c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021c8:	01 c8                	add    %ecx,%eax
  8021ca:	8a 00                	mov    (%eax),%al
  8021cc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8021ce:	ff 45 f8             	incl   -0x8(%ebp)
  8021d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8021d7:	7c d9                	jl     8021b2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8021d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8021df:	01 d0                	add    %edx,%eax
  8021e1:	c6 00 00             	movb   $0x0,(%eax)
}
  8021e4:	90                   	nop
  8021e5:	c9                   	leave  
  8021e6:	c3                   	ret    

008021e7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8021e7:	55                   	push   %ebp
  8021e8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8021ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8021ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8021f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8021f6:	8b 00                	mov    (%eax),%eax
  8021f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8021ff:	8b 45 10             	mov    0x10(%ebp),%eax
  802202:	01 d0                	add    %edx,%eax
  802204:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80220a:	eb 0c                	jmp    802218 <strsplit+0x31>
			*string++ = 0;
  80220c:	8b 45 08             	mov    0x8(%ebp),%eax
  80220f:	8d 50 01             	lea    0x1(%eax),%edx
  802212:	89 55 08             	mov    %edx,0x8(%ebp)
  802215:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802218:	8b 45 08             	mov    0x8(%ebp),%eax
  80221b:	8a 00                	mov    (%eax),%al
  80221d:	84 c0                	test   %al,%al
  80221f:	74 18                	je     802239 <strsplit+0x52>
  802221:	8b 45 08             	mov    0x8(%ebp),%eax
  802224:	8a 00                	mov    (%eax),%al
  802226:	0f be c0             	movsbl %al,%eax
  802229:	50                   	push   %eax
  80222a:	ff 75 0c             	pushl  0xc(%ebp)
  80222d:	e8 13 fb ff ff       	call   801d45 <strchr>
  802232:	83 c4 08             	add    $0x8,%esp
  802235:	85 c0                	test   %eax,%eax
  802237:	75 d3                	jne    80220c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  802239:	8b 45 08             	mov    0x8(%ebp),%eax
  80223c:	8a 00                	mov    (%eax),%al
  80223e:	84 c0                	test   %al,%al
  802240:	74 5a                	je     80229c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802242:	8b 45 14             	mov    0x14(%ebp),%eax
  802245:	8b 00                	mov    (%eax),%eax
  802247:	83 f8 0f             	cmp    $0xf,%eax
  80224a:	75 07                	jne    802253 <strsplit+0x6c>
		{
			return 0;
  80224c:	b8 00 00 00 00       	mov    $0x0,%eax
  802251:	eb 66                	jmp    8022b9 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802253:	8b 45 14             	mov    0x14(%ebp),%eax
  802256:	8b 00                	mov    (%eax),%eax
  802258:	8d 48 01             	lea    0x1(%eax),%ecx
  80225b:	8b 55 14             	mov    0x14(%ebp),%edx
  80225e:	89 0a                	mov    %ecx,(%edx)
  802260:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802267:	8b 45 10             	mov    0x10(%ebp),%eax
  80226a:	01 c2                	add    %eax,%edx
  80226c:	8b 45 08             	mov    0x8(%ebp),%eax
  80226f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802271:	eb 03                	jmp    802276 <strsplit+0x8f>
			string++;
  802273:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802276:	8b 45 08             	mov    0x8(%ebp),%eax
  802279:	8a 00                	mov    (%eax),%al
  80227b:	84 c0                	test   %al,%al
  80227d:	74 8b                	je     80220a <strsplit+0x23>
  80227f:	8b 45 08             	mov    0x8(%ebp),%eax
  802282:	8a 00                	mov    (%eax),%al
  802284:	0f be c0             	movsbl %al,%eax
  802287:	50                   	push   %eax
  802288:	ff 75 0c             	pushl  0xc(%ebp)
  80228b:	e8 b5 fa ff ff       	call   801d45 <strchr>
  802290:	83 c4 08             	add    $0x8,%esp
  802293:	85 c0                	test   %eax,%eax
  802295:	74 dc                	je     802273 <strsplit+0x8c>
			string++;
	}
  802297:	e9 6e ff ff ff       	jmp    80220a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80229c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80229d:	8b 45 14             	mov    0x14(%ebp),%eax
  8022a0:	8b 00                	mov    (%eax),%eax
  8022a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8022a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8022ac:	01 d0                	add    %edx,%eax
  8022ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8022b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8022b9:	c9                   	leave  
  8022ba:	c3                   	ret    

008022bb <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  8022bb:	55                   	push   %ebp
  8022bc:	89 e5                	mov    %esp,%ebp
  8022be:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  8022c1:	a1 04 40 80 00       	mov    0x804004,%eax
  8022c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  8022d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8022d7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  8022de:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  8022e5:	e9 f9 00 00 00       	jmp    8023e3 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  8022ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022ed:	05 00 00 00 80       	add    $0x80000000,%eax
  8022f2:	c1 e8 0c             	shr    $0xc,%eax
  8022f5:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  8022fc:	85 c0                	test   %eax,%eax
  8022fe:	75 1c                	jne    80231c <nextFitAlgo+0x61>
  802300:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  802304:	74 16                	je     80231c <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  802306:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  80230d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  802314:	ff 4d e0             	decl   -0x20(%ebp)
  802317:	e9 90 00 00 00       	jmp    8023ac <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  80231c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80231f:	05 00 00 00 80       	add    $0x80000000,%eax
  802324:	c1 e8 0c             	shr    $0xc,%eax
  802327:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  80232e:	85 c0                	test   %eax,%eax
  802330:	75 26                	jne    802358 <nextFitAlgo+0x9d>
  802332:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  802336:	75 20                	jne    802358 <nextFitAlgo+0x9d>
			flag = 1;
  802338:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  80233f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802342:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  802345:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  80234c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  802353:	ff 4d e0             	decl   -0x20(%ebp)
  802356:	eb 54                	jmp    8023ac <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  802358:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80235b:	3b 45 08             	cmp    0x8(%ebp),%eax
  80235e:	72 11                	jb     802371 <nextFitAlgo+0xb6>
				startAdd = tmp;
  802360:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802363:	a3 04 40 80 00       	mov    %eax,0x804004
				found = 1;
  802368:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  80236f:	eb 7c                	jmp    8023ed <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  802371:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802374:	05 00 00 00 80       	add    $0x80000000,%eax
  802379:	c1 e8 0c             	shr    $0xc,%eax
  80237c:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802383:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  802386:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802389:	05 00 00 00 80       	add    $0x80000000,%eax
  80238e:	c1 e8 0c             	shr    $0xc,%eax
  802391:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  802398:	c1 e0 0c             	shl    $0xc,%eax
  80239b:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  80239e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8023a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  8023ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023af:	3b 45 08             	cmp    0x8(%ebp),%eax
  8023b2:	72 11                	jb     8023c5 <nextFitAlgo+0x10a>
			startAdd = tmp;
  8023b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8023b7:	a3 04 40 80 00       	mov    %eax,0x804004
			found = 1;
  8023bc:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  8023c3:	eb 28                	jmp    8023ed <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  8023c5:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  8023cc:	76 15                	jbe    8023e3 <nextFitAlgo+0x128>
			flag = newSize = 0;
  8023ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8023d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  8023dc:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  8023e3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8023e7:	0f 85 fd fe ff ff    	jne    8022ea <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  8023ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8023f1:	75 1a                	jne    80240d <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  8023f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023f6:	3b 45 08             	cmp    0x8(%ebp),%eax
  8023f9:	73 0a                	jae    802405 <nextFitAlgo+0x14a>
  8023fb:	b8 00 00 00 00       	mov    $0x0,%eax
  802400:	e9 99 00 00 00       	jmp    80249e <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  802405:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802408:	a3 04 40 80 00       	mov    %eax,0x804004
	}

	uint32 returnHolder = startAdd;
  80240d:	a1 04 40 80 00       	mov    0x804004,%eax
  802412:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  802415:	a1 04 40 80 00       	mov    0x804004,%eax
  80241a:	05 00 00 00 80       	add    $0x80000000,%eax
  80241f:	c1 e8 0c             	shr    $0xc,%eax
  802422:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  802425:	8b 45 08             	mov    0x8(%ebp),%eax
  802428:	c1 e8 0c             	shr    $0xc,%eax
  80242b:	89 c2                	mov    %eax,%edx
  80242d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802430:	89 14 85 40 40 80 00 	mov    %edx,0x804040(,%eax,4)
	sys_allocateMem(startAdd, size);
  802437:	a1 04 40 80 00       	mov    0x804004,%eax
  80243c:	83 ec 08             	sub    $0x8,%esp
  80243f:	ff 75 08             	pushl  0x8(%ebp)
  802442:	50                   	push   %eax
  802443:	e8 82 03 00 00       	call   8027ca <sys_allocateMem>
  802448:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  80244b:	a1 04 40 80 00       	mov    0x804004,%eax
  802450:	05 00 00 00 80       	add    $0x80000000,%eax
  802455:	c1 e8 0c             	shr    $0xc,%eax
  802458:	89 c2                	mov    %eax,%edx
  80245a:	a1 04 40 80 00       	mov    0x804004,%eax
  80245f:	89 04 d5 60 40 88 00 	mov    %eax,0x884060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  802466:	a1 04 40 80 00       	mov    0x804004,%eax
  80246b:	05 00 00 00 80       	add    $0x80000000,%eax
  802470:	c1 e8 0c             	shr    $0xc,%eax
  802473:	89 c2                	mov    %eax,%edx
  802475:	8b 45 08             	mov    0x8(%ebp),%eax
  802478:	89 04 d5 64 40 88 00 	mov    %eax,0x884064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  80247f:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802485:	8b 45 08             	mov    0x8(%ebp),%eax
  802488:	01 d0                	add    %edx,%eax
  80248a:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  80248f:	76 0a                	jbe    80249b <nextFitAlgo+0x1e0>
  802491:	c7 05 04 40 80 00 00 	movl   $0x80000000,0x804004
  802498:	00 00 80 

	return (void*)returnHolder;
  80249b:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  80249e:	c9                   	leave  
  80249f:	c3                   	ret    

008024a0 <malloc>:

void* malloc(uint32 size) {
  8024a0:	55                   	push   %ebp
  8024a1:	89 e5                	mov    %esp,%ebp
  8024a3:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  8024a6:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  8024ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8024b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024b3:	01 d0                	add    %edx,%eax
  8024b5:	48                   	dec    %eax
  8024b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8024b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8024c1:	f7 75 f4             	divl   -0xc(%ebp)
  8024c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024c7:	29 d0                	sub    %edx,%eax
  8024c9:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  8024cc:	e8 c3 06 00 00       	call   802b94 <sys_isUHeapPlacementStrategyNEXTFIT>
  8024d1:	85 c0                	test   %eax,%eax
  8024d3:	74 10                	je     8024e5 <malloc+0x45>
		return nextFitAlgo(size);
  8024d5:	83 ec 0c             	sub    $0xc,%esp
  8024d8:	ff 75 08             	pushl  0x8(%ebp)
  8024db:	e8 db fd ff ff       	call   8022bb <nextFitAlgo>
  8024e0:	83 c4 10             	add    $0x10,%esp
  8024e3:	eb 0a                	jmp    8024ef <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  8024e5:	e8 79 06 00 00       	call   802b63 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  8024ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024ef:	c9                   	leave  
  8024f0:	c3                   	ret    

008024f1 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8024f1:	55                   	push   %ebp
  8024f2:	89 e5                	mov    %esp,%ebp
  8024f4:	83 ec 18             	sub    $0x18,%esp
  8024f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8024fa:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8024fd:	83 ec 04             	sub    $0x4,%esp
  802500:	68 f0 36 80 00       	push   $0x8036f0
  802505:	6a 7e                	push   $0x7e
  802507:	68 0f 37 80 00       	push   $0x80370f
  80250c:	e8 6c ed ff ff       	call   80127d <_panic>

00802511 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802511:	55                   	push   %ebp
  802512:	89 e5                	mov    %esp,%ebp
  802514:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  802517:	83 ec 04             	sub    $0x4,%esp
  80251a:	68 1b 37 80 00       	push   $0x80371b
  80251f:	68 84 00 00 00       	push   $0x84
  802524:	68 0f 37 80 00       	push   $0x80370f
  802529:	e8 4f ed ff ff       	call   80127d <_panic>

0080252e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80252e:	55                   	push   %ebp
  80252f:	89 e5                	mov    %esp,%ebp
  802531:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  802534:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80253b:	eb 61                	jmp    80259e <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  80253d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802540:	8b 14 c5 60 40 88 00 	mov    0x884060(,%eax,8),%edx
  802547:	8b 45 08             	mov    0x8(%ebp),%eax
  80254a:	39 c2                	cmp    %eax,%edx
  80254c:	75 4d                	jne    80259b <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  80254e:	8b 45 08             	mov    0x8(%ebp),%eax
  802551:	05 00 00 00 80       	add    $0x80000000,%eax
  802556:	c1 e8 0c             	shr    $0xc,%eax
  802559:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  80255c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80255f:	8b 04 c5 64 40 88 00 	mov    0x884064(,%eax,8),%eax
  802566:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  802569:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80256c:	c7 04 85 40 40 80 00 	movl   $0x0,0x804040(,%eax,4)
  802573:	00 00 00 00 
  802577:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80257a:	c7 04 c5 64 40 88 00 	movl   $0x0,0x884064(,%eax,8)
  802581:	00 00 00 00 
  802585:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802588:	8b 14 c5 64 40 88 00 	mov    0x884064(,%eax,8),%edx
  80258f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802592:	89 14 c5 60 40 88 00 	mov    %edx,0x884060(,%eax,8)
			break;
  802599:	eb 0d                	jmp    8025a8 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  80259b:	ff 45 f0             	incl   -0x10(%ebp)
  80259e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025a1:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8025a6:	76 95                	jbe    80253d <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  8025a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8025ab:	83 ec 08             	sub    $0x8,%esp
  8025ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8025b1:	50                   	push   %eax
  8025b2:	e8 f7 01 00 00       	call   8027ae <sys_freeMem>
  8025b7:	83 c4 10             	add    $0x10,%esp
}
  8025ba:	90                   	nop
  8025bb:	c9                   	leave  
  8025bc:	c3                   	ret    

008025bd <sfree>:


void sfree(void* virtual_address)
{
  8025bd:	55                   	push   %ebp
  8025be:	89 e5                	mov    %esp,%ebp
  8025c0:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8025c3:	83 ec 04             	sub    $0x4,%esp
  8025c6:	68 37 37 80 00       	push   $0x803737
  8025cb:	68 ac 00 00 00       	push   $0xac
  8025d0:	68 0f 37 80 00       	push   $0x80370f
  8025d5:	e8 a3 ec ff ff       	call   80127d <_panic>

008025da <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  8025da:	55                   	push   %ebp
  8025db:	89 e5                	mov    %esp,%ebp
  8025dd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8025e0:	83 ec 04             	sub    $0x4,%esp
  8025e3:	68 54 37 80 00       	push   $0x803754
  8025e8:	68 c4 00 00 00       	push   $0xc4
  8025ed:	68 0f 37 80 00       	push   $0x80370f
  8025f2:	e8 86 ec ff ff       	call   80127d <_panic>

008025f7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8025f7:	55                   	push   %ebp
  8025f8:	89 e5                	mov    %esp,%ebp
  8025fa:	57                   	push   %edi
  8025fb:	56                   	push   %esi
  8025fc:	53                   	push   %ebx
  8025fd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802600:	8b 45 08             	mov    0x8(%ebp),%eax
  802603:	8b 55 0c             	mov    0xc(%ebp),%edx
  802606:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802609:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80260c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80260f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802612:	cd 30                	int    $0x30
  802614:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802617:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80261a:	83 c4 10             	add    $0x10,%esp
  80261d:	5b                   	pop    %ebx
  80261e:	5e                   	pop    %esi
  80261f:	5f                   	pop    %edi
  802620:	5d                   	pop    %ebp
  802621:	c3                   	ret    

00802622 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802622:	55                   	push   %ebp
  802623:	89 e5                	mov    %esp,%ebp
  802625:	83 ec 04             	sub    $0x4,%esp
  802628:	8b 45 10             	mov    0x10(%ebp),%eax
  80262b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80262e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802632:	8b 45 08             	mov    0x8(%ebp),%eax
  802635:	6a 00                	push   $0x0
  802637:	6a 00                	push   $0x0
  802639:	52                   	push   %edx
  80263a:	ff 75 0c             	pushl  0xc(%ebp)
  80263d:	50                   	push   %eax
  80263e:	6a 00                	push   $0x0
  802640:	e8 b2 ff ff ff       	call   8025f7 <syscall>
  802645:	83 c4 18             	add    $0x18,%esp
}
  802648:	90                   	nop
  802649:	c9                   	leave  
  80264a:	c3                   	ret    

0080264b <sys_cgetc>:

int
sys_cgetc(void)
{
  80264b:	55                   	push   %ebp
  80264c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80264e:	6a 00                	push   $0x0
  802650:	6a 00                	push   $0x0
  802652:	6a 00                	push   $0x0
  802654:	6a 00                	push   $0x0
  802656:	6a 00                	push   $0x0
  802658:	6a 01                	push   $0x1
  80265a:	e8 98 ff ff ff       	call   8025f7 <syscall>
  80265f:	83 c4 18             	add    $0x18,%esp
}
  802662:	c9                   	leave  
  802663:	c3                   	ret    

00802664 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802664:	55                   	push   %ebp
  802665:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802667:	8b 45 08             	mov    0x8(%ebp),%eax
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 00                	push   $0x0
  802670:	6a 00                	push   $0x0
  802672:	50                   	push   %eax
  802673:	6a 05                	push   $0x5
  802675:	e8 7d ff ff ff       	call   8025f7 <syscall>
  80267a:	83 c4 18             	add    $0x18,%esp
}
  80267d:	c9                   	leave  
  80267e:	c3                   	ret    

0080267f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80267f:	55                   	push   %ebp
  802680:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802682:	6a 00                	push   $0x0
  802684:	6a 00                	push   $0x0
  802686:	6a 00                	push   $0x0
  802688:	6a 00                	push   $0x0
  80268a:	6a 00                	push   $0x0
  80268c:	6a 02                	push   $0x2
  80268e:	e8 64 ff ff ff       	call   8025f7 <syscall>
  802693:	83 c4 18             	add    $0x18,%esp
}
  802696:	c9                   	leave  
  802697:	c3                   	ret    

00802698 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802698:	55                   	push   %ebp
  802699:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80269b:	6a 00                	push   $0x0
  80269d:	6a 00                	push   $0x0
  80269f:	6a 00                	push   $0x0
  8026a1:	6a 00                	push   $0x0
  8026a3:	6a 00                	push   $0x0
  8026a5:	6a 03                	push   $0x3
  8026a7:	e8 4b ff ff ff       	call   8025f7 <syscall>
  8026ac:	83 c4 18             	add    $0x18,%esp
}
  8026af:	c9                   	leave  
  8026b0:	c3                   	ret    

008026b1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8026b1:	55                   	push   %ebp
  8026b2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8026b4:	6a 00                	push   $0x0
  8026b6:	6a 00                	push   $0x0
  8026b8:	6a 00                	push   $0x0
  8026ba:	6a 00                	push   $0x0
  8026bc:	6a 00                	push   $0x0
  8026be:	6a 04                	push   $0x4
  8026c0:	e8 32 ff ff ff       	call   8025f7 <syscall>
  8026c5:	83 c4 18             	add    $0x18,%esp
}
  8026c8:	c9                   	leave  
  8026c9:	c3                   	ret    

008026ca <sys_env_exit>:


void sys_env_exit(void)
{
  8026ca:	55                   	push   %ebp
  8026cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8026cd:	6a 00                	push   $0x0
  8026cf:	6a 00                	push   $0x0
  8026d1:	6a 00                	push   $0x0
  8026d3:	6a 00                	push   $0x0
  8026d5:	6a 00                	push   $0x0
  8026d7:	6a 06                	push   $0x6
  8026d9:	e8 19 ff ff ff       	call   8025f7 <syscall>
  8026de:	83 c4 18             	add    $0x18,%esp
}
  8026e1:	90                   	nop
  8026e2:	c9                   	leave  
  8026e3:	c3                   	ret    

008026e4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8026e4:	55                   	push   %ebp
  8026e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8026e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8026ed:	6a 00                	push   $0x0
  8026ef:	6a 00                	push   $0x0
  8026f1:	6a 00                	push   $0x0
  8026f3:	52                   	push   %edx
  8026f4:	50                   	push   %eax
  8026f5:	6a 07                	push   $0x7
  8026f7:	e8 fb fe ff ff       	call   8025f7 <syscall>
  8026fc:	83 c4 18             	add    $0x18,%esp
}
  8026ff:	c9                   	leave  
  802700:	c3                   	ret    

00802701 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802701:	55                   	push   %ebp
  802702:	89 e5                	mov    %esp,%ebp
  802704:	56                   	push   %esi
  802705:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802706:	8b 75 18             	mov    0x18(%ebp),%esi
  802709:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80270c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80270f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802712:	8b 45 08             	mov    0x8(%ebp),%eax
  802715:	56                   	push   %esi
  802716:	53                   	push   %ebx
  802717:	51                   	push   %ecx
  802718:	52                   	push   %edx
  802719:	50                   	push   %eax
  80271a:	6a 08                	push   $0x8
  80271c:	e8 d6 fe ff ff       	call   8025f7 <syscall>
  802721:	83 c4 18             	add    $0x18,%esp
}
  802724:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802727:	5b                   	pop    %ebx
  802728:	5e                   	pop    %esi
  802729:	5d                   	pop    %ebp
  80272a:	c3                   	ret    

0080272b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80272b:	55                   	push   %ebp
  80272c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80272e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802731:	8b 45 08             	mov    0x8(%ebp),%eax
  802734:	6a 00                	push   $0x0
  802736:	6a 00                	push   $0x0
  802738:	6a 00                	push   $0x0
  80273a:	52                   	push   %edx
  80273b:	50                   	push   %eax
  80273c:	6a 09                	push   $0x9
  80273e:	e8 b4 fe ff ff       	call   8025f7 <syscall>
  802743:	83 c4 18             	add    $0x18,%esp
}
  802746:	c9                   	leave  
  802747:	c3                   	ret    

00802748 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802748:	55                   	push   %ebp
  802749:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80274b:	6a 00                	push   $0x0
  80274d:	6a 00                	push   $0x0
  80274f:	6a 00                	push   $0x0
  802751:	ff 75 0c             	pushl  0xc(%ebp)
  802754:	ff 75 08             	pushl  0x8(%ebp)
  802757:	6a 0a                	push   $0xa
  802759:	e8 99 fe ff ff       	call   8025f7 <syscall>
  80275e:	83 c4 18             	add    $0x18,%esp
}
  802761:	c9                   	leave  
  802762:	c3                   	ret    

00802763 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802763:	55                   	push   %ebp
  802764:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802766:	6a 00                	push   $0x0
  802768:	6a 00                	push   $0x0
  80276a:	6a 00                	push   $0x0
  80276c:	6a 00                	push   $0x0
  80276e:	6a 00                	push   $0x0
  802770:	6a 0b                	push   $0xb
  802772:	e8 80 fe ff ff       	call   8025f7 <syscall>
  802777:	83 c4 18             	add    $0x18,%esp
}
  80277a:	c9                   	leave  
  80277b:	c3                   	ret    

0080277c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80277c:	55                   	push   %ebp
  80277d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80277f:	6a 00                	push   $0x0
  802781:	6a 00                	push   $0x0
  802783:	6a 00                	push   $0x0
  802785:	6a 00                	push   $0x0
  802787:	6a 00                	push   $0x0
  802789:	6a 0c                	push   $0xc
  80278b:	e8 67 fe ff ff       	call   8025f7 <syscall>
  802790:	83 c4 18             	add    $0x18,%esp
}
  802793:	c9                   	leave  
  802794:	c3                   	ret    

00802795 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802795:	55                   	push   %ebp
  802796:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802798:	6a 00                	push   $0x0
  80279a:	6a 00                	push   $0x0
  80279c:	6a 00                	push   $0x0
  80279e:	6a 00                	push   $0x0
  8027a0:	6a 00                	push   $0x0
  8027a2:	6a 0d                	push   $0xd
  8027a4:	e8 4e fe ff ff       	call   8025f7 <syscall>
  8027a9:	83 c4 18             	add    $0x18,%esp
}
  8027ac:	c9                   	leave  
  8027ad:	c3                   	ret    

008027ae <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8027ae:	55                   	push   %ebp
  8027af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8027b1:	6a 00                	push   $0x0
  8027b3:	6a 00                	push   $0x0
  8027b5:	6a 00                	push   $0x0
  8027b7:	ff 75 0c             	pushl  0xc(%ebp)
  8027ba:	ff 75 08             	pushl  0x8(%ebp)
  8027bd:	6a 11                	push   $0x11
  8027bf:	e8 33 fe ff ff       	call   8025f7 <syscall>
  8027c4:	83 c4 18             	add    $0x18,%esp
	return;
  8027c7:	90                   	nop
}
  8027c8:	c9                   	leave  
  8027c9:	c3                   	ret    

008027ca <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8027ca:	55                   	push   %ebp
  8027cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8027cd:	6a 00                	push   $0x0
  8027cf:	6a 00                	push   $0x0
  8027d1:	6a 00                	push   $0x0
  8027d3:	ff 75 0c             	pushl  0xc(%ebp)
  8027d6:	ff 75 08             	pushl  0x8(%ebp)
  8027d9:	6a 12                	push   $0x12
  8027db:	e8 17 fe ff ff       	call   8025f7 <syscall>
  8027e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8027e3:	90                   	nop
}
  8027e4:	c9                   	leave  
  8027e5:	c3                   	ret    

008027e6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8027e6:	55                   	push   %ebp
  8027e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8027e9:	6a 00                	push   $0x0
  8027eb:	6a 00                	push   $0x0
  8027ed:	6a 00                	push   $0x0
  8027ef:	6a 00                	push   $0x0
  8027f1:	6a 00                	push   $0x0
  8027f3:	6a 0e                	push   $0xe
  8027f5:	e8 fd fd ff ff       	call   8025f7 <syscall>
  8027fa:	83 c4 18             	add    $0x18,%esp
}
  8027fd:	c9                   	leave  
  8027fe:	c3                   	ret    

008027ff <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8027ff:	55                   	push   %ebp
  802800:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802802:	6a 00                	push   $0x0
  802804:	6a 00                	push   $0x0
  802806:	6a 00                	push   $0x0
  802808:	6a 00                	push   $0x0
  80280a:	ff 75 08             	pushl  0x8(%ebp)
  80280d:	6a 0f                	push   $0xf
  80280f:	e8 e3 fd ff ff       	call   8025f7 <syscall>
  802814:	83 c4 18             	add    $0x18,%esp
}
  802817:	c9                   	leave  
  802818:	c3                   	ret    

00802819 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802819:	55                   	push   %ebp
  80281a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80281c:	6a 00                	push   $0x0
  80281e:	6a 00                	push   $0x0
  802820:	6a 00                	push   $0x0
  802822:	6a 00                	push   $0x0
  802824:	6a 00                	push   $0x0
  802826:	6a 10                	push   $0x10
  802828:	e8 ca fd ff ff       	call   8025f7 <syscall>
  80282d:	83 c4 18             	add    $0x18,%esp
}
  802830:	90                   	nop
  802831:	c9                   	leave  
  802832:	c3                   	ret    

00802833 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802833:	55                   	push   %ebp
  802834:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802836:	6a 00                	push   $0x0
  802838:	6a 00                	push   $0x0
  80283a:	6a 00                	push   $0x0
  80283c:	6a 00                	push   $0x0
  80283e:	6a 00                	push   $0x0
  802840:	6a 14                	push   $0x14
  802842:	e8 b0 fd ff ff       	call   8025f7 <syscall>
  802847:	83 c4 18             	add    $0x18,%esp
}
  80284a:	90                   	nop
  80284b:	c9                   	leave  
  80284c:	c3                   	ret    

0080284d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80284d:	55                   	push   %ebp
  80284e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802850:	6a 00                	push   $0x0
  802852:	6a 00                	push   $0x0
  802854:	6a 00                	push   $0x0
  802856:	6a 00                	push   $0x0
  802858:	6a 00                	push   $0x0
  80285a:	6a 15                	push   $0x15
  80285c:	e8 96 fd ff ff       	call   8025f7 <syscall>
  802861:	83 c4 18             	add    $0x18,%esp
}
  802864:	90                   	nop
  802865:	c9                   	leave  
  802866:	c3                   	ret    

00802867 <sys_cputc>:


void
sys_cputc(const char c)
{
  802867:	55                   	push   %ebp
  802868:	89 e5                	mov    %esp,%ebp
  80286a:	83 ec 04             	sub    $0x4,%esp
  80286d:	8b 45 08             	mov    0x8(%ebp),%eax
  802870:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802873:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802877:	6a 00                	push   $0x0
  802879:	6a 00                	push   $0x0
  80287b:	6a 00                	push   $0x0
  80287d:	6a 00                	push   $0x0
  80287f:	50                   	push   %eax
  802880:	6a 16                	push   $0x16
  802882:	e8 70 fd ff ff       	call   8025f7 <syscall>
  802887:	83 c4 18             	add    $0x18,%esp
}
  80288a:	90                   	nop
  80288b:	c9                   	leave  
  80288c:	c3                   	ret    

0080288d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80288d:	55                   	push   %ebp
  80288e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802890:	6a 00                	push   $0x0
  802892:	6a 00                	push   $0x0
  802894:	6a 00                	push   $0x0
  802896:	6a 00                	push   $0x0
  802898:	6a 00                	push   $0x0
  80289a:	6a 17                	push   $0x17
  80289c:	e8 56 fd ff ff       	call   8025f7 <syscall>
  8028a1:	83 c4 18             	add    $0x18,%esp
}
  8028a4:	90                   	nop
  8028a5:	c9                   	leave  
  8028a6:	c3                   	ret    

008028a7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8028a7:	55                   	push   %ebp
  8028a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8028aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8028ad:	6a 00                	push   $0x0
  8028af:	6a 00                	push   $0x0
  8028b1:	6a 00                	push   $0x0
  8028b3:	ff 75 0c             	pushl  0xc(%ebp)
  8028b6:	50                   	push   %eax
  8028b7:	6a 18                	push   $0x18
  8028b9:	e8 39 fd ff ff       	call   8025f7 <syscall>
  8028be:	83 c4 18             	add    $0x18,%esp
}
  8028c1:	c9                   	leave  
  8028c2:	c3                   	ret    

008028c3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8028c3:	55                   	push   %ebp
  8028c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8028cc:	6a 00                	push   $0x0
  8028ce:	6a 00                	push   $0x0
  8028d0:	6a 00                	push   $0x0
  8028d2:	52                   	push   %edx
  8028d3:	50                   	push   %eax
  8028d4:	6a 1b                	push   $0x1b
  8028d6:	e8 1c fd ff ff       	call   8025f7 <syscall>
  8028db:	83 c4 18             	add    $0x18,%esp
}
  8028de:	c9                   	leave  
  8028df:	c3                   	ret    

008028e0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028e0:	55                   	push   %ebp
  8028e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e9:	6a 00                	push   $0x0
  8028eb:	6a 00                	push   $0x0
  8028ed:	6a 00                	push   $0x0
  8028ef:	52                   	push   %edx
  8028f0:	50                   	push   %eax
  8028f1:	6a 19                	push   $0x19
  8028f3:	e8 ff fc ff ff       	call   8025f7 <syscall>
  8028f8:	83 c4 18             	add    $0x18,%esp
}
  8028fb:	90                   	nop
  8028fc:	c9                   	leave  
  8028fd:	c3                   	ret    

008028fe <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028fe:	55                   	push   %ebp
  8028ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802901:	8b 55 0c             	mov    0xc(%ebp),%edx
  802904:	8b 45 08             	mov    0x8(%ebp),%eax
  802907:	6a 00                	push   $0x0
  802909:	6a 00                	push   $0x0
  80290b:	6a 00                	push   $0x0
  80290d:	52                   	push   %edx
  80290e:	50                   	push   %eax
  80290f:	6a 1a                	push   $0x1a
  802911:	e8 e1 fc ff ff       	call   8025f7 <syscall>
  802916:	83 c4 18             	add    $0x18,%esp
}
  802919:	90                   	nop
  80291a:	c9                   	leave  
  80291b:	c3                   	ret    

0080291c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80291c:	55                   	push   %ebp
  80291d:	89 e5                	mov    %esp,%ebp
  80291f:	83 ec 04             	sub    $0x4,%esp
  802922:	8b 45 10             	mov    0x10(%ebp),%eax
  802925:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802928:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80292b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80292f:	8b 45 08             	mov    0x8(%ebp),%eax
  802932:	6a 00                	push   $0x0
  802934:	51                   	push   %ecx
  802935:	52                   	push   %edx
  802936:	ff 75 0c             	pushl  0xc(%ebp)
  802939:	50                   	push   %eax
  80293a:	6a 1c                	push   $0x1c
  80293c:	e8 b6 fc ff ff       	call   8025f7 <syscall>
  802941:	83 c4 18             	add    $0x18,%esp
}
  802944:	c9                   	leave  
  802945:	c3                   	ret    

00802946 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802946:	55                   	push   %ebp
  802947:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802949:	8b 55 0c             	mov    0xc(%ebp),%edx
  80294c:	8b 45 08             	mov    0x8(%ebp),%eax
  80294f:	6a 00                	push   $0x0
  802951:	6a 00                	push   $0x0
  802953:	6a 00                	push   $0x0
  802955:	52                   	push   %edx
  802956:	50                   	push   %eax
  802957:	6a 1d                	push   $0x1d
  802959:	e8 99 fc ff ff       	call   8025f7 <syscall>
  80295e:	83 c4 18             	add    $0x18,%esp
}
  802961:	c9                   	leave  
  802962:	c3                   	ret    

00802963 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802963:	55                   	push   %ebp
  802964:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802966:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80296c:	8b 45 08             	mov    0x8(%ebp),%eax
  80296f:	6a 00                	push   $0x0
  802971:	6a 00                	push   $0x0
  802973:	51                   	push   %ecx
  802974:	52                   	push   %edx
  802975:	50                   	push   %eax
  802976:	6a 1e                	push   $0x1e
  802978:	e8 7a fc ff ff       	call   8025f7 <syscall>
  80297d:	83 c4 18             	add    $0x18,%esp
}
  802980:	c9                   	leave  
  802981:	c3                   	ret    

00802982 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802982:	55                   	push   %ebp
  802983:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802985:	8b 55 0c             	mov    0xc(%ebp),%edx
  802988:	8b 45 08             	mov    0x8(%ebp),%eax
  80298b:	6a 00                	push   $0x0
  80298d:	6a 00                	push   $0x0
  80298f:	6a 00                	push   $0x0
  802991:	52                   	push   %edx
  802992:	50                   	push   %eax
  802993:	6a 1f                	push   $0x1f
  802995:	e8 5d fc ff ff       	call   8025f7 <syscall>
  80299a:	83 c4 18             	add    $0x18,%esp
}
  80299d:	c9                   	leave  
  80299e:	c3                   	ret    

0080299f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80299f:	55                   	push   %ebp
  8029a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8029a2:	6a 00                	push   $0x0
  8029a4:	6a 00                	push   $0x0
  8029a6:	6a 00                	push   $0x0
  8029a8:	6a 00                	push   $0x0
  8029aa:	6a 00                	push   $0x0
  8029ac:	6a 20                	push   $0x20
  8029ae:	e8 44 fc ff ff       	call   8025f7 <syscall>
  8029b3:	83 c4 18             	add    $0x18,%esp
}
  8029b6:	c9                   	leave  
  8029b7:	c3                   	ret    

008029b8 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8029b8:	55                   	push   %ebp
  8029b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8029bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8029be:	6a 00                	push   $0x0
  8029c0:	6a 00                	push   $0x0
  8029c2:	ff 75 10             	pushl  0x10(%ebp)
  8029c5:	ff 75 0c             	pushl  0xc(%ebp)
  8029c8:	50                   	push   %eax
  8029c9:	6a 21                	push   $0x21
  8029cb:	e8 27 fc ff ff       	call   8025f7 <syscall>
  8029d0:	83 c4 18             	add    $0x18,%esp
}
  8029d3:	c9                   	leave  
  8029d4:	c3                   	ret    

008029d5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8029d5:	55                   	push   %ebp
  8029d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8029d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8029db:	6a 00                	push   $0x0
  8029dd:	6a 00                	push   $0x0
  8029df:	6a 00                	push   $0x0
  8029e1:	6a 00                	push   $0x0
  8029e3:	50                   	push   %eax
  8029e4:	6a 22                	push   $0x22
  8029e6:	e8 0c fc ff ff       	call   8025f7 <syscall>
  8029eb:	83 c4 18             	add    $0x18,%esp
}
  8029ee:	90                   	nop
  8029ef:	c9                   	leave  
  8029f0:	c3                   	ret    

008029f1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8029f1:	55                   	push   %ebp
  8029f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8029f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f7:	6a 00                	push   $0x0
  8029f9:	6a 00                	push   $0x0
  8029fb:	6a 00                	push   $0x0
  8029fd:	6a 00                	push   $0x0
  8029ff:	50                   	push   %eax
  802a00:	6a 23                	push   $0x23
  802a02:	e8 f0 fb ff ff       	call   8025f7 <syscall>
  802a07:	83 c4 18             	add    $0x18,%esp
}
  802a0a:	90                   	nop
  802a0b:	c9                   	leave  
  802a0c:	c3                   	ret    

00802a0d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802a0d:	55                   	push   %ebp
  802a0e:	89 e5                	mov    %esp,%ebp
  802a10:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802a13:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a16:	8d 50 04             	lea    0x4(%eax),%edx
  802a19:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a1c:	6a 00                	push   $0x0
  802a1e:	6a 00                	push   $0x0
  802a20:	6a 00                	push   $0x0
  802a22:	52                   	push   %edx
  802a23:	50                   	push   %eax
  802a24:	6a 24                	push   $0x24
  802a26:	e8 cc fb ff ff       	call   8025f7 <syscall>
  802a2b:	83 c4 18             	add    $0x18,%esp
	return result;
  802a2e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802a31:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802a34:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a37:	89 01                	mov    %eax,(%ecx)
  802a39:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3f:	c9                   	leave  
  802a40:	c2 04 00             	ret    $0x4

00802a43 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802a43:	55                   	push   %ebp
  802a44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802a46:	6a 00                	push   $0x0
  802a48:	6a 00                	push   $0x0
  802a4a:	ff 75 10             	pushl  0x10(%ebp)
  802a4d:	ff 75 0c             	pushl  0xc(%ebp)
  802a50:	ff 75 08             	pushl  0x8(%ebp)
  802a53:	6a 13                	push   $0x13
  802a55:	e8 9d fb ff ff       	call   8025f7 <syscall>
  802a5a:	83 c4 18             	add    $0x18,%esp
	return ;
  802a5d:	90                   	nop
}
  802a5e:	c9                   	leave  
  802a5f:	c3                   	ret    

00802a60 <sys_rcr2>:
uint32 sys_rcr2()
{
  802a60:	55                   	push   %ebp
  802a61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802a63:	6a 00                	push   $0x0
  802a65:	6a 00                	push   $0x0
  802a67:	6a 00                	push   $0x0
  802a69:	6a 00                	push   $0x0
  802a6b:	6a 00                	push   $0x0
  802a6d:	6a 25                	push   $0x25
  802a6f:	e8 83 fb ff ff       	call   8025f7 <syscall>
  802a74:	83 c4 18             	add    $0x18,%esp
}
  802a77:	c9                   	leave  
  802a78:	c3                   	ret    

00802a79 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802a79:	55                   	push   %ebp
  802a7a:	89 e5                	mov    %esp,%ebp
  802a7c:	83 ec 04             	sub    $0x4,%esp
  802a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  802a82:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802a85:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802a89:	6a 00                	push   $0x0
  802a8b:	6a 00                	push   $0x0
  802a8d:	6a 00                	push   $0x0
  802a8f:	6a 00                	push   $0x0
  802a91:	50                   	push   %eax
  802a92:	6a 26                	push   $0x26
  802a94:	e8 5e fb ff ff       	call   8025f7 <syscall>
  802a99:	83 c4 18             	add    $0x18,%esp
	return ;
  802a9c:	90                   	nop
}
  802a9d:	c9                   	leave  
  802a9e:	c3                   	ret    

00802a9f <rsttst>:
void rsttst()
{
  802a9f:	55                   	push   %ebp
  802aa0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802aa2:	6a 00                	push   $0x0
  802aa4:	6a 00                	push   $0x0
  802aa6:	6a 00                	push   $0x0
  802aa8:	6a 00                	push   $0x0
  802aaa:	6a 00                	push   $0x0
  802aac:	6a 28                	push   $0x28
  802aae:	e8 44 fb ff ff       	call   8025f7 <syscall>
  802ab3:	83 c4 18             	add    $0x18,%esp
	return ;
  802ab6:	90                   	nop
}
  802ab7:	c9                   	leave  
  802ab8:	c3                   	ret    

00802ab9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802ab9:	55                   	push   %ebp
  802aba:	89 e5                	mov    %esp,%ebp
  802abc:	83 ec 04             	sub    $0x4,%esp
  802abf:	8b 45 14             	mov    0x14(%ebp),%eax
  802ac2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802ac5:	8b 55 18             	mov    0x18(%ebp),%edx
  802ac8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802acc:	52                   	push   %edx
  802acd:	50                   	push   %eax
  802ace:	ff 75 10             	pushl  0x10(%ebp)
  802ad1:	ff 75 0c             	pushl  0xc(%ebp)
  802ad4:	ff 75 08             	pushl  0x8(%ebp)
  802ad7:	6a 27                	push   $0x27
  802ad9:	e8 19 fb ff ff       	call   8025f7 <syscall>
  802ade:	83 c4 18             	add    $0x18,%esp
	return ;
  802ae1:	90                   	nop
}
  802ae2:	c9                   	leave  
  802ae3:	c3                   	ret    

00802ae4 <chktst>:
void chktst(uint32 n)
{
  802ae4:	55                   	push   %ebp
  802ae5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802ae7:	6a 00                	push   $0x0
  802ae9:	6a 00                	push   $0x0
  802aeb:	6a 00                	push   $0x0
  802aed:	6a 00                	push   $0x0
  802aef:	ff 75 08             	pushl  0x8(%ebp)
  802af2:	6a 29                	push   $0x29
  802af4:	e8 fe fa ff ff       	call   8025f7 <syscall>
  802af9:	83 c4 18             	add    $0x18,%esp
	return ;
  802afc:	90                   	nop
}
  802afd:	c9                   	leave  
  802afe:	c3                   	ret    

00802aff <inctst>:

void inctst()
{
  802aff:	55                   	push   %ebp
  802b00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802b02:	6a 00                	push   $0x0
  802b04:	6a 00                	push   $0x0
  802b06:	6a 00                	push   $0x0
  802b08:	6a 00                	push   $0x0
  802b0a:	6a 00                	push   $0x0
  802b0c:	6a 2a                	push   $0x2a
  802b0e:	e8 e4 fa ff ff       	call   8025f7 <syscall>
  802b13:	83 c4 18             	add    $0x18,%esp
	return ;
  802b16:	90                   	nop
}
  802b17:	c9                   	leave  
  802b18:	c3                   	ret    

00802b19 <gettst>:
uint32 gettst()
{
  802b19:	55                   	push   %ebp
  802b1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802b1c:	6a 00                	push   $0x0
  802b1e:	6a 00                	push   $0x0
  802b20:	6a 00                	push   $0x0
  802b22:	6a 00                	push   $0x0
  802b24:	6a 00                	push   $0x0
  802b26:	6a 2b                	push   $0x2b
  802b28:	e8 ca fa ff ff       	call   8025f7 <syscall>
  802b2d:	83 c4 18             	add    $0x18,%esp
}
  802b30:	c9                   	leave  
  802b31:	c3                   	ret    

00802b32 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802b32:	55                   	push   %ebp
  802b33:	89 e5                	mov    %esp,%ebp
  802b35:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b38:	6a 00                	push   $0x0
  802b3a:	6a 00                	push   $0x0
  802b3c:	6a 00                	push   $0x0
  802b3e:	6a 00                	push   $0x0
  802b40:	6a 00                	push   $0x0
  802b42:	6a 2c                	push   $0x2c
  802b44:	e8 ae fa ff ff       	call   8025f7 <syscall>
  802b49:	83 c4 18             	add    $0x18,%esp
  802b4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802b4f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802b53:	75 07                	jne    802b5c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802b55:	b8 01 00 00 00       	mov    $0x1,%eax
  802b5a:	eb 05                	jmp    802b61 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802b5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b61:	c9                   	leave  
  802b62:	c3                   	ret    

00802b63 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802b63:	55                   	push   %ebp
  802b64:	89 e5                	mov    %esp,%ebp
  802b66:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b69:	6a 00                	push   $0x0
  802b6b:	6a 00                	push   $0x0
  802b6d:	6a 00                	push   $0x0
  802b6f:	6a 00                	push   $0x0
  802b71:	6a 00                	push   $0x0
  802b73:	6a 2c                	push   $0x2c
  802b75:	e8 7d fa ff ff       	call   8025f7 <syscall>
  802b7a:	83 c4 18             	add    $0x18,%esp
  802b7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802b80:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802b84:	75 07                	jne    802b8d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802b86:	b8 01 00 00 00       	mov    $0x1,%eax
  802b8b:	eb 05                	jmp    802b92 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802b8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b92:	c9                   	leave  
  802b93:	c3                   	ret    

00802b94 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802b94:	55                   	push   %ebp
  802b95:	89 e5                	mov    %esp,%ebp
  802b97:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b9a:	6a 00                	push   $0x0
  802b9c:	6a 00                	push   $0x0
  802b9e:	6a 00                	push   $0x0
  802ba0:	6a 00                	push   $0x0
  802ba2:	6a 00                	push   $0x0
  802ba4:	6a 2c                	push   $0x2c
  802ba6:	e8 4c fa ff ff       	call   8025f7 <syscall>
  802bab:	83 c4 18             	add    $0x18,%esp
  802bae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802bb1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802bb5:	75 07                	jne    802bbe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802bb7:	b8 01 00 00 00       	mov    $0x1,%eax
  802bbc:	eb 05                	jmp    802bc3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802bbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bc3:	c9                   	leave  
  802bc4:	c3                   	ret    

00802bc5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802bc5:	55                   	push   %ebp
  802bc6:	89 e5                	mov    %esp,%ebp
  802bc8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bcb:	6a 00                	push   $0x0
  802bcd:	6a 00                	push   $0x0
  802bcf:	6a 00                	push   $0x0
  802bd1:	6a 00                	push   $0x0
  802bd3:	6a 00                	push   $0x0
  802bd5:	6a 2c                	push   $0x2c
  802bd7:	e8 1b fa ff ff       	call   8025f7 <syscall>
  802bdc:	83 c4 18             	add    $0x18,%esp
  802bdf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802be2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802be6:	75 07                	jne    802bef <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802be8:	b8 01 00 00 00       	mov    $0x1,%eax
  802bed:	eb 05                	jmp    802bf4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802bef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bf4:	c9                   	leave  
  802bf5:	c3                   	ret    

00802bf6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802bf6:	55                   	push   %ebp
  802bf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802bf9:	6a 00                	push   $0x0
  802bfb:	6a 00                	push   $0x0
  802bfd:	6a 00                	push   $0x0
  802bff:	6a 00                	push   $0x0
  802c01:	ff 75 08             	pushl  0x8(%ebp)
  802c04:	6a 2d                	push   $0x2d
  802c06:	e8 ec f9 ff ff       	call   8025f7 <syscall>
  802c0b:	83 c4 18             	add    $0x18,%esp
	return ;
  802c0e:	90                   	nop
}
  802c0f:	c9                   	leave  
  802c10:	c3                   	ret    
  802c11:	66 90                	xchg   %ax,%ax
  802c13:	90                   	nop

00802c14 <__udivdi3>:
  802c14:	55                   	push   %ebp
  802c15:	57                   	push   %edi
  802c16:	56                   	push   %esi
  802c17:	53                   	push   %ebx
  802c18:	83 ec 1c             	sub    $0x1c,%esp
  802c1b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802c1f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802c23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802c27:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802c2b:	89 ca                	mov    %ecx,%edx
  802c2d:	89 f8                	mov    %edi,%eax
  802c2f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802c33:	85 f6                	test   %esi,%esi
  802c35:	75 2d                	jne    802c64 <__udivdi3+0x50>
  802c37:	39 cf                	cmp    %ecx,%edi
  802c39:	77 65                	ja     802ca0 <__udivdi3+0x8c>
  802c3b:	89 fd                	mov    %edi,%ebp
  802c3d:	85 ff                	test   %edi,%edi
  802c3f:	75 0b                	jne    802c4c <__udivdi3+0x38>
  802c41:	b8 01 00 00 00       	mov    $0x1,%eax
  802c46:	31 d2                	xor    %edx,%edx
  802c48:	f7 f7                	div    %edi
  802c4a:	89 c5                	mov    %eax,%ebp
  802c4c:	31 d2                	xor    %edx,%edx
  802c4e:	89 c8                	mov    %ecx,%eax
  802c50:	f7 f5                	div    %ebp
  802c52:	89 c1                	mov    %eax,%ecx
  802c54:	89 d8                	mov    %ebx,%eax
  802c56:	f7 f5                	div    %ebp
  802c58:	89 cf                	mov    %ecx,%edi
  802c5a:	89 fa                	mov    %edi,%edx
  802c5c:	83 c4 1c             	add    $0x1c,%esp
  802c5f:	5b                   	pop    %ebx
  802c60:	5e                   	pop    %esi
  802c61:	5f                   	pop    %edi
  802c62:	5d                   	pop    %ebp
  802c63:	c3                   	ret    
  802c64:	39 ce                	cmp    %ecx,%esi
  802c66:	77 28                	ja     802c90 <__udivdi3+0x7c>
  802c68:	0f bd fe             	bsr    %esi,%edi
  802c6b:	83 f7 1f             	xor    $0x1f,%edi
  802c6e:	75 40                	jne    802cb0 <__udivdi3+0x9c>
  802c70:	39 ce                	cmp    %ecx,%esi
  802c72:	72 0a                	jb     802c7e <__udivdi3+0x6a>
  802c74:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802c78:	0f 87 9e 00 00 00    	ja     802d1c <__udivdi3+0x108>
  802c7e:	b8 01 00 00 00       	mov    $0x1,%eax
  802c83:	89 fa                	mov    %edi,%edx
  802c85:	83 c4 1c             	add    $0x1c,%esp
  802c88:	5b                   	pop    %ebx
  802c89:	5e                   	pop    %esi
  802c8a:	5f                   	pop    %edi
  802c8b:	5d                   	pop    %ebp
  802c8c:	c3                   	ret    
  802c8d:	8d 76 00             	lea    0x0(%esi),%esi
  802c90:	31 ff                	xor    %edi,%edi
  802c92:	31 c0                	xor    %eax,%eax
  802c94:	89 fa                	mov    %edi,%edx
  802c96:	83 c4 1c             	add    $0x1c,%esp
  802c99:	5b                   	pop    %ebx
  802c9a:	5e                   	pop    %esi
  802c9b:	5f                   	pop    %edi
  802c9c:	5d                   	pop    %ebp
  802c9d:	c3                   	ret    
  802c9e:	66 90                	xchg   %ax,%ax
  802ca0:	89 d8                	mov    %ebx,%eax
  802ca2:	f7 f7                	div    %edi
  802ca4:	31 ff                	xor    %edi,%edi
  802ca6:	89 fa                	mov    %edi,%edx
  802ca8:	83 c4 1c             	add    $0x1c,%esp
  802cab:	5b                   	pop    %ebx
  802cac:	5e                   	pop    %esi
  802cad:	5f                   	pop    %edi
  802cae:	5d                   	pop    %ebp
  802caf:	c3                   	ret    
  802cb0:	bd 20 00 00 00       	mov    $0x20,%ebp
  802cb5:	89 eb                	mov    %ebp,%ebx
  802cb7:	29 fb                	sub    %edi,%ebx
  802cb9:	89 f9                	mov    %edi,%ecx
  802cbb:	d3 e6                	shl    %cl,%esi
  802cbd:	89 c5                	mov    %eax,%ebp
  802cbf:	88 d9                	mov    %bl,%cl
  802cc1:	d3 ed                	shr    %cl,%ebp
  802cc3:	89 e9                	mov    %ebp,%ecx
  802cc5:	09 f1                	or     %esi,%ecx
  802cc7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802ccb:	89 f9                	mov    %edi,%ecx
  802ccd:	d3 e0                	shl    %cl,%eax
  802ccf:	89 c5                	mov    %eax,%ebp
  802cd1:	89 d6                	mov    %edx,%esi
  802cd3:	88 d9                	mov    %bl,%cl
  802cd5:	d3 ee                	shr    %cl,%esi
  802cd7:	89 f9                	mov    %edi,%ecx
  802cd9:	d3 e2                	shl    %cl,%edx
  802cdb:	8b 44 24 08          	mov    0x8(%esp),%eax
  802cdf:	88 d9                	mov    %bl,%cl
  802ce1:	d3 e8                	shr    %cl,%eax
  802ce3:	09 c2                	or     %eax,%edx
  802ce5:	89 d0                	mov    %edx,%eax
  802ce7:	89 f2                	mov    %esi,%edx
  802ce9:	f7 74 24 0c          	divl   0xc(%esp)
  802ced:	89 d6                	mov    %edx,%esi
  802cef:	89 c3                	mov    %eax,%ebx
  802cf1:	f7 e5                	mul    %ebp
  802cf3:	39 d6                	cmp    %edx,%esi
  802cf5:	72 19                	jb     802d10 <__udivdi3+0xfc>
  802cf7:	74 0b                	je     802d04 <__udivdi3+0xf0>
  802cf9:	89 d8                	mov    %ebx,%eax
  802cfb:	31 ff                	xor    %edi,%edi
  802cfd:	e9 58 ff ff ff       	jmp    802c5a <__udivdi3+0x46>
  802d02:	66 90                	xchg   %ax,%ax
  802d04:	8b 54 24 08          	mov    0x8(%esp),%edx
  802d08:	89 f9                	mov    %edi,%ecx
  802d0a:	d3 e2                	shl    %cl,%edx
  802d0c:	39 c2                	cmp    %eax,%edx
  802d0e:	73 e9                	jae    802cf9 <__udivdi3+0xe5>
  802d10:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802d13:	31 ff                	xor    %edi,%edi
  802d15:	e9 40 ff ff ff       	jmp    802c5a <__udivdi3+0x46>
  802d1a:	66 90                	xchg   %ax,%ax
  802d1c:	31 c0                	xor    %eax,%eax
  802d1e:	e9 37 ff ff ff       	jmp    802c5a <__udivdi3+0x46>
  802d23:	90                   	nop

00802d24 <__umoddi3>:
  802d24:	55                   	push   %ebp
  802d25:	57                   	push   %edi
  802d26:	56                   	push   %esi
  802d27:	53                   	push   %ebx
  802d28:	83 ec 1c             	sub    $0x1c,%esp
  802d2b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802d2f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802d37:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802d3b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802d3f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802d43:	89 f3                	mov    %esi,%ebx
  802d45:	89 fa                	mov    %edi,%edx
  802d47:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802d4b:	89 34 24             	mov    %esi,(%esp)
  802d4e:	85 c0                	test   %eax,%eax
  802d50:	75 1a                	jne    802d6c <__umoddi3+0x48>
  802d52:	39 f7                	cmp    %esi,%edi
  802d54:	0f 86 a2 00 00 00    	jbe    802dfc <__umoddi3+0xd8>
  802d5a:	89 c8                	mov    %ecx,%eax
  802d5c:	89 f2                	mov    %esi,%edx
  802d5e:	f7 f7                	div    %edi
  802d60:	89 d0                	mov    %edx,%eax
  802d62:	31 d2                	xor    %edx,%edx
  802d64:	83 c4 1c             	add    $0x1c,%esp
  802d67:	5b                   	pop    %ebx
  802d68:	5e                   	pop    %esi
  802d69:	5f                   	pop    %edi
  802d6a:	5d                   	pop    %ebp
  802d6b:	c3                   	ret    
  802d6c:	39 f0                	cmp    %esi,%eax
  802d6e:	0f 87 ac 00 00 00    	ja     802e20 <__umoddi3+0xfc>
  802d74:	0f bd e8             	bsr    %eax,%ebp
  802d77:	83 f5 1f             	xor    $0x1f,%ebp
  802d7a:	0f 84 ac 00 00 00    	je     802e2c <__umoddi3+0x108>
  802d80:	bf 20 00 00 00       	mov    $0x20,%edi
  802d85:	29 ef                	sub    %ebp,%edi
  802d87:	89 fe                	mov    %edi,%esi
  802d89:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802d8d:	89 e9                	mov    %ebp,%ecx
  802d8f:	d3 e0                	shl    %cl,%eax
  802d91:	89 d7                	mov    %edx,%edi
  802d93:	89 f1                	mov    %esi,%ecx
  802d95:	d3 ef                	shr    %cl,%edi
  802d97:	09 c7                	or     %eax,%edi
  802d99:	89 e9                	mov    %ebp,%ecx
  802d9b:	d3 e2                	shl    %cl,%edx
  802d9d:	89 14 24             	mov    %edx,(%esp)
  802da0:	89 d8                	mov    %ebx,%eax
  802da2:	d3 e0                	shl    %cl,%eax
  802da4:	89 c2                	mov    %eax,%edx
  802da6:	8b 44 24 08          	mov    0x8(%esp),%eax
  802daa:	d3 e0                	shl    %cl,%eax
  802dac:	89 44 24 04          	mov    %eax,0x4(%esp)
  802db0:	8b 44 24 08          	mov    0x8(%esp),%eax
  802db4:	89 f1                	mov    %esi,%ecx
  802db6:	d3 e8                	shr    %cl,%eax
  802db8:	09 d0                	or     %edx,%eax
  802dba:	d3 eb                	shr    %cl,%ebx
  802dbc:	89 da                	mov    %ebx,%edx
  802dbe:	f7 f7                	div    %edi
  802dc0:	89 d3                	mov    %edx,%ebx
  802dc2:	f7 24 24             	mull   (%esp)
  802dc5:	89 c6                	mov    %eax,%esi
  802dc7:	89 d1                	mov    %edx,%ecx
  802dc9:	39 d3                	cmp    %edx,%ebx
  802dcb:	0f 82 87 00 00 00    	jb     802e58 <__umoddi3+0x134>
  802dd1:	0f 84 91 00 00 00    	je     802e68 <__umoddi3+0x144>
  802dd7:	8b 54 24 04          	mov    0x4(%esp),%edx
  802ddb:	29 f2                	sub    %esi,%edx
  802ddd:	19 cb                	sbb    %ecx,%ebx
  802ddf:	89 d8                	mov    %ebx,%eax
  802de1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802de5:	d3 e0                	shl    %cl,%eax
  802de7:	89 e9                	mov    %ebp,%ecx
  802de9:	d3 ea                	shr    %cl,%edx
  802deb:	09 d0                	or     %edx,%eax
  802ded:	89 e9                	mov    %ebp,%ecx
  802def:	d3 eb                	shr    %cl,%ebx
  802df1:	89 da                	mov    %ebx,%edx
  802df3:	83 c4 1c             	add    $0x1c,%esp
  802df6:	5b                   	pop    %ebx
  802df7:	5e                   	pop    %esi
  802df8:	5f                   	pop    %edi
  802df9:	5d                   	pop    %ebp
  802dfa:	c3                   	ret    
  802dfb:	90                   	nop
  802dfc:	89 fd                	mov    %edi,%ebp
  802dfe:	85 ff                	test   %edi,%edi
  802e00:	75 0b                	jne    802e0d <__umoddi3+0xe9>
  802e02:	b8 01 00 00 00       	mov    $0x1,%eax
  802e07:	31 d2                	xor    %edx,%edx
  802e09:	f7 f7                	div    %edi
  802e0b:	89 c5                	mov    %eax,%ebp
  802e0d:	89 f0                	mov    %esi,%eax
  802e0f:	31 d2                	xor    %edx,%edx
  802e11:	f7 f5                	div    %ebp
  802e13:	89 c8                	mov    %ecx,%eax
  802e15:	f7 f5                	div    %ebp
  802e17:	89 d0                	mov    %edx,%eax
  802e19:	e9 44 ff ff ff       	jmp    802d62 <__umoddi3+0x3e>
  802e1e:	66 90                	xchg   %ax,%ax
  802e20:	89 c8                	mov    %ecx,%eax
  802e22:	89 f2                	mov    %esi,%edx
  802e24:	83 c4 1c             	add    $0x1c,%esp
  802e27:	5b                   	pop    %ebx
  802e28:	5e                   	pop    %esi
  802e29:	5f                   	pop    %edi
  802e2a:	5d                   	pop    %ebp
  802e2b:	c3                   	ret    
  802e2c:	3b 04 24             	cmp    (%esp),%eax
  802e2f:	72 06                	jb     802e37 <__umoddi3+0x113>
  802e31:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802e35:	77 0f                	ja     802e46 <__umoddi3+0x122>
  802e37:	89 f2                	mov    %esi,%edx
  802e39:	29 f9                	sub    %edi,%ecx
  802e3b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802e3f:	89 14 24             	mov    %edx,(%esp)
  802e42:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802e46:	8b 44 24 04          	mov    0x4(%esp),%eax
  802e4a:	8b 14 24             	mov    (%esp),%edx
  802e4d:	83 c4 1c             	add    $0x1c,%esp
  802e50:	5b                   	pop    %ebx
  802e51:	5e                   	pop    %esi
  802e52:	5f                   	pop    %edi
  802e53:	5d                   	pop    %ebp
  802e54:	c3                   	ret    
  802e55:	8d 76 00             	lea    0x0(%esi),%esi
  802e58:	2b 04 24             	sub    (%esp),%eax
  802e5b:	19 fa                	sbb    %edi,%edx
  802e5d:	89 d1                	mov    %edx,%ecx
  802e5f:	89 c6                	mov    %eax,%esi
  802e61:	e9 71 ff ff ff       	jmp    802dd7 <__umoddi3+0xb3>
  802e66:	66 90                	xchg   %ax,%ax
  802e68:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802e6c:	72 ea                	jb     802e58 <__umoddi3+0x134>
  802e6e:	89 d9                	mov    %ebx,%ecx
  802e70:	e9 62 ff ff ff       	jmp    802dd7 <__umoddi3+0xb3>
