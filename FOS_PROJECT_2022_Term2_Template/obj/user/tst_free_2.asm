
obj/user/tst_free_2:     file format elf32-i386


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
  800031:	e8 b0 09 00 00       	call   8009e6 <libmain>
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
  80003c:	81 ec d4 00 00 00    	sub    $0xd4,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 29                	jmp    800078 <_main+0x40>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	01 c0                	add    %eax,%eax
  800061:	01 d0                	add    %edx,%eax
  800063:	c1 e0 02             	shl    $0x2,%eax
  800066:	01 c8                	add    %ecx,%eax
  800068:	8a 40 04             	mov    0x4(%eax),%al
  80006b:	84 c0                	test   %al,%al
  80006d:	74 06                	je     800075 <_main+0x3d>
			{
				fullWS = 0;
  80006f:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800073:	eb 12                	jmp    800087 <_main+0x4f>
{

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800075:	ff 45 f0             	incl   -0x10(%ebp)
  800078:	a1 20 30 80 00       	mov    0x803020,%eax
  80007d:	8b 50 74             	mov    0x74(%eax),%edx
  800080:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800083:	39 c2                	cmp    %eax,%edx
  800085:	77 c8                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800087:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008b:	74 14                	je     8000a1 <_main+0x69>
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	68 c0 25 80 00       	push   $0x8025c0
  800095:	6a 14                	push   $0x14
  800097:	68 dc 25 80 00       	push   $0x8025dc
  80009c:	e8 54 0a 00 00       	call   800af5 <_panic>
	}

	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  8000a1:	83 ec 0c             	sub    $0xc,%esp
  8000a4:	6a 03                	push   $0x3
  8000a6:	e8 13 21 00 00       	call   8021be <sys_bypassPageFault>
  8000ab:	83 c4 10             	add    $0x10,%esp





	int Mega = 1024*1024;
  8000ae:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b5:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	int start_freeFrames = sys_calculate_free_frames() ;
  8000bc:	e8 e7 1d 00 00       	call   801ea8 <sys_calculate_free_frames>
  8000c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//ALLOCATE ALL
	void* ptr_allocations[20] = {0};
  8000c4:	8d 55 80             	lea    -0x80(%ebp),%edx
  8000c7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000d1:	89 d7                	mov    %edx,%edi
  8000d3:	f3 ab                	rep stos %eax,%es:(%edi)
	int lastIndices[20] = {0};
  8000d5:	8d 95 30 ff ff ff    	lea    -0xd0(%ebp),%edx
  8000db:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e0:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e5:	89 d7                	mov    %edx,%edi
  8000e7:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000e9:	e8 ba 1d 00 00       	call   801ea8 <sys_calculate_free_frames>
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000f1:	e8 35 1e 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8000f6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000fc:	01 c0                	add    %eax,%eax
  8000fe:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800101:	83 ec 0c             	sub    $0xc,%esp
  800104:	50                   	push   %eax
  800105:	e8 29 1a 00 00       	call   801b33 <malloc>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 45 80             	mov    -0x80(%ebp),%eax
  800113:	85 c0                	test   %eax,%eax
  800115:	78 14                	js     80012b <_main+0xf3>
  800117:	83 ec 04             	sub    $0x4,%esp
  80011a:	68 f0 25 80 00       	push   $0x8025f0
  80011f:	6a 2b                	push   $0x2b
  800121:	68 dc 25 80 00       	push   $0x8025dc
  800126:	e8 ca 09 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80012b:	e8 fb 1d 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800130:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800133:	3d 00 02 00 00       	cmp    $0x200,%eax
  800138:	74 14                	je     80014e <_main+0x116>
  80013a:	83 ec 04             	sub    $0x4,%esp
  80013d:	68 58 26 80 00       	push   $0x802658
  800142:	6a 2c                	push   $0x2c
  800144:	68 dc 25 80 00       	push   $0x8025dc
  800149:	e8 a7 09 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  80014e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800151:	01 c0                	add    %eax,%eax
  800153:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800156:	48                   	dec    %eax
  800157:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80015d:	e8 46 1d 00 00       	call   801ea8 <sys_calculate_free_frames>
  800162:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800165:	e8 c1 1d 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80016a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80016d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800170:	01 c0                	add    %eax,%eax
  800172:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	50                   	push   %eax
  800179:	e8 b5 19 00 00       	call   801b33 <malloc>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800184:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800187:	89 c2                	mov    %eax,%edx
  800189:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018c:	01 c0                	add    %eax,%eax
  80018e:	05 00 00 00 80       	add    $0x80000000,%eax
  800193:	39 c2                	cmp    %eax,%edx
  800195:	73 14                	jae    8001ab <_main+0x173>
  800197:	83 ec 04             	sub    $0x4,%esp
  80019a:	68 f0 25 80 00       	push   $0x8025f0
  80019f:	6a 33                	push   $0x33
  8001a1:	68 dc 25 80 00       	push   $0x8025dc
  8001a6:	e8 4a 09 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001ab:	e8 7b 1d 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8001b0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001b3:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001b8:	74 14                	je     8001ce <_main+0x196>
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	68 58 26 80 00       	push   $0x802658
  8001c2:	6a 34                	push   $0x34
  8001c4:	68 dc 25 80 00       	push   $0x8025dc
  8001c9:	e8 27 09 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  8001ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001d1:	01 c0                	add    %eax,%eax
  8001d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001d6:	48                   	dec    %eax
  8001d7:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8001dd:	e8 c6 1c 00 00       	call   801ea8 <sys_calculate_free_frames>
  8001e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001e5:	e8 41 1d 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8001ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001f0:	01 c0                	add    %eax,%eax
  8001f2:	83 ec 0c             	sub    $0xc,%esp
  8001f5:	50                   	push   %eax
  8001f6:	e8 38 19 00 00       	call   801b33 <malloc>
  8001fb:	83 c4 10             	add    $0x10,%esp
  8001fe:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800201:	8b 45 88             	mov    -0x78(%ebp),%eax
  800204:	89 c2                	mov    %eax,%edx
  800206:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800209:	c1 e0 02             	shl    $0x2,%eax
  80020c:	05 00 00 00 80       	add    $0x80000000,%eax
  800211:	39 c2                	cmp    %eax,%edx
  800213:	73 14                	jae    800229 <_main+0x1f1>
  800215:	83 ec 04             	sub    $0x4,%esp
  800218:	68 f0 25 80 00       	push   $0x8025f0
  80021d:	6a 3b                	push   $0x3b
  80021f:	68 dc 25 80 00       	push   $0x8025dc
  800224:	e8 cc 08 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800229:	e8 fd 1c 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80022e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800231:	83 f8 01             	cmp    $0x1,%eax
  800234:	74 14                	je     80024a <_main+0x212>
  800236:	83 ec 04             	sub    $0x4,%esp
  800239:	68 58 26 80 00       	push   $0x802658
  80023e:	6a 3c                	push   $0x3c
  800240:	68 dc 25 80 00       	push   $0x8025dc
  800245:	e8 ab 08 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
  80024a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80024d:	01 c0                	add    %eax,%eax
  80024f:	48                   	dec    %eax
  800250:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800256:	e8 4d 1c 00 00       	call   801ea8 <sys_calculate_free_frames>
  80025b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80025e:	e8 c8 1c 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800263:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800266:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800269:	01 c0                	add    %eax,%eax
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	50                   	push   %eax
  80026f:	e8 bf 18 00 00       	call   801b33 <malloc>
  800274:	83 c4 10             	add    $0x10,%esp
  800277:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80027a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80027d:	89 c2                	mov    %eax,%edx
  80027f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800282:	c1 e0 02             	shl    $0x2,%eax
  800285:	89 c1                	mov    %eax,%ecx
  800287:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028a:	c1 e0 02             	shl    $0x2,%eax
  80028d:	01 c8                	add    %ecx,%eax
  80028f:	05 00 00 00 80       	add    $0x80000000,%eax
  800294:	39 c2                	cmp    %eax,%edx
  800296:	73 14                	jae    8002ac <_main+0x274>
  800298:	83 ec 04             	sub    $0x4,%esp
  80029b:	68 f0 25 80 00       	push   $0x8025f0
  8002a0:	6a 43                	push   $0x43
  8002a2:	68 dc 25 80 00       	push   $0x8025dc
  8002a7:	e8 49 08 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8002ac:	e8 7a 1c 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8002b1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002b4:	83 f8 01             	cmp    $0x1,%eax
  8002b7:	74 14                	je     8002cd <_main+0x295>
  8002b9:	83 ec 04             	sub    $0x4,%esp
  8002bc:	68 58 26 80 00       	push   $0x802658
  8002c1:	6a 44                	push   $0x44
  8002c3:	68 dc 25 80 00       	push   $0x8025dc
  8002c8:	e8 28 08 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
  8002cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d0:	01 c0                	add    %eax,%eax
  8002d2:	48                   	dec    %eax
  8002d3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8002d9:	e8 ca 1b 00 00       	call   801ea8 <sys_calculate_free_frames>
  8002de:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002e1:	e8 45 1c 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8002e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  8002e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002ec:	89 d0                	mov    %edx,%eax
  8002ee:	01 c0                	add    %eax,%eax
  8002f0:	01 d0                	add    %edx,%eax
  8002f2:	01 c0                	add    %eax,%eax
  8002f4:	01 d0                	add    %edx,%eax
  8002f6:	83 ec 0c             	sub    $0xc,%esp
  8002f9:	50                   	push   %eax
  8002fa:	e8 34 18 00 00       	call   801b33 <malloc>
  8002ff:	83 c4 10             	add    $0x10,%esp
  800302:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800305:	8b 45 90             	mov    -0x70(%ebp),%eax
  800308:	89 c2                	mov    %eax,%edx
  80030a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80030d:	c1 e0 02             	shl    $0x2,%eax
  800310:	89 c1                	mov    %eax,%ecx
  800312:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800315:	c1 e0 03             	shl    $0x3,%eax
  800318:	01 c8                	add    %ecx,%eax
  80031a:	05 00 00 00 80       	add    $0x80000000,%eax
  80031f:	39 c2                	cmp    %eax,%edx
  800321:	73 14                	jae    800337 <_main+0x2ff>
  800323:	83 ec 04             	sub    $0x4,%esp
  800326:	68 f0 25 80 00       	push   $0x8025f0
  80032b:	6a 4b                	push   $0x4b
  80032d:	68 dc 25 80 00       	push   $0x8025dc
  800332:	e8 be 07 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800337:	e8 ef 1b 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80033c:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80033f:	83 f8 02             	cmp    $0x2,%eax
  800342:	74 14                	je     800358 <_main+0x320>
  800344:	83 ec 04             	sub    $0x4,%esp
  800347:	68 58 26 80 00       	push   $0x802658
  80034c:	6a 4c                	push   $0x4c
  80034e:	68 dc 25 80 00       	push   $0x8025dc
  800353:	e8 9d 07 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
  800358:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035b:	89 d0                	mov    %edx,%eax
  80035d:	01 c0                	add    %eax,%eax
  80035f:	01 d0                	add    %edx,%eax
  800361:	01 c0                	add    %eax,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	48                   	dec    %eax
  800366:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80036c:	e8 37 1b 00 00       	call   801ea8 <sys_calculate_free_frames>
  800371:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800374:	e8 b2 1b 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800379:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  80037c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	01 d2                	add    %edx,%edx
  800383:	01 d0                	add    %edx,%eax
  800385:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800388:	83 ec 0c             	sub    $0xc,%esp
  80038b:	50                   	push   %eax
  80038c:	e8 a2 17 00 00       	call   801b33 <malloc>
  800391:	83 c4 10             	add    $0x10,%esp
  800394:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800397:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80039a:	89 c2                	mov    %eax,%edx
  80039c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80039f:	c1 e0 02             	shl    $0x2,%eax
  8003a2:	89 c1                	mov    %eax,%ecx
  8003a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a7:	c1 e0 04             	shl    $0x4,%eax
  8003aa:	01 c8                	add    %ecx,%eax
  8003ac:	05 00 00 00 80       	add    $0x80000000,%eax
  8003b1:	39 c2                	cmp    %eax,%edx
  8003b3:	73 14                	jae    8003c9 <_main+0x391>
  8003b5:	83 ec 04             	sub    $0x4,%esp
  8003b8:	68 f0 25 80 00       	push   $0x8025f0
  8003bd:	6a 53                	push   $0x53
  8003bf:	68 dc 25 80 00       	push   $0x8025dc
  8003c4:	e8 2c 07 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8003c9:	e8 5d 1b 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8003ce:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003d1:	89 c2                	mov    %eax,%edx
  8003d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d6:	89 c1                	mov    %eax,%ecx
  8003d8:	01 c9                	add    %ecx,%ecx
  8003da:	01 c8                	add    %ecx,%eax
  8003dc:	85 c0                	test   %eax,%eax
  8003de:	79 05                	jns    8003e5 <_main+0x3ad>
  8003e0:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003e5:	c1 f8 0c             	sar    $0xc,%eax
  8003e8:	39 c2                	cmp    %eax,%edx
  8003ea:	74 14                	je     800400 <_main+0x3c8>
  8003ec:	83 ec 04             	sub    $0x4,%esp
  8003ef:	68 58 26 80 00       	push   $0x802658
  8003f4:	6a 54                	push   $0x54
  8003f6:	68 dc 25 80 00       	push   $0x8025dc
  8003fb:	e8 f5 06 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		lastIndices[5] = (3*Mega - kilo)/sizeof(char) - 1;
  800400:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800403:	89 c2                	mov    %eax,%edx
  800405:	01 d2                	add    %edx,%edx
  800407:	01 d0                	add    %edx,%eax
  800409:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80040c:	48                   	dec    %eax
  80040d:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800413:	e8 90 1a 00 00       	call   801ea8 <sys_calculate_free_frames>
  800418:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041b:	e8 0b 1b 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800420:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800423:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800426:	01 c0                	add    %eax,%eax
  800428:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	50                   	push   %eax
  80042f:	e8 ff 16 00 00       	call   801b33 <malloc>
  800434:	83 c4 10             	add    $0x10,%esp
  800437:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80043a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80043d:	89 c1                	mov    %eax,%ecx
  80043f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800442:	89 d0                	mov    %edx,%eax
  800444:	01 c0                	add    %eax,%eax
  800446:	01 d0                	add    %edx,%eax
  800448:	01 c0                	add    %eax,%eax
  80044a:	01 d0                	add    %edx,%eax
  80044c:	89 c2                	mov    %eax,%edx
  80044e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800451:	c1 e0 04             	shl    $0x4,%eax
  800454:	01 d0                	add    %edx,%eax
  800456:	05 00 00 00 80       	add    $0x80000000,%eax
  80045b:	39 c1                	cmp    %eax,%ecx
  80045d:	73 14                	jae    800473 <_main+0x43b>
  80045f:	83 ec 04             	sub    $0x4,%esp
  800462:	68 f0 25 80 00       	push   $0x8025f0
  800467:	6a 5b                	push   $0x5b
  800469:	68 dc 25 80 00       	push   $0x8025dc
  80046e:	e8 82 06 00 00       	call   800af5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800473:	e8 b3 1a 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800478:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80047b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800480:	74 14                	je     800496 <_main+0x45e>
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 58 26 80 00       	push   $0x802658
  80048a:	6a 5c                	push   $0x5c
  80048c:	68 dc 25 80 00       	push   $0x8025dc
  800491:	e8 5f 06 00 00       	call   800af5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[6] = (2*Mega - kilo)/sizeof(char) - 1;
  800496:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800499:	01 c0                	add    %eax,%eax
  80049b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80049e:	48                   	dec    %eax
  80049f:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
	char x ;
	int y;
	char *byteArr ;
	//FREE ALL
	{
		int freeFrames = sys_calculate_free_frames() ;
  8004a5:	e8 fe 19 00 00       	call   801ea8 <sys_calculate_free_frames>
  8004aa:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004ad:	e8 79 1a 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8004b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[0]);
  8004b5:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004b8:	83 ec 0c             	sub    $0xc,%esp
  8004bb:	50                   	push   %eax
  8004bc:	e8 2a 18 00 00       	call   801ceb <free>
  8004c1:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8004c4:	e8 62 1a 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8004c9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004cc:	29 c2                	sub    %eax,%edx
  8004ce:	89 d0                	mov    %edx,%eax
  8004d0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8004d5:	74 14                	je     8004eb <_main+0x4b3>
  8004d7:	83 ec 04             	sub    $0x4,%esp
  8004da:	68 88 26 80 00       	push   $0x802688
  8004df:	6a 69                	push   $0x69
  8004e1:	68 dc 25 80 00       	push   $0x8025dc
  8004e6:	e8 0a 06 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[0];
  8004eb:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8004f1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004f4:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8004f7:	e8 a9 1c 00 00       	call   8021a5 <sys_rcr2>
  8004fc:	89 c2                	mov    %eax,%edx
  8004fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800501:	39 c2                	cmp    %eax,%edx
  800503:	74 14                	je     800519 <_main+0x4e1>
  800505:	83 ec 04             	sub    $0x4,%esp
  800508:	68 c4 26 80 00       	push   $0x8026c4
  80050d:	6a 6d                	push   $0x6d
  80050f:	68 dc 25 80 00       	push   $0x8025dc
  800514:	e8 dc 05 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[0]] = 10;
  800519:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80051f:	89 c2                	mov    %eax,%edx
  800521:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800524:	01 d0                	add    %edx,%eax
  800526:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[0]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800529:	e8 77 1c 00 00       	call   8021a5 <sys_rcr2>
  80052e:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  800534:	89 d1                	mov    %edx,%ecx
  800536:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800539:	01 ca                	add    %ecx,%edx
  80053b:	39 d0                	cmp    %edx,%eax
  80053d:	74 14                	je     800553 <_main+0x51b>
  80053f:	83 ec 04             	sub    $0x4,%esp
  800542:	68 c4 26 80 00       	push   $0x8026c4
  800547:	6a 6f                	push   $0x6f
  800549:	68 dc 25 80 00       	push   $0x8025dc
  80054e:	e8 a2 05 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800553:	e8 50 19 00 00       	call   801ea8 <sys_calculate_free_frames>
  800558:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80055b:	e8 cb 19 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[1]);
  800563:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800566:	83 ec 0c             	sub    $0xc,%esp
  800569:	50                   	push   %eax
  80056a:	e8 7c 17 00 00       	call   801ceb <free>
  80056f:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800572:	e8 b4 19 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800577:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80057a:	29 c2                	sub    %eax,%edx
  80057c:	89 d0                	mov    %edx,%eax
  80057e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800583:	74 14                	je     800599 <_main+0x561>
  800585:	83 ec 04             	sub    $0x4,%esp
  800588:	68 88 26 80 00       	push   $0x802688
  80058d:	6a 74                	push   $0x74
  80058f:	68 dc 25 80 00       	push   $0x8025dc
  800594:	e8 5c 05 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[1];
  800599:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80059c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80059f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005a2:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005a5:	e8 fb 1b 00 00       	call   8021a5 <sys_rcr2>
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	74 14                	je     8005c7 <_main+0x58f>
  8005b3:	83 ec 04             	sub    $0x4,%esp
  8005b6:	68 c4 26 80 00       	push   $0x8026c4
  8005bb:	6a 78                	push   $0x78
  8005bd:	68 dc 25 80 00       	push   $0x8025dc
  8005c2:	e8 2e 05 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[1]] = 10;
  8005c7:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  8005cd:	89 c2                	mov    %eax,%edx
  8005cf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005d2:	01 d0                	add    %edx,%eax
  8005d4:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[1]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005d7:	e8 c9 1b 00 00       	call   8021a5 <sys_rcr2>
  8005dc:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
  8005e2:	89 d1                	mov    %edx,%ecx
  8005e4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8005e7:	01 ca                	add    %ecx,%edx
  8005e9:	39 d0                	cmp    %edx,%eax
  8005eb:	74 14                	je     800601 <_main+0x5c9>
  8005ed:	83 ec 04             	sub    $0x4,%esp
  8005f0:	68 c4 26 80 00       	push   $0x8026c4
  8005f5:	6a 7a                	push   $0x7a
  8005f7:	68 dc 25 80 00       	push   $0x8025dc
  8005fc:	e8 f4 04 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800601:	e8 a2 18 00 00       	call   801ea8 <sys_calculate_free_frames>
  800606:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800609:	e8 1d 19 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80060e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[2]);
  800611:	8b 45 88             	mov    -0x78(%ebp),%eax
  800614:	83 ec 0c             	sub    $0xc,%esp
  800617:	50                   	push   %eax
  800618:	e8 ce 16 00 00       	call   801ceb <free>
  80061d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  800620:	e8 06 19 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800625:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800628:	29 c2                	sub    %eax,%edx
  80062a:	89 d0                	mov    %edx,%eax
  80062c:	83 f8 01             	cmp    $0x1,%eax
  80062f:	74 14                	je     800645 <_main+0x60d>
  800631:	83 ec 04             	sub    $0x4,%esp
  800634:	68 88 26 80 00       	push   $0x802688
  800639:	6a 7f                	push   $0x7f
  80063b:	68 dc 25 80 00       	push   $0x8025dc
  800640:	e8 b0 04 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[2];
  800645:	8b 45 88             	mov    -0x78(%ebp),%eax
  800648:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80064b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80064e:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800651:	e8 4f 1b 00 00       	call   8021a5 <sys_rcr2>
  800656:	89 c2                	mov    %eax,%edx
  800658:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80065b:	39 c2                	cmp    %eax,%edx
  80065d:	74 17                	je     800676 <_main+0x63e>
  80065f:	83 ec 04             	sub    $0x4,%esp
  800662:	68 c4 26 80 00       	push   $0x8026c4
  800667:	68 83 00 00 00       	push   $0x83
  80066c:	68 dc 25 80 00       	push   $0x8025dc
  800671:	e8 7f 04 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[2]] = 10;
  800676:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  80067c:	89 c2                	mov    %eax,%edx
  80067e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800681:	01 d0                	add    %edx,%eax
  800683:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[2]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800686:	e8 1a 1b 00 00       	call   8021a5 <sys_rcr2>
  80068b:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800691:	89 d1                	mov    %edx,%ecx
  800693:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800696:	01 ca                	add    %ecx,%edx
  800698:	39 d0                	cmp    %edx,%eax
  80069a:	74 17                	je     8006b3 <_main+0x67b>
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	68 c4 26 80 00       	push   $0x8026c4
  8006a4:	68 85 00 00 00       	push   $0x85
  8006a9:	68 dc 25 80 00       	push   $0x8025dc
  8006ae:	e8 42 04 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8006b3:	e8 f0 17 00 00       	call   801ea8 <sys_calculate_free_frames>
  8006b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006bb:	e8 6b 18 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8006c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[3]);
  8006c3:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	50                   	push   %eax
  8006ca:	e8 1c 16 00 00       	call   801ceb <free>
  8006cf:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006d2:	e8 54 18 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8006d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8006da:	29 c2                	sub    %eax,%edx
  8006dc:	89 d0                	mov    %edx,%eax
  8006de:	83 f8 01             	cmp    $0x1,%eax
  8006e1:	74 17                	je     8006fa <_main+0x6c2>
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	68 88 26 80 00       	push   $0x802688
  8006eb:	68 8a 00 00 00       	push   $0x8a
  8006f0:	68 dc 25 80 00       	push   $0x8025dc
  8006f5:	e8 fb 03 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[3];
  8006fa:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006fd:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800700:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800703:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800706:	e8 9a 1a 00 00       	call   8021a5 <sys_rcr2>
  80070b:	89 c2                	mov    %eax,%edx
  80070d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800710:	39 c2                	cmp    %eax,%edx
  800712:	74 17                	je     80072b <_main+0x6f3>
  800714:	83 ec 04             	sub    $0x4,%esp
  800717:	68 c4 26 80 00       	push   $0x8026c4
  80071c:	68 8e 00 00 00       	push   $0x8e
  800721:	68 dc 25 80 00       	push   $0x8025dc
  800726:	e8 ca 03 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[3]] = 10;
  80072b:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800731:	89 c2                	mov    %eax,%edx
  800733:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800736:	01 d0                	add    %edx,%eax
  800738:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[3]])) panic("Free: successful access to freed space!! it should not be succeeded");
  80073b:	e8 65 1a 00 00       	call   8021a5 <sys_rcr2>
  800740:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800746:	89 d1                	mov    %edx,%ecx
  800748:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80074b:	01 ca                	add    %ecx,%edx
  80074d:	39 d0                	cmp    %edx,%eax
  80074f:	74 17                	je     800768 <_main+0x730>
  800751:	83 ec 04             	sub    $0x4,%esp
  800754:	68 c4 26 80 00       	push   $0x8026c4
  800759:	68 90 00 00 00       	push   $0x90
  80075e:	68 dc 25 80 00       	push   $0x8025dc
  800763:	e8 8d 03 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800768:	e8 3b 17 00 00       	call   801ea8 <sys_calculate_free_frames>
  80076d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800770:	e8 b6 17 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800775:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[4]);
  800778:	8b 45 90             	mov    -0x70(%ebp),%eax
  80077b:	83 ec 0c             	sub    $0xc,%esp
  80077e:	50                   	push   %eax
  80077f:	e8 67 15 00 00       	call   801ceb <free>
  800784:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  800787:	e8 9f 17 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80078c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80078f:	29 c2                	sub    %eax,%edx
  800791:	89 d0                	mov    %edx,%eax
  800793:	83 f8 02             	cmp    $0x2,%eax
  800796:	74 17                	je     8007af <_main+0x777>
  800798:	83 ec 04             	sub    $0x4,%esp
  80079b:	68 88 26 80 00       	push   $0x802688
  8007a0:	68 95 00 00 00       	push   $0x95
  8007a5:	68 dc 25 80 00       	push   $0x8025dc
  8007aa:	e8 46 03 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[4];
  8007af:	8b 45 90             	mov    -0x70(%ebp),%eax
  8007b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8007b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b8:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007bb:	e8 e5 19 00 00       	call   8021a5 <sys_rcr2>
  8007c0:	89 c2                	mov    %eax,%edx
  8007c2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007c5:	39 c2                	cmp    %eax,%edx
  8007c7:	74 17                	je     8007e0 <_main+0x7a8>
  8007c9:	83 ec 04             	sub    $0x4,%esp
  8007cc:	68 c4 26 80 00       	push   $0x8026c4
  8007d1:	68 99 00 00 00       	push   $0x99
  8007d6:	68 dc 25 80 00       	push   $0x8025dc
  8007db:	e8 15 03 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[4]] = 10;
  8007e0:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  8007e6:	89 c2                	mov    %eax,%edx
  8007e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007eb:	01 d0                	add    %edx,%eax
  8007ed:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[4]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007f0:	e8 b0 19 00 00       	call   8021a5 <sys_rcr2>
  8007f5:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  8007fb:	89 d1                	mov    %edx,%ecx
  8007fd:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800800:	01 ca                	add    %ecx,%edx
  800802:	39 d0                	cmp    %edx,%eax
  800804:	74 17                	je     80081d <_main+0x7e5>
  800806:	83 ec 04             	sub    $0x4,%esp
  800809:	68 c4 26 80 00       	push   $0x8026c4
  80080e:	68 9b 00 00 00       	push   $0x9b
  800813:	68 dc 25 80 00       	push   $0x8025dc
  800818:	e8 d8 02 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80081d:	e8 86 16 00 00       	call   801ea8 <sys_calculate_free_frames>
  800822:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800825:	e8 01 17 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80082a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[5]);
  80082d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800830:	83 ec 0c             	sub    $0xc,%esp
  800833:	50                   	push   %eax
  800834:	e8 b2 14 00 00       	call   801ceb <free>
  800839:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096 ) panic("Wrong free: Extra or less pages are removed from PageFile");
  80083c:	e8 ea 16 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  800841:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800844:	89 d1                	mov    %edx,%ecx
  800846:	29 c1                	sub    %eax,%ecx
  800848:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80084b:	89 c2                	mov    %eax,%edx
  80084d:	01 d2                	add    %edx,%edx
  80084f:	01 d0                	add    %edx,%eax
  800851:	85 c0                	test   %eax,%eax
  800853:	79 05                	jns    80085a <_main+0x822>
  800855:	05 ff 0f 00 00       	add    $0xfff,%eax
  80085a:	c1 f8 0c             	sar    $0xc,%eax
  80085d:	39 c1                	cmp    %eax,%ecx
  80085f:	74 17                	je     800878 <_main+0x840>
  800861:	83 ec 04             	sub    $0x4,%esp
  800864:	68 88 26 80 00       	push   $0x802688
  800869:	68 a0 00 00 00       	push   $0xa0
  80086e:	68 dc 25 80 00       	push   $0x8025dc
  800873:	e8 7d 02 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 3*Mega/4096 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[5];
  800878:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80087b:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80087e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800881:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800884:	e8 1c 19 00 00       	call   8021a5 <sys_rcr2>
  800889:	89 c2                	mov    %eax,%edx
  80088b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80088e:	39 c2                	cmp    %eax,%edx
  800890:	74 17                	je     8008a9 <_main+0x871>
  800892:	83 ec 04             	sub    $0x4,%esp
  800895:	68 c4 26 80 00       	push   $0x8026c4
  80089a:	68 a4 00 00 00       	push   $0xa4
  80089f:	68 dc 25 80 00       	push   $0x8025dc
  8008a4:	e8 4c 02 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[5]] = 10;
  8008a9:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8008af:	89 c2                	mov    %eax,%edx
  8008b1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8008b4:	01 d0                	add    %edx,%eax
  8008b6:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[5]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8008b9:	e8 e7 18 00 00       	call   8021a5 <sys_rcr2>
  8008be:	8b 95 44 ff ff ff    	mov    -0xbc(%ebp),%edx
  8008c4:	89 d1                	mov    %edx,%ecx
  8008c6:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8008c9:	01 ca                	add    %ecx,%edx
  8008cb:	39 d0                	cmp    %edx,%eax
  8008cd:	74 17                	je     8008e6 <_main+0x8ae>
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 c4 26 80 00       	push   $0x8026c4
  8008d7:	68 a6 00 00 00       	push   $0xa6
  8008dc:	68 dc 25 80 00       	push   $0x8025dc
  8008e1:	e8 0f 02 00 00       	call   800af5 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8008e6:	e8 bd 15 00 00       	call   801ea8 <sys_calculate_free_frames>
  8008eb:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008ee:	e8 38 16 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  8008f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[6]);
  8008f6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8008f9:	83 ec 0c             	sub    $0xc,%esp
  8008fc:	50                   	push   %eax
  8008fd:	e8 e9 13 00 00       	call   801ceb <free>
  800902:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800905:	e8 21 16 00 00       	call   801f2b <sys_pf_calculate_allocated_pages>
  80090a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80090d:	29 c2                	sub    %eax,%edx
  80090f:	89 d0                	mov    %edx,%eax
  800911:	3d 00 02 00 00       	cmp    $0x200,%eax
  800916:	74 17                	je     80092f <_main+0x8f7>
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 88 26 80 00       	push   $0x802688
  800920:	68 ab 00 00 00       	push   $0xab
  800925:	68 dc 25 80 00       	push   $0x8025dc
  80092a:	e8 c6 01 00 00       	call   800af5 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 2) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[6];
  80092f:	8b 45 98             	mov    -0x68(%ebp),%eax
  800932:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800935:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800938:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  80093b:	e8 65 18 00 00       	call   8021a5 <sys_rcr2>
  800940:	89 c2                	mov    %eax,%edx
  800942:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800945:	39 c2                	cmp    %eax,%edx
  800947:	74 17                	je     800960 <_main+0x928>
  800949:	83 ec 04             	sub    $0x4,%esp
  80094c:	68 c4 26 80 00       	push   $0x8026c4
  800951:	68 af 00 00 00       	push   $0xaf
  800956:	68 dc 25 80 00       	push   $0x8025dc
  80095b:	e8 95 01 00 00       	call   800af5 <_panic>
		byteArr[lastIndices[6]] = 10;
  800960:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800966:	89 c2                	mov    %eax,%edx
  800968:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80096b:	01 d0                	add    %edx,%eax
  80096d:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[6]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800970:	e8 30 18 00 00       	call   8021a5 <sys_rcr2>
  800975:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
  80097b:	89 d1                	mov    %edx,%ecx
  80097d:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800980:	01 ca                	add    %ecx,%edx
  800982:	39 d0                	cmp    %edx,%eax
  800984:	74 17                	je     80099d <_main+0x965>
  800986:	83 ec 04             	sub    $0x4,%esp
  800989:	68 c4 26 80 00       	push   $0x8026c4
  80098e:	68 b1 00 00 00       	push   $0xb1
  800993:	68 dc 25 80 00       	push   $0x8025dc
  800998:	e8 58 01 00 00       	call   800af5 <_panic>

		if(start_freeFrames != (sys_calculate_free_frames() + 3) ) {panic("Wrong free: not all pages removed correctly at end");}
  80099d:	e8 06 15 00 00       	call   801ea8 <sys_calculate_free_frames>
  8009a2:	8d 50 03             	lea    0x3(%eax),%edx
  8009a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009a8:	39 c2                	cmp    %eax,%edx
  8009aa:	74 17                	je     8009c3 <_main+0x98b>
  8009ac:	83 ec 04             	sub    $0x4,%esp
  8009af:	68 08 27 80 00       	push   $0x802708
  8009b4:	68 b3 00 00 00       	push   $0xb3
  8009b9:	68 dc 25 80 00       	push   $0x8025dc
  8009be:	e8 32 01 00 00       	call   800af5 <_panic>
	}

	//set it to 0 again to cancel the bypassing option
	sys_bypassPageFault(0);
  8009c3:	83 ec 0c             	sub    $0xc,%esp
  8009c6:	6a 00                	push   $0x0
  8009c8:	e8 f1 17 00 00       	call   8021be <sys_bypassPageFault>
  8009cd:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test free [2] completed successfully.\n");
  8009d0:	83 ec 0c             	sub    $0xc,%esp
  8009d3:	68 3c 27 80 00       	push   $0x80273c
  8009d8:	e8 cc 03 00 00       	call   800da9 <cprintf>
  8009dd:	83 c4 10             	add    $0x10,%esp

	return;
  8009e0:	90                   	nop
}
  8009e1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8009ec:	e8 ec 13 00 00       	call   801ddd <sys_getenvindex>
  8009f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8009f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f7:	89 d0                	mov    %edx,%eax
  8009f9:	c1 e0 02             	shl    $0x2,%eax
  8009fc:	01 d0                	add    %edx,%eax
  8009fe:	01 c0                	add    %eax,%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	01 c0                	add    %eax,%eax
  800a04:	01 d0                	add    %edx,%eax
  800a06:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800a0d:	01 d0                	add    %edx,%eax
  800a0f:	c1 e0 02             	shl    $0x2,%eax
  800a12:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a17:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a1c:	a1 20 30 80 00       	mov    0x803020,%eax
  800a21:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800a27:	84 c0                	test   %al,%al
  800a29:	74 0f                	je     800a3a <libmain+0x54>
		binaryname = myEnv->prog_name;
  800a2b:	a1 20 30 80 00       	mov    0x803020,%eax
  800a30:	05 f4 02 00 00       	add    $0x2f4,%eax
  800a35:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a3a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a3e:	7e 0a                	jle    800a4a <libmain+0x64>
		binaryname = argv[0];
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	8b 00                	mov    (%eax),%eax
  800a45:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	ff 75 08             	pushl  0x8(%ebp)
  800a53:	e8 e0 f5 ff ff       	call   800038 <_main>
  800a58:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800a5b:	e8 18 15 00 00       	call   801f78 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800a60:	83 ec 0c             	sub    $0xc,%esp
  800a63:	68 90 27 80 00       	push   $0x802790
  800a68:	e8 3c 03 00 00       	call   800da9 <cprintf>
  800a6d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800a70:	a1 20 30 80 00       	mov    0x803020,%eax
  800a75:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800a7b:	a1 20 30 80 00       	mov    0x803020,%eax
  800a80:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800a86:	83 ec 04             	sub    $0x4,%esp
  800a89:	52                   	push   %edx
  800a8a:	50                   	push   %eax
  800a8b:	68 b8 27 80 00       	push   $0x8027b8
  800a90:	e8 14 03 00 00       	call   800da9 <cprintf>
  800a95:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800a98:	a1 20 30 80 00       	mov    0x803020,%eax
  800a9d:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800aa3:	83 ec 08             	sub    $0x8,%esp
  800aa6:	50                   	push   %eax
  800aa7:	68 dd 27 80 00       	push   $0x8027dd
  800aac:	e8 f8 02 00 00       	call   800da9 <cprintf>
  800ab1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800ab4:	83 ec 0c             	sub    $0xc,%esp
  800ab7:	68 90 27 80 00       	push   $0x802790
  800abc:	e8 e8 02 00 00       	call   800da9 <cprintf>
  800ac1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ac4:	e8 c9 14 00 00       	call   801f92 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ac9:	e8 19 00 00 00       	call   800ae7 <exit>
}
  800ace:	90                   	nop
  800acf:	c9                   	leave  
  800ad0:	c3                   	ret    

