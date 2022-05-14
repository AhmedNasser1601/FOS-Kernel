
obj/user/quicksort_semaphore:     file format elf32-i386


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
  800031:	e8 72 06 00 00       	call   8006a8 <libmain>
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
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	int envID = sys_getenvid();
  800042:	e8 db 1c 00 00       	call   801d22 <sys_getenvid>
  800047:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  80004a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	sys_createSemaphore("IO.CS", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 20 25 80 00       	push   $0x802520
  80005b:	e8 ea 1e 00 00       	call   801f4a <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 9e 1d 00 00       	call   801e06 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 b0 1d 00 00       	call   801e1f <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 ec             	mov    %eax,-0x14(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_waitSemaphore(envID, "IO.CS");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 20 25 80 00       	push   $0x802520
  80007f:	ff 75 f0             	pushl  -0x10(%ebp)
  800082:	e8 fc 1e 00 00       	call   801f83 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
			readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 28 25 80 00       	push   $0x802528
  800099:	e8 4f 10 00 00       	call   8010ed <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 9f 15 00 00       	call   801653 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 32 19 00 00       	call   8019fb <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 48 25 80 00       	push   $0x802548
  8000d7:	e8 8f 09 00 00       	call   800a6b <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 6b 25 80 00       	push   $0x80256b
  8000e7:	e8 7f 09 00 00       	call   800a6b <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	68 79 25 80 00       	push   $0x802579
  8000f7:	e8 6f 09 00 00       	call   800a6b <cprintf>
  8000fc:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 88 25 80 00       	push   $0x802588
  800107:	e8 5f 09 00 00       	call   800a6b <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80010f:	e8 3c 05 00 00       	call   800650 <getchar>
  800114:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  800117:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	50                   	push   %eax
  80011f:	e8 e4 04 00 00       	call   800608 <cputchar>
  800124:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	6a 0a                	push   $0xa
  80012c:	e8 d7 04 00 00       	call   800608 <cputchar>
  800131:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "IO.CS");
  800134:	83 ec 08             	sub    $0x8,%esp
  800137:	68 20 25 80 00       	push   $0x802520
  80013c:	ff 75 f0             	pushl  -0x10(%ebp)
  80013f:	e8 5d 1e 00 00       	call   801fa1 <sys_signalSemaphore>
  800144:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800147:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80014b:	83 f8 62             	cmp    $0x62,%eax
  80014e:	74 1d                	je     80016d <_main+0x135>
  800150:	83 f8 63             	cmp    $0x63,%eax
  800153:	74 2b                	je     800180 <_main+0x148>
  800155:	83 f8 61             	cmp    $0x61,%eax
  800158:	75 39                	jne    800193 <_main+0x15b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80015a:	83 ec 08             	sub    $0x8,%esp
  80015d:	ff 75 e8             	pushl  -0x18(%ebp)
  800160:	ff 75 e4             	pushl  -0x1c(%ebp)
  800163:	e8 3a 03 00 00       	call   8004a2 <InitializeAscending>
  800168:	83 c4 10             	add    $0x10,%esp
			break ;
  80016b:	eb 37                	jmp    8001a4 <_main+0x16c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80016d:	83 ec 08             	sub    $0x8,%esp
  800170:	ff 75 e8             	pushl  -0x18(%ebp)
  800173:	ff 75 e4             	pushl  -0x1c(%ebp)
  800176:	e8 58 03 00 00       	call   8004d3 <InitializeDescending>
  80017b:	83 c4 10             	add    $0x10,%esp
			break ;
  80017e:	eb 24                	jmp    8001a4 <_main+0x16c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800180:	83 ec 08             	sub    $0x8,%esp
  800183:	ff 75 e8             	pushl  -0x18(%ebp)
  800186:	ff 75 e4             	pushl  -0x1c(%ebp)
  800189:	e8 7a 03 00 00       	call   800508 <InitializeSemiRandom>
  80018e:	83 c4 10             	add    $0x10,%esp
			break ;
  800191:	eb 11                	jmp    8001a4 <_main+0x16c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800193:	83 ec 08             	sub    $0x8,%esp
  800196:	ff 75 e8             	pushl  -0x18(%ebp)
  800199:	ff 75 e4             	pushl  -0x1c(%ebp)
  80019c:	e8 67 03 00 00       	call   800508 <InitializeSemiRandom>
  8001a1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001a4:	83 ec 08             	sub    $0x8,%esp
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001ad:	e8 35 01 00 00       	call   8002e7 <QuickSort>
  8001b2:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001be:	e8 35 02 00 00       	call   8003f8 <CheckSorted>
  8001c3:	83 c4 10             	add    $0x10,%esp
  8001c6:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001c9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001cd:	75 14                	jne    8001e3 <_main+0x1ab>
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	68 a0 25 80 00       	push   $0x8025a0
  8001d7:	6a 45                	push   $0x45
  8001d9:	68 c2 25 80 00       	push   $0x8025c2
  8001de:	e8 d4 05 00 00       	call   8007b7 <_panic>
		else
		{
			sys_waitSemaphore(envID, "IO.CS");
  8001e3:	83 ec 08             	sub    $0x8,%esp
  8001e6:	68 20 25 80 00       	push   $0x802520
  8001eb:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ee:	e8 90 1d 00 00       	call   801f83 <sys_waitSemaphore>
  8001f3:	83 c4 10             	add    $0x10,%esp
				cprintf("\n===============================================\n") ;
  8001f6:	83 ec 0c             	sub    $0xc,%esp
  8001f9:	68 e0 25 80 00       	push   $0x8025e0
  8001fe:	e8 68 08 00 00       	call   800a6b <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800206:	83 ec 0c             	sub    $0xc,%esp
  800209:	68 14 26 80 00       	push   $0x802614
  80020e:	e8 58 08 00 00       	call   800a6b <cprintf>
  800213:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	68 48 26 80 00       	push   $0x802648
  80021e:	e8 48 08 00 00       	call   800a6b <cprintf>
  800223:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "IO.CS");
  800226:	83 ec 08             	sub    $0x8,%esp
  800229:	68 20 25 80 00       	push   $0x802520
  80022e:	ff 75 f0             	pushl  -0x10(%ebp)
  800231:	e8 6b 1d 00 00       	call   801fa1 <sys_signalSemaphore>
  800236:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "IO.CS");
  800239:	83 ec 08             	sub    $0x8,%esp
  80023c:	68 20 25 80 00       	push   $0x802520
  800241:	ff 75 f0             	pushl  -0x10(%ebp)
  800244:	e8 3a 1d 00 00       	call   801f83 <sys_waitSemaphore>
  800249:	83 c4 10             	add    $0x10,%esp
			cprintf("Freeing the Heap...\n\n") ;
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	68 7a 26 80 00       	push   $0x80267a
  800254:	e8 12 08 00 00       	call   800a6b <cprintf>
  800259:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "IO.CS");
  80025c:	83 ec 08             	sub    $0x8,%esp
  80025f:	68 20 25 80 00       	push   $0x802520
  800264:	ff 75 f0             	pushl  -0x10(%ebp)
  800267:	e8 35 1d 00 00       	call   801fa1 <sys_signalSemaphore>
  80026c:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "IO.CS");
  80026f:	83 ec 08             	sub    $0x8,%esp
  800272:	68 20 25 80 00       	push   $0x802520
  800277:	ff 75 f0             	pushl  -0x10(%ebp)
  80027a:	e8 04 1d 00 00       	call   801f83 <sys_waitSemaphore>
  80027f:	83 c4 10             	add    $0x10,%esp
			cprintf("Do you want to repeat (y/n): ") ;
  800282:	83 ec 0c             	sub    $0xc,%esp
  800285:	68 90 26 80 00       	push   $0x802690
  80028a:	e8 dc 07 00 00       	call   800a6b <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800292:	e8 b9 03 00 00       	call   800650 <getchar>
  800297:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  80029a:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80029e:	83 ec 0c             	sub    $0xc,%esp
  8002a1:	50                   	push   %eax
  8002a2:	e8 61 03 00 00       	call   800608 <cputchar>
  8002a7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002aa:	83 ec 0c             	sub    $0xc,%esp
  8002ad:	6a 0a                	push   $0xa
  8002af:	e8 54 03 00 00       	call   800608 <cputchar>
  8002b4:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002b7:	83 ec 0c             	sub    $0xc,%esp
  8002ba:	6a 0a                	push   $0xa
  8002bc:	e8 47 03 00 00       	call   800608 <cputchar>
  8002c1:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "IO.CS");
  8002c4:	83 ec 08             	sub    $0x8,%esp
  8002c7:	68 20 25 80 00       	push   $0x802520
  8002cc:	ff 75 f0             	pushl  -0x10(%ebp)
  8002cf:	e8 cd 1c 00 00       	call   801fa1 <sys_signalSemaphore>
  8002d4:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002d7:	80 7d e3 79          	cmpb   $0x79,-0x1d(%ebp)
  8002db:	0f 84 82 fd ff ff    	je     800063 <_main+0x2b>

}
  8002e1:	90                   	nop
  8002e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002e5:	c9                   	leave  
  8002e6:	c3                   	ret    

008002e7 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002e7:	55                   	push   %ebp
  8002e8:	89 e5                	mov    %esp,%ebp
  8002ea:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f0:	48                   	dec    %eax
  8002f1:	50                   	push   %eax
  8002f2:	6a 00                	push   $0x0
  8002f4:	ff 75 0c             	pushl  0xc(%ebp)
  8002f7:	ff 75 08             	pushl  0x8(%ebp)
  8002fa:	e8 06 00 00 00       	call   800305 <QSort>
  8002ff:	83 c4 10             	add    $0x10,%esp
}
  800302:	90                   	nop
  800303:	c9                   	leave  
  800304:	c3                   	ret    

00800305 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800305:	55                   	push   %ebp
  800306:	89 e5                	mov    %esp,%ebp
  800308:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80030b:	8b 45 10             	mov    0x10(%ebp),%eax
  80030e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800311:	0f 8d de 00 00 00    	jge    8003f5 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800317:	8b 45 10             	mov    0x10(%ebp),%eax
  80031a:	40                   	inc    %eax
  80031b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80031e:	8b 45 14             	mov    0x14(%ebp),%eax
  800321:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800324:	e9 80 00 00 00       	jmp    8003a9 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800329:	ff 45 f4             	incl   -0xc(%ebp)
  80032c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032f:	3b 45 14             	cmp    0x14(%ebp),%eax
  800332:	7f 2b                	jg     80035f <QSort+0x5a>
  800334:	8b 45 10             	mov    0x10(%ebp),%eax
  800337:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033e:	8b 45 08             	mov    0x8(%ebp),%eax
  800341:	01 d0                	add    %edx,%eax
  800343:	8b 10                	mov    (%eax),%edx
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	01 c8                	add    %ecx,%eax
  800354:	8b 00                	mov    (%eax),%eax
  800356:	39 c2                	cmp    %eax,%edx
  800358:	7d cf                	jge    800329 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80035a:	eb 03                	jmp    80035f <QSort+0x5a>
  80035c:	ff 4d f0             	decl   -0x10(%ebp)
  80035f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800362:	3b 45 10             	cmp    0x10(%ebp),%eax
  800365:	7e 26                	jle    80038d <QSort+0x88>
  800367:	8b 45 10             	mov    0x10(%ebp),%eax
  80036a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800371:	8b 45 08             	mov    0x8(%ebp),%eax
  800374:	01 d0                	add    %edx,%eax
  800376:	8b 10                	mov    (%eax),%edx
  800378:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	01 c8                	add    %ecx,%eax
  800387:	8b 00                	mov    (%eax),%eax
  800389:	39 c2                	cmp    %eax,%edx
  80038b:	7e cf                	jle    80035c <QSort+0x57>

		if (i <= j)
  80038d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800390:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800393:	7f 14                	jg     8003a9 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800395:	83 ec 04             	sub    $0x4,%esp
  800398:	ff 75 f0             	pushl  -0x10(%ebp)
  80039b:	ff 75 f4             	pushl  -0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	e8 a9 00 00 00       	call   80044f <Swap>
  8003a6:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003af:	0f 8e 77 ff ff ff    	jle    80032c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003b5:	83 ec 04             	sub    $0x4,%esp
  8003b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8003bb:	ff 75 10             	pushl  0x10(%ebp)
  8003be:	ff 75 08             	pushl  0x8(%ebp)
  8003c1:	e8 89 00 00 00       	call   80044f <Swap>
  8003c6:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cc:	48                   	dec    %eax
  8003cd:	50                   	push   %eax
  8003ce:	ff 75 10             	pushl  0x10(%ebp)
  8003d1:	ff 75 0c             	pushl  0xc(%ebp)
  8003d4:	ff 75 08             	pushl  0x8(%ebp)
  8003d7:	e8 29 ff ff ff       	call   800305 <QSort>
  8003dc:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003df:	ff 75 14             	pushl  0x14(%ebp)
  8003e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8003e5:	ff 75 0c             	pushl  0xc(%ebp)
  8003e8:	ff 75 08             	pushl  0x8(%ebp)
  8003eb:	e8 15 ff ff ff       	call   800305 <QSort>
  8003f0:	83 c4 10             	add    $0x10,%esp
  8003f3:	eb 01                	jmp    8003f6 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003f5:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8003f6:	c9                   	leave  
  8003f7:	c3                   	ret    

008003f8 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003f8:	55                   	push   %ebp
  8003f9:	89 e5                	mov    %esp,%ebp
  8003fb:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800405:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80040c:	eb 33                	jmp    800441 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80040e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800411:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	01 d0                	add    %edx,%eax
  80041d:	8b 10                	mov    (%eax),%edx
  80041f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800422:	40                   	inc    %eax
  800423:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	01 c8                	add    %ecx,%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	39 c2                	cmp    %eax,%edx
  800433:	7e 09                	jle    80043e <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800435:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80043c:	eb 0c                	jmp    80044a <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80043e:	ff 45 f8             	incl   -0x8(%ebp)
  800441:	8b 45 0c             	mov    0xc(%ebp),%eax
  800444:	48                   	dec    %eax
  800445:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800448:	7f c4                	jg     80040e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80044d:	c9                   	leave  
  80044e:	c3                   	ret    

0080044f <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80044f:	55                   	push   %ebp
  800450:	89 e5                	mov    %esp,%ebp
  800452:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800455:	8b 45 0c             	mov    0xc(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 d0                	add    %edx,%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	01 c2                	add    %eax,%edx
  800478:	8b 45 10             	mov    0x10(%ebp),%eax
  80047b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	01 c8                	add    %ecx,%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80048b:	8b 45 10             	mov    0x10(%ebp),%eax
  80048e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	01 c2                	add    %eax,%edx
  80049a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049d:	89 02                	mov    %eax,(%edx)
}
  80049f:	90                   	nop
  8004a0:	c9                   	leave  
  8004a1:	c3                   	ret    

008004a2 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004a2:	55                   	push   %ebp
  8004a3:	89 e5                	mov    %esp,%ebp
  8004a5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004af:	eb 17                	jmp    8004c8 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004be:	01 c2                	add    %eax,%edx
  8004c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c3:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c5:	ff 45 fc             	incl   -0x4(%ebp)
  8004c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ce:	7c e1                	jl     8004b1 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004d0:	90                   	nop
  8004d1:	c9                   	leave  
  8004d2:	c3                   	ret    

008004d3 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004d3:	55                   	push   %ebp
  8004d4:	89 e5                	mov    %esp,%ebp
  8004d6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e0:	eb 1b                	jmp    8004fd <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ef:	01 c2                	add    %eax,%edx
  8004f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f4:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004f7:	48                   	dec    %eax
  8004f8:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	ff 45 fc             	incl   -0x4(%ebp)
  8004fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800500:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800503:	7c dd                	jl     8004e2 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800505:	90                   	nop
  800506:	c9                   	leave  
  800507:	c3                   	ret    

