
obj/user/tst_nextfit:     file format elf32-i386


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
  800031:	e8 28 0b 00 00       	call   800b5e <libmain>
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
  80003d:	81 ec 30 08 00 00    	sub    $0x830,%esp
	int Mega = 1024*1024;
  800043:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  80004a:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)

	//Make sure that the heap size is 512 MB
	int numOf2MBsInHeap = (USER_HEAP_MAX - USER_HEAP_START) / (2*Mega);
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	89 c7                	mov    %eax,%edi
  800058:	b8 00 00 00 20       	mov    $0x20000000,%eax
  80005d:	ba 00 00 00 00       	mov    $0x0,%edx
  800062:	f7 f7                	div    %edi
  800064:	89 45 d8             	mov    %eax,-0x28(%ebp)
	assert(numOf2MBsInHeap == 256);
  800067:	81 7d d8 00 01 00 00 	cmpl   $0x100,-0x28(%ebp)
  80006e:	74 16                	je     800086 <_main+0x4e>
  800070:	68 e0 25 80 00       	push   $0x8025e0
  800075:	68 f7 25 80 00       	push   $0x8025f7
  80007a:	6a 0e                	push   $0xe
  80007c:	68 0c 26 80 00       	push   $0x80260c
  800081:	e8 e7 0b 00 00       	call   800c6d <_panic>




	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 03                	push   $0x3
  80008b:	e8 bc 22 00 00       	call   80234c <sys_set_uheap_strategy>
  800090:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800093:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800097:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009e:	eb 29                	jmp    8000c9 <_main+0x91>
		{
			if (myEnv->__uptr_pws[i].empty)
  8000a0:	a1 04 30 80 00       	mov    0x803004,%eax
  8000a5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8000ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8000ae:	89 d0                	mov    %edx,%eax
  8000b0:	01 c0                	add    %eax,%eax
  8000b2:	01 d0                	add    %edx,%eax
  8000b4:	c1 e0 02             	shl    $0x2,%eax
  8000b7:	01 c8                	add    %ecx,%eax
  8000b9:	8a 40 04             	mov    0x4(%eax),%al
  8000bc:	84 c0                	test   %al,%al
  8000be:	74 06                	je     8000c6 <_main+0x8e>
			{
				fullWS = 0;
  8000c0:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  8000c4:	eb 12                	jmp    8000d8 <_main+0xa0>
	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8000c6:	ff 45 f0             	incl   -0x10(%ebp)
  8000c9:	a1 04 30 80 00       	mov    0x803004,%eax
  8000ce:	8b 50 74             	mov    0x74(%eax),%edx
  8000d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d4:	39 c2                	cmp    %eax,%edx
  8000d6:	77 c8                	ja     8000a0 <_main+0x68>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  8000d8:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  8000dc:	74 14                	je     8000f2 <_main+0xba>
  8000de:	83 ec 04             	sub    $0x4,%esp
  8000e1:	68 1f 26 80 00       	push   $0x80261f
  8000e6:	6a 20                	push   $0x20
  8000e8:	68 0c 26 80 00       	push   $0x80260c
  8000ed:	e8 7b 0b 00 00       	call   800c6d <_panic>

	int freeFrames ;
	int usedDiskPages;

	//[0] Make sure there're available places in the WS
	int w = 0 ;
  8000f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int requiredNumOfEmptyWSLocs = 2;
  8000f9:	c7 45 d4 02 00 00 00 	movl   $0x2,-0x2c(%ebp)
	int numOfEmptyWSLocs = 0;
  800100:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800107:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80010e:	eb 26                	jmp    800136 <_main+0xfe>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  800110:	a1 04 30 80 00       	mov    0x803004,%eax
  800115:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80011b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80011e:	89 d0                	mov    %edx,%eax
  800120:	01 c0                	add    %eax,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	c1 e0 02             	shl    $0x2,%eax
  800127:	01 c8                	add    %ecx,%eax
  800129:	8a 40 04             	mov    0x4(%eax),%al
  80012c:	3c 01                	cmp    $0x1,%al
  80012e:	75 03                	jne    800133 <_main+0xfb>
			numOfEmptyWSLocs++;
  800130:	ff 45 e8             	incl   -0x18(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
	int requiredNumOfEmptyWSLocs = 2;
	int numOfEmptyWSLocs = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800133:	ff 45 ec             	incl   -0x14(%ebp)
  800136:	a1 04 30 80 00       	mov    0x803004,%eax
  80013b:	8b 50 74             	mov    0x74(%eax),%edx
  80013e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800141:	39 c2                	cmp    %eax,%edx
  800143:	77 cb                	ja     800110 <_main+0xd8>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
			numOfEmptyWSLocs++;
	}
	if (numOfEmptyWSLocs < requiredNumOfEmptyWSLocs)
  800145:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800148:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  80014b:	7d 14                	jge    800161 <_main+0x129>
		panic("Insufficient number of WS empty locations! please increase the PAGE_WS_MAX_SIZE");
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 3c 26 80 00       	push   $0x80263c
  800155:	6a 31                	push   $0x31
  800157:	68 0c 26 80 00       	push   $0x80260c
  80015c:	e8 0c 0b 00 00       	call   800c6d <_panic>


	void* ptr_allocations[512] = {0};
  800161:	8d 95 c8 f7 ff ff    	lea    -0x838(%ebp),%edx
  800167:	b9 00 02 00 00       	mov    $0x200,%ecx
  80016c:	b8 00 00 00 00       	mov    $0x0,%eax
  800171:	89 d7                	mov    %edx,%edi
  800173:	f3 ab                	rep stos %eax,%es:(%edi)
	int i;

	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	68 8c 26 80 00       	push   $0x80268c
  80017d:	e8 9f 0d 00 00       	call   800f21 <cprintf>
  800182:	83 c4 10             	add    $0x10,%esp

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
  800185:	e8 2f 1d 00 00       	call   801eb9 <sys_calculate_free_frames>
  80018a:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80018d:	e8 aa 1d 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800192:	89 45 cc             	mov    %eax,-0x34(%ebp)
	for(i = 0; i< 256;i++)
  800195:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80019c:	eb 20                	jmp    8001be <_main+0x186>
	{
		ptr_allocations[i] = malloc(2*Mega);
  80019e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001a1:	01 c0                	add    %eax,%eax
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	50                   	push   %eax
  8001a7:	e8 ff 1a 00 00       	call   801cab <malloc>
  8001ac:	83 c4 10             	add    $0x10,%esp
  8001af:	89 c2                	mov    %eax,%edx
  8001b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b4:	89 94 85 c8 f7 ff ff 	mov    %edx,-0x838(%ebp,%eax,4)
	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
	usedDiskPages = sys_pf_calculate_allocated_pages();
	for(i = 0; i< 256;i++)
  8001bb:	ff 45 e4             	incl   -0x1c(%ebp)
  8001be:	81 7d e4 ff 00 00 00 	cmpl   $0xff,-0x1c(%ebp)
  8001c5:	7e d7                	jle    80019e <_main+0x166>
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001c7:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8001cd:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8001d2:	75 5b                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001d4:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001da:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8001df:	75 4e                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001e1:	8b 85 e8 f7 ff ff    	mov    -0x818(%ebp),%eax
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001e7:	3d 00 00 00 81       	cmp    $0x81000000,%eax
  8001ec:	75 41                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  8001ee:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001f4:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  8001f9:	75 34                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  8001fb:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  800201:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  800206:	75 27                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  800208:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  80020e:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800213:	75 1a                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  800215:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  80021b:	3d 00 00 20 83       	cmp    $0x83200000,%eax
  800220:	75 0d                	jne    80022f <_main+0x1f7>
			(uint32)ptr_allocations[25] != 0x83200000 ||
			(uint32)ptr_allocations[255] != 0x9FE00000)
  800222:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  800228:	3d 00 00 e0 9f       	cmp    $0x9fe00000,%eax
  80022d:	74 14                	je     800243 <_main+0x20b>
			(uint32)ptr_allocations[255] != 0x9FE00000)
		panic("Wrong allocation, Check fitting strategy is working correctly");
  80022f:	83 ec 04             	sub    $0x4,%esp
  800232:	68 dc 26 80 00       	push   $0x8026dc
  800237:	6a 4a                	push   $0x4a
  800239:	68 0c 26 80 00       	push   $0x80260c
  80023e:	e8 2a 0a 00 00       	call   800c6d <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800243:	e8 f4 1c 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800248:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80024b:	89 c2                	mov    %eax,%edx
  80024d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800250:	c1 e0 09             	shl    $0x9,%eax
  800253:	85 c0                	test   %eax,%eax
  800255:	79 05                	jns    80025c <_main+0x224>
  800257:	05 ff 0f 00 00       	add    $0xfff,%eax
  80025c:	c1 f8 0c             	sar    $0xc,%eax
  80025f:	39 c2                	cmp    %eax,%edx
  800261:	74 14                	je     800277 <_main+0x23f>
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 1a 27 80 00       	push   $0x80271a
  80026b:	6a 4c                	push   $0x4c
  80026d:	68 0c 26 80 00       	push   $0x80260c
  800272:	e8 f6 09 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != (512*Mega)/(1024*PAGE_SIZE) ) panic("Wrong allocation");
  800277:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  80027a:	e8 3a 1c 00 00       	call   801eb9 <sys_calculate_free_frames>
  80027f:	29 c3                	sub    %eax,%ebx
  800281:	89 da                	mov    %ebx,%edx
  800283:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800286:	c1 e0 09             	shl    $0x9,%eax
  800289:	85 c0                	test   %eax,%eax
  80028b:	79 05                	jns    800292 <_main+0x25a>
  80028d:	05 ff ff 3f 00       	add    $0x3fffff,%eax
  800292:	c1 f8 16             	sar    $0x16,%eax
  800295:	39 c2                	cmp    %eax,%edx
  800297:	74 14                	je     8002ad <_main+0x275>
  800299:	83 ec 04             	sub    $0x4,%esp
  80029c:	68 37 27 80 00       	push   $0x802737
  8002a1:	6a 4d                	push   $0x4d
  8002a3:	68 0c 26 80 00       	push   $0x80260c
  8002a8:	e8 c0 09 00 00       	call   800c6d <_panic>

	// Make memory holes.
	freeFrames = sys_calculate_free_frames() ;
  8002ad:	e8 07 1c 00 00       	call   801eb9 <sys_calculate_free_frames>
  8002b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b5:	e8 82 1c 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8002ba:	89 45 cc             	mov    %eax,-0x34(%ebp)

	free(ptr_allocations[0]);		// Hole 1 = 2 M
  8002bd:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 33 1a 00 00       	call   801cff <free>
  8002cc:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[2]);		// Hole 2 = 4 M
  8002cf:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
  8002d5:	83 ec 0c             	sub    $0xc,%esp
  8002d8:	50                   	push   %eax
  8002d9:	e8 21 1a 00 00       	call   801cff <free>
  8002de:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[3]);
  8002e1:	8b 85 d4 f7 ff ff    	mov    -0x82c(%ebp),%eax
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	50                   	push   %eax
  8002eb:	e8 0f 1a 00 00       	call   801cff <free>
  8002f0:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[5]);		// Hole 3 = 2 M
  8002f3:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	50                   	push   %eax
  8002fd:	e8 fd 19 00 00       	call   801cff <free>
  800302:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[10]);		// Hole 4 = 6 M
  800305:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
  80030b:	83 ec 0c             	sub    $0xc,%esp
  80030e:	50                   	push   %eax
  80030f:	e8 eb 19 00 00       	call   801cff <free>
  800314:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[12]);
  800317:	8b 85 f8 f7 ff ff    	mov    -0x808(%ebp),%eax
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	50                   	push   %eax
  800321:	e8 d9 19 00 00       	call   801cff <free>
  800326:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[11]);
  800329:	8b 85 f4 f7 ff ff    	mov    -0x80c(%ebp),%eax
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	50                   	push   %eax
  800333:	e8 c7 19 00 00       	call   801cff <free>
  800338:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[20]);		// Hole 5 = 2 M
  80033b:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	50                   	push   %eax
  800345:	e8 b5 19 00 00       	call   801cff <free>
  80034a:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[25]);		// Hole 6 = 2 M
  80034d:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
  800353:	83 ec 0c             	sub    $0xc,%esp
  800356:	50                   	push   %eax
  800357:	e8 a3 19 00 00       	call   801cff <free>
  80035c:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[255]);		// Hole 7 = 2 M
  80035f:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	50                   	push   %eax
  800369:	e8 91 19 00 00       	call   801cff <free>
  80036e:	83 c4 10             	add    $0x10,%esp

	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 10*(2*Mega)/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800371:	e8 c6 1b 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800376:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800379:	89 d1                	mov    %edx,%ecx
  80037b:	29 c1                	sub    %eax,%ecx
  80037d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800380:	89 d0                	mov    %edx,%eax
  800382:	c1 e0 02             	shl    $0x2,%eax
  800385:	01 d0                	add    %edx,%eax
  800387:	c1 e0 02             	shl    $0x2,%eax
  80038a:	85 c0                	test   %eax,%eax
  80038c:	79 05                	jns    800393 <_main+0x35b>
  80038e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800393:	c1 f8 0c             	sar    $0xc,%eax
  800396:	39 c1                	cmp    %eax,%ecx
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 48 27 80 00       	push   $0x802748
  8003a2:	6a 5e                	push   $0x5e
  8003a4:	68 0c 26 80 00       	push   $0x80260c
  8003a9:	e8 bf 08 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8003ae:	e8 06 1b 00 00       	call   801eb9 <sys_calculate_free_frames>
  8003b3:	89 c2                	mov    %eax,%edx
  8003b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b8:	39 c2                	cmp    %eax,%edx
  8003ba:	74 14                	je     8003d0 <_main+0x398>
  8003bc:	83 ec 04             	sub    $0x4,%esp
  8003bf:	68 84 27 80 00       	push   $0x802784
  8003c4:	6a 5f                	push   $0x5f
  8003c6:	68 0c 26 80 00       	push   $0x80260c
  8003cb:	e8 9d 08 00 00       	call   800c6d <_panic>

	// Test next fit

	freeFrames = sys_calculate_free_frames() ;
  8003d0:	e8 e4 1a 00 00       	call   801eb9 <sys_calculate_free_frames>
  8003d5:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8003d8:	e8 5f 1b 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8003dd:	89 45 cc             	mov    %eax,-0x34(%ebp)
	void* tempAddress = malloc(Mega-kilo);		// Use Hole 1 -> Hole 1 = 1 M
  8003e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003e6:	83 ec 0c             	sub    $0xc,%esp
  8003e9:	50                   	push   %eax
  8003ea:	e8 bc 18 00 00       	call   801cab <malloc>
  8003ef:	83 c4 10             	add    $0x10,%esp
  8003f2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80000000)
  8003f5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8003f8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8003fd:	74 14                	je     800413 <_main+0x3db>
		panic("Next Fit is not working correctly");
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 c4 27 80 00       	push   $0x8027c4
  800407:	6a 67                	push   $0x67
  800409:	68 0c 26 80 00       	push   $0x80260c
  80040e:	e8 5a 08 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800413:	e8 24 1b 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800418:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80041b:	89 c2                	mov    %eax,%edx
  80041d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800420:	85 c0                	test   %eax,%eax
  800422:	79 05                	jns    800429 <_main+0x3f1>
  800424:	05 ff 0f 00 00       	add    $0xfff,%eax
  800429:	c1 f8 0c             	sar    $0xc,%eax
  80042c:	39 c2                	cmp    %eax,%edx
  80042e:	74 14                	je     800444 <_main+0x40c>
  800430:	83 ec 04             	sub    $0x4,%esp
  800433:	68 1a 27 80 00       	push   $0x80271a
  800438:	6a 68                	push   $0x68
  80043a:	68 0c 26 80 00       	push   $0x80260c
  80043f:	e8 29 08 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800444:	e8 70 1a 00 00       	call   801eb9 <sys_calculate_free_frames>
  800449:	89 c2                	mov    %eax,%edx
  80044b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80044e:	39 c2                	cmp    %eax,%edx
  800450:	74 14                	je     800466 <_main+0x42e>
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 37 27 80 00       	push   $0x802737
  80045a:	6a 69                	push   $0x69
  80045c:	68 0c 26 80 00       	push   $0x80260c
  800461:	e8 07 08 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800466:	e8 4e 1a 00 00       	call   801eb9 <sys_calculate_free_frames>
  80046b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80046e:	e8 c9 1a 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800473:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo);					// Use Hole 1 -> Hole 1 = 1 M - Kilo
  800476:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800479:	83 ec 0c             	sub    $0xc,%esp
  80047c:	50                   	push   %eax
  80047d:	e8 29 18 00 00       	call   801cab <malloc>
  800482:	83 c4 10             	add    $0x10,%esp
  800485:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80100000)
  800488:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80048b:	3d 00 00 10 80       	cmp    $0x80100000,%eax
  800490:	74 14                	je     8004a6 <_main+0x46e>
		panic("Next Fit is not working correctly");
  800492:	83 ec 04             	sub    $0x4,%esp
  800495:	68 c4 27 80 00       	push   $0x8027c4
  80049a:	6a 6f                	push   $0x6f
  80049c:	68 0c 26 80 00       	push   $0x80260c
  8004a1:	e8 c7 07 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8004a6:	e8 91 1a 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8004ab:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8004ae:	89 c2                	mov    %eax,%edx
  8004b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b3:	c1 e0 02             	shl    $0x2,%eax
  8004b6:	85 c0                	test   %eax,%eax
  8004b8:	79 05                	jns    8004bf <_main+0x487>
  8004ba:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004bf:	c1 f8 0c             	sar    $0xc,%eax
  8004c2:	39 c2                	cmp    %eax,%edx
  8004c4:	74 14                	je     8004da <_main+0x4a2>
  8004c6:	83 ec 04             	sub    $0x4,%esp
  8004c9:	68 1a 27 80 00       	push   $0x80271a
  8004ce:	6a 70                	push   $0x70
  8004d0:	68 0c 26 80 00       	push   $0x80260c
  8004d5:	e8 93 07 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8004da:	e8 da 19 00 00       	call   801eb9 <sys_calculate_free_frames>
  8004df:	89 c2                	mov    %eax,%edx
  8004e1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004e4:	39 c2                	cmp    %eax,%edx
  8004e6:	74 14                	je     8004fc <_main+0x4c4>
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	68 37 27 80 00       	push   $0x802737
  8004f0:	6a 71                	push   $0x71
  8004f2:	68 0c 26 80 00       	push   $0x80260c
  8004f7:	e8 71 07 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  8004fc:	e8 b8 19 00 00       	call   801eb9 <sys_calculate_free_frames>
  800501:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800504:	e8 33 1a 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800509:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(5*Mega); 			   // Use Hole 4 -> Hole 4 = 1 M
  80050c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80050f:	89 d0                	mov    %edx,%eax
  800511:	c1 e0 02             	shl    $0x2,%eax
  800514:	01 d0                	add    %edx,%eax
  800516:	83 ec 0c             	sub    $0xc,%esp
  800519:	50                   	push   %eax
  80051a:	e8 8c 17 00 00       	call   801cab <malloc>
  80051f:	83 c4 10             	add    $0x10,%esp
  800522:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81400000)
  800525:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800528:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  80052d:	74 14                	je     800543 <_main+0x50b>
		panic("Next Fit is not working correctly");
  80052f:	83 ec 04             	sub    $0x4,%esp
  800532:	68 c4 27 80 00       	push   $0x8027c4
  800537:	6a 77                	push   $0x77
  800539:	68 0c 26 80 00       	push   $0x80260c
  80053e:	e8 2a 07 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800543:	e8 f4 19 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800548:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80054b:	89 c1                	mov    %eax,%ecx
  80054d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800550:	89 d0                	mov    %edx,%eax
  800552:	c1 e0 02             	shl    $0x2,%eax
  800555:	01 d0                	add    %edx,%eax
  800557:	85 c0                	test   %eax,%eax
  800559:	79 05                	jns    800560 <_main+0x528>
  80055b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800560:	c1 f8 0c             	sar    $0xc,%eax
  800563:	39 c1                	cmp    %eax,%ecx
  800565:	74 14                	je     80057b <_main+0x543>
  800567:	83 ec 04             	sub    $0x4,%esp
  80056a:	68 1a 27 80 00       	push   $0x80271a
  80056f:	6a 78                	push   $0x78
  800571:	68 0c 26 80 00       	push   $0x80260c
  800576:	e8 f2 06 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80057b:	e8 39 19 00 00       	call   801eb9 <sys_calculate_free_frames>
  800580:	89 c2                	mov    %eax,%edx
  800582:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800585:	39 c2                	cmp    %eax,%edx
  800587:	74 14                	je     80059d <_main+0x565>
  800589:	83 ec 04             	sub    $0x4,%esp
  80058c:	68 37 27 80 00       	push   $0x802737
  800591:	6a 79                	push   $0x79
  800593:	68 0c 26 80 00       	push   $0x80260c
  800598:	e8 d0 06 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80059d:	e8 17 19 00 00       	call   801eb9 <sys_calculate_free_frames>
  8005a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8005a5:	e8 92 19 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8005aa:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(1*Mega); 			   // Use Hole 4 -> Hole 4 = 0 M
  8005ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b0:	83 ec 0c             	sub    $0xc,%esp
  8005b3:	50                   	push   %eax
  8005b4:	e8 f2 16 00 00       	call   801cab <malloc>
  8005b9:	83 c4 10             	add    $0x10,%esp
  8005bc:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81900000)
  8005bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8005c2:	3d 00 00 90 81       	cmp    $0x81900000,%eax
  8005c7:	74 14                	je     8005dd <_main+0x5a5>
		panic("Next Fit is not working correctly");
  8005c9:	83 ec 04             	sub    $0x4,%esp
  8005cc:	68 c4 27 80 00       	push   $0x8027c4
  8005d1:	6a 7f                	push   $0x7f
  8005d3:	68 0c 26 80 00       	push   $0x80260c
  8005d8:	e8 90 06 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  8005dd:	e8 5a 19 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8005e2:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8005e5:	89 c2                	mov    %eax,%edx
  8005e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ea:	85 c0                	test   %eax,%eax
  8005ec:	79 05                	jns    8005f3 <_main+0x5bb>
  8005ee:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f3:	c1 f8 0c             	sar    $0xc,%eax
  8005f6:	39 c2                	cmp    %eax,%edx
  8005f8:	74 17                	je     800611 <_main+0x5d9>
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 1a 27 80 00       	push   $0x80271a
  800602:	68 80 00 00 00       	push   $0x80
  800607:	68 0c 26 80 00       	push   $0x80260c
  80060c:	e8 5c 06 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800611:	e8 a3 18 00 00       	call   801eb9 <sys_calculate_free_frames>
  800616:	89 c2                	mov    %eax,%edx
  800618:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	74 17                	je     800636 <_main+0x5fe>
  80061f:	83 ec 04             	sub    $0x4,%esp
  800622:	68 37 27 80 00       	push   $0x802737
  800627:	68 81 00 00 00       	push   $0x81
  80062c:	68 0c 26 80 00       	push   $0x80260c
  800631:	e8 37 06 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800636:	e8 7e 18 00 00       	call   801eb9 <sys_calculate_free_frames>
  80063b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80063e:	e8 f9 18 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800643:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[15]);					// Make a new hole => 2 M
  800646:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax
  80064c:	83 ec 0c             	sub    $0xc,%esp
  80064f:	50                   	push   %eax
  800650:	e8 aa 16 00 00       	call   801cff <free>
  800655:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800658:	e8 df 18 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  80065d:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800660:	29 c2                	sub    %eax,%edx
  800662:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800665:	01 c0                	add    %eax,%eax
  800667:	85 c0                	test   %eax,%eax
  800669:	79 05                	jns    800670 <_main+0x638>
  80066b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800670:	c1 f8 0c             	sar    $0xc,%eax
  800673:	39 c2                	cmp    %eax,%edx
  800675:	74 17                	je     80068e <_main+0x656>
  800677:	83 ec 04             	sub    $0x4,%esp
  80067a:	68 48 27 80 00       	push   $0x802748
  80067f:	68 87 00 00 00       	push   $0x87
  800684:	68 0c 26 80 00       	push   $0x80260c
  800689:	e8 df 05 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  80068e:	e8 26 18 00 00       	call   801eb9 <sys_calculate_free_frames>
  800693:	89 c2                	mov    %eax,%edx
  800695:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800698:	39 c2                	cmp    %eax,%edx
  80069a:	74 17                	je     8006b3 <_main+0x67b>
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	68 84 27 80 00       	push   $0x802784
  8006a4:	68 88 00 00 00       	push   $0x88
  8006a9:	68 0c 26 80 00       	push   $0x80260c
  8006ae:	e8 ba 05 00 00       	call   800c6d <_panic>

	//[NEXT FIT Case]
	freeFrames = sys_calculate_free_frames() ;
  8006b3:	e8 01 18 00 00       	call   801eb9 <sys_calculate_free_frames>
  8006b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bb:	e8 7c 18 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8006c0:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo); 			   // Use new Hole = 2 M - 4 kilo
  8006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	50                   	push   %eax
  8006ca:	e8 dc 15 00 00       	call   801cab <malloc>
  8006cf:	83 c4 10             	add    $0x10,%esp
  8006d2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E00000)
  8006d5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8006d8:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  8006dd:	74 17                	je     8006f6 <_main+0x6be>
		panic("Next Fit is not working correctly");
  8006df:	83 ec 04             	sub    $0x4,%esp
  8006e2:	68 c4 27 80 00       	push   $0x8027c4
  8006e7:	68 8f 00 00 00       	push   $0x8f
  8006ec:	68 0c 26 80 00       	push   $0x80260c
  8006f1:	e8 77 05 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8006f6:	e8 41 18 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8006fb:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8006fe:	89 c2                	mov    %eax,%edx
  800700:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800703:	c1 e0 02             	shl    $0x2,%eax
  800706:	85 c0                	test   %eax,%eax
  800708:	79 05                	jns    80070f <_main+0x6d7>
  80070a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80070f:	c1 f8 0c             	sar    $0xc,%eax
  800712:	39 c2                	cmp    %eax,%edx
  800714:	74 17                	je     80072d <_main+0x6f5>
  800716:	83 ec 04             	sub    $0x4,%esp
  800719:	68 1a 27 80 00       	push   $0x80271a
  80071e:	68 90 00 00 00       	push   $0x90
  800723:	68 0c 26 80 00       	push   $0x80260c
  800728:	e8 40 05 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80072d:	e8 87 17 00 00       	call   801eb9 <sys_calculate_free_frames>
  800732:	89 c2                	mov    %eax,%edx
  800734:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800737:	39 c2                	cmp    %eax,%edx
  800739:	74 17                	je     800752 <_main+0x71a>
  80073b:	83 ec 04             	sub    $0x4,%esp
  80073e:	68 37 27 80 00       	push   $0x802737
  800743:	68 91 00 00 00       	push   $0x91
  800748:	68 0c 26 80 00       	push   $0x80260c
  80074d:	e8 1b 05 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800752:	e8 62 17 00 00       	call   801eb9 <sys_calculate_free_frames>
  800757:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80075a:	e8 dd 17 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  80075f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(Mega + 1016*kilo); 	// Use new Hole = 4 kilo
  800762:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800765:	c1 e0 03             	shl    $0x3,%eax
  800768:	89 c2                	mov    %eax,%edx
  80076a:	c1 e2 07             	shl    $0x7,%edx
  80076d:	29 c2                	sub    %eax,%edx
  80076f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	83 ec 0c             	sub    $0xc,%esp
  800777:	50                   	push   %eax
  800778:	e8 2e 15 00 00       	call   801cab <malloc>
  80077d:	83 c4 10             	add    $0x10,%esp
  800780:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E01000)
  800783:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800786:	3d 00 10 e0 81       	cmp    $0x81e01000,%eax
  80078b:	74 17                	je     8007a4 <_main+0x76c>
		panic("Next Fit is not working correctly");
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	68 c4 27 80 00       	push   $0x8027c4
  800795:	68 97 00 00 00       	push   $0x97
  80079a:	68 0c 26 80 00       	push   $0x80260c
  80079f:	e8 c9 04 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (1*Mega+1016*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  8007a4:	e8 93 17 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8007a9:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8007ac:	89 c2                	mov    %eax,%edx
  8007ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007b1:	c1 e0 03             	shl    $0x3,%eax
  8007b4:	89 c1                	mov    %eax,%ecx
  8007b6:	c1 e1 07             	shl    $0x7,%ecx
  8007b9:	29 c1                	sub    %eax,%ecx
  8007bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007be:	01 c8                	add    %ecx,%eax
  8007c0:	85 c0                	test   %eax,%eax
  8007c2:	79 05                	jns    8007c9 <_main+0x791>
  8007c4:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007c9:	c1 f8 0c             	sar    $0xc,%eax
  8007cc:	39 c2                	cmp    %eax,%edx
  8007ce:	74 17                	je     8007e7 <_main+0x7af>
  8007d0:	83 ec 04             	sub    $0x4,%esp
  8007d3:	68 1a 27 80 00       	push   $0x80271a
  8007d8:	68 98 00 00 00       	push   $0x98
  8007dd:	68 0c 26 80 00       	push   $0x80260c
  8007e2:	e8 86 04 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8007e7:	e8 cd 16 00 00       	call   801eb9 <sys_calculate_free_frames>
  8007ec:	89 c2                	mov    %eax,%edx
  8007ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007f1:	39 c2                	cmp    %eax,%edx
  8007f3:	74 17                	je     80080c <_main+0x7d4>
  8007f5:	83 ec 04             	sub    $0x4,%esp
  8007f8:	68 37 27 80 00       	push   $0x802737
  8007fd:	68 99 00 00 00       	push   $0x99
  800802:	68 0c 26 80 00       	push   $0x80260c
  800807:	e8 61 04 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80080c:	e8 a8 16 00 00       	call   801eb9 <sys_calculate_free_frames>
  800811:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800814:	e8 23 17 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800819:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(512*kilo); 			   // Use Hole 5 -> Hole 5 = 1.5 M
  80081c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80081f:	c1 e0 09             	shl    $0x9,%eax
  800822:	83 ec 0c             	sub    $0xc,%esp
  800825:	50                   	push   %eax
  800826:	e8 80 14 00 00       	call   801cab <malloc>
  80082b:	83 c4 10             	add    $0x10,%esp
  80082e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x82800000)
  800831:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800834:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800839:	74 17                	je     800852 <_main+0x81a>
		panic("Next Fit is not working correctly");
  80083b:	83 ec 04             	sub    $0x4,%esp
  80083e:	68 c4 27 80 00       	push   $0x8027c4
  800843:	68 9f 00 00 00       	push   $0x9f
  800848:	68 0c 26 80 00       	push   $0x80260c
  80084d:	e8 1b 04 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800852:	e8 e5 16 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800857:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80085a:	89 c2                	mov    %eax,%edx
  80085c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80085f:	c1 e0 09             	shl    $0x9,%eax
  800862:	85 c0                	test   %eax,%eax
  800864:	79 05                	jns    80086b <_main+0x833>
  800866:	05 ff 0f 00 00       	add    $0xfff,%eax
  80086b:	c1 f8 0c             	sar    $0xc,%eax
  80086e:	39 c2                	cmp    %eax,%edx
  800870:	74 17                	je     800889 <_main+0x851>
  800872:	83 ec 04             	sub    $0x4,%esp
  800875:	68 1a 27 80 00       	push   $0x80271a
  80087a:	68 a0 00 00 00       	push   $0xa0
  80087f:	68 0c 26 80 00       	push   $0x80260c
  800884:	e8 e4 03 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800889:	e8 2b 16 00 00       	call   801eb9 <sys_calculate_free_frames>
  80088e:	89 c2                	mov    %eax,%edx
  800890:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800893:	39 c2                	cmp    %eax,%edx
  800895:	74 17                	je     8008ae <_main+0x876>
  800897:	83 ec 04             	sub    $0x4,%esp
  80089a:	68 37 27 80 00       	push   $0x802737
  80089f:	68 a1 00 00 00       	push   $0xa1
  8008a4:	68 0c 26 80 00       	push   $0x80260c
  8008a9:	e8 bf 03 00 00       	call   800c6d <_panic>

	cprintf("\nCASE1: (next fit without looping back) has succeeded...\n") ;
  8008ae:	83 ec 0c             	sub    $0xc,%esp
  8008b1:	68 e8 27 80 00       	push   $0x8027e8
  8008b6:	e8 66 06 00 00       	call   800f21 <cprintf>
  8008bb:	83 c4 10             	add    $0x10,%esp

	// Check that next fit is looping back to check for free space
	freeFrames = sys_calculate_free_frames() ;
  8008be:	e8 f6 15 00 00       	call   801eb9 <sys_calculate_free_frames>
  8008c3:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c6:	e8 71 16 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  8008cb:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(3*Mega + 512*kilo); 			   // Use Hole 2 -> Hole 2 = 0.5 M
  8008ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d1:	89 c2                	mov    %eax,%edx
  8008d3:	01 d2                	add    %edx,%edx
  8008d5:	01 c2                	add    %eax,%edx
  8008d7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008da:	c1 e0 09             	shl    $0x9,%eax
  8008dd:	01 d0                	add    %edx,%eax
  8008df:	83 ec 0c             	sub    $0xc,%esp
  8008e2:	50                   	push   %eax
  8008e3:	e8 c3 13 00 00       	call   801cab <malloc>
  8008e8:	83 c4 10             	add    $0x10,%esp
  8008eb:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80400000)
  8008ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8008f1:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8008f6:	74 17                	je     80090f <_main+0x8d7>
		panic("Next Fit is not working correctly");
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	68 c4 27 80 00       	push   $0x8027c4
  800900:	68 aa 00 00 00       	push   $0xaa
  800905:	68 0c 26 80 00       	push   $0x80260c
  80090a:	e8 5e 03 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (3*Mega+512*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  80090f:	e8 28 16 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800914:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800917:	89 c2                	mov    %eax,%edx
  800919:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091c:	89 c1                	mov    %eax,%ecx
  80091e:	01 c9                	add    %ecx,%ecx
  800920:	01 c1                	add    %eax,%ecx
  800922:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800925:	c1 e0 09             	shl    $0x9,%eax
  800928:	01 c8                	add    %ecx,%eax
  80092a:	85 c0                	test   %eax,%eax
  80092c:	79 05                	jns    800933 <_main+0x8fb>
  80092e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800933:	c1 f8 0c             	sar    $0xc,%eax
  800936:	39 c2                	cmp    %eax,%edx
  800938:	74 17                	je     800951 <_main+0x919>
  80093a:	83 ec 04             	sub    $0x4,%esp
  80093d:	68 1a 27 80 00       	push   $0x80271a
  800942:	68 ab 00 00 00       	push   $0xab
  800947:	68 0c 26 80 00       	push   $0x80260c
  80094c:	e8 1c 03 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800951:	e8 63 15 00 00       	call   801eb9 <sys_calculate_free_frames>
  800956:	89 c2                	mov    %eax,%edx
  800958:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80095b:	39 c2                	cmp    %eax,%edx
  80095d:	74 17                	je     800976 <_main+0x93e>
  80095f:	83 ec 04             	sub    $0x4,%esp
  800962:	68 37 27 80 00       	push   $0x802737
  800967:	68 ac 00 00 00       	push   $0xac
  80096c:	68 0c 26 80 00       	push   $0x80260c
  800971:	e8 f7 02 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800976:	e8 3e 15 00 00       	call   801eb9 <sys_calculate_free_frames>
  80097b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80097e:	e8 b9 15 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800983:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[24]);		// Increase size of Hole 6 to 4 M
  800986:	8b 85 28 f8 ff ff    	mov    -0x7d8(%ebp),%eax
  80098c:	83 ec 0c             	sub    $0xc,%esp
  80098f:	50                   	push   %eax
  800990:	e8 6a 13 00 00       	call   801cff <free>
  800995:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800998:	e8 9f 15 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  80099d:	8b 55 cc             	mov    -0x34(%ebp),%edx
  8009a0:	29 c2                	sub    %eax,%edx
  8009a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009a5:	01 c0                	add    %eax,%eax
  8009a7:	85 c0                	test   %eax,%eax
  8009a9:	79 05                	jns    8009b0 <_main+0x978>
  8009ab:	05 ff 0f 00 00       	add    $0xfff,%eax
  8009b0:	c1 f8 0c             	sar    $0xc,%eax
  8009b3:	39 c2                	cmp    %eax,%edx
  8009b5:	74 17                	je     8009ce <_main+0x996>
  8009b7:	83 ec 04             	sub    $0x4,%esp
  8009ba:	68 48 27 80 00       	push   $0x802748
  8009bf:	68 b2 00 00 00       	push   $0xb2
  8009c4:	68 0c 26 80 00       	push   $0x80260c
  8009c9:	e8 9f 02 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8009ce:	e8 e6 14 00 00       	call   801eb9 <sys_calculate_free_frames>
  8009d3:	89 c2                	mov    %eax,%edx
  8009d5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009d8:	39 c2                	cmp    %eax,%edx
  8009da:	74 17                	je     8009f3 <_main+0x9bb>
  8009dc:	83 ec 04             	sub    $0x4,%esp
  8009df:	68 84 27 80 00       	push   $0x802784
  8009e4:	68 b3 00 00 00       	push   $0xb3
  8009e9:	68 0c 26 80 00       	push   $0x80260c
  8009ee:	e8 7a 02 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  8009f3:	e8 c1 14 00 00       	call   801eb9 <sys_calculate_free_frames>
  8009f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8009fb:	e8 3c 15 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800a00:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(4*Mega-kilo);		// Use Hole 6 -> Hole 6 = 0 M
  800a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a06:	c1 e0 02             	shl    $0x2,%eax
  800a09:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a0c:	83 ec 0c             	sub    $0xc,%esp
  800a0f:	50                   	push   %eax
  800a10:	e8 96 12 00 00       	call   801cab <malloc>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x83000000)
  800a1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800a1e:	3d 00 00 00 83       	cmp    $0x83000000,%eax
  800a23:	74 17                	je     800a3c <_main+0xa04>
		panic("Next Fit is not working correctly");
  800a25:	83 ec 04             	sub    $0x4,%esp
  800a28:	68 c4 27 80 00       	push   $0x8027c4
  800a2d:	68 ba 00 00 00       	push   $0xba
  800a32:	68 0c 26 80 00       	push   $0x80260c
  800a37:	e8 31 02 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800a3c:	e8 fb 14 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800a41:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800a44:	89 c2                	mov    %eax,%edx
  800a46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a49:	c1 e0 02             	shl    $0x2,%eax
  800a4c:	85 c0                	test   %eax,%eax
  800a4e:	79 05                	jns    800a55 <_main+0xa1d>
  800a50:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a55:	c1 f8 0c             	sar    $0xc,%eax
  800a58:	39 c2                	cmp    %eax,%edx
  800a5a:	74 17                	je     800a73 <_main+0xa3b>
  800a5c:	83 ec 04             	sub    $0x4,%esp
  800a5f:	68 1a 27 80 00       	push   $0x80271a
  800a64:	68 bb 00 00 00       	push   $0xbb
  800a69:	68 0c 26 80 00       	push   $0x80260c
  800a6e:	e8 fa 01 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800a73:	e8 41 14 00 00       	call   801eb9 <sys_calculate_free_frames>
  800a78:	89 c2                	mov    %eax,%edx
  800a7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a7d:	39 c2                	cmp    %eax,%edx
  800a7f:	74 17                	je     800a98 <_main+0xa60>
  800a81:	83 ec 04             	sub    $0x4,%esp
  800a84:	68 37 27 80 00       	push   $0x802737
  800a89:	68 bc 00 00 00       	push   $0xbc
  800a8e:	68 0c 26 80 00       	push   $0x80260c
  800a93:	e8 d5 01 00 00       	call   800c6d <_panic>

	cprintf("\nCASE2: (next fit WITH looping back) has succeeded...\n") ;
  800a98:	83 ec 0c             	sub    $0xc,%esp
  800a9b:	68 24 28 80 00       	push   $0x802824
  800aa0:	e8 7c 04 00 00       	call   800f21 <cprintf>
  800aa5:	83 c4 10             	add    $0x10,%esp

	// Check that next fit returns null in case all holes are not free
	freeFrames = sys_calculate_free_frames() ;
  800aa8:	e8 0c 14 00 00       	call   801eb9 <sys_calculate_free_frames>
  800aad:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab0:	e8 87 14 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800ab5:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(6*Mega); 			   // No Suitable Hole is available
  800ab8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800abb:	89 d0                	mov    %edx,%eax
  800abd:	01 c0                	add    %eax,%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	83 ec 0c             	sub    $0xc,%esp
  800ac6:	50                   	push   %eax
  800ac7:	e8 df 11 00 00       	call   801cab <malloc>
  800acc:	83 c4 10             	add    $0x10,%esp
  800acf:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x0)
  800ad2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800ad5:	85 c0                	test   %eax,%eax
  800ad7:	74 17                	je     800af0 <_main+0xab8>
		panic("Next Fit is not working correctly");
  800ad9:	83 ec 04             	sub    $0x4,%esp
  800adc:	68 c4 27 80 00       	push   $0x8027c4
  800ae1:	68 c5 00 00 00       	push   $0xc5
  800ae6:	68 0c 26 80 00       	push   $0x80260c
  800aeb:	e8 7d 01 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800af0:	e8 47 14 00 00       	call   801f3c <sys_pf_calculate_allocated_pages>
  800af5:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  800af8:	74 17                	je     800b11 <_main+0xad9>
  800afa:	83 ec 04             	sub    $0x4,%esp
  800afd:	68 1a 27 80 00       	push   $0x80271a
  800b02:	68 c6 00 00 00       	push   $0xc6
  800b07:	68 0c 26 80 00       	push   $0x80260c
  800b0c:	e8 5c 01 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800b11:	e8 a3 13 00 00       	call   801eb9 <sys_calculate_free_frames>
  800b16:	89 c2                	mov    %eax,%edx
  800b18:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b1b:	39 c2                	cmp    %eax,%edx
  800b1d:	74 17                	je     800b36 <_main+0xafe>
  800b1f:	83 ec 04             	sub    $0x4,%esp
  800b22:	68 37 27 80 00       	push   $0x802737
  800b27:	68 c7 00 00 00       	push   $0xc7
  800b2c:	68 0c 26 80 00       	push   $0x80260c
  800b31:	e8 37 01 00 00       	call   800c6d <_panic>

	cprintf("\nCASE3: (next fit with insufficient space) has succeeded...\n") ;
  800b36:	83 ec 0c             	sub    $0xc,%esp
  800b39:	68 5c 28 80 00       	push   $0x80285c
  800b3e:	e8 de 03 00 00       	call   800f21 <cprintf>
  800b43:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test Next Fit has completed successfully.\n");
  800b46:	83 ec 0c             	sub    $0xc,%esp
  800b49:	68 9c 28 80 00       	push   $0x80289c
  800b4e:	e8 ce 03 00 00       	call   800f21 <cprintf>
  800b53:	83 c4 10             	add    $0x10,%esp

	return;
  800b56:	90                   	nop
}
  800b57:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b5a:	5b                   	pop    %ebx
  800b5b:	5f                   	pop    %edi
  800b5c:	5d                   	pop    %ebp
  800b5d:	c3                   	ret    

