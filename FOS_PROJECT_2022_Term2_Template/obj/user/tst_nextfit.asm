
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
  800070:	68 80 28 80 00       	push   $0x802880
  800075:	68 97 28 80 00       	push   $0x802897
  80007a:	6a 0e                	push   $0xe
  80007c:	68 ac 28 80 00       	push   $0x8028ac
  800081:	e8 e7 0b 00 00       	call   800c6d <_panic>




	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 03                	push   $0x3
  80008b:	e8 56 25 00 00       	call   8025e6 <sys_set_uheap_strategy>
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
  8000a0:	a1 20 40 80 00       	mov    0x804020,%eax
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
  8000c9:	a1 20 40 80 00       	mov    0x804020,%eax
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
  8000e1:	68 bf 28 80 00       	push   $0x8028bf
  8000e6:	6a 20                	push   $0x20
  8000e8:	68 ac 28 80 00       	push   $0x8028ac
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
  800110:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800136:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800150:	68 dc 28 80 00       	push   $0x8028dc
  800155:	6a 31                	push   $0x31
  800157:	68 ac 28 80 00       	push   $0x8028ac
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
  800178:	68 2c 29 80 00       	push   $0x80292c
  80017d:	e8 9f 0d 00 00       	call   800f21 <cprintf>
  800182:	83 c4 10             	add    $0x10,%esp

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
  800185:	e8 c9 1f 00 00       	call   802153 <sys_calculate_free_frames>
  80018a:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80018d:	e8 44 20 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8001a7:	e8 e4 1c 00 00       	call   801e90 <malloc>
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
  800232:	68 7c 29 80 00       	push   $0x80297c
  800237:	6a 4a                	push   $0x4a
  800239:	68 ac 28 80 00       	push   $0x8028ac
  80023e:	e8 2a 0a 00 00       	call   800c6d <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800243:	e8 8e 1f 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800266:	68 ba 29 80 00       	push   $0x8029ba
  80026b:	6a 4c                	push   $0x4c
  80026d:	68 ac 28 80 00       	push   $0x8028ac
  800272:	e8 f6 09 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != (512*Mega)/(1024*PAGE_SIZE) ) panic("Wrong allocation");
  800277:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  80027a:	e8 d4 1e 00 00       	call   802153 <sys_calculate_free_frames>
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
  80029c:	68 d7 29 80 00       	push   $0x8029d7
  8002a1:	6a 4d                	push   $0x4d
  8002a3:	68 ac 28 80 00       	push   $0x8028ac
  8002a8:	e8 c0 09 00 00       	call   800c6d <_panic>

	// Make memory holes.
	freeFrames = sys_calculate_free_frames() ;
  8002ad:	e8 a1 1e 00 00       	call   802153 <sys_calculate_free_frames>
  8002b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b5:	e8 1c 1f 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  8002ba:	89 45 cc             	mov    %eax,-0x34(%ebp)

	free(ptr_allocations[0]);		// Hole 1 = 2 M
  8002bd:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 52 1c 00 00       	call   801f1e <free>
  8002cc:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[2]);		// Hole 2 = 4 M
  8002cf:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
  8002d5:	83 ec 0c             	sub    $0xc,%esp
  8002d8:	50                   	push   %eax
  8002d9:	e8 40 1c 00 00       	call   801f1e <free>
  8002de:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[3]);
  8002e1:	8b 85 d4 f7 ff ff    	mov    -0x82c(%ebp),%eax
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	50                   	push   %eax
  8002eb:	e8 2e 1c 00 00       	call   801f1e <free>
  8002f0:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[5]);		// Hole 3 = 2 M
  8002f3:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	50                   	push   %eax
  8002fd:	e8 1c 1c 00 00       	call   801f1e <free>
  800302:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[10]);		// Hole 4 = 6 M
  800305:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
  80030b:	83 ec 0c             	sub    $0xc,%esp
  80030e:	50                   	push   %eax
  80030f:	e8 0a 1c 00 00       	call   801f1e <free>
  800314:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[12]);
  800317:	8b 85 f8 f7 ff ff    	mov    -0x808(%ebp),%eax
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	50                   	push   %eax
  800321:	e8 f8 1b 00 00       	call   801f1e <free>
  800326:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[11]);
  800329:	8b 85 f4 f7 ff ff    	mov    -0x80c(%ebp),%eax
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	50                   	push   %eax
  800333:	e8 e6 1b 00 00       	call   801f1e <free>
  800338:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[20]);		// Hole 5 = 2 M
  80033b:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	50                   	push   %eax
  800345:	e8 d4 1b 00 00       	call   801f1e <free>
  80034a:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[25]);		// Hole 6 = 2 M
  80034d:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
  800353:	83 ec 0c             	sub    $0xc,%esp
  800356:	50                   	push   %eax
  800357:	e8 c2 1b 00 00       	call   801f1e <free>
  80035c:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[255]);		// Hole 7 = 2 M
  80035f:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  800365:	83 ec 0c             	sub    $0xc,%esp
  800368:	50                   	push   %eax
  800369:	e8 b0 1b 00 00       	call   801f1e <free>
  80036e:	83 c4 10             	add    $0x10,%esp

	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 10*(2*Mega)/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800371:	e8 60 1e 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  80039d:	68 e8 29 80 00       	push   $0x8029e8
  8003a2:	6a 5e                	push   $0x5e
  8003a4:	68 ac 28 80 00       	push   $0x8028ac
  8003a9:	e8 bf 08 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8003ae:	e8 a0 1d 00 00       	call   802153 <sys_calculate_free_frames>
  8003b3:	89 c2                	mov    %eax,%edx
  8003b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b8:	39 c2                	cmp    %eax,%edx
  8003ba:	74 14                	je     8003d0 <_main+0x398>
  8003bc:	83 ec 04             	sub    $0x4,%esp
  8003bf:	68 24 2a 80 00       	push   $0x802a24
  8003c4:	6a 5f                	push   $0x5f
  8003c6:	68 ac 28 80 00       	push   $0x8028ac
  8003cb:	e8 9d 08 00 00       	call   800c6d <_panic>

	// Test next fit

	freeFrames = sys_calculate_free_frames() ;
  8003d0:	e8 7e 1d 00 00       	call   802153 <sys_calculate_free_frames>
  8003d5:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8003d8:	e8 f9 1d 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  8003dd:	89 45 cc             	mov    %eax,-0x34(%ebp)
	void* tempAddress = malloc(Mega-kilo);		// Use Hole 1 -> Hole 1 = 1 M
  8003e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003e6:	83 ec 0c             	sub    $0xc,%esp
  8003e9:	50                   	push   %eax
  8003ea:	e8 a1 1a 00 00       	call   801e90 <malloc>
  8003ef:	83 c4 10             	add    $0x10,%esp
  8003f2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80000000)
  8003f5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8003f8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8003fd:	74 14                	je     800413 <_main+0x3db>
		panic("Next Fit is not working correctly");
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 64 2a 80 00       	push   $0x802a64
  800407:	6a 67                	push   $0x67
  800409:	68 ac 28 80 00       	push   $0x8028ac
  80040e:	e8 5a 08 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800413:	e8 be 1d 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800433:	68 ba 29 80 00       	push   $0x8029ba
  800438:	6a 68                	push   $0x68
  80043a:	68 ac 28 80 00       	push   $0x8028ac
  80043f:	e8 29 08 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800444:	e8 0a 1d 00 00       	call   802153 <sys_calculate_free_frames>
  800449:	89 c2                	mov    %eax,%edx
  80044b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80044e:	39 c2                	cmp    %eax,%edx
  800450:	74 14                	je     800466 <_main+0x42e>
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 d7 29 80 00       	push   $0x8029d7
  80045a:	6a 69                	push   $0x69
  80045c:	68 ac 28 80 00       	push   $0x8028ac
  800461:	e8 07 08 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800466:	e8 e8 1c 00 00       	call   802153 <sys_calculate_free_frames>
  80046b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80046e:	e8 63 1d 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800473:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo);					// Use Hole 1 -> Hole 1 = 1 M - Kilo
  800476:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800479:	83 ec 0c             	sub    $0xc,%esp
  80047c:	50                   	push   %eax
  80047d:	e8 0e 1a 00 00       	call   801e90 <malloc>
  800482:	83 c4 10             	add    $0x10,%esp
  800485:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80100000)
  800488:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80048b:	3d 00 00 10 80       	cmp    $0x80100000,%eax
  800490:	74 14                	je     8004a6 <_main+0x46e>
		panic("Next Fit is not working correctly");
  800492:	83 ec 04             	sub    $0x4,%esp
  800495:	68 64 2a 80 00       	push   $0x802a64
  80049a:	6a 6f                	push   $0x6f
  80049c:	68 ac 28 80 00       	push   $0x8028ac
  8004a1:	e8 c7 07 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8004a6:	e8 2b 1d 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8004c9:	68 ba 29 80 00       	push   $0x8029ba
  8004ce:	6a 70                	push   $0x70
  8004d0:	68 ac 28 80 00       	push   $0x8028ac
  8004d5:	e8 93 07 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8004da:	e8 74 1c 00 00       	call   802153 <sys_calculate_free_frames>
  8004df:	89 c2                	mov    %eax,%edx
  8004e1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004e4:	39 c2                	cmp    %eax,%edx
  8004e6:	74 14                	je     8004fc <_main+0x4c4>
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	68 d7 29 80 00       	push   $0x8029d7
  8004f0:	6a 71                	push   $0x71
  8004f2:	68 ac 28 80 00       	push   $0x8028ac
  8004f7:	e8 71 07 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  8004fc:	e8 52 1c 00 00       	call   802153 <sys_calculate_free_frames>
  800501:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800504:	e8 cd 1c 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800509:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(5*Mega); 			   // Use Hole 4 -> Hole 4 = 1 M
  80050c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80050f:	89 d0                	mov    %edx,%eax
  800511:	c1 e0 02             	shl    $0x2,%eax
  800514:	01 d0                	add    %edx,%eax
  800516:	83 ec 0c             	sub    $0xc,%esp
  800519:	50                   	push   %eax
  80051a:	e8 71 19 00 00       	call   801e90 <malloc>
  80051f:	83 c4 10             	add    $0x10,%esp
  800522:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81400000)
  800525:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800528:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  80052d:	74 14                	je     800543 <_main+0x50b>
		panic("Next Fit is not working correctly");
  80052f:	83 ec 04             	sub    $0x4,%esp
  800532:	68 64 2a 80 00       	push   $0x802a64
  800537:	6a 77                	push   $0x77
  800539:	68 ac 28 80 00       	push   $0x8028ac
  80053e:	e8 2a 07 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800543:	e8 8e 1c 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  80056a:	68 ba 29 80 00       	push   $0x8029ba
  80056f:	6a 78                	push   $0x78
  800571:	68 ac 28 80 00       	push   $0x8028ac
  800576:	e8 f2 06 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80057b:	e8 d3 1b 00 00       	call   802153 <sys_calculate_free_frames>
  800580:	89 c2                	mov    %eax,%edx
  800582:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800585:	39 c2                	cmp    %eax,%edx
  800587:	74 14                	je     80059d <_main+0x565>
  800589:	83 ec 04             	sub    $0x4,%esp
  80058c:	68 d7 29 80 00       	push   $0x8029d7
  800591:	6a 79                	push   $0x79
  800593:	68 ac 28 80 00       	push   $0x8028ac
  800598:	e8 d0 06 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80059d:	e8 b1 1b 00 00       	call   802153 <sys_calculate_free_frames>
  8005a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8005a5:	e8 2c 1c 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  8005aa:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(1*Mega); 			   // Use Hole 4 -> Hole 4 = 0 M
  8005ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b0:	83 ec 0c             	sub    $0xc,%esp
  8005b3:	50                   	push   %eax
  8005b4:	e8 d7 18 00 00       	call   801e90 <malloc>
  8005b9:	83 c4 10             	add    $0x10,%esp
  8005bc:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81900000)
  8005bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8005c2:	3d 00 00 90 81       	cmp    $0x81900000,%eax
  8005c7:	74 14                	je     8005dd <_main+0x5a5>
		panic("Next Fit is not working correctly");
  8005c9:	83 ec 04             	sub    $0x4,%esp
  8005cc:	68 64 2a 80 00       	push   $0x802a64
  8005d1:	6a 7f                	push   $0x7f
  8005d3:	68 ac 28 80 00       	push   $0x8028ac
  8005d8:	e8 90 06 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  8005dd:	e8 f4 1b 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8005fd:	68 ba 29 80 00       	push   $0x8029ba
  800602:	68 80 00 00 00       	push   $0x80
  800607:	68 ac 28 80 00       	push   $0x8028ac
  80060c:	e8 5c 06 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800611:	e8 3d 1b 00 00       	call   802153 <sys_calculate_free_frames>
  800616:	89 c2                	mov    %eax,%edx
  800618:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80061b:	39 c2                	cmp    %eax,%edx
  80061d:	74 17                	je     800636 <_main+0x5fe>
  80061f:	83 ec 04             	sub    $0x4,%esp
  800622:	68 d7 29 80 00       	push   $0x8029d7
  800627:	68 81 00 00 00       	push   $0x81
  80062c:	68 ac 28 80 00       	push   $0x8028ac
  800631:	e8 37 06 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800636:	e8 18 1b 00 00       	call   802153 <sys_calculate_free_frames>
  80063b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80063e:	e8 93 1b 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800643:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[15]);					// Make a new hole => 2 M
  800646:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax
  80064c:	83 ec 0c             	sub    $0xc,%esp
  80064f:	50                   	push   %eax
  800650:	e8 c9 18 00 00       	call   801f1e <free>
  800655:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800658:	e8 79 1b 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  80067a:	68 e8 29 80 00       	push   $0x8029e8
  80067f:	68 87 00 00 00       	push   $0x87
  800684:	68 ac 28 80 00       	push   $0x8028ac
  800689:	e8 df 05 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  80068e:	e8 c0 1a 00 00       	call   802153 <sys_calculate_free_frames>
  800693:	89 c2                	mov    %eax,%edx
  800695:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800698:	39 c2                	cmp    %eax,%edx
  80069a:	74 17                	je     8006b3 <_main+0x67b>
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	68 24 2a 80 00       	push   $0x802a24
  8006a4:	68 88 00 00 00       	push   $0x88
  8006a9:	68 ac 28 80 00       	push   $0x8028ac
  8006ae:	e8 ba 05 00 00       	call   800c6d <_panic>

	//[NEXT FIT Case]
	freeFrames = sys_calculate_free_frames() ;
  8006b3:	e8 9b 1a 00 00       	call   802153 <sys_calculate_free_frames>
  8006b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bb:	e8 16 1b 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  8006c0:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo); 			   // Use new Hole = 2 M - 4 kilo
  8006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	50                   	push   %eax
  8006ca:	e8 c1 17 00 00       	call   801e90 <malloc>
  8006cf:	83 c4 10             	add    $0x10,%esp
  8006d2:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E00000)
  8006d5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8006d8:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  8006dd:	74 17                	je     8006f6 <_main+0x6be>
		panic("Next Fit is not working correctly");
  8006df:	83 ec 04             	sub    $0x4,%esp
  8006e2:	68 64 2a 80 00       	push   $0x802a64
  8006e7:	68 8f 00 00 00       	push   $0x8f
  8006ec:	68 ac 28 80 00       	push   $0x8028ac
  8006f1:	e8 77 05 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8006f6:	e8 db 1a 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800719:	68 ba 29 80 00       	push   $0x8029ba
  80071e:	68 90 00 00 00       	push   $0x90
  800723:	68 ac 28 80 00       	push   $0x8028ac
  800728:	e8 40 05 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80072d:	e8 21 1a 00 00       	call   802153 <sys_calculate_free_frames>
  800732:	89 c2                	mov    %eax,%edx
  800734:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800737:	39 c2                	cmp    %eax,%edx
  800739:	74 17                	je     800752 <_main+0x71a>
  80073b:	83 ec 04             	sub    $0x4,%esp
  80073e:	68 d7 29 80 00       	push   $0x8029d7
  800743:	68 91 00 00 00       	push   $0x91
  800748:	68 ac 28 80 00       	push   $0x8028ac
  80074d:	e8 1b 05 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800752:	e8 fc 19 00 00       	call   802153 <sys_calculate_free_frames>
  800757:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80075a:	e8 77 1a 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800778:	e8 13 17 00 00       	call   801e90 <malloc>
  80077d:	83 c4 10             	add    $0x10,%esp
  800780:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E01000)
  800783:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800786:	3d 00 10 e0 81       	cmp    $0x81e01000,%eax
  80078b:	74 17                	je     8007a4 <_main+0x76c>
		panic("Next Fit is not working correctly");
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	68 64 2a 80 00       	push   $0x802a64
  800795:	68 97 00 00 00       	push   $0x97
  80079a:	68 ac 28 80 00       	push   $0x8028ac
  80079f:	e8 c9 04 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (1*Mega+1016*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  8007a4:	e8 2d 1a 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8007d3:	68 ba 29 80 00       	push   $0x8029ba
  8007d8:	68 98 00 00 00       	push   $0x98
  8007dd:	68 ac 28 80 00       	push   $0x8028ac
  8007e2:	e8 86 04 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8007e7:	e8 67 19 00 00       	call   802153 <sys_calculate_free_frames>
  8007ec:	89 c2                	mov    %eax,%edx
  8007ee:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007f1:	39 c2                	cmp    %eax,%edx
  8007f3:	74 17                	je     80080c <_main+0x7d4>
  8007f5:	83 ec 04             	sub    $0x4,%esp
  8007f8:	68 d7 29 80 00       	push   $0x8029d7
  8007fd:	68 99 00 00 00       	push   $0x99
  800802:	68 ac 28 80 00       	push   $0x8028ac
  800807:	e8 61 04 00 00       	call   800c6d <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80080c:	e8 42 19 00 00       	call   802153 <sys_calculate_free_frames>
  800811:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800814:	e8 bd 19 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800819:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(512*kilo); 			   // Use Hole 5 -> Hole 5 = 1.5 M
  80081c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80081f:	c1 e0 09             	shl    $0x9,%eax
  800822:	83 ec 0c             	sub    $0xc,%esp
  800825:	50                   	push   %eax
  800826:	e8 65 16 00 00       	call   801e90 <malloc>
  80082b:	83 c4 10             	add    $0x10,%esp
  80082e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x82800000)
  800831:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800834:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800839:	74 17                	je     800852 <_main+0x81a>
		panic("Next Fit is not working correctly");
  80083b:	83 ec 04             	sub    $0x4,%esp
  80083e:	68 64 2a 80 00       	push   $0x802a64
  800843:	68 9f 00 00 00       	push   $0x9f
  800848:	68 ac 28 80 00       	push   $0x8028ac
  80084d:	e8 1b 04 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800852:	e8 7f 19 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800875:	68 ba 29 80 00       	push   $0x8029ba
  80087a:	68 a0 00 00 00       	push   $0xa0
  80087f:	68 ac 28 80 00       	push   $0x8028ac
  800884:	e8 e4 03 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800889:	e8 c5 18 00 00       	call   802153 <sys_calculate_free_frames>
  80088e:	89 c2                	mov    %eax,%edx
  800890:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800893:	39 c2                	cmp    %eax,%edx
  800895:	74 17                	je     8008ae <_main+0x876>
  800897:	83 ec 04             	sub    $0x4,%esp
  80089a:	68 d7 29 80 00       	push   $0x8029d7
  80089f:	68 a1 00 00 00       	push   $0xa1
  8008a4:	68 ac 28 80 00       	push   $0x8028ac
  8008a9:	e8 bf 03 00 00       	call   800c6d <_panic>

	cprintf("\nCASE1: (next fit without looping back) has succeeded...\n") ;
  8008ae:	83 ec 0c             	sub    $0xc,%esp
  8008b1:	68 88 2a 80 00       	push   $0x802a88
  8008b6:	e8 66 06 00 00       	call   800f21 <cprintf>
  8008bb:	83 c4 10             	add    $0x10,%esp

	// Check that next fit is looping back to check for free space
	freeFrames = sys_calculate_free_frames() ;
  8008be:	e8 90 18 00 00       	call   802153 <sys_calculate_free_frames>
  8008c3:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c6:	e8 0b 19 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8008e3:	e8 a8 15 00 00       	call   801e90 <malloc>
  8008e8:	83 c4 10             	add    $0x10,%esp
  8008eb:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80400000)
  8008ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8008f1:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8008f6:	74 17                	je     80090f <_main+0x8d7>
		panic("Next Fit is not working correctly");
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	68 64 2a 80 00       	push   $0x802a64
  800900:	68 aa 00 00 00       	push   $0xaa
  800905:	68 ac 28 80 00       	push   $0x8028ac
  80090a:	e8 5e 03 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (3*Mega+512*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  80090f:	e8 c2 18 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  80093d:	68 ba 29 80 00       	push   $0x8029ba
  800942:	68 ab 00 00 00       	push   $0xab
  800947:	68 ac 28 80 00       	push   $0x8028ac
  80094c:	e8 1c 03 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800951:	e8 fd 17 00 00       	call   802153 <sys_calculate_free_frames>
  800956:	89 c2                	mov    %eax,%edx
  800958:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80095b:	39 c2                	cmp    %eax,%edx
  80095d:	74 17                	je     800976 <_main+0x93e>
  80095f:	83 ec 04             	sub    $0x4,%esp
  800962:	68 d7 29 80 00       	push   $0x8029d7
  800967:	68 ac 00 00 00       	push   $0xac
  80096c:	68 ac 28 80 00       	push   $0x8028ac
  800971:	e8 f7 02 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  800976:	e8 d8 17 00 00       	call   802153 <sys_calculate_free_frames>
  80097b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80097e:	e8 53 18 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800983:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[24]);		// Increase size of Hole 6 to 4 M
  800986:	8b 85 28 f8 ff ff    	mov    -0x7d8(%ebp),%eax
  80098c:	83 ec 0c             	sub    $0xc,%esp
  80098f:	50                   	push   %eax
  800990:	e8 89 15 00 00       	call   801f1e <free>
  800995:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800998:	e8 39 18 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  8009ba:	68 e8 29 80 00       	push   $0x8029e8
  8009bf:	68 b2 00 00 00       	push   $0xb2
  8009c4:	68 ac 28 80 00       	push   $0x8028ac
  8009c9:	e8 9f 02 00 00       	call   800c6d <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8009ce:	e8 80 17 00 00       	call   802153 <sys_calculate_free_frames>
  8009d3:	89 c2                	mov    %eax,%edx
  8009d5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009d8:	39 c2                	cmp    %eax,%edx
  8009da:	74 17                	je     8009f3 <_main+0x9bb>
  8009dc:	83 ec 04             	sub    $0x4,%esp
  8009df:	68 24 2a 80 00       	push   $0x802a24
  8009e4:	68 b3 00 00 00       	push   $0xb3
  8009e9:	68 ac 28 80 00       	push   $0x8028ac
  8009ee:	e8 7a 02 00 00       	call   800c6d <_panic>


	freeFrames = sys_calculate_free_frames() ;
  8009f3:	e8 5b 17 00 00       	call   802153 <sys_calculate_free_frames>
  8009f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8009fb:	e8 d6 17 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800a00:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(4*Mega-kilo);		// Use Hole 6 -> Hole 6 = 0 M
  800a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a06:	c1 e0 02             	shl    $0x2,%eax
  800a09:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a0c:	83 ec 0c             	sub    $0xc,%esp
  800a0f:	50                   	push   %eax
  800a10:	e8 7b 14 00 00       	call   801e90 <malloc>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x83000000)
  800a1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800a1e:	3d 00 00 00 83       	cmp    $0x83000000,%eax
  800a23:	74 17                	je     800a3c <_main+0xa04>
		panic("Next Fit is not working correctly");
  800a25:	83 ec 04             	sub    $0x4,%esp
  800a28:	68 64 2a 80 00       	push   $0x802a64
  800a2d:	68 ba 00 00 00       	push   $0xba
  800a32:	68 ac 28 80 00       	push   $0x8028ac
  800a37:	e8 31 02 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800a3c:	e8 95 17 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
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
  800a5f:	68 ba 29 80 00       	push   $0x8029ba
  800a64:	68 bb 00 00 00       	push   $0xbb
  800a69:	68 ac 28 80 00       	push   $0x8028ac
  800a6e:	e8 fa 01 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800a73:	e8 db 16 00 00       	call   802153 <sys_calculate_free_frames>
  800a78:	89 c2                	mov    %eax,%edx
  800a7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a7d:	39 c2                	cmp    %eax,%edx
  800a7f:	74 17                	je     800a98 <_main+0xa60>
  800a81:	83 ec 04             	sub    $0x4,%esp
  800a84:	68 d7 29 80 00       	push   $0x8029d7
  800a89:	68 bc 00 00 00       	push   $0xbc
  800a8e:	68 ac 28 80 00       	push   $0x8028ac
  800a93:	e8 d5 01 00 00       	call   800c6d <_panic>

	cprintf("\nCASE2: (next fit WITH looping back) has succeeded...\n") ;
  800a98:	83 ec 0c             	sub    $0xc,%esp
  800a9b:	68 c4 2a 80 00       	push   $0x802ac4
  800aa0:	e8 7c 04 00 00       	call   800f21 <cprintf>
  800aa5:	83 c4 10             	add    $0x10,%esp

	// Check that next fit returns null in case all holes are not free
	freeFrames = sys_calculate_free_frames() ;
  800aa8:	e8 a6 16 00 00       	call   802153 <sys_calculate_free_frames>
  800aad:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab0:	e8 21 17 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800ab5:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(6*Mega); 			   // No Suitable Hole is available
  800ab8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800abb:	89 d0                	mov    %edx,%eax
  800abd:	01 c0                	add    %eax,%eax
  800abf:	01 d0                	add    %edx,%eax
  800ac1:	01 c0                	add    %eax,%eax
  800ac3:	83 ec 0c             	sub    $0xc,%esp
  800ac6:	50                   	push   %eax
  800ac7:	e8 c4 13 00 00       	call   801e90 <malloc>
  800acc:	83 c4 10             	add    $0x10,%esp
  800acf:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x0)
  800ad2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800ad5:	85 c0                	test   %eax,%eax
  800ad7:	74 17                	je     800af0 <_main+0xab8>
		panic("Next Fit is not working correctly");
  800ad9:	83 ec 04             	sub    $0x4,%esp
  800adc:	68 64 2a 80 00       	push   $0x802a64
  800ae1:	68 c5 00 00 00       	push   $0xc5
  800ae6:	68 ac 28 80 00       	push   $0x8028ac
  800aeb:	e8 7d 01 00 00       	call   800c6d <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800af0:	e8 e1 16 00 00       	call   8021d6 <sys_pf_calculate_allocated_pages>
  800af5:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  800af8:	74 17                	je     800b11 <_main+0xad9>
  800afa:	83 ec 04             	sub    $0x4,%esp
  800afd:	68 ba 29 80 00       	push   $0x8029ba
  800b02:	68 c6 00 00 00       	push   $0xc6
  800b07:	68 ac 28 80 00       	push   $0x8028ac
  800b0c:	e8 5c 01 00 00       	call   800c6d <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800b11:	e8 3d 16 00 00       	call   802153 <sys_calculate_free_frames>
  800b16:	89 c2                	mov    %eax,%edx
  800b18:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b1b:	39 c2                	cmp    %eax,%edx
  800b1d:	74 17                	je     800b36 <_main+0xafe>
  800b1f:	83 ec 04             	sub    $0x4,%esp
  800b22:	68 d7 29 80 00       	push   $0x8029d7
  800b27:	68 c7 00 00 00       	push   $0xc7
  800b2c:	68 ac 28 80 00       	push   $0x8028ac
  800b31:	e8 37 01 00 00       	call   800c6d <_panic>

	cprintf("\nCASE3: (next fit with insufficient space) has succeeded...\n") ;
  800b36:	83 ec 0c             	sub    $0xc,%esp
  800b39:	68 fc 2a 80 00       	push   $0x802afc
  800b3e:	e8 de 03 00 00       	call   800f21 <cprintf>
  800b43:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test Next Fit has completed successfully.\n");
  800b46:	83 ec 0c             	sub    $0xc,%esp
  800b49:	68 3c 2b 80 00       	push   $0x802b3c
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
  800b64:	e8 1f 15 00 00       	call   802088 <sys_getenvindex>
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
  800b8f:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b94:	a1 20 40 80 00       	mov    0x804020,%eax
  800b99:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b9f:	84 c0                	test   %al,%al
  800ba1:	74 0f                	je     800bb2 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800ba3:	a1 20 40 80 00       	mov    0x804020,%eax
  800ba8:	05 f4 02 00 00       	add    $0x2f4,%eax
  800bad:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800bb2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb6:	7e 0a                	jle    800bc2 <libmain+0x64>
		binaryname = argv[0];
  800bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	ff 75 0c             	pushl  0xc(%ebp)
  800bc8:	ff 75 08             	pushl  0x8(%ebp)
  800bcb:	e8 68 f4 ff ff       	call   800038 <_main>
  800bd0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800bd3:	e8 4b 16 00 00       	call   802223 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800bd8:	83 ec 0c             	sub    $0xc,%esp
  800bdb:	68 94 2b 80 00       	push   $0x802b94
  800be0:	e8 3c 03 00 00       	call   800f21 <cprintf>
  800be5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800be8:	a1 20 40 80 00       	mov    0x804020,%eax
  800bed:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800bf3:	a1 20 40 80 00       	mov    0x804020,%eax
  800bf8:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800bfe:	83 ec 04             	sub    $0x4,%esp
  800c01:	52                   	push   %edx
  800c02:	50                   	push   %eax
  800c03:	68 bc 2b 80 00       	push   $0x802bbc
  800c08:	e8 14 03 00 00       	call   800f21 <cprintf>
  800c0d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c10:	a1 20 40 80 00       	mov    0x804020,%eax
  800c15:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	50                   	push   %eax
  800c1f:	68 e1 2b 80 00       	push   $0x802be1
  800c24:	e8 f8 02 00 00       	call   800f21 <cprintf>
  800c29:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c2c:	83 ec 0c             	sub    $0xc,%esp
  800c2f:	68 94 2b 80 00       	push   $0x802b94
  800c34:	e8 e8 02 00 00       	call   800f21 <cprintf>
  800c39:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c3c:	e8 fc 15 00 00       	call   80223d <sys_enable_interrupt>

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
  800c54:	e8 fb 13 00 00       	call   802054 <sys_env_destroy>
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
  800c65:	e8 50 14 00 00       	call   8020ba <sys_env_exit>
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
  800c7c:	a1 48 40 88 00       	mov    0x884048,%eax
  800c81:	85 c0                	test   %eax,%eax
  800c83:	74 16                	je     800c9b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c85:	a1 48 40 88 00       	mov    0x884048,%eax
  800c8a:	83 ec 08             	sub    $0x8,%esp
  800c8d:	50                   	push   %eax
  800c8e:	68 f8 2b 80 00       	push   $0x802bf8
  800c93:	e8 89 02 00 00       	call   800f21 <cprintf>
  800c98:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c9b:	a1 00 40 80 00       	mov    0x804000,%eax
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	ff 75 08             	pushl  0x8(%ebp)
  800ca6:	50                   	push   %eax
  800ca7:	68 fd 2b 80 00       	push   $0x802bfd
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
  800ccb:	68 19 2c 80 00       	push   $0x802c19
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
  800ce5:	a1 20 40 80 00       	mov    0x804020,%eax
  800cea:	8b 50 74             	mov    0x74(%eax),%edx
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	39 c2                	cmp    %eax,%edx
  800cf2:	74 14                	je     800d08 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800cf4:	83 ec 04             	sub    $0x4,%esp
  800cf7:	68 1c 2c 80 00       	push   $0x802c1c
  800cfc:	6a 26                	push   $0x26
  800cfe:	68 68 2c 80 00       	push   $0x802c68
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
  800d48:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800d68:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800db1:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800dc9:	68 74 2c 80 00       	push   $0x802c74
  800dce:	6a 3a                	push   $0x3a
  800dd0:	68 68 2c 80 00       	push   $0x802c68
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
  800df9:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800e1f:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800e39:	68 c8 2c 80 00       	push   $0x802cc8
  800e3e:	6a 44                	push   $0x44
  800e40:	68 68 2c 80 00       	push   $0x802c68
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
  800e78:	a0 24 40 80 00       	mov    0x804024,%al
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
  800e93:	e8 7a 11 00 00       	call   802012 <sys_cputs>
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
  800eed:	a0 24 40 80 00       	mov    0x804024,%al
  800ef2:	0f b6 c0             	movzbl %al,%eax
  800ef5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800efb:	83 ec 04             	sub    $0x4,%esp
  800efe:	50                   	push   %eax
  800eff:	52                   	push   %edx
  800f00:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f06:	83 c0 08             	add    $0x8,%eax
  800f09:	50                   	push   %eax
  800f0a:	e8 03 11 00 00       	call   802012 <sys_cputs>
  800f0f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f12:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
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
  800f27:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
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
  800f54:	e8 ca 12 00 00       	call   802223 <sys_disable_interrupt>
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
  800f74:	e8 c4 12 00 00       	call   80223d <sys_enable_interrupt>
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
  800fbe:	e8 41 16 00 00       	call   802604 <__udivdi3>
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
  80100e:	e8 01 17 00 00       	call   802714 <__umoddi3>
  801013:	83 c4 10             	add    $0x10,%esp
  801016:	05 34 2f 80 00       	add    $0x802f34,%eax
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
  801169:	8b 04 85 58 2f 80 00 	mov    0x802f58(,%eax,4),%eax
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
  80124a:	8b 34 9d a0 2d 80 00 	mov    0x802da0(,%ebx,4),%esi
  801251:	85 f6                	test   %esi,%esi
  801253:	75 19                	jne    80126e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801255:	53                   	push   %ebx
  801256:	68 45 2f 80 00       	push   $0x802f45
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
  80126f:	68 4e 2f 80 00       	push   $0x802f4e
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
  80129c:	be 51 2f 80 00       	mov    $0x802f51,%esi
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

