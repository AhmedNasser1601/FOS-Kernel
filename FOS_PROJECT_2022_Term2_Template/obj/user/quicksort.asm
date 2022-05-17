
obj/user/quicksort:     file format elf32-i386


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
  800031:	e8 a0 05 00 00       	call   8005d6 <libmain>
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
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 83 1d 00 00       	call   801dd1 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 95 1d 00 00       	call   801dea <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

			readline("Enter the number of elements: ", Line);
  80005d:	83 ec 08             	sub    $0x8,%esp
  800060:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800066:	50                   	push   %eax
  800067:	68 00 25 80 00       	push   $0x802500
  80006c:	e8 aa 0f 00 00       	call   80101b <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 fa 14 00 00       	call   801581 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 72 1a 00 00       	call   801b0e <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 20 25 80 00       	push   $0x802520
  8000aa:	e8 ea 08 00 00       	call   800999 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 43 25 80 00       	push   $0x802543
  8000ba:	e8 da 08 00 00       	call   800999 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 51 25 80 00       	push   $0x802551
  8000ca:	e8 ca 08 00 00       	call   800999 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 60 25 80 00       	push   $0x802560
  8000da:	e8 ba 08 00 00       	call   800999 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e2:	e8 97 04 00 00       	call   80057e <getchar>
  8000e7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ea:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 3f 04 00 00       	call   800536 <cputchar>
  8000f7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	6a 0a                	push   $0xa
  8000ff:	e8 32 04 00 00       	call   800536 <cputchar>
  800104:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800107:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80010b:	83 f8 62             	cmp    $0x62,%eax
  80010e:	74 1d                	je     80012d <_main+0xf5>
  800110:	83 f8 63             	cmp    $0x63,%eax
  800113:	74 2b                	je     800140 <_main+0x108>
  800115:	83 f8 61             	cmp    $0x61,%eax
  800118:	75 39                	jne    800153 <_main+0x11b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80011a:	83 ec 08             	sub    $0x8,%esp
  80011d:	ff 75 ec             	pushl  -0x14(%ebp)
  800120:	ff 75 e8             	pushl  -0x18(%ebp)
  800123:	e8 d6 02 00 00       	call   8003fe <InitializeAscending>
  800128:	83 c4 10             	add    $0x10,%esp
			break ;
  80012b:	eb 37                	jmp    800164 <_main+0x12c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	ff 75 ec             	pushl  -0x14(%ebp)
  800133:	ff 75 e8             	pushl  -0x18(%ebp)
  800136:	e8 f4 02 00 00       	call   80042f <InitializeDescending>
  80013b:	83 c4 10             	add    $0x10,%esp
			break ;
  80013e:	eb 24                	jmp    800164 <_main+0x12c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 ec             	pushl  -0x14(%ebp)
  800146:	ff 75 e8             	pushl  -0x18(%ebp)
  800149:	e8 16 03 00 00       	call   800464 <InitializeSemiRandom>
  80014e:	83 c4 10             	add    $0x10,%esp
			break ;
  800151:	eb 11                	jmp    800164 <_main+0x12c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 ec             	pushl  -0x14(%ebp)
  800159:	ff 75 e8             	pushl  -0x18(%ebp)
  80015c:	e8 03 03 00 00       	call   800464 <InitializeSemiRandom>
  800161:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800164:	83 ec 08             	sub    $0x8,%esp
  800167:	ff 75 ec             	pushl  -0x14(%ebp)
  80016a:	ff 75 e8             	pushl  -0x18(%ebp)
  80016d:	e8 d1 00 00 00       	call   800243 <QuickSort>
  800172:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 d1 01 00 00       	call   800354 <CheckSorted>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800189:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80018d:	75 14                	jne    8001a3 <_main+0x16b>
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	68 78 25 80 00       	push   $0x802578
  800197:	6a 41                	push   $0x41
  800199:	68 9a 25 80 00       	push   $0x80259a
  80019e:	e8 42 05 00 00       	call   8006e5 <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	68 ac 25 80 00       	push   $0x8025ac
  8001ab:	e8 e9 07 00 00       	call   800999 <cprintf>
  8001b0:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001b3:	83 ec 0c             	sub    $0xc,%esp
  8001b6:	68 e0 25 80 00       	push   $0x8025e0
  8001bb:	e8 d9 07 00 00       	call   800999 <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001c3:	83 ec 0c             	sub    $0xc,%esp
  8001c6:	68 14 26 80 00       	push   $0x802614
  8001cb:	e8 c9 07 00 00       	call   800999 <cprintf>
  8001d0:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001d3:	83 ec 0c             	sub    $0xc,%esp
  8001d6:	68 46 26 80 00       	push   $0x802646
  8001db:	e8 b9 07 00 00       	call   800999 <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  8001e3:	83 ec 0c             	sub    $0xc,%esp
  8001e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e9:	e8 ae 19 00 00       	call   801b9c <free>
  8001ee:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  8001f1:	83 ec 0c             	sub    $0xc,%esp
  8001f4:	68 5c 26 80 00       	push   $0x80265c
  8001f9:	e8 9b 07 00 00       	call   800999 <cprintf>
  8001fe:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800201:	e8 78 03 00 00       	call   80057e <getchar>
  800206:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  800209:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80020d:	83 ec 0c             	sub    $0xc,%esp
  800210:	50                   	push   %eax
  800211:	e8 20 03 00 00       	call   800536 <cputchar>
  800216:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800219:	83 ec 0c             	sub    $0xc,%esp
  80021c:	6a 0a                	push   $0xa
  80021e:	e8 13 03 00 00       	call   800536 <cputchar>
  800223:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800226:	83 ec 0c             	sub    $0xc,%esp
  800229:	6a 0a                	push   $0xa
  80022b:	e8 06 03 00 00       	call   800536 <cputchar>
  800230:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800233:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800237:	0f 84 0c fe ff ff    	je     800049 <_main+0x11>

}
  80023d:	90                   	nop
  80023e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800241:	c9                   	leave  
  800242:	c3                   	ret    

00800243 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800243:	55                   	push   %ebp
  800244:	89 e5                	mov    %esp,%ebp
  800246:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024c:	48                   	dec    %eax
  80024d:	50                   	push   %eax
  80024e:	6a 00                	push   $0x0
  800250:	ff 75 0c             	pushl  0xc(%ebp)
  800253:	ff 75 08             	pushl  0x8(%ebp)
  800256:	e8 06 00 00 00       	call   800261 <QSort>
  80025b:	83 c4 10             	add    $0x10,%esp
}
  80025e:	90                   	nop
  80025f:	c9                   	leave  
  800260:	c3                   	ret    

00800261 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800261:	55                   	push   %ebp
  800262:	89 e5                	mov    %esp,%ebp
  800264:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800267:	8b 45 10             	mov    0x10(%ebp),%eax
  80026a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80026d:	0f 8d de 00 00 00    	jge    800351 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800273:	8b 45 10             	mov    0x10(%ebp),%eax
  800276:	40                   	inc    %eax
  800277:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80027a:	8b 45 14             	mov    0x14(%ebp),%eax
  80027d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800280:	e9 80 00 00 00       	jmp    800305 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800285:	ff 45 f4             	incl   -0xc(%ebp)
  800288:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80028b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80028e:	7f 2b                	jg     8002bb <QSort+0x5a>
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80029a:	8b 45 08             	mov    0x8(%ebp),%eax
  80029d:	01 d0                	add    %edx,%eax
  80029f:	8b 10                	mov    (%eax),%edx
  8002a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002a4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ae:	01 c8                	add    %ecx,%eax
  8002b0:	8b 00                	mov    (%eax),%eax
  8002b2:	39 c2                	cmp    %eax,%edx
  8002b4:	7d cf                	jge    800285 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002b6:	eb 03                	jmp    8002bb <QSort+0x5a>
  8002b8:	ff 4d f0             	decl   -0x10(%ebp)
  8002bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002be:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002c1:	7e 26                	jle    8002e9 <QSort+0x88>
  8002c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	01 d0                	add    %edx,%eax
  8002d2:	8b 10                	mov    (%eax),%edx
  8002d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002de:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e1:	01 c8                	add    %ecx,%eax
  8002e3:	8b 00                	mov    (%eax),%eax
  8002e5:	39 c2                	cmp    %eax,%edx
  8002e7:	7e cf                	jle    8002b8 <QSort+0x57>

		if (i <= j)
  8002e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002ef:	7f 14                	jg     800305 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8002f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fa:	ff 75 08             	pushl  0x8(%ebp)
  8002fd:	e8 a9 00 00 00       	call   8003ab <Swap>
  800302:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800305:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800308:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80030b:	0f 8e 77 ff ff ff    	jle    800288 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800311:	83 ec 04             	sub    $0x4,%esp
  800314:	ff 75 f0             	pushl  -0x10(%ebp)
  800317:	ff 75 10             	pushl  0x10(%ebp)
  80031a:	ff 75 08             	pushl  0x8(%ebp)
  80031d:	e8 89 00 00 00       	call   8003ab <Swap>
  800322:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800325:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800328:	48                   	dec    %eax
  800329:	50                   	push   %eax
  80032a:	ff 75 10             	pushl  0x10(%ebp)
  80032d:	ff 75 0c             	pushl  0xc(%ebp)
  800330:	ff 75 08             	pushl  0x8(%ebp)
  800333:	e8 29 ff ff ff       	call   800261 <QSort>
  800338:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80033b:	ff 75 14             	pushl  0x14(%ebp)
  80033e:	ff 75 f4             	pushl  -0xc(%ebp)
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	e8 15 ff ff ff       	call   800261 <QSort>
  80034c:	83 c4 10             	add    $0x10,%esp
  80034f:	eb 01                	jmp    800352 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800351:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800352:	c9                   	leave  
  800353:	c3                   	ret    

00800354 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800354:	55                   	push   %ebp
  800355:	89 e5                	mov    %esp,%ebp
  800357:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80035a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800361:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800368:	eb 33                	jmp    80039d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80036a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80036d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	01 d0                	add    %edx,%eax
  800379:	8b 10                	mov    (%eax),%edx
  80037b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80037e:	40                   	inc    %eax
  80037f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800386:	8b 45 08             	mov    0x8(%ebp),%eax
  800389:	01 c8                	add    %ecx,%eax
  80038b:	8b 00                	mov    (%eax),%eax
  80038d:	39 c2                	cmp    %eax,%edx
  80038f:	7e 09                	jle    80039a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800391:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800398:	eb 0c                	jmp    8003a6 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80039a:	ff 45 f8             	incl   -0x8(%ebp)
  80039d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a0:	48                   	dec    %eax
  8003a1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003a4:	7f c4                	jg     80036a <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003a9:	c9                   	leave  
  8003aa:	c3                   	ret    

008003ab <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003ab:	55                   	push   %ebp
  8003ac:	89 e5                	mov    %esp,%ebp
  8003ae:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003be:	01 d0                	add    %edx,%eax
  8003c0:	8b 00                	mov    (%eax),%eax
  8003c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 c2                	add    %eax,%edx
  8003d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8003d7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	01 c8                	add    %ecx,%eax
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	01 c2                	add    %eax,%edx
  8003f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f9:	89 02                	mov    %eax,(%edx)
}
  8003fb:	90                   	nop
  8003fc:	c9                   	leave  
  8003fd:	c3                   	ret    

008003fe <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800404:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80040b:	eb 17                	jmp    800424 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80040d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800410:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	01 c2                	add    %eax,%edx
  80041c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800421:	ff 45 fc             	incl   -0x4(%ebp)
  800424:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800427:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80042a:	7c e1                	jl     80040d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80042c:	90                   	nop
  80042d:	c9                   	leave  
  80042e:	c3                   	ret    

0080042f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80042f:	55                   	push   %ebp
  800430:	89 e5                	mov    %esp,%ebp
  800432:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80043c:	eb 1b                	jmp    800459 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	01 c2                	add    %eax,%edx
  80044d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800450:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800453:	48                   	dec    %eax
  800454:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800456:	ff 45 fc             	incl   -0x4(%ebp)
  800459:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045f:	7c dd                	jl     80043e <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800461:	90                   	nop
  800462:	c9                   	leave  
  800463:	c3                   	ret    

00800464 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800464:	55                   	push   %ebp
  800465:	89 e5                	mov    %esp,%ebp
  800467:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80046a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80046d:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800472:	f7 e9                	imul   %ecx
  800474:	c1 f9 1f             	sar    $0x1f,%ecx
  800477:	89 d0                	mov    %edx,%eax
  800479:	29 c8                	sub    %ecx,%eax
  80047b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  80047e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800485:	eb 1e                	jmp    8004a5 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800487:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800497:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049a:	99                   	cltd   
  80049b:	f7 7d f8             	idivl  -0x8(%ebp)
  80049e:	89 d0                	mov    %edx,%eax
  8004a0:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a2:	ff 45 fc             	incl   -0x4(%ebp)
  8004a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004ab:	7c da                	jl     800487 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004ad:	90                   	nop
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004b6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004c4:	eb 42                	jmp    800508 <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c9:	99                   	cltd   
  8004ca:	f7 7d f0             	idivl  -0x10(%ebp)
  8004cd:	89 d0                	mov    %edx,%eax
  8004cf:	85 c0                	test   %eax,%eax
  8004d1:	75 10                	jne    8004e3 <PrintElements+0x33>
				cprintf("\n");
  8004d3:	83 ec 0c             	sub    $0xc,%esp
  8004d6:	68 7a 26 80 00       	push   $0x80267a
  8004db:	e8 b9 04 00 00       	call   800999 <cprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8004e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	01 d0                	add    %edx,%eax
  8004f2:	8b 00                	mov    (%eax),%eax
  8004f4:	83 ec 08             	sub    $0x8,%esp
  8004f7:	50                   	push   %eax
  8004f8:	68 7c 26 80 00       	push   $0x80267c
  8004fd:	e8 97 04 00 00       	call   800999 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800505:	ff 45 f4             	incl   -0xc(%ebp)
  800508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050b:	48                   	dec    %eax
  80050c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80050f:	7f b5                	jg     8004c6 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	83 ec 08             	sub    $0x8,%esp
  800525:	50                   	push   %eax
  800526:	68 81 26 80 00       	push   $0x802681
  80052b:	e8 69 04 00 00       	call   800999 <cprintf>
  800530:	83 c4 10             	add    $0x10,%esp
}
  800533:	90                   	nop
  800534:	c9                   	leave  
  800535:	c3                   	ret    

00800536 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800536:	55                   	push   %ebp
  800537:	89 e5                	mov    %esp,%ebp
  800539:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80053c:	8b 45 08             	mov    0x8(%ebp),%eax
  80053f:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800542:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 86 19 00 00       	call   801ed5 <sys_cputc>
  80054f:	83 c4 10             	add    $0x10,%esp
}
  800552:	90                   	nop
  800553:	c9                   	leave  
  800554:	c3                   	ret    

00800555 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800555:	55                   	push   %ebp
  800556:	89 e5                	mov    %esp,%ebp
  800558:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80055b:	e8 41 19 00 00       	call   801ea1 <sys_disable_interrupt>
	char c = ch;
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800566:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80056a:	83 ec 0c             	sub    $0xc,%esp
  80056d:	50                   	push   %eax
  80056e:	e8 62 19 00 00       	call   801ed5 <sys_cputc>
  800573:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800576:	e8 40 19 00 00       	call   801ebb <sys_enable_interrupt>
}
  80057b:	90                   	nop
  80057c:	c9                   	leave  
  80057d:	c3                   	ret    

0080057e <getchar>:

