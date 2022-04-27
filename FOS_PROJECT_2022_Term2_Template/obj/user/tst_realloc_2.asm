
obj/user/tst_realloc_2:     file format elf32-i386


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
  800031:	e8 b7 12 00 00       	call   8012ed <libmain>
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
  800040:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  800047:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	void* ptr_allocations[20] = {0};
  80004e:	8d 95 78 ff ff ff    	lea    -0x88(%ebp),%edx
  800054:	b9 14 00 00 00       	mov    $0x14,%ecx
  800059:	b8 00 00 00 00       	mov    $0x0,%eax
  80005e:	89 d7                	mov    %edx,%edi
  800060:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  800062:	83 ec 0c             	sub    $0xc,%esp
  800065:	68 60 2d 80 00       	push   $0x802d60
  80006a:	e8 41 16 00 00       	call   8016b0 <cprintf>
  80006f:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800072:	e8 d1 25 00 00       	call   802648 <sys_calculate_free_frames>
  800077:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80007a:	e8 4c 26 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80007f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  800082:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800085:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800088:	83 ec 0c             	sub    $0xc,%esp
  80008b:	50                   	push   %eax
  80008c:	e8 a9 23 00 00       	call   80243a <malloc>
  800091:	83 c4 10             	add    $0x10,%esp
  800094:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		if ((uint32) ptr_allocations[0] !=  (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80009a:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8000a0:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000a5:	74 14                	je     8000bb <_main+0x83>
  8000a7:	83 ec 04             	sub    $0x4,%esp
  8000aa:	68 84 2d 80 00       	push   $0x802d84
  8000af:	6a 11                	push   $0x11
  8000b1:	68 b4 2d 80 00       	push   $0x802db4
  8000b6:	e8 41 13 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000bb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8000be:	e8 85 25 00 00       	call   802648 <sys_calculate_free_frames>
  8000c3:	29 c3                	sub    %eax,%ebx
  8000c5:	89 d8                	mov    %ebx,%eax
  8000c7:	83 f8 01             	cmp    $0x1,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 cc 2d 80 00       	push   $0x802dcc
  8000d4:	6a 13                	push   $0x13
  8000d6:	68 b4 2d 80 00       	push   $0x802db4
  8000db:	e8 1c 13 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  8000e0:	e8 e6 25 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8000e5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000e8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8000ed:	74 14                	je     800103 <_main+0xcb>
  8000ef:	83 ec 04             	sub    $0x4,%esp
  8000f2:	68 38 2e 80 00       	push   $0x802e38
  8000f7:	6a 14                	push   $0x14
  8000f9:	68 b4 2d 80 00       	push   $0x802db4
  8000fe:	e8 f9 12 00 00       	call   8013fc <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800103:	e8 40 25 00 00       	call   802648 <sys_calculate_free_frames>
  800108:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80010b:	e8 bb 25 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800110:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800113:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800116:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	50                   	push   %eax
  80011d:	e8 18 23 00 00       	call   80243a <malloc>
  800122:	83 c4 10             	add    $0x10,%esp
  800125:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80012b:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800131:	89 c2                	mov    %eax,%edx
  800133:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800136:	05 00 00 00 80       	add    $0x80000000,%eax
  80013b:	39 c2                	cmp    %eax,%edx
  80013d:	74 14                	je     800153 <_main+0x11b>
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 84 2d 80 00       	push   $0x802d84
  800147:	6a 1a                	push   $0x1a
  800149:	68 b4 2d 80 00       	push   $0x802db4
  80014e:	e8 a9 12 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800153:	e8 f0 24 00 00       	call   802648 <sys_calculate_free_frames>
  800158:	89 c2                	mov    %eax,%edx
  80015a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80015d:	39 c2                	cmp    %eax,%edx
  80015f:	74 14                	je     800175 <_main+0x13d>
  800161:	83 ec 04             	sub    $0x4,%esp
  800164:	68 cc 2d 80 00       	push   $0x802dcc
  800169:	6a 1c                	push   $0x1c
  80016b:	68 b4 2d 80 00       	push   $0x802db4
  800170:	e8 87 12 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800175:	e8 51 25 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80017a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80017d:	3d 00 01 00 00       	cmp    $0x100,%eax
  800182:	74 14                	je     800198 <_main+0x160>
  800184:	83 ec 04             	sub    $0x4,%esp
  800187:	68 38 2e 80 00       	push   $0x802e38
  80018c:	6a 1d                	push   $0x1d
  80018e:	68 b4 2d 80 00       	push   $0x802db4
  800193:	e8 64 12 00 00       	call   8013fc <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800198:	e8 ab 24 00 00       	call   802648 <sys_calculate_free_frames>
  80019d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001a0:	e8 26 25 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8001a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001ab:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001ae:	83 ec 0c             	sub    $0xc,%esp
  8001b1:	50                   	push   %eax
  8001b2:	e8 83 22 00 00       	call   80243a <malloc>
  8001b7:	83 c4 10             	add    $0x10,%esp
  8001ba:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  8001bd:	8b 45 80             	mov    -0x80(%ebp),%eax
  8001c0:	89 c2                	mov    %eax,%edx
  8001c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001c5:	01 c0                	add    %eax,%eax
  8001c7:	05 00 00 00 80       	add    $0x80000000,%eax
  8001cc:	39 c2                	cmp    %eax,%edx
  8001ce:	74 14                	je     8001e4 <_main+0x1ac>
  8001d0:	83 ec 04             	sub    $0x4,%esp
  8001d3:	68 84 2d 80 00       	push   $0x802d84
  8001d8:	6a 23                	push   $0x23
  8001da:	68 b4 2d 80 00       	push   $0x802db4
  8001df:	e8 18 12 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001e4:	e8 5f 24 00 00       	call   802648 <sys_calculate_free_frames>
  8001e9:	89 c2                	mov    %eax,%edx
  8001eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001ee:	39 c2                	cmp    %eax,%edx
  8001f0:	74 14                	je     800206 <_main+0x1ce>
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	68 cc 2d 80 00       	push   $0x802dcc
  8001fa:	6a 25                	push   $0x25
  8001fc:	68 b4 2d 80 00       	push   $0x802db4
  800201:	e8 f6 11 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800206:	e8 c0 24 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80020b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80020e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800213:	74 14                	je     800229 <_main+0x1f1>
  800215:	83 ec 04             	sub    $0x4,%esp
  800218:	68 38 2e 80 00       	push   $0x802e38
  80021d:	6a 26                	push   $0x26
  80021f:	68 b4 2d 80 00       	push   $0x802db4
  800224:	e8 d3 11 00 00       	call   8013fc <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800229:	e8 1a 24 00 00       	call   802648 <sys_calculate_free_frames>
  80022e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800231:	e8 95 24 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800236:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800239:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80023c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80023f:	83 ec 0c             	sub    $0xc,%esp
  800242:	50                   	push   %eax
  800243:	e8 f2 21 00 00       	call   80243a <malloc>
  800248:	83 c4 10             	add    $0x10,%esp
  80024b:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  80024e:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800251:	89 c1                	mov    %eax,%ecx
  800253:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800256:	89 c2                	mov    %eax,%edx
  800258:	01 d2                	add    %edx,%edx
  80025a:	01 d0                	add    %edx,%eax
  80025c:	05 00 00 00 80       	add    $0x80000000,%eax
  800261:	39 c1                	cmp    %eax,%ecx
  800263:	74 14                	je     800279 <_main+0x241>
  800265:	83 ec 04             	sub    $0x4,%esp
  800268:	68 84 2d 80 00       	push   $0x802d84
  80026d:	6a 2c                	push   $0x2c
  80026f:	68 b4 2d 80 00       	push   $0x802db4
  800274:	e8 83 11 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800279:	e8 ca 23 00 00       	call   802648 <sys_calculate_free_frames>
  80027e:	89 c2                	mov    %eax,%edx
  800280:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800283:	39 c2                	cmp    %eax,%edx
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 cc 2d 80 00       	push   $0x802dcc
  80028f:	6a 2e                	push   $0x2e
  800291:	68 b4 2d 80 00       	push   $0x802db4
  800296:	e8 61 11 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  80029b:	e8 2b 24 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8002a0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002a3:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002a8:	74 14                	je     8002be <_main+0x286>
  8002aa:	83 ec 04             	sub    $0x4,%esp
  8002ad:	68 38 2e 80 00       	push   $0x802e38
  8002b2:	6a 2f                	push   $0x2f
  8002b4:	68 b4 2d 80 00       	push   $0x802db4
  8002b9:	e8 3e 11 00 00       	call   8013fc <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8002be:	e8 85 23 00 00       	call   802648 <sys_calculate_free_frames>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002c6:	e8 00 24 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8002cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  8002ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d1:	01 c0                	add    %eax,%eax
  8002d3:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8002d6:	83 ec 0c             	sub    $0xc,%esp
  8002d9:	50                   	push   %eax
  8002da:	e8 5b 21 00 00       	call   80243a <malloc>
  8002df:	83 c4 10             	add    $0x10,%esp
  8002e2:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8002e5:	8b 45 88             	mov    -0x78(%ebp),%eax
  8002e8:	89 c2                	mov    %eax,%edx
  8002ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002ed:	c1 e0 02             	shl    $0x2,%eax
  8002f0:	05 00 00 00 80       	add    $0x80000000,%eax
  8002f5:	39 c2                	cmp    %eax,%edx
  8002f7:	74 14                	je     80030d <_main+0x2d5>
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	68 84 2d 80 00       	push   $0x802d84
  800301:	6a 35                	push   $0x35
  800303:	68 b4 2d 80 00       	push   $0x802db4
  800308:	e8 ef 10 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80030d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800310:	e8 33 23 00 00       	call   802648 <sys_calculate_free_frames>
  800315:	29 c3                	sub    %eax,%ebx
  800317:	89 d8                	mov    %ebx,%eax
  800319:	83 f8 01             	cmp    $0x1,%eax
  80031c:	74 14                	je     800332 <_main+0x2fa>
  80031e:	83 ec 04             	sub    $0x4,%esp
  800321:	68 cc 2d 80 00       	push   $0x802dcc
  800326:	6a 37                	push   $0x37
  800328:	68 b4 2d 80 00       	push   $0x802db4
  80032d:	e8 ca 10 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800332:	e8 94 23 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800337:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80033a:	3d 00 02 00 00       	cmp    $0x200,%eax
  80033f:	74 14                	je     800355 <_main+0x31d>
  800341:	83 ec 04             	sub    $0x4,%esp
  800344:	68 38 2e 80 00       	push   $0x802e38
  800349:	6a 38                	push   $0x38
  80034b:	68 b4 2d 80 00       	push   $0x802db4
  800350:	e8 a7 10 00 00       	call   8013fc <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800355:	e8 ee 22 00 00       	call   802648 <sys_calculate_free_frames>
  80035a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80035d:	e8 69 23 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800362:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  800365:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800368:	01 c0                	add    %eax,%eax
  80036a:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80036d:	83 ec 0c             	sub    $0xc,%esp
  800370:	50                   	push   %eax
  800371:	e8 c4 20 00 00       	call   80243a <malloc>
  800376:	83 c4 10             	add    $0x10,%esp
  800379:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80037c:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80037f:	89 c1                	mov    %eax,%ecx
  800381:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800384:	89 d0                	mov    %edx,%eax
  800386:	01 c0                	add    %eax,%eax
  800388:	01 d0                	add    %edx,%eax
  80038a:	01 c0                	add    %eax,%eax
  80038c:	05 00 00 00 80       	add    $0x80000000,%eax
  800391:	39 c1                	cmp    %eax,%ecx
  800393:	74 14                	je     8003a9 <_main+0x371>
  800395:	83 ec 04             	sub    $0x4,%esp
  800398:	68 84 2d 80 00       	push   $0x802d84
  80039d:	6a 3e                	push   $0x3e
  80039f:	68 b4 2d 80 00       	push   $0x802db4
  8003a4:	e8 53 10 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003a9:	e8 9a 22 00 00       	call   802648 <sys_calculate_free_frames>
  8003ae:	89 c2                	mov    %eax,%edx
  8003b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b3:	39 c2                	cmp    %eax,%edx
  8003b5:	74 14                	je     8003cb <_main+0x393>
  8003b7:	83 ec 04             	sub    $0x4,%esp
  8003ba:	68 cc 2d 80 00       	push   $0x802dcc
  8003bf:	6a 40                	push   $0x40
  8003c1:	68 b4 2d 80 00       	push   $0x802db4
  8003c6:	e8 31 10 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8003cb:	e8 fb 22 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8003d0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003d3:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 38 2e 80 00       	push   $0x802e38
  8003e2:	6a 41                	push   $0x41
  8003e4:	68 b4 2d 80 00       	push   $0x802db4
  8003e9:	e8 0e 10 00 00       	call   8013fc <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003ee:	e8 55 22 00 00       	call   802648 <sys_calculate_free_frames>
  8003f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003f6:	e8 d0 22 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8003fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8003fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800401:	89 c2                	mov    %eax,%edx
  800403:	01 d2                	add    %edx,%edx
  800405:	01 d0                	add    %edx,%eax
  800407:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80040a:	83 ec 0c             	sub    $0xc,%esp
  80040d:	50                   	push   %eax
  80040e:	e8 27 20 00 00       	call   80243a <malloc>
  800413:	83 c4 10             	add    $0x10,%esp
  800416:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800419:	8b 45 90             	mov    -0x70(%ebp),%eax
  80041c:	89 c2                	mov    %eax,%edx
  80041e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800421:	c1 e0 03             	shl    $0x3,%eax
  800424:	05 00 00 00 80       	add    $0x80000000,%eax
  800429:	39 c2                	cmp    %eax,%edx
  80042b:	74 14                	je     800441 <_main+0x409>
  80042d:	83 ec 04             	sub    $0x4,%esp
  800430:	68 84 2d 80 00       	push   $0x802d84
  800435:	6a 47                	push   $0x47
  800437:	68 b4 2d 80 00       	push   $0x802db4
  80043c:	e8 bb 0f 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800441:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800444:	e8 ff 21 00 00       	call   802648 <sys_calculate_free_frames>
  800449:	29 c3                	sub    %eax,%ebx
  80044b:	89 d8                	mov    %ebx,%eax
  80044d:	83 f8 01             	cmp    $0x1,%eax
  800450:	74 14                	je     800466 <_main+0x42e>
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 cc 2d 80 00       	push   $0x802dcc
  80045a:	6a 49                	push   $0x49
  80045c:	68 b4 2d 80 00       	push   $0x802db4
  800461:	e8 96 0f 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800466:	e8 60 22 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80046b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80046e:	3d 00 03 00 00       	cmp    $0x300,%eax
  800473:	74 14                	je     800489 <_main+0x451>
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	68 38 2e 80 00       	push   $0x802e38
  80047d:	6a 4a                	push   $0x4a
  80047f:	68 b4 2d 80 00       	push   $0x802db4
  800484:	e8 73 0f 00 00       	call   8013fc <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800489:	e8 ba 21 00 00       	call   802648 <sys_calculate_free_frames>
  80048e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800491:	e8 35 22 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800496:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  800499:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	01 d2                	add    %edx,%edx
  8004a0:	01 d0                	add    %edx,%eax
  8004a2:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8004a5:	83 ec 0c             	sub    $0xc,%esp
  8004a8:	50                   	push   %eax
  8004a9:	e8 8c 1f 00 00       	call   80243a <malloc>
  8004ae:	83 c4 10             	add    $0x10,%esp
  8004b1:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[7] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004b4:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004b7:	89 c1                	mov    %eax,%ecx
  8004b9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004bc:	89 d0                	mov    %edx,%eax
  8004be:	c1 e0 02             	shl    $0x2,%eax
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	01 c0                	add    %eax,%eax
  8004c5:	01 d0                	add    %edx,%eax
  8004c7:	05 00 00 00 80       	add    $0x80000000,%eax
  8004cc:	39 c1                	cmp    %eax,%ecx
  8004ce:	74 14                	je     8004e4 <_main+0x4ac>
  8004d0:	83 ec 04             	sub    $0x4,%esp
  8004d3:	68 84 2d 80 00       	push   $0x802d84
  8004d8:	6a 50                	push   $0x50
  8004da:	68 b4 2d 80 00       	push   $0x802db4
  8004df:	e8 18 0f 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004e4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8004e7:	e8 5c 21 00 00       	call   802648 <sys_calculate_free_frames>
  8004ec:	29 c3                	sub    %eax,%ebx
  8004ee:	89 d8                	mov    %ebx,%eax
  8004f0:	83 f8 01             	cmp    $0x1,%eax
  8004f3:	74 14                	je     800509 <_main+0x4d1>
  8004f5:	83 ec 04             	sub    $0x4,%esp
  8004f8:	68 cc 2d 80 00       	push   $0x802dcc
  8004fd:	6a 52                	push   $0x52
  8004ff:	68 b4 2d 80 00       	push   $0x802db4
  800504:	e8 f3 0e 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800509:	e8 bd 21 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80050e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800511:	3d 00 03 00 00       	cmp    $0x300,%eax
  800516:	74 14                	je     80052c <_main+0x4f4>
  800518:	83 ec 04             	sub    $0x4,%esp
  80051b:	68 38 2e 80 00       	push   $0x802e38
  800520:	6a 53                	push   $0x53
  800522:	68 b4 2d 80 00       	push   $0x802db4
  800527:	e8 d0 0e 00 00       	call   8013fc <_panic>

		//Allocate the remaining space in user heap
		freeFrames = sys_calculate_free_frames() ;
  80052c:	e8 17 21 00 00       	call   802648 <sys_calculate_free_frames>
  800531:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800534:	e8 92 21 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800539:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc((USER_HEAP_MAX - USER_HEAP_START) - 14 * Mega - kilo);
  80053c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80053f:	89 d0                	mov    %edx,%eax
  800541:	01 c0                	add    %eax,%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	01 c0                	add    %eax,%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	01 c0                	add    %eax,%eax
  80054b:	f7 d8                	neg    %eax
  80054d:	89 c2                	mov    %eax,%edx
  80054f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800552:	29 c2                	sub    %eax,%edx
  800554:	89 d0                	mov    %edx,%eax
  800556:	05 00 00 00 20       	add    $0x20000000,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 d6 1e 00 00       	call   80243a <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80056a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80056d:	89 c1                	mov    %eax,%ecx
  80056f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800572:	89 d0                	mov    %edx,%eax
  800574:	01 c0                	add    %eax,%eax
  800576:	01 d0                	add    %edx,%eax
  800578:	01 c0                	add    %eax,%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	01 c0                	add    %eax,%eax
  80057e:	05 00 00 00 80       	add    $0x80000000,%eax
  800583:	39 c1                	cmp    %eax,%ecx
  800585:	74 14                	je     80059b <_main+0x563>
  800587:	83 ec 04             	sub    $0x4,%esp
  80058a:	68 84 2d 80 00       	push   $0x802d84
  80058f:	6a 59                	push   $0x59
  800591:	68 b4 2d 80 00       	push   $0x802db4
  800596:	e8 61 0e 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 124) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80059b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80059e:	e8 a5 20 00 00       	call   802648 <sys_calculate_free_frames>
  8005a3:	29 c3                	sub    %eax,%ebx
  8005a5:	89 d8                	mov    %ebx,%eax
  8005a7:	83 f8 7c             	cmp    $0x7c,%eax
  8005aa:	74 14                	je     8005c0 <_main+0x588>
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 cc 2d 80 00       	push   $0x802dcc
  8005b4:	6a 5b                	push   $0x5b
  8005b6:	68 b4 2d 80 00       	push   $0x802db4
  8005bb:	e8 3c 0e 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 127488) panic("Extra or less pages are allocated in PageFile");
  8005c0:	e8 06 21 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8005c5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8005c8:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  8005cd:	74 14                	je     8005e3 <_main+0x5ab>
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	68 38 2e 80 00       	push   $0x802e38
  8005d7:	6a 5c                	push   $0x5c
  8005d9:	68 b4 2d 80 00       	push   $0x802db4
  8005de:	e8 19 0e 00 00       	call   8013fc <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e3:	e8 60 20 00 00       	call   802648 <sys_calculate_free_frames>
  8005e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005eb:	e8 db 20 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8005f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[1]);
  8005f3:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005f9:	83 ec 0c             	sub    $0xc,%esp
  8005fc:	50                   	push   %eax
  8005fd:	e8 8c 1e 00 00       	call   80248e <free>
  800602:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  800605:	e8 c1 20 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80060a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80060d:	29 c2                	sub    %eax,%edx
  80060f:	89 d0                	mov    %edx,%eax
  800611:	3d 00 01 00 00       	cmp    $0x100,%eax
  800616:	74 14                	je     80062c <_main+0x5f4>
  800618:	83 ec 04             	sub    $0x4,%esp
  80061b:	68 68 2e 80 00       	push   $0x802e68
  800620:	6a 67                	push   $0x67
  800622:	68 b4 2d 80 00       	push   $0x802db4
  800627:	e8 d0 0d 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80062c:	e8 17 20 00 00       	call   802648 <sys_calculate_free_frames>
  800631:	89 c2                	mov    %eax,%edx
  800633:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800636:	39 c2                	cmp    %eax,%edx
  800638:	74 14                	je     80064e <_main+0x616>
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	68 a4 2e 80 00       	push   $0x802ea4
  800642:	6a 68                	push   $0x68
  800644:	68 b4 2d 80 00       	push   $0x802db4
  800649:	e8 ae 0d 00 00       	call   8013fc <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80064e:	e8 f5 1f 00 00       	call   802648 <sys_calculate_free_frames>
  800653:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800656:	e8 70 20 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80065b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[4]);
  80065e:	8b 45 88             	mov    -0x78(%ebp),%eax
  800661:	83 ec 0c             	sub    $0xc,%esp
  800664:	50                   	push   %eax
  800665:	e8 24 1e 00 00       	call   80248e <free>
  80066a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80066d:	e8 59 20 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800672:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800675:	29 c2                	sub    %eax,%edx
  800677:	89 d0                	mov    %edx,%eax
  800679:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067e:	74 14                	je     800694 <_main+0x65c>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 68 2e 80 00       	push   $0x802e68
  800688:	6a 6f                	push   $0x6f
  80068a:	68 b4 2d 80 00       	push   $0x802db4
  80068f:	e8 68 0d 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800694:	e8 af 1f 00 00       	call   802648 <sys_calculate_free_frames>
  800699:	89 c2                	mov    %eax,%edx
  80069b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80069e:	39 c2                	cmp    %eax,%edx
  8006a0:	74 14                	je     8006b6 <_main+0x67e>
  8006a2:	83 ec 04             	sub    $0x4,%esp
  8006a5:	68 a4 2e 80 00       	push   $0x802ea4
  8006aa:	6a 70                	push   $0x70
  8006ac:	68 b4 2d 80 00       	push   $0x802db4
  8006b1:	e8 46 0d 00 00       	call   8013fc <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8006b6:	e8 8d 1f 00 00       	call   802648 <sys_calculate_free_frames>
  8006bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006be:	e8 08 20 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8006c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  8006c6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8006c9:	83 ec 0c             	sub    $0xc,%esp
  8006cc:	50                   	push   %eax
  8006cd:	e8 bc 1d 00 00       	call   80248e <free>
  8006d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 768) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006d5:	e8 f1 1f 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8006da:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8006dd:	29 c2                	sub    %eax,%edx
  8006df:	89 d0                	mov    %edx,%eax
  8006e1:	3d 00 03 00 00       	cmp    $0x300,%eax
  8006e6:	74 14                	je     8006fc <_main+0x6c4>
  8006e8:	83 ec 04             	sub    $0x4,%esp
  8006eb:	68 68 2e 80 00       	push   $0x802e68
  8006f0:	6a 77                	push   $0x77
  8006f2:	68 b4 2d 80 00       	push   $0x802db4
  8006f7:	e8 00 0d 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8006fc:	e8 47 1f 00 00       	call   802648 <sys_calculate_free_frames>
  800701:	89 c2                	mov    %eax,%edx
  800703:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800706:	39 c2                	cmp    %eax,%edx
  800708:	74 14                	je     80071e <_main+0x6e6>
  80070a:	83 ec 04             	sub    $0x4,%esp
  80070d:	68 a4 2e 80 00       	push   $0x802ea4
  800712:	6a 78                	push   $0x78
  800714:	68 b4 2d 80 00       	push   $0x802db4
  800719:	e8 de 0c 00 00       	call   8013fc <_panic>
