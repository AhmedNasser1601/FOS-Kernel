
obj/user/tst_quicksort_freeHeap:     file format elf32-i386


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
  800031:	e8 20 08 00 00       	call   800856 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 01 00 00    	sub    $0x134,%esp


	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{

		Iteration++ ;
  800049:	ff 45 f0             	incl   -0x10(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80004c:	e8 d0 20 00 00       	call   802121 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  80005a:	50                   	push   %eax
  80005b:	68 80 27 80 00       	push   $0x802780
  800060:	e8 36 12 00 00       	call   80129b <readline>
  800065:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 0a                	push   $0xa
  80006d:	6a 00                	push   $0x0
  80006f:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  800075:	50                   	push   %eax
  800076:	e8 86 17 00 00       	call   801801 <strtol>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	c1 e0 02             	shl    $0x2,%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	50                   	push   %eax
  80008b:	e8 fe 1c 00 00       	call   801d8e <malloc>
  800090:	83 c4 10             	add    $0x10,%esp
  800093:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800096:	a1 24 30 80 00       	mov    0x803024,%eax
  80009b:	83 ec 0c             	sub    $0xc,%esp
  80009e:	50                   	push   %eax
  80009f:	e8 7f 03 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS ;
  8000aa:	e8 a2 1f 00 00       	call   802051 <sys_calculate_free_frames>
  8000af:	89 c3                	mov    %eax,%ebx
  8000b1:	e8 b4 1f 00 00       	call   80206a <sys_calculate_modified_frames>
  8000b6:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bc:	29 c2                	sub    %eax,%edx
  8000be:	89 d0                	mov    %edx,%eax
  8000c0:	89 45 e0             	mov    %eax,-0x20(%ebp)

		Elements[NumOfElements] = 10 ;
  8000c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d0:	01 d0                	add    %edx,%eax
  8000d2:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000d8:	83 ec 0c             	sub    $0xc,%esp
  8000db:	68 a0 27 80 00       	push   $0x8027a0
  8000e0:	e8 34 0b 00 00       	call   800c19 <cprintf>
  8000e5:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	68 c3 27 80 00       	push   $0x8027c3
  8000f0:	e8 24 0b 00 00       	call   800c19 <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	68 d1 27 80 00       	push   $0x8027d1
  800100:	e8 14 0b 00 00       	call   800c19 <cprintf>
  800105:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n") ;
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 e0 27 80 00       	push   $0x8027e0
  800110:	e8 04 0b 00 00       	call   800c19 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	68 f0 27 80 00       	push   $0x8027f0
  800120:	e8 f4 0a 00 00       	call   800c19 <cprintf>
  800125:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800128:	e8 d1 06 00 00       	call   8007fe <getchar>
  80012d:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800130:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	50                   	push   %eax
  800138:	e8 79 06 00 00       	call   8007b6 <cputchar>
  80013d:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800140:	83 ec 0c             	sub    $0xc,%esp
  800143:	6a 0a                	push   $0xa
  800145:	e8 6c 06 00 00       	call   8007b6 <cputchar>
  80014a:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80014d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800151:	74 0c                	je     80015f <_main+0x127>
  800153:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800157:	74 06                	je     80015f <_main+0x127>
  800159:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80015d:	75 b9                	jne    800118 <_main+0xe0>
	sys_enable_interrupt();
  80015f:	e8 d7 1f 00 00       	call   80213b <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800164:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800168:	83 f8 62             	cmp    $0x62,%eax
  80016b:	74 1d                	je     80018a <_main+0x152>
  80016d:	83 f8 63             	cmp    $0x63,%eax
  800170:	74 2b                	je     80019d <_main+0x165>
  800172:	83 f8 61             	cmp    $0x61,%eax
  800175:	75 39                	jne    8001b0 <_main+0x178>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	ff 75 ec             	pushl  -0x14(%ebp)
  80017d:	ff 75 e8             	pushl  -0x18(%ebp)
  800180:	e8 f9 04 00 00       	call   80067e <InitializeAscending>
  800185:	83 c4 10             	add    $0x10,%esp
			break ;
  800188:	eb 37                	jmp    8001c1 <_main+0x189>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018a:	83 ec 08             	sub    $0x8,%esp
  80018d:	ff 75 ec             	pushl  -0x14(%ebp)
  800190:	ff 75 e8             	pushl  -0x18(%ebp)
  800193:	e8 17 05 00 00       	call   8006af <InitializeDescending>
  800198:	83 c4 10             	add    $0x10,%esp
			break ;
  80019b:	eb 24                	jmp    8001c1 <_main+0x189>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a6:	e8 39 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001ab:	83 c4 10             	add    $0x10,%esp
			break ;
  8001ae:	eb 11                	jmp    8001c1 <_main+0x189>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b0:	83 ec 08             	sub    $0x8,%esp
  8001b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b9:	e8 26 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001be:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c1:	83 ec 08             	sub    $0x8,%esp
  8001c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ca:	e8 f4 02 00 00       	call   8004c3 <QuickSort>
  8001cf:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001db:	e8 f4 03 00 00       	call   8005d4 <CheckSorted>
  8001e0:	83 c4 10             	add    $0x10,%esp
  8001e3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ea:	75 14                	jne    800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 fc 27 80 00       	push   $0x8027fc
  8001f4:	6a 57                	push   $0x57
  8001f6:	68 1e 28 80 00       	push   $0x80281e
  8001fb:	e8 65 07 00 00       	call   800965 <_panic>
		else
		{
			cprintf("===============================================\n") ;
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	68 3c 28 80 00       	push   $0x80283c
  800208:	e8 0c 0a 00 00       	call   800c19 <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 70 28 80 00       	push   $0x802870
  800218:	e8 fc 09 00 00       	call   800c19 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 a4 28 80 00       	push   $0x8028a4
  800228:	e8 ec 09 00 00       	call   800c19 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 d6 28 80 00       	push   $0x8028d6
  800238:	e8 dc 09 00 00       	call   800c19 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	ff 75 e8             	pushl  -0x18(%ebp)
  800246:	e8 d1 1b 00 00       	call   801e1c <free>
  80024b:	83 c4 10             	add    $0x10,%esp


		///Testing the freeHeap according to the specified scenario
		if (Iteration == 1)
  80024e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800252:	75 72                	jne    8002c6 <_main+0x28e>
		{
			if (!(NumOfElements == 1000 && Chose == 'a'))
  800254:	81 7d ec e8 03 00 00 	cmpl   $0x3e8,-0x14(%ebp)
  80025b:	75 06                	jne    800263 <_main+0x22b>
  80025d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 ec 28 80 00       	push   $0x8028ec
  80026b:	6a 69                	push   $0x69
  80026d:	68 1e 28 80 00       	push   $0x80281e
  800272:	e8 ee 06 00 00       	call   800965 <_panic>

			numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800277:	a1 24 30 80 00       	mov    0x803024,%eax
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	50                   	push   %eax
  800280:	e8 9e 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80028b:	e8 c1 1d 00 00       	call   802051 <sys_calculate_free_frames>
  800290:	89 c3                	mov    %eax,%ebx
  800292:	e8 d3 1d 00 00       	call   80206a <sys_calculate_modified_frames>
  800297:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80029a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80029d:	29 c2                	sub    %eax,%edx
  80029f:	89 d0                	mov    %edx,%eax
  8002a1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  8002a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002aa:	0f 84 05 01 00 00    	je     8003b5 <_main+0x37d>
  8002b0:	68 3c 29 80 00       	push   $0x80293c
  8002b5:	68 61 29 80 00       	push   $0x802961
  8002ba:	6a 6d                	push   $0x6d
  8002bc:	68 1e 28 80 00       	push   $0x80281e
  8002c1:	e8 9f 06 00 00       	call   800965 <_panic>
		}
		else if (Iteration == 2 )
  8002c6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ca:	75 72                	jne    80033e <_main+0x306>
		{
			if (!(NumOfElements == 5000 && Chose == 'b'))
  8002cc:	81 7d ec 88 13 00 00 	cmpl   $0x1388,-0x14(%ebp)
  8002d3:	75 06                	jne    8002db <_main+0x2a3>
  8002d5:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
				panic("Please ensure the number of elements and the initialization method of this test");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 ec 28 80 00       	push   $0x8028ec
  8002e3:	6a 72                	push   $0x72
  8002e5:	68 1e 28 80 00       	push   $0x80281e
  8002ea:	e8 76 06 00 00       	call   800965 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  8002ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 26 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  800303:	e8 49 1d 00 00       	call   802051 <sys_calculate_free_frames>
  800308:	89 c3                	mov    %eax,%ebx
  80030a:	e8 5b 1d 00 00       	call   80206a <sys_calculate_modified_frames>
  80030f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800312:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800315:	29 c2                	sub    %eax,%edx
  800317:	89 d0                	mov    %edx,%eax
  800319:	89 45 d0             	mov    %eax,-0x30(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  80031c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80031f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800322:	0f 84 8d 00 00 00    	je     8003b5 <_main+0x37d>
  800328:	68 3c 29 80 00       	push   $0x80293c
  80032d:	68 61 29 80 00       	push   $0x802961
  800332:	6a 76                	push   $0x76
  800334:	68 1e 28 80 00       	push   $0x80281e
  800339:	e8 27 06 00 00       	call   800965 <_panic>
		}
		else if (Iteration == 3 )
  80033e:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
  800342:	75 71                	jne    8003b5 <_main+0x37d>
		{
			if (!(NumOfElements == 300000 && Chose == 'c'))
  800344:	81 7d ec e0 93 04 00 	cmpl   $0x493e0,-0x14(%ebp)
  80034b:	75 06                	jne    800353 <_main+0x31b>
  80034d:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800351:	74 14                	je     800367 <_main+0x32f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 ec 28 80 00       	push   $0x8028ec
  80035b:	6a 7b                	push   $0x7b
  80035d:	68 1e 28 80 00       	push   $0x80281e
  800362:	e8 fe 05 00 00       	call   800965 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800367:	a1 24 30 80 00       	mov    0x803024,%eax
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	50                   	push   %eax
  800370:	e8 ae 00 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 cc             	mov    %eax,-0x34(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80037b:	e8 d1 1c 00 00       	call   802051 <sys_calculate_free_frames>
  800380:	89 c3                	mov    %eax,%ebx
  800382:	e8 e3 1c 00 00       	call   80206a <sys_calculate_modified_frames>
  800387:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80038a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80038d:	29 c2                	sub    %eax,%edx
  80038f:	89 d0                	mov    %edx,%eax
  800391:	89 45 c8             	mov    %eax,-0x38(%ebp)
			//cprintf("numOFEmptyLocInWS = %d\n", numOFEmptyLocInWS );
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  800394:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800397:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80039a:	74 19                	je     8003b5 <_main+0x37d>
  80039c:	68 3c 29 80 00       	push   $0x80293c
  8003a1:	68 61 29 80 00       	push   $0x802961
  8003a6:	68 80 00 00 00       	push   $0x80
  8003ab:	68 1e 28 80 00       	push   $0x80281e
  8003b0:	e8 b0 05 00 00       	call   800965 <_panic>
		}
		///========================================================================
	sys_disable_interrupt();
  8003b5:	e8 67 1d 00 00       	call   802121 <sys_disable_interrupt>
		Chose = 0 ;
  8003ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  8003be:	eb 42                	jmp    800402 <_main+0x3ca>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8003c0:	83 ec 0c             	sub    $0xc,%esp
  8003c3:	68 76 29 80 00       	push   $0x802976
  8003c8:	e8 4c 08 00 00       	call   800c19 <cprintf>
  8003cd:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8003d0:	e8 29 04 00 00       	call   8007fe <getchar>
  8003d5:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  8003d8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 d1 03 00 00       	call   8007b6 <cputchar>
  8003e5:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003e8:	83 ec 0c             	sub    $0xc,%esp
  8003eb:	6a 0a                	push   $0xa
  8003ed:	e8 c4 03 00 00       	call   8007b6 <cputchar>
  8003f2:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	6a 0a                	push   $0xa
  8003fa:	e8 b7 03 00 00       	call   8007b6 <cputchar>
  8003ff:	83 c4 10             	add    $0x10,%esp
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
		}
		///========================================================================
	sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800402:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800406:	74 06                	je     80040e <_main+0x3d6>
  800408:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80040c:	75 b2                	jne    8003c0 <_main+0x388>
			Chose = getchar() ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
	sys_enable_interrupt();
  80040e:	e8 28 1d 00 00       	call   80213b <sys_enable_interrupt>

	} while (Chose == 'y');
  800413:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800417:	0f 84 2c fc ff ff    	je     800049 <_main+0x11>
}
  80041d:	90                   	nop
  80041e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800421:	c9                   	leave  
  800422:	c3                   	ret    

00800423 <CheckAndCountEmptyLocInWS>:

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	83 ec 18             	sub    $0x18,%esp
	int numOFEmptyLocInWS = 0, i;
  800429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  800430:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800437:	eb 74                	jmp    8004ad <CheckAndCountEmptyLocInWS+0x8a>
	{
		if (myEnv->__uptr_pws[i].empty)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800442:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800445:	89 d0                	mov    %edx,%eax
  800447:	01 c0                	add    %eax,%eax
  800449:	01 d0                	add    %edx,%eax
  80044b:	c1 e0 02             	shl    $0x2,%eax
  80044e:	01 c8                	add    %ecx,%eax
  800450:	8a 40 04             	mov    0x4(%eax),%al
  800453:	84 c0                	test   %al,%al
  800455:	74 05                	je     80045c <CheckAndCountEmptyLocInWS+0x39>
		{
			numOFEmptyLocInWS++;
  800457:	ff 45 f4             	incl   -0xc(%ebp)
  80045a:	eb 4e                	jmp    8004aa <CheckAndCountEmptyLocInWS+0x87>
		}
		else
		{
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800465:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800468:	89 d0                	mov    %edx,%eax
  80046a:	01 c0                	add    %eax,%eax
  80046c:	01 d0                	add    %edx,%eax
  80046e:	c1 e0 02             	shl    $0x2,%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	8b 00                	mov    (%eax),%eax
  800475:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800478:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800480:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
  800483:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	79 20                	jns    8004aa <CheckAndCountEmptyLocInWS+0x87>
  80048a:	81 7d e8 ff ff ff 9f 	cmpl   $0x9fffffff,-0x18(%ebp)
  800491:	77 17                	ja     8004aa <CheckAndCountEmptyLocInWS+0x87>
				panic("freeMem didn't remove its page(s) from the WS");
  800493:	83 ec 04             	sub    $0x4,%esp
  800496:	68 94 29 80 00       	push   $0x802994
  80049b:	68 9f 00 00 00       	push   $0x9f
  8004a0:	68 1e 28 80 00       	push   $0x80281e
  8004a5:	e8 bb 04 00 00       	call   800965 <_panic>
}

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
	int numOFEmptyLocInWS = 0, i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  8004aa:	ff 45 f0             	incl   -0x10(%ebp)
  8004ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b0:	8b 50 74             	mov    0x74(%eax),%edx
  8004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004b6:	39 c2                	cmp    %eax,%edx
  8004b8:	0f 87 7b ff ff ff    	ja     800439 <CheckAndCountEmptyLocInWS+0x16>
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
				panic("freeMem didn't remove its page(s) from the WS");
		}
	}
	return numOFEmptyLocInWS;
  8004be:	8b 45 f4             	mov    -0xc(%ebp),%eax

}
  8004c1:	c9                   	leave  
  8004c2:	c3                   	ret    

008004c3 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8004c3:	55                   	push   %ebp
  8004c4:	89 e5                	mov    %esp,%ebp
  8004c6:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cc:	48                   	dec    %eax
  8004cd:	50                   	push   %eax
  8004ce:	6a 00                	push   $0x0
  8004d0:	ff 75 0c             	pushl  0xc(%ebp)
  8004d3:	ff 75 08             	pushl  0x8(%ebp)
  8004d6:	e8 06 00 00 00       	call   8004e1 <QSort>
  8004db:	83 c4 10             	add    $0x10,%esp
}
  8004de:	90                   	nop
  8004df:	c9                   	leave  
  8004e0:	c3                   	ret    