int
getchar(void)
{
  80057e:	55                   	push   %ebp
  80057f:	89 e5                	mov    %esp,%ebp
  800581:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800584:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80058b:	eb 08                	jmp    800595 <getchar+0x17>
	{
		c = sys_cgetc();
  80058d:	e8 27 17 00 00       	call   801cb9 <sys_cgetc>
  800592:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800595:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800599:	74 f2                	je     80058d <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80059b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a6:	e8 f6 18 00 00       	call   801ea1 <sys_disable_interrupt>
	int c=0;
  8005ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005b2:	eb 08                	jmp    8005bc <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005b4:	e8 00 17 00 00       	call   801cb9 <sys_cgetc>
  8005b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c0:	74 f2                	je     8005b4 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005c2:	e8 f4 18 00 00       	call   801ebb <sys_enable_interrupt>
	return c;
  8005c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ca:	c9                   	leave  
  8005cb:	c3                   	ret    

008005cc <iscons>:

int iscons(int fdnum)
{
  8005cc:	55                   	push   %ebp
  8005cd:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005cf:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005d4:	5d                   	pop    %ebp
  8005d5:	c3                   	ret    

008005d6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005dc:	e8 25 17 00 00       	call   801d06 <sys_getenvindex>
  8005e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e7:	89 d0                	mov    %edx,%eax
  8005e9:	c1 e0 02             	shl    $0x2,%eax
  8005ec:	01 d0                	add    %edx,%eax
  8005ee:	01 c0                	add    %eax,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	01 c0                	add    %eax,%eax
  8005f4:	01 d0                	add    %edx,%eax
  8005f6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005fd:	01 d0                	add    %edx,%eax
  8005ff:	c1 e0 02             	shl    $0x2,%eax
  800602:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800607:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80060c:	a1 24 30 80 00       	mov    0x803024,%eax
  800611:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800617:	84 c0                	test   %al,%al
  800619:	74 0f                	je     80062a <libmain+0x54>
		binaryname = myEnv->prog_name;
  80061b:	a1 24 30 80 00       	mov    0x803024,%eax
  800620:	05 f4 02 00 00       	add    $0x2f4,%eax
  800625:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80062a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80062e:	7e 0a                	jle    80063a <libmain+0x64>
		binaryname = argv[0];
  800630:	8b 45 0c             	mov    0xc(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 0c             	pushl  0xc(%ebp)
  800640:	ff 75 08             	pushl  0x8(%ebp)
  800643:	e8 f0 f9 ff ff       	call   800038 <_main>
  800648:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80064b:	e8 51 18 00 00       	call   801ea1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800650:	83 ec 0c             	sub    $0xc,%esp
  800653:	68 a0 26 80 00       	push   $0x8026a0
  800658:	e8 3c 03 00 00       	call   800999 <cprintf>
  80065d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800660:	a1 24 30 80 00       	mov    0x803024,%eax
  800665:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80066b:	a1 24 30 80 00       	mov    0x803024,%eax
  800670:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800676:	83 ec 04             	sub    $0x4,%esp
  800679:	52                   	push   %edx
  80067a:	50                   	push   %eax
  80067b:	68 c8 26 80 00       	push   $0x8026c8
  800680:	e8 14 03 00 00       	call   800999 <cprintf>
  800685:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800688:	a1 24 30 80 00       	mov    0x803024,%eax
  80068d:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	50                   	push   %eax
  800697:	68 ed 26 80 00       	push   $0x8026ed
  80069c:	e8 f8 02 00 00       	call   800999 <cprintf>
  8006a1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006a4:	83 ec 0c             	sub    $0xc,%esp
  8006a7:	68 a0 26 80 00       	push   $0x8026a0
  8006ac:	e8 e8 02 00 00       	call   800999 <cprintf>
  8006b1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006b4:	e8 02 18 00 00       	call   801ebb <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006b9:	e8 19 00 00 00       	call   8006d7 <exit>
}
  8006be:	90                   	nop
  8006bf:	c9                   	leave  
  8006c0:	c3                   	ret    

008006c1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006c1:	55                   	push   %ebp
  8006c2:	89 e5                	mov    %esp,%ebp
  8006c4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006c7:	83 ec 0c             	sub    $0xc,%esp
  8006ca:	6a 00                	push   $0x0
  8006cc:	e8 01 16 00 00       	call   801cd2 <sys_env_destroy>
  8006d1:	83 c4 10             	add    $0x10,%esp
}
  8006d4:	90                   	nop
  8006d5:	c9                   	leave  
  8006d6:	c3                   	ret    

008006d7 <exit>:

void
exit(void)
{
  8006d7:	55                   	push   %ebp
  8006d8:	89 e5                	mov    %esp,%ebp
  8006da:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006dd:	e8 56 16 00 00       	call   801d38 <sys_env_exit>
}
  8006e2:	90                   	nop
  8006e3:	c9                   	leave  
  8006e4:	c3                   	ret    

008006e5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006e5:	55                   	push   %ebp
  8006e6:	89 e5                	mov    %esp,%ebp
  8006e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8006ee:	83 c0 04             	add    $0x4,%eax
  8006f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006f4:	a1 48 30 88 00       	mov    0x883048,%eax
  8006f9:	85 c0                	test   %eax,%eax
  8006fb:	74 16                	je     800713 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006fd:	a1 48 30 88 00       	mov    0x883048,%eax
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	50                   	push   %eax
  800706:	68 04 27 80 00       	push   $0x802704
  80070b:	e8 89 02 00 00       	call   800999 <cprintf>
  800710:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800713:	a1 00 30 80 00       	mov    0x803000,%eax
  800718:	ff 75 0c             	pushl  0xc(%ebp)
  80071b:	ff 75 08             	pushl  0x8(%ebp)
  80071e:	50                   	push   %eax
  80071f:	68 09 27 80 00       	push   $0x802709
  800724:	e8 70 02 00 00       	call   800999 <cprintf>
  800729:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80072c:	8b 45 10             	mov    0x10(%ebp),%eax
  80072f:	83 ec 08             	sub    $0x8,%esp
  800732:	ff 75 f4             	pushl  -0xc(%ebp)
  800735:	50                   	push   %eax
  800736:	e8 f3 01 00 00       	call   80092e <vcprintf>
  80073b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	6a 00                	push   $0x0
  800743:	68 25 27 80 00       	push   $0x802725
  800748:	e8 e1 01 00 00       	call   80092e <vcprintf>
  80074d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800750:	e8 82 ff ff ff       	call   8006d7 <exit>

	// should not return here
	while (1) ;
  800755:	eb fe                	jmp    800755 <_panic+0x70>

00800757 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800757:	55                   	push   %ebp
  800758:	89 e5                	mov    %esp,%ebp
  80075a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80075d:	a1 24 30 80 00       	mov    0x803024,%eax
  800762:	8b 50 74             	mov    0x74(%eax),%edx
  800765:	8b 45 0c             	mov    0xc(%ebp),%eax
  800768:	39 c2                	cmp    %eax,%edx
  80076a:	74 14                	je     800780 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80076c:	83 ec 04             	sub    $0x4,%esp
  80076f:	68 28 27 80 00       	push   $0x802728
  800774:	6a 26                	push   $0x26
  800776:	68 74 27 80 00       	push   $0x802774
  80077b:	e8 65 ff ff ff       	call   8006e5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800780:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800787:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80078e:	e9 c2 00 00 00       	jmp    800855 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800793:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800796:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	01 d0                	add    %edx,%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	85 c0                	test   %eax,%eax
  8007a6:	75 08                	jne    8007b0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007a8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007ab:	e9 a2 00 00 00       	jmp    800852 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007b7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007be:	eb 69                	jmp    800829 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007c0:	a1 24 30 80 00       	mov    0x803024,%eax
  8007c5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ce:	89 d0                	mov    %edx,%eax
  8007d0:	01 c0                	add    %eax,%eax
  8007d2:	01 d0                	add    %edx,%eax
  8007d4:	c1 e0 02             	shl    $0x2,%eax
  8007d7:	01 c8                	add    %ecx,%eax
  8007d9:	8a 40 04             	mov    0x4(%eax),%al
  8007dc:	84 c0                	test   %al,%al
  8007de:	75 46                	jne    800826 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e5:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ee:	89 d0                	mov    %edx,%eax
  8007f0:	01 c0                	add    %eax,%eax
  8007f2:	01 d0                	add    %edx,%eax
  8007f4:	c1 e0 02             	shl    $0x2,%eax
  8007f7:	01 c8                	add    %ecx,%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007fe:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800801:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800806:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800808:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80080b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800812:	8b 45 08             	mov    0x8(%ebp),%eax
  800815:	01 c8                	add    %ecx,%eax
  800817:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800819:	39 c2                	cmp    %eax,%edx
  80081b:	75 09                	jne    800826 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80081d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800824:	eb 12                	jmp    800838 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800826:	ff 45 e8             	incl   -0x18(%ebp)
  800829:	a1 24 30 80 00       	mov    0x803024,%eax
  80082e:	8b 50 74             	mov    0x74(%eax),%edx
  800831:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800834:	39 c2                	cmp    %eax,%edx
  800836:	77 88                	ja     8007c0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800838:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80083c:	75 14                	jne    800852 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80083e:	83 ec 04             	sub    $0x4,%esp
  800841:	68 80 27 80 00       	push   $0x802780
  800846:	6a 3a                	push   $0x3a
  800848:	68 74 27 80 00       	push   $0x802774
  80084d:	e8 93 fe ff ff       	call   8006e5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800852:	ff 45 f0             	incl   -0x10(%ebp)
  800855:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800858:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80085b:	0f 8c 32 ff ff ff    	jl     800793 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800861:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800868:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80086f:	eb 26                	jmp    800897 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800871:	a1 24 30 80 00       	mov    0x803024,%eax
  800876:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80087c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80087f:	89 d0                	mov    %edx,%eax
  800881:	01 c0                	add    %eax,%eax
  800883:	01 d0                	add    %edx,%eax
  800885:	c1 e0 02             	shl    $0x2,%eax
  800888:	01 c8                	add    %ecx,%eax
  80088a:	8a 40 04             	mov    0x4(%eax),%al
  80088d:	3c 01                	cmp    $0x1,%al
  80088f:	75 03                	jne    800894 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800891:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800894:	ff 45 e0             	incl   -0x20(%ebp)
  800897:	a1 24 30 80 00       	mov    0x803024,%eax
  80089c:	8b 50 74             	mov    0x74(%eax),%edx
  80089f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	77 cb                	ja     800871 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008a9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008ac:	74 14                	je     8008c2 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008ae:	83 ec 04             	sub    $0x4,%esp
  8008b1:	68 d4 27 80 00       	push   $0x8027d4
  8008b6:	6a 44                	push   $0x44
  8008b8:	68 74 27 80 00       	push   $0x802774
  8008bd:	e8 23 fe ff ff       	call   8006e5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008c2:	90                   	nop
  8008c3:	c9                   	leave  
  8008c4:	c3                   	ret    

008008c5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008c5:	55                   	push   %ebp
  8008c6:	89 e5                	mov    %esp,%ebp
  8008c8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	8d 48 01             	lea    0x1(%eax),%ecx
  8008d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d6:	89 0a                	mov    %ecx,(%edx)
  8008d8:	8b 55 08             	mov    0x8(%ebp),%edx
  8008db:	88 d1                	mov    %dl,%cl
  8008dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008ee:	75 2c                	jne    80091c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008f0:	a0 28 30 80 00       	mov    0x803028,%al
  8008f5:	0f b6 c0             	movzbl %al,%eax
  8008f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fb:	8b 12                	mov    (%edx),%edx
  8008fd:	89 d1                	mov    %edx,%ecx
  8008ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800902:	83 c2 08             	add    $0x8,%edx
  800905:	83 ec 04             	sub    $0x4,%esp
  800908:	50                   	push   %eax
  800909:	51                   	push   %ecx
  80090a:	52                   	push   %edx
  80090b:	e8 80 13 00 00       	call   801c90 <sys_cputs>
  800910:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	8b 40 04             	mov    0x4(%eax),%eax
  800922:	8d 50 01             	lea    0x1(%eax),%edx
  800925:	8b 45 0c             	mov    0xc(%ebp),%eax
  800928:	89 50 04             	mov    %edx,0x4(%eax)
}
  80092b:	90                   	nop
  80092c:	c9                   	leave  
  80092d:	c3                   	ret    

0080092e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80092e:	55                   	push   %ebp
  80092f:	89 e5                	mov    %esp,%ebp
  800931:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800937:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80093e:	00 00 00 
	b.cnt = 0;
  800941:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800948:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80094b:	ff 75 0c             	pushl  0xc(%ebp)
  80094e:	ff 75 08             	pushl  0x8(%ebp)
  800951:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800957:	50                   	push   %eax
  800958:	68 c5 08 80 00       	push   $0x8008c5
  80095d:	e8 11 02 00 00       	call   800b73 <vprintfmt>
  800962:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800965:	a0 28 30 80 00       	mov    0x803028,%al
  80096a:	0f b6 c0             	movzbl %al,%eax
  80096d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	50                   	push   %eax
  800977:	52                   	push   %edx
  800978:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097e:	83 c0 08             	add    $0x8,%eax
  800981:	50                   	push   %eax
  800982:	e8 09 13 00 00       	call   801c90 <sys_cputs>
  800987:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80098a:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800991:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800997:	c9                   	leave  
  800998:	c3                   	ret    

00800999 <cprintf>:

int cprintf(const char *fmt, ...) {
  800999:	55                   	push   %ebp
  80099a:	89 e5                	mov    %esp,%ebp
  80099c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80099f:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b5:	50                   	push   %eax
  8009b6:	e8 73 ff ff ff       	call   80092e <vcprintf>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009cc:	e8 d0 14 00 00       	call   801ea1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009d1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e0:	50                   	push   %eax
  8009e1:	e8 48 ff ff ff       	call   80092e <vcprintf>
  8009e6:	83 c4 10             	add    $0x10,%esp
  8009e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009ec:	e8 ca 14 00 00       	call   801ebb <sys_enable_interrupt>
	return cnt;
  8009f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	53                   	push   %ebx
  8009fa:	83 ec 14             	sub    $0x14,%esp
  8009fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800a00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a03:	8b 45 14             	mov    0x14(%ebp),%eax
  800a06:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a09:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a11:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a14:	77 55                	ja     800a6b <printnum+0x75>
  800a16:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a19:	72 05                	jb     800a20 <printnum+0x2a>
  800a1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a1e:	77 4b                	ja     800a6b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a20:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a23:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a26:	8b 45 18             	mov    0x18(%ebp),%eax
  800a29:	ba 00 00 00 00       	mov    $0x0,%edx
  800a2e:	52                   	push   %edx
  800a2f:	50                   	push   %eax
  800a30:	ff 75 f4             	pushl  -0xc(%ebp)
  800a33:	ff 75 f0             	pushl  -0x10(%ebp)
  800a36:	e8 45 18 00 00       	call   802280 <__udivdi3>
  800a3b:	83 c4 10             	add    $0x10,%esp
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	ff 75 20             	pushl  0x20(%ebp)
  800a44:	53                   	push   %ebx
  800a45:	ff 75 18             	pushl  0x18(%ebp)
  800a48:	52                   	push   %edx
  800a49:	50                   	push   %eax
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	ff 75 08             	pushl  0x8(%ebp)
  800a50:	e8 a1 ff ff ff       	call   8009f6 <printnum>
  800a55:	83 c4 20             	add    $0x20,%esp
  800a58:	eb 1a                	jmp    800a74 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a5a:	83 ec 08             	sub    $0x8,%esp
  800a5d:	ff 75 0c             	pushl  0xc(%ebp)
  800a60:	ff 75 20             	pushl  0x20(%ebp)
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a6b:	ff 4d 1c             	decl   0x1c(%ebp)
  800a6e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a72:	7f e6                	jg     800a5a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a74:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a77:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a82:	53                   	push   %ebx
  800a83:	51                   	push   %ecx
  800a84:	52                   	push   %edx
  800a85:	50                   	push   %eax
  800a86:	e8 05 19 00 00       	call   802390 <__umoddi3>
  800a8b:	83 c4 10             	add    $0x10,%esp
  800a8e:	05 34 2a 80 00       	add    $0x802a34,%eax
  800a93:	8a 00                	mov    (%eax),%al
  800a95:	0f be c0             	movsbl %al,%eax
  800a98:	83 ec 08             	sub    $0x8,%esp
  800a9b:	ff 75 0c             	pushl  0xc(%ebp)
  800a9e:	50                   	push   %eax
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	ff d0                	call   *%eax
  800aa4:	83 c4 10             	add    $0x10,%esp
}
  800aa7:	90                   	nop
  800aa8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aab:	c9                   	leave  
  800aac:	c3                   	ret    

00800aad <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aad:	55                   	push   %ebp
  800aae:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ab0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ab4:	7e 1c                	jle    800ad2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	8d 50 08             	lea    0x8(%eax),%edx
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	89 10                	mov    %edx,(%eax)
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	83 e8 08             	sub    $0x8,%eax
  800acb:	8b 50 04             	mov    0x4(%eax),%edx
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	eb 40                	jmp    800b12 <getuint+0x65>
	else if (lflag)
  800ad2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ad6:	74 1e                	je     800af6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	8d 50 04             	lea    0x4(%eax),%edx
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	89 10                	mov    %edx,(%eax)
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8b 00                	mov    (%eax),%eax
  800aea:	83 e8 04             	sub    $0x4,%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	ba 00 00 00 00       	mov    $0x0,%edx
  800af4:	eb 1c                	jmp    800b12 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	8b 00                	mov    (%eax),%eax
  800afb:	8d 50 04             	lea    0x4(%eax),%edx
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	89 10                	mov    %edx,(%eax)
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	83 e8 04             	sub    $0x4,%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b12:	5d                   	pop    %ebp
  800b13:	c3                   	ret    

00800b14 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b14:	55                   	push   %ebp
  800b15:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b17:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b1b:	7e 1c                	jle    800b39 <getint+0x25>
		return va_arg(*ap, long long);
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	8d 50 08             	lea    0x8(%eax),%edx
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 10                	mov    %edx,(%eax)
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	8b 00                	mov    (%eax),%eax
  800b2f:	83 e8 08             	sub    $0x8,%eax
  800b32:	8b 50 04             	mov    0x4(%eax),%edx
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	eb 38                	jmp    800b71 <getint+0x5d>
	else if (lflag)
  800b39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b3d:	74 1a                	je     800b59 <getint+0x45>
		return va_arg(*ap, long);
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	8d 50 04             	lea    0x4(%eax),%edx
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	89 10                	mov    %edx,(%eax)
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	83 e8 04             	sub    $0x4,%eax
  800b54:	8b 00                	mov    (%eax),%eax
  800b56:	99                   	cltd   
  800b57:	eb 18                	jmp    800b71 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	8d 50 04             	lea    0x4(%eax),%edx
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	89 10                	mov    %edx,(%eax)
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	83 e8 04             	sub    $0x4,%eax
  800b6e:	8b 00                	mov    (%eax),%eax
  800b70:	99                   	cltd   
}
  800b71:	5d                   	pop    %ebp
  800b72:	c3                   	ret    