00800508 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800508:	55                   	push   %ebp
  800509:	89 e5                	mov    %esp,%ebp
  80050b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80050e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800511:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800516:	f7 e9                	imul   %ecx
  800518:	c1 f9 1f             	sar    $0x1f,%ecx
  80051b:	89 d0                	mov    %edx,%eax
  80051d:	29 c8                	sub    %ecx,%eax
  80051f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800522:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800529:	eb 1e                	jmp    800549 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80052b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80052e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
  800538:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80053b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80053e:	99                   	cltd   
  80053f:	f7 7d f8             	idivl  -0x8(%ebp)
  800542:	89 d0                	mov    %edx,%eax
  800544:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800546:	ff 45 fc             	incl   -0x4(%ebp)
  800549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054f:	7c da                	jl     80052b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800551:	90                   	nop
  800552:	c9                   	leave  
  800553:	c3                   	ret    

00800554 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800554:	55                   	push   %ebp
  800555:	89 e5                	mov    %esp,%ebp
  800557:	83 ec 18             	sub    $0x18,%esp
	int envID = sys_getenvid();
  80055a:	e8 c3 17 00 00       	call   801d22 <sys_getenvid>
  80055f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_waitSemaphore(envID, "IO.CS");
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	68 20 25 80 00       	push   $0x802520
  80056a:	ff 75 f0             	pushl  -0x10(%ebp)
  80056d:	e8 11 1a 00 00       	call   801f83 <sys_waitSemaphore>
  800572:	83 c4 10             	add    $0x10,%esp
		int i ;
		int NumsPerLine = 20 ;
  800575:	c7 45 ec 14 00 00 00 	movl   $0x14,-0x14(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  80057c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800583:	eb 42                	jmp    8005c7 <PrintElements+0x73>
		{
			if (i%NumsPerLine == 0)
  800585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800588:	99                   	cltd   
  800589:	f7 7d ec             	idivl  -0x14(%ebp)
  80058c:	89 d0                	mov    %edx,%eax
  80058e:	85 c0                	test   %eax,%eax
  800590:	75 10                	jne    8005a2 <PrintElements+0x4e>
				cprintf("\n");
  800592:	83 ec 0c             	sub    $0xc,%esp
  800595:	68 ae 26 80 00       	push   $0x8026ae
  80059a:	e8 cc 04 00 00       	call   800a6b <cprintf>
  80059f:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8005a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	83 ec 08             	sub    $0x8,%esp
  8005b6:	50                   	push   %eax
  8005b7:	68 b0 26 80 00       	push   $0x8026b0
  8005bc:	e8 aa 04 00 00       	call   800a6b <cprintf>
  8005c1:	83 c4 10             	add    $0x10,%esp
{
	int envID = sys_getenvid();
	sys_waitSemaphore(envID, "IO.CS");
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8005c4:	ff 45 f4             	incl   -0xc(%ebp)
  8005c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ca:	48                   	dec    %eax
  8005cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005ce:	7f b5                	jg     800585 <PrintElements+0x31>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  8005d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	83 ec 08             	sub    $0x8,%esp
  8005e4:	50                   	push   %eax
  8005e5:	68 b5 26 80 00       	push   $0x8026b5
  8005ea:	e8 7c 04 00 00       	call   800a6b <cprintf>
  8005ef:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(envID, "IO.CS");
  8005f2:	83 ec 08             	sub    $0x8,%esp
  8005f5:	68 20 25 80 00       	push   $0x802520
  8005fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8005fd:	e8 9f 19 00 00       	call   801fa1 <sys_signalSemaphore>
  800602:	83 c4 10             	add    $0x10,%esp
}
  800605:	90                   	nop
  800606:	c9                   	leave  
  800607:	c3                   	ret    

00800608 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800608:	55                   	push   %ebp
  800609:	89 e5                	mov    %esp,%ebp
  80060b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80060e:	8b 45 08             	mov    0x8(%ebp),%eax
  800611:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800614:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800618:	83 ec 0c             	sub    $0xc,%esp
  80061b:	50                   	push   %eax
  80061c:	e8 e9 18 00 00       	call   801f0a <sys_cputc>
  800621:	83 c4 10             	add    $0x10,%esp
}
  800624:	90                   	nop
  800625:	c9                   	leave  
  800626:	c3                   	ret    

00800627 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800627:	55                   	push   %ebp
  800628:	89 e5                	mov    %esp,%ebp
  80062a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80062d:	e8 a4 18 00 00       	call   801ed6 <sys_disable_interrupt>
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 c5 18 00 00       	call   801f0a <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800648:	e8 a3 18 00 00       	call   801ef0 <sys_enable_interrupt>
}
  80064d:	90                   	nop
  80064e:	c9                   	leave  
  80064f:	c3                   	ret    

00800650 <getchar>:

int
getchar(void)
{
  800650:	55                   	push   %ebp
  800651:	89 e5                	mov    %esp,%ebp
  800653:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800656:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80065d:	eb 08                	jmp    800667 <getchar+0x17>
	{
		c = sys_cgetc();
  80065f:	e8 8a 16 00 00       	call   801cee <sys_cgetc>
  800664:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800667:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80066b:	74 f2                	je     80065f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80066d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800670:	c9                   	leave  
  800671:	c3                   	ret    

00800672 <atomic_getchar>:

int
atomic_getchar(void)
{
  800672:	55                   	push   %ebp
  800673:	89 e5                	mov    %esp,%ebp
  800675:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800678:	e8 59 18 00 00       	call   801ed6 <sys_disable_interrupt>
	int c=0;
  80067d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800684:	eb 08                	jmp    80068e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800686:	e8 63 16 00 00       	call   801cee <sys_cgetc>
  80068b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80068e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800692:	74 f2                	je     800686 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800694:	e8 57 18 00 00       	call   801ef0 <sys_enable_interrupt>
	return c;
  800699:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80069c:	c9                   	leave  
  80069d:	c3                   	ret    

0080069e <iscons>:

int iscons(int fdnum)
{
  80069e:	55                   	push   %ebp
  80069f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006a1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006a6:	5d                   	pop    %ebp
  8006a7:	c3                   	ret    

008006a8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
  8006ab:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006ae:	e8 88 16 00 00       	call   801d3b <sys_getenvindex>
  8006b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b9:	89 d0                	mov    %edx,%eax
  8006bb:	c1 e0 02             	shl    $0x2,%eax
  8006be:	01 d0                	add    %edx,%eax
  8006c0:	01 c0                	add    %eax,%eax
  8006c2:	01 d0                	add    %edx,%eax
  8006c4:	01 c0                	add    %eax,%eax
  8006c6:	01 d0                	add    %edx,%eax
  8006c8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8006cf:	01 d0                	add    %edx,%eax
  8006d1:	c1 e0 02             	shl    $0x2,%eax
  8006d4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006d9:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006de:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e3:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006e9:	84 c0                	test   %al,%al
  8006eb:	74 0f                	je     8006fc <libmain+0x54>
		binaryname = myEnv->prog_name;
  8006ed:	a1 24 30 80 00       	mov    0x803024,%eax
  8006f2:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006f7:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800700:	7e 0a                	jle    80070c <libmain+0x64>
		binaryname = argv[0];
  800702:	8b 45 0c             	mov    0xc(%ebp),%eax
  800705:	8b 00                	mov    (%eax),%eax
  800707:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80070c:	83 ec 08             	sub    $0x8,%esp
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	ff 75 08             	pushl  0x8(%ebp)
  800715:	e8 1e f9 ff ff       	call   800038 <_main>
  80071a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80071d:	e8 b4 17 00 00       	call   801ed6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800722:	83 ec 0c             	sub    $0xc,%esp
  800725:	68 d4 26 80 00       	push   $0x8026d4
  80072a:	e8 3c 03 00 00       	call   800a6b <cprintf>
  80072f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800732:	a1 24 30 80 00       	mov    0x803024,%eax
  800737:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80073d:	a1 24 30 80 00       	mov    0x803024,%eax
  800742:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800748:	83 ec 04             	sub    $0x4,%esp
  80074b:	52                   	push   %edx
  80074c:	50                   	push   %eax
  80074d:	68 fc 26 80 00       	push   $0x8026fc
  800752:	e8 14 03 00 00       	call   800a6b <cprintf>
  800757:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80075a:	a1 24 30 80 00       	mov    0x803024,%eax
  80075f:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	50                   	push   %eax
  800769:	68 21 27 80 00       	push   $0x802721
  80076e:	e8 f8 02 00 00       	call   800a6b <cprintf>
  800773:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800776:	83 ec 0c             	sub    $0xc,%esp
  800779:	68 d4 26 80 00       	push   $0x8026d4
  80077e:	e8 e8 02 00 00       	call   800a6b <cprintf>
  800783:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800786:	e8 65 17 00 00       	call   801ef0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80078b:	e8 19 00 00 00       	call   8007a9 <exit>
}
  800790:	90                   	nop
  800791:	c9                   	leave  
  800792:	c3                   	ret    

00800793 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800793:	55                   	push   %ebp
  800794:	89 e5                	mov    %esp,%ebp
  800796:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800799:	83 ec 0c             	sub    $0xc,%esp
  80079c:	6a 00                	push   $0x0
  80079e:	e8 64 15 00 00       	call   801d07 <sys_env_destroy>
  8007a3:	83 c4 10             	add    $0x10,%esp
}
  8007a6:	90                   	nop
  8007a7:	c9                   	leave  
  8007a8:	c3                   	ret    

008007a9 <exit>:

void
exit(void)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007af:	e8 b9 15 00 00       	call   801d6d <sys_env_exit>
}
  8007b4:	90                   	nop
  8007b5:	c9                   	leave  
  8007b6:	c3                   	ret    

008007b7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007b7:	55                   	push   %ebp
  8007b8:	89 e5                	mov    %esp,%ebp
  8007ba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007bd:	8d 45 10             	lea    0x10(%ebp),%eax
  8007c0:	83 c0 04             	add    $0x4,%eax
  8007c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007c6:	a1 38 30 80 00       	mov    0x803038,%eax
  8007cb:	85 c0                	test   %eax,%eax
  8007cd:	74 16                	je     8007e5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007cf:	a1 38 30 80 00       	mov    0x803038,%eax
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	50                   	push   %eax
  8007d8:	68 38 27 80 00       	push   $0x802738
  8007dd:	e8 89 02 00 00       	call   800a6b <cprintf>
  8007e2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007e5:	a1 00 30 80 00       	mov    0x803000,%eax
  8007ea:	ff 75 0c             	pushl  0xc(%ebp)
  8007ed:	ff 75 08             	pushl  0x8(%ebp)
  8007f0:	50                   	push   %eax
  8007f1:	68 3d 27 80 00       	push   $0x80273d
  8007f6:	e8 70 02 00 00       	call   800a6b <cprintf>
  8007fb:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 f4             	pushl  -0xc(%ebp)
  800807:	50                   	push   %eax
  800808:	e8 f3 01 00 00       	call   800a00 <vcprintf>
  80080d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	6a 00                	push   $0x0
  800815:	68 59 27 80 00       	push   $0x802759
  80081a:	e8 e1 01 00 00       	call   800a00 <vcprintf>
  80081f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800822:	e8 82 ff ff ff       	call   8007a9 <exit>

	// should not return here
	while (1) ;
  800827:	eb fe                	jmp    800827 <_panic+0x70>

00800829 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800829:	55                   	push   %ebp
  80082a:	89 e5                	mov    %esp,%ebp
  80082c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80082f:	a1 24 30 80 00       	mov    0x803024,%eax
  800834:	8b 50 74             	mov    0x74(%eax),%edx
  800837:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083a:	39 c2                	cmp    %eax,%edx
  80083c:	74 14                	je     800852 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80083e:	83 ec 04             	sub    $0x4,%esp
  800841:	68 5c 27 80 00       	push   $0x80275c
  800846:	6a 26                	push   $0x26
  800848:	68 a8 27 80 00       	push   $0x8027a8
  80084d:	e8 65 ff ff ff       	call   8007b7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800852:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800859:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800860:	e9 c2 00 00 00       	jmp    800927 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800865:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800868:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	01 d0                	add    %edx,%eax
  800874:	8b 00                	mov    (%eax),%eax
  800876:	85 c0                	test   %eax,%eax
  800878:	75 08                	jne    800882 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80087a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80087d:	e9 a2 00 00 00       	jmp    800924 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800882:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800889:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800890:	eb 69                	jmp    8008fb <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800892:	a1 24 30 80 00       	mov    0x803024,%eax
  800897:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80089d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008a0:	89 d0                	mov    %edx,%eax
  8008a2:	01 c0                	add    %eax,%eax
  8008a4:	01 d0                	add    %edx,%eax
  8008a6:	c1 e0 02             	shl    $0x2,%eax
  8008a9:	01 c8                	add    %ecx,%eax
  8008ab:	8a 40 04             	mov    0x4(%eax),%al
  8008ae:	84 c0                	test   %al,%al
  8008b0:	75 46                	jne    8008f8 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008b2:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008c0:	89 d0                	mov    %edx,%eax
  8008c2:	01 c0                	add    %eax,%eax
  8008c4:	01 d0                	add    %edx,%eax
  8008c6:	c1 e0 02             	shl    $0x2,%eax
  8008c9:	01 c8                	add    %ecx,%eax
  8008cb:	8b 00                	mov    (%eax),%eax
  8008cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008d8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	01 c8                	add    %ecx,%eax
  8008e9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008eb:	39 c2                	cmp    %eax,%edx
  8008ed:	75 09                	jne    8008f8 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008ef:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008f6:	eb 12                	jmp    80090a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f8:	ff 45 e8             	incl   -0x18(%ebp)
  8008fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800900:	8b 50 74             	mov    0x74(%eax),%edx
  800903:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800906:	39 c2                	cmp    %eax,%edx
  800908:	77 88                	ja     800892 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80090a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80090e:	75 14                	jne    800924 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800910:	83 ec 04             	sub    $0x4,%esp
  800913:	68 b4 27 80 00       	push   $0x8027b4
  800918:	6a 3a                	push   $0x3a
  80091a:	68 a8 27 80 00       	push   $0x8027a8
  80091f:	e8 93 fe ff ff       	call   8007b7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800924:	ff 45 f0             	incl   -0x10(%ebp)
  800927:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80092d:	0f 8c 32 ff ff ff    	jl     800865 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800933:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80093a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800941:	eb 26                	jmp    800969 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800943:	a1 24 30 80 00       	mov    0x803024,%eax
  800948:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80094e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800951:	89 d0                	mov    %edx,%eax
  800953:	01 c0                	add    %eax,%eax
  800955:	01 d0                	add    %edx,%eax
  800957:	c1 e0 02             	shl    $0x2,%eax
  80095a:	01 c8                	add    %ecx,%eax
  80095c:	8a 40 04             	mov    0x4(%eax),%al
  80095f:	3c 01                	cmp    $0x1,%al
  800961:	75 03                	jne    800966 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800963:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800966:	ff 45 e0             	incl   -0x20(%ebp)
  800969:	a1 24 30 80 00       	mov    0x803024,%eax
  80096e:	8b 50 74             	mov    0x74(%eax),%edx
  800971:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800974:	39 c2                	cmp    %eax,%edx
  800976:	77 cb                	ja     800943 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800978:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80097b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80097e:	74 14                	je     800994 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800980:	83 ec 04             	sub    $0x4,%esp
  800983:	68 08 28 80 00       	push   $0x802808
  800988:	6a 44                	push   $0x44
  80098a:	68 a8 27 80 00       	push   $0x8027a8
  80098f:	e8 23 fe ff ff       	call   8007b7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800994:	90                   	nop
  800995:	c9                   	leave  
  800996:	c3                   	ret    

00800997 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800997:	55                   	push   %ebp
  800998:	89 e5                	mov    %esp,%ebp
  80099a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80099d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a0:	8b 00                	mov    (%eax),%eax
  8009a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8009a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a8:	89 0a                	mov    %ecx,(%edx)
  8009aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ad:	88 d1                	mov    %dl,%cl
  8009af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009c0:	75 2c                	jne    8009ee <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009c2:	a0 28 30 80 00       	mov    0x803028,%al
  8009c7:	0f b6 c0             	movzbl %al,%eax
  8009ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cd:	8b 12                	mov    (%edx),%edx
  8009cf:	89 d1                	mov    %edx,%ecx
  8009d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d4:	83 c2 08             	add    $0x8,%edx
  8009d7:	83 ec 04             	sub    $0x4,%esp
  8009da:	50                   	push   %eax
  8009db:	51                   	push   %ecx
  8009dc:	52                   	push   %edx
  8009dd:	e8 e3 12 00 00       	call   801cc5 <sys_cputs>
  8009e2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f1:	8b 40 04             	mov    0x4(%eax),%eax
  8009f4:	8d 50 01             	lea    0x1(%eax),%edx
  8009f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fa:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009fd:	90                   	nop
  8009fe:	c9                   	leave  
  8009ff:	c3                   	ret    

00800a00 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
  800a03:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a09:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a10:	00 00 00 
	b.cnt = 0;
  800a13:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a1a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a1d:	ff 75 0c             	pushl  0xc(%ebp)
  800a20:	ff 75 08             	pushl  0x8(%ebp)
  800a23:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a29:	50                   	push   %eax
  800a2a:	68 97 09 80 00       	push   $0x800997
  800a2f:	e8 11 02 00 00       	call   800c45 <vprintfmt>
  800a34:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a37:	a0 28 30 80 00       	mov    0x803028,%al
  800a3c:	0f b6 c0             	movzbl %al,%eax
  800a3f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a45:	83 ec 04             	sub    $0x4,%esp
  800a48:	50                   	push   %eax
  800a49:	52                   	push   %edx
  800a4a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a50:	83 c0 08             	add    $0x8,%eax
  800a53:	50                   	push   %eax
  800a54:	e8 6c 12 00 00       	call   801cc5 <sys_cputs>
  800a59:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a5c:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a63:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a69:	c9                   	leave  
  800a6a:	c3                   	ret    

00800a6b <cprintf>:

int cprintf(const char *fmt, ...) {
  800a6b:	55                   	push   %ebp
  800a6c:	89 e5                	mov    %esp,%ebp
  800a6e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a71:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a78:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	83 ec 08             	sub    $0x8,%esp
  800a84:	ff 75 f4             	pushl  -0xc(%ebp)
  800a87:	50                   	push   %eax
  800a88:	e8 73 ff ff ff       	call   800a00 <vcprintf>
  800a8d:	83 c4 10             	add    $0x10,%esp
  800a90:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a93:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a96:	c9                   	leave  
  800a97:	c3                   	ret    

00800a98 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a98:	55                   	push   %ebp
  800a99:	89 e5                	mov    %esp,%ebp
  800a9b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a9e:	e8 33 14 00 00       	call   801ed6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aa3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab2:	50                   	push   %eax
  800ab3:	e8 48 ff ff ff       	call   800a00 <vcprintf>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800abe:	e8 2d 14 00 00       	call   801ef0 <sys_enable_interrupt>
	return cnt;
  800ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac6:	c9                   	leave  
  800ac7:	c3                   	ret    

00800ac8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ac8:	55                   	push   %ebp
  800ac9:	89 e5                	mov    %esp,%ebp
  800acb:	53                   	push   %ebx
  800acc:	83 ec 14             	sub    $0x14,%esp
  800acf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800adb:	8b 45 18             	mov    0x18(%ebp),%eax
  800ade:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae6:	77 55                	ja     800b3d <printnum+0x75>
  800ae8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aeb:	72 05                	jb     800af2 <printnum+0x2a>
  800aed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800af0:	77 4b                	ja     800b3d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800af2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800af5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800af8:	8b 45 18             	mov    0x18(%ebp),%eax
  800afb:	ba 00 00 00 00       	mov    $0x0,%edx
  800b00:	52                   	push   %edx
  800b01:	50                   	push   %eax
  800b02:	ff 75 f4             	pushl  -0xc(%ebp)
  800b05:	ff 75 f0             	pushl  -0x10(%ebp)
  800b08:	e8 a7 17 00 00       	call   8022b4 <__udivdi3>
  800b0d:	83 c4 10             	add    $0x10,%esp
  800b10:	83 ec 04             	sub    $0x4,%esp
  800b13:	ff 75 20             	pushl  0x20(%ebp)
  800b16:	53                   	push   %ebx
  800b17:	ff 75 18             	pushl  0x18(%ebp)
  800b1a:	52                   	push   %edx
  800b1b:	50                   	push   %eax
  800b1c:	ff 75 0c             	pushl  0xc(%ebp)
  800b1f:	ff 75 08             	pushl  0x8(%ebp)
  800b22:	e8 a1 ff ff ff       	call   800ac8 <printnum>
  800b27:	83 c4 20             	add    $0x20,%esp
  800b2a:	eb 1a                	jmp    800b46 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	ff 75 0c             	pushl  0xc(%ebp)
  800b32:	ff 75 20             	pushl  0x20(%ebp)
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	ff d0                	call   *%eax
  800b3a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b3d:	ff 4d 1c             	decl   0x1c(%ebp)
  800b40:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b44:	7f e6                	jg     800b2c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b46:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b49:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b51:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b54:	53                   	push   %ebx
  800b55:	51                   	push   %ecx
  800b56:	52                   	push   %edx
  800b57:	50                   	push   %eax
  800b58:	e8 67 18 00 00       	call   8023c4 <__umoddi3>
  800b5d:	83 c4 10             	add    $0x10,%esp
  800b60:	05 74 2a 80 00       	add    $0x802a74,%eax
  800b65:	8a 00                	mov    (%eax),%al
  800b67:	0f be c0             	movsbl %al,%eax
  800b6a:	83 ec 08             	sub    $0x8,%esp
  800b6d:	ff 75 0c             	pushl  0xc(%ebp)
  800b70:	50                   	push   %eax
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
}
  800b79:	90                   	nop
  800b7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b82:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b86:	7e 1c                	jle    800ba4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	8d 50 08             	lea    0x8(%eax),%edx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 10                	mov    %edx,(%eax)
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8b 00                	mov    (%eax),%eax
  800b9a:	83 e8 08             	sub    $0x8,%eax
  800b9d:	8b 50 04             	mov    0x4(%eax),%edx
  800ba0:	8b 00                	mov    (%eax),%eax
  800ba2:	eb 40                	jmp    800be4 <getuint+0x65>
	else if (lflag)
  800ba4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba8:	74 1e                	je     800bc8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	8b 00                	mov    (%eax),%eax
  800baf:	8d 50 04             	lea    0x4(%eax),%edx
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	89 10                	mov    %edx,(%eax)
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	8b 00                	mov    (%eax),%eax
  800bbc:	83 e8 04             	sub    $0x4,%eax
  800bbf:	8b 00                	mov    (%eax),%eax
  800bc1:	ba 00 00 00 00       	mov    $0x0,%edx
  800bc6:	eb 1c                	jmp    800be4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	8d 50 04             	lea    0x4(%eax),%edx
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	89 10                	mov    %edx,(%eax)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	83 e8 04             	sub    $0x4,%eax
  800bdd:	8b 00                	mov    (%eax),%eax
  800bdf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800be4:	5d                   	pop    %ebp
  800be5:	c3                   	ret    

00800be6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800be6:	55                   	push   %ebp
  800be7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800be9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bed:	7e 1c                	jle    800c0b <getint+0x25>
		return va_arg(*ap, long long);
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf2:	8b 00                	mov    (%eax),%eax
  800bf4:	8d 50 08             	lea    0x8(%eax),%edx
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	89 10                	mov    %edx,(%eax)
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	8b 00                	mov    (%eax),%eax
  800c01:	83 e8 08             	sub    $0x8,%eax
  800c04:	8b 50 04             	mov    0x4(%eax),%edx
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	eb 38                	jmp    800c43 <getint+0x5d>
	else if (lflag)
  800c0b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c0f:	74 1a                	je     800c2b <getint+0x45>
		return va_arg(*ap, long);
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8b 00                	mov    (%eax),%eax
  800c16:	8d 50 04             	lea    0x4(%eax),%edx
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	89 10                	mov    %edx,(%eax)
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	8b 00                	mov    (%eax),%eax
  800c23:	83 e8 04             	sub    $0x4,%eax
  800c26:	8b 00                	mov    (%eax),%eax
  800c28:	99                   	cltd   
  800c29:	eb 18                	jmp    800c43 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	8d 50 04             	lea    0x4(%eax),%edx
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	89 10                	mov    %edx,(%eax)
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	8b 00                	mov    (%eax),%eax
  800c3d:	83 e8 04             	sub    $0x4,%eax
  800c40:	8b 00                	mov    (%eax),%eax
  800c42:	99                   	cltd   
}
  800c43:	5d                   	pop    %ebp
  800c44:	c3                   	ret    