008004e1 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8004e1:	55                   	push   %ebp
  8004e2:	89 e5                	mov    %esp,%ebp
  8004e4:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8004e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ea:	3b 45 14             	cmp    0x14(%ebp),%eax
  8004ed:	0f 8d de 00 00 00    	jge    8005d1 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8004f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f6:	40                   	inc    %eax
  8004f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8004fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fd:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800500:	e9 80 00 00 00       	jmp    800585 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800505:	ff 45 f4             	incl   -0xc(%ebp)
  800508:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80050e:	7f 2b                	jg     80053b <QSort+0x5a>
  800510:	8b 45 10             	mov    0x10(%ebp),%eax
  800513:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051a:	8b 45 08             	mov    0x8(%ebp),%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	8b 10                	mov    (%eax),%edx
  800521:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800524:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	01 c8                	add    %ecx,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	39 c2                	cmp    %eax,%edx
  800534:	7d cf                	jge    800505 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800536:	eb 03                	jmp    80053b <QSort+0x5a>
  800538:	ff 4d f0             	decl   -0x10(%ebp)
  80053b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800541:	7e 26                	jle    800569 <QSort+0x88>
  800543:	8b 45 10             	mov    0x10(%ebp),%eax
  800546:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	01 d0                	add    %edx,%eax
  800552:	8b 10                	mov    (%eax),%edx
  800554:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800557:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	01 c8                	add    %ecx,%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	39 c2                	cmp    %eax,%edx
  800567:	7e cf                	jle    800538 <QSort+0x57>

		if (i <= j)
  800569:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80056f:	7f 14                	jg     800585 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800571:	83 ec 04             	sub    $0x4,%esp
  800574:	ff 75 f0             	pushl  -0x10(%ebp)
  800577:	ff 75 f4             	pushl  -0xc(%ebp)
  80057a:	ff 75 08             	pushl  0x8(%ebp)
  80057d:	e8 a9 00 00 00       	call   80062b <Swap>
  800582:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800588:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058b:	0f 8e 77 ff ff ff    	jle    800508 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800591:	83 ec 04             	sub    $0x4,%esp
  800594:	ff 75 f0             	pushl  -0x10(%ebp)
  800597:	ff 75 10             	pushl  0x10(%ebp)
  80059a:	ff 75 08             	pushl  0x8(%ebp)
  80059d:	e8 89 00 00 00       	call   80062b <Swap>
  8005a2:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a8:	48                   	dec    %eax
  8005a9:	50                   	push   %eax
  8005aa:	ff 75 10             	pushl  0x10(%ebp)
  8005ad:	ff 75 0c             	pushl  0xc(%ebp)
  8005b0:	ff 75 08             	pushl  0x8(%ebp)
  8005b3:	e8 29 ff ff ff       	call   8004e1 <QSort>
  8005b8:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8005bb:	ff 75 14             	pushl  0x14(%ebp)
  8005be:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c1:	ff 75 0c             	pushl  0xc(%ebp)
  8005c4:	ff 75 08             	pushl  0x8(%ebp)
  8005c7:	e8 15 ff ff ff       	call   8004e1 <QSort>
  8005cc:	83 c4 10             	add    $0x10,%esp
  8005cf:	eb 01                	jmp    8005d2 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8005d1:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8005da:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8005e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005e8:	eb 33                	jmp    80061d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8005ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	8b 10                	mov    (%eax),%edx
  8005fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005fe:	40                   	inc    %eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	39 c2                	cmp    %eax,%edx
  80060f:	7e 09                	jle    80061a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800611:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800618:	eb 0c                	jmp    800626 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80061a:	ff 45 f8             	incl   -0x8(%ebp)
  80061d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800620:	48                   	dec    %eax
  800621:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800624:	7f c4                	jg     8005ea <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800626:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800629:	c9                   	leave  
  80062a:	c3                   	ret    

0080062b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80062b:	55                   	push   %ebp
  80062c:	89 e5                	mov    %esp,%ebp
  80062e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	01 c2                	add    %eax,%edx
  800654:	8b 45 10             	mov    0x10(%ebp),%eax
  800657:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	01 c8                	add    %ecx,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800667:	8b 45 10             	mov    0x10(%ebp),%eax
  80066a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	01 c2                	add    %eax,%edx
  800676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800679:	89 02                	mov    %eax,(%edx)
}
  80067b:	90                   	nop
  80067c:	c9                   	leave  
  80067d:	c3                   	ret    

0080067e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
  800681:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800684:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80068b:	eb 17                	jmp    8006a4 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80068d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800690:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	01 c2                	add    %eax,%edx
  80069c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80069f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006a1:	ff 45 fc             	incl   -0x4(%ebp)
  8006a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006aa:	7c e1                	jl     80068d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8006ac:	90                   	nop
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8006bc:	eb 1b                	jmp    8006d9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8006be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	01 c2                	add    %eax,%edx
  8006cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8006d3:	48                   	dec    %eax
  8006d4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006d6:	ff 45 fc             	incl   -0x4(%ebp)
  8006d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006df:	7c dd                	jl     8006be <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8006e1:	90                   	nop
  8006e2:	c9                   	leave  
  8006e3:	c3                   	ret    

008006e4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8006e4:	55                   	push   %ebp
  8006e5:	89 e5                	mov    %esp,%ebp
  8006e7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8006ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006ed:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8006f2:	f7 e9                	imul   %ecx
  8006f4:	c1 f9 1f             	sar    $0x1f,%ecx
  8006f7:	89 d0                	mov    %edx,%eax
  8006f9:	29 c8                	sub    %ecx,%eax
  8006fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8006fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800705:	eb 1e                	jmp    800725 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800707:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80070a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800717:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80071a:	99                   	cltd   
  80071b:	f7 7d f8             	idivl  -0x8(%ebp)
  80071e:	89 d0                	mov    %edx,%eax
  800720:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800722:	ff 45 fc             	incl   -0x4(%ebp)
  800725:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800728:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80072b:	7c da                	jl     800707 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80072d:	90                   	nop
  80072e:	c9                   	leave  
  80072f:	c3                   	ret    

00800730 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800730:	55                   	push   %ebp
  800731:	89 e5                	mov    %esp,%ebp
  800733:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800736:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80073d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800744:	eb 42                	jmp    800788 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800746:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800749:	99                   	cltd   
  80074a:	f7 7d f0             	idivl  -0x10(%ebp)
  80074d:	89 d0                	mov    %edx,%eax
  80074f:	85 c0                	test   %eax,%eax
  800751:	75 10                	jne    800763 <PrintElements+0x33>
			cprintf("\n");
  800753:	83 ec 0c             	sub    $0xc,%esp
  800756:	68 c2 29 80 00       	push   $0x8029c2
  80075b:	e8 b9 04 00 00       	call   800c19 <cprintf>
  800760:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800763:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800766:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	01 d0                	add    %edx,%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	50                   	push   %eax
  800778:	68 c4 29 80 00       	push   $0x8029c4
  80077d:	e8 97 04 00 00       	call   800c19 <cprintf>
  800782:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800785:	ff 45 f4             	incl   -0xc(%ebp)
  800788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078b:	48                   	dec    %eax
  80078c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80078f:	7f b5                	jg     800746 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800791:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800794:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	01 d0                	add    %edx,%eax
  8007a0:	8b 00                	mov    (%eax),%eax
  8007a2:	83 ec 08             	sub    $0x8,%esp
  8007a5:	50                   	push   %eax
  8007a6:	68 c9 29 80 00       	push   $0x8029c9
  8007ab:	e8 69 04 00 00       	call   800c19 <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp

}
  8007b3:	90                   	nop
  8007b4:	c9                   	leave  
  8007b5:	c3                   	ret    

008007b6 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8007b6:	55                   	push   %ebp
  8007b7:	89 e5                	mov    %esp,%ebp
  8007b9:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007c2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007c6:	83 ec 0c             	sub    $0xc,%esp
  8007c9:	50                   	push   %eax
  8007ca:	e8 86 19 00 00       	call   802155 <sys_cputc>
  8007cf:	83 c4 10             	add    $0x10,%esp
}
  8007d2:	90                   	nop
  8007d3:	c9                   	leave  
  8007d4:	c3                   	ret    

008007d5 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8007d5:	55                   	push   %ebp
  8007d6:	89 e5                	mov    %esp,%ebp
  8007d8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007db:	e8 41 19 00 00       	call   802121 <sys_disable_interrupt>
	char c = ch;
  8007e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e3:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007e6:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007ea:	83 ec 0c             	sub    $0xc,%esp
  8007ed:	50                   	push   %eax
  8007ee:	e8 62 19 00 00       	call   802155 <sys_cputc>
  8007f3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007f6:	e8 40 19 00 00       	call   80213b <sys_enable_interrupt>
}
  8007fb:	90                   	nop
  8007fc:	c9                   	leave  
  8007fd:	c3                   	ret    

008007fe <getchar>:

int
getchar(void)
{
  8007fe:	55                   	push   %ebp
  8007ff:	89 e5                	mov    %esp,%ebp
  800801:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800804:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80080b:	eb 08                	jmp    800815 <getchar+0x17>
	{
		c = sys_cgetc();
  80080d:	e8 27 17 00 00       	call   801f39 <sys_cgetc>
  800812:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800819:	74 f2                	je     80080d <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80081b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80081e:	c9                   	leave  
  80081f:	c3                   	ret    

00800820 <atomic_getchar>:

int
atomic_getchar(void)
{
  800820:	55                   	push   %ebp
  800821:	89 e5                	mov    %esp,%ebp
  800823:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800826:	e8 f6 18 00 00       	call   802121 <sys_disable_interrupt>
	int c=0;
  80082b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800832:	eb 08                	jmp    80083c <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800834:	e8 00 17 00 00       	call   801f39 <sys_cgetc>
  800839:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80083c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800840:	74 f2                	je     800834 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800842:	e8 f4 18 00 00       	call   80213b <sys_enable_interrupt>
	return c;
  800847:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80084a:	c9                   	leave  
  80084b:	c3                   	ret    

0080084c <iscons>:

int iscons(int fdnum)
{
  80084c:	55                   	push   %ebp
  80084d:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80084f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800854:	5d                   	pop    %ebp
  800855:	c3                   	ret    

00800856 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
  800859:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80085c:	e8 25 17 00 00       	call   801f86 <sys_getenvindex>
  800861:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800864:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800867:	89 d0                	mov    %edx,%eax
  800869:	c1 e0 02             	shl    $0x2,%eax
  80086c:	01 d0                	add    %edx,%eax
  80086e:	01 c0                	add    %eax,%eax
  800870:	01 d0                	add    %edx,%eax
  800872:	01 c0                	add    %eax,%eax
  800874:	01 d0                	add    %edx,%eax
  800876:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80087d:	01 d0                	add    %edx,%eax
  80087f:	c1 e0 02             	shl    $0x2,%eax
  800882:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800887:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80088c:	a1 24 30 80 00       	mov    0x803024,%eax
  800891:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800897:	84 c0                	test   %al,%al
  800899:	74 0f                	je     8008aa <libmain+0x54>
		binaryname = myEnv->prog_name;
  80089b:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a0:	05 f4 02 00 00       	add    $0x2f4,%eax
  8008a5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008ae:	7e 0a                	jle    8008ba <libmain+0x64>
		binaryname = argv[0];
  8008b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008ba:	83 ec 08             	sub    $0x8,%esp
  8008bd:	ff 75 0c             	pushl  0xc(%ebp)
  8008c0:	ff 75 08             	pushl  0x8(%ebp)
  8008c3:	e8 70 f7 ff ff       	call   800038 <_main>
  8008c8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008cb:	e8 51 18 00 00       	call   802121 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008d0:	83 ec 0c             	sub    $0xc,%esp
  8008d3:	68 e8 29 80 00       	push   $0x8029e8
  8008d8:	e8 3c 03 00 00       	call   800c19 <cprintf>
  8008dd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e5:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8008eb:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f0:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8008f6:	83 ec 04             	sub    $0x4,%esp
  8008f9:	52                   	push   %edx
  8008fa:	50                   	push   %eax
  8008fb:	68 10 2a 80 00       	push   $0x802a10
  800900:	e8 14 03 00 00       	call   800c19 <cprintf>
  800905:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800908:	a1 24 30 80 00       	mov    0x803024,%eax
  80090d:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800913:	83 ec 08             	sub    $0x8,%esp
  800916:	50                   	push   %eax
  800917:	68 35 2a 80 00       	push   $0x802a35
  80091c:	e8 f8 02 00 00       	call   800c19 <cprintf>
  800921:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800924:	83 ec 0c             	sub    $0xc,%esp
  800927:	68 e8 29 80 00       	push   $0x8029e8
  80092c:	e8 e8 02 00 00       	call   800c19 <cprintf>
  800931:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800934:	e8 02 18 00 00       	call   80213b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800939:	e8 19 00 00 00       	call   800957 <exit>
}
  80093e:	90                   	nop
  80093f:	c9                   	leave  
  800940:	c3                   	ret    

00800941 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800941:	55                   	push   %ebp
  800942:	89 e5                	mov    %esp,%ebp
  800944:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800947:	83 ec 0c             	sub    $0xc,%esp
  80094a:	6a 00                	push   $0x0
  80094c:	e8 01 16 00 00       	call   801f52 <sys_env_destroy>
  800951:	83 c4 10             	add    $0x10,%esp
}
  800954:	90                   	nop
  800955:	c9                   	leave  
  800956:	c3                   	ret    

00800957 <exit>:

void
exit(void)
{
  800957:	55                   	push   %ebp
  800958:	89 e5                	mov    %esp,%ebp
  80095a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80095d:	e8 56 16 00 00       	call   801fb8 <sys_env_exit>
}
  800962:	90                   	nop
  800963:	c9                   	leave  
  800964:	c3                   	ret    

00800965 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800965:	55                   	push   %ebp
  800966:	89 e5                	mov    %esp,%ebp
  800968:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80096b:	8d 45 10             	lea    0x10(%ebp),%eax
  80096e:	83 c0 04             	add    $0x4,%eax
  800971:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800974:	a1 48 30 88 00       	mov    0x883048,%eax
  800979:	85 c0                	test   %eax,%eax
  80097b:	74 16                	je     800993 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80097d:	a1 48 30 88 00       	mov    0x883048,%eax
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	50                   	push   %eax
  800986:	68 4c 2a 80 00       	push   $0x802a4c
  80098b:	e8 89 02 00 00       	call   800c19 <cprintf>
  800990:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800993:	a1 00 30 80 00       	mov    0x803000,%eax
  800998:	ff 75 0c             	pushl  0xc(%ebp)
  80099b:	ff 75 08             	pushl  0x8(%ebp)
  80099e:	50                   	push   %eax
  80099f:	68 51 2a 80 00       	push   $0x802a51
  8009a4:	e8 70 02 00 00       	call   800c19 <cprintf>
  8009a9:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8009ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b5:	50                   	push   %eax
  8009b6:	e8 f3 01 00 00       	call   800bae <vcprintf>
  8009bb:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009be:	83 ec 08             	sub    $0x8,%esp
  8009c1:	6a 00                	push   $0x0
  8009c3:	68 6d 2a 80 00       	push   $0x802a6d
  8009c8:	e8 e1 01 00 00       	call   800bae <vcprintf>
  8009cd:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009d0:	e8 82 ff ff ff       	call   800957 <exit>

	// should not return here
	while (1) ;
  8009d5:	eb fe                	jmp    8009d5 <_panic+0x70>

008009d7 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
  8009da:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009dd:	a1 24 30 80 00       	mov    0x803024,%eax
  8009e2:	8b 50 74             	mov    0x74(%eax),%edx
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	39 c2                	cmp    %eax,%edx
  8009ea:	74 14                	je     800a00 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8009ec:	83 ec 04             	sub    $0x4,%esp
  8009ef:	68 70 2a 80 00       	push   $0x802a70
  8009f4:	6a 26                	push   $0x26
  8009f6:	68 bc 2a 80 00       	push   $0x802abc
  8009fb:	e8 65 ff ff ff       	call   800965 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a07:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a0e:	e9 c2 00 00 00       	jmp    800ad5 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a16:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	01 d0                	add    %edx,%eax
  800a22:	8b 00                	mov    (%eax),%eax
  800a24:	85 c0                	test   %eax,%eax
  800a26:	75 08                	jne    800a30 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a28:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a2b:	e9 a2 00 00 00       	jmp    800ad2 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800a30:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a37:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a3e:	eb 69                	jmp    800aa9 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a40:	a1 24 30 80 00       	mov    0x803024,%eax
  800a45:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a4b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a4e:	89 d0                	mov    %edx,%eax
  800a50:	01 c0                	add    %eax,%eax
  800a52:	01 d0                	add    %edx,%eax
  800a54:	c1 e0 02             	shl    $0x2,%eax
  800a57:	01 c8                	add    %ecx,%eax
  800a59:	8a 40 04             	mov    0x4(%eax),%al
  800a5c:	84 c0                	test   %al,%al
  800a5e:	75 46                	jne    800aa6 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a60:	a1 24 30 80 00       	mov    0x803024,%eax
  800a65:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800a6b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a6e:	89 d0                	mov    %edx,%eax
  800a70:	01 c0                	add    %eax,%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	c1 e0 02             	shl    $0x2,%eax
  800a77:	01 c8                	add    %ecx,%eax
  800a79:	8b 00                	mov    (%eax),%eax
  800a7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a7e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a81:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a86:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	01 c8                	add    %ecx,%eax
  800a97:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a99:	39 c2                	cmp    %eax,%edx
  800a9b:	75 09                	jne    800aa6 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a9d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800aa4:	eb 12                	jmp    800ab8 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aa6:	ff 45 e8             	incl   -0x18(%ebp)
  800aa9:	a1 24 30 80 00       	mov    0x803024,%eax
  800aae:	8b 50 74             	mov    0x74(%eax),%edx
  800ab1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ab4:	39 c2                	cmp    %eax,%edx
  800ab6:	77 88                	ja     800a40 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800ab8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800abc:	75 14                	jne    800ad2 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800abe:	83 ec 04             	sub    $0x4,%esp
  800ac1:	68 c8 2a 80 00       	push   $0x802ac8
  800ac6:	6a 3a                	push   $0x3a
  800ac8:	68 bc 2a 80 00       	push   $0x802abc
  800acd:	e8 93 fe ff ff       	call   800965 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800ad2:	ff 45 f0             	incl   -0x10(%ebp)
  800ad5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800adb:	0f 8c 32 ff ff ff    	jl     800a13 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800ae1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ae8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800aef:	eb 26                	jmp    800b17 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800af1:	a1 24 30 80 00       	mov    0x803024,%eax
  800af6:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800afc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800aff:	89 d0                	mov    %edx,%eax
  800b01:	01 c0                	add    %eax,%eax
  800b03:	01 d0                	add    %edx,%eax
  800b05:	c1 e0 02             	shl    $0x2,%eax
  800b08:	01 c8                	add    %ecx,%eax
  800b0a:	8a 40 04             	mov    0x4(%eax),%al
  800b0d:	3c 01                	cmp    $0x1,%al
  800b0f:	75 03                	jne    800b14 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b11:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b14:	ff 45 e0             	incl   -0x20(%ebp)
  800b17:	a1 24 30 80 00       	mov    0x803024,%eax
  800b1c:	8b 50 74             	mov    0x74(%eax),%edx
  800b1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b22:	39 c2                	cmp    %eax,%edx
  800b24:	77 cb                	ja     800af1 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b29:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b2c:	74 14                	je     800b42 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800b2e:	83 ec 04             	sub    $0x4,%esp
  800b31:	68 1c 2b 80 00       	push   $0x802b1c
  800b36:	6a 44                	push   $0x44
  800b38:	68 bc 2a 80 00       	push   $0x802abc
  800b3d:	e8 23 fe ff ff       	call   800965 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b42:	90                   	nop
  800b43:	c9                   	leave  
  800b44:	c3                   	ret    

00800b45 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	8d 48 01             	lea    0x1(%eax),%ecx
  800b53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b56:	89 0a                	mov    %ecx,(%edx)
  800b58:	8b 55 08             	mov    0x8(%ebp),%edx
  800b5b:	88 d1                	mov    %dl,%cl
  800b5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b60:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b6e:	75 2c                	jne    800b9c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b70:	a0 28 30 80 00       	mov    0x803028,%al
  800b75:	0f b6 c0             	movzbl %al,%eax
  800b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7b:	8b 12                	mov    (%edx),%edx
  800b7d:	89 d1                	mov    %edx,%ecx
  800b7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b82:	83 c2 08             	add    $0x8,%edx
  800b85:	83 ec 04             	sub    $0x4,%esp
  800b88:	50                   	push   %eax
  800b89:	51                   	push   %ecx
  800b8a:	52                   	push   %edx
  800b8b:	e8 80 13 00 00       	call   801f10 <sys_cputs>
  800b90:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b96:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9f:	8b 40 04             	mov    0x4(%eax),%eax
  800ba2:	8d 50 01             	lea    0x1(%eax),%edx
  800ba5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba8:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bab:	90                   	nop
  800bac:	c9                   	leave  
  800bad:	c3                   	ret    

00800bae <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
  800bb1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bb7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800bbe:	00 00 00 
	b.cnt = 0;
  800bc1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800bc8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	ff 75 08             	pushl  0x8(%ebp)
  800bd1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bd7:	50                   	push   %eax
  800bd8:	68 45 0b 80 00       	push   $0x800b45
  800bdd:	e8 11 02 00 00       	call   800df3 <vprintfmt>
  800be2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800be5:	a0 28 30 80 00       	mov    0x803028,%al
  800bea:	0f b6 c0             	movzbl %al,%eax
  800bed:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800bf3:	83 ec 04             	sub    $0x4,%esp
  800bf6:	50                   	push   %eax
  800bf7:	52                   	push   %edx
  800bf8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bfe:	83 c0 08             	add    $0x8,%eax
  800c01:	50                   	push   %eax
  800c02:	e8 09 13 00 00       	call   801f10 <sys_cputs>
  800c07:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c0a:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800c11:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c17:	c9                   	leave  
  800c18:	c3                   	ret    

00800c19 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c19:	55                   	push   %ebp
  800c1a:	89 e5                	mov    %esp,%ebp
  800c1c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c1f:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800c26:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c29:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	83 ec 08             	sub    $0x8,%esp
  800c32:	ff 75 f4             	pushl  -0xc(%ebp)
  800c35:	50                   	push   %eax
  800c36:	e8 73 ff ff ff       	call   800bae <vcprintf>
  800c3b:	83 c4 10             	add    $0x10,%esp
  800c3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c44:	c9                   	leave  
  800c45:	c3                   	ret    

00800c46 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c46:	55                   	push   %ebp
  800c47:	89 e5                	mov    %esp,%ebp
  800c49:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c4c:	e8 d0 14 00 00       	call   802121 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c51:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c54:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	83 ec 08             	sub    $0x8,%esp
  800c5d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c60:	50                   	push   %eax
  800c61:	e8 48 ff ff ff       	call   800bae <vcprintf>
  800c66:	83 c4 10             	add    $0x10,%esp
  800c69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c6c:	e8 ca 14 00 00       	call   80213b <sys_enable_interrupt>
	return cnt;
  800c71:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c74:	c9                   	leave  
  800c75:	c3                   	ret    

00800c76 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c76:	55                   	push   %ebp
  800c77:	89 e5                	mov    %esp,%ebp
  800c79:	53                   	push   %ebx
  800c7a:	83 ec 14             	sub    $0x14,%esp
  800c7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c83:	8b 45 14             	mov    0x14(%ebp),%eax
  800c86:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c89:	8b 45 18             	mov    0x18(%ebp),%eax
  800c8c:	ba 00 00 00 00       	mov    $0x0,%edx
  800c91:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c94:	77 55                	ja     800ceb <printnum+0x75>
  800c96:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c99:	72 05                	jb     800ca0 <printnum+0x2a>
  800c9b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c9e:	77 4b                	ja     800ceb <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ca0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ca3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ca6:	8b 45 18             	mov    0x18(%ebp),%eax
  800ca9:	ba 00 00 00 00       	mov    $0x0,%edx
  800cae:	52                   	push   %edx
  800caf:	50                   	push   %eax
  800cb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb3:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb6:	e8 45 18 00 00       	call   802500 <__udivdi3>
  800cbb:	83 c4 10             	add    $0x10,%esp
  800cbe:	83 ec 04             	sub    $0x4,%esp
  800cc1:	ff 75 20             	pushl  0x20(%ebp)
  800cc4:	53                   	push   %ebx
  800cc5:	ff 75 18             	pushl  0x18(%ebp)
  800cc8:	52                   	push   %edx
  800cc9:	50                   	push   %eax
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	ff 75 08             	pushl  0x8(%ebp)
  800cd0:	e8 a1 ff ff ff       	call   800c76 <printnum>
  800cd5:	83 c4 20             	add    $0x20,%esp
  800cd8:	eb 1a                	jmp    800cf4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	ff 75 0c             	pushl  0xc(%ebp)
  800ce0:	ff 75 20             	pushl  0x20(%ebp)
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	ff d0                	call   *%eax
  800ce8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ceb:	ff 4d 1c             	decl   0x1c(%ebp)
  800cee:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800cf2:	7f e6                	jg     800cda <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800cf4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800cf7:	bb 00 00 00 00       	mov    $0x0,%ebx
  800cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d02:	53                   	push   %ebx
  800d03:	51                   	push   %ecx
  800d04:	52                   	push   %edx
  800d05:	50                   	push   %eax
  800d06:	e8 05 19 00 00       	call   802610 <__umoddi3>
  800d0b:	83 c4 10             	add    $0x10,%esp
  800d0e:	05 94 2d 80 00       	add    $0x802d94,%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	0f be c0             	movsbl %al,%eax
  800d18:	83 ec 08             	sub    $0x8,%esp
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	50                   	push   %eax
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	ff d0                	call   *%eax
  800d24:	83 c4 10             	add    $0x10,%esp
}
  800d27:	90                   	nop
  800d28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d2b:	c9                   	leave  
  800d2c:	c3                   	ret    

00800d2d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d2d:	55                   	push   %ebp
  800d2e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d30:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d34:	7e 1c                	jle    800d52 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8b 00                	mov    (%eax),%eax
  800d3b:	8d 50 08             	lea    0x8(%eax),%edx
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	89 10                	mov    %edx,(%eax)
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8b 00                	mov    (%eax),%eax
  800d48:	83 e8 08             	sub    $0x8,%eax
  800d4b:	8b 50 04             	mov    0x4(%eax),%edx
  800d4e:	8b 00                	mov    (%eax),%eax
  800d50:	eb 40                	jmp    800d92 <getuint+0x65>
	else if (lflag)
  800d52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d56:	74 1e                	je     800d76 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8b 00                	mov    (%eax),%eax
  800d5d:	8d 50 04             	lea    0x4(%eax),%edx
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	89 10                	mov    %edx,(%eax)
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8b 00                	mov    (%eax),%eax
  800d6a:	83 e8 04             	sub    $0x4,%eax
  800d6d:	8b 00                	mov    (%eax),%eax
  800d6f:	ba 00 00 00 00       	mov    $0x0,%edx
  800d74:	eb 1c                	jmp    800d92 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8b 00                	mov    (%eax),%eax
  800d7b:	8d 50 04             	lea    0x4(%eax),%edx
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	89 10                	mov    %edx,(%eax)
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8b 00                	mov    (%eax),%eax
  800d88:	83 e8 04             	sub    $0x4,%eax
  800d8b:	8b 00                	mov    (%eax),%eax
  800d8d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d92:	5d                   	pop    %ebp
  800d93:	c3                   	ret    

00800d94 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d97:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d9b:	7e 1c                	jle    800db9 <getint+0x25>
		return va_arg(*ap, long long);
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	8b 00                	mov    (%eax),%eax
  800da2:	8d 50 08             	lea    0x8(%eax),%edx
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	89 10                	mov    %edx,(%eax)
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	8b 00                	mov    (%eax),%eax
  800daf:	83 e8 08             	sub    $0x8,%eax
  800db2:	8b 50 04             	mov    0x4(%eax),%edx
  800db5:	8b 00                	mov    (%eax),%eax
  800db7:	eb 38                	jmp    800df1 <getint+0x5d>
	else if (lflag)
  800db9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dbd:	74 1a                	je     800dd9 <getint+0x45>
		return va_arg(*ap, long);
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8b 00                	mov    (%eax),%eax
  800dc4:	8d 50 04             	lea    0x4(%eax),%edx
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	89 10                	mov    %edx,(%eax)
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8b 00                	mov    (%eax),%eax
  800dd1:	83 e8 04             	sub    $0x4,%eax
  800dd4:	8b 00                	mov    (%eax),%eax
  800dd6:	99                   	cltd   
  800dd7:	eb 18                	jmp    800df1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	8d 50 04             	lea    0x4(%eax),%edx
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	89 10                	mov    %edx,(%eax)
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8b 00                	mov    (%eax),%eax
  800deb:	83 e8 04             	sub    $0x4,%eax
  800dee:	8b 00                	mov    (%eax),%eax
  800df0:	99                   	cltd   
}
  800df1:	5d                   	pop    %ebp
  800df2:	c3                   	ret    

