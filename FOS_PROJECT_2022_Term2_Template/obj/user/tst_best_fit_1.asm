
obj/user/tst_best_fit_1:     file format elf32-i386


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
  800031:	e8 c2 0a 00 00       	call   800af8 <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 03 24 00 00       	call   80244d <sys_set_uheap_strategy>
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
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
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
  800083:	a1 20 30 80 00       	mov    0x803020,%eax
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
  80009b:	68 e0 26 80 00       	push   $0x8026e0
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 fc 26 80 00       	push   $0x8026fc
  8000a7:	e8 5b 0b 00 00       	call   800c07 <_panic>
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
		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cb:	e8 ea 1e 00 00       	call   801fba <sys_calculate_free_frames>
  8000d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d3:	e8 65 1f 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(3*Mega-kilo);
  8000db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000de:	89 c2                	mov    %eax,%edx
  8000e0:	01 d2                	add    %edx,%edx
  8000e2:	01 d0                	add    %edx,%eax
  8000e4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e7:	83 ec 0c             	sub    $0xc,%esp
  8000ea:	50                   	push   %eax
  8000eb:	e8 55 1b 00 00       	call   801c45 <malloc>
  8000f0:	83 c4 10             	add    $0x10,%esp
  8000f3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f9:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 14 27 80 00       	push   $0x802714
  800108:	6a 23                	push   $0x23
  80010a:	68 fc 26 80 00       	push   $0x8026fc
  80010f:	e8 f3 0a 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  800114:	e8 24 1f 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800119:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80011c:	3d 00 03 00 00       	cmp    $0x300,%eax
  800121:	74 14                	je     800137 <_main+0xff>
  800123:	83 ec 04             	sub    $0x4,%esp
  800126:	68 44 27 80 00       	push   $0x802744
  80012b:	6a 25                	push   $0x25
  80012d:	68 fc 26 80 00       	push   $0x8026fc
  800132:	e8 d0 0a 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800137:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80013a:	e8 7b 1e 00 00       	call   801fba <sys_calculate_free_frames>
  80013f:	29 c3                	sub    %eax,%ebx
  800141:	89 d8                	mov    %ebx,%eax
  800143:	83 f8 01             	cmp    $0x1,%eax
  800146:	74 14                	je     80015c <_main+0x124>
  800148:	83 ec 04             	sub    $0x4,%esp
  80014b:	68 61 27 80 00       	push   $0x802761
  800150:	6a 26                	push   $0x26
  800152:	68 fc 26 80 00       	push   $0x8026fc
  800157:	e8 ab 0a 00 00       	call   800c07 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80015c:	e8 59 1e 00 00       	call   801fba <sys_calculate_free_frames>
  800161:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800164:	e8 d4 1e 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800169:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  80016c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016f:	89 c2                	mov    %eax,%edx
  800171:	01 d2                	add    %edx,%edx
  800173:	01 d0                	add    %edx,%eax
  800175:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800178:	83 ec 0c             	sub    $0xc,%esp
  80017b:	50                   	push   %eax
  80017c:	e8 c4 1a 00 00       	call   801c45 <malloc>
  800181:	83 c4 10             	add    $0x10,%esp
  800184:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  800187:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018a:	89 c1                	mov    %eax,%ecx
  80018c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018f:	89 c2                	mov    %eax,%edx
  800191:	01 d2                	add    %edx,%edx
  800193:	01 d0                	add    %edx,%eax
  800195:	05 00 00 00 80       	add    $0x80000000,%eax
  80019a:	39 c1                	cmp    %eax,%ecx
  80019c:	74 14                	je     8001b2 <_main+0x17a>
  80019e:	83 ec 04             	sub    $0x4,%esp
  8001a1:	68 14 27 80 00       	push   $0x802714
  8001a6:	6a 2c                	push   $0x2c
  8001a8:	68 fc 26 80 00       	push   $0x8026fc
  8001ad:	e8 55 0a 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  8001b2:	e8 86 1e 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8001b7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001ba:	3d 00 03 00 00       	cmp    $0x300,%eax
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 44 27 80 00       	push   $0x802744
  8001c9:	6a 2e                	push   $0x2e
  8001cb:	68 fc 26 80 00       	push   $0x8026fc
  8001d0:	e8 32 0a 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001d5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001d8:	e8 dd 1d 00 00       	call   801fba <sys_calculate_free_frames>
  8001dd:	29 c3                	sub    %eax,%ebx
  8001df:	89 d8                	mov    %ebx,%eax
  8001e1:	83 f8 01             	cmp    $0x1,%eax
  8001e4:	74 14                	je     8001fa <_main+0x1c2>
  8001e6:	83 ec 04             	sub    $0x4,%esp
  8001e9:	68 61 27 80 00       	push   $0x802761
  8001ee:	6a 2f                	push   $0x2f
  8001f0:	68 fc 26 80 00       	push   $0x8026fc
  8001f5:	e8 0d 0a 00 00       	call   800c07 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8001fa:	e8 bb 1d 00 00       	call   801fba <sys_calculate_free_frames>
  8001ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800202:	e8 36 1e 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800207:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*Mega-kilo);
  80020a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80020d:	01 c0                	add    %eax,%eax
  80020f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800212:	83 ec 0c             	sub    $0xc,%esp
  800215:	50                   	push   %eax
  800216:	e8 2a 1a 00 00       	call   801c45 <malloc>
  80021b:	83 c4 10             	add    $0x10,%esp
  80021e:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  800221:	8b 45 98             	mov    -0x68(%ebp),%eax
  800224:	89 c1                	mov    %eax,%ecx
  800226:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800229:	89 d0                	mov    %edx,%eax
  80022b:	01 c0                	add    %eax,%eax
  80022d:	01 d0                	add    %edx,%eax
  80022f:	01 c0                	add    %eax,%eax
  800231:	05 00 00 00 80       	add    $0x80000000,%eax
  800236:	39 c1                	cmp    %eax,%ecx
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 14 27 80 00       	push   $0x802714
  800242:	6a 35                	push   $0x35
  800244:	68 fc 26 80 00       	push   $0x8026fc
  800249:	e8 b9 09 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  80024e:	e8 ea 1d 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800253:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800256:	3d 00 02 00 00       	cmp    $0x200,%eax
  80025b:	74 14                	je     800271 <_main+0x239>
  80025d:	83 ec 04             	sub    $0x4,%esp
  800260:	68 44 27 80 00       	push   $0x802744
  800265:	6a 37                	push   $0x37
  800267:	68 fc 26 80 00       	push   $0x8026fc
  80026c:	e8 96 09 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800271:	e8 44 1d 00 00       	call   801fba <sys_calculate_free_frames>
  800276:	89 c2                	mov    %eax,%edx
  800278:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027b:	39 c2                	cmp    %eax,%edx
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 61 27 80 00       	push   $0x802761
  800287:	6a 38                	push   $0x38
  800289:	68 fc 26 80 00       	push   $0x8026fc
  80028e:	e8 74 09 00 00       	call   800c07 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800293:	e8 22 1d 00 00       	call   801fba <sys_calculate_free_frames>
  800298:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80029b:	e8 9d 1d 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8002a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*Mega-kilo);
  8002a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a6:	01 c0                	add    %eax,%eax
  8002a8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8002ab:	83 ec 0c             	sub    $0xc,%esp
  8002ae:	50                   	push   %eax
  8002af:	e8 91 19 00 00       	call   801c45 <malloc>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8002ba:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002bd:	89 c2                	mov    %eax,%edx
  8002bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c2:	c1 e0 03             	shl    $0x3,%eax
  8002c5:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ca:	39 c2                	cmp    %eax,%edx
  8002cc:	74 14                	je     8002e2 <_main+0x2aa>
  8002ce:	83 ec 04             	sub    $0x4,%esp
  8002d1:	68 14 27 80 00       	push   $0x802714
  8002d6:	6a 3e                	push   $0x3e
  8002d8:	68 fc 26 80 00       	push   $0x8026fc
  8002dd:	e8 25 09 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  8002e2:	e8 56 1d 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8002e7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002ea:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002ef:	74 14                	je     800305 <_main+0x2cd>
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	68 44 27 80 00       	push   $0x802744
  8002f9:	6a 40                	push   $0x40
  8002fb:	68 fc 26 80 00       	push   $0x8026fc
  800300:	e8 02 09 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800305:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800308:	e8 ad 1c 00 00       	call   801fba <sys_calculate_free_frames>
  80030d:	29 c3                	sub    %eax,%ebx
  80030f:	89 d8                	mov    %ebx,%eax
  800311:	83 f8 01             	cmp    $0x1,%eax
  800314:	74 14                	je     80032a <_main+0x2f2>
  800316:	83 ec 04             	sub    $0x4,%esp
  800319:	68 61 27 80 00       	push   $0x802761
  80031e:	6a 41                	push   $0x41
  800320:	68 fc 26 80 00       	push   $0x8026fc
  800325:	e8 dd 08 00 00       	call   800c07 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80032a:	e8 8b 1c 00 00       	call   801fba <sys_calculate_free_frames>
  80032f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800332:	e8 06 1d 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800337:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(1*Mega-kilo);
  80033a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800340:	83 ec 0c             	sub    $0xc,%esp
  800343:	50                   	push   %eax
  800344:	e8 fc 18 00 00       	call   801c45 <malloc>
  800349:	83 c4 10             	add    $0x10,%esp
  80034c:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 10*Mega) ) panic("Wrong start address for the allocated space... ");
  80034f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800352:	89 c1                	mov    %eax,%ecx
  800354:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800357:	89 d0                	mov    %edx,%eax
  800359:	c1 e0 02             	shl    $0x2,%eax
  80035c:	01 d0                	add    %edx,%eax
  80035e:	01 c0                	add    %eax,%eax
  800360:	05 00 00 00 80       	add    $0x80000000,%eax
  800365:	39 c1                	cmp    %eax,%ecx
  800367:	74 14                	je     80037d <_main+0x345>
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	68 14 27 80 00       	push   $0x802714
  800371:	6a 47                	push   $0x47
  800373:	68 fc 26 80 00       	push   $0x8026fc
  800378:	e8 8a 08 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80037d:	e8 bb 1c 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800382:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800385:	3d 00 01 00 00       	cmp    $0x100,%eax
  80038a:	74 14                	je     8003a0 <_main+0x368>
  80038c:	83 ec 04             	sub    $0x4,%esp
  80038f:	68 44 27 80 00       	push   $0x802744
  800394:	6a 49                	push   $0x49
  800396:	68 fc 26 80 00       	push   $0x8026fc
  80039b:	e8 67 08 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8003a0:	e8 15 1c 00 00       	call   801fba <sys_calculate_free_frames>
  8003a5:	89 c2                	mov    %eax,%edx
  8003a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003aa:	39 c2                	cmp    %eax,%edx
  8003ac:	74 14                	je     8003c2 <_main+0x38a>
  8003ae:	83 ec 04             	sub    $0x4,%esp
  8003b1:	68 61 27 80 00       	push   $0x802761
  8003b6:	6a 4a                	push   $0x4a
  8003b8:	68 fc 26 80 00       	push   $0x8026fc
  8003bd:	e8 45 08 00 00       	call   800c07 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c2:	e8 f3 1b 00 00       	call   801fba <sys_calculate_free_frames>
  8003c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003ca:	e8 6e 1c 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8003cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(1*Mega-kilo);
  8003d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d5:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d8:	83 ec 0c             	sub    $0xc,%esp
  8003db:	50                   	push   %eax
  8003dc:	e8 64 18 00 00       	call   801c45 <malloc>
  8003e1:	83 c4 10             	add    $0x10,%esp
  8003e4:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 11*Mega) ) panic("Wrong start address for the allocated space... ");
  8003e7:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ea:	89 c1                	mov    %eax,%ecx
  8003ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	c1 e0 02             	shl    $0x2,%eax
  8003f4:	01 d0                	add    %edx,%eax
  8003f6:	01 c0                	add    %eax,%eax
  8003f8:	01 d0                	add    %edx,%eax
  8003fa:	05 00 00 00 80       	add    $0x80000000,%eax
  8003ff:	39 c1                	cmp    %eax,%ecx
  800401:	74 14                	je     800417 <_main+0x3df>
  800403:	83 ec 04             	sub    $0x4,%esp
  800406:	68 14 27 80 00       	push   $0x802714
  80040b:	6a 50                	push   $0x50
  80040d:	68 fc 26 80 00       	push   $0x8026fc
  800412:	e8 f0 07 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800417:	e8 21 1c 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80041c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80041f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800424:	74 14                	je     80043a <_main+0x402>
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	68 44 27 80 00       	push   $0x802744
  80042e:	6a 52                	push   $0x52
  800430:	68 fc 26 80 00       	push   $0x8026fc
  800435:	e8 cd 07 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80043a:	e8 7b 1b 00 00       	call   801fba <sys_calculate_free_frames>
  80043f:	89 c2                	mov    %eax,%edx
  800441:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800444:	39 c2                	cmp    %eax,%edx
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 61 27 80 00       	push   $0x802761
  800450:	6a 53                	push   $0x53
  800452:	68 fc 26 80 00       	push   $0x8026fc
  800457:	e8 ab 07 00 00       	call   800c07 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 59 1b 00 00       	call   801fba <sys_calculate_free_frames>
  800461:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800464:	e8 d4 1b 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800469:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(1*Mega-kilo);
  80046c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800472:	83 ec 0c             	sub    $0xc,%esp
  800475:	50                   	push   %eax
  800476:	e8 ca 17 00 00       	call   801c45 <malloc>
  80047b:	83 c4 10             	add    $0x10,%esp
  80047e:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 12*Mega) ) panic("Wrong start address for the allocated space... ");
  800481:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800484:	89 c1                	mov    %eax,%ecx
  800486:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800489:	89 d0                	mov    %edx,%eax
  80048b:	01 c0                	add    %eax,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	c1 e0 02             	shl    $0x2,%eax
  800492:	05 00 00 00 80       	add    $0x80000000,%eax
  800497:	39 c1                	cmp    %eax,%ecx
  800499:	74 14                	je     8004af <_main+0x477>
  80049b:	83 ec 04             	sub    $0x4,%esp
  80049e:	68 14 27 80 00       	push   $0x802714
  8004a3:	6a 59                	push   $0x59
  8004a5:	68 fc 26 80 00       	push   $0x8026fc
  8004aa:	e8 58 07 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8004af:	e8 89 1b 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8004b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8004bc:	74 14                	je     8004d2 <_main+0x49a>
  8004be:	83 ec 04             	sub    $0x4,%esp
  8004c1:	68 44 27 80 00       	push   $0x802744
  8004c6:	6a 5b                	push   $0x5b
  8004c8:	68 fc 26 80 00       	push   $0x8026fc
  8004cd:	e8 35 07 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004d2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004d5:	e8 e0 1a 00 00       	call   801fba <sys_calculate_free_frames>
  8004da:	29 c3                	sub    %eax,%ebx
  8004dc:	89 d8                	mov    %ebx,%eax
  8004de:	83 f8 01             	cmp    $0x1,%eax
  8004e1:	74 14                	je     8004f7 <_main+0x4bf>
  8004e3:	83 ec 04             	sub    $0x4,%esp
  8004e6:	68 61 27 80 00       	push   $0x802761
  8004eb:	6a 5c                	push   $0x5c
  8004ed:	68 fc 26 80 00       	push   $0x8026fc
  8004f2:	e8 10 07 00 00       	call   800c07 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8004f7:	e8 be 1a 00 00       	call   801fba <sys_calculate_free_frames>
  8004fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004ff:	e8 39 1b 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800504:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(1*Mega-kilo);
  800507:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80050a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80050d:	83 ec 0c             	sub    $0xc,%esp
  800510:	50                   	push   %eax
  800511:	e8 2f 17 00 00       	call   801c45 <malloc>
  800516:	83 c4 10             	add    $0x10,%esp
  800519:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 13*Mega)) panic("Wrong start address for the allocated space... ");
  80051c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80051f:	89 c1                	mov    %eax,%ecx
  800521:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800524:	89 d0                	mov    %edx,%eax
  800526:	01 c0                	add    %eax,%eax
  800528:	01 d0                	add    %edx,%eax
  80052a:	c1 e0 02             	shl    $0x2,%eax
  80052d:	01 d0                	add    %edx,%eax
  80052f:	05 00 00 00 80       	add    $0x80000000,%eax
  800534:	39 c1                	cmp    %eax,%ecx
  800536:	74 14                	je     80054c <_main+0x514>
  800538:	83 ec 04             	sub    $0x4,%esp
  80053b:	68 14 27 80 00       	push   $0x802714
  800540:	6a 62                	push   $0x62
  800542:	68 fc 26 80 00       	push   $0x8026fc
  800547:	e8 bb 06 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80054c:	e8 ec 1a 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800551:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800554:	3d 00 01 00 00       	cmp    $0x100,%eax
  800559:	74 14                	je     80056f <_main+0x537>
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 44 27 80 00       	push   $0x802744
  800563:	6a 64                	push   $0x64
  800565:	68 fc 26 80 00       	push   $0x8026fc
  80056a:	e8 98 06 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80056f:	e8 46 1a 00 00       	call   801fba <sys_calculate_free_frames>
  800574:	89 c2                	mov    %eax,%edx
  800576:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800579:	39 c2                	cmp    %eax,%edx
  80057b:	74 14                	je     800591 <_main+0x559>
  80057d:	83 ec 04             	sub    $0x4,%esp
  800580:	68 61 27 80 00       	push   $0x802761
  800585:	6a 65                	push   $0x65
  800587:	68 fc 26 80 00       	push   $0x8026fc
  80058c:	e8 76 06 00 00       	call   800c07 <_panic>
	}

	//[2] Free some to create holes
	{
		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800591:	e8 24 1a 00 00       	call   801fba <sys_calculate_free_frames>
  800596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800599:	e8 9f 1a 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80059e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005a1:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005a4:	83 ec 0c             	sub    $0xc,%esp
  8005a7:	50                   	push   %eax
  8005a8:	e8 50 18 00 00       	call   801dfd <free>
  8005ad:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  3*256) panic("Wrong page file free: ");
  8005b0:	e8 88 1a 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8005b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b8:	29 c2                	sub    %eax,%edx
  8005ba:	89 d0                	mov    %edx,%eax
  8005bc:	3d 00 03 00 00       	cmp    $0x300,%eax
  8005c1:	74 14                	je     8005d7 <_main+0x59f>
  8005c3:	83 ec 04             	sub    $0x4,%esp
  8005c6:	68 74 27 80 00       	push   $0x802774
  8005cb:	6a 6f                	push   $0x6f
  8005cd:	68 fc 26 80 00       	push   $0x8026fc
  8005d2:	e8 30 06 00 00       	call   800c07 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005d7:	e8 de 19 00 00       	call   801fba <sys_calculate_free_frames>
  8005dc:	89 c2                	mov    %eax,%edx
  8005de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005e1:	39 c2                	cmp    %eax,%edx
  8005e3:	74 14                	je     8005f9 <_main+0x5c1>
  8005e5:	83 ec 04             	sub    $0x4,%esp
  8005e8:	68 8b 27 80 00       	push   $0x80278b
  8005ed:	6a 70                	push   $0x70
  8005ef:	68 fc 26 80 00       	push   $0x8026fc
  8005f4:	e8 0e 06 00 00       	call   800c07 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005f9:	e8 bc 19 00 00       	call   801fba <sys_calculate_free_frames>
  8005fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800601:	e8 37 1a 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800606:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800609:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80060c:	83 ec 0c             	sub    $0xc,%esp
  80060f:	50                   	push   %eax
  800610:	e8 e8 17 00 00       	call   801dfd <free>
  800615:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  2*256) panic("Wrong page file free: ");
  800618:	e8 20 1a 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80061d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800620:	29 c2                	sub    %eax,%edx
  800622:	89 d0                	mov    %edx,%eax
  800624:	3d 00 02 00 00       	cmp    $0x200,%eax
  800629:	74 14                	je     80063f <_main+0x607>
  80062b:	83 ec 04             	sub    $0x4,%esp
  80062e:	68 74 27 80 00       	push   $0x802774
  800633:	6a 77                	push   $0x77
  800635:	68 fc 26 80 00       	push   $0x8026fc
  80063a:	e8 c8 05 00 00       	call   800c07 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80063f:	e8 76 19 00 00       	call   801fba <sys_calculate_free_frames>
  800644:	89 c2                	mov    %eax,%edx
  800646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800649:	39 c2                	cmp    %eax,%edx
  80064b:	74 14                	je     800661 <_main+0x629>
  80064d:	83 ec 04             	sub    $0x4,%esp
  800650:	68 8b 27 80 00       	push   $0x80278b
  800655:	6a 78                	push   $0x78
  800657:	68 fc 26 80 00       	push   $0x8026fc
  80065c:	e8 a6 05 00 00       	call   800c07 <_panic>

		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800661:	e8 54 19 00 00       	call   801fba <sys_calculate_free_frames>
  800666:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800669:	e8 cf 19 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80066e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  800671:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800674:	83 ec 0c             	sub    $0xc,%esp
  800677:	50                   	push   %eax
  800678:	e8 80 17 00 00       	call   801dfd <free>
  80067d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800680:	e8 b8 19 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800685:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800688:	29 c2                	sub    %eax,%edx
  80068a:	89 d0                	mov    %edx,%eax
  80068c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800691:	74 14                	je     8006a7 <_main+0x66f>
  800693:	83 ec 04             	sub    $0x4,%esp
  800696:	68 74 27 80 00       	push   $0x802774
  80069b:	6a 7f                	push   $0x7f
  80069d:	68 fc 26 80 00       	push   $0x8026fc
  8006a2:	e8 60 05 00 00       	call   800c07 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8006a7:	e8 0e 19 00 00       	call   801fba <sys_calculate_free_frames>
  8006ac:	89 c2                	mov    %eax,%edx
  8006ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b1:	39 c2                	cmp    %eax,%edx
  8006b3:	74 17                	je     8006cc <_main+0x694>
  8006b5:	83 ec 04             	sub    $0x4,%esp
  8006b8:	68 8b 27 80 00       	push   $0x80278b
  8006bd:	68 80 00 00 00       	push   $0x80
  8006c2:	68 fc 26 80 00       	push   $0x8026fc
  8006c7:	e8 3b 05 00 00       	call   800c07 <_panic>
	}

	//[3] Allocate again [test best fit]
	{
		//Allocate 512 KB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  8006cc:	e8 e9 18 00 00       	call   801fba <sys_calculate_free_frames>
  8006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006d4:	e8 64 19 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8006d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo);
  8006dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006df:	c1 e0 09             	shl    $0x9,%eax
  8006e2:	83 ec 0c             	sub    $0xc,%esp
  8006e5:	50                   	push   %eax
  8006e6:	e8 5a 15 00 00       	call   801c45 <malloc>
  8006eb:	83 c4 10             	add    $0x10,%esp
  8006ee:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8006f1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006f4:	89 c1                	mov    %eax,%ecx
  8006f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006f9:	89 d0                	mov    %edx,%eax
  8006fb:	c1 e0 02             	shl    $0x2,%eax
  8006fe:	01 d0                	add    %edx,%eax
  800700:	01 c0                	add    %eax,%eax
  800702:	01 d0                	add    %edx,%eax
  800704:	05 00 00 00 80       	add    $0x80000000,%eax
  800709:	39 c1                	cmp    %eax,%ecx
  80070b:	74 17                	je     800724 <_main+0x6ec>
  80070d:	83 ec 04             	sub    $0x4,%esp
  800710:	68 14 27 80 00       	push   $0x802714
  800715:	68 89 00 00 00       	push   $0x89
  80071a:	68 fc 26 80 00       	push   $0x8026fc
  80071f:	e8 e3 04 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800724:	e8 14 19 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800729:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80072c:	3d 80 00 00 00       	cmp    $0x80,%eax
  800731:	74 17                	je     80074a <_main+0x712>
  800733:	83 ec 04             	sub    $0x4,%esp
  800736:	68 44 27 80 00       	push   $0x802744
  80073b:	68 8b 00 00 00       	push   $0x8b
  800740:	68 fc 26 80 00       	push   $0x8026fc
  800745:	e8 bd 04 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80074a:	e8 6b 18 00 00       	call   801fba <sys_calculate_free_frames>
  80074f:	89 c2                	mov    %eax,%edx
  800751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800754:	39 c2                	cmp    %eax,%edx
  800756:	74 17                	je     80076f <_main+0x737>
  800758:	83 ec 04             	sub    $0x4,%esp
  80075b:	68 61 27 80 00       	push   $0x802761
  800760:	68 8c 00 00 00       	push   $0x8c
  800765:	68 fc 26 80 00       	push   $0x8026fc
  80076a:	e8 98 04 00 00       	call   800c07 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  80076f:	e8 46 18 00 00       	call   801fba <sys_calculate_free_frames>
  800774:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800777:	e8 c1 18 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80077c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80077f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800782:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800785:	83 ec 0c             	sub    $0xc,%esp
  800788:	50                   	push   %eax
  800789:	e8 b7 14 00 00       	call   801c45 <malloc>
  80078e:	83 c4 10             	add    $0x10,%esp
  800791:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800794:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800797:	89 c2                	mov    %eax,%edx
  800799:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80079c:	c1 e0 03             	shl    $0x3,%eax
  80079f:	05 00 00 00 80       	add    $0x80000000,%eax
  8007a4:	39 c2                	cmp    %eax,%edx
  8007a6:	74 17                	je     8007bf <_main+0x787>
  8007a8:	83 ec 04             	sub    $0x4,%esp
  8007ab:	68 14 27 80 00       	push   $0x802714
  8007b0:	68 92 00 00 00       	push   $0x92
  8007b5:	68 fc 26 80 00       	push   $0x8026fc
  8007ba:	e8 48 04 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007bf:	e8 79 18 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8007c4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007c7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007cc:	74 17                	je     8007e5 <_main+0x7ad>
  8007ce:	83 ec 04             	sub    $0x4,%esp
  8007d1:	68 44 27 80 00       	push   $0x802744
  8007d6:	68 94 00 00 00       	push   $0x94
  8007db:	68 fc 26 80 00       	push   $0x8026fc
  8007e0:	e8 22 04 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007e5:	e8 d0 17 00 00       	call   801fba <sys_calculate_free_frames>
  8007ea:	89 c2                	mov    %eax,%edx
  8007ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007ef:	39 c2                	cmp    %eax,%edx
  8007f1:	74 17                	je     80080a <_main+0x7d2>
  8007f3:	83 ec 04             	sub    $0x4,%esp
  8007f6:	68 61 27 80 00       	push   $0x802761
  8007fb:	68 95 00 00 00       	push   $0x95
  800800:	68 fc 26 80 00       	push   $0x8026fc
  800805:	e8 fd 03 00 00       	call   800c07 <_panic>

		//Allocate 256 KB - should be placed in remaining of 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80080a:	e8 ab 17 00 00       	call   801fba <sys_calculate_free_frames>
  80080f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800812:	e8 26 18 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800817:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  80081a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081d:	89 d0                	mov    %edx,%eax
  80081f:	c1 e0 08             	shl    $0x8,%eax
  800822:	29 d0                	sub    %edx,%eax
  800824:	83 ec 0c             	sub    $0xc,%esp
  800827:	50                   	push   %eax
  800828:	e8 18 14 00 00       	call   801c45 <malloc>
  80082d:	83 c4 10             	add    $0x10,%esp
  800830:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 11*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800833:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800836:	89 c1                	mov    %eax,%ecx
  800838:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80083b:	89 d0                	mov    %edx,%eax
  80083d:	c1 e0 02             	shl    $0x2,%eax
  800840:	01 d0                	add    %edx,%eax
  800842:	01 c0                	add    %eax,%eax
  800844:	01 d0                	add    %edx,%eax
  800846:	89 c2                	mov    %eax,%edx
  800848:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80084b:	c1 e0 09             	shl    $0x9,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	05 00 00 00 80       	add    $0x80000000,%eax
  800855:	39 c1                	cmp    %eax,%ecx
  800857:	74 17                	je     800870 <_main+0x838>
  800859:	83 ec 04             	sub    $0x4,%esp
  80085c:	68 14 27 80 00       	push   $0x802714
  800861:	68 9b 00 00 00       	push   $0x9b
  800866:	68 fc 26 80 00       	push   $0x8026fc
  80086b:	e8 97 03 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800870:	e8 c8 17 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800875:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800878:	83 f8 40             	cmp    $0x40,%eax
  80087b:	74 17                	je     800894 <_main+0x85c>
  80087d:	83 ec 04             	sub    $0x4,%esp
  800880:	68 44 27 80 00       	push   $0x802744
  800885:	68 9d 00 00 00       	push   $0x9d
  80088a:	68 fc 26 80 00       	push   $0x8026fc
  80088f:	e8 73 03 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800894:	e8 21 17 00 00       	call   801fba <sys_calculate_free_frames>
  800899:	89 c2                	mov    %eax,%edx
  80089b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80089e:	39 c2                	cmp    %eax,%edx
  8008a0:	74 17                	je     8008b9 <_main+0x881>
  8008a2:	83 ec 04             	sub    $0x4,%esp
  8008a5:	68 61 27 80 00       	push   $0x802761
  8008aa:	68 9e 00 00 00       	push   $0x9e
  8008af:	68 fc 26 80 00       	push   $0x8026fc
  8008b4:	e8 4e 03 00 00       	call   800c07 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8008b9:	e8 fc 16 00 00       	call   801fba <sys_calculate_free_frames>
  8008be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c1:	e8 77 17 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8008c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8008c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008cc:	c1 e0 02             	shl    $0x2,%eax
  8008cf:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8008d2:	83 ec 0c             	sub    $0xc,%esp
  8008d5:	50                   	push   %eax
  8008d6:	e8 6a 13 00 00       	call   801c45 <malloc>
  8008db:	83 c4 10             	add    $0x10,%esp
  8008de:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  8008e1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008e4:	89 c1                	mov    %eax,%ecx
  8008e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008e9:	89 d0                	mov    %edx,%eax
  8008eb:	01 c0                	add    %eax,%eax
  8008ed:	01 d0                	add    %edx,%eax
  8008ef:	01 c0                	add    %eax,%eax
  8008f1:	01 d0                	add    %edx,%eax
  8008f3:	01 c0                	add    %eax,%eax
  8008f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8008fa:	39 c1                	cmp    %eax,%ecx
  8008fc:	74 17                	je     800915 <_main+0x8dd>
  8008fe:	83 ec 04             	sub    $0x4,%esp
  800901:	68 14 27 80 00       	push   $0x802714
  800906:	68 a4 00 00 00       	push   $0xa4
  80090b:	68 fc 26 80 00       	push   $0x8026fc
  800910:	e8 f2 02 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800915:	e8 23 17 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  80091a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80091d:	3d 00 04 00 00       	cmp    $0x400,%eax
  800922:	74 17                	je     80093b <_main+0x903>
  800924:	83 ec 04             	sub    $0x4,%esp
  800927:	68 44 27 80 00       	push   $0x802744
  80092c:	68 a6 00 00 00       	push   $0xa6
  800931:	68 fc 26 80 00       	push   $0x8026fc
  800936:	e8 cc 02 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80093b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80093e:	e8 77 16 00 00       	call   801fba <sys_calculate_free_frames>
  800943:	29 c3                	sub    %eax,%ebx
  800945:	89 d8                	mov    %ebx,%eax
  800947:	83 f8 01             	cmp    $0x1,%eax
  80094a:	74 17                	je     800963 <_main+0x92b>
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	68 61 27 80 00       	push   $0x802761
  800954:	68 a7 00 00 00       	push   $0xa7
  800959:	68 fc 26 80 00       	push   $0x8026fc
  80095e:	e8 a4 02 00 00       	call   800c07 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1M Hole appended to already existing 1M hole in the middle
		freeFrames = sys_calculate_free_frames() ;
  800963:	e8 52 16 00 00       	call   801fba <sys_calculate_free_frames>
  800968:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80096b:	e8 cd 16 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800970:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  800973:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800976:	83 ec 0c             	sub    $0xc,%esp
  800979:	50                   	push   %eax
  80097a:	e8 7e 14 00 00       	call   801dfd <free>
  80097f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800982:	e8 b6 16 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800987:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80098a:	29 c2                	sub    %eax,%edx
  80098c:	89 d0                	mov    %edx,%eax
  80098e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800993:	74 17                	je     8009ac <_main+0x974>
  800995:	83 ec 04             	sub    $0x4,%esp
  800998:	68 74 27 80 00       	push   $0x802774
  80099d:	68 b1 00 00 00       	push   $0xb1
  8009a2:	68 fc 26 80 00       	push   $0x8026fc
  8009a7:	e8 5b 02 00 00       	call   800c07 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8009ac:	e8 09 16 00 00       	call   801fba <sys_calculate_free_frames>
  8009b1:	89 c2                	mov    %eax,%edx
  8009b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009b6:	39 c2                	cmp    %eax,%edx
  8009b8:	74 17                	je     8009d1 <_main+0x999>
  8009ba:	83 ec 04             	sub    $0x4,%esp
  8009bd:	68 8b 27 80 00       	push   $0x80278b
  8009c2:	68 b2 00 00 00       	push   $0xb2
  8009c7:	68 fc 26 80 00       	push   $0x8026fc
  8009cc:	e8 36 02 00 00       	call   800c07 <_panic>

		//another 512 KB Hole appended to the hole
		freeFrames = sys_calculate_free_frames() ;
  8009d1:	e8 e4 15 00 00       	call   801fba <sys_calculate_free_frames>
  8009d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009d9:	e8 5f 16 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8009de:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[8]);
  8009e1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8009e4:	83 ec 0c             	sub    $0xc,%esp
  8009e7:	50                   	push   %eax
  8009e8:	e8 10 14 00 00       	call   801dfd <free>
  8009ed:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  128) panic("Wrong page file free: ");
  8009f0:	e8 48 16 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  8009f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f8:	29 c2                	sub    %eax,%edx
  8009fa:	89 d0                	mov    %edx,%eax
  8009fc:	3d 80 00 00 00       	cmp    $0x80,%eax
  800a01:	74 17                	je     800a1a <_main+0x9e2>
  800a03:	83 ec 04             	sub    $0x4,%esp
  800a06:	68 74 27 80 00       	push   $0x802774
  800a0b:	68 b9 00 00 00       	push   $0xb9
  800a10:	68 fc 26 80 00       	push   $0x8026fc
  800a15:	e8 ed 01 00 00       	call   800c07 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1a:	e8 9b 15 00 00       	call   801fba <sys_calculate_free_frames>
  800a1f:	89 c2                	mov    %eax,%edx
  800a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a24:	39 c2                	cmp    %eax,%edx
  800a26:	74 17                	je     800a3f <_main+0xa07>
  800a28:	83 ec 04             	sub    $0x4,%esp
  800a2b:	68 8b 27 80 00       	push   $0x80278b
  800a30:	68 ba 00 00 00       	push   $0xba
  800a35:	68 fc 26 80 00       	push   $0x8026fc
  800a3a:	e8 c8 01 00 00       	call   800c07 <_panic>
	}

	//[5] Allocate again [test best fit]
	{
		//Allocate 2 MB - should be placed in the contiguous hole (2 MB + 512 KB)
		freeFrames = sys_calculate_free_frames();
  800a3f:	e8 76 15 00 00       	call   801fba <sys_calculate_free_frames>
  800a44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a47:	e8 f1 15 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800a4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(2*Mega - kilo);
  800a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a52:	01 c0                	add    %eax,%eax
  800a54:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800a57:	83 ec 0c             	sub    $0xc,%esp
  800a5a:	50                   	push   %eax
  800a5b:	e8 e5 11 00 00       	call   801c45 <malloc>
  800a60:	83 c4 10             	add    $0x10,%esp
  800a63:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 9*Mega)) panic("Wrong start address for the allocated space... ");
  800a66:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a69:	89 c1                	mov    %eax,%ecx
  800a6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a6e:	89 d0                	mov    %edx,%eax
  800a70:	c1 e0 03             	shl    $0x3,%eax
  800a73:	01 d0                	add    %edx,%eax
  800a75:	05 00 00 00 80       	add    $0x80000000,%eax
  800a7a:	39 c1                	cmp    %eax,%ecx
  800a7c:	74 17                	je     800a95 <_main+0xa5d>
  800a7e:	83 ec 04             	sub    $0x4,%esp
  800a81:	68 14 27 80 00       	push   $0x802714
  800a86:	68 c3 00 00 00       	push   $0xc3
  800a8b:	68 fc 26 80 00       	push   $0x8026fc
  800a90:	e8 72 01 00 00       	call   800c07 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800a95:	e8 a3 15 00 00       	call   80203d <sys_pf_calculate_allocated_pages>
  800a9a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a9d:	3d 00 02 00 00       	cmp    $0x200,%eax
  800aa2:	74 17                	je     800abb <_main+0xa83>
  800aa4:	83 ec 04             	sub    $0x4,%esp
  800aa7:	68 44 27 80 00       	push   $0x802744
  800aac:	68 c5 00 00 00       	push   $0xc5
  800ab1:	68 fc 26 80 00       	push   $0x8026fc
  800ab6:	e8 4c 01 00 00       	call   800c07 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800abb:	e8 fa 14 00 00       	call   801fba <sys_calculate_free_frames>
  800ac0:	89 c2                	mov    %eax,%edx
  800ac2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ac5:	39 c2                	cmp    %eax,%edx
  800ac7:	74 17                	je     800ae0 <_main+0xaa8>
  800ac9:	83 ec 04             	sub    $0x4,%esp
  800acc:	68 61 27 80 00       	push   $0x802761
  800ad1:	68 c6 00 00 00       	push   $0xc6
  800ad6:	68 fc 26 80 00       	push   $0x8026fc
  800adb:	e8 27 01 00 00       	call   800c07 <_panic>
	}
	cprintf("Congratulations!! test BEST FIT allocation (1) completed successfully.\n");
  800ae0:	83 ec 0c             	sub    $0xc,%esp
  800ae3:	68 98 27 80 00       	push   $0x802798
  800ae8:	e8 ce 03 00 00       	call   800ebb <cprintf>
  800aed:	83 c4 10             	add    $0x10,%esp

	return;
  800af0:	90                   	nop
}
  800af1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800af4:	5b                   	pop    %ebx
  800af5:	5f                   	pop    %edi
  800af6:	5d                   	pop    %ebp
  800af7:	c3                   	ret    

