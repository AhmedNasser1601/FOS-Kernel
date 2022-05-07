
obj/user/quicksort2:     file format elf32-i386


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
  800031:	e8 c9 05 00 00       	call   8005ff <libmain>
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
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 79 1c 00 00       	call   801cc7 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 8b 1c 00 00       	call   801ce0 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80005d:	e8 35 1d 00 00       	call   801d97 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 e0 23 80 00       	push   $0x8023e0
  800071:	e8 ce 0f 00 00       	call   801044 <readline>
  800076:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 1e 15 00 00       	call   8015aa <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 b1 18 00 00       	call   801952 <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		Elements[NumOfElements] = 10 ;
  8000a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000bc:	83 ec 0c             	sub    $0xc,%esp
  8000bf:	68 00 24 80 00       	push   $0x802400
  8000c4:	e8 f9 08 00 00       	call   8009c2 <cprintf>
  8000c9:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 23 24 80 00       	push   $0x802423
  8000d4:	e8 e9 08 00 00       	call   8009c2 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	68 31 24 80 00       	push   $0x802431
  8000e4:	e8 d9 08 00 00       	call   8009c2 <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\nSelect: ") ;
  8000ec:	83 ec 0c             	sub    $0xc,%esp
  8000ef:	68 40 24 80 00       	push   $0x802440
  8000f4:	e8 c9 08 00 00       	call   8009c2 <cprintf>
  8000f9:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  8000fc:	e8 a6 04 00 00       	call   8005a7 <getchar>
  800101:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  800104:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 4e 04 00 00       	call   80055f <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 41 04 00 00       	call   80055f <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800121:	e8 8b 1c 00 00       	call   801db1 <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800126:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012a:	83 f8 62             	cmp    $0x62,%eax
  80012d:	74 1d                	je     80014c <_main+0x114>
  80012f:	83 f8 63             	cmp    $0x63,%eax
  800132:	74 2b                	je     80015f <_main+0x127>
  800134:	83 f8 61             	cmp    $0x61,%eax
  800137:	75 39                	jne    800172 <_main+0x13a>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800139:	83 ec 08             	sub    $0x8,%esp
  80013c:	ff 75 ec             	pushl  -0x14(%ebp)
  80013f:	ff 75 e8             	pushl  -0x18(%ebp)
  800142:	e8 e0 02 00 00       	call   800427 <InitializeAscending>
  800147:	83 c4 10             	add    $0x10,%esp
			break ;
  80014a:	eb 37                	jmp    800183 <_main+0x14b>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	ff 75 ec             	pushl  -0x14(%ebp)
  800152:	ff 75 e8             	pushl  -0x18(%ebp)
  800155:	e8 fe 02 00 00       	call   800458 <InitializeDescending>
  80015a:	83 c4 10             	add    $0x10,%esp
			break ;
  80015d:	eb 24                	jmp    800183 <_main+0x14b>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80015f:	83 ec 08             	sub    $0x8,%esp
  800162:	ff 75 ec             	pushl  -0x14(%ebp)
  800165:	ff 75 e8             	pushl  -0x18(%ebp)
  800168:	e8 20 03 00 00       	call   80048d <InitializeSemiRandom>
  80016d:	83 c4 10             	add    $0x10,%esp
			break ;
  800170:	eb 11                	jmp    800183 <_main+0x14b>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800172:	83 ec 08             	sub    $0x8,%esp
  800175:	ff 75 ec             	pushl  -0x14(%ebp)
  800178:	ff 75 e8             	pushl  -0x18(%ebp)
  80017b:	e8 0d 03 00 00       	call   80048d <InitializeSemiRandom>
  800180:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 ec             	pushl  -0x14(%ebp)
  800189:	ff 75 e8             	pushl  -0x18(%ebp)
  80018c:	e8 db 00 00 00       	call   80026c <QuickSort>
  800191:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 ec             	pushl  -0x14(%ebp)
  80019a:	ff 75 e8             	pushl  -0x18(%ebp)
  80019d:	e8 db 01 00 00       	call   80037d <CheckSorted>
  8001a2:	83 c4 10             	add    $0x10,%esp
  8001a5:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001ac:	75 14                	jne    8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 58 24 80 00       	push   $0x802458
  8001b6:	6a 42                	push   $0x42
  8001b8:	68 7a 24 80 00       	push   $0x80247a
  8001bd:	e8 4c 05 00 00       	call   80070e <_panic>
		else
		{ 
			cprintf("\n===============================================\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 8c 24 80 00       	push   $0x80248c
  8001ca:	e8 f3 07 00 00       	call   8009c2 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 c0 24 80 00       	push   $0x8024c0
  8001da:	e8 e3 07 00 00       	call   8009c2 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e2:	83 ec 0c             	sub    $0xc,%esp
  8001e5:	68 f4 24 80 00       	push   $0x8024f4
  8001ea:	e8 d3 07 00 00       	call   8009c2 <cprintf>
  8001ef:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f2:	83 ec 0c             	sub    $0xc,%esp
  8001f5:	68 26 25 80 00       	push   $0x802526
  8001fa:	e8 c3 07 00 00       	call   8009c2 <cprintf>
  8001ff:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800202:	83 ec 0c             	sub    $0xc,%esp
  800205:	ff 75 e8             	pushl  -0x18(%ebp)
  800208:	e8 fd 18 00 00       	call   801b0a <free>
  80020d:	83 c4 10             	add    $0x10,%esp

		///========================================================================
	sys_disable_interrupt();
  800210:	e8 82 1b 00 00       	call   801d97 <sys_disable_interrupt>
		cprintf("Do you want to repeat (y/n): ") ;
  800215:	83 ec 0c             	sub    $0xc,%esp
  800218:	68 3c 25 80 00       	push   $0x80253c
  80021d:	e8 a0 07 00 00       	call   8009c2 <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  800225:	e8 7d 03 00 00       	call   8005a7 <getchar>
  80022a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80022d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800231:	83 ec 0c             	sub    $0xc,%esp
  800234:	50                   	push   %eax
  800235:	e8 25 03 00 00       	call   80055f <cputchar>
  80023a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023d:	83 ec 0c             	sub    $0xc,%esp
  800240:	6a 0a                	push   $0xa
  800242:	e8 18 03 00 00       	call   80055f <cputchar>
  800247:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	6a 0a                	push   $0xa
  80024f:	e8 0b 03 00 00       	call   80055f <cputchar>
  800254:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800257:	e8 55 1b 00 00       	call   801db1 <sys_enable_interrupt>

	} while (Chose == 'y');
  80025c:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800260:	0f 84 e3 fd ff ff    	je     800049 <_main+0x11>

}
  800266:	90                   	nop
  800267:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80026a:	c9                   	leave  
  80026b:	c3                   	ret    

0080026c <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80026c:	55                   	push   %ebp
  80026d:	89 e5                	mov    %esp,%ebp
  80026f:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800272:	8b 45 0c             	mov    0xc(%ebp),%eax
  800275:	48                   	dec    %eax
  800276:	50                   	push   %eax
  800277:	6a 00                	push   $0x0
  800279:	ff 75 0c             	pushl  0xc(%ebp)
  80027c:	ff 75 08             	pushl  0x8(%ebp)
  80027f:	e8 06 00 00 00       	call   80028a <QSort>
  800284:	83 c4 10             	add    $0x10,%esp
}
  800287:	90                   	nop
  800288:	c9                   	leave  
  800289:	c3                   	ret    

0080028a <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80028a:	55                   	push   %ebp
  80028b:	89 e5                	mov    %esp,%ebp
  80028d:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	3b 45 14             	cmp    0x14(%ebp),%eax
  800296:	0f 8d de 00 00 00    	jge    80037a <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  80029c:	8b 45 10             	mov    0x10(%ebp),%eax
  80029f:	40                   	inc    %eax
  8002a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8002a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a9:	e9 80 00 00 00       	jmp    80032e <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002ae:	ff 45 f4             	incl   -0xc(%ebp)
  8002b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b7:	7f 2b                	jg     8002e4 <QSort+0x5a>
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 d0                	add    %edx,%eax
  8002c8:	8b 10                	mov    (%eax),%edx
  8002ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d7:	01 c8                	add    %ecx,%eax
  8002d9:	8b 00                	mov    (%eax),%eax
  8002db:	39 c2                	cmp    %eax,%edx
  8002dd:	7d cf                	jge    8002ae <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002df:	eb 03                	jmp    8002e4 <QSort+0x5a>
  8002e1:	ff 4d f0             	decl   -0x10(%ebp)
  8002e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002ea:	7e 26                	jle    800312 <QSort+0x88>
  8002ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 10                	mov    (%eax),%edx
  8002fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800300:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8b 00                	mov    (%eax),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	7e cf                	jle    8002e1 <QSort+0x57>

		if (i <= j)
  800312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800315:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800318:	7f 14                	jg     80032e <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80031a:	83 ec 04             	sub    $0x4,%esp
  80031d:	ff 75 f0             	pushl  -0x10(%ebp)
  800320:	ff 75 f4             	pushl  -0xc(%ebp)
  800323:	ff 75 08             	pushl  0x8(%ebp)
  800326:	e8 a9 00 00 00       	call   8003d4 <Swap>
  80032b:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800331:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800334:	0f 8e 77 ff ff ff    	jle    8002b1 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80033a:	83 ec 04             	sub    $0x4,%esp
  80033d:	ff 75 f0             	pushl  -0x10(%ebp)
  800340:	ff 75 10             	pushl  0x10(%ebp)
  800343:	ff 75 08             	pushl  0x8(%ebp)
  800346:	e8 89 00 00 00       	call   8003d4 <Swap>
  80034b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80034e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800351:	48                   	dec    %eax
  800352:	50                   	push   %eax
  800353:	ff 75 10             	pushl  0x10(%ebp)
  800356:	ff 75 0c             	pushl  0xc(%ebp)
  800359:	ff 75 08             	pushl  0x8(%ebp)
  80035c:	e8 29 ff ff ff       	call   80028a <QSort>
  800361:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800364:	ff 75 14             	pushl  0x14(%ebp)
  800367:	ff 75 f4             	pushl  -0xc(%ebp)
  80036a:	ff 75 0c             	pushl  0xc(%ebp)
  80036d:	ff 75 08             	pushl  0x8(%ebp)
  800370:	e8 15 ff ff ff       	call   80028a <QSort>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	eb 01                	jmp    80037b <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80037a:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80037b:	c9                   	leave  
  80037c:	c3                   	ret    

0080037d <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80037d:	55                   	push   %ebp
  80037e:	89 e5                	mov    %esp,%ebp
  800380:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800383:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80038a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800391:	eb 33                	jmp    8003c6 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800393:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800396:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	8b 10                	mov    (%eax),%edx
  8003a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a7:	40                   	inc    %eax
  8003a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	01 c8                	add    %ecx,%eax
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	39 c2                	cmp    %eax,%edx
  8003b8:	7e 09                	jle    8003c3 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003c1:	eb 0c                	jmp    8003cf <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003c3:	ff 45 f8             	incl   -0x8(%ebp)
  8003c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c9:	48                   	dec    %eax
  8003ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003cd:	7f c4                	jg     800393 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c2                	add    %eax,%edx
  8003fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800400:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	01 c8                	add    %ecx,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800410:	8b 45 10             	mov    0x10(%ebp),%eax
  800413:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 c2                	add    %eax,%edx
  80041f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800422:	89 02                	mov    %eax,(%edx)
}
  800424:	90                   	nop
  800425:	c9                   	leave  
  800426:	c3                   	ret    

00800427 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800427:	55                   	push   %ebp
  800428:	89 e5                	mov    %esp,%ebp
  80042a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80042d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800434:	eb 17                	jmp    80044d <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800439:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	01 c2                	add    %eax,%edx
  800445:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800448:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044a:	ff 45 fc             	incl   -0x4(%ebp)
  80044d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800450:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800453:	7c e1                	jl     800436 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800455:	90                   	nop
  800456:	c9                   	leave  
  800457:	c3                   	ret    

00800458 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800458:	55                   	push   %ebp
  800459:	89 e5                	mov    %esp,%ebp
  80045b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80045e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800465:	eb 1b                	jmp    800482 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800467:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	01 c2                	add    %eax,%edx
  800476:	8b 45 0c             	mov    0xc(%ebp),%eax
  800479:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80047c:	48                   	dec    %eax
  80047d:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047f:	ff 45 fc             	incl   -0x4(%ebp)
  800482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800485:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800488:	7c dd                	jl     800467 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800493:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800496:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80049b:	f7 e9                	imul   %ecx
  80049d:	c1 f9 1f             	sar    $0x1f,%ecx
  8004a0:	89 d0                	mov    %edx,%eax
  8004a2:	29 c8                	sub    %ecx,%eax
  8004a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004ae:	eb 1e                	jmp    8004ce <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c3:	99                   	cltd   
  8004c4:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c7:	89 d0                	mov    %edx,%eax
  8004c9:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004cb:	ff 45 fc             	incl   -0x4(%ebp)
  8004ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d4:	7c da                	jl     8004b0 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004d6:	90                   	nop
  8004d7:	c9                   	leave  
  8004d8:	c3                   	ret    

008004d9 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d9:	55                   	push   %ebp
  8004da:	89 e5                	mov    %esp,%ebp
  8004dc:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004df:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004ed:	eb 42                	jmp    800531 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004f2:	99                   	cltd   
  8004f3:	f7 7d f0             	idivl  -0x10(%ebp)
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	85 c0                	test   %eax,%eax
  8004fa:	75 10                	jne    80050c <PrintElements+0x33>
			cprintf("\n");
  8004fc:	83 ec 0c             	sub    $0xc,%esp
  8004ff:	68 5a 25 80 00       	push   $0x80255a
  800504:	e8 b9 04 00 00       	call   8009c2 <cprintf>
  800509:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80050c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800516:	8b 45 08             	mov    0x8(%ebp),%eax
  800519:	01 d0                	add    %edx,%eax
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	83 ec 08             	sub    $0x8,%esp
  800520:	50                   	push   %eax
  800521:	68 5c 25 80 00       	push   $0x80255c
  800526:	e8 97 04 00 00       	call   8009c2 <cprintf>
  80052b:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052e:	ff 45 f4             	incl   -0xc(%ebp)
  800531:	8b 45 0c             	mov    0xc(%ebp),%eax
  800534:	48                   	dec    %eax
  800535:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800538:	7f b5                	jg     8004ef <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80053a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80053d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	8b 00                	mov    (%eax),%eax
  80054b:	83 ec 08             	sub    $0x8,%esp
  80054e:	50                   	push   %eax
  80054f:	68 61 25 80 00       	push   $0x802561
  800554:	e8 69 04 00 00       	call   8009c2 <cprintf>
  800559:	83 c4 10             	add    $0x10,%esp

}
  80055c:	90                   	nop
  80055d:	c9                   	leave  
  80055e:	c3                   	ret    

0080055f <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80056b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80056f:	83 ec 0c             	sub    $0xc,%esp
  800572:	50                   	push   %eax
  800573:	e8 53 18 00 00       	call   801dcb <sys_cputc>
  800578:	83 c4 10             	add    $0x10,%esp
}
  80057b:	90                   	nop
  80057c:	c9                   	leave  
  80057d:	c3                   	ret    