00800df3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800df3:	55                   	push   %ebp
  800df4:	89 e5                	mov    %esp,%ebp
  800df6:	56                   	push   %esi
  800df7:	53                   	push   %ebx
  800df8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800dfb:	eb 17                	jmp    800e14 <vprintfmt+0x21>
			if (ch == '\0')
  800dfd:	85 db                	test   %ebx,%ebx
  800dff:	0f 84 af 03 00 00    	je     8011b4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e05:	83 ec 08             	sub    $0x8,%esp
  800e08:	ff 75 0c             	pushl  0xc(%ebp)
  800e0b:	53                   	push   %ebx
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	ff d0                	call   *%eax
  800e11:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e14:	8b 45 10             	mov    0x10(%ebp),%eax
  800e17:	8d 50 01             	lea    0x1(%eax),%edx
  800e1a:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1d:	8a 00                	mov    (%eax),%al
  800e1f:	0f b6 d8             	movzbl %al,%ebx
  800e22:	83 fb 25             	cmp    $0x25,%ebx
  800e25:	75 d6                	jne    800dfd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e27:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e2b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e32:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e39:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e40:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e47:	8b 45 10             	mov    0x10(%ebp),%eax
  800e4a:	8d 50 01             	lea    0x1(%eax),%edx
  800e4d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	0f b6 d8             	movzbl %al,%ebx
  800e55:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e58:	83 f8 55             	cmp    $0x55,%eax
  800e5b:	0f 87 2b 03 00 00    	ja     80118c <vprintfmt+0x399>
  800e61:	8b 04 85 b8 2d 80 00 	mov    0x802db8(,%eax,4),%eax
  800e68:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e6a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e6e:	eb d7                	jmp    800e47 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e70:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e74:	eb d1                	jmp    800e47 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e76:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e7d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e80:	89 d0                	mov    %edx,%eax
  800e82:	c1 e0 02             	shl    $0x2,%eax
  800e85:	01 d0                	add    %edx,%eax
  800e87:	01 c0                	add    %eax,%eax
  800e89:	01 d8                	add    %ebx,%eax
  800e8b:	83 e8 30             	sub    $0x30,%eax
  800e8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e91:	8b 45 10             	mov    0x10(%ebp),%eax
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e99:	83 fb 2f             	cmp    $0x2f,%ebx
  800e9c:	7e 3e                	jle    800edc <vprintfmt+0xe9>
  800e9e:	83 fb 39             	cmp    $0x39,%ebx
  800ea1:	7f 39                	jg     800edc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ea3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ea6:	eb d5                	jmp    800e7d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ea8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eab:	83 c0 04             	add    $0x4,%eax
  800eae:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb4:	83 e8 04             	sub    $0x4,%eax
  800eb7:	8b 00                	mov    (%eax),%eax
  800eb9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ebc:	eb 1f                	jmp    800edd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ebe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec2:	79 83                	jns    800e47 <vprintfmt+0x54>
				width = 0;
  800ec4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ecb:	e9 77 ff ff ff       	jmp    800e47 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ed0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ed7:	e9 6b ff ff ff       	jmp    800e47 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800edc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800edd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ee1:	0f 89 60 ff ff ff    	jns    800e47 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ee7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800eea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800eed:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ef4:	e9 4e ff ff ff       	jmp    800e47 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ef9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800efc:	e9 46 ff ff ff       	jmp    800e47 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f01:	8b 45 14             	mov    0x14(%ebp),%eax
  800f04:	83 c0 04             	add    $0x4,%eax
  800f07:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0d:	83 e8 04             	sub    $0x4,%eax
  800f10:	8b 00                	mov    (%eax),%eax
  800f12:	83 ec 08             	sub    $0x8,%esp
  800f15:	ff 75 0c             	pushl  0xc(%ebp)
  800f18:	50                   	push   %eax
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	ff d0                	call   *%eax
  800f1e:	83 c4 10             	add    $0x10,%esp
			break;
  800f21:	e9 89 02 00 00       	jmp    8011af <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f26:	8b 45 14             	mov    0x14(%ebp),%eax
  800f29:	83 c0 04             	add    $0x4,%eax
  800f2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f32:	83 e8 04             	sub    $0x4,%eax
  800f35:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f37:	85 db                	test   %ebx,%ebx
  800f39:	79 02                	jns    800f3d <vprintfmt+0x14a>
				err = -err;
  800f3b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f3d:	83 fb 64             	cmp    $0x64,%ebx
  800f40:	7f 0b                	jg     800f4d <vprintfmt+0x15a>
  800f42:	8b 34 9d 00 2c 80 00 	mov    0x802c00(,%ebx,4),%esi
  800f49:	85 f6                	test   %esi,%esi
  800f4b:	75 19                	jne    800f66 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f4d:	53                   	push   %ebx
  800f4e:	68 a5 2d 80 00       	push   $0x802da5
  800f53:	ff 75 0c             	pushl  0xc(%ebp)
  800f56:	ff 75 08             	pushl  0x8(%ebp)
  800f59:	e8 5e 02 00 00       	call   8011bc <printfmt>
  800f5e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f61:	e9 49 02 00 00       	jmp    8011af <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f66:	56                   	push   %esi
  800f67:	68 ae 2d 80 00       	push   $0x802dae
  800f6c:	ff 75 0c             	pushl  0xc(%ebp)
  800f6f:	ff 75 08             	pushl  0x8(%ebp)
  800f72:	e8 45 02 00 00       	call   8011bc <printfmt>
  800f77:	83 c4 10             	add    $0x10,%esp
			break;
  800f7a:	e9 30 02 00 00       	jmp    8011af <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f82:	83 c0 04             	add    $0x4,%eax
  800f85:	89 45 14             	mov    %eax,0x14(%ebp)
  800f88:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8b:	83 e8 04             	sub    $0x4,%eax
  800f8e:	8b 30                	mov    (%eax),%esi
  800f90:	85 f6                	test   %esi,%esi
  800f92:	75 05                	jne    800f99 <vprintfmt+0x1a6>
				p = "(null)";
  800f94:	be b1 2d 80 00       	mov    $0x802db1,%esi
			if (width > 0 && padc != '-')
  800f99:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f9d:	7e 6d                	jle    80100c <vprintfmt+0x219>
  800f9f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fa3:	74 67                	je     80100c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800fa5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fa8:	83 ec 08             	sub    $0x8,%esp
  800fab:	50                   	push   %eax
  800fac:	56                   	push   %esi
  800fad:	e8 12 05 00 00       	call   8014c4 <strnlen>
  800fb2:	83 c4 10             	add    $0x10,%esp
  800fb5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800fb8:	eb 16                	jmp    800fd0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800fba:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800fbe:	83 ec 08             	sub    $0x8,%esp
  800fc1:	ff 75 0c             	pushl  0xc(%ebp)
  800fc4:	50                   	push   %eax
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc8:	ff d0                	call   *%eax
  800fca:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800fcd:	ff 4d e4             	decl   -0x1c(%ebp)
  800fd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fd4:	7f e4                	jg     800fba <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fd6:	eb 34                	jmp    80100c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800fd8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800fdc:	74 1c                	je     800ffa <vprintfmt+0x207>
  800fde:	83 fb 1f             	cmp    $0x1f,%ebx
  800fe1:	7e 05                	jle    800fe8 <vprintfmt+0x1f5>
  800fe3:	83 fb 7e             	cmp    $0x7e,%ebx
  800fe6:	7e 12                	jle    800ffa <vprintfmt+0x207>
					putch('?', putdat);
  800fe8:	83 ec 08             	sub    $0x8,%esp
  800feb:	ff 75 0c             	pushl  0xc(%ebp)
  800fee:	6a 3f                	push   $0x3f
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	ff d0                	call   *%eax
  800ff5:	83 c4 10             	add    $0x10,%esp
  800ff8:	eb 0f                	jmp    801009 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ffa:	83 ec 08             	sub    $0x8,%esp
  800ffd:	ff 75 0c             	pushl  0xc(%ebp)
  801000:	53                   	push   %ebx
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	ff d0                	call   *%eax
  801006:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801009:	ff 4d e4             	decl   -0x1c(%ebp)
  80100c:	89 f0                	mov    %esi,%eax
  80100e:	8d 70 01             	lea    0x1(%eax),%esi
  801011:	8a 00                	mov    (%eax),%al
  801013:	0f be d8             	movsbl %al,%ebx
  801016:	85 db                	test   %ebx,%ebx
  801018:	74 24                	je     80103e <vprintfmt+0x24b>
  80101a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80101e:	78 b8                	js     800fd8 <vprintfmt+0x1e5>
  801020:	ff 4d e0             	decl   -0x20(%ebp)
  801023:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801027:	79 af                	jns    800fd8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801029:	eb 13                	jmp    80103e <vprintfmt+0x24b>
				putch(' ', putdat);
  80102b:	83 ec 08             	sub    $0x8,%esp
  80102e:	ff 75 0c             	pushl  0xc(%ebp)
  801031:	6a 20                	push   $0x20
  801033:	8b 45 08             	mov    0x8(%ebp),%eax
  801036:	ff d0                	call   *%eax
  801038:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80103b:	ff 4d e4             	decl   -0x1c(%ebp)
  80103e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801042:	7f e7                	jg     80102b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801044:	e9 66 01 00 00       	jmp    8011af <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 e8             	pushl  -0x18(%ebp)
  80104f:	8d 45 14             	lea    0x14(%ebp),%eax
  801052:	50                   	push   %eax
  801053:	e8 3c fd ff ff       	call   800d94 <getint>
  801058:	83 c4 10             	add    $0x10,%esp
  80105b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80105e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801061:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801064:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801067:	85 d2                	test   %edx,%edx
  801069:	79 23                	jns    80108e <vprintfmt+0x29b>
				putch('-', putdat);
  80106b:	83 ec 08             	sub    $0x8,%esp
  80106e:	ff 75 0c             	pushl  0xc(%ebp)
  801071:	6a 2d                	push   $0x2d
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	ff d0                	call   *%eax
  801078:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80107b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80107e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801081:	f7 d8                	neg    %eax
  801083:	83 d2 00             	adc    $0x0,%edx
  801086:	f7 da                	neg    %edx
  801088:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80108b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80108e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801095:	e9 bc 00 00 00       	jmp    801156 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80109a:	83 ec 08             	sub    $0x8,%esp
  80109d:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a0:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a3:	50                   	push   %eax
  8010a4:	e8 84 fc ff ff       	call   800d2d <getuint>
  8010a9:	83 c4 10             	add    $0x10,%esp
  8010ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010af:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010b2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010b9:	e9 98 00 00 00       	jmp    801156 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8010be:	83 ec 08             	sub    $0x8,%esp
  8010c1:	ff 75 0c             	pushl  0xc(%ebp)
  8010c4:	6a 58                	push   $0x58
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	ff d0                	call   *%eax
  8010cb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010ce:	83 ec 08             	sub    $0x8,%esp
  8010d1:	ff 75 0c             	pushl  0xc(%ebp)
  8010d4:	6a 58                	push   $0x58
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	ff d0                	call   *%eax
  8010db:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010de:	83 ec 08             	sub    $0x8,%esp
  8010e1:	ff 75 0c             	pushl  0xc(%ebp)
  8010e4:	6a 58                	push   $0x58
  8010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e9:	ff d0                	call   *%eax
  8010eb:	83 c4 10             	add    $0x10,%esp
			break;
  8010ee:	e9 bc 00 00 00       	jmp    8011af <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8010f3:	83 ec 08             	sub    $0x8,%esp
  8010f6:	ff 75 0c             	pushl  0xc(%ebp)
  8010f9:	6a 30                	push   $0x30
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	ff d0                	call   *%eax
  801100:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801103:	83 ec 08             	sub    $0x8,%esp
  801106:	ff 75 0c             	pushl  0xc(%ebp)
  801109:	6a 78                	push   $0x78
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	ff d0                	call   *%eax
  801110:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801113:	8b 45 14             	mov    0x14(%ebp),%eax
  801116:	83 c0 04             	add    $0x4,%eax
  801119:	89 45 14             	mov    %eax,0x14(%ebp)
  80111c:	8b 45 14             	mov    0x14(%ebp),%eax
  80111f:	83 e8 04             	sub    $0x4,%eax
  801122:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801124:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801127:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80112e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801135:	eb 1f                	jmp    801156 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801137:	83 ec 08             	sub    $0x8,%esp
  80113a:	ff 75 e8             	pushl  -0x18(%ebp)
  80113d:	8d 45 14             	lea    0x14(%ebp),%eax
  801140:	50                   	push   %eax
  801141:	e8 e7 fb ff ff       	call   800d2d <getuint>
  801146:	83 c4 10             	add    $0x10,%esp
  801149:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80114c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80114f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801156:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80115a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80115d:	83 ec 04             	sub    $0x4,%esp
  801160:	52                   	push   %edx
  801161:	ff 75 e4             	pushl  -0x1c(%ebp)
  801164:	50                   	push   %eax
  801165:	ff 75 f4             	pushl  -0xc(%ebp)
  801168:	ff 75 f0             	pushl  -0x10(%ebp)
  80116b:	ff 75 0c             	pushl  0xc(%ebp)
  80116e:	ff 75 08             	pushl  0x8(%ebp)
  801171:	e8 00 fb ff ff       	call   800c76 <printnum>
  801176:	83 c4 20             	add    $0x20,%esp
			break;
  801179:	eb 34                	jmp    8011af <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80117b:	83 ec 08             	sub    $0x8,%esp
  80117e:	ff 75 0c             	pushl  0xc(%ebp)
  801181:	53                   	push   %ebx
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	ff d0                	call   *%eax
  801187:	83 c4 10             	add    $0x10,%esp
			break;
  80118a:	eb 23                	jmp    8011af <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80118c:	83 ec 08             	sub    $0x8,%esp
  80118f:	ff 75 0c             	pushl  0xc(%ebp)
  801192:	6a 25                	push   $0x25
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	ff d0                	call   *%eax
  801199:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80119c:	ff 4d 10             	decl   0x10(%ebp)
  80119f:	eb 03                	jmp    8011a4 <vprintfmt+0x3b1>
  8011a1:	ff 4d 10             	decl   0x10(%ebp)
  8011a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a7:	48                   	dec    %eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	3c 25                	cmp    $0x25,%al
  8011ac:	75 f3                	jne    8011a1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011ae:	90                   	nop
		}
	}
  8011af:	e9 47 fc ff ff       	jmp    800dfb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011b4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011b8:	5b                   	pop    %ebx
  8011b9:	5e                   	pop    %esi
  8011ba:	5d                   	pop    %ebp
  8011bb:	c3                   	ret    