00800ad1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
  800ad4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800ad7:	83 ec 0c             	sub    $0xc,%esp
  800ada:	6a 00                	push   $0x0
  800adc:	e8 c8 12 00 00       	call   801da9 <sys_env_destroy>
  800ae1:	83 c4 10             	add    $0x10,%esp
}
  800ae4:	90                   	nop
  800ae5:	c9                   	leave  
  800ae6:	c3                   	ret    

00800ae7 <exit>:

void
exit(void)
{
  800ae7:	55                   	push   %ebp
  800ae8:	89 e5                	mov    %esp,%ebp
  800aea:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800aed:	e8 1d 13 00 00       	call   801e0f <sys_env_exit>
}
  800af2:	90                   	nop
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
  800af8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800afb:	8d 45 10             	lea    0x10(%ebp),%eax
  800afe:	83 c0 04             	add    $0x4,%eax
  800b01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800b04:	a1 34 30 80 00       	mov    0x803034,%eax
  800b09:	85 c0                	test   %eax,%eax
  800b0b:	74 16                	je     800b23 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800b0d:	a1 34 30 80 00       	mov    0x803034,%eax
  800b12:	83 ec 08             	sub    $0x8,%esp
  800b15:	50                   	push   %eax
  800b16:	68 f4 27 80 00       	push   $0x8027f4
  800b1b:	e8 89 02 00 00       	call   800da9 <cprintf>
  800b20:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800b23:	a1 00 30 80 00       	mov    0x803000,%eax
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 08             	pushl  0x8(%ebp)
  800b2e:	50                   	push   %eax
  800b2f:	68 f9 27 80 00       	push   $0x8027f9
  800b34:	e8 70 02 00 00       	call   800da9 <cprintf>
  800b39:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800b3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3f:	83 ec 08             	sub    $0x8,%esp
  800b42:	ff 75 f4             	pushl  -0xc(%ebp)
  800b45:	50                   	push   %eax
  800b46:	e8 f3 01 00 00       	call   800d3e <vcprintf>
  800b4b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800b4e:	83 ec 08             	sub    $0x8,%esp
  800b51:	6a 00                	push   $0x0
  800b53:	68 15 28 80 00       	push   $0x802815
  800b58:	e8 e1 01 00 00       	call   800d3e <vcprintf>
  800b5d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800b60:	e8 82 ff ff ff       	call   800ae7 <exit>

	// should not return here
	while (1) ;
  800b65:	eb fe                	jmp    800b65 <_panic+0x70>