0080057e <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80057e:	55                   	push   %ebp
  80057f:	89 e5                	mov    %esp,%ebp
  800581:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800584:	e8 0e 18 00 00       	call   801d97 <sys_disable_interrupt>
	char c = ch;
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800593:	83 ec 0c             	sub    $0xc,%esp
  800596:	50                   	push   %eax
  800597:	e8 2f 18 00 00       	call   801dcb <sys_cputc>
  80059c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80059f:	e8 0d 18 00 00       	call   801db1 <sys_enable_interrupt>
}
  8005a4:	90                   	nop
  8005a5:	c9                   	leave  
  8005a6:	c3                   	ret    

008005a7 <getchar>:

int
getchar(void)
{
  8005a7:	55                   	push   %ebp
  8005a8:	89 e5                	mov    %esp,%ebp
  8005aa:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005b4:	eb 08                	jmp    8005be <getchar+0x17>
	{
		c = sys_cgetc();
  8005b6:	e8 f4 15 00 00       	call   801baf <sys_cgetc>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c2:	74 f2                	je     8005b6 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005cf:	e8 c3 17 00 00       	call   801d97 <sys_disable_interrupt>
	int c=0;
  8005d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005db:	eb 08                	jmp    8005e5 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005dd:	e8 cd 15 00 00       	call   801baf <sys_cgetc>
  8005e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e9:	74 f2                	je     8005dd <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005eb:	e8 c1 17 00 00       	call   801db1 <sys_enable_interrupt>
	return c;
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005f3:	c9                   	leave  
  8005f4:	c3                   	ret    

008005f5 <iscons>:

int iscons(int fdnum)
{
  8005f5:	55                   	push   %ebp
  8005f6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005fd:	5d                   	pop    %ebp
  8005fe:	c3                   	ret    

008005ff <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ff:	55                   	push   %ebp
  800600:	89 e5                	mov    %esp,%ebp
  800602:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800605:	e8 f2 15 00 00       	call   801bfc <sys_getenvindex>
  80060a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80060d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800610:	89 d0                	mov    %edx,%eax
  800612:	c1 e0 02             	shl    $0x2,%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	01 c0                	add    %eax,%eax
  800619:	01 d0                	add    %edx,%eax
  80061b:	01 c0                	add    %eax,%eax
  80061d:	01 d0                	add    %edx,%eax
  80061f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800626:	01 d0                	add    %edx,%eax
  800628:	c1 e0 02             	shl    $0x2,%eax
  80062b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800630:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800635:	a1 24 30 80 00       	mov    0x803024,%eax
  80063a:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800640:	84 c0                	test   %al,%al
  800642:	74 0f                	je     800653 <libmain+0x54>
		binaryname = myEnv->prog_name;
  800644:	a1 24 30 80 00       	mov    0x803024,%eax
  800649:	05 f4 02 00 00       	add    $0x2f4,%eax
  80064e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800653:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800657:	7e 0a                	jle    800663 <libmain+0x64>
		binaryname = argv[0];
  800659:	8b 45 0c             	mov    0xc(%ebp),%eax
  80065c:	8b 00                	mov    (%eax),%eax
  80065e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800663:	83 ec 08             	sub    $0x8,%esp
  800666:	ff 75 0c             	pushl  0xc(%ebp)
  800669:	ff 75 08             	pushl  0x8(%ebp)
  80066c:	e8 c7 f9 ff ff       	call   800038 <_main>
  800671:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800674:	e8 1e 17 00 00       	call   801d97 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800679:	83 ec 0c             	sub    $0xc,%esp
  80067c:	68 80 25 80 00       	push   $0x802580
  800681:	e8 3c 03 00 00       	call   8009c2 <cprintf>
  800686:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800689:	a1 24 30 80 00       	mov    0x803024,%eax
  80068e:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800694:	a1 24 30 80 00       	mov    0x803024,%eax
  800699:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80069f:	83 ec 04             	sub    $0x4,%esp
  8006a2:	52                   	push   %edx
  8006a3:	50                   	push   %eax
  8006a4:	68 a8 25 80 00       	push   $0x8025a8
  8006a9:	e8 14 03 00 00       	call   8009c2 <cprintf>
  8006ae:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006b1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b6:	8b 80 38 03 00 00    	mov    0x338(%eax),%eax
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	50                   	push   %eax
  8006c0:	68 cd 25 80 00       	push   $0x8025cd
  8006c5:	e8 f8 02 00 00       	call   8009c2 <cprintf>
  8006ca:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006cd:	83 ec 0c             	sub    $0xc,%esp
  8006d0:	68 80 25 80 00       	push   $0x802580
  8006d5:	e8 e8 02 00 00       	call   8009c2 <cprintf>
  8006da:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006dd:	e8 cf 16 00 00       	call   801db1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e2:	e8 19 00 00 00       	call   800700 <exit>
}
  8006e7:	90                   	nop
  8006e8:	c9                   	leave  
  8006e9:	c3                   	ret    

008006ea <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
  8006ed:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f0:	83 ec 0c             	sub    $0xc,%esp
  8006f3:	6a 00                	push   $0x0
  8006f5:	e8 ce 14 00 00       	call   801bc8 <sys_env_destroy>
  8006fa:	83 c4 10             	add    $0x10,%esp
}
  8006fd:	90                   	nop
  8006fe:	c9                   	leave  
  8006ff:	c3                   	ret    

00800700 <exit>:

void
exit(void)
{
  800700:	55                   	push   %ebp
  800701:	89 e5                	mov    %esp,%ebp
  800703:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800706:	e8 23 15 00 00       	call   801c2e <sys_env_exit>
}
  80070b:	90                   	nop
  80070c:	c9                   	leave  
  80070d:	c3                   	ret    

0080070e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
  800711:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800714:	8d 45 10             	lea    0x10(%ebp),%eax
  800717:	83 c0 04             	add    $0x4,%eax
  80071a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80071d:	a1 38 30 80 00       	mov    0x803038,%eax
  800722:	85 c0                	test   %eax,%eax
  800724:	74 16                	je     80073c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800726:	a1 38 30 80 00       	mov    0x803038,%eax
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	50                   	push   %eax
  80072f:	68 e4 25 80 00       	push   $0x8025e4
  800734:	e8 89 02 00 00       	call   8009c2 <cprintf>
  800739:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80073c:	a1 00 30 80 00       	mov    0x803000,%eax
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	ff 75 08             	pushl  0x8(%ebp)
  800747:	50                   	push   %eax
  800748:	68 e9 25 80 00       	push   $0x8025e9
  80074d:	e8 70 02 00 00       	call   8009c2 <cprintf>
  800752:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800755:	8b 45 10             	mov    0x10(%ebp),%eax
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	ff 75 f4             	pushl  -0xc(%ebp)
  80075e:	50                   	push   %eax
  80075f:	e8 f3 01 00 00       	call   800957 <vcprintf>
  800764:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	6a 00                	push   $0x0
  80076c:	68 05 26 80 00       	push   $0x802605
  800771:	e8 e1 01 00 00       	call   800957 <vcprintf>
  800776:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800779:	e8 82 ff ff ff       	call   800700 <exit>

	// should not return here
	while (1) ;
  80077e:	eb fe                	jmp    80077e <_panic+0x70>

00800780 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800780:	55                   	push   %ebp
  800781:	89 e5                	mov    %esp,%ebp
  800783:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800786:	a1 24 30 80 00       	mov    0x803024,%eax
  80078b:	8b 50 74             	mov    0x74(%eax),%edx
  80078e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800791:	39 c2                	cmp    %eax,%edx
  800793:	74 14                	je     8007a9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800795:	83 ec 04             	sub    $0x4,%esp
  800798:	68 08 26 80 00       	push   $0x802608
  80079d:	6a 26                	push   $0x26
  80079f:	68 54 26 80 00       	push   $0x802654
  8007a4:	e8 65 ff ff ff       	call   80070e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007b7:	e9 c2 00 00 00       	jmp    80087e <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	01 d0                	add    %edx,%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	85 c0                	test   %eax,%eax
  8007cf:	75 08                	jne    8007d9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007d1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007d4:	e9 a2 00 00 00       	jmp    80087b <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007e7:	eb 69                	jmp    800852 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007e9:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ee:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007f4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007f7:	89 d0                	mov    %edx,%eax
  8007f9:	01 c0                	add    %eax,%eax
  8007fb:	01 d0                	add    %edx,%eax
  8007fd:	c1 e0 02             	shl    $0x2,%eax
  800800:	01 c8                	add    %ecx,%eax
  800802:	8a 40 04             	mov    0x4(%eax),%al
  800805:	84 c0                	test   %al,%al
  800807:	75 46                	jne    80084f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800809:	a1 24 30 80 00       	mov    0x803024,%eax
  80080e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800814:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800817:	89 d0                	mov    %edx,%eax
  800819:	01 c0                	add    %eax,%eax
  80081b:	01 d0                	add    %edx,%eax
  80081d:	c1 e0 02             	shl    $0x2,%eax
  800820:	01 c8                	add    %ecx,%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800827:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80082a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80082f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800831:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800834:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	01 c8                	add    %ecx,%eax
  800840:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800842:	39 c2                	cmp    %eax,%edx
  800844:	75 09                	jne    80084f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800846:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80084d:	eb 12                	jmp    800861 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80084f:	ff 45 e8             	incl   -0x18(%ebp)
  800852:	a1 24 30 80 00       	mov    0x803024,%eax
  800857:	8b 50 74             	mov    0x74(%eax),%edx
  80085a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80085d:	39 c2                	cmp    %eax,%edx
  80085f:	77 88                	ja     8007e9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800861:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800865:	75 14                	jne    80087b <CheckWSWithoutLastIndex+0xfb>
			panic(
  800867:	83 ec 04             	sub    $0x4,%esp
  80086a:	68 60 26 80 00       	push   $0x802660
  80086f:	6a 3a                	push   $0x3a
  800871:	68 54 26 80 00       	push   $0x802654
  800876:	e8 93 fe ff ff       	call   80070e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80087b:	ff 45 f0             	incl   -0x10(%ebp)
  80087e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800881:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800884:	0f 8c 32 ff ff ff    	jl     8007bc <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80088a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800891:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800898:	eb 26                	jmp    8008c0 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80089a:	a1 24 30 80 00       	mov    0x803024,%eax
  80089f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008a5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a8:	89 d0                	mov    %edx,%eax
  8008aa:	01 c0                	add    %eax,%eax
  8008ac:	01 d0                	add    %edx,%eax
  8008ae:	c1 e0 02             	shl    $0x2,%eax
  8008b1:	01 c8                	add    %ecx,%eax
  8008b3:	8a 40 04             	mov    0x4(%eax),%al
  8008b6:	3c 01                	cmp    $0x1,%al
  8008b8:	75 03                	jne    8008bd <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008ba:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008bd:	ff 45 e0             	incl   -0x20(%ebp)
  8008c0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c5:	8b 50 74             	mov    0x74(%eax),%edx
  8008c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008cb:	39 c2                	cmp    %eax,%edx
  8008cd:	77 cb                	ja     80089a <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d5:	74 14                	je     8008eb <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008d7:	83 ec 04             	sub    $0x4,%esp
  8008da:	68 b4 26 80 00       	push   $0x8026b4
  8008df:	6a 44                	push   $0x44
  8008e1:	68 54 26 80 00       	push   $0x802654
  8008e6:	e8 23 fe ff ff       	call   80070e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008eb:	90                   	nop
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f7:	8b 00                	mov    (%eax),%eax
  8008f9:	8d 48 01             	lea    0x1(%eax),%ecx
  8008fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ff:	89 0a                	mov    %ecx,(%edx)
  800901:	8b 55 08             	mov    0x8(%ebp),%edx
  800904:	88 d1                	mov    %dl,%cl
  800906:	8b 55 0c             	mov    0xc(%ebp),%edx
  800909:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80090d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800910:	8b 00                	mov    (%eax),%eax
  800912:	3d ff 00 00 00       	cmp    $0xff,%eax
  800917:	75 2c                	jne    800945 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800919:	a0 28 30 80 00       	mov    0x803028,%al
  80091e:	0f b6 c0             	movzbl %al,%eax
  800921:	8b 55 0c             	mov    0xc(%ebp),%edx
  800924:	8b 12                	mov    (%edx),%edx
  800926:	89 d1                	mov    %edx,%ecx
  800928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092b:	83 c2 08             	add    $0x8,%edx
  80092e:	83 ec 04             	sub    $0x4,%esp
  800931:	50                   	push   %eax
  800932:	51                   	push   %ecx
  800933:	52                   	push   %edx
  800934:	e8 4d 12 00 00       	call   801b86 <sys_cputs>
  800939:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80093c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800945:	8b 45 0c             	mov    0xc(%ebp),%eax
  800948:	8b 40 04             	mov    0x4(%eax),%eax
  80094b:	8d 50 01             	lea    0x1(%eax),%edx
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	89 50 04             	mov    %edx,0x4(%eax)
}
  800954:	90                   	nop
  800955:	c9                   	leave  
  800956:	c3                   	ret    

00800957 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800957:	55                   	push   %ebp
  800958:	89 e5                	mov    %esp,%ebp
  80095a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800960:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800967:	00 00 00 
	b.cnt = 0;
  80096a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800971:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800974:	ff 75 0c             	pushl  0xc(%ebp)
  800977:	ff 75 08             	pushl  0x8(%ebp)
  80097a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800980:	50                   	push   %eax
  800981:	68 ee 08 80 00       	push   $0x8008ee
  800986:	e8 11 02 00 00       	call   800b9c <vprintfmt>
  80098b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80098e:	a0 28 30 80 00       	mov    0x803028,%al
  800993:	0f b6 c0             	movzbl %al,%eax
  800996:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80099c:	83 ec 04             	sub    $0x4,%esp
  80099f:	50                   	push   %eax
  8009a0:	52                   	push   %edx
  8009a1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a7:	83 c0 08             	add    $0x8,%eax
  8009aa:	50                   	push   %eax
  8009ab:	e8 d6 11 00 00       	call   801b86 <sys_cputs>
  8009b0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009b3:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009ba:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009c0:	c9                   	leave  
  8009c1:	c3                   	ret    

008009c2 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c2:	55                   	push   %ebp
  8009c3:	89 e5                	mov    %esp,%ebp
  8009c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c8:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009cf:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	83 ec 08             	sub    $0x8,%esp
  8009db:	ff 75 f4             	pushl  -0xc(%ebp)
  8009de:	50                   	push   %eax
  8009df:	e8 73 ff ff ff       	call   800957 <vcprintf>
  8009e4:	83 c4 10             	add    $0x10,%esp
  8009e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ed:	c9                   	leave  
  8009ee:	c3                   	ret    

008009ef <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ef:	55                   	push   %ebp
  8009f0:	89 e5                	mov    %esp,%ebp
  8009f2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f5:	e8 9d 13 00 00       	call   801d97 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009fa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a00:	8b 45 08             	mov    0x8(%ebp),%eax
  800a03:	83 ec 08             	sub    $0x8,%esp
  800a06:	ff 75 f4             	pushl  -0xc(%ebp)
  800a09:	50                   	push   %eax
  800a0a:	e8 48 ff ff ff       	call   800957 <vcprintf>
  800a0f:	83 c4 10             	add    $0x10,%esp
  800a12:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a15:	e8 97 13 00 00       	call   801db1 <sys_enable_interrupt>
	return cnt;
  800a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a1d:	c9                   	leave  
  800a1e:	c3                   	ret    

00800a1f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a1f:	55                   	push   %ebp
  800a20:	89 e5                	mov    %esp,%ebp
  800a22:	53                   	push   %ebx
  800a23:	83 ec 14             	sub    $0x14,%esp
  800a26:	8b 45 10             	mov    0x10(%ebp),%eax
  800a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a32:	8b 45 18             	mov    0x18(%ebp),%eax
  800a35:	ba 00 00 00 00       	mov    $0x0,%edx
  800a3a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3d:	77 55                	ja     800a94 <printnum+0x75>
  800a3f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a42:	72 05                	jb     800a49 <printnum+0x2a>
  800a44:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a47:	77 4b                	ja     800a94 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a49:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a4c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a4f:	8b 45 18             	mov    0x18(%ebp),%eax
  800a52:	ba 00 00 00 00       	mov    $0x0,%edx
  800a57:	52                   	push   %edx
  800a58:	50                   	push   %eax
  800a59:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5f:	e8 14 17 00 00       	call   802178 <__udivdi3>
  800a64:	83 c4 10             	add    $0x10,%esp
  800a67:	83 ec 04             	sub    $0x4,%esp
  800a6a:	ff 75 20             	pushl  0x20(%ebp)
  800a6d:	53                   	push   %ebx
  800a6e:	ff 75 18             	pushl  0x18(%ebp)
  800a71:	52                   	push   %edx
  800a72:	50                   	push   %eax
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	ff 75 08             	pushl  0x8(%ebp)
  800a79:	e8 a1 ff ff ff       	call   800a1f <printnum>
  800a7e:	83 c4 20             	add    $0x20,%esp
  800a81:	eb 1a                	jmp    800a9d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a83:	83 ec 08             	sub    $0x8,%esp
  800a86:	ff 75 0c             	pushl  0xc(%ebp)
  800a89:	ff 75 20             	pushl  0x20(%ebp)
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	ff d0                	call   *%eax
  800a91:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a94:	ff 4d 1c             	decl   0x1c(%ebp)
  800a97:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a9b:	7f e6                	jg     800a83 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a9d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aa0:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aab:	53                   	push   %ebx
  800aac:	51                   	push   %ecx
  800aad:	52                   	push   %edx
  800aae:	50                   	push   %eax
  800aaf:	e8 d4 17 00 00       	call   802288 <__umoddi3>
  800ab4:	83 c4 10             	add    $0x10,%esp
  800ab7:	05 14 29 80 00       	add    $0x802914,%eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	0f be c0             	movsbl %al,%eax
  800ac1:	83 ec 08             	sub    $0x8,%esp
  800ac4:	ff 75 0c             	pushl  0xc(%ebp)
  800ac7:	50                   	push   %eax
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	ff d0                	call   *%eax
  800acd:	83 c4 10             	add    $0x10,%esp
}
  800ad0:	90                   	nop
  800ad1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ad4:	c9                   	leave  
  800ad5:	c3                   	ret    