00800b73 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b73:	55                   	push   %ebp
  800b74:	89 e5                	mov    %esp,%ebp
  800b76:	56                   	push   %esi
  800b77:	53                   	push   %ebx
  800b78:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b7b:	eb 17                	jmp    800b94 <vprintfmt+0x21>
			if (ch == '\0')
  800b7d:	85 db                	test   %ebx,%ebx
  800b7f:	0f 84 af 03 00 00    	je     800f34 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b85:	83 ec 08             	sub    $0x8,%esp
  800b88:	ff 75 0c             	pushl  0xc(%ebp)
  800b8b:	53                   	push   %ebx
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	ff d0                	call   *%eax
  800b91:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b94:	8b 45 10             	mov    0x10(%ebp),%eax
  800b97:	8d 50 01             	lea    0x1(%eax),%edx
  800b9a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9d:	8a 00                	mov    (%eax),%al
  800b9f:	0f b6 d8             	movzbl %al,%ebx
  800ba2:	83 fb 25             	cmp    $0x25,%ebx
  800ba5:	75 d6                	jne    800b7d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ba7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bab:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bb2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bb9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bc0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bca:	8d 50 01             	lea    0x1(%eax),%edx
  800bcd:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd0:	8a 00                	mov    (%eax),%al
  800bd2:	0f b6 d8             	movzbl %al,%ebx
  800bd5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bd8:	83 f8 55             	cmp    $0x55,%eax
  800bdb:	0f 87 2b 03 00 00    	ja     800f0c <vprintfmt+0x399>
  800be1:	8b 04 85 58 2a 80 00 	mov    0x802a58(,%eax,4),%eax
  800be8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bea:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bee:	eb d7                	jmp    800bc7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bf0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bf4:	eb d1                	jmp    800bc7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bf6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bfd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c00:	89 d0                	mov    %edx,%eax
  800c02:	c1 e0 02             	shl    $0x2,%eax
  800c05:	01 d0                	add    %edx,%eax
  800c07:	01 c0                	add    %eax,%eax
  800c09:	01 d8                	add    %ebx,%eax
  800c0b:	83 e8 30             	sub    $0x30,%eax
  800c0e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c11:	8b 45 10             	mov    0x10(%ebp),%eax
  800c14:	8a 00                	mov    (%eax),%al
  800c16:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c19:	83 fb 2f             	cmp    $0x2f,%ebx
  800c1c:	7e 3e                	jle    800c5c <vprintfmt+0xe9>
  800c1e:	83 fb 39             	cmp    $0x39,%ebx
  800c21:	7f 39                	jg     800c5c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c23:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c26:	eb d5                	jmp    800bfd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c28:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2b:	83 c0 04             	add    $0x4,%eax
  800c2e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c31:	8b 45 14             	mov    0x14(%ebp),%eax
  800c34:	83 e8 04             	sub    $0x4,%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c3c:	eb 1f                	jmp    800c5d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c42:	79 83                	jns    800bc7 <vprintfmt+0x54>
				width = 0;
  800c44:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c4b:	e9 77 ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c50:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c57:	e9 6b ff ff ff       	jmp    800bc7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c5c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c61:	0f 89 60 ff ff ff    	jns    800bc7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c6d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c74:	e9 4e ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c79:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c7c:	e9 46 ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 c0 04             	add    $0x4,%eax
  800c87:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8d:	83 e8 04             	sub    $0x4,%eax
  800c90:	8b 00                	mov    (%eax),%eax
  800c92:	83 ec 08             	sub    $0x8,%esp
  800c95:	ff 75 0c             	pushl  0xc(%ebp)
  800c98:	50                   	push   %eax
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	ff d0                	call   *%eax
  800c9e:	83 c4 10             	add    $0x10,%esp
			break;
  800ca1:	e9 89 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ca6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca9:	83 c0 04             	add    $0x4,%eax
  800cac:	89 45 14             	mov    %eax,0x14(%ebp)
  800caf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb2:	83 e8 04             	sub    $0x4,%eax
  800cb5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cb7:	85 db                	test   %ebx,%ebx
  800cb9:	79 02                	jns    800cbd <vprintfmt+0x14a>
				err = -err;
  800cbb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cbd:	83 fb 64             	cmp    $0x64,%ebx
  800cc0:	7f 0b                	jg     800ccd <vprintfmt+0x15a>
  800cc2:	8b 34 9d a0 28 80 00 	mov    0x8028a0(,%ebx,4),%esi
  800cc9:	85 f6                	test   %esi,%esi
  800ccb:	75 19                	jne    800ce6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ccd:	53                   	push   %ebx
  800cce:	68 45 2a 80 00       	push   $0x802a45
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	ff 75 08             	pushl  0x8(%ebp)
  800cd9:	e8 5e 02 00 00       	call   800f3c <printfmt>
  800cde:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ce1:	e9 49 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ce6:	56                   	push   %esi
  800ce7:	68 4e 2a 80 00       	push   $0x802a4e
  800cec:	ff 75 0c             	pushl  0xc(%ebp)
  800cef:	ff 75 08             	pushl  0x8(%ebp)
  800cf2:	e8 45 02 00 00       	call   800f3c <printfmt>
  800cf7:	83 c4 10             	add    $0x10,%esp
			break;
  800cfa:	e9 30 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cff:	8b 45 14             	mov    0x14(%ebp),%eax
  800d02:	83 c0 04             	add    $0x4,%eax
  800d05:	89 45 14             	mov    %eax,0x14(%ebp)
  800d08:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0b:	83 e8 04             	sub    $0x4,%eax
  800d0e:	8b 30                	mov    (%eax),%esi
  800d10:	85 f6                	test   %esi,%esi
  800d12:	75 05                	jne    800d19 <vprintfmt+0x1a6>
				p = "(null)";
  800d14:	be 51 2a 80 00       	mov    $0x802a51,%esi
			if (width > 0 && padc != '-')
  800d19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d1d:	7e 6d                	jle    800d8c <vprintfmt+0x219>
  800d1f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d23:	74 67                	je     800d8c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d25:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d28:	83 ec 08             	sub    $0x8,%esp
  800d2b:	50                   	push   %eax
  800d2c:	56                   	push   %esi
  800d2d:	e8 12 05 00 00       	call   801244 <strnlen>
  800d32:	83 c4 10             	add    $0x10,%esp
  800d35:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d38:	eb 16                	jmp    800d50 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d3a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d3e:	83 ec 08             	sub    $0x8,%esp
  800d41:	ff 75 0c             	pushl  0xc(%ebp)
  800d44:	50                   	push   %eax
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	ff d0                	call   *%eax
  800d4a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d4d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d54:	7f e4                	jg     800d3a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d56:	eb 34                	jmp    800d8c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d58:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d5c:	74 1c                	je     800d7a <vprintfmt+0x207>
  800d5e:	83 fb 1f             	cmp    $0x1f,%ebx
  800d61:	7e 05                	jle    800d68 <vprintfmt+0x1f5>
  800d63:	83 fb 7e             	cmp    $0x7e,%ebx
  800d66:	7e 12                	jle    800d7a <vprintfmt+0x207>
					putch('?', putdat);
  800d68:	83 ec 08             	sub    $0x8,%esp
  800d6b:	ff 75 0c             	pushl  0xc(%ebp)
  800d6e:	6a 3f                	push   $0x3f
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	ff d0                	call   *%eax
  800d75:	83 c4 10             	add    $0x10,%esp
  800d78:	eb 0f                	jmp    800d89 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d7a:	83 ec 08             	sub    $0x8,%esp
  800d7d:	ff 75 0c             	pushl  0xc(%ebp)
  800d80:	53                   	push   %ebx
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	ff d0                	call   *%eax
  800d86:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d89:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8c:	89 f0                	mov    %esi,%eax
  800d8e:	8d 70 01             	lea    0x1(%eax),%esi
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	0f be d8             	movsbl %al,%ebx
  800d96:	85 db                	test   %ebx,%ebx
  800d98:	74 24                	je     800dbe <vprintfmt+0x24b>
  800d9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9e:	78 b8                	js     800d58 <vprintfmt+0x1e5>
  800da0:	ff 4d e0             	decl   -0x20(%ebp)
  800da3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800da7:	79 af                	jns    800d58 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da9:	eb 13                	jmp    800dbe <vprintfmt+0x24b>
				putch(' ', putdat);
  800dab:	83 ec 08             	sub    $0x8,%esp
  800dae:	ff 75 0c             	pushl  0xc(%ebp)
  800db1:	6a 20                	push   $0x20
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	ff d0                	call   *%eax
  800db8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dbb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc2:	7f e7                	jg     800dab <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dc4:	e9 66 01 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dc9:	83 ec 08             	sub    $0x8,%esp
  800dcc:	ff 75 e8             	pushl  -0x18(%ebp)
  800dcf:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd2:	50                   	push   %eax
  800dd3:	e8 3c fd ff ff       	call   800b14 <getint>
  800dd8:	83 c4 10             	add    $0x10,%esp
  800ddb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dde:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800de1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de7:	85 d2                	test   %edx,%edx
  800de9:	79 23                	jns    800e0e <vprintfmt+0x29b>
				putch('-', putdat);
  800deb:	83 ec 08             	sub    $0x8,%esp
  800dee:	ff 75 0c             	pushl  0xc(%ebp)
  800df1:	6a 2d                	push   $0x2d
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	ff d0                	call   *%eax
  800df8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e01:	f7 d8                	neg    %eax
  800e03:	83 d2 00             	adc    $0x0,%edx
  800e06:	f7 da                	neg    %edx
  800e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e0e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e15:	e9 bc 00 00 00       	jmp    800ed6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e1a:	83 ec 08             	sub    $0x8,%esp
  800e1d:	ff 75 e8             	pushl  -0x18(%ebp)
  800e20:	8d 45 14             	lea    0x14(%ebp),%eax
  800e23:	50                   	push   %eax
  800e24:	e8 84 fc ff ff       	call   800aad <getuint>
  800e29:	83 c4 10             	add    $0x10,%esp
  800e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e39:	e9 98 00 00 00       	jmp    800ed6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 0c             	pushl  0xc(%ebp)
  800e44:	6a 58                	push   $0x58
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	ff d0                	call   *%eax
  800e4b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	6a 58                	push   $0x58
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	ff d0                	call   *%eax
  800e5b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 58                	push   $0x58
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			break;
  800e6e:	e9 bc 00 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e73:	83 ec 08             	sub    $0x8,%esp
  800e76:	ff 75 0c             	pushl  0xc(%ebp)
  800e79:	6a 30                	push   $0x30
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	ff d0                	call   *%eax
  800e80:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e83:	83 ec 08             	sub    $0x8,%esp
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	6a 78                	push   $0x78
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	ff d0                	call   *%eax
  800e90:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e93:	8b 45 14             	mov    0x14(%ebp),%eax
  800e96:	83 c0 04             	add    $0x4,%eax
  800e99:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9f:	83 e8 04             	sub    $0x4,%eax
  800ea2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eb5:	eb 1f                	jmp    800ed6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eb7:	83 ec 08             	sub    $0x8,%esp
  800eba:	ff 75 e8             	pushl  -0x18(%ebp)
  800ebd:	8d 45 14             	lea    0x14(%ebp),%eax
  800ec0:	50                   	push   %eax
  800ec1:	e8 e7 fb ff ff       	call   800aad <getuint>
  800ec6:	83 c4 10             	add    $0x10,%esp
  800ec9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ecf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ed6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eda:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800edd:	83 ec 04             	sub    $0x4,%esp
  800ee0:	52                   	push   %edx
  800ee1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ee4:	50                   	push   %eax
  800ee5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ee8:	ff 75 f0             	pushl  -0x10(%ebp)
  800eeb:	ff 75 0c             	pushl  0xc(%ebp)
  800eee:	ff 75 08             	pushl  0x8(%ebp)
  800ef1:	e8 00 fb ff ff       	call   8009f6 <printnum>
  800ef6:	83 c4 20             	add    $0x20,%esp
			break;
  800ef9:	eb 34                	jmp    800f2f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800efb:	83 ec 08             	sub    $0x8,%esp
  800efe:	ff 75 0c             	pushl  0xc(%ebp)
  800f01:	53                   	push   %ebx
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	ff d0                	call   *%eax
  800f07:	83 c4 10             	add    $0x10,%esp
			break;
  800f0a:	eb 23                	jmp    800f2f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f0c:	83 ec 08             	sub    $0x8,%esp
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	6a 25                	push   $0x25
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	ff d0                	call   *%eax
  800f19:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f1c:	ff 4d 10             	decl   0x10(%ebp)
  800f1f:	eb 03                	jmp    800f24 <vprintfmt+0x3b1>
  800f21:	ff 4d 10             	decl   0x10(%ebp)
  800f24:	8b 45 10             	mov    0x10(%ebp),%eax
  800f27:	48                   	dec    %eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 25                	cmp    $0x25,%al
  800f2c:	75 f3                	jne    800f21 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f2e:	90                   	nop
		}
	}
  800f2f:	e9 47 fc ff ff       	jmp    800b7b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f34:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f35:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f38:	5b                   	pop    %ebx
  800f39:	5e                   	pop    %esi
  800f3a:	5d                   	pop    %ebp
  800f3b:	c3                   	ret    