00800b5e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b64:	e8 85 12 00 00       	call   801dee <sys_getenvindex>
  800b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6f:	89 d0                	mov    %edx,%eax
  800b71:	c1 e0 02             	shl    $0x2,%eax
  800b74:	01 d0                	add    %edx,%eax
  800b76:	01 c0                	add    %eax,%eax
  800b78:	01 d0                	add    %edx,%eax
  800b7a:	01 c0                	add    %eax,%eax
  800b7c:	01 d0                	add    %edx,%eax
  800b7e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800b85:	01 d0                	add    %edx,%eax
  800b87:	c1 e0 02             	shl    $0x2,%eax
  800b8a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b8f:	a3 04 30 80 00       	mov    %eax,0x803004

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b94:	a1 04 30 80 00       	mov    0x803004,%eax
  800b99:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b9f:	84 c0                	test   %al,%al
  800ba1:	74 0f                	je     800bb2 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800ba3:	a1 04 30 80 00       	mov    0x803004,%eax
  800ba8:	05 f4 02 00 00       	add    $0x2f4,%eax
  800bad:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800bb2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb6:	7e 0a                	jle    800bc2 <libmain+0x64>
		binaryname = argv[0];
  800bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	ff 75 0c             	pushl  0xc(%ebp)
  800bc8:	ff 75 08             	pushl  0x8(%ebp)
  800bcb:	e8 68 f4 ff ff       	call   800038 <_main>
  800bd0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800bd3:	e8 b1 13 00 00       	call   801f89 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800bd8:	83 ec 0c             	sub    $0xc,%esp
  800bdb:	68 f4 28 80 00       	push   $0x8028f4
  800be0:	e8 3c 03 00 00       	call   800f21 <cprintf>
  800be5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800be8:	a1 04 30 80 00       	mov    0x803004,%eax
  800bed:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800bf3:	a1 04 30 80 00       	mov    0x803004,%eax
  800bf8:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800bfe:	83 ec 04             	sub    $0x4,%esp
  800c01:	52                   	push   %edx
  800c02:	50                   	push   %eax
  800c03:	68 1c 29 80 00       	push   $0x80291c
  800c08:	e8 14 03 00 00       	call   800f21 <cprintf>
  800c0d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c10:	a1 04 30 80 00       	mov    0x803004,%eax
  800c15:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	50                   	push   %eax
  800c1f:	68 41 29 80 00       	push   $0x802941
  800c24:	e8 f8 02 00 00       	call   800f21 <cprintf>
  800c29:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c2c:	83 ec 0c             	sub    $0xc,%esp
  800c2f:	68 f4 28 80 00       	push   $0x8028f4
  800c34:	e8 e8 02 00 00       	call   800f21 <cprintf>
  800c39:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c3c:	e8 62 13 00 00       	call   801fa3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c41:	e8 19 00 00 00       	call   800c5f <exit>
}
  800c46:	90                   	nop
  800c47:	c9                   	leave  
  800c48:	c3                   	ret    

