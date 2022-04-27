
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 74 06 00 00       	call   8006aa <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int envID = sys_getenvid();
  800049:	e8 d9 1a 00 00       	call   801b27 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 20 23 80 00       	push   $0x802320
  80005b:	e8 ef 1c 00 00       	call   801d4f <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 a3 1b 00 00       	call   801c0b <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 b5 1b 00 00       	call   801c24 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 20 23 80 00       	push   $0x802320
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 01 1d 00 00       	call   801d88 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 24 23 80 00       	push   $0x802324
  800099:	e8 51 10 00 00       	call   8010ef <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 a1 15 00 00       	call   801655 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 34 19 00 00       	call   8019fd <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 44 23 80 00       	push   $0x802344
  8000d7:	e8 91 09 00 00       	call   800a6d <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 67 23 80 00       	push   $0x802367
  8000e7:	e8 81 09 00 00       	call   800a6d <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 75 23 80 00       	push   $0x802375
  800119:	e8 4f 09 00 00       	call   800a6d <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\nSelect: ") ;
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 84 23 80 00       	push   $0x802384
  800129:	e8 3f 09 00 00       	call   800a6d <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800131:	e8 1c 05 00 00       	call   800652 <getchar>
  800136:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  800139:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	50                   	push   %eax
  800141:	e8 c4 04 00 00       	call   80060a <cputchar>
  800146:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	6a 0a                	push   $0xa
  80014e:	e8 b7 04 00 00       	call   80060a <cputchar>
  800153:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  800156:	83 ec 08             	sub    $0x8,%esp
  800159:	68 20 23 80 00       	push   $0x802320
  80015e:	ff 75 e8             	pushl  -0x18(%ebp)
  800161:	e8 40 1c 00 00       	call   801da6 <sys_signalSemaphore>
  800166:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800169:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80016d:	83 f8 62             	cmp    $0x62,%eax
  800170:	74 1d                	je     80018f <_main+0x157>
  800172:	83 f8 63             	cmp    $0x63,%eax
  800175:	74 2b                	je     8001a2 <_main+0x16a>
  800177:	83 f8 61             	cmp    $0x61,%eax
  80017a:	75 39                	jne    8001b5 <_main+0x17d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017c:	83 ec 08             	sub    $0x8,%esp
  80017f:	ff 75 e0             	pushl  -0x20(%ebp)
  800182:	ff 75 dc             	pushl  -0x24(%ebp)
  800185:	e8 48 03 00 00       	call   8004d2 <InitializeAscending>
  80018a:	83 c4 10             	add    $0x10,%esp
			break ;
  80018d:	eb 37                	jmp    8001c6 <_main+0x18e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018f:	83 ec 08             	sub    $0x8,%esp
  800192:	ff 75 e0             	pushl  -0x20(%ebp)
  800195:	ff 75 dc             	pushl  -0x24(%ebp)
  800198:	e8 66 03 00 00       	call   800503 <InitializeDescending>
  80019d:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a0:	eb 24                	jmp    8001c6 <_main+0x18e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a2:	83 ec 08             	sub    $0x8,%esp
  8001a5:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a8:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ab:	e8 88 03 00 00       	call   800538 <InitializeSemiRandom>
  8001b0:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b3:	eb 11                	jmp    8001c6 <_main+0x18e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 e0             	pushl  -0x20(%ebp)
  8001bb:	ff 75 dc             	pushl  -0x24(%ebp)
  8001be:	e8 75 03 00 00       	call   800538 <InitializeSemiRandom>
  8001c3:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	ff 75 e0             	pushl  -0x20(%ebp)
  8001cc:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cf:	e8 43 01 00 00       	call   800317 <QuickSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 43 02 00 00       	call   800428 <CheckSorted>
  8001e5:	83 c4 10             	add    $0x10,%esp
  8001e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001eb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  8001ef:	75 14                	jne    800205 <_main+0x1cd>
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	68 9c 23 80 00       	push   $0x80239c
  8001f9:	6a 4b                	push   $0x4b
  8001fb:	68 be 23 80 00       	push   $0x8023be
  800200:	e8 b4 05 00 00       	call   8007b9 <_panic>
		else
		{
			sys_waitSemaphore(envID, "1");
  800205:	83 ec 08             	sub    $0x8,%esp
  800208:	68 20 23 80 00       	push   $0x802320
  80020d:	ff 75 e8             	pushl  -0x18(%ebp)
  800210:	e8 73 1b 00 00       	call   801d88 <sys_waitSemaphore>
  800215:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 d0 23 80 00       	push   $0x8023d0
  800220:	e8 48 08 00 00       	call   800a6d <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 04 24 80 00       	push   $0x802404
  800230:	e8 38 08 00 00       	call   800a6d <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800238:	83 ec 0c             	sub    $0xc,%esp
  80023b:	68 38 24 80 00       	push   $0x802438
  800240:	e8 28 08 00 00       	call   800a6d <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "1");
  800248:	83 ec 08             	sub    $0x8,%esp
  80024b:	68 20 23 80 00       	push   $0x802320
  800250:	ff 75 e8             	pushl  -0x18(%ebp)
  800253:	e8 4e 1b 00 00       	call   801da6 <sys_signalSemaphore>
  800258:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "1");
  80025b:	83 ec 08             	sub    $0x8,%esp
  80025e:	68 20 23 80 00       	push   $0x802320
  800263:	ff 75 e8             	pushl  -0x18(%ebp)
  800266:	e8 1d 1b 00 00       	call   801d88 <sys_waitSemaphore>
  80026b:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 6a 24 80 00       	push   $0x80246a
  800276:	e8 f2 07 00 00       	call   800a6d <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	68 20 23 80 00       	push   $0x802320
  800286:	ff 75 e8             	pushl  -0x18(%ebp)
  800289:	e8 18 1b 00 00       	call   801da6 <sys_signalSemaphore>
  80028e:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800291:	83 ec 0c             	sub    $0xc,%esp
  800294:	ff 75 dc             	pushl  -0x24(%ebp)
  800297:	e8 b5 17 00 00       	call   801a51 <free>
  80029c:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  80029f:	83 ec 08             	sub    $0x8,%esp
  8002a2:	68 20 23 80 00       	push   $0x802320
  8002a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8002aa:	e8 d9 1a 00 00       	call   801d88 <sys_waitSemaphore>
  8002af:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002b2:	83 ec 0c             	sub    $0xc,%esp
  8002b5:	68 80 24 80 00       	push   $0x802480
  8002ba:	e8 ae 07 00 00       	call   800a6d <cprintf>
  8002bf:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002c2:	e8 8b 03 00 00       	call   800652 <getchar>
  8002c7:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ca:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002ce:	83 ec 0c             	sub    $0xc,%esp
  8002d1:	50                   	push   %eax
  8002d2:	e8 33 03 00 00       	call   80060a <cputchar>
  8002d7:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002da:	83 ec 0c             	sub    $0xc,%esp
  8002dd:	6a 0a                	push   $0xa
  8002df:	e8 26 03 00 00       	call   80060a <cputchar>
  8002e4:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	6a 0a                	push   $0xa
  8002ec:	e8 19 03 00 00       	call   80060a <cputchar>
  8002f1:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "1");
  8002f4:	83 ec 08             	sub    $0x8,%esp
  8002f7:	68 20 23 80 00       	push   $0x802320
  8002fc:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ff:	e8 a2 1a 00 00       	call   801da6 <sys_signalSemaphore>
  800304:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800307:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80030b:	0f 84 52 fd ff ff    	je     800063 <_main+0x2b>

}
  800311:	90                   	nop
  800312:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800315:	c9                   	leave  
  800316:	c3                   	ret    

00800317 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800317:	55                   	push   %ebp
  800318:	89 e5                	mov    %esp,%ebp
  80031a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80031d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800320:	48                   	dec    %eax
  800321:	50                   	push   %eax
  800322:	6a 00                	push   $0x0
  800324:	ff 75 0c             	pushl  0xc(%ebp)
  800327:	ff 75 08             	pushl  0x8(%ebp)
  80032a:	e8 06 00 00 00       	call   800335 <QSort>
  80032f:	83 c4 10             	add    $0x10,%esp
}
  800332:	90                   	nop
  800333:	c9                   	leave  
  800334:	c3                   	ret    

00800335 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800335:	55                   	push   %ebp
  800336:	89 e5                	mov    %esp,%ebp
  800338:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80033b:	8b 45 10             	mov    0x10(%ebp),%eax
  80033e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800341:	0f 8d de 00 00 00    	jge    800425 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800347:	8b 45 10             	mov    0x10(%ebp),%eax
  80034a:	40                   	inc    %eax
  80034b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80034e:	8b 45 14             	mov    0x14(%ebp),%eax
  800351:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800354:	e9 80 00 00 00       	jmp    8003d9 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800359:	ff 45 f4             	incl   -0xc(%ebp)
  80035c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035f:	3b 45 14             	cmp    0x14(%ebp),%eax
  800362:	7f 2b                	jg     80038f <QSort+0x5a>
  800364:	8b 45 10             	mov    0x10(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 10                	mov    (%eax),%edx
  800375:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800378:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	01 c8                	add    %ecx,%eax
  800384:	8b 00                	mov    (%eax),%eax
  800386:	39 c2                	cmp    %eax,%edx
  800388:	7d cf                	jge    800359 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80038a:	eb 03                	jmp    80038f <QSort+0x5a>
  80038c:	ff 4d f0             	decl   -0x10(%ebp)
  80038f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800392:	3b 45 10             	cmp    0x10(%ebp),%eax
  800395:	7e 26                	jle    8003bd <QSort+0x88>
  800397:	8b 45 10             	mov    0x10(%ebp),%eax
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 10                	mov    (%eax),%edx
  8003a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	39 c2                	cmp    %eax,%edx
  8003bb:	7e cf                	jle    80038c <QSort+0x57>

		if (i <= j)
  8003bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003c3:	7f 14                	jg     8003d9 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003c5:	83 ec 04             	sub    $0x4,%esp
  8003c8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ce:	ff 75 08             	pushl  0x8(%ebp)
  8003d1:	e8 a9 00 00 00       	call   80047f <Swap>
  8003d6:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003df:	0f 8e 77 ff ff ff    	jle    80035c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003e5:	83 ec 04             	sub    $0x4,%esp
  8003e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003eb:	ff 75 10             	pushl  0x10(%ebp)
  8003ee:	ff 75 08             	pushl  0x8(%ebp)
  8003f1:	e8 89 00 00 00       	call   80047f <Swap>
  8003f6:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003fc:	48                   	dec    %eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 10             	pushl  0x10(%ebp)
  800401:	ff 75 0c             	pushl  0xc(%ebp)
  800404:	ff 75 08             	pushl  0x8(%ebp)
  800407:	e8 29 ff ff ff       	call   800335 <QSort>
  80040c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80040f:	ff 75 14             	pushl  0x14(%ebp)
  800412:	ff 75 f4             	pushl  -0xc(%ebp)
  800415:	ff 75 0c             	pushl  0xc(%ebp)
  800418:	ff 75 08             	pushl  0x8(%ebp)
  80041b:	e8 15 ff ff ff       	call   800335 <QSort>
  800420:	83 c4 10             	add    $0x10,%esp
  800423:	eb 01                	jmp    800426 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800425:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800426:	c9                   	leave  
  800427:	c3                   	ret    

00800428 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800428:	55                   	push   %ebp
  800429:	89 e5                	mov    %esp,%ebp
  80042b:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80042e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800435:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80043c:	eb 33                	jmp    800471 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80043e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	01 d0                	add    %edx,%eax
  80044d:	8b 10                	mov    (%eax),%edx
  80044f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800452:	40                   	inc    %eax
  800453:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045a:	8b 45 08             	mov    0x8(%ebp),%eax
  80045d:	01 c8                	add    %ecx,%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	39 c2                	cmp    %eax,%edx
  800463:	7e 09                	jle    80046e <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800465:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80046c:	eb 0c                	jmp    80047a <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80046e:	ff 45 f8             	incl   -0x8(%ebp)
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	48                   	dec    %eax
  800475:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800478:	7f c4                	jg     80043e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80047a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80047d:	c9                   	leave  
  80047e:	c3                   	ret    

0080047f <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80047f:	55                   	push   %ebp
  800480:	89 e5                	mov    %esp,%ebp
  800482:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800485:	8b 45 0c             	mov    0xc(%ebp),%eax
  800488:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	01 d0                	add    %edx,%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	01 c2                	add    %eax,%edx
  8004a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b5:	01 c8                	add    %ecx,%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004cd:	89 02                	mov    %eax,(%edx)
}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004df:	eb 17                	jmp    8004f8 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ee:	01 c2                	add    %eax,%edx
  8004f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f3:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004f5:	ff 45 fc             	incl   -0x4(%ebp)
  8004f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004fe:	7c e1                	jl     8004e1 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800500:	90                   	nop
  800501:	c9                   	leave  
  800502:	c3                   	ret    

00800503 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800503:	55                   	push   %ebp
  800504:	89 e5                	mov    %esp,%ebp
  800506:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800509:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800510:	eb 1b                	jmp    80052d <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051c:	8b 45 08             	mov    0x8(%ebp),%eax
  80051f:	01 c2                	add    %eax,%edx
  800521:	8b 45 0c             	mov    0xc(%ebp),%eax
  800524:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800527:	48                   	dec    %eax
  800528:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052a:	ff 45 fc             	incl   -0x4(%ebp)
  80052d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800530:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800533:	7c dd                	jl     800512 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800535:	90                   	nop
  800536:	c9                   	leave  
  800537:	c3                   	ret    

00800538 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800538:	55                   	push   %ebp
  800539:	89 e5                	mov    %esp,%ebp
  80053b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80053e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800541:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800546:	f7 e9                	imul   %ecx
  800548:	c1 f9 1f             	sar    $0x1f,%ecx
  80054b:	89 d0                	mov    %edx,%eax
  80054d:	29 c8                	sub    %ecx,%eax
  80054f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800552:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800559:	eb 1e                	jmp    800579 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80055b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80055e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80056b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80056e:	99                   	cltd   
  80056f:	f7 7d f8             	idivl  -0x8(%ebp)
  800572:	89 d0                	mov    %edx,%eax
  800574:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800576:	ff 45 fc             	incl   -0x4(%ebp)
  800579:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80057c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80057f:	7c da                	jl     80055b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800581:	90                   	nop
  800582:	c9                   	leave  
  800583:	c3                   	ret    