00800b67 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800b67:	55                   	push   %ebp
  800b68:	89 e5                	mov    %esp,%ebp
  800b6a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800b6d:	a1 20 30 80 00       	mov    0x803020,%eax
  800b72:	8b 50 74             	mov    0x74(%eax),%edx
  800b75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b78:	39 c2                	cmp    %eax,%edx
  800b7a:	74 14                	je     800b90 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800b7c:	83 ec 04             	sub    $0x4,%esp
  800b7f:	68 18 28 80 00       	push   $0x802818
  800b84:	6a 26                	push   $0x26
  800b86:	68 64 28 80 00       	push   $0x802864
  800b8b:	e8 65 ff ff ff       	call   800af5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800b90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800b97:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800b9e:	e9 c2 00 00 00       	jmp    800c65 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800ba3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ba6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	01 d0                	add    %edx,%eax
  800bb2:	8b 00                	mov    (%eax),%eax
  800bb4:	85 c0                	test   %eax,%eax
  800bb6:	75 08                	jne    800bc0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800bb8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800bbb:	e9 a2 00 00 00       	jmp    800c62 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800bc0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bc7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800bce:	eb 69                	jmp    800c39 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800bd0:	a1 20 30 80 00       	mov    0x803020,%eax
  800bd5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bdb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bde:	89 d0                	mov    %edx,%eax
  800be0:	01 c0                	add    %eax,%eax
  800be2:	01 d0                	add    %edx,%eax
  800be4:	c1 e0 02             	shl    $0x2,%eax
  800be7:	01 c8                	add    %ecx,%eax
  800be9:	8a 40 04             	mov    0x4(%eax),%al
  800bec:	84 c0                	test   %al,%al
  800bee:	75 46                	jne    800c36 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800bf0:	a1 20 30 80 00       	mov    0x803020,%eax
  800bf5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bfb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bfe:	89 d0                	mov    %edx,%eax
  800c00:	01 c0                	add    %eax,%eax
  800c02:	01 d0                	add    %edx,%eax
  800c04:	c1 e0 02             	shl    $0x2,%eax
  800c07:	01 c8                	add    %ecx,%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800c0e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c11:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c16:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800c18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c1b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	01 c8                	add    %ecx,%eax
  800c27:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800c29:	39 c2                	cmp    %eax,%edx
  800c2b:	75 09                	jne    800c36 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800c2d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800c34:	eb 12                	jmp    800c48 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c36:	ff 45 e8             	incl   -0x18(%ebp)
  800c39:	a1 20 30 80 00       	mov    0x803020,%eax
  800c3e:	8b 50 74             	mov    0x74(%eax),%edx
  800c41:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800c44:	39 c2                	cmp    %eax,%edx
  800c46:	77 88                	ja     800bd0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800c48:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c4c:	75 14                	jne    800c62 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800c4e:	83 ec 04             	sub    $0x4,%esp
  800c51:	68 70 28 80 00       	push   $0x802870
  800c56:	6a 3a                	push   $0x3a
  800c58:	68 64 28 80 00       	push   $0x802864
  800c5d:	e8 93 fe ff ff       	call   800af5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800c62:	ff 45 f0             	incl   -0x10(%ebp)
  800c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c68:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800c6b:	0f 8c 32 ff ff ff    	jl     800ba3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800c71:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c78:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800c7f:	eb 26                	jmp    800ca7 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800c81:	a1 20 30 80 00       	mov    0x803020,%eax
  800c86:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800c8c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c8f:	89 d0                	mov    %edx,%eax
  800c91:	01 c0                	add    %eax,%eax
  800c93:	01 d0                	add    %edx,%eax
  800c95:	c1 e0 02             	shl    $0x2,%eax
  800c98:	01 c8                	add    %ecx,%eax
  800c9a:	8a 40 04             	mov    0x4(%eax),%al
  800c9d:	3c 01                	cmp    $0x1,%al
  800c9f:	75 03                	jne    800ca4 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800ca1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ca4:	ff 45 e0             	incl   -0x20(%ebp)
  800ca7:	a1 20 30 80 00       	mov    0x803020,%eax
  800cac:	8b 50 74             	mov    0x74(%eax),%edx
  800caf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cb2:	39 c2                	cmp    %eax,%edx
  800cb4:	77 cb                	ja     800c81 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cb9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800cbc:	74 14                	je     800cd2 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800cbe:	83 ec 04             	sub    $0x4,%esp
  800cc1:	68 c4 28 80 00       	push   $0x8028c4
  800cc6:	6a 44                	push   $0x44
  800cc8:	68 64 28 80 00       	push   $0x802864
  800ccd:	e8 23 fe ff ff       	call   800af5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800cd2:	90                   	nop
  800cd3:	c9                   	leave  
  800cd4:	c3                   	ret    

00800cd5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cde:	8b 00                	mov    (%eax),%eax
  800ce0:	8d 48 01             	lea    0x1(%eax),%ecx
  800ce3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce6:	89 0a                	mov    %ecx,(%edx)
  800ce8:	8b 55 08             	mov    0x8(%ebp),%edx
  800ceb:	88 d1                	mov    %dl,%cl
  800ced:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf7:	8b 00                	mov    (%eax),%eax
  800cf9:	3d ff 00 00 00       	cmp    $0xff,%eax
  800cfe:	75 2c                	jne    800d2c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800d00:	a0 24 30 80 00       	mov    0x803024,%al
  800d05:	0f b6 c0             	movzbl %al,%eax
  800d08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d0b:	8b 12                	mov    (%edx),%edx
  800d0d:	89 d1                	mov    %edx,%ecx
  800d0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d12:	83 c2 08             	add    $0x8,%edx
  800d15:	83 ec 04             	sub    $0x4,%esp
  800d18:	50                   	push   %eax
  800d19:	51                   	push   %ecx
  800d1a:	52                   	push   %edx
  800d1b:	e8 47 10 00 00       	call   801d67 <sys_cputs>
  800d20:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800d23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2f:	8b 40 04             	mov    0x4(%eax),%eax
  800d32:	8d 50 01             	lea    0x1(%eax),%edx
  800d35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d38:	89 50 04             	mov    %edx,0x4(%eax)
}
  800d3b:	90                   	nop
  800d3c:	c9                   	leave  
  800d3d:	c3                   	ret    

00800d3e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800d47:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800d4e:	00 00 00 
	b.cnt = 0;
  800d51:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800d58:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	ff 75 08             	pushl  0x8(%ebp)
  800d61:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d67:	50                   	push   %eax
  800d68:	68 d5 0c 80 00       	push   $0x800cd5
  800d6d:	e8 11 02 00 00       	call   800f83 <vprintfmt>
  800d72:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800d75:	a0 24 30 80 00       	mov    0x803024,%al
  800d7a:	0f b6 c0             	movzbl %al,%eax
  800d7d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800d83:	83 ec 04             	sub    $0x4,%esp
  800d86:	50                   	push   %eax
  800d87:	52                   	push   %edx
  800d88:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d8e:	83 c0 08             	add    $0x8,%eax
  800d91:	50                   	push   %eax
  800d92:	e8 d0 0f 00 00       	call   801d67 <sys_cputs>
  800d97:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d9a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800da1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800da7:	c9                   	leave  
  800da8:	c3                   	ret    

00800da9 <cprintf>:

int cprintf(const char *fmt, ...) {
  800da9:	55                   	push   %ebp
  800daa:	89 e5                	mov    %esp,%ebp
  800dac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800daf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800db6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800db9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	83 ec 08             	sub    $0x8,%esp
  800dc2:	ff 75 f4             	pushl  -0xc(%ebp)
  800dc5:	50                   	push   %eax
  800dc6:	e8 73 ff ff ff       	call   800d3e <vcprintf>
  800dcb:	83 c4 10             	add    $0x10,%esp
  800dce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800dd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ddc:	e8 97 11 00 00       	call   801f78 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800de1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800de4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	83 ec 08             	sub    $0x8,%esp
  800ded:	ff 75 f4             	pushl  -0xc(%ebp)
  800df0:	50                   	push   %eax
  800df1:	e8 48 ff ff ff       	call   800d3e <vcprintf>
  800df6:	83 c4 10             	add    $0x10,%esp
  800df9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800dfc:	e8 91 11 00 00       	call   801f92 <sys_enable_interrupt>
	return cnt;
  800e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e04:	c9                   	leave  
  800e05:	c3                   	ret    

00800e06 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800e06:	55                   	push   %ebp
  800e07:	89 e5                	mov    %esp,%ebp
  800e09:	53                   	push   %ebx
  800e0a:	83 ec 14             	sub    $0x14,%esp
  800e0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e13:	8b 45 14             	mov    0x14(%ebp),%eax
  800e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800e19:	8b 45 18             	mov    0x18(%ebp),%eax
  800e1c:	ba 00 00 00 00       	mov    $0x0,%edx
  800e21:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e24:	77 55                	ja     800e7b <printnum+0x75>
  800e26:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e29:	72 05                	jb     800e30 <printnum+0x2a>
  800e2b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e2e:	77 4b                	ja     800e7b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800e30:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800e33:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800e36:	8b 45 18             	mov    0x18(%ebp),%eax
  800e39:	ba 00 00 00 00       	mov    $0x0,%edx
  800e3e:	52                   	push   %edx
  800e3f:	50                   	push   %eax
  800e40:	ff 75 f4             	pushl  -0xc(%ebp)
  800e43:	ff 75 f0             	pushl  -0x10(%ebp)
  800e46:	e8 0d 15 00 00       	call   802358 <__udivdi3>
  800e4b:	83 c4 10             	add    $0x10,%esp
  800e4e:	83 ec 04             	sub    $0x4,%esp
  800e51:	ff 75 20             	pushl  0x20(%ebp)
  800e54:	53                   	push   %ebx
  800e55:	ff 75 18             	pushl  0x18(%ebp)
  800e58:	52                   	push   %edx
  800e59:	50                   	push   %eax
  800e5a:	ff 75 0c             	pushl  0xc(%ebp)
  800e5d:	ff 75 08             	pushl  0x8(%ebp)
  800e60:	e8 a1 ff ff ff       	call   800e06 <printnum>
  800e65:	83 c4 20             	add    $0x20,%esp
  800e68:	eb 1a                	jmp    800e84 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	ff 75 20             	pushl  0x20(%ebp)
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	ff d0                	call   *%eax
  800e78:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e7b:	ff 4d 1c             	decl   0x1c(%ebp)
  800e7e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e82:	7f e6                	jg     800e6a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e84:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e87:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e92:	53                   	push   %ebx
  800e93:	51                   	push   %ecx
  800e94:	52                   	push   %edx
  800e95:	50                   	push   %eax
  800e96:	e8 cd 15 00 00       	call   802468 <__umoddi3>
  800e9b:	83 c4 10             	add    $0x10,%esp
  800e9e:	05 34 2b 80 00       	add    $0x802b34,%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	0f be c0             	movsbl %al,%eax
  800ea8:	83 ec 08             	sub    $0x8,%esp
  800eab:	ff 75 0c             	pushl  0xc(%ebp)
  800eae:	50                   	push   %eax
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	ff d0                	call   *%eax
  800eb4:	83 c4 10             	add    $0x10,%esp
}
  800eb7:	90                   	nop
  800eb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ebb:	c9                   	leave  
  800ebc:	c3                   	ret    