00800af8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800af8:	55                   	push   %ebp
  800af9:	89 e5                	mov    %esp,%ebp
  800afb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800afe:	e8 ec 13 00 00       	call   801eef <sys_getenvindex>
  800b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b09:	89 d0                	mov    %edx,%eax
  800b0b:	c1 e0 02             	shl    $0x2,%eax
  800b0e:	01 d0                	add    %edx,%eax
  800b10:	01 c0                	add    %eax,%eax
  800b12:	01 d0                	add    %edx,%eax
  800b14:	01 c0                	add    %eax,%eax
  800b16:	01 d0                	add    %edx,%eax
  800b18:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800b1f:	01 d0                	add    %edx,%eax
  800b21:	c1 e0 02             	shl    $0x2,%eax
  800b24:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b29:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b2e:	a1 20 30 80 00       	mov    0x803020,%eax
  800b33:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b39:	84 c0                	test   %al,%al
  800b3b:	74 0f                	je     800b4c <libmain+0x54>
		binaryname = myEnv->prog_name;
  800b3d:	a1 20 30 80 00       	mov    0x803020,%eax
  800b42:	05 f4 02 00 00       	add    $0x2f4,%eax
  800b47:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800b4c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b50:	7e 0a                	jle    800b5c <libmain+0x64>
		binaryname = argv[0];
  800b52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800b5c:	83 ec 08             	sub    $0x8,%esp
  800b5f:	ff 75 0c             	pushl  0xc(%ebp)
  800b62:	ff 75 08             	pushl  0x8(%ebp)
  800b65:	e8 ce f4 ff ff       	call   800038 <_main>
  800b6a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800b6d:	e8 18 15 00 00       	call   80208a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800b72:	83 ec 0c             	sub    $0xc,%esp
  800b75:	68 f8 27 80 00       	push   $0x8027f8
  800b7a:	e8 3c 03 00 00       	call   800ebb <cprintf>
  800b7f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b82:	a1 20 30 80 00       	mov    0x803020,%eax
  800b87:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800b8d:	a1 20 30 80 00       	mov    0x803020,%eax
  800b92:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800b98:	83 ec 04             	sub    $0x4,%esp
  800b9b:	52                   	push   %edx
  800b9c:	50                   	push   %eax
  800b9d:	68 20 28 80 00       	push   $0x802820
  800ba2:	e8 14 03 00 00       	call   800ebb <cprintf>
  800ba7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800baa:	a1 20 30 80 00       	mov    0x803020,%eax
  800baf:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	50                   	push   %eax
  800bb9:	68 45 28 80 00       	push   $0x802845
  800bbe:	e8 f8 02 00 00       	call   800ebb <cprintf>
  800bc3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800bc6:	83 ec 0c             	sub    $0xc,%esp
  800bc9:	68 f8 27 80 00       	push   $0x8027f8
  800bce:	e8 e8 02 00 00       	call   800ebb <cprintf>
  800bd3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800bd6:	e8 c9 14 00 00       	call   8020a4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800bdb:	e8 19 00 00 00       	call   800bf9 <exit>
}
  800be0:	90                   	nop
  800be1:	c9                   	leave  
  800be2:	c3                   	ret    