00800c49 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c49:	55                   	push   %ebp
  800c4a:	89 e5                	mov    %esp,%ebp
  800c4c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c4f:	83 ec 0c             	sub    $0xc,%esp
  800c52:	6a 00                	push   $0x0
  800c54:	e8 61 11 00 00       	call   801dba <sys_env_destroy>
  800c59:	83 c4 10             	add    $0x10,%esp
}
  800c5c:	90                   	nop
  800c5d:	c9                   	leave  
  800c5e:	c3                   	ret    

00800c5f <exit>:

void
exit(void)
{
  800c5f:	55                   	push   %ebp
  800c60:	89 e5                	mov    %esp,%ebp
  800c62:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800c65:	e8 b6 11 00 00       	call   801e20 <sys_env_exit>
}
  800c6a:	90                   	nop
  800c6b:	c9                   	leave  
  800c6c:	c3                   	ret    

00800c6d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c6d:	55                   	push   %ebp
  800c6e:	89 e5                	mov    %esp,%ebp
  800c70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c73:	8d 45 10             	lea    0x10(%ebp),%eax
  800c76:	83 c0 04             	add    $0x4,%eax
  800c79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c7c:	a1 14 30 80 00       	mov    0x803014,%eax
  800c81:	85 c0                	test   %eax,%eax
  800c83:	74 16                	je     800c9b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c85:	a1 14 30 80 00       	mov    0x803014,%eax
  800c8a:	83 ec 08             	sub    $0x8,%esp
  800c8d:	50                   	push   %eax
  800c8e:	68 58 29 80 00       	push   $0x802958
  800c93:	e8 89 02 00 00       	call   800f21 <cprintf>
  800c98:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c9b:	a1 00 30 80 00       	mov    0x803000,%eax
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	ff 75 08             	pushl  0x8(%ebp)
  800ca6:	50                   	push   %eax
  800ca7:	68 5d 29 80 00       	push   $0x80295d
  800cac:	e8 70 02 00 00       	call   800f21 <cprintf>
  800cb1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800cb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb7:	83 ec 08             	sub    $0x8,%esp
  800cba:	ff 75 f4             	pushl  -0xc(%ebp)
  800cbd:	50                   	push   %eax
  800cbe:	e8 f3 01 00 00       	call   800eb6 <vcprintf>
  800cc3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800cc6:	83 ec 08             	sub    $0x8,%esp
  800cc9:	6a 00                	push   $0x0
  800ccb:	68 79 29 80 00       	push   $0x802979
  800cd0:	e8 e1 01 00 00       	call   800eb6 <vcprintf>
  800cd5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800cd8:	e8 82 ff ff ff       	call   800c5f <exit>

	// should not return here
	while (1) ;
  800cdd:	eb fe                	jmp    800cdd <_panic+0x70>