00800f3c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
  800f3f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f42:	8d 45 10             	lea    0x10(%ebp),%eax
  800f45:	83 c0 04             	add    $0x4,%eax
  800f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f51:	50                   	push   %eax
  800f52:	ff 75 0c             	pushl  0xc(%ebp)
  800f55:	ff 75 08             	pushl  0x8(%ebp)
  800f58:	e8 16 fc ff ff       	call   800b73 <vprintfmt>
  800f5d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f60:	90                   	nop
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8b 40 08             	mov    0x8(%eax),%eax
  800f6c:	8d 50 01             	lea    0x1(%eax),%edx
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f78:	8b 10                	mov    (%eax),%edx
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	8b 40 04             	mov    0x4(%eax),%eax
  800f80:	39 c2                	cmp    %eax,%edx
  800f82:	73 12                	jae    800f96 <sprintputch+0x33>
		*b->buf++ = ch;
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	8b 00                	mov    (%eax),%eax
  800f89:	8d 48 01             	lea    0x1(%eax),%ecx
  800f8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f8f:	89 0a                	mov    %ecx,(%edx)
  800f91:	8b 55 08             	mov    0x8(%ebp),%edx
  800f94:	88 10                	mov    %dl,(%eax)
}
  800f96:	90                   	nop
  800f97:	5d                   	pop    %ebp
  800f98:	c3                   	ret    

00800f99 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f99:	55                   	push   %ebp
  800f9a:	89 e5                	mov    %esp,%ebp
  800f9c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	01 d0                	add    %edx,%eax
  800fb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fbe:	74 06                	je     800fc6 <vsnprintf+0x2d>
  800fc0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc4:	7f 07                	jg     800fcd <vsnprintf+0x34>
		return -E_INVAL;
  800fc6:	b8 03 00 00 00       	mov    $0x3,%eax
  800fcb:	eb 20                	jmp    800fed <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fcd:	ff 75 14             	pushl  0x14(%ebp)
  800fd0:	ff 75 10             	pushl  0x10(%ebp)
  800fd3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fd6:	50                   	push   %eax
  800fd7:	68 63 0f 80 00       	push   $0x800f63
  800fdc:	e8 92 fb ff ff       	call   800b73 <vprintfmt>
  800fe1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fe7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fed:	c9                   	leave  
  800fee:	c3                   	ret    

00800fef <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fef:	55                   	push   %ebp
  800ff0:	89 e5                	mov    %esp,%ebp
  800ff2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ff5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ff8:	83 c0 04             	add    $0x4,%eax
  800ffb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ffe:	8b 45 10             	mov    0x10(%ebp),%eax
  801001:	ff 75 f4             	pushl  -0xc(%ebp)
  801004:	50                   	push   %eax
  801005:	ff 75 0c             	pushl  0xc(%ebp)
  801008:	ff 75 08             	pushl  0x8(%ebp)
  80100b:	e8 89 ff ff ff       	call   800f99 <vsnprintf>
  801010:	83 c4 10             	add    $0x10,%esp
  801013:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801016:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801019:	c9                   	leave  
  80101a:	c3                   	ret    

0080101b <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80101b:	55                   	push   %ebp
  80101c:	89 e5                	mov    %esp,%ebp
  80101e:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801021:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801025:	74 13                	je     80103a <readline+0x1f>
		cprintf("%s", prompt);
  801027:	83 ec 08             	sub    $0x8,%esp
  80102a:	ff 75 08             	pushl  0x8(%ebp)
  80102d:	68 b0 2b 80 00       	push   $0x802bb0
  801032:	e8 62 f9 ff ff       	call   800999 <cprintf>
  801037:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80103a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801041:	83 ec 0c             	sub    $0xc,%esp
  801044:	6a 00                	push   $0x0
  801046:	e8 81 f5 ff ff       	call   8005cc <iscons>
  80104b:	83 c4 10             	add    $0x10,%esp
  80104e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801051:	e8 28 f5 ff ff       	call   80057e <getchar>
  801056:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801059:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80105d:	79 22                	jns    801081 <readline+0x66>
			if (c != -E_EOF)
  80105f:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801063:	0f 84 ad 00 00 00    	je     801116 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801069:	83 ec 08             	sub    $0x8,%esp
  80106c:	ff 75 ec             	pushl  -0x14(%ebp)
  80106f:	68 b3 2b 80 00       	push   $0x802bb3
  801074:	e8 20 f9 ff ff       	call   800999 <cprintf>
  801079:	83 c4 10             	add    $0x10,%esp
			return;
  80107c:	e9 95 00 00 00       	jmp    801116 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801081:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801085:	7e 34                	jle    8010bb <readline+0xa0>
  801087:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80108e:	7f 2b                	jg     8010bb <readline+0xa0>
			if (echoing)
  801090:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801094:	74 0e                	je     8010a4 <readline+0x89>
				cputchar(c);
  801096:	83 ec 0c             	sub    $0xc,%esp
  801099:	ff 75 ec             	pushl  -0x14(%ebp)
  80109c:	e8 95 f4 ff ff       	call   800536 <cputchar>
  8010a1:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010a7:	8d 50 01             	lea    0x1(%eax),%edx
  8010aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010ad:	89 c2                	mov    %eax,%edx
  8010af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b2:	01 d0                	add    %edx,%eax
  8010b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010b7:	88 10                	mov    %dl,(%eax)
  8010b9:	eb 56                	jmp    801111 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010bb:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010bf:	75 1f                	jne    8010e0 <readline+0xc5>
  8010c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010c5:	7e 19                	jle    8010e0 <readline+0xc5>
			if (echoing)
  8010c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010cb:	74 0e                	je     8010db <readline+0xc0>
				cputchar(c);
  8010cd:	83 ec 0c             	sub    $0xc,%esp
  8010d0:	ff 75 ec             	pushl  -0x14(%ebp)
  8010d3:	e8 5e f4 ff ff       	call   800536 <cputchar>
  8010d8:	83 c4 10             	add    $0x10,%esp

			i--;
  8010db:	ff 4d f4             	decl   -0xc(%ebp)
  8010de:	eb 31                	jmp    801111 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010e0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8010e4:	74 0a                	je     8010f0 <readline+0xd5>
  8010e6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8010ea:	0f 85 61 ff ff ff    	jne    801051 <readline+0x36>
			if (echoing)
  8010f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010f4:	74 0e                	je     801104 <readline+0xe9>
				cputchar(c);
  8010f6:	83 ec 0c             	sub    $0xc,%esp
  8010f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8010fc:	e8 35 f4 ff ff       	call   800536 <cputchar>
  801101:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801104:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110a:	01 d0                	add    %edx,%eax
  80110c:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80110f:	eb 06                	jmp    801117 <readline+0xfc>
		}
	}
  801111:	e9 3b ff ff ff       	jmp    801051 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801116:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801117:	c9                   	leave  
  801118:	c3                   	ret    

00801119 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801119:	55                   	push   %ebp
  80111a:	89 e5                	mov    %esp,%ebp
  80111c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80111f:	e8 7d 0d 00 00       	call   801ea1 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801124:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801128:	74 13                	je     80113d <atomic_readline+0x24>
		cprintf("%s", prompt);
  80112a:	83 ec 08             	sub    $0x8,%esp
  80112d:	ff 75 08             	pushl  0x8(%ebp)
  801130:	68 b0 2b 80 00       	push   $0x802bb0
  801135:	e8 5f f8 ff ff       	call   800999 <cprintf>
  80113a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80113d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801144:	83 ec 0c             	sub    $0xc,%esp
  801147:	6a 00                	push   $0x0
  801149:	e8 7e f4 ff ff       	call   8005cc <iscons>
  80114e:	83 c4 10             	add    $0x10,%esp
  801151:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801154:	e8 25 f4 ff ff       	call   80057e <getchar>
  801159:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80115c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801160:	79 23                	jns    801185 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801162:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801166:	74 13                	je     80117b <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801168:	83 ec 08             	sub    $0x8,%esp
  80116b:	ff 75 ec             	pushl  -0x14(%ebp)
  80116e:	68 b3 2b 80 00       	push   $0x802bb3
  801173:	e8 21 f8 ff ff       	call   800999 <cprintf>
  801178:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80117b:	e8 3b 0d 00 00       	call   801ebb <sys_enable_interrupt>
			return;
  801180:	e9 9a 00 00 00       	jmp    80121f <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801185:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801189:	7e 34                	jle    8011bf <atomic_readline+0xa6>
  80118b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801192:	7f 2b                	jg     8011bf <atomic_readline+0xa6>
			if (echoing)
  801194:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801198:	74 0e                	je     8011a8 <atomic_readline+0x8f>
				cputchar(c);
  80119a:	83 ec 0c             	sub    $0xc,%esp
  80119d:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a0:	e8 91 f3 ff ff       	call   800536 <cputchar>
  8011a5:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ab:	8d 50 01             	lea    0x1(%eax),%edx
  8011ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011b1:	89 c2                	mov    %eax,%edx
  8011b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011bb:	88 10                	mov    %dl,(%eax)
  8011bd:	eb 5b                	jmp    80121a <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011bf:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011c3:	75 1f                	jne    8011e4 <atomic_readline+0xcb>
  8011c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011c9:	7e 19                	jle    8011e4 <atomic_readline+0xcb>
			if (echoing)
  8011cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011cf:	74 0e                	je     8011df <atomic_readline+0xc6>
				cputchar(c);
  8011d1:	83 ec 0c             	sub    $0xc,%esp
  8011d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d7:	e8 5a f3 ff ff       	call   800536 <cputchar>
  8011dc:	83 c4 10             	add    $0x10,%esp
			i--;
  8011df:	ff 4d f4             	decl   -0xc(%ebp)
  8011e2:	eb 36                	jmp    80121a <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8011e4:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011e8:	74 0a                	je     8011f4 <atomic_readline+0xdb>
  8011ea:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011ee:	0f 85 60 ff ff ff    	jne    801154 <atomic_readline+0x3b>
			if (echoing)
  8011f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f8:	74 0e                	je     801208 <atomic_readline+0xef>
				cputchar(c);
  8011fa:	83 ec 0c             	sub    $0xc,%esp
  8011fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801200:	e8 31 f3 ff ff       	call   800536 <cputchar>
  801205:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801208:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80120b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120e:	01 d0                	add    %edx,%eax
  801210:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801213:	e8 a3 0c 00 00       	call   801ebb <sys_enable_interrupt>
			return;
  801218:	eb 05                	jmp    80121f <atomic_readline+0x106>
		}
	}
  80121a:	e9 35 ff ff ff       	jmp    801154 <atomic_readline+0x3b>
}
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
  801224:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801227:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80122e:	eb 06                	jmp    801236 <strlen+0x15>
		n++;
  801230:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801233:	ff 45 08             	incl   0x8(%ebp)
  801236:	8b 45 08             	mov    0x8(%ebp),%eax
  801239:	8a 00                	mov    (%eax),%al
  80123b:	84 c0                	test   %al,%al
  80123d:	75 f1                	jne    801230 <strlen+0xf>
		n++;
	return n;
  80123f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801242:	c9                   	leave  
  801243:	c3                   	ret    