00800584 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800584:	55                   	push   %ebp
  800585:	89 e5                	mov    %esp,%ebp
  800587:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80058a:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800591:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800598:	eb 42                	jmp    8005dc <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80059a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059d:	99                   	cltd   
  80059e:	f7 7d f0             	idivl  -0x10(%ebp)
  8005a1:	89 d0                	mov    %edx,%eax
  8005a3:	85 c0                	test   %eax,%eax
  8005a5:	75 10                	jne    8005b7 <PrintElements+0x33>
			cprintf("\n");
  8005a7:	83 ec 0c             	sub    $0xc,%esp
  8005aa:	68 9e 24 80 00       	push   $0x80249e
  8005af:	e8 b9 04 00 00       	call   800a6d <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	01 d0                	add    %edx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	83 ec 08             	sub    $0x8,%esp
  8005cb:	50                   	push   %eax
  8005cc:	68 a0 24 80 00       	push   $0x8024a0
  8005d1:	e8 97 04 00 00       	call   800a6d <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005d9:	ff 45 f4             	incl   -0xc(%ebp)
  8005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005df:	48                   	dec    %eax
  8005e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005e3:	7f b5                	jg     80059a <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f2:	01 d0                	add    %edx,%eax
  8005f4:	8b 00                	mov    (%eax),%eax
  8005f6:	83 ec 08             	sub    $0x8,%esp
  8005f9:	50                   	push   %eax
  8005fa:	68 a5 24 80 00       	push   $0x8024a5
  8005ff:	e8 69 04 00 00       	call   800a6d <cprintf>
  800604:	83 c4 10             	add    $0x10,%esp

}
  800607:	90                   	nop
  800608:	c9                   	leave  
  800609:	c3                   	ret    

0080060a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80060a:	55                   	push   %ebp
  80060b:	89 e5                	mov    %esp,%ebp
  80060d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800616:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80061a:	83 ec 0c             	sub    $0xc,%esp
  80061d:	50                   	push   %eax
  80061e:	e8 ec 16 00 00       	call   801d0f <sys_cputc>
  800623:	83 c4 10             	add    $0x10,%esp
}
  800626:	90                   	nop
  800627:	c9                   	leave  
  800628:	c3                   	ret    

00800629 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800629:	55                   	push   %ebp
  80062a:	89 e5                	mov    %esp,%ebp
  80062c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80062f:	e8 a7 16 00 00       	call   801cdb <sys_disable_interrupt>
	char c = ch;
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80063a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063e:	83 ec 0c             	sub    $0xc,%esp
  800641:	50                   	push   %eax
  800642:	e8 c8 16 00 00       	call   801d0f <sys_cputc>
  800647:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80064a:	e8 a6 16 00 00       	call   801cf5 <sys_enable_interrupt>
}
  80064f:	90                   	nop
  800650:	c9                   	leave  
  800651:	c3                   	ret    

00800652 <getchar>:

int
getchar(void)
{
  800652:	55                   	push   %ebp
  800653:	89 e5                	mov    %esp,%ebp
  800655:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800658:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80065f:	eb 08                	jmp    800669 <getchar+0x17>
	{
		c = sys_cgetc();
  800661:	e8 8d 14 00 00       	call   801af3 <sys_cgetc>
  800666:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800669:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80066d:	74 f2                	je     800661 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80066f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <atomic_getchar>:

int
atomic_getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80067a:	e8 5c 16 00 00       	call   801cdb <sys_disable_interrupt>
	int c=0;
  80067f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800686:	eb 08                	jmp    800690 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800688:	e8 66 14 00 00       	call   801af3 <sys_cgetc>
  80068d:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800690:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800694:	74 f2                	je     800688 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800696:	e8 5a 16 00 00       	call   801cf5 <sys_enable_interrupt>
	return c;
  80069b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80069e:	c9                   	leave  
  80069f:	c3                   	ret    

008006a0 <iscons>:

int iscons(int fdnum)
{
  8006a0:	55                   	push   %ebp
  8006a1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006a8:	5d                   	pop    %ebp
  8006a9:	c3                   	ret    

008006aa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006aa:	55                   	push   %ebp
  8006ab:	89 e5                	mov    %esp,%ebp
  8006ad:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b0:	e8 8b 14 00 00       	call   801b40 <sys_getenvindex>
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bb:	89 d0                	mov    %edx,%eax
  8006bd:	c1 e0 02             	shl    $0x2,%eax
  8006c0:	01 d0                	add    %edx,%eax
  8006c2:	01 c0                	add    %eax,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	01 c0                	add    %eax,%eax
  8006c8:	01 d0                	add    %edx,%eax
  8006ca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8006d1:	01 d0                	add    %edx,%eax
  8006d3:	c1 e0 02             	shl    $0x2,%eax
  8006d6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006db:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006e0:	a1 08 30 80 00       	mov    0x803008,%eax
  8006e5:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006eb:	84 c0                	test   %al,%al
  8006ed:	74 0f                	je     8006fe <libmain+0x54>
		binaryname = myEnv->prog_name;
  8006ef:	a1 08 30 80 00       	mov    0x803008,%eax
  8006f4:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006f9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800702:	7e 0a                	jle    80070e <libmain+0x64>
		binaryname = argv[0];
  800704:	8b 45 0c             	mov    0xc(%ebp),%eax
  800707:	8b 00                	mov    (%eax),%eax
  800709:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	ff 75 08             	pushl  0x8(%ebp)
  800717:	e8 1c f9 ff ff       	call   800038 <_main>
  80071c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80071f:	e8 b7 15 00 00       	call   801cdb <sys_disable_interrupt>
	cprintf("**************************************\n");
  800724:	83 ec 0c             	sub    $0xc,%esp
  800727:	68 c4 24 80 00       	push   $0x8024c4
  80072c:	e8 3c 03 00 00       	call   800a6d <cprintf>
  800731:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800734:	a1 08 30 80 00       	mov    0x803008,%eax
  800739:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80073f:	a1 08 30 80 00       	mov    0x803008,%eax
  800744:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80074a:	83 ec 04             	sub    $0x4,%esp
  80074d:	52                   	push   %edx
  80074e:	50                   	push   %eax
  80074f:	68 ec 24 80 00       	push   $0x8024ec
  800754:	e8 14 03 00 00       	call   800a6d <cprintf>
  800759:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80075c:	a1 08 30 80 00       	mov    0x803008,%eax
  800761:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	50                   	push   %eax
  80076b:	68 11 25 80 00       	push   $0x802511
  800770:	e8 f8 02 00 00       	call   800a6d <cprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800778:	83 ec 0c             	sub    $0xc,%esp
  80077b:	68 c4 24 80 00       	push   $0x8024c4
  800780:	e8 e8 02 00 00       	call   800a6d <cprintf>
  800785:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800788:	e8 68 15 00 00       	call   801cf5 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80078d:	e8 19 00 00 00       	call   8007ab <exit>
}
  800792:	90                   	nop
  800793:	c9                   	leave  
  800794:	c3                   	ret    

00800795 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800795:	55                   	push   %ebp
  800796:	89 e5                	mov    %esp,%ebp
  800798:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80079b:	83 ec 0c             	sub    $0xc,%esp
  80079e:	6a 00                	push   $0x0
  8007a0:	e8 67 13 00 00       	call   801b0c <sys_env_destroy>
  8007a5:	83 c4 10             	add    $0x10,%esp
}
  8007a8:	90                   	nop
  8007a9:	c9                   	leave  
  8007aa:	c3                   	ret    

008007ab <exit>:

void
exit(void)
{
  8007ab:	55                   	push   %ebp
  8007ac:	89 e5                	mov    %esp,%ebp
  8007ae:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007b1:	e8 bc 13 00 00       	call   801b72 <sys_env_exit>
}
  8007b6:	90                   	nop
  8007b7:	c9                   	leave  
  8007b8:	c3                   	ret    

008007b9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007b9:	55                   	push   %ebp
  8007ba:	89 e5                	mov    %esp,%ebp
  8007bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007bf:	8d 45 10             	lea    0x10(%ebp),%eax
  8007c2:	83 c0 04             	add    $0x4,%eax
  8007c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007c8:	a1 18 30 80 00       	mov    0x803018,%eax
  8007cd:	85 c0                	test   %eax,%eax
  8007cf:	74 16                	je     8007e7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007d1:	a1 18 30 80 00       	mov    0x803018,%eax
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	50                   	push   %eax
  8007da:	68 28 25 80 00       	push   $0x802528
  8007df:	e8 89 02 00 00       	call   800a6d <cprintf>
  8007e4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007e7:	a1 00 30 80 00       	mov    0x803000,%eax
  8007ec:	ff 75 0c             	pushl  0xc(%ebp)
  8007ef:	ff 75 08             	pushl  0x8(%ebp)
  8007f2:	50                   	push   %eax
  8007f3:	68 2d 25 80 00       	push   $0x80252d
  8007f8:	e8 70 02 00 00       	call   800a6d <cprintf>
  8007fd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800800:	8b 45 10             	mov    0x10(%ebp),%eax
  800803:	83 ec 08             	sub    $0x8,%esp
  800806:	ff 75 f4             	pushl  -0xc(%ebp)
  800809:	50                   	push   %eax
  80080a:	e8 f3 01 00 00       	call   800a02 <vcprintf>
  80080f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	6a 00                	push   $0x0
  800817:	68 49 25 80 00       	push   $0x802549
  80081c:	e8 e1 01 00 00       	call   800a02 <vcprintf>
  800821:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800824:	e8 82 ff ff ff       	call   8007ab <exit>

	// should not return here
	while (1) ;
  800829:	eb fe                	jmp    800829 <_panic+0x70>

0080082b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
  80082e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800831:	a1 08 30 80 00       	mov    0x803008,%eax
  800836:	8b 50 74             	mov    0x74(%eax),%edx
  800839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083c:	39 c2                	cmp    %eax,%edx
  80083e:	74 14                	je     800854 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800840:	83 ec 04             	sub    $0x4,%esp
  800843:	68 4c 25 80 00       	push   $0x80254c
  800848:	6a 26                	push   $0x26
  80084a:	68 98 25 80 00       	push   $0x802598
  80084f:	e8 65 ff ff ff       	call   8007b9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800854:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80085b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800862:	e9 c2 00 00 00       	jmp    800929 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800867:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800871:	8b 45 08             	mov    0x8(%ebp),%eax
  800874:	01 d0                	add    %edx,%eax
  800876:	8b 00                	mov    (%eax),%eax
  800878:	85 c0                	test   %eax,%eax
  80087a:	75 08                	jne    800884 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80087c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80087f:	e9 a2 00 00 00       	jmp    800926 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800884:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80088b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800892:	eb 69                	jmp    8008fd <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800894:	a1 08 30 80 00       	mov    0x803008,%eax
  800899:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80089f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008a2:	89 d0                	mov    %edx,%eax
  8008a4:	01 c0                	add    %eax,%eax
  8008a6:	01 d0                	add    %edx,%eax
  8008a8:	c1 e0 02             	shl    $0x2,%eax
  8008ab:	01 c8                	add    %ecx,%eax
  8008ad:	8a 40 04             	mov    0x4(%eax),%al
  8008b0:	84 c0                	test   %al,%al
  8008b2:	75 46                	jne    8008fa <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008b4:	a1 08 30 80 00       	mov    0x803008,%eax
  8008b9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008c2:	89 d0                	mov    %edx,%eax
  8008c4:	01 c0                	add    %eax,%eax
  8008c6:	01 d0                	add    %edx,%eax
  8008c8:	c1 e0 02             	shl    $0x2,%eax
  8008cb:	01 c8                	add    %ecx,%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008da:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008df:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	01 c8                	add    %ecx,%eax
  8008eb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008ed:	39 c2                	cmp    %eax,%edx
  8008ef:	75 09                	jne    8008fa <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008f1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008f8:	eb 12                	jmp    80090c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008fa:	ff 45 e8             	incl   -0x18(%ebp)
  8008fd:	a1 08 30 80 00       	mov    0x803008,%eax
  800902:	8b 50 74             	mov    0x74(%eax),%edx
  800905:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800908:	39 c2                	cmp    %eax,%edx
  80090a:	77 88                	ja     800894 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80090c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800910:	75 14                	jne    800926 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800912:	83 ec 04             	sub    $0x4,%esp
  800915:	68 a4 25 80 00       	push   $0x8025a4
  80091a:	6a 3a                	push   $0x3a
  80091c:	68 98 25 80 00       	push   $0x802598
  800921:	e8 93 fe ff ff       	call   8007b9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800926:	ff 45 f0             	incl   -0x10(%ebp)
  800929:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80092f:	0f 8c 32 ff ff ff    	jl     800867 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800935:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80093c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800943:	eb 26                	jmp    80096b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800945:	a1 08 30 80 00       	mov    0x803008,%eax
  80094a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800950:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800953:	89 d0                	mov    %edx,%eax
  800955:	01 c0                	add    %eax,%eax
  800957:	01 d0                	add    %edx,%eax
  800959:	c1 e0 02             	shl    $0x2,%eax
  80095c:	01 c8                	add    %ecx,%eax
  80095e:	8a 40 04             	mov    0x4(%eax),%al
  800961:	3c 01                	cmp    $0x1,%al
  800963:	75 03                	jne    800968 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800965:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800968:	ff 45 e0             	incl   -0x20(%ebp)
  80096b:	a1 08 30 80 00       	mov    0x803008,%eax
  800970:	8b 50 74             	mov    0x74(%eax),%edx
  800973:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800976:	39 c2                	cmp    %eax,%edx
  800978:	77 cb                	ja     800945 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80097a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80097d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800980:	74 14                	je     800996 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800982:	83 ec 04             	sub    $0x4,%esp
  800985:	68 f8 25 80 00       	push   $0x8025f8
  80098a:	6a 44                	push   $0x44
  80098c:	68 98 25 80 00       	push   $0x802598
  800991:	e8 23 fe ff ff       	call   8007b9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800996:	90                   	nop
  800997:	c9                   	leave  
  800998:	c3                   	ret    

00800999 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800999:	55                   	push   %ebp
  80099a:	89 e5                	mov    %esp,%ebp
  80099c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80099f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a2:	8b 00                	mov    (%eax),%eax
  8009a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8009a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009aa:	89 0a                	mov    %ecx,(%edx)
  8009ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8009af:	88 d1                	mov    %dl,%cl
  8009b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bb:	8b 00                	mov    (%eax),%eax
  8009bd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009c2:	75 2c                	jne    8009f0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009c4:	a0 0c 30 80 00       	mov    0x80300c,%al
  8009c9:	0f b6 c0             	movzbl %al,%eax
  8009cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cf:	8b 12                	mov    (%edx),%edx
  8009d1:	89 d1                	mov    %edx,%ecx
  8009d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d6:	83 c2 08             	add    $0x8,%edx
  8009d9:	83 ec 04             	sub    $0x4,%esp
  8009dc:	50                   	push   %eax
  8009dd:	51                   	push   %ecx
  8009de:	52                   	push   %edx
  8009df:	e8 e6 10 00 00       	call   801aca <sys_cputs>
  8009e4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f3:	8b 40 04             	mov    0x4(%eax),%eax
  8009f6:	8d 50 01             	lea    0x1(%eax),%edx
  8009f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009ff:	90                   	nop
  800a00:	c9                   	leave  
  800a01:	c3                   	ret    

00800a02 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a02:	55                   	push   %ebp
  800a03:	89 e5                	mov    %esp,%ebp
  800a05:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a0b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a12:	00 00 00 
	b.cnt = 0;
  800a15:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a1c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	ff 75 08             	pushl  0x8(%ebp)
  800a25:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a2b:	50                   	push   %eax
  800a2c:	68 99 09 80 00       	push   $0x800999
  800a31:	e8 11 02 00 00       	call   800c47 <vprintfmt>
  800a36:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a39:	a0 0c 30 80 00       	mov    0x80300c,%al
  800a3e:	0f b6 c0             	movzbl %al,%eax
  800a41:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a47:	83 ec 04             	sub    $0x4,%esp
  800a4a:	50                   	push   %eax
  800a4b:	52                   	push   %edx
  800a4c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a52:	83 c0 08             	add    $0x8,%eax
  800a55:	50                   	push   %eax
  800a56:	e8 6f 10 00 00       	call   801aca <sys_cputs>
  800a5b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a5e:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  800a65:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a6b:	c9                   	leave  
  800a6c:	c3                   	ret    

00800a6d <cprintf>:

int cprintf(const char *fmt, ...) {
  800a6d:	55                   	push   %ebp
  800a6e:	89 e5                	mov    %esp,%ebp
  800a70:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a73:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  800a7a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a80:	8b 45 08             	mov    0x8(%ebp),%eax
  800a83:	83 ec 08             	sub    $0x8,%esp
  800a86:	ff 75 f4             	pushl  -0xc(%ebp)
  800a89:	50                   	push   %eax
  800a8a:	e8 73 ff ff ff       	call   800a02 <vcprintf>
  800a8f:	83 c4 10             	add    $0x10,%esp
  800a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a98:	c9                   	leave  
  800a99:	c3                   	ret    

00800a9a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a9a:	55                   	push   %ebp
  800a9b:	89 e5                	mov    %esp,%ebp
  800a9d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800aa0:	e8 36 12 00 00       	call   801cdb <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aa5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	83 ec 08             	sub    $0x8,%esp
  800ab1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab4:	50                   	push   %eax
  800ab5:	e8 48 ff ff ff       	call   800a02 <vcprintf>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ac0:	e8 30 12 00 00       	call   801cf5 <sys_enable_interrupt>
	return cnt;
  800ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	53                   	push   %ebx
  800ace:	83 ec 14             	sub    $0x14,%esp
  800ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad7:	8b 45 14             	mov    0x14(%ebp),%eax
  800ada:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800add:	8b 45 18             	mov    0x18(%ebp),%eax
  800ae0:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae8:	77 55                	ja     800b3f <printnum+0x75>
  800aea:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aed:	72 05                	jb     800af4 <printnum+0x2a>
  800aef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800af2:	77 4b                	ja     800b3f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800af4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800af7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800afa:	8b 45 18             	mov    0x18(%ebp),%eax
  800afd:	ba 00 00 00 00       	mov    $0x0,%edx
  800b02:	52                   	push   %edx
  800b03:	50                   	push   %eax
  800b04:	ff 75 f4             	pushl  -0xc(%ebp)
  800b07:	ff 75 f0             	pushl  -0x10(%ebp)
  800b0a:	e8 ad 15 00 00       	call   8020bc <__udivdi3>
  800b0f:	83 c4 10             	add    $0x10,%esp
  800b12:	83 ec 04             	sub    $0x4,%esp
  800b15:	ff 75 20             	pushl  0x20(%ebp)
  800b18:	53                   	push   %ebx
  800b19:	ff 75 18             	pushl  0x18(%ebp)
  800b1c:	52                   	push   %edx
  800b1d:	50                   	push   %eax
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	ff 75 08             	pushl  0x8(%ebp)
  800b24:	e8 a1 ff ff ff       	call   800aca <printnum>
  800b29:	83 c4 20             	add    $0x20,%esp
  800b2c:	eb 1a                	jmp    800b48 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b2e:	83 ec 08             	sub    $0x8,%esp
  800b31:	ff 75 0c             	pushl  0xc(%ebp)
  800b34:	ff 75 20             	pushl  0x20(%ebp)
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b3f:	ff 4d 1c             	decl   0x1c(%ebp)
  800b42:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b46:	7f e6                	jg     800b2e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b48:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b4b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b56:	53                   	push   %ebx
  800b57:	51                   	push   %ecx
  800b58:	52                   	push   %edx
  800b59:	50                   	push   %eax
  800b5a:	e8 6d 16 00 00       	call   8021cc <__umoddi3>
  800b5f:	83 c4 10             	add    $0x10,%esp
  800b62:	05 74 28 80 00       	add    $0x802874,%eax
  800b67:	8a 00                	mov    (%eax),%al
  800b69:	0f be c0             	movsbl %al,%eax
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	50                   	push   %eax
  800b73:	8b 45 08             	mov    0x8(%ebp),%eax
  800b76:	ff d0                	call   *%eax
  800b78:	83 c4 10             	add    $0x10,%esp
}
  800b7b:	90                   	nop
  800b7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b7f:	c9                   	leave  
  800b80:	c3                   	ret    

00800b81 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b84:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b88:	7e 1c                	jle    800ba6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	8d 50 08             	lea    0x8(%eax),%edx
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	89 10                	mov    %edx,(%eax)
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8b 00                	mov    (%eax),%eax
  800b9c:	83 e8 08             	sub    $0x8,%eax
  800b9f:	8b 50 04             	mov    0x4(%eax),%edx
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	eb 40                	jmp    800be6 <getuint+0x65>
	else if (lflag)
  800ba6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800baa:	74 1e                	je     800bca <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8b 00                	mov    (%eax),%eax
  800bb1:	8d 50 04             	lea    0x4(%eax),%edx
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	89 10                	mov    %edx,(%eax)
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	8b 00                	mov    (%eax),%eax
  800bbe:	83 e8 04             	sub    $0x4,%eax
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	ba 00 00 00 00       	mov    $0x0,%edx
  800bc8:	eb 1c                	jmp    800be6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	8d 50 04             	lea    0x4(%eax),%edx
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	89 10                	mov    %edx,(%eax)
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	8b 00                	mov    (%eax),%eax
  800bdc:	83 e8 04             	sub    $0x4,%eax
  800bdf:	8b 00                	mov    (%eax),%eax
  800be1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800be6:	5d                   	pop    %ebp
  800be7:	c3                   	ret    

00800be8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800beb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bef:	7e 1c                	jle    800c0d <getint+0x25>
		return va_arg(*ap, long long);
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	8d 50 08             	lea    0x8(%eax),%edx
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	89 10                	mov    %edx,(%eax)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8b 00                	mov    (%eax),%eax
  800c03:	83 e8 08             	sub    $0x8,%eax
  800c06:	8b 50 04             	mov    0x4(%eax),%edx
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	eb 38                	jmp    800c45 <getint+0x5d>
	else if (lflag)
  800c0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c11:	74 1a                	je     800c2d <getint+0x45>
		return va_arg(*ap, long);
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	8d 50 04             	lea    0x4(%eax),%edx
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	89 10                	mov    %edx,(%eax)
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	83 e8 04             	sub    $0x4,%eax
  800c28:	8b 00                	mov    (%eax),%eax
  800c2a:	99                   	cltd   
  800c2b:	eb 18                	jmp    800c45 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	8d 50 04             	lea    0x4(%eax),%edx
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	89 10                	mov    %edx,(%eax)
  800c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3d:	8b 00                	mov    (%eax),%eax
  800c3f:	83 e8 04             	sub    $0x4,%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	99                   	cltd   
}
  800c45:	5d                   	pop    %ebp
  800c46:	c3                   	ret    