00800ad6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad6:	55                   	push   %ebp
  800ad7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800add:	7e 1c                	jle    800afb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8b 00                	mov    (%eax),%eax
  800ae4:	8d 50 08             	lea    0x8(%eax),%edx
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	89 10                	mov    %edx,(%eax)
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	83 e8 08             	sub    $0x8,%eax
  800af4:	8b 50 04             	mov    0x4(%eax),%edx
  800af7:	8b 00                	mov    (%eax),%eax
  800af9:	eb 40                	jmp    800b3b <getuint+0x65>
	else if (lflag)
  800afb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aff:	74 1e                	je     800b1f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	8b 00                	mov    (%eax),%eax
  800b06:	8d 50 04             	lea    0x4(%eax),%edx
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	89 10                	mov    %edx,(%eax)
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	8b 00                	mov    (%eax),%eax
  800b13:	83 e8 04             	sub    $0x4,%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	ba 00 00 00 00       	mov    $0x0,%edx
  800b1d:	eb 1c                	jmp    800b3b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	8d 50 04             	lea    0x4(%eax),%edx
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	89 10                	mov    %edx,(%eax)
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	8b 00                	mov    (%eax),%eax
  800b31:	83 e8 04             	sub    $0x4,%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b3b:	5d                   	pop    %ebp
  800b3c:	c3                   	ret    

00800b3d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b3d:	55                   	push   %ebp
  800b3e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b40:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b44:	7e 1c                	jle    800b62 <getint+0x25>
		return va_arg(*ap, long long);
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	8d 50 08             	lea    0x8(%eax),%edx
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	89 10                	mov    %edx,(%eax)
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	83 e8 08             	sub    $0x8,%eax
  800b5b:	8b 50 04             	mov    0x4(%eax),%edx
  800b5e:	8b 00                	mov    (%eax),%eax
  800b60:	eb 38                	jmp    800b9a <getint+0x5d>
	else if (lflag)
  800b62:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b66:	74 1a                	je     800b82 <getint+0x45>
		return va_arg(*ap, long);
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8b 00                	mov    (%eax),%eax
  800b6d:	8d 50 04             	lea    0x4(%eax),%edx
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	89 10                	mov    %edx,(%eax)
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	83 e8 04             	sub    $0x4,%eax
  800b7d:	8b 00                	mov    (%eax),%eax
  800b7f:	99                   	cltd   
  800b80:	eb 18                	jmp    800b9a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	8d 50 04             	lea    0x4(%eax),%edx
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	89 10                	mov    %edx,(%eax)
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	83 e8 04             	sub    $0x4,%eax
  800b97:	8b 00                	mov    (%eax),%eax
  800b99:	99                   	cltd   
}
  800b9a:	5d                   	pop    %ebp
  800b9b:	c3                   	ret    

00800b9c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	56                   	push   %esi
  800ba0:	53                   	push   %ebx
  800ba1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba4:	eb 17                	jmp    800bbd <vprintfmt+0x21>
			if (ch == '\0')
  800ba6:	85 db                	test   %ebx,%ebx
  800ba8:	0f 84 af 03 00 00    	je     800f5d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bae:	83 ec 08             	sub    $0x8,%esp
  800bb1:	ff 75 0c             	pushl  0xc(%ebp)
  800bb4:	53                   	push   %ebx
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	ff d0                	call   *%eax
  800bba:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc0:	8d 50 01             	lea    0x1(%eax),%edx
  800bc3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f b6 d8             	movzbl %al,%ebx
  800bcb:	83 fb 25             	cmp    $0x25,%ebx
  800bce:	75 d6                	jne    800ba6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bd0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bd4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bdb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf3:	8d 50 01             	lea    0x1(%eax),%edx
  800bf6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f b6 d8             	movzbl %al,%ebx
  800bfe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c01:	83 f8 55             	cmp    $0x55,%eax
  800c04:	0f 87 2b 03 00 00    	ja     800f35 <vprintfmt+0x399>
  800c0a:	8b 04 85 38 29 80 00 	mov    0x802938(,%eax,4),%eax
  800c11:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c13:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c17:	eb d7                	jmp    800bf0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c19:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c1d:	eb d1                	jmp    800bf0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c26:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c29:	89 d0                	mov    %edx,%eax
  800c2b:	c1 e0 02             	shl    $0x2,%eax
  800c2e:	01 d0                	add    %edx,%eax
  800c30:	01 c0                	add    %eax,%eax
  800c32:	01 d8                	add    %ebx,%eax
  800c34:	83 e8 30             	sub    $0x30,%eax
  800c37:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3d:	8a 00                	mov    (%eax),%al
  800c3f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c42:	83 fb 2f             	cmp    $0x2f,%ebx
  800c45:	7e 3e                	jle    800c85 <vprintfmt+0xe9>
  800c47:	83 fb 39             	cmp    $0x39,%ebx
  800c4a:	7f 39                	jg     800c85 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c4c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c4f:	eb d5                	jmp    800c26 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c51:	8b 45 14             	mov    0x14(%ebp),%eax
  800c54:	83 c0 04             	add    $0x4,%eax
  800c57:	89 45 14             	mov    %eax,0x14(%ebp)
  800c5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5d:	83 e8 04             	sub    $0x4,%eax
  800c60:	8b 00                	mov    (%eax),%eax
  800c62:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c65:	eb 1f                	jmp    800c86 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c6b:	79 83                	jns    800bf0 <vprintfmt+0x54>
				width = 0;
  800c6d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c74:	e9 77 ff ff ff       	jmp    800bf0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c79:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c80:	e9 6b ff ff ff       	jmp    800bf0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c85:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c8a:	0f 89 60 ff ff ff    	jns    800bf0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c90:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c93:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c96:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c9d:	e9 4e ff ff ff       	jmp    800bf0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca5:	e9 46 ff ff ff       	jmp    800bf0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800caa:	8b 45 14             	mov    0x14(%ebp),%eax
  800cad:	83 c0 04             	add    $0x4,%eax
  800cb0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb6:	83 e8 04             	sub    $0x4,%eax
  800cb9:	8b 00                	mov    (%eax),%eax
  800cbb:	83 ec 08             	sub    $0x8,%esp
  800cbe:	ff 75 0c             	pushl  0xc(%ebp)
  800cc1:	50                   	push   %eax
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	ff d0                	call   *%eax
  800cc7:	83 c4 10             	add    $0x10,%esp
			break;
  800cca:	e9 89 02 00 00       	jmp    800f58 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ccf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd2:	83 c0 04             	add    $0x4,%eax
  800cd5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd8:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdb:	83 e8 04             	sub    $0x4,%eax
  800cde:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ce0:	85 db                	test   %ebx,%ebx
  800ce2:	79 02                	jns    800ce6 <vprintfmt+0x14a>
				err = -err;
  800ce4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce6:	83 fb 64             	cmp    $0x64,%ebx
  800ce9:	7f 0b                	jg     800cf6 <vprintfmt+0x15a>
  800ceb:	8b 34 9d 80 27 80 00 	mov    0x802780(,%ebx,4),%esi
  800cf2:	85 f6                	test   %esi,%esi
  800cf4:	75 19                	jne    800d0f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf6:	53                   	push   %ebx
  800cf7:	68 25 29 80 00       	push   $0x802925
  800cfc:	ff 75 0c             	pushl  0xc(%ebp)
  800cff:	ff 75 08             	pushl  0x8(%ebp)
  800d02:	e8 5e 02 00 00       	call   800f65 <printfmt>
  800d07:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d0a:	e9 49 02 00 00       	jmp    800f58 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d0f:	56                   	push   %esi
  800d10:	68 2e 29 80 00       	push   $0x80292e
  800d15:	ff 75 0c             	pushl  0xc(%ebp)
  800d18:	ff 75 08             	pushl  0x8(%ebp)
  800d1b:	e8 45 02 00 00       	call   800f65 <printfmt>
  800d20:	83 c4 10             	add    $0x10,%esp
			break;
  800d23:	e9 30 02 00 00       	jmp    800f58 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d28:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2b:	83 c0 04             	add    $0x4,%eax
  800d2e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d31:	8b 45 14             	mov    0x14(%ebp),%eax
  800d34:	83 e8 04             	sub    $0x4,%eax
  800d37:	8b 30                	mov    (%eax),%esi
  800d39:	85 f6                	test   %esi,%esi
  800d3b:	75 05                	jne    800d42 <vprintfmt+0x1a6>
				p = "(null)";
  800d3d:	be 31 29 80 00       	mov    $0x802931,%esi
			if (width > 0 && padc != '-')
  800d42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d46:	7e 6d                	jle    800db5 <vprintfmt+0x219>
  800d48:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d4c:	74 67                	je     800db5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d51:	83 ec 08             	sub    $0x8,%esp
  800d54:	50                   	push   %eax
  800d55:	56                   	push   %esi
  800d56:	e8 12 05 00 00       	call   80126d <strnlen>
  800d5b:	83 c4 10             	add    $0x10,%esp
  800d5e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d61:	eb 16                	jmp    800d79 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d63:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d67:	83 ec 08             	sub    $0x8,%esp
  800d6a:	ff 75 0c             	pushl  0xc(%ebp)
  800d6d:	50                   	push   %eax
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	ff d0                	call   *%eax
  800d73:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d76:	ff 4d e4             	decl   -0x1c(%ebp)
  800d79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7d:	7f e4                	jg     800d63 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7f:	eb 34                	jmp    800db5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d81:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d85:	74 1c                	je     800da3 <vprintfmt+0x207>
  800d87:	83 fb 1f             	cmp    $0x1f,%ebx
  800d8a:	7e 05                	jle    800d91 <vprintfmt+0x1f5>
  800d8c:	83 fb 7e             	cmp    $0x7e,%ebx
  800d8f:	7e 12                	jle    800da3 <vprintfmt+0x207>
					putch('?', putdat);
  800d91:	83 ec 08             	sub    $0x8,%esp
  800d94:	ff 75 0c             	pushl  0xc(%ebp)
  800d97:	6a 3f                	push   $0x3f
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	ff d0                	call   *%eax
  800d9e:	83 c4 10             	add    $0x10,%esp
  800da1:	eb 0f                	jmp    800db2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	53                   	push   %ebx
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db2:	ff 4d e4             	decl   -0x1c(%ebp)
  800db5:	89 f0                	mov    %esi,%eax
  800db7:	8d 70 01             	lea    0x1(%eax),%esi
  800dba:	8a 00                	mov    (%eax),%al
  800dbc:	0f be d8             	movsbl %al,%ebx
  800dbf:	85 db                	test   %ebx,%ebx
  800dc1:	74 24                	je     800de7 <vprintfmt+0x24b>
  800dc3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc7:	78 b8                	js     800d81 <vprintfmt+0x1e5>
  800dc9:	ff 4d e0             	decl   -0x20(%ebp)
  800dcc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd0:	79 af                	jns    800d81 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd2:	eb 13                	jmp    800de7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dd4:	83 ec 08             	sub    $0x8,%esp
  800dd7:	ff 75 0c             	pushl  0xc(%ebp)
  800dda:	6a 20                	push   $0x20
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	ff d0                	call   *%eax
  800de1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de4:	ff 4d e4             	decl   -0x1c(%ebp)
  800de7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800deb:	7f e7                	jg     800dd4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ded:	e9 66 01 00 00       	jmp    800f58 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df2:	83 ec 08             	sub    $0x8,%esp
  800df5:	ff 75 e8             	pushl  -0x18(%ebp)
  800df8:	8d 45 14             	lea    0x14(%ebp),%eax
  800dfb:	50                   	push   %eax
  800dfc:	e8 3c fd ff ff       	call   800b3d <getint>
  800e01:	83 c4 10             	add    $0x10,%esp
  800e04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e07:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e10:	85 d2                	test   %edx,%edx
  800e12:	79 23                	jns    800e37 <vprintfmt+0x29b>
				putch('-', putdat);
  800e14:	83 ec 08             	sub    $0x8,%esp
  800e17:	ff 75 0c             	pushl  0xc(%ebp)
  800e1a:	6a 2d                	push   $0x2d
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	ff d0                	call   *%eax
  800e21:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e24:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2a:	f7 d8                	neg    %eax
  800e2c:	83 d2 00             	adc    $0x0,%edx
  800e2f:	f7 da                	neg    %edx
  800e31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e34:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e37:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e3e:	e9 bc 00 00 00       	jmp    800eff <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	ff 75 e8             	pushl  -0x18(%ebp)
  800e49:	8d 45 14             	lea    0x14(%ebp),%eax
  800e4c:	50                   	push   %eax
  800e4d:	e8 84 fc ff ff       	call   800ad6 <getuint>
  800e52:	83 c4 10             	add    $0x10,%esp
  800e55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e62:	e9 98 00 00 00       	jmp    800eff <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e67:	83 ec 08             	sub    $0x8,%esp
  800e6a:	ff 75 0c             	pushl  0xc(%ebp)
  800e6d:	6a 58                	push   $0x58
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	ff d0                	call   *%eax
  800e74:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	6a 58                	push   $0x58
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	ff d0                	call   *%eax
  800e84:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e87:	83 ec 08             	sub    $0x8,%esp
  800e8a:	ff 75 0c             	pushl  0xc(%ebp)
  800e8d:	6a 58                	push   $0x58
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	ff d0                	call   *%eax
  800e94:	83 c4 10             	add    $0x10,%esp
			break;
  800e97:	e9 bc 00 00 00       	jmp    800f58 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	6a 30                	push   $0x30
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	ff d0                	call   *%eax
  800ea9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eac:	83 ec 08             	sub    $0x8,%esp
  800eaf:	ff 75 0c             	pushl  0xc(%ebp)
  800eb2:	6a 78                	push   $0x78
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	ff d0                	call   *%eax
  800eb9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ebc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebf:	83 c0 04             	add    $0x4,%eax
  800ec2:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec8:	83 e8 04             	sub    $0x4,%eax
  800ecb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ecd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ede:	eb 1f                	jmp    800eff <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee9:	50                   	push   %eax
  800eea:	e8 e7 fb ff ff       	call   800ad6 <getuint>
  800eef:	83 c4 10             	add    $0x10,%esp
  800ef2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eff:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f03:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f06:	83 ec 04             	sub    $0x4,%esp
  800f09:	52                   	push   %edx
  800f0a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f0d:	50                   	push   %eax
  800f0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f11:	ff 75 f0             	pushl  -0x10(%ebp)
  800f14:	ff 75 0c             	pushl  0xc(%ebp)
  800f17:	ff 75 08             	pushl  0x8(%ebp)
  800f1a:	e8 00 fb ff ff       	call   800a1f <printnum>
  800f1f:	83 c4 20             	add    $0x20,%esp
			break;
  800f22:	eb 34                	jmp    800f58 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f24:	83 ec 08             	sub    $0x8,%esp
  800f27:	ff 75 0c             	pushl  0xc(%ebp)
  800f2a:	53                   	push   %ebx
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	ff d0                	call   *%eax
  800f30:	83 c4 10             	add    $0x10,%esp
			break;
  800f33:	eb 23                	jmp    800f58 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f35:	83 ec 08             	sub    $0x8,%esp
  800f38:	ff 75 0c             	pushl  0xc(%ebp)
  800f3b:	6a 25                	push   $0x25
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	ff d0                	call   *%eax
  800f42:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f45:	ff 4d 10             	decl   0x10(%ebp)
  800f48:	eb 03                	jmp    800f4d <vprintfmt+0x3b1>
  800f4a:	ff 4d 10             	decl   0x10(%ebp)
  800f4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f50:	48                   	dec    %eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	3c 25                	cmp    $0x25,%al
  800f55:	75 f3                	jne    800f4a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f57:	90                   	nop
		}
	}
  800f58:	e9 47 fc ff ff       	jmp    800ba4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f5d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f61:	5b                   	pop    %ebx
  800f62:	5e                   	pop    %esi
  800f63:	5d                   	pop    %ebp
  800f64:	c3                   	ret    