00801244 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801244:	55                   	push   %ebp
  801245:	89 e5                	mov    %esp,%ebp
  801247:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80124a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801251:	eb 09                	jmp    80125c <strnlen+0x18>
		n++;
  801253:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801256:	ff 45 08             	incl   0x8(%ebp)
  801259:	ff 4d 0c             	decl   0xc(%ebp)
  80125c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801260:	74 09                	je     80126b <strnlen+0x27>
  801262:	8b 45 08             	mov    0x8(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	84 c0                	test   %al,%al
  801269:	75 e8                	jne    801253 <strnlen+0xf>
		n++;
	return n;
  80126b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126e:	c9                   	leave  
  80126f:	c3                   	ret    

00801270 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801270:	55                   	push   %ebp
  801271:	89 e5                	mov    %esp,%ebp
  801273:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80127c:	90                   	nop
  80127d:	8b 45 08             	mov    0x8(%ebp),%eax
  801280:	8d 50 01             	lea    0x1(%eax),%edx
  801283:	89 55 08             	mov    %edx,0x8(%ebp)
  801286:	8b 55 0c             	mov    0xc(%ebp),%edx
  801289:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80128f:	8a 12                	mov    (%edx),%dl
  801291:	88 10                	mov    %dl,(%eax)
  801293:	8a 00                	mov    (%eax),%al
  801295:	84 c0                	test   %al,%al
  801297:	75 e4                	jne    80127d <strcpy+0xd>
		/* do nothing */;
	return ret;
  801299:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
  8012a1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b1:	eb 1f                	jmp    8012d2 <strncpy+0x34>
		*dst++ = *src;
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	8d 50 01             	lea    0x1(%eax),%edx
  8012b9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bf:	8a 12                	mov    (%edx),%dl
  8012c1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	84 c0                	test   %al,%al
  8012ca:	74 03                	je     8012cf <strncpy+0x31>
			src++;
  8012cc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012cf:	ff 45 fc             	incl   -0x4(%ebp)
  8012d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d8:	72 d9                	jb     8012b3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
  8012e2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ef:	74 30                	je     801321 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012f1:	eb 16                	jmp    801309 <strlcpy+0x2a>
			*dst++ = *src++;
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	8d 50 01             	lea    0x1(%eax),%edx
  8012f9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801302:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801305:	8a 12                	mov    (%edx),%dl
  801307:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801309:	ff 4d 10             	decl   0x10(%ebp)
  80130c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801310:	74 09                	je     80131b <strlcpy+0x3c>
  801312:	8b 45 0c             	mov    0xc(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	84 c0                	test   %al,%al
  801319:	75 d8                	jne    8012f3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801321:	8b 55 08             	mov    0x8(%ebp),%edx
  801324:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801327:	29 c2                	sub    %eax,%edx
  801329:	89 d0                	mov    %edx,%eax
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801330:	eb 06                	jmp    801338 <strcmp+0xb>
		p++, q++;
  801332:	ff 45 08             	incl   0x8(%ebp)
  801335:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	84 c0                	test   %al,%al
  80133f:	74 0e                	je     80134f <strcmp+0x22>
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 10                	mov    (%eax),%dl
  801346:	8b 45 0c             	mov    0xc(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	38 c2                	cmp    %al,%dl
  80134d:	74 e3                	je     801332 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	0f b6 d0             	movzbl %al,%edx
  801357:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135a:	8a 00                	mov    (%eax),%al
  80135c:	0f b6 c0             	movzbl %al,%eax
  80135f:	29 c2                	sub    %eax,%edx
  801361:	89 d0                	mov    %edx,%eax
}
  801363:	5d                   	pop    %ebp
  801364:	c3                   	ret    

00801365 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801368:	eb 09                	jmp    801373 <strncmp+0xe>
		n--, p++, q++;
  80136a:	ff 4d 10             	decl   0x10(%ebp)
  80136d:	ff 45 08             	incl   0x8(%ebp)
  801370:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801373:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801377:	74 17                	je     801390 <strncmp+0x2b>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	84 c0                	test   %al,%al
  801380:	74 0e                	je     801390 <strncmp+0x2b>
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	8a 10                	mov    (%eax),%dl
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	38 c2                	cmp    %al,%dl
  80138e:	74 da                	je     80136a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801390:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801394:	75 07                	jne    80139d <strncmp+0x38>
		return 0;
  801396:	b8 00 00 00 00       	mov    $0x0,%eax
  80139b:	eb 14                	jmp    8013b1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	0f b6 d0             	movzbl %al,%edx
  8013a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	0f b6 c0             	movzbl %al,%eax
  8013ad:	29 c2                	sub    %eax,%edx
  8013af:	89 d0                	mov    %edx,%eax
}
  8013b1:	5d                   	pop    %ebp
  8013b2:	c3                   	ret    

008013b3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
  8013b6:	83 ec 04             	sub    $0x4,%esp
  8013b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013bf:	eb 12                	jmp    8013d3 <strchr+0x20>
		if (*s == c)
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c9:	75 05                	jne    8013d0 <strchr+0x1d>
			return (char *) s;
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	eb 11                	jmp    8013e1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013d0:	ff 45 08             	incl   0x8(%ebp)
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	8a 00                	mov    (%eax),%al
  8013d8:	84 c0                	test   %al,%al
  8013da:	75 e5                	jne    8013c1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013e1:	c9                   	leave  
  8013e2:	c3                   	ret    

008013e3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
  8013e6:	83 ec 04             	sub    $0x4,%esp
  8013e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ef:	eb 0d                	jmp    8013fe <strfind+0x1b>
		if (*s == c)
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f9:	74 0e                	je     801409 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013fb:	ff 45 08             	incl   0x8(%ebp)
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	8a 00                	mov    (%eax),%al
  801403:	84 c0                	test   %al,%al
  801405:	75 ea                	jne    8013f1 <strfind+0xe>
  801407:	eb 01                	jmp    80140a <strfind+0x27>
		if (*s == c)
			break;
  801409:	90                   	nop
	return (char *) s;
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80140d:	c9                   	leave  
  80140e:	c3                   	ret    

0080140f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80140f:	55                   	push   %ebp
  801410:	89 e5                	mov    %esp,%ebp
  801412:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80141b:	8b 45 10             	mov    0x10(%ebp),%eax
  80141e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801421:	eb 0e                	jmp    801431 <memset+0x22>
		*p++ = c;
  801423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801426:	8d 50 01             	lea    0x1(%eax),%edx
  801429:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80142c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80142f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801431:	ff 4d f8             	decl   -0x8(%ebp)
  801434:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801438:	79 e9                	jns    801423 <memset+0x14>
		*p++ = c;

	return v;
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801451:	eb 16                	jmp    801469 <memcpy+0x2a>
		*d++ = *s++;
  801453:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801456:	8d 50 01             	lea    0x1(%eax),%edx
  801459:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80145c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801462:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801465:	8a 12                	mov    (%edx),%dl
  801467:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801469:	8b 45 10             	mov    0x10(%ebp),%eax
  80146c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80146f:	89 55 10             	mov    %edx,0x10(%ebp)
  801472:	85 c0                	test   %eax,%eax
  801474:	75 dd                	jne    801453 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801481:	8b 45 0c             	mov    0xc(%ebp),%eax
  801484:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80148d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801490:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801493:	73 50                	jae    8014e5 <memmove+0x6a>
  801495:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801498:	8b 45 10             	mov    0x10(%ebp),%eax
  80149b:	01 d0                	add    %edx,%eax
  80149d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014a0:	76 43                	jbe    8014e5 <memmove+0x6a>
		s += n;
  8014a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ab:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014ae:	eb 10                	jmp    8014c0 <memmove+0x45>
			*--d = *--s;
  8014b0:	ff 4d f8             	decl   -0x8(%ebp)
  8014b3:	ff 4d fc             	decl   -0x4(%ebp)
  8014b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b9:	8a 10                	mov    (%eax),%dl
  8014bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014be:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8014c9:	85 c0                	test   %eax,%eax
  8014cb:	75 e3                	jne    8014b0 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014cd:	eb 23                	jmp    8014f2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d2:	8d 50 01             	lea    0x1(%eax),%edx
  8014d5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014db:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014de:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e1:	8a 12                	mov    (%edx),%dl
  8014e3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014eb:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ee:	85 c0                	test   %eax,%eax
  8014f0:	75 dd                	jne    8014cf <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
  8014fa:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801503:	8b 45 0c             	mov    0xc(%ebp),%eax
  801506:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801509:	eb 2a                	jmp    801535 <memcmp+0x3e>
		if (*s1 != *s2)
  80150b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150e:	8a 10                	mov    (%eax),%dl
  801510:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801513:	8a 00                	mov    (%eax),%al
  801515:	38 c2                	cmp    %al,%dl
  801517:	74 16                	je     80152f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801519:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151c:	8a 00                	mov    (%eax),%al
  80151e:	0f b6 d0             	movzbl %al,%edx
  801521:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801524:	8a 00                	mov    (%eax),%al
  801526:	0f b6 c0             	movzbl %al,%eax
  801529:	29 c2                	sub    %eax,%edx
  80152b:	89 d0                	mov    %edx,%eax
  80152d:	eb 18                	jmp    801547 <memcmp+0x50>
		s1++, s2++;
  80152f:	ff 45 fc             	incl   -0x4(%ebp)
  801532:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801535:	8b 45 10             	mov    0x10(%ebp),%eax
  801538:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153b:	89 55 10             	mov    %edx,0x10(%ebp)
  80153e:	85 c0                	test   %eax,%eax
  801540:	75 c9                	jne    80150b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801542:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801547:	c9                   	leave  
  801548:	c3                   	ret    

00801549 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801549:	55                   	push   %ebp
  80154a:	89 e5                	mov    %esp,%ebp
  80154c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80154f:	8b 55 08             	mov    0x8(%ebp),%edx
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	01 d0                	add    %edx,%eax
  801557:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80155a:	eb 15                	jmp    801571 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	0f b6 d0             	movzbl %al,%edx
  801564:	8b 45 0c             	mov    0xc(%ebp),%eax
  801567:	0f b6 c0             	movzbl %al,%eax
  80156a:	39 c2                	cmp    %eax,%edx
  80156c:	74 0d                	je     80157b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80156e:	ff 45 08             	incl   0x8(%ebp)
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801577:	72 e3                	jb     80155c <memfind+0x13>
  801579:	eb 01                	jmp    80157c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80157b:	90                   	nop
	return (void *) s;
  80157c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801587:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80158e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801595:	eb 03                	jmp    80159a <strtol+0x19>
		s++;
  801597:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	8a 00                	mov    (%eax),%al
  80159f:	3c 20                	cmp    $0x20,%al
  8015a1:	74 f4                	je     801597 <strtol+0x16>
  8015a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a6:	8a 00                	mov    (%eax),%al
  8015a8:	3c 09                	cmp    $0x9,%al
  8015aa:	74 eb                	je     801597 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	8a 00                	mov    (%eax),%al
  8015b1:	3c 2b                	cmp    $0x2b,%al
  8015b3:	75 05                	jne    8015ba <strtol+0x39>
		s++;
  8015b5:	ff 45 08             	incl   0x8(%ebp)
  8015b8:	eb 13                	jmp    8015cd <strtol+0x4c>
	else if (*s == '-')
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	8a 00                	mov    (%eax),%al
  8015bf:	3c 2d                	cmp    $0x2d,%al
  8015c1:	75 0a                	jne    8015cd <strtol+0x4c>
		s++, neg = 1;
  8015c3:	ff 45 08             	incl   0x8(%ebp)
  8015c6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d1:	74 06                	je     8015d9 <strtol+0x58>
  8015d3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015d7:	75 20                	jne    8015f9 <strtol+0x78>
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	8a 00                	mov    (%eax),%al
  8015de:	3c 30                	cmp    $0x30,%al
  8015e0:	75 17                	jne    8015f9 <strtol+0x78>
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	40                   	inc    %eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	3c 78                	cmp    $0x78,%al
  8015ea:	75 0d                	jne    8015f9 <strtol+0x78>
		s += 2, base = 16;
  8015ec:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015f0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015f7:	eb 28                	jmp    801621 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fd:	75 15                	jne    801614 <strtol+0x93>
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	8a 00                	mov    (%eax),%al
  801604:	3c 30                	cmp    $0x30,%al
  801606:	75 0c                	jne    801614 <strtol+0x93>
		s++, base = 8;
  801608:	ff 45 08             	incl   0x8(%ebp)
  80160b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801612:	eb 0d                	jmp    801621 <strtol+0xa0>
	else if (base == 0)
  801614:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801618:	75 07                	jne    801621 <strtol+0xa0>
		base = 10;
  80161a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	3c 2f                	cmp    $0x2f,%al
  801628:	7e 19                	jle    801643 <strtol+0xc2>
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	3c 39                	cmp    $0x39,%al
  801631:	7f 10                	jg     801643 <strtol+0xc2>
			dig = *s - '0';
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	0f be c0             	movsbl %al,%eax
  80163b:	83 e8 30             	sub    $0x30,%eax
  80163e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801641:	eb 42                	jmp    801685 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	3c 60                	cmp    $0x60,%al
  80164a:	7e 19                	jle    801665 <strtol+0xe4>
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	3c 7a                	cmp    $0x7a,%al
  801653:	7f 10                	jg     801665 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	8a 00                	mov    (%eax),%al
  80165a:	0f be c0             	movsbl %al,%eax
  80165d:	83 e8 57             	sub    $0x57,%eax
  801660:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801663:	eb 20                	jmp    801685 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	3c 40                	cmp    $0x40,%al
  80166c:	7e 39                	jle    8016a7 <strtol+0x126>
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	3c 5a                	cmp    $0x5a,%al
  801675:	7f 30                	jg     8016a7 <strtol+0x126>
			dig = *s - 'A' + 10;
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	0f be c0             	movsbl %al,%eax
  80167f:	83 e8 37             	sub    $0x37,%eax
  801682:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801685:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801688:	3b 45 10             	cmp    0x10(%ebp),%eax
  80168b:	7d 19                	jge    8016a6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80168d:	ff 45 08             	incl   0x8(%ebp)
  801690:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801693:	0f af 45 10          	imul   0x10(%ebp),%eax
  801697:	89 c2                	mov    %eax,%edx
  801699:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169c:	01 d0                	add    %edx,%eax
  80169e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016a1:	e9 7b ff ff ff       	jmp    801621 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016a6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016ab:	74 08                	je     8016b5 <strtol+0x134>
		*endptr = (char *) s;
  8016ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b0:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016b9:	74 07                	je     8016c2 <strtol+0x141>
  8016bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016be:	f7 d8                	neg    %eax
  8016c0:	eb 03                	jmp    8016c5 <strtol+0x144>
  8016c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <ltostr>:

void
ltostr(long value, char *str)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016df:	79 13                	jns    8016f4 <ltostr+0x2d>
	{
		neg = 1;
  8016e1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016eb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016ee:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016f1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016fc:	99                   	cltd   
  8016fd:	f7 f9                	idiv   %ecx
  8016ff:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801702:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801705:	8d 50 01             	lea    0x1(%eax),%edx
  801708:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80170b:	89 c2                	mov    %eax,%edx
  80170d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801710:	01 d0                	add    %edx,%eax
  801712:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801715:	83 c2 30             	add    $0x30,%edx
  801718:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80171a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80171d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801722:	f7 e9                	imul   %ecx
  801724:	c1 fa 02             	sar    $0x2,%edx
  801727:	89 c8                	mov    %ecx,%eax
  801729:	c1 f8 1f             	sar    $0x1f,%eax
  80172c:	29 c2                	sub    %eax,%edx
  80172e:	89 d0                	mov    %edx,%eax
  801730:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801733:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801736:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173b:	f7 e9                	imul   %ecx
  80173d:	c1 fa 02             	sar    $0x2,%edx
  801740:	89 c8                	mov    %ecx,%eax
  801742:	c1 f8 1f             	sar    $0x1f,%eax
  801745:	29 c2                	sub    %eax,%edx
  801747:	89 d0                	mov    %edx,%eax
  801749:	c1 e0 02             	shl    $0x2,%eax
  80174c:	01 d0                	add    %edx,%eax
  80174e:	01 c0                	add    %eax,%eax
  801750:	29 c1                	sub    %eax,%ecx
  801752:	89 ca                	mov    %ecx,%edx
  801754:	85 d2                	test   %edx,%edx
  801756:	75 9c                	jne    8016f4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801758:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80175f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801762:	48                   	dec    %eax
  801763:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801766:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80176a:	74 3d                	je     8017a9 <ltostr+0xe2>
		start = 1 ;
  80176c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801773:	eb 34                	jmp    8017a9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801775:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801778:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177b:	01 d0                	add    %edx,%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801782:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801785:	8b 45 0c             	mov    0xc(%ebp),%eax
  801788:	01 c2                	add    %eax,%edx
  80178a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80178d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801790:	01 c8                	add    %ecx,%eax
  801792:	8a 00                	mov    (%eax),%al
  801794:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801796:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801799:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179c:	01 c2                	add    %eax,%edx
  80179e:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017a1:	88 02                	mov    %al,(%edx)
		start++ ;
  8017a3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017a6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017af:	7c c4                	jl     801775 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017b1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b7:	01 d0                	add    %edx,%eax
  8017b9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017bc:	90                   	nop
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
  8017c2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	e8 54 fa ff ff       	call   801221 <strlen>
  8017cd:	83 c4 04             	add    $0x4,%esp
  8017d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017d3:	ff 75 0c             	pushl  0xc(%ebp)
  8017d6:	e8 46 fa ff ff       	call   801221 <strlen>
  8017db:	83 c4 04             	add    $0x4,%esp
  8017de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017ef:	eb 17                	jmp    801808 <strcconcat+0x49>
		final[s] = str1[s] ;
  8017f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f7:	01 c2                	add    %eax,%edx
  8017f9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	01 c8                	add    %ecx,%eax
  801801:	8a 00                	mov    (%eax),%al
  801803:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801805:	ff 45 fc             	incl   -0x4(%ebp)
  801808:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80180b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80180e:	7c e1                	jl     8017f1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801810:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801817:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80181e:	eb 1f                	jmp    80183f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801820:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801823:	8d 50 01             	lea    0x1(%eax),%edx
  801826:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801829:	89 c2                	mov    %eax,%edx
  80182b:	8b 45 10             	mov    0x10(%ebp),%eax
  80182e:	01 c2                	add    %eax,%edx
  801830:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801833:	8b 45 0c             	mov    0xc(%ebp),%eax
  801836:	01 c8                	add    %ecx,%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80183c:	ff 45 f8             	incl   -0x8(%ebp)
  80183f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801842:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801845:	7c d9                	jl     801820 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801847:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80184a:	8b 45 10             	mov    0x10(%ebp),%eax
  80184d:	01 d0                	add    %edx,%eax
  80184f:	c6 00 00             	movb   $0x0,(%eax)
}
  801852:	90                   	nop
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801858:	8b 45 14             	mov    0x14(%ebp),%eax
  80185b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801861:	8b 45 14             	mov    0x14(%ebp),%eax
  801864:	8b 00                	mov    (%eax),%eax
  801866:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80186d:	8b 45 10             	mov    0x10(%ebp),%eax
  801870:	01 d0                	add    %edx,%eax
  801872:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801878:	eb 0c                	jmp    801886 <strsplit+0x31>
			*string++ = 0;
  80187a:	8b 45 08             	mov    0x8(%ebp),%eax
  80187d:	8d 50 01             	lea    0x1(%eax),%edx
  801880:	89 55 08             	mov    %edx,0x8(%ebp)
  801883:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801886:	8b 45 08             	mov    0x8(%ebp),%eax
  801889:	8a 00                	mov    (%eax),%al
  80188b:	84 c0                	test   %al,%al
  80188d:	74 18                	je     8018a7 <strsplit+0x52>
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	8a 00                	mov    (%eax),%al
  801894:	0f be c0             	movsbl %al,%eax
  801897:	50                   	push   %eax
  801898:	ff 75 0c             	pushl  0xc(%ebp)
  80189b:	e8 13 fb ff ff       	call   8013b3 <strchr>
  8018a0:	83 c4 08             	add    $0x8,%esp
  8018a3:	85 c0                	test   %eax,%eax
  8018a5:	75 d3                	jne    80187a <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	8a 00                	mov    (%eax),%al
  8018ac:	84 c0                	test   %al,%al
  8018ae:	74 5a                	je     80190a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b3:	8b 00                	mov    (%eax),%eax
  8018b5:	83 f8 0f             	cmp    $0xf,%eax
  8018b8:	75 07                	jne    8018c1 <strsplit+0x6c>
		{
			return 0;
  8018ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8018bf:	eb 66                	jmp    801927 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c4:	8b 00                	mov    (%eax),%eax
  8018c6:	8d 48 01             	lea    0x1(%eax),%ecx
  8018c9:	8b 55 14             	mov    0x14(%ebp),%edx
  8018cc:	89 0a                	mov    %ecx,(%edx)
  8018ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d8:	01 c2                	add    %eax,%edx
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018df:	eb 03                	jmp    8018e4 <strsplit+0x8f>
			string++;
  8018e1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e7:	8a 00                	mov    (%eax),%al
  8018e9:	84 c0                	test   %al,%al
  8018eb:	74 8b                	je     801878 <strsplit+0x23>
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	8a 00                	mov    (%eax),%al
  8018f2:	0f be c0             	movsbl %al,%eax
  8018f5:	50                   	push   %eax
  8018f6:	ff 75 0c             	pushl  0xc(%ebp)
  8018f9:	e8 b5 fa ff ff       	call   8013b3 <strchr>
  8018fe:	83 c4 08             	add    $0x8,%esp
  801901:	85 c0                	test   %eax,%eax
  801903:	74 dc                	je     8018e1 <strsplit+0x8c>
			string++;
	}
  801905:	e9 6e ff ff ff       	jmp    801878 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80190a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80190b:	8b 45 14             	mov    0x14(%ebp),%eax
  80190e:	8b 00                	mov    (%eax),%eax
  801910:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801917:	8b 45 10             	mov    0x10(%ebp),%eax
  80191a:	01 d0                	add    %edx,%eax
  80191c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801922:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <nextFitAlgo>:
struct UserHeap {
	uint32 first;
	uint32 size;
} uHeapArr[(USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE];

uint32* nextFitAlgo(unsigned int size) {
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
  80192c:	83 ec 28             	sub    $0x28,%esp
	uint32 newAdd = startAdd, newSize = 0, tmp;
  80192f:	a1 04 30 80 00       	mov    0x803004,%eax
  801934:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801937:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	bool flag = 0, found = 0;
  80193e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801945:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;
  80194c:	c7 45 e0 00 00 02 00 	movl   $0x20000,-0x20(%ebp)

	while(spacePages != 0) {
  801953:	e9 f9 00 00 00       	jmp    801a51 <nextFitAlgo+0x128>
		if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && flag) {
  801958:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80195b:	05 00 00 00 80       	add    $0x80000000,%eax
  801960:	c1 e8 0c             	shr    $0xc,%eax
  801963:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80196a:	85 c0                	test   %eax,%eax
  80196c:	75 1c                	jne    80198a <nextFitAlgo+0x61>
  80196e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801972:	74 16                	je     80198a <nextFitAlgo+0x61>
			newSize += PAGE_SIZE;
  801974:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  80197b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  801982:	ff 4d e0             	decl   -0x20(%ebp)
  801985:	e9 90 00 00 00       	jmp    801a1a <nextFitAlgo+0xf1>
		} else if(checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE]==0 && !flag) {
  80198a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198d:	05 00 00 00 80       	add    $0x80000000,%eax
  801992:	c1 e8 0c             	shr    $0xc,%eax
  801995:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80199c:	85 c0                	test   %eax,%eax
  80199e:	75 26                	jne    8019c6 <nextFitAlgo+0x9d>
  8019a0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8019a4:	75 20                	jne    8019c6 <nextFitAlgo+0x9d>
			flag = 1;
  8019a6:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			tmp = newAdd;
  8019ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
			newSize += PAGE_SIZE;
  8019b3:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			newAdd += PAGE_SIZE;
  8019ba:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
			spacePages--;
  8019c1:	ff 4d e0             	decl   -0x20(%ebp)
  8019c4:	eb 54                	jmp    801a1a <nextFitAlgo+0xf1>
		} else {
			if(newSize >= size) {
  8019c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019c9:	3b 45 08             	cmp    0x8(%ebp),%eax
  8019cc:	72 11                	jb     8019df <nextFitAlgo+0xb6>
				startAdd = tmp;
  8019ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019d1:	a3 04 30 80 00       	mov    %eax,0x803004
				found = 1;
  8019d6:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
				break;
  8019dd:	eb 7c                	jmp    801a5b <nextFitAlgo+0x132>
			}

			spacePages -= checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE];
  8019df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019e2:	05 00 00 00 80       	add    $0x80000000,%eax
  8019e7:	c1 e8 0c             	shr    $0xc,%eax
  8019ea:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019f1:	29 45 e0             	sub    %eax,-0x20(%ebp)
			newAdd += (checkList[(newAdd-USER_HEAP_START)/PAGE_SIZE] *PAGE_SIZE);
  8019f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019f7:	05 00 00 00 80       	add    $0x80000000,%eax
  8019fc:	c1 e8 0c             	shr    $0xc,%eax
  8019ff:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  801a06:	c1 e0 0c             	shl    $0xc,%eax
  801a09:	01 45 f4             	add    %eax,-0xc(%ebp)
			flag = newSize = 0;
  801a0c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a13:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		}

		if(newSize >= size) {
  801a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a1d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a20:	72 11                	jb     801a33 <nextFitAlgo+0x10a>
			startAdd = tmp;
  801a22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a25:	a3 04 30 80 00       	mov    %eax,0x803004
			found = 1;
  801a2a:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
			break;
  801a31:	eb 28                	jmp    801a5b <nextFitAlgo+0x132>
		}

		if(newAdd >= USER_HEAP_MAX) {
  801a33:	81 7d f4 ff ff ff 9f 	cmpl   $0x9fffffff,-0xc(%ebp)
  801a3a:	76 15                	jbe    801a51 <nextFitAlgo+0x128>
			flag = newSize = 0;
  801a3c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a43:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
			newAdd = USER_HEAP_START;
  801a4a:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
	uint32 newAdd = startAdd, newSize = 0, tmp;
	bool flag = 0, found = 0;

	uint32 spacePages = (USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE;

	while(spacePages != 0) {
  801a51:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801a55:	0f 85 fd fe ff ff    	jne    801958 <nextFitAlgo+0x2f>
			flag = newSize = 0;
			newAdd = USER_HEAP_START;
		}
	}

	if(!found) {
  801a5b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a5f:	75 1a                	jne    801a7b <nextFitAlgo+0x152>
		if(newSize < size) return NULL;
  801a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a64:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a67:	73 0a                	jae    801a73 <nextFitAlgo+0x14a>
  801a69:	b8 00 00 00 00       	mov    $0x0,%eax
  801a6e:	e9 99 00 00 00       	jmp    801b0c <nextFitAlgo+0x1e3>
		else startAdd = tmp;
  801a73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a76:	a3 04 30 80 00       	mov    %eax,0x803004
	}

	uint32 returnHolder = startAdd;
  801a7b:	a1 04 30 80 00       	mov    0x803004,%eax
  801a80:	89 45 dc             	mov    %eax,-0x24(%ebp)

	newAdd = (startAdd-USER_HEAP_START)/PAGE_SIZE;
  801a83:	a1 04 30 80 00       	mov    0x803004,%eax
  801a88:	05 00 00 00 80       	add    $0x80000000,%eax
  801a8d:	c1 e8 0c             	shr    $0xc,%eax
  801a90:	89 45 f4             	mov    %eax,-0xc(%ebp)
	checkList[newAdd] = size/PAGE_SIZE;
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	c1 e8 0c             	shr    $0xc,%eax
  801a99:	89 c2                	mov    %eax,%edx
  801a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a9e:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
	sys_allocateMem(startAdd, size);
  801aa5:	a1 04 30 80 00       	mov    0x803004,%eax
  801aaa:	83 ec 08             	sub    $0x8,%esp
  801aad:	ff 75 08             	pushl  0x8(%ebp)
  801ab0:	50                   	push   %eax
  801ab1:	e8 82 03 00 00       	call   801e38 <sys_allocateMem>
  801ab6:	83 c4 10             	add    $0x10,%esp

	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].first = startAdd;
  801ab9:	a1 04 30 80 00       	mov    0x803004,%eax
  801abe:	05 00 00 00 80       	add    $0x80000000,%eax
  801ac3:	c1 e8 0c             	shr    $0xc,%eax
  801ac6:	89 c2                	mov    %eax,%edx
  801ac8:	a1 04 30 80 00       	mov    0x803004,%eax
  801acd:	89 04 d5 60 30 88 00 	mov    %eax,0x883060(,%edx,8)
	uHeapArr[(startAdd-USER_HEAP_START)/PAGE_SIZE].size = size;
  801ad4:	a1 04 30 80 00       	mov    0x803004,%eax
  801ad9:	05 00 00 00 80       	add    $0x80000000,%eax
  801ade:	c1 e8 0c             	shr    $0xc,%eax
  801ae1:	89 c2                	mov    %eax,%edx
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	89 04 d5 64 30 88 00 	mov    %eax,0x883064(,%edx,8)

	if(startAdd+size >= USER_HEAP_MAX) startAdd = USER_HEAP_START;
  801aed:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	01 d0                	add    %edx,%eax
  801af8:	3d ff ff ff 9f       	cmp    $0x9fffffff,%eax
  801afd:	76 0a                	jbe    801b09 <nextFitAlgo+0x1e0>
  801aff:	c7 05 04 30 80 00 00 	movl   $0x80000000,0x803004
  801b06:	00 00 80 

	return (void*)returnHolder;
  801b09:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  801b0c:	c9                   	leave  
  801b0d:	c3                   	ret    

00801b0e <malloc>:

void* malloc(uint32 size) {
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
  801b11:	83 ec 18             	sub    $0x18,%esp

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	size = ROUNDUP(size, PAGE_SIZE);
  801b14:	c7 45 f4 00 10 00 00 	movl   $0x1000,-0xc(%ebp)
  801b1b:	8b 55 08             	mov    0x8(%ebp),%edx
  801b1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b21:	01 d0                	add    %edx,%eax
  801b23:	48                   	dec    %eax
  801b24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b2a:	ba 00 00 00 00       	mov    $0x0,%edx
  801b2f:	f7 75 f4             	divl   -0xc(%ebp)
  801b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b35:	29 d0                	sub    %edx,%eax
  801b37:	89 45 08             	mov    %eax,0x8(%ebp)

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801b3a:	e8 c3 06 00 00       	call   802202 <sys_isUHeapPlacementStrategyNEXTFIT>
  801b3f:	85 c0                	test   %eax,%eax
  801b41:	74 10                	je     801b53 <malloc+0x45>
		return nextFitAlgo(size);
  801b43:	83 ec 0c             	sub    $0xc,%esp
  801b46:	ff 75 08             	pushl  0x8(%ebp)
  801b49:	e8 db fd ff ff       	call   801929 <nextFitAlgo>
  801b4e:	83 c4 10             	add    $0x10,%esp
  801b51:	eb 0a                	jmp    801b5d <malloc+0x4f>
	}

	if(sys_isUHeapPlacementStrategyBESTFIT()) {
  801b53:	e8 79 06 00 00       	call   8021d1 <sys_isUHeapPlacementStrategyBESTFIT>
		// --->>> BONUS -->> BEST FIT -> HERE
	}

	return NULL;
  801b58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b5d:	c9                   	leave  
  801b5e:	c3                   	ret    

00801b5f <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b5f:	55                   	push   %ebp
  801b60:	89 e5                	mov    %esp,%ebp
  801b62:	83 ec 18             	sub    $0x18,%esp
  801b65:	8b 45 10             	mov    0x10(%ebp),%eax
  801b68:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801b6b:	83 ec 04             	sub    $0x4,%esp
  801b6e:	68 c4 2b 80 00       	push   $0x802bc4
  801b73:	6a 7e                	push   $0x7e
  801b75:	68 e3 2b 80 00       	push   $0x802be3
  801b7a:	e8 66 eb ff ff       	call   8006e5 <_panic>

00801b7f <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
  801b82:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801b85:	83 ec 04             	sub    $0x4,%esp
  801b88:	68 ef 2b 80 00       	push   $0x802bef
  801b8d:	68 84 00 00 00       	push   $0x84
  801b92:	68 e3 2b 80 00       	push   $0x802be3
  801b97:	e8 49 eb ff ff       	call   8006e5 <_panic>

00801b9c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
  801b9f:	83 ec 18             	sub    $0x18,%esp
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801ba2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ba9:	eb 61                	jmp    801c0c <free+0x70>
		if (uHeapArr[i].first == (uint32)virtual_address) {
  801bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bae:	8b 14 c5 60 30 88 00 	mov    0x883060(,%eax,8),%edx
  801bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb8:	39 c2                	cmp    %eax,%edx
  801bba:	75 4d                	jne    801c09 <free+0x6d>
			x = ((uint32)virtual_address-USER_HEAP_START)/PAGE_SIZE;
  801bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbf:	05 00 00 00 80       	add    $0x80000000,%eax
  801bc4:	c1 e8 0c             	shr    $0xc,%eax
  801bc7:	89 45 ec             	mov    %eax,-0x14(%ebp)
			size = uHeapArr[i].size;
  801bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bcd:	8b 04 c5 64 30 88 00 	mov    0x883064(,%eax,8),%eax
  801bd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
  801bd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bda:	c7 04 85 40 30 80 00 	movl   $0x0,0x803040(,%eax,4)
  801be1:	00 00 00 00 
  801be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801be8:	c7 04 c5 64 30 88 00 	movl   $0x0,0x883064(,%eax,8)
  801bef:	00 00 00 00 
  801bf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bf6:	8b 14 c5 64 30 88 00 	mov    0x883064(,%eax,8),%edx
  801bfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c00:	89 14 c5 60 30 88 00 	mov    %edx,0x883060(,%eax,8)
			break;
  801c07:	eb 0d                	jmp    801c16 <free+0x7a>
	//you need to call sys_freeMem()
	//refer to the project presentation and documentation for details

	uint32 x, size;

	for(int i=0; i < ((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801c09:	ff 45 f0             	incl   -0x10(%ebp)
  801c0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c0f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c14:	76 95                	jbe    801bab <free+0xf>
			uHeapArr[i].first = uHeapArr[i].size = checkList[x] = 0;
			break;
		}
	}

	sys_freeMem((uint32)virtual_address, size);
  801c16:	8b 45 08             	mov    0x8(%ebp),%eax
  801c19:	83 ec 08             	sub    $0x8,%esp
  801c1c:	ff 75 f4             	pushl  -0xc(%ebp)
  801c1f:	50                   	push   %eax
  801c20:	e8 f7 01 00 00       	call   801e1c <sys_freeMem>
  801c25:	83 c4 10             	add    $0x10,%esp
}
  801c28:	90                   	nop
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <sfree>:


void sfree(void* virtual_address)
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
  801c2e:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801c31:	83 ec 04             	sub    $0x4,%esp
  801c34:	68 0b 2c 80 00       	push   $0x802c0b
  801c39:	68 ac 00 00 00       	push   $0xac
  801c3e:	68 e3 2b 80 00       	push   $0x802be3
  801c43:	e8 9d ea ff ff       	call   8006e5 <_panic>

00801c48 <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
  801c4b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c4e:	83 ec 04             	sub    $0x4,%esp
  801c51:	68 28 2c 80 00       	push   $0x802c28
  801c56:	68 c4 00 00 00       	push   $0xc4
  801c5b:	68 e3 2b 80 00       	push   $0x802be3
  801c60:	e8 80 ea ff ff       	call   8006e5 <_panic>

00801c65 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
  801c68:	57                   	push   %edi
  801c69:	56                   	push   %esi
  801c6a:	53                   	push   %ebx
  801c6b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c74:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c77:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c7a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c7d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c80:	cd 30                	int    $0x30
  801c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c88:	83 c4 10             	add    $0x10,%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5f                   	pop    %edi
  801c8e:	5d                   	pop    %ebp
  801c8f:	c3                   	ret    

00801c90 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
  801c93:	83 ec 04             	sub    $0x4,%esp
  801c96:	8b 45 10             	mov    0x10(%ebp),%eax
  801c99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c9c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	52                   	push   %edx
  801ca8:	ff 75 0c             	pushl  0xc(%ebp)
  801cab:	50                   	push   %eax
  801cac:	6a 00                	push   $0x0
  801cae:	e8 b2 ff ff ff       	call   801c65 <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
}
  801cb6:	90                   	nop
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_cgetc>:

int
sys_cgetc(void)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 01                	push   $0x1
  801cc8:	e8 98 ff ff ff       	call   801c65 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	50                   	push   %eax
  801ce1:	6a 05                	push   $0x5
  801ce3:	e8 7d ff ff ff       	call   801c65 <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	c9                   	leave  
  801cec:	c3                   	ret    

00801ced <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ced:	55                   	push   %ebp
  801cee:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 02                	push   $0x2
  801cfc:	e8 64 ff ff ff       	call   801c65 <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 03                	push   $0x3
  801d15:	e8 4b ff ff ff       	call   801c65 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	c9                   	leave  
  801d1e:	c3                   	ret    

00801d1f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 04                	push   $0x4
  801d2e:	e8 32 ff ff ff       	call   801c65 <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
}
  801d36:	c9                   	leave  
  801d37:	c3                   	ret    

