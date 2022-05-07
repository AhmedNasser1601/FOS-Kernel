
obj/user/tst_first_fit_3:     file format elf32-i386


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
  800031:	e8 9a 0d 00 00       	call   800dd0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

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
  800045:	e8 db 26 00 00       	call   802725 <sys_set_uheap_strategy>
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
  80005a:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800083:	a1 20 40 80 00       	mov    0x804020,%eax
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
  80009b:	68 c0 29 80 00       	push   $0x8029c0
  8000a0:	6a 16                	push   $0x16
  8000a2:	68 dc 29 80 00       	push   $0x8029dc
  8000a7:	e8 33 0e 00 00       	call   800edf <_panic>
	}

	int envID = sys_getenvid();
  8000ac:	e8 fd 20 00 00       	call   8021ae <sys_getenvid>
  8000b1:	89 45 ec             	mov    %eax,-0x14(%ebp)



	int Mega = 1024*1024;
  8000b4:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  8000bb:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	void* ptr_allocations[20] = {0};
  8000c2:	8d 55 8c             	lea    -0x74(%ebp),%edx
  8000c5:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8000cf:	89 d7                	mov    %edx,%edi
  8000d1:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate Shared 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000d3:	e8 ba 21 00 00       	call   802292 <sys_calculate_free_frames>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000db:	e8 35 22 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8000e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = smalloc("x", 1*Mega, 1);
  8000e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	6a 01                	push   $0x1
  8000eb:	50                   	push   %eax
  8000ec:	68 f3 29 80 00       	push   $0x8029f3
  8000f1:	e8 a5 1f 00 00       	call   80209b <smalloc>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if (ptr_allocations[0] != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000fc:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8000ff:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800104:	74 14                	je     80011a <_main+0xe2>
  800106:	83 ec 04             	sub    $0x4,%esp
  800109:	68 f8 29 80 00       	push   $0x8029f8
  80010e:	6a 28                	push   $0x28
  800110:	68 dc 29 80 00       	push   $0x8029dc
  800115:	e8 c5 0d 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  256+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80011a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80011d:	e8 70 21 00 00       	call   802292 <sys_calculate_free_frames>
  800122:	29 c3                	sub    %eax,%ebx
  800124:	89 d8                	mov    %ebx,%eax
  800126:	3d 03 01 00 00       	cmp    $0x103,%eax
  80012b:	74 14                	je     800141 <_main+0x109>
  80012d:	83 ec 04             	sub    $0x4,%esp
  800130:	68 64 2a 80 00       	push   $0x802a64
  800135:	6a 29                	push   $0x29
  800137:	68 dc 29 80 00       	push   $0x8029dc
  80013c:	e8 9e 0d 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800141:	e8 cf 21 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800146:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800149:	74 14                	je     80015f <_main+0x127>
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	68 e2 2a 80 00       	push   $0x802ae2
  800153:	6a 2a                	push   $0x2a
  800155:	68 dc 29 80 00       	push   $0x8029dc
  80015a:	e8 80 0d 00 00       	call   800edf <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80015f:	e8 2e 21 00 00       	call   802292 <sys_calculate_free_frames>
  800164:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800167:	e8 a9 21 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80016c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  80016f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800172:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	50                   	push   %eax
  800179:	e8 9f 1d 00 00       	call   801f1d <malloc>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  800184:	8b 45 90             	mov    -0x70(%ebp),%eax
  800187:	89 c2                	mov    %eax,%edx
  800189:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80018c:	05 00 00 00 80       	add    $0x80000000,%eax
  800191:	39 c2                	cmp    %eax,%edx
  800193:	74 14                	je     8001a9 <_main+0x171>
  800195:	83 ec 04             	sub    $0x4,%esp
  800198:	68 00 2b 80 00       	push   $0x802b00
  80019d:	6a 30                	push   $0x30
  80019f:	68 dc 29 80 00       	push   $0x8029dc
  8001a4:	e8 36 0d 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a9:	e8 67 21 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8001ae:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 e2 2a 80 00       	push   $0x802ae2
  8001c0:	6a 32                	push   $0x32
  8001c2:	68 dc 29 80 00       	push   $0x8029dc
  8001c7:	e8 13 0d 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001cc:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8001cf:	e8 be 20 00 00       	call   802292 <sys_calculate_free_frames>
  8001d4:	29 c3                	sub    %eax,%ebx
  8001d6:	89 d8                	mov    %ebx,%eax
  8001d8:	83 f8 01             	cmp    $0x1,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 30 2b 80 00       	push   $0x802b30
  8001e5:	6a 33                	push   $0x33
  8001e7:	68 dc 29 80 00       	push   $0x8029dc
  8001ec:	e8 ee 0c 00 00       	call   800edf <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001f1:	e8 9c 20 00 00       	call   802292 <sys_calculate_free_frames>
  8001f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001f9:	e8 17 21 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8001fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800201:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800204:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800207:	83 ec 0c             	sub    $0xc,%esp
  80020a:	50                   	push   %eax
  80020b:	e8 0d 1d 00 00       	call   801f1d <malloc>
  800210:	83 c4 10             	add    $0x10,%esp
  800213:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800216:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800219:	89 c2                	mov    %eax,%edx
  80021b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80021e:	01 c0                	add    %eax,%eax
  800220:	05 00 00 00 80       	add    $0x80000000,%eax
  800225:	39 c2                	cmp    %eax,%edx
  800227:	74 14                	je     80023d <_main+0x205>
  800229:	83 ec 04             	sub    $0x4,%esp
  80022c:	68 00 2b 80 00       	push   $0x802b00
  800231:	6a 39                	push   $0x39
  800233:	68 dc 29 80 00       	push   $0x8029dc
  800238:	e8 a2 0c 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80023d:	e8 d3 20 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800242:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800245:	3d 00 01 00 00       	cmp    $0x100,%eax
  80024a:	74 14                	je     800260 <_main+0x228>
  80024c:	83 ec 04             	sub    $0x4,%esp
  80024f:	68 e2 2a 80 00       	push   $0x802ae2
  800254:	6a 3b                	push   $0x3b
  800256:	68 dc 29 80 00       	push   $0x8029dc
  80025b:	e8 7f 0c 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800260:	e8 2d 20 00 00       	call   802292 <sys_calculate_free_frames>
  800265:	89 c2                	mov    %eax,%edx
  800267:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80026a:	39 c2                	cmp    %eax,%edx
  80026c:	74 14                	je     800282 <_main+0x24a>
  80026e:	83 ec 04             	sub    $0x4,%esp
  800271:	68 30 2b 80 00       	push   $0x802b30
  800276:	6a 3c                	push   $0x3c
  800278:	68 dc 29 80 00       	push   $0x8029dc
  80027d:	e8 5d 0c 00 00       	call   800edf <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800282:	e8 0b 20 00 00       	call   802292 <sys_calculate_free_frames>
  800287:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80028a:	e8 86 20 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80028f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800292:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800295:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	50                   	push   %eax
  80029c:	e8 7c 1c 00 00       	call   801f1d <malloc>
  8002a1:	83 c4 10             	add    $0x10,%esp
  8002a4:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  8002a7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002aa:	89 c1                	mov    %eax,%ecx
  8002ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002af:	89 c2                	mov    %eax,%edx
  8002b1:	01 d2                	add    %edx,%edx
  8002b3:	01 d0                	add    %edx,%eax
  8002b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ba:	39 c1                	cmp    %eax,%ecx
  8002bc:	74 14                	je     8002d2 <_main+0x29a>
  8002be:	83 ec 04             	sub    $0x4,%esp
  8002c1:	68 00 2b 80 00       	push   $0x802b00
  8002c6:	6a 42                	push   $0x42
  8002c8:	68 dc 29 80 00       	push   $0x8029dc
  8002cd:	e8 0d 0c 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002d2:	e8 3e 20 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8002d7:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002da:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002df:	74 14                	je     8002f5 <_main+0x2bd>
  8002e1:	83 ec 04             	sub    $0x4,%esp
  8002e4:	68 e2 2a 80 00       	push   $0x802ae2
  8002e9:	6a 44                	push   $0x44
  8002eb:	68 dc 29 80 00       	push   $0x8029dc
  8002f0:	e8 ea 0b 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002f5:	e8 98 1f 00 00       	call   802292 <sys_calculate_free_frames>
  8002fa:	89 c2                	mov    %eax,%edx
  8002fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ff:	39 c2                	cmp    %eax,%edx
  800301:	74 14                	je     800317 <_main+0x2df>
  800303:	83 ec 04             	sub    $0x4,%esp
  800306:	68 30 2b 80 00       	push   $0x802b30
  80030b:	6a 45                	push   $0x45
  80030d:	68 dc 29 80 00       	push   $0x8029dc
  800312:	e8 c8 0b 00 00       	call   800edf <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800317:	e8 76 1f 00 00       	call   802292 <sys_calculate_free_frames>
  80031c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80031f:	e8 f1 1f 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800324:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  800327:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032a:	01 c0                	add    %eax,%eax
  80032c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	50                   	push   %eax
  800333:	e8 e5 1b 00 00       	call   801f1d <malloc>
  800338:	83 c4 10             	add    $0x10,%esp
  80033b:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  80033e:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800341:	89 c2                	mov    %eax,%edx
  800343:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800346:	c1 e0 02             	shl    $0x2,%eax
  800349:	05 00 00 00 80       	add    $0x80000000,%eax
  80034e:	39 c2                	cmp    %eax,%edx
  800350:	74 14                	je     800366 <_main+0x32e>
  800352:	83 ec 04             	sub    $0x4,%esp
  800355:	68 00 2b 80 00       	push   $0x802b00
  80035a:	6a 4b                	push   $0x4b
  80035c:	68 dc 29 80 00       	push   $0x8029dc
  800361:	e8 79 0b 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800366:	e8 aa 1f 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80036b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80036e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800373:	74 14                	je     800389 <_main+0x351>
  800375:	83 ec 04             	sub    $0x4,%esp
  800378:	68 e2 2a 80 00       	push   $0x802ae2
  80037d:	6a 4d                	push   $0x4d
  80037f:	68 dc 29 80 00       	push   $0x8029dc
  800384:	e8 56 0b 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800389:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80038c:	e8 01 1f 00 00       	call   802292 <sys_calculate_free_frames>
  800391:	29 c3                	sub    %eax,%ebx
  800393:	89 d8                	mov    %ebx,%eax
  800395:	83 f8 01             	cmp    $0x1,%eax
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 30 2b 80 00       	push   $0x802b30
  8003a2:	6a 4e                	push   $0x4e
  8003a4:	68 dc 29 80 00       	push   $0x8029dc
  8003a9:	e8 31 0b 00 00       	call   800edf <_panic>

		//Allocate Shared 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003ae:	e8 df 1e 00 00       	call   802292 <sys_calculate_free_frames>
  8003b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003b6:	e8 5a 1f 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8003bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = smalloc("y", 2*Mega, 1);
  8003be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003c1:	01 c0                	add    %eax,%eax
  8003c3:	83 ec 04             	sub    $0x4,%esp
  8003c6:	6a 01                	push   $0x1
  8003c8:	50                   	push   %eax
  8003c9:	68 43 2b 80 00       	push   $0x802b43
  8003ce:	e8 c8 1c 00 00       	call   80209b <smalloc>
  8003d3:	83 c4 10             	add    $0x10,%esp
  8003d6:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if (ptr_allocations[5] != (uint32*)(USER_HEAP_START + 6*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8003d9:	8b 4d a0             	mov    -0x60(%ebp),%ecx
  8003dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003df:	89 d0                	mov    %edx,%eax
  8003e1:	01 c0                	add    %eax,%eax
  8003e3:	01 d0                	add    %edx,%eax
  8003e5:	01 c0                	add    %eax,%eax
  8003e7:	05 00 00 00 80       	add    $0x80000000,%eax
  8003ec:	39 c1                	cmp    %eax,%ecx
  8003ee:	74 14                	je     800404 <_main+0x3cc>
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 f8 29 80 00       	push   $0x8029f8
  8003f8:	6a 54                	push   $0x54
  8003fa:	68 dc 29 80 00       	push   $0x8029dc
  8003ff:	e8 db 0a 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  512+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800404:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800407:	e8 86 1e 00 00       	call   802292 <sys_calculate_free_frames>
  80040c:	29 c3                	sub    %eax,%ebx
  80040e:	89 d8                	mov    %ebx,%eax
  800410:	3d 03 02 00 00       	cmp    $0x203,%eax
  800415:	74 14                	je     80042b <_main+0x3f3>
  800417:	83 ec 04             	sub    $0x4,%esp
  80041a:	68 64 2a 80 00       	push   $0x802a64
  80041f:	6a 55                	push   $0x55
  800421:	68 dc 29 80 00       	push   $0x8029dc
  800426:	e8 b4 0a 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  80042b:	e8 e5 1e 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800430:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800433:	74 14                	je     800449 <_main+0x411>
  800435:	83 ec 04             	sub    $0x4,%esp
  800438:	68 e2 2a 80 00       	push   $0x802ae2
  80043d:	6a 56                	push   $0x56
  80043f:	68 dc 29 80 00       	push   $0x8029dc
  800444:	e8 96 0a 00 00       	call   800edf <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800449:	e8 44 1e 00 00       	call   802292 <sys_calculate_free_frames>
  80044e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800451:	e8 bf 1e 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800456:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  800459:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80045c:	89 c2                	mov    %eax,%edx
  80045e:	01 d2                	add    %edx,%edx
  800460:	01 d0                	add    %edx,%eax
  800462:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800465:	83 ec 0c             	sub    $0xc,%esp
  800468:	50                   	push   %eax
  800469:	e8 af 1a 00 00       	call   801f1d <malloc>
  80046e:	83 c4 10             	add    $0x10,%esp
  800471:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800474:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800477:	89 c2                	mov    %eax,%edx
  800479:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80047c:	c1 e0 03             	shl    $0x3,%eax
  80047f:	05 00 00 00 80       	add    $0x80000000,%eax
  800484:	39 c2                	cmp    %eax,%edx
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 00 2b 80 00       	push   $0x802b00
  800490:	6a 5c                	push   $0x5c
  800492:	68 dc 29 80 00       	push   $0x8029dc
  800497:	e8 43 0a 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80049c:	e8 74 1e 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8004a1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8004a4:	3d 00 03 00 00       	cmp    $0x300,%eax
  8004a9:	74 14                	je     8004bf <_main+0x487>
  8004ab:	83 ec 04             	sub    $0x4,%esp
  8004ae:	68 e2 2a 80 00       	push   $0x802ae2
  8004b3:	6a 5e                	push   $0x5e
  8004b5:	68 dc 29 80 00       	push   $0x8029dc
  8004ba:	e8 20 0a 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004bf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8004c2:	e8 cb 1d 00 00       	call   802292 <sys_calculate_free_frames>
  8004c7:	29 c3                	sub    %eax,%ebx
  8004c9:	89 d8                	mov    %ebx,%eax
  8004cb:	83 f8 01             	cmp    $0x1,%eax
  8004ce:	74 14                	je     8004e4 <_main+0x4ac>
  8004d0:	83 ec 04             	sub    $0x4,%esp
  8004d3:	68 30 2b 80 00       	push   $0x802b30
  8004d8:	6a 5f                	push   $0x5f
  8004da:	68 dc 29 80 00       	push   $0x8029dc
  8004df:	e8 fb 09 00 00       	call   800edf <_panic>

		//Allocate Shared 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004e4:	e8 a9 1d 00 00       	call   802292 <sys_calculate_free_frames>
  8004e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004ec:	e8 24 1e 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8004f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = smalloc("z", 3*Mega, 0);
  8004f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004f7:	89 c2                	mov    %eax,%edx
  8004f9:	01 d2                	add    %edx,%edx
  8004fb:	01 d0                	add    %edx,%eax
  8004fd:	83 ec 04             	sub    $0x4,%esp
  800500:	6a 00                	push   $0x0
  800502:	50                   	push   %eax
  800503:	68 45 2b 80 00       	push   $0x802b45
  800508:	e8 8e 1b 00 00       	call   80209b <smalloc>
  80050d:	83 c4 10             	add    $0x10,%esp
  800510:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if (ptr_allocations[7] != (uint32*)(USER_HEAP_START + 11*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800513:	8b 4d a8             	mov    -0x58(%ebp),%ecx
  800516:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800519:	89 d0                	mov    %edx,%eax
  80051b:	c1 e0 02             	shl    $0x2,%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	01 c0                	add    %eax,%eax
  800522:	01 d0                	add    %edx,%eax
  800524:	05 00 00 00 80       	add    $0x80000000,%eax
  800529:	39 c1                	cmp    %eax,%ecx
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 f8 29 80 00       	push   $0x8029f8
  800535:	6a 65                	push   $0x65
  800537:	68 dc 29 80 00       	push   $0x8029dc
  80053c:	e8 9e 09 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  768+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800541:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800544:	e8 49 1d 00 00       	call   802292 <sys_calculate_free_frames>
  800549:	29 c3                	sub    %eax,%ebx
  80054b:	89 d8                	mov    %ebx,%eax
  80054d:	3d 04 03 00 00       	cmp    $0x304,%eax
  800552:	74 14                	je     800568 <_main+0x530>
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 64 2a 80 00       	push   $0x802a64
  80055c:	6a 66                	push   $0x66
  80055e:	68 dc 29 80 00       	push   $0x8029dc
  800563:	e8 77 09 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800568:	e8 a8 1d 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80056d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800570:	74 14                	je     800586 <_main+0x54e>
  800572:	83 ec 04             	sub    $0x4,%esp
  800575:	68 e2 2a 80 00       	push   $0x802ae2
  80057a:	6a 67                	push   $0x67
  80057c:	68 dc 29 80 00       	push   $0x8029dc
  800581:	e8 59 09 00 00       	call   800edf <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800586:	e8 07 1d 00 00       	call   802292 <sys_calculate_free_frames>
  80058b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80058e:	e8 82 1d 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800593:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[1]);
  800596:	8b 45 90             	mov    -0x70(%ebp),%eax
  800599:	83 ec 0c             	sub    $0xc,%esp
  80059c:	50                   	push   %eax
  80059d:	e8 33 1b 00 00       	call   8020d5 <free>
  8005a2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8005a5:	e8 6b 1d 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8005aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005ad:	29 c2                	sub    %eax,%edx
  8005af:	89 d0                	mov    %edx,%eax
  8005b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005b6:	74 14                	je     8005cc <_main+0x594>
  8005b8:	83 ec 04             	sub    $0x4,%esp
  8005bb:	68 47 2b 80 00       	push   $0x802b47
  8005c0:	6a 71                	push   $0x71
  8005c2:	68 dc 29 80 00       	push   $0x8029dc
  8005c7:	e8 13 09 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005cc:	e8 c1 1c 00 00       	call   802292 <sys_calculate_free_frames>
  8005d1:	89 c2                	mov    %eax,%edx
  8005d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d6:	39 c2                	cmp    %eax,%edx
  8005d8:	74 14                	je     8005ee <_main+0x5b6>
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	68 5e 2b 80 00       	push   $0x802b5e
  8005e2:	6a 72                	push   $0x72
  8005e4:	68 dc 29 80 00       	push   $0x8029dc
  8005e9:	e8 f1 08 00 00       	call   800edf <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005ee:	e8 9f 1c 00 00       	call   802292 <sys_calculate_free_frames>
  8005f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005f6:	e8 1a 1d 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8005fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[4]);
  8005fe:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800601:	83 ec 0c             	sub    $0xc,%esp
  800604:	50                   	push   %eax
  800605:	e8 cb 1a 00 00       	call   8020d5 <free>
  80060a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  80060d:	e8 03 1d 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800612:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800615:	29 c2                	sub    %eax,%edx
  800617:	89 d0                	mov    %edx,%eax
  800619:	3d 00 02 00 00       	cmp    $0x200,%eax
  80061e:	74 14                	je     800634 <_main+0x5fc>
  800620:	83 ec 04             	sub    $0x4,%esp
  800623:	68 47 2b 80 00       	push   $0x802b47
  800628:	6a 79                	push   $0x79
  80062a:	68 dc 29 80 00       	push   $0x8029dc
  80062f:	e8 ab 08 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800634:	e8 59 1c 00 00       	call   802292 <sys_calculate_free_frames>
  800639:	89 c2                	mov    %eax,%edx
  80063b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063e:	39 c2                	cmp    %eax,%edx
  800640:	74 14                	je     800656 <_main+0x61e>
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	68 5e 2b 80 00       	push   $0x802b5e
  80064a:	6a 7a                	push   $0x7a
  80064c:	68 dc 29 80 00       	push   $0x8029dc
  800651:	e8 89 08 00 00       	call   800edf <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800656:	e8 37 1c 00 00       	call   802292 <sys_calculate_free_frames>
  80065b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80065e:	e8 b2 1c 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800663:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  800666:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800669:	83 ec 0c             	sub    $0xc,%esp
  80066c:	50                   	push   %eax
  80066d:	e8 63 1a 00 00       	call   8020d5 <free>
  800672:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800675:	e8 9b 1c 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80067a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80067d:	29 c2                	sub    %eax,%edx
  80067f:	89 d0                	mov    %edx,%eax
  800681:	3d 00 03 00 00       	cmp    $0x300,%eax
  800686:	74 17                	je     80069f <_main+0x667>
  800688:	83 ec 04             	sub    $0x4,%esp
  80068b:	68 47 2b 80 00       	push   $0x802b47
  800690:	68 81 00 00 00       	push   $0x81
  800695:	68 dc 29 80 00       	push   $0x8029dc
  80069a:	e8 40 08 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80069f:	e8 ee 1b 00 00       	call   802292 <sys_calculate_free_frames>
  8006a4:	89 c2                	mov    %eax,%edx
  8006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a9:	39 c2                	cmp    %eax,%edx
  8006ab:	74 17                	je     8006c4 <_main+0x68c>
  8006ad:	83 ec 04             	sub    $0x4,%esp
  8006b0:	68 5e 2b 80 00       	push   $0x802b5e
  8006b5:	68 82 00 00 00       	push   $0x82
  8006ba:	68 dc 29 80 00       	push   $0x8029dc
  8006bf:	e8 1b 08 00 00       	call   800edf <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006c4:	e8 c9 1b 00 00       	call   802292 <sys_calculate_free_frames>
  8006c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006cc:	e8 44 1c 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8006d1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006d7:	89 d0                	mov    %edx,%eax
  8006d9:	c1 e0 09             	shl    $0x9,%eax
  8006dc:	29 d0                	sub    %edx,%eax
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	50                   	push   %eax
  8006e2:	e8 36 18 00 00       	call   801f1d <malloc>
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006ed:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8006f0:	89 c2                	mov    %eax,%edx
  8006f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8006fa:	39 c2                	cmp    %eax,%edx
  8006fc:	74 17                	je     800715 <_main+0x6dd>
  8006fe:	83 ec 04             	sub    $0x4,%esp
  800701:	68 00 2b 80 00       	push   $0x802b00
  800706:	68 8b 00 00 00       	push   $0x8b
  80070b:	68 dc 29 80 00       	push   $0x8029dc
  800710:	e8 ca 07 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800715:	e8 fb 1b 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80071a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80071d:	3d 80 00 00 00       	cmp    $0x80,%eax
  800722:	74 17                	je     80073b <_main+0x703>
  800724:	83 ec 04             	sub    $0x4,%esp
  800727:	68 e2 2a 80 00       	push   $0x802ae2
  80072c:	68 8d 00 00 00       	push   $0x8d
  800731:	68 dc 29 80 00       	push   $0x8029dc
  800736:	e8 a4 07 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80073b:	e8 52 1b 00 00       	call   802292 <sys_calculate_free_frames>
  800740:	89 c2                	mov    %eax,%edx
  800742:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800745:	39 c2                	cmp    %eax,%edx
  800747:	74 17                	je     800760 <_main+0x728>
  800749:	83 ec 04             	sub    $0x4,%esp
  80074c:	68 30 2b 80 00       	push   $0x802b30
  800751:	68 8e 00 00 00       	push   $0x8e
  800756:	68 dc 29 80 00       	push   $0x8029dc
  80075b:	e8 7f 07 00 00       	call   800edf <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800760:	e8 2d 1b 00 00       	call   802292 <sys_calculate_free_frames>
  800765:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800768:	e8 a8 1b 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80076d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800770:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800773:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800776:	83 ec 0c             	sub    $0xc,%esp
  800779:	50                   	push   %eax
  80077a:	e8 9e 17 00 00       	call   801f1d <malloc>
  80077f:	83 c4 10             	add    $0x10,%esp
  800782:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800785:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800788:	89 c2                	mov    %eax,%edx
  80078a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80078d:	c1 e0 02             	shl    $0x2,%eax
  800790:	05 00 00 00 80       	add    $0x80000000,%eax
  800795:	39 c2                	cmp    %eax,%edx
  800797:	74 17                	je     8007b0 <_main+0x778>
  800799:	83 ec 04             	sub    $0x4,%esp
  80079c:	68 00 2b 80 00       	push   $0x802b00
  8007a1:	68 94 00 00 00       	push   $0x94
  8007a6:	68 dc 29 80 00       	push   $0x8029dc
  8007ab:	e8 2f 07 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007b0:	e8 60 1b 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8007b5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8007b8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007bd:	74 17                	je     8007d6 <_main+0x79e>
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	68 e2 2a 80 00       	push   $0x802ae2
  8007c7:	68 96 00 00 00       	push   $0x96
  8007cc:	68 dc 29 80 00       	push   $0x8029dc
  8007d1:	e8 09 07 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007d6:	e8 b7 1a 00 00       	call   802292 <sys_calculate_free_frames>
  8007db:	89 c2                	mov    %eax,%edx
  8007dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 30 2b 80 00       	push   $0x802b30
  8007ec:	68 97 00 00 00       	push   $0x97
  8007f1:	68 dc 29 80 00       	push   $0x8029dc
  8007f6:	e8 e4 06 00 00       	call   800edf <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007fb:	e8 92 1a 00 00       	call   802292 <sys_calculate_free_frames>
  800800:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800803:	e8 0d 1b 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800808:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  80080b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80080e:	89 d0                	mov    %edx,%eax
  800810:	c1 e0 08             	shl    $0x8,%eax
  800813:	29 d0                	sub    %edx,%eax
  800815:	83 ec 0c             	sub    $0xc,%esp
  800818:	50                   	push   %eax
  800819:	e8 ff 16 00 00       	call   801f1d <malloc>
  80081e:	83 c4 10             	add    $0x10,%esp
  800821:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800824:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800827:	89 c2                	mov    %eax,%edx
  800829:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80082c:	c1 e0 09             	shl    $0x9,%eax
  80082f:	89 c1                	mov    %eax,%ecx
  800831:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800834:	01 c8                	add    %ecx,%eax
  800836:	05 00 00 00 80       	add    $0x80000000,%eax
  80083b:	39 c2                	cmp    %eax,%edx
  80083d:	74 17                	je     800856 <_main+0x81e>
  80083f:	83 ec 04             	sub    $0x4,%esp
  800842:	68 00 2b 80 00       	push   $0x802b00
  800847:	68 9d 00 00 00       	push   $0x9d
  80084c:	68 dc 29 80 00       	push   $0x8029dc
  800851:	e8 89 06 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800856:	e8 ba 1a 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80085b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80085e:	83 f8 40             	cmp    $0x40,%eax
  800861:	74 17                	je     80087a <_main+0x842>
  800863:	83 ec 04             	sub    $0x4,%esp
  800866:	68 e2 2a 80 00       	push   $0x802ae2
  80086b:	68 9f 00 00 00       	push   $0x9f
  800870:	68 dc 29 80 00       	push   $0x8029dc
  800875:	e8 65 06 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80087a:	e8 13 1a 00 00       	call   802292 <sys_calculate_free_frames>
  80087f:	89 c2                	mov    %eax,%edx
  800881:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800884:	39 c2                	cmp    %eax,%edx
  800886:	74 17                	je     80089f <_main+0x867>
  800888:	83 ec 04             	sub    $0x4,%esp
  80088b:	68 30 2b 80 00       	push   $0x802b30
  800890:	68 a0 00 00 00       	push   $0xa0
  800895:	68 dc 29 80 00       	push   $0x8029dc
  80089a:	e8 40 06 00 00       	call   800edf <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80089f:	e8 ee 19 00 00       	call   802292 <sys_calculate_free_frames>
  8008a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008a7:	e8 69 1a 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8008ac:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  8008af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008b2:	01 c0                	add    %eax,%eax
  8008b4:	83 ec 0c             	sub    $0xc,%esp
  8008b7:	50                   	push   %eax
  8008b8:	e8 60 16 00 00       	call   801f1d <malloc>
  8008bd:	83 c4 10             	add    $0x10,%esp
  8008c0:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008c3:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008c6:	89 c2                	mov    %eax,%edx
  8008c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008cb:	c1 e0 03             	shl    $0x3,%eax
  8008ce:	05 00 00 00 80       	add    $0x80000000,%eax
  8008d3:	39 c2                	cmp    %eax,%edx
  8008d5:	74 17                	je     8008ee <_main+0x8b6>
  8008d7:	83 ec 04             	sub    $0x4,%esp
  8008da:	68 00 2b 80 00       	push   $0x802b00
  8008df:	68 a6 00 00 00       	push   $0xa6
  8008e4:	68 dc 29 80 00       	push   $0x8029dc
  8008e9:	e8 f1 05 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008ee:	e8 22 1a 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8008f3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008f6:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008fb:	74 17                	je     800914 <_main+0x8dc>
  8008fd:	83 ec 04             	sub    $0x4,%esp
  800900:	68 e2 2a 80 00       	push   $0x802ae2
  800905:	68 a8 00 00 00       	push   $0xa8
  80090a:	68 dc 29 80 00       	push   $0x8029dc
  80090f:	e8 cb 05 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800914:	e8 79 19 00 00       	call   802292 <sys_calculate_free_frames>
  800919:	89 c2                	mov    %eax,%edx
  80091b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091e:	39 c2                	cmp    %eax,%edx
  800920:	74 17                	je     800939 <_main+0x901>
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	68 30 2b 80 00       	push   $0x802b30
  80092a:	68 a9 00 00 00       	push   $0xa9
  80092f:	68 dc 29 80 00       	push   $0x8029dc
  800934:	e8 a6 05 00 00       	call   800edf <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800939:	e8 54 19 00 00       	call   802292 <sys_calculate_free_frames>
  80093e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800941:	e8 cf 19 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800946:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800949:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80094c:	c1 e0 02             	shl    $0x2,%eax
  80094f:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800952:	83 ec 0c             	sub    $0xc,%esp
  800955:	50                   	push   %eax
  800956:	e8 c2 15 00 00       	call   801f1d <malloc>
  80095b:	83 c4 10             	add    $0x10,%esp
  80095e:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  800961:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800964:	89 c1                	mov    %eax,%ecx
  800966:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800969:	89 d0                	mov    %edx,%eax
  80096b:	01 c0                	add    %eax,%eax
  80096d:	01 d0                	add    %edx,%eax
  80096f:	01 c0                	add    %eax,%eax
  800971:	01 d0                	add    %edx,%eax
  800973:	01 c0                	add    %eax,%eax
  800975:	05 00 00 00 80       	add    $0x80000000,%eax
  80097a:	39 c1                	cmp    %eax,%ecx
  80097c:	74 17                	je     800995 <_main+0x95d>
  80097e:	83 ec 04             	sub    $0x4,%esp
  800981:	68 00 2b 80 00       	push   $0x802b00
  800986:	68 af 00 00 00       	push   $0xaf
  80098b:	68 dc 29 80 00       	push   $0x8029dc
  800990:	e8 4a 05 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800995:	e8 7b 19 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  80099a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80099d:	3d 00 04 00 00       	cmp    $0x400,%eax
  8009a2:	74 17                	je     8009bb <_main+0x983>
  8009a4:	83 ec 04             	sub    $0x4,%esp
  8009a7:	68 e2 2a 80 00       	push   $0x802ae2
  8009ac:	68 b1 00 00 00       	push   $0xb1
  8009b1:	68 dc 29 80 00       	push   $0x8029dc
  8009b6:	e8 24 05 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: ");
  8009bb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8009be:	e8 cf 18 00 00       	call   802292 <sys_calculate_free_frames>
  8009c3:	29 c3                	sub    %eax,%ebx
  8009c5:	89 d8                	mov    %ebx,%eax
  8009c7:	83 f8 02             	cmp    $0x2,%eax
  8009ca:	74 17                	je     8009e3 <_main+0x9ab>
  8009cc:	83 ec 04             	sub    $0x4,%esp
  8009cf:	68 30 2b 80 00       	push   $0x802b30
  8009d4:	68 b2 00 00 00       	push   $0xb2
  8009d9:	68 dc 29 80 00       	push   $0x8029dc
  8009de:	e8 fc 04 00 00       	call   800edf <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009e3:	e8 aa 18 00 00       	call   802292 <sys_calculate_free_frames>
  8009e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009eb:	e8 25 19 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  8009f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[2]);
  8009f3:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8009f6:	83 ec 0c             	sub    $0xc,%esp
  8009f9:	50                   	push   %eax
  8009fa:	e8 d6 16 00 00       	call   8020d5 <free>
  8009ff:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a02:	e8 0e 19 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800a07:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a0a:	29 c2                	sub    %eax,%edx
  800a0c:	89 d0                	mov    %edx,%eax
  800a0e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a13:	74 17                	je     800a2c <_main+0x9f4>
  800a15:	83 ec 04             	sub    $0x4,%esp
  800a18:	68 47 2b 80 00       	push   $0x802b47
  800a1d:	68 bc 00 00 00       	push   $0xbc
  800a22:	68 dc 29 80 00       	push   $0x8029dc
  800a27:	e8 b3 04 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a2c:	e8 61 18 00 00       	call   802292 <sys_calculate_free_frames>
  800a31:	89 c2                	mov    %eax,%edx
  800a33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a36:	39 c2                	cmp    %eax,%edx
  800a38:	74 17                	je     800a51 <_main+0xa19>
  800a3a:	83 ec 04             	sub    $0x4,%esp
  800a3d:	68 5e 2b 80 00       	push   $0x802b5e
  800a42:	68 bd 00 00 00       	push   $0xbd
  800a47:	68 dc 29 80 00       	push   $0x8029dc
  800a4c:	e8 8e 04 00 00       	call   800edf <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a51:	e8 3c 18 00 00       	call   802292 <sys_calculate_free_frames>
  800a56:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a59:	e8 b7 18 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800a5e:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[9]);
  800a61:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a64:	83 ec 0c             	sub    $0xc,%esp
  800a67:	50                   	push   %eax
  800a68:	e8 68 16 00 00       	call   8020d5 <free>
  800a6d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a70:	e8 a0 18 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800a75:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a78:	29 c2                	sub    %eax,%edx
  800a7a:	89 d0                	mov    %edx,%eax
  800a7c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a81:	74 17                	je     800a9a <_main+0xa62>
  800a83:	83 ec 04             	sub    $0x4,%esp
  800a86:	68 47 2b 80 00       	push   $0x802b47
  800a8b:	68 c4 00 00 00       	push   $0xc4
  800a90:	68 dc 29 80 00       	push   $0x8029dc
  800a95:	e8 45 04 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a9a:	e8 f3 17 00 00       	call   802292 <sys_calculate_free_frames>
  800a9f:	89 c2                	mov    %eax,%edx
  800aa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa4:	39 c2                	cmp    %eax,%edx
  800aa6:	74 17                	je     800abf <_main+0xa87>
  800aa8:	83 ec 04             	sub    $0x4,%esp
  800aab:	68 5e 2b 80 00       	push   $0x802b5e
  800ab0:	68 c5 00 00 00       	push   $0xc5
  800ab5:	68 dc 29 80 00       	push   $0x8029dc
  800aba:	e8 20 04 00 00       	call   800edf <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800abf:	e8 ce 17 00 00       	call   802292 <sys_calculate_free_frames>
  800ac4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ac7:	e8 49 18 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800acc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[3]);
  800acf:	8b 45 98             	mov    -0x68(%ebp),%eax
  800ad2:	83 ec 0c             	sub    $0xc,%esp
  800ad5:	50                   	push   %eax
  800ad6:	e8 fa 15 00 00       	call   8020d5 <free>
  800adb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ade:	e8 32 18 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800ae3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800ae6:	29 c2                	sub    %eax,%edx
  800ae8:	89 d0                	mov    %edx,%eax
  800aea:	3d 00 01 00 00       	cmp    $0x100,%eax
  800aef:	74 17                	je     800b08 <_main+0xad0>
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	68 47 2b 80 00       	push   $0x802b47
  800af9:	68 cc 00 00 00       	push   $0xcc
  800afe:	68 dc 29 80 00       	push   $0x8029dc
  800b03:	e8 d7 03 00 00       	call   800edf <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800b08:	e8 85 17 00 00       	call   802292 <sys_calculate_free_frames>
  800b0d:	89 c2                	mov    %eax,%edx
  800b0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b12:	39 c2                	cmp    %eax,%edx
  800b14:	74 17                	je     800b2d <_main+0xaf5>
  800b16:	83 ec 04             	sub    $0x4,%esp
  800b19:	68 5e 2b 80 00       	push   $0x802b5e
  800b1e:	68 cd 00 00 00       	push   $0xcd
  800b23:	68 dc 29 80 00       	push   $0x8029dc
  800b28:	e8 b2 03 00 00       	call   800edf <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 1 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b2d:	e8 60 17 00 00       	call   802292 <sys_calculate_free_frames>
  800b32:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b35:	e8 db 17 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800b3a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[13] = malloc(1*Mega + 256*kilo - kilo);
  800b3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b40:	c1 e0 08             	shl    $0x8,%eax
  800b43:	89 c2                	mov    %eax,%edx
  800b45:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b48:	01 d0                	add    %edx,%eax
  800b4a:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800b4d:	83 ec 0c             	sub    $0xc,%esp
  800b50:	50                   	push   %eax
  800b51:	e8 c7 13 00 00       	call   801f1d <malloc>
  800b56:	83 c4 10             	add    $0x10,%esp
  800b59:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b5c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b5f:	89 c1                	mov    %eax,%ecx
  800b61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b64:	89 d0                	mov    %edx,%eax
  800b66:	01 c0                	add    %eax,%eax
  800b68:	01 d0                	add    %edx,%eax
  800b6a:	c1 e0 08             	shl    $0x8,%eax
  800b6d:	89 c2                	mov    %eax,%edx
  800b6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b72:	01 d0                	add    %edx,%eax
  800b74:	05 00 00 00 80       	add    $0x80000000,%eax
  800b79:	39 c1                	cmp    %eax,%ecx
  800b7b:	74 17                	je     800b94 <_main+0xb5c>
  800b7d:	83 ec 04             	sub    $0x4,%esp
  800b80:	68 00 2b 80 00       	push   $0x802b00
  800b85:	68 d7 00 00 00       	push   $0xd7
  800b8a:	68 dc 29 80 00       	push   $0x8029dc
  800b8f:	e8 4b 03 00 00       	call   800edf <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256+64) panic("Wrong page file allocation: ");
  800b94:	e8 7c 17 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800b99:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800b9c:	3d 40 01 00 00       	cmp    $0x140,%eax
  800ba1:	74 17                	je     800bba <_main+0xb82>
  800ba3:	83 ec 04             	sub    $0x4,%esp
  800ba6:	68 e2 2a 80 00       	push   $0x802ae2
  800bab:	68 d9 00 00 00       	push   $0xd9
  800bb0:	68 dc 29 80 00       	push   $0x8029dc
  800bb5:	e8 25 03 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bba:	e8 d3 16 00 00       	call   802292 <sys_calculate_free_frames>
  800bbf:	89 c2                	mov    %eax,%edx
  800bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc4:	39 c2                	cmp    %eax,%edx
  800bc6:	74 17                	je     800bdf <_main+0xba7>
  800bc8:	83 ec 04             	sub    $0x4,%esp
  800bcb:	68 30 2b 80 00       	push   $0x802b30
  800bd0:	68 da 00 00 00       	push   $0xda
  800bd5:	68 dc 29 80 00       	push   $0x8029dc
  800bda:	e8 00 03 00 00       	call   800edf <_panic>

		//Allocate Shared 4 MB [should be placed at the end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800bdf:	e8 ae 16 00 00       	call   802292 <sys_calculate_free_frames>
  800be4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800be7:	e8 29 17 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800bec:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[14] = smalloc("w", 4*Mega, 0);
  800bef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800bf2:	c1 e0 02             	shl    $0x2,%eax
  800bf5:	83 ec 04             	sub    $0x4,%esp
  800bf8:	6a 00                	push   $0x0
  800bfa:	50                   	push   %eax
  800bfb:	68 6b 2b 80 00       	push   $0x802b6b
  800c00:	e8 96 14 00 00       	call   80209b <smalloc>
  800c05:	83 c4 10             	add    $0x10,%esp
  800c08:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if (ptr_allocations[14] != (uint32*)(USER_HEAP_START + 18*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800c0b:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  800c0e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800c11:	89 d0                	mov    %edx,%eax
  800c13:	c1 e0 03             	shl    $0x3,%eax
  800c16:	01 d0                	add    %edx,%eax
  800c18:	01 c0                	add    %eax,%eax
  800c1a:	05 00 00 00 80       	add    $0x80000000,%eax
  800c1f:	39 c1                	cmp    %eax,%ecx
  800c21:	74 17                	je     800c3a <_main+0xc02>
  800c23:	83 ec 04             	sub    $0x4,%esp
  800c26:	68 f8 29 80 00       	push   $0x8029f8
  800c2b:	68 e0 00 00 00       	push   $0xe0
  800c30:	68 dc 29 80 00       	push   $0x8029dc
  800c35:	e8 a5 02 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1024+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800c3a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800c3d:	e8 50 16 00 00       	call   802292 <sys_calculate_free_frames>
  800c42:	29 c3                	sub    %eax,%ebx
  800c44:	89 d8                	mov    %ebx,%eax
  800c46:	3d 04 04 00 00       	cmp    $0x404,%eax
  800c4b:	74 17                	je     800c64 <_main+0xc2c>
  800c4d:	83 ec 04             	sub    $0x4,%esp
  800c50:	68 64 2a 80 00       	push   $0x802a64
  800c55:	68 e1 00 00 00       	push   $0xe1
  800c5a:	68 dc 29 80 00       	push   $0x8029dc
  800c5f:	e8 7b 02 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800c64:	e8 ac 16 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800c69:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800c6c:	74 17                	je     800c85 <_main+0xc4d>
  800c6e:	83 ec 04             	sub    $0x4,%esp
  800c71:	68 e2 2a 80 00       	push   $0x802ae2
  800c76:	68 e2 00 00 00       	push   $0xe2
  800c7b:	68 dc 29 80 00       	push   $0x8029dc
  800c80:	e8 5a 02 00 00       	call   800edf <_panic>

		//Get shared of 3 MB [should be placed in the remaining part of the contiguous (256 KB + 4 MB) hole
		freeFrames = sys_calculate_free_frames() ;
  800c85:	e8 08 16 00 00       	call   802292 <sys_calculate_free_frames>
  800c8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800c8d:	e8 83 16 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800c92:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[15] = sget(envID, "z");
  800c95:	83 ec 08             	sub    $0x8,%esp
  800c98:	68 45 2b 80 00       	push   $0x802b45
  800c9d:	ff 75 ec             	pushl  -0x14(%ebp)
  800ca0:	e8 16 14 00 00       	call   8020bb <sget>
  800ca5:	83 c4 10             	add    $0x10,%esp
  800ca8:	89 45 c8             	mov    %eax,-0x38(%ebp)
		if (ptr_allocations[15] != (uint32*)(USER_HEAP_START + 3*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800cab:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800cae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800cb1:	89 c1                	mov    %eax,%ecx
  800cb3:	01 c9                	add    %ecx,%ecx
  800cb5:	01 c8                	add    %ecx,%eax
  800cb7:	05 00 00 00 80       	add    $0x80000000,%eax
  800cbc:	39 c2                	cmp    %eax,%edx
  800cbe:	74 17                	je     800cd7 <_main+0xc9f>
  800cc0:	83 ec 04             	sub    $0x4,%esp
  800cc3:	68 f8 29 80 00       	push   $0x8029f8
  800cc8:	68 e8 00 00 00       	push   $0xe8
  800ccd:	68 dc 29 80 00       	push   $0x8029dc
  800cd2:	e8 08 02 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800cd7:	e8 b6 15 00 00       	call   802292 <sys_calculate_free_frames>
  800cdc:	89 c2                	mov    %eax,%edx
  800cde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce1:	39 c2                	cmp    %eax,%edx
  800ce3:	74 17                	je     800cfc <_main+0xcc4>
  800ce5:	83 ec 04             	sub    $0x4,%esp
  800ce8:	68 64 2a 80 00       	push   $0x802a64
  800ced:	68 e9 00 00 00       	push   $0xe9
  800cf2:	68 dc 29 80 00       	push   $0x8029dc
  800cf7:	e8 e3 01 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800cfc:	e8 14 16 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800d01:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800d04:	74 17                	je     800d1d <_main+0xce5>
  800d06:	83 ec 04             	sub    $0x4,%esp
  800d09:	68 e2 2a 80 00       	push   $0x802ae2
  800d0e:	68 ea 00 00 00       	push   $0xea
  800d13:	68 dc 29 80 00       	push   $0x8029dc
  800d18:	e8 c2 01 00 00       	call   800edf <_panic>

		//Get shared of 1st 1 MB [should be placed in the remaining part of the 3 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800d1d:	e8 70 15 00 00       	call   802292 <sys_calculate_free_frames>
  800d22:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800d25:	e8 eb 15 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800d2a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[16] = sget(envID, "x");
  800d2d:	83 ec 08             	sub    $0x8,%esp
  800d30:	68 f3 29 80 00       	push   $0x8029f3
  800d35:	ff 75 ec             	pushl  -0x14(%ebp)
  800d38:	e8 7e 13 00 00       	call   8020bb <sget>
  800d3d:	83 c4 10             	add    $0x10,%esp
  800d40:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if (ptr_allocations[16] != (uint32*)(USER_HEAP_START + 10*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800d43:	8b 4d cc             	mov    -0x34(%ebp),%ecx
  800d46:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d49:	89 d0                	mov    %edx,%eax
  800d4b:	c1 e0 02             	shl    $0x2,%eax
  800d4e:	01 d0                	add    %edx,%eax
  800d50:	01 c0                	add    %eax,%eax
  800d52:	05 00 00 00 80       	add    $0x80000000,%eax
  800d57:	39 c1                	cmp    %eax,%ecx
  800d59:	74 17                	je     800d72 <_main+0xd3a>
  800d5b:	83 ec 04             	sub    $0x4,%esp
  800d5e:	68 f8 29 80 00       	push   $0x8029f8
  800d63:	68 f0 00 00 00       	push   $0xf0
  800d68:	68 dc 29 80 00       	push   $0x8029dc
  800d6d:	e8 6d 01 00 00       	call   800edf <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800d72:	e8 1b 15 00 00       	call   802292 <sys_calculate_free_frames>
  800d77:	89 c2                	mov    %eax,%edx
  800d79:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d7c:	39 c2                	cmp    %eax,%edx
  800d7e:	74 17                	je     800d97 <_main+0xd5f>
  800d80:	83 ec 04             	sub    $0x4,%esp
  800d83:	68 64 2a 80 00       	push   $0x802a64
  800d88:	68 f1 00 00 00       	push   $0xf1
  800d8d:	68 dc 29 80 00       	push   $0x8029dc
  800d92:	e8 48 01 00 00       	call   800edf <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800d97:	e8 79 15 00 00       	call   802315 <sys_pf_calculate_allocated_pages>
  800d9c:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800d9f:	74 17                	je     800db8 <_main+0xd80>
  800da1:	83 ec 04             	sub    $0x4,%esp
  800da4:	68 e2 2a 80 00       	push   $0x802ae2
  800da9:	68 f2 00 00 00       	push   $0xf2
  800dae:	68 dc 29 80 00       	push   $0x8029dc
  800db3:	e8 27 01 00 00       	call   800edf <_panic>

	}
	cprintf("Congratulations!! test FIRST FIT allocation (3) completed successfully.\n");
  800db8:	83 ec 0c             	sub    $0xc,%esp
  800dbb:	68 70 2b 80 00       	push   $0x802b70
  800dc0:	e8 ce 03 00 00       	call   801193 <cprintf>
  800dc5:	83 c4 10             	add    $0x10,%esp

	return;
  800dc8:	90                   	nop
}
  800dc9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dcc:	5b                   	pop    %ebx
  800dcd:	5f                   	pop    %edi
  800dce:	5d                   	pop    %ebp
  800dcf:	c3                   	ret    

00800dd0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
  800dd3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800dd6:	e8 ec 13 00 00       	call   8021c7 <sys_getenvindex>
  800ddb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800dde:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de1:	89 d0                	mov    %edx,%eax
  800de3:	c1 e0 02             	shl    $0x2,%eax
  800de6:	01 d0                	add    %edx,%eax
  800de8:	01 c0                	add    %eax,%eax
  800dea:	01 d0                	add    %edx,%eax
  800dec:	01 c0                	add    %eax,%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800df7:	01 d0                	add    %edx,%eax
  800df9:	c1 e0 02             	shl    $0x2,%eax
  800dfc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800e01:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800e06:	a1 20 40 80 00       	mov    0x804020,%eax
  800e0b:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800e11:	84 c0                	test   %al,%al
  800e13:	74 0f                	je     800e24 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800e15:	a1 20 40 80 00       	mov    0x804020,%eax
  800e1a:	05 f4 02 00 00       	add    $0x2f4,%eax
  800e1f:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800e24:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e28:	7e 0a                	jle    800e34 <libmain+0x64>
		binaryname = argv[0];
  800e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800e34:	83 ec 08             	sub    $0x8,%esp
  800e37:	ff 75 0c             	pushl  0xc(%ebp)
  800e3a:	ff 75 08             	pushl  0x8(%ebp)
  800e3d:	e8 f6 f1 ff ff       	call   800038 <_main>
  800e42:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800e45:	e8 18 15 00 00       	call   802362 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800e4a:	83 ec 0c             	sub    $0xc,%esp
  800e4d:	68 d4 2b 80 00       	push   $0x802bd4
  800e52:	e8 3c 03 00 00       	call   801193 <cprintf>
  800e57:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800e5a:	a1 20 40 80 00       	mov    0x804020,%eax
  800e5f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800e65:	a1 20 40 80 00       	mov    0x804020,%eax
  800e6a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800e70:	83 ec 04             	sub    $0x4,%esp
  800e73:	52                   	push   %edx
  800e74:	50                   	push   %eax
  800e75:	68 fc 2b 80 00       	push   $0x802bfc
  800e7a:	e8 14 03 00 00       	call   801193 <cprintf>
  800e7f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800e82:	a1 20 40 80 00       	mov    0x804020,%eax
  800e87:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800e8d:	83 ec 08             	sub    $0x8,%esp
  800e90:	50                   	push   %eax
  800e91:	68 21 2c 80 00       	push   $0x802c21
  800e96:	e8 f8 02 00 00       	call   801193 <cprintf>
  800e9b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800e9e:	83 ec 0c             	sub    $0xc,%esp
  800ea1:	68 d4 2b 80 00       	push   $0x802bd4
  800ea6:	e8 e8 02 00 00       	call   801193 <cprintf>
  800eab:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800eae:	e8 c9 14 00 00       	call   80237c <sys_enable_interrupt>

	// exit gracefully
	exit();
  800eb3:	e8 19 00 00 00       	call   800ed1 <exit>
}
  800eb8:	90                   	nop
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800ec1:	83 ec 0c             	sub    $0xc,%esp
  800ec4:	6a 00                	push   $0x0
  800ec6:	e8 c8 12 00 00       	call   802193 <sys_env_destroy>
  800ecb:	83 c4 10             	add    $0x10,%esp
}
  800ece:	90                   	nop
  800ecf:	c9                   	leave  
  800ed0:	c3                   	ret    

00800ed1 <exit>:

void
exit(void)
{
  800ed1:	55                   	push   %ebp
  800ed2:	89 e5                	mov    %esp,%ebp
  800ed4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800ed7:	e8 1d 13 00 00       	call   8021f9 <sys_env_exit>
}
  800edc:	90                   	nop
  800edd:	c9                   	leave  
  800ede:	c3                   	ret    

00800edf <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800edf:	55                   	push   %ebp
  800ee0:	89 e5                	mov    %esp,%ebp
  800ee2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800ee5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ee8:	83 c0 04             	add    $0x4,%eax
  800eeb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800eee:	a1 34 40 80 00       	mov    0x804034,%eax
  800ef3:	85 c0                	test   %eax,%eax
  800ef5:	74 16                	je     800f0d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800ef7:	a1 34 40 80 00       	mov    0x804034,%eax
  800efc:	83 ec 08             	sub    $0x8,%esp
  800eff:	50                   	push   %eax
  800f00:	68 38 2c 80 00       	push   $0x802c38
  800f05:	e8 89 02 00 00       	call   801193 <cprintf>
  800f0a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800f0d:	a1 00 40 80 00       	mov    0x804000,%eax
  800f12:	ff 75 0c             	pushl  0xc(%ebp)
  800f15:	ff 75 08             	pushl  0x8(%ebp)
  800f18:	50                   	push   %eax
  800f19:	68 3d 2c 80 00       	push   $0x802c3d
  800f1e:	e8 70 02 00 00       	call   801193 <cprintf>
  800f23:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800f26:	8b 45 10             	mov    0x10(%ebp),%eax
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2f:	50                   	push   %eax
  800f30:	e8 f3 01 00 00       	call   801128 <vcprintf>
  800f35:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800f38:	83 ec 08             	sub    $0x8,%esp
  800f3b:	6a 00                	push   $0x0
  800f3d:	68 59 2c 80 00       	push   $0x802c59
  800f42:	e8 e1 01 00 00       	call   801128 <vcprintf>
  800f47:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800f4a:	e8 82 ff ff ff       	call   800ed1 <exit>

	// should not return here
	while (1) ;
  800f4f:	eb fe                	jmp    800f4f <_panic+0x70>

00800f51 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800f57:	a1 20 40 80 00       	mov    0x804020,%eax
  800f5c:	8b 50 74             	mov    0x74(%eax),%edx
  800f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f62:	39 c2                	cmp    %eax,%edx
  800f64:	74 14                	je     800f7a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800f66:	83 ec 04             	sub    $0x4,%esp
  800f69:	68 5c 2c 80 00       	push   $0x802c5c
  800f6e:	6a 26                	push   $0x26
  800f70:	68 a8 2c 80 00       	push   $0x802ca8
  800f75:	e8 65 ff ff ff       	call   800edf <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800f7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800f81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800f88:	e9 c2 00 00 00       	jmp    80104f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800f8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f90:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	01 d0                	add    %edx,%eax
  800f9c:	8b 00                	mov    (%eax),%eax
  800f9e:	85 c0                	test   %eax,%eax
  800fa0:	75 08                	jne    800faa <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800fa2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800fa5:	e9 a2 00 00 00       	jmp    80104c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800faa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800fb1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800fb8:	eb 69                	jmp    801023 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800fba:	a1 20 40 80 00       	mov    0x804020,%eax
  800fbf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800fc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800fc8:	89 d0                	mov    %edx,%eax
  800fca:	01 c0                	add    %eax,%eax
  800fcc:	01 d0                	add    %edx,%eax
  800fce:	c1 e0 02             	shl    $0x2,%eax
  800fd1:	01 c8                	add    %ecx,%eax
  800fd3:	8a 40 04             	mov    0x4(%eax),%al
  800fd6:	84 c0                	test   %al,%al
  800fd8:	75 46                	jne    801020 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800fda:	a1 20 40 80 00       	mov    0x804020,%eax
  800fdf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800fe5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800fe8:	89 d0                	mov    %edx,%eax
  800fea:	01 c0                	add    %eax,%eax
  800fec:	01 d0                	add    %edx,%eax
  800fee:	c1 e0 02             	shl    $0x2,%eax
  800ff1:	01 c8                	add    %ecx,%eax
  800ff3:	8b 00                	mov    (%eax),%eax
  800ff5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ff8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ffb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801000:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801002:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801005:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	01 c8                	add    %ecx,%eax
  801011:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801013:	39 c2                	cmp    %eax,%edx
  801015:	75 09                	jne    801020 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801017:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80101e:	eb 12                	jmp    801032 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801020:	ff 45 e8             	incl   -0x18(%ebp)
  801023:	a1 20 40 80 00       	mov    0x804020,%eax
  801028:	8b 50 74             	mov    0x74(%eax),%edx
  80102b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80102e:	39 c2                	cmp    %eax,%edx
  801030:	77 88                	ja     800fba <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801032:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801036:	75 14                	jne    80104c <CheckWSWithoutLastIndex+0xfb>
			panic(
  801038:	83 ec 04             	sub    $0x4,%esp
  80103b:	68 b4 2c 80 00       	push   $0x802cb4
  801040:	6a 3a                	push   $0x3a
  801042:	68 a8 2c 80 00       	push   $0x802ca8
  801047:	e8 93 fe ff ff       	call   800edf <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80104c:	ff 45 f0             	incl   -0x10(%ebp)
  80104f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801052:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801055:	0f 8c 32 ff ff ff    	jl     800f8d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80105b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801062:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801069:	eb 26                	jmp    801091 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80106b:	a1 20 40 80 00       	mov    0x804020,%eax
  801070:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801076:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801079:	89 d0                	mov    %edx,%eax
  80107b:	01 c0                	add    %eax,%eax
  80107d:	01 d0                	add    %edx,%eax
  80107f:	c1 e0 02             	shl    $0x2,%eax
  801082:	01 c8                	add    %ecx,%eax
  801084:	8a 40 04             	mov    0x4(%eax),%al
  801087:	3c 01                	cmp    $0x1,%al
  801089:	75 03                	jne    80108e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80108b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80108e:	ff 45 e0             	incl   -0x20(%ebp)
  801091:	a1 20 40 80 00       	mov    0x804020,%eax
  801096:	8b 50 74             	mov    0x74(%eax),%edx
  801099:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80109c:	39 c2                	cmp    %eax,%edx
  80109e:	77 cb                	ja     80106b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8010a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010a3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8010a6:	74 14                	je     8010bc <CheckWSWithoutLastIndex+0x16b>
		panic(
  8010a8:	83 ec 04             	sub    $0x4,%esp
  8010ab:	68 08 2d 80 00       	push   $0x802d08
  8010b0:	6a 44                	push   $0x44
  8010b2:	68 a8 2c 80 00       	push   $0x802ca8
  8010b7:	e8 23 fe ff ff       	call   800edf <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8010bc:	90                   	nop
  8010bd:	c9                   	leave  
  8010be:	c3                   	ret    

008010bf <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8010bf:	55                   	push   %ebp
  8010c0:	89 e5                	mov    %esp,%ebp
  8010c2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8010c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c8:	8b 00                	mov    (%eax),%eax
  8010ca:	8d 48 01             	lea    0x1(%eax),%ecx
  8010cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d0:	89 0a                	mov    %ecx,(%edx)
  8010d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d5:	88 d1                	mov    %dl,%cl
  8010d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010da:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8010de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e1:	8b 00                	mov    (%eax),%eax
  8010e3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8010e8:	75 2c                	jne    801116 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8010ea:	a0 24 40 80 00       	mov    0x804024,%al
  8010ef:	0f b6 c0             	movzbl %al,%eax
  8010f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f5:	8b 12                	mov    (%edx),%edx
  8010f7:	89 d1                	mov    %edx,%ecx
  8010f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fc:	83 c2 08             	add    $0x8,%edx
  8010ff:	83 ec 04             	sub    $0x4,%esp
  801102:	50                   	push   %eax
  801103:	51                   	push   %ecx
  801104:	52                   	push   %edx
  801105:	e8 47 10 00 00       	call   802151 <sys_cputs>
  80110a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80110d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801110:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801116:	8b 45 0c             	mov    0xc(%ebp),%eax
  801119:	8b 40 04             	mov    0x4(%eax),%eax
  80111c:	8d 50 01             	lea    0x1(%eax),%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	89 50 04             	mov    %edx,0x4(%eax)
}
  801125:	90                   	nop
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801131:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801138:	00 00 00 
	b.cnt = 0;
  80113b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801142:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801145:	ff 75 0c             	pushl  0xc(%ebp)
  801148:	ff 75 08             	pushl  0x8(%ebp)
  80114b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801151:	50                   	push   %eax
  801152:	68 bf 10 80 00       	push   $0x8010bf
  801157:	e8 11 02 00 00       	call   80136d <vprintfmt>
  80115c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80115f:	a0 24 40 80 00       	mov    0x804024,%al
  801164:	0f b6 c0             	movzbl %al,%eax
  801167:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80116d:	83 ec 04             	sub    $0x4,%esp
  801170:	50                   	push   %eax
  801171:	52                   	push   %edx
  801172:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801178:	83 c0 08             	add    $0x8,%eax
  80117b:	50                   	push   %eax
  80117c:	e8 d0 0f 00 00       	call   802151 <sys_cputs>
  801181:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801184:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80118b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801191:	c9                   	leave  
  801192:	c3                   	ret    

00801193 <cprintf>:

int cprintf(const char *fmt, ...) {
  801193:	55                   	push   %ebp
  801194:	89 e5                	mov    %esp,%ebp
  801196:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801199:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8011a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8011a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	83 ec 08             	sub    $0x8,%esp
  8011ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8011af:	50                   	push   %eax
  8011b0:	e8 73 ff ff ff       	call   801128 <vcprintf>
  8011b5:	83 c4 10             	add    $0x10,%esp
  8011b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8011bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011be:	c9                   	leave  
  8011bf:	c3                   	ret    

008011c0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
  8011c3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011c6:	e8 97 11 00 00       	call   802362 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8011cb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8011ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	83 ec 08             	sub    $0x8,%esp
  8011d7:	ff 75 f4             	pushl  -0xc(%ebp)
  8011da:	50                   	push   %eax
  8011db:	e8 48 ff ff ff       	call   801128 <vcprintf>
  8011e0:	83 c4 10             	add    $0x10,%esp
  8011e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8011e6:	e8 91 11 00 00       	call   80237c <sys_enable_interrupt>
	return cnt;
  8011eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
  8011f3:	53                   	push   %ebx
  8011f4:	83 ec 14             	sub    $0x14,%esp
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801200:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801203:	8b 45 18             	mov    0x18(%ebp),%eax
  801206:	ba 00 00 00 00       	mov    $0x0,%edx
  80120b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80120e:	77 55                	ja     801265 <printnum+0x75>
  801210:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801213:	72 05                	jb     80121a <printnum+0x2a>
  801215:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801218:	77 4b                	ja     801265 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80121a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80121d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801220:	8b 45 18             	mov    0x18(%ebp),%eax
  801223:	ba 00 00 00 00       	mov    $0x0,%edx
  801228:	52                   	push   %edx
  801229:	50                   	push   %eax
  80122a:	ff 75 f4             	pushl  -0xc(%ebp)
  80122d:	ff 75 f0             	pushl  -0x10(%ebp)
  801230:	e8 0b 15 00 00       	call   802740 <__udivdi3>
  801235:	83 c4 10             	add    $0x10,%esp
  801238:	83 ec 04             	sub    $0x4,%esp
  80123b:	ff 75 20             	pushl  0x20(%ebp)
  80123e:	53                   	push   %ebx
  80123f:	ff 75 18             	pushl  0x18(%ebp)
  801242:	52                   	push   %edx
  801243:	50                   	push   %eax
  801244:	ff 75 0c             	pushl  0xc(%ebp)
  801247:	ff 75 08             	pushl  0x8(%ebp)
  80124a:	e8 a1 ff ff ff       	call   8011f0 <printnum>
  80124f:	83 c4 20             	add    $0x20,%esp
  801252:	eb 1a                	jmp    80126e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801254:	83 ec 08             	sub    $0x8,%esp
  801257:	ff 75 0c             	pushl  0xc(%ebp)
  80125a:	ff 75 20             	pushl  0x20(%ebp)
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	ff d0                	call   *%eax
  801262:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801265:	ff 4d 1c             	decl   0x1c(%ebp)
  801268:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80126c:	7f e6                	jg     801254 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80126e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801271:	bb 00 00 00 00       	mov    $0x0,%ebx
  801276:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801279:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80127c:	53                   	push   %ebx
  80127d:	51                   	push   %ecx
  80127e:	52                   	push   %edx
  80127f:	50                   	push   %eax
  801280:	e8 cb 15 00 00       	call   802850 <__umoddi3>
  801285:	83 c4 10             	add    $0x10,%esp
  801288:	05 74 2f 80 00       	add    $0x802f74,%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	0f be c0             	movsbl %al,%eax
  801292:	83 ec 08             	sub    $0x8,%esp
  801295:	ff 75 0c             	pushl  0xc(%ebp)
  801298:	50                   	push   %eax
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	ff d0                	call   *%eax
  80129e:	83 c4 10             	add    $0x10,%esp
}
  8012a1:	90                   	nop
  8012a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8012a5:	c9                   	leave  
  8012a6:	c3                   	ret    

008012a7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8012a7:	55                   	push   %ebp
  8012a8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8012aa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8012ae:	7e 1c                	jle    8012cc <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	8b 00                	mov    (%eax),%eax
  8012b5:	8d 50 08             	lea    0x8(%eax),%edx
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	89 10                	mov    %edx,(%eax)
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8b 00                	mov    (%eax),%eax
  8012c2:	83 e8 08             	sub    $0x8,%eax
  8012c5:	8b 50 04             	mov    0x4(%eax),%edx
  8012c8:	8b 00                	mov    (%eax),%eax
  8012ca:	eb 40                	jmp    80130c <getuint+0x65>
	else if (lflag)
  8012cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012d0:	74 1e                	je     8012f0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	8b 00                	mov    (%eax),%eax
  8012d7:	8d 50 04             	lea    0x4(%eax),%edx
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	89 10                	mov    %edx,(%eax)
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	8b 00                	mov    (%eax),%eax
  8012e4:	83 e8 04             	sub    $0x4,%eax
  8012e7:	8b 00                	mov    (%eax),%eax
  8012e9:	ba 00 00 00 00       	mov    $0x0,%edx
  8012ee:	eb 1c                	jmp    80130c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8b 00                	mov    (%eax),%eax
  8012f5:	8d 50 04             	lea    0x4(%eax),%edx
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	89 10                	mov    %edx,(%eax)
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8b 00                	mov    (%eax),%eax
  801302:	83 e8 04             	sub    $0x4,%eax
  801305:	8b 00                	mov    (%eax),%eax
  801307:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80130c:	5d                   	pop    %ebp
  80130d:	c3                   	ret    

0080130e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801311:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801315:	7e 1c                	jle    801333 <getint+0x25>
		return va_arg(*ap, long long);
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	8b 00                	mov    (%eax),%eax
  80131c:	8d 50 08             	lea    0x8(%eax),%edx
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	89 10                	mov    %edx,(%eax)
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	8b 00                	mov    (%eax),%eax
  801329:	83 e8 08             	sub    $0x8,%eax
  80132c:	8b 50 04             	mov    0x4(%eax),%edx
  80132f:	8b 00                	mov    (%eax),%eax
  801331:	eb 38                	jmp    80136b <getint+0x5d>
	else if (lflag)
  801333:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801337:	74 1a                	je     801353 <getint+0x45>
		return va_arg(*ap, long);
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8b 00                	mov    (%eax),%eax
  80133e:	8d 50 04             	lea    0x4(%eax),%edx
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	89 10                	mov    %edx,(%eax)
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8b 00                	mov    (%eax),%eax
  80134b:	83 e8 04             	sub    $0x4,%eax
  80134e:	8b 00                	mov    (%eax),%eax
  801350:	99                   	cltd   
  801351:	eb 18                	jmp    80136b <getint+0x5d>
	else
		return va_arg(*ap, int);
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8b 00                	mov    (%eax),%eax
  801358:	8d 50 04             	lea    0x4(%eax),%edx
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
  80135e:	89 10                	mov    %edx,(%eax)
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8b 00                	mov    (%eax),%eax
  801365:	83 e8 04             	sub    $0x4,%eax
  801368:	8b 00                	mov    (%eax),%eax
  80136a:	99                   	cltd   
}
  80136b:	5d                   	pop    %ebp
  80136c:	c3                   	ret    

0080136d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80136d:	55                   	push   %ebp
  80136e:	89 e5                	mov    %esp,%ebp
  801370:	56                   	push   %esi
  801371:	53                   	push   %ebx
  801372:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801375:	eb 17                	jmp    80138e <vprintfmt+0x21>
			if (ch == '\0')
  801377:	85 db                	test   %ebx,%ebx
  801379:	0f 84 af 03 00 00    	je     80172e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80137f:	83 ec 08             	sub    $0x8,%esp
  801382:	ff 75 0c             	pushl  0xc(%ebp)
  801385:	53                   	push   %ebx
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	ff d0                	call   *%eax
  80138b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	8d 50 01             	lea    0x1(%eax),%edx
  801394:	89 55 10             	mov    %edx,0x10(%ebp)
  801397:	8a 00                	mov    (%eax),%al
  801399:	0f b6 d8             	movzbl %al,%ebx
  80139c:	83 fb 25             	cmp    $0x25,%ebx
  80139f:	75 d6                	jne    801377 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8013a1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8013a5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8013ac:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8013b3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8013ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8013c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c4:	8d 50 01             	lea    0x1(%eax),%edx
  8013c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	0f b6 d8             	movzbl %al,%ebx
  8013cf:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8013d2:	83 f8 55             	cmp    $0x55,%eax
  8013d5:	0f 87 2b 03 00 00    	ja     801706 <vprintfmt+0x399>
  8013db:	8b 04 85 98 2f 80 00 	mov    0x802f98(,%eax,4),%eax
  8013e2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8013e4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8013e8:	eb d7                	jmp    8013c1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8013ea:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8013ee:	eb d1                	jmp    8013c1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8013f0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8013f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8013fa:	89 d0                	mov    %edx,%eax
  8013fc:	c1 e0 02             	shl    $0x2,%eax
  8013ff:	01 d0                	add    %edx,%eax
  801401:	01 c0                	add    %eax,%eax
  801403:	01 d8                	add    %ebx,%eax
  801405:	83 e8 30             	sub    $0x30,%eax
  801408:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80140b:	8b 45 10             	mov    0x10(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801413:	83 fb 2f             	cmp    $0x2f,%ebx
  801416:	7e 3e                	jle    801456 <vprintfmt+0xe9>
  801418:	83 fb 39             	cmp    $0x39,%ebx
  80141b:	7f 39                	jg     801456 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80141d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801420:	eb d5                	jmp    8013f7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801422:	8b 45 14             	mov    0x14(%ebp),%eax
  801425:	83 c0 04             	add    $0x4,%eax
  801428:	89 45 14             	mov    %eax,0x14(%ebp)
  80142b:	8b 45 14             	mov    0x14(%ebp),%eax
  80142e:	83 e8 04             	sub    $0x4,%eax
  801431:	8b 00                	mov    (%eax),%eax
  801433:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801436:	eb 1f                	jmp    801457 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801438:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80143c:	79 83                	jns    8013c1 <vprintfmt+0x54>
				width = 0;
  80143e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801445:	e9 77 ff ff ff       	jmp    8013c1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80144a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801451:	e9 6b ff ff ff       	jmp    8013c1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801456:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801457:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80145b:	0f 89 60 ff ff ff    	jns    8013c1 <vprintfmt+0x54>
				width = precision, precision = -1;
  801461:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801464:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801467:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80146e:	e9 4e ff ff ff       	jmp    8013c1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801473:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801476:	e9 46 ff ff ff       	jmp    8013c1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80147b:	8b 45 14             	mov    0x14(%ebp),%eax
  80147e:	83 c0 04             	add    $0x4,%eax
  801481:	89 45 14             	mov    %eax,0x14(%ebp)
  801484:	8b 45 14             	mov    0x14(%ebp),%eax
  801487:	83 e8 04             	sub    $0x4,%eax
  80148a:	8b 00                	mov    (%eax),%eax
  80148c:	83 ec 08             	sub    $0x8,%esp
  80148f:	ff 75 0c             	pushl  0xc(%ebp)
  801492:	50                   	push   %eax
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	ff d0                	call   *%eax
  801498:	83 c4 10             	add    $0x10,%esp
			break;
  80149b:	e9 89 02 00 00       	jmp    801729 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8014a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a3:	83 c0 04             	add    $0x4,%eax
  8014a6:	89 45 14             	mov    %eax,0x14(%ebp)
  8014a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ac:	83 e8 04             	sub    $0x4,%eax
  8014af:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8014b1:	85 db                	test   %ebx,%ebx
  8014b3:	79 02                	jns    8014b7 <vprintfmt+0x14a>
				err = -err;
  8014b5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8014b7:	83 fb 64             	cmp    $0x64,%ebx
  8014ba:	7f 0b                	jg     8014c7 <vprintfmt+0x15a>
  8014bc:	8b 34 9d e0 2d 80 00 	mov    0x802de0(,%ebx,4),%esi
  8014c3:	85 f6                	test   %esi,%esi
  8014c5:	75 19                	jne    8014e0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8014c7:	53                   	push   %ebx
  8014c8:	68 85 2f 80 00       	push   $0x802f85
  8014cd:	ff 75 0c             	pushl  0xc(%ebp)
  8014d0:	ff 75 08             	pushl  0x8(%ebp)
  8014d3:	e8 5e 02 00 00       	call   801736 <printfmt>
  8014d8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8014db:	e9 49 02 00 00       	jmp    801729 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8014e0:	56                   	push   %esi
  8014e1:	68 8e 2f 80 00       	push   $0x802f8e
  8014e6:	ff 75 0c             	pushl  0xc(%ebp)
  8014e9:	ff 75 08             	pushl  0x8(%ebp)
  8014ec:	e8 45 02 00 00       	call   801736 <printfmt>
  8014f1:	83 c4 10             	add    $0x10,%esp
			break;
  8014f4:	e9 30 02 00 00       	jmp    801729 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8014f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014fc:	83 c0 04             	add    $0x4,%eax
  8014ff:	89 45 14             	mov    %eax,0x14(%ebp)
  801502:	8b 45 14             	mov    0x14(%ebp),%eax
  801505:	83 e8 04             	sub    $0x4,%eax
  801508:	8b 30                	mov    (%eax),%esi
  80150a:	85 f6                	test   %esi,%esi
  80150c:	75 05                	jne    801513 <vprintfmt+0x1a6>
				p = "(null)";
  80150e:	be 91 2f 80 00       	mov    $0x802f91,%esi
			if (width > 0 && padc != '-')
  801513:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801517:	7e 6d                	jle    801586 <vprintfmt+0x219>
  801519:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80151d:	74 67                	je     801586 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80151f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801522:	83 ec 08             	sub    $0x8,%esp
  801525:	50                   	push   %eax
  801526:	56                   	push   %esi
  801527:	e8 0c 03 00 00       	call   801838 <strnlen>
  80152c:	83 c4 10             	add    $0x10,%esp
  80152f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801532:	eb 16                	jmp    80154a <vprintfmt+0x1dd>
					putch(padc, putdat);
  801534:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801538:	83 ec 08             	sub    $0x8,%esp
  80153b:	ff 75 0c             	pushl  0xc(%ebp)
  80153e:	50                   	push   %eax
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	ff d0                	call   *%eax
  801544:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801547:	ff 4d e4             	decl   -0x1c(%ebp)
  80154a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80154e:	7f e4                	jg     801534 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801550:	eb 34                	jmp    801586 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801552:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801556:	74 1c                	je     801574 <vprintfmt+0x207>
  801558:	83 fb 1f             	cmp    $0x1f,%ebx
  80155b:	7e 05                	jle    801562 <vprintfmt+0x1f5>
  80155d:	83 fb 7e             	cmp    $0x7e,%ebx
  801560:	7e 12                	jle    801574 <vprintfmt+0x207>
					putch('?', putdat);
  801562:	83 ec 08             	sub    $0x8,%esp
  801565:	ff 75 0c             	pushl  0xc(%ebp)
  801568:	6a 3f                	push   $0x3f
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	ff d0                	call   *%eax
  80156f:	83 c4 10             	add    $0x10,%esp
  801572:	eb 0f                	jmp    801583 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801574:	83 ec 08             	sub    $0x8,%esp
  801577:	ff 75 0c             	pushl  0xc(%ebp)
  80157a:	53                   	push   %ebx
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	ff d0                	call   *%eax
  801580:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801583:	ff 4d e4             	decl   -0x1c(%ebp)
  801586:	89 f0                	mov    %esi,%eax
  801588:	8d 70 01             	lea    0x1(%eax),%esi
  80158b:	8a 00                	mov    (%eax),%al
  80158d:	0f be d8             	movsbl %al,%ebx
  801590:	85 db                	test   %ebx,%ebx
  801592:	74 24                	je     8015b8 <vprintfmt+0x24b>
  801594:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801598:	78 b8                	js     801552 <vprintfmt+0x1e5>
  80159a:	ff 4d e0             	decl   -0x20(%ebp)
  80159d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8015a1:	79 af                	jns    801552 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8015a3:	eb 13                	jmp    8015b8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8015a5:	83 ec 08             	sub    $0x8,%esp
  8015a8:	ff 75 0c             	pushl  0xc(%ebp)
  8015ab:	6a 20                	push   $0x20
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	ff d0                	call   *%eax
  8015b2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8015b5:	ff 4d e4             	decl   -0x1c(%ebp)
  8015b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015bc:	7f e7                	jg     8015a5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8015be:	e9 66 01 00 00       	jmp    801729 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8015c3:	83 ec 08             	sub    $0x8,%esp
  8015c6:	ff 75 e8             	pushl  -0x18(%ebp)
  8015c9:	8d 45 14             	lea    0x14(%ebp),%eax
  8015cc:	50                   	push   %eax
  8015cd:	e8 3c fd ff ff       	call   80130e <getint>
  8015d2:	83 c4 10             	add    $0x10,%esp
  8015d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8015db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015e1:	85 d2                	test   %edx,%edx
  8015e3:	79 23                	jns    801608 <vprintfmt+0x29b>
				putch('-', putdat);
  8015e5:	83 ec 08             	sub    $0x8,%esp
  8015e8:	ff 75 0c             	pushl  0xc(%ebp)
  8015eb:	6a 2d                	push   $0x2d
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	ff d0                	call   *%eax
  8015f2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8015f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015fb:	f7 d8                	neg    %eax
  8015fd:	83 d2 00             	adc    $0x0,%edx
  801600:	f7 da                	neg    %edx
  801602:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801605:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801608:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80160f:	e9 bc 00 00 00       	jmp    8016d0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801614:	83 ec 08             	sub    $0x8,%esp
  801617:	ff 75 e8             	pushl  -0x18(%ebp)
  80161a:	8d 45 14             	lea    0x14(%ebp),%eax
  80161d:	50                   	push   %eax
  80161e:	e8 84 fc ff ff       	call   8012a7 <getuint>
  801623:	83 c4 10             	add    $0x10,%esp
  801626:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801629:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80162c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801633:	e9 98 00 00 00       	jmp    8016d0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801638:	83 ec 08             	sub    $0x8,%esp
  80163b:	ff 75 0c             	pushl  0xc(%ebp)
  80163e:	6a 58                	push   $0x58
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	ff d0                	call   *%eax
  801645:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801648:	83 ec 08             	sub    $0x8,%esp
  80164b:	ff 75 0c             	pushl  0xc(%ebp)
  80164e:	6a 58                	push   $0x58
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	ff d0                	call   *%eax
  801655:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801658:	83 ec 08             	sub    $0x8,%esp
  80165b:	ff 75 0c             	pushl  0xc(%ebp)
  80165e:	6a 58                	push   $0x58
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	ff d0                	call   *%eax
  801665:	83 c4 10             	add    $0x10,%esp
			break;
  801668:	e9 bc 00 00 00       	jmp    801729 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80166d:	83 ec 08             	sub    $0x8,%esp
  801670:	ff 75 0c             	pushl  0xc(%ebp)
  801673:	6a 30                	push   $0x30
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	ff d0                	call   *%eax
  80167a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80167d:	83 ec 08             	sub    $0x8,%esp
  801680:	ff 75 0c             	pushl  0xc(%ebp)
  801683:	6a 78                	push   $0x78
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	ff d0                	call   *%eax
  80168a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80168d:	8b 45 14             	mov    0x14(%ebp),%eax
  801690:	83 c0 04             	add    $0x4,%eax
  801693:	89 45 14             	mov    %eax,0x14(%ebp)
  801696:	8b 45 14             	mov    0x14(%ebp),%eax
  801699:	83 e8 04             	sub    $0x4,%eax
  80169c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80169e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8016a8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8016af:	eb 1f                	jmp    8016d0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8016b1:	83 ec 08             	sub    $0x8,%esp
  8016b4:	ff 75 e8             	pushl  -0x18(%ebp)
  8016b7:	8d 45 14             	lea    0x14(%ebp),%eax
  8016ba:	50                   	push   %eax
  8016bb:	e8 e7 fb ff ff       	call   8012a7 <getuint>
  8016c0:	83 c4 10             	add    $0x10,%esp
  8016c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8016c9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8016d0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8016d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016d7:	83 ec 04             	sub    $0x4,%esp
  8016da:	52                   	push   %edx
  8016db:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016de:	50                   	push   %eax
  8016df:	ff 75 f4             	pushl  -0xc(%ebp)
  8016e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8016e5:	ff 75 0c             	pushl  0xc(%ebp)
  8016e8:	ff 75 08             	pushl  0x8(%ebp)
  8016eb:	e8 00 fb ff ff       	call   8011f0 <printnum>
  8016f0:	83 c4 20             	add    $0x20,%esp
			break;
  8016f3:	eb 34                	jmp    801729 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8016f5:	83 ec 08             	sub    $0x8,%esp
  8016f8:	ff 75 0c             	pushl  0xc(%ebp)
  8016fb:	53                   	push   %ebx
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	ff d0                	call   *%eax
  801701:	83 c4 10             	add    $0x10,%esp
			break;
  801704:	eb 23                	jmp    801729 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801706:	83 ec 08             	sub    $0x8,%esp
  801709:	ff 75 0c             	pushl  0xc(%ebp)
  80170c:	6a 25                	push   $0x25
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	ff d0                	call   *%eax
  801713:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801716:	ff 4d 10             	decl   0x10(%ebp)
  801719:	eb 03                	jmp    80171e <vprintfmt+0x3b1>
  80171b:	ff 4d 10             	decl   0x10(%ebp)
  80171e:	8b 45 10             	mov    0x10(%ebp),%eax
  801721:	48                   	dec    %eax
  801722:	8a 00                	mov    (%eax),%al
  801724:	3c 25                	cmp    $0x25,%al
  801726:	75 f3                	jne    80171b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801728:	90                   	nop
		}
	}
  801729:	e9 47 fc ff ff       	jmp    801375 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80172e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80172f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801732:	5b                   	pop    %ebx
  801733:	5e                   	pop    %esi
  801734:	5d                   	pop    %ebp
  801735:	c3                   	ret    

00801736 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
  801739:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80173c:	8d 45 10             	lea    0x10(%ebp),%eax
  80173f:	83 c0 04             	add    $0x4,%eax
  801742:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801745:	8b 45 10             	mov    0x10(%ebp),%eax
  801748:	ff 75 f4             	pushl  -0xc(%ebp)
  80174b:	50                   	push   %eax
  80174c:	ff 75 0c             	pushl  0xc(%ebp)
  80174f:	ff 75 08             	pushl  0x8(%ebp)
  801752:	e8 16 fc ff ff       	call   80136d <vprintfmt>
  801757:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80175a:	90                   	nop
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801760:	8b 45 0c             	mov    0xc(%ebp),%eax
  801763:	8b 40 08             	mov    0x8(%eax),%eax
  801766:	8d 50 01             	lea    0x1(%eax),%edx
  801769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80176f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801772:	8b 10                	mov    (%eax),%edx
  801774:	8b 45 0c             	mov    0xc(%ebp),%eax
  801777:	8b 40 04             	mov    0x4(%eax),%eax
  80177a:	39 c2                	cmp    %eax,%edx
  80177c:	73 12                	jae    801790 <sprintputch+0x33>
		*b->buf++ = ch;
  80177e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801781:	8b 00                	mov    (%eax),%eax
  801783:	8d 48 01             	lea    0x1(%eax),%ecx
  801786:	8b 55 0c             	mov    0xc(%ebp),%edx
  801789:	89 0a                	mov    %ecx,(%edx)
  80178b:	8b 55 08             	mov    0x8(%ebp),%edx
  80178e:	88 10                	mov    %dl,(%eax)
}
  801790:	90                   	nop
  801791:	5d                   	pop    %ebp
  801792:	c3                   	ret    