00801cab <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  801cb1:	a1 04 40 80 00       	mov    0x804004,%eax
  801cb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801cb9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  801cc0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801cc7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801cce:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  801cd5:	e9 f9 00 00 00       	jmp    801dd3 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cdd:	05 00 00 00 80       	add    $0x80000000,%eax
  801ce2:	c1 e8 0c             	shr    $0xc,%eax
  801ce5:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  801cec:	85 c0                	test   %eax,%eax
  801cee:	75 1c                	jne    801d0c <nextFitAlgo+0x61>
  801cf0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801cf4:	74 16                	je     801d0c <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  801cf6:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801cfd:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801d04:	ff 4d e0             	decl   -0x20(%ebp)
  801d07:	e9 90 00 00 00       	jmp    801d9c <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d0f:	05 00 00 00 80       	add    $0x80000000,%eax
  801d14:	c1 e8 0c             	shr    $0xc,%eax
  801d17:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  801d1e:	85 c0                	test   %eax,%eax
  801d20:	75 26                	jne    801d48 <nextFitAlgo+0x9d>
  801d22:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801d26:	75 20                	jne    801d48 <nextFitAlgo+0x9d>
			flag = 1;
  801d28:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d32:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  801d35:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801d3c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801d43:	ff 4d e0             	decl   -0x20(%ebp)
  801d46:	eb 54                	jmp    801d9c <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d4b:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d4e:	72 11                	jb     801d61 <nextFitAlgo+0xb6>
				startAdd = tmp;
  801d50:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d53:	a3 04 40 80 00       	mov    %eax,0x804004
				found = 1;
  801d58:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  801d5f:	eb 7c                	jmp    801ddd <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d64:	05 00 00 00 80       	add    $0x80000000,%eax
  801d69:	c1 e8 0c             	shr    $0xc,%eax
  801d6c:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  801d73:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d79:	05 00 00 00 80       	add    $0x80000000,%eax
  801d7e:	c1 e8 0c             	shr    $0xc,%eax
  801d81:	8b 04 85 40 40 80 00 	mov    0x804040(,%eax,4),%eax
  801d88:	c1 e0 0c             	shl    $0xc,%eax
  801d8b:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801d8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d95:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801d9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d9f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801da2:	72 11                	jb     801db5 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801da4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801da7:	a3 04 40 80 00       	mov    %eax,0x804004
			found = 1;
  801dac:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801db3:	eb 28                	jmp    801ddd <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801db5:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801dbc:	76 15                	jbe    801dd3 <nextFitAlgo+0x128>
			flag = newSize = 0;
  801dbe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801dc5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801dcc:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801dd3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801dd7:	0f 85 fd fe ff ff    	jne    801cda <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801ddd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801de1:	75 1a                	jne    801dfd <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801de3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801de6:	3b 45 08             	cmp    0x8(%ebp),%eax
  801de9:	73 0a                	jae    801df5 <nextFitAlgo+0x14a>
  801deb:	b8 00 00 00 00       	mov    $0x0,%eax
  801df0:	e9 99 00 00 00       	jmp    801e8e <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  801df5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801df8:	a3 04 40 80 00       	mov    %eax,0x804004
	}

	uint32 returnHolder = startAdd;
  801dfd:	a1 04 40 80 00       	mov    0x804004,%eax
  801e02:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  801e05:	a1 04 40 80 00       	mov    0x804004,%eax
  801e0a:	05 00 00 00 80       	add    $0x80000000,%eax
  801e0f:	c1 e8 0c             	shr    $0xc,%eax
  801e12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	c1 e8 0c             	shr    $0xc,%eax
  801e1b:	89 c2                	mov    %eax,%edx
  801e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e20:	89 14 85 40 40 80 00 	mov    %edx,0x804040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801e27:	a1 04 40 80 00       	mov    0x804004,%eax
  801e2c:	83 ec 08             	sub    $0x8,%esp
  801e2f:	ff 75 08             	pushl  0x8(%ebp)
  801e32:	50                   	push   %eax
  801e33:	e8 82 03 00 00       	call   8021ba <sys_allocateMem>
  801e38:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801e3b:	a1 04 40 80 00       	mov    0x804004,%eax
  801e40:	05 00 00 00 80       	add    $0x80000000,%eax
  801e45:	c1 e8 0c             	shr    $0xc,%eax
  801e48:	89 c2                	mov    %eax,%edx
  801e4a:	a1 04 40 80 00       	mov    0x804004,%eax
  801e4f:	89 04 d5 60 40 88 00 	mov    %eax,0x884060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801e56:	a1 04 40 80 00       	mov    0x804004,%eax
  801e5b:	05 00 00 00 80       	add    $0x80000000,%eax
  801e60:	c1 e8 0c             	shr    $0xc,%eax
  801e63:	89 c2                	mov    %eax,%edx
  801e65:	8b 45 08             	mov    0x8(%ebp),%eax
  801e68:	89 04 d5 64 40 88 00 	mov    %eax,0x884064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801e6f:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801e75:	8b 45 08             	mov    0x8(%ebp),%eax
  801e78:	01 d0                	add    %edx,%eax
  801e7a:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801e7f:	76 0a                	jbe    801e8b <nextFitAlgo+0x1e0>
  801e81:	c7 05 04 40 80 00 00 	movl   $0x80000000,0x804004
  801e88:	00 00 80 

	return (void*)returnHolder;
  801e8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <malloc>:

void* malloc(uint32 size) {
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
  801e93:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801e96:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801e9d:	8b 55 08             	mov    0x8(%ebp),%edx
  801ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ea3:	01 d0                	add    %edx,%eax
  801ea5:	48                   	dec    %eax
  801ea6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ea9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801eac:	ba 00 00 00 00       	mov    $0x0,%edx
  801eb1:	f7 75 f4             	divl   -0xc(%ebp)
  801eb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801eb7:	29 d0                	sub    %edx,%eax
  801eb9:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801ebc:	e8 c3 06 00 00       	call   802584 <sys_isUHeapPlacementStrategyNEXTFIT>
  801ec1:	85 c0                	test   %eax,%eax
  801ec3:	74 10                	je     801ed5 <malloc+0x45>
		return nextFitAlgo(size);
  801ec5:	83 ec 0c             	sub    $0xc,%esp
  801ec8:	ff 75 08             	pushl  0x8(%ebp)
  801ecb:	e8 db fd ff ff       	call   801cab <nextFitAlgo>
  801ed0:	83 c4 10             	add    $0x10,%esp
  801ed3:	eb 0a                	jmp    801edf <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801ed5:	e8 79 06 00 00       	call   802553 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801eda:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801edf:	c9                   	leave  
  801ee0:	c3                   	ret    

00801ee1 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ee1:	55                   	push   %ebp
  801ee2:	89 e5                	mov    %esp,%ebp
  801ee4:	83 ec 18             	sub    $0x18,%esp
  801ee7:	8b 45 10             	mov    0x10(%ebp),%eax
  801eea:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801eed:	83 ec 04             	sub    $0x4,%esp
  801ef0:	68 b0 30 80 00       	push   $0x8030b0
  801ef5:	6a 7e                	push   $0x7e
  801ef7:	68 cf 30 80 00       	push   $0x8030cf
  801efc:	e8 6c ed ff ff       	call   800c6d <_panic>

00801f01 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f01:	55                   	push   %ebp
  801f02:	89 e5                	mov    %esp,%ebp
  801f04:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801f07:	83 ec 04             	sub    $0x4,%esp
  801f0a:	68 db 30 80 00       	push   $0x8030db
  801f0f:	68 84 00 00 00       	push   $0x84
  801f14:	68 cf 30 80 00       	push   $0x8030cf
  801f19:	e8 4f ed ff ff       	call   800c6d <_panic>

00801f1e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801f1e:	55                   	push   %ebp
  801f1f:	89 e5                	mov    %esp,%ebp
  801f21:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801f24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801f2b:	eb 61                	jmp    801f8e <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801f2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f30:	8b 14 c5 60 40 88 00 	mov    0x884060(,%eax,8),%edx
  801f37:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3a:	39 c2                	cmp    %eax,%edx
  801f3c:	75 4d                	jne    801f8b <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f41:	05 00 00 00 80       	add    $0x80000000,%eax
  801f46:	c1 e8 0c             	shr    $0xc,%eax
  801f49:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801f4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f4f:	8b 04 c5 64 40 88 00 	mov    0x884064(,%eax,8),%eax
  801f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801f59:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f5c:	c7 04 85 40 40 80 00 	movl   $0x0,0x804040(,%eax,4)
  801f63:	00 00 00 00 
  801f67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f6a:	c7 04 c5 64 40 88 00 	movl   $0x0,0x884064(,%eax,8)
  801f71:	00 00 00 00 
  801f75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f78:	8b 14 c5 64 40 88 00 	mov    0x884064(,%eax,8),%edx
  801f7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f82:	89 14 c5 60 40 88 00 	mov    %edx,0x884060(,%eax,8)
			break;
  801f89:	eb 0d                	jmp    801f98 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801f8b:	ff 45 f0             	incl   -0x10(%ebp)
  801f8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f91:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801f96:	76 95                	jbe    801f2d <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801f98:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9b:	83 ec 08             	sub    $0x8,%esp
  801f9e:	ff 75 f4             	pushl  -0xc(%ebp)
  801fa1:	50                   	push   %eax
  801fa2:	e8 f7 01 00 00       	call   80219e <sys_freeMem>
  801fa7:	83 c4 10             	add    $0x10,%esp
}
  801faa:	90                   	nop
  801fab:	c9                   	leave  
  801fac:	c3                   	ret    

