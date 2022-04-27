
obj/user/quicksort_freeheap:     file format elf32-i386


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
  800031:	e8 92 05 00 00       	call   8005c8 <libmain>
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
  800049:	e8 db 1a 00 00       	call   801b29 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 ed 1a 00 00       	call   801b42 <sys_calculate_modified_frames>
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
  800067:	68 40 22 80 00       	push   $0x802240
  80006c:	e8 9c 0f 00 00       	call   80100d <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 ec 14 00 00       	call   801573 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 7f 18 00 00       	call   80191b <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 22 80 00       	push   $0x802260
  8000aa:	e8 dc 08 00 00       	call   80098b <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 22 80 00       	push   $0x802283
  8000ba:	e8 cc 08 00 00       	call   80098b <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 22 80 00       	push   $0x802291
  8000ca:	e8 bc 08 00 00       	call   80098b <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\nSelect: ") ;
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 22 80 00       	push   $0x8022a0
  8000da:	e8 ac 08 00 00       	call   80098b <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000e2:	e8 89 04 00 00       	call   800570 <getchar>
  8000e7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000ea:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 31 04 00 00       	call   800528 <cputchar>
  8000f7:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8000fa:	83 ec 0c             	sub    $0xc,%esp
  8000fd:	6a 0a                	push   $0xa
  8000ff:	e8 24 04 00 00       	call   800528 <cputchar>
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
  800123:	e8 c8 02 00 00       	call   8003f0 <InitializeAscending>
  800128:	83 c4 10             	add    $0x10,%esp
			break ;
  80012b:	eb 37                	jmp    800164 <_main+0x12c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	ff 75 ec             	pushl  -0x14(%ebp)
  800133:	ff 75 e8             	pushl  -0x18(%ebp)
  800136:	e8 e6 02 00 00       	call   800421 <InitializeDescending>
  80013b:	83 c4 10             	add    $0x10,%esp
			break ;
  80013e:	eb 24                	jmp    800164 <_main+0x12c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 ec             	pushl  -0x14(%ebp)
  800146:	ff 75 e8             	pushl  -0x18(%ebp)
  800149:	e8 08 03 00 00       	call   800456 <InitializeSemiRandom>
  80014e:	83 c4 10             	add    $0x10,%esp
			break ;
  800151:	eb 11                	jmp    800164 <_main+0x12c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	ff 75 ec             	pushl  -0x14(%ebp)
  800159:	ff 75 e8             	pushl  -0x18(%ebp)
  80015c:	e8 f5 02 00 00       	call   800456 <InitializeSemiRandom>
  800161:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800164:	83 ec 08             	sub    $0x8,%esp
  800167:	ff 75 ec             	pushl  -0x14(%ebp)
  80016a:	ff 75 e8             	pushl  -0x18(%ebp)
  80016d:	e8 c3 00 00 00       	call   800235 <QuickSort>
  800172:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 c3 01 00 00       	call   800346 <CheckSorted>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800189:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80018d:	75 14                	jne    8001a3 <_main+0x16b>
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	68 b8 22 80 00       	push   $0x8022b8
  800197:	6a 41                	push   $0x41
  800199:	68 da 22 80 00       	push   $0x8022da
  80019e:	e8 34 05 00 00       	call   8006d7 <_panic>
		else
		{ 
				cprintf("===============================================\n") ;
  8001a3:	83 ec 0c             	sub    $0xc,%esp
  8001a6:	68 f4 22 80 00       	push   $0x8022f4
  8001ab:	e8 db 07 00 00       	call   80098b <cprintf>
  8001b0:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001b3:	83 ec 0c             	sub    $0xc,%esp
  8001b6:	68 28 23 80 00       	push   $0x802328
  8001bb:	e8 cb 07 00 00       	call   80098b <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001c3:	83 ec 0c             	sub    $0xc,%esp
  8001c6:	68 5c 23 80 00       	push   $0x80235c
  8001cb:	e8 bb 07 00 00       	call   80098b <cprintf>
  8001d0:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001d3:	83 ec 0c             	sub    $0xc,%esp
  8001d6:	68 8e 23 80 00       	push   $0x80238e
  8001db:	e8 ab 07 00 00       	call   80098b <cprintf>
  8001e0:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  8001e3:	83 ec 0c             	sub    $0xc,%esp
  8001e6:	68 a4 23 80 00       	push   $0x8023a4
  8001eb:	e8 9b 07 00 00       	call   80098b <cprintf>
  8001f0:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8001f3:	e8 78 03 00 00       	call   800570 <getchar>
  8001f8:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8001fb:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8001ff:	83 ec 0c             	sub    $0xc,%esp
  800202:	50                   	push   %eax
  800203:	e8 20 03 00 00       	call   800528 <cputchar>
  800208:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80020b:	83 ec 0c             	sub    $0xc,%esp
  80020e:	6a 0a                	push   $0xa
  800210:	e8 13 03 00 00       	call   800528 <cputchar>
  800215:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	6a 0a                	push   $0xa
  80021d:	e8 06 03 00 00       	call   800528 <cputchar>
  800222:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800225:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800229:	0f 84 1a fe ff ff    	je     800049 <_main+0x11>

}
  80022f:	90                   	nop
  800230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800233:	c9                   	leave  
  800234:	c3                   	ret    

00800235 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800235:	55                   	push   %ebp
  800236:	89 e5                	mov    %esp,%ebp
  800238:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80023b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023e:	48                   	dec    %eax
  80023f:	50                   	push   %eax
  800240:	6a 00                	push   $0x0
  800242:	ff 75 0c             	pushl  0xc(%ebp)
  800245:	ff 75 08             	pushl  0x8(%ebp)
  800248:	e8 06 00 00 00       	call   800253 <QSort>
  80024d:	83 c4 10             	add    $0x10,%esp
}
  800250:	90                   	nop
  800251:	c9                   	leave  
  800252:	c3                   	ret    

00800253 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800253:	55                   	push   %ebp
  800254:	89 e5                	mov    %esp,%ebp
  800256:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800259:	8b 45 10             	mov    0x10(%ebp),%eax
  80025c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80025f:	0f 8d de 00 00 00    	jge    800343 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800265:	8b 45 10             	mov    0x10(%ebp),%eax
  800268:	40                   	inc    %eax
  800269:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80026c:	8b 45 14             	mov    0x14(%ebp),%eax
  80026f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800272:	e9 80 00 00 00       	jmp    8002f7 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800277:	ff 45 f4             	incl   -0xc(%ebp)
  80027a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800280:	7f 2b                	jg     8002ad <QSort+0x5a>
  800282:	8b 45 10             	mov    0x10(%ebp),%eax
  800285:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028c:	8b 45 08             	mov    0x8(%ebp),%eax
  80028f:	01 d0                	add    %edx,%eax
  800291:	8b 10                	mov    (%eax),%edx
  800293:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800296:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80029d:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a0:	01 c8                	add    %ecx,%eax
  8002a2:	8b 00                	mov    (%eax),%eax
  8002a4:	39 c2                	cmp    %eax,%edx
  8002a6:	7d cf                	jge    800277 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002a8:	eb 03                	jmp    8002ad <QSort+0x5a>
  8002aa:	ff 4d f0             	decl   -0x10(%ebp)
  8002ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002b0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002b3:	7e 26                	jle    8002db <QSort+0x88>
  8002b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	8b 10                	mov    (%eax),%edx
  8002c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d3:	01 c8                	add    %ecx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	39 c2                	cmp    %eax,%edx
  8002d9:	7e cf                	jle    8002aa <QSort+0x57>

		if (i <= j)
  8002db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e1:	7f 14                	jg     8002f7 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8002e3:	83 ec 04             	sub    $0x4,%esp
  8002e6:	ff 75 f0             	pushl  -0x10(%ebp)
  8002e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ec:	ff 75 08             	pushl  0x8(%ebp)
  8002ef:	e8 a9 00 00 00       	call   80039d <Swap>
  8002f4:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8002f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002fd:	0f 8e 77 ff ff ff    	jle    80027a <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800303:	83 ec 04             	sub    $0x4,%esp
  800306:	ff 75 f0             	pushl  -0x10(%ebp)
  800309:	ff 75 10             	pushl  0x10(%ebp)
  80030c:	ff 75 08             	pushl  0x8(%ebp)
  80030f:	e8 89 00 00 00       	call   80039d <Swap>
  800314:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031a:	48                   	dec    %eax
  80031b:	50                   	push   %eax
  80031c:	ff 75 10             	pushl  0x10(%ebp)
  80031f:	ff 75 0c             	pushl  0xc(%ebp)
  800322:	ff 75 08             	pushl  0x8(%ebp)
  800325:	e8 29 ff ff ff       	call   800253 <QSort>
  80032a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80032d:	ff 75 14             	pushl  0x14(%ebp)
  800330:	ff 75 f4             	pushl  -0xc(%ebp)
  800333:	ff 75 0c             	pushl  0xc(%ebp)
  800336:	ff 75 08             	pushl  0x8(%ebp)
  800339:	e8 15 ff ff ff       	call   800253 <QSort>
  80033e:	83 c4 10             	add    $0x10,%esp
  800341:	eb 01                	jmp    800344 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800343:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800344:	c9                   	leave  
  800345:	c3                   	ret    

00800346 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800346:	55                   	push   %ebp
  800347:	89 e5                	mov    %esp,%ebp
  800349:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80034c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800353:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80035a:	eb 33                	jmp    80038f <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80035c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80035f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	01 d0                	add    %edx,%eax
  80036b:	8b 10                	mov    (%eax),%edx
  80036d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800370:	40                   	inc    %eax
  800371:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	01 c8                	add    %ecx,%eax
  80037d:	8b 00                	mov    (%eax),%eax
  80037f:	39 c2                	cmp    %eax,%edx
  800381:	7e 09                	jle    80038c <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800383:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80038a:	eb 0c                	jmp    800398 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80038c:	ff 45 f8             	incl   -0x8(%ebp)
  80038f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800392:	48                   	dec    %eax
  800393:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800396:	7f c4                	jg     80035c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800398:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80039b:	c9                   	leave  
  80039c:	c3                   	ret    

0080039d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80039d:	55                   	push   %ebp
  80039e:	89 e5                	mov    %esp,%ebp
  8003a0:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b0:	01 d0                	add    %edx,%eax
  8003b2:	8b 00                	mov    (%eax),%eax
  8003b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	01 c2                	add    %eax,%edx
  8003c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	01 c8                	add    %ecx,%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 c2                	add    %eax,%edx
  8003e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003eb:	89 02                	mov    %eax,(%edx)
}
  8003ed:	90                   	nop
  8003ee:	c9                   	leave  
  8003ef:	c3                   	ret    

008003f0 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003f0:	55                   	push   %ebp
  8003f1:	89 e5                	mov    %esp,%ebp
  8003f3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003fd:	eb 17                	jmp    800416 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800402:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	01 c2                	add    %eax,%edx
  80040e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800411:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800413:	ff 45 fc             	incl   -0x4(%ebp)
  800416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800419:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041c:	7c e1                	jl     8003ff <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80041e:	90                   	nop
  80041f:	c9                   	leave  
  800420:	c3                   	ret    

00800421 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800421:	55                   	push   %ebp
  800422:	89 e5                	mov    %esp,%ebp
  800424:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800427:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042e:	eb 1b                	jmp    80044b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 c2                	add    %eax,%edx
  80043f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800442:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800445:	48                   	dec    %eax
  800446:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800448:	ff 45 fc             	incl   -0x4(%ebp)
  80044b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800451:	7c dd                	jl     800430 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800453:	90                   	nop
  800454:	c9                   	leave  
  800455:	c3                   	ret    

00800456 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800456:	55                   	push   %ebp
  800457:	89 e5                	mov    %esp,%ebp
  800459:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80045c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80045f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800464:	f7 e9                	imul   %ecx
  800466:	c1 f9 1f             	sar    $0x1f,%ecx
  800469:	89 d0                	mov    %edx,%eax
  80046b:	29 c8                	sub    %ecx,%eax
  80046d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800470:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800477:	eb 1e                	jmp    800497 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800479:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800483:	8b 45 08             	mov    0x8(%ebp),%eax
  800486:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800489:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048c:	99                   	cltd   
  80048d:	f7 7d f8             	idivl  -0x8(%ebp)
  800490:	89 d0                	mov    %edx,%eax
  800492:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800494:	ff 45 fc             	incl   -0x4(%ebp)
  800497:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80049d:	7c da                	jl     800479 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80049f:	90                   	nop
  8004a0:	c9                   	leave  
  8004a1:	c3                   	ret    

008004a2 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004a2:	55                   	push   %ebp
  8004a3:	89 e5                	mov    %esp,%ebp
  8004a5:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004a8:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004b6:	eb 42                	jmp    8004fa <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bb:	99                   	cltd   
  8004bc:	f7 7d f0             	idivl  -0x10(%ebp)
  8004bf:	89 d0                	mov    %edx,%eax
  8004c1:	85 c0                	test   %eax,%eax
  8004c3:	75 10                	jne    8004d5 <PrintElements+0x33>
				cprintf("\n");
  8004c5:	83 ec 0c             	sub    $0xc,%esp
  8004c8:	68 c2 23 80 00       	push   $0x8023c2
  8004cd:	e8 b9 04 00 00       	call   80098b <cprintf>
  8004d2:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8004d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004df:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e2:	01 d0                	add    %edx,%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	83 ec 08             	sub    $0x8,%esp
  8004e9:	50                   	push   %eax
  8004ea:	68 c4 23 80 00       	push   $0x8023c4
  8004ef:	e8 97 04 00 00       	call   80098b <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004f7:	ff 45 f4             	incl   -0xc(%ebp)
  8004fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fd:	48                   	dec    %eax
  8004fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800501:	7f b5                	jg     8004b8 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800503:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 d0                	add    %edx,%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	83 ec 08             	sub    $0x8,%esp
  800517:	50                   	push   %eax
  800518:	68 c9 23 80 00       	push   $0x8023c9
  80051d:	e8 69 04 00 00       	call   80098b <cprintf>
  800522:	83 c4 10             	add    $0x10,%esp
}
  800525:	90                   	nop
  800526:	c9                   	leave  
  800527:	c3                   	ret    

