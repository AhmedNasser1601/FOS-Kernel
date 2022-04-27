
obj/user/tst_realloc_3:     file format elf32-i386


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
  800031:	e8 29 06 00 00       	call   80065f <libmain>
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
  80003d:	83 ec 40             	sub    $0x40,%esp
	int Mega = 1024*1024;
  800040:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
	int kilo = 1024;
  800047:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	void* ptr_allocations[5] = {0};
  80004e:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  800051:	b9 05 00 00 00       	mov    $0x5,%ecx
  800056:	b8 00 00 00 00       	mov    $0x0,%eax
  80005b:	89 d7                	mov    %edx,%edi
  80005d:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 e0 20 80 00       	push   $0x8020e0
  800067:	e8 b6 09 00 00       	call   800a22 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 100 KB
		freeFrames = sys_calculate_free_frames() ;
  80006f:	e8 46 19 00 00       	call   8019ba <sys_calculate_free_frames>
  800074:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800077:	e8 c1 19 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  80007c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(100*kilo - kilo);
  80007f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800082:	89 d0                	mov    %edx,%eax
  800084:	01 c0                	add    %eax,%eax
  800086:	01 d0                	add    %edx,%eax
  800088:	89 c2                	mov    %eax,%edx
  80008a:	c1 e2 05             	shl    $0x5,%edx
  80008d:	01 d0                	add    %edx,%eax
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	50                   	push   %eax
  800093:	e8 14 17 00 00       	call   8017ac <malloc>
  800098:	83 c4 10             	add    $0x10,%esp
  80009b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[0] !=  (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80009e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8000a1:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000a6:	74 14                	je     8000bc <_main+0x84>
  8000a8:	83 ec 04             	sub    $0x4,%esp
  8000ab:	68 04 21 80 00       	push   $0x802104
  8000b0:	6a 11                	push   $0x11
  8000b2:	68 34 21 80 00       	push   $0x802134
  8000b7:	e8 b2 06 00 00       	call   80076e <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000bc:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000bf:	e8 f6 18 00 00       	call   8019ba <sys_calculate_free_frames>
  8000c4:	29 c3                	sub    %eax,%ebx
  8000c6:	89 d8                	mov    %ebx,%eax
  8000c8:	83 f8 01             	cmp    $0x1,%eax
  8000cb:	74 14                	je     8000e1 <_main+0xa9>
  8000cd:	83 ec 04             	sub    $0x4,%esp
  8000d0:	68 4c 21 80 00       	push   $0x80214c
  8000d5:	6a 13                	push   $0x13
  8000d7:	68 34 21 80 00       	push   $0x802134
  8000dc:	e8 8d 06 00 00       	call   80076e <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 25) panic("Extra or less pages are allocated in PageFile");
  8000e1:	e8 57 19 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  8000e6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000e9:	83 f8 19             	cmp    $0x19,%eax
  8000ec:	74 14                	je     800102 <_main+0xca>
  8000ee:	83 ec 04             	sub    $0x4,%esp
  8000f1:	68 b8 21 80 00       	push   $0x8021b8
  8000f6:	6a 14                	push   $0x14
  8000f8:	68 34 21 80 00       	push   $0x802134
  8000fd:	e8 6c 06 00 00       	call   80076e <_panic>

		//Allocate 20 KB
		freeFrames = sys_calculate_free_frames() ;
  800102:	e8 b3 18 00 00       	call   8019ba <sys_calculate_free_frames>
  800107:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80010a:	e8 2e 19 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  80010f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(20*kilo-kilo);
  800112:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800115:	89 d0                	mov    %edx,%eax
  800117:	c1 e0 03             	shl    $0x3,%eax
  80011a:	01 d0                	add    %edx,%eax
  80011c:	01 c0                	add    %eax,%eax
  80011e:	01 d0                	add    %edx,%eax
  800120:	83 ec 0c             	sub    $0xc,%esp
  800123:	50                   	push   %eax
  800124:	e8 83 16 00 00       	call   8017ac <malloc>
  800129:	83 c4 10             	add    $0x10,%esp
  80012c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 100 * kilo)) panic("Wrong start address for the allocated space... ");
  80012f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800132:	89 c1                	mov    %eax,%ecx
  800134:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800137:	89 d0                	mov    %edx,%eax
  800139:	c1 e0 02             	shl    $0x2,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800145:	01 d0                	add    %edx,%eax
  800147:	c1 e0 02             	shl    $0x2,%eax
  80014a:	05 00 00 00 80       	add    $0x80000000,%eax
  80014f:	39 c1                	cmp    %eax,%ecx
  800151:	74 14                	je     800167 <_main+0x12f>
  800153:	83 ec 04             	sub    $0x4,%esp
  800156:	68 04 21 80 00       	push   $0x802104
  80015b:	6a 1a                	push   $0x1a
  80015d:	68 34 21 80 00       	push   $0x802134
  800162:	e8 07 06 00 00       	call   80076e <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800167:	e8 4e 18 00 00       	call   8019ba <sys_calculate_free_frames>
  80016c:	89 c2                	mov    %eax,%edx
  80016e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800171:	39 c2                	cmp    %eax,%edx
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 4c 21 80 00       	push   $0x80214c
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 34 21 80 00       	push   $0x802134
  800184:	e8 e5 05 00 00       	call   80076e <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 5) panic("Extra or less pages are allocated in PageFile");
  800189:	e8 af 18 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  80018e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800191:	83 f8 05             	cmp    $0x5,%eax
  800194:	74 14                	je     8001aa <_main+0x172>
  800196:	83 ec 04             	sub    $0x4,%esp
  800199:	68 b8 21 80 00       	push   $0x8021b8
  80019e:	6a 1d                	push   $0x1d
  8001a0:	68 34 21 80 00       	push   $0x802134
  8001a5:	e8 c4 05 00 00       	call   80076e <_panic>

		//Allocate 30 KB
		freeFrames = sys_calculate_free_frames() ;
  8001aa:	e8 0b 18 00 00       	call   8019ba <sys_calculate_free_frames>
  8001af:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001b2:	e8 86 18 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  8001b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(30 * kilo -kilo);
  8001ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001bd:	89 d0                	mov    %edx,%eax
  8001bf:	01 c0                	add    %eax,%eax
  8001c1:	01 d0                	add    %edx,%eax
  8001c3:	01 c0                	add    %eax,%eax
  8001c5:	01 d0                	add    %edx,%eax
  8001c7:	c1 e0 02             	shl    $0x2,%eax
  8001ca:	01 d0                	add    %edx,%eax
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	50                   	push   %eax
  8001d0:	e8 d7 15 00 00       	call   8017ac <malloc>
  8001d5:	83 c4 10             	add    $0x10,%esp
  8001d8:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 120 * kilo)) panic("Wrong start address for the allocated space... ");
  8001db:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001de:	89 c1                	mov    %eax,%ecx
  8001e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001e3:	89 d0                	mov    %edx,%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	01 d0                	add    %edx,%eax
  8001e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f0:	01 d0                	add    %edx,%eax
  8001f2:	c1 e0 03             	shl    $0x3,%eax
  8001f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8001fa:	39 c1                	cmp    %eax,%ecx
  8001fc:	74 14                	je     800212 <_main+0x1da>
  8001fe:	83 ec 04             	sub    $0x4,%esp
  800201:	68 04 21 80 00       	push   $0x802104
  800206:	6a 23                	push   $0x23
  800208:	68 34 21 80 00       	push   $0x802134
  80020d:	e8 5c 05 00 00       	call   80076e <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800212:	e8 a3 17 00 00       	call   8019ba <sys_calculate_free_frames>
  800217:	89 c2                	mov    %eax,%edx
  800219:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80021c:	39 c2                	cmp    %eax,%edx
  80021e:	74 14                	je     800234 <_main+0x1fc>
  800220:	83 ec 04             	sub    $0x4,%esp
  800223:	68 4c 21 80 00       	push   $0x80214c
  800228:	6a 25                	push   $0x25
  80022a:	68 34 21 80 00       	push   $0x802134
  80022f:	e8 3a 05 00 00       	call   80076e <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8) panic("Extra or less pages are allocated in PageFile");
  800234:	e8 04 18 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  800239:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80023c:	83 f8 08             	cmp    $0x8,%eax
  80023f:	74 14                	je     800255 <_main+0x21d>
  800241:	83 ec 04             	sub    $0x4,%esp
  800244:	68 b8 21 80 00       	push   $0x8021b8
  800249:	6a 26                	push   $0x26
  80024b:	68 34 21 80 00       	push   $0x802134
  800250:	e8 19 05 00 00       	call   80076e <_panic>

		//Allocate 40 KB
		freeFrames = sys_calculate_free_frames() ;
  800255:	e8 60 17 00 00       	call   8019ba <sys_calculate_free_frames>
  80025a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80025d:	e8 db 17 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  800262:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(40 * kilo -kilo);
  800265:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800268:	89 d0                	mov    %edx,%eax
  80026a:	c1 e0 03             	shl    $0x3,%eax
  80026d:	01 d0                	add    %edx,%eax
  80026f:	01 c0                	add    %eax,%eax
  800271:	01 d0                	add    %edx,%eax
  800273:	01 c0                	add    %eax,%eax
  800275:	01 d0                	add    %edx,%eax
  800277:	83 ec 0c             	sub    $0xc,%esp
  80027a:	50                   	push   %eax
  80027b:	e8 2c 15 00 00       	call   8017ac <malloc>
  800280:	83 c4 10             	add    $0x10,%esp
  800283:	89 45 d0             	mov    %eax,-0x30(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 152 * kilo)) panic("Wrong start address for the allocated space... ");
  800286:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800289:	89 c1                	mov    %eax,%ecx
  80028b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80028e:	89 d0                	mov    %edx,%eax
  800290:	c1 e0 03             	shl    $0x3,%eax
  800293:	01 d0                	add    %edx,%eax
  800295:	01 c0                	add    %eax,%eax
  800297:	01 d0                	add    %edx,%eax
  800299:	c1 e0 03             	shl    $0x3,%eax
  80029c:	05 00 00 00 80       	add    $0x80000000,%eax
  8002a1:	39 c1                	cmp    %eax,%ecx
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 04 21 80 00       	push   $0x802104
  8002ad:	6a 2c                	push   $0x2c
  8002af:	68 34 21 80 00       	push   $0x802134
  8002b4:	e8 b5 04 00 00       	call   80076e <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002b9:	e8 fc 16 00 00       	call   8019ba <sys_calculate_free_frames>
  8002be:	89 c2                	mov    %eax,%edx
  8002c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002c3:	39 c2                	cmp    %eax,%edx
  8002c5:	74 14                	je     8002db <_main+0x2a3>
  8002c7:	83 ec 04             	sub    $0x4,%esp
  8002ca:	68 4c 21 80 00       	push   $0x80214c
  8002cf:	6a 2e                	push   $0x2e
  8002d1:	68 34 21 80 00       	push   $0x802134
  8002d6:	e8 93 04 00 00       	call   80076e <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 10) panic("Extra or less pages are allocated in PageFile");
  8002db:	e8 5d 17 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  8002e0:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8002e3:	83 f8 0a             	cmp    $0xa,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 b8 21 80 00       	push   $0x8021b8
  8002f0:	6a 2f                	push   $0x2f
  8002f2:	68 34 21 80 00       	push   $0x802134
  8002f7:	e8 72 04 00 00       	call   80076e <_panic>


	}


	int cnt = 0;
  8002fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	//[2] Test Re-allocation
	{
		/*Reallocate the first array (100 KB) to the last hole*/

		//Fill the first array with data
		int *intArr = (int*) ptr_allocations[0];
  800303:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800306:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;
  800309:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80030c:	89 d0                	mov    %edx,%eax
  80030e:	c1 e0 02             	shl    $0x2,%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031a:	01 d0                	add    %edx,%eax
  80031c:	c1 e0 02             	shl    $0x2,%eax
  80031f:	c1 e8 02             	shr    $0x2,%eax
  800322:	48                   	dec    %eax
  800323:	89 45 d8             	mov    %eax,-0x28(%ebp)

		int i = 0;
  800326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for (i=0; i < lastIndexOfInt1 ; i++)
  80032d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800334:	eb 17                	jmp    80034d <_main+0x315>
		{
			intArr[i] = i ;
  800336:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800339:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800340:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800343:	01 c2                	add    %eax,%edx
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	89 02                	mov    %eax,(%edx)
		//Fill the first array with data
		int *intArr = (int*) ptr_allocations[0];
		int lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;

		int i = 0;
		for (i=0; i < lastIndexOfInt1 ; i++)
  80034a:	ff 45 f4             	incl   -0xc(%ebp)
  80034d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800350:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800353:	7c e1                	jl     800336 <_main+0x2fe>
		{
			intArr[i] = i ;
		}

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
  800355:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800358:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;
  80035b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80035e:	89 d0                	mov    %edx,%eax
  800360:	c1 e0 02             	shl    $0x2,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	c1 e0 02             	shl    $0x2,%eax
  800368:	c1 e8 02             	shr    $0x2,%eax
  80036b:	48                   	dec    %eax
  80036c:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  80036f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800376:	eb 17                	jmp    80038f <_main+0x357>
		{
			intArr[i] = i ;
  800378:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80037b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800382:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800385:	01 c2                	add    %eax,%edx
  800387:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80038a:	89 02                	mov    %eax,(%edx)

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80038c:	ff 45 f4             	incl   -0xc(%ebp)
  80038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800392:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800395:	7c e1                	jl     800378 <_main+0x340>
		{
			intArr[i] = i ;
		}

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
  800397:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80039a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;
  80039d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003a0:	89 d0                	mov    %edx,%eax
  8003a2:	01 c0                	add    %eax,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ad:	01 d0                	add    %edx,%eax
  8003af:	01 c0                	add    %eax,%eax
  8003b1:	c1 e8 02             	shr    $0x2,%eax
  8003b4:	48                   	dec    %eax
  8003b5:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8003bf:	eb 17                	jmp    8003d8 <_main+0x3a0>
		{
			intArr[i] = i ;
  8003c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003ce:	01 c2                	add    %eax,%edx
  8003d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003d3:	89 02                	mov    %eax,(%edx)

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003d5:	ff 45 f4             	incl   -0xc(%ebp)
  8003d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003db:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8003de:	7c e1                	jl     8003c1 <_main+0x389>
		{
			intArr[i] = i ;
		}

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
  8003e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;
  8003e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003e9:	89 d0                	mov    %edx,%eax
  8003eb:	c1 e0 02             	shl    $0x2,%eax
  8003ee:	01 d0                	add    %edx,%eax
  8003f0:	c1 e0 03             	shl    $0x3,%eax
  8003f3:	c1 e8 02             	shr    $0x2,%eax
  8003f6:	48                   	dec    %eax
  8003f7:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800401:	eb 17                	jmp    80041a <_main+0x3e2>
		{
			intArr[i] = i ;
  800403:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800406:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800410:	01 c2                	add    %eax,%edx
  800412:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800415:	89 02                	mov    %eax,(%edx)

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  800417:	ff 45 f4             	incl   -0xc(%ebp)
  80041a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041d:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800420:	7c e1                	jl     800403 <_main+0x3cb>
			intArr[i] = i ;
		}


		//Reallocate the first array to 200 KB [should be moved to after the fourth one]
		freeFrames = sys_calculate_free_frames() ;
  800422:	e8 93 15 00 00       	call   8019ba <sys_calculate_free_frames>
  800427:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80042a:	e8 0e 16 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  80042f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 200 * kilo - kilo);
  800432:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800435:	89 d0                	mov    %edx,%eax
  800437:	01 c0                	add    %eax,%eax
  800439:	01 d0                	add    %edx,%eax
  80043b:	89 c1                	mov    %eax,%ecx
  80043d:	c1 e1 05             	shl    $0x5,%ecx
  800440:	01 c8                	add    %ecx,%eax
  800442:	01 c0                	add    %eax,%eax
  800444:	01 d0                	add    %edx,%eax
  800446:	89 c2                	mov    %eax,%edx
  800448:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80044b:	83 ec 08             	sub    $0x8,%esp
  80044e:	52                   	push   %edx
  80044f:	50                   	push   %eax
  800450:	e8 df 13 00 00       	call   801834 <realloc>
  800455:	83 c4 10             	add    $0x10,%esp
  800458:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START + 192 * kilo)) panic("Wrong start address for the re-allocated space... ");
  80045b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80045e:	89 c1                	mov    %eax,%ecx
  800460:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800463:	89 d0                	mov    %edx,%eax
  800465:	01 c0                	add    %eax,%eax
  800467:	01 d0                	add    %edx,%eax
  800469:	c1 e0 06             	shl    $0x6,%eax
  80046c:	05 00 00 00 80       	add    $0x80000000,%eax
  800471:	39 c1                	cmp    %eax,%ecx
  800473:	74 14                	je     800489 <_main+0x451>
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	68 e8 21 80 00       	push   $0x8021e8
  80047d:	6a 6b                	push   $0x6b
  80047f:	68 34 21 80 00       	push   $0x802134
  800484:	e8 e5 02 00 00       	call   80076e <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong re-allocation");
		//if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 25) panic("Extra or less pages are re-allocated in PageFile");
  800489:	e8 af 15 00 00       	call   801a3d <sys_pf_calculate_allocated_pages>
  80048e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800491:	83 f8 19             	cmp    $0x19,%eax
  800494:	74 14                	je     8004aa <_main+0x472>
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	68 1c 22 80 00       	push   $0x80221c
  80049e:	6a 6e                	push   $0x6e
  8004a0:	68 34 21 80 00       	push   $0x802134
  8004a5:	e8 c4 02 00 00       	call   80076e <_panic>


		vcprintf("\b\b\b50%", NULL);
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	6a 00                	push   $0x0
  8004af:	68 4d 22 80 00       	push   $0x80224d
  8004b4:	e8 fe 04 00 00       	call   8009b7 <vcprintf>
  8004b9:	83 c4 10             	add    $0x10,%esp

		//Fill the first array with data
		intArr = (int*) ptr_allocations[0];
  8004bc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8004bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;
  8004c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004c5:	89 d0                	mov    %edx,%eax
  8004c7:	c1 e0 02             	shl    $0x2,%eax
  8004ca:	01 d0                	add    %edx,%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	01 d0                	add    %edx,%eax
  8004d5:	c1 e0 02             	shl    $0x2,%eax
  8004d8:	c1 e8 02             	shr    $0x2,%eax
  8004db:	48                   	dec    %eax
  8004dc:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e6:	eb 2d                	jmp    800515 <_main+0x4dd>
		{
			if(intArr[i] != i)
  8004e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f5:	01 d0                	add    %edx,%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004fc:	74 14                	je     800512 <_main+0x4da>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  8004fe:	83 ec 04             	sub    $0x4,%esp
  800501:	68 54 22 80 00       	push   $0x802254
  800506:	6a 7a                	push   $0x7a
  800508:	68 34 21 80 00       	push   $0x802134
  80050d:	e8 5c 02 00 00       	call   80076e <_panic>

		//Fill the first array with data
		intArr = (int*) ptr_allocations[0];
		lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  800512:	ff 45 f4             	incl   -0xc(%ebp)
  800515:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800518:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80051b:	7c cb                	jl     8004e8 <_main+0x4b0>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
  80051d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800520:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;
  800523:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	c1 e0 02             	shl    $0x2,%eax
  80052b:	01 d0                	add    %edx,%eax
  80052d:	c1 e0 02             	shl    $0x2,%eax
  800530:	c1 e8 02             	shr    $0x2,%eax
  800533:	48                   	dec    %eax
  800534:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  800537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80053e:	eb 30                	jmp    800570 <_main+0x538>
		{
			if(intArr[i] != i)
  800540:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800543:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054d:	01 d0                	add    %edx,%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800554:	74 17                	je     80056d <_main+0x535>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	68 54 22 80 00       	push   $0x802254
  80055e:	68 84 00 00 00       	push   $0x84
  800563:	68 34 21 80 00       	push   $0x802134
  800568:	e8 01 02 00 00       	call   80076e <_panic>

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80056d:	ff 45 f4             	incl   -0xc(%ebp)
  800570:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800573:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800576:	7c c8                	jl     800540 <_main+0x508>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
  800578:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80057b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;
  80057e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800581:	89 d0                	mov    %edx,%eax
  800583:	01 c0                	add    %eax,%eax
  800585:	01 d0                	add    %edx,%eax
  800587:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80058e:	01 d0                	add    %edx,%eax
  800590:	01 c0                	add    %eax,%eax
  800592:	c1 e8 02             	shr    $0x2,%eax
  800595:	48                   	dec    %eax
  800596:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  800599:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005a0:	eb 30                	jmp    8005d2 <_main+0x59a>
		{
			if(intArr[i] != i)
  8005a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005b6:	74 17                	je     8005cf <_main+0x597>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  8005b8:	83 ec 04             	sub    $0x4,%esp
  8005bb:	68 54 22 80 00       	push   $0x802254
  8005c0:	68 8e 00 00 00       	push   $0x8e
  8005c5:	68 34 21 80 00       	push   $0x802134
  8005ca:	e8 9f 01 00 00       	call   80076e <_panic>

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  8005cf:	ff 45 f4             	incl   -0xc(%ebp)
  8005d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d5:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8005d8:	7c c8                	jl     8005a2 <_main+0x56a>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
  8005da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;
  8005e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e3:	89 d0                	mov    %edx,%eax
  8005e5:	c1 e0 02             	shl    $0x2,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	c1 e0 03             	shl    $0x3,%eax
  8005ed:	c1 e8 02             	shr    $0x2,%eax
  8005f0:	48                   	dec    %eax
  8005f1:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8005f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005fb:	eb 30                	jmp    80062d <_main+0x5f5>
		{
			if(intArr[i] != i)
  8005fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800600:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800607:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80060a:	01 d0                	add    %edx,%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800611:	74 17                	je     80062a <_main+0x5f2>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 54 22 80 00       	push   $0x802254
  80061b:	68 98 00 00 00       	push   $0x98
  800620:	68 34 21 80 00       	push   $0x802134
  800625:	e8 44 01 00 00       	call   80076e <_panic>

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80062a:	ff 45 f4             	incl   -0xc(%ebp)
  80062d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800630:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800633:	7c c8                	jl     8005fd <_main+0x5c5>
				panic("Wrong re-allocation: stored values are wrongly changed!");

		}


		vcprintf("\b\b\b100%\n", NULL);
  800635:	83 ec 08             	sub    $0x8,%esp
  800638:	6a 00                	push   $0x0
  80063a:	68 8c 22 80 00       	push   $0x80228c
  80063f:	e8 73 03 00 00       	call   8009b7 <vcprintf>
  800644:	83 c4 10             	add    $0x10,%esp
	}



	cprintf("Congratulations!! test realloc [3] completed successfully.\n");
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	68 98 22 80 00       	push   $0x802298
  80064f:	e8 ce 03 00 00       	call   800a22 <cprintf>
  800654:	83 c4 10             	add    $0x10,%esp

	return;
  800657:	90                   	nop
}
  800658:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80065b:	5b                   	pop    %ebx
  80065c:	5f                   	pop    %edi
  80065d:	5d                   	pop    %ebp
  80065e:	c3                   	ret    

0080065f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80065f:	55                   	push   %ebp
  800660:	89 e5                	mov    %esp,%ebp
  800662:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800665:	e8 85 12 00 00       	call   8018ef <sys_getenvindex>
  80066a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80066d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800670:	89 d0                	mov    %edx,%eax
  800672:	c1 e0 02             	shl    $0x2,%eax
  800675:	01 d0                	add    %edx,%eax
  800677:	01 c0                	add    %eax,%eax
  800679:	01 d0                	add    %edx,%eax
  80067b:	01 c0                	add    %eax,%eax
  80067d:	01 d0                	add    %edx,%eax
  80067f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800686:	01 d0                	add    %edx,%eax
  800688:	c1 e0 02             	shl    $0x2,%eax
  80068b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800690:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800695:	a1 04 30 80 00       	mov    0x803004,%eax
  80069a:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006a0:	84 c0                	test   %al,%al
  8006a2:	74 0f                	je     8006b3 <libmain+0x54>
		binaryname = myEnv->prog_name;
  8006a4:	a1 04 30 80 00       	mov    0x803004,%eax
  8006a9:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006ae:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006b7:	7e 0a                	jle    8006c3 <libmain+0x64>
		binaryname = argv[0];
  8006b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	ff 75 0c             	pushl  0xc(%ebp)
  8006c9:	ff 75 08             	pushl  0x8(%ebp)
  8006cc:	e8 67 f9 ff ff       	call   800038 <_main>
  8006d1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006d4:	e8 b1 13 00 00       	call   801a8a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006d9:	83 ec 0c             	sub    $0xc,%esp
  8006dc:	68 ec 22 80 00       	push   $0x8022ec
  8006e1:	e8 3c 03 00 00       	call   800a22 <cprintf>
  8006e6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006e9:	a1 04 30 80 00       	mov    0x803004,%eax
  8006ee:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006f4:	a1 04 30 80 00       	mov    0x803004,%eax
  8006f9:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006ff:	83 ec 04             	sub    $0x4,%esp
  800702:	52                   	push   %edx
  800703:	50                   	push   %eax
  800704:	68 14 23 80 00       	push   $0x802314
  800709:	e8 14 03 00 00       	call   800a22 <cprintf>
  80070e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800711:	a1 04 30 80 00       	mov    0x803004,%eax
  800716:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	50                   	push   %eax
  800720:	68 39 23 80 00       	push   $0x802339
  800725:	e8 f8 02 00 00       	call   800a22 <cprintf>
  80072a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80072d:	83 ec 0c             	sub    $0xc,%esp
  800730:	68 ec 22 80 00       	push   $0x8022ec
  800735:	e8 e8 02 00 00       	call   800a22 <cprintf>
  80073a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80073d:	e8 62 13 00 00       	call   801aa4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800742:	e8 19 00 00 00       	call   800760 <exit>
}
  800747:	90                   	nop
  800748:	c9                   	leave  
  800749:	c3                   	ret    

0080074a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80074a:	55                   	push   %ebp
  80074b:	89 e5                	mov    %esp,%ebp
  80074d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800750:	83 ec 0c             	sub    $0xc,%esp
  800753:	6a 00                	push   $0x0
  800755:	e8 61 11 00 00       	call   8018bb <sys_env_destroy>
  80075a:	83 c4 10             	add    $0x10,%esp
}
  80075d:	90                   	nop
  80075e:	c9                   	leave  
  80075f:	c3                   	ret    