//		free(ptr_allocations[8]);
//		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
//		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 127488) panic("Wrong free: Extra or less pages are removed from PageFile");
//		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
	}
	int cnt = 0;
  80071e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  800725:	83 ec 0c             	sub    $0xc,%esp
  800728:	6a 03                	push   $0x3
  80072a:	e8 2f 22 00 00       	call   80295e <sys_bypassPageFault>
  80072f:	83 c4 10             	add    $0x10,%esp

	//[3] Test Re-allocation
	{
		/*CASE1: Re-allocate with size = 0*/

		char *byteArr = (char *) ptr_allocations[0];
  800732:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800738:	89 45 d8             	mov    %eax,-0x28(%ebp)

		//Reallocate with size = 0 [delete it]
		freeFrames = sys_calculate_free_frames() ;
  80073b:	e8 08 1f 00 00       	call   802648 <sys_calculate_free_frames>
  800740:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800743:	e8 83 1f 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800748:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 0);
  80074b:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800751:	83 ec 08             	sub    $0x8,%esp
  800754:	6a 00                	push   $0x0
  800756:	50                   	push   %eax
  800757:	e8 66 1d 00 00       	call   8024c2 <realloc>
  80075c:	83 c4 10             	add    $0x10,%esp
  80075f:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != 0) panic("Wrong start address for the re-allocated space...it should return NULL!");
  800765:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80076b:	85 c0                	test   %eax,%eax
  80076d:	74 17                	je     800786 <_main+0x74e>
  80076f:	83 ec 04             	sub    $0x4,%esp
  800772:	68 f0 2e 80 00       	push   $0x802ef0
  800777:	68 94 00 00 00       	push   $0x94
  80077c:	68 b4 2d 80 00       	push   $0x802db4
  800781:	e8 76 0c 00 00       	call   8013fc <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800786:	e8 bd 1e 00 00       	call   802648 <sys_calculate_free_frames>
  80078b:	89 c2                	mov    %eax,%edx
  80078d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800790:	39 c2                	cmp    %eax,%edx
  800792:	74 17                	je     8007ab <_main+0x773>
  800794:	83 ec 04             	sub    $0x4,%esp
  800797:	68 38 2f 80 00       	push   $0x802f38
  80079c:	68 96 00 00 00       	push   $0x96
  8007a1:	68 b4 2d 80 00       	push   $0x802db4
  8007a6:	e8 51 0c 00 00       	call   8013fc <_panic>
		if((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Extra or less pages are re-allocated in PageFile");
  8007ab:	e8 1b 1f 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8007b0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8007b3:	29 c2                	sub    %eax,%edx
  8007b5:	89 d0                	mov    %edx,%eax
  8007b7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007bc:	74 17                	je     8007d5 <_main+0x79d>
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	68 a8 2f 80 00       	push   $0x802fa8
  8007c6:	68 97 00 00 00       	push   $0x97
  8007cb:	68 b4 2d 80 00       	push   $0x802db4
  8007d0:	e8 27 0c 00 00       	call   8013fc <_panic>

		//[2] test memory access
		byteArr[0] = 10;
  8007d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007d8:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("successful access to re-allocated space with size 0!! it should not be succeeded");
  8007db:	e8 65 21 00 00       	call   802945 <sys_rcr2>
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 17                	je     800800 <_main+0x7c8>
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 dc 2f 80 00       	push   $0x802fdc
  8007f1:	68 9b 00 00 00       	push   $0x9b
  8007f6:	68 b4 2d 80 00       	push   $0x802db4
  8007fb:	e8 fc 0b 00 00       	call   8013fc <_panic>
		byteArr[(1*Mega-kilo)/sizeof(char) - 1] = 10;
  800800:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800803:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800806:	8d 50 ff             	lea    -0x1(%eax),%edx
  800809:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80080c:	01 d0                	add    %edx,%eax
  80080e:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[(1*Mega-kilo)/sizeof(char) - 1])) panic("successful access to reallocated space of size 0!! it should not be succeeded");
  800811:	e8 2f 21 00 00       	call   802945 <sys_rcr2>
  800816:	89 c2                	mov    %eax,%edx
  800818:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80081e:	8d 48 ff             	lea    -0x1(%eax),%ecx
  800821:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800824:	01 c8                	add    %ecx,%eax
  800826:	39 c2                	cmp    %eax,%edx
  800828:	74 17                	je     800841 <_main+0x809>
  80082a:	83 ec 04             	sub    $0x4,%esp
  80082d:	68 30 30 80 00       	push   $0x803030
  800832:	68 9d 00 00 00       	push   $0x9d
  800837:	68 b4 2d 80 00       	push   $0x802db4
  80083c:	e8 bb 0b 00 00       	call   8013fc <_panic>

		//set it to 0 again to cancel the bypassing option
		sys_bypassPageFault(0);
  800841:	83 ec 0c             	sub    $0xc,%esp
  800844:	6a 00                	push   $0x0
  800846:	e8 13 21 00 00       	call   80295e <sys_bypassPageFault>
  80084b:	83 c4 10             	add    $0x10,%esp

		vcprintf("\b\b\b20%", NULL);
  80084e:	83 ec 08             	sub    $0x8,%esp
  800851:	6a 00                	push   $0x0
  800853:	68 7e 30 80 00       	push   $0x80307e
  800858:	e8 e8 0d 00 00       	call   801645 <vcprintf>
  80085d:	83 c4 10             	add    $0x10,%esp

		/*CASE2: Re-allocate with address = NULL*/

		//new allocation with size = 2.5 MB, should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800860:	e8 e3 1d 00 00       	call   802648 <sys_calculate_free_frames>
  800865:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800868:	e8 5e 1e 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80086d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = realloc(NULL, 2*Mega + 510*kilo);
  800870:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800873:	89 d0                	mov    %edx,%eax
  800875:	c1 e0 08             	shl    $0x8,%eax
  800878:	29 d0                	sub    %edx,%eax
  80087a:	89 c2                	mov    %eax,%edx
  80087c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80087f:	01 d0                	add    %edx,%eax
  800881:	01 c0                	add    %eax,%eax
  800883:	83 ec 08             	sub    $0x8,%esp
  800886:	50                   	push   %eax
  800887:	6a 00                	push   $0x0
  800889:	e8 34 1c 00 00       	call   8024c2 <realloc>
  80088e:	83 c4 10             	add    $0x10,%esp
  800891:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800894:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800897:	89 c2                	mov    %eax,%edx
  800899:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80089c:	c1 e0 03             	shl    $0x3,%eax
  80089f:	05 00 00 00 80       	add    $0x80000000,%eax
  8008a4:	39 c2                	cmp    %eax,%edx
  8008a6:	74 17                	je     8008bf <_main+0x887>
  8008a8:	83 ec 04             	sub    $0x4,%esp
  8008ab:	68 84 2d 80 00       	push   $0x802d84
  8008b0:	68 aa 00 00 00       	push   $0xaa
  8008b5:	68 b4 2d 80 00       	push   $0x802db4
  8008ba:	e8 3d 0b 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 640) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  8008bf:	e8 84 1d 00 00       	call   802648 <sys_calculate_free_frames>
  8008c4:	89 c2                	mov    %eax,%edx
  8008c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c9:	39 c2                	cmp    %eax,%edx
  8008cb:	74 17                	je     8008e4 <_main+0x8ac>
  8008cd:	83 ec 04             	sub    $0x4,%esp
  8008d0:	68 38 2f 80 00       	push   $0x802f38
  8008d5:	68 ac 00 00 00       	push   $0xac
  8008da:	68 b4 2d 80 00       	push   $0x802db4
  8008df:	e8 18 0b 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 640) panic("Extra or less pages are re-allocated in PageFile");
  8008e4:	e8 e2 1d 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8008e9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008ec:	3d 80 02 00 00       	cmp    $0x280,%eax
  8008f1:	74 17                	je     80090a <_main+0x8d2>
  8008f3:	83 ec 04             	sub    $0x4,%esp
  8008f6:	68 a8 2f 80 00       	push   $0x802fa8
  8008fb:	68 ad 00 00 00       	push   $0xad
  800900:	68 b4 2d 80 00       	push   $0x802db4
  800905:	e8 f2 0a 00 00       	call   8013fc <_panic>

		//Fill it with data
		int *intArr = (int*) ptr_allocations[10];
  80090a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80090d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfInt1 = (2*Mega + 510*kilo)/sizeof(int) - 1;
  800910:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800913:	89 d0                	mov    %edx,%eax
  800915:	c1 e0 08             	shl    $0x8,%eax
  800918:	29 d0                	sub    %edx,%eax
  80091a:	89 c2                	mov    %eax,%edx
  80091c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80091f:	01 d0                	add    %edx,%eax
  800921:	01 c0                	add    %eax,%eax
  800923:	c1 e8 02             	shr    $0x2,%eax
  800926:	48                   	dec    %eax
  800927:	89 45 d0             	mov    %eax,-0x30(%ebp)

		int i = 0;
  80092a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