00800ebd <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ebd:	55                   	push   %ebp
  800ebe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ec0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ec4:	7e 1c                	jle    800ee2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	8b 00                	mov    (%eax),%eax
  800ecb:	8d 50 08             	lea    0x8(%eax),%edx
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	89 10                	mov    %edx,(%eax)
  800ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed6:	8b 00                	mov    (%eax),%eax
  800ed8:	83 e8 08             	sub    $0x8,%eax
  800edb:	8b 50 04             	mov    0x4(%eax),%edx
  800ede:	8b 00                	mov    (%eax),%eax
  800ee0:	eb 40                	jmp    800f22 <getuint+0x65>
	else if (lflag)
  800ee2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ee6:	74 1e                	je     800f06 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8b 00                	mov    (%eax),%eax
  800eed:	8d 50 04             	lea    0x4(%eax),%edx
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	89 10                	mov    %edx,(%eax)
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	8b 00                	mov    (%eax),%eax
  800efa:	83 e8 04             	sub    $0x4,%eax
  800efd:	8b 00                	mov    (%eax),%eax
  800eff:	ba 00 00 00 00       	mov    $0x0,%edx
  800f04:	eb 1c                	jmp    800f22 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8b 00                	mov    (%eax),%eax
  800f0b:	8d 50 04             	lea    0x4(%eax),%edx
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	89 10                	mov    %edx,(%eax)
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	8b 00                	mov    (%eax),%eax
  800f18:	83 e8 04             	sub    $0x4,%eax
  800f1b:	8b 00                	mov    (%eax),%eax
  800f1d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800f22:	5d                   	pop    %ebp
  800f23:	c3                   	ret    

00800f24 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800f24:	55                   	push   %ebp
  800f25:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800f27:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800f2b:	7e 1c                	jle    800f49 <getint+0x25>
		return va_arg(*ap, long long);
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8b 00                	mov    (%eax),%eax
  800f32:	8d 50 08             	lea    0x8(%eax),%edx
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	89 10                	mov    %edx,(%eax)
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8b 00                	mov    (%eax),%eax
  800f3f:	83 e8 08             	sub    $0x8,%eax
  800f42:	8b 50 04             	mov    0x4(%eax),%edx
  800f45:	8b 00                	mov    (%eax),%eax
  800f47:	eb 38                	jmp    800f81 <getint+0x5d>
	else if (lflag)
  800f49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f4d:	74 1a                	je     800f69 <getint+0x45>
		return va_arg(*ap, long);
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	8d 50 04             	lea    0x4(%eax),%edx
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	89 10                	mov    %edx,(%eax)
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8b 00                	mov    (%eax),%eax
  800f61:	83 e8 04             	sub    $0x4,%eax
  800f64:	8b 00                	mov    (%eax),%eax
  800f66:	99                   	cltd   
  800f67:	eb 18                	jmp    800f81 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	8d 50 04             	lea    0x4(%eax),%edx
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	89 10                	mov    %edx,(%eax)
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8b 00                	mov    (%eax),%eax
  800f7b:	83 e8 04             	sub    $0x4,%eax
  800f7e:	8b 00                	mov    (%eax),%eax
  800f80:	99                   	cltd   
}
  800f81:	5d                   	pop    %ebp
  800f82:	c3                   	ret    

00800f83 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
  800f86:	56                   	push   %esi
  800f87:	53                   	push   %ebx
  800f88:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f8b:	eb 17                	jmp    800fa4 <vprintfmt+0x21>
			if (ch == '\0')
  800f8d:	85 db                	test   %ebx,%ebx
  800f8f:	0f 84 af 03 00 00    	je     801344 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800f95:	83 ec 08             	sub    $0x8,%esp
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	53                   	push   %ebx
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	ff d0                	call   *%eax
  800fa1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800fa4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa7:	8d 50 01             	lea    0x1(%eax),%edx
  800faa:	89 55 10             	mov    %edx,0x10(%ebp)
  800fad:	8a 00                	mov    (%eax),%al
  800faf:	0f b6 d8             	movzbl %al,%ebx
  800fb2:	83 fb 25             	cmp    $0x25,%ebx
  800fb5:	75 d6                	jne    800f8d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800fb7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800fbb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800fc2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800fc9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800fd0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800fd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fda:	8d 50 01             	lea    0x1(%eax),%edx
  800fdd:	89 55 10             	mov    %edx,0x10(%ebp)
  800fe0:	8a 00                	mov    (%eax),%al
  800fe2:	0f b6 d8             	movzbl %al,%ebx
  800fe5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800fe8:	83 f8 55             	cmp    $0x55,%eax
  800feb:	0f 87 2b 03 00 00    	ja     80131c <vprintfmt+0x399>
  800ff1:	8b 04 85 58 2b 80 00 	mov    0x802b58(,%eax,4),%eax
  800ff8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ffa:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ffe:	eb d7                	jmp    800fd7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801000:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801004:	eb d1                	jmp    800fd7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801006:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80100d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801010:	89 d0                	mov    %edx,%eax
  801012:	c1 e0 02             	shl    $0x2,%eax
  801015:	01 d0                	add    %edx,%eax
  801017:	01 c0                	add    %eax,%eax
  801019:	01 d8                	add    %ebx,%eax
  80101b:	83 e8 30             	sub    $0x30,%eax
  80101e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801021:	8b 45 10             	mov    0x10(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801029:	83 fb 2f             	cmp    $0x2f,%ebx
  80102c:	7e 3e                	jle    80106c <vprintfmt+0xe9>
  80102e:	83 fb 39             	cmp    $0x39,%ebx
  801031:	7f 39                	jg     80106c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801033:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801036:	eb d5                	jmp    80100d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801038:	8b 45 14             	mov    0x14(%ebp),%eax
  80103b:	83 c0 04             	add    $0x4,%eax
  80103e:	89 45 14             	mov    %eax,0x14(%ebp)
  801041:	8b 45 14             	mov    0x14(%ebp),%eax
  801044:	83 e8 04             	sub    $0x4,%eax
  801047:	8b 00                	mov    (%eax),%eax
  801049:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80104c:	eb 1f                	jmp    80106d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80104e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801052:	79 83                	jns    800fd7 <vprintfmt+0x54>
				width = 0;
  801054:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80105b:	e9 77 ff ff ff       	jmp    800fd7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801060:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801067:	e9 6b ff ff ff       	jmp    800fd7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80106c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80106d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801071:	0f 89 60 ff ff ff    	jns    800fd7 <vprintfmt+0x54>
				width = precision, precision = -1;
  801077:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80107a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80107d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801084:	e9 4e ff ff ff       	jmp    800fd7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801089:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80108c:	e9 46 ff ff ff       	jmp    800fd7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801091:	8b 45 14             	mov    0x14(%ebp),%eax
  801094:	83 c0 04             	add    $0x4,%eax
  801097:	89 45 14             	mov    %eax,0x14(%ebp)
  80109a:	8b 45 14             	mov    0x14(%ebp),%eax
  80109d:	83 e8 04             	sub    $0x4,%eax
  8010a0:	8b 00                	mov    (%eax),%eax
  8010a2:	83 ec 08             	sub    $0x8,%esp
  8010a5:	ff 75 0c             	pushl  0xc(%ebp)
  8010a8:	50                   	push   %eax
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	ff d0                	call   *%eax
  8010ae:	83 c4 10             	add    $0x10,%esp
			break;
  8010b1:	e9 89 02 00 00       	jmp    80133f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8010b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b9:	83 c0 04             	add    $0x4,%eax
  8010bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8010bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8010c2:	83 e8 04             	sub    $0x4,%eax
  8010c5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8010c7:	85 db                	test   %ebx,%ebx
  8010c9:	79 02                	jns    8010cd <vprintfmt+0x14a>
				err = -err;
  8010cb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8010cd:	83 fb 64             	cmp    $0x64,%ebx
  8010d0:	7f 0b                	jg     8010dd <vprintfmt+0x15a>
  8010d2:	8b 34 9d a0 29 80 00 	mov    0x8029a0(,%ebx,4),%esi
  8010d9:	85 f6                	test   %esi,%esi
  8010db:	75 19                	jne    8010f6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8010dd:	53                   	push   %ebx
  8010de:	68 45 2b 80 00       	push   $0x802b45
  8010e3:	ff 75 0c             	pushl  0xc(%ebp)
  8010e6:	ff 75 08             	pushl  0x8(%ebp)
  8010e9:	e8 5e 02 00 00       	call   80134c <printfmt>
  8010ee:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8010f1:	e9 49 02 00 00       	jmp    80133f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8010f6:	56                   	push   %esi
  8010f7:	68 4e 2b 80 00       	push   $0x802b4e
  8010fc:	ff 75 0c             	pushl  0xc(%ebp)
  8010ff:	ff 75 08             	pushl  0x8(%ebp)
  801102:	e8 45 02 00 00       	call   80134c <printfmt>
  801107:	83 c4 10             	add    $0x10,%esp
			break;
  80110a:	e9 30 02 00 00       	jmp    80133f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80110f:	8b 45 14             	mov    0x14(%ebp),%eax
  801112:	83 c0 04             	add    $0x4,%eax
  801115:	89 45 14             	mov    %eax,0x14(%ebp)
  801118:	8b 45 14             	mov    0x14(%ebp),%eax
  80111b:	83 e8 04             	sub    $0x4,%eax
  80111e:	8b 30                	mov    (%eax),%esi
  801120:	85 f6                	test   %esi,%esi
  801122:	75 05                	jne    801129 <vprintfmt+0x1a6>
				p = "(null)";
  801124:	be 51 2b 80 00       	mov    $0x802b51,%esi
			if (width > 0 && padc != '-')
  801129:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80112d:	7e 6d                	jle    80119c <vprintfmt+0x219>
  80112f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801133:	74 67                	je     80119c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801135:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801138:	83 ec 08             	sub    $0x8,%esp
  80113b:	50                   	push   %eax
  80113c:	56                   	push   %esi
  80113d:	e8 0c 03 00 00       	call   80144e <strnlen>
  801142:	83 c4 10             	add    $0x10,%esp
  801145:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801148:	eb 16                	jmp    801160 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80114a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80114e:	83 ec 08             	sub    $0x8,%esp
  801151:	ff 75 0c             	pushl  0xc(%ebp)
  801154:	50                   	push   %eax
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	ff d0                	call   *%eax
  80115a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80115d:	ff 4d e4             	decl   -0x1c(%ebp)
  801160:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801164:	7f e4                	jg     80114a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801166:	eb 34                	jmp    80119c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801168:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80116c:	74 1c                	je     80118a <vprintfmt+0x207>
  80116e:	83 fb 1f             	cmp    $0x1f,%ebx
  801171:	7e 05                	jle    801178 <vprintfmt+0x1f5>
  801173:	83 fb 7e             	cmp    $0x7e,%ebx
  801176:	7e 12                	jle    80118a <vprintfmt+0x207>
					putch('?', putdat);
  801178:	83 ec 08             	sub    $0x8,%esp
  80117b:	ff 75 0c             	pushl  0xc(%ebp)
  80117e:	6a 3f                	push   $0x3f
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	ff d0                	call   *%eax
  801185:	83 c4 10             	add    $0x10,%esp
  801188:	eb 0f                	jmp    801199 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80118a:	83 ec 08             	sub    $0x8,%esp
  80118d:	ff 75 0c             	pushl  0xc(%ebp)
  801190:	53                   	push   %ebx
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	ff d0                	call   *%eax
  801196:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801199:	ff 4d e4             	decl   -0x1c(%ebp)
  80119c:	89 f0                	mov    %esi,%eax
  80119e:	8d 70 01             	lea    0x1(%eax),%esi
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	0f be d8             	movsbl %al,%ebx
  8011a6:	85 db                	test   %ebx,%ebx
  8011a8:	74 24                	je     8011ce <vprintfmt+0x24b>
  8011aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011ae:	78 b8                	js     801168 <vprintfmt+0x1e5>
  8011b0:	ff 4d e0             	decl   -0x20(%ebp)
  8011b3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011b7:	79 af                	jns    801168 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011b9:	eb 13                	jmp    8011ce <vprintfmt+0x24b>
				putch(' ', putdat);
  8011bb:	83 ec 08             	sub    $0x8,%esp
  8011be:	ff 75 0c             	pushl  0xc(%ebp)
  8011c1:	6a 20                	push   $0x20
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	ff d0                	call   *%eax
  8011c8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011cb:	ff 4d e4             	decl   -0x1c(%ebp)
  8011ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011d2:	7f e7                	jg     8011bb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8011d4:	e9 66 01 00 00       	jmp    80133f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8011d9:	83 ec 08             	sub    $0x8,%esp
  8011dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8011df:	8d 45 14             	lea    0x14(%ebp),%eax
  8011e2:	50                   	push   %eax
  8011e3:	e8 3c fd ff ff       	call   800f24 <getint>
  8011e8:	83 c4 10             	add    $0x10,%esp
  8011eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8011f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011f7:	85 d2                	test   %edx,%edx
  8011f9:	79 23                	jns    80121e <vprintfmt+0x29b>
				putch('-', putdat);
  8011fb:	83 ec 08             	sub    $0x8,%esp
  8011fe:	ff 75 0c             	pushl  0xc(%ebp)
  801201:	6a 2d                	push   $0x2d
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	ff d0                	call   *%eax
  801208:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80120b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80120e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801211:	f7 d8                	neg    %eax
  801213:	83 d2 00             	adc    $0x0,%edx
  801216:	f7 da                	neg    %edx
  801218:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80121b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80121e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801225:	e9 bc 00 00 00       	jmp    8012e6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80122a:	83 ec 08             	sub    $0x8,%esp
  80122d:	ff 75 e8             	pushl  -0x18(%ebp)
  801230:	8d 45 14             	lea    0x14(%ebp),%eax
  801233:	50                   	push   %eax
  801234:	e8 84 fc ff ff       	call   800ebd <getuint>
  801239:	83 c4 10             	add    $0x10,%esp
  80123c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80123f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801242:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801249:	e9 98 00 00 00       	jmp    8012e6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80124e:	83 ec 08             	sub    $0x8,%esp
  801251:	ff 75 0c             	pushl  0xc(%ebp)
  801254:	6a 58                	push   $0x58
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	ff d0                	call   *%eax
  80125b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80125e:	83 ec 08             	sub    $0x8,%esp
  801261:	ff 75 0c             	pushl  0xc(%ebp)
  801264:	6a 58                	push   $0x58
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	ff d0                	call   *%eax
  80126b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80126e:	83 ec 08             	sub    $0x8,%esp
  801271:	ff 75 0c             	pushl  0xc(%ebp)
  801274:	6a 58                	push   $0x58
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	ff d0                	call   *%eax
  80127b:	83 c4 10             	add    $0x10,%esp
			break;
  80127e:	e9 bc 00 00 00       	jmp    80133f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801283:	83 ec 08             	sub    $0x8,%esp
  801286:	ff 75 0c             	pushl  0xc(%ebp)
  801289:	6a 30                	push   $0x30
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	ff d0                	call   *%eax
  801290:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801293:	83 ec 08             	sub    $0x8,%esp
  801296:	ff 75 0c             	pushl  0xc(%ebp)
  801299:	6a 78                	push   $0x78
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	ff d0                	call   *%eax
  8012a0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8012a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a6:	83 c0 04             	add    $0x4,%eax
  8012a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8012ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8012af:	83 e8 04             	sub    $0x4,%eax
  8012b2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8012b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8012be:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8012c5:	eb 1f                	jmp    8012e6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8012c7:	83 ec 08             	sub    $0x8,%esp
  8012ca:	ff 75 e8             	pushl  -0x18(%ebp)
  8012cd:	8d 45 14             	lea    0x14(%ebp),%eax
  8012d0:	50                   	push   %eax
  8012d1:	e8 e7 fb ff ff       	call   800ebd <getuint>
  8012d6:	83 c4 10             	add    $0x10,%esp
  8012d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8012df:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8012e6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8012ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012ed:	83 ec 04             	sub    $0x4,%esp
  8012f0:	52                   	push   %edx
  8012f1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012f4:	50                   	push   %eax
  8012f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8012f8:	ff 75 f0             	pushl  -0x10(%ebp)
  8012fb:	ff 75 0c             	pushl  0xc(%ebp)
  8012fe:	ff 75 08             	pushl  0x8(%ebp)
  801301:	e8 00 fb ff ff       	call   800e06 <printnum>
  801306:	83 c4 20             	add    $0x20,%esp
			break;
  801309:	eb 34                	jmp    80133f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80130b:	83 ec 08             	sub    $0x8,%esp
  80130e:	ff 75 0c             	pushl  0xc(%ebp)
  801311:	53                   	push   %ebx
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	ff d0                	call   *%eax
  801317:	83 c4 10             	add    $0x10,%esp
			break;
  80131a:	eb 23                	jmp    80133f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80131c:	83 ec 08             	sub    $0x8,%esp
  80131f:	ff 75 0c             	pushl  0xc(%ebp)
  801322:	6a 25                	push   $0x25
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	ff d0                	call   *%eax
  801329:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80132c:	ff 4d 10             	decl   0x10(%ebp)
  80132f:	eb 03                	jmp    801334 <vprintfmt+0x3b1>
  801331:	ff 4d 10             	decl   0x10(%ebp)
  801334:	8b 45 10             	mov    0x10(%ebp),%eax
  801337:	48                   	dec    %eax
  801338:	8a 00                	mov    (%eax),%al
  80133a:	3c 25                	cmp    $0x25,%al
  80133c:	75 f3                	jne    801331 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80133e:	90                   	nop
		}
	}
  80133f:	e9 47 fc ff ff       	jmp    800f8b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801344:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801345:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801348:	5b                   	pop    %ebx
  801349:	5e                   	pop    %esi
  80134a:	5d                   	pop    %ebp
  80134b:	c3                   	ret    

