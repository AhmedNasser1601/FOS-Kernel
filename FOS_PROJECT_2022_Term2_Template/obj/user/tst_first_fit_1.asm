
obj/user/tst_first_fit_1:     file format elf32-i386


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
  800031:	e8 b4 0b 00 00       	call   800bea <libmain>
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
  800045:	e8 8e 23 00 00       	call   8023d8 <sys_set_uheap_strategy>
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
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

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
  80009b:	68 60 26 80 00       	push   $0x802660
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 7c 26 80 00       	push   $0x80267c
  8000a7:	e8 4d 0c 00 00       	call   800cf9 <_panic>
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
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cb:	e8 75 1e 00 00       	call   801f45 <sys_calculate_free_frames>
  8000d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d3:	e8 f0 1e 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  8000db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000de:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e1:	83 ec 0c             	sub    $0xc,%esp
  8000e4:	50                   	push   %eax
  8000e5:	e8 4d 1c 00 00       	call   801d37 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f8:	74 14                	je     80010e <_main+0xd6>
  8000fa:	83 ec 04             	sub    $0x4,%esp
  8000fd:	68 94 26 80 00       	push   $0x802694
  800102:	6a 23                	push   $0x23
  800104:	68 7c 26 80 00       	push   $0x80267c
  800109:	e8 eb 0b 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80010e:	e8 b5 1e 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800113:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800116:	3d 00 01 00 00       	cmp    $0x100,%eax
  80011b:	74 14                	je     800131 <_main+0xf9>
  80011d:	83 ec 04             	sub    $0x4,%esp
  800120:	68 c4 26 80 00       	push   $0x8026c4
  800125:	6a 25                	push   $0x25
  800127:	68 7c 26 80 00       	push   $0x80267c
  80012c:	e8 c8 0b 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800131:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800134:	e8 0c 1e 00 00       	call   801f45 <sys_calculate_free_frames>
  800139:	29 c3                	sub    %eax,%ebx
  80013b:	89 d8                	mov    %ebx,%eax
  80013d:	83 f8 01             	cmp    $0x1,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 e1 26 80 00       	push   $0x8026e1
  80014a:	6a 26                	push   $0x26
  80014c:	68 7c 26 80 00       	push   $0x80267c
  800151:	e8 a3 0b 00 00       	call   800cf9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800156:	e8 ea 1d 00 00       	call   801f45 <sys_calculate_free_frames>
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80015e:	e8 65 1e 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800163:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800166:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800169:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80016c:	83 ec 0c             	sub    $0xc,%esp
  80016f:	50                   	push   %eax
  800170:	e8 c2 1b 00 00       	call   801d37 <malloc>
  800175:	83 c4 10             	add    $0x10,%esp
  800178:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80017b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80017e:	89 c2                	mov    %eax,%edx
  800180:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800183:	05 00 00 00 80       	add    $0x80000000,%eax
  800188:	39 c2                	cmp    %eax,%edx
  80018a:	74 14                	je     8001a0 <_main+0x168>
  80018c:	83 ec 04             	sub    $0x4,%esp
  80018f:	68 94 26 80 00       	push   $0x802694
  800194:	6a 2c                	push   $0x2c
  800196:	68 7c 26 80 00       	push   $0x80267c
  80019b:	e8 59 0b 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a0:	e8 23 1e 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8001a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001ad:	74 14                	je     8001c3 <_main+0x18b>
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	68 c4 26 80 00       	push   $0x8026c4
  8001b7:	6a 2e                	push   $0x2e
  8001b9:	68 7c 26 80 00       	push   $0x80267c
  8001be:	e8 36 0b 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8001c3:	e8 7d 1d 00 00       	call   801f45 <sys_calculate_free_frames>
  8001c8:	89 c2                	mov    %eax,%edx
  8001ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cd:	39 c2                	cmp    %eax,%edx
  8001cf:	74 14                	je     8001e5 <_main+0x1ad>
  8001d1:	83 ec 04             	sub    $0x4,%esp
  8001d4:	68 e1 26 80 00       	push   $0x8026e1
  8001d9:	6a 2f                	push   $0x2f
  8001db:	68 7c 26 80 00       	push   $0x80267c
  8001e0:	e8 14 0b 00 00       	call   800cf9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001e5:	e8 5b 1d 00 00       	call   801f45 <sys_calculate_free_frames>
  8001ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001ed:	e8 d6 1d 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8001f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001f8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001fb:	83 ec 0c             	sub    $0xc,%esp
  8001fe:	50                   	push   %eax
  8001ff:	e8 33 1b 00 00       	call   801d37 <malloc>
  800204:	83 c4 10             	add    $0x10,%esp
  800207:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  80020a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80020d:	89 c2                	mov    %eax,%edx
  80020f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800212:	01 c0                	add    %eax,%eax
  800214:	05 00 00 00 80       	add    $0x80000000,%eax
  800219:	39 c2                	cmp    %eax,%edx
  80021b:	74 14                	je     800231 <_main+0x1f9>
  80021d:	83 ec 04             	sub    $0x4,%esp
  800220:	68 94 26 80 00       	push   $0x802694
  800225:	6a 35                	push   $0x35
  800227:	68 7c 26 80 00       	push   $0x80267c
  80022c:	e8 c8 0a 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800231:	e8 92 1d 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800236:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800239:	3d 00 01 00 00       	cmp    $0x100,%eax
  80023e:	74 14                	je     800254 <_main+0x21c>
  800240:	83 ec 04             	sub    $0x4,%esp
  800243:	68 c4 26 80 00       	push   $0x8026c4
  800248:	6a 37                	push   $0x37
  80024a:	68 7c 26 80 00       	push   $0x80267c
  80024f:	e8 a5 0a 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800254:	e8 ec 1c 00 00       	call   801f45 <sys_calculate_free_frames>
  800259:	89 c2                	mov    %eax,%edx
  80025b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025e:	39 c2                	cmp    %eax,%edx
  800260:	74 14                	je     800276 <_main+0x23e>
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	68 e1 26 80 00       	push   $0x8026e1
  80026a:	6a 38                	push   $0x38
  80026c:	68 7c 26 80 00       	push   $0x80267c
  800271:	e8 83 0a 00 00       	call   800cf9 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800276:	e8 ca 1c 00 00       	call   801f45 <sys_calculate_free_frames>
  80027b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80027e:	e8 45 1d 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800283:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800286:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800289:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	50                   	push   %eax
  800290:	e8 a2 1a 00 00       	call   801d37 <malloc>
  800295:	83 c4 10             	add    $0x10,%esp
  800298:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  80029b:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80029e:	89 c1                	mov    %eax,%ecx
  8002a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a3:	89 c2                	mov    %eax,%edx
  8002a5:	01 d2                	add    %edx,%edx
  8002a7:	01 d0                	add    %edx,%eax
  8002a9:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ae:	39 c1                	cmp    %eax,%ecx
  8002b0:	74 14                	je     8002c6 <_main+0x28e>
  8002b2:	83 ec 04             	sub    $0x4,%esp
  8002b5:	68 94 26 80 00       	push   $0x802694
  8002ba:	6a 3e                	push   $0x3e
  8002bc:	68 7c 26 80 00       	push   $0x80267c
  8002c1:	e8 33 0a 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002c6:	e8 fd 1c 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8002cb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002ce:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002d3:	74 14                	je     8002e9 <_main+0x2b1>
  8002d5:	83 ec 04             	sub    $0x4,%esp
  8002d8:	68 c4 26 80 00       	push   $0x8026c4
  8002dd:	6a 40                	push   $0x40
  8002df:	68 7c 26 80 00       	push   $0x80267c
  8002e4:	e8 10 0a 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002e9:	e8 57 1c 00 00       	call   801f45 <sys_calculate_free_frames>
  8002ee:	89 c2                	mov    %eax,%edx
  8002f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002f3:	39 c2                	cmp    %eax,%edx
  8002f5:	74 14                	je     80030b <_main+0x2d3>
  8002f7:	83 ec 04             	sub    $0x4,%esp
  8002fa:	68 e1 26 80 00       	push   $0x8026e1
  8002ff:	6a 41                	push   $0x41
  800301:	68 7c 26 80 00       	push   $0x80267c
  800306:	e8 ee 09 00 00       	call   800cf9 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80030b:	e8 35 1c 00 00       	call   801f45 <sys_calculate_free_frames>
  800310:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800313:	e8 b0 1c 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800318:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80031b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80031e:	01 c0                	add    %eax,%eax
  800320:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	50                   	push   %eax
  800327:	e8 0b 1a 00 00       	call   801d37 <malloc>
  80032c:	83 c4 10             	add    $0x10,%esp
  80032f:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800332:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800335:	89 c2                	mov    %eax,%edx
  800337:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033a:	c1 e0 02             	shl    $0x2,%eax
  80033d:	05 00 00 00 80       	add    $0x80000000,%eax
  800342:	39 c2                	cmp    %eax,%edx
  800344:	74 14                	je     80035a <_main+0x322>
  800346:	83 ec 04             	sub    $0x4,%esp
  800349:	68 94 26 80 00       	push   $0x802694
  80034e:	6a 47                	push   $0x47
  800350:	68 7c 26 80 00       	push   $0x80267c
  800355:	e8 9f 09 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80035a:	e8 69 1c 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80035f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800362:	3d 00 02 00 00       	cmp    $0x200,%eax
  800367:	74 14                	je     80037d <_main+0x345>
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	68 c4 26 80 00       	push   $0x8026c4
  800371:	6a 49                	push   $0x49
  800373:	68 7c 26 80 00       	push   $0x80267c
  800378:	e8 7c 09 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80037d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800380:	e8 c0 1b 00 00       	call   801f45 <sys_calculate_free_frames>
  800385:	29 c3                	sub    %eax,%ebx
  800387:	89 d8                	mov    %ebx,%eax
  800389:	83 f8 01             	cmp    $0x1,%eax
  80038c:	74 14                	je     8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 e1 26 80 00       	push   $0x8026e1
  800396:	6a 4a                	push   $0x4a
  800398:	68 7c 26 80 00       	push   $0x80267c
  80039d:	e8 57 09 00 00       	call   800cf9 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003a2:	e8 9e 1b 00 00       	call   801f45 <sys_calculate_free_frames>
  8003a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003aa:	e8 19 1c 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8003af:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  8003b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b5:	01 c0                	add    %eax,%eax
  8003b7:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003ba:	83 ec 0c             	sub    $0xc,%esp
  8003bd:	50                   	push   %eax
  8003be:	e8 74 19 00 00       	call   801d37 <malloc>
  8003c3:	83 c4 10             	add    $0x10,%esp
  8003c6:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  8003c9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003cc:	89 c1                	mov    %eax,%ecx
  8003ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003d1:	89 d0                	mov    %edx,%eax
  8003d3:	01 c0                	add    %eax,%eax
  8003d5:	01 d0                	add    %edx,%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	05 00 00 00 80       	add    $0x80000000,%eax
  8003de:	39 c1                	cmp    %eax,%ecx
  8003e0:	74 14                	je     8003f6 <_main+0x3be>
  8003e2:	83 ec 04             	sub    $0x4,%esp
  8003e5:	68 94 26 80 00       	push   $0x802694
  8003ea:	6a 50                	push   $0x50
  8003ec:	68 7c 26 80 00       	push   $0x80267c
  8003f1:	e8 03 09 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8003f6:	e8 cd 1b 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8003fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003fe:	3d 00 02 00 00       	cmp    $0x200,%eax
  800403:	74 14                	je     800419 <_main+0x3e1>
  800405:	83 ec 04             	sub    $0x4,%esp
  800408:	68 c4 26 80 00       	push   $0x8026c4
  80040d:	6a 52                	push   $0x52
  80040f:	68 7c 26 80 00       	push   $0x80267c
  800414:	e8 e0 08 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800419:	e8 27 1b 00 00       	call   801f45 <sys_calculate_free_frames>
  80041e:	89 c2                	mov    %eax,%edx
  800420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800423:	39 c2                	cmp    %eax,%edx
  800425:	74 14                	je     80043b <_main+0x403>
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	68 e1 26 80 00       	push   $0x8026e1
  80042f:	6a 53                	push   $0x53
  800431:	68 7c 26 80 00       	push   $0x80267c
  800436:	e8 be 08 00 00       	call   800cf9 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80043b:	e8 05 1b 00 00       	call   801f45 <sys_calculate_free_frames>
  800440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800443:	e8 80 1b 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800448:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  80044b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80044e:	89 c2                	mov    %eax,%edx
  800450:	01 d2                	add    %edx,%edx
  800452:	01 d0                	add    %edx,%eax
  800454:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800457:	83 ec 0c             	sub    $0xc,%esp
  80045a:	50                   	push   %eax
  80045b:	e8 d7 18 00 00       	call   801d37 <malloc>
  800460:	83 c4 10             	add    $0x10,%esp
  800463:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800466:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800469:	89 c2                	mov    %eax,%edx
  80046b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046e:	c1 e0 03             	shl    $0x3,%eax
  800471:	05 00 00 00 80       	add    $0x80000000,%eax
  800476:	39 c2                	cmp    %eax,%edx
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 94 26 80 00       	push   $0x802694
  800482:	6a 59                	push   $0x59
  800484:	68 7c 26 80 00       	push   $0x80267c
  800489:	e8 6b 08 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80048e:	e8 35 1b 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800493:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800496:	3d 00 03 00 00       	cmp    $0x300,%eax
  80049b:	74 14                	je     8004b1 <_main+0x479>
  80049d:	83 ec 04             	sub    $0x4,%esp
  8004a0:	68 c4 26 80 00       	push   $0x8026c4
  8004a5:	6a 5b                	push   $0x5b
  8004a7:	68 7c 26 80 00       	push   $0x80267c
  8004ac:	e8 48 08 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004b1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004b4:	e8 8c 1a 00 00       	call   801f45 <sys_calculate_free_frames>
  8004b9:	29 c3                	sub    %eax,%ebx
  8004bb:	89 d8                	mov    %ebx,%eax
  8004bd:	83 f8 01             	cmp    $0x1,%eax
  8004c0:	74 14                	je     8004d6 <_main+0x49e>
  8004c2:	83 ec 04             	sub    $0x4,%esp
  8004c5:	68 e1 26 80 00       	push   $0x8026e1
  8004ca:	6a 5c                	push   $0x5c
  8004cc:	68 7c 26 80 00       	push   $0x80267c
  8004d1:	e8 23 08 00 00       	call   800cf9 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004d6:	e8 6a 1a 00 00       	call   801f45 <sys_calculate_free_frames>
  8004db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004de:	e8 e5 1a 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8004e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  8004e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004e9:	89 c2                	mov    %eax,%edx
  8004eb:	01 d2                	add    %edx,%edx
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	50                   	push   %eax
  8004f6:	e8 3c 18 00 00       	call   801d37 <malloc>
  8004fb:	83 c4 10             	add    $0x10,%esp
  8004fe:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  800501:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800504:	89 c1                	mov    %eax,%ecx
  800506:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800509:	89 d0                	mov    %edx,%eax
  80050b:	c1 e0 02             	shl    $0x2,%eax
  80050e:	01 d0                	add    %edx,%eax
  800510:	01 c0                	add    %eax,%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	05 00 00 00 80       	add    $0x80000000,%eax
  800519:	39 c1                	cmp    %eax,%ecx
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 94 26 80 00       	push   $0x802694
  800525:	6a 62                	push   $0x62
  800527:	68 7c 26 80 00       	push   $0x80267c
  80052c:	e8 c8 07 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  800531:	e8 92 1a 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800536:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800539:	3d 00 03 00 00       	cmp    $0x300,%eax
  80053e:	74 14                	je     800554 <_main+0x51c>
  800540:	83 ec 04             	sub    $0x4,%esp
  800543:	68 c4 26 80 00       	push   $0x8026c4
  800548:	6a 64                	push   $0x64
  80054a:	68 7c 26 80 00       	push   $0x80267c
  80054f:	e8 a5 07 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800554:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800557:	e8 e9 19 00 00       	call   801f45 <sys_calculate_free_frames>
  80055c:	29 c3                	sub    %eax,%ebx
  80055e:	89 d8                	mov    %ebx,%eax
  800560:	83 f8 01             	cmp    $0x1,%eax
  800563:	74 14                	je     800579 <_main+0x541>
  800565:	83 ec 04             	sub    $0x4,%esp
  800568:	68 e1 26 80 00       	push   $0x8026e1
  80056d:	6a 65                	push   $0x65
  80056f:	68 7c 26 80 00       	push   $0x80267c
  800574:	e8 80 07 00 00       	call   800cf9 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800579:	e8 c7 19 00 00       	call   801f45 <sys_calculate_free_frames>
  80057e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800581:	e8 42 1a 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800586:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800589:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	50                   	push   %eax
  800590:	e8 f6 17 00 00       	call   801d8b <free>
  800595:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800598:	e8 2b 1a 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80059d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a0:	29 c2                	sub    %eax,%edx
  8005a2:	89 d0                	mov    %edx,%eax
  8005a4:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005a9:	74 14                	je     8005bf <_main+0x587>
  8005ab:	83 ec 04             	sub    $0x4,%esp
  8005ae:	68 f4 26 80 00       	push   $0x8026f4
  8005b3:	6a 6f                	push   $0x6f
  8005b5:	68 7c 26 80 00       	push   $0x80267c
  8005ba:	e8 3a 07 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005bf:	e8 81 19 00 00       	call   801f45 <sys_calculate_free_frames>
  8005c4:	89 c2                	mov    %eax,%edx
  8005c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005c9:	39 c2                	cmp    %eax,%edx
  8005cb:	74 14                	je     8005e1 <_main+0x5a9>
  8005cd:	83 ec 04             	sub    $0x4,%esp
  8005d0:	68 0b 27 80 00       	push   $0x80270b
  8005d5:	6a 70                	push   $0x70
  8005d7:	68 7c 26 80 00       	push   $0x80267c
  8005dc:	e8 18 07 00 00       	call   800cf9 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e1:	e8 5f 19 00 00       	call   801f45 <sys_calculate_free_frames>
  8005e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005e9:	e8 da 19 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8005ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  8005f1:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8005f4:	83 ec 0c             	sub    $0xc,%esp
  8005f7:	50                   	push   %eax
  8005f8:	e8 8e 17 00 00       	call   801d8b <free>
  8005fd:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  800600:	e8 c3 19 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800605:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800608:	29 c2                	sub    %eax,%edx
  80060a:	89 d0                	mov    %edx,%eax
  80060c:	3d 00 02 00 00       	cmp    $0x200,%eax
  800611:	74 14                	je     800627 <_main+0x5ef>
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 f4 26 80 00       	push   $0x8026f4
  80061b:	6a 77                	push   $0x77
  80061d:	68 7c 26 80 00       	push   $0x80267c
  800622:	e8 d2 06 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800627:	e8 19 19 00 00       	call   801f45 <sys_calculate_free_frames>
  80062c:	89 c2                	mov    %eax,%edx
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	39 c2                	cmp    %eax,%edx
  800633:	74 14                	je     800649 <_main+0x611>
  800635:	83 ec 04             	sub    $0x4,%esp
  800638:	68 0b 27 80 00       	push   $0x80270b
  80063d:	6a 78                	push   $0x78
  80063f:	68 7c 26 80 00       	push   $0x80267c
  800644:	e8 b0 06 00 00       	call   800cf9 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800649:	e8 f7 18 00 00       	call   801f45 <sys_calculate_free_frames>
  80064e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800651:	e8 72 19 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800656:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  800659:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80065c:	83 ec 0c             	sub    $0xc,%esp
  80065f:	50                   	push   %eax
  800660:	e8 26 17 00 00       	call   801d8b <free>
  800665:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800668:	e8 5b 19 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80066d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800670:	29 c2                	sub    %eax,%edx
  800672:	89 d0                	mov    %edx,%eax
  800674:	3d 00 03 00 00       	cmp    $0x300,%eax
  800679:	74 14                	je     80068f <_main+0x657>
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	68 f4 26 80 00       	push   $0x8026f4
  800683:	6a 7f                	push   $0x7f
  800685:	68 7c 26 80 00       	push   $0x80267c
  80068a:	e8 6a 06 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80068f:	e8 b1 18 00 00       	call   801f45 <sys_calculate_free_frames>
  800694:	89 c2                	mov    %eax,%edx
  800696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800699:	39 c2                	cmp    %eax,%edx
  80069b:	74 17                	je     8006b4 <_main+0x67c>
  80069d:	83 ec 04             	sub    $0x4,%esp
  8006a0:	68 0b 27 80 00       	push   $0x80270b
  8006a5:	68 80 00 00 00       	push   $0x80
  8006aa:	68 7c 26 80 00       	push   $0x80267c
  8006af:	e8 45 06 00 00       	call   800cf9 <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006b4:	e8 8c 18 00 00       	call   801f45 <sys_calculate_free_frames>
  8006b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bc:	e8 07 19 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8006c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006c4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006c7:	89 d0                	mov    %edx,%eax
  8006c9:	c1 e0 09             	shl    $0x9,%eax
  8006cc:	29 d0                	sub    %edx,%eax
  8006ce:	83 ec 0c             	sub    $0xc,%esp
  8006d1:	50                   	push   %eax
  8006d2:	e8 60 16 00 00       	call   801d37 <malloc>
  8006d7:	83 c4 10             	add    $0x10,%esp
  8006da:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006dd:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006e0:	89 c2                	mov    %eax,%edx
  8006e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006e5:	05 00 00 00 80       	add    $0x80000000,%eax
  8006ea:	39 c2                	cmp    %eax,%edx
  8006ec:	74 17                	je     800705 <_main+0x6cd>
  8006ee:	83 ec 04             	sub    $0x4,%esp
  8006f1:	68 94 26 80 00       	push   $0x802694
  8006f6:	68 89 00 00 00       	push   $0x89
  8006fb:	68 7c 26 80 00       	push   $0x80267c
  800700:	e8 f4 05 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800705:	e8 be 18 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80070a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80070d:	3d 80 00 00 00       	cmp    $0x80,%eax
  800712:	74 17                	je     80072b <_main+0x6f3>
  800714:	83 ec 04             	sub    $0x4,%esp
  800717:	68 c4 26 80 00       	push   $0x8026c4
  80071c:	68 8b 00 00 00       	push   $0x8b
  800721:	68 7c 26 80 00       	push   $0x80267c
  800726:	e8 ce 05 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80072b:	e8 15 18 00 00       	call   801f45 <sys_calculate_free_frames>
  800730:	89 c2                	mov    %eax,%edx
  800732:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800735:	39 c2                	cmp    %eax,%edx
  800737:	74 17                	je     800750 <_main+0x718>
  800739:	83 ec 04             	sub    $0x4,%esp
  80073c:	68 e1 26 80 00       	push   $0x8026e1
  800741:	68 8c 00 00 00       	push   $0x8c
  800746:	68 7c 26 80 00       	push   $0x80267c
  80074b:	e8 a9 05 00 00       	call   800cf9 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800750:	e8 f0 17 00 00       	call   801f45 <sys_calculate_free_frames>
  800755:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800758:	e8 6b 18 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80075d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800760:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800763:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800766:	83 ec 0c             	sub    $0xc,%esp
  800769:	50                   	push   %eax
  80076a:	e8 c8 15 00 00       	call   801d37 <malloc>
  80076f:	83 c4 10             	add    $0x10,%esp
  800772:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800775:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800778:	89 c2                	mov    %eax,%edx
  80077a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077d:	c1 e0 02             	shl    $0x2,%eax
  800780:	05 00 00 00 80       	add    $0x80000000,%eax
  800785:	39 c2                	cmp    %eax,%edx
  800787:	74 17                	je     8007a0 <_main+0x768>
  800789:	83 ec 04             	sub    $0x4,%esp
  80078c:	68 94 26 80 00       	push   $0x802694
  800791:	68 92 00 00 00       	push   $0x92
  800796:	68 7c 26 80 00       	push   $0x80267c
  80079b:	e8 59 05 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007a0:	e8 23 18 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8007a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007a8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007ad:	74 17                	je     8007c6 <_main+0x78e>
  8007af:	83 ec 04             	sub    $0x4,%esp
  8007b2:	68 c4 26 80 00       	push   $0x8026c4
  8007b7:	68 94 00 00 00       	push   $0x94
  8007bc:	68 7c 26 80 00       	push   $0x80267c
  8007c1:	e8 33 05 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007c6:	e8 7a 17 00 00       	call   801f45 <sys_calculate_free_frames>
  8007cb:	89 c2                	mov    %eax,%edx
  8007cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007d0:	39 c2                	cmp    %eax,%edx
  8007d2:	74 17                	je     8007eb <_main+0x7b3>
  8007d4:	83 ec 04             	sub    $0x4,%esp
  8007d7:	68 e1 26 80 00       	push   $0x8026e1
  8007dc:	68 95 00 00 00       	push   $0x95
  8007e1:	68 7c 26 80 00       	push   $0x80267c
  8007e6:	e8 0e 05 00 00       	call   800cf9 <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007eb:	e8 55 17 00 00       	call   801f45 <sys_calculate_free_frames>
  8007f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8007f3:	e8 d0 17 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8007f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  8007fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007fe:	89 d0                	mov    %edx,%eax
  800800:	c1 e0 08             	shl    $0x8,%eax
  800803:	29 d0                	sub    %edx,%eax
  800805:	83 ec 0c             	sub    $0xc,%esp
  800808:	50                   	push   %eax
  800809:	e8 29 15 00 00       	call   801d37 <malloc>
  80080e:	83 c4 10             	add    $0x10,%esp
  800811:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800814:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800817:	89 c2                	mov    %eax,%edx
  800819:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081c:	c1 e0 09             	shl    $0x9,%eax
  80081f:	89 c1                	mov    %eax,%ecx
  800821:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800824:	01 c8                	add    %ecx,%eax
  800826:	05 00 00 00 80       	add    $0x80000000,%eax
  80082b:	39 c2                	cmp    %eax,%edx
  80082d:	74 17                	je     800846 <_main+0x80e>
  80082f:	83 ec 04             	sub    $0x4,%esp
  800832:	68 94 26 80 00       	push   $0x802694
  800837:	68 9b 00 00 00       	push   $0x9b
  80083c:	68 7c 26 80 00       	push   $0x80267c
  800841:	e8 b3 04 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800846:	e8 7d 17 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80084b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80084e:	83 f8 40             	cmp    $0x40,%eax
  800851:	74 17                	je     80086a <_main+0x832>
  800853:	83 ec 04             	sub    $0x4,%esp
  800856:	68 c4 26 80 00       	push   $0x8026c4
  80085b:	68 9d 00 00 00       	push   $0x9d
  800860:	68 7c 26 80 00       	push   $0x80267c
  800865:	e8 8f 04 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80086a:	e8 d6 16 00 00       	call   801f45 <sys_calculate_free_frames>
  80086f:	89 c2                	mov    %eax,%edx
  800871:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800874:	39 c2                	cmp    %eax,%edx
  800876:	74 17                	je     80088f <_main+0x857>
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	68 e1 26 80 00       	push   $0x8026e1
  800880:	68 9e 00 00 00       	push   $0x9e
  800885:	68 7c 26 80 00       	push   $0x80267c
  80088a:	e8 6a 04 00 00       	call   800cf9 <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80088f:	e8 b1 16 00 00       	call   801f45 <sys_calculate_free_frames>
  800894:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800897:	e8 2c 17 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80089c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  80089f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a2:	01 c0                	add    %eax,%eax
  8008a4:	83 ec 0c             	sub    $0xc,%esp
  8008a7:	50                   	push   %eax
  8008a8:	e8 8a 14 00 00       	call   801d37 <malloc>
  8008ad:	83 c4 10             	add    $0x10,%esp
  8008b0:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008b3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008b6:	89 c2                	mov    %eax,%edx
  8008b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008bb:	c1 e0 03             	shl    $0x3,%eax
  8008be:	05 00 00 00 80       	add    $0x80000000,%eax
  8008c3:	39 c2                	cmp    %eax,%edx
  8008c5:	74 17                	je     8008de <_main+0x8a6>
  8008c7:	83 ec 04             	sub    $0x4,%esp
  8008ca:	68 94 26 80 00       	push   $0x802694
  8008cf:	68 a4 00 00 00       	push   $0xa4
  8008d4:	68 7c 26 80 00       	push   $0x80267c
  8008d9:	e8 1b 04 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008de:	e8 e5 16 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8008e3:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e6:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008eb:	74 17                	je     800904 <_main+0x8cc>
  8008ed:	83 ec 04             	sub    $0x4,%esp
  8008f0:	68 c4 26 80 00       	push   $0x8026c4
  8008f5:	68 a6 00 00 00       	push   $0xa6
  8008fa:	68 7c 26 80 00       	push   $0x80267c
  8008ff:	e8 f5 03 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800904:	e8 3c 16 00 00       	call   801f45 <sys_calculate_free_frames>
  800909:	89 c2                	mov    %eax,%edx
  80090b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80090e:	39 c2                	cmp    %eax,%edx
  800910:	74 17                	je     800929 <_main+0x8f1>
  800912:	83 ec 04             	sub    $0x4,%esp
  800915:	68 e1 26 80 00       	push   $0x8026e1
  80091a:	68 a7 00 00 00       	push   $0xa7
  80091f:	68 7c 26 80 00       	push   $0x80267c
  800924:	e8 d0 03 00 00       	call   800cf9 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800929:	e8 17 16 00 00       	call   801f45 <sys_calculate_free_frames>
  80092e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800931:	e8 92 16 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800936:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800939:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80093c:	c1 e0 02             	shl    $0x2,%eax
  80093f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800942:	83 ec 0c             	sub    $0xc,%esp
  800945:	50                   	push   %eax
  800946:	e8 ec 13 00 00       	call   801d37 <malloc>
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  800951:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800954:	89 c1                	mov    %eax,%ecx
  800956:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800959:	89 d0                	mov    %edx,%eax
  80095b:	01 c0                	add    %eax,%eax
  80095d:	01 d0                	add    %edx,%eax
  80095f:	01 c0                	add    %eax,%eax
  800961:	01 d0                	add    %edx,%eax
  800963:	01 c0                	add    %eax,%eax
  800965:	05 00 00 00 80       	add    $0x80000000,%eax
  80096a:	39 c1                	cmp    %eax,%ecx
  80096c:	74 17                	je     800985 <_main+0x94d>
  80096e:	83 ec 04             	sub    $0x4,%esp
  800971:	68 94 26 80 00       	push   $0x802694
  800976:	68 ad 00 00 00       	push   $0xad
  80097b:	68 7c 26 80 00       	push   $0x80267c
  800980:	e8 74 03 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800985:	e8 3e 16 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  80098a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80098d:	3d 00 04 00 00       	cmp    $0x400,%eax
  800992:	74 17                	je     8009ab <_main+0x973>
  800994:	83 ec 04             	sub    $0x4,%esp
  800997:	68 c4 26 80 00       	push   $0x8026c4
  80099c:	68 af 00 00 00       	push   $0xaf
  8009a1:	68 7c 26 80 00       	push   $0x80267c
  8009a6:	e8 4e 03 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8009ab:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8009ae:	e8 92 15 00 00       	call   801f45 <sys_calculate_free_frames>
  8009b3:	29 c3                	sub    %eax,%ebx
  8009b5:	89 d8                	mov    %ebx,%eax
  8009b7:	83 f8 01             	cmp    $0x1,%eax
  8009ba:	74 17                	je     8009d3 <_main+0x99b>
  8009bc:	83 ec 04             	sub    $0x4,%esp
  8009bf:	68 e1 26 80 00       	push   $0x8026e1
  8009c4:	68 b0 00 00 00       	push   $0xb0
  8009c9:	68 7c 26 80 00       	push   $0x80267c
  8009ce:	e8 26 03 00 00       	call   800cf9 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009d3:	e8 6d 15 00 00       	call   801f45 <sys_calculate_free_frames>
  8009d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009db:	e8 e8 15 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8009e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8009e3:	8b 45 98             	mov    -0x68(%ebp),%eax
  8009e6:	83 ec 0c             	sub    $0xc,%esp
  8009e9:	50                   	push   %eax
  8009ea:	e8 9c 13 00 00       	call   801d8b <free>
  8009ef:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009f2:	e8 d1 15 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  8009f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009fa:	29 c2                	sub    %eax,%edx
  8009fc:	89 d0                	mov    %edx,%eax
  8009fe:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a03:	74 17                	je     800a1c <_main+0x9e4>
  800a05:	83 ec 04             	sub    $0x4,%esp
  800a08:	68 f4 26 80 00       	push   $0x8026f4
  800a0d:	68 ba 00 00 00       	push   $0xba
  800a12:	68 7c 26 80 00       	push   $0x80267c
  800a17:	e8 dd 02 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1c:	e8 24 15 00 00       	call   801f45 <sys_calculate_free_frames>
  800a21:	89 c2                	mov    %eax,%edx
  800a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a26:	39 c2                	cmp    %eax,%edx
  800a28:	74 17                	je     800a41 <_main+0xa09>
  800a2a:	83 ec 04             	sub    $0x4,%esp
  800a2d:	68 0b 27 80 00       	push   $0x80270b
  800a32:	68 bb 00 00 00       	push   $0xbb
  800a37:	68 7c 26 80 00       	push   $0x80267c
  800a3c:	e8 b8 02 00 00       	call   800cf9 <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a41:	e8 ff 14 00 00       	call   801f45 <sys_calculate_free_frames>
  800a46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a49:	e8 7a 15 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800a4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[9]);
  800a51:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800a54:	83 ec 0c             	sub    $0xc,%esp
  800a57:	50                   	push   %eax
  800a58:	e8 2e 13 00 00       	call   801d8b <free>
  800a5d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a60:	e8 63 15 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800a65:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a68:	29 c2                	sub    %eax,%edx
  800a6a:	89 d0                	mov    %edx,%eax
  800a6c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a71:	74 17                	je     800a8a <_main+0xa52>
  800a73:	83 ec 04             	sub    $0x4,%esp
  800a76:	68 f4 26 80 00       	push   $0x8026f4
  800a7b:	68 c2 00 00 00       	push   $0xc2
  800a80:	68 7c 26 80 00       	push   $0x80267c
  800a85:	e8 6f 02 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a8a:	e8 b6 14 00 00       	call   801f45 <sys_calculate_free_frames>
  800a8f:	89 c2                	mov    %eax,%edx
  800a91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a94:	39 c2                	cmp    %eax,%edx
  800a96:	74 17                	je     800aaf <_main+0xa77>
  800a98:	83 ec 04             	sub    $0x4,%esp
  800a9b:	68 0b 27 80 00       	push   $0x80270b
  800aa0:	68 c3 00 00 00       	push   $0xc3
  800aa5:	68 7c 26 80 00       	push   $0x80267c
  800aaa:	e8 4a 02 00 00       	call   800cf9 <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800aaf:	e8 91 14 00 00       	call   801f45 <sys_calculate_free_frames>
  800ab4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab7:	e8 0c 15 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800abc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800abf:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800ac2:	83 ec 0c             	sub    $0xc,%esp
  800ac5:	50                   	push   %eax
  800ac6:	e8 c0 12 00 00       	call   801d8b <free>
  800acb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ace:	e8 f5 14 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800ad3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ad6:	29 c2                	sub    %eax,%edx
  800ad8:	89 d0                	mov    %edx,%eax
  800ada:	3d 00 01 00 00       	cmp    $0x100,%eax
  800adf:	74 17                	je     800af8 <_main+0xac0>
  800ae1:	83 ec 04             	sub    $0x4,%esp
  800ae4:	68 f4 26 80 00       	push   $0x8026f4
  800ae9:	68 ca 00 00 00       	push   $0xca
  800aee:	68 7c 26 80 00       	push   $0x80267c
  800af3:	e8 01 02 00 00       	call   800cf9 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800af8:	e8 48 14 00 00       	call   801f45 <sys_calculate_free_frames>
  800afd:	89 c2                	mov    %eax,%edx
  800aff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b02:	39 c2                	cmp    %eax,%edx
  800b04:	74 17                	je     800b1d <_main+0xae5>
  800b06:	83 ec 04             	sub    $0x4,%esp
  800b09:	68 0b 27 80 00       	push   $0x80270b
  800b0e:	68 cb 00 00 00       	push   $0xcb
  800b13:	68 7c 26 80 00       	push   $0x80267c
  800b18:	e8 dc 01 00 00       	call   800cf9 <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 4 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b1d:	e8 23 14 00 00       	call   801f45 <sys_calculate_free_frames>
  800b22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b25:	e8 9e 14 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800b2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[13] = malloc(4*Mega + 256*kilo - kilo);
  800b2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b30:	c1 e0 06             	shl    $0x6,%eax
  800b33:	89 c2                	mov    %eax,%edx
  800b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b38:	01 d0                	add    %edx,%eax
  800b3a:	c1 e0 02             	shl    $0x2,%eax
  800b3d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800b40:	83 ec 0c             	sub    $0xc,%esp
  800b43:	50                   	push   %eax
  800b44:	e8 ee 11 00 00       	call   801d37 <malloc>
  800b49:	83 c4 10             	add    $0x10,%esp
  800b4c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800b52:	89 c1                	mov    %eax,%ecx
  800b54:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b57:	89 d0                	mov    %edx,%eax
  800b59:	01 c0                	add    %eax,%eax
  800b5b:	01 d0                	add    %edx,%eax
  800b5d:	c1 e0 08             	shl    $0x8,%eax
  800b60:	89 c2                	mov    %eax,%edx
  800b62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b65:	01 d0                	add    %edx,%eax
  800b67:	05 00 00 00 80       	add    $0x80000000,%eax
  800b6c:	39 c1                	cmp    %eax,%ecx
  800b6e:	74 17                	je     800b87 <_main+0xb4f>
  800b70:	83 ec 04             	sub    $0x4,%esp
  800b73:	68 94 26 80 00       	push   $0x802694
  800b78:	68 d5 00 00 00       	push   $0xd5
  800b7d:	68 7c 26 80 00       	push   $0x80267c
  800b82:	e8 72 01 00 00       	call   800cf9 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024+64) panic("Wrong page file allocation: ");
  800b87:	e8 3c 14 00 00       	call   801fc8 <sys_pf_calculate_allocated_pages>
  800b8c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800b8f:	3d 40 04 00 00       	cmp    $0x440,%eax
  800b94:	74 17                	je     800bad <_main+0xb75>
  800b96:	83 ec 04             	sub    $0x4,%esp
  800b99:	68 c4 26 80 00       	push   $0x8026c4
  800b9e:	68 d7 00 00 00       	push   $0xd7
  800ba3:	68 7c 26 80 00       	push   $0x80267c
  800ba8:	e8 4c 01 00 00       	call   800cf9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bad:	e8 93 13 00 00       	call   801f45 <sys_calculate_free_frames>
  800bb2:	89 c2                	mov    %eax,%edx
  800bb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800bb7:	39 c2                	cmp    %eax,%edx
  800bb9:	74 17                	je     800bd2 <_main+0xb9a>
  800bbb:	83 ec 04             	sub    $0x4,%esp
  800bbe:	68 e1 26 80 00       	push   $0x8026e1
  800bc3:	68 d8 00 00 00       	push   $0xd8
  800bc8:	68 7c 26 80 00       	push   $0x80267c
  800bcd:	e8 27 01 00 00       	call   800cf9 <_panic>
	}
	cprintf("Congratulations!! test FIRST FIT allocation (1) completed successfully.\n");
  800bd2:	83 ec 0c             	sub    $0xc,%esp
  800bd5:	68 18 27 80 00       	push   $0x802718
  800bda:	e8 ce 03 00 00       	call   800fad <cprintf>
  800bdf:	83 c4 10             	add    $0x10,%esp

	return;
  800be2:	90                   	nop
}
  800be3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be6:	5b                   	pop    %ebx
  800be7:	5f                   	pop    %edi
  800be8:	5d                   	pop    %ebp
  800be9:	c3                   	ret    