00801793 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
  801796:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801799:	8b 45 08             	mov    0x8(%ebp),%eax
  80179c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80179f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	01 d0                	add    %edx,%eax
  8017aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8017ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8017b4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017b8:	74 06                	je     8017c0 <vsnprintf+0x2d>
  8017ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017be:	7f 07                	jg     8017c7 <vsnprintf+0x34>
		return -E_INVAL;
  8017c0:	b8 03 00 00 00       	mov    $0x3,%eax
  8017c5:	eb 20                	jmp    8017e7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8017c7:	ff 75 14             	pushl  0x14(%ebp)
  8017ca:	ff 75 10             	pushl  0x10(%ebp)
  8017cd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8017d0:	50                   	push   %eax
  8017d1:	68 5d 17 80 00       	push   $0x80175d
  8017d6:	e8 92 fb ff ff       	call   80136d <vprintfmt>
  8017db:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8017de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017e1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8017e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
  8017ec:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8017ef:	8d 45 10             	lea    0x10(%ebp),%eax
  8017f2:	83 c0 04             	add    $0x4,%eax
  8017f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8017f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8017fe:	50                   	push   %eax
  8017ff:	ff 75 0c             	pushl  0xc(%ebp)
  801802:	ff 75 08             	pushl  0x8(%ebp)
  801805:	e8 89 ff ff ff       	call   801793 <vsnprintf>
  80180a:	83 c4 10             	add    $0x10,%esp
  80180d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801810:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
  801818:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80181b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801822:	eb 06                	jmp    80182a <strlen+0x15>
		n++;
  801824:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801827:	ff 45 08             	incl   0x8(%ebp)
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	8a 00                	mov    (%eax),%al
  80182f:	84 c0                	test   %al,%al
  801831:	75 f1                	jne    801824 <strlen+0xf>
		n++;
	return n;
  801833:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
  80183b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80183e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801845:	eb 09                	jmp    801850 <strnlen+0x18>
		n++;
  801847:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80184a:	ff 45 08             	incl   0x8(%ebp)
  80184d:	ff 4d 0c             	decl   0xc(%ebp)
  801850:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801854:	74 09                	je     80185f <strnlen+0x27>
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	84 c0                	test   %al,%al
  80185d:	75 e8                	jne    801847 <strnlen+0xf>
		n++;
	return n;
  80185f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80186a:	8b 45 08             	mov    0x8(%ebp),%eax
  80186d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801870:	90                   	nop
  801871:	8b 45 08             	mov    0x8(%ebp),%eax
  801874:	8d 50 01             	lea    0x1(%eax),%edx
  801877:	89 55 08             	mov    %edx,0x8(%ebp)
  80187a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801880:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801883:	8a 12                	mov    (%edx),%dl
  801885:	88 10                	mov    %dl,(%eax)
  801887:	8a 00                	mov    (%eax),%al
  801889:	84 c0                	test   %al,%al
  80188b:	75 e4                	jne    801871 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80188d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
  801895:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801898:	8b 45 08             	mov    0x8(%ebp),%eax
  80189b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80189e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018a5:	eb 1f                	jmp    8018c6 <strncpy+0x34>
		*dst++ = *src;
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	8d 50 01             	lea    0x1(%eax),%edx
  8018ad:	89 55 08             	mov    %edx,0x8(%ebp)
  8018b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b3:	8a 12                	mov    (%edx),%dl
  8018b5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8018b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ba:	8a 00                	mov    (%eax),%al
  8018bc:	84 c0                	test   %al,%al
  8018be:	74 03                	je     8018c3 <strncpy+0x31>
			src++;
  8018c0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8018c3:	ff 45 fc             	incl   -0x4(%ebp)
  8018c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018c9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018cc:	72 d9                	jb     8018a7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8018ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
  8018d6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8018df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018e3:	74 30                	je     801915 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8018e5:	eb 16                	jmp    8018fd <strlcpy+0x2a>
			*dst++ = *src++;
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	8d 50 01             	lea    0x1(%eax),%edx
  8018ed:	89 55 08             	mov    %edx,0x8(%ebp)
  8018f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018f6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8018f9:	8a 12                	mov    (%edx),%dl
  8018fb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8018fd:	ff 4d 10             	decl   0x10(%ebp)
  801900:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801904:	74 09                	je     80190f <strlcpy+0x3c>
  801906:	8b 45 0c             	mov    0xc(%ebp),%eax
  801909:	8a 00                	mov    (%eax),%al
  80190b:	84 c0                	test   %al,%al
  80190d:	75 d8                	jne    8018e7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801915:	8b 55 08             	mov    0x8(%ebp),%edx
  801918:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191b:	29 c2                	sub    %eax,%edx
  80191d:	89 d0                	mov    %edx,%eax
}
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801924:	eb 06                	jmp    80192c <strcmp+0xb>
		p++, q++;
  801926:	ff 45 08             	incl   0x8(%ebp)
  801929:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80192c:	8b 45 08             	mov    0x8(%ebp),%eax
  80192f:	8a 00                	mov    (%eax),%al
  801931:	84 c0                	test   %al,%al
  801933:	74 0e                	je     801943 <strcmp+0x22>
  801935:	8b 45 08             	mov    0x8(%ebp),%eax
  801938:	8a 10                	mov    (%eax),%dl
  80193a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193d:	8a 00                	mov    (%eax),%al
  80193f:	38 c2                	cmp    %al,%dl
  801941:	74 e3                	je     801926 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801943:	8b 45 08             	mov    0x8(%ebp),%eax
  801946:	8a 00                	mov    (%eax),%al
  801948:	0f b6 d0             	movzbl %al,%edx
  80194b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194e:	8a 00                	mov    (%eax),%al
  801950:	0f b6 c0             	movzbl %al,%eax
  801953:	29 c2                	sub    %eax,%edx
  801955:	89 d0                	mov    %edx,%eax
}
  801957:	5d                   	pop    %ebp
  801958:	c3                   	ret    