00800be3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800be3:	55                   	push   %ebp
  800be4:	89 e5                	mov    %esp,%ebp
  800be6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800be9:	83 ec 0c             	sub    $0xc,%esp
  800bec:	6a 00                	push   $0x0
  800bee:	e8 c8 12 00 00       	call   801ebb <sys_env_destroy>
  800bf3:	83 c4 10             	add    $0x10,%esp
}
  800bf6:	90                   	nop
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <exit>:

void
exit(void)
{
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800bff:	e8 1d 13 00 00       	call   801f21 <sys_env_exit>
}
  800c04:	90                   	nop
  800c05:	c9                   	leave  
  800c06:	c3                   	ret    

00800c07 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c07:	55                   	push   %ebp
  800c08:	89 e5                	mov    %esp,%ebp
  800c0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c0d:	8d 45 10             	lea    0x10(%ebp),%eax
  800c10:	83 c0 04             	add    $0x4,%eax
  800c13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c16:	a1 34 30 80 00       	mov    0x803034,%eax
  800c1b:	85 c0                	test   %eax,%eax
  800c1d:	74 16                	je     800c35 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c1f:	a1 34 30 80 00       	mov    0x803034,%eax
  800c24:	83 ec 08             	sub    $0x8,%esp
  800c27:	50                   	push   %eax
  800c28:	68 5c 28 80 00       	push   $0x80285c
  800c2d:	e8 89 02 00 00       	call   800ebb <cprintf>
  800c32:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c35:	a1 00 30 80 00       	mov    0x803000,%eax
  800c3a:	ff 75 0c             	pushl  0xc(%ebp)
  800c3d:	ff 75 08             	pushl  0x8(%ebp)
  800c40:	50                   	push   %eax
  800c41:	68 61 28 80 00       	push   $0x802861
  800c46:	e8 70 02 00 00       	call   800ebb <cprintf>
  800c4b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800c4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c51:	83 ec 08             	sub    $0x8,%esp
  800c54:	ff 75 f4             	pushl  -0xc(%ebp)
  800c57:	50                   	push   %eax
  800c58:	e8 f3 01 00 00       	call   800e50 <vcprintf>
  800c5d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800c60:	83 ec 08             	sub    $0x8,%esp
  800c63:	6a 00                	push   $0x0
  800c65:	68 7d 28 80 00       	push   $0x80287d
  800c6a:	e8 e1 01 00 00       	call   800e50 <vcprintf>
  800c6f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800c72:	e8 82 ff ff ff       	call   800bf9 <exit>

	// should not return here
	while (1) ;
  800c77:	eb fe                	jmp    800c77 <_panic+0x70>

00800c79 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800c79:	55                   	push   %ebp
  800c7a:	89 e5                	mov    %esp,%ebp
  800c7c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800c7f:	a1 20 30 80 00       	mov    0x803020,%eax
  800c84:	8b 50 74             	mov    0x74(%eax),%edx
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	39 c2                	cmp    %eax,%edx
  800c8c:	74 14                	je     800ca2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800c8e:	83 ec 04             	sub    $0x4,%esp
  800c91:	68 80 28 80 00       	push   $0x802880
  800c96:	6a 26                	push   $0x26
  800c98:	68 cc 28 80 00       	push   $0x8028cc
  800c9d:	e8 65 ff ff ff       	call   800c07 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ca2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800ca9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800cb0:	e9 c2 00 00 00       	jmp    800d77 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800cb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cb8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	01 d0                	add    %edx,%eax
  800cc4:	8b 00                	mov    (%eax),%eax
  800cc6:	85 c0                	test   %eax,%eax
  800cc8:	75 08                	jne    800cd2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800cca:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ccd:	e9 a2 00 00 00       	jmp    800d74 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800cd2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800cd9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800ce0:	eb 69                	jmp    800d4b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800ce2:	a1 20 30 80 00       	mov    0x803020,%eax
  800ce7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ced:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800cf0:	89 d0                	mov    %edx,%eax
  800cf2:	01 c0                	add    %eax,%eax
  800cf4:	01 d0                	add    %edx,%eax
  800cf6:	c1 e0 02             	shl    $0x2,%eax
  800cf9:	01 c8                	add    %ecx,%eax
  800cfb:	8a 40 04             	mov    0x4(%eax),%al
  800cfe:	84 c0                	test   %al,%al
  800d00:	75 46                	jne    800d48 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d02:	a1 20 30 80 00       	mov    0x803020,%eax
  800d07:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d0d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d10:	89 d0                	mov    %edx,%eax
  800d12:	01 c0                	add    %eax,%eax
  800d14:	01 d0                	add    %edx,%eax
  800d16:	c1 e0 02             	shl    $0x2,%eax
  800d19:	01 c8                	add    %ecx,%eax
  800d1b:	8b 00                	mov    (%eax),%eax
  800d1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d20:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d28:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d2d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
  800d37:	01 c8                	add    %ecx,%eax
  800d39:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d3b:	39 c2                	cmp    %eax,%edx
  800d3d:	75 09                	jne    800d48 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800d3f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d46:	eb 12                	jmp    800d5a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d48:	ff 45 e8             	incl   -0x18(%ebp)
  800d4b:	a1 20 30 80 00       	mov    0x803020,%eax
  800d50:	8b 50 74             	mov    0x74(%eax),%edx
  800d53:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800d56:	39 c2                	cmp    %eax,%edx
  800d58:	77 88                	ja     800ce2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800d5a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d5e:	75 14                	jne    800d74 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800d60:	83 ec 04             	sub    $0x4,%esp
  800d63:	68 d8 28 80 00       	push   $0x8028d8
  800d68:	6a 3a                	push   $0x3a
  800d6a:	68 cc 28 80 00       	push   $0x8028cc
  800d6f:	e8 93 fe ff ff       	call   800c07 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800d74:	ff 45 f0             	incl   -0x10(%ebp)
  800d77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800d7d:	0f 8c 32 ff ff ff    	jl     800cb5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800d83:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d8a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800d91:	eb 26                	jmp    800db9 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800d93:	a1 20 30 80 00       	mov    0x803020,%eax
  800d98:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d9e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800da1:	89 d0                	mov    %edx,%eax
  800da3:	01 c0                	add    %eax,%eax
  800da5:	01 d0                	add    %edx,%eax
  800da7:	c1 e0 02             	shl    $0x2,%eax
  800daa:	01 c8                	add    %ecx,%eax
  800dac:	8a 40 04             	mov    0x4(%eax),%al
  800daf:	3c 01                	cmp    $0x1,%al
  800db1:	75 03                	jne    800db6 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800db3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800db6:	ff 45 e0             	incl   -0x20(%ebp)
  800db9:	a1 20 30 80 00       	mov    0x803020,%eax
  800dbe:	8b 50 74             	mov    0x74(%eax),%edx
  800dc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dc4:	39 c2                	cmp    %eax,%edx
  800dc6:	77 cb                	ja     800d93 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dcb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800dce:	74 14                	je     800de4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800dd0:	83 ec 04             	sub    $0x4,%esp
  800dd3:	68 2c 29 80 00       	push   $0x80292c
  800dd8:	6a 44                	push   $0x44
  800dda:	68 cc 28 80 00       	push   $0x8028cc
  800ddf:	e8 23 fe ff ff       	call   800c07 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800de4:	90                   	nop
  800de5:	c9                   	leave  
  800de6:	c3                   	ret    

00800de7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800de7:	55                   	push   %ebp
  800de8:	89 e5                	mov    %esp,%ebp
  800dea:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ded:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df0:	8b 00                	mov    (%eax),%eax
  800df2:	8d 48 01             	lea    0x1(%eax),%ecx
  800df5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df8:	89 0a                	mov    %ecx,(%edx)
  800dfa:	8b 55 08             	mov    0x8(%ebp),%edx
  800dfd:	88 d1                	mov    %dl,%cl
  800dff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e02:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	8b 00                	mov    (%eax),%eax
  800e0b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e10:	75 2c                	jne    800e3e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e12:	a0 24 30 80 00       	mov    0x803024,%al
  800e17:	0f b6 c0             	movzbl %al,%eax
  800e1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1d:	8b 12                	mov    (%edx),%edx
  800e1f:	89 d1                	mov    %edx,%ecx
  800e21:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e24:	83 c2 08             	add    $0x8,%edx
  800e27:	83 ec 04             	sub    $0x4,%esp
  800e2a:	50                   	push   %eax
  800e2b:	51                   	push   %ecx
  800e2c:	52                   	push   %edx
  800e2d:	e8 47 10 00 00       	call   801e79 <sys_cputs>
  800e32:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	8b 40 04             	mov    0x4(%eax),%eax
  800e44:	8d 50 01             	lea    0x1(%eax),%edx
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800e4d:	90                   	nop
  800e4e:	c9                   	leave  
  800e4f:	c3                   	ret    

00800e50 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800e50:	55                   	push   %ebp
  800e51:	89 e5                	mov    %esp,%ebp
  800e53:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800e59:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800e60:	00 00 00 
	b.cnt = 0;
  800e63:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800e6a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	ff 75 08             	pushl  0x8(%ebp)
  800e73:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e79:	50                   	push   %eax
  800e7a:	68 e7 0d 80 00       	push   $0x800de7
  800e7f:	e8 11 02 00 00       	call   801095 <vprintfmt>
  800e84:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800e87:	a0 24 30 80 00       	mov    0x803024,%al
  800e8c:	0f b6 c0             	movzbl %al,%eax
  800e8f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800e95:	83 ec 04             	sub    $0x4,%esp
  800e98:	50                   	push   %eax
  800e99:	52                   	push   %edx
  800e9a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ea0:	83 c0 08             	add    $0x8,%eax
  800ea3:	50                   	push   %eax
  800ea4:	e8 d0 0f 00 00       	call   801e79 <sys_cputs>
  800ea9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800eac:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800eb3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800eb9:	c9                   	leave  
  800eba:	c3                   	ret    

00800ebb <cprintf>:

int cprintf(const char *fmt, ...) {
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ec1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ec8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ecb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	83 ec 08             	sub    $0x8,%esp
  800ed4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ed7:	50                   	push   %eax
  800ed8:	e8 73 ff ff ff       	call   800e50 <vcprintf>
  800edd:	83 c4 10             	add    $0x10,%esp
  800ee0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ee3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ee6:	c9                   	leave  
  800ee7:	c3                   	ret    

00800ee8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ee8:	55                   	push   %ebp
  800ee9:	89 e5                	mov    %esp,%ebp
  800eeb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800eee:	e8 97 11 00 00       	call   80208a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ef3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ef6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	83 ec 08             	sub    $0x8,%esp
  800eff:	ff 75 f4             	pushl  -0xc(%ebp)
  800f02:	50                   	push   %eax
  800f03:	e8 48 ff ff ff       	call   800e50 <vcprintf>
  800f08:	83 c4 10             	add    $0x10,%esp
  800f0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f0e:	e8 91 11 00 00       	call   8020a4 <sys_enable_interrupt>
	return cnt;
  800f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f16:	c9                   	leave  
  800f17:	c3                   	ret    

00800f18 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f18:	55                   	push   %ebp
  800f19:	89 e5                	mov    %esp,%ebp
  800f1b:	53                   	push   %ebx
  800f1c:	83 ec 14             	sub    $0x14,%esp
  800f1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f2b:	8b 45 18             	mov    0x18(%ebp),%eax
  800f2e:	ba 00 00 00 00       	mov    $0x0,%edx
  800f33:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f36:	77 55                	ja     800f8d <printnum+0x75>
  800f38:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f3b:	72 05                	jb     800f42 <printnum+0x2a>
  800f3d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f40:	77 4b                	ja     800f8d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f42:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f45:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800f48:	8b 45 18             	mov    0x18(%ebp),%eax
  800f4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800f50:	52                   	push   %edx
  800f51:	50                   	push   %eax
  800f52:	ff 75 f4             	pushl  -0xc(%ebp)
  800f55:	ff 75 f0             	pushl  -0x10(%ebp)
  800f58:	e8 0b 15 00 00       	call   802468 <__udivdi3>
  800f5d:	83 c4 10             	add    $0x10,%esp
  800f60:	83 ec 04             	sub    $0x4,%esp
  800f63:	ff 75 20             	pushl  0x20(%ebp)
  800f66:	53                   	push   %ebx
  800f67:	ff 75 18             	pushl  0x18(%ebp)
  800f6a:	52                   	push   %edx
  800f6b:	50                   	push   %eax
  800f6c:	ff 75 0c             	pushl  0xc(%ebp)
  800f6f:	ff 75 08             	pushl  0x8(%ebp)
  800f72:	e8 a1 ff ff ff       	call   800f18 <printnum>
  800f77:	83 c4 20             	add    $0x20,%esp
  800f7a:	eb 1a                	jmp    800f96 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800f7c:	83 ec 08             	sub    $0x8,%esp
  800f7f:	ff 75 0c             	pushl  0xc(%ebp)
  800f82:	ff 75 20             	pushl  0x20(%ebp)
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	ff d0                	call   *%eax
  800f8a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800f8d:	ff 4d 1c             	decl   0x1c(%ebp)
  800f90:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800f94:	7f e6                	jg     800f7c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800f96:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800f99:	bb 00 00 00 00       	mov    $0x0,%ebx
  800f9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa4:	53                   	push   %ebx
  800fa5:	51                   	push   %ecx
  800fa6:	52                   	push   %edx
  800fa7:	50                   	push   %eax
  800fa8:	e8 cb 15 00 00       	call   802578 <__umoddi3>
  800fad:	83 c4 10             	add    $0x10,%esp
  800fb0:	05 94 2b 80 00       	add    $0x802b94,%eax
  800fb5:	8a 00                	mov    (%eax),%al
  800fb7:	0f be c0             	movsbl %al,%eax
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	50                   	push   %eax
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	ff d0                	call   *%eax
  800fc6:	83 c4 10             	add    $0x10,%esp
}
  800fc9:	90                   	nop
  800fca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800fcd:	c9                   	leave  
  800fce:	c3                   	ret    

00800fcf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800fcf:	55                   	push   %ebp
  800fd0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800fd2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800fd6:	7e 1c                	jle    800ff4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8b 00                	mov    (%eax),%eax
  800fdd:	8d 50 08             	lea    0x8(%eax),%edx
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	89 10                	mov    %edx,(%eax)
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8b 00                	mov    (%eax),%eax
  800fea:	83 e8 08             	sub    $0x8,%eax
  800fed:	8b 50 04             	mov    0x4(%eax),%edx
  800ff0:	8b 00                	mov    (%eax),%eax
  800ff2:	eb 40                	jmp    801034 <getuint+0x65>
	else if (lflag)
  800ff4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff8:	74 1e                	je     801018 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8b 00                	mov    (%eax),%eax
  800fff:	8d 50 04             	lea    0x4(%eax),%edx
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	89 10                	mov    %edx,(%eax)
  801007:	8b 45 08             	mov    0x8(%ebp),%eax
  80100a:	8b 00                	mov    (%eax),%eax
  80100c:	83 e8 04             	sub    $0x4,%eax
  80100f:	8b 00                	mov    (%eax),%eax
  801011:	ba 00 00 00 00       	mov    $0x0,%edx
  801016:	eb 1c                	jmp    801034 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8b 00                	mov    (%eax),%eax
  80101d:	8d 50 04             	lea    0x4(%eax),%edx
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	89 10                	mov    %edx,(%eax)
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8b 00                	mov    (%eax),%eax
  80102a:	83 e8 04             	sub    $0x4,%eax
  80102d:	8b 00                	mov    (%eax),%eax
  80102f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801034:	5d                   	pop    %ebp
  801035:	c3                   	ret    

00801036 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801039:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80103d:	7e 1c                	jle    80105b <getint+0x25>
		return va_arg(*ap, long long);
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8b 00                	mov    (%eax),%eax
  801044:	8d 50 08             	lea    0x8(%eax),%edx
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	89 10                	mov    %edx,(%eax)
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	8b 00                	mov    (%eax),%eax
  801051:	83 e8 08             	sub    $0x8,%eax
  801054:	8b 50 04             	mov    0x4(%eax),%edx
  801057:	8b 00                	mov    (%eax),%eax
  801059:	eb 38                	jmp    801093 <getint+0x5d>
	else if (lflag)
  80105b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105f:	74 1a                	je     80107b <getint+0x45>
		return va_arg(*ap, long);
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8b 00                	mov    (%eax),%eax
  801066:	8d 50 04             	lea    0x4(%eax),%edx
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	89 10                	mov    %edx,(%eax)
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	8b 00                	mov    (%eax),%eax
  801073:	83 e8 04             	sub    $0x4,%eax
  801076:	8b 00                	mov    (%eax),%eax
  801078:	99                   	cltd   
  801079:	eb 18                	jmp    801093 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8b 00                	mov    (%eax),%eax
  801080:	8d 50 04             	lea    0x4(%eax),%edx
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	89 10                	mov    %edx,(%eax)
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8b 00                	mov    (%eax),%eax
  80108d:	83 e8 04             	sub    $0x4,%eax
  801090:	8b 00                	mov    (%eax),%eax
  801092:	99                   	cltd   
}
  801093:	5d                   	pop    %ebp
  801094:	c3                   	ret    

00801095 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801095:	55                   	push   %ebp
  801096:	89 e5                	mov    %esp,%ebp
  801098:	56                   	push   %esi
  801099:	53                   	push   %ebx
  80109a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80109d:	eb 17                	jmp    8010b6 <vprintfmt+0x21>
			if (ch == '\0')
  80109f:	85 db                	test   %ebx,%ebx
  8010a1:	0f 84 af 03 00 00    	je     801456 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8010a7:	83 ec 08             	sub    $0x8,%esp
  8010aa:	ff 75 0c             	pushl  0xc(%ebp)
  8010ad:	53                   	push   %ebx
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	ff d0                	call   *%eax
  8010b3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b9:	8d 50 01             	lea    0x1(%eax),%edx
  8010bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	0f b6 d8             	movzbl %al,%ebx
  8010c4:	83 fb 25             	cmp    $0x25,%ebx
  8010c7:	75 d6                	jne    80109f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8010c9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8010cd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8010d4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8010db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8010e2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8010e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ec:	8d 50 01             	lea    0x1(%eax),%edx
  8010ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f2:	8a 00                	mov    (%eax),%al
  8010f4:	0f b6 d8             	movzbl %al,%ebx
  8010f7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8010fa:	83 f8 55             	cmp    $0x55,%eax
  8010fd:	0f 87 2b 03 00 00    	ja     80142e <vprintfmt+0x399>
  801103:	8b 04 85 b8 2b 80 00 	mov    0x802bb8(,%eax,4),%eax
  80110a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80110c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801110:	eb d7                	jmp    8010e9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801112:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801116:	eb d1                	jmp    8010e9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801118:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80111f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801122:	89 d0                	mov    %edx,%eax
  801124:	c1 e0 02             	shl    $0x2,%eax
  801127:	01 d0                	add    %edx,%eax
  801129:	01 c0                	add    %eax,%eax
  80112b:	01 d8                	add    %ebx,%eax
  80112d:	83 e8 30             	sub    $0x30,%eax
  801130:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801133:	8b 45 10             	mov    0x10(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80113b:	83 fb 2f             	cmp    $0x2f,%ebx
  80113e:	7e 3e                	jle    80117e <vprintfmt+0xe9>
  801140:	83 fb 39             	cmp    $0x39,%ebx
  801143:	7f 39                	jg     80117e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801145:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801148:	eb d5                	jmp    80111f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80114a:	8b 45 14             	mov    0x14(%ebp),%eax
  80114d:	83 c0 04             	add    $0x4,%eax
  801150:	89 45 14             	mov    %eax,0x14(%ebp)
  801153:	8b 45 14             	mov    0x14(%ebp),%eax
  801156:	83 e8 04             	sub    $0x4,%eax
  801159:	8b 00                	mov    (%eax),%eax
  80115b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80115e:	eb 1f                	jmp    80117f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801160:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801164:	79 83                	jns    8010e9 <vprintfmt+0x54>
				width = 0;
  801166:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80116d:	e9 77 ff ff ff       	jmp    8010e9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801172:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801179:	e9 6b ff ff ff       	jmp    8010e9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80117e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80117f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801183:	0f 89 60 ff ff ff    	jns    8010e9 <vprintfmt+0x54>
				width = precision, precision = -1;
  801189:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80118c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80118f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801196:	e9 4e ff ff ff       	jmp    8010e9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80119b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80119e:	e9 46 ff ff ff       	jmp    8010e9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8011a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a6:	83 c0 04             	add    $0x4,%eax
  8011a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8011af:	83 e8 04             	sub    $0x4,%eax
  8011b2:	8b 00                	mov    (%eax),%eax
  8011b4:	83 ec 08             	sub    $0x8,%esp
  8011b7:	ff 75 0c             	pushl  0xc(%ebp)
  8011ba:	50                   	push   %eax
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	ff d0                	call   *%eax
  8011c0:	83 c4 10             	add    $0x10,%esp
			break;
  8011c3:	e9 89 02 00 00       	jmp    801451 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8011c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cb:	83 c0 04             	add    $0x4,%eax
  8011ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8011d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d4:	83 e8 04             	sub    $0x4,%eax
  8011d7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8011d9:	85 db                	test   %ebx,%ebx
  8011db:	79 02                	jns    8011df <vprintfmt+0x14a>
				err = -err;
  8011dd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8011df:	83 fb 64             	cmp    $0x64,%ebx
  8011e2:	7f 0b                	jg     8011ef <vprintfmt+0x15a>
  8011e4:	8b 34 9d 00 2a 80 00 	mov    0x802a00(,%ebx,4),%esi
  8011eb:	85 f6                	test   %esi,%esi
  8011ed:	75 19                	jne    801208 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8011ef:	53                   	push   %ebx
  8011f0:	68 a5 2b 80 00       	push   $0x802ba5
  8011f5:	ff 75 0c             	pushl  0xc(%ebp)
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	e8 5e 02 00 00       	call   80145e <printfmt>
  801200:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801203:	e9 49 02 00 00       	jmp    801451 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801208:	56                   	push   %esi
  801209:	68 ae 2b 80 00       	push   $0x802bae
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	ff 75 08             	pushl  0x8(%ebp)
  801214:	e8 45 02 00 00       	call   80145e <printfmt>
  801219:	83 c4 10             	add    $0x10,%esp
			break;
  80121c:	e9 30 02 00 00       	jmp    801451 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	83 c0 04             	add    $0x4,%eax
  801227:	89 45 14             	mov    %eax,0x14(%ebp)
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	83 e8 04             	sub    $0x4,%eax
  801230:	8b 30                	mov    (%eax),%esi
  801232:	85 f6                	test   %esi,%esi
  801234:	75 05                	jne    80123b <vprintfmt+0x1a6>
				p = "(null)";
  801236:	be b1 2b 80 00       	mov    $0x802bb1,%esi
			if (width > 0 && padc != '-')
  80123b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80123f:	7e 6d                	jle    8012ae <vprintfmt+0x219>
  801241:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801245:	74 67                	je     8012ae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801247:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80124a:	83 ec 08             	sub    $0x8,%esp
  80124d:	50                   	push   %eax
  80124e:	56                   	push   %esi
  80124f:	e8 0c 03 00 00       	call   801560 <strnlen>
  801254:	83 c4 10             	add    $0x10,%esp
  801257:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80125a:	eb 16                	jmp    801272 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80125c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801260:	83 ec 08             	sub    $0x8,%esp
  801263:	ff 75 0c             	pushl  0xc(%ebp)
  801266:	50                   	push   %eax
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	ff d0                	call   *%eax
  80126c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80126f:	ff 4d e4             	decl   -0x1c(%ebp)
  801272:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801276:	7f e4                	jg     80125c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801278:	eb 34                	jmp    8012ae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80127a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80127e:	74 1c                	je     80129c <vprintfmt+0x207>
  801280:	83 fb 1f             	cmp    $0x1f,%ebx
  801283:	7e 05                	jle    80128a <vprintfmt+0x1f5>
  801285:	83 fb 7e             	cmp    $0x7e,%ebx
  801288:	7e 12                	jle    80129c <vprintfmt+0x207>
					putch('?', putdat);
  80128a:	83 ec 08             	sub    $0x8,%esp
  80128d:	ff 75 0c             	pushl  0xc(%ebp)
  801290:	6a 3f                	push   $0x3f
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	ff d0                	call   *%eax
  801297:	83 c4 10             	add    $0x10,%esp
  80129a:	eb 0f                	jmp    8012ab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80129c:	83 ec 08             	sub    $0x8,%esp
  80129f:	ff 75 0c             	pushl  0xc(%ebp)
  8012a2:	53                   	push   %ebx
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	ff d0                	call   *%eax
  8012a8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8012ae:	89 f0                	mov    %esi,%eax
  8012b0:	8d 70 01             	lea    0x1(%eax),%esi
  8012b3:	8a 00                	mov    (%eax),%al
  8012b5:	0f be d8             	movsbl %al,%ebx
  8012b8:	85 db                	test   %ebx,%ebx
  8012ba:	74 24                	je     8012e0 <vprintfmt+0x24b>
  8012bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012c0:	78 b8                	js     80127a <vprintfmt+0x1e5>
  8012c2:	ff 4d e0             	decl   -0x20(%ebp)
  8012c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012c9:	79 af                	jns    80127a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012cb:	eb 13                	jmp    8012e0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8012cd:	83 ec 08             	sub    $0x8,%esp
  8012d0:	ff 75 0c             	pushl  0xc(%ebp)
  8012d3:	6a 20                	push   $0x20
  8012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d8:	ff d0                	call   *%eax
  8012da:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012dd:	ff 4d e4             	decl   -0x1c(%ebp)
  8012e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012e4:	7f e7                	jg     8012cd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8012e6:	e9 66 01 00 00       	jmp    801451 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8012eb:	83 ec 08             	sub    $0x8,%esp
  8012ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8012f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8012f4:	50                   	push   %eax
  8012f5:	e8 3c fd ff ff       	call   801036 <getint>
  8012fa:	83 c4 10             	add    $0x10,%esp
  8012fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801300:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801303:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801306:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801309:	85 d2                	test   %edx,%edx
  80130b:	79 23                	jns    801330 <vprintfmt+0x29b>
				putch('-', putdat);
  80130d:	83 ec 08             	sub    $0x8,%esp
  801310:	ff 75 0c             	pushl  0xc(%ebp)
  801313:	6a 2d                	push   $0x2d
  801315:	8b 45 08             	mov    0x8(%ebp),%eax
  801318:	ff d0                	call   *%eax
  80131a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80131d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801320:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801323:	f7 d8                	neg    %eax
  801325:	83 d2 00             	adc    $0x0,%edx
  801328:	f7 da                	neg    %edx
  80132a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80132d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801330:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801337:	e9 bc 00 00 00       	jmp    8013f8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80133c:	83 ec 08             	sub    $0x8,%esp
  80133f:	ff 75 e8             	pushl  -0x18(%ebp)
  801342:	8d 45 14             	lea    0x14(%ebp),%eax
  801345:	50                   	push   %eax
  801346:	e8 84 fc ff ff       	call   800fcf <getuint>
  80134b:	83 c4 10             	add    $0x10,%esp
  80134e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801351:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801354:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80135b:	e9 98 00 00 00       	jmp    8013f8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801360:	83 ec 08             	sub    $0x8,%esp
  801363:	ff 75 0c             	pushl  0xc(%ebp)
  801366:	6a 58                	push   $0x58
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	ff d0                	call   *%eax
  80136d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801370:	83 ec 08             	sub    $0x8,%esp
  801373:	ff 75 0c             	pushl  0xc(%ebp)
  801376:	6a 58                	push   $0x58
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	ff d0                	call   *%eax
  80137d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801380:	83 ec 08             	sub    $0x8,%esp
  801383:	ff 75 0c             	pushl  0xc(%ebp)
  801386:	6a 58                	push   $0x58
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	ff d0                	call   *%eax
  80138d:	83 c4 10             	add    $0x10,%esp
			break;
  801390:	e9 bc 00 00 00       	jmp    801451 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801395:	83 ec 08             	sub    $0x8,%esp
  801398:	ff 75 0c             	pushl  0xc(%ebp)
  80139b:	6a 30                	push   $0x30
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	ff d0                	call   *%eax
  8013a2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8013a5:	83 ec 08             	sub    $0x8,%esp
  8013a8:	ff 75 0c             	pushl  0xc(%ebp)
  8013ab:	6a 78                	push   $0x78
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	ff d0                	call   *%eax
  8013b2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8013b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b8:	83 c0 04             	add    $0x4,%eax
  8013bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8013be:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c1:	83 e8 04             	sub    $0x4,%eax
  8013c4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8013c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8013d0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8013d7:	eb 1f                	jmp    8013f8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8013d9:	83 ec 08             	sub    $0x8,%esp
  8013dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8013df:	8d 45 14             	lea    0x14(%ebp),%eax
  8013e2:	50                   	push   %eax
  8013e3:	e8 e7 fb ff ff       	call   800fcf <getuint>
  8013e8:	83 c4 10             	add    $0x10,%esp
  8013eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8013f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8013f8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8013fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013ff:	83 ec 04             	sub    $0x4,%esp
  801402:	52                   	push   %edx
  801403:	ff 75 e4             	pushl  -0x1c(%ebp)
  801406:	50                   	push   %eax
  801407:	ff 75 f4             	pushl  -0xc(%ebp)
  80140a:	ff 75 f0             	pushl  -0x10(%ebp)
  80140d:	ff 75 0c             	pushl  0xc(%ebp)
  801410:	ff 75 08             	pushl  0x8(%ebp)
  801413:	e8 00 fb ff ff       	call   800f18 <printnum>
  801418:	83 c4 20             	add    $0x20,%esp
			break;
  80141b:	eb 34                	jmp    801451 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80141d:	83 ec 08             	sub    $0x8,%esp
  801420:	ff 75 0c             	pushl  0xc(%ebp)
  801423:	53                   	push   %ebx
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	ff d0                	call   *%eax
  801429:	83 c4 10             	add    $0x10,%esp
			break;
  80142c:	eb 23                	jmp    801451 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80142e:	83 ec 08             	sub    $0x8,%esp
  801431:	ff 75 0c             	pushl  0xc(%ebp)
  801434:	6a 25                	push   $0x25
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	ff d0                	call   *%eax
  80143b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80143e:	ff 4d 10             	decl   0x10(%ebp)
  801441:	eb 03                	jmp    801446 <vprintfmt+0x3b1>
  801443:	ff 4d 10             	decl   0x10(%ebp)
  801446:	8b 45 10             	mov    0x10(%ebp),%eax
  801449:	48                   	dec    %eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	3c 25                	cmp    $0x25,%al
  80144e:	75 f3                	jne    801443 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801450:	90                   	nop
		}
	}
  801451:	e9 47 fc ff ff       	jmp    80109d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801456:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801457:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80145a:	5b                   	pop    %ebx
  80145b:	5e                   	pop    %esi
  80145c:	5d                   	pop    %ebp
  80145d:	c3                   	ret    