00800bea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800bf0:	e8 85 12 00 00       	call   801e7a <sys_getenvindex>
  800bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800bf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bfb:	89 d0                	mov    %edx,%eax
  800bfd:	c1 e0 02             	shl    $0x2,%eax
  800c00:	01 d0                	add    %edx,%eax
  800c02:	01 c0                	add    %eax,%eax
  800c04:	01 d0                	add    %edx,%eax
  800c06:	01 c0                	add    %eax,%eax
  800c08:	01 d0                	add    %edx,%eax
  800c0a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800c11:	01 d0                	add    %edx,%eax
  800c13:	c1 e0 02             	shl    $0x2,%eax
  800c16:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800c1b:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800c20:	a1 04 30 80 00       	mov    0x803004,%eax
  800c25:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800c2b:	84 c0                	test   %al,%al
  800c2d:	74 0f                	je     800c3e <libmain+0x54>
		binaryname = myEnv->prog_name;
  800c2f:	a1 04 30 80 00       	mov    0x803004,%eax
  800c34:	05 f4 02 00 00       	add    $0x2f4,%eax
  800c39:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800c3e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c42:	7e 0a                	jle    800c4e <libmain+0x64>
		binaryname = argv[0];
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	8b 00                	mov    (%eax),%eax
  800c49:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800c4e:	83 ec 08             	sub    $0x8,%esp
  800c51:	ff 75 0c             	pushl  0xc(%ebp)
  800c54:	ff 75 08             	pushl  0x8(%ebp)
  800c57:	e8 dc f3 ff ff       	call   800038 <_main>
  800c5c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c5f:	e8 b1 13 00 00       	call   802015 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c64:	83 ec 0c             	sub    $0xc,%esp
  800c67:	68 7c 27 80 00       	push   $0x80277c
  800c6c:	e8 3c 03 00 00       	call   800fad <cprintf>
  800c71:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800c74:	a1 04 30 80 00       	mov    0x803004,%eax
  800c79:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800c7f:	a1 04 30 80 00       	mov    0x803004,%eax
  800c84:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800c8a:	83 ec 04             	sub    $0x4,%esp
  800c8d:	52                   	push   %edx
  800c8e:	50                   	push   %eax
  800c8f:	68 a4 27 80 00       	push   $0x8027a4
  800c94:	e8 14 03 00 00       	call   800fad <cprintf>
  800c99:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c9c:	a1 04 30 80 00       	mov    0x803004,%eax
  800ca1:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800ca7:	83 ec 08             	sub    $0x8,%esp
  800caa:	50                   	push   %eax
  800cab:	68 c9 27 80 00       	push   $0x8027c9
  800cb0:	e8 f8 02 00 00       	call   800fad <cprintf>
  800cb5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800cb8:	83 ec 0c             	sub    $0xc,%esp
  800cbb:	68 7c 27 80 00       	push   $0x80277c
  800cc0:	e8 e8 02 00 00       	call   800fad <cprintf>
  800cc5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800cc8:	e8 62 13 00 00       	call   80202f <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ccd:	e8 19 00 00 00       	call   800ceb <exit>
}
  800cd2:	90                   	nop
  800cd3:	c9                   	leave  
  800cd4:	c3                   	ret    