00801959 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80195c:	eb 09                	jmp    801967 <strncmp+0xe>
		n--, p++, q++;
  80195e:	ff 4d 10             	decl   0x10(%ebp)
  801961:	ff 45 08             	incl   0x8(%ebp)
  801964:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801967:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80196b:	74 17                	je     801984 <strncmp+0x2b>
  80196d:	8b 45 08             	mov    0x8(%ebp),%eax
  801970:	8a 00                	mov    (%eax),%al
  801972:	84 c0                	test   %al,%al
  801974:	74 0e                	je     801984 <strncmp+0x2b>
  801976:	8b 45 08             	mov    0x8(%ebp),%eax
  801979:	8a 10                	mov    (%eax),%dl
  80197b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197e:	8a 00                	mov    (%eax),%al
  801980:	38 c2                	cmp    %al,%dl
  801982:	74 da                	je     80195e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801984:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801988:	75 07                	jne    801991 <strncmp+0x38>
		return 0;
  80198a:	b8 00 00 00 00       	mov    $0x0,%eax
  80198f:	eb 14                	jmp    8019a5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801991:	8b 45 08             	mov    0x8(%ebp),%eax
  801994:	8a 00                	mov    (%eax),%al
  801996:	0f b6 d0             	movzbl %al,%edx
  801999:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	0f b6 c0             	movzbl %al,%eax
  8019a1:	29 c2                	sub    %eax,%edx
  8019a3:	89 d0                	mov    %edx,%eax
}
  8019a5:	5d                   	pop    %ebp
  8019a6:	c3                   	ret    