00801fad <sfree>:


void sfree(void* virtual_address)
{
  801fad:	55                   	push   %ebp
  801fae:	89 e5                	mov    %esp,%ebp
  801fb0:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801fb3:	83 ec 04             	sub    $0x4,%esp
  801fb6:	68 f7 30 80 00       	push   $0x8030f7
  801fbb:	68 ac 00 00 00       	push   $0xac
  801fc0:	68 cf 30 80 00       	push   $0x8030cf
  801fc5:	e8 a3 ec ff ff       	call   800c6d <_panic>

00801fca <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
  801fcd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801fd0:	83 ec 04             	sub    $0x4,%esp
  801fd3:	68 14 31 80 00       	push   $0x803114
  801fd8:	68 c4 00 00 00       	push   $0xc4
  801fdd:	68 cf 30 80 00       	push   $0x8030cf
  801fe2:	e8 86 ec ff ff       	call   800c6d <_panic>

00801fe7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801fe7:	55                   	push   %ebp
  801fe8:	89 e5                	mov    %esp,%ebp
  801fea:	57                   	push   %edi
  801feb:	56                   	push   %esi
  801fec:	53                   	push   %ebx
  801fed:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ff9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ffc:	8b 7d 18             	mov    0x18(%ebp),%edi
  801fff:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802002:	cd 30                	int    $0x30
  802004:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802007:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80200a:	83 c4 10             	add    $0x10,%esp
  80200d:	5b                   	pop    %ebx
  80200e:	5e                   	pop    %esi
  80200f:	5f                   	pop    %edi
  802010:	5d                   	pop    %ebp
  802011:	c3                   	ret    

00802012 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
  802015:	83 ec 04             	sub    $0x4,%esp
  802018:	8b 45 10             	mov    0x10(%ebp),%eax
  80201b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80201e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802022:	8b 45 08             	mov    0x8(%ebp),%eax
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	52                   	push   %edx
  80202a:	ff 75 0c             	pushl  0xc(%ebp)
  80202d:	50                   	push   %eax
  80202e:	6a 00                	push   $0x0
  802030:	e8 b2 ff ff ff       	call   801fe7 <syscall>
  802035:	83 c4 18             	add    $0x18,%esp
}
  802038:	90                   	nop
  802039:	c9                   	leave  
  80203a:	c3                   	ret    