00800cd5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800cdb:	83 ec 0c             	sub    $0xc,%esp
  800cde:	6a 00                	push   $0x0
  800ce0:	e8 61 11 00 00       	call   801e46 <sys_env_destroy>
  800ce5:	83 c4 10             	add    $0x10,%esp
}
  800ce8:	90                   	nop
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <exit>:

void
exit(void)
{
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800cf1:	e8 b6 11 00 00       	call   801eac <sys_env_exit>
}
  800cf6:	90                   	nop
  800cf7:	c9                   	leave  
  800cf8:	c3                   	ret    

00800cf9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800cf9:	55                   	push   %ebp
  800cfa:	89 e5                	mov    %esp,%ebp
  800cfc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800cff:	8d 45 10             	lea    0x10(%ebp),%eax
  800d02:	83 c0 04             	add    $0x4,%eax
  800d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800d08:	a1 14 30 80 00       	mov    0x803014,%eax
  800d0d:	85 c0                	test   %eax,%eax
  800d0f:	74 16                	je     800d27 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800d11:	a1 14 30 80 00       	mov    0x803014,%eax
  800d16:	83 ec 08             	sub    $0x8,%esp
  800d19:	50                   	push   %eax
  800d1a:	68 e0 27 80 00       	push   $0x8027e0
  800d1f:	e8 89 02 00 00       	call   800fad <cprintf>
  800d24:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800d27:	a1 00 30 80 00       	mov    0x803000,%eax
  800d2c:	ff 75 0c             	pushl  0xc(%ebp)
  800d2f:	ff 75 08             	pushl  0x8(%ebp)
  800d32:	50                   	push   %eax
  800d33:	68 e5 27 80 00       	push   $0x8027e5
  800d38:	e8 70 02 00 00       	call   800fad <cprintf>
  800d3d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d40:	8b 45 10             	mov    0x10(%ebp),%eax
  800d43:	83 ec 08             	sub    $0x8,%esp
  800d46:	ff 75 f4             	pushl  -0xc(%ebp)
  800d49:	50                   	push   %eax
  800d4a:	e8 f3 01 00 00       	call   800f42 <vcprintf>
  800d4f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d52:	83 ec 08             	sub    $0x8,%esp
  800d55:	6a 00                	push   $0x0
  800d57:	68 01 28 80 00       	push   $0x802801
  800d5c:	e8 e1 01 00 00       	call   800f42 <vcprintf>
  800d61:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d64:	e8 82 ff ff ff       	call   800ceb <exit>

	// should not return here
	while (1) ;
  800d69:	eb fe                	jmp    800d69 <_panic+0x70>

00800d6b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d6b:	55                   	push   %ebp
  800d6c:	89 e5                	mov    %esp,%ebp
  800d6e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d71:	a1 04 30 80 00       	mov    0x803004,%eax
  800d76:	8b 50 74             	mov    0x74(%eax),%edx
  800d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7c:	39 c2                	cmp    %eax,%edx
  800d7e:	74 14                	je     800d94 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d80:	83 ec 04             	sub    $0x4,%esp
  800d83:	68 04 28 80 00       	push   $0x802804
  800d88:	6a 26                	push   $0x26
  800d8a:	68 50 28 80 00       	push   $0x802850
  800d8f:	e8 65 ff ff ff       	call   800cf9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d9b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800da2:	e9 c2 00 00 00       	jmp    800e69 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800daa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	01 d0                	add    %edx,%eax
  800db6:	8b 00                	mov    (%eax),%eax
  800db8:	85 c0                	test   %eax,%eax
  800dba:	75 08                	jne    800dc4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800dbc:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800dbf:	e9 a2 00 00 00       	jmp    800e66 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800dc4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dcb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800dd2:	eb 69                	jmp    800e3d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800dd4:	a1 04 30 80 00       	mov    0x803004,%eax
  800dd9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ddf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800de2:	89 d0                	mov    %edx,%eax
  800de4:	01 c0                	add    %eax,%eax
  800de6:	01 d0                	add    %edx,%eax
  800de8:	c1 e0 02             	shl    $0x2,%eax
  800deb:	01 c8                	add    %ecx,%eax
  800ded:	8a 40 04             	mov    0x4(%eax),%al
  800df0:	84 c0                	test   %al,%al
  800df2:	75 46                	jne    800e3a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800df4:	a1 04 30 80 00       	mov    0x803004,%eax
  800df9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e02:	89 d0                	mov    %edx,%eax
  800e04:	01 c0                	add    %eax,%eax
  800e06:	01 d0                	add    %edx,%eax
  800e08:	c1 e0 02             	shl    $0x2,%eax
  800e0b:	01 c8                	add    %ecx,%eax
  800e0d:	8b 00                	mov    (%eax),%eax
  800e0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800e12:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800e15:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e1a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800e1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	01 c8                	add    %ecx,%eax
  800e2b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e2d:	39 c2                	cmp    %eax,%edx
  800e2f:	75 09                	jne    800e3a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800e31:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800e38:	eb 12                	jmp    800e4c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e3a:	ff 45 e8             	incl   -0x18(%ebp)
  800e3d:	a1 04 30 80 00       	mov    0x803004,%eax
  800e42:	8b 50 74             	mov    0x74(%eax),%edx
  800e45:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e48:	39 c2                	cmp    %eax,%edx
  800e4a:	77 88                	ja     800dd4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e4c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e50:	75 14                	jne    800e66 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800e52:	83 ec 04             	sub    $0x4,%esp
  800e55:	68 5c 28 80 00       	push   $0x80285c
  800e5a:	6a 3a                	push   $0x3a
  800e5c:	68 50 28 80 00       	push   $0x802850
  800e61:	e8 93 fe ff ff       	call   800cf9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e66:	ff 45 f0             	incl   -0x10(%ebp)
  800e69:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e6c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e6f:	0f 8c 32 ff ff ff    	jl     800da7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e75:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e7c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e83:	eb 26                	jmp    800eab <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e85:	a1 04 30 80 00       	mov    0x803004,%eax
  800e8a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800e90:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e93:	89 d0                	mov    %edx,%eax
  800e95:	01 c0                	add    %eax,%eax
  800e97:	01 d0                	add    %edx,%eax
  800e99:	c1 e0 02             	shl    $0x2,%eax
  800e9c:	01 c8                	add    %ecx,%eax
  800e9e:	8a 40 04             	mov    0x4(%eax),%al
  800ea1:	3c 01                	cmp    $0x1,%al
  800ea3:	75 03                	jne    800ea8 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800ea5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ea8:	ff 45 e0             	incl   -0x20(%ebp)
  800eab:	a1 04 30 80 00       	mov    0x803004,%eax
  800eb0:	8b 50 74             	mov    0x74(%eax),%edx
  800eb3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800eb6:	39 c2                	cmp    %eax,%edx
  800eb8:	77 cb                	ja     800e85 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ec0:	74 14                	je     800ed6 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800ec2:	83 ec 04             	sub    $0x4,%esp
  800ec5:	68 b0 28 80 00       	push   $0x8028b0
  800eca:	6a 44                	push   $0x44
  800ecc:	68 50 28 80 00       	push   $0x802850
  800ed1:	e8 23 fe ff ff       	call   800cf9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ed6:	90                   	nop
  800ed7:	c9                   	leave  
  800ed8:	c3                   	ret    

00800ed9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ed9:	55                   	push   %ebp
  800eda:	89 e5                	mov    %esp,%ebp
  800edc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800edf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee2:	8b 00                	mov    (%eax),%eax
  800ee4:	8d 48 01             	lea    0x1(%eax),%ecx
  800ee7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eea:	89 0a                	mov    %ecx,(%edx)
  800eec:	8b 55 08             	mov    0x8(%ebp),%edx
  800eef:	88 d1                	mov    %dl,%cl
  800ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ef4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efb:	8b 00                	mov    (%eax),%eax
  800efd:	3d ff 00 00 00       	cmp    $0xff,%eax
  800f02:	75 2c                	jne    800f30 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800f04:	a0 08 30 80 00       	mov    0x803008,%al
  800f09:	0f b6 c0             	movzbl %al,%eax
  800f0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f0f:	8b 12                	mov    (%edx),%edx
  800f11:	89 d1                	mov    %edx,%ecx
  800f13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f16:	83 c2 08             	add    $0x8,%edx
  800f19:	83 ec 04             	sub    $0x4,%esp
  800f1c:	50                   	push   %eax
  800f1d:	51                   	push   %ecx
  800f1e:	52                   	push   %edx
  800f1f:	e8 e0 0e 00 00       	call   801e04 <sys_cputs>
  800f24:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	8b 40 04             	mov    0x4(%eax),%eax
  800f36:	8d 50 01             	lea    0x1(%eax),%edx
  800f39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3c:	89 50 04             	mov    %edx,0x4(%eax)
}
  800f3f:	90                   	nop
  800f40:	c9                   	leave  
  800f41:	c3                   	ret    

