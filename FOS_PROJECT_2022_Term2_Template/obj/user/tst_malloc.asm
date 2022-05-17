
obj/user/tst_malloc:     file format elf32-i386


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
  800031:	e8 ee 03 00 00       	call   800424 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
///MAKE SURE PAGE_WS_MAX_SIZE = 15
///MAKE SURE TABLE_WS_MAX_SIZE = 15
#include <inc/lib.h>

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
//	cprintf("envID = %d\n",envID);

	
	

	int Mega = 1024*1024;
  80003f:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  800046:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)


	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80004d:	e8 4a 1a 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800052:	89 45 ec             	mov    %eax,-0x14(%ebp)
	{
		int freeFrames = sys_calculate_free_frames() ;
  800055:	e8 bf 19 00 00       	call   801a19 <sys_calculate_free_frames>
  80005a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80005d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800060:	01 c0                	add    %eax,%eax
  800062:	83 ec 0c             	sub    $0xc,%esp
  800065:	50                   	push   %eax
  800066:	e8 eb 16 00 00       	call   801756 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800073:	74 14                	je     800089 <_main+0x51>
  800075:	83 ec 04             	sub    $0x4,%esp
  800078:	68 40 21 80 00       	push   $0x802140
  80007d:	6a 14                	push   $0x14
  80007f:	68 a5 21 80 00       	push   $0x8021a5
  800084:	e8 aa 04 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800089:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80008c:	e8 88 19 00 00       	call   801a19 <sys_calculate_free_frames>
  800091:	29 c3                	sub    %eax,%ebx
  800093:	89 d8                	mov    %ebx,%eax
  800095:	83 f8 01             	cmp    $0x1,%eax
  800098:	74 14                	je     8000ae <_main+0x76>
  80009a:	83 ec 04             	sub    $0x4,%esp
  80009d:	68 b8 21 80 00       	push   $0x8021b8
  8000a2:	6a 15                	push   $0x15
  8000a4:	68 a5 21 80 00       	push   $0x8021a5
  8000a9:	e8 85 04 00 00       	call   800533 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8000ae:	e8 66 19 00 00       	call   801a19 <sys_calculate_free_frames>
  8000b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START + 2*Mega) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8000b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	83 ec 0c             	sub    $0xc,%esp
  8000be:	50                   	push   %eax
  8000bf:	e8 92 16 00 00       	call   801756 <malloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 c2                	mov    %eax,%edx
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	01 c0                	add    %eax,%eax
  8000ce:	05 00 00 00 80       	add    $0x80000000,%eax
  8000d3:	39 c2                	cmp    %eax,%edx
  8000d5:	74 14                	je     8000eb <_main+0xb3>
  8000d7:	83 ec 04             	sub    $0x4,%esp
  8000da:	68 40 21 80 00       	push   $0x802140
  8000df:	6a 18                	push   $0x18
  8000e1:	68 a5 21 80 00       	push   $0x8021a5
  8000e6:	e8 48 04 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000eb:	e8 29 19 00 00       	call   801a19 <sys_calculate_free_frames>
  8000f0:	89 c2                	mov    %eax,%edx
  8000f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f5:	39 c2                	cmp    %eax,%edx
  8000f7:	74 14                	je     80010d <_main+0xd5>
  8000f9:	83 ec 04             	sub    $0x4,%esp
  8000fc:	68 b8 21 80 00       	push   $0x8021b8
  800101:	6a 19                	push   $0x19
  800103:	68 a5 21 80 00       	push   $0x8021a5
  800108:	e8 26 04 00 00       	call   800533 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80010d:	e8 07 19 00 00       	call   801a19 <sys_calculate_free_frames>
  800112:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*kilo) != USER_HEAP_START+ 4*Mega) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800115:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800118:	01 c0                	add    %eax,%eax
  80011a:	83 ec 0c             	sub    $0xc,%esp
  80011d:	50                   	push   %eax
  80011e:	e8 33 16 00 00       	call   801756 <malloc>
  800123:	83 c4 10             	add    $0x10,%esp
  800126:	89 c2                	mov    %eax,%edx
  800128:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80012b:	c1 e0 02             	shl    $0x2,%eax
  80012e:	05 00 00 00 80       	add    $0x80000000,%eax
  800133:	39 c2                	cmp    %eax,%edx
  800135:	74 14                	je     80014b <_main+0x113>
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	68 40 21 80 00       	push   $0x802140
  80013f:	6a 1c                	push   $0x1c
  800141:	68 a5 21 80 00       	push   $0x8021a5
  800146:	e8 e8 03 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80014b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80014e:	e8 c6 18 00 00       	call   801a19 <sys_calculate_free_frames>
  800153:	29 c3                	sub    %eax,%ebx
  800155:	89 d8                	mov    %ebx,%eax
  800157:	83 f8 01             	cmp    $0x1,%eax
  80015a:	74 14                	je     800170 <_main+0x138>
  80015c:	83 ec 04             	sub    $0x4,%esp
  80015f:	68 b8 21 80 00       	push   $0x8021b8
  800164:	6a 1d                	push   $0x1d
  800166:	68 a5 21 80 00       	push   $0x8021a5
  80016b:	e8 c3 03 00 00       	call   800533 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800170:	e8 a4 18 00 00       	call   801a19 <sys_calculate_free_frames>
  800175:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(3*kilo) != USER_HEAP_START+ 4*Mega+ 2*kilo) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800178:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80017b:	89 c2                	mov    %eax,%edx
  80017d:	01 d2                	add    %edx,%edx
  80017f:	01 d0                	add    %edx,%eax
  800181:	83 ec 0c             	sub    $0xc,%esp
  800184:	50                   	push   %eax
  800185:	e8 cc 15 00 00       	call   801756 <malloc>
  80018a:	83 c4 10             	add    $0x10,%esp
  80018d:	89 c2                	mov    %eax,%edx
  80018f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800192:	c1 e0 02             	shl    $0x2,%eax
  800195:	89 c1                	mov    %eax,%ecx
  800197:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80019a:	01 c0                	add    %eax,%eax
  80019c:	01 c8                	add    %ecx,%eax
  80019e:	05 00 00 00 80       	add    $0x80000000,%eax
  8001a3:	39 c2                	cmp    %eax,%edx
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 40 21 80 00       	push   $0x802140
  8001af:	6a 20                	push   $0x20
  8001b1:	68 a5 21 80 00       	push   $0x8021a5
  8001b6:	e8 78 03 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0)panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001bb:	e8 59 18 00 00       	call   801a19 <sys_calculate_free_frames>
  8001c0:	89 c2                	mov    %eax,%edx
  8001c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001c5:	39 c2                	cmp    %eax,%edx
  8001c7:	74 14                	je     8001dd <_main+0x1a5>
  8001c9:	83 ec 04             	sub    $0x4,%esp
  8001cc:	68 b8 21 80 00       	push   $0x8021b8
  8001d1:	6a 21                	push   $0x21
  8001d3:	68 a5 21 80 00       	push   $0x8021a5
  8001d8:	e8 56 03 00 00       	call   800533 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8001dd:	e8 37 18 00 00       	call   801a19 <sys_calculate_free_frames>
  8001e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(3*Mega) != USER_HEAP_START + 4*Mega + 5*kilo)  panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8001e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e8:	89 c2                	mov    %eax,%edx
  8001ea:	01 d2                	add    %edx,%edx
  8001ec:	01 d0                	add    %edx,%eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	50                   	push   %eax
  8001f2:	e8 5f 15 00 00       	call   801756 <malloc>
  8001f7:	83 c4 10             	add    $0x10,%esp
  8001fa:	89 c1                	mov    %eax,%ecx
  8001fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001ff:	c1 e0 02             	shl    $0x2,%eax
  800202:	89 c3                	mov    %eax,%ebx
  800204:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800207:	89 d0                	mov    %edx,%eax
  800209:	c1 e0 02             	shl    $0x2,%eax
  80020c:	01 d0                	add    %edx,%eax
  80020e:	01 d8                	add    %ebx,%eax
  800210:	05 00 00 00 80       	add    $0x80000000,%eax
  800215:	39 c1                	cmp    %eax,%ecx
  800217:	74 14                	je     80022d <_main+0x1f5>
  800219:	83 ec 04             	sub    $0x4,%esp
  80021c:	68 40 21 80 00       	push   $0x802140
  800221:	6a 24                	push   $0x24
  800223:	68 a5 21 80 00       	push   $0x8021a5
  800228:	e8 06 03 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80022d:	e8 e7 17 00 00       	call   801a19 <sys_calculate_free_frames>
  800232:	89 c2                	mov    %eax,%edx
  800234:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800237:	39 c2                	cmp    %eax,%edx
  800239:	74 14                	je     80024f <_main+0x217>
  80023b:	83 ec 04             	sub    $0x4,%esp
  80023e:	68 b8 21 80 00       	push   $0x8021b8
  800243:	6a 25                	push   $0x25
  800245:	68 a5 21 80 00       	push   $0x8021a5
  80024a:	e8 e4 02 00 00       	call   800533 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80024f:	e8 c5 17 00 00       	call   801a19 <sys_calculate_free_frames>
  800254:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START + 7*Mega  + 5*kilo) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800257:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80025a:	01 c0                	add    %eax,%eax
  80025c:	83 ec 0c             	sub    $0xc,%esp
  80025f:	50                   	push   %eax
  800260:	e8 f1 14 00 00       	call   801756 <malloc>
  800265:	83 c4 10             	add    $0x10,%esp
  800268:	89 c1                	mov    %eax,%ecx
  80026a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80026d:	89 d0                	mov    %edx,%eax
  80026f:	01 c0                	add    %eax,%eax
  800271:	01 d0                	add    %edx,%eax
  800273:	01 c0                	add    %eax,%eax
  800275:	01 d0                	add    %edx,%eax
  800277:	89 c3                	mov    %eax,%ebx
  800279:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80027c:	89 d0                	mov    %edx,%eax
  80027e:	c1 e0 02             	shl    $0x2,%eax
  800281:	01 d0                	add    %edx,%eax
  800283:	01 d8                	add    %ebx,%eax
  800285:	05 00 00 00 80       	add    $0x80000000,%eax
  80028a:	39 c1                	cmp    %eax,%ecx
  80028c:	74 14                	je     8002a2 <_main+0x26a>
  80028e:	83 ec 04             	sub    $0x4,%esp
  800291:	68 40 21 80 00       	push   $0x802140
  800296:	6a 28                	push   $0x28
  800298:	68 a5 21 80 00       	push   $0x8021a5
  80029d:	e8 91 02 00 00       	call   800533 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002a2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8002a5:	e8 6f 17 00 00       	call   801a19 <sys_calculate_free_frames>
  8002aa:	29 c3                	sub    %eax,%ebx
  8002ac:	89 d8                	mov    %ebx,%eax
  8002ae:	83 f8 01             	cmp    $0x1,%eax
  8002b1:	74 14                	je     8002c7 <_main+0x28f>
  8002b3:	83 ec 04             	sub    $0x4,%esp
  8002b6:	68 b8 21 80 00       	push   $0x8021b8
  8002bb:	6a 29                	push   $0x29
  8002bd:	68 a5 21 80 00       	push   $0x8021a5
  8002c2:	e8 6c 02 00 00       	call   800533 <_panic>
	}
	//make sure that the pages added to page file = 9MB / 4KB
	if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != (9<<8)+2 ) panic("Extra or less pages are allocated in PageFile");
  8002c7:	e8 d0 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  8002cc:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8002cf:	3d 02 09 00 00       	cmp    $0x902,%eax
  8002d4:	74 14                	je     8002ea <_main+0x2b2>
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	68 24 22 80 00       	push   $0x802224
  8002de:	6a 2c                	push   $0x2c
  8002e0:	68 a5 21 80 00       	push   $0x8021a5
  8002e5:	e8 49 02 00 00       	call   800533 <_panic>

	cprintf("Step A of test malloc completed successfully.\n\n\n");
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	68 54 22 80 00       	push   $0x802254
  8002f2:	e8 f0 04 00 00       	call   8007e7 <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp

	///====================

	int freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 1a 17 00 00       	call   801a19 <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	{
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800302:	e8 95 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800307:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(2*kilo);
  80030a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030d:	01 c0                	add    %eax,%eax
  80030f:	83 ec 0c             	sub    $0xc,%esp
  800312:	50                   	push   %eax
  800313:	e8 3e 14 00 00       	call   801756 <malloc>
  800318:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  80031b:	e8 7c 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800320:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800323:	74 14                	je     800339 <_main+0x301>
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	68 88 22 80 00       	push   $0x802288
  80032d:	6a 36                	push   $0x36
  80032f:	68 a5 21 80 00       	push   $0x8021a5
  800334:	e8 fa 01 00 00       	call   800533 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800339:	e8 5e 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  80033e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(2*kilo);
  800341:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800344:	01 c0                	add    %eax,%eax
  800346:	83 ec 0c             	sub    $0xc,%esp
  800349:	50                   	push   %eax
  80034a:	e8 07 14 00 00       	call   801756 <malloc>
  80034f:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  800352:	e8 45 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800357:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80035a:	83 f8 01             	cmp    $0x1,%eax
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 88 22 80 00       	push   $0x802288
  800367:	6a 3a                	push   $0x3a
  800369:	68 a5 21 80 00       	push   $0x8021a5
  80036e:	e8 c0 01 00 00       	call   800533 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800373:	e8 24 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800378:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(3*kilo);
  80037b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037e:	89 c2                	mov    %eax,%edx
  800380:	01 d2                	add    %edx,%edx
  800382:	01 d0                	add    %edx,%eax
  800384:	83 ec 0c             	sub    $0xc,%esp
  800387:	50                   	push   %eax
  800388:	e8 c9 13 00 00       	call   801756 <malloc>
  80038d:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  800390:	e8 07 17 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  800395:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 88 22 80 00       	push   $0x802288
  8003a2:	6a 3e                	push   $0x3e
  8003a4:	68 a5 21 80 00       	push   $0x8021a5
  8003a9:	e8 85 01 00 00       	call   800533 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003ae:	e8 e9 16 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  8003b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(3*kilo);
  8003b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b9:	89 c2                	mov    %eax,%edx
  8003bb:	01 d2                	add    %edx,%edx
  8003bd:	01 d0                	add    %edx,%eax
  8003bf:	83 ec 0c             	sub    $0xc,%esp
  8003c2:	50                   	push   %eax
  8003c3:	e8 8e 13 00 00       	call   801756 <malloc>
  8003c8:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  8003cb:	e8 cc 16 00 00       	call   801a9c <sys_pf_calculate_allocated_pages>
  8003d0:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8003d3:	83 f8 01             	cmp    $0x1,%eax
  8003d6:	74 14                	je     8003ec <_main+0x3b4>
  8003d8:	83 ec 04             	sub    $0x4,%esp
  8003db:	68 88 22 80 00       	push   $0x802288
  8003e0:	6a 42                	push   $0x42
  8003e2:	68 a5 21 80 00       	push   $0x8021a5
  8003e7:	e8 47 01 00 00       	call   800533 <_panic>
	}

	if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory");
  8003ec:	e8 28 16 00 00       	call   801a19 <sys_calculate_free_frames>
  8003f1:	89 c2                	mov    %eax,%edx
  8003f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003f6:	39 c2                	cmp    %eax,%edx
  8003f8:	74 14                	je     80040e <_main+0x3d6>
  8003fa:	83 ec 04             	sub    $0x4,%esp
  8003fd:	68 f8 22 80 00       	push   $0x8022f8
  800402:	6a 45                	push   $0x45
  800404:	68 a5 21 80 00       	push   $0x8021a5
  800409:	e8 25 01 00 00       	call   800533 <_panic>

	cprintf("Congratulations!! test malloc completed successfully.\n");
  80040e:	83 ec 0c             	sub    $0xc,%esp
  800411:	68 38 23 80 00       	push   $0x802338
  800416:	e8 cc 03 00 00       	call   8007e7 <cprintf>
  80041b:	83 c4 10             	add    $0x10,%esp

	return;
  80041e:	90                   	nop
}
  80041f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800422:	c9                   	leave  
  800423:	c3                   	ret    