00800528 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800528:	55                   	push   %ebp
  800529:	89 e5                	mov    %esp,%ebp
  80052b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80052e:	8b 45 08             	mov    0x8(%ebp),%eax
  800531:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800534:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 ec 16 00 00       	call   801c2d <sys_cputc>
  800541:	83 c4 10             	add    $0x10,%esp
}
  800544:	90                   	nop
  800545:	c9                   	leave  
  800546:	c3                   	ret    

00800547 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800547:	55                   	push   %ebp
  800548:	89 e5                	mov    %esp,%ebp
  80054a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80054d:	e8 a7 16 00 00       	call   801bf9 <sys_disable_interrupt>
	char c = ch;
  800552:	8b 45 08             	mov    0x8(%ebp),%eax
  800555:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800558:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80055c:	83 ec 0c             	sub    $0xc,%esp
  80055f:	50                   	push   %eax
  800560:	e8 c8 16 00 00       	call   801c2d <sys_cputc>
  800565:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800568:	e8 a6 16 00 00       	call   801c13 <sys_enable_interrupt>
}
  80056d:	90                   	nop
  80056e:	c9                   	leave  
  80056f:	c3                   	ret    

00800570 <getchar>:

int
getchar(void)
{
  800570:	55                   	push   %ebp
  800571:	89 e5                	mov    %esp,%ebp
  800573:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800576:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80057d:	eb 08                	jmp    800587 <getchar+0x17>
	{
		c = sys_cgetc();
  80057f:	e8 8d 14 00 00       	call   801a11 <sys_cgetc>
  800584:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80058b:	74 f2                	je     80057f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80058d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <atomic_getchar>:

int
atomic_getchar(void)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800598:	e8 5c 16 00 00       	call   801bf9 <sys_disable_interrupt>
	int c=0;
  80059d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005a4:	eb 08                	jmp    8005ae <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005a6:	e8 66 14 00 00       	call   801a11 <sys_cgetc>
  8005ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005b2:	74 f2                	je     8005a6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005b4:	e8 5a 16 00 00       	call   801c13 <sys_enable_interrupt>
	return c;
  8005b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005bc:	c9                   	leave  
  8005bd:	c3                   	ret    

008005be <iscons>:

int iscons(int fdnum)
{
  8005be:	55                   	push   %ebp
  8005bf:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005c1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005c6:	5d                   	pop    %ebp
  8005c7:	c3                   	ret    

008005c8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005c8:	55                   	push   %ebp
  8005c9:	89 e5                	mov    %esp,%ebp
  8005cb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005ce:	e8 8b 14 00 00       	call   801a5e <sys_getenvindex>
  8005d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005d9:	89 d0                	mov    %edx,%eax
  8005db:	c1 e0 02             	shl    $0x2,%eax
  8005de:	01 d0                	add    %edx,%eax
  8005e0:	01 c0                	add    %eax,%eax
  8005e2:	01 d0                	add    %edx,%eax
  8005e4:	01 c0                	add    %eax,%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005ef:	01 d0                	add    %edx,%eax
  8005f1:	c1 e0 02             	shl    $0x2,%eax
  8005f4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005f9:	a3 08 30 80 00       	mov    %eax,0x803008

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005fe:	a1 08 30 80 00       	mov    0x803008,%eax
  800603:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800609:	84 c0                	test   %al,%al
  80060b:	74 0f                	je     80061c <libmain+0x54>
		binaryname = myEnv->prog_name;
  80060d:	a1 08 30 80 00       	mov    0x803008,%eax
  800612:	05 f4 02 00 00       	add    $0x2f4,%eax
  800617:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80061c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800620:	7e 0a                	jle    80062c <libmain+0x64>
		binaryname = argv[0];
  800622:	8b 45 0c             	mov    0xc(%ebp),%eax
  800625:	8b 00                	mov    (%eax),%eax
  800627:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80062c:	83 ec 08             	sub    $0x8,%esp
  80062f:	ff 75 0c             	pushl  0xc(%ebp)
  800632:	ff 75 08             	pushl  0x8(%ebp)
  800635:	e8 fe f9 ff ff       	call   800038 <_main>
  80063a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80063d:	e8 b7 15 00 00       	call   801bf9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800642:	83 ec 0c             	sub    $0xc,%esp
  800645:	68 e8 23 80 00       	push   $0x8023e8
  80064a:	e8 3c 03 00 00       	call   80098b <cprintf>
  80064f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800652:	a1 08 30 80 00       	mov    0x803008,%eax
  800657:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80065d:	a1 08 30 80 00       	mov    0x803008,%eax
  800662:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800668:	83 ec 04             	sub    $0x4,%esp
  80066b:	52                   	push   %edx
  80066c:	50                   	push   %eax
  80066d:	68 10 24 80 00       	push   $0x802410
  800672:	e8 14 03 00 00       	call   80098b <cprintf>
  800677:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067a:	a1 08 30 80 00       	mov    0x803008,%eax
  80067f:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  800685:	83 ec 08             	sub    $0x8,%esp
  800688:	50                   	push   %eax
  800689:	68 35 24 80 00       	push   $0x802435
  80068e:	e8 f8 02 00 00       	call   80098b <cprintf>
  800693:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800696:	83 ec 0c             	sub    $0xc,%esp
  800699:	68 e8 23 80 00       	push   $0x8023e8
  80069e:	e8 e8 02 00 00       	call   80098b <cprintf>
  8006a3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006a6:	e8 68 15 00 00       	call   801c13 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ab:	e8 19 00 00 00       	call   8006c9 <exit>
}
  8006b0:	90                   	nop
  8006b1:	c9                   	leave  
  8006b2:	c3                   	ret    

008006b3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b3:	55                   	push   %ebp
  8006b4:	89 e5                	mov    %esp,%ebp
  8006b6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006b9:	83 ec 0c             	sub    $0xc,%esp
  8006bc:	6a 00                	push   $0x0
  8006be:	e8 67 13 00 00       	call   801a2a <sys_env_destroy>
  8006c3:	83 c4 10             	add    $0x10,%esp
}
  8006c6:	90                   	nop
  8006c7:	c9                   	leave  
  8006c8:	c3                   	ret    

008006c9 <exit>:

void
exit(void)
{
  8006c9:	55                   	push   %ebp
  8006ca:	89 e5                	mov    %esp,%ebp
  8006cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006cf:	e8 bc 13 00 00       	call   801a90 <sys_env_exit>
}
  8006d4:	90                   	nop
  8006d5:	c9                   	leave  
  8006d6:	c3                   	ret    

008006d7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006d7:	55                   	push   %ebp
  8006d8:	89 e5                	mov    %esp,%ebp
  8006da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e0:	83 c0 04             	add    $0x4,%eax
  8006e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006e6:	a1 18 30 80 00       	mov    0x803018,%eax
  8006eb:	85 c0                	test   %eax,%eax
  8006ed:	74 16                	je     800705 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006ef:	a1 18 30 80 00       	mov    0x803018,%eax
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	50                   	push   %eax
  8006f8:	68 4c 24 80 00       	push   $0x80244c
  8006fd:	e8 89 02 00 00       	call   80098b <cprintf>
  800702:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800705:	a1 00 30 80 00       	mov    0x803000,%eax
  80070a:	ff 75 0c             	pushl  0xc(%ebp)
  80070d:	ff 75 08             	pushl  0x8(%ebp)
  800710:	50                   	push   %eax
  800711:	68 51 24 80 00       	push   $0x802451
  800716:	e8 70 02 00 00       	call   80098b <cprintf>
  80071b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80071e:	8b 45 10             	mov    0x10(%ebp),%eax
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 f4             	pushl  -0xc(%ebp)
  800727:	50                   	push   %eax
  800728:	e8 f3 01 00 00       	call   800920 <vcprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800730:	83 ec 08             	sub    $0x8,%esp
  800733:	6a 00                	push   $0x0
  800735:	68 6d 24 80 00       	push   $0x80246d
  80073a:	e8 e1 01 00 00       	call   800920 <vcprintf>
  80073f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800742:	e8 82 ff ff ff       	call   8006c9 <exit>

	// should not return here
	while (1) ;
  800747:	eb fe                	jmp    800747 <_panic+0x70>

00800749 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800749:	55                   	push   %ebp
  80074a:	89 e5                	mov    %esp,%ebp
  80074c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80074f:	a1 08 30 80 00       	mov    0x803008,%eax
  800754:	8b 50 74             	mov    0x74(%eax),%edx
  800757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075a:	39 c2                	cmp    %eax,%edx
  80075c:	74 14                	je     800772 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80075e:	83 ec 04             	sub    $0x4,%esp
  800761:	68 70 24 80 00       	push   $0x802470
  800766:	6a 26                	push   $0x26
  800768:	68 bc 24 80 00       	push   $0x8024bc
  80076d:	e8 65 ff ff ff       	call   8006d7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800772:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800779:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800780:	e9 c2 00 00 00       	jmp    800847 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800785:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800788:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	01 d0                	add    %edx,%eax
  800794:	8b 00                	mov    (%eax),%eax
  800796:	85 c0                	test   %eax,%eax
  800798:	75 08                	jne    8007a2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80079d:	e9 a2 00 00 00       	jmp    800844 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007a9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b0:	eb 69                	jmp    80081b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b2:	a1 08 30 80 00       	mov    0x803008,%eax
  8007b7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c0:	89 d0                	mov    %edx,%eax
  8007c2:	01 c0                	add    %eax,%eax
  8007c4:	01 d0                	add    %edx,%eax
  8007c6:	c1 e0 02             	shl    $0x2,%eax
  8007c9:	01 c8                	add    %ecx,%eax
  8007cb:	8a 40 04             	mov    0x4(%eax),%al
  8007ce:	84 c0                	test   %al,%al
  8007d0:	75 46                	jne    800818 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d2:	a1 08 30 80 00       	mov    0x803008,%eax
  8007d7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007dd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e0:	89 d0                	mov    %edx,%eax
  8007e2:	01 c0                	add    %eax,%eax
  8007e4:	01 d0                	add    %edx,%eax
  8007e6:	c1 e0 02             	shl    $0x2,%eax
  8007e9:	01 c8                	add    %ecx,%eax
  8007eb:	8b 00                	mov    (%eax),%eax
  8007ed:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007f0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007f8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800804:	8b 45 08             	mov    0x8(%ebp),%eax
  800807:	01 c8                	add    %ecx,%eax
  800809:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80080b:	39 c2                	cmp    %eax,%edx
  80080d:	75 09                	jne    800818 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80080f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800816:	eb 12                	jmp    80082a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800818:	ff 45 e8             	incl   -0x18(%ebp)
  80081b:	a1 08 30 80 00       	mov    0x803008,%eax
  800820:	8b 50 74             	mov    0x74(%eax),%edx
  800823:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800826:	39 c2                	cmp    %eax,%edx
  800828:	77 88                	ja     8007b2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80082a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80082e:	75 14                	jne    800844 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800830:	83 ec 04             	sub    $0x4,%esp
  800833:	68 c8 24 80 00       	push   $0x8024c8
  800838:	6a 3a                	push   $0x3a
  80083a:	68 bc 24 80 00       	push   $0x8024bc
  80083f:	e8 93 fe ff ff       	call   8006d7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800844:	ff 45 f0             	incl   -0x10(%ebp)
  800847:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80084d:	0f 8c 32 ff ff ff    	jl     800785 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800853:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800861:	eb 26                	jmp    800889 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800863:	a1 08 30 80 00       	mov    0x803008,%eax
  800868:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80086e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800871:	89 d0                	mov    %edx,%eax
  800873:	01 c0                	add    %eax,%eax
  800875:	01 d0                	add    %edx,%eax
  800877:	c1 e0 02             	shl    $0x2,%eax
  80087a:	01 c8                	add    %ecx,%eax
  80087c:	8a 40 04             	mov    0x4(%eax),%al
  80087f:	3c 01                	cmp    $0x1,%al
  800881:	75 03                	jne    800886 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800883:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800886:	ff 45 e0             	incl   -0x20(%ebp)
  800889:	a1 08 30 80 00       	mov    0x803008,%eax
  80088e:	8b 50 74             	mov    0x74(%eax),%edx
  800891:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800894:	39 c2                	cmp    %eax,%edx
  800896:	77 cb                	ja     800863 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800898:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80089b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80089e:	74 14                	je     8008b4 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008a0:	83 ec 04             	sub    $0x4,%esp
  8008a3:	68 1c 25 80 00       	push   $0x80251c
  8008a8:	6a 44                	push   $0x44
  8008aa:	68 bc 24 80 00       	push   $0x8024bc
  8008af:	e8 23 fe ff ff       	call   8006d7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008b4:	90                   	nop
  8008b5:	c9                   	leave  
  8008b6:	c3                   	ret    

008008b7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008b7:	55                   	push   %ebp
  8008b8:	89 e5                	mov    %esp,%ebp
  8008ba:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c0:	8b 00                	mov    (%eax),%eax
  8008c2:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c8:	89 0a                	mov    %ecx,(%edx)
  8008ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8008cd:	88 d1                	mov    %dl,%cl
  8008cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d9:	8b 00                	mov    (%eax),%eax
  8008db:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008e0:	75 2c                	jne    80090e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008e2:	a0 0c 30 80 00       	mov    0x80300c,%al
  8008e7:	0f b6 c0             	movzbl %al,%eax
  8008ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ed:	8b 12                	mov    (%edx),%edx
  8008ef:	89 d1                	mov    %edx,%ecx
  8008f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f4:	83 c2 08             	add    $0x8,%edx
  8008f7:	83 ec 04             	sub    $0x4,%esp
  8008fa:	50                   	push   %eax
  8008fb:	51                   	push   %ecx
  8008fc:	52                   	push   %edx
  8008fd:	e8 e6 10 00 00       	call   8019e8 <sys_cputs>
  800902:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800905:	8b 45 0c             	mov    0xc(%ebp),%eax
  800908:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80090e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800911:	8b 40 04             	mov    0x4(%eax),%eax
  800914:	8d 50 01             	lea    0x1(%eax),%edx
  800917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80091d:	90                   	nop
  80091e:	c9                   	leave  
  80091f:	c3                   	ret    

00800920 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800920:	55                   	push   %ebp
  800921:	89 e5                	mov    %esp,%ebp
  800923:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800929:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800930:	00 00 00 
	b.cnt = 0;
  800933:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80093a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	ff 75 08             	pushl  0x8(%ebp)
  800943:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800949:	50                   	push   %eax
  80094a:	68 b7 08 80 00       	push   $0x8008b7
  80094f:	e8 11 02 00 00       	call   800b65 <vprintfmt>
  800954:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800957:	a0 0c 30 80 00       	mov    0x80300c,%al
  80095c:	0f b6 c0             	movzbl %al,%eax
  80095f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800965:	83 ec 04             	sub    $0x4,%esp
  800968:	50                   	push   %eax
  800969:	52                   	push   %edx
  80096a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800970:	83 c0 08             	add    $0x8,%eax
  800973:	50                   	push   %eax
  800974:	e8 6f 10 00 00       	call   8019e8 <sys_cputs>
  800979:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80097c:	c6 05 0c 30 80 00 00 	movb   $0x0,0x80300c
	return b.cnt;
  800983:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800989:	c9                   	leave  
  80098a:	c3                   	ret    

0080098b <cprintf>:

int cprintf(const char *fmt, ...) {
  80098b:	55                   	push   %ebp
  80098c:	89 e5                	mov    %esp,%ebp
  80098e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800991:	c6 05 0c 30 80 00 01 	movb   $0x1,0x80300c
	va_start(ap, fmt);
  800998:	8d 45 0c             	lea    0xc(%ebp),%eax
  80099b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	83 ec 08             	sub    $0x8,%esp
  8009a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a7:	50                   	push   %eax
  8009a8:	e8 73 ff ff ff       	call   800920 <vcprintf>
  8009ad:	83 c4 10             	add    $0x10,%esp
  8009b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b6:	c9                   	leave  
  8009b7:	c3                   	ret    

008009b8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009b8:	55                   	push   %ebp
  8009b9:	89 e5                	mov    %esp,%ebp
  8009bb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009be:	e8 36 12 00 00       	call   801bf9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009c3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	83 ec 08             	sub    $0x8,%esp
  8009cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d2:	50                   	push   %eax
  8009d3:	e8 48 ff ff ff       	call   800920 <vcprintf>
  8009d8:	83 c4 10             	add    $0x10,%esp
  8009db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009de:	e8 30 12 00 00       	call   801c13 <sys_enable_interrupt>
	return cnt;
  8009e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e6:	c9                   	leave  
  8009e7:	c3                   	ret    

008009e8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009e8:	55                   	push   %ebp
  8009e9:	89 e5                	mov    %esp,%ebp
  8009eb:	53                   	push   %ebx
  8009ec:	83 ec 14             	sub    $0x14,%esp
  8009ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009fb:	8b 45 18             	mov    0x18(%ebp),%eax
  8009fe:	ba 00 00 00 00       	mov    $0x0,%edx
  800a03:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a06:	77 55                	ja     800a5d <printnum+0x75>
  800a08:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a0b:	72 05                	jb     800a12 <printnum+0x2a>
  800a0d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a10:	77 4b                	ja     800a5d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a12:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a15:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a18:	8b 45 18             	mov    0x18(%ebp),%eax
  800a1b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a20:	52                   	push   %edx
  800a21:	50                   	push   %eax
  800a22:	ff 75 f4             	pushl  -0xc(%ebp)
  800a25:	ff 75 f0             	pushl  -0x10(%ebp)
  800a28:	e8 ab 15 00 00       	call   801fd8 <__udivdi3>
  800a2d:	83 c4 10             	add    $0x10,%esp
  800a30:	83 ec 04             	sub    $0x4,%esp
  800a33:	ff 75 20             	pushl  0x20(%ebp)
  800a36:	53                   	push   %ebx
  800a37:	ff 75 18             	pushl  0x18(%ebp)
  800a3a:	52                   	push   %edx
  800a3b:	50                   	push   %eax
  800a3c:	ff 75 0c             	pushl  0xc(%ebp)
  800a3f:	ff 75 08             	pushl  0x8(%ebp)
  800a42:	e8 a1 ff ff ff       	call   8009e8 <printnum>
  800a47:	83 c4 20             	add    $0x20,%esp
  800a4a:	eb 1a                	jmp    800a66 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a4c:	83 ec 08             	sub    $0x8,%esp
  800a4f:	ff 75 0c             	pushl  0xc(%ebp)
  800a52:	ff 75 20             	pushl  0x20(%ebp)
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	ff d0                	call   *%eax
  800a5a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a5d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a60:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a64:	7f e6                	jg     800a4c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a66:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a69:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a71:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a74:	53                   	push   %ebx
  800a75:	51                   	push   %ecx
  800a76:	52                   	push   %edx
  800a77:	50                   	push   %eax
  800a78:	e8 6b 16 00 00       	call   8020e8 <__umoddi3>
  800a7d:	83 c4 10             	add    $0x10,%esp
  800a80:	05 94 27 80 00       	add    $0x802794,%eax
  800a85:	8a 00                	mov    (%eax),%al
  800a87:	0f be c0             	movsbl %al,%eax
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	50                   	push   %eax
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	ff d0                	call   *%eax
  800a96:	83 c4 10             	add    $0x10,%esp
}
  800a99:	90                   	nop
  800a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a9d:	c9                   	leave  
  800a9e:	c3                   	ret    

00800a9f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a9f:	55                   	push   %ebp
  800aa0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aa2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aa6:	7e 1c                	jle    800ac4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8b 00                	mov    (%eax),%eax
  800aad:	8d 50 08             	lea    0x8(%eax),%edx
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	89 10                	mov    %edx,(%eax)
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	8b 00                	mov    (%eax),%eax
  800aba:	83 e8 08             	sub    $0x8,%eax
  800abd:	8b 50 04             	mov    0x4(%eax),%edx
  800ac0:	8b 00                	mov    (%eax),%eax
  800ac2:	eb 40                	jmp    800b04 <getuint+0x65>
	else if (lflag)
  800ac4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac8:	74 1e                	je     800ae8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	8d 50 04             	lea    0x4(%eax),%edx
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	89 10                	mov    %edx,(%eax)
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8b 00                	mov    (%eax),%eax
  800adc:	83 e8 04             	sub    $0x4,%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae6:	eb 1c                	jmp    800b04 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	8d 50 04             	lea    0x4(%eax),%edx
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	89 10                	mov    %edx,(%eax)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8b 00                	mov    (%eax),%eax
  800afa:	83 e8 04             	sub    $0x4,%eax
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b04:	5d                   	pop    %ebp
  800b05:	c3                   	ret    

00800b06 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b06:	55                   	push   %ebp
  800b07:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b09:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b0d:	7e 1c                	jle    800b2b <getint+0x25>
		return va_arg(*ap, long long);
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	8d 50 08             	lea    0x8(%eax),%edx
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	89 10                	mov    %edx,(%eax)
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	8b 00                	mov    (%eax),%eax
  800b21:	83 e8 08             	sub    $0x8,%eax
  800b24:	8b 50 04             	mov    0x4(%eax),%edx
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	eb 38                	jmp    800b63 <getint+0x5d>
	else if (lflag)
  800b2b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2f:	74 1a                	je     800b4b <getint+0x45>
		return va_arg(*ap, long);
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	8d 50 04             	lea    0x4(%eax),%edx
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	89 10                	mov    %edx,(%eax)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	83 e8 04             	sub    $0x4,%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	99                   	cltd   
  800b49:	eb 18                	jmp    800b63 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	8d 50 04             	lea    0x4(%eax),%edx
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	89 10                	mov    %edx,(%eax)
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	83 e8 04             	sub    $0x4,%eax
  800b60:	8b 00                	mov    (%eax),%eax
  800b62:	99                   	cltd   
}
  800b63:	5d                   	pop    %ebp
  800b64:	c3                   	ret    