00800c47 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c47:	55                   	push   %ebp
  800c48:	89 e5                	mov    %esp,%ebp
  800c4a:	56                   	push   %esi
  800c4b:	53                   	push   %ebx
  800c4c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c4f:	eb 17                	jmp    800c68 <vprintfmt+0x21>
			if (ch == '\0')
  800c51:	85 db                	test   %ebx,%ebx
  800c53:	0f 84 af 03 00 00    	je     801008 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c59:	83 ec 08             	sub    $0x8,%esp
  800c5c:	ff 75 0c             	pushl  0xc(%ebp)
  800c5f:	53                   	push   %ebx
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	ff d0                	call   *%eax
  800c65:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c68:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6b:	8d 50 01             	lea    0x1(%eax),%edx
  800c6e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c71:	8a 00                	mov    (%eax),%al
  800c73:	0f b6 d8             	movzbl %al,%ebx
  800c76:	83 fb 25             	cmp    $0x25,%ebx
  800c79:	75 d6                	jne    800c51 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c7b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c7f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c86:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c8d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c94:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9e:	8d 50 01             	lea    0x1(%eax),%edx
  800ca1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	0f b6 d8             	movzbl %al,%ebx
  800ca9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cac:	83 f8 55             	cmp    $0x55,%eax
  800caf:	0f 87 2b 03 00 00    	ja     800fe0 <vprintfmt+0x399>
  800cb5:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  800cbc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cbe:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cc2:	eb d7                	jmp    800c9b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cc4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cc8:	eb d1                	jmp    800c9b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cd4:	89 d0                	mov    %edx,%eax
  800cd6:	c1 e0 02             	shl    $0x2,%eax
  800cd9:	01 d0                	add    %edx,%eax
  800cdb:	01 c0                	add    %eax,%eax
  800cdd:	01 d8                	add    %ebx,%eax
  800cdf:	83 e8 30             	sub    $0x30,%eax
  800ce2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ced:	83 fb 2f             	cmp    $0x2f,%ebx
  800cf0:	7e 3e                	jle    800d30 <vprintfmt+0xe9>
  800cf2:	83 fb 39             	cmp    $0x39,%ebx
  800cf5:	7f 39                	jg     800d30 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cfa:	eb d5                	jmp    800cd1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 c0 04             	add    $0x4,%eax
  800d02:	89 45 14             	mov    %eax,0x14(%ebp)
  800d05:	8b 45 14             	mov    0x14(%ebp),%eax
  800d08:	83 e8 04             	sub    $0x4,%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d10:	eb 1f                	jmp    800d31 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d12:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d16:	79 83                	jns    800c9b <vprintfmt+0x54>
				width = 0;
  800d18:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d1f:	e9 77 ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d24:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d2b:	e9 6b ff ff ff       	jmp    800c9b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d30:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d35:	0f 89 60 ff ff ff    	jns    800c9b <vprintfmt+0x54>
				width = precision, precision = -1;
  800d3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d41:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d48:	e9 4e ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d4d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d50:	e9 46 ff ff ff       	jmp    800c9b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d55:	8b 45 14             	mov    0x14(%ebp),%eax
  800d58:	83 c0 04             	add    $0x4,%eax
  800d5b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d61:	83 e8 04             	sub    $0x4,%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	ff 75 0c             	pushl  0xc(%ebp)
  800d6c:	50                   	push   %eax
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	ff d0                	call   *%eax
  800d72:	83 c4 10             	add    $0x10,%esp
			break;
  800d75:	e9 89 02 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7d:	83 c0 04             	add    $0x4,%eax
  800d80:	89 45 14             	mov    %eax,0x14(%ebp)
  800d83:	8b 45 14             	mov    0x14(%ebp),%eax
  800d86:	83 e8 04             	sub    $0x4,%eax
  800d89:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d8b:	85 db                	test   %ebx,%ebx
  800d8d:	79 02                	jns    800d91 <vprintfmt+0x14a>
				err = -err;
  800d8f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d91:	83 fb 64             	cmp    $0x64,%ebx
  800d94:	7f 0b                	jg     800da1 <vprintfmt+0x15a>
  800d96:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800d9d:	85 f6                	test   %esi,%esi
  800d9f:	75 19                	jne    800dba <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800da1:	53                   	push   %ebx
  800da2:	68 85 28 80 00       	push   $0x802885
  800da7:	ff 75 0c             	pushl  0xc(%ebp)
  800daa:	ff 75 08             	pushl  0x8(%ebp)
  800dad:	e8 5e 02 00 00       	call   801010 <printfmt>
  800db2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800db5:	e9 49 02 00 00       	jmp    801003 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dba:	56                   	push   %esi
  800dbb:	68 8e 28 80 00       	push   $0x80288e
  800dc0:	ff 75 0c             	pushl  0xc(%ebp)
  800dc3:	ff 75 08             	pushl  0x8(%ebp)
  800dc6:	e8 45 02 00 00       	call   801010 <printfmt>
  800dcb:	83 c4 10             	add    $0x10,%esp
			break;
  800dce:	e9 30 02 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd6:	83 c0 04             	add    $0x4,%eax
  800dd9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ddc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ddf:	83 e8 04             	sub    $0x4,%eax
  800de2:	8b 30                	mov    (%eax),%esi
  800de4:	85 f6                	test   %esi,%esi
  800de6:	75 05                	jne    800ded <vprintfmt+0x1a6>
				p = "(null)";
  800de8:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  800ded:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df1:	7e 6d                	jle    800e60 <vprintfmt+0x219>
  800df3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800df7:	74 67                	je     800e60 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800df9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dfc:	83 ec 08             	sub    $0x8,%esp
  800dff:	50                   	push   %eax
  800e00:	56                   	push   %esi
  800e01:	e8 12 05 00 00       	call   801318 <strnlen>
  800e06:	83 c4 10             	add    $0x10,%esp
  800e09:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e0c:	eb 16                	jmp    800e24 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e0e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e12:	83 ec 08             	sub    $0x8,%esp
  800e15:	ff 75 0c             	pushl  0xc(%ebp)
  800e18:	50                   	push   %eax
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	ff d0                	call   *%eax
  800e1e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e21:	ff 4d e4             	decl   -0x1c(%ebp)
  800e24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e28:	7f e4                	jg     800e0e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e2a:	eb 34                	jmp    800e60 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e2c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e30:	74 1c                	je     800e4e <vprintfmt+0x207>
  800e32:	83 fb 1f             	cmp    $0x1f,%ebx
  800e35:	7e 05                	jle    800e3c <vprintfmt+0x1f5>
  800e37:	83 fb 7e             	cmp    $0x7e,%ebx
  800e3a:	7e 12                	jle    800e4e <vprintfmt+0x207>
					putch('?', putdat);
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	6a 3f                	push   $0x3f
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	ff d0                	call   *%eax
  800e49:	83 c4 10             	add    $0x10,%esp
  800e4c:	eb 0f                	jmp    800e5d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	53                   	push   %ebx
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	ff d0                	call   *%eax
  800e5a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e5d:	ff 4d e4             	decl   -0x1c(%ebp)
  800e60:	89 f0                	mov    %esi,%eax
  800e62:	8d 70 01             	lea    0x1(%eax),%esi
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	0f be d8             	movsbl %al,%ebx
  800e6a:	85 db                	test   %ebx,%ebx
  800e6c:	74 24                	je     800e92 <vprintfmt+0x24b>
  800e6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e72:	78 b8                	js     800e2c <vprintfmt+0x1e5>
  800e74:	ff 4d e0             	decl   -0x20(%ebp)
  800e77:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e7b:	79 af                	jns    800e2c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e7d:	eb 13                	jmp    800e92 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e7f:	83 ec 08             	sub    $0x8,%esp
  800e82:	ff 75 0c             	pushl  0xc(%ebp)
  800e85:	6a 20                	push   $0x20
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	ff d0                	call   *%eax
  800e8c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e8f:	ff 4d e4             	decl   -0x1c(%ebp)
  800e92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e96:	7f e7                	jg     800e7f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e98:	e9 66 01 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e9d:	83 ec 08             	sub    $0x8,%esp
  800ea0:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea3:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea6:	50                   	push   %eax
  800ea7:	e8 3c fd ff ff       	call   800be8 <getint>
  800eac:	83 c4 10             	add    $0x10,%esp
  800eaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ebb:	85 d2                	test   %edx,%edx
  800ebd:	79 23                	jns    800ee2 <vprintfmt+0x29b>
				putch('-', putdat);
  800ebf:	83 ec 08             	sub    $0x8,%esp
  800ec2:	ff 75 0c             	pushl  0xc(%ebp)
  800ec5:	6a 2d                	push   $0x2d
  800ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eca:	ff d0                	call   *%eax
  800ecc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed5:	f7 d8                	neg    %eax
  800ed7:	83 d2 00             	adc    $0x0,%edx
  800eda:	f7 da                	neg    %edx
  800edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800edf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ee2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ee9:	e9 bc 00 00 00       	jmp    800faa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef7:	50                   	push   %eax
  800ef8:	e8 84 fc ff ff       	call   800b81 <getuint>
  800efd:	83 c4 10             	add    $0x10,%esp
  800f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f03:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f06:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f0d:	e9 98 00 00 00       	jmp    800faa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f12:	83 ec 08             	sub    $0x8,%esp
  800f15:	ff 75 0c             	pushl  0xc(%ebp)
  800f18:	6a 58                	push   $0x58
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	ff d0                	call   *%eax
  800f1f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f22:	83 ec 08             	sub    $0x8,%esp
  800f25:	ff 75 0c             	pushl  0xc(%ebp)
  800f28:	6a 58                	push   $0x58
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f32:	83 ec 08             	sub    $0x8,%esp
  800f35:	ff 75 0c             	pushl  0xc(%ebp)
  800f38:	6a 58                	push   $0x58
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	ff d0                	call   *%eax
  800f3f:	83 c4 10             	add    $0x10,%esp
			break;
  800f42:	e9 bc 00 00 00       	jmp    801003 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f47:	83 ec 08             	sub    $0x8,%esp
  800f4a:	ff 75 0c             	pushl  0xc(%ebp)
  800f4d:	6a 30                	push   $0x30
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	ff d0                	call   *%eax
  800f54:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f57:	83 ec 08             	sub    $0x8,%esp
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	6a 78                	push   $0x78
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	ff d0                	call   *%eax
  800f64:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f67:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6a:	83 c0 04             	add    $0x4,%eax
  800f6d:	89 45 14             	mov    %eax,0x14(%ebp)
  800f70:	8b 45 14             	mov    0x14(%ebp),%eax
  800f73:	83 e8 04             	sub    $0x4,%eax
  800f76:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f82:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f89:	eb 1f                	jmp    800faa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 e8             	pushl  -0x18(%ebp)
  800f91:	8d 45 14             	lea    0x14(%ebp),%eax
  800f94:	50                   	push   %eax
  800f95:	e8 e7 fb ff ff       	call   800b81 <getuint>
  800f9a:	83 c4 10             	add    $0x10,%esp
  800f9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fa3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800faa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb1:	83 ec 04             	sub    $0x4,%esp
  800fb4:	52                   	push   %edx
  800fb5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fb8:	50                   	push   %eax
  800fb9:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbc:	ff 75 f0             	pushl  -0x10(%ebp)
  800fbf:	ff 75 0c             	pushl  0xc(%ebp)
  800fc2:	ff 75 08             	pushl  0x8(%ebp)
  800fc5:	e8 00 fb ff ff       	call   800aca <printnum>
  800fca:	83 c4 20             	add    $0x20,%esp
			break;
  800fcd:	eb 34                	jmp    801003 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fcf:	83 ec 08             	sub    $0x8,%esp
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	53                   	push   %ebx
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	ff d0                	call   *%eax
  800fdb:	83 c4 10             	add    $0x10,%esp
			break;
  800fde:	eb 23                	jmp    801003 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fe0:	83 ec 08             	sub    $0x8,%esp
  800fe3:	ff 75 0c             	pushl  0xc(%ebp)
  800fe6:	6a 25                	push   $0x25
  800fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  800feb:	ff d0                	call   *%eax
  800fed:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ff0:	ff 4d 10             	decl   0x10(%ebp)
  800ff3:	eb 03                	jmp    800ff8 <vprintfmt+0x3b1>
  800ff5:	ff 4d 10             	decl   0x10(%ebp)
  800ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffb:	48                   	dec    %eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	3c 25                	cmp    $0x25,%al
  801000:	75 f3                	jne    800ff5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801002:	90                   	nop
		}
	}
  801003:	e9 47 fc ff ff       	jmp    800c4f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801008:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801009:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80100c:	5b                   	pop    %ebx
  80100d:	5e                   	pop    %esi
  80100e:	5d                   	pop    %ebp
  80100f:	c3                   	ret    