00801d38 <sys_env_exit>:


void sys_env_exit(void)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 06                	push   $0x6
  801d47:	e8 19 ff ff ff       	call   801c65 <syscall>
  801d4c:	83 c4 18             	add    $0x18,%esp
}
  801d4f:	90                   	nop
  801d50:	c9                   	leave  
  801d51:	c3                   	ret    

00801d52 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	52                   	push   %edx
  801d62:	50                   	push   %eax
  801d63:	6a 07                	push   $0x7
  801d65:	e8 fb fe ff ff       	call   801c65 <syscall>
  801d6a:	83 c4 18             	add    $0x18,%esp
}
  801d6d:	c9                   	leave  
  801d6e:	c3                   	ret    

00801d6f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	56                   	push   %esi
  801d73:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d74:	8b 75 18             	mov    0x18(%ebp),%esi
  801d77:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d7a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d80:	8b 45 08             	mov    0x8(%ebp),%eax
  801d83:	56                   	push   %esi
  801d84:	53                   	push   %ebx
  801d85:	51                   	push   %ecx
  801d86:	52                   	push   %edx
  801d87:	50                   	push   %eax
  801d88:	6a 08                	push   $0x8
  801d8a:	e8 d6 fe ff ff       	call   801c65 <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
}
  801d92:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d95:	5b                   	pop    %ebx
  801d96:	5e                   	pop    %esi
  801d97:	5d                   	pop    %ebp
  801d98:	c3                   	ret    