//		{
//			intArr[i] = i ;
//		}

		//fill the first 100 elements
		for(i = 0; i < 100; i++)
  800931:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800938:	eb 17                	jmp    800951 <_main+0x919>
		{
			intArr[i] = i;
  80093a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800944:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800947:	01 c2                	add    %eax,%edx
  800949:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094c:	89 02                	mov    %eax,(%edx)
//		{
//			intArr[i] = i ;
//		}

		//fill the first 100 elements
		for(i = 0; i < 100; i++)
  80094e:	ff 45 f0             	incl   -0x10(%ebp)
  800951:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800955:	7e e3                	jle    80093a <_main+0x902>
			intArr[i] = i;
		}


		//fill the last 100 element
		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  800957:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80095a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095d:	eb 17                	jmp    800976 <_main+0x93e>
		{
			intArr[i] = i;
  80095f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800962:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800969:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80096c:	01 c2                	add    %eax,%edx
  80096e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800971:	89 02                	mov    %eax,(%edx)
			intArr[i] = i;
		}


		//fill the last 100 element
		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  800973:	ff 4d f0             	decl   -0x10(%ebp)
  800976:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800979:	83 e8 63             	sub    $0x63,%eax
  80097c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80097f:	7e de                	jle    80095f <_main+0x927>
		{
			intArr[i] = i;
		}

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800981:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800988:	eb 33                	jmp    8009bd <_main+0x985>
		{
			cnt++;
  80098a:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80098d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800990:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800997:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80099a:	01 d0                	add    %edx,%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009a1:	74 17                	je     8009ba <_main+0x982>
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	68 88 30 80 00       	push   $0x803088
  8009ab:	68 ca 00 00 00       	push   $0xca
  8009b0:	68 b4 2d 80 00       	push   $0x802db4
  8009b5:	e8 42 0a 00 00       	call   8013fc <_panic>
		{
			intArr[i] = i;
		}

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  8009ba:	ff 45 f0             	incl   -0x10(%ebp)
  8009bd:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  8009c1:	7e c7                	jle    80098a <_main+0x952>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  8009c3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c9:	eb 33                	jmp    8009fe <_main+0x9c6>
		{
			cnt++;
  8009cb:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8009db:	01 d0                	add    %edx,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009e2:	74 17                	je     8009fb <_main+0x9c3>
  8009e4:	83 ec 04             	sub    $0x4,%esp
  8009e7:	68 88 30 80 00       	push   $0x803088
  8009ec:	68 d0 00 00 00       	push   $0xd0
  8009f1:	68 b4 2d 80 00       	push   $0x802db4
  8009f6:	e8 01 0a 00 00       	call   8013fc <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  8009fb:	ff 4d f0             	decl   -0x10(%ebp)
  8009fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a01:	83 e8 63             	sub    $0x63,%eax
  800a04:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a07:	7e c2                	jle    8009cb <_main+0x993>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		vcprintf("\b\b\b40%", NULL);
  800a09:	83 ec 08             	sub    $0x8,%esp
  800a0c:	6a 00                	push   $0x0
  800a0e:	68 c0 30 80 00       	push   $0x8030c0
  800a13:	e8 2d 0c 00 00       	call   801645 <vcprintf>
  800a18:	83 c4 10             	add    $0x10,%esp

		/*CASE3: Re-allocate in the existing internal fragment (no additional pages are required)*/

		//Reallocate last allocation with 1 extra KB [should be placed in the existing 2 KB internal fragment]
		freeFrames = sys_calculate_free_frames() ;
  800a1b:	e8 28 1c 00 00       	call   802648 <sys_calculate_free_frames>
  800a20:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800a23:	e8 a3 1c 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800a28:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = realloc(ptr_allocations[10], 2*Mega + 510*kilo + kilo);
  800a2b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a2e:	89 d0                	mov    %edx,%eax
  800a30:	c1 e0 08             	shl    $0x8,%eax
  800a33:	29 d0                	sub    %edx,%eax
  800a35:	89 c2                	mov    %eax,%edx
  800a37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3a:	01 d0                	add    %edx,%eax
  800a3c:	01 c0                	add    %eax,%eax
  800a3e:	89 c2                	mov    %eax,%edx
  800a40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a43:	01 d0                	add    %edx,%eax
  800a45:	89 c2                	mov    %eax,%edx
  800a47:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	52                   	push   %edx
  800a4e:	50                   	push   %eax
  800a4f:	e8 6e 1a 00 00       	call   8024c2 <realloc>
  800a54:	83 c4 10             	add    $0x10,%esp
  800a57:	89 45 a0             	mov    %eax,-0x60(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the re-allocated space... ");
  800a5a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800a5d:	89 c2                	mov    %eax,%edx
  800a5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a62:	c1 e0 03             	shl    $0x3,%eax
  800a65:	05 00 00 00 80       	add    $0x80000000,%eax
  800a6a:	39 c2                	cmp    %eax,%edx
  800a6c:	74 17                	je     800a85 <_main+0xa4d>
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	68 c8 30 80 00       	push   $0x8030c8
  800a76:	68 dc 00 00 00       	push   $0xdc
  800a7b:	68 b4 2d 80 00       	push   $0x802db4
  800a80:	e8 77 09 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");

		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800a85:	e8 be 1b 00 00       	call   802648 <sys_calculate_free_frames>
  800a8a:	89 c2                	mov    %eax,%edx
  800a8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8f:	39 c2                	cmp    %eax,%edx
  800a91:	74 17                	je     800aaa <_main+0xa72>
  800a93:	83 ec 04             	sub    $0x4,%esp
  800a96:	68 38 2f 80 00       	push   $0x802f38
  800a9b:	68 df 00 00 00       	push   $0xdf
  800aa0:	68 b4 2d 80 00       	push   $0x802db4
  800aa5:	e8 52 09 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");
  800aaa:	e8 1c 1c 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800aaf:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800ab2:	74 17                	je     800acb <_main+0xa93>
  800ab4:	83 ec 04             	sub    $0x4,%esp
  800ab7:	68 a8 2f 80 00       	push   $0x802fa8
  800abc:	68 e0 00 00 00       	push   $0xe0
  800ac1:	68 b4 2d 80 00       	push   $0x802db4
  800ac6:	e8 31 09 00 00       	call   8013fc <_panic>

		//[2] test memory access
		int lastIndexOfInt2 = (2*Mega + 510*kilo + kilo)/sizeof(int) - 1;
  800acb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ace:	89 d0                	mov    %edx,%eax
  800ad0:	c1 e0 08             	shl    $0x8,%eax
  800ad3:	29 d0                	sub    %edx,%eax
  800ad5:	89 c2                	mov    %eax,%edx
  800ad7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ada:	01 d0                	add    %edx,%eax
  800adc:	01 c0                	add    %eax,%eax
  800ade:	89 c2                	mov    %eax,%edx
  800ae0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ae3:	01 d0                	add    %edx,%eax
  800ae5:	c1 e8 02             	shr    $0x2,%eax
  800ae8:	48                   	dec    %eax
  800ae9:	89 45 cc             	mov    %eax,-0x34(%ebp)

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800aec:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800aef:	40                   	inc    %eax
  800af0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af3:	eb 17                	jmp    800b0c <_main+0xad4>
		{
			intArr[i] = i ;
  800af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800aff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b02:	01 c2                	add    %eax,%edx
  800b04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b07:	89 02                	mov    %eax,(%edx)
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");

		//[2] test memory access
		int lastIndexOfInt2 = (2*Mega + 510*kilo + kilo)/sizeof(int) - 1;

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800b09:	ff 45 f0             	incl   -0x10(%ebp)
  800b0c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b0f:	83 c0 65             	add    $0x65,%eax
  800b12:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b15:	7f de                	jg     800af5 <_main+0xabd>
		{
			intArr[i] = i ;
		}


		for (i=lastIndexOfInt2 ; i >= lastIndexOfInt2 - 99 ; i--)
  800b17:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1d:	eb 17                	jmp    800b36 <_main+0xafe>
		{
			intArr[i] = i ;
  800b1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b29:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b2c:	01 c2                	add    %eax,%edx
  800b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b31:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}


		for (i=lastIndexOfInt2 ; i >= lastIndexOfInt2 - 99 ; i--)
  800b33:	ff 4d f0             	decl   -0x10(%ebp)
  800b36:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800b39:	83 e8 63             	sub    $0x63,%eax
  800b3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b3f:	7e de                	jle    800b1f <_main+0xae7>
		{
			intArr[i] = i ;
		}


		for (i=0; i < 100 ; i++)
  800b41:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800b48:	eb 33                	jmp    800b7d <_main+0xb45>
		{
			cnt++;
  800b4a:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b57:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b5a:	01 d0                	add    %edx,%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b61:	74 17                	je     800b7a <_main+0xb42>
  800b63:	83 ec 04             	sub    $0x4,%esp
  800b66:	68 88 30 80 00       	push   $0x803088
  800b6b:	68 f4 00 00 00       	push   $0xf4
  800b70:	68 b4 2d 80 00       	push   $0x802db4
  800b75:	e8 82 08 00 00       	call   8013fc <_panic>
		{
			intArr[i] = i ;
		}


		for (i=0; i < 100 ; i++)
  800b7a:	ff 45 f0             	incl   -0x10(%ebp)
  800b7d:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800b81:	7e c7                	jle    800b4a <_main+0xb12>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
  800b83:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b86:	48                   	dec    %eax
  800b87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8a:	eb 33                	jmp    800bbf <_main+0xb87>
		{
			cnt++;
  800b8c:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b99:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b9c:	01 d0                	add    %edx,%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ba3:	74 17                	je     800bbc <_main+0xb84>
  800ba5:	83 ec 04             	sub    $0x4,%esp
  800ba8:	68 88 30 80 00       	push   $0x803088
  800bad:	68 f9 00 00 00       	push   $0xf9
  800bb2:	68 b4 2d 80 00       	push   $0x802db4
  800bb7:	e8 40 08 00 00       	call   8013fc <_panic>
		for (i=0; i < 100 ; i++)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
  800bbc:	ff 4d f0             	decl   -0x10(%ebp)
  800bbf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800bc2:	83 e8 63             	sub    $0x63,%eax
  800bc5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bc8:	7e c2                	jle    800b8c <_main+0xb54>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800bca:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800bcd:	40                   	inc    %eax
  800bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd1:	eb 33                	jmp    800c06 <_main+0xbce>
		{
			cnt++;
  800bd3:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bd9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800be0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	8b 00                	mov    (%eax),%eax
  800be7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bea:	74 17                	je     800c03 <_main+0xbcb>
  800bec:	83 ec 04             	sub    $0x4,%esp
  800bef:	68 88 30 80 00       	push   $0x803088
  800bf4:	68 fe 00 00 00       	push   $0xfe
  800bf9:	68 b4 2d 80 00       	push   $0x802db4
  800bfe:	e8 f9 07 00 00       	call   8013fc <_panic>
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800c03:	ff 45 f0             	incl   -0x10(%ebp)
  800c06:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c09:	83 c0 65             	add    $0x65,%eax
  800c0c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0f:	7f c2                	jg     800bd3 <_main+0xb9b>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt2; i >= lastIndexOfInt2 - 99 ; i--)
  800c11:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800c14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c17:	eb 33                	jmp    800c4c <_main+0xc14>
		{
			cnt++;
  800c19:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800c1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c1f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c26:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c29:	01 d0                	add    %edx,%eax
  800c2b:	8b 00                	mov    (%eax),%eax
  800c2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c30:	74 17                	je     800c49 <_main+0xc11>
  800c32:	83 ec 04             	sub    $0x4,%esp
  800c35:	68 88 30 80 00       	push   $0x803088
  800c3a:	68 03 01 00 00       	push   $0x103
  800c3f:	68 b4 2d 80 00       	push   $0x802db4
  800c44:	e8 b3 07 00 00       	call   8013fc <_panic>
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt2; i >= lastIndexOfInt2 - 99 ; i--)
  800c49:	ff 4d f0             	decl   -0x10(%ebp)
  800c4c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800c4f:	83 e8 63             	sub    $0x63,%eax
  800c52:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c55:	7e c2                	jle    800c19 <_main+0xbe1>
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}


		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800c57:	e8 ec 19 00 00       	call   802648 <sys_calculate_free_frames>
  800c5c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c5f:	e8 67 1a 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800c64:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[10]);
  800c67:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800c6a:	83 ec 0c             	sub    $0xc,%esp
  800c6d:	50                   	push   %eax
  800c6e:	e8 1b 18 00 00       	call   80248e <free>
  800c73:	83 c4 10             	add    $0x10,%esp

		//if ((sys_calculate_free_frames() - freeFrames) != 640) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 640) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800c76:	e8 50 1a 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800c7b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c7e:	29 c2                	sub    %eax,%edx
  800c80:	89 d0                	mov    %edx,%eax
  800c82:	3d 80 02 00 00       	cmp    $0x280,%eax
  800c87:	74 17                	je     800ca0 <_main+0xc68>
  800c89:	83 ec 04             	sub    $0x4,%esp
  800c8c:	68 fc 30 80 00       	push   $0x8030fc
  800c91:	68 0d 01 00 00       	push   $0x10d
  800c96:	68 b4 2d 80 00       	push   $0x802db4
  800c9b:	e8 5c 07 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");
  800ca0:	e8 a3 19 00 00       	call   802648 <sys_calculate_free_frames>
  800ca5:	89 c2                	mov    %eax,%edx
  800ca7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800caa:	29 c2                	sub    %eax,%edx
  800cac:	89 d0                	mov    %edx,%eax
  800cae:	83 f8 03             	cmp    $0x3,%eax
  800cb1:	74 17                	je     800cca <_main+0xc92>
  800cb3:	83 ec 04             	sub    $0x4,%esp
  800cb6:	68 50 31 80 00       	push   $0x803150
  800cbb:	68 0e 01 00 00       	push   $0x10e
  800cc0:	68 b4 2d 80 00       	push   $0x802db4
  800cc5:	e8 32 07 00 00       	call   8013fc <_panic>

		vcprintf("\b\b\b60%", NULL);
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	6a 00                	push   $0x0
  800ccf:	68 b4 31 80 00       	push   $0x8031b4
  800cd4:	e8 6c 09 00 00       	call   801645 <vcprintf>
  800cd9:	83 c4 10             	add    $0x10,%esp

		/*CASE4: Re-allocate that can NOT fit in any free fragment*/

		//Fill 3rd allocation with data
		intArr = (int*) ptr_allocations[2];
  800cdc:	8b 45 80             	mov    -0x80(%ebp),%eax
  800cdf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;
  800ce2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ce5:	c1 e8 02             	shr    $0x2,%eax
  800ce8:	48                   	dec    %eax
  800ce9:	89 45 d0             	mov    %eax,-0x30(%ebp)

		i = 0;
  800cec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		//filling the first 100 element
		for (i=0; i < 100 ; i++)
  800cf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800cfa:	eb 17                	jmp    800d13 <_main+0xcdb>
		{
			intArr[i] = i ;
  800cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d06:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d09:	01 c2                	add    %eax,%edx
  800d0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d0e:	89 02                	mov    %eax,(%edx)
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;

		i = 0;
		//filling the first 100 element
		for (i=0; i < 100 ; i++)
  800d10:	ff 45 f0             	incl   -0x10(%ebp)
  800d13:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800d17:	7e e3                	jle    800cfc <_main+0xcc4>
		{
			intArr[i] = i ;
		}

		//filling the last 100 element
		for(int i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d19:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d1f:	eb 17                	jmp    800d38 <_main+0xd00>
		{
			intArr[i] = i;
  800d21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d24:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d2b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d2e:	01 c2                	add    %eax,%edx
  800d30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d33:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 element
		for(int i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d35:	ff 4d ec             	decl   -0x14(%ebp)
  800d38:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d3b:	83 e8 64             	sub    $0x64,%eax
  800d3e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800d41:	7c de                	jl     800d21 <_main+0xce9>
		{
			intArr[i] = i;
		}

		//Reallocate it to large size that can't be fit in any free segment
		freeFrames = sys_calculate_free_frames() ;
  800d43:	e8 00 19 00 00       	call   802648 <sys_calculate_free_frames>
  800d48:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d4b:	e8 7b 19 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800d50:	89 45 dc             	mov    %eax,-0x24(%ebp)
		void* origAddress = ptr_allocations[2];
  800d53:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d56:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = realloc(ptr_allocations[2], (USER_HEAP_MAX - USER_HEAP_START - 13*Mega));
  800d59:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d5c:	89 d0                	mov    %edx,%eax
  800d5e:	01 c0                	add    %eax,%eax
  800d60:	01 d0                	add    %edx,%eax
  800d62:	c1 e0 02             	shl    $0x2,%eax
  800d65:	01 d0                	add    %edx,%eax
  800d67:	f7 d8                	neg    %eax
  800d69:	8d 90 00 00 00 20    	lea    0x20000000(%eax),%edx
  800d6f:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d72:	83 ec 08             	sub    $0x8,%esp
  800d75:	52                   	push   %edx
  800d76:	50                   	push   %eax
  800d77:	e8 46 17 00 00       	call   8024c2 <realloc>
  800d7c:	83 c4 10             	add    $0x10,%esp
  800d7f:	89 45 80             	mov    %eax,-0x80(%ebp)

		//cprintf("%x\n", ptr_allocations[2]);
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[2] != 0) panic("Wrong start address for the re-allocated space... ");
  800d82:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d85:	85 c0                	test   %eax,%eax
  800d87:	74 17                	je     800da0 <_main+0xd68>
  800d89:	83 ec 04             	sub    $0x4,%esp
  800d8c:	68 c8 30 80 00       	push   $0x8030c8
  800d91:	68 2d 01 00 00       	push   $0x12d
  800d96:	68 b4 2d 80 00       	push   $0x802db4
  800d9b:	e8 5c 06 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800da0:	e8 a3 18 00 00       	call   802648 <sys_calculate_free_frames>
  800da5:	89 c2                	mov    %eax,%edx
  800da7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800daa:	39 c2                	cmp    %eax,%edx
  800dac:	74 17                	je     800dc5 <_main+0xd8d>
  800dae:	83 ec 04             	sub    $0x4,%esp
  800db1:	68 38 2f 80 00       	push   $0x802f38
  800db6:	68 2f 01 00 00       	push   $0x12f
  800dbb:	68 b4 2d 80 00       	push   $0x802db4
  800dc0:	e8 37 06 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");
  800dc5:	e8 01 19 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800dca:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800dcd:	74 17                	je     800de6 <_main+0xdae>
  800dcf:	83 ec 04             	sub    $0x4,%esp
  800dd2:	68 a8 2f 80 00       	push   $0x802fa8
  800dd7:	68 30 01 00 00       	push   $0x130
  800ddc:	68 b4 2d 80 00       	push   $0x802db4
  800de1:	e8 16 06 00 00       	call   8013fc <_panic>

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800de6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ded:	eb 33                	jmp    800e22 <_main+0xdea>
		{
			cnt++;
  800def:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dfc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dff:	01 d0                	add    %edx,%eax
  800e01:	8b 00                	mov    (%eax),%eax
  800e03:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e06:	74 17                	je     800e1f <_main+0xde7>
  800e08:	83 ec 04             	sub    $0x4,%esp
  800e0b:	68 88 30 80 00       	push   $0x803088
  800e10:	68 36 01 00 00       	push   $0x136
  800e15:	68 b4 2d 80 00       	push   $0x802db4
  800e1a:	e8 dd 05 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800e1f:	ff 45 f0             	incl   -0x10(%ebp)
  800e22:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800e26:	7e c7                	jle    800def <_main+0xdb7>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800e28:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2e:	eb 33                	jmp    800e63 <_main+0xe2b>
		{
			cnt++;
  800e30:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800e3d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e40:	01 d0                	add    %edx,%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e47:	74 17                	je     800e60 <_main+0xe28>
  800e49:	83 ec 04             	sub    $0x4,%esp
  800e4c:	68 88 30 80 00       	push   $0x803088
  800e51:	68 3c 01 00 00       	push   $0x13c
  800e56:	68 b4 2d 80 00       	push   $0x802db4
  800e5b:	e8 9c 05 00 00       	call   8013fc <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800e60:	ff 4d f0             	decl   -0x10(%ebp)
  800e63:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e66:	83 e8 64             	sub    $0x64,%eax
  800e69:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e6c:	7c c2                	jl     800e30 <_main+0xdf8>
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after FAILURE expansion
		freeFrames = sys_calculate_free_frames() ;
  800e6e:	e8 d5 17 00 00       	call   802648 <sys_calculate_free_frames>
  800e73:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e76:	e8 50 18 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800e7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(origAddress);
  800e7e:	83 ec 0c             	sub    $0xc,%esp
  800e81:	ff 75 c8             	pushl  -0x38(%ebp)
  800e84:	e8 05 16 00 00       	call   80248e <free>
  800e89:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800e8c:	e8 3a 18 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800e91:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800e94:	29 c2                	sub    %eax,%edx
  800e96:	89 d0                	mov    %edx,%eax
  800e98:	3d 00 01 00 00       	cmp    $0x100,%eax
  800e9d:	74 17                	je     800eb6 <_main+0xe7e>
  800e9f:	83 ec 04             	sub    $0x4,%esp
  800ea2:	68 fc 30 80 00       	push   $0x8030fc
  800ea7:	68 44 01 00 00       	push   $0x144
  800eac:	68 b4 2d 80 00       	push   $0x802db4
  800eb1:	e8 46 05 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");
  800eb6:	e8 8d 17 00 00       	call   802648 <sys_calculate_free_frames>
  800ebb:	89 c2                	mov    %eax,%edx
  800ebd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ec0:	29 c2                	sub    %eax,%edx
  800ec2:	89 d0                	mov    %edx,%eax
  800ec4:	83 f8 03             	cmp    $0x3,%eax
  800ec7:	74 17                	je     800ee0 <_main+0xea8>
  800ec9:	83 ec 04             	sub    $0x4,%esp
  800ecc:	68 50 31 80 00       	push   $0x803150
  800ed1:	68 45 01 00 00       	push   $0x145
  800ed6:	68 b4 2d 80 00       	push   $0x802db4
  800edb:	e8 1c 05 00 00       	call   8013fc <_panic>

		vcprintf("\b\b\b80%", NULL);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	6a 00                	push   $0x0
  800ee5:	68 bb 31 80 00       	push   $0x8031bb
  800eea:	e8 56 07 00 00       	call   801645 <vcprintf>
  800eef:	83 c4 10             	add    $0x10,%esp
		/*CASE5: Re-allocate that test NEXT FIT strategy*/

		//[1] create 4 MB hole at beginning of the heap

		//Take 2 MB from currently 3 MB hole at beginning of the heap
		freeFrames = sys_calculate_free_frames() ;
  800ef2:	e8 51 17 00 00       	call   802648 <sys_calculate_free_frames>
  800ef7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800efa:	e8 cc 17 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800eff:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = malloc(2*Mega-kilo);
  800f02:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800f05:	01 c0                	add    %eax,%eax
  800f07:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800f0a:	83 ec 0c             	sub    $0xc,%esp
  800f0d:	50                   	push   %eax
  800f0e:	e8 27 15 00 00       	call   80243a <malloc>
  800f13:	83 c4 10             	add    $0x10,%esp
  800f16:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800f19:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800f1c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800f21:	74 17                	je     800f3a <_main+0xf02>
  800f23:	83 ec 04             	sub    $0x4,%esp
  800f26:	68 84 2d 80 00       	push   $0x802d84
  800f2b:	68 51 01 00 00       	push   $0x151
  800f30:	68 b4 2d 80 00       	push   $0x802db4
  800f35:	e8 c2 04 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800f3a:	e8 09 17 00 00       	call   802648 <sys_calculate_free_frames>
  800f3f:	89 c2                	mov    %eax,%edx
  800f41:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f44:	39 c2                	cmp    %eax,%edx
  800f46:	74 17                	je     800f5f <_main+0xf27>
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	68 cc 2d 80 00       	push   $0x802dcc
  800f50:	68 53 01 00 00       	push   $0x153
  800f55:	68 b4 2d 80 00       	push   $0x802db4
  800f5a:	e8 9d 04 00 00       	call   8013fc <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800f5f:	e8 67 17 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800f64:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800f67:	3d 00 02 00 00       	cmp    $0x200,%eax
  800f6c:	74 17                	je     800f85 <_main+0xf4d>
  800f6e:	83 ec 04             	sub    $0x4,%esp
  800f71:	68 38 2e 80 00       	push   $0x802e38
  800f76:	68 54 01 00 00       	push   $0x154
  800f7b:	68 b4 2d 80 00       	push   $0x802db4
  800f80:	e8 77 04 00 00       	call   8013fc <_panic>

		//remove 1 MB allocation between 1 MB hole and 2 MB hole to create 4 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800f85:	e8 be 16 00 00       	call   802648 <sys_calculate_free_frames>
  800f8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f8d:	e8 39 17 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800f92:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[3]);
  800f95:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800f98:	83 ec 0c             	sub    $0xc,%esp
  800f9b:	50                   	push   %eax
  800f9c:	e8 ed 14 00 00       	call   80248e <free>
  800fa1:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fa4:	e8 22 17 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  800fa9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800fac:	29 c2                	sub    %eax,%edx
  800fae:	89 d0                	mov    %edx,%eax
  800fb0:	3d 00 01 00 00       	cmp    $0x100,%eax
  800fb5:	74 17                	je     800fce <_main+0xf96>
  800fb7:	83 ec 04             	sub    $0x4,%esp
  800fba:	68 68 2e 80 00       	push   $0x802e68
  800fbf:	68 5b 01 00 00       	push   $0x15b
  800fc4:	68 b4 2d 80 00       	push   $0x802db4
  800fc9:	e8 2e 04 00 00       	call   8013fc <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800fce:	e8 75 16 00 00       	call   802648 <sys_calculate_free_frames>
  800fd3:	89 c2                	mov    %eax,%edx
  800fd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fd8:	39 c2                	cmp    %eax,%edx
  800fda:	74 17                	je     800ff3 <_main+0xfbb>
  800fdc:	83 ec 04             	sub    $0x4,%esp
  800fdf:	68 a4 2e 80 00       	push   $0x802ea4
  800fe4:	68 5c 01 00 00       	push   $0x15c
  800fe9:	68 b4 2d 80 00       	push   $0x802db4
  800fee:	e8 09 04 00 00       	call   8013fc <_panic>
		{
			//allocate 1 page after each 3 MB
			sys_allocateMem(i, PAGE_SIZE) ;
		}*/

		malloc(5*Mega-kilo);
  800ff3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ff6:	89 d0                	mov    %edx,%eax
  800ff8:	c1 e0 02             	shl    $0x2,%eax
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801000:	83 ec 0c             	sub    $0xc,%esp
  801003:	50                   	push   %eax
  801004:	e8 31 14 00 00       	call   80243a <malloc>
  801009:	83 c4 10             	add    $0x10,%esp

		//Fill last 3MB allocation with data
		intArr = (int*) ptr_allocations[7];
  80100c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80100f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		lastIndexOfInt1 = (3*Mega-kilo)/sizeof(int) - 1;
  801012:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801015:	89 c2                	mov    %eax,%edx
  801017:	01 d2                	add    %edx,%edx
  801019:	01 d0                	add    %edx,%eax
  80101b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80101e:	c1 e8 02             	shr    $0x2,%eax
  801021:	48                   	dec    %eax
  801022:	89 45 d0             	mov    %eax,-0x30(%ebp)

		i = 0;
  801025:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		//filling the first 100 elements of the last 3 mega
		for (i=0; i < 100 ; i++)
  80102c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801033:	eb 17                	jmp    80104c <_main+0x1014>
		{
			intArr[i] = i ;
  801035:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801038:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80103f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801042:	01 c2                	add    %eax,%edx
  801044:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801047:	89 02                	mov    %eax,(%edx)
		intArr = (int*) ptr_allocations[7];
		lastIndexOfInt1 = (3*Mega-kilo)/sizeof(int) - 1;

		i = 0;
		//filling the first 100 elements of the last 3 mega
		for (i=0; i < 100 ; i++)
  801049:	ff 45 f0             	incl   -0x10(%ebp)
  80104c:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  801050:	7e e3                	jle    801035 <_main+0xffd>
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801052:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801055:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801058:	eb 17                	jmp    801071 <_main+0x1039>
		{
			intArr[i] = i;
  80105a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80105d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801064:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801067:	01 c2                	add    %eax,%edx
  801069:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80106c:	89 02                	mov    %eax,(%edx)
		for (i=0; i < 100 ; i++)
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  80106e:	ff 4d f0             	decl   -0x10(%ebp)
  801071:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801074:	83 e8 64             	sub    $0x64,%eax
  801077:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80107a:	7c de                	jl     80105a <_main+0x1022>
		{
			intArr[i] = i;
		}

		//Reallocate it to 4 MB, so that it can only fit at the 1st fragment
		freeFrames = sys_calculate_free_frames() ;
  80107c:	e8 c7 15 00 00       	call   802648 <sys_calculate_free_frames>
  801081:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801084:	e8 42 16 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  801089:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = realloc(ptr_allocations[7], 4*Mega-kilo);
  80108c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80108f:	c1 e0 02             	shl    $0x2,%eax
  801092:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801095:	89 c2                	mov    %eax,%edx
  801097:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80109a:	83 ec 08             	sub    $0x8,%esp
  80109d:	52                   	push   %edx
  80109e:	50                   	push   %eax
  80109f:	e8 1e 14 00 00       	call   8024c2 <realloc>
  8010a4:	83 c4 10             	add    $0x10,%esp
  8010a7:	89 45 94             	mov    %eax,-0x6c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the re-allocated space... ");
  8010aa:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8010ad:	89 c2                	mov    %eax,%edx
  8010af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010b2:	01 c0                	add    %eax,%eax
  8010b4:	05 00 00 00 80       	add    $0x80000000,%eax
  8010b9:	39 c2                	cmp    %eax,%edx
  8010bb:	74 17                	je     8010d4 <_main+0x109c>
  8010bd:	83 ec 04             	sub    $0x4,%esp
  8010c0:	68 c8 30 80 00       	push   $0x8030c8
  8010c5:	68 7d 01 00 00       	push   $0x17d
  8010ca:	68 b4 2d 80 00       	push   $0x802db4
  8010cf:	e8 28 03 00 00       	call   8013fc <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 - 1) panic("Wrong re-allocation");
		//if((sys_calculate_free_frames() - freeFrames) != 2 + 2) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are re-allocated in PageFile");
  8010d4:	e8 f2 15 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  8010d9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8010dc:	3d 00 01 00 00       	cmp    $0x100,%eax
  8010e1:	74 17                	je     8010fa <_main+0x10c2>
  8010e3:	83 ec 04             	sub    $0x4,%esp
  8010e6:	68 a8 2f 80 00       	push   $0x802fa8
  8010eb:	68 80 01 00 00       	push   $0x180
  8010f0:	68 b4 2d 80 00       	push   $0x802db4
  8010f5:	e8 02 03 00 00       	call   8013fc <_panic>


		//[2] test memory access
		lastIndexOfInt2 = (4*Mega-kilo)/sizeof(int) - 1;
  8010fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010fd:	c1 e0 02             	shl    $0x2,%eax
  801100:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801103:	c1 e8 02             	shr    $0x2,%eax
  801106:	48                   	dec    %eax
  801107:	89 45 cc             	mov    %eax,-0x34(%ebp)
		intArr = (int*) ptr_allocations[7];
  80110a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80110d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  801110:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801113:	40                   	inc    %eax
  801114:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801117:	eb 17                	jmp    801130 <_main+0x10f8>
		{
			intArr[i] = i ;
  801119:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80111c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801123:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801126:	01 c2                	add    %eax,%edx
  801128:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80112b:	89 02                	mov    %eax,(%edx)


		//[2] test memory access
		lastIndexOfInt2 = (4*Mega-kilo)/sizeof(int) - 1;
		intArr = (int*) ptr_allocations[7];
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  80112d:	ff 45 f0             	incl   -0x10(%ebp)
  801130:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801133:	83 c0 65             	add    $0x65,%eax
  801136:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801139:	7f de                	jg     801119 <_main+0x10e1>
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80113b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80113e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801141:	eb 17                	jmp    80115a <_main+0x1122>
		{
			intArr[i] = i;
  801143:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80114d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801150:	01 c2                	add    %eax,%edx
  801152:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801155:	89 02                	mov    %eax,(%edx)
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  801157:	ff 4d f0             	decl   -0x10(%ebp)
  80115a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80115d:	83 e8 64             	sub    $0x64,%eax
  801160:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801163:	7c de                	jl     801143 <_main+0x110b>
		{
			intArr[i] = i;
		}

		for (i=0; i < 100 ; i++)
  801165:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80116c:	eb 33                	jmp    8011a1 <_main+0x1169>
		{
			cnt++;
  80116e:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  801171:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801174:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80117b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80117e:	01 d0                	add    %edx,%eax
  801180:	8b 00                	mov    (%eax),%eax
  801182:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801185:	74 17                	je     80119e <_main+0x1166>
  801187:	83 ec 04             	sub    $0x4,%esp
  80118a:	68 88 30 80 00       	push   $0x803088
  80118f:	68 93 01 00 00       	push   $0x193
  801194:	68 b4 2d 80 00       	push   $0x802db4
  801199:	e8 5e 02 00 00       	call   8013fc <_panic>
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
		{
			intArr[i] = i;
		}

		for (i=0; i < 100 ; i++)
  80119e:	ff 45 f0             	incl   -0x10(%ebp)
  8011a1:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  8011a5:	7e c7                	jle    80116e <_main+0x1136>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  8011a7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ad:	eb 33                	jmp    8011e2 <_main+0x11aa>
		{
			cnt++;
  8011af:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8011b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011bc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	8b 00                	mov    (%eax),%eax
  8011c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011c6:	74 17                	je     8011df <_main+0x11a7>
  8011c8:	83 ec 04             	sub    $0x4,%esp
  8011cb:	68 88 30 80 00       	push   $0x803088
  8011d0:	68 99 01 00 00       	push   $0x199
  8011d5:	68 b4 2d 80 00       	push   $0x802db4
  8011da:	e8 1d 02 00 00       	call   8013fc <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  8011df:	ff 4d f0             	decl   -0x10(%ebp)
  8011e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011e5:	83 e8 64             	sub    $0x64,%eax
  8011e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011eb:	7c c2                	jl     8011af <_main+0x1177>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  8011ed:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011f0:	40                   	inc    %eax
  8011f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011f4:	eb 33                	jmp    801229 <_main+0x11f1>
		{
			cnt++;
  8011f6:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8011f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801203:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801206:	01 d0                	add    %edx,%eax
  801208:	8b 00                	mov    (%eax),%eax
  80120a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80120d:	74 17                	je     801226 <_main+0x11ee>
  80120f:	83 ec 04             	sub    $0x4,%esp
  801212:	68 88 30 80 00       	push   $0x803088
  801217:	68 9f 01 00 00       	push   $0x19f
  80121c:	68 b4 2d 80 00       	push   $0x802db4
  801221:	e8 d6 01 00 00       	call   8013fc <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  801226:	ff 45 f0             	incl   -0x10(%ebp)
  801229:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80122c:	83 c0 65             	add    $0x65,%eax
  80122f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801232:	7f c2                	jg     8011f6 <_main+0x11be>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  801234:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80123a:	eb 33                	jmp    80126f <_main+0x1237>
		{
			cnt++;
  80123c:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80123f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801249:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	8b 00                	mov    (%eax),%eax
  801250:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801253:	74 17                	je     80126c <_main+0x1234>
  801255:	83 ec 04             	sub    $0x4,%esp
  801258:	68 88 30 80 00       	push   $0x803088
  80125d:	68 a5 01 00 00       	push   $0x1a5
  801262:	68 b4 2d 80 00       	push   $0x802db4
  801267:	e8 90 01 00 00       	call   8013fc <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80126c:	ff 4d f0             	decl   -0x10(%ebp)
  80126f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801272:	83 e8 64             	sub    $0x64,%eax
  801275:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801278:	7c c2                	jl     80123c <_main+0x1204>
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  80127a:	e8 c9 13 00 00       	call   802648 <sys_calculate_free_frames>
  80127f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801282:	e8 44 14 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  801287:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[7]);
  80128a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80128d:	83 ec 0c             	sub    $0xc,%esp
  801290:	50                   	push   %eax
  801291:	e8 f8 11 00 00       	call   80248e <free>
  801296:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1024) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1024) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  801299:	e8 2d 14 00 00       	call   8026cb <sys_pf_calculate_allocated_pages>
  80129e:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8012a1:	29 c2                	sub    %eax,%edx
  8012a3:	89 d0                	mov    %edx,%eax
  8012a5:	3d 00 04 00 00       	cmp    $0x400,%eax
  8012aa:	74 17                	je     8012c3 <_main+0x128b>
  8012ac:	83 ec 04             	sub    $0x4,%esp
  8012af:	68 fc 30 80 00       	push   $0x8030fc
  8012b4:	68 ad 01 00 00       	push   $0x1ad
  8012b9:	68 b4 2d 80 00       	push   $0x802db4
  8012be:	e8 39 01 00 00       	call   8013fc <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b100%\n", NULL);
  8012c3:	83 ec 08             	sub    $0x8,%esp
  8012c6:	6a 00                	push   $0x0
  8012c8:	68 c2 31 80 00       	push   $0x8031c2
  8012cd:	e8 73 03 00 00       	call   801645 <vcprintf>
  8012d2:	83 c4 10             	add    $0x10,%esp
	}



	cprintf("Congratulations!! test realloc [2] completed successfully.\n");
  8012d5:	83 ec 0c             	sub    $0xc,%esp
  8012d8:	68 cc 31 80 00       	push   $0x8031cc
  8012dd:	e8 ce 03 00 00       	call   8016b0 <cprintf>
  8012e2:	83 c4 10             	add    $0x10,%esp

	return;
  8012e5:	90                   	nop
}
  8012e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012e9:	5b                   	pop    %ebx
  8012ea:	5f                   	pop    %edi
  8012eb:	5d                   	pop    %ebp
  8012ec:	c3                   	ret    

008012ed <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
  8012f0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8012f3:	e8 85 12 00 00       	call   80257d <sys_getenvindex>
  8012f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8012fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012fe:	89 d0                	mov    %edx,%eax
  801300:	c1 e0 02             	shl    $0x2,%eax
  801303:	01 d0                	add    %edx,%eax
  801305:	01 c0                	add    %eax,%eax
  801307:	01 d0                	add    %edx,%eax
  801309:	01 c0                	add    %eax,%eax
  80130b:	01 d0                	add    %edx,%eax
  80130d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801314:	01 d0                	add    %edx,%eax
  801316:	c1 e0 02             	shl    $0x2,%eax
  801319:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80131e:	a3 04 40 80 00       	mov    %eax,0x804004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801323:	a1 04 40 80 00       	mov    0x804004,%eax
  801328:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80132e:	84 c0                	test   %al,%al
  801330:	74 0f                	je     801341 <libmain+0x54>
		binaryname = myEnv->prog_name;
  801332:	a1 04 40 80 00       	mov    0x804004,%eax
  801337:	05 f4 02 00 00       	add    $0x2f4,%eax
  80133c:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801341:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801345:	7e 0a                	jle    801351 <libmain+0x64>
		binaryname = argv[0];
  801347:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134a:	8b 00                	mov    (%eax),%eax
  80134c:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801351:	83 ec 08             	sub    $0x8,%esp
  801354:	ff 75 0c             	pushl  0xc(%ebp)
  801357:	ff 75 08             	pushl  0x8(%ebp)
  80135a:	e8 d9 ec ff ff       	call   800038 <_main>
  80135f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801362:	e8 b1 13 00 00       	call   802718 <sys_disable_interrupt>
	cprintf("**************************************\n");
  801367:	83 ec 0c             	sub    $0xc,%esp
  80136a:	68 20 32 80 00       	push   $0x803220
  80136f:	e8 3c 03 00 00       	call   8016b0 <cprintf>
  801374:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801377:	a1 04 40 80 00       	mov    0x804004,%eax
  80137c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801382:	a1 04 40 80 00       	mov    0x804004,%eax
  801387:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80138d:	83 ec 04             	sub    $0x4,%esp
  801390:	52                   	push   %edx
  801391:	50                   	push   %eax
  801392:	68 48 32 80 00       	push   $0x803248
  801397:	e8 14 03 00 00       	call   8016b0 <cprintf>
  80139c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80139f:	a1 04 40 80 00       	mov    0x804004,%eax
  8013a4:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8013aa:	83 ec 08             	sub    $0x8,%esp
  8013ad:	50                   	push   %eax
  8013ae:	68 6d 32 80 00       	push   $0x80326d
  8013b3:	e8 f8 02 00 00       	call   8016b0 <cprintf>
  8013b8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8013bb:	83 ec 0c             	sub    $0xc,%esp
  8013be:	68 20 32 80 00       	push   $0x803220
  8013c3:	e8 e8 02 00 00       	call   8016b0 <cprintf>
  8013c8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8013cb:	e8 62 13 00 00       	call   802732 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8013d0:	e8 19 00 00 00       	call   8013ee <exit>
}
  8013d5:	90                   	nop
  8013d6:	c9                   	leave  
  8013d7:	c3                   	ret    

008013d8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8013d8:	55                   	push   %ebp
  8013d9:	89 e5                	mov    %esp,%ebp
  8013db:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8013de:	83 ec 0c             	sub    $0xc,%esp
  8013e1:	6a 00                	push   $0x0
  8013e3:	e8 61 11 00 00       	call   802549 <sys_env_destroy>
  8013e8:	83 c4 10             	add    $0x10,%esp
}
  8013eb:	90                   	nop
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <exit>:

void
exit(void)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8013f4:	e8 b6 11 00 00       	call   8025af <sys_env_exit>
}
  8013f9:	90                   	nop
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
  8013ff:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801402:	8d 45 10             	lea    0x10(%ebp),%eax
  801405:	83 c0 04             	add    $0x4,%eax
  801408:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80140b:	a1 14 40 80 00       	mov    0x804014,%eax
  801410:	85 c0                	test   %eax,%eax
  801412:	74 16                	je     80142a <_panic+0x2e>
		cprintf("%s: ", argv0);
  801414:	a1 14 40 80 00       	mov    0x804014,%eax
  801419:	83 ec 08             	sub    $0x8,%esp
  80141c:	50                   	push   %eax
  80141d:	68 84 32 80 00       	push   $0x803284
  801422:	e8 89 02 00 00       	call   8016b0 <cprintf>
  801427:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80142a:	a1 00 40 80 00       	mov    0x804000,%eax
  80142f:	ff 75 0c             	pushl  0xc(%ebp)
  801432:	ff 75 08             	pushl  0x8(%ebp)
  801435:	50                   	push   %eax
  801436:	68 89 32 80 00       	push   $0x803289
  80143b:	e8 70 02 00 00       	call   8016b0 <cprintf>
  801440:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801443:	8b 45 10             	mov    0x10(%ebp),%eax
  801446:	83 ec 08             	sub    $0x8,%esp
  801449:	ff 75 f4             	pushl  -0xc(%ebp)
  80144c:	50                   	push   %eax
  80144d:	e8 f3 01 00 00       	call   801645 <vcprintf>
  801452:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801455:	83 ec 08             	sub    $0x8,%esp
  801458:	6a 00                	push   $0x0
  80145a:	68 a5 32 80 00       	push   $0x8032a5
  80145f:	e8 e1 01 00 00       	call   801645 <vcprintf>
  801464:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801467:	e8 82 ff ff ff       	call   8013ee <exit>

	// should not return here
	while (1) ;
  80146c:	eb fe                	jmp    80146c <_panic+0x70>

0080146e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
  801471:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801474:	a1 04 40 80 00       	mov    0x804004,%eax
  801479:	8b 50 74             	mov    0x74(%eax),%edx
  80147c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147f:	39 c2                	cmp    %eax,%edx
  801481:	74 14                	je     801497 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801483:	83 ec 04             	sub    $0x4,%esp
  801486:	68 a8 32 80 00       	push   $0x8032a8
  80148b:	6a 26                	push   $0x26
  80148d:	68 f4 32 80 00       	push   $0x8032f4
  801492:	e8 65 ff ff ff       	call   8013fc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801497:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80149e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8014a5:	e9 c2 00 00 00       	jmp    80156c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8014aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	01 d0                	add    %edx,%eax
  8014b9:	8b 00                	mov    (%eax),%eax
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	75 08                	jne    8014c7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8014bf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8014c2:	e9 a2 00 00 00       	jmp    801569 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8014c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8014ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8014d5:	eb 69                	jmp    801540 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8014d7:	a1 04 40 80 00       	mov    0x804004,%eax
  8014dc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8014e2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8014e5:	89 d0                	mov    %edx,%eax
  8014e7:	01 c0                	add    %eax,%eax
  8014e9:	01 d0                	add    %edx,%eax
  8014eb:	c1 e0 02             	shl    $0x2,%eax
  8014ee:	01 c8                	add    %ecx,%eax
  8014f0:	8a 40 04             	mov    0x4(%eax),%al
  8014f3:	84 c0                	test   %al,%al
  8014f5:	75 46                	jne    80153d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8014f7:	a1 04 40 80 00       	mov    0x804004,%eax
  8014fc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801502:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801505:	89 d0                	mov    %edx,%eax
  801507:	01 c0                	add    %eax,%eax
  801509:	01 d0                	add    %edx,%eax
  80150b:	c1 e0 02             	shl    $0x2,%eax
  80150e:	01 c8                	add    %ecx,%eax
  801510:	8b 00                	mov    (%eax),%eax
  801512:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801515:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801518:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80151d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80151f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801522:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	01 c8                	add    %ecx,%eax
  80152e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801530:	39 c2                	cmp    %eax,%edx
  801532:	75 09                	jne    80153d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801534:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80153b:	eb 12                	jmp    80154f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80153d:	ff 45 e8             	incl   -0x18(%ebp)
  801540:	a1 04 40 80 00       	mov    0x804004,%eax
  801545:	8b 50 74             	mov    0x74(%eax),%edx
  801548:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80154b:	39 c2                	cmp    %eax,%edx
  80154d:	77 88                	ja     8014d7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80154f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801553:	75 14                	jne    801569 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801555:	83 ec 04             	sub    $0x4,%esp
  801558:	68 00 33 80 00       	push   $0x803300
  80155d:	6a 3a                	push   $0x3a
  80155f:	68 f4 32 80 00       	push   $0x8032f4
  801564:	e8 93 fe ff ff       	call   8013fc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801569:	ff 45 f0             	incl   -0x10(%ebp)
  80156c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80156f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801572:	0f 8c 32 ff ff ff    	jl     8014aa <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801578:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80157f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801586:	eb 26                	jmp    8015ae <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801588:	a1 04 40 80 00       	mov    0x804004,%eax
  80158d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801593:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801596:	89 d0                	mov    %edx,%eax
  801598:	01 c0                	add    %eax,%eax
  80159a:	01 d0                	add    %edx,%eax
  80159c:	c1 e0 02             	shl    $0x2,%eax
  80159f:	01 c8                	add    %ecx,%eax
  8015a1:	8a 40 04             	mov    0x4(%eax),%al
  8015a4:	3c 01                	cmp    $0x1,%al
  8015a6:	75 03                	jne    8015ab <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8015a8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8015ab:	ff 45 e0             	incl   -0x20(%ebp)
  8015ae:	a1 04 40 80 00       	mov    0x804004,%eax
  8015b3:	8b 50 74             	mov    0x74(%eax),%edx
  8015b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015b9:	39 c2                	cmp    %eax,%edx
  8015bb:	77 cb                	ja     801588 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8015bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015c3:	74 14                	je     8015d9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8015c5:	83 ec 04             	sub    $0x4,%esp
  8015c8:	68 54 33 80 00       	push   $0x803354
  8015cd:	6a 44                	push   $0x44
  8015cf:	68 f4 32 80 00       	push   $0x8032f4
  8015d4:	e8 23 fe ff ff       	call   8013fc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8015d9:	90                   	nop
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
  8015df:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8015e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e5:	8b 00                	mov    (%eax),%eax
  8015e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8015ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ed:	89 0a                	mov    %ecx,(%edx)
  8015ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8015f2:	88 d1                	mov    %dl,%cl
  8015f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8015fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fe:	8b 00                	mov    (%eax),%eax
  801600:	3d ff 00 00 00       	cmp    $0xff,%eax
  801605:	75 2c                	jne    801633 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801607:	a0 08 40 80 00       	mov    0x804008,%al
  80160c:	0f b6 c0             	movzbl %al,%eax
  80160f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801612:	8b 12                	mov    (%edx),%edx
  801614:	89 d1                	mov    %edx,%ecx
  801616:	8b 55 0c             	mov    0xc(%ebp),%edx
  801619:	83 c2 08             	add    $0x8,%edx
  80161c:	83 ec 04             	sub    $0x4,%esp
  80161f:	50                   	push   %eax
  801620:	51                   	push   %ecx
  801621:	52                   	push   %edx
  801622:	e8 e0 0e 00 00       	call   802507 <sys_cputs>
  801627:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80162a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801633:	8b 45 0c             	mov    0xc(%ebp),%eax
  801636:	8b 40 04             	mov    0x4(%eax),%eax
  801639:	8d 50 01             	lea    0x1(%eax),%edx
  80163c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163f:	89 50 04             	mov    %edx,0x4(%eax)
}
  801642:	90                   	nop
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
  801648:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80164e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801655:	00 00 00 
	b.cnt = 0;
  801658:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80165f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801662:	ff 75 0c             	pushl  0xc(%ebp)
  801665:	ff 75 08             	pushl  0x8(%ebp)
  801668:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80166e:	50                   	push   %eax
  80166f:	68 dc 15 80 00       	push   $0x8015dc
  801674:	e8 11 02 00 00       	call   80188a <vprintfmt>
  801679:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80167c:	a0 08 40 80 00       	mov    0x804008,%al
  801681:	0f b6 c0             	movzbl %al,%eax
  801684:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80168a:	83 ec 04             	sub    $0x4,%esp
  80168d:	50                   	push   %eax
  80168e:	52                   	push   %edx
  80168f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801695:	83 c0 08             	add    $0x8,%eax
  801698:	50                   	push   %eax
  801699:	e8 69 0e 00 00       	call   802507 <sys_cputs>
  80169e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8016a1:	c6 05 08 40 80 00 00 	movb   $0x0,0x804008
	return b.cnt;
  8016a8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
  8016b3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8016b6:	c6 05 08 40 80 00 01 	movb   $0x1,0x804008
	va_start(ap, fmt);
  8016bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8016c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	83 ec 08             	sub    $0x8,%esp
  8016c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8016cc:	50                   	push   %eax
  8016cd:	e8 73 ff ff ff       	call   801645 <vcprintf>
  8016d2:	83 c4 10             	add    $0x10,%esp
  8016d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8016d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
  8016e0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8016e3:	e8 30 10 00 00       	call   802718 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8016e8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8016eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	83 ec 08             	sub    $0x8,%esp
  8016f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8016f7:	50                   	push   %eax
  8016f8:	e8 48 ff ff ff       	call   801645 <vcprintf>
  8016fd:	83 c4 10             	add    $0x10,%esp
  801700:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801703:	e8 2a 10 00 00       	call   802732 <sys_enable_interrupt>
	return cnt;
  801708:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	53                   	push   %ebx
  801711:	83 ec 14             	sub    $0x14,%esp
  801714:	8b 45 10             	mov    0x10(%ebp),%eax
  801717:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80171a:	8b 45 14             	mov    0x14(%ebp),%eax
  80171d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801720:	8b 45 18             	mov    0x18(%ebp),%eax
  801723:	ba 00 00 00 00       	mov    $0x0,%edx
  801728:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80172b:	77 55                	ja     801782 <printnum+0x75>
  80172d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801730:	72 05                	jb     801737 <printnum+0x2a>
  801732:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801735:	77 4b                	ja     801782 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801737:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80173a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80173d:	8b 45 18             	mov    0x18(%ebp),%eax
  801740:	ba 00 00 00 00       	mov    $0x0,%edx
  801745:	52                   	push   %edx
  801746:	50                   	push   %eax
  801747:	ff 75 f4             	pushl  -0xc(%ebp)
  80174a:	ff 75 f0             	pushl  -0x10(%ebp)
  80174d:	e8 a6 13 00 00       	call   802af8 <__udivdi3>
  801752:	83 c4 10             	add    $0x10,%esp
  801755:	83 ec 04             	sub    $0x4,%esp
  801758:	ff 75 20             	pushl  0x20(%ebp)
  80175b:	53                   	push   %ebx
  80175c:	ff 75 18             	pushl  0x18(%ebp)
  80175f:	52                   	push   %edx
  801760:	50                   	push   %eax
  801761:	ff 75 0c             	pushl  0xc(%ebp)
  801764:	ff 75 08             	pushl  0x8(%ebp)
  801767:	e8 a1 ff ff ff       	call   80170d <printnum>
  80176c:	83 c4 20             	add    $0x20,%esp
  80176f:	eb 1a                	jmp    80178b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801771:	83 ec 08             	sub    $0x8,%esp
  801774:	ff 75 0c             	pushl  0xc(%ebp)
  801777:	ff 75 20             	pushl  0x20(%ebp)
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	ff d0                	call   *%eax
  80177f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801782:	ff 4d 1c             	decl   0x1c(%ebp)
  801785:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801789:	7f e6                	jg     801771 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80178b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80178e:	bb 00 00 00 00       	mov    $0x0,%ebx
  801793:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801796:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801799:	53                   	push   %ebx
  80179a:	51                   	push   %ecx
  80179b:	52                   	push   %edx
  80179c:	50                   	push   %eax
  80179d:	e8 66 14 00 00       	call   802c08 <__umoddi3>
  8017a2:	83 c4 10             	add    $0x10,%esp
  8017a5:	05 b4 35 80 00       	add    $0x8035b4,%eax
  8017aa:	8a 00                	mov    (%eax),%al
  8017ac:	0f be c0             	movsbl %al,%eax
  8017af:	83 ec 08             	sub    $0x8,%esp
  8017b2:	ff 75 0c             	pushl  0xc(%ebp)
  8017b5:	50                   	push   %eax
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	ff d0                	call   *%eax
  8017bb:	83 c4 10             	add    $0x10,%esp
}
  8017be:	90                   	nop
  8017bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8017c7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8017cb:	7e 1c                	jle    8017e9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8017cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d0:	8b 00                	mov    (%eax),%eax
  8017d2:	8d 50 08             	lea    0x8(%eax),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	89 10                	mov    %edx,(%eax)
  8017da:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dd:	8b 00                	mov    (%eax),%eax
  8017df:	83 e8 08             	sub    $0x8,%eax
  8017e2:	8b 50 04             	mov    0x4(%eax),%edx
  8017e5:	8b 00                	mov    (%eax),%eax
  8017e7:	eb 40                	jmp    801829 <getuint+0x65>
	else if (lflag)
  8017e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017ed:	74 1e                	je     80180d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f2:	8b 00                	mov    (%eax),%eax
  8017f4:	8d 50 04             	lea    0x4(%eax),%edx
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	89 10                	mov    %edx,(%eax)
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	8b 00                	mov    (%eax),%eax
  801801:	83 e8 04             	sub    $0x4,%eax
  801804:	8b 00                	mov    (%eax),%eax
  801806:	ba 00 00 00 00       	mov    $0x0,%edx
  80180b:	eb 1c                	jmp    801829 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	8b 00                	mov    (%eax),%eax
  801812:	8d 50 04             	lea    0x4(%eax),%edx
  801815:	8b 45 08             	mov    0x8(%ebp),%eax
  801818:	89 10                	mov    %edx,(%eax)
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	8b 00                	mov    (%eax),%eax
  80181f:	83 e8 04             	sub    $0x4,%eax
  801822:	8b 00                	mov    (%eax),%eax
  801824:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801829:	5d                   	pop    %ebp
  80182a:	c3                   	ret    

0080182b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80182e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801832:	7e 1c                	jle    801850 <getint+0x25>
		return va_arg(*ap, long long);
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8b 00                	mov    (%eax),%eax
  801839:	8d 50 08             	lea    0x8(%eax),%edx
  80183c:	8b 45 08             	mov    0x8(%ebp),%eax
  80183f:	89 10                	mov    %edx,(%eax)
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	8b 00                	mov    (%eax),%eax
  801846:	83 e8 08             	sub    $0x8,%eax
  801849:	8b 50 04             	mov    0x4(%eax),%edx
  80184c:	8b 00                	mov    (%eax),%eax
  80184e:	eb 38                	jmp    801888 <getint+0x5d>
	else if (lflag)
  801850:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801854:	74 1a                	je     801870 <getint+0x45>
		return va_arg(*ap, long);
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	8b 00                	mov    (%eax),%eax
  80185b:	8d 50 04             	lea    0x4(%eax),%edx
  80185e:	8b 45 08             	mov    0x8(%ebp),%eax
  801861:	89 10                	mov    %edx,(%eax)
  801863:	8b 45 08             	mov    0x8(%ebp),%eax
  801866:	8b 00                	mov    (%eax),%eax
  801868:	83 e8 04             	sub    $0x4,%eax
  80186b:	8b 00                	mov    (%eax),%eax
  80186d:	99                   	cltd   
  80186e:	eb 18                	jmp    801888 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	8b 00                	mov    (%eax),%eax
  801875:	8d 50 04             	lea    0x4(%eax),%edx
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	89 10                	mov    %edx,(%eax)
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	8b 00                	mov    (%eax),%eax
  801882:	83 e8 04             	sub    $0x4,%eax
  801885:	8b 00                	mov    (%eax),%eax
  801887:	99                   	cltd   
}
  801888:	5d                   	pop    %ebp
  801889:	c3                   	ret    

0080188a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
  80188d:	56                   	push   %esi
  80188e:	53                   	push   %ebx
  80188f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801892:	eb 17                	jmp    8018ab <vprintfmt+0x21>
			if (ch == '\0')
  801894:	85 db                	test   %ebx,%ebx
  801896:	0f 84 af 03 00 00    	je     801c4b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80189c:	83 ec 08             	sub    $0x8,%esp
  80189f:	ff 75 0c             	pushl  0xc(%ebp)
  8018a2:	53                   	push   %ebx
  8018a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a6:	ff d0                	call   *%eax
  8018a8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8018ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ae:	8d 50 01             	lea    0x1(%eax),%edx
  8018b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8018b4:	8a 00                	mov    (%eax),%al
  8018b6:	0f b6 d8             	movzbl %al,%ebx
  8018b9:	83 fb 25             	cmp    $0x25,%ebx
  8018bc:	75 d6                	jne    801894 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8018be:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8018c2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8018c9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8018d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8018d7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8018de:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e1:	8d 50 01             	lea    0x1(%eax),%edx
  8018e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8018e7:	8a 00                	mov    (%eax),%al
  8018e9:	0f b6 d8             	movzbl %al,%ebx
  8018ec:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8018ef:	83 f8 55             	cmp    $0x55,%eax
  8018f2:	0f 87 2b 03 00 00    	ja     801c23 <vprintfmt+0x399>
  8018f8:	8b 04 85 d8 35 80 00 	mov    0x8035d8(,%eax,4),%eax
  8018ff:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801901:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801905:	eb d7                	jmp    8018de <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801907:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80190b:	eb d1                	jmp    8018de <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80190d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801914:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801917:	89 d0                	mov    %edx,%eax
  801919:	c1 e0 02             	shl    $0x2,%eax
  80191c:	01 d0                	add    %edx,%eax
  80191e:	01 c0                	add    %eax,%eax
  801920:	01 d8                	add    %ebx,%eax
  801922:	83 e8 30             	sub    $0x30,%eax
  801925:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801928:	8b 45 10             	mov    0x10(%ebp),%eax
  80192b:	8a 00                	mov    (%eax),%al
  80192d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801930:	83 fb 2f             	cmp    $0x2f,%ebx
  801933:	7e 3e                	jle    801973 <vprintfmt+0xe9>
  801935:	83 fb 39             	cmp    $0x39,%ebx
  801938:	7f 39                	jg     801973 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80193a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80193d:	eb d5                	jmp    801914 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80193f:	8b 45 14             	mov    0x14(%ebp),%eax
  801942:	83 c0 04             	add    $0x4,%eax
  801945:	89 45 14             	mov    %eax,0x14(%ebp)
  801948:	8b 45 14             	mov    0x14(%ebp),%eax
  80194b:	83 e8 04             	sub    $0x4,%eax
  80194e:	8b 00                	mov    (%eax),%eax
  801950:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801953:	eb 1f                	jmp    801974 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801955:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801959:	79 83                	jns    8018de <vprintfmt+0x54>
				width = 0;
  80195b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801962:	e9 77 ff ff ff       	jmp    8018de <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801967:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80196e:	e9 6b ff ff ff       	jmp    8018de <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801973:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801974:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801978:	0f 89 60 ff ff ff    	jns    8018de <vprintfmt+0x54>
				width = precision, precision = -1;
  80197e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801981:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801984:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80198b:	e9 4e ff ff ff       	jmp    8018de <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801990:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801993:	e9 46 ff ff ff       	jmp    8018de <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801998:	8b 45 14             	mov    0x14(%ebp),%eax
  80199b:	83 c0 04             	add    $0x4,%eax
  80199e:	89 45 14             	mov    %eax,0x14(%ebp)
  8019a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a4:	83 e8 04             	sub    $0x4,%eax
  8019a7:	8b 00                	mov    (%eax),%eax
  8019a9:	83 ec 08             	sub    $0x8,%esp
  8019ac:	ff 75 0c             	pushl  0xc(%ebp)
  8019af:	50                   	push   %eax
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	ff d0                	call   *%eax
  8019b5:	83 c4 10             	add    $0x10,%esp
			break;
  8019b8:	e9 89 02 00 00       	jmp    801c46 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8019bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c0:	83 c0 04             	add    $0x4,%eax
  8019c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8019c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c9:	83 e8 04             	sub    $0x4,%eax
  8019cc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8019ce:	85 db                	test   %ebx,%ebx
  8019d0:	79 02                	jns    8019d4 <vprintfmt+0x14a>
				err = -err;
  8019d2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8019d4:	83 fb 64             	cmp    $0x64,%ebx
  8019d7:	7f 0b                	jg     8019e4 <vprintfmt+0x15a>
  8019d9:	8b 34 9d 20 34 80 00 	mov    0x803420(,%ebx,4),%esi
  8019e0:	85 f6                	test   %esi,%esi
  8019e2:	75 19                	jne    8019fd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8019e4:	53                   	push   %ebx
  8019e5:	68 c5 35 80 00       	push   $0x8035c5
  8019ea:	ff 75 0c             	pushl  0xc(%ebp)
  8019ed:	ff 75 08             	pushl  0x8(%ebp)
  8019f0:	e8 5e 02 00 00       	call   801c53 <printfmt>
  8019f5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8019f8:	e9 49 02 00 00       	jmp    801c46 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8019fd:	56                   	push   %esi
  8019fe:	68 ce 35 80 00       	push   $0x8035ce
  801a03:	ff 75 0c             	pushl  0xc(%ebp)
  801a06:	ff 75 08             	pushl  0x8(%ebp)
  801a09:	e8 45 02 00 00       	call   801c53 <printfmt>
  801a0e:	83 c4 10             	add    $0x10,%esp
			break;
  801a11:	e9 30 02 00 00       	jmp    801c46 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801a16:	8b 45 14             	mov    0x14(%ebp),%eax
  801a19:	83 c0 04             	add    $0x4,%eax
  801a1c:	89 45 14             	mov    %eax,0x14(%ebp)
  801a1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a22:	83 e8 04             	sub    $0x4,%eax
  801a25:	8b 30                	mov    (%eax),%esi
  801a27:	85 f6                	test   %esi,%esi
  801a29:	75 05                	jne    801a30 <vprintfmt+0x1a6>
				p = "(null)";
  801a2b:	be d1 35 80 00       	mov    $0x8035d1,%esi
			if (width > 0 && padc != '-')
  801a30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a34:	7e 6d                	jle    801aa3 <vprintfmt+0x219>
  801a36:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801a3a:	74 67                	je     801aa3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801a3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a3f:	83 ec 08             	sub    $0x8,%esp
  801a42:	50                   	push   %eax
  801a43:	56                   	push   %esi
  801a44:	e8 0c 03 00 00       	call   801d55 <strnlen>
  801a49:	83 c4 10             	add    $0x10,%esp
  801a4c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801a4f:	eb 16                	jmp    801a67 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801a51:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801a55:	83 ec 08             	sub    $0x8,%esp
  801a58:	ff 75 0c             	pushl  0xc(%ebp)
  801a5b:	50                   	push   %eax
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	ff d0                	call   *%eax
  801a61:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801a64:	ff 4d e4             	decl   -0x1c(%ebp)
  801a67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a6b:	7f e4                	jg     801a51 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801a6d:	eb 34                	jmp    801aa3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801a6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801a73:	74 1c                	je     801a91 <vprintfmt+0x207>
  801a75:	83 fb 1f             	cmp    $0x1f,%ebx
  801a78:	7e 05                	jle    801a7f <vprintfmt+0x1f5>
  801a7a:	83 fb 7e             	cmp    $0x7e,%ebx
  801a7d:	7e 12                	jle    801a91 <vprintfmt+0x207>
					putch('?', putdat);
  801a7f:	83 ec 08             	sub    $0x8,%esp
  801a82:	ff 75 0c             	pushl  0xc(%ebp)
  801a85:	6a 3f                	push   $0x3f
  801a87:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8a:	ff d0                	call   *%eax
  801a8c:	83 c4 10             	add    $0x10,%esp
  801a8f:	eb 0f                	jmp    801aa0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801a91:	83 ec 08             	sub    $0x8,%esp
  801a94:	ff 75 0c             	pushl  0xc(%ebp)
  801a97:	53                   	push   %ebx
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	ff d0                	call   *%eax
  801a9d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801aa0:	ff 4d e4             	decl   -0x1c(%ebp)
  801aa3:	89 f0                	mov    %esi,%eax
  801aa5:	8d 70 01             	lea    0x1(%eax),%esi
  801aa8:	8a 00                	mov    (%eax),%al
  801aaa:	0f be d8             	movsbl %al,%ebx
  801aad:	85 db                	test   %ebx,%ebx
  801aaf:	74 24                	je     801ad5 <vprintfmt+0x24b>
  801ab1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801ab5:	78 b8                	js     801a6f <vprintfmt+0x1e5>
  801ab7:	ff 4d e0             	decl   -0x20(%ebp)
  801aba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801abe:	79 af                	jns    801a6f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ac0:	eb 13                	jmp    801ad5 <vprintfmt+0x24b>
				putch(' ', putdat);
  801ac2:	83 ec 08             	sub    $0x8,%esp
  801ac5:	ff 75 0c             	pushl  0xc(%ebp)
  801ac8:	6a 20                	push   $0x20
  801aca:	8b 45 08             	mov    0x8(%ebp),%eax
  801acd:	ff d0                	call   *%eax
  801acf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ad2:	ff 4d e4             	decl   -0x1c(%ebp)
  801ad5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ad9:	7f e7                	jg     801ac2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801adb:	e9 66 01 00 00       	jmp    801c46 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801ae0:	83 ec 08             	sub    $0x8,%esp
  801ae3:	ff 75 e8             	pushl  -0x18(%ebp)
  801ae6:	8d 45 14             	lea    0x14(%ebp),%eax
  801ae9:	50                   	push   %eax
  801aea:	e8 3c fd ff ff       	call   80182b <getint>
  801aef:	83 c4 10             	add    $0x10,%esp
  801af2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801af5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801afb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801afe:	85 d2                	test   %edx,%edx
  801b00:	79 23                	jns    801b25 <vprintfmt+0x29b>
				putch('-', putdat);
  801b02:	83 ec 08             	sub    $0x8,%esp
  801b05:	ff 75 0c             	pushl  0xc(%ebp)
  801b08:	6a 2d                	push   $0x2d
  801b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0d:	ff d0                	call   *%eax
  801b0f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801b12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b18:	f7 d8                	neg    %eax
  801b1a:	83 d2 00             	adc    $0x0,%edx
  801b1d:	f7 da                	neg    %edx
  801b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801b25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801b2c:	e9 bc 00 00 00       	jmp    801bed <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801b31:	83 ec 08             	sub    $0x8,%esp
  801b34:	ff 75 e8             	pushl  -0x18(%ebp)
  801b37:	8d 45 14             	lea    0x14(%ebp),%eax
  801b3a:	50                   	push   %eax
  801b3b:	e8 84 fc ff ff       	call   8017c4 <getuint>
  801b40:	83 c4 10             	add    $0x10,%esp
  801b43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801b49:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801b50:	e9 98 00 00 00       	jmp    801bed <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801b55:	83 ec 08             	sub    $0x8,%esp
  801b58:	ff 75 0c             	pushl  0xc(%ebp)
  801b5b:	6a 58                	push   $0x58
  801b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b60:	ff d0                	call   *%eax
  801b62:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801b65:	83 ec 08             	sub    $0x8,%esp
  801b68:	ff 75 0c             	pushl  0xc(%ebp)
  801b6b:	6a 58                	push   $0x58
  801b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b70:	ff d0                	call   *%eax
  801b72:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801b75:	83 ec 08             	sub    $0x8,%esp
  801b78:	ff 75 0c             	pushl  0xc(%ebp)
  801b7b:	6a 58                	push   $0x58
  801b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b80:	ff d0                	call   *%eax
  801b82:	83 c4 10             	add    $0x10,%esp
			break;
  801b85:	e9 bc 00 00 00       	jmp    801c46 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801b8a:	83 ec 08             	sub    $0x8,%esp
  801b8d:	ff 75 0c             	pushl  0xc(%ebp)
  801b90:	6a 30                	push   $0x30
  801b92:	8b 45 08             	mov    0x8(%ebp),%eax
  801b95:	ff d0                	call   *%eax
  801b97:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801b9a:	83 ec 08             	sub    $0x8,%esp
  801b9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ba0:	6a 78                	push   $0x78
  801ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba5:	ff d0                	call   *%eax
  801ba7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801baa:	8b 45 14             	mov    0x14(%ebp),%eax
  801bad:	83 c0 04             	add    $0x4,%eax
  801bb0:	89 45 14             	mov    %eax,0x14(%ebp)
  801bb3:	8b 45 14             	mov    0x14(%ebp),%eax
  801bb6:	83 e8 04             	sub    $0x4,%eax
  801bb9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801bbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801bc5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801bcc:	eb 1f                	jmp    801bed <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801bce:	83 ec 08             	sub    $0x8,%esp
  801bd1:	ff 75 e8             	pushl  -0x18(%ebp)
  801bd4:	8d 45 14             	lea    0x14(%ebp),%eax
  801bd7:	50                   	push   %eax
  801bd8:	e8 e7 fb ff ff       	call   8017c4 <getuint>
  801bdd:	83 c4 10             	add    $0x10,%esp
  801be0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801be3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801be6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801bed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bf4:	83 ec 04             	sub    $0x4,%esp
  801bf7:	52                   	push   %edx
  801bf8:	ff 75 e4             	pushl  -0x1c(%ebp)
  801bfb:	50                   	push   %eax
  801bfc:	ff 75 f4             	pushl  -0xc(%ebp)
  801bff:	ff 75 f0             	pushl  -0x10(%ebp)
  801c02:	ff 75 0c             	pushl  0xc(%ebp)
  801c05:	ff 75 08             	pushl  0x8(%ebp)
  801c08:	e8 00 fb ff ff       	call   80170d <printnum>
  801c0d:	83 c4 20             	add    $0x20,%esp
			break;
  801c10:	eb 34                	jmp    801c46 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801c12:	83 ec 08             	sub    $0x8,%esp
  801c15:	ff 75 0c             	pushl  0xc(%ebp)
  801c18:	53                   	push   %ebx
  801c19:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1c:	ff d0                	call   *%eax
  801c1e:	83 c4 10             	add    $0x10,%esp
			break;
  801c21:	eb 23                	jmp    801c46 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801c23:	83 ec 08             	sub    $0x8,%esp
  801c26:	ff 75 0c             	pushl  0xc(%ebp)
  801c29:	6a 25                	push   $0x25
  801c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2e:	ff d0                	call   *%eax
  801c30:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801c33:	ff 4d 10             	decl   0x10(%ebp)
  801c36:	eb 03                	jmp    801c3b <vprintfmt+0x3b1>
  801c38:	ff 4d 10             	decl   0x10(%ebp)
  801c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c3e:	48                   	dec    %eax
  801c3f:	8a 00                	mov    (%eax),%al
  801c41:	3c 25                	cmp    $0x25,%al
  801c43:	75 f3                	jne    801c38 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801c45:	90                   	nop
		}
	}
  801c46:	e9 47 fc ff ff       	jmp    801892 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801c4b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801c4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c4f:	5b                   	pop    %ebx
  801c50:	5e                   	pop    %esi
  801c51:	5d                   	pop    %ebp
  801c52:	c3                   	ret    

00801c53 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
  801c56:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801c59:	8d 45 10             	lea    0x10(%ebp),%eax
  801c5c:	83 c0 04             	add    $0x4,%eax
  801c5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801c62:	8b 45 10             	mov    0x10(%ebp),%eax
  801c65:	ff 75 f4             	pushl  -0xc(%ebp)
  801c68:	50                   	push   %eax
  801c69:	ff 75 0c             	pushl  0xc(%ebp)
  801c6c:	ff 75 08             	pushl  0x8(%ebp)
  801c6f:	e8 16 fc ff ff       	call   80188a <vprintfmt>
  801c74:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801c77:	90                   	nop
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c80:	8b 40 08             	mov    0x8(%eax),%eax
  801c83:	8d 50 01             	lea    0x1(%eax),%edx
  801c86:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c89:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c8f:	8b 10                	mov    (%eax),%edx
  801c91:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c94:	8b 40 04             	mov    0x4(%eax),%eax
  801c97:	39 c2                	cmp    %eax,%edx
  801c99:	73 12                	jae    801cad <sprintputch+0x33>
		*b->buf++ = ch;
  801c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c9e:	8b 00                	mov    (%eax),%eax
  801ca0:	8d 48 01             	lea    0x1(%eax),%ecx
  801ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca6:	89 0a                	mov    %ecx,(%edx)
  801ca8:	8b 55 08             	mov    0x8(%ebp),%edx
  801cab:	88 10                	mov    %dl,(%eax)
}
  801cad:	90                   	nop
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    

00801cb0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801cb0:	55                   	push   %ebp
  801cb1:	89 e5                	mov    %esp,%ebp
  801cb3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  801cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc5:	01 d0                	add    %edx,%eax
  801cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801cd1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cd5:	74 06                	je     801cdd <vsnprintf+0x2d>
  801cd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cdb:	7f 07                	jg     801ce4 <vsnprintf+0x34>
		return -E_INVAL;
  801cdd:	b8 03 00 00 00       	mov    $0x3,%eax
  801ce2:	eb 20                	jmp    801d04 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801ce4:	ff 75 14             	pushl  0x14(%ebp)
  801ce7:	ff 75 10             	pushl  0x10(%ebp)
  801cea:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801ced:	50                   	push   %eax
  801cee:	68 7a 1c 80 00       	push   $0x801c7a
  801cf3:	e8 92 fb ff ff       	call   80188a <vprintfmt>
  801cf8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801cfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cfe:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
  801d09:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801d0c:	8d 45 10             	lea    0x10(%ebp),%eax
  801d0f:	83 c0 04             	add    $0x4,%eax
  801d12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801d15:	8b 45 10             	mov    0x10(%ebp),%eax
  801d18:	ff 75 f4             	pushl  -0xc(%ebp)
  801d1b:	50                   	push   %eax
  801d1c:	ff 75 0c             	pushl  0xc(%ebp)
  801d1f:	ff 75 08             	pushl  0x8(%ebp)
  801d22:	e8 89 ff ff ff       	call   801cb0 <vsnprintf>
  801d27:	83 c4 10             	add    $0x10,%esp
  801d2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    

00801d32 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
  801d35:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801d38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d3f:	eb 06                	jmp    801d47 <strlen+0x15>
		n++;
  801d41:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801d44:	ff 45 08             	incl   0x8(%ebp)
  801d47:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4a:	8a 00                	mov    (%eax),%al
  801d4c:	84 c0                	test   %al,%al
  801d4e:	75 f1                	jne    801d41 <strlen+0xf>
		n++;
	return n;
  801d50:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
  801d58:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801d5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d62:	eb 09                	jmp    801d6d <strnlen+0x18>
		n++;
  801d64:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801d67:	ff 45 08             	incl   0x8(%ebp)
  801d6a:	ff 4d 0c             	decl   0xc(%ebp)
  801d6d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d71:	74 09                	je     801d7c <strnlen+0x27>
  801d73:	8b 45 08             	mov    0x8(%ebp),%eax
  801d76:	8a 00                	mov    (%eax),%al
  801d78:	84 c0                	test   %al,%al
  801d7a:	75 e8                	jne    801d64 <strnlen+0xf>
		n++;
	return n;
  801d7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d7f:	c9                   	leave  
  801d80:	c3                   	ret    

00801d81 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801d81:	55                   	push   %ebp
  801d82:	89 e5                	mov    %esp,%ebp
  801d84:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801d87:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801d8d:	90                   	nop
  801d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d91:	8d 50 01             	lea    0x1(%eax),%edx
  801d94:	89 55 08             	mov    %edx,0x8(%ebp)
  801d97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9a:	8d 4a 01             	lea    0x1(%edx),%ecx
  801d9d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801da0:	8a 12                	mov    (%edx),%dl
  801da2:	88 10                	mov    %dl,(%eax)
  801da4:	8a 00                	mov    (%eax),%al
  801da6:	84 c0                	test   %al,%al
  801da8:	75 e4                	jne    801d8e <strcpy+0xd>
		/* do nothing */;
	return ret;
  801daa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801dad:	c9                   	leave  
  801dae:	c3                   	ret    

00801daf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801daf:	55                   	push   %ebp
  801db0:	89 e5                	mov    %esp,%ebp
  801db2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801db5:	8b 45 08             	mov    0x8(%ebp),%eax
  801db8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801dbb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801dc2:	eb 1f                	jmp    801de3 <strncpy+0x34>
		*dst++ = *src;
  801dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc7:	8d 50 01             	lea    0x1(%eax),%edx
  801dca:	89 55 08             	mov    %edx,0x8(%ebp)
  801dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd0:	8a 12                	mov    (%edx),%dl
  801dd2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dd7:	8a 00                	mov    (%eax),%al
  801dd9:	84 c0                	test   %al,%al
  801ddb:	74 03                	je     801de0 <strncpy+0x31>
			src++;
  801ddd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801de0:	ff 45 fc             	incl   -0x4(%ebp)
  801de3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801de6:	3b 45 10             	cmp    0x10(%ebp),%eax
  801de9:	72 d9                	jb     801dc4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801deb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
  801df3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801df6:	8b 45 08             	mov    0x8(%ebp),%eax
  801df9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801dfc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e00:	74 30                	je     801e32 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801e02:	eb 16                	jmp    801e1a <strlcpy+0x2a>
			*dst++ = *src++;
  801e04:	8b 45 08             	mov    0x8(%ebp),%eax
  801e07:	8d 50 01             	lea    0x1(%eax),%edx
  801e0a:	89 55 08             	mov    %edx,0x8(%ebp)
  801e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e10:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e13:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801e16:	8a 12                	mov    (%edx),%dl
  801e18:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801e1a:	ff 4d 10             	decl   0x10(%ebp)
  801e1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e21:	74 09                	je     801e2c <strlcpy+0x3c>
  801e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e26:	8a 00                	mov    (%eax),%al
  801e28:	84 c0                	test   %al,%al
  801e2a:	75 d8                	jne    801e04 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801e32:	8b 55 08             	mov    0x8(%ebp),%edx
  801e35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e38:	29 c2                	sub    %eax,%edx
  801e3a:	89 d0                	mov    %edx,%eax
}
  801e3c:	c9                   	leave  
  801e3d:	c3                   	ret    