00800424 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800424:	55                   	push   %ebp
  800425:	89 e5                	mov    %esp,%ebp
  800427:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80042a:	e8 1f 15 00 00       	call   80194e <sys_getenvindex>
  80042f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800432:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800435:	89 d0                	mov    %edx,%eax
  800437:	c1 e0 02             	shl    $0x2,%eax
  80043a:	01 d0                	add    %edx,%eax
  80043c:	01 c0                	add    %eax,%eax
  80043e:	01 d0                	add    %edx,%eax
  800440:	01 c0                	add    %eax,%eax
  800442:	01 d0                	add    %edx,%eax
  800444:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80044b:	01 d0                	add    %edx,%eax
  80044d:	c1 e0 02             	shl    $0x2,%eax
  800450:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800455:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800465:	84 c0                	test   %al,%al
  800467:	74 0f                	je     800478 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800469:	a1 20 30 80 00       	mov    0x803020,%eax
  80046e:	05 f4 02 00 00       	add    $0x2f4,%eax
  800473:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800478:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80047c:	7e 0a                	jle    800488 <libmain+0x64>
		binaryname = argv[0];
  80047e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800488:	83 ec 08             	sub    $0x8,%esp
  80048b:	ff 75 0c             	pushl  0xc(%ebp)
  80048e:	ff 75 08             	pushl  0x8(%ebp)
  800491:	e8 a2 fb ff ff       	call   800038 <_main>
  800496:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800499:	e8 4b 16 00 00       	call   801ae9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80049e:	83 ec 0c             	sub    $0xc,%esp
  8004a1:	68 88 23 80 00       	push   $0x802388
  8004a6:	e8 3c 03 00 00       	call   8007e7 <cprintf>
  8004ab:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b3:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8004b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004be:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8004c4:	83 ec 04             	sub    $0x4,%esp
  8004c7:	52                   	push   %edx
  8004c8:	50                   	push   %eax
  8004c9:	68 b0 23 80 00       	push   $0x8023b0
  8004ce:	e8 14 03 00 00       	call   8007e7 <cprintf>
  8004d3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004db:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8004e1:	83 ec 08             	sub    $0x8,%esp
  8004e4:	50                   	push   %eax
  8004e5:	68 d5 23 80 00       	push   $0x8023d5
  8004ea:	e8 f8 02 00 00       	call   8007e7 <cprintf>
  8004ef:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	68 88 23 80 00       	push   $0x802388
  8004fa:	e8 e8 02 00 00       	call   8007e7 <cprintf>
  8004ff:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800502:	e8 fc 15 00 00       	call   801b03 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800507:	e8 19 00 00 00       	call   800525 <exit>
}
  80050c:	90                   	nop
  80050d:	c9                   	leave  
  80050e:	c3                   	ret    

0080050f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80050f:	55                   	push   %ebp
  800510:	89 e5                	mov    %esp,%ebp
  800512:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800515:	83 ec 0c             	sub    $0xc,%esp
  800518:	6a 00                	push   $0x0
  80051a:	e8 fb 13 00 00       	call   80191a <sys_env_destroy>
  80051f:	83 c4 10             	add    $0x10,%esp
}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <exit>:

void
exit(void)
{
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80052b:	e8 50 14 00 00       	call   801980 <sys_env_exit>
}
  800530:	90                   	nop
  800531:	c9                   	leave  
  800532:	c3                   	ret    

00800533 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800533:	55                   	push   %ebp
  800534:	89 e5                	mov    %esp,%ebp
  800536:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800539:	8d 45 10             	lea    0x10(%ebp),%eax
  80053c:	83 c0 04             	add    $0x4,%eax
  80053f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800542:	a1 48 30 88 00       	mov    0x883048,%eax
  800547:	85 c0                	test   %eax,%eax
  800549:	74 16                	je     800561 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80054b:	a1 48 30 88 00       	mov    0x883048,%eax
  800550:	83 ec 08             	sub    $0x8,%esp
  800553:	50                   	push   %eax
  800554:	68 ec 23 80 00       	push   $0x8023ec
  800559:	e8 89 02 00 00       	call   8007e7 <cprintf>
  80055e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800561:	a1 00 30 80 00       	mov    0x803000,%eax
  800566:	ff 75 0c             	pushl  0xc(%ebp)
  800569:	ff 75 08             	pushl  0x8(%ebp)
  80056c:	50                   	push   %eax
  80056d:	68 f1 23 80 00       	push   $0x8023f1
  800572:	e8 70 02 00 00       	call   8007e7 <cprintf>
  800577:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80057a:	8b 45 10             	mov    0x10(%ebp),%eax
  80057d:	83 ec 08             	sub    $0x8,%esp
  800580:	ff 75 f4             	pushl  -0xc(%ebp)
  800583:	50                   	push   %eax
  800584:	e8 f3 01 00 00       	call   80077c <vcprintf>
  800589:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80058c:	83 ec 08             	sub    $0x8,%esp
  80058f:	6a 00                	push   $0x0
  800591:	68 0d 24 80 00       	push   $0x80240d
  800596:	e8 e1 01 00 00       	call   80077c <vcprintf>
  80059b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80059e:	e8 82 ff ff ff       	call   800525 <exit>

	// should not return here
	while (1) ;
  8005a3:	eb fe                	jmp    8005a3 <_panic+0x70>

008005a5 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8005a5:	55                   	push   %ebp
  8005a6:	89 e5                	mov    %esp,%ebp
  8005a8:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8005ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b0:	8b 50 74             	mov    0x74(%eax),%edx
  8005b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b6:	39 c2                	cmp    %eax,%edx
  8005b8:	74 14                	je     8005ce <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005ba:	83 ec 04             	sub    $0x4,%esp
  8005bd:	68 10 24 80 00       	push   $0x802410
  8005c2:	6a 26                	push   $0x26
  8005c4:	68 5c 24 80 00       	push   $0x80245c
  8005c9:	e8 65 ff ff ff       	call   800533 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005dc:	e9 c2 00 00 00       	jmp    8006a3 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8005e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ee:	01 d0                	add    %edx,%eax
  8005f0:	8b 00                	mov    (%eax),%eax
  8005f2:	85 c0                	test   %eax,%eax
  8005f4:	75 08                	jne    8005fe <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005f6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005f9:	e9 a2 00 00 00       	jmp    8006a0 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8005fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800605:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80060c:	eb 69                	jmp    800677 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80060e:	a1 20 30 80 00       	mov    0x803020,%eax
  800613:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800619:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80061c:	89 d0                	mov    %edx,%eax
  80061e:	01 c0                	add    %eax,%eax
  800620:	01 d0                	add    %edx,%eax
  800622:	c1 e0 02             	shl    $0x2,%eax
  800625:	01 c8                	add    %ecx,%eax
  800627:	8a 40 04             	mov    0x4(%eax),%al
  80062a:	84 c0                	test   %al,%al
  80062c:	75 46                	jne    800674 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80062e:	a1 20 30 80 00       	mov    0x803020,%eax
  800633:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800639:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80063c:	89 d0                	mov    %edx,%eax
  80063e:	01 c0                	add    %eax,%eax
  800640:	01 d0                	add    %edx,%eax
  800642:	c1 e0 02             	shl    $0x2,%eax
  800645:	01 c8                	add    %ecx,%eax
  800647:	8b 00                	mov    (%eax),%eax
  800649:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80064c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80064f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800654:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800656:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800659:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800660:	8b 45 08             	mov    0x8(%ebp),%eax
  800663:	01 c8                	add    %ecx,%eax
  800665:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800667:	39 c2                	cmp    %eax,%edx
  800669:	75 09                	jne    800674 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80066b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800672:	eb 12                	jmp    800686 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800674:	ff 45 e8             	incl   -0x18(%ebp)
  800677:	a1 20 30 80 00       	mov    0x803020,%eax
  80067c:	8b 50 74             	mov    0x74(%eax),%edx
  80067f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800682:	39 c2                	cmp    %eax,%edx
  800684:	77 88                	ja     80060e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800686:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80068a:	75 14                	jne    8006a0 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80068c:	83 ec 04             	sub    $0x4,%esp
  80068f:	68 68 24 80 00       	push   $0x802468
  800694:	6a 3a                	push   $0x3a
  800696:	68 5c 24 80 00       	push   $0x80245c
  80069b:	e8 93 fe ff ff       	call   800533 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8006a0:	ff 45 f0             	incl   -0x10(%ebp)
  8006a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006a9:	0f 8c 32 ff ff ff    	jl     8005e1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006b6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006bd:	eb 26                	jmp    8006e5 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c4:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8006ca:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006cd:	89 d0                	mov    %edx,%eax
  8006cf:	01 c0                	add    %eax,%eax
  8006d1:	01 d0                	add    %edx,%eax
  8006d3:	c1 e0 02             	shl    $0x2,%eax
  8006d6:	01 c8                	add    %ecx,%eax
  8006d8:	8a 40 04             	mov    0x4(%eax),%al
  8006db:	3c 01                	cmp    $0x1,%al
  8006dd:	75 03                	jne    8006e2 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8006df:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006e2:	ff 45 e0             	incl   -0x20(%ebp)
  8006e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ea:	8b 50 74             	mov    0x74(%eax),%edx
  8006ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006f0:	39 c2                	cmp    %eax,%edx
  8006f2:	77 cb                	ja     8006bf <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006f7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006fa:	74 14                	je     800710 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 bc 24 80 00       	push   $0x8024bc
  800704:	6a 44                	push   $0x44
  800706:	68 5c 24 80 00       	push   $0x80245c
  80070b:	e8 23 fe ff ff       	call   800533 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800710:	90                   	nop
  800711:	c9                   	leave  
  800712:	c3                   	ret    