00800760 <exit>:

void
exit(void)
{
  800760:	55                   	push   %ebp
  800761:	89 e5                	mov    %esp,%ebp
  800763:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800766:	e8 b6 11 00 00       	call   801921 <sys_env_exit>
}
  80076b:	90                   	nop
  80076c:	c9                   	leave  
  80076d:	c3                   	ret    

0080076e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80076e:	55                   	push   %ebp
  80076f:	89 e5                	mov    %esp,%ebp
  800771:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800774:	8d 45 10             	lea    0x10(%ebp),%eax
  800777:	83 c0 04             	add    $0x4,%eax
  80077a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80077d:	a1 14 30 80 00       	mov    0x803014,%eax
  800782:	85 c0                	test   %eax,%eax
  800784:	74 16                	je     80079c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800786:	a1 14 30 80 00       	mov    0x803014,%eax
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	50                   	push   %eax
  80078f:	68 50 23 80 00       	push   $0x802350
  800794:	e8 89 02 00 00       	call   800a22 <cprintf>
  800799:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80079c:	a1 00 30 80 00       	mov    0x803000,%eax
  8007a1:	ff 75 0c             	pushl  0xc(%ebp)
  8007a4:	ff 75 08             	pushl  0x8(%ebp)
  8007a7:	50                   	push   %eax
  8007a8:	68 55 23 80 00       	push   $0x802355
  8007ad:	e8 70 02 00 00       	call   800a22 <cprintf>
  8007b2:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b8:	83 ec 08             	sub    $0x8,%esp
  8007bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8007be:	50                   	push   %eax
  8007bf:	e8 f3 01 00 00       	call   8009b7 <vcprintf>
  8007c4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007c7:	83 ec 08             	sub    $0x8,%esp
  8007ca:	6a 00                	push   $0x0
  8007cc:	68 71 23 80 00       	push   $0x802371
  8007d1:	e8 e1 01 00 00       	call   8009b7 <vcprintf>
  8007d6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007d9:	e8 82 ff ff ff       	call   800760 <exit>

	// should not return here
	while (1) ;
  8007de:	eb fe                	jmp    8007de <_panic+0x70>