00800cdf <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800cdf:	55                   	push   %ebp
  800ce0:	89 e5                	mov    %esp,%ebp
  800ce2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800ce5:	a1 04 30 80 00       	mov    0x803004,%eax
  800cea:	8b 50 74             	mov    0x74(%eax),%edx
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	39 c2                	cmp    %eax,%edx
  800cf2:	74 14                	je     800d08 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800cf4:	83 ec 04             	sub    $0x4,%esp
  800cf7:	68 7c 29 80 00       	push   $0x80297c
  800cfc:	6a 26                	push   $0x26
  800cfe:	68 c8 29 80 00       	push   $0x8029c8
  800d03:	e8 65 ff ff ff       	call   800c6d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d0f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d16:	e9 c2 00 00 00       	jmp    800ddd <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800d1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d1e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	01 d0                	add    %edx,%eax
  800d2a:	8b 00                	mov    (%eax),%eax
  800d2c:	85 c0                	test   %eax,%eax
  800d2e:	75 08                	jne    800d38 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800d30:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d33:	e9 a2 00 00 00       	jmp    800dda <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800d38:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d3f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d46:	eb 69                	jmp    800db1 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d48:	a1 04 30 80 00       	mov    0x803004,%eax
  800d4d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d53:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d56:	89 d0                	mov    %edx,%eax
  800d58:	01 c0                	add    %eax,%eax
  800d5a:	01 d0                	add    %edx,%eax
  800d5c:	c1 e0 02             	shl    $0x2,%eax
  800d5f:	01 c8                	add    %ecx,%eax
  800d61:	8a 40 04             	mov    0x4(%eax),%al
  800d64:	84 c0                	test   %al,%al
  800d66:	75 46                	jne    800dae <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d68:	a1 04 30 80 00       	mov    0x803004,%eax
  800d6d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d73:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d76:	89 d0                	mov    %edx,%eax
  800d78:	01 c0                	add    %eax,%eax
  800d7a:	01 d0                	add    %edx,%eax
  800d7c:	c1 e0 02             	shl    $0x2,%eax
  800d7f:	01 c8                	add    %ecx,%eax
  800d81:	8b 00                	mov    (%eax),%eax
  800d83:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d86:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d89:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d8e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d93:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	01 c8                	add    %ecx,%eax
  800d9f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800da1:	39 c2                	cmp    %eax,%edx
  800da3:	75 09                	jne    800dae <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800da5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800dac:	eb 12                	jmp    800dc0 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dae:	ff 45 e8             	incl   -0x18(%ebp)
  800db1:	a1 04 30 80 00       	mov    0x803004,%eax
  800db6:	8b 50 74             	mov    0x74(%eax),%edx
  800db9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800dbc:	39 c2                	cmp    %eax,%edx
  800dbe:	77 88                	ja     800d48 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800dc0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800dc4:	75 14                	jne    800dda <CheckWSWithoutLastIndex+0xfb>
			panic(
  800dc6:	83 ec 04             	sub    $0x4,%esp
  800dc9:	68 d4 29 80 00       	push   $0x8029d4
  800dce:	6a 3a                	push   $0x3a
  800dd0:	68 c8 29 80 00       	push   $0x8029c8
  800dd5:	e8 93 fe ff ff       	call   800c6d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800dda:	ff 45 f0             	incl   -0x10(%ebp)
  800ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800de3:	0f 8c 32 ff ff ff    	jl     800d1b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800de9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800df0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800df7:	eb 26                	jmp    800e1f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800df9:	a1 04 30 80 00       	mov    0x803004,%eax
  800dfe:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800e04:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e07:	89 d0                	mov    %edx,%eax
  800e09:	01 c0                	add    %eax,%eax
  800e0b:	01 d0                	add    %edx,%eax
  800e0d:	c1 e0 02             	shl    $0x2,%eax
  800e10:	01 c8                	add    %ecx,%eax
  800e12:	8a 40 04             	mov    0x4(%eax),%al
  800e15:	3c 01                	cmp    $0x1,%al
  800e17:	75 03                	jne    800e1c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800e19:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e1c:	ff 45 e0             	incl   -0x20(%ebp)
  800e1f:	a1 04 30 80 00       	mov    0x803004,%eax
  800e24:	8b 50 74             	mov    0x74(%eax),%edx
  800e27:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e2a:	39 c2                	cmp    %eax,%edx
  800e2c:	77 cb                	ja     800df9 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e31:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e34:	74 14                	je     800e4a <CheckWSWithoutLastIndex+0x16b>
		panic(
  800e36:	83 ec 04             	sub    $0x4,%esp
  800e39:	68 28 2a 80 00       	push   $0x802a28
  800e3e:	6a 44                	push   $0x44
  800e40:	68 c8 29 80 00       	push   $0x8029c8
  800e45:	e8 23 fe ff ff       	call   800c6d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e4a:	90                   	nop
  800e4b:	c9                   	leave  
  800e4c:	c3                   	ret    

00800e4d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e4d:	55                   	push   %ebp
  800e4e:	89 e5                	mov    %esp,%ebp
  800e50:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	8b 00                	mov    (%eax),%eax
  800e58:	8d 48 01             	lea    0x1(%eax),%ecx
  800e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e5e:	89 0a                	mov    %ecx,(%edx)
  800e60:	8b 55 08             	mov    0x8(%ebp),%edx
  800e63:	88 d1                	mov    %dl,%cl
  800e65:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e68:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	8b 00                	mov    (%eax),%eax
  800e71:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e76:	75 2c                	jne    800ea4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e78:	a0 08 30 80 00       	mov    0x803008,%al
  800e7d:	0f b6 c0             	movzbl %al,%eax
  800e80:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e83:	8b 12                	mov    (%edx),%edx
  800e85:	89 d1                	mov    %edx,%ecx
  800e87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e8a:	83 c2 08             	add    $0x8,%edx
  800e8d:	83 ec 04             	sub    $0x4,%esp
  800e90:	50                   	push   %eax
  800e91:	51                   	push   %ecx
  800e92:	52                   	push   %edx
  800e93:	e8 e0 0e 00 00       	call   801d78 <sys_cputs>
  800e98:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea7:	8b 40 04             	mov    0x4(%eax),%eax
  800eaa:	8d 50 01             	lea    0x1(%eax),%edx
  800ead:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb0:	89 50 04             	mov    %edx,0x4(%eax)
}
  800eb3:	90                   	nop
  800eb4:	c9                   	leave  
  800eb5:	c3                   	ret    

00800eb6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800eb6:	55                   	push   %ebp
  800eb7:	89 e5                	mov    %esp,%ebp
  800eb9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ebf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ec6:	00 00 00 
	b.cnt = 0;
  800ec9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ed0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ed3:	ff 75 0c             	pushl  0xc(%ebp)
  800ed6:	ff 75 08             	pushl  0x8(%ebp)
  800ed9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800edf:	50                   	push   %eax
  800ee0:	68 4d 0e 80 00       	push   $0x800e4d
  800ee5:	e8 11 02 00 00       	call   8010fb <vprintfmt>
  800eea:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800eed:	a0 08 30 80 00       	mov    0x803008,%al
  800ef2:	0f b6 c0             	movzbl %al,%eax
  800ef5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800efb:	83 ec 04             	sub    $0x4,%esp
  800efe:	50                   	push   %eax
  800eff:	52                   	push   %edx
  800f00:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f06:	83 c0 08             	add    $0x8,%eax
  800f09:	50                   	push   %eax
  800f0a:	e8 69 0e 00 00       	call   801d78 <sys_cputs>
  800f0f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f12:	c6 05 08 30 80 00 00 	movb   $0x0,0x803008
	return b.cnt;
  800f19:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f1f:	c9                   	leave  
  800f20:	c3                   	ret    

00800f21 <cprintf>:

int cprintf(const char *fmt, ...) {
  800f21:	55                   	push   %ebp
  800f22:	89 e5                	mov    %esp,%ebp
  800f24:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f27:	c6 05 08 30 80 00 01 	movb   $0x1,0x803008
	va_start(ap, fmt);
  800f2e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f31:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	83 ec 08             	sub    $0x8,%esp
  800f3a:	ff 75 f4             	pushl  -0xc(%ebp)
  800f3d:	50                   	push   %eax
  800f3e:	e8 73 ff ff ff       	call   800eb6 <vcprintf>
  800f43:	83 c4 10             	add    $0x10,%esp
  800f46:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f49:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f4c:	c9                   	leave  
  800f4d:	c3                   	ret    

00800f4e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f4e:	55                   	push   %ebp
  800f4f:	89 e5                	mov    %esp,%ebp
  800f51:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f54:	e8 30 10 00 00       	call   801f89 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f59:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	83 ec 08             	sub    $0x8,%esp
  800f65:	ff 75 f4             	pushl  -0xc(%ebp)
  800f68:	50                   	push   %eax
  800f69:	e8 48 ff ff ff       	call   800eb6 <vcprintf>
  800f6e:	83 c4 10             	add    $0x10,%esp
  800f71:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f74:	e8 2a 10 00 00       	call   801fa3 <sys_enable_interrupt>
	return cnt;
  800f79:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f7c:	c9                   	leave  
  800f7d:	c3                   	ret    

00800f7e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	53                   	push   %ebx
  800f82:	83 ec 14             	sub    $0x14,%esp
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f8b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f91:	8b 45 18             	mov    0x18(%ebp),%eax
  800f94:	ba 00 00 00 00       	mov    $0x0,%edx
  800f99:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f9c:	77 55                	ja     800ff3 <printnum+0x75>
  800f9e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fa1:	72 05                	jb     800fa8 <printnum+0x2a>
  800fa3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fa6:	77 4b                	ja     800ff3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800fa8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800fab:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800fae:	8b 45 18             	mov    0x18(%ebp),%eax
  800fb1:	ba 00 00 00 00       	mov    $0x0,%edx
  800fb6:	52                   	push   %edx
  800fb7:	50                   	push   %eax
  800fb8:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbb:	ff 75 f0             	pushl  -0x10(%ebp)
  800fbe:	e8 a5 13 00 00       	call   802368 <__udivdi3>
  800fc3:	83 c4 10             	add    $0x10,%esp
  800fc6:	83 ec 04             	sub    $0x4,%esp
  800fc9:	ff 75 20             	pushl  0x20(%ebp)
  800fcc:	53                   	push   %ebx
  800fcd:	ff 75 18             	pushl  0x18(%ebp)
  800fd0:	52                   	push   %edx
  800fd1:	50                   	push   %eax
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	ff 75 08             	pushl  0x8(%ebp)
  800fd8:	e8 a1 ff ff ff       	call   800f7e <printnum>
  800fdd:	83 c4 20             	add    $0x20,%esp
  800fe0:	eb 1a                	jmp    800ffc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800fe2:	83 ec 08             	sub    $0x8,%esp
  800fe5:	ff 75 0c             	pushl  0xc(%ebp)
  800fe8:	ff 75 20             	pushl  0x20(%ebp)
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	ff d0                	call   *%eax
  800ff0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ff3:	ff 4d 1c             	decl   0x1c(%ebp)
  800ff6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ffa:	7f e6                	jg     800fe2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ffc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800fff:	bb 00 00 00 00       	mov    $0x0,%ebx
  801004:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801007:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80100a:	53                   	push   %ebx
  80100b:	51                   	push   %ecx
  80100c:	52                   	push   %edx
  80100d:	50                   	push   %eax
  80100e:	e8 65 14 00 00       	call   802478 <__umoddi3>
  801013:	83 c4 10             	add    $0x10,%esp
  801016:	05 94 2c 80 00       	add    $0x802c94,%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	0f be c0             	movsbl %al,%eax
  801020:	83 ec 08             	sub    $0x8,%esp
  801023:	ff 75 0c             	pushl  0xc(%ebp)
  801026:	50                   	push   %eax
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	ff d0                	call   *%eax
  80102c:	83 c4 10             	add    $0x10,%esp
}
  80102f:	90                   	nop
  801030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801038:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80103c:	7e 1c                	jle    80105a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8b 00                	mov    (%eax),%eax
  801043:	8d 50 08             	lea    0x8(%eax),%edx
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 10                	mov    %edx,(%eax)
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	8b 00                	mov    (%eax),%eax
  801050:	83 e8 08             	sub    $0x8,%eax
  801053:	8b 50 04             	mov    0x4(%eax),%edx
  801056:	8b 00                	mov    (%eax),%eax
  801058:	eb 40                	jmp    80109a <getuint+0x65>
	else if (lflag)
  80105a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105e:	74 1e                	je     80107e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8b 00                	mov    (%eax),%eax
  801065:	8d 50 04             	lea    0x4(%eax),%edx
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	89 10                	mov    %edx,(%eax)
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8b 00                	mov    (%eax),%eax
  801072:	83 e8 04             	sub    $0x4,%eax
  801075:	8b 00                	mov    (%eax),%eax
  801077:	ba 00 00 00 00       	mov    $0x0,%edx
  80107c:	eb 1c                	jmp    80109a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8b 00                	mov    (%eax),%eax
  801083:	8d 50 04             	lea    0x4(%eax),%edx
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	89 10                	mov    %edx,(%eax)
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8b 00                	mov    (%eax),%eax
  801090:	83 e8 04             	sub    $0x4,%eax
  801093:	8b 00                	mov    (%eax),%eax
  801095:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80109a:	5d                   	pop    %ebp
  80109b:	c3                   	ret    

0080109c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80109c:	55                   	push   %ebp
  80109d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80109f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010a3:	7e 1c                	jle    8010c1 <getint+0x25>
		return va_arg(*ap, long long);
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8b 00                	mov    (%eax),%eax
  8010aa:	8d 50 08             	lea    0x8(%eax),%edx
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	89 10                	mov    %edx,(%eax)
  8010b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b5:	8b 00                	mov    (%eax),%eax
  8010b7:	83 e8 08             	sub    $0x8,%eax
  8010ba:	8b 50 04             	mov    0x4(%eax),%edx
  8010bd:	8b 00                	mov    (%eax),%eax
  8010bf:	eb 38                	jmp    8010f9 <getint+0x5d>
	else if (lflag)
  8010c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010c5:	74 1a                	je     8010e1 <getint+0x45>
		return va_arg(*ap, long);
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	8b 00                	mov    (%eax),%eax
  8010cc:	8d 50 04             	lea    0x4(%eax),%edx
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	89 10                	mov    %edx,(%eax)
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	8b 00                	mov    (%eax),%eax
  8010d9:	83 e8 04             	sub    $0x4,%eax
  8010dc:	8b 00                	mov    (%eax),%eax
  8010de:	99                   	cltd   
  8010df:	eb 18                	jmp    8010f9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8b 00                	mov    (%eax),%eax
  8010e6:	8d 50 04             	lea    0x4(%eax),%edx
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ec:	89 10                	mov    %edx,(%eax)
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	8b 00                	mov    (%eax),%eax
  8010f3:	83 e8 04             	sub    $0x4,%eax
  8010f6:	8b 00                	mov    (%eax),%eax
  8010f8:	99                   	cltd   
}
  8010f9:	5d                   	pop    %ebp
  8010fa:	c3                   	ret    

008010fb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8010fb:	55                   	push   %ebp
  8010fc:	89 e5                	mov    %esp,%ebp
  8010fe:	56                   	push   %esi
  8010ff:	53                   	push   %ebx
  801100:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801103:	eb 17                	jmp    80111c <vprintfmt+0x21>
			if (ch == '\0')
  801105:	85 db                	test   %ebx,%ebx
  801107:	0f 84 af 03 00 00    	je     8014bc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80110d:	83 ec 08             	sub    $0x8,%esp
  801110:	ff 75 0c             	pushl  0xc(%ebp)
  801113:	53                   	push   %ebx
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	ff d0                	call   *%eax
  801119:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80111c:	8b 45 10             	mov    0x10(%ebp),%eax
  80111f:	8d 50 01             	lea    0x1(%eax),%edx
  801122:	89 55 10             	mov    %edx,0x10(%ebp)
  801125:	8a 00                	mov    (%eax),%al
  801127:	0f b6 d8             	movzbl %al,%ebx
  80112a:	83 fb 25             	cmp    $0x25,%ebx
  80112d:	75 d6                	jne    801105 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80112f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801133:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80113a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801141:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801148:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80114f:	8b 45 10             	mov    0x10(%ebp),%eax
  801152:	8d 50 01             	lea    0x1(%eax),%edx
  801155:	89 55 10             	mov    %edx,0x10(%ebp)
  801158:	8a 00                	mov    (%eax),%al
  80115a:	0f b6 d8             	movzbl %al,%ebx
  80115d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801160:	83 f8 55             	cmp    $0x55,%eax
  801163:	0f 87 2b 03 00 00    	ja     801494 <vprintfmt+0x399>
  801169:	8b 04 85 b8 2c 80 00 	mov    0x802cb8(,%eax,4),%eax
  801170:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801172:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801176:	eb d7                	jmp    80114f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801178:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80117c:	eb d1                	jmp    80114f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80117e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801185:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801188:	89 d0                	mov    %edx,%eax
  80118a:	c1 e0 02             	shl    $0x2,%eax
  80118d:	01 d0                	add    %edx,%eax
  80118f:	01 c0                	add    %eax,%eax
  801191:	01 d8                	add    %ebx,%eax
  801193:	83 e8 30             	sub    $0x30,%eax
  801196:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8011a1:	83 fb 2f             	cmp    $0x2f,%ebx
  8011a4:	7e 3e                	jle    8011e4 <vprintfmt+0xe9>
  8011a6:	83 fb 39             	cmp    $0x39,%ebx
  8011a9:	7f 39                	jg     8011e4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011ab:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8011ae:	eb d5                	jmp    801185 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8011b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b3:	83 c0 04             	add    $0x4,%eax
  8011b6:	89 45 14             	mov    %eax,0x14(%ebp)
  8011b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bc:	83 e8 04             	sub    $0x4,%eax
  8011bf:	8b 00                	mov    (%eax),%eax
  8011c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8011c4:	eb 1f                	jmp    8011e5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8011c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011ca:	79 83                	jns    80114f <vprintfmt+0x54>
				width = 0;
  8011cc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8011d3:	e9 77 ff ff ff       	jmp    80114f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8011d8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8011df:	e9 6b ff ff ff       	jmp    80114f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8011e4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8011e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011e9:	0f 89 60 ff ff ff    	jns    80114f <vprintfmt+0x54>
				width = precision, precision = -1;
  8011ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8011f5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8011fc:	e9 4e ff ff ff       	jmp    80114f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801201:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801204:	e9 46 ff ff ff       	jmp    80114f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801209:	8b 45 14             	mov    0x14(%ebp),%eax
  80120c:	83 c0 04             	add    $0x4,%eax
  80120f:	89 45 14             	mov    %eax,0x14(%ebp)
  801212:	8b 45 14             	mov    0x14(%ebp),%eax
  801215:	83 e8 04             	sub    $0x4,%eax
  801218:	8b 00                	mov    (%eax),%eax
  80121a:	83 ec 08             	sub    $0x8,%esp
  80121d:	ff 75 0c             	pushl  0xc(%ebp)
  801220:	50                   	push   %eax
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	ff d0                	call   *%eax
  801226:	83 c4 10             	add    $0x10,%esp
			break;
  801229:	e9 89 02 00 00       	jmp    8014b7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80122e:	8b 45 14             	mov    0x14(%ebp),%eax
  801231:	83 c0 04             	add    $0x4,%eax
  801234:	89 45 14             	mov    %eax,0x14(%ebp)
  801237:	8b 45 14             	mov    0x14(%ebp),%eax
  80123a:	83 e8 04             	sub    $0x4,%eax
  80123d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80123f:	85 db                	test   %ebx,%ebx
  801241:	79 02                	jns    801245 <vprintfmt+0x14a>
				err = -err;
  801243:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801245:	83 fb 64             	cmp    $0x64,%ebx
  801248:	7f 0b                	jg     801255 <vprintfmt+0x15a>
  80124a:	8b 34 9d 00 2b 80 00 	mov    0x802b00(,%ebx,4),%esi
  801251:	85 f6                	test   %esi,%esi
  801253:	75 19                	jne    80126e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801255:	53                   	push   %ebx
  801256:	68 a5 2c 80 00       	push   $0x802ca5
  80125b:	ff 75 0c             	pushl  0xc(%ebp)
  80125e:	ff 75 08             	pushl  0x8(%ebp)
  801261:	e8 5e 02 00 00       	call   8014c4 <printfmt>
  801266:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801269:	e9 49 02 00 00       	jmp    8014b7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80126e:	56                   	push   %esi
  80126f:	68 ae 2c 80 00       	push   $0x802cae
  801274:	ff 75 0c             	pushl  0xc(%ebp)
  801277:	ff 75 08             	pushl  0x8(%ebp)
  80127a:	e8 45 02 00 00       	call   8014c4 <printfmt>
  80127f:	83 c4 10             	add    $0x10,%esp
			break;
  801282:	e9 30 02 00 00       	jmp    8014b7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801287:	8b 45 14             	mov    0x14(%ebp),%eax
  80128a:	83 c0 04             	add    $0x4,%eax
  80128d:	89 45 14             	mov    %eax,0x14(%ebp)
  801290:	8b 45 14             	mov    0x14(%ebp),%eax
  801293:	83 e8 04             	sub    $0x4,%eax
  801296:	8b 30                	mov    (%eax),%esi
  801298:	85 f6                	test   %esi,%esi
  80129a:	75 05                	jne    8012a1 <vprintfmt+0x1a6>
				p = "(null)";
  80129c:	be b1 2c 80 00       	mov    $0x802cb1,%esi
			if (width > 0 && padc != '-')
  8012a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012a5:	7e 6d                	jle    801314 <vprintfmt+0x219>
  8012a7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8012ab:	74 67                	je     801314 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8012ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012b0:	83 ec 08             	sub    $0x8,%esp
  8012b3:	50                   	push   %eax
  8012b4:	56                   	push   %esi
  8012b5:	e8 0c 03 00 00       	call   8015c6 <strnlen>
  8012ba:	83 c4 10             	add    $0x10,%esp
  8012bd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8012c0:	eb 16                	jmp    8012d8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8012c2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8012c6:	83 ec 08             	sub    $0x8,%esp
  8012c9:	ff 75 0c             	pushl  0xc(%ebp)
  8012cc:	50                   	push   %eax
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	ff d0                	call   *%eax
  8012d2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8012d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8012d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012dc:	7f e4                	jg     8012c2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012de:	eb 34                	jmp    801314 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8012e0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8012e4:	74 1c                	je     801302 <vprintfmt+0x207>
  8012e6:	83 fb 1f             	cmp    $0x1f,%ebx
  8012e9:	7e 05                	jle    8012f0 <vprintfmt+0x1f5>
  8012eb:	83 fb 7e             	cmp    $0x7e,%ebx
  8012ee:	7e 12                	jle    801302 <vprintfmt+0x207>
					putch('?', putdat);
  8012f0:	83 ec 08             	sub    $0x8,%esp
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	6a 3f                	push   $0x3f
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	ff d0                	call   *%eax
  8012fd:	83 c4 10             	add    $0x10,%esp
  801300:	eb 0f                	jmp    801311 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801302:	83 ec 08             	sub    $0x8,%esp
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	53                   	push   %ebx
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	ff d0                	call   *%eax
  80130e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801311:	ff 4d e4             	decl   -0x1c(%ebp)
  801314:	89 f0                	mov    %esi,%eax
  801316:	8d 70 01             	lea    0x1(%eax),%esi
  801319:	8a 00                	mov    (%eax),%al
  80131b:	0f be d8             	movsbl %al,%ebx
  80131e:	85 db                	test   %ebx,%ebx
  801320:	74 24                	je     801346 <vprintfmt+0x24b>
  801322:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801326:	78 b8                	js     8012e0 <vprintfmt+0x1e5>
  801328:	ff 4d e0             	decl   -0x20(%ebp)
  80132b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80132f:	79 af                	jns    8012e0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801331:	eb 13                	jmp    801346 <vprintfmt+0x24b>
				putch(' ', putdat);
  801333:	83 ec 08             	sub    $0x8,%esp
  801336:	ff 75 0c             	pushl  0xc(%ebp)
  801339:	6a 20                	push   $0x20
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	ff d0                	call   *%eax
  801340:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801343:	ff 4d e4             	decl   -0x1c(%ebp)
  801346:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80134a:	7f e7                	jg     801333 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80134c:	e9 66 01 00 00       	jmp    8014b7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801351:	83 ec 08             	sub    $0x8,%esp
  801354:	ff 75 e8             	pushl  -0x18(%ebp)
  801357:	8d 45 14             	lea    0x14(%ebp),%eax
  80135a:	50                   	push   %eax
  80135b:	e8 3c fd ff ff       	call   80109c <getint>
  801360:	83 c4 10             	add    $0x10,%esp
  801363:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801366:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801369:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80136c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80136f:	85 d2                	test   %edx,%edx
  801371:	79 23                	jns    801396 <vprintfmt+0x29b>
				putch('-', putdat);
  801373:	83 ec 08             	sub    $0x8,%esp
  801376:	ff 75 0c             	pushl  0xc(%ebp)
  801379:	6a 2d                	push   $0x2d
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	ff d0                	call   *%eax
  801380:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801383:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801386:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801389:	f7 d8                	neg    %eax
  80138b:	83 d2 00             	adc    $0x0,%edx
  80138e:	f7 da                	neg    %edx
  801390:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801393:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801396:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80139d:	e9 bc 00 00 00       	jmp    80145e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8013a2:	83 ec 08             	sub    $0x8,%esp
  8013a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8013a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8013ab:	50                   	push   %eax
  8013ac:	e8 84 fc ff ff       	call   801035 <getuint>
  8013b1:	83 c4 10             	add    $0x10,%esp
  8013b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8013ba:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013c1:	e9 98 00 00 00       	jmp    80145e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8013c6:	83 ec 08             	sub    $0x8,%esp
  8013c9:	ff 75 0c             	pushl  0xc(%ebp)
  8013cc:	6a 58                	push   $0x58
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	ff d0                	call   *%eax
  8013d3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013d6:	83 ec 08             	sub    $0x8,%esp
  8013d9:	ff 75 0c             	pushl  0xc(%ebp)
  8013dc:	6a 58                	push   $0x58
  8013de:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e1:	ff d0                	call   *%eax
  8013e3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013e6:	83 ec 08             	sub    $0x8,%esp
  8013e9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ec:	6a 58                	push   $0x58
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	ff d0                	call   *%eax
  8013f3:	83 c4 10             	add    $0x10,%esp
			break;
  8013f6:	e9 bc 00 00 00       	jmp    8014b7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8013fb:	83 ec 08             	sub    $0x8,%esp
  8013fe:	ff 75 0c             	pushl  0xc(%ebp)
  801401:	6a 30                	push   $0x30
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	ff d0                	call   *%eax
  801408:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80140b:	83 ec 08             	sub    $0x8,%esp
  80140e:	ff 75 0c             	pushl  0xc(%ebp)
  801411:	6a 78                	push   $0x78
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	ff d0                	call   *%eax
  801418:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80141b:	8b 45 14             	mov    0x14(%ebp),%eax
  80141e:	83 c0 04             	add    $0x4,%eax
  801421:	89 45 14             	mov    %eax,0x14(%ebp)
  801424:	8b 45 14             	mov    0x14(%ebp),%eax
  801427:	83 e8 04             	sub    $0x4,%eax
  80142a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80142c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80142f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801436:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80143d:	eb 1f                	jmp    80145e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80143f:	83 ec 08             	sub    $0x8,%esp
  801442:	ff 75 e8             	pushl  -0x18(%ebp)
  801445:	8d 45 14             	lea    0x14(%ebp),%eax
  801448:	50                   	push   %eax
  801449:	e8 e7 fb ff ff       	call   801035 <getuint>
  80144e:	83 c4 10             	add    $0x10,%esp
  801451:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801454:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801457:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80145e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801462:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801465:	83 ec 04             	sub    $0x4,%esp
  801468:	52                   	push   %edx
  801469:	ff 75 e4             	pushl  -0x1c(%ebp)
  80146c:	50                   	push   %eax
  80146d:	ff 75 f4             	pushl  -0xc(%ebp)
  801470:	ff 75 f0             	pushl  -0x10(%ebp)
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	ff 75 08             	pushl  0x8(%ebp)
  801479:	e8 00 fb ff ff       	call   800f7e <printnum>
  80147e:	83 c4 20             	add    $0x20,%esp
			break;
  801481:	eb 34                	jmp    8014b7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801483:	83 ec 08             	sub    $0x8,%esp
  801486:	ff 75 0c             	pushl  0xc(%ebp)
  801489:	53                   	push   %ebx
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	ff d0                	call   *%eax
  80148f:	83 c4 10             	add    $0x10,%esp
			break;
  801492:	eb 23                	jmp    8014b7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801494:	83 ec 08             	sub    $0x8,%esp
  801497:	ff 75 0c             	pushl  0xc(%ebp)
  80149a:	6a 25                	push   $0x25
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	ff d0                	call   *%eax
  8014a1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8014a4:	ff 4d 10             	decl   0x10(%ebp)
  8014a7:	eb 03                	jmp    8014ac <vprintfmt+0x3b1>
  8014a9:	ff 4d 10             	decl   0x10(%ebp)
  8014ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8014af:	48                   	dec    %eax
  8014b0:	8a 00                	mov    (%eax),%al
  8014b2:	3c 25                	cmp    $0x25,%al
  8014b4:	75 f3                	jne    8014a9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8014b6:	90                   	nop
		}
	}
  8014b7:	e9 47 fc ff ff       	jmp    801103 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8014bc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8014bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014c0:	5b                   	pop    %ebx
  8014c1:	5e                   	pop    %esi
  8014c2:	5d                   	pop    %ebp
  8014c3:	c3                   	ret    