00800b65 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b65:	55                   	push   %ebp
  800b66:	89 e5                	mov    %esp,%ebp
  800b68:	56                   	push   %esi
  800b69:	53                   	push   %ebx
  800b6a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b6d:	eb 17                	jmp    800b86 <vprintfmt+0x21>
			if (ch == '\0')
  800b6f:	85 db                	test   %ebx,%ebx
  800b71:	0f 84 af 03 00 00    	je     800f26 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b77:	83 ec 08             	sub    $0x8,%esp
  800b7a:	ff 75 0c             	pushl  0xc(%ebp)
  800b7d:	53                   	push   %ebx
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	ff d0                	call   *%eax
  800b83:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b86:	8b 45 10             	mov    0x10(%ebp),%eax
  800b89:	8d 50 01             	lea    0x1(%eax),%edx
  800b8c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8f:	8a 00                	mov    (%eax),%al
  800b91:	0f b6 d8             	movzbl %al,%ebx
  800b94:	83 fb 25             	cmp    $0x25,%ebx
  800b97:	75 d6                	jne    800b6f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b99:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b9d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ba4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bb2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbc:	8d 50 01             	lea    0x1(%eax),%edx
  800bbf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc2:	8a 00                	mov    (%eax),%al
  800bc4:	0f b6 d8             	movzbl %al,%ebx
  800bc7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bca:	83 f8 55             	cmp    $0x55,%eax
  800bcd:	0f 87 2b 03 00 00    	ja     800efe <vprintfmt+0x399>
  800bd3:	8b 04 85 b8 27 80 00 	mov    0x8027b8(,%eax,4),%eax
  800bda:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bdc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800be0:	eb d7                	jmp    800bb9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800be2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800be6:	eb d1                	jmp    800bb9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800be8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bef:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bf2:	89 d0                	mov    %edx,%eax
  800bf4:	c1 e0 02             	shl    $0x2,%eax
  800bf7:	01 d0                	add    %edx,%eax
  800bf9:	01 c0                	add    %eax,%eax
  800bfb:	01 d8                	add    %ebx,%eax
  800bfd:	83 e8 30             	sub    $0x30,%eax
  800c00:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c03:	8b 45 10             	mov    0x10(%ebp),%eax
  800c06:	8a 00                	mov    (%eax),%al
  800c08:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c0b:	83 fb 2f             	cmp    $0x2f,%ebx
  800c0e:	7e 3e                	jle    800c4e <vprintfmt+0xe9>
  800c10:	83 fb 39             	cmp    $0x39,%ebx
  800c13:	7f 39                	jg     800c4e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c15:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c18:	eb d5                	jmp    800bef <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c1d:	83 c0 04             	add    $0x4,%eax
  800c20:	89 45 14             	mov    %eax,0x14(%ebp)
  800c23:	8b 45 14             	mov    0x14(%ebp),%eax
  800c26:	83 e8 04             	sub    $0x4,%eax
  800c29:	8b 00                	mov    (%eax),%eax
  800c2b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c2e:	eb 1f                	jmp    800c4f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c34:	79 83                	jns    800bb9 <vprintfmt+0x54>
				width = 0;
  800c36:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c3d:	e9 77 ff ff ff       	jmp    800bb9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c42:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c49:	e9 6b ff ff ff       	jmp    800bb9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c4e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c4f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c53:	0f 89 60 ff ff ff    	jns    800bb9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c59:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c5f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c66:	e9 4e ff ff ff       	jmp    800bb9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c6b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c6e:	e9 46 ff ff ff       	jmp    800bb9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c73:	8b 45 14             	mov    0x14(%ebp),%eax
  800c76:	83 c0 04             	add    $0x4,%eax
  800c79:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7f:	83 e8 04             	sub    $0x4,%eax
  800c82:	8b 00                	mov    (%eax),%eax
  800c84:	83 ec 08             	sub    $0x8,%esp
  800c87:	ff 75 0c             	pushl  0xc(%ebp)
  800c8a:	50                   	push   %eax
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	ff d0                	call   *%eax
  800c90:	83 c4 10             	add    $0x10,%esp
			break;
  800c93:	e9 89 02 00 00       	jmp    800f21 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c98:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9b:	83 c0 04             	add    $0x4,%eax
  800c9e:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca4:	83 e8 04             	sub    $0x4,%eax
  800ca7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ca9:	85 db                	test   %ebx,%ebx
  800cab:	79 02                	jns    800caf <vprintfmt+0x14a>
				err = -err;
  800cad:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800caf:	83 fb 64             	cmp    $0x64,%ebx
  800cb2:	7f 0b                	jg     800cbf <vprintfmt+0x15a>
  800cb4:	8b 34 9d 00 26 80 00 	mov    0x802600(,%ebx,4),%esi
  800cbb:	85 f6                	test   %esi,%esi
  800cbd:	75 19                	jne    800cd8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cbf:	53                   	push   %ebx
  800cc0:	68 a5 27 80 00       	push   $0x8027a5
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	ff 75 08             	pushl  0x8(%ebp)
  800ccb:	e8 5e 02 00 00       	call   800f2e <printfmt>
  800cd0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cd3:	e9 49 02 00 00       	jmp    800f21 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cd8:	56                   	push   %esi
  800cd9:	68 ae 27 80 00       	push   $0x8027ae
  800cde:	ff 75 0c             	pushl  0xc(%ebp)
  800ce1:	ff 75 08             	pushl  0x8(%ebp)
  800ce4:	e8 45 02 00 00       	call   800f2e <printfmt>
  800ce9:	83 c4 10             	add    $0x10,%esp
			break;
  800cec:	e9 30 02 00 00       	jmp    800f21 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cf1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf4:	83 c0 04             	add    $0x4,%eax
  800cf7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfd:	83 e8 04             	sub    $0x4,%eax
  800d00:	8b 30                	mov    (%eax),%esi
  800d02:	85 f6                	test   %esi,%esi
  800d04:	75 05                	jne    800d0b <vprintfmt+0x1a6>
				p = "(null)";
  800d06:	be b1 27 80 00       	mov    $0x8027b1,%esi
			if (width > 0 && padc != '-')
  800d0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d0f:	7e 6d                	jle    800d7e <vprintfmt+0x219>
  800d11:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d15:	74 67                	je     800d7e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d17:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1a:	83 ec 08             	sub    $0x8,%esp
  800d1d:	50                   	push   %eax
  800d1e:	56                   	push   %esi
  800d1f:	e8 12 05 00 00       	call   801236 <strnlen>
  800d24:	83 c4 10             	add    $0x10,%esp
  800d27:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d2a:	eb 16                	jmp    800d42 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d2c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d30:	83 ec 08             	sub    $0x8,%esp
  800d33:	ff 75 0c             	pushl  0xc(%ebp)
  800d36:	50                   	push   %eax
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	ff d0                	call   *%eax
  800d3c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d3f:	ff 4d e4             	decl   -0x1c(%ebp)
  800d42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d46:	7f e4                	jg     800d2c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d48:	eb 34                	jmp    800d7e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d4a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d4e:	74 1c                	je     800d6c <vprintfmt+0x207>
  800d50:	83 fb 1f             	cmp    $0x1f,%ebx
  800d53:	7e 05                	jle    800d5a <vprintfmt+0x1f5>
  800d55:	83 fb 7e             	cmp    $0x7e,%ebx
  800d58:	7e 12                	jle    800d6c <vprintfmt+0x207>
					putch('?', putdat);
  800d5a:	83 ec 08             	sub    $0x8,%esp
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	6a 3f                	push   $0x3f
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	ff d0                	call   *%eax
  800d67:	83 c4 10             	add    $0x10,%esp
  800d6a:	eb 0f                	jmp    800d7b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d6c:	83 ec 08             	sub    $0x8,%esp
  800d6f:	ff 75 0c             	pushl  0xc(%ebp)
  800d72:	53                   	push   %ebx
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	ff d0                	call   *%eax
  800d78:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d7e:	89 f0                	mov    %esi,%eax
  800d80:	8d 70 01             	lea    0x1(%eax),%esi
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	0f be d8             	movsbl %al,%ebx
  800d88:	85 db                	test   %ebx,%ebx
  800d8a:	74 24                	je     800db0 <vprintfmt+0x24b>
  800d8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d90:	78 b8                	js     800d4a <vprintfmt+0x1e5>
  800d92:	ff 4d e0             	decl   -0x20(%ebp)
  800d95:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d99:	79 af                	jns    800d4a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9b:	eb 13                	jmp    800db0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	6a 20                	push   $0x20
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	ff d0                	call   *%eax
  800daa:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dad:	ff 4d e4             	decl   -0x1c(%ebp)
  800db0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db4:	7f e7                	jg     800d9d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800db6:	e9 66 01 00 00       	jmp    800f21 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dbb:	83 ec 08             	sub    $0x8,%esp
  800dbe:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc1:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc4:	50                   	push   %eax
  800dc5:	e8 3c fd ff ff       	call   800b06 <getint>
  800dca:	83 c4 10             	add    $0x10,%esp
  800dcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dd9:	85 d2                	test   %edx,%edx
  800ddb:	79 23                	jns    800e00 <vprintfmt+0x29b>
				putch('-', putdat);
  800ddd:	83 ec 08             	sub    $0x8,%esp
  800de0:	ff 75 0c             	pushl  0xc(%ebp)
  800de3:	6a 2d                	push   $0x2d
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	ff d0                	call   *%eax
  800dea:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ded:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df3:	f7 d8                	neg    %eax
  800df5:	83 d2 00             	adc    $0x0,%edx
  800df8:	f7 da                	neg    %edx
  800dfa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e00:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e07:	e9 bc 00 00 00       	jmp    800ec8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e0c:	83 ec 08             	sub    $0x8,%esp
  800e0f:	ff 75 e8             	pushl  -0x18(%ebp)
  800e12:	8d 45 14             	lea    0x14(%ebp),%eax
  800e15:	50                   	push   %eax
  800e16:	e8 84 fc ff ff       	call   800a9f <getuint>
  800e1b:	83 c4 10             	add    $0x10,%esp
  800e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e21:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e24:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2b:	e9 98 00 00 00       	jmp    800ec8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e30:	83 ec 08             	sub    $0x8,%esp
  800e33:	ff 75 0c             	pushl  0xc(%ebp)
  800e36:	6a 58                	push   $0x58
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	ff d0                	call   *%eax
  800e3d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e40:	83 ec 08             	sub    $0x8,%esp
  800e43:	ff 75 0c             	pushl  0xc(%ebp)
  800e46:	6a 58                	push   $0x58
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e50:	83 ec 08             	sub    $0x8,%esp
  800e53:	ff 75 0c             	pushl  0xc(%ebp)
  800e56:	6a 58                	push   $0x58
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	ff d0                	call   *%eax
  800e5d:	83 c4 10             	add    $0x10,%esp
			break;
  800e60:	e9 bc 00 00 00       	jmp    800f21 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	6a 30                	push   $0x30
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e75:	83 ec 08             	sub    $0x8,%esp
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	6a 78                	push   $0x78
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	ff d0                	call   *%eax
  800e82:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e85:	8b 45 14             	mov    0x14(%ebp),%eax
  800e88:	83 c0 04             	add    $0x4,%eax
  800e8b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e91:	83 e8 04             	sub    $0x4,%eax
  800e94:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ea0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ea7:	eb 1f                	jmp    800ec8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ea9:	83 ec 08             	sub    $0x8,%esp
  800eac:	ff 75 e8             	pushl  -0x18(%ebp)
  800eaf:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb2:	50                   	push   %eax
  800eb3:	e8 e7 fb ff ff       	call   800a9f <getuint>
  800eb8:	83 c4 10             	add    $0x10,%esp
  800ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ec1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ec8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ecc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ecf:	83 ec 04             	sub    $0x4,%esp
  800ed2:	52                   	push   %edx
  800ed3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ed6:	50                   	push   %eax
  800ed7:	ff 75 f4             	pushl  -0xc(%ebp)
  800eda:	ff 75 f0             	pushl  -0x10(%ebp)
  800edd:	ff 75 0c             	pushl  0xc(%ebp)
  800ee0:	ff 75 08             	pushl  0x8(%ebp)
  800ee3:	e8 00 fb ff ff       	call   8009e8 <printnum>
  800ee8:	83 c4 20             	add    $0x20,%esp
			break;
  800eeb:	eb 34                	jmp    800f21 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eed:	83 ec 08             	sub    $0x8,%esp
  800ef0:	ff 75 0c             	pushl  0xc(%ebp)
  800ef3:	53                   	push   %ebx
  800ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef7:	ff d0                	call   *%eax
  800ef9:	83 c4 10             	add    $0x10,%esp
			break;
  800efc:	eb 23                	jmp    800f21 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800efe:	83 ec 08             	sub    $0x8,%esp
  800f01:	ff 75 0c             	pushl  0xc(%ebp)
  800f04:	6a 25                	push   $0x25
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	ff d0                	call   *%eax
  800f0b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f0e:	ff 4d 10             	decl   0x10(%ebp)
  800f11:	eb 03                	jmp    800f16 <vprintfmt+0x3b1>
  800f13:	ff 4d 10             	decl   0x10(%ebp)
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	48                   	dec    %eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	3c 25                	cmp    $0x25,%al
  800f1e:	75 f3                	jne    800f13 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f20:	90                   	nop
		}
	}
  800f21:	e9 47 fc ff ff       	jmp    800b6d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f26:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f27:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f2a:	5b                   	pop    %ebx
  800f2b:	5e                   	pop    %esi
  800f2c:	5d                   	pop    %ebp
  800f2d:	c3                   	ret    