008019a7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
  8019aa:	83 ec 04             	sub    $0x4,%esp
  8019ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8019b3:	eb 12                	jmp    8019c7 <strchr+0x20>
		if (*s == c)
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	8a 00                	mov    (%eax),%al
  8019ba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8019bd:	75 05                	jne    8019c4 <strchr+0x1d>
			return (char *) s;
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	eb 11                	jmp    8019d5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8019c4:	ff 45 08             	incl   0x8(%ebp)
  8019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ca:	8a 00                	mov    (%eax),%al
  8019cc:	84 c0                	test   %al,%al
  8019ce:	75 e5                	jne    8019b5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8019d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
  8019da:	83 ec 04             	sub    $0x4,%esp
  8019dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8019e3:	eb 0d                	jmp    8019f2 <strfind+0x1b>
		if (*s == c)
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	8a 00                	mov    (%eax),%al
  8019ea:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8019ed:	74 0e                	je     8019fd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8019ef:	ff 45 08             	incl   0x8(%ebp)
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	8a 00                	mov    (%eax),%al
  8019f7:	84 c0                	test   %al,%al
  8019f9:	75 ea                	jne    8019e5 <strfind+0xe>
  8019fb:	eb 01                	jmp    8019fe <strfind+0x27>
		if (*s == c)
			break;
  8019fd:	90                   	nop
	return (char *) s;
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a01:	c9                   	leave  
  801a02:	c3                   	ret    