0080134c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
  80134f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801352:	8d 45 10             	lea    0x10(%ebp),%eax
  801355:	83 c0 04             	add    $0x4,%eax
  801358:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80135b:	8b 45 10             	mov    0x10(%ebp),%eax
  80135e:	ff 75 f4             	pushl  -0xc(%ebp)
  801361:	50                   	push   %eax
  801362:	ff 75 0c             	pushl  0xc(%ebp)
  801365:	ff 75 08             	pushl  0x8(%ebp)
  801368:	e8 16 fc ff ff       	call   800f83 <vprintfmt>
  80136d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801370:	90                   	nop
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801376:	8b 45 0c             	mov    0xc(%ebp),%eax
  801379:	8b 40 08             	mov    0x8(%eax),%eax
  80137c:	8d 50 01             	lea    0x1(%eax),%edx
  80137f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801382:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801385:	8b 45 0c             	mov    0xc(%ebp),%eax
  801388:	8b 10                	mov    (%eax),%edx
  80138a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138d:	8b 40 04             	mov    0x4(%eax),%eax
  801390:	39 c2                	cmp    %eax,%edx
  801392:	73 12                	jae    8013a6 <sprintputch+0x33>
		*b->buf++ = ch;
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	8b 00                	mov    (%eax),%eax
  801399:	8d 48 01             	lea    0x1(%eax),%ecx
  80139c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139f:	89 0a                	mov    %ecx,(%edx)
  8013a1:	8b 55 08             	mov    0x8(%ebp),%edx
  8013a4:	88 10                	mov    %dl,(%eax)
}
  8013a6:	90                   	nop
  8013a7:	5d                   	pop    %ebp
  8013a8:	c3                   	ret    

008013a9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8013a9:	55                   	push   %ebp
  8013aa:	89 e5                	mov    %esp,%ebp
  8013ac:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	01 d0                	add    %edx,%eax
  8013c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8013ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013ce:	74 06                	je     8013d6 <vsnprintf+0x2d>
  8013d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013d4:	7f 07                	jg     8013dd <vsnprintf+0x34>
		return -E_INVAL;
  8013d6:	b8 03 00 00 00       	mov    $0x3,%eax
  8013db:	eb 20                	jmp    8013fd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8013dd:	ff 75 14             	pushl  0x14(%ebp)
  8013e0:	ff 75 10             	pushl  0x10(%ebp)
  8013e3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8013e6:	50                   	push   %eax
  8013e7:	68 73 13 80 00       	push   $0x801373
  8013ec:	e8 92 fb ff ff       	call   800f83 <vprintfmt>
  8013f1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8013f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013f7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8013fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
  801402:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801405:	8d 45 10             	lea    0x10(%ebp),%eax
  801408:	83 c0 04             	add    $0x4,%eax
  80140b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80140e:	8b 45 10             	mov    0x10(%ebp),%eax
  801411:	ff 75 f4             	pushl  -0xc(%ebp)
  801414:	50                   	push   %eax
  801415:	ff 75 0c             	pushl  0xc(%ebp)
  801418:	ff 75 08             	pushl  0x8(%ebp)
  80141b:	e8 89 ff ff ff       	call   8013a9 <vsnprintf>
  801420:	83 c4 10             	add    $0x10,%esp
  801423:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801426:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801429:	c9                   	leave  
  80142a:	c3                   	ret    

0080142b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80142b:	55                   	push   %ebp
  80142c:	89 e5                	mov    %esp,%ebp
  80142e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801438:	eb 06                	jmp    801440 <strlen+0x15>
		n++;
  80143a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80143d:	ff 45 08             	incl   0x8(%ebp)
  801440:	8b 45 08             	mov    0x8(%ebp),%eax
  801443:	8a 00                	mov    (%eax),%al
  801445:	84 c0                	test   %al,%al
  801447:	75 f1                	jne    80143a <strlen+0xf>
		n++;
	return n;
  801449:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
  801451:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801454:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80145b:	eb 09                	jmp    801466 <strnlen+0x18>
		n++;
  80145d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801460:	ff 45 08             	incl   0x8(%ebp)
  801463:	ff 4d 0c             	decl   0xc(%ebp)
  801466:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80146a:	74 09                	je     801475 <strnlen+0x27>
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	84 c0                	test   %al,%al
  801473:	75 e8                	jne    80145d <strnlen+0xf>
		n++;
	return n;
  801475:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801486:	90                   	nop
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	8d 50 01             	lea    0x1(%eax),%edx
  80148d:	89 55 08             	mov    %edx,0x8(%ebp)
  801490:	8b 55 0c             	mov    0xc(%ebp),%edx
  801493:	8d 4a 01             	lea    0x1(%edx),%ecx
  801496:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801499:	8a 12                	mov    (%edx),%dl
  80149b:	88 10                	mov    %dl,(%eax)
  80149d:	8a 00                	mov    (%eax),%al
  80149f:	84 c0                	test   %al,%al
  8014a1:	75 e4                	jne    801487 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014bb:	eb 1f                	jmp    8014dc <strncpy+0x34>
		*dst++ = *src;
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	8d 50 01             	lea    0x1(%eax),%edx
  8014c3:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c9:	8a 12                	mov    (%edx),%dl
  8014cb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	84 c0                	test   %al,%al
  8014d4:	74 03                	je     8014d9 <strncpy+0x31>
			src++;
  8014d6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014d9:	ff 45 fc             	incl   -0x4(%ebp)
  8014dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014df:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014e2:	72 d9                	jb     8014bd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f9:	74 30                	je     80152b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014fb:	eb 16                	jmp    801513 <strlcpy+0x2a>
			*dst++ = *src++;
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	8d 50 01             	lea    0x1(%eax),%edx
  801503:	89 55 08             	mov    %edx,0x8(%ebp)
  801506:	8b 55 0c             	mov    0xc(%ebp),%edx
  801509:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80150f:	8a 12                	mov    (%edx),%dl
  801511:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801513:	ff 4d 10             	decl   0x10(%ebp)
  801516:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80151a:	74 09                	je     801525 <strlcpy+0x3c>
  80151c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151f:	8a 00                	mov    (%eax),%al
  801521:	84 c0                	test   %al,%al
  801523:	75 d8                	jne    8014fd <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801525:	8b 45 08             	mov    0x8(%ebp),%eax
  801528:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80152b:	8b 55 08             	mov    0x8(%ebp),%edx
  80152e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801531:	29 c2                	sub    %eax,%edx
  801533:	89 d0                	mov    %edx,%eax
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80153a:	eb 06                	jmp    801542 <strcmp+0xb>
		p++, q++;
  80153c:	ff 45 08             	incl   0x8(%ebp)
  80153f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	84 c0                	test   %al,%al
  801549:	74 0e                	je     801559 <strcmp+0x22>
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 10                	mov    (%eax),%dl
  801550:	8b 45 0c             	mov    0xc(%ebp),%eax
  801553:	8a 00                	mov    (%eax),%al
  801555:	38 c2                	cmp    %al,%dl
  801557:	74 e3                	je     80153c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	0f b6 d0             	movzbl %al,%edx
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	8a 00                	mov    (%eax),%al
  801566:	0f b6 c0             	movzbl %al,%eax
  801569:	29 c2                	sub    %eax,%edx
  80156b:	89 d0                	mov    %edx,%eax
}
  80156d:	5d                   	pop    %ebp
  80156e:	c3                   	ret    

0080156f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801572:	eb 09                	jmp    80157d <strncmp+0xe>
		n--, p++, q++;
  801574:	ff 4d 10             	decl   0x10(%ebp)
  801577:	ff 45 08             	incl   0x8(%ebp)
  80157a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80157d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801581:	74 17                	je     80159a <strncmp+0x2b>
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	8a 00                	mov    (%eax),%al
  801588:	84 c0                	test   %al,%al
  80158a:	74 0e                	je     80159a <strncmp+0x2b>
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 10                	mov    (%eax),%dl
  801591:	8b 45 0c             	mov    0xc(%ebp),%eax
  801594:	8a 00                	mov    (%eax),%al
  801596:	38 c2                	cmp    %al,%dl
  801598:	74 da                	je     801574 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80159a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159e:	75 07                	jne    8015a7 <strncmp+0x38>
		return 0;
  8015a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8015a5:	eb 14                	jmp    8015bb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	8a 00                	mov    (%eax),%al
  8015ac:	0f b6 d0             	movzbl %al,%edx
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	8a 00                	mov    (%eax),%al
  8015b4:	0f b6 c0             	movzbl %al,%eax
  8015b7:	29 c2                	sub    %eax,%edx
  8015b9:	89 d0                	mov    %edx,%eax
}
  8015bb:	5d                   	pop    %ebp
  8015bc:	c3                   	ret    

008015bd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 04             	sub    $0x4,%esp
  8015c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015c9:	eb 12                	jmp    8015dd <strchr+0x20>
		if (*s == c)
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015d3:	75 05                	jne    8015da <strchr+0x1d>
			return (char *) s;
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	eb 11                	jmp    8015eb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015da:	ff 45 08             	incl   0x8(%ebp)
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	8a 00                	mov    (%eax),%al
  8015e2:	84 c0                	test   %al,%al
  8015e4:	75 e5                	jne    8015cb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015eb:	c9                   	leave  
  8015ec:	c3                   	ret    

008015ed <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015ed:	55                   	push   %ebp
  8015ee:	89 e5                	mov    %esp,%ebp
  8015f0:	83 ec 04             	sub    $0x4,%esp
  8015f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015f9:	eb 0d                	jmp    801608 <strfind+0x1b>
		if (*s == c)
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	8a 00                	mov    (%eax),%al
  801600:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801603:	74 0e                	je     801613 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801605:	ff 45 08             	incl   0x8(%ebp)
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	8a 00                	mov    (%eax),%al
  80160d:	84 c0                	test   %al,%al
  80160f:	75 ea                	jne    8015fb <strfind+0xe>
  801611:	eb 01                	jmp    801614 <strfind+0x27>
		if (*s == c)
			break;
  801613:	90                   	nop
	return (char *) s;
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801625:	8b 45 10             	mov    0x10(%ebp),%eax
  801628:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80162b:	eb 0e                	jmp    80163b <memset+0x22>
		*p++ = c;
  80162d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801630:	8d 50 01             	lea    0x1(%eax),%edx
  801633:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801636:	8b 55 0c             	mov    0xc(%ebp),%edx
  801639:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80163b:	ff 4d f8             	decl   -0x8(%ebp)
  80163e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801642:	79 e9                	jns    80162d <memset+0x14>
		*p++ = c;

	return v;
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801647:	c9                   	leave  
  801648:	c3                   	ret    

00801649 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801649:	55                   	push   %ebp
  80164a:	89 e5                	mov    %esp,%ebp
  80164c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80164f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801652:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80165b:	eb 16                	jmp    801673 <memcpy+0x2a>
		*d++ = *s++;
  80165d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801660:	8d 50 01             	lea    0x1(%eax),%edx
  801663:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801666:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801669:	8d 4a 01             	lea    0x1(%edx),%ecx
  80166c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80166f:	8a 12                	mov    (%edx),%dl
  801671:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801673:	8b 45 10             	mov    0x10(%ebp),%eax
  801676:	8d 50 ff             	lea    -0x1(%eax),%edx
  801679:	89 55 10             	mov    %edx,0x10(%ebp)
  80167c:	85 c0                	test   %eax,%eax
  80167e:	75 dd                	jne    80165d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801683:	c9                   	leave  
  801684:	c3                   	ret    

00801685 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801685:	55                   	push   %ebp
  801686:	89 e5                	mov    %esp,%ebp
  801688:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80168b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801697:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80169a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80169d:	73 50                	jae    8016ef <memmove+0x6a>
  80169f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a5:	01 d0                	add    %edx,%eax
  8016a7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016aa:	76 43                	jbe    8016ef <memmove+0x6a>
		s += n;
  8016ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8016af:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016b8:	eb 10                	jmp    8016ca <memmove+0x45>
			*--d = *--s;
  8016ba:	ff 4d f8             	decl   -0x8(%ebp)
  8016bd:	ff 4d fc             	decl   -0x4(%ebp)
  8016c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c3:	8a 10                	mov    (%eax),%dl
  8016c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d0:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d3:	85 c0                	test   %eax,%eax
  8016d5:	75 e3                	jne    8016ba <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016d7:	eb 23                	jmp    8016fc <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016dc:	8d 50 01             	lea    0x1(%eax),%edx
  8016df:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016e5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016e8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016eb:	8a 12                	mov    (%edx),%dl
  8016ed:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8016f8:	85 c0                	test   %eax,%eax
  8016fa:	75 dd                	jne    8016d9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
  801704:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80170d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801710:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801713:	eb 2a                	jmp    80173f <memcmp+0x3e>
		if (*s1 != *s2)
  801715:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801718:	8a 10                	mov    (%eax),%dl
  80171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	38 c2                	cmp    %al,%dl
  801721:	74 16                	je     801739 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801723:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801726:	8a 00                	mov    (%eax),%al
  801728:	0f b6 d0             	movzbl %al,%edx
  80172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172e:	8a 00                	mov    (%eax),%al
  801730:	0f b6 c0             	movzbl %al,%eax
  801733:	29 c2                	sub    %eax,%edx
  801735:	89 d0                	mov    %edx,%eax
  801737:	eb 18                	jmp    801751 <memcmp+0x50>
		s1++, s2++;
  801739:	ff 45 fc             	incl   -0x4(%ebp)
  80173c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80173f:	8b 45 10             	mov    0x10(%ebp),%eax
  801742:	8d 50 ff             	lea    -0x1(%eax),%edx
  801745:	89 55 10             	mov    %edx,0x10(%ebp)
  801748:	85 c0                	test   %eax,%eax
  80174a:	75 c9                	jne    801715 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80174c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
  801756:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801759:	8b 55 08             	mov    0x8(%ebp),%edx
  80175c:	8b 45 10             	mov    0x10(%ebp),%eax
  80175f:	01 d0                	add    %edx,%eax
  801761:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801764:	eb 15                	jmp    80177b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	8a 00                	mov    (%eax),%al
  80176b:	0f b6 d0             	movzbl %al,%edx
  80176e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801771:	0f b6 c0             	movzbl %al,%eax
  801774:	39 c2                	cmp    %eax,%edx
  801776:	74 0d                	je     801785 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801778:	ff 45 08             	incl   0x8(%ebp)
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801781:	72 e3                	jb     801766 <memfind+0x13>
  801783:	eb 01                	jmp    801786 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801785:	90                   	nop
	return (void *) s;
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801789:	c9                   	leave  
  80178a:	c3                   	ret    