00800f2e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
  800f31:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f34:	8d 45 10             	lea    0x10(%ebp),%eax
  800f37:	83 c0 04             	add    $0x4,%eax
  800f3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f40:	ff 75 f4             	pushl  -0xc(%ebp)
  800f43:	50                   	push   %eax
  800f44:	ff 75 0c             	pushl  0xc(%ebp)
  800f47:	ff 75 08             	pushl  0x8(%ebp)
  800f4a:	e8 16 fc ff ff       	call   800b65 <vprintfmt>
  800f4f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f52:	90                   	nop
  800f53:	c9                   	leave  
  800f54:	c3                   	ret    

00800f55 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f55:	55                   	push   %ebp
  800f56:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5b:	8b 40 08             	mov    0x8(%eax),%eax
  800f5e:	8d 50 01             	lea    0x1(%eax),%edx
  800f61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f64:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6a:	8b 10                	mov    (%eax),%edx
  800f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6f:	8b 40 04             	mov    0x4(%eax),%eax
  800f72:	39 c2                	cmp    %eax,%edx
  800f74:	73 12                	jae    800f88 <sprintputch+0x33>
		*b->buf++ = ch;
  800f76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f79:	8b 00                	mov    (%eax),%eax
  800f7b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f81:	89 0a                	mov    %ecx,(%edx)
  800f83:	8b 55 08             	mov    0x8(%ebp),%edx
  800f86:	88 10                	mov    %dl,(%eax)
}
  800f88:	90                   	nop
  800f89:	5d                   	pop    %ebp
  800f8a:	c3                   	ret    

00800f8b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	01 d0                	add    %edx,%eax
  800fa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb0:	74 06                	je     800fb8 <vsnprintf+0x2d>
  800fb2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb6:	7f 07                	jg     800fbf <vsnprintf+0x34>
		return -E_INVAL;
  800fb8:	b8 03 00 00 00       	mov    $0x3,%eax
  800fbd:	eb 20                	jmp    800fdf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fbf:	ff 75 14             	pushl  0x14(%ebp)
  800fc2:	ff 75 10             	pushl  0x10(%ebp)
  800fc5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fc8:	50                   	push   %eax
  800fc9:	68 55 0f 80 00       	push   $0x800f55
  800fce:	e8 92 fb ff ff       	call   800b65 <vprintfmt>
  800fd3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fd6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fd9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fdf:	c9                   	leave  
  800fe0:	c3                   	ret    

00800fe1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fe1:	55                   	push   %ebp
  800fe2:	89 e5                	mov    %esp,%ebp
  800fe4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fe7:	8d 45 10             	lea    0x10(%ebp),%eax
  800fea:	83 c0 04             	add    $0x4,%eax
  800fed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ff0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff6:	50                   	push   %eax
  800ff7:	ff 75 0c             	pushl  0xc(%ebp)
  800ffa:	ff 75 08             	pushl  0x8(%ebp)
  800ffd:	e8 89 ff ff ff       	call   800f8b <vsnprintf>
  801002:	83 c4 10             	add    $0x10,%esp
  801005:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801008:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801013:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801017:	74 13                	je     80102c <readline+0x1f>
		cprintf("%s", prompt);
  801019:	83 ec 08             	sub    $0x8,%esp
  80101c:	ff 75 08             	pushl  0x8(%ebp)
  80101f:	68 10 29 80 00       	push   $0x802910
  801024:	e8 62 f9 ff ff       	call   80098b <cprintf>
  801029:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80102c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801033:	83 ec 0c             	sub    $0xc,%esp
  801036:	6a 00                	push   $0x0
  801038:	e8 81 f5 ff ff       	call   8005be <iscons>
  80103d:	83 c4 10             	add    $0x10,%esp
  801040:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801043:	e8 28 f5 ff ff       	call   800570 <getchar>
  801048:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80104b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80104f:	79 22                	jns    801073 <readline+0x66>
			if (c != -E_EOF)
  801051:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801055:	0f 84 ad 00 00 00    	je     801108 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80105b:	83 ec 08             	sub    $0x8,%esp
  80105e:	ff 75 ec             	pushl  -0x14(%ebp)
  801061:	68 13 29 80 00       	push   $0x802913
  801066:	e8 20 f9 ff ff       	call   80098b <cprintf>
  80106b:	83 c4 10             	add    $0x10,%esp
			return;
  80106e:	e9 95 00 00 00       	jmp    801108 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801073:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801077:	7e 34                	jle    8010ad <readline+0xa0>
  801079:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801080:	7f 2b                	jg     8010ad <readline+0xa0>
			if (echoing)
  801082:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801086:	74 0e                	je     801096 <readline+0x89>
				cputchar(c);
  801088:	83 ec 0c             	sub    $0xc,%esp
  80108b:	ff 75 ec             	pushl  -0x14(%ebp)
  80108e:	e8 95 f4 ff ff       	call   800528 <cputchar>
  801093:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801096:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801099:	8d 50 01             	lea    0x1(%eax),%edx
  80109c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80109f:	89 c2                	mov    %eax,%edx
  8010a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a4:	01 d0                	add    %edx,%eax
  8010a6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010a9:	88 10                	mov    %dl,(%eax)
  8010ab:	eb 56                	jmp    801103 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010ad:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010b1:	75 1f                	jne    8010d2 <readline+0xc5>
  8010b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010b7:	7e 19                	jle    8010d2 <readline+0xc5>
			if (echoing)
  8010b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010bd:	74 0e                	je     8010cd <readline+0xc0>
				cputchar(c);
  8010bf:	83 ec 0c             	sub    $0xc,%esp
  8010c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8010c5:	e8 5e f4 ff ff       	call   800528 <cputchar>
  8010ca:	83 c4 10             	add    $0x10,%esp

			i--;
  8010cd:	ff 4d f4             	decl   -0xc(%ebp)
  8010d0:	eb 31                	jmp    801103 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8010d2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8010d6:	74 0a                	je     8010e2 <readline+0xd5>
  8010d8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8010dc:	0f 85 61 ff ff ff    	jne    801043 <readline+0x36>
			if (echoing)
  8010e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e6:	74 0e                	je     8010f6 <readline+0xe9>
				cputchar(c);
  8010e8:	83 ec 0c             	sub    $0xc,%esp
  8010eb:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ee:	e8 35 f4 ff ff       	call   800528 <cputchar>
  8010f3:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8010f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fc:	01 d0                	add    %edx,%eax
  8010fe:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801101:	eb 06                	jmp    801109 <readline+0xfc>
		}
	}
  801103:	e9 3b ff ff ff       	jmp    801043 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801108:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801109:	c9                   	leave  
  80110a:	c3                   	ret    