00801a03 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801a03:	55                   	push   %ebp
  801a04:	89 e5                	mov    %esp,%ebp
  801a06:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801a09:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801a0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801a15:	eb 0e                	jmp    801a25 <memset+0x22>
		*p++ = c;
  801a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1a:	8d 50 01             	lea    0x1(%eax),%edx
  801a1d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a23:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801a25:	ff 4d f8             	decl   -0x8(%ebp)
  801a28:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801a2c:	79 e9                	jns    801a17 <memset+0x14>
		*p++ = c;

	return v;
  801a2e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
  801a36:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a42:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801a45:	eb 16                	jmp    801a5d <memcpy+0x2a>
		*d++ = *s++;
  801a47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a4a:	8d 50 01             	lea    0x1(%eax),%edx
  801a4d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a50:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a53:	8d 4a 01             	lea    0x1(%edx),%ecx
  801a56:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801a59:	8a 12                	mov    (%edx),%dl
  801a5b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801a5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a60:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a63:	89 55 10             	mov    %edx,0x10(%ebp)
  801a66:	85 c0                	test   %eax,%eax
  801a68:	75 dd                	jne    801a47 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
  801a72:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801a75:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801a81:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a84:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801a87:	73 50                	jae    801ad9 <memmove+0x6a>
  801a89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a8f:	01 d0                	add    %edx,%eax
  801a91:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801a94:	76 43                	jbe    801ad9 <memmove+0x6a>
		s += n;
  801a96:	8b 45 10             	mov    0x10(%ebp),%eax
  801a99:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801a9c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a9f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801aa2:	eb 10                	jmp    801ab4 <memmove+0x45>
			*--d = *--s;
  801aa4:	ff 4d f8             	decl   -0x8(%ebp)
  801aa7:	ff 4d fc             	decl   -0x4(%ebp)
  801aaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aad:	8a 10                	mov    (%eax),%dl
  801aaf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ab2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801ab4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab7:	8d 50 ff             	lea    -0x1(%eax),%edx
  801aba:	89 55 10             	mov    %edx,0x10(%ebp)
  801abd:	85 c0                	test   %eax,%eax
  801abf:	75 e3                	jne    801aa4 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801ac1:	eb 23                	jmp    801ae6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801ac3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ac6:	8d 50 01             	lea    0x1(%eax),%edx
  801ac9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801acc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801acf:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ad2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801ad5:	8a 12                	mov    (%edx),%dl
  801ad7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801ad9:	8b 45 10             	mov    0x10(%ebp),%eax
  801adc:	8d 50 ff             	lea    -0x1(%eax),%edx
  801adf:	89 55 10             	mov    %edx,0x10(%ebp)
  801ae2:	85 c0                	test   %eax,%eax
  801ae4:	75 dd                	jne    801ac3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801ae6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
  801aee:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801af1:	8b 45 08             	mov    0x8(%ebp),%eax
  801af4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afa:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801afd:	eb 2a                	jmp    801b29 <memcmp+0x3e>
		if (*s1 != *s2)
  801aff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b02:	8a 10                	mov    (%eax),%dl
  801b04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b07:	8a 00                	mov    (%eax),%al
  801b09:	38 c2                	cmp    %al,%dl
  801b0b:	74 16                	je     801b23 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801b0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b10:	8a 00                	mov    (%eax),%al
  801b12:	0f b6 d0             	movzbl %al,%edx
  801b15:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b18:	8a 00                	mov    (%eax),%al
  801b1a:	0f b6 c0             	movzbl %al,%eax
  801b1d:	29 c2                	sub    %eax,%edx
  801b1f:	89 d0                	mov    %edx,%eax
  801b21:	eb 18                	jmp    801b3b <memcmp+0x50>
		s1++, s2++;
  801b23:	ff 45 fc             	incl   -0x4(%ebp)
  801b26:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801b29:	8b 45 10             	mov    0x10(%ebp),%eax
  801b2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b2f:	89 55 10             	mov    %edx,0x10(%ebp)
  801b32:	85 c0                	test   %eax,%eax
  801b34:	75 c9                	jne    801aff <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801b36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b3b:	c9                   	leave  
  801b3c:	c3                   	ret    