008007e0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007e0:	55                   	push   %ebp
  8007e1:	89 e5                	mov    %esp,%ebp
  8007e3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007e6:	a1 04 30 80 00       	mov    0x803004,%eax
  8007eb:	8b 50 74             	mov    0x74(%eax),%edx
  8007ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007f1:	39 c2                	cmp    %eax,%edx
  8007f3:	74 14                	je     800809 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007f5:	83 ec 04             	sub    $0x4,%esp
  8007f8:	68 74 23 80 00       	push   $0x802374
  8007fd:	6a 26                	push   $0x26
  8007ff:	68 c0 23 80 00       	push   $0x8023c0
  800804:	e8 65 ff ff ff       	call   80076e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800809:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800810:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800817:	e9 c2 00 00 00       	jmp    8008de <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80081c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80081f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800826:	8b 45 08             	mov    0x8(%ebp),%eax
  800829:	01 d0                	add    %edx,%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	85 c0                	test   %eax,%eax
  80082f:	75 08                	jne    800839 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800831:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800834:	e9 a2 00 00 00       	jmp    8008db <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800839:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800840:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800847:	eb 69                	jmp    8008b2 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800849:	a1 04 30 80 00       	mov    0x803004,%eax
  80084e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800854:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800857:	89 d0                	mov    %edx,%eax
  800859:	01 c0                	add    %eax,%eax
  80085b:	01 d0                	add    %edx,%eax
  80085d:	c1 e0 02             	shl    $0x2,%eax
  800860:	01 c8                	add    %ecx,%eax
  800862:	8a 40 04             	mov    0x4(%eax),%al
  800865:	84 c0                	test   %al,%al
  800867:	75 46                	jne    8008af <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800869:	a1 04 30 80 00       	mov    0x803004,%eax
  80086e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800874:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800877:	89 d0                	mov    %edx,%eax
  800879:	01 c0                	add    %eax,%eax
  80087b:	01 d0                	add    %edx,%eax
  80087d:	c1 e0 02             	shl    $0x2,%eax
  800880:	01 c8                	add    %ecx,%eax
  800882:	8b 00                	mov    (%eax),%eax
  800884:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800887:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80088a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80088f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800891:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800894:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	01 c8                	add    %ecx,%eax
  8008a0:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	75 09                	jne    8008af <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008a6:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008ad:	eb 12                	jmp    8008c1 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008af:	ff 45 e8             	incl   -0x18(%ebp)
  8008b2:	a1 04 30 80 00       	mov    0x803004,%eax
  8008b7:	8b 50 74             	mov    0x74(%eax),%edx
  8008ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008bd:	39 c2                	cmp    %eax,%edx
  8008bf:	77 88                	ja     800849 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008c5:	75 14                	jne    8008db <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008c7:	83 ec 04             	sub    $0x4,%esp
  8008ca:	68 cc 23 80 00       	push   $0x8023cc
  8008cf:	6a 3a                	push   $0x3a
  8008d1:	68 c0 23 80 00       	push   $0x8023c0
  8008d6:	e8 93 fe ff ff       	call   80076e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008db:	ff 45 f0             	incl   -0x10(%ebp)
  8008de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008e4:	0f 8c 32 ff ff ff    	jl     80081c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008ea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008f8:	eb 26                	jmp    800920 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008fa:	a1 04 30 80 00       	mov    0x803004,%eax
  8008ff:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800905:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800908:	89 d0                	mov    %edx,%eax
  80090a:	01 c0                	add    %eax,%eax
  80090c:	01 d0                	add    %edx,%eax
  80090e:	c1 e0 02             	shl    $0x2,%eax
  800911:	01 c8                	add    %ecx,%eax
  800913:	8a 40 04             	mov    0x4(%eax),%al
  800916:	3c 01                	cmp    $0x1,%al
  800918:	75 03                	jne    80091d <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80091a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80091d:	ff 45 e0             	incl   -0x20(%ebp)
  800920:	a1 04 30 80 00       	mov    0x803004,%eax
  800925:	8b 50 74             	mov    0x74(%eax),%edx
  800928:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092b:	39 c2                	cmp    %eax,%edx
  80092d:	77 cb                	ja     8008fa <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80092f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800932:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800935:	74 14                	je     80094b <CheckWSWithoutLastIndex+0x16b>
		panic(
  800937:	83 ec 04             	sub    $0x4,%esp
  80093a:	68 20 24 80 00       	push   $0x802420
  80093f:	6a 44                	push   $0x44
  800941:	68 c0 23 80 00       	push   $0x8023c0
  800946:	e8 23 fe ff ff       	call   80076e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80094b:	90                   	nop
  80094c:	c9                   	leave  
  80094d:	c3                   	ret    

0080094e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80094e:	55                   	push   %ebp
  80094f:	89 e5                	mov    %esp,%ebp
  800951:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800954:	8b 45 0c             	mov    0xc(%ebp),%eax
  800957:	8b 00                	mov    (%eax),%eax
  800959:	8d 48 01             	lea    0x1(%eax),%ecx
  80095c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095f:	89 0a                	mov    %ecx,(%edx)
  800961:	8b 55 08             	mov    0x8(%ebp),%edx
  800964:	88 d1                	mov    %dl,%cl
  800966:	8b 55 0c             	mov    0xc(%ebp),%edx
  800969:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80096d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800970:	8b 00                	mov    (%eax),%eax
  800972:	3d ff 00 00 00       	cmp    $0xff,%eax
  800977:	75 2c                	jne    8009a5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800979:	a0 08 30 80 00       	mov    0x803008,%al
  80097e:	0f b6 c0             	movzbl %al,%eax
  800981:	8b 55 0c             	mov    0xc(%ebp),%edx
  800984:	8b 12                	mov    (%edx),%edx
  800986:	89 d1                	mov    %edx,%ecx
  800988:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098b:	83 c2 08             	add    $0x8,%edx
  80098e:	83 ec 04             	sub    $0x4,%esp
  800991:	50                   	push   %eax
  800992:	51                   	push   %ecx
  800993:	52                   	push   %edx
  800994:	e8 e0 0e 00 00       	call   801879 <sys_cputs>
  800999:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80099c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a8:	8b 40 04             	mov    0x4(%eax),%eax
  8009ab:	8d 50 01             	lea    0x1(%eax),%edx
  8009ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009b4:	90                   	nop
  8009b5:	c9                   	leave  
  8009b6:	c3                   	ret    

008009b7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009b7:	55                   	push   %ebp
  8009b8:	89 e5                	mov    %esp,%ebp
  8009ba:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009c0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009c7:	00 00 00 
	b.cnt = 0;
  8009ca:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009d1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009d4:	ff 75 0c             	pushl  0xc(%ebp)
  8009d7:	ff 75 08             	pushl  0x8(%ebp)
  8009da:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e0:	50                   	push   %eax
  8009e1:	68 4e 09 80 00       	push   $0x80094e
  8009e6:	e8 11 02 00 00       	call   800bfc <vprintfmt>
  8009eb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009ee:	a0 08 30 80 00       	mov    0x803008,%al
  8009f3:	0f b6 c0             	movzbl %al,%eax
  8009f6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009fc:	83 ec 04             	sub    $0x4,%esp
  8009ff:	50                   	push   %eax
  800a00:	52                   	push   %edx
  800a01:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a07:	83 c0 08             	add    $0x8,%eax
  800a0a:	50                   	push   %eax
  800a0b:	e8 69 0e 00 00       	call   801879 <sys_cputs>
  800a10:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a13:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800a1a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a20:	c9                   	leave  
  800a21:	c3                   	ret    

00800a22 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a22:	55                   	push   %ebp
  800a23:	89 e5                	mov    %esp,%ebp
  800a25:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a28:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800a2f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a32:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	83 ec 08             	sub    $0x8,%esp
  800a3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3e:	50                   	push   %eax
  800a3f:	e8 73 ff ff ff       	call   8009b7 <vcprintf>
  800a44:	83 c4 10             	add    $0x10,%esp
  800a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a4d:	c9                   	leave  
  800a4e:	c3                   	ret    

00800a4f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a4f:	55                   	push   %ebp
  800a50:	89 e5                	mov    %esp,%ebp
  800a52:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a55:	e8 30 10 00 00       	call   801a8a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a5a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	83 ec 08             	sub    $0x8,%esp
  800a66:	ff 75 f4             	pushl  -0xc(%ebp)
  800a69:	50                   	push   %eax
  800a6a:	e8 48 ff ff ff       	call   8009b7 <vcprintf>
  800a6f:	83 c4 10             	add    $0x10,%esp
  800a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a75:	e8 2a 10 00 00       	call   801aa4 <sys_enable_interrupt>
	return cnt;
  800a7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a7d:	c9                   	leave  
  800a7e:	c3                   	ret    

00800a7f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a7f:	55                   	push   %ebp
  800a80:	89 e5                	mov    %esp,%ebp
  800a82:	53                   	push   %ebx
  800a83:	83 ec 14             	sub    $0x14,%esp
  800a86:	8b 45 10             	mov    0x10(%ebp),%eax
  800a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a92:	8b 45 18             	mov    0x18(%ebp),%eax
  800a95:	ba 00 00 00 00       	mov    $0x0,%edx
  800a9a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a9d:	77 55                	ja     800af4 <printnum+0x75>
  800a9f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa2:	72 05                	jb     800aa9 <printnum+0x2a>
  800aa4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800aa7:	77 4b                	ja     800af4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aa9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aac:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aaf:	8b 45 18             	mov    0x18(%ebp),%eax
  800ab2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ab7:	52                   	push   %edx
  800ab8:	50                   	push   %eax
  800ab9:	ff 75 f4             	pushl  -0xc(%ebp)
  800abc:	ff 75 f0             	pushl  -0x10(%ebp)
  800abf:	e8 a4 13 00 00       	call   801e68 <__udivdi3>
  800ac4:	83 c4 10             	add    $0x10,%esp
  800ac7:	83 ec 04             	sub    $0x4,%esp
  800aca:	ff 75 20             	pushl  0x20(%ebp)
  800acd:	53                   	push   %ebx
  800ace:	ff 75 18             	pushl  0x18(%ebp)
  800ad1:	52                   	push   %edx
  800ad2:	50                   	push   %eax
  800ad3:	ff 75 0c             	pushl  0xc(%ebp)
  800ad6:	ff 75 08             	pushl  0x8(%ebp)
  800ad9:	e8 a1 ff ff ff       	call   800a7f <printnum>
  800ade:	83 c4 20             	add    $0x20,%esp
  800ae1:	eb 1a                	jmp    800afd <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	ff 75 20             	pushl  0x20(%ebp)
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	ff d0                	call   *%eax
  800af1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800af4:	ff 4d 1c             	decl   0x1c(%ebp)
  800af7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800afb:	7f e6                	jg     800ae3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800afd:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b00:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b0b:	53                   	push   %ebx
  800b0c:	51                   	push   %ecx
  800b0d:	52                   	push   %edx
  800b0e:	50                   	push   %eax
  800b0f:	e8 64 14 00 00       	call   801f78 <__umoddi3>
  800b14:	83 c4 10             	add    $0x10,%esp
  800b17:	05 94 26 80 00       	add    $0x802694,%eax
  800b1c:	8a 00                	mov    (%eax),%al
  800b1e:	0f be c0             	movsbl %al,%eax
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 0c             	pushl  0xc(%ebp)
  800b27:	50                   	push   %eax
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	ff d0                	call   *%eax
  800b2d:	83 c4 10             	add    $0x10,%esp
}
  800b30:	90                   	nop
  800b31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b39:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3d:	7e 1c                	jle    800b5b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	8d 50 08             	lea    0x8(%eax),%edx
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	89 10                	mov    %edx,(%eax)
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	83 e8 08             	sub    $0x8,%eax
  800b54:	8b 50 04             	mov    0x4(%eax),%edx
  800b57:	8b 00                	mov    (%eax),%eax
  800b59:	eb 40                	jmp    800b9b <getuint+0x65>
	else if (lflag)
  800b5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5f:	74 1e                	je     800b7f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8b 00                	mov    (%eax),%eax
  800b66:	8d 50 04             	lea    0x4(%eax),%edx
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6c:	89 10                	mov    %edx,(%eax)
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	8b 00                	mov    (%eax),%eax
  800b73:	83 e8 04             	sub    $0x4,%eax
  800b76:	8b 00                	mov    (%eax),%eax
  800b78:	ba 00 00 00 00       	mov    $0x0,%edx
  800b7d:	eb 1c                	jmp    800b9b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	8d 50 04             	lea    0x4(%eax),%edx
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	89 10                	mov    %edx,(%eax)
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8b 00                	mov    (%eax),%eax
  800b91:	83 e8 04             	sub    $0x4,%eax
  800b94:	8b 00                	mov    (%eax),%eax
  800b96:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b9b:	5d                   	pop    %ebp
  800b9c:	c3                   	ret    

00800b9d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ba0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ba4:	7e 1c                	jle    800bc2 <getint+0x25>
		return va_arg(*ap, long long);
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	8d 50 08             	lea    0x8(%eax),%edx
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	89 10                	mov    %edx,(%eax)
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	8b 00                	mov    (%eax),%eax
  800bb8:	83 e8 08             	sub    $0x8,%eax
  800bbb:	8b 50 04             	mov    0x4(%eax),%edx
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	eb 38                	jmp    800bfa <getint+0x5d>
	else if (lflag)
  800bc2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc6:	74 1a                	je     800be2 <getint+0x45>
		return va_arg(*ap, long);
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	8d 50 04             	lea    0x4(%eax),%edx
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	89 10                	mov    %edx,(%eax)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	83 e8 04             	sub    $0x4,%eax
  800bdd:	8b 00                	mov    (%eax),%eax
  800bdf:	99                   	cltd   
  800be0:	eb 18                	jmp    800bfa <getint+0x5d>
	else
		return va_arg(*ap, int);
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	8b 00                	mov    (%eax),%eax
  800be7:	8d 50 04             	lea    0x4(%eax),%edx
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	89 10                	mov    %edx,(%eax)
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf2:	8b 00                	mov    (%eax),%eax
  800bf4:	83 e8 04             	sub    $0x4,%eax
  800bf7:	8b 00                	mov    (%eax),%eax
  800bf9:	99                   	cltd   
}
  800bfa:	5d                   	pop    %ebp
  800bfb:	c3                   	ret    