00800713 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800713:	55                   	push   %ebp
  800714:	89 e5                	mov    %esp,%ebp
  800716:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800719:	8b 45 0c             	mov    0xc(%ebp),%eax
  80071c:	8b 00                	mov    (%eax),%eax
  80071e:	8d 48 01             	lea    0x1(%eax),%ecx
  800721:	8b 55 0c             	mov    0xc(%ebp),%edx
  800724:	89 0a                	mov    %ecx,(%edx)
  800726:	8b 55 08             	mov    0x8(%ebp),%edx
  800729:	88 d1                	mov    %dl,%cl
  80072b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80072e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800732:	8b 45 0c             	mov    0xc(%ebp),%eax
  800735:	8b 00                	mov    (%eax),%eax
  800737:	3d ff 00 00 00       	cmp    $0xff,%eax
  80073c:	75 2c                	jne    80076a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80073e:	a0 24 30 80 00       	mov    0x803024,%al
  800743:	0f b6 c0             	movzbl %al,%eax
  800746:	8b 55 0c             	mov    0xc(%ebp),%edx
  800749:	8b 12                	mov    (%edx),%edx
  80074b:	89 d1                	mov    %edx,%ecx
  80074d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800750:	83 c2 08             	add    $0x8,%edx
  800753:	83 ec 04             	sub    $0x4,%esp
  800756:	50                   	push   %eax
  800757:	51                   	push   %ecx
  800758:	52                   	push   %edx
  800759:	e8 7a 11 00 00       	call   8018d8 <sys_cputs>
  80075e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800761:	8b 45 0c             	mov    0xc(%ebp),%eax
  800764:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80076a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076d:	8b 40 04             	mov    0x4(%eax),%eax
  800770:	8d 50 01             	lea    0x1(%eax),%edx
  800773:	8b 45 0c             	mov    0xc(%ebp),%eax
  800776:	89 50 04             	mov    %edx,0x4(%eax)
}
  800779:	90                   	nop
  80077a:	c9                   	leave  
  80077b:	c3                   	ret    

0080077c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80077c:	55                   	push   %ebp
  80077d:	89 e5                	mov    %esp,%ebp
  80077f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800785:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80078c:	00 00 00 
	b.cnt = 0;
  80078f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800796:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	ff 75 08             	pushl  0x8(%ebp)
  80079f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007a5:	50                   	push   %eax
  8007a6:	68 13 07 80 00       	push   $0x800713
  8007ab:	e8 11 02 00 00       	call   8009c1 <vprintfmt>
  8007b0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007b3:	a0 24 30 80 00       	mov    0x803024,%al
  8007b8:	0f b6 c0             	movzbl %al,%eax
  8007bb:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007c1:	83 ec 04             	sub    $0x4,%esp
  8007c4:	50                   	push   %eax
  8007c5:	52                   	push   %edx
  8007c6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007cc:	83 c0 08             	add    $0x8,%eax
  8007cf:	50                   	push   %eax
  8007d0:	e8 03 11 00 00       	call   8018d8 <sys_cputs>
  8007d5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007d8:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007df:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007e5:	c9                   	leave  
  8007e6:	c3                   	ret    

008007e7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8007e7:	55                   	push   %ebp
  8007e8:	89 e5                	mov    %esp,%ebp
  8007ea:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007ed:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007f4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	83 ec 08             	sub    $0x8,%esp
  800800:	ff 75 f4             	pushl  -0xc(%ebp)
  800803:	50                   	push   %eax
  800804:	e8 73 ff ff ff       	call   80077c <vcprintf>
  800809:	83 c4 10             	add    $0x10,%esp
  80080c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80080f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800812:	c9                   	leave  
  800813:	c3                   	ret    

00800814 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800814:	55                   	push   %ebp
  800815:	89 e5                	mov    %esp,%ebp
  800817:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80081a:	e8 ca 12 00 00       	call   801ae9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80081f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800822:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	83 ec 08             	sub    $0x8,%esp
  80082b:	ff 75 f4             	pushl  -0xc(%ebp)
  80082e:	50                   	push   %eax
  80082f:	e8 48 ff ff ff       	call   80077c <vcprintf>
  800834:	83 c4 10             	add    $0x10,%esp
  800837:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80083a:	e8 c4 12 00 00       	call   801b03 <sys_enable_interrupt>
	return cnt;
  80083f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800842:	c9                   	leave  
  800843:	c3                   	ret    

00800844 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800844:	55                   	push   %ebp
  800845:	89 e5                	mov    %esp,%ebp
  800847:	53                   	push   %ebx
  800848:	83 ec 14             	sub    $0x14,%esp
  80084b:	8b 45 10             	mov    0x10(%ebp),%eax
  80084e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800851:	8b 45 14             	mov    0x14(%ebp),%eax
  800854:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800857:	8b 45 18             	mov    0x18(%ebp),%eax
  80085a:	ba 00 00 00 00       	mov    $0x0,%edx
  80085f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800862:	77 55                	ja     8008b9 <printnum+0x75>
  800864:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800867:	72 05                	jb     80086e <printnum+0x2a>
  800869:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80086c:	77 4b                	ja     8008b9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80086e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800871:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800874:	8b 45 18             	mov    0x18(%ebp),%eax
  800877:	ba 00 00 00 00       	mov    $0x0,%edx
  80087c:	52                   	push   %edx
  80087d:	50                   	push   %eax
  80087e:	ff 75 f4             	pushl  -0xc(%ebp)
  800881:	ff 75 f0             	pushl  -0x10(%ebp)
  800884:	e8 3f 16 00 00       	call   801ec8 <__udivdi3>
  800889:	83 c4 10             	add    $0x10,%esp
  80088c:	83 ec 04             	sub    $0x4,%esp
  80088f:	ff 75 20             	pushl  0x20(%ebp)
  800892:	53                   	push   %ebx
  800893:	ff 75 18             	pushl  0x18(%ebp)
  800896:	52                   	push   %edx
  800897:	50                   	push   %eax
  800898:	ff 75 0c             	pushl  0xc(%ebp)
  80089b:	ff 75 08             	pushl  0x8(%ebp)
  80089e:	e8 a1 ff ff ff       	call   800844 <printnum>
  8008a3:	83 c4 20             	add    $0x20,%esp
  8008a6:	eb 1a                	jmp    8008c2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008a8:	83 ec 08             	sub    $0x8,%esp
  8008ab:	ff 75 0c             	pushl  0xc(%ebp)
  8008ae:	ff 75 20             	pushl  0x20(%ebp)
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	ff d0                	call   *%eax
  8008b6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008b9:	ff 4d 1c             	decl   0x1c(%ebp)
  8008bc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008c0:	7f e6                	jg     8008a8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008c2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008c5:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008d0:	53                   	push   %ebx
  8008d1:	51                   	push   %ecx
  8008d2:	52                   	push   %edx
  8008d3:	50                   	push   %eax
  8008d4:	e8 ff 16 00 00       	call   801fd8 <__umoddi3>
  8008d9:	83 c4 10             	add    $0x10,%esp
  8008dc:	05 34 27 80 00       	add    $0x802734,%eax
  8008e1:	8a 00                	mov    (%eax),%al
  8008e3:	0f be c0             	movsbl %al,%eax
  8008e6:	83 ec 08             	sub    $0x8,%esp
  8008e9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ec:	50                   	push   %eax
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	ff d0                	call   *%eax
  8008f2:	83 c4 10             	add    $0x10,%esp
}
  8008f5:	90                   	nop
  8008f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008f9:	c9                   	leave  
  8008fa:	c3                   	ret    

008008fb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008fb:	55                   	push   %ebp
  8008fc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008fe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800902:	7e 1c                	jle    800920 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	8d 50 08             	lea    0x8(%eax),%edx
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	89 10                	mov    %edx,(%eax)
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	83 e8 08             	sub    $0x8,%eax
  800919:	8b 50 04             	mov    0x4(%eax),%edx
  80091c:	8b 00                	mov    (%eax),%eax
  80091e:	eb 40                	jmp    800960 <getuint+0x65>
	else if (lflag)
  800920:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800924:	74 1e                	je     800944 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8b 00                	mov    (%eax),%eax
  80092b:	8d 50 04             	lea    0x4(%eax),%edx
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	89 10                	mov    %edx,(%eax)
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	8b 00                	mov    (%eax),%eax
  800938:	83 e8 04             	sub    $0x4,%eax
  80093b:	8b 00                	mov    (%eax),%eax
  80093d:	ba 00 00 00 00       	mov    $0x0,%edx
  800942:	eb 1c                	jmp    800960 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	8b 00                	mov    (%eax),%eax
  800949:	8d 50 04             	lea    0x4(%eax),%edx
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	89 10                	mov    %edx,(%eax)
  800951:	8b 45 08             	mov    0x8(%ebp),%eax
  800954:	8b 00                	mov    (%eax),%eax
  800956:	83 e8 04             	sub    $0x4,%eax
  800959:	8b 00                	mov    (%eax),%eax
  80095b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800960:	5d                   	pop    %ebp
  800961:	c3                   	ret    

00800962 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800962:	55                   	push   %ebp
  800963:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800965:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800969:	7e 1c                	jle    800987 <getint+0x25>
		return va_arg(*ap, long long);
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	8b 00                	mov    (%eax),%eax
  800970:	8d 50 08             	lea    0x8(%eax),%edx
  800973:	8b 45 08             	mov    0x8(%ebp),%eax
  800976:	89 10                	mov    %edx,(%eax)
  800978:	8b 45 08             	mov    0x8(%ebp),%eax
  80097b:	8b 00                	mov    (%eax),%eax
  80097d:	83 e8 08             	sub    $0x8,%eax
  800980:	8b 50 04             	mov    0x4(%eax),%edx
  800983:	8b 00                	mov    (%eax),%eax
  800985:	eb 38                	jmp    8009bf <getint+0x5d>
	else if (lflag)
  800987:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80098b:	74 1a                	je     8009a7 <getint+0x45>
		return va_arg(*ap, long);
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	8d 50 04             	lea    0x4(%eax),%edx
  800995:	8b 45 08             	mov    0x8(%ebp),%eax
  800998:	89 10                	mov    %edx,(%eax)
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	83 e8 04             	sub    $0x4,%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	99                   	cltd   
  8009a5:	eb 18                	jmp    8009bf <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	8b 00                	mov    (%eax),%eax
  8009ac:	8d 50 04             	lea    0x4(%eax),%edx
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	89 10                	mov    %edx,(%eax)
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	8b 00                	mov    (%eax),%eax
  8009b9:	83 e8 04             	sub    $0x4,%eax
  8009bc:	8b 00                	mov    (%eax),%eax
  8009be:	99                   	cltd   
}
  8009bf:	5d                   	pop    %ebp
  8009c0:	c3                   	ret    