00800f65 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f65:	55                   	push   %ebp
  800f66:	89 e5                	mov    %esp,%ebp
  800f68:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f6b:	8d 45 10             	lea    0x10(%ebp),%eax
  800f6e:	83 c0 04             	add    $0x4,%eax
  800f71:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f74:	8b 45 10             	mov    0x10(%ebp),%eax
  800f77:	ff 75 f4             	pushl  -0xc(%ebp)
  800f7a:	50                   	push   %eax
  800f7b:	ff 75 0c             	pushl  0xc(%ebp)
  800f7e:	ff 75 08             	pushl  0x8(%ebp)
  800f81:	e8 16 fc ff ff       	call   800b9c <vprintfmt>
  800f86:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f89:	90                   	nop
  800f8a:	c9                   	leave  
  800f8b:	c3                   	ret    

00800f8c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f8c:	55                   	push   %ebp
  800f8d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	8b 40 08             	mov    0x8(%eax),%eax
  800f95:	8d 50 01             	lea    0x1(%eax),%edx
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	8b 10                	mov    (%eax),%edx
  800fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa6:	8b 40 04             	mov    0x4(%eax),%eax
  800fa9:	39 c2                	cmp    %eax,%edx
  800fab:	73 12                	jae    800fbf <sprintputch+0x33>
		*b->buf++ = ch;
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	8b 00                	mov    (%eax),%eax
  800fb2:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb8:	89 0a                	mov    %ecx,(%edx)
  800fba:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbd:	88 10                	mov    %dl,(%eax)
}
  800fbf:	90                   	nop
  800fc0:	5d                   	pop    %ebp
  800fc1:	c3                   	ret    

00800fc2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc2:	55                   	push   %ebp
  800fc3:	89 e5                	mov    %esp,%ebp
  800fc5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	01 d0                	add    %edx,%eax
  800fd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fe3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe7:	74 06                	je     800fef <vsnprintf+0x2d>
  800fe9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fed:	7f 07                	jg     800ff6 <vsnprintf+0x34>
		return -E_INVAL;
  800fef:	b8 03 00 00 00       	mov    $0x3,%eax
  800ff4:	eb 20                	jmp    801016 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff6:	ff 75 14             	pushl  0x14(%ebp)
  800ff9:	ff 75 10             	pushl  0x10(%ebp)
  800ffc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fff:	50                   	push   %eax
  801000:	68 8c 0f 80 00       	push   $0x800f8c
  801005:	e8 92 fb ff ff       	call   800b9c <vprintfmt>
  80100a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80100d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801010:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801013:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801016:	c9                   	leave  
  801017:	c3                   	ret    

00801018 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80101e:	8d 45 10             	lea    0x10(%ebp),%eax
  801021:	83 c0 04             	add    $0x4,%eax
  801024:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801027:	8b 45 10             	mov    0x10(%ebp),%eax
  80102a:	ff 75 f4             	pushl  -0xc(%ebp)
  80102d:	50                   	push   %eax
  80102e:	ff 75 0c             	pushl  0xc(%ebp)
  801031:	ff 75 08             	pushl  0x8(%ebp)
  801034:	e8 89 ff ff ff       	call   800fc2 <vsnprintf>
  801039:	83 c4 10             	add    $0x10,%esp
  80103c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80103f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80104a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104e:	74 13                	je     801063 <readline+0x1f>
		cprintf("%s", prompt);
  801050:	83 ec 08             	sub    $0x8,%esp
  801053:	ff 75 08             	pushl  0x8(%ebp)
  801056:	68 90 2a 80 00       	push   $0x802a90
  80105b:	e8 62 f9 ff ff       	call   8009c2 <cprintf>
  801060:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801063:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80106a:	83 ec 0c             	sub    $0xc,%esp
  80106d:	6a 00                	push   $0x0
  80106f:	e8 81 f5 ff ff       	call   8005f5 <iscons>
  801074:	83 c4 10             	add    $0x10,%esp
  801077:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80107a:	e8 28 f5 ff ff       	call   8005a7 <getchar>
  80107f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801082:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801086:	79 22                	jns    8010aa <readline+0x66>
			if (c != -E_EOF)
  801088:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80108c:	0f 84 ad 00 00 00    	je     80113f <readline+0xfb>
				cprintf("read error: %e\n", c);
  801092:	83 ec 08             	sub    $0x8,%esp
  801095:	ff 75 ec             	pushl  -0x14(%ebp)
  801098:	68 93 2a 80 00       	push   $0x802a93
  80109d:	e8 20 f9 ff ff       	call   8009c2 <cprintf>
  8010a2:	83 c4 10             	add    $0x10,%esp
			return;
  8010a5:	e9 95 00 00 00       	jmp    80113f <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010aa:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010ae:	7e 34                	jle    8010e4 <readline+0xa0>
  8010b0:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010b7:	7f 2b                	jg     8010e4 <readline+0xa0>
			if (echoing)
  8010b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010bd:	74 0e                	je     8010cd <readline+0x89>
				cputchar(c);
  8010bf:	83 ec 0c             	sub    $0xc,%esp
  8010c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8010c5:	e8 95 f4 ff ff       	call   80055f <cputchar>
  8010ca:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d0:	8d 50 01             	lea    0x1(%eax),%edx
  8010d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010d6:	89 c2                	mov    %eax,%edx
  8010d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010db:	01 d0                	add    %edx,%eax
  8010dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e0:	88 10                	mov    %dl,(%eax)
  8010e2:	eb 56                	jmp    80113a <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010e4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010e8:	75 1f                	jne    801109 <readline+0xc5>
  8010ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010ee:	7e 19                	jle    801109 <readline+0xc5>
			if (echoing)
  8010f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010f4:	74 0e                	je     801104 <readline+0xc0>
				cputchar(c);
  8010f6:	83 ec 0c             	sub    $0xc,%esp
  8010f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8010fc:	e8 5e f4 ff ff       	call   80055f <cputchar>
  801101:	83 c4 10             	add    $0x10,%esp

			i--;
  801104:	ff 4d f4             	decl   -0xc(%ebp)
  801107:	eb 31                	jmp    80113a <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801109:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80110d:	74 0a                	je     801119 <readline+0xd5>
  80110f:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801113:	0f 85 61 ff ff ff    	jne    80107a <readline+0x36>
			if (echoing)
  801119:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80111d:	74 0e                	je     80112d <readline+0xe9>
				cputchar(c);
  80111f:	83 ec 0c             	sub    $0xc,%esp
  801122:	ff 75 ec             	pushl  -0x14(%ebp)
  801125:	e8 35 f4 ff ff       	call   80055f <cputchar>
  80112a:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80112d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801130:	8b 45 0c             	mov    0xc(%ebp),%eax
  801133:	01 d0                	add    %edx,%eax
  801135:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801138:	eb 06                	jmp    801140 <readline+0xfc>
		}
	}
  80113a:	e9 3b ff ff ff       	jmp    80107a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80113f:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801140:	c9                   	leave  
  801141:	c3                   	ret    

00801142 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801142:	55                   	push   %ebp
  801143:	89 e5                	mov    %esp,%ebp
  801145:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801148:	e8 4a 0c 00 00       	call   801d97 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80114d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801151:	74 13                	je     801166 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801153:	83 ec 08             	sub    $0x8,%esp
  801156:	ff 75 08             	pushl  0x8(%ebp)
  801159:	68 90 2a 80 00       	push   $0x802a90
  80115e:	e8 5f f8 ff ff       	call   8009c2 <cprintf>
  801163:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801166:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80116d:	83 ec 0c             	sub    $0xc,%esp
  801170:	6a 00                	push   $0x0
  801172:	e8 7e f4 ff ff       	call   8005f5 <iscons>
  801177:	83 c4 10             	add    $0x10,%esp
  80117a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80117d:	e8 25 f4 ff ff       	call   8005a7 <getchar>
  801182:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801185:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801189:	79 23                	jns    8011ae <atomic_readline+0x6c>
			if (c != -E_EOF)
  80118b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80118f:	74 13                	je     8011a4 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801191:	83 ec 08             	sub    $0x8,%esp
  801194:	ff 75 ec             	pushl  -0x14(%ebp)
  801197:	68 93 2a 80 00       	push   $0x802a93
  80119c:	e8 21 f8 ff ff       	call   8009c2 <cprintf>
  8011a1:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011a4:	e8 08 0c 00 00       	call   801db1 <sys_enable_interrupt>
			return;
  8011a9:	e9 9a 00 00 00       	jmp    801248 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011ae:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011b2:	7e 34                	jle    8011e8 <atomic_readline+0xa6>
  8011b4:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011bb:	7f 2b                	jg     8011e8 <atomic_readline+0xa6>
			if (echoing)
  8011bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c1:	74 0e                	je     8011d1 <atomic_readline+0x8f>
				cputchar(c);
  8011c3:	83 ec 0c             	sub    $0xc,%esp
  8011c6:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c9:	e8 91 f3 ff ff       	call   80055f <cputchar>
  8011ce:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d4:	8d 50 01             	lea    0x1(%eax),%edx
  8011d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011da:	89 c2                	mov    %eax,%edx
  8011dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011df:	01 d0                	add    %edx,%eax
  8011e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011e4:	88 10                	mov    %dl,(%eax)
  8011e6:	eb 5b                	jmp    801243 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011e8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011ec:	75 1f                	jne    80120d <atomic_readline+0xcb>
  8011ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011f2:	7e 19                	jle    80120d <atomic_readline+0xcb>
			if (echoing)
  8011f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f8:	74 0e                	je     801208 <atomic_readline+0xc6>
				cputchar(c);
  8011fa:	83 ec 0c             	sub    $0xc,%esp
  8011fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801200:	e8 5a f3 ff ff       	call   80055f <cputchar>
  801205:	83 c4 10             	add    $0x10,%esp
			i--;
  801208:	ff 4d f4             	decl   -0xc(%ebp)
  80120b:	eb 36                	jmp    801243 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80120d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801211:	74 0a                	je     80121d <atomic_readline+0xdb>
  801213:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801217:	0f 85 60 ff ff ff    	jne    80117d <atomic_readline+0x3b>
			if (echoing)
  80121d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801221:	74 0e                	je     801231 <atomic_readline+0xef>
				cputchar(c);
  801223:	83 ec 0c             	sub    $0xc,%esp
  801226:	ff 75 ec             	pushl  -0x14(%ebp)
  801229:	e8 31 f3 ff ff       	call   80055f <cputchar>
  80122e:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801231:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801234:	8b 45 0c             	mov    0xc(%ebp),%eax
  801237:	01 d0                	add    %edx,%eax
  801239:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80123c:	e8 70 0b 00 00       	call   801db1 <sys_enable_interrupt>
			return;
  801241:	eb 05                	jmp    801248 <atomic_readline+0x106>
		}
	}
  801243:	e9 35 ff ff ff       	jmp    80117d <atomic_readline+0x3b>
}
  801248:	c9                   	leave  
  801249:	c3                   	ret    

0080124a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80124a:	55                   	push   %ebp
  80124b:	89 e5                	mov    %esp,%ebp
  80124d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801250:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801257:	eb 06                	jmp    80125f <strlen+0x15>
		n++;
  801259:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80125c:	ff 45 08             	incl   0x8(%ebp)
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	84 c0                	test   %al,%al
  801266:	75 f1                	jne    801259 <strlen+0xf>
		n++;
	return n;
  801268:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126b:	c9                   	leave  
  80126c:	c3                   	ret    