00800bfc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bfc:	55                   	push   %ebp
  800bfd:	89 e5                	mov    %esp,%ebp
  800bff:	56                   	push   %esi
  800c00:	53                   	push   %ebx
  800c01:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c04:	eb 17                	jmp    800c1d <vprintfmt+0x21>
			if (ch == '\0')
  800c06:	85 db                	test   %ebx,%ebx
  800c08:	0f 84 af 03 00 00    	je     800fbd <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c0e:	83 ec 08             	sub    $0x8,%esp
  800c11:	ff 75 0c             	pushl  0xc(%ebp)
  800c14:	53                   	push   %ebx
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	ff d0                	call   *%eax
  800c1a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c20:	8d 50 01             	lea    0x1(%eax),%edx
  800c23:	89 55 10             	mov    %edx,0x10(%ebp)
  800c26:	8a 00                	mov    (%eax),%al
  800c28:	0f b6 d8             	movzbl %al,%ebx
  800c2b:	83 fb 25             	cmp    $0x25,%ebx
  800c2e:	75 d6                	jne    800c06 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c30:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c34:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c3b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c42:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c49:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c50:	8b 45 10             	mov    0x10(%ebp),%eax
  800c53:	8d 50 01             	lea    0x1(%eax),%edx
  800c56:	89 55 10             	mov    %edx,0x10(%ebp)
  800c59:	8a 00                	mov    (%eax),%al
  800c5b:	0f b6 d8             	movzbl %al,%ebx
  800c5e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c61:	83 f8 55             	cmp    $0x55,%eax
  800c64:	0f 87 2b 03 00 00    	ja     800f95 <vprintfmt+0x399>
  800c6a:	8b 04 85 b8 26 80 00 	mov    0x8026b8(,%eax,4),%eax
  800c71:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c73:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c77:	eb d7                	jmp    800c50 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c79:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c7d:	eb d1                	jmp    800c50 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c7f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c86:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c89:	89 d0                	mov    %edx,%eax
  800c8b:	c1 e0 02             	shl    $0x2,%eax
  800c8e:	01 d0                	add    %edx,%eax
  800c90:	01 c0                	add    %eax,%eax
  800c92:	01 d8                	add    %ebx,%eax
  800c94:	83 e8 30             	sub    $0x30,%eax
  800c97:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ca2:	83 fb 2f             	cmp    $0x2f,%ebx
  800ca5:	7e 3e                	jle    800ce5 <vprintfmt+0xe9>
  800ca7:	83 fb 39             	cmp    $0x39,%ebx
  800caa:	7f 39                	jg     800ce5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cac:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800caf:	eb d5                	jmp    800c86 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb4:	83 c0 04             	add    $0x4,%eax
  800cb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cc5:	eb 1f                	jmp    800ce6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cc7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccb:	79 83                	jns    800c50 <vprintfmt+0x54>
				width = 0;
  800ccd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cd4:	e9 77 ff ff ff       	jmp    800c50 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cd9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ce0:	e9 6b ff ff ff       	jmp    800c50 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ce5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ce6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cea:	0f 89 60 ff ff ff    	jns    800c50 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cf6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cfd:	e9 4e ff ff ff       	jmp    800c50 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d02:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d05:	e9 46 ff ff ff       	jmp    800c50 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0d:	83 c0 04             	add    $0x4,%eax
  800d10:	89 45 14             	mov    %eax,0x14(%ebp)
  800d13:	8b 45 14             	mov    0x14(%ebp),%eax
  800d16:	83 e8 04             	sub    $0x4,%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	83 ec 08             	sub    $0x8,%esp
  800d1e:	ff 75 0c             	pushl  0xc(%ebp)
  800d21:	50                   	push   %eax
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	ff d0                	call   *%eax
  800d27:	83 c4 10             	add    $0x10,%esp
			break;
  800d2a:	e9 89 02 00 00       	jmp    800fb8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 14             	mov    %eax,0x14(%ebp)
  800d38:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3b:	83 e8 04             	sub    $0x4,%eax
  800d3e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d40:	85 db                	test   %ebx,%ebx
  800d42:	79 02                	jns    800d46 <vprintfmt+0x14a>
				err = -err;
  800d44:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d46:	83 fb 64             	cmp    $0x64,%ebx
  800d49:	7f 0b                	jg     800d56 <vprintfmt+0x15a>
  800d4b:	8b 34 9d 00 25 80 00 	mov    0x802500(,%ebx,4),%esi
  800d52:	85 f6                	test   %esi,%esi
  800d54:	75 19                	jne    800d6f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d56:	53                   	push   %ebx
  800d57:	68 a5 26 80 00       	push   $0x8026a5
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	ff 75 08             	pushl  0x8(%ebp)
  800d62:	e8 5e 02 00 00       	call   800fc5 <printfmt>
  800d67:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d6a:	e9 49 02 00 00       	jmp    800fb8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d6f:	56                   	push   %esi
  800d70:	68 ae 26 80 00       	push   $0x8026ae
  800d75:	ff 75 0c             	pushl  0xc(%ebp)
  800d78:	ff 75 08             	pushl  0x8(%ebp)
  800d7b:	e8 45 02 00 00       	call   800fc5 <printfmt>
  800d80:	83 c4 10             	add    $0x10,%esp
			break;
  800d83:	e9 30 02 00 00       	jmp    800fb8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d88:	8b 45 14             	mov    0x14(%ebp),%eax
  800d8b:	83 c0 04             	add    $0x4,%eax
  800d8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d91:	8b 45 14             	mov    0x14(%ebp),%eax
  800d94:	83 e8 04             	sub    $0x4,%eax
  800d97:	8b 30                	mov    (%eax),%esi
  800d99:	85 f6                	test   %esi,%esi
  800d9b:	75 05                	jne    800da2 <vprintfmt+0x1a6>
				p = "(null)";
  800d9d:	be b1 26 80 00       	mov    $0x8026b1,%esi
			if (width > 0 && padc != '-')
  800da2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da6:	7e 6d                	jle    800e15 <vprintfmt+0x219>
  800da8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dac:	74 67                	je     800e15 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800db1:	83 ec 08             	sub    $0x8,%esp
  800db4:	50                   	push   %eax
  800db5:	56                   	push   %esi
  800db6:	e8 0c 03 00 00       	call   8010c7 <strnlen>
  800dbb:	83 c4 10             	add    $0x10,%esp
  800dbe:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dc1:	eb 16                	jmp    800dd9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dc3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	50                   	push   %eax
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	ff d0                	call   *%eax
  800dd3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dd6:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ddd:	7f e4                	jg     800dc3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ddf:	eb 34                	jmp    800e15 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800de1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800de5:	74 1c                	je     800e03 <vprintfmt+0x207>
  800de7:	83 fb 1f             	cmp    $0x1f,%ebx
  800dea:	7e 05                	jle    800df1 <vprintfmt+0x1f5>
  800dec:	83 fb 7e             	cmp    $0x7e,%ebx
  800def:	7e 12                	jle    800e03 <vprintfmt+0x207>
					putch('?', putdat);
  800df1:	83 ec 08             	sub    $0x8,%esp
  800df4:	ff 75 0c             	pushl  0xc(%ebp)
  800df7:	6a 3f                	push   $0x3f
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	ff d0                	call   *%eax
  800dfe:	83 c4 10             	add    $0x10,%esp
  800e01:	eb 0f                	jmp    800e12 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e03:	83 ec 08             	sub    $0x8,%esp
  800e06:	ff 75 0c             	pushl  0xc(%ebp)
  800e09:	53                   	push   %ebx
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	ff d0                	call   *%eax
  800e0f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e12:	ff 4d e4             	decl   -0x1c(%ebp)
  800e15:	89 f0                	mov    %esi,%eax
  800e17:	8d 70 01             	lea    0x1(%eax),%esi
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	0f be d8             	movsbl %al,%ebx
  800e1f:	85 db                	test   %ebx,%ebx
  800e21:	74 24                	je     800e47 <vprintfmt+0x24b>
  800e23:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e27:	78 b8                	js     800de1 <vprintfmt+0x1e5>
  800e29:	ff 4d e0             	decl   -0x20(%ebp)
  800e2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e30:	79 af                	jns    800de1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e32:	eb 13                	jmp    800e47 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e34:	83 ec 08             	sub    $0x8,%esp
  800e37:	ff 75 0c             	pushl  0xc(%ebp)
  800e3a:	6a 20                	push   $0x20
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	ff d0                	call   *%eax
  800e41:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e44:	ff 4d e4             	decl   -0x1c(%ebp)
  800e47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4b:	7f e7                	jg     800e34 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e4d:	e9 66 01 00 00       	jmp    800fb8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e52:	83 ec 08             	sub    $0x8,%esp
  800e55:	ff 75 e8             	pushl  -0x18(%ebp)
  800e58:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5b:	50                   	push   %eax
  800e5c:	e8 3c fd ff ff       	call   800b9d <getint>
  800e61:	83 c4 10             	add    $0x10,%esp
  800e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e70:	85 d2                	test   %edx,%edx
  800e72:	79 23                	jns    800e97 <vprintfmt+0x29b>
				putch('-', putdat);
  800e74:	83 ec 08             	sub    $0x8,%esp
  800e77:	ff 75 0c             	pushl  0xc(%ebp)
  800e7a:	6a 2d                	push   $0x2d
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	ff d0                	call   *%eax
  800e81:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8a:	f7 d8                	neg    %eax
  800e8c:	83 d2 00             	adc    $0x0,%edx
  800e8f:	f7 da                	neg    %edx
  800e91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e94:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e97:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e9e:	e9 bc 00 00 00       	jmp    800f5f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ea3:	83 ec 08             	sub    $0x8,%esp
  800ea6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea9:	8d 45 14             	lea    0x14(%ebp),%eax
  800eac:	50                   	push   %eax
  800ead:	e8 84 fc ff ff       	call   800b36 <getuint>
  800eb2:	83 c4 10             	add    $0x10,%esp
  800eb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ebb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ec2:	e9 98 00 00 00       	jmp    800f5f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ec7:	83 ec 08             	sub    $0x8,%esp
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	6a 58                	push   $0x58
  800ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed2:	ff d0                	call   *%eax
  800ed4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 0c             	pushl  0xc(%ebp)
  800edd:	6a 58                	push   $0x58
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	ff d0                	call   *%eax
  800ee4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ee7:	83 ec 08             	sub    $0x8,%esp
  800eea:	ff 75 0c             	pushl  0xc(%ebp)
  800eed:	6a 58                	push   $0x58
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	ff d0                	call   *%eax
  800ef4:	83 c4 10             	add    $0x10,%esp
			break;
  800ef7:	e9 bc 00 00 00       	jmp    800fb8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800efc:	83 ec 08             	sub    $0x8,%esp
  800eff:	ff 75 0c             	pushl  0xc(%ebp)
  800f02:	6a 30                	push   $0x30
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	ff d0                	call   *%eax
  800f09:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f0c:	83 ec 08             	sub    $0x8,%esp
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	6a 78                	push   $0x78
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	ff d0                	call   *%eax
  800f19:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1f:	83 c0 04             	add    $0x4,%eax
  800f22:	89 45 14             	mov    %eax,0x14(%ebp)
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	83 e8 04             	sub    $0x4,%eax
  800f2b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f37:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f3e:	eb 1f                	jmp    800f5f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f40:	83 ec 08             	sub    $0x8,%esp
  800f43:	ff 75 e8             	pushl  -0x18(%ebp)
  800f46:	8d 45 14             	lea    0x14(%ebp),%eax
  800f49:	50                   	push   %eax
  800f4a:	e8 e7 fb ff ff       	call   800b36 <getuint>
  800f4f:	83 c4 10             	add    $0x10,%esp
  800f52:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f55:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f58:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f5f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f63:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f66:	83 ec 04             	sub    $0x4,%esp
  800f69:	52                   	push   %edx
  800f6a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f6d:	50                   	push   %eax
  800f6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f71:	ff 75 f0             	pushl  -0x10(%ebp)
  800f74:	ff 75 0c             	pushl  0xc(%ebp)
  800f77:	ff 75 08             	pushl  0x8(%ebp)
  800f7a:	e8 00 fb ff ff       	call   800a7f <printnum>
  800f7f:	83 c4 20             	add    $0x20,%esp
			break;
  800f82:	eb 34                	jmp    800fb8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f84:	83 ec 08             	sub    $0x8,%esp
  800f87:	ff 75 0c             	pushl  0xc(%ebp)
  800f8a:	53                   	push   %ebx
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	ff d0                	call   *%eax
  800f90:	83 c4 10             	add    $0x10,%esp
			break;
  800f93:	eb 23                	jmp    800fb8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f95:	83 ec 08             	sub    $0x8,%esp
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	6a 25                	push   $0x25
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	ff d0                	call   *%eax
  800fa2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fa5:	ff 4d 10             	decl   0x10(%ebp)
  800fa8:	eb 03                	jmp    800fad <vprintfmt+0x3b1>
  800faa:	ff 4d 10             	decl   0x10(%ebp)
  800fad:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb0:	48                   	dec    %eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	3c 25                	cmp    $0x25,%al
  800fb5:	75 f3                	jne    800faa <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fb7:	90                   	nop
		}
	}
  800fb8:	e9 47 fc ff ff       	jmp    800c04 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fbd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fbe:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fc1:	5b                   	pop    %ebx
  800fc2:	5e                   	pop    %esi
  800fc3:	5d                   	pop    %ebp
  800fc4:	c3                   	ret    

00800fc5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fcb:	8d 45 10             	lea    0x10(%ebp),%eax
  800fce:	83 c0 04             	add    $0x4,%eax
  800fd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd7:	ff 75 f4             	pushl  -0xc(%ebp)
  800fda:	50                   	push   %eax
  800fdb:	ff 75 0c             	pushl  0xc(%ebp)
  800fde:	ff 75 08             	pushl  0x8(%ebp)
  800fe1:	e8 16 fc ff ff       	call   800bfc <vprintfmt>
  800fe6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fe9:	90                   	nop
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff2:	8b 40 08             	mov    0x8(%eax),%eax
  800ff5:	8d 50 01             	lea    0x1(%eax),%edx
  800ff8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801001:	8b 10                	mov    (%eax),%edx
  801003:	8b 45 0c             	mov    0xc(%ebp),%eax
  801006:	8b 40 04             	mov    0x4(%eax),%eax
  801009:	39 c2                	cmp    %eax,%edx
  80100b:	73 12                	jae    80101f <sprintputch+0x33>
		*b->buf++ = ch;
  80100d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801010:	8b 00                	mov    (%eax),%eax
  801012:	8d 48 01             	lea    0x1(%eax),%ecx
  801015:	8b 55 0c             	mov    0xc(%ebp),%edx
  801018:	89 0a                	mov    %ecx,(%edx)
  80101a:	8b 55 08             	mov    0x8(%ebp),%edx
  80101d:	88 10                	mov    %dl,(%eax)
}
  80101f:	90                   	nop
  801020:	5d                   	pop    %ebp
  801021:	c3                   	ret    