0080145e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
  801461:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801464:	8d 45 10             	lea    0x10(%ebp),%eax
  801467:	83 c0 04             	add    $0x4,%eax
  80146a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80146d:	8b 45 10             	mov    0x10(%ebp),%eax
  801470:	ff 75 f4             	pushl  -0xc(%ebp)
  801473:	50                   	push   %eax
  801474:	ff 75 0c             	pushl  0xc(%ebp)
  801477:	ff 75 08             	pushl  0x8(%ebp)
  80147a:	e8 16 fc ff ff       	call   801095 <vprintfmt>
  80147f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801482:	90                   	nop
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801488:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148b:	8b 40 08             	mov    0x8(%eax),%eax
  80148e:	8d 50 01             	lea    0x1(%eax),%edx
  801491:	8b 45 0c             	mov    0xc(%ebp),%eax
  801494:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801497:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149a:	8b 10                	mov    (%eax),%edx
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	8b 40 04             	mov    0x4(%eax),%eax
  8014a2:	39 c2                	cmp    %eax,%edx
  8014a4:	73 12                	jae    8014b8 <sprintputch+0x33>
		*b->buf++ = ch;
  8014a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a9:	8b 00                	mov    (%eax),%eax
  8014ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8014ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b1:	89 0a                	mov    %ecx,(%edx)
  8014b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8014b6:	88 10                	mov    %dl,(%eax)
}
  8014b8:	90                   	nop
  8014b9:	5d                   	pop    %ebp
  8014ba:	c3                   	ret    

008014bb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
  8014be:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	01 d0                	add    %edx,%eax
  8014d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8014dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014e0:	74 06                	je     8014e8 <vsnprintf+0x2d>
  8014e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014e6:	7f 07                	jg     8014ef <vsnprintf+0x34>
		return -E_INVAL;
  8014e8:	b8 03 00 00 00       	mov    $0x3,%eax
  8014ed:	eb 20                	jmp    80150f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8014ef:	ff 75 14             	pushl  0x14(%ebp)
  8014f2:	ff 75 10             	pushl  0x10(%ebp)
  8014f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8014f8:	50                   	push   %eax
  8014f9:	68 85 14 80 00       	push   $0x801485
  8014fe:	e8 92 fb ff ff       	call   801095 <vprintfmt>
  801503:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801506:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801509:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80150c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
  801514:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801517:	8d 45 10             	lea    0x10(%ebp),%eax
  80151a:	83 c0 04             	add    $0x4,%eax
  80151d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801520:	8b 45 10             	mov    0x10(%ebp),%eax
  801523:	ff 75 f4             	pushl  -0xc(%ebp)
  801526:	50                   	push   %eax
  801527:	ff 75 0c             	pushl  0xc(%ebp)
  80152a:	ff 75 08             	pushl  0x8(%ebp)
  80152d:	e8 89 ff ff ff       	call   8014bb <vsnprintf>
  801532:	83 c4 10             	add    $0x10,%esp
  801535:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801538:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
  801540:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801543:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80154a:	eb 06                	jmp    801552 <strlen+0x15>
		n++;
  80154c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80154f:	ff 45 08             	incl   0x8(%ebp)
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
  801555:	8a 00                	mov    (%eax),%al
  801557:	84 c0                	test   %al,%al
  801559:	75 f1                	jne    80154c <strlen+0xf>
		n++;
	return n;
  80155b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
  801563:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801566:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80156d:	eb 09                	jmp    801578 <strnlen+0x18>
		n++;
  80156f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801572:	ff 45 08             	incl   0x8(%ebp)
  801575:	ff 4d 0c             	decl   0xc(%ebp)
  801578:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80157c:	74 09                	je     801587 <strnlen+0x27>
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	84 c0                	test   %al,%al
  801585:	75 e8                	jne    80156f <strnlen+0xf>
		n++;
	return n;
  801587:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801598:	90                   	nop
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8d 50 01             	lea    0x1(%eax),%edx
  80159f:	89 55 08             	mov    %edx,0x8(%ebp)
  8015a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015ab:	8a 12                	mov    (%edx),%dl
  8015ad:	88 10                	mov    %dl,(%eax)
  8015af:	8a 00                	mov    (%eax),%al
  8015b1:	84 c0                	test   %al,%al
  8015b3:	75 e4                	jne    801599 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
  8015bd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015cd:	eb 1f                	jmp    8015ee <strncpy+0x34>
		*dst++ = *src;
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	8d 50 01             	lea    0x1(%eax),%edx
  8015d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8015d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015db:	8a 12                	mov    (%edx),%dl
  8015dd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	8a 00                	mov    (%eax),%al
  8015e4:	84 c0                	test   %al,%al
  8015e6:	74 03                	je     8015eb <strncpy+0x31>
			src++;
  8015e8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8015eb:	ff 45 fc             	incl   -0x4(%ebp)
  8015ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015f4:	72 d9                	jb     8015cf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8015f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
  8015fe:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
  801604:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801607:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160b:	74 30                	je     80163d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80160d:	eb 16                	jmp    801625 <strlcpy+0x2a>
			*dst++ = *src++;
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	8d 50 01             	lea    0x1(%eax),%edx
  801615:	89 55 08             	mov    %edx,0x8(%ebp)
  801618:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80161e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801621:	8a 12                	mov    (%edx),%dl
  801623:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801625:	ff 4d 10             	decl   0x10(%ebp)
  801628:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162c:	74 09                	je     801637 <strlcpy+0x3c>
  80162e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801631:	8a 00                	mov    (%eax),%al
  801633:	84 c0                	test   %al,%al
  801635:	75 d8                	jne    80160f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80163d:	8b 55 08             	mov    0x8(%ebp),%edx
  801640:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801643:	29 c2                	sub    %eax,%edx
  801645:	89 d0                	mov    %edx,%eax
}
  801647:	c9                   	leave  
  801648:	c3                   	ret    

00801649 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801649:	55                   	push   %ebp
  80164a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80164c:	eb 06                	jmp    801654 <strcmp+0xb>
		p++, q++;
  80164e:	ff 45 08             	incl   0x8(%ebp)
  801651:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	84 c0                	test   %al,%al
  80165b:	74 0e                	je     80166b <strcmp+0x22>
  80165d:	8b 45 08             	mov    0x8(%ebp),%eax
  801660:	8a 10                	mov    (%eax),%dl
  801662:	8b 45 0c             	mov    0xc(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	38 c2                	cmp    %al,%dl
  801669:	74 e3                	je     80164e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	0f b6 d0             	movzbl %al,%edx
  801673:	8b 45 0c             	mov    0xc(%ebp),%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	0f b6 c0             	movzbl %al,%eax
  80167b:	29 c2                	sub    %eax,%edx
  80167d:	89 d0                	mov    %edx,%eax
}
  80167f:	5d                   	pop    %ebp
  801680:	c3                   	ret    

00801681 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801684:	eb 09                	jmp    80168f <strncmp+0xe>
		n--, p++, q++;
  801686:	ff 4d 10             	decl   0x10(%ebp)
  801689:	ff 45 08             	incl   0x8(%ebp)
  80168c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80168f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801693:	74 17                	je     8016ac <strncmp+0x2b>
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	8a 00                	mov    (%eax),%al
  80169a:	84 c0                	test   %al,%al
  80169c:	74 0e                	je     8016ac <strncmp+0x2b>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 10                	mov    (%eax),%dl
  8016a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a6:	8a 00                	mov    (%eax),%al
  8016a8:	38 c2                	cmp    %al,%dl
  8016aa:	74 da                	je     801686 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8016ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b0:	75 07                	jne    8016b9 <strncmp+0x38>
		return 0;
  8016b2:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b7:	eb 14                	jmp    8016cd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	0f b6 d0             	movzbl %al,%edx
  8016c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	0f b6 c0             	movzbl %al,%eax
  8016c9:	29 c2                	sub    %eax,%edx
  8016cb:	89 d0                	mov    %edx,%eax
}
  8016cd:	5d                   	pop    %ebp
  8016ce:	c3                   	ret    

008016cf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
  8016d2:	83 ec 04             	sub    $0x4,%esp
  8016d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016db:	eb 12                	jmp    8016ef <strchr+0x20>
		if (*s == c)
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8016e5:	75 05                	jne    8016ec <strchr+0x1d>
			return (char *) s;
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	eb 11                	jmp    8016fd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8016ec:	ff 45 08             	incl   0x8(%ebp)
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	84 c0                	test   %al,%al
  8016f6:	75 e5                	jne    8016dd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8016f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	83 ec 04             	sub    $0x4,%esp
  801705:	8b 45 0c             	mov    0xc(%ebp),%eax
  801708:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80170b:	eb 0d                	jmp    80171a <strfind+0x1b>
		if (*s == c)
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	8a 00                	mov    (%eax),%al
  801712:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801715:	74 0e                	je     801725 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801717:	ff 45 08             	incl   0x8(%ebp)
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	84 c0                	test   %al,%al
  801721:	75 ea                	jne    80170d <strfind+0xe>
  801723:	eb 01                	jmp    801726 <strfind+0x27>
		if (*s == c)
			break;
  801725:	90                   	nop
	return (char *) s;
  801726:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
  80172e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801731:	8b 45 08             	mov    0x8(%ebp),%eax
  801734:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801737:	8b 45 10             	mov    0x10(%ebp),%eax
  80173a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80173d:	eb 0e                	jmp    80174d <memset+0x22>
		*p++ = c;
  80173f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801742:	8d 50 01             	lea    0x1(%eax),%edx
  801745:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801748:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80174d:	ff 4d f8             	decl   -0x8(%ebp)
  801750:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801754:	79 e9                	jns    80173f <memset+0x14>
		*p++ = c;

	return v;
  801756:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
  80175e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801761:	8b 45 0c             	mov    0xc(%ebp),%eax
  801764:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80176d:	eb 16                	jmp    801785 <memcpy+0x2a>
		*d++ = *s++;
  80176f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801772:	8d 50 01             	lea    0x1(%eax),%edx
  801775:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801778:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80177b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80177e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801781:	8a 12                	mov    (%edx),%dl
  801783:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801785:	8b 45 10             	mov    0x10(%ebp),%eax
  801788:	8d 50 ff             	lea    -0x1(%eax),%edx
  80178b:	89 55 10             	mov    %edx,0x10(%ebp)
  80178e:	85 c0                	test   %eax,%eax
  801790:	75 dd                	jne    80176f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
  80179a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80179d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8017a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017af:	73 50                	jae    801801 <memmove+0x6a>
  8017b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b7:	01 d0                	add    %edx,%eax
  8017b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017bc:	76 43                	jbe    801801 <memmove+0x6a>
		s += n;
  8017be:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8017c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017ca:	eb 10                	jmp    8017dc <memmove+0x45>
			*--d = *--s;
  8017cc:	ff 4d f8             	decl   -0x8(%ebp)
  8017cf:	ff 4d fc             	decl   -0x4(%ebp)
  8017d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017d5:	8a 10                	mov    (%eax),%dl
  8017d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017da:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8017dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8017df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8017e5:	85 c0                	test   %eax,%eax
  8017e7:	75 e3                	jne    8017cc <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8017e9:	eb 23                	jmp    80180e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8017eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ee:	8d 50 01             	lea    0x1(%eax),%edx
  8017f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017fd:	8a 12                	mov    (%edx),%dl
  8017ff:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801801:	8b 45 10             	mov    0x10(%ebp),%eax
  801804:	8d 50 ff             	lea    -0x1(%eax),%edx
  801807:	89 55 10             	mov    %edx,0x10(%ebp)
  80180a:	85 c0                	test   %eax,%eax
  80180c:	75 dd                	jne    8017eb <memmove+0x54>
			*d++ = *s++;

	return dst;
  80180e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801811:	c9                   	leave  
  801812:	c3                   	ret    

00801813 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801813:	55                   	push   %ebp
  801814:	89 e5                	mov    %esp,%ebp
  801816:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801819:	8b 45 08             	mov    0x8(%ebp),%eax
  80181c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80181f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801822:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801825:	eb 2a                	jmp    801851 <memcmp+0x3e>
		if (*s1 != *s2)
  801827:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182a:	8a 10                	mov    (%eax),%dl
  80182c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	38 c2                	cmp    %al,%dl
  801833:	74 16                	je     80184b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801835:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	0f b6 d0             	movzbl %al,%edx
  80183d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801840:	8a 00                	mov    (%eax),%al
  801842:	0f b6 c0             	movzbl %al,%eax
  801845:	29 c2                	sub    %eax,%edx
  801847:	89 d0                	mov    %edx,%eax
  801849:	eb 18                	jmp    801863 <memcmp+0x50>
		s1++, s2++;
  80184b:	ff 45 fc             	incl   -0x4(%ebp)
  80184e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801851:	8b 45 10             	mov    0x10(%ebp),%eax
  801854:	8d 50 ff             	lea    -0x1(%eax),%edx
  801857:	89 55 10             	mov    %edx,0x10(%ebp)
  80185a:	85 c0                	test   %eax,%eax
  80185c:	75 c9                	jne    801827 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80185e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
  801868:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80186b:	8b 55 08             	mov    0x8(%ebp),%edx
  80186e:	8b 45 10             	mov    0x10(%ebp),%eax
  801871:	01 d0                	add    %edx,%eax
  801873:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801876:	eb 15                	jmp    80188d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	8a 00                	mov    (%eax),%al
  80187d:	0f b6 d0             	movzbl %al,%edx
  801880:	8b 45 0c             	mov    0xc(%ebp),%eax
  801883:	0f b6 c0             	movzbl %al,%eax
  801886:	39 c2                	cmp    %eax,%edx
  801888:	74 0d                	je     801897 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80188a:	ff 45 08             	incl   0x8(%ebp)
  80188d:	8b 45 08             	mov    0x8(%ebp),%eax
  801890:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801893:	72 e3                	jb     801878 <memfind+0x13>
  801895:	eb 01                	jmp    801898 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801897:	90                   	nop
	return (void *) s;
  801898:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80189b:	c9                   	leave  
  80189c:	c3                   	ret    