00801e3e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801e3e:	55                   	push   %ebp
  801e3f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801e41:	eb 06                	jmp    801e49 <strcmp+0xb>
		p++, q++;
  801e43:	ff 45 08             	incl   0x8(%ebp)
  801e46:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801e49:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4c:	8a 00                	mov    (%eax),%al
  801e4e:	84 c0                	test   %al,%al
  801e50:	74 0e                	je     801e60 <strcmp+0x22>
  801e52:	8b 45 08             	mov    0x8(%ebp),%eax
  801e55:	8a 10                	mov    (%eax),%dl
  801e57:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e5a:	8a 00                	mov    (%eax),%al
  801e5c:	38 c2                	cmp    %al,%dl
  801e5e:	74 e3                	je     801e43 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801e60:	8b 45 08             	mov    0x8(%ebp),%eax
  801e63:	8a 00                	mov    (%eax),%al
  801e65:	0f b6 d0             	movzbl %al,%edx
  801e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e6b:	8a 00                	mov    (%eax),%al
  801e6d:	0f b6 c0             	movzbl %al,%eax
  801e70:	29 c2                	sub    %eax,%edx
  801e72:	89 d0                	mov    %edx,%eax
}
  801e74:	5d                   	pop    %ebp
  801e75:	c3                   	ret    