00800f42 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800f42:	55                   	push   %ebp
  800f43:	89 e5                	mov    %esp,%ebp
  800f45:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f4b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f52:	00 00 00 
	b.cnt = 0;
  800f55:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f5c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	ff 75 08             	pushl  0x8(%ebp)
  800f65:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f6b:	50                   	push   %eax
  800f6c:	68 d9 0e 80 00       	push   $0x800ed9
  800f71:	e8 11 02 00 00       	call   801187 <vprintfmt>
  800f76:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f79:	a0 08 30 80 00       	mov    0x803008,%al
  800f7e:	0f b6 c0             	movzbl %al,%eax
  800f81:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800f87:	83 ec 04             	sub    $0x4,%esp
  800f8a:	50                   	push   %eax
  800f8b:	52                   	push   %edx
  800f8c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f92:	83 c0 08             	add    $0x8,%eax
  800f95:	50                   	push   %eax
  800f96:	e8 69 0e 00 00       	call   801e04 <sys_cputs>
  800f9b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f9e:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800fa5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800fab:	c9                   	leave  
  800fac:	c3                   	ret    

00800fad <cprintf>:

int cprintf(const char *fmt, ...) {
  800fad:	55                   	push   %ebp
  800fae:	89 e5                	mov    %esp,%ebp
  800fb0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800fb3:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800fba:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	83 ec 08             	sub    $0x8,%esp
  800fc6:	ff 75 f4             	pushl  -0xc(%ebp)
  800fc9:	50                   	push   %eax
  800fca:	e8 73 ff ff ff       	call   800f42 <vcprintf>
  800fcf:	83 c4 10             	add    $0x10,%esp
  800fd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800fd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800fe0:	e8 30 10 00 00       	call   802015 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800fe5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fe8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	83 ec 08             	sub    $0x8,%esp
  800ff1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff4:	50                   	push   %eax
  800ff5:	e8 48 ff ff ff       	call   800f42 <vcprintf>
  800ffa:	83 c4 10             	add    $0x10,%esp
  800ffd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801000:	e8 2a 10 00 00       	call   80202f <sys_enable_interrupt>
	return cnt;
  801005:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801008:	c9                   	leave  
  801009:	c3                   	ret    

0080100a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80100a:	55                   	push   %ebp
  80100b:	89 e5                	mov    %esp,%ebp
  80100d:	53                   	push   %ebx
  80100e:	83 ec 14             	sub    $0x14,%esp
  801011:	8b 45 10             	mov    0x10(%ebp),%eax
  801014:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801017:	8b 45 14             	mov    0x14(%ebp),%eax
  80101a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80101d:	8b 45 18             	mov    0x18(%ebp),%eax
  801020:	ba 00 00 00 00       	mov    $0x0,%edx
  801025:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801028:	77 55                	ja     80107f <printnum+0x75>
  80102a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80102d:	72 05                	jb     801034 <printnum+0x2a>
  80102f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801032:	77 4b                	ja     80107f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801034:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801037:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80103a:	8b 45 18             	mov    0x18(%ebp),%eax
  80103d:	ba 00 00 00 00       	mov    $0x0,%edx
  801042:	52                   	push   %edx
  801043:	50                   	push   %eax
  801044:	ff 75 f4             	pushl  -0xc(%ebp)
  801047:	ff 75 f0             	pushl  -0x10(%ebp)
  80104a:	e8 a5 13 00 00       	call   8023f4 <__udivdi3>
  80104f:	83 c4 10             	add    $0x10,%esp
  801052:	83 ec 04             	sub    $0x4,%esp
  801055:	ff 75 20             	pushl  0x20(%ebp)
  801058:	53                   	push   %ebx
  801059:	ff 75 18             	pushl  0x18(%ebp)
  80105c:	52                   	push   %edx
  80105d:	50                   	push   %eax
  80105e:	ff 75 0c             	pushl  0xc(%ebp)
  801061:	ff 75 08             	pushl  0x8(%ebp)
  801064:	e8 a1 ff ff ff       	call   80100a <printnum>
  801069:	83 c4 20             	add    $0x20,%esp
  80106c:	eb 1a                	jmp    801088 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80106e:	83 ec 08             	sub    $0x8,%esp
  801071:	ff 75 0c             	pushl  0xc(%ebp)
  801074:	ff 75 20             	pushl  0x20(%ebp)
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	ff d0                	call   *%eax
  80107c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80107f:	ff 4d 1c             	decl   0x1c(%ebp)
  801082:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801086:	7f e6                	jg     80106e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801088:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80108b:	bb 00 00 00 00       	mov    $0x0,%ebx
  801090:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801093:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801096:	53                   	push   %ebx
  801097:	51                   	push   %ecx
  801098:	52                   	push   %edx
  801099:	50                   	push   %eax
  80109a:	e8 65 14 00 00       	call   802504 <__umoddi3>
  80109f:	83 c4 10             	add    $0x10,%esp
  8010a2:	05 14 2b 80 00       	add    $0x802b14,%eax
  8010a7:	8a 00                	mov    (%eax),%al
  8010a9:	0f be c0             	movsbl %al,%eax
  8010ac:	83 ec 08             	sub    $0x8,%esp
  8010af:	ff 75 0c             	pushl  0xc(%ebp)
  8010b2:	50                   	push   %eax
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	ff d0                	call   *%eax
  8010b8:	83 c4 10             	add    $0x10,%esp
}
  8010bb:	90                   	nop
  8010bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010c4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010c8:	7e 1c                	jle    8010e6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8b 00                	mov    (%eax),%eax
  8010cf:	8d 50 08             	lea    0x8(%eax),%edx
  8010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d5:	89 10                	mov    %edx,(%eax)
  8010d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010da:	8b 00                	mov    (%eax),%eax
  8010dc:	83 e8 08             	sub    $0x8,%eax
  8010df:	8b 50 04             	mov    0x4(%eax),%edx
  8010e2:	8b 00                	mov    (%eax),%eax
  8010e4:	eb 40                	jmp    801126 <getuint+0x65>
	else if (lflag)
  8010e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010ea:	74 1e                	je     80110a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8b 00                	mov    (%eax),%eax
  8010f1:	8d 50 04             	lea    0x4(%eax),%edx
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	89 10                	mov    %edx,(%eax)
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	8b 00                	mov    (%eax),%eax
  8010fe:	83 e8 04             	sub    $0x4,%eax
  801101:	8b 00                	mov    (%eax),%eax
  801103:	ba 00 00 00 00       	mov    $0x0,%edx
  801108:	eb 1c                	jmp    801126 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	8b 00                	mov    (%eax),%eax
  80110f:	8d 50 04             	lea    0x4(%eax),%edx
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	89 10                	mov    %edx,(%eax)
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8b 00                	mov    (%eax),%eax
  80111c:	83 e8 04             	sub    $0x4,%eax
  80111f:	8b 00                	mov    (%eax),%eax
  801121:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801126:	5d                   	pop    %ebp
  801127:	c3                   	ret    

00801128 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80112b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80112f:	7e 1c                	jle    80114d <getint+0x25>
		return va_arg(*ap, long long);
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8b 00                	mov    (%eax),%eax
  801136:	8d 50 08             	lea    0x8(%eax),%edx
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	89 10                	mov    %edx,(%eax)
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8b 00                	mov    (%eax),%eax
  801143:	83 e8 08             	sub    $0x8,%eax
  801146:	8b 50 04             	mov    0x4(%eax),%edx
  801149:	8b 00                	mov    (%eax),%eax
  80114b:	eb 38                	jmp    801185 <getint+0x5d>
	else if (lflag)
  80114d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801151:	74 1a                	je     80116d <getint+0x45>
		return va_arg(*ap, long);
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8b 00                	mov    (%eax),%eax
  801158:	8d 50 04             	lea    0x4(%eax),%edx
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	89 10                	mov    %edx,(%eax)
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	8b 00                	mov    (%eax),%eax
  801165:	83 e8 04             	sub    $0x4,%eax
  801168:	8b 00                	mov    (%eax),%eax
  80116a:	99                   	cltd   
  80116b:	eb 18                	jmp    801185 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8b 00                	mov    (%eax),%eax
  801172:	8d 50 04             	lea    0x4(%eax),%edx
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	89 10                	mov    %edx,(%eax)
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8b 00                	mov    (%eax),%eax
  80117f:	83 e8 04             	sub    $0x4,%eax
  801182:	8b 00                	mov    (%eax),%eax
  801184:	99                   	cltd   
}
  801185:	5d                   	pop    %ebp
  801186:	c3                   	ret    

00801187 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
  80118a:	56                   	push   %esi
  80118b:	53                   	push   %ebx
  80118c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80118f:	eb 17                	jmp    8011a8 <vprintfmt+0x21>
			if (ch == '\0')
  801191:	85 db                	test   %ebx,%ebx
  801193:	0f 84 af 03 00 00    	je     801548 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801199:	83 ec 08             	sub    $0x8,%esp
  80119c:	ff 75 0c             	pushl  0xc(%ebp)
  80119f:	53                   	push   %ebx
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	ff d0                	call   *%eax
  8011a5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ab:	8d 50 01             	lea    0x1(%eax),%edx
  8011ae:	89 55 10             	mov    %edx,0x10(%ebp)
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	0f b6 d8             	movzbl %al,%ebx
  8011b6:	83 fb 25             	cmp    $0x25,%ebx
  8011b9:	75 d6                	jne    801191 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011bb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011bf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011c6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011cd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8011d4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8011db:	8b 45 10             	mov    0x10(%ebp),%eax
  8011de:	8d 50 01             	lea    0x1(%eax),%edx
  8011e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	0f b6 d8             	movzbl %al,%ebx
  8011e9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8011ec:	83 f8 55             	cmp    $0x55,%eax
  8011ef:	0f 87 2b 03 00 00    	ja     801520 <vprintfmt+0x399>
  8011f5:	8b 04 85 38 2b 80 00 	mov    0x802b38(,%eax,4),%eax
  8011fc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8011fe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801202:	eb d7                	jmp    8011db <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801204:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801208:	eb d1                	jmp    8011db <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80120a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801211:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801214:	89 d0                	mov    %edx,%eax
  801216:	c1 e0 02             	shl    $0x2,%eax
  801219:	01 d0                	add    %edx,%eax
  80121b:	01 c0                	add    %eax,%eax
  80121d:	01 d8                	add    %ebx,%eax
  80121f:	83 e8 30             	sub    $0x30,%eax
  801222:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801225:	8b 45 10             	mov    0x10(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80122d:	83 fb 2f             	cmp    $0x2f,%ebx
  801230:	7e 3e                	jle    801270 <vprintfmt+0xe9>
  801232:	83 fb 39             	cmp    $0x39,%ebx
  801235:	7f 39                	jg     801270 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801237:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80123a:	eb d5                	jmp    801211 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80123c:	8b 45 14             	mov    0x14(%ebp),%eax
  80123f:	83 c0 04             	add    $0x4,%eax
  801242:	89 45 14             	mov    %eax,0x14(%ebp)
  801245:	8b 45 14             	mov    0x14(%ebp),%eax
  801248:	83 e8 04             	sub    $0x4,%eax
  80124b:	8b 00                	mov    (%eax),%eax
  80124d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801250:	eb 1f                	jmp    801271 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801252:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801256:	79 83                	jns    8011db <vprintfmt+0x54>
				width = 0;
  801258:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80125f:	e9 77 ff ff ff       	jmp    8011db <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801264:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80126b:	e9 6b ff ff ff       	jmp    8011db <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801270:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801271:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801275:	0f 89 60 ff ff ff    	jns    8011db <vprintfmt+0x54>
				width = precision, precision = -1;
  80127b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801281:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801288:	e9 4e ff ff ff       	jmp    8011db <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80128d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801290:	e9 46 ff ff ff       	jmp    8011db <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801295:	8b 45 14             	mov    0x14(%ebp),%eax
  801298:	83 c0 04             	add    $0x4,%eax
  80129b:	89 45 14             	mov    %eax,0x14(%ebp)
  80129e:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a1:	83 e8 04             	sub    $0x4,%eax
  8012a4:	8b 00                	mov    (%eax),%eax
  8012a6:	83 ec 08             	sub    $0x8,%esp
  8012a9:	ff 75 0c             	pushl  0xc(%ebp)
  8012ac:	50                   	push   %eax
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	ff d0                	call   *%eax
  8012b2:	83 c4 10             	add    $0x10,%esp
			break;
  8012b5:	e9 89 02 00 00       	jmp    801543 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bd:	83 c0 04             	add    $0x4,%eax
  8012c0:	89 45 14             	mov    %eax,0x14(%ebp)
  8012c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012c6:	83 e8 04             	sub    $0x4,%eax
  8012c9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012cb:	85 db                	test   %ebx,%ebx
  8012cd:	79 02                	jns    8012d1 <vprintfmt+0x14a>
				err = -err;
  8012cf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8012d1:	83 fb 64             	cmp    $0x64,%ebx
  8012d4:	7f 0b                	jg     8012e1 <vprintfmt+0x15a>
  8012d6:	8b 34 9d 80 29 80 00 	mov    0x802980(,%ebx,4),%esi
  8012dd:	85 f6                	test   %esi,%esi
  8012df:	75 19                	jne    8012fa <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8012e1:	53                   	push   %ebx
  8012e2:	68 25 2b 80 00       	push   $0x802b25
  8012e7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ea:	ff 75 08             	pushl  0x8(%ebp)
  8012ed:	e8 5e 02 00 00       	call   801550 <printfmt>
  8012f2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8012f5:	e9 49 02 00 00       	jmp    801543 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8012fa:	56                   	push   %esi
  8012fb:	68 2e 2b 80 00       	push   $0x802b2e
  801300:	ff 75 0c             	pushl  0xc(%ebp)
  801303:	ff 75 08             	pushl  0x8(%ebp)
  801306:	e8 45 02 00 00       	call   801550 <printfmt>
  80130b:	83 c4 10             	add    $0x10,%esp
			break;
  80130e:	e9 30 02 00 00       	jmp    801543 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801313:	8b 45 14             	mov    0x14(%ebp),%eax
  801316:	83 c0 04             	add    $0x4,%eax
  801319:	89 45 14             	mov    %eax,0x14(%ebp)
  80131c:	8b 45 14             	mov    0x14(%ebp),%eax
  80131f:	83 e8 04             	sub    $0x4,%eax
  801322:	8b 30                	mov    (%eax),%esi
  801324:	85 f6                	test   %esi,%esi
  801326:	75 05                	jne    80132d <vprintfmt+0x1a6>
				p = "(null)";
  801328:	be 31 2b 80 00       	mov    $0x802b31,%esi
			if (width > 0 && padc != '-')
  80132d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801331:	7e 6d                	jle    8013a0 <vprintfmt+0x219>
  801333:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801337:	74 67                	je     8013a0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801339:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80133c:	83 ec 08             	sub    $0x8,%esp
  80133f:	50                   	push   %eax
  801340:	56                   	push   %esi
  801341:	e8 0c 03 00 00       	call   801652 <strnlen>
  801346:	83 c4 10             	add    $0x10,%esp
  801349:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80134c:	eb 16                	jmp    801364 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80134e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801352:	83 ec 08             	sub    $0x8,%esp
  801355:	ff 75 0c             	pushl  0xc(%ebp)
  801358:	50                   	push   %eax
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	ff d0                	call   *%eax
  80135e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801361:	ff 4d e4             	decl   -0x1c(%ebp)
  801364:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801368:	7f e4                	jg     80134e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80136a:	eb 34                	jmp    8013a0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80136c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801370:	74 1c                	je     80138e <vprintfmt+0x207>
  801372:	83 fb 1f             	cmp    $0x1f,%ebx
  801375:	7e 05                	jle    80137c <vprintfmt+0x1f5>
  801377:	83 fb 7e             	cmp    $0x7e,%ebx
  80137a:	7e 12                	jle    80138e <vprintfmt+0x207>
					putch('?', putdat);
  80137c:	83 ec 08             	sub    $0x8,%esp
  80137f:	ff 75 0c             	pushl  0xc(%ebp)
  801382:	6a 3f                	push   $0x3f
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	ff d0                	call   *%eax
  801389:	83 c4 10             	add    $0x10,%esp
  80138c:	eb 0f                	jmp    80139d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80138e:	83 ec 08             	sub    $0x8,%esp
  801391:	ff 75 0c             	pushl  0xc(%ebp)
  801394:	53                   	push   %ebx
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	ff d0                	call   *%eax
  80139a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80139d:	ff 4d e4             	decl   -0x1c(%ebp)
  8013a0:	89 f0                	mov    %esi,%eax
  8013a2:	8d 70 01             	lea    0x1(%eax),%esi
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	0f be d8             	movsbl %al,%ebx
  8013aa:	85 db                	test   %ebx,%ebx
  8013ac:	74 24                	je     8013d2 <vprintfmt+0x24b>
  8013ae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013b2:	78 b8                	js     80136c <vprintfmt+0x1e5>
  8013b4:	ff 4d e0             	decl   -0x20(%ebp)
  8013b7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013bb:	79 af                	jns    80136c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013bd:	eb 13                	jmp    8013d2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8013bf:	83 ec 08             	sub    $0x8,%esp
  8013c2:	ff 75 0c             	pushl  0xc(%ebp)
  8013c5:	6a 20                	push   $0x20
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	ff d0                	call   *%eax
  8013cc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013cf:	ff 4d e4             	decl   -0x1c(%ebp)
  8013d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013d6:	7f e7                	jg     8013bf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8013d8:	e9 66 01 00 00       	jmp    801543 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8013dd:	83 ec 08             	sub    $0x8,%esp
  8013e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8013e3:	8d 45 14             	lea    0x14(%ebp),%eax
  8013e6:	50                   	push   %eax
  8013e7:	e8 3c fd ff ff       	call   801128 <getint>
  8013ec:	83 c4 10             	add    $0x10,%esp
  8013ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8013f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fb:	85 d2                	test   %edx,%edx
  8013fd:	79 23                	jns    801422 <vprintfmt+0x29b>
				putch('-', putdat);
  8013ff:	83 ec 08             	sub    $0x8,%esp
  801402:	ff 75 0c             	pushl  0xc(%ebp)
  801405:	6a 2d                	push   $0x2d
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	ff d0                	call   *%eax
  80140c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80140f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801412:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801415:	f7 d8                	neg    %eax
  801417:	83 d2 00             	adc    $0x0,%edx
  80141a:	f7 da                	neg    %edx
  80141c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80141f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801422:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801429:	e9 bc 00 00 00       	jmp    8014ea <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80142e:	83 ec 08             	sub    $0x8,%esp
  801431:	ff 75 e8             	pushl  -0x18(%ebp)
  801434:	8d 45 14             	lea    0x14(%ebp),%eax
  801437:	50                   	push   %eax
  801438:	e8 84 fc ff ff       	call   8010c1 <getuint>
  80143d:	83 c4 10             	add    $0x10,%esp
  801440:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801443:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801446:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80144d:	e9 98 00 00 00       	jmp    8014ea <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801452:	83 ec 08             	sub    $0x8,%esp
  801455:	ff 75 0c             	pushl  0xc(%ebp)
  801458:	6a 58                	push   $0x58
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	ff d0                	call   *%eax
  80145f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801462:	83 ec 08             	sub    $0x8,%esp
  801465:	ff 75 0c             	pushl  0xc(%ebp)
  801468:	6a 58                	push   $0x58
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	ff d0                	call   *%eax
  80146f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801472:	83 ec 08             	sub    $0x8,%esp
  801475:	ff 75 0c             	pushl  0xc(%ebp)
  801478:	6a 58                	push   $0x58
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	ff d0                	call   *%eax
  80147f:	83 c4 10             	add    $0x10,%esp
			break;
  801482:	e9 bc 00 00 00       	jmp    801543 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801487:	83 ec 08             	sub    $0x8,%esp
  80148a:	ff 75 0c             	pushl  0xc(%ebp)
  80148d:	6a 30                	push   $0x30
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	ff d0                	call   *%eax
  801494:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801497:	83 ec 08             	sub    $0x8,%esp
  80149a:	ff 75 0c             	pushl  0xc(%ebp)
  80149d:	6a 78                	push   $0x78
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	ff d0                	call   *%eax
  8014a4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8014a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014aa:	83 c0 04             	add    $0x4,%eax
  8014ad:	89 45 14             	mov    %eax,0x14(%ebp)
  8014b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b3:	83 e8 04             	sub    $0x4,%eax
  8014b6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014c2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014c9:	eb 1f                	jmp    8014ea <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014cb:	83 ec 08             	sub    $0x8,%esp
  8014ce:	ff 75 e8             	pushl  -0x18(%ebp)
  8014d1:	8d 45 14             	lea    0x14(%ebp),%eax
  8014d4:	50                   	push   %eax
  8014d5:	e8 e7 fb ff ff       	call   8010c1 <getuint>
  8014da:	83 c4 10             	add    $0x10,%esp
  8014dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014e0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8014e3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8014ea:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8014ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014f1:	83 ec 04             	sub    $0x4,%esp
  8014f4:	52                   	push   %edx
  8014f5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014f8:	50                   	push   %eax
  8014f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8014fc:	ff 75 f0             	pushl  -0x10(%ebp)
  8014ff:	ff 75 0c             	pushl  0xc(%ebp)
  801502:	ff 75 08             	pushl  0x8(%ebp)
  801505:	e8 00 fb ff ff       	call   80100a <printnum>
  80150a:	83 c4 20             	add    $0x20,%esp
			break;
  80150d:	eb 34                	jmp    801543 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80150f:	83 ec 08             	sub    $0x8,%esp
  801512:	ff 75 0c             	pushl  0xc(%ebp)
  801515:	53                   	push   %ebx
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	ff d0                	call   *%eax
  80151b:	83 c4 10             	add    $0x10,%esp
			break;
  80151e:	eb 23                	jmp    801543 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801520:	83 ec 08             	sub    $0x8,%esp
  801523:	ff 75 0c             	pushl  0xc(%ebp)
  801526:	6a 25                	push   $0x25
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	ff d0                	call   *%eax
  80152d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801530:	ff 4d 10             	decl   0x10(%ebp)
  801533:	eb 03                	jmp    801538 <vprintfmt+0x3b1>
  801535:	ff 4d 10             	decl   0x10(%ebp)
  801538:	8b 45 10             	mov    0x10(%ebp),%eax
  80153b:	48                   	dec    %eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	3c 25                	cmp    $0x25,%al
  801540:	75 f3                	jne    801535 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801542:	90                   	nop
		}
	}
  801543:	e9 47 fc ff ff       	jmp    80118f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801548:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801549:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80154c:	5b                   	pop    %ebx
  80154d:	5e                   	pop    %esi
  80154e:	5d                   	pop    %ebp
  80154f:	c3                   	ret    