0080178b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80178b:	55                   	push   %ebp
  80178c:	89 e5                	mov    %esp,%ebp
  80178e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801791:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801798:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80179f:	eb 03                	jmp    8017a4 <strtol+0x19>
		s++;
  8017a1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a7:	8a 00                	mov    (%eax),%al
  8017a9:	3c 20                	cmp    $0x20,%al
  8017ab:	74 f4                	je     8017a1 <strtol+0x16>
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	8a 00                	mov    (%eax),%al
  8017b2:	3c 09                	cmp    $0x9,%al
  8017b4:	74 eb                	je     8017a1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	8a 00                	mov    (%eax),%al
  8017bb:	3c 2b                	cmp    $0x2b,%al
  8017bd:	75 05                	jne    8017c4 <strtol+0x39>
		s++;
  8017bf:	ff 45 08             	incl   0x8(%ebp)
  8017c2:	eb 13                	jmp    8017d7 <strtol+0x4c>
	else if (*s == '-')
  8017c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c7:	8a 00                	mov    (%eax),%al
  8017c9:	3c 2d                	cmp    $0x2d,%al
  8017cb:	75 0a                	jne    8017d7 <strtol+0x4c>
		s++, neg = 1;
  8017cd:	ff 45 08             	incl   0x8(%ebp)
  8017d0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017db:	74 06                	je     8017e3 <strtol+0x58>
  8017dd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017e1:	75 20                	jne    801803 <strtol+0x78>
  8017e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e6:	8a 00                	mov    (%eax),%al
  8017e8:	3c 30                	cmp    $0x30,%al
  8017ea:	75 17                	jne    801803 <strtol+0x78>
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	40                   	inc    %eax
  8017f0:	8a 00                	mov    (%eax),%al
  8017f2:	3c 78                	cmp    $0x78,%al
  8017f4:	75 0d                	jne    801803 <strtol+0x78>
		s += 2, base = 16;
  8017f6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017fa:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801801:	eb 28                	jmp    80182b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801803:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801807:	75 15                	jne    80181e <strtol+0x93>
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	8a 00                	mov    (%eax),%al
  80180e:	3c 30                	cmp    $0x30,%al
  801810:	75 0c                	jne    80181e <strtol+0x93>
		s++, base = 8;
  801812:	ff 45 08             	incl   0x8(%ebp)
  801815:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80181c:	eb 0d                	jmp    80182b <strtol+0xa0>
	else if (base == 0)
  80181e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801822:	75 07                	jne    80182b <strtol+0xa0>
		base = 10;
  801824:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	8a 00                	mov    (%eax),%al
  801830:	3c 2f                	cmp    $0x2f,%al
  801832:	7e 19                	jle    80184d <strtol+0xc2>
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8a 00                	mov    (%eax),%al
  801839:	3c 39                	cmp    $0x39,%al
  80183b:	7f 10                	jg     80184d <strtol+0xc2>
			dig = *s - '0';
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	8a 00                	mov    (%eax),%al
  801842:	0f be c0             	movsbl %al,%eax
  801845:	83 e8 30             	sub    $0x30,%eax
  801848:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184b:	eb 42                	jmp    80188f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80184d:	8b 45 08             	mov    0x8(%ebp),%eax
  801850:	8a 00                	mov    (%eax),%al
  801852:	3c 60                	cmp    $0x60,%al
  801854:	7e 19                	jle    80186f <strtol+0xe4>
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	3c 7a                	cmp    $0x7a,%al
  80185d:	7f 10                	jg     80186f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80185f:	8b 45 08             	mov    0x8(%ebp),%eax
  801862:	8a 00                	mov    (%eax),%al
  801864:	0f be c0             	movsbl %al,%eax
  801867:	83 e8 57             	sub    $0x57,%eax
  80186a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80186d:	eb 20                	jmp    80188f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	8a 00                	mov    (%eax),%al
  801874:	3c 40                	cmp    $0x40,%al
  801876:	7e 39                	jle    8018b1 <strtol+0x126>
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	8a 00                	mov    (%eax),%al
  80187d:	3c 5a                	cmp    $0x5a,%al
  80187f:	7f 30                	jg     8018b1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	0f be c0             	movsbl %al,%eax
  801889:	83 e8 37             	sub    $0x37,%eax
  80188c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80188f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801892:	3b 45 10             	cmp    0x10(%ebp),%eax
  801895:	7d 19                	jge    8018b0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801897:	ff 45 08             	incl   0x8(%ebp)
  80189a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189d:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018a1:	89 c2                	mov    %eax,%edx
  8018a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018a6:	01 d0                	add    %edx,%eax
  8018a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018ab:	e9 7b ff ff ff       	jmp    80182b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018b0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018b5:	74 08                	je     8018bf <strtol+0x134>
		*endptr = (char *) s;
  8018b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8018bd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018c3:	74 07                	je     8018cc <strtol+0x141>
  8018c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c8:	f7 d8                	neg    %eax
  8018ca:	eb 03                	jmp    8018cf <strtol+0x144>
  8018cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <ltostr>:

void
ltostr(long value, char *str)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
  8018d4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018e9:	79 13                	jns    8018fe <ltostr+0x2d>
	{
		neg = 1;
  8018eb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018f8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018fb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801906:	99                   	cltd   
  801907:	f7 f9                	idiv   %ecx
  801909:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80190c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80190f:	8d 50 01             	lea    0x1(%eax),%edx
  801912:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801915:	89 c2                	mov    %eax,%edx
  801917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80191a:	01 d0                	add    %edx,%eax
  80191c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80191f:	83 c2 30             	add    $0x30,%edx
  801922:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801924:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801927:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80192c:	f7 e9                	imul   %ecx
  80192e:	c1 fa 02             	sar    $0x2,%edx
  801931:	89 c8                	mov    %ecx,%eax
  801933:	c1 f8 1f             	sar    $0x1f,%eax
  801936:	29 c2                	sub    %eax,%edx
  801938:	89 d0                	mov    %edx,%eax
  80193a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80193d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801940:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801945:	f7 e9                	imul   %ecx
  801947:	c1 fa 02             	sar    $0x2,%edx
  80194a:	89 c8                	mov    %ecx,%eax
  80194c:	c1 f8 1f             	sar    $0x1f,%eax
  80194f:	29 c2                	sub    %eax,%edx
  801951:	89 d0                	mov    %edx,%eax
  801953:	c1 e0 02             	shl    $0x2,%eax
  801956:	01 d0                	add    %edx,%eax
  801958:	01 c0                	add    %eax,%eax
  80195a:	29 c1                	sub    %eax,%ecx
  80195c:	89 ca                	mov    %ecx,%edx
  80195e:	85 d2                	test   %edx,%edx
  801960:	75 9c                	jne    8018fe <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801962:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801969:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80196c:	48                   	dec    %eax
  80196d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801970:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801974:	74 3d                	je     8019b3 <ltostr+0xe2>
		start = 1 ;
  801976:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80197d:	eb 34                	jmp    8019b3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80197f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801982:	8b 45 0c             	mov    0xc(%ebp),%eax
  801985:	01 d0                	add    %edx,%eax
  801987:	8a 00                	mov    (%eax),%al
  801989:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80198c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80198f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801992:	01 c2                	add    %eax,%edx
  801994:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199a:	01 c8                	add    %ecx,%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8019a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a6:	01 c2                	add    %eax,%edx
  8019a8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8019ab:	88 02                	mov    %al,(%edx)
		start++ ;
  8019ad:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019b0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019b9:	7c c4                	jl     80197f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c1:	01 d0                	add    %edx,%eax
  8019c3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019c6:	90                   	nop
  8019c7:	c9                   	leave  
  8019c8:	c3                   	ret    

008019c9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019c9:	55                   	push   %ebp
  8019ca:	89 e5                	mov    %esp,%ebp
  8019cc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019cf:	ff 75 08             	pushl  0x8(%ebp)
  8019d2:	e8 54 fa ff ff       	call   80142b <strlen>
  8019d7:	83 c4 04             	add    $0x4,%esp
  8019da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019dd:	ff 75 0c             	pushl  0xc(%ebp)
  8019e0:	e8 46 fa ff ff       	call   80142b <strlen>
  8019e5:	83 c4 04             	add    $0x4,%esp
  8019e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019f9:	eb 17                	jmp    801a12 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801a01:	01 c2                	add    %eax,%edx
  801a03:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a06:	8b 45 08             	mov    0x8(%ebp),%eax
  801a09:	01 c8                	add    %ecx,%eax
  801a0b:	8a 00                	mov    (%eax),%al
  801a0d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a0f:	ff 45 fc             	incl   -0x4(%ebp)
  801a12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a15:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a18:	7c e1                	jl     8019fb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a1a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a21:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a28:	eb 1f                	jmp    801a49 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a2d:	8d 50 01             	lea    0x1(%eax),%edx
  801a30:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a33:	89 c2                	mov    %eax,%edx
  801a35:	8b 45 10             	mov    0x10(%ebp),%eax
  801a38:	01 c2                	add    %eax,%edx
  801a3a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a40:	01 c8                	add    %ecx,%eax
  801a42:	8a 00                	mov    (%eax),%al
  801a44:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a46:	ff 45 f8             	incl   -0x8(%ebp)
  801a49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a4c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a4f:	7c d9                	jl     801a2a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a51:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a54:	8b 45 10             	mov    0x10(%ebp),%eax
  801a57:	01 d0                	add    %edx,%eax
  801a59:	c6 00 00             	movb   $0x0,(%eax)
}
  801a5c:	90                   	nop
  801a5d:	c9                   	leave  
  801a5e:	c3                   	ret    

00801a5f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a5f:	55                   	push   %ebp
  801a60:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a62:	8b 45 14             	mov    0x14(%ebp),%eax
  801a65:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6e:	8b 00                	mov    (%eax),%eax
  801a70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a77:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7a:	01 d0                	add    %edx,%eax
  801a7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a82:	eb 0c                	jmp    801a90 <strsplit+0x31>
			*string++ = 0;
  801a84:	8b 45 08             	mov    0x8(%ebp),%eax
  801a87:	8d 50 01             	lea    0x1(%eax),%edx
  801a8a:	89 55 08             	mov    %edx,0x8(%ebp)
  801a8d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	84 c0                	test   %al,%al
  801a97:	74 18                	je     801ab1 <strsplit+0x52>
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	8a 00                	mov    (%eax),%al
  801a9e:	0f be c0             	movsbl %al,%eax
  801aa1:	50                   	push   %eax
  801aa2:	ff 75 0c             	pushl  0xc(%ebp)
  801aa5:	e8 13 fb ff ff       	call   8015bd <strchr>
  801aaa:	83 c4 08             	add    $0x8,%esp
  801aad:	85 c0                	test   %eax,%eax
  801aaf:	75 d3                	jne    801a84 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab4:	8a 00                	mov    (%eax),%al
  801ab6:	84 c0                	test   %al,%al
  801ab8:	74 5a                	je     801b14 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801aba:	8b 45 14             	mov    0x14(%ebp),%eax
  801abd:	8b 00                	mov    (%eax),%eax
  801abf:	83 f8 0f             	cmp    $0xf,%eax
  801ac2:	75 07                	jne    801acb <strsplit+0x6c>
		{
			return 0;
  801ac4:	b8 00 00 00 00       	mov    $0x0,%eax
  801ac9:	eb 66                	jmp    801b31 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801acb:	8b 45 14             	mov    0x14(%ebp),%eax
  801ace:	8b 00                	mov    (%eax),%eax
  801ad0:	8d 48 01             	lea    0x1(%eax),%ecx
  801ad3:	8b 55 14             	mov    0x14(%ebp),%edx
  801ad6:	89 0a                	mov    %ecx,(%edx)
  801ad8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801adf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae2:	01 c2                	add    %eax,%edx
  801ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ae9:	eb 03                	jmp    801aee <strsplit+0x8f>
			string++;
  801aeb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aee:	8b 45 08             	mov    0x8(%ebp),%eax
  801af1:	8a 00                	mov    (%eax),%al
  801af3:	84 c0                	test   %al,%al
  801af5:	74 8b                	je     801a82 <strsplit+0x23>
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	8a 00                	mov    (%eax),%al
  801afc:	0f be c0             	movsbl %al,%eax
  801aff:	50                   	push   %eax
  801b00:	ff 75 0c             	pushl  0xc(%ebp)
  801b03:	e8 b5 fa ff ff       	call   8015bd <strchr>
  801b08:	83 c4 08             	add    $0x8,%esp
  801b0b:	85 c0                	test   %eax,%eax
  801b0d:	74 dc                	je     801aeb <strsplit+0x8c>
			string++;
	}
  801b0f:	e9 6e ff ff ff       	jmp    801a82 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b14:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b15:	8b 45 14             	mov    0x14(%ebp),%eax
  801b18:	8b 00                	mov    (%eax),%eax
  801b1a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b21:	8b 45 10             	mov    0x10(%ebp),%eax
  801b24:	01 d0                	add    %edx,%eax
  801b26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b2c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
  801b36:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801b39:	e8 9b 07 00 00       	call   8022d9 <sys_isUHeapPlacementStrategyNEXTFIT>
  801b3e:	85 c0                	test   %eax,%eax
  801b40:	0f 84 64 01 00 00    	je     801caa <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801b46:	8b 0d 28 30 80 00    	mov    0x803028,%ecx
  801b4c:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801b53:	8b 55 08             	mov    0x8(%ebp),%edx
  801b56:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b59:	01 d0                	add    %edx,%eax
  801b5b:	48                   	dec    %eax
  801b5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b62:	ba 00 00 00 00       	mov    $0x0,%edx
  801b67:	f7 75 e8             	divl   -0x18(%ebp)
  801b6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b6d:	29 d0                	sub    %edx,%eax
  801b6f:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801b76:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7f:	01 d0                	add    %edx,%eax
  801b81:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801b84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801b8b:	a1 28 30 80 00       	mov    0x803028,%eax
  801b90:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b97:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b9a:	0f 83 0a 01 00 00    	jae    801caa <malloc+0x177>
  801ba0:	a1 28 30 80 00       	mov    0x803028,%eax
  801ba5:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801bac:	85 c0                	test   %eax,%eax
  801bae:	0f 84 f6 00 00 00    	je     801caa <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801bb4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bbb:	e9 dc 00 00 00       	jmp    801c9c <malloc+0x169>
				flag++;
  801bc0:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801bc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bc6:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801bcd:	85 c0                	test   %eax,%eax
  801bcf:	74 07                	je     801bd8 <malloc+0xa5>
					flag=0;
  801bd1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801bd8:	a1 28 30 80 00       	mov    0x803028,%eax
  801bdd:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801be4:	85 c0                	test   %eax,%eax
  801be6:	79 05                	jns    801bed <malloc+0xba>
  801be8:	05 ff 0f 00 00       	add    $0xfff,%eax
  801bed:	c1 f8 0c             	sar    $0xc,%eax
  801bf0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bf3:	0f 85 a0 00 00 00    	jne    801c99 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801bf9:	a1 28 30 80 00       	mov    0x803028,%eax
  801bfe:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801c05:	85 c0                	test   %eax,%eax
  801c07:	79 05                	jns    801c0e <malloc+0xdb>
  801c09:	05 ff 0f 00 00       	add    $0xfff,%eax
  801c0e:	c1 f8 0c             	sar    $0xc,%eax
  801c11:	89 c2                	mov    %eax,%edx
  801c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c16:	29 d0                	sub    %edx,%eax
  801c18:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801c1b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801c21:	eb 11                	jmp    801c34 <malloc+0x101>
						hFreeArr[j] = 1;
  801c23:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c26:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801c2d:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801c31:	ff 45 ec             	incl   -0x14(%ebp)
  801c34:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c3a:	7e e7                	jle    801c23 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801c3c:	a1 28 30 80 00       	mov    0x803028,%eax
  801c41:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801c44:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801c4a:	c1 e2 0c             	shl    $0xc,%edx
  801c4d:	89 15 04 30 80 00    	mov    %edx,0x803004
  801c53:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c59:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801c60:	a1 28 30 80 00       	mov    0x803028,%eax
  801c65:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801c6c:	89 c2                	mov    %eax,%edx
  801c6e:	a1 28 30 80 00       	mov    0x803028,%eax
  801c73:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801c7a:	83 ec 08             	sub    $0x8,%esp
  801c7d:	52                   	push   %edx
  801c7e:	50                   	push   %eax
  801c7f:	e8 8b 02 00 00       	call   801f0f <sys_allocateMem>
  801c84:	83 c4 10             	add    $0x10,%esp

					idx++;
  801c87:	a1 28 30 80 00       	mov    0x803028,%eax
  801c8c:	40                   	inc    %eax
  801c8d:	a3 28 30 80 00       	mov    %eax,0x803028
					return (void*)startAdd;
  801c92:	a1 04 30 80 00       	mov    0x803004,%eax
  801c97:	eb 16                	jmp    801caf <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c99:	ff 45 f0             	incl   -0x10(%ebp)
  801c9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ca4:	0f 86 16 ff ff ff    	jbe    801bc0 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801caa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
  801cb4:	83 ec 18             	sub    $0x18,%esp
  801cb7:	8b 45 10             	mov    0x10(%ebp),%eax
  801cba:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801cbd:	83 ec 04             	sub    $0x4,%esp
  801cc0:	68 b0 2c 80 00       	push   $0x802cb0
  801cc5:	6a 59                	push   $0x59
  801cc7:	68 cf 2c 80 00       	push   $0x802ccf
  801ccc:	e8 24 ee ff ff       	call   800af5 <_panic>

00801cd1 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801cd1:	55                   	push   %ebp
  801cd2:	89 e5                	mov    %esp,%ebp
  801cd4:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801cd7:	83 ec 04             	sub    $0x4,%esp
  801cda:	68 db 2c 80 00       	push   $0x802cdb
  801cdf:	6a 5f                	push   $0x5f
  801ce1:	68 cf 2c 80 00       	push   $0x802ccf
  801ce6:	e8 0a ee ff ff       	call   800af5 <_panic>

00801ceb <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
  801cee:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801cf1:	83 ec 04             	sub    $0x4,%esp
  801cf4:	68 f8 2c 80 00       	push   $0x802cf8
  801cf9:	6a 70                	push   $0x70
  801cfb:	68 cf 2c 80 00       	push   $0x802ccf
  801d00:	e8 f0 ed ff ff       	call   800af5 <_panic>

00801d05 <sfree>:

}