00800c45 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	56                   	push   %esi
  800c49:	53                   	push   %ebx
  800c4a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c4d:	eb 17                	jmp    800c66 <vprintfmt+0x21>
			if (ch == '\0')
  800c4f:	85 db                	test   %ebx,%ebx
  800c51:	0f 84 af 03 00 00    	je     801006 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c57:	83 ec 08             	sub    $0x8,%esp
  800c5a:	ff 75 0c             	pushl  0xc(%ebp)
  800c5d:	53                   	push   %ebx
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	ff d0                	call   *%eax
  800c63:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c66:	8b 45 10             	mov    0x10(%ebp),%eax
  800c69:	8d 50 01             	lea    0x1(%eax),%edx
  800c6c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6f:	8a 00                	mov    (%eax),%al
  800c71:	0f b6 d8             	movzbl %al,%ebx
  800c74:	83 fb 25             	cmp    $0x25,%ebx
  800c77:	75 d6                	jne    800c4f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c79:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c7d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c84:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c8b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c92:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c99:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9c:	8d 50 01             	lea    0x1(%eax),%edx
  800c9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	0f b6 d8             	movzbl %al,%ebx
  800ca7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800caa:	83 f8 55             	cmp    $0x55,%eax
  800cad:	0f 87 2b 03 00 00    	ja     800fde <vprintfmt+0x399>
  800cb3:	8b 04 85 98 2a 80 00 	mov    0x802a98(,%eax,4),%eax
  800cba:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cbc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cc0:	eb d7                	jmp    800c99 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cc2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cc6:	eb d1                	jmp    800c99 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cc8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ccf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cd2:	89 d0                	mov    %edx,%eax
  800cd4:	c1 e0 02             	shl    $0x2,%eax
  800cd7:	01 d0                	add    %edx,%eax
  800cd9:	01 c0                	add    %eax,%eax
  800cdb:	01 d8                	add    %ebx,%eax
  800cdd:	83 e8 30             	sub    $0x30,%eax
  800ce0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ce3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ceb:	83 fb 2f             	cmp    $0x2f,%ebx
  800cee:	7e 3e                	jle    800d2e <vprintfmt+0xe9>
  800cf0:	83 fb 39             	cmp    $0x39,%ebx
  800cf3:	7f 39                	jg     800d2e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cf8:	eb d5                	jmp    800ccf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cfa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfd:	83 c0 04             	add    $0x4,%eax
  800d00:	89 45 14             	mov    %eax,0x14(%ebp)
  800d03:	8b 45 14             	mov    0x14(%ebp),%eax
  800d06:	83 e8 04             	sub    $0x4,%eax
  800d09:	8b 00                	mov    (%eax),%eax
  800d0b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d0e:	eb 1f                	jmp    800d2f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d14:	79 83                	jns    800c99 <vprintfmt+0x54>
				width = 0;
  800d16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d1d:	e9 77 ff ff ff       	jmp    800c99 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d22:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d29:	e9 6b ff ff ff       	jmp    800c99 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d2e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d2f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d33:	0f 89 60 ff ff ff    	jns    800c99 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d3f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d46:	e9 4e ff ff ff       	jmp    800c99 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d4b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d4e:	e9 46 ff ff ff       	jmp    800c99 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d53:	8b 45 14             	mov    0x14(%ebp),%eax
  800d56:	83 c0 04             	add    $0x4,%eax
  800d59:	89 45 14             	mov    %eax,0x14(%ebp)
  800d5c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5f:	83 e8 04             	sub    $0x4,%eax
  800d62:	8b 00                	mov    (%eax),%eax
  800d64:	83 ec 08             	sub    $0x8,%esp
  800d67:	ff 75 0c             	pushl  0xc(%ebp)
  800d6a:	50                   	push   %eax
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	ff d0                	call   *%eax
  800d70:	83 c4 10             	add    $0x10,%esp
			break;
  800d73:	e9 89 02 00 00       	jmp    801001 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d78:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7b:	83 c0 04             	add    $0x4,%eax
  800d7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d81:	8b 45 14             	mov    0x14(%ebp),%eax
  800d84:	83 e8 04             	sub    $0x4,%eax
  800d87:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d89:	85 db                	test   %ebx,%ebx
  800d8b:	79 02                	jns    800d8f <vprintfmt+0x14a>
				err = -err;
  800d8d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d8f:	83 fb 64             	cmp    $0x64,%ebx
  800d92:	7f 0b                	jg     800d9f <vprintfmt+0x15a>
  800d94:	8b 34 9d e0 28 80 00 	mov    0x8028e0(,%ebx,4),%esi
  800d9b:	85 f6                	test   %esi,%esi
  800d9d:	75 19                	jne    800db8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d9f:	53                   	push   %ebx
  800da0:	68 85 2a 80 00       	push   $0x802a85
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	ff 75 08             	pushl  0x8(%ebp)
  800dab:	e8 5e 02 00 00       	call   80100e <printfmt>
  800db0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800db3:	e9 49 02 00 00       	jmp    801001 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800db8:	56                   	push   %esi
  800db9:	68 8e 2a 80 00       	push   $0x802a8e
  800dbe:	ff 75 0c             	pushl  0xc(%ebp)
  800dc1:	ff 75 08             	pushl  0x8(%ebp)
  800dc4:	e8 45 02 00 00       	call   80100e <printfmt>
  800dc9:	83 c4 10             	add    $0x10,%esp
			break;
  800dcc:	e9 30 02 00 00       	jmp    801001 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd4:	83 c0 04             	add    $0x4,%eax
  800dd7:	89 45 14             	mov    %eax,0x14(%ebp)
  800dda:	8b 45 14             	mov    0x14(%ebp),%eax
  800ddd:	83 e8 04             	sub    $0x4,%eax
  800de0:	8b 30                	mov    (%eax),%esi
  800de2:	85 f6                	test   %esi,%esi
  800de4:	75 05                	jne    800deb <vprintfmt+0x1a6>
				p = "(null)";
  800de6:	be 91 2a 80 00       	mov    $0x802a91,%esi
			if (width > 0 && padc != '-')
  800deb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800def:	7e 6d                	jle    800e5e <vprintfmt+0x219>
  800df1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800df5:	74 67                	je     800e5e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800df7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dfa:	83 ec 08             	sub    $0x8,%esp
  800dfd:	50                   	push   %eax
  800dfe:	56                   	push   %esi
  800dff:	e8 12 05 00 00       	call   801316 <strnlen>
  800e04:	83 c4 10             	add    $0x10,%esp
  800e07:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e0a:	eb 16                	jmp    800e22 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e0c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 0c             	pushl  0xc(%ebp)
  800e16:	50                   	push   %eax
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	ff d0                	call   *%eax
  800e1c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e1f:	ff 4d e4             	decl   -0x1c(%ebp)
  800e22:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e26:	7f e4                	jg     800e0c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e28:	eb 34                	jmp    800e5e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e2a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e2e:	74 1c                	je     800e4c <vprintfmt+0x207>
  800e30:	83 fb 1f             	cmp    $0x1f,%ebx
  800e33:	7e 05                	jle    800e3a <vprintfmt+0x1f5>
  800e35:	83 fb 7e             	cmp    $0x7e,%ebx
  800e38:	7e 12                	jle    800e4c <vprintfmt+0x207>
					putch('?', putdat);
  800e3a:	83 ec 08             	sub    $0x8,%esp
  800e3d:	ff 75 0c             	pushl  0xc(%ebp)
  800e40:	6a 3f                	push   $0x3f
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
  800e45:	ff d0                	call   *%eax
  800e47:	83 c4 10             	add    $0x10,%esp
  800e4a:	eb 0f                	jmp    800e5b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e4c:	83 ec 08             	sub    $0x8,%esp
  800e4f:	ff 75 0c             	pushl  0xc(%ebp)
  800e52:	53                   	push   %ebx
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	ff d0                	call   *%eax
  800e58:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e5b:	ff 4d e4             	decl   -0x1c(%ebp)
  800e5e:	89 f0                	mov    %esi,%eax
  800e60:	8d 70 01             	lea    0x1(%eax),%esi
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	0f be d8             	movsbl %al,%ebx
  800e68:	85 db                	test   %ebx,%ebx
  800e6a:	74 24                	je     800e90 <vprintfmt+0x24b>
  800e6c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e70:	78 b8                	js     800e2a <vprintfmt+0x1e5>
  800e72:	ff 4d e0             	decl   -0x20(%ebp)
  800e75:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e79:	79 af                	jns    800e2a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e7b:	eb 13                	jmp    800e90 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e7d:	83 ec 08             	sub    $0x8,%esp
  800e80:	ff 75 0c             	pushl  0xc(%ebp)
  800e83:	6a 20                	push   $0x20
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	ff d0                	call   *%eax
  800e8a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e8d:	ff 4d e4             	decl   -0x1c(%ebp)
  800e90:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e94:	7f e7                	jg     800e7d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e96:	e9 66 01 00 00       	jmp    801001 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e9b:	83 ec 08             	sub    $0x8,%esp
  800e9e:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea4:	50                   	push   %eax
  800ea5:	e8 3c fd ff ff       	call   800be6 <getint>
  800eaa:	83 c4 10             	add    $0x10,%esp
  800ead:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb9:	85 d2                	test   %edx,%edx
  800ebb:	79 23                	jns    800ee0 <vprintfmt+0x29b>
				putch('-', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 2d                	push   $0x2d
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ecd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed3:	f7 d8                	neg    %eax
  800ed5:	83 d2 00             	adc    $0x0,%edx
  800ed8:	f7 da                	neg    %edx
  800eda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800edd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ee0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ee7:	e9 bc 00 00 00       	jmp    800fa8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800eec:	83 ec 08             	sub    $0x8,%esp
  800eef:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef5:	50                   	push   %eax
  800ef6:	e8 84 fc ff ff       	call   800b7f <getuint>
  800efb:	83 c4 10             	add    $0x10,%esp
  800efe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f01:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f04:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f0b:	e9 98 00 00 00       	jmp    800fa8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f10:	83 ec 08             	sub    $0x8,%esp
  800f13:	ff 75 0c             	pushl  0xc(%ebp)
  800f16:	6a 58                	push   $0x58
  800f18:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1b:	ff d0                	call   *%eax
  800f1d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	6a 58                	push   $0x58
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	ff d0                	call   *%eax
  800f2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	ff 75 0c             	pushl  0xc(%ebp)
  800f36:	6a 58                	push   $0x58
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	ff d0                	call   *%eax
  800f3d:	83 c4 10             	add    $0x10,%esp
			break;
  800f40:	e9 bc 00 00 00       	jmp    801001 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f45:	83 ec 08             	sub    $0x8,%esp
  800f48:	ff 75 0c             	pushl  0xc(%ebp)
  800f4b:	6a 30                	push   $0x30
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	ff d0                	call   *%eax
  800f52:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f55:	83 ec 08             	sub    $0x8,%esp
  800f58:	ff 75 0c             	pushl  0xc(%ebp)
  800f5b:	6a 78                	push   $0x78
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	ff d0                	call   *%eax
  800f62:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f65:	8b 45 14             	mov    0x14(%ebp),%eax
  800f68:	83 c0 04             	add    $0x4,%eax
  800f6b:	89 45 14             	mov    %eax,0x14(%ebp)
  800f6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f71:	83 e8 04             	sub    $0x4,%eax
  800f74:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f80:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f87:	eb 1f                	jmp    800fa8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f89:	83 ec 08             	sub    $0x8,%esp
  800f8c:	ff 75 e8             	pushl  -0x18(%ebp)
  800f8f:	8d 45 14             	lea    0x14(%ebp),%eax
  800f92:	50                   	push   %eax
  800f93:	e8 e7 fb ff ff       	call   800b7f <getuint>
  800f98:	83 c4 10             	add    $0x10,%esp
  800f9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fa1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fa8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800faf:	83 ec 04             	sub    $0x4,%esp
  800fb2:	52                   	push   %edx
  800fb3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fb6:	50                   	push   %eax
  800fb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800fba:	ff 75 f0             	pushl  -0x10(%ebp)
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	ff 75 08             	pushl  0x8(%ebp)
  800fc3:	e8 00 fb ff ff       	call   800ac8 <printnum>
  800fc8:	83 c4 20             	add    $0x20,%esp
			break;
  800fcb:	eb 34                	jmp    801001 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fcd:	83 ec 08             	sub    $0x8,%esp
  800fd0:	ff 75 0c             	pushl  0xc(%ebp)
  800fd3:	53                   	push   %ebx
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	ff d0                	call   *%eax
  800fd9:	83 c4 10             	add    $0x10,%esp
			break;
  800fdc:	eb 23                	jmp    801001 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fde:	83 ec 08             	sub    $0x8,%esp
  800fe1:	ff 75 0c             	pushl  0xc(%ebp)
  800fe4:	6a 25                	push   $0x25
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	ff d0                	call   *%eax
  800feb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fee:	ff 4d 10             	decl   0x10(%ebp)
  800ff1:	eb 03                	jmp    800ff6 <vprintfmt+0x3b1>
  800ff3:	ff 4d 10             	decl   0x10(%ebp)
  800ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff9:	48                   	dec    %eax
  800ffa:	8a 00                	mov    (%eax),%al
  800ffc:	3c 25                	cmp    $0x25,%al
  800ffe:	75 f3                	jne    800ff3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801000:	90                   	nop
		}
	}
  801001:	e9 47 fc ff ff       	jmp    800c4d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801006:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801007:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80100a:	5b                   	pop    %ebx
  80100b:	5e                   	pop    %esi
  80100c:	5d                   	pop    %ebp
  80100d:	c3                   	ret    