00801550 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
  801553:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801556:	8d 45 10             	lea    0x10(%ebp),%eax
  801559:	83 c0 04             	add    $0x4,%eax
  80155c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80155f:	8b 45 10             	mov    0x10(%ebp),%eax
  801562:	ff 75 f4             	pushl  -0xc(%ebp)
  801565:	50                   	push   %eax
  801566:	ff 75 0c             	pushl  0xc(%ebp)
  801569:	ff 75 08             	pushl  0x8(%ebp)
  80156c:	e8 16 fc ff ff       	call   801187 <vprintfmt>
  801571:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801574:	90                   	nop
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80157a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157d:	8b 40 08             	mov    0x8(%eax),%eax
  801580:	8d 50 01             	lea    0x1(%eax),%edx
  801583:	8b 45 0c             	mov    0xc(%ebp),%eax
  801586:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801589:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158c:	8b 10                	mov    (%eax),%edx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	8b 40 04             	mov    0x4(%eax),%eax
  801594:	39 c2                	cmp    %eax,%edx
  801596:	73 12                	jae    8015aa <sprintputch+0x33>
		*b->buf++ = ch;
  801598:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159b:	8b 00                	mov    (%eax),%eax
  80159d:	8d 48 01             	lea    0x1(%eax),%ecx
  8015a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a3:	89 0a                	mov    %ecx,(%edx)
  8015a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8015a8:	88 10                	mov    %dl,(%eax)
}
  8015aa:	90                   	nop
  8015ab:	5d                   	pop    %ebp
  8015ac:	c3                   	ret    

008015ad <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
  8015b0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	01 d0                	add    %edx,%eax
  8015c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8015ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015d2:	74 06                	je     8015da <vsnprintf+0x2d>
  8015d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015d8:	7f 07                	jg     8015e1 <vsnprintf+0x34>
		return -E_INVAL;
  8015da:	b8 03 00 00 00       	mov    $0x3,%eax
  8015df:	eb 20                	jmp    801601 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8015e1:	ff 75 14             	pushl  0x14(%ebp)
  8015e4:	ff 75 10             	pushl  0x10(%ebp)
  8015e7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8015ea:	50                   	push   %eax
  8015eb:	68 77 15 80 00       	push   $0x801577
  8015f0:	e8 92 fb ff ff       	call   801187 <vprintfmt>
  8015f5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8015f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015fb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8015fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
  801606:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801609:	8d 45 10             	lea    0x10(%ebp),%eax
  80160c:	83 c0 04             	add    $0x4,%eax
  80160f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801612:	8b 45 10             	mov    0x10(%ebp),%eax
  801615:	ff 75 f4             	pushl  -0xc(%ebp)
  801618:	50                   	push   %eax
  801619:	ff 75 0c             	pushl  0xc(%ebp)
  80161c:	ff 75 08             	pushl  0x8(%ebp)
  80161f:	e8 89 ff ff ff       	call   8015ad <vsnprintf>
  801624:	83 c4 10             	add    $0x10,%esp
  801627:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80162a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80162d:	c9                   	leave  
  80162e:	c3                   	ret    

0080162f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80162f:	55                   	push   %ebp
  801630:	89 e5                	mov    %esp,%ebp
  801632:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801635:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80163c:	eb 06                	jmp    801644 <strlen+0x15>
		n++;
  80163e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801641:	ff 45 08             	incl   0x8(%ebp)
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	8a 00                	mov    (%eax),%al
  801649:	84 c0                	test   %al,%al
  80164b:	75 f1                	jne    80163e <strlen+0xf>
		n++;
	return n;
  80164d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
  801655:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801658:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80165f:	eb 09                	jmp    80166a <strnlen+0x18>
		n++;
  801661:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801664:	ff 45 08             	incl   0x8(%ebp)
  801667:	ff 4d 0c             	decl   0xc(%ebp)
  80166a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80166e:	74 09                	je     801679 <strnlen+0x27>
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	84 c0                	test   %al,%al
  801677:	75 e8                	jne    801661 <strnlen+0xf>
		n++;
	return n;
  801679:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
  801681:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80168a:	90                   	nop
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8d 50 01             	lea    0x1(%eax),%edx
  801691:	89 55 08             	mov    %edx,0x8(%ebp)
  801694:	8b 55 0c             	mov    0xc(%ebp),%edx
  801697:	8d 4a 01             	lea    0x1(%edx),%ecx
  80169a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80169d:	8a 12                	mov    (%edx),%dl
  80169f:	88 10                	mov    %dl,(%eax)
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	84 c0                	test   %al,%al
  8016a5:	75 e4                	jne    80168b <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
  8016af:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016bf:	eb 1f                	jmp    8016e0 <strncpy+0x34>
		*dst++ = *src;
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8d 50 01             	lea    0x1(%eax),%edx
  8016c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8016ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016cd:	8a 12                	mov    (%edx),%dl
  8016cf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	84 c0                	test   %al,%al
  8016d8:	74 03                	je     8016dd <strncpy+0x31>
			src++;
  8016da:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016dd:	ff 45 fc             	incl   -0x4(%ebp)
  8016e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016e6:	72 d9                	jb     8016c1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
  8016f0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8016f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016fd:	74 30                	je     80172f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8016ff:	eb 16                	jmp    801717 <strlcpy+0x2a>
			*dst++ = *src++;
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	8d 50 01             	lea    0x1(%eax),%edx
  801707:	89 55 08             	mov    %edx,0x8(%ebp)
  80170a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801710:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801713:	8a 12                	mov    (%edx),%dl
  801715:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801717:	ff 4d 10             	decl   0x10(%ebp)
  80171a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80171e:	74 09                	je     801729 <strlcpy+0x3c>
  801720:	8b 45 0c             	mov    0xc(%ebp),%eax
  801723:	8a 00                	mov    (%eax),%al
  801725:	84 c0                	test   %al,%al
  801727:	75 d8                	jne    801701 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80172f:	8b 55 08             	mov    0x8(%ebp),%edx
  801732:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801735:	29 c2                	sub    %eax,%edx
  801737:	89 d0                	mov    %edx,%eax
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80173e:	eb 06                	jmp    801746 <strcmp+0xb>
		p++, q++;
  801740:	ff 45 08             	incl   0x8(%ebp)
  801743:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	8a 00                	mov    (%eax),%al
  80174b:	84 c0                	test   %al,%al
  80174d:	74 0e                	je     80175d <strcmp+0x22>
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	8a 10                	mov    (%eax),%dl
  801754:	8b 45 0c             	mov    0xc(%ebp),%eax
  801757:	8a 00                	mov    (%eax),%al
  801759:	38 c2                	cmp    %al,%dl
  80175b:	74 e3                	je     801740 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	0f b6 d0             	movzbl %al,%edx
  801765:	8b 45 0c             	mov    0xc(%ebp),%eax
  801768:	8a 00                	mov    (%eax),%al
  80176a:	0f b6 c0             	movzbl %al,%eax
  80176d:	29 c2                	sub    %eax,%edx
  80176f:	89 d0                	mov    %edx,%eax
}
  801771:	5d                   	pop    %ebp
  801772:	c3                   	ret    

00801773 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801776:	eb 09                	jmp    801781 <strncmp+0xe>
		n--, p++, q++;
  801778:	ff 4d 10             	decl   0x10(%ebp)
  80177b:	ff 45 08             	incl   0x8(%ebp)
  80177e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801781:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801785:	74 17                	je     80179e <strncmp+0x2b>
  801787:	8b 45 08             	mov    0x8(%ebp),%eax
  80178a:	8a 00                	mov    (%eax),%al
  80178c:	84 c0                	test   %al,%al
  80178e:	74 0e                	je     80179e <strncmp+0x2b>
  801790:	8b 45 08             	mov    0x8(%ebp),%eax
  801793:	8a 10                	mov    (%eax),%dl
  801795:	8b 45 0c             	mov    0xc(%ebp),%eax
  801798:	8a 00                	mov    (%eax),%al
  80179a:	38 c2                	cmp    %al,%dl
  80179c:	74 da                	je     801778 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80179e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a2:	75 07                	jne    8017ab <strncmp+0x38>
		return 0;
  8017a4:	b8 00 00 00 00       	mov    $0x0,%eax
  8017a9:	eb 14                	jmp    8017bf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ae:	8a 00                	mov    (%eax),%al
  8017b0:	0f b6 d0             	movzbl %al,%edx
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	0f b6 c0             	movzbl %al,%eax
  8017bb:	29 c2                	sub    %eax,%edx
  8017bd:	89 d0                	mov    %edx,%eax
}
  8017bf:	5d                   	pop    %ebp
  8017c0:	c3                   	ret    

008017c1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
  8017c4:	83 ec 04             	sub    $0x4,%esp
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017cd:	eb 12                	jmp    8017e1 <strchr+0x20>
		if (*s == c)
  8017cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d2:	8a 00                	mov    (%eax),%al
  8017d4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017d7:	75 05                	jne    8017de <strchr+0x1d>
			return (char *) s;
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	eb 11                	jmp    8017ef <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017de:	ff 45 08             	incl   0x8(%ebp)
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	8a 00                	mov    (%eax),%al
  8017e6:	84 c0                	test   %al,%al
  8017e8:	75 e5                	jne    8017cf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 04             	sub    $0x4,%esp
  8017f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017fd:	eb 0d                	jmp    80180c <strfind+0x1b>
		if (*s == c)
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	8a 00                	mov    (%eax),%al
  801804:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801807:	74 0e                	je     801817 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801809:	ff 45 08             	incl   0x8(%ebp)
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	8a 00                	mov    (%eax),%al
  801811:	84 c0                	test   %al,%al
  801813:	75 ea                	jne    8017ff <strfind+0xe>
  801815:	eb 01                	jmp    801818 <strfind+0x27>
		if (*s == c)
			break;
  801817:	90                   	nop
	return (char *) s;
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
  801820:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801829:	8b 45 10             	mov    0x10(%ebp),%eax
  80182c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80182f:	eb 0e                	jmp    80183f <memset+0x22>
		*p++ = c;
  801831:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801834:	8d 50 01             	lea    0x1(%eax),%edx
  801837:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80183a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80183f:	ff 4d f8             	decl   -0x8(%ebp)
  801842:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801846:	79 e9                	jns    801831 <memset+0x14>
		*p++ = c;

	return v;
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
  801850:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801853:	8b 45 0c             	mov    0xc(%ebp),%eax
  801856:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80185f:	eb 16                	jmp    801877 <memcpy+0x2a>
		*d++ = *s++;
  801861:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801864:	8d 50 01             	lea    0x1(%eax),%edx
  801867:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80186a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80186d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801870:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801873:	8a 12                	mov    (%edx),%dl
  801875:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801877:	8b 45 10             	mov    0x10(%ebp),%eax
  80187a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80187d:	89 55 10             	mov    %edx,0x10(%ebp)
  801880:	85 c0                	test   %eax,%eax
  801882:	75 dd                	jne    801861 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
  80188c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80188f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801892:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801895:	8b 45 08             	mov    0x8(%ebp),%eax
  801898:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80189b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80189e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018a1:	73 50                	jae    8018f3 <memmove+0x6a>
  8018a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a9:	01 d0                	add    %edx,%eax
  8018ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018ae:	76 43                	jbe    8018f3 <memmove+0x6a>
		s += n;
  8018b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8018b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018bc:	eb 10                	jmp    8018ce <memmove+0x45>
			*--d = *--s;
  8018be:	ff 4d f8             	decl   -0x8(%ebp)
  8018c1:	ff 4d fc             	decl   -0x4(%ebp)
  8018c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018c7:	8a 10                	mov    (%eax),%dl
  8018c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018cc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8018ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8018d7:	85 c0                	test   %eax,%eax
  8018d9:	75 e3                	jne    8018be <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8018db:	eb 23                	jmp    801900 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8018dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e0:	8d 50 01             	lea    0x1(%eax),%edx
  8018e3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018e9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018ec:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8018ef:	8a 12                	mov    (%edx),%dl
  8018f1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8018f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8018fc:	85 c0                	test   %eax,%eax
  8018fe:	75 dd                	jne    8018dd <memmove+0x54>
			*d++ = *s++;

	return dst;
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80190b:	8b 45 08             	mov    0x8(%ebp),%eax
  80190e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801911:	8b 45 0c             	mov    0xc(%ebp),%eax
  801914:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801917:	eb 2a                	jmp    801943 <memcmp+0x3e>
		if (*s1 != *s2)
  801919:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191c:	8a 10                	mov    (%eax),%dl
  80191e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801921:	8a 00                	mov    (%eax),%al
  801923:	38 c2                	cmp    %al,%dl
  801925:	74 16                	je     80193d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801927:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80192a:	8a 00                	mov    (%eax),%al
  80192c:	0f b6 d0             	movzbl %al,%edx
  80192f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801932:	8a 00                	mov    (%eax),%al
  801934:	0f b6 c0             	movzbl %al,%eax
  801937:	29 c2                	sub    %eax,%edx
  801939:	89 d0                	mov    %edx,%eax
  80193b:	eb 18                	jmp    801955 <memcmp+0x50>
		s1++, s2++;
  80193d:	ff 45 fc             	incl   -0x4(%ebp)
  801940:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801943:	8b 45 10             	mov    0x10(%ebp),%eax
  801946:	8d 50 ff             	lea    -0x1(%eax),%edx
  801949:	89 55 10             	mov    %edx,0x10(%ebp)
  80194c:	85 c0                	test   %eax,%eax
  80194e:	75 c9                	jne    801919 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801950:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80195d:	8b 55 08             	mov    0x8(%ebp),%edx
  801960:	8b 45 10             	mov    0x10(%ebp),%eax
  801963:	01 d0                	add    %edx,%eax
  801965:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801968:	eb 15                	jmp    80197f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80196a:	8b 45 08             	mov    0x8(%ebp),%eax
  80196d:	8a 00                	mov    (%eax),%al
  80196f:	0f b6 d0             	movzbl %al,%edx
  801972:	8b 45 0c             	mov    0xc(%ebp),%eax
  801975:	0f b6 c0             	movzbl %al,%eax
  801978:	39 c2                	cmp    %eax,%edx
  80197a:	74 0d                	je     801989 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80197c:	ff 45 08             	incl   0x8(%ebp)
  80197f:	8b 45 08             	mov    0x8(%ebp),%eax
  801982:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801985:	72 e3                	jb     80196a <memfind+0x13>
  801987:	eb 01                	jmp    80198a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801989:	90                   	nop
	return (void *) s;
  80198a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80198d:	c9                   	leave  
  80198e:	c3                   	ret    