008014c4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8014ca:	8d 45 10             	lea    0x10(%ebp),%eax
  8014cd:	83 c0 04             	add    $0x4,%eax
  8014d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8014d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8014d9:	50                   	push   %eax
  8014da:	ff 75 0c             	pushl  0xc(%ebp)
  8014dd:	ff 75 08             	pushl  0x8(%ebp)
  8014e0:	e8 16 fc ff ff       	call   8010fb <vprintfmt>
  8014e5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8014e8:	90                   	nop
  8014e9:	c9                   	leave  
  8014ea:	c3                   	ret    

008014eb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8014eb:	55                   	push   %ebp
  8014ec:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8014ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f1:	8b 40 08             	mov    0x8(%eax),%eax
  8014f4:	8d 50 01             	lea    0x1(%eax),%edx
  8014f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8014fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801500:	8b 10                	mov    (%eax),%edx
  801502:	8b 45 0c             	mov    0xc(%ebp),%eax
  801505:	8b 40 04             	mov    0x4(%eax),%eax
  801508:	39 c2                	cmp    %eax,%edx
  80150a:	73 12                	jae    80151e <sprintputch+0x33>
		*b->buf++ = ch;
  80150c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150f:	8b 00                	mov    (%eax),%eax
  801511:	8d 48 01             	lea    0x1(%eax),%ecx
  801514:	8b 55 0c             	mov    0xc(%ebp),%edx
  801517:	89 0a                	mov    %ecx,(%edx)
  801519:	8b 55 08             	mov    0x8(%ebp),%edx
  80151c:	88 10                	mov    %dl,(%eax)
}
  80151e:	90                   	nop
  80151f:	5d                   	pop    %ebp
  801520:	c3                   	ret    

00801521 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
  801524:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80152d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801530:	8d 50 ff             	lea    -0x1(%eax),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	01 d0                	add    %edx,%eax
  801538:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80153b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801542:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801546:	74 06                	je     80154e <vsnprintf+0x2d>
  801548:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80154c:	7f 07                	jg     801555 <vsnprintf+0x34>
		return -E_INVAL;
  80154e:	b8 03 00 00 00       	mov    $0x3,%eax
  801553:	eb 20                	jmp    801575 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801555:	ff 75 14             	pushl  0x14(%ebp)
  801558:	ff 75 10             	pushl  0x10(%ebp)
  80155b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80155e:	50                   	push   %eax
  80155f:	68 eb 14 80 00       	push   $0x8014eb
  801564:	e8 92 fb ff ff       	call   8010fb <vprintfmt>
  801569:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80156c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80156f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801572:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
  80157a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80157d:	8d 45 10             	lea    0x10(%ebp),%eax
  801580:	83 c0 04             	add    $0x4,%eax
  801583:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801586:	8b 45 10             	mov    0x10(%ebp),%eax
  801589:	ff 75 f4             	pushl  -0xc(%ebp)
  80158c:	50                   	push   %eax
  80158d:	ff 75 0c             	pushl  0xc(%ebp)
  801590:	ff 75 08             	pushl  0x8(%ebp)
  801593:	e8 89 ff ff ff       	call   801521 <vsnprintf>
  801598:	83 c4 10             	add    $0x10,%esp
  80159b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80159e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015a1:	c9                   	leave  
  8015a2:	c3                   	ret    

008015a3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8015a3:	55                   	push   %ebp
  8015a4:	89 e5                	mov    %esp,%ebp
  8015a6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8015a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015b0:	eb 06                	jmp    8015b8 <strlen+0x15>
		n++;
  8015b2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8015b5:	ff 45 08             	incl   0x8(%ebp)
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	84 c0                	test   %al,%al
  8015bf:	75 f1                	jne    8015b2 <strlen+0xf>
		n++;
	return n;
  8015c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
  8015c9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015d3:	eb 09                	jmp    8015de <strnlen+0x18>
		n++;
  8015d5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015d8:	ff 45 08             	incl   0x8(%ebp)
  8015db:	ff 4d 0c             	decl   0xc(%ebp)
  8015de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015e2:	74 09                	je     8015ed <strnlen+0x27>
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	84 c0                	test   %al,%al
  8015eb:	75 e8                	jne    8015d5 <strnlen+0xf>
		n++;
	return n;
  8015ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8015fe:	90                   	nop
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	8d 50 01             	lea    0x1(%eax),%edx
  801605:	89 55 08             	mov    %edx,0x8(%ebp)
  801608:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80160e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801611:	8a 12                	mov    (%edx),%dl
  801613:	88 10                	mov    %dl,(%eax)
  801615:	8a 00                	mov    (%eax),%al
  801617:	84 c0                	test   %al,%al
  801619:	75 e4                	jne    8015ff <strcpy+0xd>
		/* do nothing */;
	return ret;
  80161b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
  801623:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80162c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801633:	eb 1f                	jmp    801654 <strncpy+0x34>
		*dst++ = *src;
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8d 50 01             	lea    0x1(%eax),%edx
  80163b:	89 55 08             	mov    %edx,0x8(%ebp)
  80163e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801641:	8a 12                	mov    (%edx),%dl
  801643:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801645:	8b 45 0c             	mov    0xc(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	84 c0                	test   %al,%al
  80164c:	74 03                	je     801651 <strncpy+0x31>
			src++;
  80164e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801651:	ff 45 fc             	incl   -0x4(%ebp)
  801654:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801657:	3b 45 10             	cmp    0x10(%ebp),%eax
  80165a:	72 d9                	jb     801635 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80165c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80166d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801671:	74 30                	je     8016a3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801673:	eb 16                	jmp    80168b <strlcpy+0x2a>
			*dst++ = *src++;
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	8d 50 01             	lea    0x1(%eax),%edx
  80167b:	89 55 08             	mov    %edx,0x8(%ebp)
  80167e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801681:	8d 4a 01             	lea    0x1(%edx),%ecx
  801684:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801687:	8a 12                	mov    (%edx),%dl
  801689:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80168b:	ff 4d 10             	decl   0x10(%ebp)
  80168e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801692:	74 09                	je     80169d <strlcpy+0x3c>
  801694:	8b 45 0c             	mov    0xc(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	84 c0                	test   %al,%al
  80169b:	75 d8                	jne    801675 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8016a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8016a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a9:	29 c2                	sub    %eax,%edx
  8016ab:	89 d0                	mov    %edx,%eax
}
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8016b2:	eb 06                	jmp    8016ba <strcmp+0xb>
		p++, q++;
  8016b4:	ff 45 08             	incl   0x8(%ebp)
  8016b7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	84 c0                	test   %al,%al
  8016c1:	74 0e                	je     8016d1 <strcmp+0x22>
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 10                	mov    (%eax),%dl
  8016c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cb:	8a 00                	mov    (%eax),%al
  8016cd:	38 c2                	cmp    %al,%dl
  8016cf:	74 e3                	je     8016b4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	0f b6 d0             	movzbl %al,%edx
  8016d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016dc:	8a 00                	mov    (%eax),%al
  8016de:	0f b6 c0             	movzbl %al,%eax
  8016e1:	29 c2                	sub    %eax,%edx
  8016e3:	89 d0                	mov    %edx,%eax
}
  8016e5:	5d                   	pop    %ebp
  8016e6:	c3                   	ret    

008016e7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8016ea:	eb 09                	jmp    8016f5 <strncmp+0xe>
		n--, p++, q++;
  8016ec:	ff 4d 10             	decl   0x10(%ebp)
  8016ef:	ff 45 08             	incl   0x8(%ebp)
  8016f2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8016f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016f9:	74 17                	je     801712 <strncmp+0x2b>
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	84 c0                	test   %al,%al
  801702:	74 0e                	je     801712 <strncmp+0x2b>
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	8a 10                	mov    (%eax),%dl
  801709:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170c:	8a 00                	mov    (%eax),%al
  80170e:	38 c2                	cmp    %al,%dl
  801710:	74 da                	je     8016ec <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801712:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801716:	75 07                	jne    80171f <strncmp+0x38>
		return 0;
  801718:	b8 00 00 00 00       	mov    $0x0,%eax
  80171d:	eb 14                	jmp    801733 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80171f:	8b 45 08             	mov    0x8(%ebp),%eax
  801722:	8a 00                	mov    (%eax),%al
  801724:	0f b6 d0             	movzbl %al,%edx
  801727:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172a:	8a 00                	mov    (%eax),%al
  80172c:	0f b6 c0             	movzbl %al,%eax
  80172f:	29 c2                	sub    %eax,%edx
  801731:	89 d0                	mov    %edx,%eax
}
  801733:	5d                   	pop    %ebp
  801734:	c3                   	ret    