00801e76 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801e79:	eb 09                	jmp    801e84 <strncmp+0xe>
		n--, p++, q++;
  801e7b:	ff 4d 10             	decl   0x10(%ebp)
  801e7e:	ff 45 08             	incl   0x8(%ebp)
  801e81:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801e84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e88:	74 17                	je     801ea1 <strncmp+0x2b>
  801e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8d:	8a 00                	mov    (%eax),%al
  801e8f:	84 c0                	test   %al,%al
  801e91:	74 0e                	je     801ea1 <strncmp+0x2b>
  801e93:	8b 45 08             	mov    0x8(%ebp),%eax
  801e96:	8a 10                	mov    (%eax),%dl
  801e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e9b:	8a 00                	mov    (%eax),%al
  801e9d:	38 c2                	cmp    %al,%dl
  801e9f:	74 da                	je     801e7b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801ea1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ea5:	75 07                	jne    801eae <strncmp+0x38>
		return 0;
  801ea7:	b8 00 00 00 00       	mov    $0x0,%eax
  801eac:	eb 14                	jmp    801ec2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801eae:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb1:	8a 00                	mov    (%eax),%al
  801eb3:	0f b6 d0             	movzbl %al,%edx
  801eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801eb9:	8a 00                	mov    (%eax),%al
  801ebb:	0f b6 c0             	movzbl %al,%eax
  801ebe:	29 c2                	sub    %eax,%edx
  801ec0:	89 d0                	mov    %edx,%eax
}
  801ec2:	5d                   	pop    %ebp
  801ec3:	c3                   	ret    

00801ec4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
  801ec7:	83 ec 04             	sub    $0x4,%esp
  801eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ecd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801ed0:	eb 12                	jmp    801ee4 <strchr+0x20>
		if (*s == c)
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	8a 00                	mov    (%eax),%al
  801ed7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801eda:	75 05                	jne    801ee1 <strchr+0x1d>
			return (char *) s;
  801edc:	8b 45 08             	mov    0x8(%ebp),%eax
  801edf:	eb 11                	jmp    801ef2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801ee1:	ff 45 08             	incl   0x8(%ebp)
  801ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee7:	8a 00                	mov    (%eax),%al
  801ee9:	84 c0                	test   %al,%al
  801eeb:	75 e5                	jne    801ed2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801eed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
  801ef7:	83 ec 04             	sub    $0x4,%esp
  801efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801efd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801f00:	eb 0d                	jmp    801f0f <strfind+0x1b>
		if (*s == c)
  801f02:	8b 45 08             	mov    0x8(%ebp),%eax
  801f05:	8a 00                	mov    (%eax),%al
  801f07:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801f0a:	74 0e                	je     801f1a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801f0c:	ff 45 08             	incl   0x8(%ebp)
  801f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f12:	8a 00                	mov    (%eax),%al
  801f14:	84 c0                	test   %al,%al
  801f16:	75 ea                	jne    801f02 <strfind+0xe>
  801f18:	eb 01                	jmp    801f1b <strfind+0x27>
		if (*s == c)
			break;
  801f1a:	90                   	nop
	return (char *) s;
  801f1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f1e:	c9                   	leave  
  801f1f:	c3                   	ret    