0080110b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
  80110e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801111:	e8 e3 0a 00 00       	call   801bf9 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801116:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80111a:	74 13                	je     80112f <atomic_readline+0x24>
		cprintf("%s", prompt);
  80111c:	83 ec 08             	sub    $0x8,%esp
  80111f:	ff 75 08             	pushl  0x8(%ebp)
  801122:	68 10 29 80 00       	push   $0x802910
  801127:	e8 5f f8 ff ff       	call   80098b <cprintf>
  80112c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80112f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801136:	83 ec 0c             	sub    $0xc,%esp
  801139:	6a 00                	push   $0x0
  80113b:	e8 7e f4 ff ff       	call   8005be <iscons>
  801140:	83 c4 10             	add    $0x10,%esp
  801143:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801146:	e8 25 f4 ff ff       	call   800570 <getchar>
  80114b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80114e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801152:	79 23                	jns    801177 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801154:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801158:	74 13                	je     80116d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80115a:	83 ec 08             	sub    $0x8,%esp
  80115d:	ff 75 ec             	pushl  -0x14(%ebp)
  801160:	68 13 29 80 00       	push   $0x802913
  801165:	e8 21 f8 ff ff       	call   80098b <cprintf>
  80116a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80116d:	e8 a1 0a 00 00       	call   801c13 <sys_enable_interrupt>
			return;
  801172:	e9 9a 00 00 00       	jmp    801211 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801177:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80117b:	7e 34                	jle    8011b1 <atomic_readline+0xa6>
  80117d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801184:	7f 2b                	jg     8011b1 <atomic_readline+0xa6>
			if (echoing)
  801186:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80118a:	74 0e                	je     80119a <atomic_readline+0x8f>
				cputchar(c);
  80118c:	83 ec 0c             	sub    $0xc,%esp
  80118f:	ff 75 ec             	pushl  -0x14(%ebp)
  801192:	e8 91 f3 ff ff       	call   800528 <cputchar>
  801197:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80119a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80119d:	8d 50 01             	lea    0x1(%eax),%edx
  8011a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011a3:	89 c2                	mov    %eax,%edx
  8011a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a8:	01 d0                	add    %edx,%eax
  8011aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ad:	88 10                	mov    %dl,(%eax)
  8011af:	eb 5b                	jmp    80120c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011b1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011b5:	75 1f                	jne    8011d6 <atomic_readline+0xcb>
  8011b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011bb:	7e 19                	jle    8011d6 <atomic_readline+0xcb>
			if (echoing)
  8011bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c1:	74 0e                	je     8011d1 <atomic_readline+0xc6>
				cputchar(c);
  8011c3:	83 ec 0c             	sub    $0xc,%esp
  8011c6:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c9:	e8 5a f3 ff ff       	call   800528 <cputchar>
  8011ce:	83 c4 10             	add    $0x10,%esp
			i--;
  8011d1:	ff 4d f4             	decl   -0xc(%ebp)
  8011d4:	eb 36                	jmp    80120c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8011d6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011da:	74 0a                	je     8011e6 <atomic_readline+0xdb>
  8011dc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011e0:	0f 85 60 ff ff ff    	jne    801146 <atomic_readline+0x3b>
			if (echoing)
  8011e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ea:	74 0e                	je     8011fa <atomic_readline+0xef>
				cputchar(c);
  8011ec:	83 ec 0c             	sub    $0xc,%esp
  8011ef:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f2:	e8 31 f3 ff ff       	call   800528 <cputchar>
  8011f7:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8011fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801200:	01 d0                	add    %edx,%eax
  801202:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801205:	e8 09 0a 00 00       	call   801c13 <sys_enable_interrupt>
			return;
  80120a:	eb 05                	jmp    801211 <atomic_readline+0x106>
		}
	}
  80120c:	e9 35 ff ff ff       	jmp    801146 <atomic_readline+0x3b>
}
  801211:	c9                   	leave  
  801212:	c3                   	ret    

00801213 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801213:	55                   	push   %ebp
  801214:	89 e5                	mov    %esp,%ebp
  801216:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801219:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801220:	eb 06                	jmp    801228 <strlen+0x15>
		n++;
  801222:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801225:	ff 45 08             	incl   0x8(%ebp)
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	84 c0                	test   %al,%al
  80122f:	75 f1                	jne    801222 <strlen+0xf>
		n++;
	return n;
  801231:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801234:	c9                   	leave  
  801235:	c3                   	ret    

00801236 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801236:	55                   	push   %ebp
  801237:	89 e5                	mov    %esp,%ebp
  801239:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80123c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801243:	eb 09                	jmp    80124e <strnlen+0x18>
		n++;
  801245:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801248:	ff 45 08             	incl   0x8(%ebp)
  80124b:	ff 4d 0c             	decl   0xc(%ebp)
  80124e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801252:	74 09                	je     80125d <strnlen+0x27>
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	84 c0                	test   %al,%al
  80125b:	75 e8                	jne    801245 <strnlen+0xf>
		n++;
	return n;
  80125d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
  801265:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80126e:	90                   	nop
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8d 50 01             	lea    0x1(%eax),%edx
  801275:	89 55 08             	mov    %edx,0x8(%ebp)
  801278:	8b 55 0c             	mov    0xc(%ebp),%edx
  80127b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801281:	8a 12                	mov    (%edx),%dl
  801283:	88 10                	mov    %dl,(%eax)
  801285:	8a 00                	mov    (%eax),%al
  801287:	84 c0                	test   %al,%al
  801289:	75 e4                	jne    80126f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80128b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80129c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a3:	eb 1f                	jmp    8012c4 <strncpy+0x34>
		*dst++ = *src;
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8d 50 01             	lea    0x1(%eax),%edx
  8012ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b1:	8a 12                	mov    (%edx),%dl
  8012b3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	84 c0                	test   %al,%al
  8012bc:	74 03                	je     8012c1 <strncpy+0x31>
			src++;
  8012be:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012c1:	ff 45 fc             	incl   -0x4(%ebp)
  8012c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012ca:	72 d9                	jb     8012a5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012cf:	c9                   	leave  
  8012d0:	c3                   	ret    

008012d1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
  8012d4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e1:	74 30                	je     801313 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012e3:	eb 16                	jmp    8012fb <strlcpy+0x2a>
			*dst++ = *src++;
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	8d 50 01             	lea    0x1(%eax),%edx
  8012eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012f7:	8a 12                	mov    (%edx),%dl
  8012f9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012fb:	ff 4d 10             	decl   0x10(%ebp)
  8012fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801302:	74 09                	je     80130d <strlcpy+0x3c>
  801304:	8b 45 0c             	mov    0xc(%ebp),%eax
  801307:	8a 00                	mov    (%eax),%al
  801309:	84 c0                	test   %al,%al
  80130b:	75 d8                	jne    8012e5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80130d:	8b 45 08             	mov    0x8(%ebp),%eax
  801310:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801313:	8b 55 08             	mov    0x8(%ebp),%edx
  801316:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801319:	29 c2                	sub    %eax,%edx
  80131b:	89 d0                	mov    %edx,%eax
}
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801322:	eb 06                	jmp    80132a <strcmp+0xb>
		p++, q++;
  801324:	ff 45 08             	incl   0x8(%ebp)
  801327:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	84 c0                	test   %al,%al
  801331:	74 0e                	je     801341 <strcmp+0x22>
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	8a 10                	mov    (%eax),%dl
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	38 c2                	cmp    %al,%dl
  80133f:	74 e3                	je     801324 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	0f b6 d0             	movzbl %al,%edx
  801349:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134c:	8a 00                	mov    (%eax),%al
  80134e:	0f b6 c0             	movzbl %al,%eax
  801351:	29 c2                	sub    %eax,%edx
  801353:	89 d0                	mov    %edx,%eax
}
  801355:	5d                   	pop    %ebp
  801356:	c3                   	ret    

00801357 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80135a:	eb 09                	jmp    801365 <strncmp+0xe>
		n--, p++, q++;
  80135c:	ff 4d 10             	decl   0x10(%ebp)
  80135f:	ff 45 08             	incl   0x8(%ebp)
  801362:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801365:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801369:	74 17                	je     801382 <strncmp+0x2b>
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	84 c0                	test   %al,%al
  801372:	74 0e                	je     801382 <strncmp+0x2b>
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 10                	mov    (%eax),%dl
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	38 c2                	cmp    %al,%dl
  801380:	74 da                	je     80135c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801382:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801386:	75 07                	jne    80138f <strncmp+0x38>
		return 0;
  801388:	b8 00 00 00 00       	mov    $0x0,%eax
  80138d:	eb 14                	jmp    8013a3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	0f b6 d0             	movzbl %al,%edx
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	0f b6 c0             	movzbl %al,%eax
  80139f:	29 c2                	sub    %eax,%edx
  8013a1:	89 d0                	mov    %edx,%eax
}
  8013a3:	5d                   	pop    %ebp
  8013a4:	c3                   	ret    

008013a5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
  8013a8:	83 ec 04             	sub    $0x4,%esp
  8013ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013b1:	eb 12                	jmp    8013c5 <strchr+0x20>
		if (*s == c)
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	8a 00                	mov    (%eax),%al
  8013b8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013bb:	75 05                	jne    8013c2 <strchr+0x1d>
			return (char *) s;
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	eb 11                	jmp    8013d3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013c2:	ff 45 08             	incl   0x8(%ebp)
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	84 c0                	test   %al,%al
  8013cc:	75 e5                	jne    8013b3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
  8013d8:	83 ec 04             	sub    $0x4,%esp
  8013db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013de:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e1:	eb 0d                	jmp    8013f0 <strfind+0x1b>
		if (*s == c)
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013eb:	74 0e                	je     8013fb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013ed:	ff 45 08             	incl   0x8(%ebp)
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	84 c0                	test   %al,%al
  8013f7:	75 ea                	jne    8013e3 <strfind+0xe>
  8013f9:	eb 01                	jmp    8013fc <strfind+0x27>
		if (*s == c)
			break;
  8013fb:	90                   	nop
	return (char *) s;
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
  801404:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80140d:	8b 45 10             	mov    0x10(%ebp),%eax
  801410:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801413:	eb 0e                	jmp    801423 <memset+0x22>
		*p++ = c;
  801415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801418:	8d 50 01             	lea    0x1(%eax),%edx
  80141b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80141e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801421:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801423:	ff 4d f8             	decl   -0x8(%ebp)
  801426:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80142a:	79 e9                	jns    801415 <memset+0x14>
		*p++ = c;

	return v;
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80142f:	c9                   	leave  
  801430:	c3                   	ret    

00801431 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
  801434:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801437:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801443:	eb 16                	jmp    80145b <memcpy+0x2a>
		*d++ = *s++;
  801445:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801448:	8d 50 01             	lea    0x1(%eax),%edx
  80144b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80144e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801451:	8d 4a 01             	lea    0x1(%edx),%ecx
  801454:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801457:	8a 12                	mov    (%edx),%dl
  801459:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80145b:	8b 45 10             	mov    0x10(%ebp),%eax
  80145e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801461:	89 55 10             	mov    %edx,0x10(%ebp)
  801464:	85 c0                	test   %eax,%eax
  801466:	75 dd                	jne    801445 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80147f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801482:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801485:	73 50                	jae    8014d7 <memmove+0x6a>
  801487:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148a:	8b 45 10             	mov    0x10(%ebp),%eax
  80148d:	01 d0                	add    %edx,%eax
  80148f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801492:	76 43                	jbe    8014d7 <memmove+0x6a>
		s += n;
  801494:	8b 45 10             	mov    0x10(%ebp),%eax
  801497:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80149a:	8b 45 10             	mov    0x10(%ebp),%eax
  80149d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014a0:	eb 10                	jmp    8014b2 <memmove+0x45>
			*--d = *--s;
  8014a2:	ff 4d f8             	decl   -0x8(%ebp)
  8014a5:	ff 4d fc             	decl   -0x4(%ebp)
  8014a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ab:	8a 10                	mov    (%eax),%dl
  8014ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014b8:	89 55 10             	mov    %edx,0x10(%ebp)
  8014bb:	85 c0                	test   %eax,%eax
  8014bd:	75 e3                	jne    8014a2 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014bf:	eb 23                	jmp    8014e4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c4:	8d 50 01             	lea    0x1(%eax),%edx
  8014c7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014d3:	8a 12                	mov    (%edx),%dl
  8014d5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e0:	85 c0                	test   %eax,%eax
  8014e2:	75 dd                	jne    8014c1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8014e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014fb:	eb 2a                	jmp    801527 <memcmp+0x3e>
		if (*s1 != *s2)
  8014fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801500:	8a 10                	mov    (%eax),%dl
  801502:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801505:	8a 00                	mov    (%eax),%al
  801507:	38 c2                	cmp    %al,%dl
  801509:	74 16                	je     801521 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80150b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150e:	8a 00                	mov    (%eax),%al
  801510:	0f b6 d0             	movzbl %al,%edx
  801513:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801516:	8a 00                	mov    (%eax),%al
  801518:	0f b6 c0             	movzbl %al,%eax
  80151b:	29 c2                	sub    %eax,%edx
  80151d:	89 d0                	mov    %edx,%eax
  80151f:	eb 18                	jmp    801539 <memcmp+0x50>
		s1++, s2++;
  801521:	ff 45 fc             	incl   -0x4(%ebp)
  801524:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801527:	8b 45 10             	mov    0x10(%ebp),%eax
  80152a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80152d:	89 55 10             	mov    %edx,0x10(%ebp)
  801530:	85 c0                	test   %eax,%eax
  801532:	75 c9                	jne    8014fd <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801534:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
  80153e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801541:	8b 55 08             	mov    0x8(%ebp),%edx
  801544:	8b 45 10             	mov    0x10(%ebp),%eax
  801547:	01 d0                	add    %edx,%eax
  801549:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80154c:	eb 15                	jmp    801563 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	0f b6 d0             	movzbl %al,%edx
  801556:	8b 45 0c             	mov    0xc(%ebp),%eax
  801559:	0f b6 c0             	movzbl %al,%eax
  80155c:	39 c2                	cmp    %eax,%edx
  80155e:	74 0d                	je     80156d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801560:	ff 45 08             	incl   0x8(%ebp)
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801569:	72 e3                	jb     80154e <memfind+0x13>
  80156b:	eb 01                	jmp    80156e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80156d:	90                   	nop
	return (void *) s;
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
  801576:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801579:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801580:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801587:	eb 03                	jmp    80158c <strtol+0x19>
		s++;
  801589:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	3c 20                	cmp    $0x20,%al
  801593:	74 f4                	je     801589 <strtol+0x16>
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	8a 00                	mov    (%eax),%al
  80159a:	3c 09                	cmp    $0x9,%al
  80159c:	74 eb                	je     801589 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	3c 2b                	cmp    $0x2b,%al
  8015a5:	75 05                	jne    8015ac <strtol+0x39>
		s++;
  8015a7:	ff 45 08             	incl   0x8(%ebp)
  8015aa:	eb 13                	jmp    8015bf <strtol+0x4c>
	else if (*s == '-')
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	8a 00                	mov    (%eax),%al
  8015b1:	3c 2d                	cmp    $0x2d,%al
  8015b3:	75 0a                	jne    8015bf <strtol+0x4c>
		s++, neg = 1;
  8015b5:	ff 45 08             	incl   0x8(%ebp)
  8015b8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015c3:	74 06                	je     8015cb <strtol+0x58>
  8015c5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015c9:	75 20                	jne    8015eb <strtol+0x78>
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	3c 30                	cmp    $0x30,%al
  8015d2:	75 17                	jne    8015eb <strtol+0x78>
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	40                   	inc    %eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	3c 78                	cmp    $0x78,%al
  8015dc:	75 0d                	jne    8015eb <strtol+0x78>
		s += 2, base = 16;
  8015de:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8015e2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8015e9:	eb 28                	jmp    801613 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8015eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ef:	75 15                	jne    801606 <strtol+0x93>
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	8a 00                	mov    (%eax),%al
  8015f6:	3c 30                	cmp    $0x30,%al
  8015f8:	75 0c                	jne    801606 <strtol+0x93>
		s++, base = 8;
  8015fa:	ff 45 08             	incl   0x8(%ebp)
  8015fd:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801604:	eb 0d                	jmp    801613 <strtol+0xa0>
	else if (base == 0)
  801606:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160a:	75 07                	jne    801613 <strtol+0xa0>
		base = 10;
  80160c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801613:	8b 45 08             	mov    0x8(%ebp),%eax
  801616:	8a 00                	mov    (%eax),%al
  801618:	3c 2f                	cmp    $0x2f,%al
  80161a:	7e 19                	jle    801635 <strtol+0xc2>
  80161c:	8b 45 08             	mov    0x8(%ebp),%eax
  80161f:	8a 00                	mov    (%eax),%al
  801621:	3c 39                	cmp    $0x39,%al
  801623:	7f 10                	jg     801635 <strtol+0xc2>
			dig = *s - '0';
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	0f be c0             	movsbl %al,%eax
  80162d:	83 e8 30             	sub    $0x30,%eax
  801630:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801633:	eb 42                	jmp    801677 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	3c 60                	cmp    $0x60,%al
  80163c:	7e 19                	jle    801657 <strtol+0xe4>
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	8a 00                	mov    (%eax),%al
  801643:	3c 7a                	cmp    $0x7a,%al
  801645:	7f 10                	jg     801657 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	8a 00                	mov    (%eax),%al
  80164c:	0f be c0             	movsbl %al,%eax
  80164f:	83 e8 57             	sub    $0x57,%eax
  801652:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801655:	eb 20                	jmp    801677 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	3c 40                	cmp    $0x40,%al
  80165e:	7e 39                	jle    801699 <strtol+0x126>
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	8a 00                	mov    (%eax),%al
  801665:	3c 5a                	cmp    $0x5a,%al
  801667:	7f 30                	jg     801699 <strtol+0x126>
			dig = *s - 'A' + 10;
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	0f be c0             	movsbl %al,%eax
  801671:	83 e8 37             	sub    $0x37,%eax
  801674:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801677:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80167d:	7d 19                	jge    801698 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80167f:	ff 45 08             	incl   0x8(%ebp)
  801682:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801685:	0f af 45 10          	imul   0x10(%ebp),%eax
  801689:	89 c2                	mov    %eax,%edx
  80168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80168e:	01 d0                	add    %edx,%eax
  801690:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801693:	e9 7b ff ff ff       	jmp    801613 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801698:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801699:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80169d:	74 08                	je     8016a7 <strtol+0x134>
		*endptr = (char *) s;
  80169f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8016a5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016ab:	74 07                	je     8016b4 <strtol+0x141>
  8016ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b0:	f7 d8                	neg    %eax
  8016b2:	eb 03                	jmp    8016b7 <strtol+0x144>
  8016b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016b7:	c9                   	leave  
  8016b8:	c3                   	ret    