00801735 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 04             	sub    $0x4,%esp
  80173b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801741:	eb 12                	jmp    801755 <strchr+0x20>
		if (*s == c)
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
  801746:	8a 00                	mov    (%eax),%al
  801748:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80174b:	75 05                	jne    801752 <strchr+0x1d>
			return (char *) s;
  80174d:	8b 45 08             	mov    0x8(%ebp),%eax
  801750:	eb 11                	jmp    801763 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801752:	ff 45 08             	incl   0x8(%ebp)
  801755:	8b 45 08             	mov    0x8(%ebp),%eax
  801758:	8a 00                	mov    (%eax),%al
  80175a:	84 c0                	test   %al,%al
  80175c:	75 e5                	jne    801743 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80175e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
  801768:	83 ec 04             	sub    $0x4,%esp
  80176b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801771:	eb 0d                	jmp    801780 <strfind+0x1b>
		if (*s == c)
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	8a 00                	mov    (%eax),%al
  801778:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80177b:	74 0e                	je     80178b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80177d:	ff 45 08             	incl   0x8(%ebp)
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	8a 00                	mov    (%eax),%al
  801785:	84 c0                	test   %al,%al
  801787:	75 ea                	jne    801773 <strfind+0xe>
  801789:	eb 01                	jmp    80178c <strfind+0x27>
		if (*s == c)
			break;
  80178b:	90                   	nop
	return (char *) s;
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80179d:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8017a3:	eb 0e                	jmp    8017b3 <memset+0x22>
		*p++ = c;
  8017a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017a8:	8d 50 01             	lea    0x1(%eax),%edx
  8017ab:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8017b3:	ff 4d f8             	decl   -0x8(%ebp)
  8017b6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8017ba:	79 e9                	jns    8017a5 <memset+0x14>
		*p++ = c;

	return v;
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
  8017c4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8017d3:	eb 16                	jmp    8017eb <memcpy+0x2a>
		*d++ = *s++;
  8017d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d8:	8d 50 01             	lea    0x1(%eax),%edx
  8017db:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017e4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017e7:	8a 12                	mov    (%edx),%dl
  8017e9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8017eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8017f4:	85 c0                	test   %eax,%eax
  8017f6:	75 dd                	jne    8017d5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8017f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
  801800:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80180f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801812:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801815:	73 50                	jae    801867 <memmove+0x6a>
  801817:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80181a:	8b 45 10             	mov    0x10(%ebp),%eax
  80181d:	01 d0                	add    %edx,%eax
  80181f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801822:	76 43                	jbe    801867 <memmove+0x6a>
		s += n;
  801824:	8b 45 10             	mov    0x10(%ebp),%eax
  801827:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80182a:	8b 45 10             	mov    0x10(%ebp),%eax
  80182d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801830:	eb 10                	jmp    801842 <memmove+0x45>
			*--d = *--s;
  801832:	ff 4d f8             	decl   -0x8(%ebp)
  801835:	ff 4d fc             	decl   -0x4(%ebp)
  801838:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183b:	8a 10                	mov    (%eax),%dl
  80183d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801840:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801842:	8b 45 10             	mov    0x10(%ebp),%eax
  801845:	8d 50 ff             	lea    -0x1(%eax),%edx
  801848:	89 55 10             	mov    %edx,0x10(%ebp)
  80184b:	85 c0                	test   %eax,%eax
  80184d:	75 e3                	jne    801832 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80184f:	eb 23                	jmp    801874 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801851:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801854:	8d 50 01             	lea    0x1(%eax),%edx
  801857:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80185a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80185d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801860:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801863:	8a 12                	mov    (%edx),%dl
  801865:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801867:	8b 45 10             	mov    0x10(%ebp),%eax
  80186a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80186d:	89 55 10             	mov    %edx,0x10(%ebp)
  801870:	85 c0                	test   %eax,%eax
  801872:	75 dd                	jne    801851 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
  80187c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801885:	8b 45 0c             	mov    0xc(%ebp),%eax
  801888:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80188b:	eb 2a                	jmp    8018b7 <memcmp+0x3e>
		if (*s1 != *s2)
  80188d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801890:	8a 10                	mov    (%eax),%dl
  801892:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	38 c2                	cmp    %al,%dl
  801899:	74 16                	je     8018b1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80189b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80189e:	8a 00                	mov    (%eax),%al
  8018a0:	0f b6 d0             	movzbl %al,%edx
  8018a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a6:	8a 00                	mov    (%eax),%al
  8018a8:	0f b6 c0             	movzbl %al,%eax
  8018ab:	29 c2                	sub    %eax,%edx
  8018ad:	89 d0                	mov    %edx,%eax
  8018af:	eb 18                	jmp    8018c9 <memcmp+0x50>
		s1++, s2++;
  8018b1:	ff 45 fc             	incl   -0x4(%ebp)
  8018b4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8018b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8018c0:	85 c0                	test   %eax,%eax
  8018c2:	75 c9                	jne    80188d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8018c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c9:	c9                   	leave  
  8018ca:	c3                   	ret    

008018cb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8018cb:	55                   	push   %ebp
  8018cc:	89 e5                	mov    %esp,%ebp
  8018ce:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8018d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8018d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d7:	01 d0                	add    %edx,%eax
  8018d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8018dc:	eb 15                	jmp    8018f3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8018de:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e1:	8a 00                	mov    (%eax),%al
  8018e3:	0f b6 d0             	movzbl %al,%edx
  8018e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e9:	0f b6 c0             	movzbl %al,%eax
  8018ec:	39 c2                	cmp    %eax,%edx
  8018ee:	74 0d                	je     8018fd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8018f0:	ff 45 08             	incl   0x8(%ebp)
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8018f9:	72 e3                	jb     8018de <memfind+0x13>
  8018fb:	eb 01                	jmp    8018fe <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8018fd:	90                   	nop
	return (void *) s;
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
  801906:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801909:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801910:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801917:	eb 03                	jmp    80191c <strtol+0x19>
		s++;
  801919:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	8a 00                	mov    (%eax),%al
  801921:	3c 20                	cmp    $0x20,%al
  801923:	74 f4                	je     801919 <strtol+0x16>
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	8a 00                	mov    (%eax),%al
  80192a:	3c 09                	cmp    $0x9,%al
  80192c:	74 eb                	je     801919 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	8a 00                	mov    (%eax),%al
  801933:	3c 2b                	cmp    $0x2b,%al
  801935:	75 05                	jne    80193c <strtol+0x39>
		s++;
  801937:	ff 45 08             	incl   0x8(%ebp)
  80193a:	eb 13                	jmp    80194f <strtol+0x4c>
	else if (*s == '-')
  80193c:	8b 45 08             	mov    0x8(%ebp),%eax
  80193f:	8a 00                	mov    (%eax),%al
  801941:	3c 2d                	cmp    $0x2d,%al
  801943:	75 0a                	jne    80194f <strtol+0x4c>
		s++, neg = 1;
  801945:	ff 45 08             	incl   0x8(%ebp)
  801948:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80194f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801953:	74 06                	je     80195b <strtol+0x58>
  801955:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801959:	75 20                	jne    80197b <strtol+0x78>
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	8a 00                	mov    (%eax),%al
  801960:	3c 30                	cmp    $0x30,%al
  801962:	75 17                	jne    80197b <strtol+0x78>
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	40                   	inc    %eax
  801968:	8a 00                	mov    (%eax),%al
  80196a:	3c 78                	cmp    $0x78,%al
  80196c:	75 0d                	jne    80197b <strtol+0x78>
		s += 2, base = 16;
  80196e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801972:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801979:	eb 28                	jmp    8019a3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80197b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80197f:	75 15                	jne    801996 <strtol+0x93>
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	8a 00                	mov    (%eax),%al
  801986:	3c 30                	cmp    $0x30,%al
  801988:	75 0c                	jne    801996 <strtol+0x93>
		s++, base = 8;
  80198a:	ff 45 08             	incl   0x8(%ebp)
  80198d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801994:	eb 0d                	jmp    8019a3 <strtol+0xa0>
	else if (base == 0)
  801996:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80199a:	75 07                	jne    8019a3 <strtol+0xa0>
		base = 10;
  80199c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	8a 00                	mov    (%eax),%al
  8019a8:	3c 2f                	cmp    $0x2f,%al
  8019aa:	7e 19                	jle    8019c5 <strtol+0xc2>
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	8a 00                	mov    (%eax),%al
  8019b1:	3c 39                	cmp    $0x39,%al
  8019b3:	7f 10                	jg     8019c5 <strtol+0xc2>
			dig = *s - '0';
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	8a 00                	mov    (%eax),%al
  8019ba:	0f be c0             	movsbl %al,%eax
  8019bd:	83 e8 30             	sub    $0x30,%eax
  8019c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019c3:	eb 42                	jmp    801a07 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8019c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c8:	8a 00                	mov    (%eax),%al
  8019ca:	3c 60                	cmp    $0x60,%al
  8019cc:	7e 19                	jle    8019e7 <strtol+0xe4>
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	8a 00                	mov    (%eax),%al
  8019d3:	3c 7a                	cmp    $0x7a,%al
  8019d5:	7f 10                	jg     8019e7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8019d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019da:	8a 00                	mov    (%eax),%al
  8019dc:	0f be c0             	movsbl %al,%eax
  8019df:	83 e8 57             	sub    $0x57,%eax
  8019e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019e5:	eb 20                	jmp    801a07 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	3c 40                	cmp    $0x40,%al
  8019ee:	7e 39                	jle    801a29 <strtol+0x126>
  8019f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f3:	8a 00                	mov    (%eax),%al
  8019f5:	3c 5a                	cmp    $0x5a,%al
  8019f7:	7f 30                	jg     801a29 <strtol+0x126>
			dig = *s - 'A' + 10;
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	8a 00                	mov    (%eax),%al
  8019fe:	0f be c0             	movsbl %al,%eax
  801a01:	83 e8 37             	sub    $0x37,%eax
  801a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a0a:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a0d:	7d 19                	jge    801a28 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a0f:	ff 45 08             	incl   0x8(%ebp)
  801a12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a15:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a19:	89 c2                	mov    %eax,%edx
  801a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a1e:	01 d0                	add    %edx,%eax
  801a20:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a23:	e9 7b ff ff ff       	jmp    8019a3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a28:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a2d:	74 08                	je     801a37 <strtol+0x134>
		*endptr = (char *) s;
  801a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a32:	8b 55 08             	mov    0x8(%ebp),%edx
  801a35:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a37:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a3b:	74 07                	je     801a44 <strtol+0x141>
  801a3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a40:	f7 d8                	neg    %eax
  801a42:	eb 03                	jmp    801a47 <strtol+0x144>
  801a44:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a47:	c9                   	leave  
  801a48:	c3                   	ret    

00801a49 <ltostr>:

void
ltostr(long value, char *str)
{
  801a49:	55                   	push   %ebp
  801a4a:	89 e5                	mov    %esp,%ebp
  801a4c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a4f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a56:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a5d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a61:	79 13                	jns    801a76 <ltostr+0x2d>
	{
		neg = 1;
  801a63:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a6d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a70:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a73:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a7e:	99                   	cltd   
  801a7f:	f7 f9                	idiv   %ecx
  801a81:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a87:	8d 50 01             	lea    0x1(%eax),%edx
  801a8a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a8d:	89 c2                	mov    %eax,%edx
  801a8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a92:	01 d0                	add    %edx,%eax
  801a94:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a97:	83 c2 30             	add    $0x30,%edx
  801a9a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a9c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a9f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801aa4:	f7 e9                	imul   %ecx
  801aa6:	c1 fa 02             	sar    $0x2,%edx
  801aa9:	89 c8                	mov    %ecx,%eax
  801aab:	c1 f8 1f             	sar    $0x1f,%eax
  801aae:	29 c2                	sub    %eax,%edx
  801ab0:	89 d0                	mov    %edx,%eax
  801ab2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801ab5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ab8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801abd:	f7 e9                	imul   %ecx
  801abf:	c1 fa 02             	sar    $0x2,%edx
  801ac2:	89 c8                	mov    %ecx,%eax
  801ac4:	c1 f8 1f             	sar    $0x1f,%eax
  801ac7:	29 c2                	sub    %eax,%edx
  801ac9:	89 d0                	mov    %edx,%eax
  801acb:	c1 e0 02             	shl    $0x2,%eax
  801ace:	01 d0                	add    %edx,%eax
  801ad0:	01 c0                	add    %eax,%eax
  801ad2:	29 c1                	sub    %eax,%ecx
  801ad4:	89 ca                	mov    %ecx,%edx
  801ad6:	85 d2                	test   %edx,%edx
  801ad8:	75 9c                	jne    801a76 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801ada:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801ae1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae4:	48                   	dec    %eax
  801ae5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801ae8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801aec:	74 3d                	je     801b2b <ltostr+0xe2>
		start = 1 ;
  801aee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801af5:	eb 34                	jmp    801b2b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801af7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afd:	01 d0                	add    %edx,%eax
  801aff:	8a 00                	mov    (%eax),%al
  801b01:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b04:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b0a:	01 c2                	add    %eax,%edx
  801b0c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b12:	01 c8                	add    %ecx,%eax
  801b14:	8a 00                	mov    (%eax),%al
  801b16:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b18:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b1e:	01 c2                	add    %eax,%edx
  801b20:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b23:	88 02                	mov    %al,(%edx)
		start++ ;
  801b25:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b28:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b2e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b31:	7c c4                	jl     801af7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b33:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b36:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b39:	01 d0                	add    %edx,%eax
  801b3b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b3e:	90                   	nop
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b47:	ff 75 08             	pushl  0x8(%ebp)
  801b4a:	e8 54 fa ff ff       	call   8015a3 <strlen>
  801b4f:	83 c4 04             	add    $0x4,%esp
  801b52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b55:	ff 75 0c             	pushl  0xc(%ebp)
  801b58:	e8 46 fa ff ff       	call   8015a3 <strlen>
  801b5d:	83 c4 04             	add    $0x4,%esp
  801b60:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b71:	eb 17                	jmp    801b8a <strcconcat+0x49>
		final[s] = str1[s] ;
  801b73:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b76:	8b 45 10             	mov    0x10(%ebp),%eax
  801b79:	01 c2                	add    %eax,%edx
  801b7b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b81:	01 c8                	add    %ecx,%eax
  801b83:	8a 00                	mov    (%eax),%al
  801b85:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b87:	ff 45 fc             	incl   -0x4(%ebp)
  801b8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b8d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b90:	7c e1                	jl     801b73 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b99:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ba0:	eb 1f                	jmp    801bc1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ba5:	8d 50 01             	lea    0x1(%eax),%edx
  801ba8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801bab:	89 c2                	mov    %eax,%edx
  801bad:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb0:	01 c2                	add    %eax,%edx
  801bb2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb8:	01 c8                	add    %ecx,%eax
  801bba:	8a 00                	mov    (%eax),%al
  801bbc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801bbe:	ff 45 f8             	incl   -0x8(%ebp)
  801bc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bc4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bc7:	7c d9                	jl     801ba2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801bc9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  801bcf:	01 d0                	add    %edx,%eax
  801bd1:	c6 00 00             	movb   $0x0,(%eax)
}
  801bd4:	90                   	nop
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801bda:	8b 45 14             	mov    0x14(%ebp),%eax
  801bdd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801be3:	8b 45 14             	mov    0x14(%ebp),%eax
  801be6:	8b 00                	mov    (%eax),%eax
  801be8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bef:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf2:	01 d0                	add    %edx,%eax
  801bf4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bfa:	eb 0c                	jmp    801c08 <strsplit+0x31>
			*string++ = 0;
  801bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bff:	8d 50 01             	lea    0x1(%eax),%edx
  801c02:	89 55 08             	mov    %edx,0x8(%ebp)
  801c05:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c08:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0b:	8a 00                	mov    (%eax),%al
  801c0d:	84 c0                	test   %al,%al
  801c0f:	74 18                	je     801c29 <strsplit+0x52>
  801c11:	8b 45 08             	mov    0x8(%ebp),%eax
  801c14:	8a 00                	mov    (%eax),%al
  801c16:	0f be c0             	movsbl %al,%eax
  801c19:	50                   	push   %eax
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	e8 13 fb ff ff       	call   801735 <strchr>
  801c22:	83 c4 08             	add    $0x8,%esp
  801c25:	85 c0                	test   %eax,%eax
  801c27:	75 d3                	jne    801bfc <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801c29:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2c:	8a 00                	mov    (%eax),%al
  801c2e:	84 c0                	test   %al,%al
  801c30:	74 5a                	je     801c8c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801c32:	8b 45 14             	mov    0x14(%ebp),%eax
  801c35:	8b 00                	mov    (%eax),%eax
  801c37:	83 f8 0f             	cmp    $0xf,%eax
  801c3a:	75 07                	jne    801c43 <strsplit+0x6c>
		{
			return 0;
  801c3c:	b8 00 00 00 00       	mov    $0x0,%eax
  801c41:	eb 66                	jmp    801ca9 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c43:	8b 45 14             	mov    0x14(%ebp),%eax
  801c46:	8b 00                	mov    (%eax),%eax
  801c48:	8d 48 01             	lea    0x1(%eax),%ecx
  801c4b:	8b 55 14             	mov    0x14(%ebp),%edx
  801c4e:	89 0a                	mov    %ecx,(%edx)
  801c50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c57:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5a:	01 c2                	add    %eax,%edx
  801c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c61:	eb 03                	jmp    801c66 <strsplit+0x8f>
			string++;
  801c63:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c66:	8b 45 08             	mov    0x8(%ebp),%eax
  801c69:	8a 00                	mov    (%eax),%al
  801c6b:	84 c0                	test   %al,%al
  801c6d:	74 8b                	je     801bfa <strsplit+0x23>
  801c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c72:	8a 00                	mov    (%eax),%al
  801c74:	0f be c0             	movsbl %al,%eax
  801c77:	50                   	push   %eax
  801c78:	ff 75 0c             	pushl  0xc(%ebp)
  801c7b:	e8 b5 fa ff ff       	call   801735 <strchr>
  801c80:	83 c4 08             	add    $0x8,%esp
  801c83:	85 c0                	test   %eax,%eax
  801c85:	74 dc                	je     801c63 <strsplit+0x8c>
			string++;
	}
  801c87:	e9 6e ff ff ff       	jmp    801bfa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c8c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c8d:	8b 45 14             	mov    0x14(%ebp),%eax
  801c90:	8b 00                	mov    (%eax),%eax
  801c92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c99:	8b 45 10             	mov    0x10(%ebp),%eax
  801c9c:	01 d0                	add    %edx,%eax
  801c9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ca4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ca9:	c9                   	leave  
  801caa:	c3                   	ret    

00801cab <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801cb1:	83 ec 04             	sub    $0x4,%esp
  801cb4:	68 10 2e 80 00       	push   $0x802e10
  801cb9:	6a 19                	push   $0x19
  801cbb:	68 35 2e 80 00       	push   $0x802e35
  801cc0:	e8 a8 ef ff ff       	call   800c6d <_panic>

00801cc5 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
  801cc8:	83 ec 18             	sub    $0x18,%esp
  801ccb:	8b 45 10             	mov    0x10(%ebp),%eax
  801cce:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801cd1:	83 ec 04             	sub    $0x4,%esp
  801cd4:	68 44 2e 80 00       	push   $0x802e44
  801cd9:	6a 30                	push   $0x30
  801cdb:	68 35 2e 80 00       	push   $0x802e35
  801ce0:	e8 88 ef ff ff       	call   800c6d <_panic>

00801ce5 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
  801ce8:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801ceb:	83 ec 04             	sub    $0x4,%esp
  801cee:	68 63 2e 80 00       	push   $0x802e63
  801cf3:	6a 36                	push   $0x36
  801cf5:	68 35 2e 80 00       	push   $0x802e35
  801cfa:	e8 6e ef ff ff       	call   800c6d <_panic>

00801cff <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
  801d02:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801d05:	83 ec 04             	sub    $0x4,%esp
  801d08:	68 80 2e 80 00       	push   $0x802e80
  801d0d:	6a 48                	push   $0x48
  801d0f:	68 35 2e 80 00       	push   $0x802e35
  801d14:	e8 54 ef ff ff       	call   800c6d <_panic>

00801d19 <sfree>:

}