0080189d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80189d:	55                   	push   %ebp
  80189e:	89 e5                	mov    %esp,%ebp
  8018a0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8018a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8018aa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018b1:	eb 03                	jmp    8018b6 <strtol+0x19>
		s++;
  8018b3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	8a 00                	mov    (%eax),%al
  8018bb:	3c 20                	cmp    $0x20,%al
  8018bd:	74 f4                	je     8018b3 <strtol+0x16>
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	3c 09                	cmp    $0x9,%al
  8018c6:	74 eb                	je     8018b3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	8a 00                	mov    (%eax),%al
  8018cd:	3c 2b                	cmp    $0x2b,%al
  8018cf:	75 05                	jne    8018d6 <strtol+0x39>
		s++;
  8018d1:	ff 45 08             	incl   0x8(%ebp)
  8018d4:	eb 13                	jmp    8018e9 <strtol+0x4c>
	else if (*s == '-')
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	8a 00                	mov    (%eax),%al
  8018db:	3c 2d                	cmp    $0x2d,%al
  8018dd:	75 0a                	jne    8018e9 <strtol+0x4c>
		s++, neg = 1;
  8018df:	ff 45 08             	incl   0x8(%ebp)
  8018e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8018e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018ed:	74 06                	je     8018f5 <strtol+0x58>
  8018ef:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8018f3:	75 20                	jne    801915 <strtol+0x78>
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	8a 00                	mov    (%eax),%al
  8018fa:	3c 30                	cmp    $0x30,%al
  8018fc:	75 17                	jne    801915 <strtol+0x78>
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	40                   	inc    %eax
  801902:	8a 00                	mov    (%eax),%al
  801904:	3c 78                	cmp    $0x78,%al
  801906:	75 0d                	jne    801915 <strtol+0x78>
		s += 2, base = 16;
  801908:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80190c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801913:	eb 28                	jmp    80193d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801915:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801919:	75 15                	jne    801930 <strtol+0x93>
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	8a 00                	mov    (%eax),%al
  801920:	3c 30                	cmp    $0x30,%al
  801922:	75 0c                	jne    801930 <strtol+0x93>
		s++, base = 8;
  801924:	ff 45 08             	incl   0x8(%ebp)
  801927:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80192e:	eb 0d                	jmp    80193d <strtol+0xa0>
	else if (base == 0)
  801930:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801934:	75 07                	jne    80193d <strtol+0xa0>
		base = 10;
  801936:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	8a 00                	mov    (%eax),%al
  801942:	3c 2f                	cmp    $0x2f,%al
  801944:	7e 19                	jle    80195f <strtol+0xc2>
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	8a 00                	mov    (%eax),%al
  80194b:	3c 39                	cmp    $0x39,%al
  80194d:	7f 10                	jg     80195f <strtol+0xc2>
			dig = *s - '0';
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	8a 00                	mov    (%eax),%al
  801954:	0f be c0             	movsbl %al,%eax
  801957:	83 e8 30             	sub    $0x30,%eax
  80195a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80195d:	eb 42                	jmp    8019a1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	8a 00                	mov    (%eax),%al
  801964:	3c 60                	cmp    $0x60,%al
  801966:	7e 19                	jle    801981 <strtol+0xe4>
  801968:	8b 45 08             	mov    0x8(%ebp),%eax
  80196b:	8a 00                	mov    (%eax),%al
  80196d:	3c 7a                	cmp    $0x7a,%al
  80196f:	7f 10                	jg     801981 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	8a 00                	mov    (%eax),%al
  801976:	0f be c0             	movsbl %al,%eax
  801979:	83 e8 57             	sub    $0x57,%eax
  80197c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80197f:	eb 20                	jmp    8019a1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	8a 00                	mov    (%eax),%al
  801986:	3c 40                	cmp    $0x40,%al
  801988:	7e 39                	jle    8019c3 <strtol+0x126>
  80198a:	8b 45 08             	mov    0x8(%ebp),%eax
  80198d:	8a 00                	mov    (%eax),%al
  80198f:	3c 5a                	cmp    $0x5a,%al
  801991:	7f 30                	jg     8019c3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	8a 00                	mov    (%eax),%al
  801998:	0f be c0             	movsbl %al,%eax
  80199b:	83 e8 37             	sub    $0x37,%eax
  80199e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8019a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8019a7:	7d 19                	jge    8019c2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8019a9:	ff 45 08             	incl   0x8(%ebp)
  8019ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019af:	0f af 45 10          	imul   0x10(%ebp),%eax
  8019b3:	89 c2                	mov    %eax,%edx
  8019b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b8:	01 d0                	add    %edx,%eax
  8019ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8019bd:	e9 7b ff ff ff       	jmp    80193d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8019c2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8019c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019c7:	74 08                	je     8019d1 <strtol+0x134>
		*endptr = (char *) s;
  8019c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8019cf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8019d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019d5:	74 07                	je     8019de <strtol+0x141>
  8019d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019da:	f7 d8                	neg    %eax
  8019dc:	eb 03                	jmp    8019e1 <strtol+0x144>
  8019de:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <ltostr>:

void
ltostr(long value, char *str)
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
  8019e6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8019e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8019f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8019f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019fb:	79 13                	jns    801a10 <ltostr+0x2d>
	{
		neg = 1;
  8019fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a04:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a07:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a0a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a0d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a10:	8b 45 08             	mov    0x8(%ebp),%eax
  801a13:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a18:	99                   	cltd   
  801a19:	f7 f9                	idiv   %ecx
  801a1b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a21:	8d 50 01             	lea    0x1(%eax),%edx
  801a24:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a27:	89 c2                	mov    %eax,%edx
  801a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2c:	01 d0                	add    %edx,%eax
  801a2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a31:	83 c2 30             	add    $0x30,%edx
  801a34:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a39:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a3e:	f7 e9                	imul   %ecx
  801a40:	c1 fa 02             	sar    $0x2,%edx
  801a43:	89 c8                	mov    %ecx,%eax
  801a45:	c1 f8 1f             	sar    $0x1f,%eax
  801a48:	29 c2                	sub    %eax,%edx
  801a4a:	89 d0                	mov    %edx,%eax
  801a4c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801a4f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a52:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a57:	f7 e9                	imul   %ecx
  801a59:	c1 fa 02             	sar    $0x2,%edx
  801a5c:	89 c8                	mov    %ecx,%eax
  801a5e:	c1 f8 1f             	sar    $0x1f,%eax
  801a61:	29 c2                	sub    %eax,%edx
  801a63:	89 d0                	mov    %edx,%eax
  801a65:	c1 e0 02             	shl    $0x2,%eax
  801a68:	01 d0                	add    %edx,%eax
  801a6a:	01 c0                	add    %eax,%eax
  801a6c:	29 c1                	sub    %eax,%ecx
  801a6e:	89 ca                	mov    %ecx,%edx
  801a70:	85 d2                	test   %edx,%edx
  801a72:	75 9c                	jne    801a10 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801a74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a7e:	48                   	dec    %eax
  801a7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a82:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a86:	74 3d                	je     801ac5 <ltostr+0xe2>
		start = 1 ;
  801a88:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a8f:	eb 34                	jmp    801ac5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a97:	01 d0                	add    %edx,%eax
  801a99:	8a 00                	mov    (%eax),%al
  801a9b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aa4:	01 c2                	add    %eax,%edx
  801aa6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aac:	01 c8                	add    %ecx,%eax
  801aae:	8a 00                	mov    (%eax),%al
  801ab0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801ab2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab8:	01 c2                	add    %eax,%edx
  801aba:	8a 45 eb             	mov    -0x15(%ebp),%al
  801abd:	88 02                	mov    %al,(%edx)
		start++ ;
  801abf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801ac2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ac8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801acb:	7c c4                	jl     801a91 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801acd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad3:	01 d0                	add    %edx,%eax
  801ad5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801ad8:	90                   	nop
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
  801ade:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801ae1:	ff 75 08             	pushl  0x8(%ebp)
  801ae4:	e8 54 fa ff ff       	call   80153d <strlen>
  801ae9:	83 c4 04             	add    $0x4,%esp
  801aec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801aef:	ff 75 0c             	pushl  0xc(%ebp)
  801af2:	e8 46 fa ff ff       	call   80153d <strlen>
  801af7:	83 c4 04             	add    $0x4,%esp
  801afa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801afd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b0b:	eb 17                	jmp    801b24 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b10:	8b 45 10             	mov    0x10(%ebp),%eax
  801b13:	01 c2                	add    %eax,%edx
  801b15:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	01 c8                	add    %ecx,%eax
  801b1d:	8a 00                	mov    (%eax),%al
  801b1f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b21:	ff 45 fc             	incl   -0x4(%ebp)
  801b24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b27:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b2a:	7c e1                	jl     801b0d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b2c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b33:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b3a:	eb 1f                	jmp    801b5b <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b3f:	8d 50 01             	lea    0x1(%eax),%edx
  801b42:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b45:	89 c2                	mov    %eax,%edx
  801b47:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4a:	01 c2                	add    %eax,%edx
  801b4c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b52:	01 c8                	add    %ecx,%eax
  801b54:	8a 00                	mov    (%eax),%al
  801b56:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801b58:	ff 45 f8             	incl   -0x8(%ebp)
  801b5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b5e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b61:	7c d9                	jl     801b3c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801b63:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b66:	8b 45 10             	mov    0x10(%ebp),%eax
  801b69:	01 d0                	add    %edx,%eax
  801b6b:	c6 00 00             	movb   $0x0,(%eax)
}
  801b6e:	90                   	nop
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801b74:	8b 45 14             	mov    0x14(%ebp),%eax
  801b77:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b7d:	8b 45 14             	mov    0x14(%ebp),%eax
  801b80:	8b 00                	mov    (%eax),%eax
  801b82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b89:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8c:	01 d0                	add    %edx,%eax
  801b8e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b94:	eb 0c                	jmp    801ba2 <strsplit+0x31>
			*string++ = 0;
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	8d 50 01             	lea    0x1(%eax),%edx
  801b9c:	89 55 08             	mov    %edx,0x8(%ebp)
  801b9f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba5:	8a 00                	mov    (%eax),%al
  801ba7:	84 c0                	test   %al,%al
  801ba9:	74 18                	je     801bc3 <strsplit+0x52>
  801bab:	8b 45 08             	mov    0x8(%ebp),%eax
  801bae:	8a 00                	mov    (%eax),%al
  801bb0:	0f be c0             	movsbl %al,%eax
  801bb3:	50                   	push   %eax
  801bb4:	ff 75 0c             	pushl  0xc(%ebp)
  801bb7:	e8 13 fb ff ff       	call   8016cf <strchr>
  801bbc:	83 c4 08             	add    $0x8,%esp
  801bbf:	85 c0                	test   %eax,%eax
  801bc1:	75 d3                	jne    801b96 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	8a 00                	mov    (%eax),%al
  801bc8:	84 c0                	test   %al,%al
  801bca:	74 5a                	je     801c26 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801bcc:	8b 45 14             	mov    0x14(%ebp),%eax
  801bcf:	8b 00                	mov    (%eax),%eax
  801bd1:	83 f8 0f             	cmp    $0xf,%eax
  801bd4:	75 07                	jne    801bdd <strsplit+0x6c>
		{
			return 0;
  801bd6:	b8 00 00 00 00       	mov    $0x0,%eax
  801bdb:	eb 66                	jmp    801c43 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801bdd:	8b 45 14             	mov    0x14(%ebp),%eax
  801be0:	8b 00                	mov    (%eax),%eax
  801be2:	8d 48 01             	lea    0x1(%eax),%ecx
  801be5:	8b 55 14             	mov    0x14(%ebp),%edx
  801be8:	89 0a                	mov    %ecx,(%edx)
  801bea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bf1:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf4:	01 c2                	add    %eax,%edx
  801bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801bfb:	eb 03                	jmp    801c00 <strsplit+0x8f>
			string++;
  801bfd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	8a 00                	mov    (%eax),%al
  801c05:	84 c0                	test   %al,%al
  801c07:	74 8b                	je     801b94 <strsplit+0x23>
  801c09:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0c:	8a 00                	mov    (%eax),%al
  801c0e:	0f be c0             	movsbl %al,%eax
  801c11:	50                   	push   %eax
  801c12:	ff 75 0c             	pushl  0xc(%ebp)
  801c15:	e8 b5 fa ff ff       	call   8016cf <strchr>
  801c1a:	83 c4 08             	add    $0x8,%esp
  801c1d:	85 c0                	test   %eax,%eax
  801c1f:	74 dc                	je     801bfd <strsplit+0x8c>
			string++;
	}
  801c21:	e9 6e ff ff ff       	jmp    801b94 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c26:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c27:	8b 45 14             	mov    0x14(%ebp),%eax
  801c2a:	8b 00                	mov    (%eax),%eax
  801c2c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c33:	8b 45 10             	mov    0x10(%ebp),%eax
  801c36:	01 d0                	add    %edx,%eax
  801c38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c3e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
  801c48:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801c4b:	e8 9b 07 00 00       	call   8023eb <sys_isUHeapPlacementStrategyNEXTFIT>
  801c50:	85 c0                	test   %eax,%eax
  801c52:	0f 84 64 01 00 00    	je     801dbc <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801c58:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801c5e:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801c65:	8b 55 08             	mov    0x8(%ebp),%edx
  801c68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c6b:	01 d0                	add    %edx,%eax
  801c6d:	48                   	dec    %eax
  801c6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801c71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c74:	ba 00 00 00 00       	mov    $0x0,%edx
  801c79:	f7 75 e8             	divl   -0x18(%ebp)
  801c7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c7f:	29 d0                	sub    %edx,%eax
  801c81:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801c88:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c91:	01 d0                	add    %edx,%eax
  801c93:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801c96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801c9d:	a1 28 30 80 00       	mov    0x803028,%eax
  801ca2:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801ca9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801cac:	0f 83 0a 01 00 00    	jae    801dbc <malloc+0x177>
  801cb2:	a1 28 30 80 00       	mov    0x803028,%eax
  801cb7:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801cbe:	85 c0                	test   %eax,%eax
  801cc0:	0f 84 f6 00 00 00    	je     801dbc <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801cc6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ccd:	e9 dc 00 00 00       	jmp    801dae <malloc+0x169>
				flag++;
  801cd2:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801cd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cd8:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801cdf:	85 c0                	test   %eax,%eax
  801ce1:	74 07                	je     801cea <malloc+0xa5>
					flag=0;
  801ce3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801cea:	a1 28 30 80 00       	mov    0x803028,%eax
  801cef:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801cf6:	85 c0                	test   %eax,%eax
  801cf8:	79 05                	jns    801cff <malloc+0xba>
  801cfa:	05 ff 0f 00 00       	add    $0xfff,%eax
  801cff:	c1 f8 0c             	sar    $0xc,%eax
  801d02:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801d05:	0f 85 a0 00 00 00    	jne    801dab <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801d0b:	a1 28 30 80 00       	mov    0x803028,%eax
  801d10:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801d17:	85 c0                	test   %eax,%eax
  801d19:	79 05                	jns    801d20 <malloc+0xdb>
  801d1b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801d20:	c1 f8 0c             	sar    $0xc,%eax
  801d23:	89 c2                	mov    %eax,%edx
  801d25:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d28:	29 d0                	sub    %edx,%eax
  801d2a:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801d2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d30:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801d33:	eb 11                	jmp    801d46 <malloc+0x101>
						hFreeArr[j] = 1;
  801d35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d38:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801d3f:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801d43:	ff 45 ec             	incl   -0x14(%ebp)
  801d46:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d49:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d4c:	7e e7                	jle    801d35 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801d4e:	a1 28 30 80 00       	mov    0x803028,%eax
  801d53:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801d56:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801d5c:	c1 e2 0c             	shl    $0xc,%edx
  801d5f:	89 15 04 30 80 00    	mov    %edx,0x803004
  801d65:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801d6b:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801d72:	a1 28 30 80 00       	mov    0x803028,%eax
  801d77:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801d7e:	89 c2                	mov    %eax,%edx
  801d80:	a1 28 30 80 00       	mov    0x803028,%eax
  801d85:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801d8c:	83 ec 08             	sub    $0x8,%esp
  801d8f:	52                   	push   %edx
  801d90:	50                   	push   %eax
  801d91:	e8 8b 02 00 00       	call   802021 <sys_allocateMem>
  801d96:	83 c4 10             	add    $0x10,%esp

					idx++;
  801d99:	a1 28 30 80 00       	mov    0x803028,%eax
  801d9e:	40                   	inc    %eax
  801d9f:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801da4:	a1 04 30 80 00       	mov    0x803004,%eax
  801da9:	eb 16                	jmp    801dc1 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801dab:	ff 45 f0             	incl   -0x10(%ebp)
  801dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801db1:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801db6:	0f 86 16 ff ff ff    	jbe    801cd2 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801dbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc1:	c9                   	leave  
  801dc2:	c3                   	ret    

00801dc3 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801dc3:	55                   	push   %ebp
  801dc4:	89 e5                	mov    %esp,%ebp
  801dc6:	83 ec 18             	sub    $0x18,%esp
  801dc9:	8b 45 10             	mov    0x10(%ebp),%eax
  801dcc:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801dcf:	83 ec 04             	sub    $0x4,%esp
  801dd2:	68 10 2d 80 00       	push   $0x802d10
  801dd7:	6a 59                	push   $0x59
  801dd9:	68 2f 2d 80 00       	push   $0x802d2f
  801dde:	e8 24 ee ff ff       	call   800c07 <_panic>

00801de3 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801de3:	55                   	push   %ebp
  801de4:	89 e5                	mov    %esp,%ebp
  801de6:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801de9:	83 ec 04             	sub    $0x4,%esp
  801dec:	68 3b 2d 80 00       	push   $0x802d3b
  801df1:	6a 5f                	push   $0x5f
  801df3:	68 2f 2d 80 00       	push   $0x802d2f
  801df8:	e8 0a ee ff ff       	call   800c07 <_panic>

00801dfd <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801dfd:	55                   	push   %ebp
  801dfe:	89 e5                	mov    %esp,%ebp
  801e00:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801e03:	83 ec 04             	sub    $0x4,%esp
  801e06:	68 58 2d 80 00       	push   $0x802d58
  801e0b:	6a 70                	push   $0x70
  801e0d:	68 2f 2d 80 00       	push   $0x802d2f
  801e12:	e8 f0 ed ff ff       	call   800c07 <_panic>

00801e17 <sfree>:

}