0080203b <sys_cgetc>:

int
sys_cgetc(void)
{
  80203b:	55                   	push   %ebp
  80203c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 01                	push   $0x1
  80204a:	e8 98 ff ff ff       	call   801fe7 <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802057:	8b 45 08             	mov    0x8(%ebp),%eax
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	50                   	push   %eax
  802063:	6a 05                	push   $0x5
  802065:	e8 7d ff ff ff       	call   801fe7 <syscall>
  80206a:	83 c4 18             	add    $0x18,%esp
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 02                	push   $0x2
  80207e:	e8 64 ff ff ff       	call   801fe7 <syscall>
  802083:	83 c4 18             	add    $0x18,%esp
}
  802086:	c9                   	leave  
  802087:	c3                   	ret    

00802088 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802088:	55                   	push   %ebp
  802089:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 03                	push   $0x3
  802097:	e8 4b ff ff ff       	call   801fe7 <syscall>
  80209c:	83 c4 18             	add    $0x18,%esp
}
  80209f:	c9                   	leave  
  8020a0:	c3                   	ret    

008020a1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 04                	push   $0x4
  8020b0:	e8 32 ff ff ff       	call   801fe7 <syscall>
  8020b5:	83 c4 18             	add    $0x18,%esp
}
  8020b8:	c9                   	leave  
  8020b9:	c3                   	ret    

008020ba <sys_env_exit>:


void sys_env_exit(void)
{
  8020ba:	55                   	push   %ebp
  8020bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 06                	push   $0x6
  8020c9:	e8 19 ff ff ff       	call   801fe7 <syscall>
  8020ce:	83 c4 18             	add    $0x18,%esp
}
  8020d1:	90                   	nop
  8020d2:	c9                   	leave  
  8020d3:	c3                   	ret    

008020d4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8020d4:	55                   	push   %ebp
  8020d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8020d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020da:	8b 45 08             	mov    0x8(%ebp),%eax
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	52                   	push   %edx
  8020e4:	50                   	push   %eax
  8020e5:	6a 07                	push   $0x7
  8020e7:	e8 fb fe ff ff       	call   801fe7 <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
}
  8020ef:	c9                   	leave  
  8020f0:	c3                   	ret    

008020f1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8020f1:	55                   	push   %ebp
  8020f2:	89 e5                	mov    %esp,%ebp
  8020f4:	56                   	push   %esi
  8020f5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8020f6:	8b 75 18             	mov    0x18(%ebp),%esi
  8020f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	56                   	push   %esi
  802106:	53                   	push   %ebx
  802107:	51                   	push   %ecx
  802108:	52                   	push   %edx
  802109:	50                   	push   %eax
  80210a:	6a 08                	push   $0x8
  80210c:	e8 d6 fe ff ff       	call   801fe7 <syscall>
  802111:	83 c4 18             	add    $0x18,%esp
}
  802114:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802117:	5b                   	pop    %ebx
  802118:	5e                   	pop    %esi
  802119:	5d                   	pop    %ebp
  80211a:	c3                   	ret    

0080211b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80211e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802121:	8b 45 08             	mov    0x8(%ebp),%eax
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	52                   	push   %edx
  80212b:	50                   	push   %eax
  80212c:	6a 09                	push   $0x9
  80212e:	e8 b4 fe ff ff       	call   801fe7 <syscall>
  802133:	83 c4 18             	add    $0x18,%esp
}
  802136:	c9                   	leave  
  802137:	c3                   	ret    

00802138 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802138:	55                   	push   %ebp
  802139:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	ff 75 0c             	pushl  0xc(%ebp)
  802144:	ff 75 08             	pushl  0x8(%ebp)
  802147:	6a 0a                	push   $0xa
  802149:	e8 99 fe ff ff       	call   801fe7 <syscall>
  80214e:	83 c4 18             	add    $0x18,%esp
}
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 0b                	push   $0xb
  802162:	e8 80 fe ff ff       	call   801fe7 <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
}
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 0c                	push   $0xc
  80217b:	e8 67 fe ff ff       	call   801fe7 <syscall>
  802180:	83 c4 18             	add    $0x18,%esp
}
  802183:	c9                   	leave  
  802184:	c3                   	ret    

00802185 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802185:	55                   	push   %ebp
  802186:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	6a 0d                	push   $0xd
  802194:	e8 4e fe ff ff       	call   801fe7 <syscall>
  802199:	83 c4 18             	add    $0x18,%esp
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	ff 75 0c             	pushl  0xc(%ebp)
  8021aa:	ff 75 08             	pushl  0x8(%ebp)
  8021ad:	6a 11                	push   $0x11
  8021af:	e8 33 fe ff ff       	call   801fe7 <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
	return;
  8021b7:	90                   	nop
}
  8021b8:	c9                   	leave  
  8021b9:	c3                   	ret    

008021ba <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8021ba:	55                   	push   %ebp
  8021bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	ff 75 0c             	pushl  0xc(%ebp)
  8021c6:	ff 75 08             	pushl  0x8(%ebp)
  8021c9:	6a 12                	push   $0x12
  8021cb:	e8 17 fe ff ff       	call   801fe7 <syscall>
  8021d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021d3:	90                   	nop
}
  8021d4:	c9                   	leave  
  8021d5:	c3                   	ret    

008021d6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8021d6:	55                   	push   %ebp
  8021d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 0e                	push   $0xe
  8021e5:	e8 fd fd ff ff       	call   801fe7 <syscall>
  8021ea:	83 c4 18             	add    $0x18,%esp
}
  8021ed:	c9                   	leave  
  8021ee:	c3                   	ret    

008021ef <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8021ef:	55                   	push   %ebp
  8021f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	ff 75 08             	pushl  0x8(%ebp)
  8021fd:	6a 0f                	push   $0xf
  8021ff:	e8 e3 fd ff ff       	call   801fe7 <syscall>
  802204:	83 c4 18             	add    $0x18,%esp
}
  802207:	c9                   	leave  
  802208:	c3                   	ret    

00802209 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802209:	55                   	push   %ebp
  80220a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 10                	push   $0x10
  802218:	e8 ca fd ff ff       	call   801fe7 <syscall>
  80221d:	83 c4 18             	add    $0x18,%esp
}
  802220:	90                   	nop
  802221:	c9                   	leave  
  802222:	c3                   	ret    

00802223 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802223:	55                   	push   %ebp
  802224:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 14                	push   $0x14
  802232:	e8 b0 fd ff ff       	call   801fe7 <syscall>
  802237:	83 c4 18             	add    $0x18,%esp
}
  80223a:	90                   	nop
  80223b:	c9                   	leave  
  80223c:	c3                   	ret    

0080223d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80223d:	55                   	push   %ebp
  80223e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 15                	push   $0x15
  80224c:	e8 96 fd ff ff       	call   801fe7 <syscall>
  802251:	83 c4 18             	add    $0x18,%esp
}
  802254:	90                   	nop
  802255:	c9                   	leave  
  802256:	c3                   	ret    