008009c1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	56                   	push   %esi
  8009c5:	53                   	push   %ebx
  8009c6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009c9:	eb 17                	jmp    8009e2 <vprintfmt+0x21>
			if (ch == '\0')
  8009cb:	85 db                	test   %ebx,%ebx
  8009cd:	0f 84 af 03 00 00    	je     800d82 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009d3:	83 ec 08             	sub    $0x8,%esp
  8009d6:	ff 75 0c             	pushl  0xc(%ebp)
  8009d9:	53                   	push   %ebx
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	ff d0                	call   *%eax
  8009df:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e5:	8d 50 01             	lea    0x1(%eax),%edx
  8009e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8009eb:	8a 00                	mov    (%eax),%al
  8009ed:	0f b6 d8             	movzbl %al,%ebx
  8009f0:	83 fb 25             	cmp    $0x25,%ebx
  8009f3:	75 d6                	jne    8009cb <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009f5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009f9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a00:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a07:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a0e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a15:	8b 45 10             	mov    0x10(%ebp),%eax
  800a18:	8d 50 01             	lea    0x1(%eax),%edx
  800a1b:	89 55 10             	mov    %edx,0x10(%ebp)
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	0f b6 d8             	movzbl %al,%ebx
  800a23:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a26:	83 f8 55             	cmp    $0x55,%eax
  800a29:	0f 87 2b 03 00 00    	ja     800d5a <vprintfmt+0x399>
  800a2f:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  800a36:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a38:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a3c:	eb d7                	jmp    800a15 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a3e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a42:	eb d1                	jmp    800a15 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a44:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a4b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a4e:	89 d0                	mov    %edx,%eax
  800a50:	c1 e0 02             	shl    $0x2,%eax
  800a53:	01 d0                	add    %edx,%eax
  800a55:	01 c0                	add    %eax,%eax
  800a57:	01 d8                	add    %ebx,%eax
  800a59:	83 e8 30             	sub    $0x30,%eax
  800a5c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a62:	8a 00                	mov    (%eax),%al
  800a64:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a67:	83 fb 2f             	cmp    $0x2f,%ebx
  800a6a:	7e 3e                	jle    800aaa <vprintfmt+0xe9>
  800a6c:	83 fb 39             	cmp    $0x39,%ebx
  800a6f:	7f 39                	jg     800aaa <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a71:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a74:	eb d5                	jmp    800a4b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 c0 04             	add    $0x4,%eax
  800a7c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a82:	83 e8 04             	sub    $0x4,%eax
  800a85:	8b 00                	mov    (%eax),%eax
  800a87:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a8a:	eb 1f                	jmp    800aab <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a90:	79 83                	jns    800a15 <vprintfmt+0x54>
				width = 0;
  800a92:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a99:	e9 77 ff ff ff       	jmp    800a15 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a9e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800aa5:	e9 6b ff ff ff       	jmp    800a15 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800aaa:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800aab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aaf:	0f 89 60 ff ff ff    	jns    800a15 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ab5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ab8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800abb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ac2:	e9 4e ff ff ff       	jmp    800a15 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ac7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800aca:	e9 46 ff ff ff       	jmp    800a15 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800acf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad2:	83 c0 04             	add    $0x4,%eax
  800ad5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad8:	8b 45 14             	mov    0x14(%ebp),%eax
  800adb:	83 e8 04             	sub    $0x4,%eax
  800ade:	8b 00                	mov    (%eax),%eax
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	50                   	push   %eax
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	ff d0                	call   *%eax
  800aec:	83 c4 10             	add    $0x10,%esp
			break;
  800aef:	e9 89 02 00 00       	jmp    800d7d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800af4:	8b 45 14             	mov    0x14(%ebp),%eax
  800af7:	83 c0 04             	add    $0x4,%eax
  800afa:	89 45 14             	mov    %eax,0x14(%ebp)
  800afd:	8b 45 14             	mov    0x14(%ebp),%eax
  800b00:	83 e8 04             	sub    $0x4,%eax
  800b03:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b05:	85 db                	test   %ebx,%ebx
  800b07:	79 02                	jns    800b0b <vprintfmt+0x14a>
				err = -err;
  800b09:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b0b:	83 fb 64             	cmp    $0x64,%ebx
  800b0e:	7f 0b                	jg     800b1b <vprintfmt+0x15a>
  800b10:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800b17:	85 f6                	test   %esi,%esi
  800b19:	75 19                	jne    800b34 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b1b:	53                   	push   %ebx
  800b1c:	68 45 27 80 00       	push   $0x802745
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	ff 75 08             	pushl  0x8(%ebp)
  800b27:	e8 5e 02 00 00       	call   800d8a <printfmt>
  800b2c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b2f:	e9 49 02 00 00       	jmp    800d7d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b34:	56                   	push   %esi
  800b35:	68 4e 27 80 00       	push   $0x80274e
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	ff 75 08             	pushl  0x8(%ebp)
  800b40:	e8 45 02 00 00       	call   800d8a <printfmt>
  800b45:	83 c4 10             	add    $0x10,%esp
			break;
  800b48:	e9 30 02 00 00       	jmp    800d7d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b50:	83 c0 04             	add    $0x4,%eax
  800b53:	89 45 14             	mov    %eax,0x14(%ebp)
  800b56:	8b 45 14             	mov    0x14(%ebp),%eax
  800b59:	83 e8 04             	sub    $0x4,%eax
  800b5c:	8b 30                	mov    (%eax),%esi
  800b5e:	85 f6                	test   %esi,%esi
  800b60:	75 05                	jne    800b67 <vprintfmt+0x1a6>
				p = "(null)";
  800b62:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800b67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b6b:	7e 6d                	jle    800bda <vprintfmt+0x219>
  800b6d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b71:	74 67                	je     800bda <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	50                   	push   %eax
  800b7a:	56                   	push   %esi
  800b7b:	e8 0c 03 00 00       	call   800e8c <strnlen>
  800b80:	83 c4 10             	add    $0x10,%esp
  800b83:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b86:	eb 16                	jmp    800b9e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b88:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b8c:	83 ec 08             	sub    $0x8,%esp
  800b8f:	ff 75 0c             	pushl  0xc(%ebp)
  800b92:	50                   	push   %eax
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	ff d0                	call   *%eax
  800b98:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b9b:	ff 4d e4             	decl   -0x1c(%ebp)
  800b9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ba2:	7f e4                	jg     800b88 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ba4:	eb 34                	jmp    800bda <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ba6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800baa:	74 1c                	je     800bc8 <vprintfmt+0x207>
  800bac:	83 fb 1f             	cmp    $0x1f,%ebx
  800baf:	7e 05                	jle    800bb6 <vprintfmt+0x1f5>
  800bb1:	83 fb 7e             	cmp    $0x7e,%ebx
  800bb4:	7e 12                	jle    800bc8 <vprintfmt+0x207>
					putch('?', putdat);
  800bb6:	83 ec 08             	sub    $0x8,%esp
  800bb9:	ff 75 0c             	pushl  0xc(%ebp)
  800bbc:	6a 3f                	push   $0x3f
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	ff d0                	call   *%eax
  800bc3:	83 c4 10             	add    $0x10,%esp
  800bc6:	eb 0f                	jmp    800bd7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bc8:	83 ec 08             	sub    $0x8,%esp
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	53                   	push   %ebx
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	ff d0                	call   *%eax
  800bd4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bd7:	ff 4d e4             	decl   -0x1c(%ebp)
  800bda:	89 f0                	mov    %esi,%eax
  800bdc:	8d 70 01             	lea    0x1(%eax),%esi
  800bdf:	8a 00                	mov    (%eax),%al
  800be1:	0f be d8             	movsbl %al,%ebx
  800be4:	85 db                	test   %ebx,%ebx
  800be6:	74 24                	je     800c0c <vprintfmt+0x24b>
  800be8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bec:	78 b8                	js     800ba6 <vprintfmt+0x1e5>
  800bee:	ff 4d e0             	decl   -0x20(%ebp)
  800bf1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bf5:	79 af                	jns    800ba6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bf7:	eb 13                	jmp    800c0c <vprintfmt+0x24b>
				putch(' ', putdat);
  800bf9:	83 ec 08             	sub    $0x8,%esp
  800bfc:	ff 75 0c             	pushl  0xc(%ebp)
  800bff:	6a 20                	push   $0x20
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	ff d0                	call   *%eax
  800c06:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c09:	ff 4d e4             	decl   -0x1c(%ebp)
  800c0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c10:	7f e7                	jg     800bf9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c12:	e9 66 01 00 00       	jmp    800d7d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c17:	83 ec 08             	sub    $0x8,%esp
  800c1a:	ff 75 e8             	pushl  -0x18(%ebp)
  800c1d:	8d 45 14             	lea    0x14(%ebp),%eax
  800c20:	50                   	push   %eax
  800c21:	e8 3c fd ff ff       	call   800962 <getint>
  800c26:	83 c4 10             	add    $0x10,%esp
  800c29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c2c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c35:	85 d2                	test   %edx,%edx
  800c37:	79 23                	jns    800c5c <vprintfmt+0x29b>
				putch('-', putdat);
  800c39:	83 ec 08             	sub    $0x8,%esp
  800c3c:	ff 75 0c             	pushl  0xc(%ebp)
  800c3f:	6a 2d                	push   $0x2d
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	ff d0                	call   *%eax
  800c46:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c4f:	f7 d8                	neg    %eax
  800c51:	83 d2 00             	adc    $0x0,%edx
  800c54:	f7 da                	neg    %edx
  800c56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c59:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c5c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c63:	e9 bc 00 00 00       	jmp    800d24 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c68:	83 ec 08             	sub    $0x8,%esp
  800c6b:	ff 75 e8             	pushl  -0x18(%ebp)
  800c6e:	8d 45 14             	lea    0x14(%ebp),%eax
  800c71:	50                   	push   %eax
  800c72:	e8 84 fc ff ff       	call   8008fb <getuint>
  800c77:	83 c4 10             	add    $0x10,%esp
  800c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c80:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c87:	e9 98 00 00 00       	jmp    800d24 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c8c:	83 ec 08             	sub    $0x8,%esp
  800c8f:	ff 75 0c             	pushl  0xc(%ebp)
  800c92:	6a 58                	push   $0x58
  800c94:	8b 45 08             	mov    0x8(%ebp),%eax
  800c97:	ff d0                	call   *%eax
  800c99:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c9c:	83 ec 08             	sub    $0x8,%esp
  800c9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ca2:	6a 58                	push   $0x58
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	ff d0                	call   *%eax
  800ca9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cac:	83 ec 08             	sub    $0x8,%esp
  800caf:	ff 75 0c             	pushl  0xc(%ebp)
  800cb2:	6a 58                	push   $0x58
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	ff d0                	call   *%eax
  800cb9:	83 c4 10             	add    $0x10,%esp
			break;
  800cbc:	e9 bc 00 00 00       	jmp    800d7d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800cc1:	83 ec 08             	sub    $0x8,%esp
  800cc4:	ff 75 0c             	pushl  0xc(%ebp)
  800cc7:	6a 30                	push   $0x30
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cd1:	83 ec 08             	sub    $0x8,%esp
  800cd4:	ff 75 0c             	pushl  0xc(%ebp)
  800cd7:	6a 78                	push   $0x78
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	ff d0                	call   *%eax
  800cde:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ce1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce4:	83 c0 04             	add    $0x4,%eax
  800ce7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cea:	8b 45 14             	mov    0x14(%ebp),%eax
  800ced:	83 e8 04             	sub    $0x4,%eax
  800cf0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cf2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cf5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cfc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d03:	eb 1f                	jmp    800d24 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d05:	83 ec 08             	sub    $0x8,%esp
  800d08:	ff 75 e8             	pushl  -0x18(%ebp)
  800d0b:	8d 45 14             	lea    0x14(%ebp),%eax
  800d0e:	50                   	push   %eax
  800d0f:	e8 e7 fb ff ff       	call   8008fb <getuint>
  800d14:	83 c4 10             	add    $0x10,%esp
  800d17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d1a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d1d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d24:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d28:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d2b:	83 ec 04             	sub    $0x4,%esp
  800d2e:	52                   	push   %edx
  800d2f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d32:	50                   	push   %eax
  800d33:	ff 75 f4             	pushl  -0xc(%ebp)
  800d36:	ff 75 f0             	pushl  -0x10(%ebp)
  800d39:	ff 75 0c             	pushl  0xc(%ebp)
  800d3c:	ff 75 08             	pushl  0x8(%ebp)
  800d3f:	e8 00 fb ff ff       	call   800844 <printnum>
  800d44:	83 c4 20             	add    $0x20,%esp
			break;
  800d47:	eb 34                	jmp    800d7d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d49:	83 ec 08             	sub    $0x8,%esp
  800d4c:	ff 75 0c             	pushl  0xc(%ebp)
  800d4f:	53                   	push   %ebx
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	ff d0                	call   *%eax
  800d55:	83 c4 10             	add    $0x10,%esp
			break;
  800d58:	eb 23                	jmp    800d7d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d5a:	83 ec 08             	sub    $0x8,%esp
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	6a 25                	push   $0x25
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	ff d0                	call   *%eax
  800d67:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d6a:	ff 4d 10             	decl   0x10(%ebp)
  800d6d:	eb 03                	jmp    800d72 <vprintfmt+0x3b1>
  800d6f:	ff 4d 10             	decl   0x10(%ebp)
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	48                   	dec    %eax
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	3c 25                	cmp    $0x25,%al
  800d7a:	75 f3                	jne    800d6f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d7c:	90                   	nop
		}
	}
  800d7d:	e9 47 fc ff ff       	jmp    8009c9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d82:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d86:	5b                   	pop    %ebx
  800d87:	5e                   	pop    %esi
  800d88:	5d                   	pop    %ebp
  800d89:	c3                   	ret    

00800d8a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d8a:	55                   	push   %ebp
  800d8b:	89 e5                	mov    %esp,%ebp
  800d8d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d90:	8d 45 10             	lea    0x10(%ebp),%eax
  800d93:	83 c0 04             	add    $0x4,%eax
  800d96:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d99:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9c:	ff 75 f4             	pushl  -0xc(%ebp)
  800d9f:	50                   	push   %eax
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	ff 75 08             	pushl  0x8(%ebp)
  800da6:	e8 16 fc ff ff       	call   8009c1 <vprintfmt>
  800dab:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dae:	90                   	nop
  800daf:	c9                   	leave  
  800db0:	c3                   	ret    