00801b3d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
  801b40:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801b43:	8b 55 08             	mov    0x8(%ebp),%edx
  801b46:	8b 45 10             	mov    0x10(%ebp),%eax
  801b49:	01 d0                	add    %edx,%eax
  801b4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801b4e:	eb 15                	jmp    801b65 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	8a 00                	mov    (%eax),%al
  801b55:	0f b6 d0             	movzbl %al,%edx
  801b58:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b5b:	0f b6 c0             	movzbl %al,%eax
  801b5e:	39 c2                	cmp    %eax,%edx
  801b60:	74 0d                	je     801b6f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801b62:	ff 45 08             	incl   0x8(%ebp)
  801b65:	8b 45 08             	mov    0x8(%ebp),%eax
  801b68:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b6b:	72 e3                	jb     801b50 <memfind+0x13>
  801b6d:	eb 01                	jmp    801b70 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801b6f:	90                   	nop
	return (void *) s;
  801b70:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
  801b78:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801b7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801b82:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801b89:	eb 03                	jmp    801b8e <strtol+0x19>
		s++;
  801b8b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b91:	8a 00                	mov    (%eax),%al
  801b93:	3c 20                	cmp    $0x20,%al
  801b95:	74 f4                	je     801b8b <strtol+0x16>
  801b97:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9a:	8a 00                	mov    (%eax),%al
  801b9c:	3c 09                	cmp    $0x9,%al
  801b9e:	74 eb                	je     801b8b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	8a 00                	mov    (%eax),%al
  801ba5:	3c 2b                	cmp    $0x2b,%al
  801ba7:	75 05                	jne    801bae <strtol+0x39>
		s++;
  801ba9:	ff 45 08             	incl   0x8(%ebp)
  801bac:	eb 13                	jmp    801bc1 <strtol+0x4c>
	else if (*s == '-')
  801bae:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb1:	8a 00                	mov    (%eax),%al
  801bb3:	3c 2d                	cmp    $0x2d,%al
  801bb5:	75 0a                	jne    801bc1 <strtol+0x4c>
		s++, neg = 1;
  801bb7:	ff 45 08             	incl   0x8(%ebp)
  801bba:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801bc1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801bc5:	74 06                	je     801bcd <strtol+0x58>
  801bc7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801bcb:	75 20                	jne    801bed <strtol+0x78>
  801bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd0:	8a 00                	mov    (%eax),%al
  801bd2:	3c 30                	cmp    $0x30,%al
  801bd4:	75 17                	jne    801bed <strtol+0x78>
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	40                   	inc    %eax
  801bda:	8a 00                	mov    (%eax),%al
  801bdc:	3c 78                	cmp    $0x78,%al
  801bde:	75 0d                	jne    801bed <strtol+0x78>
		s += 2, base = 16;
  801be0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801be4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801beb:	eb 28                	jmp    801c15 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801bed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801bf1:	75 15                	jne    801c08 <strtol+0x93>
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	8a 00                	mov    (%eax),%al
  801bf8:	3c 30                	cmp    $0x30,%al
  801bfa:	75 0c                	jne    801c08 <strtol+0x93>
		s++, base = 8;
  801bfc:	ff 45 08             	incl   0x8(%ebp)
  801bff:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801c06:	eb 0d                	jmp    801c15 <strtol+0xa0>
	else if (base == 0)
  801c08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c0c:	75 07                	jne    801c15 <strtol+0xa0>
		base = 10;
  801c0e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801c15:	8b 45 08             	mov    0x8(%ebp),%eax
  801c18:	8a 00                	mov    (%eax),%al
  801c1a:	3c 2f                	cmp    $0x2f,%al
  801c1c:	7e 19                	jle    801c37 <strtol+0xc2>
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	8a 00                	mov    (%eax),%al
  801c23:	3c 39                	cmp    $0x39,%al
  801c25:	7f 10                	jg     801c37 <strtol+0xc2>
			dig = *s - '0';
  801c27:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2a:	8a 00                	mov    (%eax),%al
  801c2c:	0f be c0             	movsbl %al,%eax
  801c2f:	83 e8 30             	sub    $0x30,%eax
  801c32:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c35:	eb 42                	jmp    801c79 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801c37:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3a:	8a 00                	mov    (%eax),%al
  801c3c:	3c 60                	cmp    $0x60,%al
  801c3e:	7e 19                	jle    801c59 <strtol+0xe4>
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	8a 00                	mov    (%eax),%al
  801c45:	3c 7a                	cmp    $0x7a,%al
  801c47:	7f 10                	jg     801c59 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801c49:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4c:	8a 00                	mov    (%eax),%al
  801c4e:	0f be c0             	movsbl %al,%eax
  801c51:	83 e8 57             	sub    $0x57,%eax
  801c54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c57:	eb 20                	jmp    801c79 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801c59:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5c:	8a 00                	mov    (%eax),%al
  801c5e:	3c 40                	cmp    $0x40,%al
  801c60:	7e 39                	jle    801c9b <strtol+0x126>
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	8a 00                	mov    (%eax),%al
  801c67:	3c 5a                	cmp    $0x5a,%al
  801c69:	7f 30                	jg     801c9b <strtol+0x126>
			dig = *s - 'A' + 10;
  801c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6e:	8a 00                	mov    (%eax),%al
  801c70:	0f be c0             	movsbl %al,%eax
  801c73:	83 e8 37             	sub    $0x37,%eax
  801c76:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801c79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c7c:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c7f:	7d 19                	jge    801c9a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801c81:	ff 45 08             	incl   0x8(%ebp)
  801c84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c87:	0f af 45 10          	imul   0x10(%ebp),%eax
  801c8b:	89 c2                	mov    %eax,%edx
  801c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c90:	01 d0                	add    %edx,%eax
  801c92:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801c95:	e9 7b ff ff ff       	jmp    801c15 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801c9a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801c9b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c9f:	74 08                	je     801ca9 <strtol+0x134>
		*endptr = (char *) s;
  801ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ca4:	8b 55 08             	mov    0x8(%ebp),%edx
  801ca7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801ca9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801cad:	74 07                	je     801cb6 <strtol+0x141>
  801caf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cb2:	f7 d8                	neg    %eax
  801cb4:	eb 03                	jmp    801cb9 <strtol+0x144>
  801cb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <ltostr>:

void
ltostr(long value, char *str)
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
  801cbe:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801cc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801cc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801ccf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cd3:	79 13                	jns    801ce8 <ltostr+0x2d>
	{
		neg = 1;
  801cd5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cdf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801ce2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801ce5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ceb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801cf0:	99                   	cltd   
  801cf1:	f7 f9                	idiv   %ecx
  801cf3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801cf6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cf9:	8d 50 01             	lea    0x1(%eax),%edx
  801cfc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801cff:	89 c2                	mov    %eax,%edx
  801d01:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d04:	01 d0                	add    %edx,%eax
  801d06:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d09:	83 c2 30             	add    $0x30,%edx
  801d0c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801d0e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d11:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d16:	f7 e9                	imul   %ecx
  801d18:	c1 fa 02             	sar    $0x2,%edx
  801d1b:	89 c8                	mov    %ecx,%eax
  801d1d:	c1 f8 1f             	sar    $0x1f,%eax
  801d20:	29 c2                	sub    %eax,%edx
  801d22:	89 d0                	mov    %edx,%eax
  801d24:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801d27:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d2a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d2f:	f7 e9                	imul   %ecx
  801d31:	c1 fa 02             	sar    $0x2,%edx
  801d34:	89 c8                	mov    %ecx,%eax
  801d36:	c1 f8 1f             	sar    $0x1f,%eax
  801d39:	29 c2                	sub    %eax,%edx
  801d3b:	89 d0                	mov    %edx,%eax
  801d3d:	c1 e0 02             	shl    $0x2,%eax
  801d40:	01 d0                	add    %edx,%eax
  801d42:	01 c0                	add    %eax,%eax
  801d44:	29 c1                	sub    %eax,%ecx
  801d46:	89 ca                	mov    %ecx,%edx
  801d48:	85 d2                	test   %edx,%edx
  801d4a:	75 9c                	jne    801ce8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801d4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801d53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d56:	48                   	dec    %eax
  801d57:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801d5a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d5e:	74 3d                	je     801d9d <ltostr+0xe2>
		start = 1 ;
  801d60:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801d67:	eb 34                	jmp    801d9d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801d69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d6f:	01 d0                	add    %edx,%eax
  801d71:	8a 00                	mov    (%eax),%al
  801d73:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801d76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d7c:	01 c2                	add    %eax,%edx
  801d7e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801d81:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d84:	01 c8                	add    %ecx,%eax
  801d86:	8a 00                	mov    (%eax),%al
  801d88:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801d8a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d90:	01 c2                	add    %eax,%edx
  801d92:	8a 45 eb             	mov    -0x15(%ebp),%al
  801d95:	88 02                	mov    %al,(%edx)
		start++ ;
  801d97:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801d9a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801da0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801da3:	7c c4                	jl     801d69 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801da5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801da8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dab:	01 d0                	add    %edx,%eax
  801dad:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801db0:	90                   	nop
  801db1:	c9                   	leave  
  801db2:	c3                   	ret    

00801db3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801db3:	55                   	push   %ebp
  801db4:	89 e5                	mov    %esp,%ebp
  801db6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801db9:	ff 75 08             	pushl  0x8(%ebp)
  801dbc:	e8 54 fa ff ff       	call   801815 <strlen>
  801dc1:	83 c4 04             	add    $0x4,%esp
  801dc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801dc7:	ff 75 0c             	pushl  0xc(%ebp)
  801dca:	e8 46 fa ff ff       	call   801815 <strlen>
  801dcf:	83 c4 04             	add    $0x4,%esp
  801dd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801dd5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801ddc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801de3:	eb 17                	jmp    801dfc <strcconcat+0x49>
		final[s] = str1[s] ;
  801de5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801de8:	8b 45 10             	mov    0x10(%ebp),%eax
  801deb:	01 c2                	add    %eax,%edx
  801ded:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801df0:	8b 45 08             	mov    0x8(%ebp),%eax
  801df3:	01 c8                	add    %ecx,%eax
  801df5:	8a 00                	mov    (%eax),%al
  801df7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801df9:	ff 45 fc             	incl   -0x4(%ebp)
  801dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801dff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e02:	7c e1                	jl     801de5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801e04:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801e0b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801e12:	eb 1f                	jmp    801e33 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801e14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e17:	8d 50 01             	lea    0x1(%eax),%edx
  801e1a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801e1d:	89 c2                	mov    %eax,%edx
  801e1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e22:	01 c2                	add    %eax,%edx
  801e24:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e2a:	01 c8                	add    %ecx,%eax
  801e2c:	8a 00                	mov    (%eax),%al
  801e2e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801e30:	ff 45 f8             	incl   -0x8(%ebp)
  801e33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e36:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e39:	7c d9                	jl     801e14 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801e3b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801e41:	01 d0                	add    %edx,%eax
  801e43:	c6 00 00             	movb   $0x0,(%eax)
}
  801e46:	90                   	nop
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801e4c:	8b 45 14             	mov    0x14(%ebp),%eax
  801e4f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801e55:	8b 45 14             	mov    0x14(%ebp),%eax
  801e58:	8b 00                	mov    (%eax),%eax
  801e5a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e61:	8b 45 10             	mov    0x10(%ebp),%eax
  801e64:	01 d0                	add    %edx,%eax
  801e66:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e6c:	eb 0c                	jmp    801e7a <strsplit+0x31>
			*string++ = 0;
  801e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e71:	8d 50 01             	lea    0x1(%eax),%edx
  801e74:	89 55 08             	mov    %edx,0x8(%ebp)
  801e77:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7d:	8a 00                	mov    (%eax),%al
  801e7f:	84 c0                	test   %al,%al
  801e81:	74 18                	je     801e9b <strsplit+0x52>
  801e83:	8b 45 08             	mov    0x8(%ebp),%eax
  801e86:	8a 00                	mov    (%eax),%al
  801e88:	0f be c0             	movsbl %al,%eax
  801e8b:	50                   	push   %eax
  801e8c:	ff 75 0c             	pushl  0xc(%ebp)
  801e8f:	e8 13 fb ff ff       	call   8019a7 <strchr>
  801e94:	83 c4 08             	add    $0x8,%esp
  801e97:	85 c0                	test   %eax,%eax
  801e99:	75 d3                	jne    801e6e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9e:	8a 00                	mov    (%eax),%al
  801ea0:	84 c0                	test   %al,%al
  801ea2:	74 5a                	je     801efe <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801ea4:	8b 45 14             	mov    0x14(%ebp),%eax
  801ea7:	8b 00                	mov    (%eax),%eax
  801ea9:	83 f8 0f             	cmp    $0xf,%eax
  801eac:	75 07                	jne    801eb5 <strsplit+0x6c>
		{
			return 0;
  801eae:	b8 00 00 00 00       	mov    $0x0,%eax
  801eb3:	eb 66                	jmp    801f1b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801eb5:	8b 45 14             	mov    0x14(%ebp),%eax
  801eb8:	8b 00                	mov    (%eax),%eax
  801eba:	8d 48 01             	lea    0x1(%eax),%ecx
  801ebd:	8b 55 14             	mov    0x14(%ebp),%edx
  801ec0:	89 0a                	mov    %ecx,(%edx)
  801ec2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ec9:	8b 45 10             	mov    0x10(%ebp),%eax
  801ecc:	01 c2                	add    %eax,%edx
  801ece:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ed3:	eb 03                	jmp    801ed8 <strsplit+0x8f>
			string++;
  801ed5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	8a 00                	mov    (%eax),%al
  801edd:	84 c0                	test   %al,%al
  801edf:	74 8b                	je     801e6c <strsplit+0x23>
  801ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee4:	8a 00                	mov    (%eax),%al
  801ee6:	0f be c0             	movsbl %al,%eax
  801ee9:	50                   	push   %eax
  801eea:	ff 75 0c             	pushl  0xc(%ebp)
  801eed:	e8 b5 fa ff ff       	call   8019a7 <strchr>
  801ef2:	83 c4 08             	add    $0x8,%esp
  801ef5:	85 c0                	test   %eax,%eax
  801ef7:	74 dc                	je     801ed5 <strsplit+0x8c>
			string++;
	}
  801ef9:	e9 6e ff ff ff       	jmp    801e6c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801efe:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801eff:	8b 45 14             	mov    0x14(%ebp),%eax
  801f02:	8b 00                	mov    (%eax),%eax
  801f04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f0b:	8b 45 10             	mov    0x10(%ebp),%eax
  801f0e:	01 d0                	add    %edx,%eax
  801f10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801f16:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801f1b:	c9                   	leave  
  801f1c:	c3                   	ret    

00801f1d <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801f1d:	55                   	push   %ebp
  801f1e:	89 e5                	mov    %esp,%ebp
  801f20:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801f23:	e8 9b 07 00 00       	call   8026c3 <sys_isUHeapPlacementStrategyNEXTFIT>
  801f28:	85 c0                	test   %eax,%eax
  801f2a:	0f 84 64 01 00 00    	je     802094 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801f30:	8b 0d 28 40 80 00    	mov    0x804028,%ecx
  801f36:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801f3d:	8b 55 08             	mov    0x8(%ebp),%edx
  801f40:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f43:	01 d0                	add    %edx,%eax
  801f45:	48                   	dec    %eax
  801f46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801f49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801f4c:	ba 00 00 00 00       	mov    $0x0,%edx
  801f51:	f7 75 e8             	divl   -0x18(%ebp)
  801f54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801f57:	29 d0                	sub    %edx,%eax
  801f59:	89 04 cd 44 40 88 00 	mov    %eax,0x884044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801f60:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801f66:	8b 45 08             	mov    0x8(%ebp),%eax
  801f69:	01 d0                	add    %edx,%eax
  801f6b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801f6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801f75:	a1 28 40 80 00       	mov    0x804028,%eax
  801f7a:	8b 04 c5 44 40 88 00 	mov    0x884044(,%eax,8),%eax
  801f81:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801f84:	0f 83 0a 01 00 00    	jae    802094 <malloc+0x177>
  801f8a:	a1 28 40 80 00       	mov    0x804028,%eax
  801f8f:	8b 04 c5 44 40 88 00 	mov    0x884044(,%eax,8),%eax
  801f96:	85 c0                	test   %eax,%eax
  801f98:	0f 84 f6 00 00 00    	je     802094 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801f9e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801fa5:	e9 dc 00 00 00       	jmp    802086 <malloc+0x169>
				flag++;
  801faa:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801fad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fb0:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  801fb7:	85 c0                	test   %eax,%eax
  801fb9:	74 07                	je     801fc2 <malloc+0xa5>
					flag=0;
  801fbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801fc2:	a1 28 40 80 00       	mov    0x804028,%eax
  801fc7:	8b 04 c5 44 40 88 00 	mov    0x884044(,%eax,8),%eax
  801fce:	85 c0                	test   %eax,%eax
  801fd0:	79 05                	jns    801fd7 <malloc+0xba>
  801fd2:	05 ff 0f 00 00       	add    $0xfff,%eax
  801fd7:	c1 f8 0c             	sar    $0xc,%eax
  801fda:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801fdd:	0f 85 a0 00 00 00    	jne    802083 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801fe3:	a1 28 40 80 00       	mov    0x804028,%eax
  801fe8:	8b 04 c5 44 40 88 00 	mov    0x884044(,%eax,8),%eax
  801fef:	85 c0                	test   %eax,%eax
  801ff1:	79 05                	jns    801ff8 <malloc+0xdb>
  801ff3:	05 ff 0f 00 00       	add    $0xfff,%eax
  801ff8:	c1 f8 0c             	sar    $0xc,%eax
  801ffb:	89 c2                	mov    %eax,%edx
  801ffd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802000:	29 d0                	sub    %edx,%eax
  802002:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  802005:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802008:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80200b:	eb 11                	jmp    80201e <malloc+0x101>
						hFreeArr[j] = 1;
  80200d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802010:	c7 04 85 40 40 80 00 	movl   $0x1,0x804040(,%eax,4)
  802017:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  80201b:	ff 45 ec             	incl   -0x14(%ebp)
  80201e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802021:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802024:	7e e7                	jle    80200d <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  802026:	a1 28 40 80 00       	mov    0x804028,%eax
  80202b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80202e:	81 c2 01 00 08 00    	add    $0x80001,%edx
  802034:	c1 e2 0c             	shl    $0xc,%edx
  802037:	89 15 04 40 80 00    	mov    %edx,0x804004
  80203d:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802043:	89 14 c5 40 40 88 00 	mov    %edx,0x884040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  80204a:	a1 28 40 80 00       	mov    0x804028,%eax
  80204f:	8b 04 c5 44 40 88 00 	mov    0x884044(,%eax,8),%eax
  802056:	89 c2                	mov    %eax,%edx
  802058:	a1 28 40 80 00       	mov    0x804028,%eax
  80205d:	8b 04 c5 40 40 88 00 	mov    0x884040(,%eax,8),%eax
  802064:	83 ec 08             	sub    $0x8,%esp
  802067:	52                   	push   %edx
  802068:	50                   	push   %eax
  802069:	e8 8b 02 00 00       	call   8022f9 <sys_allocateMem>
  80206e:	83 c4 10             	add    $0x10,%esp

					idx++;
  802071:	a1 28 40 80 00       	mov    0x804028,%eax
  802076:	40                   	inc    %eax
  802077:	a3 28 40 80 00       	mov    %eax,0x804028
					return (void*)startAdd;
  80207c:	a1 04 40 80 00       	mov    0x804004,%eax
  802081:	eb 16                	jmp    802099 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  802083:	ff 45 f0             	incl   -0x10(%ebp)
  802086:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802089:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80208e:	0f 86 16 ff ff ff    	jbe    801faa <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  802094:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802099:	c9                   	leave  
  80209a:	c3                   	ret    

0080209b <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80209b:	55                   	push   %ebp
  80209c:	89 e5                	mov    %esp,%ebp
  80209e:	83 ec 18             	sub    $0x18,%esp
  8020a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8020a4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8020a7:	83 ec 04             	sub    $0x4,%esp
  8020aa:	68 f0 30 80 00       	push   $0x8030f0
  8020af:	6a 59                	push   $0x59
  8020b1:	68 0f 31 80 00       	push   $0x80310f
  8020b6:	e8 24 ee ff ff       	call   800edf <_panic>

008020bb <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
  8020be:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8020c1:	83 ec 04             	sub    $0x4,%esp
  8020c4:	68 1b 31 80 00       	push   $0x80311b
  8020c9:	6a 5f                	push   $0x5f
  8020cb:	68 0f 31 80 00       	push   $0x80310f
  8020d0:	e8 0a ee ff ff       	call   800edf <_panic>

008020d5 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8020d5:	55                   	push   %ebp
  8020d6:	89 e5                	mov    %esp,%ebp
  8020d8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8020db:	83 ec 04             	sub    $0x4,%esp
  8020de:	68 38 31 80 00       	push   $0x803138
  8020e3:	6a 70                	push   $0x70
  8020e5:	68 0f 31 80 00       	push   $0x80310f
  8020ea:	e8 f0 ed ff ff       	call   800edf <_panic>

008020ef <sfree>:

}


void sfree(void* virtual_address)
{
  8020ef:	55                   	push   %ebp
  8020f0:	89 e5                	mov    %esp,%ebp
  8020f2:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  8020f5:	83 ec 04             	sub    $0x4,%esp
  8020f8:	68 5b 31 80 00       	push   $0x80315b
  8020fd:	6a 7b                	push   $0x7b
  8020ff:	68 0f 31 80 00       	push   $0x80310f
  802104:	e8 d6 ed ff ff       	call   800edf <_panic>

00802109 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  802109:	55                   	push   %ebp
  80210a:	89 e5                	mov    %esp,%ebp
  80210c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80210f:	83 ec 04             	sub    $0x4,%esp
  802112:	68 78 31 80 00       	push   $0x803178
  802117:	68 93 00 00 00       	push   $0x93
  80211c:	68 0f 31 80 00       	push   $0x80310f
  802121:	e8 b9 ed ff ff       	call   800edf <_panic>

00802126 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
  802129:	57                   	push   %edi
  80212a:	56                   	push   %esi
  80212b:	53                   	push   %ebx
  80212c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80212f:	8b 45 08             	mov    0x8(%ebp),%eax
  802132:	8b 55 0c             	mov    0xc(%ebp),%edx
  802135:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802138:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80213b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80213e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802141:	cd 30                	int    $0x30
  802143:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802146:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802149:	83 c4 10             	add    $0x10,%esp
  80214c:	5b                   	pop    %ebx
  80214d:	5e                   	pop    %esi
  80214e:	5f                   	pop    %edi
  80214f:	5d                   	pop    %ebp
  802150:	c3                   	ret    

00802151 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 04             	sub    $0x4,%esp
  802157:	8b 45 10             	mov    0x10(%ebp),%eax
  80215a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80215d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802161:	8b 45 08             	mov    0x8(%ebp),%eax
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	52                   	push   %edx
  802169:	ff 75 0c             	pushl  0xc(%ebp)
  80216c:	50                   	push   %eax
  80216d:	6a 00                	push   $0x0
  80216f:	e8 b2 ff ff ff       	call   802126 <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	90                   	nop
  802178:	c9                   	leave  
  802179:	c3                   	ret    

0080217a <sys_cgetc>:

int
sys_cgetc(void)
{
  80217a:	55                   	push   %ebp
  80217b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80217d:	6a 00                	push   $0x0
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 01                	push   $0x1
  802189:	e8 98 ff ff ff       	call   802126 <syscall>
  80218e:	83 c4 18             	add    $0x18,%esp
}
  802191:	c9                   	leave  
  802192:	c3                   	ret    

00802193 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802193:	55                   	push   %ebp
  802194:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802196:	8b 45 08             	mov    0x8(%ebp),%eax
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	50                   	push   %eax
  8021a2:	6a 05                	push   $0x5
  8021a4:	e8 7d ff ff ff       	call   802126 <syscall>
  8021a9:	83 c4 18             	add    $0x18,%esp
}
  8021ac:	c9                   	leave  
  8021ad:	c3                   	ret    