00802257 <sys_cputc>:


void
sys_cputc(const char c)
{
  802257:	55                   	push   %ebp
  802258:	89 e5                	mov    %esp,%ebp
  80225a:	83 ec 04             	sub    $0x4,%esp
  80225d:	8b 45 08             	mov    0x8(%ebp),%eax
  802260:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802263:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802267:	6a 00                	push   $0x0
  802269:	6a 00                	push   $0x0
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	50                   	push   %eax
  802270:	6a 16                	push   $0x16
  802272:	e8 70 fd ff ff       	call   801fe7 <syscall>
  802277:	83 c4 18             	add    $0x18,%esp
}
  80227a:	90                   	nop
  80227b:	c9                   	leave  
  80227c:	c3                   	ret    

0080227d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80227d:	55                   	push   %ebp
  80227e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	6a 17                	push   $0x17
  80228c:	e8 56 fd ff ff       	call   801fe7 <syscall>
  802291:	83 c4 18             	add    $0x18,%esp
}
  802294:	90                   	nop
  802295:	c9                   	leave  
  802296:	c3                   	ret    

00802297 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802297:	55                   	push   %ebp
  802298:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80229a:	8b 45 08             	mov    0x8(%ebp),%eax
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 00                	push   $0x0
  8022a3:	ff 75 0c             	pushl  0xc(%ebp)
  8022a6:	50                   	push   %eax
  8022a7:	6a 18                	push   $0x18
  8022a9:	e8 39 fd ff ff       	call   801fe7 <syscall>
  8022ae:	83 c4 18             	add    $0x18,%esp
}
  8022b1:	c9                   	leave  
  8022b2:	c3                   	ret    

008022b3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8022b3:	55                   	push   %ebp
  8022b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	52                   	push   %edx
  8022c3:	50                   	push   %eax
  8022c4:	6a 1b                	push   $0x1b
  8022c6:	e8 1c fd ff ff       	call   801fe7 <syscall>
  8022cb:	83 c4 18             	add    $0x18,%esp
}
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	52                   	push   %edx
  8022e0:	50                   	push   %eax
  8022e1:	6a 19                	push   $0x19
  8022e3:	e8 ff fc ff ff       	call   801fe7 <syscall>
  8022e8:	83 c4 18             	add    $0x18,%esp
}
  8022eb:	90                   	nop
  8022ec:	c9                   	leave  
  8022ed:	c3                   	ret    

008022ee <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022ee:	55                   	push   %ebp
  8022ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	52                   	push   %edx
  8022fe:	50                   	push   %eax
  8022ff:	6a 1a                	push   $0x1a
  802301:	e8 e1 fc ff ff       	call   801fe7 <syscall>
  802306:	83 c4 18             	add    $0x18,%esp
}
  802309:	90                   	nop
  80230a:	c9                   	leave  
  80230b:	c3                   	ret    

0080230c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80230c:	55                   	push   %ebp
  80230d:	89 e5                	mov    %esp,%ebp
  80230f:	83 ec 04             	sub    $0x4,%esp
  802312:	8b 45 10             	mov    0x10(%ebp),%eax
  802315:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802318:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80231b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80231f:	8b 45 08             	mov    0x8(%ebp),%eax
  802322:	6a 00                	push   $0x0
  802324:	51                   	push   %ecx
  802325:	52                   	push   %edx
  802326:	ff 75 0c             	pushl  0xc(%ebp)
  802329:	50                   	push   %eax
  80232a:	6a 1c                	push   $0x1c
  80232c:	e8 b6 fc ff ff       	call   801fe7 <syscall>
  802331:	83 c4 18             	add    $0x18,%esp
}
  802334:	c9                   	leave  
  802335:	c3                   	ret    

00802336 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802336:	55                   	push   %ebp
  802337:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802339:	8b 55 0c             	mov    0xc(%ebp),%edx
  80233c:	8b 45 08             	mov    0x8(%ebp),%eax
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	52                   	push   %edx
  802346:	50                   	push   %eax
  802347:	6a 1d                	push   $0x1d
  802349:	e8 99 fc ff ff       	call   801fe7 <syscall>
  80234e:	83 c4 18             	add    $0x18,%esp
}
  802351:	c9                   	leave  
  802352:	c3                   	ret    

00802353 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802353:	55                   	push   %ebp
  802354:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802356:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802359:	8b 55 0c             	mov    0xc(%ebp),%edx
  80235c:	8b 45 08             	mov    0x8(%ebp),%eax
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	51                   	push   %ecx
  802364:	52                   	push   %edx
  802365:	50                   	push   %eax
  802366:	6a 1e                	push   $0x1e
  802368:	e8 7a fc ff ff       	call   801fe7 <syscall>
  80236d:	83 c4 18             	add    $0x18,%esp
}
  802370:	c9                   	leave  
  802371:	c3                   	ret    

00802372 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802372:	55                   	push   %ebp
  802373:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802375:	8b 55 0c             	mov    0xc(%ebp),%edx
  802378:	8b 45 08             	mov    0x8(%ebp),%eax
  80237b:	6a 00                	push   $0x0
  80237d:	6a 00                	push   $0x0
  80237f:	6a 00                	push   $0x0
  802381:	52                   	push   %edx
  802382:	50                   	push   %eax
  802383:	6a 1f                	push   $0x1f
  802385:	e8 5d fc ff ff       	call   801fe7 <syscall>
  80238a:	83 c4 18             	add    $0x18,%esp
}
  80238d:	c9                   	leave  
  80238e:	c3                   	ret    

0080238f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80238f:	55                   	push   %ebp
  802390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	6a 00                	push   $0x0
  80239c:	6a 20                	push   $0x20
  80239e:	e8 44 fc ff ff       	call   801fe7 <syscall>
  8023a3:	83 c4 18             	add    $0x18,%esp
}
  8023a6:	c9                   	leave  
  8023a7:	c3                   	ret    

008023a8 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8023a8:	55                   	push   %ebp
  8023a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8023ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ae:	6a 00                	push   $0x0
  8023b0:	6a 00                	push   $0x0
  8023b2:	ff 75 10             	pushl  0x10(%ebp)
  8023b5:	ff 75 0c             	pushl  0xc(%ebp)
  8023b8:	50                   	push   %eax
  8023b9:	6a 21                	push   $0x21
  8023bb:	e8 27 fc ff ff       	call   801fe7 <syscall>
  8023c0:	83 c4 18             	add    $0x18,%esp
}
  8023c3:	c9                   	leave  
  8023c4:	c3                   	ret    

008023c5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8023c5:	55                   	push   %ebp
  8023c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8023c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023cb:	6a 00                	push   $0x0
  8023cd:	6a 00                	push   $0x0
  8023cf:	6a 00                	push   $0x0
  8023d1:	6a 00                	push   $0x0
  8023d3:	50                   	push   %eax
  8023d4:	6a 22                	push   $0x22
  8023d6:	e8 0c fc ff ff       	call   801fe7 <syscall>
  8023db:	83 c4 18             	add    $0x18,%esp
}
  8023de:	90                   	nop
  8023df:	c9                   	leave  
  8023e0:	c3                   	ret    

008023e1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8023e1:	55                   	push   %ebp
  8023e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8023e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e7:	6a 00                	push   $0x0
  8023e9:	6a 00                	push   $0x0
  8023eb:	6a 00                	push   $0x0
  8023ed:	6a 00                	push   $0x0
  8023ef:	50                   	push   %eax
  8023f0:	6a 23                	push   $0x23
  8023f2:	e8 f0 fb ff ff       	call   801fe7 <syscall>
  8023f7:	83 c4 18             	add    $0x18,%esp
}
  8023fa:	90                   	nop
  8023fb:	c9                   	leave  
  8023fc:	c3                   	ret    

008023fd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8023fd:	55                   	push   %ebp
  8023fe:	89 e5                	mov    %esp,%ebp
  802400:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802403:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802406:	8d 50 04             	lea    0x4(%eax),%edx
  802409:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80240c:	6a 00                	push   $0x0
  80240e:	6a 00                	push   $0x0
  802410:	6a 00                	push   $0x0
  802412:	52                   	push   %edx
  802413:	50                   	push   %eax
  802414:	6a 24                	push   $0x24
  802416:	e8 cc fb ff ff       	call   801fe7 <syscall>
  80241b:	83 c4 18             	add    $0x18,%esp
	return result;
  80241e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802421:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802424:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802427:	89 01                	mov    %eax,(%ecx)
  802429:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80242c:	8b 45 08             	mov    0x8(%ebp),%eax
  80242f:	c9                   	leave  
  802430:	c2 04 00             	ret    $0x4

00802433 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802433:	55                   	push   %ebp
  802434:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802436:	6a 00                	push   $0x0
  802438:	6a 00                	push   $0x0
  80243a:	ff 75 10             	pushl  0x10(%ebp)
  80243d:	ff 75 0c             	pushl  0xc(%ebp)
  802440:	ff 75 08             	pushl  0x8(%ebp)
  802443:	6a 13                	push   $0x13
  802445:	e8 9d fb ff ff       	call   801fe7 <syscall>
  80244a:	83 c4 18             	add    $0x18,%esp
	return ;
  80244d:	90                   	nop
}
  80244e:	c9                   	leave  
  80244f:	c3                   	ret    

00802450 <sys_rcr2>:
uint32 sys_rcr2()
{
  802450:	55                   	push   %ebp
  802451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802453:	6a 00                	push   $0x0
  802455:	6a 00                	push   $0x0
  802457:	6a 00                	push   $0x0
  802459:	6a 00                	push   $0x0
  80245b:	6a 00                	push   $0x0
  80245d:	6a 25                	push   $0x25
  80245f:	e8 83 fb ff ff       	call   801fe7 <syscall>
  802464:	83 c4 18             	add    $0x18,%esp
}
  802467:	c9                   	leave  
  802468:	c3                   	ret    

00802469 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802469:	55                   	push   %ebp
  80246a:	89 e5                	mov    %esp,%ebp
  80246c:	83 ec 04             	sub    $0x4,%esp
  80246f:	8b 45 08             	mov    0x8(%ebp),%eax
  802472:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802475:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802479:	6a 00                	push   $0x0
  80247b:	6a 00                	push   $0x0
  80247d:	6a 00                	push   $0x0
  80247f:	6a 00                	push   $0x0
  802481:	50                   	push   %eax
  802482:	6a 26                	push   $0x26
  802484:	e8 5e fb ff ff       	call   801fe7 <syscall>
  802489:	83 c4 18             	add    $0x18,%esp
	return ;
  80248c:	90                   	nop
}
  80248d:	c9                   	leave  
  80248e:	c3                   	ret    