00801022 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
  801025:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80102e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801031:	8d 50 ff             	lea    -0x1(%eax),%edx
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	01 d0                	add    %edx,%eax
  801039:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801043:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801047:	74 06                	je     80104f <vsnprintf+0x2d>
  801049:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80104d:	7f 07                	jg     801056 <vsnprintf+0x34>
		return -E_INVAL;
  80104f:	b8 03 00 00 00       	mov    $0x3,%eax
  801054:	eb 20                	jmp    801076 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801056:	ff 75 14             	pushl  0x14(%ebp)
  801059:	ff 75 10             	pushl  0x10(%ebp)
  80105c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80105f:	50                   	push   %eax
  801060:	68 ec 0f 80 00       	push   $0x800fec
  801065:	e8 92 fb ff ff       	call   800bfc <vprintfmt>
  80106a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80106d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801070:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801073:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
  80107b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80107e:	8d 45 10             	lea    0x10(%ebp),%eax
  801081:	83 c0 04             	add    $0x4,%eax
  801084:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801087:	8b 45 10             	mov    0x10(%ebp),%eax
  80108a:	ff 75 f4             	pushl  -0xc(%ebp)
  80108d:	50                   	push   %eax
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	ff 75 08             	pushl  0x8(%ebp)
  801094:	e8 89 ff ff ff       	call   801022 <vsnprintf>
  801099:	83 c4 10             	add    $0x10,%esp
  80109c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80109f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8010aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b1:	eb 06                	jmp    8010b9 <strlen+0x15>
		n++;
  8010b3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8010b6:	ff 45 08             	incl   0x8(%ebp)
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	8a 00                	mov    (%eax),%al
  8010be:	84 c0                	test   %al,%al
  8010c0:	75 f1                	jne    8010b3 <strlen+0xf>
		n++;
	return n;
  8010c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010c5:	c9                   	leave  
  8010c6:	c3                   	ret    

008010c7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8010c7:	55                   	push   %ebp
  8010c8:	89 e5                	mov    %esp,%ebp
  8010ca:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010d4:	eb 09                	jmp    8010df <strnlen+0x18>
		n++;
  8010d6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010d9:	ff 45 08             	incl   0x8(%ebp)
  8010dc:	ff 4d 0c             	decl   0xc(%ebp)
  8010df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010e3:	74 09                	je     8010ee <strnlen+0x27>
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	84 c0                	test   %al,%al
  8010ec:	75 e8                	jne    8010d6 <strnlen+0xf>
		n++;
	return n;
  8010ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
  8010f6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010ff:	90                   	nop
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	8d 50 01             	lea    0x1(%eax),%edx
  801106:	89 55 08             	mov    %edx,0x8(%ebp)
  801109:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80110f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801112:	8a 12                	mov    (%edx),%dl
  801114:	88 10                	mov    %dl,(%eax)
  801116:	8a 00                	mov    (%eax),%al
  801118:	84 c0                	test   %al,%al
  80111a:	75 e4                	jne    801100 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80111c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80111f:	c9                   	leave  
  801120:	c3                   	ret    

00801121 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
  801124:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80112d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801134:	eb 1f                	jmp    801155 <strncpy+0x34>
		*dst++ = *src;
  801136:	8b 45 08             	mov    0x8(%ebp),%eax
  801139:	8d 50 01             	lea    0x1(%eax),%edx
  80113c:	89 55 08             	mov    %edx,0x8(%ebp)
  80113f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801142:	8a 12                	mov    (%edx),%dl
  801144:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801146:	8b 45 0c             	mov    0xc(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	84 c0                	test   %al,%al
  80114d:	74 03                	je     801152 <strncpy+0x31>
			src++;
  80114f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801152:	ff 45 fc             	incl   -0x4(%ebp)
  801155:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801158:	3b 45 10             	cmp    0x10(%ebp),%eax
  80115b:	72 d9                	jb     801136 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80115d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801160:	c9                   	leave  
  801161:	c3                   	ret    

00801162 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801162:	55                   	push   %ebp
  801163:	89 e5                	mov    %esp,%ebp
  801165:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80116e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801172:	74 30                	je     8011a4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801174:	eb 16                	jmp    80118c <strlcpy+0x2a>
			*dst++ = *src++;
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	8d 50 01             	lea    0x1(%eax),%edx
  80117c:	89 55 08             	mov    %edx,0x8(%ebp)
  80117f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801182:	8d 4a 01             	lea    0x1(%edx),%ecx
  801185:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801188:	8a 12                	mov    (%edx),%dl
  80118a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80118c:	ff 4d 10             	decl   0x10(%ebp)
  80118f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801193:	74 09                	je     80119e <strlcpy+0x3c>
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	84 c0                	test   %al,%al
  80119c:	75 d8                	jne    801176 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8011a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011aa:	29 c2                	sub    %eax,%edx
  8011ac:	89 d0                	mov    %edx,%eax
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8011b3:	eb 06                	jmp    8011bb <strcmp+0xb>
		p++, q++;
  8011b5:	ff 45 08             	incl   0x8(%ebp)
  8011b8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	84 c0                	test   %al,%al
  8011c2:	74 0e                	je     8011d2 <strcmp+0x22>
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 10                	mov    (%eax),%dl
  8011c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	38 c2                	cmp    %al,%dl
  8011d0:	74 e3                	je     8011b5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	8a 00                	mov    (%eax),%al
  8011d7:	0f b6 d0             	movzbl %al,%edx
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	0f b6 c0             	movzbl %al,%eax
  8011e2:	29 c2                	sub    %eax,%edx
  8011e4:	89 d0                	mov    %edx,%eax
}
  8011e6:	5d                   	pop    %ebp
  8011e7:	c3                   	ret    

008011e8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8011e8:	55                   	push   %ebp
  8011e9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8011eb:	eb 09                	jmp    8011f6 <strncmp+0xe>
		n--, p++, q++;
  8011ed:	ff 4d 10             	decl   0x10(%ebp)
  8011f0:	ff 45 08             	incl   0x8(%ebp)
  8011f3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011fa:	74 17                	je     801213 <strncmp+0x2b>
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	74 0e                	je     801213 <strncmp+0x2b>
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	8a 10                	mov    (%eax),%dl
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	8a 00                	mov    (%eax),%al
  80120f:	38 c2                	cmp    %al,%dl
  801211:	74 da                	je     8011ed <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801213:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801217:	75 07                	jne    801220 <strncmp+0x38>
		return 0;
  801219:	b8 00 00 00 00       	mov    $0x0,%eax
  80121e:	eb 14                	jmp    801234 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	0f b6 d0             	movzbl %al,%edx
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	0f b6 c0             	movzbl %al,%eax
  801230:	29 c2                	sub    %eax,%edx
  801232:	89 d0                	mov    %edx,%eax
}
  801234:	5d                   	pop    %ebp
  801235:	c3                   	ret    

00801236 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801236:	55                   	push   %ebp
  801237:	89 e5                	mov    %esp,%ebp
  801239:	83 ec 04             	sub    $0x4,%esp
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801242:	eb 12                	jmp    801256 <strchr+0x20>
		if (*s == c)
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	8a 00                	mov    (%eax),%al
  801249:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80124c:	75 05                	jne    801253 <strchr+0x1d>
			return (char *) s;
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	eb 11                	jmp    801264 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801253:	ff 45 08             	incl   0x8(%ebp)
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	84 c0                	test   %al,%al
  80125d:	75 e5                	jne    801244 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80125f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801264:	c9                   	leave  
  801265:	c3                   	ret    

00801266 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801266:	55                   	push   %ebp
  801267:	89 e5                	mov    %esp,%ebp
  801269:	83 ec 04             	sub    $0x4,%esp
  80126c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801272:	eb 0d                	jmp    801281 <strfind+0x1b>
		if (*s == c)
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80127c:	74 0e                	je     80128c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80127e:	ff 45 08             	incl   0x8(%ebp)
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	84 c0                	test   %al,%al
  801288:	75 ea                	jne    801274 <strfind+0xe>
  80128a:	eb 01                	jmp    80128d <strfind+0x27>
		if (*s == c)
			break;
  80128c:	90                   	nop
	return (char *) s;
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801290:	c9                   	leave  
  801291:	c3                   	ret    

00801292 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
  801295:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80129e:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8012a4:	eb 0e                	jmp    8012b4 <memset+0x22>
		*p++ = c;
  8012a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ac:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8012b4:	ff 4d f8             	decl   -0x8(%ebp)
  8012b7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8012bb:	79 e9                	jns    8012a6 <memset+0x14>
		*p++ = c;

	return v;
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
  8012c5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8012d4:	eb 16                	jmp    8012ec <memcpy+0x2a>
		*d++ = *s++;
  8012d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d9:	8d 50 01             	lea    0x1(%eax),%edx
  8012dc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012e5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012e8:	8a 12                	mov    (%edx),%dl
  8012ea:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8012ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ef:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012f2:	89 55 10             	mov    %edx,0x10(%ebp)
  8012f5:	85 c0                	test   %eax,%eax
  8012f7:	75 dd                	jne    8012d6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
  801301:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801310:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801313:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801316:	73 50                	jae    801368 <memmove+0x6a>
  801318:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80131b:	8b 45 10             	mov    0x10(%ebp),%eax
  80131e:	01 d0                	add    %edx,%eax
  801320:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801323:	76 43                	jbe    801368 <memmove+0x6a>
		s += n;
  801325:	8b 45 10             	mov    0x10(%ebp),%eax
  801328:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80132b:	8b 45 10             	mov    0x10(%ebp),%eax
  80132e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801331:	eb 10                	jmp    801343 <memmove+0x45>
			*--d = *--s;
  801333:	ff 4d f8             	decl   -0x8(%ebp)
  801336:	ff 4d fc             	decl   -0x4(%ebp)
  801339:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133c:	8a 10                	mov    (%eax),%dl
  80133e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801341:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801343:	8b 45 10             	mov    0x10(%ebp),%eax
  801346:	8d 50 ff             	lea    -0x1(%eax),%edx
  801349:	89 55 10             	mov    %edx,0x10(%ebp)
  80134c:	85 c0                	test   %eax,%eax
  80134e:	75 e3                	jne    801333 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801350:	eb 23                	jmp    801375 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801352:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801355:	8d 50 01             	lea    0x1(%eax),%edx
  801358:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80135b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80135e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801361:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801364:	8a 12                	mov    (%edx),%dl
  801366:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801368:	8b 45 10             	mov    0x10(%ebp),%eax
  80136b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80136e:	89 55 10             	mov    %edx,0x10(%ebp)
  801371:	85 c0                	test   %eax,%eax
  801373:	75 dd                	jne    801352 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801378:	c9                   	leave  
  801379:	c3                   	ret    

0080137a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80137a:	55                   	push   %ebp
  80137b:	89 e5                	mov    %esp,%ebp
  80137d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80138c:	eb 2a                	jmp    8013b8 <memcmp+0x3e>
		if (*s1 != *s2)
  80138e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801391:	8a 10                	mov    (%eax),%dl
  801393:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801396:	8a 00                	mov    (%eax),%al
  801398:	38 c2                	cmp    %al,%dl
  80139a:	74 16                	je     8013b2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80139c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	0f b6 d0             	movzbl %al,%edx
  8013a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f b6 c0             	movzbl %al,%eax
  8013ac:	29 c2                	sub    %eax,%edx
  8013ae:	89 d0                	mov    %edx,%eax
  8013b0:	eb 18                	jmp    8013ca <memcmp+0x50>
		s1++, s2++;
  8013b2:	ff 45 fc             	incl   -0x4(%ebp)
  8013b5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8013b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013bb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013be:	89 55 10             	mov    %edx,0x10(%ebp)
  8013c1:	85 c0                	test   %eax,%eax
  8013c3:	75 c9                	jne    80138e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8013c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013ca:	c9                   	leave  
  8013cb:	c3                   	ret    