00800db1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800db1:	55                   	push   %ebp
  800db2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800db4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db7:	8b 40 08             	mov    0x8(%eax),%eax
  800dba:	8d 50 01             	lea    0x1(%eax),%edx
  800dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800dc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc6:	8b 10                	mov    (%eax),%edx
  800dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcb:	8b 40 04             	mov    0x4(%eax),%eax
  800dce:	39 c2                	cmp    %eax,%edx
  800dd0:	73 12                	jae    800de4 <sprintputch+0x33>
		*b->buf++ = ch;
  800dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd5:	8b 00                	mov    (%eax),%eax
  800dd7:	8d 48 01             	lea    0x1(%eax),%ecx
  800dda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ddd:	89 0a                	mov    %ecx,(%edx)
  800ddf:	8b 55 08             	mov    0x8(%ebp),%edx
  800de2:	88 10                	mov    %dl,(%eax)
}
  800de4:	90                   	nop
  800de5:	5d                   	pop    %ebp
  800de6:	c3                   	ret    

00800de7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
  800dea:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	01 d0                	add    %edx,%eax
  800dfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e08:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e0c:	74 06                	je     800e14 <vsnprintf+0x2d>
  800e0e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e12:	7f 07                	jg     800e1b <vsnprintf+0x34>
		return -E_INVAL;
  800e14:	b8 03 00 00 00       	mov    $0x3,%eax
  800e19:	eb 20                	jmp    800e3b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e1b:	ff 75 14             	pushl  0x14(%ebp)
  800e1e:	ff 75 10             	pushl  0x10(%ebp)
  800e21:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e24:	50                   	push   %eax
  800e25:	68 b1 0d 80 00       	push   $0x800db1
  800e2a:	e8 92 fb ff ff       	call   8009c1 <vprintfmt>
  800e2f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e35:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e43:	8d 45 10             	lea    0x10(%ebp),%eax
  800e46:	83 c0 04             	add    $0x4,%eax
  800e49:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4f:	ff 75 f4             	pushl  -0xc(%ebp)
  800e52:	50                   	push   %eax
  800e53:	ff 75 0c             	pushl  0xc(%ebp)
  800e56:	ff 75 08             	pushl  0x8(%ebp)
  800e59:	e8 89 ff ff ff       	call   800de7 <vsnprintf>
  800e5e:	83 c4 10             	add    $0x10,%esp
  800e61:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e64:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e76:	eb 06                	jmp    800e7e <strlen+0x15>
		n++;
  800e78:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e7b:	ff 45 08             	incl   0x8(%ebp)
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	8a 00                	mov    (%eax),%al
  800e83:	84 c0                	test   %al,%al
  800e85:	75 f1                	jne    800e78 <strlen+0xf>
		n++;
	return n;
  800e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
  800e8f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e99:	eb 09                	jmp    800ea4 <strnlen+0x18>
		n++;
  800e9b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e9e:	ff 45 08             	incl   0x8(%ebp)
  800ea1:	ff 4d 0c             	decl   0xc(%ebp)
  800ea4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ea8:	74 09                	je     800eb3 <strnlen+0x27>
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	84 c0                	test   %al,%al
  800eb1:	75 e8                	jne    800e9b <strnlen+0xf>
		n++;
	return n;
  800eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eb6:	c9                   	leave  
  800eb7:	c3                   	ret    

00800eb8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800eb8:	55                   	push   %ebp
  800eb9:	89 e5                	mov    %esp,%ebp
  800ebb:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ec4:	90                   	nop
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8d 50 01             	lea    0x1(%eax),%edx
  800ecb:	89 55 08             	mov    %edx,0x8(%ebp)
  800ece:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ed4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ed7:	8a 12                	mov    (%edx),%dl
  800ed9:	88 10                	mov    %dl,(%eax)
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	84 c0                	test   %al,%al
  800edf:	75 e4                	jne    800ec5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee4:	c9                   	leave  
  800ee5:	c3                   	ret    

00800ee6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ee6:	55                   	push   %ebp
  800ee7:	89 e5                	mov    %esp,%ebp
  800ee9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ef2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef9:	eb 1f                	jmp    800f1a <strncpy+0x34>
		*dst++ = *src;
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8d 50 01             	lea    0x1(%eax),%edx
  800f01:	89 55 08             	mov    %edx,0x8(%ebp)
  800f04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f07:	8a 12                	mov    (%edx),%dl
  800f09:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	84 c0                	test   %al,%al
  800f12:	74 03                	je     800f17 <strncpy+0x31>
			src++;
  800f14:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f17:	ff 45 fc             	incl   -0x4(%ebp)
  800f1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f20:	72 d9                	jb     800efb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f22:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f25:	c9                   	leave  
  800f26:	c3                   	ret    

00800f27 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f27:	55                   	push   %ebp
  800f28:	89 e5                	mov    %esp,%ebp
  800f2a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f33:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f37:	74 30                	je     800f69 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f39:	eb 16                	jmp    800f51 <strlcpy+0x2a>
			*dst++ = *src++;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8d 50 01             	lea    0x1(%eax),%edx
  800f41:	89 55 08             	mov    %edx,0x8(%ebp)
  800f44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f47:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f4a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f4d:	8a 12                	mov    (%edx),%dl
  800f4f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f51:	ff 4d 10             	decl   0x10(%ebp)
  800f54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f58:	74 09                	je     800f63 <strlcpy+0x3c>
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	84 c0                	test   %al,%al
  800f61:	75 d8                	jne    800f3b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f69:	8b 55 08             	mov    0x8(%ebp),%edx
  800f6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6f:	29 c2                	sub    %eax,%edx
  800f71:	89 d0                	mov    %edx,%eax
}
  800f73:	c9                   	leave  
  800f74:	c3                   	ret    

00800f75 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f75:	55                   	push   %ebp
  800f76:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f78:	eb 06                	jmp    800f80 <strcmp+0xb>
		p++, q++;
  800f7a:	ff 45 08             	incl   0x8(%ebp)
  800f7d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	84 c0                	test   %al,%al
  800f87:	74 0e                	je     800f97 <strcmp+0x22>
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 10                	mov    (%eax),%dl
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	38 c2                	cmp    %al,%dl
  800f95:	74 e3                	je     800f7a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	0f b6 d0             	movzbl %al,%edx
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	0f b6 c0             	movzbl %al,%eax
  800fa7:	29 c2                	sub    %eax,%edx
  800fa9:	89 d0                	mov    %edx,%eax
}
  800fab:	5d                   	pop    %ebp
  800fac:	c3                   	ret    

00800fad <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fad:	55                   	push   %ebp
  800fae:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fb0:	eb 09                	jmp    800fbb <strncmp+0xe>
		n--, p++, q++;
  800fb2:	ff 4d 10             	decl   0x10(%ebp)
  800fb5:	ff 45 08             	incl   0x8(%ebp)
  800fb8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbf:	74 17                	je     800fd8 <strncmp+0x2b>
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	84 c0                	test   %al,%al
  800fc8:	74 0e                	je     800fd8 <strncmp+0x2b>
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	8a 10                	mov    (%eax),%dl
  800fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	38 c2                	cmp    %al,%dl
  800fd6:	74 da                	je     800fb2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fdc:	75 07                	jne    800fe5 <strncmp+0x38>
		return 0;
  800fde:	b8 00 00 00 00       	mov    $0x0,%eax
  800fe3:	eb 14                	jmp    800ff9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	0f b6 d0             	movzbl %al,%edx
  800fed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	0f b6 c0             	movzbl %al,%eax
  800ff5:	29 c2                	sub    %eax,%edx
  800ff7:	89 d0                	mov    %edx,%eax
}
  800ff9:	5d                   	pop    %ebp
  800ffa:	c3                   	ret    

00800ffb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ffb:	55                   	push   %ebp
  800ffc:	89 e5                	mov    %esp,%ebp
  800ffe:	83 ec 04             	sub    $0x4,%esp
  801001:	8b 45 0c             	mov    0xc(%ebp),%eax
  801004:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801007:	eb 12                	jmp    80101b <strchr+0x20>
		if (*s == c)
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	8a 00                	mov    (%eax),%al
  80100e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801011:	75 05                	jne    801018 <strchr+0x1d>
			return (char *) s;
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	eb 11                	jmp    801029 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801018:	ff 45 08             	incl   0x8(%ebp)
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	84 c0                	test   %al,%al
  801022:	75 e5                	jne    801009 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801024:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801029:	c9                   	leave  
  80102a:	c3                   	ret    

0080102b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80102b:	55                   	push   %ebp
  80102c:	89 e5                	mov    %esp,%ebp
  80102e:	83 ec 04             	sub    $0x4,%esp
  801031:	8b 45 0c             	mov    0xc(%ebp),%eax
  801034:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801037:	eb 0d                	jmp    801046 <strfind+0x1b>
		if (*s == c)
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	8a 00                	mov    (%eax),%al
  80103e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801041:	74 0e                	je     801051 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801043:	ff 45 08             	incl   0x8(%ebp)
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8a 00                	mov    (%eax),%al
  80104b:	84 c0                	test   %al,%al
  80104d:	75 ea                	jne    801039 <strfind+0xe>
  80104f:	eb 01                	jmp    801052 <strfind+0x27>
		if (*s == c)
			break;
  801051:	90                   	nop
	return (char *) s;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
  80105a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801069:	eb 0e                	jmp    801079 <memset+0x22>
		*p++ = c;
  80106b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106e:	8d 50 01             	lea    0x1(%eax),%edx
  801071:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801074:	8b 55 0c             	mov    0xc(%ebp),%edx
  801077:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801079:	ff 4d f8             	decl   -0x8(%ebp)
  80107c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801080:	79 e9                	jns    80106b <memset+0x14>
		*p++ = c;

	return v;
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801085:	c9                   	leave  
  801086:	c3                   	ret    

00801087 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801087:	55                   	push   %ebp
  801088:	89 e5                	mov    %esp,%ebp
  80108a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801099:	eb 16                	jmp    8010b1 <memcpy+0x2a>
		*d++ = *s++;
  80109b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109e:	8d 50 01             	lea    0x1(%eax),%edx
  8010a1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010aa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010ad:	8a 12                	mov    (%edx),%dl
  8010af:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b7:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ba:	85 c0                	test   %eax,%eax
  8010bc:	75 dd                	jne    80109b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c1:	c9                   	leave  
  8010c2:	c3                   	ret    

008010c3 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010c3:	55                   	push   %ebp
  8010c4:	89 e5                	mov    %esp,%ebp
  8010c6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010db:	73 50                	jae    80112d <memmove+0x6a>
  8010dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e3:	01 d0                	add    %edx,%eax
  8010e5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010e8:	76 43                	jbe    80112d <memmove+0x6a>
		s += n;
  8010ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ed:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010f6:	eb 10                	jmp    801108 <memmove+0x45>
			*--d = *--s;
  8010f8:	ff 4d f8             	decl   -0x8(%ebp)
  8010fb:	ff 4d fc             	decl   -0x4(%ebp)
  8010fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801101:	8a 10                	mov    (%eax),%dl
  801103:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801106:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801108:	8b 45 10             	mov    0x10(%ebp),%eax
  80110b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80110e:	89 55 10             	mov    %edx,0x10(%ebp)
  801111:	85 c0                	test   %eax,%eax
  801113:	75 e3                	jne    8010f8 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801115:	eb 23                	jmp    80113a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801117:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111a:	8d 50 01             	lea    0x1(%eax),%edx
  80111d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801120:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801123:	8d 4a 01             	lea    0x1(%edx),%ecx
  801126:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801129:	8a 12                	mov    (%edx),%dl
  80112b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80112d:	8b 45 10             	mov    0x10(%ebp),%eax
  801130:	8d 50 ff             	lea    -0x1(%eax),%edx
  801133:	89 55 10             	mov    %edx,0x10(%ebp)
  801136:	85 c0                	test   %eax,%eax
  801138:	75 dd                	jne    801117 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113d:	c9                   	leave  
  80113e:	c3                   	ret    