0080126d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80126d:	55                   	push   %ebp
  80126e:	89 e5                	mov    %esp,%ebp
  801270:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801273:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127a:	eb 09                	jmp    801285 <strnlen+0x18>
		n++;
  80127c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80127f:	ff 45 08             	incl   0x8(%ebp)
  801282:	ff 4d 0c             	decl   0xc(%ebp)
  801285:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801289:	74 09                	je     801294 <strnlen+0x27>
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	84 c0                	test   %al,%al
  801292:	75 e8                	jne    80127c <strnlen+0xf>
		n++;
	return n;
  801294:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012a5:	90                   	nop
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8012af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012b8:	8a 12                	mov    (%edx),%dl
  8012ba:	88 10                	mov    %dl,(%eax)
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	84 c0                	test   %al,%al
  8012c0:	75 e4                	jne    8012a6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
  8012ca:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012da:	eb 1f                	jmp    8012fb <strncpy+0x34>
		*dst++ = *src;
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8d 50 01             	lea    0x1(%eax),%edx
  8012e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e8:	8a 12                	mov    (%edx),%dl
  8012ea:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	84 c0                	test   %al,%al
  8012f3:	74 03                	je     8012f8 <strncpy+0x31>
			src++;
  8012f5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012f8:	ff 45 fc             	incl   -0x4(%ebp)
  8012fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fe:	3b 45 10             	cmp    0x10(%ebp),%eax
  801301:	72 d9                	jb     8012dc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801314:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801318:	74 30                	je     80134a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80131a:	eb 16                	jmp    801332 <strlcpy+0x2a>
			*dst++ = *src++;
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	8d 50 01             	lea    0x1(%eax),%edx
  801322:	89 55 08             	mov    %edx,0x8(%ebp)
  801325:	8b 55 0c             	mov    0xc(%ebp),%edx
  801328:	8d 4a 01             	lea    0x1(%edx),%ecx
  80132b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80132e:	8a 12                	mov    (%edx),%dl
  801330:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801332:	ff 4d 10             	decl   0x10(%ebp)
  801335:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801339:	74 09                	je     801344 <strlcpy+0x3c>
  80133b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	84 c0                	test   %al,%al
  801342:	75 d8                	jne    80131c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80134a:	8b 55 08             	mov    0x8(%ebp),%edx
  80134d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801350:	29 c2                	sub    %eax,%edx
  801352:	89 d0                	mov    %edx,%eax
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801359:	eb 06                	jmp    801361 <strcmp+0xb>
		p++, q++;
  80135b:	ff 45 08             	incl   0x8(%ebp)
  80135e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	84 c0                	test   %al,%al
  801368:	74 0e                	je     801378 <strcmp+0x22>
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 10                	mov    (%eax),%dl
  80136f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	38 c2                	cmp    %al,%dl
  801376:	74 e3                	je     80135b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	0f b6 d0             	movzbl %al,%edx
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	8a 00                	mov    (%eax),%al
  801385:	0f b6 c0             	movzbl %al,%eax
  801388:	29 c2                	sub    %eax,%edx
  80138a:	89 d0                	mov    %edx,%eax
}
  80138c:	5d                   	pop    %ebp
  80138d:	c3                   	ret    

0080138e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80138e:	55                   	push   %ebp
  80138f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801391:	eb 09                	jmp    80139c <strncmp+0xe>
		n--, p++, q++;
  801393:	ff 4d 10             	decl   0x10(%ebp)
  801396:	ff 45 08             	incl   0x8(%ebp)
  801399:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80139c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a0:	74 17                	je     8013b9 <strncmp+0x2b>
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	84 c0                	test   %al,%al
  8013a9:	74 0e                	je     8013b9 <strncmp+0x2b>
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 10                	mov    (%eax),%dl
  8013b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	38 c2                	cmp    %al,%dl
  8013b7:	74 da                	je     801393 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013bd:	75 07                	jne    8013c6 <strncmp+0x38>
		return 0;
  8013bf:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c4:	eb 14                	jmp    8013da <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	0f b6 d0             	movzbl %al,%edx
  8013ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	0f b6 c0             	movzbl %al,%eax
  8013d6:	29 c2                	sub    %eax,%edx
  8013d8:	89 d0                	mov    %edx,%eax
}
  8013da:	5d                   	pop    %ebp
  8013db:	c3                   	ret    

008013dc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
  8013df:	83 ec 04             	sub    $0x4,%esp
  8013e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e8:	eb 12                	jmp    8013fc <strchr+0x20>
		if (*s == c)
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8a 00                	mov    (%eax),%al
  8013ef:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f2:	75 05                	jne    8013f9 <strchr+0x1d>
			return (char *) s;
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	eb 11                	jmp    80140a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	8a 00                	mov    (%eax),%al
  801401:	84 c0                	test   %al,%al
  801403:	75 e5                	jne    8013ea <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801405:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80140a:	c9                   	leave  
  80140b:	c3                   	ret    

0080140c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80140c:	55                   	push   %ebp
  80140d:	89 e5                	mov    %esp,%ebp
  80140f:	83 ec 04             	sub    $0x4,%esp
  801412:	8b 45 0c             	mov    0xc(%ebp),%eax
  801415:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801418:	eb 0d                	jmp    801427 <strfind+0x1b>
		if (*s == c)
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801422:	74 0e                	je     801432 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801424:	ff 45 08             	incl   0x8(%ebp)
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	8a 00                	mov    (%eax),%al
  80142c:	84 c0                	test   %al,%al
  80142e:	75 ea                	jne    80141a <strfind+0xe>
  801430:	eb 01                	jmp    801433 <strfind+0x27>
		if (*s == c)
			break;
  801432:	90                   	nop
	return (char *) s;
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
  80143b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801444:	8b 45 10             	mov    0x10(%ebp),%eax
  801447:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80144a:	eb 0e                	jmp    80145a <memset+0x22>
		*p++ = c;
  80144c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144f:	8d 50 01             	lea    0x1(%eax),%edx
  801452:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801455:	8b 55 0c             	mov    0xc(%ebp),%edx
  801458:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80145a:	ff 4d f8             	decl   -0x8(%ebp)
  80145d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801461:	79 e9                	jns    80144c <memset+0x14>
		*p++ = c;

	return v;
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
  80146b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80146e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801471:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80147a:	eb 16                	jmp    801492 <memcpy+0x2a>
		*d++ = *s++;
  80147c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147f:	8d 50 01             	lea    0x1(%eax),%edx
  801482:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801485:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801488:	8d 4a 01             	lea    0x1(%edx),%ecx
  80148b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80148e:	8a 12                	mov    (%edx),%dl
  801490:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801492:	8b 45 10             	mov    0x10(%ebp),%eax
  801495:	8d 50 ff             	lea    -0x1(%eax),%edx
  801498:	89 55 10             	mov    %edx,0x10(%ebp)
  80149b:	85 c0                	test   %eax,%eax
  80149d:	75 dd                	jne    80147c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8014aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014bc:	73 50                	jae    80150e <memmove+0x6a>
  8014be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c4:	01 d0                	add    %edx,%eax
  8014c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c9:	76 43                	jbe    80150e <memmove+0x6a>
		s += n;
  8014cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ce:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014d7:	eb 10                	jmp    8014e9 <memmove+0x45>
			*--d = *--s;
  8014d9:	ff 4d f8             	decl   -0x8(%ebp)
  8014dc:	ff 4d fc             	decl   -0x4(%ebp)
  8014df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e2:	8a 10                	mov    (%eax),%dl
  8014e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f2:	85 c0                	test   %eax,%eax
  8014f4:	75 e3                	jne    8014d9 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014f6:	eb 23                	jmp    80151b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014fb:	8d 50 01             	lea    0x1(%eax),%edx
  8014fe:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801501:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801504:	8d 4a 01             	lea    0x1(%edx),%ecx
  801507:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80150a:	8a 12                	mov    (%edx),%dl
  80150c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80150e:	8b 45 10             	mov    0x10(%ebp),%eax
  801511:	8d 50 ff             	lea    -0x1(%eax),%edx
  801514:	89 55 10             	mov    %edx,0x10(%ebp)
  801517:	85 c0                	test   %eax,%eax
  801519:	75 dd                	jne    8014f8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
  801523:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80152c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801532:	eb 2a                	jmp    80155e <memcmp+0x3e>
		if (*s1 != *s2)
  801534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801537:	8a 10                	mov    (%eax),%dl
  801539:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	38 c2                	cmp    %al,%dl
  801540:	74 16                	je     801558 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801542:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	0f b6 d0             	movzbl %al,%edx
  80154a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154d:	8a 00                	mov    (%eax),%al
  80154f:	0f b6 c0             	movzbl %al,%eax
  801552:	29 c2                	sub    %eax,%edx
  801554:	89 d0                	mov    %edx,%eax
  801556:	eb 18                	jmp    801570 <memcmp+0x50>
		s1++, s2++;
  801558:	ff 45 fc             	incl   -0x4(%ebp)
  80155b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80155e:	8b 45 10             	mov    0x10(%ebp),%eax
  801561:	8d 50 ff             	lea    -0x1(%eax),%edx
  801564:	89 55 10             	mov    %edx,0x10(%ebp)
  801567:	85 c0                	test   %eax,%eax
  801569:	75 c9                	jne    801534 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80156b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
  801575:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801578:	8b 55 08             	mov    0x8(%ebp),%edx
  80157b:	8b 45 10             	mov    0x10(%ebp),%eax
  80157e:	01 d0                	add    %edx,%eax
  801580:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801583:	eb 15                	jmp    80159a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	8a 00                	mov    (%eax),%al
  80158a:	0f b6 d0             	movzbl %al,%edx
  80158d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801590:	0f b6 c0             	movzbl %al,%eax
  801593:	39 c2                	cmp    %eax,%edx
  801595:	74 0d                	je     8015a4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801597:	ff 45 08             	incl   0x8(%ebp)
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015a0:	72 e3                	jb     801585 <memfind+0x13>
  8015a2:	eb 01                	jmp    8015a5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015a4:	90                   	nop
	return (void *) s;
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015b7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015be:	eb 03                	jmp    8015c3 <strtol+0x19>
		s++;
  8015c0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	3c 20                	cmp    $0x20,%al
  8015ca:	74 f4                	je     8015c0 <strtol+0x16>
  8015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	3c 09                	cmp    $0x9,%al
  8015d3:	74 eb                	je     8015c0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	3c 2b                	cmp    $0x2b,%al
  8015dc:	75 05                	jne    8015e3 <strtol+0x39>
		s++;
  8015de:	ff 45 08             	incl   0x8(%ebp)
  8015e1:	eb 13                	jmp    8015f6 <strtol+0x4c>
	else if (*s == '-')
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	3c 2d                	cmp    $0x2d,%al
  8015ea:	75 0a                	jne    8015f6 <strtol+0x4c>
		s++, neg = 1;
  8015ec:	ff 45 08             	incl   0x8(%ebp)
  8015ef:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fa:	74 06                	je     801602 <strtol+0x58>
  8015fc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801600:	75 20                	jne    801622 <strtol+0x78>
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	8a 00                	mov    (%eax),%al
  801607:	3c 30                	cmp    $0x30,%al
  801609:	75 17                	jne    801622 <strtol+0x78>
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	40                   	inc    %eax
  80160f:	8a 00                	mov    (%eax),%al
  801611:	3c 78                	cmp    $0x78,%al
  801613:	75 0d                	jne    801622 <strtol+0x78>
		s += 2, base = 16;
  801615:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801619:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801620:	eb 28                	jmp    80164a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801622:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801626:	75 15                	jne    80163d <strtol+0x93>
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	3c 30                	cmp    $0x30,%al
  80162f:	75 0c                	jne    80163d <strtol+0x93>
		s++, base = 8;
  801631:	ff 45 08             	incl   0x8(%ebp)
  801634:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80163b:	eb 0d                	jmp    80164a <strtol+0xa0>
	else if (base == 0)
  80163d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801641:	75 07                	jne    80164a <strtol+0xa0>
		base = 10;
  801643:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	8a 00                	mov    (%eax),%al
  80164f:	3c 2f                	cmp    $0x2f,%al
  801651:	7e 19                	jle    80166c <strtol+0xc2>
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	3c 39                	cmp    $0x39,%al
  80165a:	7f 10                	jg     80166c <strtol+0xc2>
			dig = *s - '0';
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	8a 00                	mov    (%eax),%al
  801661:	0f be c0             	movsbl %al,%eax
  801664:	83 e8 30             	sub    $0x30,%eax
  801667:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80166a:	eb 42                	jmp    8016ae <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	3c 60                	cmp    $0x60,%al
  801673:	7e 19                	jle    80168e <strtol+0xe4>
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	8a 00                	mov    (%eax),%al
  80167a:	3c 7a                	cmp    $0x7a,%al
  80167c:	7f 10                	jg     80168e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	0f be c0             	movsbl %al,%eax
  801686:	83 e8 57             	sub    $0x57,%eax
  801689:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80168c:	eb 20                	jmp    8016ae <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	3c 40                	cmp    $0x40,%al
  801695:	7e 39                	jle    8016d0 <strtol+0x126>
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	3c 5a                	cmp    $0x5a,%al
  80169e:	7f 30                	jg     8016d0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	0f be c0             	movsbl %al,%eax
  8016a8:	83 e8 37             	sub    $0x37,%eax
  8016ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016b4:	7d 19                	jge    8016cf <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016b6:	ff 45 08             	incl   0x8(%ebp)
  8016b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016c0:	89 c2                	mov    %eax,%edx
  8016c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c5:	01 d0                	add    %edx,%eax
  8016c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016ca:	e9 7b ff ff ff       	jmp    80164a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016cf:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016d0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016d4:	74 08                	je     8016de <strtol+0x134>
		*endptr = (char *) s;
  8016d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8016dc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016de:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016e2:	74 07                	je     8016eb <strtol+0x141>
  8016e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e7:	f7 d8                	neg    %eax
  8016e9:	eb 03                	jmp    8016ee <strtol+0x144>
  8016eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <ltostr>:

void
ltostr(long value, char *str)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
  8016f3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801704:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801708:	79 13                	jns    80171d <ltostr+0x2d>
	{
		neg = 1;
  80170a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801711:	8b 45 0c             	mov    0xc(%ebp),%eax
  801714:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801717:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80171a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80171d:	8b 45 08             	mov    0x8(%ebp),%eax
  801720:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801725:	99                   	cltd   
  801726:	f7 f9                	idiv   %ecx
  801728:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80172b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172e:	8d 50 01             	lea    0x1(%eax),%edx
  801731:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801734:	89 c2                	mov    %eax,%edx
  801736:	8b 45 0c             	mov    0xc(%ebp),%eax
  801739:	01 d0                	add    %edx,%eax
  80173b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80173e:	83 c2 30             	add    $0x30,%edx
  801741:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801743:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801746:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80174b:	f7 e9                	imul   %ecx
  80174d:	c1 fa 02             	sar    $0x2,%edx
  801750:	89 c8                	mov    %ecx,%eax
  801752:	c1 f8 1f             	sar    $0x1f,%eax
  801755:	29 c2                	sub    %eax,%edx
  801757:	89 d0                	mov    %edx,%eax
  801759:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80175c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80175f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801764:	f7 e9                	imul   %ecx
  801766:	c1 fa 02             	sar    $0x2,%edx
  801769:	89 c8                	mov    %ecx,%eax
  80176b:	c1 f8 1f             	sar    $0x1f,%eax
  80176e:	29 c2                	sub    %eax,%edx
  801770:	89 d0                	mov    %edx,%eax
  801772:	c1 e0 02             	shl    $0x2,%eax
  801775:	01 d0                	add    %edx,%eax
  801777:	01 c0                	add    %eax,%eax
  801779:	29 c1                	sub    %eax,%ecx
  80177b:	89 ca                	mov    %ecx,%edx
  80177d:	85 d2                	test   %edx,%edx
  80177f:	75 9c                	jne    80171d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801781:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801788:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178b:	48                   	dec    %eax
  80178c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80178f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801793:	74 3d                	je     8017d2 <ltostr+0xe2>
		start = 1 ;
  801795:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80179c:	eb 34                	jmp    8017d2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80179e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a4:	01 d0                	add    %edx,%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b1:	01 c2                	add    %eax,%edx
  8017b3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b9:	01 c8                	add    %ecx,%eax
  8017bb:	8a 00                	mov    (%eax),%al
  8017bd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017bf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c5:	01 c2                	add    %eax,%edx
  8017c7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017ca:	88 02                	mov    %al,(%edx)
		start++ ;
  8017cc:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017cf:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017d8:	7c c4                	jl     80179e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017da:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e0:	01 d0                	add    %edx,%eax
  8017e2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017e5:	90                   	nop
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
  8017eb:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017ee:	ff 75 08             	pushl  0x8(%ebp)
  8017f1:	e8 54 fa ff ff       	call   80124a <strlen>
  8017f6:	83 c4 04             	add    $0x4,%esp
  8017f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017fc:	ff 75 0c             	pushl  0xc(%ebp)
  8017ff:	e8 46 fa ff ff       	call   80124a <strlen>
  801804:	83 c4 04             	add    $0x4,%esp
  801807:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80180a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801811:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801818:	eb 17                	jmp    801831 <strcconcat+0x49>
		final[s] = str1[s] ;
  80181a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80181d:	8b 45 10             	mov    0x10(%ebp),%eax
  801820:	01 c2                	add    %eax,%edx
  801822:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	01 c8                	add    %ecx,%eax
  80182a:	8a 00                	mov    (%eax),%al
  80182c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80182e:	ff 45 fc             	incl   -0x4(%ebp)
  801831:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801834:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801837:	7c e1                	jl     80181a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801839:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801840:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801847:	eb 1f                	jmp    801868 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801849:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80184c:	8d 50 01             	lea    0x1(%eax),%edx
  80184f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801852:	89 c2                	mov    %eax,%edx
  801854:	8b 45 10             	mov    0x10(%ebp),%eax
  801857:	01 c2                	add    %eax,%edx
  801859:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80185c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185f:	01 c8                	add    %ecx,%eax
  801861:	8a 00                	mov    (%eax),%al
  801863:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801865:	ff 45 f8             	incl   -0x8(%ebp)
  801868:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80186b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80186e:	7c d9                	jl     801849 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801870:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801873:	8b 45 10             	mov    0x10(%ebp),%eax
  801876:	01 d0                	add    %edx,%eax
  801878:	c6 00 00             	movb   $0x0,(%eax)
}
  80187b:	90                   	nop
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801881:	8b 45 14             	mov    0x14(%ebp),%eax
  801884:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80188a:	8b 45 14             	mov    0x14(%ebp),%eax
  80188d:	8b 00                	mov    (%eax),%eax
  80188f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801896:	8b 45 10             	mov    0x10(%ebp),%eax
  801899:	01 d0                	add    %edx,%eax
  80189b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a1:	eb 0c                	jmp    8018af <strsplit+0x31>
			*string++ = 0;
  8018a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a6:	8d 50 01             	lea    0x1(%eax),%edx
  8018a9:	89 55 08             	mov    %edx,0x8(%ebp)
  8018ac:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	8a 00                	mov    (%eax),%al
  8018b4:	84 c0                	test   %al,%al
  8018b6:	74 18                	je     8018d0 <strsplit+0x52>
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	8a 00                	mov    (%eax),%al
  8018bd:	0f be c0             	movsbl %al,%eax
  8018c0:	50                   	push   %eax
  8018c1:	ff 75 0c             	pushl  0xc(%ebp)
  8018c4:	e8 13 fb ff ff       	call   8013dc <strchr>
  8018c9:	83 c4 08             	add    $0x8,%esp
  8018cc:	85 c0                	test   %eax,%eax
  8018ce:	75 d3                	jne    8018a3 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	84 c0                	test   %al,%al
  8018d7:	74 5a                	je     801933 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8018d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018dc:	8b 00                	mov    (%eax),%eax
  8018de:	83 f8 0f             	cmp    $0xf,%eax
  8018e1:	75 07                	jne    8018ea <strsplit+0x6c>
		{
			return 0;
  8018e3:	b8 00 00 00 00       	mov    $0x0,%eax
  8018e8:	eb 66                	jmp    801950 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ed:	8b 00                	mov    (%eax),%eax
  8018ef:	8d 48 01             	lea    0x1(%eax),%ecx
  8018f2:	8b 55 14             	mov    0x14(%ebp),%edx
  8018f5:	89 0a                	mov    %ecx,(%edx)
  8018f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801901:	01 c2                	add    %eax,%edx
  801903:	8b 45 08             	mov    0x8(%ebp),%eax
  801906:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801908:	eb 03                	jmp    80190d <strsplit+0x8f>
			string++;
  80190a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	8a 00                	mov    (%eax),%al
  801912:	84 c0                	test   %al,%al
  801914:	74 8b                	je     8018a1 <strsplit+0x23>
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	8a 00                	mov    (%eax),%al
  80191b:	0f be c0             	movsbl %al,%eax
  80191e:	50                   	push   %eax
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	e8 b5 fa ff ff       	call   8013dc <strchr>
  801927:	83 c4 08             	add    $0x8,%esp
  80192a:	85 c0                	test   %eax,%eax
  80192c:	74 dc                	je     80190a <strsplit+0x8c>
			string++;
	}
  80192e:	e9 6e ff ff ff       	jmp    8018a1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801933:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801934:	8b 45 14             	mov    0x14(%ebp),%eax
  801937:	8b 00                	mov    (%eax),%eax
  801939:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801940:	8b 45 10             	mov    0x10(%ebp),%eax
  801943:	01 d0                	add    %edx,%eax
  801945:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80194b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <malloc>:
struct UserHEAP {
	uint32 first;
	int size;
} uHeapArr[kilo];

void* malloc(uint32 size) {
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	83 ec 28             	sub    $0x28,%esp
	//	2) if no suitable space found, return NULL
	//	 Else,
	//	3) Call sys_allocateMem to invoke the Kernel for allocation
	// 	4) Return pointer containing the virtual address of allocated space,

	if(sys_isUHeapPlacementStrategyNEXTFIT()) {
  801958:	e8 9b 07 00 00       	call   8020f8 <sys_isUHeapPlacementStrategyNEXTFIT>
  80195d:	85 c0                	test   %eax,%eax
  80195f:	0f 84 64 01 00 00    	je     801ac9 <malloc+0x177>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
  801965:	8b 0d 2c 30 80 00    	mov    0x80302c,%ecx
  80196b:	c7 45 e8 00 10 00 00 	movl   $0x1000,-0x18(%ebp)
  801972:	8b 55 08             	mov    0x8(%ebp),%edx
  801975:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801978:	01 d0                	add    %edx,%eax
  80197a:	48                   	dec    %eax
  80197b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80197e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801981:	ba 00 00 00 00       	mov    $0x0,%edx
  801986:	f7 75 e8             	divl   -0x18(%ebp)
  801989:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80198c:	29 d0                	sub    %edx,%eax
  80198e:	89 04 cd 44 30 88 00 	mov    %eax,0x883044(,%ecx,8)
		uint32 maxSize = startAdd+size;
  801995:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	01 d0                	add    %edx,%eax
  8019a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int flag=0;
  8019a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
  8019aa:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019af:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8019b6:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8019b9:	0f 83 0a 01 00 00    	jae    801ac9 <malloc+0x177>
  8019bf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019c4:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  8019cb:	85 c0                	test   %eax,%eax
  8019cd:	0f 84 f6 00 00 00    	je     801ac9 <malloc+0x177>
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  8019d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8019da:	e9 dc 00 00 00       	jmp    801abb <malloc+0x169>
				flag++;
  8019df:	ff 45 f4             	incl   -0xc(%ebp)
				if(hFreeArr[i] != 0) {
  8019e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019e5:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8019ec:	85 c0                	test   %eax,%eax
  8019ee:	74 07                	je     8019f7 <malloc+0xa5>
					flag=0;
  8019f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
  8019f7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019fc:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a03:	85 c0                	test   %eax,%eax
  801a05:	79 05                	jns    801a0c <malloc+0xba>
  801a07:	05 ff 0f 00 00       	add    $0xfff,%eax
  801a0c:	c1 f8 0c             	sar    $0xc,%eax
  801a0f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a12:	0f 85 a0 00 00 00    	jne    801ab8 <malloc+0x166>
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);
  801a18:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a1d:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a24:	85 c0                	test   %eax,%eax
  801a26:	79 05                	jns    801a2d <malloc+0xdb>
  801a28:	05 ff 0f 00 00       	add    $0xfff,%eax
  801a2d:	c1 f8 0c             	sar    $0xc,%eax
  801a30:	89 c2                	mov    %eax,%edx
  801a32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a35:	29 d0                	sub    %edx,%eax
  801a37:	89 45 dc             	mov    %eax,-0x24(%ebp)

					for(int j=rem; j<=i; j++) {
  801a3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801a40:	eb 11                	jmp    801a53 <malloc+0x101>
						hFreeArr[j] = 1;
  801a42:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a45:	c7 04 85 40 30 80 00 	movl   $0x1,0x803040(,%eax,4)
  801a4c:	01 00 00 00 
				}

				if(flag == (uHeapArr[idx].size/PAGE_SIZE)) {
					uint32 rem = i-(uHeapArr[idx].size/PAGE_SIZE);

					for(int j=rem; j<=i; j++) {
  801a50:	ff 45 ec             	incl   -0x14(%ebp)
  801a53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a59:	7e e7                	jle    801a42 <malloc+0xf0>
						hFreeArr[j] = 1;
					}

					uHeapArr[idx].first = startAdd = USER_HEAP_START+((rem+1)*PAGE_SIZE);
  801a5b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a60:	8b 55 dc             	mov    -0x24(%ebp),%edx
  801a63:	81 c2 01 00 08 00    	add    $0x80001,%edx
  801a69:	c1 e2 0c             	shl    $0xc,%edx
  801a6c:	89 15 04 30 80 00    	mov    %edx,0x803004
  801a72:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a78:	89 14 c5 40 30 88 00 	mov    %edx,0x883040(,%eax,8)

					sys_allocateMem(uHeapArr[idx].first, uHeapArr[idx].size);
  801a7f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a84:	8b 04 c5 44 30 88 00 	mov    0x883044(,%eax,8),%eax
  801a8b:	89 c2                	mov    %eax,%edx
  801a8d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a92:	8b 04 c5 40 30 88 00 	mov    0x883040(,%eax,8),%eax
  801a99:	83 ec 08             	sub    $0x8,%esp
  801a9c:	52                   	push   %edx
  801a9d:	50                   	push   %eax
  801a9e:	e8 8b 02 00 00       	call   801d2e <sys_allocateMem>
  801aa3:	83 c4 10             	add    $0x10,%esp

					idx++;
  801aa6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801aab:	40                   	inc    %eax
  801aac:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*)startAdd;
  801ab1:	a1 04 30 80 00       	mov    0x803004,%eax
  801ab6:	eb 16                	jmp    801ace <malloc+0x17c>
		uHeapArr[idx].size = ROUNDUP(size, PAGE_SIZE);
		uint32 maxSize = startAdd+size;
		int flag=0;

		if (uHeapArr[idx].size<maxSize && uHeapArr[idx].size!=0) {
			for(int i=0; i<((USER_HEAP_MAX-USER_HEAP_START)/PAGE_SIZE); i++) {
  801ab8:	ff 45 f0             	incl   -0x10(%ebp)
  801abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801abe:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ac3:	0f 86 16 ff ff ff    	jbe    8019df <malloc+0x8d>

	//Use sys_isUHeapPlacementStrategyNEXTFIT() and
	//sys_isUHeapPlacementStrategyBESTFIT() for the bonus
	//to check the current strategy

	return NULL;
  801ac9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <smalloc>:

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
  801ad3:	83 ec 18             	sub    $0x18,%esp
  801ad6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("smalloc() is not required ..!!");
  801adc:	83 ec 04             	sub    $0x4,%esp
  801adf:	68 a4 2a 80 00       	push   $0x802aa4
  801ae4:	6a 59                	push   $0x59
  801ae6:	68 c3 2a 80 00       	push   $0x802ac3
  801aeb:	e8 1e ec ff ff       	call   80070e <_panic>

00801af0 <sget>:
	return NULL;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
  801af3:	83 ec 08             	sub    $0x8,%esp
	panic("sget() is not required ..!!");
  801af6:	83 ec 04             	sub    $0x4,%esp
  801af9:	68 cf 2a 80 00       	push   $0x802acf
  801afe:	6a 5f                	push   $0x5f
  801b00:	68 c3 2a 80 00       	push   $0x802ac3
  801b05:	e8 04 ec ff ff       	call   80070e <_panic>

00801b0a <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
  801b0d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - [11] User Heap free()] [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b10:	83 ec 04             	sub    $0x4,%esp
  801b13:	68 ec 2a 80 00       	push   $0x802aec
  801b18:	6a 70                	push   $0x70
  801b1a:	68 c3 2a 80 00       	push   $0x802ac3
  801b1f:	e8 ea eb ff ff       	call   80070e <_panic>

00801b24 <sfree>:

}


void sfree(void* virtual_address)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	83 ec 08             	sub    $0x8,%esp
	panic("sfree() is not requried ..!!");
  801b2a:	83 ec 04             	sub    $0x4,%esp
  801b2d:	68 0f 2b 80 00       	push   $0x802b0f
  801b32:	6a 7b                	push   $0x7b
  801b34:	68 c3 2a 80 00       	push   $0x802ac3
  801b39:	e8 d0 eb ff ff       	call   80070e <_panic>

00801b3e <realloc>:
//  Hint: you may need to use the sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size) {
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
  801b41:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2022 - BONUS3] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801b44:	83 ec 04             	sub    $0x4,%esp
  801b47:	68 2c 2b 80 00       	push   $0x802b2c
  801b4c:	68 93 00 00 00       	push   $0x93
  801b51:	68 c3 2a 80 00       	push   $0x802ac3
  801b56:	e8 b3 eb ff ff       	call   80070e <_panic>

00801b5b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
  801b5e:	57                   	push   %edi
  801b5f:	56                   	push   %esi
  801b60:	53                   	push   %ebx
  801b61:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b70:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b73:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b76:	cd 30                	int    $0x30
  801b78:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b7e:	83 c4 10             	add    $0x10,%esp
  801b81:	5b                   	pop    %ebx
  801b82:	5e                   	pop    %esi
  801b83:	5f                   	pop    %edi
  801b84:	5d                   	pop    %ebp
  801b85:	c3                   	ret    

00801b86 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
  801b89:	83 ec 04             	sub    $0x4,%esp
  801b8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b92:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	52                   	push   %edx
  801b9e:	ff 75 0c             	pushl  0xc(%ebp)
  801ba1:	50                   	push   %eax
  801ba2:	6a 00                	push   $0x0
  801ba4:	e8 b2 ff ff ff       	call   801b5b <syscall>
  801ba9:	83 c4 18             	add    $0x18,%esp
}
  801bac:	90                   	nop
  801bad:	c9                   	leave  
  801bae:	c3                   	ret    

00801baf <sys_cgetc>:

int
sys_cgetc(void)
{
  801baf:	55                   	push   %ebp
  801bb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 01                	push   $0x1
  801bbe:	e8 98 ff ff ff       	call   801b5b <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
}
  801bc6:	c9                   	leave  
  801bc7:	c3                   	ret    

00801bc8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	50                   	push   %eax
  801bd7:	6a 05                	push   $0x5
  801bd9:	e8 7d ff ff ff       	call   801b5b <syscall>
  801bde:	83 c4 18             	add    $0x18,%esp
}
  801be1:	c9                   	leave  
  801be2:	c3                   	ret    