00801f20 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
  801f23:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801f26:	8b 45 08             	mov    0x8(%ebp),%eax
  801f29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801f2c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801f32:	eb 0e                	jmp    801f42 <memset+0x22>
		*p++ = c;
  801f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f37:	8d 50 01             	lea    0x1(%eax),%edx
  801f3a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801f3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f40:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801f42:	ff 4d f8             	decl   -0x8(%ebp)
  801f45:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801f49:	79 e9                	jns    801f34 <memset+0x14>
		*p++ = c;

	return v;
  801f4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f4e:	c9                   	leave  
  801f4f:	c3                   	ret    

00801f50 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801f50:	55                   	push   %ebp
  801f51:	89 e5                	mov    %esp,%ebp
  801f53:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801f56:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801f62:	eb 16                	jmp    801f7a <memcpy+0x2a>
		*d++ = *s++;
  801f64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f67:	8d 50 01             	lea    0x1(%eax),%edx
  801f6a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801f6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f70:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f73:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801f76:	8a 12                	mov    (%edx),%dl
  801f78:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801f7a:	8b 45 10             	mov    0x10(%ebp),%eax
  801f7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801f80:	89 55 10             	mov    %edx,0x10(%ebp)
  801f83:	85 c0                	test   %eax,%eax
  801f85:	75 dd                	jne    801f64 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801f87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801f98:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fa1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801fa4:	73 50                	jae    801ff6 <memmove+0x6a>
  801fa6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  801fac:	01 d0                	add    %edx,%eax
  801fae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801fb1:	76 43                	jbe    801ff6 <memmove+0x6a>
		s += n;
  801fb3:	8b 45 10             	mov    0x10(%ebp),%eax
  801fb6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  801fbc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801fbf:	eb 10                	jmp    801fd1 <memmove+0x45>
			*--d = *--s;
  801fc1:	ff 4d f8             	decl   -0x8(%ebp)
  801fc4:	ff 4d fc             	decl   -0x4(%ebp)
  801fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fca:	8a 10                	mov    (%eax),%dl
  801fcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fcf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801fd1:	8b 45 10             	mov    0x10(%ebp),%eax
  801fd4:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fd7:	89 55 10             	mov    %edx,0x10(%ebp)
  801fda:	85 c0                	test   %eax,%eax
  801fdc:	75 e3                	jne    801fc1 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801fde:	eb 23                	jmp    802003 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fe3:	8d 50 01             	lea    0x1(%eax),%edx
  801fe6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801fe9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fec:	8d 4a 01             	lea    0x1(%edx),%ecx
  801fef:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801ff2:	8a 12                	mov    (%edx),%dl
  801ff4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ff9:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ffc:	89 55 10             	mov    %edx,0x10(%ebp)
  801fff:	85 c0                	test   %eax,%eax
  802001:	75 dd                	jne    801fe0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802003:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802006:	c9                   	leave  
  802007:	c3                   	ret    

00802008 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  802008:	55                   	push   %ebp
  802009:	89 e5                	mov    %esp,%ebp
  80200b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80200e:	8b 45 08             	mov    0x8(%ebp),%eax
  802011:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802014:	8b 45 0c             	mov    0xc(%ebp),%eax
  802017:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80201a:	eb 2a                	jmp    802046 <memcmp+0x3e>
		if (*s1 != *s2)
  80201c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80201f:	8a 10                	mov    (%eax),%dl
  802021:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802024:	8a 00                	mov    (%eax),%al
  802026:	38 c2                	cmp    %al,%dl
  802028:	74 16                	je     802040 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80202a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80202d:	8a 00                	mov    (%eax),%al
  80202f:	0f b6 d0             	movzbl %al,%edx
  802032:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802035:	8a 00                	mov    (%eax),%al
  802037:	0f b6 c0             	movzbl %al,%eax
  80203a:	29 c2                	sub    %eax,%edx
  80203c:	89 d0                	mov    %edx,%eax
  80203e:	eb 18                	jmp    802058 <memcmp+0x50>
		s1++, s2++;
  802040:	ff 45 fc             	incl   -0x4(%ebp)
  802043:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802046:	8b 45 10             	mov    0x10(%ebp),%eax
  802049:	8d 50 ff             	lea    -0x1(%eax),%edx
  80204c:	89 55 10             	mov    %edx,0x10(%ebp)
  80204f:	85 c0                	test   %eax,%eax
  802051:	75 c9                	jne    80201c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802053:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802058:	c9                   	leave  
  802059:	c3                   	ret    

0080205a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80205a:	55                   	push   %ebp
  80205b:	89 e5                	mov    %esp,%ebp
  80205d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802060:	8b 55 08             	mov    0x8(%ebp),%edx
  802063:	8b 45 10             	mov    0x10(%ebp),%eax
  802066:	01 d0                	add    %edx,%eax
  802068:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80206b:	eb 15                	jmp    802082 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80206d:	8b 45 08             	mov    0x8(%ebp),%eax
  802070:	8a 00                	mov    (%eax),%al
  802072:	0f b6 d0             	movzbl %al,%edx
  802075:	8b 45 0c             	mov    0xc(%ebp),%eax
  802078:	0f b6 c0             	movzbl %al,%eax
  80207b:	39 c2                	cmp    %eax,%edx
  80207d:	74 0d                	je     80208c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80207f:	ff 45 08             	incl   0x8(%ebp)
  802082:	8b 45 08             	mov    0x8(%ebp),%eax
  802085:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802088:	72 e3                	jb     80206d <memfind+0x13>
  80208a:	eb 01                	jmp    80208d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80208c:	90                   	nop
	return (void *) s;
  80208d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802090:	c9                   	leave  
  802091:	c3                   	ret    

00802092 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802092:	55                   	push   %ebp
  802093:	89 e5                	mov    %esp,%ebp
  802095:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802098:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80209f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8020a6:	eb 03                	jmp    8020ab <strtol+0x19>
		s++;
  8020a8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8020ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ae:	8a 00                	mov    (%eax),%al
  8020b0:	3c 20                	cmp    $0x20,%al
  8020b2:	74 f4                	je     8020a8 <strtol+0x16>
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	8a 00                	mov    (%eax),%al
  8020b9:	3c 09                	cmp    $0x9,%al
  8020bb:	74 eb                	je     8020a8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8020bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c0:	8a 00                	mov    (%eax),%al
  8020c2:	3c 2b                	cmp    $0x2b,%al
  8020c4:	75 05                	jne    8020cb <strtol+0x39>
		s++;
  8020c6:	ff 45 08             	incl   0x8(%ebp)
  8020c9:	eb 13                	jmp    8020de <strtol+0x4c>
	else if (*s == '-')
  8020cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ce:	8a 00                	mov    (%eax),%al
  8020d0:	3c 2d                	cmp    $0x2d,%al
  8020d2:	75 0a                	jne    8020de <strtol+0x4c>
		s++, neg = 1;
  8020d4:	ff 45 08             	incl   0x8(%ebp)
  8020d7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8020de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8020e2:	74 06                	je     8020ea <strtol+0x58>
  8020e4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8020e8:	75 20                	jne    80210a <strtol+0x78>
  8020ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ed:	8a 00                	mov    (%eax),%al
  8020ef:	3c 30                	cmp    $0x30,%al
  8020f1:	75 17                	jne    80210a <strtol+0x78>
  8020f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f6:	40                   	inc    %eax
  8020f7:	8a 00                	mov    (%eax),%al
  8020f9:	3c 78                	cmp    $0x78,%al
  8020fb:	75 0d                	jne    80210a <strtol+0x78>
		s += 2, base = 16;
  8020fd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802101:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  802108:	eb 28                	jmp    802132 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80210a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80210e:	75 15                	jne    802125 <strtol+0x93>
  802110:	8b 45 08             	mov    0x8(%ebp),%eax
  802113:	8a 00                	mov    (%eax),%al
  802115:	3c 30                	cmp    $0x30,%al
  802117:	75 0c                	jne    802125 <strtol+0x93>
		s++, base = 8;
  802119:	ff 45 08             	incl   0x8(%ebp)
  80211c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802123:	eb 0d                	jmp    802132 <strtol+0xa0>
	else if (base == 0)
  802125:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802129:	75 07                	jne    802132 <strtol+0xa0>
		base = 10;
  80212b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802132:	8b 45 08             	mov    0x8(%ebp),%eax
  802135:	8a 00                	mov    (%eax),%al
  802137:	3c 2f                	cmp    $0x2f,%al
  802139:	7e 19                	jle    802154 <strtol+0xc2>
  80213b:	8b 45 08             	mov    0x8(%ebp),%eax
  80213e:	8a 00                	mov    (%eax),%al
  802140:	3c 39                	cmp    $0x39,%al
  802142:	7f 10                	jg     802154 <strtol+0xc2>
			dig = *s - '0';
  802144:	8b 45 08             	mov    0x8(%ebp),%eax
  802147:	8a 00                	mov    (%eax),%al
  802149:	0f be c0             	movsbl %al,%eax
  80214c:	83 e8 30             	sub    $0x30,%eax
  80214f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802152:	eb 42                	jmp    802196 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802154:	8b 45 08             	mov    0x8(%ebp),%eax
  802157:	8a 00                	mov    (%eax),%al
  802159:	3c 60                	cmp    $0x60,%al
  80215b:	7e 19                	jle    802176 <strtol+0xe4>
  80215d:	8b 45 08             	mov    0x8(%ebp),%eax
  802160:	8a 00                	mov    (%eax),%al
  802162:	3c 7a                	cmp    $0x7a,%al
  802164:	7f 10                	jg     802176 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802166:	8b 45 08             	mov    0x8(%ebp),%eax
  802169:	8a 00                	mov    (%eax),%al
  80216b:	0f be c0             	movsbl %al,%eax
  80216e:	83 e8 57             	sub    $0x57,%eax
  802171:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802174:	eb 20                	jmp    802196 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802176:	8b 45 08             	mov    0x8(%ebp),%eax
  802179:	8a 00                	mov    (%eax),%al
  80217b:	3c 40                	cmp    $0x40,%al
  80217d:	7e 39                	jle    8021b8 <strtol+0x126>
  80217f:	8b 45 08             	mov    0x8(%ebp),%eax
  802182:	8a 00                	mov    (%eax),%al
  802184:	3c 5a                	cmp    $0x5a,%al
  802186:	7f 30                	jg     8021b8 <strtol+0x126>
			dig = *s - 'A' + 10;
  802188:	8b 45 08             	mov    0x8(%ebp),%eax
  80218b:	8a 00                	mov    (%eax),%al
  80218d:	0f be c0             	movsbl %al,%eax
  802190:	83 e8 37             	sub    $0x37,%eax
  802193:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802196:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802199:	3b 45 10             	cmp    0x10(%ebp),%eax
  80219c:	7d 19                	jge    8021b7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80219e:	ff 45 08             	incl   0x8(%ebp)
  8021a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021a4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8021a8:	89 c2                	mov    %eax,%edx
  8021aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021ad:	01 d0                	add    %edx,%eax
  8021af:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8021b2:	e9 7b ff ff ff       	jmp    802132 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8021b7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8021b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8021bc:	74 08                	je     8021c6 <strtol+0x134>
		*endptr = (char *) s;
  8021be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021c1:	8b 55 08             	mov    0x8(%ebp),%edx
  8021c4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8021c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8021ca:	74 07                	je     8021d3 <strtol+0x141>
  8021cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021cf:	f7 d8                	neg    %eax
  8021d1:	eb 03                	jmp    8021d6 <strtol+0x144>
  8021d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8021d6:	c9                   	leave  
  8021d7:	c3                   	ret    

008021d8 <ltostr>:

void
ltostr(long value, char *str)
{
  8021d8:	55                   	push   %ebp
  8021d9:	89 e5                	mov    %esp,%ebp
  8021db:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8021de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8021e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8021ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8021f0:	79 13                	jns    802205 <ltostr+0x2d>
	{
		neg = 1;
  8021f2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8021f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021fc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8021ff:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802202:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802205:	8b 45 08             	mov    0x8(%ebp),%eax
  802208:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80220d:	99                   	cltd   
  80220e:	f7 f9                	idiv   %ecx
  802210:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802213:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802216:	8d 50 01             	lea    0x1(%eax),%edx
  802219:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80221c:	89 c2                	mov    %eax,%edx
  80221e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802221:	01 d0                	add    %edx,%eax
  802223:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802226:	83 c2 30             	add    $0x30,%edx
  802229:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80222b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80222e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802233:	f7 e9                	imul   %ecx
  802235:	c1 fa 02             	sar    $0x2,%edx
  802238:	89 c8                	mov    %ecx,%eax
  80223a:	c1 f8 1f             	sar    $0x1f,%eax
  80223d:	29 c2                	sub    %eax,%edx
  80223f:	89 d0                	mov    %edx,%eax
  802241:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802247:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80224c:	f7 e9                	imul   %ecx
  80224e:	c1 fa 02             	sar    $0x2,%edx
  802251:	89 c8                	mov    %ecx,%eax
  802253:	c1 f8 1f             	sar    $0x1f,%eax
  802256:	29 c2                	sub    %eax,%edx
  802258:	89 d0                	mov    %edx,%eax
  80225a:	c1 e0 02             	shl    $0x2,%eax
  80225d:	01 d0                	add    %edx,%eax
  80225f:	01 c0                	add    %eax,%eax
  802261:	29 c1                	sub    %eax,%ecx
  802263:	89 ca                	mov    %ecx,%edx
  802265:	85 d2                	test   %edx,%edx
  802267:	75 9c                	jne    802205 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802269:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802270:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802273:	48                   	dec    %eax
  802274:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  802277:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80227b:	74 3d                	je     8022ba <ltostr+0xe2>
		start = 1 ;
  80227d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802284:	eb 34                	jmp    8022ba <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802286:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80228c:	01 d0                	add    %edx,%eax
  80228e:	8a 00                	mov    (%eax),%al
  802290:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802293:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802296:	8b 45 0c             	mov    0xc(%ebp),%eax
  802299:	01 c2                	add    %eax,%edx
  80229b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80229e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022a1:	01 c8                	add    %ecx,%eax
  8022a3:	8a 00                	mov    (%eax),%al
  8022a5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8022a7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8022aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022ad:	01 c2                	add    %eax,%edx
  8022af:	8a 45 eb             	mov    -0x15(%ebp),%al
  8022b2:	88 02                	mov    %al,(%edx)
		start++ ;
  8022b4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8022b7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8022ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8022c0:	7c c4                	jl     802286 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8022c2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8022c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022c8:	01 d0                	add    %edx,%eax
  8022ca:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8022cd:	90                   	nop
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
  8022d3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8022d6:	ff 75 08             	pushl  0x8(%ebp)
  8022d9:	e8 54 fa ff ff       	call   801d32 <strlen>
  8022de:	83 c4 04             	add    $0x4,%esp
  8022e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8022e4:	ff 75 0c             	pushl  0xc(%ebp)
  8022e7:	e8 46 fa ff ff       	call   801d32 <strlen>
  8022ec:	83 c4 04             	add    $0x4,%esp
  8022ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8022f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8022f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802300:	eb 17                	jmp    802319 <strcconcat+0x49>
		final[s] = str1[s] ;
  802302:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802305:	8b 45 10             	mov    0x10(%ebp),%eax
  802308:	01 c2                	add    %eax,%edx
  80230a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80230d:	8b 45 08             	mov    0x8(%ebp),%eax
  802310:	01 c8                	add    %ecx,%eax
  802312:	8a 00                	mov    (%eax),%al
  802314:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802316:	ff 45 fc             	incl   -0x4(%ebp)
  802319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80231c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80231f:	7c e1                	jl     802302 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802321:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  802328:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80232f:	eb 1f                	jmp    802350 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802331:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802334:	8d 50 01             	lea    0x1(%eax),%edx
  802337:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80233a:	89 c2                	mov    %eax,%edx
  80233c:	8b 45 10             	mov    0x10(%ebp),%eax
  80233f:	01 c2                	add    %eax,%edx
  802341:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802344:	8b 45 0c             	mov    0xc(%ebp),%eax
  802347:	01 c8                	add    %ecx,%eax
  802349:	8a 00                	mov    (%eax),%al
  80234b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80234d:	ff 45 f8             	incl   -0x8(%ebp)
  802350:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802356:	7c d9                	jl     802331 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  802358:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80235b:	8b 45 10             	mov    0x10(%ebp),%eax
  80235e:	01 d0                	add    %edx,%eax
  802360:	c6 00 00             	movb   $0x0,(%eax)
}
  802363:	90                   	nop
  802364:	c9                   	leave  
  802365:	c3                   	ret    

00802366 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802366:	55                   	push   %ebp
  802367:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802369:	8b 45 14             	mov    0x14(%ebp),%eax
  80236c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802372:	8b 45 14             	mov    0x14(%ebp),%eax
  802375:	8b 00                	mov    (%eax),%eax
  802377:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80237e:	8b 45 10             	mov    0x10(%ebp),%eax
  802381:	01 d0                	add    %edx,%eax
  802383:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802389:	eb 0c                	jmp    802397 <strsplit+0x31>
			*string++ = 0;
  80238b:	8b 45 08             	mov    0x8(%ebp),%eax
  80238e:	8d 50 01             	lea    0x1(%eax),%edx
  802391:	89 55 08             	mov    %edx,0x8(%ebp)
  802394:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802397:	8b 45 08             	mov    0x8(%ebp),%eax
  80239a:	8a 00                	mov    (%eax),%al
  80239c:	84 c0                	test   %al,%al
  80239e:	74 18                	je     8023b8 <strsplit+0x52>
  8023a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a3:	8a 00                	mov    (%eax),%al
  8023a5:	0f be c0             	movsbl %al,%eax
  8023a8:	50                   	push   %eax
  8023a9:	ff 75 0c             	pushl  0xc(%ebp)
  8023ac:	e8 13 fb ff ff       	call   801ec4 <strchr>
  8023b1:	83 c4 08             	add    $0x8,%esp
  8023b4:	85 c0                	test   %eax,%eax
  8023b6:	75 d3                	jne    80238b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8023b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023bb:	8a 00                	mov    (%eax),%al
  8023bd:	84 c0                	test   %al,%al
  8023bf:	74 5a                	je     80241b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8023c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8023c4:	8b 00                	mov    (%eax),%eax
  8023c6:	83 f8 0f             	cmp    $0xf,%eax
  8023c9:	75 07                	jne    8023d2 <strsplit+0x6c>
		{
			return 0;
  8023cb:	b8 00 00 00 00       	mov    $0x0,%eax
  8023d0:	eb 66                	jmp    802438 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8023d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8023d5:	8b 00                	mov    (%eax),%eax
  8023d7:	8d 48 01             	lea    0x1(%eax),%ecx
  8023da:	8b 55 14             	mov    0x14(%ebp),%edx
  8023dd:	89 0a                	mov    %ecx,(%edx)
  8023df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8023e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8023e9:	01 c2                	add    %eax,%edx
  8023eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ee:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8023f0:	eb 03                	jmp    8023f5 <strsplit+0x8f>
			string++;
  8023f2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8023f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f8:	8a 00                	mov    (%eax),%al
  8023fa:	84 c0                	test   %al,%al
  8023fc:	74 8b                	je     802389 <strsplit+0x23>
  8023fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802401:	8a 00                	mov    (%eax),%al
  802403:	0f be c0             	movsbl %al,%eax
  802406:	50                   	push   %eax
  802407:	ff 75 0c             	pushl  0xc(%ebp)
  80240a:	e8 b5 fa ff ff       	call   801ec4 <strchr>
  80240f:	83 c4 08             	add    $0x8,%esp
  802412:	85 c0                	test   %eax,%eax
  802414:	74 dc                	je     8023f2 <strsplit+0x8c>
			string++;
	}
  802416:	e9 6e ff ff ff       	jmp    802389 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80241b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80241c:	8b 45 14             	mov    0x14(%ebp),%eax
  80241f:	8b 00                	mov    (%eax),%eax
  802421:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802428:	8b 45 10             	mov    0x10(%ebp),%eax
  80242b:	01 d0                	add    %edx,%eax
  80242d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802433:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802438:	c9                   	leave  
  802439:	c3                   	ret    

0080243a <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  80243a:	55                   	push   %ebp
  80243b:	89 e5                	mov    %esp,%ebp
  80243d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  802440:	83 ec 04             	sub    $0x4,%esp
  802443:	68 30 37 80 00       	push   $0x803730
  802448:	6a 19                	push   $0x19
  80244a:	68 55 37 80 00       	push   $0x803755
  80244f:	e8 a8 ef ff ff       	call   8013fc <_panic>

00802454 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802454:	55                   	push   %ebp
  802455:	89 e5                	mov    %esp,%ebp
  802457:	83 ec 18             	sub    $0x18,%esp
  80245a:	8b 45 10             	mov    0x10(%ebp),%eax
  80245d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  802460:	83 ec 04             	sub    $0x4,%esp
  802463:	68 64 37 80 00       	push   $0x803764
  802468:	6a 30                	push   $0x30
  80246a:	68 55 37 80 00       	push   $0x803755
  80246f:	e8 88 ef ff ff       	call   8013fc <_panic>

00802474 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802474:	55                   	push   %ebp
  802475:	89 e5                	mov    %esp,%ebp
  802477:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80247a:	83 ec 04             	sub    $0x4,%esp
  80247d:	68 83 37 80 00       	push   $0x803783
  802482:	6a 36                	push   $0x36
  802484:	68 55 37 80 00       	push   $0x803755
  802489:	e8 6e ef ff ff       	call   8013fc <_panic>

0080248e <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80248e:	55                   	push   %ebp
  80248f:	89 e5                	mov    %esp,%ebp
  802491:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  802494:	83 ec 04             	sub    $0x4,%esp
  802497:	68 a0 37 80 00       	push   $0x8037a0
  80249c:	6a 48                	push   $0x48
  80249e:	68 55 37 80 00       	push   $0x803755
  8024a3:	e8 54 ef ff ff       	call   8013fc <_panic>

008024a8 <sfree>:

}