0080113f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80113f:	55                   	push   %ebp
  801140:	89 e5                	mov    %esp,%ebp
  801142:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801151:	eb 2a                	jmp    80117d <memcmp+0x3e>
		if (*s1 != *s2)
  801153:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801156:	8a 10                	mov    (%eax),%dl
  801158:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	38 c2                	cmp    %al,%dl
  80115f:	74 16                	je     801177 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801161:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	0f b6 d0             	movzbl %al,%edx
  801169:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	0f b6 c0             	movzbl %al,%eax
  801171:	29 c2                	sub    %eax,%edx
  801173:	89 d0                	mov    %edx,%eax
  801175:	eb 18                	jmp    80118f <memcmp+0x50>
		s1++, s2++;
  801177:	ff 45 fc             	incl   -0x4(%ebp)
  80117a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80117d:	8b 45 10             	mov    0x10(%ebp),%eax
  801180:	8d 50 ff             	lea    -0x1(%eax),%edx
  801183:	89 55 10             	mov    %edx,0x10(%ebp)
  801186:	85 c0                	test   %eax,%eax
  801188:	75 c9                	jne    801153 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80118a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
  801194:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801197:	8b 55 08             	mov    0x8(%ebp),%edx
  80119a:	8b 45 10             	mov    0x10(%ebp),%eax
  80119d:	01 d0                	add    %edx,%eax
  80119f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011a2:	eb 15                	jmp    8011b9 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	0f b6 d0             	movzbl %al,%edx
  8011ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011af:	0f b6 c0             	movzbl %al,%eax
  8011b2:	39 c2                	cmp    %eax,%edx
  8011b4:	74 0d                	je     8011c3 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011b6:	ff 45 08             	incl   0x8(%ebp)
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011bf:	72 e3                	jb     8011a4 <memfind+0x13>
  8011c1:	eb 01                	jmp    8011c4 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011c3:	90                   	nop
	return (void *) s;
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011c7:	c9                   	leave  
  8011c8:	c3                   	ret    

008011c9 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
  8011cc:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011dd:	eb 03                	jmp    8011e2 <strtol+0x19>
		s++;
  8011df:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3c 20                	cmp    $0x20,%al
  8011e9:	74 f4                	je     8011df <strtol+0x16>
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3c 09                	cmp    $0x9,%al
  8011f2:	74 eb                	je     8011df <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	8a 00                	mov    (%eax),%al
  8011f9:	3c 2b                	cmp    $0x2b,%al
  8011fb:	75 05                	jne    801202 <strtol+0x39>
		s++;
  8011fd:	ff 45 08             	incl   0x8(%ebp)
  801200:	eb 13                	jmp    801215 <strtol+0x4c>
	else if (*s == '-')
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3c 2d                	cmp    $0x2d,%al
  801209:	75 0a                	jne    801215 <strtol+0x4c>
		s++, neg = 1;
  80120b:	ff 45 08             	incl   0x8(%ebp)
  80120e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801215:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801219:	74 06                	je     801221 <strtol+0x58>
  80121b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80121f:	75 20                	jne    801241 <strtol+0x78>
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	8a 00                	mov    (%eax),%al
  801226:	3c 30                	cmp    $0x30,%al
  801228:	75 17                	jne    801241 <strtol+0x78>
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	40                   	inc    %eax
  80122e:	8a 00                	mov    (%eax),%al
  801230:	3c 78                	cmp    $0x78,%al
  801232:	75 0d                	jne    801241 <strtol+0x78>
		s += 2, base = 16;
  801234:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801238:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80123f:	eb 28                	jmp    801269 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801241:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801245:	75 15                	jne    80125c <strtol+0x93>
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 30                	cmp    $0x30,%al
  80124e:	75 0c                	jne    80125c <strtol+0x93>
		s++, base = 8;
  801250:	ff 45 08             	incl   0x8(%ebp)
  801253:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80125a:	eb 0d                	jmp    801269 <strtol+0xa0>
	else if (base == 0)
  80125c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801260:	75 07                	jne    801269 <strtol+0xa0>
		base = 10;
  801262:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	3c 2f                	cmp    $0x2f,%al
  801270:	7e 19                	jle    80128b <strtol+0xc2>
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	3c 39                	cmp    $0x39,%al
  801279:	7f 10                	jg     80128b <strtol+0xc2>
			dig = *s - '0';
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	0f be c0             	movsbl %al,%eax
  801283:	83 e8 30             	sub    $0x30,%eax
  801286:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801289:	eb 42                	jmp    8012cd <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	3c 60                	cmp    $0x60,%al
  801292:	7e 19                	jle    8012ad <strtol+0xe4>
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	3c 7a                	cmp    $0x7a,%al
  80129b:	7f 10                	jg     8012ad <strtol+0xe4>
			dig = *s - 'a' + 10;
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	0f be c0             	movsbl %al,%eax
  8012a5:	83 e8 57             	sub    $0x57,%eax
  8012a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012ab:	eb 20                	jmp    8012cd <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	3c 40                	cmp    $0x40,%al
  8012b4:	7e 39                	jle    8012ef <strtol+0x126>
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	3c 5a                	cmp    $0x5a,%al
  8012bd:	7f 30                	jg     8012ef <strtol+0x126>
			dig = *s - 'A' + 10;
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	0f be c0             	movsbl %al,%eax
  8012c7:	83 e8 37             	sub    $0x37,%eax
  8012ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012d0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d3:	7d 19                	jge    8012ee <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012d5:	ff 45 08             	incl   0x8(%ebp)
  8012d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012db:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012df:	89 c2                	mov    %eax,%edx
  8012e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012e4:	01 d0                	add    %edx,%eax
  8012e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012e9:	e9 7b ff ff ff       	jmp    801269 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012ee:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012ef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012f3:	74 08                	je     8012fd <strtol+0x134>
		*endptr = (char *) s;
  8012f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f8:	8b 55 08             	mov    0x8(%ebp),%edx
  8012fb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012fd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801301:	74 07                	je     80130a <strtol+0x141>
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801306:	f7 d8                	neg    %eax
  801308:	eb 03                	jmp    80130d <strtol+0x144>
  80130a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <ltostr>:

void
ltostr(long value, char *str)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
  801312:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801315:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80131c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801323:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801327:	79 13                	jns    80133c <ltostr+0x2d>
	{
		neg = 1;
  801329:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801330:	8b 45 0c             	mov    0xc(%ebp),%eax
  801333:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801336:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801339:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801344:	99                   	cltd   
  801345:	f7 f9                	idiv   %ecx
  801347:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80134a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134d:	8d 50 01             	lea    0x1(%eax),%edx
  801350:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801353:	89 c2                	mov    %eax,%edx
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	01 d0                	add    %edx,%eax
  80135a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80135d:	83 c2 30             	add    $0x30,%edx
  801360:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801362:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801365:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80136a:	f7 e9                	imul   %ecx
  80136c:	c1 fa 02             	sar    $0x2,%edx
  80136f:	89 c8                	mov    %ecx,%eax
  801371:	c1 f8 1f             	sar    $0x1f,%eax
  801374:	29 c2                	sub    %eax,%edx
  801376:	89 d0                	mov    %edx,%eax
  801378:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80137b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80137e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801383:	f7 e9                	imul   %ecx
  801385:	c1 fa 02             	sar    $0x2,%edx
  801388:	89 c8                	mov    %ecx,%eax
  80138a:	c1 f8 1f             	sar    $0x1f,%eax
  80138d:	29 c2                	sub    %eax,%edx
  80138f:	89 d0                	mov    %edx,%eax
  801391:	c1 e0 02             	shl    $0x2,%eax
  801394:	01 d0                	add    %edx,%eax
  801396:	01 c0                	add    %eax,%eax
  801398:	29 c1                	sub    %eax,%ecx
  80139a:	89 ca                	mov    %ecx,%edx
  80139c:	85 d2                	test   %edx,%edx
  80139e:	75 9c                	jne    80133c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8013a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013aa:	48                   	dec    %eax
  8013ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013b2:	74 3d                	je     8013f1 <ltostr+0xe2>
		start = 1 ;
  8013b4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013bb:	eb 34                	jmp    8013f1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c3:	01 d0                	add    %edx,%eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d0:	01 c2                	add    %eax,%edx
  8013d2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d8:	01 c8                	add    %ecx,%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013de:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e4:	01 c2                	add    %eax,%edx
  8013e6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013e9:	88 02                	mov    %al,(%edx)
		start++ ;
  8013eb:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013ee:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013f7:	7c c4                	jl     8013bd <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013f9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ff:	01 d0                	add    %edx,%eax
  801401:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801404:	90                   	nop
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
  80140a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80140d:	ff 75 08             	pushl  0x8(%ebp)
  801410:	e8 54 fa ff ff       	call   800e69 <strlen>
  801415:	83 c4 04             	add    $0x4,%esp
  801418:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80141b:	ff 75 0c             	pushl  0xc(%ebp)
  80141e:	e8 46 fa ff ff       	call   800e69 <strlen>
  801423:	83 c4 04             	add    $0x4,%esp
  801426:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801429:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801430:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801437:	eb 17                	jmp    801450 <strcconcat+0x49>
		final[s] = str1[s] ;
  801439:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80143c:	8b 45 10             	mov    0x10(%ebp),%eax
  80143f:	01 c2                	add    %eax,%edx
  801441:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	01 c8                	add    %ecx,%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80144d:	ff 45 fc             	incl   -0x4(%ebp)
  801450:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801453:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801456:	7c e1                	jl     801439 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801458:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80145f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801466:	eb 1f                	jmp    801487 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801468:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80146b:	8d 50 01             	lea    0x1(%eax),%edx
  80146e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801471:	89 c2                	mov    %eax,%edx
  801473:	8b 45 10             	mov    0x10(%ebp),%eax
  801476:	01 c2                	add    %eax,%edx
  801478:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80147b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147e:	01 c8                	add    %ecx,%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801484:	ff 45 f8             	incl   -0x8(%ebp)
  801487:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80148a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80148d:	7c d9                	jl     801468 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80148f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801492:	8b 45 10             	mov    0x10(%ebp),%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c6 00 00             	movb   $0x0,(%eax)
}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8014a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ac:	8b 00                	mov    (%eax),%eax
  8014ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b8:	01 d0                	add    %edx,%eax
  8014ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014c0:	eb 0c                	jmp    8014ce <strsplit+0x31>
			*string++ = 0;
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	8d 50 01             	lea    0x1(%eax),%edx
  8014c8:	89 55 08             	mov    %edx,0x8(%ebp)
  8014cb:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	8a 00                	mov    (%eax),%al
  8014d3:	84 c0                	test   %al,%al
  8014d5:	74 18                	je     8014ef <strsplit+0x52>
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014da:	8a 00                	mov    (%eax),%al
  8014dc:	0f be c0             	movsbl %al,%eax
  8014df:	50                   	push   %eax
  8014e0:	ff 75 0c             	pushl  0xc(%ebp)
  8014e3:	e8 13 fb ff ff       	call   800ffb <strchr>
  8014e8:	83 c4 08             	add    $0x8,%esp
  8014eb:	85 c0                	test   %eax,%eax
  8014ed:	75 d3                	jne    8014c2 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	84 c0                	test   %al,%al
  8014f6:	74 5a                	je     801552 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8014f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8014fb:	8b 00                	mov    (%eax),%eax
  8014fd:	83 f8 0f             	cmp    $0xf,%eax
  801500:	75 07                	jne    801509 <strsplit+0x6c>
		{
			return 0;
  801502:	b8 00 00 00 00       	mov    $0x0,%eax
  801507:	eb 66                	jmp    80156f <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801509:	8b 45 14             	mov    0x14(%ebp),%eax
  80150c:	8b 00                	mov    (%eax),%eax
  80150e:	8d 48 01             	lea    0x1(%eax),%ecx
  801511:	8b 55 14             	mov    0x14(%ebp),%edx
  801514:	89 0a                	mov    %ecx,(%edx)
  801516:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80151d:	8b 45 10             	mov    0x10(%ebp),%eax
  801520:	01 c2                	add    %eax,%edx
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801527:	eb 03                	jmp    80152c <strsplit+0x8f>
			string++;
  801529:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	8a 00                	mov    (%eax),%al
  801531:	84 c0                	test   %al,%al
  801533:	74 8b                	je     8014c0 <strsplit+0x23>
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	0f be c0             	movsbl %al,%eax
  80153d:	50                   	push   %eax
  80153e:	ff 75 0c             	pushl  0xc(%ebp)
  801541:	e8 b5 fa ff ff       	call   800ffb <strchr>
  801546:	83 c4 08             	add    $0x8,%esp
  801549:	85 c0                	test   %eax,%eax
  80154b:	74 dc                	je     801529 <strsplit+0x8c>
			string++;
	}
  80154d:	e9 6e ff ff ff       	jmp    8014c0 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801552:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801553:	8b 45 14             	mov    0x14(%ebp),%eax
  801556:	8b 00                	mov    (%eax),%eax
  801558:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80155f:	8b 45 10             	mov    0x10(%ebp),%eax
  801562:	01 d0                	add    %edx,%eax
  801564:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80156a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80156f:	c9                   	leave  
  801570:	c3                   	ret    