00801be3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801be3:	55                   	push   %ebp
  801be4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 02                	push   $0x2
  801bf2:	e8 64 ff ff ff       	call   801b5b <syscall>
  801bf7:	83 c4 18             	add    $0x18,%esp
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 03                	push   $0x3
  801c0b:	e8 4b ff ff ff       	call   801b5b <syscall>
  801c10:	83 c4 18             	add    $0x18,%esp
}
  801c13:	c9                   	leave  
  801c14:	c3                   	ret    

00801c15 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 04                	push   $0x4
  801c24:	e8 32 ff ff ff       	call   801b5b <syscall>
  801c29:	83 c4 18             	add    $0x18,%esp
}
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <sys_env_exit>:


void sys_env_exit(void)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 06                	push   $0x6
  801c3d:	e8 19 ff ff ff       	call   801b5b <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
}
  801c45:	90                   	nop
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	52                   	push   %edx
  801c58:	50                   	push   %eax
  801c59:	6a 07                	push   $0x7
  801c5b:	e8 fb fe ff ff       	call   801b5b <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
}
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
  801c68:	56                   	push   %esi
  801c69:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c6a:	8b 75 18             	mov    0x18(%ebp),%esi
  801c6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c70:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c76:	8b 45 08             	mov    0x8(%ebp),%eax
  801c79:	56                   	push   %esi
  801c7a:	53                   	push   %ebx
  801c7b:	51                   	push   %ecx
  801c7c:	52                   	push   %edx
  801c7d:	50                   	push   %eax
  801c7e:	6a 08                	push   $0x8
  801c80:	e8 d6 fe ff ff       	call   801b5b <syscall>
  801c85:	83 c4 18             	add    $0x18,%esp
}
  801c88:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5d                   	pop    %ebp
  801c8e:	c3                   	ret    

00801c8f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c95:	8b 45 08             	mov    0x8(%ebp),%eax
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	52                   	push   %edx
  801c9f:	50                   	push   %eax
  801ca0:	6a 09                	push   $0x9
  801ca2:	e8 b4 fe ff ff       	call   801b5b <syscall>
  801ca7:	83 c4 18             	add    $0x18,%esp
}
  801caa:	c9                   	leave  
  801cab:	c3                   	ret    

00801cac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cac:	55                   	push   %ebp
  801cad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	ff 75 0c             	pushl  0xc(%ebp)
  801cb8:	ff 75 08             	pushl  0x8(%ebp)
  801cbb:	6a 0a                	push   $0xa
  801cbd:	e8 99 fe ff ff       	call   801b5b <syscall>
  801cc2:	83 c4 18             	add    $0x18,%esp
}
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 0b                	push   $0xb
  801cd6:	e8 80 fe ff ff       	call   801b5b <syscall>
  801cdb:	83 c4 18             	add    $0x18,%esp
}
  801cde:	c9                   	leave  
  801cdf:	c3                   	ret    

00801ce0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 0c                	push   $0xc
  801cef:	e8 67 fe ff ff       	call   801b5b <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 0d                	push   $0xd
  801d08:	e8 4e fe ff ff       	call   801b5b <syscall>
  801d0d:	83 c4 18             	add    $0x18,%esp
}
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	ff 75 0c             	pushl  0xc(%ebp)
  801d1e:	ff 75 08             	pushl  0x8(%ebp)
  801d21:	6a 11                	push   $0x11
  801d23:	e8 33 fe ff ff       	call   801b5b <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
	return;
  801d2b:	90                   	nop
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	ff 75 0c             	pushl  0xc(%ebp)
  801d3a:	ff 75 08             	pushl  0x8(%ebp)
  801d3d:	6a 12                	push   $0x12
  801d3f:	e8 17 fe ff ff       	call   801b5b <syscall>
  801d44:	83 c4 18             	add    $0x18,%esp
	return ;
  801d47:	90                   	nop
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 0e                	push   $0xe
  801d59:	e8 fd fd ff ff       	call   801b5b <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	ff 75 08             	pushl  0x8(%ebp)
  801d71:	6a 0f                	push   $0xf
  801d73:	e8 e3 fd ff ff       	call   801b5b <syscall>
  801d78:	83 c4 18             	add    $0x18,%esp
}
  801d7b:	c9                   	leave  
  801d7c:	c3                   	ret    

00801d7d <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d7d:	55                   	push   %ebp
  801d7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 10                	push   $0x10
  801d8c:	e8 ca fd ff ff       	call   801b5b <syscall>
  801d91:	83 c4 18             	add    $0x18,%esp
}
  801d94:	90                   	nop
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 14                	push   $0x14
  801da6:	e8 b0 fd ff ff       	call   801b5b <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	90                   	nop
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 15                	push   $0x15
  801dc0:	e8 96 fd ff ff       	call   801b5b <syscall>
  801dc5:	83 c4 18             	add    $0x18,%esp
}
  801dc8:	90                   	nop
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sys_cputc>:


void
sys_cputc(const char c)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
  801dce:	83 ec 04             	sub    $0x4,%esp
  801dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801dd7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	50                   	push   %eax
  801de4:	6a 16                	push   $0x16
  801de6:	e8 70 fd ff ff       	call   801b5b <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	90                   	nop
  801def:	c9                   	leave  
  801df0:	c3                   	ret    

00801df1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801df1:	55                   	push   %ebp
  801df2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 17                	push   $0x17
  801e00:	e8 56 fd ff ff       	call   801b5b <syscall>
  801e05:	83 c4 18             	add    $0x18,%esp
}
  801e08:	90                   	nop
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    

00801e0b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	ff 75 0c             	pushl  0xc(%ebp)
  801e1a:	50                   	push   %eax
  801e1b:	6a 18                	push   $0x18
  801e1d:	e8 39 fd ff ff       	call   801b5b <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	52                   	push   %edx
  801e37:	50                   	push   %eax
  801e38:	6a 1b                	push   $0x1b
  801e3a:	e8 1c fd ff ff       	call   801b5b <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	52                   	push   %edx
  801e54:	50                   	push   %eax
  801e55:	6a 19                	push   $0x19
  801e57:	e8 ff fc ff ff       	call   801b5b <syscall>
  801e5c:	83 c4 18             	add    $0x18,%esp
}
  801e5f:	90                   	nop
  801e60:	c9                   	leave  
  801e61:	c3                   	ret    

00801e62 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e62:	55                   	push   %ebp
  801e63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e68:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	52                   	push   %edx
  801e72:	50                   	push   %eax
  801e73:	6a 1a                	push   $0x1a
  801e75:	e8 e1 fc ff ff       	call   801b5b <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	90                   	nop
  801e7e:	c9                   	leave  
  801e7f:	c3                   	ret    

00801e80 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
  801e83:	83 ec 04             	sub    $0x4,%esp
  801e86:	8b 45 10             	mov    0x10(%ebp),%eax
  801e89:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e8c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e8f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e93:	8b 45 08             	mov    0x8(%ebp),%eax
  801e96:	6a 00                	push   $0x0
  801e98:	51                   	push   %ecx
  801e99:	52                   	push   %edx
  801e9a:	ff 75 0c             	pushl  0xc(%ebp)
  801e9d:	50                   	push   %eax
  801e9e:	6a 1c                	push   $0x1c
  801ea0:	e8 b6 fc ff ff       	call   801b5b <syscall>
  801ea5:	83 c4 18             	add    $0x18,%esp
}
  801ea8:	c9                   	leave  
  801ea9:	c3                   	ret    

00801eaa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801eaa:	55                   	push   %ebp
  801eab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ead:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	52                   	push   %edx
  801eba:	50                   	push   %eax
  801ebb:	6a 1d                	push   $0x1d
  801ebd:	e8 99 fc ff ff       	call   801b5b <syscall>
  801ec2:	83 c4 18             	add    $0x18,%esp
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801eca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ecd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	51                   	push   %ecx
  801ed8:	52                   	push   %edx
  801ed9:	50                   	push   %eax
  801eda:	6a 1e                	push   $0x1e
  801edc:	e8 7a fc ff ff       	call   801b5b <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
}
  801ee4:	c9                   	leave  
  801ee5:	c3                   	ret    

00801ee6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ee9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eec:	8b 45 08             	mov    0x8(%ebp),%eax
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	52                   	push   %edx
  801ef6:	50                   	push   %eax
  801ef7:	6a 1f                	push   $0x1f
  801ef9:	e8 5d fc ff ff       	call   801b5b <syscall>
  801efe:	83 c4 18             	add    $0x18,%esp
}
  801f01:	c9                   	leave  
  801f02:	c3                   	ret    

00801f03 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f03:	55                   	push   %ebp
  801f04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 20                	push   $0x20
  801f12:	e8 44 fc ff ff       	call   801b5b <syscall>
  801f17:	83 c4 18             	add    $0x18,%esp
}
  801f1a:	c9                   	leave  
  801f1b:	c3                   	ret    

00801f1c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801f1c:	55                   	push   %ebp
  801f1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	ff 75 10             	pushl  0x10(%ebp)
  801f29:	ff 75 0c             	pushl  0xc(%ebp)
  801f2c:	50                   	push   %eax
  801f2d:	6a 21                	push   $0x21
  801f2f:	e8 27 fc ff ff       	call   801b5b <syscall>
  801f34:	83 c4 18             	add    $0x18,%esp
}
  801f37:	c9                   	leave  
  801f38:	c3                   	ret    

00801f39 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f39:	55                   	push   %ebp
  801f3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	50                   	push   %eax
  801f48:	6a 22                	push   $0x22
  801f4a:	e8 0c fc ff ff       	call   801b5b <syscall>
  801f4f:	83 c4 18             	add    $0x18,%esp
}
  801f52:	90                   	nop
  801f53:	c9                   	leave  
  801f54:	c3                   	ret    

00801f55 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f55:	55                   	push   %ebp
  801f56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f58:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	50                   	push   %eax
  801f64:	6a 23                	push   $0x23
  801f66:	e8 f0 fb ff ff       	call   801b5b <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
}
  801f6e:	90                   	nop
  801f6f:	c9                   	leave  
  801f70:	c3                   	ret    

00801f71 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f71:	55                   	push   %ebp
  801f72:	89 e5                	mov    %esp,%ebp
  801f74:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f77:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f7a:	8d 50 04             	lea    0x4(%eax),%edx
  801f7d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	52                   	push   %edx
  801f87:	50                   	push   %eax
  801f88:	6a 24                	push   $0x24
  801f8a:	e8 cc fb ff ff       	call   801b5b <syscall>
  801f8f:	83 c4 18             	add    $0x18,%esp
	return result;
  801f92:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f98:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f9b:	89 01                	mov    %eax,(%ecx)
  801f9d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa3:	c9                   	leave  
  801fa4:	c2 04 00             	ret    $0x4

00801fa7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	ff 75 10             	pushl  0x10(%ebp)
  801fb1:	ff 75 0c             	pushl  0xc(%ebp)
  801fb4:	ff 75 08             	pushl  0x8(%ebp)
  801fb7:	6a 13                	push   $0x13
  801fb9:	e8 9d fb ff ff       	call   801b5b <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc1:	90                   	nop
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 25                	push   $0x25
  801fd3:	e8 83 fb ff ff       	call   801b5b <syscall>
  801fd8:	83 c4 18             	add    $0x18,%esp
}
  801fdb:	c9                   	leave  
  801fdc:	c3                   	ret    

00801fdd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fdd:	55                   	push   %ebp
  801fde:	89 e5                	mov    %esp,%ebp
  801fe0:	83 ec 04             	sub    $0x4,%esp
  801fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fe9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	50                   	push   %eax
  801ff6:	6a 26                	push   $0x26
  801ff8:	e8 5e fb ff ff       	call   801b5b <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
	return ;
  802000:	90                   	nop
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <rsttst>:
void rsttst()
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 28                	push   $0x28
  802012:	e8 44 fb ff ff       	call   801b5b <syscall>
  802017:	83 c4 18             	add    $0x18,%esp
	return ;
  80201a:	90                   	nop
}
  80201b:	c9                   	leave  
  80201c:	c3                   	ret    

0080201d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80201d:	55                   	push   %ebp
  80201e:	89 e5                	mov    %esp,%ebp
  802020:	83 ec 04             	sub    $0x4,%esp
  802023:	8b 45 14             	mov    0x14(%ebp),%eax
  802026:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802029:	8b 55 18             	mov    0x18(%ebp),%edx
  80202c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802030:	52                   	push   %edx
  802031:	50                   	push   %eax
  802032:	ff 75 10             	pushl  0x10(%ebp)
  802035:	ff 75 0c             	pushl  0xc(%ebp)
  802038:	ff 75 08             	pushl  0x8(%ebp)
  80203b:	6a 27                	push   $0x27
  80203d:	e8 19 fb ff ff       	call   801b5b <syscall>
  802042:	83 c4 18             	add    $0x18,%esp
	return ;
  802045:	90                   	nop
}
  802046:	c9                   	leave  
  802047:	c3                   	ret    

00802048 <chktst>:
void chktst(uint32 n)
{
  802048:	55                   	push   %ebp
  802049:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	ff 75 08             	pushl  0x8(%ebp)
  802056:	6a 29                	push   $0x29
  802058:	e8 fe fa ff ff       	call   801b5b <syscall>
  80205d:	83 c4 18             	add    $0x18,%esp
	return ;
  802060:	90                   	nop
}
  802061:	c9                   	leave  
  802062:	c3                   	ret    

00802063 <inctst>:

void inctst()
{
  802063:	55                   	push   %ebp
  802064:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 2a                	push   $0x2a
  802072:	e8 e4 fa ff ff       	call   801b5b <syscall>
  802077:	83 c4 18             	add    $0x18,%esp
	return ;
  80207a:	90                   	nop
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <gettst>:
uint32 gettst()
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 2b                	push   $0x2b
  80208c:	e8 ca fa ff ff       	call   801b5b <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
}
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
  802099:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 2c                	push   $0x2c
  8020a8:	e8 ae fa ff ff       	call   801b5b <syscall>
  8020ad:	83 c4 18             	add    $0x18,%esp
  8020b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020b3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020b7:	75 07                	jne    8020c0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020be:	eb 05                	jmp    8020c5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020c5:	c9                   	leave  
  8020c6:	c3                   	ret    

008020c7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020c7:	55                   	push   %ebp
  8020c8:	89 e5                	mov    %esp,%ebp
  8020ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 2c                	push   $0x2c
  8020d9:	e8 7d fa ff ff       	call   801b5b <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
  8020e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020e4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020e8:	75 07                	jne    8020f1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ef:	eb 05                	jmp    8020f6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020f6:	c9                   	leave  
  8020f7:	c3                   	ret    

008020f8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020f8:	55                   	push   %ebp
  8020f9:	89 e5                	mov    %esp,%ebp
  8020fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020fe:	6a 00                	push   $0x0
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 2c                	push   $0x2c
  80210a:	e8 4c fa ff ff       	call   801b5b <syscall>
  80210f:	83 c4 18             	add    $0x18,%esp
  802112:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802115:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802119:	75 07                	jne    802122 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80211b:	b8 01 00 00 00       	mov    $0x1,%eax
  802120:	eb 05                	jmp    802127 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802122:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802127:	c9                   	leave  
  802128:	c3                   	ret    