00801d99 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	52                   	push   %edx
  801da9:	50                   	push   %eax
  801daa:	6a 09                	push   $0x9
  801dac:	e8 b4 fe ff ff       	call   801c65 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	ff 75 0c             	pushl  0xc(%ebp)
  801dc2:	ff 75 08             	pushl  0x8(%ebp)
  801dc5:	6a 0a                	push   $0xa
  801dc7:	e8 99 fe ff ff       	call   801c65 <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 0b                	push   $0xb
  801de0:	e8 80 fe ff ff       	call   801c65 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 0c                	push   $0xc
  801df9:	e8 67 fe ff ff       	call   801c65 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 0d                	push   $0xd
  801e12:	e8 4e fe ff ff       	call   801c65 <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	ff 75 0c             	pushl  0xc(%ebp)
  801e28:	ff 75 08             	pushl  0x8(%ebp)
  801e2b:	6a 11                	push   $0x11
  801e2d:	e8 33 fe ff ff       	call   801c65 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
	return;
  801e35:	90                   	nop
}
  801e36:	c9                   	leave  
  801e37:	c3                   	ret    

00801e38 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e38:	55                   	push   %ebp
  801e39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	ff 75 0c             	pushl  0xc(%ebp)
  801e44:	ff 75 08             	pushl  0x8(%ebp)
  801e47:	6a 12                	push   $0x12
  801e49:	e8 17 fe ff ff       	call   801c65 <syscall>
  801e4e:	83 c4 18             	add    $0x18,%esp
	return ;
  801e51:	90                   	nop
}
  801e52:	c9                   	leave  
  801e53:	c3                   	ret    

00801e54 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e54:	55                   	push   %ebp
  801e55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 0e                	push   $0xe
  801e63:	e8 fd fd ff ff       	call   801c65 <syscall>
  801e68:	83 c4 18             	add    $0x18,%esp
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	ff 75 08             	pushl  0x8(%ebp)
  801e7b:	6a 0f                	push   $0xf
  801e7d:	e8 e3 fd ff ff       	call   801c65 <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 10                	push   $0x10
  801e96:	e8 ca fd ff ff       	call   801c65 <syscall>
  801e9b:	83 c4 18             	add    $0x18,%esp
}
  801e9e:	90                   	nop
  801e9f:	c9                   	leave  
  801ea0:	c3                   	ret    

00801ea1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 14                	push   $0x14
  801eb0:	e8 b0 fd ff ff       	call   801c65 <syscall>
  801eb5:	83 c4 18             	add    $0x18,%esp
}
  801eb8:	90                   	nop
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 15                	push   $0x15
  801eca:	e8 96 fd ff ff       	call   801c65 <syscall>
  801ecf:	83 c4 18             	add    $0x18,%esp
}
  801ed2:	90                   	nop
  801ed3:	c9                   	leave  
  801ed4:	c3                   	ret    

00801ed5 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ed5:	55                   	push   %ebp
  801ed6:	89 e5                	mov    %esp,%ebp
  801ed8:	83 ec 04             	sub    $0x4,%esp
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801ee1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	50                   	push   %eax
  801eee:	6a 16                	push   $0x16
  801ef0:	e8 70 fd ff ff       	call   801c65 <syscall>
  801ef5:	83 c4 18             	add    $0x18,%esp
}
  801ef8:	90                   	nop
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 17                	push   $0x17
  801f0a:	e8 56 fd ff ff       	call   801c65 <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
}
  801f12:	90                   	nop
  801f13:	c9                   	leave  
  801f14:	c3                   	ret    

00801f15 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f15:	55                   	push   %ebp
  801f16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f18:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	ff 75 0c             	pushl  0xc(%ebp)
  801f24:	50                   	push   %eax
  801f25:	6a 18                	push   $0x18
  801f27:	e8 39 fd ff ff       	call   801c65 <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f37:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	52                   	push   %edx
  801f41:	50                   	push   %eax
  801f42:	6a 1b                	push   $0x1b
  801f44:	e8 1c fd ff ff       	call   801c65 <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f54:	8b 45 08             	mov    0x8(%ebp),%eax
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	52                   	push   %edx
  801f5e:	50                   	push   %eax
  801f5f:	6a 19                	push   $0x19
  801f61:	e8 ff fc ff ff       	call   801c65 <syscall>
  801f66:	83 c4 18             	add    $0x18,%esp
}
  801f69:	90                   	nop
  801f6a:	c9                   	leave  
  801f6b:	c3                   	ret    

00801f6c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f6c:	55                   	push   %ebp
  801f6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f72:	8b 45 08             	mov    0x8(%ebp),%eax
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	52                   	push   %edx
  801f7c:	50                   	push   %eax
  801f7d:	6a 1a                	push   $0x1a
  801f7f:	e8 e1 fc ff ff       	call   801c65 <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
}
  801f87:	90                   	nop
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 04             	sub    $0x4,%esp
  801f90:	8b 45 10             	mov    0x10(%ebp),%eax
  801f93:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f96:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f99:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa0:	6a 00                	push   $0x0
  801fa2:	51                   	push   %ecx
  801fa3:	52                   	push   %edx
  801fa4:	ff 75 0c             	pushl  0xc(%ebp)
  801fa7:	50                   	push   %eax
  801fa8:	6a 1c                	push   $0x1c
  801faa:	e8 b6 fc ff ff       	call   801c65 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
}
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801fb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fba:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	52                   	push   %edx
  801fc4:	50                   	push   %eax
  801fc5:	6a 1d                	push   $0x1d
  801fc7:	e8 99 fc ff ff       	call   801c65 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fd4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fda:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	51                   	push   %ecx
  801fe2:	52                   	push   %edx
  801fe3:	50                   	push   %eax
  801fe4:	6a 1e                	push   $0x1e
  801fe6:	e8 7a fc ff ff       	call   801c65 <syscall>
  801feb:	83 c4 18             	add    $0x18,%esp
}
  801fee:	c9                   	leave  
  801fef:	c3                   	ret    

00801ff0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ff0:	55                   	push   %ebp
  801ff1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	52                   	push   %edx
  802000:	50                   	push   %eax
  802001:	6a 1f                	push   $0x1f
  802003:	e8 5d fc ff ff       	call   801c65 <syscall>
  802008:	83 c4 18             	add    $0x18,%esp
}
  80200b:	c9                   	leave  
  80200c:	c3                   	ret    

0080200d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80200d:	55                   	push   %ebp
  80200e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 20                	push   $0x20
  80201c:	e8 44 fc ff ff       	call   801c65 <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
}
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802029:	8b 45 08             	mov    0x8(%ebp),%eax
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	ff 75 10             	pushl  0x10(%ebp)
  802033:	ff 75 0c             	pushl  0xc(%ebp)
  802036:	50                   	push   %eax
  802037:	6a 21                	push   $0x21
  802039:	e8 27 fc ff ff       	call   801c65 <syscall>
  80203e:	83 c4 18             	add    $0x18,%esp
}
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802046:	8b 45 08             	mov    0x8(%ebp),%eax
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	50                   	push   %eax
  802052:	6a 22                	push   $0x22
  802054:	e8 0c fc ff ff       	call   801c65 <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
}
  80205c:	90                   	nop
  80205d:	c9                   	leave  
  80205e:	c3                   	ret    

0080205f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80205f:	55                   	push   %ebp
  802060:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802062:	8b 45 08             	mov    0x8(%ebp),%eax
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	50                   	push   %eax
  80206e:	6a 23                	push   $0x23
  802070:	e8 f0 fb ff ff       	call   801c65 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
}
  802078:	90                   	nop
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
  80207e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802081:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802084:	8d 50 04             	lea    0x4(%eax),%edx
  802087:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	52                   	push   %edx
  802091:	50                   	push   %eax
  802092:	6a 24                	push   $0x24
  802094:	e8 cc fb ff ff       	call   801c65 <syscall>
  802099:	83 c4 18             	add    $0x18,%esp
	return result;
  80209c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80209f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020a5:	89 01                	mov    %eax,(%ecx)
  8020a7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ad:	c9                   	leave  
  8020ae:	c2 04 00             	ret    $0x4

008020b1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	ff 75 10             	pushl  0x10(%ebp)
  8020bb:	ff 75 0c             	pushl  0xc(%ebp)
  8020be:	ff 75 08             	pushl  0x8(%ebp)
  8020c1:	6a 13                	push   $0x13
  8020c3:	e8 9d fb ff ff       	call   801c65 <syscall>
  8020c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020cb:	90                   	nop
}
  8020cc:	c9                   	leave  
  8020cd:	c3                   	ret    

008020ce <sys_rcr2>:
uint32 sys_rcr2()
{
  8020ce:	55                   	push   %ebp
  8020cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 25                	push   $0x25
  8020dd:	e8 83 fb ff ff       	call   801c65 <syscall>
  8020e2:	83 c4 18             	add    $0x18,%esp
}
  8020e5:	c9                   	leave  
  8020e6:	c3                   	ret    

008020e7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020e7:	55                   	push   %ebp
  8020e8:	89 e5                	mov    %esp,%ebp
  8020ea:	83 ec 04             	sub    $0x4,%esp
  8020ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020f3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	50                   	push   %eax
  802100:	6a 26                	push   $0x26
  802102:	e8 5e fb ff ff       	call   801c65 <syscall>
  802107:	83 c4 18             	add    $0x18,%esp
	return ;
  80210a:	90                   	nop
}
  80210b:	c9                   	leave  
  80210c:	c3                   	ret    

0080210d <rsttst>:
void rsttst()
{
  80210d:	55                   	push   %ebp
  80210e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 28                	push   $0x28
  80211c:	e8 44 fb ff ff       	call   801c65 <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
	return ;
  802124:	90                   	nop
}
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
  80212a:	83 ec 04             	sub    $0x4,%esp
  80212d:	8b 45 14             	mov    0x14(%ebp),%eax
  802130:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802133:	8b 55 18             	mov    0x18(%ebp),%edx
  802136:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80213a:	52                   	push   %edx
  80213b:	50                   	push   %eax
  80213c:	ff 75 10             	pushl  0x10(%ebp)
  80213f:	ff 75 0c             	pushl  0xc(%ebp)
  802142:	ff 75 08             	pushl  0x8(%ebp)
  802145:	6a 27                	push   $0x27
  802147:	e8 19 fb ff ff       	call   801c65 <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
	return ;
  80214f:	90                   	nop
}
  802150:	c9                   	leave  
  802151:	c3                   	ret    

00802152 <chktst>:
void chktst(uint32 n)
{
  802152:	55                   	push   %ebp
  802153:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	ff 75 08             	pushl  0x8(%ebp)
  802160:	6a 29                	push   $0x29
  802162:	e8 fe fa ff ff       	call   801c65 <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
	return ;
  80216a:	90                   	nop
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <inctst>:

void inctst()
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 2a                	push   $0x2a
  80217c:	e8 e4 fa ff ff       	call   801c65 <syscall>
  802181:	83 c4 18             	add    $0x18,%esp
	return ;
  802184:	90                   	nop
}
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <gettst>:
uint32 gettst()
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	6a 00                	push   $0x0
  802194:	6a 2b                	push   $0x2b
  802196:	e8 ca fa ff ff       	call   801c65 <syscall>
  80219b:	83 c4 18             	add    $0x18,%esp
}
  80219e:	c9                   	leave  
  80219f:	c3                   	ret    

008021a0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
  8021a3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 2c                	push   $0x2c
  8021b2:	e8 ae fa ff ff       	call   801c65 <syscall>
  8021b7:	83 c4 18             	add    $0x18,%esp
  8021ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021bd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8021c1:	75 07                	jne    8021ca <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8021c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c8:	eb 05                	jmp    8021cf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8021ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021cf:	c9                   	leave  
  8021d0:	c3                   	ret    

008021d1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021d1:	55                   	push   %ebp
  8021d2:	89 e5                	mov    %esp,%ebp
  8021d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 2c                	push   $0x2c
  8021e3:	e8 7d fa ff ff       	call   801c65 <syscall>
  8021e8:	83 c4 18             	add    $0x18,%esp
  8021eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021ee:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021f2:	75 07                	jne    8021fb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f9:	eb 05                	jmp    802200 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802200:	c9                   	leave  
  802201:	c3                   	ret    