00801010 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801010:	55                   	push   %ebp
  801011:	89 e5                	mov    %esp,%ebp
  801013:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801016:	8d 45 10             	lea    0x10(%ebp),%eax
  801019:	83 c0 04             	add    $0x4,%eax
  80101c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	ff 75 f4             	pushl  -0xc(%ebp)
  801025:	50                   	push   %eax
  801026:	ff 75 0c             	pushl  0xc(%ebp)
  801029:	ff 75 08             	pushl  0x8(%ebp)
  80102c:	e8 16 fc ff ff       	call   800c47 <vprintfmt>
  801031:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801034:	90                   	nop
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	8b 40 08             	mov    0x8(%eax),%eax
  801040:	8d 50 01             	lea    0x1(%eax),%edx
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801049:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104c:	8b 10                	mov    (%eax),%edx
  80104e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801051:	8b 40 04             	mov    0x4(%eax),%eax
  801054:	39 c2                	cmp    %eax,%edx
  801056:	73 12                	jae    80106a <sprintputch+0x33>
		*b->buf++ = ch;
  801058:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105b:	8b 00                	mov    (%eax),%eax
  80105d:	8d 48 01             	lea    0x1(%eax),%ecx
  801060:	8b 55 0c             	mov    0xc(%ebp),%edx
  801063:	89 0a                	mov    %ecx,(%edx)
  801065:	8b 55 08             	mov    0x8(%ebp),%edx
  801068:	88 10                	mov    %dl,(%eax)
}
  80106a:	90                   	nop
  80106b:	5d                   	pop    %ebp
  80106c:	c3                   	ret    

0080106d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80106d:	55                   	push   %ebp
  80106e:	89 e5                	mov    %esp,%ebp
  801070:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801079:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	01 d0                	add    %edx,%eax
  801084:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801087:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80108e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801092:	74 06                	je     80109a <vsnprintf+0x2d>
  801094:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801098:	7f 07                	jg     8010a1 <vsnprintf+0x34>
		return -E_INVAL;
  80109a:	b8 03 00 00 00       	mov    $0x3,%eax
  80109f:	eb 20                	jmp    8010c1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010a1:	ff 75 14             	pushl  0x14(%ebp)
  8010a4:	ff 75 10             	pushl  0x10(%ebp)
  8010a7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010aa:	50                   	push   %eax
  8010ab:	68 37 10 80 00       	push   $0x801037
  8010b0:	e8 92 fb ff ff       	call   800c47 <vprintfmt>
  8010b5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010bb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010c1:	c9                   	leave  
  8010c2:	c3                   	ret    

008010c3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010c3:	55                   	push   %ebp
  8010c4:	89 e5                	mov    %esp,%ebp
  8010c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010c9:	8d 45 10             	lea    0x10(%ebp),%eax
  8010cc:	83 c0 04             	add    $0x4,%eax
  8010cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d8:	50                   	push   %eax
  8010d9:	ff 75 0c             	pushl  0xc(%ebp)
  8010dc:	ff 75 08             	pushl  0x8(%ebp)
  8010df:	e8 89 ff ff ff       	call   80106d <vsnprintf>
  8010e4:	83 c4 10             	add    $0x10,%esp
  8010e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010ed:	c9                   	leave  
  8010ee:	c3                   	ret    

008010ef <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
  8010f2:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f9:	74 13                	je     80110e <readline+0x1f>
		cprintf("%s", prompt);
  8010fb:	83 ec 08             	sub    $0x8,%esp
  8010fe:	ff 75 08             	pushl  0x8(%ebp)
  801101:	68 f0 29 80 00       	push   $0x8029f0
  801106:	e8 62 f9 ff ff       	call   800a6d <cprintf>
  80110b:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80110e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801115:	83 ec 0c             	sub    $0xc,%esp
  801118:	6a 00                	push   $0x0
  80111a:	e8 81 f5 ff ff       	call   8006a0 <iscons>
  80111f:	83 c4 10             	add    $0x10,%esp
  801122:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801125:	e8 28 f5 ff ff       	call   800652 <getchar>
  80112a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80112d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801131:	79 22                	jns    801155 <readline+0x66>
			if (c != -E_EOF)
  801133:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801137:	0f 84 ad 00 00 00    	je     8011ea <readline+0xfb>
				cprintf("read error: %e\n", c);
  80113d:	83 ec 08             	sub    $0x8,%esp
  801140:	ff 75 ec             	pushl  -0x14(%ebp)
  801143:	68 f3 29 80 00       	push   $0x8029f3
  801148:	e8 20 f9 ff ff       	call   800a6d <cprintf>
  80114d:	83 c4 10             	add    $0x10,%esp
			return;
  801150:	e9 95 00 00 00       	jmp    8011ea <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801155:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801159:	7e 34                	jle    80118f <readline+0xa0>
  80115b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801162:	7f 2b                	jg     80118f <readline+0xa0>
			if (echoing)
  801164:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801168:	74 0e                	je     801178 <readline+0x89>
				cputchar(c);
  80116a:	83 ec 0c             	sub    $0xc,%esp
  80116d:	ff 75 ec             	pushl  -0x14(%ebp)
  801170:	e8 95 f4 ff ff       	call   80060a <cputchar>
  801175:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801178:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80117b:	8d 50 01             	lea    0x1(%eax),%edx
  80117e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801181:	89 c2                	mov    %eax,%edx
  801183:	8b 45 0c             	mov    0xc(%ebp),%eax
  801186:	01 d0                	add    %edx,%eax
  801188:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80118b:	88 10                	mov    %dl,(%eax)
  80118d:	eb 56                	jmp    8011e5 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80118f:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801193:	75 1f                	jne    8011b4 <readline+0xc5>
  801195:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801199:	7e 19                	jle    8011b4 <readline+0xc5>
			if (echoing)
  80119b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80119f:	74 0e                	je     8011af <readline+0xc0>
				cputchar(c);
  8011a1:	83 ec 0c             	sub    $0xc,%esp
  8011a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a7:	e8 5e f4 ff ff       	call   80060a <cputchar>
  8011ac:	83 c4 10             	add    $0x10,%esp

			i--;
  8011af:	ff 4d f4             	decl   -0xc(%ebp)
  8011b2:	eb 31                	jmp    8011e5 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011b4:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011b8:	74 0a                	je     8011c4 <readline+0xd5>
  8011ba:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011be:	0f 85 61 ff ff ff    	jne    801125 <readline+0x36>
			if (echoing)
  8011c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c8:	74 0e                	je     8011d8 <readline+0xe9>
				cputchar(c);
  8011ca:	83 ec 0c             	sub    $0xc,%esp
  8011cd:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d0:	e8 35 f4 ff ff       	call   80060a <cputchar>
  8011d5:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011de:	01 d0                	add    %edx,%eax
  8011e0:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011e3:	eb 06                	jmp    8011eb <readline+0xfc>
		}
	}
  8011e5:	e9 3b ff ff ff       	jmp    801125 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011ea:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
  8011f0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011f3:	e8 e3 0a 00 00       	call   801cdb <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011f8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011fc:	74 13                	je     801211 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011fe:	83 ec 08             	sub    $0x8,%esp
  801201:	ff 75 08             	pushl  0x8(%ebp)
  801204:	68 f0 29 80 00       	push   $0x8029f0
  801209:	e8 5f f8 ff ff       	call   800a6d <cprintf>
  80120e:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801211:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801218:	83 ec 0c             	sub    $0xc,%esp
  80121b:	6a 00                	push   $0x0
  80121d:	e8 7e f4 ff ff       	call   8006a0 <iscons>
  801222:	83 c4 10             	add    $0x10,%esp
  801225:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801228:	e8 25 f4 ff ff       	call   800652 <getchar>
  80122d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801230:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801234:	79 23                	jns    801259 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801236:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80123a:	74 13                	je     80124f <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80123c:	83 ec 08             	sub    $0x8,%esp
  80123f:	ff 75 ec             	pushl  -0x14(%ebp)
  801242:	68 f3 29 80 00       	push   $0x8029f3
  801247:	e8 21 f8 ff ff       	call   800a6d <cprintf>
  80124c:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80124f:	e8 a1 0a 00 00       	call   801cf5 <sys_enable_interrupt>
			return;
  801254:	e9 9a 00 00 00       	jmp    8012f3 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801259:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80125d:	7e 34                	jle    801293 <atomic_readline+0xa6>
  80125f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801266:	7f 2b                	jg     801293 <atomic_readline+0xa6>
			if (echoing)
  801268:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80126c:	74 0e                	je     80127c <atomic_readline+0x8f>
				cputchar(c);
  80126e:	83 ec 0c             	sub    $0xc,%esp
  801271:	ff 75 ec             	pushl  -0x14(%ebp)
  801274:	e8 91 f3 ff ff       	call   80060a <cputchar>
  801279:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80127c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80127f:	8d 50 01             	lea    0x1(%eax),%edx
  801282:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801285:	89 c2                	mov    %eax,%edx
  801287:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128a:	01 d0                	add    %edx,%eax
  80128c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80128f:	88 10                	mov    %dl,(%eax)
  801291:	eb 5b                	jmp    8012ee <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801293:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801297:	75 1f                	jne    8012b8 <atomic_readline+0xcb>
  801299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80129d:	7e 19                	jle    8012b8 <atomic_readline+0xcb>
			if (echoing)
  80129f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012a3:	74 0e                	je     8012b3 <atomic_readline+0xc6>
				cputchar(c);
  8012a5:	83 ec 0c             	sub    $0xc,%esp
  8012a8:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ab:	e8 5a f3 ff ff       	call   80060a <cputchar>
  8012b0:	83 c4 10             	add    $0x10,%esp
			i--;
  8012b3:	ff 4d f4             	decl   -0xc(%ebp)
  8012b6:	eb 36                	jmp    8012ee <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012b8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012bc:	74 0a                	je     8012c8 <atomic_readline+0xdb>
  8012be:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012c2:	0f 85 60 ff ff ff    	jne    801228 <atomic_readline+0x3b>
			if (echoing)
  8012c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012cc:	74 0e                	je     8012dc <atomic_readline+0xef>
				cputchar(c);
  8012ce:	83 ec 0c             	sub    $0xc,%esp
  8012d1:	ff 75 ec             	pushl  -0x14(%ebp)
  8012d4:	e8 31 f3 ff ff       	call   80060a <cputchar>
  8012d9:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	01 d0                	add    %edx,%eax
  8012e4:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012e7:	e8 09 0a 00 00       	call   801cf5 <sys_enable_interrupt>
			return;
  8012ec:	eb 05                	jmp    8012f3 <atomic_readline+0x106>
		}
	}
  8012ee:	e9 35 ff ff ff       	jmp    801228 <atomic_readline+0x3b>
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
  8012f8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801302:	eb 06                	jmp    80130a <strlen+0x15>
		n++;
  801304:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801307:	ff 45 08             	incl   0x8(%ebp)
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	84 c0                	test   %al,%al
  801311:	75 f1                	jne    801304 <strlen+0xf>
		n++;
	return n;
  801313:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801316:	c9                   	leave  
  801317:	c3                   	ret    