void sfree(void* virtual_address)
{
  801e17:	55                   	push   %ebp
  801e18:	89 e5                	mov    %esp,%ebp
  801e1a:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801e1d:	83 ec 04             	sub    $0x4,%esp
  801e20:	68 7b 2d 80 00       	push   $0x802d7b
  801e25:	6a 7b                	push   $0x7b
  801e27:	68 2f 2d 80 00       	push   $0x802d2f
  801e2c:	e8 d6 ed ff ff       	call   800c07 <_panic>

00801e31 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
  801e34:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801e37:	83 ec 04             	sub    $0x4,%esp
  801e3a:	68 98 2d 80 00       	push   $0x802d98
  801e3f:	68 93 00 00 00       	push   $0x93
  801e44:	68 2f 2d 80 00       	push   $0x802d2f
  801e49:	e8 b9 ed ff ff       	call   800c07 <_panic>

00801e4e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e4e:	55                   	push   %ebp
  801e4f:	89 e5                	mov    %esp,%ebp
  801e51:	57                   	push   %edi
  801e52:	56                   	push   %esi
  801e53:	53                   	push   %ebx
  801e54:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e57:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e60:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e63:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e66:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e69:	cd 30                	int    $0x30
  801e6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e71:	83 c4 10             	add    $0x10,%esp
  801e74:	5b                   	pop    %ebx
  801e75:	5e                   	pop    %esi
  801e76:	5f                   	pop    %edi
  801e77:	5d                   	pop    %ebp
  801e78:	c3                   	ret    

00801e79 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
  801e7c:	83 ec 04             	sub    $0x4,%esp
  801e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e82:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e85:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e89:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	52                   	push   %edx
  801e91:	ff 75 0c             	pushl  0xc(%ebp)
  801e94:	50                   	push   %eax
  801e95:	6a 00                	push   $0x0
  801e97:	e8 b2 ff ff ff       	call   801e4e <syscall>
  801e9c:	83 c4 18             	add    $0x18,%esp
}
  801e9f:	90                   	nop
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 01                	push   $0x1
  801eb1:	e8 98 ff ff ff       	call   801e4e <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	50                   	push   %eax
  801eca:	6a 05                	push   $0x5
  801ecc:	e8 7d ff ff ff       	call   801e4e <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 02                	push   $0x2
  801ee5:	e8 64 ff ff ff       	call   801e4e <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 03                	push   $0x3
  801efe:	e8 4b ff ff ff       	call   801e4e <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
}
  801f06:	c9                   	leave  
  801f07:	c3                   	ret    

00801f08 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 04                	push   $0x4
  801f17:	e8 32 ff ff ff       	call   801e4e <syscall>
  801f1c:	83 c4 18             	add    $0x18,%esp
}
  801f1f:	c9                   	leave  
  801f20:	c3                   	ret    

00801f21 <sys_env_exit>:


void sys_env_exit(void)
{
  801f21:	55                   	push   %ebp
  801f22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f24:	6a 00                	push   $0x0
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 06                	push   $0x6
  801f30:	e8 19 ff ff ff       	call   801e4e <syscall>
  801f35:	83 c4 18             	add    $0x18,%esp
}
  801f38:	90                   	nop
  801f39:	c9                   	leave  
  801f3a:	c3                   	ret    

00801f3b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f3b:	55                   	push   %ebp
  801f3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f41:	8b 45 08             	mov    0x8(%ebp),%eax
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	52                   	push   %edx
  801f4b:	50                   	push   %eax
  801f4c:	6a 07                	push   $0x7
  801f4e:	e8 fb fe ff ff       	call   801e4e <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
  801f5b:	56                   	push   %esi
  801f5c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f5d:	8b 75 18             	mov    0x18(%ebp),%esi
  801f60:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f63:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	56                   	push   %esi
  801f6d:	53                   	push   %ebx
  801f6e:	51                   	push   %ecx
  801f6f:	52                   	push   %edx
  801f70:	50                   	push   %eax
  801f71:	6a 08                	push   $0x8
  801f73:	e8 d6 fe ff ff       	call   801e4e <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f7e:	5b                   	pop    %ebx
  801f7f:	5e                   	pop    %esi
  801f80:	5d                   	pop    %ebp
  801f81:	c3                   	ret    

00801f82 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f85:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f88:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	52                   	push   %edx
  801f92:	50                   	push   %eax
  801f93:	6a 09                	push   $0x9
  801f95:	e8 b4 fe ff ff       	call   801e4e <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	ff 75 0c             	pushl  0xc(%ebp)
  801fab:	ff 75 08             	pushl  0x8(%ebp)
  801fae:	6a 0a                	push   $0xa
  801fb0:	e8 99 fe ff ff       	call   801e4e <syscall>
  801fb5:	83 c4 18             	add    $0x18,%esp
}
  801fb8:	c9                   	leave  
  801fb9:	c3                   	ret    

00801fba <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801fba:	55                   	push   %ebp
  801fbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 0b                	push   $0xb
  801fc9:	e8 80 fe ff ff       	call   801e4e <syscall>
  801fce:	83 c4 18             	add    $0x18,%esp
}
  801fd1:	c9                   	leave  
  801fd2:	c3                   	ret    

00801fd3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fd3:	55                   	push   %ebp
  801fd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 0c                	push   $0xc
  801fe2:	e8 67 fe ff ff       	call   801e4e <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 0d                	push   $0xd
  801ffb:	e8 4e fe ff ff       	call   801e4e <syscall>
  802000:	83 c4 18             	add    $0x18,%esp
}
  802003:	c9                   	leave  
  802004:	c3                   	ret    

00802005 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802005:	55                   	push   %ebp
  802006:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	ff 75 0c             	pushl  0xc(%ebp)
  802011:	ff 75 08             	pushl  0x8(%ebp)
  802014:	6a 11                	push   $0x11
  802016:	e8 33 fe ff ff       	call   801e4e <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
	return;
  80201e:	90                   	nop
}
  80201f:	c9                   	leave  
  802020:	c3                   	ret    

00802021 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802021:	55                   	push   %ebp
  802022:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	ff 75 0c             	pushl  0xc(%ebp)
  80202d:	ff 75 08             	pushl  0x8(%ebp)
  802030:	6a 12                	push   $0x12
  802032:	e8 17 fe ff ff       	call   801e4e <syscall>
  802037:	83 c4 18             	add    $0x18,%esp
	return ;
  80203a:	90                   	nop
}
  80203b:	c9                   	leave  
  80203c:	c3                   	ret    

0080203d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80203d:	55                   	push   %ebp
  80203e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 0e                	push   $0xe
  80204c:	e8 fd fd ff ff       	call   801e4e <syscall>
  802051:	83 c4 18             	add    $0x18,%esp
}
  802054:	c9                   	leave  
  802055:	c3                   	ret    

00802056 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802056:	55                   	push   %ebp
  802057:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	ff 75 08             	pushl  0x8(%ebp)
  802064:	6a 0f                	push   $0xf
  802066:	e8 e3 fd ff ff       	call   801e4e <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
}
  80206e:	c9                   	leave  
  80206f:	c3                   	ret    

00802070 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802070:	55                   	push   %ebp
  802071:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 10                	push   $0x10
  80207f:	e8 ca fd ff ff       	call   801e4e <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
}
  802087:	90                   	nop
  802088:	c9                   	leave  
  802089:	c3                   	ret    

0080208a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80208a:	55                   	push   %ebp
  80208b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 14                	push   $0x14
  802099:	e8 b0 fd ff ff       	call   801e4e <syscall>
  80209e:	83 c4 18             	add    $0x18,%esp
}
  8020a1:	90                   	nop
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 15                	push   $0x15
  8020b3:	e8 96 fd ff ff       	call   801e4e <syscall>
  8020b8:	83 c4 18             	add    $0x18,%esp
}
  8020bb:	90                   	nop
  8020bc:	c9                   	leave  
  8020bd:	c3                   	ret    

008020be <sys_cputc>:


void
sys_cputc(const char c)
{
  8020be:	55                   	push   %ebp
  8020bf:	89 e5                	mov    %esp,%ebp
  8020c1:	83 ec 04             	sub    $0x4,%esp
  8020c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020ca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	50                   	push   %eax
  8020d7:	6a 16                	push   $0x16
  8020d9:	e8 70 fd ff ff       	call   801e4e <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
}
  8020e1:	90                   	nop
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8020e4:	55                   	push   %ebp
  8020e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 17                	push   $0x17
  8020f3:	e8 56 fd ff ff       	call   801e4e <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
}
  8020fb:	90                   	nop
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802101:	8b 45 08             	mov    0x8(%ebp),%eax
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	ff 75 0c             	pushl  0xc(%ebp)
  80210d:	50                   	push   %eax
  80210e:	6a 18                	push   $0x18
  802110:	e8 39 fd ff ff       	call   801e4e <syscall>
  802115:	83 c4 18             	add    $0x18,%esp
}
  802118:	c9                   	leave  
  802119:	c3                   	ret    

0080211a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80211a:	55                   	push   %ebp
  80211b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80211d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802120:	8b 45 08             	mov    0x8(%ebp),%eax
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	52                   	push   %edx
  80212a:	50                   	push   %eax
  80212b:	6a 1b                	push   $0x1b
  80212d:	e8 1c fd ff ff       	call   801e4e <syscall>
  802132:	83 c4 18             	add    $0x18,%esp
}
  802135:	c9                   	leave  
  802136:	c3                   	ret    

00802137 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802137:	55                   	push   %ebp
  802138:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80213a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80213d:	8b 45 08             	mov    0x8(%ebp),%eax
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	52                   	push   %edx
  802147:	50                   	push   %eax
  802148:	6a 19                	push   $0x19
  80214a:	e8 ff fc ff ff       	call   801e4e <syscall>
  80214f:	83 c4 18             	add    $0x18,%esp
}
  802152:	90                   	nop
  802153:	c9                   	leave  
  802154:	c3                   	ret    

00802155 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802155:	55                   	push   %ebp
  802156:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802158:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215b:	8b 45 08             	mov    0x8(%ebp),%eax
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	52                   	push   %edx
  802165:	50                   	push   %eax
  802166:	6a 1a                	push   $0x1a
  802168:	e8 e1 fc ff ff       	call   801e4e <syscall>
  80216d:	83 c4 18             	add    $0x18,%esp
}
  802170:	90                   	nop
  802171:	c9                   	leave  
  802172:	c3                   	ret    

00802173 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802173:	55                   	push   %ebp
  802174:	89 e5                	mov    %esp,%ebp
  802176:	83 ec 04             	sub    $0x4,%esp
  802179:	8b 45 10             	mov    0x10(%ebp),%eax
  80217c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80217f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802182:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802186:	8b 45 08             	mov    0x8(%ebp),%eax
  802189:	6a 00                	push   $0x0
  80218b:	51                   	push   %ecx
  80218c:	52                   	push   %edx
  80218d:	ff 75 0c             	pushl  0xc(%ebp)
  802190:	50                   	push   %eax
  802191:	6a 1c                	push   $0x1c
  802193:	e8 b6 fc ff ff       	call   801e4e <syscall>
  802198:	83 c4 18             	add    $0x18,%esp
}
  80219b:	c9                   	leave  
  80219c:	c3                   	ret    

0080219d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80219d:	55                   	push   %ebp
  80219e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	6a 00                	push   $0x0
  8021ac:	52                   	push   %edx
  8021ad:	50                   	push   %eax
  8021ae:	6a 1d                	push   $0x1d
  8021b0:	e8 99 fc ff ff       	call   801e4e <syscall>
  8021b5:	83 c4 18             	add    $0x18,%esp
}
  8021b8:	c9                   	leave  
  8021b9:	c3                   	ret    

008021ba <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021ba:	55                   	push   %ebp
  8021bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	51                   	push   %ecx
  8021cb:	52                   	push   %edx
  8021cc:	50                   	push   %eax
  8021cd:	6a 1e                	push   $0x1e
  8021cf:	e8 7a fc ff ff       	call   801e4e <syscall>
  8021d4:	83 c4 18             	add    $0x18,%esp
}
  8021d7:	c9                   	leave  
  8021d8:	c3                   	ret    

008021d9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8021d9:	55                   	push   %ebp
  8021da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8021dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021df:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	52                   	push   %edx
  8021e9:	50                   	push   %eax
  8021ea:	6a 1f                	push   $0x1f
  8021ec:	e8 5d fc ff ff       	call   801e4e <syscall>
  8021f1:	83 c4 18             	add    $0x18,%esp
}
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 20                	push   $0x20
  802205:	e8 44 fc ff ff       	call   801e4e <syscall>
  80220a:	83 c4 18             	add    $0x18,%esp
}
  80220d:	c9                   	leave  
  80220e:	c3                   	ret    

0080220f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80220f:	55                   	push   %ebp
  802210:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802212:	8b 45 08             	mov    0x8(%ebp),%eax
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	ff 75 10             	pushl  0x10(%ebp)
  80221c:	ff 75 0c             	pushl  0xc(%ebp)
  80221f:	50                   	push   %eax
  802220:	6a 21                	push   $0x21
  802222:	e8 27 fc ff ff       	call   801e4e <syscall>
  802227:	83 c4 18             	add    $0x18,%esp
}
  80222a:	c9                   	leave  
  80222b:	c3                   	ret    

0080222c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80222c:	55                   	push   %ebp
  80222d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80222f:	8b 45 08             	mov    0x8(%ebp),%eax
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	50                   	push   %eax
  80223b:	6a 22                	push   $0x22
  80223d:	e8 0c fc ff ff       	call   801e4e <syscall>
  802242:	83 c4 18             	add    $0x18,%esp
}
  802245:	90                   	nop
  802246:	c9                   	leave  
  802247:	c3                   	ret    

00802248 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80224b:	8b 45 08             	mov    0x8(%ebp),%eax
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	50                   	push   %eax
  802257:	6a 23                	push   $0x23
  802259:	e8 f0 fb ff ff       	call   801e4e <syscall>
  80225e:	83 c4 18             	add    $0x18,%esp
}
  802261:	90                   	nop
  802262:	c9                   	leave  
  802263:	c3                   	ret    

00802264 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802264:	55                   	push   %ebp
  802265:	89 e5                	mov    %esp,%ebp
  802267:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80226a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80226d:	8d 50 04             	lea    0x4(%eax),%edx
  802270:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	52                   	push   %edx
  80227a:	50                   	push   %eax
  80227b:	6a 24                	push   $0x24
  80227d:	e8 cc fb ff ff       	call   801e4e <syscall>
  802282:	83 c4 18             	add    $0x18,%esp
	return result;
  802285:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802288:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80228b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80228e:	89 01                	mov    %eax,(%ecx)
  802290:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802293:	8b 45 08             	mov    0x8(%ebp),%eax
  802296:	c9                   	leave  
  802297:	c2 04 00             	ret    $0x4

0080229a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80229a:	55                   	push   %ebp
  80229b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	ff 75 10             	pushl  0x10(%ebp)
  8022a4:	ff 75 0c             	pushl  0xc(%ebp)
  8022a7:	ff 75 08             	pushl  0x8(%ebp)
  8022aa:	6a 13                	push   $0x13
  8022ac:	e8 9d fb ff ff       	call   801e4e <syscall>
  8022b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b4:	90                   	nop
}
  8022b5:	c9                   	leave  
  8022b6:	c3                   	ret    

008022b7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8022b7:	55                   	push   %ebp
  8022b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 25                	push   $0x25
  8022c6:	e8 83 fb ff ff       	call   801e4e <syscall>
  8022cb:	83 c4 18             	add    $0x18,%esp
}
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
  8022d3:	83 ec 04             	sub    $0x4,%esp
  8022d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022dc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	50                   	push   %eax
  8022e9:	6a 26                	push   $0x26
  8022eb:	e8 5e fb ff ff       	call   801e4e <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f3:	90                   	nop
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <rsttst>:
void rsttst()
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 28                	push   $0x28
  802305:	e8 44 fb ff ff       	call   801e4e <syscall>
  80230a:	83 c4 18             	add    $0x18,%esp
	return ;
  80230d:	90                   	nop
}
  80230e:	c9                   	leave  
  80230f:	c3                   	ret    

00802310 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802310:	55                   	push   %ebp
  802311:	89 e5                	mov    %esp,%ebp
  802313:	83 ec 04             	sub    $0x4,%esp
  802316:	8b 45 14             	mov    0x14(%ebp),%eax
  802319:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80231c:	8b 55 18             	mov    0x18(%ebp),%edx
  80231f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802323:	52                   	push   %edx
  802324:	50                   	push   %eax
  802325:	ff 75 10             	pushl  0x10(%ebp)
  802328:	ff 75 0c             	pushl  0xc(%ebp)
  80232b:	ff 75 08             	pushl  0x8(%ebp)
  80232e:	6a 27                	push   $0x27
  802330:	e8 19 fb ff ff       	call   801e4e <syscall>
  802335:	83 c4 18             	add    $0x18,%esp
	return ;
  802338:	90                   	nop
}
  802339:	c9                   	leave  
  80233a:	c3                   	ret    

0080233b <chktst>:
void chktst(uint32 n)
{
  80233b:	55                   	push   %ebp
  80233c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 00                	push   $0x0
  802344:	6a 00                	push   $0x0
  802346:	ff 75 08             	pushl  0x8(%ebp)
  802349:	6a 29                	push   $0x29
  80234b:	e8 fe fa ff ff       	call   801e4e <syscall>
  802350:	83 c4 18             	add    $0x18,%esp
	return ;
  802353:	90                   	nop
}
  802354:	c9                   	leave  
  802355:	c3                   	ret    

00802356 <inctst>:

void inctst()
{
  802356:	55                   	push   %ebp
  802357:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802359:	6a 00                	push   $0x0
  80235b:	6a 00                	push   $0x0
  80235d:	6a 00                	push   $0x0
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	6a 2a                	push   $0x2a
  802365:	e8 e4 fa ff ff       	call   801e4e <syscall>
  80236a:	83 c4 18             	add    $0x18,%esp
	return ;
  80236d:	90                   	nop
}
  80236e:	c9                   	leave  
  80236f:	c3                   	ret    

00802370 <gettst>:
uint32 gettst()
{
  802370:	55                   	push   %ebp
  802371:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	6a 00                	push   $0x0
  802379:	6a 00                	push   $0x0
  80237b:	6a 00                	push   $0x0
  80237d:	6a 2b                	push   $0x2b
  80237f:	e8 ca fa ff ff       	call   801e4e <syscall>
  802384:	83 c4 18             	add    $0x18,%esp
}
  802387:	c9                   	leave  
  802388:	c3                   	ret    