008011bc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
  8011bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011c2:	8d 45 10             	lea    0x10(%ebp),%eax
  8011c5:	83 c0 04             	add    $0x4,%eax
  8011c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d1:	50                   	push   %eax
  8011d2:	ff 75 0c             	pushl  0xc(%ebp)
  8011d5:	ff 75 08             	pushl  0x8(%ebp)
  8011d8:	e8 16 fc ff ff       	call   800df3 <vprintfmt>
  8011dd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011e0:	90                   	nop
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8011e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e9:	8b 40 08             	mov    0x8(%eax),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8011f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f8:	8b 10                	mov    (%eax),%edx
  8011fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fd:	8b 40 04             	mov    0x4(%eax),%eax
  801200:	39 c2                	cmp    %eax,%edx
  801202:	73 12                	jae    801216 <sprintputch+0x33>
		*b->buf++ = ch;
  801204:	8b 45 0c             	mov    0xc(%ebp),%eax
  801207:	8b 00                	mov    (%eax),%eax
  801209:	8d 48 01             	lea    0x1(%eax),%ecx
  80120c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80120f:	89 0a                	mov    %ecx,(%edx)
  801211:	8b 55 08             	mov    0x8(%ebp),%edx
  801214:	88 10                	mov    %dl,(%eax)
}
  801216:	90                   	nop
  801217:	5d                   	pop    %ebp
  801218:	c3                   	ret    

00801219 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
  80121c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	8d 50 ff             	lea    -0x1(%eax),%edx
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	01 d0                	add    %edx,%eax
  801230:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801233:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80123a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80123e:	74 06                	je     801246 <vsnprintf+0x2d>
  801240:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801244:	7f 07                	jg     80124d <vsnprintf+0x34>
		return -E_INVAL;
  801246:	b8 03 00 00 00       	mov    $0x3,%eax
  80124b:	eb 20                	jmp    80126d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80124d:	ff 75 14             	pushl  0x14(%ebp)
  801250:	ff 75 10             	pushl  0x10(%ebp)
  801253:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801256:	50                   	push   %eax
  801257:	68 e3 11 80 00       	push   $0x8011e3
  80125c:	e8 92 fb ff ff       	call   800df3 <vprintfmt>
  801261:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801264:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801267:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80126a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
  801272:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801275:	8d 45 10             	lea    0x10(%ebp),%eax
  801278:	83 c0 04             	add    $0x4,%eax
  80127b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80127e:	8b 45 10             	mov    0x10(%ebp),%eax
  801281:	ff 75 f4             	pushl  -0xc(%ebp)
  801284:	50                   	push   %eax
  801285:	ff 75 0c             	pushl  0xc(%ebp)
  801288:	ff 75 08             	pushl  0x8(%ebp)
  80128b:	e8 89 ff ff ff       	call   801219 <vsnprintf>
  801290:	83 c4 10             	add    $0x10,%esp
  801293:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801296:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
  80129e:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8012a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a5:	74 13                	je     8012ba <readline+0x1f>
		cprintf("%s", prompt);
  8012a7:	83 ec 08             	sub    $0x8,%esp
  8012aa:	ff 75 08             	pushl  0x8(%ebp)
  8012ad:	68 10 2f 80 00       	push   $0x802f10
  8012b2:	e8 62 f9 ff ff       	call   800c19 <cprintf>
  8012b7:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012c1:	83 ec 0c             	sub    $0xc,%esp
  8012c4:	6a 00                	push   $0x0
  8012c6:	e8 81 f5 ff ff       	call   80084c <iscons>
  8012cb:	83 c4 10             	add    $0x10,%esp
  8012ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012d1:	e8 28 f5 ff ff       	call   8007fe <getchar>
  8012d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012dd:	79 22                	jns    801301 <readline+0x66>
			if (c != -E_EOF)
  8012df:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012e3:	0f 84 ad 00 00 00    	je     801396 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8012e9:	83 ec 08             	sub    $0x8,%esp
  8012ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ef:	68 13 2f 80 00       	push   $0x802f13
  8012f4:	e8 20 f9 ff ff       	call   800c19 <cprintf>
  8012f9:	83 c4 10             	add    $0x10,%esp
			return;
  8012fc:	e9 95 00 00 00       	jmp    801396 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801301:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801305:	7e 34                	jle    80133b <readline+0xa0>
  801307:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80130e:	7f 2b                	jg     80133b <readline+0xa0>
			if (echoing)
  801310:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801314:	74 0e                	je     801324 <readline+0x89>
				cputchar(c);
  801316:	83 ec 0c             	sub    $0xc,%esp
  801319:	ff 75 ec             	pushl  -0x14(%ebp)
  80131c:	e8 95 f4 ff ff       	call   8007b6 <cputchar>
  801321:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801324:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801327:	8d 50 01             	lea    0x1(%eax),%edx
  80132a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80132d:	89 c2                	mov    %eax,%edx
  80132f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801332:	01 d0                	add    %edx,%eax
  801334:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801337:	88 10                	mov    %dl,(%eax)
  801339:	eb 56                	jmp    801391 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80133b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80133f:	75 1f                	jne    801360 <readline+0xc5>
  801341:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801345:	7e 19                	jle    801360 <readline+0xc5>
			if (echoing)
  801347:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80134b:	74 0e                	je     80135b <readline+0xc0>
				cputchar(c);
  80134d:	83 ec 0c             	sub    $0xc,%esp
  801350:	ff 75 ec             	pushl  -0x14(%ebp)
  801353:	e8 5e f4 ff ff       	call   8007b6 <cputchar>
  801358:	83 c4 10             	add    $0x10,%esp

			i--;
  80135b:	ff 4d f4             	decl   -0xc(%ebp)
  80135e:	eb 31                	jmp    801391 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801360:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801364:	74 0a                	je     801370 <readline+0xd5>
  801366:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80136a:	0f 85 61 ff ff ff    	jne    8012d1 <readline+0x36>
			if (echoing)
  801370:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801374:	74 0e                	je     801384 <readline+0xe9>
				cputchar(c);
  801376:	83 ec 0c             	sub    $0xc,%esp
  801379:	ff 75 ec             	pushl  -0x14(%ebp)
  80137c:	e8 35 f4 ff ff       	call   8007b6 <cputchar>
  801381:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801384:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	01 d0                	add    %edx,%eax
  80138c:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80138f:	eb 06                	jmp    801397 <readline+0xfc>
		}
	}
  801391:	e9 3b ff ff ff       	jmp    8012d1 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801396:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801397:	c9                   	leave  
  801398:	c3                   	ret    

00801399 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801399:	55                   	push   %ebp
  80139a:	89 e5                	mov    %esp,%ebp
  80139c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80139f:	e8 7d 0d 00 00       	call   802121 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8013a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013a8:	74 13                	je     8013bd <atomic_readline+0x24>
		cprintf("%s", prompt);
  8013aa:	83 ec 08             	sub    $0x8,%esp
  8013ad:	ff 75 08             	pushl  0x8(%ebp)
  8013b0:	68 10 2f 80 00       	push   $0x802f10
  8013b5:	e8 5f f8 ff ff       	call   800c19 <cprintf>
  8013ba:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8013bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013c4:	83 ec 0c             	sub    $0xc,%esp
  8013c7:	6a 00                	push   $0x0
  8013c9:	e8 7e f4 ff ff       	call   80084c <iscons>
  8013ce:	83 c4 10             	add    $0x10,%esp
  8013d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013d4:	e8 25 f4 ff ff       	call   8007fe <getchar>
  8013d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013e0:	79 23                	jns    801405 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8013e2:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8013e6:	74 13                	je     8013fb <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8013e8:	83 ec 08             	sub    $0x8,%esp
  8013eb:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ee:	68 13 2f 80 00       	push   $0x802f13
  8013f3:	e8 21 f8 ff ff       	call   800c19 <cprintf>
  8013f8:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8013fb:	e8 3b 0d 00 00       	call   80213b <sys_enable_interrupt>
			return;
  801400:	e9 9a 00 00 00       	jmp    80149f <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801405:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801409:	7e 34                	jle    80143f <atomic_readline+0xa6>
  80140b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801412:	7f 2b                	jg     80143f <atomic_readline+0xa6>
			if (echoing)
  801414:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801418:	74 0e                	je     801428 <atomic_readline+0x8f>
				cputchar(c);
  80141a:	83 ec 0c             	sub    $0xc,%esp
  80141d:	ff 75 ec             	pushl  -0x14(%ebp)
  801420:	e8 91 f3 ff ff       	call   8007b6 <cputchar>
  801425:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801428:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80142b:	8d 50 01             	lea    0x1(%eax),%edx
  80142e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801431:	89 c2                	mov    %eax,%edx
  801433:	8b 45 0c             	mov    0xc(%ebp),%eax
  801436:	01 d0                	add    %edx,%eax
  801438:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80143b:	88 10                	mov    %dl,(%eax)
  80143d:	eb 5b                	jmp    80149a <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80143f:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801443:	75 1f                	jne    801464 <atomic_readline+0xcb>
  801445:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801449:	7e 19                	jle    801464 <atomic_readline+0xcb>
			if (echoing)
  80144b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80144f:	74 0e                	je     80145f <atomic_readline+0xc6>
				cputchar(c);
  801451:	83 ec 0c             	sub    $0xc,%esp
  801454:	ff 75 ec             	pushl  -0x14(%ebp)
  801457:	e8 5a f3 ff ff       	call   8007b6 <cputchar>
  80145c:	83 c4 10             	add    $0x10,%esp
			i--;
  80145f:	ff 4d f4             	decl   -0xc(%ebp)
  801462:	eb 36                	jmp    80149a <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801464:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801468:	74 0a                	je     801474 <atomic_readline+0xdb>
  80146a:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80146e:	0f 85 60 ff ff ff    	jne    8013d4 <atomic_readline+0x3b>
			if (echoing)
  801474:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801478:	74 0e                	je     801488 <atomic_readline+0xef>
				cputchar(c);
  80147a:	83 ec 0c             	sub    $0xc,%esp
  80147d:	ff 75 ec             	pushl  -0x14(%ebp)
  801480:	e8 31 f3 ff ff       	call   8007b6 <cputchar>
  801485:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801488:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80148b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148e:	01 d0                	add    %edx,%eax
  801490:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801493:	e8 a3 0c 00 00       	call   80213b <sys_enable_interrupt>
			return;
  801498:	eb 05                	jmp    80149f <atomic_readline+0x106>
		}
	}
  80149a:	e9 35 ff ff ff       	jmp    8013d4 <atomic_readline+0x3b>
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
  8014a4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8014a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ae:	eb 06                	jmp    8014b6 <strlen+0x15>
		n++;
  8014b0:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8014b3:	ff 45 08             	incl   0x8(%ebp)
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	84 c0                	test   %al,%al
  8014bd:	75 f1                	jne    8014b0 <strlen+0xf>
		n++;
	return n;
  8014bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
  8014c7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014d1:	eb 09                	jmp    8014dc <strnlen+0x18>
		n++;
  8014d3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014d6:	ff 45 08             	incl   0x8(%ebp)
  8014d9:	ff 4d 0c             	decl   0xc(%ebp)
  8014dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014e0:	74 09                	je     8014eb <strnlen+0x27>
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	84 c0                	test   %al,%al
  8014e9:	75 e8                	jne    8014d3 <strnlen+0xf>
		n++;
	return n;
  8014eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
  8014f3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8014fc:	90                   	nop
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	8d 50 01             	lea    0x1(%eax),%edx
  801503:	89 55 08             	mov    %edx,0x8(%ebp)
  801506:	8b 55 0c             	mov    0xc(%ebp),%edx
  801509:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80150f:	8a 12                	mov    (%edx),%dl
  801511:	88 10                	mov    %dl,(%eax)
  801513:	8a 00                	mov    (%eax),%al
  801515:	84 c0                	test   %al,%al
  801517:	75 e4                	jne    8014fd <strcpy+0xd>
		/* do nothing */;
	return ret;
  801519:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80151c:	c9                   	leave  
  80151d:	c3                   	ret    