void sfree(void* virtual_address)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
  801d1c:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801d1f:	83 ec 04             	sub    $0x4,%esp
  801d22:	68 a3 2e 80 00       	push   $0x802ea3
  801d27:	6a 53                	push   $0x53
  801d29:	68 35 2e 80 00       	push   $0x802e35
  801d2e:	e8 3a ef ff ff       	call   800c6d <_panic>

00801d33 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
  801d36:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801d39:	83 ec 04             	sub    $0x4,%esp
  801d3c:	68 c0 2e 80 00       	push   $0x802ec0
  801d41:	6a 6c                	push   $0x6c
  801d43:	68 35 2e 80 00       	push   $0x802e35
  801d48:	e8 20 ef ff ff       	call   800c6d <_panic>

00801d4d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d4d:	55                   	push   %ebp
  801d4e:	89 e5                	mov    %esp,%ebp
  801d50:	57                   	push   %edi
  801d51:	56                   	push   %esi
  801d52:	53                   	push   %ebx
  801d53:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d56:	8b 45 08             	mov    0x8(%ebp),%eax
  801d59:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d5c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d5f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d62:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d65:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d68:	cd 30                	int    $0x30
  801d6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d70:	83 c4 10             	add    $0x10,%esp
  801d73:	5b                   	pop    %ebx
  801d74:	5e                   	pop    %esi
  801d75:	5f                   	pop    %edi
  801d76:	5d                   	pop    %ebp
  801d77:	c3                   	ret    

00801d78 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
  801d7b:	83 ec 04             	sub    $0x4,%esp
  801d7e:	8b 45 10             	mov    0x10(%ebp),%eax
  801d81:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d84:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d88:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	52                   	push   %edx
  801d90:	ff 75 0c             	pushl  0xc(%ebp)
  801d93:	50                   	push   %eax
  801d94:	6a 00                	push   $0x0
  801d96:	e8 b2 ff ff ff       	call   801d4d <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
}
  801d9e:	90                   	nop
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <sys_cgetc>:

int
sys_cgetc(void)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 01                	push   $0x1
  801db0:	e8 98 ff ff ff       	call   801d4d <syscall>
  801db5:	83 c4 18             	add    $0x18,%esp
}
  801db8:	c9                   	leave  
  801db9:	c3                   	ret    

00801dba <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801dba:	55                   	push   %ebp
  801dbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	50                   	push   %eax
  801dc9:	6a 05                	push   $0x5
  801dcb:	e8 7d ff ff ff       	call   801d4d <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 02                	push   $0x2
  801de4:	e8 64 ff ff ff       	call   801d4d <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	c9                   	leave  
  801ded:	c3                   	ret    

00801dee <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 03                	push   $0x3
  801dfd:	e8 4b ff ff ff       	call   801d4d <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
}
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 04                	push   $0x4
  801e16:	e8 32 ff ff ff       	call   801d4d <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
}
  801e1e:	c9                   	leave  
  801e1f:	c3                   	ret    

00801e20 <sys_env_exit>:


void sys_env_exit(void)
{
  801e20:	55                   	push   %ebp
  801e21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 06                	push   $0x6
  801e2f:	e8 19 ff ff ff       	call   801d4d <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
}
  801e37:	90                   	nop
  801e38:	c9                   	leave  
  801e39:	c3                   	ret    

00801e3a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e3a:	55                   	push   %ebp
  801e3b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e40:	8b 45 08             	mov    0x8(%ebp),%eax
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	52                   	push   %edx
  801e4a:	50                   	push   %eax
  801e4b:	6a 07                	push   $0x7
  801e4d:	e8 fb fe ff ff       	call   801d4d <syscall>
  801e52:	83 c4 18             	add    $0x18,%esp
}
  801e55:	c9                   	leave  
  801e56:	c3                   	ret    

00801e57 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
  801e5a:	56                   	push   %esi
  801e5b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e5c:	8b 75 18             	mov    0x18(%ebp),%esi
  801e5f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e62:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e68:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6b:	56                   	push   %esi
  801e6c:	53                   	push   %ebx
  801e6d:	51                   	push   %ecx
  801e6e:	52                   	push   %edx
  801e6f:	50                   	push   %eax
  801e70:	6a 08                	push   $0x8
  801e72:	e8 d6 fe ff ff       	call   801d4d <syscall>
  801e77:	83 c4 18             	add    $0x18,%esp
}
  801e7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e7d:	5b                   	pop    %ebx
  801e7e:	5e                   	pop    %esi
  801e7f:	5d                   	pop    %ebp
  801e80:	c3                   	ret    

00801e81 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e81:	55                   	push   %ebp
  801e82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e84:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e87:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	52                   	push   %edx
  801e91:	50                   	push   %eax
  801e92:	6a 09                	push   $0x9
  801e94:	e8 b4 fe ff ff       	call   801d4d <syscall>
  801e99:	83 c4 18             	add    $0x18,%esp
}
  801e9c:	c9                   	leave  
  801e9d:	c3                   	ret    

00801e9e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e9e:	55                   	push   %ebp
  801e9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	ff 75 0c             	pushl  0xc(%ebp)
  801eaa:	ff 75 08             	pushl  0x8(%ebp)
  801ead:	6a 0a                	push   $0xa
  801eaf:	e8 99 fe ff ff       	call   801d4d <syscall>
  801eb4:	83 c4 18             	add    $0x18,%esp
}
  801eb7:	c9                   	leave  
  801eb8:	c3                   	ret    

00801eb9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801eb9:	55                   	push   %ebp
  801eba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 0b                	push   $0xb
  801ec8:	e8 80 fe ff ff       	call   801d4d <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 0c                	push   $0xc
  801ee1:	e8 67 fe ff ff       	call   801d4d <syscall>
  801ee6:	83 c4 18             	add    $0x18,%esp
}
  801ee9:	c9                   	leave  
  801eea:	c3                   	ret    

00801eeb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801eeb:	55                   	push   %ebp
  801eec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 0d                	push   $0xd
  801efa:	e8 4e fe ff ff       	call   801d4d <syscall>
  801eff:	83 c4 18             	add    $0x18,%esp
}
  801f02:	c9                   	leave  
  801f03:	c3                   	ret    

00801f04 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f04:	55                   	push   %ebp
  801f05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	ff 75 0c             	pushl  0xc(%ebp)
  801f10:	ff 75 08             	pushl  0x8(%ebp)
  801f13:	6a 11                	push   $0x11
  801f15:	e8 33 fe ff ff       	call   801d4d <syscall>
  801f1a:	83 c4 18             	add    $0x18,%esp
	return;
  801f1d:	90                   	nop
}
  801f1e:	c9                   	leave  
  801f1f:	c3                   	ret    

00801f20 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f20:	55                   	push   %ebp
  801f21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	ff 75 0c             	pushl  0xc(%ebp)
  801f2c:	ff 75 08             	pushl  0x8(%ebp)
  801f2f:	6a 12                	push   $0x12
  801f31:	e8 17 fe ff ff       	call   801d4d <syscall>
  801f36:	83 c4 18             	add    $0x18,%esp
	return ;
  801f39:	90                   	nop
}
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 0e                	push   $0xe
  801f4b:	e8 fd fd ff ff       	call   801d4d <syscall>
  801f50:	83 c4 18             	add    $0x18,%esp
}
  801f53:	c9                   	leave  
  801f54:	c3                   	ret    

00801f55 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f55:	55                   	push   %ebp
  801f56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	ff 75 08             	pushl  0x8(%ebp)
  801f63:	6a 0f                	push   $0xf
  801f65:	e8 e3 fd ff ff       	call   801d4d <syscall>
  801f6a:	83 c4 18             	add    $0x18,%esp
}
  801f6d:	c9                   	leave  
  801f6e:	c3                   	ret    

00801f6f <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 10                	push   $0x10
  801f7e:	e8 ca fd ff ff       	call   801d4d <syscall>
  801f83:	83 c4 18             	add    $0x18,%esp
}
  801f86:	90                   	nop
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 14                	push   $0x14
  801f98:	e8 b0 fd ff ff       	call   801d4d <syscall>
  801f9d:	83 c4 18             	add    $0x18,%esp
}
  801fa0:	90                   	nop
  801fa1:	c9                   	leave  
  801fa2:	c3                   	ret    

00801fa3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fa3:	55                   	push   %ebp
  801fa4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 15                	push   $0x15
  801fb2:	e8 96 fd ff ff       	call   801d4d <syscall>
  801fb7:	83 c4 18             	add    $0x18,%esp
}
  801fba:	90                   	nop
  801fbb:	c9                   	leave  
  801fbc:	c3                   	ret    

00801fbd <sys_cputc>:


void
sys_cputc(const char c)
{
  801fbd:	55                   	push   %ebp
  801fbe:	89 e5                	mov    %esp,%ebp
  801fc0:	83 ec 04             	sub    $0x4,%esp
  801fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fc9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	50                   	push   %eax
  801fd6:	6a 16                	push   $0x16
  801fd8:	e8 70 fd ff ff       	call   801d4d <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
}
  801fe0:	90                   	nop
  801fe1:	c9                   	leave  
  801fe2:	c3                   	ret    

00801fe3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 17                	push   $0x17
  801ff2:	e8 56 fd ff ff       	call   801d4d <syscall>
  801ff7:	83 c4 18             	add    $0x18,%esp
}
  801ffa:	90                   	nop
  801ffb:	c9                   	leave  
  801ffc:	c3                   	ret    

00801ffd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ffd:	55                   	push   %ebp
  801ffe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802000:	8b 45 08             	mov    0x8(%ebp),%eax
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	ff 75 0c             	pushl  0xc(%ebp)
  80200c:	50                   	push   %eax
  80200d:	6a 18                	push   $0x18
  80200f:	e8 39 fd ff ff       	call   801d4d <syscall>
  802014:	83 c4 18             	add    $0x18,%esp
}
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80201c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	52                   	push   %edx
  802029:	50                   	push   %eax
  80202a:	6a 1b                	push   $0x1b
  80202c:	e8 1c fd ff ff       	call   801d4d <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802039:	8b 55 0c             	mov    0xc(%ebp),%edx
  80203c:	8b 45 08             	mov    0x8(%ebp),%eax
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	52                   	push   %edx
  802046:	50                   	push   %eax
  802047:	6a 19                	push   $0x19
  802049:	e8 ff fc ff ff       	call   801d4d <syscall>
  80204e:	83 c4 18             	add    $0x18,%esp
}
  802051:	90                   	nop
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802057:	8b 55 0c             	mov    0xc(%ebp),%edx
  80205a:	8b 45 08             	mov    0x8(%ebp),%eax
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	52                   	push   %edx
  802064:	50                   	push   %eax
  802065:	6a 1a                	push   $0x1a
  802067:	e8 e1 fc ff ff       	call   801d4d <syscall>
  80206c:	83 c4 18             	add    $0x18,%esp
}
  80206f:	90                   	nop
  802070:	c9                   	leave  
  802071:	c3                   	ret    

00802072 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802072:	55                   	push   %ebp
  802073:	89 e5                	mov    %esp,%ebp
  802075:	83 ec 04             	sub    $0x4,%esp
  802078:	8b 45 10             	mov    0x10(%ebp),%eax
  80207b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80207e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802081:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802085:	8b 45 08             	mov    0x8(%ebp),%eax
  802088:	6a 00                	push   $0x0
  80208a:	51                   	push   %ecx
  80208b:	52                   	push   %edx
  80208c:	ff 75 0c             	pushl  0xc(%ebp)
  80208f:	50                   	push   %eax
  802090:	6a 1c                	push   $0x1c
  802092:	e8 b6 fc ff ff       	call   801d4d <syscall>
  802097:	83 c4 18             	add    $0x18,%esp
}
  80209a:	c9                   	leave  
  80209b:	c3                   	ret    

0080209c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80209c:	55                   	push   %ebp
  80209d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80209f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	52                   	push   %edx
  8020ac:	50                   	push   %eax
  8020ad:	6a 1d                	push   $0x1d
  8020af:	e8 99 fc ff ff       	call   801d4d <syscall>
  8020b4:	83 c4 18             	add    $0x18,%esp
}
  8020b7:	c9                   	leave  
  8020b8:	c3                   	ret    

008020b9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020b9:	55                   	push   %ebp
  8020ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	51                   	push   %ecx
  8020ca:	52                   	push   %edx
  8020cb:	50                   	push   %eax
  8020cc:	6a 1e                	push   $0x1e
  8020ce:	e8 7a fc ff ff       	call   801d4d <syscall>
  8020d3:	83 c4 18             	add    $0x18,%esp
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020de:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	52                   	push   %edx
  8020e8:	50                   	push   %eax
  8020e9:	6a 1f                	push   $0x1f
  8020eb:	e8 5d fc ff ff       	call   801d4d <syscall>
  8020f0:	83 c4 18             	add    $0x18,%esp
}
  8020f3:	c9                   	leave  
  8020f4:	c3                   	ret    

008020f5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020f5:	55                   	push   %ebp
  8020f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 20                	push   $0x20
  802104:	e8 44 fc ff ff       	call   801d4d <syscall>
  802109:	83 c4 18             	add    $0x18,%esp
}
  80210c:	c9                   	leave  
  80210d:	c3                   	ret    

0080210e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80210e:	55                   	push   %ebp
  80210f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802111:	8b 45 08             	mov    0x8(%ebp),%eax
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	ff 75 10             	pushl  0x10(%ebp)
  80211b:	ff 75 0c             	pushl  0xc(%ebp)
  80211e:	50                   	push   %eax
  80211f:	6a 21                	push   $0x21
  802121:	e8 27 fc ff ff       	call   801d4d <syscall>
  802126:	83 c4 18             	add    $0x18,%esp
}
  802129:	c9                   	leave  
  80212a:	c3                   	ret    

0080212b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80212b:	55                   	push   %ebp
  80212c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80212e:	8b 45 08             	mov    0x8(%ebp),%eax
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	6a 00                	push   $0x0
  802139:	50                   	push   %eax
  80213a:	6a 22                	push   $0x22
  80213c:	e8 0c fc ff ff       	call   801d4d <syscall>
  802141:	83 c4 18             	add    $0x18,%esp
}
  802144:	90                   	nop
  802145:	c9                   	leave  
  802146:	c3                   	ret    

00802147 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802147:	55                   	push   %ebp
  802148:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80214a:	8b 45 08             	mov    0x8(%ebp),%eax
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	50                   	push   %eax
  802156:	6a 23                	push   $0x23
  802158:	e8 f0 fb ff ff       	call   801d4d <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
}
  802160:	90                   	nop
  802161:	c9                   	leave  
  802162:	c3                   	ret    

00802163 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802163:	55                   	push   %ebp
  802164:	89 e5                	mov    %esp,%ebp
  802166:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802169:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80216c:	8d 50 04             	lea    0x4(%eax),%edx
  80216f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	52                   	push   %edx
  802179:	50                   	push   %eax
  80217a:	6a 24                	push   $0x24
  80217c:	e8 cc fb ff ff       	call   801d4d <syscall>
  802181:	83 c4 18             	add    $0x18,%esp
	return result;
  802184:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802187:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80218a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80218d:	89 01                	mov    %eax,(%ecx)
  80218f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802192:	8b 45 08             	mov    0x8(%ebp),%eax
  802195:	c9                   	leave  
  802196:	c2 04 00             	ret    $0x4

00802199 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802199:	55                   	push   %ebp
  80219a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	ff 75 10             	pushl  0x10(%ebp)
  8021a3:	ff 75 0c             	pushl  0xc(%ebp)
  8021a6:	ff 75 08             	pushl  0x8(%ebp)
  8021a9:	6a 13                	push   $0x13
  8021ab:	e8 9d fb ff ff       	call   801d4d <syscall>
  8021b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b3:	90                   	nop
}
  8021b4:	c9                   	leave  
  8021b5:	c3                   	ret    

008021b6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021b6:	55                   	push   %ebp
  8021b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 25                	push   $0x25
  8021c5:	e8 83 fb ff ff       	call   801d4d <syscall>
  8021ca:	83 c4 18             	add    $0x18,%esp
}
  8021cd:	c9                   	leave  
  8021ce:	c3                   	ret    

008021cf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021cf:	55                   	push   %ebp
  8021d0:	89 e5                	mov    %esp,%ebp
  8021d2:	83 ec 04             	sub    $0x4,%esp
  8021d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021db:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	50                   	push   %eax
  8021e8:	6a 26                	push   $0x26
  8021ea:	e8 5e fb ff ff       	call   801d4d <syscall>
  8021ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8021f2:	90                   	nop
}
  8021f3:	c9                   	leave  
  8021f4:	c3                   	ret    

008021f5 <rsttst>:
void rsttst()
{
  8021f5:	55                   	push   %ebp
  8021f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 28                	push   $0x28
  802204:	e8 44 fb ff ff       	call   801d4d <syscall>
  802209:	83 c4 18             	add    $0x18,%esp
	return ;
  80220c:	90                   	nop
}
  80220d:	c9                   	leave  
  80220e:	c3                   	ret    

0080220f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80220f:	55                   	push   %ebp
  802210:	89 e5                	mov    %esp,%ebp
  802212:	83 ec 04             	sub    $0x4,%esp
  802215:	8b 45 14             	mov    0x14(%ebp),%eax
  802218:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80221b:	8b 55 18             	mov    0x18(%ebp),%edx
  80221e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802222:	52                   	push   %edx
  802223:	50                   	push   %eax
  802224:	ff 75 10             	pushl  0x10(%ebp)
  802227:	ff 75 0c             	pushl  0xc(%ebp)
  80222a:	ff 75 08             	pushl  0x8(%ebp)
  80222d:	6a 27                	push   $0x27
  80222f:	e8 19 fb ff ff       	call   801d4d <syscall>
  802234:	83 c4 18             	add    $0x18,%esp
	return ;
  802237:	90                   	nop
}
  802238:	c9                   	leave  
  802239:	c3                   	ret    

0080223a <chktst>:
void chktst(uint32 n)
{
  80223a:	55                   	push   %ebp
  80223b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 00                	push   $0x0
  802243:	6a 00                	push   $0x0
  802245:	ff 75 08             	pushl  0x8(%ebp)
  802248:	6a 29                	push   $0x29
  80224a:	e8 fe fa ff ff       	call   801d4d <syscall>
  80224f:	83 c4 18             	add    $0x18,%esp
	return ;
  802252:	90                   	nop
}
  802253:	c9                   	leave  
  802254:	c3                   	ret    