00802202 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802202:	55                   	push   %ebp
  802203:	89 e5                	mov    %esp,%ebp
  802205:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 2c                	push   $0x2c
  802214:	e8 4c fa ff ff       	call   801c65 <syscall>
  802219:	83 c4 18             	add    $0x18,%esp
  80221c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80221f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802223:	75 07                	jne    80222c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802225:	b8 01 00 00 00       	mov    $0x1,%eax
  80222a:	eb 05                	jmp    802231 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80222c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802231:	c9                   	leave  
  802232:	c3                   	ret    

00802233 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802233:	55                   	push   %ebp
  802234:	89 e5                	mov    %esp,%ebp
  802236:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802239:	6a 00                	push   $0x0
  80223b:	6a 00                	push   $0x0
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 00                	push   $0x0
  802243:	6a 2c                	push   $0x2c
  802245:	e8 1b fa ff ff       	call   801c65 <syscall>
  80224a:	83 c4 18             	add    $0x18,%esp
  80224d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802250:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802254:	75 07                	jne    80225d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802256:	b8 01 00 00 00       	mov    $0x1,%eax
  80225b:	eb 05                	jmp    802262 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80225d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802262:	c9                   	leave  
  802263:	c3                   	ret    

00802264 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802264:	55                   	push   %ebp
  802265:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802267:	6a 00                	push   $0x0
  802269:	6a 00                	push   $0x0
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	ff 75 08             	pushl  0x8(%ebp)
  802272:	6a 2d                	push   $0x2d
  802274:	e8 ec f9 ff ff       	call   801c65 <syscall>
  802279:	83 c4 18             	add    $0x18,%esp
	return ;
  80227c:	90                   	nop
}
  80227d:	c9                   	leave  
  80227e:	c3                   	ret    
  80227f:	90                   	nop

00802280 <__udivdi3>:
  802280:	55                   	push   %ebp
  802281:	57                   	push   %edi
  802282:	56                   	push   %esi
  802283:	53                   	push   %ebx
  802284:	83 ec 1c             	sub    $0x1c,%esp
  802287:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80228b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80228f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802293:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802297:	89 ca                	mov    %ecx,%edx
  802299:	89 f8                	mov    %edi,%eax
  80229b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80229f:	85 f6                	test   %esi,%esi
  8022a1:	75 2d                	jne    8022d0 <__udivdi3+0x50>
  8022a3:	39 cf                	cmp    %ecx,%edi
  8022a5:	77 65                	ja     80230c <__udivdi3+0x8c>
  8022a7:	89 fd                	mov    %edi,%ebp
  8022a9:	85 ff                	test   %edi,%edi
  8022ab:	75 0b                	jne    8022b8 <__udivdi3+0x38>
  8022ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b2:	31 d2                	xor    %edx,%edx
  8022b4:	f7 f7                	div    %edi
  8022b6:	89 c5                	mov    %eax,%ebp
  8022b8:	31 d2                	xor    %edx,%edx
  8022ba:	89 c8                	mov    %ecx,%eax
  8022bc:	f7 f5                	div    %ebp
  8022be:	89 c1                	mov    %eax,%ecx
  8022c0:	89 d8                	mov    %ebx,%eax
  8022c2:	f7 f5                	div    %ebp
  8022c4:	89 cf                	mov    %ecx,%edi
  8022c6:	89 fa                	mov    %edi,%edx
  8022c8:	83 c4 1c             	add    $0x1c,%esp
  8022cb:	5b                   	pop    %ebx
  8022cc:	5e                   	pop    %esi
  8022cd:	5f                   	pop    %edi
  8022ce:	5d                   	pop    %ebp
  8022cf:	c3                   	ret    
  8022d0:	39 ce                	cmp    %ecx,%esi
  8022d2:	77 28                	ja     8022fc <__udivdi3+0x7c>
  8022d4:	0f bd fe             	bsr    %esi,%edi
  8022d7:	83 f7 1f             	xor    $0x1f,%edi
  8022da:	75 40                	jne    80231c <__udivdi3+0x9c>
  8022dc:	39 ce                	cmp    %ecx,%esi
  8022de:	72 0a                	jb     8022ea <__udivdi3+0x6a>
  8022e0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022e4:	0f 87 9e 00 00 00    	ja     802388 <__udivdi3+0x108>
  8022ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ef:	89 fa                	mov    %edi,%edx
  8022f1:	83 c4 1c             	add    $0x1c,%esp
  8022f4:	5b                   	pop    %ebx
  8022f5:	5e                   	pop    %esi
  8022f6:	5f                   	pop    %edi
  8022f7:	5d                   	pop    %ebp
  8022f8:	c3                   	ret    
  8022f9:	8d 76 00             	lea    0x0(%esi),%esi
  8022fc:	31 ff                	xor    %edi,%edi
  8022fe:	31 c0                	xor    %eax,%eax
  802300:	89 fa                	mov    %edi,%edx
  802302:	83 c4 1c             	add    $0x1c,%esp
  802305:	5b                   	pop    %ebx
  802306:	5e                   	pop    %esi
  802307:	5f                   	pop    %edi
  802308:	5d                   	pop    %ebp
  802309:	c3                   	ret    
  80230a:	66 90                	xchg   %ax,%ax
  80230c:	89 d8                	mov    %ebx,%eax
  80230e:	f7 f7                	div    %edi
  802310:	31 ff                	xor    %edi,%edi
  802312:	89 fa                	mov    %edi,%edx
  802314:	83 c4 1c             	add    $0x1c,%esp
  802317:	5b                   	pop    %ebx
  802318:	5e                   	pop    %esi
  802319:	5f                   	pop    %edi
  80231a:	5d                   	pop    %ebp
  80231b:	c3                   	ret    
  80231c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802321:	89 eb                	mov    %ebp,%ebx
  802323:	29 fb                	sub    %edi,%ebx
  802325:	89 f9                	mov    %edi,%ecx
  802327:	d3 e6                	shl    %cl,%esi
  802329:	89 c5                	mov    %eax,%ebp
  80232b:	88 d9                	mov    %bl,%cl
  80232d:	d3 ed                	shr    %cl,%ebp
  80232f:	89 e9                	mov    %ebp,%ecx
  802331:	09 f1                	or     %esi,%ecx
  802333:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802337:	89 f9                	mov    %edi,%ecx
  802339:	d3 e0                	shl    %cl,%eax
  80233b:	89 c5                	mov    %eax,%ebp
  80233d:	89 d6                	mov    %edx,%esi
  80233f:	88 d9                	mov    %bl,%cl
  802341:	d3 ee                	shr    %cl,%esi
  802343:	89 f9                	mov    %edi,%ecx
  802345:	d3 e2                	shl    %cl,%edx
  802347:	8b 44 24 08          	mov    0x8(%esp),%eax
  80234b:	88 d9                	mov    %bl,%cl
  80234d:	d3 e8                	shr    %cl,%eax
  80234f:	09 c2                	or     %eax,%edx
  802351:	89 d0                	mov    %edx,%eax
  802353:	89 f2                	mov    %esi,%edx
  802355:	f7 74 24 0c          	divl   0xc(%esp)
  802359:	89 d6                	mov    %edx,%esi
  80235b:	89 c3                	mov    %eax,%ebx
  80235d:	f7 e5                	mul    %ebp
  80235f:	39 d6                	cmp    %edx,%esi
  802361:	72 19                	jb     80237c <__udivdi3+0xfc>
  802363:	74 0b                	je     802370 <__udivdi3+0xf0>
  802365:	89 d8                	mov    %ebx,%eax
  802367:	31 ff                	xor    %edi,%edi
  802369:	e9 58 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  80236e:	66 90                	xchg   %ax,%ax
  802370:	8b 54 24 08          	mov    0x8(%esp),%edx
  802374:	89 f9                	mov    %edi,%ecx
  802376:	d3 e2                	shl    %cl,%edx
  802378:	39 c2                	cmp    %eax,%edx
  80237a:	73 e9                	jae    802365 <__udivdi3+0xe5>
  80237c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80237f:	31 ff                	xor    %edi,%edi
  802381:	e9 40 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  802386:	66 90                	xchg   %ax,%ax
  802388:	31 c0                	xor    %eax,%eax
  80238a:	e9 37 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  80238f:	90                   	nop

00802390 <__umoddi3>:
  802390:	55                   	push   %ebp
  802391:	57                   	push   %edi
  802392:	56                   	push   %esi
  802393:	53                   	push   %ebx
  802394:	83 ec 1c             	sub    $0x1c,%esp
  802397:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80239b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80239f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023a3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023af:	89 f3                	mov    %esi,%ebx
  8023b1:	89 fa                	mov    %edi,%edx
  8023b3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023b7:	89 34 24             	mov    %esi,(%esp)
  8023ba:	85 c0                	test   %eax,%eax
  8023bc:	75 1a                	jne    8023d8 <__umoddi3+0x48>
  8023be:	39 f7                	cmp    %esi,%edi
  8023c0:	0f 86 a2 00 00 00    	jbe    802468 <__umoddi3+0xd8>
  8023c6:	89 c8                	mov    %ecx,%eax
  8023c8:	89 f2                	mov    %esi,%edx
  8023ca:	f7 f7                	div    %edi
  8023cc:	89 d0                	mov    %edx,%eax
  8023ce:	31 d2                	xor    %edx,%edx
  8023d0:	83 c4 1c             	add    $0x1c,%esp
  8023d3:	5b                   	pop    %ebx
  8023d4:	5e                   	pop    %esi
  8023d5:	5f                   	pop    %edi
  8023d6:	5d                   	pop    %ebp
  8023d7:	c3                   	ret    
  8023d8:	39 f0                	cmp    %esi,%eax
  8023da:	0f 87 ac 00 00 00    	ja     80248c <__umoddi3+0xfc>
  8023e0:	0f bd e8             	bsr    %eax,%ebp
  8023e3:	83 f5 1f             	xor    $0x1f,%ebp
  8023e6:	0f 84 ac 00 00 00    	je     802498 <__umoddi3+0x108>
  8023ec:	bf 20 00 00 00       	mov    $0x20,%edi
  8023f1:	29 ef                	sub    %ebp,%edi
  8023f3:	89 fe                	mov    %edi,%esi
  8023f5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023f9:	89 e9                	mov    %ebp,%ecx
  8023fb:	d3 e0                	shl    %cl,%eax
  8023fd:	89 d7                	mov    %edx,%edi
  8023ff:	89 f1                	mov    %esi,%ecx
  802401:	d3 ef                	shr    %cl,%edi
  802403:	09 c7                	or     %eax,%edi
  802405:	89 e9                	mov    %ebp,%ecx
  802407:	d3 e2                	shl    %cl,%edx
  802409:	89 14 24             	mov    %edx,(%esp)
  80240c:	89 d8                	mov    %ebx,%eax
  80240e:	d3 e0                	shl    %cl,%eax
  802410:	89 c2                	mov    %eax,%edx
  802412:	8b 44 24 08          	mov    0x8(%esp),%eax
  802416:	d3 e0                	shl    %cl,%eax
  802418:	89 44 24 04          	mov    %eax,0x4(%esp)
  80241c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802420:	89 f1                	mov    %esi,%ecx
  802422:	d3 e8                	shr    %cl,%eax
  802424:	09 d0                	or     %edx,%eax
  802426:	d3 eb                	shr    %cl,%ebx
  802428:	89 da                	mov    %ebx,%edx
  80242a:	f7 f7                	div    %edi
  80242c:	89 d3                	mov    %edx,%ebx
  80242e:	f7 24 24             	mull   (%esp)
  802431:	89 c6                	mov    %eax,%esi
  802433:	89 d1                	mov    %edx,%ecx
  802435:	39 d3                	cmp    %edx,%ebx
  802437:	0f 82 87 00 00 00    	jb     8024c4 <__umoddi3+0x134>
  80243d:	0f 84 91 00 00 00    	je     8024d4 <__umoddi3+0x144>
  802443:	8b 54 24 04          	mov    0x4(%esp),%edx
  802447:	29 f2                	sub    %esi,%edx
  802449:	19 cb                	sbb    %ecx,%ebx
  80244b:	89 d8                	mov    %ebx,%eax
  80244d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802451:	d3 e0                	shl    %cl,%eax
  802453:	89 e9                	mov    %ebp,%ecx
  802455:	d3 ea                	shr    %cl,%edx
  802457:	09 d0                	or     %edx,%eax
  802459:	89 e9                	mov    %ebp,%ecx
  80245b:	d3 eb                	shr    %cl,%ebx
  80245d:	89 da                	mov    %ebx,%edx
  80245f:	83 c4 1c             	add    $0x1c,%esp
  802462:	5b                   	pop    %ebx
  802463:	5e                   	pop    %esi
  802464:	5f                   	pop    %edi
  802465:	5d                   	pop    %ebp
  802466:	c3                   	ret    
  802467:	90                   	nop
  802468:	89 fd                	mov    %edi,%ebp
  80246a:	85 ff                	test   %edi,%edi
  80246c:	75 0b                	jne    802479 <__umoddi3+0xe9>
  80246e:	b8 01 00 00 00       	mov    $0x1,%eax
  802473:	31 d2                	xor    %edx,%edx
  802475:	f7 f7                	div    %edi
  802477:	89 c5                	mov    %eax,%ebp
  802479:	89 f0                	mov    %esi,%eax
  80247b:	31 d2                	xor    %edx,%edx
  80247d:	f7 f5                	div    %ebp
  80247f:	89 c8                	mov    %ecx,%eax
  802481:	f7 f5                	div    %ebp
  802483:	89 d0                	mov    %edx,%eax
  802485:	e9 44 ff ff ff       	jmp    8023ce <__umoddi3+0x3e>
  80248a:	66 90                	xchg   %ax,%ax
  80248c:	89 c8                	mov    %ecx,%eax
  80248e:	89 f2                	mov    %esi,%edx
  802490:	83 c4 1c             	add    $0x1c,%esp
  802493:	5b                   	pop    %ebx
  802494:	5e                   	pop    %esi
  802495:	5f                   	pop    %edi
  802496:	5d                   	pop    %ebp
  802497:	c3                   	ret    
  802498:	3b 04 24             	cmp    (%esp),%eax
  80249b:	72 06                	jb     8024a3 <__umoddi3+0x113>
  80249d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024a1:	77 0f                	ja     8024b2 <__umoddi3+0x122>
  8024a3:	89 f2                	mov    %esi,%edx
  8024a5:	29 f9                	sub    %edi,%ecx
  8024a7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024ab:	89 14 24             	mov    %edx,(%esp)
  8024ae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024b2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024b6:	8b 14 24             	mov    (%esp),%edx
  8024b9:	83 c4 1c             	add    $0x1c,%esp
  8024bc:	5b                   	pop    %ebx
  8024bd:	5e                   	pop    %esi
  8024be:	5f                   	pop    %edi
  8024bf:	5d                   	pop    %ebp
  8024c0:	c3                   	ret    
  8024c1:	8d 76 00             	lea    0x0(%esi),%esi
  8024c4:	2b 04 24             	sub    (%esp),%eax
  8024c7:	19 fa                	sbb    %edi,%edx
  8024c9:	89 d1                	mov    %edx,%ecx
  8024cb:	89 c6                	mov    %eax,%esi
  8024cd:	e9 71 ff ff ff       	jmp    802443 <__umoddi3+0xb3>
  8024d2:	66 90                	xchg   %ax,%ax
  8024d4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024d8:	72 ea                	jb     8024c4 <__umoddi3+0x134>
  8024da:	89 d9                	mov    %ebx,%ecx
  8024dc:	e9 62 ff ff ff       	jmp    802443 <__umoddi3+0xb3>