00801318 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801318:	55                   	push   %ebp
  801319:	89 e5                	mov    %esp,%ebp
  80131b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80131e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801325:	eb 09                	jmp    801330 <strnlen+0x18>
		n++;
  801327:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80132a:	ff 45 08             	incl   0x8(%ebp)
  80132d:	ff 4d 0c             	decl   0xc(%ebp)
  801330:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801334:	74 09                	je     80133f <strnlen+0x27>
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	84 c0                	test   %al,%al
  80133d:	75 e8                	jne    801327 <strnlen+0xf>
		n++;
	return n;
  80133f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
  801347:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801350:	90                   	nop
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	8d 50 01             	lea    0x1(%eax),%edx
  801357:	89 55 08             	mov    %edx,0x8(%ebp)
  80135a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801360:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801363:	8a 12                	mov    (%edx),%dl
  801365:	88 10                	mov    %dl,(%eax)
  801367:	8a 00                	mov    (%eax),%al
  801369:	84 c0                	test   %al,%al
  80136b:	75 e4                	jne    801351 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80136d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80137e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801385:	eb 1f                	jmp    8013a6 <strncpy+0x34>
		*dst++ = *src;
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8d 50 01             	lea    0x1(%eax),%edx
  80138d:	89 55 08             	mov    %edx,0x8(%ebp)
  801390:	8b 55 0c             	mov    0xc(%ebp),%edx
  801393:	8a 12                	mov    (%edx),%dl
  801395:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	84 c0                	test   %al,%al
  80139e:	74 03                	je     8013a3 <strncpy+0x31>
			src++;
  8013a0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013a3:	ff 45 fc             	incl   -0x4(%ebp)
  8013a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ac:	72 d9                	jb     801387 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
  8013b6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c3:	74 30                	je     8013f5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013c5:	eb 16                	jmp    8013dd <strlcpy+0x2a>
			*dst++ = *src++;
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	8d 50 01             	lea    0x1(%eax),%edx
  8013cd:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013d6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013d9:	8a 12                	mov    (%edx),%dl
  8013db:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013dd:	ff 4d 10             	decl   0x10(%ebp)
  8013e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e4:	74 09                	je     8013ef <strlcpy+0x3c>
  8013e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	84 c0                	test   %al,%al
  8013ed:	75 d8                	jne    8013c7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8013f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013fb:	29 c2                	sub    %eax,%edx
  8013fd:	89 d0                	mov    %edx,%eax
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801404:	eb 06                	jmp    80140c <strcmp+0xb>
		p++, q++;
  801406:	ff 45 08             	incl   0x8(%ebp)
  801409:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	84 c0                	test   %al,%al
  801413:	74 0e                	je     801423 <strcmp+0x22>
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	8a 10                	mov    (%eax),%dl
  80141a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	38 c2                	cmp    %al,%dl
  801421:	74 e3                	je     801406 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	8a 00                	mov    (%eax),%al
  801428:	0f b6 d0             	movzbl %al,%edx
  80142b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	0f b6 c0             	movzbl %al,%eax
  801433:	29 c2                	sub    %eax,%edx
  801435:	89 d0                	mov    %edx,%eax
}
  801437:	5d                   	pop    %ebp
  801438:	c3                   	ret    

00801439 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801439:	55                   	push   %ebp
  80143a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80143c:	eb 09                	jmp    801447 <strncmp+0xe>
		n--, p++, q++;
  80143e:	ff 4d 10             	decl   0x10(%ebp)
  801441:	ff 45 08             	incl   0x8(%ebp)
  801444:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801447:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80144b:	74 17                	je     801464 <strncmp+0x2b>
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	84 c0                	test   %al,%al
  801454:	74 0e                	je     801464 <strncmp+0x2b>
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 10                	mov    (%eax),%dl
  80145b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	38 c2                	cmp    %al,%dl
  801462:	74 da                	je     80143e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801464:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801468:	75 07                	jne    801471 <strncmp+0x38>
		return 0;
  80146a:	b8 00 00 00 00       	mov    $0x0,%eax
  80146f:	eb 14                	jmp    801485 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f b6 d0             	movzbl %al,%edx
  801479:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	0f b6 c0             	movzbl %al,%eax
  801481:	29 c2                	sub    %eax,%edx
  801483:	89 d0                	mov    %edx,%eax
}
  801485:	5d                   	pop    %ebp
  801486:	c3                   	ret    

00801487 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 04             	sub    $0x4,%esp
  80148d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801490:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801493:	eb 12                	jmp    8014a7 <strchr+0x20>
		if (*s == c)
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8a 00                	mov    (%eax),%al
  80149a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80149d:	75 05                	jne    8014a4 <strchr+0x1d>
			return (char *) s;
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	eb 11                	jmp    8014b5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014a4:	ff 45 08             	incl   0x8(%ebp)
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	8a 00                	mov    (%eax),%al
  8014ac:	84 c0                	test   %al,%al
  8014ae:	75 e5                	jne    801495 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014c3:	eb 0d                	jmp    8014d2 <strfind+0x1b>
		if (*s == c)
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	8a 00                	mov    (%eax),%al
  8014ca:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014cd:	74 0e                	je     8014dd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014cf:	ff 45 08             	incl   0x8(%ebp)
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d5:	8a 00                	mov    (%eax),%al
  8014d7:	84 c0                	test   %al,%al
  8014d9:	75 ea                	jne    8014c5 <strfind+0xe>
  8014db:	eb 01                	jmp    8014de <strfind+0x27>
		if (*s == c)
			break;
  8014dd:	90                   	nop
	return (char *) s;
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e1:	c9                   	leave  
  8014e2:	c3                   	ret    

008014e3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014e3:	55                   	push   %ebp
  8014e4:	89 e5                	mov    %esp,%ebp
  8014e6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014f5:	eb 0e                	jmp    801505 <memset+0x22>
		*p++ = c;
  8014f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fa:	8d 50 01             	lea    0x1(%eax),%edx
  8014fd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801500:	8b 55 0c             	mov    0xc(%ebp),%edx
  801503:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801505:	ff 4d f8             	decl   -0x8(%ebp)
  801508:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80150c:	79 e9                	jns    8014f7 <memset+0x14>
		*p++ = c;

	return v;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
  801516:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801525:	eb 16                	jmp    80153d <memcpy+0x2a>
		*d++ = *s++;
  801527:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152a:	8d 50 01             	lea    0x1(%eax),%edx
  80152d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801530:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801533:	8d 4a 01             	lea    0x1(%edx),%ecx
  801536:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801539:	8a 12                	mov    (%edx),%dl
  80153b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80153d:	8b 45 10             	mov    0x10(%ebp),%eax
  801540:	8d 50 ff             	lea    -0x1(%eax),%edx
  801543:	89 55 10             	mov    %edx,0x10(%ebp)
  801546:	85 c0                	test   %eax,%eax
  801548:	75 dd                	jne    801527 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
  801552:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801555:	8b 45 0c             	mov    0xc(%ebp),%eax
  801558:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801561:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801564:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801567:	73 50                	jae    8015b9 <memmove+0x6a>
  801569:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156c:	8b 45 10             	mov    0x10(%ebp),%eax
  80156f:	01 d0                	add    %edx,%eax
  801571:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801574:	76 43                	jbe    8015b9 <memmove+0x6a>
		s += n;
  801576:	8b 45 10             	mov    0x10(%ebp),%eax
  801579:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801582:	eb 10                	jmp    801594 <memmove+0x45>
			*--d = *--s;
  801584:	ff 4d f8             	decl   -0x8(%ebp)
  801587:	ff 4d fc             	decl   -0x4(%ebp)
  80158a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158d:	8a 10                	mov    (%eax),%dl
  80158f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801592:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801594:	8b 45 10             	mov    0x10(%ebp),%eax
  801597:	8d 50 ff             	lea    -0x1(%eax),%edx
  80159a:	89 55 10             	mov    %edx,0x10(%ebp)
  80159d:	85 c0                	test   %eax,%eax
  80159f:	75 e3                	jne    801584 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015a1:	eb 23                	jmp    8015c6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a6:	8d 50 01             	lea    0x1(%eax),%edx
  8015a9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015af:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015b2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015b5:	8a 12                	mov    (%edx),%dl
  8015b7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015bf:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c2:	85 c0                	test   %eax,%eax
  8015c4:	75 dd                	jne    8015a3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
  8015ce:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015da:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015dd:	eb 2a                	jmp    801609 <memcmp+0x3e>
		if (*s1 != *s2)
  8015df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e2:	8a 10                	mov    (%eax),%dl
  8015e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	38 c2                	cmp    %al,%dl
  8015eb:	74 16                	je     801603 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f0:	8a 00                	mov    (%eax),%al
  8015f2:	0f b6 d0             	movzbl %al,%edx
  8015f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f8:	8a 00                	mov    (%eax),%al
  8015fa:	0f b6 c0             	movzbl %al,%eax
  8015fd:	29 c2                	sub    %eax,%edx
  8015ff:	89 d0                	mov    %edx,%eax
  801601:	eb 18                	jmp    80161b <memcmp+0x50>
		s1++, s2++;
  801603:	ff 45 fc             	incl   -0x4(%ebp)
  801606:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801609:	8b 45 10             	mov    0x10(%ebp),%eax
  80160c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80160f:	89 55 10             	mov    %edx,0x10(%ebp)
  801612:	85 c0                	test   %eax,%eax
  801614:	75 c9                	jne    8015df <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801616:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
  801620:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801623:	8b 55 08             	mov    0x8(%ebp),%edx
  801626:	8b 45 10             	mov    0x10(%ebp),%eax
  801629:	01 d0                	add    %edx,%eax
  80162b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80162e:	eb 15                	jmp    801645 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	8a 00                	mov    (%eax),%al
  801635:	0f b6 d0             	movzbl %al,%edx
  801638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163b:	0f b6 c0             	movzbl %al,%eax
  80163e:	39 c2                	cmp    %eax,%edx
  801640:	74 0d                	je     80164f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801642:	ff 45 08             	incl   0x8(%ebp)
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80164b:	72 e3                	jb     801630 <memfind+0x13>
  80164d:	eb 01                	jmp    801650 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80164f:	90                   	nop
	return (void *) s;
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801653:	c9                   	leave  
  801654:	c3                   	ret    