008021ae <sys_getenvid>:

int32 sys_getenvid(void)
{
  8021ae:	55                   	push   %ebp
  8021af:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 02                	push   $0x2
  8021bd:	e8 64 ff ff ff       	call   802126 <syscall>
  8021c2:	83 c4 18             	add    $0x18,%esp
}
  8021c5:	c9                   	leave  
  8021c6:	c3                   	ret    

008021c7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8021c7:	55                   	push   %ebp
  8021c8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8021ca:	6a 00                	push   $0x0
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 03                	push   $0x3
  8021d6:	e8 4b ff ff ff       	call   802126 <syscall>
  8021db:	83 c4 18             	add    $0x18,%esp
}
  8021de:	c9                   	leave  
  8021df:	c3                   	ret    

008021e0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8021e0:	55                   	push   %ebp
  8021e1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 04                	push   $0x4
  8021ef:	e8 32 ff ff ff       	call   802126 <syscall>
  8021f4:	83 c4 18             	add    $0x18,%esp
}
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <sys_env_exit>:


void sys_env_exit(void)
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 06                	push   $0x6
  802208:	e8 19 ff ff ff       	call   802126 <syscall>
  80220d:	83 c4 18             	add    $0x18,%esp
}
  802210:	90                   	nop
  802211:	c9                   	leave  
  802212:	c3                   	ret    

00802213 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802213:	55                   	push   %ebp
  802214:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802216:	8b 55 0c             	mov    0xc(%ebp),%edx
  802219:	8b 45 08             	mov    0x8(%ebp),%eax
  80221c:	6a 00                	push   $0x0
  80221e:	6a 00                	push   $0x0
  802220:	6a 00                	push   $0x0
  802222:	52                   	push   %edx
  802223:	50                   	push   %eax
  802224:	6a 07                	push   $0x7
  802226:	e8 fb fe ff ff       	call   802126 <syscall>
  80222b:	83 c4 18             	add    $0x18,%esp
}
  80222e:	c9                   	leave  
  80222f:	c3                   	ret    

00802230 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802230:	55                   	push   %ebp
  802231:	89 e5                	mov    %esp,%ebp
  802233:	56                   	push   %esi
  802234:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802235:	8b 75 18             	mov    0x18(%ebp),%esi
  802238:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80223b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80223e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802241:	8b 45 08             	mov    0x8(%ebp),%eax
  802244:	56                   	push   %esi
  802245:	53                   	push   %ebx
  802246:	51                   	push   %ecx
  802247:	52                   	push   %edx
  802248:	50                   	push   %eax
  802249:	6a 08                	push   $0x8
  80224b:	e8 d6 fe ff ff       	call   802126 <syscall>
  802250:	83 c4 18             	add    $0x18,%esp
}
  802253:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802256:	5b                   	pop    %ebx
  802257:	5e                   	pop    %esi
  802258:	5d                   	pop    %ebp
  802259:	c3                   	ret    

0080225a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80225a:	55                   	push   %ebp
  80225b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80225d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802260:	8b 45 08             	mov    0x8(%ebp),%eax
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	52                   	push   %edx
  80226a:	50                   	push   %eax
  80226b:	6a 09                	push   $0x9
  80226d:	e8 b4 fe ff ff       	call   802126 <syscall>
  802272:	83 c4 18             	add    $0x18,%esp
}
  802275:	c9                   	leave  
  802276:	c3                   	ret    

00802277 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802277:	55                   	push   %ebp
  802278:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	ff 75 0c             	pushl  0xc(%ebp)
  802283:	ff 75 08             	pushl  0x8(%ebp)
  802286:	6a 0a                	push   $0xa
  802288:	e8 99 fe ff ff       	call   802126 <syscall>
  80228d:	83 c4 18             	add    $0x18,%esp
}
  802290:	c9                   	leave  
  802291:	c3                   	ret    

00802292 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802292:	55                   	push   %ebp
  802293:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 0b                	push   $0xb
  8022a1:	e8 80 fe ff ff       	call   802126 <syscall>
  8022a6:	83 c4 18             	add    $0x18,%esp
}
  8022a9:	c9                   	leave  
  8022aa:	c3                   	ret    

008022ab <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8022ab:	55                   	push   %ebp
  8022ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 0c                	push   $0xc
  8022ba:	e8 67 fe ff ff       	call   802126 <syscall>
  8022bf:	83 c4 18             	add    $0x18,%esp
}
  8022c2:	c9                   	leave  
  8022c3:	c3                   	ret    

008022c4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8022c4:	55                   	push   %ebp
  8022c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 0d                	push   $0xd
  8022d3:	e8 4e fe ff ff       	call   802126 <syscall>
  8022d8:	83 c4 18             	add    $0x18,%esp
}
  8022db:	c9                   	leave  
  8022dc:	c3                   	ret    

008022dd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8022dd:	55                   	push   %ebp
  8022de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	ff 75 0c             	pushl  0xc(%ebp)
  8022e9:	ff 75 08             	pushl  0x8(%ebp)
  8022ec:	6a 11                	push   $0x11
  8022ee:	e8 33 fe ff ff       	call   802126 <syscall>
  8022f3:	83 c4 18             	add    $0x18,%esp
	return;
  8022f6:	90                   	nop
}
  8022f7:	c9                   	leave  
  8022f8:	c3                   	ret    

008022f9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8022f9:	55                   	push   %ebp
  8022fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8022fc:	6a 00                	push   $0x0
  8022fe:	6a 00                	push   $0x0
  802300:	6a 00                	push   $0x0
  802302:	ff 75 0c             	pushl  0xc(%ebp)
  802305:	ff 75 08             	pushl  0x8(%ebp)
  802308:	6a 12                	push   $0x12
  80230a:	e8 17 fe ff ff       	call   802126 <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
	return ;
  802312:	90                   	nop
}
  802313:	c9                   	leave  
  802314:	c3                   	ret    

00802315 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802315:	55                   	push   %ebp
  802316:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	6a 0e                	push   $0xe
  802324:	e8 fd fd ff ff       	call   802126 <syscall>
  802329:	83 c4 18             	add    $0x18,%esp
}
  80232c:	c9                   	leave  
  80232d:	c3                   	ret    

0080232e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80232e:	55                   	push   %ebp
  80232f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802331:	6a 00                	push   $0x0
  802333:	6a 00                	push   $0x0
  802335:	6a 00                	push   $0x0
  802337:	6a 00                	push   $0x0
  802339:	ff 75 08             	pushl  0x8(%ebp)
  80233c:	6a 0f                	push   $0xf
  80233e:	e8 e3 fd ff ff       	call   802126 <syscall>
  802343:	83 c4 18             	add    $0x18,%esp
}
  802346:	c9                   	leave  
  802347:	c3                   	ret    

00802348 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802348:	55                   	push   %ebp
  802349:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 10                	push   $0x10
  802357:	e8 ca fd ff ff       	call   802126 <syscall>
  80235c:	83 c4 18             	add    $0x18,%esp
}
  80235f:	90                   	nop
  802360:	c9                   	leave  
  802361:	c3                   	ret    

00802362 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802362:	55                   	push   %ebp
  802363:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 14                	push   $0x14
  802371:	e8 b0 fd ff ff       	call   802126 <syscall>
  802376:	83 c4 18             	add    $0x18,%esp
}
  802379:	90                   	nop
  80237a:	c9                   	leave  
  80237b:	c3                   	ret    

0080237c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80237c:	55                   	push   %ebp
  80237d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80237f:	6a 00                	push   $0x0
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 15                	push   $0x15
  80238b:	e8 96 fd ff ff       	call   802126 <syscall>
  802390:	83 c4 18             	add    $0x18,%esp
}
  802393:	90                   	nop
  802394:	c9                   	leave  
  802395:	c3                   	ret    

00802396 <sys_cputc>:


void
sys_cputc(const char c)
{
  802396:	55                   	push   %ebp
  802397:	89 e5                	mov    %esp,%ebp
  802399:	83 ec 04             	sub    $0x4,%esp
  80239c:	8b 45 08             	mov    0x8(%ebp),%eax
  80239f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8023a2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 00                	push   $0x0
  8023ac:	6a 00                	push   $0x0
  8023ae:	50                   	push   %eax
  8023af:	6a 16                	push   $0x16
  8023b1:	e8 70 fd ff ff       	call   802126 <syscall>
  8023b6:	83 c4 18             	add    $0x18,%esp
}
  8023b9:	90                   	nop
  8023ba:	c9                   	leave  
  8023bb:	c3                   	ret    

008023bc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8023bc:	55                   	push   %ebp
  8023bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 00                	push   $0x0
  8023c5:	6a 00                	push   $0x0
  8023c7:	6a 00                	push   $0x0
  8023c9:	6a 17                	push   $0x17
  8023cb:	e8 56 fd ff ff       	call   802126 <syscall>
  8023d0:	83 c4 18             	add    $0x18,%esp
}
  8023d3:	90                   	nop
  8023d4:	c9                   	leave  
  8023d5:	c3                   	ret    

008023d6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8023d6:	55                   	push   %ebp
  8023d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8023d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	ff 75 0c             	pushl  0xc(%ebp)
  8023e5:	50                   	push   %eax
  8023e6:	6a 18                	push   $0x18
  8023e8:	e8 39 fd ff ff       	call   802126 <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
}
  8023f0:	c9                   	leave  
  8023f1:	c3                   	ret    

008023f2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8023f2:	55                   	push   %ebp
  8023f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 00                	push   $0x0
  802401:	52                   	push   %edx
  802402:	50                   	push   %eax
  802403:	6a 1b                	push   $0x1b
  802405:	e8 1c fd ff ff       	call   802126 <syscall>
  80240a:	83 c4 18             	add    $0x18,%esp
}
  80240d:	c9                   	leave  
  80240e:	c3                   	ret    

0080240f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80240f:	55                   	push   %ebp
  802410:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802412:	8b 55 0c             	mov    0xc(%ebp),%edx
  802415:	8b 45 08             	mov    0x8(%ebp),%eax
  802418:	6a 00                	push   $0x0
  80241a:	6a 00                	push   $0x0
  80241c:	6a 00                	push   $0x0
  80241e:	52                   	push   %edx
  80241f:	50                   	push   %eax
  802420:	6a 19                	push   $0x19
  802422:	e8 ff fc ff ff       	call   802126 <syscall>
  802427:	83 c4 18             	add    $0x18,%esp
}
  80242a:	90                   	nop
  80242b:	c9                   	leave  
  80242c:	c3                   	ret    

0080242d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80242d:	55                   	push   %ebp
  80242e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802430:	8b 55 0c             	mov    0xc(%ebp),%edx
  802433:	8b 45 08             	mov    0x8(%ebp),%eax
  802436:	6a 00                	push   $0x0
  802438:	6a 00                	push   $0x0
  80243a:	6a 00                	push   $0x0
  80243c:	52                   	push   %edx
  80243d:	50                   	push   %eax
  80243e:	6a 1a                	push   $0x1a
  802440:	e8 e1 fc ff ff       	call   802126 <syscall>
  802445:	83 c4 18             	add    $0x18,%esp
}
  802448:	90                   	nop
  802449:	c9                   	leave  
  80244a:	c3                   	ret    

0080244b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80244b:	55                   	push   %ebp
  80244c:	89 e5                	mov    %esp,%ebp
  80244e:	83 ec 04             	sub    $0x4,%esp
  802451:	8b 45 10             	mov    0x10(%ebp),%eax
  802454:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802457:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80245a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80245e:	8b 45 08             	mov    0x8(%ebp),%eax
  802461:	6a 00                	push   $0x0
  802463:	51                   	push   %ecx
  802464:	52                   	push   %edx
  802465:	ff 75 0c             	pushl  0xc(%ebp)
  802468:	50                   	push   %eax
  802469:	6a 1c                	push   $0x1c
  80246b:	e8 b6 fc ff ff       	call   802126 <syscall>
  802470:	83 c4 18             	add    $0x18,%esp
}
  802473:	c9                   	leave  
  802474:	c3                   	ret    

00802475 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802475:	55                   	push   %ebp
  802476:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802478:	8b 55 0c             	mov    0xc(%ebp),%edx
  80247b:	8b 45 08             	mov    0x8(%ebp),%eax
  80247e:	6a 00                	push   $0x0
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	52                   	push   %edx
  802485:	50                   	push   %eax
  802486:	6a 1d                	push   $0x1d
  802488:	e8 99 fc ff ff       	call   802126 <syscall>
  80248d:	83 c4 18             	add    $0x18,%esp
}
  802490:	c9                   	leave  
  802491:	c3                   	ret    

00802492 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802492:	55                   	push   %ebp
  802493:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802495:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802498:	8b 55 0c             	mov    0xc(%ebp),%edx
  80249b:	8b 45 08             	mov    0x8(%ebp),%eax
  80249e:	6a 00                	push   $0x0
  8024a0:	6a 00                	push   $0x0
  8024a2:	51                   	push   %ecx
  8024a3:	52                   	push   %edx
  8024a4:	50                   	push   %eax
  8024a5:	6a 1e                	push   $0x1e
  8024a7:	e8 7a fc ff ff       	call   802126 <syscall>
  8024ac:	83 c4 18             	add    $0x18,%esp
}
  8024af:	c9                   	leave  
  8024b0:	c3                   	ret    

008024b1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8024b1:	55                   	push   %ebp
  8024b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8024b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ba:	6a 00                	push   $0x0
  8024bc:	6a 00                	push   $0x0
  8024be:	6a 00                	push   $0x0
  8024c0:	52                   	push   %edx
  8024c1:	50                   	push   %eax
  8024c2:	6a 1f                	push   $0x1f
  8024c4:	e8 5d fc ff ff       	call   802126 <syscall>
  8024c9:	83 c4 18             	add    $0x18,%esp
}
  8024cc:	c9                   	leave  
  8024cd:	c3                   	ret    

008024ce <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8024ce:	55                   	push   %ebp
  8024cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8024d1:	6a 00                	push   $0x0
  8024d3:	6a 00                	push   $0x0
  8024d5:	6a 00                	push   $0x0
  8024d7:	6a 00                	push   $0x0
  8024d9:	6a 00                	push   $0x0
  8024db:	6a 20                	push   $0x20
  8024dd:	e8 44 fc ff ff       	call   802126 <syscall>
  8024e2:	83 c4 18             	add    $0x18,%esp
}
  8024e5:	c9                   	leave  
  8024e6:	c3                   	ret    

008024e7 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8024e7:	55                   	push   %ebp
  8024e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8024ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ed:	6a 00                	push   $0x0
  8024ef:	6a 00                	push   $0x0
  8024f1:	ff 75 10             	pushl  0x10(%ebp)
  8024f4:	ff 75 0c             	pushl  0xc(%ebp)
  8024f7:	50                   	push   %eax
  8024f8:	6a 21                	push   $0x21
  8024fa:	e8 27 fc ff ff       	call   802126 <syscall>
  8024ff:	83 c4 18             	add    $0x18,%esp
}
  802502:	c9                   	leave  
  802503:	c3                   	ret    

00802504 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802504:	55                   	push   %ebp
  802505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802507:	8b 45 08             	mov    0x8(%ebp),%eax
  80250a:	6a 00                	push   $0x0
  80250c:	6a 00                	push   $0x0
  80250e:	6a 00                	push   $0x0
  802510:	6a 00                	push   $0x0
  802512:	50                   	push   %eax
  802513:	6a 22                	push   $0x22
  802515:	e8 0c fc ff ff       	call   802126 <syscall>
  80251a:	83 c4 18             	add    $0x18,%esp
}
  80251d:	90                   	nop
  80251e:	c9                   	leave  
  80251f:	c3                   	ret    

00802520 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802520:	55                   	push   %ebp
  802521:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802523:	8b 45 08             	mov    0x8(%ebp),%eax
  802526:	6a 00                	push   $0x0
  802528:	6a 00                	push   $0x0
  80252a:	6a 00                	push   $0x0
  80252c:	6a 00                	push   $0x0
  80252e:	50                   	push   %eax
  80252f:	6a 23                	push   $0x23
  802531:	e8 f0 fb ff ff       	call   802126 <syscall>
  802536:	83 c4 18             	add    $0x18,%esp
}
  802539:	90                   	nop
  80253a:	c9                   	leave  
  80253b:	c3                   	ret    

0080253c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80253c:	55                   	push   %ebp
  80253d:	89 e5                	mov    %esp,%ebp
  80253f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802542:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802545:	8d 50 04             	lea    0x4(%eax),%edx
  802548:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80254b:	6a 00                	push   $0x0
  80254d:	6a 00                	push   $0x0
  80254f:	6a 00                	push   $0x0
  802551:	52                   	push   %edx
  802552:	50                   	push   %eax
  802553:	6a 24                	push   $0x24
  802555:	e8 cc fb ff ff       	call   802126 <syscall>
  80255a:	83 c4 18             	add    $0x18,%esp
	return result;
  80255d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802560:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802563:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802566:	89 01                	mov    %eax,(%ecx)
  802568:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80256b:	8b 45 08             	mov    0x8(%ebp),%eax
  80256e:	c9                   	leave  
  80256f:	c2 04 00             	ret    $0x4

00802572 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802572:	55                   	push   %ebp
  802573:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802575:	6a 00                	push   $0x0
  802577:	6a 00                	push   $0x0
  802579:	ff 75 10             	pushl  0x10(%ebp)
  80257c:	ff 75 0c             	pushl  0xc(%ebp)
  80257f:	ff 75 08             	pushl  0x8(%ebp)
  802582:	6a 13                	push   $0x13
  802584:	e8 9d fb ff ff       	call   802126 <syscall>
  802589:	83 c4 18             	add    $0x18,%esp
	return ;
  80258c:	90                   	nop
}
  80258d:	c9                   	leave  
  80258e:	c3                   	ret    

0080258f <sys_rcr2>:
uint32 sys_rcr2()
{
  80258f:	55                   	push   %ebp
  802590:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802592:	6a 00                	push   $0x0
  802594:	6a 00                	push   $0x0
  802596:	6a 00                	push   $0x0
  802598:	6a 00                	push   $0x0
  80259a:	6a 00                	push   $0x0
  80259c:	6a 25                	push   $0x25
  80259e:	e8 83 fb ff ff       	call   802126 <syscall>
  8025a3:	83 c4 18             	add    $0x18,%esp
}
  8025a6:	c9                   	leave  
  8025a7:	c3                   	ret    

008025a8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8025a8:	55                   	push   %ebp
  8025a9:	89 e5                	mov    %esp,%ebp
  8025ab:	83 ec 04             	sub    $0x4,%esp
  8025ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8025b4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8025b8:	6a 00                	push   $0x0
  8025ba:	6a 00                	push   $0x0
  8025bc:	6a 00                	push   $0x0
  8025be:	6a 00                	push   $0x0
  8025c0:	50                   	push   %eax
  8025c1:	6a 26                	push   $0x26
  8025c3:	e8 5e fb ff ff       	call   802126 <syscall>
  8025c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8025cb:	90                   	nop
}
  8025cc:	c9                   	leave  
  8025cd:	c3                   	ret    