008016b9 <ltostr>:

void
ltostr(long value, char *str)
{
  8016b9:	55                   	push   %ebp
  8016ba:	89 e5                	mov    %esp,%ebp
  8016bc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016d1:	79 13                	jns    8016e6 <ltostr+0x2d>
	{
		neg = 1;
  8016d3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8016da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016dd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8016e0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8016e3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8016ee:	99                   	cltd   
  8016ef:	f7 f9                	idiv   %ecx
  8016f1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f7:	8d 50 01             	lea    0x1(%eax),%edx
  8016fa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016fd:	89 c2                	mov    %eax,%edx
  8016ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801702:	01 d0                	add    %edx,%eax
  801704:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801707:	83 c2 30             	add    $0x30,%edx
  80170a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80170c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80170f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801714:	f7 e9                	imul   %ecx
  801716:	c1 fa 02             	sar    $0x2,%edx
  801719:	89 c8                	mov    %ecx,%eax
  80171b:	c1 f8 1f             	sar    $0x1f,%eax
  80171e:	29 c2                	sub    %eax,%edx
  801720:	89 d0                	mov    %edx,%eax
  801722:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801725:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801728:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80172d:	f7 e9                	imul   %ecx
  80172f:	c1 fa 02             	sar    $0x2,%edx
  801732:	89 c8                	mov    %ecx,%eax
  801734:	c1 f8 1f             	sar    $0x1f,%eax
  801737:	29 c2                	sub    %eax,%edx
  801739:	89 d0                	mov    %edx,%eax
  80173b:	c1 e0 02             	shl    $0x2,%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	01 c0                	add    %eax,%eax
  801742:	29 c1                	sub    %eax,%ecx
  801744:	89 ca                	mov    %ecx,%edx
  801746:	85 d2                	test   %edx,%edx
  801748:	75 9c                	jne    8016e6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80174a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801751:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801754:	48                   	dec    %eax
  801755:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801758:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80175c:	74 3d                	je     80179b <ltostr+0xe2>
		start = 1 ;
  80175e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801765:	eb 34                	jmp    80179b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801767:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80176a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176d:	01 d0                	add    %edx,%eax
  80176f:	8a 00                	mov    (%eax),%al
  801771:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801774:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	01 c2                	add    %eax,%edx
  80177c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80177f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801782:	01 c8                	add    %ecx,%eax
  801784:	8a 00                	mov    (%eax),%al
  801786:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801788:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80178b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178e:	01 c2                	add    %eax,%edx
  801790:	8a 45 eb             	mov    -0x15(%ebp),%al
  801793:	88 02                	mov    %al,(%edx)
		start++ ;
  801795:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801798:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017a1:	7c c4                	jl     801767 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a9:	01 d0                	add    %edx,%eax
  8017ab:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017ae:	90                   	nop
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
  8017b4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017b7:	ff 75 08             	pushl  0x8(%ebp)
  8017ba:	e8 54 fa ff ff       	call   801213 <strlen>
  8017bf:	83 c4 04             	add    $0x4,%esp
  8017c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017c5:	ff 75 0c             	pushl  0xc(%ebp)
  8017c8:	e8 46 fa ff ff       	call   801213 <strlen>
  8017cd:	83 c4 04             	add    $0x4,%esp
  8017d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8017da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017e1:	eb 17                	jmp    8017fa <strcconcat+0x49>
		final[s] = str1[s] ;
  8017e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e9:	01 c2                	add    %eax,%edx
  8017eb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	01 c8                	add    %ecx,%eax
  8017f3:	8a 00                	mov    (%eax),%al
  8017f5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017f7:	ff 45 fc             	incl   -0x4(%ebp)
  8017fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017fd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801800:	7c e1                	jl     8017e3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801802:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801809:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801810:	eb 1f                	jmp    801831 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801812:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801815:	8d 50 01             	lea    0x1(%eax),%edx
  801818:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80181b:	89 c2                	mov    %eax,%edx
  80181d:	8b 45 10             	mov    0x10(%ebp),%eax
  801820:	01 c2                	add    %eax,%edx
  801822:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801825:	8b 45 0c             	mov    0xc(%ebp),%eax
  801828:	01 c8                	add    %ecx,%eax
  80182a:	8a 00                	mov    (%eax),%al
  80182c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80182e:	ff 45 f8             	incl   -0x8(%ebp)
  801831:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801834:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801837:	7c d9                	jl     801812 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801839:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80183c:	8b 45 10             	mov    0x10(%ebp),%eax
  80183f:	01 d0                	add    %edx,%eax
  801841:	c6 00 00             	movb   $0x0,(%eax)
}
  801844:	90                   	nop
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80184a:	8b 45 14             	mov    0x14(%ebp),%eax
  80184d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801853:	8b 45 14             	mov    0x14(%ebp),%eax
  801856:	8b 00                	mov    (%eax),%eax
  801858:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80185f:	8b 45 10             	mov    0x10(%ebp),%eax
  801862:	01 d0                	add    %edx,%eax
  801864:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80186a:	eb 0c                	jmp    801878 <strsplit+0x31>
			*string++ = 0;
  80186c:	8b 45 08             	mov    0x8(%ebp),%eax
  80186f:	8d 50 01             	lea    0x1(%eax),%edx
  801872:	89 55 08             	mov    %edx,0x8(%ebp)
  801875:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	8a 00                	mov    (%eax),%al
  80187d:	84 c0                	test   %al,%al
  80187f:	74 18                	je     801899 <strsplit+0x52>
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	0f be c0             	movsbl %al,%eax
  801889:	50                   	push   %eax
  80188a:	ff 75 0c             	pushl  0xc(%ebp)
  80188d:	e8 13 fb ff ff       	call   8013a5 <strchr>
  801892:	83 c4 08             	add    $0x8,%esp
  801895:	85 c0                	test   %eax,%eax
  801897:	75 d3                	jne    80186c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801899:	8b 45 08             	mov    0x8(%ebp),%eax
  80189c:	8a 00                	mov    (%eax),%al
  80189e:	84 c0                	test   %al,%al
  8018a0:	74 5a                	je     8018fc <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a5:	8b 00                	mov    (%eax),%eax
  8018a7:	83 f8 0f             	cmp    $0xf,%eax
  8018aa:	75 07                	jne    8018b3 <strsplit+0x6c>
		{
			return 0;
  8018ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8018b1:	eb 66                	jmp    801919 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b6:	8b 00                	mov    (%eax),%eax
  8018b8:	8d 48 01             	lea    0x1(%eax),%ecx
  8018bb:	8b 55 14             	mov    0x14(%ebp),%edx
  8018be:	89 0a                	mov    %ecx,(%edx)
  8018c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ca:	01 c2                	add    %eax,%edx
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d1:	eb 03                	jmp    8018d6 <strsplit+0x8f>
			string++;
  8018d3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	8a 00                	mov    (%eax),%al
  8018db:	84 c0                	test   %al,%al
  8018dd:	74 8b                	je     80186a <strsplit+0x23>
  8018df:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e2:	8a 00                	mov    (%eax),%al
  8018e4:	0f be c0             	movsbl %al,%eax
  8018e7:	50                   	push   %eax
  8018e8:	ff 75 0c             	pushl  0xc(%ebp)
  8018eb:	e8 b5 fa ff ff       	call   8013a5 <strchr>
  8018f0:	83 c4 08             	add    $0x8,%esp
  8018f3:	85 c0                	test   %eax,%eax
  8018f5:	74 dc                	je     8018d3 <strsplit+0x8c>
			string++;
	}
  8018f7:	e9 6e ff ff ff       	jmp    80186a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018fc:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801900:	8b 00                	mov    (%eax),%eax
  801902:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801909:	8b 45 10             	mov    0x10(%ebp),%eax
  80190c:	01 d0                	add    %edx,%eax
  80190e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801914:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801919:	c9                   	leave  
  80191a:	c3                   	ret    

0080191b <malloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* malloc(uint32 size)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
  80191e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [9] User Heap malloc()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801921:	83 ec 04             	sub    $0x4,%esp
  801924:	68 24 29 80 00       	push   $0x802924
  801929:	6a 19                	push   $0x19
  80192b:	68 49 29 80 00       	push   $0x802949
  801930:	e8 a2 ed ff ff       	call   8006d7 <_panic>

00801935 <smalloc>:

	return NULL;
}

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
  801938:	83 ec 18             	sub    $0x18,%esp
  80193b:	8b 45 10             	mov    0x10(%ebp),%eax
  80193e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801941:	83 ec 04             	sub    $0x4,%esp
  801944:	68 58 29 80 00       	push   $0x802958
  801949:	6a 30                	push   $0x30
  80194b:	68 49 29 80 00       	push   $0x802949
  801950:	e8 82 ed ff ff       	call   8006d7 <_panic>

00801955 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
  801958:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  80195b:	83 ec 04             	sub    $0x4,%esp
  80195e:	68 77 29 80 00       	push   $0x802977
  801963:	6a 36                	push   $0x36
  801965:	68 49 29 80 00       	push   $0x802949
  80196a:	e8 68 ed ff ff       	call   8006d7 <_panic>

0080196f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
  801972:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801975:	83 ec 04             	sub    $0x4,%esp
  801978:	68 94 29 80 00       	push   $0x802994
  80197d:	6a 48                	push   $0x48
  80197f:	68 49 29 80 00       	push   $0x802949
  801984:	e8 4e ed ff ff       	call   8006d7 <_panic>

00801989 <sfree>:

}


void sfree(void* virtual_address)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  80198f:	83 ec 04             	sub    $0x4,%esp
  801992:	68 b7 29 80 00       	push   $0x8029b7
  801997:	6a 53                	push   $0x53
  801999:	68 49 29 80 00       	push   $0x802949
  80199e:	e8 34 ed ff ff       	call   8006d7 <_panic>

008019a3 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
  8019a6:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  8019a9:	83 ec 04             	sub    $0x4,%esp
  8019ac:	68 d4 29 80 00       	push   $0x8029d4
  8019b1:	6a 6c                	push   $0x6c
  8019b3:	68 49 29 80 00       	push   $0x802949
  8019b8:	e8 1a ed ff ff       	call   8006d7 <_panic>

008019bd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
  8019c0:	57                   	push   %edi
  8019c1:	56                   	push   %esi
  8019c2:	53                   	push   %ebx
  8019c3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019d2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019d5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019d8:	cd 30                	int    $0x30
  8019da:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019e0:	83 c4 10             	add    $0x10,%esp
  8019e3:	5b                   	pop    %ebx
  8019e4:	5e                   	pop    %esi
  8019e5:	5f                   	pop    %edi
  8019e6:	5d                   	pop    %ebp
  8019e7:	c3                   	ret    