00801655 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
  801658:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80165b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801662:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801669:	eb 03                	jmp    80166e <strtol+0x19>
		s++;
  80166b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	3c 20                	cmp    $0x20,%al
  801675:	74 f4                	je     80166b <strtol+0x16>
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	3c 09                	cmp    $0x9,%al
  80167e:	74 eb                	je     80166b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	3c 2b                	cmp    $0x2b,%al
  801687:	75 05                	jne    80168e <strtol+0x39>
		s++;
  801689:	ff 45 08             	incl   0x8(%ebp)
  80168c:	eb 13                	jmp    8016a1 <strtol+0x4c>
	else if (*s == '-')
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	3c 2d                	cmp    $0x2d,%al
  801695:	75 0a                	jne    8016a1 <strtol+0x4c>
		s++, neg = 1;
  801697:	ff 45 08             	incl   0x8(%ebp)
  80169a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a5:	74 06                	je     8016ad <strtol+0x58>
  8016a7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016ab:	75 20                	jne    8016cd <strtol+0x78>
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 00                	mov    (%eax),%al
  8016b2:	3c 30                	cmp    $0x30,%al
  8016b4:	75 17                	jne    8016cd <strtol+0x78>
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	40                   	inc    %eax
  8016ba:	8a 00                	mov    (%eax),%al
  8016bc:	3c 78                	cmp    $0x78,%al
  8016be:	75 0d                	jne    8016cd <strtol+0x78>
		s += 2, base = 16;
  8016c0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016c4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016cb:	eb 28                	jmp    8016f5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d1:	75 15                	jne    8016e8 <strtol+0x93>
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8a 00                	mov    (%eax),%al
  8016d8:	3c 30                	cmp    $0x30,%al
  8016da:	75 0c                	jne    8016e8 <strtol+0x93>
		s++, base = 8;
  8016dc:	ff 45 08             	incl   0x8(%ebp)
  8016df:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016e6:	eb 0d                	jmp    8016f5 <strtol+0xa0>
	else if (base == 0)
  8016e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ec:	75 07                	jne    8016f5 <strtol+0xa0>
		base = 10;
  8016ee:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 2f                	cmp    $0x2f,%al
  8016fc:	7e 19                	jle    801717 <strtol+0xc2>
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	3c 39                	cmp    $0x39,%al
  801705:	7f 10                	jg     801717 <strtol+0xc2>
			dig = *s - '0';
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	8a 00                	mov    (%eax),%al
  80170c:	0f be c0             	movsbl %al,%eax
  80170f:	83 e8 30             	sub    $0x30,%eax
  801712:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801715:	eb 42                	jmp    801759 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	3c 60                	cmp    $0x60,%al
  80171e:	7e 19                	jle    801739 <strtol+0xe4>
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	8a 00                	mov    (%eax),%al
  801725:	3c 7a                	cmp    $0x7a,%al
  801727:	7f 10                	jg     801739 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	8a 00                	mov    (%eax),%al
  80172e:	0f be c0             	movsbl %al,%eax
  801731:	83 e8 57             	sub    $0x57,%eax
  801734:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801737:	eb 20                	jmp    801759 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	3c 40                	cmp    $0x40,%al
  801740:	7e 39                	jle    80177b <strtol+0x126>
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 00                	mov    (%eax),%al
  801747:	3c 5a                	cmp    $0x5a,%al
  801749:	7f 30                	jg     80177b <strtol+0x126>
			dig = *s - 'A' + 10;
  80174b:	8b 45 08             	mov    0x8(%ebp),%eax
  80174e:	8a 00                	mov    (%eax),%al
  801750:	0f be c0             	movsbl %al,%eax
  801753:	83 e8 37             	sub    $0x37,%eax
  801756:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801759:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80175c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80175f:	7d 19                	jge    80177a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801761:	ff 45 08             	incl   0x8(%ebp)
  801764:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801767:	0f af 45 10          	imul   0x10(%ebp),%eax
  80176b:	89 c2                	mov    %eax,%edx
  80176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801770:	01 d0                	add    %edx,%eax
  801772:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801775:	e9 7b ff ff ff       	jmp    8016f5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80177a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80177b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80177f:	74 08                	je     801789 <strtol+0x134>
		*endptr = (char *) s;
  801781:	8b 45 0c             	mov    0xc(%ebp),%eax
  801784:	8b 55 08             	mov    0x8(%ebp),%edx
  801787:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801789:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80178d:	74 07                	je     801796 <strtol+0x141>
  80178f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801792:	f7 d8                	neg    %eax
  801794:	eb 03                	jmp    801799 <strtol+0x144>
  801796:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <ltostr>:

void
ltostr(long value, char *str)
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
  80179e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017b3:	79 13                	jns    8017c8 <ltostr+0x2d>
	{
		neg = 1;
  8017b5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017c2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017c5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017d0:	99                   	cltd   
  8017d1:	f7 f9                	idiv   %ecx
  8017d3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d9:	8d 50 01             	lea    0x1(%eax),%edx
  8017dc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017df:	89 c2                	mov    %eax,%edx
  8017e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e4:	01 d0                	add    %edx,%eax
  8017e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017e9:	83 c2 30             	add    $0x30,%edx
  8017ec:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017f1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017f6:	f7 e9                	imul   %ecx
  8017f8:	c1 fa 02             	sar    $0x2,%edx
  8017fb:	89 c8                	mov    %ecx,%eax
  8017fd:	c1 f8 1f             	sar    $0x1f,%eax
  801800:	29 c2                	sub    %eax,%edx
  801802:	89 d0                	mov    %edx,%eax
  801804:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801807:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80180a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80180f:	f7 e9                	imul   %ecx
  801811:	c1 fa 02             	sar    $0x2,%edx
  801814:	89 c8                	mov    %ecx,%eax
  801816:	c1 f8 1f             	sar    $0x1f,%eax
  801819:	29 c2                	sub    %eax,%edx
  80181b:	89 d0                	mov    %edx,%eax
  80181d:	c1 e0 02             	shl    $0x2,%eax
  801820:	01 d0                	add    %edx,%eax
  801822:	01 c0                	add    %eax,%eax
  801824:	29 c1                	sub    %eax,%ecx
  801826:	89 ca                	mov    %ecx,%edx
  801828:	85 d2                	test   %edx,%edx
  80182a:	75 9c                	jne    8017c8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80182c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801833:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801836:	48                   	dec    %eax
  801837:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80183a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80183e:	74 3d                	je     80187d <ltostr+0xe2>
		start = 1 ;
  801840:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801847:	eb 34                	jmp    80187d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801849:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184f:	01 d0                	add    %edx,%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801856:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801859:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185c:	01 c2                	add    %eax,%edx
  80185e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801861:	8b 45 0c             	mov    0xc(%ebp),%eax
  801864:	01 c8                	add    %ecx,%eax
  801866:	8a 00                	mov    (%eax),%al
  801868:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80186a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80186d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801870:	01 c2                	add    %eax,%edx
  801872:	8a 45 eb             	mov    -0x15(%ebp),%al
  801875:	88 02                	mov    %al,(%edx)
		start++ ;
  801877:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80187a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801880:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801883:	7c c4                	jl     801849 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801885:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188b:	01 d0                	add    %edx,%eax
  80188d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801890:	90                   	nop
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
  801896:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801899:	ff 75 08             	pushl  0x8(%ebp)
  80189c:	e8 54 fa ff ff       	call   8012f5 <strlen>
  8018a1:	83 c4 04             	add    $0x4,%esp
  8018a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018a7:	ff 75 0c             	pushl  0xc(%ebp)
  8018aa:	e8 46 fa ff ff       	call   8012f5 <strlen>
  8018af:	83 c4 04             	add    $0x4,%esp
  8018b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018c3:	eb 17                	jmp    8018dc <strcconcat+0x49>
		final[s] = str1[s] ;
  8018c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cb:	01 c2                	add    %eax,%edx
  8018cd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	01 c8                	add    %ecx,%eax
  8018d5:	8a 00                	mov    (%eax),%al
  8018d7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018d9:	ff 45 fc             	incl   -0x4(%ebp)
  8018dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018df:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018e2:	7c e1                	jl     8018c5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018eb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018f2:	eb 1f                	jmp    801913 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f7:	8d 50 01             	lea    0x1(%eax),%edx
  8018fa:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018fd:	89 c2                	mov    %eax,%edx
  8018ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801902:	01 c2                	add    %eax,%edx
  801904:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80190a:	01 c8                	add    %ecx,%eax
  80190c:	8a 00                	mov    (%eax),%al
  80190e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801910:	ff 45 f8             	incl   -0x8(%ebp)
  801913:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801916:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801919:	7c d9                	jl     8018f4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80191b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80191e:	8b 45 10             	mov    0x10(%ebp),%eax
  801921:	01 d0                	add    %edx,%eax
  801923:	c6 00 00             	movb   $0x0,(%eax)
}
  801926:	90                   	nop
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80192c:	8b 45 14             	mov    0x14(%ebp),%eax
  80192f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801935:	8b 45 14             	mov    0x14(%ebp),%eax
  801938:	8b 00                	mov    (%eax),%eax
  80193a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801941:	8b 45 10             	mov    0x10(%ebp),%eax
  801944:	01 d0                	add    %edx,%eax
  801946:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80194c:	eb 0c                	jmp    80195a <strsplit+0x31>
			*string++ = 0;
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	8d 50 01             	lea    0x1(%eax),%edx
  801954:	89 55 08             	mov    %edx,0x8(%ebp)
  801957:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	8a 00                	mov    (%eax),%al
  80195f:	84 c0                	test   %al,%al
  801961:	74 18                	je     80197b <strsplit+0x52>
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	0f be c0             	movsbl %al,%eax
  80196b:	50                   	push   %eax
  80196c:	ff 75 0c             	pushl  0xc(%ebp)
  80196f:	e8 13 fb ff ff       	call   801487 <strchr>
  801974:	83 c4 08             	add    $0x8,%esp
  801977:	85 c0                	test   %eax,%eax
  801979:	75 d3                	jne    80194e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80197b:	8b 45 08             	mov    0x8(%ebp),%eax
  80197e:	8a 00                	mov    (%eax),%al
  801980:	84 c0                	test   %al,%al
  801982:	74 5a                	je     8019de <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801984:	8b 45 14             	mov    0x14(%ebp),%eax
  801987:	8b 00                	mov    (%eax),%eax
  801989:	83 f8 0f             	cmp    $0xf,%eax
  80198c:	75 07                	jne    801995 <strsplit+0x6c>
		{
			return 0;
  80198e:	b8 00 00 00 00       	mov    $0x0,%eax
  801993:	eb 66                	jmp    8019fb <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801995:	8b 45 14             	mov    0x14(%ebp),%eax
  801998:	8b 00                	mov    (%eax),%eax
  80199a:	8d 48 01             	lea    0x1(%eax),%ecx
  80199d:	8b 55 14             	mov    0x14(%ebp),%edx
  8019a0:	89 0a                	mov    %ecx,(%edx)
  8019a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ac:	01 c2                	add    %eax,%edx
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019b3:	eb 03                	jmp    8019b8 <strsplit+0x8f>
			string++;
  8019b5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	8a 00                	mov    (%eax),%al
  8019bd:	84 c0                	test   %al,%al
  8019bf:	74 8b                	je     80194c <strsplit+0x23>
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8a 00                	mov    (%eax),%al
  8019c6:	0f be c0             	movsbl %al,%eax
  8019c9:	50                   	push   %eax
  8019ca:	ff 75 0c             	pushl  0xc(%ebp)
  8019cd:	e8 b5 fa ff ff       	call   801487 <strchr>
  8019d2:	83 c4 08             	add    $0x8,%esp
  8019d5:	85 c0                	test   %eax,%eax
  8019d7:	74 dc                	je     8019b5 <strsplit+0x8c>
			string++;
	}
  8019d9:	e9 6e ff ff ff       	jmp    80194c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019de:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019df:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e2:	8b 00                	mov    (%eax),%eax
  8019e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ee:	01 d0                	add    %edx,%eax
  8019f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019f6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019fb:	c9                   	leave  
  8019fc:	c3                   	ret    

008019fd <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  8019fd:	55                   	push   %ebp
  8019fe:	89 e5                	mov    %esp,%ebp
  801a00:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801a03:	83 ec 04             	sub    $0x4,%esp
  801a06:	68 04 2a 80 00       	push   $0x802a04
  801a0b:	6a 19                	push   $0x19
  801a0d:	68 29 2a 80 00       	push   $0x802a29
  801a12:	e8 a2 ed ff ff       	call   8007b9 <_panic>

00801a17 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
  801a1a:	83 ec 18             	sub    $0x18,%esp
  801a1d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a20:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801a23:	83 ec 04             	sub    $0x4,%esp
  801a26:	68 38 2a 80 00       	push   $0x802a38
  801a2b:	6a 30                	push   $0x30
  801a2d:	68 29 2a 80 00       	push   $0x802a29
  801a32:	e8 82 ed ff ff       	call   8007b9 <_panic>

00801a37 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
  801a3a:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801a3d:	83 ec 04             	sub    $0x4,%esp
  801a40:	68 57 2a 80 00       	push   $0x802a57
  801a45:	6a 36                	push   $0x36
  801a47:	68 29 2a 80 00       	push   $0x802a29
  801a4c:	e8 68 ed ff ff       	call   8007b9 <_panic>

00801a51 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
  801a54:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a57:	83 ec 04             	sub    $0x4,%esp
  801a5a:	68 74 2a 80 00       	push   $0x802a74
  801a5f:	6a 48                	push   $0x48
  801a61:	68 29 2a 80 00       	push   $0x802a29
  801a66:	e8 4e ed ff ff       	call   8007b9 <_panic>

00801a6b <sfree>:

}


void sfree(void* virtual_address)
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
  801a6e:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801a71:	83 ec 04             	sub    $0x4,%esp
  801a74:	68 97 2a 80 00       	push   $0x802a97
  801a79:	6a 53                	push   $0x53
  801a7b:	68 29 2a 80 00       	push   $0x802a29
  801a80:	e8 34 ed ff ff       	call   8007b9 <_panic>

00801a85 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a85:	55                   	push   %ebp
  801a86:	89 e5                	mov    %esp,%ebp
  801a88:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801a8b:	83 ec 04             	sub    $0x4,%esp
  801a8e:	68 b4 2a 80 00       	push   $0x802ab4
  801a93:	6a 6c                	push   $0x6c
  801a95:	68 29 2a 80 00       	push   $0x802a29
  801a9a:	e8 1a ed ff ff       	call   8007b9 <_panic>

00801a9f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a9f:	55                   	push   %ebp
  801aa0:	89 e5                	mov    %esp,%ebp
  801aa2:	57                   	push   %edi
  801aa3:	56                   	push   %esi
  801aa4:	53                   	push   %ebx
  801aa5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aab:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ab4:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ab7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801aba:	cd 30                	int    $0x30
  801abc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801abf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ac2:	83 c4 10             	add    $0x10,%esp
  801ac5:	5b                   	pop    %ebx
  801ac6:	5e                   	pop    %esi
  801ac7:	5f                   	pop    %edi
  801ac8:	5d                   	pop    %ebp
  801ac9:	c3                   	ret    

00801aca <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
  801acd:	83 ec 04             	sub    $0x4,%esp
  801ad0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ad6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ada:	8b 45 08             	mov    0x8(%ebp),%eax
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	52                   	push   %edx
  801ae2:	ff 75 0c             	pushl  0xc(%ebp)
  801ae5:	50                   	push   %eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	e8 b2 ff ff ff       	call   801a9f <syscall>
  801aed:	83 c4 18             	add    $0x18,%esp
}
  801af0:	90                   	nop
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <sys_cgetc>:

int
sys_cgetc(void)
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 01                	push   $0x1
  801b02:	e8 98 ff ff ff       	call   801a9f <syscall>
  801b07:	83 c4 18             	add    $0x18,%esp
}
  801b0a:	c9                   	leave  
  801b0b:	c3                   	ret    

00801b0c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b0c:	55                   	push   %ebp
  801b0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	50                   	push   %eax
  801b1b:	6a 05                	push   $0x5
  801b1d:	e8 7d ff ff ff       	call   801a9f <syscall>
  801b22:	83 c4 18             	add    $0x18,%esp
}
  801b25:	c9                   	leave  
  801b26:	c3                   	ret    

00801b27 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b27:	55                   	push   %ebp
  801b28:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 02                	push   $0x2
  801b36:	e8 64 ff ff ff       	call   801a9f <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
}
  801b3e:	c9                   	leave  
  801b3f:	c3                   	ret    

00801b40 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b40:	55                   	push   %ebp
  801b41:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 03                	push   $0x3
  801b4f:	e8 4b ff ff ff       	call   801a9f <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
}
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 04                	push   $0x4
  801b68:	e8 32 ff ff ff       	call   801a9f <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_env_exit>:


void sys_env_exit(void)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 06                	push   $0x6
  801b81:	e8 19 ff ff ff       	call   801a9f <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	90                   	nop
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b92:	8b 45 08             	mov    0x8(%ebp),%eax
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	52                   	push   %edx
  801b9c:	50                   	push   %eax
  801b9d:	6a 07                	push   $0x7
  801b9f:	e8 fb fe ff ff       	call   801a9f <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
  801bac:	56                   	push   %esi
  801bad:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bae:	8b 75 18             	mov    0x18(%ebp),%esi
  801bb1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bb4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bba:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbd:	56                   	push   %esi
  801bbe:	53                   	push   %ebx
  801bbf:	51                   	push   %ecx
  801bc0:	52                   	push   %edx
  801bc1:	50                   	push   %eax
  801bc2:	6a 08                	push   $0x8
  801bc4:	e8 d6 fe ff ff       	call   801a9f <syscall>
  801bc9:	83 c4 18             	add    $0x18,%esp
}
  801bcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bcf:	5b                   	pop    %ebx
  801bd0:	5e                   	pop    %esi
  801bd1:	5d                   	pop    %ebp
  801bd2:	c3                   	ret    

00801bd3 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	52                   	push   %edx
  801be3:	50                   	push   %eax
  801be4:	6a 09                	push   $0x9
  801be6:	e8 b4 fe ff ff       	call   801a9f <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	ff 75 0c             	pushl  0xc(%ebp)
  801bfc:	ff 75 08             	pushl  0x8(%ebp)
  801bff:	6a 0a                	push   $0xa
  801c01:	e8 99 fe ff ff       	call   801a9f <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
}
  801c09:	c9                   	leave  
  801c0a:	c3                   	ret    

00801c0b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c0b:	55                   	push   %ebp
  801c0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 0b                	push   $0xb
  801c1a:	e8 80 fe ff ff       	call   801a9f <syscall>
  801c1f:	83 c4 18             	add    $0x18,%esp
}
  801c22:	c9                   	leave  
  801c23:	c3                   	ret    

00801c24 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 0c                	push   $0xc
  801c33:	e8 67 fe ff ff       	call   801a9f <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 0d                	push   $0xd
  801c4c:	e8 4e fe ff ff       	call   801a9f <syscall>
  801c51:	83 c4 18             	add    $0x18,%esp
}
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	ff 75 0c             	pushl  0xc(%ebp)
  801c62:	ff 75 08             	pushl  0x8(%ebp)
  801c65:	6a 11                	push   $0x11
  801c67:	e8 33 fe ff ff       	call   801a9f <syscall>
  801c6c:	83 c4 18             	add    $0x18,%esp
	return;
  801c6f:	90                   	nop
}
  801c70:	c9                   	leave  
  801c71:	c3                   	ret    

00801c72 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	ff 75 0c             	pushl  0xc(%ebp)
  801c7e:	ff 75 08             	pushl  0x8(%ebp)
  801c81:	6a 12                	push   $0x12
  801c83:	e8 17 fe ff ff       	call   801a9f <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
	return ;
  801c8b:	90                   	nop
}
  801c8c:	c9                   	leave  
  801c8d:	c3                   	ret    

00801c8e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 0e                	push   $0xe
  801c9d:	e8 fd fd ff ff       	call   801a9f <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
}
  801ca5:	c9                   	leave  
  801ca6:	c3                   	ret    

00801ca7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	ff 75 08             	pushl  0x8(%ebp)
  801cb5:	6a 0f                	push   $0xf
  801cb7:	e8 e3 fd ff ff       	call   801a9f <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 10                	push   $0x10
  801cd0:	e8 ca fd ff ff       	call   801a9f <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	90                   	nop
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 14                	push   $0x14
  801cea:	e8 b0 fd ff ff       	call   801a9f <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
}
  801cf2:	90                   	nop
  801cf3:	c9                   	leave  
  801cf4:	c3                   	ret    

00801cf5 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801cf5:	55                   	push   %ebp
  801cf6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 15                	push   $0x15
  801d04:	e8 96 fd ff ff       	call   801a9f <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
}
  801d0c:	90                   	nop
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <sys_cputc>:


void
sys_cputc(const char c)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
  801d12:	83 ec 04             	sub    $0x4,%esp
  801d15:	8b 45 08             	mov    0x8(%ebp),%eax
  801d18:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d1b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	50                   	push   %eax
  801d28:	6a 16                	push   $0x16
  801d2a:	e8 70 fd ff ff       	call   801a9f <syscall>
  801d2f:	83 c4 18             	add    $0x18,%esp
}
  801d32:	90                   	nop
  801d33:	c9                   	leave  
  801d34:	c3                   	ret    

00801d35 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 17                	push   $0x17
  801d44:	e8 56 fd ff ff       	call   801a9f <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
}
  801d4c:	90                   	nop
  801d4d:	c9                   	leave  
  801d4e:	c3                   	ret    

00801d4f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d4f:	55                   	push   %ebp
  801d50:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d52:	8b 45 08             	mov    0x8(%ebp),%eax
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	ff 75 0c             	pushl  0xc(%ebp)
  801d5e:	50                   	push   %eax
  801d5f:	6a 18                	push   $0x18
  801d61:	e8 39 fd ff ff       	call   801a9f <syscall>
  801d66:	83 c4 18             	add    $0x18,%esp
}
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d71:	8b 45 08             	mov    0x8(%ebp),%eax
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	52                   	push   %edx
  801d7b:	50                   	push   %eax
  801d7c:	6a 1b                	push   $0x1b
  801d7e:	e8 1c fd ff ff       	call   801a9f <syscall>
  801d83:	83 c4 18             	add    $0x18,%esp
}
  801d86:	c9                   	leave  
  801d87:	c3                   	ret    

00801d88 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d88:	55                   	push   %ebp
  801d89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	52                   	push   %edx
  801d98:	50                   	push   %eax
  801d99:	6a 19                	push   $0x19
  801d9b:	e8 ff fc ff ff       	call   801a9f <syscall>
  801da0:	83 c4 18             	add    $0x18,%esp
}
  801da3:	90                   	nop
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801da9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dac:	8b 45 08             	mov    0x8(%ebp),%eax
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	52                   	push   %edx
  801db6:	50                   	push   %eax
  801db7:	6a 1a                	push   $0x1a
  801db9:	e8 e1 fc ff ff       	call   801a9f <syscall>
  801dbe:	83 c4 18             	add    $0x18,%esp
}
  801dc1:	90                   	nop
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
  801dc7:	83 ec 04             	sub    $0x4,%esp
  801dca:	8b 45 10             	mov    0x10(%ebp),%eax
  801dcd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dd0:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dd3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dda:	6a 00                	push   $0x0
  801ddc:	51                   	push   %ecx
  801ddd:	52                   	push   %edx
  801dde:	ff 75 0c             	pushl  0xc(%ebp)
  801de1:	50                   	push   %eax
  801de2:	6a 1c                	push   $0x1c
  801de4:	e8 b6 fc ff ff       	call   801a9f <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	c9                   	leave  
  801ded:	c3                   	ret    

00801dee <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801df1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df4:	8b 45 08             	mov    0x8(%ebp),%eax
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	52                   	push   %edx
  801dfe:	50                   	push   %eax
  801dff:	6a 1d                	push   $0x1d
  801e01:	e8 99 fc ff ff       	call   801a9f <syscall>
  801e06:	83 c4 18             	add    $0x18,%esp
}
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    

00801e0b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e0e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	51                   	push   %ecx
  801e1c:	52                   	push   %edx
  801e1d:	50                   	push   %eax
  801e1e:	6a 1e                	push   $0x1e
  801e20:	e8 7a fc ff ff       	call   801a9f <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
}
  801e28:	c9                   	leave  
  801e29:	c3                   	ret    

00801e2a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e2a:	55                   	push   %ebp
  801e2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e30:	8b 45 08             	mov    0x8(%ebp),%eax
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	52                   	push   %edx
  801e3a:	50                   	push   %eax
  801e3b:	6a 1f                	push   $0x1f
  801e3d:	e8 5d fc ff ff       	call   801a9f <syscall>
  801e42:	83 c4 18             	add    $0x18,%esp
}
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 20                	push   $0x20
  801e56:	e8 44 fc ff ff       	call   801a9f <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
}
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e63:	8b 45 08             	mov    0x8(%ebp),%eax
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	ff 75 10             	pushl  0x10(%ebp)
  801e6d:	ff 75 0c             	pushl  0xc(%ebp)
  801e70:	50                   	push   %eax
  801e71:	6a 21                	push   $0x21
  801e73:	e8 27 fc ff ff       	call   801a9f <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
}
  801e7b:	c9                   	leave  
  801e7c:	c3                   	ret    

00801e7d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e7d:	55                   	push   %ebp
  801e7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	50                   	push   %eax
  801e8c:	6a 22                	push   $0x22
  801e8e:	e8 0c fc ff ff       	call   801a9f <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
}
  801e96:	90                   	nop
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	50                   	push   %eax
  801ea8:	6a 23                	push   $0x23
  801eaa:	e8 f0 fb ff ff       	call   801a9f <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	90                   	nop
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
  801eb8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ebb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ebe:	8d 50 04             	lea    0x4(%eax),%edx
  801ec1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	52                   	push   %edx
  801ecb:	50                   	push   %eax
  801ecc:	6a 24                	push   $0x24
  801ece:	e8 cc fb ff ff       	call   801a9f <syscall>
  801ed3:	83 c4 18             	add    $0x18,%esp
	return result;
  801ed6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ed9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801edc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801edf:	89 01                	mov    %eax,(%ecx)
  801ee1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee7:	c9                   	leave  
  801ee8:	c2 04 00             	ret    $0x4

00801eeb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801eeb:	55                   	push   %ebp
  801eec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	ff 75 10             	pushl  0x10(%ebp)
  801ef5:	ff 75 0c             	pushl  0xc(%ebp)
  801ef8:	ff 75 08             	pushl  0x8(%ebp)
  801efb:	6a 13                	push   $0x13
  801efd:	e8 9d fb ff ff       	call   801a9f <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
	return ;
  801f05:	90                   	nop
}
  801f06:	c9                   	leave  
  801f07:	c3                   	ret    

00801f08 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 25                	push   $0x25
  801f17:	e8 83 fb ff ff       	call   801a9f <syscall>
  801f1c:	83 c4 18             	add    $0x18,%esp
}
  801f1f:	c9                   	leave  
  801f20:	c3                   	ret    

00801f21 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f21:	55                   	push   %ebp
  801f22:	89 e5                	mov    %esp,%ebp
  801f24:	83 ec 04             	sub    $0x4,%esp
  801f27:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f2d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	50                   	push   %eax
  801f3a:	6a 26                	push   $0x26
  801f3c:	e8 5e fb ff ff       	call   801a9f <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
	return ;
  801f44:	90                   	nop
}
  801f45:	c9                   	leave  
  801f46:	c3                   	ret    

00801f47 <rsttst>:
void rsttst()
{
  801f47:	55                   	push   %ebp
  801f48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 28                	push   $0x28
  801f56:	e8 44 fb ff ff       	call   801a9f <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5e:	90                   	nop
}
  801f5f:	c9                   	leave  
  801f60:	c3                   	ret    

00801f61 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f61:	55                   	push   %ebp
  801f62:	89 e5                	mov    %esp,%ebp
  801f64:	83 ec 04             	sub    $0x4,%esp
  801f67:	8b 45 14             	mov    0x14(%ebp),%eax
  801f6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f6d:	8b 55 18             	mov    0x18(%ebp),%edx
  801f70:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f74:	52                   	push   %edx
  801f75:	50                   	push   %eax
  801f76:	ff 75 10             	pushl  0x10(%ebp)
  801f79:	ff 75 0c             	pushl  0xc(%ebp)
  801f7c:	ff 75 08             	pushl  0x8(%ebp)
  801f7f:	6a 27                	push   $0x27
  801f81:	e8 19 fb ff ff       	call   801a9f <syscall>
  801f86:	83 c4 18             	add    $0x18,%esp
	return ;
  801f89:	90                   	nop
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <chktst>:
void chktst(uint32 n)
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	ff 75 08             	pushl  0x8(%ebp)
  801f9a:	6a 29                	push   $0x29
  801f9c:	e8 fe fa ff ff       	call   801a9f <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa4:	90                   	nop
}
  801fa5:	c9                   	leave  
  801fa6:	c3                   	ret    

00801fa7 <inctst>:

void inctst()
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 2a                	push   $0x2a
  801fb6:	e8 e4 fa ff ff       	call   801a9f <syscall>
  801fbb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fbe:	90                   	nop
}
  801fbf:	c9                   	leave  
  801fc0:	c3                   	ret    

00801fc1 <gettst>:
uint32 gettst()
{
  801fc1:	55                   	push   %ebp
  801fc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 2b                	push   $0x2b
  801fd0:	e8 ca fa ff ff       	call   801a9f <syscall>
  801fd5:	83 c4 18             	add    $0x18,%esp
}
  801fd8:	c9                   	leave  
  801fd9:	c3                   	ret    

00801fda <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801fda:	55                   	push   %ebp
  801fdb:	89 e5                	mov    %esp,%ebp
  801fdd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 2c                	push   $0x2c
  801fec:	e8 ae fa ff ff       	call   801a9f <syscall>
  801ff1:	83 c4 18             	add    $0x18,%esp
  801ff4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ff7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ffb:	75 07                	jne    802004 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ffd:	b8 01 00 00 00       	mov    $0x1,%eax
  802002:	eb 05                	jmp    802009 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802004:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
  80200e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 2c                	push   $0x2c
  80201d:	e8 7d fa ff ff       	call   801a9f <syscall>
  802022:	83 c4 18             	add    $0x18,%esp
  802025:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802028:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80202c:	75 07                	jne    802035 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80202e:	b8 01 00 00 00       	mov    $0x1,%eax
  802033:	eb 05                	jmp    80203a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802035:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80203a:	c9                   	leave  
  80203b:	c3                   	ret    

0080203c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80203c:	55                   	push   %ebp
  80203d:	89 e5                	mov    %esp,%ebp
  80203f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 2c                	push   $0x2c
  80204e:	e8 4c fa ff ff       	call   801a9f <syscall>
  802053:	83 c4 18             	add    $0x18,%esp
  802056:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802059:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80205d:	75 07                	jne    802066 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80205f:	b8 01 00 00 00       	mov    $0x1,%eax
  802064:	eb 05                	jmp    80206b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802066:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80206b:	c9                   	leave  
  80206c:	c3                   	ret    