void sfree(void* virtual_address)
{
  801d05:	55                   	push   %ebp
  801d06:	89 e5                	mov    %esp,%ebp
  801d08:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801d0b:	83 ec 04             	sub    $0x4,%esp
  801d0e:	68 1b 2d 80 00       	push   $0x802d1b
  801d13:	6a 7b                	push   $0x7b
  801d15:	68 cf 2c 80 00       	push   $0x802ccf
  801d1a:	e8 d6 ed ff ff       	call   800af5 <_panic>

00801d1f <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
  801d22:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801d25:	83 ec 04             	sub    $0x4,%esp
  801d28:	68 38 2d 80 00       	push   $0x802d38
  801d2d:	68 93 00 00 00       	push   $0x93
  801d32:	68 cf 2c 80 00       	push   $0x802ccf
  801d37:	e8 b9 ed ff ff       	call   800af5 <_panic>

00801d3c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
  801d3f:	57                   	push   %edi
  801d40:	56                   	push   %esi
  801d41:	53                   	push   %ebx
  801d42:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d45:	8b 45 08             	mov    0x8(%ebp),%eax
  801d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d4e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d51:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d54:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d57:	cd 30                	int    $0x30
  801d59:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d5f:	83 c4 10             	add    $0x10,%esp
  801d62:	5b                   	pop    %ebx
  801d63:	5e                   	pop    %esi
  801d64:	5f                   	pop    %edi
  801d65:	5d                   	pop    %ebp
  801d66:	c3                   	ret    

00801d67 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d67:	55                   	push   %ebp
  801d68:	89 e5                	mov    %esp,%ebp
  801d6a:	83 ec 04             	sub    $0x4,%esp
  801d6d:	8b 45 10             	mov    0x10(%ebp),%eax
  801d70:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d73:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d77:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	52                   	push   %edx
  801d7f:	ff 75 0c             	pushl  0xc(%ebp)
  801d82:	50                   	push   %eax
  801d83:	6a 00                	push   $0x0
  801d85:	e8 b2 ff ff ff       	call   801d3c <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
}
  801d8d:	90                   	nop
  801d8e:	c9                   	leave  
  801d8f:	c3                   	ret    

00801d90 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d90:	55                   	push   %ebp
  801d91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 01                	push   $0x1
  801d9f:	e8 98 ff ff ff       	call   801d3c <syscall>
  801da4:	83 c4 18             	add    $0x18,%esp
}
  801da7:	c9                   	leave  
  801da8:	c3                   	ret    

00801da9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801dac:	8b 45 08             	mov    0x8(%ebp),%eax
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	50                   	push   %eax
  801db8:	6a 05                	push   $0x5
  801dba:	e8 7d ff ff ff       	call   801d3c <syscall>
  801dbf:	83 c4 18             	add    $0x18,%esp
}
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 02                	push   $0x2
  801dd3:	e8 64 ff ff ff       	call   801d3c <syscall>
  801dd8:	83 c4 18             	add    $0x18,%esp
}
  801ddb:	c9                   	leave  
  801ddc:	c3                   	ret    

00801ddd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ddd:	55                   	push   %ebp
  801dde:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 03                	push   $0x3
  801dec:	e8 4b ff ff ff       	call   801d3c <syscall>
  801df1:	83 c4 18             	add    $0x18,%esp
}
  801df4:	c9                   	leave  
  801df5:	c3                   	ret    

00801df6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801df6:	55                   	push   %ebp
  801df7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 04                	push   $0x4
  801e05:	e8 32 ff ff ff       	call   801d3c <syscall>
  801e0a:	83 c4 18             	add    $0x18,%esp
}
  801e0d:	c9                   	leave  
  801e0e:	c3                   	ret    

00801e0f <sys_env_exit>:


void sys_env_exit(void)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 06                	push   $0x6
  801e1e:	e8 19 ff ff ff       	call   801d3c <syscall>
  801e23:	83 c4 18             	add    $0x18,%esp
}
  801e26:	90                   	nop
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	52                   	push   %edx
  801e39:	50                   	push   %eax
  801e3a:	6a 07                	push   $0x7
  801e3c:	e8 fb fe ff ff       	call   801d3c <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
  801e49:	56                   	push   %esi
  801e4a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e4b:	8b 75 18             	mov    0x18(%ebp),%esi
  801e4e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e51:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e57:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5a:	56                   	push   %esi
  801e5b:	53                   	push   %ebx
  801e5c:	51                   	push   %ecx
  801e5d:	52                   	push   %edx
  801e5e:	50                   	push   %eax
  801e5f:	6a 08                	push   $0x8
  801e61:	e8 d6 fe ff ff       	call   801d3c <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
}
  801e69:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e6c:	5b                   	pop    %ebx
  801e6d:	5e                   	pop    %esi
  801e6e:	5d                   	pop    %ebp
  801e6f:	c3                   	ret    

00801e70 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	52                   	push   %edx
  801e80:	50                   	push   %eax
  801e81:	6a 09                	push   $0x9
  801e83:	e8 b4 fe ff ff       	call   801d3c <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	c9                   	leave  
  801e8c:	c3                   	ret    

00801e8d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e8d:	55                   	push   %ebp
  801e8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	ff 75 0c             	pushl  0xc(%ebp)
  801e99:	ff 75 08             	pushl  0x8(%ebp)
  801e9c:	6a 0a                	push   $0xa
  801e9e:	e8 99 fe ff ff       	call   801d3c <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 0b                	push   $0xb
  801eb7:	e8 80 fe ff ff       	call   801d3c <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 0c                	push   $0xc
  801ed0:	e8 67 fe ff ff       	call   801d3c <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
}
  801ed8:	c9                   	leave  
  801ed9:	c3                   	ret    

00801eda <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801eda:	55                   	push   %ebp
  801edb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 0d                	push   $0xd
  801ee9:	e8 4e fe ff ff       	call   801d3c <syscall>
  801eee:	83 c4 18             	add    $0x18,%esp
}
  801ef1:	c9                   	leave  
  801ef2:	c3                   	ret    

00801ef3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ef3:	55                   	push   %ebp
  801ef4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	ff 75 0c             	pushl  0xc(%ebp)
  801eff:	ff 75 08             	pushl  0x8(%ebp)
  801f02:	6a 11                	push   $0x11
  801f04:	e8 33 fe ff ff       	call   801d3c <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
	return;
  801f0c:	90                   	nop
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	ff 75 0c             	pushl  0xc(%ebp)
  801f1b:	ff 75 08             	pushl  0x8(%ebp)
  801f1e:	6a 12                	push   $0x12
  801f20:	e8 17 fe ff ff       	call   801d3c <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
	return ;
  801f28:	90                   	nop
}
  801f29:	c9                   	leave  
  801f2a:	c3                   	ret    

00801f2b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f2b:	55                   	push   %ebp
  801f2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 0e                	push   $0xe
  801f3a:	e8 fd fd ff ff       	call   801d3c <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	ff 75 08             	pushl  0x8(%ebp)
  801f52:	6a 0f                	push   $0xf
  801f54:	e8 e3 fd ff ff       	call   801d3c <syscall>
  801f59:	83 c4 18             	add    $0x18,%esp
}
  801f5c:	c9                   	leave  
  801f5d:	c3                   	ret    

00801f5e <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f5e:	55                   	push   %ebp
  801f5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 10                	push   $0x10
  801f6d:	e8 ca fd ff ff       	call   801d3c <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
}
  801f75:	90                   	nop
  801f76:	c9                   	leave  
  801f77:	c3                   	ret    

00801f78 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f78:	55                   	push   %ebp
  801f79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 14                	push   $0x14
  801f87:	e8 b0 fd ff ff       	call   801d3c <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
}
  801f8f:	90                   	nop
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    

00801f92 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f92:	55                   	push   %ebp
  801f93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 15                	push   $0x15
  801fa1:	e8 96 fd ff ff       	call   801d3c <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
}
  801fa9:	90                   	nop
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_cputc>:


void
sys_cputc(const char c)
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
  801faf:	83 ec 04             	sub    $0x4,%esp
  801fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fb8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	50                   	push   %eax
  801fc5:	6a 16                	push   $0x16
  801fc7:	e8 70 fd ff ff       	call   801d3c <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	90                   	nop
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 17                	push   $0x17
  801fe1:	e8 56 fd ff ff       	call   801d3c <syscall>
  801fe6:	83 c4 18             	add    $0x18,%esp
}
  801fe9:	90                   	nop
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fef:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	ff 75 0c             	pushl  0xc(%ebp)
  801ffb:	50                   	push   %eax
  801ffc:	6a 18                	push   $0x18
  801ffe:	e8 39 fd ff ff       	call   801d3c <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
}
  802006:	c9                   	leave  
  802007:	c3                   	ret    

00802008 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802008:	55                   	push   %ebp
  802009:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80200b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200e:	8b 45 08             	mov    0x8(%ebp),%eax
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	52                   	push   %edx
  802018:	50                   	push   %eax
  802019:	6a 1b                	push   $0x1b
  80201b:	e8 1c fd ff ff       	call   801d3c <syscall>
  802020:	83 c4 18             	add    $0x18,%esp
}
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802028:	8b 55 0c             	mov    0xc(%ebp),%edx
  80202b:	8b 45 08             	mov    0x8(%ebp),%eax
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	52                   	push   %edx
  802035:	50                   	push   %eax
  802036:	6a 19                	push   $0x19
  802038:	e8 ff fc ff ff       	call   801d3c <syscall>
  80203d:	83 c4 18             	add    $0x18,%esp
}
  802040:	90                   	nop
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802046:	8b 55 0c             	mov    0xc(%ebp),%edx
  802049:	8b 45 08             	mov    0x8(%ebp),%eax
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	52                   	push   %edx
  802053:	50                   	push   %eax
  802054:	6a 1a                	push   $0x1a
  802056:	e8 e1 fc ff ff       	call   801d3c <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
}
  80205e:	90                   	nop
  80205f:	c9                   	leave  
  802060:	c3                   	ret    

00802061 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802061:	55                   	push   %ebp
  802062:	89 e5                	mov    %esp,%ebp
  802064:	83 ec 04             	sub    $0x4,%esp
  802067:	8b 45 10             	mov    0x10(%ebp),%eax
  80206a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80206d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802070:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802074:	8b 45 08             	mov    0x8(%ebp),%eax
  802077:	6a 00                	push   $0x0
  802079:	51                   	push   %ecx
  80207a:	52                   	push   %edx
  80207b:	ff 75 0c             	pushl  0xc(%ebp)
  80207e:	50                   	push   %eax
  80207f:	6a 1c                	push   $0x1c
  802081:	e8 b6 fc ff ff       	call   801d3c <syscall>
  802086:	83 c4 18             	add    $0x18,%esp
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80208e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802091:	8b 45 08             	mov    0x8(%ebp),%eax
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 00                	push   $0x0
  80209a:	52                   	push   %edx
  80209b:	50                   	push   %eax
  80209c:	6a 1d                	push   $0x1d
  80209e:	e8 99 fc ff ff       	call   801d3c <syscall>
  8020a3:	83 c4 18             	add    $0x18,%esp
}
  8020a6:	c9                   	leave  
  8020a7:	c3                   	ret    

008020a8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020a8:	55                   	push   %ebp
  8020a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	51                   	push   %ecx
  8020b9:	52                   	push   %edx
  8020ba:	50                   	push   %eax
  8020bb:	6a 1e                	push   $0x1e
  8020bd:	e8 7a fc ff ff       	call   801d3c <syscall>
  8020c2:	83 c4 18             	add    $0x18,%esp
}
  8020c5:	c9                   	leave  
  8020c6:	c3                   	ret    

008020c7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020c7:	55                   	push   %ebp
  8020c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	52                   	push   %edx
  8020d7:	50                   	push   %eax
  8020d8:	6a 1f                	push   $0x1f
  8020da:	e8 5d fc ff ff       	call   801d3c <syscall>
  8020df:	83 c4 18             	add    $0x18,%esp
}
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020e4:	55                   	push   %ebp
  8020e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 20                	push   $0x20
  8020f3:	e8 44 fc ff ff       	call   801d3c <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
}
  8020fb:	c9                   	leave  
  8020fc:	c3                   	ret    

008020fd <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8020fd:	55                   	push   %ebp
  8020fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802100:	8b 45 08             	mov    0x8(%ebp),%eax
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	ff 75 10             	pushl  0x10(%ebp)
  80210a:	ff 75 0c             	pushl  0xc(%ebp)
  80210d:	50                   	push   %eax
  80210e:	6a 21                	push   $0x21
  802110:	e8 27 fc ff ff       	call   801d3c <syscall>
  802115:	83 c4 18             	add    $0x18,%esp
}
  802118:	c9                   	leave  
  802119:	c3                   	ret    

0080211a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80211a:	55                   	push   %ebp
  80211b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80211d:	8b 45 08             	mov    0x8(%ebp),%eax
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	50                   	push   %eax
  802129:	6a 22                	push   $0x22
  80212b:	e8 0c fc ff ff       	call   801d3c <syscall>
  802130:	83 c4 18             	add    $0x18,%esp
}
  802133:	90                   	nop
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	50                   	push   %eax
  802145:	6a 23                	push   $0x23
  802147:	e8 f0 fb ff ff       	call   801d3c <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
}
  80214f:	90                   	nop
  802150:	c9                   	leave  
  802151:	c3                   	ret    

00802152 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802152:	55                   	push   %ebp
  802153:	89 e5                	mov    %esp,%ebp
  802155:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802158:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80215b:	8d 50 04             	lea    0x4(%eax),%edx
  80215e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	52                   	push   %edx
  802168:	50                   	push   %eax
  802169:	6a 24                	push   $0x24
  80216b:	e8 cc fb ff ff       	call   801d3c <syscall>
  802170:	83 c4 18             	add    $0x18,%esp
	return result;
  802173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802176:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802179:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80217c:	89 01                	mov    %eax,(%ecx)
  80217e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802181:	8b 45 08             	mov    0x8(%ebp),%eax
  802184:	c9                   	leave  
  802185:	c2 04 00             	ret    $0x4

00802188 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	ff 75 10             	pushl  0x10(%ebp)
  802192:	ff 75 0c             	pushl  0xc(%ebp)
  802195:	ff 75 08             	pushl  0x8(%ebp)
  802198:	6a 13                	push   $0x13
  80219a:	e8 9d fb ff ff       	call   801d3c <syscall>
  80219f:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a2:	90                   	nop
}
  8021a3:	c9                   	leave  
  8021a4:	c3                   	ret    

008021a5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021a5:	55                   	push   %ebp
  8021a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021a8:	6a 00                	push   $0x0
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 25                	push   $0x25
  8021b4:	e8 83 fb ff ff       	call   801d3c <syscall>
  8021b9:	83 c4 18             	add    $0x18,%esp
}
  8021bc:	c9                   	leave  
  8021bd:	c3                   	ret    

008021be <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021be:	55                   	push   %ebp
  8021bf:	89 e5                	mov    %esp,%ebp
  8021c1:	83 ec 04             	sub    $0x4,%esp
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021ca:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	50                   	push   %eax
  8021d7:	6a 26                	push   $0x26
  8021d9:	e8 5e fb ff ff       	call   801d3c <syscall>
  8021de:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e1:	90                   	nop
}
  8021e2:	c9                   	leave  
  8021e3:	c3                   	ret    

008021e4 <rsttst>:
void rsttst()
{
  8021e4:	55                   	push   %ebp
  8021e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 28                	push   $0x28
  8021f3:	e8 44 fb ff ff       	call   801d3c <syscall>
  8021f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8021fb:	90                   	nop
}
  8021fc:	c9                   	leave  
  8021fd:	c3                   	ret    

008021fe <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021fe:	55                   	push   %ebp
  8021ff:	89 e5                	mov    %esp,%ebp
  802201:	83 ec 04             	sub    $0x4,%esp
  802204:	8b 45 14             	mov    0x14(%ebp),%eax
  802207:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80220a:	8b 55 18             	mov    0x18(%ebp),%edx
  80220d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802211:	52                   	push   %edx
  802212:	50                   	push   %eax
  802213:	ff 75 10             	pushl  0x10(%ebp)
  802216:	ff 75 0c             	pushl  0xc(%ebp)
  802219:	ff 75 08             	pushl  0x8(%ebp)
  80221c:	6a 27                	push   $0x27
  80221e:	e8 19 fb ff ff       	call   801d3c <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
	return ;
  802226:	90                   	nop
}
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <chktst>:
void chktst(uint32 n)
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	ff 75 08             	pushl  0x8(%ebp)
  802237:	6a 29                	push   $0x29
  802239:	e8 fe fa ff ff       	call   801d3c <syscall>
  80223e:	83 c4 18             	add    $0x18,%esp
	return ;
  802241:	90                   	nop
}
  802242:	c9                   	leave  
  802243:	c3                   	ret    

00802244 <inctst>:

void inctst()
{
  802244:	55                   	push   %ebp
  802245:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	6a 00                	push   $0x0
  802251:	6a 2a                	push   $0x2a
  802253:	e8 e4 fa ff ff       	call   801d3c <syscall>
  802258:	83 c4 18             	add    $0x18,%esp
	return ;
  80225b:	90                   	nop
}
  80225c:	c9                   	leave  
  80225d:	c3                   	ret    

0080225e <gettst>:
uint32 gettst()
{
  80225e:	55                   	push   %ebp
  80225f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	6a 00                	push   $0x0
  80226b:	6a 2b                	push   $0x2b
  80226d:	e8 ca fa ff ff       	call   801d3c <syscall>
  802272:	83 c4 18             	add    $0x18,%esp
}
  802275:	c9                   	leave  
  802276:	c3                   	ret    