008019e8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
  8019eb:	83 ec 04             	sub    $0x4,%esp
  8019ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8019f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	52                   	push   %edx
  801a00:	ff 75 0c             	pushl  0xc(%ebp)
  801a03:	50                   	push   %eax
  801a04:	6a 00                	push   $0x0
  801a06:	e8 b2 ff ff ff       	call   8019bd <syscall>
  801a0b:	83 c4 18             	add    $0x18,%esp
}
  801a0e:	90                   	nop
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 01                	push   $0x1
  801a20:	e8 98 ff ff ff       	call   8019bd <syscall>
  801a25:	83 c4 18             	add    $0x18,%esp
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	50                   	push   %eax
  801a39:	6a 05                	push   $0x5
  801a3b:	e8 7d ff ff ff       	call   8019bd <syscall>
  801a40:	83 c4 18             	add    $0x18,%esp
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 02                	push   $0x2
  801a54:	e8 64 ff ff ff       	call   8019bd <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 03                	push   $0x3
  801a6d:	e8 4b ff ff ff       	call   8019bd <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 04                	push   $0x4
  801a86:	e8 32 ff ff ff       	call   8019bd <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_env_exit>:


void sys_env_exit(void)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 06                	push   $0x6
  801a9f:	e8 19 ff ff ff       	call   8019bd <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
}
  801aa7:	90                   	nop
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801aad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	52                   	push   %edx
  801aba:	50                   	push   %eax
  801abb:	6a 07                	push   $0x7
  801abd:	e8 fb fe ff ff       	call   8019bd <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
  801aca:	56                   	push   %esi
  801acb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801acc:	8b 75 18             	mov    0x18(%ebp),%esi
  801acf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ad2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	56                   	push   %esi
  801adc:	53                   	push   %ebx
  801add:	51                   	push   %ecx
  801ade:	52                   	push   %edx
  801adf:	50                   	push   %eax
  801ae0:	6a 08                	push   $0x8
  801ae2:	e8 d6 fe ff ff       	call   8019bd <syscall>
  801ae7:	83 c4 18             	add    $0x18,%esp
}
  801aea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801aed:	5b                   	pop    %ebx
  801aee:	5e                   	pop    %esi
  801aef:	5d                   	pop    %ebp
  801af0:	c3                   	ret    

00801af1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801af4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	52                   	push   %edx
  801b01:	50                   	push   %eax
  801b02:	6a 09                	push   $0x9
  801b04:	e8 b4 fe ff ff       	call   8019bd <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
}
  801b0c:	c9                   	leave  
  801b0d:	c3                   	ret    

00801b0e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	ff 75 0c             	pushl  0xc(%ebp)
  801b1a:	ff 75 08             	pushl  0x8(%ebp)
  801b1d:	6a 0a                	push   $0xa
  801b1f:	e8 99 fe ff ff       	call   8019bd <syscall>
  801b24:	83 c4 18             	add    $0x18,%esp
}
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 0b                	push   $0xb
  801b38:	e8 80 fe ff ff       	call   8019bd <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 0c                	push   $0xc
  801b51:	e8 67 fe ff ff       	call   8019bd <syscall>
  801b56:	83 c4 18             	add    $0x18,%esp
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 0d                	push   $0xd
  801b6a:	e8 4e fe ff ff       	call   8019bd <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	ff 75 0c             	pushl  0xc(%ebp)
  801b80:	ff 75 08             	pushl  0x8(%ebp)
  801b83:	6a 11                	push   $0x11
  801b85:	e8 33 fe ff ff       	call   8019bd <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
	return;
  801b8d:	90                   	nop
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	ff 75 0c             	pushl  0xc(%ebp)
  801b9c:	ff 75 08             	pushl  0x8(%ebp)
  801b9f:	6a 12                	push   $0x12
  801ba1:	e8 17 fe ff ff       	call   8019bd <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba9:	90                   	nop
}
  801baa:	c9                   	leave  
  801bab:	c3                   	ret    

00801bac <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bac:	55                   	push   %ebp
  801bad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 0e                	push   $0xe
  801bbb:	e8 fd fd ff ff       	call   8019bd <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	ff 75 08             	pushl  0x8(%ebp)
  801bd3:	6a 0f                	push   $0xf
  801bd5:	e8 e3 fd ff ff       	call   8019bd <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 10                	push   $0x10
  801bee:	e8 ca fd ff ff       	call   8019bd <syscall>
  801bf3:	83 c4 18             	add    $0x18,%esp
}
  801bf6:	90                   	nop
  801bf7:	c9                   	leave  
  801bf8:	c3                   	ret    

00801bf9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801bf9:	55                   	push   %ebp
  801bfa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 14                	push   $0x14
  801c08:	e8 b0 fd ff ff       	call   8019bd <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
}
  801c10:	90                   	nop
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 15                	push   $0x15
  801c22:	e8 96 fd ff ff       	call   8019bd <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
}
  801c2a:	90                   	nop
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <sys_cputc>:


void
sys_cputc(const char c)
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
  801c30:	83 ec 04             	sub    $0x4,%esp
  801c33:	8b 45 08             	mov    0x8(%ebp),%eax
  801c36:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c39:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	50                   	push   %eax
  801c46:	6a 16                	push   $0x16
  801c48:	e8 70 fd ff ff       	call   8019bd <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
}
  801c50:	90                   	nop
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 17                	push   $0x17
  801c62:	e8 56 fd ff ff       	call   8019bd <syscall>
  801c67:	83 c4 18             	add    $0x18,%esp
}
  801c6a:	90                   	nop
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	ff 75 0c             	pushl  0xc(%ebp)
  801c7c:	50                   	push   %eax
  801c7d:	6a 18                	push   $0x18
  801c7f:	e8 39 fd ff ff       	call   8019bd <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	52                   	push   %edx
  801c99:	50                   	push   %eax
  801c9a:	6a 1b                	push   $0x1b
  801c9c:	e8 1c fd ff ff       	call   8019bd <syscall>
  801ca1:	83 c4 18             	add    $0x18,%esp
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ca9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cac:	8b 45 08             	mov    0x8(%ebp),%eax
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	52                   	push   %edx
  801cb6:	50                   	push   %eax
  801cb7:	6a 19                	push   $0x19
  801cb9:	e8 ff fc ff ff       	call   8019bd <syscall>
  801cbe:	83 c4 18             	add    $0x18,%esp
}
  801cc1:	90                   	nop
  801cc2:	c9                   	leave  
  801cc3:	c3                   	ret    

00801cc4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cc4:	55                   	push   %ebp
  801cc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cca:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	52                   	push   %edx
  801cd4:	50                   	push   %eax
  801cd5:	6a 1a                	push   $0x1a
  801cd7:	e8 e1 fc ff ff       	call   8019bd <syscall>
  801cdc:	83 c4 18             	add    $0x18,%esp
}
  801cdf:	90                   	nop
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
  801ce5:	83 ec 04             	sub    $0x4,%esp
  801ce8:	8b 45 10             	mov    0x10(%ebp),%eax
  801ceb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801cee:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801cf1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf8:	6a 00                	push   $0x0
  801cfa:	51                   	push   %ecx
  801cfb:	52                   	push   %edx
  801cfc:	ff 75 0c             	pushl  0xc(%ebp)
  801cff:	50                   	push   %eax
  801d00:	6a 1c                	push   $0x1c
  801d02:	e8 b6 fc ff ff       	call   8019bd <syscall>
  801d07:	83 c4 18             	add    $0x18,%esp
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d12:	8b 45 08             	mov    0x8(%ebp),%eax
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	52                   	push   %edx
  801d1c:	50                   	push   %eax
  801d1d:	6a 1d                	push   $0x1d
  801d1f:	e8 99 fc ff ff       	call   8019bd <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d32:	8b 45 08             	mov    0x8(%ebp),%eax
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	51                   	push   %ecx
  801d3a:	52                   	push   %edx
  801d3b:	50                   	push   %eax
  801d3c:	6a 1e                	push   $0x1e
  801d3e:	e8 7a fc ff ff       	call   8019bd <syscall>
  801d43:	83 c4 18             	add    $0x18,%esp
}
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	52                   	push   %edx
  801d58:	50                   	push   %eax
  801d59:	6a 1f                	push   $0x1f
  801d5b:	e8 5d fc ff ff       	call   8019bd <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 20                	push   $0x20
  801d74:	e8 44 fc ff ff       	call   8019bd <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801d81:	8b 45 08             	mov    0x8(%ebp),%eax
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	ff 75 10             	pushl  0x10(%ebp)
  801d8b:	ff 75 0c             	pushl  0xc(%ebp)
  801d8e:	50                   	push   %eax
  801d8f:	6a 21                	push   $0x21
  801d91:	e8 27 fc ff ff       	call   8019bd <syscall>
  801d96:	83 c4 18             	add    $0x18,%esp
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	50                   	push   %eax
  801daa:	6a 22                	push   $0x22
  801dac:	e8 0c fc ff ff       	call   8019bd <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	90                   	nop
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dba:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	50                   	push   %eax
  801dc6:	6a 23                	push   $0x23
  801dc8:	e8 f0 fb ff ff       	call   8019bd <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
}
  801dd0:	90                   	nop
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
  801dd6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801dd9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ddc:	8d 50 04             	lea    0x4(%eax),%edx
  801ddf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	52                   	push   %edx
  801de9:	50                   	push   %eax
  801dea:	6a 24                	push   $0x24
  801dec:	e8 cc fb ff ff       	call   8019bd <syscall>
  801df1:	83 c4 18             	add    $0x18,%esp
	return result;
  801df4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801df7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801dfa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dfd:	89 01                	mov    %eax,(%ecx)
  801dff:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e02:	8b 45 08             	mov    0x8(%ebp),%eax
  801e05:	c9                   	leave  
  801e06:	c2 04 00             	ret    $0x4

00801e09 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	ff 75 10             	pushl  0x10(%ebp)
  801e13:	ff 75 0c             	pushl  0xc(%ebp)
  801e16:	ff 75 08             	pushl  0x8(%ebp)
  801e19:	6a 13                	push   $0x13
  801e1b:	e8 9d fb ff ff       	call   8019bd <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
	return ;
  801e23:	90                   	nop
}
  801e24:	c9                   	leave  
  801e25:	c3                   	ret    

00801e26 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e26:	55                   	push   %ebp
  801e27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 25                	push   $0x25
  801e35:	e8 83 fb ff ff       	call   8019bd <syscall>
  801e3a:	83 c4 18             	add    $0x18,%esp
}
  801e3d:	c9                   	leave  
  801e3e:	c3                   	ret    

00801e3f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e3f:	55                   	push   %ebp
  801e40:	89 e5                	mov    %esp,%ebp
  801e42:	83 ec 04             	sub    $0x4,%esp
  801e45:	8b 45 08             	mov    0x8(%ebp),%eax
  801e48:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e4b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	50                   	push   %eax
  801e58:	6a 26                	push   $0x26
  801e5a:	e8 5e fb ff ff       	call   8019bd <syscall>
  801e5f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e62:	90                   	nop
}
  801e63:	c9                   	leave  
  801e64:	c3                   	ret    

00801e65 <rsttst>:
void rsttst()
{
  801e65:	55                   	push   %ebp
  801e66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 28                	push   $0x28
  801e74:	e8 44 fb ff ff       	call   8019bd <syscall>
  801e79:	83 c4 18             	add    $0x18,%esp
	return ;
  801e7c:	90                   	nop
}
  801e7d:	c9                   	leave  
  801e7e:	c3                   	ret    

00801e7f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e7f:	55                   	push   %ebp
  801e80:	89 e5                	mov    %esp,%ebp
  801e82:	83 ec 04             	sub    $0x4,%esp
  801e85:	8b 45 14             	mov    0x14(%ebp),%eax
  801e88:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e8b:	8b 55 18             	mov    0x18(%ebp),%edx
  801e8e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e92:	52                   	push   %edx
  801e93:	50                   	push   %eax
  801e94:	ff 75 10             	pushl  0x10(%ebp)
  801e97:	ff 75 0c             	pushl  0xc(%ebp)
  801e9a:	ff 75 08             	pushl  0x8(%ebp)
  801e9d:	6a 27                	push   $0x27
  801e9f:	e8 19 fb ff ff       	call   8019bd <syscall>
  801ea4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea7:	90                   	nop
}
  801ea8:	c9                   	leave  
  801ea9:	c3                   	ret    

00801eaa <chktst>:
void chktst(uint32 n)
{
  801eaa:	55                   	push   %ebp
  801eab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	ff 75 08             	pushl  0x8(%ebp)
  801eb8:	6a 29                	push   $0x29
  801eba:	e8 fe fa ff ff       	call   8019bd <syscall>
  801ebf:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec2:	90                   	nop
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <inctst>:

void inctst()
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 2a                	push   $0x2a
  801ed4:	e8 e4 fa ff ff       	call   8019bd <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
	return ;
  801edc:	90                   	nop
}
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <gettst>:
uint32 gettst()
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 2b                	push   $0x2b
  801eee:	e8 ca fa ff ff       	call   8019bd <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
  801efb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 2c                	push   $0x2c
  801f0a:	e8 ae fa ff ff       	call   8019bd <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
  801f12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f15:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f19:	75 07                	jne    801f22 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f1b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f20:	eb 05                	jmp    801f27 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
  801f2c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 2c                	push   $0x2c
  801f3b:	e8 7d fa ff ff       	call   8019bd <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
  801f43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f46:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f4a:	75 07                	jne    801f53 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f4c:	b8 01 00 00 00       	mov    $0x1,%eax
  801f51:	eb 05                	jmp    801f58 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f58:	c9                   	leave  
  801f59:	c3                   	ret    

00801f5a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f5a:	55                   	push   %ebp
  801f5b:	89 e5                	mov    %esp,%ebp
  801f5d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 2c                	push   $0x2c
  801f6c:	e8 4c fa ff ff       	call   8019bd <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
  801f74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f77:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f7b:	75 07                	jne    801f84 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f82:	eb 05                	jmp    801f89 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f84:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f89:	c9                   	leave  
  801f8a:	c3                   	ret    

00801f8b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f8b:	55                   	push   %ebp
  801f8c:	89 e5                	mov    %esp,%ebp
  801f8e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 2c                	push   $0x2c
  801f9d:	e8 1b fa ff ff       	call   8019bd <syscall>
  801fa2:	83 c4 18             	add    $0x18,%esp
  801fa5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fa8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fac:	75 07                	jne    801fb5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fae:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb3:	eb 05                	jmp    801fba <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	ff 75 08             	pushl  0x8(%ebp)
  801fca:	6a 2d                	push   $0x2d
  801fcc:	e8 ec f9 ff ff       	call   8019bd <syscall>
  801fd1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fd4:	90                   	nop
}
  801fd5:	c9                   	leave  
  801fd6:	c3                   	ret    
  801fd7:	90                   	nop