0080206d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80206d:	55                   	push   %ebp
  80206e:	89 e5                	mov    %esp,%ebp
  802070:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 2c                	push   $0x2c
  80207f:	e8 1b fa ff ff       	call   801a9f <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
  802087:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80208a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80208e:	75 07                	jne    802097 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802090:	b8 01 00 00 00       	mov    $0x1,%eax
  802095:	eb 05                	jmp    80209c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802097:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80209c:	c9                   	leave  
  80209d:	c3                   	ret    

0080209e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80209e:	55                   	push   %ebp
  80209f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	ff 75 08             	pushl  0x8(%ebp)
  8020ac:	6a 2d                	push   $0x2d
  8020ae:	e8 ec f9 ff ff       	call   801a9f <syscall>
  8020b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b6:	90                   	nop
}
  8020b7:	c9                   	leave  
  8020b8:	c3                   	ret    
  8020b9:	66 90                	xchg   %ax,%ax
  8020bb:	90                   	nop

008020bc <__udivdi3>:
  8020bc:	55                   	push   %ebp
  8020bd:	57                   	push   %edi
  8020be:	56                   	push   %esi
  8020bf:	53                   	push   %ebx
  8020c0:	83 ec 1c             	sub    $0x1c,%esp
  8020c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020d3:	89 ca                	mov    %ecx,%edx
  8020d5:	89 f8                	mov    %edi,%eax
  8020d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020db:	85 f6                	test   %esi,%esi
  8020dd:	75 2d                	jne    80210c <__udivdi3+0x50>
  8020df:	39 cf                	cmp    %ecx,%edi
  8020e1:	77 65                	ja     802148 <__udivdi3+0x8c>
  8020e3:	89 fd                	mov    %edi,%ebp
  8020e5:	85 ff                	test   %edi,%edi
  8020e7:	75 0b                	jne    8020f4 <__udivdi3+0x38>
  8020e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ee:	31 d2                	xor    %edx,%edx
  8020f0:	f7 f7                	div    %edi
  8020f2:	89 c5                	mov    %eax,%ebp
  8020f4:	31 d2                	xor    %edx,%edx
  8020f6:	89 c8                	mov    %ecx,%eax
  8020f8:	f7 f5                	div    %ebp
  8020fa:	89 c1                	mov    %eax,%ecx
  8020fc:	89 d8                	mov    %ebx,%eax
  8020fe:	f7 f5                	div    %ebp
  802100:	89 cf                	mov    %ecx,%edi
  802102:	89 fa                	mov    %edi,%edx
  802104:	83 c4 1c             	add    $0x1c,%esp
  802107:	5b                   	pop    %ebx
  802108:	5e                   	pop    %esi
  802109:	5f                   	pop    %edi
  80210a:	5d                   	pop    %ebp
  80210b:	c3                   	ret    
  80210c:	39 ce                	cmp    %ecx,%esi
  80210e:	77 28                	ja     802138 <__udivdi3+0x7c>
  802110:	0f bd fe             	bsr    %esi,%edi
  802113:	83 f7 1f             	xor    $0x1f,%edi
  802116:	75 40                	jne    802158 <__udivdi3+0x9c>
  802118:	39 ce                	cmp    %ecx,%esi
  80211a:	72 0a                	jb     802126 <__udivdi3+0x6a>
  80211c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802120:	0f 87 9e 00 00 00    	ja     8021c4 <__udivdi3+0x108>
  802126:	b8 01 00 00 00       	mov    $0x1,%eax
  80212b:	89 fa                	mov    %edi,%edx
  80212d:	83 c4 1c             	add    $0x1c,%esp
  802130:	5b                   	pop    %ebx
  802131:	5e                   	pop    %esi
  802132:	5f                   	pop    %edi
  802133:	5d                   	pop    %ebp
  802134:	c3                   	ret    
  802135:	8d 76 00             	lea    0x0(%esi),%esi
  802138:	31 ff                	xor    %edi,%edi
  80213a:	31 c0                	xor    %eax,%eax
  80213c:	89 fa                	mov    %edi,%edx
  80213e:	83 c4 1c             	add    $0x1c,%esp
  802141:	5b                   	pop    %ebx
  802142:	5e                   	pop    %esi
  802143:	5f                   	pop    %edi
  802144:	5d                   	pop    %ebp
  802145:	c3                   	ret    
  802146:	66 90                	xchg   %ax,%ax
  802148:	89 d8                	mov    %ebx,%eax
  80214a:	f7 f7                	div    %edi
  80214c:	31 ff                	xor    %edi,%edi
  80214e:	89 fa                	mov    %edi,%edx
  802150:	83 c4 1c             	add    $0x1c,%esp
  802153:	5b                   	pop    %ebx
  802154:	5e                   	pop    %esi
  802155:	5f                   	pop    %edi
  802156:	5d                   	pop    %ebp
  802157:	c3                   	ret    
  802158:	bd 20 00 00 00       	mov    $0x20,%ebp
  80215d:	89 eb                	mov    %ebp,%ebx
  80215f:	29 fb                	sub    %edi,%ebx
  802161:	89 f9                	mov    %edi,%ecx
  802163:	d3 e6                	shl    %cl,%esi
  802165:	89 c5                	mov    %eax,%ebp
  802167:	88 d9                	mov    %bl,%cl
  802169:	d3 ed                	shr    %cl,%ebp
  80216b:	89 e9                	mov    %ebp,%ecx
  80216d:	09 f1                	or     %esi,%ecx
  80216f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802173:	89 f9                	mov    %edi,%ecx
  802175:	d3 e0                	shl    %cl,%eax
  802177:	89 c5                	mov    %eax,%ebp
  802179:	89 d6                	mov    %edx,%esi
  80217b:	88 d9                	mov    %bl,%cl
  80217d:	d3 ee                	shr    %cl,%esi
  80217f:	89 f9                	mov    %edi,%ecx
  802181:	d3 e2                	shl    %cl,%edx
  802183:	8b 44 24 08          	mov    0x8(%esp),%eax
  802187:	88 d9                	mov    %bl,%cl
  802189:	d3 e8                	shr    %cl,%eax
  80218b:	09 c2                	or     %eax,%edx
  80218d:	89 d0                	mov    %edx,%eax
  80218f:	89 f2                	mov    %esi,%edx
  802191:	f7 74 24 0c          	divl   0xc(%esp)
  802195:	89 d6                	mov    %edx,%esi
  802197:	89 c3                	mov    %eax,%ebx
  802199:	f7 e5                	mul    %ebp
  80219b:	39 d6                	cmp    %edx,%esi
  80219d:	72 19                	jb     8021b8 <__udivdi3+0xfc>
  80219f:	74 0b                	je     8021ac <__udivdi3+0xf0>
  8021a1:	89 d8                	mov    %ebx,%eax
  8021a3:	31 ff                	xor    %edi,%edi
  8021a5:	e9 58 ff ff ff       	jmp    802102 <__udivdi3+0x46>
  8021aa:	66 90                	xchg   %ax,%ax
  8021ac:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021b0:	89 f9                	mov    %edi,%ecx
  8021b2:	d3 e2                	shl    %cl,%edx
  8021b4:	39 c2                	cmp    %eax,%edx
  8021b6:	73 e9                	jae    8021a1 <__udivdi3+0xe5>
  8021b8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021bb:	31 ff                	xor    %edi,%edi
  8021bd:	e9 40 ff ff ff       	jmp    802102 <__udivdi3+0x46>
  8021c2:	66 90                	xchg   %ax,%ax
  8021c4:	31 c0                	xor    %eax,%eax
  8021c6:	e9 37 ff ff ff       	jmp    802102 <__udivdi3+0x46>
  8021cb:	90                   	nop

008021cc <__umoddi3>:
  8021cc:	55                   	push   %ebp
  8021cd:	57                   	push   %edi
  8021ce:	56                   	push   %esi
  8021cf:	53                   	push   %ebx
  8021d0:	83 ec 1c             	sub    $0x1c,%esp
  8021d3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021d7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021df:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021eb:	89 f3                	mov    %esi,%ebx
  8021ed:	89 fa                	mov    %edi,%edx
  8021ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021f3:	89 34 24             	mov    %esi,(%esp)
  8021f6:	85 c0                	test   %eax,%eax
  8021f8:	75 1a                	jne    802214 <__umoddi3+0x48>
  8021fa:	39 f7                	cmp    %esi,%edi
  8021fc:	0f 86 a2 00 00 00    	jbe    8022a4 <__umoddi3+0xd8>
  802202:	89 c8                	mov    %ecx,%eax
  802204:	89 f2                	mov    %esi,%edx
  802206:	f7 f7                	div    %edi
  802208:	89 d0                	mov    %edx,%eax
  80220a:	31 d2                	xor    %edx,%edx
  80220c:	83 c4 1c             	add    $0x1c,%esp
  80220f:	5b                   	pop    %ebx
  802210:	5e                   	pop    %esi
  802211:	5f                   	pop    %edi
  802212:	5d                   	pop    %ebp
  802213:	c3                   	ret    
  802214:	39 f0                	cmp    %esi,%eax
  802216:	0f 87 ac 00 00 00    	ja     8022c8 <__umoddi3+0xfc>
  80221c:	0f bd e8             	bsr    %eax,%ebp
  80221f:	83 f5 1f             	xor    $0x1f,%ebp
  802222:	0f 84 ac 00 00 00    	je     8022d4 <__umoddi3+0x108>
  802228:	bf 20 00 00 00       	mov    $0x20,%edi
  80222d:	29 ef                	sub    %ebp,%edi
  80222f:	89 fe                	mov    %edi,%esi
  802231:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802235:	89 e9                	mov    %ebp,%ecx
  802237:	d3 e0                	shl    %cl,%eax
  802239:	89 d7                	mov    %edx,%edi
  80223b:	89 f1                	mov    %esi,%ecx
  80223d:	d3 ef                	shr    %cl,%edi
  80223f:	09 c7                	or     %eax,%edi
  802241:	89 e9                	mov    %ebp,%ecx
  802243:	d3 e2                	shl    %cl,%edx
  802245:	89 14 24             	mov    %edx,(%esp)
  802248:	89 d8                	mov    %ebx,%eax
  80224a:	d3 e0                	shl    %cl,%eax
  80224c:	89 c2                	mov    %eax,%edx
  80224e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802252:	d3 e0                	shl    %cl,%eax
  802254:	89 44 24 04          	mov    %eax,0x4(%esp)
  802258:	8b 44 24 08          	mov    0x8(%esp),%eax
  80225c:	89 f1                	mov    %esi,%ecx
  80225e:	d3 e8                	shr    %cl,%eax
  802260:	09 d0                	or     %edx,%eax
  802262:	d3 eb                	shr    %cl,%ebx
  802264:	89 da                	mov    %ebx,%edx
  802266:	f7 f7                	div    %edi
  802268:	89 d3                	mov    %edx,%ebx
  80226a:	f7 24 24             	mull   (%esp)
  80226d:	89 c6                	mov    %eax,%esi
  80226f:	89 d1                	mov    %edx,%ecx
  802271:	39 d3                	cmp    %edx,%ebx
  802273:	0f 82 87 00 00 00    	jb     802300 <__umoddi3+0x134>
  802279:	0f 84 91 00 00 00    	je     802310 <__umoddi3+0x144>
  80227f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802283:	29 f2                	sub    %esi,%edx
  802285:	19 cb                	sbb    %ecx,%ebx
  802287:	89 d8                	mov    %ebx,%eax
  802289:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80228d:	d3 e0                	shl    %cl,%eax
  80228f:	89 e9                	mov    %ebp,%ecx
  802291:	d3 ea                	shr    %cl,%edx
  802293:	09 d0                	or     %edx,%eax
  802295:	89 e9                	mov    %ebp,%ecx
  802297:	d3 eb                	shr    %cl,%ebx
  802299:	89 da                	mov    %ebx,%edx
  80229b:	83 c4 1c             	add    $0x1c,%esp
  80229e:	5b                   	pop    %ebx
  80229f:	5e                   	pop    %esi
  8022a0:	5f                   	pop    %edi
  8022a1:	5d                   	pop    %ebp
  8022a2:	c3                   	ret    
  8022a3:	90                   	nop
  8022a4:	89 fd                	mov    %edi,%ebp
  8022a6:	85 ff                	test   %edi,%edi
  8022a8:	75 0b                	jne    8022b5 <__umoddi3+0xe9>
  8022aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8022af:	31 d2                	xor    %edx,%edx
  8022b1:	f7 f7                	div    %edi
  8022b3:	89 c5                	mov    %eax,%ebp
  8022b5:	89 f0                	mov    %esi,%eax
  8022b7:	31 d2                	xor    %edx,%edx
  8022b9:	f7 f5                	div    %ebp
  8022bb:	89 c8                	mov    %ecx,%eax
  8022bd:	f7 f5                	div    %ebp
  8022bf:	89 d0                	mov    %edx,%eax
  8022c1:	e9 44 ff ff ff       	jmp    80220a <__umoddi3+0x3e>
  8022c6:	66 90                	xchg   %ax,%ax
  8022c8:	89 c8                	mov    %ecx,%eax
  8022ca:	89 f2                	mov    %esi,%edx
  8022cc:	83 c4 1c             	add    $0x1c,%esp
  8022cf:	5b                   	pop    %ebx
  8022d0:	5e                   	pop    %esi
  8022d1:	5f                   	pop    %edi
  8022d2:	5d                   	pop    %ebp
  8022d3:	c3                   	ret    
  8022d4:	3b 04 24             	cmp    (%esp),%eax
  8022d7:	72 06                	jb     8022df <__umoddi3+0x113>
  8022d9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022dd:	77 0f                	ja     8022ee <__umoddi3+0x122>
  8022df:	89 f2                	mov    %esi,%edx
  8022e1:	29 f9                	sub    %edi,%ecx
  8022e3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022e7:	89 14 24             	mov    %edx,(%esp)
  8022ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ee:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022f2:	8b 14 24             	mov    (%esp),%edx
  8022f5:	83 c4 1c             	add    $0x1c,%esp
  8022f8:	5b                   	pop    %ebx
  8022f9:	5e                   	pop    %esi
  8022fa:	5f                   	pop    %edi
  8022fb:	5d                   	pop    %ebp
  8022fc:	c3                   	ret    
  8022fd:	8d 76 00             	lea    0x0(%esi),%esi
  802300:	2b 04 24             	sub    (%esp),%eax
  802303:	19 fa                	sbb    %edi,%edx
  802305:	89 d1                	mov    %edx,%ecx
  802307:	89 c6                	mov    %eax,%esi
  802309:	e9 71 ff ff ff       	jmp    80227f <__umoddi3+0xb3>
  80230e:	66 90                	xchg   %ax,%ax
  802310:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802314:	72 ea                	jb     802300 <__umoddi3+0x134>
  802316:	89 d9                	mov    %ebx,%ecx
  802318:	e9 62 ff ff ff       	jmp    80227f <__umoddi3+0xb3>