00801571 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
  801574:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  801577:	a1 04 30 80 00       	mov    0x803004,%eax
  80157c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80157f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  801586:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80158d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801594:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  80159b:	e9 f9 00 00 00       	jmp    801699 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  8015a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015a3:	05 00 00 00 80       	add    $0x80000000,%eax
  8015a8:	c1 e8 0c             	shr    $0xc,%eax
  8015ab:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8015b2:	85 c0                	test   %eax,%eax
  8015b4:	75 1c                	jne    8015d2 <nextFitAlgo+0x61>
  8015b6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8015ba:	74 16                	je     8015d2 <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  8015bc:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8015c3:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  8015ca:	ff 4d e0             	decl   -0x20(%ebp)
  8015cd:	e9 90 00 00 00       	jmp    801662 <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  8015d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d5:	05 00 00 00 80       	add    $0x80000000,%eax
  8015da:	c1 e8 0c             	shr    $0xc,%eax
  8015dd:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8015e4:	85 c0                	test   %eax,%eax
  8015e6:	75 26                	jne    80160e <nextFitAlgo+0x9d>
  8015e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8015ec:	75 20                	jne    80160e <nextFitAlgo+0x9d>
			flag = 1;
  8015ee:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  8015f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  8015fb:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801602:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801609:	ff 4d e0             	decl   -0x20(%ebp)
  80160c:	eb 54                	jmp    801662 <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  80160e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801611:	3b 45 08             	cmp    0x8(%ebp),%eax
  801614:	72 11                	jb     801627 <nextFitAlgo+0xb6>
				startAdd = tmp;
  801616:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801619:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  80161e:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  801625:	eb 7c                	jmp    8016a3 <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801627:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80162a:	05 00 00 00 80       	add    $0x80000000,%eax
  80162f:	c1 e8 0c             	shr    $0xc,%eax
  801632:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801639:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  80163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80163f:	05 00 00 00 80       	add    $0x80000000,%eax
  801644:	c1 e8 0c             	shr    $0xc,%eax
  801647:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80164e:	c1 e0 0c             	shl    $0xc,%eax
  801651:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801654:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80165b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801662:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801665:	3b 45 08             	cmp    0x8(%ebp),%eax
  801668:	72 11                	jb     80167b <nextFitAlgo+0x10a>
			startAdd = tmp;
  80166a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80166d:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801672:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801679:	eb 28                	jmp    8016a3 <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  80167b:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801682:	76 15                	jbe    801699 <nextFitAlgo+0x128>
			flag = newSize = 0;
  801684:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80168b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801692:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801699:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80169d:	0f 85 fd fe ff ff    	jne    8015a0 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  8016a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8016a7:	75 1a                	jne    8016c3 <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  8016a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016ac:	3b 45 08             	cmp    0x8(%ebp),%eax
  8016af:	73 0a                	jae    8016bb <nextFitAlgo+0x14a>
  8016b1:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b6:	e9 99 00 00 00       	jmp    801754 <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  8016bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016be:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  8016c3:	a1 04 30 80 00       	mov    0x803004,%eax
  8016c8:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  8016cb:	a1 04 30 80 00       	mov    0x803004,%eax
  8016d0:	05 00 00 00 80       	add    $0x80000000,%eax
  8016d5:	c1 e8 0c             	shr    $0xc,%eax
  8016d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	c1 e8 0c             	shr    $0xc,%eax
  8016e1:	89 c2                	mov    %eax,%edx
  8016e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e6:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  8016ed:	a1 04 30 80 00       	mov    0x803004,%eax
  8016f2:	83 ec 08             	sub    $0x8,%esp
  8016f5:	ff 75 08             	pushl  0x8(%ebp)
  8016f8:	50                   	push   %eax
  8016f9:	e8 82 03 00 00       	call   801a80 <sys_allocateMem>
  8016fe:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801701:	a1 04 30 80 00       	mov    0x803004,%eax
  801706:	05 00 00 00 80       	add    $0x80000000,%eax
  80170b:	c1 e8 0c             	shr    $0xc,%eax
  80170e:	89 c2                	mov    %eax,%edx
  801710:	a1 04 30 80 00       	mov    0x803004,%eax
  801715:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  80171c:	a1 04 30 80 00       	mov    0x803004,%eax
  801721:	05 00 00 00 80       	add    $0x80000000,%eax
  801726:	c1 e8 0c             	shr    $0xc,%eax
  801729:	89 c2                	mov    %eax,%edx
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801735:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801745:	76 0a                	jbe    801751 <nextFitAlgo+0x1e0>
  801747:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  80174e:	00 00 80 

	return (void*)returnHolder;
  801751:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <malloc>:

void* malloc(uint32 size) {
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
  801759:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  80175c:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801763:	8b 55 08             	mov    0x8(%ebp),%edx
  801766:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801769:	01 d0                	add    %edx,%eax
  80176b:	48                   	dec    %eax
  80176c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80176f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801772:	ba 00 00 00 00       	mov    $0x0,%edx
  801777:	f7 75 f4             	divl   -0xc(%ebp)
  80177a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80177d:	29 d0                	sub    %edx,%eax
  80177f:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801782:	e8 c3 06 00 00       	call   801e4a <sys_isUHeapPlacementStrategyNEXTFIT>
  801787:	85 c0                	test   %eax,%eax
  801789:	74 10                	je     80179b <malloc+0x45>
		return nextFitAlgo(size);
  80178b:	83 ec 0c             	sub    $0xc,%esp
  80178e:	ff 75 08             	pushl  0x8(%ebp)
  801791:	e8 db fd ff ff       	call   801571 <nextFitAlgo>
  801796:	83 c4 10             	add    $0x10,%esp
  801799:	eb 0a                	jmp    8017a5 <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  80179b:	e8 79 06 00 00       	call   801e19 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  8017a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
  8017aa:	83 ec 18             	sub    $0x18,%esp
  8017ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b0:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8017b3:	83 ec 04             	sub    $0x4,%esp
  8017b6:	68 b0 28 80 00       	push   $0x8028b0
  8017bb:	6a 7e                	push   $0x7e
  8017bd:	68 cf 28 80 00       	push   $0x8028cf
  8017c2:	e8 6c ed ff ff       	call   800533 <_panic>

008017c7 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
  8017ca:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8017cd:	83 ec 04             	sub    $0x4,%esp
  8017d0:	68 db 28 80 00       	push   $0x8028db
  8017d5:	68 84 00 00 00       	push   $0x84
  8017da:	68 cf 28 80 00       	push   $0x8028cf
  8017df:	e8 4f ed ff ff       	call   800533 <_panic>

008017e4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8017ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017f1:	eb 61                	jmp    801854 <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  8017f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017f6:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	39 c2                	cmp    %eax,%edx
  801802:	75 4d                	jne    801851 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801804:	8b 45 08             	mov    0x8(%ebp),%eax
  801807:	05 00 00 00 80       	add    $0x80000000,%eax
  80180c:	c1 e8 0c             	shr    $0xc,%eax
  80180f:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801812:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801815:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  80181c:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  80181f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801822:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801829:	00 00 00 00 
  80182d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801830:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801837:	00 00 00 00 
  80183b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80183e:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801845:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801848:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  80184f:	eb 0d                	jmp    80185e <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801851:	ff 45 f0             	incl   -0x10(%ebp)
  801854:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801857:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80185c:	76 95                	jbe    8017f3 <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	83 ec 08             	sub    $0x8,%esp
  801864:	ff 75 f4             	pushl  -0xc(%ebp)
  801867:	50                   	push   %eax
  801868:	e8 f7 01 00 00       	call   801a64 <sys_freeMem>
  80186d:	83 c4 10             	add    $0x10,%esp
}
  801870:	90                   	nop
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sfree>:


void sfree(void* virtual_address)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
  801876:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801879:	83 ec 04             	sub    $0x4,%esp
  80187c:	68 f7 28 80 00       	push   $0x8028f7
  801881:	68 ac 00 00 00       	push   $0xac
  801886:	68 cf 28 80 00       	push   $0x8028cf
  80188b:	e8 a3 ec ff ff       	call   800533 <_panic>

00801890 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
  801893:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801896:	83 ec 04             	sub    $0x4,%esp
  801899:	68 14 29 80 00       	push   $0x802914
  80189e:	68 c4 00 00 00       	push   $0xc4
  8018a3:	68 cf 28 80 00       	push   $0x8028cf
  8018a8:	e8 86 ec ff ff       	call   800533 <_panic>

008018ad <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
  8018b0:	57                   	push   %edi
  8018b1:	56                   	push   %esi
  8018b2:	53                   	push   %ebx
  8018b3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018bf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018c2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8018c5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8018c8:	cd 30                	int    $0x30
  8018ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8018cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018d0:	83 c4 10             	add    $0x10,%esp
  8018d3:	5b                   	pop    %ebx
  8018d4:	5e                   	pop    %esi
  8018d5:	5f                   	pop    %edi
  8018d6:	5d                   	pop    %ebp
  8018d7:	c3                   	ret    

008018d8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
  8018db:	83 ec 04             	sub    $0x4,%esp
  8018de:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018e4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	52                   	push   %edx
  8018f0:	ff 75 0c             	pushl  0xc(%ebp)
  8018f3:	50                   	push   %eax
  8018f4:	6a 00                	push   $0x0
  8018f6:	e8 b2 ff ff ff       	call   8018ad <syscall>
  8018fb:	83 c4 18             	add    $0x18,%esp
}
  8018fe:	90                   	nop
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_cgetc>:

int
sys_cgetc(void)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 01                	push   $0x1
  801910:	e8 98 ff ff ff       	call   8018ad <syscall>
  801915:	83 c4 18             	add    $0x18,%esp
}
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	50                   	push   %eax
  801929:	6a 05                	push   $0x5
  80192b:	e8 7d ff ff ff       	call   8018ad <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 02                	push   $0x2
  801944:	e8 64 ff ff ff       	call   8018ad <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
}
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 03                	push   $0x3
  80195d:	e8 4b ff ff ff       	call   8018ad <syscall>
  801962:	83 c4 18             	add    $0x18,%esp
}
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 04                	push   $0x4
  801976:	e8 32 ff ff ff       	call   8018ad <syscall>
  80197b:	83 c4 18             	add    $0x18,%esp
}
  80197e:	c9                   	leave  
  80197f:	c3                   	ret    

00801980 <sys_env_exit>:


void sys_env_exit(void)
{
  801980:	55                   	push   %ebp
  801981:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 06                	push   $0x6
  80198f:	e8 19 ff ff ff       	call   8018ad <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	90                   	nop
  801998:	c9                   	leave  
  801999:	c3                   	ret    

0080199a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80199d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	52                   	push   %edx
  8019aa:	50                   	push   %eax
  8019ab:	6a 07                	push   $0x7
  8019ad:	e8 fb fe ff ff       	call   8018ad <syscall>
  8019b2:	83 c4 18             	add    $0x18,%esp
}
  8019b5:	c9                   	leave  
  8019b6:	c3                   	ret    

008019b7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8019b7:	55                   	push   %ebp
  8019b8:	89 e5                	mov    %esp,%ebp
  8019ba:	56                   	push   %esi
  8019bb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8019bc:	8b 75 18             	mov    0x18(%ebp),%esi
  8019bf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cb:	56                   	push   %esi
  8019cc:	53                   	push   %ebx
  8019cd:	51                   	push   %ecx
  8019ce:	52                   	push   %edx
  8019cf:	50                   	push   %eax
  8019d0:	6a 08                	push   $0x8
  8019d2:	e8 d6 fe ff ff       	call   8018ad <syscall>
  8019d7:	83 c4 18             	add    $0x18,%esp
}
  8019da:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019dd:	5b                   	pop    %ebx
  8019de:	5e                   	pop    %esi
  8019df:	5d                   	pop    %ebp
  8019e0:	c3                   	ret    

008019e1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019e1:	55                   	push   %ebp
  8019e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	52                   	push   %edx
  8019f1:	50                   	push   %eax
  8019f2:	6a 09                	push   $0x9
  8019f4:	e8 b4 fe ff ff       	call   8018ad <syscall>
  8019f9:	83 c4 18             	add    $0x18,%esp
}
  8019fc:	c9                   	leave  
  8019fd:	c3                   	ret    

008019fe <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	ff 75 0c             	pushl  0xc(%ebp)
  801a0a:	ff 75 08             	pushl  0x8(%ebp)
  801a0d:	6a 0a                	push   $0xa
  801a0f:	e8 99 fe ff ff       	call   8018ad <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 0b                	push   $0xb
  801a28:	e8 80 fe ff ff       	call   8018ad <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	c9                   	leave  
  801a31:	c3                   	ret    