0080198f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80198f:	55                   	push   %ebp
  801990:	89 e5                	mov    %esp,%ebp
  801992:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801995:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80199c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019a3:	eb 03                	jmp    8019a8 <strtol+0x19>
		s++;
  8019a5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	8a 00                	mov    (%eax),%al
  8019ad:	3c 20                	cmp    $0x20,%al
  8019af:	74 f4                	je     8019a5 <strtol+0x16>
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	8a 00                	mov    (%eax),%al
  8019b6:	3c 09                	cmp    $0x9,%al
  8019b8:	74 eb                	je     8019a5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	8a 00                	mov    (%eax),%al
  8019bf:	3c 2b                	cmp    $0x2b,%al
  8019c1:	75 05                	jne    8019c8 <strtol+0x39>
		s++;
  8019c3:	ff 45 08             	incl   0x8(%ebp)
  8019c6:	eb 13                	jmp    8019db <strtol+0x4c>
	else if (*s == '-')
  8019c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cb:	8a 00                	mov    (%eax),%al
  8019cd:	3c 2d                	cmp    $0x2d,%al
  8019cf:	75 0a                	jne    8019db <strtol+0x4c>
		s++, neg = 1;
  8019d1:	ff 45 08             	incl   0x8(%ebp)
  8019d4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8019db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019df:	74 06                	je     8019e7 <strtol+0x58>
  8019e1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8019e5:	75 20                	jne    801a07 <strtol+0x78>
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	3c 30                	cmp    $0x30,%al
  8019ee:	75 17                	jne    801a07 <strtol+0x78>
  8019f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f3:	40                   	inc    %eax
  8019f4:	8a 00                	mov    (%eax),%al
  8019f6:	3c 78                	cmp    $0x78,%al
  8019f8:	75 0d                	jne    801a07 <strtol+0x78>
		s += 2, base = 16;
  8019fa:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8019fe:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801a05:	eb 28                	jmp    801a2f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801a07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a0b:	75 15                	jne    801a22 <strtol+0x93>
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	8a 00                	mov    (%eax),%al
  801a12:	3c 30                	cmp    $0x30,%al
  801a14:	75 0c                	jne    801a22 <strtol+0x93>
		s++, base = 8;
  801a16:	ff 45 08             	incl   0x8(%ebp)
  801a19:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a20:	eb 0d                	jmp    801a2f <strtol+0xa0>
	else if (base == 0)
  801a22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a26:	75 07                	jne    801a2f <strtol+0xa0>
		base = 10;
  801a28:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a32:	8a 00                	mov    (%eax),%al
  801a34:	3c 2f                	cmp    $0x2f,%al
  801a36:	7e 19                	jle    801a51 <strtol+0xc2>
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	8a 00                	mov    (%eax),%al
  801a3d:	3c 39                	cmp    $0x39,%al
  801a3f:	7f 10                	jg     801a51 <strtol+0xc2>
			dig = *s - '0';
  801a41:	8b 45 08             	mov    0x8(%ebp),%eax
  801a44:	8a 00                	mov    (%eax),%al
  801a46:	0f be c0             	movsbl %al,%eax
  801a49:	83 e8 30             	sub    $0x30,%eax
  801a4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a4f:	eb 42                	jmp    801a93 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a51:	8b 45 08             	mov    0x8(%ebp),%eax
  801a54:	8a 00                	mov    (%eax),%al
  801a56:	3c 60                	cmp    $0x60,%al
  801a58:	7e 19                	jle    801a73 <strtol+0xe4>
  801a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5d:	8a 00                	mov    (%eax),%al
  801a5f:	3c 7a                	cmp    $0x7a,%al
  801a61:	7f 10                	jg     801a73 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8a 00                	mov    (%eax),%al
  801a68:	0f be c0             	movsbl %al,%eax
  801a6b:	83 e8 57             	sub    $0x57,%eax
  801a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a71:	eb 20                	jmp    801a93 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a73:	8b 45 08             	mov    0x8(%ebp),%eax
  801a76:	8a 00                	mov    (%eax),%al
  801a78:	3c 40                	cmp    $0x40,%al
  801a7a:	7e 39                	jle    801ab5 <strtol+0x126>
  801a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7f:	8a 00                	mov    (%eax),%al
  801a81:	3c 5a                	cmp    $0x5a,%al
  801a83:	7f 30                	jg     801ab5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	8a 00                	mov    (%eax),%al
  801a8a:	0f be c0             	movsbl %al,%eax
  801a8d:	83 e8 37             	sub    $0x37,%eax
  801a90:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a96:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a99:	7d 19                	jge    801ab4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a9b:	ff 45 08             	incl   0x8(%ebp)
  801a9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aa1:	0f af 45 10          	imul   0x10(%ebp),%eax
  801aa5:	89 c2                	mov    %eax,%edx
  801aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aaa:	01 d0                	add    %edx,%eax
  801aac:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801aaf:	e9 7b ff ff ff       	jmp    801a2f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801ab4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801ab5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ab9:	74 08                	je     801ac3 <strtol+0x134>
		*endptr = (char *) s;
  801abb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801abe:	8b 55 08             	mov    0x8(%ebp),%edx
  801ac1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801ac3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ac7:	74 07                	je     801ad0 <strtol+0x141>
  801ac9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801acc:	f7 d8                	neg    %eax
  801ace:	eb 03                	jmp    801ad3 <strtol+0x144>
  801ad0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <ltostr>:

void
ltostr(long value, char *str)
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
  801ad8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801adb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801ae2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801ae9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801aed:	79 13                	jns    801b02 <ltostr+0x2d>
	{
		neg = 1;
  801aef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801afc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801aff:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801b02:	8b 45 08             	mov    0x8(%ebp),%eax
  801b05:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801b0a:	99                   	cltd   
  801b0b:	f7 f9                	idiv   %ecx
  801b0d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b13:	8d 50 01             	lea    0x1(%eax),%edx
  801b16:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b19:	89 c2                	mov    %eax,%edx
  801b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b1e:	01 d0                	add    %edx,%eax
  801b20:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b23:	83 c2 30             	add    $0x30,%edx
  801b26:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b28:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b2b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b30:	f7 e9                	imul   %ecx
  801b32:	c1 fa 02             	sar    $0x2,%edx
  801b35:	89 c8                	mov    %ecx,%eax
  801b37:	c1 f8 1f             	sar    $0x1f,%eax
  801b3a:	29 c2                	sub    %eax,%edx
  801b3c:	89 d0                	mov    %edx,%eax
  801b3e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801b41:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b44:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b49:	f7 e9                	imul   %ecx
  801b4b:	c1 fa 02             	sar    $0x2,%edx
  801b4e:	89 c8                	mov    %ecx,%eax
  801b50:	c1 f8 1f             	sar    $0x1f,%eax
  801b53:	29 c2                	sub    %eax,%edx
  801b55:	89 d0                	mov    %edx,%eax
  801b57:	c1 e0 02             	shl    $0x2,%eax
  801b5a:	01 d0                	add    %edx,%eax
  801b5c:	01 c0                	add    %eax,%eax
  801b5e:	29 c1                	sub    %eax,%ecx
  801b60:	89 ca                	mov    %ecx,%edx
  801b62:	85 d2                	test   %edx,%edx
  801b64:	75 9c                	jne    801b02 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b70:	48                   	dec    %eax
  801b71:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b74:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b78:	74 3d                	je     801bb7 <ltostr+0xe2>
		start = 1 ;
  801b7a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b81:	eb 34                	jmp    801bb7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801b83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b89:	01 d0                	add    %edx,%eax
  801b8b:	8a 00                	mov    (%eax),%al
  801b8d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b96:	01 c2                	add    %eax,%edx
  801b98:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b9e:	01 c8                	add    %ecx,%eax
  801ba0:	8a 00                	mov    (%eax),%al
  801ba2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801ba4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801baa:	01 c2                	add    %eax,%edx
  801bac:	8a 45 eb             	mov    -0x15(%ebp),%al
  801baf:	88 02                	mov    %al,(%edx)
		start++ ;
  801bb1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801bb4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bbd:	7c c4                	jl     801b83 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801bbf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc5:	01 d0                	add    %edx,%eax
  801bc7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801bca:	90                   	nop
  801bcb:	c9                   	leave  
  801bcc:	c3                   	ret    

00801bcd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801bcd:	55                   	push   %ebp
  801bce:	89 e5                	mov    %esp,%ebp
  801bd0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801bd3:	ff 75 08             	pushl  0x8(%ebp)
  801bd6:	e8 54 fa ff ff       	call   80162f <strlen>
  801bdb:	83 c4 04             	add    $0x4,%esp
  801bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801be1:	ff 75 0c             	pushl  0xc(%ebp)
  801be4:	e8 46 fa ff ff       	call   80162f <strlen>
  801be9:	83 c4 04             	add    $0x4,%esp
  801bec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801bef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801bf6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bfd:	eb 17                	jmp    801c16 <strcconcat+0x49>
		final[s] = str1[s] ;
  801bff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c02:	8b 45 10             	mov    0x10(%ebp),%eax
  801c05:	01 c2                	add    %eax,%edx
  801c07:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0d:	01 c8                	add    %ecx,%eax
  801c0f:	8a 00                	mov    (%eax),%al
  801c11:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c13:	ff 45 fc             	incl   -0x4(%ebp)
  801c16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c19:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c1c:	7c e1                	jl     801bff <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c1e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c2c:	eb 1f                	jmp    801c4d <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c31:	8d 50 01             	lea    0x1(%eax),%edx
  801c34:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c37:	89 c2                	mov    %eax,%edx
  801c39:	8b 45 10             	mov    0x10(%ebp),%eax
  801c3c:	01 c2                	add    %eax,%edx
  801c3e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c41:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c44:	01 c8                	add    %ecx,%eax
  801c46:	8a 00                	mov    (%eax),%al
  801c48:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c4a:	ff 45 f8             	incl   -0x8(%ebp)
  801c4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c50:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c53:	7c d9                	jl     801c2e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c55:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c58:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5b:	01 d0                	add    %edx,%eax
  801c5d:	c6 00 00             	movb   $0x0,(%eax)
}
  801c60:	90                   	nop
  801c61:	c9                   	leave  
  801c62:	c3                   	ret    

00801c63 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c66:	8b 45 14             	mov    0x14(%ebp),%eax
  801c69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  801c72:	8b 00                	mov    (%eax),%eax
  801c74:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c7b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c7e:	01 d0                	add    %edx,%eax
  801c80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c86:	eb 0c                	jmp    801c94 <strsplit+0x31>
			*string++ = 0;
  801c88:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8b:	8d 50 01             	lea    0x1(%eax),%edx
  801c8e:	89 55 08             	mov    %edx,0x8(%ebp)
  801c91:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c94:	8b 45 08             	mov    0x8(%ebp),%eax
  801c97:	8a 00                	mov    (%eax),%al
  801c99:	84 c0                	test   %al,%al
  801c9b:	74 18                	je     801cb5 <strsplit+0x52>
  801c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca0:	8a 00                	mov    (%eax),%al
  801ca2:	0f be c0             	movsbl %al,%eax
  801ca5:	50                   	push   %eax
  801ca6:	ff 75 0c             	pushl  0xc(%ebp)
  801ca9:	e8 13 fb ff ff       	call   8017c1 <strchr>
  801cae:	83 c4 08             	add    $0x8,%esp
  801cb1:	85 c0                	test   %eax,%eax
  801cb3:	75 d3                	jne    801c88 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb8:	8a 00                	mov    (%eax),%al
  801cba:	84 c0                	test   %al,%al
  801cbc:	74 5a                	je     801d18 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801cbe:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc1:	8b 00                	mov    (%eax),%eax
  801cc3:	83 f8 0f             	cmp    $0xf,%eax
  801cc6:	75 07                	jne    801ccf <strsplit+0x6c>
		{
			return 0;
  801cc8:	b8 00 00 00 00       	mov    $0x0,%eax
  801ccd:	eb 66                	jmp    801d35 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ccf:	8b 45 14             	mov    0x14(%ebp),%eax
  801cd2:	8b 00                	mov    (%eax),%eax
  801cd4:	8d 48 01             	lea    0x1(%eax),%ecx
  801cd7:	8b 55 14             	mov    0x14(%ebp),%edx
  801cda:	89 0a                	mov    %ecx,(%edx)
  801cdc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ce3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce6:	01 c2                	add    %eax,%edx
  801ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ceb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ced:	eb 03                	jmp    801cf2 <strsplit+0x8f>
			string++;
  801cef:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf5:	8a 00                	mov    (%eax),%al
  801cf7:	84 c0                	test   %al,%al
  801cf9:	74 8b                	je     801c86 <strsplit+0x23>
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	8a 00                	mov    (%eax),%al
  801d00:	0f be c0             	movsbl %al,%eax
  801d03:	50                   	push   %eax
  801d04:	ff 75 0c             	pushl  0xc(%ebp)
  801d07:	e8 b5 fa ff ff       	call   8017c1 <strchr>
  801d0c:	83 c4 08             	add    $0x8,%esp
  801d0f:	85 c0                	test   %eax,%eax
  801d11:	74 dc                	je     801cef <strsplit+0x8c>
			string++;
	}
  801d13:	e9 6e ff ff ff       	jmp    801c86 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d18:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d19:	8b 45 14             	mov    0x14(%ebp),%eax
  801d1c:	8b 00                	mov    (%eax),%eax
  801d1e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d25:	8b 45 10             	mov    0x10(%ebp),%eax
  801d28:	01 d0                	add    %edx,%eax
  801d2a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d30:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
  801d3a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801d3d:	83 ec 04             	sub    $0x4,%esp
  801d40:	68 90 2c 80 00       	push   $0x802c90
  801d45:	6a 19                	push   $0x19
  801d47:	68 b5 2c 80 00       	push   $0x802cb5
  801d4c:	e8 a8 ef ff ff       	call   800cf9 <_panic>

00801d51 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
  801d54:	83 ec 18             	sub    $0x18,%esp
  801d57:	8b 45 10             	mov    0x10(%ebp),%eax
  801d5a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801d5d:	83 ec 04             	sub    $0x4,%esp
  801d60:	68 c4 2c 80 00       	push   $0x802cc4
  801d65:	6a 30                	push   $0x30
  801d67:	68 b5 2c 80 00       	push   $0x802cb5
  801d6c:	e8 88 ef ff ff       	call   800cf9 <_panic>

00801d71 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
  801d74:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801d77:	83 ec 04             	sub    $0x4,%esp
  801d7a:	68 e3 2c 80 00       	push   $0x802ce3
  801d7f:	6a 36                	push   $0x36
  801d81:	68 b5 2c 80 00       	push   $0x802cb5
  801d86:	e8 6e ef ff ff       	call   800cf9 <_panic>

00801d8b <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
  801d8e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801d91:	83 ec 04             	sub    $0x4,%esp
  801d94:	68 00 2d 80 00       	push   $0x802d00
  801d99:	6a 48                	push   $0x48
  801d9b:	68 b5 2c 80 00       	push   $0x802cb5
  801da0:	e8 54 ef ff ff       	call   800cf9 <_panic>