void sfree(void* virtual_address)
{
  8024a8:	55                   	push   %ebp
  8024a9:	89 e5                	mov    %esp,%ebp
  8024ab:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8024ae:	83 ec 04             	sub    $0x4,%esp
  8024b1:	68 c3 37 80 00       	push   $0x8037c3
  8024b6:	6a 53                	push   $0x53
  8024b8:	68 55 37 80 00       	push   $0x803755
  8024bd:	e8 3a ef ff ff       	call   8013fc <_panic>

008024c2 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8024c2:	55                   	push   %ebp
  8024c3:	89 e5                	mov    %esp,%ebp
  8024c5:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8024c8:	83 ec 04             	sub    $0x4,%esp
  8024cb:	68 e0 37 80 00       	push   $0x8037e0
  8024d0:	6a 6c                	push   $0x6c
  8024d2:	68 55 37 80 00       	push   $0x803755
  8024d7:	e8 20 ef ff ff       	call   8013fc <_panic>

008024dc <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8024dc:	55                   	push   %ebp
  8024dd:	89 e5                	mov    %esp,%ebp
  8024df:	57                   	push   %edi
  8024e0:	56                   	push   %esi
  8024e1:	53                   	push   %ebx
  8024e2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8024e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024ee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8024f1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8024f4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8024f7:	cd 30                	int    $0x30
  8024f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8024fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8024ff:	83 c4 10             	add    $0x10,%esp
  802502:	5b                   	pop    %ebx
  802503:	5e                   	pop    %esi
  802504:	5f                   	pop    %edi
  802505:	5d                   	pop    %ebp
  802506:	c3                   	ret    

00802507 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802507:	55                   	push   %ebp
  802508:	89 e5                	mov    %esp,%ebp
  80250a:	83 ec 04             	sub    $0x4,%esp
  80250d:	8b 45 10             	mov    0x10(%ebp),%eax
  802510:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802513:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802517:	8b 45 08             	mov    0x8(%ebp),%eax
  80251a:	6a 00                	push   $0x0
  80251c:	6a 00                	push   $0x0
  80251e:	52                   	push   %edx
  80251f:	ff 75 0c             	pushl  0xc(%ebp)
  802522:	50                   	push   %eax
  802523:	6a 00                	push   $0x0
  802525:	e8 b2 ff ff ff       	call   8024dc <syscall>
  80252a:	83 c4 18             	add    $0x18,%esp
}
  80252d:	90                   	nop
  80252e:	c9                   	leave  
  80252f:	c3                   	ret    

00802530 <sys_cgetc>:

int
sys_cgetc(void)
{
  802530:	55                   	push   %ebp
  802531:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802533:	6a 00                	push   $0x0
  802535:	6a 00                	push   $0x0
  802537:	6a 00                	push   $0x0
  802539:	6a 00                	push   $0x0
  80253b:	6a 00                	push   $0x0
  80253d:	6a 01                	push   $0x1
  80253f:	e8 98 ff ff ff       	call   8024dc <syscall>
  802544:	83 c4 18             	add    $0x18,%esp
}
  802547:	c9                   	leave  
  802548:	c3                   	ret    

00802549 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802549:	55                   	push   %ebp
  80254a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80254c:	8b 45 08             	mov    0x8(%ebp),%eax
  80254f:	6a 00                	push   $0x0
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	6a 00                	push   $0x0
  802557:	50                   	push   %eax
  802558:	6a 05                	push   $0x5
  80255a:	e8 7d ff ff ff       	call   8024dc <syscall>
  80255f:	83 c4 18             	add    $0x18,%esp
}
  802562:	c9                   	leave  
  802563:	c3                   	ret    

00802564 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802564:	55                   	push   %ebp
  802565:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802567:	6a 00                	push   $0x0
  802569:	6a 00                	push   $0x0
  80256b:	6a 00                	push   $0x0
  80256d:	6a 00                	push   $0x0
  80256f:	6a 00                	push   $0x0
  802571:	6a 02                	push   $0x2
  802573:	e8 64 ff ff ff       	call   8024dc <syscall>
  802578:	83 c4 18             	add    $0x18,%esp
}
  80257b:	c9                   	leave  
  80257c:	c3                   	ret    

0080257d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80257d:	55                   	push   %ebp
  80257e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802580:	6a 00                	push   $0x0
  802582:	6a 00                	push   $0x0
  802584:	6a 00                	push   $0x0
  802586:	6a 00                	push   $0x0
  802588:	6a 00                	push   $0x0
  80258a:	6a 03                	push   $0x3
  80258c:	e8 4b ff ff ff       	call   8024dc <syscall>
  802591:	83 c4 18             	add    $0x18,%esp
}
  802594:	c9                   	leave  
  802595:	c3                   	ret    

00802596 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802596:	55                   	push   %ebp
  802597:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802599:	6a 00                	push   $0x0
  80259b:	6a 00                	push   $0x0
  80259d:	6a 00                	push   $0x0
  80259f:	6a 00                	push   $0x0
  8025a1:	6a 00                	push   $0x0
  8025a3:	6a 04                	push   $0x4
  8025a5:	e8 32 ff ff ff       	call   8024dc <syscall>
  8025aa:	83 c4 18             	add    $0x18,%esp
}
  8025ad:	c9                   	leave  
  8025ae:	c3                   	ret    

008025af <sys_env_exit>:


void sys_env_exit(void)
{
  8025af:	55                   	push   %ebp
  8025b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8025b2:	6a 00                	push   $0x0
  8025b4:	6a 00                	push   $0x0
  8025b6:	6a 00                	push   $0x0
  8025b8:	6a 00                	push   $0x0
  8025ba:	6a 00                	push   $0x0
  8025bc:	6a 06                	push   $0x6
  8025be:	e8 19 ff ff ff       	call   8024dc <syscall>
  8025c3:	83 c4 18             	add    $0x18,%esp
}
  8025c6:	90                   	nop
  8025c7:	c9                   	leave  
  8025c8:	c3                   	ret    

008025c9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8025c9:	55                   	push   %ebp
  8025ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8025cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8025d2:	6a 00                	push   $0x0
  8025d4:	6a 00                	push   $0x0
  8025d6:	6a 00                	push   $0x0
  8025d8:	52                   	push   %edx
  8025d9:	50                   	push   %eax
  8025da:	6a 07                	push   $0x7
  8025dc:	e8 fb fe ff ff       	call   8024dc <syscall>
  8025e1:	83 c4 18             	add    $0x18,%esp
}
  8025e4:	c9                   	leave  
  8025e5:	c3                   	ret    

008025e6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8025e6:	55                   	push   %ebp
  8025e7:	89 e5                	mov    %esp,%ebp
  8025e9:	56                   	push   %esi
  8025ea:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8025eb:	8b 75 18             	mov    0x18(%ebp),%esi
  8025ee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8025f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8025f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8025fa:	56                   	push   %esi
  8025fb:	53                   	push   %ebx
  8025fc:	51                   	push   %ecx
  8025fd:	52                   	push   %edx
  8025fe:	50                   	push   %eax
  8025ff:	6a 08                	push   $0x8
  802601:	e8 d6 fe ff ff       	call   8024dc <syscall>
  802606:	83 c4 18             	add    $0x18,%esp
}
  802609:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80260c:	5b                   	pop    %ebx
  80260d:	5e                   	pop    %esi
  80260e:	5d                   	pop    %ebp
  80260f:	c3                   	ret    

00802610 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802610:	55                   	push   %ebp
  802611:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802613:	8b 55 0c             	mov    0xc(%ebp),%edx
  802616:	8b 45 08             	mov    0x8(%ebp),%eax
  802619:	6a 00                	push   $0x0
  80261b:	6a 00                	push   $0x0
  80261d:	6a 00                	push   $0x0
  80261f:	52                   	push   %edx
  802620:	50                   	push   %eax
  802621:	6a 09                	push   $0x9
  802623:	e8 b4 fe ff ff       	call   8024dc <syscall>
  802628:	83 c4 18             	add    $0x18,%esp
}
  80262b:	c9                   	leave  
  80262c:	c3                   	ret    

0080262d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80262d:	55                   	push   %ebp
  80262e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802630:	6a 00                	push   $0x0
  802632:	6a 00                	push   $0x0
  802634:	6a 00                	push   $0x0
  802636:	ff 75 0c             	pushl  0xc(%ebp)
  802639:	ff 75 08             	pushl  0x8(%ebp)
  80263c:	6a 0a                	push   $0xa
  80263e:	e8 99 fe ff ff       	call   8024dc <syscall>
  802643:	83 c4 18             	add    $0x18,%esp
}
  802646:	c9                   	leave  
  802647:	c3                   	ret    

00802648 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802648:	55                   	push   %ebp
  802649:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	6a 0b                	push   $0xb
  802657:	e8 80 fe ff ff       	call   8024dc <syscall>
  80265c:	83 c4 18             	add    $0x18,%esp
}
  80265f:	c9                   	leave  
  802660:	c3                   	ret    

00802661 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802661:	55                   	push   %ebp
  802662:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802664:	6a 00                	push   $0x0
  802666:	6a 00                	push   $0x0
  802668:	6a 00                	push   $0x0
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 0c                	push   $0xc
  802670:	e8 67 fe ff ff       	call   8024dc <syscall>
  802675:	83 c4 18             	add    $0x18,%esp
}
  802678:	c9                   	leave  
  802679:	c3                   	ret    

0080267a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80267a:	55                   	push   %ebp
  80267b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80267d:	6a 00                	push   $0x0
  80267f:	6a 00                	push   $0x0
  802681:	6a 00                	push   $0x0
  802683:	6a 00                	push   $0x0
  802685:	6a 00                	push   $0x0
  802687:	6a 0d                	push   $0xd
  802689:	e8 4e fe ff ff       	call   8024dc <syscall>
  80268e:	83 c4 18             	add    $0x18,%esp
}
  802691:	c9                   	leave  
  802692:	c3                   	ret    

00802693 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802693:	55                   	push   %ebp
  802694:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802696:	6a 00                	push   $0x0
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	ff 75 0c             	pushl  0xc(%ebp)
  80269f:	ff 75 08             	pushl  0x8(%ebp)
  8026a2:	6a 11                	push   $0x11
  8026a4:	e8 33 fe ff ff       	call   8024dc <syscall>
  8026a9:	83 c4 18             	add    $0x18,%esp
	return;
  8026ac:	90                   	nop
}
  8026ad:	c9                   	leave  
  8026ae:	c3                   	ret    

008026af <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8026af:	55                   	push   %ebp
  8026b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8026b2:	6a 00                	push   $0x0
  8026b4:	6a 00                	push   $0x0
  8026b6:	6a 00                	push   $0x0
  8026b8:	ff 75 0c             	pushl  0xc(%ebp)
  8026bb:	ff 75 08             	pushl  0x8(%ebp)
  8026be:	6a 12                	push   $0x12
  8026c0:	e8 17 fe ff ff       	call   8024dc <syscall>
  8026c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8026c8:	90                   	nop
}
  8026c9:	c9                   	leave  
  8026ca:	c3                   	ret    

008026cb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8026cb:	55                   	push   %ebp
  8026cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 00                	push   $0x0
  8026d2:	6a 00                	push   $0x0
  8026d4:	6a 00                	push   $0x0
  8026d6:	6a 00                	push   $0x0
  8026d8:	6a 0e                	push   $0xe
  8026da:	e8 fd fd ff ff       	call   8024dc <syscall>
  8026df:	83 c4 18             	add    $0x18,%esp
}
  8026e2:	c9                   	leave  
  8026e3:	c3                   	ret    

008026e4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8026e4:	55                   	push   %ebp
  8026e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8026e7:	6a 00                	push   $0x0
  8026e9:	6a 00                	push   $0x0
  8026eb:	6a 00                	push   $0x0
  8026ed:	6a 00                	push   $0x0
  8026ef:	ff 75 08             	pushl  0x8(%ebp)
  8026f2:	6a 0f                	push   $0xf
  8026f4:	e8 e3 fd ff ff       	call   8024dc <syscall>
  8026f9:	83 c4 18             	add    $0x18,%esp
}
  8026fc:	c9                   	leave  
  8026fd:	c3                   	ret    

008026fe <sys_scarce_memory>:

void sys_scarce_memory()
{
  8026fe:	55                   	push   %ebp
  8026ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802701:	6a 00                	push   $0x0
  802703:	6a 00                	push   $0x0
  802705:	6a 00                	push   $0x0
  802707:	6a 00                	push   $0x0
  802709:	6a 00                	push   $0x0
  80270b:	6a 10                	push   $0x10
  80270d:	e8 ca fd ff ff       	call   8024dc <syscall>
  802712:	83 c4 18             	add    $0x18,%esp
}
  802715:	90                   	nop
  802716:	c9                   	leave  
  802717:	c3                   	ret    

00802718 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802718:	55                   	push   %ebp
  802719:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80271b:	6a 00                	push   $0x0
  80271d:	6a 00                	push   $0x0
  80271f:	6a 00                	push   $0x0
  802721:	6a 00                	push   $0x0
  802723:	6a 00                	push   $0x0
  802725:	6a 14                	push   $0x14
  802727:	e8 b0 fd ff ff       	call   8024dc <syscall>
  80272c:	83 c4 18             	add    $0x18,%esp
}
  80272f:	90                   	nop
  802730:	c9                   	leave  
  802731:	c3                   	ret    

00802732 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802732:	55                   	push   %ebp
  802733:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802735:	6a 00                	push   $0x0
  802737:	6a 00                	push   $0x0
  802739:	6a 00                	push   $0x0
  80273b:	6a 00                	push   $0x0
  80273d:	6a 00                	push   $0x0
  80273f:	6a 15                	push   $0x15
  802741:	e8 96 fd ff ff       	call   8024dc <syscall>
  802746:	83 c4 18             	add    $0x18,%esp
}
  802749:	90                   	nop
  80274a:	c9                   	leave  
  80274b:	c3                   	ret    

0080274c <sys_cputc>:


void
sys_cputc(const char c)
{
  80274c:	55                   	push   %ebp
  80274d:	89 e5                	mov    %esp,%ebp
  80274f:	83 ec 04             	sub    $0x4,%esp
  802752:	8b 45 08             	mov    0x8(%ebp),%eax
  802755:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802758:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80275c:	6a 00                	push   $0x0
  80275e:	6a 00                	push   $0x0
  802760:	6a 00                	push   $0x0
  802762:	6a 00                	push   $0x0
  802764:	50                   	push   %eax
  802765:	6a 16                	push   $0x16
  802767:	e8 70 fd ff ff       	call   8024dc <syscall>
  80276c:	83 c4 18             	add    $0x18,%esp
}
  80276f:	90                   	nop
  802770:	c9                   	leave  
  802771:	c3                   	ret    

00802772 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802772:	55                   	push   %ebp
  802773:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802775:	6a 00                	push   $0x0
  802777:	6a 00                	push   $0x0
  802779:	6a 00                	push   $0x0
  80277b:	6a 00                	push   $0x0
  80277d:	6a 00                	push   $0x0
  80277f:	6a 17                	push   $0x17
  802781:	e8 56 fd ff ff       	call   8024dc <syscall>
  802786:	83 c4 18             	add    $0x18,%esp
}
  802789:	90                   	nop
  80278a:	c9                   	leave  
  80278b:	c3                   	ret    

0080278c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80278c:	55                   	push   %ebp
  80278d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80278f:	8b 45 08             	mov    0x8(%ebp),%eax
  802792:	6a 00                	push   $0x0
  802794:	6a 00                	push   $0x0
  802796:	6a 00                	push   $0x0
  802798:	ff 75 0c             	pushl  0xc(%ebp)
  80279b:	50                   	push   %eax
  80279c:	6a 18                	push   $0x18
  80279e:	e8 39 fd ff ff       	call   8024dc <syscall>
  8027a3:	83 c4 18             	add    $0x18,%esp
}
  8027a6:	c9                   	leave  
  8027a7:	c3                   	ret    

008027a8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8027a8:	55                   	push   %ebp
  8027a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8027ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b1:	6a 00                	push   $0x0
  8027b3:	6a 00                	push   $0x0
  8027b5:	6a 00                	push   $0x0
  8027b7:	52                   	push   %edx
  8027b8:	50                   	push   %eax
  8027b9:	6a 1b                	push   $0x1b
  8027bb:	e8 1c fd ff ff       	call   8024dc <syscall>
  8027c0:	83 c4 18             	add    $0x18,%esp
}
  8027c3:	c9                   	leave  
  8027c4:	c3                   	ret    

008027c5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8027c5:	55                   	push   %ebp
  8027c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8027c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8027ce:	6a 00                	push   $0x0
  8027d0:	6a 00                	push   $0x0
  8027d2:	6a 00                	push   $0x0
  8027d4:	52                   	push   %edx
  8027d5:	50                   	push   %eax
  8027d6:	6a 19                	push   $0x19
  8027d8:	e8 ff fc ff ff       	call   8024dc <syscall>
  8027dd:	83 c4 18             	add    $0x18,%esp
}
  8027e0:	90                   	nop
  8027e1:	c9                   	leave  
  8027e2:	c3                   	ret    

008027e3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8027e3:	55                   	push   %ebp
  8027e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8027e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8027ec:	6a 00                	push   $0x0
  8027ee:	6a 00                	push   $0x0
  8027f0:	6a 00                	push   $0x0
  8027f2:	52                   	push   %edx
  8027f3:	50                   	push   %eax
  8027f4:	6a 1a                	push   $0x1a
  8027f6:	e8 e1 fc ff ff       	call   8024dc <syscall>
  8027fb:	83 c4 18             	add    $0x18,%esp
}
  8027fe:	90                   	nop
  8027ff:	c9                   	leave  
  802800:	c3                   	ret    

00802801 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802801:	55                   	push   %ebp
  802802:	89 e5                	mov    %esp,%ebp
  802804:	83 ec 04             	sub    $0x4,%esp
  802807:	8b 45 10             	mov    0x10(%ebp),%eax
  80280a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80280d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802810:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802814:	8b 45 08             	mov    0x8(%ebp),%eax
  802817:	6a 00                	push   $0x0
  802819:	51                   	push   %ecx
  80281a:	52                   	push   %edx
  80281b:	ff 75 0c             	pushl  0xc(%ebp)
  80281e:	50                   	push   %eax
  80281f:	6a 1c                	push   $0x1c
  802821:	e8 b6 fc ff ff       	call   8024dc <syscall>
  802826:	83 c4 18             	add    $0x18,%esp
}
  802829:	c9                   	leave  
  80282a:	c3                   	ret    

0080282b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80282b:	55                   	push   %ebp
  80282c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80282e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802831:	8b 45 08             	mov    0x8(%ebp),%eax
  802834:	6a 00                	push   $0x0
  802836:	6a 00                	push   $0x0
  802838:	6a 00                	push   $0x0
  80283a:	52                   	push   %edx
  80283b:	50                   	push   %eax
  80283c:	6a 1d                	push   $0x1d
  80283e:	e8 99 fc ff ff       	call   8024dc <syscall>
  802843:	83 c4 18             	add    $0x18,%esp
}
  802846:	c9                   	leave  
  802847:	c3                   	ret    

00802848 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802848:	55                   	push   %ebp
  802849:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80284b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80284e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802851:	8b 45 08             	mov    0x8(%ebp),%eax
  802854:	6a 00                	push   $0x0
  802856:	6a 00                	push   $0x0
  802858:	51                   	push   %ecx
  802859:	52                   	push   %edx
  80285a:	50                   	push   %eax
  80285b:	6a 1e                	push   $0x1e
  80285d:	e8 7a fc ff ff       	call   8024dc <syscall>
  802862:	83 c4 18             	add    $0x18,%esp
}
  802865:	c9                   	leave  
  802866:	c3                   	ret    

00802867 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802867:	55                   	push   %ebp
  802868:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80286a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80286d:	8b 45 08             	mov    0x8(%ebp),%eax
  802870:	6a 00                	push   $0x0
  802872:	6a 00                	push   $0x0
  802874:	6a 00                	push   $0x0
  802876:	52                   	push   %edx
  802877:	50                   	push   %eax
  802878:	6a 1f                	push   $0x1f
  80287a:	e8 5d fc ff ff       	call   8024dc <syscall>
  80287f:	83 c4 18             	add    $0x18,%esp
}
  802882:	c9                   	leave  
  802883:	c3                   	ret    

00802884 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802884:	55                   	push   %ebp
  802885:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802887:	6a 00                	push   $0x0
  802889:	6a 00                	push   $0x0
  80288b:	6a 00                	push   $0x0
  80288d:	6a 00                	push   $0x0
  80288f:	6a 00                	push   $0x0
  802891:	6a 20                	push   $0x20
  802893:	e8 44 fc ff ff       	call   8024dc <syscall>
  802898:	83 c4 18             	add    $0x18,%esp
}
  80289b:	c9                   	leave  
  80289c:	c3                   	ret    

0080289d <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80289d:	55                   	push   %ebp
  80289e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8028a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a3:	6a 00                	push   $0x0
  8028a5:	6a 00                	push   $0x0
  8028a7:	ff 75 10             	pushl  0x10(%ebp)
  8028aa:	ff 75 0c             	pushl  0xc(%ebp)
  8028ad:	50                   	push   %eax
  8028ae:	6a 21                	push   $0x21
  8028b0:	e8 27 fc ff ff       	call   8024dc <syscall>
  8028b5:	83 c4 18             	add    $0x18,%esp
}
  8028b8:	c9                   	leave  
  8028b9:	c3                   	ret    

008028ba <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8028ba:	55                   	push   %ebp
  8028bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8028bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8028c0:	6a 00                	push   $0x0
  8028c2:	6a 00                	push   $0x0
  8028c4:	6a 00                	push   $0x0
  8028c6:	6a 00                	push   $0x0
  8028c8:	50                   	push   %eax
  8028c9:	6a 22                	push   $0x22
  8028cb:	e8 0c fc ff ff       	call   8024dc <syscall>
  8028d0:	83 c4 18             	add    $0x18,%esp
}
  8028d3:	90                   	nop
  8028d4:	c9                   	leave  
  8028d5:	c3                   	ret    

008028d6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8028d6:	55                   	push   %ebp
  8028d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8028d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8028dc:	6a 00                	push   $0x0
  8028de:	6a 00                	push   $0x0
  8028e0:	6a 00                	push   $0x0
  8028e2:	6a 00                	push   $0x0
  8028e4:	50                   	push   %eax
  8028e5:	6a 23                	push   $0x23
  8028e7:	e8 f0 fb ff ff       	call   8024dc <syscall>
  8028ec:	83 c4 18             	add    $0x18,%esp
}
  8028ef:	90                   	nop
  8028f0:	c9                   	leave  
  8028f1:	c3                   	ret    

008028f2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8028f2:	55                   	push   %ebp
  8028f3:	89 e5                	mov    %esp,%ebp
  8028f5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8028f8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8028fb:	8d 50 04             	lea    0x4(%eax),%edx
  8028fe:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802901:	6a 00                	push   $0x0
  802903:	6a 00                	push   $0x0
  802905:	6a 00                	push   $0x0
  802907:	52                   	push   %edx
  802908:	50                   	push   %eax
  802909:	6a 24                	push   $0x24
  80290b:	e8 cc fb ff ff       	call   8024dc <syscall>
  802910:	83 c4 18             	add    $0x18,%esp
	return result;
  802913:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802916:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802919:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80291c:	89 01                	mov    %eax,(%ecx)
  80291e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802921:	8b 45 08             	mov    0x8(%ebp),%eax
  802924:	c9                   	leave  
  802925:	c2 04 00             	ret    $0x4

00802928 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802928:	55                   	push   %ebp
  802929:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80292b:	6a 00                	push   $0x0
  80292d:	6a 00                	push   $0x0
  80292f:	ff 75 10             	pushl  0x10(%ebp)
  802932:	ff 75 0c             	pushl  0xc(%ebp)
  802935:	ff 75 08             	pushl  0x8(%ebp)
  802938:	6a 13                	push   $0x13
  80293a:	e8 9d fb ff ff       	call   8024dc <syscall>
  80293f:	83 c4 18             	add    $0x18,%esp
	return ;
  802942:	90                   	nop
}
  802943:	c9                   	leave  
  802944:	c3                   	ret    