00801a32 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a32:	55                   	push   %ebp
  801a33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 0c                	push   $0xc
  801a41:	e8 67 fe ff ff       	call   8018ad <syscall>
  801a46:	83 c4 18             	add    $0x18,%esp
}
  801a49:	c9                   	leave  
  801a4a:	c3                   	ret    

00801a4b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a4b:	55                   	push   %ebp
  801a4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 0d                	push   $0xd
  801a5a:	e8 4e fe ff ff       	call   8018ad <syscall>
  801a5f:	83 c4 18             	add    $0x18,%esp
}
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	ff 75 0c             	pushl  0xc(%ebp)
  801a70:	ff 75 08             	pushl  0x8(%ebp)
  801a73:	6a 11                	push   $0x11
  801a75:	e8 33 fe ff ff       	call   8018ad <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
	return;
  801a7d:	90                   	nop
}
  801a7e:	c9                   	leave  
  801a7f:	c3                   	ret    

00801a80 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	ff 75 0c             	pushl  0xc(%ebp)
  801a8c:	ff 75 08             	pushl  0x8(%ebp)
  801a8f:	6a 12                	push   $0x12
  801a91:	e8 17 fe ff ff       	call   8018ad <syscall>
  801a96:	83 c4 18             	add    $0x18,%esp
	return ;
  801a99:	90                   	nop
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 0e                	push   $0xe
  801aab:	e8 fd fd ff ff       	call   8018ad <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	ff 75 08             	pushl  0x8(%ebp)
  801ac3:	6a 0f                	push   $0xf
  801ac5:	e8 e3 fd ff ff       	call   8018ad <syscall>
  801aca:	83 c4 18             	add    $0x18,%esp
}
  801acd:	c9                   	leave  
  801ace:	c3                   	ret    

00801acf <sys_scarce_memory>:

void sys_scarce_memory()
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 10                	push   $0x10
  801ade:	e8 ca fd ff ff       	call   8018ad <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	90                   	nop
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 14                	push   $0x14
  801af8:	e8 b0 fd ff ff       	call   8018ad <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	90                   	nop
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 15                	push   $0x15
  801b12:	e8 96 fd ff ff       	call   8018ad <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	90                   	nop
  801b1b:	c9                   	leave  
  801b1c:	c3                   	ret    

00801b1d <sys_cputc>:


void
sys_cputc(const char c)
{
  801b1d:	55                   	push   %ebp
  801b1e:	89 e5                	mov    %esp,%ebp
  801b20:	83 ec 04             	sub    $0x4,%esp
  801b23:	8b 45 08             	mov    0x8(%ebp),%eax
  801b26:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b29:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	50                   	push   %eax
  801b36:	6a 16                	push   $0x16
  801b38:	e8 70 fd ff ff       	call   8018ad <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	90                   	nop
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 17                	push   $0x17
  801b52:	e8 56 fd ff ff       	call   8018ad <syscall>
  801b57:	83 c4 18             	add    $0x18,%esp
}
  801b5a:	90                   	nop
  801b5b:	c9                   	leave  
  801b5c:	c3                   	ret    

00801b5d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b5d:	55                   	push   %ebp
  801b5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b60:	8b 45 08             	mov    0x8(%ebp),%eax
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	ff 75 0c             	pushl  0xc(%ebp)
  801b6c:	50                   	push   %eax
  801b6d:	6a 18                	push   $0x18
  801b6f:	e8 39 fd ff ff       	call   8018ad <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	52                   	push   %edx
  801b89:	50                   	push   %eax
  801b8a:	6a 1b                	push   $0x1b
  801b8c:	e8 1c fd ff ff       	call   8018ad <syscall>
  801b91:	83 c4 18             	add    $0x18,%esp
}
  801b94:	c9                   	leave  
  801b95:	c3                   	ret    

00801b96 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b96:	55                   	push   %ebp
  801b97:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	52                   	push   %edx
  801ba6:	50                   	push   %eax
  801ba7:	6a 19                	push   $0x19
  801ba9:	e8 ff fc ff ff       	call   8018ad <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	90                   	nop
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bba:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	52                   	push   %edx
  801bc4:	50                   	push   %eax
  801bc5:	6a 1a                	push   $0x1a
  801bc7:	e8 e1 fc ff ff       	call   8018ad <syscall>
  801bcc:	83 c4 18             	add    $0x18,%esp
}
  801bcf:	90                   	nop
  801bd0:	c9                   	leave  
  801bd1:	c3                   	ret    

00801bd2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801bd2:	55                   	push   %ebp
  801bd3:	89 e5                	mov    %esp,%ebp
  801bd5:	83 ec 04             	sub    $0x4,%esp
  801bd8:	8b 45 10             	mov    0x10(%ebp),%eax
  801bdb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801bde:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801be1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	6a 00                	push   $0x0
  801bea:	51                   	push   %ecx
  801beb:	52                   	push   %edx
  801bec:	ff 75 0c             	pushl  0xc(%ebp)
  801bef:	50                   	push   %eax
  801bf0:	6a 1c                	push   $0x1c
  801bf2:	e8 b6 fc ff ff       	call   8018ad <syscall>
  801bf7:	83 c4 18             	add    $0x18,%esp
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c02:	8b 45 08             	mov    0x8(%ebp),%eax
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	52                   	push   %edx
  801c0c:	50                   	push   %eax
  801c0d:	6a 1d                	push   $0x1d
  801c0f:	e8 99 fc ff ff       	call   8018ad <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c22:	8b 45 08             	mov    0x8(%ebp),%eax
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	51                   	push   %ecx
  801c2a:	52                   	push   %edx
  801c2b:	50                   	push   %eax
  801c2c:	6a 1e                	push   $0x1e
  801c2e:	e8 7a fc ff ff       	call   8018ad <syscall>
  801c33:	83 c4 18             	add    $0x18,%esp
}
  801c36:	c9                   	leave  
  801c37:	c3                   	ret    

00801c38 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c38:	55                   	push   %ebp
  801c39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	52                   	push   %edx
  801c48:	50                   	push   %eax
  801c49:	6a 1f                	push   $0x1f
  801c4b:	e8 5d fc ff ff       	call   8018ad <syscall>
  801c50:	83 c4 18             	add    $0x18,%esp
}
  801c53:	c9                   	leave  
  801c54:	c3                   	ret    

00801c55 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c55:	55                   	push   %ebp
  801c56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 20                	push   $0x20
  801c64:	e8 44 fc ff ff       	call   8018ad <syscall>
  801c69:	83 c4 18             	add    $0x18,%esp
}
  801c6c:	c9                   	leave  
  801c6d:	c3                   	ret    

00801c6e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801c71:	8b 45 08             	mov    0x8(%ebp),%eax
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	ff 75 10             	pushl  0x10(%ebp)
  801c7b:	ff 75 0c             	pushl  0xc(%ebp)
  801c7e:	50                   	push   %eax
  801c7f:	6a 21                	push   $0x21
  801c81:	e8 27 fc ff ff       	call   8018ad <syscall>
  801c86:	83 c4 18             	add    $0x18,%esp
}
  801c89:	c9                   	leave  
  801c8a:	c3                   	ret    

00801c8b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c8b:	55                   	push   %ebp
  801c8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	50                   	push   %eax
  801c9a:	6a 22                	push   $0x22
  801c9c:	e8 0c fc ff ff       	call   8018ad <syscall>
  801ca1:	83 c4 18             	add    $0x18,%esp
}
  801ca4:	90                   	nop
  801ca5:	c9                   	leave  
  801ca6:	c3                   	ret    

00801ca7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801caa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	50                   	push   %eax
  801cb6:	6a 23                	push   $0x23
  801cb8:	e8 f0 fb ff ff       	call   8018ad <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	90                   	nop
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
  801cc6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801cc9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ccc:	8d 50 04             	lea    0x4(%eax),%edx
  801ccf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	52                   	push   %edx
  801cd9:	50                   	push   %eax
  801cda:	6a 24                	push   $0x24
  801cdc:	e8 cc fb ff ff       	call   8018ad <syscall>
  801ce1:	83 c4 18             	add    $0x18,%esp
	return result;
  801ce4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ce7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ced:	89 01                	mov    %eax,(%ecx)
  801cef:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf5:	c9                   	leave  
  801cf6:	c2 04 00             	ret    $0x4

00801cf9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	ff 75 10             	pushl  0x10(%ebp)
  801d03:	ff 75 0c             	pushl  0xc(%ebp)
  801d06:	ff 75 08             	pushl  0x8(%ebp)
  801d09:	6a 13                	push   $0x13
  801d0b:	e8 9d fb ff ff       	call   8018ad <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
	return ;
  801d13:	90                   	nop
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 25                	push   $0x25
  801d25:	e8 83 fb ff ff       	call   8018ad <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
}
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    

00801d2f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
  801d32:	83 ec 04             	sub    $0x4,%esp
  801d35:	8b 45 08             	mov    0x8(%ebp),%eax
  801d38:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d3b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	50                   	push   %eax
  801d48:	6a 26                	push   $0x26
  801d4a:	e8 5e fb ff ff       	call   8018ad <syscall>
  801d4f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d52:	90                   	nop
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <rsttst>:
void rsttst()
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 28                	push   $0x28
  801d64:	e8 44 fb ff ff       	call   8018ad <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6c:	90                   	nop
}
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	83 ec 04             	sub    $0x4,%esp
  801d75:	8b 45 14             	mov    0x14(%ebp),%eax
  801d78:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d7b:	8b 55 18             	mov    0x18(%ebp),%edx
  801d7e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d82:	52                   	push   %edx
  801d83:	50                   	push   %eax
  801d84:	ff 75 10             	pushl  0x10(%ebp)
  801d87:	ff 75 0c             	pushl  0xc(%ebp)
  801d8a:	ff 75 08             	pushl  0x8(%ebp)
  801d8d:	6a 27                	push   $0x27
  801d8f:	e8 19 fb ff ff       	call   8018ad <syscall>
  801d94:	83 c4 18             	add    $0x18,%esp
	return ;
  801d97:	90                   	nop
}
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <chktst>:
void chktst(uint32 n)
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	ff 75 08             	pushl  0x8(%ebp)
  801da8:	6a 29                	push   $0x29
  801daa:	e8 fe fa ff ff       	call   8018ad <syscall>
  801daf:	83 c4 18             	add    $0x18,%esp
	return ;
  801db2:	90                   	nop
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <inctst>:

void inctst()
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 2a                	push   $0x2a
  801dc4:	e8 e4 fa ff ff       	call   8018ad <syscall>
  801dc9:	83 c4 18             	add    $0x18,%esp
	return ;
  801dcc:	90                   	nop
}
  801dcd:	c9                   	leave  
  801dce:	c3                   	ret    

00801dcf <gettst>:
uint32 gettst()
{
  801dcf:	55                   	push   %ebp
  801dd0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 2b                	push   $0x2b
  801dde:	e8 ca fa ff ff       	call   8018ad <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
  801deb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 2c                	push   $0x2c
  801dfa:	e8 ae fa ff ff       	call   8018ad <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
  801e02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e05:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e09:	75 07                	jne    801e12 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e0b:	b8 01 00 00 00       	mov    $0x1,%eax
  801e10:	eb 05                	jmp    801e17 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
  801e1c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 2c                	push   $0x2c
  801e2b:	e8 7d fa ff ff       	call   8018ad <syscall>
  801e30:	83 c4 18             	add    $0x18,%esp
  801e33:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e36:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e3a:	75 07                	jne    801e43 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e3c:	b8 01 00 00 00       	mov    $0x1,%eax
  801e41:	eb 05                	jmp    801e48 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e43:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e48:	c9                   	leave  
  801e49:	c3                   	ret    

00801e4a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e4a:	55                   	push   %ebp
  801e4b:	89 e5                	mov    %esp,%ebp
  801e4d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 2c                	push   $0x2c
  801e5c:	e8 4c fa ff ff       	call   8018ad <syscall>
  801e61:	83 c4 18             	add    $0x18,%esp
  801e64:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e67:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e6b:	75 07                	jne    801e74 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e6d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e72:	eb 05                	jmp    801e79 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
  801e7e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 2c                	push   $0x2c
  801e8d:	e8 1b fa ff ff       	call   8018ad <syscall>
  801e92:	83 c4 18             	add    $0x18,%esp
  801e95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e98:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e9c:	75 07                	jne    801ea5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801ea3:	eb 05                	jmp    801eaa <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ea5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801eaa:	c9                   	leave  
  801eab:	c3                   	ret    

00801eac <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801eac:	55                   	push   %ebp
  801ead:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	ff 75 08             	pushl  0x8(%ebp)
  801eba:	6a 2d                	push   $0x2d
  801ebc:	e8 ec f9 ff ff       	call   8018ad <syscall>
  801ec1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec4:	90                   	nop
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    
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