00801da5 <sfree>:

}


void sfree(void* virtual_address)
{
  801da5:	55                   	push   %ebp
  801da6:	89 e5                	mov    %esp,%ebp
  801da8:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801dab:	83 ec 04             	sub    $0x4,%esp
  801dae:	68 23 2d 80 00       	push   $0x802d23
  801db3:	6a 53                	push   $0x53
  801db5:	68 b5 2c 80 00       	push   $0x802cb5
  801dba:	e8 3a ef ff ff       	call   800cf9 <_panic>

00801dbf <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801dbf:	55                   	push   %ebp
  801dc0:	89 e5                	mov    %esp,%ebp
  801dc2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801dc5:	83 ec 04             	sub    $0x4,%esp
  801dc8:	68 40 2d 80 00       	push   $0x802d40
  801dcd:	6a 6c                	push   $0x6c
  801dcf:	68 b5 2c 80 00       	push   $0x802cb5
  801dd4:	e8 20 ef ff ff       	call   800cf9 <_panic>

00801dd9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801dd9:	55                   	push   %ebp
  801dda:	89 e5                	mov    %esp,%ebp
  801ddc:	57                   	push   %edi
  801ddd:	56                   	push   %esi
  801dde:	53                   	push   %ebx
  801ddf:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801de2:	8b 45 08             	mov    0x8(%ebp),%eax
  801de5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801deb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dee:	8b 7d 18             	mov    0x18(%ebp),%edi
  801df1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801df4:	cd 30                	int    $0x30
  801df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801df9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801dfc:	83 c4 10             	add    $0x10,%esp
  801dff:	5b                   	pop    %ebx
  801e00:	5e                   	pop    %esi
  801e01:	5f                   	pop    %edi
  801e02:	5d                   	pop    %ebp
  801e03:	c3                   	ret    

00801e04 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
  801e07:	83 ec 04             	sub    $0x4,%esp
  801e0a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e0d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e10:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	52                   	push   %edx
  801e1c:	ff 75 0c             	pushl  0xc(%ebp)
  801e1f:	50                   	push   %eax
  801e20:	6a 00                	push   $0x0
  801e22:	e8 b2 ff ff ff       	call   801dd9 <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	90                   	nop
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_cgetc>:

int
sys_cgetc(void)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 01                	push   $0x1
  801e3c:	e8 98 ff ff ff       	call   801dd9 <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e49:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	50                   	push   %eax
  801e55:	6a 05                	push   $0x5
  801e57:	e8 7d ff ff ff       	call   801dd9 <syscall>
  801e5c:	83 c4 18             	add    $0x18,%esp
}
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 02                	push   $0x2
  801e70:	e8 64 ff ff ff       	call   801dd9 <syscall>
  801e75:	83 c4 18             	add    $0x18,%esp
}
  801e78:	c9                   	leave  
  801e79:	c3                   	ret    

00801e7a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e7a:	55                   	push   %ebp
  801e7b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 03                	push   $0x3
  801e89:	e8 4b ff ff ff       	call   801dd9 <syscall>
  801e8e:	83 c4 18             	add    $0x18,%esp
}
  801e91:	c9                   	leave  
  801e92:	c3                   	ret    

00801e93 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e93:	55                   	push   %ebp
  801e94:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 04                	push   $0x4
  801ea2:	e8 32 ff ff ff       	call   801dd9 <syscall>
  801ea7:	83 c4 18             	add    $0x18,%esp
}
  801eaa:	c9                   	leave  
  801eab:	c3                   	ret    

00801eac <sys_env_exit>:


void sys_env_exit(void)
{
  801eac:	55                   	push   %ebp
  801ead:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 06                	push   $0x6
  801ebb:	e8 19 ff ff ff       	call   801dd9 <syscall>
  801ec0:	83 c4 18             	add    $0x18,%esp
}
  801ec3:	90                   	nop
  801ec4:	c9                   	leave  
  801ec5:	c3                   	ret    

00801ec6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ec6:	55                   	push   %ebp
  801ec7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ec9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	52                   	push   %edx
  801ed6:	50                   	push   %eax
  801ed7:	6a 07                	push   $0x7
  801ed9:	e8 fb fe ff ff       	call   801dd9 <syscall>
  801ede:	83 c4 18             	add    $0x18,%esp
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
  801ee6:	56                   	push   %esi
  801ee7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ee8:	8b 75 18             	mov    0x18(%ebp),%esi
  801eeb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801eee:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef7:	56                   	push   %esi
  801ef8:	53                   	push   %ebx
  801ef9:	51                   	push   %ecx
  801efa:	52                   	push   %edx
  801efb:	50                   	push   %eax
  801efc:	6a 08                	push   $0x8
  801efe:	e8 d6 fe ff ff       	call   801dd9 <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
}
  801f06:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f09:	5b                   	pop    %ebx
  801f0a:	5e                   	pop    %esi
  801f0b:	5d                   	pop    %ebp
  801f0c:	c3                   	ret    

00801f0d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f13:	8b 45 08             	mov    0x8(%ebp),%eax
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	52                   	push   %edx
  801f1d:	50                   	push   %eax
  801f1e:	6a 09                	push   $0x9
  801f20:	e8 b4 fe ff ff       	call   801dd9 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	ff 75 0c             	pushl  0xc(%ebp)
  801f36:	ff 75 08             	pushl  0x8(%ebp)
  801f39:	6a 0a                	push   $0xa
  801f3b:	e8 99 fe ff ff       	call   801dd9 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
}
  801f43:	c9                   	leave  
  801f44:	c3                   	ret    

00801f45 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f45:	55                   	push   %ebp
  801f46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 0b                	push   $0xb
  801f54:	e8 80 fe ff ff       	call   801dd9 <syscall>
  801f59:	83 c4 18             	add    $0x18,%esp
}
  801f5c:	c9                   	leave  
  801f5d:	c3                   	ret    

00801f5e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f5e:	55                   	push   %ebp
  801f5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 0c                	push   $0xc
  801f6d:	e8 67 fe ff ff       	call   801dd9 <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
}
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 0d                	push   $0xd
  801f86:	e8 4e fe ff ff       	call   801dd9 <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	ff 75 0c             	pushl  0xc(%ebp)
  801f9c:	ff 75 08             	pushl  0x8(%ebp)
  801f9f:	6a 11                	push   $0x11
  801fa1:	e8 33 fe ff ff       	call   801dd9 <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
	return;
  801fa9:	90                   	nop
}
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	ff 75 0c             	pushl  0xc(%ebp)
  801fb8:	ff 75 08             	pushl  0x8(%ebp)
  801fbb:	6a 12                	push   $0x12
  801fbd:	e8 17 fe ff ff       	call   801dd9 <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc5:	90                   	nop
}
  801fc6:	c9                   	leave  
  801fc7:	c3                   	ret    

00801fc8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 0e                	push   $0xe
  801fd7:	e8 fd fd ff ff       	call   801dd9 <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	ff 75 08             	pushl  0x8(%ebp)
  801fef:	6a 0f                	push   $0xf
  801ff1:	e8 e3 fd ff ff       	call   801dd9 <syscall>
  801ff6:	83 c4 18             	add    $0x18,%esp
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 10                	push   $0x10
  80200a:	e8 ca fd ff ff       	call   801dd9 <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	90                   	nop
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 14                	push   $0x14
  802024:	e8 b0 fd ff ff       	call   801dd9 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
}
  80202c:	90                   	nop
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 15                	push   $0x15
  80203e:	e8 96 fd ff ff       	call   801dd9 <syscall>
  802043:	83 c4 18             	add    $0x18,%esp
}
  802046:	90                   	nop
  802047:	c9                   	leave  
  802048:	c3                   	ret    

00802049 <sys_cputc>:


void
sys_cputc(const char c)
{
  802049:	55                   	push   %ebp
  80204a:	89 e5                	mov    %esp,%ebp
  80204c:	83 ec 04             	sub    $0x4,%esp
  80204f:	8b 45 08             	mov    0x8(%ebp),%eax
  802052:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802055:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	50                   	push   %eax
  802062:	6a 16                	push   $0x16
  802064:	e8 70 fd ff ff       	call   801dd9 <syscall>
  802069:	83 c4 18             	add    $0x18,%esp
}
  80206c:	90                   	nop
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 17                	push   $0x17
  80207e:	e8 56 fd ff ff       	call   801dd9 <syscall>
  802083:	83 c4 18             	add    $0x18,%esp
}
  802086:	90                   	nop
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80208c:	8b 45 08             	mov    0x8(%ebp),%eax
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	ff 75 0c             	pushl  0xc(%ebp)
  802098:	50                   	push   %eax
  802099:	6a 18                	push   $0x18
  80209b:	e8 39 fd ff ff       	call   801dd9 <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	52                   	push   %edx
  8020b5:	50                   	push   %eax
  8020b6:	6a 1b                	push   $0x1b
  8020b8:	e8 1c fd ff ff       	call   801dd9 <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	52                   	push   %edx
  8020d2:	50                   	push   %eax
  8020d3:	6a 19                	push   $0x19
  8020d5:	e8 ff fc ff ff       	call   801dd9 <syscall>
  8020da:	83 c4 18             	add    $0x18,%esp
}
  8020dd:	90                   	nop
  8020de:	c9                   	leave  
  8020df:	c3                   	ret    

008020e0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020e0:	55                   	push   %ebp
  8020e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	52                   	push   %edx
  8020f0:	50                   	push   %eax
  8020f1:	6a 1a                	push   $0x1a
  8020f3:	e8 e1 fc ff ff       	call   801dd9 <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
}
  8020fb:	90                   	nop
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
  802101:	83 ec 04             	sub    $0x4,%esp
  802104:	8b 45 10             	mov    0x10(%ebp),%eax
  802107:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80210a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80210d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802111:	8b 45 08             	mov    0x8(%ebp),%eax
  802114:	6a 00                	push   $0x0
  802116:	51                   	push   %ecx
  802117:	52                   	push   %edx
  802118:	ff 75 0c             	pushl  0xc(%ebp)
  80211b:	50                   	push   %eax
  80211c:	6a 1c                	push   $0x1c
  80211e:	e8 b6 fc ff ff       	call   801dd9 <syscall>
  802123:	83 c4 18             	add    $0x18,%esp
}
  802126:	c9                   	leave  
  802127:	c3                   	ret    

00802128 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80212b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212e:	8b 45 08             	mov    0x8(%ebp),%eax
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	52                   	push   %edx
  802138:	50                   	push   %eax
  802139:	6a 1d                	push   $0x1d
  80213b:	e8 99 fc ff ff       	call   801dd9 <syscall>
  802140:	83 c4 18             	add    $0x18,%esp
}
  802143:	c9                   	leave  
  802144:	c3                   	ret    

00802145 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802145:	55                   	push   %ebp
  802146:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802148:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80214b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80214e:	8b 45 08             	mov    0x8(%ebp),%eax
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	51                   	push   %ecx
  802156:	52                   	push   %edx
  802157:	50                   	push   %eax
  802158:	6a 1e                	push   $0x1e
  80215a:	e8 7a fc ff ff       	call   801dd9 <syscall>
  80215f:	83 c4 18             	add    $0x18,%esp
}
  802162:	c9                   	leave  
  802163:	c3                   	ret    

00802164 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802164:	55                   	push   %ebp
  802165:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802167:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216a:	8b 45 08             	mov    0x8(%ebp),%eax
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	52                   	push   %edx
  802174:	50                   	push   %eax
  802175:	6a 1f                	push   $0x1f
  802177:	e8 5d fc ff ff       	call   801dd9 <syscall>
  80217c:	83 c4 18             	add    $0x18,%esp
}
  80217f:	c9                   	leave  
  802180:	c3                   	ret    

00802181 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802181:	55                   	push   %ebp
  802182:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 20                	push   $0x20
  802190:	e8 44 fc ff ff       	call   801dd9 <syscall>
  802195:	83 c4 18             	add    $0x18,%esp
}
  802198:	c9                   	leave  
  802199:	c3                   	ret    

0080219a <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80219a:	55                   	push   %ebp
  80219b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80219d:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	ff 75 10             	pushl  0x10(%ebp)
  8021a7:	ff 75 0c             	pushl  0xc(%ebp)
  8021aa:	50                   	push   %eax
  8021ab:	6a 21                	push   $0x21
  8021ad:	e8 27 fc ff ff       	call   801dd9 <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
}
  8021b5:	c9                   	leave  
  8021b6:	c3                   	ret    

008021b7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8021b7:	55                   	push   %ebp
  8021b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	50                   	push   %eax
  8021c6:	6a 22                	push   $0x22
  8021c8:	e8 0c fc ff ff       	call   801dd9 <syscall>
  8021cd:	83 c4 18             	add    $0x18,%esp
}
  8021d0:	90                   	nop
  8021d1:	c9                   	leave  
  8021d2:	c3                   	ret    

008021d3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021d3:	55                   	push   %ebp
  8021d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	50                   	push   %eax
  8021e2:	6a 23                	push   $0x23
  8021e4:	e8 f0 fb ff ff       	call   801dd9 <syscall>
  8021e9:	83 c4 18             	add    $0x18,%esp
}
  8021ec:	90                   	nop
  8021ed:	c9                   	leave  
  8021ee:	c3                   	ret    

008021ef <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021ef:	55                   	push   %ebp
  8021f0:	89 e5                	mov    %esp,%ebp
  8021f2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021f5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021f8:	8d 50 04             	lea    0x4(%eax),%edx
  8021fb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	52                   	push   %edx
  802205:	50                   	push   %eax
  802206:	6a 24                	push   $0x24
  802208:	e8 cc fb ff ff       	call   801dd9 <syscall>
  80220d:	83 c4 18             	add    $0x18,%esp
	return result;
  802210:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802213:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802216:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802219:	89 01                	mov    %eax,(%ecx)
  80221b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80221e:	8b 45 08             	mov    0x8(%ebp),%eax
  802221:	c9                   	leave  
  802222:	c2 04 00             	ret    $0x4

00802225 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802225:	55                   	push   %ebp
  802226:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	ff 75 10             	pushl  0x10(%ebp)
  80222f:	ff 75 0c             	pushl  0xc(%ebp)
  802232:	ff 75 08             	pushl  0x8(%ebp)
  802235:	6a 13                	push   $0x13
  802237:	e8 9d fb ff ff       	call   801dd9 <syscall>
  80223c:	83 c4 18             	add    $0x18,%esp
	return ;
  80223f:	90                   	nop
}
  802240:	c9                   	leave  
  802241:	c3                   	ret    

00802242 <sys_rcr2>:
uint32 sys_rcr2()
{
  802242:	55                   	push   %ebp
  802243:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802245:	6a 00                	push   $0x0
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	6a 25                	push   $0x25
  802251:	e8 83 fb ff ff       	call   801dd9 <syscall>
  802256:	83 c4 18             	add    $0x18,%esp
}
  802259:	c9                   	leave  
  80225a:	c3                   	ret    

0080225b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80225b:	55                   	push   %ebp
  80225c:	89 e5                	mov    %esp,%ebp
  80225e:	83 ec 04             	sub    $0x4,%esp
  802261:	8b 45 08             	mov    0x8(%ebp),%eax
  802264:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802267:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	50                   	push   %eax
  802274:	6a 26                	push   $0x26
  802276:	e8 5e fb ff ff       	call   801dd9 <syscall>
  80227b:	83 c4 18             	add    $0x18,%esp
	return ;
  80227e:	90                   	nop
}
  80227f:	c9                   	leave  
  802280:	c3                   	ret    

00802281 <rsttst>:
void rsttst()
{
  802281:	55                   	push   %ebp
  802282:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	6a 00                	push   $0x0
  80228c:	6a 00                	push   $0x0
  80228e:	6a 28                	push   $0x28
  802290:	e8 44 fb ff ff       	call   801dd9 <syscall>
  802295:	83 c4 18             	add    $0x18,%esp
	return ;
  802298:	90                   	nop
}
  802299:	c9                   	leave  
  80229a:	c3                   	ret    

0080229b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80229b:	55                   	push   %ebp
  80229c:	89 e5                	mov    %esp,%ebp
  80229e:	83 ec 04             	sub    $0x4,%esp
  8022a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8022a4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022a7:	8b 55 18             	mov    0x18(%ebp),%edx
  8022aa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022ae:	52                   	push   %edx
  8022af:	50                   	push   %eax
  8022b0:	ff 75 10             	pushl  0x10(%ebp)
  8022b3:	ff 75 0c             	pushl  0xc(%ebp)
  8022b6:	ff 75 08             	pushl  0x8(%ebp)
  8022b9:	6a 27                	push   $0x27
  8022bb:	e8 19 fb ff ff       	call   801dd9 <syscall>
  8022c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c3:	90                   	nop
}
  8022c4:	c9                   	leave  
  8022c5:	c3                   	ret    

008022c6 <chktst>:
void chktst(uint32 n)
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	ff 75 08             	pushl  0x8(%ebp)
  8022d4:	6a 29                	push   $0x29
  8022d6:	e8 fe fa ff ff       	call   801dd9 <syscall>
  8022db:	83 c4 18             	add    $0x18,%esp
	return ;
  8022de:	90                   	nop
}
  8022df:	c9                   	leave  
  8022e0:	c3                   	ret    

008022e1 <inctst>:

void inctst()
{
  8022e1:	55                   	push   %ebp
  8022e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 2a                	push   $0x2a
  8022f0:	e8 e4 fa ff ff       	call   801dd9 <syscall>
  8022f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f8:	90                   	nop
}
  8022f9:	c9                   	leave  
  8022fa:	c3                   	ret    

008022fb <gettst>:
uint32 gettst()
{
  8022fb:	55                   	push   %ebp
  8022fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022fe:	6a 00                	push   $0x0
  802300:	6a 00                	push   $0x0
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	6a 00                	push   $0x0
  802308:	6a 2b                	push   $0x2b
  80230a:	e8 ca fa ff ff       	call   801dd9 <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
}
  802312:	c9                   	leave  
  802313:	c3                   	ret    

00802314 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802314:	55                   	push   %ebp
  802315:	89 e5                	mov    %esp,%ebp
  802317:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	6a 00                	push   $0x0
  802324:	6a 2c                	push   $0x2c
  802326:	e8 ae fa ff ff       	call   801dd9 <syscall>
  80232b:	83 c4 18             	add    $0x18,%esp
  80232e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802331:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802335:	75 07                	jne    80233e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802337:	b8 01 00 00 00       	mov    $0x1,%eax
  80233c:	eb 05                	jmp    802343 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80233e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802343:	c9                   	leave  
  802344:	c3                   	ret    

00802345 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802345:	55                   	push   %ebp
  802346:	89 e5                	mov    %esp,%ebp
  802348:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 2c                	push   $0x2c
  802357:	e8 7d fa ff ff       	call   801dd9 <syscall>
  80235c:	83 c4 18             	add    $0x18,%esp
  80235f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802362:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802366:	75 07                	jne    80236f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802368:	b8 01 00 00 00       	mov    $0x1,%eax
  80236d:	eb 05                	jmp    802374 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80236f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802374:	c9                   	leave  
  802375:	c3                   	ret    

00802376 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802376:	55                   	push   %ebp
  802377:	89 e5                	mov    %esp,%ebp
  802379:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	6a 2c                	push   $0x2c
  802388:	e8 4c fa ff ff       	call   801dd9 <syscall>
  80238d:	83 c4 18             	add    $0x18,%esp
  802390:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802393:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802397:	75 07                	jne    8023a0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802399:	b8 01 00 00 00       	mov    $0x1,%eax
  80239e:	eb 05                	jmp    8023a5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8023a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023a5:	c9                   	leave  
  8023a6:	c3                   	ret    

008023a7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8023a7:	55                   	push   %ebp
  8023a8:	89 e5                	mov    %esp,%ebp
  8023aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	6a 00                	push   $0x0
  8023b3:	6a 00                	push   $0x0
  8023b5:	6a 00                	push   $0x0
  8023b7:	6a 2c                	push   $0x2c
  8023b9:	e8 1b fa ff ff       	call   801dd9 <syscall>
  8023be:	83 c4 18             	add    $0x18,%esp
  8023c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023c4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023c8:	75 07                	jne    8023d1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8023cf:	eb 05                	jmp    8023d6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023d6:	c9                   	leave  
  8023d7:	c3                   	ret    

008023d8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023d8:	55                   	push   %ebp
  8023d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 00                	push   $0x0
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	ff 75 08             	pushl  0x8(%ebp)
  8023e6:	6a 2d                	push   $0x2d
  8023e8:	e8 ec f9 ff ff       	call   801dd9 <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8023f0:	90                   	nop
}
  8023f1:	c9                   	leave  
  8023f2:	c3                   	ret    
  8023f3:	90                   	nop

008023f4 <__udivdi3>:
  8023f4:	55                   	push   %ebp
  8023f5:	57                   	push   %edi
  8023f6:	56                   	push   %esi
  8023f7:	53                   	push   %ebx
  8023f8:	83 ec 1c             	sub    $0x1c,%esp
  8023fb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023ff:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802403:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802407:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80240b:	89 ca                	mov    %ecx,%edx
  80240d:	89 f8                	mov    %edi,%eax
  80240f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802413:	85 f6                	test   %esi,%esi
  802415:	75 2d                	jne    802444 <__udivdi3+0x50>
  802417:	39 cf                	cmp    %ecx,%edi
  802419:	77 65                	ja     802480 <__udivdi3+0x8c>
  80241b:	89 fd                	mov    %edi,%ebp
  80241d:	85 ff                	test   %edi,%edi
  80241f:	75 0b                	jne    80242c <__udivdi3+0x38>
  802421:	b8 01 00 00 00       	mov    $0x1,%eax
  802426:	31 d2                	xor    %edx,%edx
  802428:	f7 f7                	div    %edi
  80242a:	89 c5                	mov    %eax,%ebp
  80242c:	31 d2                	xor    %edx,%edx
  80242e:	89 c8                	mov    %ecx,%eax
  802430:	f7 f5                	div    %ebp
  802432:	89 c1                	mov    %eax,%ecx
  802434:	89 d8                	mov    %ebx,%eax
  802436:	f7 f5                	div    %ebp
  802438:	89 cf                	mov    %ecx,%edi
  80243a:	89 fa                	mov    %edi,%edx
  80243c:	83 c4 1c             	add    $0x1c,%esp
  80243f:	5b                   	pop    %ebx
  802440:	5e                   	pop    %esi
  802441:	5f                   	pop    %edi
  802442:	5d                   	pop    %ebp
  802443:	c3                   	ret    
  802444:	39 ce                	cmp    %ecx,%esi
  802446:	77 28                	ja     802470 <__udivdi3+0x7c>
  802448:	0f bd fe             	bsr    %esi,%edi
  80244b:	83 f7 1f             	xor    $0x1f,%edi
  80244e:	75 40                	jne    802490 <__udivdi3+0x9c>
  802450:	39 ce                	cmp    %ecx,%esi
  802452:	72 0a                	jb     80245e <__udivdi3+0x6a>
  802454:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802458:	0f 87 9e 00 00 00    	ja     8024fc <__udivdi3+0x108>
  80245e:	b8 01 00 00 00       	mov    $0x1,%eax
  802463:	89 fa                	mov    %edi,%edx
  802465:	83 c4 1c             	add    $0x1c,%esp
  802468:	5b                   	pop    %ebx
  802469:	5e                   	pop    %esi
  80246a:	5f                   	pop    %edi
  80246b:	5d                   	pop    %ebp
  80246c:	c3                   	ret    
  80246d:	8d 76 00             	lea    0x0(%esi),%esi
  802470:	31 ff                	xor    %edi,%edi
  802472:	31 c0                	xor    %eax,%eax
  802474:	89 fa                	mov    %edi,%edx
  802476:	83 c4 1c             	add    $0x1c,%esp
  802479:	5b                   	pop    %ebx
  80247a:	5e                   	pop    %esi
  80247b:	5f                   	pop    %edi
  80247c:	5d                   	pop    %ebp
  80247d:	c3                   	ret    
  80247e:	66 90                	xchg   %ax,%ax
  802480:	89 d8                	mov    %ebx,%eax
  802482:	f7 f7                	div    %edi
  802484:	31 ff                	xor    %edi,%edi
  802486:	89 fa                	mov    %edi,%edx
  802488:	83 c4 1c             	add    $0x1c,%esp
  80248b:	5b                   	pop    %ebx
  80248c:	5e                   	pop    %esi
  80248d:	5f                   	pop    %edi
  80248e:	5d                   	pop    %ebp
  80248f:	c3                   	ret    
  802490:	bd 20 00 00 00       	mov    $0x20,%ebp
  802495:	89 eb                	mov    %ebp,%ebx
  802497:	29 fb                	sub    %edi,%ebx
  802499:	89 f9                	mov    %edi,%ecx
  80249b:	d3 e6                	shl    %cl,%esi
  80249d:	89 c5                	mov    %eax,%ebp
  80249f:	88 d9                	mov    %bl,%cl
  8024a1:	d3 ed                	shr    %cl,%ebp
  8024a3:	89 e9                	mov    %ebp,%ecx
  8024a5:	09 f1                	or     %esi,%ecx
  8024a7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024ab:	89 f9                	mov    %edi,%ecx
  8024ad:	d3 e0                	shl    %cl,%eax
  8024af:	89 c5                	mov    %eax,%ebp
  8024b1:	89 d6                	mov    %edx,%esi
  8024b3:	88 d9                	mov    %bl,%cl
  8024b5:	d3 ee                	shr    %cl,%esi
  8024b7:	89 f9                	mov    %edi,%ecx
  8024b9:	d3 e2                	shl    %cl,%edx
  8024bb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024bf:	88 d9                	mov    %bl,%cl
  8024c1:	d3 e8                	shr    %cl,%eax
  8024c3:	09 c2                	or     %eax,%edx
  8024c5:	89 d0                	mov    %edx,%eax
  8024c7:	89 f2                	mov    %esi,%edx
  8024c9:	f7 74 24 0c          	divl   0xc(%esp)
  8024cd:	89 d6                	mov    %edx,%esi
  8024cf:	89 c3                	mov    %eax,%ebx
  8024d1:	f7 e5                	mul    %ebp
  8024d3:	39 d6                	cmp    %edx,%esi
  8024d5:	72 19                	jb     8024f0 <__udivdi3+0xfc>
  8024d7:	74 0b                	je     8024e4 <__udivdi3+0xf0>
  8024d9:	89 d8                	mov    %ebx,%eax
  8024db:	31 ff                	xor    %edi,%edi
  8024dd:	e9 58 ff ff ff       	jmp    80243a <__udivdi3+0x46>
  8024e2:	66 90                	xchg   %ax,%ax
  8024e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024e8:	89 f9                	mov    %edi,%ecx
  8024ea:	d3 e2                	shl    %cl,%edx
  8024ec:	39 c2                	cmp    %eax,%edx
  8024ee:	73 e9                	jae    8024d9 <__udivdi3+0xe5>
  8024f0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024f3:	31 ff                	xor    %edi,%edi
  8024f5:	e9 40 ff ff ff       	jmp    80243a <__udivdi3+0x46>
  8024fa:	66 90                	xchg   %ax,%ax
  8024fc:	31 c0                	xor    %eax,%eax
  8024fe:	e9 37 ff ff ff       	jmp    80243a <__udivdi3+0x46>
  802503:	90                   	nop

00802504 <__umoddi3>:
  802504:	55                   	push   %ebp
  802505:	57                   	push   %edi
  802506:	56                   	push   %esi
  802507:	53                   	push   %ebx
  802508:	83 ec 1c             	sub    $0x1c,%esp
  80250b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80250f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802513:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802517:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80251b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80251f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802523:	89 f3                	mov    %esi,%ebx
  802525:	89 fa                	mov    %edi,%edx
  802527:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80252b:	89 34 24             	mov    %esi,(%esp)
  80252e:	85 c0                	test   %eax,%eax
  802530:	75 1a                	jne    80254c <__umoddi3+0x48>
  802532:	39 f7                	cmp    %esi,%edi
  802534:	0f 86 a2 00 00 00    	jbe    8025dc <__umoddi3+0xd8>
  80253a:	89 c8                	mov    %ecx,%eax
  80253c:	89 f2                	mov    %esi,%edx
  80253e:	f7 f7                	div    %edi
  802540:	89 d0                	mov    %edx,%eax
  802542:	31 d2                	xor    %edx,%edx
  802544:	83 c4 1c             	add    $0x1c,%esp
  802547:	5b                   	pop    %ebx
  802548:	5e                   	pop    %esi
  802549:	5f                   	pop    %edi
  80254a:	5d                   	pop    %ebp
  80254b:	c3                   	ret    
  80254c:	39 f0                	cmp    %esi,%eax
  80254e:	0f 87 ac 00 00 00    	ja     802600 <__umoddi3+0xfc>
  802554:	0f bd e8             	bsr    %eax,%ebp
  802557:	83 f5 1f             	xor    $0x1f,%ebp
  80255a:	0f 84 ac 00 00 00    	je     80260c <__umoddi3+0x108>
  802560:	bf 20 00 00 00       	mov    $0x20,%edi
  802565:	29 ef                	sub    %ebp,%edi
  802567:	89 fe                	mov    %edi,%esi
  802569:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80256d:	89 e9                	mov    %ebp,%ecx
  80256f:	d3 e0                	shl    %cl,%eax
  802571:	89 d7                	mov    %edx,%edi
  802573:	89 f1                	mov    %esi,%ecx
  802575:	d3 ef                	shr    %cl,%edi
  802577:	09 c7                	or     %eax,%edi
  802579:	89 e9                	mov    %ebp,%ecx
  80257b:	d3 e2                	shl    %cl,%edx
  80257d:	89 14 24             	mov    %edx,(%esp)
  802580:	89 d8                	mov    %ebx,%eax
  802582:	d3 e0                	shl    %cl,%eax
  802584:	89 c2                	mov    %eax,%edx
  802586:	8b 44 24 08          	mov    0x8(%esp),%eax
  80258a:	d3 e0                	shl    %cl,%eax
  80258c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802590:	8b 44 24 08          	mov    0x8(%esp),%eax
  802594:	89 f1                	mov    %esi,%ecx
  802596:	d3 e8                	shr    %cl,%eax
  802598:	09 d0                	or     %edx,%eax
  80259a:	d3 eb                	shr    %cl,%ebx
  80259c:	89 da                	mov    %ebx,%edx
  80259e:	f7 f7                	div    %edi
  8025a0:	89 d3                	mov    %edx,%ebx
  8025a2:	f7 24 24             	mull   (%esp)
  8025a5:	89 c6                	mov    %eax,%esi
  8025a7:	89 d1                	mov    %edx,%ecx
  8025a9:	39 d3                	cmp    %edx,%ebx
  8025ab:	0f 82 87 00 00 00    	jb     802638 <__umoddi3+0x134>
  8025b1:	0f 84 91 00 00 00    	je     802648 <__umoddi3+0x144>
  8025b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025bb:	29 f2                	sub    %esi,%edx
  8025bd:	19 cb                	sbb    %ecx,%ebx
  8025bf:	89 d8                	mov    %ebx,%eax
  8025c1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025c5:	d3 e0                	shl    %cl,%eax
  8025c7:	89 e9                	mov    %ebp,%ecx
  8025c9:	d3 ea                	shr    %cl,%edx
  8025cb:	09 d0                	or     %edx,%eax
  8025cd:	89 e9                	mov    %ebp,%ecx
  8025cf:	d3 eb                	shr    %cl,%ebx
  8025d1:	89 da                	mov    %ebx,%edx
  8025d3:	83 c4 1c             	add    $0x1c,%esp
  8025d6:	5b                   	pop    %ebx
  8025d7:	5e                   	pop    %esi
  8025d8:	5f                   	pop    %edi
  8025d9:	5d                   	pop    %ebp
  8025da:	c3                   	ret    
  8025db:	90                   	nop
  8025dc:	89 fd                	mov    %edi,%ebp
  8025de:	85 ff                	test   %edi,%edi
  8025e0:	75 0b                	jne    8025ed <__umoddi3+0xe9>
  8025e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8025e7:	31 d2                	xor    %edx,%edx
  8025e9:	f7 f7                	div    %edi
  8025eb:	89 c5                	mov    %eax,%ebp
  8025ed:	89 f0                	mov    %esi,%eax
  8025ef:	31 d2                	xor    %edx,%edx
  8025f1:	f7 f5                	div    %ebp
  8025f3:	89 c8                	mov    %ecx,%eax
  8025f5:	f7 f5                	div    %ebp
  8025f7:	89 d0                	mov    %edx,%eax
  8025f9:	e9 44 ff ff ff       	jmp    802542 <__umoddi3+0x3e>
  8025fe:	66 90                	xchg   %ax,%ax
  802600:	89 c8                	mov    %ecx,%eax
  802602:	89 f2                	mov    %esi,%edx
  802604:	83 c4 1c             	add    $0x1c,%esp
  802607:	5b                   	pop    %ebx
  802608:	5e                   	pop    %esi
  802609:	5f                   	pop    %edi
  80260a:	5d                   	pop    %ebp
  80260b:	c3                   	ret    
  80260c:	3b 04 24             	cmp    (%esp),%eax
  80260f:	72 06                	jb     802617 <__umoddi3+0x113>
  802611:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802615:	77 0f                	ja     802626 <__umoddi3+0x122>
  802617:	89 f2                	mov    %esi,%edx
  802619:	29 f9                	sub    %edi,%ecx
  80261b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80261f:	89 14 24             	mov    %edx,(%esp)
  802622:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802626:	8b 44 24 04          	mov    0x4(%esp),%eax
  80262a:	8b 14 24             	mov    (%esp),%edx
  80262d:	83 c4 1c             	add    $0x1c,%esp
  802630:	5b                   	pop    %ebx
  802631:	5e                   	pop    %esi
  802632:	5f                   	pop    %edi
  802633:	5d                   	pop    %ebp
  802634:	c3                   	ret    
  802635:	8d 76 00             	lea    0x0(%esi),%esi
  802638:	2b 04 24             	sub    (%esp),%eax
  80263b:	19 fa                	sbb    %edi,%edx
  80263d:	89 d1                	mov    %edx,%ecx
  80263f:	89 c6                	mov    %eax,%esi
  802641:	e9 71 ff ff ff       	jmp    8025b7 <__umoddi3+0xb3>
  802646:	66 90                	xchg   %ax,%ax
  802648:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80264c:	72 ea                	jb     802638 <__umoddi3+0x134>
  80264e:	89 d9                	mov    %ebx,%ecx
  802650:	e9 62 ff ff ff       	jmp    8025b7 <__umoddi3+0xb3>