0080100e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80100e:	55                   	push   %ebp
  80100f:	89 e5                	mov    %esp,%ebp
  801011:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801014:	8d 45 10             	lea    0x10(%ebp),%eax
  801017:	83 c0 04             	add    $0x4,%eax
  80101a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80101d:	8b 45 10             	mov    0x10(%ebp),%eax
  801020:	ff 75 f4             	pushl  -0xc(%ebp)
  801023:	50                   	push   %eax
  801024:	ff 75 0c             	pushl  0xc(%ebp)
  801027:	ff 75 08             	pushl  0x8(%ebp)
  80102a:	e8 16 fc ff ff       	call   800c45 <vprintfmt>
  80102f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801032:	90                   	nop
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	8b 40 08             	mov    0x8(%eax),%eax
  80103e:	8d 50 01             	lea    0x1(%eax),%edx
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801047:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104a:	8b 10                	mov    (%eax),%edx
  80104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104f:	8b 40 04             	mov    0x4(%eax),%eax
  801052:	39 c2                	cmp    %eax,%edx
  801054:	73 12                	jae    801068 <sprintputch+0x33>
		*b->buf++ = ch;
  801056:	8b 45 0c             	mov    0xc(%ebp),%eax
  801059:	8b 00                	mov    (%eax),%eax
  80105b:	8d 48 01             	lea    0x1(%eax),%ecx
  80105e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801061:	89 0a                	mov    %ecx,(%edx)
  801063:	8b 55 08             	mov    0x8(%ebp),%edx
  801066:	88 10                	mov    %dl,(%eax)
}
  801068:	90                   	nop
  801069:	5d                   	pop    %ebp
  80106a:	c3                   	ret    

0080106b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80106b:	55                   	push   %ebp
  80106c:	89 e5                	mov    %esp,%ebp
  80106e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801077:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	01 d0                	add    %edx,%eax
  801082:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801085:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80108c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801090:	74 06                	je     801098 <vsnprintf+0x2d>
  801092:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801096:	7f 07                	jg     80109f <vsnprintf+0x34>
		return -E_INVAL;
  801098:	b8 03 00 00 00       	mov    $0x3,%eax
  80109d:	eb 20                	jmp    8010bf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80109f:	ff 75 14             	pushl  0x14(%ebp)
  8010a2:	ff 75 10             	pushl  0x10(%ebp)
  8010a5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010a8:	50                   	push   %eax
  8010a9:	68 35 10 80 00       	push   $0x801035
  8010ae:	e8 92 fb ff ff       	call   800c45 <vprintfmt>
  8010b3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
  8010c4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010c7:	8d 45 10             	lea    0x10(%ebp),%eax
  8010ca:	83 c0 04             	add    $0x4,%eax
  8010cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d3:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d6:	50                   	push   %eax
  8010d7:	ff 75 0c             	pushl  0xc(%ebp)
  8010da:	ff 75 08             	pushl  0x8(%ebp)
  8010dd:	e8 89 ff ff ff       	call   80106b <vsnprintf>
  8010e2:	83 c4 10             	add    $0x10,%esp
  8010e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010eb:	c9                   	leave  
  8010ec:	c3                   	ret    

008010ed <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010ed:	55                   	push   %ebp
  8010ee:	89 e5                	mov    %esp,%ebp
  8010f0:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f7:	74 13                	je     80110c <readline+0x1f>
		cprintf("%s", prompt);
  8010f9:	83 ec 08             	sub    $0x8,%esp
  8010fc:	ff 75 08             	pushl  0x8(%ebp)
  8010ff:	68 f0 2b 80 00       	push   $0x802bf0
  801104:	e8 62 f9 ff ff       	call   800a6b <cprintf>
  801109:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80110c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801113:	83 ec 0c             	sub    $0xc,%esp
  801116:	6a 00                	push   $0x0
  801118:	e8 81 f5 ff ff       	call   80069e <iscons>
  80111d:	83 c4 10             	add    $0x10,%esp
  801120:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801123:	e8 28 f5 ff ff       	call   800650 <getchar>
  801128:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80112b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80112f:	79 22                	jns    801153 <readline+0x66>
			if (c != -E_EOF)
  801131:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801135:	0f 84 ad 00 00 00    	je     8011e8 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80113b:	83 ec 08             	sub    $0x8,%esp
  80113e:	ff 75 ec             	pushl  -0x14(%ebp)
  801141:	68 f3 2b 80 00       	push   $0x802bf3
  801146:	e8 20 f9 ff ff       	call   800a6b <cprintf>
  80114b:	83 c4 10             	add    $0x10,%esp
			return;
  80114e:	e9 95 00 00 00       	jmp    8011e8 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801153:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801157:	7e 34                	jle    80118d <readline+0xa0>
  801159:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801160:	7f 2b                	jg     80118d <readline+0xa0>
			if (echoing)
  801162:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801166:	74 0e                	je     801176 <readline+0x89>
				cputchar(c);
  801168:	83 ec 0c             	sub    $0xc,%esp
  80116b:	ff 75 ec             	pushl  -0x14(%ebp)
  80116e:	e8 95 f4 ff ff       	call   800608 <cputchar>
  801173:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801176:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801179:	8d 50 01             	lea    0x1(%eax),%edx
  80117c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80117f:	89 c2                	mov    %eax,%edx
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	01 d0                	add    %edx,%eax
  801186:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801189:	88 10                	mov    %dl,(%eax)
  80118b:	eb 56                	jmp    8011e3 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80118d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801191:	75 1f                	jne    8011b2 <readline+0xc5>
  801193:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801197:	7e 19                	jle    8011b2 <readline+0xc5>
			if (echoing)
  801199:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80119d:	74 0e                	je     8011ad <readline+0xc0>
				cputchar(c);
  80119f:	83 ec 0c             	sub    $0xc,%esp
  8011a2:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a5:	e8 5e f4 ff ff       	call   800608 <cputchar>
  8011aa:	83 c4 10             	add    $0x10,%esp

			i--;
  8011ad:	ff 4d f4             	decl   -0xc(%ebp)
  8011b0:	eb 31                	jmp    8011e3 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011b2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011b6:	74 0a                	je     8011c2 <readline+0xd5>
  8011b8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011bc:	0f 85 61 ff ff ff    	jne    801123 <readline+0x36>
			if (echoing)
  8011c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c6:	74 0e                	je     8011d6 <readline+0xe9>
				cputchar(c);
  8011c8:	83 ec 0c             	sub    $0xc,%esp
  8011cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ce:	e8 35 f4 ff ff       	call   800608 <cputchar>
  8011d3:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	01 d0                	add    %edx,%eax
  8011de:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011e1:	eb 06                	jmp    8011e9 <readline+0xfc>
		}
	}
  8011e3:	e9 3b ff ff ff       	jmp    801123 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011e8:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011f1:	e8 e0 0c 00 00       	call   801ed6 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011f6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011fa:	74 13                	je     80120f <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011fc:	83 ec 08             	sub    $0x8,%esp
  8011ff:	ff 75 08             	pushl  0x8(%ebp)
  801202:	68 f0 2b 80 00       	push   $0x802bf0
  801207:	e8 5f f8 ff ff       	call   800a6b <cprintf>
  80120c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80120f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801216:	83 ec 0c             	sub    $0xc,%esp
  801219:	6a 00                	push   $0x0
  80121b:	e8 7e f4 ff ff       	call   80069e <iscons>
  801220:	83 c4 10             	add    $0x10,%esp
  801223:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801226:	e8 25 f4 ff ff       	call   800650 <getchar>
  80122b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80122e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801232:	79 23                	jns    801257 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801234:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801238:	74 13                	je     80124d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80123a:	83 ec 08             	sub    $0x8,%esp
  80123d:	ff 75 ec             	pushl  -0x14(%ebp)
  801240:	68 f3 2b 80 00       	push   $0x802bf3
  801245:	e8 21 f8 ff ff       	call   800a6b <cprintf>
  80124a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80124d:	e8 9e 0c 00 00       	call   801ef0 <sys_enable_interrupt>
			return;
  801252:	e9 9a 00 00 00       	jmp    8012f1 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801257:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80125b:	7e 34                	jle    801291 <atomic_readline+0xa6>
  80125d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801264:	7f 2b                	jg     801291 <atomic_readline+0xa6>
			if (echoing)
  801266:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80126a:	74 0e                	je     80127a <atomic_readline+0x8f>
				cputchar(c);
  80126c:	83 ec 0c             	sub    $0xc,%esp
  80126f:	ff 75 ec             	pushl  -0x14(%ebp)
  801272:	e8 91 f3 ff ff       	call   800608 <cputchar>
  801277:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80127a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80127d:	8d 50 01             	lea    0x1(%eax),%edx
  801280:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801283:	89 c2                	mov    %eax,%edx
  801285:	8b 45 0c             	mov    0xc(%ebp),%eax
  801288:	01 d0                	add    %edx,%eax
  80128a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80128d:	88 10                	mov    %dl,(%eax)
  80128f:	eb 5b                	jmp    8012ec <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801291:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801295:	75 1f                	jne    8012b6 <atomic_readline+0xcb>
  801297:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80129b:	7e 19                	jle    8012b6 <atomic_readline+0xcb>
			if (echoing)
  80129d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012a1:	74 0e                	je     8012b1 <atomic_readline+0xc6>
				cputchar(c);
  8012a3:	83 ec 0c             	sub    $0xc,%esp
  8012a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a9:	e8 5a f3 ff ff       	call   800608 <cputchar>
  8012ae:	83 c4 10             	add    $0x10,%esp
			i--;
  8012b1:	ff 4d f4             	decl   -0xc(%ebp)
  8012b4:	eb 36                	jmp    8012ec <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012b6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012ba:	74 0a                	je     8012c6 <atomic_readline+0xdb>
  8012bc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012c0:	0f 85 60 ff ff ff    	jne    801226 <atomic_readline+0x3b>
			if (echoing)
  8012c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ca:	74 0e                	je     8012da <atomic_readline+0xef>
				cputchar(c);
  8012cc:	83 ec 0c             	sub    $0xc,%esp
  8012cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8012d2:	e8 31 f3 ff ff       	call   800608 <cputchar>
  8012d7:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e0:	01 d0                	add    %edx,%eax
  8012e2:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012e5:	e8 06 0c 00 00       	call   801ef0 <sys_enable_interrupt>
			return;
  8012ea:	eb 05                	jmp    8012f1 <atomic_readline+0x106>
		}
	}
  8012ec:	e9 35 ff ff ff       	jmp    801226 <atomic_readline+0x3b>
}
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
  8012f6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801300:	eb 06                	jmp    801308 <strlen+0x15>
		n++;
  801302:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801305:	ff 45 08             	incl   0x8(%ebp)
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	84 c0                	test   %al,%al
  80130f:	75 f1                	jne    801302 <strlen+0xf>
		n++;
	return n;
  801311:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
  801319:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80131c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801323:	eb 09                	jmp    80132e <strnlen+0x18>
		n++;
  801325:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801328:	ff 45 08             	incl   0x8(%ebp)
  80132b:	ff 4d 0c             	decl   0xc(%ebp)
  80132e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801332:	74 09                	je     80133d <strnlen+0x27>
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	84 c0                	test   %al,%al
  80133b:	75 e8                	jne    801325 <strnlen+0xf>
		n++;
	return n;
  80133d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801340:	c9                   	leave  
  801341:	c3                   	ret    