0080248f <rsttst>:
void rsttst()
{
  80248f:	55                   	push   %ebp
  802490:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802492:	6a 00                	push   $0x0
  802494:	6a 00                	push   $0x0
  802496:	6a 00                	push   $0x0
  802498:	6a 00                	push   $0x0
  80249a:	6a 00                	push   $0x0
  80249c:	6a 28                	push   $0x28
  80249e:	e8 44 fb ff ff       	call   801fe7 <syscall>
  8024a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8024a6:	90                   	nop
}
  8024a7:	c9                   	leave  
  8024a8:	c3                   	ret    

008024a9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8024a9:	55                   	push   %ebp
  8024aa:	89 e5                	mov    %esp,%ebp
  8024ac:	83 ec 04             	sub    $0x4,%esp
  8024af:	8b 45 14             	mov    0x14(%ebp),%eax
  8024b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8024b5:	8b 55 18             	mov    0x18(%ebp),%edx
  8024b8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8024bc:	52                   	push   %edx
  8024bd:	50                   	push   %eax
  8024be:	ff 75 10             	pushl  0x10(%ebp)
  8024c1:	ff 75 0c             	pushl  0xc(%ebp)
  8024c4:	ff 75 08             	pushl  0x8(%ebp)
  8024c7:	6a 27                	push   $0x27
  8024c9:	e8 19 fb ff ff       	call   801fe7 <syscall>
  8024ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8024d1:	90                   	nop
}
  8024d2:	c9                   	leave  
  8024d3:	c3                   	ret    

008024d4 <chktst>:
void chktst(uint32 n)
{
  8024d4:	55                   	push   %ebp
  8024d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8024d7:	6a 00                	push   $0x0
  8024d9:	6a 00                	push   $0x0
  8024db:	6a 00                	push   $0x0
  8024dd:	6a 00                	push   $0x0
  8024df:	ff 75 08             	pushl  0x8(%ebp)
  8024e2:	6a 29                	push   $0x29
  8024e4:	e8 fe fa ff ff       	call   801fe7 <syscall>
  8024e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8024ec:	90                   	nop
}
  8024ed:	c9                   	leave  
  8024ee:	c3                   	ret    

008024ef <inctst>:

void inctst()
{
  8024ef:	55                   	push   %ebp
  8024f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8024f2:	6a 00                	push   $0x0
  8024f4:	6a 00                	push   $0x0
  8024f6:	6a 00                	push   $0x0
  8024f8:	6a 00                	push   $0x0
  8024fa:	6a 00                	push   $0x0
  8024fc:	6a 2a                	push   $0x2a
  8024fe:	e8 e4 fa ff ff       	call   801fe7 <syscall>
  802503:	83 c4 18             	add    $0x18,%esp
	return ;
  802506:	90                   	nop
}
  802507:	c9                   	leave  
  802508:	c3                   	ret    

00802509 <gettst>:
uint32 gettst()
{
  802509:	55                   	push   %ebp
  80250a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80250c:	6a 00                	push   $0x0
  80250e:	6a 00                	push   $0x0
  802510:	6a 00                	push   $0x0
  802512:	6a 00                	push   $0x0
  802514:	6a 00                	push   $0x0
  802516:	6a 2b                	push   $0x2b
  802518:	e8 ca fa ff ff       	call   801fe7 <syscall>
  80251d:	83 c4 18             	add    $0x18,%esp
}
  802520:	c9                   	leave  
  802521:	c3                   	ret    

00802522 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802522:	55                   	push   %ebp
  802523:	89 e5                	mov    %esp,%ebp
  802525:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802528:	6a 00                	push   $0x0
  80252a:	6a 00                	push   $0x0
  80252c:	6a 00                	push   $0x0
  80252e:	6a 00                	push   $0x0
  802530:	6a 00                	push   $0x0
  802532:	6a 2c                	push   $0x2c
  802534:	e8 ae fa ff ff       	call   801fe7 <syscall>
  802539:	83 c4 18             	add    $0x18,%esp
  80253c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80253f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802543:	75 07                	jne    80254c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802545:	b8 01 00 00 00       	mov    $0x1,%eax
  80254a:	eb 05                	jmp    802551 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80254c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802551:	c9                   	leave  
  802552:	c3                   	ret    

00802553 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802553:	55                   	push   %ebp
  802554:	89 e5                	mov    %esp,%ebp
  802556:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802559:	6a 00                	push   $0x0
  80255b:	6a 00                	push   $0x0
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 2c                	push   $0x2c
  802565:	e8 7d fa ff ff       	call   801fe7 <syscall>
  80256a:	83 c4 18             	add    $0x18,%esp
  80256d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802570:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802574:	75 07                	jne    80257d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802576:	b8 01 00 00 00       	mov    $0x1,%eax
  80257b:	eb 05                	jmp    802582 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80257d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802582:	c9                   	leave  
  802583:	c3                   	ret    

00802584 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802584:	55                   	push   %ebp
  802585:	89 e5                	mov    %esp,%ebp
  802587:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80258a:	6a 00                	push   $0x0
  80258c:	6a 00                	push   $0x0
  80258e:	6a 00                	push   $0x0
  802590:	6a 00                	push   $0x0
  802592:	6a 00                	push   $0x0
  802594:	6a 2c                	push   $0x2c
  802596:	e8 4c fa ff ff       	call   801fe7 <syscall>
  80259b:	83 c4 18             	add    $0x18,%esp
  80259e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8025a1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8025a5:	75 07                	jne    8025ae <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8025a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8025ac:	eb 05                	jmp    8025b3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8025ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025b3:	c9                   	leave  
  8025b4:	c3                   	ret    

008025b5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8025b5:	55                   	push   %ebp
  8025b6:	89 e5                	mov    %esp,%ebp
  8025b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025bb:	6a 00                	push   $0x0
  8025bd:	6a 00                	push   $0x0
  8025bf:	6a 00                	push   $0x0
  8025c1:	6a 00                	push   $0x0
  8025c3:	6a 00                	push   $0x0
  8025c5:	6a 2c                	push   $0x2c
  8025c7:	e8 1b fa ff ff       	call   801fe7 <syscall>
  8025cc:	83 c4 18             	add    $0x18,%esp
  8025cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8025d2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8025d6:	75 07                	jne    8025df <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8025d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8025dd:	eb 05                	jmp    8025e4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8025df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025e4:	c9                   	leave  
  8025e5:	c3                   	ret    

008025e6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8025e6:	55                   	push   %ebp
  8025e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8025e9:	6a 00                	push   $0x0
  8025eb:	6a 00                	push   $0x0
  8025ed:	6a 00                	push   $0x0
  8025ef:	6a 00                	push   $0x0
  8025f1:	ff 75 08             	pushl  0x8(%ebp)
  8025f4:	6a 2d                	push   $0x2d
  8025f6:	e8 ec f9 ff ff       	call   801fe7 <syscall>
  8025fb:	83 c4 18             	add    $0x18,%esp
	return ;
  8025fe:	90                   	nop
}
  8025ff:	c9                   	leave  
  802600:	c3                   	ret    
  802601:	66 90                	xchg   %ax,%ax
  802603:	90                   	nop

00802604 <__udivdi3>:
  802604:	55                   	push   %ebp
  802605:	57                   	push   %edi
  802606:	56                   	push   %esi
  802607:	53                   	push   %ebx
  802608:	83 ec 1c             	sub    $0x1c,%esp
  80260b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80260f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802613:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802617:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80261b:	89 ca                	mov    %ecx,%edx
  80261d:	89 f8                	mov    %edi,%eax
  80261f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802623:	85 f6                	test   %esi,%esi
  802625:	75 2d                	jne    802654 <__udivdi3+0x50>
  802627:	39 cf                	cmp    %ecx,%edi
  802629:	77 65                	ja     802690 <__udivdi3+0x8c>
  80262b:	89 fd                	mov    %edi,%ebp
  80262d:	85 ff                	test   %edi,%edi
  80262f:	75 0b                	jne    80263c <__udivdi3+0x38>
  802631:	b8 01 00 00 00       	mov    $0x1,%eax
  802636:	31 d2                	xor    %edx,%edx
  802638:	f7 f7                	div    %edi
  80263a:	89 c5                	mov    %eax,%ebp
  80263c:	31 d2                	xor    %edx,%edx
  80263e:	89 c8                	mov    %ecx,%eax
  802640:	f7 f5                	div    %ebp
  802642:	89 c1                	mov    %eax,%ecx
  802644:	89 d8                	mov    %ebx,%eax
  802646:	f7 f5                	div    %ebp
  802648:	89 cf                	mov    %ecx,%edi
  80264a:	89 fa                	mov    %edi,%edx
  80264c:	83 c4 1c             	add    $0x1c,%esp
  80264f:	5b                   	pop    %ebx
  802650:	5e                   	pop    %esi
  802651:	5f                   	pop    %edi
  802652:	5d                   	pop    %ebp
  802653:	c3                   	ret    
  802654:	39 ce                	cmp    %ecx,%esi
  802656:	77 28                	ja     802680 <__udivdi3+0x7c>
  802658:	0f bd fe             	bsr    %esi,%edi
  80265b:	83 f7 1f             	xor    $0x1f,%edi
  80265e:	75 40                	jne    8026a0 <__udivdi3+0x9c>
  802660:	39 ce                	cmp    %ecx,%esi
  802662:	72 0a                	jb     80266e <__udivdi3+0x6a>
  802664:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802668:	0f 87 9e 00 00 00    	ja     80270c <__udivdi3+0x108>
  80266e:	b8 01 00 00 00       	mov    $0x1,%eax
  802673:	89 fa                	mov    %edi,%edx
  802675:	83 c4 1c             	add    $0x1c,%esp
  802678:	5b                   	pop    %ebx
  802679:	5e                   	pop    %esi
  80267a:	5f                   	pop    %edi
  80267b:	5d                   	pop    %ebp
  80267c:	c3                   	ret    
  80267d:	8d 76 00             	lea    0x0(%esi),%esi
  802680:	31 ff                	xor    %edi,%edi
  802682:	31 c0                	xor    %eax,%eax
  802684:	89 fa                	mov    %edi,%edx
  802686:	83 c4 1c             	add    $0x1c,%esp
  802689:	5b                   	pop    %ebx
  80268a:	5e                   	pop    %esi
  80268b:	5f                   	pop    %edi
  80268c:	5d                   	pop    %ebp
  80268d:	c3                   	ret    
  80268e:	66 90                	xchg   %ax,%ax
  802690:	89 d8                	mov    %ebx,%eax
  802692:	f7 f7                	div    %edi
  802694:	31 ff                	xor    %edi,%edi
  802696:	89 fa                	mov    %edi,%edx
  802698:	83 c4 1c             	add    $0x1c,%esp
  80269b:	5b                   	pop    %ebx
  80269c:	5e                   	pop    %esi
  80269d:	5f                   	pop    %edi
  80269e:	5d                   	pop    %ebp
  80269f:	c3                   	ret    
  8026a0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8026a5:	89 eb                	mov    %ebp,%ebx
  8026a7:	29 fb                	sub    %edi,%ebx
  8026a9:	89 f9                	mov    %edi,%ecx
  8026ab:	d3 e6                	shl    %cl,%esi
  8026ad:	89 c5                	mov    %eax,%ebp
  8026af:	88 d9                	mov    %bl,%cl
  8026b1:	d3 ed                	shr    %cl,%ebp
  8026b3:	89 e9                	mov    %ebp,%ecx
  8026b5:	09 f1                	or     %esi,%ecx
  8026b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8026bb:	89 f9                	mov    %edi,%ecx
  8026bd:	d3 e0                	shl    %cl,%eax
  8026bf:	89 c5                	mov    %eax,%ebp
  8026c1:	89 d6                	mov    %edx,%esi
  8026c3:	88 d9                	mov    %bl,%cl
  8026c5:	d3 ee                	shr    %cl,%esi
  8026c7:	89 f9                	mov    %edi,%ecx
  8026c9:	d3 e2                	shl    %cl,%edx
  8026cb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026cf:	88 d9                	mov    %bl,%cl
  8026d1:	d3 e8                	shr    %cl,%eax
  8026d3:	09 c2                	or     %eax,%edx
  8026d5:	89 d0                	mov    %edx,%eax
  8026d7:	89 f2                	mov    %esi,%edx
  8026d9:	f7 74 24 0c          	divl   0xc(%esp)
  8026dd:	89 d6                	mov    %edx,%esi
  8026df:	89 c3                	mov    %eax,%ebx
  8026e1:	f7 e5                	mul    %ebp
  8026e3:	39 d6                	cmp    %edx,%esi
  8026e5:	72 19                	jb     802700 <__udivdi3+0xfc>
  8026e7:	74 0b                	je     8026f4 <__udivdi3+0xf0>
  8026e9:	89 d8                	mov    %ebx,%eax
  8026eb:	31 ff                	xor    %edi,%edi
  8026ed:	e9 58 ff ff ff       	jmp    80264a <__udivdi3+0x46>
  8026f2:	66 90                	xchg   %ax,%ax
  8026f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026f8:	89 f9                	mov    %edi,%ecx
  8026fa:	d3 e2                	shl    %cl,%edx
  8026fc:	39 c2                	cmp    %eax,%edx
  8026fe:	73 e9                	jae    8026e9 <__udivdi3+0xe5>
  802700:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802703:	31 ff                	xor    %edi,%edi
  802705:	e9 40 ff ff ff       	jmp    80264a <__udivdi3+0x46>
  80270a:	66 90                	xchg   %ax,%ax
  80270c:	31 c0                	xor    %eax,%eax
  80270e:	e9 37 ff ff ff       	jmp    80264a <__udivdi3+0x46>
  802713:	90                   	nop