008013cc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8013cc:	55                   	push   %ebp
  8013cd:	89 e5                	mov    %esp,%ebp
  8013cf:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8013d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8013d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d8:	01 d0                	add    %edx,%eax
  8013da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8013dd:	eb 15                	jmp    8013f4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	0f b6 d0             	movzbl %al,%edx
  8013e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ea:	0f b6 c0             	movzbl %al,%eax
  8013ed:	39 c2                	cmp    %eax,%edx
  8013ef:	74 0d                	je     8013fe <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013f1:	ff 45 08             	incl   0x8(%ebp)
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013fa:	72 e3                	jb     8013df <memfind+0x13>
  8013fc:	eb 01                	jmp    8013ff <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013fe:	90                   	nop
	return (void *) s;
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80140a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801411:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801418:	eb 03                	jmp    80141d <strtol+0x19>
		s++;
  80141a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	3c 20                	cmp    $0x20,%al
  801424:	74 f4                	je     80141a <strtol+0x16>
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	8a 00                	mov    (%eax),%al
  80142b:	3c 09                	cmp    $0x9,%al
  80142d:	74 eb                	je     80141a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	3c 2b                	cmp    $0x2b,%al
  801436:	75 05                	jne    80143d <strtol+0x39>
		s++;
  801438:	ff 45 08             	incl   0x8(%ebp)
  80143b:	eb 13                	jmp    801450 <strtol+0x4c>
	else if (*s == '-')
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 2d                	cmp    $0x2d,%al
  801444:	75 0a                	jne    801450 <strtol+0x4c>
		s++, neg = 1;
  801446:	ff 45 08             	incl   0x8(%ebp)
  801449:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801450:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801454:	74 06                	je     80145c <strtol+0x58>
  801456:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80145a:	75 20                	jne    80147c <strtol+0x78>
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	8a 00                	mov    (%eax),%al
  801461:	3c 30                	cmp    $0x30,%al
  801463:	75 17                	jne    80147c <strtol+0x78>
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	40                   	inc    %eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	3c 78                	cmp    $0x78,%al
  80146d:	75 0d                	jne    80147c <strtol+0x78>
		s += 2, base = 16;
  80146f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801473:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80147a:	eb 28                	jmp    8014a4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80147c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801480:	75 15                	jne    801497 <strtol+0x93>
  801482:	8b 45 08             	mov    0x8(%ebp),%eax
  801485:	8a 00                	mov    (%eax),%al
  801487:	3c 30                	cmp    $0x30,%al
  801489:	75 0c                	jne    801497 <strtol+0x93>
		s++, base = 8;
  80148b:	ff 45 08             	incl   0x8(%ebp)
  80148e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801495:	eb 0d                	jmp    8014a4 <strtol+0xa0>
	else if (base == 0)
  801497:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80149b:	75 07                	jne    8014a4 <strtol+0xa0>
		base = 10;
  80149d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	3c 2f                	cmp    $0x2f,%al
  8014ab:	7e 19                	jle    8014c6 <strtol+0xc2>
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	3c 39                	cmp    $0x39,%al
  8014b4:	7f 10                	jg     8014c6 <strtol+0xc2>
			dig = *s - '0';
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	0f be c0             	movsbl %al,%eax
  8014be:	83 e8 30             	sub    $0x30,%eax
  8014c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014c4:	eb 42                	jmp    801508 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	8a 00                	mov    (%eax),%al
  8014cb:	3c 60                	cmp    $0x60,%al
  8014cd:	7e 19                	jle    8014e8 <strtol+0xe4>
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	8a 00                	mov    (%eax),%al
  8014d4:	3c 7a                	cmp    $0x7a,%al
  8014d6:	7f 10                	jg     8014e8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	8a 00                	mov    (%eax),%al
  8014dd:	0f be c0             	movsbl %al,%eax
  8014e0:	83 e8 57             	sub    $0x57,%eax
  8014e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014e6:	eb 20                	jmp    801508 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	8a 00                	mov    (%eax),%al
  8014ed:	3c 40                	cmp    $0x40,%al
  8014ef:	7e 39                	jle    80152a <strtol+0x126>
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f4:	8a 00                	mov    (%eax),%al
  8014f6:	3c 5a                	cmp    $0x5a,%al
  8014f8:	7f 30                	jg     80152a <strtol+0x126>
			dig = *s - 'A' + 10;
  8014fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fd:	8a 00                	mov    (%eax),%al
  8014ff:	0f be c0             	movsbl %al,%eax
  801502:	83 e8 37             	sub    $0x37,%eax
  801505:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801508:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80150b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80150e:	7d 19                	jge    801529 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801510:	ff 45 08             	incl   0x8(%ebp)
  801513:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801516:	0f af 45 10          	imul   0x10(%ebp),%eax
  80151a:	89 c2                	mov    %eax,%edx
  80151c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80151f:	01 d0                	add    %edx,%eax
  801521:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801524:	e9 7b ff ff ff       	jmp    8014a4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801529:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80152a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80152e:	74 08                	je     801538 <strtol+0x134>
		*endptr = (char *) s;
  801530:	8b 45 0c             	mov    0xc(%ebp),%eax
  801533:	8b 55 08             	mov    0x8(%ebp),%edx
  801536:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801538:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80153c:	74 07                	je     801545 <strtol+0x141>
  80153e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801541:	f7 d8                	neg    %eax
  801543:	eb 03                	jmp    801548 <strtol+0x144>
  801545:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <ltostr>:

void
ltostr(long value, char *str)
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
  80154d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801550:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801557:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80155e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801562:	79 13                	jns    801577 <ltostr+0x2d>
	{
		neg = 1;
  801564:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80156b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801571:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801574:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80157f:	99                   	cltd   
  801580:	f7 f9                	idiv   %ecx
  801582:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801585:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801588:	8d 50 01             	lea    0x1(%eax),%edx
  80158b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80158e:	89 c2                	mov    %eax,%edx
  801590:	8b 45 0c             	mov    0xc(%ebp),%eax
  801593:	01 d0                	add    %edx,%eax
  801595:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801598:	83 c2 30             	add    $0x30,%edx
  80159b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80159d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015a0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015a5:	f7 e9                	imul   %ecx
  8015a7:	c1 fa 02             	sar    $0x2,%edx
  8015aa:	89 c8                	mov    %ecx,%eax
  8015ac:	c1 f8 1f             	sar    $0x1f,%eax
  8015af:	29 c2                	sub    %eax,%edx
  8015b1:	89 d0                	mov    %edx,%eax
  8015b3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8015b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015b9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015be:	f7 e9                	imul   %ecx
  8015c0:	c1 fa 02             	sar    $0x2,%edx
  8015c3:	89 c8                	mov    %ecx,%eax
  8015c5:	c1 f8 1f             	sar    $0x1f,%eax
  8015c8:	29 c2                	sub    %eax,%edx
  8015ca:	89 d0                	mov    %edx,%eax
  8015cc:	c1 e0 02             	shl    $0x2,%eax
  8015cf:	01 d0                	add    %edx,%eax
  8015d1:	01 c0                	add    %eax,%eax
  8015d3:	29 c1                	sub    %eax,%ecx
  8015d5:	89 ca                	mov    %ecx,%edx
  8015d7:	85 d2                	test   %edx,%edx
  8015d9:	75 9c                	jne    801577 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8015db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8015e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e5:	48                   	dec    %eax
  8015e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8015e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015ed:	74 3d                	je     80162c <ltostr+0xe2>
		start = 1 ;
  8015ef:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015f6:	eb 34                	jmp    80162c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fe:	01 d0                	add    %edx,%eax
  801600:	8a 00                	mov    (%eax),%al
  801602:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801605:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801608:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160b:	01 c2                	add    %eax,%edx
  80160d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801610:	8b 45 0c             	mov    0xc(%ebp),%eax
  801613:	01 c8                	add    %ecx,%eax
  801615:	8a 00                	mov    (%eax),%al
  801617:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801619:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80161c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161f:	01 c2                	add    %eax,%edx
  801621:	8a 45 eb             	mov    -0x15(%ebp),%al
  801624:	88 02                	mov    %al,(%edx)
		start++ ;
  801626:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801629:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80162f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801632:	7c c4                	jl     8015f8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801634:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801637:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163a:	01 d0                	add    %edx,%eax
  80163c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80163f:	90                   	nop
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801648:	ff 75 08             	pushl  0x8(%ebp)
  80164b:	e8 54 fa ff ff       	call   8010a4 <strlen>
  801650:	83 c4 04             	add    $0x4,%esp
  801653:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801656:	ff 75 0c             	pushl  0xc(%ebp)
  801659:	e8 46 fa ff ff       	call   8010a4 <strlen>
  80165e:	83 c4 04             	add    $0x4,%esp
  801661:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801664:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80166b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801672:	eb 17                	jmp    80168b <strcconcat+0x49>
		final[s] = str1[s] ;
  801674:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801677:	8b 45 10             	mov    0x10(%ebp),%eax
  80167a:	01 c2                	add    %eax,%edx
  80167c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	01 c8                	add    %ecx,%eax
  801684:	8a 00                	mov    (%eax),%al
  801686:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801688:	ff 45 fc             	incl   -0x4(%ebp)
  80168b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80168e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801691:	7c e1                	jl     801674 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801693:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80169a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8016a1:	eb 1f                	jmp    8016c2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8016a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a6:	8d 50 01             	lea    0x1(%eax),%edx
  8016a9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016ac:	89 c2                	mov    %eax,%edx
  8016ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b1:	01 c2                	add    %eax,%edx
  8016b3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b9:	01 c8                	add    %ecx,%eax
  8016bb:	8a 00                	mov    (%eax),%al
  8016bd:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8016bf:	ff 45 f8             	incl   -0x8(%ebp)
  8016c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016c8:	7c d9                	jl     8016a3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8016ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d0:	01 d0                	add    %edx,%eax
  8016d2:	c6 00 00             	movb   $0x0,(%eax)
}
  8016d5:	90                   	nop
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8016db:	8b 45 14             	mov    0x14(%ebp),%eax
  8016de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8016e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f3:	01 d0                	add    %edx,%eax
  8016f5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016fb:	eb 0c                	jmp    801709 <strsplit+0x31>
			*string++ = 0;
  8016fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801700:	8d 50 01             	lea    0x1(%eax),%edx
  801703:	89 55 08             	mov    %edx,0x8(%ebp)
  801706:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	8a 00                	mov    (%eax),%al
  80170e:	84 c0                	test   %al,%al
  801710:	74 18                	je     80172a <strsplit+0x52>
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	8a 00                	mov    (%eax),%al
  801717:	0f be c0             	movsbl %al,%eax
  80171a:	50                   	push   %eax
  80171b:	ff 75 0c             	pushl  0xc(%ebp)
  80171e:	e8 13 fb ff ff       	call   801236 <strchr>
  801723:	83 c4 08             	add    $0x8,%esp
  801726:	85 c0                	test   %eax,%eax
  801728:	75 d3                	jne    8016fd <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	84 c0                	test   %al,%al
  801731:	74 5a                	je     80178d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801733:	8b 45 14             	mov    0x14(%ebp),%eax
  801736:	8b 00                	mov    (%eax),%eax
  801738:	83 f8 0f             	cmp    $0xf,%eax
  80173b:	75 07                	jne    801744 <strsplit+0x6c>
		{
			return 0;
  80173d:	b8 00 00 00 00       	mov    $0x0,%eax
  801742:	eb 66                	jmp    8017aa <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801744:	8b 45 14             	mov    0x14(%ebp),%eax
  801747:	8b 00                	mov    (%eax),%eax
  801749:	8d 48 01             	lea    0x1(%eax),%ecx
  80174c:	8b 55 14             	mov    0x14(%ebp),%edx
  80174f:	89 0a                	mov    %ecx,(%edx)
  801751:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801758:	8b 45 10             	mov    0x10(%ebp),%eax
  80175b:	01 c2                	add    %eax,%edx
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801762:	eb 03                	jmp    801767 <strsplit+0x8f>
			string++;
  801764:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	8a 00                	mov    (%eax),%al
  80176c:	84 c0                	test   %al,%al
  80176e:	74 8b                	je     8016fb <strsplit+0x23>
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	8a 00                	mov    (%eax),%al
  801775:	0f be c0             	movsbl %al,%eax
  801778:	50                   	push   %eax
  801779:	ff 75 0c             	pushl  0xc(%ebp)
  80177c:	e8 b5 fa ff ff       	call   801236 <strchr>
  801781:	83 c4 08             	add    $0x8,%esp
  801784:	85 c0                	test   %eax,%eax
  801786:	74 dc                	je     801764 <strsplit+0x8c>
			string++;
	}
  801788:	e9 6e ff ff ff       	jmp    8016fb <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80178d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80178e:	8b 45 14             	mov    0x14(%ebp),%eax
  801791:	8b 00                	mov    (%eax),%eax
  801793:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80179a:	8b 45 10             	mov    0x10(%ebp),%eax
  80179d:	01 d0                	add    %edx,%eax
  80179f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8017a5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
  8017af:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8017b2:	83 ec 04             	sub    $0x4,%esp
  8017b5:	68 10 28 80 00       	push   $0x802810
  8017ba:	6a 19                	push   $0x19
  8017bc:	68 35 28 80 00       	push   $0x802835
  8017c1:	e8 a8 ef ff ff       	call   80076e <_panic>

008017c6 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
  8017c9:	83 ec 18             	sub    $0x18,%esp
  8017cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cf:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  8017d2:	83 ec 04             	sub    $0x4,%esp
  8017d5:	68 44 28 80 00       	push   $0x802844
  8017da:	6a 30                	push   $0x30
  8017dc:	68 35 28 80 00       	push   $0x802835
  8017e1:	e8 88 ef ff ff       	call   80076e <_panic>

008017e6 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
  8017e9:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  8017ec:	83 ec 04             	sub    $0x4,%esp
  8017ef:	68 63 28 80 00       	push   $0x802863
  8017f4:	6a 36                	push   $0x36
  8017f6:	68 35 28 80 00       	push   $0x802835
  8017fb:	e8 6e ef ff ff       	call   80076e <_panic>

00801800 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801800:	55                   	push   %ebp
  801801:	89 e5                	mov    %esp,%ebp
  801803:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801806:	83 ec 04             	sub    $0x4,%esp
  801809:	68 80 28 80 00       	push   $0x802880
  80180e:	6a 48                	push   $0x48
  801810:	68 35 28 80 00       	push   $0x802835
  801815:	e8 54 ef ff ff       	call   80076e <_panic>

0080181a <sfree>:

}


void sfree(void* virtual_address)
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
  80181d:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801820:	83 ec 04             	sub    $0x4,%esp
  801823:	68 a3 28 80 00       	push   $0x8028a3
  801828:	6a 53                	push   $0x53
  80182a:	68 35 28 80 00       	push   $0x802835
  80182f:	e8 3a ef ff ff       	call   80076e <_panic>

00801834 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
  801837:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80183a:	83 ec 04             	sub    $0x4,%esp
  80183d:	68 c0 28 80 00       	push   $0x8028c0
  801842:	6a 6c                	push   $0x6c
  801844:	68 35 28 80 00       	push   $0x802835
  801849:	e8 20 ef ff ff       	call   80076e <_panic>

0080184e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80184e:	55                   	push   %ebp
  80184f:	89 e5                	mov    %esp,%ebp
  801851:	57                   	push   %edi
  801852:	56                   	push   %esi
  801853:	53                   	push   %ebx
  801854:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801860:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801863:	8b 7d 18             	mov    0x18(%ebp),%edi
  801866:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801869:	cd 30                	int    $0x30
  80186b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80186e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801871:	83 c4 10             	add    $0x10,%esp
  801874:	5b                   	pop    %ebx
  801875:	5e                   	pop    %esi
  801876:	5f                   	pop    %edi
  801877:	5d                   	pop    %ebp
  801878:	c3                   	ret    