0080151e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80151e:	55                   	push   %ebp
  80151f:	89 e5                	mov    %esp,%ebp
  801521:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80152a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801531:	eb 1f                	jmp    801552 <strncpy+0x34>
		*dst++ = *src;
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	8d 50 01             	lea    0x1(%eax),%edx
  801539:	89 55 08             	mov    %edx,0x8(%ebp)
  80153c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153f:	8a 12                	mov    (%edx),%dl
  801541:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	84 c0                	test   %al,%al
  80154a:	74 03                	je     80154f <strncpy+0x31>
			src++;
  80154c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80154f:	ff 45 fc             	incl   -0x4(%ebp)
  801552:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801555:	3b 45 10             	cmp    0x10(%ebp),%eax
  801558:	72 d9                	jb     801533 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80155a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
  801562:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80156b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80156f:	74 30                	je     8015a1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801571:	eb 16                	jmp    801589 <strlcpy+0x2a>
			*dst++ = *src++;
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	8d 50 01             	lea    0x1(%eax),%edx
  801579:	89 55 08             	mov    %edx,0x8(%ebp)
  80157c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801582:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801585:	8a 12                	mov    (%edx),%dl
  801587:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801589:	ff 4d 10             	decl   0x10(%ebp)
  80158c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801590:	74 09                	je     80159b <strlcpy+0x3c>
  801592:	8b 45 0c             	mov    0xc(%ebp),%eax
  801595:	8a 00                	mov    (%eax),%al
  801597:	84 c0                	test   %al,%al
  801599:	75 d8                	jne    801573 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80159b:	8b 45 08             	mov    0x8(%ebp),%eax
  80159e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8015a1:	8b 55 08             	mov    0x8(%ebp),%edx
  8015a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a7:	29 c2                	sub    %eax,%edx
  8015a9:	89 d0                	mov    %edx,%eax
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8015b0:	eb 06                	jmp    8015b8 <strcmp+0xb>
		p++, q++;
  8015b2:	ff 45 08             	incl   0x8(%ebp)
  8015b5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	84 c0                	test   %al,%al
  8015bf:	74 0e                	je     8015cf <strcmp+0x22>
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	8a 10                	mov    (%eax),%dl
  8015c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c9:	8a 00                	mov    (%eax),%al
  8015cb:	38 c2                	cmp    %al,%dl
  8015cd:	74 e3                	je     8015b2 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	8a 00                	mov    (%eax),%al
  8015d4:	0f b6 d0             	movzbl %al,%edx
  8015d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015da:	8a 00                	mov    (%eax),%al
  8015dc:	0f b6 c0             	movzbl %al,%eax
  8015df:	29 c2                	sub    %eax,%edx
  8015e1:	89 d0                	mov    %edx,%eax
}
  8015e3:	5d                   	pop    %ebp
  8015e4:	c3                   	ret    

008015e5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8015e8:	eb 09                	jmp    8015f3 <strncmp+0xe>
		n--, p++, q++;
  8015ea:	ff 4d 10             	decl   0x10(%ebp)
  8015ed:	ff 45 08             	incl   0x8(%ebp)
  8015f0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8015f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f7:	74 17                	je     801610 <strncmp+0x2b>
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	8a 00                	mov    (%eax),%al
  8015fe:	84 c0                	test   %al,%al
  801600:	74 0e                	je     801610 <strncmp+0x2b>
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	8a 10                	mov    (%eax),%dl
  801607:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160a:	8a 00                	mov    (%eax),%al
  80160c:	38 c2                	cmp    %al,%dl
  80160e:	74 da                	je     8015ea <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801610:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801614:	75 07                	jne    80161d <strncmp+0x38>
		return 0;
  801616:	b8 00 00 00 00       	mov    $0x0,%eax
  80161b:	eb 14                	jmp    801631 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	8a 00                	mov    (%eax),%al
  801622:	0f b6 d0             	movzbl %al,%edx
  801625:	8b 45 0c             	mov    0xc(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	0f b6 c0             	movzbl %al,%eax
  80162d:	29 c2                	sub    %eax,%edx
  80162f:	89 d0                	mov    %edx,%eax
}
  801631:	5d                   	pop    %ebp
  801632:	c3                   	ret    

00801633 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801633:	55                   	push   %ebp
  801634:	89 e5                	mov    %esp,%ebp
  801636:	83 ec 04             	sub    $0x4,%esp
  801639:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80163f:	eb 12                	jmp    801653 <strchr+0x20>
		if (*s == c)
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8a 00                	mov    (%eax),%al
  801646:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801649:	75 05                	jne    801650 <strchr+0x1d>
			return (char *) s;
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	eb 11                	jmp    801661 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801650:	ff 45 08             	incl   0x8(%ebp)
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	84 c0                	test   %al,%al
  80165a:	75 e5                	jne    801641 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80165c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 04             	sub    $0x4,%esp
  801669:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80166f:	eb 0d                	jmp    80167e <strfind+0x1b>
		if (*s == c)
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801679:	74 0e                	je     801689 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80167b:	ff 45 08             	incl   0x8(%ebp)
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	84 c0                	test   %al,%al
  801685:	75 ea                	jne    801671 <strfind+0xe>
  801687:	eb 01                	jmp    80168a <strfind+0x27>
		if (*s == c)
			break;
  801689:	90                   	nop
	return (char *) s;
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
  801692:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80169b:	8b 45 10             	mov    0x10(%ebp),%eax
  80169e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8016a1:	eb 0e                	jmp    8016b1 <memset+0x22>
		*p++ = c;
  8016a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a6:	8d 50 01             	lea    0x1(%eax),%edx
  8016a9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016af:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8016b1:	ff 4d f8             	decl   -0x8(%ebp)
  8016b4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8016b8:	79 e9                	jns    8016a3 <memset+0x14>
		*p++ = c;

	return v;
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
  8016c2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016d1:	eb 16                	jmp    8016e9 <memcpy+0x2a>
		*d++ = *s++;
  8016d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d6:	8d 50 01             	lea    0x1(%eax),%edx
  8016d9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016df:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016e2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016e5:	8a 12                	mov    (%edx),%dl
  8016e7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8016e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8016f2:	85 c0                	test   %eax,%eax
  8016f4:	75 dd                	jne    8016d3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
  8016fe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801701:	8b 45 0c             	mov    0xc(%ebp),%eax
  801704:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80170d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801710:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801713:	73 50                	jae    801765 <memmove+0x6a>
  801715:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801718:	8b 45 10             	mov    0x10(%ebp),%eax
  80171b:	01 d0                	add    %edx,%eax
  80171d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801720:	76 43                	jbe    801765 <memmove+0x6a>
		s += n;
  801722:	8b 45 10             	mov    0x10(%ebp),%eax
  801725:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801728:	8b 45 10             	mov    0x10(%ebp),%eax
  80172b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80172e:	eb 10                	jmp    801740 <memmove+0x45>
			*--d = *--s;
  801730:	ff 4d f8             	decl   -0x8(%ebp)
  801733:	ff 4d fc             	decl   -0x4(%ebp)
  801736:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801739:	8a 10                	mov    (%eax),%dl
  80173b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801740:	8b 45 10             	mov    0x10(%ebp),%eax
  801743:	8d 50 ff             	lea    -0x1(%eax),%edx
  801746:	89 55 10             	mov    %edx,0x10(%ebp)
  801749:	85 c0                	test   %eax,%eax
  80174b:	75 e3                	jne    801730 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80174d:	eb 23                	jmp    801772 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80174f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801752:	8d 50 01             	lea    0x1(%eax),%edx
  801755:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801758:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80175b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80175e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801761:	8a 12                	mov    (%edx),%dl
  801763:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801765:	8b 45 10             	mov    0x10(%ebp),%eax
  801768:	8d 50 ff             	lea    -0x1(%eax),%edx
  80176b:	89 55 10             	mov    %edx,0x10(%ebp)
  80176e:	85 c0                	test   %eax,%eax
  801770:	75 dd                	jne    80174f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
  80177a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80177d:	8b 45 08             	mov    0x8(%ebp),%eax
  801780:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801783:	8b 45 0c             	mov    0xc(%ebp),%eax
  801786:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801789:	eb 2a                	jmp    8017b5 <memcmp+0x3e>
		if (*s1 != *s2)
  80178b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80178e:	8a 10                	mov    (%eax),%dl
  801790:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801793:	8a 00                	mov    (%eax),%al
  801795:	38 c2                	cmp    %al,%dl
  801797:	74 16                	je     8017af <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801799:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179c:	8a 00                	mov    (%eax),%al
  80179e:	0f b6 d0             	movzbl %al,%edx
  8017a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a4:	8a 00                	mov    (%eax),%al
  8017a6:	0f b6 c0             	movzbl %al,%eax
  8017a9:	29 c2                	sub    %eax,%edx
  8017ab:	89 d0                	mov    %edx,%eax
  8017ad:	eb 18                	jmp    8017c7 <memcmp+0x50>
		s1++, s2++;
  8017af:	ff 45 fc             	incl   -0x4(%ebp)
  8017b2:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8017be:	85 c0                	test   %eax,%eax
  8017c0:	75 c9                	jne    80178b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c7:	c9                   	leave  
  8017c8:	c3                   	ret    

008017c9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017c9:	55                   	push   %ebp
  8017ca:	89 e5                	mov    %esp,%ebp
  8017cc:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8017d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d5:	01 d0                	add    %edx,%eax
  8017d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017da:	eb 15                	jmp    8017f1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	8a 00                	mov    (%eax),%al
  8017e1:	0f b6 d0             	movzbl %al,%edx
  8017e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e7:	0f b6 c0             	movzbl %al,%eax
  8017ea:	39 c2                	cmp    %eax,%edx
  8017ec:	74 0d                	je     8017fb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8017ee:	ff 45 08             	incl   0x8(%ebp)
  8017f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8017f7:	72 e3                	jb     8017dc <memfind+0x13>
  8017f9:	eb 01                	jmp    8017fc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8017fb:	90                   	nop
	return (void *) s;
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
  801804:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801807:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80180e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801815:	eb 03                	jmp    80181a <strtol+0x19>
		s++;
  801817:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	3c 20                	cmp    $0x20,%al
  801821:	74 f4                	je     801817 <strtol+0x16>
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	8a 00                	mov    (%eax),%al
  801828:	3c 09                	cmp    $0x9,%al
  80182a:	74 eb                	je     801817 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 2b                	cmp    $0x2b,%al
  801833:	75 05                	jne    80183a <strtol+0x39>
		s++;
  801835:	ff 45 08             	incl   0x8(%ebp)
  801838:	eb 13                	jmp    80184d <strtol+0x4c>
	else if (*s == '-')
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	8a 00                	mov    (%eax),%al
  80183f:	3c 2d                	cmp    $0x2d,%al
  801841:	75 0a                	jne    80184d <strtol+0x4c>
		s++, neg = 1;
  801843:	ff 45 08             	incl   0x8(%ebp)
  801846:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80184d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801851:	74 06                	je     801859 <strtol+0x58>
  801853:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801857:	75 20                	jne    801879 <strtol+0x78>
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	8a 00                	mov    (%eax),%al
  80185e:	3c 30                	cmp    $0x30,%al
  801860:	75 17                	jne    801879 <strtol+0x78>
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	40                   	inc    %eax
  801866:	8a 00                	mov    (%eax),%al
  801868:	3c 78                	cmp    $0x78,%al
  80186a:	75 0d                	jne    801879 <strtol+0x78>
		s += 2, base = 16;
  80186c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801870:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801877:	eb 28                	jmp    8018a1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801879:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80187d:	75 15                	jne    801894 <strtol+0x93>
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	8a 00                	mov    (%eax),%al
  801884:	3c 30                	cmp    $0x30,%al
  801886:	75 0c                	jne    801894 <strtol+0x93>
		s++, base = 8;
  801888:	ff 45 08             	incl   0x8(%ebp)
  80188b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801892:	eb 0d                	jmp    8018a1 <strtol+0xa0>
	else if (base == 0)
  801894:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801898:	75 07                	jne    8018a1 <strtol+0xa0>
		base = 10;
  80189a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a4:	8a 00                	mov    (%eax),%al
  8018a6:	3c 2f                	cmp    $0x2f,%al
  8018a8:	7e 19                	jle    8018c3 <strtol+0xc2>
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	8a 00                	mov    (%eax),%al
  8018af:	3c 39                	cmp    $0x39,%al
  8018b1:	7f 10                	jg     8018c3 <strtol+0xc2>
			dig = *s - '0';
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	8a 00                	mov    (%eax),%al
  8018b8:	0f be c0             	movsbl %al,%eax
  8018bb:	83 e8 30             	sub    $0x30,%eax
  8018be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018c1:	eb 42                	jmp    801905 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c6:	8a 00                	mov    (%eax),%al
  8018c8:	3c 60                	cmp    $0x60,%al
  8018ca:	7e 19                	jle    8018e5 <strtol+0xe4>
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	8a 00                	mov    (%eax),%al
  8018d1:	3c 7a                	cmp    $0x7a,%al
  8018d3:	7f 10                	jg     8018e5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	8a 00                	mov    (%eax),%al
  8018da:	0f be c0             	movsbl %al,%eax
  8018dd:	83 e8 57             	sub    $0x57,%eax
  8018e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018e3:	eb 20                	jmp    801905 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	8a 00                	mov    (%eax),%al
  8018ea:	3c 40                	cmp    $0x40,%al
  8018ec:	7e 39                	jle    801927 <strtol+0x126>
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	8a 00                	mov    (%eax),%al
  8018f3:	3c 5a                	cmp    $0x5a,%al
  8018f5:	7f 30                	jg     801927 <strtol+0x126>
			dig = *s - 'A' + 10;
  8018f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fa:	8a 00                	mov    (%eax),%al
  8018fc:	0f be c0             	movsbl %al,%eax
  8018ff:	83 e8 37             	sub    $0x37,%eax
  801902:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801905:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801908:	3b 45 10             	cmp    0x10(%ebp),%eax
  80190b:	7d 19                	jge    801926 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80190d:	ff 45 08             	incl   0x8(%ebp)
  801910:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801913:	0f af 45 10          	imul   0x10(%ebp),%eax
  801917:	89 c2                	mov    %eax,%edx
  801919:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80191c:	01 d0                	add    %edx,%eax
  80191e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801921:	e9 7b ff ff ff       	jmp    8018a1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801926:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801927:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80192b:	74 08                	je     801935 <strtol+0x134>
		*endptr = (char *) s;
  80192d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801930:	8b 55 08             	mov    0x8(%ebp),%edx
  801933:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801935:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801939:	74 07                	je     801942 <strtol+0x141>
  80193b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80193e:	f7 d8                	neg    %eax
  801940:	eb 03                	jmp    801945 <strtol+0x144>
  801942:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801945:	c9                   	leave  
  801946:	c3                   	ret    

00801947 <ltostr>:

void
ltostr(long value, char *str)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
  80194a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80194d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801954:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80195b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80195f:	79 13                	jns    801974 <ltostr+0x2d>
	{
		neg = 1;
  801961:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801968:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80196e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801971:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80197c:	99                   	cltd   
  80197d:	f7 f9                	idiv   %ecx
  80197f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801982:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801985:	8d 50 01             	lea    0x1(%eax),%edx
  801988:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80198b:	89 c2                	mov    %eax,%edx
  80198d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801990:	01 d0                	add    %edx,%eax
  801992:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801995:	83 c2 30             	add    $0x30,%edx
  801998:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80199a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80199d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019a2:	f7 e9                	imul   %ecx
  8019a4:	c1 fa 02             	sar    $0x2,%edx
  8019a7:	89 c8                	mov    %ecx,%eax
  8019a9:	c1 f8 1f             	sar    $0x1f,%eax
  8019ac:	29 c2                	sub    %eax,%edx
  8019ae:	89 d0                	mov    %edx,%eax
  8019b0:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8019b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019b6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019bb:	f7 e9                	imul   %ecx
  8019bd:	c1 fa 02             	sar    $0x2,%edx
  8019c0:	89 c8                	mov    %ecx,%eax
  8019c2:	c1 f8 1f             	sar    $0x1f,%eax
  8019c5:	29 c2                	sub    %eax,%edx
  8019c7:	89 d0                	mov    %edx,%eax
  8019c9:	c1 e0 02             	shl    $0x2,%eax
  8019cc:	01 d0                	add    %edx,%eax
  8019ce:	01 c0                	add    %eax,%eax
  8019d0:	29 c1                	sub    %eax,%ecx
  8019d2:	89 ca                	mov    %ecx,%edx
  8019d4:	85 d2                	test   %edx,%edx
  8019d6:	75 9c                	jne    801974 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019e2:	48                   	dec    %eax
  8019e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019ea:	74 3d                	je     801a29 <ltostr+0xe2>
		start = 1 ;
  8019ec:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8019f3:	eb 34                	jmp    801a29 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8019f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fb:	01 d0                	add    %edx,%eax
  8019fd:	8a 00                	mov    (%eax),%al
  8019ff:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a05:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a08:	01 c2                	add    %eax,%edx
  801a0a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a10:	01 c8                	add    %ecx,%eax
  801a12:	8a 00                	mov    (%eax),%al
  801a14:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a16:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a19:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1c:	01 c2                	add    %eax,%edx
  801a1e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a21:	88 02                	mov    %al,(%edx)
		start++ ;
  801a23:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a26:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a2c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2f:	7c c4                	jl     8019f5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a31:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a37:	01 d0                	add    %edx,%eax
  801a39:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a3c:	90                   	nop
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
  801a42:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a45:	ff 75 08             	pushl  0x8(%ebp)
  801a48:	e8 54 fa ff ff       	call   8014a1 <strlen>
  801a4d:	83 c4 04             	add    $0x4,%esp
  801a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a53:	ff 75 0c             	pushl  0xc(%ebp)
  801a56:	e8 46 fa ff ff       	call   8014a1 <strlen>
  801a5b:	83 c4 04             	add    $0x4,%esp
  801a5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a61:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a6f:	eb 17                	jmp    801a88 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a71:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a74:	8b 45 10             	mov    0x10(%ebp),%eax
  801a77:	01 c2                	add    %eax,%edx
  801a79:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7f:	01 c8                	add    %ecx,%eax
  801a81:	8a 00                	mov    (%eax),%al
  801a83:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a85:	ff 45 fc             	incl   -0x4(%ebp)
  801a88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a8b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a8e:	7c e1                	jl     801a71 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a90:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a97:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a9e:	eb 1f                	jmp    801abf <strcconcat+0x80>
		final[s++] = str2[i] ;
  801aa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa3:	8d 50 01             	lea    0x1(%eax),%edx
  801aa6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801aa9:	89 c2                	mov    %eax,%edx
  801aab:	8b 45 10             	mov    0x10(%ebp),%eax
  801aae:	01 c2                	add    %eax,%edx
  801ab0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab6:	01 c8                	add    %ecx,%eax
  801ab8:	8a 00                	mov    (%eax),%al
  801aba:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801abc:	ff 45 f8             	incl   -0x8(%ebp)
  801abf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ac2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ac5:	7c d9                	jl     801aa0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ac7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aca:	8b 45 10             	mov    0x10(%ebp),%eax
  801acd:	01 d0                	add    %edx,%eax
  801acf:	c6 00 00             	movb   $0x0,(%eax)
}
  801ad2:	90                   	nop
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ad8:	8b 45 14             	mov    0x14(%ebp),%eax
  801adb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ae1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ae4:	8b 00                	mov    (%eax),%eax
  801ae6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aed:	8b 45 10             	mov    0x10(%ebp),%eax
  801af0:	01 d0                	add    %edx,%eax
  801af2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801af8:	eb 0c                	jmp    801b06 <strsplit+0x31>
			*string++ = 0;
  801afa:	8b 45 08             	mov    0x8(%ebp),%eax
  801afd:	8d 50 01             	lea    0x1(%eax),%edx
  801b00:	89 55 08             	mov    %edx,0x8(%ebp)
  801b03:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	8a 00                	mov    (%eax),%al
  801b0b:	84 c0                	test   %al,%al
  801b0d:	74 18                	je     801b27 <strsplit+0x52>
  801b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b12:	8a 00                	mov    (%eax),%al
  801b14:	0f be c0             	movsbl %al,%eax
  801b17:	50                   	push   %eax
  801b18:	ff 75 0c             	pushl  0xc(%ebp)
  801b1b:	e8 13 fb ff ff       	call   801633 <strchr>
  801b20:	83 c4 08             	add    $0x8,%esp
  801b23:	85 c0                	test   %eax,%eax
  801b25:	75 d3                	jne    801afa <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801b27:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2a:	8a 00                	mov    (%eax),%al
  801b2c:	84 c0                	test   %al,%al
  801b2e:	74 5a                	je     801b8a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801b30:	8b 45 14             	mov    0x14(%ebp),%eax
  801b33:	8b 00                	mov    (%eax),%eax
  801b35:	83 f8 0f             	cmp    $0xf,%eax
  801b38:	75 07                	jne    801b41 <strsplit+0x6c>
		{
			return 0;
  801b3a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b3f:	eb 66                	jmp    801ba7 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b41:	8b 45 14             	mov    0x14(%ebp),%eax
  801b44:	8b 00                	mov    (%eax),%eax
  801b46:	8d 48 01             	lea    0x1(%eax),%ecx
  801b49:	8b 55 14             	mov    0x14(%ebp),%edx
  801b4c:	89 0a                	mov    %ecx,(%edx)
  801b4e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b55:	8b 45 10             	mov    0x10(%ebp),%eax
  801b58:	01 c2                	add    %eax,%edx
  801b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b5f:	eb 03                	jmp    801b64 <strsplit+0x8f>
			string++;
  801b61:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	8a 00                	mov    (%eax),%al
  801b69:	84 c0                	test   %al,%al
  801b6b:	74 8b                	je     801af8 <strsplit+0x23>
  801b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b70:	8a 00                	mov    (%eax),%al
  801b72:	0f be c0             	movsbl %al,%eax
  801b75:	50                   	push   %eax
  801b76:	ff 75 0c             	pushl  0xc(%ebp)
  801b79:	e8 b5 fa ff ff       	call   801633 <strchr>
  801b7e:	83 c4 08             	add    $0x8,%esp
  801b81:	85 c0                	test   %eax,%eax
  801b83:	74 dc                	je     801b61 <strsplit+0x8c>
			string++;
	}
  801b85:	e9 6e ff ff ff       	jmp    801af8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b8a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b8b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b8e:	8b 00                	mov    (%eax),%eax
  801b90:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b97:	8b 45 10             	mov    0x10(%ebp),%eax
  801b9a:	01 d0                	add    %edx,%eax
  801b9c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801ba2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
  801bac:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  801baf:	a1 04 30 80 00       	mov    0x803004,%eax
  801bb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801bb7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  801bbe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801bc5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  801bcc:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  801bd3:	e9 f9 00 00 00       	jmp    801cd1 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bdb:	05 00 00 00 80       	add    $0x80000000,%eax
  801be0:	c1 e8 0c             	shr    $0xc,%eax
  801be3:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801bea:	85 c0                	test   %eax,%eax
  801bec:	75 1c                	jne    801c0a <nextFitAlgo+0x61>
  801bee:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801bf2:	74 16                	je     801c0a <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  801bf4:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801bfb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801c02:	ff 4d e0             	decl   -0x20(%ebp)
  801c05:	e9 90 00 00 00       	jmp    801c9a <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  801c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c0d:	05 00 00 00 80       	add    $0x80000000,%eax
  801c12:	c1 e8 0c             	shr    $0xc,%eax
  801c15:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801c1c:	85 c0                	test   %eax,%eax
  801c1e:	75 26                	jne    801c46 <nextFitAlgo+0x9d>
  801c20:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801c24:	75 20                	jne    801c46 <nextFitAlgo+0x9d>
			flag = 1;
  801c26:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  801c2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c30:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  801c33:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  801c3a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801c41:	ff 4d e0             	decl   -0x20(%ebp)
  801c44:	eb 54                	jmp    801c9a <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  801c46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c49:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c4c:	72 11                	jb     801c5f <nextFitAlgo+0xb6>
				startAdd = tmp;
  801c4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c51:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  801c56:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  801c5d:	eb 7c                	jmp    801cdb <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  801c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c62:	05 00 00 00 80       	add    $0x80000000,%eax
  801c67:	c1 e8 0c             	shr    $0xc,%eax
  801c6a:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801c71:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  801c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c77:	05 00 00 00 80       	add    $0x80000000,%eax
  801c7c:	c1 e8 0c             	shr    $0xc,%eax
  801c7f:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801c86:	c1 e0 0c             	shl    $0xc,%eax
  801c89:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801c8c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c93:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801c9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ca0:	72 11                	jb     801cb3 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801ca2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ca5:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801caa:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801cb1:	eb 28                	jmp    801cdb <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801cb3:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801cba:	76 15                	jbe    801cd1 <nextFitAlgo+0x128>
			flag = newSize = 0;
  801cbc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cc3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801cca:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801cd1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801cd5:	0f 85 fd fe ff ff    	jne    801bd8 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801cdb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801cdf:	75 1a                	jne    801cfb <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801ce1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ce4:	3b 45 08             	cmp    0x8(%ebp),%eax
  801ce7:	73 0a                	jae    801cf3 <nextFitAlgo+0x14a>
  801ce9:	b8 00 00 00 00       	mov    $0x0,%eax
  801cee:	e9 99 00 00 00       	jmp    801d8c <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  801cf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cf6:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801cfb:	a1 04 30 80 00       	mov    0x803004,%eax
  801d00:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  801d03:	a1 04 30 80 00       	mov    0x803004,%eax
  801d08:	05 00 00 00 80       	add    $0x80000000,%eax
  801d0d:	c1 e8 0c             	shr    $0xc,%eax
  801d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801d13:	8b 45 08             	mov    0x8(%ebp),%eax
  801d16:	c1 e8 0c             	shr    $0xc,%eax
  801d19:	89 c2                	mov    %eax,%edx
  801d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1e:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801d25:	a1 04 30 80 00       	mov    0x803004,%eax
  801d2a:	83 ec 08             	sub    $0x8,%esp
  801d2d:	ff 75 08             	pushl  0x8(%ebp)
  801d30:	50                   	push   %eax
  801d31:	e8 82 03 00 00       	call   8020b8 <sys_allocateMem>
  801d36:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801d39:	a1 04 30 80 00       	mov    0x803004,%eax
  801d3e:	05 00 00 00 80       	add    $0x80000000,%eax
  801d43:	c1 e8 0c             	shr    $0xc,%eax
  801d46:	89 c2                	mov    %eax,%edx
  801d48:	a1 04 30 80 00       	mov    0x803004,%eax
  801d4d:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801d54:	a1 04 30 80 00       	mov    0x803004,%eax
  801d59:	05 00 00 00 80       	add    $0x80000000,%eax
  801d5e:	c1 e8 0c             	shr    $0xc,%eax
  801d61:	89 c2                	mov    %eax,%edx
  801d63:	8b 45 08             	mov    0x8(%ebp),%eax
  801d66:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801d6d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801d73:	8b 45 08             	mov    0x8(%ebp),%eax
  801d76:	01 d0                	add    %edx,%eax
  801d78:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801d7d:	76 0a                	jbe    801d89 <nextFitAlgo+0x1e0>
  801d7f:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801d86:	00 00 80 

	return (void*)returnHolder;
  801d89:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801d8c:	c9                   	leave  
  801d8d:	c3                   	ret    

00801d8e <malloc>:

void* malloc(uint32 size) {
  801d8e:	55                   	push   %ebp
  801d8f:	89 e5                	mov    %esp,%ebp
  801d91:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801d94:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801d9b:	8b 55 08             	mov    0x8(%ebp),%edx
  801d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801da1:	01 d0                	add    %edx,%eax
  801da3:	48                   	dec    %eax
  801da4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801daa:	ba 00 00 00 00       	mov    $0x0,%edx
  801daf:	f7 75 f4             	divl   -0xc(%ebp)
  801db2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801db5:	29 d0                	sub    %edx,%eax
  801db7:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801dba:	e8 c3 06 00 00       	call   802482 <sys_isUHeapPlacementStrategyNEXTFIT>
  801dbf:	85 c0                	test   %eax,%eax
  801dc1:	74 10                	je     801dd3 <malloc+0x45>
		return nextFitAlgo(size);
  801dc3:	83 ec 0c             	sub    $0xc,%esp
  801dc6:	ff 75 08             	pushl  0x8(%ebp)
  801dc9:	e8 db fd ff ff       	call   801ba9 <nextFitAlgo>
  801dce:	83 c4 10             	add    $0x10,%esp
  801dd1:	eb 0a                	jmp    801ddd <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801dd3:	e8 79 06 00 00       	call   802451 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801dd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
  801de2:	83 ec 18             	sub    $0x18,%esp
  801de5:	8b 45 10             	mov    0x10(%ebp),%eax
  801de8:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801deb:	83 ec 04             	sub    $0x4,%esp
  801dee:	68 24 2f 80 00       	push   $0x802f24
  801df3:	6a 7e                	push   $0x7e
  801df5:	68 43 2f 80 00       	push   $0x802f43
  801dfa:	e8 66 eb ff ff       	call   800965 <_panic>

00801dff <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801dff:	55                   	push   %ebp
  801e00:	89 e5                	mov    %esp,%ebp
  801e02:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801e05:	83 ec 04             	sub    $0x4,%esp
  801e08:	68 4f 2f 80 00       	push   $0x802f4f
  801e0d:	68 84 00 00 00       	push   $0x84
  801e12:	68 43 2f 80 00       	push   $0x802f43
  801e17:	e8 49 eb ff ff       	call   800965 <_panic>

00801e1c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
  801e1f:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801e22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e29:	eb 61                	jmp    801e8c <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e2e:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801e35:	8b 45 08             	mov    0x8(%ebp),%eax
  801e38:	39 c2                	cmp    %eax,%edx
  801e3a:	75 4d                	jne    801e89 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	05 00 00 00 80       	add    $0x80000000,%eax
  801e44:	c1 e8 0c             	shr    $0xc,%eax
  801e47:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801e4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e4d:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801e54:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801e57:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e5a:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801e61:	00 00 00 00 
  801e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e68:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801e6f:	00 00 00 00 
  801e73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e76:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e80:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801e87:	eb 0d                	jmp    801e96 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801e89:	ff 45 f0             	incl   -0x10(%ebp)
  801e8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e8f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801e94:	76 95                	jbe    801e2b <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801e96:	8b 45 08             	mov    0x8(%ebp),%eax
  801e99:	83 ec 08             	sub    $0x8,%esp
  801e9c:	ff 75 f4             	pushl  -0xc(%ebp)
  801e9f:	50                   	push   %eax
  801ea0:	e8 f7 01 00 00       	call   80209c <sys_freeMem>
  801ea5:	83 c4 10             	add    $0x10,%esp
}
  801ea8:	90                   	nop
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sfree>:


void sfree(void* virtual_address)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801eb1:	83 ec 04             	sub    $0x4,%esp
  801eb4:	68 6b 2f 80 00       	push   $0x802f6b
  801eb9:	68 ac 00 00 00       	push   $0xac
  801ebe:	68 43 2f 80 00       	push   $0x802f43
  801ec3:	e8 9d ea ff ff       	call   800965 <_panic>

00801ec8 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
  801ecb:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801ece:	83 ec 04             	sub    $0x4,%esp
  801ed1:	68 88 2f 80 00       	push   $0x802f88
  801ed6:	68 c4 00 00 00       	push   $0xc4
  801edb:	68 43 2f 80 00       	push   $0x802f43
  801ee0:	e8 80 ea ff ff       	call   800965 <_panic>

00801ee5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
  801ee8:	57                   	push   %edi
  801ee9:	56                   	push   %esi
  801eea:	53                   	push   %ebx
  801eeb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801eee:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ef7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801efa:	8b 7d 18             	mov    0x18(%ebp),%edi
  801efd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f00:	cd 30                	int    $0x30
  801f02:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f05:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f08:	83 c4 10             	add    $0x10,%esp
  801f0b:	5b                   	pop    %ebx
  801f0c:	5e                   	pop    %esi
  801f0d:	5f                   	pop    %edi
  801f0e:	5d                   	pop    %ebp
  801f0f:	c3                   	ret    

00801f10 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f10:	55                   	push   %ebp
  801f11:	89 e5                	mov    %esp,%ebp
  801f13:	83 ec 04             	sub    $0x4,%esp
  801f16:	8b 45 10             	mov    0x10(%ebp),%eax
  801f19:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f1c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f20:	8b 45 08             	mov    0x8(%ebp),%eax
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	52                   	push   %edx
  801f28:	ff 75 0c             	pushl  0xc(%ebp)
  801f2b:	50                   	push   %eax
  801f2c:	6a 00                	push   $0x0
  801f2e:	e8 b2 ff ff ff       	call   801ee5 <syscall>
  801f33:	83 c4 18             	add    $0x18,%esp
}
  801f36:	90                   	nop
  801f37:	c9                   	leave  
  801f38:	c3                   	ret    

00801f39 <sys_cgetc>:

int
sys_cgetc(void)
{
  801f39:	55                   	push   %ebp
  801f3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 01                	push   $0x1
  801f48:	e8 98 ff ff ff       	call   801ee5 <syscall>
  801f4d:	83 c4 18             	add    $0x18,%esp
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801f55:	8b 45 08             	mov    0x8(%ebp),%eax
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	50                   	push   %eax
  801f61:	6a 05                	push   $0x5
  801f63:	e8 7d ff ff ff       	call   801ee5 <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 02                	push   $0x2
  801f7c:	e8 64 ff ff ff       	call   801ee5 <syscall>
  801f81:	83 c4 18             	add    $0x18,%esp
}
  801f84:	c9                   	leave  
  801f85:	c3                   	ret    