00802129 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802129:	55                   	push   %ebp
  80212a:	89 e5                	mov    %esp,%ebp
  80212c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	6a 00                	push   $0x0
  802139:	6a 2c                	push   $0x2c
  80213b:	e8 1b fa ff ff       	call   801b5b <syscall>
  802140:	83 c4 18             	add    $0x18,%esp
  802143:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802146:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80214a:	75 07                	jne    802153 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80214c:	b8 01 00 00 00       	mov    $0x1,%eax
  802151:	eb 05                	jmp    802158 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802153:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802158:	c9                   	leave  
  802159:	c3                   	ret    

0080215a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80215a:	55                   	push   %ebp
  80215b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	ff 75 08             	pushl  0x8(%ebp)
  802168:	6a 2d                	push   $0x2d
  80216a:	e8 ec f9 ff ff       	call   801b5b <syscall>
  80216f:	83 c4 18             	add    $0x18,%esp
	return ;
  802172:	90                   	nop
}
  802173:	c9                   	leave  
  802174:	c3                   	ret    
  802175:	66 90                	xchg   %ax,%ax
  802177:	90                   	nop

00802178 <__udivdi3>:
  802178:	55                   	push   %ebp
  802179:	57                   	push   %edi
  80217a:	56                   	push   %esi
  80217b:	53                   	push   %ebx
  80217c:	83 ec 1c             	sub    $0x1c,%esp
  80217f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802183:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802187:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80218b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80218f:	89 ca                	mov    %ecx,%edx
  802191:	89 f8                	mov    %edi,%eax
  802193:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802197:	85 f6                	test   %esi,%esi
  802199:	75 2d                	jne    8021c8 <__udivdi3+0x50>
  80219b:	39 cf                	cmp    %ecx,%edi
  80219d:	77 65                	ja     802204 <__udivdi3+0x8c>
  80219f:	89 fd                	mov    %edi,%ebp
  8021a1:	85 ff                	test   %edi,%edi
  8021a3:	75 0b                	jne    8021b0 <__udivdi3+0x38>
  8021a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021aa:	31 d2                	xor    %edx,%edx
  8021ac:	f7 f7                	div    %edi
  8021ae:	89 c5                	mov    %eax,%ebp
  8021b0:	31 d2                	xor    %edx,%edx
  8021b2:	89 c8                	mov    %ecx,%eax
  8021b4:	f7 f5                	div    %ebp
  8021b6:	89 c1                	mov    %eax,%ecx
  8021b8:	89 d8                	mov    %ebx,%eax
  8021ba:	f7 f5                	div    %ebp
  8021bc:	89 cf                	mov    %ecx,%edi
  8021be:	89 fa                	mov    %edi,%edx
  8021c0:	83 c4 1c             	add    $0x1c,%esp
  8021c3:	5b                   	pop    %ebx
  8021c4:	5e                   	pop    %esi
  8021c5:	5f                   	pop    %edi
  8021c6:	5d                   	pop    %ebp
  8021c7:	c3                   	ret    
  8021c8:	39 ce                	cmp    %ecx,%esi
  8021ca:	77 28                	ja     8021f4 <__udivdi3+0x7c>
  8021cc:	0f bd fe             	bsr    %esi,%edi
  8021cf:	83 f7 1f             	xor    $0x1f,%edi
  8021d2:	75 40                	jne    802214 <__udivdi3+0x9c>
  8021d4:	39 ce                	cmp    %ecx,%esi
  8021d6:	72 0a                	jb     8021e2 <__udivdi3+0x6a>
  8021d8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021dc:	0f 87 9e 00 00 00    	ja     802280 <__udivdi3+0x108>
  8021e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021e7:	89 fa                	mov    %edi,%edx
  8021e9:	83 c4 1c             	add    $0x1c,%esp
  8021ec:	5b                   	pop    %ebx
  8021ed:	5e                   	pop    %esi
  8021ee:	5f                   	pop    %edi
  8021ef:	5d                   	pop    %ebp
  8021f0:	c3                   	ret    
  8021f1:	8d 76 00             	lea    0x0(%esi),%esi
  8021f4:	31 ff                	xor    %edi,%edi
  8021f6:	31 c0                	xor    %eax,%eax
  8021f8:	89 fa                	mov    %edi,%edx
  8021fa:	83 c4 1c             	add    $0x1c,%esp
  8021fd:	5b                   	pop    %ebx
  8021fe:	5e                   	pop    %esi
  8021ff:	5f                   	pop    %edi
  802200:	5d                   	pop    %ebp
  802201:	c3                   	ret    
  802202:	66 90                	xchg   %ax,%ax
  802204:	89 d8                	mov    %ebx,%eax
  802206:	f7 f7                	div    %edi
  802208:	31 ff                	xor    %edi,%edi
  80220a:	89 fa                	mov    %edi,%edx
  80220c:	83 c4 1c             	add    $0x1c,%esp
  80220f:	5b                   	pop    %ebx
  802210:	5e                   	pop    %esi
  802211:	5f                   	pop    %edi
  802212:	5d                   	pop    %ebp
  802213:	c3                   	ret    
  802214:	bd 20 00 00 00       	mov    $0x20,%ebp
  802219:	89 eb                	mov    %ebp,%ebx
  80221b:	29 fb                	sub    %edi,%ebx
  80221d:	89 f9                	mov    %edi,%ecx
  80221f:	d3 e6                	shl    %cl,%esi
  802221:	89 c5                	mov    %eax,%ebp
  802223:	88 d9                	mov    %bl,%cl
  802225:	d3 ed                	shr    %cl,%ebp
  802227:	89 e9                	mov    %ebp,%ecx
  802229:	09 f1                	or     %esi,%ecx
  80222b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80222f:	89 f9                	mov    %edi,%ecx
  802231:	d3 e0                	shl    %cl,%eax
  802233:	89 c5                	mov    %eax,%ebp
  802235:	89 d6                	mov    %edx,%esi
  802237:	88 d9                	mov    %bl,%cl
  802239:	d3 ee                	shr    %cl,%esi
  80223b:	89 f9                	mov    %edi,%ecx
  80223d:	d3 e2                	shl    %cl,%edx
  80223f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802243:	88 d9                	mov    %bl,%cl
  802245:	d3 e8                	shr    %cl,%eax
  802247:	09 c2                	or     %eax,%edx
  802249:	89 d0                	mov    %edx,%eax
  80224b:	89 f2                	mov    %esi,%edx
  80224d:	f7 74 24 0c          	divl   0xc(%esp)
  802251:	89 d6                	mov    %edx,%esi
  802253:	89 c3                	mov    %eax,%ebx
  802255:	f7 e5                	mul    %ebp
  802257:	39 d6                	cmp    %edx,%esi
  802259:	72 19                	jb     802274 <__udivdi3+0xfc>
  80225b:	74 0b                	je     802268 <__udivdi3+0xf0>
  80225d:	89 d8                	mov    %ebx,%eax
  80225f:	31 ff                	xor    %edi,%edi
  802261:	e9 58 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  802266:	66 90                	xchg   %ax,%ax
  802268:	8b 54 24 08          	mov    0x8(%esp),%edx
  80226c:	89 f9                	mov    %edi,%ecx
  80226e:	d3 e2                	shl    %cl,%edx
  802270:	39 c2                	cmp    %eax,%edx
  802272:	73 e9                	jae    80225d <__udivdi3+0xe5>
  802274:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802277:	31 ff                	xor    %edi,%edi
  802279:	e9 40 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  80227e:	66 90                	xchg   %ax,%ax
  802280:	31 c0                	xor    %eax,%eax
  802282:	e9 37 ff ff ff       	jmp    8021be <__udivdi3+0x46>
  802287:	90                   	nop

00802288 <__umoddi3>:
  802288:	55                   	push   %ebp
  802289:	57                   	push   %edi
  80228a:	56                   	push   %esi
  80228b:	53                   	push   %ebx
  80228c:	83 ec 1c             	sub    $0x1c,%esp
  80228f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802293:	8b 74 24 34          	mov    0x34(%esp),%esi
  802297:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80229b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80229f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022a3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022a7:	89 f3                	mov    %esi,%ebx
  8022a9:	89 fa                	mov    %edi,%edx
  8022ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022af:	89 34 24             	mov    %esi,(%esp)
  8022b2:	85 c0                	test   %eax,%eax
  8022b4:	75 1a                	jne    8022d0 <__umoddi3+0x48>
  8022b6:	39 f7                	cmp    %esi,%edi
  8022b8:	0f 86 a2 00 00 00    	jbe    802360 <__umoddi3+0xd8>
  8022be:	89 c8                	mov    %ecx,%eax
  8022c0:	89 f2                	mov    %esi,%edx
  8022c2:	f7 f7                	div    %edi
  8022c4:	89 d0                	mov    %edx,%eax
  8022c6:	31 d2                	xor    %edx,%edx
  8022c8:	83 c4 1c             	add    $0x1c,%esp
  8022cb:	5b                   	pop    %ebx
  8022cc:	5e                   	pop    %esi
  8022cd:	5f                   	pop    %edi
  8022ce:	5d                   	pop    %ebp
  8022cf:	c3                   	ret    
  8022d0:	39 f0                	cmp    %esi,%eax
  8022d2:	0f 87 ac 00 00 00    	ja     802384 <__umoddi3+0xfc>
  8022d8:	0f bd e8             	bsr    %eax,%ebp
  8022db:	83 f5 1f             	xor    $0x1f,%ebp
  8022de:	0f 84 ac 00 00 00    	je     802390 <__umoddi3+0x108>
  8022e4:	bf 20 00 00 00       	mov    $0x20,%edi
  8022e9:	29 ef                	sub    %ebp,%edi
  8022eb:	89 fe                	mov    %edi,%esi
  8022ed:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022f1:	89 e9                	mov    %ebp,%ecx
  8022f3:	d3 e0                	shl    %cl,%eax
  8022f5:	89 d7                	mov    %edx,%edi
  8022f7:	89 f1                	mov    %esi,%ecx
  8022f9:	d3 ef                	shr    %cl,%edi
  8022fb:	09 c7                	or     %eax,%edi
  8022fd:	89 e9                	mov    %ebp,%ecx
  8022ff:	d3 e2                	shl    %cl,%edx
  802301:	89 14 24             	mov    %edx,(%esp)
  802304:	89 d8                	mov    %ebx,%eax
  802306:	d3 e0                	shl    %cl,%eax
  802308:	89 c2                	mov    %eax,%edx
  80230a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80230e:	d3 e0                	shl    %cl,%eax
  802310:	89 44 24 04          	mov    %eax,0x4(%esp)
  802314:	8b 44 24 08          	mov    0x8(%esp),%eax
  802318:	89 f1                	mov    %esi,%ecx
  80231a:	d3 e8                	shr    %cl,%eax
  80231c:	09 d0                	or     %edx,%eax
  80231e:	d3 eb                	shr    %cl,%ebx
  802320:	89 da                	mov    %ebx,%edx
  802322:	f7 f7                	div    %edi
  802324:	89 d3                	mov    %edx,%ebx
  802326:	f7 24 24             	mull   (%esp)
  802329:	89 c6                	mov    %eax,%esi
  80232b:	89 d1                	mov    %edx,%ecx
  80232d:	39 d3                	cmp    %edx,%ebx
  80232f:	0f 82 87 00 00 00    	jb     8023bc <__umoddi3+0x134>
  802335:	0f 84 91 00 00 00    	je     8023cc <__umoddi3+0x144>
  80233b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80233f:	29 f2                	sub    %esi,%edx
  802341:	19 cb                	sbb    %ecx,%ebx
  802343:	89 d8                	mov    %ebx,%eax
  802345:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802349:	d3 e0                	shl    %cl,%eax
  80234b:	89 e9                	mov    %ebp,%ecx
  80234d:	d3 ea                	shr    %cl,%edx
  80234f:	09 d0                	or     %edx,%eax
  802351:	89 e9                	mov    %ebp,%ecx
  802353:	d3 eb                	shr    %cl,%ebx
  802355:	89 da                	mov    %ebx,%edx
  802357:	83 c4 1c             	add    $0x1c,%esp
  80235a:	5b                   	pop    %ebx
  80235b:	5e                   	pop    %esi
  80235c:	5f                   	pop    %edi
  80235d:	5d                   	pop    %ebp
  80235e:	c3                   	ret    
  80235f:	90                   	nop
  802360:	89 fd                	mov    %edi,%ebp
  802362:	85 ff                	test   %edi,%edi
  802364:	75 0b                	jne    802371 <__umoddi3+0xe9>
  802366:	b8 01 00 00 00       	mov    $0x1,%eax
  80236b:	31 d2                	xor    %edx,%edx
  80236d:	f7 f7                	div    %edi
  80236f:	89 c5                	mov    %eax,%ebp
  802371:	89 f0                	mov    %esi,%eax
  802373:	31 d2                	xor    %edx,%edx
  802375:	f7 f5                	div    %ebp
  802377:	89 c8                	mov    %ecx,%eax
  802379:	f7 f5                	div    %ebp
  80237b:	89 d0                	mov    %edx,%eax
  80237d:	e9 44 ff ff ff       	jmp    8022c6 <__umoddi3+0x3e>
  802382:	66 90                	xchg   %ax,%ax
  802384:	89 c8                	mov    %ecx,%eax
  802386:	89 f2                	mov    %esi,%edx
  802388:	83 c4 1c             	add    $0x1c,%esp
  80238b:	5b                   	pop    %ebx
  80238c:	5e                   	pop    %esi
  80238d:	5f                   	pop    %edi
  80238e:	5d                   	pop    %ebp
  80238f:	c3                   	ret    
  802390:	3b 04 24             	cmp    (%esp),%eax
  802393:	72 06                	jb     80239b <__umoddi3+0x113>
  802395:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802399:	77 0f                	ja     8023aa <__umoddi3+0x122>
  80239b:	89 f2                	mov    %esi,%edx
  80239d:	29 f9                	sub    %edi,%ecx
  80239f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023a3:	89 14 24             	mov    %edx,(%esp)
  8023a6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023aa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ae:	8b 14 24             	mov    (%esp),%edx
  8023b1:	83 c4 1c             	add    $0x1c,%esp
  8023b4:	5b                   	pop    %ebx
  8023b5:	5e                   	pop    %esi
  8023b6:	5f                   	pop    %edi
  8023b7:	5d                   	pop    %ebp
  8023b8:	c3                   	ret    
  8023b9:	8d 76 00             	lea    0x0(%esi),%esi
  8023bc:	2b 04 24             	sub    (%esp),%eax
  8023bf:	19 fa                	sbb    %edi,%edx
  8023c1:	89 d1                	mov    %edx,%ecx
  8023c3:	89 c6                	mov    %eax,%esi
  8023c5:	e9 71 ff ff ff       	jmp    80233b <__umoddi3+0xb3>
  8023ca:	66 90                	xchg   %ax,%ax
  8023cc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023d0:	72 ea                	jb     8023bc <__umoddi3+0x134>
  8023d2:	89 d9                	mov    %ebx,%ecx
  8023d4:	e9 62 ff ff ff       	jmp    80233b <__umoddi3+0xb3>