008025ce <rsttst>:
void rsttst()
{
  8025ce:	55                   	push   %ebp
  8025cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 00                	push   $0x0
  8025d7:	6a 00                	push   $0x0
  8025d9:	6a 00                	push   $0x0
  8025db:	6a 28                	push   $0x28
  8025dd:	e8 44 fb ff ff       	call   802126 <syscall>
  8025e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8025e5:	90                   	nop
}
  8025e6:	c9                   	leave  
  8025e7:	c3                   	ret    

008025e8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8025e8:	55                   	push   %ebp
  8025e9:	89 e5                	mov    %esp,%ebp
  8025eb:	83 ec 04             	sub    $0x4,%esp
  8025ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8025f1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8025f4:	8b 55 18             	mov    0x18(%ebp),%edx
  8025f7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8025fb:	52                   	push   %edx
  8025fc:	50                   	push   %eax
  8025fd:	ff 75 10             	pushl  0x10(%ebp)
  802600:	ff 75 0c             	pushl  0xc(%ebp)
  802603:	ff 75 08             	pushl  0x8(%ebp)
  802606:	6a 27                	push   $0x27
  802608:	e8 19 fb ff ff       	call   802126 <syscall>
  80260d:	83 c4 18             	add    $0x18,%esp
	return ;
  802610:	90                   	nop
}
  802611:	c9                   	leave  
  802612:	c3                   	ret    

00802613 <chktst>:
void chktst(uint32 n)
{
  802613:	55                   	push   %ebp
  802614:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802616:	6a 00                	push   $0x0
  802618:	6a 00                	push   $0x0
  80261a:	6a 00                	push   $0x0
  80261c:	6a 00                	push   $0x0
  80261e:	ff 75 08             	pushl  0x8(%ebp)
  802621:	6a 29                	push   $0x29
  802623:	e8 fe fa ff ff       	call   802126 <syscall>
  802628:	83 c4 18             	add    $0x18,%esp
	return ;
  80262b:	90                   	nop
}
  80262c:	c9                   	leave  
  80262d:	c3                   	ret    

0080262e <inctst>:

void inctst()
{
  80262e:	55                   	push   %ebp
  80262f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802631:	6a 00                	push   $0x0
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	6a 00                	push   $0x0
  802639:	6a 00                	push   $0x0
  80263b:	6a 2a                	push   $0x2a
  80263d:	e8 e4 fa ff ff       	call   802126 <syscall>
  802642:	83 c4 18             	add    $0x18,%esp
	return ;
  802645:	90                   	nop
}
  802646:	c9                   	leave  
  802647:	c3                   	ret    

00802648 <gettst>:
uint32 gettst()
{
  802648:	55                   	push   %ebp
  802649:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	6a 2b                	push   $0x2b
  802657:	e8 ca fa ff ff       	call   802126 <syscall>
  80265c:	83 c4 18             	add    $0x18,%esp
}
  80265f:	c9                   	leave  
  802660:	c3                   	ret    

00802661 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802661:	55                   	push   %ebp
  802662:	89 e5                	mov    %esp,%ebp
  802664:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802667:	6a 00                	push   $0x0
  802669:	6a 00                	push   $0x0
  80266b:	6a 00                	push   $0x0
  80266d:	6a 00                	push   $0x0
  80266f:	6a 00                	push   $0x0
  802671:	6a 2c                	push   $0x2c
  802673:	e8 ae fa ff ff       	call   802126 <syscall>
  802678:	83 c4 18             	add    $0x18,%esp
  80267b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80267e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802682:	75 07                	jne    80268b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802684:	b8 01 00 00 00       	mov    $0x1,%eax
  802689:	eb 05                	jmp    802690 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80268b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802690:	c9                   	leave  
  802691:	c3                   	ret    

00802692 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802692:	55                   	push   %ebp
  802693:	89 e5                	mov    %esp,%ebp
  802695:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	6a 00                	push   $0x0
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 00                	push   $0x0
  8026a2:	6a 2c                	push   $0x2c
  8026a4:	e8 7d fa ff ff       	call   802126 <syscall>
  8026a9:	83 c4 18             	add    $0x18,%esp
  8026ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8026af:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8026b3:	75 07                	jne    8026bc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8026b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8026ba:	eb 05                	jmp    8026c1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8026bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026c1:	c9                   	leave  
  8026c2:	c3                   	ret    

008026c3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8026c3:	55                   	push   %ebp
  8026c4:	89 e5                	mov    %esp,%ebp
  8026c6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026c9:	6a 00                	push   $0x0
  8026cb:	6a 00                	push   $0x0
  8026cd:	6a 00                	push   $0x0
  8026cf:	6a 00                	push   $0x0
  8026d1:	6a 00                	push   $0x0
  8026d3:	6a 2c                	push   $0x2c
  8026d5:	e8 4c fa ff ff       	call   802126 <syscall>
  8026da:	83 c4 18             	add    $0x18,%esp
  8026dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8026e0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8026e4:	75 07                	jne    8026ed <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8026e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026eb:	eb 05                	jmp    8026f2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8026ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026f2:	c9                   	leave  
  8026f3:	c3                   	ret    

008026f4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8026f4:	55                   	push   %ebp
  8026f5:	89 e5                	mov    %esp,%ebp
  8026f7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026fa:	6a 00                	push   $0x0
  8026fc:	6a 00                	push   $0x0
  8026fe:	6a 00                	push   $0x0
  802700:	6a 00                	push   $0x0
  802702:	6a 00                	push   $0x0
  802704:	6a 2c                	push   $0x2c
  802706:	e8 1b fa ff ff       	call   802126 <syscall>
  80270b:	83 c4 18             	add    $0x18,%esp
  80270e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802711:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802715:	75 07                	jne    80271e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802717:	b8 01 00 00 00       	mov    $0x1,%eax
  80271c:	eb 05                	jmp    802723 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80271e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802723:	c9                   	leave  
  802724:	c3                   	ret    

00802725 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802725:	55                   	push   %ebp
  802726:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802728:	6a 00                	push   $0x0
  80272a:	6a 00                	push   $0x0
  80272c:	6a 00                	push   $0x0
  80272e:	6a 00                	push   $0x0
  802730:	ff 75 08             	pushl  0x8(%ebp)
  802733:	6a 2d                	push   $0x2d
  802735:	e8 ec f9 ff ff       	call   802126 <syscall>
  80273a:	83 c4 18             	add    $0x18,%esp
	return ;
  80273d:	90                   	nop
}
  80273e:	c9                   	leave  
  80273f:	c3                   	ret    

00802740 <__udivdi3>:
  802740:	55                   	push   %ebp
  802741:	57                   	push   %edi
  802742:	56                   	push   %esi
  802743:	53                   	push   %ebx
  802744:	83 ec 1c             	sub    $0x1c,%esp
  802747:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80274b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80274f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802753:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802757:	89 ca                	mov    %ecx,%edx
  802759:	89 f8                	mov    %edi,%eax
  80275b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80275f:	85 f6                	test   %esi,%esi
  802761:	75 2d                	jne    802790 <__udivdi3+0x50>
  802763:	39 cf                	cmp    %ecx,%edi
  802765:	77 65                	ja     8027cc <__udivdi3+0x8c>
  802767:	89 fd                	mov    %edi,%ebp
  802769:	85 ff                	test   %edi,%edi
  80276b:	75 0b                	jne    802778 <__udivdi3+0x38>
  80276d:	b8 01 00 00 00       	mov    $0x1,%eax
  802772:	31 d2                	xor    %edx,%edx
  802774:	f7 f7                	div    %edi
  802776:	89 c5                	mov    %eax,%ebp
  802778:	31 d2                	xor    %edx,%edx
  80277a:	89 c8                	mov    %ecx,%eax
  80277c:	f7 f5                	div    %ebp
  80277e:	89 c1                	mov    %eax,%ecx
  802780:	89 d8                	mov    %ebx,%eax
  802782:	f7 f5                	div    %ebp
  802784:	89 cf                	mov    %ecx,%edi
  802786:	89 fa                	mov    %edi,%edx
  802788:	83 c4 1c             	add    $0x1c,%esp
  80278b:	5b                   	pop    %ebx
  80278c:	5e                   	pop    %esi
  80278d:	5f                   	pop    %edi
  80278e:	5d                   	pop    %ebp
  80278f:	c3                   	ret    
  802790:	39 ce                	cmp    %ecx,%esi
  802792:	77 28                	ja     8027bc <__udivdi3+0x7c>
  802794:	0f bd fe             	bsr    %esi,%edi
  802797:	83 f7 1f             	xor    $0x1f,%edi
  80279a:	75 40                	jne    8027dc <__udivdi3+0x9c>
  80279c:	39 ce                	cmp    %ecx,%esi
  80279e:	72 0a                	jb     8027aa <__udivdi3+0x6a>
  8027a0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8027a4:	0f 87 9e 00 00 00    	ja     802848 <__udivdi3+0x108>
  8027aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8027af:	89 fa                	mov    %edi,%edx
  8027b1:	83 c4 1c             	add    $0x1c,%esp
  8027b4:	5b                   	pop    %ebx
  8027b5:	5e                   	pop    %esi
  8027b6:	5f                   	pop    %edi
  8027b7:	5d                   	pop    %ebp
  8027b8:	c3                   	ret    
  8027b9:	8d 76 00             	lea    0x0(%esi),%esi
  8027bc:	31 ff                	xor    %edi,%edi
  8027be:	31 c0                	xor    %eax,%eax
  8027c0:	89 fa                	mov    %edi,%edx
  8027c2:	83 c4 1c             	add    $0x1c,%esp
  8027c5:	5b                   	pop    %ebx
  8027c6:	5e                   	pop    %esi
  8027c7:	5f                   	pop    %edi
  8027c8:	5d                   	pop    %ebp
  8027c9:	c3                   	ret    
  8027ca:	66 90                	xchg   %ax,%ax
  8027cc:	89 d8                	mov    %ebx,%eax
  8027ce:	f7 f7                	div    %edi
  8027d0:	31 ff                	xor    %edi,%edi
  8027d2:	89 fa                	mov    %edi,%edx
  8027d4:	83 c4 1c             	add    $0x1c,%esp
  8027d7:	5b                   	pop    %ebx
  8027d8:	5e                   	pop    %esi
  8027d9:	5f                   	pop    %edi
  8027da:	5d                   	pop    %ebp
  8027db:	c3                   	ret    
  8027dc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8027e1:	89 eb                	mov    %ebp,%ebx
  8027e3:	29 fb                	sub    %edi,%ebx
  8027e5:	89 f9                	mov    %edi,%ecx
  8027e7:	d3 e6                	shl    %cl,%esi
  8027e9:	89 c5                	mov    %eax,%ebp
  8027eb:	88 d9                	mov    %bl,%cl
  8027ed:	d3 ed                	shr    %cl,%ebp
  8027ef:	89 e9                	mov    %ebp,%ecx
  8027f1:	09 f1                	or     %esi,%ecx
  8027f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8027f7:	89 f9                	mov    %edi,%ecx
  8027f9:	d3 e0                	shl    %cl,%eax
  8027fb:	89 c5                	mov    %eax,%ebp
  8027fd:	89 d6                	mov    %edx,%esi
  8027ff:	88 d9                	mov    %bl,%cl
  802801:	d3 ee                	shr    %cl,%esi
  802803:	89 f9                	mov    %edi,%ecx
  802805:	d3 e2                	shl    %cl,%edx
  802807:	8b 44 24 08          	mov    0x8(%esp),%eax
  80280b:	88 d9                	mov    %bl,%cl
  80280d:	d3 e8                	shr    %cl,%eax
  80280f:	09 c2                	or     %eax,%edx
  802811:	89 d0                	mov    %edx,%eax
  802813:	89 f2                	mov    %esi,%edx
  802815:	f7 74 24 0c          	divl   0xc(%esp)
  802819:	89 d6                	mov    %edx,%esi
  80281b:	89 c3                	mov    %eax,%ebx
  80281d:	f7 e5                	mul    %ebp
  80281f:	39 d6                	cmp    %edx,%esi
  802821:	72 19                	jb     80283c <__udivdi3+0xfc>
  802823:	74 0b                	je     802830 <__udivdi3+0xf0>
  802825:	89 d8                	mov    %ebx,%eax
  802827:	31 ff                	xor    %edi,%edi
  802829:	e9 58 ff ff ff       	jmp    802786 <__udivdi3+0x46>
  80282e:	66 90                	xchg   %ax,%ax
  802830:	8b 54 24 08          	mov    0x8(%esp),%edx
  802834:	89 f9                	mov    %edi,%ecx
  802836:	d3 e2                	shl    %cl,%edx
  802838:	39 c2                	cmp    %eax,%edx
  80283a:	73 e9                	jae    802825 <__udivdi3+0xe5>
  80283c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80283f:	31 ff                	xor    %edi,%edi
  802841:	e9 40 ff ff ff       	jmp    802786 <__udivdi3+0x46>
  802846:	66 90                	xchg   %ax,%ax
  802848:	31 c0                	xor    %eax,%eax
  80284a:	e9 37 ff ff ff       	jmp    802786 <__udivdi3+0x46>
  80284f:	90                   	nop

00802850 <__umoddi3>:
  802850:	55                   	push   %ebp
  802851:	57                   	push   %edi
  802852:	56                   	push   %esi
  802853:	53                   	push   %ebx
  802854:	83 ec 1c             	sub    $0x1c,%esp
  802857:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80285b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80285f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802863:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802867:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80286b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80286f:	89 f3                	mov    %esi,%ebx
  802871:	89 fa                	mov    %edi,%edx
  802873:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802877:	89 34 24             	mov    %esi,(%esp)
  80287a:	85 c0                	test   %eax,%eax
  80287c:	75 1a                	jne    802898 <__umoddi3+0x48>
  80287e:	39 f7                	cmp    %esi,%edi
  802880:	0f 86 a2 00 00 00    	jbe    802928 <__umoddi3+0xd8>
  802886:	89 c8                	mov    %ecx,%eax
  802888:	89 f2                	mov    %esi,%edx
  80288a:	f7 f7                	div    %edi
  80288c:	89 d0                	mov    %edx,%eax
  80288e:	31 d2                	xor    %edx,%edx
  802890:	83 c4 1c             	add    $0x1c,%esp
  802893:	5b                   	pop    %ebx
  802894:	5e                   	pop    %esi
  802895:	5f                   	pop    %edi
  802896:	5d                   	pop    %ebp
  802897:	c3                   	ret    
  802898:	39 f0                	cmp    %esi,%eax
  80289a:	0f 87 ac 00 00 00    	ja     80294c <__umoddi3+0xfc>
  8028a0:	0f bd e8             	bsr    %eax,%ebp
  8028a3:	83 f5 1f             	xor    $0x1f,%ebp
  8028a6:	0f 84 ac 00 00 00    	je     802958 <__umoddi3+0x108>
  8028ac:	bf 20 00 00 00       	mov    $0x20,%edi
  8028b1:	29 ef                	sub    %ebp,%edi
  8028b3:	89 fe                	mov    %edi,%esi
  8028b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8028b9:	89 e9                	mov    %ebp,%ecx
  8028bb:	d3 e0                	shl    %cl,%eax
  8028bd:	89 d7                	mov    %edx,%edi
  8028bf:	89 f1                	mov    %esi,%ecx
  8028c1:	d3 ef                	shr    %cl,%edi
  8028c3:	09 c7                	or     %eax,%edi
  8028c5:	89 e9                	mov    %ebp,%ecx
  8028c7:	d3 e2                	shl    %cl,%edx
  8028c9:	89 14 24             	mov    %edx,(%esp)
  8028cc:	89 d8                	mov    %ebx,%eax
  8028ce:	d3 e0                	shl    %cl,%eax
  8028d0:	89 c2                	mov    %eax,%edx
  8028d2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028d6:	d3 e0                	shl    %cl,%eax
  8028d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8028dc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028e0:	89 f1                	mov    %esi,%ecx
  8028e2:	d3 e8                	shr    %cl,%eax
  8028e4:	09 d0                	or     %edx,%eax
  8028e6:	d3 eb                	shr    %cl,%ebx
  8028e8:	89 da                	mov    %ebx,%edx
  8028ea:	f7 f7                	div    %edi
  8028ec:	89 d3                	mov    %edx,%ebx
  8028ee:	f7 24 24             	mull   (%esp)
  8028f1:	89 c6                	mov    %eax,%esi
  8028f3:	89 d1                	mov    %edx,%ecx
  8028f5:	39 d3                	cmp    %edx,%ebx
  8028f7:	0f 82 87 00 00 00    	jb     802984 <__umoddi3+0x134>
  8028fd:	0f 84 91 00 00 00    	je     802994 <__umoddi3+0x144>
  802903:	8b 54 24 04          	mov    0x4(%esp),%edx
  802907:	29 f2                	sub    %esi,%edx
  802909:	19 cb                	sbb    %ecx,%ebx
  80290b:	89 d8                	mov    %ebx,%eax
  80290d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802911:	d3 e0                	shl    %cl,%eax
  802913:	89 e9                	mov    %ebp,%ecx
  802915:	d3 ea                	shr    %cl,%edx
  802917:	09 d0                	or     %edx,%eax
  802919:	89 e9                	mov    %ebp,%ecx
  80291b:	d3 eb                	shr    %cl,%ebx
  80291d:	89 da                	mov    %ebx,%edx
  80291f:	83 c4 1c             	add    $0x1c,%esp
  802922:	5b                   	pop    %ebx
  802923:	5e                   	pop    %esi
  802924:	5f                   	pop    %edi
  802925:	5d                   	pop    %ebp
  802926:	c3                   	ret    
  802927:	90                   	nop
  802928:	89 fd                	mov    %edi,%ebp
  80292a:	85 ff                	test   %edi,%edi
  80292c:	75 0b                	jne    802939 <__umoddi3+0xe9>
  80292e:	b8 01 00 00 00       	mov    $0x1,%eax
  802933:	31 d2                	xor    %edx,%edx
  802935:	f7 f7                	div    %edi
  802937:	89 c5                	mov    %eax,%ebp
  802939:	89 f0                	mov    %esi,%eax
  80293b:	31 d2                	xor    %edx,%edx
  80293d:	f7 f5                	div    %ebp
  80293f:	89 c8                	mov    %ecx,%eax
  802941:	f7 f5                	div    %ebp
  802943:	89 d0                	mov    %edx,%eax
  802945:	e9 44 ff ff ff       	jmp    80288e <__umoddi3+0x3e>
  80294a:	66 90                	xchg   %ax,%ax
  80294c:	89 c8                	mov    %ecx,%eax
  80294e:	89 f2                	mov    %esi,%edx
  802950:	83 c4 1c             	add    $0x1c,%esp
  802953:	5b                   	pop    %ebx
  802954:	5e                   	pop    %esi
  802955:	5f                   	pop    %edi
  802956:	5d                   	pop    %ebp
  802957:	c3                   	ret    
  802958:	3b 04 24             	cmp    (%esp),%eax
  80295b:	72 06                	jb     802963 <__umoddi3+0x113>
  80295d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802961:	77 0f                	ja     802972 <__umoddi3+0x122>
  802963:	89 f2                	mov    %esi,%edx
  802965:	29 f9                	sub    %edi,%ecx
  802967:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80296b:	89 14 24             	mov    %edx,(%esp)
  80296e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802972:	8b 44 24 04          	mov    0x4(%esp),%eax
  802976:	8b 14 24             	mov    (%esp),%edx
  802979:	83 c4 1c             	add    $0x1c,%esp
  80297c:	5b                   	pop    %ebx
  80297d:	5e                   	pop    %esi
  80297e:	5f                   	pop    %edi
  80297f:	5d                   	pop    %ebp
  802980:	c3                   	ret    
  802981:	8d 76 00             	lea    0x0(%esi),%esi
  802984:	2b 04 24             	sub    (%esp),%eax
  802987:	19 fa                	sbb    %edi,%edx
  802989:	89 d1                	mov    %edx,%ecx
  80298b:	89 c6                	mov    %eax,%esi
  80298d:	e9 71 ff ff ff       	jmp    802903 <__umoddi3+0xb3>
  802992:	66 90                	xchg   %ax,%ax
  802994:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802998:	72 ea                	jb     802984 <__umoddi3+0x134>
  80299a:	89 d9                	mov    %ebx,%ecx
  80299c:	e9 62 ff ff ff       	jmp    802903 <__umoddi3+0xb3>