00802945 <sys_rcr2>:
uint32 sys_rcr2()
{
  802945:	55                   	push   %ebp
  802946:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802948:	6a 00                	push   $0x0
  80294a:	6a 00                	push   $0x0
  80294c:	6a 00                	push   $0x0
  80294e:	6a 00                	push   $0x0
  802950:	6a 00                	push   $0x0
  802952:	6a 25                	push   $0x25
  802954:	e8 83 fb ff ff       	call   8024dc <syscall>
  802959:	83 c4 18             	add    $0x18,%esp
}
  80295c:	c9                   	leave  
  80295d:	c3                   	ret    

0080295e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80295e:	55                   	push   %ebp
  80295f:	89 e5                	mov    %esp,%ebp
  802961:	83 ec 04             	sub    $0x4,%esp
  802964:	8b 45 08             	mov    0x8(%ebp),%eax
  802967:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80296a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80296e:	6a 00                	push   $0x0
  802970:	6a 00                	push   $0x0
  802972:	6a 00                	push   $0x0
  802974:	6a 00                	push   $0x0
  802976:	50                   	push   %eax
  802977:	6a 26                	push   $0x26
  802979:	e8 5e fb ff ff       	call   8024dc <syscall>
  80297e:	83 c4 18             	add    $0x18,%esp
	return ;
  802981:	90                   	nop
}
  802982:	c9                   	leave  
  802983:	c3                   	ret    

00802984 <rsttst>:
void rsttst()
{
  802984:	55                   	push   %ebp
  802985:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802987:	6a 00                	push   $0x0
  802989:	6a 00                	push   $0x0
  80298b:	6a 00                	push   $0x0
  80298d:	6a 00                	push   $0x0
  80298f:	6a 00                	push   $0x0
  802991:	6a 28                	push   $0x28
  802993:	e8 44 fb ff ff       	call   8024dc <syscall>
  802998:	83 c4 18             	add    $0x18,%esp
	return ;
  80299b:	90                   	nop
}
  80299c:	c9                   	leave  
  80299d:	c3                   	ret    

0080299e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80299e:	55                   	push   %ebp
  80299f:	89 e5                	mov    %esp,%ebp
  8029a1:	83 ec 04             	sub    $0x4,%esp
  8029a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8029a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8029aa:	8b 55 18             	mov    0x18(%ebp),%edx
  8029ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8029b1:	52                   	push   %edx
  8029b2:	50                   	push   %eax
  8029b3:	ff 75 10             	pushl  0x10(%ebp)
  8029b6:	ff 75 0c             	pushl  0xc(%ebp)
  8029b9:	ff 75 08             	pushl  0x8(%ebp)
  8029bc:	6a 27                	push   $0x27
  8029be:	e8 19 fb ff ff       	call   8024dc <syscall>
  8029c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8029c6:	90                   	nop
}
  8029c7:	c9                   	leave  
  8029c8:	c3                   	ret    

008029c9 <chktst>:
void chktst(uint32 n)
{
  8029c9:	55                   	push   %ebp
  8029ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8029cc:	6a 00                	push   $0x0
  8029ce:	6a 00                	push   $0x0
  8029d0:	6a 00                	push   $0x0
  8029d2:	6a 00                	push   $0x0
  8029d4:	ff 75 08             	pushl  0x8(%ebp)
  8029d7:	6a 29                	push   $0x29
  8029d9:	e8 fe fa ff ff       	call   8024dc <syscall>
  8029de:	83 c4 18             	add    $0x18,%esp
	return ;
  8029e1:	90                   	nop
}
  8029e2:	c9                   	leave  
  8029e3:	c3                   	ret    

008029e4 <inctst>:

void inctst()
{
  8029e4:	55                   	push   %ebp
  8029e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8029e7:	6a 00                	push   $0x0
  8029e9:	6a 00                	push   $0x0
  8029eb:	6a 00                	push   $0x0
  8029ed:	6a 00                	push   $0x0
  8029ef:	6a 00                	push   $0x0
  8029f1:	6a 2a                	push   $0x2a
  8029f3:	e8 e4 fa ff ff       	call   8024dc <syscall>
  8029f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8029fb:	90                   	nop
}
  8029fc:	c9                   	leave  
  8029fd:	c3                   	ret    

008029fe <gettst>:
uint32 gettst()
{
  8029fe:	55                   	push   %ebp
  8029ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802a01:	6a 00                	push   $0x0
  802a03:	6a 00                	push   $0x0
  802a05:	6a 00                	push   $0x0
  802a07:	6a 00                	push   $0x0
  802a09:	6a 00                	push   $0x0
  802a0b:	6a 2b                	push   $0x2b
  802a0d:	e8 ca fa ff ff       	call   8024dc <syscall>
  802a12:	83 c4 18             	add    $0x18,%esp
}
  802a15:	c9                   	leave  
  802a16:	c3                   	ret    

00802a17 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802a17:	55                   	push   %ebp
  802a18:	89 e5                	mov    %esp,%ebp
  802a1a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802a1d:	6a 00                	push   $0x0
  802a1f:	6a 00                	push   $0x0
  802a21:	6a 00                	push   $0x0
  802a23:	6a 00                	push   $0x0
  802a25:	6a 00                	push   $0x0
  802a27:	6a 2c                	push   $0x2c
  802a29:	e8 ae fa ff ff       	call   8024dc <syscall>
  802a2e:	83 c4 18             	add    $0x18,%esp
  802a31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802a34:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802a38:	75 07                	jne    802a41 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802a3a:	b8 01 00 00 00       	mov    $0x1,%eax
  802a3f:	eb 05                	jmp    802a46 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802a41:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802a46:	c9                   	leave  
  802a47:	c3                   	ret    

00802a48 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802a48:	55                   	push   %ebp
  802a49:	89 e5                	mov    %esp,%ebp
  802a4b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802a4e:	6a 00                	push   $0x0
  802a50:	6a 00                	push   $0x0
  802a52:	6a 00                	push   $0x0
  802a54:	6a 00                	push   $0x0
  802a56:	6a 00                	push   $0x0
  802a58:	6a 2c                	push   $0x2c
  802a5a:	e8 7d fa ff ff       	call   8024dc <syscall>
  802a5f:	83 c4 18             	add    $0x18,%esp
  802a62:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802a65:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802a69:	75 07                	jne    802a72 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802a6b:	b8 01 00 00 00       	mov    $0x1,%eax
  802a70:	eb 05                	jmp    802a77 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802a72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802a77:	c9                   	leave  
  802a78:	c3                   	ret    

00802a79 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802a79:	55                   	push   %ebp
  802a7a:	89 e5                	mov    %esp,%ebp
  802a7c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802a7f:	6a 00                	push   $0x0
  802a81:	6a 00                	push   $0x0
  802a83:	6a 00                	push   $0x0
  802a85:	6a 00                	push   $0x0
  802a87:	6a 00                	push   $0x0
  802a89:	6a 2c                	push   $0x2c
  802a8b:	e8 4c fa ff ff       	call   8024dc <syscall>
  802a90:	83 c4 18             	add    $0x18,%esp
  802a93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802a96:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802a9a:	75 07                	jne    802aa3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802a9c:	b8 01 00 00 00       	mov    $0x1,%eax
  802aa1:	eb 05                	jmp    802aa8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802aa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802aa8:	c9                   	leave  
  802aa9:	c3                   	ret    

00802aaa <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802aaa:	55                   	push   %ebp
  802aab:	89 e5                	mov    %esp,%ebp
  802aad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802ab0:	6a 00                	push   $0x0
  802ab2:	6a 00                	push   $0x0
  802ab4:	6a 00                	push   $0x0
  802ab6:	6a 00                	push   $0x0
  802ab8:	6a 00                	push   $0x0
  802aba:	6a 2c                	push   $0x2c
  802abc:	e8 1b fa ff ff       	call   8024dc <syscall>
  802ac1:	83 c4 18             	add    $0x18,%esp
  802ac4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802ac7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802acb:	75 07                	jne    802ad4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802acd:	b8 01 00 00 00       	mov    $0x1,%eax
  802ad2:	eb 05                	jmp    802ad9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802ad4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802ad9:	c9                   	leave  
  802ada:	c3                   	ret    

00802adb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802adb:	55                   	push   %ebp
  802adc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802ade:	6a 00                	push   $0x0
  802ae0:	6a 00                	push   $0x0
  802ae2:	6a 00                	push   $0x0
  802ae4:	6a 00                	push   $0x0
  802ae6:	ff 75 08             	pushl  0x8(%ebp)
  802ae9:	6a 2d                	push   $0x2d
  802aeb:	e8 ec f9 ff ff       	call   8024dc <syscall>
  802af0:	83 c4 18             	add    $0x18,%esp
	return ;
  802af3:	90                   	nop
}
  802af4:	c9                   	leave  
  802af5:	c3                   	ret    
  802af6:	66 90                	xchg   %ax,%ax

00802af8 <__udivdi3>:
  802af8:	55                   	push   %ebp
  802af9:	57                   	push   %edi
  802afa:	56                   	push   %esi
  802afb:	53                   	push   %ebx
  802afc:	83 ec 1c             	sub    $0x1c,%esp
  802aff:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802b03:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802b07:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802b0b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802b0f:	89 ca                	mov    %ecx,%edx
  802b11:	89 f8                	mov    %edi,%eax
  802b13:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802b17:	85 f6                	test   %esi,%esi
  802b19:	75 2d                	jne    802b48 <__udivdi3+0x50>
  802b1b:	39 cf                	cmp    %ecx,%edi
  802b1d:	77 65                	ja     802b84 <__udivdi3+0x8c>
  802b1f:	89 fd                	mov    %edi,%ebp
  802b21:	85 ff                	test   %edi,%edi
  802b23:	75 0b                	jne    802b30 <__udivdi3+0x38>
  802b25:	b8 01 00 00 00       	mov    $0x1,%eax
  802b2a:	31 d2                	xor    %edx,%edx
  802b2c:	f7 f7                	div    %edi
  802b2e:	89 c5                	mov    %eax,%ebp
  802b30:	31 d2                	xor    %edx,%edx
  802b32:	89 c8                	mov    %ecx,%eax
  802b34:	f7 f5                	div    %ebp
  802b36:	89 c1                	mov    %eax,%ecx
  802b38:	89 d8                	mov    %ebx,%eax
  802b3a:	f7 f5                	div    %ebp
  802b3c:	89 cf                	mov    %ecx,%edi
  802b3e:	89 fa                	mov    %edi,%edx
  802b40:	83 c4 1c             	add    $0x1c,%esp
  802b43:	5b                   	pop    %ebx
  802b44:	5e                   	pop    %esi
  802b45:	5f                   	pop    %edi
  802b46:	5d                   	pop    %ebp
  802b47:	c3                   	ret    
  802b48:	39 ce                	cmp    %ecx,%esi
  802b4a:	77 28                	ja     802b74 <__udivdi3+0x7c>
  802b4c:	0f bd fe             	bsr    %esi,%edi
  802b4f:	83 f7 1f             	xor    $0x1f,%edi
  802b52:	75 40                	jne    802b94 <__udivdi3+0x9c>
  802b54:	39 ce                	cmp    %ecx,%esi
  802b56:	72 0a                	jb     802b62 <__udivdi3+0x6a>
  802b58:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802b5c:	0f 87 9e 00 00 00    	ja     802c00 <__udivdi3+0x108>
  802b62:	b8 01 00 00 00       	mov    $0x1,%eax
  802b67:	89 fa                	mov    %edi,%edx
  802b69:	83 c4 1c             	add    $0x1c,%esp
  802b6c:	5b                   	pop    %ebx
  802b6d:	5e                   	pop    %esi
  802b6e:	5f                   	pop    %edi
  802b6f:	5d                   	pop    %ebp
  802b70:	c3                   	ret    
  802b71:	8d 76 00             	lea    0x0(%esi),%esi
  802b74:	31 ff                	xor    %edi,%edi
  802b76:	31 c0                	xor    %eax,%eax
  802b78:	89 fa                	mov    %edi,%edx
  802b7a:	83 c4 1c             	add    $0x1c,%esp
  802b7d:	5b                   	pop    %ebx
  802b7e:	5e                   	pop    %esi
  802b7f:	5f                   	pop    %edi
  802b80:	5d                   	pop    %ebp
  802b81:	c3                   	ret    
  802b82:	66 90                	xchg   %ax,%ax
  802b84:	89 d8                	mov    %ebx,%eax
  802b86:	f7 f7                	div    %edi
  802b88:	31 ff                	xor    %edi,%edi
  802b8a:	89 fa                	mov    %edi,%edx
  802b8c:	83 c4 1c             	add    $0x1c,%esp
  802b8f:	5b                   	pop    %ebx
  802b90:	5e                   	pop    %esi
  802b91:	5f                   	pop    %edi
  802b92:	5d                   	pop    %ebp
  802b93:	c3                   	ret    
  802b94:	bd 20 00 00 00       	mov    $0x20,%ebp
  802b99:	89 eb                	mov    %ebp,%ebx
  802b9b:	29 fb                	sub    %edi,%ebx
  802b9d:	89 f9                	mov    %edi,%ecx
  802b9f:	d3 e6                	shl    %cl,%esi
  802ba1:	89 c5                	mov    %eax,%ebp
  802ba3:	88 d9                	mov    %bl,%cl
  802ba5:	d3 ed                	shr    %cl,%ebp
  802ba7:	89 e9                	mov    %ebp,%ecx
  802ba9:	09 f1                	or     %esi,%ecx
  802bab:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802baf:	89 f9                	mov    %edi,%ecx
  802bb1:	d3 e0                	shl    %cl,%eax
  802bb3:	89 c5                	mov    %eax,%ebp
  802bb5:	89 d6                	mov    %edx,%esi
  802bb7:	88 d9                	mov    %bl,%cl
  802bb9:	d3 ee                	shr    %cl,%esi
  802bbb:	89 f9                	mov    %edi,%ecx
  802bbd:	d3 e2                	shl    %cl,%edx
  802bbf:	8b 44 24 08          	mov    0x8(%esp),%eax
  802bc3:	88 d9                	mov    %bl,%cl
  802bc5:	d3 e8                	shr    %cl,%eax
  802bc7:	09 c2                	or     %eax,%edx
  802bc9:	89 d0                	mov    %edx,%eax
  802bcb:	89 f2                	mov    %esi,%edx
  802bcd:	f7 74 24 0c          	divl   0xc(%esp)
  802bd1:	89 d6                	mov    %edx,%esi
  802bd3:	89 c3                	mov    %eax,%ebx
  802bd5:	f7 e5                	mul    %ebp
  802bd7:	39 d6                	cmp    %edx,%esi
  802bd9:	72 19                	jb     802bf4 <__udivdi3+0xfc>
  802bdb:	74 0b                	je     802be8 <__udivdi3+0xf0>
  802bdd:	89 d8                	mov    %ebx,%eax
  802bdf:	31 ff                	xor    %edi,%edi
  802be1:	e9 58 ff ff ff       	jmp    802b3e <__udivdi3+0x46>
  802be6:	66 90                	xchg   %ax,%ax
  802be8:	8b 54 24 08          	mov    0x8(%esp),%edx
  802bec:	89 f9                	mov    %edi,%ecx
  802bee:	d3 e2                	shl    %cl,%edx
  802bf0:	39 c2                	cmp    %eax,%edx
  802bf2:	73 e9                	jae    802bdd <__udivdi3+0xe5>
  802bf4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802bf7:	31 ff                	xor    %edi,%edi
  802bf9:	e9 40 ff ff ff       	jmp    802b3e <__udivdi3+0x46>
  802bfe:	66 90                	xchg   %ax,%ax
  802c00:	31 c0                	xor    %eax,%eax
  802c02:	e9 37 ff ff ff       	jmp    802b3e <__udivdi3+0x46>
  802c07:	90                   	nop

00802c08 <__umoddi3>:
  802c08:	55                   	push   %ebp
  802c09:	57                   	push   %edi
  802c0a:	56                   	push   %esi
  802c0b:	53                   	push   %ebx
  802c0c:	83 ec 1c             	sub    $0x1c,%esp
  802c0f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802c13:	8b 74 24 34          	mov    0x34(%esp),%esi
  802c17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802c1b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802c1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802c23:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802c27:	89 f3                	mov    %esi,%ebx
  802c29:	89 fa                	mov    %edi,%edx
  802c2b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802c2f:	89 34 24             	mov    %esi,(%esp)
  802c32:	85 c0                	test   %eax,%eax
  802c34:	75 1a                	jne    802c50 <__umoddi3+0x48>
  802c36:	39 f7                	cmp    %esi,%edi
  802c38:	0f 86 a2 00 00 00    	jbe    802ce0 <__umoddi3+0xd8>
  802c3e:	89 c8                	mov    %ecx,%eax
  802c40:	89 f2                	mov    %esi,%edx
  802c42:	f7 f7                	div    %edi
  802c44:	89 d0                	mov    %edx,%eax
  802c46:	31 d2                	xor    %edx,%edx
  802c48:	83 c4 1c             	add    $0x1c,%esp
  802c4b:	5b                   	pop    %ebx
  802c4c:	5e                   	pop    %esi
  802c4d:	5f                   	pop    %edi
  802c4e:	5d                   	pop    %ebp
  802c4f:	c3                   	ret    
  802c50:	39 f0                	cmp    %esi,%eax
  802c52:	0f 87 ac 00 00 00    	ja     802d04 <__umoddi3+0xfc>
  802c58:	0f bd e8             	bsr    %eax,%ebp
  802c5b:	83 f5 1f             	xor    $0x1f,%ebp
  802c5e:	0f 84 ac 00 00 00    	je     802d10 <__umoddi3+0x108>
  802c64:	bf 20 00 00 00       	mov    $0x20,%edi
  802c69:	29 ef                	sub    %ebp,%edi
  802c6b:	89 fe                	mov    %edi,%esi
  802c6d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802c71:	89 e9                	mov    %ebp,%ecx
  802c73:	d3 e0                	shl    %cl,%eax
  802c75:	89 d7                	mov    %edx,%edi
  802c77:	89 f1                	mov    %esi,%ecx
  802c79:	d3 ef                	shr    %cl,%edi
  802c7b:	09 c7                	or     %eax,%edi
  802c7d:	89 e9                	mov    %ebp,%ecx
  802c7f:	d3 e2                	shl    %cl,%edx
  802c81:	89 14 24             	mov    %edx,(%esp)
  802c84:	89 d8                	mov    %ebx,%eax
  802c86:	d3 e0                	shl    %cl,%eax
  802c88:	89 c2                	mov    %eax,%edx
  802c8a:	8b 44 24 08          	mov    0x8(%esp),%eax
  802c8e:	d3 e0                	shl    %cl,%eax
  802c90:	89 44 24 04          	mov    %eax,0x4(%esp)
  802c94:	8b 44 24 08          	mov    0x8(%esp),%eax
  802c98:	89 f1                	mov    %esi,%ecx
  802c9a:	d3 e8                	shr    %cl,%eax
  802c9c:	09 d0                	or     %edx,%eax
  802c9e:	d3 eb                	shr    %cl,%ebx
  802ca0:	89 da                	mov    %ebx,%edx
  802ca2:	f7 f7                	div    %edi
  802ca4:	89 d3                	mov    %edx,%ebx
  802ca6:	f7 24 24             	mull   (%esp)
  802ca9:	89 c6                	mov    %eax,%esi
  802cab:	89 d1                	mov    %edx,%ecx
  802cad:	39 d3                	cmp    %edx,%ebx
  802caf:	0f 82 87 00 00 00    	jb     802d3c <__umoddi3+0x134>
  802cb5:	0f 84 91 00 00 00    	je     802d4c <__umoddi3+0x144>
  802cbb:	8b 54 24 04          	mov    0x4(%esp),%edx
  802cbf:	29 f2                	sub    %esi,%edx
  802cc1:	19 cb                	sbb    %ecx,%ebx
  802cc3:	89 d8                	mov    %ebx,%eax
  802cc5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802cc9:	d3 e0                	shl    %cl,%eax
  802ccb:	89 e9                	mov    %ebp,%ecx
  802ccd:	d3 ea                	shr    %cl,%edx
  802ccf:	09 d0                	or     %edx,%eax
  802cd1:	89 e9                	mov    %ebp,%ecx
  802cd3:	d3 eb                	shr    %cl,%ebx
  802cd5:	89 da                	mov    %ebx,%edx
  802cd7:	83 c4 1c             	add    $0x1c,%esp
  802cda:	5b                   	pop    %ebx
  802cdb:	5e                   	pop    %esi
  802cdc:	5f                   	pop    %edi
  802cdd:	5d                   	pop    %ebp
  802cde:	c3                   	ret    
  802cdf:	90                   	nop
  802ce0:	89 fd                	mov    %edi,%ebp
  802ce2:	85 ff                	test   %edi,%edi
  802ce4:	75 0b                	jne    802cf1 <__umoddi3+0xe9>
  802ce6:	b8 01 00 00 00       	mov    $0x1,%eax
  802ceb:	31 d2                	xor    %edx,%edx
  802ced:	f7 f7                	div    %edi
  802cef:	89 c5                	mov    %eax,%ebp
  802cf1:	89 f0                	mov    %esi,%eax
  802cf3:	31 d2                	xor    %edx,%edx
  802cf5:	f7 f5                	div    %ebp
  802cf7:	89 c8                	mov    %ecx,%eax
  802cf9:	f7 f5                	div    %ebp
  802cfb:	89 d0                	mov    %edx,%eax
  802cfd:	e9 44 ff ff ff       	jmp    802c46 <__umoddi3+0x3e>
  802d02:	66 90                	xchg   %ax,%ax
  802d04:	89 c8                	mov    %ecx,%eax
  802d06:	89 f2                	mov    %esi,%edx
  802d08:	83 c4 1c             	add    $0x1c,%esp
  802d0b:	5b                   	pop    %ebx
  802d0c:	5e                   	pop    %esi
  802d0d:	5f                   	pop    %edi
  802d0e:	5d                   	pop    %ebp
  802d0f:	c3                   	ret    
  802d10:	3b 04 24             	cmp    (%esp),%eax
  802d13:	72 06                	jb     802d1b <__umoddi3+0x113>
  802d15:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802d19:	77 0f                	ja     802d2a <__umoddi3+0x122>
  802d1b:	89 f2                	mov    %esi,%edx
  802d1d:	29 f9                	sub    %edi,%ecx
  802d1f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802d23:	89 14 24             	mov    %edx,(%esp)
  802d26:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802d2a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802d2e:	8b 14 24             	mov    (%esp),%edx
  802d31:	83 c4 1c             	add    $0x1c,%esp
  802d34:	5b                   	pop    %ebx
  802d35:	5e                   	pop    %esi
  802d36:	5f                   	pop    %edi
  802d37:	5d                   	pop    %ebp
  802d38:	c3                   	ret    
  802d39:	8d 76 00             	lea    0x0(%esi),%esi
  802d3c:	2b 04 24             	sub    (%esp),%eax
  802d3f:	19 fa                	sbb    %edi,%edx
  802d41:	89 d1                	mov    %edx,%ecx
  802d43:	89 c6                	mov    %eax,%esi
  802d45:	e9 71 ff ff ff       	jmp    802cbb <__umoddi3+0xb3>
  802d4a:	66 90                	xchg   %ax,%ax
  802d4c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802d50:	72 ea                	jb     802d3c <__umoddi3+0x134>
  802d52:	89 d9                	mov    %ebx,%ecx
  802d54:	e9 62 ff ff ff       	jmp    802cbb <__umoddi3+0xb3>