00802389 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802389:	55                   	push   %ebp
  80238a:	89 e5                	mov    %esp,%ebp
  80238c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80238f:	6a 00                	push   $0x0
  802391:	6a 00                	push   $0x0
  802393:	6a 00                	push   $0x0
  802395:	6a 00                	push   $0x0
  802397:	6a 00                	push   $0x0
  802399:	6a 2c                	push   $0x2c
  80239b:	e8 ae fa ff ff       	call   801e4e <syscall>
  8023a0:	83 c4 18             	add    $0x18,%esp
  8023a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023a6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023aa:	75 07                	jne    8023b3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023ac:	b8 01 00 00 00       	mov    $0x1,%eax
  8023b1:	eb 05                	jmp    8023b8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023b8:	c9                   	leave  
  8023b9:	c3                   	ret    

008023ba <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023ba:	55                   	push   %ebp
  8023bb:	89 e5                	mov    %esp,%ebp
  8023bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 00                	push   $0x0
  8023c8:	6a 00                	push   $0x0
  8023ca:	6a 2c                	push   $0x2c
  8023cc:	e8 7d fa ff ff       	call   801e4e <syscall>
  8023d1:	83 c4 18             	add    $0x18,%esp
  8023d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023d7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8023db:	75 07                	jne    8023e4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8023dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8023e2:	eb 05                	jmp    8023e9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8023e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023e9:	c9                   	leave  
  8023ea:	c3                   	ret    

008023eb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023eb:	55                   	push   %ebp
  8023ec:	89 e5                	mov    %esp,%ebp
  8023ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023f1:	6a 00                	push   $0x0
  8023f3:	6a 00                	push   $0x0
  8023f5:	6a 00                	push   $0x0
  8023f7:	6a 00                	push   $0x0
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 2c                	push   $0x2c
  8023fd:	e8 4c fa ff ff       	call   801e4e <syscall>
  802402:	83 c4 18             	add    $0x18,%esp
  802405:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802408:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80240c:	75 07                	jne    802415 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80240e:	b8 01 00 00 00       	mov    $0x1,%eax
  802413:	eb 05                	jmp    80241a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802415:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80241a:	c9                   	leave  
  80241b:	c3                   	ret    

0080241c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80241c:	55                   	push   %ebp
  80241d:	89 e5                	mov    %esp,%ebp
  80241f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802422:	6a 00                	push   $0x0
  802424:	6a 00                	push   $0x0
  802426:	6a 00                	push   $0x0
  802428:	6a 00                	push   $0x0
  80242a:	6a 00                	push   $0x0
  80242c:	6a 2c                	push   $0x2c
  80242e:	e8 1b fa ff ff       	call   801e4e <syscall>
  802433:	83 c4 18             	add    $0x18,%esp
  802436:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802439:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80243d:	75 07                	jne    802446 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80243f:	b8 01 00 00 00       	mov    $0x1,%eax
  802444:	eb 05                	jmp    80244b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802446:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80244b:	c9                   	leave  
  80244c:	c3                   	ret    

0080244d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80244d:	55                   	push   %ebp
  80244e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	6a 00                	push   $0x0
  802458:	ff 75 08             	pushl  0x8(%ebp)
  80245b:	6a 2d                	push   $0x2d
  80245d:	e8 ec f9 ff ff       	call   801e4e <syscall>
  802462:	83 c4 18             	add    $0x18,%esp
	return ;
  802465:	90                   	nop
}
  802466:	c9                   	leave  
  802467:	c3                   	ret    

00802468 <__udivdi3>:
  802468:	55                   	push   %ebp
  802469:	57                   	push   %edi
  80246a:	56                   	push   %esi
  80246b:	53                   	push   %ebx
  80246c:	83 ec 1c             	sub    $0x1c,%esp
  80246f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802473:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802477:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80247b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80247f:	89 ca                	mov    %ecx,%edx
  802481:	89 f8                	mov    %edi,%eax
  802483:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802487:	85 f6                	test   %esi,%esi
  802489:	75 2d                	jne    8024b8 <__udivdi3+0x50>
  80248b:	39 cf                	cmp    %ecx,%edi
  80248d:	77 65                	ja     8024f4 <__udivdi3+0x8c>
  80248f:	89 fd                	mov    %edi,%ebp
  802491:	85 ff                	test   %edi,%edi
  802493:	75 0b                	jne    8024a0 <__udivdi3+0x38>
  802495:	b8 01 00 00 00       	mov    $0x1,%eax
  80249a:	31 d2                	xor    %edx,%edx
  80249c:	f7 f7                	div    %edi
  80249e:	89 c5                	mov    %eax,%ebp
  8024a0:	31 d2                	xor    %edx,%edx
  8024a2:	89 c8                	mov    %ecx,%eax
  8024a4:	f7 f5                	div    %ebp
  8024a6:	89 c1                	mov    %eax,%ecx
  8024a8:	89 d8                	mov    %ebx,%eax
  8024aa:	f7 f5                	div    %ebp
  8024ac:	89 cf                	mov    %ecx,%edi
  8024ae:	89 fa                	mov    %edi,%edx
  8024b0:	83 c4 1c             	add    $0x1c,%esp
  8024b3:	5b                   	pop    %ebx
  8024b4:	5e                   	pop    %esi
  8024b5:	5f                   	pop    %edi
  8024b6:	5d                   	pop    %ebp
  8024b7:	c3                   	ret    
  8024b8:	39 ce                	cmp    %ecx,%esi
  8024ba:	77 28                	ja     8024e4 <__udivdi3+0x7c>
  8024bc:	0f bd fe             	bsr    %esi,%edi
  8024bf:	83 f7 1f             	xor    $0x1f,%edi
  8024c2:	75 40                	jne    802504 <__udivdi3+0x9c>
  8024c4:	39 ce                	cmp    %ecx,%esi
  8024c6:	72 0a                	jb     8024d2 <__udivdi3+0x6a>
  8024c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8024cc:	0f 87 9e 00 00 00    	ja     802570 <__udivdi3+0x108>
  8024d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d7:	89 fa                	mov    %edi,%edx
  8024d9:	83 c4 1c             	add    $0x1c,%esp
  8024dc:	5b                   	pop    %ebx
  8024dd:	5e                   	pop    %esi
  8024de:	5f                   	pop    %edi
  8024df:	5d                   	pop    %ebp
  8024e0:	c3                   	ret    
  8024e1:	8d 76 00             	lea    0x0(%esi),%esi
  8024e4:	31 ff                	xor    %edi,%edi
  8024e6:	31 c0                	xor    %eax,%eax
  8024e8:	89 fa                	mov    %edi,%edx
  8024ea:	83 c4 1c             	add    $0x1c,%esp
  8024ed:	5b                   	pop    %ebx
  8024ee:	5e                   	pop    %esi
  8024ef:	5f                   	pop    %edi
  8024f0:	5d                   	pop    %ebp
  8024f1:	c3                   	ret    
  8024f2:	66 90                	xchg   %ax,%ax
  8024f4:	89 d8                	mov    %ebx,%eax
  8024f6:	f7 f7                	div    %edi
  8024f8:	31 ff                	xor    %edi,%edi
  8024fa:	89 fa                	mov    %edi,%edx
  8024fc:	83 c4 1c             	add    $0x1c,%esp
  8024ff:	5b                   	pop    %ebx
  802500:	5e                   	pop    %esi
  802501:	5f                   	pop    %edi
  802502:	5d                   	pop    %ebp
  802503:	c3                   	ret    
  802504:	bd 20 00 00 00       	mov    $0x20,%ebp
  802509:	89 eb                	mov    %ebp,%ebx
  80250b:	29 fb                	sub    %edi,%ebx
  80250d:	89 f9                	mov    %edi,%ecx
  80250f:	d3 e6                	shl    %cl,%esi
  802511:	89 c5                	mov    %eax,%ebp
  802513:	88 d9                	mov    %bl,%cl
  802515:	d3 ed                	shr    %cl,%ebp
  802517:	89 e9                	mov    %ebp,%ecx
  802519:	09 f1                	or     %esi,%ecx
  80251b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80251f:	89 f9                	mov    %edi,%ecx
  802521:	d3 e0                	shl    %cl,%eax
  802523:	89 c5                	mov    %eax,%ebp
  802525:	89 d6                	mov    %edx,%esi
  802527:	88 d9                	mov    %bl,%cl
  802529:	d3 ee                	shr    %cl,%esi
  80252b:	89 f9                	mov    %edi,%ecx
  80252d:	d3 e2                	shl    %cl,%edx
  80252f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802533:	88 d9                	mov    %bl,%cl
  802535:	d3 e8                	shr    %cl,%eax
  802537:	09 c2                	or     %eax,%edx
  802539:	89 d0                	mov    %edx,%eax
  80253b:	89 f2                	mov    %esi,%edx
  80253d:	f7 74 24 0c          	divl   0xc(%esp)
  802541:	89 d6                	mov    %edx,%esi
  802543:	89 c3                	mov    %eax,%ebx
  802545:	f7 e5                	mul    %ebp
  802547:	39 d6                	cmp    %edx,%esi
  802549:	72 19                	jb     802564 <__udivdi3+0xfc>
  80254b:	74 0b                	je     802558 <__udivdi3+0xf0>
  80254d:	89 d8                	mov    %ebx,%eax
  80254f:	31 ff                	xor    %edi,%edi
  802551:	e9 58 ff ff ff       	jmp    8024ae <__udivdi3+0x46>
  802556:	66 90                	xchg   %ax,%ax
  802558:	8b 54 24 08          	mov    0x8(%esp),%edx
  80255c:	89 f9                	mov    %edi,%ecx
  80255e:	d3 e2                	shl    %cl,%edx
  802560:	39 c2                	cmp    %eax,%edx
  802562:	73 e9                	jae    80254d <__udivdi3+0xe5>
  802564:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802567:	31 ff                	xor    %edi,%edi
  802569:	e9 40 ff ff ff       	jmp    8024ae <__udivdi3+0x46>
  80256e:	66 90                	xchg   %ax,%ax
  802570:	31 c0                	xor    %eax,%eax
  802572:	e9 37 ff ff ff       	jmp    8024ae <__udivdi3+0x46>
  802577:	90                   	nop

00802578 <__umoddi3>:
  802578:	55                   	push   %ebp
  802579:	57                   	push   %edi
  80257a:	56                   	push   %esi
  80257b:	53                   	push   %ebx
  80257c:	83 ec 1c             	sub    $0x1c,%esp
  80257f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802583:	8b 74 24 34          	mov    0x34(%esp),%esi
  802587:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80258b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80258f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802593:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802597:	89 f3                	mov    %esi,%ebx
  802599:	89 fa                	mov    %edi,%edx
  80259b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80259f:	89 34 24             	mov    %esi,(%esp)
  8025a2:	85 c0                	test   %eax,%eax
  8025a4:	75 1a                	jne    8025c0 <__umoddi3+0x48>
  8025a6:	39 f7                	cmp    %esi,%edi
  8025a8:	0f 86 a2 00 00 00    	jbe    802650 <__umoddi3+0xd8>
  8025ae:	89 c8                	mov    %ecx,%eax
  8025b0:	89 f2                	mov    %esi,%edx
  8025b2:	f7 f7                	div    %edi
  8025b4:	89 d0                	mov    %edx,%eax
  8025b6:	31 d2                	xor    %edx,%edx
  8025b8:	83 c4 1c             	add    $0x1c,%esp
  8025bb:	5b                   	pop    %ebx
  8025bc:	5e                   	pop    %esi
  8025bd:	5f                   	pop    %edi
  8025be:	5d                   	pop    %ebp
  8025bf:	c3                   	ret    
  8025c0:	39 f0                	cmp    %esi,%eax
  8025c2:	0f 87 ac 00 00 00    	ja     802674 <__umoddi3+0xfc>
  8025c8:	0f bd e8             	bsr    %eax,%ebp
  8025cb:	83 f5 1f             	xor    $0x1f,%ebp
  8025ce:	0f 84 ac 00 00 00    	je     802680 <__umoddi3+0x108>
  8025d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8025d9:	29 ef                	sub    %ebp,%edi
  8025db:	89 fe                	mov    %edi,%esi
  8025dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025e1:	89 e9                	mov    %ebp,%ecx
  8025e3:	d3 e0                	shl    %cl,%eax
  8025e5:	89 d7                	mov    %edx,%edi
  8025e7:	89 f1                	mov    %esi,%ecx
  8025e9:	d3 ef                	shr    %cl,%edi
  8025eb:	09 c7                	or     %eax,%edi
  8025ed:	89 e9                	mov    %ebp,%ecx
  8025ef:	d3 e2                	shl    %cl,%edx
  8025f1:	89 14 24             	mov    %edx,(%esp)
  8025f4:	89 d8                	mov    %ebx,%eax
  8025f6:	d3 e0                	shl    %cl,%eax
  8025f8:	89 c2                	mov    %eax,%edx
  8025fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025fe:	d3 e0                	shl    %cl,%eax
  802600:	89 44 24 04          	mov    %eax,0x4(%esp)
  802604:	8b 44 24 08          	mov    0x8(%esp),%eax
  802608:	89 f1                	mov    %esi,%ecx
  80260a:	d3 e8                	shr    %cl,%eax
  80260c:	09 d0                	or     %edx,%eax
  80260e:	d3 eb                	shr    %cl,%ebx
  802610:	89 da                	mov    %ebx,%edx
  802612:	f7 f7                	div    %edi
  802614:	89 d3                	mov    %edx,%ebx
  802616:	f7 24 24             	mull   (%esp)
  802619:	89 c6                	mov    %eax,%esi
  80261b:	89 d1                	mov    %edx,%ecx
  80261d:	39 d3                	cmp    %edx,%ebx
  80261f:	0f 82 87 00 00 00    	jb     8026ac <__umoddi3+0x134>
  802625:	0f 84 91 00 00 00    	je     8026bc <__umoddi3+0x144>
  80262b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80262f:	29 f2                	sub    %esi,%edx
  802631:	19 cb                	sbb    %ecx,%ebx
  802633:	89 d8                	mov    %ebx,%eax
  802635:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802639:	d3 e0                	shl    %cl,%eax
  80263b:	89 e9                	mov    %ebp,%ecx
  80263d:	d3 ea                	shr    %cl,%edx
  80263f:	09 d0                	or     %edx,%eax
  802641:	89 e9                	mov    %ebp,%ecx
  802643:	d3 eb                	shr    %cl,%ebx
  802645:	89 da                	mov    %ebx,%edx
  802647:	83 c4 1c             	add    $0x1c,%esp
  80264a:	5b                   	pop    %ebx
  80264b:	5e                   	pop    %esi
  80264c:	5f                   	pop    %edi
  80264d:	5d                   	pop    %ebp
  80264e:	c3                   	ret    
  80264f:	90                   	nop
  802650:	89 fd                	mov    %edi,%ebp
  802652:	85 ff                	test   %edi,%edi
  802654:	75 0b                	jne    802661 <__umoddi3+0xe9>
  802656:	b8 01 00 00 00       	mov    $0x1,%eax
  80265b:	31 d2                	xor    %edx,%edx
  80265d:	f7 f7                	div    %edi
  80265f:	89 c5                	mov    %eax,%ebp
  802661:	89 f0                	mov    %esi,%eax
  802663:	31 d2                	xor    %edx,%edx
  802665:	f7 f5                	div    %ebp
  802667:	89 c8                	mov    %ecx,%eax
  802669:	f7 f5                	div    %ebp
  80266b:	89 d0                	mov    %edx,%eax
  80266d:	e9 44 ff ff ff       	jmp    8025b6 <__umoddi3+0x3e>
  802672:	66 90                	xchg   %ax,%ax
  802674:	89 c8                	mov    %ecx,%eax
  802676:	89 f2                	mov    %esi,%edx
  802678:	83 c4 1c             	add    $0x1c,%esp
  80267b:	5b                   	pop    %ebx
  80267c:	5e                   	pop    %esi
  80267d:	5f                   	pop    %edi
  80267e:	5d                   	pop    %ebp
  80267f:	c3                   	ret    
  802680:	3b 04 24             	cmp    (%esp),%eax
  802683:	72 06                	jb     80268b <__umoddi3+0x113>
  802685:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802689:	77 0f                	ja     80269a <__umoddi3+0x122>
  80268b:	89 f2                	mov    %esi,%edx
  80268d:	29 f9                	sub    %edi,%ecx
  80268f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802693:	89 14 24             	mov    %edx,(%esp)
  802696:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80269a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80269e:	8b 14 24             	mov    (%esp),%edx
  8026a1:	83 c4 1c             	add    $0x1c,%esp
  8026a4:	5b                   	pop    %ebx
  8026a5:	5e                   	pop    %esi
  8026a6:	5f                   	pop    %edi
  8026a7:	5d                   	pop    %ebp
  8026a8:	c3                   	ret    
  8026a9:	8d 76 00             	lea    0x0(%esi),%esi
  8026ac:	2b 04 24             	sub    (%esp),%eax
  8026af:	19 fa                	sbb    %edi,%edx
  8026b1:	89 d1                	mov    %edx,%ecx
  8026b3:	89 c6                	mov    %eax,%esi
  8026b5:	e9 71 ff ff ff       	jmp    80262b <__umoddi3+0xb3>
  8026ba:	66 90                	xchg   %ax,%ax
  8026bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8026c0:	72 ea                	jb     8026ac <__umoddi3+0x134>
  8026c2:	89 d9                	mov    %ebx,%ecx
  8026c4:	e9 62 ff ff ff       	jmp    80262b <__umoddi3+0xb3>