00801fd8 <__udivdi3>:
  801fd8:	55                   	push   %ebp
  801fd9:	57                   	push   %edi
  801fda:	56                   	push   %esi
  801fdb:	53                   	push   %ebx
  801fdc:	83 ec 1c             	sub    $0x1c,%esp
  801fdf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fe3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fe7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801feb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fef:	89 ca                	mov    %ecx,%edx
  801ff1:	89 f8                	mov    %edi,%eax
  801ff3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ff7:	85 f6                	test   %esi,%esi
  801ff9:	75 2d                	jne    802028 <__udivdi3+0x50>
  801ffb:	39 cf                	cmp    %ecx,%edi
  801ffd:	77 65                	ja     802064 <__udivdi3+0x8c>
  801fff:	89 fd                	mov    %edi,%ebp
  802001:	85 ff                	test   %edi,%edi
  802003:	75 0b                	jne    802010 <__udivdi3+0x38>
  802005:	b8 01 00 00 00       	mov    $0x1,%eax
  80200a:	31 d2                	xor    %edx,%edx
  80200c:	f7 f7                	div    %edi
  80200e:	89 c5                	mov    %eax,%ebp
  802010:	31 d2                	xor    %edx,%edx
  802012:	89 c8                	mov    %ecx,%eax
  802014:	f7 f5                	div    %ebp
  802016:	89 c1                	mov    %eax,%ecx
  802018:	89 d8                	mov    %ebx,%eax
  80201a:	f7 f5                	div    %ebp
  80201c:	89 cf                	mov    %ecx,%edi
  80201e:	89 fa                	mov    %edi,%edx
  802020:	83 c4 1c             	add    $0x1c,%esp
  802023:	5b                   	pop    %ebx
  802024:	5e                   	pop    %esi
  802025:	5f                   	pop    %edi
  802026:	5d                   	pop    %ebp
  802027:	c3                   	ret    
  802028:	39 ce                	cmp    %ecx,%esi
  80202a:	77 28                	ja     802054 <__udivdi3+0x7c>
  80202c:	0f bd fe             	bsr    %esi,%edi
  80202f:	83 f7 1f             	xor    $0x1f,%edi
  802032:	75 40                	jne    802074 <__udivdi3+0x9c>
  802034:	39 ce                	cmp    %ecx,%esi
  802036:	72 0a                	jb     802042 <__udivdi3+0x6a>
  802038:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80203c:	0f 87 9e 00 00 00    	ja     8020e0 <__udivdi3+0x108>
  802042:	b8 01 00 00 00       	mov    $0x1,%eax
  802047:	89 fa                	mov    %edi,%edx
  802049:	83 c4 1c             	add    $0x1c,%esp
  80204c:	5b                   	pop    %ebx
  80204d:	5e                   	pop    %esi
  80204e:	5f                   	pop    %edi
  80204f:	5d                   	pop    %ebp
  802050:	c3                   	ret    
  802051:	8d 76 00             	lea    0x0(%esi),%esi
  802054:	31 ff                	xor    %edi,%edi
  802056:	31 c0                	xor    %eax,%eax
  802058:	89 fa                	mov    %edi,%edx
  80205a:	83 c4 1c             	add    $0x1c,%esp
  80205d:	5b                   	pop    %ebx
  80205e:	5e                   	pop    %esi
  80205f:	5f                   	pop    %edi
  802060:	5d                   	pop    %ebp
  802061:	c3                   	ret    
  802062:	66 90                	xchg   %ax,%ax
  802064:	89 d8                	mov    %ebx,%eax
  802066:	f7 f7                	div    %edi
  802068:	31 ff                	xor    %edi,%edi
  80206a:	89 fa                	mov    %edi,%edx
  80206c:	83 c4 1c             	add    $0x1c,%esp
  80206f:	5b                   	pop    %ebx
  802070:	5e                   	pop    %esi
  802071:	5f                   	pop    %edi
  802072:	5d                   	pop    %ebp
  802073:	c3                   	ret    
  802074:	bd 20 00 00 00       	mov    $0x20,%ebp
  802079:	89 eb                	mov    %ebp,%ebx
  80207b:	29 fb                	sub    %edi,%ebx
  80207d:	89 f9                	mov    %edi,%ecx
  80207f:	d3 e6                	shl    %cl,%esi
  802081:	89 c5                	mov    %eax,%ebp
  802083:	88 d9                	mov    %bl,%cl
  802085:	d3 ed                	shr    %cl,%ebp
  802087:	89 e9                	mov    %ebp,%ecx
  802089:	09 f1                	or     %esi,%ecx
  80208b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80208f:	89 f9                	mov    %edi,%ecx
  802091:	d3 e0                	shl    %cl,%eax
  802093:	89 c5                	mov    %eax,%ebp
  802095:	89 d6                	mov    %edx,%esi
  802097:	88 d9                	mov    %bl,%cl
  802099:	d3 ee                	shr    %cl,%esi
  80209b:	89 f9                	mov    %edi,%ecx
  80209d:	d3 e2                	shl    %cl,%edx
  80209f:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020a3:	88 d9                	mov    %bl,%cl
  8020a5:	d3 e8                	shr    %cl,%eax
  8020a7:	09 c2                	or     %eax,%edx
  8020a9:	89 d0                	mov    %edx,%eax
  8020ab:	89 f2                	mov    %esi,%edx
  8020ad:	f7 74 24 0c          	divl   0xc(%esp)
  8020b1:	89 d6                	mov    %edx,%esi
  8020b3:	89 c3                	mov    %eax,%ebx
  8020b5:	f7 e5                	mul    %ebp
  8020b7:	39 d6                	cmp    %edx,%esi
  8020b9:	72 19                	jb     8020d4 <__udivdi3+0xfc>
  8020bb:	74 0b                	je     8020c8 <__udivdi3+0xf0>
  8020bd:	89 d8                	mov    %ebx,%eax
  8020bf:	31 ff                	xor    %edi,%edi
  8020c1:	e9 58 ff ff ff       	jmp    80201e <__udivdi3+0x46>
  8020c6:	66 90                	xchg   %ax,%ax
  8020c8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020cc:	89 f9                	mov    %edi,%ecx
  8020ce:	d3 e2                	shl    %cl,%edx
  8020d0:	39 c2                	cmp    %eax,%edx
  8020d2:	73 e9                	jae    8020bd <__udivdi3+0xe5>
  8020d4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020d7:	31 ff                	xor    %edi,%edi
  8020d9:	e9 40 ff ff ff       	jmp    80201e <__udivdi3+0x46>
  8020de:	66 90                	xchg   %ax,%ax
  8020e0:	31 c0                	xor    %eax,%eax
  8020e2:	e9 37 ff ff ff       	jmp    80201e <__udivdi3+0x46>
  8020e7:	90                   	nop

008020e8 <__umoddi3>:
  8020e8:	55                   	push   %ebp
  8020e9:	57                   	push   %edi
  8020ea:	56                   	push   %esi
  8020eb:	53                   	push   %ebx
  8020ec:	83 ec 1c             	sub    $0x1c,%esp
  8020ef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020f3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020fb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802103:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802107:	89 f3                	mov    %esi,%ebx
  802109:	89 fa                	mov    %edi,%edx
  80210b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80210f:	89 34 24             	mov    %esi,(%esp)
  802112:	85 c0                	test   %eax,%eax
  802114:	75 1a                	jne    802130 <__umoddi3+0x48>
  802116:	39 f7                	cmp    %esi,%edi
  802118:	0f 86 a2 00 00 00    	jbe    8021c0 <__umoddi3+0xd8>
  80211e:	89 c8                	mov    %ecx,%eax
  802120:	89 f2                	mov    %esi,%edx
  802122:	f7 f7                	div    %edi
  802124:	89 d0                	mov    %edx,%eax
  802126:	31 d2                	xor    %edx,%edx
  802128:	83 c4 1c             	add    $0x1c,%esp
  80212b:	5b                   	pop    %ebx
  80212c:	5e                   	pop    %esi
  80212d:	5f                   	pop    %edi
  80212e:	5d                   	pop    %ebp
  80212f:	c3                   	ret    
  802130:	39 f0                	cmp    %esi,%eax
  802132:	0f 87 ac 00 00 00    	ja     8021e4 <__umoddi3+0xfc>
  802138:	0f bd e8             	bsr    %eax,%ebp
  80213b:	83 f5 1f             	xor    $0x1f,%ebp
  80213e:	0f 84 ac 00 00 00    	je     8021f0 <__umoddi3+0x108>
  802144:	bf 20 00 00 00       	mov    $0x20,%edi
  802149:	29 ef                	sub    %ebp,%edi
  80214b:	89 fe                	mov    %edi,%esi
  80214d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802151:	89 e9                	mov    %ebp,%ecx
  802153:	d3 e0                	shl    %cl,%eax
  802155:	89 d7                	mov    %edx,%edi
  802157:	89 f1                	mov    %esi,%ecx
  802159:	d3 ef                	shr    %cl,%edi
  80215b:	09 c7                	or     %eax,%edi
  80215d:	89 e9                	mov    %ebp,%ecx
  80215f:	d3 e2                	shl    %cl,%edx
  802161:	89 14 24             	mov    %edx,(%esp)
  802164:	89 d8                	mov    %ebx,%eax
  802166:	d3 e0                	shl    %cl,%eax
  802168:	89 c2                	mov    %eax,%edx
  80216a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80216e:	d3 e0                	shl    %cl,%eax
  802170:	89 44 24 04          	mov    %eax,0x4(%esp)
  802174:	8b 44 24 08          	mov    0x8(%esp),%eax
  802178:	89 f1                	mov    %esi,%ecx
  80217a:	d3 e8                	shr    %cl,%eax
  80217c:	09 d0                	or     %edx,%eax
  80217e:	d3 eb                	shr    %cl,%ebx
  802180:	89 da                	mov    %ebx,%edx
  802182:	f7 f7                	div    %edi
  802184:	89 d3                	mov    %edx,%ebx
  802186:	f7 24 24             	mull   (%esp)
  802189:	89 c6                	mov    %eax,%esi
  80218b:	89 d1                	mov    %edx,%ecx
  80218d:	39 d3                	cmp    %edx,%ebx
  80218f:	0f 82 87 00 00 00    	jb     80221c <__umoddi3+0x134>
  802195:	0f 84 91 00 00 00    	je     80222c <__umoddi3+0x144>
  80219b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80219f:	29 f2                	sub    %esi,%edx
  8021a1:	19 cb                	sbb    %ecx,%ebx
  8021a3:	89 d8                	mov    %ebx,%eax
  8021a5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021a9:	d3 e0                	shl    %cl,%eax
  8021ab:	89 e9                	mov    %ebp,%ecx
  8021ad:	d3 ea                	shr    %cl,%edx
  8021af:	09 d0                	or     %edx,%eax
  8021b1:	89 e9                	mov    %ebp,%ecx
  8021b3:	d3 eb                	shr    %cl,%ebx
  8021b5:	89 da                	mov    %ebx,%edx
  8021b7:	83 c4 1c             	add    $0x1c,%esp
  8021ba:	5b                   	pop    %ebx
  8021bb:	5e                   	pop    %esi
  8021bc:	5f                   	pop    %edi
  8021bd:	5d                   	pop    %ebp
  8021be:	c3                   	ret    
  8021bf:	90                   	nop
  8021c0:	89 fd                	mov    %edi,%ebp
  8021c2:	85 ff                	test   %edi,%edi
  8021c4:	75 0b                	jne    8021d1 <__umoddi3+0xe9>
  8021c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cb:	31 d2                	xor    %edx,%edx
  8021cd:	f7 f7                	div    %edi
  8021cf:	89 c5                	mov    %eax,%ebp
  8021d1:	89 f0                	mov    %esi,%eax
  8021d3:	31 d2                	xor    %edx,%edx
  8021d5:	f7 f5                	div    %ebp
  8021d7:	89 c8                	mov    %ecx,%eax
  8021d9:	f7 f5                	div    %ebp
  8021db:	89 d0                	mov    %edx,%eax
  8021dd:	e9 44 ff ff ff       	jmp    802126 <__umoddi3+0x3e>
  8021e2:	66 90                	xchg   %ax,%ax
  8021e4:	89 c8                	mov    %ecx,%eax
  8021e6:	89 f2                	mov    %esi,%edx
  8021e8:	83 c4 1c             	add    $0x1c,%esp
  8021eb:	5b                   	pop    %ebx
  8021ec:	5e                   	pop    %esi
  8021ed:	5f                   	pop    %edi
  8021ee:	5d                   	pop    %ebp
  8021ef:	c3                   	ret    
  8021f0:	3b 04 24             	cmp    (%esp),%eax
  8021f3:	72 06                	jb     8021fb <__umoddi3+0x113>
  8021f5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021f9:	77 0f                	ja     80220a <__umoddi3+0x122>
  8021fb:	89 f2                	mov    %esi,%edx
  8021fd:	29 f9                	sub    %edi,%ecx
  8021ff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802203:	89 14 24             	mov    %edx,(%esp)
  802206:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80220a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80220e:	8b 14 24             	mov    (%esp),%edx
  802211:	83 c4 1c             	add    $0x1c,%esp
  802214:	5b                   	pop    %ebx
  802215:	5e                   	pop    %esi
  802216:	5f                   	pop    %edi
  802217:	5d                   	pop    %ebp
  802218:	c3                   	ret    
  802219:	8d 76 00             	lea    0x0(%esi),%esi
  80221c:	2b 04 24             	sub    (%esp),%eax
  80221f:	19 fa                	sbb    %edi,%edx
  802221:	89 d1                	mov    %edx,%ecx
  802223:	89 c6                	mov    %eax,%esi
  802225:	e9 71 ff ff ff       	jmp    80219b <__umoddi3+0xb3>
  80222a:	66 90                	xchg   %ax,%ax
  80222c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802230:	72 ea                	jb     80221c <__umoddi3+0x134>
  802232:	89 d9                	mov    %ebx,%ecx
  802234:	e9 62 ff ff ff       	jmp    80219b <__umoddi3+0xb3>