00802277 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802277:	55                   	push   %ebp
  802278:	89 e5                	mov    %esp,%ebp
  80227a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 2c                	push   $0x2c
  802289:	e8 ae fa ff ff       	call   801d3c <syscall>
  80228e:	83 c4 18             	add    $0x18,%esp
  802291:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802294:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802298:	75 07                	jne    8022a1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80229a:	b8 01 00 00 00       	mov    $0x1,%eax
  80229f:	eb 05                	jmp    8022a6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a6:	c9                   	leave  
  8022a7:	c3                   	ret    

008022a8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022a8:	55                   	push   %ebp
  8022a9:	89 e5                	mov    %esp,%ebp
  8022ab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 2c                	push   $0x2c
  8022ba:	e8 7d fa ff ff       	call   801d3c <syscall>
  8022bf:	83 c4 18             	add    $0x18,%esp
  8022c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022c5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022c9:	75 07                	jne    8022d2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022cb:	b8 01 00 00 00       	mov    $0x1,%eax
  8022d0:	eb 05                	jmp    8022d7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d7:	c9                   	leave  
  8022d8:	c3                   	ret    

008022d9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022d9:	55                   	push   %ebp
  8022da:	89 e5                	mov    %esp,%ebp
  8022dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 00                	push   $0x0
  8022e7:	6a 00                	push   $0x0
  8022e9:	6a 2c                	push   $0x2c
  8022eb:	e8 4c fa ff ff       	call   801d3c <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
  8022f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022f6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022fa:	75 07                	jne    802303 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022fc:	b8 01 00 00 00       	mov    $0x1,%eax
  802301:	eb 05                	jmp    802308 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802303:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802308:	c9                   	leave  
  802309:	c3                   	ret    

0080230a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80230a:	55                   	push   %ebp
  80230b:	89 e5                	mov    %esp,%ebp
  80230d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802310:	6a 00                	push   $0x0
  802312:	6a 00                	push   $0x0
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	6a 2c                	push   $0x2c
  80231c:	e8 1b fa ff ff       	call   801d3c <syscall>
  802321:	83 c4 18             	add    $0x18,%esp
  802324:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802327:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80232b:	75 07                	jne    802334 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80232d:	b8 01 00 00 00       	mov    $0x1,%eax
  802332:	eb 05                	jmp    802339 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802334:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802339:	c9                   	leave  
  80233a:	c3                   	ret    

0080233b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80233b:	55                   	push   %ebp
  80233c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 00                	push   $0x0
  802344:	6a 00                	push   $0x0
  802346:	ff 75 08             	pushl  0x8(%ebp)
  802349:	6a 2d                	push   $0x2d
  80234b:	e8 ec f9 ff ff       	call   801d3c <syscall>
  802350:	83 c4 18             	add    $0x18,%esp
	return ;
  802353:	90                   	nop
}
  802354:	c9                   	leave  
  802355:	c3                   	ret    
  802356:	66 90                	xchg   %ax,%ax

00802358 <__udivdi3>:
  802358:	55                   	push   %ebp
  802359:	57                   	push   %edi
  80235a:	56                   	push   %esi
  80235b:	53                   	push   %ebx
  80235c:	83 ec 1c             	sub    $0x1c,%esp
  80235f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802363:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802367:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80236b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80236f:	89 ca                	mov    %ecx,%edx
  802371:	89 f8                	mov    %edi,%eax
  802373:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802377:	85 f6                	test   %esi,%esi
  802379:	75 2d                	jne    8023a8 <__udivdi3+0x50>
  80237b:	39 cf                	cmp    %ecx,%edi
  80237d:	77 65                	ja     8023e4 <__udivdi3+0x8c>
  80237f:	89 fd                	mov    %edi,%ebp
  802381:	85 ff                	test   %edi,%edi
  802383:	75 0b                	jne    802390 <__udivdi3+0x38>
  802385:	b8 01 00 00 00       	mov    $0x1,%eax
  80238a:	31 d2                	xor    %edx,%edx
  80238c:	f7 f7                	div    %edi
  80238e:	89 c5                	mov    %eax,%ebp
  802390:	31 d2                	xor    %edx,%edx
  802392:	89 c8                	mov    %ecx,%eax
  802394:	f7 f5                	div    %ebp
  802396:	89 c1                	mov    %eax,%ecx
  802398:	89 d8                	mov    %ebx,%eax
  80239a:	f7 f5                	div    %ebp
  80239c:	89 cf                	mov    %ecx,%edi
  80239e:	89 fa                	mov    %edi,%edx
  8023a0:	83 c4 1c             	add    $0x1c,%esp
  8023a3:	5b                   	pop    %ebx
  8023a4:	5e                   	pop    %esi
  8023a5:	5f                   	pop    %edi
  8023a6:	5d                   	pop    %ebp
  8023a7:	c3                   	ret    
  8023a8:	39 ce                	cmp    %ecx,%esi
  8023aa:	77 28                	ja     8023d4 <__udivdi3+0x7c>
  8023ac:	0f bd fe             	bsr    %esi,%edi
  8023af:	83 f7 1f             	xor    $0x1f,%edi
  8023b2:	75 40                	jne    8023f4 <__udivdi3+0x9c>
  8023b4:	39 ce                	cmp    %ecx,%esi
  8023b6:	72 0a                	jb     8023c2 <__udivdi3+0x6a>
  8023b8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8023bc:	0f 87 9e 00 00 00    	ja     802460 <__udivdi3+0x108>
  8023c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023c7:	89 fa                	mov    %edi,%edx
  8023c9:	83 c4 1c             	add    $0x1c,%esp
  8023cc:	5b                   	pop    %ebx
  8023cd:	5e                   	pop    %esi
  8023ce:	5f                   	pop    %edi
  8023cf:	5d                   	pop    %ebp
  8023d0:	c3                   	ret    
  8023d1:	8d 76 00             	lea    0x0(%esi),%esi
  8023d4:	31 ff                	xor    %edi,%edi
  8023d6:	31 c0                	xor    %eax,%eax
  8023d8:	89 fa                	mov    %edi,%edx
  8023da:	83 c4 1c             	add    $0x1c,%esp
  8023dd:	5b                   	pop    %ebx
  8023de:	5e                   	pop    %esi
  8023df:	5f                   	pop    %edi
  8023e0:	5d                   	pop    %ebp
  8023e1:	c3                   	ret    
  8023e2:	66 90                	xchg   %ax,%ax
  8023e4:	89 d8                	mov    %ebx,%eax
  8023e6:	f7 f7                	div    %edi
  8023e8:	31 ff                	xor    %edi,%edi
  8023ea:	89 fa                	mov    %edi,%edx
  8023ec:	83 c4 1c             	add    $0x1c,%esp
  8023ef:	5b                   	pop    %ebx
  8023f0:	5e                   	pop    %esi
  8023f1:	5f                   	pop    %edi
  8023f2:	5d                   	pop    %ebp
  8023f3:	c3                   	ret    
  8023f4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023f9:	89 eb                	mov    %ebp,%ebx
  8023fb:	29 fb                	sub    %edi,%ebx
  8023fd:	89 f9                	mov    %edi,%ecx
  8023ff:	d3 e6                	shl    %cl,%esi
  802401:	89 c5                	mov    %eax,%ebp
  802403:	88 d9                	mov    %bl,%cl
  802405:	d3 ed                	shr    %cl,%ebp
  802407:	89 e9                	mov    %ebp,%ecx
  802409:	09 f1                	or     %esi,%ecx
  80240b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80240f:	89 f9                	mov    %edi,%ecx
  802411:	d3 e0                	shl    %cl,%eax
  802413:	89 c5                	mov    %eax,%ebp
  802415:	89 d6                	mov    %edx,%esi
  802417:	88 d9                	mov    %bl,%cl
  802419:	d3 ee                	shr    %cl,%esi
  80241b:	89 f9                	mov    %edi,%ecx
  80241d:	d3 e2                	shl    %cl,%edx
  80241f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802423:	88 d9                	mov    %bl,%cl
  802425:	d3 e8                	shr    %cl,%eax
  802427:	09 c2                	or     %eax,%edx
  802429:	89 d0                	mov    %edx,%eax
  80242b:	89 f2                	mov    %esi,%edx
  80242d:	f7 74 24 0c          	divl   0xc(%esp)
  802431:	89 d6                	mov    %edx,%esi
  802433:	89 c3                	mov    %eax,%ebx
  802435:	f7 e5                	mul    %ebp
  802437:	39 d6                	cmp    %edx,%esi
  802439:	72 19                	jb     802454 <__udivdi3+0xfc>
  80243b:	74 0b                	je     802448 <__udivdi3+0xf0>
  80243d:	89 d8                	mov    %ebx,%eax
  80243f:	31 ff                	xor    %edi,%edi
  802441:	e9 58 ff ff ff       	jmp    80239e <__udivdi3+0x46>
  802446:	66 90                	xchg   %ax,%ax
  802448:	8b 54 24 08          	mov    0x8(%esp),%edx
  80244c:	89 f9                	mov    %edi,%ecx
  80244e:	d3 e2                	shl    %cl,%edx
  802450:	39 c2                	cmp    %eax,%edx
  802452:	73 e9                	jae    80243d <__udivdi3+0xe5>
  802454:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802457:	31 ff                	xor    %edi,%edi
  802459:	e9 40 ff ff ff       	jmp    80239e <__udivdi3+0x46>
  80245e:	66 90                	xchg   %ax,%ax
  802460:	31 c0                	xor    %eax,%eax
  802462:	e9 37 ff ff ff       	jmp    80239e <__udivdi3+0x46>
  802467:	90                   	nop

00802468 <__umoddi3>:
  802468:	55                   	push   %ebp
  802469:	57                   	push   %edi
  80246a:	56                   	push   %esi
  80246b:	53                   	push   %ebx
  80246c:	83 ec 1c             	sub    $0x1c,%esp
  80246f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802473:	8b 74 24 34          	mov    0x34(%esp),%esi
  802477:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80247b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80247f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802483:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802487:	89 f3                	mov    %esi,%ebx
  802489:	89 fa                	mov    %edi,%edx
  80248b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80248f:	89 34 24             	mov    %esi,(%esp)
  802492:	85 c0                	test   %eax,%eax
  802494:	75 1a                	jne    8024b0 <__umoddi3+0x48>
  802496:	39 f7                	cmp    %esi,%edi
  802498:	0f 86 a2 00 00 00    	jbe    802540 <__umoddi3+0xd8>
  80249e:	89 c8                	mov    %ecx,%eax
  8024a0:	89 f2                	mov    %esi,%edx
  8024a2:	f7 f7                	div    %edi
  8024a4:	89 d0                	mov    %edx,%eax
  8024a6:	31 d2                	xor    %edx,%edx
  8024a8:	83 c4 1c             	add    $0x1c,%esp
  8024ab:	5b                   	pop    %ebx
  8024ac:	5e                   	pop    %esi
  8024ad:	5f                   	pop    %edi
  8024ae:	5d                   	pop    %ebp
  8024af:	c3                   	ret    
  8024b0:	39 f0                	cmp    %esi,%eax
  8024b2:	0f 87 ac 00 00 00    	ja     802564 <__umoddi3+0xfc>
  8024b8:	0f bd e8             	bsr    %eax,%ebp
  8024bb:	83 f5 1f             	xor    $0x1f,%ebp
  8024be:	0f 84 ac 00 00 00    	je     802570 <__umoddi3+0x108>
  8024c4:	bf 20 00 00 00       	mov    $0x20,%edi
  8024c9:	29 ef                	sub    %ebp,%edi
  8024cb:	89 fe                	mov    %edi,%esi
  8024cd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8024d1:	89 e9                	mov    %ebp,%ecx
  8024d3:	d3 e0                	shl    %cl,%eax
  8024d5:	89 d7                	mov    %edx,%edi
  8024d7:	89 f1                	mov    %esi,%ecx
  8024d9:	d3 ef                	shr    %cl,%edi
  8024db:	09 c7                	or     %eax,%edi
  8024dd:	89 e9                	mov    %ebp,%ecx
  8024df:	d3 e2                	shl    %cl,%edx
  8024e1:	89 14 24             	mov    %edx,(%esp)
  8024e4:	89 d8                	mov    %ebx,%eax
  8024e6:	d3 e0                	shl    %cl,%eax
  8024e8:	89 c2                	mov    %eax,%edx
  8024ea:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ee:	d3 e0                	shl    %cl,%eax
  8024f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024f4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024f8:	89 f1                	mov    %esi,%ecx
  8024fa:	d3 e8                	shr    %cl,%eax
  8024fc:	09 d0                	or     %edx,%eax
  8024fe:	d3 eb                	shr    %cl,%ebx
  802500:	89 da                	mov    %ebx,%edx
  802502:	f7 f7                	div    %edi
  802504:	89 d3                	mov    %edx,%ebx
  802506:	f7 24 24             	mull   (%esp)
  802509:	89 c6                	mov    %eax,%esi
  80250b:	89 d1                	mov    %edx,%ecx
  80250d:	39 d3                	cmp    %edx,%ebx
  80250f:	0f 82 87 00 00 00    	jb     80259c <__umoddi3+0x134>
  802515:	0f 84 91 00 00 00    	je     8025ac <__umoddi3+0x144>
  80251b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80251f:	29 f2                	sub    %esi,%edx
  802521:	19 cb                	sbb    %ecx,%ebx
  802523:	89 d8                	mov    %ebx,%eax
  802525:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802529:	d3 e0                	shl    %cl,%eax
  80252b:	89 e9                	mov    %ebp,%ecx
  80252d:	d3 ea                	shr    %cl,%edx
  80252f:	09 d0                	or     %edx,%eax
  802531:	89 e9                	mov    %ebp,%ecx
  802533:	d3 eb                	shr    %cl,%ebx
  802535:	89 da                	mov    %ebx,%edx
  802537:	83 c4 1c             	add    $0x1c,%esp
  80253a:	5b                   	pop    %ebx
  80253b:	5e                   	pop    %esi
  80253c:	5f                   	pop    %edi
  80253d:	5d                   	pop    %ebp
  80253e:	c3                   	ret    
  80253f:	90                   	nop
  802540:	89 fd                	mov    %edi,%ebp
  802542:	85 ff                	test   %edi,%edi
  802544:	75 0b                	jne    802551 <__umoddi3+0xe9>
  802546:	b8 01 00 00 00       	mov    $0x1,%eax
  80254b:	31 d2                	xor    %edx,%edx
  80254d:	f7 f7                	div    %edi
  80254f:	89 c5                	mov    %eax,%ebp
  802551:	89 f0                	mov    %esi,%eax
  802553:	31 d2                	xor    %edx,%edx
  802555:	f7 f5                	div    %ebp
  802557:	89 c8                	mov    %ecx,%eax
  802559:	f7 f5                	div    %ebp
  80255b:	89 d0                	mov    %edx,%eax
  80255d:	e9 44 ff ff ff       	jmp    8024a6 <__umoddi3+0x3e>
  802562:	66 90                	xchg   %ax,%ax
  802564:	89 c8                	mov    %ecx,%eax
  802566:	89 f2                	mov    %esi,%edx
  802568:	83 c4 1c             	add    $0x1c,%esp
  80256b:	5b                   	pop    %ebx
  80256c:	5e                   	pop    %esi
  80256d:	5f                   	pop    %edi
  80256e:	5d                   	pop    %ebp
  80256f:	c3                   	ret    
  802570:	3b 04 24             	cmp    (%esp),%eax
  802573:	72 06                	jb     80257b <__umoddi3+0x113>
  802575:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802579:	77 0f                	ja     80258a <__umoddi3+0x122>
  80257b:	89 f2                	mov    %esi,%edx
  80257d:	29 f9                	sub    %edi,%ecx
  80257f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802583:	89 14 24             	mov    %edx,(%esp)
  802586:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80258a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80258e:	8b 14 24             	mov    (%esp),%edx
  802591:	83 c4 1c             	add    $0x1c,%esp
  802594:	5b                   	pop    %ebx
  802595:	5e                   	pop    %esi
  802596:	5f                   	pop    %edi
  802597:	5d                   	pop    %ebp
  802598:	c3                   	ret    
  802599:	8d 76 00             	lea    0x0(%esi),%esi
  80259c:	2b 04 24             	sub    (%esp),%eax
  80259f:	19 fa                	sbb    %edi,%edx
  8025a1:	89 d1                	mov    %edx,%ecx
  8025a3:	89 c6                	mov    %eax,%esi
  8025a5:	e9 71 ff ff ff       	jmp    80251b <__umoddi3+0xb3>
  8025aa:	66 90                	xchg   %ax,%ax
  8025ac:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8025b0:	72 ea                	jb     80259c <__umoddi3+0x134>
  8025b2:	89 d9                	mov    %ebx,%ecx
  8025b4:	e9 62 ff ff ff       	jmp    80251b <__umoddi3+0xb3>