00802255 <inctst>:

void inctst()
{
  802255:	55                   	push   %ebp
  802256:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 2a                	push   $0x2a
  802264:	e8 e4 fa ff ff       	call   801d4d <syscall>
  802269:	83 c4 18             	add    $0x18,%esp
	return ;
  80226c:	90                   	nop
}
  80226d:	c9                   	leave  
  80226e:	c3                   	ret    

0080226f <gettst>:
uint32 gettst()
{
  80226f:	55                   	push   %ebp
  802270:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 2b                	push   $0x2b
  80227e:	e8 ca fa ff ff       	call   801d4d <syscall>
  802283:	83 c4 18             	add    $0x18,%esp
}
  802286:	c9                   	leave  
  802287:	c3                   	ret    

00802288 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802288:	55                   	push   %ebp
  802289:	89 e5                	mov    %esp,%ebp
  80228b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80228e:	6a 00                	push   $0x0
  802290:	6a 00                	push   $0x0
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 2c                	push   $0x2c
  80229a:	e8 ae fa ff ff       	call   801d4d <syscall>
  80229f:	83 c4 18             	add    $0x18,%esp
  8022a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022a5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022a9:	75 07                	jne    8022b2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022ab:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b0:	eb 05                	jmp    8022b7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022b7:	c9                   	leave  
  8022b8:	c3                   	ret    

008022b9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022b9:	55                   	push   %ebp
  8022ba:	89 e5                	mov    %esp,%ebp
  8022bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022bf:	6a 00                	push   $0x0
  8022c1:	6a 00                	push   $0x0
  8022c3:	6a 00                	push   $0x0
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 2c                	push   $0x2c
  8022cb:	e8 7d fa ff ff       	call   801d4d <syscall>
  8022d0:	83 c4 18             	add    $0x18,%esp
  8022d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022d6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022da:	75 07                	jne    8022e3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e1:	eb 05                	jmp    8022e8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022e8:	c9                   	leave  
  8022e9:	c3                   	ret    

008022ea <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022ea:	55                   	push   %ebp
  8022eb:	89 e5                	mov    %esp,%ebp
  8022ed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	6a 2c                	push   $0x2c
  8022fc:	e8 4c fa ff ff       	call   801d4d <syscall>
  802301:	83 c4 18             	add    $0x18,%esp
  802304:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802307:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80230b:	75 07                	jne    802314 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80230d:	b8 01 00 00 00       	mov    $0x1,%eax
  802312:	eb 05                	jmp    802319 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802314:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802319:	c9                   	leave  
  80231a:	c3                   	ret    

0080231b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80231b:	55                   	push   %ebp
  80231c:	89 e5                	mov    %esp,%ebp
  80231e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802321:	6a 00                	push   $0x0
  802323:	6a 00                	push   $0x0
  802325:	6a 00                	push   $0x0
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	6a 2c                	push   $0x2c
  80232d:	e8 1b fa ff ff       	call   801d4d <syscall>
  802332:	83 c4 18             	add    $0x18,%esp
  802335:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802338:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80233c:	75 07                	jne    802345 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80233e:	b8 01 00 00 00       	mov    $0x1,%eax
  802343:	eb 05                	jmp    80234a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802345:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80234a:	c9                   	leave  
  80234b:	c3                   	ret    

0080234c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80234c:	55                   	push   %ebp
  80234d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	ff 75 08             	pushl  0x8(%ebp)
  80235a:	6a 2d                	push   $0x2d
  80235c:	e8 ec f9 ff ff       	call   801d4d <syscall>
  802361:	83 c4 18             	add    $0x18,%esp
	return ;
  802364:	90                   	nop
}
  802365:	c9                   	leave  
  802366:	c3                   	ret    
  802367:	90                   	nop

00802368 <__udivdi3>:
  802368:	55                   	push   %ebp
  802369:	57                   	push   %edi
  80236a:	56                   	push   %esi
  80236b:	53                   	push   %ebx
  80236c:	83 ec 1c             	sub    $0x1c,%esp
  80236f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802373:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802377:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80237b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80237f:	89 ca                	mov    %ecx,%edx
  802381:	89 f8                	mov    %edi,%eax
  802383:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802387:	85 f6                	test   %esi,%esi
  802389:	75 2d                	jne    8023b8 <__udivdi3+0x50>
  80238b:	39 cf                	cmp    %ecx,%edi
  80238d:	77 65                	ja     8023f4 <__udivdi3+0x8c>
  80238f:	89 fd                	mov    %edi,%ebp
  802391:	85 ff                	test   %edi,%edi
  802393:	75 0b                	jne    8023a0 <__udivdi3+0x38>
  802395:	b8 01 00 00 00       	mov    $0x1,%eax
  80239a:	31 d2                	xor    %edx,%edx
  80239c:	f7 f7                	div    %edi
  80239e:	89 c5                	mov    %eax,%ebp
  8023a0:	31 d2                	xor    %edx,%edx
  8023a2:	89 c8                	mov    %ecx,%eax
  8023a4:	f7 f5                	div    %ebp
  8023a6:	89 c1                	mov    %eax,%ecx
  8023a8:	89 d8                	mov    %ebx,%eax
  8023aa:	f7 f5                	div    %ebp
  8023ac:	89 cf                	mov    %ecx,%edi
  8023ae:	89 fa                	mov    %edi,%edx
  8023b0:	83 c4 1c             	add    $0x1c,%esp
  8023b3:	5b                   	pop    %ebx
  8023b4:	5e                   	pop    %esi
  8023b5:	5f                   	pop    %edi
  8023b6:	5d                   	pop    %ebp
  8023b7:	c3                   	ret    
  8023b8:	39 ce                	cmp    %ecx,%esi
  8023ba:	77 28                	ja     8023e4 <__udivdi3+0x7c>
  8023bc:	0f bd fe             	bsr    %esi,%edi
  8023bf:	83 f7 1f             	xor    $0x1f,%edi
  8023c2:	75 40                	jne    802404 <__udivdi3+0x9c>
  8023c4:	39 ce                	cmp    %ecx,%esi
  8023c6:	72 0a                	jb     8023d2 <__udivdi3+0x6a>
  8023c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8023cc:	0f 87 9e 00 00 00    	ja     802470 <__udivdi3+0x108>
  8023d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023d7:	89 fa                	mov    %edi,%edx
  8023d9:	83 c4 1c             	add    $0x1c,%esp
  8023dc:	5b                   	pop    %ebx
  8023dd:	5e                   	pop    %esi
  8023de:	5f                   	pop    %edi
  8023df:	5d                   	pop    %ebp
  8023e0:	c3                   	ret    
  8023e1:	8d 76 00             	lea    0x0(%esi),%esi
  8023e4:	31 ff                	xor    %edi,%edi
  8023e6:	31 c0                	xor    %eax,%eax
  8023e8:	89 fa                	mov    %edi,%edx
  8023ea:	83 c4 1c             	add    $0x1c,%esp
  8023ed:	5b                   	pop    %ebx
  8023ee:	5e                   	pop    %esi
  8023ef:	5f                   	pop    %edi
  8023f0:	5d                   	pop    %ebp
  8023f1:	c3                   	ret    
  8023f2:	66 90                	xchg   %ax,%ax
  8023f4:	89 d8                	mov    %ebx,%eax
  8023f6:	f7 f7                	div    %edi
  8023f8:	31 ff                	xor    %edi,%edi
  8023fa:	89 fa                	mov    %edi,%edx
  8023fc:	83 c4 1c             	add    $0x1c,%esp
  8023ff:	5b                   	pop    %ebx
  802400:	5e                   	pop    %esi
  802401:	5f                   	pop    %edi
  802402:	5d                   	pop    %ebp
  802403:	c3                   	ret    
  802404:	bd 20 00 00 00       	mov    $0x20,%ebp
  802409:	89 eb                	mov    %ebp,%ebx
  80240b:	29 fb                	sub    %edi,%ebx
  80240d:	89 f9                	mov    %edi,%ecx
  80240f:	d3 e6                	shl    %cl,%esi
  802411:	89 c5                	mov    %eax,%ebp
  802413:	88 d9                	mov    %bl,%cl
  802415:	d3 ed                	shr    %cl,%ebp
  802417:	89 e9                	mov    %ebp,%ecx
  802419:	09 f1                	or     %esi,%ecx
  80241b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80241f:	89 f9                	mov    %edi,%ecx
  802421:	d3 e0                	shl    %cl,%eax
  802423:	89 c5                	mov    %eax,%ebp
  802425:	89 d6                	mov    %edx,%esi
  802427:	88 d9                	mov    %bl,%cl
  802429:	d3 ee                	shr    %cl,%esi
  80242b:	89 f9                	mov    %edi,%ecx
  80242d:	d3 e2                	shl    %cl,%edx
  80242f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802433:	88 d9                	mov    %bl,%cl
  802435:	d3 e8                	shr    %cl,%eax
  802437:	09 c2                	or     %eax,%edx
  802439:	89 d0                	mov    %edx,%eax
  80243b:	89 f2                	mov    %esi,%edx
  80243d:	f7 74 24 0c          	divl   0xc(%esp)
  802441:	89 d6                	mov    %edx,%esi
  802443:	89 c3                	mov    %eax,%ebx
  802445:	f7 e5                	mul    %ebp
  802447:	39 d6                	cmp    %edx,%esi
  802449:	72 19                	jb     802464 <__udivdi3+0xfc>
  80244b:	74 0b                	je     802458 <__udivdi3+0xf0>
  80244d:	89 d8                	mov    %ebx,%eax
  80244f:	31 ff                	xor    %edi,%edi
  802451:	e9 58 ff ff ff       	jmp    8023ae <__udivdi3+0x46>
  802456:	66 90                	xchg   %ax,%ax
  802458:	8b 54 24 08          	mov    0x8(%esp),%edx
  80245c:	89 f9                	mov    %edi,%ecx
  80245e:	d3 e2                	shl    %cl,%edx
  802460:	39 c2                	cmp    %eax,%edx
  802462:	73 e9                	jae    80244d <__udivdi3+0xe5>
  802464:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802467:	31 ff                	xor    %edi,%edi
  802469:	e9 40 ff ff ff       	jmp    8023ae <__udivdi3+0x46>
  80246e:	66 90                	xchg   %ax,%ax
  802470:	31 c0                	xor    %eax,%eax
  802472:	e9 37 ff ff ff       	jmp    8023ae <__udivdi3+0x46>
  802477:	90                   	nop

00802478 <__umoddi3>:
  802478:	55                   	push   %ebp
  802479:	57                   	push   %edi
  80247a:	56                   	push   %esi
  80247b:	53                   	push   %ebx
  80247c:	83 ec 1c             	sub    $0x1c,%esp
  80247f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802483:	8b 74 24 34          	mov    0x34(%esp),%esi
  802487:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80248b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80248f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802493:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802497:	89 f3                	mov    %esi,%ebx
  802499:	89 fa                	mov    %edi,%edx
  80249b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80249f:	89 34 24             	mov    %esi,(%esp)
  8024a2:	85 c0                	test   %eax,%eax
  8024a4:	75 1a                	jne    8024c0 <__umoddi3+0x48>
  8024a6:	39 f7                	cmp    %esi,%edi
  8024a8:	0f 86 a2 00 00 00    	jbe    802550 <__umoddi3+0xd8>
  8024ae:	89 c8                	mov    %ecx,%eax
  8024b0:	89 f2                	mov    %esi,%edx
  8024b2:	f7 f7                	div    %edi
  8024b4:	89 d0                	mov    %edx,%eax
  8024b6:	31 d2                	xor    %edx,%edx
  8024b8:	83 c4 1c             	add    $0x1c,%esp
  8024bb:	5b                   	pop    %ebx
  8024bc:	5e                   	pop    %esi
  8024bd:	5f                   	pop    %edi
  8024be:	5d                   	pop    %ebp
  8024bf:	c3                   	ret    
  8024c0:	39 f0                	cmp    %esi,%eax
  8024c2:	0f 87 ac 00 00 00    	ja     802574 <__umoddi3+0xfc>
  8024c8:	0f bd e8             	bsr    %eax,%ebp
  8024cb:	83 f5 1f             	xor    $0x1f,%ebp
  8024ce:	0f 84 ac 00 00 00    	je     802580 <__umoddi3+0x108>
  8024d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8024d9:	29 ef                	sub    %ebp,%edi
  8024db:	89 fe                	mov    %edi,%esi
  8024dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8024e1:	89 e9                	mov    %ebp,%ecx
  8024e3:	d3 e0                	shl    %cl,%eax
  8024e5:	89 d7                	mov    %edx,%edi
  8024e7:	89 f1                	mov    %esi,%ecx
  8024e9:	d3 ef                	shr    %cl,%edi
  8024eb:	09 c7                	or     %eax,%edi
  8024ed:	89 e9                	mov    %ebp,%ecx
  8024ef:	d3 e2                	shl    %cl,%edx
  8024f1:	89 14 24             	mov    %edx,(%esp)
  8024f4:	89 d8                	mov    %ebx,%eax
  8024f6:	d3 e0                	shl    %cl,%eax
  8024f8:	89 c2                	mov    %eax,%edx
  8024fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024fe:	d3 e0                	shl    %cl,%eax
  802500:	89 44 24 04          	mov    %eax,0x4(%esp)
  802504:	8b 44 24 08          	mov    0x8(%esp),%eax
  802508:	89 f1                	mov    %esi,%ecx
  80250a:	d3 e8                	shr    %cl,%eax
  80250c:	09 d0                	or     %edx,%eax
  80250e:	d3 eb                	shr    %cl,%ebx
  802510:	89 da                	mov    %ebx,%edx
  802512:	f7 f7                	div    %edi
  802514:	89 d3                	mov    %edx,%ebx
  802516:	f7 24 24             	mull   (%esp)
  802519:	89 c6                	mov    %eax,%esi
  80251b:	89 d1                	mov    %edx,%ecx
  80251d:	39 d3                	cmp    %edx,%ebx
  80251f:	0f 82 87 00 00 00    	jb     8025ac <__umoddi3+0x134>
  802525:	0f 84 91 00 00 00    	je     8025bc <__umoddi3+0x144>
  80252b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80252f:	29 f2                	sub    %esi,%edx
  802531:	19 cb                	sbb    %ecx,%ebx
  802533:	89 d8                	mov    %ebx,%eax
  802535:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802539:	d3 e0                	shl    %cl,%eax
  80253b:	89 e9                	mov    %ebp,%ecx
  80253d:	d3 ea                	shr    %cl,%edx
  80253f:	09 d0                	or     %edx,%eax
  802541:	89 e9                	mov    %ebp,%ecx
  802543:	d3 eb                	shr    %cl,%ebx
  802545:	89 da                	mov    %ebx,%edx
  802547:	83 c4 1c             	add    $0x1c,%esp
  80254a:	5b                   	pop    %ebx
  80254b:	5e                   	pop    %esi
  80254c:	5f                   	pop    %edi
  80254d:	5d                   	pop    %ebp
  80254e:	c3                   	ret    
  80254f:	90                   	nop
  802550:	89 fd                	mov    %edi,%ebp
  802552:	85 ff                	test   %edi,%edi
  802554:	75 0b                	jne    802561 <__umoddi3+0xe9>
  802556:	b8 01 00 00 00       	mov    $0x1,%eax
  80255b:	31 d2                	xor    %edx,%edx
  80255d:	f7 f7                	div    %edi
  80255f:	89 c5                	mov    %eax,%ebp
  802561:	89 f0                	mov    %esi,%eax
  802563:	31 d2                	xor    %edx,%edx
  802565:	f7 f5                	div    %ebp
  802567:	89 c8                	mov    %ecx,%eax
  802569:	f7 f5                	div    %ebp
  80256b:	89 d0                	mov    %edx,%eax
  80256d:	e9 44 ff ff ff       	jmp    8024b6 <__umoddi3+0x3e>
  802572:	66 90                	xchg   %ax,%ax
  802574:	89 c8                	mov    %ecx,%eax
  802576:	89 f2                	mov    %esi,%edx
  802578:	83 c4 1c             	add    $0x1c,%esp
  80257b:	5b                   	pop    %ebx
  80257c:	5e                   	pop    %esi
  80257d:	5f                   	pop    %edi
  80257e:	5d                   	pop    %ebp
  80257f:	c3                   	ret    
  802580:	3b 04 24             	cmp    (%esp),%eax
  802583:	72 06                	jb     80258b <__umoddi3+0x113>
  802585:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802589:	77 0f                	ja     80259a <__umoddi3+0x122>
  80258b:	89 f2                	mov    %esi,%edx
  80258d:	29 f9                	sub    %edi,%ecx
  80258f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802593:	89 14 24             	mov    %edx,(%esp)
  802596:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80259a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80259e:	8b 14 24             	mov    (%esp),%edx
  8025a1:	83 c4 1c             	add    $0x1c,%esp
  8025a4:	5b                   	pop    %ebx
  8025a5:	5e                   	pop    %esi
  8025a6:	5f                   	pop    %edi
  8025a7:	5d                   	pop    %ebp
  8025a8:	c3                   	ret    
  8025a9:	8d 76 00             	lea    0x0(%esi),%esi
  8025ac:	2b 04 24             	sub    (%esp),%eax
  8025af:	19 fa                	sbb    %edi,%edx
  8025b1:	89 d1                	mov    %edx,%ecx
  8025b3:	89 c6                	mov    %eax,%esi
  8025b5:	e9 71 ff ff ff       	jmp    80252b <__umoddi3+0xb3>
  8025ba:	66 90                	xchg   %ax,%ax
  8025bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8025c0:	72 ea                	jb     8025ac <__umoddi3+0x134>
  8025c2:	89 d9                	mov    %ebx,%ecx
  8025c4:	e9 62 ff ff ff       	jmp    80252b <__umoddi3+0xb3>