00801342 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
  801345:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80134e:	90                   	nop
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8d 50 01             	lea    0x1(%eax),%edx
  801355:	89 55 08             	mov    %edx,0x8(%ebp)
  801358:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80135e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801361:	8a 12                	mov    (%edx),%dl
  801363:	88 10                	mov    %dl,(%eax)
  801365:	8a 00                	mov    (%eax),%al
  801367:	84 c0                	test   %al,%al
  801369:	75 e4                	jne    80134f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80136b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80136e:	c9                   	leave  
  80136f:	c3                   	ret    

00801370 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801370:	55                   	push   %ebp
  801371:	89 e5                	mov    %esp,%ebp
  801373:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80137c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801383:	eb 1f                	jmp    8013a4 <strncpy+0x34>
		*dst++ = *src;
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8d 50 01             	lea    0x1(%eax),%edx
  80138b:	89 55 08             	mov    %edx,0x8(%ebp)
  80138e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801391:	8a 12                	mov    (%edx),%dl
  801393:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801395:	8b 45 0c             	mov    0xc(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	84 c0                	test   %al,%al
  80139c:	74 03                	je     8013a1 <strncpy+0x31>
			src++;
  80139e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013a1:	ff 45 fc             	incl   -0x4(%ebp)
  8013a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013aa:	72 d9                	jb     801385 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
  8013b4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c1:	74 30                	je     8013f3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013c3:	eb 16                	jmp    8013db <strlcpy+0x2a>
			*dst++ = *src++;
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8d 50 01             	lea    0x1(%eax),%edx
  8013cb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013d4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013d7:	8a 12                	mov    (%edx),%dl
  8013d9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013db:	ff 4d 10             	decl   0x10(%ebp)
  8013de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e2:	74 09                	je     8013ed <strlcpy+0x3c>
  8013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	84 c0                	test   %al,%al
  8013eb:	75 d8                	jne    8013c5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013f3:	8b 55 08             	mov    0x8(%ebp),%edx
  8013f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f9:	29 c2                	sub    %eax,%edx
  8013fb:	89 d0                	mov    %edx,%eax
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801402:	eb 06                	jmp    80140a <strcmp+0xb>
		p++, q++;
  801404:	ff 45 08             	incl   0x8(%ebp)
  801407:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	84 c0                	test   %al,%al
  801411:	74 0e                	je     801421 <strcmp+0x22>
  801413:	8b 45 08             	mov    0x8(%ebp),%eax
  801416:	8a 10                	mov    (%eax),%dl
  801418:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	38 c2                	cmp    %al,%dl
  80141f:	74 e3                	je     801404 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	0f b6 d0             	movzbl %al,%edx
  801429:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	0f b6 c0             	movzbl %al,%eax
  801431:	29 c2                	sub    %eax,%edx
  801433:	89 d0                	mov    %edx,%eax
}
  801435:	5d                   	pop    %ebp
  801436:	c3                   	ret    

00801437 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80143a:	eb 09                	jmp    801445 <strncmp+0xe>
		n--, p++, q++;
  80143c:	ff 4d 10             	decl   0x10(%ebp)
  80143f:	ff 45 08             	incl   0x8(%ebp)
  801442:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801445:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801449:	74 17                	je     801462 <strncmp+0x2b>
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	84 c0                	test   %al,%al
  801452:	74 0e                	je     801462 <strncmp+0x2b>
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 10                	mov    (%eax),%dl
  801459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	38 c2                	cmp    %al,%dl
  801460:	74 da                	je     80143c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801462:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801466:	75 07                	jne    80146f <strncmp+0x38>
		return 0;
  801468:	b8 00 00 00 00       	mov    $0x0,%eax
  80146d:	eb 14                	jmp    801483 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	0f b6 d0             	movzbl %al,%edx
  801477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	0f b6 c0             	movzbl %al,%eax
  80147f:	29 c2                	sub    %eax,%edx
  801481:	89 d0                	mov    %edx,%eax
}
  801483:	5d                   	pop    %ebp
  801484:	c3                   	ret    

00801485 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
  801488:	83 ec 04             	sub    $0x4,%esp
  80148b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801491:	eb 12                	jmp    8014a5 <strchr+0x20>
		if (*s == c)
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	8a 00                	mov    (%eax),%al
  801498:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80149b:	75 05                	jne    8014a2 <strchr+0x1d>
			return (char *) s;
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	eb 11                	jmp    8014b3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014a2:	ff 45 08             	incl   0x8(%ebp)
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	8a 00                	mov    (%eax),%al
  8014aa:	84 c0                	test   %al,%al
  8014ac:	75 e5                	jne    801493 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 04             	sub    $0x4,%esp
  8014bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014be:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014c1:	eb 0d                	jmp    8014d0 <strfind+0x1b>
		if (*s == c)
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	8a 00                	mov    (%eax),%al
  8014c8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014cb:	74 0e                	je     8014db <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014cd:	ff 45 08             	incl   0x8(%ebp)
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	8a 00                	mov    (%eax),%al
  8014d5:	84 c0                	test   %al,%al
  8014d7:	75 ea                	jne    8014c3 <strfind+0xe>
  8014d9:	eb 01                	jmp    8014dc <strfind+0x27>
		if (*s == c)
			break;
  8014db:	90                   	nop
	return (char *) s;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
  8014e4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014f3:	eb 0e                	jmp    801503 <memset+0x22>
		*p++ = c;
  8014f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f8:	8d 50 01             	lea    0x1(%eax),%edx
  8014fb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801501:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801503:	ff 4d f8             	decl   -0x8(%ebp)
  801506:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80150a:	79 e9                	jns    8014f5 <memset+0x14>
		*p++ = c;

	return v;
  80150c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
  801514:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801517:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80151d:	8b 45 08             	mov    0x8(%ebp),%eax
  801520:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801523:	eb 16                	jmp    80153b <memcpy+0x2a>
		*d++ = *s++;
  801525:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801528:	8d 50 01             	lea    0x1(%eax),%edx
  80152b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80152e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801531:	8d 4a 01             	lea    0x1(%edx),%ecx
  801534:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801537:	8a 12                	mov    (%edx),%dl
  801539:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80153b:	8b 45 10             	mov    0x10(%ebp),%eax
  80153e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801541:	89 55 10             	mov    %edx,0x10(%ebp)
  801544:	85 c0                	test   %eax,%eax
  801546:	75 dd                	jne    801525 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
  801550:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801553:	8b 45 0c             	mov    0xc(%ebp),%eax
  801556:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80155f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801562:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801565:	73 50                	jae    8015b7 <memmove+0x6a>
  801567:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	01 d0                	add    %edx,%eax
  80156f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801572:	76 43                	jbe    8015b7 <memmove+0x6a>
		s += n;
  801574:	8b 45 10             	mov    0x10(%ebp),%eax
  801577:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80157a:	8b 45 10             	mov    0x10(%ebp),%eax
  80157d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801580:	eb 10                	jmp    801592 <memmove+0x45>
			*--d = *--s;
  801582:	ff 4d f8             	decl   -0x8(%ebp)
  801585:	ff 4d fc             	decl   -0x4(%ebp)
  801588:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158b:	8a 10                	mov    (%eax),%dl
  80158d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801590:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801592:	8b 45 10             	mov    0x10(%ebp),%eax
  801595:	8d 50 ff             	lea    -0x1(%eax),%edx
  801598:	89 55 10             	mov    %edx,0x10(%ebp)
  80159b:	85 c0                	test   %eax,%eax
  80159d:	75 e3                	jne    801582 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80159f:	eb 23                	jmp    8015c4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a4:	8d 50 01             	lea    0x1(%eax),%edx
  8015a7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ad:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015b0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015b3:	8a 12                	mov    (%edx),%dl
  8015b5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c0:	85 c0                	test   %eax,%eax
  8015c2:	75 dd                	jne    8015a1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
  8015cc:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015db:	eb 2a                	jmp    801607 <memcmp+0x3e>
		if (*s1 != *s2)
  8015dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e0:	8a 10                	mov    (%eax),%dl
  8015e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e5:	8a 00                	mov    (%eax),%al
  8015e7:	38 c2                	cmp    %al,%dl
  8015e9:	74 16                	je     801601 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ee:	8a 00                	mov    (%eax),%al
  8015f0:	0f b6 d0             	movzbl %al,%edx
  8015f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f6:	8a 00                	mov    (%eax),%al
  8015f8:	0f b6 c0             	movzbl %al,%eax
  8015fb:	29 c2                	sub    %eax,%edx
  8015fd:	89 d0                	mov    %edx,%eax
  8015ff:	eb 18                	jmp    801619 <memcmp+0x50>
		s1++, s2++;
  801601:	ff 45 fc             	incl   -0x4(%ebp)
  801604:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80160d:	89 55 10             	mov    %edx,0x10(%ebp)
  801610:	85 c0                	test   %eax,%eax
  801612:	75 c9                	jne    8015dd <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801614:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801619:	c9                   	leave  
  80161a:	c3                   	ret    

0080161b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80161b:	55                   	push   %ebp
  80161c:	89 e5                	mov    %esp,%ebp
  80161e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801621:	8b 55 08             	mov    0x8(%ebp),%edx
  801624:	8b 45 10             	mov    0x10(%ebp),%eax
  801627:	01 d0                	add    %edx,%eax
  801629:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80162c:	eb 15                	jmp    801643 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	8a 00                	mov    (%eax),%al
  801633:	0f b6 d0             	movzbl %al,%edx
  801636:	8b 45 0c             	mov    0xc(%ebp),%eax
  801639:	0f b6 c0             	movzbl %al,%eax
  80163c:	39 c2                	cmp    %eax,%edx
  80163e:	74 0d                	je     80164d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801640:	ff 45 08             	incl   0x8(%ebp)
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801649:	72 e3                	jb     80162e <memfind+0x13>
  80164b:	eb 01                	jmp    80164e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80164d:	90                   	nop
	return (void *) s;
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
  801656:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801659:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801660:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801667:	eb 03                	jmp    80166c <strtol+0x19>
		s++;
  801669:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	3c 20                	cmp    $0x20,%al
  801673:	74 f4                	je     801669 <strtol+0x16>
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	8a 00                	mov    (%eax),%al
  80167a:	3c 09                	cmp    $0x9,%al
  80167c:	74 eb                	je     801669 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	3c 2b                	cmp    $0x2b,%al
  801685:	75 05                	jne    80168c <strtol+0x39>
		s++;
  801687:	ff 45 08             	incl   0x8(%ebp)
  80168a:	eb 13                	jmp    80169f <strtol+0x4c>
	else if (*s == '-')
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	8a 00                	mov    (%eax),%al
  801691:	3c 2d                	cmp    $0x2d,%al
  801693:	75 0a                	jne    80169f <strtol+0x4c>
		s++, neg = 1;
  801695:	ff 45 08             	incl   0x8(%ebp)
  801698:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80169f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a3:	74 06                	je     8016ab <strtol+0x58>
  8016a5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016a9:	75 20                	jne    8016cb <strtol+0x78>
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	3c 30                	cmp    $0x30,%al
  8016b2:	75 17                	jne    8016cb <strtol+0x78>
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	40                   	inc    %eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	3c 78                	cmp    $0x78,%al
  8016bc:	75 0d                	jne    8016cb <strtol+0x78>
		s += 2, base = 16;
  8016be:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016c2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016c9:	eb 28                	jmp    8016f3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016cf:	75 15                	jne    8016e6 <strtol+0x93>
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	3c 30                	cmp    $0x30,%al
  8016d8:	75 0c                	jne    8016e6 <strtol+0x93>
		s++, base = 8;
  8016da:	ff 45 08             	incl   0x8(%ebp)
  8016dd:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016e4:	eb 0d                	jmp    8016f3 <strtol+0xa0>
	else if (base == 0)
  8016e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ea:	75 07                	jne    8016f3 <strtol+0xa0>
		base = 10;
  8016ec:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8a 00                	mov    (%eax),%al
  8016f8:	3c 2f                	cmp    $0x2f,%al
  8016fa:	7e 19                	jle    801715 <strtol+0xc2>
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	8a 00                	mov    (%eax),%al
  801701:	3c 39                	cmp    $0x39,%al
  801703:	7f 10                	jg     801715 <strtol+0xc2>
			dig = *s - '0';
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	8a 00                	mov    (%eax),%al
  80170a:	0f be c0             	movsbl %al,%eax
  80170d:	83 e8 30             	sub    $0x30,%eax
  801710:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801713:	eb 42                	jmp    801757 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	8a 00                	mov    (%eax),%al
  80171a:	3c 60                	cmp    $0x60,%al
  80171c:	7e 19                	jle    801737 <strtol+0xe4>
  80171e:	8b 45 08             	mov    0x8(%ebp),%eax
  801721:	8a 00                	mov    (%eax),%al
  801723:	3c 7a                	cmp    $0x7a,%al
  801725:	7f 10                	jg     801737 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801727:	8b 45 08             	mov    0x8(%ebp),%eax
  80172a:	8a 00                	mov    (%eax),%al
  80172c:	0f be c0             	movsbl %al,%eax
  80172f:	83 e8 57             	sub    $0x57,%eax
  801732:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801735:	eb 20                	jmp    801757 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	8a 00                	mov    (%eax),%al
  80173c:	3c 40                	cmp    $0x40,%al
  80173e:	7e 39                	jle    801779 <strtol+0x126>
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	8a 00                	mov    (%eax),%al
  801745:	3c 5a                	cmp    $0x5a,%al
  801747:	7f 30                	jg     801779 <strtol+0x126>
			dig = *s - 'A' + 10;
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	8a 00                	mov    (%eax),%al
  80174e:	0f be c0             	movsbl %al,%eax
  801751:	83 e8 37             	sub    $0x37,%eax
  801754:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801757:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80175a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80175d:	7d 19                	jge    801778 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80175f:	ff 45 08             	incl   0x8(%ebp)
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801765:	0f af 45 10          	imul   0x10(%ebp),%eax
  801769:	89 c2                	mov    %eax,%edx
  80176b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80176e:	01 d0                	add    %edx,%eax
  801770:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801773:	e9 7b ff ff ff       	jmp    8016f3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801778:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801779:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80177d:	74 08                	je     801787 <strtol+0x134>
		*endptr = (char *) s;
  80177f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801782:	8b 55 08             	mov    0x8(%ebp),%edx
  801785:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801787:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80178b:	74 07                	je     801794 <strtol+0x141>
  80178d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801790:	f7 d8                	neg    %eax
  801792:	eb 03                	jmp    801797 <strtol+0x144>
  801794:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <ltostr>:

void
ltostr(long value, char *str)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
  80179c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80179f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017b1:	79 13                	jns    8017c6 <ltostr+0x2d>
	{
		neg = 1;
  8017b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017c0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017c3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017ce:	99                   	cltd   
  8017cf:	f7 f9                	idiv   %ecx
  8017d1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d7:	8d 50 01             	lea    0x1(%eax),%edx
  8017da:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017dd:	89 c2                	mov    %eax,%edx
  8017df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e2:	01 d0                	add    %edx,%eax
  8017e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017e7:	83 c2 30             	add    $0x30,%edx
  8017ea:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017ef:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017f4:	f7 e9                	imul   %ecx
  8017f6:	c1 fa 02             	sar    $0x2,%edx
  8017f9:	89 c8                	mov    %ecx,%eax
  8017fb:	c1 f8 1f             	sar    $0x1f,%eax
  8017fe:	29 c2                	sub    %eax,%edx
  801800:	89 d0                	mov    %edx,%eax
  801802:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801805:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801808:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80180d:	f7 e9                	imul   %ecx
  80180f:	c1 fa 02             	sar    $0x2,%edx
  801812:	89 c8                	mov    %ecx,%eax
  801814:	c1 f8 1f             	sar    $0x1f,%eax
  801817:	29 c2                	sub    %eax,%edx
  801819:	89 d0                	mov    %edx,%eax
  80181b:	c1 e0 02             	shl    $0x2,%eax
  80181e:	01 d0                	add    %edx,%eax
  801820:	01 c0                	add    %eax,%eax
  801822:	29 c1                	sub    %eax,%ecx
  801824:	89 ca                	mov    %ecx,%edx
  801826:	85 d2                	test   %edx,%edx
  801828:	75 9c                	jne    8017c6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80182a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801831:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801834:	48                   	dec    %eax
  801835:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801838:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80183c:	74 3d                	je     80187b <ltostr+0xe2>
		start = 1 ;
  80183e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801845:	eb 34                	jmp    80187b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801847:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184d:	01 d0                	add    %edx,%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801854:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801857:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185a:	01 c2                	add    %eax,%edx
  80185c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80185f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801862:	01 c8                	add    %ecx,%eax
  801864:	8a 00                	mov    (%eax),%al
  801866:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801868:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80186b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186e:	01 c2                	add    %eax,%edx
  801870:	8a 45 eb             	mov    -0x15(%ebp),%al
  801873:	88 02                	mov    %al,(%edx)
		start++ ;
  801875:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801878:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80187b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801881:	7c c4                	jl     801847 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801883:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801886:	8b 45 0c             	mov    0xc(%ebp),%eax
  801889:	01 d0                	add    %edx,%eax
  80188b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80188e:	90                   	nop
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
  801894:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801897:	ff 75 08             	pushl  0x8(%ebp)
  80189a:	e8 54 fa ff ff       	call   8012f3 <strlen>
  80189f:	83 c4 04             	add    $0x4,%esp
  8018a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018a5:	ff 75 0c             	pushl  0xc(%ebp)
  8018a8:	e8 46 fa ff ff       	call   8012f3 <strlen>
  8018ad:	83 c4 04             	add    $0x4,%esp
  8018b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018c1:	eb 17                	jmp    8018da <strcconcat+0x49>
		final[s] = str1[s] ;
  8018c3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c9:	01 c2                	add    %eax,%edx
  8018cb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d1:	01 c8                	add    %ecx,%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018d7:	ff 45 fc             	incl   -0x4(%ebp)
  8018da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018e0:	7c e1                	jl     8018c3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018f0:	eb 1f                	jmp    801911 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f5:	8d 50 01             	lea    0x1(%eax),%edx
  8018f8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018fb:	89 c2                	mov    %eax,%edx
  8018fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801900:	01 c2                	add    %eax,%edx
  801902:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801905:	8b 45 0c             	mov    0xc(%ebp),%eax
  801908:	01 c8                	add    %ecx,%eax
  80190a:	8a 00                	mov    (%eax),%al
  80190c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80190e:	ff 45 f8             	incl   -0x8(%ebp)
  801911:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801914:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801917:	7c d9                	jl     8018f2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801919:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80191c:	8b 45 10             	mov    0x10(%ebp),%eax
  80191f:	01 d0                	add    %edx,%eax
  801921:	c6 00 00             	movb   $0x0,(%eax)
}
  801924:	90                   	nop
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80192a:	8b 45 14             	mov    0x14(%ebp),%eax
  80192d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801933:	8b 45 14             	mov    0x14(%ebp),%eax
  801936:	8b 00                	mov    (%eax),%eax
  801938:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193f:	8b 45 10             	mov    0x10(%ebp),%eax
  801942:	01 d0                	add    %edx,%eax
  801944:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80194a:	eb 0c                	jmp    801958 <strsplit+0x31>
			*string++ = 0;
  80194c:	8b 45 08             	mov    0x8(%ebp),%eax
  80194f:	8d 50 01             	lea    0x1(%eax),%edx
  801952:	89 55 08             	mov    %edx,0x8(%ebp)
  801955:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801958:	8b 45 08             	mov    0x8(%ebp),%eax
  80195b:	8a 00                	mov    (%eax),%al
  80195d:	84 c0                	test   %al,%al
  80195f:	74 18                	je     801979 <strsplit+0x52>
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	8a 00                	mov    (%eax),%al
  801966:	0f be c0             	movsbl %al,%eax
  801969:	50                   	push   %eax
  80196a:	ff 75 0c             	pushl  0xc(%ebp)
  80196d:	e8 13 fb ff ff       	call   801485 <strchr>
  801972:	83 c4 08             	add    $0x8,%esp
  801975:	85 c0                	test   %eax,%eax
  801977:	75 d3                	jne    80194c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801979:	8b 45 08             	mov    0x8(%ebp),%eax
  80197c:	8a 00                	mov    (%eax),%al
  80197e:	84 c0                	test   %al,%al
  801980:	74 5a                	je     8019dc <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801982:	8b 45 14             	mov    0x14(%ebp),%eax
  801985:	8b 00                	mov    (%eax),%eax
  801987:	83 f8 0f             	cmp    $0xf,%eax
  80198a:	75 07                	jne    801993 <strsplit+0x6c>
		{
			return 0;
  80198c:	b8 00 00 00 00       	mov    $0x0,%eax
  801991:	eb 66                	jmp    8019f9 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801993:	8b 45 14             	mov    0x14(%ebp),%eax
  801996:	8b 00                	mov    (%eax),%eax
  801998:	8d 48 01             	lea    0x1(%eax),%ecx
  80199b:	8b 55 14             	mov    0x14(%ebp),%edx
  80199e:	89 0a                	mov    %ecx,(%edx)
  8019a0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019aa:	01 c2                	add    %eax,%edx
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019b1:	eb 03                	jmp    8019b6 <strsplit+0x8f>
			string++;
  8019b3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b9:	8a 00                	mov    (%eax),%al
  8019bb:	84 c0                	test   %al,%al
  8019bd:	74 8b                	je     80194a <strsplit+0x23>
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	8a 00                	mov    (%eax),%al
  8019c4:	0f be c0             	movsbl %al,%eax
  8019c7:	50                   	push   %eax
  8019c8:	ff 75 0c             	pushl  0xc(%ebp)
  8019cb:	e8 b5 fa ff ff       	call   801485 <strchr>
  8019d0:	83 c4 08             	add    $0x8,%esp
  8019d3:	85 c0                	test   %eax,%eax
  8019d5:	74 dc                	je     8019b3 <strsplit+0x8c>
			string++;
	}
  8019d7:	e9 6e ff ff ff       	jmp    80194a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019dc:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e0:	8b 00                	mov    (%eax),%eax
  8019e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ec:	01 d0                	add    %edx,%eax
  8019ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019f4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019f9:	c9                   	leave  
  8019fa:	c3                   	ret    

008019fb <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

void* malloc(uint32 size) {
  8019fb:	55                   	push   %ebp
  8019fc:	89 e5                	mov    %esp,%ebp
  8019fe:	83 ec 28             	sub    $0x28,%esp
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,


	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801a01:	e8 31 08 00 00       	call   802237 <sys_isUHeapPlacementStrategyNEXTFIT>
  801a06:	85 c0                	test   %eax,%eax
  801a08:	0f 84 64 01 00 00    	je     801b72 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801a0e:	8b 0d 2c 30 80 00    	mov    0x80302c,%ecx
  801a14:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801a1b:	8b 55 08             	mov    0x8(%ebp),%edx
  801a1e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a21:	01 d0                	add    %edx,%eax
  801a23:	48                   	dec    %eax
  801a24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801a27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a2a:	ba 00 00 00 00       	mov    $0x0,%edx
  801a2f:	f7 75 e8             	divl   -0x18(%ebp)
  801a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a35:	29 d0                	sub    %edx,%eax
  801a37:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801a3e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	01 d0                	add    %edx,%eax
  801a49:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  801a4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  801a53:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a58:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a5f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801a62:	0f 83 0a 01 00 00    	jae    801b72 <malloc+0x177>
  801a68:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a6d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a74:	85 c0                	test   %eax,%eax
  801a76:	0f 84 f6 00 00 00    	je     801b72 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801a7c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a83:	e9 dc 00 00 00       	jmp    801b64 <malloc+0x169>
				flag++;
  801a88:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  801a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a8e:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801a95:	85 c0                	test   %eax,%eax
  801a97:	74 07                	je     801aa0 <malloc+0xa5>
					flag=0;
  801a99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  801aa0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801aa5:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801aac:	85 c0                	test   %eax,%eax
  801aae:	79 05                	jns    801ab5 <malloc+0xba>
  801ab0:	05 ff 0f 00 00       	add    $0xfff,%eax
  801ab5:	c1 f8 0c             	sar    $0xc,%eax
  801ab8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801abb:	0f 85 a0 00 00 00    	jne    801b61 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801ac1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ac6:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801acd:	85 c0                	test   %eax,%eax
  801acf:	79 05                	jns    801ad6 <malloc+0xdb>
  801ad1:	05 ff 0f 00 00       	add    $0xfff,%eax
  801ad6:	c1 f8 0c             	sar    $0xc,%eax
  801ad9:	89 c2                	mov    %eax,%edx
  801adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ade:	29 d0                	sub    %edx,%eax
  801ae0:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801ae3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ae6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801ae9:	eb 11                	jmp    801afc <malloc+0x101>
						hFreeArr[j] = 1;
  801aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801aee:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801af5:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801af9:	ff 45 ec             	incl   -0x14(%ebp)
  801afc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801aff:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b02:	7e e7                	jle    801aeb <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801b04:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b09:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801b0c:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801b12:	c1 e2 0c             	shl    $0xc,%edx
  801b15:	89 15 04 30 80 00    	mov    %edx,0x803004
  801b1b:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b21:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801b28:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b2d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801b34:	89 c2                	mov    %eax,%edx
  801b36:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b3b:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801b42:	83 ec 08             	sub    $0x8,%esp
  801b45:	52                   	push   %edx
  801b46:	50                   	push   %eax
  801b47:	e8 21 03 00 00       	call   801e6d <sys_allocateMem>
  801b4c:	83 c4 10             	add    $0x10,%esp

					idx++;
  801b4f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b54:	40                   	inc    %eax
  801b55:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*)startAdd;
  801b5a:	a1 04 30 80 00       	mov    0x803004,%eax
  801b5f:	eb 16                	jmp    801b77 <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801b61:	ff 45 f0             	incl   -0x10(%ebp)
  801b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b67:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b6c:	0f 86 16 ff ff ff    	jbe    801a88 <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801b72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
  801b7c:	83 ec 18             	sub    $0x18,%esp
  801b7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b82:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801b85:	83 ec 04             	sub    $0x4,%esp
  801b88:	68 04 2c 80 00       	push   $0x802c04
  801b8d:	6a 5a                	push   $0x5a
  801b8f:	68 23 2c 80 00       	push   $0x802c23
  801b94:	e8 1e ec ff ff       	call   8007b7 <_panic>

00801b99 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
  801b9c:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801b9f:	83 ec 04             	sub    $0x4,%esp
  801ba2:	68 2f 2c 80 00       	push   $0x802c2f
  801ba7:	6a 60                	push   $0x60
  801ba9:	68 23 2c 80 00       	push   $0x802c23
  801bae:	e8 04 ec ff ff       	call   8007b7 <_panic>

00801bb3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
  801bb6:	83 ec 18             	sub    $0x18,%esp

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801bb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801bc0:	e9 8a 00 00 00       	jmp    801c4f <free+0x9c>
		if (virtual_address == (void*)uHeapArr[i].first) {
  801bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bc8:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801bcf:	3b 45 08             	cmp    0x8(%ebp),%eax
  801bd2:	75 78                	jne    801c4c <free+0x99>
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
  801bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bd7:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801bde:	05 00 00 00 80       	add    $0x80000000,%eax
  801be3:	c1 e8 0c             	shr    $0xc,%eax
  801be6:	89 45 ec             	mov    %eax,-0x14(%ebp)
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;
  801be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bec:	8b 14 c5 44 30 88 00 	mov    0x883044(,%eax,8),%edx
  801bf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bf6:	01 d0                	add    %edx,%eax
  801bf8:	85 c0                	test   %eax,%eax
  801bfa:	79 05                	jns    801c01 <free+0x4e>
  801bfc:	05 ff 0f 00 00       	add    $0xfff,%eax
  801c01:	c1 f8 0c             	sar    $0xc,%eax
  801c04:	89 45 e8             	mov    %eax,-0x18(%ebp)

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801c07:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c0d:	eb 19                	jmp    801c28 <free+0x75>
				sys_freeMem((uint32)j, fIDX);
  801c0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c12:	83 ec 08             	sub    $0x8,%esp
  801c15:	50                   	push   %eax
  801c16:	ff 75 f0             	pushl  -0x10(%ebp)
  801c19:	e8 33 02 00 00       	call   801e51 <sys_freeMem>
  801c1e:	83 c4 10             	add    $0x10,%esp
	for(int i=0; i<idx; i++) {
		if (virtual_address == (void*)uHeapArr[i].first) {
			int fIDX = (uHeapArr[i].first-USER_HEAP_START)/PAGE_SIZE;
			uint32 finalAdd = (fIDX + uHeapArr[i].size)/PAGE_SIZE;

			for(uint32 j=(uint32)fIDX; j<finalAdd; j+=PAGE_SIZE)
  801c21:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
  801c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c2e:	72 df                	jb     801c0f <free+0x5c>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
  801c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c33:	c7 04 c5 44 30 88 00 	movl   $0x0,0x883044(,%eax,8)
  801c3a:	00 00 00 00 
  801c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c41:	c7 04 c5 40 30 88 00 	movl   $0x0,0x883040(,%eax,8)
  801c48:	00 00 00 00 

	//you shold get the size of the given allocation using its address
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	for(int i=0; i<idx; i++) {
  801c4c:	ff 45 f4             	incl   -0xc(%ebp)
  801c4f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c54:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  801c57:	0f 8c 68 ff ff ff    	jl     801bc5 <free+0x12>
				sys_freeMem((uint32)j, fIDX);

			uHeapArr[i].first = uHeapArr[i].size = 0;
		}
	}
}
  801c5d:	90                   	nop
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <sfree>:


void sfree(void* virtual_address)
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
  801c63:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801c66:	83 ec 04             	sub    $0x4,%esp
  801c69:	68 4b 2c 80 00       	push   $0x802c4b
  801c6e:	68 87 00 00 00       	push   $0x87
  801c73:	68 23 2c 80 00       	push   $0x802c23
  801c78:	e8 3a eb ff ff       	call   8007b7 <_panic>

00801c7d <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
  801c80:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c83:	83 ec 04             	sub    $0x4,%esp
  801c86:	68 68 2c 80 00       	push   $0x802c68
  801c8b:	68 9f 00 00 00       	push   $0x9f
  801c90:	68 23 2c 80 00       	push   $0x802c23
  801c95:	e8 1d eb ff ff       	call   8007b7 <_panic>

00801c9a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
  801c9d:	57                   	push   %edi
  801c9e:	56                   	push   %esi
  801c9f:	53                   	push   %ebx
  801ca0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cac:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801caf:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cb2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cb5:	cd 30                	int    $0x30
  801cb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cbd:	83 c4 10             	add    $0x10,%esp
  801cc0:	5b                   	pop    %ebx
  801cc1:	5e                   	pop    %esi
  801cc2:	5f                   	pop    %edi
  801cc3:	5d                   	pop    %ebp
  801cc4:	c3                   	ret    

00801cc5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
  801cc8:	83 ec 04             	sub    $0x4,%esp
  801ccb:	8b 45 10             	mov    0x10(%ebp),%eax
  801cce:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801cd1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	52                   	push   %edx
  801cdd:	ff 75 0c             	pushl  0xc(%ebp)
  801ce0:	50                   	push   %eax
  801ce1:	6a 00                	push   $0x0
  801ce3:	e8 b2 ff ff ff       	call   801c9a <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	90                   	nop
  801cec:	c9                   	leave  
  801ced:	c3                   	ret    

00801cee <sys_cgetc>:

int
sys_cgetc(void)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 01                	push   $0x1
  801cfd:	e8 98 ff ff ff       	call   801c9a <syscall>
  801d02:	83 c4 18             	add    $0x18,%esp
}
  801d05:	c9                   	leave  
  801d06:	c3                   	ret    