00802714 <__umoddi3>:
  802714:	55                   	push   %ebp
  802715:	57                   	push   %edi
  802716:	56                   	push   %esi
  802717:	53                   	push   %ebx
  802718:	83 ec 1c             	sub    $0x1c,%esp
  80271b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80271f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802723:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802727:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80272b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80272f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802733:	89 f3                	mov    %esi,%ebx
  802735:	89 fa                	mov    %edi,%edx
  802737:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80273b:	89 34 24             	mov    %esi,(%esp)
  80273e:	85 c0                	test   %eax,%eax
  802740:	75 1a                	jne    80275c <__umoddi3+0x48>
  802742:	39 f7                	cmp    %esi,%edi
  802744:	0f 86 a2 00 00 00    	jbe    8027ec <__umoddi3+0xd8>
  80274a:	89 c8                	mov    %ecx,%eax
  80274c:	89 f2                	mov    %esi,%edx
  80274e:	f7 f7                	div    %edi
  802750:	89 d0                	mov    %edx,%eax
  802752:	31 d2                	xor    %edx,%edx
  802754:	83 c4 1c             	add    $0x1c,%esp
  802757:	5b                   	pop    %ebx
  802758:	5e                   	pop    %esi
  802759:	5f                   	pop    %edi
  80275a:	5d                   	pop    %ebp
  80275b:	c3                   	ret    
  80275c:	39 f0                	cmp    %esi,%eax
  80275e:	0f 87 ac 00 00 00    	ja     802810 <__umoddi3+0xfc>
  802764:	0f bd e8             	bsr    %eax,%ebp
  802767:	83 f5 1f             	xor    $0x1f,%ebp
  80276a:	0f 84 ac 00 00 00    	je     80281c <__umoddi3+0x108>
  802770:	bf 20 00 00 00       	mov    $0x20,%edi
  802775:	29 ef                	sub    %ebp,%edi
  802777:	89 fe                	mov    %edi,%esi
  802779:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80277d:	89 e9                	mov    %ebp,%ecx
  80277f:	d3 e0                	shl    %cl,%eax
  802781:	89 d7                	mov    %edx,%edi
  802783:	89 f1                	mov    %esi,%ecx
  802785:	d3 ef                	shr    %cl,%edi
  802787:	09 c7                	or     %eax,%edi
  802789:	89 e9                	mov    %ebp,%ecx
  80278b:	d3 e2                	shl    %cl,%edx
  80278d:	89 14 24             	mov    %edx,(%esp)
  802790:	89 d8                	mov    %ebx,%eax
  802792:	d3 e0                	shl    %cl,%eax
  802794:	89 c2                	mov    %eax,%edx
  802796:	8b 44 24 08          	mov    0x8(%esp),%eax
  80279a:	d3 e0                	shl    %cl,%eax
  80279c:	89 44 24 04          	mov    %eax,0x4(%esp)
  8027a0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027a4:	89 f1                	mov    %esi,%ecx
  8027a6:	d3 e8                	shr    %cl,%eax
  8027a8:	09 d0                	or     %edx,%eax
  8027aa:	d3 eb                	shr    %cl,%ebx
  8027ac:	89 da                	mov    %ebx,%edx
  8027ae:	f7 f7                	div    %edi
  8027b0:	89 d3                	mov    %edx,%ebx
  8027b2:	f7 24 24             	mull   (%esp)
  8027b5:	89 c6                	mov    %eax,%esi
  8027b7:	89 d1                	mov    %edx,%ecx
  8027b9:	39 d3                	cmp    %edx,%ebx
  8027bb:	0f 82 87 00 00 00    	jb     802848 <__umoddi3+0x134>
  8027c1:	0f 84 91 00 00 00    	je     802858 <__umoddi3+0x144>
  8027c7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8027cb:	29 f2                	sub    %esi,%edx
  8027cd:	19 cb                	sbb    %ecx,%ebx
  8027cf:	89 d8                	mov    %ebx,%eax
  8027d1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8027d5:	d3 e0                	shl    %cl,%eax
  8027d7:	89 e9                	mov    %ebp,%ecx
  8027d9:	d3 ea                	shr    %cl,%edx
  8027db:	09 d0                	or     %edx,%eax
  8027dd:	89 e9                	mov    %ebp,%ecx
  8027df:	d3 eb                	shr    %cl,%ebx
  8027e1:	89 da                	mov    %ebx,%edx
  8027e3:	83 c4 1c             	add    $0x1c,%esp
  8027e6:	5b                   	pop    %ebx
  8027e7:	5e                   	pop    %esi
  8027e8:	5f                   	pop    %edi
  8027e9:	5d                   	pop    %ebp
  8027ea:	c3                   	ret    
  8027eb:	90                   	nop
  8027ec:	89 fd                	mov    %edi,%ebp
  8027ee:	85 ff                	test   %edi,%edi
  8027f0:	75 0b                	jne    8027fd <__umoddi3+0xe9>
  8027f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8027f7:	31 d2                	xor    %edx,%edx
  8027f9:	f7 f7                	div    %edi
  8027fb:	89 c5                	mov    %eax,%ebp
  8027fd:	89 f0                	mov    %esi,%eax
  8027ff:	31 d2                	xor    %edx,%edx
  802801:	f7 f5                	div    %ebp
  802803:	89 c8                	mov    %ecx,%eax
  802805:	f7 f5                	div    %ebp
  802807:	89 d0                	mov    %edx,%eax
  802809:	e9 44 ff ff ff       	jmp    802752 <__umoddi3+0x3e>
  80280e:	66 90                	xchg   %ax,%ax
  802810:	89 c8                	mov    %ecx,%eax
  802812:	89 f2                	mov    %esi,%edx
  802814:	83 c4 1c             	add    $0x1c,%esp
  802817:	5b                   	pop    %ebx
  802818:	5e                   	pop    %esi
  802819:	5f                   	pop    %edi
  80281a:	5d                   	pop    %ebp
  80281b:	c3                   	ret    
  80281c:	3b 04 24             	cmp    (%esp),%eax
  80281f:	72 06                	jb     802827 <__umoddi3+0x113>
  802821:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802825:	77 0f                	ja     802836 <__umoddi3+0x122>
  802827:	89 f2                	mov    %esi,%edx
  802829:	29 f9                	sub    %edi,%ecx
  80282b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80282f:	89 14 24             	mov    %edx,(%esp)
  802832:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802836:	8b 44 24 04          	mov    0x4(%esp),%eax
  80283a:	8b 14 24             	mov    (%esp),%edx
  80283d:	83 c4 1c             	add    $0x1c,%esp
  802840:	5b                   	pop    %ebx
  802841:	5e                   	pop    %esi
  802842:	5f                   	pop    %edi
  802843:	5d                   	pop    %ebp
  802844:	c3                   	ret    
  802845:	8d 76 00             	lea    0x0(%esi),%esi
  802848:	2b 04 24             	sub    (%esp),%eax
  80284b:	19 fa                	sbb    %edi,%edx
  80284d:	89 d1                	mov    %edx,%ecx
  80284f:	89 c6                	mov    %eax,%esi
  802851:	e9 71 ff ff ff       	jmp    8027c7 <__umoddi3+0xb3>
  802856:	66 90                	xchg   %ax,%ax
  802858:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80285c:	72 ea                	jb     802848 <__umoddi3+0x134>
  80285e:	89 d9                	mov    %ebx,%ecx
  802860:	e9 62 ff ff ff       	jmp    8027c7 <__umoddi3+0xb3>