00801879 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
  80187c:	83 ec 04             	sub    $0x4,%esp
  80187f:	8b 45 10             	mov    0x10(%ebp),%eax
  801882:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801885:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	52                   	push   %edx
  801891:	ff 75 0c             	pushl  0xc(%ebp)
  801894:	50                   	push   %eax
  801895:	6a 00                	push   $0x0
  801897:	e8 b2 ff ff ff       	call   80184e <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	90                   	nop
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 01                	push   $0x1
  8018b1:	e8 98 ff ff ff       	call   80184e <syscall>
  8018b6:	83 c4 18             	add    $0x18,%esp
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018be:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	50                   	push   %eax
  8018ca:	6a 05                	push   $0x5
  8018cc:	e8 7d ff ff ff       	call   80184e <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 02                	push   $0x2
  8018e5:	e8 64 ff ff ff       	call   80184e <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 03                	push   $0x3
  8018fe:	e8 4b ff ff ff       	call   80184e <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 00                	push   $0x0
  801915:	6a 04                	push   $0x4
  801917:	e8 32 ff ff ff       	call   80184e <syscall>
  80191c:	83 c4 18             	add    $0x18,%esp
}
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_env_exit>:


void sys_env_exit(void)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 06                	push   $0x6
  801930:	e8 19 ff ff ff       	call   80184e <syscall>
  801935:	83 c4 18             	add    $0x18,%esp
}
  801938:	90                   	nop
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80193e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801941:	8b 45 08             	mov    0x8(%ebp),%eax
  801944:	6a 00                	push   $0x0
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	52                   	push   %edx
  80194b:	50                   	push   %eax
  80194c:	6a 07                	push   $0x7
  80194e:	e8 fb fe ff ff       	call   80184e <syscall>
  801953:	83 c4 18             	add    $0x18,%esp
}
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
  80195b:	56                   	push   %esi
  80195c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80195d:	8b 75 18             	mov    0x18(%ebp),%esi
  801960:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801963:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801966:	8b 55 0c             	mov    0xc(%ebp),%edx
  801969:	8b 45 08             	mov    0x8(%ebp),%eax
  80196c:	56                   	push   %esi
  80196d:	53                   	push   %ebx
  80196e:	51                   	push   %ecx
  80196f:	52                   	push   %edx
  801970:	50                   	push   %eax
  801971:	6a 08                	push   $0x8
  801973:	e8 d6 fe ff ff       	call   80184e <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80197e:	5b                   	pop    %ebx
  80197f:	5e                   	pop    %esi
  801980:	5d                   	pop    %ebp
  801981:	c3                   	ret    

00801982 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801985:	8b 55 0c             	mov    0xc(%ebp),%edx
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	52                   	push   %edx
  801992:	50                   	push   %eax
  801993:	6a 09                	push   $0x9
  801995:	e8 b4 fe ff ff       	call   80184e <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
}
  80199d:	c9                   	leave  
  80199e:	c3                   	ret    

0080199f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	ff 75 0c             	pushl  0xc(%ebp)
  8019ab:	ff 75 08             	pushl  0x8(%ebp)
  8019ae:	6a 0a                	push   $0xa
  8019b0:	e8 99 fe ff ff       	call   80184e <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 0b                	push   $0xb
  8019c9:	e8 80 fe ff ff       	call   80184e <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
}
  8019d1:	c9                   	leave  
  8019d2:	c3                   	ret    

008019d3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019d3:	55                   	push   %ebp
  8019d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 0c                	push   $0xc
  8019e2:	e8 67 fe ff ff       	call   80184e <syscall>
  8019e7:	83 c4 18             	add    $0x18,%esp
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 0d                	push   $0xd
  8019fb:	e8 4e fe ff ff       	call   80184e <syscall>
  801a00:	83 c4 18             	add    $0x18,%esp
}
  801a03:	c9                   	leave  
  801a04:	c3                   	ret    

00801a05 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a05:	55                   	push   %ebp
  801a06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	ff 75 0c             	pushl  0xc(%ebp)
  801a11:	ff 75 08             	pushl  0x8(%ebp)
  801a14:	6a 11                	push   $0x11
  801a16:	e8 33 fe ff ff       	call   80184e <syscall>
  801a1b:	83 c4 18             	add    $0x18,%esp
	return;
  801a1e:	90                   	nop
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	ff 75 0c             	pushl  0xc(%ebp)
  801a2d:	ff 75 08             	pushl  0x8(%ebp)
  801a30:	6a 12                	push   $0x12
  801a32:	e8 17 fe ff ff       	call   80184e <syscall>
  801a37:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3a:	90                   	nop
}
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 0e                	push   $0xe
  801a4c:	e8 fd fd ff ff       	call   80184e <syscall>
  801a51:	83 c4 18             	add    $0x18,%esp
}
  801a54:	c9                   	leave  
  801a55:	c3                   	ret    

00801a56 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a56:	55                   	push   %ebp
  801a57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	ff 75 08             	pushl  0x8(%ebp)
  801a64:	6a 0f                	push   $0xf
  801a66:	e8 e3 fd ff ff       	call   80184e <syscall>
  801a6b:	83 c4 18             	add    $0x18,%esp
}
  801a6e:	c9                   	leave  
  801a6f:	c3                   	ret    

00801a70 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 10                	push   $0x10
  801a7f:	e8 ca fd ff ff       	call   80184e <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	90                   	nop
  801a88:	c9                   	leave  
  801a89:	c3                   	ret    

00801a8a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a8a:	55                   	push   %ebp
  801a8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 14                	push   $0x14
  801a99:	e8 b0 fd ff ff       	call   80184e <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	90                   	nop
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 15                	push   $0x15
  801ab3:	e8 96 fd ff ff       	call   80184e <syscall>
  801ab8:	83 c4 18             	add    $0x18,%esp
}
  801abb:	90                   	nop
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <sys_cputc>:


void
sys_cputc(const char c)
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
  801ac1:	83 ec 04             	sub    $0x4,%esp
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801aca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	50                   	push   %eax
  801ad7:	6a 16                	push   $0x16
  801ad9:	e8 70 fd ff ff       	call   80184e <syscall>
  801ade:	83 c4 18             	add    $0x18,%esp
}
  801ae1:	90                   	nop
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 17                	push   $0x17
  801af3:	e8 56 fd ff ff       	call   80184e <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	90                   	nop
  801afc:	c9                   	leave  
  801afd:	c3                   	ret    

00801afe <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	ff 75 0c             	pushl  0xc(%ebp)
  801b0d:	50                   	push   %eax
  801b0e:	6a 18                	push   $0x18
  801b10:	e8 39 fd ff ff       	call   80184e <syscall>
  801b15:	83 c4 18             	add    $0x18,%esp
}
  801b18:	c9                   	leave  
  801b19:	c3                   	ret    

00801b1a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b20:	8b 45 08             	mov    0x8(%ebp),%eax
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	52                   	push   %edx
  801b2a:	50                   	push   %eax
  801b2b:	6a 1b                	push   $0x1b
  801b2d:	e8 1c fd ff ff       	call   80184e <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
}
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	52                   	push   %edx
  801b47:	50                   	push   %eax
  801b48:	6a 19                	push   $0x19
  801b4a:	e8 ff fc ff ff       	call   80184e <syscall>
  801b4f:	83 c4 18             	add    $0x18,%esp
}
  801b52:	90                   	nop
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	52                   	push   %edx
  801b65:	50                   	push   %eax
  801b66:	6a 1a                	push   $0x1a
  801b68:	e8 e1 fc ff ff       	call   80184e <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
}
  801b70:	90                   	nop
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
  801b76:	83 ec 04             	sub    $0x4,%esp
  801b79:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b7f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b82:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b86:	8b 45 08             	mov    0x8(%ebp),%eax
  801b89:	6a 00                	push   $0x0
  801b8b:	51                   	push   %ecx
  801b8c:	52                   	push   %edx
  801b8d:	ff 75 0c             	pushl  0xc(%ebp)
  801b90:	50                   	push   %eax
  801b91:	6a 1c                	push   $0x1c
  801b93:	e8 b6 fc ff ff       	call   80184e <syscall>
  801b98:	83 c4 18             	add    $0x18,%esp
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ba0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	52                   	push   %edx
  801bad:	50                   	push   %eax
  801bae:	6a 1d                	push   $0x1d
  801bb0:	e8 99 fc ff ff       	call   80184e <syscall>
  801bb5:	83 c4 18             	add    $0x18,%esp
}
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bbd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	51                   	push   %ecx
  801bcb:	52                   	push   %edx
  801bcc:	50                   	push   %eax
  801bcd:	6a 1e                	push   $0x1e
  801bcf:	e8 7a fc ff ff       	call   80184e <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	52                   	push   %edx
  801be9:	50                   	push   %eax
  801bea:	6a 1f                	push   $0x1f
  801bec:	e8 5d fc ff ff       	call   80184e <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 20                	push   $0x20
  801c05:	e8 44 fc ff ff       	call   80184e <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801c12:	8b 45 08             	mov    0x8(%ebp),%eax
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	ff 75 10             	pushl  0x10(%ebp)
  801c1c:	ff 75 0c             	pushl  0xc(%ebp)
  801c1f:	50                   	push   %eax
  801c20:	6a 21                	push   $0x21
  801c22:	e8 27 fc ff ff       	call   80184e <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
}
  801c2a:	c9                   	leave  
  801c2b:	c3                   	ret    

00801c2c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c2c:	55                   	push   %ebp
  801c2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	50                   	push   %eax
  801c3b:	6a 22                	push   $0x22
  801c3d:	e8 0c fc ff ff       	call   80184e <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
}
  801c45:	90                   	nop
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	50                   	push   %eax
  801c57:	6a 23                	push   $0x23
  801c59:	e8 f0 fb ff ff       	call   80184e <syscall>
  801c5e:	83 c4 18             	add    $0x18,%esp
}
  801c61:	90                   	nop
  801c62:	c9                   	leave  
  801c63:	c3                   	ret    

00801c64 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
  801c67:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c6a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c6d:	8d 50 04             	lea    0x4(%eax),%edx
  801c70:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	52                   	push   %edx
  801c7a:	50                   	push   %eax
  801c7b:	6a 24                	push   $0x24
  801c7d:	e8 cc fb ff ff       	call   80184e <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
	return result;
  801c85:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c8b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c8e:	89 01                	mov    %eax,(%ecx)
  801c90:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c93:	8b 45 08             	mov    0x8(%ebp),%eax
  801c96:	c9                   	leave  
  801c97:	c2 04 00             	ret    $0x4

00801c9a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	ff 75 10             	pushl  0x10(%ebp)
  801ca4:	ff 75 0c             	pushl  0xc(%ebp)
  801ca7:	ff 75 08             	pushl  0x8(%ebp)
  801caa:	6a 13                	push   $0x13
  801cac:	e8 9d fb ff ff       	call   80184e <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb4:	90                   	nop
}
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <sys_rcr2>:
uint32 sys_rcr2()
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 25                	push   $0x25
  801cc6:	e8 83 fb ff ff       	call   80184e <syscall>
  801ccb:	83 c4 18             	add    $0x18,%esp
}
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
  801cd3:	83 ec 04             	sub    $0x4,%esp
  801cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cdc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	50                   	push   %eax
  801ce9:	6a 26                	push   $0x26
  801ceb:	e8 5e fb ff ff       	call   80184e <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf3:	90                   	nop
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <rsttst>:
void rsttst()
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 28                	push   $0x28
  801d05:	e8 44 fb ff ff       	call   80184e <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0d:	90                   	nop
}
  801d0e:	c9                   	leave  
  801d0f:	c3                   	ret    

00801d10 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
  801d13:	83 ec 04             	sub    $0x4,%esp
  801d16:	8b 45 14             	mov    0x14(%ebp),%eax
  801d19:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d1c:	8b 55 18             	mov    0x18(%ebp),%edx
  801d1f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d23:	52                   	push   %edx
  801d24:	50                   	push   %eax
  801d25:	ff 75 10             	pushl  0x10(%ebp)
  801d28:	ff 75 0c             	pushl  0xc(%ebp)
  801d2b:	ff 75 08             	pushl  0x8(%ebp)
  801d2e:	6a 27                	push   $0x27
  801d30:	e8 19 fb ff ff       	call   80184e <syscall>
  801d35:	83 c4 18             	add    $0x18,%esp
	return ;
  801d38:	90                   	nop
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <chktst>:
void chktst(uint32 n)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	ff 75 08             	pushl  0x8(%ebp)
  801d49:	6a 29                	push   $0x29
  801d4b:	e8 fe fa ff ff       	call   80184e <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
	return ;
  801d53:	90                   	nop
}
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <inctst>:

void inctst()
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 2a                	push   $0x2a
  801d65:	e8 e4 fa ff ff       	call   80184e <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6d:	90                   	nop
}
  801d6e:	c9                   	leave  
  801d6f:	c3                   	ret    

00801d70 <gettst>:
uint32 gettst()
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 2b                	push   $0x2b
  801d7f:	e8 ca fa ff ff       	call   80184e <syscall>
  801d84:	83 c4 18             	add    $0x18,%esp
}
  801d87:	c9                   	leave  
  801d88:	c3                   	ret    

00801d89 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d89:	55                   	push   %ebp
  801d8a:	89 e5                	mov    %esp,%ebp
  801d8c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 2c                	push   $0x2c
  801d9b:	e8 ae fa ff ff       	call   80184e <syscall>
  801da0:	83 c4 18             	add    $0x18,%esp
  801da3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801da6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801daa:	75 07                	jne    801db3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801dac:	b8 01 00 00 00       	mov    $0x1,%eax
  801db1:	eb 05                	jmp    801db8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801db3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db8:	c9                   	leave  
  801db9:	c3                   	ret    

00801dba <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801dba:	55                   	push   %ebp
  801dbb:	89 e5                	mov    %esp,%ebp
  801dbd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 2c                	push   $0x2c
  801dcc:	e8 7d fa ff ff       	call   80184e <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
  801dd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801dd7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ddb:	75 07                	jne    801de4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ddd:	b8 01 00 00 00       	mov    $0x1,%eax
  801de2:	eb 05                	jmp    801de9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801de4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
  801dee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 2c                	push   $0x2c
  801dfd:	e8 4c fa ff ff       	call   80184e <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
  801e05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e08:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e0c:	75 07                	jne    801e15 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e13:	eb 05                	jmp    801e1a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e15:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
  801e1f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 2c                	push   $0x2c
  801e2e:	e8 1b fa ff ff       	call   80184e <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
  801e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e39:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e3d:	75 07                	jne    801e46 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e3f:	b8 01 00 00 00       	mov    $0x1,%eax
  801e44:	eb 05                	jmp    801e4b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e46:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	ff 75 08             	pushl  0x8(%ebp)
  801e5b:	6a 2d                	push   $0x2d
  801e5d:	e8 ec f9 ff ff       	call   80184e <syscall>
  801e62:	83 c4 18             	add    $0x18,%esp
	return ;
  801e65:	90                   	nop
}
  801e66:	c9                   	leave  
  801e67:	c3                   	ret    