00801d07 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d07:	55                   	push   %ebp
  801d08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	50                   	push   %eax
  801d16:	6a 05                	push   $0x5
  801d18:	e8 7d ff ff ff       	call   801c9a <syscall>
  801d1d:	83 c4 18             	add    $0x18,%esp
}
  801d20:	c9                   	leave  
  801d21:	c3                   	ret    

00801d22 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d22:	55                   	push   %ebp
  801d23:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 02                	push   $0x2
  801d31:	e8 64 ff ff ff       	call   801c9a <syscall>
  801d36:	83 c4 18             	add    $0x18,%esp
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 03                	push   $0x3
  801d4a:	e8 4b ff ff ff       	call   801c9a <syscall>
  801d4f:	83 c4 18             	add    $0x18,%esp
}
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 04                	push   $0x4
  801d63:	e8 32 ff ff ff       	call   801c9a <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
}
  801d6b:	c9                   	leave  
  801d6c:	c3                   	ret    

00801d6d <sys_env_exit>:


void sys_env_exit(void)
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d70:	6a 00                	push   $0x0
  801d72:	6a 00                	push   $0x0
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 06                	push   $0x6
  801d7c:	e8 19 ff ff ff       	call   801c9a <syscall>
  801d81:	83 c4 18             	add    $0x18,%esp
}
  801d84:	90                   	nop
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	52                   	push   %edx
  801d97:	50                   	push   %eax
  801d98:	6a 07                	push   $0x7
  801d9a:	e8 fb fe ff ff       	call   801c9a <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
  801da7:	56                   	push   %esi
  801da8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801da9:	8b 75 18             	mov    0x18(%ebp),%esi
  801dac:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801daf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801db2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db5:	8b 45 08             	mov    0x8(%ebp),%eax
  801db8:	56                   	push   %esi
  801db9:	53                   	push   %ebx
  801dba:	51                   	push   %ecx
  801dbb:	52                   	push   %edx
  801dbc:	50                   	push   %eax
  801dbd:	6a 08                	push   $0x8
  801dbf:	e8 d6 fe ff ff       	call   801c9a <syscall>
  801dc4:	83 c4 18             	add    $0x18,%esp
}
  801dc7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dca:	5b                   	pop    %ebx
  801dcb:	5e                   	pop    %esi
  801dcc:	5d                   	pop    %ebp
  801dcd:	c3                   	ret    

00801dce <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801dd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	52                   	push   %edx
  801dde:	50                   	push   %eax
  801ddf:	6a 09                	push   $0x9
  801de1:	e8 b4 fe ff ff       	call   801c9a <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	ff 75 0c             	pushl  0xc(%ebp)
  801df7:	ff 75 08             	pushl  0x8(%ebp)
  801dfa:	6a 0a                	push   $0xa
  801dfc:	e8 99 fe ff ff       	call   801c9a <syscall>
  801e01:	83 c4 18             	add    $0x18,%esp
}
  801e04:	c9                   	leave  
  801e05:	c3                   	ret    

00801e06 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e06:	55                   	push   %ebp
  801e07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 0b                	push   $0xb
  801e15:	e8 80 fe ff ff       	call   801c9a <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
}
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    

00801e1f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 0c                	push   $0xc
  801e2e:	e8 67 fe ff ff       	call   801c9a <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
}
  801e36:	c9                   	leave  
  801e37:	c3                   	ret    

00801e38 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e38:	55                   	push   %ebp
  801e39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 0d                	push   $0xd
  801e47:	e8 4e fe ff ff       	call   801c9a <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
}
  801e4f:	c9                   	leave  
  801e50:	c3                   	ret    

00801e51 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e51:	55                   	push   %ebp
  801e52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	ff 75 0c             	pushl  0xc(%ebp)
  801e5d:	ff 75 08             	pushl  0x8(%ebp)
  801e60:	6a 11                	push   $0x11
  801e62:	e8 33 fe ff ff       	call   801c9a <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
	return;
  801e6a:	90                   	nop
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	ff 75 0c             	pushl  0xc(%ebp)
  801e79:	ff 75 08             	pushl  0x8(%ebp)
  801e7c:	6a 12                	push   $0x12
  801e7e:	e8 17 fe ff ff       	call   801c9a <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
	return ;
  801e86:	90                   	nop
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 0e                	push   $0xe
  801e98:	e8 fd fd ff ff       	call   801c9a <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	ff 75 08             	pushl  0x8(%ebp)
  801eb0:	6a 0f                	push   $0xf
  801eb2:	e8 e3 fd ff ff       	call   801c9a <syscall>
  801eb7:	83 c4 18             	add    $0x18,%esp
}
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 10                	push   $0x10
  801ecb:	e8 ca fd ff ff       	call   801c9a <syscall>
  801ed0:	83 c4 18             	add    $0x18,%esp
}
  801ed3:	90                   	nop
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 14                	push   $0x14
  801ee5:	e8 b0 fd ff ff       	call   801c9a <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	90                   	nop
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 15                	push   $0x15
  801eff:	e8 96 fd ff ff       	call   801c9a <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	90                   	nop
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_cputc>:


void
sys_cputc(const char c)
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
  801f0d:	83 ec 04             	sub    $0x4,%esp
  801f10:	8b 45 08             	mov    0x8(%ebp),%eax
  801f13:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f16:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	50                   	push   %eax
  801f23:	6a 16                	push   $0x16
  801f25:	e8 70 fd ff ff       	call   801c9a <syscall>
  801f2a:	83 c4 18             	add    $0x18,%esp
}
  801f2d:	90                   	nop
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 17                	push   $0x17
  801f3f:	e8 56 fd ff ff       	call   801c9a <syscall>
  801f44:	83 c4 18             	add    $0x18,%esp
}
  801f47:	90                   	nop
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	ff 75 0c             	pushl  0xc(%ebp)
  801f59:	50                   	push   %eax
  801f5a:	6a 18                	push   $0x18
  801f5c:	e8 39 fd ff ff       	call   801c9a <syscall>
  801f61:	83 c4 18             	add    $0x18,%esp
}
  801f64:	c9                   	leave  
  801f65:	c3                   	ret    

00801f66 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f66:	55                   	push   %ebp
  801f67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f69:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	52                   	push   %edx
  801f76:	50                   	push   %eax
  801f77:	6a 1b                	push   $0x1b
  801f79:	e8 1c fd ff ff       	call   801c9a <syscall>
  801f7e:	83 c4 18             	add    $0x18,%esp
}
  801f81:	c9                   	leave  
  801f82:	c3                   	ret    

00801f83 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f83:	55                   	push   %ebp
  801f84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f86:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f89:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	52                   	push   %edx
  801f93:	50                   	push   %eax
  801f94:	6a 19                	push   $0x19
  801f96:	e8 ff fc ff ff       	call   801c9a <syscall>
  801f9b:	83 c4 18             	add    $0x18,%esp
}
  801f9e:	90                   	nop
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	52                   	push   %edx
  801fb1:	50                   	push   %eax
  801fb2:	6a 1a                	push   $0x1a
  801fb4:	e8 e1 fc ff ff       	call   801c9a <syscall>
  801fb9:	83 c4 18             	add    $0x18,%esp
}
  801fbc:	90                   	nop
  801fbd:	c9                   	leave  
  801fbe:	c3                   	ret    

00801fbf <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
  801fc2:	83 ec 04             	sub    $0x4,%esp
  801fc5:	8b 45 10             	mov    0x10(%ebp),%eax
  801fc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fcb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fce:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd5:	6a 00                	push   $0x0
  801fd7:	51                   	push   %ecx
  801fd8:	52                   	push   %edx
  801fd9:	ff 75 0c             	pushl  0xc(%ebp)
  801fdc:	50                   	push   %eax
  801fdd:	6a 1c                	push   $0x1c
  801fdf:	e8 b6 fc ff ff       	call   801c9a <syscall>
  801fe4:	83 c4 18             	add    $0x18,%esp
}
  801fe7:	c9                   	leave  
  801fe8:	c3                   	ret    

00801fe9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fe9:	55                   	push   %ebp
  801fea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fec:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fef:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	52                   	push   %edx
  801ff9:	50                   	push   %eax
  801ffa:	6a 1d                	push   $0x1d
  801ffc:	e8 99 fc ff ff       	call   801c9a <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
}
  802004:	c9                   	leave  
  802005:	c3                   	ret    

00802006 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802006:	55                   	push   %ebp
  802007:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802009:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80200c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200f:	8b 45 08             	mov    0x8(%ebp),%eax
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	51                   	push   %ecx
  802017:	52                   	push   %edx
  802018:	50                   	push   %eax
  802019:	6a 1e                	push   $0x1e
  80201b:	e8 7a fc ff ff       	call   801c9a <syscall>
  802020:	83 c4 18             	add    $0x18,%esp
}
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802028:	8b 55 0c             	mov    0xc(%ebp),%edx
  80202b:	8b 45 08             	mov    0x8(%ebp),%eax
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	52                   	push   %edx
  802035:	50                   	push   %eax
  802036:	6a 1f                	push   $0x1f
  802038:	e8 5d fc ff ff       	call   801c9a <syscall>
  80203d:	83 c4 18             	add    $0x18,%esp
}
  802040:	c9                   	leave  
  802041:	c3                   	ret    

00802042 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802042:	55                   	push   %ebp
  802043:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 20                	push   $0x20
  802051:	e8 44 fc ff ff       	call   801c9a <syscall>
  802056:	83 c4 18             	add    $0x18,%esp
}
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80205e:	8b 45 08             	mov    0x8(%ebp),%eax
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	ff 75 10             	pushl  0x10(%ebp)
  802068:	ff 75 0c             	pushl  0xc(%ebp)
  80206b:	50                   	push   %eax
  80206c:	6a 21                	push   $0x21
  80206e:	e8 27 fc ff ff       	call   801c9a <syscall>
  802073:	83 c4 18             	add    $0x18,%esp
}
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80207b:	8b 45 08             	mov    0x8(%ebp),%eax
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	50                   	push   %eax
  802087:	6a 22                	push   $0x22
  802089:	e8 0c fc ff ff       	call   801c9a <syscall>
  80208e:	83 c4 18             	add    $0x18,%esp
}
  802091:	90                   	nop
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802097:	8b 45 08             	mov    0x8(%ebp),%eax
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	50                   	push   %eax
  8020a3:	6a 23                	push   $0x23
  8020a5:	e8 f0 fb ff ff       	call   801c9a <syscall>
  8020aa:	83 c4 18             	add    $0x18,%esp
}
  8020ad:	90                   	nop
  8020ae:	c9                   	leave  
  8020af:	c3                   	ret    

008020b0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
  8020b3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020b6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020b9:	8d 50 04             	lea    0x4(%eax),%edx
  8020bc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	52                   	push   %edx
  8020c6:	50                   	push   %eax
  8020c7:	6a 24                	push   $0x24
  8020c9:	e8 cc fb ff ff       	call   801c9a <syscall>
  8020ce:	83 c4 18             	add    $0x18,%esp
	return result;
  8020d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020da:	89 01                	mov    %eax,(%ecx)
  8020dc:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020df:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e2:	c9                   	leave  
  8020e3:	c2 04 00             	ret    $0x4

008020e6 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020e6:	55                   	push   %ebp
  8020e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	ff 75 10             	pushl  0x10(%ebp)
  8020f0:	ff 75 0c             	pushl  0xc(%ebp)
  8020f3:	ff 75 08             	pushl  0x8(%ebp)
  8020f6:	6a 13                	push   $0x13
  8020f8:	e8 9d fb ff ff       	call   801c9a <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802100:	90                   	nop
}
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <sys_rcr2>:
uint32 sys_rcr2()
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 25                	push   $0x25
  802112:	e8 83 fb ff ff       	call   801c9a <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
}
  80211a:	c9                   	leave  
  80211b:	c3                   	ret    

0080211c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80211c:	55                   	push   %ebp
  80211d:	89 e5                	mov    %esp,%ebp
  80211f:	83 ec 04             	sub    $0x4,%esp
  802122:	8b 45 08             	mov    0x8(%ebp),%eax
  802125:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802128:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	50                   	push   %eax
  802135:	6a 26                	push   $0x26
  802137:	e8 5e fb ff ff       	call   801c9a <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
	return ;
  80213f:	90                   	nop
}
  802140:	c9                   	leave  
  802141:	c3                   	ret    

00802142 <rsttst>:
void rsttst()
{
  802142:	55                   	push   %ebp
  802143:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 28                	push   $0x28
  802151:	e8 44 fb ff ff       	call   801c9a <syscall>
  802156:	83 c4 18             	add    $0x18,%esp
	return ;
  802159:	90                   	nop
}
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
  80215f:	83 ec 04             	sub    $0x4,%esp
  802162:	8b 45 14             	mov    0x14(%ebp),%eax
  802165:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802168:	8b 55 18             	mov    0x18(%ebp),%edx
  80216b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80216f:	52                   	push   %edx
  802170:	50                   	push   %eax
  802171:	ff 75 10             	pushl  0x10(%ebp)
  802174:	ff 75 0c             	pushl  0xc(%ebp)
  802177:	ff 75 08             	pushl  0x8(%ebp)
  80217a:	6a 27                	push   $0x27
  80217c:	e8 19 fb ff ff       	call   801c9a <syscall>
  802181:	83 c4 18             	add    $0x18,%esp
	return ;
  802184:	90                   	nop
}
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <chktst>:
void chktst(uint32 n)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	ff 75 08             	pushl  0x8(%ebp)
  802195:	6a 29                	push   $0x29
  802197:	e8 fe fa ff ff       	call   801c9a <syscall>
  80219c:	83 c4 18             	add    $0x18,%esp
	return ;
  80219f:	90                   	nop
}
  8021a0:	c9                   	leave  
  8021a1:	c3                   	ret    

008021a2 <inctst>:

void inctst()
{
  8021a2:	55                   	push   %ebp
  8021a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 2a                	push   $0x2a
  8021b1:	e8 e4 fa ff ff       	call   801c9a <syscall>
  8021b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b9:	90                   	nop
}
  8021ba:	c9                   	leave  
  8021bb:	c3                   	ret    

008021bc <gettst>:
uint32 gettst()
{
  8021bc:	55                   	push   %ebp
  8021bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 2b                	push   $0x2b
  8021cb:	e8 ca fa ff ff       	call   801c9a <syscall>
  8021d0:	83 c4 18             	add    $0x18,%esp
}
  8021d3:	c9                   	leave  
  8021d4:	c3                   	ret    

008021d5 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021d5:	55                   	push   %ebp
  8021d6:	89 e5                	mov    %esp,%ebp
  8021d8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 2c                	push   $0x2c
  8021e7:	e8 ae fa ff ff       	call   801c9a <syscall>
  8021ec:	83 c4 18             	add    $0x18,%esp
  8021ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021f2:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021f6:	75 07                	jne    8021ff <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021f8:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fd:	eb 05                	jmp    802204 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802204:	c9                   	leave  
  802205:	c3                   	ret    