00801f86 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f86:	55                   	push   %ebp
  801f87:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 03                	push   $0x3
  801f95:	e8 4b ff ff ff       	call   801ee5 <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 04                	push   $0x4
  801fae:	e8 32 ff ff ff       	call   801ee5 <syscall>
  801fb3:	83 c4 18             	add    $0x18,%esp
}
  801fb6:	c9                   	leave  
  801fb7:	c3                   	ret    

00801fb8 <sys_env_exit>:


void sys_env_exit(void)
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 06                	push   $0x6
  801fc7:	e8 19 ff ff ff       	call   801ee5 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	90                   	nop
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801fd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	52                   	push   %edx
  801fe2:	50                   	push   %eax
  801fe3:	6a 07                	push   $0x7
  801fe5:	e8 fb fe ff ff       	call   801ee5 <syscall>
  801fea:	83 c4 18             	add    $0x18,%esp
}
  801fed:	c9                   	leave  
  801fee:	c3                   	ret    

00801fef <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801fef:	55                   	push   %ebp
  801ff0:	89 e5                	mov    %esp,%ebp
  801ff2:	56                   	push   %esi
  801ff3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ff4:	8b 75 18             	mov    0x18(%ebp),%esi
  801ff7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ffa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ffd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802000:	8b 45 08             	mov    0x8(%ebp),%eax
  802003:	56                   	push   %esi
  802004:	53                   	push   %ebx
  802005:	51                   	push   %ecx
  802006:	52                   	push   %edx
  802007:	50                   	push   %eax
  802008:	6a 08                	push   $0x8
  80200a:	e8 d6 fe ff ff       	call   801ee5 <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802015:	5b                   	pop    %ebx
  802016:	5e                   	pop    %esi
  802017:	5d                   	pop    %ebp
  802018:	c3                   	ret    

00802019 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80201c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	52                   	push   %edx
  802029:	50                   	push   %eax
  80202a:	6a 09                	push   $0x9
  80202c:	e8 b4 fe ff ff       	call   801ee5 <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	ff 75 0c             	pushl  0xc(%ebp)
  802042:	ff 75 08             	pushl  0x8(%ebp)
  802045:	6a 0a                	push   $0xa
  802047:	e8 99 fe ff ff       	call   801ee5 <syscall>
  80204c:	83 c4 18             	add    $0x18,%esp
}
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 0b                	push   $0xb
  802060:	e8 80 fe ff ff       	call   801ee5 <syscall>
  802065:	83 c4 18             	add    $0x18,%esp
}
  802068:	c9                   	leave  
  802069:	c3                   	ret    

0080206a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80206a:	55                   	push   %ebp
  80206b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 0c                	push   $0xc
  802079:	e8 67 fe ff ff       	call   801ee5 <syscall>
  80207e:	83 c4 18             	add    $0x18,%esp
}
  802081:	c9                   	leave  
  802082:	c3                   	ret    

00802083 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802083:	55                   	push   %ebp
  802084:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 0d                	push   $0xd
  802092:	e8 4e fe ff ff       	call   801ee5 <syscall>
  802097:	83 c4 18             	add    $0x18,%esp
}
  80209a:	c9                   	leave  
  80209b:	c3                   	ret    

0080209c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80209c:	55                   	push   %ebp
  80209d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	ff 75 0c             	pushl  0xc(%ebp)
  8020a8:	ff 75 08             	pushl  0x8(%ebp)
  8020ab:	6a 11                	push   $0x11
  8020ad:	e8 33 fe ff ff       	call   801ee5 <syscall>
  8020b2:	83 c4 18             	add    $0x18,%esp
	return;
  8020b5:	90                   	nop
}
  8020b6:	c9                   	leave  
  8020b7:	c3                   	ret    

008020b8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8020b8:	55                   	push   %ebp
  8020b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	ff 75 0c             	pushl  0xc(%ebp)
  8020c4:	ff 75 08             	pushl  0x8(%ebp)
  8020c7:	6a 12                	push   $0x12
  8020c9:	e8 17 fe ff ff       	call   801ee5 <syscall>
  8020ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d1:	90                   	nop
}
  8020d2:	c9                   	leave  
  8020d3:	c3                   	ret    

008020d4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8020d4:	55                   	push   %ebp
  8020d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 0e                	push   $0xe
  8020e3:	e8 fd fd ff ff       	call   801ee5 <syscall>
  8020e8:	83 c4 18             	add    $0x18,%esp
}
  8020eb:	c9                   	leave  
  8020ec:	c3                   	ret    

008020ed <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020ed:	55                   	push   %ebp
  8020ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	ff 75 08             	pushl  0x8(%ebp)
  8020fb:	6a 0f                	push   $0xf
  8020fd:	e8 e3 fd ff ff       	call   801ee5 <syscall>
  802102:	83 c4 18             	add    $0x18,%esp
}
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 10                	push   $0x10
  802116:	e8 ca fd ff ff       	call   801ee5 <syscall>
  80211b:	83 c4 18             	add    $0x18,%esp
}
  80211e:	90                   	nop
  80211f:	c9                   	leave  
  802120:	c3                   	ret    

00802121 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802121:	55                   	push   %ebp
  802122:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 14                	push   $0x14
  802130:	e8 b0 fd ff ff       	call   801ee5 <syscall>
  802135:	83 c4 18             	add    $0x18,%esp
}
  802138:	90                   	nop
  802139:	c9                   	leave  
  80213a:	c3                   	ret    

0080213b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80213b:	55                   	push   %ebp
  80213c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 15                	push   $0x15
  80214a:	e8 96 fd ff ff       	call   801ee5 <syscall>
  80214f:	83 c4 18             	add    $0x18,%esp
}
  802152:	90                   	nop
  802153:	c9                   	leave  
  802154:	c3                   	ret    

00802155 <sys_cputc>:


void
sys_cputc(const char c)
{
  802155:	55                   	push   %ebp
  802156:	89 e5                	mov    %esp,%ebp
  802158:	83 ec 04             	sub    $0x4,%esp
  80215b:	8b 45 08             	mov    0x8(%ebp),%eax
  80215e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802161:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	50                   	push   %eax
  80216e:	6a 16                	push   $0x16
  802170:	e8 70 fd ff ff       	call   801ee5 <syscall>
  802175:	83 c4 18             	add    $0x18,%esp
}
  802178:	90                   	nop
  802179:	c9                   	leave  
  80217a:	c3                   	ret    

0080217b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80217b:	55                   	push   %ebp
  80217c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 17                	push   $0x17
  80218a:	e8 56 fd ff ff       	call   801ee5 <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	90                   	nop
  802193:	c9                   	leave  
  802194:	c3                   	ret    

00802195 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802195:	55                   	push   %ebp
  802196:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802198:	8b 45 08             	mov    0x8(%ebp),%eax
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	ff 75 0c             	pushl  0xc(%ebp)
  8021a4:	50                   	push   %eax
  8021a5:	6a 18                	push   $0x18
  8021a7:	e8 39 fd ff ff       	call   801ee5 <syscall>
  8021ac:	83 c4 18             	add    $0x18,%esp
}
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 00                	push   $0x0
  8021c0:	52                   	push   %edx
  8021c1:	50                   	push   %eax
  8021c2:	6a 1b                	push   $0x1b
  8021c4:	e8 1c fd ff ff       	call   801ee5 <syscall>
  8021c9:	83 c4 18             	add    $0x18,%esp
}
  8021cc:	c9                   	leave  
  8021cd:	c3                   	ret    

008021ce <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021ce:	55                   	push   %ebp
  8021cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	52                   	push   %edx
  8021de:	50                   	push   %eax
  8021df:	6a 19                	push   $0x19
  8021e1:	e8 ff fc ff ff       	call   801ee5 <syscall>
  8021e6:	83 c4 18             	add    $0x18,%esp
}
  8021e9:	90                   	nop
  8021ea:	c9                   	leave  
  8021eb:	c3                   	ret    

008021ec <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021ec:	55                   	push   %ebp
  8021ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f5:	6a 00                	push   $0x0
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	52                   	push   %edx
  8021fc:	50                   	push   %eax
  8021fd:	6a 1a                	push   $0x1a
  8021ff:	e8 e1 fc ff ff       	call   801ee5 <syscall>
  802204:	83 c4 18             	add    $0x18,%esp
}
  802207:	90                   	nop
  802208:	c9                   	leave  
  802209:	c3                   	ret    

0080220a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
  80220d:	83 ec 04             	sub    $0x4,%esp
  802210:	8b 45 10             	mov    0x10(%ebp),%eax
  802213:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802216:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802219:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80221d:	8b 45 08             	mov    0x8(%ebp),%eax
  802220:	6a 00                	push   $0x0
  802222:	51                   	push   %ecx
  802223:	52                   	push   %edx
  802224:	ff 75 0c             	pushl  0xc(%ebp)
  802227:	50                   	push   %eax
  802228:	6a 1c                	push   $0x1c
  80222a:	e8 b6 fc ff ff       	call   801ee5 <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223a:	8b 45 08             	mov    0x8(%ebp),%eax
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 00                	push   $0x0
  802243:	52                   	push   %edx
  802244:	50                   	push   %eax
  802245:	6a 1d                	push   $0x1d
  802247:	e8 99 fc ff ff       	call   801ee5 <syscall>
  80224c:	83 c4 18             	add    $0x18,%esp
}
  80224f:	c9                   	leave  
  802250:	c3                   	ret    

00802251 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802254:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802257:	8b 55 0c             	mov    0xc(%ebp),%edx
  80225a:	8b 45 08             	mov    0x8(%ebp),%eax
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	51                   	push   %ecx
  802262:	52                   	push   %edx
  802263:	50                   	push   %eax
  802264:	6a 1e                	push   $0x1e
  802266:	e8 7a fc ff ff       	call   801ee5 <syscall>
  80226b:	83 c4 18             	add    $0x18,%esp
}
  80226e:	c9                   	leave  
  80226f:	c3                   	ret    

00802270 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802270:	55                   	push   %ebp
  802271:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802273:	8b 55 0c             	mov    0xc(%ebp),%edx
  802276:	8b 45 08             	mov    0x8(%ebp),%eax
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	52                   	push   %edx
  802280:	50                   	push   %eax
  802281:	6a 1f                	push   $0x1f
  802283:	e8 5d fc ff ff       	call   801ee5 <syscall>
  802288:	83 c4 18             	add    $0x18,%esp
}
  80228b:	c9                   	leave  
  80228c:	c3                   	ret    

0080228d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802290:	6a 00                	push   $0x0
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 20                	push   $0x20
  80229c:	e8 44 fc ff ff       	call   801ee5 <syscall>
  8022a1:	83 c4 18             	add    $0x18,%esp
}
  8022a4:	c9                   	leave  
  8022a5:	c3                   	ret    

008022a6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8022a6:	55                   	push   %ebp
  8022a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	ff 75 10             	pushl  0x10(%ebp)
  8022b3:	ff 75 0c             	pushl  0xc(%ebp)
  8022b6:	50                   	push   %eax
  8022b7:	6a 21                	push   $0x21
  8022b9:	e8 27 fc ff ff       	call   801ee5 <syscall>
  8022be:	83 c4 18             	add    $0x18,%esp
}
  8022c1:	c9                   	leave  
  8022c2:	c3                   	ret    

008022c3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8022c3:	55                   	push   %ebp
  8022c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8022c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	50                   	push   %eax
  8022d2:	6a 22                	push   $0x22
  8022d4:	e8 0c fc ff ff       	call   801ee5 <syscall>
  8022d9:	83 c4 18             	add    $0x18,%esp
}
  8022dc:	90                   	nop
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8022e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e5:	6a 00                	push   $0x0
  8022e7:	6a 00                	push   $0x0
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	50                   	push   %eax
  8022ee:	6a 23                	push   $0x23
  8022f0:	e8 f0 fb ff ff       	call   801ee5 <syscall>
  8022f5:	83 c4 18             	add    $0x18,%esp
}
  8022f8:	90                   	nop
  8022f9:	c9                   	leave  
  8022fa:	c3                   	ret    

008022fb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8022fb:	55                   	push   %ebp
  8022fc:	89 e5                	mov    %esp,%ebp
  8022fe:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802301:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802304:	8d 50 04             	lea    0x4(%eax),%edx
  802307:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80230a:	6a 00                	push   $0x0
  80230c:	6a 00                	push   $0x0
  80230e:	6a 00                	push   $0x0
  802310:	52                   	push   %edx
  802311:	50                   	push   %eax
  802312:	6a 24                	push   $0x24
  802314:	e8 cc fb ff ff       	call   801ee5 <syscall>
  802319:	83 c4 18             	add    $0x18,%esp
	return result;
  80231c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80231f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802322:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802325:	89 01                	mov    %eax,(%ecx)
  802327:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80232a:	8b 45 08             	mov    0x8(%ebp),%eax
  80232d:	c9                   	leave  
  80232e:	c2 04 00             	ret    $0x4

00802331 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802331:	55                   	push   %ebp
  802332:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	ff 75 10             	pushl  0x10(%ebp)
  80233b:	ff 75 0c             	pushl  0xc(%ebp)
  80233e:	ff 75 08             	pushl  0x8(%ebp)
  802341:	6a 13                	push   $0x13
  802343:	e8 9d fb ff ff       	call   801ee5 <syscall>
  802348:	83 c4 18             	add    $0x18,%esp
	return ;
  80234b:	90                   	nop
}
  80234c:	c9                   	leave  
  80234d:	c3                   	ret    

0080234e <sys_rcr2>:
uint32 sys_rcr2()
{
  80234e:	55                   	push   %ebp
  80234f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	6a 25                	push   $0x25
  80235d:	e8 83 fb ff ff       	call   801ee5 <syscall>
  802362:	83 c4 18             	add    $0x18,%esp
}
  802365:	c9                   	leave  
  802366:	c3                   	ret    

00802367 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802367:	55                   	push   %ebp
  802368:	89 e5                	mov    %esp,%ebp
  80236a:	83 ec 04             	sub    $0x4,%esp
  80236d:	8b 45 08             	mov    0x8(%ebp),%eax
  802370:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802373:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802377:	6a 00                	push   $0x0
  802379:	6a 00                	push   $0x0
  80237b:	6a 00                	push   $0x0
  80237d:	6a 00                	push   $0x0
  80237f:	50                   	push   %eax
  802380:	6a 26                	push   $0x26
  802382:	e8 5e fb ff ff       	call   801ee5 <syscall>
  802387:	83 c4 18             	add    $0x18,%esp
	return ;
  80238a:	90                   	nop
}
  80238b:	c9                   	leave  
  80238c:	c3                   	ret    

0080238d <rsttst>:
void rsttst()
{
  80238d:	55                   	push   %ebp
  80238e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802390:	6a 00                	push   $0x0
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	6a 28                	push   $0x28
  80239c:	e8 44 fb ff ff       	call   801ee5 <syscall>
  8023a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8023a4:	90                   	nop
}
  8023a5:	c9                   	leave  
  8023a6:	c3                   	ret    

008023a7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8023a7:	55                   	push   %ebp
  8023a8:	89 e5                	mov    %esp,%ebp
  8023aa:	83 ec 04             	sub    $0x4,%esp
  8023ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8023b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8023b3:	8b 55 18             	mov    0x18(%ebp),%edx
  8023b6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023ba:	52                   	push   %edx
  8023bb:	50                   	push   %eax
  8023bc:	ff 75 10             	pushl  0x10(%ebp)
  8023bf:	ff 75 0c             	pushl  0xc(%ebp)
  8023c2:	ff 75 08             	pushl  0x8(%ebp)
  8023c5:	6a 27                	push   $0x27
  8023c7:	e8 19 fb ff ff       	call   801ee5 <syscall>
  8023cc:	83 c4 18             	add    $0x18,%esp
	return ;
  8023cf:	90                   	nop
}
  8023d0:	c9                   	leave  
  8023d1:	c3                   	ret    

008023d2 <chktst>:
void chktst(uint32 n)
{
  8023d2:	55                   	push   %ebp
  8023d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	ff 75 08             	pushl  0x8(%ebp)
  8023e0:	6a 29                	push   $0x29
  8023e2:	e8 fe fa ff ff       	call   801ee5 <syscall>
  8023e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ea:	90                   	nop
}
  8023eb:	c9                   	leave  
  8023ec:	c3                   	ret    

008023ed <inctst>:

void inctst()
{
  8023ed:	55                   	push   %ebp
  8023ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8023f0:	6a 00                	push   $0x0
  8023f2:	6a 00                	push   $0x0
  8023f4:	6a 00                	push   $0x0
  8023f6:	6a 00                	push   $0x0
  8023f8:	6a 00                	push   $0x0
  8023fa:	6a 2a                	push   $0x2a
  8023fc:	e8 e4 fa ff ff       	call   801ee5 <syscall>
  802401:	83 c4 18             	add    $0x18,%esp
	return ;
  802404:	90                   	nop
}
  802405:	c9                   	leave  
  802406:	c3                   	ret    

00802407 <gettst>:
uint32 gettst()
{
  802407:	55                   	push   %ebp
  802408:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80240a:	6a 00                	push   $0x0
  80240c:	6a 00                	push   $0x0
  80240e:	6a 00                	push   $0x0
  802410:	6a 00                	push   $0x0
  802412:	6a 00                	push   $0x0
  802414:	6a 2b                	push   $0x2b
  802416:	e8 ca fa ff ff       	call   801ee5 <syscall>
  80241b:	83 c4 18             	add    $0x18,%esp
}
  80241e:	c9                   	leave  
  80241f:	c3                   	ret    