00801e68 <__udivdi3>:
  801e68:	55                   	push   %ebp
  801e69:	57                   	push   %edi
  801e6a:	56                   	push   %esi
  801e6b:	53                   	push   %ebx
  801e6c:	83 ec 1c             	sub    $0x1c,%esp
  801e6f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e73:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e77:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e7b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e7f:	89 ca                	mov    %ecx,%edx
  801e81:	89 f8                	mov    %edi,%eax
  801e83:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e87:	85 f6                	test   %esi,%esi
  801e89:	75 2d                	jne    801eb8 <__udivdi3+0x50>
  801e8b:	39 cf                	cmp    %ecx,%edi
  801e8d:	77 65                	ja     801ef4 <__udivdi3+0x8c>
  801e8f:	89 fd                	mov    %edi,%ebp
  801e91:	85 ff                	test   %edi,%edi
  801e93:	75 0b                	jne    801ea0 <__udivdi3+0x38>
  801e95:	b8 01 00 00 00       	mov    $0x1,%eax
  801e9a:	31 d2                	xor    %edx,%edx
  801e9c:	f7 f7                	div    %edi
  801e9e:	89 c5                	mov    %eax,%ebp
  801ea0:	31 d2                	xor    %edx,%edx
  801ea2:	89 c8                	mov    %ecx,%eax
  801ea4:	f7 f5                	div    %ebp
  801ea6:	89 c1                	mov    %eax,%ecx
  801ea8:	89 d8                	mov    %ebx,%eax
  801eaa:	f7 f5                	div    %ebp
  801eac:	89 cf                	mov    %ecx,%edi
  801eae:	89 fa                	mov    %edi,%edx
  801eb0:	83 c4 1c             	add    $0x1c,%esp
  801eb3:	5b                   	pop    %ebx
  801eb4:	5e                   	pop    %esi
  801eb5:	5f                   	pop    %edi
  801eb6:	5d                   	pop    %ebp
  801eb7:	c3                   	ret    
  801eb8:	39 ce                	cmp    %ecx,%esi
  801eba:	77 28                	ja     801ee4 <__udivdi3+0x7c>
  801ebc:	0f bd fe             	bsr    %esi,%edi
  801ebf:	83 f7 1f             	xor    $0x1f,%edi
  801ec2:	75 40                	jne    801f04 <__udivdi3+0x9c>
  801ec4:	39 ce                	cmp    %ecx,%esi
  801ec6:	72 0a                	jb     801ed2 <__udivdi3+0x6a>
  801ec8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ecc:	0f 87 9e 00 00 00    	ja     801f70 <__udivdi3+0x108>
  801ed2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ed7:	89 fa                	mov    %edi,%edx
  801ed9:	83 c4 1c             	add    $0x1c,%esp
  801edc:	5b                   	pop    %ebx
  801edd:	5e                   	pop    %esi
  801ede:	5f                   	pop    %edi
  801edf:	5d                   	pop    %ebp
  801ee0:	c3                   	ret    
  801ee1:	8d 76 00             	lea    0x0(%esi),%esi
  801ee4:	31 ff                	xor    %edi,%edi
  801ee6:	31 c0                	xor    %eax,%eax
  801ee8:	89 fa                	mov    %edi,%edx
  801eea:	83 c4 1c             	add    $0x1c,%esp
  801eed:	5b                   	pop    %ebx
  801eee:	5e                   	pop    %esi
  801eef:	5f                   	pop    %edi
  801ef0:	5d                   	pop    %ebp
  801ef1:	c3                   	ret    
  801ef2:	66 90                	xchg   %ax,%ax
  801ef4:	89 d8                	mov    %ebx,%eax
  801ef6:	f7 f7                	div    %edi
  801ef8:	31 ff                	xor    %edi,%edi
  801efa:	89 fa                	mov    %edi,%edx
  801efc:	83 c4 1c             	add    $0x1c,%esp
  801eff:	5b                   	pop    %ebx
  801f00:	5e                   	pop    %esi
  801f01:	5f                   	pop    %edi
  801f02:	5d                   	pop    %ebp
  801f03:	c3                   	ret    
  801f04:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f09:	89 eb                	mov    %ebp,%ebx
  801f0b:	29 fb                	sub    %edi,%ebx
  801f0d:	89 f9                	mov    %edi,%ecx
  801f0f:	d3 e6                	shl    %cl,%esi
  801f11:	89 c5                	mov    %eax,%ebp
  801f13:	88 d9                	mov    %bl,%cl
  801f15:	d3 ed                	shr    %cl,%ebp
  801f17:	89 e9                	mov    %ebp,%ecx
  801f19:	09 f1                	or     %esi,%ecx
  801f1b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f1f:	89 f9                	mov    %edi,%ecx
  801f21:	d3 e0                	shl    %cl,%eax
  801f23:	89 c5                	mov    %eax,%ebp
  801f25:	89 d6                	mov    %edx,%esi
  801f27:	88 d9                	mov    %bl,%cl
  801f29:	d3 ee                	shr    %cl,%esi
  801f2b:	89 f9                	mov    %edi,%ecx
  801f2d:	d3 e2                	shl    %cl,%edx
  801f2f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f33:	88 d9                	mov    %bl,%cl
  801f35:	d3 e8                	shr    %cl,%eax
  801f37:	09 c2                	or     %eax,%edx
  801f39:	89 d0                	mov    %edx,%eax
  801f3b:	89 f2                	mov    %esi,%edx
  801f3d:	f7 74 24 0c          	divl   0xc(%esp)
  801f41:	89 d6                	mov    %edx,%esi
  801f43:	89 c3                	mov    %eax,%ebx
  801f45:	f7 e5                	mul    %ebp
  801f47:	39 d6                	cmp    %edx,%esi
  801f49:	72 19                	jb     801f64 <__udivdi3+0xfc>
  801f4b:	74 0b                	je     801f58 <__udivdi3+0xf0>
  801f4d:	89 d8                	mov    %ebx,%eax
  801f4f:	31 ff                	xor    %edi,%edi
  801f51:	e9 58 ff ff ff       	jmp    801eae <__udivdi3+0x46>
  801f56:	66 90                	xchg   %ax,%ax
  801f58:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f5c:	89 f9                	mov    %edi,%ecx
  801f5e:	d3 e2                	shl    %cl,%edx
  801f60:	39 c2                	cmp    %eax,%edx
  801f62:	73 e9                	jae    801f4d <__udivdi3+0xe5>
  801f64:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f67:	31 ff                	xor    %edi,%edi
  801f69:	e9 40 ff ff ff       	jmp    801eae <__udivdi3+0x46>
  801f6e:	66 90                	xchg   %ax,%ax
  801f70:	31 c0                	xor    %eax,%eax
  801f72:	e9 37 ff ff ff       	jmp    801eae <__udivdi3+0x46>
  801f77:	90                   	nop

00801f78 <__umoddi3>:
  801f78:	55                   	push   %ebp
  801f79:	57                   	push   %edi
  801f7a:	56                   	push   %esi
  801f7b:	53                   	push   %ebx
  801f7c:	83 ec 1c             	sub    $0x1c,%esp
  801f7f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f83:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f87:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f8b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f8f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f93:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f97:	89 f3                	mov    %esi,%ebx
  801f99:	89 fa                	mov    %edi,%edx
  801f9b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f9f:	89 34 24             	mov    %esi,(%esp)
  801fa2:	85 c0                	test   %eax,%eax
  801fa4:	75 1a                	jne    801fc0 <__umoddi3+0x48>
  801fa6:	39 f7                	cmp    %esi,%edi
  801fa8:	0f 86 a2 00 00 00    	jbe    802050 <__umoddi3+0xd8>
  801fae:	89 c8                	mov    %ecx,%eax
  801fb0:	89 f2                	mov    %esi,%edx
  801fb2:	f7 f7                	div    %edi
  801fb4:	89 d0                	mov    %edx,%eax
  801fb6:	31 d2                	xor    %edx,%edx
  801fb8:	83 c4 1c             	add    $0x1c,%esp
  801fbb:	5b                   	pop    %ebx
  801fbc:	5e                   	pop    %esi
  801fbd:	5f                   	pop    %edi
  801fbe:	5d                   	pop    %ebp
  801fbf:	c3                   	ret    
  801fc0:	39 f0                	cmp    %esi,%eax
  801fc2:	0f 87 ac 00 00 00    	ja     802074 <__umoddi3+0xfc>
  801fc8:	0f bd e8             	bsr    %eax,%ebp
  801fcb:	83 f5 1f             	xor    $0x1f,%ebp
  801fce:	0f 84 ac 00 00 00    	je     802080 <__umoddi3+0x108>
  801fd4:	bf 20 00 00 00       	mov    $0x20,%edi
  801fd9:	29 ef                	sub    %ebp,%edi
  801fdb:	89 fe                	mov    %edi,%esi
  801fdd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fe1:	89 e9                	mov    %ebp,%ecx
  801fe3:	d3 e0                	shl    %cl,%eax
  801fe5:	89 d7                	mov    %edx,%edi
  801fe7:	89 f1                	mov    %esi,%ecx
  801fe9:	d3 ef                	shr    %cl,%edi
  801feb:	09 c7                	or     %eax,%edi
  801fed:	89 e9                	mov    %ebp,%ecx
  801fef:	d3 e2                	shl    %cl,%edx
  801ff1:	89 14 24             	mov    %edx,(%esp)
  801ff4:	89 d8                	mov    %ebx,%eax
  801ff6:	d3 e0                	shl    %cl,%eax
  801ff8:	89 c2                	mov    %eax,%edx
  801ffa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ffe:	d3 e0                	shl    %cl,%eax
  802000:	89 44 24 04          	mov    %eax,0x4(%esp)
  802004:	8b 44 24 08          	mov    0x8(%esp),%eax
  802008:	89 f1                	mov    %esi,%ecx
  80200a:	d3 e8                	shr    %cl,%eax
  80200c:	09 d0                	or     %edx,%eax
  80200e:	d3 eb                	shr    %cl,%ebx
  802010:	89 da                	mov    %ebx,%edx
  802012:	f7 f7                	div    %edi
  802014:	89 d3                	mov    %edx,%ebx
  802016:	f7 24 24             	mull   (%esp)
  802019:	89 c6                	mov    %eax,%esi
  80201b:	89 d1                	mov    %edx,%ecx
  80201d:	39 d3                	cmp    %edx,%ebx
  80201f:	0f 82 87 00 00 00    	jb     8020ac <__umoddi3+0x134>
  802025:	0f 84 91 00 00 00    	je     8020bc <__umoddi3+0x144>
  80202b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80202f:	29 f2                	sub    %esi,%edx
  802031:	19 cb                	sbb    %ecx,%ebx
  802033:	89 d8                	mov    %ebx,%eax
  802035:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802039:	d3 e0                	shl    %cl,%eax
  80203b:	89 e9                	mov    %ebp,%ecx
  80203d:	d3 ea                	shr    %cl,%edx
  80203f:	09 d0                	or     %edx,%eax
  802041:	89 e9                	mov    %ebp,%ecx
  802043:	d3 eb                	shr    %cl,%ebx
  802045:	89 da                	mov    %ebx,%edx
  802047:	83 c4 1c             	add    $0x1c,%esp
  80204a:	5b                   	pop    %ebx
  80204b:	5e                   	pop    %esi
  80204c:	5f                   	pop    %edi
  80204d:	5d                   	pop    %ebp
  80204e:	c3                   	ret    
  80204f:	90                   	nop
  802050:	89 fd                	mov    %edi,%ebp
  802052:	85 ff                	test   %edi,%edi
  802054:	75 0b                	jne    802061 <__umoddi3+0xe9>
  802056:	b8 01 00 00 00       	mov    $0x1,%eax
  80205b:	31 d2                	xor    %edx,%edx
  80205d:	f7 f7                	div    %edi
  80205f:	89 c5                	mov    %eax,%ebp
  802061:	89 f0                	mov    %esi,%eax
  802063:	31 d2                	xor    %edx,%edx
  802065:	f7 f5                	div    %ebp
  802067:	89 c8                	mov    %ecx,%eax
  802069:	f7 f5                	div    %ebp
  80206b:	89 d0                	mov    %edx,%eax
  80206d:	e9 44 ff ff ff       	jmp    801fb6 <__umoddi3+0x3e>
  802072:	66 90                	xchg   %ax,%ax
  802074:	89 c8                	mov    %ecx,%eax
  802076:	89 f2                	mov    %esi,%edx
  802078:	83 c4 1c             	add    $0x1c,%esp
  80207b:	5b                   	pop    %ebx
  80207c:	5e                   	pop    %esi
  80207d:	5f                   	pop    %edi
  80207e:	5d                   	pop    %ebp
  80207f:	c3                   	ret    
  802080:	3b 04 24             	cmp    (%esp),%eax
  802083:	72 06                	jb     80208b <__umoddi3+0x113>
  802085:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802089:	77 0f                	ja     80209a <__umoddi3+0x122>
  80208b:	89 f2                	mov    %esi,%edx
  80208d:	29 f9                	sub    %edi,%ecx
  80208f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802093:	89 14 24             	mov    %edx,(%esp)
  802096:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80209a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80209e:	8b 14 24             	mov    (%esp),%edx
  8020a1:	83 c4 1c             	add    $0x1c,%esp
  8020a4:	5b                   	pop    %ebx
  8020a5:	5e                   	pop    %esi
  8020a6:	5f                   	pop    %edi
  8020a7:	5d                   	pop    %ebp
  8020a8:	c3                   	ret    
  8020a9:	8d 76 00             	lea    0x0(%esi),%esi
  8020ac:	2b 04 24             	sub    (%esp),%eax
  8020af:	19 fa                	sbb    %edi,%edx
  8020b1:	89 d1                	mov    %edx,%ecx
  8020b3:	89 c6                	mov    %eax,%esi
  8020b5:	e9 71 ff ff ff       	jmp    80202b <__umoddi3+0xb3>
  8020ba:	66 90                	xchg   %ax,%ax
  8020bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020c0:	72 ea                	jb     8020ac <__umoddi3+0x134>
  8020c2:	89 d9                	mov    %ebx,%ecx
  8020c4:	e9 62 ff ff ff       	jmp    80202b <__umoddi3+0xb3>