00802206 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802206:	55                   	push   %ebp
  802207:	89 e5                	mov    %esp,%ebp
  802209:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 2c                	push   $0x2c
  802218:	e8 7d fa ff ff       	call   801c9a <syscall>
  80221d:	83 c4 18             	add    $0x18,%esp
  802220:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802223:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802227:	75 07                	jne    802230 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802229:	b8 01 00 00 00       	mov    $0x1,%eax
  80222e:	eb 05                	jmp    802235 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802230:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802235:	c9                   	leave  
  802236:	c3                   	ret    

00802237 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802237:	55                   	push   %ebp
  802238:	89 e5                	mov    %esp,%ebp
  80223a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 00                	push   $0x0
  802243:	6a 00                	push   $0x0
  802245:	6a 00                	push   $0x0
  802247:	6a 2c                	push   $0x2c
  802249:	e8 4c fa ff ff       	call   801c9a <syscall>
  80224e:	83 c4 18             	add    $0x18,%esp
  802251:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802254:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802258:	75 07                	jne    802261 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80225a:	b8 01 00 00 00       	mov    $0x1,%eax
  80225f:	eb 05                	jmp    802266 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802261:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802266:	c9                   	leave  
  802267:	c3                   	ret    

00802268 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802268:	55                   	push   %ebp
  802269:	89 e5                	mov    %esp,%ebp
  80226b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80226e:	6a 00                	push   $0x0
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 2c                	push   $0x2c
  80227a:	e8 1b fa ff ff       	call   801c9a <syscall>
  80227f:	83 c4 18             	add    $0x18,%esp
  802282:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802285:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802289:	75 07                	jne    802292 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80228b:	b8 01 00 00 00       	mov    $0x1,%eax
  802290:	eb 05                	jmp    802297 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802292:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802297:	c9                   	leave  
  802298:	c3                   	ret    

00802299 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802299:	55                   	push   %ebp
  80229a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	6a 00                	push   $0x0
  8022a4:	ff 75 08             	pushl  0x8(%ebp)
  8022a7:	6a 2d                	push   $0x2d
  8022a9:	e8 ec f9 ff ff       	call   801c9a <syscall>
  8022ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b1:	90                   	nop
}
  8022b2:	c9                   	leave  
  8022b3:	c3                   	ret    

008022b4 <__udivdi3>:
  8022b4:	55                   	push   %ebp
  8022b5:	57                   	push   %edi
  8022b6:	56                   	push   %esi
  8022b7:	53                   	push   %ebx
  8022b8:	83 ec 1c             	sub    $0x1c,%esp
  8022bb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022bf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022cb:	89 ca                	mov    %ecx,%edx
  8022cd:	89 f8                	mov    %edi,%eax
  8022cf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022d3:	85 f6                	test   %esi,%esi
  8022d5:	75 2d                	jne    802304 <__udivdi3+0x50>
  8022d7:	39 cf                	cmp    %ecx,%edi
  8022d9:	77 65                	ja     802340 <__udivdi3+0x8c>
  8022db:	89 fd                	mov    %edi,%ebp
  8022dd:	85 ff                	test   %edi,%edi
  8022df:	75 0b                	jne    8022ec <__udivdi3+0x38>
  8022e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e6:	31 d2                	xor    %edx,%edx
  8022e8:	f7 f7                	div    %edi
  8022ea:	89 c5                	mov    %eax,%ebp
  8022ec:	31 d2                	xor    %edx,%edx
  8022ee:	89 c8                	mov    %ecx,%eax
  8022f0:	f7 f5                	div    %ebp
  8022f2:	89 c1                	mov    %eax,%ecx
  8022f4:	89 d8                	mov    %ebx,%eax
  8022f6:	f7 f5                	div    %ebp
  8022f8:	89 cf                	mov    %ecx,%edi
  8022fa:	89 fa                	mov    %edi,%edx
  8022fc:	83 c4 1c             	add    $0x1c,%esp
  8022ff:	5b                   	pop    %ebx
  802300:	5e                   	pop    %esi
  802301:	5f                   	pop    %edi
  802302:	5d                   	pop    %ebp
  802303:	c3                   	ret    
  802304:	39 ce                	cmp    %ecx,%esi
  802306:	77 28                	ja     802330 <__udivdi3+0x7c>
  802308:	0f bd fe             	bsr    %esi,%edi
  80230b:	83 f7 1f             	xor    $0x1f,%edi
  80230e:	75 40                	jne    802350 <__udivdi3+0x9c>
  802310:	39 ce                	cmp    %ecx,%esi
  802312:	72 0a                	jb     80231e <__udivdi3+0x6a>
  802314:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802318:	0f 87 9e 00 00 00    	ja     8023bc <__udivdi3+0x108>
  80231e:	b8 01 00 00 00       	mov    $0x1,%eax
  802323:	89 fa                	mov    %edi,%edx
  802325:	83 c4 1c             	add    $0x1c,%esp
  802328:	5b                   	pop    %ebx
  802329:	5e                   	pop    %esi
  80232a:	5f                   	pop    %edi
  80232b:	5d                   	pop    %ebp
  80232c:	c3                   	ret    
  80232d:	8d 76 00             	lea    0x0(%esi),%esi
  802330:	31 ff                	xor    %edi,%edi
  802332:	31 c0                	xor    %eax,%eax
  802334:	89 fa                	mov    %edi,%edx
  802336:	83 c4 1c             	add    $0x1c,%esp
  802339:	5b                   	pop    %ebx
  80233a:	5e                   	pop    %esi
  80233b:	5f                   	pop    %edi
  80233c:	5d                   	pop    %ebp
  80233d:	c3                   	ret    
  80233e:	66 90                	xchg   %ax,%ax
  802340:	89 d8                	mov    %ebx,%eax
  802342:	f7 f7                	div    %edi
  802344:	31 ff                	xor    %edi,%edi
  802346:	89 fa                	mov    %edi,%edx
  802348:	83 c4 1c             	add    $0x1c,%esp
  80234b:	5b                   	pop    %ebx
  80234c:	5e                   	pop    %esi
  80234d:	5f                   	pop    %edi
  80234e:	5d                   	pop    %ebp
  80234f:	c3                   	ret    
  802350:	bd 20 00 00 00       	mov    $0x20,%ebp
  802355:	89 eb                	mov    %ebp,%ebx
  802357:	29 fb                	sub    %edi,%ebx
  802359:	89 f9                	mov    %edi,%ecx
  80235b:	d3 e6                	shl    %cl,%esi
  80235d:	89 c5                	mov    %eax,%ebp
  80235f:	88 d9                	mov    %bl,%cl
  802361:	d3 ed                	shr    %cl,%ebp
  802363:	89 e9                	mov    %ebp,%ecx
  802365:	09 f1                	or     %esi,%ecx
  802367:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80236b:	89 f9                	mov    %edi,%ecx
  80236d:	d3 e0                	shl    %cl,%eax
  80236f:	89 c5                	mov    %eax,%ebp
  802371:	89 d6                	mov    %edx,%esi
  802373:	88 d9                	mov    %bl,%cl
  802375:	d3 ee                	shr    %cl,%esi
  802377:	89 f9                	mov    %edi,%ecx
  802379:	d3 e2                	shl    %cl,%edx
  80237b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80237f:	88 d9                	mov    %bl,%cl
  802381:	d3 e8                	shr    %cl,%eax
  802383:	09 c2                	or     %eax,%edx
  802385:	89 d0                	mov    %edx,%eax
  802387:	89 f2                	mov    %esi,%edx
  802389:	f7 74 24 0c          	divl   0xc(%esp)
  80238d:	89 d6                	mov    %edx,%esi
  80238f:	89 c3                	mov    %eax,%ebx
  802391:	f7 e5                	mul    %ebp
  802393:	39 d6                	cmp    %edx,%esi
  802395:	72 19                	jb     8023b0 <__udivdi3+0xfc>
  802397:	74 0b                	je     8023a4 <__udivdi3+0xf0>
  802399:	89 d8                	mov    %ebx,%eax
  80239b:	31 ff                	xor    %edi,%edi
  80239d:	e9 58 ff ff ff       	jmp    8022fa <__udivdi3+0x46>
  8023a2:	66 90                	xchg   %ax,%ax
  8023a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023a8:	89 f9                	mov    %edi,%ecx
  8023aa:	d3 e2                	shl    %cl,%edx
  8023ac:	39 c2                	cmp    %eax,%edx
  8023ae:	73 e9                	jae    802399 <__udivdi3+0xe5>
  8023b0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023b3:	31 ff                	xor    %edi,%edi
  8023b5:	e9 40 ff ff ff       	jmp    8022fa <__udivdi3+0x46>
  8023ba:	66 90                	xchg   %ax,%ax
  8023bc:	31 c0                	xor    %eax,%eax
  8023be:	e9 37 ff ff ff       	jmp    8022fa <__udivdi3+0x46>
  8023c3:	90                   	nop

008023c4 <__umoddi3>:
  8023c4:	55                   	push   %ebp
  8023c5:	57                   	push   %edi
  8023c6:	56                   	push   %esi
  8023c7:	53                   	push   %ebx
  8023c8:	83 ec 1c             	sub    $0x1c,%esp
  8023cb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023cf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023d7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023e3:	89 f3                	mov    %esi,%ebx
  8023e5:	89 fa                	mov    %edi,%edx
  8023e7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023eb:	89 34 24             	mov    %esi,(%esp)
  8023ee:	85 c0                	test   %eax,%eax
  8023f0:	75 1a                	jne    80240c <__umoddi3+0x48>
  8023f2:	39 f7                	cmp    %esi,%edi
  8023f4:	0f 86 a2 00 00 00    	jbe    80249c <__umoddi3+0xd8>
  8023fa:	89 c8                	mov    %ecx,%eax
  8023fc:	89 f2                	mov    %esi,%edx
  8023fe:	f7 f7                	div    %edi
  802400:	89 d0                	mov    %edx,%eax
  802402:	31 d2                	xor    %edx,%edx
  802404:	83 c4 1c             	add    $0x1c,%esp
  802407:	5b                   	pop    %ebx
  802408:	5e                   	pop    %esi
  802409:	5f                   	pop    %edi
  80240a:	5d                   	pop    %ebp
  80240b:	c3                   	ret    
  80240c:	39 f0                	cmp    %esi,%eax
  80240e:	0f 87 ac 00 00 00    	ja     8024c0 <__umoddi3+0xfc>
  802414:	0f bd e8             	bsr    %eax,%ebp
  802417:	83 f5 1f             	xor    $0x1f,%ebp
  80241a:	0f 84 ac 00 00 00    	je     8024cc <__umoddi3+0x108>
  802420:	bf 20 00 00 00       	mov    $0x20,%edi
  802425:	29 ef                	sub    %ebp,%edi
  802427:	89 fe                	mov    %edi,%esi
  802429:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80242d:	89 e9                	mov    %ebp,%ecx
  80242f:	d3 e0                	shl    %cl,%eax
  802431:	89 d7                	mov    %edx,%edi
  802433:	89 f1                	mov    %esi,%ecx
  802435:	d3 ef                	shr    %cl,%edi
  802437:	09 c7                	or     %eax,%edi
  802439:	89 e9                	mov    %ebp,%ecx
  80243b:	d3 e2                	shl    %cl,%edx
  80243d:	89 14 24             	mov    %edx,(%esp)
  802440:	89 d8                	mov    %ebx,%eax
  802442:	d3 e0                	shl    %cl,%eax
  802444:	89 c2                	mov    %eax,%edx
  802446:	8b 44 24 08          	mov    0x8(%esp),%eax
  80244a:	d3 e0                	shl    %cl,%eax
  80244c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802450:	8b 44 24 08          	mov    0x8(%esp),%eax
  802454:	89 f1                	mov    %esi,%ecx
  802456:	d3 e8                	shr    %cl,%eax
  802458:	09 d0                	or     %edx,%eax
  80245a:	d3 eb                	shr    %cl,%ebx
  80245c:	89 da                	mov    %ebx,%edx
  80245e:	f7 f7                	div    %edi
  802460:	89 d3                	mov    %edx,%ebx
  802462:	f7 24 24             	mull   (%esp)
  802465:	89 c6                	mov    %eax,%esi
  802467:	89 d1                	mov    %edx,%ecx
  802469:	39 d3                	cmp    %edx,%ebx
  80246b:	0f 82 87 00 00 00    	jb     8024f8 <__umoddi3+0x134>
  802471:	0f 84 91 00 00 00    	je     802508 <__umoddi3+0x144>
  802477:	8b 54 24 04          	mov    0x4(%esp),%edx
  80247b:	29 f2                	sub    %esi,%edx
  80247d:	19 cb                	sbb    %ecx,%ebx
  80247f:	89 d8                	mov    %ebx,%eax
  802481:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802485:	d3 e0                	shl    %cl,%eax
  802487:	89 e9                	mov    %ebp,%ecx
  802489:	d3 ea                	shr    %cl,%edx
  80248b:	09 d0                	or     %edx,%eax
  80248d:	89 e9                	mov    %ebp,%ecx
  80248f:	d3 eb                	shr    %cl,%ebx
  802491:	89 da                	mov    %ebx,%edx
  802493:	83 c4 1c             	add    $0x1c,%esp
  802496:	5b                   	pop    %ebx
  802497:	5e                   	pop    %esi
  802498:	5f                   	pop    %edi
  802499:	5d                   	pop    %ebp
  80249a:	c3                   	ret    
  80249b:	90                   	nop
  80249c:	89 fd                	mov    %edi,%ebp
  80249e:	85 ff                	test   %edi,%edi
  8024a0:	75 0b                	jne    8024ad <__umoddi3+0xe9>
  8024a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024a7:	31 d2                	xor    %edx,%edx
  8024a9:	f7 f7                	div    %edi
  8024ab:	89 c5                	mov    %eax,%ebp
  8024ad:	89 f0                	mov    %esi,%eax
  8024af:	31 d2                	xor    %edx,%edx
  8024b1:	f7 f5                	div    %ebp
  8024b3:	89 c8                	mov    %ecx,%eax
  8024b5:	f7 f5                	div    %ebp
  8024b7:	89 d0                	mov    %edx,%eax
  8024b9:	e9 44 ff ff ff       	jmp    802402 <__umoddi3+0x3e>
  8024be:	66 90                	xchg   %ax,%ax
  8024c0:	89 c8                	mov    %ecx,%eax
  8024c2:	89 f2                	mov    %esi,%edx
  8024c4:	83 c4 1c             	add    $0x1c,%esp
  8024c7:	5b                   	pop    %ebx
  8024c8:	5e                   	pop    %esi
  8024c9:	5f                   	pop    %edi
  8024ca:	5d                   	pop    %ebp
  8024cb:	c3                   	ret    
  8024cc:	3b 04 24             	cmp    (%esp),%eax
  8024cf:	72 06                	jb     8024d7 <__umoddi3+0x113>
  8024d1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024d5:	77 0f                	ja     8024e6 <__umoddi3+0x122>
  8024d7:	89 f2                	mov    %esi,%edx
  8024d9:	29 f9                	sub    %edi,%ecx
  8024db:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024df:	89 14 24             	mov    %edx,(%esp)
  8024e2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024ea:	8b 14 24             	mov    (%esp),%edx
  8024ed:	83 c4 1c             	add    $0x1c,%esp
  8024f0:	5b                   	pop    %ebx
  8024f1:	5e                   	pop    %esi
  8024f2:	5f                   	pop    %edi
  8024f3:	5d                   	pop    %ebp
  8024f4:	c3                   	ret    
  8024f5:	8d 76 00             	lea    0x0(%esi),%esi
  8024f8:	2b 04 24             	sub    (%esp),%eax
  8024fb:	19 fa                	sbb    %edi,%edx
  8024fd:	89 d1                	mov    %edx,%ecx
  8024ff:	89 c6                	mov    %eax,%esi
  802501:	e9 71 ff ff ff       	jmp    802477 <__umoddi3+0xb3>
  802506:	66 90                	xchg   %ax,%ax
  802508:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80250c:	72 ea                	jb     8024f8 <__umoddi3+0x134>
  80250e:	89 d9                	mov    %ebx,%ecx
  802510:	e9 62 ff ff ff       	jmp    802477 <__umoddi3+0xb3>