00802420 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802420:	55                   	push   %ebp
  802421:	89 e5                	mov    %esp,%ebp
  802423:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802426:	6a 00                	push   $0x0
  802428:	6a 00                	push   $0x0
  80242a:	6a 00                	push   $0x0
  80242c:	6a 00                	push   $0x0
  80242e:	6a 00                	push   $0x0
  802430:	6a 2c                	push   $0x2c
  802432:	e8 ae fa ff ff       	call   801ee5 <syscall>
  802437:	83 c4 18             	add    $0x18,%esp
  80243a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80243d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802441:	75 07                	jne    80244a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802443:	b8 01 00 00 00       	mov    $0x1,%eax
  802448:	eb 05                	jmp    80244f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80244a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80244f:	c9                   	leave  
  802450:	c3                   	ret    

00802451 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802451:	55                   	push   %ebp
  802452:	89 e5                	mov    %esp,%ebp
  802454:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802457:	6a 00                	push   $0x0
  802459:	6a 00                	push   $0x0
  80245b:	6a 00                	push   $0x0
  80245d:	6a 00                	push   $0x0
  80245f:	6a 00                	push   $0x0
  802461:	6a 2c                	push   $0x2c
  802463:	e8 7d fa ff ff       	call   801ee5 <syscall>
  802468:	83 c4 18             	add    $0x18,%esp
  80246b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80246e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802472:	75 07                	jne    80247b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802474:	b8 01 00 00 00       	mov    $0x1,%eax
  802479:	eb 05                	jmp    802480 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80247b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802480:	c9                   	leave  
  802481:	c3                   	ret    

00802482 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802482:	55                   	push   %ebp
  802483:	89 e5                	mov    %esp,%ebp
  802485:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802488:	6a 00                	push   $0x0
  80248a:	6a 00                	push   $0x0
  80248c:	6a 00                	push   $0x0
  80248e:	6a 00                	push   $0x0
  802490:	6a 00                	push   $0x0
  802492:	6a 2c                	push   $0x2c
  802494:	e8 4c fa ff ff       	call   801ee5 <syscall>
  802499:	83 c4 18             	add    $0x18,%esp
  80249c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80249f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8024a3:	75 07                	jne    8024ac <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8024a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8024aa:	eb 05                	jmp    8024b1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8024ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024b1:	c9                   	leave  
  8024b2:	c3                   	ret    

008024b3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8024b3:	55                   	push   %ebp
  8024b4:	89 e5                	mov    %esp,%ebp
  8024b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024b9:	6a 00                	push   $0x0
  8024bb:	6a 00                	push   $0x0
  8024bd:	6a 00                	push   $0x0
  8024bf:	6a 00                	push   $0x0
  8024c1:	6a 00                	push   $0x0
  8024c3:	6a 2c                	push   $0x2c
  8024c5:	e8 1b fa ff ff       	call   801ee5 <syscall>
  8024ca:	83 c4 18             	add    $0x18,%esp
  8024cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8024d0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8024d4:	75 07                	jne    8024dd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8024d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8024db:	eb 05                	jmp    8024e2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8024dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024e2:	c9                   	leave  
  8024e3:	c3                   	ret    

008024e4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8024e4:	55                   	push   %ebp
  8024e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8024e7:	6a 00                	push   $0x0
  8024e9:	6a 00                	push   $0x0
  8024eb:	6a 00                	push   $0x0
  8024ed:	6a 00                	push   $0x0
  8024ef:	ff 75 08             	pushl  0x8(%ebp)
  8024f2:	6a 2d                	push   $0x2d
  8024f4:	e8 ec f9 ff ff       	call   801ee5 <syscall>
  8024f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8024fc:	90                   	nop
}
  8024fd:	c9                   	leave  
  8024fe:	c3                   	ret    
  8024ff:	90                   	nop

00802500 <__udivdi3>:
  802500:	55                   	push   %ebp
  802501:	57                   	push   %edi
  802502:	56                   	push   %esi
  802503:	53                   	push   %ebx
  802504:	83 ec 1c             	sub    $0x1c,%esp
  802507:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80250b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80250f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802513:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802517:	89 ca                	mov    %ecx,%edx
  802519:	89 f8                	mov    %edi,%eax
  80251b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80251f:	85 f6                	test   %esi,%esi
  802521:	75 2d                	jne    802550 <__udivdi3+0x50>
  802523:	39 cf                	cmp    %ecx,%edi
  802525:	77 65                	ja     80258c <__udivdi3+0x8c>
  802527:	89 fd                	mov    %edi,%ebp
  802529:	85 ff                	test   %edi,%edi
  80252b:	75 0b                	jne    802538 <__udivdi3+0x38>
  80252d:	b8 01 00 00 00       	mov    $0x1,%eax
  802532:	31 d2                	xor    %edx,%edx
  802534:	f7 f7                	div    %edi
  802536:	89 c5                	mov    %eax,%ebp
  802538:	31 d2                	xor    %edx,%edx
  80253a:	89 c8                	mov    %ecx,%eax
  80253c:	f7 f5                	div    %ebp
  80253e:	89 c1                	mov    %eax,%ecx
  802540:	89 d8                	mov    %ebx,%eax
  802542:	f7 f5                	div    %ebp
  802544:	89 cf                	mov    %ecx,%edi
  802546:	89 fa                	mov    %edi,%edx
  802548:	83 c4 1c             	add    $0x1c,%esp
  80254b:	5b                   	pop    %ebx
  80254c:	5e                   	pop    %esi
  80254d:	5f                   	pop    %edi
  80254e:	5d                   	pop    %ebp
  80254f:	c3                   	ret    
  802550:	39 ce                	cmp    %ecx,%esi
  802552:	77 28                	ja     80257c <__udivdi3+0x7c>
  802554:	0f bd fe             	bsr    %esi,%edi
  802557:	83 f7 1f             	xor    $0x1f,%edi
  80255a:	75 40                	jne    80259c <__udivdi3+0x9c>
  80255c:	39 ce                	cmp    %ecx,%esi
  80255e:	72 0a                	jb     80256a <__udivdi3+0x6a>
  802560:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802564:	0f 87 9e 00 00 00    	ja     802608 <__udivdi3+0x108>
  80256a:	b8 01 00 00 00       	mov    $0x1,%eax
  80256f:	89 fa                	mov    %edi,%edx
  802571:	83 c4 1c             	add    $0x1c,%esp
  802574:	5b                   	pop    %ebx
  802575:	5e                   	pop    %esi
  802576:	5f                   	pop    %edi
  802577:	5d                   	pop    %ebp
  802578:	c3                   	ret    
  802579:	8d 76 00             	lea    0x0(%esi),%esi
  80257c:	31 ff                	xor    %edi,%edi
  80257e:	31 c0                	xor    %eax,%eax
  802580:	89 fa                	mov    %edi,%edx
  802582:	83 c4 1c             	add    $0x1c,%esp
  802585:	5b                   	pop    %ebx
  802586:	5e                   	pop    %esi
  802587:	5f                   	pop    %edi
  802588:	5d                   	pop    %ebp
  802589:	c3                   	ret    
  80258a:	66 90                	xchg   %ax,%ax
  80258c:	89 d8                	mov    %ebx,%eax
  80258e:	f7 f7                	div    %edi
  802590:	31 ff                	xor    %edi,%edi
  802592:	89 fa                	mov    %edi,%edx
  802594:	83 c4 1c             	add    $0x1c,%esp
  802597:	5b                   	pop    %ebx
  802598:	5e                   	pop    %esi
  802599:	5f                   	pop    %edi
  80259a:	5d                   	pop    %ebp
  80259b:	c3                   	ret    
  80259c:	bd 20 00 00 00       	mov    $0x20,%ebp
  8025a1:	89 eb                	mov    %ebp,%ebx
  8025a3:	29 fb                	sub    %edi,%ebx
  8025a5:	89 f9                	mov    %edi,%ecx
  8025a7:	d3 e6                	shl    %cl,%esi
  8025a9:	89 c5                	mov    %eax,%ebp
  8025ab:	88 d9                	mov    %bl,%cl
  8025ad:	d3 ed                	shr    %cl,%ebp
  8025af:	89 e9                	mov    %ebp,%ecx
  8025b1:	09 f1                	or     %esi,%ecx
  8025b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8025b7:	89 f9                	mov    %edi,%ecx
  8025b9:	d3 e0                	shl    %cl,%eax
  8025bb:	89 c5                	mov    %eax,%ebp
  8025bd:	89 d6                	mov    %edx,%esi
  8025bf:	88 d9                	mov    %bl,%cl
  8025c1:	d3 ee                	shr    %cl,%esi
  8025c3:	89 f9                	mov    %edi,%ecx
  8025c5:	d3 e2                	shl    %cl,%edx
  8025c7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025cb:	88 d9                	mov    %bl,%cl
  8025cd:	d3 e8                	shr    %cl,%eax
  8025cf:	09 c2                	or     %eax,%edx
  8025d1:	89 d0                	mov    %edx,%eax
  8025d3:	89 f2                	mov    %esi,%edx
  8025d5:	f7 74 24 0c          	divl   0xc(%esp)
  8025d9:	89 d6                	mov    %edx,%esi
  8025db:	89 c3                	mov    %eax,%ebx
  8025dd:	f7 e5                	mul    %ebp
  8025df:	39 d6                	cmp    %edx,%esi
  8025e1:	72 19                	jb     8025fc <__udivdi3+0xfc>
  8025e3:	74 0b                	je     8025f0 <__udivdi3+0xf0>
  8025e5:	89 d8                	mov    %ebx,%eax
  8025e7:	31 ff                	xor    %edi,%edi
  8025e9:	e9 58 ff ff ff       	jmp    802546 <__udivdi3+0x46>
  8025ee:	66 90                	xchg   %ax,%ax
  8025f0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025f4:	89 f9                	mov    %edi,%ecx
  8025f6:	d3 e2                	shl    %cl,%edx
  8025f8:	39 c2                	cmp    %eax,%edx
  8025fa:	73 e9                	jae    8025e5 <__udivdi3+0xe5>
  8025fc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025ff:	31 ff                	xor    %edi,%edi
  802601:	e9 40 ff ff ff       	jmp    802546 <__udivdi3+0x46>
  802606:	66 90                	xchg   %ax,%ax
  802608:	31 c0                	xor    %eax,%eax
  80260a:	e9 37 ff ff ff       	jmp    802546 <__udivdi3+0x46>
  80260f:	90                   	nop

00802610 <__umoddi3>:
  802610:	55                   	push   %ebp
  802611:	57                   	push   %edi
  802612:	56                   	push   %esi
  802613:	53                   	push   %ebx
  802614:	83 ec 1c             	sub    $0x1c,%esp
  802617:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80261b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80261f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802623:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802627:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80262b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80262f:	89 f3                	mov    %esi,%ebx
  802631:	89 fa                	mov    %edi,%edx
  802633:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802637:	89 34 24             	mov    %esi,(%esp)
  80263a:	85 c0                	test   %eax,%eax
  80263c:	75 1a                	jne    802658 <__umoddi3+0x48>
  80263e:	39 f7                	cmp    %esi,%edi
  802640:	0f 86 a2 00 00 00    	jbe    8026e8 <__umoddi3+0xd8>
  802646:	89 c8                	mov    %ecx,%eax
  802648:	89 f2                	mov    %esi,%edx
  80264a:	f7 f7                	div    %edi
  80264c:	89 d0                	mov    %edx,%eax
  80264e:	31 d2                	xor    %edx,%edx
  802650:	83 c4 1c             	add    $0x1c,%esp
  802653:	5b                   	pop    %ebx
  802654:	5e                   	pop    %esi
  802655:	5f                   	pop    %edi
  802656:	5d                   	pop    %ebp
  802657:	c3                   	ret    
  802658:	39 f0                	cmp    %esi,%eax
  80265a:	0f 87 ac 00 00 00    	ja     80270c <__umoddi3+0xfc>
  802660:	0f bd e8             	bsr    %eax,%ebp
  802663:	83 f5 1f             	xor    $0x1f,%ebp
  802666:	0f 84 ac 00 00 00    	je     802718 <__umoddi3+0x108>
  80266c:	bf 20 00 00 00       	mov    $0x20,%edi
  802671:	29 ef                	sub    %ebp,%edi
  802673:	89 fe                	mov    %edi,%esi
  802675:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802679:	89 e9                	mov    %ebp,%ecx
  80267b:	d3 e0                	shl    %cl,%eax
  80267d:	89 d7                	mov    %edx,%edi
  80267f:	89 f1                	mov    %esi,%ecx
  802681:	d3 ef                	shr    %cl,%edi
  802683:	09 c7                	or     %eax,%edi
  802685:	89 e9                	mov    %ebp,%ecx
  802687:	d3 e2                	shl    %cl,%edx
  802689:	89 14 24             	mov    %edx,(%esp)
  80268c:	89 d8                	mov    %ebx,%eax
  80268e:	d3 e0                	shl    %cl,%eax
  802690:	89 c2                	mov    %eax,%edx
  802692:	8b 44 24 08          	mov    0x8(%esp),%eax
  802696:	d3 e0                	shl    %cl,%eax
  802698:	89 44 24 04          	mov    %eax,0x4(%esp)
  80269c:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026a0:	89 f1                	mov    %esi,%ecx
  8026a2:	d3 e8                	shr    %cl,%eax
  8026a4:	09 d0                	or     %edx,%eax
  8026a6:	d3 eb                	shr    %cl,%ebx
  8026a8:	89 da                	mov    %ebx,%edx
  8026aa:	f7 f7                	div    %edi
  8026ac:	89 d3                	mov    %edx,%ebx
  8026ae:	f7 24 24             	mull   (%esp)
  8026b1:	89 c6                	mov    %eax,%esi
  8026b3:	89 d1                	mov    %edx,%ecx
  8026b5:	39 d3                	cmp    %edx,%ebx
  8026b7:	0f 82 87 00 00 00    	jb     802744 <__umoddi3+0x134>
  8026bd:	0f 84 91 00 00 00    	je     802754 <__umoddi3+0x144>
  8026c3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8026c7:	29 f2                	sub    %esi,%edx
  8026c9:	19 cb                	sbb    %ecx,%ebx
  8026cb:	89 d8                	mov    %ebx,%eax
  8026cd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026d1:	d3 e0                	shl    %cl,%eax
  8026d3:	89 e9                	mov    %ebp,%ecx
  8026d5:	d3 ea                	shr    %cl,%edx
  8026d7:	09 d0                	or     %edx,%eax
  8026d9:	89 e9                	mov    %ebp,%ecx
  8026db:	d3 eb                	shr    %cl,%ebx
  8026dd:	89 da                	mov    %ebx,%edx
  8026df:	83 c4 1c             	add    $0x1c,%esp
  8026e2:	5b                   	pop    %ebx
  8026e3:	5e                   	pop    %esi
  8026e4:	5f                   	pop    %edi
  8026e5:	5d                   	pop    %ebp
  8026e6:	c3                   	ret    
  8026e7:	90                   	nop
  8026e8:	89 fd                	mov    %edi,%ebp
  8026ea:	85 ff                	test   %edi,%edi
  8026ec:	75 0b                	jne    8026f9 <__umoddi3+0xe9>
  8026ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8026f3:	31 d2                	xor    %edx,%edx
  8026f5:	f7 f7                	div    %edi
  8026f7:	89 c5                	mov    %eax,%ebp
  8026f9:	89 f0                	mov    %esi,%eax
  8026fb:	31 d2                	xor    %edx,%edx
  8026fd:	f7 f5                	div    %ebp
  8026ff:	89 c8                	mov    %ecx,%eax
  802701:	f7 f5                	div    %ebp
  802703:	89 d0                	mov    %edx,%eax
  802705:	e9 44 ff ff ff       	jmp    80264e <__umoddi3+0x3e>
  80270a:	66 90                	xchg   %ax,%ax
  80270c:	89 c8                	mov    %ecx,%eax
  80270e:	89 f2                	mov    %esi,%edx
  802710:	83 c4 1c             	add    $0x1c,%esp
  802713:	5b                   	pop    %ebx
  802714:	5e                   	pop    %esi
  802715:	5f                   	pop    %edi
  802716:	5d                   	pop    %ebp
  802717:	c3                   	ret    
  802718:	3b 04 24             	cmp    (%esp),%eax
  80271b:	72 06                	jb     802723 <__umoddi3+0x113>
  80271d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802721:	77 0f                	ja     802732 <__umoddi3+0x122>
  802723:	89 f2                	mov    %esi,%edx
  802725:	29 f9                	sub    %edi,%ecx
  802727:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80272b:	89 14 24             	mov    %edx,(%esp)
  80272e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802732:	8b 44 24 04          	mov    0x4(%esp),%eax
  802736:	8b 14 24             	mov    (%esp),%edx
  802739:	83 c4 1c             	add    $0x1c,%esp
  80273c:	5b                   	pop    %ebx
  80273d:	5e                   	pop    %esi
  80273e:	5f                   	pop    %edi
  80273f:	5d                   	pop    %ebp
  802740:	c3                   	ret    
  802741:	8d 76 00             	lea    0x0(%esi),%esi
  802744:	2b 04 24             	sub    (%esp),%eax
  802747:	19 fa                	sbb    %edi,%edx
  802749:	89 d1                	mov    %edx,%ecx
  80274b:	89 c6                	mov    %eax,%esi
  80274d:	e9 71 ff ff ff       	jmp    8026c3 <__umoddi3+0xb3>
  802752:	66 90                	xchg   %ax,%ax
  802754:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802758:	72 ea                	jb     802744 <__umoddi3+0x134>
  80275a:	89 d9                	mov    %ebx,%ecx
  80275c:	e9 62 ff ff ff       	jmp    8026c3 <__umoddi3+0xb3>
